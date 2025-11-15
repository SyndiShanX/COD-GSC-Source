/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3414.gsc
************************/

init() {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp\zombieclientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.maxdeathlogs = 50;
}

canlogclient(param_00) {
  if(isagent(param_00)) {
    return 0;
  }

  return param_00.clientid < level.maxlogclients;
}

canlogdeath(param_00) {
  return param_00 < level.maxdeathlogs;
}

logplayerdeath() {
  var_00 = getclientmatchdata("deathCount");
  if(!canlogclient(self) || !canlogdeath(var_00)) {}
}