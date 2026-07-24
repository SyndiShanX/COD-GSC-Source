/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3057.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("towcart", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_318B(%vehicle_towcart_drive_forward, %vehicle_towcart_drive_backward, 8);
  scripts\sp\vehicle_build::_id_31C6("script_vehicle_civilian_firetruck", "default", "vfx/core/tread/tread_dust_default.vfx");
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);
  scripts\sp\vehicle_build::_id_31C4("allies");
  scripts\sp\vehicle_build::_id_3186("veh_ind_lnd_tow_cart", "veh_ind_lnd_tow_cart");
  scripts\sp\vehicle_build::_id_3184("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "explo_metal_rand");
  scripts\sp\vehicle_build::_id_31B3((0, 0, 0), 0, 0, 0, 0);
  scripts\sp\vehicle_build::build_ace(::_id_F643);
  scripts\sp\vehicle_build::_id_31CC(::_id_12BBD);
}

init_location() {}

#using_animtree("generic_human");

_id_F643() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1]._id_10220 = "tag_detach";
  }

  var_0[0]._id_92CC = % shipcrib_hangar_veh_tow_driver_idle;
  var_0[1]._id_92CC = % shipcrib_hangar_veh_tow_passenger_idle;
  var_0[2]._id_92CC = % shipcrib_hangar_veh_tow_rear_idle;
  return var_0;
}

_id_12BBD() {
  var_0 = [];
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0["default"] = var_0["all"];
  return var_0;
}

_id_11A51() {
  self endon("entitydeleted");
  playFXOnTag(loadfx("vfx/_requests/shipcrib/vfx_light_flash_red.vfx"), self, "tag_glass_2_light");
}

_id_11A4C() {
  stopFXOnTag(loadfx("vfx/_requests/shipcrib/vfx_light_flash_red.vfx"), self, "tag_glass_2_light");
  self delete();
}