/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2986.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("capital_ship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  _id_0BA9::_id_39B3(var_0, "ca", var_2);
  precachemodel("veh_mil_air_ca_cruiser");
  precachemodel("vfx_ftl_ca_destroyer");
  precacheturret("cap_turret_cannon_large_ca");
  precacheturret("cap_turret_cannon_large_ca_zerog");
  _id_0BB6::_id_12A89();
  level._effect["cruiser_ca_warp_in"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_destroyer_warp_in.vfx");
  level._effect["cruiser_ca_warp_out"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_destroyer_warp_out.vfx");
  level._effect["cruiser_death"] = loadfx("vfx/iw7/core/expl/vehicle/vfx_destroyer_death_dps.vfx");
}

init_location() {
  thread _id_0BA9::_id_396E("ca");
  thread _id_1EDC();
  scripts\sp\vehicle::_id_8441();
  self._id_7482 = "cruiser_ca_warp";
  self._id_748F = "vfx_ftl_ca_destroyer";
  self._id_4E09 = "cruiser_death";
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_s", "ca_thruster_down_sml", self._id_5020);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_m", "ca_thruster_down_med", self._id_5020);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_l", "ca_thruster_down_lrg", self._id_5020);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_s", "ca_thruster_rear_sml", self._id_501F);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_m", "ca_thruster_rear_med", self._id_501F);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_l", "ca_thruster_rear_lrg", self._id_501F);
}

#using_animtree("vehicles");

_id_1EDC() {
  level._id_EC87["ftl_model"] = #animtree;
  level._id_EC8C["ftl_model"] = "vfx_ftl_ca_destroyer";
  level._id_EC85["ftl_model"]["ftl_in"] = % vfx_ftl_ca_destroyer_in;
  level._id_EC85["ftl_model"]["ftl_out"] = % vfx_ftl_ca_destroyer_out;
}