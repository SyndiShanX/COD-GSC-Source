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

function canlogclient(var0) {
  if(isagent(var0)) {
    return false;
  }

  return var0.clientid < level.maxlogclients;
}

function canlogdeath(var0) {
  return var0 < 300;
}

function logplayerdeath(var0) {
  if(getdvarint("MTKSQRQLKN") == 0) {
    return;
  }

  var1 = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(var1)) {
    return;
  }

  if(isPlayer(var0) && canlogclient(var0)) {
    self logclientmatchdatadeath(var1, self.clientid, var0, var0.clientid);
    return;
  }

  self logclientmatchdatadeath(var1, self.clientid, undefined, undefined);
}