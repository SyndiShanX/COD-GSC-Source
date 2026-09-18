/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawnscoring.gsc
***********************************************/

init() {
  if(!isDefined(game["gamestarted"]) && !maps\mp\_utility::func_551F() || function_0367()) {
    var_00 = getDvar("1924");
    switch (var_00) {
      case "war":
        var_00 = "tdm";
        break;

      case "raid":
        var_00 = "war";
        break;

      case "dom":
      case "hp":
      case "ctf":
        break;

      default:
        break;
    }

    level.var_609F = 10;
    function_037B("mp/ddl/spawndata_" + var_00 + ".ddl");
    function_037C();
    setspawndata("matchSpawnData", "spawnTuningVersion", common_scripts\utility::func_9AAD(level.var_90B4));
    setspawndata("matchSpawnData", "gametype", getDvar("1924"));
    level.var_903C = 1;
  }
}

func_57DC(param_00) {
  switch (param_00) {
    case "raid":
    case "dom":
    case "hp":
    case "war":
    case "ctf":
      return 1;

    default:
      return 0;
  }
}

func_5EAC() {
    level endon("game_ended");
    if(maps\mp\_utility::func_551F() || function_0367()) {
      return;
    }

    var_00 = 18;
    var_01 = 9;
    var_02 = 10;
    var_03 = 80;
    var_04 = 10;
    var_05 = [];
    var_06 = [];
    for(var_07 = 0; var_07 < var_01; var_07++) {
      var_05[var_07] = spawnStruct();
      var_05[var_07].var_5E3E = (-999999, -999999, -999999);
      var_05[var_07].var_DCE = (-999999, -999999, -999999);
    }

    for(var_08 = 0; var_08 < var_02; var_08++) {
      var_06[var_08] = spawnStruct();
      var_06[var_08].var_5E3E = (-999999, -999999, -999999);
      var_06[var_08].var_DCE = (-999999, -999999, -999999);
    }

    var_09 = -1;
    for(;;) {
      level waittill("log_player_spawn_data", var_0A);
      if(!isDefined(var_0A) && !isPlayer(var_0A)) {
        continue;
      }

      if(isDefined(level.usestartspawns) && level.usestartspawns && isDefined(level.var_5139) && level.var_5139) {
        continue;
      }

      var_0B = func_57DC(level.gametype) && var_09 < var_04 - 1 && randomint(3) == 0;
      if(var_0B) {
        var_09++;
        setspawndata("spawns", var_09, "spawnTuningVersion", common_scripts\utility::func_9AAD(level.var_90B4));
        setspawndata("spawns", var_09, "timeFromMatchStart", maps\mp\_utility::gettimepassed());
        setspawndata("spawns", var_09, "matchID", getmatchdata("match_common", "matchID"));
        setspawndata("spawns", var_09, "playerID", var_0A.clientid);
      }

      var_0C = 0;
      var_0D = 0;
      var_0E = maps\mp\_utility::func_44FB();
      var_0F = var_0A.team;
      var_10 = 0;
      foreach(var_12 in level.players) {
        if(isbot(var_12) || istestclient(var_12) || var_12 == var_0A) {
          continue;
        }

        if(maps\mp\_utility::isreallyalive(var_12) && isDefined(var_12.var_5CC6) && maps\mp\_matchdata::func_1F59(var_12.var_5CC6)) {
          if(level.teambased && var_12.team == var_0F) {
            if(var_0C < var_01) {
              var_05[var_0C].var_5E3E = var_12.origin;
              var_05[var_0C].var_DCE = var_12.angles;
            }

            var_0C++;
          } else {
            if(var_0D < var_02) {
              var_06[var_0D].var_5E3E = var_12.origin;
              var_06[var_0D].var_DCE = var_12.angles;
            }

            var_0D++;
          }

          if(var_0B && var_10 < var_00) {
            setspawndata("spawns", var_09, "otherPlayerInfo", var_10, "position", 0, int(var_12.origin[0]));
            setspawndata("spawns", var_09, "otherPlayerInfo", var_10, "position", 1, int(var_12.origin[1]));
            setspawndata("spawns", var_09, "otherPlayerInfo", var_10, "position", 2, int(var_12.origin[2]));
            setspawndata("spawns", var_09, "otherPlayerInfo", var_10, "team", var_12.team);
            var_10++;
          }
        }
      }

      for(var_07 = var_0C; var_07 < var_01; var_07++) {
        var_05[var_07].var_5E3E = (-999999, -999999, -999999);
        var_05[var_07].var_DCE = (-999999, -999999, -999999);
      }

      for(var_08 = var_0D; var_08 < var_02; var_08++) {
        var_06[var_08].var_5E3E = (-999999, -999999, -999999);
        var_06[var_08].var_DCE = (-999999, -999999, -999999);
      }

      var_14 = gettime();
      var_15 = var_0A;
      function_00F6(var_0A.var_9092, "@"script_mp_spawndata_plyrlocs: player_name % s, life_id % d, team % s, gameTime % d, ally_0_loc % v, ally_0_ang % v, ally_1_loc % v, ally_1_ang % v, ally_2_loc % v, ally_2_ang % v, ally_3_loc % v, ally_3_ang % v, ally_4_loc % v, ally_4_ang % v, ally_5_loc % v, ally_5_ang % v, ally_6_loc % v, ally_6_ang % v, ally_7_loc % v, ally_7_ang % v, ally_8_loc % v, ally_8_ang % v, enemy_0_loc % v, enemy_0_ang % v, enemy_1_loc % v, enemy_1_ang % v, enemy_2_loc % v, enemy_2_ang % v, enemy_3_loc % v, enemy_3_ang % v, enemy_4_loc % v, enemy_4_ang % v, enemy_5_loc % v, enemy_5_ang % v, enemy_6_loc % v, enemy_6_ang % v, enemy_7_loc % v, enemy_7_ang % v, enemy_8_loc % v, enemy_8_ang % v, enemy_9_loc % v, enemy_9_ang % v ",var_15.name,var_15.var_5CC6,var_15.team,var_14,var_05[0].var_5E3E,var_05[0].var_DCE,var_05[1].var_5E3E,var_05[1].var_DCE,var_05[2].var_5E3E,var_05[2].var_DCE,var_05[3].var_5E3E,var_05[3].var_DCE,var_05[4].var_5E3E,var_05[4].var_DCE,var_05[5].var_5E3E,var_05[5].var_DCE,var_05[6].var_5E3E,var_05[6].var_DCE,var_05[7].var_5E3E,var_05[7].var_DCE,var_05[8].var_5E3E,var_05[8].var_DCE,var_06[0].var_5E3E,var_06[0].var_DCE,var_06[1].var_5E3E,var_06[1].var_DCE,var_06[2].var_5E3E,var_06[2].var_DCE,var_06[3].var_5E3E,var_06[3].var_DCE,var_06[4].var_5E3E,var_06[4].var_DCE,var_06[5].var_5E3E,var_06[5].var_DCE,var_06[6].var_5E3E,var_06[6].var_DCE,var_06[7].var_5E3E,var_06[7].var_DCE,var_06[8].var_5E3E,var_06[8].var_DCE,var_06[9].var_5E3E,var_06[9].var_DCE);
        var_16 = -1; var_17 = -1; var_18 = "none"; var_19 = "none"; var_1A = var_0C + var_0D; var_1B = level.players.size; var_1C = getmatchdata("match_common", "player_count"); var_1D = getmatchdata("match_common", "life_count"); var_1E = getmatchdata("match_common", "playlist_name"); var_1F = 0;
        if(isDefined(var_1E)) {
          if(issubstr(var_1E, "QA")) {
            var_1F = 1;
          }
        }

        if(!isDefined(level.var_6026)) {
          var_20 = -1;
          var_21 = -1;
        } else {
          if(isDefined(game["botJoinCount"])) {
            var_20 = game["botJoinCount"];
          } else {
            var_20 = -1;
          }

          if(isDefined(game["deathCount"])) {
            var_21 = game["deathCount"];
          } else {
            var_21 = -1;
          }
        }

        var_22 = -1; var_23 = -1; var_24 = -1; var_25 = -1; var_26 = -1; var_27 = -1;
        if(level.teambased) {
          var_19 = maps\mp\gametypes\_gamescore::func_473F();
          if(maps\mp\_utility::isroundbased() || maps\mp\_utility::isobjectivebased()) {
            var_24 = maps\mp\_utility::getroundswon(var_15.team);
            var_25 = maps\mp\_utility::getroundswon(maps\mp\_utility::getotherteam(var_15.team));
            var_22 = maps\mp\_utility::getroundswon("allies");
            var_23 = maps\mp\_utility::getroundswon("axis");
            var_26 = maps\mp\gametypes\_gamescore::func_63E(var_15.team);
            var_27 = maps\mp\gametypes\_gamescore::func_63E(maps\mp\_utility::getotherteam(var_15.team));
          } else {
            var_24 = maps\mp\gametypes\_gamescore::func_63E(var_15.team);
            var_25 = maps\mp\gametypes\_gamescore::func_63E(maps\mp\_utility::getotherteam(var_15.team));
            var_22 = maps\mp\gametypes\_gamescore::func_63E("allies");
            var_23 = maps\mp\gametypes\_gamescore::func_63E("axis");
          }
        } else {
          var_28 = maps\mp\gametypes\_gamescore::func_450B(2);
          var_24 = var_15.score;
          if(var_28.size > 0 && var_28[0] != var_15) {
            var_25 = var_25;
          } else {
            var_25 = -1;
          }

          if(var_28.size > 0) {
            var_19 = var_28[0].name;
          } else {
            var_19 = "none";
          }
        }

        var_29 = maps\mp\_utility::getscorelimit(); var_2A = common_scripts\utility::func_98E7(var_24 > var_25, var_24, var_25);
        if(var_29 > 0) {
          var_2B = var_2A / var_29;
        } else {
          var_2B = -1;
        }

        var_18 = common_scripts\utility::func_98E7(isDefined(game["status"]), game["status"], "none"); var_16 = common_scripts\utility::func_98E7(isDefined(game["timePassed"]), game["timePassed"], -1); var_17 = maps\mp\gametypes\_gamelogic::func_46E5(); var_2C = 0;
        if(var_18 == "normal") {
          var_2C = 1;
        } else if(var_18 == "halfway") {
          var_2C = 2;
        }

        if(var_0B) {
          setspawndata("spawns", var_09, "matchInfo", "scoreAllies", maps\mp\_utility::clamptoshort(var_22));
          setspawndata("spawns", var_09, "matchInfo", "scoreAxis", maps\mp\_utility::clamptoshort(var_23));
          setspawndata("spawns", var_09, "matchInfo", "roundNum", maps\mp\_utility::func_2314(var_2C));
        }

        function_00F5("@"script_mp_spawndata_matchinfo: player_name % s, life_id % d, team % s, gameTime % d, timePassed % d, timeRemaining % d, gameStatus % s, winning_team % s, winning_score_perc % f, ally_score % d, enemy_score % d, ally_score_for_cur_round % d, enemy_score_for_cur_round % d, aliveCount % d, activeCount % d, joinCount % d, botJoinCount % d, spawnCount % d, deathCount % d, playlistName % s, qaPlayList % d ",var_15.name,var_15.var_5CC6,var_15.team,var_14,var_16,var_17,var_18,var_19,var_2B,var_24,var_25,var_26,var_27,var_1A,var_1B,var_1C,var_20,var_1D,var_21,var_1E,var_1F);
          if(isDefined(level.var_9068.var_9090)) {
            var_2D = 0;
            foreach(var_2F in level.var_9068.var_9090) {
              var_30 = var_2F.origin;
              var_31 = var_2F.var_9AB8;
              var_32 = var_2F.var_9AB7;
              var_33 = func_447B(var_2F.var_285B);
              var_34 = var_2F.var_2859;
              var_35 = var_2F.var_6221[maps\mp\_utility::getotherteam(var_15.team)];
              if(!isDefined(var_31)) {
                var_31 = -1;
              }

              if(!isDefined(var_32)) {
                var_32 = -1;
              }

              if(!isDefined(var_34)) {
                var_34 = -1;
              }

              if(!isDefined(var_35)) {
                var_35 = -1;
              }

              if(var_0B && var_2D < var_03) {
                setspawndata("spawns", var_09, "spawnPoints", var_2D, "position", 0, int(var_30[0]));
                setspawndata("spawns", var_09, "spawnPoints", var_2D, "position", 1, int(var_30[1]));
                setspawndata("spawns", var_09, "spawnPoints", var_2D, "position", 2, int(var_30[2]));
                setspawndata("spawns", var_09, "spawnPoints", var_2D, "scoreFactor", var_31);
                setspawndata("spawns", var_09, "spawnPoints", var_2D, "criticalFactorIndex", var_34);
                setspawndata("spawns", var_09, "spawnPoints", var_2D, "timeToLineOfSight", var_35);
              }

              function_00F6(var_30, "script_mp_spawndata_pointinfo: player_name %s, life_id %d, team %s, gameTime %d, scoreFactorsTotal %d, scoreFactorsPossibleTotal %d, criticalFactorsResult %d, criticalFactorIndex %d, ttlosValue %f", var_15.name, var_15.var_5CC6, var_15.team, var_14, var_31, var_32, var_33, var_34, var_35);
              var_2D++;
            }
          }

          var_15 func_5EA8(var_0B, var_09);
        }
      }

      func_5EA8(param_00, param_01) {
          var_02 = gettime();
          var_03 = level.var_90B4;
          var_04 = lib_050D::func_580F();
          var_05 = "_matchdata.gsc";
          var_06 = -1;
          var_07 = -1;
          var_08 = -1;
          var_09 = -1;
          var_0A = -1;
          var_0B = -1;
          var_0C = -1;
          var_0D = -1;
          var_0E = -1;
          var_0F = -1;
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
          var_1A = -1;
          if(isDefined(self.var_9070)) {
            if(isDefined(self.var_9070.var_9087)) {
              if(isDefined(self.var_9070.var_BD9)) {
                var_06 = self.var_9070.var_BD9;
              }

              if(isDefined(self.var_9070.var_6884)) {
                var_07 = self.var_9070.var_6884;
              }

              if(isDefined(self.var_9070.var_689C)) {
                var_1A = self.var_9070.var_689C;
              }

              if(isDefined(self.var_9070.var_9087.lastupdatetime)) {
                var_08 = self.var_9070.var_9087.lastupdatetime;
              }

              if(isDefined(self.var_9070.var_76E6) && isDefined(self.var_9070.var_76E6.origin)) {
                var_0D = distance2d(self.var_9092, self.var_9070.var_76E6.origin);
              }

              var_0E = getspawnpointmindist(self.var_9070.var_9087.index, self.team);
              if(!isDefined(var_0E) || var_0E > 15000) {
                var_0E = -1;
              }

              var_0F = getspawnpointmindist(self.var_9070.var_9087.index, maps\mp\_utility::getotherteam(self.team));
              if(!isDefined(var_0F) || var_0F > 15000) {
                var_0F = -1;
              }

              var_1B = getspawnpointtotalplayers(self.var_9070.var_9087.index, self.team);
              if(var_1B > 0) {
                var_10 = getspawnpointdistsum(self.var_9070.var_9087.index, self.team);
                if(!isDefined(var_10) || var_10 > 15000) {
                  var_10 = -1;
                } else {
                  var_10 = var_10 / var_1B;
                }
              }

              var_1C = getspawnpointtotalplayers(self.var_9070.var_9087.index, maps\mp\_utility::getotherteam(self.team));
              if(var_1C > 0) {
                var_11 = getspawnpointdistsum(self.var_9070.var_9087.index, maps\mp\_utility::getotherteam(self.team));
                if(!isDefined(var_11) || var_11 > 15000) {
                  var_11 = -1;
                } else {
                  var_11 = var_11 / var_1C;
                }
              }

              var_12 = getspawnpointnearbyfriendlies(self.var_9070.var_9087.index, self.team);
              var_13 = getspawnpointnearbyenemies(self.var_9070.var_9087.index, maps\mp\_utility::getotherteam(self.team));
              if(isDefined(self.var_9070.var_9087.var_2055) && self.var_9070.var_9087.var_2055) {
                var_17 = 1;
              } else {
                var_17 = 0;
              }

              if(isDefined(self.var_9070.var_90B3)) {
                if(isDefined(self.var_9070.var_90B3["primary"])) {
                  var_18 = self.var_9070.var_90B3["primary"];
                }

                if(isDefined(self.var_9070.var_90B3["secondary"])) {
                  var_19 = self.var_9070.var_90B3["secondary"];
                }
              }

              var_1D = lib_050C::func_3B91(self.team, self.var_9070.var_9087, 0);
              if(isDefined(var_1D)) {
                var_0B = sqrt(var_1D);
              }

              var_1E = lib_050C::func_3B92(self.team, self.var_9070.var_9087, 0);
              if(isDefined(var_1E)) {
                var_0C = sqrt(var_1E);
              }

              if(isDefined(self.lastattacker) && isDefined(self.lastattacker.origin)) {
                var_0A = distance2d(self.var_9070.var_9087.origin, self.lastattacker.origin);
              }

              if(isDefined(self.var_5B90)) {
                var_09 = distance2d(self.var_9070.var_9087.origin, self.var_5B90);
              }
            }
          }

          if(param_00) {
            setspawndata("spawns", param_01, "playerInfo", "lifeNum", self.var_5CC6);
            setspawndata("spawns", param_01, "playerInfo", "wasTacticalInsertion", self.var_A87A);
            setspawndata("spawns", param_01, "playerInfo", "team", self.team);
            setspawndata("spawns", param_01, "playerInfo", "spawnPos", 0, int(self.var_9092[0]));
            setspawndata("spawns", param_01, "playerInfo", "spawnPos", 1, int(self.var_9092[1]));
            setspawndata("spawns", param_01, "playerInfo", "spawnPos", 2, int(self.var_9092[2]));
          }

          switch (level.gametype) {
            case "conf":
            case "war":
              if(isDefined(level.var_6026) && isDefined(game["spawnClaimFlipCount"])) {
                var_1F = game["spawnClaimFlipCount"];
              } else {
                var_1F = -1;
              }

              if(param_00) {
                setspawndata("tdmSpawns", param_01, "numTimesSidesFlipped", maps\mp\_utility::clamptoshort(var_1F));
                setspawndata("tdmSpawns", param_01, "causedSidesToFlip", var_17);
              }

              var_20 = 0;
              var_21 = 0;
              var_22 = (-999999, -999999, -999999);
              var_23 = (-999999, -999999, -999999);
              var_24 = 0;
              var_25 = (-999999, -999999, -999999);
              var_26 = -999;
              var_27 = -1;
              var_28 = -1;
              var_29 = -1;
              var_2A = -1;
              var_2B = getdvarint("spawning_revised_frontline") != 0 && lib_050C::func_2936();
              if(var_2B) {
                var_2C = lib_050C::func_4500();
                if(isDefined(var_2C)) {
                  if(isDefined(var_2C.var_565F)) {
                    var_20 = var_2C.var_565F["allies"];
                    var_21 = var_2C.var_565F["axis"];
                    if(isDefined(var_2C.var_BF3)) {
                      var_22 = var_2C.var_BF3;
                    }

                    if(isDefined(var_2C.var_1479)) {
                      var_23 = var_2C.var_1479;
                    }

                    var_24 = var_20 && var_21 && isDefined(var_2C.var_BF3) && isDefined(var_2C.var_1479);
                    if(isDefined(var_2C.var_6162)) {
                      var_25 = var_2C.var_6162;
                    }

                    if(isDefined(var_2C.var_9851)) {
                      var_26 = var_2C.var_9851;
                    }

                    if(isDefined(var_2C.lastupdatetime)) {
                      var_27 = var_2C.lastupdatetime;
                    }

                    if(isDefined(var_2C.var_5C0A)) {
                      var_28 = var_2C.var_5C0A;
                    }

                    if(isDefined(var_2C.var_A1C7)) {
                      var_29 = var_2C.var_A1C7;
                    }

                    if(isDefined(var_2C.var_32D2)) {
                      var_2A = var_2C.var_32D2;
                    }
                  }
                }
              }

              function_00F5("@"script_mp_spawndata_info_tdm: player_name % s, life_id % d, team % s, gameTime % d, causedSpawnClaimsToFlip % d, spawnClaimsFlipCount % d, usingFrontline % b, frontlineActive % b, frontlineMidpoint % v, frontlineYaw % f, frontlineAlliesAverage % v, frontlineAxisAverage % v, frontlineActiveAllies % b, frontlineActiveAxis % b, frontlineLastUpdateTime % d, frontlineLastUpdateTimeDelta % d, frontlineUptime % d, frontlineDowntime % d ",self.name,self.var_5CC6,self.team,var_02,var_17,var_1F,var_2B,var_24,var_25,var_26,var_22,var_23,var_20,var_21,var_27,var_28,var_29,var_2A);
                  break;

                  case "hp":
                  var_2D = level.var_AC7C.origin; var_2E = distance2d(self.var_9092, var_2D); var_2F = level.var_AC7C.var_3FCA maps\mp\gametypes\_gameobjects::func_45F7();
                  if(var_2F == self.team) {
                    var_14 = var_2E;
                  } else if(var_2F == maps\mp\_utility::getotherteam(self.team)) {
                    var_15 = var_2E;
                  } else {
                    var_16 = var_2E;
                  }

                  if(isDefined(self.var_99DE)) {
                    var_30 = self.var_99DE;
                  } else {
                    var_30 = -1;
                  }

                  var_31 = self.pers["defends"];
                  if(isDefined(self.var_2EF1)) {
                    var_32 = self.var_2EF1;
                  } else {
                    var_32 = 0;
                  }

                  if(isDefined(self.var_5B90)) {
                    var_33 = distance2d(self.var_5B90, var_2D);
                  } else {
                    var_33 = -1;
                  }

                  if(param_00) {
                    setspawndata("hpSpawns", param_01, "timeInHardPoint", maps\mp\_utility::clamptoshort(var_30));
                    setspawndata("hpSpawns", param_01, "diedInHardPoint", var_32);
                    setspawndata("hpSpawns", param_01, "hpZoneInfo", "controllingTeam", func_46CA(var_2F));
                    setspawndata("hpSpawns", param_01, "hpZoneInfo", "position", 0, int(var_2D[0]));
                    setspawndata("hpSpawns", param_01, "hpZoneInfo", "position", 1, int(var_2D[1]));
                    setspawndata("hpSpawns", param_01, "hpZoneInfo", "position", 2, int(var_2D[2]));
                  }

                  function_00F5("script_mp_spawndata_info_hp: player_name %s, life_id %d, team %s, gameTime %d, hp_origin %v, hp_team %s, distToHP %f, diedInHP %b, distFromDeathToHP %f, time_in_hardpoint %d, defend_kills %d", self.name, self.var_5CC6, self.team, var_02, var_2D, var_2F, var_2E, var_32, var_33, var_30, var_31);
                  break;

                  case "control":
                  case "lockdown":
                  case "dom":
                  var_34 = "none"; var_35 = -1; var_36 = "none"; var_37 = -1; var_38 = 0; foreach(var_3A in level.var_3211) {
                    if(isDefined(self.var_5B90)) {
                      var_3B = distance2d(self.var_5B90, var_3A.var_28D4);
                      if(var_35 == -1 || var_3B < var_35) {
                        var_35 = var_3B;
                        var_34 = var_3A.label;
                      }
                    }

                    if(isDefined(self.var_9092)) {
                      var_3C = distance2d(self.var_9092, var_3A.var_28D4);
                      if(var_37 == -1 || var_3C < var_37) {
                        var_37 = var_3C;
                        var_36 = var_3A.label;
                      }

                      var_3D = var_3A maps\mp\gametypes\_gameobjects::func_45F7();
                      if(var_3D == self.team && var_14 == -1 || var_3C < var_14) {
                        var_14 = var_3C;
                      } else if(var_3D == maps\mp\_utility::getotherteam(self.team) && var_15 == -1 || var_3C < var_15) {
                        var_15 = var_3C;
                      } else if(var_16 == -1 || var_3C < var_16) {
                        var_16 = var_3C;
                      }

                      if(param_00 && var_38 < 3) {
                        setspawndata("domSpawns", param_01, "domFlagInfo", var_38, "flag", func_44A4(var_3A.label));
                        setspawndata("domSpawns", param_01, "domFlagInfo", var_38, "controllingTeam", func_46CA(var_3D));
                        setspawndata("domSpawns", param_01, "domFlagInfo", var_38, "position", 0, int(var_3A.var_28D4[0]));
                        setspawndata("domSpawns", param_01, "domFlagInfo", var_38, "position", 1, int(var_3A.var_28D4[1]));
                        setspawndata("domSpawns", param_01, "domFlagInfo", var_38, "position", 2, int(var_3A.var_28D4[2]));
                      }
                    }
                  }

                  var_3F = level.var_3211[0].var_A582[0].origin; var_40 = level.var_3211[0].var_6DB2; var_41 = level.var_3211[1].var_A582[0].origin; var_42 = level.var_3211[1].var_6DB2; var_43 = level.var_3211[2].var_A582[0].origin; var_44 = level.var_3211[2].var_6DB2; var_45 = var_14; var_46 = var_15; var_47 = var_16;
                  if(isDefined(self.var_9070) && isDefined(self.var_9070.var_9087) && isDefined(self.var_9070.var_9087.var_766F)) {
                    var_48 = self.var_9070.var_9087.var_766F;
                  } else {
                    var_48 = "none";
                  }

                  var_49 = self.pers["captures"]; var_31 = self.pers["defends"];
                  if(isDefined(self.var_2EF1)) {
                    var_4A = self.var_2EF1;
                  } else {
                    var_4A = 0;
                  }

                  if(param_00) {
                    setspawndata("domSpawns", param_01, "spawnFlag", func_44A4(var_48));
                    setspawndata("domSpawns", param_01, "nearestFlagOnSpawn", func_44A4(var_36));
                    setspawndata("domSpawns", param_01, "nearestFlagOnDeath", func_44A4(var_34));
                    setspawndata("domSpawns", param_01, "diedOnFlag", var_4A);
                  }

                  function_00F5("@"script_mp_spawndata_info_dom: player_name % s, life_id % d, team % s, gameTime % d, a_origin % v, a_owner % s, b_origin % v, b_owner % s, c_origin % v, c_owner % s, spawnFlag % s, nearestFlagOnSpawn % s, diedOnFlag % b, nearestFlagOnDeath % s, distToAllyFlagOnSpawn % f, distToEnemyFlagOnSpawn % f, distToNeutralFlagOnSpawn % f, captures % d, defend_kills % d ",self.name,self.var_5CC6,self.team,var_02,var_3F,var_40,var_41,var_42,var_43,var_44,var_48,var_36,var_4A,var_34,var_45,var_46,var_47,var_49,var_31);
                    break;

                    case "ctf":
                    if(isDefined(level.var_9853[self.team].var_2006)) {
                      var_16 = distance2d(self.var_9092, level.var_9853[self.team].var_2006.origin);
                    }

                    var_14 = distance2d(self.var_9092, level.var_9853[self.team].origin); var_15 = distance2d(self.var_9092, level.var_9853[maps\mp\_utility::getotherteam(self.team)].origin); var_4B = var_14; var_4C = var_15; var_4D = var_16; var_4E = level.var_9853["allies"]; var_4F = level.var_9853["axis"]; var_50 = var_4E.var_2006; var_51 = var_4F.var_2006; var_52 = undefined; var_53 = undefined;
                    if(!isDefined(var_50)) {
                      var_54 = "none";
                      var_55 = -1;
                      var_52 = var_4E.origin;
                    } else {
                      var_54 = var_52.name;
                      var_55 = var_51.clientid;
                      var_52 = var_50.origin;
                    }

                    if(!isDefined(var_51)) {
                      var_56 = "none";
                      var_57 = -1;
                      var_53 = var_4F.origin;
                    } else {
                      var_56 = var_53.name;
                      var_57 = var_52.clientid;
                      var_53 = var_51.origin;
                    }

                    var_49 = self.pers["captures"]; var_58 = self.pers["returns"]; var_31 = self.pers["defends"];
                    if(isDefined(self.var_2EF1)) {
                      var_59 = self.var_2EF1;
                    } else {
                      var_59 = 0;
                    }

                    if(param_00) {
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "team", "allies");
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "homePosition", 0, int(var_4E.origin[0]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "homePosition", 1, int(var_4E.origin[1]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "homePosition", 2, int(var_4E.origin[2]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "carrierID", var_55);
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "position", 0, int(var_52[0]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "position", 1, int(var_52[1]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 0, "position", 2, int(var_52[2]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "team", "axis");
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "homePosition", 0, int(var_4F.origin[0]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "homePosition", 1, int(var_4F.origin[1]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "homePosition", 2, int(var_4F.origin[2]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "carrierID", var_57);
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "position", 0, int(var_53[0]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "position", 1, int(var_53[1]));
                      setspawndata("ctfSpawns", param_01, "flagInfo", 1, "position", 2, int(var_53[2]));
                      setspawndata("ctfSpawns", param_01, "diedWithFlag", var_59);
                    }

                    function_00F5("@"script_mp_spawndata_info_ctf: player_name % s, life_id % d, team % s, gameTime % d, allies_flag_loc % v, allies_carrier % s, axis_flag_loc % v, axis_carrier % s, diedWtihFlag % b, distToAllyFlagBase % f, distToEnemyFlagBase % f, distToEnemyFlagCarrier % f, captures % d, returns % d, defend_kills % d ",self.name,self.var_5CC6,self.team,var_02,var_52,var_54,var_53,var_56,var_59,var_4B,var_4C,var_4D,var_49,var_58,var_31);
                      break;
                    }

                    function_00F6(self.var_9092, "@"script_mp_spawndata_spawninfo: player_name % s, life_id % d, life_index % d, was_tactical_insertion % b, team % s, gameTime % d, tuning_version % f, allBadSpawn % d, spawnTypePercPrimary % f, spawnTypePercSecondary % f, number_of_choices % d, distToNearestAlly % f, distToNearestEnemy % f, averageDistToAlly % f, averageDistToEnemy % f, numNearbyAllies % d, numNearbyEnemies % d, distToDeathLocation % f, distToLastAttacker % f, distToPrevSpawnLocation % f, distToNearestAllyDeathLocation % f, distToNearestEnemySpawnLocation % f ",self.name,self.var_5CC6,self.var_6870,self.var_A87A,self.team,var_02,var_03,var_06,var_18,var_19,var_07,var_0E,var_0F,var_10,var_11,var_12,var_13,var_09,var_0A,var_0D,var_0B,var_0C);
                      function_00F6(self.var_9092, "@"script_mp_playerspawn: player_name % s, life_id % d, life_index % d, was_tactical_insertion % b, team % s, gameTime % d, version % f, script_file % s, allBadSpawn % b, number_of_choices % d, last_update_time % d, distToPrevSpawnLocation % f, distToNearestFriendly % f, distToNearestEnemy % f, numNearbyFriendlies % d, numNearbyEnemies % d, distToNearestFriendlyObjective % f, distToNearestEnemyObjective % f, averageDistToFriendly % f, averageDistToEnemy % f, distToNearestNeutralObjective % f, causedSpawnClaimsToFlip % d, spawnTypePercPrimary % f, spawnTypePercSecondary % f, numSecondaryBetterThanTopPrimary % d, isTTLOSDataAvailable % d ",self.name,self.var_5CC6,self.var_6870,self.var_A87A,self.team,var_02,var_03,var_05,var_06,var_07,var_08,var_0D,var_0E,var_0F,var_12,var_13,var_14,var_15,var_10,var_11,var_16,var_17,var_18,var_19,var_1A,var_04);
                      }

                      func_5E90() {
                        var_00 = gettime();
                        var_01 = level.var_90B4;
                        var_02 = level.players.size;
                        var_03 = getmatchdata("match_common", "player_count");
                        var_04 = getmatchdata("match_common", "life_count");
                        var_05 = getmatchdata("match_common", "playlist_name");
                        var_06 = 0;
                        if(isDefined(var_05)) {
                          if(issubstr(var_05, "QA")) {
                            var_06 = 1;
                          }
                        }

                        if(!isDefined(level.var_6026)) {
                          var_07 = -1;
                          var_08 = -1;
                          var_09 = -1;
                          var_0A = -1;
                          var_0B = -1;
                          var_0C = -1;
                          var_0D = -1;
                          var_0E = -1;
                        } else {
                          if(isDefined(game["botJoinCount"])) {
                            var_07 = game["botJoinCount"];
                          } else {
                            var_07 = -1;
                          }

                          if(isDefined(game["deathCount"])) {
                            var_08 = game["deathCount"];
                          } else {
                            var_08 = -1;
                          }

                          if(isDefined(game["trapSpawnDiedTooFastCount"])) {
                            var_09 = game["trapSpawnDiedTooFastCount"];
                          } else {
                            var_09 = -1;
                          }

                          if(isDefined(game["trapSpawnKilledTooFastCount"])) {
                            var_0A = game["trapSpawnKilledTooFastCount"];
                          } else {
                            var_0A = -1;
                          }

                          if(isDefined(game["trapSpawnDmgDealtCount"])) {
                            var_0B = game["trapSpawnDmgDealtCount"];
                          } else {
                            var_0B = -1;
                          }

                          if(isDefined(game["trapSpawnDmgReceivedCount"])) {
                            var_0C = game["trapSpawnDmgReceivedCount"];
                          } else {
                            var_0C = -1;
                          }

                          if(isDefined(game["trapSpawnByAnyMeansCount"])) {
                            var_0D = game["trapSpawnByAnyMeansCount"];
                          } else {
                            var_0D = -1;
                          }

                          if(isDefined(game["objectiveFlipCount"])) {
                            var_0E = game["objectiveFlipCount"];
                          } else {
                            var_0E = -1;
                          }
                        }

                        var_0F = -1;
                        var_10 = -1;
                        if(level.teambased) {
                          var_11 = maps\mp\gametypes\_gamescore::func_473F();
                          if(maps\mp\_utility::isroundbased() || maps\mp\_utility::isobjectivebased()) {
                            var_0F = maps\mp\_utility::getroundswon("allies");
                            var_10 = maps\mp\_utility::getroundswon("axis");
                          } else {
                            var_0F = maps\mp\gametypes\_gamescore::func_63E("allies");
                            var_10 = maps\mp\gametypes\_gamescore::func_63E("axis");
                          }
                        } else {
                          var_12 = maps\mp\gametypes\_gamescore::func_450B(2);
                          if(isDefined(var_12[0])) {
                            var_0F = var_12[0].score;
                            var_11 = var_12[0].name;
                          } else {
                            var_11 = "none";
                          }

                          if(isDefined(var_12[1])) {
                            var_10 = var_12[1].score;
                          }
                        }

                        var_13 = maps\mp\_utility::getscorelimit();
                        var_14 = common_scripts\utility::func_98E7(var_0F > var_10, var_0F, var_10);
                        if(var_13 > 0) {
                          var_15 = var_14 / var_13;
                        } else {
                          var_15 = -1;
                        }

                        var_16 = common_scripts\utility::func_98E7(isDefined(game["status"]), game["status"], "none");
                        var_17 = common_scripts\utility::func_98E7(isDefined(game["timePassed"]), game["timePassed"], -1);
                        var_18 = maps\mp\gametypes\_gamelogic::func_46E5();
                        function_00F5("@"script_mp_spawndata_gameover: gameTime % d, tuning_version % f, timePassed % d, timeRemaining % d, gameStatus % s, winning_team % s, winning_score_perc % f, allies_score % d, axis_score % d, objectiveFlipCount % d, activeCount % d, joinCount % d, botJoinCount % d, spawnCount % d, deathCount % d, badSpawnByAnyMeansCount % d, victimSpawnDiedTooFastCount % d, victimSpawnKilledTooFastCount % d, immediateActionDmgDealtCount % d, immediateActionDmgReceivedCount % d, playlistName % s, qaPlayList % d ",var_00,var_01,var_17,var_18,var_16,var_11,var_15,var_0F,var_10,var_0E,var_02,var_03,var_07,var_04,var_08,var_0D,var_09,var_0A,var_0B,var_0C,var_05,var_06);
                          foreach(var_1A in level.players) {
                            if(isbot(var_1A) || istestclient(var_1A)) {
                              continue;
                            }

                            if(isDefined(var_1A.pers["team"])) {
                              var_1B = var_1A.pers["team"];
                            } else {
                              var_1B = "none";
                            }

                            if(isDefined(var_1A.pers["kills"])) {
                              var_1C = var_1A.pers["kills"];
                            } else {
                              var_1C = -1;
                            }

                            if(isDefined(var_1A.pers["deaths"])) {
                              var_1D = var_1A.pers["deaths"];
                            } else {
                              var_1D = -1;
                            }

                            var_04 = -1;
                            var_1E = -1;
                            var_1F = -1;
                            var_20 = -1;
                            var_21 = -1;
                            if(isDefined(var_1A.pers["spawnCount"])) {
                              var_04 = var_1A.pers["spawnCount"];
                            }

                            if(isDefined(var_1A.pers["immediateActionSpawnCount"])) {
                              var_1E = var_1A.pers["immediateActionSpawnCount"];
                            }

                            if(isDefined(var_1A.pers["victimSpawnCount"])) {
                              var_1F = var_1A.pers["victimSpawnCount"];
                            }

                            if(isDefined(var_1A.pers["causedImmediateActionSpawnCount"])) {
                              var_20 = var_1A.pers["causedImmediateActionSpawnCount"];
                            }

                            if(isDefined(var_1A.pers["causedVictimSpawnCount"])) {
                              var_21 = var_1A.pers["causedVictimSpawnCount"];
                            }

                            function_00F5("script_mp_spawndata_gameover_player: player_name %s, team %s, gameTime %d, kills %d, deaths %d, spawnCount %d, immediateActionSpawnCount %d, victimSpawnCount %d, causedImmediateActionSpawnCount %d, causedVictimSpawnCount %d", var_1A.name, var_1B, var_00, var_1C, var_1D, var_04, var_1E, var_1F, var_20, var_21);
                          }
                        }

                        func_7AF5(param_00) {
                            if(!isDefined(param_00.var_5BE1)) {
                              param_00.var_5BE1 = "none";
                            }

                            if(!isDefined(param_00.var_5BE2)) {
                              param_00.var_5BE2 = -1;
                            }

                            if(level.teambased) {
                              var_01 = param_00.var_3EFF["allies"];
                              var_02 = param_00.var_3EFF["axis"];
                              var_03 = param_00.var_266E["allies"];
                              var_04 = param_00.var_266E["axis"];
                              var_05 = getspawnpointmindist(param_00.index, "allies");
                              var_06 = getspawnpointmindist(param_00.index, "axis");
                            } else {
                              var_01 = var_06.var_3EFF["none"];
                              var_02 = -1;
                              var_03 = var_04.var_266E["none"];
                              var_04 = -1;
                              var_05 = getspawnpointmindist(var_02.index, "none");
                              var_06 = -1;
                            }

                            var_07 = -1;
                            var_08 = -1;
                            var_09 = -1;
                            var_0A = -1;
                            var_0B = -1;
                            var_0C = -1;
                            var_0D = -1;
                            var_0E = -1;
                            var_0F = -1;
                            var_10 = -1;
                            var_11 = -1;
                            var_12 = -1;
                            var_13 = -1;
                            var_14 = -1;
                            var_15 = -1;
                            var_16 = -1;
                            var_17 = "undefined";
                            if(isDefined(self.name)) {
                              var_17 = self.name;
                            }

                            var_18 = -1;
                            if(isDefined(self.var_5CC6)) {
                              var_18 = self.var_5CC6;
                            }

                            var_19 = "_spawnscoring.gsc";
                            var_1A = level.var_90B4;
                            var_1B = gettime();
                            var_1C = param_00.classname;
                            var_1D = param_00.var_9AB8;
                            var_1E = param_00.var_285B;
                            var_1F = param_00.var_6C97;
                            var_20 = "none";
                            if(isDefined(param_00.var_9849)) {
                              var_20 = param_00.var_9849;
                            }

                            if(isDefined(param_00.var_2B4F[0])) {
                              var_07 = param_00.var_2B4F[0];
                            }

                            if(isDefined(param_00.var_2B4F[1])) {
                              var_08 = param_00.var_2B4F[1];
                            }

                            if(isDefined(param_00.var_2B4F[2])) {
                              var_09 = param_00.var_2B4F[2];
                            }

                            if(isDefined(param_00.var_2B4F[3])) {
                              var_0A = param_00.var_2B4F[3];
                            }

                            if(isDefined(param_00.var_2B4F[4])) {
                              var_0B = param_00.var_2B4F[4];
                            }

                            if(isDefined(param_00.var_2B4F[5])) {
                              var_0C = param_00.var_2B4F[5];
                            }

                            if(isDefined(param_00.var_2B4F[6])) {
                              var_0D = param_00.var_2B4F[6];
                            }

                            if(isDefined(param_00.var_2B4F[7])) {
                              var_0E = param_00.var_2B4F[7];
                            }

                            if(isDefined(param_00.var_2B4F[8])) {
                              var_07 = param_00.var_2B4F[8];
                            }

                            if(isDefined(param_00.var_2B4F[9])) {
                              var_08 = param_00.var_2B4F[9];
                            }

                            if(isDefined(param_00.var_2B4F[10])) {
                              var_09 = param_00.var_2B4F[10];
                            }

                            if(isDefined(param_00.var_2B4F[11])) {
                              var_0A = param_00.var_2B4F[11];
                            }

                            if(isDefined(param_00.var_2B4F[12])) {
                              var_0B = param_00.var_2B4F[12];
                            }

                            if(isDefined(param_00.var_2B4F[13])) {
                              var_0C = param_00.var_2B4F[13];
                            }

                            if(isDefined(param_00.var_2B4F[14])) {
                              var_0D = param_00.var_2B4F[14];
                            }

                            if(isDefined(param_00.var_2B4F[15])) {
                              var_0E = param_00.var_2B4F[15];
                            }

                            var_21 = param_00.var_9AB7;
                            var_22 = -1;
                            var_23 = -1;
                            var_24 = -1;
                            var_25 = -1;
                            var_26 = -1;
                            var_27 = -1;
                            var_28 = -1;
                            var_29 = -1;
                            if(isDefined(param_00.var_2B5E[0])) {
                              var_22 = param_00.var_2B5E[0];
                            }

                            if(isDefined(param_00.var_2B5E[1])) {
                              var_23 = param_00.var_2B5E[1];
                            }

                            if(isDefined(param_00.var_2B5E[2])) {
                              var_24 = param_00.var_2B5E[2];
                            }

                            if(isDefined(param_00.var_2B5E[3])) {
                              var_25 = param_00.var_2B5E[3];
                            }

                            if(isDefined(param_00.var_2B5E[4])) {
                              var_26 = param_00.var_2B5E[4];
                            }

                            if(isDefined(param_00.var_2B5E[5])) {
                              var_27 = param_00.var_2B5E[5];
                            }

                            if(isDefined(param_00.var_2B5E[6])) {
                              var_28 = param_00.var_2B5E[6];
                            }

                            if(isDefined(param_00.var_2B5E[7])) {
                              var_29 = param_00.var_2B5E[7];
                            }

                            function_00F6(param_00.origin, "@"script_mp_spawnpoint_score: player_name % s, life_id % d, script_file % s, gameTime % d, classname % s, totalscore % d, totalPossibleScore % d, score_data0 % d, score_data1 % d, score_data2 % d, score_data3 % d, score_data4 % d, score_data5 % d, score_data6 % d, score_data7 % d, fullsights_allies % d, fullsights_axis % d, cornersights_allies % d, cornersights_axis % d, min_dist_allies % d, min_dist_axis % d, criticalResult % s, critical_data0 % d, critical_data1 % d, critical_data2 % d, critical_data3 % d, critical_data4 % d, critical_data5 % d, critical_data6 % d, critical_data7 % d, critical_data8 % d, critical_data9 % d, critical_data10 % d, critical_data11 % d, critical_data12 % d, critical_data13 % d, critical_data14 % d, critical_data15 % d, teamAssignment % s, outside % d, spawnVersion % f ",var_17,var_18,var_19,var_1B,var_1C,var_1D,var_21,var_22,var_23,var_24,var_25,var_26,var_27,var_28,var_29,var_01,var_02,var_03,var_04,var_05,var_06,var_1E,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_15,var_16,var_20,var_1F,var_1A);
                            }

                            func_447B(param_00) {
                              if(isDefined(param_00)) {
                                switch (param_00) {
                                  case "primary":
                                    return 1;

                                  case "secondary":
                                    return 2;

                                  case "bad":
                                    return 3;
                                }

                                return;
                              }

                              return -1;
                            }

                            func_44A4(param_00) {
                              switch (param_00) {
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

                            func_46CA(param_00) {
                              switch (param_00) {
                                case "none":
                                case "axis":
                                case "allies":
                                  return param_00;

                                case "neutral":
                                default:
                                  return "none";
                              }
                            }