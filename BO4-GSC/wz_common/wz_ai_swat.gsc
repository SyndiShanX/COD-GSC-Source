/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai_swat.gsc
***********************************************/

#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_ai_swat;

autoexec __init__system__() {
  system::register(#"swat", &__init__, undefined, undefined);
}

__init__() {
  registerbehaviorscriptfunctions();
}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_e3151f98));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62335a0608a02309", &function_e3151f98);
  assert(isscriptfunctionptr(&function_e5f59cf0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a938922d1af0c4d", &function_e5f59cf0);
  assert(isscriptfunctionptr(&function_3c677dcd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4cc583c8bb841d4c", &function_3c677dcd);
  assert(isscriptfunctionptr(&function_994477c0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3861dc092e2bcf88", &function_994477c0);
  assert(isscriptfunctionptr(&function_fb9f1f3b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48334fe2b83169f2", &function_fb9f1f3b);
  animationstatenetwork::registeranimationmocomp("mocomp_swat_team_pain", &function_6edff1e1, undefined, &function_8acd749d);
}

function_6edff1e1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", self.angles[1]);
  entity animmode("zonly_physics", 1);
  entity pathmode("dont move");
  entity.blockingpain = 1;
}

function_8acd749d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity pathmode("move allowed");
  entity.blockingpain = 0;
}

private function_e3151f98(entity) {
  if(entity.subarchetype === #"human_swat_gunner") {
    return true;
  }

  return false;
}

private function_e5f59cf0(entity) {
  entity unlink();
}

private function_3c677dcd(entity) {
  if(isDefined(entity.enemy)) {
    if(util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(90))) {
      return true;
    }
  }

  return false;
}

private function_994477c0(entity) {
  return false;
}

private function_fb9f1f3b(entity) {
  return false;
}