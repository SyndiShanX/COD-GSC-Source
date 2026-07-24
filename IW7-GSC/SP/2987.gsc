/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2987.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("capital_ship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  _id_0BA9::_id_39B3(var_0, "un", var_2);
  precachemodel("veh_mil_air_un_cruiser_rig");
  precachemodel("veh_mil_air_un_cruiser_engines");
  precachemodel("veh_mil_air_un_cruiser_details");

  if(issubstr(var_2, "cheap")) {
    precachemodel("veh_mil_air_un_cruiser_periph");
    precachemodel("ship_exterior_un_cannon_b_rig");
    precacheturret("cap_turret_cannon_large_un");
    level._effect["capital_turret_muzzle_lg"] = loadfx("vfx/iw7/core/muzflash/cannon/vfx_mega_cannon_muzflash.vfx");
    level._effect["capital_un_turret_sml_cheap"] = loadfx("vfx/iw7/core/muzflash/cannon/vfx_un_turret_small_cheap.vfx");
    return;
  }

  precachemodel("veh_mil_air_un_cruiser");
  precachemodel("vfx_ftl_ca_destroyer");
  precacheturret("cap_turret_cannon_large_un");
  precacheturret("cap_turret_cannon_large_un_zerog");
  level._effect["cruiser_un_warp_in"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_destroyer_warp_in.vfx");
  level._effect["cruiser_un_warp_out"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_destroyer_warp_out.vfx");
  level._effect["cruiser_death"] = loadfx("vfx/iw7/core/expl/vehicle/vfx_destroyer_death_dps.vfx");
}

init_location() {
  thread _id_0BA9::_id_396E("un");
  scripts\sp\vehicle::_id_8441();
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_s", "un_thruster_down_sml", self._id_5020);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_m", "un_thruster_down_med", self._id_5020);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_l", "un_thruster_down_lrg", self._id_5020);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_m", "un_thruster_rear_med", self._id_501F);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_l", "un_thruster_rear_lrg", self._id_501F);
  self._id_539B = ["veh_mil_air_un_cruiser_engines", "veh_mil_air_un_cruiser_details"];

  if(issubstr(self.classname, "cheap")) {
    return;
  }
  thread _id_1EDC();
  self._id_7482 = "cruiser_un_warp";
  self._id_748F = "vfx_ftl_ca_destroyer";
  self._id_4E09 = "cruiser_death";
}

#using_animtree("vehicles");

_id_1EDC() {
  level._id_EC87["ftl_model"] = #animtree;
  level._id_EC8C["ftl_model"] = "vfx_ftl_ca_destroyer";
  level._id_EC85["ftl_model"]["ftl_in"] = % vfx_ftl_ca_destroyer_in;
  level._id_EC85["ftl_model"]["ftl_out"] = % vfx_ftl_ca_destroyer_out;
}