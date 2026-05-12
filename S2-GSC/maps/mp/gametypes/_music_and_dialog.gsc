/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_music_and_dialog.gsc
***************************************************/

func_00D5() {
  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  if(level.var_6520) {
    for(var_01 = 0; var_01 < level.var_985B.size; var_01++) {
      var_02 = "spawn_" + level.var_985B[var_01];
      var_03 = "defeat_" + level.var_985B[var_01];
      var_04 = "victory_" + level.var_985B[var_01];
      var_05 = "winning_" + level.var_985B[var_01];
      var_06 = "losing_" + level.var_985B[var_01];
      game["music"][var_02] = maps\mp\gametypes\_teams::func_46D9("allies") + "spawn_music";
      game["music"][var_03] = maps\mp\gametypes\_teams::func_46D9("allies") + "defeat_music";
      game["music"][var_04] = maps\mp\gametypes\_teams::func_46D9("allies") + "victory_music";
      game["music"][var_05] = maps\mp\gametypes\_teams::func_46D9("allies") + "winning_music";
      game["music"][var_06] = maps\mp\gametypes\_teams::func_46D9("allies") + "losing_music";
      game["voice"][level.var_985B[var_01]] = maps\mp\gametypes\_teams::func_46D9("allies") + "anr0_";
    }
  } else {
    game["music"]["spawn_allies"] = maps\mp\gametypes\_teams::func_46D9("allies") + "spawn_music";
    game["music"]["defeat_allies"] = maps\mp\gametypes\_teams::func_46D9("allies") + "defeat_music";
    game["music"]["victory_allies"] = maps\mp\gametypes\_teams::func_46D9("allies") + "victory_music";
    game["music"]["winning_allies"] = maps\mp\gametypes\_teams::func_46D9("allies") + "winning_music";
    game["music"]["losing_allies"] = maps\mp\gametypes\_teams::func_46D9("allies") + "losing_music";
    game["voice"]["allies"] = maps\mp\gametypes\_teams::func_46D9("allies") + "anr0_";
    game["music"]["spawn_axis"] = maps\mp\gametypes\_teams::func_46D9("axis") + "spawn_music";
    game["music"]["defeat_axis"] = maps\mp\gametypes\_teams::func_46D9("axis") + "defeat_music";
    game["music"]["victory_axis"] = maps\mp\gametypes\_teams::func_46D9("axis") + "victory_music";
    game["music"]["winning_axis"] = maps\mp\gametypes\_teams::func_46D9("axis") + "winning_music";
    game["music"]["losing_axis"] = maps\mp\gametypes\_teams::func_46D9("axis") + "losing_music";
    game["voice"]["axis"] = maps\mp\gametypes\_teams::func_46D9("axis") + "anr0_";
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
  level thread func_6B6C();
  level thread func_6B4C();
  level thread func_65BC();
  level thread func_6B3E();
  level thread func_6B99();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
    var_00 thread func_3B5D();
  }
}

func_74CF() {
  if(!isDefined(level.var_7622)) {
    return;
  }

  level.var_7622 method_805C();
  foreach(var_01 in level.var_744A) {
    if(var_01 == self) {
      continue;
    }

    if(!isDefined(var_01.var_7623) || !var_01.var_7623) {
      continue;
    }

    if(maps\mp\_utility::func_5666(var_01)) {
      continue;
    }

    level.var_7622 showtoclient(var_01);
  }
}

init_end_game_music_ent() {
  if(!level.var_4B17) {
    if(!isDefined(level.end_game_music_ent)) {
      level.end_game_music_ent = spawn("script_origin", (0, 0, 0));
    }
  }
}

end_game_music_ent_origin_update(param_00) {
  if(isDefined(level.end_game_music_ent)) {
    level.end_game_music_ent.var_0116 = param_00;
  }
}

play_end_game_music(param_00) {
  if(isDefined(level.end_game_music_ent)) {
    level.end_game_music_ent method_8617(param_00);
  }
}

stop_end_game_music() {
  if(isDefined(level.end_game_music_ent)) {
    level.end_game_music_ent method_861B(0, 1);
    wait(5.5);
    level.end_game_music_ent method_8614();
    level.end_game_music_ent delete();
  }
}

func_7620() {
  self endon("disconnect");
  if(maps\mp\_utility::func_5666(self)) {
    return;
  }

  if(isDefined(level.var_7621) && level.var_7621) {
    return;
  }

  if(isDefined(self.var_7624) && self.var_7624) {
    return;
  } else {
    self.var_7624 = 1;
  }

  if(!isDefined(level.var_7622)) {
    if(!function_0344("mus_practice_round_backing_track")) {
      return;
    }

    level.var_7622 = spawn("script_origin", (0, 0, 0));
    level.var_7622 endon("death");
    level endon("practiceRoundMusicEnding");
    level thread func_36E0();
    level.var_7622 method_805C();
    wait(12);
    self.var_7623 = 1;
    level.var_7622 method_861D("mus_practice_round_backing_track");
    func_74CF();
    level.var_7622 showtoclient(self);
    level.var_7622 method_861B(0, 0.05);
    wait(0.8);
    level.var_7622 method_861B(0.8, 2.5);
    return;
  }

  func_74CF();
  level.var_7622 endon("death");
  level endon("practiceRoundMusicEnding");
  wait(12);
  self.var_7623 = 1;
  level.var_7622 showtoclient(self);
}

func_36E0() {
  level.var_7622 endon("death");
  while(game["state"] == "playing") {
    if(!level.var_9A12 && maps\mp\_utility::func_46E2()) {
      var_00 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
      var_01 = int(var_00 + 0.5);
      if(var_01 <= 10) {
        break;
      }

      if(var_00 - floor(var_00) >= 0.05) {
        wait(var_00 - floor(var_00));
      }
    }

    wait(1);
  }

  level notify("practiceRoundMusicEnding");
  level.var_7621 = 1;
  level.var_7622 method_861B(0, 5);
  wait(5.5);
  level.var_7622 method_8614();
  level.var_7622 delete();
}

func_6B82() {
  self endon("disconnect");
  self waittill("spawned_player");
  if(getDvar("4017") == "0" && !function_0367()) {
    if(!level.var_910F || level.var_910F && !isDefined(level.var_7217)) {
      if(!self issplitscreenplayer() || self method_82ED()) {
        self method_8615(game["music"]["spawn_" + self.var_01A7]);
      }

      if(level.var_910F) {
        level.var_7217 = 1;
      }
    }

    if(maps\mp\_utility::func_761E()) {
      thread func_7620();
    }

    if(isDefined(game["dialog"]["gametype"]) && !level.var_910F || self == level.var_744A[0]) {
      if(isDefined(game["dialog"]["allies_gametype"]) && self.var_01A7 == "allies") {
        maps\mp\_utility::func_5C43("allies_gametype");
      } else if(isDefined(game["dialog"]["axis_gametype"]) && self.var_01A7 == "axis") {
        maps\mp\_utility::func_5C43("axis_gametype");
      } else if(!self issplitscreenplayer() || self method_82ED()) {
        maps\mp\_utility::func_5C43("gametype");
      }
    }

    if(isDefined(level.var_2EC3)) {
      self[[level.var_2EC3]]();
      return;
    }

    wait(5);
    maps\mp\_utility::func_3FA5("prematch_done");
    if(self.var_01A7 == game["attackers"]) {
      if(!self issplitscreenplayer() || self method_82ED()) {
        maps\mp\_utility::func_5C43("offense_obj", "introboost");
        return;
      }

      return;
    }

    if(!self issplitscreenplayer() || self method_82ED()) {
      maps\mp\_utility::func_5C43("defense_obj", "introboost");
      return;
    }

    return;
  }
}

func_6B4C() {
  level endon("game_ended");
  level waittill("last_alive", var_00);
  if(!isalive(var_00)) {
    return;
  }

  var_00 maps\mp\_utility::func_5C43("last_alive");
}

func_6B99() {
  level waittill("round_switch", var_00);
  switch (var_00) {
    case "halftime":
      foreach(var_02 in level.var_744A) {
        if(var_02 issplitscreenplayer() && !var_02 method_82ED()) {
          continue;
        }

        var_02 maps\mp\_utility::func_5C43("halftime");
      }
      break;

    case "overtime":
      foreach(var_02 in level.var_744A) {
        if(var_02 issplitscreenplayer() && !var_02 method_82ED()) {
          continue;
        }

        var_02 maps\mp\_utility::func_5C43("overtime");
      }
      break;

    default:
      foreach(var_02 in level.var_744A) {
        if(var_02 issplitscreenplayer() && !var_02 method_82ED()) {
          continue;
        }

        var_02 maps\mp\_utility::func_5C43("side_switch");
      }
      break;
  }
}

func_6B3E() {
  level thread func_7F2E();
  level thread func_3FE1();
  level waittill("game_win", var_00);
  thread stop_end_game_music();
  if(level.var_984D) {
    if(level.var_910F) {
      if(var_00 == "allies") {
        maps\mp\_utility::func_74D9(game["music"]["victory_allies"], "allies");
        return;
      }

      if(var_00 == "axis") {
        maps\mp\_utility::func_74D9(game["music"]["victory_axis"], "axis");
        return;
      }

      maps\mp\_utility::func_74D9(game["music"]["draw_allies"], "allies");
      maps\mp\_utility::func_74D9(game["music"]["draw_axis"], "axis");
      return;
    }

    if(var_00 == "allies") {
      maps\mp\_utility::func_74D9(game["music"]["victory_allies"], "allies");
      maps\mp\_utility::func_74D9(game["music"]["defeat_axis"], "axis");
      return;
    }

    if(var_00 == "axis") {
      maps\mp\_utility::func_74D9(game["music"]["victory_axis"], "axis");
      maps\mp\_utility::func_74D9(game["music"]["defeat_allies"], "allies");
      return;
    }

    maps\mp\_utility::func_74D9(game["music"]["draw_allies"], "allies");
    maps\mp\_utility::func_74D9(game["music"]["draw_axis"], "axis");
    return;
  }

  foreach(var_02 in level.var_744A) {
    if(var_02 issplitscreenplayer() && !var_02 method_82ED()) {
      continue;
    }

    if(var_02.var_012C["team"] != "allies" && var_02.var_012C["team"] != "axis") {
      var_02 method_8615(game["music"]["draw_allies"]);
      continue;
    }

    if(isDefined(var_00) && isPlayer(var_00) && var_02 == var_00) {
      var_02 method_8615(game["music"]["victory_" + var_02.var_012C["team"]]);
      continue;
    }

    if(!level.var_910F) {
      var_02 method_8615(game["music"]["defeat_" + var_02.var_012C["team"]]);
    }
  }
}

func_7F2E() {
  level waittill("round_win", var_00);
  var_01 = level.var_7F16 / 4;
  if(var_01 > 0) {
    wait(var_01);
  }

  if(maps\mp\_utility::isprophuntgametype()) {
    thread stop_end_game_music();
  }

  if(!isDefined(var_00) || isPlayer(var_00)) {
    maps\mp\_utility::func_74D9(game["music"]["draw_allies"], "allies");
    maps\mp\_utility::func_74D9(game["music"]["draw_axis"], "axis");
    return;
  }

  if(maps\mp\_utility::func_761E()) {
    return;
  }

  if(var_00 == "allies") {
    maps\mp\_utility::func_5C39("round_success", "allies");
    maps\mp\_utility::func_5C39("round_failure", "axis");
    maps\mp\_utility::func_74D9(game["music"]["victory_allies"], "allies");
    maps\mp\_utility::func_74D9(game["music"]["defeat_axis"], "axis");
    return;
  }

  if(var_00 == "axis") {
    maps\mp\_utility::func_5C39("round_success", "axis");
    maps\mp\_utility::func_5C39("round_failure", "allies");
    maps\mp\_utility::func_74D9(game["music"]["victory_axis"], "axis");
    maps\mp\_utility::func_74D9(game["music"]["defeat_allies"], "allies");
    return;
  }
}

func_3FE1() {
  level waittill("game_win", var_00);
  var_01 = level.var_75EE / 2;
  if(var_01 > 0) {
    wait(var_01);
  }

  if(!level.var_984D && isDefined(var_00) && isPlayer(var_00)) {
    var_02 = [var_00];
    var_03 = [];
    foreach(var_05 in level.var_744A) {
      if(var_05 == var_00) {
        continue;
      } else {
        var_03[var_03.size] = var_05;
      }
    }

    maps\mp\_utility::func_5C39("ffa_win", "allies", undefined, var_03);
    maps\mp\_utility::func_5C39("ffa_lost", "allies", undefined, var_02);
  }

  if(!isDefined(var_05) || isPlayer(var_05)) {
    return;
  }

  if(maps\mp\_utility::func_761E()) {
    return;
  }

  if(var_05 == "allies") {
    maps\mp\_utility::func_5C39("mission_success", "allies");
    maps\mp\_utility::func_5C39("mission_failure", "axis");
    return;
  }

  if(var_05 == "axis") {
    maps\mp\_utility::func_5C39("mission_success", "axis");
    maps\mp\_utility::func_5C39("mission_failure", "allies");
    return;
  }

  maps\mp\_utility::func_5C39("mission_draw");
}

func_65BC() {
  level endon("game_ended");
  init_end_game_music_ent();
  level waittill("match_ending_soon", var_00);
  if(var_00 == "time") {
    if(level.var_984D) {
      if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
        maps\mp\_utility::func_5C39("winning_time", "allies");
        maps\mp\_utility::func_5C39("losing_time", "axis");
      } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        maps\mp\_utility::func_5C39("winning_time", "axis");
        maps\mp\_utility::func_5C39("losing_time", "allies");
      }
    } else {
      maps\mp\_utility::func_5C39("timesup");
    }
  } else if(var_00 == "score") {
    if(level.var_984D) {
      if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
        maps\mp\_utility::func_5C39("winning_score", "allies");
        maps\mp\_utility::func_5C39("losing_score", "axis");
      } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        maps\mp\_utility::func_5C39("winning_score", "axis");
        maps\mp\_utility::func_5C39("losing_score", "allies");
      }
    } else {
      var_01 = maps\mp\gametypes\_gamescore::func_450A();
      var_02 = maps\mp\gametypes\_gamescore::func_4568();
      var_01 maps\mp\_utility::func_5C43("winning_score");
      maps\mp\_utility::func_5C46("losing_score", var_02);
    }
  }

  if(!level.var_4B17 && !maps\mp\_utility::func_579B() && !maps\mp\_utility::func_585F() && getdvarint("enable_end_game_music", 1) && !maps\mp\_utility::func_56B1()) {
    play_end_game_music(game["music"]["match_ending_soon"]);
  }

  level waittill("match_ending_very_soon");
  maps\mp\_utility::func_5C39("timesup");
}

func_9528() {
  level endon("game_ended");
  level endon("match_ending_soon");
  var_00 = game["music"]["suspense"].size;
  wait(120);
  for(;;) {
    wait(randomfloatrange(60, 120));
    maps\mp\_utility::func_74D9(game["music"]["suspense"][randomint(var_00)]);
  }
}

func_3B5D() {
  self waittill("showing_final_killcam");
}