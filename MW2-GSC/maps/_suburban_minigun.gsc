/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_suburban_minigun.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");

main(model, type) {
  build_template("suburban_minigun", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_suburban_minigun_viewmodel", "vehicle_suburban_destroyed");
  build_deathmodel("vehicle_suburban_technical", "vehicle_suburban_destroyed");

  build_deathfx("fire/firelp_med_pm", "TAG_CAB_FIRE", "fire_metal_medium", undefined, undefined, true, 0);
  build_deathfx("explosions/vehicle_explosion_suburban_minigun", "TAG_DEATH_FX", "explo_metal_rand");

  build_drive(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);
  build_treadfx();

  build_life(3000, 500, 3000);
  build_team("allies");
  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::Unload_Groups);

  build_turret("suburban_minigun", "tag_turret", "weapon_suburban_minigun", undefined, "sentry", 0.2);
  build_bulletshield(true);

  build_radiusdamage((0, 0, 32), 300, 200, 0, false);
}

init_local() {}

#using_animtree("vehicles");
set_vehicle_anims(positions) {
  positions[0].vehicle_getoutanim = % suburban_dismount_frontL_door;
  positions[1].vehicle_getoutanim = % suburban_dismount_frontR_door;
  positions[2].vehicle_getoutanim = % suburban_dismount_backL_door;
  positions[3].vehicle_getoutanim = % suburban_dismount_backR_door;

  return positions;
}

#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 7; i++)
    positions[i] = spawnStruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy2";
  positions[4].sittag = "tag_guy3";
  positions[5].sittag = "tag_guy4";
  positions[6].sittag = "tag_guy_turret";

  positions[0].idle = % suburban_idle_frontL;
  positions[1].idle = % suburban_idle_frontR;
  positions[2].idle = % suburban_idle_backL;
  positions[3].idle = % suburban_idle_backR;

  positions[4].idle = % humvee_passenger_idle_R;
  positions[5].idle = % humvee_passenger_idle_L;

  positions[0].getout = % suburban_dismount_frontL;
  positions[1].getout = % suburban_dismount_frontR;
  positions[2].getout = % suburban_dismount_backL;
  positions[3].getout = % suburban_dismount_backR;

  positions[4].getout = % humvee_passenger_out_L;
  positions[5].getout = % humvee_passenger_out_R;

  positions[6].getout = % humvee_turret_2_passenger;
  positions[6].exittag = "tag_passenger";
  positions[6].getout_secondary = % humvee_passenger_out_R;
  positions[6].getout_secondary_tag = "tag_passenger";

  positions[0].getin = % humvee_driver_climb_in;
  positions[1].getin = % humvee_passenger_in_R;
  positions[2].getin = % humvee_passenger_in_R;
  positions[3].getin = % humvee_passenger_in_L;
  positions[4].getin = % humvee_passenger_in_L;
  positions[5].getin = % humvee_passenger_in_R;
  positions[6].getin = % humvee_passenger_in_R;

  positions[6].mgturret = 0;

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["passengers"] = [];
  unload_groups["all"] = [];
  unload_groups["everyone"] = [];

  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;

  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;

  group = "everyone";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;
  unload_groups[group][unload_groups[group].size] = 4;
  unload_groups[group][unload_groups[group].size] = 5;
  unload_groups[group][unload_groups[group].size] = 6;

  unload_groups["default"] = unload_groups["all"];

  return unload_groups;
}