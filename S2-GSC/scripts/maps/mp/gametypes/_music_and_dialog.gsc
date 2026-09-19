/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_music_and_dialog.gsc
***********************************************************/

init() {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(level._id_6520) {
    for(var_1 = 0; var_1 < level._id_985B.size; var_1++) {
      var_2 = "spawn_" + level._id_985B[var_1];
      var_3 = "defeat_" + level._id_985B[var_1];
      var_4 = "victory_" + level._id_985B[var_1];
      var_5 = "winning_" + level._id_985B[var_1];
      var_6 = "losing_" + level._id_985B[var_1];
      game["music"][var_2] = _id_0510::_id_46D9("allies") + "spawn_music";
      game["music"][var_3] = _id_0510::_id_46D9("allies") + "defeat_music";
      game["music"][var_4] = _id_0510::_id_46D9("allies") + "victory_music";
      game["music"][var_5] = _id_0510::_id_46D9("allies") + "winning_music";
      game["music"][var_6] = _id_0510::_id_46D9("allies") + "losing_music";
      game["voice"][level._id_985B[var_1]] = _id_0510::_id_46D9("allies") + "anr0_";
    }
  } else {
    game["music"]["spawn_allies"] = _id_0510::_id_46D9("allies") + "spawn_music";
    game["music"]["defeat_allies"] = _id_0510::_id_46D9("allies") + "defeat_music";
    game["music"]["victory_allies"] = _id_0510::_id_46D9("allies") + "victory_music";
    game["music"]["winning_allies"] = _id_0510::_id_46D9("allies") + "winning_music";
    game["music"]["losing_allies"] = _id_0510::_id_46D9("allies") + "losing_music";
    game["voice"]["allies"] = _id_0510::_id_46D9("allies") + "anr0_";
    game["music"]["spawn_axis"] = _id_0510::_id_46D9("axis") + "spawn_music";
    game["music"]["defeat_axis"] = _id_0510::_id_46D9("axis") + "defeat_music";
    game["music"]["victory_axis"] = _id_0510::_id_46D9("axis") + "victory_music";
    game["music"]["winning_axis"] = _id_0510::_id_46D9("axis") + "winning_music";
    game["music"]["losing_axis"] = _id_0510::_id_46D9("axis") + "losing_music";
    game["voice"]["axis"] = _id_0510::_id_46D9("axis") + "anr0_";
    game["music"]["match_ending_soon"] = "match_ending_soon";
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

  if(!isDefined(game["dialog"]["offense_obj"]))
    game["dialog"]["offense_obj"] = "boost";

  if(!isDefined(game["dialog"]["defense_obj"]))
    game["dialog"]["defense_obj"] = "boost";

  game["dialog"]["hardcore"] = "hardcore";
  game["dialog"]["highspeed"] = "highspeed";
  game["dialog"]["tactical"] = "tactical";
  game["dialog"]["challenge"] = "challengecomplete";
  game["dialog"]["promotion"] = "promotion";
  game["dialog"]["bomb_taken"] = "sd_ownbomb";
  game["dialog"]["bomb_lost"] = "sd_bombdropped";
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
  game["music"]["halftime_allies"] = "halftime_allies";
  game["music"]["halftime_axis"] = "halftime_axis";
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
  game["dialog"]["ffa_win"] = "ffa_win";
  game["dialog"]["ffa_lost"] = "ffa_lost";
  game["dialog"]["capturing_a"] = "dom_capa";
  game["dialog"]["capturing_b"] = "dom_capb";
  game["dialog"]["capturing_c"] = "dom_capc";
  game["dialog"]["capturing_d"] = "dom_capb";
  game["dialog"]["capturing_e"] = "dom_capc";
  game["dialog"]["captured_a"] = "dom_owna";
  game["dialog"]["captured_b"] = "dom_ownb";
  game["dialog"]["captured_c"] = "dom_ownc";
  game["dialog"]["captured_d"] = "dom_ownb";
  game["dialog"]["captured_e"] = "dom_ownc";
  game["dialog"]["enemy_taking_a"] = "dom_enemycapa";
  game["dialog"]["enemy_taking_b"] = "dom_enemycapb";
  game["dialog"]["enemy_taking_c"] = "dom_enemycapc";
  game["dialog"]["enemy_taking_d"] = "dom_enemycapb";
  game["dialog"]["enemy_taking_e"] = "dom_enemycapc";
  game["dialog"]["securing_a"] = "dom_securinga";
  game["dialog"]["securing_b"] = "dom_securingb";
  game["dialog"]["securing_c"] = "dom_securingc";
  game["dialog"]["securing_d"] = "dom_securingb";
  game["dialog"]["securing_e"] = "dom_securingc";
  game["dialog"]["secured_a"] = "dom_secure_a";
  game["dialog"]["secured_b"] = "dom_secure_b";
  game["dialog"]["secured_c"] = "dom_secure_c";
  game["dialog"]["secured_d"] = "dom_secure_b";
  game["dialog"]["secured_e"] = "dom_secure_c";
  game["dialog"]["losing_a"] = "dom_enemycapa";
  game["dialog"]["losing_b"] = "dom_enemycapb";
  game["dialog"]["losing_c"] = "dom_enemycapc";
  game["dialog"]["losing_d"] = "dom_enemycapb";
  game["dialog"]["losing_e"] = "dom_enemycapc";
  game["dialog"]["lost_a"] = "dom_losta";
  game["dialog"]["lost_b"] = "dom_lostb";
  game["dialog"]["lost_c"] = "dom_lostc";
  game["dialog"]["lost_d"] = "dom_lostb";
  game["dialog"]["lost_e"] = "dom_lostc";
  game["dialog"]["enemy_has_a"] = "dom_enemyowna";
  game["dialog"]["enemy_has_b"] = "dom_enemyownb";
  game["dialog"]["enemy_has_c"] = "dom_enemyownc";
  game["dialog"]["enemy_has_d"] = "dom_enemyownb";
  game["dialog"]["enemy_has_e"] = "dom_enemyownc";
  game["dialog"]["lost_all"] = "dom_enemyownall";
  game["dialog"]["secure_all"] = "dom_ownall";
  game["dialog"]["destroy_sentry"] = "ks_sentrygun_destroyed";
  game["music"]["nuke_music"] = "nuke_music";
  game["music"]["draw_allies"] = "draw_allies";
  game["music"]["draw_axis"] = "draw_axis";
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
  game["dialog"]["uav_destroyed"] = "ss_reconplane_destroyed";
  game["dialog"]["cuav_destroyed"] = "ss_counterint_destroyed";
  game["dialog"]["fighter_destroyed"] = "ss_fighterstraff_destroyed";
  game["dialog"]["uav_ended"] = "ss_reconplane_ended";
  game["dialog"]["cuav_ended"] = "ss_counterint_ended";
  game["dialog"]["planegun_ended"] = "ss_planegun_ended";
  game["dialog"]["planegun_destroyed"] = "ss_planegun_destroyed";
  game["dialog"]["planegun_bailout"] = "ss_planegun_bailout";
  game["dialog"]["cpkg_destroyed"] = "ss_cpkg_destroyed";
  level thread onplayerconnect();
  level thread _id_6B4C();
  level thread _id_65BC();
  level thread _id_6B3E();
  level thread _id_6B99();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
    var_0 thread _id_3B5D();
  }
}

_id_74CF() {
  if(!isDefined(level._id_7622)) {
    return;
  }
  level._id_7622 hide();

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    if(!isDefined(var_1._id_7623) || !var_1._id_7623) {
      continue;
    }
    if(maps\mp\_utility::_id_5666(var_1)) {
      continue;
    }
    level._id_7622 showtoplayer(var_1);
  }
}

init_end_game_music_ent() {
  if(!level.hardcoremode) {
    if(!isDefined(level.end_game_music_ent))
      level.end_game_music_ent = spawn("script_origin", (0, 0, 0));
  }
}

end_game_music_ent_origin_update(var_0) {
  if(isDefined(level.end_game_music_ent))
    level.end_game_music_ent.origin = var_0;
}

play_end_game_music(var_0) {
  if(isDefined(level.end_game_music_ent))
    level.end_game_music_ent playSound(var_0);
}

stop_end_game_music() {
  if(isDefined(level.end_game_music_ent)) {
    level.end_game_music_ent scalevolume(0, 1);
    wait 5.5;
    level.end_game_music_ent stopsounds();
    level.end_game_music_ent delete();
  }
}

_id_7620() {
  self endon("disconnect");

  if(maps\mp\_utility::_id_5666(self)) {
    return;
  }
  if(isDefined(level._id_7621) && level._id_7621) {
    return;
  }
  if(isDefined(self._id_7624) && self._id_7624)
    return;
  else
    self._id_7624 = 1;

  if(!isDefined(level._id_7622)) {
    if(!_soundexists("mus_practice_round_backing_track")) {
      return;
    }
    level._id_7622 = spawn("script_origin", (0, 0, 0));
    level._id_7622 endon("death");
    level endon("practiceRoundMusicEnding");
    level thread _id_36E0();
    level._id_7622 hide();
    wait 12;
    self._id_7623 = 1;
    level._id_7622 playloopsound("mus_practice_round_backing_track");
    _id_74CF();
    level._id_7622 showtoplayer(self);
    level._id_7622 scalevolume(0, 0.05);
    wait 0.8;
    level._id_7622 scalevolume(0.8, 2.5);
  } else {
    _id_74CF();
    level._id_7622 endon("death");
    level endon("practiceRoundMusicEnding");
    wait 12;
    self._id_7623 = 1;
    level._id_7622 showtoplayer(self);
  }
}

_id_36E0() {
  level._id_7622 endon("death");

  while(game["state"] == "playing") {
    if(!level.timerstopped && maps\mp\_utility::gettimelimit()) {
      var_0 = maps\mp\gametypes\_gamelogic::_id_46E5() / 1000;
      var_1 = int(var_0 + 0.5);

      if(var_1 <= 10) {
        break;
      }

      if(var_0 - _floor(var_0) >= 0.05)
        wait(var_0 - _floor(var_0));
    }

    wait 1.0;
  }

  level notify("practiceRoundMusicEnding");
  level._id_7621 = 1;
  level._id_7622 scalevolume(0, 5);
  wait 5.5;
  level._id_7622 stopsounds();
  level._id_7622 delete();
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");

  if(getDvar("4017") == "0" && !_func_367()) {
    if(!level.splitscreen || level.splitscreen && !isDefined(level._id_7217)) {
      if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        self playlocalsound(game["music"]["spawn_" + self.team]);

      if(level.splitscreen)
        level._id_7217 = 1;
    }

    if(maps\mp\_utility::_id_761E())
      thread _id_7620();

    if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
      if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies")
        maps\mp\_utility::leaderdialogonplayer("allies_gametype");
      else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis")
        maps\mp\_utility::leaderdialogonplayer("axis_gametype");
      else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        maps\mp\_utility::leaderdialogonplayer("gametype");
    }

    if(isDefined(level._id_2EC3))
      self[[level._id_2EC3]]();
    else {
      wait 5;
      maps\mp\_utility::gameflagwait("prematch_done");

      if(self.team == game["attackers"]) {
        if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
          maps\mp\_utility::leaderdialogonplayer("offense_obj", "introboost");
      } else if(!self issplitscreenplayer() || self issplitscreenplayerprimary())
        maps\mp\_utility::leaderdialogonplayer("defense_obj", "introboost");
    }
  }
}

_id_6B4C() {
  level endon("game_ended");
  level waittill("last_alive", var_0);

  if(!isalive(var_0)) {
    return;
  }
  var_0 maps\mp\_utility::leaderdialogonplayer("last_alive");
}

_id_6B99() {
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

_id_6B3E() {
  level thread _id_7F2E();
  level thread _id_3FE1();
  level waittill("game_win", var_0);
  thread stop_end_game_music();

  if(level.teambased) {
    if(level.splitscreen) {
      if(var_0 == "allies")
        maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
      else if(var_0 == "axis")
        maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
      else {
        maps\mp\_utility::playsoundonplayers(game["music"]["draw_allies"], "allies");
        maps\mp\_utility::playsoundonplayers(game["music"]["draw_axis"], "axis");
      }
    } else if(var_0 == "allies") {
      maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
      maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"], "axis");
    } else if(var_0 == "axis") {
      maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
      maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"], "allies");
    } else {
      maps\mp\_utility::playsoundonplayers(game["music"]["draw_allies"], "allies");
      maps\mp\_utility::playsoundonplayers(game["music"]["draw_axis"], "axis");
    }
  } else {
    foreach(var_2 in level.players) {
      if(var_2 issplitscreenplayer() && !var_2 issplitscreenplayerprimary()) {
        continue;
      }
      if(var_2.pers["team"] != "allies" && var_2.pers["team"] != "axis") {
        var_2 playlocalsound(game["music"]["draw_allies"]);
        continue;
      }

      if(isDefined(var_0) && isPlayer(var_0) && var_2 == var_0) {
        var_2 playlocalsound(game["music"]["victory_" + var_2.pers["team"]]);
        continue;
      }

      if(!level.splitscreen)
        var_2 playlocalsound(game["music"]["defeat_" + var_2.pers["team"]]);
    }
  }
}

_id_7F2E() {
  level waittill("round_win", var_0);
  var_1 = level._id_7F16 / 4;

  if(var_1 > 0)
    wait(var_1);

  if(maps\mp\_utility::isprophuntgametype())
    thread stop_end_game_music();

  if(!isDefined(var_0) || isPlayer(var_0)) {
    maps\mp\_utility::playsoundonplayers(game["music"]["draw_allies"], "allies");
    maps\mp\_utility::playsoundonplayers(game["music"]["draw_axis"], "axis");
  } else {
    if(maps\mp\_utility::_id_761E()) {
      return;
    }
    if(var_0 == "allies") {
      maps\mp\_utility::leaderdialog("round_success", "allies");
      maps\mp\_utility::leaderdialog("round_failure", "axis");
      maps\mp\_utility::playsoundonplayers(game["music"]["victory_allies"], "allies");
      maps\mp\_utility::playsoundonplayers(game["music"]["defeat_axis"], "axis");
    } else if(var_0 == "axis") {
      maps\mp\_utility::leaderdialog("round_success", "axis");
      maps\mp\_utility::leaderdialog("round_failure", "allies");
      maps\mp\_utility::playsoundonplayers(game["music"]["victory_axis"], "axis");
      maps\mp\_utility::playsoundonplayers(game["music"]["defeat_allies"], "allies");
    }
  }
}

_id_3FE1() {
  level waittill("game_win", var_0);
  var_1 = level._id_75EE / 2;

  if(var_1 > 0)
    wait(var_1);

  if(!level.teambased && isDefined(var_0) && isPlayer(var_0)) {
    var_2 = [var_0];
    var_3 = [];

    foreach(var_5 in level.players) {
      if(var_5 == var_0)
        continue;
      else
        var_3[var_3.size] = var_5;
    }

    maps\mp\_utility::leaderdialog("ffa_win", "allies", undefined, var_3);
    maps\mp\_utility::leaderdialog("ffa_lost", "allies", undefined, var_2);
  }

  if(!isDefined(var_0) || isPlayer(var_0)) {
    return;
  }
  if(maps\mp\_utility::_id_761E()) {
    return;
  }
  if(var_0 == "allies") {
    maps\mp\_utility::leaderdialog("mission_success", "allies");
    maps\mp\_utility::leaderdialog("mission_failure", "axis");
  } else if(var_0 == "axis") {
    maps\mp\_utility::leaderdialog("mission_success", "axis");
    maps\mp\_utility::leaderdialog("mission_failure", "allies");
  } else {
    maps\mp\_utility::leaderdialog("mission_draw");
    return;
  }
}

_id_65BC() {
  level endon("game_ended");
  init_end_game_music_ent();
  level waittill("match_ending_soon", var_0);

  if(var_0 == "time") {
    if(level.teambased) {
      if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
        maps\mp\_utility::leaderdialog("winning_time", "allies");
        maps\mp\_utility::leaderdialog("losing_time", "axis");
      } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        maps\mp\_utility::leaderdialog("winning_time", "axis");
        maps\mp\_utility::leaderdialog("losing_time", "allies");
      }
    } else
      maps\mp\_utility::leaderdialog("timesup");
  } else if(var_0 == "score") {
    if(level.teambased) {
      if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
        maps\mp\_utility::leaderdialog("winning_score", "allies");
        maps\mp\_utility::leaderdialog("losing_score", "axis");
      } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        maps\mp\_utility::leaderdialog("winning_score", "axis");
        maps\mp\_utility::leaderdialog("losing_score", "allies");
      }
    } else {
      var_1 = _id_04D2::_id_450A();
      var_2 = _id_04D2::_id_4568();
      var_1 maps\mp\_utility::leaderdialogonplayer("winning_score");
      maps\mp\_utility::leaderdialogonplayers("losing_score", var_2);
    }
  }

  if(!level.hardcoremode && !maps\mp\_utility::_id_579B() && !maps\mp\_utility::_id_585F() && getdvarint("enable_end_game_music", 1) && !maps\mp\_utility::_id_56B1())
    play_end_game_music(game["music"]["match_ending_soon"]);

  level waittill("match_ending_very_soon");
  maps\mp\_utility::leaderdialog("timesup");
}

_id_9528() {
  level endon("game_ended");
  level endon("match_ending_soon");
  var_0 = game["music"]["suspense"].size;
  wait 120;

  for(;;) {
    wait(_randomfloatrange(60, 120));
    maps\mp\_utility::playsoundonplayers(game["music"]["suspense"][randomint(var_0)]);
  }
}

_id_3B5D() {
  self waittill("showing_final_killcam");
}