/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2705.gsc
*************************************************/

_id_65A8() {
  var_0 = [self];

  if(isDefined(level._id_50B5)) {
    foreach(var_2 in level._id_50B5) {
      var_0[var_0.size] = var_2._id_5526[0];
    }
  }

  var_4 = self _meth_8150(1);

  if(!isDefined(var_4)) {
    var_4 = [];
  }

  var_4[var_4.size] = self _meth_8151();

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && var_6.classname == "grenade") {
      var_0[var_0.size] = var_6;
    }
  }

  return var_0;
}

_id_6790(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
  }

  if(!isDefined(var_5._id_3BEB)) {
    var_5._id_3BEB = _id_64CC();
  }

  if(!isDefined(var_5._id_4BC3)) {
    var_5._id_4BC3 = 5;
  }

  if(!isDefined(var_5._id_1750)) {
    var_5._id_1750 = 1;
  }

  if(!isDefined(var_5._id_7D2B)) {
    var_5._id_7D2B = [var_0, var_0.owner];
  }

  if(!isDefined(var_5._id_7CFF)) {
    var_5._id_7D1B = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 10;
  }

  if(!isDefined(var_5._id_9CB1)) {
    var_5._id_9CB1 = var_4 - var_4 * var_0._id_F1DF;
  }

  var_6 = var_5._id_9CB1 / var_5._id_4BC3;
  var_7[0] = 0;
  var_8[0] = var_0.origin;
  var_9 = var_5._id_4BC3;
  var_10 = anglesToForward(var_1);
  var_11 = (0, 0, 1);
  var_12 = var_10 * var_2 + var_11 * var_3;
  var_13 = var_11 * vectordot(var_11, var_12);
  var_14 = var_12 - var_13;

  for(var_15 = 1; var_15 < var_5._id_4BC3; var_15++) {
    var_16 = var_7[var_15 - 1];
    var_17 = var_8[var_15 - 1];
    var_18 = var_15 * var_6;
    var_19 = var_14 * var_18;
    var_20 = var_13 * var_18 + (0, 0, -400) * var_18 * var_18;
    var_21 = var_8[0] + var_19 + var_20;
    var_7[var_15] = var_18;
    var_8[var_15] = var_21;
    var_22 = _func_02C1(var_17, var_21, var_5._id_3BEB, var_5._id_7D2B, 1, "physicsquery_closest", var_5._id_7D1B);

    if(isDefined(var_22) && var_22.size > 0) {
      var_5._id_4823 = var_22[0]["position"];
      var_5._id_4827 = var_22[0]["normal"];
      var_5._id_4825 = var_22[0]["entity"];
      var_5._id_4826 = 1;
      var_23 = var_21 - var_17;
      var_24 = length(var_23);
      var_25 = var_23 / var_24;
      var_26 = var_17 - var_5._id_4823;
      var_27 = vectordot(var_25, var_26);
      var_28 = clamp(var_27 / var_24, 0, 1);
      var_5._id_4829 = var_16 + var_6 * var_28;
      break;
    } else if(var_15 == var_5._id_4BC3 - 1) {
      var_5._id_4823 = var_21;
      break;
    }

    if(var_5._id_1750) {
      waitframe();
    }
  }

  return var_5;
}

_id_64CC(var_0) {
  var_1 = undefined;

  if(istrue(var_0)) {
    var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_characterproxy"]);
  } else {
    var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);
  }

  return var_1;
}

_id_B198(var_0, var_1) {
  self endon("death_or_disconnect");
  var_0 endon("death");
  var_0._id_C2FF = var_0.origin;
  var_0._id_C304 = self.origin;
  var_0._id_C303 = self getEye();
  var_0._id_C302 = self _meth_8599();

  if(!isDefined(var_1._id_B1D3)) {
    var_1._id_B1D3 = 0.5;
  }

  if(!isDefined(var_1._id_B1D2)) {
    var_1._id_B1D2 = 0;
  }

  if(!isDefined(var_1._id_B1D4)) {
    var_1._id_B1D4 = 12;
  }

  if(!isDefined(var_1._id_B1D1)) {
    var_1._id_B1D1 = 20;
  }

  if(!isDefined(var_1._id_B1D5)) {
    var_1._id_B1D5 = 45;
  }

  if(!isDefined(var_1._id_B1D6)) {
    var_1._id_B1D6 = 0.342;
  }

  if(!isDefined(var_1._id_B1D8)) {
    var_1._id_B1D8 = 1;
  }

  _id_B1C2(var_0, var_1);
  var_2 = 0;
  var_3 = var_1._id_A6AA;
  var_4 = var_1._id_A6A7;
  var_5 = var_1._id_A6A1;
  var_6 = var_1._id_A6A3;
  var_7 = undefined;

  if(!istrue(var_6)) {
    var_3 = var_1._id_2EC1;
    var_4 = var_1._id_2EC0;
    var_5 = var_1._id_2EB7;
    var_6 = var_1._id_2EBC;

    if(istrue(var_6) && isDefined(var_5) && var_5 _meth_8163()) {
      var_6 = undefined;
    }

    var_8 = _id_64CC(0);
    var_9 = [var_0];
    var_10 = self getEye() - (0, 0, 30);
    var_11 = var_10 + anglesToForward(self getplayerangles(1)) * 20;
    var_12 = _func_02C1(var_10, var_11, var_8, var_9, 0, "physicsquery_closest", 1);

    if(isDefined(var_12) && var_12.size > 0) {
      var_6 = 0;
    }
  } else
    var_7 = _id_B19E(var_0.angles, var_1);

  if(istrue(var_6)) {
    if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1._id_B1D6) {
      var_2 = 1;
    } else {
      var_13 = vectordot(var_0._id_C304 - var_3, (0, 0, 1));

      if(var_13 > 0) {
        if(var_13 > var_1._id_B1D1) {
          var_2 = 1;
        }
      } else {
        var_14 = vectordot(var_0._id_C303 - var_0._id_C304, (0, 0, 1));

        if(var_14 > var_1._id_B1D5) {
          var_15 = vectordot(var_0._id_C303 - var_3, (0, 0, 1));

          if(var_15 >= 0) {
            if(var_15 < var_1._id_B1D4) {
              var_2 = 1;
            }
          } else
            var_2 = 1;
        }
      }
    }
  } else
    var_2 = 1;

  if(var_2) {
    var_8 = var_1._id_330A;

    if(!isDefined(var_8)) {
      var_8 = _id_64CC();
    }

    var_9 = [var_0];
    var_10 = var_0._id_C304 + (0, 0, 1);
    var_11 = var_10 + (0, 0, -1 * var_1._id_B1D1);
    var_12 = _func_02C1(var_10, var_11, var_8, var_9, 1, "physicsquery_closest", 1);

    if(isDefined(var_12) && var_12.size > 0) {
      var_3 = var_12[0]["position"];
      var_4 = var_12[0]["normal"];

      if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1._id_B1D6) {
        return 0;
      }

      var_16 = var_0._id_C302 * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\mp\utility\script::_id_FFE3(anglesToForward(var_16), var_4);
        var_7 = _id_B19E(var_7, var_1);
      } else
        var_7 = var_16;

      var_3 = var_3 + anglestoup(var_7) * var_1._id_B1D8;
      var_5 = var_12[0]["entity"];
      var_0 dontinterpolate();
      var_0.origin = var_3;
      var_0.angles = var_7;
    } else
      return 0;
  } else {
    if(!isDefined(var_7)) {
      var_16 = var_0._id_C302 * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\mp\utility\script::_id_FFE3(anglesToForward(var_16), var_4);
        var_7 = _id_B19E(var_7, var_1);
      } else
        var_7 = var_16;
    }

    var_3 = var_3 + anglestoup(var_7) * var_1._id_B1D8;
    var_0 dontinterpolate();
    var_0.origin = var_3;
    var_0.angles = var_7;
  }

  if(isDefined(var_5)) {
    var_0 linkto(var_5);
  }

  return 1;
}

_id_B1C2(var_0, var_1) {
  childthread _id_B1C4(var_0, var_1);
  childthread _id_B1C3(var_0, var_1);
  childthread _id_B1C5(var_0, var_1);
  var_1 waittill("start_race");
  waittillframeend;
  var_1 notify("end_race");
  return var_1;
}

_id_B1C4(var_0, var_1) {
  var_1 endon("end_race");
  var_0 waittill("missile_stuck", var_2);
  var_1._id_A6AA = var_0.origin;
  var_1._id_A697 = var_0.angles;
  var_1._id_A6A1 = var_2;
  var_1._id_A6A3 = 1;
  var_1 notify("start_race");
}

_id_B1C3(var_0, var_1) {
  var_1 endon("end_race");
  var_1 = _id_6790(var_0, var_0._id_C302, var_1._id_F1D0, var_1._id_F1D1, var_1._id_3314, var_1);
  var_1._id_2EC1 = var_1._id_4823;
  var_1._id_2EC0 = var_1._id_4827;
  var_1._id_2EB7 = var_1._id_4825;
  var_1._id_2EBC = var_1._id_4826;
  var_1 notify("start_race");
}

_id_B1C5(var_0, var_1) {
  var_1 endon("end_race");
  wait(var_1._id_B1D3);
  var_1 notify("start_race");
}

_id_B19E(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0[1];
  var_4 = scripts\engine\utility::ter_op(var_1._id_B1D2 != 0, var_0[2], 0);

  if(var_4 != 0) {
    if(var_4 > 0) {
      var_4 = clamp(var_0[2], 0, var_1._id_B1D2);
    } else {
      var_4 = clamp(var_0[2], -1 * var_1._id_B1D2, 0);
    }
  }

  return (var_2, var_3, var_4);
}