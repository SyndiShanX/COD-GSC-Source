/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3180.gsc
**************************************/

_id_FFE6() {
  if(scripts\engine\utility::is_true(self.disablearrivals)) {
    return 0;
  }

  return 1;
}

_id_7F95(var_0) {
  return 256.0;
}

_id_3E97(var_0, var_1, var_2) {
  return self.asm._id_11068;
}

_id_7DD7(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

_id_7EAB(var_0, var_1, var_2) {
  var_3 = ["F", "B", "L", "R", "U", "D"];
  var_4 = [];

  foreach(var_6 in var_3) {
    var_4[var_6] = spawnStruct();
    var_4[var_6]._id_02C9 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_6);
    var_4[var_6].weight = 0;
    var_4[var_6].string = var_6;
  }

  var_8 = vectorNormalize(var_1);
  var_9 = anglestoaxis(var_2);
  var_10 = [];
  var_10["F"] = vectorNormalize(var_9["forward"]);
  var_10["B"] = vectorNormalize(-1 * var_9["forward"]);
  var_10["R"] = vectorNormalize(var_9["right"]);
  var_10["L"] = vectorNormalize(-1 * var_9["right"]);
  var_11 = [];

  foreach(var_17, var_13 in var_10) {
    var_14 = vectordot(var_8, var_13);
    var_15 = acos(clamp(var_14, -1.0, 1.0));
    var_16 = 90 - var_15;
    var_11[var_17] = var_16 / 90;
  }

  var_18["U"] = vectorNormalize(var_9["up"]);
  var_18["D"] = vectorNormalize(-1 * var_9["up"]);

  foreach(var_17, var_13 in var_18) {
    var_15 = acos(vectordot(var_8, var_13));
    var_16 = 90 - var_15;
    var_11[var_17] = var_16 / 90;
  }

  var_20 = [];
  var_21 = 0;

  foreach(var_17, var_23 in var_11) {
    if(var_23 > 0.01) {
      var_20[var_17] = var_23;

      if(var_23 > var_21) {
        var_21 = var_23;
      }
    }
  }

  var_24 = [];

  foreach(var_17, var_23 in var_20) {
    var_24[var_17] = var_23 * (1 / var_21);
  }

  foreach(var_17, var_23 in var_24) {
    var_4[var_17].weight = var_23;
  }

  return var_4;
}

getyaw2d(var_0) {
  var_1 = (180 + var_0) / 45;
  var_2 = floor(var_1 + 0.5);
  return int(var_2);
}

_id_8061(var_0) {
  var_1 = 10;

  if(var_0 < 0) {
    return int(ceil((180 + var_0 - var_1) / 45));
  } else {
    return int(floor((180 + var_0 + var_1) / 45));
  }
}

_id_3720(var_0, var_1, var_2, var_3) {
  var_4 = _id_0F3D::_id_7DD6();

  if(isDefined(var_4)) {
    var_5 = var_4.origin;
  } else {
    var_5 = self.pathgoalpos;
  }

  var_6 = var_5 - self.origin;
  var_7 = length(var_6);
  var_8 = vectorNormalize(var_6);
  var_9 = _id_8176(var_8);
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = 1.0;
  var_15 = isDefined(var_3) && isarray(var_3) && var_3[1] == "onlyForward";

  if(var_2 == "Exposed 3D" && var_15) {
    var_16 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "F");

    if(!isDefined(var_16)) {
      return undefined;
    }

    var_11 = getmovedelta(var_16);
    var_12 = getangledelta3d(var_16);
    var_13 = getanimlength(var_16);
    var_10["F"] = spawnStruct();
    var_10["F"]._id_02C9 = var_16;
    var_10["F"].weight = 1.0;
    var_10["F"].string = "F";
  } else if(var_2 == "Exposed 3D") {
    var_10 = _id_7EAB(var_1, var_8, var_9._id_0130);
    var_17 = 0;

    foreach(var_19 in var_10) {
      var_17 = var_17 + var_19.weight;
    }

    var_11 = (0, 0, 0);
    var_12 = (0, 0, 0);
    var_21 = 0;
    var_22 = 0;

    foreach(var_19 in var_10) {
      if(var_19.weight <= 0) {
        continue;
      }
      var_24 = getmovedelta(var_19._id_02C9);
      var_11 = var_11 + var_24 * (var_19.weight / var_17);
      var_25 = getangledelta3d(var_19._id_02C9);
      var_12 = var_12 + var_25 * (var_19.weight / var_17);
      var_21 = var_21 + getanimlength(var_19._id_02C9);
      var_22++;
    }

    var_13 = var_21 / var_22;
    var_14 = 0.5;
  } else if(isDefined(var_4)) {
    var_27 = vectordot(var_8, anglesToForward(var_4.angles));
    var_28 = vectordot(var_8, anglestoright(var_4.angles));
    var_29 = vectordot(var_8, anglestoup(var_4.angles));
    var_30 = vectortoangles((-1 * var_27, var_28, -1 * var_29));

    if(var_29 > 0.966) {
      var_31 = undefined;
      var_32 = 5;
      var_33 = 8;
    } else if(var_29 < -0.9666) {
      var_31 = undefined;
      var_32 = 5;
      var_33 = 0;
    } else {
      var_30 = (angleclamp180(var_30[0]), angleclamp180(var_30[1]), angleclamp180(var_30[2]));
      var_31 = getyaw2d(var_30[1]);
      var_32 = _id_7DD7(var_31);
      var_33 = _id_8061(var_30[0]);
    }

    if(var_33 == 4) {
      var_34 = "M";
    } else if(var_33 > 4) {
      var_34 = "B";
    } else {
      var_34 = "T";
    }

    if(var_2 == "Cover Stand 3D" || var_2 == "Cover Exposed 3D") {
      if(var_34 == "B") {
        return undefined;
      }

      if(var_32 >= 7 && var_34 == "M") {
        if(var_7 <= 125) {
          var_34 = "T";
        } else {
          return undefined;
        }
      }

      var_35 = 1.0;
    } else if(var_2 == "Cover 3D") {
      if(var_32 >= 7) {
        return undefined;
      }
    }

    var_36 = var_32 + var_34;
    var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_36);

    if(!isDefined(var_10)) {
      return undefined;
    }

    var_11 = getmovedelta(var_10);
    var_12 = getangledelta3d(var_10);
    var_13 = getanimlength(var_10);
  }

  if(!isDefined(var_10)) {
    return undefined;
  }

  var_37 = length(var_11);
  var_38 = var_7 - var_37;

  if(var_38 >= 0) {
    var_39 = 0.5;
  } else {
    var_39 = 2.0;
  }

  var_40 = var_37 / var_13;
  var_41 = var_40 * self._id_BD22 * var_39 * var_14;

  if(abs(var_38) > var_41) {
    return undefined;
  }

  var_42 = calculatestartorientation(var_11, var_12, var_9.pos, var_9._id_0130);
  var_43 = spawnStruct();
  var_43._id_02C9 = var_10;
  var_43.startpos = var_42[0];
  var_43._id_6378 = var_5;
  var_43._id_1E7F = var_12;
  var_43.angles = var_9.angles;
  var_43._id_0130 = var_9._id_0130;
  var_43._id_01F3 = var_11;
  var_44 = self _meth_84AC();
  var_45 = getclosestpointonnavmesh3d(var_9.pos, self);
  var_46 = navtrace3d(var_44, var_45, 1);
  var_47 = var_46["fraction"] >= 0.9 || navisstraightlinereachable3d(var_44, var_45, self);

  if(!var_47) {
    var_48 = self pathdisttogoal();
    var_47 = var_48 < distance(var_44, var_45) + 8.0;
  }

  if(var_47) {
    return var_43;
  }

  return undefined;
}

_id_22F4(var_0) {
  self endon("death");
  self.asm._id_22F8 = var_0;
  self waittill(var_0 + "_finished");
  self.asm._id_22F8 = undefined;
}

_id_CEA9(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = "Exposed 3D";

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  self._id_4C7E = _id_0F3D::_id_22EA;
  self.a._id_22E5 = var_1;
  self orientmode("face motion");
  thread _id_22F4(var_1);
  var_6 = _id_0A1E::asm_getallanimsforstate(var_0, var_1);

  if(!isDefined(var_6)) {
    scripts\asm\asm::asm_fireevent(var_1, "abort", undefined);
    return;
  }

  self _meth_8396(var_6.startpos, undefined, 15, var_6._id_0130, var_6._id_1E7F);

  if(isDefined(self.asm._id_4C86._id_4C38)) {
    var_7 = self.asm._id_4C86._id_4C38;
    self animmode(var_7);
  } else
    self animmode("nogravity", 0);

  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);

  if(var_4 == "Exposed 3D") {
    var_6._id_02C9 = scripts\anim\utility_common::sortandcullanimstructarray(var_6._id_02C9);

    for(var_8 = 0; var_8 < var_6._id_02C9.size; var_8++) {
      var_9 = var_6._id_02C9[var_8];
      var_10 = var_1 + "_" + var_9.string;
      self _meth_82EA(var_10, var_9._id_02C9, var_9.weight, var_2, self._id_BD22);

      if(var_8 == var_6._id_02C9.size - 1) {
        _id_0A1E::_id_231F(var_0, var_1, undefined, undefined, var_10);
      }
    }
  } else {
    _id_0A1E::_id_2369(var_0, var_1, var_6._id_02C9);
    self _meth_82E7(var_1, var_6._id_02C9, 1, var_2, self._id_BD22);
    _id_0A1E::_id_231F(var_0, var_1);
  }

  self.a.movement = "stop";
}

_id_7E54() {
  if(isDefined(self.asm._id_4C86._id_22E3)) {
    return self.asm._id_4C86._id_22E3;
  }

  return undefined;
}

_id_10010(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::is_true(self._id_B3E9)) {
    if(scripts\engine\utility::isnodeexposed3d(var_0)) {
      return 1;
    }
  }

  return _id_0F3D::_id_C057(var_0);
}

_id_8176(var_0) {
  var_1 = spawnStruct();
  var_2 = _id_0F3D::_id_7DD6();

  if(_id_10010(var_2)) {
    var_1.pos = var_2.origin;
    var_1.angles = var_2.angles;
    var_1._id_0130 = scripts\asm\shared\utility::getnodeforwardangles(var_2, 0);
  } else {
    if(isDefined(var_2)) {
      var_1.pos = var_2.origin;
    } else {
      var_1.pos = self.pathgoalpos;
    }

    if(!self.facemotion && isDefined(self.enemy)) {
      var_3 = self.enemy.origin - var_1.pos;
      var_1.angles = generateaxisanglesfromforwardvector(var_3, self.angles);
    } else
      var_1.angles = self.angles;

    var_1._id_0130 = var_1.angles;
  }

  var_4 = _id_7E54();

  if(isDefined(var_4)) {
    var_1.angles = var_4;
  }

  return var_1;
}

_id_FFD4(var_0, var_1, var_2, var_3) {
  if(!_id_FFE6()) {
    return 0;
  }

  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }

  if(!scripts\asm\asm::_id_232B(var_1, "cover_approach")) {
    return 0;
  }

  var_4 = _id_0F3D::_id_7DD6();

  if(isDefined(var_4) && isDefined(var_4.angles)) {
    var_5 = scripts\asm\shared\utility::_id_812E(var_4);
    self _meth_853D(var_5);
  }

  return 1;
}

_id_1008E(var_0, var_1, var_2, var_3) {
  var_4 = "Exposed 3D";

  if(isDefined(var_3)) {
    if(!isarray(var_3)) {
      var_4 = var_3;
    } else if(var_3.size >= 1) {
      var_4 = var_3[0];
    }
  }

  if(!_id_0F3D::_id_9D4C(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  var_5 = self pathdisttogoal();
  var_6 = _id_7F95(var_4);

  if(var_5 > var_6 || var_5 <= 0) {
    return 0;
  }

  if(isDefined(var_3) && isarray(var_3)) {
    if(var_3.size >= 3) {
      var_7 = var_3[2];

      if(var_3[1] == "greater_than") {
        if(var_5 <= var_7) {
          return 0;
        }
      } else if(var_3[1] == "less_than") {
        if(var_5 > var_7) {
          return 0;
        }
      }
    }

    if(var_3.size >= 5) {
      if(var_3[3] == "moveType") {
        var_8 = var_3[4];

        if(!(isDefined(self._id_13EE7) && self._id_13EE7 == var_8)) {
          return 0;
        }
      }
    }
  }

  self.asm._id_11068 = _id_3720(var_0, var_2, var_4, var_3);

  if(!isDefined(self.asm._id_11068)) {
    return 0;
  }

  return 1;
}