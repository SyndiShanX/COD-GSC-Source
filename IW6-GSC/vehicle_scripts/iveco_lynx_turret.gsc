/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\iveco_lynx_turret.gsc
*************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("iveco_lynx_turret", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_aianims(::setanims_turret, ::set_vehicle_anims);
  maps\_vehicle::build_drive( % iveco_lynx_idle_driving_idle_forward, % iveco_lynx_idle_driving_idle_forward, 10);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  build_lynx_death(var_2);
  maps\_vehicle::build_turret("dshk_gaz_factory", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14);
  maps\_vehicle::build_light(var_2, "headlight_L", "tag_headlight_left", "fx/misc/spotlight_btr80_daytime", "running", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_R", "tag_headlight_right", "fx/misc/spotlight_btr80_daytime", "running", 0.0);
  maps\_vehicle::build_light(var_2, "brakelight_L", "tag_brakelight_left", "fx/misc/car_taillight_btr80_eye", "running", 0.0);
  maps\_vehicle::build_light(var_2, "brakelight_R", "tag_brakelight_right", "fx/misc/car_taillight_btr80_eye", "running", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_L", "tag_headlight_left", "vfx/gameplay/vehicles/iveco_headlight_l_night", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "headlight_R", "tag_headlight_right", "vfx/gameplay/vehicles/iveco_headlight_r_night", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "brakelight_L", "tag_brakelight_left", "fx/misc/car_taillight_btr80_eye", "headlights", 0.0);
  maps\_vehicle::build_light(var_2, "brakelight_R", "tag_brakelight_right", "fx/misc/car_taillight_btr80_eye", "headlights", 0.0);
}

init_local() {
  self hidepart("top_hatch_jnt");
}

build_lynx_death(var_0) {
  level._effect["lynxfire"] = loadfx("fx/fire/firelp_med_pm_nolight");

  if(isDefined(level.factory) && level.factory == 1) {
    level._effect["lynxexplode"] = loadfx("vfx/moments/factory/factory_chase_jeep_explosion");
  } else {
    level._effect["lynxexplode"] = loadfx("fx/explosions/vehicle_explosion_gaz");
  }

  level._effect["lynxcookoff"] = loadfx("fx/explosions/ammo_cookoff");
  level._effect["lynxsmfire"] = loadfx("fx/fire/firelp_small_pm_a");
  maps\_vehicle::build_deathmodel("vehicle_iveco_lynx_iw6", "vehicle_iveco_lynx_destroyed_iw6");

  if(isDefined(level.factory) && level.factory == 1) {
    maps\_vehicle::build_deathfx("vfx/moments/factory/factory_chase_jeep_explosion", "tag_origin");
  } else {
    maps\_vehicle::build_deathfx("fx/explosions/vehicle_explosion_gaz", "tag_origin");
  }

  maps\_vehicle::build_deathfx("fx/fire/firelp_med_pm_nolight", "tag_origin", undefined, undefined, undefined, 1, 0);
  maps\_vehicle::build_deathfx("fx/fire/firelp_small_pm_a", "tag_origin", undefined, undefined, undefined, 1, 3);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
}

unload_groups() {
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

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % gaz_dismount_frontl_door;
  var_0[1].vehicle_getoutanim = % gaz_dismount_frontr_door;
  var_0[2].vehicle_getoutanim = % gaz_dismount_backl_door;
  var_0[3].vehicle_getoutanim = % gaz_dismount_backr_door;
  var_0[0].vehicle_getinanim = % gaz_mount_frontl_door;
  var_0[1].vehicle_getinanim = % gaz_mount_frontr_door;
  var_0[2].vehicle_getinanim = % gaz_enter_back_door;
  var_0[3].vehicle_getinanim = % gaz_enter_back_door;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
  }

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy1";
  var_0[0].bhasgunwhileriding = 0;
  var_0[0].death = % gaz_dismount_frontl;
  var_0[0].death_delayed_ragdoll = 3;
  var_0[0].idle = % gaz_idle_frontl;
  var_0[1].idle = % gaz_idle_frontr;
  var_0[2].idle = % gaz_idle_backl;
  var_0[3].idle = % gaz_idle_backr;
  var_0[0].getout = % gaz_dismount_frontl;
  var_0[1].getout = % gaz_dismount_frontr;
  var_0[2].getout = % gaz_dismount_backl;
  var_0[3].getout = % gaz_dismount_backr;
  var_0[0].getin = % gaz_mount_frontl;
  var_0[1].getin = % gaz_mount_frontr;
  var_0[2].getin = % gaz_enter_backr;
  var_0[3].getin = % gaz_enter_backl;
  return var_0;
}

setanims_turret() {
  var_0 = setanims();
  var_0[3].mgturret = 0;
  var_0[3].sittag = "tag_guy_turret";
  return var_0;
}