/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_descent_aud.gsc
*****************************************************/

main() {
  _id_0367::_id_8E3E("dlc4_fzn_dwn");
  _id_7BBA();
  _id_51D8();
  _id_5C22();
  level._id_11CB.intermission_music_aliases = ["mus_intermission_dlc2"];
  level._id_11CB.wave_cues = ["dlcx_mus_intro_assault", "dlcx_mus_wave_04", "dlcx_mus_wave_02", "dlcx_mus_wave_03", "dlcx_mus_movin", "dlcx_mus_screetchy1", "dlcx_mus_wave_07", "dlcx_mus_wave_01", "dlcx_mus_wave_05"];
  _id_0366::snd_set_mus_combat_cues_override(level._id_11CB.wave_cues);
  _id_0366::snd_zmb_set_start_intermission_music_override_callback(::start_intermission_music_override_callback);
  _id_0366::snd_zmb_set_map_wave_music_master_volume_scalar(0.8);
}

_id_7BBA() {
  _id_0378::_id_8DC7("player_connect_map", ::_id_7248);
  _id_0378::_id_8DC7("player_spawned", ::_id_7330);
  _id_0378::_id_8DC7("wave_begin", ::_id_A979);
  _id_0378::_id_8DC7("wave_end", ::_id_A97A);
  _id_0378::_id_8DC7("aud_stormraven_uberschnell_place", ::stormraven_uberschnell_place);
  _id_0378::_id_8DC7("aud_stormraven_bloodfall", ::stormraven_bloodfall);
  _id_0378::_id_8DC7("aud_stormraven_bloodstopper_pickup", ::stormraven_bloodstopper_pickup);
  _id_0378::_id_8DC7("aud_stormraven_bloodstopper_place", ::stormraven_bloodstopper_place);
  _id_0378::_id_8DC7("aud_stop_stormraven_bloodfall", ::stop_stormraven_bloodfall);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_spawn", ::stormraven_warhammer_spawn);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_tp_out", ::stormraven_warhammer_tp_out);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_tp_in", ::stormraven_warhammer_tp_in);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_burst_mvmt", ::stormraven_warhammer_burst_mvmt);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_steady_mvmt", ::stormraven_warhammer_steady_mvmt);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_tether", ::stormraven_warhammer_tether);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_pickup", ::stormraven_warhammer_pickup);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_run_charged", ::stormraven_warhammer_run_charged);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_rune_strike", ::stormraven_warhammer_rune_strike);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_timed_charge", ::stormraven_warhammer_timed_charge);
  _id_0378::_id_8DC7("aud_stormraven_charge_puzzle_spin", ::stormraven_charge_puzzle_spin);
  _id_0378::_id_8DC7("aud_stormraven_charge_puzzle_rotate", ::stormraven_charge_puzzle_rotate);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_puz_run_ch", ::stormraven_warhammer_puz_run_ch);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_trial_strikes", ::stormraven_warhammer_trial_strikes);
  _id_0378::_id_8DC7("aud_stormraven_warhammer_ascend_strike", ::stormraven_warhammer_ascend_strike);
  _id_0378::_id_8DC7("aud_blood_plate_absorb", ::aud_blood_plate_absorb);
  _id_0378::_id_8DC7("aud_blood_plate_press", ::aud_blood_plate_press);
  _id_0378::_id_8DC7("aud_blood_plate_release", ::aud_blood_plate_release);
  _id_0378::_id_8DC7("aud_blood_plate_lock", ::aud_blood_plate_lock);
  _id_0378::_id_8DC7("aud_blood_plate_full_lp", ::aud_blood_plate_lp_full);
  _id_0378::_id_8DC7("zombie_soul_suck", ::_id_ABF8);
  _id_0378::_id_8DC7("zombie_soul_suck_threshold", ::_id_ABF9);
  _id_0378::_id_8DC7("aud_deathraven_button", ::deathraven_button);
  _id_0378::_id_8DC7("aud_deathraven_earthquake", ::deathraven_earthquake);
  _id_0378::_id_8DC7("aud_deathraven_firewall", ::deathraven_firewall);
  _id_0378::_id_8DC7("aud_deathraven_scythe_appear", ::deathraven_scythe_appear);
  _id_0378::_id_8DC7("aud_deathraven_scythe_obtain", ::deathraven_scythe_obtain);
  _id_0378::_id_8DC7("aud_deathraven_place_scythe", ::deathraven_place_scythe);
  _id_0378::_id_8DC7("aud_deathraven_place_spine", ::deathraven_place_spine);
  _id_0378::_id_8DC7("aud_deathraven_scythe_heat_stage_1", ::deathraven_scythe_heat_stage_1);
  _id_0378::_id_8DC7("aud_deathraven_scythe_heat_stage_2", ::deathraven_scythe_heat_stage_2);
  _id_0378::_id_8DC7("aud_deathraven_scythe_heated", ::deathraven_scythe_heated);
  _id_0378::_id_8DC7("aud_deathraven_pickup_scythe", ::deathraven_pickup_scythe);
  _id_0378::_id_8DC7("aud_deathraven_exit_trail", ::exit_trial);
  _id_0378::_id_8DC7("aud_stormraven_lightning_rod_ascend", ::stormraven_lightning_rod_ascend);
  _id_0378::_id_8DC7("aud_stormraven_lightning_rod_rotate", ::stormraven_lightning_rod_rotate);
  _id_0378::_id_8DC7("aud_moonraven_book_pickup", ::moonraven_book_pickup);
  _id_0378::_id_8DC7("aud_moonraven_book_place", ::moonraven_book_place);
  _id_0378::_id_8DC7("aud_moonraven_gear_pickup", ::moonraven_gear_pickup);
  _id_0378::_id_8DC7("aud_moonraven_gear_place", ::moonraven_gear_place);
  _id_0378::_id_8DC7("aud_moonraven_orrery_lower_gears_move", ::moonraven_orrery_lower_gears_move);
  _id_0378::_id_8DC7("aud_moonraven_orrery_move", ::moonraven_orrery_move);
  _id_0378::_id_8DC7("aud_moonraven_orrery_stop", ::moonraven_orrery_stop);
  _id_0378::_id_8DC7("aud_moonraven_orrery_lock", ::moonraven_orrery_lock);
  _id_0378::_id_8DC7("aud_moonraven_constellation_find", ::moonraven_constellation_find);
  _id_0378::_id_8DC7("aud_moonraven_constellation_done", ::moonraven_constellation_done);
  _id_0378::_id_8DC7("aud_moonraven_trial_fire_strt", ::moonraven_trial_fire_strt);
  _id_0378::_id_8DC7("aud_moonraven_enter_trial", ::enter_trial);
  _id_0378::_id_8DC7("aud_moonraven_exit_trail", ::exit_trial);
  _id_0378::_id_8DC7("aud_blood_tube_door_open", ::blood_tube_door_open);
  _id_0378::_id_8DC7("aud_blood_tube_door_close", ::blood_tube_door_close);
  _id_0378::_id_8DC7("aud_blood_tube_filling_up", ::blood_tube_filling_up);
  _id_0378::_id_8DC7("aud_blood_tube_engulf", ::blood_tube_engulf);
  _id_0378::_id_8DC7("aud_blood_tube_splash", ::blood_tube_splash);
  _id_0378::_id_8DC7("aud_pap_rise", ::pap_rise);
  _id_0378::_id_8DC7("aud_bloodraven_radio_pickup", ::bloodraven_radio_pickup);
  _id_0378::_id_8DC7("aud_bloodraven_speaker_pickup", ::bloodraven_speaker_pickup);
  _id_0378::_id_8DC7("aud_bloodraven_radio_place", ::bloodraven_radio_place);
  _id_0378::_id_8DC7("aud_bloodraven_speaker_place", ::bloodraven_speaker_place);
  _id_0378::_id_8DC7("aud_bloodraven_bloodstopper_pickup", ::bloodraven_bloodstopper_pickup);
  _id_0378::_id_8DC7("aud_bloodraven_bloodstopper_place", ::bloodraven_bloodstopper_place);
  _id_0378::_id_8DC7("aud_bloodraven_wustling_spawn", ::bloodraven_wustling_spawn);
  _id_0378::_id_8DC7("aud_bloodraven_bloodpool_ready", ::bloodraven_bloodpool_ready);
  _id_0378::_id_8DC7("aud_bloodraven_reveal_bloodpool_code", ::bloodraven_reveal_bloodpool_code);
  _id_0378::_id_8DC7("aud_bloodraven_tune_radio", ::bloodraven_tune_radio);
  _id_0378::_id_8DC7("aud_bloodraven_bloodcode_final", ::bloodraven_bloodcode_final);
  _id_0378::_id_8DC7("aud_bloodraven_enter_trial", ::enter_trial);
  _id_0378::_id_8DC7("aud_bloodraven_exit_trial", ::exit_trial);
  _id_0378::_id_8DC7("aud_citadel_wpn_placement", ::citadel_wpn_placement);
  _id_0378::_id_8DC7("aud_citadel_pillar_ignite", ::citadel_pillar_ignite);
  _id_0378::_id_8DC7("aud_citadel_shield_pillar_fire_lp", ::citadel_shield_pillar_fire_lp);
  _id_0378::_id_8DC7("aud_citadel_hammer_pillar_fire_lp", ::citadel_hammer_pillar_fire_lp);
  _id_0378::_id_8DC7("aud_citadel_spike_pillar_fire_lp", ::citadel_spike_pillar_fire_lp);
  _id_0378::_id_8DC7("aud_citadel_scythe_pillar_fire_lp", ::citadel_scythe_pillar_fire_lp);
  _id_0378::_id_8DC7("aud_citadel_all_weapons_placed", ::citadel_all_weapons_placed);
  _id_0378::_id_8DC7("aud_citadel_entrance", ::citadel_entrance);
  _id_0378::_id_8DC7("aud_gdk_intro", ::aud_gdk_intro);
  _id_0378::_id_8DC7("aud_boss_music_start", ::boss_music_start);
  _id_0378::_id_8DC7("dlc_handle_boss_killed_music", ::dlc_handle_boss_killed_music);
  _id_0378::_id_8DC7("aud_trap_spikes", ::archives_spike_trap);
  _id_0378::_id_8DC7("aud_damage_ice", ::damage_ice);
  _id_0378::_id_8DC7("aud_break_ice", ::break_ice);
  _id_0378::_id_8DC7("aud_spawn_raven", ::spawn_raven);
  _id_0378::_id_8DC7("aud_raven_fly_away", ::raven_fly_away);
  _id_0378::_id_8DC7("aud_outro_vo_submix_start", ::outro_vo_submix_start);
  _id_0378::_id_8DC7("aud_outro_vo_submix_end", ::outro_vo_submix_end);
}

start_intermission_music_override_callback() {
  var_0 = level._id_11CB.intermission_music_aliases[randomint(level._id_11CB.intermission_music_aliases.size)];
  var_1 = 3.0;
  var_2 = 5.0;
  _id_0366::_id_8E31(var_0, var_1, var_2);
}

_id_51D8() {
  level._id_11CB = spawnStruct();
  level._id_11CB.pap_rose_once_already = 0;
  level._id_11CB.bloodfall_count_started = 0;
  level._id_11CB.bloodfall_counter = 0;
  level._id_11CB.bloodfall_ent = [];
  level._id_11CB.bloodfall_snd = [];
  level._id_11CB.moon_count = 0;
  level._id_11CB.shield_pillar_fire_snd_handle = undefined;
  level._id_11CB.hammer_pillar_fire_snd_handle = undefined;
  level._id_11CB.spike_pillar_fire_snd_handle = undefined;
  level._id_11CB.scythe_pillar_fire_snd_handle = undefined;
  level._id_11CB.cit_shield_pillar_fire_playing = 0;
  level._id_11CB.cit_hammer_pillar_fire_playing = 0;
  level._id_11CB.cit_spike_pillar_fire_playing = 0;
  level._id_11CB.cit_scythe_pillar_fire_playing = 0;
  level._id_11CB.final_strike_started = 0;
}

_id_5C22() {
  thread _id_35E1();
  thread zmb_metal_creak_1();
  thread zmb_metal_creak_4();
  thread zmb_metal_creak_7();
  thread zmb_metal_creak_12();
  thread zmb_metal_creak_15();
  thread zmb_metal_stress_01();
  thread zmb_chains_01();
  thread zmb_chains_04();
  thread zmb_chains_08();
  thread zmb_chains_12();
  thread zmb_chains_13();
  thread zmb_chains_16();
  thread zmb_chains_18();
  thread zmb_sparks_01();
  thread zmb_sparks_04();
  thread zmb_cave_drips_02();
  thread zmb_cave_drips_05();
}

_id_35E1() {
  wait 0.5;
  _id_0380::_id_6842("zmb_dig_bloodfall_room_water_lp", undefined, (6, 1465, 171), 0.5);
  _id_0380::_id_6842("emt_zmb_descent_debris_fire_lp", undefined, (1057, 2752, 2193));
  _id_0380::_id_6842("emt_zmb_descent_debris_fire_lp", undefined, (1056, 2517, 2193));
  _id_0380::_id_6842("emt_zmb_descent_debris_fire_lp", undefined, (184, 2918, 2244));
  _id_0380::_id_6842("emt_zmb_descent_debris_fire_lp", undefined, (953, 2075, 2267));
  _id_0380::_id_6842("emt_zmb_descent_debris_fire_lp", undefined, (-3693, 529, 1004));
  _id_0380::_id_6842("dig_amb_snowy_opening_sml_02", undefined, (-902, 1195, 1945));
  _id_0380::_id_6842("dig_amb_snowy_opening_sml_02", undefined, (-482, 1282, 2217));
  _id_0380::_id_6842("emt_zmb_descent_fire_brush", undefined, (-801, 2995, 2271));
  _id_0380::_id_6842("emt_zmb_descent_fire_lp", undefined, (-1042, 2674, 2472));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-763, -389, 1384));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-3, -385, 1384));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1192, -324, 1583));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1103, -429, 1592));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1158, -649, 1592));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1279, -604, 1592));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1332, -1011, 1590));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2050, 447, 1446));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2104, 521, 1446));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2095, 1008, 1471));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2346, 945, 1520));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2317, 628, 1624));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2166, 711, 1632));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1917, 485, 1753));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1863, 678, 1753));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1461, 328, 1753));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1393, 587, 1753));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1309, 603, 1717));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1932, 848, 1453));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (640, 409, 1544));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (899, 499, 1520));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (1019, 532, 1520));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2972, -369, 1431));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-2932, -221, 1431));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (892, -153, 1433));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1816, -900, 1526));
  _id_0380::_id_6842("emt_zmb_descent_torch_main", undefined, (-1554, -758, 1526));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (-3459, 129, 1036));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (-1966, -330, 1534));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (-949, -5442, -2052));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (-1539, -4631, 2088));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (-1289, -4073, -2088));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (-1209, -3471, -2088));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (337, -5448, -2087));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (792, -4577, -2087));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (558, -4228, -2087));
  _id_0380::_id_6842("emt_zmb_descent_waterTank", undefined, (553, -3713, -2087));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (946, -564, 1342));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (1084, -237, 1342));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (798, -219, 1342));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (842, -158, 1342));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (-607, 455, 1710));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (-579, 481, 1526));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (-160, 477, 1635));
  _id_0380::_id_6842("zmb_dsc_bloodpool_lp", undefined, (-116, 453, 1526));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp", undefined, (-607, 455, 1710));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp", undefined, (-579, 481, 1526));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp", undefined, (-160, 477, 1635));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp", undefined, (-116, 453, 1526));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp_final", undefined, (-929, -2972, -1504));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp_final", undefined, (-25, -2995, -1340));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp_final", undefined, (-865, -3703, -1388));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp_final", undefined, (-1810, -3819, -1484));
  _id_0380::_id_6842("zmb_dsc_bloodfall_splats_lp_final", undefined, (188, -3232, -1696));
  _id_0380::_id_6842("zmb_dsc_challenge_elec", undefined, (-1119, 907, -1577));
  _id_0380::_id_6842("zmb_dsc_challenge_elec", undefined, (595, 923, -1595));
  _id_0380::_id_6842("zmb_dsc_challenge_blood", undefined, (-1123, -835, -1585));
  _id_0380::_id_6842("emt_zmb_descent_bloodfall", undefined, (-130, 417, 1434));
  _id_0380::_id_6842("emt_zmb_descent_bloodfall_verb", undefined, (-376, 419, 1284));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp", undefined, (1164, -141, 1445));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp", undefined, (1001, -227, 1445));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp", undefined, (1066, -407, 1445));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp", undefined, (998, -521, 1419));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp", undefined, (858, -370, 1419));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp", undefined, (1341, -228, 1443));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp_final", undefined, (-81, -3262, -1710));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp_final", undefined, (-702, -3177, -1664));
  _id_0380::_id_6842("zmb_dsc_blood_ceiling_lp_final", undefined, (301, -3135, -1478));
  _id_0380::_id_6842("zmb_dig_emt_drips_lp_final", undefined, (-1549, -3962, -1932));
  _id_0380::_id_6842("zmb_dig_emt_drips_lp_final", undefined, (-1236, -3197, -1956));
  _id_0380::_id_6842("zmb_dig_emt_drips_lp_final", undefined, (344, -3225, -1727));
  _id_0380::_id_6842("zmb_dig_emt_drips_lp_final", undefined, (846, -4312, -1944));
  _id_0380::_id_6842("zmb_orrery_aura_main_lp", undefined, (1124, -238, 1728));
}

zmb_metal_creak_1() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(12, 18);
    _id_0380::_id_2889("emt_zmb_descent_metal_stress", undefined, (994, 3014, 2244));
    wait(var_0);
  }
}

zmb_metal_creak_4() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(8, 19);
    _id_0380::_id_2889("emt_zmb_descent_metal_rattle_low", undefined, (958, 2654, 2244));
    wait(var_0);
  }
}

zmb_metal_creak_7() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(9, 20);
    _id_0380::_id_2889("emt_zmb_descent_metal_stress", undefined, (286, 3355, 2338));
    wait(var_0);
  }
}

zmb_metal_creak_12() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(12, 21);
    _id_0380::_id_2889("emt_zmb_descent_metal_rattle_low", undefined, (-486, 2730, 2249));
    wait(var_0);
  }
}

zmb_metal_creak_15() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(11, 20);
    _id_0380::_id_2889("emt_zmb_descent_metal_stress", undefined, (-317, 2155, 2290));
    wait(var_0);
  }
}

zmb_metal_stress_01() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(6, 18);
    _id_0380::_id_2889("emt_zmb_descent_metal_stress", undefined, (1260, -222, 1436));
    wait(var_0);
  }
}

zmb_chains_01() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(7, 15);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (1082, -402, 1428));
    wait(var_0);
  }
}

zmb_chains_04() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(8, 18);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (-1979, 779, 1478));
    wait(var_0);
  }
}

zmb_chains_08() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(12, 22);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (791, 498, 1838));
    wait(var_0);
  }
}

zmb_chains_12() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(8, 93);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (1093, 82, 1808));
    wait(var_0);
  }
}

zmb_chains_13() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(7, 13);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (945, -303, 1757));
    wait(var_0);
  }
}

zmb_chains_16() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(12, 24);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (-2853, 76, 1506));
    wait(var_0);
  }
}

zmb_chains_18() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(6, 24);
    _id_0380::_id_2889("emt_zmb_dsc_chains", undefined, (-3044, -630, 1506));
    wait(var_0);
  }
}

zmb_sparks_01() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(2, 5);
    _id_0380::_id_2889("emt_zmb_dsc_elec_sparks", undefined, (165, -5512, -1579));
    wait(var_0);
  }
}

zmb_sparks_04() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(2, 5);
    _id_0380::_id_2889("emt_zmb_dsc_elec_sparks", undefined, (-1175, -5642, -1652));
    wait(var_0);
  }
}

zmb_cave_drips_02() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(9, 21);
    _id_0380::_id_2889("zmb_dsc_cave_drips", undefined, (-857, 1007, 1824));
    wait(var_0);
  }
}

zmb_cave_drips_05() {
  level endon("death");

  for(;;) {
    var_0 = _func_0A4(10, 19);
    _id_0380::_id_2889("zmb_dsc_cave_drips", undefined, (419, 841, 1722));
    wait(var_0);
  }
}

_id_7248() {
  if(!isDefined(self._id_11CB))
    self._id_11CB = spawnStruct();
}

_id_7330() {
  soundscripts\_snd_common_zmb_dlc4::dlc4_player_spawned();
}

_id_A979(var_0) {
  soundscripts\_snd_common_zmb_dlc4::dlc4_wave_begin(var_0);
}

_id_A97A() {
  soundscripts\_snd_common_zmb_dlc4::dlc4_wave_end();
}

stormraven_uberschnell_place() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_uberschnell_place", undefined, self);
}

stormraven_bloodfall() {
  if(!isDefined(self)) {
    return;
  }
  level._id_11CB.bloodfall_snd[level._id_11CB.bloodfall_counter] = _id_0380::_id_6844("zmb_stormraven_bloodfall_lp", undefined, self);

  if(level._id_11CB.bloodfall_counter < 3)
    level._id_11CB.bloodfall_counter = level._id_11CB.bloodfall_counter + 1;
}

stormraven_bloodstopper_pickup() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_bloodstopper_pickup", undefined, self);
}

stormraven_bloodstopper_place() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_bloodstopper_place", undefined, self);
}

stop_stormraven_bloodfall() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level._id_11CB.bloodfall_snd[level._id_11CB.bloodfall_counter]))
    _id_0380::_id_6850(level._id_11CB.bloodfall_snd[level._id_11CB.bloodfall_counter]);

  if(level._id_11CB.bloodfall_counter > 0)
    level._id_11CB.bloodfall_counter = level._id_11CB.bloodfall_counter - 1;
}

stormraven_warhammer_spawn() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_warhammer_spawn", undefined, self);
  _id_0380::_id_288B("zmb_stormraven_warhammer_spawn_body", undefined, self);
  _id_0380::_id_288B("zmb_stormraven_warhammer_spawn_sub", undefined, self);
  _id_0380::_id_288B("zmb_stormraven_warhammer_spawn_thump", undefined, self);
  _id_0380::_id_288B("zmb_stormraven_warhammer_spawn_mtl", undefined, self);
  _id_0380::_id_288B("zmb_stormraven_warhammer_spawn_elec", undefined, self);
}

stormraven_warhammer_tp_out(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_stormraven_warhammer_tp_body", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_tp_sub", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_tp_thump", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_tp_mtl", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_tp_elec", undefined, var_0);
}

stormraven_warhammer_tp_in(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_stormraven_warhammer_spawn", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_spawn_body", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_spawn_sub", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_spawn_thump", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_spawn_mtl", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_spawn_elec", undefined, var_0);
}

stormraven_warhammer_burst_mvmt() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_warhammer_mvmt_burst", undefined, self);
}

stormraven_warhammer_steady_mvmt() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = _id_0380::_id_6844("zmb_stormraven_warhammer_mvmt_lp", undefined, self);
  thread stormraven_warhammer_mvmt_one_shot_handler(self);
  level waittill("stormraven_hammer_tethered");

  if(isDefined(var_0))
    _id_0380::_id_6850(var_0);
}

stormraven_warhammer_mvmt_one_shot_handler(var_0) {
  level endon("stormraven_hammer_tethered");

  for(;;) {
    var_1 = _func_0A5(8.0, 15.0);
    wait(var_1);
    _id_0380::_id_288B("zmb_stormraven_warhammer_mvmt", undefined, var_0);
    waitframe();
  }
}

stormraven_warhammer_tether() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_warhammer_tether", undefined, self);
}

stormraven_warhammer_pickup(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_stormraven_warhammer_pickup", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_pickup_body", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_pickup_sub", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_pickup_mtl", undefined, var_0);
  _id_0380::_id_2889("zmb_stormraven_warhammer_pickup_elec", undefined, var_0);
}

stormraven_warhammer_run_charged() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = _id_0380::_id_6844("zmb_stormraven_warhammer_rune_charged", undefined, self);
  self waittill("aud_rune_charge_transferred");

  if(isDefined(var_0))
    _id_0380::_id_6850(var_0);
}

stormraven_warhammer_rune_strike() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_warhammer_rune_hit", undefined, self);
}

stormraven_warhammer_timed_charge() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = _id_0380::_id_6844("zmb_stormraven_warhammer_charged", undefined, self);
  self waittill("aud_stop_charged_warhammer");

  if(isDefined(var_0))
    _id_0380::_id_6850(var_0);
}

stormraven_charge_puzzle_spin(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  wait 0.3;
  _id_0380::_id_2889("zmb_stormraven_warhammer_puzzle_start", undefined, var_0);
}

stormraven_charge_puzzle_rotate() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_stormraven_warhammer_puzzle_rot", undefined, self);
}

stormraven_warhammer_puz_run_ch() {
  if(!isDefined(self)) {
    return;
  }
  level endon("disconnect");
  var_0 = _id_0380::_id_6844("zmb_stormraven_warhammer_rune_charged", undefined, self);
  self waittill("aud_rune_charge_done");

  if(isDefined(var_0))
    _id_0380::_id_6850(var_0);
}

stormraven_warhammer_trial_strikes(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_stormraven_warhammer_trial_strikes", undefined, var_0);
}

stormraven_warhammer_ascend_strike(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_stormraven_warhammer_tether", undefined, var_0);
  var_1 = _id_0380::_id_6842("zmb_stormraven_warhammer_rune_charged", undefined, var_0, 2.0);
  wait 4.5;

  if(isDefined(var_1))
    _id_0380::_id_6850(var_1, 2.0);

  _id_0380::_id_2889("zmb_stormraven_warhammer_rune_hit", undefined, var_0);
}

moonraven_trial_fire_strt() {
  _id_0380::_id_288B("zmb_gdkng_flamewave_end", undefined, self);
}

moonraven_constellation_find() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_morningstar_constellation_find", undefined, self);
}

moonraven_constellation_done() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_morningstar_constellation_complete", undefined, self);
}

aud_blood_plate_absorb(var_0) {
  var_1 = self;
  var_2 = spawn("script_origin", var_1.origin);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  _id_0380::_id_288B("zmb_dig_soul_suck_blood", undefined, var_2);
  var_2 _meth_82B1(var_0.origin, 1.9);
  wait 2.0;
  var_2 delete();
  _id_0380::_id_2889("zombie_soul_suck_threshold", undefined, var_1.origin);
}

aud_blood_plate_press(var_0) {
  _id_0380::_id_288B("zmb_dig_blood_plate_press", undefined, var_0);
}

aud_blood_plate_lock(var_0) {}

aud_blood_plate_lp_full() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  _id_0380::_id_6846("zmb_dec_blood_plate_full_lp", undefined, var_0, 0.5, undefined, 1);
  _id_0380::_id_6846("zmb_dec_blood_plate_full_lp_low", undefined, var_0, 0.5, undefined, 1.5);
}

aud_blood_plate_release(var_0) {
  _id_0380::_id_288B("zmb_dig_blood_plate_release", undefined, var_0);
}

_id_ABF8(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  var_2 _meth_82B1(var_1, 1.9);
  wait 2.0;
  var_2 delete();
}

_id_ABF9(var_0) {}

deathraven_button(var_0) {
  _id_0380::_id_288B("zmb_dsnt_button", undefined, var_0);
}

deathraven_earthquake(var_0) {
  var_1 = _id_0380::_id_6844("zone1earthquake_phase1", undefined, self, var_0 * 0.04);
  var_2 = _id_0380::_id_6844("zone1earthquake_phase2", undefined, self, var_0 * 0.12);
  var_3 = _id_0380::_id_6844("zone1earthquake_phase3", undefined, self, var_0 * 0.12);
  var_4 = _id_0380::_id_6844("zone1earthquake_phase4", undefined, self, var_0 * 0.15);
  wait(var_0 * 0.8);
  _id_0380::_id_288B("zone1earthquake_settle", undefined, self);
  _id_0380::_id_6850(var_1, 0.5);
  _id_0380::_id_6850(var_2, 0.5);
  _id_0380::_id_6850(var_3, 0.5);
  _id_0380::_id_6850(var_4, 0.5);
}

deathraven_firewall(var_0) {
  var_1 = self;
  _id_0380::_id_6846("zmb_dsnt_fire_lp", undefined, var_1, 0.3, undefined, 1.5);
  _id_0380::_id_6846("zmb_dsnt_elec_lp", undefined, var_1, 0.3, undefined, 0.5);
  var_1 thread firewall_whoosh_oneshots(var_0);
}

firewall_whoosh_oneshots(var_0) {
  while(var_0) {
    var_1 = _func_0A4(4, 8);
    _id_0380::_id_288B("zmb_dsnt_fire_whoosh", undefined, self);
    wait(var_1);
  }
}

deathraven_scythe_appear() {
  var_0 = self;
  _id_0380::_id_288B("zmb_weap_scythe_spawn", undefined, var_0);
  level._id_11CB.scythe_appear_lp = _id_0380::_id_6844("zmb_weap_scythe_idle_lp", undefined, var_0, 0.2);
}

deathraven_scythe_obtain() {
  _id_0380::_id_6850(level._id_11CB.scythe_appear_lp, 0.75);
}

deathraven_place_spine() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_place_spine", undefined, var_0);
}

deathraven_place_scythe() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dig_barb_place_pommel", undefined, var_0);
}

deathraven_scythe_heat_stage_1() {
  var_0 = self;
  level._id_11CB.scythe_sizzle_stage_1 = _id_0380::_id_6844("zmb_dsnt_scythe_sizzle_lvl_1_lp", undefined, var_0, 0.2);
}

deathraven_scythe_heat_stage_2() {
  var_0 = self;

  if(!isDefined(level._id_11CB.scythe_sizzle_stage_2))
    level._id_11CB.scythe_sizzle_stage_2 = _id_0380::_id_6844("zmb_dsnt_scythe_sizzle_lvl_2_lp", undefined, var_0, 0.2);
}

deathraven_scythe_heated() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB.scythe_sizzle_stage_1, 0.5);
  _id_0380::_id_6850(level._id_11CB.scythe_sizzle_stage_2, 0.5);
  _id_0380::_id_288B("zmb_dsnt_scythe_heated", undefined, var_0);
}

deathraven_pickup_scythe() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dig_barb_place_hilt", undefined, var_0);
}

stormraven_lightning_rod_ascend(var_0, var_1) {
  var_2 = _id_0380::_id_6844("zmb_dsnt_lightningrod_ascend", undefined, self, 0.1);
  wait(var_0);
  _id_0380::_id_6850(var_2, 0.2);
  _id_0380::_id_288B("zmb_dsnt_lightningrod_ascend_done", undefined, self);
}

stormraven_lightning_rod_rotate() {
  var_0 = _id_0380::_id_6844("zmb_dsnt_block_rotate_lp", undefined, self, 0.1);
  wait(level.stormravenblockrotatetime);
  _id_0380::_id_6850(var_0, 0.2);
  var_1 = _id_0380::_id_288B("zmb_dsnt_block_stop_impact", undefined, self);
}

moonraven_book_pickup() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_book_pickup", undefined, var_0);
}

moonraven_book_place() {
  var_0 = self;

  if(!isDefined(var_0.place_book_snd)) {
    var_0.place_book_snd = _id_0380::_id_288B("zmb_dsnt_book_place", undefined, var_0);
    _id_0380::_id_288F(var_0.place_book_snd, var_0, "place_book_done");
    var_0 waittill("place_book_done");
    var_0.place_book_snd = undefined;
  }
}

moonraven_gear_pickup() {
  var_0 = self;
  _id_0380::_id_288B("zmb_orrery_gears_pickup", undefined, var_0);
}

moonraven_gear_place() {
  var_0 = self;

  if(!isDefined(var_0.place_gear_snd)) {
    var_0.place_gear_snd = _id_0380::_id_288B("zmb_orrery_gears_place", undefined, var_0);
    _id_0380::_id_288F(var_0.place_gear_snd, var_0, "place_gear_done");
    var_0 waittill("place_gear_done");
    var_0.place_gear_snd = undefined;
  }
}

moonraven_orrery_lower_gears_move() {
  self endon("disconnect");

  while(!common_scripts\utility::_id_3C77("moonraven_gears_stop_rotation")) {
    if(!isDefined(self.lower_gear_lp))
      self.lower_gear_lp = _id_0380::_id_6842("zmb_orrery_gears_lower_lp", undefined, self.origin + (0, 50, 0), 0.2);

    waitframe();
  }

  _id_0380::_id_6850(self.lower_gear_lp, 0.3);
  self.lower_gear_lp = undefined;
}

moonraven_orrery_move(var_0) {
  level._id_11CB.moon_count++;

  if(level._id_11CB.moon_count > 4)
    level._id_11CB.moon_count = 4;

  switch (level._id_11CB.moon_count) {
    case 0:
      _id_0380::_id_288B("zmb_orrery_ring_strt", undefined, level.orrery_moon_a);
      break;
    case 1:
      _id_0380::_id_288B("zmb_orrery_ring_strt", undefined, level.orrery_moon_a);
      level._id_11CB.moon_lp_1 = _id_0380::_id_6844("zmb_orrery_gears_main_a_lp", undefined, level.orrery_moon_a, 0.2);
      break;
    case 2:
      _id_0380::_id_288B("zmb_orrery_ring_strt", undefined, level.orrery_moon_a);
      level._id_11CB.moon_lp_2 = _id_0380::_id_6844("zmb_orrery_gears_layer_a_lp", undefined, level.orrery_moon_a, 0.2);
      break;
    case 3:
      _id_0380::_id_288B("zmb_orrery_ring_strt", undefined, level.orrery_moon_a);
      level._id_11CB.moon_lp_3 = _id_0380::_id_6844("zmb_orrery_gears_layer_c_lp", undefined, level.orrery_moon_a, 0.2);
      break;
    case 4:
      _id_0380::_id_288B("zmb_orrery_ring_strt", undefined, level.orrery_moon_a);
      level._id_11CB.moon_lp_4 = _id_0380::_id_6844("zmb_orrery_gears_layer_b_lp", undefined, level.orrery_moon_a, 0.2);
      break;
    default:
      break;
  }
}

moonraven_orrery_stop(var_0) {
  level._id_11CB.moon_count--;

  if(level._id_11CB.moon_count < 0)
    level._id_11CB.moon_count = 0;

  switch (level._id_11CB.moon_count) {
    case 0:
      _id_0380::_id_6850(level._id_11CB.moon_lp_1, 0.3);
      _id_0380::_id_6850(level._id_11CB.moon_lp_2, 0.3);
      _id_0380::_id_6850(level._id_11CB.moon_lp_3, 0.3);
      _id_0380::_id_288B("zmb_orrery_ring_stop", undefined, level.orrery_moon_a);
      break;
    case 1:
      _id_0380::_id_6850(level._id_11CB.moon_lp_2, 0.3);
      _id_0380::_id_6850(level._id_11CB.moon_lp_3, 0.3);
      _id_0380::_id_288B("zmb_orrery_ring_stop", undefined, level.orrery_moon_a);
      break;
    case 2:
      _id_0380::_id_6850(level._id_11CB.moon_lp_3, 0.3);
      _id_0380::_id_288B("zmb_orrery_ring_stop", undefined, level.orrery_moon_a);
      break;
    case 3:
      _id_0380::_id_6850(level._id_11CB.moon_lp_4, 0.3);
      _id_0380::_id_288B("zmb_orrery_ring_stop", undefined, level.orrery_moon_a);
      break;
    case 4:
      break;
    default:
      break;
  }
}

moonraven_orrery_lock() {
  _id_0380::_id_288B("zmb_orrery_rings_lock", undefined, self);
}

blood_tube_door_open() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_blood_tube_door_open", undefined, self);
}

blood_tube_door_close() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_blood_tube_door_close", undefined, self);
}

blood_tube_filling_up() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_blood_tube_fill", undefined, self);
  wait 0.5;
  _id_0380::_id_288B("zmb_blood_tube_gore", undefined, self);
}

blood_tube_engulf(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_blood_tube_engulfed", undefined, var_0);
}

blood_tube_splash(var_0) {
  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_blood_tube_flush_splash", undefined, var_0);
}

pap_rise() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_pap_machine_rise", undefined, self);
  thread pap_rise_blood_lp_handler(self);
}

bloodraven_radio_pickup() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_radio_pickup", undefined, var_0);
}

bloodraven_speaker_pickup() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_speaker_pickup", undefined, var_0);
}

bloodraven_radio_place() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_radio_place", undefined, var_0);
}

bloodraven_speaker_place() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_speaker_place", undefined, var_0);
}

bloodraven_bloodstopper_pickup() {
  var_0 = self;
  _id_0380::_id_288B("zmb_bloodpool_stopper_pickup", undefined, var_0);
}

bloodraven_bloodstopper_place() {
  var_0 = self;
  _id_0380::_id_288B("zmb_bloodpool_stopper_place", undefined, var_0);
}

bloodraven_wustling_spawn() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_wustling_rise_blood", undefined, var_0);
}

bloodraven_bloodpool_ready() {
  var_0 = self;
  _id_0380::_id_6846("zmb_dsnt_bloodpool_sizzle_lp", undefined, self, 0.2, undefined, 0.5);
}

bloodraven_reveal_bloodpool_code(var_0) {
  _id_0380::_id_6842("zmb_dsnt_bloodpool_code_lp", undefined, var_0.origin, 0.2);

  switch (var_0.blood_fx_index) {
    case 1:
      _id_0380::_id_6842("zmb_dsnt_chaldni_e2_sml_lp", undefined, var_0.origin, 0.2);
      break;
    case 3:
      _id_0380::_id_6842("zmb_dsnt_chaldni_g2_sharp_sml_lp", undefined, var_0.origin, 0.2);
      break;
    case 5:
      _id_0380::_id_6842("zmb_dsnt_chaldni_b2_sml_lp", undefined, var_0.origin, 0.2);
      break;
    case 7:
      _id_0380::_id_6842("zmb_dsnt_chaldni_c3_sml_lp", undefined, var_0.origin, 0.2);
      break;
    case 8:
      _id_0380::_id_6842("zmb_dsnt_chaldni_c3_sharp_sml_lp", undefined, var_0.origin, 0.2);
      break;
    case 9:
      _id_0380::_id_6842("zmb_dsnt_chaldni_d3_sharp_sml_lp", undefined, var_0.origin, 0.2);
      break;
    case 11:
      _id_0380::_id_6842("zmb_dsnt_chaldni_e3_sml_lp", undefined, var_0.origin, 0.2);
      break;
  }
}

bloodraven_tune_radio() {
  var_0 = self;
  _id_0380::_id_288B("zmb_dsnt_chladni_radio_tune", undefined, var_0);
}

bloodraven_bloodcode_final(var_0, var_1) {
  var_2 = 2.5;
  var_3 = 1.5;

  if(isDefined(var_0.chladni_current_lp)) {
    _id_0380::_id_6850(var_0.chladni_current_lp, 1.5);
    var_0.chladni_current_lp = undefined;
  }

  if(issubstr(var_1, "to_1")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_e2", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6844("zmb_dsnt_chaldni_e2_lp", undefined, var_0.blood_fx_index, 1.25);
  } else if(issubstr(var_1, "to_3")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_g2_sharp", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6846("zmb_dsnt_chaldni_g2_sharp_lp", undefined, var_0.blood_fx_index, 1.25);
  } else if(issubstr(var_1, "to_5")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_b2", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6844("zmb_dsnt_chaldni_b2_lp", undefined, var_0.blood_fx_index, 1.25);
  } else if(issubstr(var_1, "to_7")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_c3", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6844("zmb_dsnt_chaldni_c3_lp", undefined, var_0.blood_fx_index, 1.25);
  } else if(issubstr(var_1, "to_8")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_c3_sharp", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6844("zmb_dsnt_chaldni_c3_sharp_lp", undefined, var_0.blood_fx_index, 1.25);
  } else if(issubstr(var_1, "to_9")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_d3_sharp", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6844("zmb_dsnt_chaldni_d3_sharp_lp", undefined, var_0.blood_fx_index, 1.25);
  } else if(issubstr(var_1, "to_11")) {
    wait(var_3);
    var_0.chladni_oneshot = _id_0380::_id_6844("zmb_dsnt_chaldni_e3", undefined, var_0.blood_fx_index);
    wait(var_2);
    var_0.chladni_current_lp = _id_0380::_id_6844("zmb_dsnt_chaldni_e3_lp", undefined, var_0.blood_fx_index, 1.25);
  }
}

enter_trial() {
  self _meth_8626("trials_teleport");
  _id_0380::_id_288B("zmb_dsnt_trials_enter", self, self);
  wait 1.5;
  self _meth_8627("trials_teleport");
}

exit_trial() {
  self _meth_8626("trials_teleport");
  _id_0380::_id_288B("zmb_dsnt_trials_exit", self, self);
  wait 1.5;
  self _meth_8627("trials_teleport");
}

pap_rise_blood_lp_handler(var_0) {
  if(!level._id_11CB.pap_rose_once_already) {
    level waittill("aud_pap_machine_blood_lp_starts");
    _id_0380::_id_6844("zmb_pap_machine_rise_blood_lp", undefined, var_0);
    level._id_11CB.pap_rose_once_already = 1;
  }
}

citadel_wpn_placement(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "shield_emp")
    _id_0380::_id_2889("zmb_citadel_emp_shield_place", undefined, var_1);
  else if(var_0 == "hammer_emp")
    _id_0380::_id_2889("zmb_citadel_emp_hammer_place", undefined, var_1);
  else if(var_0 == "scythe_emp")
    _id_0380::_id_2889("zmb_citadel_emp_scythe_place", undefined, var_1);
  else if(var_0 == "spike_emp")
    _id_0380::_id_2889("zmb_citadel_emp_spike_place", undefined, var_1);
  else
    return;
}

citadel_pillar_ignite(var_0) {
  _id_0380::_id_2889("zmb_citadel_pillar_explo_body", undefined, var_0);
}

citadel_shield_pillar_fire_lp(var_0) {
  if(!level._id_11CB.cit_shield_pillar_fire_playing) {
    level._id_11CB.shield_pillar_fire_snd_handle = _id_0380::_id_6842("zmb_citadel_pillar_fire_lp_03", undefined, var_0, 1.5);
    level._id_11CB.cit_shield_pillar_fire_playing = 1;
  }

  level waittill("aud_shield_removed_from_plith");

  if(isDefined(level._id_11CB.shield_pillar_fire_snd_handle)) {
    _id_0380::_id_6850(level._id_11CB.shield_pillar_fire_snd_handle);
    level._id_11CB.cit_shield_pillar_fire_playing = 0;
    level._id_11CB.shield_pillar_fire_snd_handle = undefined;
  }
}

citadel_hammer_pillar_fire_lp(var_0) {
  if(!level._id_11CB.cit_hammer_pillar_fire_playing) {
    level._id_11CB.hammer_pillar_fire_snd_handle = _id_0380::_id_6842("zmb_citadel_pillar_fire_lp_01", undefined, var_0, 1.5);
    level._id_11CB.cit_hammer_pillar_fire_playing = 1;
  }

  level waittill("aud_hammer_removed_from_plith");

  if(isDefined(level._id_11CB.hammer_pillar_fire_snd_handle)) {
    _id_0380::_id_6850(level._id_11CB.hammer_pillar_fire_snd_handle);
    level._id_11CB.cit_hammer_pillar_fire_playing = 0;
    level._id_11CB.hammer_pillar_fire_snd_handle = undefined;
  }
}

citadel_spike_pillar_fire_lp(var_0) {
  if(!level._id_11CB.cit_spike_pillar_fire_playing) {
    level._id_11CB.spike_pillar_fire_snd_handle = _id_0380::_id_6842("zmb_citadel_pillar_fire_lp_02", undefined, var_0, 1.5);
    level._id_11CB.cit_spike_pillar_fire_playing = 1;
  }

  level waittill("aud_spike_removed_from_plith");

  if(isDefined(level._id_11CB.spike_pillar_fire_snd_handle)) {
    _id_0380::_id_6850(level._id_11CB.spike_pillar_fire_snd_handle);
    level._id_11CB.cit_spike_pillar_fire_playing = 0;
    level._id_11CB.spike_pillar_fire_snd_handle = undefined;
  }
}

citadel_scythe_pillar_fire_lp(var_0) {
  if(!level._id_11CB.cit_scythe_pillar_fire_playing) {
    level._id_11CB.scythe_pillar_fire_snd_handle = _id_0380::_id_6842("zmb_citadel_pillar_fire_lp_04", undefined, var_0, 1.5);
    level._id_11CB.cit_scythe_pillar_fire_playing = 1;
  }

  level waittill("aud_scythe_removed_from_plith");

  if(isDefined(level._id_11CB.scythe_pillar_fire_snd_handle)) {
    _id_0380::_id_6850(level._id_11CB.scythe_pillar_fire_snd_handle);
    level._id_11CB.cit_scythe_pillar_fire_playing = 0;
    level._id_11CB.scythe_pillar_fire_snd_handle = undefined;
  }
}

citadel_all_weapons_placed() {
  _id_0380::_id_2889("zmb_citadel_all_weapons_placed", undefined, (-355, 731, 1900));
  _id_0380::_id_6842("zmb_citadel_plith_fire_lp", undefined, (-355, 731, 1900), 3.0);
}

citadel_entrance(var_0) {
  _id_0380::_id_2889("zmb_citadel_enter_one_shot", undefined, var_0);
  _id_0380::_id_6842("zmb_citadel_enter_lp", undefined, var_0);
}

aud_gdk_intro() {
  foreach(var_1 in level.players)
  var_1 _meth_8626("god_king_intro", 2.0);

  _id_0366::_id_8E33(3);
  var_3 = _id_0380::_id_6840("zmb_mus_god_king_intro");
  thread gdk_intro_viv_vox();
  thread gdk_intro_magic();
  _id_0380::_id_6840("zmb_gdk_intro_viv_fol");
  wait 4.1;
  _id_0380::_id_6840("zmb_gdk_intro_sword");
  wait 0.271;
  _id_0380::_id_6840("zmb_gdk_intro_room_response");
  wait 2.267;
  _id_0380::_id_6840("zmb_gdk_intro_gdk_fol");
  wait 6.353;
  _id_0380::_id_6840("zmb_gdk_intro_smash");
  wait 5.0;

  if(isDefined(var_3)) {
    _id_0380::_id_6850(var_3, 4.0);
    var_3 = undefined;
  }

  foreach(var_1 in level.players)
  var_1 _meth_8627("god_king_intro");
}

gdk_intro_viv_vox() {
  wait 4.052;
  _id_0380::_id_6840("zmb_gdk_intro_viv_vox");
}

gdk_intro_magic() {
  wait 4.393;
  _id_0380::_id_6840("zmb_gdk_intro_gdk_magic", undefined, 1.5);
}

boss_music_start() {
  wait 1;

  foreach(var_1 in level.players)
  var_1 _meth_8626("god_king_fight", 2.0);

  if(!isDefined(level._id_11CB.boss_music_playing) && !isDefined(level._id_11CB.boss_is_dead)) {
    level._id_11CB.boss_music_playing = 1;

    foreach(var_1 in level.players) {
      var_1 _id_0366::_id_8E47(1.0);
      var_1 _id_0366::snd_set_auto_wave_music_enabled(0);
      var_1 notify("kill_wave_mus_switcher");
      var_1 _id_0366::_id_8E31("bob_fight", 0.25, 3);
    }
  }
}

dlc_handle_boss_killed_music() {
  level._id_11CB.boss_music_playing = undefined;
  level._id_11CB.boss_is_dead = 1;

  foreach(var_1 in level.players) {
    var_1 _id_0366::_id_8E09();
    var_1 thread dlc_play_boss_killed_stinger();
  }
}

dlc_play_boss_killed_stinger() {
  self _meth_8626("bob_death_stinger", 0.2);
  _id_0380::_id_2888("mus_bob_death_stinger", self);
  wait 10;
  self _meth_8627("bob_death_stinger", 4.0);
  self _meth_8627("god_king_fight", 4.0);
}

archives_spike_trap(var_0) {
  _id_0380::_id_2889("trap_spikes", undefined, var_0.origin);
}

damage_ice() {
  var_0 = self;
  var_0.damage_snd = _id_0380::_id_288B("zmb_dsnt_ice_dmg", undefined, self);
}

break_ice() {
  var_0 = self;
  var_0.break_snd = _id_0380::_id_288B("zmb_dsnt_ice_break", undefined, self);
}

spawn_raven() {
  while(isDefined(self)) {
    var_0 = _func_0A4(5, 10);
    level._id_11CB.crow_amb_caw = _id_0380::_id_288B("zmb_dsnt_raven_ee_caw", undefined, self);
    wait(var_0);
  }
}

raven_fly_away() {
  _id_0380::_stoplocalsound(level._id_11CB.crow_amb_caw, 0.1);
  _id_0380::_id_2889("training_crow_caw", undefined, self.origin);
}

outro_vo_submix_start() {
  foreach(var_1 in level.players)
  var_1 _meth_8626("outro_vo");
}

outro_vo_submix_end() {
  foreach(var_1 in level.players)
  var_1 _meth_8627("outro_vo");
}