/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1fc7b693520ea2b9.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("truckbig", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "fullsized_pickup_2014");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::_id_26ADACDEDD87D439(classname, 2);
  _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_pickup_fullsized_2014_vehphys_hsk_sp";

  switch (model) {
    case "veh9_civ_lnd_pickup_fullsized_2014_tech_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_pickup_fullsized_2014_tech_vehphys_hsk_sp";
      break;
    case "veh9_civ_lnd_pickup_fullsized_2014_tech_aq_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_pickup_fullsized_2014_tech_aq_vehphys_hsk_sp";
      break;
    case "veh9_civ_lnd_pickup_fullsized_2014_border_patrol_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_pickup_fullsized_2014_border_patrol_vehphys_hsk_sp";
      break;
    case "veh9_civ_lnd_pickup_fullsized_2014_police_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_pickup_fullsized_2014_police_vehphys_hsk_sp";
      break;
  }

  _id_CFB2CE4545421678 = "veh9_pickup_fullsized_2014_physics_sp";

  switch (classname) {
    case "script_vehicle_iw9_pickup_fullsize_2014_physics_stolen":
      _id_CFB2CE4545421678 = "veh9_pickup_fullsized_2014_physics_sp_stolen";
      break;
    case "script_vehicle_iw9_pickup_fullsize_2014_tech_physics_backstabbed":
      _id_CFB2CE4545421678 = "veh9_pickup_fullsized_2014_physics_sp_backstabbed";
      break;
    case "script_vehicle_iw9_pickup_fullsize_2014_tech_physics_gunship":
      _id_CFB2CE4545421678 = "veh9_pickup_fullsized_2014_physics_sp_gunship";
      break;
    case "script_vehicle_iw9_pickup_fullsize_2014_tech_physics_intercept":
      _id_CFB2CE4545421678 = "veh9_pickup_fullsized_2014_physics_sp_intercept";
      break;
  }

  scripts\common\vehicle_build::_id_98128821320ABA35(model, _id_12A4C0B2EEB1DB9D, _id_CFB2CE4545421678);
  scripts\common\vehicle_build::_id_2660787CA33CF457(classname, "tag_door_front_left", ["tag_window_front_left", "tag_mirror_left"]);
  scripts\common\vehicle_build::_id_2660787CA33CF457(classname, "tag_door_front_right", ["tag_window_front_right", "tag_mirror_right"]);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "headlight_front_left", "tag_light_front_left", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "headlight_front_right", "tag_light_front_right", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "taillight_back_left", "tag_light_back_left", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "taillight_back_right", "tag_light_back_right", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "foglight_front_left", "tag_light_front_left_2", "foglights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "foglight_front_right", "tag_light_front_right_2", "foglights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "brakelight_back_left", "tag_light_back_left", "brakelights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "brakelight_back_right", "tag_light_back_right", "brakelights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_front_left", "tag_light_front_left", "daylights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_front_right", "tag_light_front_right", "daylights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_back_left", "tag_light_back_left", "daylights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_back_right", "tag_light_back_right", "daylights");
}

#using_animtree("vehicles");

init_local() {
  if(scripts\common\utility::issp())
    self useanimtree(#animtree);

  self.script_badplace = 1;
  self.vehicleanimalias = "fullsized_pickup_2014";
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_0_entry_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_1_entry_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_2_entry_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % iw9_veh_pickup_fullsize_2014_seat_3_entry_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_0_exit_idle_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_1_exit_idle_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_2_exit_idle_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % iw9_veh_pickup_fullsize_2014_seat_3_exit_idle_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_0_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_1_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_2_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat = % iw9_veh_pickup_fullsize_2014_seat_3_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_0_exit_run_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_1_exit_run_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_2_exit_run_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat_run = % iw9_veh_pickup_fullsize_2014_seat_3_exit_run_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_SEAT_WM_0";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_SEAT_WM_1";
  _id_E4B7E99A96C8829F[2].sittag = "TAG_SEAT_WM_2";
  _id_E4B7E99A96C8829F[3].sittag = "TAG_SEAT_WM_3";
  _id_E4B7E99A96C8829F[4].sittag = "TAG_SEAT_WM_4";
  _id_E4B7E99A96C8829F[5].sittag = "TAG_SEAT_WM_5";
  _id_E4B7E99A96C8829F[6].sittag = "TAG_SEAT_WM_6";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[4].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[6].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[0]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[1]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[2]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[3]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[4]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[5]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[6]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 0;
  _id_E4B7E99A96C8829F[1].death_impulse = 1;
  _id_E4B7E99A96C8829F[2].death_impulse = 1;
  _id_E4B7E99A96C8829F[3].death_impulse = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[6].death_impulse = 1;
  _id_E4B7E99A96C8829F[0]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[1]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[2]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[3]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[4]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[5]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[6]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[0]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[1]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[2]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[3]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[4]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[5]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[6]._id_70AA9EAF339DDB20 = 1;
  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    unload_groups["default"][_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  unload_groups["driver"] = [0];
  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["backseats"] = [2, 3];
  unload_groups["entirecab"] = [0, 1, 2, 3];
  return unload_groups;
}