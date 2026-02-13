/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2082.gsc
*************************************************/

init() {
  _id_06E2::_id_1029("callback_match_start", ::_id_AA57);
  _id_06E2::_id_1029("callback_match_end", ::_id_AA56);
  _id_06E2::_id_1029("callback_round_start", ::_id_AA61);
  _id_06E2::_id_1029("callback_round_end", ::_id_AA60);
  _id_06E2::_id_1029("callback_on_player_first_connect", ::_id_AA5D);
  _id_06E2::_id_1029("callback_on_player_spawned", ::on_player_spawned);
  _id_06E2::_id_1029("callback_player_server_end", ::on_player_match_end);
  _id_06E2::_id_1029("callback_player_death", ::on_player_death);
  _id_06E2::_id_1029("callback_on_player_disconnect", ::_id_AA5E);
  _id_06E2::_id_1029("callback_player_new_loadout_used", ::on_player_new_loadout_used);
  _id_06E2::_id_1029("callback_update_weapon_stats", ::update_weapon_stats);
  _id_06E2::_id_1029("callback_player_score_event", ::on_player_score_event);
  _id_06E2::_id_1029("callback_on_game_event", ::on_game_event);
}

_id_AA57() {
  var_0 = _func_00D7();
  setmatchdata("commonMatchData", "utc_start_time_s", var_0);
  setmatchdata("commonMatchData", "player_count_start", level.players.size);

  if(isDefined(game["telemetry"])) {
    game["telemetry"].utc_start_time_s = var_0;
  }

  var_1 = scripts\mp\utility\game::getgametype();
  var_2 = "";

  if(var_1 == "br") {
    var_2 = level._id_2BB5.name;
  }

  if(level._id_74C4) {
    var_1 = var_1 + " hc";
  }

  var_3 = 0;
  var_4 = "";

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_3 = _func_00C5();
    var_4 = _func_0433();
  }

  _func_03BF("dlog_event_mp_server_match_start", ["utc_start_time_s", var_0, "map", level.script, "game_type", var_1, "is_playtest", getdvarint("#x394d2cc8d0d3f736e"), "experiment_name", getDvar("#x34348a48effaf53db"), "dedi_server_guid", _func_0414(), "sub_game_type", var_2, "playlist_id", var_3, "playlist_name", var_4, "is_offline", !level.onlinegame, "league_play", level.leagueplaymatch, "league_season", _func_048A()]);

  if(var_1 == "br") {
    scripts\common\utility::_id_F73A(level._id_9BAC);
  }

  _func_03D7();
}

_id_AA56(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = scripts\mp\utility\game::getgametype();

  if(isDefined(game["telemetry"].utc_start_time_s)) {
    var_1 = game["telemetry"].utc_start_time_s;
  }

  if(isDefined(game["telemetry"].total_player_connections)) {
    var_2 = game["telemetry"].total_player_connections;
  }

  if(isDefined(game["telemetry"].life_count)) {
    var_3 = game["telemetry"].life_count;
  }

  if(level._id_74C4) {
    var_4 = var_4 + " hc";
  }

  var_5 = 0;
  var_6 = "";

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_5 = _func_00C5();
    var_6 = _func_0433();
  }

  var_7 = 0;
  var_8 = 0;

  if(level.teambased) {
    var_7 = _func_00DB("allies");
    var_8 = _func_00DB("axis");
  }

  _func_03BF("dlog_event_mp_server_match_end", ["utc_start_time_s", var_1, "utc_end_time_s", _func_00D7(), "total_player_connections", var_2, "life_count", var_3, "playlist_id", var_5, "playlist_name", var_6, "game_type", var_4, "map", level.script, "is_offline", !level.onlinegame, "allies_score", var_7, "axis_score", var_8, "league_play", level.leagueplaymatch, "league_season", _func_048A()]);
}

_id_AA61(var_0) {
  if(isDefined(game["telemetry"])) {
    game["telemetry"].round_start_time_ms = _id_07EE::_id_6DE4(gettime());
  }
}

_id_AA60(var_0) {
  var_1 = 0;

  if(isDefined(game["telemetry"].round_start_time_ms)) {
    var_1 = game["telemetry"].round_start_time_ms;
  }

  var_2 = 0;
  var_3 = 0;

  if(level.teambased) {
    var_2 = _func_00DB("allies");
    var_3 = _func_00DB("axis");
  }

  _func_03BF("dlog_event_mp_server_round_end", ["round_start_time_ms", var_1, "round_end_time_ms", _id_07EE::_id_6DE4(gettime()), "allies_score", var_2, "axis_score", var_3]);
}

_id_AA5D(var_0) {
  if(!_id_06E2::is_valid_client(var_0)) {
    return;
  }
  if(!isDefined(var_0.pers["telemetry"]) || !isDefined(var_0.pers["telemetry"]._id_3B81)) {
    if(!isDefined(var_0.pers["telemetry"])) {
      var_0.pers["telemetry"] = spawnStruct();
    }

    if(isDefined(game["telemetry"]) && isDefined(game["telemetry"].total_player_connections)) {
      var_0.pers["telemetry"].connect_index = game["telemetry"].total_player_connections;
      game["telemetry"].total_player_connections++;
    } else
      return;

    var_0.pers["telemetry"].utc_connect_time_s = _func_00D7();
    var_0.pers["telemetry"]._id_3B81 = 1;
    var_0.pers["telemetry"].shots = 0;
    var_0.pers["telemetry"]._id_79B5 = 0;
    var_0.pers["telemetry"].num_short_lives = 0;
    var_0.pers["telemetry"].num_short_engagement_lives = 0;
    var_0.pers["telemetry"].num_good_bucket_spawns = 0;
    var_0.pers["telemetry"].num_ok_bucket_spawns = 0;
    var_0.pers["telemetry"].num_bad_bucket_spawns = 0;
    var_0.pers["telemetry"].num_buddy_bucket_spawns = 0;
    var_0.pers["telemetry"].num_killstreaks_earned = 0;
    var_0.pers["telemetry"].num_killstreaks_used = 0;

    if(var_0 scripts\mp\utility\game::rankingenabled() && var_0 _meth_85AD()) {
      var_1 = var_0 getplayerdata("common", "mpProgression", "playerLevel", "xp");
      var_0.pers["telemetry"].xp_at_start = var_1;
      var_0.pers["telemetry"].rank_at_start = var_0 scripts\mp\rank::getrankforxp(var_1);
      var_0.pers["telemetry"].score_at_start = var_0 getplayerdata(level.progressiongroup, "playerStats", "matchStats", "score");
      var_0.pers["telemetry"].prestige_at_start = var_0 getplayerdata("rankedloadouts", "squadMembers", "season_rank");
    } else {
      var_0.pers["telemetry"].xp_at_start = 0;
      var_0.pers["telemetry"].rank_at_start = 0;
      var_0.pers["telemetry"].score_at_start = 0;
      var_0.pers["telemetry"].prestige_at_start = 0;
    }

    var_2 = 0;

    if(level.onlinegame) {
      var_2 = var_0 _meth_81BF();
    }

    var_3 = "";
    var_4 = "";
    var_5 = -1;
    var_6 = -1;
    var_7 = "none";
    var_8 = "none";

    if(!istrue(game["isLaunchChunk"]) && !isbot(var_0)) {
      if(level.teambased) {
        var_3 = var_0 scripts\mp\teams::_id_9817("allies");
        var_4 = var_0 scripts\mp\teams::_id_9817("axis");
        var_5 = var_0 scripts\mp\teams::_id_9818("allies");
        var_6 = var_0 scripts\mp\teams::_id_9818("axis");
        var_9 = var_0 scripts\mp\teams::_id_6BD2(var_3);

        if(isDefined(var_9)) {
          var_7 = var_9;
        }

        var_9 = var_0 scripts\mp\teams::_id_6BD2(var_4);

        if(isDefined(var_9)) {
          var_8 = var_9;
        }
      } else {
        var_3 = var_0 scripts\mp\teams::_id_9817("allies");
        var_5 = var_0 scripts\mp\teams::_id_9818("allies");
        var_9 = var_0 scripts\mp\teams::_id_6BD2(var_3);

        if(isDefined(var_9)) {
          var_7 = var_9;
        }
      }
    }

    var_10 = scripts\mp\utility\game::getgametype();

    if(level._id_74C4) {
      var_10 = var_10 + " hc";
    }

    var_11 = 0;
    var_12 = "";

    if(scripts\mp\utility\game::matchmakinggame()) {
      var_11 = _func_00C5();
      var_12 = _func_0433();
    }

    var_13 = 0;

    if(isDefined(var_0.pers["telemetry"].connect_index)) {
      var_13 = var_0.pers["telemetry"].connect_index;
    }

    var_14 = _func_0477();

    if(!isDefined(var_14)) {
      var_14 = "";
    }

    var_0 _meth_870F("dlog_event_mp_player_match_start", ["utc_connect_time_s", var_0.pers["telemetry"].utc_connect_time_s, "team", var_0.sessionteam, "join_type", var_0 _meth_813E(), "skill", var_0 _meth_811E(), "party_id", var_0 _meth_8743(), "is_party_host", var_2, "is_guest", var_0 _meth_8744(), "was_keyboardmouse", var_0 _meth_8877() != 1, "operator_allies", var_3, "operator_axis", var_4, "operator_allies_skin", var_5, "operator_axis_skin", var_6, "operator_allies_execution_ref", var_7, "operator_axis_execution_ref", var_8, "map", level.script, "playlist_id", var_11, "playlist_name", var_12, "game_type", var_10, "connect_index", var_13, "lobby_id", var_14, "league_play", level.leagueplaymatch, "league_season", _func_048A()]);
  }
}

on_player_spawned(var_0) {
  if(!_id_06E2::is_valid_client(var_0)) {
    return;
  }
  if(!isDefined(var_0.pers["telemetry"])) {
    var_0.pers["telemetry"] = spawnStruct();
  }

  if(!isDefined(var_0.pers["telemetry"]._id_9365)) {
    var_0.pers["telemetry"]._id_9365 = spawnStruct();
  }

  if(isDefined(game["telemetry"]) && isDefined(game["telemetry"].life_count)) {
    var_0.pers["telemetry"]._id_9365.life_index = game["telemetry"].life_count;
    game["telemetry"].life_count++;
  }

  if(isDefined(var_0.pers["summary"]["xp"])) {
    var_0.pers["telemetry"]._id_9365.xp_at_spawn = var_0.pers["summary"]["xp"];
  } else {
    var_0.pers["telemetry"]._id_9365.xp_at_spawn = 0;
  }

  if(isDefined(var_0._id_038F)) {
    var_0.pers["telemetry"]._id_9365.score_at_spawn = var_0._id_038F;
  } else {
    var_0.pers["telemetry"]._id_9365.score_at_spawn = 0;
  }

  if(isDefined(var_0.spawncriticalfactorbucket)) {
    switch (var_0.spawncriticalfactorbucket) {
      case 0:
        if(isDefined(var_0.pers["telemetry"].num_good_bucket_spawns)) {
          var_0.pers["telemetry"].num_good_bucket_spawns++;
        }

        break;
      case 1:
        if(isDefined(var_0.pers["telemetry"].num_ok_bucket_spawns)) {
          var_0.pers["telemetry"].num_ok_bucket_spawns++;
        }

        break;
      case 2:
        if(isDefined(var_0.pers["telemetry"].num_bad_bucket_spawns)) {
          var_0.pers["telemetry"].num_bad_bucket_spawns++;
        }

        break;
      case 3:
        if(isDefined(var_0.pers["telemetry"].num_buddy_bucket_spawns)) {
          var_0.pers["telemetry"].num_buddy_bucket_spawns++;
        }

        break;
      default:
        break;
    }
  }
}

on_player_match_end(var_0) {
  var_1 = var_0.player;

  if(!isDefined(var_1.pers["telemetry"].player_match_end_event_sent)) {
    if(!_id_06E2::is_valid_client(var_1)) {
      return;
    }
    var_2 = 0;

    if(isDefined(var_1.pers["telemetry"].utc_connect_time_s)) {
      var_2 = var_1.pers["telemetry"].utc_connect_time_s;
    }

    var_3 = "";

    if(isDefined(var_0.disconnectreason)) {
      var_3 = var_0.disconnectreason;
    }

    var_4 = 0;

    if(level.teambased) {
      var_4 = int(var_1 scripts\mp\rank::_id_6DD7(var_1.team));
    }

    var_5 = 0;

    if(isDefined(var_1.pers["telemetry"].connect_index)) {
      var_5 = var_1.pers["telemetry"].connect_index;
    }

    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;

    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      if(isDefined(var_1.pers["summary"]["xp"])) {
        var_6 = var_1.pers["summary"]["xp"];
      }

      if(isDefined(var_1.pers["summary"]["score"])) {
        var_7 = var_1.pers["summary"]["score"];
      }

      if(isDefined(var_1.pers["summary"]["challenge"])) {
        var_8 = var_1.pers["summary"]["challenge"];
      }

      if(isDefined(var_1.pers["summary"]["match"])) {
        var_9 = var_1.pers["summary"]["match"];
      }

      if(isDefined(var_1.pers["summary"]["medal"])) {
        var_10 = var_1.pers["summary"]["medal"];
      }

      if(isDefined(var_1.pers["summary"]["bonusXP"])) {
        var_11 = var_1.pers["summary"]["bonusXP"];
      }

      if(isDefined(var_1.pers["summary"]["misc"])) {
        var_12 = var_1.pers["summary"]["misc"];
      }

      if(isDefined(var_1.pers["summary"]["accolade"])) {
        var_13 = var_1.pers["summary"]["accolade"];
      }

      if(isDefined(var_1.pers["summary"]["weaponXP"])) {
        var_14 = var_1.pers["summary"]["weaponXP"];
      }

      if(isDefined(var_1.pers["summary"]["operatorXP"])) {
        var_15 = var_1.pers["summary"]["operatorXP"];
      }

      if(isDefined(var_1.pers["summary"]["clanXP"])) {
        var_16 = var_1.pers["summary"]["clanXP"];
      }

      if(isDefined(var_1.pers["summary"]["battlepassXP"])) {
        var_17 = var_1.pers["summary"]["battlepassXP"];
      }
    }

    if(var_1.pers["telemetry"].rank_at_start) {
      var_18 = var_1.pers["telemetry"].rank_at_start;
    } else {
      var_18 = 0;
    }

    if(var_1.pers["telemetry"].xp_at_start) {
      var_19 = var_1.pers["telemetry"].xp_at_start;
    } else {
      var_19 = 0;
    }

    if(var_1.pers["telemetry"].score_at_start) {
      var_20 = var_1.pers["telemetry"].score_at_start;
    } else {
      var_20 = 0;
    }

    if(var_1.pers["telemetry"].prestige_at_start) {
      var_21 = var_1.pers["telemetry"].prestige_at_start;
    } else {
      var_21 = 0;
    }

    if(var_1 scripts\mp\utility\game::rankingenabled() && var_1 _meth_85AD()) {
      var_22 = var_1 getplayerdata("common", "mpProgression", "playerLevel", "xp");
      var_23 = var_1 scripts\mp\rank::getrankforxp(var_22);
      var_24 = var_1 getplayerdata(level.progressiongroup, "playerStats", "matchStats", "score");
      var_25 = var_1 getplayerdata("rankedloadouts", "squadMembers", "season_rank");
      var_26 = var_1 getplayerdata(level.progressiongroup, "playerStats", "combatStats", "kills");
      var_27 = var_1 getplayerdata(level.progressiongroup, "playerStats", "combatStats", "deaths");
      var_28 = var_1 getplayerdata(level.progressiongroup, "playerStats", "matchStats", "wins");
      var_29 = var_1 getplayerdata(level.progressiongroup, "playerStats", "matchStats", "losses");
      var_30 = var_1 getplayerdata(level.progressiongroup, "playerStats", "combatStats", "hits");
      var_31 = var_1 getplayerdata(level.progressiongroup, "playerStats", "combatStats", "misses");
      var_32 = var_1 getplayerdata(level.progressiongroup, "playerStats", "matchStats", "gamesPlayed");
      var_33 = var_1 getplayerdata(level.progressiongroup, "playerStats", "matchStats", "timePlayedTotal");
    } else {
      var_22 = 0;
      var_23 = 0;
      var_24 = 0;
      var_25 = 0;
      var_26 = 0;
      var_27 = 0;
      var_28 = 0;
      var_29 = 0;
      var_30 = 0;
      var_31 = 0;
      var_32 = 0;
      var_33 = 0;
    }

    var_34 = -1;
    var_35 = 0;
    var_36 = 0;

    if(isDefined(var_0.disconnectreason)) {
      if(scripts\mp\utility\game::isroundbased()) {
        var_34 = game["roundsPlayed"];
      }

      if(level.teambased) {
        if(isDefined(var_1.team)) {
          if(var_1.team == "allies") {
            var_35 = _func_00DB("allies");
            var_36 = _func_00DB("axis");
          } else if(var_1.team == "axis") {
            var_35 = _func_00DB("axis");
            var_36 = _func_00DB("allies");
          }
        }
      }
    }

    var_37 = 0.0;
    var_38 = 0.0;

    if(isDefined(var_1._id_D02F) && var_1._id_D02F["movementUpdateCount"] >= 30) {
      var_37 = var_1._id_D02F["movingTotal"] / (var_1._id_D02F["movementUpdateCount"] / 5) * 100;
      var_38 = var_1._id_D02F["distanceTotal"] / var_1._id_D02F["movementUpdateCount"];
    }

    var_39 = 0.0;

    if(isDefined(var_1.pers["totalDistTraveled"])) {
      var_39 = float(var_1.pers["totalDistTraveled"]);
    }

    var_40 = 0.0;
    var_41 = var_1 _id_0804::_id_6C64("combatStats", "totalShots");
    var_42 = var_1 _id_0804::_id_6C64("combatStats", "hits");

    if(isDefined(var_41) && isDefined(var_42) && var_41 > 0) {
      var_40 = float(var_42 / var_41 * 100);
    }

    var_43 = 0;

    if(isDefined(var_1.pers["suicides"])) {
      var_43 = var_1 scripts\mp\utility\stats::_id_6C29("suicides");
    }

    var_44 = 0;
    var_45 = 0;
    var_46 = 0;
    var_47 = 0;

    if(scripts\mp\utility\game::getgametype() == "arm" && isDefined(var_1._id_7347)) {
      var_44 = istrue(var_1._id_7347["rightmouseup"]);
      var_45 = istrue(var_1._id_7347["leftmouseup"]);
      var_46 = istrue(var_1._id_7347["activate"]);
      var_47 = istrue(var_1._id_7347["gostand"]);
    }

    var_48 = scripts\mp\utility\game::getgametype();

    if(level._id_74C4) {
      var_48 = var_48 + " hc";
    }

    var_49 = 0;
    var_50 = "";

    if(scripts\mp\utility\game::matchmakinggame()) {
      var_49 = _func_00C5();
      var_50 = _func_0433();
    }

    var_51 = _func_0477();

    if(!isDefined(var_51)) {
      var_51 = "";
    }

    var_52 = "";

    if(scripts\mp\utility\game::matchmakinggame()) {
      var_52 = _func_0445(var_49);
    }

    var_53 = "loss";

    if(isDefined(var_1.pers["match_outcome"])) {
      var_53 = var_1.pers["match_outcome"];
    }

    var_54 = 0;

    if(isDefined(var_1.pers["telemetry"].shots)) {
      var_54 = var_1.pers["telemetry"].shots;
    }

    var_55 = 0;

    if(isDefined(var_1.pers["telemetry"]._id_79B5)) {
      var_55 = var_1.pers["telemetry"]._id_79B5;
    }

    var_56 = var_1 _meth_8588();
    var_57 = var_1 getxuid();
    var_58 = _func_0491(var_57);
    var_1 _meth_870F("dlog_event_mp_player_match_end", ["utc_connect_time_s", var_2, "utc_disconnect_time_s", _func_00D7(), "score", var_1 scripts\mp\utility\stats::_id_6C29("score"), "assists", var_1 scripts\mp\utility\stats::_id_6C29("assists"), "longest_streak", var_1 scripts\mp\utility\stats::_id_6C29("longestStreak"), "kills", var_1 scripts\mp\utility\stats::_id_6C29("kills"), "deaths", var_1 scripts\mp\utility\stats::_id_6C29("deaths"), "headshots", var_1 scripts\mp\utility\stats::_id_6C29("headshots"), "executions", var_1 scripts\mp\utility\stats::_id_6C29("executions"), "short_lives", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_short_lives, 0), "short_engagement_lives", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_short_engagement_lives, 0), "good_bucket_spawns", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_good_bucket_spawns, 0), "ok_bucket_spawns", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_ok_bucket_spawns, 0), "bad_bucket_spawns", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_bad_bucket_spawns, 0), "buddy_bucket_spawns", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_buddy_bucket_spawns, 0), "killstreaks_earned", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_killstreaks_earned, 0), "killstreaks_activated", scripts\engine\utility::_id_FF6C(var_1.pers["telemetry"].num_killstreaks_used, 0), "player_xp_modifier", int(var_1 scripts\mp\rank::_id_6CE0()), "team_xp_modifier", var_4, "weapon_xp_modifier", int(var_1 _id_0826::_id_6E86()), "disconnect_reason", var_3, "player_quit_round_number", var_34, "player_quit_team_score", var_35, "player_quit_opposing_team_score", var_36, "average_speed_during_match", var_38, "percent_time_moving", var_37, "damage_done", var_1 scripts\mp\utility\stats::_id_6C29("damage"), "damage_taken", var_1 scripts\mp\utility\stats::_id_6C29("damageTaken"), "distance_traveled", var_39, "weapon_accuracy", var_40, "suicides", var_43, "game_type", var_48, "gw_spawn_method_press_activate", var_46, "gw_spawn_method_press_gostand", var_47, "gw_spawn_method_press_lclick", var_45, "gw_spawn_method_press_rclick", var_44, "playlist_id", var_49, "playlist_name", var_50, "map", level.script, "connect_index", var_5, "lobby_id", var_51, "intensity", var_52, "match_outcome", var_53, "rank_at_start", var_18, "rank_at_end", var_23, "xp_at_start", var_19, "xp_at_end", var_22, "score_at_start", var_20, "score_at_end", var_24, "prestige_at_start", var_21, "prestige_at_end", var_25, "lifetime_kills", var_26, "lifetime_deaths", var_27, "lifetime_wins", var_28, "lifetime_losses", var_29, "lifetime_hits", var_30, "lifetime_misses", var_31, "lifetime_games_played", var_32, "lifetime_time_played_total", var_33, "total_xp", var_6, "score_xp", var_7, "challenge_xp", var_8, "match_xp", var_9, "medal_xp", var_10, "bonus_xp", var_11, "misc_xp", var_12, "accolade_xp", var_13, "weapon_xp", var_14, "operator_xp", var_15, "clan_xp", var_16, "battlepass_xp", var_17, "shots", var_54, "hits", var_55, "clan_id", var_56, "league_play", level.leagueplaymatch, "league_season", _func_048A(), "league_play_skill_rating", var_58, "league_play_skill_division", _func_048E(var_58)]);
    var_1.pers["telemetry"].player_match_end_event_sent = 1;
    var_1 scripts\mp\weapons::updateweaponusetime();
    send_player_weapon_stats_event(var_1);
  }
}

on_player_death(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0._id_10D86;
  var_4 = var_0._id_9CD6;

  if(!_id_06E2::is_valid_client(var_2)) {
    return;
  }
  if(var_3 == "agent_mp") {
    var_5 = [];
  } else {
    var_6 = scripts\mp\utility\weapon::_id_6E69(var_3);
    var_5 = scripts\mp\utility\weapon::_id_1DB3(var_6, var_3);
  }

  var_7 = 0;

  if(isDefined(var_2._id_E393)) {
    var_7 = var_2._id_E393;
  }

  var_8 = _id_06E2::get_time_from_match_start(var_7);
  var_9 = _id_06E2::get_time_from_match_start(gettime());
  var_10 = -1;

  if(isDefined(var_2.pers["telemetry"]._id_9365.life_index)) {
    var_10 = var_2.pers["telemetry"]._id_9365.life_index;
  }

  var_11 = -1;
  var_12 = -1;
  var_13 = [];

  if(_id_06E2::is_valid_client(var_1)) {
    var_14 = getweaponbasename(var_3);
    var_15 = var_1;
    var_16 = var_1 scripts\mp\utility\weapon::_id_897E(var_3);
    var_17 = var_1 _meth_8543(var_3);
    var_18 = 0.0;

    if(scripts\mp\utility\weapon::_id_8799(var_3)) {
      var_18 = var_1 playerads();
    }

    var_19 = scripts\engine\utility::_id_10E76(var_2.origin, var_2.angles, var_1.origin, 0.4226);
    var_20 = scripts\engine\utility::_id_10E76(var_1.origin, var_1.angles, var_2.origin, 0.4226);
    var_21 = var_1 _id_06E2::mount_string_to_dlog_enum();
    var_22 = var_1.origin;
    var_23 = var_1.angles;

    if(isDefined(var_1.pers["telemetry"]._id_9365.life_index)) {
      var_11 = var_1.pers["telemetry"]._id_9365.life_index;
    }

    if(isDefined(var_1._id_9678)) {
      var_12 = var_1._id_9678;
    }

    var_13 = var_1 _id_06E2::get_death_modifiers();
  } else {
    var_15 = undefined;
    var_14 = "";
    var_16 = 0;
    var_17 = 0;
    var_18 = 0.0;
    var_19 = 0;
    var_20 = 0;
    var_21 = "MOUNT_NONE";
    var_22 = (0, 0, 0);
    var_23 = (0, 0, 0);
  }

  var_24 = var_2 _id_06E2::get_death_modifiers();
  var_25 = [];
  var_26 = "";

  if(isDefined(var_2._id_90CE)) {
    var_27 = var_2._id_90CE;
    var_28 = scripts\mp\utility\weapon::_id_6E69(var_27);
    var_25 = scripts\mp\utility\weapon::_id_1DB3(var_28, var_27);
    var_26 = getweaponbasename(var_27);
    var_29 = var_2 scripts\mp\utility\weapon::_id_897E(var_27);
    var_30 = var_2 _meth_8543(var_27, 0, 1);
    var_31 = var_2 playerads();
  } else {
    var_29 = 0;
    var_30 = 0;
    var_31 = 0.0;
  }

  var_32 = var_2 _id_06E2::mount_string_to_dlog_enum();
  var_33 = -1;

  if(isDefined(var_2._id_9678)) {
    var_33 = var_2._id_9678;
  }

  var_34 = 0;

  if(isDefined(var_2.pers["summary"]["xp"])) {
    var_35 = var_2.pers["summary"]["xp"];
    var_34 = var_35 - var_2.pers["telemetry"]._id_9365.xp_at_spawn;
  }

  var_36 = var_2._id_038F - var_2.pers["telemetry"]._id_9365.score_at_spawn;
  var_37 = -1;

  if(scripts\mp\utility\game::isroundbased()) {
    var_37 = game["roundsPlayed"];

    if(var_4 == "MOD_GAME_ENDED" || var_4 == "MOD_ROUND_ENDED") {
      var_37--;

      if(var_37 < 0) {
        var_37 = 0;
      }
    }
  }

  var_38 = 0;

  if(isDefined(var_1) && isDefined(var_1._id_9FFB)) {
    var_38 = istrue(var_1._id_9FFB["hipfire"]);
  }

  var_39 = (0, 0, 0);

  if(isDefined(var_2._id_E352)) {
    var_39 = var_2._id_E352;
  }

  var_40 = 0;

  if(isDefined(var_2._id_10A22)) {
    var_40 = var_2._id_10A22;
  }

  var_41 = 0;

  if(isDefined(var_2.spawnevaluationid)) {
    var_41 = var_2.spawnevaluationid;
  }

  var_42 = 0;

  if(isDefined(var_2.spawncriticalfactorbucket)) {
    var_42 = var_2.spawncriticalfactorbucket;
  }

  var_43 = 0;

  if(isDefined(var_2.firstdamagedeliveredtime)) {
    var_43 = _id_06E2::get_time_from_match_start(var_2.firstdamagedeliveredtime);
  }

  var_44 = "";

  if(isDefined(var_2.firstdamagedeliveredtype)) {
    var_44 = var_2.firstdamagedeliveredtype;
  }

  var_45 = "";

  if(isDefined(var_2.firstdamagedeliveredweapon)) {
    var_45 = var_2.firstdamagedeliveredweapon;
  }

  var_46 = 0;

  if(isDefined(var_2.firstdamagereceivedtime)) {
    var_46 = _id_06E2::get_time_from_match_start(var_2.firstdamagereceivedtime);
  }

  var_47 = "";

  if(isDefined(var_2.firstdamagereceivedtype)) {
    var_47 = var_2.firstdamagereceivedtype;
  }

  var_48 = "";

  if(isDefined(var_2.firstdamagereceivedweapon)) {
    var_48 = var_2.firstdamagereceivedweapon;
  }

  if(isDefined(var_2.pers["telemetry"].num_short_engagement_lives)) {
    var_49 = 0;

    if(var_43 > 0 && var_46 > 0) {
      var_49 = min(var_43, var_46);
    } else if(var_43 > 0) {
      var_49 = var_43;
    } else if(var_46 > 0) {
      var_49 = var_46;
    }

    var_50 = var_49 - var_8;

    if(var_49 > 0 && var_50 < 3000) {
      var_2.pers["telemetry"].num_short_engagement_lives++;
    }
  }

  if(var_4 != "MOD_GAME_ENDED" && var_4 != "MOD_ROUND_ENDED") {
    var_51 = var_9 - var_8;

    if(isDefined(var_2.pers["telemetry"].num_short_lives) && var_51 < 3000) {
      var_2.pers["telemetry"].num_short_lives++;
    }
  }

  var_2 _meth_870F("dlog_event_mp_life", ["attacker", var_15, "spawn_time_from_match_start_ms", var_8, "life_index", var_10, "spawn_evaluation_id", var_41, "spawn_critical_factor_bucket", var_42, "spawn_pos_x", var_39[0], "spawn_pos_y", var_39[1], "spawn_pos_z", var_39[2], "team", var_2.team, "is_host", var_2 ishost(), "was_tactical_insertion", var_40, "death_time_from_match_start_ms", var_9, "victim_weapon", var_26, "victim_weapon_attachments", var_25, "attacker_weapon", var_14, "attacker_weapon_attachments", var_5, "victim_death_modifiers", var_24, "attacker_death_modifiers", var_13, "death_pos_x", var_2.origin[0], "death_pos_y", var_2.origin[1], "death_pos_z", var_2.origin[2], "death_angle_x", var_2.angles[0], "death_angle_y", var_2.angles[1], "death_angle_z", var_2.angles[2], "attacker_pos_x", var_22[0], "attacker_pos_y", var_22[1], "attacker_pos_z", var_22[2], "attacker_angle_x", var_23[0], "attacker_angle_y", var_23[1], "attacker_angle_z", var_23[2], "means_of_death", var_4, "attacker_weapon_alt_mode", var_17, "attacker_weapon_picked_up", var_16, "victim_weapon_alt_mode", var_30, "victim_weapon_picked_up", var_29, "attacker_ads_value", var_18, "victim_ads_value", var_31, "attacker_was_in_victim_fov", var_19, "victim_was_in_attacker_fov", var_20, "attacker_mount_type", var_21, "victim_mount_type", var_32, "xp_earned", var_34, "score_earned", var_36, "victim_loadout_index", var_33, "attacker_life_index", var_11, "attacker_loadout_index", var_12, "victim_was_reloading", var_2 _meth_81E0(), "victim_was_executing", var_2 _meth_86C8(), "round", var_37, "is_hipfire", var_38, "first_damage_delivered_time_ms", var_43, "first_damage_delivered_type", var_44, "first_damage_delivered_weapon", var_45, "first_damage_received_time_ms", var_46, "first_damage_received_type", var_47, "first_damage_received_weapon", var_48]);
  var_2.pers["telemetry"]._id_9365.last_life_index_sent = var_10;
}

_id_AA5E(var_0) {
  on_player_match_end(var_0);
  var_1 = -1;

  if(data_has_last_life_info(var_0)) {
    var_1 = var_0.player.pers["telemetry"]._id_9365.last_life_index_sent;

    if(!isDefined(var_1)) {
      var_1 = -1;
    }
  }

  var_2 = -1;

  if(data_has_last_life_info(var_0)) {
    var_2 = var_0.player.pers["telemetry"]._id_9365.life_index;

    if(!isDefined(var_2)) {
      var_2 = -1;
    }
  }

  if(var_1 != var_2) {
    var_3 = spawnStruct();
    var_3._id_103C2 = var_0.player;
    var_3.attacker = undefined;
    var_3._id_10D86 = "none";
    var_3._id_9CD6 = "";

    if(isDefined(var_0.disconnectreason)) {
      if(var_0.disconnectreason == "EXE/SERVERCOMMANDOVERFLOW") {
        var_3._id_9CD6 = "MOD_DISCONNECTED";
      } else if(var_0.disconnectreason == "EXE/DISCONNECTED") {
        var_3._id_9CD6 = "MOD_QUIT";
      }
    }

    on_player_death(var_3);
  }
}

data_has_last_life_info(var_0) {
  if(!isDefined(var_0.player)) {
    return 0;
  }

  if(!isDefined(var_0.player.pers)) {
    return 0;
  }

  if(!isDefined(var_0.player.pers["telemetry"])) {
    return 0;
  }

  if(!isDefined(var_0.player.pers["telemetry"]._id_9365)) {
    return 0;
  }

  if(!isDefined(var_0.player.pers["telemetry"]._id_9365.life_index) && !isDefined(var_0.player.pers["telemetry"]._id_9365.last_life_index_sent)) {
    return 0;
  }

  return 1;
}

on_player_new_loadout_used(var_0) {
  if(isDefined(var_0.lifeindex)) {
    var_1 = var_0.lifeindex;
  } else {
    var_1 = -1;
  }

  var_2 = _id_07EE::_id_6DE4(gettime());
  var_3 = var_0._id_3808._id_9683;
  var_4 = [];

  for(var_5 = 0; var_5 < scripts\mp\class::_id_6B49(); var_5++) {
    var_4[var_5] = var_0._id_3808._id_9685[var_5];
  }

  var_6 = var_0._id_3808._id_9686;
  var_7 = var_0._id_3808._id_968C;
  var_8 = var_0._id_3808._id_9689;
  var_9 = var_0._id_3808._id_968E;
  var_10 = var_0._id_3808._id_9692;
  var_11 = [];

  for(var_5 = 0; var_5 < scripts\mp\class::_id_6B4B(); var_5++) {
    var_11[var_5] = var_0._id_3808._id_9694[var_5];
  }

  var_12 = var_0._id_3808._id_9695;
  var_13 = var_0._id_3808._id_969A;
  var_14 = var_0._id_3808._id_9698;
  var_15 = var_0._id_3808._id_969C;
  var_16 = var_0._id_3808._id_966A;
  var_17 = var_0._id_3808._id_966B;
  var_18 = [];
  var_19 = 3;

  for(var_20 = 0; var_20 < var_19; var_20++) {
    var_21 = "specialty_null";

    if(isDefined(var_0._id_3808._id_969F[var_20])) {
      var_21 = var_0._id_3808._id_969F[var_20];
    }

    var_18[var_20] = var_21;
  }

  var_22 = [];
  var_23 = var_0._id_3808._id_9670.size;

  if(var_23 > 3) {
    var_23 = 3;
  }

  for(var_20 = 0; var_20 < var_23; var_20++) {
    var_22[var_20] = var_0._id_3808._id_9670[var_20];
  }

  for(var_20 = 0; var_20 < 3; var_20++) {
    if(!isDefined(var_22[var_20])) {
      var_22[var_20] = "null";
    }
  }

  var_24 = "";

  if(isDefined(var_0.primaryblueprint)) {
    var_24 = var_0.primaryblueprint;
  }

  var_25 = "";

  if(isDefined(var_0.secondaryblueprint)) {
    var_25 = var_0.secondaryblueprint;
  }

  self _meth_870F("dlog_event_mp_player_loadout", ["loadout_index", var_0._id_9678, "class_type", var_0.classtype, "mid_match_edit_count", var_0.loadoutversionnumber, "first_use_life_index", var_1, "time_ms_from_match_start", var_2, "primary_weapon_setup_weapon", var_3, "primary_weapon_setup_attachment_0", var_4[0], "primary_weapon_setup_attachment_1", var_4[1], "primary_weapon_setup_attachment_2", var_4[2], "primary_weapon_setup_attachment_3", var_4[3], "primary_weapon_setup_attachment_4", var_4[4], "primary_weapon_setup_camo", var_6, "primary_weapon_setup_reticle", var_7, "primary_weapon_setup_loot_item_id", var_8, "primary_weapon_setup_variant_id", var_9, "secondary_weapon_setup_weapon", var_10, "secondary_weapon_setup_attachment_0", var_11[0], "secondary_weapon_setup_attachment_1", var_11[1], "secondary_weapon_setup_attachment_2", var_11[2], "secondary_weapon_setup_attachment_3", var_11[3], "secondary_weapon_setup_attachment_4", var_11[4], "secondary_weapon_setup_camo", var_12, "secondary_weapon_setup_reticle", var_13, "secondary_weapon_setup_loot_item_id", var_14, "secondary_weapon_setup_variant_id", var_15, "primary_grenade", var_16, "tactical_gear", var_17, "loadout_perk_0", var_18[0], "loadout_perk_1", var_18[1], "loadout_perk_2", var_18[2], "extra_loadout_perk_0", var_22[0], "extra_loadout_perk_1", var_22[1], "extra_loadout_perk_2", var_22[2], "killstreak_0", var_0._id_3808._id_9679, "killstreak_1", var_0._id_3808._id_967A, "killstreak_2", var_0._id_3808._id_967B, "field_upgrade_0", var_0._id_704A._id_9674, "field_upgrade_1", var_0._id_704A._id_9675, "primary_blueprint", var_24, "secondary_blueprint", var_25]);
}

send_player_weapon_stats_event(var_0) {
  if(!_id_06E2::is_valid_client(var_0) || scripts\mp\utility\game::getgametype() == "br") {
    return;
  }
  if(isbot(var_0) || _func_03DA(var_0) || isai(var_0)) {
    return;
  }
  var_1 = var_0 getplayerdata("rankedloadouts", "squadMembers", "player_xp");

  foreach(var_16, var_3 in var_0.pers["weaponStats"]) {
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;

    if(_func_030C("common", "LoadoutWeapon", var_3._id_04F6)) {
      var_4 = var_0 getplayerdata("rankedloadouts", "squadMembers", "weapon_xp", var_3._id_04F6);
    }

    foreach(var_15, var_14 in var_3._id_E76F) {
      if(var_15 == "xp_earned") {
        var_5 = var_5 + var_14;
      }

      if(var_15 == "deaths") {
        var_6 = var_6 + var_14;
      }

      if(var_15 == "headshots") {
        var_7 = var_7 + var_14;
      }

      if(var_15 == "hits") {
        var_8 = var_8 + var_14;
      }

      if(var_15 == "kills") {
        var_9 = var_9 + var_14;
      }

      if(var_15 == "shots") {
        var_10 = var_10 + var_14;
      }

      if(var_15 == "timeUsed") {
        var_11 = var_11 + var_14;
      }

      if(var_15 == "damage") {
        var_12 = var_12 + var_14;
      }
    }

    var_0 _meth_870F("dlog_event_mp_player_weapon_stats", ["weapon", var_3._id_04F6, "variant_id", var_3._id_04CC, "loadout_index", var_3._id_9678, "starting_weapon_xp", var_4, "xp_earned", var_5, "deaths", var_6, "headshots", var_7, "hits", var_8, "kills", var_9, "shots", var_10, "time_used_s", float(var_11), "damage", var_12]);
  }
}

update_weapon_stats(var_0) {
  if(scripts\mp\utility\weapon::_id_88F6(var_0._id_04FE) || scripts\mp\utility\weapon::_id_8AFA(var_0._id_04FE)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }
  var_1 = var_0._id_04FE;

  if(isDefined(self._id_9678)) {
    var_1 = var_1 + "+loadoutIndex" + self._id_9678;
  } else {
    return;
  }

  if(!isDefined(self.pers["weaponStats"][var_1])) {
    self.pers["weaponStats"][var_1] = spawnStruct();
    self.pers["weaponStats"][var_1]._id_E76F = [];
    self.pers["weaponStats"][var_1]._id_04F6 = var_0._id_04FE;
    self.pers["weaponStats"][var_1]._id_9678 = self._id_9678;

    if(isDefined(var_0._id_04CC)) {
      self.pers["weaponStats"][var_1]._id_04CC = var_0._id_04CC;
    } else {
      self.pers["weaponStats"][var_1]._id_04CC = -1;
    }
  }

  if(!isDefined(self.pers["weaponStats"][var_1]._id_E76F[var_0.statname])) {
    self.pers["weaponStats"][var_1]._id_E76F[var_0.statname] = var_0.incvalue;
  } else {
    self.pers["weaponStats"][var_1]._id_E76F[var_0.statname] = self.pers["weaponStats"][var_1]._id_E76F[var_0.statname] + var_0.incvalue;
  }

  if(var_0.statname == "shots") {
    self.pers["telemetry"].shots = self.pers["telemetry"].shots + var_0.incvalue;
  } else if(var_0.statname == "hits") {
    self.pers["telemetry"]._id_79B5 = self.pers["telemetry"]._id_79B5 + var_0.incvalue;
  }
}

on_player_score_event(var_0) {
  var_1 = var_0.player;

  if(scripts\mp\utility\entity::_id_8877(var_1) == 0) {
    return;
  }
  if(!_id_06E2::is_valid_client(var_1)) {
    return;
  }
  if(isbot(var_1) || _func_03DA(var_1) || isai(var_1)) {
    return;
  }
  var_2 = _id_06E2::get_time_from_match_start(gettime());
  self _meth_870F("dlog_event_mp_player_score_event", ["time_ms_from_match_start", var_2, "score_event", var_0.scoreevent]);
}

on_game_event(var_0) {
  var_1 = undefined;
  var_2 = -1;

  if(isDefined(var_0.player) && _id_06E2::is_valid_client(var_0.player) && scripts\mp\utility\entity::_id_8877(var_0.player)) {
    var_1 = var_0.player;

    if(isDefined(var_0.player.pers["telemetry"]._id_9365.life_index)) {
      var_2 = var_0.player.pers["telemetry"]._id_9365.life_index;
    }
  }

  var_3 = _id_06E2::get_time_from_match_start(gettime());
  var_4 = _func_00AC("gameEventCount");
  var_5 = var_4 + 1;
  setmatchdata("gameEventCount", var_5);
  _func_03BF("dlog_event_mp_game_event", ["event_player", var_1, "event_name", var_0._id_56B9, "time_from_match_start_ms", var_3, "player_life_index", var_2, "pos_x", var_0._id_033E[0], "pos_y", var_0._id_033E[1], "pos_z", var_0._id_033E[2]]);
}