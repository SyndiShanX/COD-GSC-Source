/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

func_13F51(var_0) {
  scripts\cp\cp_analytics::func_AF6A("revived_another_player", 1, [var_0.clientid], [var_0.clientid], [var_0.clientid]);
}

func_97A4(var_0) {
  var_0 endon("disconnect");
  var_0.achievement_registration_func = scripts\cp\zombies\achievement::register_default_achievements;
  scripts\cp\zombies\achievement::init_player_achievement(var_0);
  while(!isDefined(var_0.pers)) {
    wait(1);
  }

  var_0.var_1193D = [];
  var_0.killswithitem = [];
  var_0.itemtype = " ";
  var_0.var_118F0 = [];
  if(!isDefined(level.var_311A)) {
    level.var_311A = 0;
  }

  if(level.wave_num == 0) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"].var_11930 = [];
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1] = [];
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(var_0.pers["timesPerWave"])) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"].var_11930 = [];
    var_0.pers["timesPerWave"].var_11930[level.wave_num] = [];
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["coaster"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["game_race"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(var_0.pers["timesPerWave"].var_11930[level.wave_num + 1])) {
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  var_0.var_A03C = [];
  var_0.itemkills = [];
  var_0.var_A032 = " ";
  var_0.var_A037 = " ";
  var_0.itempicked = " ";
  var_0.var_A03C[var_0.itempicked] = 0;
  var_0.itemkills[var_0.itempicked] = 0;
  if(!isDefined(var_0.totalxpearned)) {
    var_0.totalxpearned = 0;
  }

  if(!isDefined(var_0.score_earned)) {
    var_0.score_earned = 0;
  }

  var_0.downsperweaponlog = [];
  var_0.killsperweaponlog = [];
  var_0.wavesheldwithweapon = [];
  var_0.shotsfiredwithweapon = [];
  var_0.shotsontargetwithweapon = [];
  var_0.headshots = [];
  var_0.total_match_headshots = 0;
  var_0.aggregateweaponkills = [];
  var_0.weapon_name_log = " ";
  var_0.accuracy_shots_fired = 0;
  var_0.accuracy_shots_on_target = 0;
  var_0.explosive_kills = 0;
  var_0.total_trap_kills = 0;
  if(!isDefined(var_0.exitingafterlifearcade)) {
    var_0.exitingafterlifearcade = 0;
  }

  var_0.meleekill = 0;
  var_0.kung_fu_vo = 0;
  if(!isDefined(var_0.trapkills)) {
    var_0.trapkills = [];
  }

  var_1 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];
  foreach(var_3 in var_1) {
    if(!isDefined(var_0.trapkills[var_3])) {
      var_0.trapkills[var_3] = 0;
    }
  }

  var_5 = var_0.func_8235;
  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      var_0.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_7);
      if(!isDefined(var_0.aggregateweaponkills[var_0.weapon_name_log])) {
        var_0.aggregateweaponkills[var_0.weapon_name_log] = 0;
      }
    }
  }
}

func_AF67(var_0, var_1) {
  if(isDefined(var_0.score_earned)) {
    var_0.score_earned = var_0.score_earned + var_1;
  }

  scripts\cp\cp_analytics::func_AF6A("currency_earned", var_1, [var_1], [var_0.clientid], [var_0.clientid]);
}

log_zombiedeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3) && var_3 != "none") {
    scripts\cp\cp_analytics::func_AF6A("zombie_death", var_0, [var_1, var_2.clientid, var_3, var_4, "" + var_5], [var_2.clientid, var_3], [var_2.clientid]);
  }
}

func_AF90(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_analytics::func_AF6A("wave_complete", 1, [level.script, var_0, var_1, var_2, var_3], [level.script]);
  foreach(var_5 in level.players) {
    var_5.logevent = "wave_complete";
  }
}

func_AF68(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_4)) {
    var_8 = var_4.agent_type;
  } else {
    var_8 = "";
  }

  scripts\cp\cp_analytics::func_AF6A("dropped_to_last_stand", var_0, [var_1.clientid, var_3, var_8, "" + var_5, var_6, var_7], [var_1.clientid, var_2], [var_1.clientid]);
  if(!isDefined(var_1.logevent)) {
    var_1.logevent = "droppedToLastStand";
  }

  var_1.logevent = "droppedToLastStand";
}

log_enteringafterlifearcade(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp\cp_analytics::func_AF6A("entering_afterlife_arcade", var_0, [var_1.clientid, var_2, var_3, var_4], [var_1.clientid, var_3], [var_1.clientid]);
}

func_45F3(var_0) {
  switch (var_0) {
    case "Wave Complete":
      return 1;

    case "Self Revive":
      return 2;

    default:
      return 1;
  }
}

log_exitingafterlifearcade(var_0, var_1, var_2, var_3, var_4) {
  var_5 = func_45F3(var_3);
  scripts\cp\cp_analytics::func_AF6A("exiting_afterlife_arcade", var_0, [var_1.clientid, var_2, var_5, var_4], [var_1.clientid, var_5]);
}

func_AF8E(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("turning_on_the_power", 1, [level.script, var_0, var_1], [level.script]);
}

func_AF7E(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp\cp_persistence::increment_player_career_doors_opened(var_1);
  scripts\cp\cp_analytics::func_AF6A("opening_the_doors", var_0, [var_1.clientid, var_2, var_3, var_4], [var_1.clientid, var_2]);
}

log_purchasingforateamdoor(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp\cp_analytics::func_AF6A("purchasing_for_a_team_door", var_0, [var_1.clientid, var_2, var_3, var_4], [var_1.clientid, var_2]);
}

func_AF62(var_0, var_1) {
  if(var_0 != "next_challenge") {
    scripts\cp\cp_analytics::func_AF6A("challenge_activated", 1, [level.script, var_0, var_1], [level.script]);
  }
}

func_AF63(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("challenge_completed", 1, [level.script, var_0, var_1, var_2], [level.script]);
}

func_AF64(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_analytics::func_AF6A("challenge_failed", 1, [level.script, var_0, var_1, int(var_2), var_3], [level.script]);
}

func_AF79(var_0) {
  scripts\cp\cp_analytics::func_AF6A("magic_box_used", 1, [level.script, var_0], [level.script]);
}

log_purchasingaweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  if(var_3 == "none") {
    var_1.wavesheldwithweapon[getweaponbasename(var_2)] = var_4;
    if(isDefined(var_7[var_3])) {
      var_9 = var_7[var_3];
    } else {
      var_9 = 0;
    }

    if(isDefined(var_8[var_3])) {
      var_0A = var_8[var_3];
    } else {
      var_0A = 0;
    }

    var_6 = 0;
  } else {
    var_0B = var_3.wavesheldwithweapon[getweaponbasename(var_5)];
    var_6 = var_4 - var_0B;
    var_1.wavesheldwithweapon[getweaponbasename(var_2)] = var_4;
    if(!isDefined(var_1.killsperweaponlog[var_3])) {
      var_1.killsperweaponlog[var_3] = 0;
    }

    if(!isDefined(var_1.downsperweaponlog[var_3])) {
      var_1.downsperweaponlog[var_3] = 0;
    }

    var_9 = var_1.killsperweaponlog[var_3];
    var_0A = var_1.downsperweaponlog[var_3];
  }

  scripts\cp\cp_analytics::func_AF6A("purchasing_weapon", var_0, [var_1.clientid, var_2, var_3, var_4, var_5, var_6, var_9, var_0A], [var_1.clientid, var_9]);
}

log_atmused(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("atm_used", var_0, [var_1, var_2.clientid], [var_2.clientid, var_1]);
}

func_AF85(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("portal_used", 1, [level.script, var_0, var_1], [level.script]);
}

log_itemcrafted(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("souvenir_item_crafted", 1, [level.script, var_0, var_1], [level.script]);
}

log_lostandfound(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("lost_and_found", 1, [level.script, var_0, var_1, var_2], [level.script]);
}

log_fafcardused(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_analytics::func_AF6A("faf_card_used", var_0, [var_1, var_2, var_3.clientid], [var_3.clientid, var_2]);
}

log_fafrefill(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("faf_card_refill", var_0, [var_1, var_2.clientid], [var_2.clientid, var_1]);
}

log_papused(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::getbaseweaponname(var_1);
  scripts\cp\cp_analytics::func_AF6A("pack_a_punch_used", 1, [level.script, var_0, var_3, var_2], [level.script]);
}

log_souvenircoindeposited(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("souvenir_coin_used", 1, [level.script, var_0, var_1], [level.script]);
}

func_AF66(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\cp\cp_analytics::func_AF6A("crafted_item_placed", var_0, [var_1.clientid, var_2, var_3, var_4, var_5], [var_1.clientid, var_3]);
}

func_AF74(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("interaction_status", 1, [level.script, var_0, var_1], [level.script]);
}

log_perk_machine_used(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("perk_machine_used", 1, [level.script, var_0, var_1], [level.script]);
}

log_perk_returned(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("perk_returned", 1, [level.script, var_0, var_1], [level.script]);
}

log_finished_mini_game(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 scripts\cp\zombies\achievement::update_achievement_arcade(var_1, var_3, var_2);
  if(var_5 > 0 && var_3 != "coaster") {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("arcade_complete", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
  }

  scripts\cp\cp_analytics::func_AF6A("finished_mini_game", var_0, [var_1.clientid, var_2, var_3, var_4, var_5, var_6], [var_1.clientid, var_3]);
}

func_AF82(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\cp\cp_analytics::func_AF6A("pillage_event", var_0, [var_1.clientid, var_2, var_3, var_4, var_5], [var_1.clientid, var_3]);
}

log_item_purchase_with_tickets(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("item_purchase_with_tickets", 1, [level.script, var_0, var_1, var_2], [level.script]);
}

func_AF76(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("item_replaced", 1, [level.script, var_0, var_1], [level.script]);
}

func_AF7D(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("neil_head_found", var_0, [level.script, var_0], [level.script]);
  scripts\cp\cp_analytics::func_AF6A("neil_head_placed", var_1, [level.script, var_1], [level.script]);
}

func_AF7B(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("neil_battery", var_0, [level.script, var_0, var_1], [level.script]);
}

func_AF7C(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("neil_floppy", var_0, [level.script, var_0, var_1], [level.script]);
}

log_balloons_popped(var_0) {
  scripts\cp\cp_analytics::func_AF6A("balloons_popped", var_0, [level.script, var_0], [level.script]);
}

log_boss_fight_result(var_0) {
  scripts\cp\cp_analytics::func_AF6A("shot_icemonster", var_0, [level.script, var_0], [level.script]);
}

log_wave_dur_boss_fight(var_0) {
  scripts\cp\cp_analytics::func_AF6A("ghost_spelled", var_0, [level.script, var_0], [level.script]);
}

log_using_dc_mode(var_0) {
  scripts\cp\cp_analytics::func_AF6A("beating_arcade_games", var_0, [level.script, var_0], [level.script]);
}

log_using_boss_fight_playlist(var_0) {
  scripts\cp\cp_analytics::func_AF6A("brute_hits_cabinet", var_0, [level.script, var_0], [level.script]);
}

log_activate_enter_ghostskulls_game(var_0) {
  scripts\cp\cp_analytics::func_AF6A("activate_enter_ghostskulls_game", var_0, [level.script, var_0], [level.script]);
}

log_player_exits_ghostskulls_games(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("player_exits_ghostskulls_games", var_0, [level.script, var_0, var_1, int(var_2)], [level.script]);
}

log_frequency_device_collected(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("frequency_device_collected", var_0, [level.script, var_0, var_1, var_2], [level.script]);
}

log_frequency_device_crafted_dj(var_0, var_1) {
  scripts\cp\cp_analytics::func_AF6A("frequency_device_crafted_dj", var_0, [level.script, var_0, var_1], [level.script]);
}

log_speaker_defence_sequence_ends(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_analytics::func_AF6A("speaker_defence_sequence_ends", var_0, [level.script, var_0, "" + var_1, var_2, var_3], [level.script]);
}

log_tone_sequence_activated(var_0) {
  scripts\cp\cp_analytics::func_AF6A("tone_sequence_activated", var_0, [level.script, var_0], [level.script]);
}

log_suicide_bomber_sequence_activated(var_0) {
  scripts\cp\cp_analytics::func_AF6A("suicide_bomber_sequence_activated", var_0, [level.script, var_0], [level.script]);
}

log_grey_sequence_activated(var_0) {
  scripts\cp\cp_analytics::func_AF6A("grey_sequence_activated", var_0, [level.script, var_0], [level.script]);
}

log_ufo_destroyed(var_0) {
  scripts\cp\cp_analytics::func_AF6A("ufo_destroyed", var_0, [level.script, var_0], [level.script]);
}

log_session_xp_earned(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_analytics::func_AF6A("xp_earned", var_0, [var_1, var_2.clientid, var_3], [var_2.clientid, var_1]);
}

func_AF73(var_0, var_1) {
  foreach(var_6, var_3 in var_1.headshots) {
    if(var_6 == "none" || var_6 == "" || var_3 == 0 || !scripts\engine\utility::array_contains(level.var_AE60, var_6)) {
      continue;
    }

    var_4 = scripts\cp\utility::getbaseweaponname(var_6);
    setclientmatchdata("player", var_0, "headShots", var_4, var_3);
    var_5 = var_1 getplayerdata("cp", "headShots", var_4);
    var_1 setplayerdata("cp", "headShots", var_4, var_5 + var_3);
  }

  setclientmatchdata("player", var_0, "total_headshots", var_1.total_match_headshots);
}

log_card_data(var_0, var_1) {
  if(!isDefined(var_1.consumables)) {
    return;
  }

  foreach(var_5, var_3 in var_1.consumables) {
    var_4 = var_1 getplayerdata("cp", "cards_used", var_5);
    var_1 setplayerdata("cp", "cards_used", var_5, var_4 + var_3.times_used);
  }
}

log_explosive_kills(var_0, var_1) {
  if(!isDefined(var_1.explosive_kills)) {
    return;
  }

  var_2 = var_1 getplayerdata("cp", "explosive_kills");
  var_1 setplayerdata("cp", "explosive_kills", var_2 + var_1.explosive_kills);
}

func_AF91(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";
  foreach(var_8, var_6 in var_1.aggregateweaponkills) {
    if(var_8 == "none" || var_8 == "" || var_6 == 0 || !scripts\engine\utility::array_contains(level.var_AE60, var_8)) {
      continue;
    }

    setclientmatchdata("player", var_0, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_8), var_6);
    var_7 = var_1 getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_8));
    var_1 setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_8), var_7 + var_6);
    if(var_1.aggregateweaponkills[var_8] > 0 && var_2 == 0) {
      var_3 = var_1.aggregateweaponkills[var_8];
      var_2 = 1;
      var_4 = scripts\cp\utility::getbaseweaponname(var_8);
    }

    if(var_1.aggregateweaponkills[var_8] > var_3) {
      var_3 = var_1.aggregateweaponkills[var_8];
      var_4 = scripts\cp\utility::getbaseweaponname(var_8);
    }
  }

  if(var_3 > 0) {
    setclientmatchdata("player", var_0, "DeadliestWeapon", var_4);
    setclientmatchdata("player", var_0, "DeadliestWeaponKills", var_3);
  }

  var_9 = var_1 getplayerdata("cp", "DeadliestWeaponName");
  var_7 = var_1 getplayerdata("cp", "DeadliestWeaponKills", var_9);
  if(var_7 < var_3) {
    if(var_3 > 0) {
      var_0A = var_1 getplayerdata("cp", "killsPerWeapon", var_4);
      if(!isDefined(var_1.aggregateweaponkills[var_4])) {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_0A);
      } else {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_0A);
      }

      var_1 setplayerdata("cp", "DeadliestWeaponName", var_4);
      return;
    }

    return;
  }

  var_0B = var_2 getplayerdata("cp", "killsPerWeapon", var_0A);
  if(!isDefined(var_2.aggregateweaponkills[var_0A])) {
    var_2 setplayerdata("cp", "DeadliestWeaponKills", var_0A, var_0B);
  } else {
    var_2 setplayerdata("cp", "DeadliestWeaponKills", var_0A, var_2.aggregateweaponkills[var_0A] + var_0B);
  }

  var_2 setplayerdata("cp", "DeadliestWeaponName", var_0A);
}

func_13F5C() {
  var_0 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];
  foreach(var_6, var_2 in level.players) {
    func_AF91(var_6, var_2);
    func_AF73(var_6, var_2);
    log_card_data(var_6, var_2);
    log_explosive_kills(var_6, var_2);
    foreach(var_4 in var_0) {
      if(isDefined(var_2.trapkills[var_4])) {
        var_2.total_trap_kills = var_2.total_trap_kills + var_2.trapkills[var_4];
      }
    }
  }
}

func_AF84(var_0, var_1) {}

log_playershotsontarget(var_0, var_1, var_2) {
  scripts\cp\cp_analytics::func_AF6A("shots_on_target", var_0, [var_1.clientid, var_2], [var_1.clientid, var_2]);
}

log_times_per_wave(var_0, var_1) {
  if(!isDefined(var_1.pers["timesPerWave"].var_11930)) {
    var_1.pers["timesPerWave"].var_11930 = [];
  }

  if(!isDefined(var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game])) {
    var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game] = [];
  }

  if(!isDefined(var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][var_0])) {
    var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][var_0] = 0;
  }

  var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game][var_0]++;
}

log_hidden_song_one_found(var_0) {
  scripts\cp\cp_analytics::func_AF6A("hidden_song_one_discovered", undefined, [var_0], undefined);
}

log_hidden_song_two_found(var_0) {
  scripts\cp\cp_analytics::func_AF6A("hidden_song_two_discovered", undefined, [var_0], undefined);
}

log_crafted_wor_facemelter(var_0) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_facemelter", undefined, [var_0], undefined);
}

log_crafted_wor_headcutter(var_0) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_headcutter", undefined, [var_0], undefined);
}

log_crafted_wor_dischord(var_0) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_dischord", undefined, [var_0], undefined);
}

log_crafted_wor_shredder(var_0) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_shredder", undefined, [var_0], undefined);
}

log_pink_ark_obtained(var_0) {
  scripts\cp\cp_analytics::func_AF6A("pink_ark_obtained", undefined, [var_0], undefined);
}