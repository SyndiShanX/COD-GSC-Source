/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_civ_vehicle.gsc
**************************************/

#include maps\_vehicle;

main() {
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
  level._effect["sand"] = loadFX("vehicle/treadfx/fx_treadfx_sand");
}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");
setanims() {}
unload_groups() {}