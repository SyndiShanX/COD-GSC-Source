/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_455b9cb22d561924.gsc
***********************************************/

#using script_19de6a08d25644f4;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#namespace namespace_2be98cb7;

function autoexec init() {
  spawner::add_archetype_spawn_function(#"dog", &function_ef4b81af);
  registerbehaviorscriptfunctions();
  namespace_835228b4::function_7304e94b();
}

function private function_ef4b81af() {
  function_ae45f57b();
  self allowpitchangle(1);
  self setpitchorient();
  self setavoidancemask("avoid all");
  self collidewithactors(1);
  self ai::set_behavior_attribute("spacing_value", randomfloatrange(-1, 1));
  aiutility::addaioverridedamagecallback(self, &function_756cb98c);
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&dogtargetservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("dogTargetService", &dogtargetservice);
  assert(isscriptfunctionptr(&dogshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi("dogShouldMelee", &dogshouldmelee);
  assert(isscriptfunctionptr(&dogshouldwalk));
  behaviortreenetworkutility::registerbehaviortreescriptapi("dogShouldWalk", &dogshouldwalk);
  assert(isscriptfunctionptr(&dogshouldrun));
  behaviortreenetworkutility::registerbehaviortreescriptapi("dogShouldRun", &dogshouldrun);
  assert(!isDefined(&dogmeleeaction) || isscriptfunctionptr(&dogmeleeaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_303397b0) || isscriptfunctionptr(&function_303397b0));
  behaviortreenetworkutility::registerbehaviortreeaction("dogMeleeAction", &dogmeleeaction, undefined, &function_303397b0);
}

function function_cebd576f(entity) {
  entity melee();

  record3dtext("<dev string:x38>", self.origin, (1, 0, 0), "<dev string:x41>", entity);
}

function function_ae45f57b() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_cb274b5;
}

function private function_cb274b5(entity) {
  entity.__blackboard = undefined;
  entity function_ae45f57b();
}

function bb_getshouldrunstatus() {
  if(is_true(self.hasseenfavoriteenemy) || ai::getaiattribute(self, "chaseenemyonspawn")) {
    return "run";
  }

  return "walk";
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
  if(ai::getaiattribute(self, "chaseenemyonspawn")) {
    return true;
  }

  run_dist_squared = sqr(self ai::get_behavior_attribute("min_run_dist"));
  run_yaw = 20;
  run_pitch = 30;
  run_height = 64;

  if(self.health < self.maxhealth) {
    return true;
  }

  if(!isDefined(self.enemy) || !isalive(self.enemy)) {
    return false;
  }

  lastknownpostime = self lastknowntime(self.enemy);
  isfullyaware = gettime() - lastknownpostime < 20000;

  if(!self cansee(self.enemy) && !isfullyaware) {
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
    return false;
  }

  if(!isalive(target)) {
    return false;
  }

  if(isPlayer(target) && target.sessionstate == "spectator") {
    return false;
  }

  if(isPlayer(target) && target.sessionstate == "intermission") {
    return false;
  }

  if(is_true(self.intermission)) {
    return false;
  }

  if(is_true(target.ignoreme)) {
    return false;
  }

  if(target isnotarget()) {
    return false;
  }

  if(dog.team == target.team) {
    return false;
  }

  return true;
}

function private get_favorite_enemy(dog) {
  dog_targets = [];
  dog_targets = arraycombine(getplayers(), getaiarray(), 0, 0);
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

  least_hunted.hunted_by += 1;
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
    offset = perp * spacing_horz_dist * spacing_value;
    spacing_dist = math::clamp(length(to_enemy), spacing_near_dist, spacing_far_dist);
    lerp_amount = math::clamp((spacing_dist - spacing_near_dist) / (spacing_far_dist - spacing_near_dist), 0, 1);
    desired_point = last_valid_position + offset * lerp_amount;
    desired_point = getclosestpointonnavmesh(desired_point, spacing_horz_dist * 1.2, 16);

    if(isDefined(desired_point)) {
      locomotion_target = desired_point;
    }
  }

  return locomotion_target;
}

function dogtargetservice(behaviortreeentity) {
  if(behaviortreeentity.ignoreall || behaviortreeentity.pacifist || isDefined(behaviortreeentity.favoriteenemy) && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    if(isDefined(behaviortreeentity.favoriteenemy) && isDefined(behaviortreeentity.favoriteenemy.hunted_by) && behaviortreeentity.favoriteenemy.hunted_by > 0) {
      behaviortreeentity.favoriteenemy.hunted_by--;
    }

    behaviortreeentity.favoriteenemy = undefined;
    behaviortreeentity.hasseenfavoriteenemy = 0;

    if(!behaviortreeentity.ignoreall) {
      behaviortreeentity function_a57c34b7(behaviortreeentity.origin);
    }

    return;
  }

  if(!is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
  }

  if(!is_true(behaviortreeentity.hasseenfavoriteenemy)) {
    if(isDefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run()) {
      behaviortreeentity.hasseenfavoriteenemy = 1;
    }
  }

  if(isDefined(behaviortreeentity.favoriteenemy)) {
    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.favoriteenemy);

      if(isDefined(goalpos)) {
        behaviortreeentity function_a57c34b7(goalpos);
        return;
      }
    }

    locomotion_target = get_locomotion_target(behaviortreeentity);

    if(isDefined(locomotion_target)) {
      repathdist = 16;

      if(!isDefined(behaviortreeentity.lasttargetposition) || distancesquared(behaviortreeentity.lasttargetposition, locomotion_target) > sqr(repathdist) || !behaviortreeentity haspath()) {
        behaviortreeentity function_a57c34b7(locomotion_target);
        behaviortreeentity.lasttargetposition = locomotion_target;
      }
    }
  }
}

function dogshouldmelee(behaviortreeentity) {
  if(behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    return false;
  }

  if(!is_true(level.intermission)) {
    meleedist = 72;

    if(distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < sqr(meleedist) && behaviortreeentity cansee(behaviortreeentity.favoriteenemy)) {
      return true;
    }
  }

  return false;
}

function dogshouldwalk(behaviortreeentity) {
  return bb_getshouldrunstatus() == "walk";
}

function dogshouldrun(behaviortreeentity) {
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

function dogmeleeaction(behaviortreeentity, asmstatename) {
  behaviortreeentity clearpath();
  context = "high";

  if(behaviortreeentity use_low_attack()) {
    context = "low";
  }

  behaviortreeentity setblackboardattribute("_context", context);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_303397b0(behaviortreeentity, asmstatename) {
  asmstatename setblackboardattribute("_context", undefined);
  return 4;
}

function private function_756cb98c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(isDefined(psoffsettime) && isactor(psoffsettime) && (modelindex === "MOD_RIFLE_BULLET" || modelindex == "MOD_PISTOL_BULLET" || modelindex == "MOD_HEAD_SHOT")) {
    level.var_d7e2833c = 1;
    boneindex *= 3;
  }

  return boneindex;
}