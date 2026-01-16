/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\scoutsniper_lighting.gsc
*****************************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread handle_church_explosion();
  level.default_clut = "clut_scoutsniper";
  level.default_lightset = "scoutsniper";
  level.default_visionset = "scoutsniper";
  thread handle_intro_cinematics();
  thread handle_ghillie_wibble();
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("scoutsniper", 0);
  level.player maps\_utility::set_light_set_player("scoutsniper");
  level.player setclutforplayer("clut_scoutsniper", 0.0);
  setsaveddvar("sm_sunShadowScale", "0.7");
}

handle_ghillie_wibble() {
  var_0 = 0.5;
  var_1 = 1;
  setshaderconstant(0, "x", var_0);
  setshaderconstant(0, "y", var_1);
}

handle_intro_cinematics() {
  common_scripts\utility::flag_wait("intro");

  if(getdvarint("scoutsniper_use_pre_h1_intro") == 1) {
    intro_blur_pre_h1();
    return;
  }

  wait 1;
  var_0 = maps\_cinematography::cinematic_sequence("intro");
  var_0 maps\_cinematography::cinseq_key("init") maps\_cinematography::cinseq_key_time(0) maps\_cinematography::cinseq_key_dyndof_values("main", 0.2, 10, 1, 0.2) maps\_cinematography::cinseq_key_lerp_fov(63, 0) maps\_cinematography::cinseq_key_start_dynamic_dof(1);
  var_0 maps\_cinematography::cinseq_key("resolve_in") maps\_cinematography::cinseq_key_time(3.5) maps\_cinematography::cinseq_key_dyndof_values("main", 1.2, 50, 2, 0.1) maps\_cinematography::cinseq_key_lerp_fov(63.5, 2);
  var_0 maps\_cinematography::cinseq_key("fast_lerp") maps\_cinematography::cinseq_key_time(5.5) maps\_cinematography::cinseq_key_dyndof_values("main", 3.2, 100, 0.6, 0.5) maps\_cinematography::cinseq_key_lerp_fov(64.5, 3);
  var_0 maps\_cinematography::cinseq_key("focus_out_to_scene") maps\_cinematography::cinseq_key_time(7.5) maps\_cinematography::cinseq_key_dyndof_values("main", 5, 300, 2, 1) maps\_cinematography::cinseq_key_lerp_fov_default(4);
  var_0 maps\_cinematography::cinseq_key("remove_dof") maps\_cinematography::cinseq_key_time(10) maps\_cinematography::cinseq_key_dyndof_values("main", 32, 600, 1, 2);
  var_0 maps\_cinematography::cinseq_key("end") maps\_cinematography::cinseq_key_time(13) maps\_cinematography::cinseq_key_remove_dyndof("main") maps\_cinematography::cinseq_key_end_dynamic_dof();
  var_0 maps\_cinematography::cinseq_start_sequence();
}

intro_blur_pre_h1() {
  maps\_utility::delaythread(1, maps\_utility::set_blur, 4.8, 0.25);
  maps\_utility::delaythread(4, maps\_utility::set_blur, 0, 3);
}

handle_church_explosion() {
  for (;;) {
    level waittill("church_explosion_player_screen_fx");
    level.player shellshock("scoutsniper_church_explo", 3);
  }
}