/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1729.gsc
*************************************************/

_id_F3D4(var_0) {
  self endon("asm_terminated");
  _id_D576();
  self._id_006C = var_0;
  var_1 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_2"));
  var_2 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_4"));
  var_3 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_6"));
  var_4 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_8"));
  _id_F415(var_1, var_2, var_3, var_4);
  _id_F41B(var_0);
}

_id_F415(var_0, var_1, var_2, var_3) {
  self._id_0DDF._id_1357 = 1.0;
  self._id_0DDF._id_1359 = 1.0;
  self._id_0DDF._id_1358 = 1.0;
  self._id_0DDF._id_135B = 0;
  self._id_0DDF._id_135A = 0;
  var_4 = spawnStruct();
  var_4._id_132C = var_0;
  var_4._id_132E = var_1;
  var_4._id_1331 = var_2;
  var_4._id_1333 = var_3;
  self._id_1C30._id_F3D4 = var_4;
}

_id_DFAC() {
  self endon("stop_sniper");
  self waittill("death");

  if(isDefined(self._id_DF7E)) {
    self._id_DF7E delete();
    self._id_DF7E = undefined;
  }
}

_id_DFB5() {
  if(isDefined(self._id_DF7E)) {
    self notify("stop_sniper");
    self._id_DF7E[[self._id_5D9F]]();
    self._id_DF7E delete();
    self._id_DF7E = undefined;
    self._id_24F6 = undefined;
    self[[self._id_5DBD]]("none");
  }
}

_id_DC04() {
  var_0 = getweaponbasename(self._id_04F6);

  switch (var_0) {
    case "iw7_m8":
      return 1;
    default:
      break;
  }

  return 0;
}

_id_6AF5() {
  if(!isDefined(self._id_24F6)) {
    if(_id_DC04()) {
      var_0 = self gettagorigin("tag_laser", 1);

      if(isDefined(var_0)) {
        self._id_24F6 = 1;
        return var_0;
      }
    }

    self._id_24F6 = 0;
  } else if(istrue(self._id_24F6)) {
    if(!_id_DC04()) {
      self._id_24F6 = 0;
    }
  }

  if(self._id_24F6) {
    return self gettagorigin("tag_laser");
  }

  return self _meth_815C();
}

_id_6AF4() {
  return self _meth_8561();
}

_id_6AF3() {
  return self _meth_815B();
}

_id_DFB4() {
  if(isDefined(self._id_DF7E)) {
    return;
  }
  thread _id_DFAC();
  var_0 = _id_6AF5();
  self._id_DF7E = spawn("script_model", var_0);
  self._id_DF7E setModel("tag_laser");
  self._id_DF7E _meth_8592(self._id_04F6);
  self._id_DF7E setotherent(self);
  self._id_DF7E.origin = var_0;
  self[[self._id_5DBD]]("interpolate");
  self._id_DF7E[[self._id_5DA0]]();

  while(isalive(self) && isDefined(self._id_DF7E)) {
    if(isDefined(self._id_3C72._id_133C)) {
      var_0 = _id_6AF5();
      self._id_DF7E.origin = var_0;
      var_1 = self._id_3C72._id_133C;
      var_2 = vectornormalize(var_1 - var_0);
      var_3 = _id_6AF4();
      var_2 = vectornormalize((var_2[0], var_2[1], 0));
      var_3 = vectornormalize((var_3[0], var_3[1], 0));
      var_4 = vectordot(var_2, var_3);

      if(var_4 < 0.996) {
        self._id_DF7E.angles = _id_6AF3();
      } else {
        self._id_DF7E.angles = vectortoangles(self._id_3C72._id_133C - self._id_DF7E.origin);
      }
    }

    waitframe();
  }
}

_id_F43A() {
  _id_DFB5();
}

_id_F43B() {
  if(!isDefined(self._id_DF7E)) {
    thread _id_DFB4();
  }
}

_id_392E() {
  self._id_3C72 = undefined;
  self._id_0119 = 0;
}

_id_C60D(var_0, var_1, var_2) {
  if(!isDefined(self._id_3C72)) {
    self._id_3C72 = spawnStruct();
    self._id_0119 = 1;
  }

  self._id_3C72._id_DF6A = undefined;
  self._id_3C72.target = self._id_0B67._id_03C3;
  self._id_3C72._id_3C6E = 96;

  if(var_0) {
    self._id_3C72._id_3C71 = 1500;
  } else if(istrue(var_2)) {
    self._id_3C72._id_3C71 = 1500;
  } else {
    self._id_3C72._id_3C71 = 2000;
  }

  self[[self._id_5DBD]]("interpolate");
  var_3 = _id_06D7::_id_675A(level._id_60E6);
  var_4 = level._id_498A["sniper_converge_scale"][var_3];

  if(isDefined(var_4)) {
    self._id_3C72._id_3C71 = self._id_3C72._id_3C71 * var_4;
  }

  if(isDefined(level._id_DF56)) {
    self._id_3C72._id_3C71 = self._id_3C72._id_3C71 * level._id_DF56;
  }

  self._id_3C72._id_3C6D = 12;
  self._id_0115 = 750;
  self._id_0116 = -1;

  if(!isDefined(self._id_DF7E)) {
    self._id_0114 = -1500;
  } else {
    self._id_0114 = 0;
  }

  self._id_0117 = int(self._id_3C72._id_3C71 + 1000);
  self._id_3C72._id_3C6C = self._id_0117 + 500;

  if(isDefined(self._id_0B67._id_03C8)) {
    var_5 = undefined;
    var_6 = undefined;

    if(isDefined(var_1)) {
      var_5 = var_1;
    } else {
      if(isDefined(self._id_0B67._id_03C3)) {
        var_7 = self._id_0B67._id_03C3.origin;

        if(isPlayer(self._id_0B67._id_03C3)) {
          var_6 = self._id_0B67._id_03C3 getvelocity();

          if(var_6 == (0, 0, 0)) {
            var_6 = undefined;
          }
        }
      } else
        var_7 = self._id_0B67._id_03C8 - (0, 0, 70);

      var_8 = var_7 - self.origin;
      var_8 = (var_8[0], var_8[1], 0);
      var_9 = vectornormalize(var_8);

      if(istrue(var_2)) {
        var_5 = var_7;
        var_5 = var_5 + (0, 0, randomfloatrange(12, 36));
      } else
        var_5 = var_7 - var_9 * randomfloatrange(120, 180);

      var_10 = _func_025B(var_9, (0, 0, 1));
      var_11 = randomfloatrange(6, 36);

      if(istrue(var_2)) {
        var_11 = randomfloatrange(12, 24);
      }

      if(isDefined(var_6)) {
        var_12 = vectordot(var_6, var_10);

        if(var_12 < 0) {
          var_5 = var_5 + var_10 * var_11;
        } else {
          var_5 = var_5 - var_10 * var_11;
        }
      } else if(randomintrange(0, 2))
        var_5 = var_5 + var_10 * var_11;
      else {
        var_5 = var_5 - var_10 * var_11;
      }
    }

    self._id_3C72._id_3C6F = vectornormalize(var_5 - self._id_0B67._id_03C8);
    self._id_3C72._id_3C6E = distance(var_5, self._id_0B67._id_03C8);
  }
}

_id_2EB4() {
  if(self._id_0116 >= 0 && gettime() - self._id_0116 >= 100) {
    var_0 = gettime() - self._id_0116;

    if(isDefined(self._id_0B67._id_03C3) && isPlayer(self._id_0B67._id_03C3)) {
      self[[self._id_5DBD]]("lock");
    } else {
      self[[self._id_5DBD]]("interpolate");
    }

    return self._id_0B67._id_03C8 - (0, 0, 1.3);
  }

  var_1 = vectornormalize(self._id_0B67._id_03C8 - self.origin);
  var_2 = vectortoangles(var_1);

  if(self._id_0114 < 0) {
    self[[self._id_5DBD]]("interpolate");
    var_3 = self._id_0B67._id_03C8 + self._id_3C72._id_3C6F * self._id_3C72._id_3C6E;
    return var_3;
  }

  var_4 = (self._id_3C72._id_3C71 - self._id_0114) / self._id_3C72._id_3C71;

  if(self._id_0114 >= self._id_3C72._id_3C71) {
    var_4 = 0.0;
  }

  var_5 = var_4 * (self._id_3C72._id_3C6E - self._id_3C72._id_3C6D) + self._id_3C72._id_3C6D;
  var_3 = self._id_0B67._id_03C8 + self._id_3C72._id_3C6F * var_5;

  if(isDefined(self._id_0B67._id_03C3) && isPlayer(self._id_0B67._id_03C3)) {
    self[[self._id_5DBD]]("interpolate");
  }

  return var_3;
}

_id_AB9E() {
  self notify("sniper_weapon_fired");

  if(isDefined(self._id_3C72) && isDefined(self._id_DF7E)) {
    self._id_3C72._id_DF6A = 1;
  }
}

_id_AB9D() {
  if(isDefined(self._id_DF7E)) {
    self._id_DF7E[[self._id_5D9F]]();
    thread _id_F816(0.5);
  }
}

_id_F816(var_0) {
  self endon("death");
  wait(var_0);

  if(isDefined(self._id_DF7E)) {
    self._id_DF7E[[self._id_5DA0]]();
  }
}

_id_3C73() {
  var_0 = 1;
  var_1 = 0;

  if(isDefined(self._id_0B67._id_03C3)) {
    var_0 = self _meth_8067(self._id_0B67._id_03C3);

    if(isDefined(self._id_3C72) && isDefined(self._id_3C72.target) && self._id_3C72.target != self._id_0B67._id_03C3) {
      var_1 = 1;
    }

    if(var_0) {
      _id_06BD::_id_2418(self._id_0B67._id_03C3 _meth_8176());
    }
  }

  if(!isDefined(self._id_3C72) || var_1) {
    _id_C60D(var_1);
  } else if(var_0 && !istrue(self._id_3C72._id_24F7)) {
    if(isDefined(self._id_3C72._id_133C) && distancesquared(self._id_3C72._id_133C, self._id_0B67._id_03C8) < 3600) {
      _id_C60D(var_1, undefined, 1);
    } else {
      _id_C60D(var_1);
    }
  } else if(istrue(self._id_3C72._id_DF6A)) {
    self[[self._id_5DBD]]("interpolate");
    self._id_3C72._id_DF6A = undefined;

    if(isDefined(self._id_0B67._id_03C3) && isPlayer(self._id_0B67._id_03C3) && self _meth_8067(self._id_0B67._id_03C3)) {
      _id_C60D(var_1, undefined, 1);
    }
  }

  self._id_3C72._id_24F7 = var_0;
  var_2 = 1;
  var_3 = _id_6AF5();
  var_4 = _id_2EB4();
  var_5 = vectornormalize(var_4 - var_3);
  var_6 = self _meth_8561();

  if(self._id_0114 < 0) {
    if(!_id_873A()) {
      return 0;
    }

    self._id_0114 = self._id_0114 + 50;
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.984) {
      return 0;
    }

    var_5 = vectornormalize((var_5[0], var_5[1], 0));
    var_6 = vectornormalize((var_6[0], var_6[1], 0));
    var_8 = vectordot(var_5, var_6);

    if(var_8 < 0.996) {
      return 0;
    }

    self._id_0114 = 0;
  } else {
    self._id_0114 = self._id_0114 + 50;
    var_7 = vectordot(var_5, var_6);

    if(var_7 < 0.984) {
      var_2 = 0;
    }

    var_5 = vectornormalize((var_5[0], var_5[1], 0));
    var_6 = vectornormalize((var_6[0], var_6[1], 0));
    var_8 = vectordot(var_5, var_6);

    if(var_8 < 0.996) {
      var_2 = 0;
    }
  }

  if(self._id_0114 >= self._id_3C72._id_3C71) {
    if(isDefined(self._id_0B67._id_03C3)) {
      if(self._id_0116 < 0) {
        if(var_0) {
          self._id_0116 = gettime();
        }
      } else if(gettime() >= self._id_0116 + 200) {
        if(!var_0) {
          self._id_0116 = -1;
        }
      }
    }
  }

  return var_2;
}

_id_8A42() {
  if(!isDefined(self._id_3C72)) {
    return 0;
  }

  return 1;
}

_id_8A43() {
  if(isDefined(self._id_DF7E)) {
    return 1;
  }

  return 0;
}

_id_873A() {
  if(!isDefined(self._id_1C30._id_1354)) {
    return 0;
  }

  var_0 = 100.0;
  var_0 = var_0 * 2;
  var_1 = gettime();

  if(self._id_1C30._id_1354 + var_0 < var_1) {
    return 1;
  }

  return 0;
}

_id_3112() {
  var_0 = self _meth_864B();

  if(istrue(self._id_CA5E)) {
    return 0;
  }

  if(self._id_03FF != "none") {
    return 1;
  }

  var_1 = self _meth_87CE();

  if(_func_03A4(var_1, "fast") && _func_03A4(var_1, "jog") && var_0 < _func_03A8(var_1, "fast", "jog", 0.4)) {
    return 1;
  }

  if(var_1 == "juggernaut" || var_1 == "juggernaut_cp" || var_1 == "juggernaut_lw") {
    return var_0 < 60;
  }

  if(istrue(self._id_0380)) {
    return 1;
  }

  return 0;
}

_id_F41B(var_0) {
  self endon("death");
  self._id_1C30._id_BC6D = 0;
  self._id_1C30._id_BC55 = 0;
  var_1 = (0, 0, 0);
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 10;

  for(;;) {
    _id_7DB0();
    var_6 = _id_0009::_id_1C43(self._id_006C, "aim");

    if(isDefined(self._id_0323) && distance2dsquared(self._id_0323, self.origin) > 16 && !_id_3112()) {
      var_6 = 0;
    }

    var_7 = 0;

    if(!var_6 && _id_0009::_id_1C43(self._id_006C, "notetrackAim")) {
      var_6 = _id_0009::_id_1C50(self._id_006C, "start_aim");
    }

    if(!var_6 || !istrue(self._id_0B67._id_03CE)) {
      if(!var_6 && isDefined(self._id_3C72)) {
        _id_392E();
      }

      _id_F43A();
      self._id_1C30._id_1354 = undefined;
    } else if(!isDefined(self._id_1C30._id_1354))
      self._id_1C30._id_1354 = gettime();

    var_1 = (0, 0, 0);
    var_8 = undefined;
    var_9 = undefined;

    if(var_6) {
      var_9 = self _meth_884D();
      var_8 = self _meth_886A(var_9);
      var_10 = undefined;

      if(isDefined(var_8)) {
        var_10 = var_8._id_DA32;
        var_7 = istrue(var_8._id_2DBF);
      }

      if(isDefined(self._id_1353)) {
        self _meth_8007(self._id_1353);
      } else if(var_7 || !isDefined(var_10)) {
        self _meth_8007(6);
      } else if(!isDefined(var_10)) {
        self _meth_8007(3);
      } else {
        self _meth_8007(1);
      }

      var_11 = self _meth_8182();
      var_12 = isDefined(var_11);

      if(var_12) {
        var_13 = var_11 _meth_8548();
        var_14 = anglesToForward(self.angles);
        var_15 = rotatevector(var_14, var_13);
        var_10 = var_9 + var_15 * 512.0;
      } else if(_id_06BD::_id_240F() && isDefined(self._id_0B67._id_03C8)) {
        if(istrue(self._id_0B67._id_03C0)) {
          var_16 = _id_3C73();
          var_10 = _id_2EB4();
          self._id_3C72._id_133C = var_10;

          if(var_16) {
            _id_F43B();
          } else {
            _id_F43A();
          }
        } else
          _id_F43A();
      } else
        _id_F43A();

      var_17 = isDefined(var_10);
      var_18 = (0, 0, 0);

      if(var_17) {
        var_18 = var_10;
      }

      var_21 = 0;
      var_22 = isDefined(self._id_E83A);

      if(var_22) {
        var_21 = self._id_E83A;
      }

      var_23 = 0;
      var_24 = 0;
      var_25 = _id_06BD::_id_23BC();

      if(isDefined(var_25) && _id_06BD::_id_23C5() == "exposed") {
        var_26 = _id_06BD::_id_23C3();

        if(isDefined(var_26)) {
          var_27 = self _meth_87CE();
          var_23 = _id_08F1::_id_6B99(var_27, var_25, var_26);
          var_24 = _id_08F1::_id_6B98(var_27, var_25, var_26);
        }
      } else if(istrue(self._id_134E)) {
        var_27 = self _meth_87CE();
        var_24 = anim._id_A56A[var_27]["Aim Down"];
      } else if(self._id_1C30._id_1A35 == "boss" || self._id_1C30._id_1A35 == "boss2") {
        var_23 = -12;
        var_28 = 10;
      }

      var_29 = (var_24, var_23, 0);
      var_30 = self _meth_8107();

      if(self _meth_8659() || isDefined(var_8) && isDefined(var_8._id_24E2) && var_8._id_24E2) {
        var_1 = self _meth_85E4(var_9, var_18, var_17, var_29, var_21, var_22, 1);
      } else {
        var_1 = self _meth_85E4((0, 0, 0));
      }

      if(_func_000C(var_30, var_1) > 12) {
        self._id_0086 = 0;
      }
    } else if(abs(self._id_1C30._id_BC6D) < 5 && abs(self._id_1C30._id_BC55) < 5) {
      self _meth_85E4((0, 0, 0));
      self _meth_8007(3);
      self._id_0086 = 0;
      waitframe();
      continue;
    }

    if(self _meth_8645(self._id_006C)) {
      if(isDefined(var_8) && isDefined(var_8._id_DA32)) {
        if(istrue(self._id_017D)) {
          var_34 = self _meth_8561();
          var_35 = vectornormalize(var_8._id_DA32 - var_9);
          var_36 = vectordot(var_34, var_35);

          if(var_36 >= 0.966) {
            self._id_026D = 1;
            self _meth_886D();
          }
        }
      }

      waitframe();
      continue;
    }

    if(istrue(self._id_0380)) {
      waitframe();
      continue;
    }

    var_37 = var_1[0];
    var_38 = var_1[1];
    var_1 = undefined;

    if(var_4 > 0) {
      var_4 = var_4 - 1;
      var_5 = max(10, var_5 - 5);
    } else if(self._id_0366 && self._id_0366 != var_3) {
      var_4 = 2;
      var_5 = 30;
    } else if(scripts\anim\utility_common::_id_8766())
      var_5 = 2;
    else if(var_7) {
      var_5 = 5;
    } else {
      var_5 = 10;
    }

    var_39 = 4;
    var_3 = self._id_0366;
    var_40 = self._id_02D6 != "stop" || !var_2;

    if(var_40) {
      var_41 = var_38 - self._id_1C30._id_BC6D;

      if(_func_0219(var_41) > var_39) {
        var_42 = var_41 * 0.4;
        var_38 = self._id_1C30._id_BC6D + clamp(var_42, -1 * var_5, var_5);
        var_38 = clamp(var_38, self._id_0377, self._id_0275);
      }

      var_43 = var_37 - self._id_1C30._id_BC55;

      if(_func_0219(var_43) > var_39) {
        var_44 = var_43 * 0.4;
        var_37 = self._id_1C30._id_BC55 + clamp(var_44, -1 * var_5, var_5);
        var_37 = clamp(var_37, self._id_04BE, self._id_0185);
      }
    }

    var_2 = 0;
    self._id_1C30._id_BC6D = var_38;
    self._id_1C30._id_BC55 = var_37;

    if(isDefined(self._id_1C30._id_4D0B) && self._id_1C30._id_4D0B) {
      _id_F422(var_37, var_38);
    } else {
      _id_F421(var_37, var_38);
    }

    wait 0.05;
  }
}

_id_F420() {
  if(!isDefined(self._id_1C30._id_BC6D)) {
    return;
  }
  var_0 = clamp(self._id_1C30._id_BC6D, self._id_0377, self._id_0275);
  var_1 = clamp(self._id_1C30._id_BC55, self._id_04BE, self._id_0185);

  if(isDefined(self._id_1C30._id_4D0B) && self._id_1C30._id_4D0B) {
    _id_F422(var_1, var_0);
  } else {
    _id_F421(var_1, var_0);
  }
}

getcurrentpoi() {
  if(self._id_006E) {
    if(isDefined(self._id_3E32)) {
      self._id_3E32._id_90B8 = self._id_0337;
    }

    self._id_41E4 = self._id_3E32;
    self._id_006E = 0;
  }

  return self.currsentpoi_code;
}

_id_F421(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self._id_1C30._id_F3D4._id_132B)) {
    var_3 = self._id_1C30._id_F3D4._id_132B;
    var_4 = self._id_1C30._id_F3D4._id_132D;
    var_5 = self._id_1C30._id_F3D4._id_1330;
    var_6 = self._id_1C30._id_F3D4._id_1332;
  } else {
    var_3 = self._id_1C30._id_F3D4._id_132C;
    var_4 = self._id_1C30._id_F3D4._id_132E;
    var_5 = self._id_1C30._id_F3D4._id_1331;
    var_6 = self._id_1C30._id_F3D4._id_1333;
  }

  if(isDefined(self._id_1C30._id_F3D4._id_132F)) {
    var_2 = self._id_1C30._id_F3D4._id_132F;
  }

  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;

  if(var_1 < 0) {
    var_10 = var_1 / self._id_0377 * self._id_0DDF._id_1357;
    var_9 = 1;
  } else if(var_1 > 0) {
    var_8 = var_1 / self._id_0275 * self._id_0DDF._id_1357;
    var_9 = 1;
  }

  if(var_0 < 0) {
    var_11 = var_0 / self._id_04BE * self._id_0DDF._id_1357;
    var_9 = 1;
  } else if(var_0 > 0) {
    var_7 = var_0 / self._id_0185 * self._id_0DDF._id_1357;
    var_9 = 1;
  }

  self _meth_85EE(var_3, var_7, 0.1, 1, 1);
  self _meth_85EE(var_4, var_8, 0.1, 1, 1);
  self _meth_85EE(var_5, var_10, 0.1, 1, 1);
  self _meth_85EE(var_6, var_11, 0.1, 1, 1);

  if(isDefined(var_2)) {
    self _meth_85EE(var_2, var_9, 0.1, 1, 1);
  }
}

_id_F422(var_0, var_1) {
  var_2 = self._id_1C30._id_F3D4._id_959B;
  var_3 = self._id_1C30._id_F3D4._id_959C;
  var_4 = self._id_1C30._id_F3D4._id_959D;
  var_5 = self._id_1C30._id_F3D4._id_959E;
  var_6 = self._id_1C30._id_F3D4._id_959F;
  var_7 = self._id_1C30._id_F3D4._id_95A0;
  var_8 = self._id_1C30._id_F3D4._id_95A1;
  var_9 = self._id_1C30._id_F3D4._id_95A2;
  var_10 = [var_6, var_9, var_8, var_7, var_5, var_2, var_3, var_4, var_6];
  var_11 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];
  var_12 = [(-1, 0, 0), (-0.707, -0.707, 0), (0, -1, 0), (0.707, -0.707, 0), (1, 0, 0), (0.707, 0.707, 0), (0, 1, 0), (-0.707, 0.707, 0), (-1, 0, 0)];
  var_13 = [80, 91.787, 45, 91.787, 80, 91.787, 45, 91.787, 80];
  var_14 = (var_1, var_0, 0);
  var_15 = _func_0133(var_14);
  var_16 = vectornormalize(var_14);
  var_17 = _func_0261(var_16);
  var_17 = _func_000B(var_17);

  for(var_18 = 0; var_17 > var_11[var_18]; var_18++) {}

  if(var_18 == 0) {
    var_18 = 1;
  }

  var_19 = self._id_1C30._id_F3D4._id_95A3;

  for(var_20 = 0; var_20 < var_10.size; var_20++) {
    if(var_20 == var_18 || var_20 == var_18 - 1) {
      var_21 = clamp(var_15 / var_13[var_20], 0.0, 1.0);
      var_22 = _func_0002(vectordot(var_12[var_20], var_16));
      var_23 = clamp(1 - var_22 / var_13[var_20], 0.0, 1.0);
      var_24 = _id_0009::_id_1C6E(var_19, var_10[var_20]);
      var_25 = self _meth_85F7(var_24);

      if(var_25 > 0) {
        var_26 = _func_0079(var_24);
        var_27 = (var_21 - var_25) * var_26 / 0.05;
        self _meth_85EE(var_24, var_23, 0.05, var_27);
      } else {
        self _meth_85EE(var_24, var_23, 0.05, 0.0);
        self _meth_85F3(var_24, var_21);
      }

      continue;
    }

    if(var_10[var_20] != var_10[var_18] && var_10[var_20] != var_10[var_18 - 1]) {
      self _meth_85EF(_id_0009::_id_1C6E(var_19, var_10[var_20]), 0.05);
    }
  }
}

_id_D475(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    self._id_0DDF._id_1357 = var_0;
    self._id_0DDF._id_1359 = var_0;
    self._id_0DDF._id_1358 = var_0;
    self._id_0DDF._id_135B = 0;
  } else {
    if(!isDefined(self._id_0DDF._id_1357)) {
      self._id_0DDF._id_1357 = 0;
    }

    self._id_0DDF._id_1359 = self._id_0DDF._id_1357;
    self._id_0DDF._id_1358 = var_0;
    self._id_0DDF._id_135B = int(var_1 * 20);
  }

  self._id_0DDF._id_135A = 0;
}

_id_7DB0() {
  if(self._id_0DDF._id_135A < self._id_0DDF._id_135B) {
    self._id_0DDF._id_135A++;
    var_0 = 1.0 * self._id_0DDF._id_135A / self._id_0DDF._id_135B;
    self._id_0DDF._id_1357 = self._id_0DDF._id_1359 * (1 - var_0) + self._id_0DDF._id_1358 * var_0;
  }
}

_id_D576() {
  anim._id_3DD7 = 55;
  anim._id_135E = 10;
  anim._id_135C = 4096;
  anim._id_135D = 45;
  anim._id_1351 = 20;
  anim._id_ADFE = 25;
  anim._id_ADFC = anim._id_135C;
  anim._id_ADFD = anim._id_135D;
  anim._id_ADEE = 30;
  anim._id_9C56 = 65;
  anim._id_9C55 = 65;
}