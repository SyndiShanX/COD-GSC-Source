/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_hind.gsc
**************************************/

#include maps\_vehicle;
#using_animtree("vehicles");
main() {
  self.script_badplace = false;
  level._effect["rotor_full"] = LoadFX("vehicle/props/fx_hind_main_blade_full");
  level._effect["rotor_small_full"] = LoadFX("vehicle/props/fx_hind_small_blade_full");
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}
set_vehicle_anims(positions) {
  return positions;
}
#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 4; i++) {
    positions[i] = spawnStruct();
  }
  return positions;
}
unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}