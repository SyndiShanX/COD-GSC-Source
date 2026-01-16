/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_ghost.gsc
***********************************************/

#include script_2c5daa95f8fec03c;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\archetype_mocomps_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\debug;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\ai\zm_ai_ghost_interface;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_ghost;

autoexec __init__system__() {
  system::register(#"zm_ai_ghost", &__init__, &__main__, undefined);
}

__init__() {
  spawner::add_archetype_spawn_function(#"ghost", &function_cc3e52ff);
  spawner::add_archetype_spawn_function(#"ghost", &function_fe6a9772);
  zm_ai_ghost_interface::function_fd76c3b();
}

__main__() {}

function_cc3e52ff() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_f093c843;
}

private function_f093c843(entity) {
  entity.__blackboard = undefined;
  entity function_cc3e52ff();
}

private function_fe6a9772() {
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");

  if(!isDefined(self.zombie_arms_position)) {
    if(randomint(2) == 0) {
      self.zombie_arms_position = "up";
    } else {
      self.zombie_arms_position = "down";
    }
  }

  self.zombie_move_speed = "walk";
  self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
  self.zombie_think_done = 1;
  self setavoidancemask("avoid none");
  self collidewithactors(0);
  self setplayercollision(0);
  self.var_ccefa6dd = 1;
}

function_cea6c2e0(entity, attribute, oldvalue, value) {
  if(value === 1) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    return;
  }

  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
}