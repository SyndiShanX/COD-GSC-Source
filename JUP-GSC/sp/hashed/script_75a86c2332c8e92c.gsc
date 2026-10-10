/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_75a86c2332c8e92c.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_e12d9122c31ca175;

function init() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  if(!isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/zombieclientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.maxdeaths = 50;
}