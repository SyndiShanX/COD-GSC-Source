/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1766.gsc
*************************************************/

_id_8103() {
  if(isDefined(level._id_4AFC) && level._id_4AFC) {
    return;
  }
  if(!scripts\engine\utility::_id_0FE2("vehicles", ::_id_8103)) {
    return;
  }
  thread _id_8105();
  _id_3869();
}

_id_3869() {
  level._id_106B9 = undefined;
  level._id_106BA = undefined;
  level._id_106BC = undefined;
}

_id_8105() {
  scripts\engine\utility::_id_3F35("aircraft_wash_math");
  _id_06E9::_id_10255();
  level.vehicle._id_7777 = scripts\engine\utility::array_combine(level.vehicle._id_7777, scripts\engine\utility::_id_6D9B("helicopter_crash_location", "targetname"));
  _id_06E9::_id_10256();
  var_0 = _id_06E9::_id_10239();
  _id_06E9::_id_D83A(var_0);
  level.vehicle._id_752D = getEntArray("script_vehicle", "code_classname").size > 0;
  scripts\engine\utility::_id_CD61("add_hint_string", "invulerable_frags", &"SCRIPT/INVULERABLE_FRAGS");
  scripts\engine\utility::_id_CD61("add_hint_string", "invulerable_bullets", &"SCRIPT/INVULERABLE_BULLETS");
}

_id_1022C(var_0, var_1, var_2) {
  return _id_06EB::_id_0DBD(var_0, var_1, var_2);
}

vehicle_spawn(var_0) {
  return _id_06E9::_id_1027B(var_0);
}

_id_7097() {
  self._id_7095 = 1;
}

_id_7096() {
  self._id_7095 = 0;
}

_id_9984() {
  return _id_06E9::_id_0C58();
}

_id_9985() {
  return _id_06E9::_id_0C59();
}

_id_9E68() {
  return _id_06E9::_id_0C62();
}

_id_9E69() {
  return _id_06E9::_id_0C63();
}

_id_8AF5() {
  return isDefined(self._id_04DE);
}

_id_1011A() {
  return _id_06E9::_id_10120();
}

_id_85E1() {
  return _id_06E9::_id_0C3A();
}

_id_1012B() {
  self notify("kill_rumble_forever");
}

_id_E23F(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4._id_00EC) || var_4._id_00EC != "script_vehicle") {
      continue;
    }
    if(_func_011E(var_4)) {
      var_5 = _id_06E9::_id_1027B(var_4);
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  return var_1;
}

_id_E23B(var_0) {
  var_1 = _id_E23F(var_0);
  return var_1[0];
}

_id_E23C(var_0) {
  var_1 = _id_E23F(var_0);
  thread _id_06EB::_id_70E1(var_1[0]);
  return var_1[0];
}

_id_E240(var_0) {
  var_1 = _id_E23F(var_0);

  foreach(var_3 in var_1) {
    thread _id_06EB::_id_70E1(var_3);
  }

  return var_1;
}

_id_136C(var_0) {
  thread _id_06E9::_id_136D(var_0);
}

_id_102E7() {
  _id_06E9::_id_10257(1);
}

_id_102E6() {
  _id_06E9::_id_10257(0);
}

_id_10139(var_0, var_1, var_2) {
  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  _id_06E7::_id_95A9(var_0, var_1, var_2);

  if(getdvarint("#x32923f011fc14a85b")) {
    if(!self._id_FE56[0]) {
      var_3 = self._id_C835;
      _id_102D0();
      scripts\engine\utility::_id_5476("unloaded");
      var_3 = scripts\engine\utility::_id_1BCA(var_3);
      var_3 = scripts\engine\utility::_id_1BBF(var_3, self._id_C835);

      if(var_3.size > 0) {
        _id_10139(var_3);
        return;
      }
    } else {
      var_4 = level.vehicle._id_F078._id_1306[_id_06E9::_id_6810()];

      if(isDefined(var_4[0]._id_0153)) {
        foreach(var_6 in self._id_C835) {
          if(istrue(var_6._id_4F6E)) {
            thread _id_06E7::_id_4F69(var_6);
          }
        }
      }
    }
  }
}

_id_E239() {
  var_0 = scripts\common\utility::_id_E235();

  if(isDefined(self._id_CE57)) {
    if(!_id_8896()) {
      var_0 vehicle_setspeed(self._id_CE57);
    }
  }

  thread _id_06EB::_id_70E1(var_0);
  return var_0;
}

_id_1D76(var_0) {
  self _meth_8439(var_0.origin, var_0.angles);

  if(!_id_8896()) {
    waitframe();
    self _meth_8020(var_0);
  }

  thread _id_1022C(var_0, 1);
}

_id_1D77(var_0) {
  self _meth_8439(var_0.origin, var_0.angles);
  waitframe();

  if(!_id_8896()) {
    self _meth_8020(var_0);
  }

  thread _id_1022C(var_0);
  _id_06EB::_id_70E1(self);
}

_id_100B3(var_0) {
  var_1 = [];
  var_2 = _id_06E9::_id_6810();

  if(!isDefined(level.vehicle._id_F078._id_F97C[var_2])) {
    return var_1;
  }

  var_3 = level.vehicle._id_F078._id_F97C[var_2];

  if(!isDefined(var_0)) {
    return var_1;
  }

  foreach(var_5 in self._id_C835) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5._id_10238 == var_7) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

_id_102D0(var_0) {
  return _id_06E9::_id_0DC0(var_0);
}

_id_102CF() {
  self notify("stop_scanning_turret");
}

_id_100B2() {
  self endon("death");
  var_0 = [];
  var_1 = self._id_1D83;

  if(!isDefined(self._id_1D83)) {
    return var_0;
  }

  var_2 = var_1;
  var_2._id_3D9C = 0;

  while(isDefined(var_2)) {
    if(isDefined(var_2._id_3D9C) && var_2._id_3D9C == 1) {
      break;
    }

    var_0 = scripts\engine\utility::array_add(var_0, var_2);
    var_2._id_3D9C = 1;

    if(!isDefined(var_2.target)) {
      break;
    }

    if(!_id_8896()) {
      var_2 = _func_00E5(var_2.target, "targetname");
      continue;
    }

    var_2 = scripts\engine\utility::_id_6A02(var_2.target, "targetname");
  }

  return var_0;
}

_id_10137(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  _id_06EA::_id_94A3(var_0, var_1);
}

_id_10136(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  _id_06EA::_id_949F(var_0, var_1);
}

_id_102B2(var_0, var_1) {
  self _meth_8386(var_0, var_1);
  self._id_1D83 = var_1;
  thread _id_1022C();
}

_id_102A2(var_0, var_1, var_2) {
  return _id_06EB::_id_0DBF(var_0, var_1, var_2);
}

_id_10247(var_0) {
  return _id_06EB::_id_0DBE(var_0);
}

vehicle_has_stop_named(var_0) {
  return _id_06EB::_vehicle_has_stop_named(var_0);
}

_id_8896() {
  return _id_06E9::_id_8897();
}

_id_8740() {
  return _id_06E9::_id_8741();
}

_id_51F9() {
  _id_06E9::_id_10255();
  level.vehicle._id_E144 = 1;
}

_id_10250(var_0) {
  if(isDefined(self._id_763A)) {
    self.health = var_0 + self._id_763A;
  } else {
    self.health = var_0;
  }

  self._id_41CA = self.health;
}

_id_100B0() {
  if(isDefined(self._id_763A)) {
    return self.health - self._id_763A;
  } else {
    return self.health;
  }
}

_id_100B1() {
  if(isDefined(self._id_763A)) {
    return self.maxhealth - self._id_763A;
  } else {
    return self.maxhealth;
  }
}