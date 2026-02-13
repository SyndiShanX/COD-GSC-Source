/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2025.gsc
*************************************************/

_id_EED4() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  _id_EEC1();

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename == "iw8_la_kgolf_mp" && _id_EECE()) {
      self._id_EEB5._id_E942 = 0;
      thread _id_EED0();
    } else
      self._id_EEB5._id_E942 = 1;

    self waittill("weapon_change");
  }
}

_id_EEC1() {
  self._id_EEB5 = spawnStruct();
  self._id_EEB5._id_E75E = [];
  self._id_EEB5._id_E75E["off"] = [];
  self._id_EEB5._id_E75E["off"]["enter"] = ::_id_EEC3;
  self._id_EEB5._id_E75E["off"]["update"] = ::_id_EEC5;
  self._id_EEB5._id_E75E["off"]["exit"] = ::_id_EEC4;
  self._id_EEB5._id_E75E["scanning"] = [];
  self._id_EEB5._id_E75E["scanning"]["enter"] = ::_id_EECC;
  self._id_EEB5._id_E75E["scanning"]["update"] = ::_id_EECD;
  self._id_EEB5._id_E75E["hold"] = [];
  self._id_EEB5._id_E75E["hold"]["enter"] = ::_id_EEBE;
  self._id_EEB5._id_E75E["hold"]["update"] = ::_id_EEC0;
  self._id_EEB5._id_E75E["hold"]["exit"] = ::_id_EEBF;
}

_id_EECA() {
  self._id_EEB5._id_11B8 = undefined;
  self._id_EEB5.target = undefined;
  self._id_EEB5._id_9707 = undefined;
  self._id_EEB5._id_1031C = undefined;
  self._id_EEB5._id_873B = 0;

  if(isDefined(self._id_EEB5._id_9144)) {
    self._id_EEB5._id_9144 _id_078E::_id_4807();
    self._id_EEB5._id_9144 delete();
  }

  self._id_EEB5._id_9144 = undefined;
  self._id_EEB5._id_E747 = undefined;
  self._id_EEB5._id_BECF = undefined;
}

_id_EEC3(var_0) {
  if(isDefined(var_0)) {
    _id_079B::_id_EEDE(self._id_EEB5._id_EED6);
    self._id_EEB5._id_EED6 = undefined;
  }
}

_id_EEC5() {
  if(self playerads() >= 0.6) {
    _id_EEC9("scanning");
  }
}

_id_EEC4() {}

_id_EECC(var_0) {
  self._id_EEB5._id_11B8 = gettime() + 100;

  if(isDefined(var_0) && var_0 == "off") {
    self._id_EEB5._id_EED6 = _id_079B::_id_EEDF("kgolftarget", self, undefined, self);
  }
}

_id_EECD() {
  if(gettime() < self._id_EEB5._id_11B8) {
    return;
  }
  var_0 = _id_EECB();

  if(isDefined(var_0)) {
    self._id_EEB5.target = var_0;
    _id_EEC9("hold");
  }
}

_id_EEBE(var_0) {
  self._id_EEB5._id_9707 = gettime();
  self._id_EEB5._id_98AD = 0;
  self._id_EEB5._id_9144 = scripts\engine\utility::spawn_tag_origin();
  self._id_EEB5._id_9144 _id_078E::_id_C2B6(1);
  self._id_EEB5._id_9144 show();
  _id_EED1();
}

_id_EEC0() {
  if(!_id_EEB8(self._id_EEB5.target)) {
    _id_EEC9("scanning");
    return;
  } else {
    var_0 = _id_EEBB(self._id_EEB5.target);

    if(isDefined(var_0)) {
      self._id_EEB5._id_9144 moveto(var_0, 0.05);
    }
  }

  var_1 = self _meth_845E(self._id_EEB5._id_9144.origin, 55, 40);

  if(var_1 && !self._id_EEB5._id_873B) {
    self._id_EEB5._id_873B = 1;
    thread _id_EEB6();
  } else if(!var_1 && self._id_EEB5._id_873B) {
    self._id_EEB5._id_873B = 0;
    self notify("stop_airburst_think");
  }
}

_id_EEBF() {
  _id_EED2();

  if(isDefined(self._id_EEB5._id_9144)) {
    self._id_EEB5._id_9144 _id_078E::_id_4807();
    self._id_EEB5._id_9144 delete();
  }

  self._id_EEB5._id_9144 = undefined;
  self._id_EEB5._id_873B = 0;
  self notify("stop_airburst_think");
}

_id_EEC8() {
  if(self._id_EEB5._id_E747 != "off") {
    if(self playerads() < 0.6) {
      _id_EEC9("off");
    }
  }
}

_id_EEC6() {}

_id_EEC7() {
  if(isDefined(self._id_EEB5._id_E747) && self._id_EEB5._id_E747 != "off") {
    _id_EEBA("off");
  }
}

_id_EEBB(var_0) {
  var_1 = (0, 0, 0);

  if(var_0.classname == "script_vehicle") {
    var_1 = var_0 _meth_8431();
  } else if(scripts\mp\utility\entity::_id_8889(var_0) || scripts\mp\utility\entity::_id_8ABB(var_0)) {
    var_1 = var_0._id_04DF;
  }

  var_2 = var_0.origin + _id_EEBD(var_0);
  var_3 = self getEye();
  var_4 = 4000;
  var_5 = _func_02F9(var_3, (0, 0, 0), var_4, var_2, var_1);

  if(isDefined(var_5)) {
    return var_5;
  }

  return undefined;
}

_id_EEBD(var_0) {
  var_1 = (0, 0, 0);

  if(scripts\mp\utility\entity::_id_87AE(var_0)) {
    var_1 = (0, 0, -50);
  } else if(scripts\mp\utility\entity::_id_8A80(var_0)) {
    var_1 = (0, 0, -100);
  } else if(scripts\mp\utility\entity::_id_8889(var_0)) {
    var_1 = (0, 0, 40);
  } else if(scripts\mp\utility\entity::_id_87B4(var_0)) {
    var_1 = (0, 0, 40);
  } else if(scripts\mp\utility\entity::_id_89D2(var_0)) {
    var_1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::_id_8A1A(var_0)) {
    var_1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::_id_89D3(var_0)) {
    var_1 = (0, 0, 30);
  }

  return var_1;
}

_id_EEB8(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self _meth_845E(var_0.origin, 55, 240);

  if(!var_1) {
    return 0;
  }

  if(!_id_EECF(var_0)) {
    return 0;
  }

  return 1;
}

_id_EEC2(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

_id_EEC9(var_0) {
  self._id_EEB5._id_BECF = var_0;
}

_id_EEBC() {
  return self._id_EEB5._id_BECF;
}

_id_EEBA(var_0) {
  if(isDefined(self._id_EEB5._id_E747)) {}

  var_1 = self._id_EEB5._id_E747;

  if(isDefined(var_1) && isDefined(self._id_EEB5._id_E75E[var_1]["exit"])) {
    self[[self._id_EEB5._id_E75E[var_1]["exit"]]]();
  }

  self._id_EEB5._id_E747 = var_0;

  if(isDefined(self._id_EEB5._id_E75E[var_0]["enter"])) {
    self[[self._id_EEB5._id_E75E[var_0]["enter"]]](var_1);
  }

  self._id_EEB5._id_BECF = undefined;
}

_id_EECE() {
  return !_id_078D::_id_85B3();
}

_id_EED0() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self notify("targetLead_think");
  self endon("targetLead_think");
  _id_EECA();
  _id_EEBA("off");
  _id_EEC6();
  thread _id_EEB9();

  for(;;) {
    if(isDefined(self._id_EEB5._id_E942) && self._id_EEB5._id_E942 || !_id_EECE()) {
      self notify("targetLead_stop");
      _id_EEC7();
      return;
    }

    _id_EEC8();
    var_0 = _id_EEBC();

    if(isDefined(var_0)) {
      _id_EEBA(var_0);
    }

    self[[self._id_EEB5._id_E75E[self._id_EEB5._id_E747]["update"]]]();
    wait 0.05;
  }
}

_id_EEB9() {
  self endon("targetLead_stop");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "faux_spawn");
  _id_EEC7();
}

_id_EECB() {
  var_0 = scripts\mp\weapons::_id_96FE();

  if(var_0.size != 0) {
    var_1 = [];

    foreach(var_3 in var_0) {
      var_4 = self _meth_845E(var_3.origin, 55, 240);

      if(var_4) {
        var_1[var_1.size] = var_3;
      }
    }

    if(var_1.size != 0) {
      var_6 = _func_0204(var_1, self.origin);

      if(_id_EED3(var_6[0])) {
        return var_6[0];
      }
    }
  }

  return undefined;
}

_id_EED3(var_0) {
  var_1 = self getEye();
  var_2 = var_0 _meth_8174(0, 0, 0);
  var_3 = _func_0202(var_1, var_2, 0, var_0);

  if(var_3) {
    return 1;
  }

  var_4 = var_0 _meth_8174(1, 0, 0);
  var_3 = _func_0202(var_1, var_4, 0, var_0);

  if(var_3) {
    return 1;
  }

  var_5 = var_0 _meth_8174(-1, 0, 0);
  var_3 = _func_0202(var_1, var_5, 0, var_0);

  if(var_3) {
    return 1;
  }

  return 0;
}

_id_EECF(var_0) {
  if(_id_EED3(var_0)) {
    self._id_EEB5._id_98AD = 0;
    return 1;
  }

  if(self._id_EEB5._id_98AD == 0) {
    self._id_EEB5._id_98AD = gettime();
  }

  var_1 = gettime() - self._id_EEB5._id_98AD;

  if(var_1 >= 500) {
    return 0;
  }

  return 1;
}

_id_EEB6() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("stop_airburst_think");
  self waittill("missile_fire", var_0);

  if(isDefined(self._id_EEB5.target)) {
    var_0 thread _id_EEB7(self._id_EEB5.target, self);
  }
}

_id_EEB7(var_0, var_1) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_0)) {
      iprintlnbold("targetEnt undefined");
      return;
    }

    var_2 = distance(var_1.origin, var_0.origin);
    var_3 = distance(var_1.origin, self.origin);

    if(var_3 > var_2) {
      self detonate();
      iprintlnbold("explode");
    }

    wait 0.05;
  }
}

_id_EED1() {
  _func_0368(self._id_EEB5._id_EED6, self._id_EEB5.target);
  _func_036A(self._id_EEB5._id_EED6, self._id_EEB5.target, 1);
  _func_0368(self._id_EEB5._id_EED6, self._id_EEB5._id_9144);
  _func_036A(self._id_EEB5._id_EED6, self._id_EEB5._id_9144, 0);
}

_id_EED2() {
  _func_0369(self._id_EEB5._id_EED6, self._id_EEB5.target);
  _func_0369(self._id_EEB5._id_EED6, self._id_EEB5._id_9144);
}