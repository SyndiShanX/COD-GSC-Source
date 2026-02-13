/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2494.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "init")]]();
  }

  level._effect["white_phosphorus_inair_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_white_phosphorus_expl_inair.vfx");
  level._effect["white_phosphorus_screen"] = loadfx("vfx/iw8_mp/killstreak/vfx_white_phosphorus_screen.vfx");
  level._id_0F6C = [];
  level._id_0F6B = [];
  level._id_10E0A = getent("white_phosphorus_damage", "targetname");
}

_id_10F9E() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_airspace_crowded_firebombing", 1);

  while(istrue(level._id_10FA1)) {
    waitframe();
  }

  self setclientomnvar("ui_airspace_crowded_firebombing", 0);
}

_id_10D97(var_0) {
  if(istrue(level._id_10FA1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "startMapSelectSequence")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "startMapSelectSequence")]](0, 1, 1);
  }

  return 1;
}

_id_F7A8() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("white_phosphorus", self);
  return _id_F7A9(var_0);
}

_id_F7A9(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_1 = [];
  var_2 = spawnStruct();
  var_2._id_96CF = level._id_9AAC;
  var_2.angles = 0.0;
  var_2._id_EA52 = "confirm_location";
  var_1[var_1.size] = var_2;
  _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));
  thread _id_10F84(var_1, var_0);
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_3 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("white_phosphorus", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_white_phosphorus", self);
  }

  return 1;
}

_id_10F6F(var_0, var_1, var_2) {
  scripts\common\utility::_id_1593(0);
  self _meth_867F("mp_killstreak_overlay");
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "getSelectMapPoint")) {
    var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("wh ite_phosphorus", "getSelectMapPoint")]](var_0, var_1, var_2);
  }

  if(!isDefined(var_3)) {
    scripts\common\utility::_id_1593(1);
    self _meth_8680("mp_killstreak_overlay");
    return undefined;
  }

  scripts\common\utility::_id_1593(1);
  self _meth_8680("mp_killstreak_overlay");
  return var_3;
}

_id_10F84(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(istrue(level._id_10FA1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return 0;
  }

  level._id_10FA1 = 1;
  thread _id_10F9E();

  foreach(var_6, var_3 in var_0) {
    var_4 = var_3._id_96CF;
    var_5 = var_3.angles;
    _id_10F68(var_4, var_5, var_1);

    if(var_0.size > 1 && var_6 < var_0.size - 1) {
      wait(randomfloatrange(1, 3.0));
    }
  }
}

_id_10F68(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  thread _id_10F91("disconnect");
  thread _id_10F91("joined_team");
  thread _id_10F91("joined_spectator");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  var_3 = _id_10F5B(var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_3._id_873F = 1;
  var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "monitorDamage")]](100, "hitequip", ::_id_10F73, undefined, 1);
  var_3 thread _id_10F9A();
  var_3 thread _id_10F62(var_2);
}

_id_10F73(var_0) {
  var_1 = var_0.attacker;
  _id_10F63();
}

_id_10F63() {
  level notify("white_phosphorus_end");
  self notify("death");
  level._id_10FA1 = undefined;
  var_0 = anglestoright(self.angles) * 200;
  playFX(level._id_F902["uav"]._id_6090, self.origin, var_0);
  playsoundatpos(self.origin, level._id_F902["directional_uav"]._id_E053);
  _id_10F7E(self);
}

_id_10F5B(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_4 = 28000;
  var_5 = 5000;
  var_6 = 2500;
  var_7 = 1500;
  var_8 = (0, var_1, 0);

  if(!isDefined(var_3)) {
    var_6 = var_6 + 3000;
  } else {
    var_6 = var_3.origin[2] + 3000;
    var_7 = _id_09AB::_id_6A21(var_6);
  }

  var_9 = _id_09AB::_id_6A4E(var_0, var_8, var_4, var_3, var_6, var_5, var_7);
  var_10 = spawn("script_model", var_9["startPoint"]);
  var_10.angles = var_8;
  var_10._id_5CF4 = var_9;
  var_10.owner = self;
  var_10.team = self.team;
  var_10.streakinfo = var_2;
  var_10.speed = var_5;
  var_11 = "veh8_mil_air_suniform25_west";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(self)) {
    var_11 = "veh8_mil_air_suniform25";
  }

  var_10 setModel(var_11);
  var_12 = undefined;
  var_13 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_13 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
  }

  if(isDefined(var_13)) {
    var_12 = var_10[[var_13]]("icon_minimap_wp", var_10.team, 1, 1, 1);
    var_10._id_9F26 = var_12;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_10.streakinfo.streakname, "Killstreak_Air", self);
  }

  return var_10;
}

_id_10F91(var_0, var_1) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self waittill(var_0);
  level._id_10FA1 = undefined;
  level notify("white_phosphorus_end");
}

_id_10F9A() {
  self endon("death");
  level waittill("white_phosphorus_end");
  _id_10F7E(self);
}

_id_10F98() {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(_id_10F75("smoke", self)) {
    level _id_10F7D("smoke", self);
  } else {
    var_0 = 0;

    if(var_0) {
      self _meth_86BE();
    } else {
      self delete();
    }
  }
}

_id_10F94(var_0) {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(_id_10F75("inner", self)) {
    level _id_10F7D("inner", self, var_0, 1);
  }

  self notify("stop_wp_status_effect");
  var_1 = 0;

  if(var_1) {
    self _meth_86BE();
  } else {
    self delete();
  }
}

_id_10F62(var_0) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = self._id_5CF4["startPoint"];
  var_2 = self._id_5CF4["endPoint"];
  var_3 = self._id_5CF4["flyTime"];
  var_4 = var_1 + anglesToForward(self.angles) * 12500;
  var_5 = var_2 - anglesToForward(self.angles) * 12500;
  var_6 = length(var_4 - var_5);
  var_7 = 30;
  self.owner thread _id_10F92(var_0, var_7);
  self.owner thread _id_10F99(var_0);
  self moveto(var_2, var_3);
  self setscriptablepartstate("bodyFX", "on", 0);
  self _meth_82CB("mp_suniform25_flyin");
  thread _id_10F64();
  thread _id_10F65(var_2, var_3);
  var_9 = 3;
  _id_10F72(::_id_10F69, var_1, var_4, var_6, var_7, 4000, var_9, 1);
  _id_10F72(::_id_10F6C, var_1, var_4, var_6, var_7, 4000, 3, 1);
  _id_10F72(::_id_10F6A, var_1, var_4, var_6, var_7, 2000, 6, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self _meth_83F8();
  self _meth_82CC("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  _id_10F7E(self);
}

_id_10F92(var_0, var_1) {
  self endon("disconnect");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self notify("white_phosphorus_finished");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_10F99(var_0) {
  self endon("disconnect");
  self endon("white_phosphorus_finished");
  level endon("white_phosphorus_end");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_10F64() {
  self endon("death");
  level endon("white_phosphorus_end");
  waitframe();
}

_id_10F65(var_0, var_1) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
}

_id_10F9B(var_0) {
  level endon("wp_zone_succeeded");
  level endon("game_ended");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level waittill("wp_zone_failed");
  }

  level._id_10FA1 = undefined;
}

_id_10F72(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = int(var_3 / var_5);
  var_9 = 0;

  if(!isDefined(var_6)) {
    var_6 = var_8;
  } else {
    var_10 = var_8 - var_6;
    var_9 = int(var_10 / 2);
  }

  if(isDefined(var_7)) {
    var_9 = var_9 + var_7;
  }

  var_11 = anglesToForward(self.angles);
  var_12 = var_2;
  var_13 = 0;

  for(var_14 = 0; var_14 < var_8; var_14++) {
    var_15 = length(var_1 - var_12) / self.speed;

    if(var_14 < var_9) {
      var_12 = var_12 + var_11 * var_5;
      continue;
    }

    var_16 = var_12 - (0, 0, 2000);

    if(var_0 == ::_id_10F6A) {
      var_17 = spawn("script_model", var_1 + (0, 0, 1500));
      var_17 thread _id_10F79(var_15, var_16, var_11, var_4);
      self thread[[var_0]](var_16, var_11, var_15, var_17);
    } else if(var_0 == ::_id_10F6C)
      self thread[[var_0]](var_16, var_11, var_15, var_14);
    else {
      self thread[[var_0]](var_16, var_11, var_15);
    }

    var_12 = var_12 + var_11 * var_5;
    var_13++;

    if(var_13 == var_6) {
      break;
    }
  }
}

_id_10F79(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 = var_1 - var_2 * 3500;
  var_4 = var_1 - var_2 * 1000;
  self moveto(var_1, var_0 + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 + 2);
  self moveto(var_4, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self delete();
}

_id_10F8D(var_0, var_1, var_2) {
  self endon("death");
}

_id_10F69(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_3 = var_0 - var_1 * 3000;
  var_4 = var_0 - var_1 * 2000;
  var_5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  playFX(scripts\engine\utility::getfx("white_phosphorus_inair_explosion"), var_3, var_1);
}

_id_10F6C(var_0, var_1, var_2, var_3) {
  level endon("white_phosphorus_end");
  level endon("game_ended");

  if(!isDefined(self._id_B7B9)) {
    self._id_B7B9 = [];
  }

  if(!isDefined(self._id_B7C9)) {
    self._id_B7C9 = [];
  }

  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.gametype != "arm") {
    var_4 = 0;
  }

  var_5 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000));
  var_6 = var_5["position"];
  var_7 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_9 = 0;

  if(var_9) {
    var_10 = _func_03C5("ks_white_phosphorus_mp_p", var_6, self.angles);
  } else {
    var_10 = spawn("script_model", var_6);
    var_10 setModel("ks_white_phosphorus_mp");
    var_10 setentityowner(self.owner);
  }

  var_10.team = self.team;
  var_10.owner = self.owner;
  var_10.streakinfo = self.streakinfo;
  var_10 thread _id_10F98();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  level thread _id_10F7B(var_10);

  if(istrue(var_4)) {
    var_11 = isDefined(var_3) && var_3 == 3;

    if(istrue(var_11)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
      self._id_B7B9 = scripts\common\utility::_id_B7B6(var_6, 2000);
      self._id_B7C9 = scripts\engine\utility::_id_1BA6(level.players, self._id_B7B9);
      var_10 thread _id_10F90(2000, self._id_B7B9, self._id_B7C9, "s4_firebombing_run_mp");
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::_id_894E()) {
      var_10 setscriptablepartstate("smoke_night", "on", 0);
    } else {
      var_10 setscriptablepartstate("smoke", "on", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
    var_10 thread _id_10F90(2000, var_4, undefined, "s4_firebombing_run_mp");
  }

  level _id_10F5A("smoke", var_10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_7);
  level _id_10F7D("smoke", var_10);
}

_id_10F6A(var_0, var_1, var_2, var_3) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_4 = self.owner;
  var_5 = self.team;
  var_6 = self.angles;
  var_7 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000), self, undefined, 1, 1);
  var_8 = var_7["position"];
  var_9 = var_7["surfacetype"];
  var_10 = isDefined(level._id_10E0A);

  if(istrue(var_10)) {
    level._id_10E0A dontinterpolate();
    level._id_10E0A.owner = var_4;
    level._id_10E0A.team = var_5;
    level._id_10E0A.streakinfo = self.streakinfo;
  }

  var_11 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_12 = _id_10F6D(var_0, var_8, 4, int(250.0));

  foreach(var_14 in var_12) {
    var_15 = 0;

    if(var_15) {
      var_16 = _func_03C5("ks_white_phosphorus_mp_p", var_14._id_5C71, var_6);
    } else {
      var_16 = spawn("script_model", var_14._id_5C71);
      var_16 setModel("ks_white_phosphorus_mp");
      var_16 setentityowner(var_4);
      var_16.angles = var_6;
    }

    var_16.owner = var_4;
    var_16.team = var_5;
    var_16.streakinfo = self.streakinfo;
    var_16._id_EA6A = var_14;
    var_16.weapon_name = "s4_firebombing_run_mp";
    var_16.killcament = var_3;
    var_16 thread _id_10F94("burn");
    var_16 thread _id_10F7C(var_11, "burn", var_9);
    wait(randomfloatrange(0.1, 0.4));
  }

  if(istrue(var_10)) {
    level._id_10E0A.origin = (0, 0, 50000);
  }
}

_id_10F6D(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = self.angles * (0, 1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  var_9 = physics_createcontents(var_8);
  var_10 = -2000;
  var_11 = 0;

  for(var_12 = 0; var_12 < var_2; var_12++) {
    var_13 = var_6 * var_10 + var_7 * var_11;
    var_14 = var_1 + var_6 * var_10;
    var_15 = var_1 + var_13;
    var_16 = scripts\engine\trace::ray_trace(var_15 + (0, 0, var_0[2]), var_15 - (0, 0, 10000), level.characters, var_9);
    var_17 = var_16["position"];
    var_18 = var_1 * (1, 1, 0) + (0, 0, var_17[2]) + var_6 * var_10;
    var_19 = spawnStruct();
    var_19._id_4315 = var_18;
    var_19._id_5C71 = var_17;
    var_4[var_4.size] = var_19;
    var_10 = var_10 + 500;
    var_11 = randomintrange(-750, 750);
  }

  return var_4;
}

_id_10F7C(var_0, var_1, var_2) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.5);
  self._id_BDA3 = 1;
  level _id_10F5A("inner", self);
  self setscriptablepartstate("impact", "on", 0);

  if(isDefined(var_2) && var_2 == "surftype_water") {
    self setscriptablepartstate("flare_death_water", "on", 0);
  } else {
    self setscriptablepartstate("flare", "on", 0);
  }

  var_3 = self._id_EA6A._id_4315 + (0, 0, 10);

  if(isDefined(self.owner)) {
    self radiusdamage(var_3, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "s4_firebombing_run_mp");
  }

  if(isDefined(var_2) && var_2 != "surftype_water") {
    if(isDefined(var_1)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(var_1 == "burn") {
        thread _id_10F8F(300, "s4_firebombing_run_mp");
      } else {
        thread _id_10F8E(300);
      }

      if(!scripts\common\utility::iscp()) {
        scripts\cp_mp\utility\killstreak_utility::_id_8DAE(self.origin, 300, 300, var_0, self.owner, self.team);
        thread _id_10F61();
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
    level _id_10F7D("inner", self, var_1, 1);
    self notify("stop_wp_status_effect");
    self setscriptablepartstate("flare", "off", 0);
    self setscriptablepartstate("flare_death", "on", 0);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread _id_10F60(15);
}

_id_10F61() {
  level endon("game_ended");
  var_0 = self._id_4349;
  self waittill("death");
  scripts\cp_mp\utility\killstreak_utility::_id_8DB2(var_0);
}

_id_10F60(var_0) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = 0;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(var_1) {
    self _meth_86BE();
  } else {
    self delete();
  }
}

_id_10F90(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_B7B7 = [];

  if(isDefined(var_1) && isDefined(var_2)) {
    thread _id_10F5F(0.15, 2000, var_1, var_3);
    thread _id_10F5F(0.25, undefined, var_2, var_3);
  } else {
    for(;;) {
      var_4 = scripts\common\utility::_id_B7B6(self.origin, var_0);
      var_5 = scripts\engine\utility::_id_1BA6(level.players, var_4);

      foreach(var_7 in var_4) {
        if(var_7 scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_gasmask")) {
          continue;
        }
        if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(!_id_10F77("smoke", var_7, self)) {
          _id_10F59("smoke", var_7);
        }

        if(!istrue(var_7._id_10F9F)) {
          var_7 thread _id_10F85(self, var_3);
        }
      }

      foreach(var_7 in var_5) {
        if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(istrue(var_7._id_10F9F) && _id_10F77("smoke", var_7, self)) {
          var_7 thread _id_10F8B(self);
        }
      }

      waitframe();
    }
  }
}

_id_10F70(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(distance2dsquared(self.origin, var_4.origin) <= var_1 * var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_10F5F(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(var_0) && var_0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  var_4 = var_2;

  if(isDefined(var_1) && var_1 > 0) {
    var_4 = _id_10F70(var_2, var_1);
  }

  foreach(var_6 in var_4) {
    if(var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_10F59("smoke", var_6);

      if(!istrue(var_6._id_10F9F)) {
        var_6 thread _id_10F85(self, var_3);
      }
    }

    var_6 thread _id_10F86(self, var_3);
  }
}

_id_10F8F(var_0, var_1) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self._id_B7BA = [];

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, var_3.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_3 getEye(), self.origin + (0, 0, 30), var_3)) {
        if(!istrue(var_3._id_10F9D)) {
          var_3 thread _id_10F83(self, self.owner, var_1);
        }

        continue;
      }

      if(istrue(var_3._id_10F9D) && _id_10F77("inner", var_3, self)) {
        var_3 _id_10F89(self);
      }
    }

    waitframe();
  }
}

_id_10F8E(var_0) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self._id_B7BA = [];

  for(;;) {
    foreach(var_2 in level.players) {
      if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, var_2.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_2 getEye(), self.origin + (0, 0, 30), var_2)) {
        if(!istrue(var_2._id_10F9C)) {
          var_2 _id_10F82(self);
        }

        continue;
      }

      if(istrue(var_2._id_10F9C) && _id_10F77("inner", var_2, self)) {
        var_2 _id_10F88(self);
      }
    }

    waitframe();
  }
}

_id_10F5A(var_0, var_1) {
  if(var_0 == "smoke") {
    level._id_0F6C[level._id_0F6C.size] = var_1;
  } else {
    level._id_0F6B[level._id_0F6B.size] = var_1;
  }
}

_id_10F75(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "smoke") {
    foreach(var_4 in level._id_0F6C) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level._id_0F6B) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_10F7D(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_0 == "smoke") {
    foreach(var_6 in level._id_0F6C) {
      if(var_6 == var_1) {
        continue;
      }
      var_4[var_4.size] = var_6;
    }

    level._id_0F6C = var_4;

    if(isDefined(var_1._id_B7B7)) {
      foreach(var_9 in var_1._id_B7B7) {
        if(!_id_10F76("smoke", var_9)) {
          var_9 thread _id_10F8B(var_1);
        }
      }
    }

    if(level._id_0F6C.size <= 0) {
      level._id_10FA1 = undefined;
    }
  } else {
    foreach(var_6 in level._id_0F6B) {
      if(var_6 == var_1) {
        continue;
      }
      var_4[var_4.size] = var_6;
    }

    level._id_0F6B = var_4;

    if(isDefined(var_1._id_B7BA)) {
      foreach(var_9 in var_1._id_B7BA) {
        if(!_id_10F76("inner", var_9)) {
          if(var_2 == "burn") {
            var_9 thread _id_10F89(var_1);
            continue;
          }

          var_9 thread _id_10F88(var_1);
        }
      }
    }
  }

  if(istrue(var_3)) {
    return;
  }
  var_15 = 0;

  if(var_15) {
    var_1 _meth_86BE();
  } else {
    var_1 delete();
  }
}

_id_10F76(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "smoke") {
    foreach(var_4 in level._id_0F6C) {
      if(_id_10F77(var_0, var_1, var_4)) {
        var_2 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level._id_0F6B) {
      if(_id_10F77(var_0, var_1, var_4)) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_10F77(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = undefined;

  if(var_0 == "smoke") {
    var_4 = var_2._id_B7B7;
  } else {
    var_4 = var_2._id_B7BA;
  }

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(var_6 == var_1) {
        var_3 = 1;
        break;
      }
    }
  }

  return var_3;
}

_id_10F59(var_0, var_1) {
  if(var_0 == "smoke") {
    self._id_B7B7[self._id_B7B7.size] = var_1;
  } else {
    self._id_B7BA[self._id_B7BA.size] = var_1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "codcasterAddPhosphorousStatusEffect")) {
    var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "codcasterAddPhosphorousStatusEffect")]]();
  }
}

_id_10F80(var_0, var_1) {
  if(var_0 == "smoke") {
    var_2 = [];

    foreach(var_4 in self._id_B7B7) {
      if(var_4 == var_1) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self._id_B7B7 = var_2;
  } else {
    var_2 = [];

    foreach(var_4 in self._id_B7BA) {
      if(var_4 == var_1) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self._id_B7BA = var_2;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "codcasterRemovePhosphorousStatusEffect")) {
    var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "codcasterRemovePhosphorousStatusEffect")]]();
  }
}

_id_10F7F(var_0, var_1) {
  if(var_0 == "smoke") {
    foreach(var_3 in level._id_0F6C) {
      if(_id_10F77(var_0, var_1, var_3)) {
        var_3 _id_10F80(var_0, var_1);
      }
    }
  } else {
    foreach(var_3 in level._id_0F6B) {
      if(_id_10F77(var_0, var_1, var_3)) {
        var_3 _id_10F80(var_0, var_1);
      }
    }
  }
}

_id_10F86(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    var_0 _id_10F59("smoke", self);
    thread _id_10F85(var_0, var_1);
  }
}

_id_10F85(var_0, var_1) {
  var_0 endon("death");
  self endon("death_or_disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  self._id_10F9F = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "playing") {
    waitframe();
  }

  thread _id_10F8A(var_0);
  thread _id_10F78(var_0);
  _func_019D(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_2 = 1;

    if(istrue(var_2)) {
      return;
    }
  }

  self._id_10FA0 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
  }

  if(self.health > 10 && var_1 != "s4_smoke_gbr_n77_mp") {
    var_4 = _id_10F6E();
    _id_10F5E(var_4, var_0);
  }

  if(!_id_10F74()) {
    _id_525A();
  }
}

_id_10F5E(var_0, var_1) {
  if(istrue(self._id_61D4)) {
    return;
  }
  if(!isDefined(self._id_10FA0)) {
    self._id_10FA0 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
    }
  }

  self dodamage(var_0, self.origin, var_1.owner, var_1, "MOD_EXPLOSIVE", "s4_firebombing_run_mp");
}

_id_10F87(var_0) {
  var_0 endon("death");
  self endon("death");
  level endon("game_ended");

  while(istrue(self._id_10F9F)) {
    wait(randomfloatrange(1, 3));
  }
}

_id_10F8A(var_0) {
  var_0 endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  _id_10F8B(var_0, 1);
}

_id_10F8B(var_0, var_1) {
  level endon("game_ended");

  if(istrue(var_1)) {
    level _id_10F7F("smoke", self);
  } else {
    var_0 _id_10F80("smoke", self);
  }

  if(!_id_10F76("smoke", self) || istrue(var_1)) {
    if(istrue(self._id_10F9F)) {
      self._id_10F9F = undefined;

      if(scripts\cp_mp\utility\player_utility::_isalive()) {
        self visionsetnakedforplayer("", 2);
      }

      _func_02D1(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

      if(istrue(self._id_10FA0)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_block_health_regen");
        }

        self._id_10FA0 = undefined;
      }

      _id_4ACA();
      self notify("stop_disorient");
    }
  }
}

_id_10F83(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");

  if(level.teambased && self.team == var_0.team && self != var_0.owner) {
    var_3 = 1;

    if(istrue(var_3)) {
      return;
    }
  }

  var_0 _id_10F59("inner", self);
  self._id_10F9D = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](undefined, "wp_active");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "enqueueCorpsetableFunc")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "enqueueCorpsetableFunc")]]("white_phosphorus_burning", ::_id_10F7A);
  }

  thread _id_10F8C(var_0);

  if(isDefined(var_2) && var_2 == "s4_smoke_gbr_n77_mp") {
    var_5 = 5;
    var_6 = 5;
    var_7 = 20;
  } else {
    var_5 = 10;
    var_6 = 1;
    var_7 = 20;
  }

  thread _id_10F67(var_5, var_1, var_0, var_2);

  for(;;) {
    if(self.health <= var_5) {
      self notify("stop_degen");
    }

    self dodamage(var_5, self.origin, var_1, var_0, "MOD_FIRE", var_2);
    wait 0.5;
    var_5 = var_5 + var_6;

    if(var_5 >= var_7) {
      var_5 = var_7;
    }

    self._id_8F9E = gettime();
  }
}

_id_10F67(var_0, var_1, var_2, var_3) {
  self waittill("stop_wp_burn");

  for(;;) {
    if(isDefined(self._id_8F9E) && self._id_8F9E + 500 <= gettime()) {
      self dodamage(var_0, self.origin, var_1, var_2, "MOD_FIRE", var_3);
      _id_10F81();
      break;
    }

    if(!isDefined(self._id_8F9E)) {
      _id_10F81();
      break;
    }

    waitframe();
  }
}

_id_10F89(var_0) {
  var_0 _id_10F80("inner", self);

  if(!_id_10F76("inner", self)) {
    self notify("stop_wp_burn");
  }
}

_id_10F82(var_0) {
  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_1 = 1;

    if(istrue(var_1)) {
      return;
    }
  }

  var_0 _id_10F59("inner", self);
  self._id_10F9C = 1;
  thread _id_10F8C(var_0);
  self visionsetnakedforplayer("wp_flare", 1);
}

_id_10F88(var_0) {
  var_0 _id_10F80("inner", self);

  if(!_id_10F76("inner", self)) {
    _id_10F81();
  }
}

_id_10F8C(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_10F81(1);
}

_id_10F81(var_0) {
  if(istrue(self._id_10F9D)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](undefined, "wp_active");
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "dequeueCorpsetableFunc")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "dequeueCorpsetableFunc")]]("white_phosphorus_burning");
      }
    }

    self._id_10F9D = undefined;
  }

  if(istrue(self._id_10F9C)) {
    self._id_10F9C = undefined;

    if(_id_10F76("smoke", self)) {
      self visionsetnakedforplayer(_id_10F71(), 1);
    } else {
      self visionsetnakedforplayer("", 1);
    }
  }

  if(istrue(var_0)) {
    level _id_10F7F("inner", self);
  }
}

_id_10F7E(var_0) {
  if(isDefined(var_0._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0._id_9F26);
    }

    var_0._id_9F26 = undefined;
  }

  var_0 delete();
}

_id_10F71() {
  var_0 = "wp_smoke";
  var_1 = "wp_smoke_night";
  var_2 = var_0;

  if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::_id_894E()) {
    var_2 = var_1;
  }

  return var_2;
}

_id_10F78(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  self endon("death");
  level endon("game_ended");
  var_1 = undefined;

  for(;;) {
    if(istrue(self._id_10F9F)) {
      var_2 = _id_10F71();

      if(!isDefined(var_1) || var_2 != var_1) {
        var_1 = var_2;
        self visionsetnakedforplayer(var_2, 2);
      }
    }

    waitframe();
  }
}

_id_10F6E() {
  var_0 = 50;
  var_1 = 10;

  if(_id_10F74()) {
    var_0 = var_0 * 0.5;
  }

  var_2 = self.health;
  var_3 = var_2 - var_0;

  if(var_3 < var_1) {
    var_0 = var_0 - (var_1 - var_3);
  }

  return var_0;
}

_id_10F7A(var_0) {
  var_0 setscriptablepartstate("wp_burning", "flareUp", 0);
}

_id_10F74() {
  return isDefined(self.perks) && isDefined(self.perks["specialty_tac_resist"]);
}

_id_525A() {
  if(!isDefined(self._id_983B)) {
    self._id_983B = 0;
  }

  self._id_983B++;

  if(self._id_983B == 1) {
    thread _id_E6E3();
  }
}

_id_4ACA() {
  if(!isDefined(self._id_983B)) {
    return;
  }
  self._id_983B--;

  if(self._id_983B == 0) {
    thread _id_E915();
    self._id_983B = undefined;
  }
}

_id_E6E3() {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");
  level endon("game_ended");

  for(;;) {
    var_0 = randomfloatrange(5, 7);

    if(!_id_983C()) {
      var_1 = "gas_player_cough";

      if(scripts\engine\utility::cointoss()) {
        var_1 = "gas_player_gag";
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, var_1);
      }
    }

    wait(var_0);
  }
}

_id_E915() {
  self notify("clearLoopingCoughAudio");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "gas_player_exit");
  }
}

_id_525B() {
  if(!isDefined(self._id_983D)) {
    self._id_983D = 0;
  }

  self._id_983D++;
}

_id_4ACB() {
  if(!isDefined(self._id_983D)) {
    return;
  }
  self._id_983D--;
}

_id_983C() {
  return isDefined(self._id_983D) && self._id_983D > 0;
}

_id_3956() {
  self notify("clearLoopingCoughAudio");
  self._id_983B = undefined;
  self._id_983D = undefined;
}

_id_10F7B(var_0) {
  var_0 setscriptablepartstate("impact_center", "on", 0);
  waitframe();
  var_0 setscriptablepartstate("impact_center", "off", 0);
}