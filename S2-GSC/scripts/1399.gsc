/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1399.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("skel_key", ::_id_A237, ::_id_1F6F, ::_id_4685);
}

_id_1F6F(var_0) {
  if(!_id_0561::_id_1F7B()) {
    return 0;
  }

  if(_id_4B95()) {
    return 0;
  }

  return 1;
}

_id_A237(var_0) {
  self playlocalsound("zmb_pickup_general");
  var_1 = self._id_259F[var_0].type;
  self._id_8C71 = spawnStruct();
  self._id_8C71.type = var_1;
  self._id_8C71._id_267C = 1 - _id_4686(var_1);

  if(common_scripts\utility::_id_562E(level.reworkedconsumabledenabled)) {
    self._id_8C71.flatdiscount = 1000;
  }

  _id_0561::notifywallbuytriggers();
}

_id_4685(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  switch (var_0) {
    case "epic":
      return 4;
    case "legendary":
      return 3;
    case "rare":
      return 2;
    case "common":
      return 1;
    default:
      return 0;
  }
}

_id_4686(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  switch (var_0) {
    case "common":
    case "rare":
    case "legendary":
    case "epic":
      return 0.5;
    default:
      return 0;
  }
}

_id_4687() {
  if(_id_4B95()) {
    return self._id_8C71._id_267C;
  }

  return 1;
}

_id_4B95() {
  if(isDefined(self._id_8C71)) {
    return 1;
  }

  return 0;
}

_id_A236() {
  if(!_id_4B95()) {
    return;
  }
  self._id_8C71 = undefined;
  _id_0561::notifywallbuytriggers();
}