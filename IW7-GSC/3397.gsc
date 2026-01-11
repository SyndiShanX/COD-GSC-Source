/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3397.gsc
***************************************/

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
  level.func_3C2B = [];
  level.func_28BF = 0;
  level.func_13BD1 = 0;
  level.func_13BD2 = 0;
  level.func_13BCD = 0;
  level.func_13BCE = 0;
  level.func_13BCF = 0;
  level.func_13BD0 = 0;
  level.ghostskullstimestart = 0;
  level.ghostskulls_complete_status = 0;
  level.ghostskulls_total_waves = 0;
  level.defense_sequence_duration = 0;
  level.transactionid = 0;
  level.analyticsendgame = ::func_13F5C;
  level.func_311A = 0;
  level.func_D71D = ["front_gate", "hidden_room", "moon", "moon_outside_begin", "moon_rocket_space", "moon_second", "moon_bridge", "arcade", "arcade_back", "europa_tunnel", "room_europa", "europa_2", "roller_coast_back", "swamp_stage", "mars_3", "mars"];
  level.power_on = 0;
  level.func_D746 = 0;
  level.func_2137 = 0;
  level.revive_success_analytics_func = ::func_13F51;
  level.pap_firsttime = 0;
  level.func_AE60 = ["iw7_nrg", "iw7_emc", "iw7_revolver", "iw7_g18", "iw7_g18c", "iw7_erad", "iw7_crb", "iw7_smgmags", "iw7_ripper", "iw7_fhr", "iw7_ump45", "iw7_ump45c", "iw7_knife", "iw7_fists", "iw7_reaperblade", "iw7_ar57", "iw7_ake", "iw7_m4", "iw7_fmg", "iw7_sdfar", "iw7_arclassic", "iw7_kbs", "iw7_m8", "iw7_cheytac", "iw7_cheytacc", "iw7_m1", "iw7_m1c", "iw7_devastator", "iw7_sonic", "iw7_sdfshotty", "iw7_spas", "iw7_spasc", "iw7_mauler", "iw7_sdflmg", "iw7_lmg03", "iw7_lockon", "iw7_glprox", "iw7_chargeshot", "iw7_rvn", "iw7_udm45", "iw7_vr", "iw7_crdb", "iw7_mp28", "iw7_minilmg", "iw7_mod2187", "iw7_ba50cal", "iw7_gauss", "iw7_longshot", "iw7_unsalmg", "iw7_mag", "iw7_tacburst"];
  level.arcade_games_progress = ["arcade_spider", "arcade_barnstorming", "arcade_cosmic", "arcade_demon", "arcade_pitfall", "arcade_riverraid", "arcade_robottank", "arcade_starmaster", "bowling_for_planets", "bowling_for_planets_afterlife", "coaster", "laughingclown", "laughingclown_afterlife", "basketball_game", "basketball_game_afterlife", "clown_tooth_game", "clown_tooth_game_afterlife", "game_race", "shooting_gallery", "shooting_gallery_afterlife"];
}

func_13F51(var_00) {
  scripts\cp\cp_analytics::func_AF6A("revived_another_player", 1, [var_0.clientid], [var_0.clientid], [var_0.clientid]);
}

func_97A4(var_00) {
  var_00 endon("disconnect");
  var_0.achievement_registration_func = scripts\cp\zombies\achievement::register_default_achievements;
  scripts\cp\zombies\achievement::init_player_achievement(var_00);

  while(!isDefined(var_0.pers)) {
    wait 1;
  }

  var_0.func_1193D = [];
  var_0.killswithitem = [];
  var_0.itemtype = " ";
  var_0.func_118F0 = [];

  if(!isDefined(level.func_311A)) {
    level.func_311A = 0;
  }

  if(level.wave_num == 0) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"].func_11930 = [];
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1] = [];
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(var_0.pers["timesPerWave"])) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"].func_11930 = [];
    var_0.pers["timesPerWave"].func_11930[level.wave_num] = [];
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["coaster"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["game_race"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(var_0.pers["timesPerWave"].func_11930[level.wave_num + 1])) {
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].func_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  var_0.func_A03C = [];
  var_0.itemkills = [];
  var_0.func_A032 = " ";
  var_0.func_A037 = " ";
  var_0.itempicked = " ";
  var_0.func_A03C[var_0.itempicked] = 0;
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

  var_01 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_03 in var_01) {
    if(!isDefined(var_0.trapkills[var_03])) {
      var_0.trapkills[var_03] = 0;
    }
  }

  var_05 = var_0._meth_8235;

  if(isDefined(var_05)) {
    foreach(var_07 in var_05) {
      var_0.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_07);

      if(!isDefined(var_0.aggregateweaponkills[var_0.weapon_name_log])) {
        var_0.aggregateweaponkills[var_0.weapon_name_log] = 0;
      }
    }
  }
}

func_AF67(var_00, var_01) {
  if(isDefined(var_0.score_earned)) {
    var_0.score_earned = var_0.score_earned + var_01;
  }

  scripts\cp\cp_analytics::func_AF6A("currency_earned", var_01, [var_01], [var_0.clientid], [var_0.clientid]);
}

log_zombiedeath(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_03) && var_03 != "none") {
    scripts\cp\cp_analytics::func_AF6A("zombie_death", var_00, [var_01, var_2.clientid, var_03, var_04, "" + var_05], [var_2.clientid, var_03], [var_2.clientid]);
  }
}

func_AF90(var_00, var_01, var_02, var_03) {
  scripts\cp\cp_analytics::func_AF6A("wave_complete", 1, [level.script, var_00, var_01, var_02, var_03], [level.script]);

  foreach(var_05 in level.players) {
  var_5.logevent = "wave_complete";
  }
}

func_AF68(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(isDefined(var_04)) {
    var_08 = var_4.agent_type;
  }
  else {
    var_08 = "";
  }

  scripts\cp\cp_analytics::func_AF6A("dropped_to_last_stand", var_00, [var_1.clientid, var_03, var_08, "" + var_05, var_06, var_07], [var_1.clientid, var_02], [var_1.clientid]);

  if(!isDefined(var_1.logevent)) {
    var_1.logevent = "droppedToLastStand";
  }

  var_1.logevent = "droppedToLastStand";
}

log_enteringafterlifearcade(var_00, var_01, var_02, var_03, var_04) {
  scripts\cp\cp_analytics::func_AF6A("entering_afterlife_arcade", var_00, [var_1.clientid, var_02, var_03, var_04], [var_1.clientid, var_03], [var_1.clientid]);
}

func_45F3(var_00) {
  switch (var_00) {
    case "Wave Complete":
      return 1;
    case "Self Revive":
      return 2;
    default:
      return 1;
  }
}

log_exitingafterlifearcade(var_00, var_01, var_02, var_03, var_04) {
  var_05 = func_45F3(var_03);
  scripts\cp\cp_analytics::func_AF6A("exiting_afterlife_arcade", var_00, [var_1.clientid, var_02, var_05, var_04], [var_1.clientid, var_05]);
}

func_AF8E(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("turning_on_the_power", 1, [level.script, var_00, var_01], [level.script]);
}

func_AF7E(var_00, var_01, var_02, var_03, var_04) {
  scripts\cp\cp_persistence::increment_player_career_doors_opened(var_01);
  scripts\cp\cp_analytics::func_AF6A("opening_the_doors", var_00, [var_1.clientid, var_02, var_03, var_04], [var_1.clientid, var_02]);
}

log_purchasingforateamdoor(var_00, var_01, var_02, var_03, var_04) {
  scripts\cp\cp_analytics::func_AF6A("purchasing_for_a_team_door", var_00, [var_1.clientid, var_02, var_03, var_04], [var_1.clientid, var_02]);
}

func_AF62(var_00, var_01) {
  if(var_00 != "next_challenge") {
    scripts\cp\cp_analytics::func_AF6A("challenge_activated", 1, [level.script, var_00, var_01], [level.script]);
  }
}

func_AF63(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("challenge_completed", 1, [level.script, var_00, var_01, var_02], [level.script]);
}

func_AF64(var_00, var_01, var_02, var_03) {
  scripts\cp\cp_analytics::func_AF6A("challenge_failed", 1, [level.script, var_00, var_01, int(var_02), var_03], [level.script]);
}

func_AF79(var_00) {
  scripts\cp\cp_analytics::func_AF6A("magic_box_used", 1, [level.script, var_00], [level.script]);
}

log_purchasingaweapon(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isDefined(var_03)) {
    var_03 = "none";
  }

  if(var_03 == "none") {
    var_1.wavesheldwithweapon[getweaponbasename(var_02)] = var_04;

    if(isDefined(var_7[var_03])) {
      var_09 = var_7[var_03];
    }
    else {
      var_09 = 0;
    }

    if(isDefined(var_8[var_03])) {
      var_10 = var_8[var_03];
    }
    else {
      var_10 = 0;
    }

    var_06 = 0;
  } else {
    var_11 = var_1.wavesheldwithweapon[getweaponbasename(var_03)];
    var_06 = var_04 - var_11;
    var_1.wavesheldwithweapon[getweaponbasename(var_02)] = var_04;

    if(!isDefined(var_1.killsperweaponlog[var_03])) {
      var_1.killsperweaponlog[var_03] = 0;
    }

    if(!isDefined(var_1.downsperweaponlog[var_03])) {
      var_1.downsperweaponlog[var_03] = 0;
    }

    var_09 = var_1.killsperweaponlog[var_03];
    var_10 = var_1.downsperweaponlog[var_03];
  }

  scripts\cp\cp_analytics::func_AF6A("purchasing_weapon", var_00, [var_1.clientid, var_02, var_03, var_04, var_05, var_06, var_09, var_10], [var_1.clientid, var_09]);
}

log_atmused(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("atm_used", var_00, [var_01, var_2.clientid], [var_2.clientid, var_01]);
}

func_AF85(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("portal_used", 1, [level.script, var_00, var_01], [level.script]);
}

log_itemcrafted(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("souvenir_item_crafted", 1, [level.script, var_00, var_01], [level.script]);
}

log_lostandfound(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("lost_and_found", 1, [level.script, var_00, var_01, var_02], [level.script]);
}

log_fafcardused(var_00, var_01, var_02, var_03) {
  scripts\cp\cp_analytics::func_AF6A("faf_card_used", var_00, [var_01, var_02, var_3.clientid], [var_3.clientid, var_02]);
}

log_fafrefill(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("faf_card_refill", var_00, [var_01, var_2.clientid], [var_2.clientid, var_01]);
}

log_papused(var_00, var_01, var_02) {
  var_03 = scripts\cp\utility::getbaseweaponname(var_01);
  scripts\cp\cp_analytics::func_AF6A("pack_a_punch_used", 1, [level.script, var_00, var_03, var_02], [level.script]);
}

log_souvenircoindeposited(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("souvenir_coin_used", 1, [level.script, var_00, var_01], [level.script]);
}

func_AF66(var_00, var_01, var_02, var_03, var_04, var_05) {
  scripts\cp\cp_analytics::func_AF6A("crafted_item_placed", var_00, [var_1.clientid, var_02, var_03, var_04, var_05], [var_1.clientid, var_03]);
}

func_AF74(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("interaction_status", 1, [level.script, var_00, var_01], [level.script]);
}

log_perk_machine_used(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("perk_machine_used", 1, [level.script, var_00, var_01], [level.script]);
}

log_perk_returned(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("perk_returned", 1, [level.script, var_00, var_01], [level.script]);
}

log_finished_mini_game(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_01 scripts\cp\zombies\achievement::update_achievement_arcade(var_01, var_03, var_02);

  if(var_05 > 0 && var_03 != "coaster") {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("arcade_complete", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
  }

  scripts\cp\cp_analytics::func_AF6A("finished_mini_game", var_00, [var_1.clientid, var_02, var_03, var_04, var_05, var_06], [var_1.clientid, var_03]);
}

func_AF82(var_00, var_01, var_02, var_03, var_04, var_05) {
  scripts\cp\cp_analytics::func_AF6A("pillage_event", var_00, [var_1.clientid, var_02, var_03, var_04, var_05], [var_1.clientid, var_03]);
}

log_item_purchase_with_tickets(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("item_purchase_with_tickets", 1, [level.script, var_00, var_01, var_02], [level.script]);
}

func_AF76(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("item_replaced", 1, [level.script, var_00, var_01], [level.script]);
}

func_AF7D(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("neil_head_found", var_00, [level.script, var_00], [level.script]);
  scripts\cp\cp_analytics::func_AF6A("neil_head_placed", var_01, [level.script, var_01], [level.script]);
}

func_AF7B(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("neil_battery", var_00, [level.script, var_00, var_01], [level.script]);
}

func_AF7C(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("neil_floppy", var_00, [level.script, var_00, var_01], [level.script]);
}

log_balloons_popped(var_00) {
  scripts\cp\cp_analytics::func_AF6A("balloons_popped", var_00, [level.script, var_00], [level.script]);
}

log_shooting_icemonster_coaster(var_00) {
  scripts\cp\cp_analytics::func_AF6A("shot_icemonster", var_00, [level.script, var_00], [level.script]);
}

log_ghost_spelled(var_00) {
  scripts\cp\cp_analytics::func_AF6A("ghost_spelled", var_00, [level.script, var_00], [level.script]);
}

log_1984_kills(var_00) {
  scripts\cp\cp_analytics::func_AF6A("1984_kills", undefined, [var_00], undefined);
}

log_beating_arcade_games(var_00) {
  scripts\cp\cp_analytics::func_AF6A("beating_arcade_games", var_00, [level.script, var_00], [level.script]);
}

log_brute_hits_cabinet(var_00) {
  scripts\cp\cp_analytics::func_AF6A("brute_hits_cabinet", var_00, [level.script, var_00], [level.script]);
}

log_activate_enter_ghostskulls_game(var_00) {
  scripts\cp\cp_analytics::func_AF6A("activate_enter_ghostskulls_game", var_00, [level.script, var_00], [level.script]);
}

log_player_exits_ghostskulls_games(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("player_exits_ghostskulls_games", var_00, [level.script, var_00, var_01, int(var_02)], [level.script]);
}

log_frequency_device_collected(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("frequency_device_collected", var_00, [level.script, var_00, var_01, var_02], [level.script]);
}

log_frequency_device_crafted_dj(var_00, var_01) {
  scripts\cp\cp_analytics::func_AF6A("frequency_device_crafted_dj", var_00, [level.script, var_00, var_01], [level.script]);
}

log_speaker_defence_sequence_ends(var_00, var_01, var_02, var_03) {
  scripts\cp\cp_analytics::func_AF6A("speaker_defence_sequence_ends", var_00, [level.script, var_00, "" + var_01, var_02, var_03], [level.script]);
}

log_tone_sequence_activated(var_00) {
  scripts\cp\cp_analytics::func_AF6A("tone_sequence_activated", var_00, [level.script, var_00], [level.script]);
}

log_suicide_bomber_sequence_activated(var_00) {
  scripts\cp\cp_analytics::func_AF6A("suicide_bomber_sequence_activated", var_00, [level.script, var_00], [level.script]);
}

log_grey_sequence_activated(var_00) {
  scripts\cp\cp_analytics::func_AF6A("grey_sequence_activated", var_00, [level.script, var_00], [level.script]);
}

log_ufo_destroyed(var_00) {
  scripts\cp\cp_analytics::func_AF6A("ufo_destroyed", var_00, [level.script, var_00], [level.script]);
}

log_session_xp_earned(var_00, var_01, var_02, var_03) {
  scripts\cp\cp_analytics::func_AF6A("xp_earned", var_00, [var_01, var_2.clientid, var_03], [var_2.clientid, var_01]);
}

func_AF73(var_00, var_01) {
  foreach(var_06, var_03 in var_1.headshots) {
    if(var_06 == "none" || var_06 == "" || var_03 == 0 || !scripts\engine\utility::array_contains(level.func_AE60, var_06)) {
      continue;
    }
    var_04 = scripts\cp\utility::getbaseweaponname(var_06);
    setclientmatchdata("player", var_00, "headShots", var_04, var_03);
    var_05 = var_01 getrankedplayerdata("cp", "headShots", var_04);
    var_01 setrankedplayerdata("cp", "headShots", var_04, var_05 + var_03);
  }

  setclientmatchdata("player", var_00, "total_headshots", var_1.total_match_headshots);
}

log_card_data(var_00, var_01) {
  if(!isDefined(var_1.consumables)) {
    return;
  }
  foreach(var_05, var_03 in var_1.consumables) {
    var_04 = var_01 getrankedplayerdata("cp", "cards_used", var_05);
    var_01 setrankedplayerdata("cp", "cards_used", var_05, var_04 + var_3.times_used);
  }
}

log_explosive_kills(var_00, var_01) {
  if(!isDefined(var_1.explosive_kills)) {
    return;
  }
  var_02 = var_01 getrankedplayerdata("cp", "explosive_kills");
  var_01 setrankedplayerdata("cp", "explosive_kills", var_02 + var_1.explosive_kills);
}

func_AF91(var_00, var_01) {
  var_02 = 0;
  var_03 = 0;
  var_04 = "";

  foreach(var_08, var_06 in var_1.aggregateweaponkills) {
    if(var_08 == "none" || var_08 == "" || var_06 == 0 || !scripts\engine\utility::array_contains(level.func_AE60, var_08)) {
      continue;
    }
    setclientmatchdata("player", var_00, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_08), var_06);
    var_07 = var_01 getrankedplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_08));
    var_01 setrankedplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_08), var_07 + var_06);

    if(var_1.aggregateweaponkills[var_08] > 0 && var_02 == 0) {
      var_03 = var_1.aggregateweaponkills[var_08];
      var_02 = 1;
      var_04 = scripts\cp\utility::getbaseweaponname(var_08);
    }

    if(var_1.aggregateweaponkills[var_08] > var_03) {
      var_03 = var_1.aggregateweaponkills[var_08];
      var_04 = scripts\cp\utility::getbaseweaponname(var_08);
    }
  }

  if(var_03 > 0) {
    setclientmatchdata("player", var_00, "DeadliestWeapon", var_04);
    setclientmatchdata("player", var_00, "DeadliestWeaponKills", var_03);
  }

  var_09 = var_01 getrankedplayerdata("cp", "DeadliestWeaponName");
  var_07 = var_01 getrankedplayerdata("cp", "DeadliestWeaponKills", var_09);

  if(var_07 < var_03) {
    if(var_03 > 0) {
      var_10 = var_01 getrankedplayerdata("cp", "killsPerWeapon", var_04);

      if(!isDefined(var_1.aggregateweaponkills[var_04])) {
        var_01 setrankedplayerdata("cp", "DeadliestWeaponKills", var_04, var_10);
      }
      else {
        var_01 setrankedplayerdata("cp", "DeadliestWeaponKills", var_04, var_10);
      }

      var_01 setrankedplayerdata("cp", "DeadliestWeaponName", var_04);
    }
  } else {
    var_11 = var_01 getrankedplayerdata("cp", "killsPerWeapon", var_09);

    if(!isDefined(var_1.aggregateweaponkills[var_09])) {
      var_01 setrankedplayerdata("cp", "DeadliestWeaponKills", var_09, var_11);
    }
    else {
      var_01 setrankedplayerdata("cp", "DeadliestWeaponKills", var_09, var_1.aggregateweaponkills[var_09] + var_11);
    }

    var_01 setrankedplayerdata("cp", "DeadliestWeaponName", var_09);
  }
}

func_13F5C() {
  var_00 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_06, var_02 in level.players) {
    func_AF91(var_06, var_02);
    func_AF73(var_06, var_02);
    log_card_data(var_06, var_02);
    log_explosive_kills(var_06, var_02);

    foreach(var_04 in var_00) {
      if(isDefined(var_2.trapkills[var_04])) {
        var_2.total_trap_kills = var_2.total_trap_kills + var_2.trapkills[var_04];
      }
    }
  }
}

func_AF84(var_00, var_01) {}

log_playershotsontarget(var_00, var_01, var_02) {
  scripts\cp\cp_analytics::func_AF6A("shots_on_target", var_00, [var_1.clientid, var_02], [var_1.clientid, var_02]);
}

log_times_per_wave(var_00, var_01) {
  if(!isDefined(var_1.pers["timesPerWave"].func_11930)) {
    var_1.pers["timesPerWave"].func_11930 = [];
  }

  if(!isDefined(var_1.pers["timesPerWave"].func_11930[level.wave_num_at_start_of_game])) {
    var_1.pers["timesPerWave"].func_11930[level.wave_num_at_start_of_game] = [];
  }

  if(!isDefined(var_1.pers["timesPerWave"].func_11930[level.wave_num_at_start_of_game][var_00])) {
    var_1.pers["timesPerWave"].func_11930[level.wave_num_at_start_of_game][var_00] = 0;
  }

  var_1.pers["timesPerWave"].func_11930[level.wave_num_at_start_of_game][var_00]++;
}

log_hidden_song_one_found(var_00) {
  scripts\cp\cp_analytics::func_AF6A("hidden_song_one_discovered", undefined, [var_00], undefined);
}

log_hidden_song_two_found(var_00) {
  scripts\cp\cp_analytics::func_AF6A("hidden_song_two_discovered", undefined, [var_00], undefined);
}

log_crafted_wor_facemelter(var_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_facemelter", undefined, [var_00], undefined);
}

log_crafted_wor_headcutter(var_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_headcutter", undefined, [var_00], undefined);
}

log_crafted_wor_dischord(var_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_dischord", undefined, [var_00], undefined);
}

log_crafted_wor_shredder(var_00) {
  scripts\cp\cp_analytics::func_AF6A("crafted_wor_shredder", undefined, [var_00], undefined);
}

log_pink_ark_obtained(var_00) {
  scripts\cp\cp_analytics::func_AF6A("pink_ark_obtained", undefined, [var_00], undefined);
}