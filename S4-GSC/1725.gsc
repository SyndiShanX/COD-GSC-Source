/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1725.gsc
*************************************************/

_id_23C2(var_0) {
  return undefined;
}

_id_2419() {
  if(isDefined(self._id_0B67._id_02A8) && self._id_0B67._id_02A8) {
    return 1;
  }

  if(isDefined(self._id_0B67._id_2DED)) {
    return self._id_0B67._id_2DED;
  }

  return 0;
}

_id_23F7(var_0) {
  self._id_0B67._id_015E = var_0;
}

_id_23C7() {
  return self._id_0B67._id_015E;
}

_id_23D8(var_0, var_1, var_2, var_3) {
  var_4 = _id_08F1::_id_48AC();
  return var_4 == var_3;
}

_id_23D9(var_0, var_1, var_2, var_3) {
  return self._id_0B67._id_015E == var_3[0] && _id_0009::_id_1C61() == var_3[1];
}

_id_2408(var_0) {
  self._id_0095 = !isDefined(var_0) || var_0;
}

_id_23D5() {
  return self._id_0095;
}

_id_23DD(var_0, var_1, var_2, var_3) {
  return weaponclass(self._id_04F6) == var_3;
}

_id_2410(var_0, var_1, var_2, var_3) {
  if(weaponclass(self._id_04F6) != "rocketlauncher") {
    return 0;
  }

  var_4 = _id_23C9();

  if(!isDefined(var_4)) {
    return 0;
  }

  return var_4 != "rocketlauncher";
}

_id_23F2() {}

_id_23B2() {}

_id_23E5() {
  return self _meth_8566();
}

_id_23E6(var_0) {
  return self._id_0B67._id_02D7 == var_0;
}

_id_23F3(var_0) {
  self._id_0B67._id_02D7 = var_0;
}

_id_23FC(var_0) {
  self._id_0B67._id_0502 = var_0;
}

_id_23B7() {
  self._id_0B67._id_0502 = "none";
}

_id_23C9() {
  if(isDefined(self._id_0B67._id_0502) && self._id_0B67._id_0502 == "none") {
    return undefined;
  }

  return self._id_0B67._id_0502;
}

_id_23F5(var_0) {
  if(!isDefined(var_0)) {
    self._id_0B67._id_00A2 = 1;
  } else {
    self._id_0B67._id_00A2 = var_0;
  }
}

_id_23E9() {
  return self._id_0B67._id_00A2;
}

_id_23F9(var_0, var_1) {
  if(!isDefined(var_0)) {
    self._id_0B67._id_2C69 = 1;
  } else {
    self._id_0B67._id_2C69 = var_0;
  }

  if(self._id_0B67._id_2C69) {
    self._id_0B67._id_F193 = var_1;
  } else {
    self._id_0B67._id_F193 = undefined;
  }
}

_id_2416() {
  if(isDefined(self._id_0B67._id_2C69)) {
    return self._id_0B67._id_2C69 && isDefined(self._id_0B67._id_F193);
  }

  return 0;
}

_id_23CB() {
  return self._id_0B67._id_F193;
}

_id_23EE(var_0) {
  if(!isDefined(var_0)) {
    self._id_0B67._id_0091 = 1;
  } else {
    self._id_0B67._id_0091 = var_0;
  }
}

_id_23B9() {
  return istrue(self._id_0B67._id_0091);
}

_id_23AC(var_0) {
  self._id_0B67._id_03CD = var_0;
}

_id_240E() {
  if(!istrue(self._id_0B67._id_03CE)) {
    return 0;
  }

  if(!isDefined(self._id_0B67._id_03C9)) {
    return 0;
  }

  return self._id_0B67._id_03CF == self._id_0B67._id_03C9;
}

_id_2418(var_0) {
  self._id_0B67._id_03C8 = var_0;
}

_id_23B5() {
  self._id_0B67._id_03C3 = undefined;
  self._id_0B67._id_03CE = 0;
}

_id_240C(var_0, var_1) {}

_id_240F() {
  if(istrue(self._id_0B67._id_03CE)) {
    if(isDefined(self._id_03D1) && isDefined(self._id_0B67._id_03C8)) {
      return 1;
    }

    if(istrue(self._id_0181)) {
      return 0;
    }

    if(isDefined(self _meth_8182())) {
      var_0 = _id_08F1::_id_F887();

      if(isDefined(var_0)) {
        return 1;
      }
    }

    if(isDefined(self._id_0B67._id_03C3) && isDefined(self._id_0192) && self._id_0192 == self._id_0B67._id_03C3) {
      return self _meth_8659();
    }
  }

  return 0;
}

_id_23ED(var_0) {
  self._id_0B67._id_0125 = var_0;
}

_id_23C5() {
  if(!isDefined(self._id_0B67._id_0125)) {
    return "none";
  }

  return self._id_0B67._id_0125;
}

_id_23EB(var_0) {
  self._id_0B67._id_011D = var_0;
}

_id_23C3() {
  return self._id_0B67._id_011D;
}

_id_23EA(var_0) {
  self._id_0B67._id_0098 = var_0;
}

_id_2403(var_0) {
  self._id_011F = var_0;
}

_id_23CC(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_011F);
}

_id_23BC() {
  return self._id_011F;
}

_id_23C8() {
  if(isDefined(self._id_0B67._id_C574)) {
    return self._id_0B67._id_C574;
  }

  return undefined;
}

_id_23FA(var_0) {
  self._id_0B67._id_C574 = var_0;
}

_id_23FB(var_0) {
  self._id_0B67._id_C575 = var_0;
}

_id_23CD(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0B67._id_03D5) && isDefined(self._id_02ED) && self._id_0B67._id_03D5 == self._id_02ED && distancesquared(self._id_02ED.origin, self.origin) > 16;
}

_id_2400() {
  self._id_0B67._id_005E = 1;
}

_id_23AD() {
  self._id_0B67._id_005E = 0;
}

_id_23CE() {
  if(isDefined(self.script)) {
    if(self.script == "scripted" || self.script == "<custom>") {
      return 1;
    }
  }

  return istrue(self._id_0B67._id_005E);
}

_id_23F0(var_0) {
  self._id_0B67._id_02A8 = 1;
  self._id_0B67._id_9D9D = var_0;
  self._id_0B67._id_9D9C = 0;
}

_id_23C0() {
  if(!self._id_0B67._id_02A8) {
    return undefined;
  }

  return self._id_0B67._id_9D9D;
}

_id_23AF() {
  self._id_0B67._id_02A8 = 0;
  self._id_0B67._id_9D9D = undefined;
}

_id_23B0() {
  self._id_0B67._id_9D9C = undefined;
}

_id_23E2(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0B67._id_9D9C);
}

_id_23E1(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0B67._id_9D9C) && self._id_0B67._id_9D9C;
}

_id_23E3() {
  return self._id_0B67._id_02A8;
}

_id_23E4(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_9D39)) {
    return 1;
  }

  if(!isDefined(self._id_9D39.target)) {
    return 1;
  }

  return 0;
}

_id_23F1(var_0, var_1) {
  self._id_0B67._id_02A9 = 1;
  self._id_0B67._id_9D9A = var_0;
  self._id_0B67._id_9D9B = var_1;
  var_0 notify("being_melee_charged", self);
}

_id_23AE() {
  self._id_0B67._id_02A9 = 0;
  self._id_0B67._id_9D9A = undefined;
  self._id_0B67._id_9D9B = undefined;
}

_id_23E0() {
  return isDefined(self._id_0B67._id_02A9) && self._id_0B67._id_02A9 && isDefined(self._id_0323);
}

_id_23DF(var_0, var_1, var_2, var_3) {
  if(_id_23E0()) {
    return 0;
  }

  return 1;
}

_id_23BE() {
  if(!isDefined(self._id_0B67._id_02A9) || !self._id_0B67._id_02A9) {
    return undefined;
  }

  return self._id_0B67._id_9D9A;
}

_id_23BF() {
  return self._id_0B67._id_9D9B;
}

_id_23EF(var_0) {
  self._id_0B67._id_0093 = var_0;
}

_id_23FD(var_0) {
  self._id_0B67._id_10E14 = var_0;
}

_id_23DE() {
  return isDefined(self._id_0B67._id_10E14);
}

_id_23CA() {
  return self._id_0B67._id_10E14;
}

_id_23D1() {
  var_0 = _id_23BC();

  if(!isDefined(var_0)) {
    var_0 = self._id_02ED;
  }

  var_1 = isDefined(var_0) && (var_0.type == "Conceal Crouch" || var_0.type == "Conceal Stand");
  return self._id_0B67._id_02D7 == "frantic" && !var_1;
}

_id_23D6() {
  var_0 = _id_23C1();

  if(isDefined(var_0)) {
    return 1;
  }

  return 0;
}

_id_23C1() {
  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(self._id_0B67._id_4B43)) {
    return var_1;
  }

  if(isDefined(self._id_0B67._id_4B43["left_leg"])) {
    var_0++;
    var_1 = "left";
  }

  if(isDefined(self._id_0B67._id_4B43["right_leg"])) {
    var_0++;
    var_1 = "right";
  }

  if(var_0 == 2) {
    var_1 = "both";
  }

  return var_1;
}

_id_8971(var_0) {
  if(!isDefined(self._id_0B67)) {
    return 0;
  }

  if(isDefined(self._id_0B67._id_CF24)) {
    if(!isDefined(self._id_0B67._id_CF24[var_0])) {
      return 0;
    }

    return self._id_0B67._id_CF24[var_0]._id_E747 == "dismember";
  }

  if(!isDefined(self._id_0B67._id_4B43)) {
    return 0;
  }

  return isDefined(self._id_0B67._id_4B43[var_0]);
}

_id_23D7(var_0, var_1, var_2, var_3) {
  return _id_8971(var_3);
}

_id_10A1C(var_0) {
  if(isDefined(self._id_0B67._id_CF24)) {
    if(!isDefined(self._id_0B67._id_CF24[var_0])) {
      return 0;
    }

    if(self._id_0B67._id_CF24[var_0]._id_E747 != "dismember") {
      return 0;
    }

    return self._id_0B67._id_CF24[var_0]._id_F1E8 == gettime();
  }

  if(!isDefined(self._id_0B67._id_4B43)) {
    return 0;
  }

  if(!isDefined(self._id_0B67._id_4B43[var_0])) {
    return 0;
  }

  return self._id_0B67._id_4B43[var_0] == gettime();
}

_id_241A(var_0, var_1, var_2, var_3) {
  return _id_10A1C(var_3);
}

_id_241B(var_0, var_1, var_2, var_3) {
  return _id_8971(var_3[0]) && _id_10A1C(var_3[1]);
}

_id_23B8(var_0) {
  self._id_0B67._id_4B43[var_0] = gettime();
}

_id_240B(var_0) {
  self._id_0B67._id_D083 = var_0;
}

_id_23DB() {
  if(!isDefined(self._id_0B67._id_D083)) {
    if(isDefined(self._id_2C5E._id_5EBD) && gettime() > self._id_2C5E._id_5EBD) {
      self._id_0B67._id_D083 = 1;
    }
  }

  return isDefined(self._id_0B67._id_D083);
}

_id_23FF() {
  self._id_0B67._id_D084 = 1;
}

_id_2411() {
  return isDefined(self._id_0B67._id_D084);
}

_id_2406(var_0) {
  self._id_0B67._id_8890 = var_0;
}

_id_23D3() {
  if(isDefined(self._id_2C5E._id_3EBE)) {
    return 0;
  }

  return isDefined(self._id_0B67._id_8890);
}

_id_2401(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = "left";

  if(var_0 == var_2) {
    var_2 = "right";
  }

  if(isDefined(self._id_0B67._id_C8C1) && isDefined(self._id_0B67._id_C8C1[var_2])) {
    self._id_0B67._id_C8C1[var_2] = 0;
    self._id_0B67._id_C8C1[var_0] = 0;
    return;
  }

  self._id_0B67._id_C8C1[var_0] = var_1;
}

_id_23AA(var_0) {
  if(!isDefined(self._id_0B67._id_C8C1)) {
    return 0;
  }

  if(!isDefined(self._id_0B67._id_C8C1[var_0])) {
    return 0;
  }

  if(!self._id_0B67._id_C8C1[var_0]) {
    return 0;
  }

  return 1;
}

_id_240A(var_0) {
  self._id_0B67._id_C8C2 = var_0;
}

_id_23B4(var_0) {
  self._id_0B67._id_C8C3 = undefined;
}

_id_23DA(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0B67._id_C8C2)) {
    return 0;
  }

  return 1;
}

_id_2409(var_0) {
  self._id_9D39 = spawnStruct();
  var_0._id_9D39 = spawnStruct();
  self._id_9D39.target = var_0;
  self._id_9D39._id_AE83 = var_0;
  var_0._id_9D39._id_AE83 = self;
}

_id_23B1() {
  if(!isDefined(self._id_9D39)) {
    return;
  }
  if(isDefined(self._id_9D39.target)) {
    self._id_9D39.target._id_9D39 = undefined;
  }

  if(isDefined(self._id_9D39._id_F050)) {
    self._id_9D39._id_F050 delete();
  }

  self._id_9D39 = undefined;
}

_id_2404(var_0) {
  self._id_0B67._id_3EBD = var_0;
}

_id_23D0() {
  return isDefined(self._id_0B67._id_3EBD);
}

_id_2405(var_0) {
  self._id_0B67._id_75D4 = var_0;
}

_id_23D2() {
  return isDefined(self._id_0B67._id_75D4);
}

_id_23BD() {
  return self._id_0B67._id_75D4;
}

_id_2407(var_0) {
  self._id_0B67._id_241C = var_0;
}

_id_23D4() {
  return istrue(self._id_0B67._id_241C);
}

_id_2402(var_0) {
  if(isDefined(self._id_0B67._id_37E1) && self._id_0B67._id_37E1 == var_0) {
    return;
  }
  self._id_0B67._id_37E1 = var_0;
  self._id_0B67._id_37E2 = gettime();
}

_id_23BA() {
  return self._id_0B67._id_37E1;
}

_id_23BB() {
  return self._id_0B67._id_37E2;
}

_id_23AB(var_0) {
  scripts\engine\utility::set_movement_speed(var_0);
}

_id_23DC() {
  return istrue(self._id_0B67._id_DA3E);
}

_id_240D(var_0) {
  self._id_0B67._id_DA3E = var_0;
}

_id_2413() {
  return isDefined(self._id_0B67._id_DE1C);
}

_id_23F6(var_0) {
  self._id_0B67._id_DE1C = var_0;
}

_id_23C6() {
  return self._id_0B67._id_DE1C;
}

_id_23B6() {
  self._id_0B67._id_DE1C = undefined;
  _id_23B3();
}

_id_23F4() {
  self._id_0B67._id_29ED = 1;
}

_id_23B3() {
  self._id_0B67._id_29ED = undefined;
}

_id_23E7() {
  return istrue(self._id_0B67._id_29ED);
}

_id_23EC(var_0, var_1) {
  self._id_0B67._id_4C4E = var_0;
  self._id_0B67._id_4C4F = var_1;
}

_id_23C4() {
  return [self._id_0B67._id_4C4E, self._id_0B67._id_4C4F];
}

_id_23FE() {
  self._id_0B67._id_4C4E = undefined;
  self._id_0B67._id_4C4F = undefined;
}

_id_23CF() {
  return isDefined(self._id_0B67._id_4C4E);
}

_id_23A9(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_0B67._id_62ED)) {
    return 0;
  }

  if(isDefined(var_3) && self._id_0B67._id_62ED._id_62AA != var_3) {
    return 0;
  }

  if(!isDefined(self._id_0B67._id_62ED._id_90D4)) {
    return 0;
  }

  if(gettime() > self._id_0B67._id_62ED._id_F232) {
    return 0;
  }

  var_4 = self._id_0B67._id_62ED._id_90D4;

  if(!_id_0009::_id_1C72(var_2, var_4)) {
    return 0;
  }

  return 1;
}

_id_2412(var_0, var_1, var_2) {
  if(!istrue(self._id_0B67._id_89EF)) {
    return 0;
  }

  var_3 = 50;
  return randomint(100) <= var_3;
}