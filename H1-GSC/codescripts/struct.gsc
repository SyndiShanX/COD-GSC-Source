/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: codescripts\struct.gsc
********************************/

initstructs() {
  level.struct = [];
}

createstruct() {
  var_0 = spawnstruct();
  level.struct[level.struct.size] = var_0;
  return var_0;
}