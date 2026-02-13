/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\telemetry_cp.gsc
*************************************************/

init() {
  _id_06E2::_id_1029("callback_match_start", ::_id_AA57);
  _id_06E2::_id_1029("callback_match_end", ::_id_AA56);
  _id_06E2::_id_1029("callback_player_match_start", ::on_player_match_start);
  _id_06E2::_id_1029("callback_player_match_end", ::on_player_match_end);
}

_id_AA57(var_0) {
  if(!isDefined(level.utc_start_time_s)) {
    level.utc_start_time_s = 0;
  }

  level.utc_start_time_s = _func_00D7();
  _func_03BF("dlog_event_cp_server_match_start", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", level.utc_start_time_s, "player_count", level.players.size]);
}

_id_AA56(var_0) {
  var_1 = var_0._id_0372;
  var_2 = 0;

  if(isDefined(level.utc_start_time_s)) {
    var_2 = level.utc_start_time_s;
  }

  if(var_1 != "") {
    if(scripts\cp\utility::_id_871A()) {
      var_1 = "KIA";
    }

    _func_03BF("dlog_event_cp_server_match_end", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", _func_00D7(), "result", var_1, "utc_start_time_s", var_2, "player_count", level.players.size]);
  } else
    _func_03BF("dlog_event_cp_server_match_end", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", _func_00D7(), "result", var_0._id_0372, "utc_start_time_s", var_2, "player_count", level.players.size]);
}

on_player_match_start(var_0) {
  var_1 = var_0.player;

  if(!isDefined(var_1.pers["telemetry"]) || !isDefined(var_1.pers["telemetry"]._id_3B81)) {
    if(!isDefined(var_1.pers["telemetry"])) {
      var_1.pers["telemetry"] = spawnStruct();
    }

    if(isDefined(game["telemetry"]) && isDefined(game["telemetry"].total_player_connections)) {
      var_1.pers["telemetry"].connect_index = game["telemetry"].total_player_connections;
      game["telemetry"].total_player_connections++;
    } else
      return;
  }

  var_1.pers["telemetry"].utc_connect_time_s = _func_00D7();
  var_1.pers["telemetry"]._id_3B81 = 1;

  if(var_1 scripts\cp\utility::rankingenabled()) {
    var_2 = var_1 getplayerdata("cp", "progression", "playerLevel", "xp");
    var_3 = var_1 getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
    var_4 = var_1 getplayerdata("cp", "progression", "playerLevel", "prestige");
  } else {
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
  }

  var_1.pers["utc_connect_time_s"] = _func_00D7();
  var_5 = var_1.pers["telemetry"].connect_index;
  var_1 _meth_870F("dlog_event_cp_player_match_start", ["utc_connect_time_s", var_1.pers["utc_connect_time_s"], "team", var_1.sessionteam, "join_type", var_1 _meth_813E(), "skill", var_1 _meth_811E(), "start_xp", var_2, "start_time_played_total", var_3, "start_prestige", var_4, "connect_index", var_5, "player_count", level.players.size, "party_id", var_1 _meth_8743()]);
  var_1.pers["telemetry"].first_weapon_in_round_base_name = undefined;
  var_1.pers["telemetry"].first_weapon_in_round_start_time = undefined;
  var_1.pers["telemetry"].first_weapon_in_round_end_time = undefined;
  scripts\cp\cp_playerstats::incrementcombatstat(var_1, "totalGamesPlayed", 1);
}

on_player_match_end(var_0) {
  var_1 = var_0.player;
  var_2 = "";

  if(isDefined(var_0.disconnectreason) && _func_0121(var_0.disconnectreason)) {
    var_2 = var_0.disconnectreason;
  }

  if(level.teambased) {
    var_3 = int(var_1 _id_0756::_id_6DD7(var_1.team));
  } else {
    var_3 = 0;
  }

  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = var_1 scripts\cp\utility::onlinestatsenabled();

  if(var_1 scripts\cp\utility::onlinestatsenabled() && !scripts\cp\utility::_id_86C9()) {
    if(isDefined(var_1.pers["summary"]["xp"])) {
      var_4 = var_1.pers["summary"]["xp"];
    }

    if(isDefined(var_1.pers["summary"]["score"])) {
      var_5 = var_1.pers["summary"]["score"];
    }

    if(isDefined(var_1.pers["summary"]["challenge"])) {
      var_6 = var_1.pers["summary"]["challenge"];
    }

    if(isDefined(var_1.pers["summary"]["match"])) {
      var_7 = var_1.pers["summary"]["match"];
    }

    if(isDefined(var_1.pers["summary"]["medal"])) {
      var_8 = var_1.pers["summary"]["medal"];
    }

    if(isDefined(var_1.pers["summary"]["bonusXP"])) {
      var_9 = var_1.pers["summary"]["bonusXP"];
    }

    if(isDefined(var_1.pers["summary"]["misc"])) {
      var_10 = var_1.pers["summary"]["misc"];
    }
  }

  var_12 = var_1 getplayerdata("cp", "progression", "playerLevel", "xp");
  var_1 _id_074E::_id_D359(var_4 + var_12);
  var_13 = var_1 _id_0756::getrankxp();
  var_14 = var_1 _id_0756::getrankforxp(var_13);

  if(var_1 scripts\cp\utility::rankingenabled() && var_1 _meth_85AD()) {
    var_15 = var_1 getplayerdata("cp", "progression", "playerLevel", "xp");
    var_16 = var_1 getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
    var_17 = var_1 getplayerdata("common", "mpProgression", "playerLevel", "prestige");
  } else {
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
  }

  var_18 = 0.0;
  var_19 = 0.0;

  if(isDefined(var_1._id_D02F)) {
    if(isDefined(var_1._id_D02F["movementUpdateCount"])) {
      if(var_1._id_D02F["movementUpdateCount"] >= 30) {
        var_19 = var_1._id_D02F["movingTotal"] / (var_1._id_D02F["movementUpdateCount"] / 5) * 100;
        var_18 = var_1._id_D02F["distanceTotal"] / var_1._id_D02F["movementUpdateCount"];
      }
    }
  }

  var_20 = 0;

  if(isDefined(var_1.pers["utc_connect_time_s"])) {
    var_20 = var_1.pers["utc_connect_time_s"];
  }

  if(isDefined(var_1.pers["essence"])) {
    var_21 = var_1.pers["essence"];
  } else {
    var_21 = 0;
  }

  if(isDefined(var_1._id_A38A)) {
    var_22 = var_1._id_A38A;
  } else {
    var_22 = 0;
  }

  var_23 = var_2;

  if(level.matchmakingmatch) {
    var_24 = "public";
  } else if(level.onlinegame) {
    var_24 = "private";
  } else {
    var_24 = "solo";
  }

  var_25 = _id_660E();
  var_26 = var_1.pers["telemetry"].connect_index;
  var_27 = var_1 _meth_8588();
  var_28 = _func_00D7() - var_20;
  var_1 _meth_870F("dlog_event_cp_player_match_end", ["utc_connect_time_s", var_20, "utc_disconnect_time_s", _func_00D7(), "player_xp_modifier", int(var_1 _id_0756::_id_6CE0()), "team_xp_modifier", var_3, "weapon_xp_modifier", int(var_1 _id_0776::_id_6E86()), "total_xp", var_4, "score_xp", var_5, "challenge_xp", var_6, "match_xp", var_7, "medal_xp", var_8, "bonus_xp", var_9, "misc_xp", var_10, "rank", var_14, "end_xp", var_15, "end_time_played_total", var_16, "end_prestige", var_17, "disconnect_reason", var_2, "average_speed_during_match", var_18, "percent_time_moving", var_19, "result", var_2, "connected_time_s", var_28, "essence", var_21, "salvage", var_22, "means_of_end", var_23, "match_type", var_24, "objective_type_on_death", var_25, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round(), "connect_index", var_26, "clan_id", var_27, "party_id", var_1 _meth_8743()]);
  scripts\cp\cp_playerstats::updateonlyifhighercombatstat(var_1, "highestRoundReached", get_current_round());
  scripts\cp\cp_playerstats::incrementcombatstat(var_1, "totalTimeSpent", var_28);
}

get_player_index_cp(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in level.players) {
    if(var_0 == var_3) {
      var_1 = var_4;
    }
  }

  return var_1;
}

get_current_cp_map() {
  return level.script;
}

get_current_round() {
  return scripts\cp\utility::_id_6871();
}

_id_660E() {
  var_0 = "hub";

  if(isDefined(level._id_0F24)) {
    var_0 = level._id_0F24;
  } else if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51)) {
    var_1 = level._id_3BE9._id_0F51;
    var_2 = var_1._id_0481;

    if(isDefined(var_2)) {
      var_0 = var_2;
    }
  } else if(isDefined(level.lastobjective))
    var_0 = level.lastobjective;

  return var_0;
}

_id_9790(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_xp_earned", ["player_xp_earned", var_1, "weapon", var_2, "weapon_xp_earned", var_3, "xp_source", var_4, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_essenceearned(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_essence_earned", ["essence_earned", var_1, "equipped_weapon", var_2, "essence_source", var_3, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_salvageearned(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(isDefined(var_2) && (var_2 == "normal" || var_2 == "special")) {
    var_2 = var_2 + "_zombie";
  }

  var_0 _meth_870F("dlog_event_cp_player_salvage_earned", ["salvage_earned", var_1, "source", var_2, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_scoreevent(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_score_event", ["score_event", var_1, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_medal(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_medal_name", ["medal_name", var_1, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_weaponinfo() {
  var_0 = 0;

  foreach(var_6, var_2 in level.players) {
    var_3 = level.players[var_6];
    var_4 = var_3.pers["telemetry"].first_weapon_in_round_end_time - var_3.pers["telemetry"].first_weapon_in_round_start_time;
    var_5 = var_3.pers["telemetry"].first_weapon_in_round_base_name;
    var_3 _meth_870F("dlog_event_cp_player_weapon_info", ["duration_equipped", var_4, "equipped_weapon_at_round_start", var_5, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
  }
}

logevent_aikillinfo(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_4 = getweaponbasename(var_1);
  var_5 = var_2.numhits;
  var_6 = var_2._id_1210;
  var_7 = var_3;
  var_0 _meth_870F("dlog_event_cp_player_ai_kill_info_event", ["weapon_used", var_4, "hits_to_kill", var_5, "ai_type", var_6, "kill_type", var_7, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "round", get_current_round(), "player_count", level.players.size]);
}

logevent_objectivefinished(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_8, var_5 in level.players) {
    var_6 = level.players[var_8];

    if(var_0) {
      var_7 = "completed";
    } else {
      var_7 = "failed";
    }

    var_6 _meth_870F("dlog_event_cp_player_objective_finished_event", ["failed_completed", var_7, "location", var_1, "duration", var_2, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "round", get_current_round(), "player_count", level.players.size]);
  }
}

logevent_playerdown(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(isDefined(var_2) && isDefined(var_2.origin), distance2d(var_0.origin, var_2.origin), 0);
  var_4 = "Zombie Melee";

  if(isPlayer(var_2) || !isDefined(var_2._id_1210)) {
    var_4 = "Player-thrown Equipment";
  } else {
    var_5 = var_1 == "MOD_BULLET" || var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_PISTOL_BULLET";
    var_6 = var_1 == "MOD_MELEE" || var_1 == "MOD_MELEE_WEAPON_BUTT" || var_1 == "MOD_IMPACT";
    var_7 = var_1 == "MOD_EXPLOSIVE" || var_1 == "MOD_GRENADE" || var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_PROJECTILE" || var_1 == "MOD_PROJECTILE_SPLASH";

    if(isDefined(var_2._id_1210)) {
      switch (var_2._id_1210) {
        case "actor_enemy_zombie_juggernaut_cp":
          if(var_5) {
            var_4 = "Juggernaut Gun";
          }

          break;
        case "actor_enemy_zombie_screamer_cp":
          if(var_1 == "MOD_EXPLOSION") {
            var_4 = "Screamer Explosion";
          }

          break;
        default:
          if(var_7) {
            var_4 = "Zombie Gut Throw";
          }

          break;
      }
    }
  }

  var_0 _meth_870F("dlog_event_cp_player_downed_event", ["source_of_death", var_4, "range_from_enemy", var_3, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "round", get_current_round(), "player_count", level.players.size]);
}

logevent_perkpurchase(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_perk_purchase_event", ["first_perk_purchase", var_1, "tier_purchased", var_2, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "round", get_current_round(), "player_count", level.players.size]);
}

logevent_covenantpurchase(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_covenant_purchase_event", ["covenant_purchased", var_1, "rarity_purchased", var_2, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "round", get_current_round(), "player_count", level.players.size]);
}

logevent_serverroundend() {
  var_0 = 0;

  if(isDefined(level.last_objective_start)) {
    var_0 = level.last_objective_start;
  }

  _func_03BF("dlog_event_cp_server_round_end", ["round_start_time_ms", var_0 * 1000, "round_end_time_ms", _func_00D7() * 1000, "round_number", get_current_round()]);
}

logevent_playerroundend(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_1 = 0;

  if(isDefined(level.last_objective_start)) {
    var_1 = level.last_objective_start;
  }

  if(!isDefined(var_0.pers["telemetry"])) {
    var_0.pers["telemetry"] = spawnStruct();
  }

  if(!isDefined(var_0.pers["telemetry"].last_round_data)) {
    var_0.pers["telemetry"].last_round_data = spawnStruct();
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0._id_0157), var_0._id_0157, 0);
  var_3 = var_0 getplayerdata("cp", "alienSession", "currency");
  var_4 = var_0 getplayerdata("cp", "alienSession", "kills");
  var_5 = scripts\engine\utility::ter_op(isDefined(var_0.pers["xpEarnedThisMatch"]), var_0.pers["xpEarnedThisMatch"], 0);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_0.pers["telemetry"].last_round_data._id_038F), var_0.pers["telemetry"].last_round_data._id_038F, 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_0.pers["telemetry"].last_round_data._id_0267), var_0.pers["telemetry"].last_round_data._id_0267, 0);
  var_8 = scripts\engine\utility::ter_op(isDefined(var_0.pers["telemetry"].last_round_data._id_10FD5), var_0.pers["telemetry"].last_round_data._id_10FD5, 0);
  var_9 = max(var_3 - var_6, 0);
  var_10 = max(var_4 - var_7, 0);
  var_11 = max(var_5 - var_8, 0);
  var_12 = var_0 getcurrentprimaryweapon();
  var_13 = scripts\cp\utility::_id_459B(getweaponattachments(var_12), []);
  [var_15, var_16] = _id_0774::strip_pap_attachments(var_13, []);
  var_17 = "";

  foreach(var_19 in var_15) {
    var_17 = var_17 + (var_19 + "+");
  }

  var_21 = _id_0774::_id_684B(var_12);
  var_22 = _func_0375();
  var_23 = "";
  var_24 = 0;

  foreach(var_26 in var_0.weaponlist) {
    if(var_26 != var_12 && !var_26._id_0245) {
      var_22 = var_26;
      var_13 = scripts\cp\utility::_id_459B(getweaponattachments(var_22), []);
      [var_28, var_16] = _id_0774::strip_pap_attachments(var_13, []);

      foreach(var_19 in var_28) {
        var_23 = var_23 + (var_19 + "+");
      }

      var_24 = _id_0774::_id_684B(var_22);
      break;
    }
  }

  var_0 _meth_870F("dlog_event_cp_player_round_end", ["round_start_time_ms", var_1, "round_end_time_ms", _func_00D7(), "round_number", get_current_round(), "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "deaths", var_2, "score", var_3, "kills", var_4, "round_score", var_9, "round_kills", var_10, "xp_round_gained_total", var_11, "weapon_primary", getweaponbasename(var_12), "weapon_primary_attachments", var_17, "weapon_primary_pack_level", var_21, "weapon_secondary", getweaponbasename(var_22), "weapon_secondary_attachments", var_23, "weapon_secondary_pack_level", var_24]);
  var_0.pers["telemetry"].last_round_data._id_038F = var_3;
  var_0.pers["telemetry"].last_round_data._id_0267 = var_4;
  var_0.pers["telemetry"].last_round_data._id_10FD5 = var_5;
}

logevent_serveraispawned() {
  var_0 = 0;

  if(isDefined(level.spawnedaibase)) {
    var_0 = level.spawnedaibase;
  }

  var_1 = 0;

  if(isDefined(level.spawnedaijuggernaut)) {
    var_1 = level.spawnedaijuggernaut;
  }

  var_2 = 0;

  if(isDefined(level.spawnedaiscreamer)) {
    var_2 = level.spawnedaiscreamer;
  }

  var_3 = 0;

  if(isDefined(level.spawnedaitrickster)) {
    var_3 = level.spawnedaitrickster;
  }

  _func_03BF("dlog_event_cp_server_ai_spawned_event", ["base", var_0, "juggernaut", var_1, "screamer", var_2, "trickster", var_3, "levelname", get_current_cp_map(), "active_objective", _id_660E()]);
}

logevent_loadout_info(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_1 = var_0.pers["telemetry"].loadoutselectedweapon;
  var_2 = var_0.pers["telemetry"].loadoutselectedattachments;
  var_3 = var_0.pers["telemetry"].loadoutselectedfieldupgrade;
  var_0 _meth_870F("dlog_event_cp_player_loadout_info", ["weapon", var_1, "attachments", var_2, "field_upgrade", var_3, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_weaponacquired(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_weapon_acquired", ["weapon", var_1, "pap_level", var_2, "source", var_3, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_equipmentacquired(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_equipment_acquired", ["equipment", var_1, "source", var_2, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_armoracquired(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_armor_acquired", ["armor", var_1, "tier", var_2, "source", var_3, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}

logevent_supportacquired(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 _meth_870F("dlog_event_cp_player_support_acquired", ["support", var_1, "source", var_2, "levelname", get_current_cp_map(), "active_objective", _id_660E(), "player_count", level.players.size, "round", get_current_round()]);
}