/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\clientmatchdata.gsc
***********************************************/

function init() {
  if(getdvarint("MTKSQRQLKN") != 0 && !isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.heavydamageawardlaunchonly = &logplayerdeath;
}

function canlogclient(var_0) {
  if(isagent(var_0)) {
    return false;
  }

  return var_0.clientid < level.maxlogclients;
}

function canlogdeath(var_0) {
  return var_0 < 300;
}

function logplayerdeath(var_0) {
  if(getdvarint("MTKSQRQLKN") == 0) {
    return;
  }

  var_1 = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(var_1)) {
    return;
  }

  if(isPlayer(var_0) && canlogclient(var_0)) {
    self logclientmatchdatadeath(var_1, self.clientid, var_0, var_0.clientid);
    return;
  }

  self logclientmatchdatadeath(var_1, self.clientid, undefined, undefined);
}