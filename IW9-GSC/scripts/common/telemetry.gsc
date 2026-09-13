/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\telemetry.gsc
***********************************************/

init() {
  if(isDefined(game)) {
    if(!isDefined(game["telemetry"]))
      game["telemetry"] = spawnStruct();

    if(!isDefined(game["telemetry"]._id_AF0F7BFFF116DFE5))
      game["telemetry"]._id_AF0F7BFFF116DFE5 = 0;

    if(!isDefined(game["telemetry"]._id_BF9667D999B5EA7B))
      game["telemetry"]._id_BF9667D999B5EA7B = 0;

    if(!isDefined(game["telemetry"]._id_19EB71D207A4B2B8))
      game["telemetry"]._id_19EB71D207A4B2B8 = 0;
  } else {}
}