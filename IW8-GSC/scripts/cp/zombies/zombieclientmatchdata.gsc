/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombieclientmatchdata.gsc
********************************************************/

function init() {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/zombieclientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.maxdeaths = 50;
}

function canlogclient(var_0) {
  if(isagent(var_0)) {
    return false;
  }

  return var_0.clientid < level.maxlogclients;
}

function canlogdeath(var_0) {
  return var_0 < level.maxdeaths;
}

function logplayerdeath() {
  var_0 = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(var_0)) {
    return;
  }
}