/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_analytics.gsc
***************************************************/

init() {
  scripts\cp\cp_analytics::start_game_type("mp\zombieMatchdata.ddl", "mp\zombieclientmatchdata.ddl", "cp\zombies\zombie_analytics.csv");
  level.timesitemspicked = 0;
  level.timesitemstimedout = 0;
  level.timeslfused = 0;
  level.timespapused = 0;
  level.souvenircointype = " ";
  level.revocatorkills = [];
  level.revocatorkills = [];
  level.gascankills = [];
  level.gascanowner = [];
  level.gascanownercount = 0;
  level.revocatorownercount = 0;
  level.laststandnumber = 0;
  level.var_3C2B = [];
  level.var_28BF = 0;
  level.var_13BD1 = 0;
  level.var_13BD2 = 0;
  level.var_13BCD = 0;
  level.var_13BCE = 0;
  level.var_13BCF = 0;
  level.var_13BD0 = 0;
  level.ghostskullstimestart = 0;
  level.ghostskulls_complete_status = 0;
  level.ghostskulls_total_waves = 0;
  level.defense_sequence_duration = 0;
  level.transactionid = 0;
  level.analyticsendgame = ::func_13F5C;
  level.var_311A = 0;
  level.var_D71D = ["front_gate", "hidden_room", "moon", "moon_outside_begin", "moon_rocket_space", "moon_second", "moon_bridge", "arcade", "arcade_back", "europa_tunnel", "room_europa", "europa_2", "roller_coast_back", "swamp_stage", "mars_3", "mars"];
  level.power_on = 0;
  level.var_D746 = 0;
  level.var_2137 = 0;
  level.revive_success_analytics_func = ::func_13F51;
  level.pap_firsttime = 0;
  level.var_AE60 = ["iw7_nrg", "iw7_emc", "iw7_revolver", "iw7_g18", "iw7_g18c", "iw7_erad", "iw7_crb", "iw7_smgmags", "iw7_ripper", "iw7_fhr", "iw7_ump45", "iw7_ump45c", "iw7_knife", "iw7_fists", "iw7_reaperblade", "iw7_ar57", "iw7_ake", "iw7_m4", "iw7_fmg", "iw7_sdfar", "iw7_arclassic", "iw7_kbs", "iw7_m8", "iw7_cheytac", "iw7_cheytacc", "iw7_m1", "iw7_m1c", "iw7_devastator", "iw7_sonic", "iw7_sdfshotty", "iw7_spas", "iw7_spasc", "iw7_mauler", "iw7_sdflmg", "iw7_lmg03", "iw7_lockon", "iw7_glprox", "iw7_chargeshot", "iw7_rvn", "iw7_udm45", "iw7_vr", "iw7_crdb", "iw7_mp28", "iw7_minilmg", "iw7_mod2187", "iw7_ba50cal", "iw7_gauss", "iw7_longshot", "iw7_unsalmg", "iw7_mag", "iw7_tacburst"];
  level.arcade_games_progress = ["arcade_spider", "arcade_barnstorming", "arcade_cosmic", "arcade_demon", "arcade_pitfall", "arcade_riverraid", "arcade_robottank", "arcade_starmaster", "bowling_for_planets", "bowling_for_planets_afterlife", "coaster", "laughingclown", "laughingclown_afterlife", "basketball_game", "basketball_game_afterlife", "clown_tooth_game", "clown_tooth_game_afterlife", "game_race", "shooting_gallery", "shooting_gallery_afterlife"];
}

func_13F51(param_00) {
  scripts\cp\cp_analytics::func_AF6A("revived_another_player", 1, [param_00.clientid], [param_00.clientid], [param_00.clientid]);
}

func_97A4(param_00) {
  param_00 endon("disconnect");
  param_00.achievement_registration_func = ::scripts\cp\zombies\achievement::register_default_achievements;
  scripts\cp\zombies\achievement::init_player_achievement(param_00);
  while(!isDefined(param_00.pers)) {
    wait(1);
  }

  param_00.var_1193D = [];
  param_00.killswithitem = [];
  param_00.itemtype = " ";
  param_00.var_118F0 = [];
  if(!isDefined(level.var_311A)) {
    level.var_311A = 0;
  }

  if(level.wave_num == 0) {
    param_00.pers["timesPerWave"] = spawnStruct();
    param_00.pers["timesPerWave"].var_11930 = [];
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1] = [];
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(param_00.pers["timesPerWave"])) {
    param_00.pers["timesPerWave"] = spawnStruct();
    param_00.pers["timesPerWave"].var_11930 = [];
    param_00.pers["timesPerWave"].var_11930[level.wave_num] = [];
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["bowling_for_planets"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["bowling_for_planets_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["coaster"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["laughingclown"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["laughingclown_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["basketball_game"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["basketball_game_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["clown_tooth_game"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["clown_tooth_game_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["game_race"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["shooting_gallery"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(param_00.pers["timesPerWave"].var_11930[level.wave_num + 1])) {
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
    param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  param_00.var_A03C = [];
  param_00.itemkills = [];
  param_00.var_A032 = " ";
  param_00.var_A037 = " ";
  param_00.itempicked = " ";
  param_00.var_A03C[param_00.itempicked] = 0;
  param_00.itemkills[param_00.itempicked] = 0;
  if(!isDefined(param_00.totalxpearned)) {
    param_00.totalxpearned = 0;
  }

  if(!isDefined(param_00.score_earned)) {
    param_00.score_earned = 0;
  }

  param_00.downsperweaponlog = [];
  param_00.killsperweaponlog = [];
  param_00.wavesheldwithweapon = [];
  param_00.shotsfiredwithweapon = [];
  param_00.shotsontargetwithweapon = [];
  param_00.headshots = [];
  param_00.total_match_headshots = 0;
  param_00.aggregateweaponkills = [];
  param_00.weapon_name_log = " ";
  param_00.accuracy_shots_fired = 0;
  param_00.accuracy_shots_on_target = 0;
  param_00.explosive_kills = 0;
  param_00.total_trap_kills = 0;
  if(!isDefined(param_00.exitingafterlifearcade)) {
    param_00.exitingafterlifearcade = 0;
  }

  param_00.meleekill = 0;
  param_00.kung_fu_vo = 0;
  if(!isDefined(param_00.trapkills)) {
    param_00.trapkills = [];
  }

  var_01 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];
  foreach(var_03 in var_01) {
    if(!isDefined(param_00.trapkills[var_03])) {
      param_00.trapkills[var_03] = 0;
    }
  }

  var_05 = param_00._meth_8235;
  if(isDefined(var_05)) {
    foreach(var_07 in var_05) {
      param_00.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_07);
      if(!isDefined(param_00.aggregateweaponkills[param_00.weapon_name_log])) {
        param_00.aggregateweaponkills[param_00.weapon_name_log] = 0;
      }
    }
  }
}

func_AF67(param_00, param_01) {
  if(isDefined(param_00.score_earned)) {
    param_00.score_earned = param_00.score_earned + param_01;
  }

  scripts\cp\cp_analytics::func_AF6A("currency_earned", param_01, [param_01], [param_00.clientid], [param_00.clientid]);
}

log_zombiedeath(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_03) && param_03 != "none") {
    scripts\cp\cp_analytics::func_AF6A("zombie_death", param_00, [param_01, param_02.clientid, param_03, param_04, "" + param_05], [param_02.clientid, param_03], [param_02.clientid]);
  }
}

func_AF90(param_00, param_01, param_02, param_03) {
  scripts\cp\cp_analytics::func_AF6A("wave_complete", 1, [level.script, param_00, param_01, param_02, param_03], [level.script]);
  foreach(var_05 in level.players) {
    var_05.logevent = "wave_complete";
  }
}

func_AF68(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_04)) {
    var_08 = param_04.agent_type;
  } else {
    var_08 = "";
  }

  scripts\cp\cp_analytics::func_AF6A("dropped_to_last_stand", param_00, [param_01.clientid, param_03, var_08, "" + param_05, param_06, param_07], [param_01.clientid, param_02], [param_01.clientid]);
  if(!isDefined(param_01.logevent)) {
    param_01.logevent = "droppedToLastStand";
  }

  param_01.logevent = "droppedToLastStand";
}

log_enteringafterlifearcade(param_00, param_01, param_02, param_03, param_04) {
  scripts\cp\cp_analytics::func_AF6A("entering_afterlife_arcade", param_00, [param_01.clientid, param_02, param_03, param_04], [param_01.clientid, param_03], [param_01.clientid]);
}

func_45F3(param_00) {
  switch (param_00) {
    case "Wave Complete":
      return 1;

    case "Self Revive":
      return 2;

    default:
      return 1;
  }
}

log_exitingafterlifearcade(param_00, param_01, param_02, param_03, param_04) {
  var_05 = func_45F3(param_03);
  scripts\cp\cp_analytics::func_AF6A("exiting_afterlife_arcade", param_00, [param_01.clientid, param_02, var_05, param_04], [param_01.clientid, var_05]);
}

func_AF8E(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("turning_on_the_power", 1, [level.script, param_00, param_01], [level.script]);
}

func_AF7E(param_00, param_01, param_02, param_03, param_04) {
  scripts\cp\cp_persistence::increment_player_career_doors_opened(param_01);
  scripts\cp\cp_analytics::func_AF6A("opening_the_doors", param_00, [param_01.clientid, param_02, param_03, param_04], [param_01.clientid, param_02]);
}

log_purchasingforateamdoor(param_00, param_01, param_02, param_03, param_04) {
  scripts\cp\cp_analytics::func_AF6A("purchasing_for_a_team_door", param_00, [param_01.clientid, param_02, param_03, param_04], [param_01.clientid, param_02]);
}

func_AF62(param_00, param_01) {
  if(param_00 != "next_challenge") {
    scripts\cp\cp_analytics::func_AF6A("challenge_activated", 1, [level.script, param_00, param_01], [level.script]);
  }
}

func_AF63(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("challenge_completed", 1, [level.script, param_00, param_01, param_02], [level.script]);
}

func_AF64(param_00, param_01, param_02, param_03) {
  scripts\cp\cp_analytics::func_AF6A("challenge_failed", 1, [level.script, param_00, param_01, int(param_02), param_03], [level.script]);
}

func_AF79(param_00) {
  scripts\cp\cp_analytics::func_AF6A("magic_box_used", 1, [level.script, param_00], [level.script]);
}

log_purchasingaweapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_03)) {
    param_03 = "none";
  }

  if(param_03 == "none") {
    param_01.wavesheldwithweapon[getweaponbasename(param_02)] = param_04;
    if(isDefined(param_07[param_03])) {
      var_09 = param_07[param_03];
    } else {
      var_09 = 0;
    }

    if(isDefined(param_08[param_03])) {
      var_0A = param_08[param_03];
    } else {
      var_0A = 0;
    }

    param_06 = 0;
  } else {
    var_0B = param_03.wavesheldwithweapon[getweaponbasename(param_05)];
    param_06 = param_04 - var_0B;
    param_01.wavesheldwithweapon[getweaponbasename(param_02)] = param_04;
    if(!isDefined(param_01.killsperweaponlog[param_03])) {
      param_01.killsperweaponlog[param_03] = 0;
    }

    if(!isDefined(param_01.downsperweaponlog[param_03])) {
      param_01.downsperweaponlog[param_03] = 0;
    }

    var_09 = param_01.killsperweaponlog[param_03];
    var_0A = param_01.downsperweaponlog[param_03];
  }

  scripts\cp\cp_analytics::func_AF6A("purchasing_weapon", param_00, [param_01.clientid, param_02, param_03, param_04, param_05, param_06, var_09, var_0A], [param_01.clientid, var_09]);
}

log_atmused(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("atm_used", param_00, [param_01, param_02.clientid], [param_02.clientid, param_01]);
}

func_AF85(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("portal_used", 1, [level.script, param_00, param_01], [level.script]);
}

log_itemcrafted(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("souvenir_item_crafted", 1, [level.script, param_00, param_01], [level.script]);
}

log_lostandfound(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("lost_and_found", 1, [level.script, param_00, param_01, param_02], [level.script]);
}

log_fafcardused(param_00, param_01, param_02, param_03) {
  scripts\cp\cp_analytics::func_AF6A("faf_card_used", param_00, [param_01, param_02, param_03.clientid], [param_03.clientid, param_02]);
}

log_fafrefill(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("faf_card_refill", param_00, [param_01, param_02.clientid], [param_02.clientid, param_01]);
}

log_papused(param_00, param_01, param_02) {
  var_03 = scripts\cp\utility::getbaseweaponname(param_01);
  scripts\cp\cp_analytics::func_AF6A("pack_a_punch_used", 1, [level.script, param_00, var_03, param_02], [level.script]);
}

log_souvenircoindeposited(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("souvenir_coin_used", 1, [level.script, param_00, param_01], [level.script]);
}

func_AF66(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\cp\cp_analytics::func_AF6A("crafted_item_placed", param_00, [param_01.clientid, param_02, param_03, param_04, param_05], [param_01.clientid, param_03]);
}

func_AF74(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("interaction_status", 1, [level.script, param_00, param_01], [level.script]);
}

log_perk_machine_used(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("perk_machine_used", 1, [level.script, param_00, param_01], [level.script]);
}

log_perk_returned(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("perk_returned", 1, [level.script, param_00, param_01], [level.script]);
}

log_finished_mini_game(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_01 scripts\cp\zombies\achievement::update_achievement_arcade(param_01, param_03, param_02);
  if(param_05 > 0 && param_03 != "coaster") {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("arcade_complete", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
  }

  scripts\cp\cp_analytics::func_AF6A("finished_mini_game", param_00, [param_01.clientid, param_02, param_03, param_04, param_05, param_06], [param_01.clientid, param_03]);
}

func_AF82(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\cp\cp_analytics::func_AF6A("pillage_event", param_00, [param_01.clientid, param_02, param_03, param_04, param_05], [param_01.clientid, param_03]);
}

log_item_purchase_with_tickets(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("item_purchase_with_tickets", 1, [level.script, param_00, param_01, param_02], [level.script]);
}

func_AF76(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("item_replaced", 1, [level.script, param_00, param_01], [level.script]);
}

func_AF7D(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("neil_head_found", param_00, [level.script, param_00], [level.script]);
  scripts\cp\cp_analytics::func_AF6A("neil_head_placed", param_01, [level.script, param_01], [level.script]);
}

func_AF7B(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("neil_battery", param_00, [level.script, param_00, param_01], [level.script]);
}

func_AF7C(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("neil_floppy", param_00, [level.script, param_00, param_01], [level.script]);
}

log_balloons_popped(param_00) {
  scripts\cp\cp_analytics::func_AF6A("balloons_popped", param_00, [level.script, param_00], [level.script]);
}

log_boss_fight_result(param_00) {
  scripts\cp\cp_analytics::func_AF6A("shot_icemonster", param_00, [level.script, param_00], [level.script]);
}

log_wave_dur_boss_fight(param_00) {
  scripts\cp\cp_analytics::func_AF6A("ghost_spelled", param_00, [level.script, param_00], [level.script]);
}

log_using_dc_mode(param_00) {
  scripts\cp\cp_analytics::func_AF6A("beating_arcade_games", param_00, [level.script, param_00], [level.script]);
}

log_using_boss_fight_playlist(param_00) {
  scripts\cp\cp_analytics::func_AF6A("brute_hits_cabinet", param_00, [level.script, param_00], [level.script]);
}

log_activate_enter_ghostskulls_game(param_00) {
  scripts\cp\cp_analytics::func_AF6A("activate_enter_ghostskulls_game", param_00, [level.script, param_00], [level.script]);
}

log_player_exits_ghostskulls_games(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("player_exits_ghostskulls_games", param_00, [level.script, param_00, param_01, int(param_02)], [level.script]);
}

log_frequency_device_collected(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("frequency_device_collected", param_00, [level.script, param_00, param_01, param_02], [level.script]);
}

log_frequency_device_crafted_dj(param_00, param_01) {
  scripts\cp\cp_analytics::func_AF6A("frequency_device_crafted_dj", param_00, [level.script, param_00, param_01], [level.script]);
}

log_speaker_defence_sequence_ends(param_00, param_01, param_02, param_03) {
  scripts\cp\cp_analytics::func_AF6A("speaker_defence_sequence_ends", param_00, [level.script, param_00, "" + param_01, param_02, param_03], [level.script]);
}

log_tone_sequence_activated(param_00) {
  scripts\cp\cp_analytics::func_AF6A("tone_sequence_activated", param_00, [level.script, param_00], [level.script]);
}

log_suicide_bomber_sequence_activated(param_00) {
  scripts\cp\cp_analytics::func_AF6A("suicide_bomber_sequence_activated", param_00, [level.script, param_00], [level.script]);
}

log_grey_sequence_activated(param_00) {
  scripts\cp\cp_analytics::func_AF6A("grey_sequence_activated", param_00, [level.script, param_00], [level.script]);
}

log_ufo_destroyed(param_00) {
  scripts\cp\cp_analytics::func_AF6A("ufo_destroyed", param_00, [level.script, param_00], [level.script]);
}

log_session_xp_earned(param_00, param_01, param_02, param_03) {
  scripts\cp\cp_analytics::func_AF6A("xp_earned", param_00, [param_01, param_02.clientid, param_03], [param_02.clientid, param_01]);
}

func_AF73(param_00, param_01) {
  foreach(var_06, var_03 in param_01.headshots) {
    if(var_06 == "none" || var_06 == "" || var_03 == 0 || !scripts\engine\utility::array_contains(level.var_AE60, var_06)) {
      continue;
    }

    var_04 = scripts\cp\utility::getbaseweaponname(var_06);
    setclientmatchdata("player", param_00, "headShots", var_04, var_03);
    var_05 = param_01 getplayerdata("cp", "headShots", var_04);
    param_01 setplayerdata("cp", "headShots", var_04, var_05 + var_03);
  }

  setclientmatchdata("player", param_00, "total_headshots", param_01.total_match_headshots);
}

log_card_data(param_00, param_01) {
  if(!isDefined(param_01.consumables)) {
    return;
  }

  foreach(var_05, var_03 in param_01.consumables) {
    var_04 = param_01 getplayerdata("cp", "cards_used", var_05);
    param_01 setplayerdata("cp", "cards_used", var_05, var_04 + var_03.times_used);
  }
}

log_explosive_kills(param_00, param_01) {
  if(!isDefined(param_01.explosive_kills)) {
    return;
  }

  var_02 = param_01 getplayerdata("cp", "explosive_kills");
  param_01 setplayerdata("cp", "explosive_kills", var_02 + param_01.explosive_kills);
}

func_AF91(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  var_04 = "";
  foreach(var_08, var_06 in param_01.aggregateweaponkills) {
    if(var_08 == "none" || var_08 == "" || var_06 == 0 || !scripts\engine\utility::array_contains(level.var_AE60, var_08)) {
      continue;
    }

    setclientmatchdata("player", param_00, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_08), var_06);
    var_07 = param_01 getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_08));
    param_01 setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_08), var_07 + var_06);
    if(param_01.aggregateweaponkills[var_08] > 0 && var_02 == 0) {
      var_03 = param_01.aggregateweaponkills[var_08];
      var_02 = 1;
      var_04 = scripts\cp\utility::getbaseweaponname(var_08);
    }

    if(param_01.aggregateweaponkills[var_08] > var_03) {
      var_03 = param_01.aggregateweaponkills[var_08];
      var_04 = scripts\cp\utility::getbaseweaponname(var_08);
    }
  }

  if(var_03 > 0) {
    setclientmatchdata("player", param_00, "DeadliestWeapon", var_04);
    setclientmatchdata("player", param_00, "DeadliestWeaponKills", var_03);
  }

  var_09 = param_01 getplayerdata("cp", "DeadliestWeaponName");
  var_07 = param_01 getplayerdata("cp", "DeadliestWeaponKills", var_09);
  if(var_07 < var_03) {
    if(var_03 > 0) {
      var_0A = param_01 getplayerdata("cp", "killsPerWeapon", var_04);
      if(!isDefined(param_01.aggregateweaponkills[var_04])) {
        param_01 setplayerdata("cp", "DeadliestWeaponKills", var_04, var_0A);
      } else {
        param_01 setplayerdata("cp", "DeadliestWeaponKills", var_04, var_0A);
      }

      param_01 setplayerdata("cp", "DeadliestWeaponName", var_04);
      return;
    }

    return;
  }

  var_0B = var_02 getplayerdata("cp", "killsPerWeapon", var_0A);
  if(!isDefined(var_02.aggregateweaponkills[var_0A])) {
    var_02 setplayerdata("cp", "DeadliestWeaponKills", var_0A, var_0B);
  } else {
    var_02 setplayerdata("cp", "DeadliestWeaponKills", var_0A, var_02.aggregateweaponkills[var_0A] + var_0B);
  }

  var_02 setplayerdata("cp", "DeadliestWeaponName", var_0A);
}

func_13F5C() {
  var_00 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];
  foreach(var_06, var_02 in level.players) {
    func_AF91(var_06, var_02);
    func_AF73(var_06, var_02);
    log_card_data(var_06, var_02);
    log_explosive_kills(var_06, var_02);
    foreach(var_04 in var_00) {
      if(isDefined(var_02.trapkills[var_04])) {
        var_02.total_trap_kills = var_02.total_trap_kills + var_02.trapkills[var_04];
      }
    }
  }
}

func_AF84(param_00, param_01) {}

log_playershotsontarget(param_00, param_01, param_02) {
  scripts\cp\cp_analytics::func_AF6A("shots_on_target", param_00, [param_01.clientid, param_02], [param_01.clientid, param_02]);
}

log_times_per_wave(param_00, param_01) {
  if(!isDefined(param_01.pers["timesPerWave"].var_11930)) {
    param_01.pers["timesPerWave"].var_11930 = [];
  }

  if(!isDefined(param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game])) {
    param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game] = [];
  }

  if(!isDefined(param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][param_00])) {
    param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][param_00] = 0;
  }

  param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][param_00]++;
}

log_hidden_song_one_found(param_00) {
  scripts\cp\cp_analytics::func_AF6A("hidden_song_one_discovered", undefined, [param_00], undefined);
}

log_hidden_song_two_found(param_00) {
  scripts\cp\cp_analytics::func_AF6A("hidden_song_two_discovered", undefined, [param_00], undefined);
}

log_crafted_wor_facemelter(param_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_facemelter", undefined, [param_00], undefined);
}

log_crafted_wor_headcutter(param_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_headcutter", undefined, [param_00], undefined);
}

log_crafted_wor_dischord(param_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_dischord", undefined, [param_00], undefined);
}

log_crafted_wor_shredder(param_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_shredder", undefined, [param_00], undefined);
}

log_pink_ark_obtained(param_00) {
  scripts\cp\cp_analytics::func_AF6A("pink_ark_obtained", undefined, [param_00], undefined);
}