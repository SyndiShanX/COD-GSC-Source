/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: codescripts\struct.gsc
**************************************/

initstructs() {
  level.struct = [];
}

createstruct() {
  struct = spawnstruct();
  level.struct[level.struct.size] = struct;
  return struct;
}

findstruct(position) {
  foreach(key, _ in level.struct_class_names) {
    foreach(val, s_array in level.struct_class_names[key]) {
      foreach(struct in s_array) {
        if(distancesquared(struct.origin, position) < 1)
          return struct;
      }
    }
  }
}