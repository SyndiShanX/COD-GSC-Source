/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_658912bcc638205.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_b6fe1dbe;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::trigger_init(&_trigger);
  snd::trigger_init(&function_2733af4e, "audio_custom_trigger", "targetname");
  snd::function_5e69f468(&_objective);
  snd::wait_init();
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  level.var_cf6581e7 = 0;
  level.var_190f5ea8 = "start";
  level.var_1a702ee5 = 1;
  level.var_948f8ad5 = 1;
  level.var_f346a11f = 1;
  level.var_743d2803 = 1;
  level.var_dc404c80 = 1;
  level.var_d571b32d = 0;
}

function private function_32ab045(ent, name) {
  switch (name) {
    case # "player":
      player = ent;
      player waittill(#"death", #"disconnect");
      player = undefined;
      break;
    case # "perseus":
      level.perseus = ent;
      ent waittill(#"death");
      level.perseus = undefined;
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69(name, "<dev string:x5d>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");

  switch (trigger_name) {
    case # "$default":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>");

      break;
  }
}

function private function_2733af4e(player, trigger, var_ec80d14b) {
  var_e3462120 = snd::function_ea2f17d1(var_ec80d14b.script_noteworthy, "");

  switch (var_e3462120) {
    case # "hash_42ccbe8fe4a4c00":
      function_5ea2c6e3("cp_pris_bridge_walk", 0.5, 1);
      function_5ea2c6e3("cp_pris_bridge_run", 0.5, 1);
      function_5ea2c6e3("cp_pris_bridge_sprint", 0.5, 1);
      util::wait_till_not_touching(trigger, var_ec80d14b);
      function_ed62c9c2("cp_pris_bridge_walk", 0.5);
      function_ed62c9c2("cp_pris_bridge_run", 0.5);
      function_ed62c9c2("cp_pris_bridge_sprint", 0.5);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x86>" + var_e3462120 + "<dev string:x5d>");

      break;
  }
}

function function_66f72926() {
  function_5ea2c6e3("cp_pris_ladder_hand", 0.5, 1);
  function_5ea2c6e3("cp_pris_ladder_foot", 0.5, 1);
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "global_submix":
      function_5ea2c6e3("cp_nam_prisoner_global_submix", 0, 1);
      function_5ea2c6e3("cp_nam_prisoner_exploration", 0, 1);
      break;
    case # "exploration_mix_on":
      function_5ea2c6e3("cp_nam_prisoner_exploration", 3, 1);
      break;
    case # "exploration_mix_off":
      function_ed62c9c2("cp_nam_prisoner_exploration", 3);
      break;
    case # "intro_scene":
      thread intro_scene();
      break;
    case # "intro_mix_3":
      thread intro_mix_3();
      break;
    case # "intro_mix_4":
      thread intro_mix_4();
      break;
    case # "intro_mix_5":
      thread intro_mix_5();
      break;
    case # "rice_paddies_1_start":
      function_5ea2c6e3("cp_nam_prisoner_rice_paddies_battle");
      break;
    case # "hash_3453089a606822fb":
      break;
    case # "rice_paddies_3_start":
      function_5ea2c6e3("cp_nam_prisoner_rice_paddies_battle");
      break;
    case # "rice_paddies_bc_1":
      level.rice_paddies_bc_1 = snd::emitter("vox_rice_paddies_vtn_distant_bc", (-1064, -4632, 223), [0.5, 7], [200, 800]);
      break;
    case # "rice_paddies_bc_2":
      level.rice_paddies_bc_2 = snd::emitter("vox_rice_paddies_vtn_distant_bc", (-1064, -4632, 223), [0.5, 7], [200, 800]);
      break;
    case # "rice_paddies_bc_3":
      level.rice_paddies_bc_3 = snd::emitter("vox_rice_paddies_adlr_distant_bc", (-1064, -4632, 223), [2, 8], [200, 800]);
      break;
    case # "rice_paddies_1_end":
      function_ed62c9c2("cp_nam_prisoner_rice_paddies_battle");
      snd::stop(level.rice_paddies_bc_1);
      break;
    case # "rice_paddies_2_end":
      snd::stop(level.rice_paddies_bc_2);
      break;
    case # "rice_paddies_3_end":
      snd::stop(level.rice_paddies_bc_3);
      function_ed62c9c2("cp_nam_prisoner_rice_paddies_battle");
      break;
    case # "waterfall_kill_right":
      thread waterfall_kill("right");
      break;
    case # "waterfall_kill_left":
      thread waterfall_kill("left");
      break;
    case # "waterfall_slowmo_start":
      thread waterfall_slowmo_start();
      break;
    case # "waterfall_slowmo_stop":
      thread waterfall_slowmo_stop();
      break;
    case # "waterfall_throw_knife":
      thread waterfall_throw_knife();
      break;
    case # "mkultra_sound_on":
      level notify(#"mkultra_sound_on");
      break;
    case # "mkultra_sound_off":
      level notify(#"mkultra_sound_off");
      break;
    case # "start_frozen_battle":
      thread function_20018404();
      break;
    case # "stop_frozen_battle":
      level notify(#"hash_135069eaafe77dc0");
      break;
    case # "hash_559e7c9c03da213b":
      level notify(#"hash_559e7c9c03da213b");
      break;
    case # "timeofday_day":
      setsoundcontext("timeofday", "day");
      break;
    case # "timeofday_night":
      setsoundcontext("timeofday", "night");
      break;
    case # "emi_allruns_play":
      emi_allruns_play();
      thread function_42a7819b();
      thread function_8b66fcd3();
      function_66f72926();
      break;
    case # "emi_allruns_stop":
      emi_allruns_stop();
      level notify(#"hash_555ba3576c3cbf50");
      break;
    case # "emi_day_play":
      emi_day_play();
      break;
    case # "hash_4ef8030b21c8f964":
      break;
    case # "emi_night_play":
      emi_night_play();
      break;
    case # "hash_d74c565087804b0":
      break;
    case # "hash_57530adbd77d1885":
      break;
    case # "pre_injection_hallway_sfx":
      thread pre_injection_hallway_sfx();
      break;
    case # "arcade_start":
      function_5ea2c6e3("cp_nam_prisoner_arcade", 2, 1);
      break;
    case # "arcade_exit":
      function_ed62c9c2("cp_nam_prisoner_arcade", 2);
      break;
    case # "hallway_voice_1":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_whyisbellrepeat_f9");
      }

      break;
    case # "hallway_voice_2":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_whyisbellrepeat_fa");
      }

      break;
    case # "hallway_voice_3":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_whyisbellrepeat_56");
      }

      break;
    case # "hallway_voice_4":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_bellstopspeakin_2d");
      }

      break;
    case # "hallway_voice_5":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_stopwastingmyti_8c");
      }

      break;
    case # "hallway_voice_6":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_turnaroundbell_4b");
      }

      break;
    case # "hallway_voice_7":
      if(level.var_dc404c80 == 1) {
        snd::play("vox_cp_prsn_09000_adlr_bellgothroughad_38");
      }

      break;
    case # "rat_tunnels_amb_zombies":
      thread rat_tunnels_amb_zombies();
      break;
    case # "rat_tunnels_throb_low":
      thread function_488e467();
      break;
    case # "rat_tunnels_throb_medium":
      level notify(#"rat_tunnels_throb_medium");
      break;
    case # "rat_tunnels_throb_high":
      level notify(#"rat_tunnels_throb_high");
      break;
    case # "rat_tunnels_ambience_fade_out":
      level notify(#"rat_tunnels_ambience_fade_out");
      function_ed62c9c2("cp_nam_prisoner_rat_tunnels");
      break;
    case # "cave_entry":
      thread function_a159adc3();
      break;
    case # "projector_room_enter":
      audio::snd_set_snapshot("cp_nam_prisoner_projector_room");
      function_b6407dd4(0);
      break;
    case # "projector_room_exit":
      audio::snd_set_snapshot("default");
      function_b6407dd4(1);
      break;
    case # "cave_footsteps":
      thread cave_footsteps();
      break;
    case # "infinite_hallway_ambience_1":
      level.var_ad3afa08 = 1;
      level.var_c635eb23 = 1;
      thread function_c635eb23();
      level notify(#"hash_df4e0488c76955a");
      break;
    case # "infinite_hallway_ambience_2":
      level.var_c635eb23 = 2;
      level notify(#"hash_df4e0488c76955a");
      break;
    case # "infinite_hallway_ambience_3":
      level.var_c635eb23 = 3;
      level notify(#"hash_df4e0488c76955a");
      break;
    case # "infinite_hallway_ambience_4":
      level.var_c635eb23 = 4;
      level notify(#"hash_df4e0488c76955a");
      break;
    case # "infinite_hallway_ambience_end":
      level.var_ad3afa08 = 0;
      level notify(#"hash_df4e0488c76955a");
      break;
    case # "stop_hallway_sfx":
      level notify(#"stop_hallway_sfx");
      break;
    case # "shrinking_hallway1_hide":
      level.var_1a702ee5 = 1;

      if(level.var_948f8ad5 == 1 && level.var_f346a11f == 1 && level.var_743d2803 == 1) {
        level.var_dc404c80 = 1;
      }

      break;
    case # "shrinking_hallway2_hide":
      level.var_948f8ad5 = 1;

      if(level.var_1a702ee5 == 1 && level.var_f346a11f == 1 && level.var_743d2803 == 1) {
        level.var_dc404c80 = 1;
      }

      break;
    case # "shrinking_hallway3_hide":
      level.var_f346a11f = 1;

      if(level.var_1a702ee5 == 1 && level.var_948f8ad5 == 1 && level.var_743d2803 == 1) {
        level.var_dc404c80 = 1;
      }

      break;
    case # "shrinking_hallway4_hide":
      level.var_743d2803 = 1;

      if(level.var_1a702ee5 == 1 && level.var_948f8ad5 == 1 && level.var_f346a11f == 1) {
        level.var_dc404c80 = 1;
      }

      break;
    case # "shrinking_hallway1_unhide":
      level.var_1a702ee5 = 0;
      level.var_dc404c80 = 0;
      break;
    case # "shrinking_hallway2_unhide":
      level.var_948f8ad5 = 0;
      level.var_dc404c80 = 0;
      break;
    case # "shrinking_hallway3_unhide":
      level.var_f346a11f = 0;
      level.var_dc404c80 = 0;
      break;
    case # "shrinking_hallway4_unhide":
      level.var_743d2803 = 0;
      level.var_dc404c80 = 0;
      break;
    case # "shrinking_hallway_start":
      thread function_4422f3fe();
      break;
    case # "shrinking_hallway_end":
      level notify(#"shrinking_hallway_end");
      level.var_dc404c80 = 1;
      break;
    case # "infinite_hallway_loop_start":
      level.var_4b36b09 = "start";
      thread function_670b73d1();
      break;
    case # "infinite_hallway_loop_low":
      level.var_4b36b09 = "low";
      thread function_670b73d1();
      break;
    case # "infinite_hallway_loop_mid":
      level.var_4b36b09 = "mid";
      thread function_670b73d1();
      break;
    case # "infinite_hallway_loop_high":
      level.var_4b36b09 = "high";
      thread function_670b73d1();
      break;
    case # "hash_4fef8a23b1544f54":
      voice = snd::play("vox_cp_prsn_13000_pers_theunitedstates_9f", [level.perseus, "j_head"]);
      wait 3;
      snd::set_pitch(voice, 0.01, 3);
      wait 2;
      snd::stop(voice, 0.1);
      break;
    case # "bunker_door_used":
      level notify(#"bunker_door_used");
      break;
    case # "bunker_room_final":
      forceambientroom("int_bunker_end");
      break;
    case # "cinematic_duck_start":
      function_5ea2c6e3("cp_nam_prisoner_cin", 1, 1);
      break;
    case # "cinematic_duck_end":
      function_ed62c9c2("cp_nam_prisoner_cin");
      break;
    case # "musictrack_cp_prisoner_2":
    case # "musictrack_cp_prisoner_3":
    case # "musictrack_cp_prisoner_1":
    case # "musictrack_cp_prisoner_6":
    case # "musictrack_cp_prisoner_4":
    case # "musictrack_cp_prisoner_5":
      function_2cca7b47(0, msg);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xb1>" + snd::function_783b69(msg, "<dev string:x5d>"));

      break;
  }
}

function private _objective(objective) {
  switch (objective) {
    case # "intro":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xcf>" + objective + "<dev string:x5d>");

      break;
  }
}

function emi_allruns_play() {
  players = snd::function_da785aa8();
  player = players[0];
  level.var_fae1e01f = snd::emitter("amb_prs_gust", (-734, 2515, 157), [4, 12], 200, [-60, 60], [-20, 20]);
  level.var_7b3e60d6 = snd::emitter("amb_prs_gust", (-260, 2213, 67), [4, 12], 200, [-60, 60], [-20, 20]);
  level.var_4e838761 = snd::emitter("amb_prs_gust", (-98, 1963, 19), [4, 12], 200, [-60, 60], [-20, 20]);
  level.var_39a80e25 = snd::emitter("amb_prs_gust", (-1182, 3275, 513), [4, 12], 200, [-60, 60], [-20, 20]);
  level.var_6865eba0 = snd::emitter("amb_prs_gust", (-1185, 2708, 403), [4, 12], 200, [-60, 60], [-20, 20]);
  level.var_ad1c7514 = snd::emitter("amb_prs_gust", (-1012, 2179, 418), [4, 12], 200, [-60, 60], [-20, 20]);
  level.var_1a375e68 = snd::emitter("amb_prs_rice_paddies_dist_gunf", (-1240, -4460, 847), [2, 20], [1000, 1001]);
  level.var_1a375e68 = snd::emitter("amb_prs_rice_paddies_dist_gunf", (-1240, -4460, 847), [8, 60], [1000, 1001]);
  level.var_a09d5a94 = snd::play("amb_pris_river_close_lp", (-1437, 918, 196));
  level.var_9283be61 = snd::play("amb_pris_river_close_lp", (-1437, 918, 196));
  level.var_352f03b9 = snd::play("amb_pris_river_close_lp", (-1437, 918, 196));
  level.var_a6e1671c = snd::play("amb_pris_river_close_lp", (-1437, 918, 196));
  level.var_c96aac2e = snd::play("amb_pris_river_close_lp", (-1437, 918, 196));
  level.var_cba2fe51 = snd::play("amb_pris_river_close_lp_sml_radius", (-1437, 918, 196));
  level.var_ae62c3d1 = snd::play("amb_pris_river_close_lp_sml_radius", (-1437, 918, 196));
  level.var_cbcbfe9f = snd::play("amb_pris_river_close_lp_sml_radius", (-1437, 918, 196));
  level.var_ae0dc323 = snd::play("amb_pris_river_close_lp_sml_radius", (-1437, 918, 196));
  function_30054301(level.var_a09d5a94, player, (-1437, 918, 196), (-570, 905, 170));
  function_30054301(level.var_9283be61, player, (-2049, 903, 325), (-1591, 908, 285));
  function_30054301(level.var_352f03b9, player, (-272, 809, -343), (66, 2302, -330));
  function_30054301(level.var_a6e1671c, player, (-671, 2471, -310), (777, 2585, -331));
  function_30054301(level.var_c96aac2e, player, (-3448, 2840, -244), (-836, 2498, -244));
  function_30054301(level.var_cba2fe51, player, (-774, 2505, -329), (1202, 2397, -327));
  function_30054301(level.var_ae62c3d1, player, (-1355, 2459, -325), (2180, 2318, -324));
  function_30054301(level.var_cbcbfe9f, player, (889, 2605, -327), (1426, 2746, -322));
  function_30054301(level.var_ae0dc323, player, (1502, 2842, -322), (1656, 2990, -322));
  level.var_dd5c8b21 = snd::play("amb_cave_river_close_hv_splashes_lp", (2076, 4263, -976));
  level.var_f39cb7a1 = snd::play("amb_cave_river_close_hv_splashes_lp", (2327, 4649, -976));
  level.var_de5224 = snd::play("amb_cave_river_close_very_calm_lp", (3530, 6544, -1130));
  level.var_17297eba = snd::play("amb_cave_river_close_very_calm_lp", (3479, 6337, -1130));
  level.var_b8b1c1c4 = snd::play("amb_cave_river_close_very_calm_lp", (5155, 6620, -1233));
  function_30054301(level.var_dd5c8b21, player, (2076, 4263, -976), (2327, 4649, -976));
  function_30054301(level.var_f39cb7a1, player, (2327, 4649, -976), (2343, 5320, -976));
  function_30054301(level.var_de5224, player, (3530, 6544, -1130), (4028, 6537, -1130));
  function_30054301(level.var_17297eba, player, (3479, 6337, -1130), (4128, 6169, -1130));
  function_30054301(level.var_b8b1c1c4, player, (5155, 6620, -1233), (6726, 6624, -1233));
}

function emi_allruns_stop() {
  if(level.var_d571b32d == 0) {
    return;
  }

  level.var_d571b32d = 0;
  level notify(#"snd_emitter_stop");
  function_ff8cbed3(level.var_dd5c8b21);
  function_ff8cbed3(level.var_f39cb7a1);
  function_ff8cbed3(level.var_de5224);
  function_ff8cbed3(level.var_17297eba);
  function_ff8cbed3(level.var_b8b1c1c4);
  snd::stop(level.var_dd5c8b21);
  snd::stop(level.var_f39cb7a1);
  snd::stop(level.var_de5224);
  snd::stop(level.var_17297eba);
  snd::stop(level.var_b8b1c1c4);
  function_ff8cbed3(level.var_a09d5a94);
  function_ff8cbed3(level.var_9283be61);
  function_ff8cbed3(level.var_352f03b9);
  function_ff8cbed3(level.var_a6e1671c);
  function_ff8cbed3(level.var_c96aac2e);
  function_ff8cbed3(level.var_cba2fe51);
  function_ff8cbed3(level.var_ae62c3d1);
  function_ff8cbed3(level.var_cbcbfe9f);
  function_ff8cbed3(level.var_ae0dc323);
  snd::stop(level.var_a09d5a94);
  snd::stop(level.var_9283be61);
  snd::stop(level.var_352f03b9);
  snd::stop(level.var_a6e1671c);
  snd::stop(level.var_c96aac2e);
  snd::stop(level.var_cba2fe51);
  snd::stop(level.var_ae62c3d1);
  snd::stop(level.var_cbcbfe9f);
  snd::stop(level.var_ae0dc323);
  snd::stop(level.var_fae1e01f);
  snd::stop(level.var_7b3e60d6);
  snd::stop(level.var_4e838761);
  snd::stop(level.var_39a80e25);
  snd::stop(level.var_6865eba0);
  snd::stop(level.var_ad1c7514);
  snd::stop(level.var_1a375e68, 1);
}

function emi_day_play() {
  level.var_4ceeb983 = snd::emitter("amb_pris_heli", (0, 0, 2000), [30, 90], [5000, 6000], [-10, 10]);
  level.var_ddc9eb81 = snd::emitter("amb_pris_jet", (0, 0, 2000), [30, 90], [5000, 6000], [-10, 10]);
}

function emi_night_play() {}

function function_3587d33f() {
  level.env_nam_computer_whine_01_lp = snd::play(["env_nam_computer_whine_01_lp", 1], (-529, 10907, -1060));
  level.env_nam_computer_whine_02_lp = snd::play(["env_nam_computer_whine_02_lp", 1], (-761, 11099, -1051));
  level.env_nam_computer_whine_03_lp = snd::play(["env_nam_computer_whine_03_lp", 1], (-481, 11453, -1041));
  level.env_nam_computer_whine_04_lp = snd::play(["env_nam_computer_whine_04_lp", 1], (-442, 11018, -1024));
  level.env_nam_projector_lp = snd::play(["env_nam_projector_lp", 1], (4508, 16524, -1017));
  level.env_wall_clock_lab_tick_lp = snd::play(["env_wall_clock_lab_tick_lp", 1], (4541, 16406, -975));
  var_63769da3 = "env_nam_crt_screen_lp";
  var_8e980ccc = [(-796, 11031, -1024), (4448, 16623, -1009), (4602, 16623, -1006)];
  level.var_f262f2ef = snd::play(var_63769da3, var_8e980ccc);
}

function function_1acbe626(alias, pos, time_min, time_max) {
  while(true) {
    snd::play(alias, pos);
    wait randomfloatrange(time_min, time_max);
  }
}

function function_d745794a() {
  players = snd::function_da785aa8();
  player = players[0];
  var_16f8cca9 = player getlocalclientnumber();
  var_4bbef51c = getEntArray(var_16f8cca9, "audio_foliage", "targetname");

  foreach(foliage in var_4bbef51c) {
    foliage thread function_a2a87870();
  }
}

function function_a2a87870() {
  level endon(#"hash_555ba3576c3cbf50");
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  walk = 20;
  sprint = 100;

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    speed = abs(player getspeed());

    if(player istouching(self)) {
      if(speed >= walk && speed < sprint) {
        snd::play("evt_pris_foliage");
        wait 0.6;
      } else if(speed >= sprint) {
        snd::play("evt_pris_foliage_sprint");
        wait 0.23;
      }
    }

    waitframe(3);
  }
}

function function_42a7819b() {
  players = snd::function_da785aa8();
  player = players[0];
  var_16f8cca9 = player getlocalclientnumber();
  var_4bbef51c = getEntArray(var_16f8cca9, "audio_grass", "targetname");

  foreach(foliage in var_4bbef51c) {
    foliage thread function_5c29b8ba();
  }

  var_fad53314 = getEntArray(var_16f8cca9, "audio_grass_mix", "targetname");

  foreach(mix in var_fad53314) {
    mix thread function_a8208aac();
  }
}

function function_5c29b8ba() {
  level endon(#"hash_555ba3576c3cbf50");
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  playing = 0;
  grass = undefined;
  var_5d54552c = 0;
  touching = 0;

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    speed = abs(player getspeed());

    if(player istouching(self)) {
      if(speed > 20 && !isDefined(grass)) {
        grass = snd::play("amb_waterfall_kill_grass_lp");
      } else if(isDefined(grass) && speed <= 20) {
        snd::stop(grass);
      }

      vol = mapfloat(20, 200, 0, 1, speed);
      var_5d54552c = snd::function_e8185c19(vol, var_5d54552c, 0.3);

      if(isDefined(grass)) {
        snd::set_volume(grass, var_5d54552c);
      }
    } else if(isDefined(grass)) {
      snd::stop(grass, 1);
    }

    waitframe(3);
  }
}

function function_a8208aac() {
  level endon(#"hash_555ba3576c3cbf50");
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  var_eee381c9 = 0;

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    stance = player getstance();

    if(player istouching(self)) {
      if(var_eee381c9 == 0 && stance == "crouch") {
        function_5ea2c6e3("cp_nam_prisoner_waterfall_kill_grass", 1, 1);
        var_eee381c9 = 1;
      } else if(var_eee381c9 == 1 && stance != "crouch") {
        function_ed62c9c2("cp_nam_prisoner_waterfall_kill_grass", 0.5);
        var_eee381c9 = 0;
      }
    } else {
      if(var_eee381c9 == 1) {
        function_ed62c9c2("cp_nam_prisoner_waterfall_kill_grass", 0.5);
      }

      var_eee381c9 = 0;
    }

    waitframe(1);
  }
}

function function_8b66fcd3() {
  players = snd::function_da785aa8();
  player = players[0];
  var_16f8cca9 = player getlocalclientnumber();
  var_2534b9f9 = getEntArray(var_16f8cca9, "audio_bridge_vol", "targetname");

  foreach(var_9a11ae59 in var_2534b9f9) {
    var_9a11ae59 thread function_b22795c1();
  }
}

function function_b22795c1() {
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  var_eee381c9 = 0;

  while(true) {
    iprintlnbold("active");
    players = snd::function_da785aa8();
    player = players[0];

    if(isDefined(self) && player istouching(self)) {
      if(var_eee381c9 == 0) {
        iprintlnbold("active");
        var_eee381c9 = 1;
      }
    } else if(var_eee381c9 == 1) {
      iprintlnbold("inactive");
      var_eee381c9 = 0;
    }

    waitframe(1);
  }
}

function intro_scene() {
  thread function_962367b8();
  thread function_19dc715d();
}

function function_962367b8() {
  snd::play("evt_cp_nam_pris_intro_start");
}

function function_19dc715d() {
  function_5ea2c6e3("cp_nam_prisoner_intro_ambience");
  wait 17.35;
  snd::play("evt_cp_nam_pris_intro_chopper");
  wait 20;
  function_ed62c9c2("cp_nam_prisoner_intro_ambience");
}

function intro_mix_3() {
  function_5ea2c6e3("cp_nam_prisoner_intro_3", 6, 1);
  wait 10;
  function_ed62c9c2("cp_nam_prisoner_intro_3", 4);
}

function intro_mix_4() {
  function_5ea2c6e3("cp_nam_prisoner_intro_4", 2, 1);
  wait 3.5;
  function_ed62c9c2("cp_nam_prisoner_intro_4", 4);
}

function intro_mix_5() {
  function_5ea2c6e3("cp_nam_prisoner_intro_5", 2, 1);
  wait 3.5;
  function_ed62c9c2("cp_nam_prisoner_intro_5", 4);
}

function function_488e467() {
  var_477fac82 = snd::play("evt_rat_tunnels_heartbeat_lp");
  snd::set_volume(var_477fac82, 0.251);
  level waittill(#"rat_tunnels_throb_medium");
  snd::set_volume(var_477fac82, 0.501, 1);
  snd::set_pitch(var_477fac82, 1.07, 1);
  level waittill(#"rat_tunnels_throb_high");
  snd::set_volume(var_477fac82, 1, 3);
  snd::set_pitch(var_477fac82, 1.15, 3);
  level waittill(#"rat_tunnels_ambience_fade_out");
  snd::stop(var_477fac82, 3);
  snd::set_pitch(var_477fac82, 0.9, 3);
}

function rat_tunnels_amb_zombies() {
  front = snd::play("amb_rat_tunnels_zombies_front", (524, 68, -1641));
  var_38a08682 = snd::play("amb_rat_tunnels_zombies_back", (1892, -21, -1641));
  level waittill(#"rat_tunnels_ambience_fade_out");
  snd::stop(front, 3);
  snd::stop(var_38a08682, 3);
}

function waterfall_kill(side) {
  org1 = (68, 1025, -294);
  org2 = (-41, 1267, -309);
  var_75d9de4d = (252, 1155, -303);
  var_ab2ec8f6 = (193, 1444, -301);
  players = snd::function_da785aa8();
  player = players[0];
  victim = player.origin + anglesToForward(player.angles) * 200 + (0, 0, 30);
  function_5ea2c6e3("cp_nam_prisoner_slowmo_waterfall", 1, 1);

  if(side == "left") {
    snd::play("evt_pris_knife_takedown_left");
    snd::play("vox_pris_stealth_pain_victim_left", victim);
  } else {
    snd::play("evt_pris_knife_takedown_right");
    snd::play("vox_pris_stealth_pain_victim_right", victim);
  }

  snd::play([1.5, "vox_waterfall_kill_startle_enemy_1"], org1);
  snd::play([1.8, "vox_waterfall_kill_startle_enemy_2"], org2);
  snd::play([2.6, "vox_waterfall_kill_startle_enemy_3"], var_75d9de4d);
  snd::play([2.8, "vox_pris_stealth_death_victim"], victim);
  snd::play([3.4, "vox_waterfall_kill_startle_enemy_4"], var_ab2ec8f6);
}

function waterfall_slowmo_start() {
  level.var_6ab46996 = snd::play("evt_pris_knife_throw_slowmo_start");
}

function waterfall_slowmo_stop() {
  wait 0.5;
  snd::stop(level.var_6ab46996);
  snd::play("evt_pris_knife_throw_slowmo_stop");
  function_ed62c9c2("cp_nam_prisoner_slowmo_waterfall", 1.5);
}

function waterfall_throw_knife() {
  snd::play("evt_pris_knife_throw");
}

function function_a159adc3() {}

function cave_footsteps() {
  level endon(#"visit_restart");
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");
  var_f4eb3697 = 0;
  self.cave_footsteps = 1;
  function_5ea2c6e3("cp_nam_prisoner_cave_footsteps");
  self thread function_440134fd();

  while(self.cave_footsteps == 1) {
    players = snd::function_da785aa8();
    player = players[0];
    speed = abs(player getspeed());
    blend = mapfloat(20, 200, 1, 0, speed);
    var_f4eb3697 = snd::function_e8185c19(blend, var_f4eb3697, 0.8);
    function_672403ca("cp_nam_prisoner_cave_footsteps", 0, var_f4eb3697);
    waitframe(1);
  }

  function_ed62c9c2("cp_nam_prisoner_cave_footsteps", 1);
}

function function_440134fd() {
  level waittill(#"bunker_door_used");
  self.cave_footsteps = 0;
}

function pre_injection_hallway_sfx() {
  self endon(#"end");
  wait 0.3;
  level.var_fac92819 = 1;
  level.var_d20c84d7 = 0.9;
  level.var_c8f7b65d = 0.8;
  level.var_db673ddc = 0.97;
  var_1beeaa7f = (-997, 9836, -1221);
  var_517e15c3 = snd::play("mus_hallway_tape_machine", var_1beeaa7f);
  self thread function_a2188d1a(var_517e15c3, var_1beeaa7f);
  var_ea09dcad = snd::play("mus_hallway");
  var_9e4626e9 = snd::play("mus_hallway_reverse");
  snd::set_volume(var_9e4626e9, 0);
  snd::set_volume(var_ea09dcad, 0);
  level.var_46b963df = "forward";
  reversed = 0;
  level waittill(#"mkultra_sound_on");
  snd::play("evt_hallway_mkultra_injection");
  snd::set_volume(var_ea09dcad, 1, 3);
  snd::stop(var_517e15c3, 3);
  function_5ea2c6e3("cp_nam_prisoner_mk_ultra_inf_hallway", 1, 1);
  heartbeat = snd::play("evt_hallway_mkultra_heartbeat_drone_lp");
  thread function_ab421080();
  snd::set_volume(heartbeat, 0);
  snd::set_pitch(heartbeat, 0.5);
  waitframe(1);
  snd::set_volume(heartbeat, 1, 6);
  snd::set_pitch(heartbeat, 1, 10);
  level.var_7454541e = 1;
  self thread function_3a0734a4(heartbeat);
  drop = 0;
  wait 3;

  while(level.var_7454541e == 1) {
    pitch = randomfloatrange(0.95, 1.05) + drop;

    if(pitch <= 0.5) {
      pitch = 0.5;
    }

    time = randomfloatrange(0.1, 0.4);
    snd::set_pitch(var_ea09dcad, pitch, time, "easeinout");
    wait time;
    drop -= 5e-05;
  }

  var_8f1ace57 = pitch;
  var_5d54552c = 1;
  self thread function_bf5b08ac(var_ea09dcad, var_9e4626e9);

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    speed = abs(player getspeed());
    pitch = mapfloat(20, 200, level.var_d20c84d7, level.var_fac92819, speed);
    var_8f1ace57 = snd::function_e8185c19(pitch, var_8f1ace57, level.var_db673ddc);
    vol = mapfloat(20, 200, level.var_c8f7b65d, 1, speed);
    var_5d54552c = snd::function_e8185c19(vol, var_5d54552c, 0.1);
    snd::set_pitch(var_ea09dcad, var_8f1ace57);
    snd::set_pitch(var_9e4626e9, var_8f1ace57);

    if(level.var_46b963df == "backward") {
      snd::set_volume(var_ea09dcad, 0, 0.05);
      snd::set_volume(var_9e4626e9, var_5d54552c, 0);
    }

    if(level.var_46b963df == "forward") {
      snd::set_volume(var_ea09dcad, var_5d54552c, 0);
      snd::set_volume(var_9e4626e9, 0, 0.05);
    }

    waitframe(1);
  }
}

function function_a2188d1a(snd, loc) {
  level endon(#"mkultra_sound_off");
  players = snd::function_da785aa8();
  player = players[0];

  while(true) {
    level waittill(#"bunker_door_used");

    if(isDefined(snd)) {
      snd linkto(player);
    }

    waitframe(10);

    if(isDefined(snd)) {
      snd unlink();
    }

    snd moveto(loc, 0.5);
  }
}

function function_cc22752b(start_point) {
  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    org_player = player snd::getplayervieworigin();

    if(distance(org_player, start_point) < 50) {
      break;
    }

    waitframe(1);
  }

  level notify(#"hash_9f518241346adc7");

  while(true) {
    iprintlnbold(level.var_46b963df);
    waitframe(1);
  }
}

function function_ab421080() {
  var_6b216c00 = 0.398;
  var_ec67eb1d = 1;
  var_b3f50719 = 0.5;
  var_4cb03c63 = 1;
  var_f6b97b2f = 0.8;
  var_dff37609 = 0.3;
  var_b1dff62a = 20;
  vol = var_6b216c00;
  pitch = var_b3f50719;
  time = var_f6b97b2f;

  for(i = 0; i < var_b1dff62a; i++) {
    thread function_500b7ed1(vol, pitch);
    pitch += abs((var_4cb03c63 - var_b3f50719) / var_b1dff62a);
    vol += abs((var_ec67eb1d - var_6b216c00) / var_b1dff62a);
    wait time;
    time -= abs((var_f6b97b2f - var_dff37609) / var_b1dff62a);
  }

  while(level.var_7454541e == 1) {
    thread function_500b7ed1(vol, pitch);
    level notify(#"hash_3d359ce45bd789ce");
    wait var_dff37609;
  }

  for(i = 0; i < var_b1dff62a; i++) {
    thread function_500b7ed1(vol, pitch);
    level notify(#"hash_3d359ce45bd789ce");
    pitch -= abs((var_4cb03c63 - var_b3f50719) / var_b1dff62a);
    vol -= abs((var_ec67eb1d - var_6b216c00) / var_b1dff62a);
    wait time;
    time += abs((var_f6b97b2f - var_dff37609) / var_b1dff62a);
  }
}

function function_500b7ed1(vol, pitch) {
  beat = snd::play("evt_hallway_mkultra_heartbeat");
  snd::set_volume(beat, vol);
  snd::set_pitch(beat, pitch);
  players = snd::function_da785aa8();
  player = players[0];
  var_16f8cca9 = player getlocalclientnumber();
  player playrumbleonentity(var_16f8cca9, "heartbeat_low");
}

function function_3a0734a4(heartbeat) {
  level waittill(#"mkultra_sound_off");
  function_ed62c9c2("cp_nam_prisoner_mk_ultra_inf_hallway", 1);
  snd::set_pitch(heartbeat, 0.5, 14);
  snd::stop(heartbeat, 16);
  level.var_7454541e = 0;
}

function function_bf5b08ac(var_ea09dcad, var_9e4626e9) {
  level waittill(#"stop_hallway_sfx");
  snd::stop(var_ea09dcad);
  snd::stop(var_9e4626e9);
  waitframe(1);
  self notify(#"end");
}

function function_c635eb23() {
  amb = snd::play("amb_cp_nam_pris_infinite_hallway_lp");
  snd::set_volume(amb, 0.1);
  running = 1;
  time = 10;

  while(running == 1) {
    level waittill(#"hash_df4e0488c76955a");

    if(level.var_ad3afa08 == 0) {
      snd::stop(amb, 5);
      running = 0;
    } else if(level.var_c635eb23 == 1) {
      time = 10;
      snd::set_volume(amb, 0.398, time);
    } else if(level.var_c635eb23 == 2) {
      time = 10;
      snd::set_volume(amb, 0.501, time);
    } else if(level.var_c635eb23 == 3) {
      time = 5;
      snd::set_volume(amb, 1, time);
    } else if(level.var_c635eb23 == 4) {
      time = 1;
      snd::set_volume(amb, 0.5, time);
      snd::set_pitch(amb, 3, time);
    }

    wait time;
  }

  if(isDefined(amb)) {
    snd::stop(amb, 5);
  }
}

function function_4422f3fe() {
  level.var_fac92819 = 1;
  level.var_d20c84d7 = 0.1;
  level.var_c8f7b65d = 0.25;
  level.var_db673ddc = 0.25;
  level.var_7156857d = 0;
  var_bff7ec3a = 1;
  var_8fc20bcf = 1;
  var_dcd5a5f1 = 1;
  var_5d54552c = 1;
  var_14c841f8 = 1;
  pt1 = (-1124, 10132, -1205);
  pt2 = (-1697, 10132, -1205);
  var_b153d2a1 = (-1697, 9367, -1205);
  var_563e1c77 = (-1044, 9367, -1205);
  thread function_26ec9e99(pt1, pt2, "amb_cp_nam_pris_shrinking_hall_lp_1");
  thread function_26ec9e99(pt2, var_b153d2a1, "amb_cp_nam_pris_shrinking_hall_lp_2");
  thread function_26ec9e99(var_b153d2a1, var_563e1c77, "amb_cp_nam_pris_shrinking_hall_lp_3");
  thread function_e4f511a0(pt1, pt2);
  thread function_e4f511a0(pt2, var_b153d2a1);
  thread function_e4f511a0(var_b153d2a1, var_563e1c77);
  level waittill(#"shrinking_hallway_end");
  snd::stop(level.var_2076751c, 1);
  snd::stop(level.var_f21d186a, 1);
  snd::stop(level.var_45bbce7, 1);
}

function function_26ec9e99(org_start, org_end, alias) {
  self endon(#"end");
  amb = snd::play(alias, org_start);
  var_5d54552c = 1;
  var_8f1ace57 = 1;
  players = snd::function_da785aa8();
  player = players[0];
  self thread function_8c181e90(amb);

  while(isPlayer(player)) {
    org_player = player snd::getplayervieworigin();
    org = pointonsegmentnearesttopoint(org_start, org_end, org_player);

    if(distance(org_player, org) < 50 && org != org_start && org != org_end) {
      amb.origin = org;
      speed = abs(player getspeed());

      if(level.var_dc404c80 == 0) {
        vol = mapfloat(20, 200, 0.1, 1, speed);
      } else {
        vol = 0;
      }

      pitch = mapfloat(20, 200, 0.5, 1, speed);
      var_5d54552c = snd::function_e8185c19(vol, var_5d54552c, 0.1);
      var_8f1ace57 = snd::function_e8185c19(pitch, var_8f1ace57, 0.1);

      if(level.var_dc404c80 == 0) {
        snd::set_volume(amb, var_5d54552c);
      } else {
        snd::set_volume(amb, 0, 1);
      }

      snd::set_pitch(amb, var_8f1ace57);
    }

    waitframe(1);
  }
}

function function_8c181e90(amb) {
  level waittill(#"shrinking_hallway_end");
  snd::stop(amb);
  waitframe(1);
  self notify(#"end");
}

function function_e4f511a0(org_start, org_end) {
  self endon(#"end");
  self thread function_21ca79c1();
  dist = 0;
  var_8f1ace57 = 1;
  var_5d54552c = 1;
  movement = "stopped";
  players = snd::function_da785aa8();
  player = players[0];

  while(isPlayer(player)) {
    org_player = player snd::getplayervieworigin();
    org = pointonsegmentnearesttopoint(org_start, org_end, org_player);

    if(distance(org_player, org) < 50 && org != org_start && org != org_end) {
      prev_dist = dist;
      dist = distance(org, org_start);

      if(dist > prev_dist) {
        movement = "forward";
        level.var_46b963df = "forward";
      } else if(dist < prev_dist) {
        movement = "backward";
        level.var_46b963df = "backward";
      } else {
        movement = "stopped";
      }

      if(movement != "stopped" && level.var_7156857d == 0) {
        level.var_7156857d = 1;
        thread function_c9107823();
        alias = randomintrange(1, 4);

        if(level.var_dc404c80 == 0) {
          if(movement == "forward") {
            var_1dda358a = snd::play("evt_hallway_voice_0" + alias);
          } else if(movement == "backward") {
            var_38356c94 = snd::play("evt_hallway_voice_0" + alias + "r");
          }
        }
      }

      speed = abs(player getspeed());
      pitch = mapfloat(20, 200, 0.01, 2, speed);
      vol = mapfloat(20, 200, 0.5, 1, speed);
      var_5d54552c = snd::function_e8185c19(vol, var_5d54552c, 0.1);
      var_8f1ace57 = snd::function_e8185c19(pitch, var_8f1ace57, 0.1);

      if(isDefined(var_1dda358a)) {
        snd::set_volume(var_1dda358a, var_5d54552c);
        snd::set_pitch(var_1dda358a, var_8f1ace57);
      }

      if(isDefined(var_38356c94)) {
        snd::set_volume(var_38356c94, var_5d54552c);
        snd::set_pitch(var_38356c94, var_8f1ace57);
      }

      if(level.var_7156857d == 1 && movement == "stopped") {
        if(isDefined(var_1dda358a)) {
          snd::stop(var_1dda358a);
        }

        if(isDefined(var_38356c94)) {
          snd::stop(var_38356c94);
        }

        level.var_7156857d = 0;
        level notify(#"hash_2826cb21e9ad241d");
      }
    }

    waitframe(1);
  }
}

function function_21ca79c1() {
  level waittill(#"shrinking_hallway_end");
  self notify(#"end");
}

function function_1159f83b(val) {
  scale = 1.5;
  x = 860 - 96 * scale;
  y = 540 - 112 * scale;
  var_94de442b = (0.72974, 0.72974, 0.72974);
  var_27dc744f = (1, 1, 1);
  alpha = 1;
  snd::function_669c57bc(x, y, val, var_27dc744f, alpha, scale);
}

function function_c9107823() {
  level endon(#"hash_2826cb21e9ad241d");
  wait randomfloatrange(6, 10);
  level.var_7156857d = 0;
}

function function_670b73d1() {
  loc = (-937, 10165, -1213);

  if(level.var_cf6581e7 == 0) {
    level.var_cf6581e7 = 1;
    level.var_bfcd020d = snd::play("amb_cp_nam_pris_hallway_clock_fwd_lp", loc);
    level.var_e7abcaa4 = snd::play("amb_cp_nam_pris_hallway_clock_bwd_lp", loc);
    snd::set_volume(level.var_e7abcaa4, 0);
  }

  if(isDefined(level.var_bfcd020d) && isDefined(level.var_e7abcaa4) && level.var_cf6581e7 == 1) {
    if(level.var_4b36b09 == "start") {
      snd::set_volume(level.var_bfcd020d, 1);
      snd::set_volume(level.var_e7abcaa4, 0);
      snd::set_pitch(level.var_bfcd020d, 1);
      snd::set_pitch(level.var_e7abcaa4, 1);
      return;
    }

    if(level.var_4b36b09 == "low") {
      snd::set_volume(level.var_bfcd020d, 0);
      snd::set_volume(level.var_e7abcaa4, 1);
      snd::set_pitch(level.var_bfcd020d, 1);
      snd::set_pitch(level.var_e7abcaa4, 1);
      return;
    }

    if(level.var_4b36b09 == "mid") {
      snd::set_volume(level.var_bfcd020d, 1);
      snd::set_volume(level.var_e7abcaa4, 1);
      snd::set_pitch(level.var_bfcd020d, 1.25);
      snd::set_pitch(level.var_e7abcaa4, 1.25);
      return;
    }

    if(level.var_4b36b09 == "high") {
      snd::set_volume(level.var_bfcd020d, 1);
      snd::set_volume(level.var_e7abcaa4, 1);
      snd::set_pitch(level.var_bfcd020d, 1.5);
      snd::set_pitch(level.var_e7abcaa4, 1.5);
    }
  }
}

function function_b5ac929c(entity, threshold, timeout) {
  start_point = entity.origin;
  move = 0;
  time = 0;

  while(move == 0 || time >= timeout) {
    if(abs(start_point[0] - entity.origin[0]) > threshold) {
      move = 1;
    } else if(abs(start_point[1] - entity.origin[1]) > threshold) {
      move = 1;
    } else if(abs(start_point[2] - entity.origin[2]) > threshold) {
      move = 1;
    }

    waitframe(1);
    time += 0.01;
  }

  wait 1;
}

function function_2982df9f(ent) {
  self endon(#"death");
  self endon(#"deleted");

  if(!isDefined(ent)) {
    return;
  }

  if(!isDefined(level.bunker_door)) {
    level.bunker_door = [];
  }

  if(!isinarray(level.bunker_door, ent)) {
    level.bunker_door[level.bunker_door.size] = ent;
  } else {
    return;
  }

  door = snd::play("amb_bunker_door_close_lp", [ent, "tag_origin"]);
}

function function_20018404() {
  self notify(#"end");
  self endon(#"end");
  var_5d54552c = 1;
  var_8f1ace57 = 1;
  var_cd204b54 = snd::play("amb_frozen_battle_bullet_lp", (912, 2676, -313));
  var_bb5627c0 = snd::play("amb_frozen_battle_bullet_lp", (-1205, 1987, 320));
  var_b5ac1c6c = snd::play("amb_frozen_battle_bullet_lp", (-1326, 3260, 511));
  var_6d856785 = snd::play("amb_frozen_battle_shimmer_1_lp", (-1033, 3252, 563));
  var_977ebb77 = snd::play("amb_frozen_battle_shimmer_2_lp", (-348, 2334, 287));
  var_6d4a670b = snd::play("amb_frozen_battle_shimmer_3_lp", (-1224, 2572, -180));
  var_72a32f4b = snd::play("amb_frozen_battle_soldiers_1_lp", (600, 2699, -149));
  var_c0624acc = snd::play("amb_frozen_battle_soldiers_2_lp", (78, 2668, 257));
  var_ce0c6620 = snd::play("amb_frozen_battle_soldiers_3_lp", (-1270, 3257, 550));
  var_e40557d = snd::play("amb_frozen_battle_bridge_scream_lp", (-1131, 2369, 358));
  battle = snd::play("amb_frozen_battle_lp", (-1399, 2756, 491));
  var_eb52d24e = snd::play("amb_pris_froz_battle_booms_lp", (-1399, 2756, 491));
  players = snd::function_da785aa8();
  player = players[0];
  function_30054301(battle, player, (-1399, 2756, 491), (1472, 2681, -171));
  function_30054301(var_eb52d24e, player, (-1399, 2756, 491), (1472, 2681, -171));
  self thread function_a2a0188c(var_cd204b54, var_bb5627c0, var_b5ac1c6c, var_6d856785, var_977ebb77, var_6d4a670b, var_72a32f4b, var_c0624acc, var_ce0c6620, var_e40557d, battle, var_eb52d24e);
  vol = 0;
  peak = 0;
  var_819cb54 = 0;
  var_f75de6e = 0.005;
  min_vol = 0.2;
  var_9a7e5a7e = 0.5;
  var_188f29f5 = (-1168, 2605, 362);
  var_9d2fe6d6 = (965, 2565, -226);

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];
    speed = abs(player getspeed());
    vol = mapfloat(20, 200, min_vol, 1, speed);

    if(vol > peak) {
      peak = vol;

      if(var_819cb54 == 1 && vol > var_9a7e5a7e) {
        distance1 = distance(player.origin, var_188f29f5);
        distance2 = distance(player.origin, var_9d2fe6d6);

        if(distance1 < 1500 || distance2 < 2000) {
          snd::play("amb_frozen_battle_whoosh");
          var_819cb54 = 0;
        }
      }
    } else if(peak > min_vol) {
      peak -= var_f75de6e;

      if(peak < var_9a7e5a7e && var_819cb54 == 0) {
        var_819cb54 = 1;
      }
    }

    if(vol < peak) {
      vol = peak;
    }

    var_5d54552c = snd::function_e8185c19(vol, var_5d54552c, 0.87);

    snd::set_volume(var_cd204b54, var_5d54552c);
    snd::set_volume(var_bb5627c0, var_5d54552c);
    snd::set_volume(var_b5ac1c6c, var_5d54552c);
    snd::set_volume(var_6d856785, var_5d54552c);
    snd::set_volume(var_977ebb77, var_5d54552c);
    snd::set_volume(var_6d4a670b, var_5d54552c);
    snd::set_volume(var_72a32f4b, var_5d54552c);
    snd::set_volume(var_c0624acc, var_5d54552c);
    snd::set_volume(var_ce0c6620, var_5d54552c);
    snd::set_volume(var_e40557d, var_5d54552c);
    snd::set_volume(battle, var_5d54552c);
    snd::set_volume(var_eb52d24e, var_5d54552c);
    waitframe(1);
  }
}

function function_a2a0188c(var_cd204b54, var_bb5627c0, var_b5ac1c6c, var_6d856785, var_977ebb77, var_6d4a670b, var_72a32f4b, var_c0624acc, var_ce0c6620, var_e40557d, battle, var_eb52d24e) {
  level waittill(#"hash_135069eaafe77dc0");
  snd::stop(var_cd204b54, 3);
  snd::stop(var_bb5627c0, 3);
  snd::stop(var_b5ac1c6c, 3);
  snd::stop(var_6d856785, 3);
  snd::stop(var_977ebb77, 3);
  snd::stop(var_6d4a670b, 3);
  snd::stop(var_72a32f4b, 3);
  snd::stop(var_c0624acc, 3);
  snd::stop(var_ce0c6620, 3);
  snd::stop(var_e40557d, 3);
  function_ff8cbed3(battle);
  function_ff8cbed3(var_eb52d24e);
  snd::stop(battle, 3);
  snd::stop(var_eb52d24e, 3);
  self notify(#"end");
}

function function_30054301(soundobject, player, org_start, org_end) {
  soundobject thread function_2fc1b3a7(soundobject, player, org_start, org_end);
}

function private function_2fc1b3a7(soundobject, player, org_start, org_end) {
  soundobject notify(#"hash_20f2dfe33da3f037");
  soundobject endon(#"hash_20f2dfe33da3f037");
  players = snd::function_da785aa8();
  player = players[0];
  player endon(#"death");

  while(isPlayer(player) && snd::function_a6779cbd(soundobject)) {
    org_player = player snd::getplayervieworigin();
    org = pointonsegmentnearesttopoint(org_start, org_end, org_player);
    soundobject.origin = org;
    waitframe(1);
  }
}

function function_ff8cbed3(soundobject) {
  if(!isDefined(soundobject) || function_3132f113(soundobject)) {
    return;
  }

  soundobject notify(#"hash_20f2dfe33da3f037");
}

function function_ea2f17d1(variable, value) {
  if(isDefined(variable) == 1) {
    return variable;
  }

  assert(isDefined(value) == 1);
  return value;
}

function function_e2578d0f() {
  var_2139de76 = ["<dev string:xf2>", "<dev string:x103>", "<dev string:x113>", "<dev string:x120>", "<dev string:x12d>", "<dev string:x137>", "<dev string:x144>", "<dev string:x14e>", "<dev string:xf2>"];
  group = ["<dev string:x15b>", "<dev string:x169>", "<dev string:x179>", "<dev string:x18a>", "<dev string:x196>", "<dev string:x1aa>", "<dev string:x1bb>", "<dev string:x1c8>", "<dev string:x1d4>", "<dev string:x1e1>", "<dev string:x1ec>", "<dev string:x1fb>", "<dev string:x206>", "<dev string:x214>", "<dev string:x220>", "<dev string:x22f>", "<dev string:x23c>", "<dev string:x24b>", "<dev string:x25f>", "<dev string:x275>", "<dev string:x286>", "<dev string:x29d>", "<dev string:x2ae>", "<dev string:x2bd>", "<dev string:x2ca>", "<dev string:x2d8>", "<dev string:x2e9>", "<dev string:x300>", "<dev string:x30e>"];

  while(true) {
    players = snd::function_da785aa8();
    player = players[0];

    while(player buttonPressed("<dev string:x31d>") == 0) {
      waitframe(1);
    }

    for(i = 0; i < var_2139de76.size; i++) {
      iprintlnbold("<dev string:x328>" + var_2139de76[i]);
      var_b1319b94 = snd::play([0.05, "<dev string:x331>" + var_2139de76[i], 3]);
      wait 3.5;
      iprintlnbold("<dev string:x33d>");
      iprintlnbold("<dev string:x33d>");
      snd::stop(var_b1319b94, 0.1);
      waitframe(1);
    }

    wait 0.5;

    for(i = 0; i < group.size; i++) {
      iprintlnbold("<dev string:x342>" + group[i]);
      var_b1319b94 = snd::play([0.5, "<dev string:x331>" + group[i], 3]);
      wait 3.5;
      iprintlnbold("<dev string:x33d>");
      iprintlnbold("<dev string:x33d>");
      snd::stop(var_b1319b94, 0.1);
    }
  }
}