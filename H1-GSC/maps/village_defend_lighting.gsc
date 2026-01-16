/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\village_defend_lighting.gsc
********************************************/

main() {
  set_level_lighting_values();
  setup_church_lighting();
  init_level_lighting_flags();
  level.cheat_highcontrast_override = "_night";
  level.default_clut = "clut_village_defend";
  level.default_lightset = "village_defend";
  level.default_visionset = "village_defend";
  thread handle_player_on_chopper_cinematic();
}

init_level_lighting_flags() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("village_defend", 0);
  level.player maps\_utility::set_light_set_player("village_defend");
  level.player setclutforplayer("clut_village_defend", 0.0);
}

setup_church_lighting() {
  var_0 = getent("village_defend_church_light", "targetname");
  var_1 = getentarray("village_defend_church_models", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 overridelightingorigin(var_0.origin);
}

handle_player_on_chopper_cinematic() {
  wait 0.05;
  common_scripts\utility::flag_wait("seaknight_guards_boarding");
  var_0 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_0.pitch_scale = 0.9;
  var_0.yaw_scale = 0.5;
  var_0.roll_scale = 0.2;
  var_0.duration = 7;
  var_0.duration_fade_up = 2;
  var_0.duration_fade_down = 4;
  var_0.frequency_pitch = 10;
  var_0.frequency_roll = 4;
  var_0.frequency_yaw = 2;
  var_1 = maps\_cinematography::cinematic_sequence("heli_exfil");
  var_1 maps\_cinematography::cinseq_key("takeoff_shake") maps\_cinematography::cinseq_key_time(10) maps\_cinematography::cinseq_key_screen_shake(var_0);
  var_1 maps\_cinematography::cinseq_key("begin_dof") maps\_cinematography::cinseq_key_time(10.5) maps\_cinematography::cinseq_key_dyndof_values("main", 3.2, 400, 2, 0.5) maps\_cinematography::cinseq_key_start_dynamic_dof(1);
  var_1 maps\_cinematography::cinseq_key("finalize_blur_out") maps\_cinematography::cinseq_key_time(17.5) maps\_cinematography::cinseq_key_dyndof_values("main", 0.2, 75, 0.1, 0.1);
  var_1 maps\_cinematography::cinseq_start_sequence();
}