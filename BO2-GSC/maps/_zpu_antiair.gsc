/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zpu_antiair.gsc
**************************************/

#include maps\_vehicle;

main() {
  build_aianims(::setanims);
  build_unload_groups(::unload_groups);
}

#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 1; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[0].idle = % crew_zpu4_idle;
  positions[0].death = % crew_zpu4_death;
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