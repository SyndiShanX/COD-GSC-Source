/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5e8f7ecf981ad9a3.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_nosferatu;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#namespace namespace_be2ae534;

function init() {
  namespace_250e9486::function_252dff4d("demon", 4, &function_8cff66e5, &function_227b5187);
  clientfield::register("actor", "nfrtu_move_dash", 8000, 1, "int");
  registerbehaviorscriptfunctions();
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&namespace_250e9486::shouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ef20564d67585c5", &namespace_250e9486::shouldstun);
  assert(isscriptfunctionptr(&function_a3037ba2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_463e60b10fe1afee", &function_a3037ba2);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_1d87e1af) || isscriptfunctionptr(&function_1d87e1af));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_6cdf9a7fdb31b1e4", undefined, &function_1d87e1af, undefined);
  assert(isscriptfunctionptr(&function_3e73036b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_783b67afe0ea98a5", &function_3e73036b);
  assert(isscriptfunctionptr(&function_a85ea11));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5be8a05866186293", &function_a85ea11);
  assert(isscriptfunctionptr(&function_7df9c6d8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2321be589a6d9a0", &function_7df9c6d8);
  assert(isscriptfunctionptr(&function_cf9a996));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3a2582998db5774b", &function_cf9a996);
  assert(isscriptfunctionptr(&function_bc8edc07));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3c518f78c393482e", &function_bc8edc07);
  assert(isscriptfunctionptr(&namespace_250e9486::function_abb6c18a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48a15a732caa47ce", &namespace_250e9486::function_abb6c18a);
  assert(isscriptfunctionptr(&namespace_250e9486::function_99ed5179));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4b5d0f518720c6e9", &namespace_250e9486::function_99ed5179);
  assert(isscriptfunctionptr(&namespace_250e9486::function_50547dae));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1f5497ad3559808d", &namespace_250e9486::function_50547dae);
}

function function_8cff66e5() {
  self namespace_250e9486::function_25b2c8a9();
  self.animrate = 1;
  self.var_df416181 = "annhilate";
  self.var_d1bf288 = 3000;
  self.health = 600 + getplayers().size * 400;
  self.no_gib = 1;
  self asmsetanimationrate(self.animrate);
  self namespace_83eb6304::function_3ecfde67("demon_burst");
  self thread namespace_9fc66ac::function_ba33d23d(#"hash_4fb3839181258631", #"hash_4fb3839181258631", #"hash_3da6894b4a02a91b");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_demon_spawn");
}

function function_227b5187() {
  self namespace_250e9486::function_8971bbb7();
}

function private function_5c82fd66(entity) {
  var_7a69f7e9 = blackboard::getblackboardevents("nfrtu_stun");

  if(isDefined(var_7a69f7e9) && var_7a69f7e9.size) {
    foreach(event in var_7a69f7e9) {
      if(event.nosferatu === entity) {
        return false;
      }
    }
  }

  return true;
}

function function_a3037ba2(entity) {
  namespace_250e9486::stunstart(entity);
  var_268f1415 = spawnStruct();
  var_268f1415.nosferatu = entity;
  blackboard::addblackboardevent("nfrtu_stun", var_268f1415, randomintrange(10000, 12000));
}

function private function_1d87e1af(entity, asmstatename) {
  if(asmstatename ai::is_stunned()) {
    return 5;
  }

  return 4;
}

function function_3e73036b(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_623b3520 = blackboard::getblackboardevents("nfrtu_full_pain");

  if(isDefined(var_623b3520) && var_623b3520.size) {
    foreach(var_77d2339d in var_623b3520) {
      if(var_77d2339d.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

function private function_a85ea11(entity) {
  var_77d2339d = spawnStruct();
  var_77d2339d.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_full_pain", var_77d2339d, randomintrange(4500, 6500));
}

function private function_7df9c6d8(entity) {
  entity pathmode("move allowed");
}

function function_cf9a996(entity) {
  entity namespace_e32bb68::function_3a59ec34("zmb_doa_ai_demon_vocal_leap");
  entity clientfield::set("nfrtu_move_dash", 1);
  return true;
}

function function_bc8edc07(entity) {
  entity clientfield::set("nfrtu_move_dash", 0);
  return true;
}