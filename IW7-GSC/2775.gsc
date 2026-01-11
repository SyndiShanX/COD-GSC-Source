/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2775.gsc
***************************************/

init() {
  if(!isDefined(game["music"])) {
    var_00 = randomint(100);
    var_01 = getdvar("mapname");

    if(getdvarint("scr_vo_selection_test", 0) != 0) {
      var_02 = getdvarint("scr_vo_selection_test", 0);

      switch (var_02) {
        case 1:
          var_03 = "S1_";
          var_04 = "U1_";
          break;
        case 2:
          var_03 = "S2_";
          var_04 = "U2_";
          break;
        case 3:
          var_03 = "MR_";
          var_04 = "JV_";
          break;
        default:
          var_03 = "S1_";
          var_04 = "U1_";
          break;
      }
    } else if(level.gametype == "tdef") {
      if(var_00 < 50) {
        var_04 = "JV_";
      } else {
        var_04 = "U1_";
      }

      var_03 = "S1_";
    } else if(var_00 <= 33) {
      var_04 = "JV_";
      var_03 = "MR_";
    } else if(var_00 > 33 && var_00 <= 66) {
      var_04 = "U1_";
      var_03 = "S1_";
    } else {
      var_04 = "U2_";
      var_03 = "S2_";
    }

    game["voice"]["allies"] = var_04;
    game["music"]["allies_used_nuke"] = "mus_us_nuke_fired";
    game["music"]["allies_hit_by_nuke"] = "mus_us_nuke_hit";
    game["music"]["draw_allies"] = "mus_us_draw";
    game["music"]["spawn_axis"] = "mus_fd_spawn";
    game["music"]["defeat_axis"] = "mus_fd_defeat";
    game["music"]["victory_axis"] = "mus_fd_victory";
    game["music"]["winning_axis"] = "mus_fd_winning";
    game["music"]["losing_axis"] = "mus_fd_losing";
    game["music"]["spawn_allies"] = "mus_us_spawn";
    game["music"]["defeat_allies"] = "mus_us_defeat";
    game["music"]["victory_allies"] = "mus_us_victory";
    game["music"]["winning_allies"] = "mus_us_winning";
    game["music"]["losing_allies"] = "mus_us_losing";
    game["voice"]["axis"] = var_03;
    game["music"]["axis_used_nuke"] = "mus_fd_nuke_fired";
    game["music"]["axis_hit_by_nuke"] = "mus_fd_nuke_hit";
    game["music"]["draw_axis"] = "mus_fd_draw";
    game["music"]["losing_time"] = "mp_time_running_out_losing";
    game["music"]["allies_suspense"] = [];
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_110_scar_suspense_01";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_138_scar_suspense_03";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_140_scar_suspense_04";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_111_general_suspense_01";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_113_general_suspense_03";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_115_general_suspense_04";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_120_general_suspense_07";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_122_general_suspense_09";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_123_general_suspense_10";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_127_general_suspense_11";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_130_general_suspense_12";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_135_general_suspense_13";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_139_general_suspense_14";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_497_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_496_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_495_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_506_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_510_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_507_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_518_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_519_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_520_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_521_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_528_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_524_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_523_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_529_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_494_general_suspense";
    game["music"]["allies_suspense"][game["music"]["allies_suspense"].size] = "mp_487_general_suspense";
    game["music"]["axis_suspense"] = [];
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_117_setdef_suspense_01";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_119_setdef_suspense_02";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_136_setdef_suspense_04";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_111_general_suspense_01";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_112_general_suspense_02";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_113_general_suspense_03";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_115_general_suspense_04";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_120_general_suspense_07";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_122_general_suspense_09";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_123_general_suspense_10";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_127_general_suspense_11";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_135_general_suspense_13";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_139_general_suspense_14";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_487_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_494_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_495_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_496_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_497_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_506_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_507_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_510_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_518_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_519_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_520_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_521_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_523_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_524_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_528_general_suspense";
    game["music"]["axis_suspense"][game["music"]["axis_suspense"].size] = "mp_529_general_suspense";
    game["dialog"]["mission_success"] = "mission_success";
    game["dialog"]["mission_failure"] = "mission_fail";
    game["dialog"]["mission_draw"] = "draw";
    game["dialog"]["round_success"] = "round_end_win";
    game["dialog"]["round_failure"] = "round_end_lose";
    game["dialog"]["round_draw"] = "draw";
    game["dialog"]["timesup"] = "timesup";
    game["dialog"]["winning_time"] = "winning";
    game["dialog"]["losing_time"] = "losing";
    game["dialog"]["winning_score"] = "winning_fight";
    game["dialog"]["losing_score"] = "losing_fight";
    game["dialog"]["lead_lost"] = "lead_lost";
    game["dialog"]["lead_tied"] = "tied";
    game["dialog"]["lead_taken"] = "lead_taken";
    game["dialog"]["last_alive"] = "lastalive";
    game["dialog"]["halfway_enemy_boost"] = "halfway_enemy";
    game["dialog"]["halfway_friendly_boost"] = "halfway_friendly";
    game["dialog"]["boost"] = "boost";

    if(!isDefined(game["dialog"]["offense_obj"])) {
      game["dialog"]["offense_obj"] = "boost";
    }

    if(!isDefined(game["dialog"]["defense_obj"])) {
      game["dialog"]["defense_obj"] = "boost";
    }

    game["dialog"]["hardcore"] = "hardcore";
    game["dialog"]["challenge"] = "challengecomplete";
    game["dialog"]["promotion"] = "promotion";
    game["dialog"]["bomb_taken"] = "acheive_bomb";
    game["dialog"]["bomb_lost"] = "bomb_taken";
    game["dialog"]["bomb_defused"] = "bomb_defused";
    game["dialog"]["bomb_planted"] = "bomb_planted";
    game["dialog"]["enemy_bomb_a"] = "enemy_bomb_a";
    game["dialog"]["enemy_bomb_b"] = "enemy_bomb_b";
    game["dialog"]["enemy_bomb_defused"] = "enemy_bomb_defused";
    game["dialog"]["enemy_bomb_planted"] = "enemy_bomb_planted";
    game["dialog"]["obj_defend"] = "obj_defend";
    game["dialog"]["obj_destroy"] = "obj_destroy";
    game["dialog"]["obj_capture"] = "capture_obj";
    game["dialog"]["objs_capture"] = "capture_objs";
    game["dialog"]["enemy_zone_control"] = "enemy_zone_control";
    game["dialog"]["friendly_zone_control"] = "friendly_zone_control";
    game["dialog"]["hp_new_location"] = "hp_new_location";
    game["dialog"]["hp_captured_enemy"] = "hp_captured_enemy";
    game["dialog"]["hp_captured_friendly"] = "hp_captured_friendly";
    game["dialog"]["hp_contested"] = "hp_contested";
    game["dialog"]["hp_move_soon"] = "hp_move_soon";
    game["dialog"]["hp_capturing_enemy"] = "hp_capturing_enemy";
    game["dialog"]["hp_capturing_friendly"] = "hp_capturing_friendly";
    game["dialog"]["hp_lost_enemy"] = "hp_lost_enemy";
    game["dialog"]["halftime"] = "halftime";
    game["dialog"]["overtime"] = "overtime";
    game["dialog"]["side_switch"] = "switching";
    game["dialog"]["flag_taken"] = "ourflag";
    game["dialog"]["flag_dropped"] = "ourflag_drop";
    game["dialog"]["flag_returned"] = "ourflag_return";
    game["dialog"]["flag_captured"] = "ourflag_capt";
    game["dialog"]["flag_getback"] = "getback_ourflag";
    game["dialog"]["enemy_flag_bringhome"] = "enemyflag_tobase";
    game["dialog"]["enemy_flag_taken"] = "enemyflag";
    game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
    game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
    game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";
    game["dialog"]["capturing_a"] = "capturing_a";
    game["dialog"]["capturing_b"] = "capturing_b";
    game["dialog"]["capturing_c"] = "capturing_c";
    game["dialog"]["captured_a"] = "capture_a";
    game["dialog"]["captured_b"] = "capture_c";
    game["dialog"]["captured_c"] = "capture_b";
    game["dialog"]["securing_a"] = "securing_a";
    game["dialog"]["securing_b"] = "securing_b";
    game["dialog"]["securing_c"] = "securing_c";
    game["dialog"]["secured_a"] = "secure_a";
    game["dialog"]["secured_b"] = "secure_b";
    game["dialog"]["secured_c"] = "secure_c";
    game["dialog"]["losing_a"] = "losing_a";
    game["dialog"]["losing_b"] = "losing_b";
    game["dialog"]["losing_c"] = "losing_c";
    game["dialog"]["lost_a"] = "lost_a";
    game["dialog"]["lost_b"] = "lost_b";
    game["dialog"]["lost_c"] = "lost_c";
    game["dialog"]["enemy_taking_a"] = "enemy_take_a";
    game["dialog"]["enemy_taking_b"] = "enemy_take_b";
    game["dialog"]["enemy_taking_c"] = "enemy_take_c";
    game["dialog"]["enemy_has_a"] = "enemy_has_a";
    game["dialog"]["enemy_has_b"] = "enemy_has_b";
    game["dialog"]["enemy_has_c"] = "enemy_has_c";
    game["dialog"]["lost_all"] = "take_positions";
    game["dialog"]["secure_all"] = "positions_lock";
    game["music"]["nuke_music"] = "nuke_music";
    game["dialog"]["ti_destroyed"] = "ti_blocked";
    game["dialog"]["jackal_destroyed"] = "destroyed_jackal";
    game["dialog"]["uav_use"] = "op_uav_use";
    game["dialog"]["uav_destroyed"] = "op_uav_destroyed";
    game["dialog"]["uav_timeout"] = "op_uav_timeout";
    game["dialog"]["counter_uav_use"] = "op_counter_uav_use";
    game["dialog"]["counter_uav_destroyed"] = "op_counter_uav_destroyed";
    game["dialog"]["counter_uav_timeout"] = "op_counter_uav_timeout";
    game["dialog"]["dronedrop_use"] = "op_dronedrop_use";
    game["dialog"]["dronedrop_destroyed"] = "op_dronedrop_destroyed";
    game["dialog"]["drone_hive_use"] = "op_orbital_deployment_use";
    game["dialog"]["bombardment_use"] = "op_bombardment_use";
    game["dialog"]["thor_use"] = "op_thor_use";
    game["dialog"]["thor_end"] = "op_thor_end";
    game["dialog"]["thor_destroyed"] = "op_thor_destroyed";
    game["dialog"]["thor_timeout"] = "op_thor_timeout";
    game["dialog"]["jackal_use"] = "op_jackal_use";
    game["dialog"]["jackal_fire"] = "op_jackal_fire";
    game["dialog"]["jackal_guard"] = "op_jackal_guard";
    game["dialog"]["jackal_follow"] = "op_jackal_follow";
    game["dialog"]["jackal_target_dead"] = "op_jackal_target_dead";
    game["dialog"]["jackal_target_lost"] = "op_jackal_target_lost";
    game["dialog"]["jackal_end"] = "op_jackal_end";
    game["dialog"]["jackal_destroyed"] = "op_jackal_destroyed";
    game["dialog"]["precision_airstrike_use"] = "op_precision_airstrike_use";
    game["dialog"]["precision_airstrike_end"] = "op_precision_airstrike_end";
    game["dialog"]["jammer_use"] = "op_jammer_use";
    game["dialog"]["jammer_destroyed"] = "op_jammer_destroyed";
    game["dialog"]["sentry_shock_use"] = "op_sentry_shock_use";
    game["dialog"]["sentry_shock_destroy"] = "op_sentry_shock_destroy";
    game["dialog"]["sentry_shock_timeout"] = "op_sentry_shock_timeout";
    game["dialog"]["ball_drone_backup_use"] = "op_ball_drone_backup_use";
    game["dialog"]["ball_drone_backup_destroy"] = "op_ball_drone_backup_destroy";
    game["dialog"]["ball_drone_backup_timeout"] = "op_ball_drone_backup_timeout";
    game["dialog"]["minijackal_use"] = "op_minijackal_use";
    game["dialog"]["minijackal_destroy"] = "op_minijackal_destroy";
    game["dialog"]["minijackal_timeout"] = "op_minijackal_timeout";
    game["dialog"]["remote_c8_use"] = "op_remote_c8_use";
    game["dialog"]["remote_c8_ai"] = "op_remote_c8_ai";
    game["dialog"]["remote_c8_user"] = "op_remote_c8_user";
    game["dialog"]["remote_c8_destroy"] = "op_remote_c8_destroy";
    game["dialog"]["remote_c8_end"] = "op_remote_c8_end";
    game["dialog"]["remote_c8_timeout"] = "op_remote_c8_timeout";
    game["dialog"]["siege_ship_use"] = "op_siege_ship_use";
    game["dialog"]["siege_ship_destroy"] = "op_siege_ship_destroy";
    game["dialog"]["nuke_use"] = "op_nuke_use";
    game["dialog"]["directional_uav_use"] = "op_directional_uav_use";
    game["dialog"]["directional_uav_destroyed"] = "op_directional_uav_destroyed";
    game["dialog"]["directional_uav_timeout"] = "op_directional_uav_timeout";
    game["dialog"]["venom_use"] = "op_venom_use";
    game["dialog"]["venom_destroyed"] = "op_venom_destroyed";
    game["dialog"]["venom_timeout"] = "op_venom_timeout";
  }

  level thread onplayerconnect();
  level thread func_BDEF();
  level thread ongameended();
  level thread post_match_music();
  level thread func_C585();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread playflyoveraudioline();
    var_00 thread onplayerspawned();
    var_00 thread func_6C70();
    var_00 thread watchhostmigration();
  }
}

onplayerspawned() {
  self endon("disconnect");

  if(!isai(self)) {
    self waittill("spawned_player");
    thread dointro();
  }
}

waitcountdown() {
  self endon("rigBootFinished");
  level endon("host_migration_begin");
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\utility\game::gameflag("prematch_done")) {
      self notify("luinotifyserver", "matchReady");
      return;
    }

    wait 1;
  }
}

playflyoveraudioline() {
  level endon("host_migration_begin");
  self endon("disconnect");
  var_00 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(var_00 >= level.prematchperiod) {
    return;
  }
  if(!level.rankedmatch) {
    return;
  }
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_01 = self getrankedplayerdata("mp", "activeMissionTeam");

  if(!self issplitscreenplayer() || self isreloading()) {
    if(self.sessionteam == "allies") {
      switch (var_01) {
        case 0:
          self _meth_85BF("jtfw_mtc1_un_flyover");
          break;
        case 1:
          self _meth_85BF("oi_mtc3_un_flyover");
          break;
        case 2:
          self _meth_85BF("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self _meth_85BF("wr_mtc5_un_flyover");
          break;
        case 4:
          self _meth_85BF("ba_mtc2_un_flyover");
          break;
        default:
          break;
      }
    } else if(self.sessionteam == "axis") {
      switch (var_01) {
        case 0:
          self _meth_85BF("jtfw_mtc1_sdf_flyover");
          break;
        case 1:
          self _meth_85BF("oi_mtc3_sdf_flyover");
          break;
        case 2:
          self _meth_85BF("st7_mtc4_prematch_flyover");
          break;
        case 3:
          self _meth_85BF("wr_mtc5_sdf_flyover");
          break;
        case 4:
          self _meth_85BF("ba_mtc2_sdf_flyover");
          break;
        default:
          break;
      }
    }
  }
}

dointro() {
  level endon("host_migration_begin");
  self endon("disconnect");

  while(level.ingraceperiod > 15) {
    wait 0.05;
  }

  var_00 = !scripts\mp\utility\game::gameflag("prematch_done") && (!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::func_9DF6());

  if(var_00) {
    thread waitcountdown();

    for(;;) {
      self waittill("luinotifyserver", var_01, var_02);

      if(var_01 == "rig_boot_started") {
        level notify("rigBootFinished");
        self notify("rigBootFinished");
        break;
      } else if(var_01 == "matchReady") {
        break;
      }
    }
  }

  if(!level.splitscreen || level.splitscreen && !isDefined(level.playedstartingmusic)) {
    if(!self issplitscreenplayer() || self isreloading()) {
      self setplayermusicstate("");

      if(isDefined(self.team) && self.team != "spectator") {
        self playlocalsound(game["music"]["spawn_" + self.team]);
      }
    }

    if(level.splitscreen) {
      level.playedstartingmusic = 1;
    }
  }

  if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
    if(isDefined(game["dialog"]["allies_gametype"]) && self.team == "allies") {
      scripts\mp\utility\game::leaderdialogonplayer("allies_gametype");
    } else if(isDefined(game["dialog"]["axis_gametype"]) && self.team == "axis") {
      scripts\mp\utility\game::leaderdialogonplayer("axis_gametype");
    } else if(!self issplitscreenplayer() || self isreloading()) {
      scripts\mp\utility\game::leaderdialogonplayer("gametype");
    }
  }

  scripts\mp\utility\game::gameflagwait("prematch_done");

  if(self.team == game["attackers"]) {
    if(!self issplitscreenplayer() || self isreloading()) {
      scripts\mp\utility\game::leaderdialogonplayer("offense_obj", "introboost");
    }
  } else if(!self issplitscreenplayer() || self isreloading())
    scripts\mp\utility\game::leaderdialogonplayer("defense_obj", "introboost");
}

watchhostmigration() {
  self endon("disconnect");
  level endon("grace_period_ending");

  for(;;) {
    level waittill("host_migration_begin");
    var_00 = level.ingraceperiod;
    level waittill("host_migration_end");

    if(var_00) {
      thread dointro();
    }
  }
}

func_C54B(var_00) {
  if(level.gameended) {
    return;
  }
  if(!isalive(var_00)) {
    return;
  }
  if(scripts\mp\utility\game::istrue(var_0.playedlastmanstandingvo)) {
    return;
  }
  var_0.playedlastmanstandingvo = 1;

  if(level.gametype == "siege") {
    var_00 scripts\mp\utility\game::leaderdialogonplayer("lastalive_zones");
  } else if(level.gametype == "sr" && !level.nofriendlytags) {
    var_00 scripts\mp\utility\game::leaderdialogonplayer("lastalive_revive");
  } else {
    var_00 scripts\mp\utility\game::leaderdialogonplayer("last_alive");
  }
}

func_C585() {
  level waittill("round_switch", var_00);

  switch (var_00) {
    case "halftime":
      foreach(var_02 in level.players) {
        if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
          continue;
        }
        var_02 scripts\mp\utility\game::leaderdialogonplayer("halftime");
      }

      break;
    case "overtime":
      foreach(var_02 in level.players) {
        if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
          continue;
        }
        var_02 scripts\mp\utility\game::leaderdialogonplayer("overtime");
      }

      break;
    default:
      foreach(var_02 in level.players) {
        if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
          continue;
        }
        var_02 scripts\mp\utility\game::leaderdialogonplayer("side_switch");
      }

      break;
  }
}

post_match_music() {
  level waittill("round_end_music", var_00);

  foreach(var_02 in level.players) {
    if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
      continue;
    }
    if(level.finalkillcam_winner != "none") {
      var_02 setplayermusicstate("mus_mp_killcam");
    }
  }
}

ongameended() {
  level thread func_E76B();
  level thread func_7690();
  level waittill("game_win", var_00);

  if(level.teambased) {
    if(level.splitscreen) {
      if(var_00 == "allies") {
        foreach(var_02 in level.players) {
          if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
            continue;
          }
          var_02 setplayermusicstate(game["music"]["victory_allies"]);
        }
      } else if(var_00 == "axis") {
        foreach(var_02 in level.players) {
          if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
            continue;
          }
          var_02 setplayermusicstate(game["music"]["victory_axis"]);
        }
      } else {
        scripts\mp\utility\game::playsoundonplayers(game["music"]["nuke_music"]);

        foreach(var_02 in level.players) {
          var_02 setplayermusicstate("");
        }
      }
    } else if(var_00 == "allies") {
      foreach(var_02 in level.players) {
        if(isDefined(var_2.team) && var_2.team == "allies") {
          var_02 setplayermusicstate(game["music"]["victory_allies"]);
          continue;
        }

        var_02 setplayermusicstate(game["music"]["defeat_axis"]);
      }
    } else if(var_00 == "axis") {
      foreach(var_02 in level.players) {
        if(isDefined(var_2.team) && var_2.team == "axis") {
          var_02 setplayermusicstate(game["music"]["victory_axis"]);
          continue;
        }

        var_02 setplayermusicstate(game["music"]["defeat_allies"]);
      }
    } else {
      foreach(var_02 in level.players) {
        if(isDefined(var_2.team) && var_2.team == "allies") {
          var_02 setplayermusicstate(game["music"]["draw_allies"]);
          continue;
        }

        var_02 setplayermusicstate(game["music"]["draw_axis"]);
      }
    }
  } else {
    foreach(var_02 in level.players) {
      var_02 setplayermusicstate("");

      if(var_02 issplitscreenplayer() && !var_02 isreloading()) {
        continue;
      }
      if(var_2.pers["team"] != "allies" && var_2.pers["team"] != "axis") {
        var_02 playlocalsound(game["music"]["nuke_music"]);
        continue;
      }

      if(isDefined(var_00) && isplayer(var_00) && var_02 == var_00) {
        var_02 setplayermusicstate(game["music"]["victory_" + var_2.pers["team"]]);
        continue;
      }

      if(!level.splitscreen) {
        var_02 setplayermusicstate(game["music"]["defeat_" + var_2.pers["team"]]);
      }
    }
  }
}

func_E76B() {
  level waittill("round_win", var_00);
  wait 0.5;
  var_01 = game["teamScores"]["allies"];
  var_02 = game["teamScores"]["axis"];

  if(!isDefined(var_00) || isplayer(var_00)) {
    return;
  }
  if(var_00 == "allies") {
    scripts\mp\utility\game::leaderdialog("round_success", "allies");
    scripts\mp\utility\game::leaderdialog("round_failure", "axis");
  } else if(var_00 == "axis") {
    scripts\mp\utility\game::leaderdialog("round_success", "axis");
    scripts\mp\utility\game::leaderdialog("round_failure", "allies");
  } else if(var_02 > var_01) {
    scripts\mp\utility\game::leaderdialog("round_success", "axis");
    scripts\mp\utility\game::leaderdialog("round_failure", "allies");
  } else if(var_01 > var_02) {
    scripts\mp\utility\game::leaderdialog("round_success", "allies");
    scripts\mp\utility\game::leaderdialog("round_failure", "axis");
  } else
    scripts\mp\utility\game::leaderdialog("lead_tied");
}

func_7690() {
  level waittill("game_win", var_00);
  var_01 = level.func_D706 / 2;

  if(var_01 > 0) {
    wait(var_01);
  }

  if(!isDefined(var_00)) {
    return;
  }
  if(isplayer(var_00) && !level.teambased) {
    for(var_02 = 0; var_02 < level.placement["all"].size; var_2++) {
      var_03 = level.placement["all"][var_02];

      if(var_03 issplitscreenplayer() && !var_03 isreloading()) {
        continue;
      }
      if(var_02 < 3) {
        var_03 scripts\mp\utility\game::leaderdialogonplayer("mission_success");
        continue;
      }

      var_03 scripts\mp\utility\game::leaderdialogonplayer("mission_failure");
    }
  } else if(var_00 == "allies") {
    scripts\mp\utility\game::leaderdialog("mission_success", "allies");
    scripts\mp\utility\game::leaderdialog("mission_failure", "axis");
  } else if(var_00 == "axis") {
    scripts\mp\utility\game::leaderdialog("mission_success", "axis");
    scripts\mp\utility\game::leaderdialog("mission_failure", "allies");
  } else
    scripts\mp\utility\game::leaderdialog("mission_draw");
}

func_BDEF() {
  level endon("game_ended");
  level.musicenabled = 1;
  thread suspensemusic();
  level waittill("match_ending_soon", var_00);

  if(level.roundlimit == 1 || game["roundsPlayed"] == level.roundlimit - 1 || scripts\mp\utility\game::ismoddedroundgame()) {
    if(!level.splitscreen) {
      if(var_00 == "time") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              thread timelimitmusic("allies");
            }

            scripts\mp\utility\game::leaderdialog("winning_time", "allies");
            scripts\mp\utility\game::leaderdialog("losing_time", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              thread timelimitmusic("axis");
            }

            scripts\mp\utility\game::leaderdialog("winning_time", "axis");
            scripts\mp\utility\game::leaderdialog("losing_time", "allies");
          }
        } else {
          if(ismusicenabled()) {
            scripts\mp\utility\game::playsoundonplayers(game["music"]["losing_time"]);

            foreach(var_02 in level.players) {
              var_02 setplayermusicstate("");
            }
          }

          scripts\mp\utility\game::leaderdialog("timesup");
        }
      } else if(var_00 == "score") {
        if(level.teambased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            if(ismusicenabled()) {
              scripts\mp\utility\game::playsoundonplayers(game["music"]["winning_allies"], "allies");
              scripts\mp\utility\game::playsoundonplayers(game["music"]["losing_axis"], "axis");

              foreach(var_02 in level.players) {
                var_02 setplayermusicstate("");
              }
            }

            scripts\mp\utility\game::leaderdialog("winning_score", "allies");
            scripts\mp\utility\game::leaderdialog("losing_score", "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            if(ismusicenabled()) {
              scripts\mp\utility\game::playsoundonplayers(game["music"]["winning_axis"], "axis");
              scripts\mp\utility\game::playsoundonplayers(game["music"]["losing_allies"], "allies");

              foreach(var_02 in level.players) {
                var_02 setplayermusicstate("");
              }
            }

            scripts\mp\utility\game::leaderdialog("winning_score", "axis");
            scripts\mp\utility\game::leaderdialog("losing_score", "allies");
          }
        } else {
          var_08 = scripts\mp\gamescore::gethighestscoringplayer();
          var_09 = scripts\mp\gamescore::getlosingplayers();
          var_10[0] = var_08;

          if(ismusicenabled()) {
            var_08 playlocalsound(game["music"]["winning_" + var_8.pers["team"]]);
            var_08 setplayermusicstate("");

            foreach(var_12 in level.players) {
              if(var_12 == var_08) {
                continue;
              }
              if(var_12 ismlgspectator()) {
                continue;
              }
              var_12 playlocalsound(game["music"]["losing_" + var_12.pers["team"]]);
              var_12 setplayermusicstate("");
            }
          }

          var_08 scripts\mp\utility\game::leaderdialogonplayer("winning_score");
          scripts\mp\utility\game::leaderdialogonplayers("losing_score", var_09);
        }
      }

      level waittill("match_ending_very_soon");
      scripts\mp\utility\game::leaderdialog("timesup");
    }
  } else {
    if(!level.hardcoremode) {
      scripts\mp\utility\game::playsoundonplayers(game["music"]["losing_allies"]);

      foreach(var_02 in level.players) {
        var_02 setplayermusicstate("");
      }
    }

    scripts\mp\utility\game::leaderdialog("timesup");
  }
}

timelimitmusic(var_00) {
  self endon("game_ended");
  level waittill("match_ending_very_soon");

  if(var_00 == "allies") {
    scripts\mp\utility\game::playsoundonplayers(game["music"]["winning_allies"], "allies");
    scripts\mp\utility\game::playsoundonplayers(game["music"]["losing_axis"], "axis");
  } else {
    scripts\mp\utility\game::playsoundonplayers(game["music"]["winning_axis"], "axis");
    scripts\mp\utility\game::playsoundonplayers(game["music"]["losing_allies"], "allies");
  }

  foreach(var_02 in level.players) {
    var_02 setplayermusicstate("");
  }
}

suspensemusic(var_00) {
  if(!ismusicenabled()) {
    return;
  }
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("stop_suspense_music");

  if(isDefined(level.func_C0AF) && level.func_C0AF) {
    return;
  }
  var_01 = game["music"]["allies_suspense"].size;
  var_02 = game["music"]["axis_suspense"].size;
  level.cursuspsensetrack = [];

  if(isDefined(var_00) && var_00) {
    wait 120;
  }

  for(;;) {
    wait(randomfloatrange(60, 150));
    level.cursuspsensetrack["allies"] = randomint(var_01);
    level.cursuspsensetrack["axis"] = randomint(var_02);

    foreach(var_04 in level.players) {
      var_05 = var_4.team;

      if(var_4.team == "allies") {
        var_04 setplayermusicstate(game["music"]["allies_suspense"][level.cursuspsensetrack["allies"]]);
        continue;
      }

      var_04 setplayermusicstate(game["music"]["axis_suspense"][level.cursuspsensetrack["axis"]]);
    }
  }
}

stopsuspensemusic() {
  level notify("stop_suspense_music");

  if(isDefined(level.cursuspsensetrack) && level.cursuspsensetrack.size == 2) {
    foreach(var_01 in level.players) {
      var_01 setplayermusicstate("");
    }
  }
}

func_6C70() {
  self waittill("showing_final_killcam");
}

func_6274() {
  if(level.musicenabled == 0) {
    thread suspensemusic();
  }

  level.musicenabled++;
}

disablemusic() {
  if(level.musicenabled > 0) {
    level.musicenabled--;

    if(level.musicenabled == 0) {
      stopsuspensemusic();
    }
  } else {}
}

ismusicenabled() {
  return !level.hardcoremode && level.musicenabled > 0;
}