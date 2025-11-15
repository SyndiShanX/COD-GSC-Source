/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2708.gsc
***************************************/

init() {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "mp\clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.maxdeathlogs = 200;
}

canlogclient(var_00) {
  if(isagent(var_00))
    return 0;

  return var_0.clientid < level.maxlogclients;
}

canlogdeath(var_00) {
  return var_00 < level.maxdeathlogs;
}

logplayerdeath(var_00) {
  var_01 = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(var_01)) {
    return;
  }
  if(isplayer(var_00) && canlogclient(var_00))
    self getufolightcolor(var_01, self.clientid, var_00, var_0.clientid);
  else
    self getufolightcolor(var_01, self.clientid, undefined, undefined);
}