/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4a70de683189a148.gsc
*************************************************/

#using script_4a70de683189a148;
#using script_72ef6b9f0cf1f55a;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace objective_splash;

function private autoexec __init__system__() {
  system::register(#"objective_splash", #"hash_58f5dc856591d010", &pre_main, undefined);
}

function private pre_main() {
  if(!isDefined(level.objectives_splash)) {
    level.objectives_splash = spawnStruct();
  }

  scripts\engine\sp\objectives::function_1a7f32a7c56ad4e0(&namespace_f8a964affd6c5998::show_splash);
  level.objectives_splash.widget = function_6cd0a8e23ff14e13("scripted_widget_objective_splash");
  scripts\common\ui::lui_registercallback("objective_splash_complete", &remove_splash);
}

function private function_79bc04af6da056bb(msg_str, is_completed, var_ab20541e485d5ba0, var_1b0922c37b1abf7) {
  is_completed = default_to(is_completed, 0);
  var_ab20541e485d5ba0 = default_to(var_ab20541e485d5ba0, 0);
  var_1b0922c37b1abf7 = default_to(var_1b0922c37b1abf7, -1);
  fields = [];
  fields["title_index"] = getlocstringindex(msg_str);
  fields["is_completed"] = is_completed;
  fields["count"] = var_ab20541e485d5ba0;
  fields["table_id"] = var_1b0922c37b1abf7;
  return fields;
}

function show_splash(ref_str, msg_str, is_completed, var_ab20541e485d5ba0, var_1b0922c37b1abf7) {
  assert(isDefined(ref_str));
  assert(isDefined(msg_str));
  assertex(isDefined(level.objectives_splash.widget), "The splash widget, " + level.objectives_splash.widget + ", does not exist or is not included in the level's scripted widget list. Please check APE.");
  settings = spawnStruct();
  settings.ref = ref_str;
  settings.msg_str = msg_str;
  settings.is_completed = is_completed;
  settings.var_ab20541e485d5ba0 = var_ab20541e485d5ba0;
  settings.var_1b0922c37b1abf7 = var_1b0922c37b1abf7;
  level.objectives_splash.settings = settings;

  if(!function_ada0825249682644("objective_splash")) {
    function_90de31b2cbef19f9("objective_splash", level.objectives_splash.widget);
  } else {
    waitframe();
  }

  function_14a0ee2aaf9128c3("objective_splash", function_79bc04af6da056bb(msg_str, is_completed, var_ab20541e485d5ba0, var_1b0922c37b1abf7), 1);
  function_f4c37324750dc183("objective_splash", 0, 0, 3, 3);
  thread function_2dfbf73728a84824();
}

function function_2dfbf73728a84824() {
  self endon("disconnect");
  self endon("death");
  self setclientomnvar("ui_show_objectives", 1);
  wait 3;
  self setclientomnvar("ui_show_objectives", 0);
}

function function_e5ba01b6b27e6823(count_value, count_max) {}

function function_56854474e9410861(state_str) {
  function_d28fa5295a04d555("objective_splash", state_str);
}

function remove_splash(val) {
  level.objectives_splash.settings = undefined;
  scripted_widget_destroy("objective_splash");
}