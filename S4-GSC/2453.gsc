/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2453.gsc
*************************************************/

init() {
  _id_0705::_id_E5E8("ddl/mp/cp_matchdata.ddl", "ddl/mp/zombieclientmatchdata.ddl", "cp/zombies/zombie_analytics.csv");
  level._id_F274 = 0;
  level._id_F275 = 0;
  level._id_F276 = 0;
  level._id_F277 = 0;
  level._id_E073 = " ";
  level._id_C7FD = [];
  level._id_C7FE = [];
  level._id_61C8 = [];
  level._id_61C9 = [];
  level._id_61CA = 0;
  level._id_C7FF = 0;
  level._id_907F = 0;
  level._id_33AF = [];
  level._id_2342 = 0;
  level._id_10C9D = 0;
  level._id_10C9E = 0;
  level._id_10C99 = 0;
  level._id_10C9A = 0;
  level._id_10C9B = 0;
  level._id_10C9C = 0;
  level._id_6EAB = 0;
  level._id_6EA9 = 0;
  level._id_6EAA = 0;
  level._id_4629 = 0;
  level._id_F464 = 0;
  level._id_1765 = ::_id_1106C;
  level._id_2C43 = 0;
  level._id_BA98 = ["front_gate", "hidden_room", "moon", "moon_outside_begin", "moon_rocket_space", "moon_second", "moon_bridge", "arcade", "arcade_back", "europa_tunnel", "room_europa", "europa_2", "roller_coast_back", "swamp_stage", "mars_3", "mars"];
  level._id_BABA = 0;
  level._id_BABB = 0;
  level._id_1A50 = 0;
  level._id_C7D1 = ::_id_11046;
  level._id_AE0E = 0;
  level._id_965B = ["iw7_nrg", "iw7_emc", "iw7_revolver", "iw7_g18", "iw7_g18c", "iw7_erad", "iw7_crb", "iw7_smgmags", "iw7_ripper", "iw7_fhr", "iw7_ump45", "iw7_ump45c", "iw7_knife", "iw7_fists", "iw7_reaperblade", "iw7_ar57", "iw7_ake", "iw7_m4", "iw7_fmg", "iw7_sdfar", "iw7_arclassic", "iw7_kbs", "iw7_m8", "iw7_cheytac", "iw7_cheytacc", "iw7_m1", "iw7_m1c", "iw7_devastator", "iw7_sonic", "iw7_sdfshotty", "iw7_spas", "iw7_spasc", "iw7_mauler", "iw7_sdflmg", "iw7_lmg03", "iw7_lockon", "iw7_glprox", "iw7_chargeshot"];
  level._id_1A32 = ["arcade_spider", "arcade_barnstorming", "arcade_cosmic", "arcade_demon", "arcade_pitfall", "arcade_riverraid", "arcade_robottank", "arcade_starmaster", "bowling_for_planets", "bowling_for_planets_afterlife", "coaster", "laughingclown", "laughingclown_afterlife", "basketball_game", "basketball_game_afterlife", "clown_tooth_game", "clown_tooth_game_afterlife", "game_race", "shooting_gallery", "shooting_gallery_afterlife"];
}

_id_11046(var_0) {
  _id_0705::_id_9723("revived_another_player", 1, [var_0._id_399D], [var_0._id_399D], [var_0._id_399D]);
}

_id_8111(var_0) {
  var_0 endon("disconnect");
  var_0._id_0E69 = _id_097F::_id_C1DC;

  while(!isDefined(var_0.pers)) {
    wait 1;
  }

  var_0._id_F28C = [];
  var_0._id_8DF0 = [];
  var_0._id_8B3D = " ";
  var_0._id_F214 = [];

  if(!isDefined(level._id_2C43)) {
    level._id_2C43 = 0;
  }

  if(level._id_10C9F == 0) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"]._id_F279 = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1] = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(var_0.pers["timesPerWave"])) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"]._id_F279 = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F] = [];
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["coaster"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["laughingclown"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["basketball_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["game_race"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1])) {
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"]._id_F279[level._id_10C9F + 1]["shooting_gallery_afterlife"] = 0;
  }

  var_0._id_8B3E = [];
  var_0._id_8B32 = [];
  var_0._id_8B30 = " ";
  var_0._id_8B37 = " ";
  var_0._id_8B35 = " ";
  var_0._id_8B3E[var_0._id_8B35] = 0;
  var_0._id_8B32[var_0._id_8B35] = 0;

  if(!isDefined(var_0._id_F389)) {
    var_0._id_F389 = 0;
  }

  if(!isDefined(var_0._id_CBDD)) {
    var_0._id_CBDD = 0;
  }

  var_0._id_4EB5 = [];
  var_0._id_8DA4 = [];
  var_0._id_10CB8 = [];
  var_0._id_DA68 = [];
  var_0._id_DA6C = [];
  var_0._id_761D = [];
  var_0._id_F365 = 0;
  var_0._id_121F = [];
  var_0._id_10D09 = " ";
  var_0._id_0E5D = 0;
  var_0._id_0E5E = 0;
  var_0._id_57E3 = 0;
  var_0._id_F36B = 0;

  if(!isDefined(var_0._id_5784)) {
    var_0._id_5784 = 0;
  }

  var_0._id_9D91 = 0;
  var_0._id_8E56 = 0;

  if(!isDefined(var_0._id_F4BF)) {
    var_0._id_F4BF = [];
  }

  var_1 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_3 in var_1) {
    if(!isDefined(var_0._id_F4BF[var_3])) {
      var_0._id_F4BF[var_3] = 0;
    }
  }

  var_5 = var_0._id_6E8B;

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      var_0._id_10D09 = scripts\cp\utility::_id_6902(var_7);

      if(!isDefined(var_0._id_121F[var_0._id_10D09])) {
        var_0._id_121F[var_0._id_10D09] = 0;
      }
    }
  }
}

_id_9720(var_0, var_1) {
  if(isDefined(var_0._id_CBDD)) {
    var_0._id_CBDD = var_0._id_CBDD + var_1;
  }

  _id_0705::_id_9723("currency_earned", var_1, [var_1], [var_0._id_399D], [var_0._id_399D]);
}

_id_9752(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3) && var_3.basename != "none") {
    _id_0705::_id_9723("zombie_death", var_0, [var_1, var_2._id_399D, var_3, var_4, "" + var_5], [var_2._id_399D, var_3.basename], [var_2._id_399D]);
  }
}

_id_9750(var_0, var_1, var_2, var_3) {
  _id_0705::_id_9723("wave_complete", undefined, [var_0, var_1, var_2, var_3], undefined);

  foreach(var_5 in level.players) {
    if(!isDefined(var_5._id_9761)) {
      var_5._id_9761 = "wave_complete";
    }

    var_5._id_9761 = "wave_complete";
  }
}

_id_9721(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_4)) {
    var_8 = var_4._id_1210;
  } else {
    var_8 = "";
  }

  _id_0705::_id_9723("dropped_to_last_stand", var_0, [var_1._id_399D, var_3, var_8, "" + var_5, var_6, var_7], [var_1._id_399D, getcompleteweaponname(var_2)], [var_1._id_399D]);

  if(!isDefined(var_1._id_9761)) {
    var_1._id_9761 = "droppedToLastStand";
  }

  var_1._id_9761 = "droppedToLastStand";
}

_id_9722(var_0, var_1, var_2, var_3, var_4) {
  _id_0705::_id_9723("entering_afterlife_arcade", var_0, [var_1._id_399D, var_2, var_3, var_4], [var_1._id_399D, var_3], [var_1._id_399D]);
}

_id_3C7A(var_0) {
  switch (var_0) {
    case "Wave Complete":
      return 1;
    case "Self Revive":
      return 2;
    default:
      return 1;
  }
}

_id_9724(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_3C7A(var_3);
  _id_0705::_id_9723("exiting_afterlife_arcade", var_0, [var_1._id_399D, var_2, var_5, var_4], [var_1._id_399D, var_5]);
}

_id_974E(var_0, var_1) {
  _id_0705::_id_9723("turning_on_the_power", undefined, [var_0, var_1], undefined);
}

_id_973B(var_0, var_1, var_2, var_3, var_4) {
  _id_074E::_id_7DDA(var_1);
  _id_0705::_id_9723("opening_the_doors", var_0, [var_1._id_399D, var_2, var_3, var_4], [var_1._id_399D, var_2]);
}

_id_9746(var_0, var_1, var_2, var_3, var_4) {
  _id_0705::_id_9723("purchasing_for_a_team_door", var_0, [var_1._id_399D, var_2, var_3, var_4], [var_1._id_399D, var_2]);
}

_id_9717(var_0, var_1) {
  if(var_0 != "next_challenge") {
    _id_0705::_id_9723("challenge_activated", undefined, [var_0, var_1], undefined);
  }
}

_id_9718(var_0, var_1, var_2) {
  _id_0705::_id_9723("challenge_completed", undefined, [var_0, var_1, var_2], undefined);
}

_id_9719(var_0, var_1, var_2, var_3) {
  _id_0705::_id_9723("challenge_failed", undefined, [var_0, var_1, int(var_2), var_3], undefined);
}

_id_9735(var_0) {
  _id_0705::_id_9723("magic_box_used", undefined, [var_0], undefined);
}

_id_9745(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_3)) {
    var_3 = _func_0375();
  }

  var_9 = undefined;

  if(isweapon(var_2)) {
    var_9 = var_2;
  } else {
    var_9 = makeweaponfromstring(var_2);
  }

  if(isnullweapon(var_3)) {
    var_1._id_10CB8[getweaponbasename(var_9)] = var_4;
    var_10 = "none";

    if(isDefined(var_7[var_10])) {
      var_11 = var_7[var_10];
    } else {
      var_11 = 0;
    }

    if(isDefined(var_8[var_10])) {
      var_12 = var_8[var_10];
    } else {
      var_12 = 0;
    }

    var_6 = 0;
  } else {
    var_13 = var_1._id_10CB8[getweaponbasename(var_3)];
    var_6 = var_4 - var_13;
    var_1._id_10CB8[getweaponbasename(var_9)] = var_4;
    var_10 = getcompleteweaponname(var_3);

    if(!isDefined(var_1._id_8DA4[var_10])) {
      var_1._id_8DA4[var_10] = 0;
    }

    if(!isDefined(var_1._id_4EB5[var_10])) {
      var_1._id_4EB5[var_10] = 0;
    }

    var_11 = var_1._id_8DA4[var_10];
    var_12 = var_1._id_4EB5[var_10];
  }

  _id_0705::_id_9723("purchasing_weapon", var_0, [var_1._id_399D, getcompleteweaponname(var_9), getcompleteweaponname(var_3), var_4, var_5, var_6, var_11, var_12], [var_1._id_399D, var_11]);
}

_id_9711(var_0, var_1, var_2) {
  _id_0705::_id_9723("atm_used", var_0, [var_1, var_2._id_399D], [var_2._id_399D, var_1]);
}

_id_9744(var_0, var_1) {
  _id_0705::_id_9723("portal_used", undefined, [var_0, var_1], undefined);
}

_id_9733(var_0, var_1) {
  _id_0705::_id_9723("souvenir_coin_dropped", undefined, [var_0, var_1], undefined);
}

_id_9734(var_0, var_1, var_2) {
  _id_0705::_id_9723("lost_and_found", undefined, [var_0, var_1, var_2], undefined);
}

_id_9726(var_0, var_1, var_2, var_3) {
  _id_0705::_id_9723("faf_card_used", var_0, [var_1, var_2, var_3._id_399D], [var_3._id_399D, var_2]);
}

_id_9727(var_0, var_1, var_2) {
  _id_0705::_id_9723("faf_card_refill", var_0, [var_1, var_2._id_399D], [var_2._id_399D, var_1]);
}

_id_973C(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::_id_6902(var_1);
  _id_0705::_id_9723("pack_a_punch_used", undefined, [var_0, var_3, var_2], undefined);
}

_id_9749(var_0, var_1) {
  _id_0705::_id_9723("souvenir_coin_used", undefined, [var_0, var_1], undefined);
}

_id_971F(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0705::_id_9723("crafted_item_placed", var_0, [var_1._id_399D, var_2, var_3, var_4, var_5], [var_1._id_399D, var_3]);
}

_id_9730(var_0, var_1) {
  _id_0705::_id_9723("interaction_status", undefined, [var_0, var_1], undefined);
}

_id_973D(var_0, var_1) {
  _id_0705::_id_9723("perk_machine_used", undefined, [var_0, var_1], undefined);
}

_id_973E(var_0, var_1) {
  _id_0705::_id_9723("perk_returned", undefined, [var_0, var_1], undefined);
}

_id_9728(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 _id_097F::_id_FB33(var_1, var_3, var_2);

  if(var_5 > 0 && var_3 != "coaster") {
    var_1 thread _id_076F::_id_F72D("arcade_complete", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
  }

  _id_0705::_id_9723("finished_mini_game", var_0, [var_1._id_399D, var_2, var_3, var_4, var_5, var_6], [var_1._id_399D, var_3]);
}

_id_973F(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0705::_id_9723("pillage_event", var_0, [var_1._id_399D, var_2, var_3, var_4, var_5], [var_1._id_399D, var_3]);
}

_id_9731(var_0, var_1, var_2) {
  _id_0705::_id_9723("item_purchase_with_tickets", undefined, [var_0, var_1, var_2], undefined);
}

_id_9732(var_0, var_1) {
  _id_0705::_id_9723("item_replaced", undefined, [var_0, var_1], undefined);
}

_id_973A(var_0, var_1) {
  _id_0705::_id_9723("neil_head", undefined, [var_0, var_1], undefined);
}

_id_9738(var_0, var_1) {
  _id_0705::_id_9723("neil_battery", undefined, [var_0, var_1], undefined);
}

_id_9739(var_0, var_1) {
  _id_0705::_id_9723("neil_floppy", undefined, [var_0, var_1], undefined);
}

_id_9712(var_0) {
  _id_0705::_id_9723("balloons_popped", undefined, [var_0], undefined);
}

_id_9748(var_0) {
  _id_0705::_id_9723("shot_icemonster", undefined, [var_0], undefined);
}

_id_972B(var_0) {
  _id_0705::_id_9723("ghost_spelled", undefined, [var_0], undefined);
}

_id_970F(var_0) {
  _id_0705::_id_9723("1984_kills", undefined, [var_0], undefined);
}

_id_9713(var_0) {
  _id_0705::_id_9723("beating_arcade_games", undefined, [var_0], undefined);
}

_id_9715(var_0) {
  _id_0705::_id_9723("brute_hits_cabinet", undefined, [var_0], undefined);
}

_id_9710(var_0) {
  _id_0705::_id_9723("activate_enter_ghostskulls_game", undefined, [var_0], undefined);
}

_id_9741(var_0, var_1, var_2) {
  _id_0705::_id_9723("player_exits_ghostskulls_games", undefined, [var_0, var_1, int(var_2)], undefined);
}

_id_9729(var_0, var_1, var_2) {
  _id_0705::_id_9723("frequency_device_collected", undefined, [var_0, var_1, var_2], undefined);
}

_id_972A(var_0, var_1) {
  _id_0705::_id_9723("frequency_device_crafted_dj", undefined, [var_0, var_1], undefined);
}

_id_974A(var_0, var_1, var_2, var_3) {
  _id_0705::_id_9723("speaker_defence_sequence_ends", undefined, [var_0, "" + var_1, var_2, var_3], undefined);
}

_id_974D(var_0) {
  _id_0705::_id_9723("tone_sequence_activated", undefined, [var_0], undefined);
}

_id_974B(var_0) {
  _id_0705::_id_9723("suicide_bomber_sequence_activated", undefined, [var_0], undefined);
}

_id_972C(var_0) {
  _id_0705::_id_9723("grey_sequence_activated", undefined, [var_0], undefined);
}

_id_974F(var_0) {
  _id_0705::_id_9723("ufo_destroyed", undefined, [var_0], undefined);
}

_id_9747(var_0, var_1, var_2, var_3) {
  _id_0705::_id_9723("xp_earned", var_0, [var_1, var_2._id_399D, var_3], [var_2._id_399D, var_1]);
}

_id_972D(var_0, var_1) {
  foreach(var_5, var_3 in var_1._id_761D) {
    if(var_5 == "none" || var_5 == "" || var_3 == 0 || !scripts\engine\utility::array_contains(level._id_965B, var_5)) {
      continue;
    }
    setclientmatchdata("player", var_0, "headShots", scripts\cp\utility::_id_6902(var_5), var_3);
    var_4 = var_1 getplayerdata("cp", "headShots", scripts\cp\utility::_id_6902(var_5));
    var_1 setplayerdata("cp", "headShots", scripts\cp\utility::_id_6902(var_5), var_4 + var_3);
  }

  setclientmatchdata("player", var_0, "total_headshots", var_1._id_F365);
}

_id_9725(var_0, var_1) {
  if(!isDefined(var_1._id_57E3)) {
    return;
  }
  var_2 = var_1 getplayerdata("cp", "explosive_kills");
  var_1 setplayerdata("cp", "explosive_kills", var_2 + var_1._id_57E3);
}

_id_9751(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  foreach(var_8, var_6 in var_1._id_121F) {
    if(var_8 == "none" || var_8 == "" || var_6 == 0 || !scripts\engine\utility::array_contains(level._id_965B, var_8)) {
      continue;
    }
    setclientmatchdata("player", var_0, "killsPerWeapon", scripts\cp\utility::_id_6902(var_8), var_6);
    var_7 = var_1 getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::_id_6902(var_8));
    var_1 setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::_id_6902(var_8), var_7 + var_6);

    if(var_1._id_121F[var_8] > 0 && var_2 == 0) {
      var_3 = var_1._id_121F[var_8];
      var_2 = 1;
      var_4 = scripts\cp\utility::_id_6902(var_8);
    }

    if(var_1._id_121F[var_8] > var_3) {
      var_3 = var_1._id_121F[var_8];
      var_4 = scripts\cp\utility::_id_6902(var_8);
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
      var_10 = var_1 getplayerdata("cp", "killsPerWeapon", var_4);

      if(!isDefined(var_1._id_121F[var_4])) {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_10);
      } else {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_10);
      }

      var_1 setplayerdata("cp", "DeadliestWeaponName", var_4);
    }
  } else {
    var_11 = var_1 getplayerdata("cp", "killsPerWeapon", var_9);

    if(!isDefined(var_1._id_121F[var_9])) {
      var_1 setplayerdata("cp", "DeadliestWeaponKills", var_9, var_11);
    } else {
      var_1 setplayerdata("cp", "DeadliestWeaponKills", var_9, var_1._id_121F[var_9] + var_11);
    }

    var_1 setplayerdata("cp", "DeadliestWeaponName", var_9);
  }
}

_id_1106C() {
  var_0 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_6, var_2 in level.players) {
    _id_9751(var_6, var_2);
    _id_972D(var_6, var_2);
    _id_9725(var_6, var_2);

    foreach(var_4 in var_0) {
      if(isDefined(var_2._id_F4BF[var_4])) {
        var_2._id_F36B = var_2._id_F36B + var_2._id_F4BF[var_4];
      }
    }
  }
}

_id_9742(var_0, var_1) {}

_id_9743(var_0, var_1, var_2) {
  _id_0705::_id_9723("shots_on_target", var_0, [var_1._id_399D, var_2], [var_1._id_399D, var_2]);
}

_id_974C(var_0, var_1) {
  if(!isDefined(var_1.pers["timesPerWave"]._id_F279)) {
    var_1.pers["timesPerWave"]._id_F279 = [];
  }

  if(!isDefined(var_1.pers["timesPerWave"]._id_F279[level._id_10CA0])) {
    var_1.pers["timesPerWave"]._id_F279[level._id_10CA0] = [];
  }

  if(!isDefined(var_1.pers["timesPerWave"]._id_F279[level._id_10CA0][var_0])) {
    var_1.pers["timesPerWave"]._id_F279[level._id_10CA0][var_0] = 0;
  }

  var_1.pers["timesPerWave"]._id_F279[level._id_10CA0][var_0]++;
}

_id_972E(var_0) {
  _id_0705::_id_9723("hidden_song_one_discovered", undefined, [var_0], undefined);
}

_id_972F(var_0) {
  _id_0705::_id_9723("hidden_song_two_discovered", undefined, [var_0], undefined);
}

_id_971C(var_0) {
  _id_0705::_id_9723("crafted_wor_facemelter", undefined, [var_0], undefined);
}

_id_971D(var_0) {
  _id_0705::_id_9723("crafted_wor_headcutter", undefined, [var_0], undefined);
}

_id_971B(var_0) {
  _id_0705::_id_9723("crafted_wor_dischord", undefined, [var_0], undefined);
}

_id_971E(var_0) {
  _id_0705::_id_9723("crafted_wor_shredder", undefined, [var_0], undefined);
}

_id_9740(var_0) {
  _id_0705::_id_9723("pink_ark_obtained", undefined, [var_0], undefined);
}