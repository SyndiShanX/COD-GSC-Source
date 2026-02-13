/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2821.gsc
*************************************************/

_id_318A(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return _func_0036(var_4, self._id_0359, self.height - var_2, self, 1, 0, 0, var_5);
}

_id_6BB3() {
  return 8;
}

_id_6B50() {
  return 360.0 / _id_6BB3();
}

_id_9D9F(var_0, var_1, var_2) {
  var_3 = var_1 * _id_6B50() - 180.0;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

_id_6B56(var_0) {
  return self._id_9D9E[var_0];
}

_id_FF4C(var_0) {
  if(!isDefined(self._id_9D9E)) {
    self._id_9D9E = [];
  }

  if(!isDefined(self._id_9D9E[var_0])) {
    self._id_9D9E[var_0] = [];

    for(var_1 = 0; var_1 < _id_6BB3(); var_1++) {
      self._id_9D9E[var_0][var_1] = spawnStruct();
      self._id_9D9E[var_0][var_1]._id_F27A = 0;
      self._id_9D9E[var_0][var_1]._id_37F2 = undefined;
      self._id_9D9E[var_0][var_1].origin = undefined;
      self._id_9D9E[var_0][var_1]._id_A74C = var_1;
    }
  }
}

_id_6BDD(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0.groundpos)) {
    var_1 = var_0.groundpos;

    if(isDefined(self._id_4BB4) && var_0 == self._id_4BB4 && _id_754A()) {
      var_2 = _id_6B73();

      if(isDefined(var_2)) {
        var_1 = var_2.origin;
      }
    }
  } else if(isPlayer(var_0) && (var_0 _meth_846A() || var_0 _meth_846B())) {
    if(!isDefined(var_0._id_B6C4)) {
      var_0._id_B6C4 = 0;
    }

    if(gettime() > var_0._id_B6C4) {
      var_0._id_B6C3 = getgroundposition(var_0.origin, 15);
      var_0._id_B6C4 = gettime();
    }

    if(isDefined(var_0._id_B6C3)) {
      var_1 = var_0._id_B6C3;
    }
  }

  return var_1;
}

_id_75C1(var_0, var_1) {
  for(var_2 = 0; var_2 < _id_6BB3(); var_2++) {
    var_3 = var_0 _id_6B56(var_1);
    var_4 = var_3[var_2];

    if(isDefined(var_4.origin)) {
      return 1;
    }
  }

  return 0;
}

_id_2EEE() {
  var_0 = self _meth_815E();
}

_id_754A() {
  var_0 = self _meth_815E();

  if(isDefined(var_0) && isDefined(self._id_4BB4._id_A3FD)) {
    var_1 = self._id_4BB4._id_A3FD["0"];

    if(isDefined(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_6B73() {
  var_0 = self _meth_815E();
  var_1 = self._id_4BB4._id_A3FD["0"];

  if(!_func_02B7(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

_id_DBF9() {
  if(_id_754A()) {
    var_0 = _id_6B73();

    if(!isDefined(var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_8831(var_0) {
  if(isDefined(self._id_4BB4) && var_0 == self._id_4BB4) {
    if(self._id_4BB5 > 5) {
      return 1;
    }
  }

  return 0;
}

_id_6B57(var_0, var_1) {
  var_2 = 0;

  if(var_2) {
    return var_0.origin;
  }

  if(getdvarint("#x3d870c876050f3466", 0)) {
    return var_0.origin;
  }

  var_0 _id_FF4C(self._id_9DA0);
  var_3 = var_0 _id_6B56(self._id_9DA0);
  var_4 = var_1;
  var_5 = self.origin - var_4;
  var_6 = _func_0135(var_5);

  if(var_6 < 256) {
    var_7 = -1;

    for(var_8 = 0; var_8 < _id_6BB3(); var_8++) {
      var_9 = var_3[var_8];

      if(isDefined(var_9._id_37F2) && var_9._id_37F2 == self) {
        var_7 = var_9._id_A74C;
      }
    }

    if(var_7 < 0) {
      var_7 = self getentitynumber() % _id_6BB3();
    }

    var_10 = var_7;
  } else {
    var_11 = _func_000B(_func_0261(var_5)) + 180.0;
    var_10 = var_11 / _id_6B50();
    var_7 = int(var_10 + 0.5);
  }

  var_12 = undefined;
  var_13 = -1;
  var_14 = 3;
  var_15 = 2;

  if(var_10 > var_7) {
    var_13 = var_13 * -1;
    var_14 = var_14 * -1;
    var_15 = var_15 * -1;
  }

  var_16 = _id_6BB3();

  for(var_17 = 0; var_17 < var_16 / 2 + 1; var_17++) {
    for(var_18 = var_13; var_18 != var_14; var_18 = var_18 + var_15) {
      var_19 = var_7 + var_17 * var_18;

      if(var_19 >= var_16) {
        var_19 = var_19 - var_16;
      } else if(var_19 < 0) {
        var_19 = var_19 + var_16;
      }

      var_9 = var_3[var_19];

      if(!isDefined(var_12) && gettime() - var_9._id_F27A >= self._id_9DA1) {
        if(isDefined(level._id_F739) && isDefined(level._id_F739[self._id_1210])) {
          [[level._id_F739[self._id_1210]]](var_9, var_4, self._id_1DF5, self._id_0359);
        } else {
          _id_F739(var_9, var_4, self._id_1DF5, self._id_0359);
        }
      }

      if(!isDefined(var_12) && isDefined(var_9.origin)) {
        var_20 = _func_02AB(var_0.origin, self);
        var_21 = _func_02A6(var_9.origin, var_20, self, 1);

        if(var_21["fraction"] < 0.95) {
          continue;
        }
        var_22 = 0;

        if(isDefined(var_9._id_37F2) && var_9._id_37F2 != self) {
          var_23 = vectornormalize(var_4 - var_9._id_37F2.origin) * self._id_0359 * 2;
          var_22 = distancesquared(var_9._id_37F2.origin + var_23, var_4);
        }

        if(!isalive(var_9._id_37F2) || !isDefined(var_9._id_37F2._id_012F) || var_9._id_37F2._id_012F != var_0 || var_9._id_37F2 == self || var_6 < var_22) {
          if(isalive(var_9._id_37F2) && var_9._id_37F2 != self) {
            if(!isDefined(var_9._id_37F2._id_CFF6)) {
              var_24 = var_9._id_37F2 getentitynumber();
            }

            var_9._id_37F2._id_CFF6 = undefined;
          }

          if(isDefined(self._id_CFF6) && self._id_CFF6 != var_9) {
            self._id_CFF6._id_37F2 = undefined;
          }

          if(!isDefined(self._id_CFF6) || self._id_CFF6 != var_9) {
            self._id_CFF6 = var_9;
            var_9._id_37F2 = self;
          }

          var_12 = var_9.origin;
        }
      }

      if(var_17 == 0) {
        break;
      }
    }
  }

  return var_12;
}

_id_F739(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0._id_F27A >= 50) {
    var_0.origin = _id_9D9F(var_1, var_0._id_A74C, var_2);
    var_0.origin = _id_5059(var_0.origin, var_3, 55);
    var_0._id_F27A = gettime();
  }
}

_id_5059(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 18;
  }

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self _meth_8008(var_4, var_5, var_1, var_2, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
}

_id_87D9() {
  return isDefined(self._id_4B40) && self._id_4B40;
}

_id_6B54() {
  if(!isDefined(self._id_9917) || self._id_9917) {
    return self._id_9D94;
  } else {
    return self._id_9D95;
  }
}

_id_6B55() {
  if(!isDefined(self._id_9917) || self._id_9917) {
    return self._id_9D97;
  } else {
    return self._id_9D96;
  }
}

_id_9918(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_9911 = var_0 * 1000.0;
  self._id_9912 = var_3;
  self._id_9910 = isDefined(var_4) && var_4;
  self._id_9914 = var_5;
  self._id_9919 = var_2;
  self._id_991A = _func_0219(self._id_9919);
  _id_D5F7(var_1);
}

_id_9916() {
  if(isDefined(self._id_4AA2) && self._id_4AA2 > 0) {
    self._id_4AA2--;

    if(self._id_4AA2 > 0) {
      return;
    }
  }

  self._id_9917 = 1;
}

_id_9915() {
  if(!isDefined(self._id_4AA2)) {
    self._id_4AA2 = 0;
  }

  self._id_4AA2++;
  self._id_9917 = 0;
}

_id_4C65(var_0, var_1, var_2, var_3) {
  self._id_4C60 = var_0 * 1000.0;
  self._id_4C5D = var_1;
  self._id_4C5C = var_2;
  self._id_4C59 = ["back", "right", "left"];
  self._id_4C5A = [];

  foreach(var_6, var_5 in self._id_4C59) {
    self._id_4C5A[var_6] = level._effect[var_3 + var_5];
  }
}

_id_4C63() {
  if(isDefined(self._id_4A95) && self._id_4A95 > 0) {
    self._id_4A95--;

    if(self._id_4A95 > 0) {
      return;
    }
  }

  self._id_4C64 = 1;
}

_id_4C62() {
  if(!isDefined(self._id_4A95)) {
    self._id_4A95 = 0;
  }

  self._id_4A95++;
  self._id_4C64 = 0;
}

_id_9159(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self._id_914E = var_0 * 1000.0;
  self._id_914D = var_1 * 1000.0;
  self._id_914C = var_2;
  self._id_9155 = var_3;
  self._id_9156 = _func_0219(self._id_9155);
  self._id_9157 = var_4;
  self._id_9158 = _func_0219(self._id_9157);
  self._id_9152 = var_6;
  self._id_914B = var_5;
  self._id_9153 = 0;
  self._id_9154 = 0;
}

_id_9150() {
  if(isDefined(self._id_4AA1) && self._id_4AA1 > 0) {
    self._id_4AA1--;

    if(self._id_4AA1 > 0) {
      return;
    }
  }

  self._id_9151 = 1;
}

_id_914F() {
  if(!isDefined(self._id_4AA1)) {
    self._id_4AA1 = 0;
  }

  self._id_4AA1++;
  self._id_9151 = 0;
}

_id_33D7(var_0, var_1) {
  self endon("death");
  self _meth_82C3(1);
  _id_0017::_id_D6EC(1, "ChangeAnimClass");
  self._id_82D2 = 1;
  self _meth_82C1("face angle abs", (0, self.angles[1], 0));
  self _meth_82B9("anim deltas");
  self _meth_82BA(1, 1);
  _id_0017::_id_B357(var_1, randomint(self _meth_810F(var_1)), "change_anim_class");
  self _meth_82DA(var_0);
  _id_0017::_id_D6EC(0, "ChangeAnimClass");
  self._id_82D2 = 0;
  self _meth_82C3(0);
}

_id_6E42(var_0) {
  var_1 = 50;
  var_2 = 32;
  var_3 = 72;
  var_4 = _func_00B0(var_0);
  var_4 = rotatevector(var_4, self.angles);
  var_5 = self.origin + var_4;
  var_6 = (0, 0, var_1);
  var_7 = self _meth_8008(var_5 + var_6, var_5 - var_6, var_2, var_3);
  var_8 = var_7 - var_5;
  return var_8[2];
}

_id_6C79(var_0, var_1, var_2, var_3) {
  var_4 = _func_0079(var_0);
  var_5 = _func_00B0(var_0, 0, var_3 / var_4);
  var_6 = rotatevector(var_5, var_2);
  return var_1 + var_6;
}

_id_6AFC(var_0) {
  var_1 = 0.2;
  var_2 = _func_0079(var_0);
  return min(var_1, var_2);
}

_id_AF9A(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self _meth_82B3(self.origin, var_0, var_1);
  wait(var_1);
  self _meth_82B9("anim deltas");
}

_id_6C06(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;

    if(var_0 < 0) {
      var_2 = randomint(var_4);
    } else {
      var_2 = var_3 + randomint(var_4);
    }
  }

  return var_2;
}

_id_8830(var_0) {
  var_1 = self.origin[2] + self.height;

  if(var_0.origin[2] < var_1) {
    return 0;
  }

  var_2 = self.origin[2] + self.height + 2 * self._id_0359;

  if(var_0.origin[2] > var_2) {
    return 0;
  }

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];

    if(abs(var_3) > 12) {
      return 0;
    }
  }

  var_4 = 15.0;

  if(isDefined(var_0._id_0359)) {
    var_4 = var_0._id_0359;
  }

  var_5 = self._id_0359 + var_4;
  var_5 = var_5 * var_5;

  if(distance2dsquared(self.origin, var_0.origin) > var_5) {
    return 0;
  }

  return 1;
}

_id_D55D(var_0) {
  self._id_01BD = var_0;
}

_id_4307(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("J_SpineLower");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectornormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
}

_id_4A0C() {
  if(!isDefined(self._id_4A9E)) {
    self._id_4A9E = 0;
  }

  self._id_4A9E++;
  _id_4A0D();
  _id_4A0E();
}

_id_74F7() {
  return istrue(self._id_7574);
}

_id_51FC() {
  if(isDefined(level._id_4A76) && level._id_4A76) {
    return;
  }
  if(isDefined(self._id_4A9E) && self._id_4A9E > 0) {
    self._id_4A9E--;

    if(self._id_4A9E > 0) {
      return;
    }
  }

  self._id_7574 = 1;
  _id_51FE();
  _id_D7CC();
  _id_51FD();
}

_id_51FE() {}

_id_4A0E() {}

_id_D7CC() {
  var_0 = clamp(level._id_10CB3 / 20, 0.0, 1.0);
  var_1 = _id_91A9(var_0, 0.35, 0.55);
  var_2 = _id_91A9(var_0, 0.06, 0.12);
  _id_9918(5.0, self._id_9D95 * 2, self._id_9D95 * 1.5, "attack_lunge_boost", level._effect["boost_lunge"]);
  _id_4C65(5.0, var_1, "dodge_boost", "boost_dodge_");
  _id_9159(10.0, 2.0, var_2, 550, 350, "leap_boost", level._effect["boost_jump"]);
}

_id_51FD() {
  _id_9916();
  _id_4C63();
  _id_9150();
}

_id_91A9(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

_id_4A0D() {
  _id_9915();
  _id_4C62();
  _id_914F();
}

_id_B201(var_0) {
  if(!isDefined(self._id_26BA)) {
    return;
  }
  if(self._id_26BA != "no_boost_fx") {
    playFXOnTag(var_0, self, self._id_26BA);
  }
}

_id_B4EF(var_0) {
  return var_0.inlaststand;
}

_id_5AD8(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(_id_B4EF(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(_id_A572(var_7)) {
      continue;
    }
    var_8 = 0;

    foreach(var_3 in var_1) {
      if(distancesquared(var_7.origin, var_3.origin) < 65536) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  return var_5;
}

_id_89C0(var_0, var_1) {
  var_2 = self._id_9D98 * self._id_9D98;
  return distancesquared(var_0, var_1) <= var_2;
}

_id_10E80() {
  return _id_89C0(self.origin, self._id_012F.origin);
}

_id_10E7E() {
  if(_id_6B54() == self._id_9D95) {
    return _id_10E7F();
  }

  var_0 = distancesquared(self.origin, self._id_012F.origin) <= _id_6B55();
  return var_0;
}

_id_10E7F() {
  var_0 = distancesquared(self.origin, self._id_012F.origin) <= self._id_9D96;

  if(!var_0 && (isPlayer(self._id_012F) || isagent(self._id_012F))) {
    var_1 = undefined;
    var_1 = self._id_012F _meth_84A5();

    if(isDefined(var_1) && isDefined(var_1._id_0481) && var_1._id_0481 == "care_package") {
      var_0 = distancesquared(self.origin, self._id_012F.origin) <= self._id_9D96 * 4;
    }
  }

  if(!var_0 && isPlayer(self._id_012F) && istrue(self._id_012F._id_88C0)) {
    if(length(self getvelocity()) < 5) {
      var_0 = distancesquared(self.origin, self._id_012F.origin) <= self._id_9D96 * 4;
    }
  }

  return var_0;
}

_id_D5F7(var_0) {
  self._id_9D94 = var_0;
  self._id_9D97 = var_0 * var_0;
}

_id_A572(var_0) {
  return !isDefined(var_0._id_110AE);
}

_id_6EA3() {
  if(!isDefined(level._id_11069)) {
    return 1;
  }

  return level._id_11069;
}

_id_107F7() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path");
    self._id_24F8 = 1;

    if(isDefined(self._id_4BB4)) {
      self._id_4BB5++;
    }
  }
}

_id_74EC() {
  return 1;
}

_id_4977() {
  if(isDefined(self._id_9012) && isDefined(self._id_9011) && distance2dsquared(self._id_012F.origin, self._id_9012) < 4 && distancesquared(self.origin, self._id_9011) < 2500) {
    return 1;
  }

  return 0;
}

_id_4976() {
  if(isDefined(self._id_900C) && isDefined(self._id_900B) && distance2dsquared(self._id_012F.origin, self._id_900C) < 4 && distancesquared(self.origin, self._id_900B) < 2500) {
    return 1;
  }

  return 0;
}

_id_89BE(var_0, var_1) {
  var_2 = 0;
  var_3 = var_1[2] - var_0[2];
  var_2 = var_3 <= self._id_1DFC && var_3 >= self._id_1DFD;

  if(!var_2 && isPlayer(self._id_012F) && istrue(self._id_012F._id_88C0)) {
    if(length(self getvelocity()) < 5) {
      var_2 = var_3 <= self._id_1DFC * 2 && var_3 >= self._id_1DFD;
    }
  }

  return var_2;
}

_id_8B17(var_0) {
  return _id_89BE(self.origin, var_0);
}

_id_89BF(var_0, var_1) {
  return distance2dsquared(var_0, var_1) < _id_6B55() * 0.75 * 0.75;
}

_id_8B18(var_0) {
  return _id_89BF(self.origin, var_0);
}

_id_109D1() {
  if(_id_8830(self._id_012F)) {
    return 0;
  }

  return !_id_8B17(self._id_012F.origin) && _id_8B18(self._id_012F.origin);
}

_id_8925() {
  var_0 = self.origin + (0, 0, self._id_9D79);
  var_1 = self._id_012F.origin + (0, 0, self._id_9D79);

  if(!isPlayer(self._id_012F) && !isai(self._id_012F)) {
    return 0;
  }

  var_2 = scripts\engine\trace::_id_3EF6(1);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1, self._id_012F, var_2)) {
    return 0;
  }

  return 1;
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0._id_59E0)) {
    return 1;
  }

  return 0;
}

_id_C0AF(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(self._id_012F)) {
    return 0;
  }

  if(!isreallyalive(self._id_012F)) {
    return 0;
  }

  if(self._id_13E7 == "traverse") {
    return 0;
  }

  if(!_id_8830(self._id_012F)) {
    if(!_id_8B17(self._id_012F.origin)) {
      return 0;
    }

    if(var_0 == "offmesh" && !_id_10E80()) {
      return 0;
    }

    if(var_0 == "normal" && !_id_10E7E()) {
      return 0;
    } else if(var_0 == "base" && !_id_10E7F()) {
      return 0;
    }
  }

  self._id_9010 = undefined;

  if(var_1 && _id_8925()) {
    self._id_9010 = 1;
    return 0;
  }

  return 1;
}

_id_6B52(var_0) {
  if(!isDefined(self._id_9D6B)) {
    self._id_9D6B = spawnStruct();
  }

  if(_id_8831(var_0) && !_id_754A()) {
    _id_2EEE();
  }

  var_1 = _id_6BDD(var_0);
  self._id_9D6B._id_5428 = var_1;
  var_2 = _id_6B57(var_0, var_1);

  if(isDefined(var_2)) {
    self._id_9D6B._id_FF2C = 1;
    self._id_9D6B.origin = var_2;
  } else {
    self._id_9D6B._id_FF2C = 0;
    self._id_9D6B.origin = var_1;

    if(isDefined(self._id_4BB4)) {
      if(!isDefined(_id_5059(self._id_9D6B.origin, 15, 55))) {
        if(!isDefined(self._id_BFED)) {
          self._id_BFED = [];

          for(var_3 = 0; var_3 < _id_6BB3(); var_3++) {
            self._id_BFED[self._id_BFED.size] = var_3;
          }

          self._id_BFED = scripts\engine\utility::array_randomize(self._id_BFED);
        }

        foreach(var_5 in self._id_BFED) {
          var_6 = var_0 _id_6B56(self._id_9DA0);
          var_7 = var_6[var_5];

          if(isDefined(var_7.origin)) {
            self._id_9D6B.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self._id_9D6B;
}

_id_DB71(var_0, var_1) {
  if(istrue(_id_B4EF(var_0))) {
    return 1;
  }

  if(isDefined(var_0.team) && isDefined(self.team) && self.team == var_0.team) {
    return 1;
  }

  if(_id_89A1(var_0)) {
    return 1;
  }

  if(isDefined(var_0._id_8D86)) {
    return 1;
  }

  if(istrue(var_0._id_02FA)) {
    return 1;
  }

  if(istrue(var_0.ignoreme)) {
    return 1;
  }

  if(!isalive(var_0)) {
    return 1;
  }

  if(!istrue(var_1) && !istrue(self._id_DB73)) {
    if(isDefined(var_0._id_8539) && !var_0._id_8539) {
      return 1;
    }

    if(isDefined(var_0._id_110CD) && isDefined(self._id_106A1)) {
      if(!scripts\engine\utility::array_contains(var_0._id_110CD, self._id_106A1)) {
        return 1;
      }
    }
  }

  if(isDefined(level._id_DB72)) {
    if([[level._id_DB72]](var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_89A1(var_0) {
  return isDefined(var_0._id_8322) && var_0._id_8322;
}

_id_319A(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return _func_0036(var_4, self._id_0359, self.height - var_2, self, 1, 0, 0, var_5);
}

_id_43B9(var_0) {
  return level._id_1459._id_43D8["hitLoc"][var_0];
}

_id_43BA(var_0) {
  var_1 = _id_0017::_id_68BD(var_0);
  return level._id_1459._id_43D8["hitDirection"][var_1];
}

_id_6C0A(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = var_3[var_0][var_1][var_2];
  } else {
    var_4 = var_3[var_0][var_1];
  }

  return var_4[randomint(var_4.size)];
}

_id_D602(var_0) {
  self._id_91A3._id_02D6 = var_0;
  _id_06BD::_id_23F3(self._id_91A3._id_02D6);

  if(var_0 == "walk") {
    self._id_A5AC = 0.8;
  } else if(var_0 == "run") {
    self._id_A5AC = 1.0;
  } else if(var_0 == "sprint") {
    self._id_A5AC = 1.2;
  } else if(var_0 == "super_sprint") {
    self._id_A5AC = 1.4;
  }
}

_id_D6A3(var_0) {
  var_1["walk"] = [0.65, 1.2];
  var_1["run"] = [0.8, 1.1];
  var_1["sprint"] = [0.9, 1.3];

  if(!isDefined(self._id_C018)) {
    self._id_C018 = randomfloatrange(-0.1, 0.1);
  }

  var_2 = clamp(var_0 + self._id_C018, 0.0, 2.0);

  if(var_0 <= 1.0) {
    var_3 = var_1[self._id_91A3._id_02D6][0];
    var_4 = 1;
    var_5 = var_3 + var_0 * (var_4 - var_3);
  } else {
    var_3 = 1;
    var_4 = var_1[self._id_91A3._id_02D6][1];
    var_5 = var_3 + (var_0 - 1) * (var_4 - var_3);
  }

  self._id_A254 = var_5;
  self._id_F4EE = var_5;
}