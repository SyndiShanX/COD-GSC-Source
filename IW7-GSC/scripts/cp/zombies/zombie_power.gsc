/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_power.gsc
***********************************************/

func_96F4() {
  wait(5);
  level.generators = [];
  level.generators = scripts\engine\utility::getstructarray("generator", "script_noteworthy");
  scripts\engine\utility::flag_init("power_on");
  level.power_off_func = ::func_D744;
  foreach(var_01 in level.generators) {
    func_95FC(var_01);
  }
}

func_95FC(param_00) {
  var_01 = getEntArray(param_00.target, "targetname");
  var_02 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  param_00.handle = undefined;
  param_00.var_2F12 = undefined;
  foreach(var_04 in var_01) {
    if(var_04.model == "icbm_electricpanel_switch_02") {
      param_00.handle = var_04;
      continue;
    }

    if(var_04.script_noteworthy == "box") {
      param_00.var_2F12 = var_04;
    }
  }
}

func_D744(param_00, param_01) {
  var_02 = level.generators;
  foreach(var_04 in var_02) {
    if(scripts\engine\utility::istrue(var_04.powered_on)) {
      level thread func_7736(var_04);
    }
  }

  level notify("power_off");
}

func_7736(param_00) {
  while(!isDefined(level.current_interaction_structs)) {
    wait(1);
  }

  thread func_7758(param_00);
  var_01 = param_00.script_parameters;
  var_02 = strtok(var_01, ",");
  foreach(var_04 in var_02) {
    if(var_04 == "power_all") {
      scripts\engine\utility::flag_clear("power_on");
      continue;
    }

    if(scripts\engine\utility::flag_exist(var_04 + " power_on")) {
      scripts\engine\utility::flag_clear(var_04 + " power_on");
    }
  }

  param_00.powered_on = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

func_7758(param_00) {
  if(param_00.handle.script_noteworthy == "roll") {
    param_00.handle rotateroll(-60, 0.5);
  } else if(param_00.handle.script_noteworthy == "-roll") {
    param_00.handle rotateroll(60, 0.5);
  } else if(param_00.handle.script_noteworthy == "pitch") {
    param_00.handle rotatepitch(-60, 0.5);
  } else if(param_00.handle.script_noteworthy == "-pitch") {
    param_00.handle rotatepitch(60, 0.5);
  }

  if(isDefined(param_00.var_7735)) {
    param_00.var_7735 delete();
  }
}

func_129A2(param_00) {
  scripts\cp\zombies\zombie_analytics::func_AF8E(param_00, level.wave_num);
}

generic_generator(param_00, param_01) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(isDefined(param_01)) {
    param_01 thread scripts\cp\utility::firegesturegrenade(param_01, "iw7_powerlever_zm");
  }

  if(!isDefined(param_01)) {
    param_01 = level.players[0];
  }

  if(isDefined(param_00.target)) {
    func_7759(param_00, param_01);
  }

  var_02 = param_00.script_parameters;
  var_03 = strtok(var_02, ",");
  func_129A2(var_03[0]);
  level notify("power_on_scriptable_and_light", var_02, param_01);
  wait(2.5);
  foreach(var_05 in var_03) {
    if(!isDefined(var_05)) {}

    if(var_05 == "power_all") {
      level notify("power_on");
      scripts\engine\utility::flag_set("power_on");
      level.var_D746 = 1;
      continue;
    }

    level notify(var_05 + " power_on");
    if(scripts\engine\utility::flag_exist(var_05 + " power_on")) {
      scripts\engine\utility::flag_set(var_05 + " power_on");
    }
  }

  scripts\engine\utility::waitframe();
  level notify("activate_power");
  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_power", "zmb_comment_vo", "medium", 4, 0, 0, 0, 50);
    if(isDefined(level.power_vo_func)) {
      thread[[level.power_vo_func]](param_01);
    }
  }

  wait(0.5);
  level thread func_DE6F();
}

func_DE6F() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01.last_interaction_point) && isDefined(var_01.last_interaction_point.requires_power)) {
      var_01 notify("stop_interaction_logic");
      var_01.interaction_trigger makeunusable();
      var_01.last_interaction_point = undefined;
    }

    wait(0.05);
  }
}

func_7759(param_00, param_01) {
  level endon("power_off");
  wait(0.2);
  if(param_00.handle.script_noteworthy == "roll") {
    param_00.handle rotateroll(75, 0.15);
  } else if(param_00.handle.script_noteworthy == "-roll") {
    param_00.handle rotateroll(-75, 0.15);
  } else if(param_00.handle.script_noteworthy == "pitch") {
    param_00.handle rotatepitch(75, 0.15);
  } else if(param_00.handle.script_noteworthy == "-pitch") {
    param_00.handle rotatepitch(-75, 0.15);
  }

  if(isDefined(param_00.var_2F12)) {
    param_00.var_2F12 setscriptablepartstate("box", "on");
  }

  param_00.powered_on = 1;
}

register_interactions() {
  level.interaction_hintstrings["generator"] = &"COOP_INTERACTIONS_GENERATOR_ON";
  scripts\cp\cp_interaction::register_interaction("generator", "generator", 1, undefined, ::generic_generator, 0);
}