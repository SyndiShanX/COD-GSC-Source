/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58242.gsc
***********************************************/

_id_1412B(var_0) {
  var_1 = _id_14122();
  var_1.instances[var_0 getentitynumber()] = var_0;
  _id_1412F(var_0);
}

_id_14120(var_0) {
  var_1 = _id_14122();
  var_1.instances[var_0 getentitynumber()] = undefined;
}

_id_14126(var_0) {
  var_1 = _id_14122();
  return isDefined(var_1.instances[var_0 getentitynumber()]) && var_1.instances[var_0 getentitynumber()] == var_0;
}

_id_14132(var_0, var_1, var_2) {
  var_3 = _id_14122();

  if(!var_3._id_142CE) {
    return;
  }
  if(!_id_14126(var_0)) {
    if(!istrue(var_2)) {}
  } else {
    if(!_id_1412E(var_0, var_1)) {
      var_0 vehicleshowonminimapforclient(var_1, 0);
      return;
    }

    var_0 vehicleshowonminimapforclient(var_1, 1);
  }
}

_id_14131(var_0, var_1) {
  var_2 = _id_14122();

  if(!var_2._id_142CE) {
    return;
  }
  if(!_id_14126(var_0)) {
    if(!istrue(var_1)) {}

    return;
  }

  foreach(var_4 in level.players)
  _id_14132(var_0, var_4);
}

_id_14130(var_0) {
  var_1 = _id_14122();

  if(!var_1._id_142CE) {
    return;
  }
  foreach(var_3 in var_1.instances)
  _id_14132(var_3, var_0);
}

_id_1412E(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_AF2618A0BAE5ABC8DB12E57401BF504D8DF211B8D1FD3B22B74A")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_AF2618A0BAE5ABC8DB12E57401BF504D8DF211B8D1FD3B22B74A")]](var_0, var_1);

    if(isDefined(var_2))
      return var_2;
  }

  if(!scripts\cp_mp\vehicles\vehicle::_id_141B9(var_0, var_1))
    return 0;

  return 1;
}

_id_1412F(var_0) {
  var_1 = _id_14122();

  if(var_1._id_142CE)
    var_0 vehicleshowonminimap(1);

  if(isDefined(var_1.instances[var_0 getentitynumber()])) {
    if(level.teambased)
      _id_1412D(var_0, scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D7(var_0));
    else
      _id_1412C(var_0, scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D5(var_0));

    _id_14131(var_0, 1);
  }
}

_id_14123(var_0) {
  var_1 = _id_14122();
  var_1.instances[var_0 getentitynumber()] = undefined;

  if(var_1._id_142CE)
    var_0 vehicleshowonminimap(0);
}

_id_1412D(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_1 = "_encstr_8BBA05185F8B99";

  var_0 setvehicleteam(var_1);
}

_id_1412C(var_0, var_1) {
  var_0 setentityowner(undefined);
}

_id_14125() {
  var_0 = spawnStruct();
  level.vehicle.hidescavengerhudfromplayer = var_0;
  var_0.instances = [];
  var_1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8E8912DB5025E567C1D0B4B0F6693FB73BE8C222"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8E8912DB5025E567C1D0B4B0F6693FB73BE8C222")]]();

  var_0._id_142CE = !var_1 || getdvarint("_encstr_B4152F08A20A275337C01B06AC5FBD3FB5FB0B801BAB830BDFF21389B12322BB9A51983052FAE145EF16A5FE9FABC8BB87", 0) > 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_88C5055208731B")]]();
}

_id_14122() {
  return level.vehicle.hidescavengerhudfromplayer;
}

_id_14121(var_0, var_1, var_2) {
  var_3 = _id_14122();
  var_4 = isDefined(var_3.instances[var_0 getentitynumber()]) && var_3.instances[var_0 getentitynumber()] == var_0;

  if(!var_4) {
    return;
  }
  if(level.teambased)
    _id_1412D(var_0, var_2);
  else
    _id_1412C(var_0, var_2);

  _id_14131(var_0);
}

_id_14129(var_0) {
  if(!level.teambased) {
    return;
  }
  _id_14130(var_0);
}

_id_1412A() {
  _id_14130(self);
}