/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_stoker.gsc
***********************************************/

#include script_24c32478acf44108;
#include script_2c5daa95f8fec03c;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\archetype_mocomps_utility;
#include scripts\core_common\ai\archetype_stoker;
#include scripts\core_common\ai\archetype_stoker_interface;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\debug;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\burnplayer;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\powerup\zm_powerup_nuke;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\trials\zm_trial_close_quarters;
#include scripts\zm_common\trials\zm_trial_special_enemy;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_stoker;

class class_264486ac {
  var active;
  var health;
  var hitloc;
  var hittag;

  constructor() {
    active = 1;
    health = 0;
    hitloc = "";
    hittag = "";
    var_934afb38 = 0;
  }

}

autoexec __init__system__() {
  system::register(#"zm_ai_stoker", &__init__, &__main__, undefined);
}

__init__() {
  level.var_b48fed60 = 0;
  zm_player::register_player_damage_callback(&function_6da30402);
  registerbehaviorscriptfunctions();
  init();

  execdevgui("<dev string:x38>");
  level thread function_a92dac75();

    spawner::add_archetype_spawn_function(#"stoker", &function_580b77a2);
  zm_utility::function_d0f02e71(#"stoker");

  spawner::add_archetype_spawn_function(#"stoker", &zombie_utility::updateanimationrate);

    animationstatenetwork::registernotetrackhandlerfunction("coals_fire", &function_b2602782);
  animationstatenetwork::registernotetrackhandlerfunction("stoker_death_gib", &function_eb4e0ec3);
  animationstatenetwork::registernotetrackhandlerfunction("coal_charge_stop", &function_717a6538);

  if(ai::shouldregisterclientfieldforarchetype(#"stoker")) {
    clientfield::register("actor", "crit_spot_reveal_clientfield", 1, getminbitcountfornum(4), "int");
    clientfield::register("actor", "stoker_fx_start_clientfield", 1, 3, "int");
    clientfield::register("actor", "stoker_fx_stop_clientfield", 1, 3, "int");
    clientfield::register("actor", "stoker_death_explosion", 1, 2, "int");
  }

  function_983f7ff1();
  zm::register_actor_damage_callback(&function_fa8be26d);
  zm_spawner::register_zombie_death_event_callback(&killed_callback);
  zm_trial_special_enemy::function_95c1dd81(#"stoker", &function_f5f699aa);
  namespace_9ff9f642::register_slowdown("stoker_undewater_slow_type", 0.8);
  zm_round_spawning::register_archetype(#"stoker", &function_b381320, &round_spawn, undefined, 100);
  zm_round_spawning::function_306ce518(#"stoker", &function_cf5ef033);
  zm_cleanup::function_cdf5a512(#"stoker", &function_3049b317);
}

__main__() {}

init() {
  level.a_sp_stoker = [];
  level thread aat::register_immunity("zm_aat_brain_decay", #"stoker", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_frostbite", #"stoker", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_kill_o_watt", #"stoker", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_plasmatic_burst", #"stoker", 1, 1, 1);
  function_2170ee7a();
}

registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_253c9e38));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_11342039e49bb092", &function_253c9e38);
  assert(isscriptfunctionptr(&function_6d817d57));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_64bb85f17c6f0c26", &function_6d817d57);
  assert(isscriptfunctionptr(&function_31f887b5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7abf56a70eea8824", &function_31f887b5);
  assert(isscriptfunctionptr(&function_6cd91a4d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7914389e526099c3", &function_6cd91a4d);
  assert(isscriptfunctionptr(&function_d47e273b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_69d99c802f94a161", &function_d47e273b);
  assert(isscriptfunctionptr(&function_65d23c4f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34979234c577e020", &function_65d23c4f);
  assert(isscriptfunctionptr(&function_fb220c8c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2eda816d46284ecf", &function_fb220c8c);
  assert(isscriptfunctionptr(&function_53d1998d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62e8ff16b0eb8a2e", &function_53d1998d);
  assert(isscriptfunctionptr(&function_765f06f9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_e3d43dd957e7586", &function_765f06f9);
  assert(isscriptfunctionptr(&function_60951874));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d05a32b52fcaafd", &function_60951874);
  assert(isscriptfunctionptr(&function_8ef6771f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed50d08e0e9bcfa", &function_8ef6771f);
  assert(isscriptfunctionptr(&function_e2e5eebf));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ce6baf23499b6f", &function_e2e5eebf);
  assert(isscriptfunctionptr(&function_7cd52d88));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3993bf34ab2531f0", &function_7cd52d88);
  assert(isscriptfunctionptr(&function_a2d1d120));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_25c4de2eb81f27cb", &function_a2d1d120);
  assert(isscriptfunctionptr(&function_b7fe306e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_389c07d3893e660", &function_b7fe306e);
  assert(isscriptfunctionptr(&function_36903815));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1607f20e814fb19b", &function_36903815);
  assert(isscriptfunctionptr(&function_f01e64d6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_173e1c9378200965", &function_f01e64d6);
  assert(isscriptfunctionptr(&function_dee90338));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e875851311be4e8", &function_dee90338);
  assert(isscriptfunctionptr(&function_b6e7676d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4fe0c56f8cd42ad1", &function_b6e7676d);
  assert(isscriptfunctionptr(&function_20a3d8f6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21f1387075571547", &function_20a3d8f6);
  assert(isscriptfunctionptr(&function_efbd6650));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_771bfe8686d806d6", &function_efbd6650);
  assert(isscriptfunctionptr(&function_399815b2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_138db5b46aeab153", &function_399815b2);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_b4ecc051) || isscriptfunctionptr(&function_b4ecc051));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4778faf1d75cc885", undefined, &function_b4ecc051, undefined);
}

private function_983f7ff1() {
  level.stokerdebug = 0;
  level.var_fb6dfb50 = 0;
}

function_580b77a2() {
  zm_score::function_e5d6e6dd(#"stoker", self ai::function_9139c839().stokerscore);
  aiutility::addaioverridedamagecallback(self, &function_a96d8bd7);
  self attach("c_t8_zmb_titanic_stoker_larm1");
  self attach("c_t8_zmb_titanic_stoker_lshoulder_cap1");
  self attach("c_t8_zmb_titanic_stoker_rshoulder_cap1");
  self attach("c_t8_zmb_titanic_stoker_head_cap1");
  self attach("c_t8_zmb_titanic_stoker_shovel1", "tag_weapon_right");
  self.armorinfo = [];
  self.armorinfo[#"left_arm_upper"] = new class_264486ac();
  self.armorinfo[#"left_arm_upper"].shadervector = 4;
  self.armorinfo[#"left_arm_upper"].fxindex = 3;
  self.armorinfo[#"right_arm_upper"] = new class_264486ac();
  self.armorinfo[#"right_arm_upper"].shadervector = 1;
  self.armorinfo[#"right_arm_upper"].fxindex = 4;
  self.armorinfo[#"head"] = new class_264486ac();
  self.armorinfo[#"head"].shadervector = 3;
  self.armorinfo[#"head"].fxindex = 5;
  self.armorinfo[#"left_arm_lower"] = new class_264486ac();
  self.armorinfo[#"left_arm_lower"].var_6d7b8c32 = 1;
  self.armorinfo[#"left_arm_lower"].var_a222368f = "j_wrist_le";
  self.armorinfo[#"left_arm_lower"].fxindex = 6;
  self.var_19f48bbe = [];
  self.var_19f48bbe[0] = "left_arm_upper";
  self.var_19f48bbe[1] = "right_arm_upper";
  self.var_19f48bbe[2] = "head";

  if(!isDefined(level.var_a64fa07c)) {
    level.var_a64fa07c = 0;
  }

  self.var_a056e24 = self.var_19f48bbe[level.var_a64fa07c];
  level.var_a64fa07c = (level.var_a64fa07c + 1) % self.var_19f48bbe.size;
  self.var_dc32e381 = 0;
  self.var_81d3587d = 0;
  self.var_ce5d8e8f = "locomotion_speed_run";

  if(level.var_fb6dfb50) {
    self.var_ce5d8e8f = "locomotion_speed_walk";
  }

  self setblackboardattribute("_locomotion_speed", self.var_ce5d8e8f);
  self.lastattacktime = gettime() + self ai::function_9139c839().var_1d505f4d - getdvarint(#"hash_3dfb66f92268c90f", self ai::function_9139c839().var_d33d95d0);
  self.var_41f51cb4 = "stoker_charge_attack";
  self.var_5274eb5f = 0;
  self.var_86f9cdcd = 0;
  self.var_aca87abc = 0;
  self.var_d691409c = 0;
  self.var_ccb2e201 = 0;
  self.var_1db5ef71 = 0;
  self.should_zigzag = 0;
  self.instakill_func = &zm_powerups::function_16c2586a;
  self.var_f46fbf3f = 1;
  self.actor_killed_override = &function_cf402986;
  self.closest_player_override = &zm_utility::function_c52e1749;
  self.var_80cf70fb = &function_e4ef4e27;
  self.cant_move_cb = &zombiebehavior::function_79fe956f;
  self zm_powerup_nuke::function_9a79647b(0.5);
  self thread zm_audio::play_ambient_zombie_vocals();
  target_set(self);
  level.var_b48fed60++;
}

function_2df052bb() {
  self.maxhealth = int(self zm_ai_utility::function_8d44707e(1, self._starting_round_number) * (isDefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1));
  self.health = self.maxhealth;
  namespace_81245006::initweakpoints(self, #"c_t8_zmb_stoker_weakpoint_def");
}

function_3049b317() {
  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return true;
  }

  if(isDefined(level.var_370b1a3d)) {
    s_spawn_loc = [[level.var_370b1a3d]]();
  } else if(level.zm_loc_types[#"stoker_location"].size > 0) {
    s_spawn_loc = array::random(level.zm_loc_types[#"stoker_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    return true;
  }

  self zm_ai_utility::function_a8dc3363(s_spawn_loc);

  if(isalive(self)) {
    self playSound(#"hash_63299a75a97f9678");
    bhtnactionstartevent(self, "spawn");
  }

  return true;
}

private function_eb4e0ec3(entity) {
  entity setModel("c_t8_zmb_titanic_stoker_body1_gibbed");
  entity clientfield::set("stoker_death_explosion", 2);
}

private function_cf402986(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self clientfield::set("stoker_fx_start_clientfield", 1);
  destructserverutils::destructnumberrandompieces(self);
  self clientfield::set("stoker_death_explosion", 1);
}

private function_e4ef4e27(entity, attribute, oldvalue, value) {
  if(value == "low") {
    entity thread namespace_9ff9f642::slowdown("stoker_undewater_slow_type");
    return;
  }

  entity thread namespace_9ff9f642::function_520f4da5("stoker_undewater_slow_type");
}

function_a96d8bd7(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(self.archetype != #"stoker") {
    return;
  }

  if(eattacker.archetype === #"stoker") {
    return 0;
  }

  if(zm_trial_close_quarters::is_active() && !self zm_trial_close_quarters::function_23d15bf3(eattacker)) {
    return 0;
  }

  var_dd54fdb1 = namespace_81245006::function_3131f5dd(self, shitloc, 1);

  if(!isDefined(var_dd54fdb1)) {
    var_dd54fdb1 = namespace_81245006::function_73ab4754(self, vpoint, 1);
  }

  var_786d7e06 = zm_ai_utility::function_422fdfd4(self, eattacker, sweapon, boneindex, shitloc, vpoint, var_dd54fdb1);
  damagedone = int(max(1, idamage * var_786d7e06.damage_scale));
  var_fe16adf4 = 0;
  var_88e794fb = 0;
  var_ae30c5b0 = 0;

  if(zm_loadout::is_hero_weapon(sweapon)) {
    var_ae30c5b0 = 1;

    if(!isDefined(self.var_5dc26e42) || self.var_5dc26e42 >= 1000) {
      self.var_5dc26e42 = 0;
    }

    self.var_5dc26e42 += damagedone;
  }

  if(smeansofdeath != "MOD_PROJECTILE_SPLASH") {
    if(!var_ae30c5b0) {
      var_dd54fdb1 = var_786d7e06.var_84ed9a13;
      var_88e794fb = var_786d7e06.registerzombie_bgb_used_reinforce;
    } else {
      weakpoints = namespace_81245006::function_fab3ee3e(self);

      if(isDefined(weakpoints)) {
        foreach(pointinfo in weakpoints) {
          if(namespace_81245006::function_f29756fe(pointinfo) === 1 && pointinfo.type === #"armor" && pointinfo.hitloc !== "left_arm_lower") {
            var_dd54fdb1 = pointinfo;
            var_88e794fb = 1;
            break;
          }
        }
      }
    }

    if(isDefined(var_dd54fdb1)) {
      if(var_dd54fdb1.type == #"armor") {
        if(isDefined(var_88e794fb) && var_88e794fb) {
          if(isDefined(var_dd54fdb1.hitloc)) {
            armorinfo = self.armorinfo[var_dd54fdb1.hitloc];
          }

          if(isDefined(armorinfo)) {
            self clientfield::set("stoker_fx_start_clientfield", armorinfo.fxindex);
          }

          namespace_81245006::damageweakpoint(var_dd54fdb1, damagedone);
          var_fe16adf4 = 1;
          bhtnactionstartevent(self, "pain");

          if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3 || var_ae30c5b0 && self.var_5dc26e42 >= 1000) {
            if(var_dd54fdb1.var_641ce20e) {
              namespace_81245006::function_6742b846(self, var_dd54fdb1);
            }

            if(isDefined(armorinfo.var_6d7b8c32) && armorinfo.var_6d7b8c32) {
              self.var_81d3587d = 1;
              self.var_86f9cdcd = 1;
            }

            if(isDefined(armorinfo.var_a222368f)) {
              physicsexplosionsphere(self gettagorigin(armorinfo.var_a222368f), 600, 0, 80, 1, 1);
              self.var_ccb2e201 = 1;
            }

            self destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, var_dd54fdb1.hitloc, psoffsettime, boneindex, modelindex);

            if(var_dd54fdb1.hitloc === self.var_a056e24) {
              if(isDefined(armorinfo.shadervector)) {
                self clientfield::set("crit_spot_reveal_clientfield", armorinfo.shadervector);
              }

              var_add9b529 = namespace_81245006::function_3131f5dd(self, self.var_a056e24);

              if(isDefined(var_add9b529)) {
                namespace_81245006::function_6c64ebd3(var_add9b529, 1);
              }
            }
          }
        }
      } else if(var_dd54fdb1.hitloc === self.var_a056e24) {
        if(self.var_5274eb5f) {
          self.var_dc32e381 += damagedone;
        }

        if(damagedone >= self.health) {
          self.var_6f3ba226 = 1;
          self notify(#"hash_4651621237a54fc7");
        }
      }
    }
  }

  if(var_fe16adf4 && !var_ae30c5b0) {
    damagedone = 1;
  }

  function_752a64b8("<dev string:x58>" + damagedone + "<dev string:x67>" + self.health);

    return damagedone;
}

private function_1bf5272c(hitloc, point, location, var_934afb38, tag) {
  var_99f08950 = 0;

  if(isDefined(hitloc) && hitloc != "none" && hitloc == location) {
    var_99f08950 = 1;
  } else {
    distsq = distancesquared(point, self gettagorigin(tag));

    if(distsq <= var_934afb38) {
      var_99f08950 = 1;
    }
  }

  return var_99f08950;
}

private function_c9116e0f(armorinfo, damage) {

  function_752a64b8("<dev string:x58>" + damage + "<dev string:x89>" + armorinfo.position);

    armorinfo.health -= damage;

  if(armorinfo.health <= 0) {
    armorinfo.active = 0;
  }
}

private function_31f887b5(behaviortreeentity) {
  if(behaviortreeentity getblackboardattribute("_locomotion_speed") === "locomotion_speed_sprint" || behaviortreeentity.var_ccb2e201) {
    var_bd66486b = "knockdown";
  } else {
    var_bd66486b = "push";
  }

  var_92cf09df = behaviortreeentity ai::function_9139c839().var_a22e6e32;

  if(behaviortreeentity.var_ccb2e201) {
    var_92cf09df = behaviortreeentity ai::function_9139c839().var_159f74bb;
  }

  velocity = behaviortreeentity getvelocity();
  velocitymag = length(velocity);
  predicttime = 0.2;
  movevector = velocity * predicttime;
  predictedpos = behaviortreeentity.origin + movevector;
  zombiesarray = getaiarchetypearray(#"zombie");
  zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"catalyst"), 0, 0);
  var_86476d47 = array::filter(zombiesarray, 0, &namespace_9ff9f642::function_865a83f8, behaviortreeentity, predictedpos, var_92cf09df);

  if(var_86476d47.size > 0) {
    foreach(zombie in var_86476d47) {
      if(var_bd66486b == "knockdown") {
        zombie zombie_utility::setup_zombie_knockdown(behaviortreeentity);
        zombie.knockdown_type = "knockdown_shoved";
        continue;
      }

      zombie zombie_utility::function_fc0cb93d(behaviortreeentity);
    }
  }

  behaviortreeentity.var_ccb2e201 = 0;
}

private function_6cd91a4d(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(entity.var_1db5ef71 > gettime()) {
    return false;
  }

  meleedistsq = 4096;

  if(isDefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
    meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
  }

  var_e9677328 = distancesquared(entity.origin, entity.enemy.origin);

  if(var_e9677328 <= meleedistsq) {
    return false;
  }

  if(var_e9677328 > entity ai::function_9139c839().var_b7a8163d * entity ai::function_9139c839().var_b7a8163d) {
    return false;
  }

  return true;
}

private function_d4e03577(distance) {
  if(isDefined(self.enemy)) {
    return (distancesquared(self.origin, self.enemy.origin) > distance * distance);
  }

  return false;
}

private function_d47e273b(entity) {
  return entity.var_86f9cdcd;
}

private function_65d23c4f(entity) {

  if(entity.var_907e6060) {
    function_752a64b8("<dev string:x9c>");
  }

    return entity.var_907e6060;
}

private function_fb220c8c(entity) {
  return entity.var_aca87abc && function_ac53cb4e(entity);
}

private function_53d1998d(entity) {
  return !entity.var_907e6060 && entity.var_aca87abc && function_ac53cb4e(entity);
}

private function_765f06f9(entity) {
  return entity.var_aca87abc && function_ac53cb4e(entity);
}

private function_7cd52d88(entity) {

  function_752a64b8("<dev string:xc3>");

}

private function_b7fe306e(entity) {

  function_752a64b8("<dev string:xe6>");

    entity.var_86f9cdcd = 0;
  stokerchargeattack(entity);
}

private function_f01e64d6(entity) {

  function_752a64b8("<dev string:x124>");

}

private function_36903815(entity) {

  function_752a64b8("<dev string:x13f>");

    entity clientfield::set("stoker_fx_start_clientfield", 7);
}

private function_aae7916a(entity) {
  if(zm_behavior::zombieshouldstun(entity)) {
    return true;
  }

  if(zm_behavior::zombieshouldknockdown(entity)) {
    return true;
  }

  return false;
}

private function_dee90338(entity) {

  function_752a64b8("<dev string:x160>");

}

private function_b6e7676d(entity) {

  function_752a64b8("<dev string:x181>");

    entity.var_aca87abc = 0;

  if(function_aae7916a(entity)) {
    entity clientfield::set("stoker_fx_stop_clientfield", 7);
  }
}

private function_20a3d8f6(entity) {

  function_752a64b8("<dev string:x19b>");

    entity.var_907e6060 = 0;

  if(function_aae7916a(entity)) {
    entity clientfield::set("stoker_fx_stop_clientfield", 7);
  }
}

private function_efbd6650(entity) {
  entity.cp_level_blackstation_goto_centerbreadcrumb = 1;
}

private function_399815b2(entity) {
  entity.cp_level_blackstation_goto_centerbreadcrumb = undefined;
}

private function_60951874(entity) {
  if(self.var_dc32e381 >= entity ai::function_9139c839().var_20dea374) {

    function_752a64b8("<dev string:x1bb>");

      return true;
  }

  return false;
}

private function_b4ecc051(entity, asmstatename) {
  if(entity ai::is_stunned()) {
    return 5;
  }

  return 4;
}

private function_a2d1d120(entity) {

  function_752a64b8("<dev string:x1f1>");

    function_394c6870(entity);
}

private function_394c6870(entity) {
  entity.var_5274eb5f = 0;
  entity.var_86f9cdcd = 0;
  entity.var_dc32e381 = 0;
  entity setblackboardattribute("_locomotion_speed", self.var_ce5d8e8f);
  entity clientfield::set("stoker_fx_stop_clientfield", 2);
}

private stokerchargeattack(entity) {
  entity.var_5274eb5f = 1;

  if(entity.var_d691409c) {
    entity.var_d691409c = 0;
  } else {
    entity.var_41f51cb4 = "stoker_charge_attack";
  }

  entity.lastattacktime = gettime();
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  entity clientfield::set("stoker_fx_start_clientfield", 2);
}

private stokerrangedattack(entity) {
  entity.var_907e6060 = 1;
  entity.var_aca87abc = 1;
  self.var_41f51cb4 = "stoker_ranged_attack";
  entity.lastattacktime = gettime();
}

private function_5878b360(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  return distancesquared(entity.origin, entity.enemy.origin) <= entity ai::function_9139c839().var_2512cf3b * entity ai::function_9139c839().var_2512cf3b;
}

private function_ac53cb4e(entity) {
  if(!isDefined(entity.enemy)) {
    return 0;
  }

  can_see = bullettracepassed(entity.origin + (0, 0, 36), entity.enemy.origin + (0, 0, 36), 0, undefined);
  return can_see;
}

private function_6d817d57(entity) {
  if(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) {
    return true;
  }

  return zm_behavior::zombieenteredplayable(entity);
}

private function_253c9e38(entity) {
  timeelapsed = gettime() - entity.lastattacktime;

  if(entity.var_5274eb5f && timeelapsed > entity ai::function_9139c839().var_287805eb) {

    function_752a64b8("<dev string:x209>");

      function_394c6870(entity);
  }

  if(entity.var_d691409c) {

    function_752a64b8("<dev string:x23d>");

      entity.var_86f9cdcd = 1;
    return;
  }

  if(timeelapsed > getdvarint(#"hash_3dfb66f92268c90f", entity ai::function_9139c839().var_d33d95d0)) {
    if(timeelapsed > entity ai::function_9139c839().var_73070557 && entity.var_41f51cb4 == "stoker_ranged_attack" && isDefined(entity.var_c6e0686b) && entity.var_c6e0686b <= entity ai::function_9139c839().var_20266c0d * entity ai::function_9139c839().var_20266c0d) {
      entity.var_86f9cdcd = 1;
      return;
    }

    if(!entity.var_aca87abc && !entity.var_86f9cdcd && isDefined(entity getblackboardattribute("_locomotion_speed")) && entity getblackboardattribute("_locomotion_speed") != "locomotion_speed_sprint" && function_ac53cb4e(entity) && !entity.var_81d3587d && function_5878b360(entity)) {

      function_752a64b8("<dev string:x28f>");

        stokerrangedattack(entity);
    }
  }
}

function_b2602782(entity) {
  if(!isactor(entity) || !isDefined(entity.enemy)) {
    return;
  }

  targetpos = entity.enemy.origin;
  launchpos = entity gettagorigin("j_wrist_le");
  var_ad804014 = entity ai::function_9139c839().var_accd767d;

  if(distancesquared(targetpos, entity.origin) > entity ai::function_9139c839().var_bf28a226 * entity ai::function_9139c839().var_bf28a226) {
    velocity = entity.enemy getvelocity();
    targetpos += velocity * entity ai::function_9139c839().var_10a1d059;
    var_a76a363d = math::randomsign() * randomint(var_ad804014);
    var_9b241db1 = math::randomsign() * randomint(var_ad804014);
    targetpos += (var_a76a363d, var_9b241db1, 0);
    speed = length(velocity);

    if(speed > 0) {
      var_7ee6937e = vectornormalize((targetpos[0], targetpos[1], 0) - (launchpos[0], launchpos[1], 0));
      dot = vectordot(-1 * var_7ee6937e, velocity / speed);

      if(dot >= entity ai::function_9139c839().var_cd8b7a6c) {
        targetpos += var_7ee6937e * dot * speed * entity ai::function_9139c839().var_322773b9;
      }
    }
  }

  targetpos += (0, 0, entity ai::function_9139c839().var_f227d0d0);
  var_872c6826 = vectortoangles(targetpos - launchpos);
  angles = function_cc68801f(launchpos, targetpos, entity ai::function_9139c839().var_81da787, getdvarfloat(#"bg_lowgravity", 0));

  if(isDefined(angles) && angles[#"lowangle"] > 0) {
    dir = anglesToForward((-1 * angles[#"lowangle"], var_872c6826[1], var_872c6826[2]));
  } else {
    dir = anglesToForward(var_872c6826);
  }

  velocity = dir * entity ai::function_9139c839().var_81da787;
  grenade = entity magicgrenadetype(getweapon("stoker_coal_bomb"), launchpos, velocity);
}

function_717a6538(entity) {
  entity clientfield::set("stoker_fx_stop_clientfield", 7);
}

function_6da30402(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(eattacker) && isai(eattacker) && eattacker.archetype == #"stoker" && eattacker.team != self.team) {
    if(smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_BURNED") {
      eattacker.var_d691409c = 1;
    }

    if(weapon == getweapon(#"stoker_melee") && isDefined(einflictor.cp_level_blackstation_goto_centerbreadcrumb) && einflictor.cp_level_blackstation_goto_centerbreadcrumb) {
      idamage = 150;
    }

    if(weapon == getweapon(#"stoker_coal_bomb")) {
      burnplayer::setplayerburning(1, 1, 1, eattacker, weapon);
    }

    return idamage;
  }

  return -1;
}

private function_8ef6771f(entity) {
  entity.var_dc89435f = 1;
}

private function_e2e5eebf(entity) {
  entity.var_dc89435f = undefined;
  entity.var_1db5ef71 = gettime() + entity ai::function_9139c839().var_10d707f8;
}

function_72339619(spawner, s_spot, var_bc66d64b) {
  ai_stoker = zombie_utility::spawn_zombie(level.a_sp_stoker[0], "stoker", s_spot, var_bc66d64b);

  if(isDefined(ai_stoker)) {
    ai_stoker.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai_stoker thread zombie_utility::round_spawn_failsafe();
    ai_stoker thread function_4c2cb763(s_spot);
  }

  return ai_stoker;
}

function_4c2cb763(s_spot) {
  if(isDefined(level.var_9fb8585a)) {
    self thread[[level.var_9fb8585a]](s_spot);
  }

  if(isDefined(level.var_1ab8872e)) {
    self thread[[level.var_1ab8872e]]();
  }
}

function_2170ee7a() {
  level.a_sp_stoker = getEntArray("zombie_stoker_spawner", "script_noteworthy");

  if(level.a_sp_stoker.size == 0) {
    assertmsg("<dev string:x2aa>");
    return;
  }

  foreach(sp_stoker in level.a_sp_stoker) {
    sp_stoker.is_enabled = 1;
    sp_stoker.script_forcespawn = 1;
    sp_stoker spawner::add_spawn_function(&stoker_init);
  }
}

stoker_init() {
  self function_2df052bb();
  self zm_score::function_82732ced();
  self.var_ab8f2b90 = 3;
  level thread zm_spawner::zombie_death_event(self);
}

private function_fa8be26d(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(attacker) && attacker.archetype === #"stoker" && self.team === attacker.team) {
    return 0;
  }

  return -1;
}

private killed_callback(e_attacker) {
  if(self.archetype != #"stoker") {
    return;
  }

  self val::set(#"stoker_death", "takedamage", 0);

  if(!isplayer(e_attacker)) {
    return;
  }

  e_attacker util::delay(1.5, "death", &zm_audio::create_and_play_dialog, #"kill", #"stoker");
}

spawn_single(b_force_spawn = 0, var_eb3a8721, var_bc66d64b) {
  if(!b_force_spawn && !function_30509b8c()) {
    return undefined;
  }

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.var_370b1a3d)) {
    s_spawn_loc = [[level.var_370b1a3d]]();
  } else if(level.zm_loc_types[#"stoker_location"].size > 0) {
    s_spawn_loc = array::random(level.zm_loc_types[#"stoker_location"]);
  }

  if(!isDefined(s_spawn_loc)) {

    if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
      iprintlnbold("<dev string:x2f4>");
    }

      return undefined;
  }

  ai = function_72339619(level.a_sp_stoker[0], undefined, var_bc66d64b);

  if(isDefined(ai)) {
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);

    if(isDefined(level.var_9e197b6)) {
      ai thread[[level.var_9e197b6]](s_spawn_loc);
    }

    ai playSound(#"hash_63299a75a97f9678");
    bhtnactionstartevent(ai, "spawn");
    self util::delay(3, "death", &zm_audio::function_bca32e49, "stoker", "cue_react");
  }

  return ai;
}

function_30509b8c() {
  var_cd35bb62 = function_9d74a83a();
  var_74f3a5af = function_6dd277e7();

  if(!(isDefined(level.var_76934955) && level.var_76934955) && (isDefined(level.var_fe2bb2ac) && level.var_fe2bb2ac || var_cd35bb62 >= var_74f3a5af || !level flag::get("spawn_zombies"))) {
    return false;
  }

  return true;
}

function_6dd277e7() {
  n_player_count = zm_utility::function_a2541519(level.players.size);

  switch (n_player_count) {
    case 1:
      return 1;
    case 2:
      return 2;
    case 3:
      return 2;
    case 4:
      return 3;
  }
}

function_cf5ef033(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_ac8e1955)) {
    level.var_ac8e1955 = 0;
  }

  switch (level.round_number - n_round_number) {
    case 0:
      break;
    case 1:
    case 2:
      level.var_ac8e1955++;
      break;
    case 3:
    case 4:
      level.var_ac8e1955 += 2;
      break;
    default:
      level.var_ac8e1955 = undefined;
      return;
  }

    while(true) {
      level waittill(#"hash_5d3012139f083ccb");

      if(zm_round_spawning::function_d0db51fc(#"stoker")) {
        level.var_ac8e1955++;

        if(level.var_ac8e1955 == 3) {
          level.var_ac8e1955 = undefined;
          level.var_a21ee6fc = undefined;
          return;
        }

        level.var_a21ee6fc = level.round_number + randomintrangeinclusive(1, 2);
      }
    }
}

function_b381320(var_dbce0c44) {
  var_8cf00d40 = int(floor(var_dbce0c44 / 100));

  if(isDefined(level.var_a21ee6fc) && level.round_number < level.var_a21ee6fc) {
    return 0;
  }

  if(level.players.size == 1) {
    var_1797c23a = 1 + max(0, floor((level.round_number - zombie_utility::get_zombie_var(#"hash_2374f3ef775ac2c3")) / 4));
  } else {
    var_1797c23a = 1 + max(0, floor((level.round_number - zombie_utility::get_zombie_var(#"hash_3b4ad7449c039d1b")) / 3));
  }

  var_2506688 = var_1797c23a < 8 ? max(var_1797c23a - 3, 0) : var_1797c23a * 0.75;
  return randomintrangeinclusive(int(var_2506688), int(min(var_8cf00d40, var_1797c23a)));
}

round_spawn() {
  ai = spawn_single();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_9d74a83a() {
  var_35576160 = getaiarchetypearray(#"stoker");
  var_cd35bb62 = var_35576160.size;

  foreach(ai_stoker in var_35576160) {
    if(!isalive(ai_stoker)) {
      var_cd35bb62--;
    }
  }

  return var_cd35bb62;
}

private function_f5f699aa() {
  var_16049422 = spawn_single(1);
  return isDefined(var_16049422);
}

private function_a92dac75() {
  level flagsys::wait_till("<dev string:x325>");
  zm_devgui::add_custom_devgui_callback(&function_963e8ce);
  spawner::add_archetype_spawn_function(#"stoker", &function_16c9b795);
}

private function_16c9b795() {
  if(isDefined(level.var_910d20f6) && level.var_910d20f6) {
    return;
  }

  adddebugcommand("<dev string:x340>" + getdvarint(#"hash_3dfb66f92268c90f", self ai::function_9139c839().var_d33d95d0) + "<dev string:x365>");
  adddebugcommand("<dev string:x371>");
  level.var_910d20f6 = 1;
}

private function_963e8ce(cmd) {
  if(cmd == "<dev string:x3b8>") {
    player = level.players[0];
    v_direction = player getplayerangles();
    v_direction = anglesToForward(v_direction) * 8000;
    eye = player getEye();
    trace = bulletTrace(eye, eye + v_direction, 0, undefined);
    var_380c580a = positionquery_source_navigation(trace[#"position"], 128, 256, 128, 20);
    s_spot = spawnStruct();

    if(isDefined(var_380c580a) && var_380c580a.data.size > 0) {
      s_spot.origin = var_380c580a.data[0].origin;
    } else {
      s_spot.origin = player.origin;
    }

    s_spot.angles = (0, player.angles[1] - 180, 0);
    spawn_single(1, s_spot);
    return 1;
  }

  if(cmd == "<dev string:x3c7>") {
    stokers = getaiarchetypearray(#"stoker");

    foreach(stoker in stokers) {
      stoker kill();
    }
  }
}

update_dvars() {
  while(true) {
    level.stokerdebug = getdvarint(#"scr_stokerdebug", 0);
    wait 1;
  }
}

function_752a64b8(message) {
  if(isDefined(level.stokerdebug)) {
    println("<dev string:x3d9>" + message);
  }
}

