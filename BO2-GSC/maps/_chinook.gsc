/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_chinook.gsc
**************************************/

#include maps\_vehicle;

main() {
  self.script_badplace = 0;
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}

set_vehicle_anims(positions) {
  return positions;
}

setanims() {
  positions = [];

  for(i = 0; i < 9; i++)
    positions[i] = spawnstruct();

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  return unload_groups;
}