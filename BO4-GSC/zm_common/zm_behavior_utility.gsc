/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_behavior_utility.gsc
***********************************************/

#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_spawner;

#namespace zm_behavior_utility;

setupattackproperties() {
  self val::reset(#"attack_properties", "ignoreall");
  self.meleeattackdist = 64;
}

enteredplayablearea() {
  self zm_spawner::zombie_complete_emerging_into_playable_area();
  self.pushable = 1;
  self setupattackproperties();
}