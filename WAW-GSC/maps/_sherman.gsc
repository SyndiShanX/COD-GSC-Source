/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_sherman.gsc
*****************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;

main(model, type) {
  build_template("sherman", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_usa_tracked_shermanm4a3", "vehicle_usa_tracked_shermanm4a3");
  build_deathmodel("vehicle_usa_tracked_shermanm4a3_green_w", "vehicle_usa_tracked_shermanm4a3_green_d_w");
  build_deathmodel("vehicle_usa_tracked_shermanm4a3_green", "vehicle_usa_tracked_shermanm4a3_green_d");
  build_deathmodel("vehicle_usa_tracked_shermanm4a3_camo", "vehicle_usa_tracked_shermanm4a3_camo_d");
  build_shoot_shock("tankblast");
  build_shoot_rumble("tank_fire");
  build_exhaust("vehicle/exhaust/fx_exhaust_sherman");
  build_deathfx("vehicle/vexplosion/fx_vexplode_usa_sherman", "tag_origin", "explo_metal_rand");
  build_deathquake(0.7, 1.0, 600);
  build_turret("sherman_tank_mg", "tag_turret2", "weapon_machinegun_tiger", false);
  build_treadfx(type);
  build_life(999, 500, 1500);
  build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  build_team("allies");
  build_mainturret();
  build_compassicon();
  build_aianims(::setanims, ::set_vehicle_anims);
  build_frontarmor(.33);
  level.vehicletypefancy["sherman"] = &"VEHICLENAME_SHERMAN_TANK";
}

init_local() {}
#using_animtree("tank");

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 10; i++) {
    positions[i] = spawnStruct();
  }
  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_passenger2";
  positions[3].sittag = "tag_passenger3";
  positions[4].sittag = "tag_passenger4";
  positions[5].sittag = "tag_passenger5";
  positions[6].sittag = "tag_passenger6";
  positions[7].sittag = "tag_passenger7";
  positions[8].sittag = "tag_passenger8";
  positions[9].sittag = "tag_passenger9";
  positions[0].idle = % crew_tank1_commander_idle;
  positions[1].idle = % crew_tank1_passenger1_idle;
  positions[2].idle = % crew_tank1_passenger2_idle;
  positions[3].idle = % crew_tank1_passenger3_idle;
  positions[4].idle = % crew_tank1_passenger4_idle;
  positions[5].idle = % crew_tank1_passenger5_idle;
  positions[6].idle = % crew_tank1_passenger6_idle;
  positions[7].idle = % crew_tank1_passenger7_idle;
  positions[8].idle = % crew_tank1_passenger8_idle;
  positions[9].idle = % crew_tank1_passenger9_idle;
  positions[4].idle_combat = % crew_sherman_passenger4_combatidle;
  positions[5].idle_combat = % crew_sherman_passenger5_combatidle;
  positions[6].idle_combat = % crew_sherman_passenger6_combatidle;
  positions[7].idle_combat = % crew_tank1_passenger7_combatidle;
  positions[8].idle_combat = % crew_tank1_passenger8_combatidle;
  positions[9].idle_combat = % crew_tank1_passenger9_combatidle;
  positions[0].getout = % crew_tank1_commander_dismount;
  positions[1].getout = % crew_tank1_passenger1_dismount;
  positions[2].getout = % crew_tank1_passenger2_dismount;
  positions[3].getout = % crew_tank1_passenger3_dismount;
  positions[4].getout = % crew_tank1_passenger4_dismount;
  positions[5].getout = % crew_tank1_passenger5_dismount;
  positions[6].getout = % crew_tank1_passenger6_dismount;
  positions[7].getout = % crew_tank1_passenger7_dismount;
  positions[8].getout = % crew_tank1_passenger8_dismount;
  positions[9].getout = % crew_tank1_passenger9_dismount;
  positions[4].getout_combat = % crew_sherman_passenger4_combatdismount_a;
  positions[5].getout_combat = % crew_sherman_passenger5_combatdismount_a;
  positions[6].getout_combat = % crew_sherman_passenger6_combatdismount_a;
  positions[7].getout_combat = % crew_tank1_passenger7_combatdismount;
  positions[8].getout_combat = % crew_tank1_passenger8_combatdismount;
  positions[9].getout_combat = % crew_tank1_passenger9_combatdismount;
  return positions;
}