/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2461.gsc
*************************************************/

init() {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/zombieclientmatchdata.ddl";
    _func_01D2(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level._id_9C62 = 50;
}

_id_3193(var_0) {
  if(isagent(var_0)) {
    return 0;
  }

  return var_0._id_399D < level._id_9C85;
}

_id_3194(var_0) {
  return var_0 < level._id_9C62;
}

_id_97AA() {
  var_0 = _func_007F("deathCount");

  if(!_id_3193(self) || !_id_3194(var_0)) {
    return;
  }
}