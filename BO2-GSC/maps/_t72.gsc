/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_t72.gsc
**************************************/

#include maps\_vehicle;

set_vehicle_anims(positions) {
  return positions;
}

setanims() {
  positions = [];

  for(i = 0; i < 11; i++)
    positions[i] = spawnstruct();

  positions[0].getout_delete = 1;
  return positions;
}