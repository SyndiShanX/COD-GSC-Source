/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\archetype_zombie_interface;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#namespace namespace_9c39c8b3;

function autoexec init() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("bonuszmZombieTraversalDoesAnimationExist", & function_6de9fa37);
  behaviortreenetworkutility::registerbehaviortreeaction("bonuszmSpecialTraverseAction", & function_88e9d5da, undefined, & function_dd1fc89b);
  animationstatenetwork::registeranimationmocomp("mocomp_bonuszm_special_traversal", & function_26c42b09, undefined, & function_47268b78);
}

function private function_6de9fa37(entity) {
  assert(isdefined(entity.traversestartnode));
  var_f6b30806 = isdefined(entity.traversestartnode) && entity.traversestartnode.script_noteworthy === "custom_traversal" || (isdefined(entity.traverseendnode) && entity.traverseendnode.script_noteworthy === "custom_traversal");
  if(var_f6b30806) {
    if(isdefined(entity.traversestartnode) && !issubstr(entity.traversestartnode.animscript, "human")) {
      if(isdefined(entity.traversestartnode.animscript)) {
        iprintln("" + entity.traversestartnode.animscript);
      }
      return false;
    }
    if(isdefined(entity.traverseendnode) && !issubstr(entity.traversestartnode.animscript, "human")) {
      if(isdefined(entity.traversestartnode.animscript)) {
        iprintln("" + entity.traversestartnode.animscript);
      }
      return false;
    }
    return true;
  }
  blackboard::setblackboardattribute(entity, "_traversal_type", entity.traversestartnode.animscript);
  if(entity.missinglegs === 1) {
    animationresults = entity astsearch(istring("traverse_legless@zombie"));
  } else {
    animationresults = entity astsearch(istring("traverse@zombie"));
  }
  if(isdefined(animationresults["animation"])) {
    return true;
  }
  if(isdefined(entity.traversestartnode.animscript)) {
    iprintln("" + entity.traversestartnode.animscript);
  }
  return false;
}

function private function_88e9d5da(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity ghost();
  entity notsolid();
  entity clientfield::set("zombie_appear_vanish_fx", 1);
  return 5;
}

function private function_dd1fc89b(entity, asmstatename) {
  entity clientfield::set("zombie_appear_vanish_fx", 3);
  entity show();
  entity solid();
  return 4;
}

function private function_26c42b09(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity setrepairpaths(0);
  locomotionspeed = blackboard::getblackboardattribute(entity, "_locomotion_speed");
  if(locomotionspeed == "locomotion_speed_walk") {
    rate = 1.5;
  } else {
    if(locomotionspeed == "locomotion_speed_run") {
      rate = 2;
    } else {
      rate = 3;
    }
  }
  entity asmsetanimationrate(rate);
  if(entity haspath()) {
    entity.var_51ea7126 = entity.pathgoalpos;
  }
  assert(isdefined(entity.traverseendnode));
  entity forceteleport(entity.traverseendnode.origin, entity.angles);
  entity animmode("noclip", 0);
  entity.blockingpain = 1;
}

function private function_47268b78(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 0;
  entity setrepairpaths(1);
  if(isdefined(entity.var_51ea7126)) {
    entity setgoal(entity.var_51ea7126);
  }
  entity asmsetanimationrate(1);
  entity finishtraversal();
}