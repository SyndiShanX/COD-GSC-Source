/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\code\struct.gsc
***********************************/

initstructs() {
  level.struct = [];
}

createstruct() {
  var_0 = spawnStruct();
  level.struct[level.struct.size] = var_0;
  return var_0;
}