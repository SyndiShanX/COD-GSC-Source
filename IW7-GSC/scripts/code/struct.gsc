/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\code\struct.gsc
***********************************/

initstructs() {
  level.struct = [];
}

createstruct() {
  var_00 = spawnStruct();
  level.struct[level.struct.size] = var_00;
  return var_00;
}