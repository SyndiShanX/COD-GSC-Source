/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42913.gsc
**************************************/

init() {
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(level.multiteambased) {
    for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
      var_2 = "spawn_" + level.teamnamelist[var_1];
      var_3 = "defeat_" + level.teamnamelist[var_1];
      var_4 = "victory_" + level.teamnamelist[var_1];
      var_5 = "winning_" + level.teamnamelist[var_1];
      var_6 = "losing_" + level.teamnamelist[var_1];
      game["music"][var_2] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "spawn_music";
      game["music"][var_3] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "defeat_music";
      game["music"][var_4] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "victory_music";
      game["music"][var_5] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "winning_music";
      game["music"][var_6] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "losing_music";
      game["voice"][level.teamnamelist[var_1]] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "anr0_";
    }
  } else {
    game["music"]["spawn_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "spawn_music";
    game["music"]["defeat_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "defeat_music";
    game["music"]["victory_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "victory_music";
    game["music"]["winning_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "winning_music";
    game["music"]["losing_allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "losing_music";
    game["voice"]["allies"] = maps\mp\gametypes\_teams::getteamvoiceprefix("allies") + "anr0_";
    game["music"]["spawn_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "spawn_music";
    game["music"]["defeat_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "defeat_music";
    game["music"]["victory_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "victory_music";
    game["music"]["winning_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "winning_music";
    game["music"]["losing_axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "losing_music";
    game["voice"]["axis"] = maps\mp\gametypes\_teams::getteamvoiceprefix("axis") + "anr0_";
  }

  game["music"]["losing_time"] = "null";
  game["music"]["suspense"] = [];
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["music"]["suspense"][game["music"]["suspense"].size] = "null";
  game["dialog"]["mission_success"] = "gbl_win";
  game["dialog"]["mission_failure"] = "gbl_lost";
  game["dialog"]["mission_draw"] = "gbl_draw";
  game["dialog"]["round_success"] = "encourage_win";
  game["dialog"]["round_failure"] = "encourage_lost";
  game["dialog"]["round_draw"] = "draw";
  game["dialog"]["timesup"] = "timesup";
  game["dialog"]["winning_time"] = "gbl_winning";
  game["dialog"]["losing_time"] = "gbl_losing";
  game["dialog"]["winning_score"] = "gbl_winning";
  game["dialog"]["losing_score"] = "gbl_losing";
  game["dialog"]["lead_lost"] = "gbl_lead_lost";
  game["dialog"]["lead_tied"] = "tied";
  game["dialog"]["lead_taken"] = "gbl_lead_taken";
  game["dialog"]["last_alive"] = "gbl_lastman";
  game["dialog"]["boost"] = "gbl_start";

  if(!isDefined(game["dialog"]["offense_obj"])) {
    game["dialog"]["offense_obj"] = "boost";
  }

  if(!isDefined(game["dialog"]["defense_obj"])) {
    game["dialog"]["defense_obj"] = "boost";
  }

  game["dialog"]["hardcore"] = "hardcore";
  game["dialog"]["highspeed"] = "highspeed";
  game["dialog"]["tactical"] = "tactical";
  game["dialog"]["challenge"] = "challengecomplete";
  game["dialog"]["promotion"] = "promotion";
  game["dialog"]["bomb_taken"] = "acheive_bomb";
  game["dialog"]["bomb_lost"] = "bomb_taken";
  game["dialog"]["bomb_defused_attackers"] = "sd_enemydefused";
  game["dialog"]["bomb_defused_defenders"] = "sd_allydefused";
  game["dialog"]["bomb_planted"] = "sd_bombplanted";
  game["dialog"]["obj_taken"] = "securedobj";
  game["dialog"]["obj_lost"] = "lostobj";
  game["dialog"]["obj_defend"] = "gbl_defendobj";
  game["dialog"]["obj_destroy"] = "gbl_destroyobj";
  game["dialog"]["obj_capture"] = "gbl_secureobj";
  game["dialog"]["objs_capture"] = "gbl_secureobjs";
  game["dialog"]["move_to_new"] = "new_positions";
  game["dialog"]["push_forward"] = "gbl_rally";
  game["dialog"]["attack"] = "attack";
  game["dialog"]["defend"] = "defend";
  game["dialog"]["offense"] = "offense";
  game["dialog"]["defense"] = "defense";
  game["dialog"]["halftime"] = "gbl_halftime";
  game["dialog"]["overtime"] = "gbl_overtime";
  game["dialog"]["side_switch"] = "gbl_switchingsides";
  game["dialog"]["flag_taken"] = "ctf_retrieveflagally";
  game["dialog"]["enemy_flag_taken"] = "ctf_enemyflagacquired";
  game["dialog"]["flag_dropped"] = "ctf_enemydropflag";
  game["dialog"]["enemy_flag_dropped"] = "ctf_allydropflag";
  game["dialog"]["flag_returned"] = "ctf_allyflagback";
  game["dialog"]["enemy_flag_returned"] = "ctf_enemyflagback";
  game["dialog"]["flag_captured"] = "ctf_enemycapflag";
  game["dialog"]["enemy_flag_captured"] = "ctf_allycapflag";
  game["dialog"]["flag_getback"] = "ctf_retrieveflagally";
  game["dialog"]["enemy_flag_bringhome"] = "ctf_bringhomeflag";
  game["dialog"]["hp_online"] = "hpt_identified";
  game["dialog"]["hp_lost"] = "hpt_enemycap";
  game["dialog"]["hp_contested"] = "hpt_contested";
  game["dialog"]["hp_secured"] = "hpt_allyown";
  game["dialog"]["capturing_a"] = "dom_capa";
  game["dialog"]["capturing_b"] = "dom_capb";
  game["dialog"]["capturing_c"] = "dom_capc";
  game["dialog"]["captured_a"] = "dom_owna";
  game["dialog"]["captured_b"] = "dom_ownb";
  game["dialog"]["captured_c"] = "dom_ownc";
  game["dialog"]["securing_a"] = "dom_securinga";
  game["dialog"]["securing_b"] = "dom_securingb";
  game["dialog"]["securing_c"] = "dom_securingc";
  game["dialog"]["secured_a"] = "dom_secure_a";
  game["dialog"]["secured_b"] = "dom_secure_b";
  game["dialog"]["secured_c"] = "dom_secure_c";
  game["dialog"]["losing_a"] = "dom_enemycapa";
  game["dialog"]["losing_b"] = "dom_enemycapb";
  game["dialog"]["losing_c"] = "dom_enemycapc";
  game["dialog"]["lost_a"] = "dom_losta";
  game["dialog"]["lost_b"] = "dom_lostb";
  game["dialog"]["lost_c"] = "dom_lostc";
  game["dialog"]["enemy_taking_a"] = "dom_enemycapa";
  game["dialog"]["enemy_taking_b"] = "dom_enemycapb";
  game["dialog"]["enemy_taking_c"] = "dom_enemycapc";
  game["dialog"]["enemy_has_a"] = "dom_enemyowna";
  game["dialog"]["enemy_has_b"] = "dom_enemyownb";
  game["dialog"]["enemy_has_c"] = "dom_enemyownc";
  game["dialog"]["lost_all"] = "dom_enemyownall";
  game["dialog"]["secure_all"] = "dom_ownall";
  game["dialog"]["destroy_sentry"] = "ks_sentrygun_destroyed";
  game["music"]["nuke_music"] = "nuke_music";
  game["dialog"]["sentry_gone"] = "sentry_gone";
  game["dialog"]["sentry_destroyed"] = "sentry_destroyed";
  game["dialog"]["ti_gone"] = "ti_cancelled";
  game["dialog"]["ti_destroyed"] = "ti_blocked";
  game["dialog"]["ims_destroyed"] = "ims_destroyed";
  game["dialog"]["lbguard_destroyed"] = "lbguard_destroyed";
  game["dialog"]["ballistic_vest_destroyed"] = "ballistic_vest_destroyed";
  game["dialog"]["remote_sentry_destroyed"] = "remote_sentry_destroyed";
  game["dialog"]["sam_destroyed"] = "sam_destroyed";
  game["dialog"]["sam_gone"] = "sam_gone";
  game["dialog"]["claymore_destroyed"] = "null";
  game["dialog"]["mine_destroyed"] = "null";
  game["dialog"]["ti_destroyed"] = "gbl_tactinsertlost";
  game["dialog"]["lockouts"] = [];
  game["dialog"]["lockouts"]["ks_uav_allyuse"] = 6;
  level thread onplayerconnect();
  level thread onlastalive();
  level thread musiccontroller();
  level thread ongameended();
  level thread onroundswitch();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread finalkillcammusic();
  }
}

playpracticeroundmusicforactiveclients() {
  if(!isDefined(level.practiceroundmusicent)) {
    return;
  }
  level.practiceroundmusicent hide();

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    if(!isDefined(var_1.practiceroundmusicplaying) || !var_1.practiceroundmusicplaying) {
      continue;
    }
    if(maps\mp\_utility::isaigameparticipant(var_1)) {
      continue;
    }
    level.practiceroundmusicent showtoplayer(var_1);
  }
}

practiceroundmusic() {
  self endon("disconnect");

  if(maps\mp\_utility::isaigameparticipant(self)) {
    return;
  }
  if(isDefined(level.practiceroundmusicending) && level.practiceroundmusicending) {
    return;
  }
  if(isDefined(self.practiceroundmusicstarted) && self.practiceroundmusicstarted) {
    return;
  } else {
    self.practiceroundmusicstarted = 1;
  }

  if(!isDefined(level.practiceroundmusicent)) {
    if(!soundexists("mus_practice_round_backing_track")) {
      return;
    }
    level.practiceroundmusicent = spawn("script_origin", (0, 0, 0));
    level.practiceroundmusicent endon("death");
    level endon("practiceRoundMusicEnding");
    level thread endpracticeroundmusic();
    level.practiceroundmusicent hide();
    wait 12;
    self.practiceroundmusicplaying = 1;
    level.practiceroundmusicent playLoopSound("mus_practice_round_backing_track");
    playpracticeroundmusicforactiveclients();
    level.practiceroundmusicent showtoplayer(self);
    level.practiceroundmusicent scalevolume(0, 0.05);
    wait 0.8;
    level.practiceroundmusicent scalevolume(0.8, 2.5);
  } else {
    playpracticeroundmusicforactiveclients();
    level.practiceroundmusicent endon("death");
    level endon("practiceRoundMusicEnding");
    wait 12;
    self.practiceroundmusicplaying = 1;
    level.practiceroundmusicent showtoplayer(self);
  }
}

endpracticeroundmusic() {
  level.practiceroundmusicent endon("death");

  while(game["state"] == "playing") {
    if(!level.timerstopped && maps\mp\_utility::gettimelimit()) {
      var_0 = maps\mp\gametypes\_gamelogic::gettimeremaining() / 1000;
      var_1 = int(var_0 + 0.5);

      if(var_1 <= 10) {
        break;
      }

      if(var_0 - floor(var_0) >= 0.05) {
        wait(var_0 - floor(var_0));
      }
    }

    wait 1.0;
  }

  level notify("practiceRoundMusicEnding");
  level.practiceroundmusicending = 1;
  level.practiceroundmusicent scalevolume(0, 5);
  wait 5.5;
  level.practiceroundmusicent stopsounds();
  level.practiceroundmusicent delete();
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");

  if(getDvar("virtuallobbyactive") == "0") {
    if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        self playlocalsound(game["music"]["spawn_" + self.team]);
      }

      if(level.splitscreen) {
        level.playedstartingmusic = 1;
      }
    }

    if(maps\mp\_utility::practiceroundgame()) {
      thread practiceroundmusic();
    }

    if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
      if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies") {
        maps\mp\_utility::leaderdialogonplayer("allies_gametype");
      } else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis") {
        maps\mp\_utility::leaderdialogonplayer("axis_gametype");
      } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        maps\mp\_utility::leaderdialogonplayer("gametype");
      }
    }

    maps\mp\_utility::gameflagwait("prematch_done");

    if(self.team == game["attackers"]) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
        maps\mp\_utility::leaderdialogonplayer("offense_obj", "introboost");
      }
    } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary()) {
      maps\mp\_utility::leaderdialogonplayer("defense_obj", "introboost");
    }
  }
}

onlastalive() {
  level endon("game_ended");
  level waittill("last_alive", var_0);

  if(!isalive(var_0)) {
    return;
  }
  var_0 maps\mp\_utility::leaderdialogonplayer("last_alive");
}

onroundswitch() {
  level waittill("round_switch", var_0);

  switch (var_0) {
    case "halftime":
      foreach(var_2 in level.players) {
        if(var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary()) {
          continue;
        }
        var_2 maps\mp\_utility::leaderdialogonplayer("halftime");
      }

      break;
    case "overtime":
      foreach(var_2 in level.players) {
        if(var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary()) {
          continue;
        }
        var_2 maps\mp\_utility::leaderdialogonplayer("overtime");
      }

      break;
    default:
      foreach(var_2 in level.players) {
        if(var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary()) {
          continue;
        }
        var_2 maps\mp\_utility::leaderdialogonplayer("side_switch");
      }

      break;
  }
}

ongameended() {
  level thread roundwinnerdialog();
  level thread gamewinnerdialog();
  level waittill("game_win", var_0);

  if(level.teambased) {
    if(level.splitscreen) {
      if(var_0 == "allies") {
        maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
      } else if(var_0 == "axis") {
        maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
      } else {
        maps\mp\_utility::playsoundonplayers(game["music"]["nuke_music"]);
      }
    } else if(var_0 == "allies") {
      maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
      maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"], "axis");
    } else if(var_0 == "axis") {
      maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
      maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"], "allies");
    } else {
      maps\mp\_utility::playsoundonplayers(game["music"]["nuke_music"]);
    }
  } else {
    foreach(var_2 in level.players) {
      if(var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary()) {
        continue;
      }
      if(var_2.pers["team"] != "allies" && var_2.pers["team"] != "axis") {
        var_2 playlocalsound(game["music"]["nuke_music"]);
        continue;
      }

      if(isDefined(var_0) && isPlayer(var_0) && var_2 == var_0) {
        var_2 playlocalsound(game["music"]["victory_" + var_2.pers["team"]]);
        continue;
      }

      if(!level.splitscreen) {
        var_2 playlocalsound(game["music"]["defeat_" + var_2.pers["team"]]);
      }
    }
  }
}

roundwinnerdialog() {
  level waittill("round_win", var_0);
  var_1 = level.roundenddelay / 4;

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(var_0) || isPlayer(var_0)) {
    return;
  }
  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }
  if(var_0 == "allies") {
    maps\mp\_utility::leaderdialog("round_success", "allies");
    maps\mp\_utility::leaderdialog("round_failure", "axis");
  } else if(var_0 == "axis") {
    maps\mp\_utility::leaderdialog("round_success", "axis");
    maps\mp\_utility::leaderdialog("round_failure", "allies");
  } else {}
}

gamewinnerdialog() {
  level waittill("game_win", var_0);
  var_1 = level.postroundtime / 2;

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(var_0) || isPlayer(var_0)) {
    return;
  }
  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }
  if(var_0 == "allies") {
    maps\mp\_utility::leaderdialog("mission_success", "allies");
    maps\mp\_utility::leaderdialog("mission_failure", "axis");
  } else if(var_0 == "axis") {
    if(isDefined(level.ishorde)) {
      [[level.hordevomissionfail]]();
    } else {
      maps\mp\_utility::leaderdialog("mission_success", "axis");
      maps\mp\_utility::leaderdialog("mission_failure", "allies");
    }
  } else {
    maps\mp\_utility::leaderdialog("mission_draw");
    return;
  }
}

musiccontroller() {
  level endon("game_ended");

  if(!level.hardcoremode && getDvar("virtualLobbyActive") == "0") {
    thread suspensemusic();
  }

  level waittill("match_ending_soon", var_0);

  if(maps\mp\_utility::getwatcheddvar("roundlimit") == 1 || game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("roundlimit") - 1) {
    if(!level.splitscreen) {
      if(var_0 == "time") {
        if(level.teambased) {
          if(maps\mp\_utility::practiceroundgame()) {
            maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"]);
            maps\mp\_utility::leaderdialog("winning_time");
          } else if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(!level.hardcoremode) {
              maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"], "allies");
              maps\mp\_utility::playsoundonplayers(game["music"]["losing_axis"], "axis");
            }

            maps\mp\_utility::leaderdialog("winning_time", "allies");
            maps\mp\_utility::leaderdialog("losing_time", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(!level.hardcoremode) {
              maps\mp\_utility::playsoundonplayers(game["music"]["winning_axis"], "axis");
              maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"], "allies");
            }

            maps\mp\_utility::leaderdialog("winning_time", "axis");
            maps\mp\_utility::leaderdialog("losing_time", "allies");
          }
        } else {
          if(!level.hardcoremode) {
            maps\mp\_utility::playsoundonplayers(game["music"]["losing_time"]);
          }

          maps\mp\_utility::leaderdialog("timesup");
        }
      } else if(var_0 == "score") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(!level.hardcoremode) {
              maps\mp\_utility::playsoundonplayers(game["music"]["winning_allies"], "allies");
              maps\mp\_utility::playsoundonplayers(game["music"]["losing_axis"], "axis");
            }

            maps\mp\_utility::leaderdialog("winning_score", "allies");
            maps\mp\_utility::leaderdialog("losing_score", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(!level.hardcoremode) {
              maps\mp\_utility::playsoundonplayers(game["music"]["winning_axis"], "axis");
              maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"], "allies");
            }

            maps\mp\_utility::leaderdialog("winning_score", "axis");
            maps\mp\_utility::leaderdialog("losing_score", "allies");
          }
        } else {
          var_1 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
          var_2 = maps\mp\gametypes\_gamescore::getlosingplayers();
          var_3[0] = var_1;

          if(!level.hardcoremode) {
            var_1 playlocalsound(game["music"]["winning_" + var_1.pers["team"]]);

            foreach(var_5 in level.players) {
              if(var_5 == var_1) {
                continue;
              }
              var_5 playlocalsound(game["music"]["losing_" + var_5.pers["team"]]);
            }
          }

          var_1 maps\mp\_utility::leaderdialogonplayer("winning_score");
          maps\mp\_utility::leaderdialogonplayers("losing_score", var_2);
        }
      }

      level waittill("match_ending_very_soon");
      maps\mp\_utility::leaderdialog("timesup");
    }
  } else {
    if(!level.hardcoremode) {
      maps\mp\_utility::playsoundonplayers(game["music"]["losing_allies"]);
    }

    maps\mp\_utility::leaderdialog("timesup");
  }
}

suspensemusic() {
  level endon("game_ended");
  level endon("match_ending_soon");
  var_0 = game["music"]["suspense"].size;
  wait 120;

  for(;;) {
    wait(randomfloatrange(60, 120));
    maps\mp\_utility::playsoundonplayers(game["music"]["suspense"][randomint(var_0)]);
  }
}

finalkillcammusic() {
  self waittill("showing_final_killcam");
}