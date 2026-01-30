/******************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_comeback.gsc
******************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.killstreakWieldWeapons["killstreak_comeback_mp"] = "mp_comeback";

  level.killstreakFuncs["mp_comeback"] = ::tryUseKillstreak;

  level.mapKillStreak = "mp_comeback";
  level.mapKillstreakPickupString = &"MP_COMEBACK_MAP_KILLSTREAK_PICKUP";

  level.mapCustomBotKillstreakFunc = ::setupBotsForMapKillstreak;

  level.killstreak_tank_groups = [];
  level.killstreak_tanks = getEntArray("walker_tank", "targetname");
  array_thread(level.killstreak_tanks, ::init_tank);

  level.killstreak_tank_groups = array_randomize(level.killstreak_tank_groups);

  level.sky_nodes = [];
  allNodes = GetAllNodes();
  foreach(node in allNodes) {
    if(NodeExposedToSky(node, true)) {
      level.sky_nodes[level.sky_nodes.size] = node;
    }
  }

  level.missile_start_offset = 20;

  PrecacheMpAnim("mp_comeback_spider_tank_idle");
  PrecacheMpAnim("mp_comeback_spider_tank_fire");
}

setupBotsForMapKillstreak() {
  level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_comeback", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseKillstreak(lifeId, modules) {
  killstreak_group = undefined;
  foreach(group in level.killstreak_tank_groups) {
    isOlder = !isDefined(killstreak_group) || (group.last_run_time < killstreak_group.last_run_time);

    if(!group.active && isOlder) {
      killstreak_group = group;
    }
  }

  if(!isDefined(killstreak_group)) {
    IPrintLnBold(&"MP_COMEBACK_MAP_KILLSTREAK_NOT_AVAILABLE");
    return false;
  }

  killstreak_group thread group_run(self);

  return true;
}

init_tank() {
  self.start_origin = self.origin;
  self.start_angles = self.angles;

  self.objIds = [];
  teams = ["allies", "axis"];
  foreach(team in teams) {
    self.objIds[team] = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(self.objIds[team], "invisible", (0, 0, 0));
    objective_icon(self.objIds[team], ter_op(team == "allies", "compass_objpoint_tank_friendly", "compass_objpoint_tank_enemy"));
  }

  self.group = self.script_noteworthy;
  if(!isDefined(self.group)) {
    self.group = "default";
  }

  if(!isDefined(level.killstreak_tank_groups[self.group])) {
    level.killstreak_tank_groups[self.group] = init_new_tank_group();
  }

  group_tank_count = level.killstreak_tank_groups[self.group].tanks.size;
  level.killstreak_tank_groups[self.group].tanks[group_tank_count] = self;

  tank_idle(self);
}

init_new_tank_group() {
  group = spawnStruct();
  group.active = false;
  group.tanks = [];
  group.last_run_time = 0;
  return group;
}

group_run(owner) {
  self.active = true;
  self.owner_team = owner.team;
  self.owner = owner;

  self.last_run_time = GetTime();

  self.tank_count = self.tanks.size;
  foreach(tank in self.tanks) {
    self thread tank_run(tank);
  }

  self waittill("all_tanks_done");

  self.active = false;
}

tank_run(tank, owner) {
  tank_show_icon(tank);

  tank_attack(tank);

  tank_idle(tank);

  tank_end(tank);
}

tank_show_icon(tank) {
  foreach(team, objId in tank.objIds) {
    objective_state(objId, "active");
    if(team == "allies") {
      Objective_PlayerTeam(objId, self.owner GetEntityNumber());
    } else {
      Objective_PlayerEnemyTeam(objId, self.owner GetEntityNumber());
    }
    Objective_OnEntityWithRotation(objId, tank);
  }
}

tank_hide_icon(tank) {
  foreach(team, objId in tank.objIds) {
    objective_state(objId, "invisible");
  }
}

tank_idle(tank) {
  tank ScriptModelPlayAnimDeltaMotion("mp_comeback_spider_tank_idle");
}

tank_attack(tank) {
  self.owner endon("disconnect");
  tank endon("tank_destroyed");

  tank playSound("walker_start");
  tank ScriptModelPlayAnimDeltaMotion("mp_comeback_spider_tank_fire", "comeback_tank");

  right_count = 0;
  left_count = 0;

  while(1) {
    tank waittill("comeback_tank", notetrack);
    switch (notetrack) {
      case "fire_right":
        right_count++;
        tag = "tag_missile_" + right_count + "_r";
        self tank_fire_missile(tank, tag);
        break;
      case "fire_left":
        left_count++;
        tag = "tag_missile_" + left_count + "_l";
        self tank_fire_missile(tank, tag);
        break;
      case "end":
        return;
    }
  }
}

tank_fire_missile(tank, tag) {
  origin = tank GetTagOrigin(tag);
  tag_angles = tank GetTagAngles(tag);
  dir = anglesToForward(tag_angles);

  start = origin + (dir * level.missile_start_offset);
  end = start + dir;
  missile = MagicBullet("killstreak_comeback_mp", start, end, self.owner);
  self thread tank_missile_set_target(missile);
}

tank_missile_set_target(missile) {
  missile endon("death");

  wait RandomFloatRange(0.2, 0.4);

  target = undefined;

  find_target_time = RandomFloatRange(.5, 1.0);
  find_end_time = GetTime() + (find_target_time * 1000);

  other_team = getOtherTeam(self.owner_team);
  while(GetTime() < find_end_time && !isDefined(target)) {
    players = array_randomize(level.players);
    foreach(player in players) {
      if(player.team != other_team) {
        continue;
      }

      if(!isReallyAlive(player)) {
        continue;
      }

      if(isDefined(player.tank_no_target_time) && player.tank_no_target_time > GetTime()) {
        continue;
      }

      if(isDefined(player.spawnTime) && (player.spawnTime + 3000) > GetTime()) {
        continue;
      }

      if(SightTracePassed(missile.origin, player.origin + (0, 0, 40), false, missile, player, false)) {
        target = player;
        break;
      }
    }
    wait 0.05;
  }

  if(isDefined(target)) {
    target.tank_no_target_time = GetTime() + 3000;
    missile Missile_SetTargetEnt(target);
  } else {
    min_owner_dist = 250;
    min_owner_dist_sqr = min_owner_dist * min_owner_dist;
    random_node = random(level.sky_nodes);

    if(isDefined(self.owner)) {
      for(i = 0; i < 10 && DistanceSquared(random_node.origin, self.owner.origin) < min_owner_dist_sqr; i++) {
        random_node = random(level.sky_nodes);
      }
    }

    missile Missile_SetTargetPos(random_node.origin);
  }
}

tank_end(tank) {
  tank_hide_icon(tank);

  self.tank_count--;
  if(self.tank_count == 0) {
    self notify("all_tanks_done");
  }
}