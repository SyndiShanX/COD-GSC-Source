/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_asylum_zombie.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_remaster_zombie;
#namespace zm_asylum_zombie;

function autoexec init() {
  setdvar("scr_zm_use_code_enemy_selection", 0);
  level.closest_player_override = & zm_remaster_zombie::remaster_closest_player;
  level thread zm_remaster_zombie::update_closest_player();
  level.move_valid_poi_to_navmesh = 1;
  level.pathdist_type = 2;
  spawner::add_archetype_spawn_function("zombie", & function_87ff545e);
  level.last_valid_position_override = & asylum_last_valid_position;
}

function private function_87ff545e() {
  self pushactors(0);
}

function private asylum_last_valid_position() {
  bad_pos = (-307, -55, 226);
  var_c49c5ad0 = (-307, -60, 226);
  var_1dd2d452 = distance2dsquared(self.origin, bad_pos);
  if(var_1dd2d452 < 64) {
    self.last_valid_position = var_c49c5ad0;
    return true;
  }
  return false;
}