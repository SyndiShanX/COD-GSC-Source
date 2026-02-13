/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2040.gsc
*************************************************/

init() {
  if(istrue(game["isLaunchChunk"])) {
    var_0 = "ustl";
  } else {
    var_0 = "uktl";
  }

  if(isDefined(level._id_1517)) {
    var_0 = level._id_1517;
  }

  var_1 = "rutl";

  if(isDefined(level._id_1FEE)) {
    var_1 = level._id_1FEE;
  }

  if(!isDefined(game["music"])) {
    var_2 = getDvar("#x376847958d67972ef");
    game["voice"]["allies"] = var_0;
    game["music"]["allies_used_nuke"] = "mus_us_nuke_fired";
    game["music"]["allies_hit_by_nuke"] = "mus_us_nuke_hit";
    game["music"]["draw_allies"] = "mus_west_draw";
    game["music"]["spawn_axis"] = [];

    if(isDefined(level._id_A35B) && level._id_A35B == "eastern_europe") {
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_1";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_2";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_3";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_4";
    } else if(isDefined(level._id_A35B) && level._id_A35B == "middle_east") {
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_middleeast_east_static_1";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_middleeast_east_static_2";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_middleeast_east_static_3";
    } else {
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_1";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_2";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_3";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_4";
    }

    game["music"]["spawn_allies"] = [];

    if(isDefined(level._id_A35B) && level._id_A35B == "eastern_europe") {
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_1";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_2";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_3";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_4";
    } else if(isDefined(level._id_A35B) && level._id_A35B == "middle_east") {
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_middleeast_west_static_1";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_middleeast_west_static_2";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_middleeast_west_static_3";
    } else {
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_england_west_static_1";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_england_west_static_2";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_england_west_static_3";
    }

    foreach(var_4 in level._id_EF89) {
      if(var_4 == "axis" || var_4 == "allies") {
        continue;
      }
      game["music"]["defeat_" + var_4] = "mus_west_defeat";
      game["music"]["victory_" + var_4] = "mus_west_victory";
      game["music"]["winning_" + var_4] = "mus_west_winning";
      game["music"]["losing_" + var_4] = "mus_west_losing";
    }

    game["music"]["gunfight_spawn_allies"] = [];
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_1";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_2";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_3";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_4";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_5";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_6";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_7";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_8";
    game["music"]["gunfight_spawn_allies"][game["music"]["gunfight_spawn_allies"].size] = "mp_gunfight_west_infil_9";
    game["music"]["gunfight_spawn_axis"] = [];
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_1";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_2";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_3";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_4";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_5";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_6";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_7";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_8";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_9";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_10";
    game["music"]["gunfight_spawn_axis"][game["music"]["gunfight_spawn_axis"].size] = "mp_gunfight_east_infil_11";
    game["music"]["allies_suspense"] = [];
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_2";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_3";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_4";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_6";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_9";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_10";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_11";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_13";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_15";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_16";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_17";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_19";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_2";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_7";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_11";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_13";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_14";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_4";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_5";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_6";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_8";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_26";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_33";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_37";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_38";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_39";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_45";

    if(isDefined(level._id_A35B) && level._id_A35B == "eastern_europe") {
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_1";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_5";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_7";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_8";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_12";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_14";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_12";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_18";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_easterneurope_20";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_48";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_49";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_50";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_51";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_52";
    }

    if(isDefined(level._id_A35B) && level._id_A35B == "england") {
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_3";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_4";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_5";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_6";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_8";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_9";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_10";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_12";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_15";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_england_16";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_40";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_43";
    }

    if(isDefined(level._id_A35B) && level._id_A35B == "middle_east") {
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_1";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_3";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_12";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_14";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_15";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_16";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_17";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_18";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_19";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_20";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_21";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_22";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_23";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_24";
      game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mus_tension_middleeast_25";
    }

    game["voice"]["axis"] = var_1;
    game["music"]["axis_used_nuke"] = "mus_fd_nuke_fired";
    game["music"]["axis_hit_by_nuke"] = "mus_fd_nuke_hit";
    game["music"]["draw_axis"] = "mus_east_draw";
    game["music"]["axis_suspense"] = [];
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_2";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_3";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_4";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_6";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_9";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_10";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_11";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_13";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_15";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_16";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_17";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_19";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_2";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_7";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_11";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_13";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_14";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_4";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_5";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_6";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_8";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_26";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_33";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_37";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_38";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_39";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_45";

    if(isDefined(level._id_A35B) && level._id_A35B == "eastern_europe") {
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_1";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_5";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_7";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_8";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_12";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_14";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_12";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_18";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_easterneurope_20";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_48";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_49";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_50";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_51";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_52";
    }

    if(isDefined(level._id_A35B) && level._id_A35B == "england") {
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_3";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_4";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_5";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_6";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_8";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_9";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_10";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_12";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_15";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_england_16";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_40";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_43";
    }

    if(isDefined(level._id_A35B) && level._id_A35B == "middle_east") {
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_1";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_3";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_12";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_14";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_15";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_16";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_17";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_18";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_19";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_20";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_21";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_22";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_23";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_24";
      game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mus_tension_middleeast_25";
    }

    game["music"]["mp_match_start_general"] = [];
    game["music"]["mp_match_start_general"][game["music"]["mp_match_start_general"].size] = "music_mp_match_start";
    game["music"]["mp_match_start_general"][game["music"]["mp_match_start_general"].size] = "music_mp_match_start2";
    game["music"]["mp_match_start_general"][game["music"]["mp_match_start_general"].size] = "music_mp_match_start3";
    game["music"]["mp_arena_start"] = [];
    game["music"]["mp_arena_start"][game["music"]["mp_arena_start"].size] = "mp_arena_start_stinger";
    game["music"]["mp_arena_start"][game["music"]["mp_arena_start"].size] = "mp_arena_start_stinger2";
    game["music"]["mp_arena_start"][game["music"]["mp_arena_start"].size] = "mp_arena_start_stinger3";
    game["music"]["mp_arena_start"][game["music"]["mp_arena_start"].size] = "mp_arena_start_stinger4";
    game["music"]["mp_match_closing"] = [];
    game["music"]["mp_match_closing"][game["music"]["mp_match_closing"].size] = "music_mp_match_closing";
    game["music"]["mp_match_closing"][game["music"]["mp_match_closing"].size] = "music_mp_match_closing2";
    game["music"]["mp_match_winners_circle"] = [];
    game["music"]["mp_match_winners_circle"][game["music"]["mp_match_winners_circle"].size] = "music_mp_winners_circle";
    game["music"]["mp_match_winners_circle"][game["music"]["mp_match_winners_circle"].size] = "music_mp_winners_circle2";
    game["music"]["mp_match_winners_circle"][game["music"]["mp_match_winners_circle"].size] = "music_mp_winners_circle3";
    game["music"]["mp_arena_evo_defeat"] = [];
    game["music"]["mp_arena_evo_defeat"][game["music"]["mp_arena_evo_defeat"].size] = "music_mp_arena_evo_defeat";
    game["music"]["mp_arena_evo_defeat"][game["music"]["mp_arena_evo_defeat"].size] = "music_mp_arena_evo_defeat2";
    game["music"]["mp_arena_evo_defeat"][game["music"]["mp_arena_evo_defeat"].size] = "music_mp_arena_evo_defeat3";
    game["music"]["mp_arena_evo_victory"] = [];
    game["music"]["mp_arena_evo_victory"][game["music"]["mp_arena_evo_victory"].size] = "music_mp_arena_evo_victory";
    game["music"]["mp_arena_evo_victory"][game["music"]["mp_arena_evo_victory"].size] = "music_mp_arena_evo_victory2";
    game["music"]["mp_arena_evo_victory"][game["music"]["mp_arena_evo_victory"].size] = "music_mp_arena_evo_victory3";
    game["music"]["mp_arena_evo_victory"][game["music"]["mp_arena_evo_victory"].size] = "music_mp_arena_evo_victory4";
    game["music"]["mp_arena_evo_draw"] = [];
    game["music"]["mp_arena_evo_draw"][game["music"]["mp_arena_evo_draw"].size] = "music_mp_arena_evo_draw";
    game["music"]["mp_arena_evo_draw"][game["music"]["mp_arena_evo_draw"].size] = "music_mp_arena_evo_draw2";
    game["music"]["mp_arena_round_over"] = [];
    game["music"]["mp_arena_round_over"][game["music"]["mp_arena_round_over"].size] = "mp_arena_round_over";
    game["music"]["mp_arena_round_over"][game["music"]["mp_arena_round_over"].size] = "mp_arena_round_over2";
    game["music"]["mp_arena_round_over"][game["music"]["mp_arena_round_over"].size] = "mp_arena_round_over3";
    game["music"]["mp_arena_round_start"] = [];
    game["music"]["mp_arena_round_start"][game["music"]["mp_arena_round_start"].size] = "mp_arena_round_start";
    game["music"]["mp_arena_round_start"][game["music"]["mp_arena_round_start"].size] = "mp_arena_round_start2";
    game["music"]["mp_arena_round_start"][game["music"]["mp_arena_round_start"].size] = "mp_arena_round_start3";
    game["music"]["mp_match_postflow"] = [];
    game["music"]["mp_match_postflow"][game["music"]["mp_match_postflow"].size] = "music_mp_match_postflow";
    game["music"]["mp_match_postflow"][game["music"]["mp_match_postflow"].size] = "music_mp_match_postflow2";
    game["music"]["mp_timer_10s"] = [];
    game["music"]["mp_timer_10s"][game["music"]["mp_timer_10s"].size] = "mp_timer_10s";
    game["music"]["ftue_match_start"] = [];
    game["music"]["ftue_match_start"][game["music"]["ftue_match_start"].size] = "music_ftue_start";
    game["music"]["mp_ar_overtime_start"] = [];
    game["music"]["mp_ar_overtime_start"][game["music"]["mp_ar_overtime_start"].size] = "mp_ar_overtime_start_loop";
    game["music"]["mp_ks_flamethrower_intro"] = [];
    game["music"]["mp_ks_flamethrower_intro"][game["music"]["mp_ks_flamethrower_intro"].size] = "ks_flamethrower_intro";
    game["music"]["mp_ks_flamethrower_outro"] = [];
    game["music"]["mp_ks_flamethrower_outro"][game["music"]["mp_ks_flamethrower_outro"].size] = "ks_flamethrower_outro";
    game["music"]["mp_ks_flamethrower_loop"] = [];
    game["music"]["mp_ks_flamethrower_loop"][game["music"]["mp_ks_flamethrower_loop"].size] = "ks_flamethrower_loop";
    game["music"]["mp_ks_lmg_stinger"] = [];
    game["music"]["mp_ks_lmg_stinger"][game["music"]["mp_ks_lmg_stinger"].size] = "ks_lmg_stinger";
    game["music"]["mp_ks_lmg_stinger"][game["music"]["mp_ks_lmg_stinger"].size] = "ks_lmg_stinger2";
    game["music"]["mp_ks_warmachine_stinger"] = [];
    game["music"]["mp_ks_warmachine_stinger"][game["music"]["mp_ks_warmachine_stinger"].size] = "ks_warmachine_stinger";
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

    foreach(var_4 in level._id_EF89) {
      if(var_4 == "axis" || var_4 == "allies") {
        continue;
      }
    }

    game["dialog"]["timesup"] = "z279";
    game["dialog"]["timesup_sixty"] = "gamestate_timesup_sixty";
    game["dialog"]["timesup_thirty"] = "gamestate_timesup_thirty";
    game["dialog"]["timesup_ten"] = "gamestate_timesup_ten";
    game["dialog"]["winning_comeback"] = "gamestate_winning_comeback";
    game["dialog"]["lead_lost"] = "z259";
    game["dialog"]["lead_tied"] = "gamestate_tied";
    game["dialog"]["lead_taken"] = "z260";
    game["dialog"]["last_alive"] = "hint_lastmanstanding";
    game["dialog"]["halftime"] = "gamestate_halftime";
    game["dialog"]["overtime"] = "gamestate_overtime";
    game["dialog"]["side_switch"] = "gamestate_switchsides";
    game["dialog"]["kill_all"] = "hint_killall";
    game["dialog"]["lead"] = "gamestate_leadtaken";

    if(!isDefined(game["dialog"]["winning"])) {
      game["dialog"]["winning"] = "adva";
    }

    if(!isDefined(game["dialog"]["winning_time"])) {
      game["dialog"]["winning_time"] = "adva";
    }

    if(!isDefined(game["dialog"]["winning_score"])) {
      game["dialog"]["winning_score"] = "adva";
    }

    if(!isDefined(game["dialog"]["losing"])) {
      game["dialog"]["losing"] = "dadv";
    }

    if(!isDefined(game["dialog"]["losing_time"])) {
      game["dialog"]["losing_time"] = "dadv";
    }

    if(!isDefined(game["dialog"]["losing_score"])) {
      game["dialog"]["losing_score"] = "dadv";
    }

    if(!isDefined(game["dialog"]["halfway_enemy_score"])) {
      game["dialog"]["halfway_enemy_score"] = "z082";
    }

    if(!isDefined(game["dialog"]["halfway_enemy_time"])) {
      game["dialog"]["halfway_enemy_time"] = "halfway_enemy_time";
    }

    if(!isDefined(game["dialog"]["halfway_friendly_score"])) {
      game["dialog"]["halfway_friendly_score"] = "z084";
    }

    if(!isDefined(game["dialog"]["halfway_friendly_time"])) {
      game["dialog"]["halfway_friendly_time"] = "halfway_friendly_time";
    }

    if(!isDefined(game["dialog"]["boost"])) {
      game["dialog"]["boost"] = "boost_enemy_inbound";
    }

    if(!isDefined(game["dialog"]["boost_round"])) {
      game["dialog"]["boost"] = "boost_genericround";
    }

    if(!isDefined(game["dialog"]["offense_obj"])) {
      game["dialog"]["offense_obj"] = "z251";
    }

    if(!isDefined(game["dialog"]["defense_obj"])) {
      game["dialog"]["defense_obj"] = "z252";
    }

    game["dialog"]["hardcore"] = "hardcore";
    game["dialog"]["challenge"] = "challengecomplete";
    game["dialog"]["promotion"] = "promotion";
    game["dialog"]["obj_defend"] = "hint_defendobj";
    game["dialog"]["objs_defend"] = "hint_defendobjs";
    game["dialog"]["obj_destroy"] = "hint_destroyobj";
    game["dialog"]["objs_destroy"] = "hint_destroyobjs";
    game["dialog"]["obj_capture"] = "hint_captureobj";
    game["dialog"]["objs_capture"] = "hint_captureobjs";
    game["dialog"]["obj_generic_capture"] = "hint_generic_captureobj";
    game["dialog"]["hint_fightback"] = "hint_fightback";
    game["dialog"]["captured_all_enemy"] = "z073";
    game["dialog"]["captured_all_friendly"] = "z074";
    game["dialog"]["enemy_zone_control"] = "enemy_zone_control";
    game["dialog"]["friendly_zone_control"] = "friendly_zone_control";
    game["music"]["nuke_music"] = "nuke_music";
    game["dialog"]["ti_spawn"] = "mp_glob_fdup_bchr_uti2";
    game["dialog"]["ti_destroyed"] = "mp_glob_fdup_bchr_tinl";
    game["dialog"]["dd_destroyed"] = "mp_glob_fdup_bchr_udd3";
    game["dialog"]["fm_destroyed_s"] = "mp_glob_fdup_bchr_ufm4";
    game["dialog"]["fm_destroyed_m"] = "mp_glob_fdup_bchr_ufm5";
    game["dialog"]["fm_hijacked_s"] = "mp_glob_fdup_bchr_ufm6";
    game["dialog"]["fm_hijacked_m"] = "mp_glob_fdup_bchr_ufm7";
    game["dialog"]["ja_destroyed_s"] = "mp_glob_fdup_bchr_uja4";
    game["dialog"]["ja_destroyed_m"] = "mp_glob_fdup_bchr_uja5";
    game["dialog"]["ja_hijacked_s"] = "mp_glob_fdup_bchr_uja6";
    game["dialog"]["ja_hijacked_m"] = "mp_glob_fdup_bchr_uja7";
    game["dialog"]["sb_destroyed_s"] = "mp_glob_fdup_bchr_usb5";
    game["dialog"]["sb_destroyed_m"] = "mp_glob_fdup_bchr_usb6";
    game["dialog"]["dc_damaged"] = "mp_glob_fdup_bchr_udc3";
    game["dialog"]["dc_destroyed_s"] = "mp_glob_fdup_bchr_udc5";
    game["dialog"]["dc_destroyed_m"] = "mp_glob_fdup_bchr_udc6";
    game["dialog"]["gt_enemy_use"] = "mp_glob_fdup_bchr_ugt3";
    game["dialog"]["gt_destroyed"] = "mp_glob_fdup_bchr_ugt4";
    game["dialog"]["sm_destroyed_s"] = "mp_glob_eqip_bchr_stu2";
    game["dialog"]["sm_destroyed_m"] = "mp_glob_eqip_bchr_stu3";
    game["dialog"]["sm_hijacked_s"] = "mp_glob_eqip_bchr_stu4";
    game["dialog"]["sm_hijacked_m"] = "mp_glob_eqip_bchr_stu5";
    game["dialog"]["revived"] = "revived_generic";
    game["dialog"]["enemy_exfil"] = "exfilstart_enemy_10";
    game["dialog"]["friendly_exfil"] = "exfilstart_friendly_10";
    game["dialog"]["exfilarrive_enemy"] = "exfilarrive_enemy_20";
    game["dialog"]["exfilarrive_friendly"] = "exfilarrive_friendly_20";
    game["dialog"]["exfilend_enemy"] = "exfilend_enemy_10";
    game["dialog"]["exfilend_friendly"] = "exfilend_friendly_10";
    game["dialog"]["enemy_ident"] = "frontline_enemy_ident";
    game["dialog"]["target_ident"] = "frontline_target_ident";
    game["dialog"]["jackal_use"] = "op_jackal_use";
    game["dialog"]["jackal_fire"] = "op_jackal_fire";
    game["dialog"]["jackal_guard"] = "op_jackal_guard";
    game["dialog"]["jackal_follow"] = "op_jackal_follow";
    game["dialog"]["jackal_target_dead"] = "op_jackal_target_dead";
    game["dialog"]["jackal_target_lost"] = "op_jackal_target_lost";
    game["dialog"]["jackal_end"] = "op_jackal_end";
    game["dialog"]["jackal_destroyed"] = "op_jackal_destroyed";
    game["dialog"]["doublekill"] = "mp_glob_rpkc_bchr_doublekill";
    game["dialog"]["triplekill"] = "mp_glob_rpkc_bchr_triplekill";
    game["dialog"]["furykill"] = "mp_glob_rpkc_bchr_furykill";
    game["dialog"]["superkill"] = "mp_glob_rpkc_bchr_superkill";
    game["dialog"]["megakill"] = "mp_glob_rpkc_bchr_megakill";
    game["dialog"]["ultrakill"] = "mp_glob_rpkc_bchr_ultrakill";
    game["dialog"]["rabidkill"] = "mp_glob_rpkc_bchr_rabidkill";
    game["dialog"]["bloodthristy"] = "mp_glob_rpkc_bchr_bloodthristy";
    game["dialog"]["merciless"] = "mp_glob_rpkc_bchr_merciless";
    game["dialog"]["ruthless"] = "mp_glob_rpkc_bchr_ruthless";
    game["dialog"]["relenteless"] = "mp_glob_rpkc_bchr_relentless";
    game["dialog"]["brutal"] = "mp_glob_rpkc_bchr_brutal";
    game["dialog"]["atomic"] = "mp_glob_rpkc_bchr_atomic";
    game["dialog"]["insane"] = "mp_glob_rpkc_bchr_insane";
    game["dialog"]["goliath_detonate"] = "mp_glob_goli_bchr_gdet";
    game["dialog"]["goliath_kill_1"] = "mp_glob_goli_bchr_godk";
    game["dialog"]["goliath_kill_2"] = "mp_glob_goli_bchr_gdk2";
    game["dialog"]["goliath_kill_3"] = "mp_glob_goli_bchr_gdk3";
  }

  if(!isDefined(game["dialog"]["mission_success"])) {
    game["dialog"]["mission_success"] = "z277";
  }

  if(!isDefined(game["dialog"]["mission_failure"])) {
    game["dialog"]["mission_failure"] = "z276";
  }

  if(!isDefined(game["dialog"]["mission_draw"])) {
    game["dialog"]["mission_draw"] = "draw";
  }

  game["dialog"]["round_success"] = "z273";
  game["dialog"]["round_failure"] = "z272";
  game["dialog"]["round_draw"] = "draw";

  if(scripts\mp\utility\game::_id_8701()) {
    _id_1EB2();
  }

  _id_0AA3::_id_C28D(::onplayerspawned);
  level thread onplayerconnect();
  level thread _id_AB1D();
  level thread _id_A35D();
  level thread _id_AAF6();
  level thread _id_AB93();
}

_id_1EB2() {
  if(scripts\engine\utility::is_equal(level.gametype, "dom")) {
    game["dialog"]["lost_a"] = "alsa";
    game["dialog"]["lost_b"] = "alsb";
    game["dialog"]["lost_c"] = "alsc";
    game["dialog"]["captured_all_friendly"] = "adom";
    game["dialog"]["secured_a"] = "aona";
    game["dialog"]["secured_b"] = "aonb";
    game["dialog"]["secured_c"] = "aonc";
    game["dialog"]["securing_a"] = "atka";
    game["dialog"]["securing_b"] = "atkb";
    game["dialog"]["securing_c"] = "atkc";
    game["dialog"]["captured_all_enemy"] = "edom";
    game["dialog"]["losing_a"] = "etka";
    game["dialog"]["losing_b"] = "etkb";
    game["dialog"]["losing_c"] = "etkc";
    _id_AD32("obj_defend", "aobj", "gmst");
    _id_AD32("objs_defend", "dobj", "gmst");
    var_0 = getdvarint("#x3db5d3184a15d696d", 0);
    _id_AD32("gametype", "dmin", "gmit");

    if(var_0 > 10) {
      game["dialog"]["gametype"] = "i1in";
    }

    if(var_0 > 13) {
      game["dialog"]["gametype"] = "i2in";
    }

    if(var_0 > 15) {
      game["dialog"]["gametype"] = "i3in";
    }

    if(var_0 > 17) {
      game["dialog"]["gametype"] = "i4in";
    }

    if(var_0 > 20) {
      game["dialog"]["gametype"] = "i5in";
    }

    _id_AD32("mission_success", "dwin", "gmst");
    _id_AD32("mission_failure", "dlos", "gmst");
  }

  if(scripts\engine\utility::is_equal(level.gametype, "war")) {
    _id_AD32("mission_success", "tdmw", "tmdm");
    _id_AD32("mission_failure", "tdml", "tmdm");
    var_0 = getdvarint("#x3db5d3184a15d696d", 0);
    _id_AD32("gametype", "tdin", "gmit");

    if(var_0 > 10) {
      game["dialog"]["gametype"] = "i1in";
    }

    if(var_0 > 13) {
      game["dialog"]["gametype"] = "i2in";
    }

    if(var_0 > 15) {
      game["dialog"]["gametype"] = "i3in";
    }

    if(var_0 > 17) {
      game["dialog"]["gametype"] = "i4in";
    }

    if(var_0 > 20) {
      game["dialog"]["gametype"] = "i5in";
    }
  }

  _id_AD32("gamestate_domlosing", "dadv", "gmst");
  _id_AD32("gamestate_domwinning", "adva", "gmst");
  _id_AD32("mission_draw", "draw", "gmst");
  _id_AD32("ti_destroyed", "tinl", "gmst");
  _id_AD32("halftime", "half", "gmst");
  _id_AD32("overtime", "over", "gmst");
  _id_AD32("obj_generic_capture", "sobj", "gmst");
  _id_AD32("losing_time", "fght", "gmst");
  _id_AD32("losing_score", "fght", "gmst");
  _id_AD32("doublekill", "doublekill", "rpkc");
  _id_AD32("triplekill", "triplekill", "rpkc");
  _id_AD32("furykill", "furykill", "rpkc");
  _id_AD32("frenzykill", "frenzykill", "rpkc");
  _id_AD32("superkill", "superkill", "rpkc");
  _id_AD32("ultrakill", "ultrakill", "rpkc");
  _id_AD32("rabidkill", "rabidkill", "rpkc");
  _id_AD32("bloodthristy", "bloodthristy", "rpkc");
  _id_AD32("merciless", "merciless", "rpkc");
  _id_AD32("ruthless", "ruthless", "rpkc");
  _id_AD32("brutal", "brutal", "rpkc");
  _id_AD32("insane", "insane", "rpkc");
  _id_AD32("goliath_detonate", "gdet", "goli");
  _id_AD32("goliath_kill_1", "godk", "goli");
  _id_AD32("goliath_kill_2", "gdk2", "goli");
  _id_AD32("goliath_kill_3", "gdk3", "goli");
}

_id_AD32(var_0, var_1, var_2) {
  if(!isDefined(level._id_490C)) {
    level._id_490C = [];
  }

  if(!isDefined(level._id_490C[var_1])) {
    level._id_490C[var_1] = [];
  }

  level._id_490C[var_1] = var_2;
  game["dialog"][var_0] = var_1;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_B83B();
    var_0 thread _id_10B80();
    var_0._id_A417 = 1;

    if(scripts\mp\utility\game::getgametype() == "ftue") {
      var_0 setplayermusicstate(game["music"]["ftue_match_start"][0]);
      continue;
    }

    if(scripts\mp\utility\game::getgametype() == "arena_evo") {
      var_1 = game["music"]["mp_arena_start"].size - 1;
      var_2 = randomint(var_1);
      var_0 setplayermusicstate(game["music"]["mp_arena_start"][var_2]);
    } else if(scripts\mp\utility\game::getgametype() == "sd") {
      var_3 = game["music"]["mp_match_start_general"].size - 1;
      var_2 = randomint(var_3);
      var_0 setplayermusicstate(game["music"]["mp_match_start_general"][var_2]);
      var_4 = 0;
    } else {
      var_3 = game["music"]["mp_match_start_general"].size - 1;
      var_2 = randomint(var_3);
      var_0 setplayermusicstate(game["music"]["mp_match_start_general"][var_2]);
    }
  }
}

onplayerspawned() {
  if(!isai(self) && istrue(self._id_A417)) {
    thread _id_4CFF();
    self._id_A417 = undefined;
  }
}

_id_107E7() {
  level endon("host_migration_begin");
  self endon("disconnect");

  for(;;) {
    if(_id_07D1::_id_60BE("prematch_done")) {
      self notify("luinotifyserver", "matchReady");
      return;
    }

    wait 1;
  }
}

_id_B83B() {
  level endon("host_migration_begin");
  self endon("disconnect");
  var_0 = scripts\mp\utility\game::_id_6DE6() / 1000 + 6;

  if(var_0 >= level._id_BBAD) {
    return;
  }
  if(!level.rankedmatch) {
    return;
  }
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_1 = 0;

  if(!self _meth_81E2() || self _meth_81E3()) {
    if(self.sessionteam == "allies") {
      switch (var_1) {
        case 0:
          self _meth_8610("jtfw_mtc1_un_flyover");
          break;
        case 1:
          self _meth_8610("oi_mtc3_un_flyover");
          break;
        case 2:
          self _meth_8610("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self _meth_8610("wr_mtc5_un_flyover");
          break;
        case 4:
          self _meth_8610("ba_mtc2_un_flyover");
          break;
        default:
          break;
      }
    } else if(self.sessionteam == "axis") {
      switch (var_1) {
        case 0:
          self _meth_8610("jtfw_mtc1_sdf_flyover");
          break;
        case 1:
          self _meth_8610("oi_mtc3_sdf_flyover");
          break;
        case 2:
          self _meth_8610("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self _meth_8610("wr_mtc5_sdf_flyover");
          break;
        case 4:
          self _meth_8610("ba_mtc2_sdf_flyover");
          break;
        default:
          break;
      }
    }
  }
}

_id_4CFF() {
  level endon("host_migration_begin");
  self endon("disconnect");

  while(level._id_7EB0 > 15) {
    waitframe();
  }

  if(!isDefined(level._id_7E80) && scripts\mp\utility\game::_id_EF76(self.team) && game["roundsPlayed"] == 0) {
    level._id_7E80 = 1;
  }

  if(isDefined(game["trial"]) && isDefined(game["trial"]["tries_remaining"]) && game["trial"]["tries_remaining"] < 3) {
    return;
  }
  if(scripts\mp\utility\game::_id_875E() || level.script == "mp_m_speed") {
    var_0 = 0;
  } else {
    var_0 = !_id_07D1::_id_60BE("prematch_done") && (!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::_id_885C());
  }

  if(var_0) {
    thread _id_107E7();

    for(;;) {
      self waittill("luinotifyserver", var_1, var_2);

      if(var_1 == "matchReady") {
        break;
      }
    }
  }

  if(!level.splitscreen && !isDefined(self._id_B397) || level.splitscreen && !isDefined(level._id_B39A)) {
    if(!self _meth_81E2() || self _meth_81E3()) {
      if(isDefined(self.team) && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "ctf" && !scripts\mp\utility\game::_id_875E() && scripts\mp\utility\game::getgametype() != "sd" && scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "cyber" && scripts\mp\utility\game::getgametype() != "siege" && scripts\mp\utility\game::getgametype() != "rugby") {
        var_3 = getDvar("#x376847958d67972ef");

        if(var_3 == "mp_gunsmith_gl") {
          self setplayermusicstate("");
        } else if(self.team == "allies") {
          var_4 = game["music"]["mp_match_start_general"].size - 1;
          var_5 = randomint(var_4);
          self._id_A5E0 = 1;
        } else {
          var_6 = game["music"]["mp_match_start_general"].size - 1;
          var_5 = randomint(var_6);
          self._id_A5E0 = 1;
        }
      }

      if((scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "cyber" || scripts\mp\utility\game::getgametype() == "ctf" || scripts\mp\utility\game::getgametype() == "siege" || scripts\mp\utility\game::getgametype() == "rugby") && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        if(self.team == "allies") {
          var_4 = game["music"]["spawn_allies"].size - 1;
          var_5 = randomint(var_4);
          self._id_A5E0 = 1;
        } else {
          var_6 = game["music"]["spawn_axis"].size - 1;
          var_5 = randomint(var_6);
          self._id_A5E0 = 1;
        }
      }

      if(scripts\mp\utility\game::getgametype() == "arm" && !isDefined(level._id_B39A)) {
        if(self.team == "allies") {
          var_4 = game["music"]["spawn_allies"].size - 1;
          var_5 = randomint(var_4);
          self._id_A5E0 = 1;
        } else {
          var_6 = game["music"]["spawn_axis"].size - 1;
          var_5 = randomint(var_6);
          self._id_A5E0 = 1;
        }
      }

      if(scripts\mp\utility\game::getgametype() == "arena" && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        if(self.team == "allies") {
          var_4 = game["music"]["gunfight_spawn_allies"].size - 1;
          var_5 = randomint(var_4);
        } else {
          var_6 = game["music"]["gunfight_spawn_axis"].size - 1;
          var_5 = randomint(var_6);
        }
      }
    }

    if(level.splitscreen) {
      level._id_B39A = 1;
    }

    thread _id_EBE9(20);
  }

  if(istrue(level._id_7E80)) {
    _id_07D1::_id_60C2("prematch_done");
    wait 1.5;
  }

  if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
    if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies") {
      _id_0A8D::_id_9137("allies_gametype", "gametype");
    } else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis") {
      _id_0A8D::_id_9137("axis_gametype", "gametype");
    } else if(!self _meth_81E2() || self _meth_81E3()) {
      var_7 = 1;

      if(scripts\mp\utility\game::_id_875D()) {} else if(scripts\mp\utility\game::_id_875E()) {
        if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
          var_7 = 1;
        } else if(_id_DB9A() || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] % 2 == 0) {
          var_7 = 0;

          if(game["matchPoint"] != 1 && game["finalRound"] != 1) {
            if(game["roundsPlayed"] % 6 == 0) {
              game["dialog"]["offense_obj"] = "boost_genericround";
              game["dialog"]["defense_obj"] = "boost_genericround";
            }
          }

          if(self.team == game["attackers"]) {
            if(!self _meth_81E2() || self _meth_81E3()) {
              _id_0A8D::_id_9137("offense_obj", "introboost");
            }
          } else if(!self _meth_81E2() || self _meth_81E3())
            _id_0A8D::_id_9137("defense_obj", "introboost");
        } else
          var_7 = 0;
      }

      if(var_7) {
        _id_0A8D::_id_9137("gametype", "gametype");
      }
    }
  }

  _id_07D1::_id_60C2("prematch_done");

  if(scripts\mp\utility\game::_id_875E()) {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      if(self.team == game["attackers"]) {
        if(!self _meth_81E2() || self _meth_81E3()) {
          _id_0A8D::_id_9137("offense_obj", "introboost");
        }
      } else if(!self _meth_81E2() || self _meth_81E3())
        _id_0A8D::_id_9137("defense_obj", "introboost");
    }
  } else {
    if(scripts\mp\utility\game::_id_875D()) {
      return;
    }
    if(self.team == game["attackers"]) {
      if(!self _meth_81E2() || self _meth_81E3()) {
        _id_0A8D::_id_9137("offense_obj", "introboost");
      }
    } else if(!self _meth_81E2() || self _meth_81E3())
      _id_0A8D::_id_9137("defense_obj", "introboost");

    _id_0A8D::_id_9137("matchIntensity", "intensity");
    return;
  }
}

_id_DB9A() {
  if(game["finalRound"] == 1) {
    game["dialog"]["offense_obj"] = "boost_tied_matchpoint";
    game["dialog"]["defense_obj"] = "boost_tied_matchpoint";
    return 1;
  } else if(game["matchPoint"] == 1) {
    var_0 = "";

    foreach(var_2 in level._id_EF89) {
      var_3 = scripts\mp\utility\game::_id_6CFE(var_2);

      if(var_3 == level._id_10E52 - 1) {
        var_0 = var_2;
        break;
      }
    }

    if(game["attackers"] == var_0) {
      game["dialog"]["offense_obj"] = "boost_winning_matchpoint";
      game["dialog"]["defense_obj"] = "boost_losing_matchpoint";
    } else {
      game["dialog"]["offense_obj"] = "boost_losing_matchpoint";
      game["dialog"]["defense_obj"] = "boost_winning_matchpoint";
    }

    return 1;
  }

  return 0;
}

_id_10B80() {
  self endon("disconnect");
  level endon("grace_period_ending");

  for(;;) {
    level waittill("host_migration_begin");
    var_0 = level._id_7EB0;
    level waittill("host_migration_end");

    if(var_0) {
      thread _id_4CFF();
    }
  }
}

_id_AB1D() {
  level endon("game_ended");
  level waittill("last_alive", var_0);

  if(!isalive(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "siege") {
    var_0 _id_0A8D::_id_9137("siege_lastalive_zones", "status");
    level thread _id_AB1D();
    return;
  } else if(scripts\mp\utility\game::getgametype() == "sr" && !level._id_A586) {
    var_0 _id_0A8D::_id_9137("lastalive_revive", "status");
    level thread _id_AB1D();
    return;
  }

  var_0 _id_0A8D::_id_9137("last_alive", "status");
}

_id_AB93() {
  level waittill("round_switch", var_0);

  switch (var_0) {
    case "halftime":
      foreach(var_2 in level.players) {
        if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
          continue;
        }
        var_2 _id_0A8D::_id_9137("halftime", "status");
      }

      break;
    case "overtime":
      foreach(var_2 in level.players) {
        if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
          continue;
        }
        var_2 _id_0A8D::_id_9137("overtime", "status");
      }

      break;
    default:
      if(istrue(level._id_EC31)) {
        foreach(var_2 in level.players) {
          if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
            continue;
          }
          var_2 _id_0A8D::_id_9137("side_switch", "status");
        }

        break;
        return;
      }
  }
}

_id_B932(var_0) {
  if(isDefined(level._id_532A)) {
    return;
  }
  game["music"]["payback_lose"] = [];
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mus_west_defeat";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mus_west_draw";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mus_east_defeat";
  game["music"]["payback_lose"][game["music"]["payback_lose"].size] = "mus_east_draw";
  game["music"]["payback_win"] = [];
  game["music"]["payback_win"][game["music"]["payback_win"].size] = "mus_west_victory";
  game["music"]["payback_win"][game["music"]["payback_win"].size] = "mus_east_victory";
  var_1 = scripts\mp\gamescore::_id_6DD9();

  foreach(var_3 in level.players) {
    var_4 = var_1[var_3.team];

    if(var_4 <= 10) {
      var_5 = game["music"]["payback_win"].size - 1;
    } else {
      var_6 = game["music"]["payback_lose"].size - 1;
    }

    var_3 _meth_867F("mp_matchend_music", 2);
    var_3 enableplayerbreathsystem(0);
  }

  level._id_532A = 1;
}

arena_evo_victory_music(var_0) {
  var_1 = game["music"]["mp_arena_evo_victory"].size - 1;
  var_2 = randomint(var_1);
  var_0 setplayermusicstate(game["music"]["mp_arena_evo_victory"][var_2]);
}

arena_evo_defeat_music(var_0) {
  var_1 = game["music"]["mp_arena_evo_defeat"].size - 1;
  var_2 = randomint(var_1);
  var_0 setplayermusicstate(game["music"]["mp_arena_evo_defeat"][var_2]);
}

arena_evo_draw_music(var_0) {
  var_1 = game["music"]["mp_arena_evo_draw"].size - 1;
  var_2 = randomint(var_1);
  var_0 setplayermusicstate(game["music"]["mp_arena_evo_draw"][var_2]);
}

_id_AAF6() {
  level thread _id_C94E();
  level thread _id_60FD();
  level waittill("start_game_win_audio", var_0);

  if(isDefined(level._id_532A)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::_id_6D9E() != "dmz") {
    return;
  }
  if(level.teambased) {
    if(level.splitscreen) {
      if(var_0 == "allies") {
        foreach(var_2 in level.players) {
          if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
            continue;
          }
          var_2 _meth_867F("mp_matchend_music", 2);

          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_defeat_music(var_2);
            continue;
          }

          var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
        }
      } else if(var_0 == "axis") {
        foreach(var_2 in level.players) {
          if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
            continue;
          }
          var_2 _meth_867F("mp_matchend_music", 2);

          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_victory_music(var_2);
            continue;
          }

          var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
        }
      } else {
        foreach(var_2 in level.players) {
          var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
        }
      }
    } else if(var_0 == "allies") {
      foreach(var_2 in level.players) {
        var_2 _meth_867F("mp_matchend_music", 2);

        if(isDefined(var_2.team) && var_2.team == "allies") {
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_victory_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
          thread arena_evo_defeat_music(var_2);
          continue;
        }

        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
      }
    } else if(var_0 == "axis") {
      foreach(var_2 in level.players) {
        var_2 _meth_867F("mp_matchend_music", 2);

        if(isDefined(var_2.team) && var_2.team == "axis") {
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_victory_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
          thread arena_evo_defeat_music(var_2);
          continue;
        }

        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
      }
    } else {
      foreach(var_2 in level.players) {
        var_2 _meth_867F("mp_matchend_music", 2);

        if(isDefined(var_2.team) && var_2.team == "allies") {
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_draw_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][2]);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
          thread arena_evo_draw_music(var_2);
          continue;
        }

        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][2]);
      }
    }
  } else {
    foreach(var_2 in level.players) {
      var_2 _meth_867F("mp_matchend_music", 2);
      var_2 setplayermusicstate("");

      if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
        continue;
      }
      if(var_2.pers["team"] != "allies" && var_2.pers["team"] != "axis") {
        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][2]);
        continue;
      }

      if(isDefined(var_0) && isPlayer(var_0) && var_2 == var_0) {
        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
        continue;
      }

      if(!level.splitscreen) {
        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
      }
    }
  }

  level._id_532A = 1;
}

_id_C94E() {
  level waittill("round_win", var_0);
  var_1 = level._id_C93E / 4;

  if(var_1 > 0) {
    wait(var_1);
  }

  var_2 = game["teamScores"]["allies"];
  var_3 = game["teamScores"]["axis"];

  if(!isDefined(var_0) || isPlayer(var_0)) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    game["dialog"]["round_success"] = "gamestate_practice_over";
    game["dialog"]["round_failure"] = "gamestate_practice_over";
    game["dialog"]["round_draw"] = "gamestate_practice_over";
  }

  if(var_0 == "allies") {
    _id_0A8D::_id_9136("round_success", "allies");
    _id_0A8D::_id_9136("round_failure", "axis");
  } else if(var_0 == "axis") {
    _id_0A8D::_id_9136("round_success", "axis");
    _id_0A8D::_id_9136("round_failure", "allies");
  } else if(var_3 > var_2) {
    _id_0A8D::_id_9136("round_success", "axis");
    _id_0A8D::_id_9136("round_failure", "allies");
  } else if(var_2 > var_3) {
    _id_0A8D::_id_9136("round_success", "allies");
    _id_0A8D::_id_9136("round_failure", "axis");
  } else {
    _id_0A8D::_id_9136("round_draw", "allies");
    _id_0A8D::_id_9136("round_draw", "axis");
  }
}

_id_60FD() {
  level waittill("start_game_win_audio", var_0);
  var_1 = level._id_BA5A / 2;

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }
  if(isPlayer(var_0) && !level.teambased) {
    for(var_2 = 0; var_2 < level._id_B16C["all"].size; var_2++) {
      var_3 = level._id_B16C["all"][var_2];

      if(var_3 _meth_81E2() && !var_3 _meth_81E3()) {
        continue;
      }
      if(var_2 < 3) {
        var_3 _id_0A8D::_id_9137("mission_success");
        continue;
      }

      var_3 _id_0A8D::_id_9137("mission_failure");
    }
  } else if(var_0 == "allies") {
    _id_0A8D::_id_9136("mission_success", "allies");
    _id_0A8D::_id_9136("mission_failure", "axis");
  } else if(var_0 == "axis") {
    _id_0A8D::_id_9136("mission_success", "axis");
    _id_0A8D::_id_9136("mission_failure", "allies");
  } else {
    _id_0A8D::_id_9136("mission_draw", "axis");
    _id_0A8D::_id_9136("mission_draw", "allies");
  }
}

_id_A35D() {
  level endon("game_ended");
  level._id_A35E = 1;
  level waittill("match_ending_soon", var_0);

  if(level._id_C943 == 1 || game["roundsPlayed"] == level._id_C943 - 1 || scripts\mp\utility\game::_id_8935()) {
    if(!level.splitscreen) {
      if(var_0 == "time") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(_id_893D()) {
              thread _id_F219("allies");
            }

            _id_0A8D::_id_9136("winning_time", "allies", "score");
            _id_0A8D::_id_9136("losing_time", "axis", "score");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(_id_893D()) {
              thread _id_F219("axis");
            }

            _id_0A8D::_id_9136("winning_time", "axis", "score");
            _id_0A8D::_id_9136("losing_time", "allies", "score");
          } else
            thread _id_F219("draw");
        } else if(_id_893D()) {
          var_1 = game["music"]["mp_match_closing"].size - 1;
          var_2 = game["music"]["mp_match_closing"].size - 1;

          foreach(var_4 in level.players) {
            if(var_4.team == "allies") {
              var_4 setplayermusicstate(game["music"]["mp_match_closing"][0]);
              continue;
            }

            var_4 setplayermusicstate(game["music"]["mp_match_closing"][1]);
          }
        }
      } else if(var_0 == "score") {
        if(level.teambased && !scripts\mp\utility\game::_id_875E()) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(_id_893D()) {
              foreach(var_4 in level.players) {
                if(var_4.team == "allies") {
                  var_4 setplayermusicstate(game["music"]["mp_match_closing"][0]);
                  continue;
                }

                var_4 setplayermusicstate(game["music"]["mp_match_closing"][1]);
              }
            }

            _id_0A8D::_id_9136("winning_score", "allies", "score");
            _id_0A8D::_id_9136("losing_score", "axis", "score");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(_id_893D()) {
              foreach(var_4 in level.players) {
                if(var_4.team == "allies") {
                  var_4 setplayermusicstate(game["music"]["mp_match_closing"][1]);
                  continue;
                }

                var_4 setplayermusicstate(game["music"]["mp_match_closing"][0]);
              }
            }

            _id_0A8D::_id_9136("winning_score", "axis", "score");
            _id_0A8D::_id_9136("losing_score", "allies", "score");
          } else if(_id_893D()) {
            foreach(var_4 in level.players) {
              var_4 setplayermusicstate(game["music"]["mp_match_closing"][1]);
            }
          }
        } else {
          var_12 = scripts\mp\gamescore::_id_6A9E();
          var_13 = scripts\mp\gamescore::_id_6B26();

          if(_id_893D()) {
            var_12 setplayermusicstate(game["music"]["mp_match_closing"][0]);

            foreach(var_15 in level.players) {
              if(var_15 == var_12) {
                continue;
              }
              var_15 setplayermusicstate(game["music"]["mp_match_closing"][1]);
            }
          }

          var_12 _id_0A8D::_id_9137("winning_score");
          _id_0A8D::_id_9139("losing_score", var_13);
        }
      }
    }
  } else if(!level._id_74C4 && !scripts\mp\utility\game::_id_875E()) {
    foreach(var_4 in level.players) {
      var_4 setplayermusicstate("");
    }
  }
}

_id_9BC3(var_0) {
  var_0 endon("disconnect");
  wait 10;
  var_1 = game["music"]["mp_arena_round_over"].size - 1;
  level.roundmusicnum = randomint(var_1);
  var_0 setplayermusicstate(game["music"]["mp_arena_round_over"][level.roundmusicnum]);
}

matchbeginmusicfromcountdown(var_0) {
  if(!isDefined(level.roundmusicnum)) {
    level.roundmusicnum = 0;
  } else {
    var_0 setplayermusicstate(game["music"]["mp_arena_round_start"][level.roundmusicnum]);
  }
}

_id_9BC2(var_0, var_1) {
  if(scripts\mp\utility\game::_id_875E()) {
    if(isDefined(var_1) && !isDefined(level._id_A661) && var_1 <= 10) {
      level._id_A661 = 1;
      var_0 = "timesup_ten";
    } else if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 1 || game["launchChunkRuleSet"] == 2) {
        return 0;
      }
    } else
      return 0;
  }

  if(level.teambased) {
    foreach(var_3 in level._id_EF89) {
      if(var_3 != "spectator") {
        _id_0A8D::_id_9136(var_0, var_3);
      }
    }
  } else {
    var_5 = [];

    foreach(var_7 in level.players) {
      if(var_7.team != "spectator") {
        var_5[var_5.size] = var_7;
      }
    }

    _id_0A8D::_id_9139(var_0, var_5);
  }

  return 1;
}

_id_F219(var_0) {
  self endon("game_ended");
  level notify("stop_suspense_music");

  if(!scripts\mp\utility\game::_id_875E() && !scripts\mp\utility\game::_id_875D()) {
    if(var_0 == "allies") {
      var_1 = game["music"]["mp_match_closing"].size - 1;
      var_2 = game["music"]["mp_match_closing"].size - 1;

      foreach(var_4 in level.players) {
        if(var_4.team == "allies") {
          var_5 = randomint(var_2);
          var_4 setplayermusicstate(game["music"]["mp_match_closing"][var_5]);
          continue;
        }

        var_5 = randomint(var_1);
        var_4 setplayermusicstate(game["music"]["mp_match_closing"][var_5]);
      }
    } else if(var_0 == "axis") {
      var_1 = game["music"]["mp_match_closing"].size - 1;
      var_2 = game["music"]["mp_match_closing"].size - 1;

      foreach(var_4 in level.players) {
        if(var_4.team == "allies") {
          var_5 = randomint(var_2);
          var_4 setplayermusicstate(game["music"]["mp_match_closing"][var_5]);
          continue;
        }

        var_5 = randomint(var_1);
        var_4 setplayermusicstate(game["music"]["mp_match_closing"][var_5]);
      }
    } else {
      var_1 = game["music"]["mp_match_closing"].size - 1;
      var_2 = game["music"]["mp_match_closing"].size - 1;

      foreach(var_4 in level.players) {
        if(var_4.team == "allies") {
          var_5 = randomint(var_2);
          var_4 setplayermusicstate(game["music"]["mp_match_closing"][var_5]);
          continue;
        }

        var_5 = randomint(var_1);
        var_4 setplayermusicstate(game["music"]["mp_match_closing"][var_5]);
      }
    }
  }
}

_id_EBE8(var_0) {
  if(!_id_893D()) {
    return;
  }
  var_1 = getDvar("#x376847958d67972ef");

  if(var_1 == "mp_gunsmith_gl") {
    return;
  }
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("stop_suspense_music");

  if(isDefined(level._id_A5E0) && level._id_A5E0) {
    return;
  }
  var_2 = game["music"]["allies_suspense"].size - 1;
  var_3 = game["music"]["axis_suspense"].size - 1;
  level._id_421E = [];
  level._id_421E["allies"] = randomint(var_2);
  level._id_421E["axis"] = randomint(var_3);

  if(isDefined(var_0) && var_0) {
    wait 120;
  }

  for(;;) {
    wait(randomfloatrange(75, 120));

    if(isDefined(level._id_A5E0) && level._id_A5E0) {
      return;
    }
    level._id_421E["allies"] = randomint(var_2);
    level._id_421E["axis"] = randomint(var_3);

    if(!istrue(game["inLiveLobby"])) {
      foreach(var_5 in level.players) {
        if(!isDefined(var_5._id_A5E0)) {
          var_6 = var_5.team;
        }
      }
    }
  }
}

_id_EBE9(var_0) {
  wait(var_0);
  self._id_A5E0 = undefined;
}

_id_893D() {
  return !level._id_74C4 && level._id_A35E > 0;
}

aud_infil_start() {
  foreach(var_1 in level.players) {
    var_1 _meth_867F("mp_intro_infil");
  }
}

aud_infil_end() {
  foreach(var_1 in level.players) {
    var_1 _meth_8680("mp_intro_infil", 2);
  }
}

killstreak_warmachine_music() {
  if(self _meth_871D() == 1) {
    self setplayermusicstate(game["music"]["mp_ks_warmachine_stinger"][0]);
    scripts\engine\utility::_id_10888(self, "death", level, "start_game_win_audio", level, "round_end_music");
    self _meth_87CA(game["music"]["mp_ks_warmachine_stinger"][0]);
  }
}

killstreak_lmg_music() {
  if(self _meth_871D() == 1) {
    var_0 = game["music"]["mp_ks_lmg_stinger"].size - 1;
    var_1 = randomint(var_0);
    self setplayermusicstate(game["music"]["mp_ks_lmg_stinger"][var_1]);
    scripts\engine\utility::_id_10888(self, "death", level, "start_game_win_audio", level, "round_end_music");
    self _meth_87CA(game["music"]["mp_ks_lmg_stinger"][var_1]);
  }
}

killstreak_flamethrower_music() {
  var_0 = self _meth_871D();

  if(var_0 == 1) {
    scripts\engine\utility::_id_5C11("mus_flame_stop");
    var_1 = 1;
    var_2 = 0;
    self setplayermusicstate(game["music"]["mp_ks_flamethrower_intro"][0]);
    thread killstreak_flamethrower_music_watcher();

    while(var_2 != 5.0) {
      if(scripts\engine\utility::_id_5C00("mus_flame_stop")) {
        var_1 = 0;
      }

      wait 0.2;
      var_2 = var_2 + 0.2;
    }

    if(var_1 == 0) {
      self _meth_87CA(game["music"]["mp_ks_flamethrower_intro"][0]);
      var_1 = 1;
    } else {
      self setplayermusicstate(game["music"]["mp_ks_flamethrower_loop"][0]);
      scripts\engine\utility::_id_10888(self, "death", level, "start_game_win_audio", level, "round_end_music");
      self _meth_87CA(game["music"]["mp_ks_flamethrower_loop"][0]);
      wait 1;
      self setplayermusicstate(game["music"]["mp_ks_flamethrower_outro"][0]);
    }
  }
}

killstreak_flamethrower_music_watcher() {
  scripts\engine\utility::_id_5C04("mus_flame_stop");
  scripts\engine\utility::_id_10888(self, "death", level, "start_game_win_audio", level, "round_end_music");
  scripts\engine\utility::_id_5C1B("mus_flame_stop");
}

matchpostflow() {
  if(scripts\mp\utility\game::getgametype() != "sd") {
    var_0 = game["music"]["mp_match_postflow"].size - 1;
    var_1 = randomint(var_0);
    _func_01E3(game["music"]["mp_match_postflow"][var_1]);
  }
}

ftue_fade_music() {
  self _meth_87CA(game["music"]["ftue_match_start"][0]);
}

sd_round_end_music(var_0) {
  if(level.teambased) {
    if(level.splitscreen) {
      if(var_0 == "allies") {
        foreach(var_2 in level.players) {
          if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
            continue;
          }
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_defeat_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
          }

          var_2 _meth_867F("mp_matchend_music", 2);
        }
      } else if(var_0 == "axis") {
        foreach(var_2 in level.players) {
          if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
            continue;
          }
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_victory_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
          }

          var_2 _meth_867F("mp_matchend_music", 2);
        }
      } else {
        foreach(var_2 in level.players) {
          var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
        }
      }
    } else if(var_0 == "allies") {
      foreach(var_2 in level.players) {
        var_2 _meth_867F("mp_matchend_music", 2);

        if(isDefined(var_2.team) && var_2.team == "allies") {
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_victory_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
          thread arena_evo_defeat_music(var_2);
          continue;
        }

        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
      }
    } else if(var_0 == "axis") {
      foreach(var_2 in level.players) {
        var_2 _meth_867F("mp_matchend_music", 2);

        if(isDefined(var_2.team) && var_2.team == "axis") {
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_victory_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][1]);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
          thread arena_evo_defeat_music(var_2);
          continue;
        }

        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][0]);
      }
    } else {
      foreach(var_2 in level.players) {
        var_2 _meth_867F("mp_matchend_music", 2);

        if(isDefined(var_2.team) && var_2.team == "allies") {
          if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
            thread arena_evo_draw_music(var_2);
          } else {
            var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][2]);
          }

          continue;
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" || scripts\mp\utility\game::getgametype() == "sd") {
          thread arena_evo_draw_music(var_2);
          continue;
        }

        var_2 setplayermusicstate(game["music"]["mp_match_winners_circle"][2]);
      }
    }
  }
}

base_overtime_music_start() {
  foreach(var_1 in level.players) {
    var_1 setplayermusicstate(game["music"]["mp_ar_overtime_start"][0]);
  }
}

base_overtime_music_stop() {
  foreach(var_1 in level.players) {
    var_1 _meth_87CA(game["music"]["mp_ar_overtime_start"][0]);
  }
}