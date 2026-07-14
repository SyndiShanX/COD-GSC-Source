/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\task_countdown_timer.gsc
******************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\engine\hud_management;
#namespace task_countdown_timer;

function private autoexec __init__system__() {
  system::register(#"task_countdown_timer", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_2b0edc0826e21d51();
}

function private function_2b0edc0826e21d51() {
  ui::lui_registercallback("\xe2\r\xbbvq\x1aA\xcf\xeb;\x05A\x98\x03\xe4i\no\xeel\xc7\x0f\\\x9c\x9e%", &task_countdown_timer_close);
}

function function_4f04343e9fb522a2(var_497c95a3bf396f8d, timer, asset, use_game_clock, close_callback) {
  widget = asset ?? hud_management::function_a1a13273e72bfe46("%?\xe2.\x8b#\xa7%\x17\xc7\xb2\xc2\xaf\x98N\xe7u\x0f\xf5\xeei\x12F\xb4\x874\xa2\x84\x8f%\xccU\xa4\xdf\x99_");
  hud_management::function_35924dfcb78711f4("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c", widget);
  hud_management::function_85d8a0ba2e35b6f2("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c", 50, 100, 0, 0);
  fields = [];
  fields["\xe8\xa5:\x1b\xb2\xafl\xed\x1b_Z7d+\x87"] = function_30e4f86dded0873(var_497c95a3bf396f8d);
  fields["\xe2)Tf\xee"] = timer ?? 0;
  fields["\x16\x1a\xc7\x1f\x1d`Yi&\x99\xfc\x8d\x9c\x9f"] = use_game_clock ?? 1;
  hud_management::function_41ff479ac45608d6("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c", fields);
  hud_management::function_d8d634ceece460("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c", "\xf1\xba\x8f\x9d");
  self.task_countdown_timer = spawnStruct();
  self.task_countdown_timer.close_callback = close_callback;
}

function function_31e1c8e88e25c042(str_state) {
  if(!hud_management::function_48c98ea9a4f0da89("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c")) {
    return;
  }

  assert(isDefined(str_state), "<dev string:x24>");
  hud_management::function_d8d634ceece460("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c", str_state);
}

function function_38cb16a52ea58084(var_33c99c1eb8751c41, var_fddc1cc1b5c68dfa, var_290f3a0c77735b7b, var_a3943ea0c9191ae9) {
  if(!hud_management::function_48c98ea9a4f0da89("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c")) {
    return;
  }

  if(!isDefined(var_33c99c1eb8751c41)) {
    var_33c99c1eb8751c41 = 0;
  }

  if(!isDefined(var_fddc1cc1b5c68dfa)) {
    var_fddc1cc1b5c68dfa = 0;
  }

  if(!isDefined(var_290f3a0c77735b7b)) {
    var_290f3a0c77735b7b = 0;
  }

  if(!isDefined(var_a3943ea0c9191ae9)) {
    var_a3943ea0c9191ae9 = 0;
  }

  hud_management::function_85d8a0ba2e35b6f2("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c", var_33c99c1eb8751c41, var_fddc1cc1b5c68dfa, var_290f3a0c77735b7b, var_a3943ea0c9191ae9);
}

function task_countdown_timer_close(val) {
  if(isDefined(self.task_countdown_timer) && isDefined(self.task_countdown_timer.close_callback)) {
    self thread[[self.task_countdown_timer.close_callback]]();
  }

  function_f594cb8d604201e();
}

function function_f594cb8d604201e() {
  hud_management::scripted_widget_destroy("\xd8{\xd5n:\x8c\xedw\xdc\xd7\x8ei\xadY\x9c");
  self.task_countdown_timer = undefined;
}