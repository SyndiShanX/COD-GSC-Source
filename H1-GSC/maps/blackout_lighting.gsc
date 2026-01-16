/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\blackout_lighting.gsc
********************************/

main() {
  set_level_lighting_values();
  init_level_lighting_flags();
  level.cheat_highcontrast_override = "_night";
  thread setup_fade_angle_lights();
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread blackout_vision_adjustment();
  thread handle_blackout_spotlights_off();
  thread handle_blackout_upstairs_spotlight();
  thread handle_start_swamp_fog();
  thread handle_exfil_heli_cinematic();
  thread setup_flickerlight_motion_presets();
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_dim", "firelight_dim");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium", "firelight_medium");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_bright", "firelight_bright");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_verybright", "firelight_verybright");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_ridonculous", "firelight_ridonculous");
  level.nightvisionlightset = "nightvision_blackout";
  visionsetnight("blackout_nightvision");
}

init_level_lighting_flags() {
  common_scripts\utility::flag_init("turn_off_blackout_spotlights");
  common_scripts\utility::flag_init("blackout_upstairs_spotlight_turn_on");
  common_scripts\utility::flag_init("start_swamp_fog");
}

setup_dof_presets() {}

set_level_lighting_values() {
  setsaveddvar("sm_minSpotLightScore", "0.0001");
  maps\_utility::vision_set_fog_changes("blackout_swamp_1", 0);
  level.player maps\_utility::set_light_set_player("blackout_swamp_1");
  level.player setclutforplayer("clut_blackout", 0.0);
  enableouterspacemodellighting((10000, 10000, 10000), (0.00158008, 0.00158008, 0.00158008));
}

setup_fade_angle_lights() {
  var_0 = getentarray("fade_angle_light", "targetname");

  foreach(var_2 in var_0)
  var_2 thread update_fade_angle_lights();
}

update_fade_angle_lights() {
  var_0 = 45.0;
  var_1 = 135.0;
  var_2 = 10000.0;

  if(isdefined(self.script_noteworthy)) {
    var_3 = strtok(self.script_noteworthy, " ");

    if(isdefined(var_3[0]))
      var_0 = float(var_3[0]);

    if(isdefined(var_3[1]))
      var_1 = float(var_3[1]);

    if(isdefined(var_3[2]))
      var_2 = float(var_3[2]);
  }

  var_4 = var_0 / 180.0;
  var_5 = var_1 / 180.0;
  var_6 = (var_1 - var_0) / 180.0;
  var_7 = anglestoforward(self.angles);
  var_8 = vectornormalize((var_7[0], var_7[1], 0.0));

  for (;;) {
    var_9 = level.player.origin - (self.origin + var_7 * self.radius * 0.75);
    var_9 = vectornormalize((var_9[0], var_9[1], 0.0));
    var_10 = vectordot(var_8, var_9);
    var_11 = (clamp((var_10 + 1.0) * 0.5, var_4, var_5) - var_4) / var_6;
    self setlightintensity(var_2 * var_11);
    wait 0.05;
  }
}

handle_start_swamp_fog() {
  common_scripts\utility::flag_wait("start_swamp_fog");
}

handle_overlook_attack_cinematics() {
  wait 0.05;
  common_scripts\utility::flag_wait("ready_to_commence_attack");
  var_0 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_0.pitch_scale = 1.5;
  var_0.roll_scale = 1.3;
  var_0.duration = 1;
  var_0.duration_fade_up = 0;
  var_0.duration_fade_down = 0.3;
  var_0.frequency_pitch = 13;
  var_0.frequency_roll = 13;
  var_1 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_1.pitch_scale = 1.6;
  var_1.roll_scale = 1.5;
  var_1.duration = 0.9;
  var_1.duration_fade_up = 0;
  var_1.duration_fade_down = 0.2;
  var_1.frequency_pitch = 12;
  var_1.frequency_roll = 14;
  var_2 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_2.pitch_scale = 0.4;
  var_2.roll_scale = 0.6;
  var_2.duration = 0.5;
  var_2.duration_fade_up = 0;
  var_2.duration_fade_down = 0.3;
  var_2.frequency_pitch = 7;
  var_2.frequency_roll = 6;
  wait 2.5;
  var_3 = maps\_cinematography::cinematic_sequence("mortars");
  var_3 maps\_cinematography::cinseq_key("initial_explosion") maps\_cinematography::cinseq_key_time(6.8) maps\_cinematography::cinseq_key_screen_shake(var_2);
  var_3 maps\_cinematography::cinseq_key("major_explosion") maps\_cinematography::cinseq_key_time(7.8) maps\_cinematography::cinseq_key_screen_shake(var_1);
  var_3 maps\_cinematography::cinseq_key("cliff_rocket") maps\_cinematography::cinseq_key_time(12.8) maps\_cinematography::cinseq_key_screen_shake(var_0);
  var_3 maps\_cinematography::cinseq_start_sequence();
  common_scripts\utility::flag_wait("first_bmp_destroyed");
  var_4 = maps\_cinematography::cinematic_sequence("bmp_destroyed");
  var_4 maps\_cinematography::cinseq_key("MLRS_destruction_1") maps\_cinematography::cinseq_key_time(0) maps\_cinematography::cinseq_key_screen_shake(var_1);
  var_4 maps\_cinematography::cinseq_key("MLRS_destruction_2") maps\_cinematography::cinseq_key_time(1.5) maps\_cinematography::cinseq_key_screen_shake(var_1);
  var_4 maps\_cinematography::cinseq_start_sequence();
}

blackout_vision_adjustment() {
  wait 0.05;

  for (;;) {
    common_scripts\utility::flag_wait("player_in_house");
    thread maps\_utility::set_vision_set("blackout_darkness", 0.5);
    level.player maps\_utility::set_light_set_player("safehouse_interior");
    common_scripts\utility::flag_waitopen("player_in_house");
    thread maps\_utility::set_vision_set("blackout_village", 0.5);
    level.player maps\_utility::set_light_set_player("blackout");
  }
}

handle_exfil_heli_cinematic() {
  wait 0.05;
  common_scripts\utility::flag_wait("player_gets_on_heli");
  maps\_cinematography::dyndof("price") maps\_cinematography::dyndof_values(4.8, 40, 5, 1) maps\_cinematography::dyndof_angles(-35, 35) maps\_cinematography::dyndof_reference_entity(level.price) maps\_cinematography::dyndof_tag_name("tag_eye");
  maps\_cinematography::dyndof("nikolai") maps\_cinematography::dyndof_values(3.2, 90, 5, 1) maps\_cinematography::dyndof_angles(-25, 25) maps\_cinematography::dyndof_reference_entity(level.vip) maps\_cinematography::dyndof_tag_name("tag_eye");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(2.4, 800, 5, 1) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  var_0 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_0.pitch_scale = 0.63;
  var_0.yaw_scale = 0.375;
  var_0.roll_scale = 0.35;
  var_0.duration = 7;
  var_0.duration_fade_up = 2;
  var_0.duration_fade_down = 4;
  var_0.frequency_pitch = 12;
  var_0.frequency_roll = 5;
  var_0.frequency_yaw = 8.5;
  var_1 = maps\_cinematography::cinematic_sequence("exfil");
  var_1 maps\_cinematography::cinseq_key("takeoff_shake") maps\_cinematography::cinseq_key_time(8.5) maps\_cinematography::cinseq_key_screen_shake(var_0);
  var_1 maps\_cinematography::cinseq_key("begin_looping_shake") maps\_cinematography::cinseq_key_time(15) maps\_cinematography::cinseq_key_add_custom_func("looping_shake", ::loop_camera_shake, level);
  var_1 maps\_cinematography::cinseq_key("blur_out") maps\_cinematography::cinseq_key_time(19.5) maps\_cinematography::cinseq_key_dyndof_values("main", 0.6, 20, 2, 1) maps\_cinematography::cinseq_key_remove_dyndof("price") maps\_cinematography::cinseq_key_remove_dyndof("nikolai");
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
  var_0[1].pitch_scale = 0.5;
  var_0[1].yaw_scale = 0.2;
  var_0[1].roll_scale = 0;
  var_0[1].duration = 2;
  var_0[1].duration_fade_up = 0.5;
  var_0[1].duration_fade_down = 0;
  var_0[1].frequency_pitch = 3.5;
  var_0[1].frequency_roll = 2;
  var_0[1].frequency_yaw = 0;

  for (;;) {
    var_1 = randomintrange(0, var_0.size);
    var_2 = var_0[var_1];
    level.player screenshakeonentity(var_2.pitch_scale, var_2.yaw_scale, var_2.roll_scale, var_2.duration, var_2.duration_fade_up, var_2.duration_fade_down, var_2.radius, var_2.frequency_pitch, var_2.frequency_roll, var_2.frequency_yaw, var_2.exponent);
    wait(var_0[var_1].duration - 0.5);
  }
}

handle_blackout_spotlights_off() {
  common_scripts\utility::flag_wait("turn_off_blackout_spotlights");
  var_0 = getentarray("blackout_spotlight", "targetname");
  common_scripts\utility::array_thread(var_0, maps\blackout_code::record_old_intensity);
  common_scripts\utility::array_thread(var_0, maps\_utility::_setlightintensity, 0);
  maps\_utility::disable_oneshotfx_with_noteworthy("blackout_light_org");
}

handle_blackout_upstairs_spotlight() {
  common_scripts\utility::flag_wait("blackout_upstairs_spotlight_turn_on");
  var_0 = getent("blackout_upstairs_spotlight", "script_noteworthy");
  var_0 setlightintensity(var_0.old_intensity);
}

setup_flickerlight_motion_presets() {
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_dim", (0.86, 0.5, 0.15), 10, 12, 0.15, 0.75);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium", (1, 0.75, 0.35), 35, 12, 0.15, 0.75);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_bright", (0.86, 0.5, 0.15), 80, 20, 0.2, 1.0);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_verybright", (0.86, 0.5, 0.15), 200, 30, 0.6, 1.5);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_ridonculous", (0.86, 0.5, 0.15), 4000, 40, 1, 2.5);
}