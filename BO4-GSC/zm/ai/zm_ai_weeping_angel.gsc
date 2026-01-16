/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_weeping_angel.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_weeping_angel;

autoexec __init__system__() {
  system::register(#"zm_ai_weeping_angel", &__init__, &__main__, undefined);
}

__init__() {
  zm_score::function_e5d6e6dd(#"weeping_angel", 1);
  assert(isscriptfunctionptr(&function_f5d43a20));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a1fbaa1c4a45a3f", &function_f5d43a20);
  assert(isscriptfunctionptr(&function_ad034041));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_64a769b6a696ad3e", &function_ad034041, 1);
  spawner::add_archetype_spawn_function(#"weeping_angel", &function_d8a99ae2);

  zm_devgui::function_c7dd7a17("<dev string:x38>");
  adddebugcommand("<dev string:x48>");
  adddebugcommand("<dev string:x78>");

    level thread aat::register_immunity("zm_aat_brain_decay", #"weeping_angel", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_frostbite", #"weeping_angel", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_kill_o_watt", #"weeping_angel", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_plasmatic_burst", #"weeping_angel", 1, 1, 1);
}

__main__() {}

private function_d8a99ae2() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self zombie_utility::set_zombie_run_cycle("super_sprint");
  self thread function_487069e4();
}

private function_487069e4() {
  self endon(#"death");
  wait 1;
  self disableaimassist();
}

private function_b6824ff0(entity, player, duration, color) {

  enabled = getdvarint(#"hash_46b9af6724aa7968", 0);

  if(enabled) {
    endpoint = function_78910888(player);
    entity thread function_e5ffb77c(entity.origin, endpoint, 0.05, color);
  }

}

private function_e5ffb77c(start, end, duration, color) {
  current_time = duration * 20;

  while(current_time > 0) {
    waitframe(1);
    line(start, end, color, 1, 1);
    sphere(end, 10, color, 1, 0, 8, 1);
    distance = distance(start, end);
    print3d(end + (0, 0, 10), "<dev string:xc8>" + distance, color, 1, 1, 1);
    current_time -= 1;
  }
}

  function private function_78910888(player) {
    angles = player getplayerangles();
    forward = anglesToForward(angles);
    result = player.origin + (0, 0, 30) + forward * 100;
    return result;
  }

private function_ad034041(entity) {
  players = getplayers();
  var_de85d14d = [];

  foreach(player in players) {
    if(player cansee(entity)) {
      function_b6824ff0(entity, player, 0.1, (1, 0, 0));
      var_de85d14d[var_de85d14d.size] = player;
      continue;
    }

    function_b6824ff0(entity, player, 0.1, (0, 1, 0));
  }

  if(var_de85d14d.size > 0) {
    if(!(isDefined(entity.is_inert) && entity.is_inert)) {
      entity namespace_9ff9f642::freeze();
    }

    entity setgoal(entity.origin);
    return;
  }

  if(isDefined(entity.is_inert) && entity.is_inert) {
    entity namespace_9ff9f642::unfreeze();
  }

  if(isDefined(entity.var_72411ccf)) {
    entity[[entity.var_72411ccf]](entity);
    return;
  }

  entity zm_behavior::zombiefindflesh(entity);
}

private function_f5d43a20(entity) {
  result = zombiebehavior::zombieshouldmeleecondition(entity);

  if(result && isDefined(entity.enemy) && entity.enemy cansee(entity)) {
    result = 1;
  }

  return result;
}