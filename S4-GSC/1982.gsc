/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1982.gsc
*************************************************/

init() {
  if(getdvarint("#x36325d0d09e7e5310") != 0 && !isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/clientmatchdata.ddl";
    _func_01D2(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level._id_39A0 = ::_id_97AA;
}

_id_3193(var_0) {
  if(isagent(var_0)) {
    return 0;
  }

  return var_0._id_399D < level._id_9C85;
}

_id_3194(var_0) {
  return var_0 < 300;
}

_id_97AA(var_0) {
  if(getdvarint("#x36325d0d09e7e5310") == 0) {
    return;
  }
  var_1 = _func_007F("deathCount");

  if(!_id_3193(self) || !_id_3194(var_1)) {
    return;
  }
  if(isPlayer(var_0) && _id_3193(var_0)) {
    self _meth_8218(var_1, self._id_399D, var_0, var_0._id_399D);
  } else {
    self _meth_8218(var_1, self._id_399D, undefined, undefined);
  }
}