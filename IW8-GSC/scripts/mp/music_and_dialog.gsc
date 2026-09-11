/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\music_and_dialog.gsc
***********************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("music", "isBRSuspenseMusicEnabled", &tutorialprint_number);
  scripts\cp_mp\utility\script_utility::registersharedfunc("music", "getMusicSet", &reset_attack_next_available_time);
  scripts\cp_mp\utility\script_utility::registersharedfunc("music", "getRandomMusicSet", &risk_flagspawnshiftingcenter);

  if(istrue(game["isLaunchChunk"])) {
    var0 = "ustl";
  } else {
    var0 = "uktl";
  }

  if(isDefined(level.alliessquadleader)) {
    var0 = level.alliessquadleader;
  }

  var1 = "rutl";

  if(isDefined(level.axissquadleader)) {
    var1 = level.axissquadleader;
  }

  game["voice"]["allies"] = var0;
  game["voice"]["axis"] = var1;

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    traceselectedmaplocation();
  } else if(!isDefined(game["music"])) {
    game["music"]["allies_used_nuke"] = "mus_us_nuke_fired";
    game["music"]["allies_hit_by_nuke"] = "mus_us_nuke_hit";
    game["music"]["draw_allies"] = "mus_west_draw";
    game["music"]["spawn_axis"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_1";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_2";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_3";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_easterneurope_east_static_4";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_middleeast_east_static_1";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_middleeast_east_static_2";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_middleeast_east_static_3";
    } else {
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_1";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_2";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_3";
      game["music"]["spawn_axis"][game["music"]["spawn_axis"].size] = "mus_infil_england_east_static_4";
    }

    game["music"]["defeat_axis"] = "mus_east_defeat";
    game["music"]["defeat_axis_fade"] = "mus_east_defeat_fade";
    game["music"]["victory_axis"] = "mus_east_victory";
    game["music"]["victory_axis_fade"] = "mus_east_victory_fade";
    game["music"]["winning_axis"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_1";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_2";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_3";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_4";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_5";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_middleeast_winning_1";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_middleeast_winning_2";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_middleeast_winning_3";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_middleeast_winning_4";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_middleeast_winning_5";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_middleeast_winning_6";
    } else {
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_england_winning_1";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_england_winning_2";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_england_winning_3";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_england_winning_4";
      game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_england_winning_5";
    }

    game["music"]["roundwin_axis"] = [];
    game["music"]["roundwin_axis"][game["music"]["roundwin_axis"].size] = "mp_cyber_attack_roundwin_aq";
    game["music"]["roundwin_axis"][game["music"]["roundwin_axis"].size] = "mp_cyber_attack_roundwin_aq2";
    game["music"]["roundwin_axis"][game["music"]["roundwin_axis"].size] = "mp_cyber_attack_roundwin_aq3";
    game["music"]["roundwin_axis"][game["music"]["roundwin_axis"].size] = "mp_cyber_attack_roundwin_aq4";
    game["music"]["roundloss_axis"] = [];
    game["music"]["roundloss_axis"][game["music"]["roundloss_axis"].size] = "mp_cyber_attack_roundloss_aq";
    game["music"]["roundloss_axis"][game["music"]["roundloss_axis"].size] = "mp_cyber_attack_roundloss_aq2";
    game["music"]["roundloss_axis"][game["music"]["roundloss_axis"].size] = "mp_cyber_attack_roundloss_aq3";
    game["music"]["roundloss_axis"][game["music"]["roundloss_axis"].size] = "mp_cyber_attack_roundloss_aq4";
    game["music"]["roundloss_axis"][game["music"]["roundloss_axis"].size] = "mp_cyber_attack_roundloss_aq5";
    game["music"]["roundloss_axis"][game["music"]["roundloss_axis"].size] = "mp_cyber_attack_roundloss_aq6";
    game["music"]["losing_axis"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_1";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_2";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_3";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_4";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_5";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_6";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_7";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_middleeast_losing_1";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_middleeast_losing_2";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_middleeast_losing_3";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_middleeast_losing_4";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_middleeast_losing_5";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_middleeast_losing_6";
    } else {
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_england_losing_1";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_england_losing_2";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_england_losing_3";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_england_losing_4";
      game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_england_losing_5";
    }

    game["music"]["spawn_allies"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_1";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_2";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_3";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_easterneurope_west_static_4";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_middleeast_west_static_1";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_middleeast_west_static_2";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_middleeast_west_static_3";
    } else {
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_england_west_static_1";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_england_west_static_2";
      game["music"]["spawn_allies"][game["music"]["spawn_allies"].size] = "mus_infil_england_west_static_3";
    }

    game["music"]["defeat_allies"] = "mus_west_defeat";
    game["music"]["victory_allies"] = "mus_west_victory";
    game["music"]["defeat_allies_fade"] = "mus_west_defeat_fade";
    game["music"]["victory_allies_fade"] = "mus_west_victory_fade";
    game["music"]["winning_allies"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_1";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_2";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_3";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_4";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_5";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_middleeast_winning_1";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_middleeast_winning_2";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_middleeast_winning_3";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_middleeast_winning_4";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_middleeast_winning_5";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_middleeast_winning_6";
    } else {
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_england_winning_1";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_england_winning_2";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_england_winning_3";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_england_winning_4";
      game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_england_winning_5";
    }

    game["music"]["roundloss_allies"] = [];
    game["music"]["roundloss_allies"][game["music"]["roundloss_allies"].size] = "mp_cyber_attack_roundloss_sas";
    game["music"]["roundloss_allies"][game["music"]["roundloss_allies"].size] = "mp_cyber_attack_roundloss_sas2";
    game["music"]["roundloss_allies"][game["music"]["roundloss_allies"].size] = "mp_cyber_attack_roundloss_sas3";
    game["music"]["roundwin_allies"] = [];
    game["music"]["roundwin_allies"][game["music"]["roundwin_allies"].size] = "mp_cyber_attack_roundwin_sas";
    game["music"]["roundwin_allies"][game["music"]["roundwin_allies"].size] = "mp_cyber_attack_roundwin_sas2";
    game["music"]["roundwin_allies"][game["music"]["roundwin_allies"].size] = "mp_cyber_attack_roundwin_sas3";
    game["music"]["roundwin_allies"][game["music"]["roundwin_allies"].size] = "mp_cyber_attack_roundwin_sas4";
    game["music"]["losing_allies"] = [];

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_1";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_2";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_3";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_4";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_5";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_6";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_7";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_middleeast_losing_1";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_middleeast_losing_2";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_middleeast_losing_3";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_middleeast_losing_4";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_middleeast_losing_5";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_middleeast_losing_6";
    } else {
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_england_losing_1";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_england_losing_2";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_england_losing_3";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_england_losing_4";
      game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_england_losing_5";
    }

    game["music"]["midpoint_winning"] = [];

    if(isDefined(level.music_style) && level.music_style == "england") {
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_easterneurope_winning_1";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_easterneurope_winning_2";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_easterneurope_winning_3";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_easterneurope_winning_5";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_middleeast_winning_1";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_middleeast_winning_2";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_middleeast_winning_3";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_middleeast_winning_4";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_middleeast_winning_5";
    } else {
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_england_winning_1";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_england_winning_2";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_england_winning_3";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_england_winning_4";
      game["music"]["midpoint_winning"][game["music"]["midpoint_winning"].size] = "mus_midpoint_england_winning_5";
    }

    game["music"]["midpoint_losing"] = [];

    if(isDefined(level.music_style) && level.music_style == "england") {
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_easterneurope_losing_1";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_easterneurope_losing_2";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_easterneurope_losing_3";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_easterneurope_losing_4";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_easterneurope_losing_5";
    } else if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_middleeast_losing_1";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_middleeast_losing_2";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_middleeast_losing_3";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_middleeast_losing_4";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_middleeast_losing_5";
    } else {
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_england_losing_1";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_england_losing_2";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_england_losing_3";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_england_losing_4";
      game["music"]["midpoint_losing"][game["music"]["midpoint_losing"].size] = "mus_midpoint_england_losing_5";
    }

    foreach(var3 in level.teamnamelist) {
      if(var3 == "axis" || var3 == "allies") {
        continue;
      }

      game["music"]["defeat_" + var3] = "mus_west_defeat";
      game["music"]["victory_" + var3] = "mus_west_victory";
      game["music"]["winning_" + var3] = "mus_west_winning";
      game["music"]["losing_" + var3] = "mus_west_losing";
    }

    game["music"]["snatch_spawn"] = [];
    game["music"]["snatch_spawn"][game["music"]["snatch_spawn"].size] = "mus_infil_easterneurope_animated_1";
    game["music"]["snatch_spawn"][game["music"]["snatch_spawn"].size] = "mus_infil_easterneurope_static_1";
    game["music"]["snatch_spawn"][game["music"]["snatch_spawn"].size] = "mus_infil_england_animated_1";
    game["music"]["snatch_spawn"][game["music"]["snatch_spawn"].size] = "mus_infil_england_static_1";
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
    game["music"]["gunfight_roundwin_early_allies"] = [];
    game["music"]["gunfight_roundwin_early_allies"][game["music"]["gunfight_roundwin_early_allies"].size] = "mp_gunfight_early_win_1";
    game["music"]["gunfight_roundwin_early_allies"][game["music"]["gunfight_roundwin_early_allies"].size] = "mp_gunfight_early_win_2";
    game["music"]["gunfight_roundwin_early_allies"][game["music"]["gunfight_roundwin_early_allies"].size] = "mp_gunfight_early_win_3";
    game["music"]["gunfight_roundwin_early_allies"][game["music"]["gunfight_roundwin_early_allies"].size] = "mp_gunfight_early_win_4";
    game["music"]["gunfight_roundwin_early_allies"][game["music"]["gunfight_roundwin_early_allies"].size] = "mp_gunfight_early_win_5";
    game["music"]["gunfight_roundwin_early_allies"][game["music"]["gunfight_roundwin_early_allies"].size] = "mp_gunfight_early_win_6";
    game["music"]["gunfight_roundloss_early_allies"] = [];
    game["music"]["gunfight_roundloss_early_allies"][game["music"]["gunfight_roundloss_early_allies"].size] = "mp_gunfight_early_lose_1";
    game["music"]["gunfight_roundloss_early_allies"][game["music"]["gunfight_roundloss_early_allies"].size] = "mp_gunfight_early_lose_2";
    game["music"]["gunfight_roundloss_early_allies"][game["music"]["gunfight_roundloss_early_allies"].size] = "mp_gunfight_early_lose_3";
    game["music"]["gunfight_roundloss_early_allies"][game["music"]["gunfight_roundloss_early_allies"].size] = "mp_gunfight_early_lose_4";
    game["music"]["gunfight_roundloss_early_allies"][game["music"]["gunfight_roundloss_early_allies"].size] = "mp_gunfight_early_lose_5";
    game["music"]["gunfight_roundwin_mid_allies"] = [];
    game["music"]["gunfight_roundwin_mid_allies"][game["music"]["gunfight_roundwin_mid_allies"].size] = "mp_gunfight_mid_win_1";
    game["music"]["gunfight_roundwin_mid_allies"][game["music"]["gunfight_roundwin_mid_allies"].size] = "mp_gunfight_mid_win_2";
    game["music"]["gunfight_roundwin_mid_allies"][game["music"]["gunfight_roundwin_mid_allies"].size] = "mp_gunfight_mid_win_3";
    game["music"]["gunfight_roundwin_mid_allies"][game["music"]["gunfight_roundwin_mid_allies"].size] = "mp_gunfight_mid_win_4";
    game["music"]["gunfight_roundwin_mid_allies"][game["music"]["gunfight_roundwin_mid_allies"].size] = "mp_gunfight_mid_win_5";
    game["music"]["gunfight_roundwin_mid_allies"][game["music"]["gunfight_roundwin_mid_allies"].size] = "mp_gunfight_mid_win_6";
    game["music"]["gunfight_roundloss_mid_allies"] = [];
    game["music"]["gunfight_roundloss_mid_allies"][game["music"]["gunfight_roundloss_mid_allies"].size] = "mp_gunfight_mid_lose_1";
    game["music"]["gunfight_roundloss_mid_allies"][game["music"]["gunfight_roundloss_mid_allies"].size] = "mp_gunfight_mid_lose_2";
    game["music"]["gunfight_roundloss_mid_allies"][game["music"]["gunfight_roundloss_mid_allies"].size] = "mp_gunfight_mid_lose_3";
    game["music"]["gunfight_roundloss_mid_allies"][game["music"]["gunfight_roundloss_mid_allies"].size] = "mp_gunfight_mid_lose_4";
    game["music"]["gunfight_roundloss_mid_allies"][game["music"]["gunfight_roundloss_mid_allies"].size] = "mp_gunfight_mid_lose_5";
    game["music"]["gunfight_roundwin_late_allies"] = [];
    game["music"]["gunfight_roundwin_late_allies"][game["music"]["gunfight_roundwin_late_allies"].size] = "mp_gunfight_late_win_1";
    game["music"]["gunfight_roundwin_late_allies"][game["music"]["gunfight_roundwin_late_allies"].size] = "mp_gunfight_late_win_2";
    game["music"]["gunfight_roundwin_late_allies"][game["music"]["gunfight_roundwin_late_allies"].size] = "mp_gunfight_late_win_3";
    game["music"]["gunfight_roundwin_late_allies"][game["music"]["gunfight_roundwin_late_allies"].size] = "mp_gunfight_late_win_4";
    game["music"]["gunfight_roundwin_late_allies"][game["music"]["gunfight_roundwin_late_allies"].size] = "mp_gunfight_late_win_5";
    game["music"]["gunfight_roundwin_late_allies"][game["music"]["gunfight_roundwin_late_allies"].size] = "mp_gunfight_late_win_6";
    game["music"]["gunfight_roundloss_late_allies"] = [];
    game["music"]["gunfight_roundloss_late_allies"][game["music"]["gunfight_roundloss_late_allies"].size] = "mp_gunfight_late_lose_1";
    game["music"]["gunfight_roundloss_late_allies"][game["music"]["gunfight_roundloss_late_allies"].size] = "mp_gunfight_late_lose_2";
    game["music"]["gunfight_roundloss_late_allies"][game["music"]["gunfight_roundloss_late_allies"].size] = "mp_gunfight_late_lose_3";
    game["music"]["gunfight_roundloss_late_allies"][game["music"]["gunfight_roundloss_late_allies"].size] = "mp_gunfight_late_lose_4";
    game["music"]["gunfight_roundloss_late_allies"][game["music"]["gunfight_roundloss_late_allies"].size] = "mp_gunfight_late_lose_5";
    game["music"]["gunfight_roundloss_late_allies"][game["music"]["gunfight_roundloss_late_allies"].size] = "mp_gunfight_late_lose_6";
    game["music"]["gunfight_roundwin_early_axis"] = [];
    game["music"]["gunfight_roundwin_early_axis"][game["music"]["gunfight_roundwin_early_axis"].size] = "mp_gunfight_early_win_1";
    game["music"]["gunfight_roundwin_early_axis"][game["music"]["gunfight_roundwin_early_axis"].size] = "mp_gunfight_early_win_2";
    game["music"]["gunfight_roundwin_early_axis"][game["music"]["gunfight_roundwin_early_axis"].size] = "mp_gunfight_early_win_3";
    game["music"]["gunfight_roundwin_early_axis"][game["music"]["gunfight_roundwin_early_axis"].size] = "mp_gunfight_early_win_4";
    game["music"]["gunfight_roundwin_early_axis"][game["music"]["gunfight_roundwin_early_axis"].size] = "mp_gunfight_early_win_5";
    game["music"]["gunfight_roundwin_early_axis"][game["music"]["gunfight_roundwin_early_axis"].size] = "mp_gunfight_early_win_6";
    game["music"]["gunfight_roundloss_early_axis"] = [];
    game["music"]["gunfight_roundloss_early_axis"][game["music"]["gunfight_roundloss_early_axis"].size] = "mp_gunfight_early_lose_1";
    game["music"]["gunfight_roundloss_early_axis"][game["music"]["gunfight_roundloss_early_axis"].size] = "mp_gunfight_early_lose_2";
    game["music"]["gunfight_roundloss_early_axis"][game["music"]["gunfight_roundloss_early_axis"].size] = "mp_gunfight_early_lose_3";
    game["music"]["gunfight_roundloss_early_axis"][game["music"]["gunfight_roundloss_early_axis"].size] = "mp_gunfight_early_lose_4";
    game["music"]["gunfight_roundloss_early_axis"][game["music"]["gunfight_roundloss_early_axis"].size] = "mp_gunfight_early_lose_5";
    game["music"]["gunfight_roundwin_mid_axis"] = [];
    game["music"]["gunfight_roundwin_mid_axis"][game["music"]["gunfight_roundwin_mid_axis"].size] = "mp_gunfight_mid_win_1";
    game["music"]["gunfight_roundwin_mid_axis"][game["music"]["gunfight_roundwin_mid_axis"].size] = "mp_gunfight_mid_win_2";
    game["music"]["gunfight_roundwin_mid_axis"][game["music"]["gunfight_roundwin_mid_axis"].size] = "mp_gunfight_mid_win_3";
    game["music"]["gunfight_roundwin_mid_axis"][game["music"]["gunfight_roundwin_mid_axis"].size] = "mp_gunfight_mid_win_4";
    game["music"]["gunfight_roundwin_mid_axis"][game["music"]["gunfight_roundwin_mid_axis"].size] = "mp_gunfight_mid_win_5";
    game["music"]["gunfight_roundwin_mid_axis"][game["music"]["gunfight_roundwin_mid_axis"].size] = "mp_gunfight_mid_win_6";
    game["music"]["gunfight_roundloss_mid_axis"] = [];
    game["music"]["gunfight_roundloss_mid_axis"][game["music"]["gunfight_roundloss_mid_axis"].size] = "mp_gunfight_mid_lose_1";
    game["music"]["gunfight_roundloss_mid_axis"][game["music"]["gunfight_roundloss_mid_axis"].size] = "mp_gunfight_mid_lose_2";
    game["music"]["gunfight_roundloss_mid_axis"][game["music"]["gunfight_roundloss_mid_axis"].size] = "mp_gunfight_mid_lose_3";
    game["music"]["gunfight_roundloss_mid_axis"][game["music"]["gunfight_roundloss_mid_axis"].size] = "mp_gunfight_mid_lose_4";
    game["music"]["gunfight_roundloss_mid_axis"][game["music"]["gunfight_roundloss_mid_axis"].size] = "mp_gunfight_mid_lose_5";
    game["music"]["gunfight_roundwin_late_axis"] = [];
    game["music"]["gunfight_roundwin_late_axis"][game["music"]["gunfight_roundwin_late_axis"].size] = "mp_gunfight_late_win_1";
    game["music"]["gunfight_roundwin_late_axis"][game["music"]["gunfight_roundwin_late_axis"].size] = "mp_gunfight_late_win_2";
    game["music"]["gunfight_roundwin_late_axis"][game["music"]["gunfight_roundwin_late_axis"].size] = "mp_gunfight_late_win_3";
    game["music"]["gunfight_roundwin_late_axis"][game["music"]["gunfight_roundwin_late_axis"].size] = "mp_gunfight_late_win_4";
    game["music"]["gunfight_roundwin_late_axis"][game["music"]["gunfight_roundwin_late_axis"].size] = "mp_gunfight_late_win_5";
    game["music"]["gunfight_roundwin_late_axis"][game["music"]["gunfight_roundwin_late_axis"].size] = "mp_gunfight_late_win_6";
    game["music"]["gunfight_roundloss_late_axis"] = [];
    game["music"]["gunfight_roundloss_late_axis"][game["music"]["gunfight_roundloss_late_axis"].size] = "mp_gunfight_late_lose_1";
    game["music"]["gunfight_roundloss_late_axis"][game["music"]["gunfight_roundloss_late_axis"].size] = "mp_gunfight_late_lose_2";
    game["music"]["gunfight_roundloss_late_axis"][game["music"]["gunfight_roundloss_late_axis"].size] = "mp_gunfight_late_lose_3";
    game["music"]["gunfight_roundloss_late_axis"][game["music"]["gunfight_roundloss_late_axis"].size] = "mp_gunfight_late_lose_4";
    game["music"]["gunfight_roundloss_late_axis"][game["music"]["gunfight_roundloss_late_axis"].size] = "mp_gunfight_late_lose_5";
    game["music"]["gunfight_roundloss_late_axis"][game["music"]["gunfight_roundloss_late_axis"].size] = "mp_gunfight_late_lose_6";
    game["music"]["dominated_axis"] = [];
    game["music"]["dominated_axis"][game["music"]["dominated_axis"].size] = "east_dominated_1";
    game["music"]["dominated_axis"][game["music"]["dominated_axis"].size] = "east_dominated_2";
    game["music"]["dominated_axis"][game["music"]["dominated_axis"].size] = "east_dominated_4";
    game["music"]["dominated_axis"][game["music"]["dominated_axis"].size] = "east_dominated_5";
    game["music"]["dominated_axis"][game["music"]["dominated_axis"].size] = "east_dominated_6";
    game["music"]["dominated_axis"][game["music"]["dominated_axis"].size] = "east_dominated_7";
    game["music"]["dominating_axis"] = [];

    if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["dominating_axis"][game["music"]["dominating_axis"].size] = "east_dominating_2";
    }

    game["music"]["dominating_axis"][game["music"]["dominating_axis"].size] = "east_dominating_1";
    game["music"]["dominating_axis"][game["music"]["dominating_axis"].size] = "east_dominating_3";
    game["music"]["dominating_axis"][game["music"]["dominating_axis"].size] = "east_dominating_4";
    game["music"]["dominating_axis"][game["music"]["dominating_axis"].size] = "east_dominating_5";
    game["music"]["dominating_axis"][game["music"]["dominating_axis"].size] = "east_dominating_6";
    game["music"]["dominated_allies"] = [];
    game["music"]["dominated_allies"][game["music"]["dominated_allies"].size] = "west_dominated_1";
    game["music"]["dominated_allies"][game["music"]["dominated_allies"].size] = "west_dominated_2";
    game["music"]["dominated_allies"][game["music"]["dominated_allies"].size] = "west_dominated_3";
    game["music"]["dominated_allies"][game["music"]["dominated_allies"].size] = "west_dominated_4";
    game["music"]["dominated_allies"][game["music"]["dominated_allies"].size] = "west_dominated_5";
    game["music"]["dominating_allies"] = [];
    game["music"]["dominating_allies"][game["music"]["dominating_allies"].size] = "west_dominating_1";
    game["music"]["dominating_allies"][game["music"]["dominating_allies"].size] = "west_dominating_2";
    game["music"]["dominating_allies"][game["music"]["dominating_allies"].size] = "west_dominating_4";
    game["music"]["dominating_allies"][game["music"]["dominating_allies"].size] = "west_dominating_5";
    game["music"]["dominating_allies"][game["music"]["dominating_allies"].size] = "west_dominating_6";
    game["music"]["bombplant"] = [];

    if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_middleeast_1";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_middleeast_2";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_middleeast_3";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_middleeast_4";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_middleeast_5";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_middleeast_6";
    } else if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_1";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_2";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_3";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_4";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_5";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_6";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_7";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_easterneurope_8";
    } else {
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_england_1";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_england_2";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_england_3";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_england_4";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_england_5";
      game["music"]["bombplant"][game["music"]["bombplant"].size] = "mp_bombplant_england_6";
    }

    game["music"]["bombplant_30"] = [];

    if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_middleeast_30_1";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_middleeast_30_2";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_middleeast_30_3";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_middleeast_30_4";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_middleeast_30_5";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_middleeast_30_6";
    } else if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_1";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_2";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_3";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_4";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_5";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_6";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_easterneurope_30_7";
    } else {
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_england_30_1";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_england_30_2";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_england_30_3";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_england_30_4";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_england_30_5";
      game["music"]["bombplant_30"][game["music"]["bombplant_30"].size] = "mp_bombplant_england_30_6";
    }

    game["music"]["hq_new"] = [];
    game["music"]["hq_new"][game["music"]["hq_new"].size] = "mp_hq_new_1";
    game["music"]["hq_new"][game["music"]["hq_new"].size] = "mp_hq_new_2";
    game["music"]["hq_new"][game["music"]["hq_new"].size] = "mp_hq_new_3";
    game["music"]["hq_new"][game["music"]["hq_new"].size] = "mp_hq_new_4";
    game["music"]["hq_new"][game["music"]["hq_new"].size] = "mp_hq_new_5";
    game["music"]["hq_new"][game["music"]["hq_new"].size] = "mp_hq_new_6";
    game["music"]["hq_captured"] = [];
    game["music"]["hq_captured"][game["music"]["hq_captured"].size] = "mp_hq_captured_1";
    game["music"]["hq_captured"][game["music"]["hq_captured"].size] = "mp_hq_captured_2";
    game["music"]["hq_captured"][game["music"]["hq_captured"].size] = "mp_hq_captured_3";
    game["music"]["hq_captured"][game["music"]["hq_captured"].size] = "mp_hq_captured_4";
    game["music"]["hq_captured"][game["music"]["hq_captured"].size] = "mp_hq_captured_5";
    game["music"]["hq_captured"][game["music"]["hq_captured"].size] = "mp_hq_captured_7";
    game["music"]["hq_destroyed_pos"] = [];
    game["music"]["hq_destroyed_pos"][game["music"]["hq_destroyed_pos"].size] = "mp_hq_destroyed_pos_1";
    game["music"]["hq_destroyed_pos"][game["music"]["hq_destroyed_pos"].size] = "mp_hq_destroyed_pos_2";
    game["music"]["hq_destroyed_pos"][game["music"]["hq_destroyed_pos"].size] = "mp_hq_destroyed_pos_3";
    game["music"]["hq_destroyed_pos"][game["music"]["hq_destroyed_pos"].size] = "mp_hq_destroyed_pos_4";
    game["music"]["hq_destroyed_pos"][game["music"]["hq_destroyed_pos"].size] = "mp_hq_destroyed_pos_5";
    game["music"]["hq_destroyed_neg"] = [];
    game["music"]["hq_destroyed_neg"][game["music"]["hq_destroyed_neg"].size] = "mp_hq_destroyed_neg_1";
    game["music"]["hq_destroyed_neg"][game["music"]["hq_destroyed_neg"].size] = "mp_hq_destroyed_neg_2";
    game["music"]["hq_destroyed_neg"][game["music"]["hq_destroyed_neg"].size] = "mp_hq_destroyed_neg_3";
    game["music"]["hq_destroyed_neg"][game["music"]["hq_destroyed_neg"].size] = "mp_hq_destroyed_neg_4";
    game["music"]["hq_destroyed_neg"][game["music"]["hq_destroyed_neg"].size] = "mp_hq_destroyed_neg_5";
    game["music"]["east_animated_infil"] = [];
    game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_8";
    game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_9";
    game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_10";
    game["music"]["west_animated_infil"] = [];
    game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_8";
    game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_9";
    game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_10";

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_1";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_2";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_4";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_5";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_10";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_12";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_7";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_easterneurope_animated_9";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_3";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_6";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_8";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_11";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_13";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_14";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_15";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_7";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_easterneurope_animated_9";
    }

    if(isDefined(level.music_style) && level.music_style == "england") {
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_1";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_2";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_5";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_10";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_6";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_7";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_england_animated_11";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_3";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_4";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_8";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_9";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_6";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_7";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_england_animated_11";
    }

    if(isDefined(level.music_style) && level.music_style == "middle_east") {
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_1";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_6";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_11";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_14";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_3";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_4";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_5";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_13";
      game["music"]["west_animated_infil"][game["music"]["west_animated_infil"].size] = "mus_infil_middleeast_animated_17";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_2";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_7";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_12";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_15";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_18";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_3";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_4";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_5";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_13";
      game["music"]["east_animated_infil"][game["music"]["east_animated_infil"].size] = "mus_infil_middleeast_animated_17";
    }

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

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
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

    if(isDefined(level.music_style) && level.music_style == "england") {
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

    if(isDefined(level.music_style) && level.music_style == "middle_east") {
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

    if(isDefined(level.music_style) && level.music_style == "eastern_europe") {
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

    if(isDefined(level.music_style) && level.music_style == "england") {
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

    if(isDefined(level.music_style) && level.music_style == "middle_east") {
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

    game["music"]["trials_loss"] = [];
    game["music"]["trials_loss"][game["music"]["trials_loss"].size] = "mp_cyber_attack_roundloss_aq";
    game["music"]["trials_loss"][game["music"]["trials_loss"].size] = "mp_cyber_attack_roundloss_aq2";
    game["music"]["trials_loss"][game["music"]["trials_loss"].size] = "mp_cyber_attack_roundloss_aq5";
    game["music"]["trials_loss"][game["music"]["trials_loss"].size] = "mp_cyber_attack_roundloss_aq6";
    game["music"]["trials_loss"][game["music"]["trials_loss"].size] = "mp_cyber_attack_roundloss_sas";
    game["music"]["trials_loss"][game["music"]["trials_loss"].size] = "mp_cyber_attack_roundloss_sas3";
    game["music"]["trials_win_low"] = [];
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_cyber_attack_roundwin_sas";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_cyber_attack_roundwin_aq";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_cyber_attack_roundwin_aq5";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_early_win_1";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_early_win_3";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_early_win_4";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_early_win_5";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_early_win_6";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_mid_win_3";
    game["music"]["trials_win_low"][game["music"]["trials_win_low"].size] = "mp_gunfight_mid_win_5";
    game["music"]["trials_win_mid"] = [];
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_cyber_attack_roundwin_aq2";
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_cyber_attack_roundwin_aq3";
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_cyber_attack_roundwin_aq4";
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_gunfight_early_win_2";
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_gunfight_mid_win_1";
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_gunfight_mid_win_2";
    game["music"]["trials_win_mid"][game["music"]["trials_win_mid"].size] = "mp_gunfight_mid_win_6";
    game["music"]["trials_win_high"] = [];
    game["music"]["trials_win_high"][game["music"]["trials_win_high"].size] = "mp_cyber_attack_roundwin_sas3";
    game["music"]["trials_win_high"][game["music"]["trials_win_high"].size] = "mp_cyber_attack_roundwin_sas4";
    game["music"]["trials_win_high"][game["music"]["trials_win_high"].size] = "mp_gunfight_late_win_1";
    game["music"]["trials_win_high"][game["music"]["trials_win_high"].size] = "mp_gunfight_late_win_2";
    game["music"]["trials_win_high"][game["music"]["trials_win_high"].size] = "mp_gunfight_late_win_6";
    game["music"]["infected"] = [];
    game["music"]["infected"][game["music"]["infected"].size] = "infected_01";
    game["music"]["infected"][game["music"]["infected"].size] = "infected_02";
    game["music"]["infected"][game["music"]["infected"].size] = "infected_03";
    game["music"]["infected"][game["music"]["infected"].size] = "infected_04";
    game["music"]["infected"][game["music"]["infected"].size] = "infected_05";

    foreach(var3 in level.teamnamelist) {
      if(var3 == "axis" || var3 == "allies") {
        continue;
      }

      game["music"][var3 + "_suspense"] = game["music"]["allies_suspense"];
    }
  }

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
  game["dialog"]["timesup"] = "gamestate_timesup";
  game["dialog"]["timesup_sixty"] = "gamestate_timesup_sixty";
  game["dialog"]["timesup_thirty"] = "gamestate_timesup_thirty";
  game["dialog"]["timesup_ten"] = "gamestate_timesup_ten";
  game["dialog"]["winning"] = "gamestate_winning";
  game["dialog"]["winning_time"] = "gamestate_winning_time";
  game["dialog"]["winning_score"] = "gamestate_winning_score";
  game["dialog"]["winning_comeback"] = "gamestate_winning_comeback";
  game["dialog"]["losing"] = "gamestate_losing";
  game["dialog"]["losing_time"] = "gamestate_losing_time";
  game["dialog"]["losing_score"] = "gamestate_losing_score";
  game["dialog"]["lead_lost"] = "gamestate_leadlost";
  game["dialog"]["lead_tied"] = "gamestate_tied";
  game["dialog"]["lead_taken"] = "gamestate_leadtaken";
  game["dialog"]["last_alive"] = "hint_lastmanstanding";
  game["dialog"]["halftime"] = "gamestate_halftime";
  game["dialog"]["overtime"] = "gamestate_overtime";
  game["dialog"]["side_switch"] = "gamestate_switchsides";
  game["dialog"]["kill_all"] = "hint_killall";
  game["dialog"]["lead"] = "gamestate_leadtaken";

  if(!isDefined(game["dialog"]["halfway_enemy_score"])) {
    game["dialog"]["halfway_enemy_score"] = "halfway_enemy_score";
  }

  if(!isDefined(game["dialog"]["halfway_enemy_time"])) {
    game["dialog"]["halfway_enemy_time"] = "halfway_enemy_time";
  }

  if(!isDefined(game["dialog"]["halfway_friendly_score"])) {
    game["dialog"]["halfway_friendly_score"] = "halfway_friendly_score";
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
    game["dialog"]["offense_obj"] = "boost";
  }

  if(!isDefined(game["dialog"]["defense_obj"])) {
    game["dialog"]["defense_obj"] = "boost";
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
  game["dialog"]["captured_all_enemy"] = "captured_all_enemy";
  game["dialog"]["captured_all_friendly"] = "captured_all_friendly";
  game["dialog"]["enemy_zone_control"] = "enemy_zone_control";
  game["dialog"]["friendly_zone_control"] = "friendly_zone_control";
  game["dialog"]["ti_destroyed"] = "ti_blocked";
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
  game["dialog"]["perk_highalert_exposed"] = "perk_highalert_exposed";
  game["dialog"]["mission_success"] = "gamestate_win";
  game["dialog"]["mission_failure"] = "gamestate_lost";
  game["dialog"]["mission_draw"] = "gamestate_draw";
  game["dialog"]["round_success"] = "round_win";
  game["dialog"]["round_failure"] = "round_lose";
  game["dialog"]["round_draw"] = "round_draw";
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  thread onplayerconnect();
  thread onlastalive();
  thread musiccontroller();
  thread ongameended();
  thread onroundswitch();
}

function ref_13155(var0, var1, var2) {
  game[var0][var1] = var2;
}

function headlessloadoutindexprimary(var0, var1) {
  ref_13155(var0, var1, undefined);
}

function relightingenabled(var0, var1) {
  var2 = game[var0][var1];
  return var2;
}

function reload_currentsequence_button_handler(var0, var1) {
  var2 = relightingenabled(var0, var1);

  if(isarray(var2)) {
    var3 = 0;

    if(var2.size > 1) {
      var3 = randomintrange(0, var2.size);
    }

    var2 = var2[var3];
  }

  return var2;
}

function ref_13175(var0, var1) {
  ref_13155("music", var0, var1);
}

function reset_attack_next_available_time(var0) {
  var1 = relightingenabled("music", var0);

  if(isarray(var1)) {
    if(var1.size == 0) {
      var1 = undefined;
    } else {
      var1 = var1[0];
    }
  } else if(!isstring(var1)) {
    var1 = undefined;
  }

  if(!isDefined(var1)) {
    return "";
  }

  return var1;
}

function risk_flagspawnshiftingcenter(var0) {
  var1 = reload_currentsequence_button_handler("music", var0);

  if(!isDefined(var1) || !isstring(var1)) {
    return "";
  }

  return var1;
}

function traceselectedmaplocation() {
  var0 = scripts\cp_mp\utility\game_utility::getmapname();
  var1 = scripts\mp\utility\game::getgametype();
  var2 = scripts\mp\utility\game::round_vehicle_logic();
  var3 = [""];

  if(var1 == "br" || var1 == "brtdm") {
    var4 = ["br3_lobby_intro_01", "br3_lobby_intro_02", "br3_lobby_intro_03", "br3_lobby_intro_04", "br3_lobby_intro_05"];
    var5 = ["br3_lobby_outro_01", "br3_lobby_outro_02", "br3_lobby_outro_03", "br3_lobby_outro_04", "br3_lobby_outro_05"];
    ref_13175("br_lobby_intro", var4);
    ref_13175("br_lobby_outro", var5);
    var6 = ["br3_infil_intro_01"];
    var7 = ["br3_plane_jump_01"];
    var8 = ["br3_plane_jump_parachute_01"];
    ref_13175("br_infil_intro", var6);
    ref_13175("br_infil_jump", var7);
    ref_13175("br_infil_jump_parachute", var8);
    var9 = ["br3_gulag_intro"];
    var10 = ["br3_gulag_lose"];
    var11 = ["br3_gulag_win"];
    ref_13175("br_gulag_intro", var9);
    ref_13175("br_gulag_lose", var10);
    ref_13175("br_gulag_win", var11);
    var12 = ["br3_ring_low_01", "br3_ring_low_02", "br3_ring_low_03"];
    var13 = ["br3_ring_med_01", "br3_ring_med_02", "br3_ring_med_03"];
    var14 = ["br3_ring_high_01", "br3_ring_high_02", "br3_ring_high_03", "br3_ring_high_04"];
    var15 = ["br3_ring_final"];
    ref_13175("br_ring_low", var12);
    ref_13175("br_ring_med", var13);
    ref_13175("br_ring_high", var14);
    ref_13175("br_ring_final", var15);
    var16 = ["br3_suspense_01", "br3_suspense_02", "br3_suspense_03", "br3_suspense_04", "br3_suspense_05", "br3_suspense_06", "br3_suspense_07", "br3_suspense_08", "br3_suspense_09", "br3_suspense_10", "br3_suspense_11", "br3_suspense_12"];
    ref_13175("allies_suspense", var16);
    ref_13175("axis_suspense", var16);
  }

  if(var2 == "dmz" || var2 == "rat_race" || var2 == "gold_war") {
    var17 = ["br3_plunder_infil_intro_01"];
    var18 = ["br3_plunder_plane_jump_01"];
    ref_13175("br_infil_intro", var17);
    ref_13175("br_infil_jump", var18);
    var19 = ["br3_plunder_tenpercent_1", "br3_plunder_tenpercent_2", "br3_plunder_tenpercent_3", "br3_plunder_tenpercent_4"];
    var20 = ["br3_plunder_thirtypercent_1", "br3_plunder_thirtypercent_2", "br3_plunder_thirdypercent_3"];
    var21 = ["br3_plunder_fiftypercent_1", "br3_plunder_fiftypercent_2", "br3_plunder_fiftypercent_3"];
    var22 = ["br3_plunder_seventyfivepercent_1", "br3_plunder_seventyfivepercent_2", "br3_plunder_seventyfivepercent_3"];
    var23 = ["br3_plunder_ninetypercent_1", "br3_plunder_ninetypercent_2"];
    ref_13175("plunder_tenpercent", var19);
    ref_13175("plunder_thirtypercent", var20);
    ref_13175("plunder_fiftypercent", var21);
    ref_13175("plunder_seventyfivepercent", var22);
    ref_13175("plunder_ninetypercent", var23);
    var24 = ["br3_plunder_defeat"];
    var25 = ["br3_plunder_draw"];
    var26 = ["br3_plunder_victory"];
    ref_13175("br_plunder_defeat", var24);
    ref_13175("br_plunder_draw", var25);
    ref_13175("br_plunder_victory", var26);
  }

  if(var2 == "truckwar") {
    var27 = ["mus_infil_truckwars_01", "mus_infil_truckwars_02", "mus_infil_truckwars_03", "mus_infil_truckwars_04", "mus_infil_truckwars_05"];
    var12 = ["mus_truckwars_ringlow_01", "mus_truckwars_ringlow_03", "mus_truckwars_ringlow_04", "mus_truckwars_ringlow_05", "mus_truckwars_ringlow_06"];
    var13 = ["mus_truckwars_ringmed_01", "mus_truckwars_ringmed_02", "mus_truckwars_ringmed_03", "mus_truckwars_ringmed_04", "mus_truckwars_ringmed_05", "mus_truckwars_ringmed_06"];
    var14 = ["mus_truckwars_ringhigh_01", "mus_truckwars_ringhigh_02", "mus_truckwars_ringhigh_03"];
    var15 = ["mus_truckwars_ringfinal_01", "mus_truckwars_ringfinal_02"];
    var28 = ["mus_truckwars_attacked_01", "mus_truckwars_attacked_02", "mus_truckwars_attacked_03", "mus_truckwars_attacked_04"];
    ref_13175("truckwars_infil", var27);
    ref_13175("br_ring_low", var12);
    ref_13175("br_ring_med", var13);
    ref_13175("br_ring_high", var14);
    ref_13175("br_ring_final", var15);
    ref_13175("br_truck_attacked", var28);
  }

  if(getdvarint("scr_br_alt_mode_escape", 0) != 0) {
    var6 = ["br3_plunder_infil_intro_01", "br3_plunder_infil_intro_02"];
    var29 = ["br3_plunder_tenpercent_1", "br3_plunder_tenpercent_2"];
    var30 = ["br3_plunder_thirtypercent_1", "br3_plunder_thirtypercent_2"];
    var31 = ["br3_plunder_fiftypercent_1", "br3_plunder_fiftypercent_2"];
    var32 = ["br3_plunder_seventyfivepercent_1"];
    var33 = ["br3_plunder_seventyfivepercent_2"];
    var34 = ["br3_plunder_ninetypercent_1", "br3_plunder_ninetypercent_2"];
    ref_13175("br_infil_intro", var6);
    ref_13175("br_escape_tenpercent", var29);
    ref_13175("br_escape_thirtypercent", var30);
    ref_13175("br_escape_fiftypercent", var31);
    ref_13175("br_escape_seventypercent", var32);
    ref_13175("br_escape_eightypercent", var33);
    ref_13175("br_escape_ninetypercent", var34);
  }

  if(var2 == "payload") {
    var6 = ["br3_payload_loading_drone"];
    ref_13175("br_infil_intro", var6);
    ref_13175("br_infil_jump", var3);
  }

  if(var2 == "zxp" || var2 == "gxp") {
    var4 = ["zxp3_lobby_intro_01", "zxp3_lobby_intro_02", "zxp3_lobby_intro_03", "zxp3_lobby_intro_04", "zxp3_lobby_intro_05"];
    var5 = ["zxp3_lobby_outro_01", "zxp3_lobby_outro_02", "zxp3_lobby_outro_03", "zxp3_lobby_outro_04"];
    var6 = ["zxp3_infil_intro_01"];
    var7 = ["zxp3_infil_jump_01"];
    var8 = ["zxp3_infil_jump_parachute_01"];
    ref_13175("br_lobby_intro", var4);
    ref_13175("br_lobby_outro", var5);
    ref_13175("br_infil_intro", var6);
    ref_13175("br_infil_jump", var7);
    ref_13175("br_infil_jump_parachute", var8);
    var35 = ["zxp3_zmb_spawn_01", "zxp3_zmb_spawn_02", "zxp3_zmb_spawn_03", "zxp3_zmb_spawn_04", "zxp3_zmb_spawn_05", "zxp3_zmb_spawn_06", "zxp3_zmb_spawn_07", "zxp3_zmb_spawn_08", "zxp3_zmb_spawn_09", "zxp3_zmb_spawn_10"];
    var12 = ["zxp3_ring_low_01", "zxp3_ring_low_02", "zxp3_ring_low_03", "zxp3_ring_low_04"];
    var13 = ["zxp3_ring_med_01", "zxp3_ring_med_02", "zxp3_ring_med_03", "zxp3_ring_med_04"];
    var14 = ["zxp3_ring_high_01", "zxp3_ring_high_02", "zxp3_ring_high_03", "zxp3_ring_high_04"];
    var15 = ["zxp3_ring_final_01", "zxp3_ring_final_02", "zxp3_ring_final_03", "zxp3_ring_final_04"];
    var16 = ["zxp3_suspense_01", "zxp3_suspense_02", "zxp3_suspense_03", "zxp3_suspense_04", "zxp3_suspense_05", "zxp3_suspense_06", "zxp3_suspense_07", "zxp3_suspense_08", "zxp3_suspense_09", "zxp3_suspense_10", "zxp3_suspense_11", "zxp3_suspense_12", "zxp3_suspense_13", "zxp3_suspense_14", "zxp3_suspense_15", "zxp3_suspense_16", "zxp3_suspense_17", "zxp3_suspense_18", "zxp3_suspense_19", "zxp3_suspense_20"];
    ref_13175("br_zmb_spawn", var35);
    ref_13175("br_ring_low", var12);
    ref_13175("br_ring_med", var13);
    ref_13175("br_ring_high", var14);
    ref_13175("br_ring_final", var15);
    ref_13175("allies_suspense", var16);
    ref_13175("axis_suspense", var16);

    if(var2 == "gxp") {
      ref_13175("br_lobby_intro", ["gov_lobby_intro_01", "gov_lobby_intro_02"]);
      ref_13175("br_lobby_outro", ["gov_lobby_outro_01"]);
      ref_13175("br_infil_intro", ["gov_infil_intro_01"]);
      ref_13175("br_infil_jump", ["gov_plane_jump_01"]);
      ref_13175("br_infil_jump_parachute", ["gov_parachute_01"]);
      ref_13175("br_zmb_spawn", ["zxp_ghost_spawn_01"]);
    }
  }

  if(var2 == "x2") {
    ref_13175("br_infil_intro", ["mx_plane_intro"]);
    ref_13175("br_infil_jump", ["mx_plane_jump"]);
    ref_13175("br_infil_jump_parachute", ["mx_plane_parachute"]);
  }

  if(var2 == "olaride") {
    var36 = ["br3_olaride_infil_intro_01", "br3_olaride_infil_intro_02"];
    var37 = ["br3_olaride_plane_jump_01", "br3_olaride_plane_jump_02"];
    var38 = ["br3_olaride_plane_jump_parachute_01", "br3_olaride_plane_jump_parachute_02"];
    ref_13175("br_infil_intro", var36);
    ref_13175("br_infil_jump", var37);
    ref_13175("br_infil_jump_parachute", var38);
  }

  if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    if(var2 == "payload" || var2 == "dmz" || var2 == "rat_race" || getdvarint("scr_br_alt_mode_escape", 0) != 0 || var2 == "zxp") {
      return;
    }

    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    thread playflyoveraudioline();
    thread watchhostmigration();
    var0.needtoplayintro = 1;
  }
}

function onplayerspawned() {
  if(!isai(self) && istrue(self.needtoplayintro)) {
    thread dointro();
    self.needtoplayintro = undefined;
    return;
  }
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
  var0 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(var0 >= level.prematchperiod) {
    return;
  }

  if(!level.rankedmatch) {
    return;
  }

  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }

  var1 = 0;

  if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
    if(self.sessionteam == "allies") {
      switch (var1) {
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
      switch (var1) {
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

      return;
    }

    return;
  }
}

function dointro() {
  level endon("host_migration_begin");
  self endon("disconnect");

  while(level.ingraceperiod > 15) {
    waitframe();
  }

  if(!isDefined(level.infilvotiming) && scripts\mp\utility\game::teamhasinfil(self.team) && game["roundsPlayed"] == 0) {
    level.infilvotiming = 1;
  }

  if(isDefined(game["trial"]) && isDefined(game["trial"]["tries_remaining"]) && game["trial"]["tries_remaining"] < 3) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "arena" || level.script == "mp_m_speed") {
    var0 = 0;
  } else {
    var0 = !scripts\mp\flags::gameflag("prematch_done") && (!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::isfirstround());
  }

  if(var0) {
    thread waitcountdown();

    for(;;) {
      self waittill("luinotifyserver", var1, var2);

      if(var1 == "matchReady") {
        break;
      }
    }
  }

  if(!level.splitscreen && !isDefined(self.ref_12463) || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      if(isDefined(self.team) && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "ctf" && scripts\mp\utility\game::getgametype() != "arena" && scripts\mp\utility\game::getgametype() != "sd" && scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "cyber" && scripts\mp\utility\game::getgametype() != "siege" && scripts\mp\utility\game::getgametype() != "rugby") {
        var3 = getDvar("mapname");

        if(var3 == "mp_gunsmith_gl") {
          self setplayermusicstate("");
        } else {
          jumpiffalse(self.team == "allies") LOC_00000206;
          var4 = game["music"]["spawn_allies"].size;
          var5 = randomint(var4);
          self setplayermusicstate(game["music"]["spawn_allies"][var5]);
          self.nosuspensemusic = 1;
          goto LOC_0000023b;
        }
      }

      if((scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "cyber" || scripts\mp\utility\game::getgametype() == "ctf" || scripts\mp\utility\game::getgametype() == "siege" || scripts\mp\utility\game::getgametype() == "rugby") && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        jumpiffalse(self.team == "allies") LOC_000002ec;
        var4 = game["music"]["spawn_allies"].size;
        var5 = randomint(var4);
        self setplayermusicstate(game["music"]["spawn_allies"][var5]);
        self.nosuspensemusic = 1;
        goto LOC_00000321;
      }

      if(scripts\mp\utility\game::getgametype() == "arm" && !isDefined(level.playedstartingmusic)) {
        jumpiffalse(self.team == "allies") LOC_00000382;
        var4 = game["music"]["spawn_allies"].size;
        var5 = randomint(var4);
        self setplayermusicstate(game["music"]["spawn_allies"][var5]);
        self.nosuspensemusic = 1;
        goto LOC_000003b7;
      }

      if(scripts\mp\utility\game::getgametype() == "arena" && isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
        jumpiffalse(self.team == "allies") LOC_00000424;
        var4 = game["music"]["gunfight_spawn_allies"].size;
        var5 = randomint(var4);
        self setplayermusicstate(game["music"]["gunfight_spawn_" + self.team][var5]);
        goto LOC_00000458;
      }
    }

    if(level.splitscreen) {
      level.playedstartingmusic = 1;
    }

    thread ref_139be(20);
  }

  if(istrue(level.infilvotiming)) {
    scripts\mp\flags::gameflagwait("prematch_done");
    wait 1.5;
  }

  if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
    if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies") {
      scripts\mp\utility\dialog::leaderdialogonplayer("allies_gametype");
    } else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis") {
      scripts\mp\utility\dialog::leaderdialogonplayer("axis_gametype");
    } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      var7 = 1;

      if(scripts\mp\utility\game::getgametype() == "arena") {
        if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
          var7 = 1;
        } else if(shouldplayarenaintro() || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] % 2 == 0) {
          var7 = 0;

          if(game["matchPoint"] != 1 && game["finalRound"] != 1) {
            if(game["roundsPlayed"] % 6 == 0) {
              game["dialog"]["offense_obj"] = "boost_genericround";
              game["dialog"]["defense_obj"] = "boost_genericround";
            }
          }

          if(self.team == game["attackers"]) {
            if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
              scripts\mp\utility\dialog::leaderdialogonplayer("offense_obj", "introboost");
            }
          } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
            scripts\mp\utility\dialog::leaderdialogonplayer("defense_obj", "introboost");
          }
        } else {
          var7 = 0;
        }
      }

      if(var7) {
        scripts\mp\utility\dialog::leaderdialogonplayer("gametype", "gametype");
      }
    }
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      if(self.team == game["attackers"]) {
        if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
          scripts\mp\utility\dialog::leaderdialogonplayer("offense_obj", "introboost");
          return;
        }

        return;
      }

      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        scripts\mp\utility\dialog::leaderdialogonplayer("defense_obj", "introboost");
        return;
      }

      return;
    }

    return;
  }

  if(self.team == game["attackers"]) {
    if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      scripts\mp\utility\dialog::leaderdialogonplayer("offense_obj", "introboost");
      return;
    }

    return;
  }

  if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
    scripts\mp\utility\dialog::leaderdialogonplayer("defense_obj", "introboost");
    return;
  }
}

function shouldplayarenaintro() {
  if(scripts\mp\utility\game::iswinbytworulegametype()) {
    return false;
  }

  if(game["finalRound"] == 1) {
    game["dialog"]["offense_obj"] = "boost_tied_matchpoint";
    game["dialog"]["defense_obj"] = "boost_tied_matchpoint";
    return true;
  } else if(game["matchPoint"] == 1) {
    var0 = "";

    foreach(var2 in level.teamnamelist) {
      var3 = scripts\mp\utility\game::getroundswon(var2);

      if(var3 == level.winlimit - 1) {
        var0 = var2;
        break;
      }
    }

    if(game["attackers"] == var0) {
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

  for(;;) {
    level waittill("host_migration_begin");
    var0 = level.ingraceperiod;
    level waittill("host_migration_end");

    if(var0) {
      thread dointro();
    }
  }
}

function onlastalive() {
  level endon("game_ended");
  level waittill("last_alive", var0);

  if(!isalive(var0)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "siege") {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("siege_lastalive_zones");
    thread onlastalive();
    return;
  } else if(scripts\mp\utility\game::getgametype() == "sr" && !level.nofriendlytags) {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("lastalive_revive");
    thread onlastalive();
    return;
  }

  var0 scripts\mp\utility\dialog::leaderdialogonplayer("last_alive");
}

function onroundswitch() {
  level waittill("round_switch", var0);

  if(isDefined(level.ref_12081)) {
    [[level.ref_12081]](var0);
    return;
  }

  switch (var0) {
    case "halftime":
      foreach(var2 in level.players) {
        if(var2 issplitscreenplayer() && !var2 issplitscreenplayerprimary()) {
          continue;
        }

        var2 scripts\mp\utility\dialog::leaderdialogonplayer("halftime");
      }

      break;
    case "overtime":
      foreach(var2 in level.players) {
        if(var2 issplitscreenplayer() && !var2 issplitscreenplayerprimary()) {
          continue;
        }

        var2 scripts\mp\utility\dialog::leaderdialogonplayer("overtime");
      }

      break;
    default:
      if(istrue(level.switchedsides)) {
        foreach(var2 in level.players) {
          if(var2 issplitscreenplayer() && !var2 issplitscreenplayerprimary()) {
            continue;
          }

          var2 scripts\mp\utility\dialog::leaderdialogonplayer("side_switch");
        }

        break;
      }

      break;
  }
}

function ref_12789(var0) {
  if(isDefined(level.endmusicplayed)) {
    return;
  }

  var1 = scripts\mp\gamescore::run_common_functions_stealth();
  level.endmusicplayed = 1;

  foreach(var3 in level.players) {
    var4 = var1[var3.team];

    if(var4 <= 10) {
      var5 = reset_attack_next_available_time("br_plunder_victory");
      var3 setplayermusicstate(var5);
    } else {
      var5 = reset_attack_next_available_time("br_plunder_defeat");
      var3 setplayermusicstate(var5);
    }

    var3 setsoundsubmix("mp_matchend_music", 2);
    var3 enableplayerbreathsystem(0);
  }
}

function ongameended() {
  thread roundwinnerdialog();
  thread gamewinnerdialog();
  level waittill("start_game_win_audio", var0);

  if(!isDefined(var0) || isDefined(level.endmusicplayed)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "kingslayer" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
    return;
  }

  jumpiffalse(level.teambased) LOC_0000049c;

  if(level.splitscreen) {
    if(var0 == "allies") {
      foreach(var2 in level.players) {
        var2 clearsoundsubmix("deaths_door_mp");
        var2 setplayermusicstate(game["music"]["victory_allies"]);
        var2 setsoundsubmix("mp_matchend_music", 2);
        LOC_000000f7:
      }
    } else {
      jumpiffalse(var2 == "axis") LOC_0000017c;

      foreach(var2 in level.players) {
        var2 clearsoundsubmix("deaths_door_mp");
        var2 setplayermusicstate(game["music"]["victory_axis"]);
        var2 setsoundsubmix("mp_matchend_music", 2);
        LOC_00000169:
      }

      goto LOC_000001cb;
    }
    LOC_000001cb:
  } else if(var2 == "allies") {
    jumpiffalse(scripts\mp\utility\game::getgametype() == "brtdm") LOC_0000026d;

    foreach(var2 in level.players) {
      var2 clearsoundsubmix("deaths_door_mp");
      var2 setsoundsubmix("mp_matchend_music", 2);

      if(isDefined(var2.team) && var2.team == "allies") {
        var2 setplayermusicstate(game["music"]["victory_allies_fade"]);
        continue;
      }

      var2 setplayermusicstate(game["music"]["defeat_axis_fade"]);
    }

    goto LOC_000002ee;
  } else {
    jumpiffalse(var2 == "axis") LOC_00000416;
    jumpiffalse(scripts\mp\utility\game::getgametype() == "brtdm") LOC_00000390;

    foreach(var2 in level.players) {
      var2 clearsoundsubmix("deaths_door_mp");
      var2 setsoundsubmix("mp_matchend_music", 2);

      if(isDefined(var2.team) && var2.team == "axis") {
        var2 setplayermusicstate(game["music"]["victory_axis_fade"]);
        continue;
      }

      var2 setplayermusicstate(game["music"]["defeat_allies_fade"]);
    }

    goto LOC_00000411;
  }

  LOC_00000497:
    goto LOC_00000599;
}

function ref_11bdd(var0) {
  thread stopsuspensemusic();
  var1 = game["music"]["midpoint_winning"].size - 1;
  var2 = game["music"]["midpoint_losing"].size - 1;

  foreach(var4 in level.players) {
    if(var4.team == var0) {
      var5 = randomint(var1);
      var4 setplayermusicstate(game["music"]["midpoint_winning"][var5]);
      continue;
    }

    var5 = randomint(var2);
    var4 setplayermusicstate(game["music"]["midpoint_losing"][var5]);
  }

  wait 25;
  thread suspensemusic();
}

function dominating_music(var0) {
  if(isDefined(level.dominating_music) && level.dominating_music == 1) {
    return;
  }

  thread stopsuspensemusic();

  if(var0 == "axis") {
    var1 = game["music"]["dominating_axis"].size - 1;
    var2 = game["music"]["dominated_allies"].size - 1;

    foreach(var4 in level.players) {
      if(var4.team == "allies") {
        var5 = randomint(var2);
        var4 setplayermusicstate(game["music"]["dominated_allies"][var5]);
        continue;
      }

      var5 = randomint(var1);
      var4 setplayermusicstate(game["music"]["dominating_axis"][var5]);
    }
  } else {
    var1 = game["music"]["dominated_axis"].size - 1;
    var2 = game["music"]["dominating_allies"].size - 1;

    foreach(var4 in level.players) {
      if(var4.team == "allies") {
        var5 = randomint(var2);
        var4 setplayermusicstate(game["music"]["dominating_allies"][var5]);
        continue;
      }

      var5 = randomint(var1);
      var4 setplayermusicstate(game["music"]["dominated_axis"][var5]);
    }
  }

  level.dominating_music = 1;
  wait 25;
  level.dominating_music = 0;
  thread suspensemusic();
}

function bombplanted_music() {
  var0 = game["music"]["bombplant"].size - 1;
  var1 = randomint(var0);

  if(isDefined(level.bombtimer) && level.bombtimer > 44) {
    var2 = level.bombtimer - 45;
    wait var2;

    foreach(var4 in level.players) {
      var4 setplayermusicstate(game["music"]["bombplant"][var1]);
    }
  } else if(isDefined(level.bombtimer)) {
    var2 = level.bombtimer - 30;

    if(var2 < 0) {
      var2 = 0;
    }

    wait var2;

    foreach(var4 in level.players) {
      var4 setplayermusicstate(game["music"]["bombplant_30"][var1]);
    }
  }

  level.bombplanted_music = 1;
}

function roundwinnerdialog() {
  level waittill("round_win", var0);
  var1 = level.roundenddelay / 4;

  if(var1 > 0) {
    wait var1;
  }

  var2 = game["teamScores"]["allies"];
  var3 = game["teamScores"]["axis"];

  if(!isDefined(var0) || isPlayer(var0)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    game["dialog"]["round_success"] = "gamestate_practice_over";
    game["dialog"]["round_failure"] = "gamestate_practice_over";
    game["dialog"]["round_draw"] = "gamestate_practice_over";
  }

  if(var0 == "allies") {
    scripts\mp\utility\dialog::leaderdialog("round_success", "allies");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "axis");
    return;
  }

  if(var0 == "axis") {
    scripts\mp\utility\dialog::leaderdialog("round_success", "axis");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "allies");
    return;
  }

  if(var3 > var2) {
    scripts\mp\utility\dialog::leaderdialog("round_success", "axis");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "allies");
    return;
  }

  if(var2 > var3) {
    scripts\mp\utility\dialog::leaderdialog("round_success", "allies");
    scripts\mp\utility\dialog::leaderdialog("round_failure", "axis");
    return;
  }

  scripts\mp\utility\dialog::leaderdialog("round_draw", "allies");
  scripts\mp\utility\dialog::leaderdialog("round_draw", "axis");
}

function gamewinnerdialog() {
  level waittill("start_game_win_audio", var0);
  var1 = level.postroundtime / 2;

  if(var1 > 0) {
    wait var1;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }

  if(isPlayer(var0) && !level.teambased) {
    for(var2 = 0; var2 < level.placement["all"].size; var2++) {
      var3 = level.placement["all"][var2];

      if(var3 issplitscreenplayer() && !var3 issplitscreenplayerprimary()) {
        continue;
      }

      if(var2 < 3) {
        var3 scripts\mp\utility\dialog::leaderdialogonplayer("mission_success");
        continue;
      }

      var3 scripts\mp\utility\dialog::leaderdialogonplayer("mission_failure");
    }

    return;
  }

  if(var0 == "allies") {
    scripts\mp\utility\dialog::leaderdialog("mission_success", "allies");
    scripts\mp\utility\dialog::leaderdialog("mission_failure", "axis");
    return;
  }

  if(var0 == "axis") {
    scripts\mp\utility\dialog::leaderdialog("mission_success", "axis");
    scripts\mp\utility\dialog::leaderdialog("mission_failure", "allies");
    return;
  }

  scripts\mp\utility\dialog::leaderdialog("mission_draw", "axis");
  scripts\mp\utility\dialog::leaderdialog("mission_draw", "allies");
}

function musiccontroller() {
  level endon("game_ended");
  level.musicenabled = 1;
  thread suspensemusic();
  level waittill("match_ending_soon", var0);

  if(level.roundlimit == 1 || game["roundsPlayed"] == level.roundlimit - 1 || scripts\mp\utility\game::ismoddedroundgame()) {
    if(!level.splitscreen) {
      if(var0 == "time") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              thread timelimitmusic("allies");
            }

            scripts\mp\utility\dialog::leaderdialog("winning_time", "allies");
            scripts\mp\utility\dialog::leaderdialog("losing_time", "axis");
            return;
          }

          if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              thread timelimitmusic("axis");
            }

            scripts\mp\utility\dialog::leaderdialog("winning_time", "axis");
            scripts\mp\utility\dialog::leaderdialog("losing_time", "allies");
            return;
          }

          thread timelimitmusic("draw");
          return;
        }

        if(ismusicenabled()) {
          var1 = game["music"]["winning_axis"].size;
          var2 = game["music"]["winning_allies"].size;

          foreach(var4 in level.players) {
            if(var4.team == "allies") {
              var5 = randomint(var2);
              var4 setplayermusicstate(game["music"]["winning_allies"][var5]);
              continue;
            }

            var5 = randomint(var1);
            var4 setplayermusicstate(game["music"]["winning_axis"][var5]);
          }

          return;
        }

        return;
      }

      if(var6 == "score") {
        var1 = game["music"]["winning_axis"].size - 1;
        var2 = game["music"]["losing_allies"].size - 1;

        if(level.teambased && scripts\mp\utility\game::getgametype() != "arena") {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              var1 = game["music"]["losing_axis"].size;
              var2 = game["music"]["winning_allies"].size;

              foreach(var4 in level.players) {
                if(var4.team == "allies") {
                  var5 = randomint(var2);
                  var4 setplayermusicstate(game["music"]["winning_allies"][var5]);
                  continue;
                }

                var5 = randomint(var1);
                var4 setplayermusicstate(game["music"]["losing_axis"][var5]);
              }
            }

            scripts\mp\utility\dialog::leaderdialog("winning_score", "allies");
            scripts\mp\utility\dialog::leaderdialog("losing_score", "axis");
            return;
          }

          if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              var1 = game["music"]["winning_axis"].size;
              var2 = game["music"]["losing_allies"].size;

              foreach(var4 in level.players) {
                if(var4.team == "allies") {
                  var5 = randomint(var2);
                  var4 setplayermusicstate(game["music"]["losing_allies"][var5]);
                  continue;
                }

                var5 = randomint(var1);
                var4 setplayermusicstate(game["music"]["winning_axis"][var5]);
              }
            }

            scripts\mp\utility\dialog::leaderdialog("winning_score", "axis");
            scripts\mp\utility\dialog::leaderdialog("losing_score", "allies");
            return;
          }

          return;
        }

        var11 = scripts\mp\gamescore::gethighestscoringplayer();
        var12 = scripts\mp\gamescore::getlosingplayers();
        GscBinSkip1(0x45, 0, var11);
      }

      return;
    }

    return;
  }

  if(!level.hardcoremode && scripts\mp\utility\game::getgametype() != "arena") {
    foreach(var4 in level.players) {
      var4 setplayermusicstate("");
    }

    return;
  }
}

function matchendingsoonleaderdialog(var0, var1) {
  if(scripts\mp\utility\game::getgametype() == "arena") {
    if(isDefined(var1) && !isDefined(level.notifiedtimesup) && var1 <= 10) {
      level.notifiedtimesup = 1;
      var0 = "timesup_ten";
    } else if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 1 || game["launchChunkRuleSet"] == 2) {
        return false;
      }
    } else {
      return false;
    }
  }

  if(level.teambased) {
    foreach(var3 in level.teamnamelist) {
      if(var3 != "spectator") {
        scripts\mp\utility\dialog::leaderdialog(var0, var3);
      }
    }
  } else {
    var5 = [];

    foreach(var7 in level.players) {
      if(var7.team != "spectator") {
        var5 = var7;
      }
    }

    scripts\mp\utility\dialog::leaderdialogonplayers(var0, var5);
  }

  return true;
}

function timelimitmusic(var0) {
  self endon("game_ended");
  level notify("stop_suspense_music");

  if(scripts\mp\utility\game::getgametype() != "arena") {
    var1 = "losing_axis";
    var2 = "losing_allies";

    if(var0 == "allies") {
      var1 = "losing_axis";
      var2 = "winning_allies";
    } else if(var0 == "axis") {
      var1 = "winning_axis";
      var2 = "losing_allies";
    }

    var3 = game["music"][var1].size;
    var4 = game["music"][var2].size;

    foreach(var6 in level.players) {
      if(var6.team == "allies") {
        var6 setplayermusicstate(game["music"][var2][randomint(var4)]);
        continue;
      }

      var6 setplayermusicstate(game["music"][var1][randomint(var3)]);
    }

    return;
  }
}

function headquarters_newhq_music() {
  foreach(var1 in level.players) {
    var2 = game["music"]["hq_new"].size - 1;
    var3 = randomint(var2);
    var1 setplayermusicstate(game["music"]["hq_new"][var3]);
  }
}

function headquarters_captured_music() {
  level endon("hq_music_done");

  if(scripts\mp\utility\game::getgametype() == "hq") {
    foreach(var1 in level.players) {
      var2 = game["music"]["hq_captured"].size - 1;
      var3 = randomint(var2);
      var1 setplayermusicstate(game["music"]["hq_captured"][var3]);
    }

    level.hq_captured_music = 1;
    wait 60;
    level.hq_captured_music = 0;
    return;
  }
}

function headquarters_deactivate_music(var0) {
  if(isDefined(level.hq_captured_music) && level.hq_captured_music == 1) {
    level notify("hq_music_done");
    level.hq_captured_music = 0;
    var1 = game["music"]["hq_destroyed_pos"].size;
    var2 = game["music"]["hq_destroyed_neg"].size;
    var3 = randomint(var1);
    var4 = randomint(var2);

    foreach(var6 in level.players) {
      var7 = var6.team;

      if(var7 == var0) {
        var6 setplayermusicstate(game["music"]["hq_destroyed_pos"][var3]);
        continue;
      }

      var6 setplayermusicstate(game["music"]["hq_destroyed_neg"][var4]);
    }

    return;
  }
}

function stealthtimeelapsed() {
  var0 = game["music"]["infected"].size;
  var1 = randomint(var0);
  self setplayermusicstate(game["music"]["infected"][var1]);
}

function ref_1469b() {
  if(scripts\mp\utility\game::round_vehicle_logic() != "reveal") {
    var0 = game["music"]["br_zmb_spawn"].size;
    var1 = randomint(var0);
    self setplayermusicstate(game["music"]["br_zmb_spawn"][var1]);
    return;
  }
}

function suspensemusic(var0) {
  if(!ismusicenabled()) {
    return;
  }

  var1 = getDvar("mapname");

  if(var1 == "mp_gunsmith_gl") {
    return;
  }

  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("stop_suspense_music");

  if(isDefined(level.nosuspensemusic) && level.nosuspensemusic) {
    return;
  }

  var2 = game["music"]["allies_suspense"].size;
  var3 = game["music"]["axis_suspense"].size;
  level.cursuspsensetrack = [];
  level.cursuspsensetrack["allies"] = randomint(var2);
  level.cursuspsensetrack["axis"] = randomint(var3);

  if(isDefined(var0) && var0) {
    wait 120;
  }

  for(;;) {
    if(!getdvarint("scr_br_alt_mode_zxp", 0)) {
      wait randomfloatrange(75, 120);

      if(isDefined(level.nosuspensemusic) && level.nosuspensemusic) {
        return;
      }

      level.cursuspsensetrack["allies"] = randomint(var2);
      level.cursuspsensetrack["axis"] = randomint(var3);

      if(!istrue(game["inLiveLobby"])) {
        foreach(var5 in level.players) {
          if(!isDefined(var5.nosuspensemusic)) {
            var6 = var5.team;

            if(var5.team == "allies") {
              var5 setplayermusicstate(game["music"]["allies_suspense"][level.cursuspsensetrack["allies"]]);
            } else {
              var5 setplayermusicstate(game["music"]["axis_suspense"][level.cursuspsensetrack["axis"]]);
            }
          }
        }
      }

      continue;
    }

    wait randomfloatrange(30, 75);

    if(isDefined(level.nosuspensemusic) && level.nosuspensemusic) {
      return;
    }

    if(!istrue(game["inLiveLobby"])) {
      foreach(var5 in level.players) {
        if(isalive(var5) && !istrue(var5.iszombie)) {
          level.cursuspsensetrack["allies"] = randomint(var2);
          var5 setplayermusicstate(game["music"]["allies_suspense"][level.cursuspsensetrack["allies"]]);
        }
      }
    }
  }
}

function ref_139be(var0) {
  wait var0;
  self.nosuspensemusic = undefined;
}

function stopsuspensemusic() {
  level notify("stop_suspense_music");

  if(isDefined(level.cursuspsensetrack) && level.cursuspsensetrack.size == 2) {
    foreach(var1 in level.players) {
      var1 setplayermusicstate("");
    }

    return;
  }
}

function enablemusic() {
  if(level.musicenabled == 0) {
    thread suspensemusic();
  }

  level.musicenabled++;
}

function disablemusic() {
  if(level.musicenabled > 0) {
    level.musicenabled--;

    if(level.musicenabled == 0) {
      stopsuspensemusic();
      return;
    }

    return;
  }
}

function round_end_music(var0, var1, var2) {
  if(isDefined(level.endmusicplayed)) {
    return;
  }

  if(level.halftimetype == "halftime" && level.roundlimit && game["roundsPlayed"] * 2 == level.roundlimit) {
    foreach(var4 in level.players) {
      var4 setplayermusicstate("mus_mp_halftime");
      var4 clearsoundsubmix("mp_killstreak_nuke", 10);
    }

    return;
  }

  if(level.playovertime) {
    foreach(var4 in level.players) {
      var4 setplayermusicstate("mus_mp_halftime");
      var4 clearsoundsubmix("mp_killstreak_nuke", 10);
    }

    return;
  }

  if(level.halftimetype == "halftime" && !level.roundlimit) {
    foreach(var18, var4 in level.players) {
      if(var0 == "allies") {
        if(scripts\mp\utility\game::getgametype() != "arena") {
          var9 = game["music"]["roundloss_axis"].size;
          var10 = game["music"]["roundwin_allies"].size;

          if(istrue(level.unset_relic_lfo)) {
            wait 4;
          }

          foreach(var4 in level.players) {
            if(var4.team == "allies") {
              var12 = randomint(var10);
              var4 setplayermusicstate(game["music"]["roundwin_allies"][var12]);
              var4 clearsoundsubmix("deaths_door_mp");
              var4 clearsoundsubmix("mp_killstreak_nuke", 10);
              continue;
            }

            var12 = randomint(var9);
            var4 setplayermusicstate(game["music"]["roundloss_axis"][var12]);
            var4 clearsoundsubmix("deaths_door_mp");
            var4 clearsoundsubmix("mp_killstreak_nuke", 10);
          }
        } else {
          var14 = getarenaroundendmusictype();
          jumpiffalse(isDefined(var4.team) && var4.team == "allies") LOC_00000247;
          var10 = game["music"]["gunfight_roundwin_" + var14 + "_allies"].size - 1;
          var15 = randomint(var10);
          var4 setplayermusicstate(game["music"]["gunfight_roundwin_" + var14 + "_allies"][var15]);
          var4 clearsoundsubmix("deaths_door_mp");
          goto LOC_00000292;
        }

        continue;
      }

      if(var1 == "axis") {
        if(scripts\mp\utility\game::getgametype() != "arena") {
          var9 = game["music"]["roundwin_axis"].size;
          var10 = game["music"]["roundloss_allies"].size;

          if(istrue(level.unset_relic_lfo)) {
            wait 4;
          }

          foreach(var18 in level.players) {
            if(isDefined(var18.team) && var18.team == "allies") {
              var12 = randomint(var10);
              var18 setplayermusicstate(game["music"]["roundloss_allies"][var12]);
              var18 clearsoundsubmix("deaths_door_mp");
              var18 clearsoundsubmix("mp_killstreak_nuke", 10);
              continue;
            }

            var12 = randomint(var9);
            var18 setplayermusicstate(game["music"]["roundwin_axis"][var12]);
            var18 clearsoundsubmix("deaths_door_mp");
            var18 clearsoundsubmix("mp_killstreak_nuke", 10);
          }
        } else {
          var14 = getarenaroundendmusictype();
          jumpiffalse(isDefined(var18.team) && var18.team == "allies") LOC_000003ff;
          var10 = game["music"]["gunfight_roundloss_" + var14 + "_allies"].size - 1;
          var15 = randomint(var10);
          var18 setplayermusicstate(game["music"]["gunfight_roundloss_" + var14 + "_allies"][var15]);
          var18 clearsoundsubmix("deaths_door_mp");
          goto LOC_0000044a;
        }

        continue;
      }

      if(scripts\mp\utility\game::getgametype() != "arena") {
        var14 setplayermusicstate("mp_cyber_attack_rounddraw");
        continue;
      }

      var14 = getarenaroundendmusictype();
      jumpiffalse(isDefined(var14.team) && var14.team == "allies") LOC_000004de;
      var10 = game["music"]["gunfight_roundwin_" + var14 + "_allies"].size - 1;
      var15 = randomint(var10);
      var14 setplayermusicstate(game["music"]["gunfight_roundwin_" + var14 + "_allies"][var15]);
      var14 clearsoundsubmix("deaths_door_mp");
      goto LOC_00000529;
    }

    var14 = undefined;
    var14 = undefined;
    return;
  }

  if(level.halftimetype == "halftime" && scripts\mp\utility\game::getgametype() == "dd" && !scripts\mp\utility\game::hitroundlimit()) {
    foreach(var4 in level.players) {
      if(var8 == "allies") {
        var9 = game["music"]["roundloss_axis"].size;
        var10 = game["music"]["roundwin_allies"].size;

        foreach(var4 in level.players) {
          if(var4.team == "allies") {
            var12 = randomint(var10);
            var4 setplayermusicstate(game["music"]["roundwin_allies"][var12]);
            var4 clearsoundsubmix("deaths_door_mp");
            var4 clearsoundsubmix("mp_killstreak_nuke", 10);
            continue;
          }

          var12 = randomint(var9);
          var4 setplayermusicstate(game["music"]["roundloss_axis"][var12]);
          var4 clearsoundsubmix("deaths_door_mp");
          var4 clearsoundsubmix("mp_killstreak_nuke", 10);
        }

        continue;
      }

      if(var8 == "axis") {
        var9 = game["music"]["roundwin_axis"].size;
        var10 = game["music"]["roundloss_allies"].size;

        foreach(var4 in level.players) {
          if(var4.team == "allies") {
            var12 = randomint(var10);
            var4 setplayermusicstate(game["music"]["roundloss_allies"][var12]);
            var4 clearsoundsubmix("deaths_door_mp");
            var4 clearsoundsubmix("mp_killstreak_nuke", 10);
            continue;
          }

          var12 = randomint(var9);
          var4 setplayermusicstate(game["music"]["roundwin_axis"][var12]);
          var4 clearsoundsubmix("deaths_door_mp");
          var4 clearsoundsubmix("mp_killstreak_nuke", 10);
        }

        continue;
      }

      var4 setplayermusicstate("mp_cyber_attack_rounddraw");
      var4 clearsoundsubmix("deaths_door_mp");
      var4 clearsoundsubmix("mp_killstreak_nuke", 10);
    }

    return;
  }
}

function getarenaroundendmusictype() {
  var0 = "early";
  var1 = 0;

  foreach(var3 in level.teamnamelist) {
    var4 = game["roundsWon"][var3];

    if(var4 > var1) {
      var1 = var4;
    }
  }

  if(var1 > 0) {
    var6 = var1 / level.winlimit;

    if(var6 <= 0.34) {
      var0 = "early";
    } else if(var6 >= 0.34 && var6 <= 0.67) {
      var0 = "mid";
    } else {
      var0 = "late";
    }
  }

  return var0;
}

function debugtype() {
  level endon("game_ended");
  level endon("final_circle_music");

  if(istrue(level.ref_11e96)) {
    return;
  }

  if(!scripts\mp\flags::gameflag("br_ready_to_jump")) {
    return;
  }

  var0 = getdvarint("scr_br_circle_closing_music_ignore_moving_circles", 0);
  var1 = level.br_level.br_circleclosetimes.size - 1;

  if(!var0) {
    var1 -= level.br_level.delay_start_escort_protect_hvi_objective;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    var2 = level.br_circle.circleindex;
  } else {
    var2 = 1;
  }

  if(var2 >= var2) {
    return;
  }

  var3 = 2;
  var4 = 6;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    var5 = level.br_level.br_circleclosetimes.size;

    if(!var1) {
      var5 -= level.br_level.delay_start_escort_protect_hvi_objective;
    }

    var3 = scripts\mp\utility\script::roundup(var5 * 0.5 - 1);

    if(var3 < 1) {
      var3 = 1;
    }

    var4 = scripts\mp\utility\script::roundup(var5 * 0.75);
  }

  wait 5;

  foreach(var7 in level.players) {
    if(!isbot(var7) && !var7 scripts\mp\gametypes\br_public::isplayeringulag()) {
      if(var2 < var3) {
        var8 = game["music"]["br_ring_low"].size - 1;
        var9 = randomint(var8);
        var10 = "low" + var9;

        if(isDefined(var7.initializerocketfuelreadings) && var10 == var7.initializerocketfuelreadings) {
          if(var9 == 0) {
            var9++;
          } else {
            var9--;
          }
        }

        var7.nosuspensemusic = 1;
        var7 setplayermusicstate(game["music"]["br_ring_low"][var9]);
        var7.initializerocketfuelreadings = "low" + var9;
      } else if(var6 < var11) {
        var8 = game["music"]["br_ring_med"].size - 1;
        var9 = randomint(var8);
        var10 = "med" + var9;

        if(isDefined(var9.initializerocketfuelreadings) && var10 == var9.initializerocketfuelreadings) {
          if(var9 == 0) {
            var9++;
          } else {
            var9--;
          }
        }

        var9.nosuspensemusic = 1;
        var9 setplayermusicstate(game["music"]["br_ring_med"][var9]);
        var9.initializerocketfuelreadings = "med" + var9;
      } else {
        var8 = game["music"]["br_ring_high"].size - 1;
        var9 = randomint(var8);
        var10 = "high" + var9;

        if(isDefined(var9.initializerocketfuelreadings) && var10 == var9.initializerocketfuelreadings) {
          if(var9 == 0) {
            var9++;
          } else {
            var9--;
          }
        }

        var9.nosuspensemusic = 1;
        var9 setplayermusicstate(game["music"]["br_ring_high"][var9]);
        var9.initializerocketfuelreadings = "high" + var9;
      }
    }
  }

  var8 = undefined;
  var10 = undefined;
  thread decrement_num_of_frame_frozen();
}

function defcon_alarms_stop() {
  level endon("game_ended");
  level endon("final_circle_music");

  if(istrue(level.ref_11e96)) {
    return;
  }

  if(!scripts\mp\flags::gameflag("br_ready_to_jump")) {
    return;
  }

  var0 = getdvarint("scr_br_danger_circle_closing_music_ignore_moving_circles", 0);
  var1 = level.br_level.br_circleclosetimes.size - 1;

  if(!var0) {
    var1 -= level.br_level.delay_start_escort_protect_hvi_objective;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    var2 = level.br_circle.circleindex;
  } else {
    var2 = 1;
  }

  if(var2 == var2) {
    var3 = risk_flagspawnshiftingcenter("br_ring_final");
    setmusicstate(var3);
    level.nosuspensemusic = 1;
    level notify("final_circle_music");
  } else if(var2 > var2) {
    return;
  }

  var4 = 0;
  var5 = 4;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    var6 = level.br_level.br_circleclosetimes.size;

    if(!var1) {
      var6 -= level.br_level.delay_start_escort_protect_hvi_objective;
    }

    var5 = scripts\mp\utility\script::roundup(var6 * 0.5);
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    var2 = level.br_circle.circleindex;
  } else {
    var2 = 1;
  }

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    var4 = level.br_level.br_circleclosetimes[var2];
  }

  if(var4 > 15) {
    wait var4 - 15;
  }

  foreach(var8 in level.players) {
    if(!isbot(var8) && !var8 scripts\mp\gametypes\br_public::isplayeringulag()) {
      if(var2 < var5) {
        var9 = game["music"]["br_ring_med"].size;
        var10 = randomint(var9);
        var11 = "med" + var10;

        if(isDefined(var8.initializerocketfuelreadings) && var11 == var8.initializerocketfuelreadings) {
          if(var10 == 0) {
            var10++;
          } else {
            var10--;
          }
        }

        var8.nosuspensemusic = 1;
        var8 setplayermusicstate(game["music"]["br_ring_med"][var10]);
        var8.initializerocketfuelreadings = "med" + var10;
      } else {
        var9 = game["music"]["br_ring_high"].size;
        var10 = randomint(var9);
        var11 = "high" + var10;

        if(isDefined(var10.initializerocketfuelreadings) && var11 == var10.initializerocketfuelreadings) {
          if(var10 == 0) {
            var10++;
          } else {
            var10--;
          }
        }

        var10.nosuspensemusic = 1;
        var10 setplayermusicstate(game["music"]["br_ring_high"][var10]);
        var10.initializerocketfuelreadings = "high" + var10;
      }
    }
  }

  var9 = undefined;
  var11 = undefined;
  thread decrement_num_of_frame_frozen();
}

function decrement_num_of_frame_frozen(var0) {
  level notify("circle_suspense_music_reset");
  level endon("circle_suspense_music_reset");
  level endon("final_circle_music");

  if(!isDefined(var0)) {
    var0 = 120;
  }

  wait var0;

  foreach(var2 in level.players) {
    var3 = tutorialprint_number(var2);

    if(var3) {
      var2.nosuspensemusic = undefined;
    }
  }
}

function ref_127a8() {
  level notify("stop_suspense_music");
}

function ref_127a9() {
  level endon("fiftypercent_music");

  if(isDefined(level.ref_13b31) && level.ref_13b31 == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  level notify("stop_suspense_music");
  var0 = risk_flagspawnshiftingcenter("plunder_tenpercent");
  setmusicstate(var0);
  level.ref_13b31 = 1;
}

function ref_1278b(var0) {
  level endon("seventyfivepercent_music");

  if(isDefined(level.play_hack_reminder_goto1) && level.play_hack_reminder_goto1 == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var1 = risk_flagspawnshiftingcenter("plunder_thirtypercent");
  setmusicstate(var1);
  level.play_hack_reminder_goto1 = 1;
  level notify("fiftypercent_music");
}

function ref_127a7(var0) {
  level endon("ninetypercent_music");

  if(isDefined(level.ref_1328e) && level.ref_1328e == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var1 = risk_flagspawnshiftingcenter("plunder_fiftypercent");
  setmusicstate(var1);
  level.ref_1328e = 1;
  level notify("seventyfivepercent_music");
}

function ref_12791(var0) {
  if(isDefined(level.ref_11e8b) && level.ref_11e8b == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var1 = risk_flagspawnshiftingcenter("plunder_seventyfivepercent");
  setmusicstate(var1);
  level.ref_11e8b = 1;
  level notify("ninetypercent_music");
}

function ref_12792() {
  if(isDefined(level.ref_12190) && level.ref_12190 == 1) {
    return;
  }

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  var0 = risk_flagspawnshiftingcenter("plunder_ninetypercent");
  setmusicstate(var0);
  level.ref_12190 = 1;
}

function ismusicenabled() {
  return !level.hardcoremode && level.musicenabled > 0;
}

function tutorialprint_number(var0) {
  var1 = !istrue(level.nosuspensemusic);
  var2 = !istrue(game["inLiveLobby"]);
  var3 = istrue(game["liveLobbyCompleted"]);
  var4 = !isDefined(level.matchcountdowntime);
  var5 = var1 && var2 && var3 && var4;

  if(isDefined(var0) && isPlayer(var0) && var5) {
    var6 = isalive(var0);
    var7 = isbot(var0);
    var8 = isDefined(level.audio_player_stop_mud_loop[var0 getxuid()]);
    var9 = var0 scripts\mp\gametypes\br_public::isplayeringulag();
    var10 = var5 && var6 && !var7 && !var8 && !var9;
    return var10;
  }

  return var10;
}