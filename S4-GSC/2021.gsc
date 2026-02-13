/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2021.gsc
*************************************************/

_id_8BA1() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  _id_8B8C();

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename == "iw8_la_juliet_mp" && _id_8B98()) {
      self._id_8B7C._id_E942 = 0;
      thread _id_8B9B();
    } else
      self._id_8B7C._id_E942 = 1;

    self waittill("weapon_change");
  }
}

_id_8B8C() {
  self._id_8B7C = spawnStruct();

  if(!isDefined(level._id_8B7C)) {
    level._id_8B7C = spawnStruct();
    level._id_8B7C._id_E75E = [];
    level._id_8B7C._id_E75E["off"] = [];
    level._id_8B7C._id_E75E["off"]["enter"] = ::_id_8B8E;
    level._id_8B7C._id_E75E["off"]["update"] = ::_id_8B90;
    level._id_8B7C._id_E75E["off"]["exit"] = ::_id_8B8F;
    level._id_8B7C._id_E75E["scanning"] = [];
    level._id_8B7C._id_E75E["scanning"]["enter"] = ::_id_8B95;
    level._id_8B7C._id_E75E["scanning"]["update"] = ::_id_8B96;
    level._id_8B7C._id_E75E["hold"] = [];
    level._id_8B7C._id_E75E["hold"]["enter"] = ::_id_8B89;
    level._id_8B7C._id_E75E["hold"]["update"] = ::_id_8B8B;
    level._id_8B7C._id_E75E["hold"]["exit"] = ::_id_8B8A;
    level._id_8B7C._id_E75E["fire"] = [];
    level._id_8B7C._id_E75E["fire"]["enter"] = ::_id_8B82;
    level._id_8B7C._id_E75E["fire"]["update"] = ::_id_8B84;
    level._id_8B7C._id_E75E["fire"]["exit"] = ::_id_8B83;
    level._id_8B7C._id_E75E["too_close"] = [];
    level._id_8B7C._id_E75E["too_close"]["enter"] = ::_id_8B9C;
    level._id_8B7C._id_E75E["too_close"]["update"] = ::_id_8B9D;
  }
}

_id_8B93() {
  if(!isDefined(self._id_8B7C)) {
    return;
  }
  self._id_8B7C._id_11B8 = undefined;
  self._id_8B7C.target = undefined;
  self._id_8B7C._id_9707 = undefined;
  self._id_8B7C._id_1031C = undefined;
  self._id_8B7C._id_71CF = 0;
  self._id_8B7C._id_EEED = undefined;

  if(isDefined(self._id_8B7C._id_71D0)) {
    self._id_8B7C._id_71D0 _id_078E::_id_4807();
    self._id_8B7C._id_71D0 delete();
  }

  self._id_8B7C._id_71D0 = undefined;
  self._id_8B7C._id_71D3 = undefined;
  self._id_8B7C._id_E747 = undefined;
  self._id_8B7C._id_BECF = undefined;
}

_id_8B8E(var_0) {
  if(isDefined(self._id_8B7C.target)) {
    scripts\cp_mp\utility\weapon_utility::_id_C4E1(self._id_8B7C.target, self);
    self._id_8B7C.target = undefined;
  }

  if(isDefined(self._id_8B7C._id_71D0)) {
    self._id_8B7C._id_71D0 _id_078E::_id_4807();
    self._id_8B7C._id_71D0 delete();
  }

  self._id_8B7C._id_71D0 = undefined;
  _id_8B88(0);
  _id_8B97(0);
}

_id_8B90() {
  if(self playerads() >= 0.9) {
    _id_8B92("scanning");
  }
}

_id_8B8F() {
  _id_8B88(1);
}

_id_8B7E() {
  self endon("weapon_change");
  self waittill("death_or_disconnect");

  if(isDefined(self._id_8B7C)) {
    if(isDefined(self._id_8B7C.target)) {
      scripts\cp_mp\utility\weapon_utility::_id_C4E1(self._id_8B7C.target, self);
      self _meth_8459();
      self._id_8B7C.target = undefined;
    }

    if(isDefined(self._id_8B7C._id_71D0)) {
      self._id_8B7C._id_71D0 _id_078E::_id_4807();
      self._id_8B7C._id_71D0 delete();
      self._id_8B7C._id_71D0 = undefined;
    }
  }

  _id_8B88(0);
  _id_8B97(0);
}

_id_8B95(var_0) {
  _id_8B97(1);
  self._id_8B7C._id_11B8 = gettime() + 100;
}

_id_8B96() {
  if(gettime() < self._id_8B7C._id_11B8) {
    return;
  }
  var_0 = _id_8B94();

  if(isDefined(var_0)) {
    if(_id_8B9A(var_0.origin)) {
      _id_8B92("too_close");
      return;
    }

    if(isDefined(self._id_8B7C.target) && self._id_8B7C.target == var_0) {
      var_1 = 1;
    }

    self._id_8B7C.target = var_0;

    if(isDefined(self._id_8B7C.target)) {
      scripts\cp_mp\utility\weapon_utility::_id_10E5(self._id_8B7C.target, self);
    }

    if(!isDefined(self._id_8BA0)) {
      _id_9B82(self._id_8B7C.target);
    }

    _id_8B92("hold");
  } else if(self attackbuttonpressed()) {
    if(self._id_8B7C._id_71CF >= 1) {
      self._id_8B7C._id_71CF = 0;
      self._id_8B7C._id_71D3 = undefined;
      return;
    }

    var_5 = _id_8B81();

    if(!isDefined(var_5)) {
      self._id_8B7C._id_71CF++;
      return;
    }

    if(_id_8B9A(var_5[0])) {
      _id_8B92("too_close");
      return;
    }

    if(isDefined(self._id_8B7C._id_71D3)) {
      var_6 = _func_0016(self._id_8B7C._id_71D3);
      var_7 = distance(var_6, var_5[0]);

      if(var_7 > 400) {
        self._id_8B7C._id_71CF++;
        return;
      }
    } else {
      self._id_8B7C._id_71D3 = [];
      self._id_8B7C._id_71D1 = [];
    }

    self._id_8B7C._id_71D3[self._id_8B7C._id_71D3.size] = var_5[0];
    self._id_8B7C._id_71D1[self._id_8B7C._id_71D1.size] = var_5[1];
    self._id_8B7C._id_71CF = 0;

    if(self._id_8B7C._id_71D3.size < 2) {
      return;
    }
    var_8 = _func_0016(self._id_8B7C._id_71D3);
    self._id_8B7C._id_71D0 = scripts\engine\utility::spawn_tag_origin(var_8);
    self._id_8B7C._id_71D0 _id_078E::_id_C2B6(1);
    self._id_8B7C.target = self._id_8B7C._id_71D0;
    self._id_8B7C._id_71CF = 0;
    self._id_8B7C._id_71D3 = undefined;
    self._id_8B7C._id_71D1 = undefined;

    if(!isDefined(self._id_8BA0)) {
      _id_9B82(self._id_8B7C.target);
    }

    _id_8B92("hold");
  }
}

_id_8B89(var_0) {
  if(!isDefined(self._id_8B7C.target)) {
    return;
  }
  _id_8B97(2);
  self._id_8B7C._id_9707 = gettime();
  self._id_8B7C._id_98AD = 0;
  self _meth_845B(self._id_8B7C.target);
  thread _id_8B8D("javelin_clu_acquiring_lock", 0.5);
}

_id_8B8B() {
  var_0 = 0;

  if(!isDefined(self._id_8B7C.target)) {
    _id_8B92("scanning");
    return;
  }

  var_1 = 0;

  if(!var_0 && (self._id_8B7C.target scripts\cp_mp\vehicles\vehicle::_id_8AF5() && scripts\cp_mp\vehicles\vehicle::_id_10124(self._id_8B7C.target, self))) {
    _id_8B92("scanning");
    var_1 = 1;
  }

  if(!_id_8B7D(self._id_8B7C.target)) {
    _id_8B92("scanning");
    var_1 = 1;
  }

  if(_id_8B9A(self._id_8B7C.target.origin)) {
    _id_8B92("too_close");
    var_1 = 1;
  }

  if(var_1) {
    if(isDefined(self._id_8B7C.target)) {
      scripts\cp_mp\utility\weapon_utility::_id_C4E1(self._id_8B7C.target, self);
    }

    self _meth_8459();
    self._id_8B7C.target = undefined;

    if(isDefined(self._id_8B7C._id_71D0)) {
      self._id_8B7C._id_71D0 delete();
    }
  }

  var_2 = gettime() - self._id_8B7C._id_9707;

  if(var_2 < 1150) {
    return;
  }
  _id_8B92("fire");
}

_id_8B8A() {
  self notify("stop_lockon_sound");
  self _meth_83EF("javelin_clu_acquiring_lock");
}

_id_8B82(var_0) {
  _id_8B97(3);

  if(!isDefined(self._id_8B7C.target)) {
    return;
  }
  if(isPlayer(self._id_8B7C.target)) {
    self _meth_8458(self._id_8B7C.target, (0, 0, 64), 0);
  } else if(isDefined(self._id_8B7C._id_71D0)) {
    self _meth_8458(self._id_8B7C.target, (0, 0, 0), 1);
  } else {
    var_1 = _id_8B87(self._id_8B7C.target);
    self _meth_8458(self._id_8B7C.target, var_1, 0);
  }

  thread _id_8B8D("javelin_clu_lock", 1.6);
}

_id_8B84() {
  var_0 = 0;

  if(!isDefined(self._id_8B7C.target)) {
    _id_8B92("scanning");
    return;
  }

  if(!var_0 && (self._id_8B7C.target scripts\cp_mp\vehicles\vehicle::_id_8AF5() && scripts\cp_mp\vehicles\vehicle::_id_10124(self._id_8B7C.target, self))) {
    _id_8B92("scanning");
  }

  if(!_id_8B7D(self._id_8B7C.target)) {
    _id_8B92("scanning");
  }

  if(_id_8B9A(self._id_8B7C.target.origin)) {
    _id_8B92("too_close");
  }
}

_id_8B83() {
  if(isDefined(self._id_8B7C.target)) {
    scripts\cp_mp\utility\weapon_utility::_id_C4E1(self._id_8B7C.target, self);
  }

  self _meth_8459();
  self._id_8B7C.target = undefined;

  if(isDefined(self._id_8B7C._id_71D0)) {
    self._id_8B7C._id_71D0 delete();
  }

  self notify("stop_lockon_sound");
  self _meth_83EF("javelin_clu_lock");
}

_id_8B9C(var_0) {
  _id_8B97(4);
}

_id_8B9D() {
  var_0 = _id_8B94();

  if(isDefined(var_0)) {
    if(!_id_8B9A(var_0.origin)) {
      _id_8B92("scanning");
      return;
    }
  } else {
    var_1 = _id_8B81();

    if(!isDefined(var_1) || isDefined(var_1) && _id_8B9A(var_1[0]) == 0) {
      _id_8B92("scanning");
      return;
    }
  }
}

_id_8B91() {
  if(isDefined(self._id_8B7C._id_E747) && self._id_8B7C._id_E747 != "off") {
    if(self playerads() < 0.9) {
      _id_8B92("off");
    }
  }
}

_id_8B7D(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self _meth_845F(var_0.origin, 35, 120, 80);

  if(!var_1) {
    return 0;
  }

  if(!isDefined(self._id_8B7C._id_71D0) && !_id_8B99(var_0)) {
    return 0;
  }

  if(isDefined(self._id_8B7C._id_71D0)) {
    if(!self attackbuttonpressed()) {
      return 0;
    }
  }

  return 1;
}

_id_8B81() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 15000;
  var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 0, undefined);

  if(var_4["surfacetype"] == "surftype_none" && var_4["hittype"] == "hittype_none") {
    return undefined;
  }

  if(var_4["surfacetype"] == "default") {
    return undefined;
  }

  var_5 = var_4["entity"];
  var_6 = [];
  var_6[0] = var_4["position"];
  var_6[1] = var_4["normal"];
  return var_6;
}

_id_8B9A(var_0) {
  var_1 = 1100;
  var_2 = distance(self.origin, var_0);

  if(var_2 < var_1) {
    return 1;
  }

  return 0;
}

_id_8B8D(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

_id_8B92(var_0) {
  self._id_8B7C._id_BECF = var_0;
}

_id_8B86() {
  return self._id_8B7C._id_BECF;
}

_id_8B80(var_0) {
  var_1 = self._id_8B7C._id_E747;

  if(isDefined(var_1) && isDefined(level._id_8B7C._id_E75E[var_1]["exit"])) {
    self[[level._id_8B7C._id_E75E[var_1]["exit"]]]();
  }

  self._id_8B7C._id_E747 = var_0;

  if(isDefined(level._id_8B7C._id_E75E[var_0]["enter"])) {
    self[[level._id_8B7C._id_E75E[var_0]["enter"]]](var_1);
  }

  self._id_8B7C._id_BECF = undefined;
}

_id_8B98() {
  return !_id_078D::_id_85B3();
}

_id_8B9B() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");
  self notify("javelin_think");
  self endon("javelin_think");
  _id_8B93();
  _id_8B80("off");
  thread _id_8B7E();

  for(;;) {
    if(isDefined(self._id_8B7C._id_E942) && self._id_8B7C._id_E942) {
      _id_8B80("off");
      return;
    }

    if(!_id_8B98()) {
      _id_8B80("off");
      return;
    }

    _id_8B91();
    var_0 = _id_8B86();

    if(isDefined(var_0)) {
      _id_8B80(var_0);
    }

    self[[level._id_8B7C._id_E75E[self._id_8B7C._id_E747]["update"]]]();
    wait 0.05;
  }
}

_id_8B94() {
  var_0 = scripts\mp\weapons::_id_96FE();
  var_1 = getdvarint("#x3f2fe94fa15345e1e", 625000000);

  if(var_0.size != 0) {
    var_2 = [];

    foreach(var_4 in var_0) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = self _meth_845F(var_4.origin, 35, 120, 80);

      if(var_5 && distancesquared(var_4.origin, self.origin) <= var_1) {
        var_2[var_2.size] = var_4;
      }
    }

    if(var_2.size != 0) {
      var_7 = _func_0204(var_2, self.origin);

      if(_id_8B9E(var_7[0])) {
        return var_7[0];
      }
    }
  }

  return undefined;
}

_id_8B9E(var_0) {
  var_1 = self getEye();
  var_2 = var_0 _meth_8174(0, 0, 1);
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

_id_8B87(var_0) {
  var_1 = (0, 0, 0);

  if(!isDefined(var_0)) {
    return var_1;
  }

  if(scripts\mp\utility\entity::_id_87AE(var_0)) {
    var_1 = (0, 0, -50);
  } else if(scripts\mp\utility\entity::_id_8A80(var_0)) {
    var_1 = (0, 0, -100);
  } else if(scripts\mp\utility\entity::_id_8889(var_0)) {
    var_1 = (0, 0, 50);
  } else if(scripts\mp\utility\entity::_id_87B4(var_0)) {
    var_1 = (0, 0, 40);
  } else if(scripts\mp\utility\entity::_id_89D2(var_0)) {
    var_1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::_id_8A1A(var_0)) {
    var_1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::_id_89D3(var_0)) {
    var_1 = (0, 0, -30);
  } else if(isDefined(var_0._id_1031E) && var_0._id_1031E == "loot_chopper") {
    var_1 = (0, 0, -100);
  }

  return var_1;
}

_id_8B99(var_0) {
  if(_id_8B9E(var_0)) {
    self._id_8B7C._id_98AD = 0;
    return 1;
  }

  if(self._id_8B7C._id_98AD == 0) {
    self._id_8B7C._id_98AD = gettime();
  }

  var_1 = gettime() - self._id_8B7C._id_98AD;

  if(var_1 >= 500) {
    return 0;
  }

  return 1;
}

_id_8B88(var_0) {
  if(var_0) {
    self setclientomnvar("ui_javelin_view", 1);
  } else {
    self setclientomnvar("ui_javelin_view", 0);
  }
}

_id_8B97(var_0) {
  self setclientomnvar("ui_javelin_state", var_0);
}

_id_9B82(var_0) {
  var_1 = _id_079B::_id_EEDF("javelincrosshair", self, var_0, self);

  if(var_0.model == "tag_origin") {
    var_0 show();
  }

  self._id_8BA0 = 1;
  thread _id_10C15(var_0, var_1, 1);
}

_id_10C15(var_0, var_1, var_2) {
  level endon("game_ended");

  while(isDefined(self._id_8B7C.target) && self._id_8B7C._id_E747 != "off") {
    waitframe();
  }

  if(isDefined(var_1)) {
    _id_079B::_id_EEDE(var_1);
  }

  self._id_8BA0 = undefined;
}

_id_8B85() {
  _id_8B88(0);
  _id_8B97(0);

  if(isDefined(self._id_8B7C)) {
    if(isDefined(self._id_8B7C.target)) {
      scripts\cp_mp\utility\weapon_utility::_id_C4E1(self._id_8B7C.target, self);
      self _meth_8459();
      self._id_8B7C.target = undefined;
    }

    if(isDefined(self._id_8B7C._id_71D0)) {
      self._id_8B7C._id_71D0 _id_078E::_id_4807();
      self._id_8B7C._id_71D0 delete();
    }
  }

  self notify("stop_lockon_sound");
  self _meth_83EF("javelin_clu_lock");
}