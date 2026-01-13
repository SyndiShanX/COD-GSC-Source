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

canlogclient(var_0) {
  if(isagent(var_0)) {
    return 0;
  }

  return var_0.clientid < level.maxlogclients;
}

canlogdeath(var_0) {
  return var_0 < level.maxdeathlogs;
}

logplayerdeath() {
  var_0 = getclientmatchdata("deathCount");
  if(!canlogclient(self) || !canlogdeath(var_0)) {}
}