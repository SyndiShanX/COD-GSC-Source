/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\hunted_lighting.gsc
********************************/

main() {
  precache_lighting_and_fx();
  init_level_lighting_flags();
  level.cheat_highcontrast_override = "_night";
  thread setup_dof_presets();
  thread set_level_lighting_values();
  thread setup_fade_angle_lights();

  if(getdvar("beautiful_corner") != "1") {
    thread handle_heli_flight_lighting_init();
    thread handle_heli_crash_lighting_init();
    thread handle_wakeup_done();
    thread handle_barn_lighting_init();
    thread handle_field_lighting_init();
    thread handle_farm_lighting_init();
    thread handle_creek_lighting_init();
    thread handle_ac130_lighting_init();
  }

  thread setup_lighting_pass_helicrash();
  thread setup_lighting_pass_interior();
  thread setup_flickerlight_motion_presets();
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_01", "heli_fire_01");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_02", "heli_fire_02");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_03", "heli_fire_03");
  thread maps\_lighting::play_flickerlight_motion_preset("firelight_motion_04", "heli_fire_04");
  thread maps\_lighting::play_flickerlight_motion_preset("fire_barrel_small_01", "barrel_01");
  thread maps\_lighting::play_flickerlight_motion_preset("fire_barrel_small_02", "barrel_02");
  thread maps\_lighting::play_flickerlight_motion_preset("fire_barrel_small_03", "dumpster_01");
}

precache_lighting_and_fx() {
  precacheshader("overlay_hunted_red");
  precacheshader("overlay_hunted_black");
  precacheshader("splatter_alt_sp");
  precacherumble("blackhawk_down_crash_rumble");
}

init_level_lighting_flags() {
  common_scripts\utility::flag_init("vision_barn_interior");
  common_scripts\utility::flag_init("lighting_player_exit_helicrash");
  common_scripts\utility::flag_init("lighting_player_entered_helicrash");
}

setup_dof_presets() {}

set_level_lighting_values() {
  setsaveddvar("r_specularcolorscale", "2.3");
  setsaveddvar("sm_sunShadowScale", "0.5");
  setsaveddvar("sm_minSpotLightScore", "0.0001");
  enableouterspacemodellighting((10000, 10000, 10000), (0.00158008, 0.00158008, 0.00158008));
  apply_lighting_pass_hunted_outside(0.0);
}

setup_fade_angle_lights() {
  var_0 = getentarray("fade_angle_light", "targetname");

  foreach(var_2 in var_0)
  var_2 thread update_fade_angle_lights();
}

update_fade_angle_lights() {
  var_0 = 45.0;
  var_1 = 135.0;

  if(isdefined(self.script_noteworthy)) {
    var_2 = strtok(self.script_noteworthy, "-");

    if(isdefined(var_2[0]))
      var_0 = float(var_2[0]);

    if(isdefined(var_2[1]))
      var_1 = float(var_2[1]);
  }

  var_3 = var_0 / 180.0;
  var_4 = var_1 / 180.0;
  var_5 = (var_1 - var_0) / 180.0;
  var_6 = anglestoforward(self.angles);
  var_7 = vectornormalize((var_6[0], var_6[1], 0.0));

  for (;;) {
    var_8 = level.player.origin - (self.origin + var_6 * self.radius * 0.75);
    var_8 = vectornormalize((var_8[0], var_8[1], 0.0));
    var_9 = vectordot(var_7, var_8);
    var_10 = (clamp((var_9 + 1.0) * 0.5, var_3, var_4) - var_3) / var_5;
    self setlightintensity(5000.0 * var_10);
    wait 0.05;
  }
}

handle_heli_flight_lighting_init() {
  common_scripts\utility::flag_wait("aa_flight");
  var_0 = getent("crash_blackhawk", "targetname");
  var_1 = var_0.last_spawned_vehicle.attachedguys;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    switch (var_1[var_2].classname) {
      case "actor_ally_hero_price_sas_woodland":
        var_3 = maps\_cinematography::dyndof("price");
        var_3 maps\_cinematography::dyndof_values(3.2, 25, 10, 5);
        var_3 maps\_cinematography::dyndof_angles(-30, 30);
        var_3 maps\_cinematography::dyndof_reference_entity(var_1[var_2]);
        var_3 maps\_cinematography::dyndof_tag_name("tag_eye");
        break;
      case "actor_ally_hero_gaz_sas_woodland":
        var_3 = maps\_cinematography::dyndof("gaz");
        var_3 maps\_cinematography::dyndof_values(3.2, 35, 2.3, 2);
        var_3 maps\_cinematography::dyndof_angles(-20, 20);
        var_3 maps\_cinematography::dyndof_reference_entity(var_1[var_2]);
        var_3 maps\_cinematography::dyndof_tag_name("tag_eye");
        break;
      case "actor_ally_vip":
        var_3 = maps\_cinematography::dyndof("nikolai");
        var_3 maps\_cinematography::dyndof_values(3.2, 47, 2.3, 2);
        var_3 maps\_cinematography::dyndof_angles(-20, 20);
        var_3 maps\_cinematography::dyndof_reference_entity(var_1[var_2]);
        var_3 maps\_cinematography::dyndof_tag_name("tag_eye");
        break;
      default:
        break;
    }
  }

  maps\_cinematography::dyndof("missile") maps\_cinematography::dyndof_values(1.5, 1400, 5, 4) maps\_cinematography::dyndof_angles(-180, 180);
  maps\_cinematography::dyndof("default") maps\_cinematography::dyndof_values(5, 35, 1.8, 2.3) maps\_cinematography::dyndof_angles(-180, 180);
  thread setup_missile_dof();
  maps\_cinematography::dyndof_system_start(1);
}

setup_missile_dof() {
  level waittill("missile_fired");
  maps\_cinematography::dyndof("missile") maps\_cinematography::dyndof_focus_distance(-1) maps\_cinematography::dyndof_angles(-50, 50) maps\_cinematography::dyndof_reference_entity(level.blackhawk_down_missile);
  var_0 = 6;
  wait(var_0);
  maps\_cinematography::dyndof_remove("price");
  maps\_cinematography::dyndof("missile") maps\_cinematography::dyndof_focus_distance(60);
  handle_flight_going_down();
}

handle_flight_going_down() {
  common_scripts\utility::flag_wait("blackhawk_hit");

  if(getdvarint("use_original_crash_view") == 1) {
    handle_flight_going_down_preh1();
    return;
  }

  var_0 = create_overlay_element("black", 0);
  var_1 = create_overlay_element("overlay_hunted_red", 0);
  var_1.sort = 0;
  var_0.sort = 1;
  maps\_cinematography::dyndof_system_clear_all();
  var_2 = create_crash_cinseq(var_0);
  var_2 thread maps\_cinematography::cinseq_start_sequence();
  common_scripts\utility::flag_wait("blackhawk_hit");
  thread common_scripts\_exploder::exploder(44);
  level.player playrumbleonentity("blackhawk_down_crash_rumble");
  common_scripts\utility::flag_wait("blackhawk_down");
  var_1 destroy();
  var_0 thread fade_overlay(0, 4);
}

handle_flight_going_down_preh1() {
  var_0 = create_overlay_element("black", 0);
  var_1 = create_overlay_element("overlay_hunted_red", 0);
  var_1.sort = 0;
  var_0.sort = 1;
  wait 4;
  var_1 thread exp_fade_overlay(1, 4.5);
  var_0 thread exp_fade_overlay(0.5, 4.5);
  wait 5.25;
  var_0 thread fade_overlay(1, 0.1);
  common_scripts\utility::flag_wait("blackhawk_down");
  var_1 destroy();
  var_0 thread fade_overlay(0, 4);
}

create_crash_cinseq(var_0) {
  var_1 = maps\_cinematography::cinematic_sequence("crash_blur_sequence");
  var_1 maps\_cinematography::cinseq_key("missile_explosion_slowmo") maps\_cinematography::cinseq_key_time(0.5) maps\_cinematography::cinseq_key_set_slowmo(0.3, 0.5);
  var_2 = var_1 maps\_cinematography::cinseq_key("remove_missile_explosion_slowmo") maps\_cinematography::cinseq_key_time(1.15) maps\_cinematography::cinseq_key_remove_slowmo(0.2);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("remove_slomo_mix", ::end_slomo_mix);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_start_key");
  var_2 maps\_cinematography::cinseq_key_time(0);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("fade_func", ::fade_overlay, var_0, 0.5, 7);
  var_3 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_3.duration = 3;
  var_3.duration_fade_down = 0.5;
  var_3.duration_fade_up = 0;
  var_3.pitch_scale = 5;
  var_3.roll_scale = 3;
  var_3.yaw_scale = 2;
  var_3.frequency_roll = 8;
  var_3.frequency_pitch = 11;
  var_3.frequency_yaw = 10;
  var_2 = var_1 maps\_cinematography::cinseq_key("wind_down_after_initial_explosion");
  var_2 maps\_cinematography::cinseq_key_time(0.5);
  var_2 maps\_cinematography::cinseq_key_screen_shake(var_3);
  var_3 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_3.duration = 0.75;
  var_3.duration_fade_down = 0.25;
  var_3.duration_fade_up = 0;
  var_3.pitch_scale = 8;
  var_3.roll_scale = 3;
  var_3.yaw_scale = 8;
  var_3.frequency_roll = 10;
  var_3.frequency_pitch = 15;
  var_3.frequency_yaw = 15;
  var_2 = var_1 maps\_cinematography::cinseq_key("missile_explosion");
  var_2 maps\_cinematography::cinseq_key_time(1);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 4, 40, 15, 10);
  var_2 maps\_cinematography::cinseq_key_screen_shake(var_3);
  var_3 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_3.duration = 5;
  var_3.duration_fade_down = 1;
  var_3.duration_fade_up = 4;
  var_3.pitch_scale = 5;
  var_3.roll_scale = 3;
  var_3.frequency_roll = 8;
  var_3.frequency_pitch = 12;
  var_2 = var_1 maps\_cinematography::cinseq_key("initial_explosion_shake");
  var_2 maps\_cinematography::cinseq_key_time(1);
  var_2 maps\_cinematography::cinseq_key_screen_shake(var_3);
  var_3 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_3.duration = 2.5;
  var_3.duration_fade_down = 0;
  var_3.duration_fade_up = 0.3;
  var_3.pitch_scale = 4;
  var_3.roll_scale = 3;
  var_3.frequency_roll = 11;
  var_3.frequency_pitch = 12;
  var_2 = var_1 maps\_cinematography::cinseq_key("first_blur");
  var_2 maps\_cinematography::cinseq_key_time(6);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 2.4, 1, 10, 10);
  var_2 maps\_cinematography::cinseq_key_screen_shake(var_3);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("fade_func", ::fade_overlay, var_0, 0.65, 1);
  var_2 = var_1 maps\_cinematography::cinseq_key("first_blur_away");
  var_2 maps\_cinematography::cinseq_key_time(6.5);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 6, 35, 5, 5);
  var_3 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_3.duration = 2.5;
  var_3.duration_fade_down = 1.5;
  var_3.duration_fade_up = 0;
  var_3.pitch_scale = 5;
  var_3.roll_scale = 3.5;
  var_3.frequency_roll = 8;
  var_3.frequency_pitch = 11;
  var_2 = var_1 maps\_cinematography::cinseq_key("blur_to_cover_terrain");
  var_2 maps\_cinematography::cinseq_key_time(7.5);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, 5, 2, 1);
  var_2 maps\_cinematography::cinseq_key_screen_shake(var_3);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("remove_terrain_mask", ::remove_crash_terrain_mask);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_back_in");
  var_2 maps\_cinematography::cinseq_key_time(8.2);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 5, 30, 4, 2);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("fade_back", ::fade_overlay, var_0, 0.6, 0.5);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_back_fully");
  var_2 maps\_cinematography::cinseq_key_time(8.7);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 4, 1, 3, 1);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("fade_backFully", ::fade_overlay, var_0, 0.1, 0.8);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_out_fully_first");
  var_2 maps\_cinematography::cinseq_key_time(9.5);
  var_2 maps\_cinematography::cinseq_key_add_custom_func("fade_out_fully_first", ::fade_overlay, var_0, 1, 0.001);
  var_2 = var_1 maps\_cinematography::cinseq_key("cleanup") maps\_cinematography::cinseq_key_time(11) maps\_cinematography::cinseq_key_end_dynamic_dof();
  return var_1;
}

remove_crash_terrain_mask() {
  var_0 = getent("crash_mask", "targetname");
  var_0 delete();
}

handle_heli_crash_lighting_init() {
  common_scripts\utility::flag_wait("aa_crash");
  thread handle_wakeup_overlay();
  set_specular_scale(1.7, 0);
  maps\_utility::set_vision_set("hunted", 0);
}

handle_wakeup_overlay() {
  thread common_scripts\_exploder::exploder(45);

  if(getdvarint("use_original_crash_view") == 1) {
    handle_wakeup_preh1();
    return;
  }

  var_0 = create_overlay_element("black", 1);
  var_1 = maps\_cinematography::cinematic_sequence("wakeup_from_crash");
  var_1 maps\_cinematography::cinseq_key("initial_fov") maps\_cinematography::cinseq_key_time(0) maps\_cinematography::cinseq_key_lerp_fov(45, 0);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_in_initial") maps\_cinematography::cinseq_key_time(2) maps\_cinematography::cinseq_key_add_custom_func("fade_in_initial", ::exp_fade_overlay, var_0, 0.25, 4);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 1.5, 20, 40, 20) maps\_cinematography::cinseq_key_start_dynamic_dof(1);
  var_2 maps\_cinematography::cinseq_key_lerp_fov(49, 3);
  var_2 = var_1 maps\_cinematography::cinseq_key("blur_in") maps\_cinematography::cinseq_key_time(5) maps\_cinematography::cinseq_key_dyndof_values("main", 3, -1, 1, 0.3);
  var_2 maps\_cinematography::cinseq_key_dyndof_ref_ent("main", level.price) maps\_cinematography::cinseq_key_dyndof_tag_name("main", "tag_eye");
  var_2 maps\_cinematography::cinseq_key_lerp_fov(50, 1.5);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_out") maps\_cinematography::cinseq_key_time(8) maps\_cinematography::cinseq_key_add_custom_func("fade_in_initial", ::exp_fade_overlay, var_0, 1, 2);
  var_2 maps\_cinematography::cinseq_key_dyndof_values("main", 2, 5, 0.2, 0.2);
  var_1 maps\_cinematography::cinseq_key("fade_out_fov") maps\_cinematography::cinseq_key_time(8.3);
  var_2 = var_1 maps\_cinematography::cinseq_key("fade_in_final") maps\_cinematography::cinseq_key_time(8.5) maps\_cinematography::cinseq_key_add_custom_func("fade_in_initial", ::exp_fade_overlay, var_0, 0, 3);
  var_2 = var_1 maps\_cinematography::cinseq_key("blur_in_final") maps\_cinematography::cinseq_key_time(9.5) maps\_cinematography::cinseq_key_dyndof_values("main", 2.4, -1, 0.5, 0.2);
  var_1 maps\_cinematography::cinseq_key("look_at_chopper_explode_fov") maps\_cinematography::cinseq_key_time(12.6) maps\_cinematography::cinseq_key_lerp_fov(48, 0.5);
  var_2 = var_1 maps\_cinematography::cinseq_key("look_at_chopper_explode") maps\_cinematography::cinseq_key_time(12.7) maps\_cinematography::cinseq_key_dyndof_values("main", 1.2, 100, 10, 5);
  var_2 = var_1 maps\_cinematography::cinseq_key("look_back_to_price") maps\_cinematography::cinseq_key_time(13.5) maps\_cinematography::cinseq_key_dyndof_values("main", 2.8, -1, 2, 5);
  var_2 maps\_cinematography::cinseq_key_lerp_fov(55, 1);
  var_2 = var_1 maps\_cinematography::cinseq_key("final_focus_on_price") maps\_cinematography::cinseq_key_time(17) maps\_cinematography::cinseq_key_dyndof_values("main", 2.4, -1, 2, 3);
  var_2 maps\_cinematography::cinseq_key_lerp_fov(62, 0.5);
  var_1 maps\_cinematography::cinseq_key("fov_to_default") maps\_cinematography::cinseq_key_time(18.8) maps\_cinematography::cinseq_key_lerp_fov_default(1);
  var_1 maps\_cinematography::cinseq_start_sequence();
  wait 2;
  maps\_cinematography::dyndof_system_end();
}

handle_wakeup_preh1() {
  var_0 = create_overlay_element("splatter_alt_sp", 0);
  var_1 = create_overlay_element("black", 1);
  wait 2;
  setblur(5, 0);
  var_1 thread exp_fade_overlay(0.25, 4);
  wait 1.5;
  wait 1.5;
  setblur(0, 2);
  wait 3;
  var_1 exp_fade_overlay(1, 2);
  wait 0.5;
  var_1 thread exp_fade_overlay(0, 3);
  wait 2;
  setblur(2.4, 1);
  wait 1;
  setblur(0, 2);
  wait 2;
  var_1 destroy();
  var_0 destroy();
}

handle_wakeup_done() {
  common_scripts\utility::flag_wait("wakeup_done");
  thread post_crash_flashlight_off();
  set_specular_scale(2.3, 1);
  level.player maps\_utility::set_light_set_player("heli_crash");
}

post_crash_flashlight_off() {
  var_0 = getent("post_crash_flashlight", "targetname");
  var_0 setlightintensity(0);
}

handle_barn_lighting_init() {
  common_scripts\utility::flag_wait("aa_barn");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(6, -1, 5, 2) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  thread handle_barn_combat_start();
  level waittill("barn_interrogation_start");
  var_0 = getent("farmer", "targetname");
  var_0 waittill("spawned", var_1);

  if(isdefined(var_1)) {
    var_2 = maps\_cinematography::dyndof("farmer") maps\_cinematography::dyndof_values(4, -1, 5, 4) maps\_cinematography::dyndof_angles(-25, 25) maps\_cinematography::dyndof_priority(2);
    var_2 maps\_cinematography::dyndof_reference_entity(var_1) maps\_cinematography::dyndof_offset((0, 0, 30)) maps\_cinematography::dyndof_require_visible(1);
  }
}

handle_barn_combat_start() {
  common_scripts\utility::flag_wait_any("player_interruption", "interrogation_done");
  maps\_cinematography::dyndof_system_end();
}

handle_field_lighting_init() {
  common_scripts\utility::flag_wait("aa_field");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(6, -1, 5, 2) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  thread handle_field_combat_start();
  common_scripts\utility::flag_wait("field_cover");
  wait 1;

  if(isdefined(level.helicopter)) {
    var_0 = maps\_cinematography::dyndof("heli") maps\_cinematography::dyndof_values(3.2, -1, 20, 5) maps\_cinematography::dyndof_angles(-20, 20) maps\_cinematography::dyndof_priority(2);
    var_0 maps\_cinematography::dyndof_reference_entity(level.helicopter);
  }
}

handle_field_combat_start() {
  common_scripts\utility::flag_wait_either("field_spoted", "field_truck");
  maps\_cinematography::dyndof_system_end();
}

handle_farm_lighting_init() {
  common_scripts\utility::flag_wait("aa_farm");
}

handle_creek_lighting_init() {
  common_scripts\utility::flag_wait("aa_creek");
}

handle_creek_combat_start() {}

handle_ac130_lighting_init() {
  common_scripts\utility::flag_wait("aa_ac130");
  maps\_cinematography::dyndof("main") maps\_cinematography::dyndof_values(6, -1, 5, 2) maps\_cinematography::dyndof_autofocus(1);
  thread maps\_cinematography::dyndof_system_start(1);
  common_scripts\utility::flag_wait("gasstation_start");
  wait 12;
  var_0 = getentarray("gasstation_truck", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.model == "vehicle_t72_tank") {
      var_1 = var_3.last_spawned_vehicle;
      break;
    }
  }

  if(isdefined(var_1)) {
    var_5 = maps\_cinematography::dyndof("ac130_explosions") maps\_cinematography::dyndof_values(4.5, -1, 5, 2) maps\_cinematography::dyndof_reference_entity(var_1);
    var_5 maps\_cinematography::dyndof_angles(-30, 30) maps\_cinematography::dyndof_priority(2) maps\_cinematography::dyndof_valid_range(40, 2700);
  }

  var_6 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_6.duration = 0.5;
  var_6.duration_fade_down = 0.3;
  var_6.pitch_scale = 0.7;
  var_6.roll_scale = 0.4;
  var_6.yaw_scale = 0.62;
  var_6.frequency_roll = 12;
  var_6.frequency_yaw = 15;
  var_6.frequency_pitch = 8;
  var_7 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_7.duration = 0.75;
  var_7.duration_fade_down = 0.4;
  var_7.pitch_scale = 1;
  var_7.roll_scale = 0.56;
  var_7.yaw_scale = 0.9;
  var_7.frequency_roll = 12;
  var_7.frequency_yaw = 15;
  var_7.frequency_pitch = 8;
  var_8 = maps\_cinematography::cinematic_sequence("ac130_barrage");
  var_8 maps\_cinematography::cinseq_key("first_hit") maps\_cinematography::cinseq_key_time(1) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_7);
  var_8 maps\_cinematography::cinseq_key("first_hit_away") maps\_cinematography::cinseq_key_time(1.2) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 4, 3.5);
  var_8 maps\_cinematography::cinseq_key("first_hit_mid") maps\_cinematography::cinseq_key_time(2) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 40, 20) maps\_cinematography::cinseq_key_screen_shake(var_6);
  var_8 maps\_cinematography::cinseq_key("first_hit_mid_away") maps\_cinematography::cinseq_key_time(2.2) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 4, 3.5);
  var_8 maps\_cinematography::cinseq_key("second_hit") maps\_cinematography::cinseq_key_time(2.55) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 40, 20) maps\_cinematography::cinseq_key_screen_shake(var_6);
  var_8 maps\_cinematography::cinseq_key("second_hit_away") maps\_cinematography::cinseq_key_time(2.65) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 4, 3.5);
  var_8 maps\_cinematography::cinseq_key("second_hit_mid") maps\_cinematography::cinseq_key_time(3.05) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_6);
  var_8 maps\_cinematography::cinseq_key("second_hit_mid_away") maps\_cinematography::cinseq_key_time(3.2) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 4, 3.5);
  var_8 maps\_cinematography::cinseq_key("third_hit") maps\_cinematography::cinseq_key_time(6.5) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_7);
  var_8 maps\_cinematography::cinseq_key("third_hit_away") maps\_cinematography::cinseq_key_time(6.7) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 8, 3.5);
  var_8 maps\_cinematography::cinseq_key("third_hit_mid") maps\_cinematography::cinseq_key_time(7) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_6);
  var_8 maps\_cinematography::cinseq_key("third_hit_mid_away") maps\_cinematography::cinseq_key_time(7.3) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 4, 3.5);
  var_8 maps\_cinematography::cinseq_key("fourth_hit") maps\_cinematography::cinseq_key_time(10.05) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_7);
  var_8 maps\_cinematography::cinseq_key("fourth_hit_away") maps\_cinematography::cinseq_key_time(10.3) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 3, 3.5);
  var_8 maps\_cinematography::cinseq_key("fifth_hit") maps\_cinematography::cinseq_key_time(12) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_7);
  var_8 maps\_cinematography::cinseq_key("fifth_hit_away") maps\_cinematography::cinseq_key_time(12.4) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 6, 3.5);
  var_8 maps\_cinematography::cinseq_key("sixth_hit") maps\_cinematography::cinseq_key_time(12.8) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_6);
  var_8 maps\_cinematography::cinseq_key("sixth_hit_away") maps\_cinematography::cinseq_key_time(13.1) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 4, 3.5);
  var_8 maps\_cinematography::cinseq_key("seventh_hit") maps\_cinematography::cinseq_key_time(15.05) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 0.2, -1, 20, 10) maps\_cinematography::cinseq_key_screen_shake(var_7);
  var_8 maps\_cinematography::cinseq_key("seventh_hit_away") maps\_cinematography::cinseq_key_time(15.5) maps\_cinematography::cinseq_key_dyndof_values("ac130_explosions", 4.5, -1, 3, 3.5);
  common_scripts\utility::flag_wait("ac130_barrage");
  var_8 maps\_cinematography::cinseq_start_sequence();
  maps\_cinematography::dyndof_remove("ac130_explosions");
}

create_overlay_element(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader(var_0, 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = var_1;
  var_2.foreground = 1;
  return var_2;
}

fade_overlay(var_0, var_1) {
  self fadeovertime(var_1);
  self.alpha = var_0;
  wait(var_1);
}

exp_fade_overlay(var_0, var_1) {
  var_2 = 4;
  var_3 = 90 / var_2;
  var_4 = 0;
  var_5 = var_1 / var_2;
  var_6 = self.alpha;
  var_7 = var_6 - var_0;

  for (var_8 = 0; var_8 < var_2; var_8++) {
    var_4 = var_4 + var_3;
    self fadeovertime(var_5);

    if(var_0 > var_6) {
      var_9 = 1 - cos(var_4);
      self.alpha = var_6 - var_7 * var_9;
    } else {
      var_9 = sin(var_4);
      self.alpha = var_6 - var_7 * var_9;
    }

    wait(var_5);
  }
}

set_specular_scale(var_0, var_1) {
  var_2 = getdvarfloat("r_specularcolorscale");

  if(!isdefined(var_1))
    var_1 = 0;

  var_3 = abs(int(var_1 * 4));
  var_4 = var_0 - var_2;

  for (var_5 = 0; var_5 < var_3; var_5++) {
    var_2 = var_2 + var_4 / var_3;
    setsaveddvar("r_specularcolorscale", var_2);
    wait 0.25;
  }

  setsaveddvar("r_specularcolorscale", var_0);
}

setup_visionset_trigger() {
  var_0 = spawnstruct();
  var_1 = getentarray("vision_trigger", "targetname");
  common_scripts\utility::array_thread(var_1, ::visionset_trigger, var_0);
}

visionset_trigger(var_0) {
  for (;;) {
    self waittill("trigger");
    var_0 notify("new_visionset");
    maps\_utility::set_vision_set(self.script_noteworthy, self.script_delay);
    var_0 waittill("new_visionset");
  }
}

setup_lighting_pass_helicrash() {
  for (;;) {
    common_scripts\utility::flag_wait("lighting_player_exit_helicrash");
    common_scripts\utility::flag_clear("lighting_player_entered_helicrash");
    apply_lighting_pass_hunted_outside();
    common_scripts\utility::flag_wait("lighting_player_entered_helicrash");
    common_scripts\utility::flag_clear("lighting_player_exit_helicrash");
    apply_lighting_pass_hunted_helicrash();
  }
}

setup_lighting_pass_interior() {
  for (;;) {
    common_scripts\utility::flag_wait("vision_barn_interior");
    apply_lighting_pass_hunted_inside();
    common_scripts\utility::flag_waitopen("vision_barn_interior");
    apply_lighting_pass_hunted_outside();
  }
}

apply_lighting_pass_hunted_outside(var_0) {
  if(!isdefined(var_0))
    var_0 = 5.0;

  maps\_utility::vision_set_fog_changes("hunted", 2);
  level.player maps\_utility::set_light_set_player("hunted");
  level.player setclutforplayer("clut_hunted", var_0);
}

apply_lighting_pass_hunted_inside() {
  maps\_utility::vision_set_fog_changes("hunted_barn_interior", 2);
  level.player maps\_utility::set_light_set_player("barn_interior");
  level.player setclutforplayer("clut_hunted", 5);
  maps\_utility::set_vision_set("hunted_barn_interior", 6);
}

apply_lighting_pass_hunted_helicrash() {
  level.player maps\_utility::set_light_set_player("heli_crash");
}

setup_flickerlight_motion_presets() {
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_01", (1, 0.7, 0.4), 800, 20, 0.1, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_02", (1, 0.7, 0.4), 800, 20, 0.1, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_03", (1, 0.7, 0.4), 800, 20, 0.1, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("firelight_motion_04", (1, 0.7, 0.4), 800, 20, 0.1, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("fire_barrel_small_01", (1, 0.4, 0.1), 45, 20, 0.1, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("fire_barrel_small_02", (1, 0.65, 0.4), 28, 20, 0.1, 0.8);
  maps\_lighting::create_flickerlight_motion_preset("fire_barrel_small_03", (1, 0.4, 0.1), 55, 20, 0.1, 0.8);
}

end_slomo_mix() {
  soundscripts\_snd::snd_message("aud_heli_crashing");
}