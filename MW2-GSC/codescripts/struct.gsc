/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: codescripts\struct.gsc
********************************************************/

InitStructs() {
  level.struct = [];
}

CreateStruct() {
  struct = spawnStruct();
  level.struct[level.struct.size] = struct;
  return struct;
}