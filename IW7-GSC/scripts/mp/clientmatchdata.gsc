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

canlogclient(var_0) {
  if(isagent(var_0)) {
    return 0;
  }

  return var_0.clientid < level.maxlogclients;
}

canlogdeath(var_0) {
  return var_0 < level.maxdeathlogs;
}

logplayerdeath(var_0) {
  var_1 = getclientmatchdata("deathCount");
  if(!canlogclient(self) || !canlogdeath(var_1)) {
    return;
  }

  if(isplayer(var_0) && canlogclient(var_0)) {
    self getufolightcolor(var_1, self.clientid, var_0, var_0.clientid);
    return;
  }

  self getufolightcolor(var_1, self.clientid, undefined, undefined);
}