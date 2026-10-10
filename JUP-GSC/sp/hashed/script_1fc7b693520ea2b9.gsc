/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1fc7b693520ea2b9.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle_build;
#namespace namespace_ba992ffcff31c0d9;

function main(model, type, classname) {
  build_template("truckbig", model, type, classname);
  build_localinit(&init_local);
  build_aianims(&setanims, &set_vehicle_anims, "fullsized_pickup_2014");
  build_unload_groups(&unload_groups);
  build_hud(classname, 2);
  huskmodel = "veh9_civ_lnd_pickup_fullsized_2014_vehphys_hsk_sp";

  switch (model) {
    case #"hash_2c732e4fbbd1b16":
      huskmodel = "veh9_civ_lnd_pickup_fullsized_2014_tech_vehphys_hsk_sp";
      break;
    case #"hash_4d9c0ee6e8beac53":
      huskmodel = "veh9_civ_lnd_pickup_fullsized_2014_tech_aq_vehphys_hsk_sp";
      break;
    case #"hash_424b0b2701bd8f5d":
      huskmodel = "veh9_civ_lnd_pickup_fullsized_2014_border_patrol_vehphys_hsk_sp";
      break;
    case #"hash_5a1799183df8f10c":
      huskmodel = "veh9_civ_lnd_pickup_fullsized_2014_police_vehphys_hsk_sp";
      break;
  }

  husktype = "veh9_pickup_fullsized_2014_physics_sp";

  switch (classname) {
    case #"hash_5602658a0708a039":
      husktype = "veh9_pickup_fullsized_2014_physics_sp_stolen";
      break;
    case #"hash_7b2ae92cc1a18ab3":
      husktype = "veh9_pickup_fullsized_2014_physics_sp_backstabbed";
      break;
    case #"hash_bb829ce801a97425":
      husktype = "veh9_pickup_fullsized_2014_physics_sp_gunship";
      break;
    case #"hash_6799e6ed0cded8da":
      husktype = "veh_jup_pickup_fullsized_2014_physics_sp_gunship";
      break;
    case #"hash_dc1e9f5ce4344cf3":
      husktype = "veh9_pickup_fullsized_2014_physics_sp_intercept";
      break;
  }

  build_husk(model, huskmodel, husktype);
  function_2660787ca33cf457(classname, "tag_door_front_left", ["tag_window_front_left", "tag_mirror_left"]);
  function_2660787ca33cf457(classname, "tag_door_front_right", ["tag_window_front_right", "tag_mirror_right"]);
  function_2cf37d073c6bde84(classname, "headlight_front_left", "tag_light_front_left", "headlights");
  function_2cf37d073c6bde84(classname, "headlight_front_right", "tag_light_front_right", "headlights");
  function_2cf37d073c6bde84(classname, "taillight_back_left", "tag_light_back_left", "headlights");
  function_2cf37d073c6bde84(classname, "taillight_back_right", "tag_light_back_right", "headlights");
  function_2cf37d073c6bde84(classname, "foglight_front_left", "tag_light_front_left_2", "foglights");
  function_2cf37d073c6bde84(classname, "foglight_front_right", "tag_light_front_right_2", "foglights");
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
  self.vehicleanimalias = "fullsized_pickup_2014";
}

function set_vehicle_anims(positions) {
  positions[0].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_0_entry_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_1_entry_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_2_entry_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_3_entry_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_0_exit_idle_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_1_exit_idle_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_2_exit_idle_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_3_exit_idle_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_0_exit_combat_idle_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_1_exit_combat_idle_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_2_exit_combat_idle_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_3_exit_combat_idle_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_0_exit_run_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_1_exit_run_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_2_exit_run_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_3_exit_run_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  return positions;
}

function setanims() {
  positions = [];

  for(i = 0; i < 7; i++) {
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
  positions[0].canshootinvehicle = 0;
  positions[1].canshootinvehicle = 0;
  positions[2].canshootinvehicle = 0;
  positions[3].canshootinvehicle = 0;
  positions[4].canshootinvehicle = 1;
  positions[5].canshootinvehicle = 1;
  positions[6].canshootinvehicle = 1;
  positions[4].deathragdoll = 1;
  positions[5].deathragdoll = 1;
  positions[6].deathragdoll = 1;
  positions[0].death_impulse = 0;
  positions[1].death_impulse = 1;
  positions[2].death_impulse = 1;
  positions[3].death_impulse = 1;
  positions[4].death_impulse = 1;
  positions[5].death_impulse = 1;
  positions[6].death_impulse = 1;
  positions[0].var_bcd0a0afd54c6491 = 0;
  positions[1].var_bcd0a0afd54c6491 = 0;
  positions[2].var_bcd0a0afd54c6491 = 0;
  positions[3].var_bcd0a0afd54c6491 = 0;
  positions[4].var_bcd0a0afd54c6491 = 1;
  positions[5].var_bcd0a0afd54c6491 = 1;
  positions[6].var_bcd0a0afd54c6491 = 1;
  positions[0].var_70aa9eaf339ddb20 = 0;
  positions[1].var_70aa9eaf339ddb20 = 0;
  positions[2].var_70aa9eaf339ddb20 = 0;
  positions[3].var_70aa9eaf339ddb20 = 0;
  positions[4].var_70aa9eaf339ddb20 = 1;
  positions[5].var_70aa9eaf339ddb20 = 1;
  positions[6].var_70aa9eaf339ddb20 = 1;
  return positions;
}

function unload_groups() {
  unload_groups = [];

  for(i = 0; i < 7; i++) {
    unload_groups["default"][i] = i;
  }

  unload_groups["driver"] = [0];
  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["backseats"] = [2, 3];
  unload_groups["entirecab"] = [0, 1, 2, 3];
  return unload_groups;
}