/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 24.gsc
*************************************************/

main() {
  if(isDefined(level._id_3FD9) && level._id_3FD9) {
    return;
  }
  if(getdvarint("#x3a8fb0620196c6263") == 1) {
    return;
  }
  _id_D795();
  _id_09F7::_id_D7FB();
  level._id_20EE = ::_func_0018;
  level._id_20EF = ::_func_0019;

  if(isDefined(level._id_2824)) {
    [[level._id_2824]]();
  } else {
    _id_09F4::_id_2823();
  }

  _id_09F6::init();
  level thread init();
  _id_95BC();
}

_id_D795() {
  level._id_279D = [];
  level._id_279D["bots_spawn"] = ::spawn_bots;
  level._id_279D["bots_add_scavenger_bag"] = ::_id_26F3;
  level._id_279D["bots_add_to_level_targets"] = ::scripts\mp\bots\bots_util::_id_26F5;
  level._id_279D["bots_remove_from_level_targets"] = ::scripts\mp\bots\bots_util::_id_28A6;
  level._id_279D["think"] = ::_id_28F8;
  level._id_279D["on_killed"] = ::_id_AA4D;
  level._id_279D["should_do_killcam"] = ::_id_28D6;
  level._id_279D["get_attacker_ent"] = ::scripts\mp\bots\bots_util::_id_27C5;
  level._id_279D["should_pickup_weapons"] = ::_id_28D8;
  level._id_279D["on_damaged"] = ::_id_2758;
  level._id_279D["gametype_think"] = ::_id_456D;
  level._id_279D["leader_dialog"] = ::scripts\mp\bots\bots_util::_id_2832;
  level._id_279D["player_spawned"] = ::_id_2890;
  level._id_279D["should_start_cautious_approach"] = _id_09F9::_id_DADB;
  level._id_279D["know_enemies_on_start"] = ::_id_2828;
  level._id_279D["bot_get_rank_xp"] = ::_id_27CE;
  level._id_279D["ai_3d_sighting_model"] = ::_id_26EC;
  level._id_279D["dropped_weapon_think"] = ::_id_2901;
  level._id_279D["dropped_weapon_cancel"] = ::_id_DAE0;
  level._id_279D["crate_can_use"] = ::_id_3E70;
  level._id_279D["crate_low_ammo_check"] = ::_id_3E7A;
  level._id_279D["crate_should_claim"] = ::_id_3E7E;
  level._id_279D["crate_wait_use"] = ::_id_3E7F;
  level._id_279D["crate_in_range"] = ::_id_3E76;
  level._id_279D["post_teleport"] = ::_id_2892;
  level._id_279D["bot_set_difficulty"] = ::scripts\mp\bots\bots_util::_id_28C4;
  level._id_279D["bot_set_personality"] = ::scripts\mp\bots\bots_util::_id_28C8;
  level._id_279D["bot_think_watch_enemy"] = ::_id_2904;
  level._id_279D["bot_think_tactical_goals"] = _id_09F9::_id_2902;
  level._id_279D["bot_bots_enabled_or_added"] = ::scripts\mp\bots\bots_util::_id_270B;
  level._id_279D["revive_think"] = ::_id_2900;
  level._id_28A1 = _id_09F7::_id_28A0;
  level._id_278F["capture"] = _id_09F9::_id_5AC1;
  level._id_278F["capture_zone"] = _id_09F9::_id_5AC2;
  level._id_278F["protect"] = _id_09F9::_id_5AC4;
  level._id_278F["protect_zone"] = _id_09F9::_id_5AC5;
  level._id_278F["bodyguard"] = _id_09F9::_id_5AC0;
  level._id_278F["patrol"] = _id_09F9::_id_5AC3;
  scripts\mp\bots\bots_gametype_war::_id_D795();
}

_id_00F7(var_0, var_1) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["leader_dialog"])) {
    self[[level._id_279D["leader_dialog"]]](var_0, var_1);
  }
}

init() {
  thread _id_A0E8();
  thread _id_2908();
  _id_8152();

  if(!_id_DBE0()) {
    return;
  }
  _id_C1A1();
  setmatchdata("hasBots", 1);
  level thread _id_273D();
}

_id_8152() {
  if(!isDefined(level._id_3E97)) {
    level._id_3E97 = 500;
  }

  if(!isDefined(level._id_3E96)) {
    level._id_3E96 = 3000;
  }

  level._id_2878 = 3000;
  level._id_28A8 = "iw6_panzerfaust3";
  level._id_2789 = "s4_me_knife";
  level._id_110E1 = _func_00F4();
  level._id_2833 = getEntArray("bot_light_area", "targetname");
  level._id_2759 = getEntArray("bot_dark_area", "targetname");
  _id_8153();
  level._id_2915 = 1;
}

_id_8153() {
  if(isDefined(level._id_F039)) {
    var_0 = [[level._id_F039]]();
    level._id_2850 = 0;
    level._id_284D = 0;
    level._id_2851 = 0;
    level._id_284E = 0;
    level._id_2852 = 0;
    level._id_284F = 0;

    if(var_0.size > 1) {
      level._id_2850 = var_0[0].origin[0];
      level._id_284D = var_0[0].origin[0];
      level._id_2851 = var_0[0].origin[1];
      level._id_284E = var_0[0].origin[1];
      level._id_2852 = var_0[0].origin[2];
      level._id_284F = var_0[0].origin[2];

      for(var_1 = 1; var_1 < var_0.size; var_1++) {
        var_2 = var_0[var_1].origin;

        if(var_2[0] < level._id_2850) {
          level._id_2850 = var_2[0];
        }

        if(var_2[0] > level._id_284D) {
          level._id_284D = var_2[0];
        }

        if(var_2[1] < level._id_2851) {
          level._id_2851 = var_2[1];
        }

        if(var_2[1] > level._id_284E) {
          level._id_284E = var_2[1];
        }

        if(var_2[2] < level._id_2852) {
          level._id_2852 = var_2[2];
        }

        if(var_2[2] > level._id_284F) {
          level._id_284F = var_2[2];
        }
      }
    }

    level._id_284C = ((level._id_2850 + level._id_284D) / 2, (level._id_2851 + level._id_284E) / 2, (level._id_2852 + level._id_284F) / 2);
  }
}

_id_2892() {
  level._id_2915 = undefined;
  level._id_27FD = undefined;
  _id_8153();
  level._id_2915 = 1;
}

_id_DBE0() {
  return 1;
}

_id_C1A1() {
  wait 1;

  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      if(isalive(var_1)) {
        var_1._id_5553 = 1;
        var_1._id_28F7 = var_1.team;
        var_1._id_28E5 = 1;
        var_1 thread[[level._id_279D["think"]]]();
        continue;
      }
    }
  }
}

_id_2890() {
  _id_28C6();
}

_id_28C6() {
  if(!isDefined(self._id_2735)) {
    if(!_id_27A4()) {
      while(!isDefined(level._id_2849)) {
        wait 0.05;
      }

      if(isDefined(self._id_AD35)) {
        self._id_2735 = [[self._id_AD35]]();
      } else {
        self._id_2735 = _id_09F7::_id_28CE();
      }
    } else
      self._id_2735 = self.class;
  }
}

_id_10A7D() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isai(var_0) && level.players.size > 0) {
      level._id_B787 = scripts\engine\utility::array_add(level._id_B787, var_0);
      childthread _id_2949(var_0);
      childthread _id_2948(var_0);
      childthread _id_294A(var_0);
    }
  }
}

_id_2949(var_0) {
  var_0 endon("bots_human_disconnected");

  while(!scripts\engine\utility::array_contains(level.players, var_0)) {
    wait 0.05;
  }

  var_0 notify("bots_human_spawned");
}

_id_2948(var_0) {
  var_0 endon("bots_human_spawned");
  var_0 waittill("disconnect");
  var_0 notify("bots_human_disconnected");
}

_id_294A(var_0) {
  var_0 scripts\engine\utility::waittill_any_2("bots_human_spawned", "bots_human_disconnected");
  level._id_B787 = scripts\engine\utility::array_remove(level._id_B787, var_0);
}

_id_A0DD() {
  level._id_B787 = [];
  childthread _id_10A7D();

  for(;;) {
    if(level._id_B787.size > 0 || istrue(level._id_5E62)) {
      level._id_AF78 = 1;
    } else {
      level._id_AF78 = 0;
    }

    wait 0.5;
  }
}

_id_271B(var_0) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    return 1;
  }

  if(!level.teambased) {
    return 1;
  }

  if(scripts\mp\teams::_id_6AD1(var_0)) {
    return 1;
  }

  return 0;
}

_id_26FA() {
  if(isDefined(level._id_2941) && level._id_2941) {
    return 0;
  }

  if(isDefined(level._id_9BEF) && level._id_9BEF) {
    return 0;
  }

  return 1;
}

_id_273D() {
  level endon("game_ended");
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level._id_AF78 = 0;
  childthread _id_A0DD();
  var_0 = 1.5;
  _func_0026();

  for(;;) {
    if(level._id_AF78) {
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
      continue;
    }

    level._id_2854["allies"] = 0;
    level._id_2854["axis"] = 0;
    _func_0025();
    var_1 = _func_0024();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(var_1[var_2].team == "free") {
        var_1[var_2]._id_26EB._id_28F7 = "autoassign";
      } else {
        var_1[var_2]._id_26EB._id_28F7 = var_1[var_2].team;
      }

      if(var_1[var_2]._id_024E) {
        var_1[var_2]._id_26EB scripts\mp\playerlogic::_id_E37D();
        var_1[var_2]._id_26EB._id_2C68 = 1;
        var_1[var_2]._id_26EB _id_07F2::_id_1F1D();
        var_3 = "class" + randomint(3);
        var_1[var_2]._id_26EB notify("loadout_class_selected", var_3);
        var_1[var_2]._id_26EB notify("luinotifyserver", "class_select", var_3);
        continue;
      }

      var_1[var_2]._id_26EB._id_5553 = 1;
      var_1[var_2]._id_26EB thread[[level._id_279D["think"]]]();
    }

    _id_FB87();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

_id_285B() {
  level endon("game_ended");
  self notify("bot_monitor_team_limits");
  self endon("bot_monitor_team_limits");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  var_0 = 1.5;

  for(;;) {
    level._id_2854["allies"] = 0;
    level._id_2854["axis"] = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.team) && (var_2.team == "allies" || var_2.team == "axis")) {
        level._id_2854[var_2.team]++;
      }
    }

    _id_FB87();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }
}

_id_FB87() {
  if(isDefined(level.agentarray)) {
    foreach(var_1 in level.agentarray) {
      if(isDefined(var_1.isactive) && var_1.isactive) {
        if(scripts\mp\utility\entity::_id_8A94(var_1) && isDefined(var_1.team) && (var_1.team == "allies" || var_1.team == "axis")) {
          level._id_2854[var_1.team]++;
        }
      }
    }
  }
}

_id_27CD() {
  if(isDefined(self.team)) {
    return self.team;
  }

  if(isDefined(self.pers["team"])) {
    return self.pers["team"];
  }

  return undefined;
}

_id_27C2() {
  foreach(var_1 in level.players) {
    if(!isai(var_1) && var_1 ishost()) {
      return var_1 _id_27CD();
    }
  }

  return "spectator";
}

_id_27C4() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      if(var_4 ishost()) {
        var_0 = 1;
      }

      if(_id_B578(var_4)) {
        var_1 = 1;

        if(var_4 ishost()) {
          var_2 = 1;
        }
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

_id_B578(var_0) {
  if(isDefined(var_0.team) && var_0.team != "spectator") {
    return 1;
  }

  if(isDefined(var_0._id_E3E6) && var_0._id_E3E6) {
    return 1;
  }

  if(var_0 _meth_81D3() && isDefined(var_0.team) && var_0.team == "spectator") {
    return 1;
  }

  return 0;
}

_id_27C3() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      if(var_4 ishost()) {
        var_0 = 1;
      }

      if(isDefined(var_4.class)) {
        var_1 = 1;

        if(var_4 ishost()) {
          var_2 = 1;
        }
      }
    }
  }

  return var_2 || var_1 && !var_0;
}

_id_2737() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(isDefined(var_2) && isDefined(var_2.team)) {
      var_0 = _id_3326(var_0, "all");
      var_0 = _id_3326(var_0, var_2.team);

      if(isbot(var_2)) {
        var_0 = _id_3326(var_0, "bots");
        var_0 = _id_3326(var_0, "bots_" + var_2.team);
        continue;
      }

      var_0 = _id_3326(var_0, "humans");
      var_0 = _id_3326(var_0, "humans_" + var_2.team);
    }
  }

  return var_0;
}

_id_3326(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = [];
  }

  if(!isDefined(var_0[var_1])) {
    var_0[var_1] = 0;
  }

  var_0[var_1] = var_0[var_1] + 1;
  return var_0;
}

_id_3327(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0[var_1])) {
    return 0;
  }

  return var_0[var_1];
}

_id_A1D0(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isDefined(var_5.team)) {
      continue;
    }
    if(isDefined(var_5._id_3B81) && var_5._id_3B81 && isbot(var_5) && var_5.team == var_1) {
      var_5._id_28F7 = var_2;

      if(isDefined(var_3)) {
        var_5 scripts\mp\bots\bots_util::_id_28C4(var_3);
      }

      var_5 notify("luinotifyserver", "team_select", _id_284A(var_2));
      wait 0.05;
      var_5 notify("loadout_class_selected", var_5._id_2735);
      var_0--;

      if(var_0 <= 0) {
        break;
      } else
        wait 0.1;
    }
  }
}

_id_294C(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(isDefined(var_3._id_3B81) && var_3._id_3B81 && isbot(var_3) && var_3.team == var_0) {
      if(var_1 != var_3 _meth_802F()) {
        var_3 scripts\mp\bots\bots_util::_id_28C4(var_1);
      }
    }
  }
}

_id_2781() {
  kick(self._id_5501, "EXE/PLAYERKICKED_BOT_BALANCE");
  wait 0.1;
}

_id_4FE1(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(isDefined(var_4._id_3B81) && var_4._id_3B81 && isbot(var_4) && (!isDefined(var_1) || isDefined(var_4.team) && var_4.team == var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    if(!var_2[var_6] scripts\cp_mp\utility\player_utility::_isalive()) {
      var_2[var_6] _id_2781();
      var_2 = scripts\engine\utility::array_remove(var_2, var_2[var_6]);
      var_0--;
    }
  }

  for(var_6 = var_2.size - 1; var_6 >= 0; var_6--) {
    if(var_0 <= 0) {
      break;
    }

    var_2[var_6] _id_2781();
    var_0--;
  }
}

_id_284A(var_0) {
  if(var_0 == "axis") {
    return 0;
  } else if(var_0 == "allies") {
    return 1;
  } else if(var_0 == "autoassign" || var_0 == "random") {
    return 2;
  } else {
    return 3;
  }
}

_id_E0E9(var_0, var_1, var_2) {
  var_3 = gettime() + 60000;

  while(!self _meth_806A()) {
    if(gettime() >= var_3) {
      kick(self._id_5501, "EXE/PLAYERKICKED_BOT_BALANCE");
      var_2._id_0E06 = 1;
      return;
    }

    wait 0.05;

    if(!isDefined(self)) {
      var_2._id_0E06 = 1;
      return;
    }
  }

  if(!scripts\mp\bots\bots_util::_id_48DA()) {
    var_4 = randomfloatrange(0.25, 2.0);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_4);
  }

  if(!isDefined(self)) {
    var_2._id_0E06 = 1;
    return;
  }

  self _meth_83D3();
  self._id_5553 = 1;
  self._id_28F7 = var_0;

  if(isDefined(var_2._id_4989)) {
    scripts\mp\bots\bots_util::_id_28C4(var_2._id_4989);
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
  }

  self thread[[level._id_279D["think"]]]();
  var_2._id_C0A9 = 1;
}

spawn_bots(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime() + 15000;
  var_7 = [];
  var_8 = var_7.size;

  while(level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && var_7.size < var_0 && gettime() < var_6) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.05);
    var_9 = undefined;

    if(isbotmatchmakingenabled()) {
      if(level.teambased) {
        var_9 = addmpbottoteam(var_1);
      } else {
        var_9 = addmpbottoteam("none");
      }
    } else
      var_9 = addbot("");

    if(!isDefined(var_9)) {
      if(isDefined(var_3) && var_3) {
        if(isDefined(var_4)) {
          self notify(var_4);
        }

        return;
      }

      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      continue;
    } else {
      var_10 = spawnStruct();
      var_10._id_26EB = var_9;
      var_10._id_C0A9 = 0;
      var_10._id_0E06 = 0;
      var_10.index = var_8;
      var_10._id_4989 = var_5;
      var_7[var_7.size] = var_10;
      var_10._id_26EB thread _id_E0E9(var_1, var_2, var_10);
      var_8++;
    }
  }

  var_11 = 0;
  var_6 = gettime() + 60000;

  while(var_11 < var_7.size && gettime() < var_6) {
    var_11 = 0;

    foreach(var_10 in var_7) {
      if(var_10._id_C0A9 || var_10._id_0E06) {
        var_11++;
      }
    }

    wait 0.05;
  }

  if(isDefined(var_4)) {
    self notify(var_4);
  }
}

_id_27A5() {
  if(scripts\mp\utility\game::matchmakinggame() && self.sessionteam != "none") {
    var_0 = 0;
  } else if(!scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::_id_47C7() && scripts\mp\utility\game::_id_4C79()) {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  return !var_0;
}

_id_27A4() {
  return istrue(level._id_2943);
}

_id_280E() {
  if(!isDefined(self._id_3802)) {
    if(!_id_27A4()) {
      return 0;
    }
  }

  return 1;
}

_id_28F8() {
  self notify("bot_think");
  self endon("bot_think");
  self endon("disconnect");

  while(!isDefined(self.pers["team"])) {
    wait 0.05;
  }

  level._id_7547 = 1;

  if(_id_27A5()) {
    self._id_28F7 = self.pers["team"];
  }

  var_0 = self._id_28F7;

  if(!isDefined(var_0)) {
    var_0 = self.pers["team"];
  }

  self._id_5501 = self getentitynumber();
  var_1 = 0;

  if(!isDefined(self._id_28E5)) {
    var_1 = 1;
    self._id_28E5 = 1;

    if(!_id_27A5()) {
      var_2 = self.pers["team"] != "spectator" && !isDefined(self._id_28F7);

      if(!var_2) {
        var_3 = isDefined(self._id_28F7) && self._id_28F7 != self.pers["team"];

        if(var_3) {
          self notify("luinotifyserver", "team_select", _id_284A(var_0));
        }

        wait 0.5;

        if(self.pers["team"] == "spectator") {
          _id_2781();
          return;
        }
      }
    }
  }

  for(;;) {
    scripts\mp\bots\bots_util::_id_28C4(self _meth_802F());
    self._id_4989 = self _meth_802F();
    var_4 = self _meth_8030("advancedPersonality");

    if(var_1 && isDefined(var_4) && var_4 != 0) {
      _id_09F7::_id_2705();
    }

    _id_09F7::_id_2701();

    if(var_1) {
      if(isDefined(level._id_279D) && isDefined(level._id_279D["class_select_override"])) {
        self[[level._id_279D["class_select_override"]]]();
      } else {
        _id_28C6();

        if(!_id_27A4()) {
          if(isDefined(self._id_3B86) && self._id_3B86 == gettime()) {
            waittillframeend;
            waittillframeend;
          }

          self notify("loadout_class_selected", self._id_2735);
        }
      }

      self._id_0196 = "enemyselector_default_bots";

      if(self.health == 0) {
        self._id_2DEA = 1;
        self notify("bot_ready_to_spawn");
        self waittill("spawned_player");
        self._id_2DEA = undefined;
        self._id_28F7 = var_0;
      }

      if(isDefined(level._id_279D) && isDefined(level._id_279D["know_enemies_on_start"])) {
        self thread[[level._id_279D["know_enemies_on_start"]]]();
      }

      var_1 = 0;
    }

    _id_09F6::_id_2858();
    _id_2859();
    _id_28A9();
    wait 0.1;
    self waittill("death");

    if(isDefined(level._id_279D) && isDefined(level._id_279D["post_death_func"])) {
      self[[level._id_279D["post_death_func"]]]();
    }

    _id_C68C();
    self waittill("spawned_player");
  }
}

_id_2859() {
  if(scripts\mp\tweakables::_id_6E14("game", "onlyheadshots")) {
    self _meth_8054("only_headshots", 1);
  }
}

_id_C68C() {
  self endon("started_spawnPlayer");

  while(!self._id_10849) {
    wait 0.05;
  }

  if(scripts\mp\playerlogic::_id_A408()) {
    while(self._id_10849) {
      if(self.sessionstate == "spectator") {
        if(getdvarint("#x3cb1391c761400cd7") == 0 || self.pers["lives"] > 0) {
          self _meth_804E("use", 0.5);
        }
      }

      wait 1.0;
    }
  }
}

_id_27CE() {
  if(scripts\mp\bots\bots_util::_id_2811() == 0) {
    if(!isDefined(self.pers["rankxp"])) {
      self.pers["rankxp"] = 0;
    }

    return self.pers["rankxp"];
  }

  var_0 = self _meth_802F();
  var_1 = "bot_rank_" + var_0;

  if(isDefined(self.pers[var_1]) && self.pers[var_1] > 0) {
    return self.pers[var_1];
  }

  var_2 = _id_28A2(var_0);
  var_3 = var_2["rank"];
  var_4 = var_2["prestige"];
  var_5 = scripts\mp\rank::_id_6CDD(var_3);
  var_6 = var_5 + scripts\mp\rank::_id_6CDE(var_3);
  var_7 = randomintrange(var_5, var_6 + 1);
  self.pers[var_1] = var_7;
  return var_7;
}

_id_26EC(var_0) {
  thread _id_26ED(var_0);
}

_id_26ED(var_0) {
  var_0 endon("disconnect");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isalive(self) && !self _meth_8028(var_0) && scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), var_0.origin, self _meth_8032())) {
      self _meth_8034(var_0, var_0.origin);
    }

    wait 0.1;
  }
}

_id_28A2(var_0) {
  var_1 = [];
  var_1["rank"] = 0;
  var_1["prestige"] = 0;

  if(var_0 == "default") {
    return var_1;
  }

  if(!isDefined(level._id_28AB)) {
    level._id_28AB = [];
    level._id_28AB["recruit"][0] = 0;
    level._id_28AB["recruit"][1] = 1;
    level._id_28AB["regular"][0] = 3;
    level._id_28AB["regular"][1] = 18;
    level._id_28AB["hardened"][0] = 22;
    level._id_28AB["hardened"][1] = 38;
    level._id_28AB["veteran"][0] = 40;
    level._id_28AB["veteran"][1] = 55;
  }

  if(!isDefined(level._id_28AA)) {
    level._id_28AA = [];
    level._id_28AA["recruit"][0] = 0;
    level._id_28AA["recruit"][1] = 0;
    level._id_28AA["regular"][0] = 0;
    level._id_28AA["regular"][1] = 0;
    level._id_28AA["hardened"][0] = 0;
    level._id_28AA["hardened"][1] = 0;
    level._id_28AA["veteran"][0] = 0;
    level._id_28AA["veteran"][1] = 9;
  }

  var_1["rank"] = randomintrange(level._id_28AB[var_0][0], level._id_28AB[var_0][1] + 1);
  var_1["prestige"] = randomintrange(level._id_28AA[var_0][0], level._id_28AA[var_0][1] + 1);
  return var_1;
}

_id_3E70(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !_id_09F4::_id_2809(var_0.cratetype)) {
    return 0;
  }

  return 1;
}

_id_64FE() {
  var_0 = undefined;
  var_1 = getEntArray("player", "classname");

  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2]) && isDefined(var_1[var_2]._id_3B81) && var_1[var_2]._id_3B81 && !isai(var_1[var_2]) && (!isDefined(var_0) || var_0.team == "spectator")) {
        var_0 = var_1[var_2];
      }
    }
  }

  return var_0;
}

_id_2758(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(var_2 == "MOD_FALLING" || var_2 == "MOD_SUICIDE") {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!isDefined(var_4)) {
    if(!isDefined(var_0)) {
      return;
    }
    var_4 = var_0;
  }

  if(isDefined(var_4)) {
    if(isDefined(self._id_5D68)) {
      self[[self._id_5D68]](var_0, var_1, var_2, var_3, var_4, var_5);
    }

    if(level.teambased) {
      if(isDefined(var_4.team) && var_4.team == self.team) {
        return;
      } else if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
        return;
      }
    }

    var_6 = scripts\mp\bots\bots_util::_id_27C5(var_0, var_4);

    if(isDefined(var_6)) {
      self _meth_8050(var_6);
    }
  }

  if(isagent(self)) {
    self notify("agentDamage");
  }
}

_id_AA4D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self _meth_802A();
  self _meth_802B();
  var_10 = scripts\mp\bots\bots_util::_id_27C5(var_1, var_0);

  if(isDefined(var_10) && (var_10.classname == "script_vehicle" || var_10.classname == "script_model") && isDefined(var_10._id_77E7)) {
    var_11 = self _meth_8030("launcherRespawnChance");

    if(randomfloat(1.0) < var_11) {
      self._id_C68D = 1;
    }
  }
}

_id_28D6() {
  if(istrue(game["isLaunchChunk"])) {
    return 1;
  }

  var_5 = 0.0;
  var_6 = self _meth_802F();

  if(var_6 == "recruit") {
    var_5 = 0.1;
  } else if(var_6 == "regular") {
    var_5 = 0.4;
  } else if(var_6 == "hardened") {
    var_5 = 0.7;
  } else if(var_6 == "veteran") {
    var_5 = 1.0;
  }

  return randomfloat(1.0) < 1.0 - var_5;
}

_id_28D8() {
  return 1;
}

_id_28A9() {
  self thread[[level._id_279D["bot_think_watch_enemy"]]]();
  self thread[[level._id_279D["bot_think_tactical_goals"]]]();
  self thread[[level._id_279D["dropped_weapon_think"]]]();
  self thread[[level._id_279D["revive_think"]]]();
  thread _id_28F9();
  thread _id_28FA();
  thread _id_09F4::_id_28FD();
  thread _id_09F4::_id_2903();
  thread _id_28FC();
  thread _id_28FB();
  thread _id_28FF();
}

_id_E02F(var_0, var_1) {
  return distancesquared(var_0.origin, self._id_39EF) < distancesquared(var_1.origin, self._id_39EF);
}

_id_28FB() {
  self notify("bot_think_dynamic_doors");
  self endon("bot_think_dynamic_doors");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = self _meth_857B("door", 64);

    if(isDefined(var_0)) {
      self._id_39EF = var_0;
      var_1 = _func_0098("dynamic_door", "targetname", var_0, 64);

      if(var_1.size > 0) {
        var_1 = scripts\engine\utility::_id_1BD6(var_1, ::_id_E02F);
        var_2 = var_1[0];

        if(isDefined(var_2._id_E747) && var_2 _id_07CA::_id_4DCC()) {
          var_2 thread _id_07CA::_id_3423(self);
        }
      }

      self._id_39EF = undefined;
    }

    wait 0.05;
  }
}

_id_28FF() {
  self notify("bot_think_nvg");
  self endon("bot_think_nvg");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();

  for(;;) {
    var_1 = 0;
    var_2 = 0;

    if(isDefined(level._id_2833)) {
      foreach(var_4 in level._id_2833) {
        if(self istouching(var_4)) {
          var_2 = 1;
          break;
        }
      }
    }

    if(isDefined(level._id_2759)) {
      foreach(var_4 in level._id_2759) {
        if(self istouching(var_4)) {
          var_1 = 1;
          break;
        }
      }
    }

    if(istrue(self._id_82CC)) {
      var_2 = 1;
    }

    if(var_1 || var_0 && !var_2) {
      self _meth_8054("dark_area", 1);
      self._id_7DF8 = 1;
    } else if(!var_1 && istrue(self._id_7DF8)) {
      self _meth_8054("dark_area", 0);
      self._id_7DF8 = 0;
    }

    wait 0.25;
  }
}

_id_2904(var_0) {
  var_1 = "spawned_player";

  if(isDefined(var_0) && var_0) {
    var_1 = "death";
  }

  self notify("bot_think_watch_enemy");
  self endon("bot_think_watch_enemy");
  self endon(var_1);
  self endon("disconnect");
  level endon("game_ended");
  self._id_8F1D = 0;

  for(;;) {
    if(isDefined(self._id_0192)) {
      if(self _meth_8028(self._id_0192)) {
        self._id_8F1D = gettime();
      }
    }

    wait 0.05;
  }
}

_id_2901() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = "s4_throwing_knife_mp";

  for(;;) {
    var_1 = 0;

    if(scripts\mp\bots\bots_util::_id_27C7(0.33)) {
      if(self[[level._id_279D["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::_id_280F()) {
        var_2 = getEntArray("dropped_weapon", "targetname");
        var_3 = scripts\engine\utility::_id_6369(self.origin, var_2);

        if(var_3.size > 0) {
          var_4 = var_3[0];
          _id_28B2(var_4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::_id_27F7() && !scripts\mp\bots\bots_util::_id_280F() && self _meth_8030("strategyLevel") > 0) {
      var_5 = self hasweapon(var_0);
      var_6 = var_5 && self _meth_8109(var_0) == 0;

      if(var_6) {
        if(isDefined(self._id_7098)) {
          wait 5.0;
          continue;
        }

        var_7 = getEntArray("dropped_knife", "targetname");
        var_8 = scripts\engine\utility::_id_6369(self.origin, var_7);

        foreach(var_10 in var_8) {
          if(!isDefined(var_10)) {
            continue;
          }
          if(!isDefined(var_10._id_2EE3)) {
            var_11 = scripts\mp\bots\bots_util::_id_289B("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::_id_6019, var_10.origin, 32, self);

            if(isDefined(var_10)) {
              var_10._id_39E6 = var_11;
              var_10._id_2EE3 = 1;
            } else
              continue;
          }

          if(isDefined(var_10._id_39E6)) {
            self._id_7098 = 1;
            _id_28B2(var_10);
          }
        }
      } else if(var_5)
        self._id_7098 = undefined;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

_id_28B2(var_0) {
  if(_id_09F9::_id_27ED("seek_dropped_weapon", var_0) == 0) {
    var_1 = undefined;

    if(var_0._id_0481 == "dropped_weapon") {
      var_2 = 1;
      var_3 = self getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(var_0.model == getweaponmodel(var_5)) {
          var_2 = 0;
        }
      }

      if(var_2) {
        var_1 = ::_id_288E;
      }
    }

    var_7 = spawnStruct();
    var_7._id_A860 = var_0;
    var_7._id_CD72 = 12;
    var_7._id_DA6E = level._id_279D["dropped_weapon_cancel"];
    var_7._id_0E86 = var_1;
    _id_09F9::_id_2862("seek_dropped_weapon", var_0.origin, 100, var_7);
  }
}

_id_288E(var_0) {
  self _meth_804E("use", 2);
  wait 2;
}

_id_DAE0(var_0) {
  if(!isDefined(var_0._id_A860)) {
    return 1;
  }

  if(var_0._id_A860._id_0481 == "dropped_weapon") {
    if(scripts\mp\bots\bots_util::_id_27D7() > 0) {
      return 1;
    }
  } else if(var_0._id_A860._id_0481 == "dropped_knife") {
    if(scripts\mp\bots\bots_util::_id_27F7()) {
      self._id_7098 = undefined;
      return 1;
    }
  }

  return 0;
}

_id_3E76(var_0) {
  if(!isDefined(var_0.owner) || var_0.owner != self) {
    if(distancesquared(self.origin, var_0.origin) > 4194304) {
      return 0;
    }
  }

  return 1;
}

_id_2749(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self[[level._id_279D["crate_can_use"]]](var_0);

  if(!var_1) {
    if(scripts\mp\utility\game::getgametype() == "grnd") {
      var_1 = 1;
    }
  }

  if(!var_1) {
    return 0;
  }

  if(!_id_3E79(var_0)) {
    return 0;
  }

  if(level.teambased && isDefined(var_0._id_25F6) && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(!self[[level._id_279D["crate_in_range"]]](var_0)) {
    return 0;
  }

  if(!isDefined(level._id_2723)) {
    return 0;
  }

  if(isDefined(var_0._id_2991)) {
    if(isDefined(level._id_298E) && isDefined(level._id_298E[var_0._id_2991]) && ![[level._id_298E[var_0._id_2991]._id_3201]]()) {
      return 0;
    }

    if(isDefined(var_0._id_4A8D) && isDefined(var_0._id_4A8D[self getentitynumber()]) && var_0._id_4A8D[self getentitynumber()]) {
      return 0;
    }

    if(!self[[level._id_2723[var_0._id_2991]]](var_0)) {
      return 0;
    }
  } else if(_id_27EC(var_0))
    return 0;

  return isDefined(var_0);
}

_id_27EC(var_0) {
  return 0;
}

_id_3E79(var_0) {
  if(!_id_3E75(var_0)) {
    return 0;
  }

  if(!_id_3E78(var_0)) {
    return 0;
  }

  return isDefined(var_0);
}

_id_3E75(var_0) {
  if(isDefined(var_0._id_2991)) {
    return gettime() > var_0._id_0094 + 1000;
  } else {
    return isDefined(var_0._id_504F) && !var_0._id_504F;
  }
}

_id_3E78(var_0) {
  if(!isDefined(var_0._id_AA5C)) {
    _id_3E6E(var_0);
  }

  return isDefined(var_0) && var_0._id_AA5C;
}

_id_A566(var_0, var_1) {
  if(isDefined(var_1._id_2991) && var_1._id_2991 == "scavenger_bag") {
    return abs(var_0.origin[0] - var_1.origin[0]) < 36 && abs(var_0.origin[0] - var_1.origin[0]) < 36 && abs(var_0.origin[0] - var_1.origin[0]) < 18;
  } else {
    var_2 = getdvarfloat("#x3dd0f2c637b8e7fdb");
    var_3 = distancesquared(var_1.origin, var_0.origin + (0, 0, 40));
    return var_3 <= var_2 * var_2;
  }
}

_id_3E6E(var_0) {
  var_0 thread _id_3E7B();
  var_0._id_AA5C = 0;
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0._id_5E94)) {
    var_1 = var_0._id_5E94;
    var_2 = gettime() + 30000;
    var_0._id_5E94 = var_2;
    var_0 notify("path_disconnect");
  }

  wait 0.05;

  if(!isDefined(var_0)) {
    return;
  }
  var_3 = _id_3E74(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_3) && var_3.size > 0) {
    var_0._id_A3FA = var_3;
    var_0._id_AA5C = 1;
  } else {
    var_4 = getdvarfloat("#x3dd0f2c637b8e7fdb");
    var_5 = _func_00B5(var_0.origin, var_4 * 2, 0)[0];
    var_6 = var_0 _meth_8174(0, 0, -1);
    var_7 = undefined;

    if(isDefined(var_0._id_2991) && var_0._id_2991 == "scavenger_bag") {
      if(scripts\mp\bots\bots_util::_id_2891(var_0.origin, var_4)) {
        var_7 = var_0.origin;
      }
    } else
      var_7 = _func_0020(var_0.origin, var_4);

    if(isDefined(var_5) && !var_5 _meth_824A() && isDefined(var_7) && abs(var_5.origin[2] - var_6[2]) < 30) {
      var_0._id_A3FC = [var_7];
      var_0._id_A3FA = [var_5];
      var_0._id_AA5C = 1;
    }
  }

  if(isDefined(var_0._id_5E94)) {
    if(var_0._id_5E94 == var_2) {
      var_0._id_5E94 = var_1;
    }
  }
}

_id_3E74(var_0) {
  var_1 = _func_00B5(var_0.origin, 256, 0);

  for(var_2 = var_1.size; var_2 > 0; var_2--) {
    var_1[var_2] = var_1[var_2 - 1];
  }

  var_1[0] = _func_0080(var_0.origin);
  var_3 = undefined;

  if(isDefined(var_0._id_5E94)) {
    var_3 = _func_03F2();
  }

  var_4 = [];
  var_5 = 1;

  if(!isDefined(var_0._id_2991)) {
    var_5 = 2;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_6 = var_1[var_2];

    if(!isDefined(var_6) || !isDefined(var_0)) {
      continue;
    }
    if(var_6 _meth_824A()) {
      continue;
    }
    if(!_id_A566(var_6, var_0)) {
      if(var_2 == 0) {
        continue;
      } else {
        break;
      }
    }

    wait 0.05;

    if(!isDefined(var_0)) {
      break;
    }

    if(_func_0202(var_0.origin, var_6.origin + (0, 0, 55), 0, var_0)) {
      wait 0.05;

      if(!isDefined(var_0)) {
        break;
      }

      if(!isDefined(var_0._id_5E94)) {
        var_4[var_4.size] = var_6;

        if(var_4.size == var_5) {
          return var_4;
        } else {
          continue;
        }
      }

      var_7 = undefined;
      var_8 = 0;

      while(!isDefined(var_7) && var_8 < 100) {
        var_8++;
        var_9 = randomint(var_3);
        var_10 = _func_03E0(var_9);

        if(isDefined(var_10) && distancesquared(var_6.origin, var_10.origin) > 250000) {
          var_7 = var_10;
        }
      }

      if(isDefined(var_7)) {
        var_11 = scripts\mp\bots\bots_util::_id_289B("GetNodesOnPathCrate", scripts\mp\bots\bots_util::_id_601E, var_6.origin, var_7.origin);

        if(isDefined(var_11)) {
          var_4[var_4.size] = var_6;

          if(var_4.size == var_5) {
            return var_4;
          } else {
            continue;
          }
        }
      }
    }
  }

  return undefined;
}

_id_3E72(var_0) {
  if(isDefined(var_0._id_A3FC)) {
    return var_0._id_A3FC[0];
  }

  if(isDefined(var_0._id_A3FA) && var_0._id_A3FA.size > 0) {
    if(var_0._id_A3FA.size > 1) {
      var_1 = scripts\engine\utility::_id_1BD2(self _meth_804B(var_0._id_A3FA, "node_exposed"));
      return scripts\engine\utility::_id_BFF2(var_1).origin;
    } else
      return var_0._id_A3FA[0].origin;
  }
}

_id_3E73(var_0, var_1) {
  var_2 = _id_3E72(var_0);
  var_2 = _func_02AB(var_2, self);
  var_3 = var_1 * 0.9;
  var_3 = var_3 * var_3;

  if(distancesquared(var_0.origin, var_2) <= var_3) {
    return var_2;
  } else {
    return undefined;
  }
}

_id_28F9() {
  self notify("bot_think_crate");
  self endon("bot_think_crate");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("#x3dd0f2c637b8e7fdb");

  for(;;) {
    var_1 = randomfloatrange(2, 4);
    scripts\engine\utility::_id_108F5("new_crate_to_take", var_1);

    if(isDefined(self._id_298A) && self._id_298A.size == 0) {
      self._id_298A = undefined;
    }

    var_2 = level._id_326E;

    if(!scripts\mp\bots\bots_util::_id_27F7() && isDefined(self._id_298A)) {
      var_2 = scripts\engine\utility::array_combine(var_2, self._id_298A);
    }

    if(isDefined(level._id_28AD) && scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var_2 = scripts\engine\utility::array_combine(var_2, level._id_28AD);
    }

    var_2 = scripts\engine\utility::_id_1BD1(var_2);

    if(var_2.size == 0) {
      continue;
    }
    if(_id_09F9::_id_27ED("airdrop_crate") || self _meth_803E() == "tactical" || scripts\mp\bots\bots_util::_id_280F()) {
      continue;
    }
    var_3 = [];

    foreach(var_5 in var_2) {
      if(_id_2749(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }

    var_3 = scripts\engine\utility::_id_1BC1(var_3);

    if(var_3.size == 0) {
      continue;
    }
    var_3 = scripts\engine\utility::_id_6369(self.origin, var_3);
    var_7 = self _meth_815E();

    if(!isDefined(var_7)) {
      continue;
    }
    var_8 = self[[level._id_279D["crate_low_ammo_check"]]]();
    var_9 = (var_8 || randomint(100) < 50) && !_id_078D::_id_85B3();
    var_10 = undefined;

    foreach(var_5 in var_3) {
      var_12 = 0;

      if((!isDefined(var_5.owner) || var_5.owner != self) && !isDefined(var_5._id_2991)) {
        var_13 = [];

        foreach(var_15 in level.players) {
          if(!isDefined(var_15.team)) {
            continue;
          }
          if(!isai(var_15) && level.teambased && var_15.team == self.team) {
            if(distancesquared(var_15.origin, var_5.origin) < 490000) {
              var_13[var_13.size] = var_15;
            }
          }
        }

        if(var_13.size > 0) {
          var_17 = var_13[0] _meth_815E();

          if(isDefined(var_17)) {
            var_12 = 0;

            foreach(var_19 in var_5._id_A3FA) {
              var_12 = var_12 | _func_0158(var_17, var_19, 1);
            }
          }
        }
      }

      if(!var_12) {
        var_21 = isDefined(var_5._id_293E) && isDefined(var_5._id_293E[self.team]) && var_5._id_293E[self.team] > 0;
        var_22 = 0;

        foreach(var_19 in var_5._id_A3FA) {
          var_22 = var_22 | _func_0158(var_7, var_19, 1);
        }

        if(var_22 || var_9 && !var_21) {
          var_10 = var_5;
          break;
        }
      }
    }

    if(isDefined(var_10)) {
      if(self[[level._id_279D["crate_should_claim"]]]()) {
        if(!isDefined(var_10._id_2991)) {
          if(!isDefined(var_10._id_293E)) {
            var_10._id_293E = [];
          }

          var_10._id_293E[self.team] = 1;
        }
      }

      var_26 = spawnStruct();
      var_26._id_A860 = var_10;
      var_26._id_E656 = ::_id_10A29;
      var_26._id_DA6E = ::_id_3E7C;
      var_27 = undefined;

      if(isDefined(var_10._id_2991)) {
        if(isDefined(var_10._id_2990) && var_10._id_2990) {
          var_26._id_CD72 = 16;
          var_26._id_0E86 = undefined;
          var_27 = var_10.origin;
        } else {
          var_26._id_CD72 = 50;
          var_26._id_0E86 = ::_id_FDC4;
          var_28 = _id_3E73(var_10, var_0);

          if(!isDefined(var_28)) {
            continue;
          }
          var_28 = var_28 - var_10.origin;
          var_29 = length(var_28) * randomfloat(1.0);
          var_27 = var_10.origin + vectornormalize(var_28) * var_29 + (0, 0, 12);
        }
      } else {
        var_26._id_0E86 = ::_id_FDCD;
        var_26._id_52CD = ::_id_E8EF;
        var_27 = _id_3E73(var_10, var_0);

        if(!isDefined(var_27)) {
          continue;
        }
        var_26._id_CD72 = var_0 - distance(var_10.origin, var_27 + (0, 0, 40));
        var_27 = var_27 + (0, 0, 24);
      }

      if(isDefined(var_26._id_CD72)) {}

      var_10 notify("path_disconnect");
      wait 0.05;

      if(!isDefined(var_10)) {
        continue;
      }
      _id_09F9::_id_2862("airdrop_crate", var_27, 30, var_26);
    }
  }
}

_id_28DB(var_0) {
  return 1;
}

_id_3E7E() {
  return 1;
}

_id_3E7A() {
  return 0;
}

_id_28DA(var_0) {
  if(getcompleteweaponname(self getcurrentweapon()) == level._id_298E[var_0._id_2991]._id_9F08) {
    return 0;
  }

  return 1;
}

_id_2895(var_0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_03B5);
  wait 1.0;
}

_id_2893(var_0) {
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_func_0375());
  self._id_03B5 = self getcurrentweapon();
}

_id_28DE(var_0) {
  if(scripts\mp\bots\bots_util::_id_27C8(0.66)) {
    var_1 = self _meth_815E();

    if(isDefined(var_0._id_A3FA) && isDefined(var_0._id_A3FA[0]) && isDefined(var_1)) {
      if(_func_0158(var_1, var_0._id_A3FA[0], 1)) {
        if(scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), var_0.origin, self _meth_8032())) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_28DC(var_0) {
  var_1 = self _meth_8195();

  foreach(var_3 in var_1) {
    if(self getweaponammostock(var_3) == 0) {
      return 1;
    }
  }

  return 0;
}

_id_28DD(var_0) {
  return 1;
}

_id_3E7B() {
  self notify("crate_monitor_position");
  self endon("crate_monitor_position");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = self.origin;
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
    if(!scripts\mp\bots\bots_util::_id_2916(self.origin, var_0)) {
      self._id_AA5C = undefined;
      self._id_A3FA = undefined;
      self._id_A3FC = undefined;
    }
  }
}

_id_3E7F() {}

_id_3E7C(var_0) {
  if(!isDefined(var_0._id_A860)) {
    return 1;
  }

  return 0;
}

_id_FDCD(var_0) {
  if(isagent(self)) {
    scripts\common\utility::_id_158A(1);
    var_0._id_A860 _meth_80E0(self);
    wait 0.05;
  }

  self[[level._id_279D["crate_wait_use"]]]();

  if(isDefined(var_0._id_A860.owner) && var_0._id_A860.owner == self) {
    var_1 = level._id_3E97 / 1000 + 0.5;
  } else {
    var_1 = level._id_3E96 / 1000 + 1.0;
  }

  self _meth_804E("use", var_1);

  while(var_1 > 0 && isDefined(var_0._id_A860)) {
    wait 0.05;
    var_1 = var_1 - 0.05;
  }

  if(var_1 > 0) {
    wait(randomfloatrange(0.05, 0.5));
  }

  if(isagent(self)) {
    scripts\common\utility::_id_158A(0);

    if(isDefined(var_0._id_A860)) {
      var_0._id_A860 disableplayeruse(self);
    }
  }

  if(isDefined(var_0._id_A860)) {
    if(!isDefined(var_0._id_A860._id_294D)) {
      var_0._id_A860._id_294D = [];
    }

    var_0._id_A860._id_294D[var_0._id_A860._id_294D.size] = self;
  }
}

_id_FDC4(var_0) {
  if(isagent(self)) {
    scripts\common\utility::_id_158A(1);
    var_0._id_A860 _meth_80E0(self);
    wait 0.05;
  }

  if(isDefined(var_0._id_A860) && isDefined(var_0._id_A860._id_2991)) {
    var_1 = var_0._id_A860._id_2991;

    if(isDefined(level._id_2896[var_1])) {
      self[[level._id_2896[var_1]]](var_0._id_A860);
    }

    if(isDefined(var_0._id_A860)) {
      var_2 = level._id_298E[var_0._id_A860._id_2991]._id_FEE7 / 1000 + 0.5;
      self _meth_804E("use", var_2);
      wait(var_2);

      if(isDefined(level._id_2894[var_1])) {
        self[[level._id_2894[var_1]]](var_0._id_A860);
      }
    }
  }

  if(isagent(self)) {
    scripts\common\utility::_id_158A(0);

    if(isDefined(var_0._id_A860)) {
      var_0._id_A860 disableplayeruse(self);
    }
  }
}

_id_10A29(var_0) {
  thread _id_2921(var_0._id_A860);
}

_id_E8EF(var_0) {
  if(isDefined(var_0._id_A860)) {
    var_0._id_A860._id_293E[self.team] = 0;
  }
}

_id_2921(var_0) {
  var_0 endon("death_or_disconnect");
  var_0 endon("revived");
  level endon("game_ended");
  var_1 = self.team;
  self waittill("death_or_disconnect");

  if(isDefined(var_0)) {
    var_0._id_293E[var_1] = 0;
  }
}

_id_28FA() {
  self notify("bot_think_crate_blocking_path");
  self endon("bot_think_crate_blocking_path");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = getdvarfloat("#x3dd0f2c637b8e7fdb");

  for(;;) {
    wait 3;

    if(self usebuttonpressed()) {
      continue;
    }
    if(scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_1 = level._id_326E;

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(!isDefined(var_3)) {
        continue;
      }
      var_4 = self _meth_816C();

      if(!isDefined(var_4) || var_4 != var_3) {
        continue;
      }
      if(distancesquared(self.origin, var_3.origin) < var_0 * var_0) {
        if(!_id_27EC(var_3)) {
          if(isDefined(var_3.owner) && var_3.owner == self) {
            self _meth_804E("use", level._id_3E97 / 1000 + 0.5);
            continue;
          }

          self _meth_804E("use", level._id_3E96 / 1000 + 0.5);
        }
      }
    }
  }
}

_id_2900() {
  self notify("bot_think_revive");
  self endon("bot_think_revive");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  if(!scripts\mp\utility\game::_id_8902() && !scripts\mp\utility\game::_id_8A95()) {
    return;
  }
  for(;;) {
    var_0 = 2.0;
    var_1 = getEntArray("revive_trigger", "targetname");

    if(var_1.size > 0) {
      var_0 = 0.05;
    }

    level scripts\engine\utility::_id_108F5("player_last_stand", var_0);

    if(!_id_271C()) {
      self._id_878C = 0;
      continue;
    }

    var_1 = getEntArray("revive_trigger", "targetname");
    var_2 = 1;
    var_3 = scripts\mp\utility\teams::_id_6DCA(self.team, "teamCount");

    if(var_3 < 4) {
      var_2 = 0;
    }

    if(var_1.size > var_2) {
      var_1 = _func_0204(var_1, self.origin);

      if(isDefined(self.owner)) {
        for(var_4 = 0; var_4 < var_1.size; var_4++) {
          if(var_1[var_4].owner != self.owner) {
            continue;
          }
          if(var_4 == 0) {
            break;
          }

          var_5 = var_1[var_4];
          var_1[var_4] = var_1[0];
          var_1[0] = var_5;
          break;
        }
      }
    }

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_6 = var_1[var_4];
      var_7 = var_6.owner;

      if(!isDefined(var_7)) {
        continue;
      }
      if(var_7 == self) {
        continue;
      }
      if(scripts\mp\utility\game::_id_8902() && !scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }
      if(var_7.team != self.team) {
        continue;
      }
      if(scripts\mp\utility\game::_id_8902() && (!isDefined(var_7.inlaststand) || !var_7.inlaststand)) {
        continue;
      }
      if(isDefined(var_7._id_293E) && isDefined(var_7._id_293E[self.team]) && var_7._id_293E[self.team] > 0) {
        continue;
      }
      if(scripts\mp\utility\game::_id_8902()) {
        var_8 = var_7.origin;
      } else {
        var_8 = var_6.origin;
      }

      if(distancesquared(self.origin, var_8) < 4194304) {
        var_9 = spawnStruct();
        var_9._id_A860 = var_6;
        var_9._id_CD72 = 64;

        if(isDefined(self._id_8F50) && gettime() - self._id_8F50 < 1000) {
          var_9._id_CD72 = 32;
        }

        var_9._id_E656 = ::_id_10A2A;
        var_9._id_52CD = ::_id_E8D8;
        var_9._id_DA6E = ::_id_B5A3;
        var_9._id_0E86 = ::_id_C7CB;
        var_10 = 60;

        if(scripts\mp\utility\teams::_id_6DCA(self.team, "aliveCount") == 1) {
          var_10 = 100;
        }

        _id_09F9::_id_2862("revive", var_8, var_10, var_9);
        self._id_878C = 1;
        var_7._id_293E[self.team] = 1;
        break;
      }
    }
  }
}

_id_10A2A(var_0) {
  if(scripts\mp\utility\game::_id_8902()) {
    thread _id_2921(var_0._id_A860.owner);
  }
}

_id_E8D8(var_0) {
  if(isDefined(var_0._id_A860.owner)) {
    var_0._id_A860.owner._id_293E[self.team] = 0;
  }
}

_id_B5A3(var_0) {
  if(scripts\mp\utility\game::_id_8902()) {
    if(!isDefined(var_0._id_A860.owner) || var_0._id_A860.owner.health <= 0) {
      return 1;
    }

    if(!isDefined(var_0._id_A860.owner.inlaststand) || !var_0._id_A860.owner.inlaststand) {
      return 1;
    }
  } else if(!isDefined(var_0._id_A860.owner) || var_0._id_A860.owner.health > 0)
    return 1;

  return 0;
}

_id_C7CB(var_0) {
  if(isDefined(var_0._id_A860.owner)) {
    var_0._id_A860.owner._id_293E[self.team] = 1;
  }

  if(scripts\mp\utility\game::_id_8902()) {
    var_1 = var_0._id_A860.owner.origin;
  } else {
    var_1 = var_0._id_A860.origin;
  }

  if(distancesquared(self.origin, var_1) > 4096) {
    self._id_8F50 = gettime();
    return;
  }

  if(isagent(self)) {
    scripts\common\utility::_id_158A(1);
    var_0._id_A860 _meth_80E0(self);
    wait 0.05;
  }

  var_2 = self.team;
  self _meth_804E("use", level._id_908B + 0.5);
  wait(level._id_908B + 1.5);

  if(isDefined(var_0._id_A860.owner)) {
    var_0._id_A860.owner._id_293E[var_2] = 0;
  }

  if(isagent(self)) {
    scripts\common\utility::_id_158A(0);

    if(isDefined(var_0._id_A860)) {
      var_0._id_A860 disableplayeruse(self);
    }
  }
}

_id_271C() {
  if(isDefined(self._id_0271) && self._id_0271 == 1) {
    return 0;
  }

  if(_id_09F9::_id_27ED("revive")) {
    return 0;
  }

  if(scripts\mp\bots\bots_util::_id_280F()) {
    return 0;
  }

  if(scripts\mp\bots\bots_util::_id_2800()) {
    return 1;
  }

  if(isDefined(level._id_279D["tactical_revive_override"])) {
    var_0 = self[[level._id_279D["tactical_revive_override"]]]();

    if(var_0) {
      self._id_878C = 0;
      return 1;
    }
  }

  var_1 = self _meth_803E();

  if(var_1 == "none" || var_1 == "hunt" || var_1 == "guard") {
    return 1;
  }

  return 0;
}

_id_C7D8(var_0) {
  self endon("death_or_disconnect");
  self endon("bad_path");
  self endon("goal");
  var_0 scripts\engine\utility::waittill_any_2("death", "revived");
  self notify("bad_path");
}

_id_2828() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(gettime() > 15000) {
    return;
  }
  while(!scripts\mp\utility\game::_id_60C5() || !_id_07D1::_id_60BE("prematch_done")) {
    wait 0.05;
  }

  var_0 = undefined;
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3) && isDefined(self.team) && isDefined(var_3.team) && !_func_03D9(self, var_3)) {
      if(!isDefined(var_3._id_28EE)) {
        var_0 = var_3;
      }

      if(isai(var_3) && !isDefined(var_3._id_28ED)) {
        var_1 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    self._id_28ED = 1;
    var_0._id_28EE = 1;
    self _meth_812E(var_0);
  }

  if(isDefined(var_1)) {
    var_1._id_28ED = 1;
    self._id_28EE = 1;
    var_1 _meth_812E(self);
  }
}

_id_28FC() {
  self notify("bot_think_gametype");
  self endon("bot_think_gametype");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = 0;

  if(level.gametype == "br") {
    var_0 = 1;
  }

  if(!var_0) {
    _id_07D1::_id_60C2("prematch_done");
  }

  self thread[[level._id_279D["gametype_think"]]]();
}

_id_456D() {}

_id_A0E8() {
  level._id_28E2 = getent("smoke_grenade_sight_clip_256", "targetname");

  if(!isDefined(level._id_28E2)) {
    return;
  }
  for(;;) {
    level waittill("smoke", var_0, var_1);

    if(var_1.basename == "s4_smoke_usa_m18_mp") {
      var_0 thread _id_740E();
    }
  }
}

_id_740E() {
  self endon("late_death");
  thread _id_DE3D();
  self waittill("explode", var_0);
  thread _id_3F6E(var_0);
}

_id_3F6E(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 show();
  wait 1;
  var_1 clonebrushmodeltoscriptmodel(level._id_28E2);
  var_1 _meth_8731();
  wait 8.75;
  var_1 delete();
}

_id_DE3D() {
  self endon("explode");
  self waittill("death");
  waittillframeend;
  self notify("late_death");
}

_id_26F3(var_0) {
  var_1 = 0;
  var_0._id_2991 = "scavenger_bag";
  var_0._id_2990 = 1;

  if(!isDefined(level._id_28AD)) {
    level._id_28AD = [];
  }

  foreach(var_4, var_3 in level._id_28AD) {
    if(!isDefined(var_3)) {
      var_1 = 1;
      level._id_28AD[var_4] = var_0;
      break;
    }
  }

  if(!var_1) {
    level._id_28AD[level._id_28AD.size] = var_0;
  }

  foreach(var_6 in level._id_AE7C) {
    if(isai(var_6) && var_6 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
      var_6 notify("new_crate_to_take");
    }
  }
}

_id_2908() {
  var_0 = getEntArray("bot_flag_set", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_039B)) {
      continue;
    }
    var_2 thread _id_2799(var_2._id_039B);
  }
}

_id_2799(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(scripts\mp\utility\entity::_id_8737(var_1)) {
      var_1 notify("flag_trigger_set_" + var_0);
      var_1 _meth_8054(var_0, 1);
      var_1 thread _id_279A(var_0);
    }
  }
}

_id_279A(var_0) {
  self endon("flag_trigger_set_" + var_0);
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  waittillframeend;
  self _meth_8054(var_0, 0);
}

_id_95BC() {}