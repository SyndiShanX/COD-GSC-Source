/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_playerlogic.gsc
**********************************************/

func_9A1D(param_00, param_01) {
  if(!self.hasspawned) {
    return 0;
  }

  var_02 = gettime() + param_00 * 1000;
  var_03 = level.var_5C0F[self.pers["team"]];
  var_04 = level.var_A982[self.pers["team"]] * 1000;
  if(var_04 <= 0) {
    return param_00;
  }

  var_05 = var_02 - var_03 / var_04;
  var_06 = ceil(var_05);
  var_07 = var_03 + var_06 * var_04;
  if(isDefined(self.var_7DB7) && !common_scripts\utility::func_562E(param_01)) {
    var_08 = gettime() - self.var_7DB7 / 1000;
    if(self.var_7DB7 < var_03) {
      return 0;
    }
  }

  if(isDefined(self.var_A98A)) {
    var_07 = var_07 + 50 * self.var_A98A;
  }

  return var_07 - gettime() / 1000;
}

teamkilldelay() {
  var_00 = self.pers["teamkills"];
  if(var_00 <= level.maxallowedteamkills) {
    return 0;
  }

  var_01 = var_00 - level.maxallowedteamkills;
  return maps\mp\gametypes\_tweakables::gettweakablevalue("team", "teamkillspawndelay") * var_01;
}

func_9A1C(param_00) {
  if((level.var_5139 && !self.hasspawned) || level.gameended) {
    return 0;
  }

  var_01 = 0;
  if(self.hasspawned) {
    var_02 = self[[level.var_6B96]]();
    if(isDefined(var_02)) {
      var_01 = var_02;
    } else {
      var_01 = getdvarfloat("scr_" + level.gametype + "_playerrespawndelay");
    }

    if(param_00) {
      if(isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
        var_01 = var_01 + teamkilldelay();
      }

      if(isDefined(self.pers["suicideSpawnDelay"])) {
        var_01 = var_01 + self.pers["suicideSpawnDelay"];
      }
    }

    if(isDefined(self.var_7DB7)) {
      var_03 = gettime() - self.var_7DB7 / 1000;
      var_01 = var_01 - var_03;
      if(var_01 < 0) {
        var_01 = 0;
      }
    }

    if(isDefined(self.var_872A)) {
      var_01 = var_01 + level.var_9A27;
    }
  }

  if(maps\mp\_utility::func_579B()) {
    var_04 = level.var_7DB3 == 2;
  } else {
    var_04 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;
  }

  if(var_04) {
    if(isDefined(level.var_A982) && level.var_A982[self.pers["team"]] > 0) {
      return func_9A1D(var_01);
    }
  }

  return var_01;
}

func_60B2() {
  if(maps\mp\_utility::func_44FC() || isDefined(level.var_2F9F)) {
    if(isDefined(level.var_2F9F) && level.var_2F9F) {
      return 0;
    }

    if(isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
      return 0;
    }

    if(!self.pers["lives"] && maps\mp\_utility::func_3FA6()) {
      return 0;
    } else if(maps\mp\_utility::func_3FA6()) {
      if(!level.var_5139 && !self.hasspawned && isDefined(level.var_C25) && !level.var_C25) {
        return 0;
      }
    }

    if(isDefined(level.var_2FA0) && [[level.var_2FA0]](self)) {
      return 0;
    }
  }

  return 1;
}

func_9035() {
  self endon("becameSpectator");
  if(isDefined(self.clientid)) {} else {}

  if(isDefined(self.var_A6EF) && self.var_A6EF) {
    self waittill("notWaitingToSelectClass");
  }

  if(isDefined(self.var_9FC)) {
    maps\mp\gametypes\_menus::func_9FC(self.var_9FC);
    self.var_9FC = undefined;
  }

  if(!func_60B2()) {
    wait 0.05;
    self notify("attempted_spawn");
    var_00 = self.pers["teamKillPunish"];
    if(isDefined(var_00) && var_00) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      maps\mp\_utility::func_86C3("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT");
      if(!self.hasspawned && teamkilldelay() <= 0) {
        self.pers["teamKillPunish"] = 0;
      }
    } else if(maps\mp\_utility::func_57B2() && !maps\mp\_utility::func_5743()) {
      if(isDefined(self.var_95B4) && self.var_95B4) {
        maps\mp\_utility::func_86C3("spawn_info", game["strings"]["spawn_tag_wait"]);
      } else {
        maps\mp\_utility::func_86C3("spawn_info", game["strings"]["spawn_next_round"]);
      }

      thread func_7CFA(3);
    }

    thread func_90A5();
    return;
  }

  if(self.var_A6F0) {
    return;
  }

  self.var_A6F0 = 1;
  func_A686();
  if(isDefined(self)) {
    self.var_A6F0 = 0;
  }
}

func_9457() {
  if(maps\mp\_utility::func_C1E() && !isai(self)) {
    var_00 = [];
    if(isDefined(level.var_3E20)) {
      var_00 = level.var_3E20;
    }

    var_01 = ["custom1", "custom2", "custom3", "custom4", "custom5", "class0", "class1", "class2", "class3", "class4"];
    foreach(var_03 in var_01) {
      var_04 = maps\mp\gametypes\_class::func_455F(self.team, var_03, undefined, undefined, 1);
      var_00[var_00.size] = var_04.var_76F8;
    }

    self method_8512(var_00);
  }
}

func_4006(param_00, param_01) {
  var_02 = [];
  if(isDefined(level.var_3E20)) {
    var_02 = level.var_3E20;
  }

  var_03 = param_01;
  if(!maps\mp\_utility::isvalidclass(var_03)) {
    var_03 = self.var_2319;
  }

  if(maps\mp\_utility::isvalidclass(var_03)) {
    var_04 = maps\mp\gametypes\_class::func_455F(self.team, var_03, undefined, undefined, 1);
    var_02[var_02.size] = var_04.var_76F8;
    if(!isDefined(param_00) || !param_00) {
      var_02[var_02.size] = var_04.var_8358;
    }
  }

  return var_02;
}

func_9455(param_00, param_01, param_02) {
  self.var_2327 = 0;
  self notify("endStreamClassWeapons");
  self endon("endStreamClassWeapons");
  self endon("death");
  self endon("disconnect");
  if(isai(self) || !isDefined(param_00)) {
    param_00 = 0;
  }

  var_03 = func_4006(param_01, param_02);
  if(var_03.size > 0) {
    while(isDefined(self.var_5DED) && self.var_5DED) {
      wait 0.05;
    }

    param_00 = !self method_8512(var_03) && param_00;
    self method_8533(1);
    self.var_2327 = param_00;
    while(param_00) {
      wait 0.05;
      param_00 = !self method_8512(var_03);
    }

    self method_8533(0);
  }

  self.var_2327 = 0;
  self notify("streamClassWeaponsComplete");
}

func_A686() {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");
  if(isDefined(self.clientid)) {} else {}

  var_00 = 0;
  var_01 = undefined;
  if(isDefined(level.var_469A)) {
    var_01 = [[level.var_469A]]();
  } else {
    var_02 = getEntArray("mp_global_intermission", "classname");
    var_01 = var_02[randomint(var_02.size)];
  }

  var_03 = self.pers["teamKillPunish"];
  if(isDefined(var_03) && var_03) {
    var_04 = teamkilldelay();
    if(var_04 > 0) {
      maps\mp\_utility::func_86C3("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT", var_04, 1, 1);
      thread func_7DA7(var_01.origin, var_01.angles);
      var_00 = 1;
      wait(var_04);
      maps\mp\_utility::func_2401("friendly_fire");
      self.var_7DB7 = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(teamkilldelay()) {
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
  }

  var_05 = self.pers["suicideSpawnDelay"];
  if(isDefined(var_05) && var_05 > 0) {
    maps\mp\_utility::func_86C3("suicidePenalty", &"MP_SUICIDE_PUNISHED", var_05, 1, 1);
    if(!var_00) {
      thread func_7DA7(var_01.origin, var_01.angles);
    }

    var_00 = 1;
    wait(var_05);
    maps\mp\_utility::func_2401("suicidePenalty");
    self.var_7DB7 = gettime();
    self.pers["suicideSpawnDelay"] = 0;
  }

  if(maps\mp\_utility::func_581D()) {
    self.var_9071 = 1;
    self.var_2AA9 = self.origin;
    self waittill("stopped_using_remote");
  }

  if(!isDefined(self.var_A98A) && isDefined(level.var_A987[self.team])) {
    self.var_A98A = level.var_A987[self.team];
    level.var_A987[self.team]++;
  }

  var_06 = func_9A1C(0);
  var_07 = 0;
  if(var_06 > 0) {
    self setclientomnvar("ui_killcam_time_until_spawn", gettime() + var_06 * 1000);
    if(!var_00) {
      thread func_7DA7(var_01.origin, var_01.angles);
    }

    var_00 = 1;
    maps\mp\_utility::func_A6D1(var_06, "force_spawn");
    self notify("stop_wait_safe_spawn_button");
    var_07 = 1;
  }

  if(func_664E()) {
    maps\mp\_utility::func_86C3("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);
    if(!var_00) {
      thread func_7DA7(var_01.origin, var_01.angles);
    }

    var_00 = 1;
    func_A6FA();
    var_07 = 1;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame && !var_07) {
    wait 0.05;
  }

  self.var_A6F0 = 0;
  maps\mp\_utility::func_2401("spawn_info");
  self.var_A98A = undefined;
  var_08 = level.gametype != "gun";
  thread func_9084(0, var_08);
}

func_664E() {
  if(maps\mp\gametypes\_tweakables::gettweakablevalue("player", "forcerespawn") != 0) {
    return 0;
  }

  if(!self.hasspawned) {
    return 0;
  }

  var_00 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;
  if(var_00) {
    return 0;
  }

  if(self.var_A7F5) {
    return 0;
  }

  return 1;
}

func_A6FA() {
  self endon("disconnect");
  self endon("end_respawn");
  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

func_7CFA(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(param_00);
  maps\mp\_utility::func_2401("spawn_info");
}

func_5BF0() {
  self laststandrevive();
  if(maps\mp\_utility::_hasperk("specialty_finalstand") && !level.diehardmode) {
    maps\mp\_utility::func_735("specialty_finalstand");
  }

  if(level.diehardmode) {
    self.headicon = "";
  }

  self setstance("crouch");
  self.var_7E54 = 1;
  self notify("revive");
  if(isDefined(self.var_9165)) {
    self.maxhealth = self.var_9165;
  }

  self.health = self.maxhealth;
  common_scripts\utility::func_615();
  if(game["state"] == "postgame") {
    maps\mp\gametypes\_gamelogic::func_9412();
  }
}

func_4489() {
  var_00 = spawn("script_origin", self.origin);
  var_00 hide();
  var_00.angles = self.angles;
  return var_00;
}

func_8C17() {}

func_4695(param_00) {
  var_01 = spawnStruct();
  var_01.var_9088 = undefined;
  var_01.var_7588 = param_00.origin;
  if(!positionwouldtelefrag(param_00.origin) || !isDefined(param_00.var_CAD)) {
    return var_01;
  }

  foreach(var_03 in param_00.var_CAD) {
    if(!isDefined(var_01.var_9088)) {
      var_01.var_9088 = 0;
    } else {
      var_01.var_9088 = var_01.var_9088 + 1;
    }

    if(!positionwouldtelefrag(var_03)) {
      var_01.var_7588 = var_03;
      return var_01;
    }
  }

  var_01.var_9088 = undefined;
  return var_01;
}

func_9A2F() {
  if(!isDefined(self.var_872A)) {
    return 0;
  }

  var_00 = getEntArray("care_package", "targetname");
  foreach(var_02 in var_00) {
    if(distancesquared(var_02.origin, self.var_872A.var_7464) > 4096) {
      continue;
    }

    maps\mp\perks\_perkfunctions::func_2D54(self.var_872A);
    return 0;
  }

  if(maps\mp\_utility::func_5668(0)) {
    maps\mp\perks\_perkfunctions::func_2D54(self.var_872A);
    self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_FLAKGUNS");
    return 0;
  }

  return 1;
}

func_9072() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  wait 0.05;
  level.var_689B--;
}

func_8753(param_00) {
  self endon("disconnect");
  self endon("joined_spectators");
  while(self method_8436() && !maps\mp\_utility::func_551F()) {
    wait 0.05;
  }

  self setclientomnvar("ui_options_menu", param_00);
}

func_4005() {
  var_00 = [];
  if(isDefined(self.var_5DEE)) {
    var_00[var_00.size] = maps\mp\_utility::func_4340(self.var_5DEE);
    if(isDefined(self.var_5DEE.var_8358) && self.var_5DEE.var_8358 != "none") {
      var_00[var_00.size] = self.var_5DEE.var_8358;
    }
  } else {
    if(isDefined(self.primaryweapon) && self.primaryweapon != "none") {
      var_00[var_00.size] = self.primaryweapon;
    }

    if(isDefined(self.var_835A) && self.var_835A != "none") {
      var_00[var_00.size] = self.var_835A;
    }
  }

  return var_00;
}

func_A919() {
  self notify("watchHasDoneCombat");
  self endon("watchHasDoneCombat");
  for(;;) {
    if(isDefined(self.var_4B62) && self.var_4B62) {
      self notify("hasDoneCombatTrue");
      return;
    }

    self waittill("hasDoneCombat");
  }
}

func_A79A() {
  self endon("hasDoneCombatTrue");
  thread func_A919();
  maps\mp\_utility::func_3FA5("team_collision_on");
}

func_5FCC() {
  self endon("disconnect");
  self notify("manageTeamPlayerCollision");
  self endon("manageTeamPlayerCollision");
  if(maps\mp\_utility::func_3FA0("team_collision_on")) {
    self setteamplayercollision(1);
    return;
  }

  self setteamplayercollision(0);
  func_A79A();
  self setteamplayercollision(1);
}

func_9084(param_00, param_01) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");
  if(isDefined(self.clientid)) {} else {}

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01) {
    self.var_9085 = 1;
    thread func_637B();
  }

  self.var_5CC6 = maps\mp\_utility::func_45AD(self.name);
  self.var_9AB6 = 0;
  var_02 = undefined;
  self.var_99BD = 0;
  self.var_6E6B = 0;
  self.var_5723 = 0;
  self.var_A258 = 0;
  self.var_A25A = 0;
  self.usingriotshield = 0;
  self.hideshieldmodels = 0;
  if(!isDefined(self.pers["spawnCount"])) {
    self.pers["spawnCount"] = 0;
  }

  if(!isDefined(self.pers["badSpawnByAnyMeansCount"])) {
    self.pers["badSpawnByAnyMeansCount"] = 0;
  }

  if(!isDefined(self.pers["immediateActionSpawnCount"])) {
    self.pers["immediateActionSpawnCount"] = 0;
  }

  if(!isDefined(self.pers["victimSpawnCount"])) {
    self.pers["victimSpawnCount"] = 0;
  }

  if(!isDefined(self.pers["causedBadSpawnByAnyMeansCount"])) {
    self.pers["causedBadSpawnByAnyMeansCount"] = 0;
  }

  if(!isDefined(self.pers["causedImmediateActionSpawnCount"])) {
    self.pers["causedImmediateActionSpawnCount"] = 0;
  }

  if(!isDefined(self.pers["causedVictimSpawnCount"])) {
    self.pers["causedVictimSpawnCount"] = 0;
  }

  if(common_scripts\utility::func_562E(level.var_9565)) {
    if(game["switchedsides"]) {
      self switchcustomizationteam(1);
    }
  }

  thread func_8753(0);
  self setclientomnvar("ui_hud_shake", 0);
  self setdemigod(0);
  self method_852E();
  level.var_689B++;
  if(level.var_689B > 1) {
    self.var_A6F1 = 1;
    wait(0.05 * level.var_689B - 1);
  }

  thread func_9072();
  self.var_A6F1 = 0;
  maps\mp\gametypes\_divisions::func_2406();
  self.var_509B = 0;
  if(param_01) {
    maps\mp\gametypes\_class::func_4790(self.team, self.var_2319);
    var_03 = func_4005();
    self.var_5DED = 1;
    if(!function_0367() && !self method_842C(self, var_03)) {
      self.var_A6F1 = 1;
      self method_8533(1);
      for(;;) {
        self method_812C(0);
        wait 0.05;
        var_03 = func_4005();
        if(self method_842C(self, var_03)) {
          break;
        }
      }

      self method_8533(0);
      self method_812C(1);
      self.var_A6F1 = 0;
    }

    self.var_5DED = 0;
  }

  self.playerconnectedbuthasntstreamedweapons = 0;
  if(function_0367() && !function_026D(self) && !isai(self)) {
    if(maps\mp\gametypes\_hud_util::func_5527()) {
      var_04 = [449, 449, 449, 449, 0, 0, 0];
    } else {
      var_04 = maps\mp\gametypes\_class::func_1F99(common_scripts\utility::func_46AF());
    }

    while(!self method_86B9(var_04)) {
      self setcostumemodels(var_04);
      wait 0.05;
    }
  }

  if(isDefined(self.var_6E6E) && self.var_6E6E && isDefined(self.var_5DEE) && isDefined(self.var_5DEE.var_79) && self.var_5DEE.var_79 != 8) {
    self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_WRONGDIVISION");
    maps\mp\perks\_perkfunctions::func_2D54(self.var_872A);
  } else if(isDefined(self.var_6E6C) && self.var_6E6C && !isDefined(self.var_872A)) {
    self iprintlnbold(&"DIVISIONS_DLC4_INSERTION_FLARE_INVALID_DESTROYED");
    self.var_872A = undefined;
    self.var_6E6E = 0;
  }

  self.var_6E6C = 0;
  if(isDefined(self.var_3E2C)) {
    var_05 = self.var_3E2C;
    self.var_3E2C = undefined;
    if(isDefined(self.var_3E2B)) {
      var_06 = self.var_3E2B;
      self.var_3E2B = undefined;
    } else {
      var_06 = (0, randomfloatrange(0, 360), 0);
    }
  } else if(isDefined(self.var_872A) && isDefined(self.var_872A.var_6817) || func_9A2F()) {
    var_06 = self.var_872A;
    if(!isDefined(self.var_872A.var_6817)) {
      self.var_99BD = 1;
      self disableweapons();
      self playlocalsound("tactical_spawn");
      if(level.multiteambased) {
        foreach(var_08 in level.teamnamelist) {
          if(var_08 != self.team) {
            self method_860E("tactical_spawn", var_08);
          }
        }
      } else if(level.teambased) {
        self method_860E("tactical_spawn", level.var_6C63[self.team]);
      } else {
        self playSound("tactical_spawn");
      }
    }

    foreach(var_0B in level.var_9FEA) {
      if(distancesquared(var_0B.origin, var_02.var_7464) < 1024) {
        var_0B notify("damage", 5000, var_0B.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, "killstreak_emp_mp");
      }
    }

    var_05 = self.var_872A.var_7464;
    var_06 = self.var_872A.playerspawnangles;
    var_02 = undefined;
  } else if(isDefined(self.var_4C9D) && (!isDefined(self.var_3C6F) || isDefined(self.var_3C6F) && self.var_3C6F) && level.prematchperiod > 0 && self.team == "allies") {
    while(!isDefined(level.var_BF5)) {
      wait(0.1);
    }

    var_05 = level.var_BF5.origin;
    var_06 = level.var_BF5.angles;
    self.var_3C6F = 0;
  } else if(isDefined(self.fighterspawningfunc)) {
    var_0D = self[[self.fighterspawningfunc]]();
    self.fighterspawnorigin = var_0D[0];
    self.fighterspawnangles = var_0D[1];
    var_05 = (clamp(self.fighterspawnorigin[0], -32767, 32767), clamp(self.fighterspawnorigin[1], -32767, 32767), clamp(self.fighterspawnorigin[2], -32767, 32767));
    var_06 = self.fighterspawnangles;
  } else if(isDefined(self.var_4C9D) && (!isDefined(self.var_3C6F) || isDefined(self.var_3C6F) && self.var_3C6F) && level.prematchperiod > 0 && self.team == "axis") {
    while(!isDefined(level.var_147B)) {
      wait(0.1);
    }

    var_05 = level.var_147B.origin;
    var_06 = level.var_147B.angles;
    self.var_3C6F = 0;
  } else {
    var_06 = [[level.var_4696]]();
    var_05 = var_06.origin;
    var_06 = var_05.angles;
  }

  func_872B();
  var_0E = self.hasspawned;
  self.pers["spawnCount"]++;
  setfauxdead(self, 0);
  if(!param_00) {
    self.killsthislife = [];
    var_0F = self.sessionstate == "spectator";
    maps\mp\_utility::updatesessionstate("playing");
    maps\mp\_utility::func_23FF();
    self.var_1F3F = undefined;
    self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "maxhealth");
    self.health = self.maxhealth;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.var_90AC = maps\mp\_matchdata::getmatchtimepassed();
    self.var_3C6C = undefined;
    self.var_A87A = !isDefined(var_02) || isDefined(self.var_6E6E) && self.var_6E6E;
    self.var_A34 = 0;
    self.var_29BD = [];
    self.var_5A73 = 1;
    self.var_696D = 1;
    self.var_2313 = undefined;
    self.var_8AFE = 0;
    self.var_8AFD = 0;
    self.attackers = [];
    self.var_1189 = [];
    self.var_A495 = [];
    self.var_A491 = [];
    self.var_29B9 = 0;
    self.var_29DA = 0;
    self.var_9A16 = 0;
    self.var_9A17 = 0;
    self.var_90AD = -1;
    self.var_90AE = -1;
    self.var_3905 = 0;
    self.var_3900 = 0;
    self.var_80A7 = self.pers["score"];
    if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"])) {
      self.var_AAD0 = self.pers["summary"]["xp"];
    }

    if(isDefined(level.iszombiegame) && level.iszombiegame) {
      if(isDefined(level.var_789)) {
        self thread[[level.var_789]]();
      }
    } else {
      thread maps\mp\_breadcrumbdata::func_5E8B();
    }

    if(isDefined(self.team) && level.iszombiegame == 0 && !function_0367()) {
      setmatchdata("players", self.clientid, "team", self.team);
    }

    if(var_0F) {
      level notify("spawn_after_spectator", self);
    }
  }

  maps\mp\gametypes\_weapons::func_A13B();
  self setviewkickscale(1);
  self.var_5720 = 0;
  self.isinthaw = 0;
  self.var_5378 = 0;
  self.laststand = undefined;
  self.infinalstand = undefined;
  self.var_2F81 = 0;
  self.var_2F82 = 0;
  self.var_2F7E = 0;
  common_scripts\utility::func_7D75();
  self.var_73D4 = [];
  if(function_0367() && !isDefined(self.team) || self.team != "allies") {
    maps\mp\gametypes\_menus::func_9FC("allies");
  }

  if(!param_00) {
    self.var_1444 = 5;
    var_10 = self.pers["lives"];
    if(var_10 == maps\mp\_utility::func_44FC()) {
      func_09F9();
    }

    if(var_10) {
      self.pers["lives"]--;
    }

    func_09F7();
    if(!var_0E || maps\mp\_utility::func_3FA6() || maps\mp\_utility::func_3FA6() && level.var_5139 && self.var_4B62) {
      func_7CDE();
    }

    if(!self.wasaliveatmatchstart) {
      var_11 = 20;
      if(maps\mp\_utility::func_46E2() > 0 && var_11 < maps\mp\_utility::func_46E2() * 60 / 4) {
        var_11 = maps\mp\_utility::func_46E2() * 60 / 4;
      }

      if(level.var_5139 || maps\mp\_utility::gettimepassed() < var_11 * 1000) {
        self.wasaliveatmatchstart = 1;
      }
    }
  }

  if(level.console) {
    self setclientdvar("cg_fov", "65");
  }

  func_7D73();
  self luinotifyevent(&"player_respawned", 0);
  var_12 = undefined;
  var_13 = undefined;
  if(isDefined(var_02)) {
    lib_050D::func_3B4A(var_02);
    var_14 = func_4695(var_02);
    var_05 = var_14.var_7588;
    var_06 = var_02.angles;
    if(isDefined(var_02.var_5700) && var_02.var_5700) {
      var_12 = var_02.index;
      var_13 = var_14.var_9088;
    }
  }

  self.var_9092 = var_05;
  self.var_5BE2 = gettime();
  self.var_4B7A = 0;
  self spawn_0(var_05, var_06, var_12, var_13);
  maps\mp\_utility::func_8668(level.dofdefault);
  maps\mp\_utility::func_86F8();
  if(param_00 && isDefined(self.var_3A5E)) {
    self setstance(self.var_3A5E);
    self.var_3A5E = undefined;
  }

  [[level.var_6BA7]]();
  if(function_03BC()) {
    var_15 = 255;
    if(isDefined(self.var_2943)) {
      var_15 = self.var_2943;
    }

    self dlogevent("dtel_spawn", ["spawn", ["life_index", self.var_5CC6, "player_index", self.clientid, "spawn_pos", [int(self.var_9092[0]), int(self.var_9092[1]), int(self.var_9092[2])], "spawn_time_ms", self.var_5BE2, "loadout_index", var_15]]);
  }

  if(!param_00) {
    maps\mp\gametypes\_missions::playerspawned();
    if(isai(self) && isDefined(level.var_19D5) && isDefined(level.var_19D5["player_spawned"])) {
      self[[level.var_19D5["player_spawned"]]]();
    }
  }

  maps\mp\gametypes\_class::func_864F(self.var_2319);
  if(isDefined(level.var_296B)) {
    self[[level.var_296B]](param_00);
  } else if(param_01) {
    maps\mp\gametypes\_class::func_F35();
    self notify("spawnplayer_giveloadout");
  }

  if(getdvarint("311")) {
    maps\mp\_utility::setthirdpersondof(1);
  }

  if(!function_0367()) {
    if(!maps\mp\_utility::func_3FA0("prematch_done")) {
      maps\mp\_utility::func_3E8F(0);
      self method_800F();
      thread func_5FCC();
    } else {
      maps\mp\_utility::func_3E8F(1);
      self method_800E();
    }
  } else {
    maps\mp\_utility::func_3E8F(1);
    self method_800E();
  }

  if(isDefined(self.var_90E1)) {
    if(isPlayer(self)) {
      if(self.var_90E1 maps\mp\_utility::_hasperk("specialty_perception") || self.var_90E1 maps\mp\_utility::_hasperk("specialty_class_perception")) {
        thread maps\mp\gametypes\_killcam::func_238F(self.var_90E1);
      }

      if(isDefined(self.var_90E1.var_79)) {
        thread maps\mp\gametypes\_killcam::func_237D(self.var_90E1);
      }
    }

    self.var_90E1 = undefined;
  }

  if(!maps\mp\_utility::func_3FA0("prematch_done") || !var_0E && game["state"] == "playing") {
    var_16 = self.pers["team"];
    if(maps\mp\_utility::func_5380()) {
      thread maps\mp\gametypes\_hud_message::func_6A64(game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, (1, 0, 0), "mp_last_stand");
    }

    thread func_8C17();
  }

  if(maps\mp\_utility::func_4529("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {}

  waittillframeend;
  self.var_9071 = undefined;
  self notify("spawned_player");
  level notify("player_spawned", self);
  if(game["state"] == "postgame") {
    maps\mp\gametypes\_gamelogic::func_9412();
  }

  if(isDefined(level.var_6034) && level.var_6034) {
    self setclientomnvar("ui_disable_team_change", 1);
  }

  thread maps\mp\_minimap_location_callout::func_63C2();
  thread func_75F2();
}

func_637B() {
  self endon("disconnect");
  common_scripts\utility::waittill_any("joined_spectators", "spawnplayer_giveloadout");
  self.var_9085 = undefined;
}

func_90A5(param_00, param_01) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  func_50D2(param_00, param_01);
}

func_7DA7(param_00, param_01) {
  func_50D2(param_00, param_01);
}

func_50D2(param_00, param_01) {
  func_872B();
  var_02 = self.pers["team"];
  if(isDefined(var_02) && var_02 == "spectator" && !level.gameended) {
    maps\mp\_utility::func_2401("spawn_info");
  }

  maps\mp\_utility::updatesessionstate("spectator");
  maps\mp\_utility::func_23FF();
  self.friendlydamage = undefined;
  self.var_5DED = undefined;
  func_7D74();
  maps\mp\gametypes\_spectating::func_872F();
  func_6BAB(param_00, param_01);
  if(isDefined(level.onspawnspectatorgamemode)) {
    [[level.onspawnspectatorgamemode]]();
  }

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer()) {
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  }
}

func_4622(param_00) {
  if(param_00 < 0) {
    return undefined;
  }

  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    if(level.players[var_01] getentitynumber() == param_00) {
      return level.players[var_01];
    }
  }

  return undefined;
}

func_4651() {
  if(isDefined(level.var_469A)) {
    return [[level.var_469A]]();
  }

  var_00 = "mp_global_intermission";
  var_01 = getEntArray(var_00, "classname");
  var_02 = lib_050E::func_839A(var_01);
  return var_02;
}

func_6BAB(param_00, param_01) {
  if(isDefined(param_00) && isDefined(param_01)) {
    self setspectatedefaults(param_00, param_01);
    self spawn_0(param_00, param_01);
    return;
  }

  var_02 = func_4651();
  self setspectatedefaults(var_02.origin, var_02.angles);
  self spawn_0(var_02.origin, var_02.angles);
}

func_9073() {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");
  func_872B();
  maps\mp\_utility::clearlowermessages();
  maps\mp\_utility::func_3E8E(1);
  self method_800F();
  self setclientdvar("3724", 1);
  var_00 = self.pers["postGameChallenges"];
  if(level.rankedmatch && self.var_75E5 || isDefined(var_00) && var_00) {
    if(self.var_75E5) {
      self playlocalsound("mp_level_up");
    } else if(isDefined(var_00)) {
      self playlocalsound("mp_challenge_complete");
    }

    if(self.var_75E5 > level.var_75E4) {
      level.var_75E4 = 1;
    }

    if(isDefined(var_00) && var_00 > level.var_75E4) {
      level.var_75E4 = var_00;
    }

    var_01 = 7;
    if(isDefined(var_00)) {
      var_01 = 4 + min(var_00, 3);
    }

    while(var_01) {
      wait(0.25);
      var_01 = var_01 - 0.25;
    }
  }

  maps\mp\_utility::updatesessionstate("intermission");
  maps\mp\_utility::func_23FF();
  self.friendlydamage = undefined;
  var_02 = undefined;
  if(isDefined(level.var_4526)) {
    var_02 = [[level.var_4526]]();
  } else {
    var_03 = getEntArray("mp_global_intermission", "classname");
    var_02 = var_03[0];
  }

  self spawn_0(var_02.origin, var_02.angles);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

func_9049() {
  if(1) {
    maps\mp\_utility::func_3E8E(1);
    self method_800F();
    func_90A5();
    maps\mp\_utility::func_3E8E(1);
    self method_800F();
    return;
  }

  self notify("spawned");
  self notify("end_respawn");
  func_872B();
  maps\mp\_utility::clearlowermessages();
  self setclientdvar("3724", 1);
  maps\mp\_utility::updatesessionstate("dead");
  maps\mp\_utility::func_23FF();
  self.friendlydamage = undefined;
  var_00 = undefined;
  if(isDefined(level.var_44B6)) {
    var_00 = [[level.var_44B6]]();
  } else {
    var_01 = getEntArray("mp_global_intermission", "classname");
    var_00 = lib_050E::func_839A(var_01);
  }

  self spawn_0(var_00.origin, var_00.angles);
  var_00 setModel("tag_origin");
  self playerlinkTo(var_00);
  self method_8003();
  maps\mp\_utility::func_3E8E(1);
  self method_800F();
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

func_872B() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self.var_2AA9 = undefined;
}

func_6805() {
  waittillframeend;
  if(isDefined(self)) {
    level notify("connecting", self);
  }
}

func_5EA9() {
  if(function_0367()) {
    return;
  }

  if(isDefined(self.pers["totalKillcamsSkipped"])) {
    setmatchdata("players", self.clientid, "killcams_skipped", maps\mp\_utility::func_2314(self.pers["totalKillcamsSkipped"]));
  }

  if(isDefined(self.pers["totalKillcamsInterrupted"])) {
    setmatchdata("players", self.clientid, "killcams_interrupted", maps\mp\_utility::func_2314(self.pers["totalKillcamsInterrupted"]));
  }

  if(isDefined(self.pers["weaponPickupsCount"])) {
    setmatchdata("players", self.clientid, "weapon_pickups_count", maps\mp\_utility::func_2314(self.pers["weaponPickupsCount"]));
  }

  if(isDefined(self.pers["suicides"])) {
    setmatchdata("players", self.clientid, "suicides_total", maps\mp\_utility::func_2314(self.pers["suicides"]));
  }

  if(isDefined(self.pers["headshots"])) {
    setmatchdata("players", self.clientid, "headshots_total", maps\mp\_utility::clamptoshort(self.pers["headshots"]));
  }

  if(isDefined(self.pers["pingAccumulation"]) && isDefined(self.pers["pingSampleCount"])) {
    if(self.pers["pingSampleCount"] > 0) {
      var_00 = maps\mp\_utility::func_2314(self.pers["pingAccumulation"] / self.pers["pingSampleCount"]);
      setmatchdata("players", self.clientid, "average_ping", var_00);
    }
  }

  if(maps\mp\_utility::rankingenabled()) {
    var_01 = 3;
    var_02 = 0;
    for(var_03 = 0; var_03 < var_01; var_03++) {
      var_04 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "xpMultiplier", var_03);
      if(isDefined(var_04) && var_04 > var_02) {
        var_02 = var_04;
      }
    }

    if(var_02 > 0) {
      setmatchdata("players", self.clientid, "xp_multiplier", var_02);
    }
  }

  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["clanWarsXP"])) {
    setmatchdata("players", self.clientid, "clanwars_xp", self.pers["summary"]["clanWarsXP"]);
  }
}

func_1E6A(param_00) {
  if(!isDefined(self.var_2582)) {
    return;
  }

  if(function_0367()) {
    if(isdedicatedserver() && !function_0279(self)) {
      var_01 = self.var_4F4C;
      if(!isDefined(var_01)) {
        var_01 = -1;
      }

      var_02 = self.clientid;
      if(!isDefined(var_02)) {
        var_02 = -1;
      }

      if(!isDefined(param_00)) {
        param_00 = "null";
      }

      self dlogevent("telemetry_hq_event", ["base", ["hq_guid", function_0398(), "utc_timestamp_join", var_01, "data_center_id", function_0397(), "game_time", gettime(), "player_index", var_02, "player_count", level.players.size, "event_name", "leave", "event_category", "hq_session_info", "duration_seconds", 0], "leave", ["reason", param_00]]);
    }
  } else {
    setmatchdata("players", self.clientid, "utc_disconnect_time_s", getsystemtime());
    setmatchdata("players", self.clientid, "disconnect_reason", param_00);
    var_03 = getmatchdata("match_common", "player_count_left");
    var_03++;
    setmatchdata("match_common", "player_count_left", var_03);
    if(!level.iszombiegame) {
      setmatchdata("players", self.clientid, "match_result", "quit");
    }

    if(level.iszombiegame) {
      setmatchdata("players", self.clientid, "play_time", self.timeplayed["total"]);
      setmatchdata("players", self.clientid, "player_quit_on_round", maps\mp\_utility::func_2314(level.var_A980));
    }

    var_04 = getmatchdata("players", self.clientid, "playermatchtime_start_ms");
    var_05 = getmatchdata("players", self.clientid, "playermatchtime_total_ms");
    var_05 = var_05 + gettime() - var_04;
    setmatchdata("players", self.clientid, "playermatchtime_total_ms", var_05);
    if(maps\mp\_utility::rankingenabled()) {
      maps\mp\_matchdata::func_5E92();
    }

    maps\mp\_matchdata::func_5EA4();
    if(isDefined(self.pers["confirmed"])) {
      maps\mp\_matchdata::func_5E97();
    }

    if(isDefined(self.pers["denied"])) {
      maps\mp\_matchdata::func_5E98();
    }

    func_5EA9();
    if(!level.iszombiegame) {
      if(maps\mp\_utility::func_57B2()) {
        var_06 = game["roundsPlayed"] + 1;
        setmatchdata("players", self.clientid, "player_quit_round", var_06);
        if(isDefined(self.team) && self.team == "allies" || self.team == "axis") {
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

  maps\mp\_skill::func_775A();
  maps\mp\gametypes\_killcam_nemesis::func_4AB9();
  func_7CF5();
  lib_050D::func_7CDF();
  if(isDefined(self.waterwakevfxdeletefunc)) {
    self[[self.waterwakevfxdeletefunc]]();
  }

  cleanupentsonplayerdisconnect();
  removefromcharactersarray(self);
  var_07 = self getentitynumber();
  if(!level.teambased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(!level.gameended) {
    maps\mp\_utility::func_5EB0();
  }

  if(level.splitscreen) {
    var_08 = level.players;
    if(var_08.size <= 1) {
      level thread maps\mp\gametypes\_gamelogic::func_3E1A();
    }
  }

  maps\mp\gametypes\_gamelogic::func_8700(self);
  function_00F5("script_mp_playerquit: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());
  var_09 = self getentitynumber();
  var_0A = self.guid;
  function_015A("Q;" + var_0A + ";" + var_09 + ";" + self.name + "\n");
  thread maps\mp\_events::func_2FC1();
  if(level.gameended) {
    maps\mp\gametypes\_gamescore::func_7CD8();
  }

  if(isDefined(self.team)) {
    func_7CE1();
  }

  if(self.sessionstate == "playing" && !function_02D2(self)) {
    func_7CDD(1);
    return;
  }

  if(self.sessionstate == "spectator" || self.sessionstate == "dead") {
    level thread maps\mp\gametypes\_gamelogic::updategameevents();
  }
}

func_7CF5() {
  var_00 = 0;
  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    if(level.players[var_01] == self) {
      var_00 = 1;
      while(var_01 < level.players.size - 1) {
        level.players[var_01] = level.players[var_01 + 1];
        var_01++;
      }

      level.players[var_01] = undefined;
      break;
    }
  }
}

func_52A3() {
  if((level.splitscreen || self issplitscreenplayer()) && !function_03BA()) {
    self setclientdvars("2772", "90", "4217", "40", "2777", "40", "416", "35", "2913", "0 0", "3078", "0.75");
  } else {
    self setclientdvars("2772", "180", "4217", "80", "2777", "80", "416", "70", "2913", "0 0", "3078", "1");
  }

  maps\mp\perks\_perkfunctions::func_A05D();
}

func_52A2() {
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

  if(isDefined(level.var_CB4) && level.var_CB4) {
    setDvar("4934", 1);
  } else {
    setDvar("4934", 0);
  }

  func_52A3();
  if(maps\mp\_utility::func_44FC()) {
    self setclientdvars("2651", 1, "3328", 0, "1176", 0, "558", 0);
  } else {
    self setclientdvars("2651", 0, "3328", 1, "1176", 1, "558", 0);
  }

  if(level.teambased) {
    self setclientdvars("3724", 0);
  }

  if(getdvarint("scr_hitloc_debug")) {
    for(var_00 = 0; var_00 < 6; var_00++) {
      self setclientdvar("ui_hitloc_" + var_00, "");
    }

    self.var_4DDA = 1;
  }

  self setclientdvars("ui_raid_hide_fighter", 1, "ui_raid_hide_scorestreaks", 0);
}

func_456A() {
  var_00 = 0;
  for(var_01 = 0; var_01 < 24; var_01++) {
    foreach(var_03 in level.players) {
      if(!isDefined(var_03)) {
        continue;
      }

      if(var_03.var_2418 == var_01) {
        var_00 = 1;
        break;
      }

      var_00 = 0;
    }

    if(!var_00) {
      return var_01;
    }
  }
}

func_8A40() {
  self.var_805F = [];
  for(var_00 = 1; var_00 <= 4; var_00++) {
    self.var_805F[var_00] = spawnStruct();
    self.var_805F[var_00].type = "";
    self.var_805F[var_00].var_586B = undefined;
  }

  if(!level.console) {
    for(var_00 = 5; var_00 <= 8; var_00++) {
      self.var_805F[var_00] = spawnStruct();
      self.var_805F[var_00].type = "";
      self.var_805F[var_00].var_586B = undefined;
    }
  }
}

func_5EA2() {
  var_00 = function_02B4();
  var_01 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "consoleIDChunkLow", var_00);
  var_02 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "consoleIDChunkHigh", var_00);
  var_03 = 3;
  var_04 = -1;
  if(isDefined(var_02) && var_02 != 0 && isDefined(var_01) && var_01 != 0) {
    for(var_05 = 0; var_05 < var_03; var_05++) {
      var_06 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "deviceConnectionHistory", var_05, "device_id_high");
      var_07 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "deviceConnectionHistory", var_05, "device_id_low");
      if(var_06 == var_02 && var_07 == var_01) {
        var_04 = var_05;
        break;
      }
    }
  }

  if(var_04 == -1) {
    var_08 = 0;
    for(var_05 = 0; var_05 < var_03; var_05++) {
      var_09 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "deviceConnectionHistory", var_05, "deviceUseFrequency");
      if(var_09 > var_08) {
        var_08 = var_09;
        var_04 = var_05;
      }
    }
  }

  if(var_04 == -1) {
    var_04 = 0;
  }

  var_0A = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "deviceConnectionHistory", var_04, "onWifi");
  if(var_0A) {
    setmatchdata("players", self.clientid, "onwifi", 1);
  }
}

func_9E05(param_00) {
  var_01 = common_scripts\utility::func_9462(param_00, "]");
  if(var_01 >= 0 && common_scripts\utility::string_starts_with(param_00, "[")) {
    param_00 = getsubstr(param_00, var_01 + 1);
  }

  return param_00;
}

callback_playerconnect() {
  var_00 = func_4651();
  self setspectatedefaults(var_00.origin, var_00.angles);
  self.playerconnectedbuthasntstreamedweapons = 1;
  thread func_6805();
  self waittill("begin");
  self.var_2589 = gettime();
  if(isDefined(level.resetclientomnvarcallback)) {
    [[level.resetclientomnvarcallback]](self);
  }

  level notify("connected", self);
  self.var_2582 = 1;
  level.var_596C = common_scripts\utility::func_F6F(level.var_596C, self);
  if(self ishost()) {
    level.player = self;
  }

  self.var_A25B = self method_801A();
  func_52A2();
  func_5336();
  if(getDvar("233") == "1") {
    level waittill("eternity");
  }

  self.guid = self getguid();
  self.var_1D6 = self getxuid();
  self.var_9AB6 = 0;
  var_01 = 0;
  var_02 = 0;
  if(!isDefined(self.pers["clientid"])) {
    if(function_0367()) {
      self.pers["clientid"] = game["clientid"];
      game["clientid"]++;
    } else {
      for(var_03 = 0; var_03 < 24; var_03++) {
        var_04 = getmatchdata("players", var_03, "client", "user_id");
        if(var_04 == self.guid) {
          self.pers["clientid"] = var_03;
          var_02 = 1;
          var_05 = getmatchdata("match_common", "player_count_reconnect");
          var_05++;
          setmatchdata("match_common", "player_count_reconnect", var_05);
          setmatchdata("players", var_03, "utc_reconnect_time_s", getsystemtime());
          break;
        }
      }

      if(!var_02) {
        if(game["clientid"] >= 24) {
          self.pers["clientid"] = func_456A();
        } else {
          self.pers["clientid"] = game["clientid"];
        }

        if(game["clientid"] < 24) {
          game["clientid"]++;
        }
      }
    }

    var_01 = 1;
  }

  if(var_01 && !maps\mp\_utility::func_551F()) {
    maps\mp\killstreaks\_killstreaks::func_7D50(1);
    maps\mp\perks\_perkfunctions::resetspecialistperkstreak();
  }

  if(maps\mp\_utility::practiceroundgame() && var_01) {
    maps\mp\gametypes\_class::func_10E3();
  }

  if(getdvarint("spv_stream_primaries_on_connect", 0) == 1) {
    if(var_01) {
      func_9457();
    }
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  self.pers["suicideSpawnDelay"] = 0;
  if(var_01) {
    function_00F5("script_mp_playerjoin: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());
  }

  function_015A("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
  if(!function_0367() && game["clientid"] < 24 && game["clientid"] != getmatchdata("match_common", "player_count")) {
    if(!isai(self) && maps\mp\_utility::func_602B() && getdvarint("4017", 0) == 0) {
      self registerparty(self.clientid);
    }

    setmatchdata("match_common", "player_count", game["clientid"]);
    setmatchdata("players", self.clientid, "client", "gamer_tag", func_9E05(self.name));
    setmatchdata("players", self.clientid, "client", "country", self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "country"));
    setmatchdata("players", self.clientid, "client", "language", self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "language"));
    setmatchdata("players", self.clientid, "client", "timezone", self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "timezone"));
    if(!isDefined(level.iszombiegame) && level.iszombiegame) {
      var_06 = self getrankedplayerdata(common_scripts\utility::func_46A9(), "activeCostume");
      setmatchdata("players", self.clientid, "costume", "head", self getrankedplayerdata(common_scripts\utility::func_46A9(), "globalCostume", "head"));
      setmatchdata("players", self.clientid, "costume", "shirt", self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", var_06, "shirt"));
      setmatchdata("players", self.clientid, "costume", "pants", self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", var_06, "pants"));
      setmatchdata("players", self.clientid, "costume", "eyewear", self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", var_06, "eyewear"));
      setmatchdata("players", self.clientid, "costume", "hat", self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", var_06, "hat"));
      setmatchdata("players", self.clientid, "costume", "gear", self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", var_06, "gear"));
      setmatchdata("players", self.clientid, "costume", "uniform", self getrankedplayerdata(common_scripts\utility::func_46A9(), "costumes", var_06, "uniform"));
    }

    var_07 = self getentitynumber();
    setmatchdata("players", self.clientid, "code_client_num", maps\mp\_utility::func_2314(var_07));
    function_039F(self, self.clientid);
    setmatchdata("players", self.clientid, "join_type", self getjointype());
    if(var_01) {
      setmatchdata("players", self.clientid, "utc_connect_time_s", getsystemtime());
    }

    if(maps\mp\_utility::func_585F()) {
      if(var_01) {
        setmatchdata("players", self.clientid, "utc_first_spawn_time_s", 0);
      }
    } else {
      setmatchdata("players", self.clientid, "is_bot", isai(self));
    }

    func_5EA2();
    if(self ishost()) {
      setmatchdata("players", self.clientid, "was_host", 1);
    }

    if(maps\mp\_utility::rankingenabled()) {
      maps\mp\_matchdata::func_5E95();
    }

    if(function_026D(self) || isai(self)) {
      var_08 = 1;
    } else {
      var_08 = 0;
    }

    if(maps\mp\_utility::func_602B() && maps\mp\_utility::func_C2D() && !var_08) {}

    if(maps\mp\_utility::func_566A(self)) {
      if(!isDefined(level.var_6026)) {
        level.var_6026 = [];
      }

      if(!isDefined(game["botJoinCount"])) {
        game["botJoinCount"] = 1;
      } else {
        game["botJoinCount"]++;
      }
    }
  }

  if(!level.teambased) {
    game["roundsWon"][self.guid] = 0;
  }

  self.var_5C47 = [];
  self.var_5C42 = [];
  self.var_5C3D = undefined;
  self.var_5C40 = [];
  self.var_5C3F = "";
  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
    self.killstreakcount = 0;
  }

  if(!isDefined(self.pers["cur_death_streak"])) {
    self.pers["cur_death_streak"] = 0;
  }

  if(!isDefined(self.pers["cur_kill_streak_for_nuke"])) {
    self.pers["cur_kill_streak_for_nuke"] = 0;
  }

  thread maps\mp\gametypes\_killcam_nemesis::init();
  if(maps\mp\_utility::rankingenabled()) {
    self.kill_streak = maps\mp\gametypes\_persistence::func_932F("killStreak");
  }

  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  if(isDefined(game["firstbloodcount"]) && isDefined(game["firstbloodcount"][self.guid])) {
    self.firstbloodcount = game["firstbloodcount"][self.guid];
  }

  self.hasspawned = 0;
  self.var_A6F0 = 0;
  self.var_A7F5 = 0;
  self.wasaliveatmatchstart = 0;
  self.var_5A73 = 1;
  self.var_696D = 1;
  self.var_57D6 = 0;
  func_8A40();
  if(!isDefined(level.iszombiegame) && level.iszombiegame) {
    level thread func_63C4(self);
  }

  thread maps\mp\_flashgrenades::func_6394();
  func_7D71();
  lib_0378::func_8D8A();
  waittillframeend;
  level.players[level.players.size] = self;
  level.var_596C = common_scripts\utility::func_F93(level.var_596C, self);
  lib_050D::func_9FA();
  addtocharactersarray(self);
  if(level.teambased) {
    self method_82A3();
  }

  if(isDefined(level.var_75DF)) {
    self[[level.var_75DF]]();
  }

  if(game["state"] == "postgame") {
    self.var_2583 = 1;
    func_9073();
    return;
  }

  if(var_01 && maps\mp\_utility::gettimepassed() >= -5536 || game["roundsPlayed"] > 0) {
    self.var_5969 = 1;
    if(maps\mp\_utility::func_579B() && !game["switchedsides"]) {
      self.pers["jip_game_one"] = 1;
    }
  } else if(isDefined(self.pers["jip_game_one"]) && self.pers["jip_game_one"]) {
    self.var_5969 = 1;
  }

  if(isai(self) && isDefined(level.var_19D5) && isDefined(level.var_19D5["think"])) {
    self thread[[level.var_19D5["think"]]]();
  }

  level endon("game_ended");
  if(isDefined(level.var_4E09)) {
    if(!isDefined(self.var_4E05) || self.var_4E05 == 0) {
      self.var_4E05 = 0;
      thread maps\mp\gametypes\_hostmigration::func_4E0A();
    }
  }

  if(isDefined(level.onplayerconnectaudioinit)) {
    [[level.onplayerconnectaudioinit]]();
  }

  if(maps\mp\_utility::func_56B9()) {
    thread func_90A5();
    self[[level.var_1385]]();
    return;
  }

  if(!isDefined(self.pers["team"])) {
    if(function_038B()) {
      if(self.sessionteam == "none") {
        thread func_90A5();
        self[[level.var_1385]]();
        if(maps\mp\_utility::func_C1E()) {
          thread func_8753(2);
        }
      } else if(self.sessionteam == "spectator") {
        maps\mp\gametypes\_menus::func_6116();
        thread func_8753(0);
      } else {
        thread func_90A5();
        thread maps\mp\gametypes\_menus::func_873A(self.sessionteam);
        if(maps\mp\_utility::func_C1E()) {
          thread func_8753(2);
        }
      }

      thread func_59EB();
      return;
    }

    if((maps\mp\_utility::func_602B() || function_037E()) && self.sessionteam != "none") {
      thread watch_kick_if_no_damage();
      thread func_90A5();
      if(isDefined(level.var_A6EB) && level.var_A6EB) {
        maps\mp\_utility::func_3E8E(1);
      }

      if(level.gametype == "infect") {
        self[[level.var_1385]]();
      } else {
        thread maps\mp\gametypes\_menus::func_873A(self.sessionteam);
      }

      if(maps\mp\_utility::func_C1E()) {
        thread func_8753(2);
      }

      thread watchforhostmigrationonconnect();
      thread func_59EB();
      return;
    }

    if(!maps\mp\_utility::func_602B() && maps\mp\_utility::func_C2D()) {
      maps\mp\gametypes\_menus::func_6116();
      thread func_8753(1);
      return;
    }

    thread func_90A5();
    self[[level.var_1385]]();
    if(maps\mp\_utility::func_C1E()) {
      thread func_8753(2);
    }

    if(maps\mp\_utility::func_602B()) {
      thread watch_kick_if_no_damage();
      thread watchforhostmigrationonconnect();
      thread func_59EB();
    }

    return;
  }

  maps\mp\gametypes\_menus::func_9FC(self.pers["team"], 1);
  if(maps\mp\_utility::isvalidclass(self.pers["class"]) && !maps\mp\_utility::isprophuntgametype()) {
    thread func_9035();
    return;
  }

  thread func_90A5();
  if(level.gametype == "sd" && (maps\mp\_utility::func_602B() || function_037E()) && self.sessionteam != "none") {
    thread func_59EB();
  }

  if(maps\mp\_utility::func_579B() && (maps\mp\_utility::func_602B() || function_037E()) && self.sessionteam != "none" && common_scripts\utility::func_562E(self.pers["secondHalfInitialConnect"])) {
    thread func_59EB();
    self.pers["secondHalfInitialConnect"] = 0;
  }

  if(self.pers["team"] == "spectator") {
    if(self.sessionteam == "spectator") {
      self.var_90E3 = 1;
      return;
    }

    if(!function_038B()) {
      if(maps\mp\_utility::func_C2D()) {
        maps\mp\gametypes\_menus::func_171C();
        return;
      }

      self[[level.var_1385]]();
      return;
    }

    return;
  }

  maps\mp\gametypes\_menus::func_170E();
}

func_1E6F() {
  if(isDefined(self.var_2582) && self.var_2582) {
    if(!maps\mp\_utility::func_579B()) {
      maps\mp\_utility::func_A143();
    }

    maps\mp\_utility::func_A132();
    if(level.teambased) {
      self method_82A3();
    }
  }

  if(self ishost()) {
    func_52A3();
    setmatchdata("players", self.clientid, "was_host", 1);
  }

  var_00 = 0;
  foreach(var_02 in level.players) {
    if(!isbot(var_02) && !function_026D(var_02)) {
      var_00++;
    }
  }

  if(!isbot(self) && !function_026D(self)) {
    level.var_4E08++;
    if(level.var_4E08 >= var_00 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
    }

    self notify("player_migrated");
  }
}

func_3E2A() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  wait(60);
  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  if(!maps\mp\_utility::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";
    self.var_2319 = self.pers["class"];
    maps\mp\gametypes\_class::func_23DC();
  }

  thread func_9035();
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

    maps\mp\gametypes\_menus::func_170E();
  }
}

func_59EB() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  self endon("attempted_spawn");
  if(!common_scripts\utility::func_562E(level.var_AC5A) && !maps\mp\_utility::func_551F() || !function_03AE()) {
    var_00 = getdvarfloat("scr_kick_time", 90);
    var_01 = getdvarfloat("scr_kick_mintime", 45);
    var_02 = gettime();
    if(self ishost()) {
      func_59F0(120);
    } else {
      func_59F0(var_00);
    }

    var_03 = gettime() - var_02 / 1000;
    if(var_03 < var_00 - 0.1 && var_03 < var_01) {
      return;
    }

    if(self.hasspawned) {
      return;
    }

    if(self.pers["team"] == "spectator") {
      return;
    }

    if(getdvarint("2803", 0) == 0) {
      kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    }

    level thread maps\mp\gametypes\_gamelogic::updategameevents();
  }
}

watch_kick_if_no_damage() {
  level endon("game_ended");
  self endon("disconnect");
  if(function_0367()) {
    return;
  }

  if(getdvarint("spv_kick_if_no_damage", 0) == 0) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(!common_scripts\utility::func_562E(level.var_AC5A) && !maps\mp\_utility::func_551F() || !function_03AE()) {
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
  if(function_0367()) {
    return;
  }

  if(getdvarint("spv_kick_if_no_damage", 0) == 0) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  var_00 = getdvarint("spv_no_damage_kick_time", 300);
  if(self ishost()) {
    var_00 = var_00 + 30;
  }

  maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
  if(isDefined(self)) {
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
  }
}

kick_after_delay(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  if(getdvarint("spv_kick_if_no_damage_rounds", 0) == 0) {
    return;
  }

  if(function_0367()) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(self ishost()) {
    param_00 = param_00 + 5;
  }

  maps\mp\gametypes\_hostmigration::func_A6F5(param_00);
  kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
}

func_59F0(param_00) {
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::func_A6F5(param_00);
}

func_5336() {
  maps\mp\gametypes\_persistence::func_529D();
  self.pers["lives"] = maps\mp\_utility::func_44FC();
  if(!isDefined(self.pers["deaths"])) {
    maps\mp\_utility::func_532D("deaths");
    maps\mp\gametypes\_persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = maps\mp\_utility::getpersstat("deaths");
  if(!isDefined(self.pers["score"])) {
    maps\mp\_utility::func_532D("score");
    maps\mp\gametypes\_persistence::statsetchild("round", "score", 0);
    maps\mp\gametypes\_persistence::func_933B("round", "timePlayed", 0);
  }

  self.score = maps\mp\_utility::getpersstat("score");
  self.timeplayed["total"] = maps\mp\gametypes\_persistence::func_9332("round", "timePlayed");
  if(!isDefined(self.pers["suicides"])) {
    maps\mp\_utility::func_532D("suicides");
  }

  self.suicides = maps\mp\_utility::getpersstat("suicides");
  if(!isDefined(self.pers["kills"])) {
    maps\mp\_utility::func_532D("kills");
    maps\mp\gametypes\_persistence::statsetchild("round", "kills", 0);
  }

  self.kills = maps\mp\_utility::getpersstat("kills");
  if(!isDefined(self.pers["headshots"])) {
    maps\mp\_utility::func_532D("headshots");
    maps\mp\gametypes\_persistence::statsetchild("round", "headshots", 0);
  }

  self.var_4BF9 = maps\mp\_utility::getpersstat("headshots");
  if(!isDefined(self.pers["assists"])) {
    maps\mp\_utility::func_532D("assists");
    maps\mp\gametypes\_persistence::statsetchild("round", "assists", 0);
  }

  self.assists = maps\mp\_utility::getpersstat("assists");
  if(!isDefined(self.pers["captures"])) {
    maps\mp\_utility::func_532D("captures");
    maps\mp\gametypes\_persistence::statsetchild("round", "captures", 0);
  }

  if(!isDefined(self.pers["returns"])) {
    maps\mp\_utility::func_532D("returns");
    maps\mp\gametypes\_persistence::statsetchild("round", "returns", 0);
  }

  self.var_7E31 = maps\mp\_utility::getpersstat("returns");
  if(!isDefined(self.pers["defends"])) {
    maps\mp\_utility::func_532D("defends");
    maps\mp\gametypes\_persistence::statsetchild("round", "defends", 0);
  }

  if(!isDefined(self.pers["plants"])) {
    maps\mp\_utility::func_532D("plants");
    maps\mp\gametypes\_persistence::statsetchild("round", "plants", 0);
  }

  if(!isDefined(self.pers["defuses"])) {
    maps\mp\_utility::func_532D("defuses");
    maps\mp\gametypes\_persistence::statsetchild("round", "defuses", 0);
  }

  if(!isDefined(self.pers["destructions"])) {
    maps\mp\_utility::func_532D("destructions");
    maps\mp\gametypes\_persistence::statsetchild("round", "destructions", 0);
  }

  if(!isDefined(self.pers["confirmed"])) {
    maps\mp\_utility::func_532D("confirmed");
    maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", 0);
  }

  if(!isDefined(self.pers["denied"])) {
    maps\mp\_utility::func_532D("denied");
    maps\mp\gametypes\_persistence::statsetchild("round", "denied", 0);
  }

  if(!isDefined(self.pers["rescues"])) {
    maps\mp\_utility::func_532D("rescues");
    maps\mp\gametypes\_persistence::statsetchild("round", "rescues", 0);
  }

  if(!isDefined(self.pers["teamkills"])) {
    maps\mp\_utility::func_532D("teamkills");
  }

  if(!isDefined(self.pers["totalTeamKills"])) {
    maps\mp\_utility::func_532D("totalTeamKills");
  }

  if(!isDefined(self.pers["extrascore0"])) {
    maps\mp\_utility::func_532D("extrascore0");
  }

  if(!isDefined(self.pers["extrascore1"])) {
    maps\mp\_utility::func_532D("extrascore1");
  }

  if(!isDefined(self.pers["throwingKnifeKills"])) {
    maps\mp\_utility::func_532D("throwingKnifeKills");
  }

  if(!isDefined(self.pers["meleeKnifeKills"])) {
    maps\mp\_utility::func_532D("meleeKnifeKills");
  }

  if(!isDefined(self.pers["scorestreaksCalled"])) {
    maps\mp\_utility::func_532D("scorestreaksCalled");
  }

  if(!isDefined(self.pers["scorestreaksDowned"])) {
    maps\mp\_utility::func_532D("scorestreaksDowned");
  }

  if(!isDefined(self.pers["time"])) {
    maps\mp\_utility::func_532D("time");
  }

  if(!isDefined(self.pers["teamKillPunish"])) {
    self.pers["teamKillPunish"] = 0;
  }

  if(!isDefined(self.pers["suicideSpawnDelay"])) {
    self.pers["suicideSpawnDelay"] = 0;
  }

  maps\mp\_utility::func_532D("longestStreak");
  self.pers["lives"] = maps\mp\_utility::func_44FC();
  if(!function_0367()) {
    maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", 0);
    maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
    maps\mp\gametypes\_persistence::statsetchild("round", "win", 0);
    maps\mp\gametypes\_persistence::statsetchild("round", "scoreboardType", "none");
  }

  if(maps\mp\_utility::rankingenabled()) {
    if(!isDefined(self.pers["previous_shots"])) {
      self.pers["previous_shots"] = self getrankedplayerdata(common_scripts\utility::func_46AE(), "totalShots");
    }

    if(!isDefined(self.pers["previous_hits"])) {
      self.pers["previous_hits"] = self getrankedplayerdata(common_scripts\utility::func_46AE(), "hits");
    }
  }

  if(!isDefined(self.pers["mpWeaponStats"])) {
    self.pers["mpWeaponStats"] = [];
  }

  if(!isDefined(self.pers["mpMatchdataWeaponStats"])) {
    self.pers["mpMatchdataWeaponStats"] = [];
  }

  if(!isDefined(self.pers["numberOfTimesCloakingUsed"])) {
    self.pers["numberOfTimesCloakingUsed"] = 0;
  }

  if(!isDefined(self.pers["numberOfTimesHoveringUsed"])) {
    self.pers["numberOfTimesHoveringUsed"] = 0;
  }

  if(!isDefined(self.pers["numberOfTimesShieldUsed"])) {
    self.pers["numberOfTimesShieldUsed"] = 0;
  }

  if(!isDefined(self.pers["bulletsBlockedByShield"])) {
    self.pers["bulletsBlockedByShield"] = 0;
  }

  if(!isDefined(self.pers["totalKillcamsSkipped"])) {
    self.pers["totalKillcamsSkipped"] = 0;
  }

  if(!isDefined(self.pers["totalKillcamsInterrupted"])) {
    self.pers["totalKillcamsInterrupted"] = 0;
  }

  if(!isDefined(self.pers["weaponPickupsCount"])) {
    self.pers["weaponPickupsCount"] = 0;
  }

  if(!isDefined(self.pers["pingAccumulation"])) {
    self.pers["pingAccumulation"] = 0;
  }

  if(!isDefined(self.pers["pingSampleCount"])) {
    self.pers["pingSampleCount"] = 0;
  }

  if(!isDefined(self.pers["minPing"])) {
    self.pers["minPing"] = 32767;
  }

  if(!isDefined(self.pers["maxPing"])) {
    self.pers["maxPing"] = 0;
  }

  if(!isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] = 0;
  }
}

func_09FD() {
  level.teamcount[self.team]++;
  if(!isDefined(level.var_9859)) {
    level.var_9859 = [];
  }

  if(!isDefined(level.var_9859[self.team])) {
    level.var_9859[self.team] = [];
  }

  level.var_9859[self.team][level.var_9859[self.team].size] = self;
  maps\mp\gametypes\_gamelogic::updategameevents();
}

func_7CE1() {
  level.teamcount[self.team]--;
  if(isDefined(level.var_9859) && isDefined(level.var_9859[self.team])) {
    var_00 = [];
    foreach(var_02 in level.var_9859[self.team]) {
      if(!isDefined(var_02) || var_02 == self) {
        continue;
      }

      var_00[var_00.size] = var_02;
    }

    level.var_9859[self.team] = var_00;
  }
}

func_09F7() {
  var_00 = self.team;
  if(!isDefined(self.var_CA4) && self.var_CA4) {
    level.hasspawned[var_00]++;
    func_50F8(var_00, "playerlogic addToAliveCount");
  }

  self.var_CA4 = undefined;
  if(level.var_BC3["allies"] + level.var_BC3["axis"] > level.maxplayercount) {
    level.maxplayercount = level.var_BC3["allies"] + level.var_BC3["axis"];
  }
}

func_50F8(param_00, param_01) {
  level.var_BC3[param_00]++;
  if(param_00 == "allies") {
    setomnvar("ui_alive_player_count_allies", level.var_BC3[param_00]);
    return;
  }

  setomnvar("ui_alive_player_count_axis", level.var_BC3[param_00]);
}

func_7CDD(param_00) {
  var_01 = self.team;
  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team) {
    var_01 = self.leaving_team;
  }

  if(isDefined(param_00)) {
    func_7CCE();
  }

  func_2B77(var_01);
  return maps\mp\gametypes\_gamelogic::updategameevents();
}

func_2B77(param_00) {
  level.var_BC3[param_00]--;
  if(param_00 == "allies") {
    setomnvar("ui_alive_player_count_allies", level.var_BC3[param_00]);
    return;
  }

  setomnvar("ui_alive_player_count_axis", level.var_BC3[param_00]);
}

func_09F9() {
  level.var_5DDB[self.team] = level.var_5DDB[self.team] + self.pers["lives"];
}

func_7CDE() {
  level.var_5DDB[self.team]--;
  level.var_5DDB[self.team] = int(max(0, level.var_5DDB[self.team]));
}

func_7CCE() {
  level.var_5DDB[self.team] = level.var_5DDB[self.team] - self.pers["lives"];
  level.var_5DDB[self.team] = int(max(0, level.var_5DDB[self.team]));
}

func_7D73() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_capture_icon", 0);
  self setclientomnvar("ui_capture_status_index", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_show_overview_map_icons", 1);
  self setclientomnvar("ui_light_armor_percent", 0);
  self setclientomnvar("serum_active_percent", 0);
  self setclientomnvar("ui_killcam_time_until_spawn", 0);
  if(!maps\mp\_utility::func_585F()) {
    self setclientomnvar("ui_uplink_can_pass", 0);
  }
}

func_7D71() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_capture_icon", 0);
  self setclientomnvar("ui_capture_status_index", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_show_overview_map_icons", 1);
  if(!maps\mp\_utility::func_585F() && !maps\mp\gametypes\_hud_util::func_5527()) {
    self setclientomnvar("serum_active_streakIndex", -1);
  }
}

func_7D74() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_capture_icon", 0);
  self setclientomnvar("ui_capture_status_index", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_show_overview_map_icons", 1);
}

resetuidvarsondeath() {}

func_63C4(param_00) {
  param_00 endon("disconnect");
  level endon("game_ended");
  func_281F(param_00);
  for(;;) {
    param_00 waittill("spawned_player");
    func_7B3C(param_00);
  }
}

func_281F(param_00) {
  if(!isDefined(param_00.pers["segments"])) {
    param_00.pers["segments"] = [];
  }

  param_00.var_838A = param_00.pers["segments"];
  if(!param_00.var_838A.size) {
    param_00.var_838A["distanceTotal"] = 0;
    param_00.var_838A["movingTotal"] = 0;
    param_00.var_838A["movementUpdateCount"] = 0;
    param_00.var_838A["killDistanceTotal"] = 0;
    param_00.var_838A["killDistanceCount"] = 0;
  }
}

func_7B3C(param_00) {
  param_00 endon("death");
  while(!maps\mp\_utility::func_3FA0("prematch_done")) {
    wait(0.5);
  }

  wait(4);
  param_00.var_8067 = param_00.origin;
  param_00.var_7592 = param_00.origin;
  for(;;) {
    wait(1);
    if(param_00 maps\mp\_utility::func_581D()) {
      param_00 waittill("stopped_using_remote");
      param_00.var_8067 = param_00.origin;
      param_00.var_7592 = param_00.origin;
      continue;
    }

    param_00.var_838A["movementUpdateCount"]++;
    param_00.var_838A["distanceTotal"] = param_00.var_838A["distanceTotal"] + distance2d(param_00.var_8067, param_00.origin);
    param_00.var_8067 = param_00.origin;
    if(param_00.var_838A["movementUpdateCount"] % 5 == 0) {
      var_01 = distance2d(param_00.var_7592, param_00.origin);
      param_00.var_7592 = param_00.origin;
      if(var_01 > 16) {
        param_00.var_838A["movingTotal"]++;
      }
    }
  }
}

func_AABB(param_00) {
  setdvarifuninitialized("spv_enablePlaystyleStats", 0);
  if(function_0367()) {
    return;
  }

  if(level.players.size < 2) {
    return;
  }

  param_00 endon("disconnect");
  if(param_00.var_838A["movementUpdateCount"] < 30) {
    return;
  }

  var_01 = param_00.var_838A["movingTotal"] / int(param_00.var_838A["movementUpdateCount"] / 5) * 100;
  var_02 = param_00.var_838A["distanceTotal"] / param_00.var_838A["movementUpdateCount"];
  var_03 = 0;
  if(param_00.var_838A["killDistanceCount"] > 0) {
    var_03 = param_00.var_838A["killDistanceTotal"] / param_00.var_838A["killDistanceCount"];
  }

  var_01 = min(var_01, float(tablelookup("mp/playerSegments.csv", 0, "MAX", 3)));
  var_02 = min(var_02, float(tablelookup("mp/playerSegments.csv", 0, "MAX", 2)));
  var_03 = min(var_03, float(tablelookup("mp/playerSegments.csv", 0, "MAX", 4)));
  var_04 = func_1E50(var_01, var_02, var_03);
  setmatchdata("players", param_00.var_2418, "average_speed", var_02);
  setmatchdata("players", param_00.var_2418, "pct_time_moving", var_01);
  setmatchdata("players", param_00.var_2418, "average_kill_distance", var_03);
  setmatchdata("players", param_00.var_2418, "total_distance_travelled", param_00.var_838A["distanceTotal"]);
  setmatchdata("players", param_00.var_2418, "playstyle", maps\mp\_utility::func_2314(var_04));
  setmatchdata("players", param_00.var_2418, "movement_update_count", param_00.var_838A["movementUpdateCount"]);
  if(isai(param_00)) {
    return;
  }

  if(getdvarint("spv_enablePlaystyleStats", 0) == 1) {
    function_00F5("script_PlayerSegments: percentTimeMoving %f, averageSpeed %f, averageKillDistance %f, playStyle %d, name %s", var_01, var_02, var_03, var_04, param_00.name);
    if(!param_00 maps\mp\_utility::rankingenabled()) {
      return;
    }

    var_05 = 50;
    var_06 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "numPlayStyleTrends");
    var_06++;
    if(var_06 > var_05) {
      var_06 = var_05;
      if(var_05 > 1) {
        for(var_07 = 0; var_07 < var_05 - 1; var_07++) {
          var_08 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "playStyleTimeStamp", var_07 + 1);
          var_09 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "playStyle", var_07 + 1);
          param_00 setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "playStyleTimeStamp", var_07, var_08);
          param_00 setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "playStyle", var_07, var_09);
        }
      }
    }

    var_08 = maps\mp\_utility::func_46E7();
    param_00 setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "playStyleTimeStamp", var_06 - 1, var_08);
    param_00 setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "playStyle", var_06 - 1, var_04);
    param_00 setrankedplayerdata(common_scripts\utility::func_46AE(), "combatRecord", "numPlayStyleTrends", var_06);
  }
}

func_1E50(param_00, param_01, param_02) {
  param_00 = func_6746(param_00, float(tablelookup("mp/playerSegments.csv", 0, "Mean", 3)), float(tablelookup("mp/playerSegments.csv", 0, "SD", 3)));
  param_01 = func_6746(param_01, float(tablelookup("mp/playerSegments.csv", 0, "Mean", 2)), float(tablelookup("mp/playerSegments.csv", 0, "SD", 2)));
  param_02 = func_6746(param_02, float(tablelookup("mp/playerSegments.csv", 0, "Mean", 4)), float(tablelookup("mp/playerSegments.csv", 0, "SD", 4)));
  var_03 = (param_00, param_01, param_02);
  var_04 = ["Camper", "Mobile", "Run", "Sniper", "TacCQ"];
  var_05 = "Camper";
  var_06 = 1000;
  foreach(var_08 in var_04) {
    var_09 = func_444C(var_03, var_08);
    if(var_09 < var_06) {
      var_05 = var_08;
      var_06 = var_09;
    }
  }

  return int(tablelookup("mp/playerSegments.csv", 0, var_05, 1));
}

func_6746(param_00, param_01, param_02) {
  return param_00 - param_01 / param_02;
}

func_444C(param_00, param_01) {
  var_02 = (float(tablelookup("mp/playerSegments.csv", 0, param_01, 3)), float(tablelookup("mp/playerSegments.csv", 0, param_01, 2)), float(tablelookup("mp/playerSegments.csv", 0, param_01, 4)));
  return distance(param_00, var_02);
}

func_2409(param_00, param_01) {
  param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "practiceRoundLockoutTime", 0);
  for(var_02 = 0; var_02 < param_01; var_02++) {
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "practiceRoundLockoutMatchTimes", var_02, 0);
  }
}

func_21DF(param_00) {
  if(isbot(param_00) || function_01EF(param_00)) {
    return;
  }

  var_01 = 10;
  var_02 = 3;
  var_03 = 5;
  var_04 = int(86400);
  var_05 = int(86400);
  var_06 = param_00 getrankedplayerdata(common_scripts\utility::getstatgamemode(), "practiceRoundLockoutTime");
  if(var_06 > 0) {
    func_2409(param_00, var_01);
  }

  var_07 = param_00 getrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "kills");
  var_08 = param_00 getrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "deaths");
  var_08 = max(var_08, 1);
  var_09 = var_07 / var_08;
  if(var_09 < var_03) {
    func_2409(param_00, var_01);
    return;
  }

  var_0A = maps\mp\_utility::func_46E7();
  var_0B = var_0A - var_04;
  var_0C = -1;
  var_0D = var_0A;
  var_0E = 1;
  for(var_0F = 0; var_0F < var_01; var_0F++) {
    var_10 = param_00 getrankedplayerdata(common_scripts\utility::getstatgamemode(), "practiceRoundLockoutMatchTimes", var_0F);
    if(var_10 < var_0D) {
      var_0D = var_10;
      var_0C = var_0F;
    }

    if(var_10 >= var_0B) {
      var_0E++;
    }
  }

  param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "practiceRoundLockoutMatchTimes", var_0C, var_0A);
  if(var_0E >= var_02) {
    var_11 = var_0A + var_05;
    param_00 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "practiceRoundLockoutTime", var_11);
  }
}

func_75F2() {
  if(!isDefined(level.var_A4B5)) {
    level.var_A4B5["intensity"] = 0;
    level.var_A4B5["falloff"] = 1.2;
    level.var_A4B5["scaleX"] = 1;
    level.var_A4B5["scaleY"] = 1;
    level.var_A4B5["squareAspectRatio"] = 0;
  }

  self vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
  if(isDefined(level.var_6465)) {
    self setscriptmotionblurparams(level.var_6465["velocityscaler"], level.var_6465["cameraRotationInfluence"], level.var_6465["cameraTranslationInfluence"]);
  }
}

deleteentonplayerdisconnect(param_00) {
  if(!isDefined(self.playerondisconnectcleanup)) {
    self.playerondisconnectcleanup = [];
  }

  self.playerondisconnectcleanup[self.playerondisconnectcleanup.size] = param_00;
  thread watchentdeleteforplayerdisconnect(param_00);
}

watchentdeleteforplayerdisconnect(param_00) {
  self endon("disconnect");
  param_00 common_scripts\utility::waittill_any("death", "entitydeleted");
  self.playerondisconnectcleanup = common_scripts\utility::func_F93(self.playerondisconnectcleanup, param_00);
}

cleanupentsonplayerdisconnect() {
  if(isDefined(self.playerondisconnectcleanup)) {
    foreach(var_01 in self.playerondisconnectcleanup) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}