/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_shellshock.gsc
*****************************************************/

init() {}

_id_8AF0(var_0, var_1) {
  if(maps\mp\_flashgrenades::isflashbanged()) {
    return;
  }
  if(maps\mp\_utility::isusingremote() || maps\mp\_utility::_id_572D()) {
    return;
  }
  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(!maps\mp\_utility::_hasperk("specialty_stun_resistance") && (!isDefined(self._id_4B64) || !self._id_4B64))
        self _meth_8182("frag_grenade_mp", 0.5);
    }
  }
}

_id_36DC() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

_id_485C() {
  thread _id_36DC();
  self endon("make_dud");
  self endon("end_explode");
  var_0 = self._id_0117;
  var_1 = undefined;

  if(isDefined(var_0))
    var_1 = var_0.team;

  self waittill("explode", var_2);

  if(_func_367()) {} else {
    _func_1BB("grenade_rumble", var_2);
    _func_17F(0.4, 0.75, var_2, 256);
  }

  foreach(var_4 in level.players) {
    if(!isalive(var_4) || var_4 maps\mp\_utility::isusingremote() || var_4 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(distancesquared(var_2, var_4.origin) > 22500) {
      continue;
    }
    if(isDefined(level.teambased) && level.teambased && isDefined(var_0) && isDefined(var_1) && isDefined(var_4.team) && var_4 != var_0 && var_4.team == var_1) {
      continue;
    }
    if(var_4 _meth_81D7(var_2)) {
      if(!var_4 maps\mp\_utility::_hasperk("specialty_stun_resistance"))
        var_4 _meth_8182("ear_ring_mp", 1.0, 0.0, 0);
    }

    var_4 _meth_82FF("ui_hud_shake", 1);
  }
}

_id_2F13(var_0) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];

  if(var_4 > 0 && var_4 > 0.5) {
    self _meth_82FF("ui_fullscreen_dirt_left", 1);
    common_scripts\utility::_id_A710(var_6, 2.0);
  } else if(_func_0AE(var_4) < 0.866) {
    if(var_5 > 0) {
      self _meth_82FF("ui_fullscreen_dirt_left", 1);
      common_scripts\utility::_id_A710(var_6, 2.0);
    } else {
      self _meth_82FF("ui_fullscreen_dirt_left", 1);
      common_scripts\utility::_id_A710(var_6, 2.0);
    }
  }
}

_id_17FE(var_0) {
  self notify("bloodEffect");
  self endon("bloodEffect");
  self endon("disconnect");

  if(!maps\mp\_utility::isreallyalive(self)) {
    return;
  }
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];

  if(var_4 > 0 && var_4 > 0.5)
    common_scripts\utility::_id_A710(var_6, 7.0);
  else if(_func_0AE(var_4) < 0.866) {
    if(var_5 > 0)
      common_scripts\utility::_id_A710(var_6, 7.0);
    else
      common_scripts\utility::_id_A710(var_6, 7.0);
  }
}

_id_17FF() {
  self endon("disconnect");
  wait 0.5;

  if(isalive(self))
    common_scripts\utility::waittill_notify_or_timeout("death", 1.5);
}

_id_1DEE() {
  thread _id_36DC();
  self endon("end_explode");
  self endon("make_dud");
  var_0 = self._id_0117;
  var_1 = self._id_0117.team;
  self waittill("explode", var_2);
  _func_1BB("grenade_rumble", var_2);
  _func_17F(0.4, 0.75, var_2, 256);

  foreach(var_4 in level.players) {
    if(var_4 maps\mp\_utility::isusingremote() || var_4 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(distance(var_2, var_4.origin) > 150) {
      continue;
    }
    if(isDefined(level.teambased) && level.teambased && isDefined(var_0) && isDefined(var_1) && isDefined(var_4.team) && var_4 != var_0 && var_4.team == var_1) {
      continue;
    }
    if(var_4 _meth_81D7(var_2))
      var_4 _meth_8182("ear_ring_mp", 1.0, 0.0, 0);

    var_4 _meth_82FF("ui_hud_shake", 1);
  }
}

_id_15C5() {
  var_0 = self.origin;
  _func_1BB("grenade_rumble", var_0);
  _func_17F(0.4, 0.5, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }
    if(var_2 _meth_81D7(var_0))
      var_2 _meth_82FF("ui_hud_shake", 1);
  }
}

_id_0FD9() {
  var_0 = self.origin;
  _func_1BB("artillery_rumble", self.origin);
  _func_17F(0.7, 0.5, self.origin, 800);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 _meth_81D7(var_0))
      var_2 _meth_82FF("ui_hud_shake", 1);
  }
}

_id_938E(var_0) {
  _func_1BB("grenade_rumble", var_0);
  _func_17F(0.6, 0.6, var_0, 2000);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 1000) {
      continue;
    }
    if(var_2 _meth_81D7(var_0))
      var_2 _meth_82FF("ui_hud_shake", 1);
  }
}

_id_0B94(var_0) {
  _func_1BB("artillery_rumble", var_0);
  _func_17F(0.7, 0.75, var_0, 1000);

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\_utility::isusingremote() || var_2 maps\mp\_utility::_id_572D()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 900) {
      continue;
    }
    if(var_2 _meth_81D7(var_0))
      var_2 _meth_82FF("ui_hud_shake", 1);
  }
}