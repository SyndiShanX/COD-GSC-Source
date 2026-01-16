/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: codescripts\struct.gsc
**************************************/

InitStructs() {
  level.struct = [];
}

CreateStruct() {
  struct = spawnstruct();
  level.struct[level.struct.size] = struct;
  return struct;
}

FindStruct(position) {
  for(i = 0; i < level.struct.size; i++) {
    if(distanceSquared(level.struct[i].origin, position) < 1) {
      return level.struct[i];
    }
  }
  return undefined;
}