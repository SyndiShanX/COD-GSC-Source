/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2999.gsc
***************************************/

func_F8F9() {
  self.type = "cap_turret_cannon_large_un";
  self.func_12AE6 = "cap_turret_cannon_large_un_zerog";
  self.model = "ship_exterior_un_cannon_b_rig";
  self.tag = ["amb_turret_l", "amb_turret_m", "amb_turret_r"];
  self.team = "allies";
  self.func_B8F9 = "manual";
  self.func_2103 = 150;
  self.func_2107 = 150;
  self.func_2109 = 80;
  self.func_2100 = 10;
  self.func_2106 = [];
  self.func_45E4 = 0.75;
  self.func_45E3 = 0.75;
  self.func_10241 = spawnStruct();
  self.func_10241.health = 5000;
  self.func_10241.func_6D20 = 3;
  self.func_10241.func_13536 = [1, 1.1];
  self.func_10241.func_13535 = [8, 12];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.func_6CF8 = func_0BB6::func_6D4D;
  self.func_10241.func_6D32 = "capitalship_megacannon_fire";
  self.func_DCCA = 25000;
  self.func_10AA2 = 600;
  var_00 = 1;
  var_01 = 1;
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_B428 = 500 * int(var_01);
  self.func_4D1E.func_B73D = 250 * int(var_01);
  self.func_4D1E.func_B465 = 1 * int(var_01);
  self.func_4D1E.func_B753 = 1 * int(var_01);
  self.func_4D1E.func_1060D = 50;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_un_turret_sml_cheap";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_lg";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_lg";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_lg";
  self.func_4D1E.fx.death = "capital_turret_death_lg";
  self.func_4D1E.fx.func_A865 = "capital_turret_laser_lg";
  self.func_4D1E.fx.func_6D02 = "capital_turret_fire_laser_lg";
  self.func_3AF3 = "large_target";
  self.func_11549 = "JACKAL_76MM_DSM";
}

func_F8F8() {
  self.type = "cap_turret_cannon_large_ca";
  self.func_12AE6 = "cap_turret_cannon_large_ca_zerog";
  self.model = "ship_exterior_ca_cannon_a_rig";
  self.tag = ["amb_turret_l", "amb_turret_m", "amb_turret_r"];
  self.team = "axis";
  self.func_B8F9 = "manual";
  self.func_2103 = 150;
  self.func_2107 = 150;
  self.func_2109 = 80;
  self.func_2100 = 15;
  self.func_2106 = [];
  self.func_45E4 = 0.4;
  self.func_45E3 = 0.4;
  self.func_10241 = spawnStruct();
  self.func_10241.health = 2500;
  self.func_10241.func_6D20 = 3;
  self.func_10241.func_13536 = [1, 1.1];
  self.func_10241.func_13535 = [4, 10];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.func_6CF8 = func_0BB6::func_6D4D;
  self.func_10241.func_6D32 = "capitalship_megacannon_fire";
  self.func_DCCA = 25000;
  self.func_10AA2 = 600;
  var_00 = 1;
  var_01 = 1;
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_B428 = 500 * int(var_01);
  self.func_4D1E.func_B73D = 250 * int(var_01);
  self.func_4D1E.func_B465 = 1 * int(var_01);
  self.func_4D1E.func_B753 = 1 * int(var_01);
  self.func_4D1E.func_1060D = 50;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_lg";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_lg";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_lg";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_lg";
  self.func_4D1E.fx.death = "capital_turret_death_lg";
  self.func_4D1E.fx.func_A865 = "capital_turret_laser_lg";
  self.func_4D1E.fx.func_6D02 = "capital_turret_fire_laser_lg";
  self.func_3AF3 = "large_target";
  self.func_11549 = "JACKAL_76MM_DSM";
}

func_F8F7(var_00, var_01, var_02) {
  if(isDefined(var_00) && var_00 == "allies") {
    self.model = "ship_exterior_un_cannon_b_rig";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_un_cannon_b_rig";
    self.team = "axis";
  }

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  if(!isDefined(var_02) || int(var_02) < 0) {
    var_02 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_cannon_large_ca";
  self.func_12AE6 = "cap_turret_cannon_large_ca_zerog_noexp";
  self.tag = ["amb_turret_lrg_m", "amb_turret_lrg_m_b"];
  self.func_2103 = 180;
  self.func_2107 = 180;
  self.func_2109 = 90;
  self.func_2100 = 15;
  self.func_2106 = [];
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_B428 = 500 * int(var_02);
  self.func_4D1E.func_B73D = 250 * int(var_02);
  self.func_4D1E.func_B465 = 1 * int(var_02);
  self.func_4D1E.func_B753 = 1 * int(var_02);
  self.func_4D1E.func_1060D = 50;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_lg";
  self.func_4D1E.fx.func_11A7B = "capital_turret_trace_lg";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_lg";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_lg";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_lg";
  self.func_4D1E.fx.death = "capital_turret_death_lg";
  self.func_4D1E.fx.func_A865 = "capital_turret_laser_lg";
  self.func_4D1E.fx.func_6D02 = "capital_turret_fire_laser_lg";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 3;
  self.func_10241.func_13536 = [1, 1.5];
  self.func_10241.func_13535 = [1, 3];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.health = 2500 * int(var_01);
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;

  if(isDefined(var_00) && var_00 == "allies") {
    self.func_10241.func_6D32 = "capitalship_megacannon_fire";
  } else {
    self.func_10241.func_6D32 = "capitalship_megacannon_fire";
  }

  self.func_3AF3 = "large_target";
  self.func_11549 = "JACKAL_76MM_DSM";
}

func_F8FE(var_00, var_01, var_02, var_03) {
  if(isDefined(var_00) && var_00 == "allies") {
    self.model = "ship_exterior_un_turret_b_rig";
    self.team = "allies";
  } else {
    self.model = "sdf_ship_exterior_un_turret_b_rig";
    self.team = "axis";
  }

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  if(!isDefined(var_02) || int(var_02) < 0) {
    var_02 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_small_constant";
  self.func_12AE6 = "cap_turret_small_constant";
  self.func_6D1D = "cap_turret_proj_small_constant";
  self.tag = ["amb_turret_sml_m", "amb_turret_sml_t_l", "amb_turret_sml_t_r", "amb_turret_ts_l", "amb_turret_ts_r"];
  self.func_2103 = 75;
  self.func_2107 = 75;
  self.func_2109 = 90;
  self.func_2100 = 5;
  self.func_2106 = [];
  self.func_45E4 = 1;
  self.func_45E3 = 1;
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_B465 = 1 * int(var_02);
  self.func_4D1E.func_B753 = 1 * int(var_02);
  self.func_4D1E.func_1060D = 1;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_sml_cheap";
  self.func_4D1E.fx.func_11A7B = "capital_turret_sml_cheap";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_sm";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_sm";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_sm";
  self.func_4D1E.fx.death = "capital_turret_death_sm";
  self.func_934D = "turret";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 0.16;
  self.func_10241.func_13536 = [2, 2.5];
  self.func_10241.func_13535 = [2, 3.5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.health = 2500 * int(var_01);
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;
  self.func_10241.func_6CF8 = func_0BB6::func_6D4F;

  if(isDefined(var_00) && var_00 == "allies") {
    self.func_10241.func_6CF8 = func_0BB6::func_6D4D;
  }

  self.func_10241.func_6D34 = "capship_phalanx_fire_lp";
  self.func_10241.func_6D36 = "capship_phalanx_fire_stop";
  self.func_10241.func_6D35 = "capship_phalanx_fire_lp_plr";
  self.func_10241.func_6D37 = "capship_phalanx_fire_stop_plr";
  self.func_1D52 = 4;
  self.func_3AF3 = "large_target";

  if(isDefined(var_03) && var_3.classname == "script_vehicle_capitalship_missileboat_ca") {
    self.model = "sdf_ship_exterior_un_turret_b_rig_s0p75";
    self.func_4D1E.fx.func_1037F = "capital_turret_smolder_sm_mb";
    self.func_4D1E.fx.death = "capital_turret_death_sm_mb";
    self.func_3AF3 = "small_target";
    self.func_10241.health = 1500 * int(var_01);
  }

  self.func_11549 = "JACKAL_30MM_GRUNION";
}

func_F8FF(var_00, var_01, var_02, var_03) {
  func_F8FE(var_00, var_01, var_02, var_03);
  self.func_4D1E.fx.func_BDFF = "capital_turret_sml_mons_cheap";
  self.func_10241.func_6CF8 = func_0BB6::func_6D4D;
  self.tag = ["amb_turret_sml_l", "amb_turret_sml_r", "amb_turret_l", "amb_turret_r"];
}

func_F8F6(var_00, var_01, var_02) {
  if(isDefined(var_00) && var_00 == "allies") {
    self.model = "ship_exterior_ca_cannon_a_rig";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_ca_cannon_a_rig";
    self.team = "axis";
  }

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  if(!isDefined(var_02) || int(var_02) < 0) {
    var_02 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_med_flak";
  self.func_12AE6 = "cap_turret_med_flak";
  self.func_6D1D = "cap_turret_proj_med_flak";
  self.tag = ["amb_turret_l", "amb_turret_r"];
  self.func_2103 = 90;
  self.func_2107 = 90;
  self.func_2109 = 75;
  self.func_2100 = 2;
  self.func_2106 = [];
  self.func_45E4 = 1;
  self.func_45E3 = 1;
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_DCCC = 15000;
  self.func_4D1E.func_DCCB = 2000;
  self.func_4D1E.func_B428 = 0 * int(var_02);
  self.func_4D1E.func_B73D = 0 * int(var_02);
  self.func_4D1E.func_B465 = self.func_4D1E.func_B428;
  self.func_4D1E.func_B753 = self.func_4D1E.func_B73D;
  self.func_4D1E.func_1060D = 500;
  self.func_4D1E.func_32B9 = 500;
  self.func_4D1E.func_32B2 = self.func_4D1E.func_B428;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_flak_cheap";
  self.func_4D1E.fx.func_11A7B = "capital_turret_flak_cheap";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_md";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_md";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_md";
  self.func_4D1E.fx.death = "capital_turret_death_md";
  self.func_4D1E.fx.func_69DA = "capital_turret_explosion_md";
  self.func_934D = "turret";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 3;
  self.func_10241.func_13536 = [1, 1];
  self.func_10241.func_13535 = [0.5, 2];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.health = 2500 * int(var_01);
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;
  self.func_10241.func_6CF8 = func_0BB6::func_6D4C;
  self.func_10241.func_6D32 = "weap_capital_ship_flak_fire";
  self.func_10241.func_6D33 = "capitalship_cannon_fire_plr";
  self.func_3AF3 = "large_target";
  self.func_11549 = "JACKAL_R28_TASKMASTER";
}

func_F8FD(var_00, var_01, var_02) {
  self.model = "ship_exterior_un_turret_a_rig";
  self.team = var_00;

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  if(!isDefined(var_02) || int(var_02) < 0) {
    var_02 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_phalanx";
  self.func_12AE6 = "cap_turret_phalanx";
  self.tag = ["amb_turret_sml_m"];
  self.func_2103 = 180;
  self.func_2107 = 180;
  self.func_2109 = 80;
  self.func_2100 = 0;
  self.func_2106 = [];
  self.func_45E4 = 1;
  self.func_45E3 = 1;
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_DCCC = 15000;
  self.func_4D1E.func_DCCB = 2000;
  self.func_4D1E.func_B465 = self.func_4D1E.func_B428;
  self.func_4D1E.func_B753 = self.func_4D1E.func_B73D;
  self.func_4D1E.func_1060D = 500;
  self.func_4D1E.func_32B9 = 500;
  self.func_4D1E.func_32B2 = self.func_4D1E.func_B428;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_md";
  self.func_4D1E.fx.func_11A7B = "capital_turret_trace_md";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_md";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_md";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_md";
  self.func_4D1E.fx.death = "capital_turret_death_md";
  self.func_4D1E.fx.func_69DA = "capital_turret_explosion_md";
  self.func_934D = "turret";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 1;
  self.func_10241.func_13536 = [1, 1];
  self.func_10241.func_13535 = [0.05, 0.5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.health = 400 * int(var_01);
  self.func_10241.func_10943 = ::func_CA98;
  self.func_10241.func_102A6 = 1;
  self.func_10241.func_AF57 = ::func_5F1E;
  self.func_10241.func_6CF8 = ::func_5F1E;
  self.func_10241.func_6D32 = "capship_phalanx_fire_lp";
  self.func_10241.func_6D36 = "capship_phalanx_fire_stop";
  self.func_3AF3 = "small_target";
  self.func_11549 = "JACKAL_20MM_OST";
}

func_F8FA(var_00, var_01, var_02) {
  if(isDefined(var_00) && var_00 == "allies") {
    self.model = "cap_turret_missile_un";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "axis";
  }

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  if(!isDefined(var_02) || int(var_02) < 0) {
    var_02 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_missile_barrage";
  self.func_12AE6 = "cap_turret_missile_barrage";
  self.func_6D1D = "cap_turret_proj_missile_barrage";
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.func_2103 = 0;
  self.func_2107 = 0;
  self.func_2109 = 0;
  self.func_2100 = 0;
  self.func_2106 = [];
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_DCCC = 600;
  self.func_4D1E.func_B428 = 100 * int(var_02);
  self.func_4D1E.func_B73D = 50 * int(var_02);
  self.func_4D1E.func_B465 = 10 * int(var_02);
  self.func_4D1E.func_B753 = 5 * int(var_02);
  self.func_4D1E.func_1060D = 500;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_smt";
  self.func_4D1E.fx.func_BE00 = 256;
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_smt";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_smt";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_smt";
  self.func_4D1E.fx.death = "capital_turret_death_smt";
  self.func_4D1E.fx.func_B036 = "capital_missile_flare_smt";
  self.func_4D1E.fx.func_69DA = "capital_missile_imp_airburst_smt";
  self.func_934D = "missile";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 10;
  self.func_10241.func_6D39 = 0.05;
  self.func_10241.func_13536 = [1, 5];
  self.func_10241.func_13535 = [1, 5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.func_AC75 = 6;
  self.func_10241.health = 1000 * int(var_01);
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;
  self.func_3AF3 = "small_target";
  self.func_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F8FC(var_00, var_01, var_02) {
  if(isDefined(var_00) && var_00 == "allies") {
    self.model = "cap_turret_missile_un";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "axis";
  }

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  if(!isDefined(var_02) || int(var_02) < 0) {
    var_02 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_missile_barrage";
  self.func_12AE6 = "cap_turret_missile_barrage";
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.func_2103 = 0;
  self.func_2107 = 0;
  self.func_2109 = 0;
  self.func_2100 = 0;
  self.func_2106 = [];
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 100000;
  self.func_4D1E.func_DCCC = 600;
  self.func_4D1E.func_B428 = 100 * int(var_02);
  self.func_4D1E.func_B73D = 50 * int(var_02);
  self.func_4D1E.func_B465 = 10 * int(var_02);
  self.func_4D1E.func_B753 = 5 * int(var_02);
  self.func_4D1E.func_1060D = 500;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_smt";
  self.func_4D1E.fx.func_BE00 = 256;
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_smt";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_smt";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_smt";
  self.func_4D1E.fx.death = "capital_turret_death_smt";
  self.func_4D1E.fx.func_B036 = "capital_missile_flare_smt";
  self.func_4D1E.fx.func_69DA = "capital_missile_imp_airburst_smt";
  self.func_934D = "missile";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 5;
  self.func_10241.func_6D39 = 0.3;
  self.func_10241.func_13536 = [1, 5];
  self.func_10241.func_13535 = [1, 5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.func_AC75 = 70;
  self.func_10241.health = 2500 * int(var_01);
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;
  self.func_3AF3 = "small_target";
  self.func_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F9D6(var_00, var_01, var_02) {
  self.model = "ship_exterior_missile_pod_a_rig";
  self.team = "allies";
  self.func_B8F9 = "manual";
  self.type = "cap_turret_missile_barrage";
  self.func_12AE6 = "cap_turret_missile_barrage";
  self.func_6D1D = "cap_turret_proj_missile_barrage";
  self.tag = ["amb_missile_r", "amb_missile_l"];
  self.func_2103 = 180;
  self.func_2107 = 180;
  self.func_2109 = 88;
  self.func_2100 = 10;
  self.func_2106 = [];
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 30000;
  self.func_4D1E.func_DCCC = 600;
  self.func_4D1E.func_B428 = 100;
  self.func_4D1E.func_B73D = 50;
  self.func_4D1E.func_B465 = 10;
  self.func_4D1E.func_B753 = 5;
  self.func_4D1E.func_1060D = 500;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_smt";
  self.func_4D1E.fx.func_BE00 = 256;
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_smt";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_smt";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_smt";
  self.func_4D1E.fx.death = "capital_turret_death_smt";
  self.func_4D1E.fx.func_B036 = "capital_missile_flare_smt";
  self.func_4D1E.fx.func_69DA = "capital_missile_imp_airburst_smt";
  self.func_934D = "missile";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 10;
  self.func_10241.func_6D39 = 0.05;
  self.func_10241.func_13536 = [1, 5];
  self.func_10241.func_13535 = [1, 5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.func_AC75 = 6;
  self.func_10241.health = 1000;
  self.func_10241.func_AF57 = func_0BB6::func_6D0E;
  self.func_3AF3 = "small_target";
  self.func_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F8FB(var_00, var_01, var_02, var_03) {
  self.func_8B3B = 1;
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.team = "allies";
  self.func_B8F9 = "manual";
  self.type = "cap_hardpoint_missile_barrage";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 10;
  self.func_10241.func_6D39 = 0.05;
  self.func_10241.func_13536 = [1, 5];
  self.func_10241.func_13535 = [1, 5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.func_AC75 = 6;
  self.func_10241.health = 1300;
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;
  self.func_10241.func_B46E = 9;
  self.func_10241.func_EF5F = "capitalship_missile_fire";
  self.func_10241.func_EF60 = "capitalship_missile_fire_for_plr";
  self.func_4D1E = spawnStruct();
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_smt";
  self.func_4D1E.fx.death = "capital_turret_death_smt";

  if(isDefined(var_00) && var_00 == "allies") {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "allies";
    self.func_10241.func_6CF8 = func_0BB6::func_6D0C;
  } else {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "axis";
    self.func_10241.func_6CF8 = func_0BB6::func_6D0C;
  }

  self.func_3AF3 = "small_target";

  if(isDefined(var_03) && var_3.classname == "script_vehicle_capitalship_missileboat_ca") {
    self.model = "ship_exterior_ca_turret_missile_b_s0p75";
    self.func_10241.health = 1800;
    self.func_10241.func_EF5F = "missileboat_missile_launch";
    self.func_10241.func_EF60 = "missileboat_missile_launch_for_plr";
    self.func_4D1E.fx.func_1037F = "capital_turret_smolder_smt_mb";
    self.func_4D1E.fx.death = "capital_turret_death_smt_mb";
  }

  self.func_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F9DA(var_00) {
  self.type = "cap_missile_tube_un";
  self.func_8B3B = 1;
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.team = "allies";
  self.func_B8F9 = "manual";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 0.3;
  self.func_10241.func_13535 = [18, 32];
  self.func_10241.func_6CF8 = func_0BB6::func_6D0E;
  self.func_10241.func_B46E = 6;
}

func_F9D8(var_00) {
  self.type = "cap_missile_tube_ca";
  self.func_8B3B = 1;
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.team = "axis";
  self.func_B8F9 = "manual";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 0.1;
  self.func_10241.func_13535 = [24, 36];
  self.func_10241.func_6CF8 = func_0BB6::func_6D0C;
  self.func_10241.func_B46E = 9;
}

func_F9D9(var_00) {}

func_F9DB(var_00, var_01) {
  self.model = "veh_mil_air_ca_missile_boat_turret";
  self.team = "axis";

  if(!isDefined(var_00) || int(var_00) < 0) {
    var_00 = 1;
  }

  if(!isDefined(var_01) || int(var_01) < 0) {
    var_01 = 1;
  }

  self.func_B8F9 = "manual";
  self.type = "cap_turret_small_constant";
  self.func_12AE6 = "cap_turret_small_constant";
  self.tag = ["amb_turret_sml_m", "amb_turret_sml_t_l", "amb_turret_sml_t_r"];
  self.func_2103 = 180;
  self.func_2107 = 180;
  self.func_2109 = 90;
  self.func_2100 = 5;
  self.func_2106 = [];
  self.func_45E4 = 1;
  self.func_4D1E = spawnStruct();
  self.func_4D1E.func_DCCA = 15000;
  self.func_4D1E.func_10AA2 = 600;
  self.func_4D1E.func_B428 = 10 * int(var_01);
  self.func_4D1E.func_B73D = 5 * int(var_01);
  self.func_4D1E.func_B465 = 1 * int(var_01);
  self.func_4D1E.func_B753 = 1 * int(var_01);
  self.func_4D1E.func_1060D = 1;
  self.func_4D1E.fx = spawnStruct();
  self.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_sm";
  self.func_4D1E.fx.func_BE00 = 60;
  self.func_4D1E.fx.func_11A7B = "capital_turret_trace_sm";
  self.func_4D1E.fx.func_1037F = "capital_turret_smolder_sm";
  self.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_sm";
  self.func_4D1E.fx.func_4CDA = "capital_turret_damage2_sm";
  self.func_4D1E.fx.death = "capital_turret_death_sm";
  self.func_10241 = spawnStruct();
  self.func_10241.func_6D20 = 0.1;
  self.func_10241.func_13536 = [0.5, 1.5];
  self.func_10241.func_13535 = [0.25, 0.5];
  self.func_10241.func_1DFC = 1.0;
  self.func_10241.health = 4000 * int(var_00);
  self.func_10241.func_AF57 = func_0BB6::func_6D4D;
  self.func_10241.func_6CF8 = func_0BB6::func_6D4F;
  self.func_1D52 = 4;
  self.func_3AF3 = "none";
  self.func_11549 = "JACKAL_MMT38_WHIPLASH";
}

#using_animtree("vehicles");

func_B878(var_00, var_01, var_02) {
  var_0.script_team = "axis";
  var_0.health = 2000;
  var_00 glinton(#animtree);
  var_0.func_BEED = scripts\engine\utility::spawn_tag_origin();
  var_0.func_BEED linkto(var_00, "tag_origin", (500, 0, 0), (0, 0, 0));
  var_0.func_5978 = spawn("script_model", var_1.origin);
  var_0.func_5978 setModel("veh_mil_air_ca_missile_boat_turret_door");
  var_0.func_5978 linkto(var_01, var_02, (0, 0, 0), (0, 0, 0));
  var_0.func_5978.func_1BE4 = 1;
  var_0.func_5978.state = "open";
  var_0.func_5978 glinton(#animtree);
  var_03 = 1;
  var_0.func_4D1E = spawnStruct();
  var_0.func_4D1E.func_DCCA = 30000;
  var_0.func_4D1E.func_10AA2 = 1;
  var_0.func_4D1E.func_B832 = 50;
  var_0.func_4D1E.func_B428 = 10 * int(var_03);
  var_0.func_4D1E.func_B73D = 5 * int(var_03);
  var_0.func_4D1E.func_B465 = 1 * int(var_03);
  var_0.func_4D1E.func_B753 = 1 * int(var_03);
  var_0.func_4D1E.func_1060D = 1;
  var_0.func_4D1E.fx = spawnStruct();
  var_0.func_4D1E.fx.func_BDFF = "capital_turret_muzzle_sm";
  var_0.func_4D1E.fx.func_BE00 = 60;
  var_0.func_4D1E.fx.func_11A7B = "capital_turret_trace_sm";
  var_0.func_4D1E.fx.func_1037F = "capital_turret_smoke_trail";
  var_0.func_4D1E.fx.func_4CD9 = "capital_turret_damage1_sm";
  var_0.func_4D1E.fx.func_4CDA = "capital_turret_damage2_sm";
  var_0.func_4D1E.fx.death = "capital_turret_death_md";
  var_0.func_4D1E.fx.func_B036 = "capital_missile_flare_smt";
  var_0.func_4D1E.fx.func_69DA = "capital_missile_imp_airburst_smt";
  var_0.func_934D = "turret";
  var_0.func_2103 = 120;
  var_0.func_2107 = 120;
  var_0.func_2109 = 20;
  var_0.func_2100 = 20;
  var_0.func_2106 = [];
  var_00 setleftarc(120);
  var_00 setrightarc(120);
  var_00 settoparc(20);
  var_00 give_crafted_gascan(20);
  var_00 _meth_82C9(0.5, "yaw");
  var_00 _meth_82C9(0.5, "pitch");
  var_04 = "JACKAL_MMT38_WHIPLASH";
  var_05 = "small_target";

  if(scripts\sp\utility::func_B324()) {
    var_00[[level.func_A056.func_11543]]("missileboat_turret", var_04, var_05, "enemy_jackal");
    var_00[[level.func_A056.func_F389]]("tag_lockon", [var_0.func_5978]);
  }
}

func_5F1E(var_00, var_01, var_02, var_03, var_04) {}

func_CA98(var_00) {
  if(isDefined(self.func_CA99)) {
    return;
  }
  self.func_CA99 = 1;
  playFXOnTag(level._effect["phalanx_burst_fire"], self, var_00);

  if(!isDefined(self.func_B04A) && isDefined(self.func_10241.func_6D32)) {
    self.func_B04A = spawn("script_origin", self gettagorigin("TAG_FLASH"));
    self.func_B04A.angles = self gettagangles("TAG_FLASH");
    self.func_B04A linkto(self);
    self.func_B04A playLoopSound(self.func_10241.func_6D32);
  }
}