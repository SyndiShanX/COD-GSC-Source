/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_riotshield.gsc
********************************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;

DEFAULT_GROUP_SPACING = 50;
DEFAULT_GOAL_RADIUS = 25;
RIOTSHIELD_PATH_ENEMY_DIST = 400;
init_riotshield() {
  if(isDefined(level.riotshield_initialized)) {
    return;
  }
  level.riotshield_initialized = true;

  if(is_specialop()) {
    quotes = [];
    quotes[quotes.size] = "@DEADQUOTE_RIOTSHIELD_USE_EXPLOSIVE";
    quotes[quotes.size] = "@DEADQUOTE_RIOTSHIELD_OUT_FLANK";
    quotes[quotes.size] = "@DEADQUOTE_RIOTSHIELD_DONT_CHARGE";
    maps\_specialops::so_include_deadquote_array(quotes);
  }

  if(!isDefined(level.subclass_spawn_functions)) {
    level.subclass_spawn_functions = [];
  }

  level.subclass_spawn_functions["riotshield"] = ::subclass_riotshield;

  animscripts\riotshield\riotshield::init_riotshield_AI_anims();
}

subclass_riotshield() {
  animscripts\riotshield\riotshield::init_riotshield_AI();
}

riotshield_sprint_on() {
  animscripts\riotshield\riotshield::riotshield_sprint_on();
}

riotshield_fastwalk_on() {
  animscripts\riotshield\riotshield::riotshield_fastwalk_on();
}

riotshield_sprint_off() {
  animscripts\riotshield\riotshield::riotshield_sprint_off();
}

riotshield_fastwalk_off() {
  animscripts\riotshield\riotshield::riotshield_fastwalk_off();
}

riotshield_flee() {
  assert(self.subclass == "riotshield");

  if(self.subclass != "riotshield") {
    return;
  }
  self.combatMode = "cover";
  self.goalradius = 2048;

  animscripts\riotshield\riotshield::riotshield_init_flee();

  node = self FindBestCoverNode();

  if(isDefined(node)) {
    self UseCoverNode(node);
  }
}

group_create(ai_array, forward, spacing) {
  newarray = [];
  foreach(member in ai_array) {
    if(member.combatMode != "no_cover") {
      continue;
    }
    newarray[newarray.size] = member;
  }
  group = spawnStruct();

  foreach(member in newarray) {
    if(isDefined(member.group) && isDefined(member.group.ai_array)) {
      member.group.ai_array = array_remove(member.group.ai_array, member);
    }
    member.group = group;
  }

  group.ai_array = newarray;
  group.fleeThreshold = 1;
  group.spacing = DEFAULT_GROUP_SPACING;

  group thread group_check_deaths();
  return group;
}

group_initialize_formation(forward, spacing) {
  assert(isDefined(self.ai_array));

  self.ai_array = array_removedead(self.ai_array);

  self.forward = forward;

  if(isDefined(spacing)) {
    self.spacing = spacing;
  }

  foreach(ai in self.ai_array) {
    ai.goalradius = DEFAULT_GOAL_RADIUS;
    ai.pathEnemyFightDist = 128;
    ai.pathEnemyLookahead = 128;
  }

  self group_sort_by_closest_match();

  self thread check_group_facing_forward();
}

group_resort_on_deaths() {
  assert(isDefined(self.ai_array));

  self endon("break_group");

  if(self.ai_array.size == 0) {
    return;
  }
  while(self.ai_array.size) {
    waittill_dead(self.ai_array, 1);

    if(self.group_move_mode != "stopped") {
      self waittill("goal");
    }

    self.ai_array = array_removedead(self.ai_array);
    self group_sort_by_closest_match();
  }
}

group_sort_by_closest_match(dir) {
  assert(isDefined(self.ai_array));

  if(self.ai_array.size == 0) {
    return;
  }
  if(isDefined(dir)) {
    self.forward = dir;
  } else {
    dir = self.forward;
  }

  center = group_center();
  right = (self.forward[1], -1 * self.forward[0], 0);
  offset = right * self.spacing;
  pos = self group_left_corner(center, offset);

  dist_array = [];
  for(i = 0; i < self.ai_array.size; i++) {
    if(isDefined(self.ai_array[i])) {
      dist_array[i] = vectordot(pos - self.ai_array[i].origin, right);
    } else {
      dist_array[i] = 0;
    }
  }

  for(i = 1; i < dist_array.size; i++) {
    curDist = dist_array[i];
    curAI = self.ai_array[i];

    for(j = i - 1; j >= 0; j--) {
      if(curDist < dist_array[j]) {
        break;
      }

      dist_array[j + 1] = dist_array[j];
      self.ai_array[j + 1] = self.ai_array[j];
    }

    dist_array[j + 1] = curDist;
    self.ai_array[j + 1] = curAI;
  }
}
group_check_deaths() {
  while(1) {
    if(self.fleeThreshold > 0) {
      self.ai_array = array_removedead(self.ai_array);

      if(self.ai_array.size <= self.fleeThreshold) {
        foreach(ai in self.ai_array) {
          ai riotshield_flee();
        }

        self notify("break_group");
        break;
      }
    }

    wait 1;
  }
}

group_left_corner(center, offset) {
  return center - ((self.ai_array.size - 1) / 2 * offset);
}

group_move(group_center, dir) {
  assert(isDefined(self.ai_array));
  assert(isDefined(self.forward));
  assert(isDefined(group_center));

  self notify("new_goal_set");
  self.group_move_mode = "moving";

  if(isDefined(dir)) {
    self.forward = dir;
  } else {
    dir = self.forward;
  }

  right = (dir[1], -1 * dir[0], 0);
  offset = right * self.spacing;
  pos = self group_left_corner(group_center, offset);

  for(i = 0; i < self.ai_array.size; i++) {
    ai = self.ai_array[i];

    if(isDefined(ai)) {
      ai setgoalpos(pos);
    }

    pos = pos + offset;
  }

  self thread check_group_at_goal();
}

MIN_AT_GOAL_RADIUS = 45;
check_group_at_goal() {
  self endon("new_goal_set");

  while(1) {
    wait 0.5;

    alive_count = 0;
    foreach(ai in self.ai_array) {
      if(isDefined(ai) && isalive(ai)) {
        alive_count++;
      }
    }

    at_goal_count = 0;
    for(i = 0; i < self.ai_array.size; i++) {
      ai = self.ai_array[i];

      if(isDefined(ai)) {
        check_radius = max(MIN_AT_GOAL_RADIUS, ai.goalradius);
        if(distanceSquared(ai.origin, ai.goalpos) < squared(check_radius)) {
          at_goal_count++;
        }
      }
    }

    if(at_goal_count == alive_count) {
      self notify("goal");
      self.group_move_mode = "stopped";
    }
  }
}

check_group_facing_forward() {
  self endon("break_group");

  while(1) {
    wait 0.5;

    alive_count = 0;
    foreach(ai in self.ai_array) {
      if(isDefined(ai) && isalive(ai)) {
        alive_count++;
      }
    }

    at_goal_count = 0;
    group_yaw = vectorToYaw(self.forward);

    for(i = 0; i < self.ai_array.size; i++) {
      ai = self.ai_array[i];

      if(isDefined(ai)) {
        if(abs(ai.angles[1] - group_yaw) < 45) {
          at_goal_count++;
        }
      }
    }

    if(at_goal_count == alive_count) {
      self notify("goal_yaw");
    }
  }
}

group_sprint_on() {
  foreach(ai in self.ai_array) {
    if(isalive(ai)) {
      ai riotshield_sprint_on();
    }
  }
}

group_fastwalk_on() {
  foreach(ai in self.ai_array) {
    if(isalive(ai)) {
      ai riotshield_fastwalk_on();
    }
  }
}

group_sprint_off() {
  foreach(ai in self.ai_array) {
    if(isalive(ai)) {
      ai riotshield_sprint_off();
    }
  }
}

group_fastwalk_off() {
  foreach(ai in self.ai_array) {
    if(isalive(ai)) {
      ai riotshield_fastwalk_off();
    }
  }
}

group_lock_angles(dir) {
  self.forward = dir;
  yaw = vectorToYaw(dir);

  foreach(ai in self.ai_array) {
    if(!isDefined(ai)) {
      continue;
    }
    if(isDefined(ai.enemy) && distanceSquared(ai.origin, ai.enemy.origin) < squared(ai.pathEnemyFightDist)) {
      continue;
    }
    ai orientmode("face angle", yaw);
    ai.lockOrientation = true;
  }

  wait 0.1;
}

group_unlock_angles() {
  foreach(ai in self.ai_array) {
    if(!isDefined(ai)) {
      continue;
    }
    ai orientmode("face default");
    ai.lockOrientation = false;
  }
}

group_free_combat() {
  self group_unlock_angles();

  foreach(ai in self.ai_array) {
    if(!isDefined(ai)) {
      continue;
    }
    ai.goalradius = 2048;
    ai.pathEnemyFightDist = RIOTSHIELD_PATH_ENEMY_DIST;
    ai.pathEnemyLookahead = RIOTSHIELD_PATH_ENEMY_DIST;
  }
}

group_center() {
  center = (0, 0, 0);
  alive_count = 0;
  foreach(ai in self.ai_array) {
    if(isDefined(ai)) {
      center = center + ai.origin;
      alive_count++;
    }
  }

  if(alive_count) {
    center = (1 / alive_count) * center;
  }

  return center;
}