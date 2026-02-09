/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_clone.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace clonebehavior;

function autoexec init() {
  initthrasherbehaviorsandasm();
  spawner::add_archetype_spawn_function("human_clone", &archetypecloneblackboardinit);
  spawner::add_archetype_spawn_function("human_clone", &clonespawnsetup);
}

function private initthrasherbehaviorsandasm() {}

function private archetypecloneblackboardinit() {
  entity = self;
  blackboard::createblackboardforentity(entity);
  entity aiutility::registerutilityblackboardattributes();
  ai::createinterfaceforentity(entity);
  entity.___archetypeonanimscriptedcallback = &archetypecloneonanimscriptedcallback;
  entity finalizetrackedblackboardattributes();
}

function private archetypecloneonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypecloneblackboardinit();
}

function private perfectinfothread() {
  entity = self;
  entity endon("death");
  while(true) {
    if(isDefined(entity.enemy)) {
      entity getperfectinfo(entity.enemy, 1);
    }
    wait(0.05);
  }
}

function private clonespawnsetup() {
  entity = self;
  entity.ignoreme = 1;
  entity.ignoreall = 1;
  entity setcontents(8192);
  entity setavoidancemask("avoid none");
  entity setclone();
  entity thread perfectinfothread();
}

#namespace cloneserverutils;

function cloneplayerlook(clone, cloneplayer, targetplayer) {
  assert(isactor(clone));
  assert(isPlayer(cloneplayer));
  assert(isPlayer(targetplayer));
  clone.owner = cloneplayer;
  clone setentitytarget(targetplayer, 1);
  clone setentityowner(cloneplayer);
  clone detachall();
  bodymodel = cloneplayer getcharacterbodymodel();
  if(isDefined(bodymodel)) {
    clone setModel(bodymodel);
  }
  headmodel = cloneplayer getcharacterheadmodel();
  if(isDefined(headmodel) && headmodel != "tag_origin") {
    if(isDefined(clone.head)) {
      clone detach(clone.head);
    }
    clone attach(headmodel);
  }
  helmetmodel = cloneplayer getcharacterhelmetmodel();
  if(isDefined(helmetmodel) && headmodel != "tag_origin") {
    clone attach(helmetmodel);
  }
}