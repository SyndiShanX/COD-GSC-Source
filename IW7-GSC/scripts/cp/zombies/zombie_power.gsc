/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_power.gsc
***********************************************/

func_96F4() {
  wait(5);
  level.generators = [];
  level.generators = scripts\engine\utility::getStructArray("generator", "script_noteworthy");
  scripts\engine\utility::flag_init("power_on");
  level.power_off_func = ::func_D744;
  foreach(var_1 in level.generators) {
    func_95FC(var_1);
  }
}

func_95FC(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_0.handle = undefined;
  var_0.var_2F12 = undefined;
  foreach(var_4 in var_1) {
    if(var_4.model == "icbm_electricpanel_switch_02") {
      var_0.handle = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "box") {
      var_0.var_2F12 = var_4;
    }
  }
}

func_D744(var_0, var_1) {
  var_2 = level.generators;
  foreach(var_4 in var_2) {
    if(scripts\engine\utility::istrue(var_4.powered_on)) {
      level thread func_7736(var_4);
    }
  }

  level notify("power_off");
}

func_7736(var_0) {
  while(!isDefined(level.current_interaction_structs)) {
    wait(1);
  }

  thread func_7758(var_0);
  var_1 = var_0.script_parameters;
  var_2 = strtok(var_1, ",");
  foreach(var_4 in var_2) {
    if(var_4 == "power_all") {
      scripts\engine\utility::flag_clear("power_on");
      continue;
    }

    if(scripts\engine\utility::flag_exist(var_4 + " power_on")) {
      scripts\engine\utility::flag_clear(var_4 + " power_on");
    }
  }

  var_0.powered_on = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

func_7758(var_0) {
  if(var_0.handle.script_noteworthy == "roll") {
    var_0.handle rotateroll(-60, 0.5);
  } else if(var_0.handle.script_noteworthy == "-roll") {
    var_0.handle rotateroll(60, 0.5);
  } else if(var_0.handle.script_noteworthy == "pitch") {
    var_0.handle rotatepitch(-60, 0.5);
  } else if(var_0.handle.script_noteworthy == "-pitch") {
    var_0.handle rotatepitch(60, 0.5);
  }

  if(isDefined(var_0.var_7735)) {
    var_0.var_7735 delete();
  }
}

func_129A2(var_0) {
  scripts\cp\zombies\zombie_analytics::func_AF8E(var_0, level.wave_num);
}

generic_generator(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(isDefined(var_1)) {
    var_1 thread scripts\cp\utility::firegesturegrenade(var_1, "iw7_powerlever_zm");
  }

  if(!isDefined(var_1)) {
    var_1 = level.players[0];
  }

  if(isDefined(var_0.target)) {
    func_7759(var_0, var_1);
  }

  var_2 = var_0.script_parameters;
  var_3 = strtok(var_2, ",");
  func_129A2(var_3[0]);
  level notify("power_on_scriptable_and_light", var_2, var_1);
  wait(2.5);
  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {}

    if(var_5 == "power_all") {
      level notify("power_on");
      scripts\engine\utility::flag_set("power_on");
      level.var_D746 = 1;
      continue;
    }

    level notify(var_5 + " power_on");
    if(scripts\engine\utility::flag_exist(var_5 + " power_on")) {
      scripts\engine\utility::flag_set(var_5 + " power_on");
    }
  }

  scripts\engine\utility::waitframe();
  level notify("activate_power");
  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_power", "zmb_comment_vo", "medium", 4, 0, 0, 0, 50);
    if(isDefined(level.power_vo_func)) {
      thread[[level.power_vo_func]](var_1);
    }
  }

  wait(0.5);
  level thread func_DE6F();
}

func_DE6F() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.last_interaction_point) && isDefined(var_1.last_interaction_point.requires_power)) {
      var_1 notify("stop_interaction_logic");
      var_1.interaction_trigger makeunusable();
      var_1.last_interaction_point = undefined;
    }

    wait(0.05);
  }
}

func_7759(var_0, var_1) {
  level endon("power_off");
  wait(0.2);
  if(var_0.handle.script_noteworthy == "roll") {
    var_0.handle rotateroll(75, 0.15);
  } else if(var_0.handle.script_noteworthy == "-roll") {
    var_0.handle rotateroll(-75, 0.15);
  } else if(var_0.handle.script_noteworthy == "pitch") {
    var_0.handle rotatepitch(75, 0.15);
  } else if(var_0.handle.script_noteworthy == "-pitch") {
    var_0.handle rotatepitch(-75, 0.15);
  }

  if(isDefined(var_0.var_2F12)) {
    var_0.var_2F12 setscriptablepartstate("box", "on");
  }

  var_0.powered_on = 1;
}

register_interactions() {
  level.interaction_hintstrings["generator"] = &"COOP_INTERACTIONS_GENERATOR_ON";
  scripts\cp\cp_interaction::register_interaction("generator", "generator", 1, undefined, ::generic_generator, 0);
}