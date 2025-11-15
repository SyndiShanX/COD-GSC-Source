/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human_rpg.gsc
*************************************************/

#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_human_rpg_interface;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#namespace archetype_human_rpg;

function autoexec main() {
  spawner::add_archetype_spawn_function("human_rpg", & humanrpgbehavior::archetypehumanrpgblackboardinit);
  humanrpgbehavior::registerbehaviorscriptfunctions();
  humanrpginterface::registerhumanrpginterfaceattributes();
}

#namespace humanrpgbehavior;

function registerbehaviorscriptfunctions() {}

function private archetypehumanrpgblackboardinit() {
  entity = self;
  blackboard::createblackboardforentity(entity);
  ai::createinterfaceforentity(entity);
  entity aiutility::registerutilityblackboardattributes();
  self.___archetypeonanimscriptedcallback = & archetypehumanrpgonanimscriptedcallback;
  entity finalizetrackedblackboardattributes();
  entity asmchangeanimmappingtable(1);
}

function private archetypehumanrpgonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypehumanrpgblackboardinit();
}