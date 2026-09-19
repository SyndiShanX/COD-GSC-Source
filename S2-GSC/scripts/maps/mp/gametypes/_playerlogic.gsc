/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_playerlogic.gsc
******************************************************/

_id_9A1D(var_0, var_1) {
  if(!self.hasspawned)
    return 0;

  var_2 = gettime() + var_0 * 1000;
  var_3 = level._id_5C0F[self.pers["team"]];
  var_4 = level._id_A982[self.pers["team"]] * 1000;

  if(var_4 <= 0)
    return var_0;

  var_5 = (var_2 - var_3) / var_4;
  var_6 = _func_0D5(var_5);
  var_7 = var_3 + var_6 * var_4;

  if(isDefined(self._id_7DB7) && !common_scripts\utility::_id_562E(var_1)) {
    var_8 = (gettime() - self._id_7DB7) / 1000.0;

    if(self._id_7DB7 < var_3)
      return 0;
  }

  if(isDefined(self._id_A98A))
    var_7 = var_7 + 50 * self._id_A98A;

  return (var_7 - gettime()) / 1000;
}

_id_9856() {
  var_0 = self.pers["teamkills"];

  if(var_0 <= level._id_6072)
    return 0;

  var_1 = var_0 - level._id_6072;
  return _id_0511::_id_46F7("team", "teamkillspawndelay") * var_1;
}

_id_9A1C(var_0) {
  if(level._id_5139 && !self.hasspawned || level.gameended)
    return 0;

  var_1 = 0;

  if(self.hasspawned) {
    var_2 = self[[level._id_6B96]]();

    if(isDefined(var_2))
      var_1 = var_2;
    else
      var_1 = getdvarfloat("scr_" + level.gametype + "_playerrespawndelay");

    if(var_0) {
      if(isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
        var_1 = var_1 + _id_9856();

      if(isDefined(self.pers["suicideSpawnDelay"]))
        var_1 = var_1 + self.pers["suicideSpawnDelay"];
    }

    if(isDefined(self._id_7DB7)) {
      var_3 = (gettime() - self._id_7DB7) / 1000.0;
      var_1 = var_1 - var_3;

      if(var_1 < 0)
        var_1 = 0;
    }

    if(isDefined(self._id_872A))
      var_1 = var_1 + level._id_9A27;
  }

  if(maps\mp\_utility::_id_579B())
    var_4 = level._id_7DB3 == 2;
  else
    var_4 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;

  if(var_4) {
    if(isDefined(level._id_A982) && level._id_A982[self.pers["team"]] > 0)
      return _id_9A1D(var_1);
  }

  return var_1;
}

mayspawn() {
  if(maps\mp\_utility::getgametypenumlives() || isDefined(level._id_2F9F)) {
    if(isDefined(level._id_2F9F) && level._id_2F9F)
      return 0;

    if(isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
      return 0;

    if(!self.pers["lives"] && maps\mp\_utility::gamehasstarted())
      return 0;
    else if(maps\mp\_utility::gamehasstarted()) {
      if(!level._id_5139 && !self.hasspawned && (isDefined(level._id_0C25) && !level._id_0C25))
        return 0;
    }

    if(isDefined(level._id_2FA0) && [[level._id_2FA0]](self))
      return 0;
  }

  return 1;
}

_id_9035() {
  self endon("becameSpectator");

  if(isDefined(self.clientid)) {} else {}

  if(isDefined(self._id_A6EF) && self._id_A6EF)
    self waittill("notWaitingToSelectClass");

  if(isDefined(self._id_09FC)) {
    _id_04E8::_id_09FC(self._id_09FC);
    self._id_09FC = undefined;
  }

  if(!mayspawn()) {
    waitframe();
    self notify("attempted_spawn");
    var_0 = self.pers["teamKillPunish"];

    if(isDefined(var_0) && var_0) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      maps\mp\_utility::_id_86C3("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT");

      if(!self.hasspawned && _id_9856() <= 0)
        self.pers["teamKillPunish"] = 0;
    } else if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround()) {
      if(isDefined(self._id_95B4) && self._id_95B4)
        maps\mp\_utility::_id_86C3("spawn_info", game["strings"]["spawn_tag_wait"]);
      else
        maps\mp\_utility::_id_86C3("spawn_info", game["strings"]["spawn_next_round"]);

      thread _id_7CFA(3.0);
    }

    thread _id_90A5();
    return;
  }

  if(self._id_A6F0) {
    return;
  }
  self._id_A6F0 = 1;
  _id_A686();

  if(isDefined(self))
    self._id_A6F0 = 0;
}

_id_9457() {
  if(maps\mp\_utility::_id_0C1E() && !_func_0C1(self)) {
    var_0 = [];

    if(isDefined(level._id_3E20))
      var_0 = level._id_3E20;

    var_1 = ["custom1", "custom2", "custom3", "custom4", "custom5", "class0", "class1", "class2", "class3", "class4"];

    foreach(var_3 in var_1) {
      var_4 = maps\mp\gametypes\_class::giveloadout(self.team, var_3, undefined, undefined, 1);
      var_0[var_0.size] = var_4._id_76F8;
    }

    self _meth_8512(var_0);
  }
}

_id_4006(var_0, var_1) {
  var_2 = [];

  if(isDefined(level._id_3E20))
    var_2 = level._id_3E20;

  var_3 = var_1;

  if(!maps\mp\_utility::isvalidclass(var_3))
    var_3 = self.class;

  if(maps\mp\_utility::isvalidclass(var_3)) {
    var_4 = maps\mp\gametypes\_class::giveloadout(self.team, var_3, undefined, undefined, 1);
    var_2[var_2.size] = var_4._id_76F8;

    if(!isDefined(var_0) || !var_0)
      var_2[var_2.size] = var_4._id_8358;
  }

  return var_2;
}

_id_9455(var_0, var_1, var_2) {
  self._id_2327 = 0;
  self notify("endStreamClassWeapons");
  self endon("endStreamClassWeapons");
  self endon("death");
  self endon("disconnect");

  if(_func_0C1(self) || !isDefined(var_0))
    var_0 = 0;

  var_3 = _id_4006(var_1, var_2);

  if(var_3.size > 0) {
    while(isDefined(self._id_5DED) && self._id_5DED)
      waitframe();

    var_0 = !self _meth_8512(var_3) && var_0;
    self _meth_8533(1);

    for(self._id_2327 = var_0; var_0; var_0 = !self _meth_8512(var_3))
      waitframe();

    self _meth_8533(0);
  }

  self._id_2327 = 0;
  self notify("streamClassWeaponsComplete");
}

_id_A686() {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");

  if(isDefined(self.clientid)) {} else {}

  var_0 = 0;
  var_1 = undefined;

  if(isDefined(level._id_469A))
    var_1 = [[level._id_469A]]();
  else {
    var_2 = getEntArray("mp_global_intermission", "classname");
    var_1 = var_2[randomint(var_2.size)];
  }

  var_3 = self.pers["teamKillPunish"];

  if(isDefined(var_3) && var_3) {
    var_4 = _id_9856();

    if(var_4 > 0) {
      maps\mp\_utility::_id_86C3("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT", var_4, 1, 1);
      thread _id_7DA7(var_1.origin, var_1.angles);
      var_0 = 1;
      wait(var_4);
      maps\mp\_utility::_id_2401("friendly_fire");
      self._id_7DB7 = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(_id_9856())
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);

  var_5 = self.pers["suicideSpawnDelay"];

  if(isDefined(var_5) && var_5 > 0) {
    maps\mp\_utility::_id_86C3("suicidePenalty", &"MP_SUICIDE_PUNISHED", var_5, 1, 1);

    if(!var_0)
      thread _id_7DA7(var_1.origin, var_1.angles);

    var_0 = 1;
    wait(var_5);
    maps\mp\_utility::_id_2401("suicidePenalty");
    self._id_7DB7 = gettime();
    self.pers["suicideSpawnDelay"] = 0;
  }

  if(maps\mp\_utility::isusingremote()) {
    self._id_9071 = 1;
    self._id_2AA9 = self.origin;
    self waittill("stopped_using_remote");
  }

  if(!isDefined(self._id_A98A) && isDefined(level._id_A987[self.team])) {
    self._id_A98A = level._id_A987[self.team];
    level._id_A987[self.team]++;
  }

  var_6 = _id_9A1C(0);
  var_7 = 0;

  if(var_6 > 0) {
    self _meth_82FF("ui_killcam_time_until_spawn", gettime() + var_6 * 1000);

    if(!var_0)
      thread _id_7DA7(var_1.origin, var_1.angles);

    var_0 = 1;
    maps\mp\_utility::waitfortimeornotify(var_6, "force_spawn");
    self notify("stop_wait_safe_spawn_button");
    var_7 = 1;
  }

  if(_id_664E()) {
    maps\mp\_utility::_id_86C3("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);

    if(!var_0)
      thread _id_7DA7(var_1.origin, var_1.angles);

    var_0 = 1;
    _id_A6FA();
    var_7 = 1;
  }

  if(isDefined(level._id_585D) && level._id_585D && !var_7)
    waitframe();

  self._id_A6F0 = 0;
  maps\mp\_utility::_id_2401("spawn_info");
  self._id_A98A = undefined;
  var_8 = level.gametype != "gun";
  thread _id_9084(0, var_8);
}

_id_664E() {
  if(_id_0511::_id_46F7("player", "forcerespawn") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  var_0 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;

  if(var_0)
    return 0;

  if(self._id_A7F5)
    return 0;

  return 1;
}

_id_A6FA() {
  self endon("disconnect");
  self endon("end_respawn");

  for(;;) {
    if(self _meth_8341()) {
      break;
    }

    waitframe();
  }
}

_id_7CFA(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(var_0);
  maps\mp\_utility::_id_2401("spawn_info");
}

_id_5BF0() {
  self _meth_82C9();

  if(maps\mp\_utility::_hasperk("specialty_finalstand") && !level._id_2EF3)
    maps\mp\_utility::_id_0735("specialty_finalstand");

  if(level._id_2EF3)
    self._id_00BA = "";

  self _meth_8179("crouch");
  self._id_7E54 = 1;
  self notify("revive");

  if(isDefined(self._id_9165))
    self.maxhealth = self._id_9165;

  self.health = self.maxhealth;
  common_scripts\utility::_id_0615();

  if(game["state"] == "postgame")
    maps\mp\gametypes\_gamelogic::_id_9412();
}

_id_4489() {
  var_0 = spawn("script_origin", self.origin);
  var_0 _meth_805C();
  var_0.angles = self.angles;
  return var_0;
}

_id_8C17() {}

_id_4695(var_0) {
  var_1 = spawnStruct();
  var_1._id_9088 = undefined;
  var_1._id_7588 = var_0.origin;

  if(!_func_15D(var_0.origin) || !isDefined(var_0._id_0CAD))
    return var_1;

  foreach(var_3 in var_0._id_0CAD) {
    if(!isDefined(var_1._id_9088))
      var_1._id_9088 = 0;
    else
      var_1._id_9088 = var_1._id_9088 + 1;

    if(!_func_15D(var_3)) {
      var_1._id_7588 = var_3;
      return var_1;
    }
  }

  var_1._id_9088 = undefined;
  return var_1;
}

_id_9A2F() {
  if(!isDefined(self._id_872A))
    return 0;

  var_0 = getEntArray("care_package", "targetname");

  foreach(var_2 in var_0) {
    if(distancesquared(var_2.origin, self._id_872A._id_7464) > 4096) {
      continue;
    }
    _id_052C::_id_2D54(self._id_872A);
    return 0;
  }

  if(maps\mp\_utility::_id_5668(0)) {
    _id_052C::_id_2D54(self._id_872A);
    self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_FLAKGUNS");
    return 0;
  }

  return 1;
}

_id_9072() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  waitframe();
  level._id_689B--;
}

_id_8753(var_0) {
  self endon("disconnect");
  self endon("joined_spectators");

  while(self _meth_8436() && !maps\mp\_utility::_id_551F())
    waitframe();

  self _meth_82FF("ui_options_menu", var_0);
}

_id_4005() {
  var_0 = [];

  if(isDefined(self._id_5DEE)) {
    var_0[var_0.size] = maps\mp\_utility::_id_4340(self._id_5DEE);

    if(isDefined(self._id_5DEE._id_8358) && self._id_5DEE._id_8358 != "none")
      var_0[var_0.size] = self._id_5DEE._id_8358;
  } else {
    if(isDefined(self.primaryweapon) && self.primaryweapon != "none")
      var_0[var_0.size] = self.primaryweapon;

    if(isDefined(self._id_835A) && self._id_835A != "none")
      var_0[var_0.size] = self._id_835A;
  }

  return var_0;
}

_id_A919() {
  self notify("watchHasDoneCombat");
  self endon("watchHasDoneCombat");

  for(;;) {
    if(isDefined(self._id_4B62) && self._id_4B62) {
      self notify("hasDoneCombatTrue");
      return;
    }

    self waittill("hasDoneCombat");
  }
}

_id_A79A() {
  self endon("hasDoneCombatTrue");
  thread _id_A919();
  maps\mp\_utility::gameflagwait("team_collision_on");
}

_id_5FCC() {
  self endon("disconnect");
  self notify("manageTeamPlayerCollision");
  self endon("manageTeamPlayerCollision");

  if(maps\mp\_utility::gameflag("team_collision_on")) {
    self _meth_8665(1);
    return;
  }

  self _meth_8665(0);
  _id_A79A();
  self _meth_8665(1);
}

_id_9084(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(isDefined(self.clientid)) {} else {}

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1) {
    self._id_9085 = 1;
    thread _id_637B();
  }

  self._id_5CC6 = maps\mp\_utility::getnextlifeid(self.name);
  self._id_9AB6 = 0;
  var_2 = undefined;
  self._id_99BD = 0;
  self._id_6E6B = 0;
  self._id_5723 = 0;
  self._id_A258 = 0;
  self._id_A25A = 0;
  self.usingriotshield = 0;
  self.hideshieldmodels = 0;

  if(!isDefined(self.pers["spawnCount"]))
    self.pers["spawnCount"] = 0;

  if(!isDefined(self.pers["badSpawnByAnyMeansCount"]))
    self.pers["badSpawnByAnyMeansCount"] = 0;

  if(!isDefined(self.pers["immediateActionSpawnCount"]))
    self.pers["immediateActionSpawnCount"] = 0;

  if(!isDefined(self.pers["victimSpawnCount"]))
    self.pers["victimSpawnCount"] = 0;

  if(!isDefined(self.pers["causedBadSpawnByAnyMeansCount"]))
    self.pers["causedBadSpawnByAnyMeansCount"] = 0;

  if(!isDefined(self.pers["causedImmediateActionSpawnCount"]))
    self.pers["causedImmediateActionSpawnCount"] = 0;

  if(!isDefined(self.pers["causedVictimSpawnCount"]))
    self.pers["causedVictimSpawnCount"] = 0;

  if(common_scripts\utility::_id_562E(level._id_9565)) {
    if(game["switchedsides"])
      self _meth_866E(1);
  }

  thread _id_8753(0);
  self _meth_82FF("ui_hud_shake", 0);
  self _meth_84C0(0);
  self _meth_852E();
  level._id_689B++;

  if(level._id_689B > 1) {
    self._id_A6F1 = 1;
    wait(0.05 * (level._id_689B - 1));
  }

  thread _id_9072();
  self._id_A6F1 = 0;
  _id_04CA::_id_2406();
  self._id_509B = 0;

  if(var_1) {
    maps\mp\gametypes\_class::_id_4790(self.team, self.class);
    var_3 = _id_4005();
    self._id_5DED = 1;

    if(!_func_367() && !self _meth_842C(self, var_3)) {
      self._id_A6F1 = 1;
      self _meth_8533(1);

      for(;;) {
        self _meth_812C(0);
        waitframe();
        var_3 = _id_4005();

        if(self _meth_842C(self, var_3)) {
          break;
        }
      }

      self _meth_8533(0);
      self _meth_812C(1);
      self._id_A6F1 = 0;
    }

    self._id_5DED = 0;
  }

  self.playerconnectedbuthasntstreamedweapons = 0;

  if(_func_367() && !istestclient(self) && !_func_0C1(self)) {
    if(maps\mp\gametypes\_hud_util::_id_5527())
      var_4 = [449, 449, 449, 449, 0, 0, 0];
    else
      var_4 = maps\mp\gametypes\_class::_id_1F99(common_scripts\utility::_id_46AF());

    while(!self _meth_86B9(var_4)) {
      self _meth_84C7(var_4);
      waitframe();
    }
  }

  if(isDefined(self._id_6E6E) && self._id_6E6E && isDefined(self._id_5DEE) && isDefined(self._id_5DEE._id_0079) && self._id_5DEE._id_0079 != 8) {
    self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_WRONGDIVISION");
    _id_052C::_id_2D54(self._id_872A);
  } else if(isDefined(self._id_6E6C) && self._id_6E6C && !isDefined(self._id_872A)) {
    self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_DESTROYED");
    self._id_872A = undefined;
    self._id_6E6E = 0;
  }

  self._id_6E6C = 0;

  if(isDefined(self._id_3E2C)) {
    var_5 = self._id_3E2C;
    self._id_3E2C = undefined;

    if(isDefined(self._id_3E2B)) {
      var_6 = self._id_3E2B;
      self._id_3E2B = undefined;
    } else
      var_6 = (0, _func_0A5(0, 360), 0);
  } else if(isDefined(self._id_872A) && (isDefined(self._id_872A._id_6817) || _id_9A2F())) {
    var_2 = self._id_872A;

    if(!isDefined(self._id_872A._id_6817)) {
      self._id_99BD = 1;
      self _meth_8322();
      self playlocalsound("tactical_spawn");

      if(level._id_6520) {
        foreach(var_8 in level._id_985B) {
          if(var_8 != self.team)
            self _meth_860E("tactical_spawn", var_8);
        }
      } else if(level.teambased)
        self _meth_860E("tactical_spawn", level._id_6C63[self.team]);
      else
        self playSound("tactical_spawn");
    }

    foreach(var_11 in level._id_9FEA) {
      if(distancesquared(var_11.origin, var_2._id_7464) < 1024)
        var_11 notify("damage", 5000, var_11._id_0117, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, "killstreak_emp_mp");
    }

    var_5 = self._id_872A._id_7464;
    var_6 = self._id_872A.playerspawnangles;
    var_2 = undefined;
  } else if(isDefined(self._id_4C9D) && (!isDefined(self._id_3C6F) || isDefined(self._id_3C6F) && self._id_3C6F) && level._id_7691 > 0 && self.team == "allies") {
    while(!isDefined(level._id_0BF5))
      wait 0.1;

    var_5 = level._id_0BF5.origin;
    var_6 = level._id_0BF5.angles;
    self._id_3C6F = 0;
  } else if(isDefined(self.fighterspawningfunc)) {
    [self.fighterspawnorigin, self.fighterspawnangles] = self[[self.fighterspawningfunc]]();
    var_5 = (clamp(self.fighterspawnorigin[0], -32767, 32767), clamp(self.fighterspawnorigin[1], -32767, 32767), clamp(self.fighterspawnorigin[2], -32767, 32767));
    var_6 = self.fighterspawnangles;
  } else if(isDefined(self._id_4C9D) && (!isDefined(self._id_3C6F) || isDefined(self._id_3C6F) && self._id_3C6F) && level._id_7691 > 0 && self.team == "axis") {
    while(!isDefined(level._id_147B))
      wait 0.1;

    var_5 = level._id_147B.origin;
    var_6 = level._id_147B.angles;
    self._id_3C6F = 0;
  } else {
    var_2 = [[level._id_4696]]();
    var_5 = var_2.origin;
    var_6 = var_2.angles;
  }

  _id_872B();
  var_14 = self.hasspawned;
  self.pers["spawnCount"]++;
  _func_2D3(self, 0);

  if(!var_0) {
    self._id_5A57 = [];
    var_15 = self.sessionstate == "spectator";
    maps\mp\_utility::_id_A165("playing");
    maps\mp\_utility::clearkillcamstate();
    self._id_1F3F = undefined;
    self.maxhealth = _id_0511::_id_46F7("player", "maxhealth");
    self.health = self.maxhealth;
    self._id_3EC1 = undefined;
    self.hasspawned = 1;
    self._id_90AC = _id_0485::getmatchtimepassed();
    self._id_3C6C = undefined;
    self._id_A87A = !isDefined(var_2) || isDefined(self._id_6E6E) && self._id_6E6E;
    self._id_0A34 = 0;
    self._id_29BD = [];
    self._id_5A73 = 1;
    self._id_696D = 1;
    self._id_2313 = undefined;
    self._id_8AFE = 0;
    self._id_8AFD = 0;
    self._id_1193 = [];
    self._id_1189 = [];
    self._id_A495 = [];
    self._id_A491 = [];
    self._id_29B9 = 0;
    self._id_29DA = 0;
    self._id_9A16 = 0;
    self._id_9A17 = 0;
    self._id_90AD = -1;
    self._id_90AE = -1;
    self._id_3905 = 0;
    self._id_3900 = 0;
    self._id_80A7 = self.pers["score"];

    if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"]))
      self._id_AAD0 = self.pers["summary"]["xp"];

    if(isDefined(level._id_585D) && level._id_585D) {
      if(isDefined(level._id_0789))
        self thread[[level._id_0789]]();
    } else
      thread _id_0471::_id_5E8B();

    if(isDefined(self.team) && level._id_585D == 0 && !_func_367())
      setmatchdata("players", self.clientid, "team", self.team);

    if(var_15)
      level notify("spawn_after_spectator", self);
  }

  _id_0513::_id_A13B();
  self _meth_830E(1);
  self._id_5720 = 0;
  self.isinthaw = 0;
  self._id_5378 = 0;
  self._id_00E8 = undefined;
  self._id_5133 = undefined;
  self._id_2F81 = 0;
  self._id_2F82 = 0;
  self._id_2F7E = 0;
  common_scripts\utility::_id_7D75();
  self._id_73D4 = [];

  if(_func_367() && (!isDefined(self.team) || self.team != "allies"))
    _id_04E8::_id_09FC("allies");

  if(!var_0) {
    self._id_1444 = 5.0;
    var_16 = self.pers["lives"];

    if(var_16 == maps\mp\_utility::getgametypenumlives())
      _id_09F9();

    if(var_16)
      self.pers["lives"]--;

    _id_09F7();

    if(!var_14 || maps\mp\_utility::gamehasstarted() || maps\mp\_utility::gamehasstarted() && level._id_5139 && self._id_4B62)
      _id_7CDE();

    if(!self._id_A869) {
      var_17 = 20;

      if(maps\mp\_utility::gettimelimit() > 0 && var_17 < maps\mp\_utility::gettimelimit() * 60 / 4)
        var_17 = maps\mp\_utility::gettimelimit() * 60 / 4;

      if(level._id_5139 || maps\mp\_utility::gettimepassed() < var_17 * 1000)
        self._id_A869 = 1;
    }
  }

  if(level._id_258F)
    self setclientdvar("cg_fov", "65");

  _id_7D73();
  self _meth_85EF(&"player_respawned", 0);
  var_18 = undefined;
  var_19 = undefined;

  if(isDefined(var_2)) {
    _id_050D::_id_3B4A(var_2);
    var_20 = _id_4695(var_2);
    var_5 = var_20._id_7588;
    var_6 = var_2.angles;

    if(isDefined(var_2._id_5700) && var_2._id_5700) {
      var_18 = var_2._id_00D4;
      var_19 = var_20._id_9088;
    }
  }

  self._id_9092 = var_5;
  self._id_5BE2 = gettime();
  self._id_4B7A = 0;
  self _meth_826B(var_5, var_6, var_18, var_19);
  maps\mp\_utility::_id_8668(level._id_3189);
  maps\mp\_utility::_id_86F8();

  if(var_0 && isDefined(self._id_3A5E)) {
    self _meth_8179(self._id_3A5E);
    self._id_3A5E = undefined;
  }

  [[level._id_6BA7]]();

  if(_func_3BC()) {
    var_21 = 255;

    if(isDefined(self._id_2943))
      var_21 = self._id_2943;

    self _meth_8681("dtel_spawn", ["spawn", ["life_index", self._id_5CC6, "player_index", self.clientid, "spawn_pos", [int(self._id_9092[0]), int(self._id_9092[1]), int(self._id_9092[2])], "spawn_time_ms", self._id_5BE2, "loadout_index", var_21]]);
  }

  if(!var_0) {
    maps\mp\gametypes\_missions::_id_7463();

    if(_func_0C1(self) && isDefined(level._id_19D5) && isDefined(level._id_19D5["player_spawned"]))
      self[[level._id_19D5["player_spawned"]]]();
  }

  maps\mp\gametypes\_class::setclass(self.class);

  if(isDefined(level._id_296B))
    self[[level._id_296B]](var_0);
  else if(var_1) {
    maps\mp\gametypes\_class::_id_0F35();
    self notify("spawnplayer_giveloadout");
  }

  if(getdvarint("311"))
    maps\mp\_utility::setthirdpersondof(1);

  if(!_func_367()) {
    if(!maps\mp\_utility::gameflag("prematch_done")) {
      maps\mp\_utility::_id_3E8F(0);
      self _meth_800F();
      thread _id_5FCC();
    } else {
      maps\mp\_utility::_id_3E8F(1);
      self _meth_800E();
    }
  } else {
    maps\mp\_utility::_id_3E8F(1);
    self _meth_800E();
  }

  if(isDefined(self._id_90E1)) {
    if(isPlayer(self)) {
      if(self._id_90E1 maps\mp\_utility::_hasperk("specialty_perception") || self._id_90E1 maps\mp\_utility::_hasperk("specialty_class_perception"))
        thread _id_04E6::_id_238F(self._id_90E1);

      if(isDefined(self._id_90E1._id_0079))
        thread _id_04E6::_id_237D(self._id_90E1);
    }

    self._id_90E1 = undefined;
  }

  if(!maps\mp\_utility::gameflag("prematch_done") || !var_14 && game["state"] == "playing") {
    var_22 = self.pers["team"];

    if(maps\mp\_utility::inovertime())
      thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, (1, 0, 0), "mp_last_stand");

    thread _id_8C17();
  }

  if(maps\mp\_utility::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {}

  waittillframeend;
  self._id_9071 = undefined;
  self notify("spawned_player");
  level notify("player_spawned", self);

  if(game["state"] == "postgame")
    maps\mp\gametypes\_gamelogic::_id_9412();

  if(isDefined(level._id_6034) && level._id_6034)
    self _meth_82FF("ui_disable_team_change", 1);

  thread _id_0487::_id_63C2();
  thread _id_75F2();
}

_id_637B() {
  self endon("disconnect");
  common_scripts\utility::_id_A70A("joined_spectators", "spawnplayer_giveloadout");
  self._id_9085 = undefined;
}

_id_90A5(var_0, var_1) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  _id_50D2(var_0, var_1);
}

_id_7DA7(var_0, var_1) {
  _id_50D2(var_0, var_1);
}

_id_50D2(var_0, var_1) {
  _id_872B();
  var_2 = self.pers["team"];

  if(isDefined(var_2) && var_2 == "spectator" && !level.gameended)
    maps\mp\_utility::_id_2401("spawn_info");

  maps\mp\_utility::_id_A165("spectator");
  maps\mp\_utility::clearkillcamstate();
  self._id_3EC1 = undefined;
  self._id_5DED = undefined;
  _id_7D74();
  _id_050F::_id_872F();
  _id_6BAB(var_0, var_1);

  if(isDefined(level.onspawnspectatorgamemode))
    [[level.onspawnspectatorgamemode]]();

  if(level.teambased && !level.splitscreen && !self _meth_82D0())
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

_id_4622(var_0) {
  if(var_0 < 0)
    return undefined;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] getentitynumber() == var_0)
      return level.players[var_1];
  }

  return undefined;
}

_id_4651() {
  if(isDefined(level._id_469A))
    return [[level._id_469A]]();
  else {
    var_0 = "mp_global_intermission";
    var_1 = getEntArray(var_0, "classname");
    var_2 = _id_050E::_id_839A(var_1);
    return var_2;
  }
}

_id_6BAB(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    self _meth_82CB(var_0, var_1);
    self _meth_826B(var_0, var_1);
    return;
  }

  var_2 = _id_4651();
  self _meth_82CB(var_2.origin, var_2.angles);
  self _meth_826B(var_2.origin, var_2.angles);
}

_id_9073() {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");
  _id_872B();
  maps\mp\_utility::clearlowermessages();
  maps\mp\_utility::freezecontrolswrapper(1);
  self _meth_800F();
  self setclientdvar("3724", 1);
  var_0 = self.pers["postGameChallenges"];

  if(level.rankedmatch && (self.postgamepromotion || isDefined(var_0) && var_0)) {
    if(self.postgamepromotion)
      self playlocalsound("mp_level_up");
    else if(isDefined(var_0))
      self playlocalsound("mp_challenge_complete");

    if(self.postgamepromotion > level._id_75E4)
      level._id_75E4 = 1;

    if(isDefined(var_0) && var_0 > level._id_75E4)
      level._id_75E4 = var_0;

    var_1 = 7.0;

    if(isDefined(var_0))
      var_1 = 4.0 + _func_0AF(var_0, 3);

    while(var_1) {
      wait 0.25;
      var_1 = var_1 - 0.25;
    }
  }

  maps\mp\_utility::_id_A165("intermission");
  maps\mp\_utility::clearkillcamstate();
  self._id_3EC1 = undefined;
  var_2 = undefined;

  if(isDefined(level._id_4526))
    var_2 = [[level._id_4526]]();
  else {
    var_3 = getEntArray("mp_global_intermission", "classname");
    var_2 = var_3[0];
  }

  self _meth_826B(var_2.origin, var_2.angles);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

_id_9049() {
  if(1) {
    maps\mp\_utility::freezecontrolswrapper(1);
    self _meth_800F();
    _id_90A5();
    maps\mp\_utility::freezecontrolswrapper(1);
    self _meth_800F();
    return;
  }

  self notify("spawned");
  self notify("end_respawn");
  _id_872B();
  maps\mp\_utility::clearlowermessages();
  self setclientdvar("3724", 1);
  maps\mp\_utility::_id_A165("dead");
  maps\mp\_utility::clearkillcamstate();
  self._id_3EC1 = undefined;
  var_0 = undefined;

  if(isDefined(level._id_44B6))
    var_0 = [[level._id_44B6]]();
  else {
    var_1 = getEntArray("mp_global_intermission", "classname");
    var_0 = _id_050E::_id_839A(var_1);
  }

  self _meth_826B(var_0.origin, var_0.angles);
  var_0 setModel("tag_origin");
  self _meth_8077(var_0);
  self _meth_8003();
  maps\mp\_utility::freezecontrolswrapper(1);
  self _meth_800F();
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

_id_872B() {
  self _meth_8184();
  self _meth_80A1("damage_heavy");
  self._id_2AA9 = undefined;
}

_id_6805() {
  waittillframeend;

  if(isDefined(self))
    level notify("connecting", self);
}

_id_5EA9() {
  if(_func_367()) {
    return;
  }
  if(isDefined(self.pers["totalKillcamsSkipped"]))
    setmatchdata("players", self.clientid, "killcams_skipped", maps\mp\_utility::_id_2314(self.pers["totalKillcamsSkipped"]));

  if(isDefined(self.pers["totalKillcamsInterrupted"]))
    setmatchdata("players", self.clientid, "killcams_interrupted", maps\mp\_utility::_id_2314(self.pers["totalKillcamsInterrupted"]));

  if(isDefined(self.pers["weaponPickupsCount"]))
    setmatchdata("players", self.clientid, "weapon_pickups_count", maps\mp\_utility::_id_2314(self.pers["weaponPickupsCount"]));

  if(isDefined(self.pers["suicides"]))
    setmatchdata("players", self.clientid, "suicides_total", maps\mp\_utility::_id_2314(self.pers["suicides"]));

  if(isDefined(self.pers["headshots"]))
    setmatchdata("players", self.clientid, "headshots_total", maps\mp\_utility::_id_2315(self.pers["headshots"]));

  if(isDefined(self.pers["pingAccumulation"]) && isDefined(self.pers["pingSampleCount"])) {
    if(self.pers["pingSampleCount"] > 0) {
      var_0 = maps\mp\_utility::_id_2314(self.pers["pingAccumulation"] / self.pers["pingSampleCount"]);
      setmatchdata("players", self.clientid, "average_ping", var_0);
    }
  }

  if(maps\mp\_utility::rankingenabled()) {
    var_1 = 3;
    var_2 = 0;

    for(var_3 = 0; var_3 < var_1; var_3++) {
      var_4 = self getplayerdata(common_scripts\utility::_id_46AE(), "xpMultiplier", var_3);

      if(isDefined(var_4) && var_4 > var_2)
        var_2 = var_4;
    }

    if(var_2 > 0)
      setmatchdata("players", self.clientid, "xp_multiplier", var_2);
  }

  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["clanWarsXP"]))
    setmatchdata("players", self.clientid, "clanwars_xp", self.pers["summary"]["clanWarsXP"]);
}

callback_playerdisconnect(var_0) {
  if(!isDefined(self._id_2582)) {
    return;
  }
  if(_func_367()) {
    if(_func_25F() && !_func_279(self)) {
      var_1 = self._id_4F4C;

      if(!isDefined(var_1))
        var_1 = -1;

      var_2 = self.clientid;

      if(!isDefined(var_2))
        var_2 = -1;

      if(!isDefined(var_0))
        var_0 = "null";

      self _meth_8681("telemetry_hq_event", ["base", ["hq_guid", _func_398(), "utc_timestamp_join", var_1, "data_center_id", _func_397(), "game_time", gettime(), "player_index", var_2, "player_count", level.players.size, "event_name", "leave", "event_category", "hq_session_info", "duration_seconds", 0], "leave", ["reason", var_0]]);
    }
  } else {
    setmatchdata("players", self.clientid, "utc_disconnect_time_s", _func_131());
    setmatchdata("players", self.clientid, "disconnect_reason", var_0);
    var_3 = getmatchdata("match_common", "player_count_left");
    var_3++;
    setmatchdata("match_common", "player_count_left", var_3);

    if(!level._id_585D)
      setmatchdata("players", self.clientid, "match_result", "quit");

    if(level._id_585D) {
      setmatchdata("players", self.clientid, "play_time", self._id_9A06["total"]);
      setmatchdata("players", self.clientid, "player_quit_on_round", maps\mp\_utility::_id_2314(level._id_A980));
    }

    var_4 = getmatchdata("players", self.clientid, "playermatchtime_start_ms");
    var_5 = getmatchdata("players", self.clientid, "playermatchtime_total_ms");
    var_5 = var_5 + (gettime() - var_4);
    setmatchdata("players", self.clientid, "playermatchtime_total_ms", var_5);

    if(maps\mp\_utility::rankingenabled())
      _id_0485::_id_5E92();

    _id_0485::_id_5EA4();

    if(isDefined(self.pers["confirmed"]))
      _id_0485::_id_5E97();

    if(isDefined(self.pers["denied"]))
      _id_0485::_id_5E98();

    _id_5EA9();

    if(!level._id_585D) {
      if(maps\mp\_utility::isroundbased()) {
        var_6 = game["roundsPlayed"] + 1;
        setmatchdata("players", self.clientid, "player_quit_round", var_6);

        if(isDefined(self.team) && (self.team == "allies" || self.team == "axis")) {
          if(self.team == "allies") {
            setmatchdata("players", self.clientid, "player_quit_team_score", game["roundsWon"]["allies"]);
            setmatchdata("players", self.clientid, "player_quit_enemy_team_score", game["roundsWon"]["axis"]);
          } else {
            setmatchdata("players", self.clientid, "player_quit_team_score", game["roundsWon"]["axis"]);
            setmatchdata("players", self.clientid, "player_quit_enemy_team_score", game["roundsWon"]["allies"]);
          }
        }
      } else if(isDefined(self.team) && (self.team == "allies" || self.team == "axis") && level.teambased) {
        if(self.team == "allies") {
          setmatchdata("players", self.clientid, "player_quit_team_score", game["teamScores"]["allies"]);
          setmatchdata("players", self.clientid, "player_quit_enemy_team_score", game["teamScores"]["axis"]);
        } else {
          setmatchdata("players", self.clientid, "player_quit_team_score", game["teamScores"]["axis"]);
          setmatchdata("players", self.clientid, "player_quit_enemy_team_score", game["teamScores"]["allies"]);
        }
      }
    }
  }

  _id_048D::_id_775A();
  _id_04E7::_id_4AB9();
  _id_7CF5();
  _id_050D::_id_7CDF();

  if(isDefined(self.waterwakevfxdeletefunc))
    self[[self.waterwakevfxdeletefunc]]();

  cleanupentsonplayerdisconnect();
  _func_2D0(self);
  var_7 = self getentitynumber();

  if(!level.teambased)
    game["roundsWon"][self.guid] = undefined;

  if(!level.gameended)
    maps\mp\_utility::_id_5EB0();

  if(level.splitscreen) {
    var_8 = level.players;

    if(var_8.size <= 1)
      level thread maps\mp\gametypes\_gamelogic::_id_3E1A();
  }

  maps\mp\gametypes\_gamelogic::_id_8700(self);
  _func_0F5("script_mp_playerquit: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());
  var_9 = self getentitynumber();
  var_10 = self.guid;
  _func_15A("Q;" + var_10 + ";" + var_9 + ";" + self.name + "\n");
  thread _id_047A::_id_2FC1();

  if(level.gameended)
    _id_04D2::_id_7CD8();

  if(isDefined(self.team))
    _id_7CE1();

  if(self.sessionstate == "playing" && !isDefined(self))
    _id_7CDD(1);
  else if(self.sessionstate == "spectator" || self.sessionstate == "dead")
    level thread maps\mp\gametypes\_gamelogic::_id_A11E();
}

_id_7CF5() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      for(var_0 = 1; var_1 < level.players.size - 1; var_1++)
        level.players[var_1] = level.players[var_1 + 1];

      level.players[var_1] = undefined;
      break;
    }
  }
}

_id_52A3() {
  if((level.splitscreen || self _meth_82D0()) && !_func_3BA())
    self setclientdvars("2772", "90", "4217", "40", "2777", "40", "416", "35", "2913", "0 0", "3078", "0.75");
  else
    self setclientdvars("2772", "180", "4217", "80", "2777", "80", "416", "70", "2913", "0 0", "3078", "1");

  _id_052C::_id_A05D();
}

_id_52A2() {
  setDvar("4431", 1);
  setDvar("1874", 1);
  setDvar("1979", 1);
  setDvar("787", 250);

  if(level.hardcoremode) {
    setDvar("4431", 3);
    setDvar("1874", 0);
    setDvar("1979", 1);
    setDvar("787", 0);
  }

  if(isDefined(level._id_0CB4) && level._id_0CB4)
    setDvar("4934", 1);
  else
    setDvar("4934", 0);

  _id_52A3();

  if(maps\mp\_utility::getgametypenumlives())
    self setclientdvars("2651", 1, "3328", 0, "1176", 0, "558", 0);
  else
    self setclientdvars("2651", 0, "3328", 1, "1176", 1, "558", 0);

  if(level.teambased)
    self setclientdvars("3724", 0);

  if(getdvarint("scr_hitloc_debug")) {
    for(var_0 = 0; var_0 < 6; var_0++)
      self setclientdvar("ui_hitloc_" + var_0, "");

    self._id_4DDA = 1;
  }

  self setclientdvars("ui_raid_hide_fighter", 1, "ui_raid_hide_scorestreaks", 0);
}

_id_456A() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 24; var_1++) {
    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.clientid == var_1) {
        var_0 = 1;
        break;
      }

      var_0 = 0;
    }

    if(!var_0)
      return var_1;
  }
}

_id_8A40() {
  self.saved_actionslotdata = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    self.saved_actionslotdata[var_0] = spawnStruct();
    self.saved_actionslotdata[var_0].type = "";
    self.saved_actionslotdata[var_0]._id_586B = undefined;
  }

  if(!level._id_258F) {
    for(var_0 = 5; var_0 <= 8; var_0++) {
      self.saved_actionslotdata[var_0] = spawnStruct();
      self.saved_actionslotdata[var_0].type = "";
      self.saved_actionslotdata[var_0]._id_586B = undefined;
    }
  }
}

_id_5EA2() {
  var_0 = _func_2B4();
  var_1 = self getplayerdata(common_scripts\utility::_id_46A7(), "consoleIDChunkLow", var_0);
  var_2 = self getplayerdata(common_scripts\utility::_id_46A7(), "consoleIDChunkHigh", var_0);
  var_3 = 3;
  var_4 = -1;

  if(isDefined(var_2) && var_2 != 0 && isDefined(var_1) && var_1 != 0) {
    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_6 = self getplayerdata(common_scripts\utility::_id_46A7(), "deviceConnectionHistory", var_5, "device_id_high");
      var_7 = self getplayerdata(common_scripts\utility::_id_46A7(), "deviceConnectionHistory", var_5, "device_id_low");

      if(var_6 == var_2 && var_7 == var_1) {
        var_4 = var_5;
        break;
      }
    }
  }

  if(var_4 == -1) {
    var_8 = 0;

    for(var_5 = 0; var_5 < var_3; var_5++) {
      var_9 = self getplayerdata(common_scripts\utility::_id_46A7(), "deviceConnectionHistory", var_5, "deviceUseFrequency");

      if(var_9 > var_8) {
        var_8 = var_9;
        var_4 = var_5;
      }
    }
  }

  if(var_4 == -1)
    var_4 = 0;

  var_10 = self getplayerdata(common_scripts\utility::_id_46A7(), "deviceConnectionHistory", var_4, "onWifi");

  if(var_10)
    setmatchdata("players", self.clientid, "onwifi", 1);
}

_id_9E05(var_0) {
  var_1 = common_scripts\utility::_id_9462(var_0, "]");

  if(var_1 >= 0 && common_scripts\utility::_id_9467(var_0, "["))
    var_0 = getsubstr(var_0, var_1 + 1);

  return var_0;
}

callback_playerconnect() {
  var_0 = _id_4651();
  self _meth_82CB(var_0.origin, var_0.angles);
  self.playerconnectedbuthasntstreamedweapons = 1;
  thread _id_6805();
  self waittill("begin");
  self._id_2589 = gettime();

  if(isDefined(level.resetclientomnvarcallback))
    [[level.resetclientomnvarcallback]](self);

  level notify("connected", self);
  self._id_2582 = 1;
  level._id_596C = common_scripts\utility::_id_0F6F(level._id_596C, self);

  if(self _meth_829E())
    level.player = self;

  self._id_A25B = self _meth_801A();
  _id_52A2();
  _id_5336();

  if(getDvar("233") == "1")
    level waittill("eternity");

  self.guid = self _meth_8271();
  self._id_01D6 = self _meth_8299();
  self._id_9AB6 = 0;
  var_1 = 0;
  var_2 = 0;

  if(!isDefined(self.pers["clientid"])) {
    if(_func_367()) {
      self.pers["clientid"] = game["clientid"];
      game["clientid"]++;
    } else {
      for(var_3 = 0; var_3 < 24; var_3++) {
        var_4 = getmatchdata("players", var_3, "client", "user_id");

        if(var_4 == self.guid) {
          self.pers["clientid"] = var_3;
          var_2 = 1;
          var_5 = getmatchdata("match_common", "player_count_reconnect");
          var_5++;
          setmatchdata("match_common", "player_count_reconnect", var_5);
          setmatchdata("players", var_3, "utc_reconnect_time_s", _func_131());
          break;
        }
      }

      if(!var_2) {
        if(game["clientid"] >= 24)
          self.pers["clientid"] = _id_456A();
        else
          self.pers["clientid"] = game["clientid"];

        if(game["clientid"] < 24)
          game["clientid"]++;
      }
    }

    var_1 = 1;
  }

  if(var_1 && !maps\mp\_utility::_id_551F()) {
    _id_051E::_id_7D50(1);
    _id_052C::resetspecialistperkstreak();
  }

  if(maps\mp\_utility::_id_761E() && var_1)
    maps\mp\gametypes\_class::_id_10E3();

  if(getdvarint("spv_stream_primaries_on_connect", 0) == 1) {
    if(var_1)
      _id_9457();
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  self.pers["suicideSpawnDelay"] = 0;

  if(var_1)
    _func_0F5("script_mp_playerjoin: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());

  _func_15A("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");

  if(!_func_367() && game["clientid"] < 24 && game["clientid"] != getmatchdata("match_common", "player_count")) {
    if(!_func_0C1(self) && maps\mp\_utility::matchmakinggame() && getdvarint("4017", 0) == 0)
      self _meth_82AD(self.clientid);

    setmatchdata("match_common", "player_count", game["clientid"]);
    setmatchdata("players", self.clientid, "client", "gamer_tag", _id_9E05(self.name));
    setmatchdata("players", self.clientid, "client", "country", self getplayerdata(common_scripts\utility::_id_46A7(), "country"));
    setmatchdata("players", self.clientid, "client", "language", self getplayerdata(common_scripts\utility::_id_46A7(), "language"));
    setmatchdata("players", self.clientid, "client", "timezone", self getplayerdata(common_scripts\utility::_id_46A7(), "timezone"));

    if(!(isDefined(level._id_585D) && level._id_585D)) {
      var_6 = self getplayerdata(common_scripts\utility::_id_46A9(), "activeCostume");
      setmatchdata("players", self.clientid, "costume", "head", self getplayerdata(common_scripts\utility::_id_46A9(), "globalCostume", "head"));
      setmatchdata("players", self.clientid, "costume", "shirt", self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_6, "shirt"));
      setmatchdata("players", self.clientid, "costume", "pants", self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_6, "pants"));
      setmatchdata("players", self.clientid, "costume", "eyewear", self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_6, "eyewear"));
      setmatchdata("players", self.clientid, "costume", "hat", self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_6, "hat"));
      setmatchdata("players", self.clientid, "costume", "gear", self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_6, "gear"));
      setmatchdata("players", self.clientid, "costume", "uniform", self getplayerdata(common_scripts\utility::_id_46A9(), "costumes", var_6, "uniform"));
    }

    var_7 = self getentitynumber();
    setmatchdata("players", self.clientid, "code_client_num", maps\mp\_utility::_id_2314(var_7));
    _func_39F(self, self.clientid);
    setmatchdata("players", self.clientid, "join_type", self _meth_84DB());

    if(var_1)
      setmatchdata("players", self.clientid, "utc_connect_time_s", _func_131());

    if(maps\mp\_utility::_id_585F()) {
      if(var_1)
        setmatchdata("players", self.clientid, "utc_first_spawn_time_s", 0);
    } else
      setmatchdata("players", self.clientid, "is_bot", _func_0C1(self));

    _id_5EA2();

    if(self _meth_829E())
      setmatchdata("players", self.clientid, "was_host", 1);

    if(maps\mp\_utility::rankingenabled())
      _id_0485::_id_5E95();

    if(istestclient(self) || _func_0C1(self))
      var_8 = 1;
    else
      var_8 = 0;

    if(maps\mp\_utility::matchmakinggame() && maps\mp\_utility::_id_0C2D() && !var_8) {}

    if(maps\mp\_utility::_id_566A(self)) {
      if(!isDefined(level._id_6026))
        level._id_6026 = [];

      if(!isDefined(game["botJoinCount"]))
        game["botJoinCount"] = 1;
      else
        game["botJoinCount"]++;
    }
  }

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  self.leaderdialogqueue = [];
  self._id_5C42 = [];
  self.leaderdialogactive = undefined;
  self.leaderdialoggroups = [];
  self.leaderdialoggroup = "";

  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
    self._id_00E4 = 0;
  }

  if(!isDefined(self.pers["cur_death_streak"]))
    self.pers["cur_death_streak"] = 0;

  if(!isDefined(self.pers["cur_kill_streak_for_nuke"]))
    self.pers["cur_kill_streak_for_nuke"] = 0;

  thread _id_04E7::init();

  if(maps\mp\_utility::rankingenabled())
    self._id_5A1D = maps\mp\gametypes\_persistence::statget("killStreak");

  self._id_5BA1 = -1;
  self._id_9857 = 0;

  if(isDefined(game["firstbloodcount"]) && isDefined(game["firstbloodcount"][self.guid]))
    self._id_0097 = game["firstbloodcount"][self.guid];

  self.hasspawned = 0;
  self._id_A6F0 = 0;
  self._id_A7F5 = 0;
  self._id_A869 = 0;
  self._id_5A73 = 1;
  self._id_696D = 1;
  self._id_57D6 = 0;
  _id_8A40();

  if(!(isDefined(level._id_585D) && level._id_585D))
    level thread _id_63C4(self);

  thread maps\mp\_flashgrenades::_id_6394();
  _id_7D71();
  _id_0378::_id_8D8A();
  waittillframeend;
  level.players[level.players.size] = self;
  level._id_596C = common_scripts\utility::_id_0F93(level._id_596C, self);
  _id_050D::_id_09FA();
  _func_2CF(self);

  if(level.teambased)
    self _meth_82A3();

  if(isDefined(level._id_75DF))
    self[[level._id_75DF]]();

  if(game["state"] == "postgame") {
    self._id_2583 = 1;
    _id_9073();
  } else {
    if(var_1 && (maps\mp\_utility::gettimepassed() >= 60000 || game["roundsPlayed"] > 0)) {
      self._id_5969 = 1;

      if(maps\mp\_utility::_id_579B() && !game["switchedsides"])
        self.pers["jip_game_one"] = 1;
    } else if(isDefined(self.pers["jip_game_one"]) && self.pers["jip_game_one"])
      self._id_5969 = 1;

    if(_func_0C1(self) && isDefined(level._id_19D5) && isDefined(level._id_19D5["think"]))
      self thread[[level._id_19D5["think"]]]();

    level endon("game_ended");

    if(isDefined(level.hostmigrationtimer)) {
      if(!isDefined(self._id_4E05) || self._id_4E05 == 0) {
        self._id_4E05 = 0;
        thread maps\mp\gametypes\_hostmigration::_id_4E0A();
      }
    }

    if(isDefined(level._id_6B6D))
      [[level._id_6B6D]]();

    if(maps\mp\_utility::_id_56B9()) {
      thread _id_90A5();
      self[[level._id_1385]]();
    } else {
      if(!isDefined(self.pers["team"])) {
        if(_func_38B()) {
          if(self._id_0179 == "none") {
            thread _id_90A5();
            self[[level._id_1385]]();

            if(maps\mp\_utility::_id_0C1E())
              thread _id_8753(2);
          } else if(self._id_0179 == "spectator") {
            _id_04E8::_id_6116();
            thread _id_8753(0);
          } else {
            thread _id_90A5();
            thread _id_04E8::_id_873A(self._id_0179);

            if(maps\mp\_utility::_id_0C1E())
              thread _id_8753(2);
          }

          thread _id_59EB();
          return;
          return;
        }

        if((maps\mp\_utility::matchmakinggame() || _func_37E()) && self._id_0179 != "none") {
          thread watch_kick_if_no_damage();
          thread _id_90A5();

          if(isDefined(level._id_A6EB) && level._id_A6EB)
            maps\mp\_utility::freezecontrolswrapper(1);

          if(level.gametype == "infect")
            self[[level._id_1385]]();
          else
            thread _id_04E8::_id_873A(self._id_0179);

          if(maps\mp\_utility::_id_0C1E())
            thread _id_8753(2);

          thread watchforhostmigrationonconnect();
          thread _id_59EB();
          return;
          return;
        }

        if(!maps\mp\_utility::matchmakinggame() && maps\mp\_utility::_id_0C2D()) {
          _id_04E8::_id_6116();
          thread _id_8753(1);
          return;
        }

        thread _id_90A5();
        self[[level._id_1385]]();

        if(maps\mp\_utility::_id_0C1E())
          thread _id_8753(2);

        if(maps\mp\_utility::matchmakinggame()) {
          thread watch_kick_if_no_damage();
          thread watchforhostmigrationonconnect();
          thread _id_59EB();
        }

        return;
        return;
        return;
        return;
        return;
      }

      _id_04E8::_id_09FC(self.pers["team"], 1);

      if(maps\mp\_utility::isvalidclass(self.pers["class"]) && !maps\mp\_utility::isprophuntgametype()) {
        thread _id_9035();
        return;
      }

      thread _id_90A5();

      if(level.gametype == "sd" && (maps\mp\_utility::matchmakinggame() || _func_37E()) && self._id_0179 != "none")
        thread _id_59EB();

      if(maps\mp\_utility::_id_579B() && (maps\mp\_utility::matchmakinggame() || _func_37E()) && self._id_0179 != "none" && common_scripts\utility::_id_562E(self.pers["secondHalfInitialConnect"])) {
        thread _id_59EB();
        self.pers["secondHalfInitialConnect"] = 0;
      }

      if(self.pers["team"] == "spectator") {
        if(self._id_0179 == "spectator") {
          self._id_90E3 = 1;
          return;
        }

        if(!_func_38B()) {
          if(maps\mp\_utility::_id_0C2D()) {
            _id_04E8::_id_171C();
            return;
          }

          self[[level._id_1385]]();
          return;
          return;
        }

        return;
        return;
      }

      _id_04E8::_id_170E();
    }
  }
}

callback_playermigrated() {
  if(isDefined(self._id_2582) && self._id_2582) {
    if(!maps\mp\_utility::_id_579B())
      maps\mp\_utility::updateobjectivetext();

    maps\mp\_utility::updatemainmenu();

    if(level.teambased)
      self _meth_82A3();
  }

  if(self _meth_829E()) {
    _id_52A3();
    setmatchdata("players", self.clientid, "was_host", 1);
  }

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) && !istestclient(var_2))
      var_0++;
  }

  if(!isbot(self) && !istestclient(self)) {
    level._id_4E08++;

    if(level._id_4E08 >= var_0 * 2 / 3)
      level notify("hostmigration_enoughplayers");

    self notify("player_migrated");
  }
}

_id_3E2A() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  wait 60.0;

  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  if(!maps\mp\_utility::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";
    self.class = self.pers["class"];
    maps\mp\gametypes\_class::_id_23DC();
  }

  thread _id_9035();
}

watchforhostmigrationonconnect() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("spawned");
  self endon("attempted_spawn");

  for(;;) {
    self waittill("player_migrated");

    if(maps\mp\_utility::isvalidclass(self.pers["class"])) {
      return;
    }
    if(self.pers["team"] == "spectator") {
      return;
    }
    _id_04E8::_id_170E();
  }
}

_id_59EB() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  self endon("attempted_spawn");

  if(!common_scripts\utility::_id_562E(level._id_AC5A) && (!maps\mp\_utility::_id_551F() || !_func_3AE())) {
    var_0 = getdvarfloat("scr_kick_time", 90);
    var_1 = getdvarfloat("scr_kick_mintime", 45);
    var_2 = gettime();

    if(self _meth_829E())
      _id_59F0(120);
    else
      _id_59F0(var_0);

    var_3 = (gettime() - var_2) / 1000;

    if(var_3 < var_0 - 0.1 && var_3 < var_1) {
      return;
    }
    if(self.hasspawned) {
      return;
    }
    if(self.pers["team"] == "spectator") {
      return;
    }
    if(getdvarint("2803", 0) == 0)
      _func_134(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");

    level thread maps\mp\gametypes\_gamelogic::_id_A11E();
  }
}

watch_kick_if_no_damage() {
  level endon("game_ended");
  self endon("disconnect");

  if(_func_367()) {
    return;
  }
  if(getdvarint("spv_kick_if_no_damage", 0) == 0) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(!common_scripts\utility::_id_562E(level._id_AC5A) && (!maps\mp\_utility::_id_551F() || !_func_3AE())) {
    for(;;) {
      thread kick_if_no_damage();
      self waittill("has_recently_done_damage");
    }
  }
}

kick_if_no_damage() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("end_kick_threads");
  self endon("end_kick_threads");

  if(_func_367()) {
    return;
  }
  if(getdvarint("spv_kick_if_no_damage", 0) == 0) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  var_0 = getdvarint("spv_no_damage_kick_time", 300);

  if(self _meth_829E())
    var_0 = var_0 + 30;

  maps\mp\gametypes\_hostmigration::_id_A6F5(var_0);

  if(isDefined(self))
    _func_134(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
}

kick_after_delay(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("spv_kick_if_no_damage_rounds", 0) == 0) {
    return;
  }
  if(_func_367()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(self _meth_829E())
    var_0 = var_0 + 5;

  maps\mp\gametypes\_hostmigration::_id_A6F5(var_0);
  _func_134(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
}

_id_59F0(var_0) {
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::_id_A6F5(var_0);
}

_id_5336() {
  maps\mp\gametypes\_persistence::_id_529D();
  self.pers["lives"] = maps\mp\_utility::getgametypenumlives();

  if(!isDefined(self.pers["deaths"])) {
    maps\mp\_utility::initpersstat("deaths");
    maps\mp\gametypes\_persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = maps\mp\_utility::getpersstat("deaths");

  if(!isDefined(self.pers["score"])) {
    maps\mp\_utility::initpersstat("score");
    maps\mp\gametypes\_persistence::statsetchild("round", "score", 0);
    maps\mp\gametypes\_persistence::statsetchildbuffered("round", "timePlayed", 0);
  }

  self.score = maps\mp\_utility::getpersstat("score");
  self._id_9A06["total"] = maps\mp\gametypes\_persistence::statgetchildbuffered("round", "timePlayed");

  if(!isDefined(self.pers["suicides"]))
    maps\mp\_utility::initpersstat("suicides");

  self._id_94DD = maps\mp\_utility::getpersstat("suicides");

  if(!isDefined(self.pers["kills"])) {
    maps\mp\_utility::initpersstat("kills");
    maps\mp\gametypes\_persistence::statsetchild("round", "kills", 0);
  }

  self._id_00E3 = maps\mp\_utility::getpersstat("kills");

  if(!isDefined(self.pers["headshots"])) {
    maps\mp\_utility::initpersstat("headshots");
    maps\mp\gametypes\_persistence::statsetchild("round", "headshots", 0);
  }

  self._id_4BF9 = maps\mp\_utility::getpersstat("headshots");

  if(!isDefined(self.pers["assists"])) {
    maps\mp\_utility::initpersstat("assists");
    maps\mp\gametypes\_persistence::statsetchild("round", "assists", 0);
  }

  self._id_0021 = maps\mp\_utility::getpersstat("assists");

  if(!isDefined(self.pers["captures"])) {
    maps\mp\_utility::initpersstat("captures");
    maps\mp\gametypes\_persistence::statsetchild("round", "captures", 0);
  }

  if(!isDefined(self.pers["returns"])) {
    maps\mp\_utility::initpersstat("returns");
    maps\mp\gametypes\_persistence::statsetchild("round", "returns", 0);
  }

  self._id_7E31 = maps\mp\_utility::getpersstat("returns");

  if(!isDefined(self.pers["defends"])) {
    maps\mp\_utility::initpersstat("defends");
    maps\mp\gametypes\_persistence::statsetchild("round", "defends", 0);
  }

  if(!isDefined(self.pers["plants"])) {
    maps\mp\_utility::initpersstat("plants");
    maps\mp\gametypes\_persistence::statsetchild("round", "plants", 0);
  }

  if(!isDefined(self.pers["defuses"])) {
    maps\mp\_utility::initpersstat("defuses");
    maps\mp\gametypes\_persistence::statsetchild("round", "defuses", 0);
  }

  if(!isDefined(self.pers["destructions"])) {
    maps\mp\_utility::initpersstat("destructions");
    maps\mp\gametypes\_persistence::statsetchild("round", "destructions", 0);
  }

  if(!isDefined(self.pers["confirmed"])) {
    maps\mp\_utility::initpersstat("confirmed");
    maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", 0);
  }

  if(!isDefined(self.pers["denied"])) {
    maps\mp\_utility::initpersstat("denied");
    maps\mp\gametypes\_persistence::statsetchild("round", "denied", 0);
  }

  if(!isDefined(self.pers["rescues"])) {
    maps\mp\_utility::initpersstat("rescues");
    maps\mp\gametypes\_persistence::statsetchild("round", "rescues", 0);
  }

  if(!isDefined(self.pers["teamkills"]))
    maps\mp\_utility::initpersstat("teamkills");

  if(!isDefined(self.pers["totalTeamKills"]))
    maps\mp\_utility::initpersstat("totalTeamKills");

  if(!isDefined(self.pers["extrascore0"]))
    maps\mp\_utility::initpersstat("extrascore0");

  if(!isDefined(self.pers["extrascore1"]))
    maps\mp\_utility::initpersstat("extrascore1");

  if(!isDefined(self.pers["throwingKnifeKills"]))
    maps\mp\_utility::initpersstat("throwingKnifeKills");

  if(!isDefined(self.pers["meleeKnifeKills"]))
    maps\mp\_utility::initpersstat("meleeKnifeKills");

  if(!isDefined(self.pers["scorestreaksCalled"]))
    maps\mp\_utility::initpersstat("scorestreaksCalled");

  if(!isDefined(self.pers["scorestreaksDowned"]))
    maps\mp\_utility::initpersstat("scorestreaksDowned");

  if(!isDefined(self.pers["time"]))
    maps\mp\_utility::initpersstat("time");

  if(!isDefined(self.pers["teamKillPunish"]))
    self.pers["teamKillPunish"] = 0;

  if(!isDefined(self.pers["suicideSpawnDelay"]))
    self.pers["suicideSpawnDelay"] = 0;

  maps\mp\_utility::initpersstat("longestStreak");
  self.pers["lives"] = maps\mp\_utility::getgametypenumlives();

  if(!_func_367()) {
    maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", 0);
    maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
    maps\mp\gametypes\_persistence::statsetchild("round", "win", 0);
    maps\mp\gametypes\_persistence::statsetchild("round", "scoreboardType", "none");
  }

  if(maps\mp\_utility::rankingenabled()) {
    if(!isDefined(self.pers["previous_shots"]))
      self.pers["previous_shots"] = self getplayerdata(common_scripts\utility::_id_46AE(), "totalShots");

    if(!isDefined(self.pers["previous_hits"]))
      self.pers["previous_hits"] = self getplayerdata(common_scripts\utility::_id_46AE(), "hits");
  }

  if(!isDefined(self.pers["mpWeaponStats"]))
    self.pers["mpWeaponStats"] = [];

  if(!isDefined(self.pers["mpMatchdataWeaponStats"]))
    self.pers["mpMatchdataWeaponStats"] = [];

  if(!isDefined(self.pers["numberOfTimesCloakingUsed"]))
    self.pers["numberOfTimesCloakingUsed"] = 0;

  if(!isDefined(self.pers["numberOfTimesHoveringUsed"]))
    self.pers["numberOfTimesHoveringUsed"] = 0;

  if(!isDefined(self.pers["numberOfTimesShieldUsed"]))
    self.pers["numberOfTimesShieldUsed"] = 0;

  if(!isDefined(self.pers["bulletsBlockedByShield"]))
    self.pers["bulletsBlockedByShield"] = 0;

  if(!isDefined(self.pers["totalKillcamsSkipped"]))
    self.pers["totalKillcamsSkipped"] = 0;

  if(!isDefined(self.pers["totalKillcamsInterrupted"]))
    self.pers["totalKillcamsInterrupted"] = 0;

  if(!isDefined(self.pers["weaponPickupsCount"]))
    self.pers["weaponPickupsCount"] = 0;

  if(!isDefined(self.pers["pingAccumulation"]))
    self.pers["pingAccumulation"] = 0;

  if(!isDefined(self.pers["pingSampleCount"]))
    self.pers["pingSampleCount"] = 0;

  if(!isDefined(self.pers["minPing"]))
    self.pers["minPing"] = 32767;

  if(!isDefined(self.pers["maxPing"]))
    self.pers["maxPing"] = 0;

  if(!isDefined(self.pers["validationInfractions"]))
    self.pers["validationInfractions"] = 0;
}

_id_09FD() {
  level.teamcount[self.team]++;

  if(!isDefined(level._id_9859))
    level._id_9859 = [];

  if(!isDefined(level._id_9859[self.team]))
    level._id_9859[self.team] = [];

  level._id_9859[self.team][level._id_9859[self.team].size] = self;
  maps\mp\gametypes\_gamelogic::_id_A11E();
}

_id_7CE1() {
  level.teamcount[self.team]--;

  if(isDefined(level._id_9859) && isDefined(level._id_9859[self.team])) {
    var_0 = [];

    foreach(var_2 in level._id_9859[self.team]) {
      if(!isDefined(var_2) || var_2 == self) {
        continue;
      }
      var_0[var_0.size] = var_2;
    }

    level._id_9859[self.team] = var_0;
  }
}

_id_09F7() {
  var_0 = self.team;

  if(!(isDefined(self._id_0CA4) && self._id_0CA4)) {
    level.hasspawned[var_0]++;
    _id_50F8(var_0, "playerlogic addToAliveCount");
  }

  self._id_0CA4 = undefined;

  if(level._id_0BC3["allies"] + level._id_0BC3["axis"] > level.maxplayercount)
    level.maxplayercount = level._id_0BC3["allies"] + level._id_0BC3["axis"];
}

_id_50F8(var_0, var_1) {
  level._id_0BC3[var_0]++;

  if(var_0 == "allies")
    _func_032("ui_alive_player_count_allies", level._id_0BC3[var_0]);
  else
    _func_032("ui_alive_player_count_axis", level._id_0BC3[var_0]);
}

_id_7CDD(var_0) {
  var_1 = self.team;

  if(isDefined(self._id_9566) && self._id_9566 && isDefined(self._id_596B) && self._id_596B == self.team)
    var_1 = self._id_5C62;

  if(isDefined(var_0))
    _id_7CCE();

  _id_2B77(var_1);
  return maps\mp\gametypes\_gamelogic::_id_A11E();
}

_id_2B77(var_0) {
  level._id_0BC3[var_0]--;

  if(var_0 == "allies")
    _func_032("ui_alive_player_count_allies", level._id_0BC3[var_0]);
  else
    _func_032("ui_alive_player_count_axis", level._id_0BC3[var_0]);
}

_id_09F9() {
  level._id_5DDB[self.team] = level._id_5DDB[self.team] + self.pers["lives"];
}

_id_7CDE() {
  level._id_5DDB[self.team]--;
  level._id_5DDB[self.team] = int(max(0, level._id_5DDB[self.team]));
}

_id_7CCE() {
  level._id_5DDB[self.team] = level._id_5DDB[self.team] - self.pers["lives"];
  level._id_5DDB[self.team] = int(max(0, level._id_5DDB[self.team]));
}

_id_7D73() {
  self _meth_82FF("ui_carrying_bomb", 0);
  self _meth_82FF("ui_capture_icon", 0);
  self _meth_82FF("ui_capture_status_index", 0);
  self _meth_82FF("ui_light_armor", 0);
  self _meth_82FF("ui_killcam_end_milliseconds", 0);
  self _meth_82FF("ui_show_overview_map_icons", 1);
  self _meth_82FF("ui_light_armor_percent", 0);
  self _meth_82FF("serum_active_percent", 0);
  self _meth_82FF("ui_killcam_time_until_spawn", 0);

  if(!maps\mp\_utility::_id_585F())
    self _meth_82FF("ui_uplink_can_pass", 0);
}

_id_7D71() {
  self _meth_82FF("ui_carrying_bomb", 0);
  self _meth_82FF("ui_capture_icon", 0);
  self _meth_82FF("ui_capture_status_index", 0);
  self _meth_82FF("ui_light_armor", 0);
  self _meth_82FF("ui_killcam_end_milliseconds", 0);
  self _meth_82FF("ui_show_overview_map_icons", 1);

  if(!maps\mp\_utility::_id_585F() && !maps\mp\gametypes\_hud_util::_id_5527())
    self _meth_82FF("serum_active_streakIndex", -1);
}

_id_7D74() {
  self _meth_82FF("ui_carrying_bomb", 0);
  self _meth_82FF("ui_capture_icon", 0);
  self _meth_82FF("ui_capture_status_index", 0);
  self _meth_82FF("ui_light_armor", 0);
  self _meth_82FF("ui_killcam_end_milliseconds", 0);
  self _meth_82FF("ui_show_overview_map_icons", 1);
}

_id_7D72() {}

_id_63C4(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  _id_281F(var_0);

  for(;;) {
    var_0 waittill("spawned_player");
    _id_7B3C(var_0);
  }
}

_id_281F(var_0) {
  if(!isDefined(var_0.pers["segments"]))
    var_0.pers["segments"] = [];

  var_0._id_838A = var_0.pers["segments"];

  if(!var_0._id_838A.size) {
    var_0._id_838A["distanceTotal"] = 0;
    var_0._id_838A["movingTotal"] = 0;
    var_0._id_838A["movementUpdateCount"] = 0;
    var_0._id_838A["killDistanceTotal"] = 0;
    var_0._id_838A["killDistanceCount"] = 0;
  }
}

_id_7B3C(var_0) {
  var_0 endon("death");

  while(!maps\mp\_utility::gameflag("prematch_done"))
    wait 0.5;

  wait 4;
  var_0._id_8067 = var_0.origin;
  var_0._id_7592 = var_0.origin;

  for(;;) {
    wait 1;

    if(var_0 maps\mp\_utility::isusingremote()) {
      var_0 waittill("stopped_using_remote");
      var_0._id_8067 = var_0.origin;
      var_0._id_7592 = var_0.origin;
      continue;
    }

    var_0._id_838A["movementUpdateCount"]++;
    var_0._id_838A["distanceTotal"] = var_0._id_838A["distanceTotal"] + _func_0E1(var_0._id_8067, var_0.origin);
    var_0._id_8067 = var_0.origin;

    if(var_0._id_838A["movementUpdateCount"] % 5 == 0) {
      var_1 = _func_0E1(var_0._id_7592, var_0.origin);
      var_0._id_7592 = var_0.origin;

      if(var_1 > 16)
        var_0._id_838A["movingTotal"]++;
    }
  }
}

_id_AABB(var_0) {
  setdvarifuninitialized("spv_enablePlaystyleStats", 0);

  if(_func_367()) {
    return;
  }
  if(level.players.size < 2) {
    return;
  }
  var_0 endon("disconnect");

  if(var_0._id_838A["movementUpdateCount"] < 30) {
    return;
  }
  var_1 = var_0._id_838A["movingTotal"] / int(var_0._id_838A["movementUpdateCount"] / 5) * 100;
  var_2 = var_0._id_838A["distanceTotal"] / var_0._id_838A["movementUpdateCount"];
  var_3 = 0;

  if(var_0._id_838A["killDistanceCount"] > 0)
    var_3 = var_0._id_838A["killDistanceTotal"] / var_0._id_838A["killDistanceCount"];

  var_1 = _func_0AF(var_1, _func_0AD(tablelookup("mp/playerSegments.csv", 0, "MAX", 3)));
  var_2 = _func_0AF(var_2, _func_0AD(tablelookup("mp/playerSegments.csv", 0, "MAX", 2)));
  var_3 = _func_0AF(var_3, _func_0AD(tablelookup("mp/playerSegments.csv", 0, "MAX", 4)));
  var_4 = _id_1E50(var_1, var_2, var_3);
  setmatchdata("players", var_0.clientid, "average_speed", var_2);
  setmatchdata("players", var_0.clientid, "pct_time_moving", var_1);
  setmatchdata("players", var_0.clientid, "average_kill_distance", var_3);
  setmatchdata("players", var_0.clientid, "total_distance_travelled", var_0._id_838A["distanceTotal"]);
  setmatchdata("players", var_0.clientid, "playstyle", maps\mp\_utility::_id_2314(var_4));
  setmatchdata("players", var_0.clientid, "movement_update_count", var_0._id_838A["movementUpdateCount"]);

  if(_func_0C1(var_0)) {
    return;
  }
  if(getdvarint("spv_enablePlaystyleStats", 0) == 1) {
    _func_0F5("script_PlayerSegments: percentTimeMoving %f, averageSpeed %f, averageKillDistance %f, playStyle %d, name %s", var_1, var_2, var_3, var_4, var_0.name);

    if(!var_0 maps\mp\_utility::rankingenabled()) {
      return;
    }
    var_5 = 50;
    var_6 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "numPlayStyleTrends");
    var_6++;

    if(var_6 > var_5) {
      var_6 = var_5;

      if(var_5 > 1) {
        for(var_7 = 0; var_7 < var_5 - 1; var_7++) {
          var_8 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "playStyleTimeStamp", var_7 + 1);
          var_9 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "playStyle", var_7 + 1);
          var_0 setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "playStyleTimeStamp", var_7, var_8);
          var_0 setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "playStyle", var_7, var_9);
        }
      }
    }

    var_8 = maps\mp\_utility::_id_46E7();
    var_0 setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "playStyleTimeStamp", var_6 - 1, var_8);
    var_0 setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "playStyle", var_6 - 1, var_4);
    var_0 setplayerdata(common_scripts\utility::_id_46AE(), "combatRecord", "numPlayStyleTrends", var_6);
  }
}

_id_1E50(var_0, var_1, var_2) {
  var_0 = _id_6746(var_0, _func_0AD(tablelookup("mp/playerSegments.csv", 0, "Mean", 3)), _func_0AD(tablelookup("mp/playerSegments.csv", 0, "SD", 3)));
  var_1 = _id_6746(var_1, _func_0AD(tablelookup("mp/playerSegments.csv", 0, "Mean", 2)), _func_0AD(tablelookup("mp/playerSegments.csv", 0, "SD", 2)));
  var_2 = _id_6746(var_2, _func_0AD(tablelookup("mp/playerSegments.csv", 0, "Mean", 4)), _func_0AD(tablelookup("mp/playerSegments.csv", 0, "SD", 4)));
  var_3 = (var_0, var_1, var_2);
  var_4 = ["Camper", "Mobile", "Run", "Sniper", "TacCQ"];
  var_5 = "Camper";
  var_6 = 1000;

  foreach(var_8 in var_4) {
    var_9 = _id_444C(var_3, var_8);

    if(var_9 < var_6) {
      var_5 = var_8;
      var_6 = var_9;
    }
  }

  return int(tablelookup("mp/playerSegments.csv", 0, var_5, 1));
}

_id_6746(var_0, var_1, var_2) {
  return (var_0 - var_1) / var_2;
}

_id_444C(var_0, var_1) {
  var_2 = (_func_0AD(tablelookup("mp/playerSegments.csv", 0, var_1, 3)), _func_0AD(tablelookup("mp/playerSegments.csv", 0, var_1, 2)), _func_0AD(tablelookup("mp/playerSegments.csv", 0, var_1, 4)));
  return distance(var_0, var_2);
}

_id_2409(var_0, var_1) {
  var_0 setplayerdata(common_scripts\utility::_id_46A7(), "practiceRoundLockoutTime", 0);

  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "practiceRoundLockoutMatchTimes", var_2, 0);
}

_id_21DF(var_0) {
  if(isbot(var_0) || _func_1EF(var_0)) {
    return;
  }
  var_1 = 10;
  var_2 = 3;
  var_3 = 5.0;
  var_4 = int(86400);
  var_5 = int(86400);
  var_6 = var_0 getplayerdata(common_scripts\utility::_id_46A7(), "practiceRoundLockoutTime");

  if(var_6 > 0)
    _id_2409(var_0, var_1);

  var_7 = var_0 getplayerdata(common_scripts\utility::_id_46A7(), "round", "kills");
  var_8 = var_0 getplayerdata(common_scripts\utility::_id_46A7(), "round", "deaths");
  var_8 = max(var_8, 1);
  var_9 = var_7 / var_8;

  if(var_9 < var_3) {
    _id_2409(var_0, var_1);
    return;
  } else {
    var_10 = maps\mp\_utility::_id_46E7();
    var_11 = var_10 - var_4;
    var_12 = -1;
    var_13 = var_10;
    var_14 = 1;

    for(var_15 = 0; var_15 < var_1; var_15++) {
      var_16 = var_0 getplayerdata(common_scripts\utility::_id_46A7(), "practiceRoundLockoutMatchTimes", var_15);

      if(var_16 < var_13) {
        var_13 = var_16;
        var_12 = var_15;
      }

      if(var_16 >= var_11)
        var_14++;
    }

    var_0 setplayerdata(common_scripts\utility::_id_46A7(), "practiceRoundLockoutMatchTimes", var_12, var_10);

    if(var_14 >= var_2) {
      var_17 = var_10 + var_5;
      var_0 setplayerdata(common_scripts\utility::_id_46A7(), "practiceRoundLockoutTime", var_17);
    }
  }
}

_id_75F2() {
  if(!isDefined(level._id_A4B5)) {
    level._id_A4B5["intensity"] = 0;
    level._id_A4B5["falloff"] = 1.2;
    level._id_A4B5["scaleX"] = 1;
    level._id_A4B5["scaleY"] = 1;
    level._id_A4B5["squareAspectRatio"] = 0;
  }

  self _meth_806B(level._id_A4B5["intensity"], level._id_A4B5["falloff"], level._id_A4B5["scaleX"], level._id_A4B5["scaleY"], level._id_A4B5["squareAspectRatio"]);

  if(isDefined(level._id_6465))
    self _meth_866F(level._id_6465["velocityscaler"], level._id_6465["cameraRotationInfluence"], level._id_6465["cameraTranslationInfluence"]);
}

deleteentonplayerdisconnect(var_0) {
  if(!isDefined(self.playerondisconnectcleanup))
    self.playerondisconnectcleanup = [];

  self.playerondisconnectcleanup[self.playerondisconnectcleanup.size] = var_0;
  thread watchentdeleteforplayerdisconnect(var_0);
}

watchentdeleteforplayerdisconnect(var_0) {
  self endon("disconnect");
  var_0 common_scripts\utility::_id_A70A("death", "entitydeleted");
  self.playerondisconnectcleanup = common_scripts\utility::_id_0F93(self.playerondisconnectcleanup, var_0);
}

cleanupentsonplayerdisconnect() {
  if(isDefined(self.playerondisconnectcleanup)) {
    foreach(var_1 in self.playerondisconnectcleanup) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }
}