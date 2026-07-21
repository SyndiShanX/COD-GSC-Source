/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_cyber.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_cyber();
}

setup_callbacks() {
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use;
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_cyber_think;
  level.bot_funcs["_encstr_952F16EAC5AAB7BE35F36850974D73AFF26D486EDBA24503"] = undefined;
  level.bot_funcs["_encstr_B18315D04F881E117A3E6A65D73153A3FF1F8873EF35B0"] = ::currentintelflag;
  level.bot_funcs["_encstr_BA301954E3383B8F9E19FAB103E5BB34C843C7C755E0423BB39162"] = ::currentlabel;
}

setup_bot_cyber() {
  damage_multiplier();
  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_setup_objective_bottargets();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::debug_consoles(["_encstr_ABE2089FA7E2116055EA", "_encstr_8AF106FA2C0FD2CD"]);

  if(var_0) {
    foreach(var_2 in level.objectives)
    var_2 thread _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::monitor_bombzone_control();

    level.protect_radius = 600;
    level.bot_gametype_precaching_done = 1;
  }
}

bot_cyber_think() {
  self notify("_encstr_B4450E4DE56B97374E1A27B3817A6048");
  self endon("_encstr_B4450E4DE56B97374E1A27B3817A6048");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  strafe();
  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);
  self.next_time_hunt_carrier = gettime();

  if(!isDefined(level.next_game_update_time))
    level.next_game_update_time = gettime() + 100;

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time) {
      _id_13F85();
      level.next_game_update_time = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_13A9A)) {
      if(!isDefined(level.cover_guys_debug)) {
        if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_96B60F6E2BACD6BE1B5E31B29CBE2BDA07", undefined) == 0) {
          var_0 = ::introarmor;
          var_1 = spawnStruct();
          var_1.object = level.cyberemp.trigger;
          var_1.script_goal_radius = 16;
          var_1.should_abort = level.bot_funcs["_encstr_B18315D04F881E117A3E6A65D73153A3FF1F8873EF35B0"];
          var_1.action_thread = var_0;
          var_2 = getclosestpointonnavmesh(level.cyberemp.curorigin, self);
          scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_96B60F6E2BACD6BE1B5E31B29CBE2BDA07", var_2, 99, var_1);
        }
      } else if(self.isbombcarrier) {
        var_3 = level.objectives[scripts\engine\utility::get_enemy_team(self.team)];
        var_4 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::process_should_do_pain(var_3, 1);
        self botsetscriptgoal(var_4.origin, 0, "_encstr_99CC09DA9020C4ECD149AD", var_4.angles[1]);
        var_5 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(var_5 == "_encstr_8B7205D9ED5958") {
          self botpressbutton("_encstr_AB19049D0FC0", level.planttime + 2);
          level scripts\engine\utility::_id_143B9(level.planttime + 2, "_encstr_AB3D0DE25FE81EF7B7188A42230553");
        }
      } else if(level.cover_guys_debug.team == self.team) {
        if(!scripts\mp\bots\bots_util::bot_is_defending())
          scripts\mp\bots\bots_strategy::bot_guard_player(level.cover_guys_debug, 400);
      } else if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level.cover_guys_debug.origin + (0, 0, 77), 0, self)) {
        self botsetscriptgoal(level.cover_guys_debug.origin, 16, "_encstr_9ACC05B4156DF3");
        self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
      }

      continue;
    }

    var_3 = level.objectives[scripts\engine\utility::get_enemy_team(level._id_13A9A)];

    if(self.team == level._id_13A9A) {
      if(!trigger_spawn_kill_watcher())
        scripts\mp\bots\bots_strategy::bot_protect_point(var_3.curorigin, 600);
    } else if(isDefined(level.bomb_defuser) && level.bomb_defuser == self) {
      var_6 = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::process_players_inside_subway_car(var_3).origin;
      self botsetscriptgoal(var_6, 20, "_encstr_99CC09DA9020C4ECD149AD");
      var_7 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail(undefined, "_encstr_889117E6F6BE63DBB99D9539D74C7BDA13AFC82BCCEA9BAC9C");

      if(var_7 == "_encstr_8B7205D9ED5958") {
        self botpressbutton("_encstr_AB19049D0FC0", level.defusetime + 2);
        _id_143EB(level.defusetime + 2);
      }
    } else if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      var_8["_encstr_A136168FEA0B6BCBE09EF96870352B232BE7CEA3D8D0F2E0"] = "_encstr_836105A5EFB2E5" + var_3.label;
      scripts\mp\bots\bots_strategy::bot_capture_point(var_3.curorigin, 200, var_8);
    }
  }
}

currentintelflag(var_0) {
  if(isDefined(level.cyberemp.carrier))
    return 1;

  return 0;
}

introarmor(var_0) {
  self botpressbutton("_encstr_AB19049D0FC0", 0.5);
  var_1 = self botgetpersonality();

  if(var_1 == "_encstr_8B1608EC43B8D647A113" || var_1 == "_encstr_B892078D2C5BE05927")
    wait 0.5;
}

_id_143EB(var_0) {
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var_2 && level.bombplanted)
    wait 0.05;
}

trigger_spawn_kill_watcher() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

strafe() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;
}

_id_13F85() {
  if(!level.bombplanted) {
    if(isDefined(level._id_13A9A)) {
      level._id_13A9A = undefined;
      level.cover_guys_debug = undefined;
    }

    var_0 = level.cover_guys_debug;
    level.cover_guys_debug = undefined;

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && var_2.isbombcarrier)
        level.cover_guys_debug = var_2;
    }

    var_4 = 0;

    if(!isDefined(var_0) && isDefined(level.cover_guys_debug)) {
      var_4 = 1;

      if(isai(level.cover_guys_debug))
        level.cover_guys_debug thread createinvalidcirclearea();
    } else if(isDefined(var_0) && !isDefined(level.cover_guys_debug))
      var_4 = 1;

    if(var_4) {
      foreach(var_2 in level.participants) {
        if(scripts\mp\utility\entity::isaiteamparticipant(var_2))
          var_2 scripts\mp\bots\bots_strategy::bot_defend_stop();
      }

      return;
    }
  } else {
    if(isDefined(level.bombowner) && !isDefined(level._id_13A9A)) {
      level._id_13A9A = level.bombowner.team;
      level.waittill_player_behind_cover = gettime();
    }

    if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser) || gettime() > level.waittill_player_behind_cover + 1000) {
      var_7 = [];

      foreach(var_2 in level.participants) {
        if(isalive(var_2) && scripts\mp\utility\entity::isaiteamparticipant(var_2) && var_2.team != level._id_13A9A)
          var_7[var_7.size] = var_2;
      }

      if(var_7.size > 0) {
        var_10 = level.objectives[scripts\engine\utility::get_enemy_team(level._id_13A9A)];
        var_11 = scripts\engine\utility::get_array_of_closest(var_10.curorigin, var_7);

        if(!isDefined(level.bomb_defuser) || level.bomb_defuser != var_11[0]) {
          var_12 = level.bomb_defuser;
          level.bomb_defuser = var_11[0];
          level.bomb_defuser scripts\mp\bots\bots_strategy::bot_defend_stop();

          if(isDefined(var_12))
            var_12 notify("_encstr_889117E6F6BE63DBB99D9539D74C7BDA13AFC82BCCEA9BAC9C");
        }
      }
    }
  }
}

createinvalidcirclearea() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!level.bombplanted && self.isbombcarrier) {
    var_0 = [];

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && scripts\mp\utility\entity::isaiteamparticipant(var_2) && var_2.team == self.team && var_2 scripts\mp\bots\bots_util::bot_is_defending())
        var_0[var_0.size] = var_2;
    }

    var_4 = 0;

    foreach(var_6 in var_0) {
      var_7 = distancesquared(self.origin, var_6.origin);
      var_8 = var_6.bot_defending_radius * var_6.bot_defending_radius;
      var_9 = var_6.bot_defending_radius * 2 * (var_6.bot_defending_radius * 2);

      if(var_7 > var_8 && var_7 < var_9)
        var_4++;
    }

    self setmovespeedscale(1.0 - 0.15 * var_4);
    wait 1;
  }
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype))
    return 0;

  if(isDefined(var_0.cratetype) && !scripts\mp\bots\bots_killstreaks::bot_is_killstreak_supported(var_0.cratetype))
    return 0;

  if(self.isbombcarrier)
    return 0;

  if(!scripts\mp\bots\bots_util::bot_is_defending() && !scripts\mp\bots\bots_util::bot_is_protecting() && !scripts\mp\bots\bots_util::bot_is_bodyguarding())
    return 1;

  return 0;
}

currentlabel() {
  if(level.bombplanted)
    return 0;

  if(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier)
    return 0;

  if(istrue(self.tutorial_lead_collected))
    return 0;

  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_8A2A0B936CCCC3078547970A8B");
  var_1 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");
  var_2 = var_1 - var_0;

  if(var_2 == 0)
    return 0;

  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B")) {
    if(istrue(self.tutorial_lead_collected))
      var_3++;
  }

  var_8 = int(clamp(var_1 - 2, 1, 3));

  if(var_3 < var_8 + 1)
    var_4 = 1;

  if(var_4) {
    if(var_1 == 2)
      var_9 = 1;
    else
      var_9 = var_0 / var_1 <= 0.7;

    if(var_9)
      return 1;
  }

  return 0;
}

vehicle_compass_br_shouldbevisibletoplayer(var_0) {
  var_1 = spawncovernode(var_0, (0, randomint(360), 0), "_encstr_AFFF0C6E8FE899DDE6174B068510");
}

damage_multiplier() {
  switch (level.mapname) {
    case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
      var_0 = (1184, 1849, 158);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      var_0 = (812, -2969, 286);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (812, -3034, 286);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (741, 2789, 252);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (677, 2852, 252);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      var_0 = (-548, -530, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (6191, 148, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      var_0 = (6297, 215, 270);
      thread vehicle_compass_br_shouldbevisibletoplayer(var_0);
      break;
    default:
      break;
  }
}