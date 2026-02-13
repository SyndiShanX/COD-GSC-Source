/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2649.gsc
*************************************************/

init() {
  if(!isDefined(level._id_B192)) {
    level._id_B192 = [];
  }

  if(!isDefined(level._id_B189)) {
    level._id_B189 = [];
  }

  level._id_5A29 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._id_605C = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._id_605D = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._id_605E = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._id_605F = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

_id_6A4E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 + var_1 * (-1 * var_2);
  var_9 = var_0 + var_1 * var_2;

  if(var_3) {
    var_8 = var_8 * (1, 1, 0);
    var_9 = var_9 * (1, 1, 0);
  }

  var_8 = var_8 + (0, 0, var_4);
  var_9 = var_9 + (0, 0, var_4);
  var_10 = length(var_8 - var_9);
  var_11 = var_10 / var_5;
  var_10 = abs(0.5 * var_10 + var_6);
  var_12 = var_10 / var_5;
  var_13["startPoint"] = var_8;
  var_13["endPoint"] = var_9;
  var_13["attackTime"] = var_12;
  var_13["flyTime"] = var_11;
  return var_13;
}

_id_4CAE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_B195(var_0, var_1, var_3, var_7, var_8);
  var_9 endon("death");
  var_10 = 150;
  var_11 = var_4 + ((randomfloat(2) - 1) * var_10, (randomfloat(2) - 1) * var_10, 0);
  var_9 _id_B18F(var_11, var_6, var_5, var_8);
  var_9 _id_B188();
}

_id_B195(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  var_5 = 100;
  var_6 = var_2 + ((randomfloat(2) - 1) * var_5, (randomfloat(2) - 1) * var_5, 0);
  var_7 = level._id_B189[var_4];
  var_8 = undefined;
  var_8 = spawn("script_model", var_6);
  var_8.team = var_1.team;
  var_8.origin = var_6;
  var_8.angles = vectortoangles(var_3);
  var_8._id_936C = var_0;
  var_8.streakname = var_4;
  var_8.owner = var_1;
  var_8 setModel(var_7._id_9FDB[var_1.team]);

  if(isDefined(var_7._id_3B09)) {
    var_8 _id_D616(var_7._id_3B09, var_7._id_3B08);
  }

  var_8 thread _id_742F();
  var_8 thread _id_7431();
  _id_E733(var_8);

  if(!isDefined(var_7._id_A597)) {
    var_8 thread _id_B8B9();
  }

  var_8 playLoopSound(var_7._id_7D8C);
  var_8 _id_4005(var_4);
  return var_8;
}

_id_B18F(var_0, var_1, var_2, var_3) {
  var_4 = level._id_B189[var_3];
  self moveto(var_0, var_1, 0, 0);

  if(isDefined(var_4._id_AA73)) {
    self thread[[var_4._id_AA73]](var_0, var_1, var_2, self.owner, var_3);
  }

  if(isDefined(var_4._id_E01D)) {
    thread _id_B8E7(var_4._id_E01D, 0.5 * var_1);
  }

  wait(0.65 * var_1);

  if(isDefined(var_4._id_ACA5)) {
    self stoploopsound();
    self playLoopSound(var_4._id_ACA5);
  }

  if(isDefined(var_4._id_ACA4)) {
    self _meth_82CC(var_4._id_ACA4);
  }

  wait(0.35 * var_1);
}

_id_B188() {
  var_0 = level._id_B189[self.streakname];

  if(isDefined(var_0._id_AAF1)) {
    thread[[var_0._id_AAF1]](self.owner, self, self.streakname);
  }

  if(isDefined(self._id_5FBE)) {
    _id_07F9::_id_C799(self._id_5FBE);
    _id_07F9::_id_C799(self._id_542F);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  _id_E945(self);
  self notify("delete");
  self delete();
}

_id_7431() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  var_0 = anglesToForward(self.angles) * 200;
  playFX(level._id_5A29, self.origin, var_0);
  thread _id_B188();
}

_id_742F() {
  self endon("end_remote");
  _id_07C3::_id_A0FF(800, "helicopter", ::_id_7433, ::_id_A007, 1);
}

_id_A007(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_6 = _id_07C3::_id_746C(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_741D(var_2, var_3, var_6);
  return var_6;
}

_id_7433(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = level._id_B189[self.streakname];
  _id_07C3::_id_AB18(self.streakname, var_1, var_2, var_3, var_4, var_5._id_CC16, var_5._id_484C, var_5._id_2F66);
}

_id_B8B9() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level._id_605C, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level._id_605C, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level._id_605D, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level._id_605D, self, "tag_left_wingtip");
  wait 0.5;
  playFXOnTag(level._id_605F, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level._id_605E, self, "tag_left_wingtip");
}

_id_6C35() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();

  if(isDefined(var_0)) {
    return var_0.origin[2];
  } else {
    var_1 = 950;
    return var_1;
  }
}

_id_6C34(var_0) {
  var_1 = spawnStruct();
  var_1.height = _id_6C35();
  var_2 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();

  if(isDefined(var_2) && isDefined(var_2._id_039B) && var_2._id_039B == "fixedposition") {
    var_1._id_EEF5 = var_2.origin;
    var_1._id_5CF2 = anglesToForward(var_2.angles);

    if(randomint(2) == 0) {
      var_1._id_5CF2 = var_1._id_5CF2 * -1;
    }
  } else {
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoright(self.angles);
    var_1._id_EEF5 = self.origin + var_0 * var_3;
    var_1._id_5CF2 = -1 * var_4;
  }

  return var_1;
}

_id_6A21(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

_id_E733(var_0) {
  var_1 = var_0 getentitynumber();
  level._id_B192[var_1] = var_0;
}

_id_E945(var_0) {
  var_1 = var_0 getentitynumber();
  level._id_B192[var_1] = undefined;
}

_id_D050(var_0, var_1, var_2) {
  var_3 = level._id_9AC7 / 6.46875;

  if(level.splitscreen) {
    var_3 = var_3 * 1.5;
  }

  var_4 = level._id_B189[var_1];

  if(isDefined(var_4._id_D06E)) {
    self playlocalsound(game["voice"][self.team] + var_4._id_D06E);
  }

  scripts\mp\utility\killstreak::_id_0B66(var_1, "map_artillery_selector", var_4._id_35E6, var_3);
  self endon("stop_location_selection");
  self waittill("confirm_location", var_5, var_6);

  if(!var_4._id_35E6) {
    var_6 = randomint(360);
  }

  self _meth_82EE(0, 0.3);

  if(isDefined(var_4._id_7D8D)) {
    self playlocalsound(game["voice"][self.team] + var_4._id_7D8D);
  }

  self thread[[var_2]](var_0, var_5, var_6, var_1);
  return 1;
}

_id_D616(var_0, var_1) {
  var_2 = _id_07F9::_id_C57D(1);

  if(var_2 != -1) {
    _id_07F9::_id_A867(var_2, "active", (0, 0, 0), var_0);
    _id_07F9::_id_FB94(var_2, self);
  }

  self._id_5FBE = var_2;
  var_3 = _id_07F9::_id_C57D(1);

  if(var_3 != -1) {
    _id_07F9::_id_A867(var_3, "active", (0, 0, 0), var_1);
    _id_07F9::_id_FB94(var_3, self);
  }

  self._id_542F = var_3;

  if(level.teambased) {
    if(var_2 != -1) {
      _id_07F9::_id_A8CA(var_2, self.team);
    }

    if(var_3 != -1) {
      _id_07F9::_id_A8CA(var_3, scripts\mp\utility\game::_id_6BE2(self.team)[0]);
    }
  } else {
    if(var_2 != -1) {
      _id_07F9::_id_A88D(var_2, self.owner);
    }

    if(var_3 != -1) {
      _id_07F9::_id_A88D(var_3, self.owner);
    }
  }
}

_id_B8E7(var_0, var_1) {
  self endon("death");
  wait(var_1);
  self _meth_827E(var_0);
}

_id_4005(var_0) {
  var_1 = level._id_B189[var_0];

  if(isDefined(var_1._id_8D6B)) {
    var_2 = anglesToForward(self.angles);
    var_3 = spawn("script_model", self.origin + (0, 0, 100) - var_2 * 200);
    var_3._id_E72D = gettime();
    var_3 _meth_8375("airstrike");
    var_3 linkto(self, "tag_origin", var_1._id_8D6B, (0, 0, 0));
    self.killcament = var_3;
  }
}