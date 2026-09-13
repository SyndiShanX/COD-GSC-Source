/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\struct.gsc
***********************************************/

initstructs() {
  level.struct = [];
}

createstruct() {
  struct = spawnStruct();
  level.struct[level.struct.size] = struct;
  return struct;
}