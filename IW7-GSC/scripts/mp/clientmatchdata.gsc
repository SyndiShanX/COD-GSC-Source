/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\clientmatchdata.gsc
******************************************/

init() {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp\clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.maxdeathlogs = 200;
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

logplayerdeath(param_00) {
  var_01 = getclientmatchdata("deathCount");
  if(!canlogclient(self) || !canlogdeath(var_01)) {
    return;
  }

  if(isplayer(param_00) && canlogclient(param_00)) {
    self getufolightcolor(var_01, self.clientid, param_00, param_00.clientid);
    return;
  }

  self getufolightcolor(var_01, self.clientid, undefined, undefined);
}