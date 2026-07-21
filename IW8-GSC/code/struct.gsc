/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: code\struct.gsc
***********************************************/

initstructs() {
  level.struct = [];
}

createstruct() {
  var_0 = spawnStruct();
  level.struct[level.struct.size] = var_0;
  return var_0;
}