/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_buffalo.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;

main(model, type) {
  build_template("buffalo", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_usa_tracked_lvta4_amtank", "vehicle_usa_tracked_lvta4_amtank_d");
  build_deathmodel("vehicle_usa_tracked_lvta4_amtank_8k", "vehicle_usa_tracked_lvta4_amtank_d_8k");
  build_deathmodel("vehicle_usa_tracked_lvta2", "vehicle_usa_tracked_lvta2_d");
  build_deathmodel("vehicle_usa_tracked_lvt4", "vehicle_usa_tracked_lvt4_dest");
  build_deathmodel("vehicle_usa_tracked_lvt4_8k", "vehicle_usa_tracked_lvt4_dest");
  build_deathmodel("vehicle_usa_tracked_gunners", "vehicle_usa_tracked_gunners");

  build_deathfx("vehicle/vexplosion/fx_Vexplode_lvt_beach", undefined, "explo_metal_rand");

  build_treadfx(type);
  build_exhaust("vehicle/exhaust/fx_exhaust_lvt");
  build_life(9999998, 9999998, 9999999);
  build_team("allies");
  build_aianims(::setanims, ::set_vehicle_anims);
}
init_local() {}
#using_animtree("tank");
set_vehicle_anims(positions) {
  return positions;
}
#using_animtree("generic_human");
setanims() {
  max_positions = 8;

  positions = [];
  for(i = 0; i < max_positions; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].sittag = "tag_passenger2";
  positions[1].sittag = "tag_passenger3";
  positions[2].sittag = "tag_passenger4";
  positions[3].sittag = "tag_passenger5";
  positions[4].sittag = "tag_passenger6";
  positions[5].sittag = "tag_passenger7";
  positions[6].sittag = "tag_passenger8";
  positions[7].sittag = "tag_passenger9";

  positions[0].idle = % crew_lvt4_passenger2_idle;
  positions[1].idle = % crew_lvt4_passenger3_idle;
  positions[2].idle = % crew_lvt4_passenger4_idle;
  positions[3].idle = % crew_lvt4_passenger5_idle;
  positions[4].idle = % crew_lvt4_passenger6_idle;
  positions[5].idle = % crew_lvt4_passenger7_idle;
  positions[6].idle = % crew_lvt4_passenger8_idle;
  positions[7].idle = % crew_lvt4_passenger9_idle;

  positions[0].getout = % crew_lvt4_passenger2_exit_normal;
  positions[1].getout = % crew_lvt4_passenger3_exit_normal;
  positions[2].getout = % crew_lvt4_passenger4_exit_normal;
  positions[3].getout = % crew_lvt4_passenger5_exit_normal;
  positions[4].getout = % crew_lvt4_passenger6_exit_normal;
  positions[5].getout = % crew_lvt4_passenger7_exit_normal;
  positions[6].getout = % crew_lvt4_passenger8_exit_normal;
  positions[7].getout = % crew_lvt4_passenger9_exit_normal;

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["passengers"] = [];
  unload_groups["all"] = [];

  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;

  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;

  unload_groups["default"] = unload_groups["passengers"];

  return unload_groups;
}