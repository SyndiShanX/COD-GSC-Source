/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2530.gsc
*************************************************/

_id_10147() {
  var_0 = spawnStruct();
  var_0._id_102F6 = [];
  var_0._id_9ED4 = [];
  level.vehicle._id_9EF7 = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_mines", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_mines", "init")]]();
  }
}

_id_10142() {
  return level.vehicle._id_9EF7;
}

_id_10144(var_0, var_1) {
  var_2 = _id_10142();
  var_3 = var_2._id_102F6[var_0];

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_3._id_5FDC = 90;
    var_3._id_2093 = 115;
    var_3._id_919A = 38;
    var_3._id_C862 = 38;
    var_3._id_2954 = 20;
    var_3._id_4B96 = 35;
    var_3._id_98A0 = (0, 0, 37);
    var_3._id_F612 = undefined;
    var_2._id_102F6[var_0] = var_3;
  }

  return var_3;
}

_id_10143(var_0, var_1) {
  var_2 = _id_10142();
  var_3 = var_2._id_9ED4[var_0];

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_3._id_0359 = 10;
    var_3._id_F612 = undefined;
    var_2._id_9ED4[var_0] = var_3;
  }

  return var_3;
}

_id_1014C(var_0, var_1) {
  var_2 = _id_10144(var_0._id_1031E);

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = _id_10143(var_1._id_5562);

  if(!isDefined(var_3)) {
    return 0;
  }

  if(istrue(var_1._id_57CE)) {
    return 0;
  }

  if(_func_0135(var_0 _meth_8431()) < 100) {
    if(_func_0135(var_0 _meth_8432()) < 400) {
      return 0;
    }
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF7()) {
    return 0;
  }

  var_4 = anglesToForward(var_0.angles) * var_2._id_5FDC;
  var_5 = anglesToForward(var_0.angles) * -1 * var_2._id_5FDC;
  var_6 = anglestoright(var_0.angles) * -1 * var_2._id_919A;
  var_7 = anglestoright(var_0.angles) * var_2._id_C862;
  var_8 = var_0.origin + var_4 + var_6;
  var_9 = var_0.origin + var_4 + var_7;
  var_10 = var_0.origin + var_5 + var_6;
  var_11 = var_0.origin + var_5 + var_7;
  var_12 = (var_9 - var_8) * (1, 1, 0);
  var_13 = (var_8 - var_10) * (1, 1, 0);
  var_14 = var_8 - var_1.origin;
  var_15 = vectordot(vectornormalize(_id_10146(var_12)), var_14);

  if(var_15 > var_3._id_0359) {
    return 0;
  }

  var_15 = vectordot(vectornormalize(_id_10146(var_13)), var_14);

  if(var_15 > var_3._id_0359) {
    return 0;
  }

  var_16 = (var_10 - var_11) * (1, 1, 0);
  var_17 = (var_11 - var_9) * (1, 1, 0);
  var_14 = var_11 - var_1.origin;
  var_15 = vectordot(vectornormalize(_id_10146(var_16)), var_14);

  if(var_15 > var_3._id_0359) {
    return 0;
  }

  var_15 = vectordot(vectornormalize(_id_10146(var_17)), var_14);

  if(var_15 > var_3._id_0359) {
    return 0;
  }

  var_14 = var_0.origin + anglestoup(var_0.angles) * var_2._id_2954 - var_1.origin;
  var_15 = vectordot(var_14, anglestoup(var_0.angles));

  if(var_15 > var_2._id_4B96) {
    return 0;
  } else if(var_15 < 0) {
    return 0;
  }

  return 1;
}

_id_10149(var_0, var_1) {
  var_2 = _id_10143(var_1._id_5562);

  if(isDefined(var_2._id_F612)) {
    thread[[var_2._id_F612]](var_0, var_1);
  }

  var_3 = _id_10144(var_0._id_1031E);

  if(isDefined(var_3._id_F612)) {
    thread[[var_3._id_F612]](var_0, var_1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_mines", "trigger")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_mines", "trigger")]](var_0, var_1);
  }
}

_id_10148(var_0) {
  if(level.teambased) {
    var_1 = var_0.team;

    if(!isDefined(var_1)) {
      if(isDefined(var_0.owner)) {
        var_1 = var_0.owner.team;
      }
    }

    if(isDefined(var_1)) {
      return scripts\cp_mp\vehicles\vehicle::_id_10125(self, var_1);
    }
  } else if(isDefined(var_0.owner))
    return scripts\cp_mp\vehicles\vehicle::_id_10124(self, var_0.owner);

  return 0;
}

_id_10146(var_0) {
  return (var_0[1], var_0[0] * -1, 0);
}

_id_10145() {
  return physics_createcontents(["physicscontents_water", "physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight"]);
}