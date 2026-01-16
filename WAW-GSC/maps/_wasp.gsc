/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_wasp.gsc
*****************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;

main(model, type) {
  build_template("wasp", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_brt_tracked_wasp", "vehicle_brt_tracked_wasp_d");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_deathquake(0.6, 1.0, 400);
  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_mainturret();
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::unload_groups);
}

init_local() {}
#using_animtree("tank");

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for (i = 0; i < 6; i++)
    positions[i] = spawnstruct();
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[0].idle = % crew_jeep1_driver_drive_idle;
  positions[1].idle = % crew_jeep1_passenger1_drive_idle;
  positions[0].getout = % crew_jeep1_driver_climbout;
  positions[1].getout = % crew_jeep1_passenger1_climbout;
  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  unload_groups["passengers"] = [];
  unload_groups["none"] = [];
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups["default"] = unload_groups["none"];
  return unload_groups;
}