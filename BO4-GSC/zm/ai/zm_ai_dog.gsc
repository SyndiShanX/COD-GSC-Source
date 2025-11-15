/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_dog.gsc
***********************************************/

#include scripts\core_common\ai\archetype_mocomps_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\ai\zm_ai_dog_interface;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_dog;

autoexec __init__system__() {
  system::register(#"zm_ai_dog", &__init__, undefined, undefined);
}

__init__() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"zombie_dog", &function_b9d56970);
}

function_b9d56970() {
  self.var_93a62fe = zm_utility::get_closest_valid_player(self.origin, undefined, 1);
  self.closest_player_override = &zm_utility::function_c52e1749;
  self.var_ef1ed308 = &function_ea61b64a;
}

registerbehaviorscriptfunctions() {
  spawner::add_archetype_spawn_function(#"zombie_dog", &archetypezombiedogblackboardinit);
  assert(isscriptfunctionptr(&zombiedogtargetservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogtargetservice", &zombiedogtargetservice, 1);
  assert(isscriptfunctionptr(&function_5e50d260));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29b43f0d0b6bd4e2", &function_5e50d260, 2);
  assert(isscriptfunctionptr(&zombiedogshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldmelee", &zombiedogshouldmelee);
  assert(isscriptfunctionptr(&zombiedogshouldwalk));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldwalk", &zombiedogshouldwalk);
  assert(isscriptfunctionptr(&zombiedogshouldrun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldrun", &zombiedogshouldrun);
  assert(!isDefined(&zombiedogmeleeaction) || isscriptfunctionptr(&zombiedogmeleeaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiedogmeleeactionterminate) || isscriptfunctionptr(&zombiedogmeleeactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
  zm_ai_dog_interface::registerzombiedoginterfaceattributes();
}

archetypezombiedogblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
  self.kill_on_wine_coccon = 1;
}

private archetypezombiedogonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombiedogblackboardinit();
}

bb_getshouldrunstatus() {
  if(isDefined(self.var_1dddf9ab)) {
    return self[[self.var_1dddf9ab]]();
  }

  if(isDefined(self.ispuppet) && self.ispuppet) {
    return "<dev string:x38>";
  }

    if(isDefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || ai::hasaiattribute(self, "sprint") && ai::getaiattribute(self, "sprint")) {
      return "run";
    }

  return "walk";
}

bb_getshouldhowlstatus() {
  if(self ai::has_behavior_attribute("howl_chance") && isDefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy) {
    if(!isDefined(self.shouldhowl)) {
      chance = self ai::get_behavior_attribute("howl_chance");
      self.shouldhowl = randomfloat(1) <= chance;
    }

    return (self.shouldhowl ? "howl" : "dont_howl");
  }

  return "dont_howl";
}

getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

absyawtoenemy() {
  assert(isDefined(self.enemy));
  yaw = self.angles[1] - getyaw(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

need_to_run() {
  run_dist_squared = self ai::get_behavior_attribute("min_run_dist") * self ai::get_behavior_attribute("min_run_dist");
  run_yaw = 20;
  run_pitch = 30;
  run_height = 64;

  if(level.dog_round_count > 1) {
    return true;
  }

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

is_target_valid(dog, target) {
  if(!isDefined(target)) {
    return 0;
  }

  if(!isalive(target)) {
    return 0;
  }

  if(!(dog.team == #"allies")) {
    if(!isplayer(target) && sessionmodeiszombiesgame()) {
      return 0;
    }

    if(isDefined(target.is_zombie) && target.is_zombie == 1) {
      return 0;
    }
  }

  if(isplayer(target) && target.sessionstate == "spectator") {
    return 0;
  }

  if(isplayer(target) && target.sessionstate == "intermission") {
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

  if(isplayer(target) && isDefined(level.var_6f6cc58)) {
    if(!dog[[level.var_6f6cc58]](target)) {
      return 0;
    }
  }

  if(isplayer(target) && isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](target);
  }

  return 1;
}

private get_favorite_enemy(dog) {
  dog_targets = [];

  if(sessionmodeiszombiesgame()) {
    if(self.team == #"allies") {
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

  least_hunted.hunted_by += 1;
  return least_hunted;
}

get_last_valid_position() {
  if(isplayer(self)) {
    return self.last_valid_position;
  }

  return self.origin;
}

get_locomotion_target(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.favoriteenemy)) {
    return undefined;
  }

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

zombiedogtargetservice(behaviortreeentity) {
  if(isDefined(level.intermission) && level.intermission) {
    behaviortreeentity clearpath();
    return;
  }

  if(isDefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
    return;
  }

    if(behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol")) {
      return;
    }

  if(!is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    if(isDefined(behaviortreeentity.favoriteenemy)) {
      function_ea61b64a(behaviortreeentity);
      behaviortreeentity.hasseenfavoriteenemy = 0;
    }

    behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
  }

  if(behaviortreeentity.ignoreall || behaviortreeentity.pacifist || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    if(is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
      if(isDefined(level.var_d22435d9)) {
        [
          [level.var_d22435d9]
        ](behaviortreeentity);
      }
    } else {
      if(isDefined(behaviortreeentity function_4794d6a3().overridegoalpos)) {
        behaviortreeentity function_d4c687c9();
      }

      if(isDefined(level.no_target_override)) {
        [
          [level.no_target_override]
        ](behaviortreeentity);
        return;
      }

      behaviortreeentity setgoal(behaviortreeentity.origin);
      return;
    }
  }

  if(!(isDefined(behaviortreeentity.hasseenfavoriteenemy) && behaviortreeentity.hasseenfavoriteenemy)) {
    if(isDefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run()) {
      behaviortreeentity.hasseenfavoriteenemy = 1;
    }
  }

  if(isDefined(behaviortreeentity.favoriteenemy)) {
    if(isDefined(level.enemy_location_override_func)) {
      goalpos = [
        [level.enemy_location_override_func]
      ](behaviortreeentity, behaviortreeentity.favoriteenemy);

      if(isDefined(goalpos)) {
        behaviortreeentity setgoal(goalpos);
        return;
      }
    }

    locomotion_target = get_locomotion_target(behaviortreeentity);

    if(isDefined(locomotion_target)) {
      repathdist = 16;

      if(!isDefined(behaviortreeentity.lasttargetposition) || distancesquared(behaviortreeentity.lasttargetposition, locomotion_target) > repathdist * repathdist || !behaviortreeentity haspath()) {
        behaviortreeentity function_a57c34b7(locomotion_target);
        behaviortreeentity.lasttargetposition = locomotion_target;
      }
    }
  }
}

zombiedogshouldmelee(behaviortreeentity) {
  if(behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    return false;
  }

  if(!(isDefined(level.intermission) && level.intermission)) {
    meleedist = 72;

    if(distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < meleedist * meleedist && behaviortreeentity cansee(behaviortreeentity.favoriteenemy)) {
      return true;
    }
  }

  return false;
}

zombiedogshouldwalk(behaviortreeentity) {
  return bb_getshouldrunstatus() == "walk";
}

zombiedogshouldrun(behaviortreeentity) {
  return bb_getshouldrunstatus() == "run";
}

use_low_attack() {
  if(!isDefined(self.enemy) || !isplayer(self.enemy)) {
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

zombiedogmeleeaction(behaviortreeentity, asmstatename) {
  behaviortreeentity clearpath();
  context = "high";

  if(behaviortreeentity use_low_attack()) {
    context = "low";
  }

  behaviortreeentity setblackboardattribute("_context", context);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombiedogmeleeactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity setblackboardattribute("_context", undefined);
  return 4;
}

zombiedoggravity(entity, attribute, oldvalue, value) {
  entity setblackboardattribute("_low_gravity", value);
}

function_5e50d260(dog) {
  if(!isDefined(dog.favoriteenemy) || !zm_utility::is_player_valid(dog.favoriteenemy)) {
    return;
  }

  if(!isDefined(dog.var_93a62fe) || dog.favoriteenemy == dog.var_93a62fe) {
    return;
  }

  if(!(isDefined(dog.var_2eda3fd0) && dog.var_2eda3fd0)) {
    dog.var_90957231 = dog zm_utility::approximate_path_dist(dog.favoriteenemy);
    dog.var_2eda3fd0 = 1;
    return;
  }

  new_target_dist = dog zm_utility::approximate_path_dist(dog.var_93a62fe);

  if(isDefined(dog.var_90957231)) {
    if(isDefined(new_target_dist) && dog.var_90957231 - new_target_dist > 200) {
      dog function_e856134(dog, dog.var_93a62fe);
    }
  } else if(isDefined(new_target_dist)) {
    dog function_e856134(dog, dog.var_93a62fe);
  }

  dog.var_2eda3fd0 = 0;
}

function_e856134(dog, new_target) {
  function_ea61b64a(dog);

  if(!isDefined(new_target.hunted_by)) {
    new_target.hunted_by = 0;
  }

  dog.favoriteenemy = new_target;
  dog.favoriteenemy.hunted_by++;
}

function_ea61b64a(dog) {
  if(isDefined(dog.favoriteenemy) && isDefined(dog.favoriteenemy.hunted_by) && dog.favoriteenemy.hunted_by > 0) {
    dog.favoriteenemy.hunted_by--;
  }

  dog.favoriteenemy = undefined;
}