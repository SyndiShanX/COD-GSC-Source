/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\bog_b_lighting.gsc
********************************/

main() {
  set_level_lighting_values();
  init_level_lighting_flags();
  level.cheat_invert_override = "_bright";
  thread setup_lighting_pass_archway();
  thread setup_lighting_pass_interior();
  thread play_flickering_light();
  thread setup_fade_angle_lights();
  thread setup_fade_distance_lights();
  thread handle_tank_fight_dof();
  thread handle_finale_dof();
}

handle_tank_fight_dof() {
  var_0 = maps\_vehicle::waittill_vehiclespawn("t72");
  var_1 = maps\_cinematography::dyndof("t72") maps\_cinematography::dyndof_values(2.4, -1, 3, 1) maps\_cinematography::dyndof_reference_entity(var_0) maps\_cinematography::dyndof_require_visible(1) maps\_cinematography::dyndof_view_model_fstop_scale(6);
  var_1 maps\_cinematography::dyndof_angles(-15, 15) maps\_cinematography::dyndof_priority(2);
  var_2 = maps\_cinematography::dyndof("m1a1") maps\_cinematography::dyndof_values(2.4, -1, 3, 1) maps\_cinematography::dyndof_reference_entity(level.abrams) maps\_cinematography::dyndof_require_visible(1) maps\_cinematography::dyndof_view_model_fstop_scale(6);
  var_2 maps\_cinematography::dyndof_angles(-10, 10) maps\_cinematography::dyndof_priority(1);
  maps\_cinematography::dyndof("main_dof") maps\_cinematography::dyndof_values(4, 640, 3, 1) maps\_cinematography::dyndof_autofocus(1) maps\_cinematography::dyndof_view_model_fstop_scale(10) maps\_cinematography::dyndof_reference_entity(level.price) maps\_cinematography::dyndof_valid_range(0, 200);
  maps\_cinematography::dyndof("off_angle_dof") maps\_cinematography::dyndof_values(64, 1200, 3, 1) maps\_cinematography::dyndof_autofocus(1) maps\_cinematography::dyndof_view_model_fstop_scale(5);
  thread maps\_cinematography::dyndof_system_start(1);
  var_3 = maps\_cinematography::cinseq_create_screen_shake_struct();
  var_3.duration = 0.3;
  var_3.pitch_scale = 0.5;
  var_3.roll_scale = 0.4;
  var_3.frequency_roll = 4;
  var_3.frequency_pitch = 11;
  var_4 = maps\_cinematography::cinematic_sequence("t72_blown_up");
  var_5 = var_4 maps\_cinematography::cinseq_key("begin_explosion") maps\_cinematography::cinseq_key_time(0.1) maps\_cinematography::cinseq_key_dyndof_values("t72", 0.5, -1, 40, 40);
  var_5 maps\_cinematography::cinseq_key_screen_shake(var_3) maps\_cinematography::cinseq_key_dyndof_offset("t72", 100);
  var_4 maps\_cinematography::cinseq_key("wind_down_explosion") maps\_cinematography::cinseq_key_time(0.4) maps\_cinematography::cinseq_key_dyndof_values("t72", 2.8, -1, 10, 3) maps\_cinematography::cinseq_key_dyndof_offset("t72", 0);
  var_4 maps\_cinematography::cinseq_key("start_slowmo") maps\_cinematography::cinseq_key_time(3.5) maps\_cinematography::cinseq_key_set_slowmo(0.6, 0.3);
  var_4 maps\_cinematography::cinseq_key("turret_explosion") maps\_cinematography::cinseq_key_time(3.7) maps\_cinematography::cinseq_key_dyndof_values("t72", 0.2, -1, 40, 40) maps\_cinematography::cinseq_key_dyndof_offset("t72", 300);
  var_4 maps\_cinematography::cinseq_key("remove_slowmo") maps\_cinematography::cinseq_key_time(4.1) maps\_cinematography::cinseq_key_remove_slowmo(0.4);
  var_5 = var_4 maps\_cinematography::cinseq_key("turret_explosion_wind_down") maps\_cinematography::cinseq_key_time(4.3) maps\_cinematography::cinseq_key_dyndof_values("t72", 2, -1, 2, 0.5);
  var_5 maps\_cinematography::cinseq_key_dyndof_offset("t72", 0) maps\_cinematography::cinseq_key_dyndof_view_model_fstop_scale("t72", 0.6);
  var_4 maps\_cinematography::cinseq_key("view_model_fstop1") maps\_cinematography::cinseq_key_time(5) maps\_cinematography::cinseq_key_dyndof_view_model_fstop_scale("t72", 2);
  var_4 maps\_cinematography::cinseq_key("view_model_fstop2") maps\_cinematography::cinseq_key_time(5.5) maps\_cinematography::cinseq_key_dyndof_view_model_fstop_scale("t72", 4);
  var_4 maps\_cinematography::cinseq_key("view_model_fstop3") maps\_cinematography::cinseq_key_time(6) maps\_cinematography::cinseq_key_dyndof_view_model_fstop_scale("t72", 6);
  level waittill("t72_exploded");
  var_1 maps\_cinematography::dyndof_require_visible(0);
  var_4 maps\_cinematography::cinseq_start_sequence();
  wait 2;
  maps\_cinematography::dyndof_system_clear_all();
  maps\_cinematography::dyndof_system_end();
}

handle_finale_dof() {}

init_level_lighting_flags() {
  common_scripts\utility::flag_init("lighting_player_entered_alley");
  common_scripts\utility::flag_init("lighting_player_entered_bog");
  common_scripts\utility::flag_init("lighting_player_interior");
}

set_level_lighting_values() {
  setsaveddvar("r_disablelightsets", 0);
  setsunflareposition((-50, 136, 0));
  setsaveddvar("scr_dof_enable", "1");
  apply_lighting_pass_bog_outside(0.0);
}

setup_fade_angle_lights() {
  var_0 = getentarray("fade_angle_light", "targetname");

  foreach(var_2 in var_0)
  var_2 thread update_fade_angle_lights();
}

update_fade_angle_lights() {
  var_0 = 45.0;
  var_1 = 135.0;
  var_2 = 3000000.0;

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

setup_fade_distance_lights() {
  var_0 = getentarray("fade_distance_light", "targetname");

  foreach(var_2 in var_0)
  var_2 thread update_fade_distance_lights();
}

update_fade_distance_lights() {
  var_0 = 500.0;
  var_1 = 1000.0;
  var_2 = 100000.0;

  if(isdefined(self.script_noteworthy)) {
    var_3 = strtok(self.script_noteworthy, " ");

    if(isdefined(var_3[0]))
      var_0 = float(var_3[0]);

    if(isdefined(var_3[1]))
      var_1 = float(var_3[1]);

    if(isdefined(var_3[2]))
      var_2 = float(var_3[2]);
  }

  for (;;) {
    var_4 = length(level.player.origin - self.origin);
    var_5 = clamp((var_4 - var_0) / (var_1 - var_0), 0.0, 1.0);
    self setlightintensity(var_2 * var_5);
    wait 0.05;
  }
}

setup_lighting_pass_archway() {
  for (;;) {
    common_scripts\utility::flag_wait("lighting_player_entered_alley");
    common_scripts\utility::flag_clear("lighting_player_entered_bog");
    apply_lighting_pass_bog_street_part01();
    common_scripts\utility::flag_wait("lighting_player_entered_bog");
    common_scripts\utility::flag_clear("lighting_player_entered_alley");
    apply_lighting_pass_bog_outside();
  }
}

setup_lighting_pass_interior() {
  for (;;) {
    common_scripts\utility::flag_wait("lighting_player_interior");
    apply_lighting_pass_bog_inside();
    common_scripts\utility::flag_waitopen("lighting_player_interior");
    apply_lighting_pass_bog_outside();
  }
}

apply_lighting_pass_bog_outside(var_0) {
  if(!isdefined(var_0))
    var_0 = 5.0;

  maps\_utility::vision_set_fog_changes("bog_b", 2);
  level.player maps\_utility::set_light_set_player("bog_b");
  level.player setclutforplayer("clut_bog_b", var_0);
}

apply_lighting_pass_bog_inside() {
  maps\_utility::vision_set_fog_changes("bog_b_interior", 2);
  level.player maps\_utility::set_light_set_player("bog_b_interior");
  level.player setclutforplayer("clut_bog_b", 5);
}

apply_lighting_pass_bog_street_part01() {
  maps\_utility::vision_set_fog_changes("bog_b", 2);
  level.player maps\_utility::set_light_set_player("bog_b");
  level.player setclutforplayer("clut_bog_b", 5);
}

apply_lighting_pass_bog_tank_sequence() {
  maps\_utility::vision_set_fog_changes("bog_b", 2);
  level.player maps\_utility::set_light_set_player("bog_b");
  level.player setclutforplayer("clut_bog_b", 5);
}

play_flickering_light() {
  var_0 = 1800;
  var_1 = 15000;
  var_2["on"] = "emt_light_flicker_on";
  var_2["off"] = "emt_light_flicker_off";
  var_2["loop"] = "emt_light_flicker_lp";
  var_2["vol_env"] = [[var_0, 0.2],
    [var_1, 1.0]
  ];
  thread maps\_lighting::model_flicker_preset("model_flicker_01", 0, var_0, var_1, undefined, undefined, 0.005, 0.5, 0.005, 0.05, undefined, var_2, 1500);
  var_0 = 1800;
  var_1 = 25000;
  var_2["vol_env"] = [[var_0, 0.2],
    [var_1, 1.0]
  ];
  thread maps\_lighting::model_flicker_preset("model_flicker_03", 0, var_0, var_1, undefined, undefined, 0.005, 0.5, 0.005, 0.05, undefined, var_2, 1500);
}