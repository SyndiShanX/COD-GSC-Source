/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_t72.gsc
**************************************/

#include maps\_vehicle;
#using_animtree("vehicles");
main() {}
set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 11; i++) {
    positions[i] = spawnStruct();
  }
  positions[0].getout_delete = true;
  return positions;
}