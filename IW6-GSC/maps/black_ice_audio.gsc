/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_audio.gsc
*****************************************************/

main() {
  audio_flag_init();
  sfx_black_ice_node_init();
  precacheshellshock("default_nosound");
  thread sfx_wind_trigger_setup();
  thread sfx_tvs_heaters_setup();
  thread sfx_fire_tower_triggers();
  thread sfx_metal_beam_event();
  thread sfx_command_warning_sfx();
  thread sfx_derrick_expl_init();
  thread sfx_tanks_wind_gust_trigger();
  var_0 = getent("pre_common_room", "targetname");
  var_0 thread precommon_sound();
}

audio_flag_init() {
  common_scripts\utility::flag_init("sfx_stop_dist_oil_rig");
  common_scripts\utility::flag_init("sfx_stop_blackice_alarm");
  common_scripts\utility::flag_init("sfx_ascend_done");
  common_scripts\utility::flag_init("sfx_rumble_ok");
  common_scripts\utility::flag_init("sfx_stop_pa");
  common_scripts\utility::flag_init("heli_mudpumps_in");
  common_scripts\utility::flag_init("sfx_stop_heli_squibs");
  common_scripts\utility::flag_init("sfx_stop_heli_shells");
  common_scripts\utility::flag_init("sfx_lever_green");
  common_scripts\utility::flag_init("sfx_lever_yellow");
  common_scripts\utility::flag_init("sfx_lever_red");
  common_scripts\utility::flag_init("sfx_warning_playing");
  common_scripts\utility::flag_init("sfx_rumbles_playing");
  common_scripts\utility::flag_init("minigame_practice_over");
  common_scripts\utility::flag_init("sfx_cam_mvmt_gate");
  common_scripts\utility::flag_init("sfx_common_breach_start");
}

sfx_tvs_heaters_setup() {
  var_0 = getEntArray("blackice_tv", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::sfx_tv_thread);
  var_1 = getscriptablearray("blackice_heater", "targetname");
  common_scripts\utility::array_thread(var_1, ::sfx_heaters_thread);
}

sfx_tv_thread() {
  self playLoopSound("emt_blackice_camp_tv_static_lp");
  self waittill("death");
  self stoploopsound();
}

sfx_heaters_thread() {
  self playLoopSound("emt_blackice_camp_heater_hum_lp");
  self waittill("death");
  self stoploopsound();
}

sfx_distant_alarm() {
  common_scripts\utility::flag_wait("bc_flag_alarm_start");
  var_0 = spawn("script_origin", (-888, 4735, 1645));
  var_1 = spawn("script_origin", (290, 3048, 1645));
  var_2 = spawn("script_origin", (-1206, 4411, 1645));
  var_0 playLoopSound("emt_blackice_alarm_dist_lt_lp");
  var_1 playLoopSound("emt_blackice_alarm_dist_rt_lp");
  var_2 playLoopSound("emt_blackice_alarm_lp");
  common_scripts\utility::flag_wait("sfx_stop_blackice_alarm");
  wait 4;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

sfx_fire_tower_spawn() {
  for(var_0 = 12; var_0 < 18; var_0++)
    level.sfx_black_ice_nodes[var_0] playLoopSound(level.sfx_black_ice_nodes[var_0].soundalias);
}

sfx_flare_stack_burn() {
  level waittill("notify_dialogue_baker_enter_complete");
  wait 1.5;
  thread sfx_flare_stack_amb_emt();
  var_0 = spawn("script_origin", (-4745, 3844, 1950));
  var_0 playLoopSound("emt_blackice_flarestack_burn_lp");
  level waittill("notify_flare_stack_button_press");
  thread sfx_flare_stack_shutdown();
  wait 0.5;
  var_0 delete();
}

sfx_flare_stack_amb_emt() {
  wait 0.1;
  var_0 = spawn("script_origin", (-3533, 4322, 1931));
  var_0 playLoopSound("emt_blackice_server_hum_lp");
  var_1 = spawn("script_origin", (-3573, 4378, 1928));
  var_1 playLoopSound("emt_blackice_computer_hum_01_lp");
  var_2 = spawn("script_origin", (-3577, 4452, 1928));
  var_2 playLoopSound("emt_blackice_computer_hum_02_lp");
  var_3 = spawn("script_origin", (-3577, 4470, 1928));
  var_3 playLoopSound("emt_blackice_relay_clicks_lp");
  var_4 = spawn("script_origin", (-3394, 4626, 1926));
  var_4 playLoopSound("emt_blackice_server_hum_lp");
  var_5 = spawn("script_origin", (-3573, 4587, 1921));
  var_5 playLoopSound("emt_blackice_computer_hum_01_lp");
  var_6 = spawn("script_origin", (-3585, 4428, 1966));
  var_6 playLoopSound("emt_blackice_int_wind_lp");
  var_7 = spawn("script_origin", (-3394, 4408, 2003));
  var_7 playLoopSound("emt_light_fluorescent_hum3_int");
  var_8 = spawn("script_origin", (-3492, 4408, 2003));
  var_8 playLoopSound("emt_light_fluorescent_hum3_int");
  var_9 = spawn("script_origin", (-3396, 4579, 2003));
  var_9 playLoopSound("emt_light_fluorescent_hum2_int");
  var_10 = spawn("script_origin", (-3490, 4578, 2003));
  var_10 playLoopSound("emt_light_fluorescent_hum3_int");
  level waittill("notify_flare_stack_button_press");
  wait 0.1;
  var_3 delete();
  level waittill("notify_refinery_explosion_start");
  wait 1;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_4 delete();
  var_5 delete();
  var_6 delete();
  var_7 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
}

sfx_flare_stack_shutdown() {
  wait 0.1;
  var_0 = spawn("script_origin", (-4740, 3840, 1945));
  var_0 playSound("emt_blackice_flarestack_turnoff_ss");
  thread sfx_flare_stack_arm_expl();
  wait 7;
  var_0 delete();
}

sfx_flare_stack_arm_expl() {
  wait 1.4;
  level.player playSound("scn_blackice_flarestack_pipe_stress");
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("scn_blackice_flarestack_mtl_arm", (-4496, 3815, 1842));
}

sfx_camera_intro() {
  wait 0.2;
  level.player playSound("scn_blackice_intro_lr");
  thread sfx_intro_sweeteners();
  wait 25;
  level.player setclienttriggeraudiozone("blackice_underwater", 2);
}

sfx_camera_mvmt() {
  if(!common_scripts\utility::flag("sfx_cam_mvmt_gate")) {
    common_scripts\utility::flag_set("sfx_cam_mvmt_gate");
    level.player playSound("scn_blackice_intro_cam_mvmt");
    wait 0.3;
    common_scripts\utility::flag_clear("sfx_cam_mvmt_gate");
  }
}

sfx_breach_plant_charges() {}

sfx_breach_detonate() {
  wait 0.3;
  level.player playSound("scn_blackice_infil_expl_charges");
  level.player clearclienttriggeraudiozone(2);
  thread sfx_underwater_combat_amb();
}

sfx_underwater_combat_amb() {
  wait 13;
  level.underwater_combat_amb = spawn("script_origin", level.player.origin);
  level.underwater_combat_amb linkto(level.player);
  level.underwater_combat_amb playLoopSound("scn_blackice_infil_combat_amb");
  common_scripts\utility::flag_wait("flag_player_breaching");
  wait 2;
  level.underwater_combat_amb stoploopsound("scn_blackice_infil_combat_amb");
  level.underwater_combat_amb delete();
}

sfx_intro_sweeteners() {
  wait 12.8;
  level.player playSound("scn_blackice_intro_snowmobiles_swt");
  wait 2;
  level.player playSound("scn_blackice_intro_hummer_swt");
}

sfx_hummer_over() {}

sfx_player_exits_water() {
  level.player playSound("scn_blackice_water_emerge_ss");
  level.player playSound("elm_blackice_windgust");
  maps\_utility::music_stop(8);
  wait 2;
}

sfx_truck_sinking() {
  wait 4.8;
  thread common_scripts\utility::play_sound_in_space("scn_blackice_truck_sinking", (-3540, 122, 237));
}

sfx_heli_over() {
  waittillframeend;
  level.player playSound("scn_blackice_heli_flyover_lr");
}

sfx_hangardoor_amb() {
  wait 0.2;
}

sfx_distant_oil_rig() {
  wait 0.1;
  var_0 = spawn("script_origin", (-1679, 2928, 1000));
  var_0 playLoopSound("emt_oil_rig_dist_lp");
  common_scripts\utility::flag_wait("sfx_stop_dist_oil_rig");
  wait 10;
  var_0 delete();
}

sfx_stop_dist_oil_rig() {
  common_scripts\utility::flag_set("sfx_stop_dist_oil_rig");
}

sfx_blackice_door_rollup(var_0) {
  var_0 playSound("scn_blackice_door_rollup");
}

sfx_blackice_helo_flyby() {
  self playSound("scn_blackice_heli_camp_flyover");
}

sfx_blackice_rig_start_ss() {
  level.player playSound("scn_blackice_rig_start_ss");
}

sfx_blackice_rig_start2_ss() {
  level.player playSound("scn_blackice_rig_start2_ss");
  wait 1;
  thread blackice_pre_ascend_music();
}

sfx_blackice_rig_start3_ss() {
  wait 0.3;
  level.player playSound("scn_blackice_rig_start3_ss");
}

sfx_stop_ascent_sounds() {
  wait 2;
  level.sfx_ascend_node stopsounds();
  wait 0.1;
  level.sfx_ascend_node delete();
}

sfx_rig_ascend_logic(var_0) {
  if(!isDefined(level.sfx_ascend_node)) {
    return;
  }
  if(var_0 == "go" && var_0 != level.sfx_ascend_check) {
    level.sfx_ascend_check = var_0;
    level.sfx_ascend_node stopsounds();
    level.sfx_ascend_node playSound("scn_blackice_rig_ascend_ss");
  } else if(var_0 == "stop" && var_0 != level.sfx_ascend_check) {
    level.sfx_ascend_check = var_0;
    level.player playSound("scn_blackice_rig_stop_ss");
    thread sfx_stop_ascend_sound_wait(0.5);
  }
}

sfx_stop_ascend_sound_wait(var_0) {
  wait 0.1;

  if(level.sfx_ascend_check == "stop")
    level.sfx_ascend_node stopsounds();
}

sfx_wind_trigger_setup() {
  var_0 = getent("trigger_ascend_wind_01", "targetname");
  var_0 thread sfx_ascend_wind_01();
  var_1 = getent("trigger_ascend_wind_02", "targetname");
  var_1 thread sfx_ascend_wind_02();
  var_2 = getent("trigger_ascend_wind_03", "targetname");
  var_2 thread sfx_ascend_wind_03();
}

sfx_ascend_wind_01() {
  self waittill("trigger");
  level.ascend_wind_01 = spawn("script_origin", level.player.origin);
  level.ascend_wind_01 linkto(level.player);
  level.ascend_wind_01 playLoopSound("scn_blackice_ascend_wind_01");
}

sfx_ascend_wind_02() {
  self waittill("trigger");
  level.ascend_wind_02 = spawn("script_origin", level.player.origin);
  level.ascend_wind_02 linkto(level.player);
  level.ascend_wind_02 playLoopSound("scn_blackice_ascend_wind_02");

  if(isDefined(level.ascend_wind_01)) {
    wait 4;
    level.ascend_wind_01 stoploopsound();
    level.ascend_wind_01 delete();
  }
}

sfx_ascend_wind_03() {
  self waittill("trigger");
  level.ascend_wind_03 = spawn("script_origin", level.player.origin);
  level.ascend_wind_03 linkto(level.player);
  level.ascend_wind_03 playLoopSound("scn_blackice_ascend_wind_03");

  if(isDefined(level.ascend_wind_02)) {
    wait 4;
    level.ascend_wind_02 stoploopsound();
    level.ascend_wind_02 delete();
  }
}

sfx_ascend_wind_last() {
  thread sfx_ascend_wind_03_fade();
  wait 2;
  level.ascend_wind_04 = spawn("script_origin", level.player.origin);
  level.ascend_wind_04 linkto(level.player);
  level.ascend_wind_04 playLoopSound("scn_blackice_ascend_wind_02");
  wait 3;
  thread sfx_stop_dist_oil_rig();
  wait 12;
  level.ascend_wind_04 stoploopsound();
  level.ascend_wind_04 delete();
}

sfx_ascend_wind_03_fade() {
  if(isDefined(level.ascend_wind_03)) {
    wait 5;
    level.ascend_wind_03 stoploopsound();
    level.ascend_wind_03 delete();
  }
}

sfx_cargo_sway() {
  var_0 = spawn("script_origin", (-1546, 2479, 1276));
  var_0 playLoopSound("emt_blackice_cargo_sway");
  level waittill("notify_damage_breacher");
  var_0 delete();
}

sfx_cargo_lift(var_0) {
  level.cargo_lift = spawn("script_origin", var_0.origin + (0, 0, -700));
  level.cargo_lift linkto(var_0);
  level.cargo_lift playSound("scn_blackice_cargo_lift");
  wait 21;
  level.cargo_lift delete();
}

sfx_cargo_hatch() {
  wait 0.2;
  thread common_scripts\utility::play_sound_in_space("scn_blackice_cargo_hatch", (-1461, 3691, 1695));
}

sfx_cw_door_open(var_0) {
  var_0 playSound("scn_blackice_catwalk_mtl_door");
}

sfx_catwalk_guy_over_railing() {
  wait 0.8;
  self playSound("scn_blackice_catwalk_guy_over_rail");
}

sfx_exited_flarestack() {
  common_scripts\utility::flag_set("sfx_rumble_ok");
}

sfx_black_ice_node_init() {
  level.sfx_black_ice_nodes = [];
  level.sfx_fire_tower_lookat_flag = 0;
  level.sfx_fire_tower_lookat_section = 0;
  sfx_node_array_init((1367, 3969, 3367), "emt_fire_tower_dist_lp", 0);
  sfx_node_array_init((1367, 3977, 2460), "emt_fire_tower_close_lp", 1);
  sfx_node_array_init((1367, 3977, 2460), "emt_fire_tower_close2_lp", 2);
  sfx_node_array_init((1106, 3239, 2732), "emt_fire_tower_metal_dist_lp", 3);
  sfx_node_array_init((1468, 3386, 3099), "emt_fire_tower_metal_med_lp", 4);
  sfx_node_array_init((1143, 4491, 2712), "emt_fire_tower_metal_med2_lp", 5);
  sfx_node_array_init((1877, 2785, 2426), "emt_fire_tower_metal_close_01_lp", 6);
  sfx_node_array_init((1740, 2514, 2492), "emt_fire_tower_metal_close_02_lp", 7);
  sfx_node_array_init((1536, 2261, 2416), "emt_fire_tower_metal_close_03_lp", 8);
  sfx_node_array_init((1415, 3054, 2457), "emt_fire_tower_metal_close_04_lp", 9);
  sfx_node_array_init((-1185, 4836, 2212), "null", 10);
  sfx_node_array_init((-1185, 3785, 2212), "null", 11);
  sfx_node_array_init((1367, 3969, 3367), "emt_fire_tower_disteye_lp", 12);
  sfx_node_array_init((1367, 3977, 2683), "emt_fire_tower_closeeye_lp", 13);
  sfx_node_array_init((1367, 3977, 2683), "emt_fire_tower_close2eye_lp", 14);
  sfx_node_array_init((1367, 3977, 2683), "emt_fire_tower_closehigheye_lp", 15);
  sfx_node_array_init((1830, 3495, 2565), "emt_fire_tower_close2_lp", 16);
  sfx_node_array_init((1739, 3867, 2539), "emt_fire_tower_close2_lp", 17);
}

sfx_node_array_init(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_0);
  var_3.soundalias = var_1;
  var_3.refnum = var_2;
  level.sfx_black_ice_nodes[level.sfx_black_ice_nodes.size] = var_3;
}

sfx_play_suppression_sounds() {
  if(!isDefined(level.sound_water_suppression))
    level.sound_water_suppression = 1;
}

sfx_fire_tower_triggers() {
  level.sfx_fire_tower_trigger_array = [];
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_1", 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, "blackice_oil_rain_ext");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_2", 0.6, 0, 0, 0.6, 0.6, 0, 0, 0, 0, 0, "blackice_oil_rain_ext");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_3", 0.6, 0, 0, 0.6, 0.6, 0, 0, 0, 0, 0, "blackice_oil_rain_ext");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_4", 0.2, 0, 0, 0.2, 0.2, 0, 0, 0, 0, 0, "blackice_oil_rain_int");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_5", 0.2, 0, 0, 0.2, 0.2, 0, 0, 0, 0, 0, "blackice_oil_rain_int");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_6", 0.8, 0.8, 0, 0, 1, 1, 0, 0, 0, 0, "blackice_oil_rain_ext");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_7", 0.8, 0.8, 0, 0, 1, 1, 0, 0, 0, 0, "blackice_oil_rain_ext");
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_8", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "blackice_oil_rain_int", 0);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_9", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "blackice_oil_rain_int", 0);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_10", 0, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, "blackice_oil_rain_ext", 1);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_11", 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, "blackice_oil_rain_ext", 2);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_12", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "blackice_oil_rain_int", 0);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_13", 0, 0, 0, 0.4, 0.4, 0.4, 0, 0, 0, 0, "blackice_oil_rain_int", 2);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_14", 0, 0, 0, 0.7, 0.7, 0, 0, 0, 0, 0, "blackice_oil_rain_ext", 3);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_15", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "blackice_oil_rain_ext", 2);
  sfx_fire_tower_triggers_init("sfx_fire_tower_trigger_16", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "blackice_oil_rain_ext", 2);
  var_0 = [];

  for(var_1 = 0; var_1 < level.sfx_fire_tower_trigger_array.size; var_1++)
    var_0[var_1] = getent(level.sfx_fire_tower_trigger_array[var_1].trig, "targetname");
}

sfx_fire_tower_triggers_init(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = spawnStruct();
  var_13.trig = var_0;
  var_13.vol = [];
  var_13.vol[0] = var_1;
  var_13.vol[1] = var_2;
  var_13.vol[2] = var_3;
  var_13.vol[3] = var_4;
  var_13.vol[4] = var_5;
  var_13.vol[5] = var_6;
  var_13.vol[6] = var_7;
  var_13.vol[7] = var_8;
  var_13.vol[8] = var_9;
  var_13.vol[9] = var_10;
  var_13.filter = var_11;

  if(isDefined(var_12))
    var_13.lookatnum = var_12;
  else
    var_13.lookatnum = 0;

  level.sfx_fire_tower_trigger_array[level.sfx_fire_tower_trigger_array.size] = var_13;
}

sfx_fire_tower_trigger_logic(var_0, var_1) {
  for(var_2 = 12; var_2 < 18; var_2++)
    level.sfx_black_ice_nodes[var_2] playLoopSound(level.sfx_black_ice_nodes[var_2].soundalias);
}

sfx_generic_node_delete(var_0, var_1) {
  if(!isDefined(var_1)) {
    if(isDefined(level.sfx_black_ice_nodes[var_0]))
      level.sfx_black_ice_nodes[var_0] delete();
  } else {
    for(var_2 = var_0; var_2 < var_1 + 1; var_2++) {
      if(isDefined(level.sfx_black_ice_nodes[var_2]))
        level.sfx_black_ice_nodes[var_2] delete();
    }
  }
}

hall_search_music() {
  wait 0.2;
}

sfx_metal_beam_event() {
  var_0 = getent("audio_metal_beam_event", "script_noteworthy");
  var_1 = getent("audio_metal_beam_event_move", "script_noteworthy");
  var_0 waittill("trigger");
  maps\_utility::delaythread(0.01, common_scripts\utility::play_sound_in_space, "emt_metal_beam_settle_rumble_ss", (1787, 2822, 2370));
  maps\_utility::delaythread(1.2, common_scripts\utility::play_sound_in_space, "emt_metal_beam_settle_01_ss", (1689, 2800, 2316));
  maps\_utility::delaythread(4.4, common_scripts\utility::play_sound_in_space, "emt_metal_beam_settle_02_ss", (2442, 2855, 2316));
  var_1 waittill("trigger");
  maps\_utility::delaythread(0.5, common_scripts\utility::play_sound_in_space, "emt_metal_beam_settle_trigger_ss", (1787, 2822, 2370));
}

sfx_spawn_refinery_fire_nodes() {
  wait 5;
  level.refinery_fire_01 = spawn("script_origin", (-2217, 3667, 2320));
  level.refinery_fire_01 playLoopSound("emt_blackice_fire_huge_lp");
  level.refinery_fire_02 = spawn("script_origin", (-2270, 3637, 2284));
  level.refinery_fire_02 playLoopSound("emt_blackice_fire_med_lp");
  level.refinery_fire_03 = spawn("script_origin", (-2755, 3896, 2284));
  level.refinery_fire_03 playLoopSound("emt_blackice_fire_sm_lp");
  level.refinery_fire_04 = spawn("script_origin", (-2899, 3711, 2284));
  level.refinery_fire_04 playLoopSound("emt_blackice_fire_sm_lp");
}

sfx_delete_refinery_fire_nodes() {
  wait 1;

  if(isDefined(level.refinery_fire_01)) {
    level.refinery_fire_01 stoploopsound();
    level.refinery_fire_02 stoploopsound();
    level.refinery_fire_03 stoploopsound();
    level.refinery_fire_04 stoploopsound();
    wait 0.1;
    level.refinery_fire_01 delete();
    level.refinery_fire_02 delete();
    level.refinery_fire_03 delete();
    level.refinery_fire_04 delete();
  }
}

sfx_start_flarestack_room_siren() {
  wait 0.2;
  level.flarestack_siren = spawn("script_origin", (-3392, 4306, 1963));
  level.flarestack_siren playLoopSound("emt_blackice_flarestack_alarm_02_lp");
}

sfx_flarestack_door_open() {
  wait 2.9;
  level.flarestack_door = spawn("script_origin", (-3438, 4200, 1948));
  level.flarestack_door playSound("scn_blackice_flarestack_door_open");
}

sfx_spawn_refinery_alarm_node() {
  wait 6;
  level.refinery_alarm_dist = spawn("script_origin", (-2206, 4286, 2352));
  level.refinery_alarm_dist playLoopSound("emt_blackice_flarestack_alarm_05_lp");
}

sfx_delete_refinery_alarm_node() {
  wait 2;

  if(isDefined(level.refinery_alarm_dist)) {
    level.refinery_alarm_dist stoploopsound();
    wait 0.1;
    level.refinery_alarm_dist delete();
  }

  sfx_stop_pa_bursts();
}

sfx_russian_panic_dx() {
  wait 0.1;
  level.rus_panic_os = spawn("script_origin", (-2683, 3703, 2284));
  wait 0.2;
  wait 3;
  level.rus_panic_os delete();
}

sfx_stop_pa_bursts() {
  common_scripts\utility::flag_set("sfx_stop_pa");
}

sfx_pa_bursts() {
  wait 12;
  level.pa_bursts = spawn("script_origin", (-2170, 4050, 2480));

  while(!common_scripts\utility::flag("sfx_stop_pa")) {
    level.pa_bursts playSound("emt_blackice_pa_burst");
    wait(randomfloatrange(5.0, 9.0));
  }

  level.pa_bursts delete();
}

sfx_long_pipe_bursts() {
  wait 1.1;
  var_0 = spawn("script_origin", (-2372, 3402, 2725));
  var_0 playSound("scn_blackice_long_pipe_bursts");
  thread sfx_play_pipe_sounds();
}

sfx_play_pipe_sounds() {
  var_0 = spawn("script_origin", (-2372, 3402, 2725));
  var_0 playSound("scn_blackice_flarestack_pipe_stress2");
}

audio_derrick_explode_logic(var_0) {
  if(var_0 == "start") {
    wait 2.5;
    level.flarestack_pressurelp_01 = spawn("script_origin", (-2372, 3402, 2725));
    level.flarestack_pressurelp_01 playLoopSound("scn_blackice_flarestack_pressure_01_lp");
    level.flarestack_pressurelp_02 = spawn("script_origin", (-2300, 5516, 2725));
    level.flarestack_pressurelp_02 playLoopSound("scn_blackice_flarestack_pressure_02_lp");
    wait 0.1;
    thread sfx_stereo_quake();
    wait 1.3;
    level.flarestack_alarm_01 = spawn("script_origin", (-3365, 3372, 2148));
    level.flarestack_alarm_01 playLoopSound("emt_blackice_flarestack_alarm_01_lp");
  } else {
    thread derrick_pop_and_explode();
    thread sfx_derrick_mix_change();
    thread common_scripts\utility::play_sound_in_space("scn_blackice_derrick_exp5_ss", (643, 3873, 3294));
    thread sfx_spawn_refinery_fire_nodes();
    thread sfx_spawn_refinery_alarm_node();
    wait 0.2;
    level.flarestack_alarm_01 stoploopsound();
    level.flarestack_pressurelp_01 stoploopsound();
    level.flarestack_pressurelp_02 stoploopsound();

    if(isDefined(level.flarestack_quake_lp_01))
      level.flarestack_quake_lp_01 stoploopsound();

    wait 0.1;
    level.flarestack_alarm_01 delete();
    level.flarestack_pressurelp_01 delete();
    level.flarestack_pressurelp_02 delete();

    if(isDefined(level.flarestack_quake_lp_01))
      level.flarestack_quake_lp_01 delete();

    thread sfx_playing_fire_tower_sounds();
    wait 4.1;
    thread derrick_metal_debris_sfx();
    thread common_scripts\utility::play_sound_in_space("scn_blackice_drk_explo_debris01", (-2781, 3665, 2284));
    thread common_scripts\utility::play_sound_in_space("scn_blackice_drk_explo_debris01", (-2781, 3665, 2284));
    wait 0.2;
    thread common_scripts\utility::play_sound_in_space("scn_blackice_drk_explo_debris02", (-2600, 3909, 2284));
    wait 1.74;
    thread common_scripts\utility::play_sound_in_space("scn_blackice_drk_explo_debris03", (-2736, 3513, 2293));
  }
}

sfx_blackice_cmd_fire() {
  var_0 = spawn("script_origin", (2521, 5754, 2748));
  var_1 = spawn("script_origin", (2566, 5849, 2748));
  var_2 = spawn("script_origin", (2335, 5800, 2748));
  wait 0.01;
  var_0 playLoopSound("emt_blackice_fire_sm_lp");
  var_1 playLoopSound("smallfire");
  var_2 playLoopSound("emt_blackice_fire_sm_lp");
}

derrick_metal_debris_sfx() {
  var_0 = spawn("script_origin", (-2780, randomintrange(3237, 4033), 2284));
  var_1 = spawn("script_origin", (-2780, randomintrange(3237, 4033), 2284));
  var_2 = spawn("script_origin", (-2780, randomintrange(3237, 4033), 2284));
  var_3 = spawn("script_origin", (-2780, randomintrange(3237, 4033), 2284));
  wait 1.7;
  var_0 playSound("scn_blackice_derrick_exp_debris");
  wait 0.4;
  var_1 playSound("scn_blackice_derrick_exp_debris");
  wait 0.6;
  var_2 playSound("scn_blackice_derrick_exp_debris");
  wait 0.4;
  var_3 playSound("scn_blackice_derrick_exp_debris");
  wait 4;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
}

derrick_pop_and_explode() {
  thread sfx_other_derrick_explosions();
  wait 0.1;
  thread common_scripts\utility::play_sound_in_space("scn_blackice_derrick_exp_pop_ss", (643, 3873, 3294));
}

sfx_other_derrick_explosions() {
  level.player playSound("scn_blackice_derrick_exp_ss");
  wait 1.5;
  level.player playSound("scn_blackice_derrick_exp2_ss");
}

sfx_blackice_derrick_exp4_ss() {
  thread common_scripts\utility::play_sound_in_space("scn_blackice_derrick_exp4_ss", (643, 3873, 3294));
}

sfx_playing_fire_tower_sounds() {
  sfx_fire_tower_spawn();
}

sfx_blackice_derrick_exp6_ss() {
  thread common_scripts\utility::play_sound_in_space("scn_blackice_derrick_exp6_ss", (-2135, 3711, 2360));
  thread sfx_postderrick_pressure();
}

sfx_postderrick_pressure() {
  var_0 = spawn("script_origin", (-2450, 2863, 2533));
  var_1 = spawn("script_origin", (-2153, 4850, 2354));
  var_2 = spawn("script_origin", (-857, 4053, 2514));
  var_3 = spawn("script_origin", (-403, 3001, 2514));
  wait 0.1;
  var_0 playLoopSound("scn_blackice_pressure_01_lp");
  var_1 playLoopSound("scn_blackice_pressure_02_lp");
  var_2 playLoopSound("scn_blackice_pressure_01_lp");
  var_3 playLoopSound("scn_blackice_pressure_02_lp");
}

sfx_stereo_quake() {
  level.player playSound("scn_blackice_flarestack_quake_ss");
  level.flarestack_quake_lp_01 = spawn("script_origin", (-3610, 4413, 1948));
  level.flarestack_quake_lp_01 playLoopSound("emt_blackice_flarestack_quake_lp");
  wait 9;
  level.player playSound("scn_blackice_flarestack_quake_ss");
}

sfx_blackice_catwalk_collapse(var_0) {
  var_0 playSound("scn_blackice_catwalk_collapse");
}

sfx_pre_engine_room() {
  maps\_utility::delaythread(0.001, common_scripts\utility::play_sound_in_space, "scn_blackice_tanks_engine_explo", (796, 2886, 2096));
  maps\_utility::delaythread(1.2, common_scripts\utility::loop_fx_sound, "emt_blackice_engine_fire_alarm_lp", (1090, 2866, 2160));
  level.player playSound("scn_blackice_tanks_dist_explo");
}

sfx_blackice_engine_beam_fall(var_0) {
  var_0 thread common_scripts\utility::delaycall(0.65, ::playsound, "scn_blackice_engine_beam_fall");
  level.player playSound("scn_blackice_engine_beam_fall_swtner");
}

sfx_blackice_fire_extinguisher_spray(var_0) {
  var_0 maps\_utility::play_sound_on_tag("scn_blackice_fire_extinguisher_spray", "tag_fx");
}

sfx_blackice_catwalk_explode() {
  level._tanks.pipe playSound("scn_blackice_catwalk_explode");
}

sfx_hand_scan() {
  wait 2;
  thread common_scripts\utility::play_sound_in_space("scn_blackice_hand_scanner", (-3570, 4385, 1930));
}

sfx_use_console() {
  level.player playSound("scn_blackice_command_console_use");
}

sfx_command_warning_sfx() {
  level waittill("notify_activate_flarestack_console");
  var_0 = spawn("script_origin", (-3567, 4412, 1932));
  var_0 playSound("scn_blackice_command_console_raise");
  wait 0.1;
  var_1 = spawn("script_origin", (-3567, 4412, 1930));
  var_1 playLoopSound("scn_blackice_command_warning_lp");
  level waittill("notify_flare_stack_button_press");
  var_1 stoploopsound();
  var_1 delete();
  sfx_computer_error();
}

sfx_computer_error() {
  wait 0.75;
  var_0 = spawn("script_origin", (-3573, 4421, 1939));
  var_0 playLoopSound("scn_blackice_computer_warning_lp");
}

sfx_screenshake() {
  if(common_scripts\utility::flag("sfx_rumble_ok")) {
    common_scripts\utility::flag_clear("sfx_rumble_ok");
    level.player playSound("scn_blackice_screenshake");
    wait 1;
    common_scripts\utility::flag_set("sfx_rumble_ok");
  }
}

sfx_black_ice_tanks_rumble() {
  level.player playSound("scn_black_ice_tanks_rumble");
}

sfx_blackice_tanks_dist_explo() {
  thread sfx_death_stop_rumbles();
  thread sfx_death_stop_turbines();
  wait 0.1;
  level.player playSound("scn_blackice_tanks_dist_explo");
}

sfx_tanks_wind_gust_trigger() {}

sfx_tanks_door_open() {
  thread common_scripts\utility::play_sound_in_space("scn_blackice_tanks_door_open", (761, 2887, 2114));
}

sfx_blackice_engine_dist_explo() {
  level.player playSound("scn_blackice_engine_dist_explo");
}

sfx_blackice_exfil_heli() {
  level.heli playSound("scn_blackice_exfil_heli");
}

sfx_tape_breach(var_0) {
  wait 0.6;
  var_0 playSound("scn_blackice_door_breach_01_ss");
  thread sfx_blackice_doorway_wind_emt_barracks();
}

sfx_blackice_doorway_wind_emt_barracks() {
  var_0 = spawn("script_origin", (-1409, 4615, 1586));
  wait 5.0;
  var_0 playLoopSound("emt_wind_barracks_doorway_lp");
}

precommon_sound() {
  self waittill("trigger");
  thread precommon_scripted_bc();
  level.precommon = spawn("script_origin", (-2636, 4609, 1931));
  level.precommon playSound("scn_blackice_common_prebreach");
}

precommon_scripted_bc() {
  level.precommon_bc = spawn("script_origin", (-2636, 4609, 1931));

  while(!common_scripts\utility::flag("sfx_common_breach_start")) {
    level.precommon_bc playSound("scn_blackice_common_scripted_bc");
    wait(randomfloatrange(2, 4));
  }
}

sfx_barracks_breach(var_0) {
  level.player playSound("scn_blackice_common_breach");
  common_scripts\utility::flag_set("sfx_common_breach_start");
  thread sfx_common_breach_mix();
  level.precommon_bc stopsounds();
  wait 0.9;
  level.precommon_bc playSound("scn_blackice_common_scripted_bc_02");

  if(isDefined(level.precommon)) {
    wait 4.3;
    level.precommon delete();
  }
}

sfx_common_breach_mix() {
  level.player setclienttriggeraudiozone("blackice_common_breach1", 1);
  wait 7.5;
  level.player setclienttriggeraudiozone("blackice_common_breach2", 1);
  wait 3;
  level.player setclienttriggeraudiozone("blackice_common_breach3", 2);
  wait 4.5;
  level.player clearclienttriggeraudiozone(1);
}

sfx_derrick_expl_init() {
  var_0 = getent("derrick_expl_trig", "targetname");
  var_0 thread sfx_derrick_expl_trig();
}

sfx_derrick_expl_trig() {
  self waittill("trigger");
  level.player setclienttriggeraudiozone("blackice_oilrig_prederrick", 4);
}

sfx_derrick_mix_change() {
  wait 1.45;
  level.player clearclienttriggeraudiozone(2);
}

sfx_baker_fight_scene() {
  self playSound("scn_blackice_command_baker_door");
  self playSound("scn_blackice_command_baker_fight");
  maps\_utility::smart_dialogue("blackice_bkr_flarestruggle");
  wait 1.838;
  self playLoopSound("scn_blackice_command_idle_lp");
  level waittill("notify_flarestack_baker_pistol_pullout");
  wait 1.0;
  self stoploopsound();
}

sfx_heli_flyin_mudpumps(var_0) {
  common_scripts\utility::flag_set("heli_mudpumps_in");
  thread sfx_heli_flyin_sweetener(var_0);
  wait 0.2;
  level.heli_flyin_mudpumps = spawn("script_origin", var_0.origin);
  level.heli_flyin_mudpumps linkto(var_0);
  level.heli_flyin_mudpumps playSound("scn_blackice_pipedeck_heli_in_boats");
  wait 0.8;
  level.heli_engine_lp_01 = spawn("script_origin", var_0.origin);
  level.heli_engine_lp_01 linkto(var_0);
  level.heli_engine_lp_01 playLoopSound("scn_blackice_pipedeck_heli_lp");
  level.heli_engine_lp_01 scalevolume(0.0, 0.0);
  thread sfx_assault_heli_wind(var_0);
  thread sfx_heli_wind_debris();
  wait 0.1;
  level.heli_engine_lp_01 scalevolume(1.0, 1.5);
}

sfx_heli_flyin_sweetener(var_0) {
  wait 1.2;
  level.heli_flyin_swt = spawn("script_origin", var_0.origin);
  level.heli_flyin_swt linkto(var_0);
  level.heli_flyin_swt playSound("scn_blackice_pipedeck_heli_in_swt");
}

sfx_heli_flyin_pipedeck(var_0) {
  if(!common_scripts\utility::flag("heli_mudpumps_in")) {
    level.heli_engine_lp_01 = spawn("script_origin", var_0.origin);
    level.heli_engine_lp_01 linkto(var_0);
    level.heli_engine_lp_01 playLoopSound("scn_blackice_pipedeck_heli_lp");
    thread sfx_assault_heli_wind(var_0);
    thread sfx_heli_wind_debris();
  }
}

sfx_heli_move_pipedeck(var_0) {
  wait 1;
  level.heli_move_boats = spawn("script_origin", var_0.origin);
  level.heli_move_boats linkto(var_0);
  level.heli_move_boats playSound("scn_blackice_pipedeck_heli_move_01");
  wait 1;
  level.heli_engine_lp_01 scalevolume(0.6, 3.0);
  wait 3;
  level.heli_engine_lp_01 scalevolume(1.0, 1);
}

sfx_heli_flyaway_boats(var_0) {
  level.heli_flyaway_boats = spawn("script_origin", var_0.origin);
  level.heli_flyaway_boats linkto(var_0);
  level.heli_flyaway_boats playSound("scn_blackice_pipedeck_heli_away_boats");
  level.heli_engine_lp_01 scalevolume(0.5, 1.0);
  wait 1;
  level.heli_engine_lp_01 scalevolume(0.0, 8.0);
  wait 7;
  level.heli_engine_lp_01 delete();
}

sfx_assault_heli_flyin() {
  wait 2;
  common_scripts\utility::play_sound_in_space("scn_blackice_pipedeck_heli_in", (2600, 5140, 2892));
}

sfx_assault_heli_engine(var_0) {
  wait 0.1;
  level.heli_engine_lp_02 = spawn("script_origin", var_0.origin);
  level.heli_engine_lp_02 linkto(var_0);
  level.heli_engine_lp_02 playLoopSound("scn_blackice_pipedeck_heli_lp");
  level.heli_engine_lp_02 scalevolume(0.0);
  wait 0.2;
  level.heli_engine_lp_02 scalevolume(1.0, 2.5);
  wait 2.5;
}

sfx_heli_flyaway_cmd_center(var_0) {
  wait 0.2;
  level.heli_flyaway_cmd = spawn("script_origin", var_0.origin);
  level.heli_flyaway_cmd linkto(var_0);
  level.heli_engine_lp_02 stoploopsound("scn_blackice_pipedeck_heli_lp");
  level.heli_flyaway_cmd playSound("scn_blackice_pipedeck_heli_away_cmd");
  level.heli_engine_lp_02 delete();
}

sfx_heli_wind_debris() {
  if(common_scripts\utility::flag("heli_mudpumps_in"))
    wait 3;

  level.heli_wind_debris = spawn("script_origin", level.player.origin);
  level.heli_wind_debris linkto(level.player);
  level.heli_wind_debris playLoopSound("scn_blackice_pipedeck_heli_debris_lp");
  level.heli_wind_debris scalevolume(0.0, 0.0);
  wait 0.1;
  level.heli_wind_debris scalevolume(1.0, 4.0);
  level waittill("notify_heli_leave");
  level.heli_wind_debris scalevolume(0.0, 2.0);
  wait 2;
  level.heli_wind_debris stoploopsound("scn_blackice_pipedeck_heli_debris_lp");
  level.heli_wind_debris delete();
}

sfx_assault_heli_wind(var_0) {
  level.heli_wind = spawn("script_origin", (0, 0, 0));
  level.heli_wind hide();
  level.heli_wind endon("death");
  thread common_scripts\utility::delete_on_death(level.heli_wind);
  level.heli_wind.origin = var_0.origin + (0, 0, -350);
  level.heli_wind linkto(var_0);
  level.heli_wind playLoopSound("scn_blackice_pipedeck_heli_wind_lp");
  level.heli_wind scalevolume(0.0);
  wait 0.1;
  level.heli_wind scalevolume(1.0, 2);
}

sfx_heli_turret_fire_start() {}

sfx_heli_turret_fire_stop() {}

sfx_heli_turret_fire_squibs() {
  if(common_scripts\utility::flag("sfx_stop_heli_squibs"))
    common_scripts\utility::flag_clear("sfx_stop_heli_squibs");

  if(!isDefined(level.heli_squibs)) {
    level.heli_squibs = spawn("script_origin", self.turret_impact.origin);
    level.heli_squibs linkto(self.turret_impact);
  }

  level.heli_squibs playLoopSound("scn_blackice_pipedeck_squib_lp");

  if(!isDefined(level.squib_debris)) {
    level.squib_debris = spawn("script_origin", self.turret_impact.origin);
    level.squib_debris linkto(self.turret_impact);
  }

  level.squib_debris playLoopSound("scn_blackice_pipedeck_debris_lp");
  common_scripts\utility::flag_wait("sfx_stop_heli_squibs");
  level.heli_squibs stoploopsound("scn_blackice_pipedeck_squib_lp");
  wait 0.75;
  level.squib_debris stoploopsound("scn_blackice_pipedeck_debris_lp");
}

sfx_heli_turret_fire_squibs_stop() {
  common_scripts\utility::flag_set("sfx_stop_heli_squibs");
}

sfx_heli_turret_shells() {
  if(common_scripts\utility::flag("sfx_stop_heli_shells"))
    common_scripts\utility::flag_clear("sfx_stop_heli_shells");

  if(!isDefined(level.heli_shells)) {
    level.heli_shells = spawn("script_origin", self.origin);
    level.heli_shells.origin = self.origin + (0, 0, -450);
    level.heli_shells linkto(self);
  }

  wait 0.2;
  level.heli_shells playLoopSound("scn_blackice_pipedeck_shell_lp");
  common_scripts\utility::flag_wait("sfx_stop_heli_shells");
  wait 1.6;
  level.heli_shells stoploopsound("scn_blackice_pipedeck_shell_lp");
}

sfx_heli_turret_shells_stop() {
  common_scripts\utility::flag_set("sfx_stop_heli_shells");
}

sfx_baker_move_body_chair(var_0) {
  wait 0.1;
  var_0 playSound("scn_blackice_cmd_baker_chair");
}

sfx_command_center_door_open() {
  wait 1.2;
  self playSound("scn_blackice_command_door_open");
}

sfx_plr_cmd_console() {
  level.player playSound("scn_blackice_cmd_plr_console");
  level.command_rumble_node = spawn("script_origin", (2464, 5463, 2800));
  level.command_warning_node = spawn("script_origin", (2464, 5463, 2796));
  thread sfx_cmd_amb_change();
  thread sfx_turbines();
  wait 1;
  thread sfx_turbine_beeps();
}

sfx_cmd_amb_change() {
  wait 3;
  level.player setclienttriggeraudiozone("blackice_controlroom_02", 4);
}

sfx_cmd_amb_change_final() {
  wait 0.7;
  level.player setclienttriggeraudiozone("blackice_controlroom_03", 1.5);
}

sfx_cmd_console_acknowledge() {
  level.command_warning_node playSound("scn_blackice_cmd_turbine_ack");
  common_scripts\utility::flag_set("minigame_practice_over");
}

sfx_turbines() {
  wait 4.5;
  level.player playSound("scn_blackice_cmd_turbine_start");
  wait 2;
  level.cmd_turbine_lp = spawn("script_origin", (0, 0, 0));
  level.cmd_turbine_lp linkto(level.player);
  level.cmd_turbine_lp playLoopSound("scn_blackice_cmd_turbine_lp");
  common_scripts\utility::flag_wait("minigame_practice_over");
  wait 0.2;
  level.player playSound("scn_blackice_cmd_turbine_ramp");
  wait 1;
  level.cmd_turbine_lp stoploopsound();
  wait 1.5;
  level.cmd_turbine_lp delete();
}

sfx_turbine_beeps() {
  level.turbine_fail_node = spawn("script_origin", (2455, 5463, 2798));
  common_scripts\utility::flag_wait("minigame_practice_over");
  wait 0.2;
  level.player playSound("scn_blackice_cmd_turbine_beeps_asc");
  wait 3.2;
  level.turbine_fail_node playSound("scn_blackice_cmd_turbine_fail_beep");
  level.player playSound("scn_blackice_cmd_turbine_shake_01_lr");
  wait 2.7;
  level.turbine_fail_node playSound("scn_blackice_cmd_turbine_fail_beep");
  wait 1.5;
  level.turbine_fail_node playSound("scn_blackice_cmd_turbine_fail_beep");
  level.player playSound("scn_blackice_cmd_turbine_shake_02_lr");
}

sfx_exfil_alarm() {
  wait 1.4;
  level.exfil_alarm = spawn("script_origin", (0, 0, 0));
  level.exfil_alarm playLoopSound("scn_blackice_cmd_exfil_alarm");
  level.exfil_alarm linkto(level.player);

  if(common_scripts\utility::flag("sfx_warning_playing")) {
    level.command_warning_node stoploopsound("scn_blackice_cmd_turbine_warning_lp");
    common_scripts\utility::flag_clear("sfx_warning_playing");
  }
}

sfx_exfil_stop_alarm() {
  wait 3;
  thread sfx_cmd_node_cleanup();
}

sfx_cmd_node_cleanup() {
  if(isDefined(level.exfil_alarm))
    level.exfil_alarm delete();

  if(isDefined(level.turbine_fail_node))
    level.turbine_fail_node delete();

  if(isDefined(level.command_warning_node))
    level.command_warning_node delete();

  if(isDefined(level.command_rumble_node))
    level.command_rumble_node delete();
}

sfx_death_stop_turbines() {
  level.player stopsounds("scn_blackice_cmd_turbine_ramp");
}

sfx_lever_logic(var_0) {
  switch (var_0) {
    case 0:
      thread sfx_lever_green();
      break;
    case 1:
      thread sfx_lever_yellow();
      break;
    case 2:
      thread sfx_lever_red();
      break;
  }
}

sfx_lever_green() {
  if(!common_scripts\utility::flag("sfx_lever_green")) {
    if(common_scripts\utility::flag("sfx_lever_yellow"))
      common_scripts\utility::flag_clear("sfx_lever_yellow");

    if(common_scripts\utility::flag("sfx_lever_red"))
      common_scripts\utility::flag_clear("sfx_lever_red");

    common_scripts\utility::flag_set("sfx_lever_green");

    if(common_scripts\utility::flag("sfx_warning_playing")) {
      level.command_warning_node stoploopsound("scn_blackice_cmd_turbine_warning_lp");
      level.command_warning_node playSound("scn_blackice_cmd_turbine_beep_02");
      common_scripts\utility::flag_clear("sfx_warning_playing");
    }
  }
}

sfx_lever_yellow() {
  if(!common_scripts\utility::flag("sfx_lever_yellow")) {
    if(common_scripts\utility::flag("sfx_lever_green"))
      common_scripts\utility::flag_clear("sfx_lever_green");

    if(common_scripts\utility::flag("sfx_lever_red"))
      common_scripts\utility::flag_clear("sfx_lever_red");

    common_scripts\utility::flag_set("sfx_lever_yellow");

    if(!common_scripts\utility::flag("sfx_warning_playing")) {
      common_scripts\utility::flag_set("sfx_warning_playing");
      level.command_warning_node playLoopSound("scn_blackice_cmd_turbine_warning_lp");
    }

    if(!common_scripts\utility::flag("sfx_rumbles_playing") && common_scripts\utility::flag("minigame_practice_over"))
      thread sfx_yellowshake();
  }
}

sfx_lever_red() {
  if(!common_scripts\utility::flag("sfx_lever_red")) {
    if(common_scripts\utility::flag("sfx_lever_green"))
      common_scripts\utility::flag_clear("sfx_lever_green");

    if(common_scripts\utility::flag("sfx_lever_yellow"))
      common_scripts\utility::flag_clear("sfx_lever_yellow");

    common_scripts\utility::flag_set("sfx_lever_red");

    if(!common_scripts\utility::flag("sfx_rumbles_playing") && common_scripts\utility::flag("minigame_practice_over"))
      thread sfx_lever_rumbles();
  }
}

sfx_lever_rumbles() {
  level.command_rumble_node playLoopSound("emt_blackice_cmd_quake_lp");
  thread sfx_redshake();

  if(!common_scripts\utility::flag("sfx_rumbles_playing"))
    common_scripts\utility::flag_set("sfx_rumbles_playing");

  common_scripts\utility::flag_wait("sfx_lever_yellow");
  wait 1.5;
  level.command_rumble_node stoploopsound("emt_blackice_cmd_quake_lp");

  if(common_scripts\utility::flag("sfx_lever_red"))
    sfx_lever_rumbles();
  else
    common_scripts\utility::flag_clear("sfx_rumbles_playing");
}

sfx_redshake() {
  level.player playSound("scn_blackice_cmd_red_shake");
}

sfx_yellowshake() {
  level.player playSound("scn_blackice_cmd_yellow_shake");
}

sfx_death_stop_rumbles() {
  level.command_rumble_node stoploopsound("emt_blackice_cmd_quake_lp");
  wait 1.5;
  level.command_warning_node stoploopsound("scn_blackice_cmd_turbine_warning_lp");
}

sfx_blackice_console_fail_explo() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkto(level.player);
  wait 1.3;
  var_0 playSound("scn_blackice_exfil_fail_console");
}

sfx_blackice_fail_explo() {
  self playSound("scn_blackice_exfil_fail");
}

sfx_blackice_fail_fall() {
  level.player setclienttriggeraudiozonepartial("blackice_exfil_fail", "mix");
  wait 0.1;
  self playSound("scn_blackice_exfil_fail_fall");
}

sfx_controlroom_explosions(var_0) {
  var_1 = "null";
  var_2 = "null";

  switch (var_0) {
    case "command_control_1":
      var_1 = "scn_blackice_cmd_expl_03";
      var_2 = "scn_blackice_cmd_expl_shake_01_lr";
      break;
    case "command_control_2":
      var_1 = "scn_blackice_cmd_expl_02";
      var_2 = "scn_blackice_cmd_expl_shake_02_lr";
      break;
    case "command_control_3":
      var_1 = "scn_blackice_cmd_expl_01";
      var_2 = "scn_blackice_cmd_expl_shake_03_lr";
      break;
    case "command_control_4":
      var_1 = "scn_blackice_cmd_expl_04";
      var_2 = "scn_blackice_cmd_expl_shake_04_lsrs";
      break;
  }

  level.player playSound(var_1);
  wait 0.5;
  level.player playSound(var_2);
}

sfx_cmd_seq_end() {
  thread sfx_cmd_metal_bend();
  thread sfx_cmd_amb_change_final();
  thread sfx_exfil_alarm();
  wait 0.3;
  level.player playSound("scn_blackice_cmd_plr_console_end");
  wait 0.2;
  wait 0.2;
}

sfx_cmd_metal_bend() {
  wait 0.4;
  level.player playSound("scn_blackice_cmd_metal_bend");
}

sfx_exfil_outro() {
  thread sfx_exfil_outro_mix();
  level.player playSound("scn_blackice_exfil_outro_lr");
  wait 7.6;
  level.player playSound("scn_blackice_exfil_outro_lfe");
  wait 6.15;
}

sfx_exfil_outro_mix() {
  level.player setclienttriggeraudiozone("blackice_exfil_outro", 4);
}

blackice_pre_ascend_music() {
  maps\_utility::music_play("mus_blackice_ascend");
  common_scripts\utility::flag_wait("flag_ascend_end");
}

blackice_exfil_music() {
  maps\_utility::music_play("mus_blackice_exfil");
}

blackice_exfil_stinger_music() {
  wait 0.25;
  maps\_utility::music_crossfade("mus_blackice_jump", 1.75);
}