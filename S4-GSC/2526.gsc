/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2526.gsc
*************************************************/

_id_10018(var_0) {
  var_1 = _id_10010();
  var_1._id_8300[var_0 getentitynumber()] = var_0;
  _id_1001C(var_0);
}

_id_1000E(var_0) {
  var_1 = _id_10010();
  var_1._id_8300[var_0 getentitynumber()] = undefined;
}

_id_10013(var_0) {
  var_1 = _id_10010();
  return isDefined(var_1._id_8300[var_0 getentitynumber()]) && var_1._id_8300[var_0 getentitynumber()] == var_0;
}

_id_1001F(var_0, var_1, var_2) {
  var_3 = _id_10010();

  if(!var_3._id_10414) {
    return;
  }
  if(!_id_10013(var_0)) {
    if(!istrue(var_2)) {}
  } else {
    if(!_id_1001B(var_0, var_1)) {
      var_0 _meth_872F(var_1, 0);
      return;
    }

    var_0 _meth_872F(var_1, 1);
  }
}

_id_1001E(var_0, var_1) {
  var_2 = _id_10010();

  if(!var_2._id_10414) {
    return;
  }
  if(!_id_10013(var_0)) {
    if(!istrue(var_1)) {}

    return;
  }

  foreach(var_4 in level.players) {
    _id_1001F(var_0, var_4);
  }
}

_id_1001D(var_0) {
  var_1 = _id_10010();

  if(!var_1._id_10414) {
    return;
  }
  foreach(var_3 in var_1._id_8300) {
    _id_1001F(var_3, var_0);
  }
}

_id_1001B(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "shouldBeVisibleToPlayer")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "shouldBeVisibleToPlayer")]](var_0, var_1);

    if(isDefined(var_2)) {
      return var_2;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle::_id_10124(var_0, var_1)) {
    return 0;
  }

  return 1;
}

_id_1001C(var_0) {
  var_1 = _id_10010();

  if(var_1._id_10414) {
    var_0 _meth_86A2(1);
  }

  if(isDefined(var_1._id_8300[var_0 getentitynumber()])) {
    if(level.teambased) {
      _id_1001A(var_0, scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AD(var_0));
    } else {
      _id_10019(var_0, scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A8(var_0));
    }

    _id_1001E(var_0, 1);
  }
}

_id_10011(var_0) {
  var_1 = _id_10010();
  var_1._id_8300[var_0 getentitynumber()] = undefined;

  if(var_1._id_10414) {
    var_0 _meth_86A2(0);
  }
}

_id_1001A(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "neutral") {
    var_1 = "none";
  }

  var_0 _meth_83A6(var_1);
}

_id_10019(var_0, var_1) {
  var_0 setentityowner(undefined);
}

_id_10012() {
  var_0 = spawnStruct();
  level.vehicle._id_3B06 = var_0;
  var_0._id_8300 = [];
  var_1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "runLeanThreadMode")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "runLeanThreadMode")]]();
  }

  var_0._id_10414 = !var_1 || getdvarint("#x3c958ba6eb57a4cc0", 0) > 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_compass", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_compass", "init")]]();
  }
}

_id_10010() {
  return level.vehicle._id_3B06;
}

_id_1000F(var_0, var_1, var_2) {
  var_3 = _id_10010();
  var_4 = isDefined(var_3._id_8300[var_0 getentitynumber()]) && var_3._id_8300[var_0 getentitynumber()] == var_0;

  if(!var_4) {
    return;
  }
  if(level.teambased) {
    _id_1001A(var_0, var_2);
  } else {
    _id_10019(var_0, var_2);
  }

  _id_1001E(var_0);
}

_id_10016(var_0) {
  if(!level.teambased) {
    return;
  }
  _id_1001D(var_0);
}

_id_10017() {
  _id_1001D(self);
}