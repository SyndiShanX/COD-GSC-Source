/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_spawnscoring.gsc
*******************************************************/

init() {
  if(!isDefined(game["gamestarted"]) && !(maps\mp\_utility::_id_551F() || _func_367())) {
    var_0 = getDvar("1924");

    switch (var_0) {
      case "war":
        var_0 = "tdm";
        break;
      case "raid":
        var_0 = "war";
        break;
      case "hp":
      case "dom":
      case "ctf":
        break;
      default:
        return;
    }

    level._id_609F = 10;
    _func_37B("mp/ddl/spawndata_" + var_0 + ".ddl");
    _func_37C();
    _func_37A("matchSpawnData", "spawnTuningVersion", common_scripts\utility::_id_9AAD(level._id_90B4));
    _func_37A("matchSpawnData", "gametype", getDvar("1924"));
    level._id_903C = 1;
  }
}

_id_57DC(var_0) {
  switch (var_0) {
    case "raid":
    case "hp":
    case "dom":
    case "war":
    case "ctf":
      return 1;
    default:
      return 0;
  }
}

_id_5EAC() {
  level endon("game_ended");

  if(maps\mp\_utility::_id_551F() || _func_367()) {
    return;
  }
  var_0 = 18;
  var_1 = 9;
  var_2 = 10;
  var_3 = 80;
  var_4 = 10;
  var_5 = [];
  var_6 = [];

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_5[var_7] = spawnStruct();
    var_5[var_7]._id_5E3E = (-999999, -999999, -999999);
    var_5[var_7]._id_0DCE = (-999999, -999999, -999999);
  }

  for(var_8 = 0; var_8 < var_2; var_8++) {
    var_6[var_8] = spawnStruct();
    var_6[var_8]._id_5E3E = (-999999, -999999, -999999);
    var_6[var_8]._id_0DCE = (-999999, -999999, -999999);
  }

  var_9 = -1;

  for(;;) {
    level waittill("log_player_spawn_data", var_10);

    if(!isDefined(var_10) && !isPlayer(var_10)) {
      continue;
    }
    if(isDefined(level._id_A239) && level._id_A239 && (isDefined(level.ingraceperiod) && level.ingraceperiod)) {
      continue;
    }
    var_11 = _id_57DC(level.gametype) && var_9 < var_4 - 1 && randomint(3) == 0;

    if(var_11) {
      var_9++;
      _func_37A("spawns", var_9, "spawnTuningVersion", common_scripts\utility::_id_9AAD(level._id_90B4));
      _func_37A("spawns", var_9, "timeFromMatchStart", maps\mp\_utility::gettimepassed());
      _func_37A("spawns", var_9, "matchID", getmatchdata("match_common", "matchID"));
      _func_37A("spawns", var_9, "playerID", var_10.clientid);
    }

    var_12 = 0;
    var_13 = 0;
    var_14 = maps\mp\_utility::_id_44FB();
    var_15 = var_10.team;
    var_16 = 0;

    foreach(var_18 in level.players) {
      if(isbot(var_18) || istestclient(var_18) || var_18 == var_10) {
        continue;
      }
      if(maps\mp\_utility::isreallyalive(var_18) && isDefined(var_18._id_5CC6) && _id_0485::_id_1F59(var_18._id_5CC6)) {
        if(level.teambased && var_18.team == var_15) {
          if(var_12 < var_1) {
            var_5[var_12]._id_5E3E = var_18.origin;
            var_5[var_12]._id_0DCE = var_18.angles;
          }

          var_12++;
        } else {
          if(var_13 < var_2) {
            var_6[var_13]._id_5E3E = var_18.origin;
            var_6[var_13]._id_0DCE = var_18.angles;
          }

          var_13++;
        }

        if(var_11 && var_16 < var_0) {
          _func_37A("spawns", var_9, "otherPlayerInfo", var_16, "position", 0, int(var_18.origin[0]));
          _func_37A("spawns", var_9, "otherPlayerInfo", var_16, "position", 1, int(var_18.origin[1]));
          _func_37A("spawns", var_9, "otherPlayerInfo", var_16, "position", 2, int(var_18.origin[2]));
          _func_37A("spawns", var_9, "otherPlayerInfo", var_16, "team", var_18.team);
          var_16++;
        }
      }
    }

    for(var_7 = var_12; var_7 < var_1; var_7++) {
      var_5[var_7]._id_5E3E = (-999999, -999999, -999999);
      var_5[var_7]._id_0DCE = (-999999, -999999, -999999);
    }

    for(var_8 = var_13; var_8 < var_2; var_8++) {
      var_6[var_8]._id_5E3E = (-999999, -999999, -999999);
      var_6[var_8]._id_0DCE = (-999999, -999999, -999999);
    }

    var_20 = gettime();
    var_21 = var_10;
    _reconspatialevent(var_10._id_9092, "script_mp_spawndata_plyrlocs: player_name %s, life_id %d, team %s, gameTime %d, ally_0_loc %v, ally_0_ang %v, ally_1_loc %v, ally_1_ang %v, ally_2_loc %v, ally_2_ang %v, ally_3_loc %v, ally_3_ang %v, ally_4_loc %v, ally_4_ang %v, ally_5_loc %v, ally_5_ang %v, ally_6_loc %v, ally_6_ang %v, ally_7_loc %v, ally_7_ang %v, ally_8_loc %v, ally_8_ang %v, enemy_0_loc %v, enemy_0_ang %v, enemy_1_loc %v, enemy_1_ang %v, enemy_2_loc %v, enemy_2_ang %v, enemy_3_loc %v, enemy_3_ang %v, enemy_4_loc %v, enemy_4_ang %v, enemy_5_loc %v, enemy_5_ang %v, enemy_6_loc %v, enemy_6_ang %v, enemy_7_loc %v, enemy_7_ang %v, enemy_8_loc %v, enemy_8_ang %v, enemy_9_loc %v, enemy_9_ang %v", var_21.name, var_21._id_5CC6, var_21.team, var_20, var_5[0]._id_5E3E, var_5[0]._id_0DCE, var_5[1]._id_5E3E, var_5[1]._id_0DCE, var_5[2]._id_5E3E, var_5[2]._id_0DCE, var_5[3]._id_5E3E, var_5[3]._id_0DCE, var_5[4]._id_5E3E, var_5[4]._id_0DCE, var_5[5]._id_5E3E, var_5[5]._id_0DCE, var_5[6]._id_5E3E, var_5[6]._id_0DCE, var_5[7]._id_5E3E, var_5[7]._id_0DCE, var_5[8]._id_5E3E, var_5[8]._id_0DCE, var_6[0]._id_5E3E, var_6[0]._id_0DCE, var_6[1]._id_5E3E, var_6[1]._id_0DCE, var_6[2]._id_5E3E, var_6[2]._id_0DCE, var_6[3]._id_5E3E, var_6[3]._id_0DCE, var_6[4]._id_5E3E, var_6[4]._id_0DCE, var_6[5]._id_5E3E, var_6[5]._id_0DCE, var_6[6]._id_5E3E, var_6[6]._id_0DCE, var_6[7]._id_5E3E, var_6[7]._id_0DCE, var_6[8]._id_5E3E, var_6[8]._id_0DCE, var_6[9]._id_5E3E, var_6[9]._id_0DCE);
    var_22 = -1;
    var_23 = -1;
    var_24 = "none";
    var_25 = "none";
    var_26 = var_12 + var_13;
    var_27 = level.players.size;
    var_28 = getmatchdata("match_common", "player_count");
    var_29 = getmatchdata("match_common", "life_count");
    var_30 = getmatchdata("match_common", "playlist_name");
    var_31 = 0;

    if(isDefined(var_30)) {
      if(issubstr(var_30, "QA"))
        var_31 = 1;
    }

    if(!isDefined(level._id_6026)) {
      var_32 = -1;
      var_33 = -1;
    } else {
      if(isDefined(game["botJoinCount"]))
        var_32 = game["botJoinCount"];
      else
        var_32 = -1;

      if(isDefined(game["deathCount"]))
        var_33 = game["deathCount"];
      else
        var_33 = -1;
    }

    var_34 = -1;
    var_35 = -1;
    var_36 = -1;
    var_37 = -1;
    var_38 = -1;
    var_39 = -1;

    if(level.teambased) {
      var_25 = _id_04D2::_id_473F();

      if(maps\mp\_utility::isroundbased() || maps\mp\_utility::isobjectivebased()) {
        var_36 = maps\mp\_utility::getroundswon(var_21.team);
        var_37 = maps\mp\_utility::getroundswon(maps\mp\_utility::getotherteam(var_21.team));
        var_34 = maps\mp\_utility::getroundswon("allies");
        var_35 = maps\mp\_utility::getroundswon("axis");
        var_38 = _id_04D2::_id_063E(var_21.team);
        var_39 = _id_04D2::_id_063E(maps\mp\_utility::getotherteam(var_21.team));
      } else {
        var_36 = _id_04D2::_id_063E(var_21.team);
        var_37 = _id_04D2::_id_063E(maps\mp\_utility::getotherteam(var_21.team));
        var_34 = _id_04D2::_id_063E("allies");
        var_35 = _id_04D2::_id_063E("axis");
      }
    } else {
      var_40 = _id_04D2::_id_450B(2);
      var_36 = var_21.score;

      if(var_40.size > 0 && var_40[0] != var_21)
        var_37 = var_37;
      else
        var_37 = -1;

      if(var_40.size > 0)
        var_25 = var_40[0].name;
      else
        var_25 = "none";
    }

    var_41 = maps\mp\_utility::getscorelimit();
    var_42 = common_scripts\utility::_id_98E7(var_36 > var_37, var_36, var_37);

    if(var_41 > 0)
      var_43 = var_42 / var_41;
    else
      var_43 = -1;

    var_24 = common_scripts\utility::_id_98E7(isDefined(game["status"]), game["status"], "none");
    var_22 = common_scripts\utility::_id_98E7(isDefined(game["timePassed"]), game["timePassed"], -1);
    var_23 = maps\mp\gametypes\_gamelogic::_id_46E5();
    var_44 = 0;

    if(var_24 == "normal")
      var_44 = 1;
    else if(var_24 == "halfway")
      var_44 = 2;

    if(var_11) {
      _func_37A("spawns", var_9, "matchInfo", "scoreAllies", maps\mp\_utility::_id_2315(var_34));
      _func_37A("spawns", var_9, "matchInfo", "scoreAxis", maps\mp\_utility::_id_2315(var_35));
      _func_37A("spawns", var_9, "matchInfo", "roundNum", maps\mp\_utility::_id_2314(var_44));
    }

    _reconevent("script_mp_spawndata_matchinfo: player_name %s, life_id %d, team %s, gameTime %d, timePassed %d, timeRemaining %d, gameStatus %s,winning_team %s, winning_score_perc %f, ally_score %d, enemy_score %d, ally_score_for_cur_round %d, enemy_score_for_cur_round %d, aliveCount %d, activeCount %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, playlistName %s, qaPlayList %d", var_21.name, var_21._id_5CC6, var_21.team, var_20, var_22, var_23, var_24, var_25, var_43, var_36, var_37, var_38, var_39, var_26, var_27, var_28, var_32, var_29, var_33, var_30, var_31);

    if(isDefined(level._id_9068._id_9090)) {
      var_45 = 0;

      foreach(var_47 in level._id_9068._id_9090) {
        var_48 = var_47.origin;
        var_49 = var_47._id_9AB8;
        var_50 = var_47._id_9AB7;
        var_51 = _id_447B(var_47._id_285B);
        var_52 = var_47._id_2859;
        var_53 = var_47._id_6221[maps\mp\_utility::getotherteam(var_21.team)];

        if(!isDefined(var_49))
          var_49 = -1;

        if(!isDefined(var_50))
          var_50 = -1;

        if(!isDefined(var_52))
          var_52 = -1;

        if(!isDefined(var_53))
          var_53 = -1;

        if(var_11 && var_45 < var_3) {
          _func_37A("spawns", var_9, "spawnPoints", var_45, "position", 0, int(var_48[0]));
          _func_37A("spawns", var_9, "spawnPoints", var_45, "position", 1, int(var_48[1]));
          _func_37A("spawns", var_9, "spawnPoints", var_45, "position", 2, int(var_48[2]));
          _func_37A("spawns", var_9, "spawnPoints", var_45, "scoreFactor", var_49);
          _func_37A("spawns", var_9, "spawnPoints", var_45, "criticalFactorIndex", var_52);
          _func_37A("spawns", var_9, "spawnPoints", var_45, "timeToLineOfSight", var_53);
        }

        _reconspatialevent(var_48, "script_mp_spawndata_pointinfo: player_name %s, life_id %d, team %s, gameTime %d, scoreFactorsTotal %d, scoreFactorsPossibleTotal %d, criticalFactorsResult %d, criticalFactorIndex %d, ttlosValue %f", var_21.name, var_21._id_5CC6, var_21.team, var_20, var_49, var_50, var_51, var_52, var_53);
        var_45++;
      }
    }

    var_21 _id_5EA8(var_11, var_9);
  }
}

_id_5EA8(var_0, var_1) {
  var_2 = gettime();
  var_3 = level._id_90B4;
  var_4 = _id_050D::_id_580F();
  var_5 = "_matchdata.gsc";
  var_6 = -1;
  var_7 = -1;
  var_8 = -1;
  var_9 = -1;
  var_10 = -1;
  var_11 = -1;
  var_12 = -1;
  var_13 = -1;
  var_14 = -1;
  var_15 = -1;
  var_16 = -1;
  var_17 = -1;
  var_18 = -1;
  var_19 = -1;
  var_20 = -1;
  var_21 = -1;
  var_22 = -1;
  var_23 = -1;
  var_24 = -1;
  var_25 = -1;
  var_26 = -1;

  if(isDefined(self._id_9070)) {
    if(isDefined(self._id_9070._id_9087)) {
      if(isDefined(self._id_9070._id_0BD9))
        var_6 = self._id_9070._id_0BD9;

      if(isDefined(self._id_9070._id_6884))
        var_7 = self._id_9070._id_6884;

      if(isDefined(self._id_9070._id_689C))
        var_26 = self._id_9070._id_689C;

      if(isDefined(self._id_9070._id_9087._id_5C09))
        var_8 = self._id_9070._id_9087._id_5C09;

      if(isDefined(self._id_9070._id_76E6) && isDefined(self._id_9070._id_76E6.origin))
        var_13 = _distance2d(self._id_9092, self._id_9070._id_76E6.origin);

      var_14 = _func_391(self._id_9070._id_9087._id_00D4, self.team);

      if(!isDefined(var_14) || var_14 > 15000)
        var_14 = -1;

      var_15 = _func_391(self._id_9070._id_9087._id_00D4, maps\mp\_utility::getotherteam(self.team));

      if(!isDefined(var_15) || var_15 > 15000)
        var_15 = -1;

      var_27 = _func_393(self._id_9070._id_9087._id_00D4, self.team);

      if(var_27 > 0) {
        var_16 = _func_392(self._id_9070._id_9087._id_00D4, self.team);

        if(!isDefined(var_16) || var_16 > 15000)
          var_16 = -1;
        else
          var_16 = var_16 / var_27;
      }

      var_28 = _func_393(self._id_9070._id_9087._id_00D4, maps\mp\_utility::getotherteam(self.team));

      if(var_28 > 0) {
        var_17 = _func_392(self._id_9070._id_9087._id_00D4, maps\mp\_utility::getotherteam(self.team));

        if(!isDefined(var_17) || var_17 > 15000)
          var_17 = -1;
        else
          var_17 = var_17 / var_28;
      }

      var_18 = _func_394(self._id_9070._id_9087._id_00D4, self.team);
      var_19 = _func_395(self._id_9070._id_9087._id_00D4, maps\mp\_utility::getotherteam(self.team));

      if(isDefined(self._id_9070._id_9087._id_2055) && self._id_9070._id_9087._id_2055)
        var_23 = 1;
      else
        var_23 = 0;

      if(isDefined(self._id_9070._id_90B3)) {
        if(isDefined(self._id_9070._id_90B3["primary"]))
          var_24 = self._id_9070._id_90B3["primary"];

        if(isDefined(self._id_9070._id_90B3["secondary"]))
          var_25 = self._id_9070._id_90B3["secondary"];
      }

      var_29 = _id_050C::_id_3B91(self.team, self._id_9070._id_9087, 0);

      if(isDefined(var_29))
        var_11 = _sqrt(var_29);

      var_30 = _id_050C::_id_3B92(self.team, self._id_9070._id_9087, 0);

      if(isDefined(var_30))
        var_12 = _sqrt(var_30);

      if(isDefined(self._id_00E6) && isDefined(self._id_00E6.origin))
        var_10 = _distance2d(self._id_9070._id_9087.origin, self._id_00E6.origin);

      if(isDefined(self._id_5B90))
        var_9 = _distance2d(self._id_9070._id_9087.origin, self._id_5B90);
    }
  }

  if(var_0) {
    _func_37A("spawns", var_1, "playerInfo", "lifeNum", self._id_5CC6);
    _func_37A("spawns", var_1, "playerInfo", "wasTacticalInsertion", self._id_A87A);
    _func_37A("spawns", var_1, "playerInfo", "team", self.team);
    _func_37A("spawns", var_1, "playerInfo", "spawnPos", 0, int(self._id_9092[0]));
    _func_37A("spawns", var_1, "playerInfo", "spawnPos", 1, int(self._id_9092[1]));
    _func_37A("spawns", var_1, "playerInfo", "spawnPos", 2, int(self._id_9092[2]));
  }

  switch (level.gametype) {
    case "conf":
    case "war":
      if(isDefined(level._id_6026) && isDefined(game["spawnClaimFlipCount"]))
        var_31 = game["spawnClaimFlipCount"];
      else
        var_31 = -1;

      if(var_0) {
        _func_37A("tdmSpawns", var_1, "numTimesSidesFlipped", maps\mp\_utility::_id_2315(var_31));
        _func_37A("tdmSpawns", var_1, "causedSidesToFlip", var_23);
      }

      var_32 = 0;
      var_33 = 0;
      var_34 = (-999999, -999999, -999999);
      var_35 = (-999999, -999999, -999999);
      var_36 = 0;
      var_37 = (-999999, -999999, -999999);
      var_38 = -999;
      var_39 = -1;
      var_40 = -1;
      var_41 = -1;
      var_42 = -1;
      var_43 = getdvarint("spawning_revised_frontline") != 0 && _id_050C::_id_2936();

      if(var_43) {
        var_44 = _id_050C::_id_4500();

        if(isDefined(var_44)) {
          if(isDefined(var_44._id_565F)) {
            var_32 = var_44._id_565F["allies"];
            var_33 = var_44._id_565F["axis"];

            if(isDefined(var_44._id_0BF3))
              var_34 = var_44._id_0BF3;

            if(isDefined(var_44._id_1479))
              var_35 = var_44._id_1479;

            var_36 = var_32 && var_33 && isDefined(var_44._id_0BF3) && isDefined(var_44._id_1479);

            if(isDefined(var_44._id_6162))
              var_37 = var_44._id_6162;

            if(isDefined(var_44._id_9851))
              var_38 = var_44._id_9851;

            if(isDefined(var_44._id_5C09))
              var_39 = var_44._id_5C09;

            if(isDefined(var_44._id_5C0A))
              var_40 = var_44._id_5C0A;

            if(isDefined(var_44._id_A1C7))
              var_41 = var_44._id_A1C7;

            if(isDefined(var_44._id_32D2))
              var_42 = var_44._id_32D2;
          }
        }
      }

      _reconevent("script_mp_spawndata_info_tdm: player_name %s, life_id %d, team %s, gameTime %d, causedSpawnClaimsToFlip %d, spawnClaimsFlipCount %d, usingFrontline %b, frontlineActive %b, frontlineMidpoint %v, frontlineYaw %f, frontlineAlliesAverage %v, frontlineAxisAverage %v, frontlineActiveAllies %b, frontlineActiveAxis %b, frontlineLastUpdateTime %d, frontlineLastUpdateTimeDelta %d, frontlineUptime %d, frontlineDowntime %d", self.name, self._id_5CC6, self.team, var_2, var_23, var_31, var_43, var_36, var_37, var_38, var_34, var_35, var_32, var_33, var_39, var_40, var_41, var_42);
      break;
    case "hp":
      var_45 = level._id_AC7C.origin;
      var_46 = _distance2d(self._id_9092, var_45);
      var_47 = level._id_AC7C._id_3FCA _id_04D1::_id_45F7();

      if(var_47 == self.team)
        var_20 = var_46;
      else if(var_47 == maps\mp\_utility::getotherteam(self.team))
        var_21 = var_46;
      else
        var_22 = var_46;

      if(isDefined(self._id_99DE))
        var_48 = self._id_99DE;
      else
        var_48 = -1;

      var_49 = self.pers["defends"];

      if(isDefined(self._id_2EF1))
        var_50 = self._id_2EF1;
      else
        var_50 = 0;

      if(isDefined(self._id_5B90))
        var_51 = _distance2d(self._id_5B90, var_45);
      else
        var_51 = -1;

      if(var_0) {
        _func_37A("hpSpawns", var_1, "timeInHardPoint", maps\mp\_utility::_id_2315(var_48));
        _func_37A("hpSpawns", var_1, "diedInHardPoint", var_50);
        _func_37A("hpSpawns", var_1, "hpZoneInfo", "controllingTeam", _id_46CA(var_47));
        _func_37A("hpSpawns", var_1, "hpZoneInfo", "position", 0, int(var_45[0]));
        _func_37A("hpSpawns", var_1, "hpZoneInfo", "position", 1, int(var_45[1]));
        _func_37A("hpSpawns", var_1, "hpZoneInfo", "position", 2, int(var_45[2]));
      }

      _reconevent("script_mp_spawndata_info_hp: player_name %s, life_id %d, team %s, gameTime %d, hp_origin %v, hp_team %s, distToHP %f, diedInHP %b, distFromDeathToHP %f, time_in_hardpoint %d, defend_kills %d", self.name, self._id_5CC6, self.team, var_2, var_45, var_47, var_46, var_50, var_51, var_48, var_49);
      break;
    case "control":
    case "lockdown":
    case "dom":
      var_52 = "none";
      var_53 = -1;
      var_54 = "none";
      var_55 = -1;
      var_56 = 0;

      foreach(var_58 in level._id_3211) {
        if(isDefined(self._id_5B90)) {
          var_59 = _distance2d(self._id_5B90, var_58._id_28D4);

          if(var_53 == -1 || var_59 < var_53) {
            var_53 = var_59;
            var_52 = var_58.label;
          }
        }

        if(isDefined(self._id_9092)) {
          var_60 = _distance2d(self._id_9092, var_58._id_28D4);

          if(var_55 == -1 || var_60 < var_55) {
            var_55 = var_60;
            var_54 = var_58.label;
          }

          var_61 = var_58 _id_04D1::_id_45F7();

          if(var_61 == self.team && (var_20 == -1 || var_60 < var_20))
            var_20 = var_60;
          else if(var_61 == maps\mp\_utility::getotherteam(self.team) && (var_21 == -1 || var_60 < var_21))
            var_21 = var_60;
          else if(var_22 == -1 || var_60 < var_22)
            var_22 = var_60;

          if(var_0 && var_56 < 3) {
            _func_37A("domSpawns", var_1, "domFlagInfo", var_56, "flag", _id_44A4(var_58.label));
            _func_37A("domSpawns", var_1, "domFlagInfo", var_56, "controllingTeam", _id_46CA(var_61));
            _func_37A("domSpawns", var_1, "domFlagInfo", var_56, "position", 0, int(var_58._id_28D4[0]));
            _func_37A("domSpawns", var_1, "domFlagInfo", var_56, "position", 1, int(var_58._id_28D4[1]));
            _func_37A("domSpawns", var_1, "domFlagInfo", var_56, "position", 2, int(var_58._id_28D4[2]));
          }
        }
      }

      var_63 = level._id_3211[0]._id_A582[0].origin;
      var_64 = level._id_3211[0]._id_6DB2;
      var_65 = level._id_3211[1]._id_A582[0].origin;
      var_66 = level._id_3211[1]._id_6DB2;
      var_67 = level._id_3211[2]._id_A582[0].origin;
      var_68 = level._id_3211[2]._id_6DB2;
      var_69 = var_20;
      var_70 = var_21;
      var_71 = var_22;

      if(isDefined(self._id_9070) && isDefined(self._id_9070._id_9087) && isDefined(self._id_9070._id_9087._id_766F))
        var_72 = self._id_9070._id_9087._id_766F;
      else
        var_72 = "none";

      var_73 = self.pers["captures"];
      var_49 = self.pers["defends"];

      if(isDefined(self._id_2EF1))
        var_74 = self._id_2EF1;
      else
        var_74 = 0;

      if(var_0) {
        _func_37A("domSpawns", var_1, "spawnFlag", _id_44A4(var_72));
        _func_37A("domSpawns", var_1, "nearestFlagOnSpawn", _id_44A4(var_54));
        _func_37A("domSpawns", var_1, "nearestFlagOnDeath", _id_44A4(var_52));
        _func_37A("domSpawns", var_1, "diedOnFlag", var_74);
      }

      _reconevent("script_mp_spawndata_info_dom: player_name %s, life_id %d, team %s, gameTime %d, a_origin %v, a_owner %s, b_origin %v, b_owner %s,c_origin %v, c_owner %s, spawnFlag %s, nearestFlagOnSpawn %s, diedOnFlag %b, nearestFlagOnDeath %s, distToAllyFlagOnSpawn %f, distToEnemyFlagOnSpawn %f, distToNeutralFlagOnSpawn %f, captures %d, defend_kills %d", self.name, self._id_5CC6, self.team, var_2, var_63, var_64, var_65, var_66, var_67, var_68, var_72, var_54, var_74, var_52, var_69, var_70, var_71, var_73, var_49);
      break;
    case "ctf":
      if(isDefined(level._id_9853[self.team].carrier))
        var_22 = _distance2d(self._id_9092, level._id_9853[self.team].carrier.origin);

      var_20 = _distance2d(self._id_9092, level._id_9853[self.team].origin);
      var_21 = _distance2d(self._id_9092, level._id_9853[maps\mp\_utility::getotherteam(self.team)].origin);
      var_75 = var_20;
      var_76 = var_21;
      var_77 = var_22;
      var_78 = level._id_9853["allies"];
      var_79 = level._id_9853["axis"];
      var_80 = var_78.carrier;
      var_81 = var_79.carrier;
      var_82 = undefined;
      var_83 = undefined;

      if(!isDefined(var_80)) {
        var_84 = "none";
        var_85 = -1;
        var_82 = var_78.origin;
      } else {
        var_84 = var_80.name;
        var_85 = var_80.clientid;
        var_82 = var_80.origin;
      }

      if(!isDefined(var_81)) {
        var_86 = "none";
        var_87 = -1;
        var_83 = var_79.origin;
      } else {
        var_86 = var_81.name;
        var_87 = var_81.clientid;
        var_83 = var_81.origin;
      }

      var_73 = self.pers["captures"];
      var_88 = self.pers["returns"];
      var_49 = self.pers["defends"];

      if(isDefined(self._id_2EF1))
        var_89 = self._id_2EF1;
      else
        var_89 = 0;

      if(var_0) {
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "team", "allies");
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "homePosition", 0, int(var_78.origin[0]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "homePosition", 1, int(var_78.origin[1]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "homePosition", 2, int(var_78.origin[2]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "carrierID", var_85);
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "position", 0, int(var_82[0]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "position", 1, int(var_82[1]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 0, "position", 2, int(var_82[2]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "team", "axis");
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "homePosition", 0, int(var_79.origin[0]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "homePosition", 1, int(var_79.origin[1]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "homePosition", 2, int(var_79.origin[2]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "carrierID", var_87);
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "position", 0, int(var_83[0]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "position", 1, int(var_83[1]));
        _func_37A("ctfSpawns", var_1, "flagInfo", 1, "position", 2, int(var_83[2]));
        _func_37A("ctfSpawns", var_1, "diedWithFlag", var_89);
      }

      _reconevent("script_mp_spawndata_info_ctf: player_name %s, life_id %d, team %s, gameTime %d, allies_flag_loc %v, allies_carrier %s, axis_flag_loc %v, axis_carrier %s,diedWtihFlag %b, distToAllyFlagBase %f, distToEnemyFlagBase %f, distToEnemyFlagCarrier %f, captures %d, returns %d, defend_kills %d", self.name, self._id_5CC6, self.team, var_2, var_82, var_84, var_83, var_86, var_89, var_75, var_76, var_77, var_73, var_88, var_49);
      break;
  }

  _reconspatialevent(self._id_9092, "script_mp_spawndata_spawninfo: player_name %s, life_id %d, life_index %d, was_tactical_insertion %b, team %s, gameTime %d, tuning_version %f, allBadSpawn %d, spawnTypePercPrimary %f, spawnTypePercSecondary %f,number_of_choices %d, distToNearestAlly %f, distToNearestEnemy %f, averageDistToAlly %f, averageDistToEnemy %f, numNearbyAllies %d, numNearbyEnemies %d, distToDeathLocation %f, distToLastAttacker %f, distToPrevSpawnLocation %f, distToNearestAllyDeathLocation %f, distToNearestEnemySpawnLocation %f", self.name, self._id_5CC6, self._id_6870, self._id_A87A, self.team, var_2, var_3, var_6, var_24, var_25, var_7, var_14, var_15, var_16, var_17, var_18, var_19, var_9, var_10, var_13, var_11, var_12);
  _reconspatialevent(self._id_9092, "script_mp_playerspawn: player_name %s, life_id %d, life_index %d, was_tactical_insertion %b, team %s, gameTime %d, version %f, script_file %s, allBadSpawn %b, number_of_choices %d, last_update_time %d, distToPrevSpawnLocation %f, distToNearestFriendly %f, distToNearestEnemy %f, numNearbyFriendlies %d, numNearbyEnemies %d, distToNearestFriendlyObjective %f, distToNearestEnemyObjective %f, averageDistToFriendly %f, averageDistToEnemy %f, distToNearestNeutralObjective %f, causedSpawnClaimsToFlip %d, spawnTypePercPrimary %f, spawnTypePercSecondary %f, numSecondaryBetterThanTopPrimary %d, isTTLOSDataAvailable %d", self.name, self._id_5CC6, self._id_6870, self._id_A87A, self.team, var_2, var_3, var_5, var_6, var_7, var_8, var_13, var_14, var_15, var_18, var_19, var_20, var_21, var_16, var_17, var_22, var_23, var_24, var_25, var_26, var_4);
}

_id_5E90() {
  var_0 = gettime();
  var_1 = level._id_90B4;
  var_2 = level.players.size;
  var_3 = getmatchdata("match_common", "player_count");
  var_4 = getmatchdata("match_common", "life_count");
  var_5 = getmatchdata("match_common", "playlist_name");
  var_6 = 0;

  if(isDefined(var_5)) {
    if(issubstr(var_5, "QA"))
      var_6 = 1;
  }

  if(!isDefined(level._id_6026)) {
    var_7 = -1;
    var_8 = -1;
    var_9 = -1;
    var_10 = -1;
    var_11 = -1;
    var_12 = -1;
    var_13 = -1;
    var_14 = -1;
  } else {
    if(isDefined(game["botJoinCount"]))
      var_7 = game["botJoinCount"];
    else
      var_7 = -1;

    if(isDefined(game["deathCount"]))
      var_8 = game["deathCount"];
    else
      var_8 = -1;

    if(isDefined(game["trapSpawnDiedTooFastCount"]))
      var_9 = game["trapSpawnDiedTooFastCount"];
    else
      var_9 = -1;

    if(isDefined(game["trapSpawnKilledTooFastCount"]))
      var_10 = game["trapSpawnKilledTooFastCount"];
    else
      var_10 = -1;

    if(isDefined(game["trapSpawnDmgDealtCount"]))
      var_11 = game["trapSpawnDmgDealtCount"];
    else
      var_11 = -1;

    if(isDefined(game["trapSpawnDmgReceivedCount"]))
      var_12 = game["trapSpawnDmgReceivedCount"];
    else
      var_12 = -1;

    if(isDefined(game["trapSpawnByAnyMeansCount"]))
      var_13 = game["trapSpawnByAnyMeansCount"];
    else
      var_13 = -1;

    if(isDefined(game["objectiveFlipCount"]))
      var_14 = game["objectiveFlipCount"];
    else
      var_14 = -1;
  }

  var_15 = -1;
  var_16 = -1;

  if(level.teambased) {
    var_17 = _id_04D2::_id_473F();

    if(maps\mp\_utility::isroundbased() || maps\mp\_utility::isobjectivebased()) {
      var_15 = maps\mp\_utility::getroundswon("allies");
      var_16 = maps\mp\_utility::getroundswon("axis");
    } else {
      var_15 = _id_04D2::_id_063E("allies");
      var_16 = _id_04D2::_id_063E("axis");
    }
  } else {
    var_18 = _id_04D2::_id_450B(2);

    if(isDefined(var_18[0])) {
      var_15 = var_18[0].score;
      var_17 = var_18[0].name;
    } else
      var_17 = "none";

    if(isDefined(var_18[1]))
      var_16 = var_18[1].score;
  }

  var_19 = maps\mp\_utility::getscorelimit();
  var_20 = common_scripts\utility::_id_98E7(var_15 > var_16, var_15, var_16);

  if(var_19 > 0)
    var_21 = var_20 / var_19;
  else
    var_21 = -1;

  var_22 = common_scripts\utility::_id_98E7(isDefined(game["status"]), game["status"], "none");
  var_23 = common_scripts\utility::_id_98E7(isDefined(game["timePassed"]), game["timePassed"], -1);
  var_24 = maps\mp\gametypes\_gamelogic::_id_46E5();
  _reconevent("script_mp_spawndata_gameover: gameTime %d, tuning_version %f, timePassed %d, timeRemaining %d, gameStatus %s,winning_team %s, winning_score_perc %f, allies_score %d, axis_score %d, objectiveFlipCount %d, activeCount %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnByAnyMeansCount %d, victimSpawnDiedTooFastCount %d, victimSpawnKilledTooFastCount %d, immediateActionDmgDealtCount %d, immediateActionDmgReceivedCount %d, playlistName %s, qaPlayList %d", var_0, var_1, var_23, var_24, var_22, var_17, var_21, var_15, var_16, var_14, var_2, var_3, var_7, var_4, var_8, var_13, var_9, var_10, var_11, var_12, var_5, var_6);

  foreach(var_26 in level.players) {
    if(isbot(var_26) || istestclient(var_26)) {
      continue;
    }
    if(isDefined(var_26.pers["team"]))
      var_27 = var_26.pers["team"];
    else
      var_27 = "none";

    if(isDefined(var_26.pers["kills"]))
      var_28 = var_26.pers["kills"];
    else
      var_28 = -1;

    if(isDefined(var_26.pers["deaths"]))
      var_29 = var_26.pers["deaths"];
    else
      var_29 = -1;

    var_4 = -1;
    var_30 = -1;
    var_31 = -1;
    var_32 = -1;
    var_33 = -1;

    if(isDefined(var_26.pers["spawnCount"]))
      var_4 = var_26.pers["spawnCount"];

    if(isDefined(var_26.pers["immediateActionSpawnCount"]))
      var_30 = var_26.pers["immediateActionSpawnCount"];

    if(isDefined(var_26.pers["victimSpawnCount"]))
      var_31 = var_26.pers["victimSpawnCount"];

    if(isDefined(var_26.pers["causedImmediateActionSpawnCount"]))
      var_32 = var_26.pers["causedImmediateActionSpawnCount"];

    if(isDefined(var_26.pers["causedVictimSpawnCount"]))
      var_33 = var_26.pers["causedVictimSpawnCount"];

    _reconevent("script_mp_spawndata_gameover_player: player_name %s, team %s, gameTime %d, kills %d, deaths %d, spawnCount %d, immediateActionSpawnCount %d, victimSpawnCount %d, causedImmediateActionSpawnCount %d, causedVictimSpawnCount %d", var_26.name, var_27, var_0, var_28, var_29, var_4, var_30, var_31, var_32, var_33);
  }
}

_id_7AF5(var_0) {
  if(!isDefined(var_0._id_5BE1))
    var_0._id_5BE1 = "none";

  if(!isDefined(var_0._id_5BE2))
    var_0._id_5BE2 = -1;

  if(level.teambased) {
    var_1 = var_0._id_3EFF["allies"];
    var_2 = var_0._id_3EFF["axis"];
    var_3 = var_0._id_266E["allies"];
    var_4 = var_0._id_266E["axis"];
    var_5 = _func_391(var_0._id_00D4, "allies");
    var_6 = _func_391(var_0._id_00D4, "axis");
  } else {
    var_1 = var_0._id_3EFF["none"];
    var_2 = -1;
    var_3 = var_0._id_266E["none"];
    var_4 = -1;
    var_5 = _func_391(var_0._id_00D4, "none");
    var_6 = -1;
  }

  var_7 = -1;
  var_8 = -1;
  var_9 = -1;
  var_10 = -1;
  var_11 = -1;
  var_12 = -1;
  var_13 = -1;
  var_14 = -1;
  var_15 = -1;
  var_16 = -1;
  var_17 = -1;
  var_18 = -1;
  var_19 = -1;
  var_20 = -1;
  var_21 = -1;
  var_22 = -1;
  var_23 = "undefined";

  if(isDefined(self.name))
    var_23 = self.name;

  var_24 = -1;

  if(isDefined(self._id_5CC6))
    var_24 = self._id_5CC6;

  var_25 = "_spawnscoring.gsc";
  var_26 = level._id_90B4;
  var_27 = gettime();
  var_28 = var_0.classname;
  var_29 = var_0._id_9AB8;
  var_30 = var_0._id_285B;
  var_31 = var_0._id_6C97;
  var_32 = "none";

  if(isDefined(var_0._id_9849))
    var_32 = var_0._id_9849;

  if(isDefined(var_0._id_2B4F[0]))
    var_7 = var_0._id_2B4F[0];

  if(isDefined(var_0._id_2B4F[1]))
    var_8 = var_0._id_2B4F[1];

  if(isDefined(var_0._id_2B4F[2]))
    var_9 = var_0._id_2B4F[2];

  if(isDefined(var_0._id_2B4F[3]))
    var_10 = var_0._id_2B4F[3];

  if(isDefined(var_0._id_2B4F[4]))
    var_11 = var_0._id_2B4F[4];

  if(isDefined(var_0._id_2B4F[5]))
    var_12 = var_0._id_2B4F[5];

  if(isDefined(var_0._id_2B4F[6]))
    var_13 = var_0._id_2B4F[6];

  if(isDefined(var_0._id_2B4F[7]))
    var_14 = var_0._id_2B4F[7];

  if(isDefined(var_0._id_2B4F[8]))
    var_7 = var_0._id_2B4F[8];

  if(isDefined(var_0._id_2B4F[9]))
    var_8 = var_0._id_2B4F[9];

  if(isDefined(var_0._id_2B4F[10]))
    var_9 = var_0._id_2B4F[10];

  if(isDefined(var_0._id_2B4F[11]))
    var_10 = var_0._id_2B4F[11];

  if(isDefined(var_0._id_2B4F[12]))
    var_11 = var_0._id_2B4F[12];

  if(isDefined(var_0._id_2B4F[13]))
    var_12 = var_0._id_2B4F[13];

  if(isDefined(var_0._id_2B4F[14]))
    var_13 = var_0._id_2B4F[14];

  if(isDefined(var_0._id_2B4F[15]))
    var_14 = var_0._id_2B4F[15];

  var_33 = var_0._id_9AB7;
  var_34 = -1;
  var_35 = -1;
  var_36 = -1;
  var_37 = -1;
  var_38 = -1;
  var_39 = -1;
  var_40 = -1;
  var_41 = -1;

  if(isDefined(var_0._id_2B5E[0]))
    var_34 = var_0._id_2B5E[0];

  if(isDefined(var_0._id_2B5E[1]))
    var_35 = var_0._id_2B5E[1];

  if(isDefined(var_0._id_2B5E[2]))
    var_36 = var_0._id_2B5E[2];

  if(isDefined(var_0._id_2B5E[3]))
    var_37 = var_0._id_2B5E[3];

  if(isDefined(var_0._id_2B5E[4]))
    var_38 = var_0._id_2B5E[4];

  if(isDefined(var_0._id_2B5E[5]))
    var_39 = var_0._id_2B5E[5];

  if(isDefined(var_0._id_2B5E[6]))
    var_40 = var_0._id_2B5E[6];

  if(isDefined(var_0._id_2B5E[7]))
    var_41 = var_0._id_2B5E[7];

  _reconspatialevent(var_0.origin, "script_mp_spawnpoint_score: player_name %s, life_id %d, script_file %s, gameTime %d, classname %s, totalscore %d, totalPossibleScore %d, score_data0 %d, score_data1 %d, score_data2 %d, score_data3 %d, score_data4 %d, score_data5 %d, score_data6 %d, score_data7 %d, fullsights_allies %d, fullsights_axis %d, cornersights_allies %d, cornersights_axis %d, min_dist_allies %d, min_dist_axis %d, criticalResult %s, critical_data0 %d, critical_data1 %d, critical_data2 %d, critical_data3 %d, critical_data4 %d, critical_data5 %d, critical_data6 %d, critical_data7 %d, critical_data8 %d, critical_data9 %d, critical_data10 %d, critical_data11 %d, critical_data12 %d, critical_data13 %d, critical_data14 %d, critical_data15 %d, teamAssignment %s, outside %d, spawnVersion %f", var_23, var_24, var_25, var_27, var_28, var_29, var_33, var_34, var_35, var_36, var_37, var_38, var_39, var_40, var_41, var_1, var_2, var_3, var_4, var_5, var_6, var_30, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_32, var_31, var_26);
}

_id_447B(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "primary":
        return 1;
      case "secondary":
        return 2;
      case "bad":
        return 3;
    }
  } else
    return -1;
}

_id_44A4(var_0) {
  switch (var_0) {
    case "_a":
      return "alpha";
    case "_b":
      return "beta";
    case "_c":
      return "charlie";
    default:
      return "undefined";
  }
}

_id_46CA(var_0) {
  switch (var_0) {
    case "none":
    case "allies":
    case "axis":
      return var_0;
    case "neutral":
    default:
      return "none";
  }
}