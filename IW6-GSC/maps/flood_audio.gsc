/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_audio.gsc
*****************************************************/

main() {
  audio_flag_init();
  level.current_audio_zone = "flood_streets";
  thread sfx_flood_int_alarm();
  thread trigger_heli_staircase();
  thread trigger_int_building_hits();
  thread sfx_rooftops_player_jump();
  thread sfx_rooftops_player_jumpdown();
  thread sfx_stairwell_heli_trig_setup();
  thread sfx_stairwell_mid_trig_setup();
  level.swept_away = 0;
  soundsettimescalefactor("announcer", 0.1);
  soundsettimescalefactor("mission", 0);
  soundsettimescalefactor("missionfx", 0.1);
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("local3", 1);
  soundsettimescalefactor("effects2d2", 0);
  soundsettimescalefactor("shellshock", 0);
}

audio_flag_init() {
  common_scripts\utility::flag_init("sfx_warehouse_water_start");
  common_scripts\utility::flag_init("sfx_stop_warehouse_water");
  common_scripts\utility::flag_init("sfx_stop_stairwell_water");
  common_scripts\utility::flag_init("sfx_stop_mall_water");
  common_scripts\utility::flag_init("sfx_stop_alley_water");
  common_scripts\utility::flag_init("sfx_missiles_launched");
  common_scripts\utility::flag_init("sfx_launcher_destroyed");
  common_scripts\utility::flag_init("rooftop_heli_flyaway");
  common_scripts\utility::flag_init("rooftop_stairwell_top");
  common_scripts\utility::flag_init("rooftop_stairwell_mid");
}

cleanupent(var_0) {
  wait(var_0);
  self delete();
}

change_zone_stairwell() {}

audio_start_rushing_water_line_emitter_01() {
  wait 0.1;
  var_0 = [];
  var_0[0] = spawn("script_origin", (3847, -3631, 123));
  var_0[1] = spawn("script_origin", (3759, -4085, 123));
  var_0[2] = spawn("script_origin", (4914, -4086, 123));
  var_0[3] = spawn("script_origin", (4906, -3434, 123));
  var_0[4] = spawn("script_origin", (5480, -3370, 123));
  audio_stereo_line_emitter(var_0, "emt_flood_rushing_water_l");
}

audio_start_rushing_water_line_emitter_02() {
  wait 0.1;
  var_0 = [];
  var_0[0] = spawn("script_origin", (6100, -3398, 157));
  var_0[1] = spawn("script_origin", (6484, -3182, 157));
  var_0[2] = spawn("script_origin", (6486, -2786, 157));
  audio_stereo_line_emitter(var_0, "emt_flood_rushing_water_l");
}

audio_start_rushing_water_line_emitter_03() {
  wait 0.1;
  var_0 = [];
  var_0[0] = spawn("script_origin", (5653, -2121, 123));
  var_0[1] = spawn("script_origin", (5641, 2134, 123));
  var_0[2] = spawn("script_origin", (6514, 2906, 123));
  audio_stereo_line_emitter(var_0, "emt_flood_rushing_water_l");
}

audio_stereo_line_emitter(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_4 = spawn("script_origin", (0, 0, 0));
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;

  for(;;) {
    var_8 = 0;
    var_9 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0, undefined, 2);

    foreach(var_11 in var_9) {
      if(var_8 == 0) {
        var_8 = 1;
        var_5 = var_11;
        continue;
      }

      var_6 = var_11;
    }

    var_13 = pointonsegmentnearesttopoint(var_5.origin, var_6.origin, level.player.origin);

    if(isDefined(var_2)) {
      var_3 moveto(var_13 + (0, 30, 0), 0.01);
      var_4 moveto(var_13 - (0, 30, 0), 0.01);
    } else
      var_3 moveto(var_13, 0.01);

    if(var_7 == 0) {
      if(isDefined(var_2)) {
        var_4 playLoopSound(var_2);
      }

      var_3 playLoopSound(var_1);
      var_7 = 1;
    }

    wait 0.1;
  }
}

narration_flood_infil() {
  wait 1.25;
  level.player playSound("flood_els_tousrorkewas");
  wait 7.6;
  level.player playSound("flood_els_theghostswerethe");
}

sfx_start_heartbeat_countdown() {
  level endon("cw_player_abovewater");
  wait(level.cw_player_allowed_underwater_time - 8);

  if(!level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    level.cw_heartbeat_sfx_on = 1;
    var_0 = spawn("script_origin", level.player.origin);
    var_0 linkto(level.player);
    var_0 playSound("scn_flood_underwater_heartbeat");
    level thread sfx_start_heartbeat_countdown_off(var_0);
  }
}

sfx_start_heartbeat_countdown_off(var_0) {
  for(;;) {
    if(common_scripts\utility::flag("cw_player_abovewater")) {
      break;
    } else if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  var_0 stopsounds();
  wait 0.1;
  var_0 delete();
}

sfx_start_heartbeat_countdown_lp() {
  if(!level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
    var_0 = spawn("script_origin", level.player.origin);
    var_0 linkto(level.player);
    var_0 playLoopSound("scn_flood_underwater_heartbeat_lp");

    for(;;) {
      if(common_scripts\utility::flag("cw_player_abovewater")) {
        break;
      } else if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
        break;
      }

      common_scripts\utility::waitframe();
    }

    var_0 stopsounds();
    wait 0.1;
    var_0 delete();
  }
}

sfx_heli_infil() {
  wait 1;
  level.player playSound("scn_flood_infil_lr");
  wait 6.5;
  level.player setclienttriggeraudiozone("flood_infil_main", 0.5);
}

sfx_infil_heli_flyaway(var_0) {
  level.player clearclienttriggeraudiozone(6);
  wait 2.5;
  var_0 playSound("scn_flood_infil_flyaway");
}

sfx_lynx_smash() {
  wait 3;
  level.tank_ally_joel playSound("scn_flood_tank_crush_lynx");
  wait 1;
  common_scripts\utility::exploder("lynx_crush");
  wait 2;
  common_scripts\utility::exploder("lynx_crush");
}

sfx_tank_bust_wall() {
  wait 2.0;
  level.tank_wall_sfx = spawn("script_origin", (1093, -9790, 50));
  level.tank_wall_sfx playSound("scn_streets_tank_bust_wall");
}

sfx_missile_buzzer(var_0, var_1) {
  var_2 = level.dam_break_m880;
  var_2 = var_0;
  level.buzzer_node = spawn("script_origin", var_2.origin);
  level.buzzer_node linkto(var_2);
  waittillframeend;
  maps\_utility::battlechatter_on("axis");
  thread missile_launcher_battlechatter(var_1);

  for(;;) {
    if(!common_scripts\utility::flag(var_1)) {
      level.buzzer_node playSound("emt_flood_missile_buzzer_2");
      wait 1.32;
      continue;
    }

    break;
  }

  level.buzzer_node delete();
}

missile_launcher_battlechatter(var_0) {
  var_1 = spawn("script_origin", (-1554, -3711, 0));
  waittillframeend;

  for(;;) {
    if(!common_scripts\utility::flag(var_0)) {
      var_1 playSound("scn_flood_missile_scripted_bc");
      wait(randomfloatrange(2, 5));
      continue;
    }

    break;
  }
}

sfx_stop_buzzer(var_0) {
  common_scripts\utility::flag_set(var_0);
}

sfx_dam_start_water() {
  thread start_sfx_dam_siren_ext(5.0, 1.0);
  level.player playSound("scn_flood_dam_rumble");
  thread sfx_dam_tidal_wave_01();
}

setup_sfx_dam_siren() {
  level.player setclienttriggeraudiozone("flood_streets_alarmoff", 0.5);
  wait 0.6;
  level.sirenorg_ext_l = spawn("script_origin", (-6839, -67, 1962));
  level.sirenorg_ext_l playLoopSound("scn_flood_dam_siren_lp_l");
  level.sirenorg_ext_r = spawn("script_origin", (5969, 1090, 1962));
  level.sirenorg_ext_r playLoopSound("scn_flood_dam_siren_lp_r");
  level.sirenorg_ext_s = spawn("script_origin", (-25, -13632, 1962));
  level.sirenorg_ext_s playLoopSound("scn_flood_dam_siren_lp_s");
  level.sirenorg_int = spawn("script_origin", level.player.origin);
  level.sirenorg_int linkto(level.player);
  level.sirenorg_int playLoopSound("scn_flood_dam_siren_int_lp");
  level.player clearclienttriggeraudiozone(4);
}

mall_ext_sirens() {
  wait 3;
  level.player setclienttriggeraudiozone("flood_mall", 4);
  common_scripts\utility::flag_wait("player_on_mall_roof");
  level.player clearclienttriggeraudiozone(2);
}

start_sfx_dam_siren_ext(var_0, var_1) {
  if(!isDefined(level.sirenorg_ext_l) || !isDefined(level.sirenorg_ext_r) || !isDefined(level.sirenorg_ext_s) || !isDefined(level.sirenorg_int)) {
    setup_sfx_dam_siren();
  }

  level.player setclienttriggeraudiozone("flood_streets_alarmoff", 0.1);
  level.player clearclienttriggeraudiozone(5);
}

stop_sfx_dam_siren_ext() {
  if(!isDefined(level.sirenorg_ext_l) || !isDefined(level.sirenorg_ext_r) || !isDefined(level.sirenorg_ext_s) || !isDefined(level.sirenorg_int)) {
    setup_sfx_dam_siren();
  }
}

start_sfx_dam_siren_int() {
  if(!isDefined(level.sirenorg_ext_l) || !isDefined(level.sirenorg_ext_r) || !isDefined(level.sirenorg_ext_s) || !isDefined(level.sirenorg_int)) {
    setup_sfx_dam_siren();
  }
}

stop_sfx_dam_siren_int() {
  if(!isDefined(level.sirenorg_ext_l) || !isDefined(level.sirenorg_ext_r) || !isDefined(level.sirenorg_ext_s) || !isDefined(level.sirenorg_int)) {
    setup_sfx_dam_siren();
  }
}

kill_sfx_dam_sirens() {
  if(isDefined(level.sirenorg_ext_l) || isDefined(level.sirenorg_ext_r) || isDefined(level.sirenorg_ext_s) || isDefined(level.sirenorg_int)) {
    wait 1.0;
    level.sirenorg_int stoploopsound("scn_flood_dam_siren_int_lp");
    level.sirenorg_ext_l stoploopsound("scn_flood_dam_siren_lp_l");
    level.sirenorg_ext_r stoploopsound("scn_flood_dam_siren_lp_r");
    level.sirenorg_ext_s stoploopsound("scn_flood_dam_siren_lp_s");
    level.sirenorg_ext_l delete();
    level.sirenorg_ext_r delete();
    level.sirenorg_ext_s delete();
    level.sirenorg_int delete();
  }
}

sfx_dam_tidal_wave_01() {}

sfx_dam_tidal_wave_02() {
  var_0 = spawn("script_origin", (900, -4026, 60));
  var_1 = spawn("script_origin", (256, -4026, 60));
  var_2 = spawn("script_origin", (700, -4176, 33));
  var_0 playSound("scn_flood_dam_tidal_wave_03");
  wait 2.9;
  var_2 playSound("scn_flood_dam_truck_impact");
  wait 1;
  wait 0.6;
  var_1 playLoopSound("emt_flood_water_rushing_heavy_alley");
  wait 0.1;
  wait 10;
  var_0 delete();
  common_scripts\utility::flag_wait("sfx_stop_alley_water");
  var_1 stoploopsound();
  wait 2;
  var_1 delete();
}

sfx_stop_alley_water() {
  common_scripts\utility::flag_set("sfx_stop_alley_water");
}

sfx_flood_mall_int_npc_mantles(var_0) {
  self playSound(var_0);
}

sfx_big_metal_stress() {
  wait 15;
  level.player playSound("scn_flood_warehouse_mtl_huge_stress_lr");
}

sfx_warehouse_door_burst_01(var_0) {
  var_0 playSound("scn_flood_warehouse_door_burst_01");
  wait 1;
  var_0 playLoopSound("emt_flood_door_rattle_lp");
  var_1 = spawn("script_origin", (310, -2410, 44));
  var_1 playLoopSound("emt_flood_water_spray_lp_02");
  common_scripts\utility::flag_wait("sfx_stop_warehouse_water");
  wait 2;
  var_1 delete();
}

sfx_warehouse_door_burst_02(var_0) {
  thread common_scripts\utility::play_sound_in_space("scn_flood_warehouse_door_burst_02", (373, -2033, 75));
  wait 0.1;
  thread sfx_warehouse_water_sprays();
  wait 0.1;
  var_0 playLoopSound("emt_flood_door_rattle_lp");
}

sfx_warehouse_water_sprays() {
  wait 0.6;
  var_0 = spawn("script_origin", (292, -2120, 47));
  var_0 playLoopSound("emt_flood_water_spray_lp_01");
  wait 0.3;
  var_1 = spawn("script_origin", (278, -1908, 47));
  var_1 playLoopSound("emt_flood_water_spray_lp_02");
  var_2 = spawn("script_origin", (74, -1431, 69));
  var_2 playLoopSound("emt_flood_water_spray_lp_02");
  wait 0.1;
  var_3 = spawn("script_origin", (9, -1093, 90));
  var_3 playLoopSound("emt_flood_water_spray_lp_01");
  common_scripts\utility::flag_wait("sfx_stop_warehouse_water");
  wait 2;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

sfx_warehouse_water() {
  var_0 = spawn("script_origin", (36, -2932, 52));
  var_1 = spawn("script_origin", (-91, -2932, 52));
  var_2 = spawn("script_origin", (-21, -2932, 10));
  var_3 = spawn("script_origin", (81, -2932, 10));
  var_4 = spawn("script_origin", (-129, -2932, 10));
  var_5 = spawn("script_origin", (373, -2597, 52));
  var_6 = spawn("script_origin", (373, -2273, 52));
  var_7 = spawn("script_origin", (373, -1952, 52));
  var_8 = spawn("script_origin", (252, -2704, 52));
  var_9 = spawn("script_origin", (373, -2511, 52));
  var_10 = spawn("script_origin", (373, -2191, 85));
  var_11 = spawn("script_origin", (4, -1027, 91));
  var_12 = spawn("script_origin", (221, -3168, 47));
  wait 0.05;
  waittillframeend;
  var_0 playLoopSound("emt_flood_mtl_buckling_lp_01");
  var_1 playLoopSound("emt_flood_mtl_buckling_lp_02");
  var_2 playLoopSound("emt_flood_water_seep_low_lp");
  var_3 playLoopSound("emt_flood_water_seep_low_lp");
  var_5 playLoopSound("emt_flood_mtl_buckling_lp_02");
  var_6 playLoopSound("emt_flood_mtl_buckling_lp_01");
  var_7 playLoopSound("emt_flood_mtl_buckling_last_lp");
  var_8 playLoopSound("emt_flood_water_spray_lp_01");
  var_9 playLoopSound("emt_flood_water_seep_int_lp");
  var_10 playLoopSound("emt_flood_water_seep_int_lp");
  var_11 playLoopSound("emt_flood_mtl_buckling_lp_01");
  var_12 playLoopSound("emt_flood_water_spray_lp_02");
  wait 0.05;
  waittillframeend;
  common_scripts\utility::flag_wait("sfx_stop_warehouse_water");
  wait 4;
  var_0 delete();
  var_1 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
  var_12 delete();
  common_scripts\utility::flag_wait("sfx_stop_stairwell_water");
  wait 4;
  var_11 delete();
}

sfx_stop_warehouse_water() {
  wait 12;
  common_scripts\utility::flag_set("sfx_stop_warehouse_water");
}

sfx_stop_stairwell_water() {
  wait 4;
  common_scripts\utility::flag_set("sfx_stop_stairwell_water");
}

sfx_stop_mall_water() {
  wait 0.1;
  common_scripts\utility::flag_set("sfx_stop_mall_water");
}

sfx_oldboy_stumble_stairs() {
  self playSound("scn_flood_mall_oldboy_stumble_stairs");
}

sfx_mall_water() {
  wait 2.9;
  var_0 = spawn("script_origin", (638, -2325, 277));
  wait 0.1;
  var_0 playLoopSound("emt_flood_water_rushing_heavy_mall");
  common_scripts\utility::flag_wait("sfx_stop_mall_water");
  var_0 delete();
}

sfx_node_array_init(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_0);
  var_3.soundalias = var_1;
  var_3.refnum = var_2;
  level.sfx_flood_nodes[level.sfx_flood_nodes.size] = var_3;
}

audio_flood_end_logic() {
  thread swept_away_scene("end");
  wait 4.4;
  level.swept_away = 0;
}

debris_bridge_sfx() {
  thread debris_bridge_shaking_loop();
  var_0 = 0.0;
  wait 8.4;
  thread common_scripts\utility::play_sound_in_space("scn_flood_debris_bridge", (5540, 2494, 110));
  maps\_utility::delaythread(var_0 + 0.2, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 1.143, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 6.351, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 8.917, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 9.591, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 10.31, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 12.19, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 13.49, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 16.089, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_sm", (6286, 2225, 160));
  maps\_utility::delaythread(var_0 + 19.205, common_scripts\utility::play_sound_in_space, "scn_flood_debris_bridge_ceiling_debris_lg", (6286, 2225, 160));
}

debris_bridge_shaking_loop() {
  common_scripts\utility::flag_wait("debrisbridge_ready");
  var_0 = [];
  var_0[0] = spawn("script_origin", (6034, 2388, 95));
  var_0[1] = spawn("script_origin", (2628, 2499, 95));
  var_1 = [];
  var_1[0] = spawn("script_origin", (5970, 2280, 119));
  var_1[1] = spawn("script_origin", (5537, 2364, 119));
  var_2 = [];
  var_2[0] = spawn("script_origin", (6034, 2388, 95));
  var_2[1] = spawn("script_origin", (2628, 2499, 95));
  thread audio_stereo_line_emitter(var_0, "emt_flood_debris_bridge_lp_01");
  thread audio_stereo_line_emitter(var_1, "emt_flood_debris_bridge_lp_02");
  thread audio_stereo_line_emitter(var_2, "scn_flood_debris_bridge_lp");
}

swept_away_scene(var_0) {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");

  if(var_0 == "beginning") {
    level.player setclienttriggeraudiozone("flood_swept", 0.1);
    level.player playSound("scn_flood_swept_away_beg_lr_ss");
    level.scene1emitter = spawn("script_origin", (6034, 2388, 96));
    wait 6.3;
    level.scene1emitter playSound("scn_flood_swept_away_pt1_lr_ss");
    wait 0.1;
    wait 0.2;
  }

  if(var_0 == "start") {
    level.prescene = spawn("script_origin", (6034, 2388, 98));
    level.prescene playSound("scn_flood_swept_fadein_lr_ss");
    level.player setclienttriggeraudiozone("flood_swept", 0.1);
    level.scene1emitter = spawn("script_origin", (6034, 2388, 96));
    wait 6.1;
    level.scene1emitter playSound("scn_flood_swept_away_pt1_lr_ss");
  }

  if(var_0 == "switch") {
    level.scene2emitter = spawn("script_origin", (6034, 2388, 97));
    wait 0.4;
    level.scene1emitter stopsounds();
    wait 0.1;
    level.scene1emitter delete();

    if(isDefined(level.prescene)) {
      level.prescene delete();
    }
  }

  if(var_0 == "end") {
    wait 10;
    level.player clearclienttriggeraudiozone(1.0);
  }
}

skybridge_precursor_emitter() {
  var_0 = spawn("script_origin", (5037, -2444, 96));
  var_0 playLoopSound("scn_flood_skybridge_lp");
  common_scripts\utility::flag_wait("on_skybridge");
  wait 3.0;
  var_0 stopsounds();
  wait 0.1;
  var_0 delete();
}

skybridge_door_bump() {
  wait 1.5;
  thread common_scripts\utility::play_sound_in_space("scn_flood_stealth_door_bump_ss", (4530, -3163, 252));
}

skybridge_logic() {
  wait 0.3;
  thread common_scripts\utility::play_sound_in_space("scn_flood_skybridge_ss", (5294, -1005, 221));
  wait 5.2;
  common_scripts\utility::play_sound_in_space("scn_flood_skybridge_impact_ss", (5143, -1693, 75));
}

skybridge_wash_away() {
  thread common_scripts\utility::play_sound_in_space("scn_flood_skybridge_wash_away_pos", (5278, -1710, 135));
  level.player playSound("scn_flood_skybridge_wash_away");
  wait 6.0;
  common_scripts\utility::play_sound_in_space("scn_flood_skybridge_break_away", (5458, -2537, 170));
}

mssl_launch_front_wheels() {
  level.front_wheel_sfx = spawn("script_origin", (-1670, -7928, -8));
  level.back_wheel_sfx = spawn("script_origin", (-1696, -8132, -8));
  wait 1.18;
  level.front_wheel_sfx playLoopSound("scn_flood_mssl_stuck_lp");
  level.back_wheel_sfx playLoopSound("scn_flood_mssl_stuck_front_lp");
}

mssl_launch_destory_sfx() {
  level.lnchr_dstry_sfx = spawn("script_origin", (-1560, -7899, 25));
  level.lnchr_dstry_sfx linkto(level.player);
  level.lnchr_dstry_sfx playSound("scn_flood_mssl_destroy_ss");
  wait 9.72;
  level.back_wheel_sfx stoploopsound();
  level.front_wheel_sfx stoploopsound();
  wait 2.83;
  common_scripts\utility::play_sound_in_space("scn_flood_mssl_explo", (-1743, -7314, 0));
  level.back_wheel_sfx delete();
  level.front_wheel_sfx delete();
}

launcher_destroy_slomo_sfx() {
  level.lnchr_slomo_sfx = spawn("script_origin", (-1560, -7899, 25));
  level.lnchr_slomo_sfx linkto(level.player);
  level.player setclienttriggeraudiozone("flood_streets_slomo", 0.3);
  waittillframeend;
  level.lnchr_slomo_sfx playSound("scn_flood_lnchr_destroy_slowin");
}

launcher_destroy_stop_slomo_sfx() {
  level.lnchr_slomo2_sfx = spawn("script_origin", (-1560, -7899, 25));
  level.lnchr_slomo2_sfx linkto(level.player);
  level.player clearclienttriggeraudiozone(0.5);
  waittillframeend;
  level.lnchr_slomo2_sfx playSound("scn_flood_lnchr_destroy_slowout");
  wait 0.2;
  level.lnchr_slomo_sfx stopsounds();
}

sfx_rorke_submerge(var_0) {
  wait 5;
  var_0 playSound("scn_flood_stealth_rorke_submerge");
}

sfx_diaz_stealth_kills2(var_0) {
  var_0 playSound("scn_flood_diaz_stealth_kill_02");
  wait 7.5;
  var_0 playSound("scn_flood_diaz_stealth_cabinets");
}

sfx_stealth_kill_death_vo(var_0) {
  level.sfx_death_vo = spawn("script_origin", var_0.origin);
  wait 0.2;
  level.sfx_death_vo playSound("generic_death_enemy_3", "sounddone");
  level.sfx_death_vo waittill("sounddone");
  level.sfx_death_vo delete();
}

sfx_plr_vault() {
  level.player playSound("scn_flood_stealth_plr_vault");
}

diaz_door_kick_sfx() {
  var_0 = spawn("script_origin", (-62, -3906, -3));
  wait 0.05;
  var_0 playSound("scn_flood_diaz_door_kick");
  wait 5;
  var_0 delete();
}

sfx_flood_int_alarm() {
  level.flood_int_alarm01 = spawn("script_origin", (1.77724, -1607.53, 146.668));
  level.flood_int_doors = spawn("script_origin", (21, -1233, 92));
  wait 0.1;
  level.flood_int_alarm01 playLoopSound("emt_flood_fire_alarm");
  level.flood_int_doors playLoopSound("emt_flood_doubledoor_lp");
  common_scripts\utility::flag_wait("player_at_stairs");
  sfx_flood_int_alarm_stop();
}

sfx_flood_int_alarm_stop() {
  if(isDefined(level.flood_int_alarm01)) {
    wait 1;
    level.flood_int_alarm01 stopsounds();
    level.flood_int_doors stopsounds();
    wait 0.1;
    level.flood_int_doors delete();
    level.flood_int_alarm01 delete();
  }
}

trigger_heli_staircase() {
  var_0 = getent("sfx_trigger_heli", "targetname");
  var_0 thread trigger_heli_wait();
}

trigger_heli_wait() {
  self waittill("trigger");
  var_0 = spawn("script_origin", (-2255, -1872, 1290));
  var_0 playSound("emt_flood_roof_heli_02");
  var_0 moveto((1734, -1812, 1290), 12);
  wait 5;
  var_1 = spawn("script_origin", (1734, -1812, 1290));
  var_1 playSound("emt_flood_roof_heli_01");
  var_1 moveto((-2255, -1872, 1290), 16);
  wait 13;
  var_2 = spawn("script_origin", (-2963, -613, 1307));
  var_2 playSound("emt_flood_roof_heli_03");
  var_2 moveto((4092, -6121, 2233), 11);
}

sfx_play_chopper_5(var_0) {
  level.destruc_chopper = spawn("script_origin", var_0.origin);
  level.destruc_chopper linkto(var_0);
  wait 1;
  level.destruc_chopper playSound("emt_flood_roof_heli_05");
  level waittill("swept_away");

  if(isDefined(level.destruc_chopper)) {
    level.destruc_chopper stopsounds();
  }
}

sfx_kill_chopper_sound() {
  if(isDefined(level.destruc_chopper)) {
    wait 1;
    level.destruc_chopper stopsounds();
    wait 0.1;
    level.destruc_chopper delete();
  }
}

sfx_chopper_4_play(var_0) {
  var_0 playSound("emt_flood_roof_heli_04");
}

sfx_chooper_wait_and_play(var_0) {
  wait 3;
  var_0 playSound("emt_flood_roof_heli_06");
}

trigger_int_building_hits() {
  var_0 = getent("int_building_shake_sfx_01", "targetname");
  var_0 thread trigger_int_building_hit_01_wait();
  var_1 = getent("int_building_shake_sfx_02", "targetname");
  var_1 thread trigger_int_building_hit_02_wait();
}

trigger_int_building_hit_01_wait() {
  self waittill("trigger");
  level.player playSound("scn_flood_int_building_hit_01");
}

trigger_int_building_hit_02_wait() {
  self waittill("trigger");
  level.player playSound("scn_flood_int_building_hit_02");
}

sfx_rooftop_collapse() {
  level.rooftop_collapse_crumble_01_sfx = spawn("script_origin", (31, -2198, 341));
  level.rooftop_collapse_end_build_sfx = spawn("script_origin", level.player.origin);
  level.rooftop_collapse_end_build_sfx linkto(level.player);
  level.player setclienttriggeraudiozone("flood_mall_rooftop_crumble", 1.0);
  level.player playSound("scn_flood_mall_crumble_build_up");
  wait 2.95;
  thread common_scripts\utility::play_sound_in_space("scn_flood_mall_crumble_building", (539, -2614, 349));
  wait 1.8;
  level.rooftop_collapse_crumble_01_sfx playSound("scn_flood_mall_crumble_01");
  level.rooftop_collapse_end_build_sfx playSound("scn_flood_mall_end_build");
  wait 5.15;
}

sfx_rocket_aiming_sound() {
  wait 1.0;
  thread common_scripts\utility::play_sound_in_space("scn_flood_rocket_launcher_movement_ss", (-1754, -4349, 65));
}

sfx_rocket_explosion_sound(var_0) {
  thread sfx_stop_buzzer("sfx_missiles_launched");
  level.player playSound("scn_flood_rocket_explosion_lr_ss");
  level.player setclienttriggeraudiozone("flood_streets_rocket_launch", 0.1);
  wait 13;
  level.player clearclienttriggeraudiozone(1.0);
  wait 1;
  level.player playSound("scn_flood_rocket_explosion_aftermath_ss");
  wait 4;
  var_1 = spawn("script_origin", (-1585, -2111, 153));
  var_1 playSound("scn_flood_rocket_explosion_aftermath2_ss");
  wait 0.5;
  var_1 moveto((-1536, -4392, 153), 6.5);
}

sfx_mall_ceiling_debris() {
  wait 0.55;
  thread common_scripts\utility::play_sound_in_space("scn_flood_mall_rumble_ceiling_debris_big", (233, -756, 168));
  thread common_scripts\utility::play_sound_in_space("scn_flood_mall_rumble_ceiling_debris_big", (352, -997, 264));
  thread common_scripts\utility::play_sound_in_space("scn_flood_mall_rumble_ceiling_debris_big", (363, -1302, 264));
  thread common_scripts\utility::play_sound_in_space("scn_flood_mall_rumble_ceiling_debris_big", (307, -1436, 304));
}

sfx_mall_exit_door() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkto(level.player);
  level.rooftop_collapse_sfx = spawn("script_origin", level.player.origin);
  level.rooftop_collapse_sfx linkto(level.player);
  thread common_scripts\utility::play_sound_in_space("scn_flood_mall_wave_hit", (498, -1849, 284));
  maps\_utility::delaythread(7, common_scripts\utility::play_sound_in_space, "scn_flood_mall_wave_hit", (498, -1849, 284));
  maps\_utility::delaythread(15, common_scripts\utility::play_sound_in_space, "scn_flood_mall_wave_hit", (498, -1849, 284));
  maps\_utility::delaythread(22, common_scripts\utility::play_sound_in_space, "scn_flood_mall_wave_hit", (498, -1849, 284));
  maps\_utility::delaythread(30, common_scripts\utility::play_sound_in_space, "scn_flood_mall_wave_hit", (498, -1849, 284));
  level.player setclienttriggeraudiozonepartial("flood_mall_fadein", "mix");
  var_0 playLoopSound("scn_flood_mall_rumble_lr_lp");
  wait 0.1;
  level.player clearclienttriggeraudiozone(0.5);
  common_scripts\utility::flag_wait("mall_attack_player");
  level.rooftop_collapse_sfx playSound("scn_flood_mall_rooftop_collapse_lr");
  common_scripts\utility::flag_wait("mall_rooftop_sfx_fadeout");
  level.player playSound("scn_flood_mall_player_fall_01");
  level.player setclienttriggeraudiozone("flood_mall_rooftop_fall", 0.3);
  level.rooftop_collapse_end_build_sfx stopsounds();
  wait 0.2;
  level.rooftop_collapse_end_build_sfx delete();
  wait 1.0;
  level.rooftop_collapse_sfx stopsounds();
  level.rooftop_collapse_crumble_01_sfx stopsounds();
  level waittill("swept_away");
  var_0 delete();
}

sfx_mall_hanging_falling_floor() {
  common_scripts\utility::play_sound_in_space("scn_flood_mall_crumble_02", (201, -2043, 199));
}

sfx_mall_first_screen_shake() {
  level.player playSound("scn_flood_mall_rumble_01");
}

sfx_flood_int_door() {
  var_0 = spawn("script_origin", (312, -1535, 305));
  var_1 = spawn("script_origin", (358, -1587, 305));
  wait 0.1;
  var_1 playLoopSound("scn_flood_door_water");
  wait 1.9;
  var_0 playSound("scn_flood_int_door", "sound_done");
  var_0 waittill("sound_done");
  var_0 delete();
}

rooftops_mix_heli_down() {
  common_scripts\utility::flag_wait("rooftops_exterior_encounter_start");
  wait 8;
  level.player setclienttriggeraudiozone("flood_ending_rooftop_helifade", 10);
  wait 6;
  level.player clearclienttriggeraudiozone(4);
}

sfx_stealth_heli_flyby() {
  level.rooftop_heli playSound("scn_flood_stealth_heli_flyby");
}

sfx_rooftops_wall_kick() {
  wait 12.5;
  self playSound("scn_rooftops_wall_kick");
}

sfx_rooftops_ally_jumpdown() {
  wait 2.6;
  self playSound("scn_rooftops_ally_vault_jumpdown");
}

sfx_rooftops_player_jumpdown() {
  var_0 = getent("sfx_player_rooftop_jumpdown", "targetname");
  var_0 thread trigger_player_jumpdown_wait();
}

trigger_player_jumpdown_wait() {
  self waittill("trigger");
  level.player playSound("scn_rooftops_plr_jumpdown");
}

sfx_rooftops_ally_jump() {
  wait 1.3;
  self playSound("scn_rooftops_ally_vault");
}

sfx_rooftops_player_jump() {
  var_0 = getent("sfx_player_rooftop_vault_land", "targetname");
  var_0 thread trigger_player_jum_wait();
}

trigger_player_jum_wait() {
  self waittill("trigger");
  level.player playSound("scn_rooftops_plr_vault");
}

sfx_heli_rooftops_sequence(var_0) {
  thread sfx_heli_rooftops_wind(var_0);
  wait 0.1;
  thread sfx_heli_rooftops_engine(var_0);
  common_scripts\utility::flag_wait("rooftops_exterior_encounter_start");
  common_scripts\utility::flag_set("rooftop_heli_flyaway");
  level.rooftops_heli_flyaway = spawn("script_origin", var_0.origin);
  level.rooftops_heli_flyaway linkto(var_0);
  level.rooftops_heli_flyaway playSound("scn_flood_rooftop_heli_away");

  if(!common_scripts\utility::flag("rooftop_stairwell_mid")) {
    wait 2;
    var_0 vehicle_turnengineoff();
  } else if(!common_scripts\utility::flag("rooftop_stairwell_top")) {
    wait 0.5;
    var_0 vehicle_turnengineoff();
  } else {
    wait 0.2;
    var_0 vehicle_turnengineoff();
  }

  wait 2.5;
}

sfx_heli_rooftops_wind(var_0) {
  level.heli_wind = spawn("script_origin", (0, 0, 0));
  level.heli_wind hide();
  level.heli_wind endon("death");
  thread common_scripts\utility::delete_on_death(level.heli_wind);
  level.heli_wind.origin = var_0.origin + (0, 0, -200);
  level.heli_wind linkto(var_0);
  level.heli_wind playLoopSound("scn_flood_rooftop_heli_wind_lp");
  common_scripts\utility::flag_wait("rooftop_stairwell_mid");

  if(!common_scripts\utility::flag("rooftop_heli_flyaway")) {
    level.heli_wind_debris = spawn("script_origin", (0, 0, 0));
    level.heli_wind_debris playLoopSound("scn_flood_rooftop_heli_debris_lp");
    level.heli_wind_debris linkto(level.player);
  }

  common_scripts\utility::flag_wait("rooftop_stairwell_top");

  if(common_scripts\utility::flag("rooftop_heli_flyaway") && isDefined(level.heli_wind_debris)) {
    level.heli_wind_debris scalevolume(0, 2);
    wait 2;
    level.heli_wind_debris stoploopsound("scn_flood_rooftop_heli_debris_lp");
    level.heli_wind_debris delete();
  } else {
    common_scripts\utility::flag_wait("rooftop_heli_flyaway");
    wait 5;

    if(isDefined(level.heli_wind_debris)) {
      level.heli_wind_debris scalevolume(0, 3);
      wait 3;
      level.heli_wind_debris stoploopsound("scn_flood_rooftop_heli_debris_lp");
      wait 5;
      level.heli_wind delete();
      level.heli_wind_debris delete();
    }
  }
}

sfx_heli_rooftops_engine(var_0) {
  level.rooftops_heli_engine_lp = spawn("script_origin", var_0.origin);
  level.rooftops_heli_engine_lp linkto(var_0);
  level.rooftops_heli_engine_lp playLoopSound("scn_flood_rooftop_heli_lp");
  level.rooftops_heli_engine_lp endon("death");
  thread common_scripts\utility::delete_on_death(level.rooftops_heli_engine_lp);
  common_scripts\utility::flag_wait("rooftop_stairwell_top");
  wait 10;
  level.rooftops_heli_engine_lp delete();
}

sfx_heli_rooftops_water_idle() {
  self vehicle_turnengineoff();
  level.rooftops_water_heli_engine_lp = spawn("script_origin", self.origin);
  level.rooftops_water_heli_engine_lp linkto(self);
  level.rooftops_water_heli_engine_lp playLoopSound("scn_flood_rooftop_water_heli_lp");
}

sfx_heli_rooftops_water() {
  self playSound("scn_flood_rooftop_water_heli");
  wait 0.5;
  level.rooftops_water_heli_engine_lp stoploopsound();
  wait 2.0;
  self playLoopSound("scn_flood_rooftop_water_heli_debris_lp");
  wait 4.0;
  self stoploopsound();
}

sfx_heli_final_passby() {
  self playSound("scn_flood_final_heli_flyby");
  wait 10.0;
  level.rooftops_final_heli_idle_lp = spawn("script_origin", (6383, 5815, 276));
  level.rooftops_final_heli_idle_lp playLoopSound("scn_flood_final_heli_lp");
}

sfx_heli_dam_passby() {
  self playSound("scn_flood_dam_heli_flyby");
}

sfx_stairwell_wind() {
  level.rooftops_stairwell_wind = spawn("script_origin", (6444, -1315, 392));
  level.rooftops_stairwell_wind playLoopSound("scn_flood_stairwell_wind_lp");
  common_scripts\utility::flag_wait("rooftop_stairwell_top");
  wait 2;
  level.rooftops_stairwell_wind stopsounds();
  level.rooftops_stairwell_wind delete();
}

sfx_stairwell_heli_trig_setup() {
  var_0 = getent("trigger_rooftop_exit_stairwell", "targetname");
  var_0 thread sfx_stairwell_heli_trig();
}

sfx_stairwell_heli_trig() {
  self waittill("trigger");
  common_scripts\utility::flag_set("rooftop_stairwell_top");
}

sfx_stairwell_mid_trig_setup() {
  var_0 = getent("trigger_rooftop_mid_stairwell", "targetname");
  var_0 thread sfx_stairwell_mid_trig();
}

sfx_stairwell_mid_trig() {
  self waittill("trigger");
  common_scripts\utility::flag_set("rooftop_stairwell_mid");
}

flood_convoy_chopper1_sfx() {
  self playSound("scn_flood_convoyheli_01");
}

flood_convoy_chopper2_sfx() {
  self playSound("scn_flood_convoyheli_02");
}

flood_convoy_chopper4_sfx() {
  self playSound("scn_flood_convoyheli_03");
}

flood_convoy_attackheli01_sfx() {
  self playSound("scn_flood_convoy_attackheli_01");
}

flood_convoy_attackheli02_sfx() {
  wait 6.06;
  self playSound("scn_flood_convoy_attackheli_02");
}

flood_convoy_sfx(var_0) {
  if(var_0 == 0) {
    self playSound("scn_flood_convoypass_ss_01");
  }

  if(var_0 == 1) {
    self playSound("scn_flood_convoypass_ss_02");
  }

  if(var_0 == 2) {
    self playSound("scn_flood_convoypass_ss_03");
  }

  if(var_0 == 3) {
    self playSound("scn_flood_convoypass_ss_04");
  }

  if(var_0 == 4) {
    self playSound("scn_flood_convoypass_ss_05");
  }

  if(var_0 == 5) {
    self playSound("scn_flood_convoypass_ss_06");
  }

  if(var_0 == 6) {
    self playSound("scn_flood_convoypass_ss_07");
  }
}

flood_convoy_exp_sfx() {
  var_0 = spawn("script_origin", (-1600, -8900, -9));
  var_1 = spawn("script_origin", (-1600, -8600, -9));
  common_scripts\utility::flag_wait("start_heli_attack");
  wait 3.6;
  var_0 playSound("exp_armor_vehicle");
  wait 6;
  var_0 delete();
  var_1 delete();
}

flood_launcher_crash_sfx() {
  wait 0.75;
  self playSound("scn_flood_mssl_crash_ss");
}

sfx_parking_lot_explode() {
  level.player playSound("scn_flood_parklot_exp_lr_ss");
}

sfx_heli_jump_script(var_0) {
  wait 0.5;
  level.heli_jump = spawn("script_origin", (0, 0, 0));
  level.heli_jump playSound("scn_flood_exfil_part1_lr");
  level.heli_jump2 = spawn("script_origin", (0, 0, 0));
  level.heli_jump2 playSound("scn_flood_exfil_ambhel_lr");
  level.player setclienttriggeraudiozone("flood_exfil_01", 1.5);
  wait 1.5;
  level.ending_heli stopsounds();
}

sfx_change_zone_exfil() {
  level.player setclienttriggeraudiozone("flood_exfil_01", 1.5);
}

sfx_change_zone_exfil2() {
  level.player setclienttriggeraudiozone("flood_exfil_02", 1);
}

sfx_alarms_script(var_0) {
  level.alarms = spawn("script_origin", (0, 0, 0));
  level.alarms playSound("scn_flood_exfil_ambhel_crash_lr");
  level.alarms2 = spawn("script_origin", (0, 0, 0));
  level.alarms2 playLoopSound("scn_flood_heli_alarms");
}

sfx_stop_alarms_script(var_0) {
  if(isDefined(level.alarms)) {
    wait 0.2;
    level.alarms stopsounds();
    wait 0.1;
    level.alarms delete();
  }
}

sfx_slomo_script(var_0) {
  level.slomo = spawn("script_origin", (0, 0, 0));
  level.slomo playSound("scn_flood_exfil_part2_lr");
  level.heli_jump stopsounds();
  thread music_flood_exfil_end();
}

music_flood_exfil_end() {
  wait 2.3;
  maps\_utility::music_play("mus_flood_exfil_crash_ss");
  common_scripts\utility::flag_wait("vignette_ending_qte_grabbed");
  maps\_utility::music_play("mus_flood_exfil_end_ss");
}

sfx_gun_grab_script(var_0) {
  level.gun_grab = spawn("script_origin", (0, 0, 0));
  level.gun_grab playSound("scn_flood_exfil_gun_grab");
}

sfx_ally_grab_script(var_0) {}

sfx_plane_crash_script(var_0) {
  maps\_utility::delaythread(5.0, maps\_utility::music_stop, 1.0);
  level.player setclienttriggeraudiozone("flood_exfil_02", 0);
  level.plane_crash = spawn("script_origin", (0, 0, 0));
  level.plane_crash playSound("scn_flood_exfil_part3_lr");
  level.alarms2 stoploopsound();
  wait 1.1;
  level.player setclienttriggeraudiozone("flood_exfil_01", 0.1);
}

sfx_wake_up_script(var_0) {
  level.wake_up = spawn("script_origin", (0, 0, 0));
  level.wake_up playSound("scn_flood_exfil_wake01_lr");
}

sfx_let_go() {}

sfx_save_script(var_0) {
  wait 0.1;
}

play_helicopter_leaving_sound() {
  level.ending_heli playSound("scn_flood_exfil_helicopter_intro");
  wait 2.0;

  if(isDefined(level.rooftops_final_heli_idle_lp)) {
    level.rooftops_final_heli_idle_lp stoploopsound();
  }
}

sfx_play_outofwater_sound() {
  level.player playSound("scn_flood_stairwell_plr");
}

sfx_small_rumble_loop() {
  common_scripts\utility::flag_wait("player_at_stairs");

  while(!common_scripts\utility::flag("event_quaker_big")) {
    wait(randomfloatrange(4, 8));
    level.player playSound("scn_flood_mall_rumble_shake_int");
    level.player playSound("scn_flood_mall_rumble_ceiling_debris");
    level.player playSound("scn_flood_mall_rumble_ceiling_debris");
    level.player playSound("scn_flood_mall_rumble_ceiling_debris");
  }
}

sfx_change_zone() {
  level.player setclienttriggeraudiozone("flood_exfil_03", 1);
  wait 1;
  level.heli_loop stoploopsound();
}

sfx_fail01() {
  wait 0.5;
  level.player playSound("scn_flood_exfil_wake01_fail");
}

sfx_let_go_fail() {
  wait 1;
  level.player playSound("scn_flood_exfil_wake03_fail");
}

sfx_last_pass() {
  wait 0.2;
  level.player playSound("scn_flood_exfil_wake03_pass");
}

sfx_wakeup() {
  level.player playSound("scn_flood_exfil_wake02_lr");
  level.heli_loop = spawn("script_origin", (0, 0, 0));
  level.heli_loop playLoopSound("scn_flood_exfil_wake02_lp_lr");
}

sfx_exfil_slomo01() {
  wait 1.5;
  level.player setclienttriggeraudiozone("flood_exfil_02", 1);
  wait 1;
  level.player setclienttriggeraudiozone("flood_exfil_01", 0.5);
}

sfx_exfil_slomo00() {
  level.player setclienttriggeraudiozone("flood_exfil_01", 0.1);
}

sfx_boss_shot_begin() {
  level.player setclienttriggeraudiozone("flood_exfil_04", 2);
}

sfx_boss_shot_end() {
  level.player setclienttriggeraudiozone("flood_exfil_01", 0.1);
  level.player playSound("scn_flood_exfil_part3hit_lr");
}

flood_streets_distant_helipass() {
  var_0 = spawn("script_origin", (-1680, -1800, 450));
  var_1 = spawn("script_origin", (-1680, -1800, 450));
  wait 2.5;
  var_0 playSound("scn_flood_convoyheli_02");
  wait 0.3;
  var_1 playSound("scn_flood_convoyheli_03");
  wait 5;
  var_0 delete();
  var_1 delete();
}

sfx_deathsdoor_end_underwater() {
  level endon("cw_player_abovewater");

  for(;;) {
    waittillframeend;

    if(!isDefined(level._audio.in_deathsdoor)) {
      if(isDefined(level.swept_away) && level.swept_away == 0) {
        level.player setclienttriggeraudiozone("flood_underwater", 0);
      }

      return;
    }

    wait 0.05;
  }
}

sfx_flood_end_notetrack(var_0) {
  level.player playSound("scn_flood_swept_away_pt3_lr_ss");
}

sfx_looping_rorke() {
  var_0 = spawn("script_origin", (5807, 2624, 545));
  var_0 playLoopSound("flood_rke_outro_loop");
  common_scripts\utility::flag_wait("vignette_ending_qte_grabbed");
  wait 0.5;
  var_0 stoploopsound();
}