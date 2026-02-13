/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2005.gsc
*************************************************/

_id_AAF2(var_0) {
  if(isDefined(level._id_5EFD)) {
    return;
  }
  level endon("abort_forfeit");
  level thread _id_5EFE();
  level._id_5EFD = 1;
  level._id_31B5 = 0;

  if(!level.teambased && level.players.size > 1) {
    wait 10;
  } else {
    wait 1.05;
  }

  level._id_5EFC = 0;
  var_1 = 20.0;
  _id_9BC6(var_1);
  var_2 = &"";

  if(!isDefined(var_0)) {
    var_2 = game["end_reason"]["players_forfeited"];
    var_3 = level.players[0];
  } else {
    if(var_0 == "allies") {
      var_2 = game["end_reason"]["spetsnaz_forfeited"];
    } else {
      var_2 = game["end_reason"]["marines_forfeited"];
    }

    var_3 = var_0;
  }

  level._id_5E90 = 1;

  if(isPlayer(var_3)) {
    _func_0141("forfeit, win: " + var_3 getxuid() + "(" + var_3.name + ")");
  } else {
    _func_0141("forfeit, win: " + var_3);

    foreach(var_5 in level._id_EF89) {
      _func_0141(var_5 + ":" + game["teamScores"][var_5]);
    }
  }

  thread _id_52F7(var_3, var_2);
}

_id_5EFE() {
  level endon("game_ended");

  if(getdvarfloat("#x3d60e87ed267605be") == 1) {
    level._id_4AB9 = 1;
    level notify("abort_forfeit");
  } else
    level waittill("abort_forfeit");

  level._id_5EFC = 1;
  level._id_31B5 = 1;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_match_start_countdown", 0);
    var_1 setclientomnvar("ui_match_in_progress", 1);
  }
}

_id_9BC7(var_0) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");

  while(var_0 > 0 && !level.gameended && !level._id_5EFC && !level._id_7EB0) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("ui_match_start_countdown", var_0);
      var_2 setclientomnvar("ui_match_in_progress", 0);
    }

    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_start_countdown", 0);
    var_2 setclientomnvar("ui_match_in_progress", 1);
  }
}

_id_9BC6(var_0) {
  level notify("match_forfeit_timer_beginning");
  var_1 = int(var_0);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  _id_9BC7(var_1);
}

_id_457D(var_0) {
  _func_0141("team eliminated: " + var_0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(var_0, "players")) {
      var_2 scripts\cp_mp\utility\game_utility::_id_E912();
    }

    _func_0435();
  }

  if(var_0 == "all") {
    _func_0141("tie");

    foreach(var_5 in level._id_EF89) {
      _func_0141(var_5 + ": " + game["teamScores"][var_5]);
    }

    if(level.teambased) {
      thread _id_52F7("tie", game["end_reason"]["tie"]);
      return;
    }

    thread _id_52F7(undefined, game["end_reason"]["tie"]);
    return;
  } else {
    var_7 = scripts\mp\utility\teams::_id_6A01(var_0);
    var_8 = [];

    foreach(var_5 in var_7) {
      var_8[var_5] = 0;
    }

    if(!istrue(level._id_4AE8)) {
      foreach(var_5 in var_7) {
        foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(var_5, "players")) {
          if(!istrue(var_2._id_75B4)) {
            continue;
          }
          var_8[var_5] = var_8[var_5] + var_2.pers["lives"];
        }
      }
    }

    var_15 = [];

    foreach(var_5 in var_7) {
      if(scripts\mp\utility\teams::_id_6DCA(var_5, "aliveCount") || var_8[var_5]) {
        var_15[var_15.size] = var_5;
      }
    }

    if(var_15.size == 1) {
      thread _id_52F7(var_15[0], game["end_reason"]["enemies_eliminated"]);
    }
  }
}

_id_457F(var_0) {
  if(level.teambased) {
    var_1 = scripts\mp\utility\game::_id_6AF7(var_0);

    if(isDefined(var_1)) {
      var_1 thread _id_6FAE();
    }
  } else {
    var_1 = scripts\mp\utility\game::_id_6AF7();
    _func_0141("last one alive, win: " + var_1.name);
    thread _id_52F7(var_1, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

_id_C93D(var_0, var_1) {
  _id_3567(var_0);

  if(istrue(var_1)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    waitframe();
  }

  var_2 = scripts\mp\utility\game::_id_6E99();

  if(scripts\mp\utility\game::_id_82D1() || scripts\mp\utility\game::_id_8424()) {
    if(scripts\mp\utility\game::_id_8AA1()) {
      if(scripts\mp\utility\game::_id_D728(var_0)) {
        foreach(var_4 in level.players) {
          var_4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_4.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_4.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread _id_52F7(var_0, game["end_reason"]["score_limit_reached"]);
      }
    } else {
      if(scripts\mp\utility\game::_id_8A16()) {
        return;
      }
      thread _id_52F7(var_0, game["end_reason"]["score_limit_reached"]);
      return;
    }
  } else if(level._id_C948 > 0) {
    var_6 = [];

    foreach(var_8 in level._id_EF89) {
      if(game["teamScores"][var_8] >= level._id_C948) {
        var_6[var_6.size] = var_8;
      }
    }

    if(var_6.size > 0) {
      if(var_6.size > 1) {
        var_10 = 0;
        var_11 = undefined;
        var_12 = 0;

        foreach(var_8 in var_6) {
          var_14 = game["teamScores"][var_8];

          if(!isDefined(var_11)) {
            var_10 = var_14;
            var_11 = var_8;
            var_12 = 0;
            continue;
          }

          if(var_14 > var_10) {
            var_10 = var_14;
            var_11 = var_8;
            var_12 = 0;
            continue;
          }

          if(var_14 == var_10) {
            var_12 = 1;
          }
        }

        if(var_12) {
          thread _id_52F7("tie", game["end_reason"]["score_limit_reached"]);
          return;
        }

        thread _id_52F7(var_11, game["end_reason"]["score_limit_reached"]);
        return;
      } else
        thread _id_52F7(var_6[0], game["end_reason"]["score_limit_reached"]);
    }
  }
}

_id_4580() {
  var_0 = "tie";

  if(level.teambased) {
    if(scripts\mp\utility\game::_id_82D1() || scripts\mp\utility\game::_id_8424()) {
      if(scripts\mp\utility\game::_id_8A16()) {
        var_1 = game["overtimeProgress"] + game["overtimeProgressFrac"];
        var_0 = scripts\mp\utility\game::_id_D6B6(game["attackers"], var_1 * 60.0);
      } else if(scripts\mp\utility\game::_id_8AA2())
        var_0 = game["timeToBeatTeam"];
    } else if(level.gametype == "base")
      var_0 = scripts\mp\gametypes\base::matchending_timeexpired_getwinner();
    else {
      var_0 = scripts\mp\gamescore::_id_6AA0();
    }

    _func_0141("time limit, win: " + var_0);

    foreach(var_3 in level._id_EF89) {
      _func_0141(var_3 + ":" + game["teamScores"][var_3]);
    }
  } else {
    var_0 = scripts\mp\gamescore::_id_6A9E();

    if(scripts\mp\gamescore::_id_88A2()) {
      var_0 = "tie";
    }

    if(isDefined(var_0) && isPlayer(var_0)) {
      _func_0141("time limit, win: " + var_0.name);
    } else {
      _func_0141("time limit, tie");
    }
  }

  thread _id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_457E() {
  var_0 = undefined;
  thread _id_52F7("halftime", game["end_reason"]["time_limit_reached"]);
}

forceend(var_0) {
  if(level._id_7AA2 || level._id_5E90) {
    return;
  }
  scripts\mp\gamescore::_id_FCF2();

  if(level.teambased) {
    foreach(var_2 in level._id_EF89) {
      scripts\mp\gamescore::_id_FD6B(var_2);
    }
  }

  var_4 = undefined;

  if(level.teambased) {
    var_4 = scripts\mp\gamescore::_id_6AA0();
    _func_0141("host ended game, win: " + var_4);

    foreach(var_2 in level._id_EF89) {
      _func_0141(var_2 + ":" + game["teamScores"][var_2]);
    }
  } else {
    var_4 = scripts\mp\gamescore::_id_6A9E();

    if(isDefined(var_4)) {
      _func_0141("host ended game, win: " + var_4.name);
    } else {
      _func_0141("host ended game, tie");
    }
  }

  level._id_5E90 = 1;
  level._id_7AA2 = 1;

  if(level.splitscreen) {
    var_7 = game["end_reason"]["ended_game"];
  } else {
    var_7 = game["end_reason"]["host_ended_game"];
  }

  if(isDefined(var_0) && var_0 == 2) {
    if(level.teambased) {
      if(var_4 == "allies") {
        var_8 = game["end_reason"]["spetsnaz_forfeited"];
      } else {
        var_8 = game["end_reason"]["marines_forfeited"];
      }
    } else
      var_8 = game["end_reason"]["players_forfeited"];
  } else if(istrue(level.leagueplaymatch) && istrue(level.leagueplaymatchcancelled)) {
    var_4 = "tie";
    var_7 = game["end_reason"]["lp_match_cancelled"];
  }

  level notify("force_end");
  thread _id_52F7(var_4, var_7);
}

_id_AB95(var_0) {
  var_1 = game["end_reason"]["score_limit_reached"];
  var_2 = "tie";

  if(level.teambased) {
    var_2 = scripts\mp\gamescore::_id_2F03();

    if(var_2 == "none") {
      var_2 = "tie";
    }

    _func_0141("scorelimit, win: " + var_2);

    foreach(var_4 in level._id_EF89) {
      _func_0141(var_4 + ":" + game["teamScores"][var_4]);
    }
  } else {
    var_2 = scripts\mp\gamescore::_id_6A9E();

    if(istrue(var_0) && scripts\mp\gamescore::_id_88A2()) {
      var_2 = "tie";
    }

    if(isDefined(var_2) && isPlayer(var_2)) {
      _func_0141("scorelimit, win: " + var_2.name);
    } else {
      _func_0141("scorelimit, tie");
    }

    var_6 = var_2 scripts\mp\killstreaks\killstreaks::_id_2EC5("nuke");

    if(scripts\mp\utility\game::_id_6D0E() == var_6 && var_2.pers["cur_kill_streak"] == var_6) {
      level._id_9FED = var_2;
      level._id_E72D = gettime();
      level._id_4B0D = 0;
      level._id_F25E = 0;
      var_7 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit");
      level._id_10AD4[var_7]._id_04CB = 30;
      level._id_AD6A[var_7] = 30;
      level._id_4DA1 = 1;
      return;
    }
  }

  thread _id_52F7(var_2, var_1);
  return 1;
}

_id_FC75() {
  var_0 = 0;
  level._id_EFB3 = [];

  foreach(var_2 in level._id_EF89) {
    var_3 = scripts\mp\utility\teams::_id_6DCA(var_2, "teamCount");
    var_0 = var_0 + var_3;

    if(var_3) {
      level._id_EFB3[level._id_EFB3.size] = var_2;
    }
  }

  if(scripts\mp\utility\game::matchmakinggame() && !level._id_7EB0 && (!isDefined(level._id_4AB9) || !level._id_4AB9)) {
    if(level.teambased) {
      if(level._id_EFB3.size == 1 && game["state"] == "playing") {
        thread _id_AAF2(level._id_EFB3[0]);
        return;
      }

      if(level._id_EFB3.size > 1) {
        level._id_5EFD = undefined;
        level notify("abort_forfeit");
      }
    } else {
      var_5 = 0;

      foreach(var_7 in level._id_EF89) {
        var_5 = var_5 + scripts\mp\utility\teams::_id_6DCA(var_7, "teamCount");
      }

      if(var_5 == 1 && level._id_9C91 > 1) {
        thread _id_AAF2();
        return;
      }

      if(var_5 > 1) {
        level._id_5EFD = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(level._id_EFB3.size == 1 && (istrue(level._id_2A34) || scripts\mp\utility\game::getgametype() != "br") && level.teambased) {
    return;
  }
  if(!scripts\mp\utility\game::_id_6A65() && (!isDefined(level._id_4AE8) || !level._id_4AE8)) {
    return;
  }
  if(!scripts\mp\utility\game::_id_60C5()) {
    return;
  }
  if(level._id_7EB0 && !isDefined(level._id_AD53)) {
    return;
  }
  if(level.teambased) {
    var_9 = [];

    foreach(var_7 in level._id_EF89) {
      var_9[var_7] = 0;
    }

    foreach(var_13 in level.players) {
      if(!istrue(var_13._id_75B4) || var_13.team == "spectator" || var_13.team == "follower" || var_13.team == "free") {
        continue;
      }
      var_9[var_13.team] = var_9[var_13.team] + var_13.pers["lives"];
    }

    if(istrue(level._id_4AE8)) {
      foreach(var_7 in level._id_EF89) {
        var_9[var_7] = 0;
      }
    }

    var_17 = 0;

    foreach(var_7 in level._id_EF89) {
      if(scripts\mp\utility\teams::_id_6DCA(var_7, "aliveCount")) {
        var_17 = 1;
        break;
      }
    }

    var_20 = 0;

    foreach(var_22 in var_9) {
      if(var_22) {
        var_20 = 1;
        break;
      }
    }

    if(!var_17 && !var_20) {
      if(istrue(level._id_BA49) && level.gameended) {
        level notify("exfil_continue_game_end");
      }

      if(istrue(level._id_A737)) {
        return;
      }
      return [[level._id_AAA3]]("all");
    }

    foreach(var_7 in level._id_EF89) {
      if(!scripts\mp\utility\teams::_id_6DCA(var_7, "aliveCount") && !var_9[var_7]) {
        if(istrue(level._id_BA49) && level.gameended) {
          level notify("exfil_continue_game_end");
        }

        if(!istrue(level._id_DDB6)) {
          if(istrue(level._id_A737)) {
            return;
          }
          if(level._id_A2FC) {
            if(!scripts\mp\utility\teams::_id_6DCA(var_7, "deathEvent") && scripts\mp\utility\teams::_id_6DCA(var_7, "hasSpawned")) {
              scripts\mp\utility\teams::_id_D70F(var_7, "deathEvent", 1);
              [[level._id_AAA3]](var_7);
            }

            continue;
          }

          return [[level._id_AAA3]](var_7);
        }
      }
    }

    foreach(var_7 in level._id_EF89) {
      var_27 = scripts\mp\utility\teams::_id_6DCA(var_7, "aliveCount");

      if(var_27 == 1 || var_27 == 2 || scripts\mp\utility\game::getgametype() == "control") {
        var_28 = 0;
        var_29 = undefined;
        var_30 = scripts\mp\utility\teams::_id_6DCA(var_7, "players");
        var_31 = [];

        foreach(var_13 in var_30) {
          if(!isalive(var_13)) {
            var_28 = var_28 + var_13.pers["lives"];
            continue;
          }

          var_31[var_31.size] = var_13;
        }

        if(var_27 != 1) {
          scripts\mp\utility\teams::_id_D70F(var_7, "oneLeft", 0);
        }

        var_34 = 0;

        if(scripts\mp\utility\game::getgametype() == "control") {
          var_9 = scripts\mp\utility\teams::_id_6DCA(var_7, "livesCount");
          var_35 = scripts\mp\utility\teams::_id_6DCA(var_7, "aliveCount");
          var_36 = var_9 + var_35;

          if(var_36 == 1 && level.numteamlives != 0) {
            var_34 = 1;
          }
        } else if(var_28 == 0)
          var_34 = 1;

        if(var_34) {
          if(var_27 == 1 && !scripts\mp\utility\teams::_id_6DCA(var_7, "oneLeft") && gettime() > scripts\mp\utility\teams::_id_6DCA(var_7, "oneLeftTime") + 5000) {
            scripts\mp\utility\teams::_id_D70F(var_7, "oneLeftTime", gettime());
            scripts\mp\utility\teams::_id_D70F(var_7, "oneLeft", 1);

            if(var_30.size > 1) {
              [[level._id_AB47]](var_7);
            }
          } else if(getDvar("#x3f59526763711edc4", "") != "dmz" && var_27 == 2 && var_30.size > 2) {
            var_37 = scripts\engine\utility::random(var_31);
            level thread scripts\mp\battlechatter_mp::_id_F759(var_37, "inform_last_two");
          }
        }

        continue;
      }

      scripts\mp\utility\teams::_id_D70F(var_7, "oneLeft", 0);
    }
  } else {
    var_9 = 0;

    foreach(var_13 in level.players) {
      if(var_13.team == "spectator" || var_13.team == "follower") {
        continue;
      }
      var_9 = var_9 + var_13.pers["lives"];
    }

    var_41 = 0;

    foreach(var_7 in level._id_EF89) {
      var_41 = var_41 + scripts\mp\utility\teams::_id_6DCA(var_7, "aliveCount");
    }

    if(!var_41 && !var_9) {
      if(istrue(level._id_A737)) {
        return;
      }
      return [[level._id_AAA3]]("all");
    }

    var_44 = scripts\mp\utility\game::_id_6C7B();

    if(var_44.size == 1) {
      return [[level._id_AB47]]("all");
    }
  }
}

_id_F218(var_0) {
  setgameendtime(gettime() + int(var_0 * 1000));
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 hide();

  if(var_0 >= 10.0) {
    wait(var_0 - 10.0);
  }

  for(;;) {
    wait 1.0;
  }
}

_id_1081D(var_0, var_1, var_2) {
  var_3 = gettime();

  if(istrue(game["isLaunchChunk"])) {
    var_4 = 0;
  } else if(var_0 > 5) {
    var_4 = gettime() + getdvarint("#x3e6000dca62024361") * 1000;
  } else {
    var_4 = 0;
  }

  if(var_2) {
    var_5 = max(1, level._id_3B83);
  } else {
    var_5 = max(1, level._id_3B83 / 2);
  }

  _id_07D1::_id_60C2("infil_setup_complete");
  var_6 = 0;

  for(;;) {
    if(istrue(game["roundsPlayed"])) {
      break;
    }

    var_7 = level._id_9C91;
    var_8 = _id_6D96();

    if(!var_6) {
      if(var_8 > 0) {
        var_3 = gettime();
        var_6 = 1;
      } else {
        waitframe();
        continue;
      }
    }

    var_9 = gettime();
    var_10 = var_7 >= var_5;
    var_11 = var_8 >= var_5;

    if(var_11) {
      foreach(var_13 in level._id_EF89) {
        if(!_id_3553(var_13, 0)) {
          var_10 = 0;
          break;
        }
      }
    }

    foreach(var_13 in level._id_EF89) {
      if(!_id_3554(var_13, 0)) {
        var_11 = 0;
        break;
      }
    }

    var_17 = var_3 + level._id_BBAD * 1000 - 200;

    if(_id_07D1::_id_60BE("infil_will_run") || istrue(var_1)) {
      if(var_11 && var_9 > var_4 || var_9 > var_17) {
        break;
      }
    } else if(var_10 && var_9 > var_4 || var_9 > var_17) {
      break;
    }

    waitframe();
  }
}

waitforplayersleagueplay(var_0, var_1) {
  if(istrue(game["roundsPlayed"])) {
    return;
  }
  var_2 = gettime();
  var_3 = var_2 + var_0 * 1000;
  var_4 = gettime() + getdvarint("#x3e6000dca62024361") * 1000;
  var_5 = level._id_C586["allies"] + level._id_C586["axis"];
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(getdvarint("#x3ba99a94c1ed5901", 0) && var_1) {
    var_5 = var_5 - getdvarint("#x3ba99a94c1ed5901", 0);
  }

  for(;;) {
    var_10 = gettime();
    var_11 = level._id_9C91;
    var_12 = _id_6D96();

    if(!var_6) {
      if(var_12 > 0) {
        var_2 = gettime();
        var_6 = 1;

        if(getdvarint("#x35299b9dd50e97627", 0)) {
          break;
        }
      } else {
        waitframe();
        continue;
      }
    }

    var_13 = var_11 >= var_5;
    var_14 = var_12 >= var_5;
    var_15 = 0;

    if(var_14) {
      foreach(var_23 in level._id_EF89) {
        if(!_id_3553(var_23, var_15)) {
          var_13 = 0;
          break;
        }
      }
    }

    if(istrue(var_1) && var_14 && var_10 > var_4) {
      break;
    } else if(var_13 && var_10 > var_4) {
      break;
    }

    if(var_10 > var_3) {
      var_7 = 1;
      break;
    }

    if(!var_1 && !var_8 && var_10 + level._id_BBAE * 1000 > var_3) {
      foreach(var_20 in level.players) {
        if(istrue(var_20._id_10848)) {
          var_26 = var_20 getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
          var_27 = scripts\engine\utility::ter_op(isDefined(var_26), var_26, 0);
          var_20 notify("loadout_class_selected", var_27);
          var_20 setclientomnvar("ui_options_menu", 0);
        }
      }

      var_8 = 1;
    }

    waitframe();
  }

  if(getdvarint("#x39fb6cdbec2745cb5", 0) || var_1) {
    return;
  }
  if(var_7) {
    scripts\mp\leagueplay::cancel_match();
  }
}

_id_6D96() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(istrue(var_2.pers["streamSyncComplete"])) {
      var_0++;
    }
  }

  return var_0;
}

_id_3553(var_0, var_1) {
  return scripts\mp\utility\teams::_id_6DCA(var_0, "hasSpawned") >= level._id_C586[var_0];
}

_id_3554(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(isDefined(var_4.team) && var_4.team == var_0 && istrue(var_4.pers["streamSyncComplete"])) {
      var_2++;
    }
  }

  return var_2 >= level._id_C586[var_0];
}

_id_BBAD() {
  level endon("game_ended");
  level._id_3B83 = getdvarint("#x345ba6dff8ecba1eb");

  if(getdvarint("#x336a286056d367e30", 0) == 1 && !istrue(level._id_DDC3)) {
    game["inLiveLobby"] = 1;

    if(getdvarint("#x387173deaef287a8d", 0) == 1) {
      level thread _id_10ACA();
    }

    level thread _id_10B24(1);
    level thread _id_10B29();
    level waittill("start_prematch");
    setDvar("#x336a286056d367e30", 0);
    game["inLiveLobby"] = 0;
    game["liveLobbyCompleted"] = 1;
    var_0 = 30;

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 = getdvarint("#x35e9ad9b1ee4858e1", 60);
    }

    if(scripts\mp\utility\game::getgametype() == "br" && istrue(level._id_7E69)) {
      var_0 = getdvarint("#x35e9ad9b1ee4858e1", 25);
    }

    level._id_15CA = 0;

    if(scripts\mp\utility\game::getgametype() == "br") {
      level._id_15CA = 1;
      _func_01E6(1, 1);
      _func_01E7(1, 1);
      level._id_A593 = 1;

      if(scripts\mp\gametypes\br_public::_id_8ACA()) {
        scripts\mp\gametypes\br_public::_id_745F();
      }
    }

    level _id_9595("match_starting_in", var_0);

    if(scripts\mp\utility\game::getgametype() == "br") {
      if(scripts\mp\gametypes\br_public::_id_8ACA()) {
        scripts\mp\gametypes\br_public::_id_745E();
      }
    }

    level notify("start_prematch");
    level._id_BBAD = 0;
    game["blockJIP"] = 1;
  } else if(!istrue(level._id_DDC3)) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var_2 = getdvarint("#x3e03e0043260c3e7f");

      if(var_2 != 0) {
        level thread _id_10B24();
        level thread _id_2C4D();
        level waittill("start_prematch");
      }

      var_0 = 15;

      if(scripts\mp\gametypes\br_public::_id_8ACA()) {
        scripts\mp\gametypes\br_public::_id_745F();
      }

      level._id_15CA = 0;

      if(scripts\mp\utility\game::getgametype() == "br") {
        level._id_15CA = 1;

        if(istrue(level._id_7E69)) {
          var_0 = getdvarint("#x35e9ad9b1ee4858e1", 25);
        }
      }

      level _id_9595("match_starting_in", var_0);

      if(scripts\mp\gametypes\br_public::_id_8ACA()) {
        scripts\mp\gametypes\br_public::_id_745E();
      }
    }
  }

  if(istrue(level._id_DDC3)) {
    while(!level.players.size) {
      waitframe();
    }
  }

  if(istrue(game["matchStartRequiresInput"])) {
    level waittill("pressToStartMatch");
  }

  if(istrue(game["blockJIP"])) {
    _func_01E6(1, 1);
    _func_01E7(1, 1);
    level._id_A593 = 1;
  }

  level notify("prematch_started");
  _func_0397(_id_6DE8(), 2);
  level._id_BBB5 = 1;

  if(level._id_BBAE > 0) {
    _id_9BF6();
  } else {
    _id_9BF5();
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();
  _func_0397(_id_6DE8(), 0);

  if(game["state"] != "playing") {
    return;
  }
}

_id_6F84() {
  wait 3;

  if(isDefined(level._id_AE38)) {
    foreach(var_1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_1)) {
        var_1[[level._id_AE38]]();
      }
    }
  }
}

_id_7116() {
  level endon("game_ended");

  if(!isDefined(game["clientActive"])) {
    while(_func_006F() == 0) {
      waitframe();
    }

    game["clientActive"] = 1;
  }

  while(level._id_7EB0 > 0) {
    wait 1.0;
    level._id_7EB0--;
  }

  level notify("grace_period_ending");
  waitframe();
  _id_07D1::_id_60C1("graceperiod_done");
  level._id_7EB0 = 0;

  if(game["state"] != "playing") {
    return;
  }
  if(scripts\mp\utility\game::_id_6A65()) {
    var_0 = level.players;

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(!var_2._id_75B4 && var_2.sessionteam != "spectator" && !isalive(var_2)) {
        var_2._id_0407 = "hud_status_dead";
      }
    }
  }

  level thread[[level._id_FC75]]();
}

_id_D58D(var_0, var_1) {
  if(var_1 && !istrue(var_0._id_7555)) {
    scripts\mp\class::_id_4A86();
  }

  var_0._id_7555 = var_1;

  if(scripts\mp\utility\game::getgametype() == "br" && !_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  if(var_1 && !istrue(var_0.pers["hasDoneAnyCombat"])) {
    var_0.pers["hasDoneAnyCombat"] = 1;

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 scripts\mp\utility\stats::_id_7DAE("gamesPlayed", 1);
    }

    if(isDefined(var_0.pers["hasMatchLoss"]) && var_0.pers["hasMatchLoss"]) {
      return;
    }
    _id_FCB6(var_0);
  }
}

_id_FD94(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }
  if(istrue(var_0.pers["recordedLoss"])) {
    var_0 _id_0804::_id_116A(-1, "matchStats", "losses");
  }

  var_0 _id_0804::_id_116A(1, "matchStats", "wins");
  var_0 _id_0804::_id_116A(1, "matchStats", "currentWinStreak");
  var_0 _id_0804::_id_116A(1, "modeRecords", scripts\mp\utility\game::getgametype());
  var_1 = var_0 _id_0804::_id_6C64("matchStats", "currentWinStreak");

  if(var_1 > var_0 _id_0804::_id_6C64("bestStats", "longestWinStreak")) {
    var_0 _id_0804::_id_D672(var_1, "bestStats", "longestWinStreak");
  }

  var_0 scripts\mp\persistence::_id_E770("round", "win", 1);
  var_0 scripts\mp\persistence::_id_E770("round", "loss", 0);
}

_id_FCB6(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }
  var_0.pers["hasMatchLoss"] = 1;

  if(!istrue(self._id_8BD9)) {
    var_0 _id_0804::_id_116A(1, "matchStats", "losses");
    var_0.pers["recordedLoss"] = 1;
  }

  var_0 _id_0804::_id_116A(1, "matchStats", "gamesPlayed");
  var_0 scripts\mp\persistence::_id_E770("round", "loss", 1);
}

_id_FD61(var_0) {
  if(!var_0 scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!istrue(var_0.pers["hasDoneAnyCombat"])) {
    return;
  }
  if(istrue(var_0.pers["recordedLoss"])) {
    var_0 _id_0804::_id_116A(-1, "matchStats", "losses");
    var_0 _id_0804::_id_D672(0, "matchStats", "currentWinStreak");
  }

  var_0 _id_0804::_id_116A(1, "matchStats", "ties");
  var_0 scripts\mp\persistence::_id_E770("round", "loss", 0);
}

_id_FD93(var_0) {
  if(scripts\mp\utility\game::privatematch()) {
    return;
  }
  if(!scripts\mp\utility\game::_id_10A16()) {
    return;
  }
  level._id_BD69 = 1;
  var_1 = level.players;
  _id_FCF7();

  if(!isDefined(var_0) || isDefined(var_0) && _func_0121(var_0) && var_0 == "tie") {
    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_3B82)) {
        continue;
      }
      if(level._id_7AA2 && var_3 ishost()) {
        var_3 _id_0804::_id_D672(0, "matchStats", "currentWinStreak");
        continue;
      }

      _id_FD61(var_3);
    }
  } else if(isPlayer(var_0)) {
    if(level._id_7AA2 && var_0 ishost()) {
      var_0 _id_0804::_id_D672(0, "matchStats", "currentWinStreak");
      return;
    }

    if(isDefined(level._id_902C)) {
      _id_FD94(level._id_B16C["all"][0]);
    } else {
      for(var_5 = 0; var_5 < min(level._id_B16C["all"].size, 3); var_5++) {
        _id_FD94(level._id_B16C["all"][var_5]);
      }
    }
  } else if(_func_0121(var_0)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_3B82)) {
        continue;
      }
      if(level._id_7AA2 && var_3 ishost()) {
        var_3 _id_0804::_id_D672(0, "matchStats", "currentWinStreak");
        continue;
      }

      if(var_0 == "tie") {
        _id_FD61(var_3);
        continue;
      }

      if(var_3.pers["team"] == var_0) {
        _id_FD94(var_3);
        continue;
      }

      if(istrue(var_3.pers["recordedLoss"])) {
        var_3 _id_0804::_id_D672(0, "matchStats", "currentWinStreak");
      }
    }
  }

  foreach(var_3 in level.players) {
    var_9 = isPlayer(var_0) || _func_0121(var_0) && var_3.pers["team"] == var_0 && !isDefined(var_3._id_3B82);

    if(var_9) {
      _func_0493(var_3);
    }
  }

  _func_0494();

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !var_3 scripts\mp\utility\game::onlinestatsenabled()) {
      continue;
    }
    if(isai(var_3)) {
      continue;
    }
    var_12 = var_3 _id_0804::_id_6C64("matchStats", "wins");
  }
}

_id_FCF7() {
  if(scripts\mp\utility\game::getgametype() != "infect") {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator" && !var_1._id_03EB) {
      continue;
    } else if(istrue(var_1.pers["hasDoneAnyCombat"])) {
      continue;
    } else if(var_1.team == "axis") {
      continue;
    } else {
      var_1 _id_D58D(var_1, 1);
    }
  }
}

_id_5F64(var_0) {
  self endon("disconnect");
  _id_0A99::_id_D5EA(0);
  _id_0A99::_id_3959();

  if(!isDefined(var_0)) {
    var_0 = level._id_5F3A;
  }

  wait(var_0);
  scripts\mp\playeractions::_id_1596("gameEndFreeze", 0);

  if(self isonground() || self isonladder()) {
    self allowmovement(0);
  } else {
    thread _id_60BB();
  }
}

_id_60BB() {
  var_0 = 0.0;

  while(var_0 < 1) {
    if(!self isonground()) {
      var_0 = var_0 + level._id_5F3A;
    } else {
      self allowmovement(0);
      break;
    }

    wait(level._id_5F3A);
  }

  self allowmovement(0);
}

_id_FCBB(var_0) {
  if(!game["timePassed"]) {
    return;
  }
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(!scripts\mp\utility\game::_id_6DE5() || level._id_5E90) {
    var_1 = scripts\mp\utility\game::_id_6DE6() / 1000;
    var_1 = min(var_1, 1200);
  } else
    var_1 = scripts\mp\utility\game::_id_6DE5();

  if(level.teambased) {
    if(var_0 != "tie") {
      _func_01FF(var_0);
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_3B82)) {
        continue;
      }
      if(!var_3 scripts\mp\utility\game::rankingenabled()) {
        continue;
      }
      if(var_3._id_F242["total"] < 1 || var_3.pers["participation"] < 1) {
        continue;
      }
      if(level._id_7AA2 && var_3 ishost()) {
        continue;
      }
      if(!istrue(var_3.pers["hasDoneAnyCombat"])) {
        continue;
      }
      if(var_0 == "tie") {
        var_4 = var_3 _id_2EED("tie", var_1);
        var_3 thread _id_6FB4("tie", var_4);
        var_3._id_9BA8 = var_4;
      } else if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_0) {
        var_4 = var_3 _id_2EED("win", var_1);
        var_3 thread _id_6FB4("win", var_4);
        var_3._id_9BA8 = var_4;
      } else if(isDefined(var_3.pers["team"]) && scripts\mp\utility\teams::_id_8878(var_3.pers["team"]) && var_3.pers["team"] != var_0) {
        var_4 = var_3 _id_2EED("loss", var_1);
        var_3 thread _id_6FB4("loss", var_4);
        var_3._id_9BA8 = var_4;
      }

      var_3 _id_2F02(var_1);
    }
  } else {
    var_6 = "win";
    var_7 = "loss";

    if(!isDefined(var_0)) {
      var_6 = "tie";
      var_7 = "tie";
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_3B82)) {
        continue;
      }
      if(var_3._id_F242["total"] < 1 || var_3.pers["participation"] < 1) {
        continue;
      }
      if(!istrue(var_3.pers["hasDoneAnyCombat"])) {
        continue;
      }
      var_9 = 0;

      for(var_10 = 0; var_10 < min(level._id_B16C["all"].size, 3); var_10++) {
        if(level._id_B16C["all"][var_10] != var_3) {
          continue;
        }
        var_9 = 1;
      }

      if(var_9) {
        var_4 = var_3 _id_2EED(var_6, var_1);
        var_3 thread _id_6FB4("win", var_4);
        var_3._id_9BA8 = var_4;
      } else {
        var_4 = var_3 _id_2EED(var_7, var_1);
        var_3 thread _id_6FB4("loss", var_4);
        var_3._id_9BA8 = var_4;
      }

      var_3 _id_2F02(var_1);
    }
  }
}

_id_2EED(var_0, var_1) {
  var_2 = 250;
  var_3 = var_1 / 60;
  var_4 = scripts\mp\rank::getscoreinfovalue(var_0);
  var_5 = self._id_F242["total"] / var_1;
  var_6 = int(var_2 * var_4 * var_3 * var_5);
  var_6 = int(min(var_6, 16384));
  return var_6;
}

_id_6FB4(var_0, var_1) {
  self endon("disconnect");

  if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::_id_6D9E() != "dmz") {
    return;
  }
  level waittill("give_match_bonus");
  scripts\mp\rank::giverankxp(var_0, var_1, undefined, 1, 1);

  if(var_0 == "win") {
    thread _id_07B1::_id_6FB9("match_complete_win");
  } else {
    thread _id_07B1::_id_6FB9("match_complete");
  }
}

_id_2F02(var_0) {
  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }
  var_1 = _id_0826::_id_6A63() / 60;
  var_2 = var_0 / 60;
  var_3 = int(var_1 * var_2);
  var_4 = int(50.0);
  var_5 = self._id_F242["total"] / var_0;
  var_6 = var_4 * var_5;
  var_7 = int(var_3 * var_6);
  var_7 = var_7 - int(self.pers["weaponMatchBonusKills"] * var_6);

  if(var_7 <= 0) {
    return;
  }
  var_8 = 0;

  foreach(var_10 in self.pers["killsPerWeapon"]) {
    var_8 = var_8 + (var_3 - var_10._id_8D6E);
  }

  if(var_8 <= 0) {
    return;
  }
  foreach(var_19, var_10 in self.pers["killsPerWeapon"]) {
    var_13 = (var_3 - var_10._id_8D6E) / var_8;
    var_14 = int(var_7 * var_13);
    scripts\mp\rank::incrankxp(var_14, var_10.objweapon, "WeaponMatchBonus");

    foreach(var_18, var_16 in self.pers["weaponStats"]) {
      if(issubstr(var_18, var_19)) {
        if(isDefined(var_16._id_E76F["kills"]) && var_10._id_8D6E > 0) {
          var_17 = var_13 * (var_16._id_E76F["kills"] / var_10._id_8D6E);
          var_14 = int(var_7 * var_17);

          if(isDefined(var_16._id_E76F["xp_earned"])) {
            var_16._id_E76F["xp_earned"] = var_16._id_E76F["xp_earned"] + var_14;
          } else {
            var_16._id_E76F["xp_earned"] = var_14;
          }
        }
      }
    }
  }
}

_id_D8F4(var_0) {
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3._id_038F) || !isDefined(var_3.pers["team"])) {
      continue;
    }
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    _id_0CEF(var_3);
  }
}

_id_0CEF(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(istrue(var_0.pers["xenonRankSet"])) {
    return;
  }
  if(!isDefined(var_0._id_0267) || !isDefined(var_0._id_0157)) {
    return;
  }
  if(scripts\mp\utility\game::_id_875E()) {
    if(1 > var_0._id_F242["total"]) {
      return;
    }
    if(!isDefined(var_0._id_1A9F)) {
      return;
    }
    var_2 = var_0._id_1A9F;
    _func_01ED(var_0, var_0._id_399D, var_2);
    var_0.pers["xenonRankSet"] = 1;
  } else if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::_id_6D9E() == "") {
    var_3 = 1000 - var_1;
    _func_01ED(var_0, var_0._id_399D, var_3);
    var_0.pers["xenonRankSet"] = 1;
  } else {
    if(120 > var_0._id_F242["total"]) {
      return;
    }
    var_4 = 0;

    if(getdvarint("#x35cea22b6773d42c0") == 1) {
      var_4 = var_0 scripts\mp\utility\stats::_id_6C29("suicides");
    }

    var_5 = (var_0._id_0267 - (var_0._id_0157 - var_4)) / (var_0._id_F242["total"] / 60);
    _func_01ED(var_0, var_0._id_399D, var_5);
    var_0.pers["xenonRankSet"] = 1;
  }
}

_id_3568(var_0) {
  if(isDefined(level._id_F21A) && level._id_F21A) {
    return;
  }
  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  _id_CA45();

  if(scripts\mp\utility\game::_id_6DE5() <= 0) {
    if(isDefined(level._id_E72D)) {
      setgameendtime(level._id_E72D);
    } else {
      setgameendtime(0);
    }

    return;
  }

  if(!_id_07D1::_id_60BE("prematch_done")) {
    setgameendtime(0);
    return;
  }

  if(!isDefined(level._id_E72D)) {
    return;
  }
  if(istrue(level._id_F262)) {
    return;
  }
  var_1 = _id_6DE8();
  setgameendtime(gettime() + int(var_1));
  var_2 = istrue(level._id_ABC2);

  if(var_1 > 0 && !isDefined(level._id_5EB6)) {
    if(var_2) {
      if(istrue(level._id_D46A)) {
        _func_01EA("ui_overtime_timer_show", 0);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
      }
    }

    return;
  }

  if(var_2) {
    _id_07D1::_id_60C1("overtime_started");

    if(!isDefined(level._id_AD75)) {
      level._id_AD75 = 0;
    } else {
      level._id_AD75 = level._id_AD75 + level._id_01E2;
    }

    if(isDefined(level._id_ABC3)) {
      [[level._id_ABC3]]();
      level._id_ABC3 = undefined;
    }

    if(istrue(level._id_31B5)) {
      level._id_4203 = level._id_4203 + level._id_5F3A;
    } else {
      level._id_4203 = 0;
    }

    var_3 = clamp(1.0 - level._id_4203 / level._id_ABC2, 0.0, 1.0);

    if(level._id_4203 < level._id_ABC2) {
      if(istrue(level._id_D46A)) {
        if(!isDefined(level._id_5EAB)) {
          _func_01EA("ui_overtime_timer_show", 1);
        }

        _func_01EA("ui_overtime_timer", var_3);
      } else {
        setomnvar("ui_overtime_timer_show", 1);
        setomnvar("ui_overtime_timer", var_3);
      }

      setomnvar("ui_overtime_time", gettime() + level._id_ABC2 * 1000);
    } else {
      if(istrue(level._id_D46A)) {
        _func_01EA("ui_overtime_timer_show", 0);
        _func_01EA("ui_overtime_timer", var_3);
      } else {
        setomnvar("ui_overtime_timer_show", 0);
        setomnvar("ui_overtime_timer", var_3);
      }

      setomnvar("ui_overtime_time", gettime() + level._id_ABC2 * 1000);
    }

    if(level._id_4203 < level._id_ABC2) {
      return;
    }
  }

  [[level._id_ABC0]]();
}

_id_5263() {
  level._id_ABC2 = 5.0;
  level._id_4203 = 0.0;
}

_id_CA45() {
  if(!level.matchmakingmatch) {
    return;
  }
  if(!isDefined(level._id_A593)) {
    level._id_A593 = 0;
  }

  if(!level._id_A593) {
    if(scripts\mp\utility\game::isroundbased() && !level._id_A593) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "dom":
        case "front":
          var_0 = _id_34F5();
          break;
        case "arena_evo":
        case "arena":
        case "cyber":
        case "siege":
        case "sr":
        case "sd":
          var_0 = _id_3559();
          break;
        case "ctf":
          var_0 = _id_34F0();
          break;
        case "ball":
          var_0 = _id_34E3();
          break;
        case "dd":
          var_0 = _id_34F2();
          break;
        default:
          var_0 = _id_34F3();
          break;
      }

      if(var_0) {
        _func_01E6(1, 1);
        _func_01E7(1, 1);
        level._id_A593 = 1;
        return;
      }
    } else if(scripts\mp\utility\game::_id_6DE7() > level._id_F23F) {
      _func_01E7(1, 1);
      level._id_A593 = 1;
    }
  }
}

_id_34F5() {
  if(!scripts\mp\utility\game::_id_885C()) {
    foreach(var_1 in level._id_EF89) {
      if(_id_6DD8(var_1) > 150) {
        return 1;
      }
    }

    if(scripts\mp\utility\game::_id_6DE7() > 75) {
      return 1;
    }
  }

  return 0;
}

_id_3559() {
  var_0 = 3;

  switch (scripts\mp\utility\game::getgametype()) {
    case "sr":
    case "sd":
      var_0 = 3;
      break;
    case "siege":
      var_0 = 2;
      break;
    case "cyber":
      var_0 = 2;
      break;
    case "arena_evo":
    case "arena":
      var_0 = 3;
      break;
    default:
      var_0 = 3;
      break;
  }

  if(scripts\mp\utility\game::isanymlgmatch()) {
    var_0 = 5;
  }

  foreach(var_2 in level._id_EF89) {
    if(scripts\mp\utility\game::_id_6CFE(var_2) >= var_0) {
      return 1;
    }
  }

  return 0;
}

_id_34F0() {
  if(!scripts\mp\utility\game::_id_885C()) {
    if(scripts\mp\utility\game::_id_6DE7() > level._id_F23F) {
      return 1;
    }
  }

  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level._id_EF89) {
    var_4 = _id_6DD8(var_3);

    if(!isDefined(var_0) || var_4 < var_0) {
      var_0 = var_4;
    }

    if(!isDefined(var_1) || var_4 > var_1) {
      var_1 = var_4;
    }
  }

  var_6 = abs(var_1 - var_0);

  if(var_6 > 10) {
    return 1;
  }

  return 0;
}

_id_34E3() {
  if(!scripts\mp\utility\game::_id_885C()) {
    if(scripts\mp\utility\game::_id_6DE7() > level._id_F23F) {
      return 1;
    }
  }

  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level._id_EF89) {
    var_4 = _id_6DD8(var_3);

    if(!isDefined(var_0) || var_4 < var_0) {
      var_0 = var_4;
    }

    if(!isDefined(var_1) || var_4 > var_1) {
      var_1 = var_4;
    }
  }

  var_6 = abs(var_1 - var_0);

  if(var_6 > 15) {
    return 1;
  }

  return 0;
}

_id_34F2() {
  var_0 = 0;

  foreach(var_2 in level._id_EF89) {
    var_0 = var_0 + scripts\mp\utility\game::_id_6CFE(var_2);
  }

  if(var_0 >= 3) {
    return 1;
  }

  return 0;
}

_id_34F3() {
  if(scripts\mp\utility\game::_id_A4CD()) {
    if(scripts\mp\utility\game::_id_6DE7() > level._id_F23F) {
      return 1;
    }
  }

  return 0;
}

_id_6DD8(var_0) {
  return int(game["teamScores"][var_0]);
}

_id_6DE8() {
  var_0 = 0;

  if(isDefined(level.esportstimerdiscardtime)) {
    var_0 = level.esportstimerdiscardtime;
  }

  return scripts\mp\utility\game::_id_6DE5() * 1000 - scripts\mp\utility\game::_id_6DE6() - var_0;
}

_id_6DE9() {
  var_0 = scripts\mp\utility\game::_id_6DE5() * 1000;
  return (var_0 - scripts\mp\utility\game::_id_6DE6()) / var_0;
}

_id_3567(var_0) {
  if(level._id_C948 <= 0 || scripts\mp\utility\game::_id_8957()) {
    return;
  }
  if(isDefined(level._id_CC0B) && level._id_CC0B) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "jugg") {
    return;
  }
  if(!level.teambased) {
    return;
  }
  var_1 = 0;

  if(_id_DB11()) {
    var_1 = _id_39F9(var_0);
  } else if(scripts\mp\utility\game::getgametype() == "arm") {
    var_2 = _id_39F9(var_0);
    var_3 = _id_6DE8() < scripts\mp\utility\game::_id_6DE5() * 0.075;
    var_1 = var_2 || var_3;
  } else {
    var_4 = undefined;

    if(scripts\mp\utility\game::gametypestopsclock()) {
      var_4 = scripts\mp\utility\game::gettimepassedwithpauses();
    } else {
      var_4 = scripts\mp\utility\game::_id_6DE6();
    }

    if(var_4 > 45000) {
      var_5 = _id_5643(var_0);
      var_1 = undefined;

      if(scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "patrol") {
        var_1 = var_5 < 0.6;
      } else {
        var_1 = var_5 < 0.75;
      }
    }
  }

  if(!isDefined(level._id_B398)) {
    level._id_B398 = 0;
  }

  if(!level._id_B398 && var_1) {
    level._id_B398 = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level._id_B398 && scripts\mp\utility\game::_id_31B1()) {
    if(_func_00DB(var_0) >= int(level._id_CC09 * level._id_41EA - level._id_CC09 / 2)) {
      _id_0A8D::_id_9136("halfway_friendly_score", var_0, "status");
      var_6 = scripts\mp\utility\teams::_id_6A01(var_0);

      foreach(var_8 in var_6) {
        _id_0A8D::_id_9136("halfway_enemy_score", var_8, "status");
      }

      level._id_4971 = 1;
    }
  }
}

_id_DB11() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "conf":
    case "tdef":
    case "dom":
    case "base":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

_id_3539() {
  if(level._id_C948 <= 0 || scripts\mp\utility\game::_id_8957()) {
    return;
  }
  if(level.teambased) {
    return;
  }
  if(scripts\mp\utility\game::_id_6DE6() < 45000) {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level._id_A593) && !level._id_A593 && scripts\mp\utility\game::getgametype() != "infect") {
    scripts\mp\gamescore::_id_34FE();
  }

  if(scripts\mp\utility\game::getgametype() == "gun") {
    if(self._id_038F == 14) {
      level notify("match_ending_soon", "score");
    }
  } else {
    var_0 = _id_5643();

    if(var_0 < 0.75) {
      level notify("match_ending_soon", "score");
    }
  }
}

_id_3557(var_0) {
  if(scripts\mp\utility\game::_id_31F6()) {
    var_0 = 1;
  }

  if(istrue(var_0)) {
    if(!level.teambased && isDefined(self._id_038F) && self._id_038F >= level._id_C948) {
      level._id_CC0C = 1;
    }

    level notify("checkScoreLimit");
    level endon("checkScoreLimit");
    waitframe();
  }

  if(scripts\mp\utility\game::_id_8957()) {
    return 0;
  }

  if(isDefined(level._id_CC0B) && level._id_CC0B) {
    return 0;
  }

  if(game["state"] != "playing") {
    return 0;
  }

  if(level._id_C948 <= 0) {
    return 0;
  }

  if(level.teambased) {
    var_1 = 0;

    for(var_2 = 0; var_2 < level._id_EF89.size; var_2++) {
      if(game["teamScores"][level._id_EF89[var_2]] >= level._id_C948) {
        var_1 = 1;
      }
    }

    if(!var_1) {
      return 0;
    }
  } else {
    if(!isPlayer(self)) {
      return 0;
    }

    if(self._id_038F < level._id_C948 && !istrue(level._id_CC0C)) {
      return 0;
    }
  }

  if(!istrue(level._id_4DA1)) {
    return _id_AB95(var_0);
  }
}

_id_FC7D() {
  level endon("game_ended");

  while(game["state"] == "playing") {
    if(isDefined(level._id_E72D)) {
      if(_id_6DE8() < 3000) {
        wait 0.1;
        continue;
      }
    }

    wait 1;
  }
}

_id_9BF6() {
  if(istrue(level.leagueplaymatch)) {
    waitforplayersleagueplay(level.leagueplayprematchcancellingtimeout, 1);
    level thread _id_BBA1();
  } else {
    thread _id_9BF2("match_starting_in", level._id_BBAD + level._id_BBAE);
    level thread _id_BBA1();
    _id_1081D(level._id_BBAD, 0, 0);
  }

  _id_07D1::_id_60C1("prematch_waitForPlayers_Complete");

  if(level._id_BBAE > 0 && !isDefined(level._id_7AAE)) {
    var_0 = level._id_BBAE;
    level notify("match_start_real_countdown", var_0);

    if(istrue(level.leagueplaymatch)) {
      var_1 = level._id_BBAD * 2 + var_0;
      level.leagueplayloadingcomplete = 1;
      level notify("leaguePlayLoadingComplete");
      setomnvar("ui_mp_extended_load_screen", 0);
      setomnvar("ui_match_start_text", "waiting_for_players");
      waitforplayersleagueplay(var_1, 0);
    }

    if(!_id_07D1::_id_60BE("infil_will_run") && game["roundsPlayed"] == 0 && !scripts\cp_mp\utility\game_utility::_id_875F()) {
      level thread _id_DCC1();
    }

    thread _id_9BF2("match_starting_in", var_0);
    thread _id_BBA1(var_0);
    level waittill("matchStartTimer_done");
  }
}

_id_DCC1() {
  setomnvar("ui_in_infil", 1);
  level scripts\engine\utility::_id_108F5("matchStartTimer_done", 8.0);
  setomnvar("ui_in_infil", -1);
}

_id_BBA1(var_0) {
  level notify("prematchCountdownNotify");
  level endon("prematchCountdownNotify");

  if(isDefined(var_0)) {
    wait(max(var_0 - 5, 0));
  } else {
    wait(max(level._id_BBAD + level._id_BBAE - 5, 0));
  }

  _id_07D1::_id_60C1("prematch_countdown");
}

_id_E6E9(var_0) {
  self notify("startOBJID");
  self endon("startOBJID");

  if(scripts\mp\utility\game::getgametype() == "sd") {
    var_1 = 6;
  } else {
    var_1 = 5;
  }

  if(var_0 > var_1) {
    var_0 = var_0 - var_1;
    max(var_0, 0);
    wait(var_0);
  }

  level notify("start_mode_setup");
}

_id_9BF2(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);
  level thread _id_E6E9(var_2);

  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    _id_9BF4(var_2);
  }

  visionsetnaked("", 0.0);
  level notify("matchStartTimer_done");

  if(scripts\cp_mp\utility\game_utility::_id_89EC() || istrue(level._id_F0E0)) {
    foreach(var_4 in level.players) {
      if(istrue(level._id_F0E0)) {
        if(!isDefined(var_4._id_89EC)) {
          if(scripts\engine\utility::cointoss()) {
            var_4 setclientomnvar("ui_realism_hud", 0);
            var_4 setclientomnvar("ui_realism_hud", 1);
            var_4._id_89EC = 1;
          }
        }

        continue;
      }

      var_4 setclientomnvar("ui_realism_hud", 0);
      var_4 setclientomnvar("ui_realism_hud", 1);
    }
  }
}

_id_9BF4(var_0) {
  waittillframeend;
  level endon("match_start_timer_beginning");
  var_1 = undefined;

  foreach(var_3 in level._id_EF89) {
    var_4 = int(var_0);
    childthread _id_EFB1(var_3, var_4);

    if(!isDefined(var_1) || var_1 < var_4) {
      var_1 = var_4;
    }
  }

  var_6 = ["spectator", "follower"];

  foreach(var_3 in var_6) {
    var_4 = int(var_0);
    childthread _id_EFB1(var_3, var_4);

    if(!isDefined(var_1) || var_1 < var_4) {
      var_1 = var_4;
    }
  }

  childthread _id_3994(var_1);
  wait(var_1);
}

_id_EFB1(var_0, var_1) {
  level endon("match_start_timer_beginning");
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 hide();
  level._id_9BAA = var_1;

  if(!level.gameended) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      thread scripts\mp\gametypes\br_public::_id_BBAC(var_0);
      thread scripts\mp\gametypes\br_public::_id_BBA3(var_0);
      thread scripts\mp\gametypes\br_public::_id_19E5();
    }

    while(var_1 > 0 && !level.gameended) {
      if(var_1 < 6) {
        if(var_1 < 4) {} else {}
      }

      var_3 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

      foreach(var_5 in var_3) {
        if(var_1 <= 80) {
          var_5 setclientomnvar("ui_match_start_countdown", var_1);
          var_5 setclientomnvar("ui_match_in_progress", 0);
        }
      }

      var_1--;
      level._id_9BAA = var_1;
      wait 1.0;
      var_7 = scripts\mp\codcaster_utils::esportshandletimeout(1, var_1 * 1000);

      if(var_7 > 0 && var_1 <= 10) {
        var_1 = var_7;
      }
    }

    scripts\mp\codcaster_utils::esportsresumetimer();
    level._id_9BAA = undefined;
    var_2 delete();
    var_3 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

    foreach(var_5 in var_3) {
      scripts\mp\playerlogic::_id_3970(var_5);

      if(scripts\mp\utility\game::getgametype() != "arena_evo") {
        var_5 scripts\mp\utility\player::_freezecontrols(0, 1);
      }

      var_5 setclientomnvar("ui_match_start_countdown", -1);
      var_5 setclientomnvar("ui_match_in_progress", 1);
    }
  }
}

_id_3994(var_0) {
  while(var_0 > 0 && !level.gameended) {
    var_0--;
    wait 1.0;
  }

  visionsetnaked("", 0);
}

_id_9BF5() {
  visionsetnaked("", 0);
}

_id_AB93(var_0) {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(var_0) {
    level._id_73BD = "overtime";

    if(scripts\mp\utility\game::_id_8904()) {
      var_1 = _id_691F();

      if(var_1 != game["defenders"]) {
        game["switchedsides"] = !game["switchedsides"];
        level._id_EC31 = 1;
        return;
      }

      level._id_EC31 = undefined;
      return;
    } else {
      game["switchedsides"] = !game["switchedsides"];
      level._id_EC31 = 1;
    }
  } else if(istrue(level._id_DDA9)) {
    game["switchedsides"] = !game["switchedsides"];
    level._id_EC31 = 1;
  } else if(_id_DB66()) {
    var_1 = _id_691F();

    if(var_1 != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
      level._id_EC31 = 1;
      return;
    }

    level._id_EC31 = undefined;
    return;
  } else {
    level._id_73BD = "halftime";
    game["switchedsides"] = !game["switchedsides"];
    level._id_EC31 = 1;
  }
}

_id_DB66() {
  return game["roundsWon"]["allies"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == scripts\mp\utility\dvars::getwatcheddvar("winlimit") - 1;
}

_id_3555(var_0) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(level._id_C949) || !level._id_C949) {
    return 0;
  }

  if(game["roundsPlayed"] % level._id_C949 == 0 || var_0) {
    return 1;
  }

  return 0;
}

_id_F286() {
  if(level.gameended) {
    var_0 = (gettime() - level._id_60BD) / 1000;
    var_1 = level._id_BA5A - var_0;

    if(var_1 < 0) {
      return 0;
    }

    return var_1;
  }

  if(scripts\mp\utility\game::_id_6DE5() <= 0) {
    return undefined;
  }

  if(!isDefined(level._id_E72D)) {
    return undefined;
  }

  if(scripts\mp\utility\game::_id_875D() && isDefined(level._id_1A87)) {
    return scripts\mp\gametypes\arena_evo_tourney_util::_id_64B9() - level._id_1A87;
  }

  var_2 = scripts\mp\utility\game::_id_6DE5();
  var_0 = (gettime() - level._id_E72D) / 1000;
  var_1 = level._id_4B0D / 1000 + scripts\mp\utility\game::_id_6DE5() - var_0;

  if(isDefined(level._id_F23C)) {
    var_1 = var_1 + level._id_F23C;
  }

  return var_1 + level._id_BA5A;
}

_id_5F53() {
  if(isDefined(self._id_AFCF)) {
    if(isDefined(self._id_AFCF[0])) {
      self._id_AFCF[0] scripts\mp\hud_util::destroyelem();
      self._id_AFD3[0] scripts\mp\hud_util::destroyelem();
    }

    if(isDefined(self._id_AFCF[1])) {
      self._id_AFCF[1] scripts\mp\hud_util::destroyelem();
      self._id_AFD3[1] scripts\mp\hud_util::destroyelem();
    }

    if(isDefined(self._id_AFCF[2])) {
      self._id_AFCF[2] scripts\mp\hud_util::destroyelem();
      self._id_AFD3[2] scripts\mp\hud_util::destroyelem();
    }
  }

  self notify("perks_hidden");

  if(!level._id_4C6F) {
    self._id_98C4 scripts\mp\hud_util::destroyelem();
    self._id_98CB scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self._id_BDC5)) {
    self._id_BDC5 scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self._id_BDC6)) {
    self._id_BDC6 scripts\mp\hud_util::destroyelem();
  }
}

_id_6AA7() {
  var_0 = getEntArray("player", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] ishost()) {
      return var_0[var_1];
    }
  }
}

_id_7AA3() {
  var_0 = _id_6AA7();

  if(isDefined(var_0) && !var_0._id_75B4 && !isDefined(var_0._id_D05C)) {
    return 1;
  }

  return 0;
}

_id_C942(var_0, var_1) {
  if(!level._id_4C6F) {
    wait(level._id_BA4A + 0.1);
    _func_01EA("post_game_state", 2);
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    var_4 thread scripts\mp\utility\game::_id_D73A(0.0);

    if(var_4 _meth_81D3()) {
      var_2 = 2;
    }
  }

  if(!var_1) {
    wait(var_0);
  } else {
    wait(var_0 / 2);
    level notify("give_match_bonus");
    wait(var_0 / 2);
  }

  wait(var_2);
  _func_01EA("post_game_state", 1);
  level notify("round_end_finished");
}

_id_C93F(var_0) {
  scripts\mp\utility\player::_id_D52A();
}

_id_D8E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level._id_10CCD[var_0] = var_2;
  level._id_10CCC[var_0] = var_1;
  level._id_10CD9[var_0] = var_3;
  level._id_10CD8[var_0] = var_4;
  level._id_10CD1[var_0] = var_5;
  level.waypointshowfreecamlabel[var_0] = var_6;
}

setwaypointcodcasteroverride(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.codcasterwaypointcolors[var_0] = var_2;
  level.codcasterwaypointbgtype[var_0] = var_1;
  level.codcasterwaypointstring[var_0] = var_3;
  level.codcasterwaypointshader[var_0] = var_4;
  level.codcasterwaypointpulses[var_0] = var_5;
  level.codcasterwaypointshowfreecamlabel[var_0] = var_6;
}

_id_82B8() {
  var_0 = 0;

  switch (scripts\mp\utility\game::getgametype()) {
    case "trial":
    case "pill":
    case "mtmc":
    case "siege":
    case "dom":
    case "control":
    case "base":
    case "arm":
      _id_D8E5("icon_waypoint_dom_a", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("icon_waypoint_dom_b", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("icon_waypoint_dom_c", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("icon_waypoint_dom_d", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("icon_waypoint_dom_e", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("icon_waypoint_dom_f", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, 0);
      _id_D8E5("icon_waypoint_dom_g", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, 0);
      _id_D8E5("waypoint_taking_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1, 0);
      _id_D8E5("waypoint_taking_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1, 0);
      _id_D8E5("waypoint_taking_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1, 0);
      _id_D8E5("waypoint_taking_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1, 0);
      _id_D8E5("waypoint_taking_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1, 0);
      _id_D8E5("waypoint_taking_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_f", 1, 0);
      _id_D8E5("waypoint_taking_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_g", 1, 0);
      _id_D8E5("waypoint_capture_a", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_capture_b", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_capture_c", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("waypoint_capture_d", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("waypoint_capture_e", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("waypoint_capture_f", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, 0);
      _id_D8E5("waypoint_capture_g", var_0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, 0);
      _id_D8E5("waypoint_defend_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_defend_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_defend_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("waypoint_defend_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("waypoint_defend_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("waypoint_defend_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, 0);
      _id_D8E5("waypoint_defend_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0, 0);
      _id_D8E5("waypoint_defending_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_defending_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_defending_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("waypoint_defending_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("waypoint_defending_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("waypoint_defending_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_f", 0, 0);
      _id_D8E5("waypoint_defending_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_g", 0, 0);
      _id_D8E5("waypoint_blocking_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1, 0);
      _id_D8E5("waypoint_blocking_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1, 0);
      _id_D8E5("waypoint_blocking_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1, 0);
      _id_D8E5("waypoint_blocking_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1, 0);
      _id_D8E5("waypoint_blocking_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1, 0);
      _id_D8E5("waypoint_blocking_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_f", 1, 0);
      _id_D8E5("waypoint_blocking_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_g", 1, 0);
      _id_D8E5("waypoint_blocked_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1, 0);
      _id_D8E5("waypoint_blocked_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1, 0);
      _id_D8E5("waypoint_blocked_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1, 0);
      _id_D8E5("waypoint_blocked_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1, 0);
      _id_D8E5("waypoint_blocked_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1, 0);
      _id_D8E5("waypoint_blocked_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_f", 1, 0);
      _id_D8E5("waypoint_blocked_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_g", 1, 0);
      _id_D8E5("waypoint_losing_a", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1, 0);
      _id_D8E5("waypoint_losing_b", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1, 0);
      _id_D8E5("waypoint_losing_c", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1, 0);
      _id_D8E5("waypoint_losing_d", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1, 0);
      _id_D8E5("waypoint_losing_e", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1, 0);
      _id_D8E5("waypoint_losing_f", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_f", 1, 0);
      _id_D8E5("waypoint_losing_g", var_0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_g", 1, 0);
      _id_D8E5("waypoint_captureneutral_a", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_captureneutral_b", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_captureneutral_c", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("waypoint_captureneutral_d", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("waypoint_captureneutral_e", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("waypoint_captureneutral_f", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, 0);
      _id_D8E5("waypoint_captureneutral_g", var_0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, 0);
      _id_D8E5("waypoint_contested_a", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, 1);
      _id_D8E5("waypoint_contested_b", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1, 1);
      _id_D8E5("waypoint_contested_c", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1, 1);
      _id_D8E5("waypoint_contested_d", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1, 1);
      _id_D8E5("waypoint_contested_e", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1, 1);
      _id_D8E5("waypoint_contested_f", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_f", 1, 1);
      _id_D8E5("waypoint_contested_g", var_0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_g", 1, 1);
      _id_D8E5("waypoint_dom_target_a", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_dom_target_b", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_dom_target_c", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("waypoint_dom_target_d", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("waypoint_dom_target_e", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("waypoint_dom_target_f", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, 0);
      _id_D8E5("waypoint_dom_target_g", var_0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_g", 0, 0);
      break;
    case "dd":
    case "sd":
      _id_D8E5("waypoint_bomb", 2, "neutral", "MP_INGAME_ONLY/OBJ_BOMB_CAPS", "icon_waypoint_bomb", 1, 0);
      _id_D8E5("icon_waypoint_escort_bomb", 1, "neutral", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("codcaster_enemy_escort_bomb", 1, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_bomb_defusing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_TARGET_A_CAPS", "icon_waypoint_dom_a", 0, 1);
      _id_D8E5("waypoint_bomb_defusing_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_TARGET_B_CAPS", "icon_waypoint_dom_b", 0, 1);
      _id_D8E5("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_TARGET_A_CAPS", "icon_waypoint_dom_a", 0, 1);
      _id_D8E5("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_TARGET_B_CAPS", "icon_waypoint_dom_b", 0, 1);
      _id_D8E5("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 0);
      _id_D8E5("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 0);
      _id_D8E5("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 0);
      _id_D8E5("waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, 0);
      _id_D8E5("waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, 0);
      _id_D8E5("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_bomb", 0, 0);
      _id_D8E5("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_bomb", 0, 0);
      break;
    case "btm":
    case "hq":
      _id_D8E5("hq_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_DESTROY_CAPS", "icon_waypoint_hq", 0, 0);
      _id_D8E5("hq_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0, 0);
      _id_D8E5("hq_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0, 0);
      _id_D8E5("hq_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0, 0);
      _id_D8E5("hq_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0, 0);
      _id_D8E5("hq_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0, 0);
      _id_D8E5("hq_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 0);
      _id_D8E5("hq_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_hq", 0, 0);
    default:
      break;
  }

  _id_D8E5("waypoint_dogtags", 1, "enemy", "", "icon_minimap_dogtag", 0, 0);
  _id_D8E5("waypoint_dogtags_friendly", 1, "friendly", "", "icon_minimap_dogtag", 0, 0);
  _id_D8E5("icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, 0);
  _id_D8E5("waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, 0);
  _id_D8E5("waypoint_escort", 0, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0, 0);
}

initcodcasterwaypointoverrides() {
  var_0 = 0;

  switch (scripts\mp\utility\game::getgametype()) {
    case "trial":
    case "pill":
    case "mtmc":
    case "siege":
    case "dom":
    case "control":
    case "base":
    case "arm":
      setwaypointcodcasteroverride("waypoint_taking_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_a", 1, 0);
      setwaypointcodcasteroverride("waypoint_taking_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_b", 1, 0);
      setwaypointcodcasteroverride("waypoint_taking_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_c", 1, 0);
      setwaypointcodcasteroverride("waypoint_taking_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_d", 1, 0);
      setwaypointcodcasteroverride("waypoint_taking_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_e", 1, 0);
      setwaypointcodcasteroverride("waypoint_taking_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_f", 1, 0);
      setwaypointcodcasteroverride("waypoint_taking_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_g", 1, 0);
      setwaypointcodcasteroverride("waypoint_defending_a", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 0);
      setwaypointcodcasteroverride("waypoint_defending_b", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 0);
      setwaypointcodcasteroverride("waypoint_defending_c", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 0);
      setwaypointcodcasteroverride("waypoint_defending_d", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, 0);
      setwaypointcodcasteroverride("waypoint_defending_e", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, 0);
      setwaypointcodcasteroverride("waypoint_defending_f", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, 0);
      setwaypointcodcasteroverride("waypoint_defending_g", var_0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0, 0);
      break;
    case "kspoint":
    case "dd":
    case "sd":
      setwaypointcodcasteroverride("waypoint_defuse_nt_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0, 0);
      setwaypointcodcasteroverride("waypoint_defuse_nt_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0, 0);
      setwaypointcodcasteroverride("waypoint_bomb_defend_nt_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 0);
      setwaypointcodcasteroverride("waypoint_bomb_defend_nt_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 0);
      setwaypointcodcasteroverride("waypoint_bomb_defusing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0, 1);
      setwaypointcodcasteroverride("waypoint_bomb_defusing_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0, 1);
      setwaypointcodcasteroverride("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0, 1);
      setwaypointcodcasteroverride("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0, 1);
      break;
    case "koth":
      setwaypointcodcasteroverride("koth_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_koth", 0, 0);
      break;
    case "btm":
    case "hq":
    default:
      break;
  }
}

playagainsquad_requestreceived(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_3 = var_2 getentitynumber();
      var_4 = var_2;

      if(var_3 == var_0) {
        var_5 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "players");

        if(var_2 _meth_81E2() && !var_2 _meth_81E3()) {
          var_4 = var_2 _meth_81E4();
        }

        if(isDefined(var_4.playagainsquadconfirmed)) {
          var_4.playagainsquadconfirmed = !var_4.playagainsquadconfirmed;
        } else {
          var_4.playagainsquadconfirmed = 1;
        }

        var_6 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "playagainHostXuid");
        var_7 = var_4 getxuid();

        if(var_4.playagainsquadconfirmed) {
          if(var_6 == "0") {
            scripts\mp\utility\teams::_id_D70F(var_2.team, "playagainHostXuid", var_7);
          }
        } else if(var_6 == var_7) {
          var_8 = "0";

          foreach(var_10 in var_5) {
            if(isDefined(var_10) && !isbot(var_10) && var_10 _meth_81E3()) {
              var_8 = var_10 getxuid();
              break;
            }
          }

          scripts\mp\utility\teams::_id_D70F(var_2.team, "playagainHostXuid", var_8);
        }

        if(istrue(scripts\mp\utility\game::matchmakinggame())) {
          if(isDefined(var_2) && var_2 _meth_81BF()) {
            var_12 = var_2 _meth_8133();

            foreach(var_14 in var_12) {
              if(!isDefined(var_14)) {
                continue;
              }
              var_15 = var_14 getentitynumber();

              if(var_15 != var_3) {
                if(isDefined(var_14.playagainsquadconfirmed)) {
                  var_14.playagainsquadconfirmed = !var_14.playagainsquadconfirmed;
                } else {
                  var_14.playagainsquadconfirmed = 1;
                }

                foreach(var_10 in var_5) {
                  if(isDefined(var_10)) {}
                }
              }
            }
          }
        }

        break;
      }
    }
  }

  return;
}

handleplayagainsquadstate() {
  var_0 = 0;

  if(!scripts\mp\utility\game::privatematch() && !scripts\mp\gametypes\br_public::_id_878D()) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(isDefined(var_3.playagainsquadconfirmed) && var_3.playagainsquadconfirmed) {
        var_4 = var_3.team;
        var_5 = 0;
        var_6 = var_1.size;

        for(var_7 = 0; var_7 < var_6; var_7++) {
          if(var_1[var_7] == var_4) {
            var_5 = 1;
          }
        }

        if(!var_5) {
          var_1[var_6] = var_4;
          var_8 = scripts\mp\utility\teams::_id_6DCA(var_4, "players");
          var_9 = [];
          var_10 = scripts\mp\utility\teams::_id_6DCA(var_4, "playagainHostXuid");

          foreach(var_3 in var_8) {
            if(!isDefined(var_3)) {
              continue;
            }
            if(isDefined(var_3.playagainsquadconfirmed) && var_3.playagainsquadconfirmed) {
              var_9[var_9.size] = var_3;
            }
          }

          _func_0468(var_9, var_10);
          waitframe();
        }
      }
    }
  }
}

_id_2F3F() {
  _id_07EC::main();

  if(!isDefined(game["roundsPlayed"])) {
    if(_func_0391()) {
      _func_038E();
    }

    game["matchHasMoreThan1Player"] = 0;
    game["numPlayersConsideredPlaying"] = 0;
  }

  _id_07D1::_id_60C0("prematch_waitForPlayers_Complete", 0);
  _id_07D1::_id_60C0("prematch_done", 0);
  _id_07D1::_id_60C0("prematch_countdown", 0);
  _id_07D1::_id_60C0("graceperiod_done", 0);
  _id_07D1::_id_60C0("infil_setup_complete", 0);
  _id_07D1::_id_60C0("infil_will_run", 0);
  _id_07D1::_id_60C0("infil_started", 0);
  _id_07D1::_id_60C0("overtime_started", 0);
  _id_07D1::_id_9353("round_over", 0);
  _id_07D1::_id_9353("game_over", 0);
  _id_07D1::_id_9353("block_notifies", 0);
  _id_07D1::_id_9353("post_game_level_event_active", 0);
  _id_07D1::_id_9353("final_killcam_preloaded", 0);
  level._id_BBAD = 0;
  level._id_BBAE = 0;
  level._id_BA4B = 0;
  level._id_023E = 0;
  level.infil_light_count = 0;
  level.winner_light_count = 0;
  setDvar("#x3ca984a865792777", getdvarint("#x3a93070affbb9fe0d") == 1);
  setDvar("#x348ba174af8b81812", istrue(level._id_A6CA));
  setDvar("#x3929ceba4ee5247c4", istrue(level._id_1B5B));

  if(scripts\mp\utility\game::matchmakinggame()) {
    setDvar("#x3be5b00c5664516ea", 1);
  } else {
    setDvar("#x3be5b00c5664516ea", 0);
  }

  level thread _id_82B8();
  level thread initcodcasterwaypointoverrides();

  if(getdvarint("#x39533ac66feb2d0b1") == 1) {
    level thread scripts\mp\codcaster_utils::totalgametimelogic();
  }

  if(!isDefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;
    game["life_count"] = 0;

    if(!isDefined(game["attackers"]) || !isDefined(game["defenders"])) {
      thread scripts\engine\utility::_id_5598("No attackers or defenders team defined in level .gsc.");
    }

    if(!isDefined(game["attackers"])) {
      game["attackers"] = "allies";
    }

    if(!isDefined(game["defenders"])) {
      game["defenders"] = "axis";
    }

    if(!isDefined(game["state"])) {
      game["state"] = "playing";
    }

    game["strings"]["press_to_spawn"] = &"MP/PRESS_TO_SPAWN";
    game["strings"]["spawn_next_round"] = &"MP/SPAWN_NEXT_ROUND";
    game["strings"]["spawn_flag_wait"] = &"MP/SPAWN_FLAG_WAIT";
    game["strings"]["spawn_point_capture_wait"] = &"MP/SPAWN_POINT_CAPTURE_WAIT";
    game["strings"]["spawn_revive_wait"] = &"MP/SPAWN_REVIVE_WAIT";
    game["strings"]["spawn_revive_wait_bleedout"] = &"MP/SPAWN_REVIVE_WAIT_BLEEDOUT";
    game["strings"]["spawn_revive_remote"] = &"MP/SPAWN_REVIVE_REMOTE";
    game["strings"]["spawn_tag_wait"] = &"MP/SPAWN_TAG_WAIT";
    game["strings"]["waiting_to_spawn"] = &"MP/WAITING_TO_SPAWN";
    game["strings"]["next_team_spawn"] = &"MP/NEXT_TEAM_SPAWN";
    game["strings"]["match_starting"] = &"MP/MATCH_STARTING";
    game["strings"]["change_class"] = &"MP/CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["revive_class"] = &"MP/CHANGE_CLASS_NEXT_ROUND";
    game["strings"]["change_rig"] = &"LUA_MENU_MP/CHANGE_RIG_NEXT_SPAWN";
    game["strings"]["must_select_loadout_to_spawn"] = &"MP_INGAME_ONLY/SELECT_LOADOUT_TO_SPAWN";
    game["strings"]["select_spawn"] = &"MP/SELECT_SPAWN";
    game["strings"]["cowards_way"] = &"MP/COWARDS_WAY_OUT";
    game["colors"]["black"] = (0, 0, 0);
    game["colors"]["white"] = (1, 1, 1);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["colors"]["orange"] = (0.9, 0.6, 0);
    game["colors"]["blue"] = (0.2, 0.3, 0.7);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0);
    game["colors"]["friendly"] = (0.258824, 0.639216, 0.87451);
    game["colors"]["enemy"] = (0.929412, 0.231373, 0.141176);
    game["colors"]["contest"] = (1, 0.858824, 0);
    game["colors"]["neutral"] = (1, 1, 1);
    [[level._id_AB7F]]();
    setdvarifuninitialized("#x3e6000dca62024361", 5);

    if(level.gametype == "base") {
      level._id_BBAD = getdvarfloat("scr_base_prematch_countdown_delay", 12);
      level._id_BBAE = getdvarfloat("scr_base_prematch_countdown_time", 5.9);
    } else if(!level.splitscreen) {
      level._id_BBAD = scripts\mp\tweakables::_id_6E14("game", "graceperiod");
      level._id_BBAE = getdvarint("#x3d4e90ea01c7bc02a", 15);
    }

    if(_func_0474()) {
      _func_01E6(1, 1);
      _func_01E7(1, 1);
    } else {
      _func_01E6(0, 1);
      _func_01E7(0, 1);
    }
  } else {
    setdvarifuninitialized("#x3e6000dca62024361", 5);

    if(!level.splitscreen) {
      scripts\mp\tweakables::_id_6E14("game", "graceperiod");
      level._id_BBAE = getdvarint("#x334b1a553207e33a5", 5);
    }
  }

  if(!isDefined(game["allies"])) {
    game["allies"] = "SAS";
  }

  if(!isDefined(game["axis"])) {
    game["axis"] = "RUSF";
  }

  if(!isDefined(game["team_three"])) {
    game["team_three"] = "USMC";
  }

  if(!isDefined(game["team_four"])) {
    game["team_four"] = "SABF";
  }

  if(!isDefined(game["team_five"])) {
    game["team_five"] = "SAS";
  }

  if(!isDefined(game["team_six"])) {
    game["team_six"] = "RUSF";
  }

  if(!isDefined(game["team_seven"])) {
    game["team_seven"] = "SEVEN";
  }

  if(!isDefined(game["team_eight"])) {
    game["team_eight"] = "EIGHT";
  }

  if(!isDefined(game["team_nine"])) {
    game["team_nine"] = "NINE";
  }

  if(!isDefined(game["team_ten"])) {
    game["team_ten"] = "TEN";
  }

  if(!isDefined(game["team_eleven"])) {
    game["team_eleven"] = "ELEVEN";
  }

  if(!isDefined(game["status"])) {
    game["status"] = "normal";
  }

  setDvar("#x31da92e2adcc4dee0", scripts\mp\utility\game::_id_82D1());

  if(!isDefined(game["timePassed"])) {
    game["timePassed"] = 0;
  }

  if(!isDefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  if(!isDefined(game["overtimeRoundsPlayed"])) {
    game["overtimeRoundsPlayed"] = 0;
  }

  if(!isDefined(game["matchPoint"])) {
    game["matchPoint"] = 0;
  }

  if(!isDefined(game["finalRound"])) {
    game["finalRound"] = 0;
  }

  if(!isDefined(game["previousWinningTeam"])) {
    game["previousWinningTeam"] = "";
  }

  setomnvar("ui_last_round", game["finalRound"]);

  if(!isDefined(game["roundsWon"])) {
    game["roundsWon"] = [];
  }

  if(!isDefined(game["teamScores"])) {
    game["teamScores"] = [];
  }

  if(!isDefined(game["timeToBeat"])) {
    game["timeToBeat"] = 0;
  }

  if(!isDefined(game["timeToBeatOld"])) {
    game["timeToBeatOld"] = 0;
  }

  if(!isDefined(game["timeToBeatTeam"])) {
    game["timeToBeatTeam"] = "none";
  }

  if(!isDefined(game["timeToBeatScore"])) {
    game["timeToBeatScore"] = 0;
  }

  if(!isDefined(game["timeToBeatScoreOld"])) {
    game["timeToBeatScoreOld"] = 0;
  }

  level._id_41B8 = 0;
  level.gameended = 0;
  level._id_5E90 = 0;
  level._id_7AA2 = 0;
  level._id_74C4 = getdvarint("#x3af383f37c3a10748");
  setdvarifuninitialized("#x3d1c9984568884f80", 0);
  setdvarifuninitialized("#x39293fbc549331d5c", 0);
  level._id_F0E0 = getdvarint("#x3156ea3b0a79a48a0", 0) == 1;
  level._id_4ADA = scripts\mp\utility\game::isanymlgmatch();
  level._id_ED2B = scripts\mp\utility\game::matchmakinggame() && getdvarint("#x3cc2293bb5aa816bc") || getdvarint("#x3ced75240913bc3ea");

  if(level._id_ED2B) {
    setomnvar("ui_realism_mode", 1);
  }

  if(level._id_ED2B) {
    level._id_A00B = _id_07C3::_id_60D1;
    setDvar("#x3a608566925f9573", 1);
    setDvar("#x349bf326e8a9dfcf4", 0);
  }

  if(isDefined(level._id_5C41)) {
    setomnvar("ui_flag_neutralization_enabled", level._id_5C41);
  }

  if(level._id_74C4) {
    _func_0141("game mode: hardcore");
  }

  level._id_4986 = getdvarint("#x3e488386ae6284c8");
  level._id_3324 = getdvarint("#x3432a8e2d2ff30b5c");

  if(!isDefined(level._id_3E5B)) {
    level._id_3E5B = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_crankedBombTimer"), 0);
  }

  level._id_EB99 = scripts\engine\utility::ter_op(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_crankedBombTimer")) > 0, 1, 0);

  if(!level.teambased) {
    level._id_4986 = 0;
  }

  if(level._id_4986) {
    _func_0141("game mode: diehard");
  }

  level._id_9BEB = 0;
  level._id_9BF0 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_vampirism"), "#x3d6afcc65fe7f67aa");

  if(level._id_9BF0) {
    level._id_A00B = _id_07C3::_id_60D1;
  }

  level._id_5AA7 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_killcamType"), "#x3e91c2952f8ec8307");
  level._id_15BD = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_allowKillstreaks"), "#x3bb3287ee2dea8408");
  level._id_C945 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_roundRetainStreaks"), "#x3a060422731d492d0");
  level._id_C944 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_roundRetainStreakProg"), "#x35cd6d32694f09c77");
  level._id_43FA = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_deathRetainStreaks"), "#x39e858408459fd5be");
  level._id_15C7 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_allowPerks"), "#x33dc148863ff745de");
  level._id_15D8 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_allowSupers"), "#x3adbf3c9c82686879");
  level._id_EB26 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_superFastChargeRate"), "#x3d8cdb2888c027343");
  level._id_EB3C = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_superPointsMod"), "#x34b9531497edc4554");
  level._id_E357 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_spawnProtectionTimer"), "#x3cb9a97ad46da0c11");
  level._id_91E0 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_lethalDelay"), "#x3b87c0767505c186d");
  level._id_555F = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_equipmentMSProtect"), "#x3e417a96cc4b8ec0b") * 1000;
  level._id_992A = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_magcount"), "#x375eeee513fa18366");

  if(!isDefined(level._id_BB2E)) {
    level._id_BB2E = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_practiceRound"), "#x35750668b12ffaa37");
  }

  level._id_BA49 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_postGameExfil"), "#x3b079c8c024dfa5bc");
  level._id_5719 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_exfilActiveTimer"), "#x3cb457dcd5f272ca7");
  level._id_5720 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_exfilExtractTimer"), "#x3716709b4bc793392");
  level._id_FE23 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_useAmmoRestockLocs"), "#x3ed480f11f7331c7d");
  level._id_E3DF = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_allow3rdspectate"), "#x33c7832882e7f841f");
  setDvar("#x39c34f657c4899bdb", level._id_E3DF);
  level._id_0271 = scripts\mp\tweakables::_id_6E14("player", "laststand");
  setomnvar("ui_last_stand_type", level._id_0271);

  if(scripts\mp\utility\game::_id_8A95() || scripts\mp\utility\game::getgametype() == "br") {
    _id_081F::init();
  }

  if(scripts\mp\utility\game::_id_8A6F()) {
    _id_3510();
  }

  level._id_9F28 = (getdvarint("#x31109f5b6dd29a6e6") != 0 || getdvarint("#x38b0c8ef08acc0748") != 0) && !istrue(game["isLaunchChunk"]);
  var_0 = scripts\mp\utility\game::getgametype();
  level._id_BF11 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", var_0, "_radarHidePings"), "#x32f81e060e8d0db85");
  setomnvar("ui_compass_hide_weapon_pings_minimap", level._id_BF11);
  level._id_A3DF = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", var_0, "_navBarHidePings"), "#x3ead41b8a49a25c23");
  setomnvar("ui_compass_hide_weapon_pings_navbar", level._id_A3DF);
  level._id_A3DE = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", var_0, "_navBarHideEnemy"), "#x3c7468d1968d8d216");
  setomnvar("ui_compass_hide_enemy_navbar", level._id_A3DE);
  level._id_4AF0 = getdvarint("#x38a080e5753995a0e");
  level._id_4ACD = getdvarint("#x3284bff713458c19c");
  level._id_4A81 = getdvarint("#x389cb40ede8807023");
  level._id_4A7D = getdvarint("#x33467774880efa057");
  level._id_CC0E = [];
  level._id_CC0E["kill"] = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_pointsPerKill"));
  level._id_CC0E["death"] = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_pointsPerDeath"));
  level._id_CC0E["headshot"] = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_pointsHeadshotBonus"));
  level._id_CC0E["kskill"] = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_pointsPerKSKill"));

  if(level._id_BB2E && !isDefined(game["practiceRound"])) {
    game["practiceRound"] = 1;
    level._id_C945 = 0;
    level._id_C944 = 0;
    level.ignorescoring = 1;
    game["dialog"]["offense_obj"] = "gamestate_practice";
    game["dialog"]["defense_obj"] = "gamestate_practice";
  }

  if(getdvarint("#x3aa01b18116c1acef", 0) == 1) {
    game["attackers"] = "axis";
    game["defenders"] = "allies";
  }

  setomnvar("ui_match_timer_hidden", 1);

  if(scripts\cp_mp\utility\game_utility::_id_875F() && scripts\mp\utility\game::getgametype() != "infect") {
    level._id_15BD = 0;
    level._id_15D8 = 0;
    setomnvar("ui_disable_killstreaks", 1);
    setomnvar("ui_disable_fieldupgrades", 1);
  } else {
    setomnvar("ui_disable_killstreaks", 0);
    setomnvar("ui_disable_fieldupgrades", 0);
  }

  level._id_4A87 = 1;
  setomnvar("ui_killcam_copycat", 0);
  scripts\cp_mp\utility\game_utility::_id_6B18();
  level._id_9C75 = 5;
  level._id_9C74 = 32;
  level._id_FED4 = 1;
  level thread _id_0A21::_id_7E43();
  level thread scripts\mp\infilexfil\infil_s4::infil_s4_init();
  _id_0AA3::init();
  _id_0A9A::init();
  _id_0A8E::init();
  _id_0A9E::init();
  _id_078E::init();
  scripts\mp\playerlogic::init();
  scripts\cp_mp\utility\game_utility::_id_815E();
  level._id_9C50 = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_ffPunishLimit"), "#x3854c13f0df9853e8");
  level.maxallowedteamkillsbeforekick = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_ffKickKillLimit"), "#x3deb5cf65b24323dd");
  level.maxallowedteamdamagebeforepunish = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_ffPunishDamageLimit"), "#x3a9ab5b167ec6bae7");
  level.maxallowedteamdamagebeforekick = scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_ffKickDamageLimit"), "#x36ea560d0694e6a12");
  thread _id_07E4::init();
  thread scripts\mp\teams::init();
  _id_09C9::_id_EF5B();
  scripts\cp_mp\utility\player_utility::_id_8182();
  thread scripts\common\utility::_id_1549();
  thread _id_09C8::_id_D9D2();
  thread scripts\cp_mp\utility\game_utility::_id_60B4();
  thread scripts\mp\playeractions::init();
  thread scripts\mp\healthoverlay::init();
  thread _id_07E7::init();
  thread _id_07D0::_id_8191();
  thread _id_07BC::init();
  _id_0A8D::_id_829D();

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread scripts\mp\battlechatter_mp::init();
  } else if(!scripts\mp\utility\game::_id_CA4B()) {
    thread scripts\mp\battlechatter_mp::init();
  } else {
    level._id_237F = 0;
  }

  thread _id_07F8::init();
  thread scripts\mp\class::init();

  if(!scripts\mp\utility\game::_id_CA4B()) {
    thread scripts\mp\persistence::init();
  }

  thread scripts\mp\rank::init();
  thread _id_0801::init();
  thread _id_07F2::init();
  thread _id_07E1::init();
  thread _id_0813::init();
  thread scripts\mp\weapons::init();
  thread _id_07FB::init();
  thread _id_0814::init();
  thread _id_07C5::init();
  thread _id_07C4::init();
  thread _id_07EA::init();
  thread _id_07D6::init();
  thread _id_081A::init();
  thread _id_0817::init();

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread _id_07B6::init();
    thread _id_07B5::init();
  } else {
    thread _id_07EE::init();
    thread _id_07BE::init();
  }

  thread _id_07B1::init();
  thread scripts\mp\playerlogic::_id_8289();

  if(!scripts\mp\utility\game::_id_CA4B()) {
    _id_0A9E::_id_C29C(scripts\mp\playerlogic::_id_FC90);
  }

  _id_0A9E::_id_C29C(scripts\mp\weapons::_id_7165);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
    level _id_000F::_id_990C("play_again_squad_request", ::playagainsquad_requestreceived);
  }

  if(level.leagueplaymatch) {
    scripts\mp\leagueplay::init();
  }

  thread _id_07FD::init();
  thread scripts\mp\perks\perks::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread scripts\cp_mp\vehicles\vehicle::_id_100E0();
    thread _id_09B6::init();
    thread scripts\mp\perks\perks::_id_8297();
  }

  thread _id_07CE::init();
  thread _id_09F1::init();

  if(!scripts\mp\utility\game::_id_CA4B()) {
    thread _id_0827::init();
  }

  if(getdvarint("#x3656c342d5b028eb3", 0) == 1) {
    scripts\common\telemetry::init();
    _id_07A9::init();
    _id_0822::init();
    _id_0821::init();
  } else {
    thread scripts\common\telemetry::init();
    thread _id_07A9::init();
    thread _id_0822::init();
    thread _id_0821::init();
  }

  if(!istrue(game["isLaunchChunk"])) {
    thread _id_07ED::init();
    thread scripts\mp\supers::init();
    thread scripts\mp\supers::_id_10C09();
  }

  thread _id_07BA::init();
  thread _id_07B4::init();
  thread _id_1590();
  thread _id_893B();
  thread _id_0793::init();
  thread _id_07D8::_id_8007();
  thread _id_07A6::init();
  thread _id_0790::_id_56FD();
  thread _id_0812::init();
  thread _id_07F9::init();
  thread _id_07AD::_id_8138();
  thread _id_080D::_id_C9BA();

  if(!istrue(game["isLaunchChunk"])) {
    thread _id_0823::init();
  }

  thread _id_07E8::init();
  thread scripts\mp\equipment::init();
  thread _id_07F1::init();
  thread _id_0803::init();

  if(!istrue(game["isLaunchChunk"])) {
    thread _id_0789::init();
    thread scripts\mp\outofbounds::_id_824A();
    thread _id_079B::init();
  }

  thread _id_0805::init();
  thread _id_0AA6::_id_F63B();
  thread _id_078F::init();
  thread _id_07EF::_id_7FEF();

  if(!istrue(game["isLaunchChunk"])) {
    thread _id_0819::init();
    thread _id_0815::init();
    thread _id_07E6::init();
    thread _id_07CA::_id_4DDD();
    thread _id_07D2::init();
    thread _id_078D::_id_5181();
  }

  if(!istrue(game["isLaunchChunk"])) {
    if(istrue(level._id_BA49) || istrue(level._id_FE6B)) {
      thread scripts\mp\gametypes\exfil::_id_5724();
    }
  }

  if(getdvarint("#x3c0c45396a0966888", 0) && getdvarint("#x36c05a3ff3ee5fdd8", 0)) {
    thread _id_07C7::remove_destructible_walls();
  }

  thread scripts\mp\hud_message::init();
  level._id_15CE = getdvarint("#x3d0ea3eb869e01e13", 0);
  scripts\mp\playeractions::_id_C23B("reviveShoot", ["weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload"]);
  scripts\mp\playeractions::_id_C23B("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "crouch", "prone", "melee"]);
  thread _id_07A7::init();
  thread _id_07A8::init();
  thread _id_07DF::init();
  scripts\common\utility::_id_151E("equipment", scripts\mp\equipment::allow_equipment);
  scripts\common\utility::_id_151E("gesture", scripts\mp\utility\player::_id_1543);
  scripts\common\utility::_id_151E("supers", scripts\common\utility::_id_1587);
  scripts\common\utility::_id_151E("health_regen", scripts\mp\utility\player::_id_1546);
  scripts\common\utility::_id_151E("one_hit_melee_victim", scripts\mp\utility\player::_id_1563);
  scripts\common\utility::_id_151E("flashed", scripts\mp\utility\player::_id_153F);
  scripts\common\utility::_id_151E("stunned", scripts\mp\utility\player::_id_1585);
  scripts\common\utility::_id_151E("stick_kill", scripts\mp\utility\player::_id_1584);

  if(level.teambased) {
    foreach(var_2 in level._id_EF89) {
      if(!isDefined(game["roundsWon"][var_2])) {
        game["roundsWon"][var_2] = 0;
      }

      if(!isDefined(game["teamScores"][var_2])) {
        game["teamScores"][var_2] = 0;
      }
    }
  }

  if(game["status"] != "overtime" && game["status"] != "halftime") {
    if(!(game["roundsPlayed"] > 0 && scripts\mp\utility\game::_id_8935())) {
      game["teamScores"]["allies"] = 0;
      game["teamScores"]["axis"] = 0;
    }
  }

  setomnvar("ui_in_overtime_round", game["status"] == "overtime");
  game["gamestarted"] = 1;
  level._id_41EA = game["roundsPlayed"] + 1;
  level._id_9C91 = 0;
  level._id_0F55 = [];

  foreach(var_5 in level._id_EF89) {
    level._id_10CB5[var_5] = 0;
    level._id_90C5[var_5] = 0;
    level._id_10CB6[var_5] = 0;
    level._id_145F[var_5] = [];

    if(!istrue(level._id_C587)) {
      level._id_C586[var_5] = 0;
    }
  }

  setomnvar("ui_scorelimit", 0);
  setDvar("#x3d66aa88265dae2e0", 1);

  if(!istrue(game["isLaunchChunk"])) {
    setomnvar("ui_round_hint_override_attackers", 0);
    setomnvar("ui_round_hint_override_defenders", 0);
  }

  if(scripts\mp\utility\game::_id_6A65()) {
    setDvar("#x37c9b9af716ef3c26", 0);
  } else {
    setDvar("#x37c9b9af716ef3c26", 1);
  }

  _id_FD85();
  level._id_7116 = 15;
  level._id_7EB0 = level._id_7116;

  if(!isDefined(level._id_C93E)) {
    level._id_C93E = 6;
  }

  level._id_B8A9 = 0;
  level._id_5AA9 = 3;
  level._id_73BC = 3;
  level._id_BA4A = 0.25;
  level._id_CC09 = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");
  level._id_C943 = scripts\mp\utility\dvars::getwatcheddvar("roundlimit");
  level._id_10E52 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

  if(isDefined(level._id_CC0A) && level._id_CC09 > 0) {
    var_7 = [[level._id_CC0A]](level._id_CC09);

    if(isDefined(var_7)) {
      level._id_CC09 = var_7;
      setDvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_scorelimit"), var_7);
      setomnvar("ui_intensity_score_limit", var_7);
    }
  }

  if(istrue(game["isLaunchChunk"])) {
    setomnvar("ui_current_round", level._id_41EA);
  } else if(level._id_C943 != 1) {
    setomnvar("ui_current_round", level._id_41EA);
  }

  if(level._id_CC09 == 1) {
    level._id_C948 = 1;
    level._id_F380 = level._id_10E52;
  } else {
    level._id_C948 = level._id_CC09 * (game["roundsPlayed"] + 1);
    level._id_F380 = level._id_CC09 * level._id_C943;
  }

  if(scripts\mp\utility\game::_id_C63F()) {
    level._id_C948 = level._id_CC09;
    level._id_F380 = level._id_CC09;
    game["teamScores"][game["attackers"]] = 0;
    _func_01F8(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    _func_01F8(game["defenders"], 0);
  }

  if(scripts\mp\utility\game::_id_896C() && scripts\mp\utility\game::_id_82D1()) {
    scripts\mp\gamescore::_id_FCE3();
  }

  if(level.teambased) {
    foreach(var_5 in level._id_EF89) {
      scripts\mp\gamescore::_id_FD5B(var_5);
    }
  }

  thread _id_FD76();
  level notify("update_scorelimit");

  if(isDefined(level._id_9BD7)) {
    level thread[[level._id_9BD7]]();
  }

  if(getdvarint("#x3ee742089549ed784", 0) == 0) {
    setomnvar("ui_only_default_loadouts", 1);
  }

  [[level._id_ABAD]]();
  setattackingteam();
  level thread scripts\mp\gametypes\common::_id_AB5C();
  _id_0A8E::_id_C285(scripts\mp\gametypes\common::_id_AB64);
  level._id_CC10 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_score_percentage_cut_off"), 70);
  level._id_F23F = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_time_percentage_cut_off"), 70);

  if(getDvar("#x38ce255fac6663f1d") == "dedicated LAN server" || getDvar("#x38ce255fac6663f1d") == "dedicated internet server") {
    thread verifydedicatedconfiguration();
  }

  scripts\mp\codcaster_utils::esportshandletimeout(0, 0);
  thread _id_E6B1();
  level thread scripts\mp\utility\dvars::_id_FD83();

  if(!istrue(level._id_8A88)) {
    level thread _id_F21B();
  }

  level thread _id_FCA5();
  level thread scripts\mp\playerlogic::_id_FD07();
  level thread scripts\mp\playerlogic::_id_FC50();
  level thread _id_C4FC();

  if(scripts\mp\utility\game::_id_885C()) {
    level thread callbackserverstart();
  }
}

callbackserverstart() {
  if(getdvarint("#x37e47a9fed6331575", 0) > 0) {
    level waittill("telemetry_init");
  }

  _id_06E2::_id_4C2A("callback_server_start");
}

_id_FD85(var_0, var_1) {
  if(isDefined(var_0)) {
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay"), var_0);
  }

  if(isDefined(var_1)) {
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay_alt"), var_1);
  }

  var_2 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay"));
  var_3 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay_alt"));

  if(var_2) {
    foreach(var_5 in level._id_EF89) {
      level._id_10CB5[var_5] = var_2;
      level._id_90C5[var_5] = 0;
    }

    level thread _id_10CBA();
  }
}

verifydedicatedconfiguration() {
  for(;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint("#x310c28bb5d64c8c6d")) {
      exitlevel(0);
    }

    if(getDvar("#x38ce255fac6663f1d") != "dedicated LAN server" && getDvar("#x38ce255fac6663f1d") != "dedicated internet server") {
      exitlevel(0);
    }

    wait 5;
  }
}

_id_F21B() {
  level endon("game_ended");
  var_0 = scripts\mp\utility\game::_id_6DE6();

  while(game["state"] == "playing") {
    waittillframeend;
    thread _id_3568(var_0);
    var_0 = scripts\mp\utility\game::_id_6DE6();

    if(isDefined(level._id_E72D)) {
      if(_id_6DE8() < 3000 || istrue(level._id_5EB6)) {
        waitframe();
        continue;
      }
    }

    wait 1;
  }
}

_id_FD76() {
  for(;;) {
    level scripts\engine\utility::_id_108C5("update_scorelimit", "update_winlimit");

    if(scripts\mp\utility\game::_id_82D1() || scripts\mp\utility\game::_id_8424()) {
      if(scripts\mp\utility\game::_id_8AA1()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::_id_8AA2(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::_id_8A16()) {
        foreach(var_1 in level.players) {
          var_1 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_1.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_1 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_1.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility\game::_id_8AA2(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility\game::_id_8B13()) {
        var_5 = game["roundsWon"][game["defenders"]];
        var_6 = game["roundsWon"][game["attackers"]];
        var_7 = 0;

        if(var_5 == var_6) {
          var_7 = var_5 + 2;
        } else if(var_5 > var_6) {
          var_7 = var_5 + 1;
        } else {
          var_7 = var_6 + 1;
        }

        setomnvar("ui_scorelimit", var_7);
      } else
        _id_FE8F();

      continue;
    }

    _id_FE8F();
  }
}

_id_FE8F() {
  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::_id_8957() || scripts\mp\utility\game::_id_8935()) {
    setomnvar("ui_scorelimit", level._id_F380);
    thread _id_3557();
  } else
    setomnvar("ui_scorelimit", level._id_10E52);
}

_id_B901() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_0 = level._id_2682;

  for(;;) {
    self playSound("ui_mp_suitcasebomb_timer");

    if(var_0 > 5) {
      var_0 = var_0 - 1;
      wait 1;
    } else {
      var_0 = var_0 - 0.5;
      wait 0.5;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_E943() {
  self notify("stop_ticking");
}

_id_6966(var_0) {
  if(var_0 > 20) {
    return "ui_mp_timer_countdown";
  } else if(var_0 > 10) {
    return "ui_mp_timer_countdown_10";
  } else if(var_0 > 5) {
    return "ui_mp_timer_countdown_half_sec";
  } else if(var_0 > 1.5) {
    return "ui_mp_timer_countdown_quarter_sec";
  } else {
    return "ui_mp_timer_countdown_1";
  }
}

_id_F217() {
  level endon("cancel_announcer_dialog");
  waitframe();

  if(scripts\mp\utility\game::_id_6DE5() == 0) {
    return;
  }
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 hide();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);

  while(game["state"] == "playing") {
    if(!level._id_F262 && scripts\mp\utility\game::_id_6DE5() && !istrue(level._id_267E)) {
      var_5 = _id_6DE8() / 1000;
      var_6 = int(var_5 + 0.5);
      var_7 = 0;

      if(var_4 == 2 && var_6 % 2 == 1) {
        var_7 = 1;
      }

      if(!var_1 && (var_7 == 1 && var_6 == 61 || var_7 == 0 && var_6 == 60)) {
        level _id_07F8::_id_9BC2("timesup_sixty");

        if(!scripts\mp\utility\game::gametypestopsclock()) {
          level notify("match_ending_soon", "time");
        }

        var_1 = 1;
      } else if(!var_2 && (var_7 == 1 && var_6 == 31 || var_7 == 0 && var_6 == 30)) {
        level _id_07F8::_id_9BC2("timesup_thirty");
        var_3 = level _id_07F8::_id_9BC2("timesup");
        level notify("match_ending_soon", "time");
        var_2 = 1;
      } else if(!var_1 && !var_2 && !var_3 && (var_6 >= 30 && var_6 <= 45)) {
        var_3 = level _id_07F8::_id_9BC2("timesup");

        if(!scripts\mp\utility\game::gametypestopsclock()) {
          level notify("match_ending_soon", "time");
        }
      }

      if(var_6 <= 10 || var_6 <= 30 && var_6 % var_4 == var_7) {
        if(!var_3 && var_6 <= 10) {
          var_3 = level _id_07F8::_id_9BC2("timesup", var_6);
        }

        level notify("match_ending_very_soon");
        var_8 = 1;

        if(var_6 == 0) {
          break;
        }

        if(isDefined(level._id_AD61) && level._id_AD61 < var_6) {
          var_8 = 0;
        }

        if(var_8) {
          var_9 = _id_6966(var_5);
        }
      }

      if(var_5 - floor(var_5) >= 0.05) {
        wait(var_5 - floor(var_5));
        continue;
      }
    }

    wait 1.0;
  }
}

_id_DB85() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "arena_evo":
    case "arena":
    case "cyber":
    case "sd":
      return 0;
    default:
      return 1;
  }
}

_id_60ED() {
  level endon("game_ended");

  if(isDefined(game["startTimeFromMatchStart"])) {
    level._id_E72F = game["startTimeFromMatchStart"];
  }

  level waittill("prematch_over");
  level._id_E72D = gettime();
  level._id_4B0D = 0;
  level._id_AD75 = 0;

  if(!isDefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level._id_E72F = gettime();
    _id_06E2::_id_4C2A("callback_match_start");
  }

  if(isDefined(game["roundMillisecondsAlreadyPassed"])) {
    level._id_E72D = level._id_E72D - game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundStartTimeSeconds", game["roundsPlayed"], _func_00D7());
  }

  _id_06E2::_id_4C2A("callback_round_start");

  if(_id_06E2::is_telemetry_callback_registered("callback_player_round_start")) {
    foreach(var_1 in level.players) {
      _id_06E2::_id_4C2A("callback_player_round_start", var_1);
    }
  }

  var_3 = gettime();

  while(game["state"] == "playing") {
    if(!level._id_F262) {
      game["timePassed"] = game["timePassed"] + (gettime() - var_3);
    }

    var_3 = gettime();
    wait 1.0;
  }
}

_id_FD65(var_0) {
  var_1 = level._id_F263 || isDefined(level._id_7AAE);

  if(!level._id_F262 && var_1) {
    level._id_F262 = 1;
    level._id_F25E = gettime();
    var_2 = _id_6DE8();

    if(isDefined(var_0)) {
      setgameendtime(var_0);
    } else {
      setgameendtime(gettime() + int(var_2));
    }

    setomnvar("ui_match_timer_stopped", 1);
  } else if(level._id_F262 && !var_1) {
    level._id_F262 = 0;
    level._id_4B0D = level._id_4B0D + (gettime() - level._id_F25E);
    var_2 = _id_6DE8();

    if(isDefined(var_0)) {
      setgameendtime(var_0);
    } else {
      setgameendtime(gettime() + int(var_2));
    }

    setomnvar("ui_match_timer_stopped", 0);
  }
}

pausetimer(var_0) {
  if(!level._id_F263) {
    level._id_F263 = 1;
    _id_FD65(var_0);
  }
}

resumetimer(var_0) {
  if(level._id_F263) {
    level._id_F263 = 0;
    _id_FD65(var_0);
  }
}

_id_E6B1() {
  _func_01F0(1, 1, 0);
  thread _id_60ED();
  level thread _id_60E2();
  level._id_F262 = 0;
  level._id_F263 = 0;
  setomnvar("ui_prematch_period", 1);
  _id_BBAD();
  _func_02A0("Ready for Compass");
  thread _id_07A9::_id_9784();

  foreach(var_1 in level.players) {
    var_1 _meth_8881();
  }

  _id_07D1::_id_60C1("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);
  _id_FD65();
  var_3 = scripts\mp\utility\game::_id_6DE5();

  if(var_3 > 0) {
    level thread _id_10872();
  } else {
    setomnvar("ui_match_timer_hidden", 1);
  }

  _id_3842();
  thread _id_F217();
  thread _id_7116();
  thread _id_07BC::_id_C939();

  if(getdvarint("#x3db5d3184a15d696d", 0) > 30) {
    setDvar("#x360e94616e8c18378", 1);
  }

  thread _id_07A9::_id_C142();
}

_id_60E2() {
  for(;;) {
    var_0 = scripts\engine\utility::_id_10899("prematch_over", "round_win", "round_end_finished", "game_ended");

    switch (var_0) {
      case "prematch_over":
      case "round_end_finished":
        _func_0444(1);
        break;
      case "round_win":
        _func_0444(0);
        break;
      case "game_ended":
        _func_0444(0);
        return;
    }
  }
}

_id_10872() {
  setomnvar("ui_match_timer_hidden", 1);
  wait 0.25;
  setomnvar("ui_match_timer_hidden", 0);
}

_id_3842() {
  var_0 = [];
  var_0[0] = getent("clip32x32x8", "targetname");
  var_0[1] = getent("clip32x32x128", "targetname");
  var_0[2] = getent("clip64x64x256", "targetname");
  var_0[3] = getent("clip32x32x32", "targetname");
  var_0[4] = getent("clip64x64x128", "targetname");
  var_0[5] = getent("clip64x64x64", "targetname");
  var_0[6] = getent("clip64x64x8", "targetname");
  var_0[7] = getent("clip128x128x256", "targetname");
  var_0[8] = getent("clip128x128x128", "targetname");
  var_0[9] = getent("clip128x128x8", "targetname");
  var_0[10] = getent("clip256x256x256", "targetname");
  var_0[11] = getent("clip256x256x128", "targetname");
  var_0[12] = getent("clip256x256x8", "targetname");
  var_0[13] = getent("clip512x512x8", "targetname");
  var_0[14] = getent("clip32x32x256", "targetname");
  var_0[15] = getent("player32x32x8", "targetname");
  var_0[16] = getent("player32x32x32", "targetname");
  var_0[17] = getent("player32x32x128", "targetname");
  var_0[18] = getent("player32x32x256", "targetname");
  var_0[19] = getent("player64x64x256", "targetname");
  var_0[20] = getent("player64x64x128", "targetname");
  var_0[21] = getent("player64x64x64", "targetname");
  var_0[22] = getent("player64x64x8", "targetname");
  var_0[23] = getent("player128x128x256", "targetname");
  var_0[24] = getent("player128x128x128", "targetname");
  var_0[25] = getent("player128x128x8", "targetname");
  var_0[26] = getent("player256x256x256", "targetname");
  var_0[27] = getent("player256x256x128", "targetname");
  var_0[28] = getent("player256x256x8", "targetname");
  var_0[29] = getent("player512x512x8", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_10CBA() {
  level endon("game_ended");
  level notify("waveSpawnTimer");
  level endon("waveSpawnTimer");

  if(isDefined(level._id_ED22)) {
    thread _id_10CBE();
  }

  while(game["state"] == "playing") {
    var_0 = gettime();

    foreach(var_2 in level._id_EF89) {
      if(var_0 - level._id_90C5[var_2] > level._id_10CB5[var_2] * 1000) {
        level notify("wave_respawn_" + var_2);
        level._id_90C5[var_2] = var_0;
        level._id_10CB6[var_2] = 0;
      }
    }

    waitframe();
  }
}

_id_10CBE() {
  level endon("waveSpawnTimer");

  for(;;) {
    scripts\engine\utility::waittill_any_2("wave_respawn_allies", "wave_respawn_axis");
    setomnvar("ui_hardpoint_timer", gettime() + 1000 * level._id_10CB5["allies"]);
  }
}

_id_691F() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level._id_EF89) {
    var_0[var_3] = 0;
    var_1[var_3] = 0;
  }

  foreach(var_6 in level.players) {
    var_7 = var_6.pers["team"];

    if(isDefined(var_7) && scripts\mp\utility\teams::_id_8878(var_7)) {
      var_0[var_7] = var_0[var_7] + var_6._id_0267;
      var_1[var_7] = var_1[var_7] + var_6._id_0157;
    }
  }

  var_9 = undefined;
  var_10 = undefined;
  var_11 = 0;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = 0;

  foreach(var_3 in level._id_EF89) {
    var_16 = var_0[var_3];

    if(!isDefined(var_9) || var_16 > var_9) {
      var_9 = var_16;
      var_10 = var_3;
      var_11 = 0;
    } else if(var_9 == var_16)
      var_11 = 1;

    var_17 = var_1[var_3];

    if(!isDefined(var_12) || var_17 < var_12) {
      var_12 = var_17;
      var_13 = var_3;
      var_14 = 0;
      continue;
    }

    if(var_12 == var_17) {
      var_14 = 1;
    }
  }

  if(!var_11) {
    return var_10;
  }

  if(!var_14) {
    return var_13;
  }

  var_19 = randomint(level._id_EF89.size);
  return level._id_EF89[var_19];
}

_id_C025(var_0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_D8F4();

    if(_id_7AA3()) {
      level._id_7AA2 = 1;
      _func_0141("host idled out");
      _func_0062();
    }

    _id_FCBB(var_0);
  }

  _id_FD93(var_0);
}

_id_4B7C(var_0, var_1, var_2) {
  if(!level._id_4C6F && scripts\mp\utility\game::_id_8935() && game["finalRound"] == 0) {
    var_0 = "roundend";
  }

  level._id_C940 = 0;

  if(!scripts\mp\utility\game::_id_10A16() && scripts\mp\utility\game::_id_875E() && !istrue(game["practiceRound"])) {
    if(_id_3555(level._id_B8A9)) {
      level._id_C940 = game["round_end_exmsg"]["switching_sides"];
    }
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::_id_EF8B(var_0, 1, var_1, var_2, level._id_C940);
      continue;
    }

    var_4 thread scripts\mp\hud_message::_id_ACA7(var_0, var_1, var_2);
  }
}

_id_4B78(var_0, var_1, var_2) {
  setomnvar("ui_match_over", 1);

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::_id_EF8B(var_0, 0, var_1, var_2);
      continue;
    }

    var_4 thread scripts\mp\hud_message::_id_ACA7(var_0, var_1, var_2);
  }
}

_id_4B7D() {
  level notify("spawning_intermission");

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\playerlogic::_id_E30E();
  }

  var_3 = level._id_73BD;

  if(var_3 == "halftime") {
    if(level._id_C943) {
      if(game["roundsPlayed"] * 2 == level._id_C943) {
        var_3 = "halftime";
      } else {
        var_3 = "intermission";
      }
    } else
      var_3 = "intermission";
  }

  level notify("round_switch", var_3);
  var_4 = 0;

  if(game["finalRound"] == 1) {
    var_3 = "final_round";
  } else if(game["matchPoint"] == 1) {
    var_3 = "match_point";

    if(scripts\mp\utility\game::_id_8B13() && game["roundsWon"]["allies"] == game["roundsWon"]["axis"]) {
      var_3 = "intermission";
    }
  }

  if(isDefined(level._id_EC31)) {
    var_4 = game["end_reason"]["switching_sides"];
    level._id_C940 = 0;

    if(var_3 != "final_round" && var_3 != "match_point") {
      var_3 = "switching_sides";
    }
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\hud_message::_id_EF8B(var_3, 1, var_4, var_4, level._id_C940);
  }

  _id_C942(level._id_73BC, 0);
}

_id_5F61(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(var_0 > 0 && var_3) {
    thread _id_DE0A(var_0);
  }

  thread _id_D0BE(var_0);

  foreach(var_5 in level.players) {
    var_5 enableplayerbreathsystem(0);
    var_5 thread _id_5F64(var_0);
    var_5 thread _id_C93F(4.0);
    var_5 thread scripts\mp\healthoverlay::_id_AADF(0);
    var_5 _id_5F53();
    var_5 _meth_82F6("#x3acf57c223df6ab1e", 1, "#x3e9de50fa971cd442", 0);

    if(isDefined(var_1) && isDefined(var_2)) {
      if(var_1 == "#x38bd4585c77e2050" && var_5 _meth_81E2()) {
        var_5 _meth_82F6(var_1, 0.75);
      }

      var_5 _meth_82F6(var_1, var_2);
    }
  }

  if(isDefined(level.agentarray)) {
    foreach(var_8 in level.agentarray) {
      var_8 scripts\mp\utility\player::_freezecontrols(1);
    }
  }
}

_id_5331(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
}

_id_DE0A(var_0) {
  _func_01F0(1.0, 0.4, var_0);
  _id_D53D();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  _func_01F0(1.0, 1, 0);
  _id_C641();
}

_id_D53D() {
  if(!isDefined(level._id_5344)) {
    _func_0428("end_of_round");
    level._id_5344 = 1;
    level._id_C5F5 = undefined;
  }
}

_id_C641() {
  if(!isDefined(level._id_C5F5)) {
    _func_0428("reset");
    level._id_5344 = undefined;
    level._id_A720 = undefined;
    level._id_C5F5 = 1;
  }
}

_id_D0BE(var_0) {
  wait(var_0);
  level notify("game_ended_frozen");
}

restart() {
  if(isDefined(level._id_AB37)) {
    [[level._id_AB37]]();
  }

  level notify("restarting");
  game["state"] = "playing";
  map_restart(1);
}

_id_52F7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_9FED)) {
    var_0 = level._id_9FED;
  }

  if(level.gametype == "base" && isDefined(level.base_ongameended)) {
    [[level.base_ongameended]]();
  }

  if(isDefined(level._id_52F7)) {
    [[level._id_52F7]](var_0, var_1);
  } else {
    _id_52FD(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_52FD(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(scripts\mp\utility\game::getgametype() != "br" && level.gameended) {
    return;
  }
  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], _func_00D7());
  }

  scripts\common\utility::_id_F73A(level._id_9BBC);
  level.updatecodcasterclientstatsinplayerkilledsharedlogiclate = 1;
  var_5 = 0;

  if(level._id_7AA2 || level._id_5E90) {
    var_5 = 1;
  }

  if(scripts\mp\utility\game::_id_82D1()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);
    }

    if(!var_5) {
      game["overtimeRoundsPlayed"]++;
    }
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::_id_8878(var_0)) {
      if(!var_5) {
        if(isDefined(var_4)) {
          game["roundsWon"][var_0] = game["roundsWon"][var_0] + var_4;
        } else {
          game["roundsWon"][var_0]++;
        }
      }

      if(!isDefined(level._id_5AA3)) {
        level._id_5AA3 = var_0;
      }
    } else {
      if(var_0 == "tie" && _id_DB86()) {
        foreach(var_7 in level._id_EF89) {
          game["roundsWon"][var_7]++;
        }
      }

      if(!isDefined(level._id_5AA3)) {
        level._id_5AA3 = "none";
      }
    }

    if(!istrue(game["practiceRound"])) {
      foreach(var_7 in level._id_EF89) {
        scripts\mp\gamescore::_id_FD5B(var_7);
      }

      if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] < 24 && scripts\mp\utility\game::getgametype() != "koth") {
        setmatchdata("alliesRoundScore", game["roundsPlayed"], _func_00DB("allies"));
        setmatchdata("axisRoundScore", game["roundsPlayed"], _func_00DB("axis"));
      }
    }
  } else {
    if(isDefined(var_0) && isPlayer(var_0) && !var_5) {
      game["roundsWon"][var_0.guid]++;
    }

    if(!isDefined(level._id_5AA3)) {
      if(_func_0121(var_0) && var_0 == "tie") {
        level._id_5AA3 = "none";
      } else {
        level._id_5AA3 = var_0.guid;
      }
    }
  }

  scripts\mp\gamescore::_id_FCF2();

  if(!var_5) {
    game["roundsPlayed"]++;
  }

  level._id_B8A9 = scripts\mp\utility\game::_id_DBA7();

  if(scripts\mp\utility\game::_id_A4CD()) {
    game["finalRound"] = 1;
  } else if(scripts\mp\utility\game::_id_A4CE()) {
    game["matchPoint"] = 1;
  }

  if(scripts\mp\utility\game::_id_10A16()) {
    var_0 = _id_352D(var_0);
  } else {
    foreach(var_12 in level.players) {
      var_12 notify("round_ended");
    }
  }

  level._id_411A = istrue(var_3) && scripts\mp\utility\game::getgametype() == "ctf";

  if(level._id_411A) {
    var_14 = scripts\engine\utility::ter_op(var_0 == "allies", "axis", "allies");
    game["roundsWon"][var_0] = 1;
    game["roundsWon"][var_14] = 0;
    game["teamScores"][var_0] = 1;
    game["teamScores"][var_14] = 0;
    _func_01F8(var_0, 1);
    _func_01F8(var_14, 0);
  }

  var_15 = _id_52FA(var_0, var_1, var_2, var_3);

  if(var_15 && scripts\mp\utility\game::_id_10A16()) {
    _id_52F9(var_0, var_1, var_2, var_3);
  }
}

_id_DB86() {
  return istrue(game["canScoreOnTie"]);
}

_id_352D(var_0) {
  var_1 = _id_DB86() && var_0 == "tie";
  var_2 = scripts\mp\utility\game::getgametype() == "ctf" && var_0 == "tie" && !level._id_10E61;

  if(var_1 || var_2) {
    scripts\mp\gamescore::_id_FD6B("axis");
    scripts\mp\gamescore::_id_FD6B("allies");
    var_3 = _func_00DB("allies");
    var_4 = _func_00DB("axis");

    if(var_3 != var_4) {
      var_0 = scripts\engine\utility::ter_op(var_3 > var_4, "allies", "axis");
    }
  }

  return var_0;
}

_id_52FE() {
  if(istrue(level._id_A731)) {
    return;
  }
  if(istrue(level._id_2B51)) {
    return;
  }
  _id_07D1::_id_9356("final_killcam_preloaded");

  if(level._id_5AA4) {
    var_0 = 0;

    if(isDefined(level._id_5AA3)) {
      var_0 = 1;

      if(isDefined(level._id_5AA6[level._id_5AA3])) {
        if(isDefined(level._id_5AA6[level._id_5AA3].attacker) && isPlayer(level._id_5AA6[level._id_5AA3].attacker)) {
          level.potgwinner = level._id_5AA6[level._id_5AA3].attacker;
        }
      }
    }

    if(var_0) {
      var_0 = level _id_07D0::_id_4CAC();
    }

    if(isDefined(var_0) && !var_0) {
      _id_BA59();
      return;
    }
  } else if(level._id_BA8B) {
    var_1 = _id_0805::_id_699D();

    if(isDefined(var_1._id_BCCE)) {
      level.potgwinner = var_1._id_BCCE;
      level _id_07D0::_id_4E67();
      return;
    }

    level._id_5AA4 = 1;
    var_0 = level _id_07D0::_id_4CAC();

    if(isDefined(var_0) && !var_0) {
      _id_BA59();
      return;
    }

    return;
  } else {}
}

_id_BA59() {
  if(_id_0828::_id_86DC()) {
    return;
  }
  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }
    var_1 thread scripts\mp\utility\game::_id_D73A(1.0, 0.1);

    if(scripts\mp\utility\game::_id_875E()) {
      var_1 setclientomnvar("post_game_state", 1);
    } else {
      var_1 setclientomnvar("post_game_state", 2);
    }

    var_1 thread _id_BB7C();
  }

  wait 0.5;
}

_id_BB7C() {
  self endon("disconnect");
  var_0 = scripts\mp\playerlogic::_id_6D6A();
  self _meth_8282(var_0.origin, 1);

  while(self.sessionstate != "intermission") {
    waitframe();
  }

  waitframe();
  self _meth_8283();
}

_id_D571(var_0) {
  game["state"] = "postgame";
  level notify("game_ended", var_0);
  _id_07D1::_id_9355("game_over");
  _id_07D1::_id_9355("block_notifies");
}

_id_52FB(var_0) {
  if(isDefined(var_0)) {
    if(var_0 == 1 || var_0 == 2) {
      level._id_0DC5 = 0;
      level._id_0C55 = var_0;
      level notify("madeLUIDecision");
    }
  }
}

_id_52FA(var_0, var_1, var_2, var_3) {
  level._id_60BD = gettime();
  level.gameended = 1;
  level._id_7EB0 = 0;
  level._id_4C6F = 0;

  if(getdvarint("#x33dcbd8a33f8919f1")) {
    if(scripts\mp\utility\game::_id_10A16() && !scripts\mp\utility\game::_id_875E()) {
      level._id_4C6F = 1;
    }
  }

  _id_FCA4();
  waitframe();
  scripts\mp\gamescore::_id_FCF2();
  level._id_C145 = 0;
  level.ignorescoring = 1;
  thread _id_0805::_id_AB92(var_0);

  if(_id_0828::_id_86DC()) {
    if(getdvarint("#x337dc1f218268a26", 1) == 1) {
      if(scripts\mp\utility\game::_id_10A16() || getdvarint("#x3b2b5cc3df72bc4b8", 1) == 0) {}
    }

    if(scripts\mp\utility\game::_id_10A16()) {
      _id_0828::set_additional_stream_pos();
    }
  }

  thread _id_07D0::_id_BB9B();
  level notify("cancel_announcer_dialog");

  if(scripts\mp\utility\game::_id_8A95()) {
    thread _id_081F::_id_389C();
  }

  if(scripts\mp\utility\game::_id_10A16()) {
    level notify("start_game_win_audio", var_0);

    if(istrue(level._id_BA49) && !level._id_5E90) {
      if(var_0 != "tie") {
        level thread scripts\mp\gametypes\exfil::_id_AAD8(var_0);
        level waittill("exfil_continue_game_end");
      }
    }
  }

  if(level._id_4C6F) {
    if(istrue(level._id_4C4D)) {
      thread _id_10807();
      _id_D571(var_0);
      level waittill("cmd_continue_game_end");
      _func_01EA("post_game_state", 2);

      foreach(var_5 in level.players) {
        if(level.teambased) {
          var_5 thread scripts\mp\hud_message::_id_EF8B(var_0, 0, var_1, var_2);
          continue;
        }

        var_5 thread scripts\mp\hud_message::_id_ACA7(var_0, var_1, var_2);
      }

      _id_5F61(3, "#x38bd4585c77e2050", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    } else if(level.gametype == "br") {
      thread _id_553C(var_0, var_1, var_2);
      game["state"] = "postgame";
      level notify("game_ended", var_0);
      _id_07D1::_id_9355("game_over");
      _id_07D1::_id_9355("block_notifies");
      waitframe();
    } else if(!(level.gametype == "tac_ops" && isDefined(level._id_ED22))) {
      thread _id_553C(var_0, var_1, var_2);
      _id_5F61(2.5, "#x38bd4585c77e2050", 1, 1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.5);
      _id_D571(var_0);
      waitframe();
    }

    foreach(var_5 in level.players) {
      var_5 setclientdvar("#x32add9cc9e0c920a1", 1);

      if(scripts\mp\utility\game::_id_10A1B() || scripts\mp\utility\game::_id_10A16()) {
        var_5 scripts\mp\killstreaks\killstreaks::_id_394F();
        var_5 _id_07B4::_id_B767();
      }

      var_5 setclientomnvar("ui_match_in_progress", 0);
    }
  } else {
    if(!(level.gametype == "tac_ops" && isDefined(level._id_ED22))) {
      thread _id_10807();
      _id_D571(var_0);
    }

    waitframe();

    foreach(var_5 in level.players) {
      var_5 setclientdvar("#x32add9cc9e0c920a1", 1);

      if((scripts\mp\utility\game::_id_10A1B() || scripts\mp\utility\game::_id_10A16()) && !istrue(game["isLaunchChunk"])) {
        var_5 scripts\mp\killstreaks\killstreaks::_id_394F();
        var_5 _id_07B4::_id_B767();
      }

      var_5 setclientomnvar("ui_match_in_progress", 0);
    }

    _id_5F61(1.0, "#x38bd4585c77e2050", 1, 0);
  }

  setgameendtime(0);
  thread _id_07A9::_id_9784();

  if(_id_07A9::_id_176F()) {
    _id_07A9::_id_1770();
  }

  var_11 = spawnStruct();
  var_11._id_52BF = var_1;
  var_11._id_10E53 = var_0;
  _id_06E2::_id_4C2A("callback_round_end", var_11);

  if(_id_06E2::is_telemetry_callback_registered("callback_player_round_end")) {
    foreach(var_5 in level.players) {
      var_11 = spawnStruct();
      var_11.player = var_5;
      _id_06E2::_id_4C2A("callback_player_round_end", var_11);
    }
  }

  _id_395B();

  if(isDefined(level._id_9BCE)) {
    [[level._id_9BCE]]();
  }

  _id_C025(var_0);
  setDvar("#x37c9b9af716ef3c26", 1);
  setDvar("#x3d66aa88265dae2e0", 0);
  setDvar("#x3ca984a865792777", 0);

  foreach(var_5 in level.players) {
    var_5 scripts\mp\class::_id_961E();
  }

  if(istrue(game["practiceRound"]) && !istrue(level._id_5E90)) {
    game["roundsPlayed"] = 0;

    foreach(var_17 in level._id_EF89) {
      game["roundsWon"][var_17] = 0;
      game["teamScores"][var_17] = 0;
    }

    var_0 = "tie";
    var_1 = game["end_reason"]["practice_round_over"];
  }

  _id_4B7C(var_0, var_1, var_2);
  level thread _id_5331(level._id_C93E - 1.0);

  if(!scripts\mp\utility\game::_id_10A16()) {
    level notify("round_win", var_0);
    _id_C942(level._id_C93E, 1);
  } else {
    var_11 = spawnStruct();
    var_11._id_10E53 = var_0;
    _id_06E2::_id_4C2A("callback_match_end", var_11);

    if(_id_06E2::is_telemetry_callback_registered("callback_player_match_end")) {
      foreach(var_5 in level.players) {
        var_11 = spawnStruct();
        var_11.player = var_5;
        _id_06E2::_id_4C2A("callback_player_match_end", var_11);
      }
    }

    _id_C942(level._id_C93E, 1);
  }

  level notify("game_cleanup");

  if(_id_0828::_id_86DC()) {
    _id_0828::_id_D80D(var_0);
  }

  _id_52FE();
  _func_01F0(1, 1, 0);
  _id_C641();

  if(istrue(game["practiceRound"]) && !istrue(level._id_5E90)) {
    game["practiceRound"] = 0;

    if(level._id_15D8 && !scripts\mp\utility\game::_id_CA4B()) {
      foreach(var_5 in level.players) {
        var_5 scripts\mp\supers::_id_3987();
        var_5 _id_0A6C::_id_AFE4();
      }
    }

    _id_07D1::_id_9352("block_notifies");
    restart();
    return 0;
  } else {
    if(level.teambased) {
      foreach(var_24 in level._id_EF89) {
        scripts\mp\gamescore::_id_FD6B(var_24);
      }
    }

    if(!scripts\mp\utility\game::_id_10A1B()) {
      if(!scripts\mp\utility\game::_id_10A16()) {
        if(level._id_B8A9) {
          var_0 = "overtime";
          game["status"] = "overtime";
        }

        _id_07D1::_id_9352("block_notifies");
        var_26 = _id_3555(level._id_B8A9);

        if(var_26) {
          _id_AB93(level._id_B8A9);
        }

        if(var_26 || game["finalRound"] == 1 || game["matchPoint"] == 1) {
          var_27 = 1;

          if(scripts\mp\utility\game::_id_875E()) {
            if(game["matchPoint"] == 1 && !istrue(game["displayedMatchPoint"])) {
              game["displayedMatchPoint"] = 1;
            } else if(game["finalRound"] != 1) {
              var_27 = 0;
            }
          }

          if(var_27) {
            _id_4B7D();
          }
        }

        foreach(var_5 in level.players) {
          var_5.pers["stats"] = var_5._id_E76F;

          if(isalive(var_5) && isDefined(var_5._id_9BC0)) {
            var_29 = spawnStruct();
            var_29._id_103C2 = var_5;
            var_29.attacker = undefined;
            var_29._id_9CD6 = "MOD_ROUND_ENDED";
            var_29._id_10D86 = "none";
            _id_06E2::_id_4C2A("callback_player_death", var_29);
          }
        }

        restart();
        return 0;
      }

      if(!level._id_5E90) {
        var_1 = _id_FD14(var_0);
      }
    }
  }

  return 1;
}

_id_ED1B(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!var_5 scripts\mp\hud_message::_id_8808()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  var_7 = 0;

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\utility\game::_id_D73A(0.0);

    if(var_5 _meth_81D3()) {
      var_7 = 2;
    }
  }

  wait(var_0 + var_7);
  _func_01EA("post_game_state", 1);
  level notify("round_end_finished");
}

_id_3AF6(var_0, var_1) {
  return var_0._id_038F >= var_1._id_038F;
}

_id_0DDA(var_0) {
  var_1 = self;
  var_1._id_75C4 = 1;
  var_1 notify("winners_circle_votes_submitted");
  var_1.endgame_modifiers["vote"] = 1;
}

_id_52F9(var_0, var_1, var_2, var_3) {
  _func_03C4();
  _func_01E6(1, 1);
  _func_01E7(1, 1);

  if(scripts\mp\gametypes\br_public::_id_878D() && !level._id_5E90) {
    level._id_0DC5 = 1;
    level _id_000F::_id_990C("exit_squad_eliminated", ::_id_52FB);
  }

  level _id_000F::_id_990C("winners_circle_votes_submitted", ::_id_0DDA);

  if(scripts\mp\utility\game::matchmakinggame() && isDefined(level._id_DB63) && [[level._id_DB63]]()) {
    _func_041F();
  }

  if(!istrue(level._id_BD69) && (istrue(level._id_5EFD) || level._id_5E90)) {
    _id_FD93(var_0);
  }

  _id_07BC::_id_C93C(var_0);
  _id_350E();
  _id_FD37();
  scripts\mp\persistence::_id_10FC2();
  level notify("stop_leaderboard_stats");
  _id_FCA4();
  _id_07A7::_id_566B();
  level._id_DCBB = _id_0828::_id_86DC() && scripts\mp\utility\game::_id_60F9();

  if(istrue(level._id_A737)) {
    level._id_DCBB = 0;
  }

  var_4 = [];

  if(level._id_DCBB) {
    foreach(var_6 in level._id_EF89) {
      var_7 = _id_07A7::_id_F342(var_6);
      var_4[var_6] = var_7.size > 0;

      if(var_4[var_6]) {
        if(var_7.size < _id_0828::get_num_winner_circle_spots()) {
          level._id_DCBB = 0;
          break;
        }

        _id_0828::_id_D841(var_6, var_7);
      }
    }

    if(level._id_DCBB) {
      _id_0828::preload_weapons("teamMVP");
    }
  }

  level._id_4CFA = _id_07B7::_id_8156(var_0);

  if(!level._id_4CFA) {
    level notify("spawning_intermission");

    foreach(var_10 in level.players) {
      if(!level._id_DCBB) {
        var_10 thread scripts\mp\utility\game::_id_D73A(0.0);
      }

      if(!isDefined(level._id_9FF0) || !var_10[[level._id_9FF0]]()) {
        var_10 thread scripts\mp\playerlogic::_id_E30E();
      }
    }
  }

  if(istrue(var_3) && !istrue(level._id_A72A)) {
    scripts\mp\utility\player::_id_0DC2(level._id_A748, 0);
    _func_0266("", 0.75);
  } else {
    scripts\mp\utility\player::_id_0DC2("", 0);
    _func_0266("", 0.75);
  }

  _id_4B78(var_0, var_1, var_2);
  _id_07D1::_id_9352("block_notifies");

  if(level.leagueplaymatch) {
    scripts\mp\leagueplay::match_end(var_0);
  }

  level._id_023E = 1;

  if(!level._id_4CFA && !level._id_DCBB) {
    if(scripts\mp\utility\game::_id_875D()) {} else if(scripts\mp\utility\game::getgametype() != "br") {
      _func_01EA("post_game_state", 5);
      _id_C942(level._id_BA5A, 1);
    } else {
      scripts\mp\gametypes\br_circle::_id_78F2();
      _func_01EA("ui_br_transition_type", 0);
      _func_01EA("post_game_state", 14);

      if(!scripts\mp\gametypes\br_public::_id_878D()) {
        if(getdvarint("#x32f5d0cb801f524cc") == 1) {
          wait 25;
        } else {
          wait 25;
        }
      } else {
        if(istrue(level._id_0DC5)) {
          level waittill("madeLUIDecision");
        }

        level._id_BA5A = 0;
      }

      _func_01EA("post_game_state", 5);
    }
  }

  handleplayagainsquadstate();
  _id_BD73();
  scripts\common\utility::_id_F73A(level._id_9BBD);

  if(level._id_DCBB) {
    foreach(var_10 in level.players) {
      if(var_10 _meth_81D3()) {
        var_10 setclientomnvar("post_game_state", 5);
      } else {
        var_10 setclientomnvar("post_game_state", 15);
      }

      var_10 thread scripts\mp\utility\game::_id_D73A(0.0, 0.5);
      var_10 _meth_8209(0, 0);
    }

    wait 3;
    level thread _id_0828::_id_CA1B();

    if(scripts\mp\utility\game::_id_875D()) {
      level._id_10E55 = var_0;
      _id_07A7::_id_A6AE(level._id_EF6A[var_0]["players"]);
    } else {
      _id_07A7::_id_A6AD();
      _id_07A7::_id_81ED();
    }

    foreach(var_10 in level.players) {
      var_6 = var_10.pers["team"];
      var_15 = !isDefined(var_6) || var_6 == "spectator" || var_6 == "follower" || var_10 _meth_81D3();

      if(var_15 || !scripts\mp\utility\game::_id_875D() && !var_4[var_6]) {
        var_10 setclientomnvar("post_game_state", 5);
        continue;
      }

      var_10 setclientomnvar("post_game_state", 16);
    }

    _id_0828::cleanup_additional_stream_pos();

    while(getdvarint("#x38c3ad70aa1cdb617", 0)) {
      waitframe();
    }

    var_17 = 0;

    foreach(var_10 in level.players) {
      if(isPlayer(var_10) && !isbot(var_10) && !var_10 _meth_81D3()) {
        var_10._id_75C4 = 0;
        var_10 thread _id_10838();
        var_17 = 1;
      }
    }

    if(var_17) {
      thread _id_10837();
      level waittill("winners_circle_all_players_voted");
    }

    _id_0828::cleanup_preloaded_weapons("teamMVP");
    var_20 = 0;

    foreach(var_10 in level.players) {
      var_10 _meth_8209(1.0, 0.0);

      if(var_10 _meth_81D3()) {
        var_20 = 2;
        var_10 setclientomnvar("post_game_state", 5);
        continue;
      }

      var_10 setclientomnvar("post_game_state", 17);
    }

    foreach(var_6 in level._id_EF89) {
      var_24 = -1;
      var_25 = -1;

      for(var_26 = 0; var_26 < level._id_10E5C[var_6].size; var_26++) {
        if(level._id_10E5C[var_6][var_26] > var_25) {
          var_25 = level._id_10E5C[var_6][var_26];
          var_24 = var_26;
        }
      }

      if(var_24 < 0) {
        continue;
      }
      var_27 = _id_07A7::_id_F342(var_6);

      if(var_27.size > 0) {
        var_27[var_24] thread scripts\mp\rank::giverankxp("accolade_mvp", scripts\mp\rank::getscoreinfovalue("accolade_mvp"));
        var_27[var_24].endgame_modifiers["voted_mvp"] = 1;
      }
    }

    wait(getdvarint("#x369d246d77d71dfb2", 4) + var_20);
    level notify("round_end_finished");
  } else if(level._id_4CFA) {
    _func_01EA("post_game_state", 7);
    wait 0.1;
    _id_07B7::_id_E684(var_0);
    level waittill("taunts_timed_out");
    _id_07B7::_id_52E3();
  }

  foreach(var_10 in level.players) {
    var_10 _id_07BC::createendgamechallengeevent(var_0);
  }

  if(level.teambased) {
    if(scripts\mp\utility\teams::_id_8878(var_0)) {
      setmatchdata("victor", var_0);
      var_7 = scripts\engine\utility::_id_1BD6(scripts\mp\utility\teams::_id_6DCA(var_0, "players"), ::_id_3AF6);
    } else {
      setmatchdata("victor", "none");
      var_7 = level._id_B16C["all"];
    }

    setmatchdata("alliesScore", _func_00DB("allies"));
    setmatchdata("axisScore", _func_00DB("axis"));
  } else {
    setmatchdata("victor", "none");
    var_7 = level._id_B16C["all"];
  }

  _func_0435();

  foreach(var_10 in level.players) {
    var_10 setplayerdata("common", "round", "endReasonTextIndex", var_1);
    var_10 scripts\cp_mp\utility\game_utility::_id_E912(var_0);

    if(isalive(var_10) && isDefined(var_10._id_9BC0)) {
      var_10 scripts\common\utility::_id_F73A(level._id_9BB7, var_10._id_9BC0, undefined, undefined, "MOD_GAME_ENDED", "none", undefined, undefined);
      var_32 = spawnStruct();
      var_32._id_103C2 = var_10;
      var_32.attacker = undefined;
      var_32._id_9CD6 = "MOD_GAME_ENDED";
      var_32._id_10D86 = "none";
      _id_06E2::_id_4C2A("callback_player_death", var_32);
    }

    var_33 = int(min(3, var_7.size));
    var_34 = 0;

    for(var_26 = 0; var_26 < var_33; var_26++) {
      if(var_10 == var_7[var_26]) {
        var_34 = 1;
      }
    }

    if(var_34) {
      var_10 _id_0798::_id_1187();
    }

    if(level.teambased) {
      if(scripts\mp\utility\teams::_id_8878(var_0)) {
        if(isDefined(var_10.team)) {
          if(var_10.team == var_0) {
            var_10 _id_0798::_id_1186();
            var_10.pers["match_outcome"] = "win";
          } else
            var_10.pers["match_outcome"] = "loss";
        }
      } else if(!isDefined(var_0) || isDefined(var_0) && _func_0121(var_0) && var_0 == "tie")
        var_10.pers["match_outcome"] = "tie";
    } else if(isPlayer(var_0)) {
      if(isDefined(level._id_902C)) {
        if(var_10 == level._id_B16C["all"][0]) {
          var_10 _id_0798::_id_1186();
          var_10.pers["match_outcome"] = "win";
        } else
          var_10.pers["match_outcome"] = "loss";
      } else if(var_34) {
        var_10 _id_0798::_id_1186();
        var_10.pers["match_outcome"] = "win";
      } else
        var_10.pers["match_outcome"] = "loss";
    } else if(!isDefined(var_0) || isDefined(var_0) && _func_0121(var_0) && var_0 == "tie")
      var_10.pers["match_outcome"] = "tie";

    var_10 scripts\common\utility::_id_F73A(level._id_9BB6);
  }

  _id_06E2::_id_4C2A("callback_server_end");

  if(_id_06E2::is_telemetry_callback_registered("callback_player_server_end")) {
    foreach(var_10 in level.players) {
      var_37 = spawnStruct();
      var_37.player = var_10;
      _id_06E2::_id_4C2A("callback_player_server_end", var_37);
    }
  }

  setmatchdata("host", level._id_7AB3);

  if(scripts\mp\utility\game::matchmakinggame()) {
    setmatchdata("playlistVersion", _func_00C6());
    setmatchdata("playlistID", _func_00C5());
    setmatchdata("isDedicated", isdedicatedserver());
    setmatchdata("party_maxplayers", getdvarint("#x3db5d3184a15d696d", 0));
  }

  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    if(isgamebattlematch()) {
      foreach(var_10 in level.players) {
        var_40 = var_10 getxuid();
        var_6 = var_10.team;
        var_41 = var_10 scripts\mp\utility\stats::_id_6C29("score");
        _func_041D(var_40, var_6, var_41);
      }

      var_43 = level.mapname;
      var_44 = scripts\mp\utility\game::getgametype();
      var_45 = _func_00AC("victor");
      var_46 = _func_00DB("allies");
      var_47 = _func_00DB("axis");
      var_48 = _id_07EE::_id_6B35();
      var_49 = _id_07EE::_id_6B31();
      _func_041E(var_43, var_44, var_45, var_46, var_47, var_48, var_49);
    }

    _func_03D8();
    _func_01CD();
  }

  foreach(var_10 in level.players) {
    var_10.pers["stats"] = var_10._id_E76F;
  }

  if(istrue(game["isLaunchChunk"])) {
    wait 1;
  } else if(!var_3 && !level._id_BA4B) {
    if(!scripts\mp\utility\game::_id_875D() && !level._id_4CFA && !level._id_DCBB) {
      if(!scripts\mp\utility\game::_id_10A1B()) {
        wait 6.0;
      } else {
        wait(min(5.0, 4.0 + level._id_BA4B));
      }
    }
  } else
    wait(min(10.0, 4.0 + level._id_BA4B));

  _id_D731(var_0);
  _func_01EA("post_game_state", 1);
  _id_07D1::_id_9357("post_game_level_event_active");

  if(istrue(game["isLaunchChunk"])) {
    _id_07D1::_id_9352("block_notifies");
    game["launchChunkWinner"] = 1;
    game["timePassed"] = 0;
    game["roundsPlayed"] = 0;
    game["overtimeRoundsPlayed"] = 0;
    game["matchPoint"] = 0;
    game["finalRound"] = 0;
    game["gamestarted"] = undefined;
    game["previousWinningTeam"] = "";

    foreach(var_6 in level._id_EF89) {
      game["roundsWon"][var_6] = 0;
      game["teamScores"][var_6] = 0;
      _func_01F8(var_6, int(0));
    }

    if(game["launchChunkRuleSet"] == 3) {
      scripts\mp\gametypes\arena_alt::_id_503B();
      wait 1;
    }

    if(!level._id_7AA2 && !level._id_5E90) {
      restart();
      return 0;
    }
  }

  level notify("exitLevel_called");

  if(scripts\mp\gametypes\br_public::_id_878D() && isDefined(level._id_0C55) && level._id_0C55 == 2) {
    scripts\mp\bots\bots::_id_4FE1(1, level.player.team);
    restart();
  } else
    exitlevel(0);
}

_id_10837() {
  level endon("winners_circle_all_players_voted");
  wait(getdvarint("#x3d156a5c0a062f949", 45));
  level notify("winners_circle_all_players_voted");
}

_id_10838() {
  var_0 = self;
  level endon("winners_circle_all_players_voted");

  if(!var_0 _meth_81D3()) {
    var_0 waittill("winners_circle_votes_submitted");
  }

  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(isPlayer(var_4) && !isbot(var_4) && !var_0 _meth_81D3()) {
      if(var_4._id_75C4) {
        var_1++;
      }

      var_2++;
    }
  }

  if(var_1 == var_2) {
    level notify("winners_circle_all_players_voted");
  }
}

_id_D731(var_0) {
  if(!level.teambased) {
    _func_0395(var_0);
    return;
  } else if(var_0 != "allies" && var_0 != "axis") {
    var_1 = scripts\mp\utility\teams::_id_6DCA("allies", "players");
    var_2 = scripts\mp\utility\teams::_id_6DCA("axis", "players");

    if(var_1.size == 0) {
      var_0 = "axis";
    } else if(var_2.size == 0) {
      var_0 = "allies";
    } else {
      var_0 = _id_691F();
    }
  }

  _func_0395(var_0);
}

_id_10807() {
  wait(level._id_BA4A);
  level notify("post_game_ui_start");
  _func_01EA("post_game_state", 1);
}

_id_553C(var_0, var_1, var_2) {
  wait(level._id_BA4A);
  level notify("post_game_ui_start");

  if(scripts\mp\utility\game::getgametype() != "br") {
    _func_01EA("post_game_state", 2);
  }

  foreach(var_4 in level.players) {
    if(level.teambased) {
      var_4 thread scripts\mp\hud_message::_id_EF8B(var_0, 0, var_1, var_2);
      continue;
    }

    var_4 thread scripts\mp\hud_message::_id_ACA7(var_0, var_1, var_2);
  }
}

_id_553B(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_2 scripts\common\utility::_id_151F(0);
    var_3 = var_2 getEye() + (0, 0, 100) + anglesToForward(var_2.angles) * -100;
    var_4 = spawn("script_model", var_3);
    var_4 setModel("tag_origin");
    var_4.angles = var_2.angles;
    var_2._id_E277 = var_4;
    var_5 = var_2 getEye();
    var_6 = var_2.angles;
    var_7 = var_3 + (0, 0, 5000);
    var_7 = var_7 + anglesToForward(var_6) * -100;
    var_2 cameralinkto(var_2._id_E277, "tag_origin", 1, 1);
    var_2._id_E277 moveto(var_7, 5.0, 4.0, 0.1);
    var_8 = vectornormalize(var_5 - var_4.origin);
    var_9 = scripts\mp\utility\script::_id_FFE3(var_8, (0, 0, 1));
    var_2._id_E277.angles = var_9;
    var_2 thread _id_97EF(var_6);
    wait 2.0;
  }
}

_id_97EF(var_0) {
  self endon("disconnect");
  self endon("lookAtPlayerUpdate_stop");

  for(;;) {
    var_1 = self getEye();
    var_2 = vectornormalize(var_1 - self._id_E277.origin);
    var_3 = scripts\mp\utility\script::_id_FFE3(var_2, (0, 0, 1));
    self._id_E277 rotateto(var_3, 0.75);
    waitframe();
  }
}

_id_FD14(var_0) {
  if(!level.teambased) {
    return 1;
  }

  if(scripts\mp\utility\game::_id_8935()) {
    if(scripts\mp\utility\game::_id_79B7()) {
      return game["end_reason"]["score_limit_reached"];
    }

    if(scripts\mp\utility\game::_id_79C1()) {
      return game["end_reason"]["time_limit_reached"];
    }
  } else if(scripts\mp\utility\game::_id_79B4())
    return game["end_reason"]["round_limit_reached"];

  if(scripts\mp\utility\game::_id_79C3()) {
    return game["end_reason"]["score_limit_reached"];
  }

  return game["end_reason"]["objective_completed"];
}

_id_5643(var_0) {
  if(!scripts\mp\utility\game::_id_8935()) {
    var_1 = _id_6D0F(var_0);
    var_2 = _id_6D11(var_0);
    var_3 = 999999;

    if(var_1) {
      var_3 = var_2 / var_1;
    }

    return var_3;
  } else {
    var_1 = _id_6D0F(var_0);
    var_2 = _id_6D0F(var_0);
    var_3 = 999999;

    if(var_1) {
      var_3 = var_2 / var_1;
    }

    return var_3;
  }
}

_id_39F9(var_0) {
  var_1 = 10;
  var_2 = 20;
  var_3 = level._id_C948;

  switch (scripts\mp\utility\game::getgametype()) {
    case "tdef":
    case "dom":
      var_2 = 20;
      break;
    case "conf":
      var_2 = 10;
    case "base":
    case "arm":
      var_2 = var_3 * 0.1;
      break;
    default:
      break;
  }

  var_4 = _func_00DB(var_0);
  var_5 = var_3 - var_4;

  if(var_5 <= scripts\engine\utility::ter_op(istrue(game["finalRound"]), var_2, var_1)) {
    return 1;
  }

  return 0;
}

_id_6D0F(var_0) {
  var_1 = undefined;

  if(scripts\mp\utility\game::gametypestopsclock()) {
    var_1 = scripts\mp\utility\game::gettimepassedwithpauses() / 60000 + 0.0001;
  } else {
    var_1 = scripts\mp\utility\game::_id_6DE6() / 60000 + 0.0001;
  }

  if(isPlayer(self)) {
    var_2 = self._id_038F / var_1;
  } else {
    var_2 = _func_00DB(var_0) / var_1;
  }

  return var_2;
}

_id_6D11(var_0) {
  var_1 = level._id_C948;

  if(isPlayer(self)) {
    var_2 = var_1 - self._id_038F;
  } else {
    var_2 = var_1 - _func_00DB(var_0);
  }

  return var_2;
}

_id_6D10(var_0) {
  var_1 = level._id_C948;

  if(!game["switchedsides"]) {
    var_1 = var_1 / 2;
    var_2 = scripts\mp\utility\game::_id_6DE6() / 60000 + 0.0001;
    var_3 = _func_00DB(var_0) / var_2;
  } else {
    var_1 = int(var_1 / 2);
    var_2 = scripts\mp\utility\game::_id_6DE6() / 60000 + 0.0001;
    var_4 = _func_00DB(var_0);

    if(var_4 >= var_1) {
      var_3 = (var_4 - var_1) / var_2;
    } else {
      return 0;
    }
  }

  return var_3;
}

_id_6FAE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_id_10968(3);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "inform_last_one");
  thread scripts\mp\hud_util::_id_EF8D("callout_lastteammemberalive", self, self.pers["team"]);

  foreach(var_1 in level._id_EF89) {
    if(self.pers["team"] != var_1) {
      thread scripts\mp\hud_util::_id_EF8D("callout_lastenemyalive", self, var_1);
    }
  }

  level notify("last_alive", self);
}

_id_BD73() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    _id_BD74(var_1);
  }

  if(getdvarint("#x36325d0d09e7e5310") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
      setclientmatchdata("isPublicMatch", 1);
    } else {
      setclientmatchdata("isPublicMatch", 0);
    }
  }

  _id_080E::_id_BD75();

  if(getdvarint("#x36325d0d09e7e5310") != 0) {
    _func_01CC();
  }
}

_id_BD74(var_0) {
  if(istrue(var_0._id_BD74)) {
    return;
  }
  var_0._id_BD74 = 1;

  if(!isDefined(var_0._id_39A2)) {
    var_0._id_39A2 = level._id_41B8;
    level._id_41B8++;
  }

  var_1 = var_0.name;

  if(getdvarint("#x36325d0d09e7e5310") != 0) {
    setclientmatchdata("players", var_0._id_39A2, "clanTag", var_0 _meth_8587());
    setclientmatchdata("players", var_0._id_39A2, "xuidHigh", var_0 _meth_8585());
    setclientmatchdata("players", var_0._id_39A2, "xuidLow", var_0 _meth_8586());
    setclientmatchdata("players", var_0._id_39A2, "isBot", isbot(var_0));
    setclientmatchdata("players", var_0._id_39A2, "uniqueClientId", var_0._id_399D);
    setclientmatchdata("players", var_0._id_39A2, "username", var_1);

    if(var_0 _meth_8687()) {
      setclientmatchdata("players", var_0._id_39A2, "platform", "ps4");
    } else if(var_0 _meth_868A()) {
      setclientmatchdata("players", var_0._id_39A2, "platform", "xb3");
    } else if(var_0 _meth_8685()) {
      setclientmatchdata("players", var_0._id_39A2, "platform", "bnet");
    } else {
      setclientmatchdata("players", var_0._id_39A2, "platform", "none");
    }
  }

  var_0 setplayerdata("common", "round", "clientMatchIndex", var_0._id_39A2);
  var_0 _id_080E::_id_D66F();
}

_id_F41A(var_0, var_1, var_2, var_3) {
  var_1 thread _id_F13D(var_2, 1, "deaths");
  var_1 thread _id_F13D(var_2, distancesquared(var_0.origin, var_1.origin), "cumulative_death_distance_sq");
}

_id_F3F2(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(var_3 != "MOD_FALLING") {
      if(var_3 == "MOD_MELEE" && issubstr(var_2, "tactical")) {
        var_0 scripts\common\utility::_id_F73A(level._id_9BB0, "tactical", "kills", 1, var_2);
        var_0 scripts\common\utility::_id_F73A(level._id_9BB0, "tactical", "hits", 1, var_2);
        var_0 scripts\mp\persistence::_id_7DEB("tactical", "kills", 1, var_2);
        var_0 scripts\mp\persistence::_id_7DEB("tactical", "hits", 1, var_2);
        return;
      }

      if(var_3 == "MOD_MELEE" && !_id_080B::_id_8A09(var_2) && !scripts\mp\utility\weapon::_id_8798(var_2)) {
        var_0 scripts\common\utility::_id_F73A(level._id_9BB0, "none", "kills", 1, var_2);
        var_0 scripts\common\utility::_id_F73A(level._id_9BB0, "none", "hits", 1, var_2);
        var_0 scripts\mp\persistence::_id_7DEB("none", "kills", 1, var_2);
        var_0 scripts\mp\persistence::_id_7DEB("none", "hits", 1, var_2);
        return;
      }

      var_0 thread _id_F13D(var_2, 1, "kills");
      var_0 thread _id_F13D(var_2, distancesquared(var_0.origin, var_1.origin), "cumulative_kill_distance_sq");
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      var_0 thread _id_F13D(var_2, 1, "headShots");
    }
  }
}

_id_D8EE(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }
  var_3 = undefined;

  if(isweapon(var_0)) {
    var_3 = var_0;
  } else {
    var_3 = makeweaponfromstring(var_0);
  }

  if(isDefined(var_3._id_AE61)) {
    var_3 = var_3._id_AE61;
  }

  if(scripts\mp\utility\weapon::_id_897E(var_3)) {
    return;
  }
  var_4 = var_3.basename;
  var_5 = scripts\mp\utility\weapon::getweapongroup(var_3);
  var_6 = _func_02F7(var_3);

  if(var_5 == "super") {
    var_7 = scripts\mp\supers::_id_DBFC(var_3);

    if(isDefined(var_7) && !var_7) {
      return;
    }
  }

  if(var_5 == "killstreak") {
    return;
  }
  if(scripts\mp\utility\weapon::_id_8834(var_3)) {
    return;
  }
  if(var_5 == "weapon_grenade" || var_5 == "weapon_explosive" || var_4 == "trophy_mp" || var_4 == "forcepush_mp") {
    var_4 = scripts\mp\utility\script::_id_EA63(var_4, "_mp");
    scripts\mp\persistence::_id_7DF5(var_4, var_2, var_1);
    var_8 = spawnStruct();
    var_8._id_04FE = var_4;
    var_8.statname = var_2;
    var_8.incvalue = var_1;
    var_8._id_04CC = var_6;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_8);
    return;
  }

  if(!isDefined(self._id_F40F)) {
    self._id_F40F = var_3;
  }

  if(var_3 != self._id_F40F) {
    scripts\mp\persistence::_id_FD88();
    self._id_F40F = var_3;
  }

  switch (var_2) {
    case "shots":
      self._id_F414++;
      break;
    case "hits":
      self._id_F412++;
      break;
    case "headShots":
      self._id_F411++;
      break;
    case "kills":
      self._id_F413++;
      break;
  }

  if(var_2 == "deaths") {
    var_9 = undefined;
    var_10 = scripts\mp\utility\weapon::getweaponrootname(var_3);

    if(!scripts\mp\utility\weapon::_id_879A(var_10) && !scripts\mp\utility\weapon::_id_879C(var_10)) {
      return;
    }
    var_11 = scripts\mp\utility\weapon::_id_6E69(var_3);
    scripts\mp\persistence::_id_7DF5(var_10, var_2, var_1);
    var_8 = spawnStruct();
    var_8._id_04FE = var_10;
    var_8.statname = "deaths";
    var_8.incvalue = var_1;
    var_8._id_04CC = var_6;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_8);

    foreach(var_13 in var_11) {
      scripts\mp\persistence::_id_7DEB(var_13, var_2, var_1, var_3);
      scripts\common\utility::_id_F73A(level._id_9BB0, var_13, var_2, var_1, var_3);
    }
  }
}

_id_D5B9(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 _id_D8EE(var_2, 1, "hits");
    return;
  }

  if(!isDefined(var_0._id_B656)) {
    var_0._id_B656 = [];
  }

  var_3 = 1;

  for(var_4 = 0; var_4 < var_0._id_B656.size; var_4++) {
    if(var_0._id_B656[var_4] == self) {
      var_3 = 0;
      break;
    }
  }

  if(var_3) {
    var_0._id_B656[var_0._id_B656.size] = self;
    var_1 _id_D8EE(var_2, 1, "hits");
  }
}

_id_F13D(var_0, var_1, var_2) {
  self endon("disconnect");
  waittillframeend;
  _id_D8EE(var_0, var_1, var_2);
}

_id_FD37() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = _id_6B34(var_1);
      var_3 = var_1 getplayerdata(level.progressiongroup, "globalSPM");
      var_4 = var_1 _id_0804::_id_6C64("matchStats", "gamesPlayed");
      var_3 = var_3 * (var_4 - 1);
      var_5 = var_2;

      if(var_4 > 0) {
        var_5 = (var_3 + var_2) / var_4;
      }

      var_1 setplayerdata(level.progressiongroup, "globalSPM", int(var_5));
      var_6 = _func_009E(scripts\mp\utility\game::getgametype());

      if(var_6 >= 0 && var_6 < level._id_9C74) {
        for(var_7 = 0; var_7 < 4; var_7++) {
          var_8 = var_1 getplayerdata(level.progressiongroup, "gameModeHistory", var_7 + 1);
          var_1 setplayerdata(level.progressiongroup, "gameModeHistory", var_7, var_8);
        }

        var_1 setplayerdata(level.progressiongroup, "gameModeHistory", 4, scripts\mp\utility\game::getgametype());
        var_9 = var_1 getplayerdata(level.progressiongroup, "gameModeScoreHistory", var_6, "index");
        var_1 setplayerdata(level.progressiongroup, "gameModeScoreHistory", var_6, "scores", var_9, int(var_2));
        var_9 = (var_9 + 1) % level._id_9C75;
        var_1 setplayerdata(level.progressiongroup, "gameModeScoreHistory", var_6, "index", var_9);
      }
    }
  }
}

_id_350E() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 = var_1 getplayerdata("common", "round", "kills");
      var_3 = var_1 getplayerdata("common", "round", "deaths");
      var_4 = var_1.pers["summary"]["xp"];
      var_5 = var_1 _id_0804::_id_6C64("bestStats", "killsInAMatch");
      var_6 = var_1 _id_0804::_id_6C64("bestStats", "deathsInAMatch");
      var_7 = var_1 _id_0804::_id_6C64("bestStats", "xpInAMatch");
      var_8 = var_1 getplayerdata(level.progressiongroup, "bestSPM", "score");
      var_9 = var_1 getplayerdata(level.progressiongroup, "bestKD", "score");

      if(var_2 > var_5) {
        var_1 _id_0804::_id_D672(var_2, "bestStats", "killsInAMatch");
      }

      if(var_4 > var_7) {
        var_1 _id_0804::_id_D672(var_4, "bestStats", "xpInAMatch");
      }

      if(var_3 > var_6) {
        var_1 _id_0804::_id_D672(var_3, "bestStats", "deathsInAMatch");
      }

      var_10 = var_2;

      if(var_3 > 1) {
        var_10 = var_10 / var_3;
      }

      var_10 = int(var_10 * 1000);

      if(var_10 > var_9) {
        var_1 setplayerdata(level.progressiongroup, "bestKD", "score", var_10);
        var_1 setplayerdata(level.progressiongroup, "bestKD", "time", _func_00D7());
      }

      var_11 = _id_6B34(var_1);

      if(var_11 > var_8) {
        var_1 setplayerdata(level.progressiongroup, "bestSPM", "score", int(var_11));
        var_1 setplayerdata(level.progressiongroup, "bestSPM", "time", _func_00D7());
      }

      var_1 _id_3503();
    }
  }
}

_id_15BF() {
  return level.onlinestatsenabled && _id_8906();
}

_id_FCA5() {
  level endon("game_ended");
  level endon("stop_leaderboard_stats");

  if(!_id_15BF()) {
    return;
  }
  var_0 = 0;

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
    }

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    var_1 = level.players[var_0];

    if(!isDefined(var_1) || isai(var_1)) {
      waitframe();
    } else {
      var_1 _id_FCFB();
      wait 0.1;
    }

    var_0++;
  }
}

_id_FCA4() {
  if(!_id_15BF()) {
    return;
  }
  foreach(var_1 in level.players) {
    if(!isDefined(var_1) || isai(var_1)) {
      continue;
    }
    var_1 _id_FCFB();
  }
}

_id_FCFA() {
  if(!_id_15BF()) {
    return;
  }
  if(!isDefined(self) || isai(self)) {
    return;
  }
  _id_FCFB();
}

_id_8906() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "cmd":
    case "grnd":
    case "grind":
    case "dm":
    case "war":
    case "hq":
    case "pill":
    case "gun":
    case "conf":
    case "koth":
    case "dd":
    case "ctf":
    case "arena_evo":
    case "arena":
    case "cyber":
    case "siege":
    case "sr":
    case "sd":
    case "dom":
    case "infect":
    case "control":
    case "base":
    case "br":
    case "patrol":
    case "arm":
      return 1;
    default:
      return 0;
  }

  return 0;
}

_id_FCFB() {
  var_0 = undefined;

  if(level._id_74C4) {
    var_0 = "hc_";
  } else {
    var_0 = "";
  }

  var_0 = var_0 + scripts\mp\utility\game::getgametype();

  if(isDefined(level._id_2BB5) && isDefined(level._id_2BB5.name)) {
    switch (level._id_2BB5.name) {
      case "sandbox":
      case "evac":
      case "extract":
      case "dmz":
        var_0 = var_0 + ("_" + level._id_2BB5.name);
        break;
      case "":
        break;
      default:
        return;
    }
  }

  var_1 = scripts\engine\utility::ter_op(level.teambased, self._id_038F, self._id_9134["gamemodeScore"]);
  _id_7DF2("score", var_0, var_1);
  var_2 = scripts\mp\persistence::_id_E761("round", "timePlayed", 0);
  _id_7DF2("timePlayed", var_0, var_2);
  _id_7DF2("kills", var_0, self._id_9134["kills"]);
  _id_7DF2("deaths", var_0, self._id_9134["deaths"]);

  switch (scripts\mp\utility\game::getgametype()) {
    case "war":
      _id_7DF2("assists", var_0, self._id_9134["assists"]);
      break;
    case "arena_evo":
    case "arena":
      _id_7DF2("damage", var_0, self._id_9134["damage"]);
      _id_7DF2("assists", var_0, self._id_9134["assists"]);
      break;
    case "base":
    case "arm":
      _id_7DF2("captures", var_0, self._id_9134["captures"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
    case "cyber":
      _id_7DF2("revives", var_0, self._id_9134["rescues"]);
      _id_7DF2("plants", var_0, self._id_9134["plants"]);
      break;
    case "dm":
      _id_FCA3("streak", var_0, self._id_9134["killChains"]);
      break;
    case "dom":
      _id_7DF2("captures", var_0, self._id_9134["captures"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
    case "sd":
      _id_7DF2("plants", var_0, self._id_9134["plants"]);
      _id_7DF2("defuses", var_0, self._id_9134["defuses"]);
      break;
    case "conf":
      _id_7DF2("confirms", var_0, self._id_9134["confirmed"]);
      _id_7DF2("denies", var_0, self._id_9134["denied"]);
      break;
    case "hq":
      _id_7DF2("captures", var_0, self._id_9134["captures"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
    case "koth":
      _id_7DF2("objTime", var_0, self._id_9134["objTime"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
    case "ctf":
      _id_7DF2("captures", var_0, self._id_9134["captures"]);
      _id_7DF2("returns", var_0, self._id_9134["returns"]);
      break;
    case "sr":
      _id_7DF2("plants", var_0, self._id_9134["plants"]);
      _id_7DF2("rescues", var_0, self._id_9134["rescues"]);
      break;
    case "siege":
      _id_7DF2("captures", var_0, self._id_9134["captures"]);
      _id_7DF2("revives", var_0, self._id_9134["rescues"]);
      break;
    case "grind":
      _id_7DF2("banks", var_0, self._id_9134["confirmed"]);
      _id_7DF2("denies", var_0, self._id_9134["denied"]);
      break;
    case "infect":
      _id_7DF2("time", var_0, scripts\mp\utility\stats::_id_6C29("extrascore0"));
      _id_7DF2("infected", var_0, self._id_9134["killsAsInfected"]);
      break;
    case "gun":
      _id_7DF2("stabs", var_0, self._id_9134["stabs"]);
      _id_7DF2("setBacks", var_0, self._id_9134["setbacks"]);
      break;
    case "grnd":
      _id_7DF2("objTime", var_0, self._id_9134["objTime"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
    case "cmd":
      _id_7DF2("assists", var_0, self._id_9134["assists"]);
      _id_7DF2("captures", var_0, self._id_9134["captures"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
    case "pill":
      _id_7DF2("banks", var_0, self._id_9134["confirmed"]);
      _id_7DF2("denies", var_0, self._id_9134["denied"]);
      break;
    case "br":
      _id_7DF2("downs", var_0, self._id_9134["downs"]);
      _id_7DF2("contracts", var_0, self._id_9134["contracts"]);
      _id_7DF2("wins", var_0, self._id_9134["wins"]);
      _id_7DF2("topFive", var_0, self._id_9134["topFive"]);
      _id_7DF2("topTen", var_0, self._id_9134["topTen"]);
      _id_7DF2("topTwentyFive", var_0, self._id_9134["topTwentyFive"]);
      _id_7DF2("gamesPlayed", var_0, self._id_9134["gamesPlayed"]);
      _id_7DF2("revives", var_0, self._id_9134["rescues"]);
      _id_7DF2("cash", var_0, self._id_9134["cash"]);
      break;
    case "patrol":
      _id_7DF2("objTime", var_0, self._id_9134["objTime"]);
      _id_7DF2("defends", var_0, self._id_9134["defends"]);
      break;
  }
}

_id_7DF2(var_0, var_1, var_2) {
  if(!isDefined(self._id_9135)) {
    self._id_9135 = [];
  }

  if(!isDefined(self._id_9135[var_0])) {
    self._id_9135[var_0] = self getplayerdata(level.progressiongroup, "playerStats", "modeStats", var_1, var_0);
  }

  var_3 = int(max(self._id_9135[var_0] + var_2, self._id_9135[var_0]));
  self setplayerdata(level.progressiongroup, "playerStats", "modeStats", var_1, var_0, var_3);
}

_id_FCA3(var_0, var_1, var_2) {
  var_3 = self getplayerdata(level.progressiongroup, "playerStats", "modeStats", var_1, var_0);

  if(var_2 > var_3) {
    self setplayerdata(level.progressiongroup, "playerStats", "modeStats", var_1, var_0, var_2);
  }
}

_id_6B34(var_0) {
  var_1 = scripts\engine\utility::ter_op(level.teambased, var_0._id_038F, var_0.pers["gamemodeScore"]);
  var_2 = var_0 scripts\mp\persistence::_id_E761("round", "timePlayed", 0);

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = var_2 / 60;
    var_1 = var_1 / var_3;
  }

  return var_1;
}

_id_8ADF(var_0) {
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  return isDefined(var_0) && var_0 != "" && !scripts\mp\utility\weapon::_id_88F6(var_0) && var_1 != "killstreak" && var_1 != "other";
}

_id_3503() {
  var_0 = scripts\common\utility::_id_F73A(level._id_9BAD);
  var_1 = "";
  var_2 = -1;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_4);

    if(_id_8ADF(var_4)) {
      if(!_func_030C("mp", "WeaponStats", var_4)) {
        continue;
      }
      var_5 = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_4, "kills");

      if(var_5 > var_2) {
        var_1 = var_4;
        var_2 = var_5;
      }
    }
  }

  var_6 = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_1, "shots");
  var_7 = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_1, "headShots");
  var_8 = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_1, "hits");
  var_9 = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_1, "deaths");
  var_10 = 0;
  self setplayerdata(level.progressiongroup, "bestWeapon", "kills", var_2);
  self setplayerdata(level.progressiongroup, "bestWeapon", "shots", var_6);
  self setplayerdata(level.progressiongroup, "bestWeapon", "headShots", var_7);
  self setplayerdata(level.progressiongroup, "bestWeapon", "hits", var_8);
  self setplayerdata(level.progressiongroup, "bestWeapon", "deaths", var_9);
  self setplayerdata(level.progressiongroup, "bestWeaponXP", var_10);
  var_11 = int(_func_0222("mp/statstable.csv", 4, var_1, 0));
  self setplayerdata(level.progressiongroup, "bestWeaponIndex", var_11);
}

_id_158F(var_0) {
  self notify("allow_weapon_mp()");

  if(var_0) {
    if(isDefined(self._id_15E1) && !self hasweapon(self._id_15E1) && !scripts\mp\utility\killstreak::_id_88DF()) {
      _id_0A95::_id_EC3C();
    }

    self._id_15E1 = undefined;
  } else {
    self._id_15E1 = self._id_9021;
    thread _id_10B8D();
  }
}

_id_1590() {
  level._id_158F = ::_id_158F;
}

_id_10B8D() {
  self endon("death");
  self endon("disconnect");
  self endon("allow_weapon_mp()");

  for(;;) {
    self waittill("weapon_switch_invalid", var_0);
    self._id_15E1 = var_0;
  }
}

_id_893B() {
  level.ismp = 1;
}

_id_10B24(var_0) {
  if(!istrue(level._id_98D0)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level endon("start_prematch");
  var_1 = getdvarint("#x3838a3edf2ef4cc49", 1);
  var_2 = -1;
  var_3 = gettime();

  for(;;) {
    var_4 = getdvarint("#x3ca76e9bb65cfc2bc", 50);
    var_5 = getdvarfloat("#x3bb1f10c6b97ad379", 300) * 1000;
    var_6 = scripts\engine\utility::ter_op(var_0, _func_006F(var_1), level.players.size);

    if(var_2 >= 0) {
      var_7 = var_2 + var_5;

      if(var_6 >= var_4 && gettime() >= var_7 && !istrue(level._id_48E9)) {
        break;
      }
    } else if(var_6 >= var_4)
      var_2 = gettime();

    waitframe();
  }

  var_8 = getdvarint("#x3ca53d7bb65a9536e", 100);
  var_6 = scripts\engine\utility::ter_op(var_0, _func_006F(var_1), level.players.size);

  if(var_6 <= var_8) {
    level._id_98D1 = 1;
    var_9 = gettime() - var_3;
    var_10 = getdvarfloat("#x3bb1f10c6b97ad379", 300);
    _func_03BF("dlog_event_low_pop_start", ["start_players", var_6, "wait_time_ms", var_9, "active_client_count", var_0, "lowpop_min", var_4, "lowpop_max", var_8, "lowpop_time", var_10]);

    if(isDefined(level._id_AB2B)) {
      [[level._id_AB2B]]();
    }
  }

  level notify("start_prematch");
}

_id_10B29() {
  level endon("start_prematch");
  var_0 = getdvarint("#x3838a3edf2ef4cc49", 1);
  var_1 = gettime();
  var_2 = var_1;
  var_3 = getdvarint("#x3e4aa2b4357caabd3");

  if(var_3 != 0) {
    for(;;) {
      if(istrue(level._id_48E9)) {
        break;
      }

      var_4 = (var_2 - var_1) / 1000;
      var_5 = getdvarint("#x3991f4b475e699078", 300);

      if(var_5 > 0 && var_4 >= var_5) {
        break;
      }

      if(var_4 <= getdvarint("#x31137d7ad6ba3d6d6", 15)) {
        if(_func_006F(0) >= getdvarint("#x3e4aa2b4357caabd3")) {
          break;
        }
      } else if(_func_006F(var_0) >= getdvarint("#x3e4aa2b4357caabd3")) {
        break;
      }

      waitframe();
      var_2 = gettime();
    }
  }

  level notify("start_prematch");
}

_id_2C4D() {
  level endon("start_prematch");

  while(level.players.size < getdvarint("#x3e03e0043260c3e7f") || istrue(level._id_48E9)) {
    waitframe();
  }

  level notify("start_prematch");
}

_id_10ACA() {
  level._id_E689 = [];
  var_0 = getEntArray("start_lobby_trigger", "targetname");
  level thread _id_10815();
  level thread _id_10816();

  if(var_0.size == 0) {
    level thread _id_1080B();
  } else {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.target)) {
        var_3[0] = getent(var_2.target, "targetname");
      } else {
        var_3[0] = spawn("script_model", var_2.origin);
        var_3[0].angles = var_2.angles;
      }

      var_4 = _id_07D6::_id_406E("neutral", var_2, var_3, (0, 0, 64), undefined, 1);
      var_4 _id_07D6::_id_15DF("any");
      var_4._id_7C8C = "use";
      var_4.trigger _meth_83A2();
      var_4 _id_07D6::_id_D8D2(3);
      var_4 _id_07D6::_id_D8D0(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
      var_4._id_ABCB = ::_id_E688;
      level._id_E689[level._id_E689.size] = var_4;
    }
  }
}

_id_1080B() {
  level endon("game_ended");
  level endon("start_prematch");
  level waittill("connected", var_0);
  var_0 waittill("giveLoadout");
  waitframe();
  var_1[0] = spawn("script_model", var_0.origin);
  var_2 = var_1[0];
  var_1[0] setModel("tag_origin");
  var_3 = "any";
  var_4 = 3;
  var_5 = (31983, -35229, -458);
  var_2.team = "neutral";
  level._id_E689[0] = _id_07D6::_id_3FF1(var_3, var_2, var_1, (0, 0, 0));
  level._id_E689[0]._id_4140 = var_5;
  level._id_E689[0].trigger.origin = var_5;
  level._id_E689[0]._id_10430[0].origin = var_5;
  level._id_E689[0].trigger makeuseable();
  level._id_E689[0]._id_ADAE = var_2.team;
  level._id_E689[0].trigger.owner = level.players[0];
  level._id_E689[0]._id_83B6 = "any";
  level._id_E689[0]._id_4143 = 0;
  level._id_E689[0]._id_FEB1 = 1;
  level._id_E689[0]._id_7C8C = "use";
  level._id_E689[0]._id_56E2 = 0;
  level._id_E689[0]._id_56E1 = 1;
  level._id_E689[0]._id_DDC9 = 1;
  level._id_E689[0]._id_DDB5 = 1;
  level._id_E689[0].trigger setcursorhint("HINT_NOICON");
  level._id_E689[0].trigger _meth_84D1(1);
  level._id_E689[0].trigger sethintstring(&"MP_INGAME_ONLY/HOLD_TO_START_GAME");
  level._id_E689[0].trigger _meth_83A2();
  level._id_E689[0]._id_ABCB = ::_id_E688;
  level._id_E689[0]._id_5C3F = spawn("script_model", var_5);
  level._id_E689[0]._id_5C3F setModel("prop_flag_neutral");
  level._id_E689[0]._id_FDB1 = spawn("trigger_radius", var_5, 0, 32, 128);
  level._id_E689[0] _id_07D6::_id_D8D2(var_4);
}

_id_10815() {
  level endon("game_ended");
  level endon("dev_force_start_completed");

  for(;;) {
    if(getdvarint("#x32291a88c4ebe6c97", 0)) {
      _id_48D9();
      break;
    }

    wait 0.5;
  }
}

_id_10816() {
  level endon("game_ended");
  level endon("dev_force_start_completed");
  level waittill("forcematchstart");
  _id_48D9();
}

_id_E688(var_0) {
  var_0 setclientomnvar("ui_securing", 0);
  _id_48D9();
}

_id_48D9() {
  level thread _id_0AA2::_id_B8F1("mp_dom_flag_captured");

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\print::_id_EF7B("MP_INGAME_ONLY/GAME_FORCE_STARTED", var_1, 10);
  }

  setDvar("#x3e03e0043260c3e7f", 1);
  setDvar("#x3e4aa2b4357caabd3", 1);
  level notify("start_prematch");

  foreach(var_4 in level._id_E689) {
    var_4 _id_07D6::_id_15DF("none");
    var_4.trigger = undefined;
    var_4._id_1041A = "none";
    var_4._id_5C3F delete();
    var_4 notify("deleted");
  }

  level notify("dev_force_start_completed");
}

_id_9596() {
  level._id_60BD = gettime();
  level.gameended = 1;
  level._id_7EB0 = 0;
  level._id_4C6F = 0;
  game["blockJIP"] = 1;
  waitframe();
  _id_D571(undefined);
  waitframe();
  setgameendtime(0);
  thread _id_07A9::_id_9784();

  if(_id_07A9::_id_176F()) {
    _id_07A9::_id_1770();
  }

  if(isDefined(level._id_9BCE)) {
    [[level._id_9BCE]]();
  }

  setDvar("#x37c9b9af716ef3c26", 1);
  setDvar("#x3d66aa88265dae2e0", 0);
  setDvar("#x3ca984a865792777", 0);
  _id_9597(1, 1);
  level notify("game_cleanup");
  _func_01F0(1.0, 0.4, 3);
  _id_C641();
  _id_07D1::_id_9352("block_notifies");
  restart();
}

_id_9597(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_4 thread scripts\mp\utility\game::_id_D73A(0.0);

    if(var_4 _meth_81D3()) {
      var_2 = 2;
    }
  }

  wait(var_0 + var_2);
  level notify("round_end_finished");
}

_id_9595(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);

  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    _id_9BF4(var_2);
  }

  visionsetnaked("", 0.0);
}

_id_395B() {
  game["numPlayersConsideredPlaying"] = 0;
  game["matchHasMoreThan1Player"] = 0;
}

_id_FCBD() {
  var_0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]++;

  if(!game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] > 1) {
      game["matchHasMoreThan1Player"] = 1;
    }
  }

  if(game["matchHasMoreThan1Player"]) {
    if(!var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++) {
        level.players[var_1] setclientomnvar("match_has_more_than_1_player", 1);
      }
    } else
      self setclientomnvar("match_has_more_than_1_player", 1);
  }
}

_id_FCBC() {
  var_0 = game["matchHasMoreThan1Player"];
  game["numPlayersConsideredPlaying"]--;

  if(game["matchHasMoreThan1Player"]) {
    if(game["numPlayersConsideredPlaying"] <= 1) {
      game["matchHasMoreThan1Player"] = 0;
    }
  }

  if(!game["matchHasMoreThan1Player"]) {
    if(var_0) {
      for(var_1 = 0; var_1 < level.players.size; var_1++) {
        level.players[var_1] setclientomnvar("match_has_more_than_1_player", 0);
      }
    }
  }
}

_id_C4FC() {
  wait 10;
  var_0 = [];
  var_0[1] = "tactical_ladder_col";
  var_0[2] = "clip8x8x256";
  var_0[3] = "player8x8x256";
  var_0[4] = "ladderMetal264";
  var_0[5] = "ladderWood192";
  var_0[6] = "ladderMetal192";
  var_0[7] = "mount128";
  var_0[8] = "mount64";
  var_0[9] = "mount32";
  var_0[10] = "mount256";
  var_0[11] = "ladderWood264";
  var_0[12] = "nosight256x256x8";
  var_0[13] = "nosight128x128x8";
  var_0[14] = "mountCorner128";
  var_0[15] = "mantle256";
  var_0[16] = "mantle128";
  var_0[17] = "mantle64";
  var_0[18] = "mantle32";
  var_0[19] = "stairsHalfFlight128";
  var_0[20] = "stairsFullFlight128";

  foreach(var_2 in var_0) {
    scripts\cp_mp\utility\game_utility::_id_C4E8(var_2, "targetname");
  }
}

_id_692B() {
  return 9;
}

_id_3510() {
  level._id_15D8 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::_id_6D9E(), "_allowSupers"), level._id_15D8);
}

setattackingteam() {
  if(!isDefined(game["attackers"])) {
    setomnvar("ui_attacking_team", 0);
  }

  if(game["attackers"] == "axis") {
    setomnvar("ui_attacking_team", 1);
  } else if(game["attackers"] == "allies") {
    setomnvar("ui_attacking_team", 2);
  } else {
    setomnvar("ui_attacking_team", 0);
  }
}