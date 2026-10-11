/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\music_and_dialog.gsc
***********************************************/

#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\teams;
#namespace music_and_dialog;

function init() {
  init_voice();
  init_dialogue();
  init_music();
  function_6ca37af6683e78ec();
}

function init_voice() {
  if(istrue(game["isLaunchChunk"])) {
    var_ae34c52213832650 = "ustl";
  } else {
    var_ae34c52213832650 = "uktl";
  }

  if(isDefined(level.alliessquadleader)) {
    var_ae34c52213832650 = level.alliessquadleader;
  }

  var_b24c891508e7c927 = "rutl";

  if(isDefined(level.axissquadleader)) {
    var_b24c891508e7c927 = level.axissquadleader;
  }

  if(!isDefined(game["voice"])) {
    game["voice"]["allies"] = var_ae34c52213832650;
    game["voice"]["axis"] = var_b24c891508e7c927;
  }
}

function init_music() {
  if(!isDefined(game["music"])) {
    function_1d15528daa831962();
  }
}

function function_1d15528daa831962() {
  setmusicset("axis_used_nuke", "mus_fd_nuke_fired");
  setmusicset("axis_hit_by_nuke", "mus_fd_nuke_hit");
  trials_loss = ["mp_round_lose_playlist"];
  setmusicset("trials_loss", trials_loss);
  trials_win_low = ["mp_round_win_playlist"];
  setmusicset("trials_win_low", trials_win_low);
  trials_win_mid = ["mp_round_win_playlist"];
  setmusicset("trials_win_mid", trials_win_mid);
  trials_win_high = ["mp_round_win_playlist"];
  setmusicset("trials_win_high", trials_win_high);
  infected = ["infected_01", "infected_02", "infected_03", "infected_04", "infected_05"];
  setmusicset("infected", infected);
  ko_carry_music = ["mp_hp_new_playlist", "mp_hp_captured_playlist"];
  setmusicset("ko_carry_music", ko_carry_music);
  prisoner_carry_music = ["mp_prisoner_loop_1", "mp_prisoner_loop_2"];
  setmusicset("prisoner_carry_music", prisoner_carry_music);
  function_79d09d8dff37ff80();
  function_c85c8d480a1f8d97();
  function_350d33613fa93e9();
}

function function_a5e3fac0c5201a8() {
  allies_suspense = ["mx_mp_generic_suspense_1", "mx_mp_generic_suspense_2", "mx_mp_generic_suspense_3", "mx_mp_generic_suspense_4", "mx_mp_generic_suspense_5", "mx_mp_generic_suspense_6", "mx_mp_generic_suspense_7", "mx_mp_generic_suspense_8", "mx_mp_mexico_suspense_1", "mx_mp_mexico_suspense_2", "mx_mp_mexico_suspense_3", "mx_mp_mexico_suspense_4", "mx_mp_mexico_suspense_5", "mx_mp_mexico_suspense_6", "mx_mp_mexico_suspense_7", "mx_mp_mexico_suspense_8"];

  if(function_5df2f278f44a6ffd("middle_east")) {
    var_7bb0f6f911721ebc = ["mx_mp_mideast_suspense_1", "mx_mp_mideast_suspense_2", "mx_mp_mideast_suspense_3", "mx_mp_mideast_suspense_4", "mx_mp_mideast_suspense_5", "mx_mp_mideast_suspense_6", "mx_mp_mideast_suspense_7", "mx_mp_mideast_suspense_8"];
    allies_suspense = array_combine(allies_suspense, var_7bb0f6f911721ebc);
  }

  setmusicset("allies_suspense", allies_suspense);
  allies_suspense_classic = ["mx_mp_generic_suspense_1_classic", "mx_mp_generic_suspense_2_classic", "mx_mp_generic_suspense_3_classic", "mx_mp_generic_suspense_4_classic", "mx_mp_generic_suspense_5_classic", "mx_mp_generic_suspense_6_classic", "mx_mp_generic_suspense_7_classic", "mx_mp_generic_suspense_8_classic"];

  if(function_5df2f278f44a6ffd("middle_east")) {
    var_117a27f685ad48c7 = ["mx_mp_mideast_suspense_1_classic", "mx_mp_mideast_suspense_2_classic", "mx_mp_mideast_suspense_3_classic", "mx_mp_mideast_suspense_4_classic", "mx_mp_mideast_suspense_5_classic", "mx_mp_mideast_suspense_6_classic", "mx_mp_mideast_suspense_7_classic", "mx_mp_mideast_suspense_8_classic"];
    allies_suspense_classic = array_combine(allies_suspense_classic, var_117a27f685ad48c7);
  }

  if(function_5df2f278f44a6ffd("mexico")) {
    var_ba852636d22aeecd = ["mx_mp_mexico_suspense_1_classic", "mx_mp_mexico_suspense_2_classic", "mx_mp_mexico_suspense_3_classic", "mx_mp_mexico_suspense_4_classic", "mx_mp_mexico_suspense_5_classic", "mx_mp_mexico_suspense_6_classic", "mx_mp_mexico_suspense_7_classic", "mx_mp_mexico_suspense_8_classic"];
    allies_suspense_classic = array_combine(allies_suspense_classic, var_ba852636d22aeecd);
  }

  setmusicset("allies_suspense_classic", allies_suspense_classic);
  axis_suspense = ["mx_mp_generic_suspense_1", "mx_mp_generic_suspense_2", "mx_mp_generic_suspense_3", "mx_mp_generic_suspense_4", "mx_mp_generic_suspense_5", "mx_mp_generic_suspense_6", "mx_mp_generic_suspense_7", "mx_mp_generic_suspense_8", "mx_mp_mexico_suspense_1", "mx_mp_mexico_suspense_2", "mx_mp_mexico_suspense_3", "mx_mp_mexico_suspense_4", "mx_mp_mexico_suspense_5", "mx_mp_mexico_suspense_6", "mx_mp_mexico_suspense_7", "mx_mp_mexico_suspense_8"];

  if(function_5df2f278f44a6ffd("middle_east")) {
    var_8cbc4de0ff7369f1 = ["mx_mp_mideast_suspense_1", "mx_mp_mideast_suspense_2", "mx_mp_mideast_suspense_3", "mx_mp_mideast_suspense_4", "mx_mp_mideast_suspense_5", "mx_mp_mideast_suspense_6", "mx_mp_mideast_suspense_7", "mx_mp_mideast_suspense_8"];
    axis_suspense = array_combine(axis_suspense, var_8cbc4de0ff7369f1);
  }

  setmusicset("axis_suspense", axis_suspense);
  axis_suspense_classic = ["mx_mp_generic_suspense_1_classic", "mx_mp_generic_suspense_2_classic", "mx_mp_generic_suspense_3_classic", "mx_mp_generic_suspense_4_classic", "mx_mp_generic_suspense_5_classic", "mx_mp_generic_suspense_6_classic", "mx_mp_generic_suspense_7_classic", "mx_mp_generic_suspense_8_classic"];

  if(function_5df2f278f44a6ffd("middle_east")) {
    var_688a88378ff6ab1e = ["mx_mp_mideast_suspense_1_classic", "mx_mp_mideast_suspense_2_classic", "mx_mp_mideast_suspense_3_classic", "mx_mp_mideast_suspense_4_classic", "mx_mp_mideast_suspense_5_classic", "mx_mp_mideast_suspense_6_classic", "mx_mp_mideast_suspense_7_classic", "mx_mp_mideast_suspense_8_classic"];
    axis_suspense_classic = array_combine(axis_suspense_classic, var_688a88378ff6ab1e);
  }

  if(function_5df2f278f44a6ffd("mexico")) {
    var_ac960a84746d1e6e = ["mx_mp_mexico_suspense_1_classic", "mx_mp_mexico_suspense_2_classic", "mx_mp_mexico_suspense_3_classic", "mx_mp_mexico_suspense_4_classic", "mx_mp_mexico_suspense_5_classic", "mx_mp_mexico_suspense_6_classic", "mx_mp_mexico_suspense_7_classic", "mx_mp_mexico_suspense_8_classic"];
    axis_suspense_classic = array_combine(axis_suspense_classic, var_ac960a84746d1e6e);
  }

  setmusicset("axis_suspense_classic", axis_suspense_classic);
}

function function_79d09d8dff37ff80() {
  var_fdd4cb56c3b978a3 = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(!istrue(var_fdd4cb56c3b978a3)) {
    return;
  }

  br_lobby_intro = [""];
  setmusicset("br_lobby_intro", br_lobby_intro);
  br_lobby_outro = ["mx_mp_br_prelobby_outro"];
  setmusicset("br_lobby_outro", br_lobby_outro);
  br_infil_intro = ["mx_mp_br_infil_1"];
  setmusicset("br_infil_intro", br_infil_intro);
  br_plane_jump = [""];
  setmusicset("br_plane_jump", br_plane_jump);
  br_plane_jump_parachute = [""];
  setmusicset("br_plane_jump_parachute", br_plane_jump_parachute);
  br_gulag_intro = ["mx_mp_br_gulag_intro_1"];
  setmusicset("br_gulag_intro", br_gulag_intro);
  br_gulag_jailer = [""];
  setmusicset("br_gulag_jailer", br_gulag_jailer);
  br_gulag_lose = ["mx_mp_br_gulag_lose"];
  setmusicset("br_gulag_lose", br_gulag_lose);
  br_gulag_win = ["mx_mp_br_gulag_win"];
  setmusicset("br_gulag_win", br_gulag_win);
  br_ring_low = ["mx_mp_br_circle_close_low_1", "mx_mp_br_circle_close_low_2", "mx_mp_br_circle_close_low_3", "mx_mp_br_circle_close_low_4"];
  setmusicset("br_ring_low", br_ring_low);
  br_ring_med = ["mx_mp_br_circle_close_med_1", "mx_mp_br_circle_close_med_2", "mx_mp_br_circle_close_med_3", "mx_mp_br_circle_close_med_4"];
  setmusicset("br_ring_med", br_ring_med);
  br_ring_high = ["mx_mp_br_circle_close_high_1", "mx_mp_br_circle_close_high_2", "mx_mp_br_circle_close_high_3", "mx_mp_br_circle_close_high_4"];
  setmusicset("br_ring_high", br_ring_high);
  br_ring_final = ["mx_mp_br_circle_close_final_1", "mx_mp_br_circle_close_final_2"];
  setmusicset("br_ring_final", br_ring_final);
  br_exfil_intro1 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro1", br_exfil_intro1);
  br_exfil_intro2 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro2", br_exfil_intro2);
  br_exfil_intro3 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro3", br_exfil_intro3);
  br_exfil_intro4 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro4", br_exfil_intro4);
  br_exfil_intro5 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro5", br_exfil_intro5);
  br_exfil_intro6 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro6", br_exfil_intro6);
  br_exfil_intro7 = ["mx_mp_br_exfil1"];
  setmusicset("br_exfil_intro7", br_exfil_intro7);
  br_secondary_exfil = ["mx_mp_br_sv_exfil_loop"];
  setmusicset("br_secondary_exfil", br_secondary_exfil);
  br_secondary_exfil_aborted = ["mx_mp_br_sv_exfil_abort"];
  setmusicset("br_secondary_exfil_aborted", br_secondary_exfil_aborted);
  br_secondary_exfil_success = ["mx_mp_br_sv_exfil_success"];
  setmusicset("br_secondary_exfil_success", br_secondary_exfil_success);
  br_cq_element = ["mx_mp_br_cq_elementfound_1", "mx_mp_br_cq_elementfound_2", "mx_mp_br_cq_elementfound_3", "mx_mp_br_cq_elementfound_7"];
  setmusicset("br_cq_element", br_cq_element);
  br_cq_bomb_armed = ["mx_mp_br_cq_bombarmed_1", "mx_mp_br_cq_bombarmed_2", "mx_mp_br_cq_bombarmed_3", "mx_mp_br_cq_bombarmed_4", "mx_mp_br_cq_bombarmed_5"];
  setmusicset("br_cq_bomb_armed", br_cq_bomb_armed);
  br_cq_ending_flyby = ["mx_mp_br_cq_airplaneoneshot_1"];
  setmusicset("br_cq_ending_flyby", br_cq_ending_flyby);
  br_cq_exfil = ["mx_mp_br_cq_exfil_1"];
  setmusicset("br_cq_exfil", br_cq_exfil);
  plunder_tenpercent = ["br_plunder_tenpercent_1", "br_plunder_tenpercent_2"];
  setmusicset("plunder_tenpercent", plunder_tenpercent);
  plunder_thirtypercent = ["br_plunder_thirtypercent_1", "br_plunder_thirtypercent_2"];
  setmusicset("plunder_thirtypercent", plunder_thirtypercent);
  plunder_fiftypercent = ["br_plunder_fiftypercent_1", "br_plunder_fiftypercent_2", "br_plunder_fiftypercent_3"];
  setmusicset("plunder_fiftypercent", plunder_fiftypercent);
  plunder_seventyfivepercent = ["br_plunder_seventyfivepercent_1", "br_plunder_seventyfivepercent_2", "br_plunder_seventyfivepercent_3"];
  setmusicset("plunder_seventyfivepercent", plunder_seventyfivepercent);
  plunder_ninetypercent = ["br_plunder_ninetypercent_1", "br_plunder_ninetypercent_2", "br_plunder_ninetypercent_3"];
  setmusicset("plunder_ninetypercent", plunder_ninetypercent);
  plunder_bonustime_long = ["br_plunder_bonustime_long"];
  setmusicset("plunder_bonustime_long", plunder_bonustime_long);
  zc_zone_streak = ["mx_mp_br_delta_zonecontrol_loop1", "mx_mp_br_delta_zonecontrol_loop2", "mx_mp_br_delta_zonecontrol_loop3"];
  setmusicset("zc_zone_streak_main", zc_zone_streak);

  if(scripts\engine\utility::issharedfuncdefined("music_and_dialog", "init_music_br_map")) {
    [[scripts\engine\utility::getsharedfunc("music_and_dialog", "init_music_br_map")]]();
  }

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    br_lobby_intro = ["mx_mp_br_prelobby_intro"];
    setmusicset("br_lobby_intro", br_lobby_intro);
    br_lobby_outro = ["mx_mp_br_prelobby_outro"];
    setmusicset("br_lobby_outro", br_lobby_outro);
    br_infil_intro = ["mx_mp_br_infil_1"];
    setmusicset("br_infil_intro", br_infil_intro);
    br_plane_jump = ["mx_mp_br_infil_parachute_1", "mx_mp_br_infil_parachute_2", "mx_mp_br_infil_parachute_3", "mx_mp_br_infil_parachute_4"];
    setmusicset("br_plane_jump", br_plane_jump);
    br_plane_jump_parachute = [""];
    setmusicset("br_plane_jump_parachute", br_plane_jump_parachute);
    br_gulag_intro = ["mx_mp_br_gulag_intro_1", "mx_mp_br_gulag_intro_2", "mx_mp_br_gulag_intro_3"];
    setmusicset("br_gulag_intro", br_gulag_intro);
    br_gulag_jailer = ["mx_mp_br_gulag_juggernaut"];
    setmusicset("br_gulag_jailer", br_gulag_jailer);
    br_gulag_lose = ["mx_mp_br_gulag_lose"];
    setmusicset("br_gulag_lose", br_gulag_lose);
    br_gulag_win = ["mx_mp_br_gulag_win"];
    setmusicset("br_gulag_win", br_gulag_win);
    br_ring_low = ["mx_mp_br_circle_close_low_1", "mx_mp_br_circle_close_low_2", "mx_mp_br_circle_close_low_3"];
    setmusicset("br_ring_low", br_ring_low);
    br_ring_med = ["mx_mp_br_circle_close_med_1", "mx_mp_br_circle_close_med_2", "mx_mp_br_circle_close_med_3"];
    setmusicset("br_ring_med", br_ring_med);
    br_ring_high = ["mx_mp_br_circle_close_high_1", "mx_mp_br_circle_close_high_2", "mx_mp_br_circle_close_high_3"];
    setmusicset("br_ring_high", br_ring_high);
    br_ring_final = ["mx_mp_br_circle_close_final_loop_1", "mx_mp_br_circle_close_final_loop_2", "mx_mp_br_circle_close_final_loop_3"];
    setmusicset("br_ring_final", br_ring_final);
    br_exfil_intro1 = ["mx_mp_br_exfil1"];
    setmusicset("br_exfil_intro1", br_exfil_intro1);
    br_exfil_intro2 = ["mx_mp_br_exfil2"];
    setmusicset("br_exfil_intro2", br_exfil_intro2);
    br_exfil_intro3 = ["mx_mp_br_exfil3"];
    setmusicset("br_exfil_intro3", br_exfil_intro3);
    br_exfil_intro4 = ["mx_mp_br_exfil4"];
    setmusicset("br_exfil_intro4", br_exfil_intro4);
    br_exfil_intro5 = ["mx_mp_br_exfil5"];
    setmusicset("br_exfil_intro5", br_exfil_intro5);
    br_exfil_intro6 = ["mx_mp_br_exfil6"];
    setmusicset("br_exfil_intro6", br_exfil_intro6);
    br_exfil_intro7 = ["mx_mp_br_exfil7"];
    setmusicset("br_exfil_intro7", br_exfil_intro7);
  }
}

function function_c85c8d480a1f8d97() {
  var_6a1d06b01f51312e = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "dmz";

  if(!istrue(var_6a1d06b01f51312e)) {
    return;
  }

  dmz_infil = ["iw9_mp_dmz_infil1", "iw9_mp_dmz_infil2", "iw9_mp_dmz_infil3", "iw9_mp_dmz_infil4", "iw9_mp_dmz_infil5"];
  setmusicset("dmz_infil", dmz_infil);
  dmz_activity_start = ["iw9_mp_dmz_activity_start"];
  setmusicset("dmz_activity_start", dmz_activity_start);
  dmz_activity_tension = ["iw9_mp_dmz_activity_tension"];
  setmusicset("dmz_activity_tension", dmz_activity_tension);
  dmz_activity_action = ["iw9_mp_dmz_activity_action"];
  setmusicset("dmz_activity_action", dmz_activity_action);
  dmz_activity_win = ["iw9_mp_dmz_activity_won"];
  setmusicset("dmz_activity_win", dmz_activity_win);
  dmz_activity_lose = ["iw9_mp_dmz_activity_lose"];
  setmusicset("dmz_activity_lose", dmz_activity_lose);
  dmz_exfil_start = ["iw9_mp_dmz_exfil1", "iw9_mp_dmz_exfil2"];
  setmusicset("dmz_exfil_start", dmz_exfil_start);
  dmz_exfil_manual = ["iw9_mp_dmz_exfil_manual"];
  setmusicset("dmz_exfil_manual", dmz_exfil_manual);
  dmz_exfil_end = [""];
  setmusicset("dmz_exfil_end", dmz_exfil_end);
  dmz_exfil_abort = ["iw9_mp_dmz_exfil_abort"];
  setmusicset("dmz_exfil_abort", dmz_exfil_abort);
  dmz_stronghold_unlock = ["dmz_stronghold_unlock"];
  setmusicset("dmz_stronghold_unlock", dmz_stronghold_unlock);
  dmz_elimination_start = ["dmz_elimination_accept"];
  setmusicset("dmz_elimination_start", dmz_elimination_start);
  dmz_elimination_approach = ["dmz_elimination_approach"];
  setmusicset("dmz_elimination_approach", dmz_elimination_approach);
  dmz_elimination_win = ["dmz_elimination_kill"];
  setmusicset("dmz_elimination_win", dmz_elimination_win);
  dmz_geigersearch_pickups = ["dmz_geigersearch_pickups"];
  setmusicset("dmz_geigersearch_pickups", dmz_geigersearch_pickups);
  dmz_hostage_start = ["dmz_fortress_hostage_contract"];
  setmusicset("dmz_hostage_start", dmz_hostage_start);
  dmz_hostage_approach = ["dmz_fortress_hostage_approach"];
  setmusicset("dmz_hostage_approach", dmz_hostage_approach);
  dmz_hostage_breach = ["dmz_stronghold_unlock"];
  setmusicset("dmz_hostage_breach", dmz_hostage_breach);
  dmz_hostage_rescue = ["dmz_fortress_hostage_rescue"];
  setmusicset("dmz_hostage_rescue", dmz_hostage_rescue);
  dmz_hostage_rescue_failed = ["dmz_fortress_hostage_rescuefailed"];
  setmusicset("dmz_hostage_rescue_failed", dmz_hostage_rescue_failed);
  dmz_trap_start = ["dmz_trap_assigned"];
  setmusicset("dmz_trap_start", dmz_trap_start);
  dmz_trap_approach = ["dmz_trap_approach"];
  setmusicset("dmz_trap_approach", dmz_trap_approach);
  dmz_trap_drill = ["dmz_trap_drill"];
  setmusicset("dmz_trap_drill", dmz_trap_drill);
  dmz_train_safe_drill = ["mx_mp_dmz_safecracker_train_loop"];
  setmusicset("dmz_train_safe_drill", dmz_train_safe_drill);

  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker") {
    dmz_infil = ["dmz_stronghold_unlock"];
    setmusicset("dmz_infil", dmz_infil);
  }

  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    dmz_infil = ["mx_mp_dmz_s2_infil1", "mx_mp_dmz_s2_infil2"];
    setmusicset("dmz_infil", dmz_infil);
    dmz_activity_start = ["mx_mp_dmz_s2_activity_start"];
    setmusicset("dmz_activity_start", dmz_activity_start);
    dmz_activity_tension = ["mx_mp_dmz_s2_activity_tension"];
    setmusicset("dmz_activity_tension", dmz_activity_tension);
    dmz_activity_action = ["mx_mp_dmz_s2_activity_action"];
    setmusicset("dmz_activity_action", dmz_activity_action);
    dmz_activity_win = ["mx_mp_dmz_s2_activity_win"];
    setmusicset("dmz_activity_win", dmz_activity_win);
    dmz_activity_lose = ["mx_mp_dmz_s2_activity_lose"];
    setmusicset("dmz_activity_lose", dmz_activity_lose);
    dmz_exfil_start = ["mx_mp_dmz_s2_exfil1", "mx_mp_dmz_s2_exfil2"];
    setmusicset("dmz_exfil_start", dmz_exfil_start);
    dmz_stronghold_unlock = ["dmz_stronghold_unlock"];
    setmusicset("dmz_stronghold_unlock", dmz_stronghold_unlock);
    dmz_elimination_start = ["mx_mp_dmz_s2_activity_start"];
    setmusicset("dmz_elimination_start", dmz_activity_start);
    dmz_elimination_approach = ["mx_mp_dmz_s2_activity_action_loop2"];
    setmusicset("dmz_elimination_approach", dmz_elimination_approach);
    dmz_elimination_win = [""];
    setmusicset("dmz_elimination_win", dmz_elimination_win);
    dmz_geigersearch_pickups = ["mx_mp_dmz_s2_activity_pickups"];
    setmusicset("dmz_geigersearch_pickups", dmz_geigersearch_pickups);
    dmz_hostage_start = ["mx_mp_dmz_s2_activity_start"];
    setmusicset("dmz_hostage_start", dmz_hostage_start);
    dmz_hostage_approach = ["mx_mp_dmz_s2_activity_tension"];
    setmusicset("dmz_hostage_approach", dmz_hostage_approach);
    dmz_hostage_breach = ["dmz_stronghold_unlock"];
    setmusicset("dmz_hostage_breach", dmz_hostage_breach);
    dmz_hostage_rescue = ["mx_mp_dmz_s2_activity_action_loop3"];
    setmusicset("dmz_hostage_rescue", dmz_hostage_rescue);
    dmz_hostage_rescue_failed = ["mx_mp_dmz_s2_activity_lose"];
    setmusicset("dmz_hostage_rescue_failed", dmz_hostage_rescue_failed);
    dmz_trap_start = ["mx_mp_dmz_s2_activity_start"];
    setmusicset("dmz_trap_start", dmz_trap_start);
    dmz_trap_approach = ["mx_mp_dmz_s2_activity_tension"];
    setmusicset("dmz_trap_approach", dmz_trap_approach);
    dmz_trap_drill = ["mx_mp_dmz_s2_activity_action_loop2"];
    setmusicset("dmz_trap_drill", dmz_trap_drill);
  }
}

function function_350d33613fa93e9() {
  function_8b0c0a46f9743150();
}

function function_8b0c0a46f9743150() {
  br_infil_intro_classic = ["mx_mp_br_infil_1_classic"];
  setmusicset("br_infil_intro_classic", br_infil_intro_classic);
  br_gulag_lose_classic = ["mx_mp_br_gulag_lose_classic"];
  setmusicset("br_gulag_lose_classic", br_gulag_lose_classic);
  br_gulag_win_classic = ["mx_mp_br_gulag_win_classic"];
  setmusicset("br_gulag_win_classic", br_gulag_win_classic);
  br_ring_low_classic = ["mx_mp_br_circle_close_low_1_classic", "mx_mp_br_circle_close_low_2_classic"];
  setmusicset("br_ring_low_classic", br_ring_low_classic);
  br_ring_med_classic = ["mx_mp_br_circle_close_med_1_classic", "mx_mp_br_circle_close_med_2_classic"];
  setmusicset("br_ring_med_classic", br_ring_med_classic);
  br_ring_high_classic = ["mx_mp_br_circle_close_high_1_classic", "mx_mp_br_circle_close_high_2_classic"];
  setmusicset("br_ring_high_classic", br_ring_high_classic);
  br_ring_final_classic = ["mx_mp_br_circle_close_final_loop_1_classic", "mx_mp_br_circle_close_final_loop_2_classic"];
  setmusicset("br_ring_final_classic", br_ring_final_classic);
  br_exfil_intro1_classic = ["mx_mp_br_exfil1_classic"];
  setmusicset("br_exfil_intro1_classic", br_exfil_intro1_classic);
  br_exfil_intro2_classic = ["mx_mp_br_exfil2_classic"];
  setmusicset("br_exfil_intro2_classic", br_exfil_intro2_classic);
  br_exfil_intro3_classic = ["mx_mp_br_exfil3_classic"];
  setmusicset("br_exfil_intro3_classic", br_exfil_intro3_classic);
  br_exfil_intro4_classic = ["mx_mp_br_exfil4_classic"];
  setmusicset("br_exfil_intro4_classic", br_exfil_intro4_classic);
  br_exfil_intro5_classic = ["mx_mp_br_exfil5_classic"];
  setmusicset("br_exfil_intro5_classic", br_exfil_intro5_classic);
  br_exfil_intro6_classic = ["mx_mp_br_exfil6_classic"];
  setmusicset("br_exfil_intro6_classic", br_exfil_intro6_classic);
  br_exfil_intro7_classic = ["mx_mp_br_exfil6_classic"];
  setmusicset("br_exfil_intro7_classic", br_exfil_intro7_classic);
  br_cq_element_classic = ["mx_mp_br_cq_elementfound_1_classic", "mx_mp_br_cq_elementfound_2_classic", "mx_mp_br_cq_elementfound_3_classic"];
  setmusicset("br_cq_element_classic", br_cq_element_classic);
  br_cq_bomb_armed_classic = ["mx_mp_br_cq_bombarmed_1_classic"];
  setmusicset("br_cq_bomb_armed_classic", br_cq_bomb_armed_classic);
  dmz_infil_classic = ["iw9_mp_dmz_infil1_classic", "iw9_mp_dmz_infil2_classic", "iw9_mp_dmz_infil3_classic", "iw9_mp_dmz_infil4_classic", "iw9_mp_dmz_infil5_classic"];
  setmusicset("dmz_infil_classic", dmz_infil_classic);
  dmz_activity_start_classic = ["iw9_mp_dmz_activity_start_classic"];
  setmusicset("dmz_activity_start_classic", dmz_activity_start_classic);
  dmz_activity_tension_classic = ["iw9_mp_dmz_activity_tension_classic"];
  setmusicset("dmz_activity_tension_classic", dmz_activity_tension_classic);
  dmz_activity_action_classic = ["iw9_mp_dmz_activity_action_classic"];
  setmusicset("dmz_activity_action_classic", dmz_activity_action_classic);
  dmz_activity_win_classic = ["iw9_mp_dmz_activity_won_classic"];
  setmusicset("dmz_activity_win_classic", dmz_activity_win_classic);
  dmz_activity_lose_classic = ["iw9_mp_dmz_activity_lose_classic"];
  setmusicset("dmz_activity_lose_classic", dmz_activity_lose_classic);
  dmz_exfil_start_classic = ["iw9_mp_dmz_exfil1_classic", "iw9_mp_dmz_exfil2_classic"];
  setmusicset("dmz_exfil_start_classic", dmz_exfil_start_classic);
  dmz_stronghold_unlock_classic = ["dmz_stronghold_unlock_classic"];
  setmusicset("dmz_stronghold_unlock_classic", dmz_stronghold_unlock_classic);
  dmz_elimination_start_classic = ["dmz_elimination_accept_classic"];
  setmusicset("dmz_elimination_start_classic", dmz_elimination_start_classic);
  dmz_elimination_approach_classic = ["dmz_elimination_approach_classic"];
  setmusicset("dmz_elimination_approach_classic", dmz_elimination_approach_classic);
  dmz_elimination_win_classic = ["dmz_elimination_kill_classic"];
  setmusicset("dmz_elimination_win_classic", dmz_elimination_win_classic);
  dmz_geigersearch_pickups_classic = ["dmz_geigersearch_pickups_classic"];
  setmusicset("dmz_geigersearch_pickups_classic", dmz_geigersearch_pickups_classic);
  dmz_hostage_start_classic = ["dmz_fortress_hostage_contract_classic"];
  setmusicset("dmz_hostage_start_classic", dmz_hostage_start_classic);
  dmz_hostage_approach_classic = ["dmz_fortress_hostage_approach_classic"];
  setmusicset("dmz_hostage_approach_classic", dmz_hostage_approach_classic);
  dmz_hostage_breach_classic = ["dmz_stronghold_unlock_classic"];
  setmusicset("dmz_hostage_breach_classic", dmz_hostage_breach_classic);
  dmz_hostage_rescue_classic = ["dmz_fortress_hostage_rescue_classic"];
  setmusicset("dmz_hostage_rescue_classic", dmz_hostage_rescue_classic);
  dmz_hostage_rescue_failed_classic = ["dmz_fortress_hostage_rescuefailed_classic"];
  setmusicset("dmz_hostage_rescue_failed_classic", dmz_hostage_rescue_failed_classic);
  dmz_trap_start_classic = ["dmz_trap_assigned_classic"];
  setmusicset("dmz_trap_start_classic", dmz_trap_start_classic);
  dmz_trap_approach_classic = ["dmz_trap_approach_classic"];
  setmusicset("dmz_trap_approach_classic", dmz_trap_approach_classic);
  dmz_trap_drill_classic = ["dmz_trap_drill_classic"];
  setmusicset("dmz_trap_drill_classic", dmz_trap_drill_classic);
  dmz_train_safe_drill_classic = ["mx_mp_dmz_safecracker_train_loop"];
  setmusicset("dmz_train_safe_drill_classic", dmz_train_safe_drill_classic);
  var_9be07d4da97c507b = ["zc_points_streak_classic"];
  setmusicset("zc_zone_streak_main_classic", var_9be07d4da97c507b);
}

function function_a7859595cdf7077() {
  self endon("disconnect");

  if(!istrue(level.gametype == "br")) {
    self.var_dacd6424f90c605d = [];
    thread function_42b070fb8d72b5f8();
  }
}

function function_42b070fb8d72b5f8() {
  if(getgametype() == "high") {
    function_414b65c7174581d1("mp_mode_get_high", "allies");
    function_414b65c7174581d1("mp_mode_get_high", "axis");
    return;
  }

  if(self.musicpack != 1 && getdvarint(@ "current_season") > 4) {
    if(getdvarint(@ "current_season") == 5) {
      function_414b65c7174581d1("mp_season05", "allies");
      function_414b65c7174581d1("mp_season05", "axis");

      if(getgametype() == "xfire" || getgametype() == "warrior") {
        function_414b65c7174581d1("mp_season05", "team_three");
      }
    } else if(getdvarint(@ "current_season") == 6 && getdvarfloat(@ "hash_c804bf7eae3d0887") != 6.5) {
      function_414b65c7174581d1("mp_season06", "allies");
      function_414b65c7174581d1("mp_season06", "axis");

      if(getgametype() == "xfire" || getgametype() == "warrior") {
        function_414b65c7174581d1("mp_season06", "team_three");
      }
    } else {
      alliesfaction = scripts\mp\utility\teams::getteamvoiceinfix("allies");
      axisfaction = scripts\mp\utility\teams::getteamvoiceinfix("axis");

      if(getgametype() == "xfire" || getgametype() == "warrior") {
        var_ec40686507c21b1d = scripts\mp\utility\teams::getteamvoiceinfix("team_three");
        function_e910cd87d53c8a51(alliesfaction, "allies");
        function_e910cd87d53c8a51(axisfaction, "axis");
        function_e910cd87d53c8a51(var_ec40686507c21b1d, "team_three");
      } else if(getgametype() == "koth_horde") {
        function_414b65c7174581d1("mp_mode_hordepoint", "allies");
        function_414b65c7174581d1("mp_mode_hordepoint", "axis");
      } else {
        function_e910cd87d53c8a51(alliesfaction, "allies");
        function_e910cd87d53c8a51(axisfaction, "axis");
      }
    }

    return;
  }

  alliesfaction = scripts\mp\utility\teams::getteamvoiceinfix("allies");
  axisfaction = scripts\mp\utility\teams::getteamvoiceinfix("axis");

  if(getgametype() == "xfire" || getgametype() == "warrior") {
    var_ec40686507c21b1d = scripts\mp\utility\teams::getteamvoiceinfix("team_three");
    function_e910cd87d53c8a51(alliesfaction, "allies");
    function_e910cd87d53c8a51(axisfaction, "axis");
    function_e910cd87d53c8a51(var_ec40686507c21b1d, "team_three");
    return;
  }

  if(getgametype() == "koth_horde") {
    function_414b65c7174581d1("mp_mode_hordepoint", "allies");
    function_414b65c7174581d1("mp_mode_hordepoint", "axis");
    return;
  }

  function_e910cd87d53c8a51(alliesfaction, "allies");
  function_e910cd87d53c8a51(axisfaction, "axis");
}

function function_e910cd87d53c8a51(factionname, teamname) {
  if(self.musicpack == 1) {
    switch (factionname) {
      case #"hash_af17f86d59bb3d35":
        function_414b65c7174581d1("mp_faction_tf141_classic", teamname);
        break;
      case #"hash_20abb6900079e8a3":
        function_414b65c7174581d1("mp_faction_rangers_classic", teamname);
        break;
      case #"hash_b4f27b89f5a78a00":
        function_414b65c7174581d1("mp_faction_navyseals_classic", teamname);
        break;
      case #"hash_d73ed93ff1b09b71":
        function_414b65c7174581d1("mp_faction_opfor_classic", teamname);
        break;
      case #"hash_521188a1f4fac07":
        function_414b65c7174581d1("mp_faction_spetsnaz_classic", teamname);
        break;
      case #"hash_bfb1c034c59a88dc":
        function_414b65c7174581d1("mp_faction_militia_classic", teamname);
        break;
      default:
        function_414b65c7174581d1("mp_default", teamname);
        break;
    }

    return;
  }

  switch (factionname) {
    case #"hash_af17f86d59bb3d35":
      function_414b65c7174581d1("mp_faction_tf141", teamname);
      break;
    case #"hash_20abb6900079e8a3":
      function_414b65c7174581d1("mp_faction_rangers", teamname);
      break;
    case #"hash_b4f27b89f5a78a00":
      function_414b65c7174581d1("mp_faction_navyseals", teamname);
      break;
    case #"hash_d73ed93ff1b09b71":
      function_414b65c7174581d1("mp_faction_opfor", teamname);
      break;
    case #"hash_521188a1f4fac07":
      function_414b65c7174581d1("mp_faction_spetsnaz", teamname);
      break;
    case #"hash_bfb1c034c59a88dc":
      function_414b65c7174581d1("mp_faction_militia", teamname);
      break;
    default:
      function_414b65c7174581d1("mp_default", teamname);
      break;
  }
}

function function_414b65c7174581d1(var_8e6988e5e46aad6e, teamname, var_94297cc109e4d6a5) {
  if(isDefined(getscriptbundle("musicbank:" + var_8e6988e5e46aad6e))) {
    if(isDefined(teamname)) {
      self.var_dacd6424f90c605d["musicbank_" + teamname] = var_8e6988e5e46aad6e;
      function_ad9f5152bfdebcfe("musicbank", var_8e6988e5e46aad6e, getscriptbundle("musicbank:" + var_8e6988e5e46aad6e));
    } else {
      self.var_dacd6424f90c605d["musicbank"] = var_8e6988e5e46aad6e;
      function_ad9f5152bfdebcfe("musicbank", var_8e6988e5e46aad6e, getscriptbundle("musicbank:" + var_8e6988e5e46aad6e));
    }

    return;
  }

  self.var_dacd6424f90c605d["musicbank"] = var_8e6988e5e46aad6e;
  function_ad9f5152bfdebcfe("musicbank", var_8e6988e5e46aad6e, getscriptbundle("musicbank:" + var_8e6988e5e46aad6e));
}

function function_cd6fa41e597b8df0(var_83adde1ef76f568a) {
  if(istrue(level.gametype == "br")) {
    return;
  }

  musicevent = function_291ab2db66d6ea2e(var_83adde1ef76f568a);

  if(isDefined(musicevent)) {
    musicstate = utility::array_random(musicevent.musicstates);
    self setplayermusicstate(musicstate.statename);
  }
}

function function_291ab2db66d6ea2e(var_83adde1ef76f568a) {
  if(!isDefined(var_83adde1ef76f568a) || var_83adde1ef76f568a == "") {
    return undefined;
  }

  if(isDefined(self.team) && self.team == "allies") {
    musicbank = audio_utility::function_9a0f23d8adcd6392("musicbank", self.var_dacd6424f90c605d["musicbank_allies"]);
  } else if(isDefined(self.team) && self.team == "axis") {
    musicbank = audio_utility::function_9a0f23d8adcd6392("musicbank", self.var_dacd6424f90c605d["musicbank_axis"]);
  } else if(isDefined(self.team) && self.team == "team_three") {
    musicbank = audio_utility::function_9a0f23d8adcd6392("musicbank", self.var_dacd6424f90c605d["musicbank_team_three"]);
  } else {
    return;
  }

  if(!isDefined(musicbank)) {
    return;
  }

  foreach(event in musicbank.musicevent) {
    if(event.eventid == var_83adde1ef76f568a) {
      return event;
    }
  }
}

function init_dialogue() {
  if(!isDefined(game["dialogue"])) {
    game["dialogue"]["axis_male_cough"] = [];
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_1";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_2";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_3";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_4";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_5";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_6";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_7";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_8";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_1";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_2";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_3";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_4";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_5";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_6";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_7";
    game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_8";
    game["dialogue"]["axis_female_cough"] = [];
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_1";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_2";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_3";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_4";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_5";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_6";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_7";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_8";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_1";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_2";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_3";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_4";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_5";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_6";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_7";
    game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_8";
    game["dialogue"]["allies_male_cough"] = [];
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_1";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_2";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_3";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_4";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_5";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_6";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_7";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_8";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_1";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_2";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_3";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_4";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_5";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_6";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_7";
    game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_8";
    game["dialogue"]["allies_female_cough"] = [];
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_1";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_2";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_3";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_4";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_5";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_6";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_7";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_8";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_1";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_2";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_3";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_4";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_5";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_6";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_7";
    game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_8";
    game["dialog"]["timesup"] = "dx_mp_gmst_anno_uktl_gsta";
    game["dialog"]["timesup_sixty"] = "dx_mp_gmst_anno_uktl_gstd";
    game["dialog"]["timesup_thirty"] = "dx_mp_gmst_anno_uktl_gstc";
    game["dialog"]["timesup_ten"] = "dx_mp_gmst_anno_uktl_gstb";
    game["dialog"]["winning"] = "dx_mp_gmst_anno_uktl_gswa";
    game["dialog"]["winning_time"] = "dx_mp_gmst_anno_uktl_gswb";
    game["dialog"]["winning_score"] = "dx_mp_gmst_anno_uktl_gswc";
    game["dialog"]["winning_comeback"] = "dx_mp_gmst_anno_uktl_gswd";
    game["dialog"]["losing"] = "dx_mp_gmst_anno_uktl_gsla";
    game["dialog"]["losing_time"] = "dx_mp_gmst_anno_uktl_gslb";
    game["dialog"]["losing_score"] = "dx_mp_gmst_anno_uktl_gslc";
    game["dialog"]["lead_lost"] = "dx_mp_gmst_anno_uktl_gsld";
    game["dialog"]["lead_tied"] = "dx_mp_gmst_anno_uktl_gslf";
    game["dialog"]["lead_taken"] = "dx_mp_gmst_anno_uktl_gsle";
    game["dialog"]["halftime"] = "dx_mp_gmst_anno_uktl_gsht";
    game["dialog"]["overtime"] = "dx_mp_gmst_anno_uktl_gsot";
    game["dialog"]["side_switch"] = "dx_mp_gmst_anno_uktl_gsss";
    game["dialog"]["last_alive"] = "dx_mp_gmst_anno_uktl_gslr";

    if(!isDefined(game["dialog"]["halfway_enemy_score"])) {
      game["dialog"]["halfway_enemy_score"] = "dx_mp_gmst_anno_uktl_gshd";
    }

    if(!isDefined(game["dialog"]["halfway_enemy_time"])) {
      game["dialog"]["halfway_enemy_time"] = "dx_mp_gmst_anno_uktl_gshc";
    }

    if(!isDefined(game["dialog"]["halfway_friendly_score"])) {
      game["dialog"]["halfway_friendly_score"] = "dx_mp_gmst_anno_uktl_gshb";
    }

    if(!isDefined(game["dialog"]["halfway_friendly_time"])) {
      game["dialog"]["halfway_friendly_time"] = "dx_mp_gmst_anno_uktl_gsha";
    }

    if(!isDefined(game["dialog"]["boost"])) {
      game["dialog"]["boost"] = "dx_mp_gmst_anno_uktl_gsbo";
    }

    if(!isDefined(game["dialog"]["offense_obj"])) {
      game["dialog"]["offense_obj"] = "dx_mp_gmst_anno_uktl_gsbo";
    }

    if(!isDefined(game["dialog"]["defense_obj"])) {
      game["dialog"]["defense_obj"] = "dx_mp_gmst_anno_uktl_gsbo";
    }

    game["dialog"]["obj_defend"] = "dx_mp_gmst_anno_uktl_gsoa";
    game["dialog"]["objs_defend"] = "dx_mp_gmst_anno_uktl_gsob";
    game["dialog"]["obj_destroy"] = "dx_mp_gmst_anno_uktl_gsoc";
    game["dialog"]["objs_destroy"] = "dx_mp_gmst_anno_uktl_gsod";
    game["dialog"]["obj_capture"] = "dx_mp_gmst_anno_uktl_gsoe";
    game["dialog"]["objs_capture"] = "dx_mp_gmst_anno_uktl_gsof";
    game["dialog"]["captured_all_enemy"] = "dx_mp_gmst_anno_uktl_gsce";
    game["dialog"]["captured_all_friendly"] = "dx_mp_gmst_anno_uktl_gscf";
    game["dialog"]["ti_destroyed"] = "dx_mp_gmst_anno_uktl_gsti";
    game["dialog"]["revived"] = "dx_mp_gmst_anno_uktl_gsrv";
  }

  game["dialog"]["mission_success"] = "dx_mp_gmst_anno_uktl_gsms";
  game["dialog"]["mission_failure"] = "dx_mp_gmst_anno_uktl_gsmf";
  game["dialog"]["mission_draw"] = "dx_mp_gmst_anno_uktl_gsmt";
  game["dialog"]["round_success"] = "dx_mp_gmst_anno_uktl_gsrs";
  game["dialog"]["round_failure"] = "dx_mp_gmst_anno_uktl_gsrf";
  game["dialog"]["round_draw"] = "dx_mp_gmst_anno_uktl_gsrt";
}

function function_6ca37af6683e78ec() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level thread onplayerconnect();
  level thread onlastalive();
  level thread musiccontroller();
  level thread ongameended();
  level thread onroundswitch();

  if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "gwai") {
    setDvar(@ "hash_58a078a367c02ab3", 1);
    setDvar(@ "hash_c5d765aefb9658bd", 1500);
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    musicpack = player getplayerdata("common", "commonCustomization", "musicbox");
    player.musicpack = musicpack;

    if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "dmz") {
      player thread function_8ffc5ac70256254b();
    }

    player thread function_a7859595cdf7077();
    player thread playflyoveraudioline();
    player thread watchhostmigration();
    player.needtoplayintro = 1;
  }
}

function onplayerspawned() {
  setdvarifuninitialized(@ "hash_61e9133b2e499a6c", 0);

  if(isai(self)) {
    return;
  }

  if(istrue(self.needtoplayintro)) {
    thread dointro();
    self.needtoplayintro = undefined;
  }

  if(getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk" || getgametype() == "gwbomb" || getgametype() == "gwtdm" || isgroundwarcoremode()) {
    self setsoundsubmix("iw9_mp_groundwar_focus");
  } else if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self setsoundsubmix("wz_br_focus");
  } else if(getgametype() == "ballmode") {
    self setsoundsubmix("iw9_mp_soccer");
  } else {
    self setsoundsubmix("iw9_mp_core_focus");
  }

  if(getsubgametype() == "dmz" && scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    self setsoundsubmix("iw9_mp_sealion_dmz");
  }
}

function function_8ffc5ac70256254b() {
  self endon("disconnect");
  var_6a1d06b01f51312e = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "dmz";
  var_cdee7f83a96700f2 = getdvarint(@ "hash_9c43b60485fbd92e", 0) == 0;

  if(!istrue(var_6a1d06b01f51312e)) {
    return;
  }

  if(getdvarint(@ "hash_61e9133b2e499a6c")) {
    dmz_infil_classic = function_17ee301cf0b5ba85("dmz_infil_classic");
    self setplayermusicstate(dmz_infil_classic);
  } else {
    dmz_infil = function_17ee301cf0b5ba85("dmz_infil");
    self setplayermusicstate(dmz_infil);
  }

  if(istrue(var_cdee7f83a96700f2)) {
    self setsoundsubmix("solo_cin_igc_music", 0);

    while(!scripts\mp\flags::gameflag("prematch_done")) {
      if(istrue(level.infilcompleted) || isnumber(level.matchcountdowntime) && level.matchcountdowntime <= 3) {
        break;
      }

      waitframe();
    }

    waitframe();
    self clearsoundsubmix("solo_cin_igc_music", 2);
  }

  if(isDefined(level.prematchperiod)) {
    while(!scripts\mp\flags::gameflag("prematch_done")) {
      waitframe();
    }
  }

  waittillframeend();
  self setplayermusicstate("");
}

function waitcountdown() {
  level endon("host_migration_begin");
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      self notify("luinotifyserver", "matchReady");
      return;
    }

    wait 1;
  }
}

function playflyoveraudioline() {
  level endon("host_migration_begin");
  self endon("disconnect");
  normalizedtimepassed = gettimepassed() / 1000 + 6;

  if(normalizedtimepassed >= level.prematchperiod) {
    return;
  }

  if(!level.rankedmatch) {
    return;
  }

  if(!rankingenabled()) {
    return;
  }

  teamid = 0;

  if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
    if(self.sessionteam == "allies") {
      switch (teamid) {
        case 0:
          self playannouncersound("jtfw_mtc1_un_flyover");
          break;
        case 1:
          self playannouncersound("oi_mtc3_un_flyover");
          break;
        case 2:
          self playannouncersound("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self playannouncersound("wr_mtc5_un_flyover");
          break;
        case 4:
          self playannouncersound("ba_mtc2_un_flyover");
          break;
        default:
          break;
      }

      return;
    }

    if(self.sessionteam == "axis") {
      switch (teamid) {
        case 0:
          self playannouncersound("jtfw_mtc1_sdf_flyover");
          break;
        case 1:
          self playannouncersound("oi_mtc3_sdf_flyover");
          break;
        case 2:
          self playannouncersound("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self playannouncersound("wr_mtc5_sdf_flyover");
          break;
        case 4:
          self playannouncersound("ba_mtc2_sdf_flyover");
          break;
        default:
          break;
      }
    }
  }
}

function dointro() {
  level endon("game_ended");
  level endon("host_migration_begin");
  self endon("disconnect");

  while(level.ingraceperiod > 15) {
    waitframe();
  }

  if(!isDefined(level.infilvotiming) && teamhasinfil(self.team) && game["roundsPlayed"] == 0) {
    level.infilvotiming = 1;
  }

  if(isDefined(game["trial"]) && isDefined(game["trial"]["tries_remaining"]) && game["trial"]["tries_remaining"] < 3) {
    return;
  }

  if(level.script == "mp_m_speed") {
    waiting = 0;
  } else {
    waiting = !scripts\mp\flags::gameflag("prematch_done") && (!isroundbased() || isfirstround());
  }

  if(getgametype() == "ctf") {
    thread prematch_music();
  }

  if(waiting) {
    thread waitcountdown();
    thread prematch_music();
    self setsoundsubmix("iw9_mp_core_prematch");

    for(;;) {
      self waittill("luinotifyserver", result, value);

      if(result == "matchReady") {
        break;
      }
    }
  }

  self clearsoundsubmix("iw9_mp_core_prematch", 2);

  if(istrue(level.infilvotiming)) {
    scripts\mp\flags::gameflagwait("prematch_done");
    wait 1.5;
  }

  if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
    if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies") {
      leaderdialogonplayer("allies_gametype");
    } else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis") {
      leaderdialogonplayer("axis_gametype");
    } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      var_ffa7278c9feebdf2 = 1;

      if(getgametype() == "arena") {
        if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
          var_ffa7278c9feebdf2 = 1;
        } else if(shouldplayarenaintro() || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] % 2 == 0) {
          var_ffa7278c9feebdf2 = 0;

          if(game["matchPoint"] != 1 && game["finalRound"] != 1) {
            if(game["roundsPlayed"] % 6 == 0) {
              game["dialog"]["offense_obj"] = "boost_genericround";
              game["dialog"]["defense_obj"] = "boost_genericround";
            }
          }

          if(self.team == game["attackers"]) {
            if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
              leaderdialogonplayer("offense_obj", "introboost");
            }
          } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
            leaderdialogonplayer("defense_obj", "introboost");
          }
        } else {
          var_ffa7278c9feebdf2 = 0;
        }
      }

      if(var_ffa7278c9feebdf2) {
        leaderdialogonplayer("gametype", "gametype");
      }
    }
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  waitframe();

  if(istrue(level.var_aaee655630513b9d)) {
    wait 3.5;
  }

  if(getdvarint(@ "hash_ae1f081d4f476460", 1)) {
    waitframe();
  }

  if(getgametype() == "arena") {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      if(self.team == game["attackers"]) {
        if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
          leaderdialogonplayer("offense_obj", "introboost");
        }
      } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        leaderdialogonplayer("defense_obj", "introboost");
      }
    }

    return;
  }

  if(getgametype() == "escort") {
    if(self.team == game["attackers"]) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        leaderdialogonplayer("match_start_attacker", "introboost");
      }
    } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      leaderdialogonplayer("match_start_defender", "introboost");
    }

    return;
  }

  if(self.team == game["attackers"]) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      leaderdialogonplayer("offense_obj", "introboost");
    }

    return;
  }

  if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
    leaderdialogonplayer("defense_obj", "introboost");
  }
}

function function_3aa69e0e6827ce5(var_167b74d4ec89f276) {
  self endon("disconnect");

  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(var_167b74d4ec89f276)) {
    self.submix = var_167b74d4ec89f276;
  } else {
    var_a72551ff1c8f8278 = [];
    var_a72551ff1c8f8278[var_a72551ff1c8f8278.size] = "mp_infil_mix_musicheavy";
    var_a72551ff1c8f8278[var_a72551ff1c8f8278.size] = "mp_infil_mix_normal";
    var_2ab153106ab328f7 = var_a72551ff1c8f8278.size;
    var_d019be313dba7991 = randomint(var_2ab153106ab328f7);
    self.submix = var_a72551ff1c8f8278[var_d019be313dba7991];
  }

  if(isDefined(self.team) && self.team != "spectator") {
    thread function_cd6fa41e597b8df0("mp_infil");
    self.playedinfilmusic = 1;
    wait 15;

    if(isent(self) && isPlayer(self)) {
      self clearclienttriggeraudiozone(3);
      return;
    }

    return;
  }
}

function prematch_music() {
  self endon("disconnect");

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  level waittill("prematch_music");

  if(!level.splitscreen && !isDefined(self.playedinfilmusic) || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      if(isDefined(self.team) && self.team != "spectator" && getgametype() != "arm" && getgametype() != "conflict" && !isroundbased()) {
        mapname = getDvar(@ "g_mapname");

        if(mapname == "mp_gunsmith_gl") {
          self setplayermusicstate("");
        } else if(getgametype() == "training_course") {
          level waittill("prematch_over");

          if(self.team == "allies") {
            if(ismusicenabled()) {
              thread function_cd6fa41e597b8df0("mp_prematch");
            }

            self.nosuspensemusic = 1;
          } else {
            if(ismusicenabled()) {
              thread function_cd6fa41e597b8df0("mp_prematch");
            }

            self.nosuspensemusic = 1;
          }
        } else if(getgametype() == "ballmode") {
          if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
            if(self.team == "allies") {
              if(ismusicenabled()) {
                thread function_cd6fa41e597b8df0("mp_prematch");
              }

              self.nosuspensemusic = 1;
            } else {
              if(ismusicenabled()) {
                thread function_cd6fa41e597b8df0("mp_prematch");
              }

              self.nosuspensemusic = 1;
            }
          }
        } else if(self.team == "allies") {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }

          self.nosuspensemusic = 1;
        } else {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }

          self.nosuspensemusic = 1;
        }
      }

      if(isroundbased() && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        if(self.team == "allies") {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }

          self.nosuspensemusic = 1;
        } else {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }

          self.nosuspensemusic = 1;
        }
      }

      if(getgametype() == "ctf" && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] != 0) {
        if(self.team == "allies") {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }
        } else if(ismusicenabled()) {
          thread function_cd6fa41e597b8df0("mp_prematch");
        }
      }

      if((getgametype() == "arm" || getgametype() == "conflict") && !isDefined(level.playedstartingmusic)) {
        if(self.team == "allies") {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }

          self.nosuspensemusic = 1;
        } else {
          if(ismusicenabled()) {
            thread function_cd6fa41e597b8df0("mp_prematch");
          }

          self.nosuspensemusic = 1;
        }
      }

      if(getgametype() == "arena" && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        thread function_cd6fa41e597b8df0("mp_prematch_gunfight");
      }

      if(getgametype() == "xfire" && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        thread function_cd6fa41e597b8df0("mp_prematch_gunfight");
      }
    }

    if(level.splitscreen) {
      level.playedstartingmusic = 1;
    }

    thread suspensemusic_reset(20);
  }
}

function shouldplayarenaintro() {
  if(iswinbytworulegametype()) {
    return false;
  }

  if(game["finalRound"] == 1) {
    game["dialog"]["offense_obj"] = "boost_tied_matchpoint";
    game["dialog"]["defense_obj"] = "boost_tied_matchpoint";
    return true;
  } else if(game["matchPoint"] == 1) {
    var_10ba24a48f1b3f6d = "";

    foreach(entry in level.teamnamelist) {
      roundswon = getroundswon(entry);

      if(roundswon == level.winlimit - 1) {
        var_10ba24a48f1b3f6d = entry;
        break;
      }
    }

    if(game["attackers"] == var_10ba24a48f1b3f6d) {
      game["dialog"]["offense_obj"] = "boost_winning_matchpoint";
      game["dialog"]["defense_obj"] = "boost_losing_matchpoint";
    } else {
      game["dialog"]["offense_obj"] = "boost_losing_matchpoint";
      game["dialog"]["defense_obj"] = "boost_winning_matchpoint";
    }

    return true;
  }

  return false;
}

function watchhostmigration() {
  self endon("disconnect");
  level endon("grace_period_ending");

  while(true) {
    level waittill("host_migration_begin");
    var_70fb9c790a2bb63d = level.ingraceperiod;
    level waittill("host_migration_end");

    if(var_70fb9c790a2bb63d) {
      thread dointro();
    }
  }
}

function onlastalive() {
  level endon("game_ended");
  level waittill("last_alive", player);

  if(!isalive(player)) {
    return;
  }

  if(getgametype() == "siege") {
    player leaderdialogonplayer("siege_lastalive_zones");
    level thread onlastalive();
    return;
  } else if(getgametype() == "sr" && !level.nofriendlytags) {
    player leaderdialogonplayer("lastalive_revive");
    level thread onlastalive();
    return;
  }

  if(!scripts\cp_mp\overlord::playevent("player_last_man_standing", player)) {
    player leaderdialogonplayer("last_alive");
  }
}

function onroundswitch() {
  level waittill("round_switch", switchtype);

  switch (switchtype) {
    case #"hash_f7af050de10a5685":
      foreach(player in level.players) {
        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }

        player leaderdialogonplayer("halftime");
      }

      break;
    case #"hash_4a79ea9678ed059e":
      foreach(player in level.players) {
        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }

        player leaderdialogonplayer("overtime");
      }

      break;
    default:
      if(istrue(level.switchedsides)) {
        foreach(player in level.players) {
          if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
            continue;
          }

          player leaderdialogonplayer("side_switch");
        }

        break;
      }

      break;
  }
}

function plunder_endgame_music() {
  if(isDefined(level.endmusicplayed)) {
    return;
  }

  game["music"]["payback_lose"] = [];
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_lose_1";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_draw_1";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_lose_2";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mp_draw_1";
  game["music"]["payback_win"] = [];
  game["music"]["payback_win"][game["music"]["payback_win"].size] = "mp_win_1";
  game["music"]["payback_win"][game["music"]["payback_win"].size] = "mp_win_2";
  placements = scripts\mp\gamescore::getteamscoreplacements();
  level.endmusicplayed = 1;

  foreach(player in level.players) {
    placement = placements[player.team];

    if(placement <= 10) {
      payback_win = function_17ee301cf0b5ba85("payback_win");
      player setplayermusicstate(payback_win);
    } else {
      payback_lose = function_17ee301cf0b5ba85("payback_lose");
      player setplayermusicstate(payback_lose);
    }

    player setsoundsubmix("mp_matchend_music", 2);
    player enableplayerbreathsystem(0);
  }
}

function dmz_activity_start(players) {
  dmz_activity_start = function_17ee301cf0b5ba85("dmz_activity_start");
  dmz_activity_start_classic = function_17ee301cf0b5ba85("dmz_activity_start_classic");
  function_fe75a89529dd0fd0(players, dmz_activity_start, undefined, undefined, dmz_activity_start_classic);
}

function dmz_activity_tension(players) {
  dmz_activity_tension = function_17ee301cf0b5ba85("dmz_activity_tension");
  dmz_activity_tension_classic = function_17ee301cf0b5ba85("dmz_activity_tension_classic");
  function_fe75a89529dd0fd0(players, dmz_activity_tension, undefined, undefined, dmz_activity_tension_classic);
}

function function_39a3ba69d3b190a5(players) {
  dmz_activity_action = function_17ee301cf0b5ba85("dmz_activity_action");
  dmz_activity_action_classic = function_17ee301cf0b5ba85("dmz_activity_action_classic");
  function_fe75a89529dd0fd0(players, dmz_activity_action, undefined, undefined, dmz_activity_action_classic);
}

function dmz_activity_win(players) {
  dmz_activity_win = function_17ee301cf0b5ba85("dmz_activity_win");
  dmz_activity_win_classic = function_17ee301cf0b5ba85("dmz_activity_win_classic");
  function_fe75a89529dd0fd0(players, dmz_activity_win, undefined, undefined, dmz_activity_win_classic);
}

function dmz_activity_lose(players) {
  dmz_activity_lose = function_17ee301cf0b5ba85("dmz_activity_lose");
  dmz_activity_lose_classic = function_17ee301cf0b5ba85("dmz_activity_lose_classic");
  function_fe75a89529dd0fd0(players, dmz_activity_lose, undefined, undefined, dmz_activity_lose_classic);
}

function ongameended() {
  level thread roundwinnerdialog();
  level thread gamewinnerdialog();
  level waittill("start_game_win_audio", winner);

  if(!isDefined(winner) || isDefined(level.endmusicplayed)) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "rumble_mgl") {
    return;
  }

  if(!ismusicenabled()) {
    return;
  }

  if(getgametype() == "xfire") {
    function_9d7b08b1c2165e1(winner);
  } else if(level.teambased) {
    if(level.splitscreen) {
      foreach(player in level.players) {
        if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
          continue;
        }

        player scripts\common\damage_effects::function_a2b4e6088394bade();

        if(winner == player.team) {
          player thread function_cd6fa41e597b8df0("mp_victory");
        } else {
          player thread function_cd6fa41e597b8df0("mp_defeat");
        }

        player setsoundsubmix("mp_matchend_music", 2);
      }
    } else {
      foreach(player in level.players) {
        player scripts\common\damage_effects::function_a2b4e6088394bade();
        player setsoundsubmix("mp_matchend_music", 2);

        if(winner == player.team) {
          player thread function_cd6fa41e597b8df0("mp_victory");
          continue;
        }

        player thread function_cd6fa41e597b8df0("mp_defeat");
      }
    }
  } else {
    foreach(player in level.players) {
      player scripts\common\damage_effects::function_a2b4e6088394bade();
      player setsoundsubmix("mp_matchend_music", 2);
      player setplayermusicstate("");

      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }

      if(isstring(winner) && (winner == "tie" || winner == "none")) {
        continue;
      }

      assertex(isstring(winner) || isDefined(winner.team) && isstring(winner.team), "<dev string:x1c>");

      if(isstring(winner) && winner == player.team || !isstring(winner) && isDefined(winner.team) && winner.team == player.team) {
        player thread function_cd6fa41e597b8df0("mp_victory");
        continue;
      }

      player thread function_cd6fa41e597b8df0("mp_defeat");
    }
  }

  level.endmusicplayed = 1;
}

function function_9d7b08b1c2165e1(winner) {
  foreach(player in level.players) {
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }

    player scripts\common\damage_effects::function_a2b4e6088394bade();
    player setsoundsubmix("mp_matchend_music", 2);

    if(winner == player.team) {
      player thread function_cd6fa41e597b8df0("mp_victory");
      continue;
    }

    player thread function_cd6fa41e597b8df0("mp_defeat");
  }
}

function midpoint_music(winning_team) {
  thread stopsuspensemusic();

  foreach(player in level.players) {
    if(winning_team == player.team) {
      player thread function_cd6fa41e597b8df0("mp_midpoint_winning");
      continue;
    }

    player thread function_cd6fa41e597b8df0("mp_midpoint_losing");
  }

  wait 25;
  thread suspensemusic();
}

function dominating_music(var_8b9b442335d5c181) {
  if(isDefined(level.dominating_music) && level.dominating_music == 1) {
    return;
  }

  thread stopsuspensemusic();

  foreach(player in level.players) {
    if(var_8b9b442335d5c181 == player.team) {
      player thread function_cd6fa41e597b8df0("mp_dominating");
      continue;
    }

    player thread function_cd6fa41e597b8df0("mp_dominated");
  }

  level.dominating_music = 1;
  wait 25;
  level.dominating_music = 0;
  thread suspensemusic();
}

function bombplanted_music() {
  if(isDefined(level.bombtimer) && level.bombtimer > 44) {
    waittime = level.bombtimer - 45;
    wait waittime;

    foreach(player in level.players) {
      player thread function_cd6fa41e597b8df0("mp_bombplant");
    }
  } else if(isDefined(level.bombtimer)) {
    waittime = level.bombtimer - 30;

    if(waittime < 0) {
      waittime = 0;
    }

    wait waittime;

    foreach(player in level.players) {
      player thread function_cd6fa41e597b8df0("mp_bombplant30");
    }
  }

  level.bombplanted_music = 1;
}

function roundwinnerdialog() {
  if(getgametype() == "ballmode") {
    return;
  }

  if(getgametype() == "wm" || getgametype() == "escort") {
    return;
  }

  level waittill("round_win", winner);

  if(istrue(level.var_1242a000845a4331)) {
    return;
  }

  delay = level.roundenddelay / 4;

  if(delay > 0) {
    wait delay;
  }

  var_ba1d87a61aadec55 = getgametype() == "xfire" || getgametype() == "warrior";
  alliesscore = game["teamScores"]["allies"];
  axisscore = game["teamScores"]["axis"];

  if(!isDefined(winner) || isPlayer(winner)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    game["dialog"]["round_success"] = "gamestate_practice_over";
    game["dialog"]["round_failure"] = "gamestate_practice_over";
    game["dialog"]["round_draw"] = "gamestate_practice_over";
  }

  if(winner == "allies") {
    leaderdialog("round_success", "allies");
    leaderdialog("round_failure", "axis");
    leaderdialog("round_failure", "team_three");
    return;
  }

  if(winner == "axis") {
    leaderdialog("round_success", "axis");
    leaderdialog("round_failure", "allies");
    leaderdialog("round_failure", "team_three");
    return;
  }

  if(winner == "team_three") {
    leaderdialog("round_success", "team_three");
    leaderdialog("round_failure", "allies");
    leaderdialog("round_failure", "axis");
    return;
  }

  if(!var_ba1d87a61aadec55 && axisscore > alliesscore) {
    leaderdialog("round_success", "axis");
    leaderdialog("round_failure", "allies");
    return;
  }

  if(!var_ba1d87a61aadec55 && alliesscore > axisscore) {
    leaderdialog("round_success", "allies");
    leaderdialog("round_failure", "axis");
    return;
  }

  if(getgametype() == "warrior" && level.var_6298f362ec23d83.ref == "hunt") {
    var_bb4049867767c45f = getenemyteams(level.var_6298f362ec23d83.hunterteam);
    leaderdialog("round_success", var_bb4049867767c45f[0]);
    leaderdialog("round_success", var_bb4049867767c45f[1]);
    leaderdialog("round_failure", level.var_6298f362ec23d83.hunterteam);
    return;
  }

  if(getgametype() == "warrior") {
    foreach(team in level.teamnamelist) {
      if(getteamdata(team, "aliveCount") > 0) {
        leaderdialog("round_draw", team);
        continue;
      }

      leaderdialog("round_failure", team);
    }

    return;
  }

  leaderdialog("round_draw", "allies");
  leaderdialog("round_draw", "axis");
  leaderdialog("round_draw", "team_three");
}

function gamewinnerdialog() {
  level waittill("start_game_win_audio", winner);
  delay = level.postroundtime / 2;

  if(delay > 0) {
    wait delay;
  }

  if(!isDefined(winner)) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(getDvar(@ "ui_gametype") == "wm") {
    return;
  }

  if(isPlayer(winner) && !level.teambased) {
    for(i = 0; i < level.placement["all"].size; i++) {
      player = level.placement["all"][i];

      if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
        continue;
      }

      if(i < 3) {
        player leaderdialogonplayer("mission_success");
        continue;
      }

      player leaderdialogonplayer("mission_failure");
    }

    return;
  }

  var_6d7c74048def3911 = "mission_failure";

  if(getgametype() == "escort") {
    if(winner == game["defenders"]) {
      var_6d7c74048def3911 = "fail_attacker";
    }
  }

  if(winner == "allies") {
    leaderdialog("mission_success", "allies");
    leaderdialog(var_6d7c74048def3911, "axis");
    leaderdialog(var_6d7c74048def3911, "team_three");
    return;
  }

  if(winner == "axis") {
    leaderdialog("mission_success", "axis");
    leaderdialog(var_6d7c74048def3911, "allies");
    leaderdialog(var_6d7c74048def3911, "team_three");
    return;
  }

  if(winner == "team_three") {
    leaderdialog("mission_success", "team_three");
    leaderdialog(var_6d7c74048def3911, "axis");
    leaderdialog(var_6d7c74048def3911, "allies");
    return;
  }

  if(getgametype() == "warrior") {
    foreach(team in level.teamnamelist) {
      if(game["teamScores"][team] >= level.roundscorelimit) {
        leaderdialog("mission_draw", team);
        continue;
      }

      leaderdialog(var_6d7c74048def3911, team);
    }

    return;
  }

  leaderdialog("mission_draw", "axis");
  leaderdialog("mission_draw", "allies");
  leaderdialog("mission_draw", "team_three");
}

function musiccontroller() {
  level endon("game_ended");

  if(!isDefined(level.musicenabled)) {
    level.musicenabled = 1;
  }

  thread suspensemusic();

  if(getgametype() == "ballmode") {
    return;
  }

  level waittill("match_ending_soon", reason);
  assert(isDefined(reason));

  if(level.roundlimit == 1 || game["roundsPlayed"] == level.roundlimit - 1 || ismoddedroundgame()) {
    if(!level.splitscreen) {
      if(reason == "time") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              thread timelimitmusic("allies");
            }

            childthread function_7fb5d63165248f4d("allies");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              thread timelimitmusic("axis");
            }

            childthread function_7fb5d63165248f4d("axis");
          } else if(ismusicenabled()) {
            thread timelimitmusic("draw");
          }
        } else if(ismusicenabled()) {
          foreach(player in level.players) {
            player thread function_cd6fa41e597b8df0("mp_timesup_winning");
          }
        }
      } else if(reason == "score") {
        if(level.teambased && getgametype() != "arena") {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              foreach(player in level.players) {
                if(player.team == "allies") {
                  player thread function_cd6fa41e597b8df0("mp_round_winning");
                  continue;
                }

                player thread function_cd6fa41e597b8df0("mp_round_losing");
              }
            }

            leaderdialog("winning_score", "allies");
            leaderdialog("losing_score", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              foreach(player in level.players) {
                if(player.team == "allies") {
                  player thread function_cd6fa41e597b8df0("mp_round_losing");
                  continue;
                }

                player thread function_cd6fa41e597b8df0("mp_round_winning");
              }
            }

            leaderdialog("winning_score", "axis");
            leaderdialog("losing_score", "allies");
          }
        } else {
          winningplayer = scripts\mp\gamescore::gethighestscoringplayer();
          losingplayers = scripts\mp\gamescore::getlosingplayers();
          excludelist[0] = winningplayer;

          if(ismusicenabled()) {
            foreach(player in level.players) {
              if(winningplayer.pers["team"] == player.team) {
                player thread function_cd6fa41e597b8df0("mp_round_winning");
                continue;
              }

              player thread function_cd6fa41e597b8df0("mp_round_losing");
            }
          }

          winningplayer leaderdialogonplayer("winning_score");
          leaderdialogonplayers("losing_score", losingplayers);
        }
      }
    }

    return;
  }

  if(getgametype() != "arena") {
    clearmusicstate();
  }
}

function function_7fb5d63165248f4d(winningteam) {
  if(isDefined(level.var_97a53e173c277570)) {
    wait level.var_97a53e173c277570;
  }

  losingteam = winningteam == "allies" ? "axis" : "allies";
  leaderdialog("winning_time", winningteam);
  leaderdialog("losing_time", losingteam);
}

function matchendingsoonleaderdialog(dialog, timeleftint) {
  if(getgametype() == "arena") {
    if(isDefined(timeleftint) && !isDefined(level.notifiedtimesup) && timeleftint <= 10) {
      level.notifiedtimesup = 1;
      dialog = "timesup_ten";
    } else if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 1 || game["launchChunkRuleSet"] == 2) {
        return false;
      }
    } else {
      return false;
    }
  } else if(getgametype() == "escort") {
    if(dialog == "timesup_thirty") {
      leaderdialog("almost_over_attacker", game["attackers"]);
      leaderdialog("almost_over_defender", game["defenders"]);
      return true;
    }
  }

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(team != "spectator") {
        leaderdialog(dialog, team);
      }
    }
  } else {
    players = [];

    foreach(p in level.players) {
      if(p.team != "spectator") {
        players[players.size] = p;
      }
    }

    scripts\mp\utility\dialog::leaderdialogonplayers(dialog, players);
  }

  return true;
}

function timelimitmusic(team) {
  self endon("game_ended");
  level notify("stop_suspense_music");

  if(getgametype() != "arena") {
    foreach(player in level.players) {
      if(team == player.team) {
        player thread function_cd6fa41e597b8df0("mp_timesup_winning");
        continue;
      }

      player thread function_cd6fa41e597b8df0("mp_timesup_losing");
    }
  }
}

function headquarters_newhq_music() {
  stopsuspensemusic();

  foreach(player in level.players) {
    player thread function_cd6fa41e597b8df0("mp_hq_new");
  }
}

function headquarters_captured_music() {
  level endon("hq_music_done");
  stopsuspensemusic();

  foreach(player in level.players) {
    player thread function_cd6fa41e597b8df0("mp_captured");
    level.hq_captured_music = 1;
    wait 60;
    level.hq_captured_music = 0;
  }
}

function headquarters_deactivate_music(claimteam) {
  stopsuspensemusic();

  if(istrue(level.hq_captured_music)) {
    level notify("hq_music_done");
    level.hq_captured_music = 0;

    foreach(player in level.players) {
      if(claimteam == player.team) {
        player thread function_cd6fa41e597b8df0("mp_destroyed_pos");
        continue;
      }

      player thread function_cd6fa41e597b8df0("mp_destroyed_neg");
    }
  }
}

function function_20981f58c35e2997(claimteam) {
  stopsuspensemusic();

  foreach(player in level.players) {
    if(claimteam == player.team) {
      player thread function_cd6fa41e597b8df0("mp_destroyed_pos");
      continue;
    }

    player thread function_cd6fa41e597b8df0("mp_destroyed_neg");
  }
}

function infected_music() {
  infected = function_17ee301cf0b5ba85("infected");
  self setplayermusicstate(infected);
}

function suspensemusic(var_8c71e0347db7824d) {
  if(!ismusicenabled()) {
    return;
  }

  mapname = getDvar(@ "g_mapname");

  if(mapname == "mp_gunsmith_gl") {
    return;
  }

  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("stop_suspense_music");

  if(istrue(level.nosuspensemusic)) {
    return;
  }

  wait 30;

  if(isDefined(var_8c71e0347db7824d) && var_8c71e0347db7824d) {
    wait 120;
  }

  for(;;) {
    wait randomfloatrange(75, 120);

    if(isDefined(level.nosuspensemusic) && level.nosuspensemusic) {
      return;
    }

    if(!istrue(game["inLiveLobby"])) {
      foreach(player in level.players) {
        player thread function_cd6fa41e597b8df0("mp_suspense");
      }
    }
  }
}

function suspensemusic_reset(waittime) {
  wait waittime;
  self.nosuspensemusic = undefined;
}

function stopsuspensemusic() {
  level notify("stop_suspense_music");

  if(isDefined(level.cursuspsensetrack) && level.cursuspsensetrack.size == 2) {
    clearmusicstate();
  }
}

function enablemusic() {
  if(level.musicenabled == 0) {
    thread suspensemusic();
  }

  level.musicenabled++;
}

function disablemusic() {
  if(!isDefined(level.musicenabled)) {
    level.musicenabled = 0;
    return;
  }

  if(level.musicenabled > 0) {
    level.musicenabled--;

    if(level.musicenabled == 0) {
      stopsuspensemusic();
    }
  }
}

function round_end_music(winner, endreasontext, endreasontextloss) {
  if(isDefined(level.endmusicplayed)) {
    return;
  }

  if(getgametype() == "ballmode") {
    return;
  }

  if(getgametype() == "xfire") {
    thread stopsuspensemusic();
    function_4f651c1e1ec8dae6(winner);
    return;
  }

  thread stopsuspensemusic();

  if(level.halftimetype == "halftime" && level.roundlimit && game["roundsPlayed"] * 2 == level.roundlimit) {
    foreach(player in level.players) {
      if(getgametype() == "ctf" || getgametype() == "escort") {
        if(winner == "tie") {
          player thread function_cd6fa41e597b8df0("mp_round_draw");
          continue;
        }

        if(winner == player.team) {
          player thread function_cd6fa41e597b8df0("mp_round_win");
          continue;
        }

        player thread function_cd6fa41e597b8df0("mp_round_loss");
      }
    }

    return;
  }

  if(level.playovertime) {
    setmusicstate("mus_mp_halftime");
    return;
  }

  if(level.halftimetype == "halftime" && !level.roundlimit) {
    foreach(player in level.players) {
      if(getgametype() != "arena") {
        if(winner == "tie") {
          player thread function_cd6fa41e597b8df0("mp_round_draw_" + getarenaroundendmusictype());
        } else if(winner == player.team) {
          player thread function_cd6fa41e597b8df0("mp_round_win_" + getarenaroundendmusictype());
        } else {
          player thread function_cd6fa41e597b8df0("mp_round_loss_" + getarenaroundendmusictype());
        }

        continue;
      }

      if(winner == "tie") {
        player thread function_cd6fa41e597b8df0("mp_round_draw_" + getarenaroundendmusictype());
        continue;
      }

      if(winner == player.team) {
        player thread function_cd6fa41e597b8df0("mp_round_win_" + getarenaroundendmusictype());
        continue;
      }

      player thread function_cd6fa41e597b8df0("mp_round_loss_" + getarenaroundendmusictype());
    }

    return;
  }

  if(level.halftimetype == "halftime" && getgametype() == "dd" && !hitroundlimit()) {
    foreach(player in level.players) {
      if(getgametype() != "arena") {
        if(winner == "tie") {
          player thread function_cd6fa41e597b8df0("mp_round_draw_" + getarenaroundendmusictype());
        } else if(winner == player.team) {
          player thread function_cd6fa41e597b8df0("mp_round_win_" + getarenaroundendmusictype());
        } else {
          player thread function_cd6fa41e597b8df0("mp_round_loss_" + getarenaroundendmusictype());
        }

        continue;
      }

      if(winner == "tie") {
        player thread function_cd6fa41e597b8df0("mp_round_draw_" + getarenaroundendmusictype());
        continue;
      }

      if(winner == player.team) {
        player thread function_cd6fa41e597b8df0("mp_round_win_" + getarenaroundendmusictype());
        continue;
      }

      player thread function_cd6fa41e597b8df0("mp_round_loss_" + getarenaroundendmusictype());
    }
  }
}

function function_4f651c1e1ec8dae6(winner) {
  thread stopsuspensemusic();

  foreach(player in level.players) {
    if(winner == "tie") {
      player thread function_cd6fa41e597b8df0("mp_round_draw_" + getarenaroundendmusictype());
      continue;
    }

    if(winner == player.team) {
      player thread function_cd6fa41e597b8df0("mp_round_win_" + getarenaroundendmusictype());
      continue;
    }

    player thread function_cd6fa41e597b8df0("mp_round_loss_" + getarenaroundendmusictype());
  }
}

function function_6c71c8bc6495a0df(generic) {
  thread stopsuspensemusic();

  if(isDefined(generic)) {
    foreach(player in level.players) {
      player thread function_cd6fa41e597b8df0("mp_overtime");
    }

    return;
  }

  foreach(player in level.players) {
    player thread function_cd6fa41e597b8df0("mp_overtime");
  }
}

function getarenaroundendmusictype() {
  musictype = "early";
  mostroundswon = 0;

  foreach(entry in level.teamnamelist) {
    roundswon = game["roundsWon"][entry];

    if(roundswon > mostroundswon) {
      mostroundswon = roundswon;
    }
  }

  if(mostroundswon > 0) {
    perc = mostroundswon / level.winlimit;

    if(perc <= 0.34) {
      musictype = "early";
    } else if(perc >= 0.34 && perc <= 0.67) {
      musictype = "mid";
    } else {
      musictype = "late";
    }
  }

  return musictype;
}

function function_aecafe54c65c0e35(players) {
  players = default_to(players, level.players);
  br_players = [];

  if(isarray(players)) {
    foreach(player in players) {
      var_de14d878883d4c57 = player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();

      if(isPlayer(player) && !isagent(player) && !isbot(player) && !var_de14d878883d4c57) {
        br_players[br_players.size] = player;
      }
    }
  }

  return br_players;
}

function function_a486df26072a530a(circleindex, circletotal, var_2948ca54731de34f) {
  level endon("game_ended");
  var_2948ca54731de34f = default_to(var_2948ca54731de34f, 0.05);
  assert(isnumber(circleindex));
  assert(isnumber(circletotal));

  if(isstruct(level.br_circle)) {
    if(isnumber(level.br_circle.var_da6c0f6a12518740) && level.br_circle.var_da6c0f6a12518740 == circleindex) {
      return;
    } else {
      level.br_circle.var_da6c0f6a12518740 = circleindex;
    }
  }

  var_272b0ee396e8a69a = int(circletotal - 1);
  var_1b32fded15194cc7 = var_272b0ee396e8a69a / 3;
  var_3494d23f34a9dac = int(floor(var_1b32fded15194cc7));
  var_61d4cf0c14f1b38f = int(var_3494d23f34a9dac * 3);
  var_695acfe00695da06 = int(max(0, var_272b0ee396e8a69a - var_61d4cf0c14f1b38f));
  lowindex = int(var_3494d23f34a9dac) - 1;
  medindex = int(var_3494d23f34a9dac * 2 + var_695acfe00695da06) - 1;
  highindex = int(var_3494d23f34a9dac * 3);
  finalindex = int(max(1, circletotal - 1));
  waittime = max(0.05, var_2948ca54731de34f);
  wait waittime;
  br_circle_state = "";
  var_96dd8ab6925778d3 = "";

  if(circleindex <= lowindex) {
    br_circle_state = function_17ee301cf0b5ba85("br_ring_low");
    var_96dd8ab6925778d3 = function_17ee301cf0b5ba85("br_ring_low_classic");
  } else if(circleindex <= medindex) {
    br_circle_state = function_17ee301cf0b5ba85("br_ring_med");
    var_96dd8ab6925778d3 = function_17ee301cf0b5ba85("br_ring_med_classic");
  } else if(circleindex <= highindex) {
    br_circle_state = function_17ee301cf0b5ba85("br_ring_high");
    var_96dd8ab6925778d3 = function_17ee301cf0b5ba85("br_ring_high_classic");
  } else if(circleindex == finalindex) {
    br_circle_state = function_17ee301cf0b5ba85("br_ring_final");
    var_96dd8ab6925778d3 = function_17ee301cf0b5ba85("br_ring_final_classic");
  }

  players = function_aecafe54c65c0e35();
  exfil_players = [];

  foreach(player in players) {
    if(isPlayer(player) && istrue(player.var_43fa6aa15d11c927)) {
      exfil_players[exfil_players.size] = player;
    }
  }

  players = array_remove_array(players, exfil_players);
  function_fe75a89529dd0fd0(players, br_circle_state, undefined, undefined, var_96dd8ab6925778d3);

  if(circleindex != finalindex) {
    wait 30;
    function_fe75a89529dd0fd0(players, "", undefined, "wartracks");
  }
}

function plunder_tenpercent_music() {
  level notify("stop_suspense_music");
}

function plunder_thirtypercent_music() {
  level endon("fiftypercent_music");

  if(isDefined(level.thirtypercent_music) && level.thirtypercent_music == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  level notify("stop_suspense_music");
  numtracks = game["music"]["plunder_tenpercent"].size;
  tracknum = randomint(numtracks);
  setmusicstate(game["music"]["plunder_tenpercent"][tracknum]);
  level.thirtypercent_music = 1;
}

function plunder_fiftypercent_music(team) {
  level endon("seventyfivepercent_music");

  if(isDefined(level.fiftypercent_music) && level.fiftypercent_music == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  numtracks = game["music"]["plunder_thirtypercent"].size;
  tracknum = randomint(numtracks);
  setmusicstate(game["music"]["plunder_thirtypercent"][tracknum]);
  level.fiftypercent_music = 1;
  level notify("fiftypercent_music");
}

function plunder_seventyfivepercent_music(team) {
  level endon("ninetypercent_music");

  if(isDefined(level.seventyfivepercent_music) && level.seventyfivepercent_music == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  numtracks = game["music"]["plunder_fiftypercent"].size;
  tracknum = randomint(numtracks);
  setmusicstate(game["music"]["plunder_fiftypercent"][tracknum]);
  level.seventyfivepercent_music = 1;
  level notify("seventyfivepercent_music");
}

function plunder_ninetypercent_music(team) {
  if(isDefined(level.ninetypercent_music) && level.ninetypercent_music == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  numtracks = game["music"]["plunder_seventyfivepercent"].size;
  tracknum = randomint(numtracks);
  setmusicstate(game["music"]["plunder_seventyfivepercent"][tracknum]);
  level.ninetypercent_music = 1;
  level notify("ninetypercent_music");
}

function plunder_overtime_music() {
  if(isDefined(level.overtime_music) && level.overtime_music == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    return;
  }

  numtracks = game["music"]["plunder_ninetypercent"].size;
  tracknum = randomint(numtracks);
  setmusicstate(game["music"]["plunder_ninetypercent"][tracknum]);
  level.overtime_music = 1;
}

function function_283a36147406b42f() {
  if(istrue(level.overtime_music)) {
    return;
  }

  setmusicstate(game["music"]["plunder_bonustime_long"][0]);
  level.overtime_music = 1;
}

function function_c080ebbcdcc3176f() {
  if(!isDefined(self.warp_music)) {
    self.warp_music = 1;
    self setplayermusicstate("iw9_mp_dmz_biobunker_enter");
  }
}

function ismusicenabled() {
  return level.musicenabled > 0;
}

function function_535120141f535b49() {
  self endon("disconnect");
  level endon("game_ended");
  stopsuspensemusic();

  if(!isDefined(self.music_value)) {
    self.music_value = 0;
  }

  if(!isDefined(self.var_33ed4a0a9ccd0f0a)) {
    self.var_33ed4a0a9ccd0f0a = 0;
  }

  if(!isDefined(self.music_time)) {
    self.music_time = 0;
  }

  while(true) {
    music_diff = self.music_value - self.var_33ed4a0a9ccd0f0a;

    if(self.music_value >= 0) {
      self.var_33ed4a0a9ccd0f0a = self.music_value;
    }

    iprintln("current music diff is " + music_diff);

    if(music_diff > 0) {
      if(music_diff > 1 && music_diff < 6) {
        if(!isDefined(self.music_low)) {
          thread function_32e2796e3dbf61ac();
        }
      } else if(music_diff >= 6 && music_diff <= 15) {
        if(!isDefined(self.music_med)) {
          thread function_3f789f6e464550d8();
        }
      } else if(music_diff > 15) {
        if(!isDefined(self.music_high)) {
          thread function_ee789bca4d90f206();
        }
      }
    }

    if(music_diff < 0) {
      if(music_diff <= -5 && music_diff > -10) {
        if(isDefined(self.music_med) || isDefined(self.music_high) || isDefined(self.music_low)) {
          self setsoundsubmix("iw9_mp_musictest_fadeout", 4);
          self notify("clear_music_low");
          self notify("clear_music_med");
          self notify("clear_music_high");
          self.music_low = undefined;
          self.music_high = undefined;
          self.music_med = undefined;
          wait self.music_time + 10;

          if(self.music_value >= 0) {
            self.var_33ed4a0a9ccd0f0a = self.music_value;
          }

          self stoplocalsound("mus_iw9_mpmusictest_ambient1_intro");
          self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
        }
      } else if(music_diff < -10) {
        if(isDefined(self.music_med) || isDefined(self.music_high)) {
          self playlocalsound("mus_iw9_mpmusictest_hit1_intro");
        }

        if(isDefined(self.music_med) || isDefined(self.music_high) || isDefined(self.music_low)) {
          self setsoundsubmix("iw9_mp_musictest_fadeout", 2);
          self notify("clear_music_low");
          self notify("clear_music_med");
          self notify("clear_music_high");
          self.music_low = undefined;
          self.music_high = undefined;
          self.music_med = undefined;
          wait self.music_time + 10;

          if(self.music_value >= 0) {
            self.var_33ed4a0a9ccd0f0a = self.music_value;
          }

          self stoplocalsound("mus_iw9_mpmusictest_ambient1_intro");
          self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
        }
      }
    }

    if(self.music_value >= 0) {
      self.music_value -= 0.5;
    }

    if(self.music_value < 0) {
      self.music_value = 0;
    }

    iprintln("current music value is " + self.music_value);
    wait 2;

    if(self.music_time > 0) {
      self.music_time -= 2;

      if(self.music_time < 0) {
        self.music_time = 0;
      }
    }
  }
}

function function_32e2796e3dbf61ac() {
  self endon("disconnect");
  self endon("clear_music_low");
  level endon("game_ended");

  if(!isDefined(self.music_low)) {
    self.music_low = 1;
    self playlocalsound("mus_iw9_mpmusictest_ambient1_intro");
    iprintln("adding low music");
    self.music_time = 25;
    wait self.music_time;
    iprintln("low music state cleared");
    self.music_low = undefined;
  }
}

function function_3f789f6e464550d8() {
  self endon("disconnect");
  self endon("clear_music_med");
  level endon("game_ended");

  if(isDefined(self.music_high)) {
    self.music_high = 1;
    self.music_med = 1;
    self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self setplayermusicstate("");
    self notify("clear_music_high");
    iprintln("adding med music");
    self.music_time = 21;
    wait self.music_time;
    iprintln("music states cleared");
    self.music_high = undefined;
    self.music_med = undefined;
    return;
  }

  self.music_med = 1;
  self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
  self setplayermusicstate("iw9_mpmusictest_perc1");
  iprintln("adding med music");
  self.music_time = 21;
  wait self.music_time - 2;
  self setsoundsubmix("iw9_mp_musictest_fadeout", 2);
  self stopplayermusicstate("iw9_mpmusictest_perc1");
  wait self.music_time + 2;
  iprintln("med music state cleared");
  self.music_med = undefined;
}

function function_ee789bca4d90f206() {
  self endon("disconnect");
  self endon("clear_music_high");
  level endon("game_ended");

  if(isDefined(self.music_med)) {
    self.music_high = 1;
    self.music_med = 1;
    self setplayermusicstate("");
    self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
    self notify("clear_music_med");
    iprintln("adding high music");
    self.music_time = 31;
    wait self.music_time;
    iprintln("music states cleared");
    self.music_high = undefined;
    self.music_med = undefined;
    return;
  }

  self.music_high = 1;
  self clearsoundsubmix("iw9_mp_musictest_fadeout", 2);
  self setplayermusicstate("iw9_mpmusictest_bass1");
  iprintln("adding high music");
  self.music_time = 30.5;
  wait self.music_time - 2;
  self setsoundsubmix("iw9_mp_musictest_fadeout", 2);
  self stopplayermusicstate("iw9_mpmusictest_bass1");
  wait self.music_time + 2;
  iprintln("high music state cleared");
  self.music_high = undefined;
}