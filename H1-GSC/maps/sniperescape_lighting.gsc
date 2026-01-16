/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\sniperescape_lighting.gsc
******************************************/

main() {
  init_level_lighting_flags();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  level.cheat_invert_override = "_bright";
  level.default_clut = "clut_sniperescape";
  level.default_lightset = "sniperescape";
  level.default_visionset = "sniperescape";
  thread handle_player_on_sniper_rifle();
  thread handle_player_rappel_init();
  thread handle_helicopter_extraction();
  thread handle_enemy_helicopter_crash();
  level.default_clut = "clut_sniperescape";
  level.default_lightset = "sniperescape";
  level.default_visionset = "sniperescape";
}

init_level_lighting_flags() {}

setup_dof_presets() {}

set_level_lighting_values() {
  maps\_utility::vision_set_fog_changes("sniperescape", 0);
  level.player maps\_utility::set_light_set_player("sniperescape");
  level.player setclutforplayer("clut_sniperescape", 1.0);
}

handle_player_on_sniper_rifle() {
  wait 0.05;
  common_scripts\utility::flag_wait("player_is_on_turret");
  setsaveddvar("sv_znear", "100");
  setsaveddvar("sm_sunShadowCenter", getent("blood_pool", "targetname").origin);
  var_0 = getentarray("zakhaev_light", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightshadowstate("force_on");

  level.player maps\_utility::set_light_set_player("sniperescape_scope");
  maps\_utility::vision_set_fog_changes("sniperescape_scope", 2);
  common_scripts\utility::flag_wait("player_gets_off_turret");
  setsaveddvar("sv_znear", "1.0");
  setsaveddvar("sm_sunShadowCenter", (0, 0, 0));
  var_0 = getentarray("zakhaev_light", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightshadowstate("normal");

  level.player maps\_utility::set_light_set_player("sniperescape");
  maps\_utility::vision_set_fog_changes("sniperescape", 2);
}

handle_player_rappel_init() {
  wait 0.05;
  common_scripts\utility::flag_wait("player_can_rappel");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(4.5, -1, 5, 2) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  common_scripts\utility::flag_wait("player_rappels");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_autofocus(0) maps\_cinematography::dyndof_values(4.5, 20, 5, 2);
  var_0 = getnode("player_rappel_node", "targetname");
  var_1 = maps\_cinematography::cinematic_sequence("rappel_sequence");
  var_1 maps\_cinematography::cinseq_key("begin_rappel") maps\_cinematography::cinseq_key_time(0) maps\_cinematography::cinseq_key_dyndof_values("main", 2.4, 25, 2, 1) maps\_cinematography::cinseq_key_lerp_fov(50, 1.6);
  var_1 maps\_cinematography::cinseq_key("look_to_city") maps\_cinematography::cinseq_key_time(0.2) maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, 3000, 40, 2);
  var_1 maps\_cinematography::cinseq_key("back_to_rope") maps\_cinematography::cinseq_key_time(0.8) maps\_cinematography::cinseq_key_dyndof_values("main", 2.4, 25, 40, 2);
  var_1 maps\_cinematography::cinseq_key("back_to_city") maps\_cinematography::cinseq_key_time(1) maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, 2000, 40, 2);
  var_1 maps\_cinematography::cinseq_key("turn_to_window_center") maps\_cinematography::cinseq_key_time(1.3) maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, 17, 40, 1);
  var_1 maps\_cinematography::cinseq_key("look_at_macmillan") maps\_cinematography::cinseq_key_time(1.9) maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, 30, 3, 1) maps\_cinematography::cinseq_key_lerp_fov(60, 0.4);
  var_2 = var_1 maps\_cinematography::cinseq_key("turn_to_building") maps\_cinematography::cinseq_key_time(3.3) maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, 250, 3, 1);
  var_2 = var_1 maps\_cinematography::cinseq_key("just_before_explosion") maps\_cinematography::cinseq_key_time(4.2) maps\_cinematography::cinseq_key_dyndof_values("main", 1.8, -1, 3, 1) maps\_cinematography::cinseq_key_lerp_fov(55, 0.7);
  var_2 maps\_cinematography::cinseq_key_dyndof_ref_ent("main", var_0) maps\_cinematography::cinseq_key_dyndof_offset("main", 60);
  var_1 maps\_cinematography::cinseq_key("explosion") maps\_cinematography::cinseq_key_time(4.75) maps\_cinematography::cinseq_key_dyndof_values("main", 2.4, -1, 10, 2) maps\_cinematography::cinseq_key_lerp_fov(40, 0.3) maps\_cinematography::cinseq_key_set_slowmo(0.1, 0.5);
  var_2 = var_1 maps\_cinematography::cinseq_key("explosion_end") maps\_cinematography::cinseq_key_time(5.1) maps\_cinematography::cinseq_key_lerp_fov(47, 0.5);
  var_2 maps\_cinematography::cinseq_key_dyndof_ref_ent("main", level.price) maps\_cinematography::cinseq_key_dyndof_offset("main", 0) maps\_cinematography::cinseq_key_remove_slowmo(0.5);
  var_2 = var_1 maps\_cinematography::cinseq_key("look_at_hand") maps\_cinematography::cinseq_key_time(5.7) maps\_cinematography::cinseq_key_dyndof_values("main", 1.6, 16, 4, 1);
  var_2 = var_1 maps\_cinematography::cinseq_key("midway_to_ground") maps\_cinematography::cinseq_key_time(6.2) maps\_cinematography::cinseq_key_dyndof_values("main", 1.4, -1, 3, 1) maps\_cinematography::cinseq_key_lerp_fov(60, 0.6);
  var_2 = var_1 maps\_cinematography::cinseq_key("close_to_ground") maps\_cinematography::cinseq_key_time(7.4) maps\_cinematography::cinseq_key_dyndof_values("main", 2, -1, 2, 0.5) maps\_cinematography::cinseq_key_lerp_fov_default(0.5);
  var_1 maps\_cinematography::cinseq_start_sequence();
  wait 1;
  maps\_cinematography::dyndof_system_end();
}

handle_enemy_helicopter_crash() {
  wait 0.05;
  common_scripts\utility::flag_wait("heli_shot_down");
  maps\_cinematography::dyndof("heli") maps\_cinematography::dyndof_values(3.2, -1, 3, 1) maps\_cinematography::dyndof_reference_entity(level.price_heli) maps\_cinematography::dyndof_angles(-45, 45);
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(16, 1000, 5, 2) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  var_0 = maps\_cinematography::cinematic_sequence("heli_crash");
  var_0 maps\_cinematography::cinseq_key("heli_hits_ground") maps\_cinematography::cinseq_key_time(10.8) maps\_cinematography::cinseq_key_dyndof_values("heli", 0.2, -1, 7, 2);
  var_0 maps\_cinematography::cinseq_key("heli_hits_ground_done") maps\_cinematography::cinseq_key_time(12) maps\_cinematography::cinseq_key_dyndof_values("heli", 0.8, -1, 1, 1);
  var_0 maps\_cinematography::cinseq_key("heli_slides_in") maps\_cinematography::cinseq_key_time(13) maps\_cinematography::cinseq_key_dyndof_values("heli", 1, -1, 2, 1);
  var_0 maps\_cinematography::cinseq_key("heli_slides_in_2") maps\_cinematography::cinseq_key_time(14) maps\_cinematography::cinseq_key_dyndof_values("heli", 1.4, -1, 4, 1);
  var_0 maps\_cinematography::cinseq_key("heli_slide_finish") maps\_cinematography::cinseq_key_time(15.5) maps\_cinematography::cinseq_key_dyndof_values("heli", 6, -1, 4, 1);
  var_0 maps\_cinematography::cinseq_start_sequence();
  maps\_cinematography::dyndof_system_clear_all();
  maps\_cinematography::dyndof_system_end();
}

handle_helicopter_extraction() {
  wait 0.05;
  common_scripts\utility::flag_wait("player_made_it_to_seaknight");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(3.2, 400, 1, 0.5) maps\_cinematography::dyndof_autofocus(1) maps\_cinematography::dyndof_view_model_fstop_scale(8);
  thread maps\_cinematography::dyndof_system_start(1);
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
  var_1 maps\_cinematography::cinseq_key("initial_dof") maps\_cinematography::cinseq_key_time(0) maps\_cinematography::cinseq_key_dyndof_values("macmillan", 1.8, 30, 2, 1) maps\_cinematography::cinseq_key_dyndof_priority("macmillan", 10);
  var_1 maps\_cinematography::cinseq_key("outdoors") maps\_cinematography::cinseq_key_time(2.5) maps\_cinematography::cinseq_key_remove_dyndof("macmillan");
  var_1 maps\_cinematography::cinseq_key("takeoff_shake") maps\_cinematography::cinseq_key_time(15) maps\_cinematography::cinseq_key_screen_shake(var_0);
  var_1 maps\_cinematography::cinseq_key("begin_looping_shake") maps\_cinematography::cinseq_key_time(20) maps\_cinematography::cinseq_key_add_custom_func("looping_shake", ::loop_camera_shake, level);
  var_1 maps\_cinematography::cinseq_key("blur_out") maps\_cinematography::cinseq_key_time(38) maps\_cinematography::cinseq_key_dyndof_values("main", 0.2, 10, 0.4, 0.1);
  var_1 maps\_cinematography::cinseq_start_sequence();
}

loop_camera_shake() {
  level endon("end_looping_heli_cam_shake");
  var_0 = [];
  var_0[0] = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_0[0].pitch_scale = 0.4;
  var_0[0].yaw_scale = 0.2;
  var_0[0].roll_scale = 0;
  var_0[0].duration = 3;
  var_0[0].duration_fade_up = 0;
  var_0[0].duration_fade_down = 0;
  var_0[0].frequency_pitch = 3;
  var_0[0].frequency_roll = 2;
  var_0[0].frequency_yaw = 0;
  var_0[1] = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_0[1].pitch_scale = 0.7;
  var_0[1].yaw_scale = 0.2;
  var_0[1].roll_scale = 0;
  var_0[1].duration = 2;
  var_0[1].duration_fade_up = 0.5;
  var_0[1].duration_fade_down = 0;
  var_0[1].frequency_pitch = 3;
  var_0[1].frequency_roll = 2;
  var_0[1].frequency_yaw = 0;

  for (;;) {
    var_1 = randomintrange(0, var_0.size);
    var_2 = var_0[var_1];
    level.player screenshakeonentity(var_2.pitch_scale, var_2.yaw_scale, var_2.roll_scale, var_2.duration, var_2.duration_fade_up, var_2.duration_fade_down, var_2.radius, var_2.frequency_pitch, var_2.frequency_roll, var_2.frequency_yaw, var_2.exponent);
    wait(var_0[var_1].duration - 0.5);
  }
}

begin_vision_blurs() {}

vision_glow_change() {
  common_scripts\utility::flag_set("stop_adjusting_vision");
  maps\_utility::set_vision_set("sniperescape_glow_off", 5);
  wait 10;
  maps\_utility::set_vision_set("sniperescape_outside", 5);
}

snipe_vision_adjust() {
  level endon("stop_adjusting_vision");

  if(1) {
    return;
  }
  for (;;) {
    common_scripts\utility::flag_wait("near_window");
    var_0 = 1.25;
    var_1 = 1.25;
    maps\_utility::set_vision_set("sniperescape_glow_off", var_0);
    common_scripts\utility::flag_waitopen_or_timeout("near_window", var_0);
    maps\_utility::set_vision_set("sniperescape_outside", var_1);
    common_scripts\utility::flag_waitopen_or_timeout("near_window", var_1);
    common_scripts\utility::flag_waitopen("near_window");
    var_0 = 0.25;
    var_1 = 1.25;
    maps\_utility::set_vision_set("sniperescape_glow_off", var_0);
    common_scripts\utility::flag_wait_or_timeout("near_window", var_0);
    maps\_utility::set_vision_set("sniperescape", var_1);
    common_scripts\utility::flag_wait_or_timeout("near_window", var_1);
  }
}