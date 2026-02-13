/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1712.gsc
*************************************************/

_id_816B(var_0) {
  self._id_2C5E._id_011B = spawnStruct();
  _id_06BD::_id_23ED("none");
  self._id_011F = self._id_02ED;
  self._id_2C5E._id_011B._id_E72D = gettime();
  self._id_2C5E._id_011B._id_A4AD = gettime() + randomintrange(3000, 7000);
  self._id_0296 = 0.015;
  self._id_0B67._id_90B5 = self._id_02ED;
  self._id_10A17 = 1;
  self._id_024C = 0;

  if(!isDefined(self._id_4E6C)) {
    scripts\common\utility::_id_C5E0();
  }

  if(!isDefined(self._id_0B67._id_011E)) {
    self._id_0B67._id_011E = scripts\anim\weaponlist::_id_698F();
  }

  if(!isDefined(self._id_26C0)) {
    self._id_26C0 = scripts\anim\weaponlist::_id_6928();
  }

  if(isDefined(self._id_0B67._id_015C)) {}

  _id_06BD::_id_2403(self._id_011F);
  self._id_3D95 = self.origin;

  if(!isDefined(self._id_2C5E._id_011B._id_A4C7) || !isDefined(self._id_0B67._id_03D5)) {
    _id_D60D();
  }

  _id_D60A();

  if(!isDefined(self._id_3DE1)) {
    self._id_3DE1 = 30;
  }

  if(!isDefined(self._id_3DE3)) {
    self._id_3DE3 = 2;
  }

  if(!isDefined(self._id_3DE2)) {
    self._id_3DE2 = 3;
  }

  if(!isDefined(self._id_3DDE)) {
    self._id_3DDE = 5;
  }

  thread _id_2D3E();
  return anim._id_EACB;
}

_id_816C(var_0) {
  self._id_2C5E._id_011B._id_EF2C = var_0;
}

_id_3932(var_0) {
  if(isDefined(self._id_2C5E._id_011B) && self._id_2C5E._id_011B._id_EF2C != var_0) {
    return anim._id_EACB;
  }

  if(_id_06BD::_id_23CC()) {
    _id_06BD::_id_2403(undefined);
    _id_06BD::_id_23ED("hide");
    self._id_0B67._id_015C = undefined;

    if(isDefined(self._id_0323) || self._id_0B67._id_015E == "prone") {
      var_1 = _id_08F1::_id_6A9A();
      _id_06BD::_id_23F7(var_1);
    }

    _id_06BD::_id_23EB(undefined);
    self._id_2C5E._id_011B = undefined;
    self._id_011F = undefined;
    _id_06BD::_id_23B5();
    _id_06BD::_id_23EE(0);
  }

  self._id_0B67._id_0238 = undefined;
  return anim._id_EACB;
}

_id_D4EA(var_0) {
  var_1 = self._id_0B67._id_0125;

  if(var_0 == "hide" && (var_1 == "exposed" || var_1 == "none")) {
    _id_81AE();
  }

  _id_06BD::_id_23ED(var_0);
}

_id_6990() {
  return self._id_0B67._id_0125;
}

_id_878A(var_0) {
  if(self._id_017B) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_011F) && gettime() > _id_6B85()) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_D60A() {
  if(self._id_017B) {
    self._id_2C5E._id_02E5 = gettime();
    return;
  }

  if(!isDefined(self._id_26C0)) {
    self._id_26C0 = scripts\anim\weaponlist::_id_6928();
  }

  self._id_2C5E._id_02E5 = gettime() + self._id_26C0;
}

_id_6B85() {
  return self._id_2C5E._id_02E5;
}

_id_A271(var_0) {
  if(isDefined(self._id_5DA8)) {
    self[[self._id_5DA8]](var_0);
  }
}

_id_DB82(var_0) {
  if(isDefined(self._id_5DC2)) {
    return self[[self._id_5DC2]](var_0);
  }

  return anim._id_58E3;
}

_id_97FD(var_0) {
  if(isDefined(self._id_5DA1)) {
    return self[[self._id_5DA1]](var_0);
  }

  return anim._id_58E3;
}

_id_FE37(var_0) {
  var_1 = self._id_0260;
  var_2 = self._id_025E;
  self._id_0260 = 0;
  self._id_025E = 0;

  if(self _meth_8423(var_0, 0)) {
    _id_A271(var_0);
    return 1;
  } else {}

  self._id_0260 = var_1;
  self._id_025E = var_2;
  return 0;
}

_id_97FB(var_0) {
  if(self._id_01C2 || self._id_017B) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_0B67._id_015C)) {
    return anim._id_58E3;
  }

  var_1 = undefined;

  if(istrue(self._id_009F)) {
    var_1 = "cover_bounding_overwatch";
  }

  _id_C56C(1, 1, var_1);
  return anim._id_EACB;
}

_id_3DD1() {
  if(self._id_01C2) {
    return 0;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  var_0 = self._id_0B67._id_0125;

  if(self._id_017B) {
    if(var_0 == "exposed" && !self._id_0063) {
      return !self _meth_8633();
    }

    return 0;
  }

  if(istrue(self._id_8840)) {
    return 0;
  }

  if(gettime() < _id_6B85()) {
    return 0;
  }

  if(var_0 == "hide" || var_0 == "exposed") {
    if(!isDefined(self._id_0B67._id_015C) || !_id_08F1::_id_87CD(self._id_0B67._id_015C)) {
      return 1;
    }
  }

  return 0;
}

_id_DAF8() {
  if(!istrue(self._id_009F)) {
    return 0;
  }

  if(!_id_3DD1()) {
    return 0;
  }

  return self _meth_865A();
}

_id_97FC(var_0) {
  if(_id_DAF8()) {
    _id_C56C(0, 1, "cover_bounding_overwatch");
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_C56C(var_0, var_1, var_2) {
  self._id_02E5 = gettime();

  if(isDefined(self._id_041F)) {
    if(self._id_041F > 0) {
      var_3 = self._id_04F6.classname;

      if(isDefined(self._id_10D1F[var_3])) {
        var_4 = self._id_10D1F[var_3]._id_9F2D * self._id_10D1F[var_3]._id_EBA9;
        var_5 = self._id_10D1F[var_3]._id_9C8B * self._id_10D1F[var_3]._id_EBA9;

        if(var_4 > var_5) {}

        self._id_02E5 = self._id_02E5 + randomintrange(int(var_4), int(var_5));
      }
    }
  }

  if(!self._id_036F) {
    self._id_036F = var_0;
  }

  self._id_036D = var_1;
  self._id_0123 = var_2;
  _id_D60A();
}

_id_97F9(var_0) {
  if(istrue(self._id_009F)) {
    return anim._id_58E3;
  }

  if(self._id_01D5) {
    return anim._id_58E3;
  }

  if(_id_3DD1()) {
    if(self._id_017B) {
      _id_4C3A();
      return anim._id_EACB;
    }

    var_1 = 1;
    var_2 = undefined;

    if(scripts\anim\utility_common::_id_FF0F()) {
      var_2 = "cover_lmg";
    }

    _id_C56C(var_1, 0, var_2);
  }

  return anim._id_EACB;
}

_id_97FA(var_0, var_1, var_2) {
  if(self._id_0063) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(self._id_017B) {
    var_3 = self _meth_8634();
  } else {
    if(!isDefined(var_2) && scripts\anim\utility_common::_id_FF0F()) {
      var_2 = "cover_lmg";
    }

    var_3 = self _meth_80EC(var_2, var_1, undefined, self._id_009F);
  }

  if(isDefined(var_3)) {
    if(!isDefined(self._id_02ED) || var_3 != self._id_02ED || isDefined(var_0) && var_3 != var_0) {
      if(_id_FE37(var_3)) {
        if(self._id_017B) {
          if(self _meth_8635(var_3)) {
            return 1;
          } else {
            self _meth_8474();
            self._id_0260 = 0;
            self._id_025E = 0;
            return 0;
          }
        }

        return 1;
      }
    }
  }

  return 0;
}

_id_57F0() {
  if(self._id_01C2) {
    return 0;
  }

  if(isDefined(self._id_2C5E._id_011B)) {
    return 0;
  }

  if(self._id_017B) {
    if(!self._id_0063) {
      return !self _meth_8633();
    }

    return 0;
  }

  if(istrue(self._id_8840)) {
    return 0;
  }

  if(isDefined(self _meth_875D())) {
    return 1;
  }

  if(!isDefined(self._id_0B67._id_90B5)) {
    return 0;
  }

  return 1;
}

_id_4C3A() {
  var_0 = self _meth_8634();

  if(isDefined(var_0) && (!isDefined(self._id_011F) || self._id_02ED != self._id_011F)) {
    if(self _meth_8635(var_0)) {
      _id_FE37(var_0);
    }
  }

  _id_D60A();
}

_id_FC61(var_0) {
  if(_id_DB44()) {
    if(self._id_041F > 0.75 && !self._id_024C) {
      self._id_024C = 1;
      var_1 = "prone";
      _id_06BD::_id_23F7(var_1);
      thread _id_FD4F();
    }
  }

  if(_id_57F0()) {
    if(!self._id_017B && !scripts\engine\utility::_id_0F78() && isDefined(self._id_0323) && distancesquared(self._id_0323, self.origin) > 4.0) {
      self._id_0B67._id_90B5 = undefined;
      self._id_2C5E._id_02E5 = undefined;
    } else if(!self._id_017B && isDefined(self._id_02ED) && isDefined(self._id_0B67._id_90B5) && self._id_02ED != self._id_0B67._id_90B5) {
      self._id_0B67._id_90B5 = undefined;
      self._id_2C5E._id_02E5 = undefined;
    } else {
      if(!isDefined(self._id_2C5E._id_02E5)) {
        _id_D60A();
      }

      if(gettime() >= self._id_2C5E._id_02E5) {
        if(self._id_017B) {
          _id_4C3A();
          return anim._id_EACB;
        }

        var_2 = undefined;

        if(istrue(self._id_009F)) {
          var_2 = "cover_bounding_overwatch";
        }

        _id_C56C(1, 1, var_2);
        _id_D60A();
      }
    }
  }

  return anim._id_EACB;
}

_id_FD4F() {
  self endon("death");
  var_0 = self._id_04F6.classname;
  var_1 = 3.0;

  if(isDefined(self._id_10D1F[var_0])) {
    var_1 = self._id_10D1F[var_0]._id_EBAB;
  }

  for(;;) {
    waitframe();
    var_1 = var_1 - 0.05;

    if(var_1 < 0) {
      self._id_024C = 0;
      var_2 = "stand";
      _id_06BD::_id_23F7(var_2);
      break;
    }
  }
}

_id_DB44() {
  if(self._id_041F < 0.75) {
    self._id_10A17 = 1;
  } else if(isDefined(self._id_02ED) && self._id_02ED.type == "Exposed" && self._id_041F >= 0.75 && istrue(self._id_10A17)) {
    self._id_10A17 = 0;
    var_0 = 0.3;
    var_1 = self._id_04F6.classname;

    if(isDefined(self._id_10D1F[var_1])) {
      var_0 = self._id_10D1F[var_1]._id_EBAC;
    }

    var_0 = var_0 * 100;
    return randomint(100) <= var_0;
  }

  return 0;
}

_id_FB30(var_0) {
  var_1 = self._id_011F;
  return anim._id_EACB;
}

_id_FB7E(var_0) {
  return anim._id_EACB;
}

_id_316E(var_0) {
  if(var_0 _meth_8678()) {
    return 1;
  }

  return 0;
}

_id_7559(var_0) {
  return istrue(self._id_0B67._id_0187) && isDefined(self._id_0B67._id_015C) && self._id_0B67._id_015C == var_0 && (!isDefined(self._id_0B67._id_5049) || gettime() > self._id_0B67._id_5049);
}

_id_DB1F(var_0) {
  var_1 = isDefined(self._id_02ED) && _id_7559(self._id_02ED);
  var_2 = _id_316E(self._id_02ED) && (scripts\anim\utility_common::_id_FF0F() || isDefined(_id_06BD::_id_23C8()) || var_1);

  if(var_2) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_8807(var_0) {
  return self._id_017B;
}

_id_FC83(var_0) {
  _id_D4EA("hide");
  return anim._id_EACB;
}

_id_88BD(var_0) {
  if(isDefined(self._id_2C5E._id_011B)) {
    if(!isDefined(self._id_011F)) {
      return anim._id_58E3;
    }

    if(self._id_011F != self._id_02ED && !istrue(self._id_0324)) {
      return anim._id_58E3;
    }

    if(isDefined(self._id_0192)) {
      var_1 = 0;

      if(_id_DB0B()) {
        var_1 = _id_87D3(self._id_011F);
      } else {
        var_1 = _id_08F1::_id_87D2();
      }

      if(!var_1 && !_id_08F1::_id_5BEE() && _id_08F1::_id_3DC5()) {
        return anim._id_58E3;
      }
    }
  } else if(isDefined(self._id_0192)) {
    if(_id_08F1::_id_87C8()) {
      return anim._id_58E3;
    }

    if(_id_08F1::_id_03D3() && weaponclass(self._id_04F6) != "mg") {
      _id_06BD::_id_23F7("stand");
      return anim._id_58E3;
    }
  }

  return anim._id_EACB;
}

_id_DB0B() {
  return (weaponclass(self._id_04F6) == "mg" || _id_7559(self._id_011F)) && self._id_011F.type != "Cover Left" && self._id_011F.type != "Cover Right";
}

_id_87D3(var_0) {
  if(!isDefined(self._id_0192) || !isDefined(self._id_02ED)) {
    return 0;
  }

  var_1 = var_0.angles[1] - _func_0261(self._id_0192.origin - var_0.origin);
  var_1 = _func_000B(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;
  }

  if(var_1 <= self._id_0275) {
    return 1;
  }

  return 0;
}

_id_DBC5(var_0, var_1) {
  if(self._id_00CC > weaponclipsize(self._id_04F6) * var_1) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_8279(var_0) {
  thread scripts\anim\battlechatter_wrapper::_id_5677();
  _id_81AE();
}

_id_F09B(var_0) {
  _id_06BD::_id_23F5(0);
}

_id_81AD(var_0) {
  _id_D4EA("hide");

  if(isDefined(self._id_0192) && !isDefined(self._id_2C5E._id_011B._id_33E3)) {
    _id_D4E8();
  }
}

_id_3DE5(var_0) {
  _id_D4EA("hide");

  if(isDefined(self._id_0192) && !_id_08F1::_id_87D2()) {
    self._id_2C5E._id_02E5 = self._id_2C5E._id_02E5 - 1000;
  }

  return anim._id_EACB;
}

_id_D646(var_0) {
  var_1 = 1000;
  var_2 = 3000;

  if(self.team == "allies") {
    var_1 = 2500;
    var_2 = 3500;
  }

  if(isDefined(self._id_041F)) {
    if(self._id_041F > 0.75) {
      var_3 = self._id_04F6.classname;

      if(isDefined(self._id_10D1F[var_3])) {
        var_1 = self._id_10D1F[var_3]._id_9F40;
        var_2 = self._id_10D1F[var_3]._id_9CAC;

        if(var_1 > var_2) {}
      }
    }
  }

  self._id_2C5E._id_011B._id_AF7F = gettime() + randomintrange(int(var_1), int(var_2));
}

_id_81AE() {
  var_0 = gettime();
  self._id_2C5E._id_011B._id_F27C = var_0;
  _id_D646(1);
}

_id_F097(var_0) {}

_id_87D1(var_0) {
  if(self._id_017B) {
    return 0;
  }

  if(self._id_01D5) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_0230) && self._id_0230) {
    return 0;
  }

  if(isDefined(self._id_21BD)) {
    return anim._id_58E3;
  }

  if(scripts\anim\utility_common::_id_8A82()) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_DB96(var_0) {
  if(_id_DB83(var_0) == anim._id_58E3) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(!_func_011D(self._id_0192)) {
    return anim._id_58E3;
  }

  var_1 = distancesquared(self._id_0192.origin, self.origin);

  if(var_1 < 65536) {
    return anim._id_58E3;
  }

  var_2 = self _meth_885A(self._id_0192);

  if(gettime() - var_2 < 1000) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_DB83(var_0) {
  if(_id_6990() != "hide") {
    return anim._id_58E3;
  }

  if(self._id_017B) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_2C5E._id_011B._id_F27C)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_2C5E._id_011B._id_AF7F)) {
    return anim._id_58E3;
  }

  if(gettime() < self._id_2C5E._id_011B._id_AF7F) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_02ED.script_allow_lookpeek) && !self._id_02ED.script_allow_lookpeek) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_8219(var_0) {
  var_1 = 500;
  var_2 = 1500;
  var_3 = gettime();
  self._id_2C5E._id_011B._id_9814 = var_3;
  self._id_2C5E._id_011B._id_97F8 = randomintrange(var_1, var_2);
  self._id_2C5E._id_011B._id_97F6 = 3000;
}

_id_F099(var_0) {
  if(isDefined(self._id_2C5E._id_011B)) {
    _id_D646(0);
  }
}

_id_3DE7(var_0) {
  _id_D4EA("look");
  var_1 = self._id_2C5E._id_011B._id_9814;
  var_2 = self._id_2C5E._id_011B._id_97F8;
  var_3 = self._id_2C5E._id_011B._id_97F6;

  if(isDefined(self._id_0323)) {
    return anim._id_EACB;
  }

  if(self _meth_81E9()) {
    return anim._id_EACB;
  }

  if(isDefined(self._id_02ED.script_allow_lookpeek) && !self._id_02ED.script_allow_lookpeek) {
    return anim._id_EACB;
  }

  var_4 = gettime();

  if(_id_0009::_id_1C4F("cover_trans", "end")) {
    var_3 = var_4 - var_1;
  }

  if(var_4 - var_1 > var_3 + var_2) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_3DEB(var_0) {
  _id_D4EA("peek");

  if(_id_0009::_id_1C4F("cover_peek", "end")) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_F09A(var_0) {
  if(isDefined(self._id_2C5E._id_011B)) {
    _id_D4EA("hide");
    _id_D646(0);
  }
}

_id_A361(var_0) {
  if(!isDefined(self._id_02ED) && self._id_0131 == "prone") {
    return anim._id_EACB;
  }

  if(self._id_02ED.type == "Conceal Prone" || self._id_02ED.type == "Cover Prone") {
    if(self._id_0131 != "prone" || _id_06BD::_id_23C7() != "prone") {
      return anim._id_EACB;
    }

    return anim._id_58E3;
  }

  if(!self _meth_81E8(self._id_0131)) {
    return anim._id_EACB;
  }

  var_1 = undefined;

  if(self._id_02ED _meth_80B9("stand") && !self._id_02ED _meth_80B9("crouch")) {
    var_1 = "stand";
  } else if(self._id_02ED _meth_80B9("crouch") && !self._id_02ED _meth_80B9("stand")) {
    var_1 = "crouch";
  }

  if(isDefined(self._id_0B67._id_012D) && self._id_0B67._id_012D != self._id_02ED.type) {
    var_1 = "crouch";
  }

  if(isDefined(var_1)) {
    _id_06BD::_id_23F7(var_1);
  }

  return anim._id_58E3;
}

_id_DB10(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_BFCD) && self._id_0131 == "stand") {
    return anim._id_58E3;
  }

  if(self._id_02ED.type != "Cover Right" && self._id_02ED.type != "Cover Left") {
    return anim._id_58E3;
  }

  if(scripts\engine\utility::_id_8943(self._id_02ED)) {
    return anim._id_58E3;
  }

  if(self._id_0131 == "stand" && !self._id_02ED _meth_80B9("crouch")) {
    return anim._id_58E3;
  }

  if(self._id_0131 == "crouch" && !self._id_02ED _meth_80B9("stand")) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_2C5E._id_011B._id_33E3)) {
    _id_D4E8();
  }

  if(gettime() < self._id_2C5E._id_011B._id_33E3) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_D4E8() {
  self._id_2C5E._id_011B._id_33E3 = gettime() + randomintrange(5000, 20000);
}

_id_815F(var_0) {
  _id_D4E8();
  var_1 = undefined;
  var_2 = undefined;

  if((self._id_0131 != "prone" || _id_06BD::_id_23C7() != "prone") && isDefined(self._id_02ED) && (self._id_02ED.type == "Conceal Prone" || self._id_02ED.type == "Cover Prone")) {
    var_1 = "prone";
  } else {
    if(isDefined(self._id_011F) && self._id_011F.type == "Cover Crouch") {
      var_3 = ["crouch", "stand", "prone"];
    } else {
      var_3 = ["stand", "crouch", "prone"];
    }

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4];

      if(self _meth_81E8(var_5)) {
        var_2 = var_5;

        if(!isDefined(self._id_011F) || self._id_011F _meth_80B9(var_5)) {
          var_1 = var_5;
          break;
        }
      }
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_2;
  }

  _id_06BD::_id_23F7(var_1);
  self._id_2C5E._id_011B._id_33E4 = gettime();
}

_id_3DD5(var_0) {
  if(_id_0009::_id_1C4F("cover_stance_trans", "end")) {
    return anim._id_EACB;
  }

  var_1 = 5000;
  var_2 = self._id_2C5E._id_011B._id_33E4;

  if(gettime() - var_2 > var_1) {
    return anim._id_EACB;
  }

  if(self._id_0131 == _id_06BD::_id_23C7()) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_F08C(var_0) {
  _id_06BD::_id_23F7(self._id_0131);
}

_id_75A7(var_0) {
  var_1 = 36;
  var_2 = var_0.origin;

  if(scripts\engine\utility::_id_8948(var_0)) {
    var_2 = var_2 + anglestoright(var_0.angles) * var_1;
  } else {
    var_2 = var_2 + anglestoleft(var_0.angles) * var_1;
  }

  if(!self _meth_86AF(var_2)) {
    return 0;
  }

  if(!_func_02AE(var_2, self, 1)) {
    return 0;
  }

  if(!scripts\engine\trace::_id_321B(var_0.origin, var_2, 15, 36, (0, 0, 0), self, scripts\engine\trace::_id_3EE0())) {
    return 0;
  }

  return 1;
}

getupdatedtimebetweenpeeks(var_0, var_1) {
  var_2 = self._id_04F6.classname;
  var_3 = self._id_10D1F[var_2];

  if(!isDefined(var_1) && isDefined(var_3)) {
    if(istrue(var_0)) {
      if(isDefined(self.mintimebetweenpeekslostenemyoverride) && isDefined(self.maxtimebetweenpeekslostenemyoverride)) {
        var_4 = self.mintimebetweenpeekslostenemyoverride;
        var_5 = self.maxtimebetweenpeekslostenemyoverride;
      } else {
        var_4 = var_3.mintimebetweenpeekslostenemy;
        var_5 = var_3.maxtimebetweenpeekslostenemy;
      }
    } else if(isDefined(self.mintimebetweenpeeksoverride) && isDefined(self.maxtimebetweenpeeksoverride)) {
      var_4 = self.mintimebetweenpeeksoverride;
      var_5 = self.maxtimebetweenpeeksoverride;
    } else {
      var_4 = var_3._id_9F43;
      var_5 = var_3._id_9CB3;
    }

    if(var_4 > var_5) {}

    var_1 = randomfloatrange(var_4, var_5) * 1000;
    var_6 = var_3._id_AC4A * var_3._id_AC4A;

    if(_func_011D(self._id_0192)) {
      var_7 = self _meth_8204(self._id_0192);
    } else {
      var_7 = self._id_0192.origin;
    }

    if(distancesquared(self.origin, var_7) <= var_6) {
      var_1 = var_1 * var_3._id_39DE;
    }
  }

  return var_1;
}

isallowedtoexpose(var_0) {
  if(istrue(var_0)) {
    self._id_2C5E._id_011B.timebetweenpeekslostenemy = getupdatedtimebetweenpeeks(1, self._id_2C5E._id_011B.timebetweenpeekslostenemy);
    var_1 = self._id_2C5E._id_011B.timebetweenpeekslostenemy;
  } else {
    self._id_2C5E._id_011B._id_F207 = getupdatedtimebetweenpeeks(0, self._id_2C5E._id_011B._id_F207);
    var_1 = self._id_2C5E._id_011B._id_F207;
  }

  if(isDefined(self._id_2C5E._id_011B._id_F210) && isDefined(var_1)) {
    var_2 = gettime();
    var_3 = self._id_2C5E._id_011B._id_F210;
    var_4 = var_2 - var_3;

    if(var_4 < var_1) {
      return 0;
    }
  }

  return 1;
}

_id_3DF3(var_0) {
  if(self._id_0063 || self _meth_8566()) {
    return anim._id_58E3;
  }

  if(self._id_01D5) {
    return anim._id_EACB;
  }

  if(isDefined(self._id_21BD)) {
    return anim._id_EACB;
  }

  if(self._id_017B) {
    return anim._id_EACB;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(istrue(self._id_4E6C)) {
    return anim._id_EACB;
  }

  if(!isallowedtoexpose(0)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_02ED.script_aicanstepout) && self._id_02ED.script_aicanstepout == 0) {
    return anim._id_58E3;
  }

  if(scripts\engine\utility::_id_0F78() && scripts\engine\utility::_id_8942(self._id_02ED)) {
    if(scripts\engine\utility::_id_8949(self._id_02ED)) {
      return anim._id_EACB;
    }

    var_1 = _id_08F1::_id_6B9C(self._id_02ED, 0);
    var_2 = _func_000B(self.angles[0] - var_1[0]);
    var_3 = _func_000B(self.angles[1] - var_1[1]);
    var_4 = _func_000B(self.angles[2] - var_1[2]);

    if(abs(var_2) > 5 || abs(var_3) > 5 || abs(var_4) > 5) {
      return anim._id_58E3;
    }

    var_5 = (self._id_0192.origin + scripts\anim\utility_common::_id_69FC()) / 2;
    var_6 = var_5 - self.origin;
    var_7 = _func_01C8(var_6, self._id_02ED.angles);
    var_8 = vectortoangles(var_7);
    var_2 = _func_000B(var_8[0]);
    var_3 = _func_000B(var_8[1]);
    var_9 = _func_03AA(self._id_02ED, self._id_0131);

    if(var_2 > var_9[1] || var_2 < var_9[0]) {
      return anim._id_58E3;
    }

    if(var_3 > var_9[3] || var_3 < var_9[2]) {
      return anim._id_58E3;
    }

    return anim._id_EACB;
  } else {
    var_10 = _func_03A9(self._id_02ED, self._id_0131);
    var_11 = self._id_02ED.origin + scripts\anim\utility_common::_id_6BA2(self._id_02ED);
    var_6 = self._id_0192.origin - var_11;
    var_12 = vectortoangles(var_6);
    var_8 = _func_000B(var_12[1] - self._id_02ED.angles[1]);

    if(var_10[0] <= var_8 && var_8 <= var_10[1]) {
      if(scripts\engine\utility::_id_8948(self._id_02ED) && var_8 > var_10[3] || scripts\engine\utility::_id_8946(self._id_02ED) && var_8 < var_10[2]) {
        var_13 = scripts\engine\utility::_id_6984();

        if(!_id_75A7(self._id_02ED) || var_13) {
          return anim._id_58E3;
        }
      }

      return anim._id_EACB;
    }

    return anim._id_58E3;
  }
}

initexposetime() {
  if(_id_6990() != "exposed" || !isDefined(self._id_2C5E._id_011B._id_F27B)) {
    self._id_025F = 1;
    self._id_2C5E._id_011B._id_F27B = gettime() + 3000;
    self._id_2C5E._id_011B._id_9C6D = undefined;
  }
}

_id_818E(var_0) {
  self._id_2C5E._id_82FD[var_0] = spawnStruct();
  initexposetime();
  _id_06BD::_id_23AC(var_0);
  self._id_2C5E._id_9921 = 0;
  var_1 = scripts\anim\utility_common::_id_8766();

  if(var_1) {
    _id_06AC::_id_D9FD();
  }
}

cleanupexpose(var_0) {
  if(istrue(self._id_0B67._id_03CE) && self._id_0B67._id_03CD == var_0) {
    _id_06BD::_id_23B5();
    _id_06AC::_id_D9F8();
    self._id_2C5E._id_9921 = 0;
    self._id_2C5E._id_011B._id_F207 = undefined;
    self._id_2C5E._id_011B.timebetweenpeekslostenemy = undefined;
    self._id_2C5E._id_011B._id_F210 = gettime();
  }

  _id_06BD::_id_23EE(0);
}

_id_F091(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
  cleanupexpose(var_0);
}

updatemaxexposedtime() {
  var_0 = self getentitynumber() * 3 % 1000;

  if(isDefined(self._id_2C5E._id_011B._id_9C6D)) {
    return var_0;
  }

  var_1 = 2000 + var_0;
  var_2 = 3500 + var_0;
  var_3 = self._id_04F6.classname;
  var_4 = 1;
  var_5 = 65536;
  var_6 = self._id_10D1F[var_3];

  if(isDefined(var_6)) {
    var_1 = var_6._id_9EFC;
    var_2 = var_6._id_9C6D;

    if(var_1 > var_2) {}

    var_4 = var_6._id_39DD;
    var_5 = var_6._id_AC4A * var_6._id_AC4A;
  }

  self._id_2C5E._id_011B._id_9C6D = randomfloatrange(var_1, var_2);

  if(isDefined(self._id_0192)) {
    if(_func_011D(self._id_0192)) {
      var_7 = self _meth_8204(self._id_0192);
    } else {
      var_7 = self._id_0192.origin;
    }

    if(distancesquared(self.origin, var_7) <= var_5) {
      self._id_2C5E._id_011B._id_9C6D = self._id_2C5E._id_011B._id_9C6D * var_4;
    }
  }

  return var_0;
}

_id_3DDD(var_0) {
  if(!isDefined(self._id_0192) && !self._id_017B) {
    return anim._id_58E3;
  }

  var_1 = updatemaxexposedtime();
  var_2 = 2500 + var_1;
  var_3 = 1000;
  var_4 = gettime();

  if(_id_0009::_id_1C4F("cover_trans", "end")) {
    self._id_2C5E._id_011B._id_F27B = var_4;
  }

  var_5 = self._id_2C5E._id_011B._id_F27B;
  var_6 = var_4 - var_5;

  if(self._id_017B && var_6 > var_3) {
    _id_97F9(var_0);
  }

  var_7 = self._id_011F;

  if(isDefined(self._id_21BD) || self._id_01D5) {
    _id_3DF1(var_0);

    if(scripts\engine\utility::_id_8946(var_7) || scripts\engine\utility::_id_8948(var_7)) {
      _id_06BD::_id_23EB("B");
    } else {
      _id_06BD::_id_23EB("full exposed");
    }

    _id_D4EA("exposed");

    if(self._id_01D5) {
      _id_06BD::_id_23F5(0);
      return anim._id_CA5F;
    }

    if(_id_DBC5(var_0, 0) == anim._id_EACB) {
      _id_06BD::_id_23F5(1);
      return anim._id_58E3;
    }

    _id_06BD::_id_23F5(0);
    return anim._id_CA5F;
  }

  if(_id_DBC5(var_0, 0) == anim._id_EACB) {
    if(var_6 > var_3) {
      return anim._id_58E3;
    }

    _id_06AC::_id_C30E();
  }

  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(scripts\engine\utility::_id_0F78()) {
    var_12 = self._id_0192 _meth_811B();
    var_13 = var_12 - self getEye();

    if(scripts\engine\utility::_id_8949(var_7)) {
      var_11 = vectortoangles(var_13);
    } else if(scripts\engine\utility::_id_8942(var_7)) {
      var_8 = _func_03AA(var_7, self._id_0131);
      var_13 = _func_01C8(var_13, var_7.angles);
      var_11 = vectortoangles(var_13);
      var_14 = _func_000B(var_11[0]);
      var_15 = _func_000B(var_11[1]);

      if(var_14 > var_8[1] || var_14 < var_8[0]) {
        return anim._id_58E3;
      }

      if(var_15 > var_8[3] || var_15 < var_8[2]) {
        return anim._id_58E3;
      }
    }
  } else {
    var_8 = _func_03A9(var_7, self._id_0131);
    var_16 = undefined;

    if(_func_011D(self._id_0192) && !self _meth_8067(self._id_0192)) {
      var_16 = scripts\engine\utility::ter_op(isDefined(self._id_03DC), self._id_03DC, self._id_0192.origin + (0, 0, 60));
    } else {
      var_16 = scripts\anim\utility_common::_id_69FC();
    }

    var_17 = var_7.origin + scripts\anim\utility_common::_id_6BA2(var_7);
    var_13 = var_16 - var_17;
    var_11 = vectortoangles(var_13);
    var_9 = _func_000B(var_11[1] - var_7.angles[1]);
    var_10 = _func_000B(var_11[0] - var_7.angles[0]);

    if(var_9 < var_8[0] || var_9 > var_8[1]) {
      if(self._id_017B) {
        _id_3DF1(var_0);

        if(scripts\engine\utility::_id_8946(var_7) || scripts\engine\utility::_id_8948(var_7)) {
          _id_06BD::_id_23EB("B");
        } else {
          _id_06BD::_id_23EB("full exposed");
        }

        _id_D4EA("exposed");

        if(_id_DBC5(var_0, 0) == anim._id_EACB) {
          _id_06BD::_id_23F5(1);
        } else {
          _id_06BD::_id_23F5(0);
        }

        return anim._id_CA5F;
      } else
        return anim._id_58E3;
    }
  }

  var_18 = _id_3DF1(var_0);

  if(!istrue(self._id_0B67._id_03C0)) {
    if(!var_18) {
      if(var_6 > var_2 && !self._id_017B) {
        return anim._id_58E3;
      }
    } else if(var_6 > self._id_2C5E._id_011B._id_9C6D && !self._id_017B)
      return anim._id_58E3;
  }

  if(!self._id_017B && isDefined(self._id_0192)) {
    var_19 = self._id_2C5E._id_82FD[var_0];
    var_20 = !var_18 && self _meth_8067(self._id_0192);

    if(!var_20) {
      var_19._id_31CA = undefined;
    } else if(isDefined(var_19._id_31CA)) {
      if(var_4 - var_19._id_31CA > 2000) {
        return anim._id_58E3;
      }
    } else
      var_19._id_31CA = var_4;
  }

  if(isDefined(self._id_041F)) {
    if(self._id_041F > 0.75) {
      return anim._id_58E3;
    }
  }

  var_21 = self _meth_873A(var_9, var_10, scripts\engine\utility::_id_6984(), _id_06BD::_id_23DC(), var_4 - self._id_0DDF._id_ADFA);

  if(var_21) {
    return anim._id_CA5F;
  }

  return anim._id_58E3;
}

_id_3DF1(var_0) {
  var_1 = _id_06AC::_id_DBCC();

  if(var_1) {
    var_1 = _id_06AC::_id_2EBA();
  } else {
    self._id_70E0 = undefined;
  }

  if(!var_1) {
    self._id_2C5E._id_9921 = 0;
    _id_06BD::_id_23EE(0);
    return 0;
  }

  if(self _meth_8067(self._id_0192)) {
    self _meth_8858(self._id_0192 _meth_8176(), self._id_0192, 1);
  } else {
    self _meth_8858(self._id_70E0, self._id_0192, 0);
  }

  if(istrue(self._id_0086) || _id_06AC::_id_8738()) {
    if(self _meth_8867(0)) {
      self._id_2C5E._id_9921 = 0;
      _id_06BD::_id_23EE(0);
      return 0;
    }

    if(!self._id_2C5E._id_9921) {
      self _meth_8868();
    }

    self _meth_886B();
    self._id_2C5E._id_9921 = istrue(self._id_0B67._id_03CE);
  } else
    self._id_2C5E._id_9921 = 0;

  if(self _meth_886C()) {
    self._id_2C5E._id_9921 = 0;
    _id_06BD::_id_23EE(0);
    return 0;
  }

  _id_06BD::_id_23EE(self._id_2C5E._id_9921);
  return 1;
}

_id_8823(var_0, var_1) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(distancesquared(self._id_0192.origin, self._id_3D95) < 256) {
    return anim._id_58E3;
  } else if(scripts\anim\utility_common::_id_31CD()) {
    return anim._id_EACB;
  } else {
    return anim._id_58E3;
  }
}

_id_DBFF(var_0) {
  var_1 = 50;

  if(istrue(self._id_1223)) {
    var_1 = 30;
  }

  if(istrue(self._id_103AF)) {
    var_1 = 10;
  }

  if(istrue(self._id_A440)) {
    var_1 = 0;
  }

  return randomint(100) <= var_1;
}

_id_D60D() {
  if(isDefined(self._id_2C5E._id_011B)) {
    if(istrue(self._id_A573)) {
      self._id_2C5E._id_011B._id_A4C7 = gettime();
    } else if(istrue(self._id_103AF)) {
      self._id_2C5E._id_011B._id_A4C7 = gettime() + randomintrange(2000, 3000);
    } else if(istrue(self._id_1223)) {
      self._id_2C5E._id_011B._id_A4C7 = gettime() + randomintrange(5000, 7000);
    } else {
      self._id_2C5E._id_011B._id_A4C7 = gettime() + randomintrange(7000, 12000);
    }
  }
}

_id_D579() {
  if(istrue(self._id_A573)) {
    level._id_A4C7 = gettime();
  } else if(istrue(self._id_103AF)) {
    level._id_A4C7 = gettime() + randomintrange(1000, 2000);
  } else if(istrue(self._id_1223)) {
    level._id_A4C7 = gettime() + randomintrange(2000, 3000);
  } else {
    level._id_A4C7 = gettime() + randomintrange(3000, 5000);
  }
}

_id_314E() {
  if(self.team == "allies" && !istrue(self._id_1598)) {
    return 0;
  }

  if(self._id_04B9 == "c6") {
    return 0;
  }

  if(!scripts\anim\weaponlist::_id_FF06()) {
    return 0;
  }

  if(weaponclass(self._id_04F6) == "mg") {
    return 0;
  }

  if(isDefined(self._id_49DC) && self._id_49DC == 1) {
    return 0;
  }

  if(isDefined(self._id_011F._id_CE18) && self._id_011F._id_CE18 == "no_blindfire") {
    return 0;
  }

  if(abs(self._id_0192.origin[2] - self.origin[2]) > 100) {
    return 0;
  }

  var_0 = self._id_011F.type;

  switch (var_0) {
    case "Cover Right":
    case "Cover Left":
      return 1;
    case "Cover Crouch":
      return 0;
    case "Conceal Prone":
    case "Cover Prone":
    case "Conceal Stand":
    case "Conceal Crouch":
      return 0;
    case "Cover Stand":
      if(self._id_02ED scripts\engine\utility::_id_8AE7("over")) {
        return 1;
      }

      return 0;
  }

  return 1;
}

_id_DB0C(var_0) {
  if(!_id_314E()) {
    return anim._id_58E3;
  }

  if(isDefined(level._id_A4C7) && gettime() < level._id_A4C7) {
    return anim._id_58E3;
  }

  if(gettime() < self._id_2C5E._id_011B._id_A4C7) {
    return anim._id_58E3;
  }

  if(!_id_8823() && !scripts\anim\utility_common::_id_31EB()) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_3DD4(var_0) {
  if(_id_0009::_id_1C4F("cover_blindfire", "end")) {
    return anim._id_EACB;
  }

  _id_06BD::_id_23EA(1);
  return anim._id_CA5F;
}

_id_F08B(var_0) {
  _id_06BD::_id_23EA(0);
  _id_D60D();
  _id_D579();
}

_id_DBFB(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(!isalive(self._id_0192)) {
    return anim._id_58E3;
  }

  if(_id_06BD::_id_23E5()) {
    return anim._id_58E3;
  }

  var_1 = 0;

  if(isDefined(anim._id_F191) && isPlayer(self._id_0192)) {
    var_1 = 1;
  } else if(isDefined(self._id_F190)) {
    var_1 = 1;
  }

  if(!var_1) {
    return anim._id_58E3;
  }

  _id_06BA::_id_D45E(self._id_0192);
  return anim._id_EACB;
}

_id_DBFA(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(self._id_017B) {
    return anim._id_58E3;
  }

  if(self._id_0206 <= 0) {
    return anim._id_58E3;
  }

  if(isnullweapon(self._id_020A)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_0192) && isDefined(self._id_0192._id_4DA5)) {
    return anim._id_58E3;
  }

  var_1 = self._id_011F;

  if(var_1.type == "Cover Prone" || var_1.type == "Conceal Prone") {
    return anim._id_58E3;
  }

  if(istrue(self._id_A589)) {
    return anim._id_58E3;
  }

  var_2 = self._id_0192;
  var_3 = anglesToForward(var_1.angles);
  var_4 = var_2.origin - self.origin;
  var_5 = _func_0135(var_4);
  var_6 = 2560000;

  if(var_5 > var_6) {
    return anim._id_58E3;
  }

  var_7 = vectornormalize(var_4);

  if(vectordot(var_3, var_7) < 0) {
    return anim._id_58E3;
  }

  var_8 = 0.4;

  if(isDefined(self._id_041F)) {
    if(self._id_041F > 0.2) {
      var_9 = self._id_04F6.classname;

      if(isDefined(self._id_10D1F[var_9])) {
        var_8 = var_8 * self._id_10D1F[var_9]._id_EBAA;
      }
    }
  }

  var_10 = gettime();

  if(isDefined(self._id_2C5E._id_011B._id_8FDF) && var_10 < self._id_2C5E._id_011B._id_8FDF + var_8) {
    return anim._id_58E3;
  }

  self._id_2C5E._id_011B._id_8FDF = var_10;

  if(self._id_017B && !scripts\anim\utility_common::_id_C0F9()) {
    return anim._id_58E3;
  }

  if(istrue(self._id_0181) || istrue(var_2._id_017F)) {
    var_11 = 0;

    if(!var_11) {
      return anim._id_58E3;
    }
  }

  _id_06BA::_id_D45E(self._id_0192);

  if(!_id_06BA::_id_715D(var_2)) {
    return anim._id_58E3;
  }

  if(scripts\anim\utility_common::_id_31CD()) {
    if(!_id_06BA::_id_716F(var_2, var_2.origin)) {
      return anim._id_58E3;
    }

    return anim._id_EACB;
  }

  if(scripts\anim\utility_common::_id_31EB()) {
    return anim._id_EACB;
  }

  if(!_id_06BA::_id_716F(var_2, var_2.origin)) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_82AD(var_0) {
  _id_06BD::_id_23F9(1, self._id_0192);
  _id_D4EA("hide");
  self._id_2C5E._id_82FD[var_0] = gettime() + 3000;
}

_id_3DF7(var_0) {
  if(_id_0009::_id_1C4F("throwgrenade", "end")) {
    return anim._id_EACB;
  }

  if(_id_0009::_id_1C4F("throwgrenade", "start", 0)) {
    self._id_2C5E._id_82FD[var_0] = self._id_2C5E._id_82FD[var_0] + 10000;
  }

  if(gettime() > self._id_2C5E._id_82FD[var_0]) {
    return anim._id_58E3;
  }

  return anim._id_CA5F;
}

_id_F09E(var_0) {
  _id_06BD::_id_23F9(0);
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_FBFE(var_0) {
  if(isDefined(self._id_21BD)) {
    if(self.health < self.maxhealth * 0.75) {
      self._id_21BD = undefined;
    } else if(isDefined(self._id_0B67._id_CF24) && self._id_0B67._id_CF24.size >= 2) {
      self._id_21BD = undefined;
    }
  }

  return anim._id_EACB;
}

_id_874E(var_0) {
  if(self._id_017B) {
    return anim._id_EACB;
  }

  if(self._id_01D5) {
    return anim._id_EACB;
  }

  if(isDefined(self._id_21BD)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_FC40(var_0) {
  if(!isDefined(self._id_02ED) || self._id_02ED.type != "Cover Crouch") {
    self._id_0B67._id_012D = undefined;
    self._id_0B67._id_40A2 = undefined;
    return anim._id_EACB;
  }

  if(!isDefined(self._id_0B67._id_012D) || self._id_0B67._id_40A2 != self._id_02ED) {
    var_1 = self _meth_8473();

    if(var_1 > 0 && var_1 < 512) {
      var_2 = getDvar("#x3657f39fbcd013f07");

      if(isDefined(self._id_02ED._id_3DD8)) {
        var_2 = self._id_02ED._id_3DD8;

        if(var_2 != "Cover Right Crouch" && var_2 != "Cover Left Crouch" && var_2 != "Cover Crouch") {
          var_2 = undefined;
        }
      } else if(var_2 == "")
        var_2 = undefined;

      self._id_0B67._id_40A2 = self._id_02ED;
      self._id_0B67._id_012D = var_2;
    }
  }

  return anim._id_EACB;
}

_id_DB18(var_0) {
  var_1 = self._id_011F;

  if(!isDefined(var_1)) {
    return anim._id_58E3;
  }

  if(!var_1 _meth_80BB()) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_3DE9(var_0) {
  if(_id_06BD::_id_23CF()) {
    [var_2, var_3] = _id_06BD::_id_23C4();
    var_4 = _id_06BD::_id_23BC();

    if(var_3 == var_2.type) {
      _id_06BD::_id_23FE();
    }

    return anim._id_CA5F;
  }

  var_4 = _id_06BD::_id_23BC();
  var_5 = scripts\engine\utility::_id_690C(var_4);

  if(!isDefined(var_5)) {
    return anim._id_58E3;
  }

  if(var_4.type == var_5) {
    return anim._id_58E3;
  }

  _id_06BD::_id_23ED("hide");
  _id_06BD::_id_23EC(var_4, var_5);
  return anim._id_CA5F;
}

_id_F08E(var_0) {
  if(_id_06BD::_id_23CF()) {
    _id_06BD::_id_23FE();
  }
}

_id_3DF5(var_0) {
  if(isDefined(self._id_02ED.script_aicanstepout) && self._id_02ED.script_aicanstepout == 0) {
    return anim._id_58E3;
  }

  if(!istrue(self._id_3DE0)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_816D(var_0) {
  initexposetime();
  self._id_2C5E._id_9921 = 0;
  var_1 = _id_06BD::_id_23BC();

  if(scripts\engine\utility::_id_8946(var_1) || scripts\engine\utility::_id_8948(var_1)) {
    _id_06BD::_id_23EB("B");
  } else if(var_1 _meth_80B9("stand")) {
    _id_06BD::_id_23EB("full exposed");
  } else {
    _id_06BD::_id_23EB("exposed");
  }

  _id_D4EA("exposed");
  _id_06BD::_id_23AC(var_0);
}

_id_3DE0(var_0) {
  var_1 = _id_06BD::_id_23BC();

  if(!isDefined(self._id_3DDF) || self._id_3DDF < gettime()) {
    var_2 = randomintrange(self._id_3DE3, self._id_3DE2);
    self._id_3DDF = gettime() + int(var_2 * 1000);
    var_3 = undefined;

    if(!isDefined(self._id_0192)) {
      var_4 = var_1.angles;
      var_3 = (var_4[0], var_4[1] + randomintrange(0 - self._id_3DE1, self._id_3DE1), var_4[2]);
    } else {
      var_5 = self _meth_8204(self._id_0192);

      if(distancesquared(var_5, self._id_0192.origin) < 62500) {
        var_3 = self _meth_810B();

        if(isDefined(var_3) && _func_000C(var_3, var_1.angles) > 50) {
          var_3 = undefined;
        }
      }

      if(!isDefined(var_3)) {
        var_6 = var_5 - self _meth_86A9();
        var_3 = vectortoangles(var_6);
      }
    }

    if(isDefined(var_3)) {
      var_7 = anglesToForward(var_3) * 500;
      var_8 = self _meth_86A9() + var_7;

      if(!istrue(self._id_0B67._id_03CE)) {
        self _meth_8857(var_8, self._id_0192, 0);
      } else {
        self _meth_8858(var_8, self._id_0192, 0);
      }

      self._id_01D5 = 1;
      self.coverexposenoenemyshootpos = var_8;
    }
  }

  self._id_0B67._id_03C7 = "suppress";
  self._id_0B67._id_03C5 = 1;
  self._id_03D1 = self.coverexposenoenemyshootpos;
  var_9 = updatemaxexposedtime();
  var_10 = 2500 + var_9;
  var_11 = 1000;
  var_12 = gettime();

  if(_id_0009::_id_1C4F("cover_trans", "end")) {
    self._id_2C5E._id_011B._id_F27B = var_12;
  }

  var_13 = self._id_2C5E._id_011B._id_F27B;
  var_14 = var_12 - var_13;

  if(_id_DBC5(var_0, 0) == anim._id_EACB) {
    if(var_14 > var_11) {
      return anim._id_58E3;
    }

    _id_06AC::_id_C30E();
  }

  var_15 = _id_3DF1(var_0);

  if(!istrue(self._id_0B67._id_03C0)) {
    if(!var_15) {
      if(var_14 > var_10 && !self._id_017B) {
        return anim._id_58E3;
      }
    } else if(var_14 > self._id_2C5E._id_011B._id_9C6D && !self._id_017B)
      return anim._id_58E3;
  }

  return anim._id_CA5F;
}

_id_F08D(var_0) {
  self._id_0B67.shootparams_forceaim = 0;
  self._id_03D1 = undefined;
  self._id_01D5 = 0;
  cleanupexpose(var_0);
}

_id_3DF4(var_0) {
  if(isDefined(self._id_02ED.script_aicanstepout) && self._id_02ED.script_aicanstepout == 0) {
    return anim._id_58E3;
  }

  if(!istrue(self.coverexposelostenemy)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(!_func_011D(self._id_0192)) {
    return anim._id_58E3;
  }

  if(!isallowedtoexpose(1)) {
    return anim._id_58E3;
  }

  if(gettime() - self _meth_8205(self._id_0192) > self._id_3DDE * 1000) {
    var_1 = self _meth_84C2();

    if(!isDefined(var_1) || var_1.size == 0) {
      return anim._id_EACB;
    }
  }

  return anim._id_58E3;
}

_id_2D3E() {
  self endon("death");
  self._id_ACCE = 0;

  if(isDefined(self.team) && self.team == "axis") {
    for(;;) {
      self waittill("bulletwhizby", var_0, var_1, var_2, var_3, var_4);

      if(self._id_041F > 0.75 && !self._id_ACCE && getdvarint("#x35b6f4f20621e34ff", 0)) {
        self._id_ACCE = 1;
        self _meth_81B0("outline_nodepth_red");
        thread _id_EBB7();
      }
    }
  }
}

_id_EBB7() {
  while(self._id_ACCE && isalive(self)) {
    if(self._id_041F < 0.2) {
      self _meth_81AD();
      self._id_ACCE = 0;
    }

    waitframe();
  }

  self _meth_81AD();
  self._id_ACCE = 0;
}