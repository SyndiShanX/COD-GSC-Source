/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_behavior_utility.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_spawner;
#namespace zm_behavior_utility;

function setupattackproperties() {
  self.ignoreall = 0;
  self.meleeattackdist = 64;
}

function enteredplayablearea() {
  self zm_spawner::zombie_complete_emerging_into_playable_area();
  self.pushable = 1;
  self setupattackproperties();
}