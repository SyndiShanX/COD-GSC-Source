/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_rugby.gsc
***********************************************/

main() {
  setup_callbacks();
  _id_131E0();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::death_explode;
  level.bot_funcs["_encstr_99EB0E12DB5279E596CEBBD2C11B30F8"] = ::crate_can_use;
  level.bot_funcs["_encstr_952F16EAC5AAB7BE35F36850974D73AFF26D486EDBA24503"] = undefined;
  level.bot_funcs["_encstr_AAFB16340390CF51A74B1F274B459915D0AEEE7ED818951A"] = ::currentintelindex;
}

_id_131E0() {
  deathcashcollected();
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = debug_display_track_tilts(["_encstr_ABE2089FA7E2116055EA", "_encstr_8AF106FA2C0FD2CD"]);

  if(var_0) {
    level.protect_radius = 1200;
    level.bot_gametype_precaching_done = 1;
  }
}

death_explode() {
  self notify("_encstr_858610B10A2B5860B38F252B8FDBF81B1B22");
  self endon("_encstr_858610B10A2B5860B38F252B8FDBF81B1B22");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  strafe_acceleration();
  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_B68D13D9272BDC16C856AFBD264D951B474B3BB2CD", 1);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);
  self.next_time_hunt_carrier = gettime();

  if(!isDefined(level.next_game_update_time))
    level.next_game_update_time = gettime() + 100;

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time)
      level.next_game_update_time = gettime() + 100;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_12DD4)) {
      if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal("_encstr_87F010804A47F7CEE345840E312F1083AFF2", undefined) == 0) {
        var_0 = ::_id_12DCF;
        var_1 = spawnStruct();
        var_1.object = level.rugby.activejuggcrates[0];
        var_1.script_goal_radius = 16;
        var_1.should_abort = level.bot_funcs["_encstr_AAFB16340390CF51A74B1F274B459915D0AEEE7ED818951A"];
        var_1.action_thread = var_0;
        var_2 = getclosestpointonnavmesh(level.rugby.activejuggcrates[0].origin, self);
        scripts\mp\bots\bots_strategy::bot_new_tactical_goal("_encstr_87F010804A47F7CEE345840E312F1083AFF2", var_2, 99, var_1);
      }

      continue;
    }

    if(self == level._id_12DD4) {
      if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
        var_3 = level.rugby.endzones[self.team][0];
      else
        var_3 = level.rugby.endzones[scripts\engine\utility::get_enemy_team(self.team)][0];

      var_4 = propminigamesetting(var_3.trigger);
      self botsetscriptgoal(var_4.origin, 0, "_encstr_99CC09DA9020C4ECD149AD", var_4.angles[1]);
      var_5 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
      continue;
    }

    if(level._id_12DD4.team == self.team) {
      if(!scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_guard_player(level._id_12DD4, 400);

      continue;
    }

    if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level._id_12DD4.origin + (0, 0, 77), 0, self)) {
      self botsetscriptgoal(level._id_12DD4.origin, 16, "_encstr_9ACC05B4156DF3");
      self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
    }
  }
}

propminigamesetting(var_0) {
  if(var_0.bottargets.size >= 2) {
    var_1 = scripts\engine\utility::array_randomize(var_0.bottargets);
    return var_1[0];
  } else
    return var_0.bottargets[0];
}

currentintelindex(var_0) {
  if(isDefined(level._id_12DD4))
    return 1;

  return 0;
}

_id_12DCF(var_0) {
  var_1 = vehicle_isfriendlytoteam(_encstr_91C21F68C26A2BF3D37B98A15096D983150AC8B08BC757201385B42E41EA816F7E::remove_spawn_disable_struct() + 2, "_encstr_93CA0E6B6829AF391767C2FB551D5274", randomint(100) > 50);
  self botclearscriptgoal();

  if(var_1) {
    return;
  }
  return;
}

vehicle_isfriendlytoteam(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") == 1)
    var_4 = 40;
  else if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") >= 2)
    var_4 = 80;

  if(randomint(100) < var_4 && !(isDefined(var_3) && var_3)) {
    self botsetstance("_encstr_922406F1A6FD5E05");
    wait 0.2;
  }

  if(self botgetdifficultysetting("_encstr_B4EF0E6F49A68AECB861D86DD9D80592") > 0 && !var_2) {}

  self botpressbutton("_encstr_AB19049D0FC0", var_0);
  var_5 = scripts\mp\bots\bots_util::bot_usebutton_wait(var_0, var_1, "_encstr_8B531057E656F5D2374756E439AE0E1DCA8C");
  self botsetstance("_encstr_8BBA05185F8B99");
  self botclearbutton("_encstr_AB19049D0FC0");
  var_6 = var_5 == var_1;
  return var_6;
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

strafe_acceleration() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }
  level.bots_gametype_initialized = 1;
}

deathcashcollected() {
  wait 1.0;
  death_killstreak_watcher(level.rugby.endzones["_encstr_9A8507BA4040188D08"][0].trigger);
  death_killstreak_watcher(level.rugby.endzones["_encstr_8E8405EA382B2A"][0].trigger);
  level.bot_set_objective_bottargets = 1;
}

death_killstreak_watcher(var_0) {
  if(!isDefined(var_0.bottargets))
    var_0.bottargets = _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_get_valid_nodes_in_trigger(var_0);
}

_id_13F86() {
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

debug_display_track_tilts(var_0) {
  var_1 = 0;

  foreach(var_3 in level.rugby.endzones) {}

  if(!var_1)
    currentvalue();

  return !var_1;
}

currentvalue() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.rugby.endzones) {
    var_0[var_2] = scripts\engine\utility::random(var_4[0].trigger.bottargets).origin;
    var_1[var_2] = "_encstr_836105A5EFB2E5" + var_4[0].trigger.objectivekey;
    var_2++;
  }

  _encstr_99EB29139F63436FF3C627E2B8AFB8A8838FC7BB256D57D73CFB0D53A5CAE3556EDBF76BBD08EBDDBFE02B::bot_cache_entrances(var_0, var_1);
}