/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_lighting.gsc
*********************************************************/

main() {
  _id_84F8();

  if(level._id_01D4 && getDvar("2695") != "true")
    xbox_optimizations();

  level thread maps\mp\_utility::_id_6F74(::onplayerspawned);
  thread set_anchor_pulse_lights_off();
  thread set_airship_corrupsing_spark_off();
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
  setDvar("2225", 8);
  setDvar("sm_spotDynamics", 8);
}

onplayerspawned() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 0.5;
  var_0 digitaldistortsetparams(1, 0.25, 1, 1, 0);
  var_0 setclutforplayer("clut_zombie_berlin", 0.1);
}

set_default_scriptable_state() {
  var_0 = getEntArray("script_default_shadow_on", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "on");
  }
}

set_dagger_step03_light() {
  maps\mp\_utility::_id_5C98("dagger_step03_light", 1, 3000);
}

set_anchor_lights() {
  var_0 = _getscriptablearray("anchor_light_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "on", 0);
}

set_anchor_pulse_lights_off() {
  var_0 = _getscriptablearray("anchor_light_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("part_pulse_switch", "off", 0);
}

set_anchor_pulse_lights_on() {
  var_0 = _getscriptablearray("anchor_light_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("part_pulse_switch", "on", 0);
}

set_anchor_fast_pulse_lights() {
  var_0 = _getscriptablearray("anchor_light_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("part_pulse_switch", "pulse_fast", 0);
}

set_anchor_slow_pulse_lights() {
  var_0 = _getscriptablearray("anchor_light_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("part_pulse_switch", "pulse_slow", 0);
}

straub_death_start_lights() {
  var_0 = _getscriptablearray("straub_lights_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("light_straub", "color_change_init", 0);
}

straub_death_start_02_lights() {
  var_0 = _getscriptablearray("straub_lights_02_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("light_straub", "color_change_init", 0);
}

straub_death_kill_lights() {
  wait 21;
  var_0 = _getscriptablearray("straub_lights_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("light_straub", "off", 0);
}

straub_death_kill_fill_lights() {
  wait 21;
  var_0 = _getscriptablearray("straub_fill_lights_scriptable", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("light_straub", "off", 0);
}

airship_alarm_lights() {
  wait 21;
  var_0 = _getscriptablearray("airship_alarm_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "pulse", 0);

  var_4 = _getscriptablearray("airship_corrupsing_sparks", "targetname");

  foreach(var_6 in var_4)
  var_6 setscriptablepartstate("part_spark", "flicker_on_1", 0);
}

airship_lowering_light_intensity_control(var_0) {
  var_1 = _getscriptablearray("airship_fill_control", "targetname");

  foreach(var_3 in var_1)
  var_3 setscriptablepartstate("lightpart", var_0, 0);
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
  var_0 = _getscriptablearray("airship_corrupsing_sparks", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("part_spark", "initial_off", 0);
}