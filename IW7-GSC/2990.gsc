/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2990.gsc
***************************************/

main(var_00, var_01, var_02) {
  scripts\sp\vehicle_build::func_31C5("capital_ship", var_00, var_01, var_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  func_0BA9::func_39B3(var_00, "un", var_02);
  precachemodel("veh_mil_air_un_destroyer_rig");
  precachemodel("veh_mil_air_un_destroyer_engines");
  precachemodel("veh_mil_air_un_destroyer_details");

  if(issubstr(var_02, "cheap")) {
    precachemodel("veh_mil_air_un_destroyer_periph");
    precachemodel("ship_exterior_un_cannon_b_rig");
    precacheturret("cap_turret_cannon_large_un");
    level._effect["capital_turret_muzzle_lg"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_mega_cannon_muzflash.vfx");
    level._effect["capital_un_turret_sml_cheap"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_un_turret_small_cheap.vfx");
    return;
  }

  precachemodel("veh_mil_air_un_destroyer");
  precachemodel("vfx_ftl_ca_destroyer");
  precacheturret("cap_turret_cannon_large_un");
  precacheturret("cap_turret_cannon_large_un_zerog");
  func_0BB6::func_12A89();
  level._effect["destroyer_un_warp_pre"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_warp_in_anticipation.vfx");
  level._effect["destroyer_un_warp_in"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_destroyer_warp_in.vfx");
  level._effect["destroyer_un_warp_out"] = loadfx("vfx\iw7\core\vehicle\capship\un\vfx_capship_un_destroyer_warp_out.vfx");
  level._effect["destroyer_death"] = loadfx("vfx\core\vehicles\attachments\core_elements\vfx_veh_mil_air_un_destroyer_periph_death_pieces.vfx");
}

init_location() {
  thread func_0BA9::func_396E("un");
  scripts\sp\vehicle::playgestureviewmodel();
  func_0BB8::func_7562("thrust_vert", "fx_thruster_v_s", "un_thruster_down_sml", self.func_5020);
  func_0BB8::func_7562("thrust_vert", "fx_thruster_v_m", "un_thruster_down_med", self.func_5020);
  func_0BB8::func_7562("thrust_vert", "fx_thruster_v_l", "un_thruster_down_lrg", self.func_5020);
  func_0BB8::func_7562("thrust_rear", "fx_engine_s", "un_thruster_rear_sml", self.func_501F);
  func_0BB8::func_7562("thrust_rear", "fx_engine_m", "un_thruster_rear_med", self.func_501F);
  func_0BB8::func_7562("thrust_rear", "fx_engine_l", "un_thruster_rear_lrg", self.func_501F);
  self.func_539B = ["veh_mil_air_un_destroyer_engines", "veh_mil_air_un_destroyer_details"];
  self.func_24C4 = ["tag_origin", "amb_turret_m_2", "amb_missile_l_1", "amb_turret_l_1", "amb_missile_r_4", "fx_engine_l_2", "fx_thruster_v_l_1", "fx_light_main_a_1"];

  if(issubstr(self.classname, "cheap")) {
    return;
  }
  thread func_1EDC();
  self.func_7482 = "destroyer_un_warp";
  self.func_748F = "vfx_ftl_ca_destroyer";
  self.func_4E09 = "destroyer_death";
}

#using_animtree("vehicles");

func_1EDC() {
  level.func_EC87["ftl_model"] = #animtree;
  level.func_EC8C["ftl_model"] = "vfx_ftl_ca_destroyer";
  level.func_EC85["ftl_model"]["ftl_in"] = % vfx_ftl_ca_destroyer_in;
  level.func_EC85["ftl_model"]["ftl_out"] = % vfx_ftl_ca_destroyer_out;
}