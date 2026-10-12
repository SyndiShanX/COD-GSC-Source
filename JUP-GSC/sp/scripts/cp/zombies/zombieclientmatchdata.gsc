/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombieclientmatchdata.gsc
********************************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace zombieclientmatchdata;

function init() {
  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/zombieclientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.maxdeaths = 50;
}