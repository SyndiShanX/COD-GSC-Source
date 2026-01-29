/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\20502.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("gaz_tigr_harbor", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ACD(::_id_3E58);
  maps\_vehicle::_id_2AC1( % humvee_50cal_driving_idle_forward, % humvee_50cal_driving_idle_backward, 10);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("axis");

  if(issubstr(var_2, "turret")) {
    maps\_vehicle::_id_2ACA(::_id_4438, ::_id_3A9C);

    if(issubstr(var_2, "_paris") || issubstr(var_2, "_hijack")) {
      maps\_vehicle::_id_2A4A("dshk_gaz_damage_player", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14);
    } else {
      maps\_vehicle::_id_2A4A("dshk_gaz", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14);
    }
  } else {
    maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);

  }
  if(var_2 == "script_vehicle_gaz_tigr_turret_physics_paris") {
    maps\_vehicle::_id_2AD0(var_0, "vehicle_gaz_harbor");
  } else {
    _id_4436(var_2);

  }
  var_3 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_3, "headlight_L", "TAG_HEADLIGHT_LEFT", "misc/spotlight_btr80_daytime", "running", 0.0);
  maps\_vehicle::_id_2AAD(var_3, "headlight_R", "TAG_HEADLIGHT_RIGHT", "misc/spotlight_btr80_daytime", "running", 0.0);
  maps\_vehicle::_id_2AAD(var_3, "brakelight_L", "TAG_BRAKELIGHT_LEFT", "misc/car_taillight_btr80_eye", "running", 0.0);
  maps\_vehicle::_id_2AAD(var_3, "brakelight_R", "TAG_BRAKELIGHT_RIGHT", "misc/car_taillight_btr80_eye", "running", 0.0);
}

_id_2B1D() {}

_id_3E58() {
  var_0 = [];
  var_1 = "passengers";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all_but_gunner";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "rear_driver_side";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}

_id_4436(var_0) {
  level._effect["gazfire"] = loadfx("fire/firelp_med_pm_nolight");
  level._effect["gazexplode"] = loadfx("explosions/vehicle_explosion_gaz");
  level._effect["gazcookoff"] = loadfx("explosions/ammo_cookoff");
  level._effect["gazsmfire"] = loadfx("fire/firelp_small_pm_a");
  maps\_vehicle::_id_2ABE("vehicle_gaz_tigr_harbor", "vehicle_gaz_tigr_harbor_destroyed");
  maps\_vehicle::_id_2ABE("vehicle_gaz_tigr_base", "vehicle_gaz_tigr_harbor_destroyed");
  maps\_vehicle::_id_2A02("explosions/vehicle_explosion_gaz", "tag_deathfx");
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight", "tag_cab_fx", undefined, undefined, undefined, 1, 0);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_trunk_fx", undefined, undefined, undefined, 1, 3);
  maps\_vehicle::_id_29F8(1, 1.6, 500);
  maps\_vehicle::_id_29F3((0, 0, 32), 300, 200, 0, 0);
}

_id_3A9C(var_0) {
  var_0[0]._id_2523 = % gaz_dismount_frontl_door;
  var_0[1]._id_2523 = % gaz_dismount_frontr_door;
  var_0[2]._id_2523 = % gaz_dismount_backl_door;
  var_0[3]._id_2523 = % gaz_dismount_backr_door;
  var_0[0]._id_2522 = % gaz_mount_frontl_door;
  var_0[1]._id_2522 = % gaz_mount_frontr_door;
  var_0[2]._id_2522 = % gaz_enter_back_door;
  var_0[3]._id_2522 = % gaz_enter_back_door;
  var_0[0]._id_2581 = "gaz_door_open";
  var_0[1]._id_2581 = "gaz_door_open";
  var_0[2]._id_2581 = "gaz_door_open";
  var_0[3]._id_2581 = "gaz_door_open";
  var_0[0]._id_2527 = "gaz_door_close";
  var_0[1]._id_2527 = "gaz_door_close";
  var_0[2]._id_2527 = "gaz_door_close";
  var_0[3]._id_2527 = "gaz_door_close";
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();

  }
  var_0[0]._id_24F2 = "tag_driver";
  var_0[1]._id_24F2 = "tag_passenger";
  var_0[2]._id_24F2 = "tag_guy0";
  var_0[3]._id_24F2 = "tag_guy1";
  var_0[0]._id_24F4 = 0;
  var_0[0]._id_1048 = % gaz_dismount_frontl;
  var_0[0]._id_2506 = 3;
  var_0[0]._id_0F59 = % gaz_idle_frontl;
  var_0[1]._id_0F59 = % gaz_idle_frontr;
  var_0[2]._id_0F59 = % gaz_idle_backl;
  var_0[3]._id_0F59 = % gaz_idle_backr;
  var_0[0]._id_257C = % gaz_dismount_frontl;
  var_0[1]._id_257C = % gaz_dismount_frontr;
  var_0[2]._id_257C = % gaz_dismount_backl;
  var_0[3]._id_257C = % gaz_dismount_backr;
  var_0[0]._id_2519 = % gaz_mount_frontl;
  var_0[1]._id_2519 = % gaz_mount_frontr;
  var_0[2]._id_2519 = % gaz_enter_backr;
  var_0[3]._id_2519 = % gaz_enter_backl;
  return var_0;
}

_id_4438() {
  var_0 = _id_3A9D();
  var_0[3].mgturret = 0;
  var_0[3]._id_25BB = ::_id_4439;
  var_0[3]._id_24F2 = "tag_guy_turret";
  return var_0;
}

_id_4439(var_0, var_1, var_2, var_3) {}