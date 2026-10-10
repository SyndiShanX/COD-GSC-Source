/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\vehicle\veh9_mil_lnd_cargo_truck.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle_build;
#namespace veh9_mil_lnd_cargo_truck;

function main(model, type, classname) {
  archetype = "mil_lnd_cargo_truck_ts2_stand";

  if(issubstr(model, "midcargo")) {
    archetype = "mil_lnd_cargo_truck_midcargo_ts2_stand";
  }

  build_template("milarmor", model, type, classname);
  build_localinit(&init_local);
  build_aianims(&setanims, &set_vehicle_anims, archetype);
  build_unload_groups(&unload_groups);
  build_hud(classname, 1);
  huskmodel = "veh9_mil_lnd_cargo_truck_vehphys_hsk_sp";

  switch (model) {
    case #"hash_2ecd92b62f084439":
    case #"hash_92054d76aa12feb4":
    case #"hash_bcb773c7b4411fd5":
    case #"hash_dca20c73a80854bf":
      huskmodel = "veh9_mil_lnd_cargo_truck_flatbed_vehphys_hsk_sp";
      break;
    case #"hash_76fab6e41b51d4f":
    case #"hash_5231a47538926bf5":
    case #"hash_72c90d6f2d7067d6":
    case #"hash_e29528ff3e82a85f":
      huskmodel = "veh9_mil_lnd_cargo_truck_midcargo_vehphys_hsk_sp";
      break;
    case #"hash_afc77339c1a53201":
    case #"hash_f24f9022585024ea":
      huskmodel = "veh9_mil_lnd_cargo_truck_cover_open_vehphys_hsk_sp";
      break;
    case #"hash_4a4ff6a578754725":
    case #"hash_da7248a216cfd682":
      huskmodel = "veh9_mil_lnd_cargo_truck_cover_closed_vehphys_hsk_sp";
      break;
    case #"hash_fc6a39899c21f18f":
    case #"hash_fe948edcadd20f8e":
      huskmodel = "veh9_mil_lnd_cargo_truck_x_vehphys_hsk_sp";
      break;
  }

  husktype = "veh9_mil_lnd_cargo_truck_physics_sp";

  switch (classname) {
    case #"hash_e3518ca32a32bd27":
      husktype = "veh9_mil_lnd_cargo_truck_physics_sp_gunship";
      break;
    case #"hash_9658f5a8d36ea10f":
      husktype = "veh_jup_mil_lnd_cargo_truck_cover_physics_sp_gunship";
      break;
    case #"hash_958dd96013ef30fe":
      husktype = "veh9_mil_lnd_cargo_truck_physics_sp_stolen";
      break;
    case #"hash_1c61e17faa8b3dad":
      husktype = "veh9_mil_lnd_cargo_truck_physics_sp_intercept";
      break;
    case #"hash_72d37e3470694ede":
      husktype = "veh9_mil_lnd_cargo_truck_physics_sp_backstabbed";
      break;
    case #"hash_fbdc0e20e12e425":
    case #"hash_4208a5a4e06e09fd":
    case #"hash_8fbc61826c6fabc5":
    case #"hash_9237213f724d30f5":
      husktype = "veh9_mil_lnd_cargo_truck_cover_physics_sp";
      break;
    case #"hash_84a2ba36ae66e5c8":
      husktype = "veh9_mil_lnd_cargo_truck_cover_physics_sp_backstabbed";
      break;
  }

  build_husk(model, huskmodel, husktype, 0);
  function_2660787ca33cf457(classname, "tag_door_front_left", ["tag_window_front_left", "tag_mirror_left"]);
  function_2660787ca33cf457(classname, "tag_door_front_right", ["tag_window_front_right", "tag_mirror_right"]);
  function_2cf37d073c6bde84(classname, "headlight_front_left", "tag_light_front_left", "headlights");
  function_2cf37d073c6bde84(classname, "headlight_front_right", "tag_light_front_right", "headlights");
  function_2cf37d073c6bde84(classname, "taillight_back_left", "tag_light_back_left", "headlights");
  function_2cf37d073c6bde84(classname, "taillight_back_right", "tag_light_back_right", "headlights");
  function_2cf37d073c6bde84(classname, "brakelight_back_left", "tag_light_back_left", "brakelights");
  function_2cf37d073c6bde84(classname, "brakelight_back_right", "tag_light_back_right", "brakelights");
  function_2cf37d073c6bde84(classname, "daylight_front_left", "tag_light_front_left", "daylights");
  function_2cf37d073c6bde84(classname, "daylight_front_right", "tag_light_front_right", "daylights");
  function_2cf37d073c6bde84(classname, "daylight_back_left", "tag_light_back_left", "daylights");
  function_2cf37d073c6bde84(classname, "daylight_back_right", "tag_light_back_right", "daylights");
}

#using_animtree("vehicles");

function init_local() {
  if(utility::issp()) {
    self useanimtree(#animtree);
  }

  self.script_badplace = 1;
  archetype = "mil_lnd_cargo_truck_ts2_stand";

  if(issubstr(self.model, "midcargo")) {
    archetype = "mil_lnd_cargo_truck_midcargo_ts2_stand";
  }

  self.vehicleanimalias = archetype;
}

function set_vehicle_anims(positions) {
  positions[0].vehicle_getinanim = % iw9_veh_cargo_truck_seat_0_entry_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getinanim = % iw9_veh_cargo_truck_seat_1_entry_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim = % iw9_veh_cargo_truck_seat_0_exit_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim = % iw9_veh_cargo_truck_seat_1_exit_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim_combat = % iw9_veh_cargo_truck_seat_0_exit_combat_idle_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim_combat = % iw9_veh_cargo_truck_seat_1_exit_combat_idle_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim_combat_run = % iw9_veh_cargo_truck_seat_0_exit_combat_run_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim_combat_run = % iw9_veh_cargo_truck_seat_1_exit_combat_run_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  return positions;
}

function setanims() {
  positions = [];

  for(i = 0; i < 9; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].bhasgunwhileriding = 0;
  positions[0].sittag = "TAG_SEAT_WM_0";
  positions[1].sittag = "TAG_SEAT_WM_1";
  positions[2].sittag = "TAG_SEAT_WM_2";
  positions[3].sittag = "TAG_SEAT_WM_3";
  positions[4].sittag = "TAG_SEAT_WM_4";
  positions[5].sittag = "TAG_SEAT_WM_5";
  positions[6].sittag = "TAG_SEAT_WM_6";
  positions[7].sittag = "TAG_SEAT_WM_7";
  positions[8].sittag = "TAG_TURRET";
  positions[2].deathragdoll = 1;
  positions[3].deathragdoll = 1;
  positions[4].deathragdoll = 1;
  positions[5].deathragdoll = 1;
  positions[6].deathragdoll = 1;
  positions[7].deathragdoll = 1;
  positions[8].deathragdoll = 1;
  positions[0].canshootinvehicle = 0;
  positions[1].canshootinvehicle = 0;
  positions[2].canshootinvehicle = 1;
  positions[3].canshootinvehicle = 1;
  positions[4].canshootinvehicle = 1;
  positions[5].canshootinvehicle = 1;
  positions[6].canshootinvehicle = 1;
  positions[7].canshootinvehicle = 1;
  positions[8].canshootinvehicle = 1;
  positions[0].death_impulse = 0;
  positions[1].death_impulse = 0;
  positions[2].death_impulse = 1;
  positions[3].death_impulse = 1;
  positions[4].death_impulse = 1;
  positions[5].death_impulse = 1;
  positions[6].death_impulse = 1;
  positions[7].death_impulse = 1;
  positions[8].death_impulse = 1;
  positions[0].var_bcd0a0afd54c6491 = 0;
  positions[1].var_bcd0a0afd54c6491 = 0;
  positions[2].var_bcd0a0afd54c6491 = 1;
  positions[3].var_bcd0a0afd54c6491 = 1;
  positions[4].var_bcd0a0afd54c6491 = 1;
  positions[5].var_bcd0a0afd54c6491 = 1;
  positions[6].var_bcd0a0afd54c6491 = 1;
  positions[7].var_bcd0a0afd54c6491 = 1;
  positions[8].var_bcd0a0afd54c6491 = 1;
  positions[0].var_70aa9eaf339ddb20 = 0;
  positions[1].var_70aa9eaf339ddb20 = 0;
  positions[2].var_70aa9eaf339ddb20 = 0;
  positions[3].var_70aa9eaf339ddb20 = 0;
  positions[4].var_70aa9eaf339ddb20 = 1;
  positions[5].var_70aa9eaf339ddb20 = 1;
  positions[6].var_70aa9eaf339ddb20 = 1;
  positions[7].var_70aa9eaf339ddb20 = 1;
  positions[8].var_70aa9eaf339ddb20 = 1;
  positions[8].do_not_unload = 1;
  positions[0].var_a06d61eb83f02f4 = 0;
  positions[1].var_a06d61eb83f02f4 = 0;
  positions[2].var_a06d61eb83f02f4 = 1;
  positions[3].var_a06d61eb83f02f4 = 1;
  positions[4].var_a06d61eb83f02f4 = 1;
  positions[5].var_a06d61eb83f02f4 = 1;
  positions[6].var_a06d61eb83f02f4 = 1;
  positions[7].var_a06d61eb83f02f4 = 1;
  positions[8].var_a06d61eb83f02f4 = 0;
  return positions;
}

function unload_groups() {
  unload_groups = [];
  unload_groups["driver"] = [0];
  unload_groups["turret"] = [8];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6, 7];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}