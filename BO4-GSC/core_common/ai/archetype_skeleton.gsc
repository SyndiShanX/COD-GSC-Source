/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_skeleton.gsc
*************************************************/

#include script_2c5daa95f8fec03c;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace archetype_skeleton;

autoexec init() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"skeleton", &function_f31535d8);
  spawner::add_archetype_spawn_function(#"skeleton", &function_a1acece9);
  level.var_cc1828c = [#"walk": 4];
}

private function_f31535d8() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypeskeletononanimscriptedcallback;
}

private archetypeskeletononanimscriptedcallback(entity) {
  self.__blackboard = undefined;
  self function_f31535d8();
}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_7ef4937e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2dafca553cbc289b", &function_7ef4937e, 1);
  assert(isscriptfunctionptr(&function_233f80e1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_22a1ab87ff6a9886", &function_233f80e1);
  assert(isscriptfunctionptr(&function_9eb31dff));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5260937d1b37a1ab", &function_9eb31dff);
  assert(isscriptfunctionptr(&skeletondeathaction));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"skeletondeathaction", &skeletondeathaction);
  animationstatenetwork::registeranimationmocomp("mocomp_skeleton_run_melee", &function_7d1989aa, &function_5ff8994e, &function_9873c40e);
}

private function_a1acece9() {
  self.ignorepathenemyfightdist = 1;
  self.cant_move_cb = &zombiebehavior::function_79fe956f;
  self.var_2f68be48 = 1;
  self zombie_utility::set_zombie_run_cycle();
  self.base_speed = self.zombie_move_speed;
  self setup_variant_type();
  self callback::function_d8abfc3d(#"hash_dfbeaa068b23e7c", &setup_variant_type);

  if(self.subarchetype == #"hash_fd7b9665529dd42") {
    self attach(#"c_t8_zmb_dlc2_skeleton_helmet", "j_head");
    self attach(#"c_t8_zmb_dlc2_skeleton_sword", "tag_weapon_right");
    self attach(#"c_t8_zmb_dlc2_skeleton_shield", "tag_weapon_left");
  } else if(self.subarchetype == #"hash_1520c8987a671df0") {
    self attach(#"c_t8_zmb_dlc2_skeleton_helmet", "j_head");
    self attach(#"c_t8_zmb_dlc2_skeleton_spear", "tag_weapon_right");
  } else if(self.subarchetype == #"hash_342763a42d8fbca") {
    self attach(#"c_t8_zmb_dlc2_skeleton_sword", "tag_weapon_right");
    self attach(#"c_t8_zmb_dlc2_skeleton_shield", "tag_weapon_left");
  } else if(self.subarchetype == #"skeleton_spear") {
    self attach(#"c_t8_zmb_dlc2_skeleton_spear", "tag_weapon_right");
  }

  aiutility::addaioverridedamagecallback(self, &function_abab78a7);
  self callback::on_ai_killed(&function_4ac532fd);
}

private setup_variant_type(params) {
  if(isDefined(level.var_cc1828c) && isDefined(level.var_cc1828c[self.zombie_move_speed])) {
    self.variant_type = randomintrange(0, level.var_cc1828c[self.zombie_move_speed]);
    return;
  }

  self.variant_type = 0;
}

private function_abab78a7(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(boneindex)) {
    bonename = getpartname(self, boneindex);

    if(bonename === "tag_animate") {
      return 0;
    }
  }

  if(isDefined(level.var_dd9ff360)) {
    damage = self[[level.var_dd9ff360]](inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
  }

  return damage;
}

private function_4ac532fd(s_params) {
  if(!(isDefined(self.fake_death) && self.fake_death)) {
    destructserverutils::togglespawngibs(self, 1);
    destructserverutils::function_629a8d54(self, "tag_animate");
  }
}

private skeletondeathaction(entity) {
  entity ghost();
}

private function_233f80e1(entity) {
  if(entity asmistransitionrunning() || entity asmistransdecrunning()) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    if(!entity haspath()) {
      return false;
    }

    if(!btapi_shouldchargemelee(entity)) {
      return false;
    }

    if(!function_dd3f5fa7(entity)) {
      return false;
    }

    if(!isplayer(entity.enemy)) {
      return false;
    }

    if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
      return false;
    }

    if(!entity cansee(entity.enemy)) {
      return false;
    }

    if(!tracepassedonnavmesh(entity.origin, entity.enemy.origin, entity getpathfindingradius())) {
      return false;
    }

    return true;
  }

  return false;
}

private function_dd3f5fa7(entity) {
  if(getdvarint(#"hash_3e2ac8f3fd8af68a", 0)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_2d00dddb = blackboard::getblackboardevents("skeleton_run_melee");

  if(isDefined(var_2d00dddb) && var_2d00dddb.size) {
    foreach(var_5d4c61c9 in var_2d00dddb) {
      if(var_5d4c61c9.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

private function_9eb31dff(entity) {
  var_5d4c61c9 = {
    #enemy: entity.enemy
  };
  blackboard::addblackboardevent("skeleton_run_melee", var_5d4c61c9, randomintrange(5000, 7000));
}

function_bcb3a1a1() {
  if(isDefined(self.favoriteenemy)) {
    predictedpos = self lastknownpos(self.favoriteenemy);

    if(isDefined(predictedpos)) {
      turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
      return turnyaw;
    }
  }

  return undefined;
}

private function_7a007bbf(skeleton, entity) {
  forward = anglesToForward(skeleton.angles);
  to_enemy = vectornormalize(entity.origin - skeleton.origin);
  return vectordot(forward, to_enemy) >= 0.966;
}

function_7d1989aa(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face enemy");
  entity animmode("zonly physics");

  if(isDefined(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) < 60 * 60) {
    entity animmode("angle deltas");
  }
}

function_5ff8994e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face enemy");
  entity animmode("zonly physics");

  if(isDefined(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) < 60 * 60) {
    entity animmode("angle deltas");
  }
}

function_9873c40e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face current");
}

function_a94fc02e(entity) {
  if(entity.zombie_move_speed === "walk") {
    entity zombie_utility::set_zombie_run_cycle("run");
  } else if(entity.zombie_move_speed === "run") {
    entity zombie_utility::set_zombie_run_cycle("sprint");
  }

  entity.var_a2691e6b = gettime() + randomintrange(5000, 7500);
  entity.is_charging = 1;
  var_b7eca892 = {
    #enemy: entity.enemy
  };
  blackboard::addblackboardevent("skeleton_speed_update", var_b7eca892, randomintrange(1000, 2000));

  if(isDefined(level.var_a5007a40)) {
    entity[[level.var_a5007a40]]();
  }
}

function_9f7eb359(entity) {
  entity.is_charging = 0;
  entity.var_a9bb453f = gettime() + randomintrange(5000, 7500);

  if(entity.zombie_move_speed === "run") {
    entity zombie_utility::set_zombie_run_cycle("walk");
  } else if(entity.zombie_move_speed === "sprint") {
    entity zombie_utility::set_zombie_run_cycle("run");
  }

  if(isDefined(level.var_51e07970)) {
    entity[[level.var_51e07970]]();
  }
}

private function_7ef4937e(entity) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(isDefined(self.is_charging) && self.is_charging) {
    if(distance2dsquared(self.enemy.origin, entity.origin) >= 1000 * 1000 || gettime() >= self.var_a2691e6b) {
      function_9f7eb359(entity);
    }

    return false;
  }

  if(isDefined(self.var_a9bb453f) && gettime() < self.var_a9bb453f) {
    return false;
  }

  var_b2bf2e3c = blackboard::getblackboardevents("skeleton_speed_update");

  if(isDefined(var_b2bf2e3c) && var_b2bf2e3c.size) {
    foreach(var_b7eca892 in var_b2bf2e3c) {
      if(var_b7eca892.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  if(isDefined(level.var_64800a5a) && ![[level.var_64800a5a]](self)) {
    return false;
  }

  if(distance2dsquared(self.enemy.origin, entity.origin) < 400 * 400) {
    if(!util::within_fov(entity.enemy.origin, entity.enemy.angles, self.origin, cos(90))) {
      return false;
    }

    function_a94fc02e(entity);
    return true;
  }

  return false;
}