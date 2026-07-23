/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_aud.gsc
**************************************/

main(var_0) {
  maps\_audio::aud_register_msg_handler(::so_msg_handler);
  thread aud_handle_map_setups(var_0);
}

aud_handle_map_setups(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "so_nyse_ny_manhattan":
      aud_start_nyse_fire();
      break;
  }
}

so_msg_handler(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "so_berlin_intro_littlebird_spawn":
      var_3 = var_1;
      var_3 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move");
      break;
    case "so_ied_littlebird":
      var_3 = var_1;
      var_3 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move");
      var_3 thread aud_helicopter_deathwatch();
      break;
    case "so_ied_wave4_littlebird":
      var_4 = var_1;
      var_4 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move_distant");
      var_4 thread aud_helicopter_deathwatch();
      break;
    case "so_ied_wave3_tank":
      var_5 = var_1;
      var_5 thread aud_run_tank_system();
      break;
    case "so_paris_start_jeep":
      var_6 = var_1;
      thread maps\_audio_vehicles::vm_start_preset("so_paris_jeep_01", "so_paris_jeep", var_6, 2.0);
      break;
    case "so_nyse_littlebird_spawn":
      var_3 = var_1;
      var_3 common_scripts\utility::play_loop_sound_on_entity("so_nymn_littlebird_move");
      break;
    case "so_start_harbor_player_hind":
      var_7 = var_1;
      var_7 common_scripts\utility::play_loop_sound_on_entity("so_hind_player");
      break;
    case "so_harbor_ally_helis":
      var_8 = var_1;

      foreach(var_3 in var_8) {}
      var_3 thread common_scripts\utility::play_loop_sound_on_entity("so_hind_allies");

      break;
    case "so_harbor_kill_helis":
      var_8 = var_1;

      foreach(var_3 in var_8) {}
      var_3 common_scripts\utility::stop_loop_sound_on_entity("so_hind_allies");

      break;
    case "so_start_harbor_exit_hind":
      var_13 = var_1;
      var_13 common_scripts\utility::play_loop_sound_on_entity("so_exit_hind_player");
      break;
    case "so_harbor_enemy_chopper_flyover":
      var_14 = var_1;
      var_14 maps\_utility::play_sound_on_entity("so_sub_hind_flyover");
      break;
    case "so_sub_missile_launch":
      var_15 = var_1;
      aud_handle_so_missile(var_15);
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

aud_start_nyse_fire() {
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med", (-945, -2847, 262), "steff_01", 1000, 1.0);
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med", (-1181, -2926, 55), "steff_02", 1000, 1.0);
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med_tight", (-1004, -2927, 42), "steff_03", 1000, 1.0);
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_crackle_med_tight", (-902, -2716, 66), "steff_04", 1000, 1.0);
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med_tight", (-909, -2636, 36), "steff_05", 1000, 1.0);
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med", (-686, -2120, 91), "steff_car", 1000, 1.0);
  common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight", (-141, 271, 2));
  common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight", (-259, 579, 2));
  common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight", (-475, 980, 10));
  common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight", (-704, 311, -7));
  maps\_audio_dynamic_ambi::damb_start_preset_at_point("fire_crackle_med_tight", (-471, 1856, -22), "pre_stock_01", 1000, 1.0);
}

aud_handle_so_missile(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.aud.is_occluded)) {
    level.aud.is_occluded = 0;
  }
  var_1 = maps\_audio_zone_manager::azm_get_current_zone();

  if((var_1 == "nyhb_sub_interior_controlroom" || var_1 == "nyhb_sub_interior_missileroom2") && !level.aud.is_occluded) {
    level.aud.is_occluded = 1;
    maps\_audio::aud_disable_zone_filter();
    level.player seteq("grondo3d", 0, 0, "lowpass", 0, 400, 2);
    level.player seteq("norestrict2d", 0, 0, "lowpass", 0, 400, 2);
    level.player seteqlerp(1, 0);
    thread monitor_zone_to_disable_eq();
  }

  wait 0.05;
  var_0 playSound("russian_sub_missile_launch");
  wait 1.25;
  var_0 playSound("russian_sub_missile_launch_boom");
}

monitor_zone_to_disable_eq() {
  for(;;) {
    var_0 = maps\_audio_zone_manager::azm_get_current_zone();

    if(var_0 != "nyhb_sub_interior_controlroom" && var_0 != "nyhb_sub_interior_missileroom2") {
      maps\_audio::aud_enable_zone_filter();
      level.player deactivateeq(0, "grondo3d", 0);
      level.player deactivateeq(0, "norestrict2d", 0);
      level.aud.is_occluded = 0;
      return;
    }

    level.player seteqlerp(1, 0);
    wait 0.1;
  }
}

aud_helicopter_deathwatch() {
  level.aud.crashpos = (0, 0, 0);
  self waittill("deathspin");
  thread aud_heli_crash_pos();
  thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_helicopter_dying_loop");
  common_scripts\utility::waittill_either("death", "crash_done");
  thread common_scripts\utility::play_sound_in_space("so_littlebird_helicopter_crash", level.aud.crashpos);
}

aud_heli_crash_pos() {
  self endon("death");

  for(;;) {
    if(isDefined(self)) {
      self.origin = level.aud.crashpos;
      wait 0.05;
    }
  }
}

aud_run_tank_system() {
  aud_ground_veh_loops("ied_tank_01", "us_tank_treads_lp_02", "us_tank_move_low_lp", "us_tank_idle_lp");
  aud_tank_fire_watch();
}

aud_ground_veh_loops(var_0, var_1, var_2, var_3) {
  if(isDefined(self)) {
    level.aud.instance_name = spawn("script_origin", self.origin);
    var_4 = spawn("script_origin", self.origin);
    var_5 = spawn("script_origin", self.origin);
    var_6 = spawn("script_origin", self.origin);
    level.aud.instance_name.fade_in = 1;
    var_7 = level.aud.instance_name;
    var_8 = level.aud.instance_name.fade_in;
    var_4 linkTo(self);
    var_6 linkTo(self);
    var_5 linkTo(self);

    if(isDefined(var_4) || isDefined(var_1)) {
      var_4 playLoopSound(var_1);
    }
    if(isDefined(var_5) || isDefined(var_2)) {
      var_5 playLoopSound(var_2);
    }
    if(isDefined(var_6) || isDefined(var_3)) {
      var_6 playLoopSound(var_3);
    }
    var_4 scalevolume(0.0);
    var_5 scalevolume(0.0);
    var_6 scalevolume(0.0);
    wait 0.3;
    aud_ground_veh_speed_mapping(var_7, var_4, var_5, var_6, 1, 5, var_8);
  }
}

aud_ground_veh_speed_mapping(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_4 = 1;
  var_5 = 5;
  thread aud_ground_veh_deathwatch(var_0, var_1, var_2, var_3);
  thread aud_create_drive_envs();
  var_0 endon("instance_killed");
  var_7 = 0;

  for(;;) {
    if(isDefined(self)) {
      var_8 = self vehicle_getspeed();
      var_8 = min(var_8, var_5);
      var_8 = maps\_audio::aud_smooth(var_7, var_8, 0.1);
      var_9 = maps\_audio::aud_map_range(var_8, var_4, var_5, level.aud.envs["veh_drive_vol"]);
      var_10 = maps\_audio::aud_map_range(var_8, var_4, var_5, level.aud.envs["veh_idle_vol"]);
      var_2 scalevolume(var_9, 0.1);
      var_1 scalevolume(var_9, 0.1);
      var_3 scalevolume(var_10, 0.1);
      var_7 = var_8;
      wait 0.1;
    }
  }
}

aud_create_drive_envs() {
  level.aud.envs["veh_drive_vol"] = [[0.0, 0.0], [0.05, 0.1], [0.1, 0.1], [0.2, 0.2], [0.3, 0.3], [0.4, 0.4], [0.5, 0.5], [0.6, 0.6], [0.8, 0.8], [1.0, 1.0]];
  level.aud.envs["veh_idle_vol"] = [[0.0, 1.0], [0.05, 0.85], [0.1, 0.6], [0.2, 0.5], [0.3, 0.4], [0.4, 0.1], [0.5, 0.0], [0.6, 0.0], [0.8, 0.0], [1.0, 0.0]];
}

aud_ground_veh_deathwatch(var_0, var_1, var_2, var_3) {
  if(isDefined(self)) {
    self waittill("death");
    var_0 notify("instance_killed");
    thread aud_fade_loop_out_and_delete_temp(var_1, 5);
    thread aud_fade_loop_out_and_delete_temp(var_2, 5);
    thread aud_fade_loop_out_and_delete_temp(var_3, 5);
  }
}

aud_tank_fire_watch() {
  self endon("death");

  if(isDefined(self)) {
    for(;;) {
      self waittill("weapon_fired");
      var_0 = randomfloatrange(0.2, 0.4);
      thread common_scripts\utility::play_sound_in_space("us_tank_big_boom", self.origin);
      thread common_scripts\utility::play_sound_in_space("us_tank_fire_dist", self.origin);
      thread common_scripts\utility::play_sound_in_space("us_tank_fire_close", self.origin);
      thread common_scripts\utility::play_sound_in_space("us_tank_fire_hi_ring", self.origin);
      thread common_scripts\utility::play_sound_in_space("us_tank_fire_lfe", self.origin);
      wait 0.2;
      thread common_scripts\utility::play_sound_in_space("us_tank_dist_verb", self.origin);
      wait(var_0);
    }
  }
}

aud_fade_loop_out_and_delete_temp(var_0, var_1) {
  var_0 scalevolume(0.0, var_1);
  wait(var_1 + 0.05);
  var_0 stoploopsound();
  wait 0.05;
  var_0 delete();
}