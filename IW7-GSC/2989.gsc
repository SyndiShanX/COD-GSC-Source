/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2989.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("capital_ship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  _id_0BA9::_id_39B3(var_0, "ca", var_2);
  precachemodel("veh_mil_air_ca_destroyer_rig");
  precachemodel("veh_mil_air_ca_destroyer_details");
  precachemodel("veh_mil_air_ca_destroyer_engines");

  if(issubstr(var_2, "cheap")) {
    precachemodel("veh_mil_air_ca_destroyer_periph");
    precachemodel("ship_exterior_ca_cannon_a_rig");
    precacheturret("cap_turret_cannon_large_ca");
    level._effect["capital_turret_muzzle_lg"] = loadfx("vfx/iw7/core/muzflash/cannon/vfx_mega_cannon_muzflash.vfx");
    level._effect["capital_turret_sml_cheap"] = loadfx("vfx/iw7/core/muzflash/cannon/vfx_turret_small_cheap.vfx");
    level._effect["capital_turret_flak_cheap"] = loadfx("vfx/iw7/core/muzflash/cannon/vfx_flack_cannon_cheap.vfx");
    return;
  }

  precachemodel("veh_mil_air_ca_destroyer_details_scr");
  precachemodel("veh_mil_air_ca_destroyer");
  precachemodel("vfx_ftl_ca_destroyer");
  precacheturret("cap_turret_cannon_large_ca");
  precacheturret("cap_turret_cannon_large_ca_zerog");
  level._effect["destroyer_ca_warp_pre"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_warp_in_anticipation.vfx");
  level._effect["destroyer_ca_warp_in"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_warp_in.vfx");
  level._effect["destroyer_ca_warp_out"] = loadfx("vfx/iw7/core/vehicle/capship/ca/vfx_capship_ca_destroyer_warp_out.vfx");
  level._effect["destroyer_death"] = loadfx("vfx/iw7/core/expl/vehicle/vfx_destroyer_death_dps.vfx");
  _id_0BB6::_id_12A89();
  _id_317C(var_2);
}

#using_animtree("vehicles");

_id_317C(var_0) {
  if(!isDefined(level._id_3979)) {
    level._id_3979 = [];
  }

  level._effect["capship_death_linger_sparks_bg"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_sparks_bg.vfx");
  level._effect["capship_death_linger_sparks_md"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_sparks_md.vfx");
  level._effect["capship_death_linger_sparks_sm"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_sparks_sm.vfx");
  level._effect["capship_death_linger_steam_bg"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_steam_bg.vfx");
  level._effect["capship_death_linger_steam_md"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_steam_md.vfx");
  level._effect["capship_death_linger_steam_sm"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_steam_sm.vfx");
  level._effect["capship_death_linger_debris_bg"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_debris_bg.vfx");
  level._effect["capship_death_linger_debris_md"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_debris_md.vfx");
  level._effect["capship_death_linger_debris_sm"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_debris_sm.vfx");
  level._effect["capship_death_linger_explo_bg"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_explo_bg.vfx");
  level._effect["capship_death_linger_explo_md"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_explo_md.vfx");
  level._effect["capship_death_linger_explo_sm"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_explo_sm.vfx");
  level._effect["capship_death_linger_fire_bg"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_fire_bg.vfx");
  level._effect["capship_death_linger_fire_md"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_fire_md.vfx");
  level._effect["capship_death_linger_fire_sm"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_fire_sm.vfx");
  level._effect["capship_death_linger_meteor_bg"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_meteor_bg.vfx");
  level._effect["capship_death_linger_meteor_md"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_meteor_md.vfx");
  level._effect["capship_death_linger_meteor_sm"] = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_damage_meteor_sm.vfx");
  var_1 = spawnStruct();
  var_1._id_E505 = "ph_mil_air_ca_destroyer_space_explosion_rig";
  var_1._id_CB56 = "veh_mil_air_ca_destroyer_dst_piece_big_";
  var_1._id_C1FB = 40;
  var_1._id_1FAF = % ph_mil_air_ca_destroyer_space_explosion;
  var_1._id_7570 = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_death_debris.vfx");

  if(getdvarint("e3", 0)) {
    var_1._id_7571 = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_death_debris_e3.vfx");
  }

  var_1._id_7582 = loadfx("vfx/iw7/core/vehicle/capship/ca/destroyer/vfx_ca_destroyer_death_explosion.vfx");
  var_1._id_FB8C = "capital_ship_explo";
  var_1._id_7586["tag_fx_sparks_bg"] = "capship_death_linger_sparks_bg";
  var_1._id_7586["tag_fx_sparks_md"] = "capship_death_linger_sparks_md";
  var_1._id_7586["tag_fx_sparks_sm"] = "capship_death_linger_sparks_sm";
  var_1._id_7586["tag_fx_steam_bg"] = "capship_death_linger_steam_bg";
  var_1._id_7586["tag_fx_steam_md"] = "capship_death_linger_steam_md";
  var_1._id_7586["tag_fx_steam_sm"] = "capship_death_linger_steam_sm";
  var_1._id_7586["tag_fx_debris_bg"] = "capship_death_linger_debris_bg";
  var_1._id_7586["tag_fx_debris_md"] = "capship_death_linger_debris_md";
  var_1._id_7586["tag_fx_debris_sm"] = "capship_death_linger_debris_sm";
  var_1._id_7586["tag_fx_explo_bg"] = "capship_death_linger_explo_bg";
  var_1._id_7586["tag_fx_explo_md"] = "capship_death_linger_explo_md";
  var_1._id_7586["tag_fx_explo_sm"] = "capship_death_linger_explo_sm";
  var_1._id_7586["tag_fx_fire_bg"] = "capship_death_linger_fire_bg";
  var_1._id_7586["tag_fx_fire_md"] = "capship_death_linger_fire_md";
  var_1._id_7586["tag_fx_fire_sm"] = "capship_death_linger_fire_sm";
  var_1._id_7586["tag_fx_meteor_bg"] = "capship_death_linger_meteor_bg";
  var_1._id_7586["tag_fx_meteor_md"] = "capship_death_linger_meteor_md";
  var_1._id_7586["tag_fx_meteor_sm"] = "capship_death_linger_meteor_sm";
  var_1 _id_0BA9::_id_48AF(var_0);
}

init_location() {
  thread _id_0BA9::_id_396E("ca");
  scripts\sp\vehicle::_id_8441();
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_s", "ca_thruster_down_sml", self._id_5020);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_m", "ca_thruster_down_med", self._id_5020);
  _id_0BB8::_id_7562("thrust_vert", "fx_thruster_v_l", "ca_thruster_down_lrg", self._id_5020);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_s", "ca_thruster_rear_sml", self._id_501F);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_m", "ca_thruster_rear_med", self._id_501F);
  _id_0BB8::_id_7562("thrust_rear", "fx_engine_l", "ca_thruster_rear_lrg", self._id_501F);
  self._id_129C4 = _id_129C4();
  self._id_12A08 = _id_12A08();
  self._id_539B = ["veh_mil_air_ca_destroyer_engines", "veh_mil_air_ca_destroyer_details", "veh_mil_air_ca_destroyer_details_scr"];

  if(issubstr(self.classname, "cheap")) {
    return;
  }
  thread _id_1EDC();
  self._id_24C4 = ["tag_origin", "amb_special_m_1", "amb_turret_sml_r_ts_5", "amb_turret_sml_m_2", "amb_turret_sml_l_ts_2", "amb_turret_sml_m_4", "amb_turret_sml_l_b_3", "amb_turret_l_3"];
  self._id_7482 = "destroyer_ca_warp";
  self._id_748F = "vfx_ftl_ca_destroyer";
  self._id_7475 = 0.55;
  self._id_4E09 = "destroyer_death";
}

_id_129C4() {
  var_0 = [];
  var_0["amb_turret_r_1"] = [135, 135, 88, 15];
  var_0["amb_turret_l_1"] = [135, 135, 88, 15];
  var_0["amb_turret_r_2"] = [135, 135, 88, 15];
  var_0["amb_turret_l_2"] = [135, 135, 88, 15];
  var_0["amb_turret_r_3"] = [90, 160, 88, 15];
  var_0["amb_turret_l_3"] = [160, 90, 88, 15];
  var_0["amb_turret_sml_r_ts_1"] = [135, 90, 88, -25];
  var_0["amb_turret_sml_l_ts_1"] = [90, 135, 88, -25];
  var_0["amb_turret_sml_r_ts_5"] = [180, 180, 88, -25];
  var_0["amb_turret_sml_l_ts_5"] = [180, 180, 88, -25];
  return var_0;
}

_id_12A08() {
  var_0 = [];
  var_0["amb_turret_r_1"] = (0, -90, 0);
  var_0["amb_turret_l_1"] = (0, 90, 0);
  var_0["amb_turret_r_2"] = (0, -90, 0);
  var_0["amb_turret_l_2"] = (0, 90, 0);
  var_0["amb_turret_r_3"] = (0, 90, 0);
  var_0["amb_turret_l_3"] = (0, -90, 0);
  return var_0;
}

_id_1EDC() {
  level._id_EC87["ftl_model"] = #animtree;
  level._id_EC8C["ftl_model"] = "vfx_ftl_ca_destroyer";
  level._id_EC85["ftl_model"]["ftl_in"] = % vfx_ftl_ca_destroyer_in;
  level._id_EC85["ftl_model"]["ftl_out"] = % vfx_ftl_ca_destroyer_out;
}

_id_F030(var_0, var_1, var_2) {
  while(isDefined(self._id_74A6)) {
    wait 0.05;
  }

  if(!isDefined(level._id_F033)) {
    level._id_F033 = [];
  }

  if(!isDefined(level._id_F02D)) {
    level._id_F02D = [];
  }

  level._id_F033 = scripts\engine\utility::array_add(level._id_F033, self);
  level._id_F02D = scripts\engine\utility::array_add(level._id_F02D, self);
  self._id_3775 = 0;
  self._id_1153F = 0;
  self._id_56EA = 9999999;
  self._id_5ABB = -1;
  self._id_12FF3 = 1;
  self._id_10250 = 1;
  self._id_D436 = 0;

  if(scripts\sp\utility::_id_B324()) {
    self[[level._id_A056._id_11543]]("capitalship", "JACKAL_SDF_DESTROYER", "none", "none", 0, 1, 1);
  }

  self.team = "axis";
  _id_0BB6::_id_39E1();

  if(isDefined(var_2)) {
    self._id_EEF9 = var_2;
  } else {
    self._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,3,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,3,1 cannon_phalanx";
  }

  _id_0BB6::_id_39E8();
  self solid();
  self setCanDamage(1);

  if(scripts\engine\utility::is_true(var_0)) {
    thread _id_0BA9::_id_39C9();
  }

  _id_0BB8::_id_39CE("high");
  thread _id_0BB8::_id_39D0("idle");
  thread _id_0BB8::_id_39CD("idle");
  _id_0BB8::_id_397F(1, 1);
  thread _id_0BB6::_id_39EF();
  var_3 = 200;
  var_4 = 17500;
  var_5 = 0.35;
  var_6 = 0.75;
  var_7 = 13000;
  var_8 = 3000;
  var_9 = 1000;
  _id_0BA9::_id_39D6(var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  thread _id_52FB();
  _id_0BA9::_id_52FD();

  if(!isDefined(var_1) || !var_1) {
    self._id_12FBA = 1;
  }

  thread _id_0BA9::_id_396F(var_1);
}

_id_52FB() {
  level.player endon("death");
  self endon("death");
  self endon("entitydeleted");
  self endon("delete_cleanup");
  var_0 = _id_52FA();
  var_1 = _id_52F9();
  var_2 = 8;
  var_3 = 1;
  var_4 = var_0 * var_2 + var_1 * var_3;
  var_5 = 0.3;

  for(;;) {
    var_6 = _id_52FA() * var_2 + _id_52F9() * var_3;

    if(var_6 / var_4 <= var_5) {
      break;
    }

    wait 0.25;
  }

  self _meth_81D0();
}

_id_52FA() {
  var_0 = 0;

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_med_flak"])) {
    var_0 = scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_med_flak"]).size;
  }

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_phalanx"])) {
    var_0 = var_0 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_phalanx"]).size;
  }

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_small_constant"])) {
    var_0 = var_0 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_small_constant"]).size;
  }

  return var_0;
}

_id_52F9() {
  var_0 = 0;

  if(isDefined(self._id_8B4F) && isDefined(self._id_8B4F["cap_hardpoint_missile_barrage"])) {
    var_0 = scripts\engine\utility::array_removeundefined(self._id_8B4F["cap_hardpoint_missile_barrage"]).size;
  }

  return var_0;
}