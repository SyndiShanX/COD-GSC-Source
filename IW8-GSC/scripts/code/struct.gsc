/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\struct.gsc
***********************************************/

function initstructs() {
  level.struct = [];
}

function createstruct() {
  var_0 = spawnStruct();
  level.struct[level.struct.size] = var_0;
  return var_0;
}