/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_civilian.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_state_machine;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\spawner_shared;
#namespace archetype_civilian;

function autoexec main() {
  archetypecivilian::registerbehaviorscriptfunctions();
}

#namespace archetypecivilian;

function registerbehaviorscriptfunctions() {
  spawner::add_archetype_spawn_function("civilian", & civilianblackboardinit);
  spawner::add_archetype_spawn_function("civilian", & archetypecivilianinit);
  ai::registermatchedinterface("civilian", "sprint", 0, array(1, 0));
  ai::registermatchedinterface("civilian", "panic", 0, array(1, 0));
  behaviortreenetworkutility::registerbehaviortreeaction("civilianMoveAction", & civilianmoveactioninitialize, undefined, & civilianmoveactionfinalize);
  behaviortreenetworkutility::registerbehaviortreeaction("civilianCowerAction", & civiliancoweractioninitialize, undefined, undefined);
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianIsPanicked", & civilianispanicked);
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianPanic", & civilianpanic);
  behaviorstatemachine::registerbsmscriptapiinternal("civilianPanic", & civilianpanic);
}

function private civilianblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_panic", "calm", & bb_getpanic);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_human_locomotion_variation", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self.___archetypeonanimscriptedcallback = & civilianonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private archetypecivilianinit() {
  entity = self;
  locomotiontypes = array("alt1", "alt2", "alt3", "alt4");
  altindex = entity getentitynumber() % locomotiontypes.size;
  blackboard::setblackboardattribute(entity, "_human_locomotion_variation", locomotiontypes[altindex]);
  entity setavoidancemask("avoid ai");
}

function private bb_getpanic() {
  if(ai::getaiattribute(self, "panic")) {
    return "panic";
  }
  return "calm";
}

function private civilianonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity civilianblackboardinit();
}

function private civilianmoveactioninitialize(entity, asmstatename) {
  blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function private civilianmoveactionfinalize(entity, asmstatename) {
  if(blackboard::getblackboardattribute(entity, "_stance") != "stand") {
    blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
  }
  return 4;
}

function private civiliancoweractioninitialize(entity, asmstatename) {
  if(isDefined(entity.node)) {
    higheststance = aiutility::gethighestnodestance(entity.node);
    if(higheststance == "crouch") {
      blackboard::setblackboardattribute(entity, "_stance", "crouch");
    } else {
      blackboard::setblackboardattribute(entity, "_stance", "stand");
    }
  }
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function private civilianispanicked(entity) {
  return blackboard::getblackboardattribute(entity, "_panic") == "panic";
}

function private civilianpanic(entity) {
  entity ai::set_behavior_attribute("panic", 1);
  return true;
}