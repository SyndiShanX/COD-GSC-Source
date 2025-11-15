/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_thrasher.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_behavior;
#using scripts\zm\_zm_utility;
#namespace zm_island_thrasher;

function autoexec init() {
  spawner::add_archetype_spawn_function("thrasher", & function_f8333089);
}

function private function_f8333089() {
  self thread function_9b57ea16();
}

function private function_9b57ea16() {
  self endon("death");
  wait(1);
  self ai::set_behavior_attribute("use_attackable", 1);
}