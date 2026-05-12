/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_lighting.gsc
*************************************************/

func_00F9() {
  func_84F8();
  if(level.var_1D4 && getDvar("2695") != "true") {
    xbox_optimizations();
  }

  level thread maps\mp\_utility::func_6F74(::func_6B82);
  thread set_anchor_pulse_lights_off();
  thread set_airship_corrupsing_spark_off();
}

func_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
  setDvar("2225", 8);
  setDvar("sm_spotDynamics", 8);
}

func_6B82() {
  var_00 = self;
  var_00 endon("disconnect");
  wait(0.5);
  var_00 vignettesetparams(1, 0.25, 1, 1, 0);
  var_00 setclutforplayer("clut_zombie_berlin", 0.1);
}

set_default_scriptable_state() {
  var_00 = getEntArray("script_default_shadow_on", "targetname");
  foreach(var_02 in var_00) {
    wait(0.1);
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

set_dagger_step03_light() {
  maps\mp\_utility::func_5C98("dagger_step03_light", 1, 3000);
}

set_anchor_lights() {
  var_00 = function_021F("anchor_light_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on", 0);
  }
}

set_anchor_pulse_lights_off() {
  var_00 = function_021F("anchor_light_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("part_pulse_switch", "off", 0);
  }
}

set_anchor_pulse_lights_on() {
  var_00 = function_021F("anchor_light_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("part_pulse_switch", "on", 0);
  }
}

set_anchor_fast_pulse_lights() {
  var_00 = function_021F("anchor_light_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("part_pulse_switch", "pulse_fast", 0);
  }
}

set_anchor_slow_pulse_lights() {
  var_00 = function_021F("anchor_light_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("part_pulse_switch", "pulse_slow", 0);
  }
}

straub_death_start_lights() {
  var_00 = function_021F("straub_lights_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("light_straub", "color_change_init", 0);
  }
}

straub_death_start_02_lights() {
  var_00 = function_021F("straub_lights_02_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("light_straub", "color_change_init", 0);
  }
}

straub_death_kill_lights() {
  wait(21);
  var_00 = function_021F("straub_lights_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("light_straub", "off", 0);
  }
}

straub_death_kill_fill_lights() {
  wait(21);
  var_00 = function_021F("straub_fill_lights_scriptable", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("light_straub", "off", 0);
  }
}

airship_alarm_lights() {
  wait(21);
  var_00 = function_021F("airship_alarm_lights", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "pulse", 0);
  }

  var_04 = function_021F("airship_corrupsing_sparks", "targetname");
  foreach(var_06 in var_04) {
    var_06 setscriptablepartstate("part_spark", "flicker_on_1", 0);
  }
}

airship_lowering_light_intensity_control(param_00) {
  var_01 = function_021F("airship_fill_control", "targetname");
  foreach(var_03 in var_01) {
    var_03 setscriptablepartstate("lightpart", param_00, 0);
  }
}

xbox_optimizations() {
  setDvar("1578", 0);
  setDvar("5156", 0);
  setDvar("3158", 0.7);
  setDvar("2225", 4);
  setDvar("sm_spotDynamics", 4);
}

neo_optimizations() {
  setDvar("1578", 1);
  setDvar("5156", 1);
}

set_airship_corrupsing_spark_off() {
  var_00 = function_021F("airship_corrupsing_sparks", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("part_spark", "initial_off", 0);
  }
}