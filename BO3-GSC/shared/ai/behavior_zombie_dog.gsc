/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\behavior_zombie_dog.gsc
*************************************************/

#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\archetype_zombie_dog_interface;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#namespace zombiedogbehavior;

function autoexec registerbehaviorscriptfunctions() {
  spawner::add_archetype_spawn_function("zombie_dog", &archetypezombiedogblackboardinit);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogTargetService", &zombiedogtargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldMelee", &zombiedogshouldmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldWalk", &zombiedogshouldwalk);
  behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldRun", &zombiedogshouldrun);
  behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
  animationstatenetwork::registernotetrackhandlerfunction("dog_melee", &zombiebehavior::zombienotetrackmeleefire);
  zombiedoginterface::registerzombiedoginterfaceattributes();
}

function archetypezombiedogblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_low_gravity", "normal", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_should_run", "walk", &bb_getshouldrunstatus);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_should_howl", "dont_howl", &bb_getshouldhowlstatus);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
  self.kill_on_wine_coccon = 1;
}

function private archetypezombiedogonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombiedogblackboardinit();
}

function bb_getshouldrunstatus() {
  if(isDefined(self.ispuppet) && self.ispuppet) {
    return "";
  }
  if(isDefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || (ai::hasaiattribute(self, "sprint") && ai::getaiattribute(self, "sprint"))) {
    return "run";
  }
  return "walk";
}

function bb_getshouldhowlstatus() {
  if(self ai::has_behavior_attribute("howl_chance") && (isDefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy)) {
    if(!isDefined(self.shouldhowl)) {
      chance = self ai::get_behavior_attribute("howl_chance");
      self.shouldhowl = randomfloat(1) <= chance;
    }
    if(self.shouldhowl) {
      return "howl";
    }
    return "dont_howl";
  }
  return "dont_howl";
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function absyawtoenemy() {
  assert(isDefined(self.enemy));
  yaw = self.angles[1] - getyaw(self.enemy.origin);
  yaw = angleclamp180(yaw);
  if(yaw < 0) {
    yaw = -1 * yaw;
  }
  return yaw;
}

function need_to_run() {
  run_dist_squared = self ai::get_behavior_attribute("min_run_dist") * self ai::get_behavior_attribute("min_run_dist");
  run_yaw = 20;
  run_pitch = 30;
  run_height = 64;
  if(self.health < self.maxhealth) {
    return true;
  }
  if(!isDefined(self.enemy) || !isalive(self.enemy)) {
    return false;
  }
  if(!self cansee(self.enemy)) {
    return false;
  }
  dist = distancesquared(self.origin, self.enemy.origin);
  if(dist > run_dist_squared) {
    return false;
  }
  height = self.origin[2] - self.enemy.origin[2];
  if(abs(height) > run_height) {
    return false;
  }
  yaw = self absyawtoenemy();
  if(yaw > run_yaw) {
    return false;
  }
  pitch = angleclamp180(vectortoangles(self.origin - self.enemy.origin)[0]);
  if(abs(pitch) > run_pitch) {
    return false;
  }
  return true;
}

function private is_target_valid(dog, target) {
  if(!isDefined(target)) {
    return 0;
  }
  if(!isalive(target)) {
    return 0;
  }
  if(!dog.team == "allies") {
    if(!isPlayer(target) && sessionmodeiszombiesgame()) {
      return 0;
    }
    if(isDefined(target.is_zombie) && target.is_zombie == 1) {
      return 0;
    }
  }
  if(isPlayer(target) && target.sessionstate == "spectator") {
    return 0;
  }
  if(isPlayer(target) && target.sessionstate == "intermission") {
    return 0;
  }
  if(isDefined(self.intermission) && self.intermission) {
    return 0;
  }
  if(isDefined(target.ignoreme) && target.ignoreme) {
    return 0;
  }
  if(target isnotarget()) {
    return 0;
  }
  if(dog.team == target.team) {
    return 0;
  }
  if(isPlayer(target) && isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](target);
  }
  return 1;
}

function private get_favorite_enemy(dog) {
  dog_targets = [];
  if(sessionmodeiszombiesgame()) {
    if(self.team == "allies") {
      dog_targets = getaiteamarray(level.zombie_team);
    } else {
      dog_targets = getplayers();
    }
  } else {
    dog_targets = arraycombine(getplayers(), getaiarray(), 0, 0);
  }
  least_hunted = dog_targets[0];
  closest_target_dist_squared = undefined;
  for(i = 0; i < dog_targets.size; i++) {
    if(!isDefined(dog_targets[i].hunted_by)) {
      dog_targets[i].hunted_by = 0;
    }
    if(!is_target_valid(dog, dog_targets[i])) {
      continue;
    }
    if(!is_target_valid(dog, least_hunted)) {
      least_hunted = dog_targets[i];
    }
    dist_squared = distancesquared(dog.origin, dog_targets[i].origin);
    if(dog_targets[i].hunted_by <= least_hunted.hunted_by && (!isDefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared)) {
      least_hunted = dog_targets[i];
      closest_target_dist_squared = dist_squared;
    }
  }
  if(!is_target_valid(dog, least_hunted)) {
    return undefined;
  }
  least_hunted.hunted_by = least_hunted.hunted_by + 1;
  return least_hunted;
}

function get_last_valid_position() {
  if(isPlayer(self)) {
    return self.last_valid_position;
  }
  return self.origin;
}

function get_locomotion_target(behaviortreeentity) {
  last_valid_position = behaviortreeentity.favoriteenemy get_last_valid_position();
  if(!isDefined(last_valid_position)) {
    return undefined;
  }
  locomotion_target = last_valid_position;
  if(ai::has_behavior_attribute("spacing_value")) {
    spacing_near_dist = ai::get_behavior_attribute("spacing_near_dist");
    spacing_far_dist = ai::get_behavior_attribute("spacing_far_dist");
    spacing_horz_dist = ai::get_behavior_attribute("spacing_horz_dist");
    spacing_value = ai::get_behavior_attribute("spacing_value");
    to_enemy = behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin;
    perp = vectornormalize((to_enemy[1] * -1, to_enemy[0], 0));
    offset = (perp * spacing_horz_dist) * spacing_value;
    spacing_dist = math::clamp(length(to_enemy), spacing_near_dist, spacing_far_dist);
    lerp_amount = math::clamp((spacing_dist - spacing_near_dist) / (spacing_far_dist - spacing_near_dist), 0, 1);
    desired_point = last_valid_position + (offset * lerp_amount);
    desired_point = getclosestpointonnavmesh(desired_point, spacing_horz_dist * 1.2, 16);
    if(isDefined(desired_point)) {
      locomotion_target = desired_point;
    }
  }
  return locomotion_target;
}

function zombiedogtargetservice(behaviortreeentity) {
  if(isDefined(level.intermission) && level.intermission) {
    behaviortreeentity clearpath();
    return;
  }
  if(isDefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
    return;
  }
  if(behaviortreeentity.ignoreall || behaviortreeentity.pacifist || (isDefined(behaviortreeentity.favoriteenemy) && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))) {
    if(isDefined(behaviortreeentity.favoriteenemy) && isDefined(behaviortreeentity.favoriteenemy.hunted_by) && behaviortreeentity.favoriteenemy.hunted_by > 0) {
      behaviortreeentity.favoriteenemy.hunted_by--;
    }
    behaviortreeentity.favoriteenemy = undefined;
    behaviortreeentity.hasseenfavoriteenemy = 0;
    if(!behaviortreeentity.ignoreall) {
      behaviortreeentity setgoal(behaviortreeentity.origin);
    }
    return;
  }
  if(isDefined(behaviortreeentity.ignoreme) && behaviortreeentity.ignoreme) {
    return;
  }
  if(!sessionmodeiszombiesgame() || behaviortreeentity.team == "allies" && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
  }
  if(!(isDefined(behaviortreeentity.hasseenfavoriteenemy) && behaviortreeentity.hasseenfavoriteenemy)) {
    if(isDefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run()) {
      behaviortreeentity.hasseenfavoriteenemy = 1;
    }
  }
  if(isDefined(behaviortreeentity.favoriteenemy)) {
    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.favoriteenemy);
      if(isDefined(goalpos)) {
        behaviortreeentity setgoal(goalpos);
        return;
      }
    }
    locomotion_target = get_locomotion_target(behaviortreeentity);
    if(isDefined(locomotion_target)) {
      repathdist = 16;
      if(!isDefined(behaviortreeentity.lasttargetposition) || distancesquared(behaviortreeentity.lasttargetposition, locomotion_target) > (repathdist * repathdist) || !behaviortreeentity haspath()) {
        behaviortreeentity useposition(locomotion_target);
        behaviortreeentity.lasttargetposition = locomotion_target;
      }
    }
  }
}

function zombiedogshouldmelee(behaviortreeentity) {
  if(behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    return false;
  }
  if(!(isDefined(level.intermission) && level.intermission)) {
    meleedist = 72;
    if(distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < (meleedist * meleedist) && behaviortreeentity cansee(behaviortreeentity.favoriteenemy)) {
      dog_eye = behaviortreeentity.origin + vectorscale((0, 0, 1), 40);
      enemy_eye = behaviortreeentity.favoriteenemy getEye();
      clip_mask = 1 | 8;
      trace = physicstrace(dog_eye, enemy_eye, (0, 0, 0), (0, 0, 0), self, clip_mask);
      can_melee = trace["fraction"] == 1 || (isDefined(trace["entity"]) && trace["entity"] == behaviortreeentity.favoriteenemy);
      if(isDefined(can_melee) && can_melee) {
        return true;
      }
    }
  }
  return false;
}

function zombiedogshouldwalk(behaviortreeentity) {
  return bb_getshouldrunstatus() == "walk";
}

function zombiedogshouldrun(behaviortreeentity) {
  return bb_getshouldrunstatus() == "run";
}

function use_low_attack() {
  if(!isDefined(self.enemy) || !isPlayer(self.enemy)) {
    return false;
  }
  height_diff = self.enemy.origin[2] - self.origin[2];
  low_enough = 30;
  if(height_diff < low_enough && self.enemy getstance() == "prone") {
    return true;
  }
  melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
  enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
  if(!bullettracepassed(melee_origin, enemy_origin, 0, self)) {
    return true;
  }
  return false;
}

function zombiedogmeleeaction(behaviortreeentity, asmstatename) {
  behaviortreeentity clearpath();
  context = "high";
  if(behaviortreeentity use_low_attack()) {
    context = "low";
  }
  blackboard::setblackboardattribute(behaviortreeentity, "_context", context);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function zombiedogmeleeactionterminate(behaviortreeentity, asmstatename) {
  blackboard::setblackboardattribute(behaviortreeentity, "_context", undefined);
  return 4;
}

function zombiedoggravity(entity, attribute, oldvalue, value) {
  blackboard::setblackboardattribute(entity, "_low_gravity", value);
}