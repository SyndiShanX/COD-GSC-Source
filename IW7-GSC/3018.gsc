/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3018.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("forklift", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_318B(%vehicle_forklift_drive_forward, %vehicle_forklift_drive_backward, 8);
  scripts\sp\vehicle_build::_id_31C6("script_vehicle_civilian_firetruck", "default", "vfx/core/tread/tread_dust_default.vfx");
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);
  scripts\sp\vehicle_build::_id_31C4("allies");
  scripts\sp\vehicle_build::_id_3186("veh_ind_lnd_traditional_forklift", "veh_ind_lnd_traditional_forklift");
  scripts\sp\vehicle_build::_id_3184("vfx/core/expl/large_vehicle_explosion.vfx", undefined, "explo_metal_rand");
  scripts\sp\vehicle_build::_id_31B3((0, 0, 0), 0, 0, 0, 0);
  scripts\sp\vehicle_build::_id_31CC(::_id_12BBD);
  scripts\sp\vehicle_build::build_ace(::_id_F643, ::_id_F5FA);
  level._effect["forklift_red_flash"] = loadfx("vfx/_requests/shipcrib/vfx_light_flash_red.vfx");
}

init_location() {
  self endon("entitydeleted");
  self hide();
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("forklift_red_flash"), self, "tag_light_top_red");
  self setanimknob(%vehicle_forklift_lift_lowered, 1, 0.0);
  self show();
}

#using_animtree("generic_human");

_id_F643() {
  var_0 = [];
  var_0[0] = spawnStruct();
  var_0[0]._id_10220 = "tag_driver";
  var_0[0]._id_92CC = % shipcrib_hangar_forklift_driving_idle_01;
  return var_0;
}

#using_animtree("vehicles");

_id_F5FA(var_0) {
  var_0[0]._id_131E6 = % vh_apc_red_unload_door_l;
  var_0[0]._id_131E7 = 0;
  return var_0;
}

_id_12BBD() {
  var_0 = [];
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0["default"] = var_0["all"];
  return var_0;
}