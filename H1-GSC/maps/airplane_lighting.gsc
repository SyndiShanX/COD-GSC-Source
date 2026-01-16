/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\airplane_lighting.gsc
********************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread toggle_breach_lightset_triggers();
  thread override_scriptmodel_lightorigins();
  thread handle_shield_dof();
  thread handle_jump_dof();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("airplane", 0);
  level.player maps\_utility::set_light_set_player("airplane");
  level.player setclutforplayer("airplane", 0.0);
}

toggle_breach_lightset_triggers() {
  if(getdvar("beautiful_corner") == "1") {
    return;
  }
  var_0 = getent("breach_blowout_trig", "targetname");
  var_1 = getent("breach_aftermath_trig", "targetname");
  var_2 = getent("breach_aftermath2_trig", "targetname");
  var_0 common_scripts\utility::trigger_off();
  var_1 common_scripts\utility::trigger_off();
  var_2 common_scripts\utility::trigger_off();
  level waittill("fuselage_breached");
  var_0 common_scripts\utility::trigger_on();
  wait 0.8;
  var_0 common_scripts\utility::trigger_off();
  var_1 common_scripts\utility::trigger_on();

  if(level.player istouching(var_1))
    wait 0.3;

  var_1 common_scripts\utility::trigger_off();
  var_2 common_scripts\utility::trigger_on();
}

handle_shield_dof() {
  wait 0.05;
  common_scripts\utility::flag_wait("player_approach_human_shield");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(3.2, 400, 5, 1) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
}

handle_jump_dof() {
  wait 0.05;
  common_scripts\utility::flag_wait("exit_door_blown");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(2, 600, 5, 1) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  var_0 = getent("trig_exit_door", "targetname");
  var_0 waittill("trigger");
  var_1 = getent("plane_shell", "targetname");
  var_2 = maps\_cinematography::cinematic_sequence("freefall");
  var_2 maps\_cinematography::cinseq_key("moving_out_door") maps\_cinematography::cinseq_key_time(0) maps\_cinematography::cinseq_key_dyndof_values("main", 1.6, 80, 10, 3);
  var_2 maps\_cinematography::cinseq_key("out_door") maps\_cinematography::cinseq_key_time(1) maps\_cinematography::cinseq_key_dyndof_values("main", 1.6, 200, 10, 3);
  var_2 maps\_cinematography::cinseq_key("over_wing") maps\_cinematography::cinseq_key_time(2) maps\_cinematography::cinseq_key_dyndof_values("main", 1.2, 150, 10, 3);
  var_2 maps\_cinematography::cinseq_key("focus_plane") maps\_cinematography::cinseq_key_time(3) maps\_cinematography::cinseq_key_dyndof_values("main", 1.6, -1, 10, 3) maps\_cinematography::cinseq_key_dyndof_ref_ent("main", var_1) maps\_cinematography::cinseq_key_lerp_fov(60, 3);
  var_2 maps\_cinematography::cinseq_start_sequence();
}

override_scriptmodel_lightorigins() {
  common_scripts\utility::run_thread_on_noteworthy("override_light_origin", ::set_new_lighting_origin);
  var_0 = getent("door_light_origin_override", "script_noteworthy");

  if(isdefined(var_0)) {
    var_1 = getent("right_door_model", "script_noteworthy");
    var_2 = getent("left_door_model", "script_noteworthy");
    var_3 = [var_1, var_2];

    foreach(var_5 in var_3) {
      if(isdefined(var_5))
        var_5 overridelightingorigin(var_0.origin);
    }
  }
}

set_new_lighting_origin() {
  if(isdefined(self.target) && self.target != "") {
    var_0 = getent(self.target, "targetname");

    if(isdefined(var_0))
      self overridelightingorigin(var_0.origin);
  }
}