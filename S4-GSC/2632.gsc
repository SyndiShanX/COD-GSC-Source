/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2632.gsc
*************************************************/

init() {
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level._effect["jet_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_harrier_angel_flares.vfx");

  if(level.gametype != "br") {
    level thread _id_68F0();
  }
}

_id_68F0() {
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1++;
    var_2 = var_2 + var_4.origin[2];
  }

  if(var_1 > 0) {
    level._id_1F9C = var_2 / var_1;
  } else {
    level._id_1F9C = 0;
  }
}

_id_99F2(var_0, var_1, var_2) {
  level.chopper_fx["explode"]["death"][var_0] = loadfx(var_1);
  level._id_9460[var_0] = var_2;
}

_id_108A(var_0, var_1) {
  level.chopper_fx["explode"]["air_death"][var_0] = loadfx(var_1);
}

_id_45B8() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

_id_FE78(var_0, var_1) {
  return _id_F785(var_0, "helicopter");
}

_id_F785(var_0, var_1) {
  var_2 = 1;

  if(isDefined(level._id_3643)) {
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  if(isDefined(level._id_3643) && var_3) {
    self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");

    if(isDefined(var_1) && var_1 != "helicopter") {
      var_4 = "helicopter_" + var_1;
    } else {
      var_4 = "helicopter";
    }

    var_5 = spawn("script_origin", (0, 0, 0));
    var_5 hide();
    var_5 thread _id_4778(self, "disconnect");
    var_5.player = self;
    var_5._id_936C = var_0;
    var_5._id_77E7 = var_1;
    var_5.streakname = var_4;
    scripts\mp\utility\script::_id_BEC7("helicopter", var_5);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level._id_59E1 + var_2 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  var_2 = 1;
  _id_E6B7(var_0, var_1);
  return 1;
}

_id_4778(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self delete();
}

_id_E6B7(var_0, var_1) {
  scripts\mp\utility\killstreak::_id_7DEF();
  var_2 = undefined;

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_3 = "helicopter";
  var_4 = self.pers["team"];
  var_2 = level._id_7743[randomint(level._id_7743.size)];
  scripts\common\utility::_id_F73A(level._id_9BB4, var_3, self.origin);
  thread _id_7750(var_0, self, var_2, self.pers["team"], var_1);
}

_id_BB68() {
  level._id_7729["allies"]["hit"] = "veh_chopper_support_hit";
  level._id_7729["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level._id_7729["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level._id_7729["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level._id_7729["allies"]["crash"] = "exp_helicopter_fuel";
  level._id_7729["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level._id_7729["axis"]["hit"] = "veh_chopper_support_hit";
  level._id_7729["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level._id_7729["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
  level._id_7729["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
  level._id_7729["axis"]["crash"] = "exp_helicopter_fuel";
  level._id_7729["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

_id_76CA() {
  var_0 = self.team;

  if(level._id_A2FC) {
    var_0 = "axis";
  }

  return var_0;
}

_id_E15A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnhelicopter(var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_5)) {
    return undefined;
  }

  if(var_4 == "vehicle_battle_hind") {
    var_5._id_7756 = "cobra";
  } else {
    var_5._id_7756 = level._id_7757[var_4];
  }

  var_5 thread[[level._id_9460[var_5._id_7756]]]();
  var_5 scripts\mp\utility\killstreak::_id_115E(var_5 getentitynumber());
  var_5._id_11012 = (0, 0, var_5 gettagorigin("tag_origin")[2] - var_5 gettagorigin("tag_ground")[2]);
  var_5._id_1E2E = _func_014B(var_5, level._id_767C, level._id_767B);
  return var_5;
}

_id_779E(var_0) {
  if(gettime() - level._id_8FEB < 6000) {
    return;
  }
  level._id_8FEB = gettime();
  var_1 = randomint(level._id_779E[var_0].size);
  var_2 = level._id_779E[var_0][var_1];
  var_3 = scripts\mp\utility\teams::_id_6DDF(self.team) + "tl" + var_2;
  self playlocalsound(var_3);
}

_id_FC02(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3._id_FF63 = [];
    var_3._id_A57A = 0;
  }

  foreach(var_6 in level.players) {
    if(!isalive(var_6)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    foreach(var_3 in var_0) {
      if(distancesquared(var_6.origin, var_3.origin) > 1048576) {
        continue;
      }
      var_3._id_FF63[var_3._id_FF63.size] = var_6;
    }
  }

  var_10 = var_0[0];

  foreach(var_3 in var_0) {
    var_12 = getent(var_3.target, "targetname");

    foreach(var_6 in var_3._id_FF63) {
      var_3._id_A57A = var_3._id_A57A + 1;

      if(scripts\engine\trace::_bullet_trace_passed(var_6.origin + (0, 0, 32), var_12.origin, 0, var_6)) {
        var_3._id_A57A = var_3._id_A57A + 3;
      }
    }

    if(var_3._id_A57A > var_10._id_A57A) {
      var_10 = var_3;
    }
  }

  return getent(var_10.target, "targetname");
}

_id_7750(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2.origin;
  var_6 = var_2.angles;
  var_7 = "cobra_mp";
  var_8 = "vehicle_battle_hind";
  var_9 = _id_E15A(var_1, var_5, var_6, var_7, var_8);

  if(!isDefined(var_9)) {
    return;
  }
  level._id_3643 = var_9;

  if(var_3 == "allies") {
    level._id_150F = var_9;
  } else {
    level._id_1FE4 = var_9;
  }

  var_9._id_77E7 = var_4;
  var_9._id_936C = var_0;
  var_9.team = var_3;
  var_9.pers["team"] = var_3;
  var_9.owner = var_1;
  var_9 setotherent(var_1);
  var_9._id_E6FB = var_2;
  var_9.maxhealth = level._id_76ED;
  var_9._id_EEAC = level._id_774F;
  var_9._id_BCDD = undefined;
  var_9._id_CFE9 = undefined;
  var_9.attacker = undefined;
  var_9._id_41F6 = "ok";
  var_9 _id_0812::_id_C2B2("Killstreak_Air", var_1);
  var_9._id_51B3 = 0;

  if(var_4 == "flares" || var_4 == "minigun") {
    var_9 thread _id_0A44::_id_5C81(1);
  }

  var_9 thread _id_76E3(var_1);
  var_9 thread _id_76E2(var_1);
  var_9 thread _id_76E4(var_1);
  var_9 thread _id_7699(var_4);
  var_9 thread _id_7760();
  var_9 thread _id_775F();
  var_9 thread _id_76B4();
  var_9 endon("helicopter_done");
  var_9 endon("crashing");
  var_9 endon("leaving");
  var_9 endon("death");
  var_10 = getEntArray("heli_attack_area", "targetname");
  var_11 = undefined;
  var_11 = level._id_76EB[randomint(level._id_76EB.size)];
  var_9 _id_76BF(var_2);
  var_9 thread _id_774E();
  var_9 thread _id_76E6(60.0);
  var_9 thread _id_76BE(var_11);
}

_id_76B4() {
  var_0 = self getentitynumber();
  scripts\engine\utility::waittill_any_3("death", "crashing", "leaving");
  scripts\mp\utility\killstreak::_id_C4A9(var_0);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  var_1 = undefined;
  var_2 = scripts\mp\utility\script::_id_BED5("helicopter");

  if(!isDefined(var_2)) {
    level._id_3643 = undefined;
  } else {
    var_1 = var_2.player;
    var_3 = var_2._id_936C;
    var_4 = var_2.streakname;
    var_5 = var_2._id_77E7;
    var_2 delete();

    if(isDefined(var_1) && (var_1.sessionstate == "playing" || var_1.sessionstate == "dead")) {
      var_1 _id_E6B7(var_3, var_5);
      return;
    }

    level._id_3643 = undefined;
  }
}

_id_774E() {
  self notify("heli_targeting");
  self endon("heli_targeting");
  self endon("death");
  self endon("helicopter_done");

  for(;;) {
    var_0 = [];
    self._id_BCDD = undefined;
    self._id_CFE9 = undefined;

    foreach(var_2 in level.characters) {
      wait 0.05;

      if(!_id_31F2(var_2)) {
        continue;
      }
      var_0[var_0.size] = var_2;
    }

    if(var_0.size) {
      for(var_4 = _id_6913(var_0); !isDefined(var_4); var_4 = _id_6913(var_0)) {
        waitframe();
      }

      self._id_BCDD = var_4;
      self notify("primary acquired");
    }

    if(isDefined(self._id_BCDD)) {
      _id_5B84(self._id_BCDD);
      continue;
    }

    wait 0.25;
  }
}

_id_31F2(var_0) {
  var_1 = 1;

  if(!isalive(var_0) || isDefined(var_0.sessionstate) && var_0.sessionstate != "playing") {
    return 0;
  }

  if(distance(var_0.origin, self.origin) > level._id_775B) {
    return 0;
  }

  if(!self.owner scripts\mp\utility\player::isenemy(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_E393) && (gettime() - var_0._id_E393) / 1000 <= 5) {
    return 0;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
    return 0;
  }

  var_2 = self.origin + (0, 0, -160);
  var_3 = anglesToForward(self.angles);
  var_4 = var_2 + 144 * var_3;

  if(var_0 _meth_83CD(var_4, self) < level._id_774D) {
    return 0;
  }

  return var_1;
}

_id_6913(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    _id_FBB2(var_2);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = getEntArray("minimap_corner", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_6.size == 2) {
      var_8 = var_6[0].origin;
      var_9 = var_6[0].origin;

      if(var_6[1].origin[0] > var_9[0]) {
        var_9 = (var_6[1].origin[0], var_9[1], var_9[2]);
      } else {
        var_8 = (var_6[1].origin[0], var_8[1], var_8[2]);
      }

      if(var_6[1].origin[1] > var_9[1]) {
        var_9 = (var_9[0], var_6[1].origin[1], var_9[2]);
      } else {
        var_8 = (var_8[0], var_6[1].origin[1], var_8[2]);
      }

      if(var_2.origin[0] < var_8[0] || var_2.origin[0] > var_9[0] || var_2.origin[1] < var_8[1] || var_2.origin[1] > var_9[1]) {
        continue;
      }
    }

    if(var_2._id_F168 < var_4) {
      continue;
    }
    if(!scripts\engine\trace::_bullet_trace_passed(var_2.origin + (0, 0, 32), self.origin, 0, self)) {
      wait 0.05;
      continue;
    }

    var_4 = var_2._id_F168;
    var_5 = var_2;
  }

  return var_5;
}

_id_FBB2(var_0) {
  var_0._id_F168 = 0;
  var_1 = distance(var_0.origin, self.origin);
  var_0._id_F168 = var_0._id_F168 + (level._id_775B - var_1) / level._id_775B * 100;

  if(isDefined(self.attacker) && var_0 == self.attacker) {
    var_0._id_F168 = var_0._id_F168 + 100;
  }

  if(isPlayer(var_0)) {
    var_0._id_F168 = var_0._id_F168 + var_0._id_038F * 4;
  }

  if(isDefined(var_0._id_1903)) {
    var_0._id_F168 = var_0._id_F168 - var_0._id_1903;
  }

  if(var_0._id_F168 <= 0) {
    var_0._id_F168 = 1;
  }
}

_id_770D() {
  self _meth_8087();
  self _meth_807D();
  self vehicle_setspeed(80, 35);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

_id_1120(var_0) {
  self endon("death");
  self._id_C0EE = self._id_C0EE + var_0;
  wait 4.0;
  self._id_C0EE = self._id_C0EE - var_0;
}

_id_A007(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_7 = 2;
  var_8 = 3;
  var_9 = 4;

  if(isDefined(self._id_77E7) && self._id_77E7 == "dronedrop") {
    var_7 = 1;
    var_8 = 1;
    var_9 = 2;
  }

  var_6 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_2, var_3, var_6, self.maxhealth, var_7, var_8, var_9);
  thread _id_1120(var_6);
  self notify("heli_damage_fx");
  return var_6;
}

_id_7433(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(isDefined(var_1)) {
    var_6 = level._id_776D[self.streakname];
    var_7 = _id_07C3::_id_AB18(self.streakname, var_1, var_2, var_3, var_4, var_6._id_CC16, var_6._id_484C, var_6._id_2F66);

    if(var_7) {
      var_1 notify("destroyed_helicopter");
      self._id_8D87 = var_1;
    }
  }
}

_id_7699(var_0, var_1, var_2) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = var_0;
  self._id_C0EE = 0;

  if(!istrue(var_2)) {
    thread _id_76D2();
  }

  _id_07C3::_id_A0FF(self.maxhealth, "helicopter", ::_id_7433, ::_id_A007, 1, var_1);
}

_id_7760() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    self._id_51B3 = 1;

    if(isDefined(self._id_9E71)) {
      self._id_9E71 notify("stop_shooting");
    }

    if(isDefined(self._id_9E74)) {
      self._id_9E74 notify("stop_shooting");
    }

    wait(var_1);
    self._id_51B3 = 0;

    if(isDefined(self._id_9E71)) {
      self._id_9E71 notify("turretstatechange");
    }

    if(isDefined(self._id_9E74)) {
      self._id_9E74 notify("turretstatechange");
    }
  }
}

_id_76D2() {
  self endon("leaving");
  self endon("crashing");
  self._id_41F6 = "ok";
  self._id_9097 = "ok";
  self _meth_8307(3);
  var_0 = 3;
  self _meth_8307(var_0);
  var_1 = level._id_776D[self.streakname];

  for(;;) {
    self waittill("heli_damage_fx");

    if(var_0 > 0 && self._id_014E >= self.maxhealth) {
      var_0 = 0;
      self _meth_8307(var_0);
      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var_1._id_5463);
      self notify("death");
      break;
    } else {
      if(var_0 > 1 && self._id_014E >= self.maxhealth * 0.66) {
        var_0 = 1;
        self _meth_8307(var_0);
        self._id_41F6 = "heavy smoke";
        stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var_1._id_5463);
        playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, var_1._id_5463);
        continue;
      }

      if(var_0 > 2 && self._id_014E >= self.maxhealth * 0.33) {
        var_0 = 2;
        self _meth_8307(var_0);
        self._id_41F6 = "light smoke";
        playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, var_1._id_5463);
      }
    }
  }
}

_id_775F() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isDefined(self._id_8EE2) && self._id_8EE2) {
    thread _id_76B5(1);
  } else {
    var_0 = level._id_776D[self.streakname];
    playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, var_0._id_5463);
    thread _id_7688();
  }
}

_id_7688() {
  self notify("crashing");
  self _meth_807E();
  var_0 = level._id_7691[randomint(level._id_7691.size)];

  if(isDefined(self._id_9E71)) {
    self._id_9E71 notify("stop_shooting");
  }

  if(isDefined(self._id_9E74)) {
    self._id_9E74 notify("stop_shooting");
  }

  thread _id_772E(180);
  thread _id_7719();
  _id_76BF(var_0);
  thread _id_76B5();
}

_id_7719() {
  var_0 = _id_76CA();
  var_1 = level._id_776D[self.streakname];
  playFXOnTag(level.chopper_fx["explode"]["large"], self, var_1._id_5463);
  self playSound(level._id_7729[var_0]["hitsecondary"]);
  wait 3.0;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["explode"]["large"], self, var_1._id_5463);
  self playSound(level._id_7729[var_0]["hitsecondary"]);
}

_id_772E(var_0) {
  self endon("death");
  var_1 = _id_76CA();
  self playSound(level._id_7729[var_1]["hit"]);
  thread _id_E40F();
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self _meth_838A(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

_id_E40F() {
  self endon("death");
  wait 0.25;
  var_0 = _id_76CA();
  self stoploopsound();
  wait 0.05;
  self playLoopSound(level._id_7729[var_0]["spinloop"]);
  wait 0.05;
  self playLoopSound(level._id_7729[var_0]["spinstart"]);
}

_id_76B5(var_0) {
  self notify("death");

  if(isDefined(var_0) && isDefined(level.chopper_fx["explode"]["air_death"][self._id_7756])) {
    var_1 = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self._id_7756], self gettagorigin("tag_deathfx"), anglesToForward(var_1), anglestoup(var_1));
  } else {
    var_2 = self.origin;
    var_3 = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self._id_7756], var_2, var_3);
  }

  var_4 = _id_76CA();
  self playSound(level._id_7729[var_4]["crash"]);
  waitframe();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility\killstreak::_id_455A();
  self delete();
}

_id_34A0() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    thread _id_76E0();
    return 0;
  }

  return 1;
}

_id_76E3(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 waittill("disconnect");
  thread _id_76E0();
}

_id_76E2(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread _id_76E0();
}

_id_76E5(var_0) {
  self endon("death");
  self endon("helicopter_done");
  var_0 waittill("spawned");
  thread _id_76E0();
}

_id_76E4(var_0) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread _id_76E0();
}

_id_76E6(var_0) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread _id_76E0();
}

_id_5B84(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_1 = 15;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level._id_76EB) {
    var_2++;
    var_3 = var_3 + var_5.origin[2];
  }

  var_7 = var_3 / var_2;
  self notify("newTarget");

  if(isDefined(self._id_CFE9) && self._id_CFE9._id_014E < self._id_CFE9.maxhealth) {
    return;
  }
  if(isDefined(self._id_8978) && self._id_8978) {
    return;
  }
  var_8 = self._id_BCDD;
  var_8._id_1903 = 0;
  var_9 = self._id_BCDD.origin * (1, 1, 0);
  var_10 = self.origin * (0, 0, 1);
  var_11 = var_9 + var_10;
  var_12 = distance2d(self.origin, var_8.origin);

  if(var_12 < 1000) {
    var_1 = 600;
  }

  var_13 = anglesToForward(var_8.angles);
  var_13 = var_13 * (1, 1, 0);
  var_14 = var_11 + var_1 * var_13;
  var_15 = var_14 - var_11;
  var_16 = vectortoangles(var_15);
  var_16 = var_16 * (1, 1, 0);
  thread _id_1DE4(var_8);
  self vehicle_setspeed(80);

  if(distance2d(self.origin, var_14) < 1000) {
    var_14 = var_14 * 1.5;
  }

  var_14 = var_14 * (1, 1, 0);
  var_14 = var_14 + (0, 0, var_7);
  _id_0CF5(var_14, 1, 1);
  self waittill("near_goal");

  if(!isDefined(var_8) || !isalive(var_8)) {
    return;
  }
  self setlookatent(var_8);
  thread _id_8849(10, var_8);
  scripts\engine\utility::_id_108A7(4, "facing");

  if(!isDefined(var_8) || !isalive(var_8)) {
    return;
  }
  self _meth_807E();
  var_17 = var_11 + var_1 * anglesToForward(var_16);
  self setmaxpitchroll(40, 30);
  _id_0CF5(var_17, 1, 1);
  self setmaxpitchroll(30, 30);

  if(isDefined(var_8) && isalive(var_8)) {
    if(isDefined(var_8._id_1903)) {
      var_8._id_1903 = var_8._id_1903 + 100;
    } else {
      var_8._id_1903 = 100;
    }
  }

  scripts\engine\utility::_id_108A7(3, "near_goal");
}

_id_1DE4(var_0) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self._id_8772 = 1;
  self _meth_839E(var_0);
  _id_10857(var_0, 3.0);

  if(!isalive(var_0)) {
    self._id_8772 = 0;
  } else {
    var_1 = distance2dsquared(self.origin, var_0.origin);

    if(var_1 < 640000) {
      thread _id_5012(var_0);
      self._id_8772 = 0;
      return;
    } else {
      if(_id_3522(50, var_0) && scripts\engine\utility::cointoss()) {
        thread _id_5B81(var_0);
        self._id_8772 = 0;
        return;
        return;
      }

      var_2 = weaponfiretime("cobra_20mm_mp");
      var_3 = 0;
      var_4 = 0;

      for(var_5 = 0; var_5 < level._id_7755; var_5++) {
        if(!isDefined(self)) {
          break;
        }

        if(self._id_51B3) {
          break;
        }

        if(!isDefined(var_0)) {
          break;
        }

        if(!isalive(var_0)) {
          break;
        }

        if(self._id_014E >= self.maxhealth) {
          continue;
        }
        if(!_id_3522(55, var_0)) {
          self stoploopsound();
          var_4 = 0;
          wait(var_2);
          var_5--;
          continue;
        }

        if(var_5 < level._id_7755 - 1) {
          wait(var_2);
        }

        if(!isDefined(var_0) || !isalive(var_0)) {
          break;
        }

        if(!var_4) {
          self playLoopSound("weap_hind_20mm_fire_npc");
          var_4 = 1;
        }

        self _meth_83A7("cobra_20mm_mp");
        self _meth_80F3("tag_flash", var_0);
      }

      if(!isDefined(self)) {
        return;
      }
      self stoploopsound();
      var_4 = 0;
      self._id_8772 = 0;
    }
  }
}

_id_3522(var_0, var_1) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = var_1.origin - self.origin;
  var_2 = var_2 * (1, 1, 0);
  var_3 = var_3 * (1, 1, 0);
  var_3 = vectornormalize(var_3);
  var_2 = vectornormalize(var_2);
  var_4 = vectordot(var_3, var_2);
  var_5 = cos(var_0);

  if(var_4 >= var_5) {
    return 1;
  } else {
    return 0;
  }
}

_id_8849(var_0, var_1) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  while(isalive(var_1)) {
    var_2 = anglesToForward(self.angles);
    var_3 = var_1.origin - self.origin;
    var_2 = var_2 * (1, 1, 0);
    var_3 = var_3 * (1, 1, 0);
    var_3 = vectornormalize(var_3);
    var_2 = vectornormalize(var_2);
    var_4 = vectordot(var_3, var_2);
    var_5 = cos(var_0);

    if(var_4 >= var_5) {
      self notify("facing");
      break;
    }

    wait 0.1;
  }
}

_id_10857(var_0, var_1) {
  self endon("death");
  self endon("helicopter_done");
  var_0 endon("death_or_disconnect");
  scripts\engine\utility::_id_108F5("turret_on_target", var_1);
}

_id_5B81(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_1 = 2;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(!isDefined(var_0)) {
      return;
    }
    if(scripts\engine\utility::cointoss()) {
      var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_missile_mp"), self gettagorigin("tag_missile_right") - (0, 0, 64), var_0.origin, self.owner);
      var_3._id_100A9 = self;
    } else {
      var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_missile_mp"), self gettagorigin("tag_missile_left") - (0, 0, 64), var_0.origin, self.owner);
      var_3._id_100A9 = self;
    }

    var_3 missile_settargetent(var_0);
    var_3.owner = self;
    var_3 _meth_8231();
    wait(0.5 / var_1);
  }
}

_id_5012(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(var_0)) {
    return;
  }
  for(var_1 = 0; var_1 < randomintrange(2, 5); var_1++) {
    if(scripts\engine\utility::cointoss()) {
      var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_bomb_mp"), self gettagorigin("tag_missile_left") - (0, 0, 45), var_0.origin, self.owner);
      var_2._id_100A9 = self;
    } else {
      var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_bomb_mp"), self gettagorigin("tag_missile_right") - (0, 0, 45), var_0.origin, self.owner);
      var_2._id_100A9 = self;
    }

    wait(randomfloatrange(0.35, 0.65));
  }
}

_id_6BE0(var_0) {
  var_1 = self.origin;
  var_2 = var_0.origin;
  var_3 = 0;
  var_4 = 40;
  var_5 = (0, 0, -196);

  for(var_6 = scripts\engine\trace::_bullet_trace(var_1 + var_5, var_2 + var_5, 0, self); distancesquared(var_6["position"], var_2 + var_5) > 10 && var_3 < var_4; var_6 = scripts\engine\trace::_bullet_trace(var_1 + var_5, var_2 + var_5, 0, self)) {
    if(var_1[2] < var_2[2]) {
      var_1 = var_1 + (0, 0, 128);
    } else if(var_1[2] > var_2[2]) {
      var_2 = var_2 + (0, 0, 128);
    } else {
      var_1 = var_1 + (0, 0, 128);
      var_2 = var_2 + (0, 0, 128);
    }

    var_3++;
  }

  var_7 = [];
  var_7["start"] = var_1;
  var_7["end"] = var_2;
  return var_7;
}

_id_F4C4(var_0) {
  var_1 = _id_6BE0(var_0);

  if(var_1["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _id_0CF5(var_1["start"] + (0, 0, 30), 0);
    self _meth_8329(var_0.angles[1] + level._id_766F);
    self waittill("goal");
  }

  if(var_1["end"] != var_0.origin) {
    if(isDefined(var_0._id_CC90) && isDefined(var_0._id_CC89)) {
      var_2 = var_0._id_CC90;
      var_3 = var_0._id_CC89;
    } else {
      var_2 = 30 + randomint(20);
      var_3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _id_0CF5(var_1["end"] + (0, 0, 30), 0);
    self _meth_8329(var_0.angles[1] + level._id_766F);
    self waittill("goal");
  }
}

_id_0CF5(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 0;

  if(var_2) {
    thread _id_0CF7(var_0, var_1);
  } else {
    self setvehgoalpos(var_0, var_1);
  }
}

_id_0CF7(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = var_0;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(scripts\engine\utility::_id_4B8C(self.origin, var_2) < 65536) {
      self setvehgoalpos(var_2, var_1);
      break;
    }

    var_3 = vectortoangles(var_2 - self.origin);
    var_4 = anglesToForward(var_3);
    var_5 = self.origin + var_4 * (1, 1, 0) * 250;
    var_6 = (0, 0, 2500);
    var_7 = var_5 + (scripts\mp\utility\killstreak::_id_6A98() + var_6);
    var_8 = var_5 + (scripts\mp\utility\killstreak::_id_6A98() - var_6);
    var_9 = scripts\engine\trace::_bullet_trace(var_7, var_8, 0, self, 0, 0, 1);
    var_10 = var_9;

    if(isDefined(var_9["entity"]) && var_9["entity"] == self && var_9["normal"][2] > 0.1) {
      var_11 = var_9["position"][2] - 4400;
      var_12 = var_11 - self.origin[2];

      if(var_12 > 256) {
        var_9["position"] = var_9["position"] * (1, 1, 0);
        var_9["position"] = var_9["position"] + (0, 0, self.origin[2] + 256);
      } else if(var_12 < -256) {
        var_9["position"] = var_9["position"] * (1, 1, 0);
        var_9["position"] = var_9["position"] + (0, 0, self.origin[2] - 256);
      }

      var_10 = var_9["position"] - scripts\mp\utility\killstreak::_id_6A98() + (0, 0, 600);
    } else
      var_10 = var_2;

    self setvehgoalpos(var_10, 0);
    wait 0.15;
  }
}

_id_76BF(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  _id_770D();
  var_1 = var_0;

  while(isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");

    if(isDefined(var_1._id_CC90) && isDefined(var_1._id_CC89)) {
      var_3 = var_1._id_CC90;
      var_4 = var_1._id_CC89;
    } else {
      var_3 = 30 + randomint(20);
      var_4 = 15 + randomint(15);
    }

    if(isDefined(self._id_8772) && self._id_8772) {
      waitframe();
      continue;
    }

    if(isDefined(self._id_8978) && self._id_8978) {
      waitframe();
      continue;
    }

    self vehicle_setspeed(75, 35);

    if(!isDefined(var_2.target)) {
      _id_0CF5(var_2.origin + self._id_11012, 1);
      self waittill("near_goal");
    } else {
      _id_0CF5(var_2.origin + self._id_11012, 0);
      self waittill("near_goal");
      self _meth_8329(var_2.angles[1]);
      self waittillmatch("goal");
    }

    var_1 = var_2;
  }
}

_id_76BE(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  _id_770D();
  thread _id_76EC(var_0);
  var_1 = var_0;

  while(isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");

    if(isDefined(self._id_8978) && self._id_8978) {
      wait 0.25;
      continue;
    }

    if(isDefined(self._id_8772) && self._id_8772) {
      wait 0.1;
      continue;
    }

    if(isDefined(var_1._id_CC90) && isDefined(var_1._id_CC89)) {
      self._id_4817 = var_1._id_CC90;
      self._id_4811 = var_1._id_CC89;
    } else {
      self._id_4817 = 30 + randomint(20);
      self._id_4811 = 15 + randomint(15);
    }

    if(self._id_77E7 == "flares") {
      self._id_4817 = self._id_4817 * 0.5;
      self._id_4811 = self._id_4811 * 0.5;
    }

    if(isDefined(var_2._id_0393) && isDefined(self._id_BCDD) && !_id_76DD()) {
      _id_0CF5(var_2.origin + self._id_11012, 1, 1);
      self waittill("near_goal");
      wait(var_2._id_0393);
    } else {
      _id_0CF5(var_2.origin + self._id_11012, 0, 1);
      self waittill("near_goal");
      self _meth_8329(var_2.angles[1]);
      self waittillmatch("goal");
    }

    var_1 = var_2;
  }
}

_id_76EC(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isDefined(var_0._id_CC90) && isDefined(var_0._id_CC89)) {
    self._id_4817 = var_0._id_CC90;
    self._id_4811 = var_0._id_CC89;
  } else {
    self._id_4817 = 30 + randomint(20);
    self._id_4811 = 15 + randomint(15);
  }

  var_1 = 0;
  var_2 = 0;

  for(;;) {
    var_3 = self._id_4817;
    var_4 = self._id_4811;

    if(isDefined(self._id_8772) && self._id_8772) {
      waitframe();
      continue;
    }

    if(self._id_77E7 != "flares" && isDefined(self._id_BCDD) && !_id_76DD()) {
      var_3 = var_3 * 0.25;
    }

    if(var_1 != var_3 || var_2 != var_4) {
      self vehicle_setspeed(75, 35);
      var_1 = var_3;
      var_2 = var_4;
    }

    wait 0.05;
  }
}

_id_76DD() {
  if(self._id_C0EE > 50) {
    return 1;
  }

  if(self._id_41F6 == "heavy smoke") {
    return 1;
  }

  return 0;
}

_id_76C0(var_0) {
  self notify("flying");
  self endon("flying");
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    if(isDefined(self._id_8772) && self._id_8772) {
      waitframe();
      continue;
    }

    var_1 = _id_6389(var_0);
    _id_F4C4(var_1);

    if(isDefined(var_1._id_CC90) && isDefined(var_1._id_CC89)) {
      var_2 = var_1._id_CC90;
      var_3 = var_1._id_CC89;
    } else {
      var_2 = 30 + randomint(20);
      var_3 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _id_0CF5(var_1.origin + self._id_11012, 1);
    self _meth_8329(var_1.angles[1] + level._id_766F);

    if(level._id_76C2 != 0) {
      self waittill("near_goal");
      wait(level._id_76C2);
      continue;
    }

    if(!isDefined(var_1._id_0393)) {
      self waittill("near_goal");
      wait(5 + randomint(5));
      continue;
    }

    self waittillmatch("goal");
    wait(var_1._id_0393);
  }
}

_id_6389(var_0) {
  return _id_FC02(var_0);
}

_id_76E0(var_0) {
  self notify("leaving");
  self _meth_807E();

  if(isDefined(self._id_77E7) && self._id_77E7 == "osprey" && isDefined(self._id_AEDC)) {
    _id_0CF5(self._id_AEDC, 1);
    scripts\engine\utility::_id_108A7(5, "goal");
  }

  if(!isDefined(var_0)) {
    var_1 = level._id_76E1[randomint(level._id_76E1.size)];
    var_0 = var_1.origin;
  }

  var_2 = spawn("script_origin", var_0);

  if(isDefined(var_2)) {
    self setlookatent(var_2);
    var_2 thread _id_106C5(3.0);
  }

  var_3 = (var_0 - self.origin) * 2000;
  _id_770D();
  self vehicle_setspeed(180, 45);
  _id_0CF5(var_3, 1);
  scripts\engine\utility::_id_108A7(12, "goal");
  self notify("gone");
  self notify("death");
  waitframe();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  scripts\mp\utility\killstreak::_id_455A();
  self delete();
}

_id_106C5(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

_id_4478(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_769E) && level._id_769E == 1.0) {
    thread _id_4F2C(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_4479(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_769E) && level._id_769E == 1.0) {
    if(isDefined(var_3)) {
      thread _id_4F2C(var_0, (0.8, 0.8, 0.8), var_1, var_2, var_3);
    } else {
      thread _id_4F2C(var_0, (0.8, 0.8, 0.8), var_1, var_2, 0);
    }
  }
}

_id_445C(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_769E) && level._id_769E == 1.0 && !isDefined(var_3)) {
    thread _id_4F12(var_0, var_1, var_2);
  } else if(isDefined(level._id_769E) && level._id_769E == 1.0) {
    thread _id_4F12(var_0, var_1, var_2, var_3);
  }
}

_id_4F2C(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    while(isDefined(var_2)) {
      wait 0.05;
    }
  } else {
    for(var_5 = 0; var_5 < var_4; var_5++) {
      if(!isDefined(var_2)) {
        break;
      }

      wait 0.05;
    }
  }
}

_id_4F12(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      wait 0.05;
    }
  } else {
    for(;;) {
      wait 0.05;
    }
  }
}

_id_56D0(var_0) {
  if(level._id_9593.size >= 4 || level._id_9593.size >= 2 && var_0 == "littlebird_flock") {
    return 1;
  } else {
    return 0;
  }
}

_id_AF79() {
  self endon("death_or_disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
  wait 3.5;
  self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

_id_9122() {
  self endon("gone");

  if(!isDefined(self)) {
    return;
  }
  self notify("crashing");

  if(isDefined(self._id_8EE2) && self._id_8EE2) {
    waitframe();
  } else {
    self vehicle_setspeed(25, 5);
    thread _id_912C(randomintrange(180, 220));
    wait(randomfloatrange(1.0, 2.0));
  }

  _id_9121();
}

_id_912C(var_0) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread _id_F449(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setyawspeed(var_0, var_0, var_0);

  while(isDefined(self)) {
    self _meth_838A(self.angles[1] + var_0 * 0.9);
    wait 1;
  }
}

_id_9121() {
  var_0 = self.origin + (0, 0, 1) - self.origin;
  var_1 = self gettagangles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglesToForward(var_1), anglestoup(var_1));
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  _id_C4DF();
}

_id_F449(var_0, var_1, var_2) {
  self notify(var_2);
  self endon(var_2);
  self endon("death");

  for(;;) {
    playFXOnTag(var_0, self, var_1);
    wait 0.05;
  }
}

_id_C4DF() {
  if(isDefined(self._id_9E71)) {
    if(isDefined(self._id_9E71.killcament)) {
      self._id_9E71.killcament delete();
    }

    self._id_9E71 delete();
  }

  if(isDefined(self._id_9E74)) {
    if(isDefined(self._id_9E74.killcament)) {
      self._id_9E74.killcament delete();
    }

    self._id_9E74 delete();
  }

  if(isDefined(self._id_9B4D)) {
    self._id_9B4D delete();
  }

  if(isDefined(level._id_76FF[self.team]) && level._id_76FF[self.team] == self) {
    level._id_76FF[self.team] = undefined;
  }

  scripts\mp\utility\killstreak::_id_455A();
  self delete();
}