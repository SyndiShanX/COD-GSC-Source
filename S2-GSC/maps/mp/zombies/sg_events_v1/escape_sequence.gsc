/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\escape_sequence.gsc
************************************************************/

func_00D5() {
  initialize_markers();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_escape_common", ::run_escape, undefined, undefined, 1);
}

initialize_markers() {
  level.zmf_shattered_hardpoint_structs = common_scripts\utility::func_46B7("zmf_shattered_hardpoint_marker", "targetname");
  level.zmf_shattered_hardpoint_markers = [];
  var_00 = 16;
  foreach(var_02 in level.zmf_shattered_hardpoint_structs) {
    var_03 = bulletTrace(var_02.var_116 + (0, 0, var_00), var_02.var_116 - (0, 0, var_00), 0);
    if(distance(var_02.var_116, var_03["position"]) > var_00) {
      continue;
    }

    var_02.var_116 = var_03["position"] + (0, 0, 0.25);
  }
}

hide_markers() {
  foreach(var_01 in level.zmf_shattered_hardpoint_markers) {
    var_01 method_805C();
  }
}

show_markers() {
  foreach(var_01 in level.zmf_shattered_hardpoint_structs) {
    if(isDefined(var_01.var_3F2F)) {
      var_01.var_3F2F method_805B();
      continue;
    }

    var_01.var_3F2F = lib_0547::func_8FBA(var_01, "hp_neutral");
    level.zmf_shattered_hardpoint_markers = common_scripts\utility::func_F6F(level.zmf_shattered_hardpoint_markers, var_01.var_3F2F);
    triggerfx(var_01.var_3F2F);
  }
}

run_escape(param_00) {
  level endon("game_over");
  var_01 = common_scripts\utility::func_46B5("dom_flag_pole_b", "targetname");
  var_02 = common_scripts\utility::func_46B5(var_01.var_1A2, "targetname");
  var_03 = spawn("script_model", var_01.var_116);
  var_03 setModel("ctf_flag_pole_with_supports");
  var_04 = spawn("script_model", var_02.var_116);
  var_04 setModel("usa_ctf_flag_anim");
  var_04 scriptmodelplayanim("ctf_flag_flap");
  if(isDefined(var_01.var_1D)) {
    var_03.var_1D = var_01.var_1D;
  }

  if(isDefined(var_02.var_1D)) {
    var_04.var_1D = var_04.var_1D;
  }

  var_03.capture_health = 100;
  var_03.var_BC = 100;
  var_03.var_FB = 100;
  var_03.anim_flag = var_04;
  var_04 method_8511();
  var_03 setModel("tag_origin");
  var_05 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escape_common_delay");
  var_06 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escape_common_capture_time");
  var_07 = spawnStruct();
  var_07 thread maps\mp\mp_zombie_nest_ee_wave_manipulation::enforce_zombie_limit("escape_started", 8);
  var_07 thread ramp_value(var_05);
  lib_0378::func_8D74("dlc3_start_escape_music");
  var_08 = var_03;
  var_08.var_603C = "zm_hud_type_escape_common_icon";
  var_08.waypoint_origin = var_08.var_116 + (0, 0, 80);
  var_08.waypoints = [];
  level thread maps\mp\_utility::func_6F74(::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::draw_waypoint_on_struct, var_08);
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::sg_obj_timer(int(var_05 + var_06));
  wait_escape_intro(var_05);
  show_markers();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::clear_all_waypoints();
  var_07 notify("escape_started");
  lib_0378::func_8D74("dlc3_stop_escape_music", 80);
  return capture_escape_point(var_03, var_06);
}

wait_escape_intro(param_00) {
  wait(param_00);
}

capture_escape_point(param_00, param_01) {
  var_02 = param_00.var_116;
  var_03 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escape_common_capture_radius");
  var_04 = 1;
  var_05 = 0;
  var_06 = param_00.anim_flag;
  while(isDefined(param_00) && param_00.capture_health > 0) {
    var_05 = var_05 + var_04;
    param_00.capture_health = int(max(0, param_00.var_FB - int(param_00.var_FB * var_05 / param_01)));
    wait(var_04);
  }

  var_06 delete();
  lib_0378::func_8D74("dlc3_stop_escape_music", 0);
  var_07 = 0;
  foreach(var_09 in level.var_744A) {
    var_09.var_480F = 1;
  }

  foreach(var_09 in level.var_744A) {
    if(isalive(var_09) && distance2d(var_09.var_116, var_02) < var_03) {
      maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::individual_escape_bonus(var_09);
      var_07++;
    }
  }

  if(var_07 > 0) {
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::set_game_won();
  }

  if(var_07 >= level.var_744A.size) {
    maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::group_escape_bonus();
  }

  wait(3.5);
  return 1;
}

ramp_value(param_00) {
  self.zombie_count = 1;
  for(;;) {
    self.zombie_count = self.zombie_count + 1;
    wait(int(param_00 / 18));
  }
}