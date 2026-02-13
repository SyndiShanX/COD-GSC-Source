/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\krampus\think.gsc
*************************************************/

main() {
  level waittill("connected", var_0);
  var_0 waittill("spawned");

  if(!isvalidkrampusgamemode(level.gametype)) {
    return;
  }
  thread calculatetargetscores();
  var_1 = getdvarint("#x3d0aeda97e76eff26", 20);
  wait(var_1);
  var_2 = getdvarint("#x3e106d3133dd79d9", 15);
  var_3 = randomint(var_2);
  wait(var_3);
  var_4 = _id_0015::_id_3B84("actor_s4_mp_krampus", undefined);
  var_4 thread[[var_4 _id_09EF::_id_1215("spawn")]](var_0.origin, var_0.angles, undefined, "actor_s4_mp_krampus");
}

init() {
  self._id_189F = spawnStruct();
  self._id_189F._id_AAC4 = [];
  self._id_189F._id_AAC4["idle"] = _id_0AFD::main;
  self._id_189F._id_AAC4["move"] = _id_0AFF::main;
  self._id_189F._id_AAC4["traverse"] = _id_0B01::main;
  self._id_189F._id_AAC4["melee"] = _id_0AFE::main;
  self._id_189F._id_AADC = [];
  self._id_189F._id_AADC["idle"] = _id_0AFD::_id_0191;
  self._id_189F._id_AADC["move"] = _id_0AFF::_id_0191;
  self._id_189F._id_AADC["melee"] = _id_0AFE::_id_0191;
  self._id_189F._id_AADC["traverse"] = _id_0B01::_id_0191;
  self._id_13E7 = "idle";
  self._id_0359 = 15;
  self.height = 40;
  self.perks = [];
  self._id_AFF8 = [];
  scripts\mp\utility\perk::_id_6FC2("specialty_melee_resist_damage");
  scripts\mp\utility\perk::_id_6FC2("specialty_melee_resist_finisher");
  self.lastenemykilled = undefined;
  self.lastenemytargeted = undefined;
  self._id_0281 = 1;
  self._id_01BD = undefined;
  self.bdebugmode = 0;
  self._id_31FB = undefined;
  self.krampuswaketimestamp = 0;
  self.krampussleeptimestamp = 0;
  self._id_0201 = 36;
  self.waitingforteleport = 0;
  self._id_A546 = 1;
  self.shouldroar = 0;
  self _meth_84C0(1);
  self _meth_85E2(0);
  self.breath_sfx = undefined;
  self._id_4A7F = 1;
  self.proximitytarget = undefined;
  self.lastproximitytarget = undefined;
  self.shoulddoproximitycheck = 0;
  self.lastdamageaggrotimestamp = 0;
  self.originaltarget = undefined;
  self.damageaggrocount = undefined;
  self.krampussleeptime = getdvarint("#x35008415b1103fb4a", 15000);
  self _meth_852F(0);
  self _meth_86C6();
  krampusgotosleep(0);
  thread _id_10B12();
  thread listenforunreachablegoalandbadpath();
  thread listenfortargetonladder();
  thread updateproximitytarget();
  _id_06BD::_id_2402("casual");
}

getkrampusspawnchance() {
  return getdvarint("#x3f1a7991496cefc81", 100);
}

dropkrampuspresent() {
  var_0 = undefined;
  var_1 = undefined;
  krampusplayteleportvfx(1);
  var_2 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(undefined, var_0);
  var_3 = "killstreak_no_owner";
  var_4 = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(var_2, 0);
  var_5 = scripts\cp_mp\killstreaks\airdrop::_id_B159(var_0, var_1, var_3, self.origin, self.angles + (0, 180, 0), var_4);

  if(!isDefined(var_5)) {
    return undefined;
  }

  var_6 = scripts\cp_mp\killstreaks\airdrop::_id_6B00(var_3);
  var_6._id_3238 = 0;
  return var_5;
}

isvalidkrampusgamemode(var_0) {
  if(var_0 == "sd" || var_0 == "control") {
    return 0;
  }

  return 1;
}

_id_10AE6() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  level endon("game_ended");
  self._id_01BD scripts\engine\utility::_id_108A7(1000, "death_or_disconnect");
  self._id_01BD = undefined;
  thread updatetarget();
}

_id_D55D(var_0) {
  self._id_01BD = var_0;
  self.lastenemytargeted = var_0;
  thread _id_10AE6();
}

_id_10B12() {
  self endon("death");
  level waittill("game_ended");

  for(;;) {
    var_0 = self _meth_86C8();

    if(!var_0 && istrue(self.krampusisawake)) {
      var_1 = gettime();
      krampusgotosleep(var_1);
      krampushide();
      return;
    }

    wait 0.5;
  }
}

listenforunreachablegoalandbadpath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::_id_108B4("unreachable_goal", "bad_path");
    setcantreachtargettime();
  }
}

listenfortargetonladder() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(self.krampusisawake && isDefined(self._id_01BD)) {
      if(self._id_01BD isonladder()) {
        setcantreachtargettime();
      }
    }

    wait 1;
  }
}

setcantreachtargettime() {
  if(!isDefined(self._id_31FB)) {
    self._id_31FB = gettime();
    self notify("find_new_target");
  }
}

onkrampuskill(var_0) {
  self.lastenemykilled = var_0;
  self.lastenemytargeted = var_0;
  self.shoulddoproximitycheck = 0;
  level._id_EE9A[var_0._id_399D]["targetScore"] = 0;
  var_0.krampustargetrespawndelay = 1.3;

  if(shouldreturntooriginaltarget()) {
    return;
  }
  wait 3;
  var_1 = gettime();
  krampusgotosleep(var_1);
  krampushide();
}

setkrampusroar() {
  if(isDefined(self.breath_sfx)) {
    _id_0847::_id_DF21(self.breath_sfx);
  }

  self _meth_8326(self.origin);
  self.shouldroar = 1;
  scripts\engine\utility::_id_108A7(5, "krampus_roar_end");

  if(!isDefined(self.breath_sfx)) {
    self.breath_sfx = _id_0847::_id_DF08("mp_krampus_exert_breath_lp", self);
  }
}

krampusroarsoundloop() {
  self notify("krampusRoarSoundLoop");
  self endon("krampusWakeUp");
  self endon("krampusGoToSleep");
  self endon("krampusRoarSoundLoop");
  self endon("Krampus_SetupExecute");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3;

    if(isDefined(self.breath_sfx)) {
      _id_0847::_id_DF21(self.breath_sfx);
    }

    if(istargetreachable()) {
      self _meth_827E("mp_krampus_exert_roar");
    }

    wait 3;

    if(!isDefined(self.breath_sfx)) {
      self.breath_sfx = _id_0847::_id_DF08("mp_krampus_exert_breath_lp", self);
    }
  }
}

_id_F108() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    updatekrampuswake();

    if(self.krampusisawake) {
      updatetarget();
      _id_FCCA();
    }

    wait 0.1;
  }
}

updatekrampuswake() {
  var_0 = gettime();

  if(self.krampusisawake) {
    if(var_0 - self.krampuswaketimestamp > 2000000) {
      setkrampusroar();
      krampusgotosleep(var_0);
      krampushide();
    }
  } else if(var_0 - self.krampussleeptimestamp > self.krampussleeptime) {
    if(!isvalidtarget(self._id_01BD)) {
      self._id_01BD = undefined;
      updatetarget();
    }

    if(setkrampuswakelocation() && istargetreachable()) {
      krampuswakeup(var_0);
    } else {
      self.krampussleeptimestamp = var_0;
    }
  }
}

krampushide() {
  wait 0.1;
  self hide();
}

krampusgotosleep(var_0) {
  self notify("krampusGoToSleep");

  if(var_0 != 0) {
    krampusplayteleportvfx(1);
  }

  self.krampusisawake = 0;
  self.krampussleeptimestamp = var_0;
  self _meth_852B(0);
  self hide();
  self.candamage = 0;
  self.ballowexecutions = 0;
  self.ignoreme = 1;
  self _meth_85E2(0);
  self.krampusdisablemovebehavior = 1;
  self _meth_8326(self.origin);
  self.shoulddoproximitycheck = 0;
  _id_0847::_id_DF21(self.breath_sfx);
}

krampuswakeup(var_0) {
  self notify("krampusWakeUp");
  krampusplayteleportvfx();
  self.krampusisawake = 1;
  self.krampuswaketimestamp = var_0;
  self show();
  self _meth_852B(1);
  self.candamage = 1;
  self.ballowexecutions = 1;
  self.ignoreme = 0;
  self.shoulddoproximitycheck = 1;
  self.originaltarget = undefined;
  self.damageaggrocount = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 scripts\mp\hud_message::showsplash("codmas_krampus_spawned");
    }
  }

  if(!isDefined(self.breath_sfx)) {
    self.breath_sfx = _id_0847::_id_DF08("mp_krampus_exert_breath_lp", self);
  }

  setkrampusroar();
  self.krampusdisablemovebehavior = 0;
  thread krampusroarsoundloop();
}

setkrampuswakelocation() {
  updatetarget();
  var_0 = self._id_01BD _id_09EF::_id_6DF2(1, 0, 30);

  if(!isDefined(var_0)) {
    var_0 = self._id_01BD _id_09EF::_id_6DF2(1, 0, _func_0037(15.0));
  }

  if(!isDefined(var_0)) {
    var_0 = self._id_01BD _id_09EF::_id_6DF2(1, 0, 1);
  }

  if(isDefined(var_0)) {
    var_1 = getfarthestnode(var_0);
    self.origin = var_1.origin;
    self setorigin(var_1.origin);
    self.angles = vectortoangles(self._id_01BD.origin - self.origin);
    return 1;
  }

  return 0;
}

getfarthestnode(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = distancesquared(self._id_01BD.origin, var_4.origin);

    if(!isDefined(var_1)) {
      var_1 = var_4;
      var_2 = var_5;
      continue;
    }

    if(var_5 > var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

calculatetargetscores() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level._id_EE9A)) {
      level._id_EE9A = [];
    }

    if(level.gametype == "dom" || level.gametype == "koth" || level.gametype == "patrol" || level.gametype == "conf") {
      getobjectivebasedkrampustargetarray();
    } else {
      getcampingbasedkrampustargetarray();
    }

    wait 1;
  }
}

updatetarget() {
  self notify("updateTarget");
  self endon("updateTarget");
  self endon("death");
  level endon("game_ended");

  if(isDefined(self._id_01BD)) {
    return;
  }
  if(shouldreturntooriginaltarget()) {
    self.lastenemytargeted = self.originaltarget;
    _id_D55D(self.originaltarget);
    self.originaltarget = undefined;
    self.damageaggrocount = 0;
    return;
  }

  var_0 = undefined;

  if(0) {
    var_0 = getclosestplayer();
  } else {
    var_0 = _id_691C();
  }

  self.lastenemytargeted = var_0;
  _id_D55D(var_0);
}

_id_8963(var_0) {
  return isDefined(var_0._id_F392) && var_0._id_F392.size > 0;
}

isvalidtarget(var_0) {
  if(!isDefined(var_0) || !isalive(var_0) || istrue(var_0._id_88DF) || _id_8963(var_0)) {
    return 0;
  }

  return 1;
}

_id_691C() {
  var_0 = findbesttarget();

  while(!isvalidtarget(var_0)) {
    var_1 = randomint(level.players.size);
    var_0 = level.players[var_1];
    wait 0.5;
  }

  return var_0;
}

findbesttarget() {
  var_0 = undefined;

  if(!isDefined(level._id_EE9A)) {
    return var_0;
  }

  foreach(var_2 in level.players) {
    if(isDefined(self.lastenemykilled) && var_2 == self.lastenemykilled) {
      continue;
    }
    if(isDefined(self.lastenemytargeted) && var_2 == self.lastenemytargeted) {
      continue;
    }
    if(!isvalidtarget()) {
      continue;
    }
    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    if(level._id_EE9A[var_2._id_399D]["targetScore"] > level._id_EE9A[var_0._id_399D]["targetScore"]) {
      var_0 = var_2;
    }
  }

  if(!isDefined(var_0) || level._id_EE9A[var_0._id_399D]["targetScore"] == 0) {
    return undefined;
  }

  return var_0;
}

updateproximitytarget() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = getclosestplayer();

    if(isDefined(var_0) && self.shoulddoproximitycheck) {
      var_1 = distancesquared(var_0.origin, self.origin);

      if(var_1 < 4900) {
        self.lastproximitytarget = self.proximitytarget;
        self.proximitytarget = var_0;
        var_2 = isDefined(self.lastproximitytarget) && self.lastproximitytarget == self.proximitytarget;

        if(var_2 && isalive(self.proximitytarget)) {
          self.proximitytarget = undefined;
          self.lastproximitytarget = undefined;
          _id_D55D(var_0);
        }
      } else {
        self.proximitytarget = undefined;
        self.lastproximitytarget = undefined;
      }
    }

    wait 1;
  }
}

getclosestplayer() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(self.lastproximitytarget) && var_3 == self.lastproximitytarget) {
      continue;
    }
    var_4 = distancesquared(var_3.origin, self.origin);

    if(!isDefined(var_0)) {
      var_0 = var_3;
      var_1 = var_4;
      continue;
    }

    if(var_4 < var_1) {
      var_0 = var_3;
      var_1 = var_4;
    }
  }

  return var_0;
}

getcampingbasedkrampustargetarray() {
  var_0 = gettime();

  foreach(var_2 in level.players) {
    if(!isDefined(level._id_EE9A[var_2._id_399D])) {
      level._id_EE9A[var_2._id_399D]["campOrigin"] = var_2.origin;
      level._id_EE9A[var_2._id_399D]["campTimeStamp"] = var_0;
      level._id_EE9A[var_2._id_399D]["targetScore"] = 0;
    }

    var_3 = distancesquared(var_2.origin, level._id_EE9A[var_2._id_399D]["campOrigin"]);
    var_4 = var_3 < 160000;

    if(!var_4) {
      level._id_EE9A[var_2._id_399D]["campOrigin"] = var_2.origin;
      level._id_EE9A[var_2._id_399D]["campTimeStamp"] = var_0;
    }

    var_5 = var_0 - level._id_EE9A[var_2._id_399D]["campTimeStamp"] > 3000;
    updatetargetscore(var_2, var_5);
  }
}

getobjectivebasedkrampustargetarray() {
  foreach(var_1 in level.players) {
    if(!isDefined(level._id_EE9A[var_1._id_399D])) {
      level._id_EE9A[var_1._id_399D]["kdScore"] = 0;
      level._id_EE9A[var_1._id_399D]["objectiveScore"] = 0;
      level._id_EE9A[var_1._id_399D]["targetScore"] = 0;
    }

    level._id_EE9A[var_1._id_399D]["kdScore"] = 0;

    if(var_1.pers["kills"] > var_1.pers["deaths"]) {
      level._id_EE9A[var_1._id_399D]["kdScore"] = var_1.pers["kills"] - var_1.pers["deaths"];
    }

    switch (level.gametype) {
      case "dom":
        level._id_EE9A[var_1._id_399D]["objectiveScore"] = var_1.pers["captures"] * 50;
        break;
      case "koth":
      case "patrol":
        level._id_EE9A[var_1._id_399D]["objectiveScore"] = var_1.pers["objTime"] * 2;
        break;
      case "conf":
        level._id_EE9A[var_1._id_399D]["objectiveScore"] = var_1.pers["confirmed"] * 20 + var_1.pers["denied"] * 10;
        break;
      default:
        break;
    }

    var_2 = level._id_EE9A[var_1._id_399D]["kdScore"] * 10 > level._id_EE9A[var_1._id_399D]["objectiveScore"];
    updatetargetscore(var_1, var_2);
  }
}

updatetargetscore(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_1) {
    level._id_EE9A[var_0._id_399D]["targetScore"] = level._id_EE9A[var_0._id_399D]["targetScore"] + var_2;
  } else if(level._id_EE9A[var_0._id_399D]["targetScore"] > 0) {
    level._id_EE9A[var_0._id_399D]["targetScore"]--;
  }
}

damageaggrotoattacker(var_0) {
  if(var_0 == self._id_01BD) {
    return;
  }
  var_1 = gettime();
  var_2 = var_1 - self.lastdamageaggrotimestamp > 5000;
  var_3 = distancesquared(self.origin, var_0.origin);
  var_4 = var_3 <= 160000;
  var_5 = distancesquared(self.origin, self._id_01BD.origin);
  var_6 = var_5 < 40000;
  var_7 = self _meth_86C8();
  var_8 = self.damageaggrocount >= 3;

  if(var_4 && var_2 && !var_6 && !var_8 && !var_7) {
    self.lastdamageaggrotimestamp = var_1;
    self.originaltarget = self._id_01BD;
    self.damageaggrocount = self.damageaggrocount + 1;
    _id_D55D(var_0);
  }
}

shouldreturntooriginaltarget() {
  if(isDefined(self.originaltarget) && isalive(self.originaltarget) && !istrue(self.originaltarget._id_88DF)) {
    var_0 = distancesquared(self.origin, self.originaltarget.origin);
    var_1 = var_0 <= 360000;

    if(var_1) {
      return 1;
    }
  }

  return 0;
}

_id_FCCA() {
  self notify("endupdatemove");
  level endon("game_ended");
  self endon("death");
  self endon("endupdatemove");

  if(isDefined(self._id_01BD)) {
    var_0 = self._id_01BD.origin;

    if(self._id_0281) {
      var_1 = self _meth_841A();
      thread destroydoorifclose(var_1);
    }

    destroydestuctablewalls();
    var_2 = self._id_01BD.origin[2] - self.origin[2];

    if(abs(var_2) > 100) {
      self.waitingforteleport = 1;
      thread teleporttotarget(var_2);
    } else
      self.waitingforteleport = 0;

    if(self.waitingforteleport && 0) {
      self _meth_8326(self.origin);
    } else {
      self _meth_8326(var_0);
      self _meth_85E2(300);
    }

    giveupcheckonunreachabletarget();
    giveupcheckonjuggernaut();
  }
}

destroydoorifclose(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = distancesquared(var_0.origin, self.origin);
  var_2 = var_1 < 2500;

  if(var_2) {
    _id_08F1::setdoortoopen(var_0);
    earthquake(0.3, 0.5, var_0.origin, 300);
    self radiusdamage(var_0.origin, 50, 1000, 1000, self);
    wait 1;
    var_0 _meth_8727(1);
  }
}

destroydestuctablewalls() {
  var_0 = _func_03C0("destructiblewall", "targetname", self getEye(), 175);

  foreach(var_2 in var_0) {
    var_2 _id_090B::_id_D8C2();
    var_3 = var_2 _meth_8575("main_part", 1);

    if(isDefined(var_3) && var_3 == "no_more_collmap") {
      continue;
    }
    var_4 = distancesquared(var_2._id_109BB, self.origin);
    var_5 = var_4 < 2500;
    scripts\mp\abilities\wall_destructible_dash_mp::isfacingwallmp(var_2);

    if(var_5) {
      self radiusdamage(var_2._id_109BB, 30, 1000, 1000, self);
    }
  }
}

teleporttotarget(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("teleporttotarget");
  self endon("krampusGoToSleep");
  self endon("krampusWakeUp");
  var_1 = var_0 > 0;

  if(var_1) {
    wait 3;
  } else {
    wait 3;
  }

  if(!isDefined(self._id_01BD) || !self.krampusisawake) {
    return;
  }
  var_2 = self._id_01BD.origin[2] - self.origin[2];
  var_3 = var_2 > 0;
  var_4 = var_1 && var_3 || !var_1 && !var_3;

  if(var_4 && abs(var_2) > 100) {
    var_5 = self._id_01BD _id_09EF::_id_6DF2(1, 1, 1);

    if(isDefined(var_5)) {
      krampusplayteleportvfx(1);
      self.origin = var_5[0].origin;
      self setorigin(var_5[0].origin);
      krampusplayteleportvfx();
      self notify("teleporttotarget");
    }
  }
}

istargetreachable() {
  if(self._id_01BD isonladder()) {
    return 0;
  }

  var_0 = _id_06E0::_id_68E7(self._id_01BD);
  var_1 = _id_06E0::_id_31A9(self.origin, var_0);
  return var_1._id_31A8;
}

giveupcheckonunreachabletarget() {
  var_0 = gettime();

  if(isDefined(self._id_31FB) && var_0 - self._id_31FB > 3000) {
    if(!istargetreachable()) {
      setkrampusroar();
      krampusgotosleep(var_0);
      krampushide();
      self._id_01BD = undefined;
      updatetarget();
    }

    self._id_31FB = undefined;
  }
}

giveupcheckonjuggernaut() {
  var_0 = gettime();

  if(istrue(self._id_01BD._id_88DF)) {
    setkrampusroar();
    krampusgotosleep(var_0);
    krampushide();
    self._id_01BD = undefined;
    updatetarget();
  }
}

krampusplayteleportvfx(var_0) {
  var_1 = self.origin;

  if(istrue(var_0)) {
    var_2 = "vfx_codmas_krampus_despawn";
    thread _id_084D::krampus_despawn_sound(self);
  } else {
    var_2 = "vfx_codmas_krampus_spawn";
    thread _id_084D::krampus_spawn_sound(self);
  }

  playFX(scripts\engine\utility::getfx(var_2), var_1);
}