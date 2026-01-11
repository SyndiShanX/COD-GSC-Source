/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2989.gsc
***************************************/

main(var_00, var_01, var_02) {
  scripts\sp\vehicle_build::func_31C5("capital_ship", var_00, var_01, var_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  func_0BA9::func_39B3(var_00, "ca", var_02);
  precachemodel("veh_mil_air_ca_destroyer_rig");
  precachemodel("veh_mil_air_ca_destroyer_details");
  precachemodel("veh_mil_air_ca_destroyer_engines");

  if(issubstr(var_02, "cheap")) {
    precachemodel("veh_mil_air_ca_destroyer_periph");
    precachemodel("ship_exterior_ca_cannon_a_rig");
    precacheturret("cap_turret_cannon_large_ca");
    level._effect["capital_turret_muzzle_lg"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_mega_cannon_muzflash.vfx");
    level._effect["capital_turret_sml_cheap"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_turret_small_cheap.vfx");
    level._effect["capital_turret_flak_cheap"] = loadfx("vfx\iw7\core\muzflash\cannon\vfx_flack_cannon_cheap.vfx");
    return;
  }

  precachemodel("veh_mil_air_ca_destroyer_details_scr");
  precachemodel("veh_mil_air_ca_destroyer");
  precachemodel("vfx_ftl_ca_destroyer");
  precacheturret("cap_turret_cannon_large_ca");
  precacheturret("cap_turret_cannon_large_ca_zerog");
  level._effect["destroyer_ca_warp_pre"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_warp_in_anticipation.vfx");
  level._effect["destroyer_ca_warp_in"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_warp_in.vfx");
  level._effect["destroyer_ca_warp_out"] = loadfx("vfx\iw7\core\vehicle\capship\ca\vfx_capship_ca_destroyer_warp_out.vfx");
  level._effect["destroyer_death"] = loadfx("vfx\iw7\core\expl\vehicle\vfx_destroyer_death_dps.vfx");
  func_0BB6::func_12A89();
  func_317C(var_02);
}

#using_animtree("vehicles");

func_317C(var_00) {
  if(!isDefined(level.func_3979)) {
    level.func_3979 = [];
  }

  level._effect["capship_death_linger_sparks_bg"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_sparks_bg.vfx");
  level._effect["capship_death_linger_sparks_md"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_sparks_md.vfx");
  level._effect["capship_death_linger_sparks_sm"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_sparks_sm.vfx");
  level._effect["capship_death_linger_steam_bg"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_steam_bg.vfx");
  level._effect["capship_death_linger_steam_md"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_steam_md.vfx");
  level._effect["capship_death_linger_steam_sm"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_steam_sm.vfx");
  level._effect["capship_death_linger_debris_bg"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_debris_bg.vfx");
  level._effect["capship_death_linger_debris_md"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_debris_md.vfx");
  level._effect["capship_death_linger_debris_sm"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_debris_sm.vfx");
  level._effect["capship_death_linger_explo_bg"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_explo_bg.vfx");
  level._effect["capship_death_linger_explo_md"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_explo_md.vfx");
  level._effect["capship_death_linger_explo_sm"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_explo_sm.vfx");
  level._effect["capship_death_linger_fire_bg"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_fire_bg.vfx");
  level._effect["capship_death_linger_fire_md"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_fire_md.vfx");
  level._effect["capship_death_linger_fire_sm"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_fire_sm.vfx");
  level._effect["capship_death_linger_meteor_bg"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_meteor_bg.vfx");
  level._effect["capship_death_linger_meteor_md"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_meteor_md.vfx");
  level._effect["capship_death_linger_meteor_sm"] = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_damage_meteor_sm.vfx");
  var_01 = spawnStruct();
  var_1.func_E505 = "ph_mil_air_ca_destroyer_space_explosion_rig";
  var_1.func_CB56 = "veh_mil_air_ca_destroyer_dst_piece_big_";
  var_1.func_C1FB = 40;
  var_1.func_1FAF = % ph_mil_air_ca_destroyer_space_explosion;
  var_1.func_7570 = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_death_debris.vfx");

  if(getdvarint("e3", 0)) {
    var_1.func_7571 = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_death_debris_e3.vfx");
  }

  var_1.func_7582 = loadfx("vfx\iw7\core\vehicle\capship\ca\destroyer\vfx_ca_destroyer_death_explosion.vfx");
  var_1.func_FB8C = "capital_ship_explo";
  var_1.func_7586["tag_fx_sparks_bg"] = "capship_death_linger_sparks_bg";
  var_1.func_7586["tag_fx_sparks_md"] = "capship_death_linger_sparks_md";
  var_1.func_7586["tag_fx_sparks_sm"] = "capship_death_linger_sparks_sm";
  var_1.func_7586["tag_fx_steam_bg"] = "capship_death_linger_steam_bg";
  var_1.func_7586["tag_fx_steam_md"] = "capship_death_linger_steam_md";
  var_1.func_7586["tag_fx_steam_sm"] = "capship_death_linger_steam_sm";
  var_1.func_7586["tag_fx_debris_bg"] = "capship_death_linger_debris_bg";
  var_1.func_7586["tag_fx_debris_md"] = "capship_death_linger_debris_md";
  var_1.func_7586["tag_fx_debris_sm"] = "capship_death_linger_debris_sm";
  var_1.func_7586["tag_fx_explo_bg"] = "capship_death_linger_explo_bg";
  var_1.func_7586["tag_fx_explo_md"] = "capship_death_linger_explo_md";
  var_1.func_7586["tag_fx_explo_sm"] = "capship_death_linger_explo_sm";
  var_1.func_7586["tag_fx_fire_bg"] = "capship_death_linger_fire_bg";
  var_1.func_7586["tag_fx_fire_md"] = "capship_death_linger_fire_md";
  var_1.func_7586["tag_fx_fire_sm"] = "capship_death_linger_fire_sm";
  var_1.func_7586["tag_fx_meteor_bg"] = "capship_death_linger_meteor_bg";
  var_1.func_7586["tag_fx_meteor_md"] = "capship_death_linger_meteor_md";
  var_1.func_7586["tag_fx_meteor_sm"] = "capship_death_linger_meteor_sm";
  var_01 func_0BA9::func_48AF(var_00);
}

init_location() {
  thread func_0BA9::func_396E("ca");
  scripts\sp\vehicle::playgestureviewmodel();
  func_0BB8::func_7562("thrust_vert", "fx_thruster_v_s", "ca_thruster_down_sml", self.func_5020);
  func_0BB8::func_7562("thrust_vert", "fx_thruster_v_m", "ca_thruster_down_med", self.func_5020);
  func_0BB8::func_7562("thrust_vert", "fx_thruster_v_l", "ca_thruster_down_lrg", self.func_5020);
  func_0BB8::func_7562("thrust_rear", "fx_engine_s", "ca_thruster_rear_sml", self.func_501F);
  func_0BB8::func_7562("thrust_rear", "fx_engine_m", "ca_thruster_rear_med", self.func_501F);
  func_0BB8::func_7562("thrust_rear", "fx_engine_l", "ca_thruster_rear_lrg", self.func_501F);
  self.func_129C4 = func_129C4();
  self.func_12A08 = func_12A08();
  self.func_539B = ["veh_mil_air_ca_destroyer_engines", "veh_mil_air_ca_destroyer_details", "veh_mil_air_ca_destroyer_details_scr"];

  if(issubstr(self.classname, "cheap")) {
    return;
  }
  thread func_1EDC();
  self.func_24C4 = ["tag_origin", "amb_special_m_1", "amb_turret_sml_r_ts_5", "amb_turret_sml_m_2", "amb_turret_sml_l_ts_2", "amb_turret_sml_m_4", "amb_turret_sml_l_b_3", "amb_turret_l_3"];
  self.func_7482 = "destroyer_ca_warp";
  self.func_748F = "vfx_ftl_ca_destroyer";
  self.func_7475 = 0.55;
  self.func_4E09 = "destroyer_death";
}

func_129C4() {
  var_00 = [];
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
  return var_00;
}

func_12A08() {
  var_00 = [];
  var_0["amb_turret_r_1"] = (0, -90, 0);
  var_0["amb_turret_l_1"] = (0, 90, 0);
  var_0["amb_turret_r_2"] = (0, -90, 0);
  var_0["amb_turret_l_2"] = (0, 90, 0);
  var_0["amb_turret_r_3"] = (0, 90, 0);
  var_0["amb_turret_l_3"] = (0, -90, 0);
  return var_00;
}

func_1EDC() {
  level.func_EC87["ftl_model"] = #animtree;
  level.func_EC8C["ftl_model"] = "vfx_ftl_ca_destroyer";
  level.func_EC85["ftl_model"]["ftl_in"] = % vfx_ftl_ca_destroyer_in;
  level.func_EC85["ftl_model"]["ftl_out"] = % vfx_ftl_ca_destroyer_out;
}

func_F030(var_00, var_01, var_02) {
  while(isDefined(self.func_74A6)) {
    wait 0.05;
  }

  if(!isDefined(level.func_F033)) {
    level.func_F033 = [];
  }

  if(!isDefined(level.func_F02D)) {
    level.func_F02D = [];
  }

  level.func_F033 = scripts\engine\utility::array_add(level.func_F033, self);
  level.func_F02D = scripts\engine\utility::array_add(level.func_F02D, self);
  self.func_3775 = 0;
  self.func_1153F = 0;
  self.func_56EA = 9999999;
  self.func_5ABB = -1;
  self.func_12FF3 = 1;
  self.func_10250 = 1;
  self.func_D436 = 0;

  if(scripts\sp\utility::func_B324()) {
    self[[level.func_A056.func_11543]]("capitalship", "JACKAL_SDF_DESTROYER", "none", "none", 0, 1, 1);
  }

  self.team = "axis";
  func_0BB6::func_39E1();

  if(isDefined(var_02)) {
    self.func_EEF9 = var_02;
  }
  else {
    self.func_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,3,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,3,1 cannon_phalanx";
  }

  func_0BB6::func_39E8();
  self solid();
  self setCanDamage(1);

  if(scripts\engine\utility::is_true(var_00)) {
    thread func_0BA9::func_39C9();
  }

  func_0BB8::func_39CE("high");
  thread func_0BB8::func_39D0("idle");
  thread func_0BB8::func_39CD("idle");
  func_0BB8::func_397F(1, 1);
  thread func_0BB6::func_39EF();
  var_03 = 200;
  var_04 = 17500;
  var_05 = 0.35;
  var_06 = 0.75;
  var_07 = 13000;
  var_08 = 3000;
  var_09 = 1000;
  func_0BA9::func_39D6(var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  thread func_52FB();
  func_0BA9::func_52FD();

  if(!isDefined(var_01) || !var_01) {
    self.func_12FBA = 1;
  }

  thread func_0BA9::func_396F(var_01);
}

func_52FB() {
  level.player endon("death");
  self endon("death");
  self endon("entitydeleted");
  self endon("delete_cleanup");
  var_00 = func_52FA();
  var_01 = func_52F9();
  var_02 = 8;
  var_03 = 1;
  var_04 = var_00 * var_02 + var_01 * var_03;
  var_05 = 0.3;

  for(;;) {
    var_06 = func_52FA() * var_02 + func_52F9() * var_03;

    if(var_06 / var_04 <= var_05) {
      break;
    }
    wait 0.25;
  }

  self _meth_81D0();
}

func_52FA() {
  var_00 = 0;

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_med_flak"])) {
    var_00 = scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_med_flak"]).size;
  }

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_phalanx"])) {
    var_00 = var_00 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_phalanx"]).size;
  }

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_small_constant"])) {
    var_00 = var_00 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_small_constant"]).size;
  }

  return var_00;
}

func_52F9() {
  var_00 = 0;

  if(isDefined(self.func_8B4F) && isDefined(self.func_8B4F["cap_hardpoint_missile_barrage"])) {
    var_00 = scripts\engine\utility::array_removeundefined(self.func_8B4F["cap_hardpoint_missile_barrage"]).size;
  }

  return var_00;
}