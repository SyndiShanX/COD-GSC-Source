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

function canlogclient(var0) {
  if(isagent(var0)) {
    return false;
  }

  return var0.clientid < level.maxlogclients;
}

function canlogdeath(var0) {
  return var0 < level.maxdeaths;
}

function logplayerdeath() {
  var0 = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(var0)) {
    return;
  }
}