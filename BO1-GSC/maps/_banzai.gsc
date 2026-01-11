/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_banzai.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  self call_overloaded_func("animscripts\banzai", "banzai_init_anims");
  PrecacheShellshock("banzai_impact");
  PrecacheString(&"SCRIPT_PLATFORM_BANZAI_HINT");
  PrecacheString(&"SCRIPT_PLATFORM_BANZAI_DEATH_DO_NOTHING");
  PrecacheString(&"SCRIPT_PLATFORM_BANZAI_DEATH_TOO_SOON");
  PrecacheString(&"SCRIPT_PLATFORM_BANZAI_DEATH_TOO_LATE");
  level._effects["stab_wound"] = loadfx("impacts/fx_flesh_bayonet_neck");
  level thread check_interactive_hands();
}

check_interactive_hands() {}
spawned_banzai_immediate() {
  if(spawn_failed(self)) {
    return;
  }
  banzai_force();
}

spawned_banzai_dynamic() {
  banzai();
}

banzai() {
  self call_overloaded_func("animscripts\banzai", "init");
  self endon("death");
  self endon("stop_banzai_thread");
  if(isDefined(self.target) && (!isDefined(self.banzai_no_wait) || (isDefined(self.banzai_no_wait) && !self.banzai_no_wait))) {
    self waittill("reached_path_end");
  }
  wait_time = 3 + RandomFloat(2);
  self thread banzai_print("Banzai wait: " + wait_time);
  wait(wait_time);
  self thread banzai_print("Getting nearby Banzai-ers");
  others = self get_nearby_banzai_guys();
  self banzai_pump_up();
  self thread staggered_banzai_charge();
  for(i = 0; i < others.size; i++) {
    if(isalive(others[i]) && isDefined(others[i])) {
      others[i] thread staggered_banzai_charge();
    }
  }
}

banzai_force() {
  self call_overloaded_func("animscripts\banzai", "init");
  self endon("death");
  self.banzai = true;
  self.inmeleecharge = true;
  if(isDefined(self.target) && (!isDefined(self.banzai_no_wait) || (isDefined(self.banzai_no_wait) && !self.banzai_no_wait))) {
    self waittill("reached_path_end");
  }
  self banzai_charge(true);
}

may_banzai_attack(enemy, maxAttackers) {
  assert(isDefined(enemy));
  if(enemy call_overloaded_func("animscripts\banzai", "in_banzai_melee") && distanceSquared(self.origin, enemy.origin) < 96 * 96) {
    return false;
  }
  if(isDefined(enemy.num_banzai_chargers) && enemy.num_banzai_chargers >= maxAttackers) {
    return false;
  }
  if(isDefined(enemy.no_banzai_attack) && enemy.no_banzai_attack) {
    return false;
  }
  if(isDefined(enemy.magic_bullet_shield) && enemy.magic_bullet_shield) {
    if(enemy.a.pose != "stand") {
      return false;
    }
  }
  if(IsPlayer(enemy)) {
    if(isDefined(enemy.usingturret) && enemy.usingturret) {
      return false;
    }
    if(isDefined(enemy.usingvehicle) && enemy.usingvehicle) {
      return false;
    }
    if(!check_player_can_see_me(enemy)) {
      return false;
    }
    if(enemy maps\_laststand::player_is_in_laststand()) {
      return false;
    }
    if(isDefined(self.primaryweapon) && self.primaryweapon == "type100_smg") {
      return false;
    }
  }
  return true;
}

should_switch_immediately(enemy) {
  if(!isDefined(enemy)) {
    return true;
  }
  if(!IsAlive(enemy)) {
    return true;
  }
  if(isDefined(enemy.no_banzai_attack) && enemy.no_banzai_attack) {
    return true;
  }
  if(isDefined(enemy.magic_bullet_shield) && enemy.magic_bullet_shield) {
    if(enemy.a.pose != "stand") {
      return true;
    }
  }
  if(IsPlayer(enemy)) {
    if(isDefined(enemy.usingTurret) && enemy.usingTurret) {
      return true;
    }
    if(isDefined(enemy.usingVehicle) && enemy.usingvehicle) {
      return true;
    }
    if(enemy maps\_laststand::player_is_in_laststand()) {
      return true;
    }
    if(distanceSquared(self.origin, enemy.origin) < 20736) {
      if(self.a.movement == "stop" && (self.origin[2] < (enemy.origin[2] - 24))) {
        return true;
      }
    }
  }
  return false;
}

find_enemy() {
  self endon("death");
  if(!isDefined(self.team)) {
    return undefined;
  }
  if(self.team == "axis") {
    opposite_team = "allies";
  } else {
    opposite_team = "axis";
  }
  maxDistance = 4000;
  if(isDefined(self.script_max_banzai_distance)) {
    maxDistance = self.script_max_banzai_distance;
  }
  clear_blocked_enemy_cache();
  if(!isDefined(self.script_player_chance)) {
    ais = GetAiArray(opposite_team);
    players = get_players();
    enemies = array_combine(players, ais);
    enemies = get_array_of_closest(self.origin, enemies, undefined, undefined, maxDistance);
    for(numAttackers = 1; numAttackers <= 2; numAttackers++) {
      for(i = 0; i < enemies.size; i++) {
        if(may_banzai_attack(enemies[i], numAttackers)) {
          return enemies[i];
        }
      }
    }
    players = get_array_of_closest(self.origin, players, undefined, undefined, maxDistance);
    for(i = 0; i < players.size; i++) {
      if(may_banzai_attack(players[i], numAttackers)) {
        return players[i];
      }
    }
    return undefined;
  }
  if(self.script_player_chance > 0) {
    enemies = get_players();
    enemies = get_array_of_closest(self.origin, enemies, undefined, undefined, maxDistance);
    for(i = 0; i < enemies.size; i++) {
      if(may_banzai_attack(enemies[i], 3)) {
        dieRoll = randomInt(100);
        if(dieRoll < self.script_player_chance) {
          return enemies[i];
        }
      }
    }
  }
  enemies = GetAiArray(opposite_team);
  enemies = get_array_of_closest(self.origin, enemies, undefined, undefined, maxDistance);
  for(i = 0; i < enemies.size; i++) {
    if(may_banzai_attack(enemies[i], 2)) {
      return enemies[i];
    }
  }
  return undefined;
}

check_player_can_see_me(player) {
  if(!isDefined(self.script_banzai_within_fov) || !self.script_banzai_within_fov) {
    return true;
  }
  return player_can_see_me(player);
}

player_can_see_me(player) {
  playerAngles = player getplayerangles();
  playerForwardVec = anglesToForward(playerAngles);
  playerUnitForwardVec = VectorNormalize(playerForwardVec);
  banzaiPos = self GetOrigin();
  playerPos = player GetOrigin();
  playerToBanzaiVec = banzaiPos - playerPos;
  playerToBanzaiUnitVec = VectorNormalize(playerToBanzaiVec);
  forwardDotBanzai = VectorDot(playerUnitForwardVec, playerToBanzaiUnitVec);
  angleFromCenter = ACos(forwardDotBanzai);
  playerFOV = GetDvarFloat(#"cg_fov");
  banzaiVsPlayerFOVBuffer = GetDvarFloat(#"g_banzai_player_fov_buffer");
  if(banzaiVsPlayerFOVBuffer <= 0) {
    banzaiVsPlayerFOVBuffer = 0.2;
  }
  playerCanSeeMe = (angleFromCenter <= (playerFOV * 0.5 * (1 - banzaiVsPlayerFOVBuffer)));
  return playerCanSeeMe;
}

get_nearby_banzai_guys() {
  guys = GetAiArray(self.team);
  banzai_guys = [];
  for(i = 0; i < guys.size; i++) {
    if(guys[i] == self) {
      continue;
    }
    if(IsAlive(guys[i]) && isDefined(guys[i].script_banzai) && guys[i].script_banzai) {
      if(distanceSquared(self.origin, guys[i].origin) < 512 * 512) {
        guys[i] notify("stop_banzai_thread");
        guys[i].script_banzai = 0;
        banzai_guys[banzai_guys.size] = guys[i];
      }
    }
  }
  return banzai_guys;
}

staggered_banzai_charge() {
  wait(RandomFloat(1.0));
  banzai_charge();
}

banzai_charge(spawned_charge) {
  self endon("death");
  if(!isDefined(spawned_charge)) {
    spawned_charge = false;
  }
  if(!spawned_charge) {
    self.banzai = true;
    self.inmeleecharge = true;
  }
  self.goalradius = 64;
  self thread start_banzai_announce();
  self.favoriteenemy = undefined;
  thread find_new_enemy_immediately();
  thread find_closer_enemy();
  thread find_new_enemy_if_blocked();
  wait(0.05);
  while(1) {
    if(isDefined(self.favoriteenemy)) {
      self SetGoalPos(self.favoriteenemy.origin);
    }
    wait(0.1);
  }
}

distance_to_enemy_less_than(lessThanThis) {
  assert(isDefined(self.favoriteenemy));
  return distanceSquared(self.origin, self.favoriteenemy.origin) < lessThanThis * lessThanThis;
}

find_new_enemy_immediately() {
  self endon("death");
  while(1) {
    if(!self call_overloaded_func("animscripts\banzai", "in_banzai_attack")) {
      enemy = self.favoriteenemy;
      if(should_switch_immediately(enemy)) {
        switch_enemies();
      }
    }
    wait(0.1);
  }
}

find_closer_enemy() {
  self endon("death");
  lastPos = undefined;
  while(1) {
    if(!self call_overloaded_func("animscripts\banzai", "in_banzai_attack")) {
      enemy = self.favoriteenemy;
      if(isDefined(enemy)) {
        if(!IsPlayer(enemy) && !distance_to_enemy_less_than(192)) {
          newEnemy = self find_enemy();
          if(isDefined(newEnemy) && newEnemy != enemy) {
            if(self CanSee(newEnemy)) {
              self notify("banzai_new_enemy");
              self.favoriteenemy.num_banzai_chargers--;
              banzai_set_enemy(newEnemy);
            }
          }
        }
      }
    }
    wait(0.05);
  }
}

find_new_enemy_if_blocked() {
  self endon("death");
  lastPos = undefined;
  while(1) {
    if(!self call_overloaded_func("animscripts\banzai", "in_banzai_attack")) {
      enemy = self.favoriteenemy;
      if(isDefined(enemy)) {
        currPos = self.origin;
        if(isDefined(lastPos) && distanceSquared(currPos, lastPos) < 64) {
          if(!findpath(currPos, enemy.origin)) {
            switch_enemies();
          } else {
            lastPos = currPos;
          }
        } else {
          lastPos = currPos;
        }
      }
    }
    wait(RandomFloatRange(0.25, 0.35));
  }
}

switch_enemies() {
  if(isDefined(self.favoriteenemy)) {
    self notify("banzai_new_enemy");
    self.favoriteenemy.num_banzai_chargers--;
  }
  enemy = keep_trying_find_enemy();
  banzai_set_enemy(enemy);
}

keep_trying_find_enemy() {
  while(1) {
    enemy = self find_enemy();
    if(isDefined(enemy) && (!isDefined(self.favoriteenemy) || enemy != self.favoriteenemy)) {
      return enemy;
    }
    wait(0.05);
  }
}

clear_blocked_enemy_cache() {
  self.blocked_enemies = [];
  self.blocked_enemy_flags = [];
}

banzai_set_enemy(enemy) {
  level thread banzai_death_thread(self, enemy);
  self.favoriteEnemy = enemy;
  self SetGoalPos(enemy.origin);
  if(!isDefined(enemy.num_banzai_chargers)) {
    enemy.num_banzai_chargers = 0;
  }
  enemy.num_banzai_chargers++;
}

draw_forward_line_until_notify(ent, r, g, b, notifyEnt, notifyString) {
  assert(isDefined(notifyEnt));
  assert(isDefined(notifyString));
  ent endon("death");
  notifyEnt endon("death");
  notifyEnt endon(notifyString);
  while(1) {
    forwardVec = VectorNormalize(anglesToForward(ent.angles));
    pointForward = ent.origin + forwardVec * 64;
    line(ent.origin, pointForward, (r, g, b), 0.05);
    wait .05;
  }
}

banzai_death_thread(attacker, enemy) {
  attacker endon("banzai_new_enemy");
  attacker waittill("death");
  if(isDefined(enemy)) {
    enemy.num_banzai_chargers--;
  }
}

start_banzai_announce() {
  self endon("death");
  self.battlechatter = false;
  if(!isDefined(self.banzai_announcing)) {
    self.banzai_announcing = true;
    self thread listen_for_end_of_banzai_announce();
    self banzai_dialogue("banzai_charge_announce", undefined, "banzai_announce_ended");
  }
}

listen_for_end_of_banzai_announce() {
  self endon("death");
  self waittill("banzai_announce_ended");
  self.banzai_announcing = false;
}

end_banzai_charge_yell() {
  self endon("banzai_new_enemy");
  self waittill("pain");
  self stopSounds();
}

banzai_pump_up() {
  facial_anim = undefined;
  soundalias = "banzai_pump";
  self banzai_dialogue(soundalias, facial_anim, "banzai_pump");
  self waittill("banzai_pump");
}

banzai_print(msg) {}
#using_animtree("generic_human");
banzai_dialogue(soundalias, facial_anim, notify_string) {
  self animscripts\face::SaySpecificDialogue(facial_anim, soundalias, 0.9, notify_string);
}