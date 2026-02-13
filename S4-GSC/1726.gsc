/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1726.gsc
*************************************************/

_id_1C77(var_0, var_1) {
  self._id_1C30 = spawnStruct();
  self._id_1C30._id_18B7 = [];
  self._id_1C30._id_5F3F = 0;
  self._id_1CB8 = var_0;
  self._id_1C30._id_1A35 = var_1;
  self _meth_85E0(var_1);
  self._id_5D5E = ::_id_1C77;

  if(self _meth_85EC()) {
    self._id_5D63 = ::_id_1CA7;
  } else {
    self._id_5D63 = ::_id_1CA8;
  }

  self._id_5D5D = scripts\anim\notetracks_mp::_id_7476;
  self._id_5D60 = ::_id_1C85;
  self._id_5D61 = ::_id_1C8F;
  self._id_5D79 = ::_id_4E47;
  self._id_5D76 = ::_id_4E38;
  self._id_5D78 = ::_id_4E44;
  self._id_5D89 = ::_id_69EF;
  self._id_5D75 = ::_id_4E2E;
  level._id_5D57 = ::_id_187D;
  level._id_5D58 = ::_id_187C;
  level._id_5D56 = ::_id_187C;
  _id_7357();
  var_2 = var_0;

  if(isDefined(self._id_1CB6)) {
    var_2 = self._id_1CB6;
  }

  _func_0344(var_2, _id_0009::_id_1C55);
  self _meth_85CB(var_2);
}

_id_7357() {
  if(isDefined(self._id_0DDF)) {
    return;
  }
  self._id_0DDF = spawnStruct();
  self._id_0131 = "stand";
  self._id_0DDF._id_A235 = "stop";
  self._id_0DDF._id_E3B7 = "none";
  self._id_0DDF._id_72AF = "none";
  self._id_0DDF._id_A411 = 0;
  self._id_0DDF._id_3AAE = gettime();
  self._id_0DDF._id_8FCE = gettime();
  self._id_0DDF._id_EBAF = 0;
  self._id_0DDF._id_4AC4 = !self _meth_81BA();
  self._id_0DDF._id_ADFA = 0;
  self._id_0DDF._id_9041 = 0;
  self._id_0DDF._id_A4A4 = 0;
  self._id_0DDF._id_C09A = 0.8;
  self._id_0DDF._id_A567 = 0;
  self._id_02B6 = 0;
  self._id_02B7 = 0;
  self._id_0DDF._id_4AD8 = 0;
  self._id_026D = 0;
}

_id_187D(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel(level._id_CC42[var_0]);
  self._id_1879 = var_4;
}

_id_187C(var_0, var_1) {
  var_2 = level._id_CC31[var_0][var_1];
  self._id_1879 _meth_82CC(var_2);
}

_id_CA69() {
  if(isDefined(self._id_5DC3)) {
    if(![[self._id_5DC3]]()) {
      return;
    }
  } else if(!_id_DBA8()) {
    return;
  }
  if(isDefined(self.damageweapon)) {
    var_0 = getweaponbasename(self.damageweapon);

    if(var_0 == "s4_molotov_mp") {
      self._id_0B67._id_8796 = 1;

      if(self._id_0150 > 0) {
        self._id_2D8A = "right";
      } else {
        self._id_2D8A = "left";
      }
    }
  }

  if(self _meth_85D0(self._id_1CB8)) {
    self _meth_85CF(self._id_1CB8);
  }
}

_id_F4E9() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("traverse_begin", var_0, var_1);

    if(!self _meth_85C9(self._id_1CB8, var_0)) {
      var_0 = "traverse_external";
    }

    self _meth_85CA(self._id_1CB8, var_0);
  }
}

_id_DBA8() {
  var_0 = 64;

  if(self._id_0DDF._id_4AD8) {
    return 0;
  }

  if(isDefined(self._id_0043) && self._id_0043 == 0) {
    return 0;
  }

  if(isDefined(self._id_0323) && self _meth_8473(1) < var_0) {
    return 0;
  }

  if(isDefined(self.damageweapon)) {
    var_1 = getweaponbasename(self.damageweapon);
    var_2 = issubstr(var_1, "thermite") || isDefined(self.damageweapon._id_028D) && issubstr(self.damageweapon._id_028D, "boltfire");

    if(var_2 && isDefined(self._id_0DDF._id_9024) && gettime() - self._id_0DDF._id_9024 < 2000) {
      return 0;
    }
  }

  return 1;
}

_id_1C71(var_0, var_1, var_2, var_3) {
  _id_0009::_id_1C53(self._id_1CB8, var_0);
}

_id_1C88(var_0, var_1, var_2, var_3) {
  _id_1C89(var_0, var_1, var_2, var_3, "end");
}

_id_1C89(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = _id_0009::_id_1C6A(var_0, var_1);

  if(isDefined(var_3)) {
    _id_0017::_id_B353(var_1, var_2, var_3, var_1, var_4, var_5);
  } else {
    _id_0017::_id_B356(var_1, var_2, var_1, var_4, var_5);
  }
}

_id_1C8A(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = _id_0009::_id_1C6A(var_0, var_1);

  if(isDefined(var_3)) {
    _id_0017::_id_B354(var_1, var_2, var_3, var_1, var_4, var_5);
  } else {
    _id_0017::_id_B357(var_1, var_2, var_1, var_4, var_5);
  }
}

_id_1C8C(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_1C5D(var_0, var_1);
  var_4 = _id_0009::_id_1C6A(var_0, var_1);
  _id_0017::_id_B356(var_1, var_3, var_1, var_2, var_4);
}

_id_1CAC(var_0, var_1) {}

_id_1CA8(var_0) {
  switch (var_0) {
    case "face node":
      var_1 = 1024.0;

      if(scripts\engine\utility::_id_0F78()) {
        var_2 = self.angles;

        if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_1) {
          var_2 = _id_08F1::_id_6B9C(self._id_02ED);
        }

        self _meth_8251("face angle 3d", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_1) {
          var_3 = _id_08F1::_id_6B9D(self._id_02ED);
        }

        self _meth_8251("face angle", var_3);
      }

      break;
    default:
      self _meth_8251(var_0);
      break;
  }
}

_id_1CA7(var_0) {
  switch (var_0) {
    case "face goal":
      var_1 = self._id_0323;

      if(isDefined(var_1)) {
        var_2 = var_1 - self.origin;
        var_3 = vectornormalize(var_2);
        var_4 = vectortoangles(var_3);
        self _meth_8251("face angle", var_4[1]);
        break;
      }
    case "face current":
      self _meth_8251("face current");
      break;
    case "face motion":
    case "face enemy":
      self _meth_8251(var_0);
      break;
    case "face node":
      var_5 = self.angles[1];
      var_6 = 1024.0;

      if(isDefined(self._id_02ED) && distancesquared(self.origin, self._id_02ED.origin) < var_6) {
        var_5 = _id_08F1::_id_6B9D(self._id_02ED);
      }

      self _meth_8251("face angle", var_5);
      break;
    default:
      break;
  }
}

_id_1C5D(var_0, var_1, var_2) {
  return self _meth_85C8(var_0, var_1, var_2);
}

_id_1C85(var_0, var_1, var_2) {}

_id_4E47(var_0, var_1) {
  var_2 = self._id_04B9 == "dog";
  var_3 = getdvarint("#x38f725ff91fadc419", 0) == 1;
  var_4 = var_2 && var_3;
  var_0 _meth_873C("away", self.origin, var_4);

  if(var_0 _meth_872B()) {
    var_5 = _func_03C0(undefined, undefined, var_0.origin, 64);

    foreach(var_7 in var_5) {
      if(var_7 _meth_872B()) {
        var_7 _meth_873C("away", self.origin);
      }
    }
  }
}

_id_4E38(var_0) {
  var_0 _meth_873D();
}

_id_4E44(var_0) {
  var_1 = var_0 _meth_8575("door", 1);

  if(!isDefined(var_1) || var_1 == "closed" || var_1 == "setup") {
    return 0;
  }

  var_2 = self.origin - var_0.origin;
  var_3 = _func_0261(var_2);
  var_4 = _func_000B(var_3 - var_0._id_39D6[1]);
  var_5 = _func_000B(var_0.angles[1] - var_0._id_39D6[1]);
  return var_4 * var_5 > 0;
}

_id_69EF(var_0) {
  return self._id_0B67._id_4E4A;
}

_id_4E2E(var_0) {
  return abs(var_0 _meth_8730()) > 60;
}

_id_1C35(var_0) {
  if(!_func_0335(var_0)) {
    return 0;
  }

  return _func_0011(var_0, "facial_override");
}

_id_1C8F(var_0, var_1, var_2) {
  self _meth_87C1(var_0, var_1, var_2);
}

_id_1C93(var_0, var_1) {
  if(!_id_08F1::_id_8848("asm")) {
    return;
  }
  if(isDefined(var_0) && _id_1C35(var_0)) {
    return;
  }
  var_2 = _id_0009::_id_1C7E("knobs", "head");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(self._id_1C30._id_588C)) {
    self._id_1C30._id_588C = "";
  }

  _id_08F1::_id_D556("asm");

  if(isai(self)) {
    self _meth_86D8(var_1);
  }
}

_id_1C9C() {
  self _meth_8019("noclip");
  self _meth_8251("face angle", self.angles[1]);
  _id_0009::_id_1C3F();
  _id_06BD::_id_2400();
  self _meth_85CA(self._id_1CB8, "animscripted");
}