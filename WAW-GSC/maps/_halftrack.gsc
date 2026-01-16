/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_halftrack.gsc
*****************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;

main(model, type, do_build_death) {
  build_template("halftrack", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_ger_tracked_halftrack", "vehicle_ger_tracked_halftrack_d", undefined, do_build_death);
  build_deathmodel("vehicle_halftrack_mg_brush", "vehicle_halftrack_mg_brush_d", undefined, do_build_death);
  build_deathmodel("vehicle_halftrack_mg_woodland", "vehicle_halftrack_mg_woodland_d", undefined, do_build_death);
  build_deathmodel("vehicle_halftrack_rockets_woodland", "vehicle_halftrack_rockets_woodland_d", do_build_death);
  build_deathmodel("vehicle_halftrack_mg_snow", "vehicle_halftrack_mg_brush_d", undefined, do_build_death);
  build_deathmodel("vehicle_halftrack_rockets_snow", "vehicle_halftrack_mg_brush_d", undefined, do_build_death);
  build_shoot_shock("tankblast");
  build_exhaust("vehicle/exhaust/fx_exhaust_halftrack");
  build_deathfx("vehicle/vexplosion/fx_vexplode_ger_halftrack", "tag_origin", "explo_metal_rand");
  build_deathquake(0.7, 1.0, 600);
  build_turret("mg42_bipod_stand", "tag_turret", "weapon_ger_mg_mg42", true);
  build_treadfx();
  build_life(999, 500, 1500);
  build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  build_team("axis");
  build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}
#using_animtree("tank");

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for (i = 0; i < 11; i++) {
    positions[i] = spawnstruct();
  }
  positions[0].sittag = "tag_gunner1";
  positions[1].sittag = "tag_passenger2";
  positions[2].sittag = "tag_passenger3";
  positions[3].sittag = "tag_passenger4";
  positions[4].sittag = "tag_passenger5";
  positions[5].sittag = "tag_passenger6";
  positions[6].sittag = "tag_passenger7";
  positions[7].sittag = "tag_passenger8";
  positions[8].sittag = "tag_passenger9";
  positions[0].idle = % technical_turret_aim_level_center;
  positions[0].mgturret = 0;
  positions[1].idle = % crew_halftrack_passenger2_idle;
  positions[2].idle = % crew_halftrack_passenger3_idle;
  positions[3].idle = % crew_halftrack_passenger4_idle;
  positions[4].idle = % crew_halftrack_passenger5_idle;
  positions[5].idle = % crew_halftrack_passenger6_idle;
  positions[6].idle = % crew_halftrack_passenger7_idle;
  positions[7].idle = % crew_halftrack_passenger8_idle;
  positions[8].idle = % crew_halftrack_passenger9_idle;
  positions[1].getout = % crew_halftrack_passenger2_exit_normal;
  positions[2].getout = % crew_halftrack_passenger3_exit_normal;
  positions[3].getout = % crew_halftrack_passenger4_exit_normal;
  positions[4].getout = % crew_halftrack_passenger5_exit_normal;
  positions[5].getout = % crew_halftrack_passenger6_exit_normal;
  positions[6].getout = % crew_halftrack_passenger7_exit_normal;
  positions[7].getout = % crew_halftrack_passenger8_exit_normal;
  positions[8].getout = % crew_halftrack_passenger9_exit_normal;
  positions[1].getout_combat = % crew_halftrack_passenger2_exit_jumpout;
  positions[2].getout_combat = % crew_halftrack_passenger3_exit_jumpout;
  positions[3].getout_combat = % crew_halftrack_passenger4_exit_jumpout;
  positions[4].getout_combat = % crew_halftrack_passenger5_exit_jumpout;
  positions[5].getout_combat = % crew_halftrack_passenger6_exit_jumpout;
  positions[6].getout_combat = % crew_halftrack_passenger7_exit_jumpout;
  positions[7].getout_combat = % crew_halftrack_passenger8_exit_jumpout;
  positions[8].getout_combat = % crew_halftrack_passenger9_exit_jumpout;
  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["passengers"] = [];
  unload_groups["all"] = [];
  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;
  unload_groups[group][unload_groups[group].size] = 8;
  unload_groups[group][unload_groups[group].size] = 9;
  unload_groups[group][unload_groups[group].size] = 10;
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;
  unload_groups[group][unload_groups[group].size] = 7;
  unload_groups[group][unload_groups[group].size] = 8;
  unload_groups[group][unload_groups[group].size] = 9;
  unload_groups[group][unload_groups[group].size] = 10;
  unload_groups["default"] = unload_groups["passengers"];
  return unload_groups;
}