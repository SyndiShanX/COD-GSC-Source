/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2999.gsc
**************************************/

func_F8F9() {
  self.type = "cap_turret_cannon_large_un";
  self.var_12AE6 = "cap_turret_cannon_large_un_zerog";
  self.model = "ship_exterior_un_cannon_b_rig";
  self.tag = ["amb_turret_l", "amb_turret_m", "amb_turret_r"];
  self.team = "allies";
  self.var_B8F9 = "manual";
  self.var_2103 = 150;
  self.var_2107 = 150;
  self.var_2109 = 80;
  self.var_2100 = 10;
  self.var_2106 = [];
  self.var_45E4 = 0.75;
  self.var_45E3 = 0.75;
  self.var_10241 = spawnStruct();
  self.var_10241.health = 5000;
  self.var_10241.var_6D20 = 3;
  self.var_10241.var_13536 = [1, 1.1];
  self.var_10241.var_13535 = [8, 12];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.var_6CF8 = func_0BB6::func_6D4D;
  self.var_10241.var_6D32 = "capitalship_megacannon_fire";
  self.var_DCCA = 25000;
  self.var_10AA2 = 600;
  var_0 = 1;
  var_1 = 1;
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_B428 = 500 * int(var_1);
  self.var_4D1E.var_B73D = 250 * int(var_1);
  self.var_4D1E.var_B465 = 1 * int(var_1);
  self.var_4D1E.var_B753 = 1 * int(var_1);
  self.var_4D1E.var_1060D = 50;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_un_turret_sml_cheap";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_lg";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_lg";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_lg";
  self.var_4D1E.fx.death = "capital_turret_death_lg";
  self.var_4D1E.fx.var_A865 = "capital_turret_laser_lg";
  self.var_4D1E.fx.var_6D02 = "capital_turret_fire_laser_lg";
  self.var_3AF3 = "large_target";
  self.var_11549 = "JACKAL_76MM_DSM";
}

func_F8F8() {
  self.type = "cap_turret_cannon_large_ca";
  self.var_12AE6 = "cap_turret_cannon_large_ca_zerog";
  self.model = "ship_exterior_ca_cannon_a_rig";
  self.tag = ["amb_turret_l", "amb_turret_m", "amb_turret_r"];
  self.team = "axis";
  self.var_B8F9 = "manual";
  self.var_2103 = 150;
  self.var_2107 = 150;
  self.var_2109 = 80;
  self.var_2100 = 15;
  self.var_2106 = [];
  self.var_45E4 = 0.4;
  self.var_45E3 = 0.4;
  self.var_10241 = spawnStruct();
  self.var_10241.health = 2500;
  self.var_10241.var_6D20 = 3;
  self.var_10241.var_13536 = [1, 1.1];
  self.var_10241.var_13535 = [4, 10];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.var_6CF8 = func_0BB6::func_6D4D;
  self.var_10241.var_6D32 = "capitalship_megacannon_fire";
  self.var_DCCA = 25000;
  self.var_10AA2 = 600;
  var_0 = 1;
  var_1 = 1;
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_B428 = 500 * int(var_1);
  self.var_4D1E.var_B73D = 250 * int(var_1);
  self.var_4D1E.var_B465 = 1 * int(var_1);
  self.var_4D1E.var_B753 = 1 * int(var_1);
  self.var_4D1E.var_1060D = 50;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_lg";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_lg";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_lg";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_lg";
  self.var_4D1E.fx.death = "capital_turret_death_lg";
  self.var_4D1E.fx.var_A865 = "capital_turret_laser_lg";
  self.var_4D1E.fx.var_6D02 = "capital_turret_fire_laser_lg";
  self.var_3AF3 = "large_target";
  self.var_11549 = "JACKAL_76MM_DSM";
}

func_F8F7(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 == "allies") {
    self.model = "ship_exterior_un_cannon_b_rig";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_un_cannon_b_rig";
    self.team = "axis";
  }

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  if(!isDefined(var_2) || int(var_2) < 0) {
    var_2 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_cannon_large_ca";
  self.var_12AE6 = "cap_turret_cannon_large_ca_zerog_noexp";
  self.tag = ["amb_turret_lrg_m", "amb_turret_lrg_m_b"];
  self.var_2103 = 180;
  self.var_2107 = 180;
  self.var_2109 = 90;
  self.var_2100 = 15;
  self.var_2106 = [];
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_B428 = 500 * int(var_2);
  self.var_4D1E.var_B73D = 250 * int(var_2);
  self.var_4D1E.var_B465 = 1 * int(var_2);
  self.var_4D1E.var_B753 = 1 * int(var_2);
  self.var_4D1E.var_1060D = 50;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_lg";
  self.var_4D1E.fx.var_11A7B = "capital_turret_trace_lg";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_lg";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_lg";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_lg";
  self.var_4D1E.fx.death = "capital_turret_death_lg";
  self.var_4D1E.fx.var_A865 = "capital_turret_laser_lg";
  self.var_4D1E.fx.var_6D02 = "capital_turret_fire_laser_lg";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 3;
  self.var_10241.var_13536 = [1, 1.5];
  self.var_10241.var_13535 = [1, 3];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.health = 2500 * int(var_1);
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;

  if(isDefined(var_0) && var_0 == "allies") {
    self.var_10241.var_6D32 = "capitalship_megacannon_fire";
  } else {
    self.var_10241.var_6D32 = "capitalship_megacannon_fire";
  }

  self.var_3AF3 = "large_target";
  self.var_11549 = "JACKAL_76MM_DSM";
}

func_F8FE(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && var_0 == "allies") {
    self.model = "ship_exterior_un_turret_b_rig";
    self.team = "allies";
  } else {
    self.model = "sdf_ship_exterior_un_turret_b_rig";
    self.team = "axis";
  }

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  if(!isDefined(var_2) || int(var_2) < 0) {
    var_2 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_small_constant";
  self.var_12AE6 = "cap_turret_small_constant";
  self.var_6D1D = "cap_turret_proj_small_constant";
  self.tag = ["amb_turret_sml_m", "amb_turret_sml_t_l", "amb_turret_sml_t_r", "amb_turret_ts_l", "amb_turret_ts_r"];
  self.var_2103 = 75;
  self.var_2107 = 75;
  self.var_2109 = 90;
  self.var_2100 = 5;
  self.var_2106 = [];
  self.var_45E4 = 1;
  self.var_45E3 = 1;
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_B465 = 1 * int(var_2);
  self.var_4D1E.var_B753 = 1 * int(var_2);
  self.var_4D1E.var_1060D = 1;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_sml_cheap";
  self.var_4D1E.fx.var_11A7B = "capital_turret_sml_cheap";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_sm";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_sm";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_sm";
  self.var_4D1E.fx.death = "capital_turret_death_sm";
  self.var_934D = "turret";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 0.16;
  self.var_10241.var_13536 = [2, 2.5];
  self.var_10241.var_13535 = [2, 3.5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.health = 2500 * int(var_1);
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;
  self.var_10241.var_6CF8 = func_0BB6::func_6D4F;

  if(isDefined(var_0) && var_0 == "allies") {
    self.var_10241.var_6CF8 = func_0BB6::func_6D4D;
  }

  self.var_10241.var_6D34 = "capship_phalanx_fire_lp";
  self.var_10241.var_6D36 = "capship_phalanx_fire_stop";
  self.var_10241.var_6D35 = "capship_phalanx_fire_lp_plr";
  self.var_10241.var_6D37 = "capship_phalanx_fire_stop_plr";
  self.var_1D52 = 4;
  self.var_3AF3 = "large_target";

  if(isDefined(var_3) && var_3.classname == "script_vehicle_capitalship_missileboat_ca") {
    self.model = "sdf_ship_exterior_un_turret_b_rig_s0p75";
    self.var_4D1E.fx.var_1037F = "capital_turret_smolder_sm_mb";
    self.var_4D1E.fx.death = "capital_turret_death_sm_mb";
    self.var_3AF3 = "small_target";
    self.var_10241.health = 1500 * int(var_1);
  }

  self.var_11549 = "JACKAL_30MM_GRUNION";
}

func_F8FF(var_0, var_1, var_2, var_3) {
  func_F8FE(var_0, var_1, var_2, var_3);
  self.var_4D1E.fx.var_BDFF = "capital_turret_sml_mons_cheap";
  self.var_10241.var_6CF8 = func_0BB6::func_6D4D;
  self.tag = ["amb_turret_sml_l", "amb_turret_sml_r", "amb_turret_l", "amb_turret_r"];
}

func_F8F6(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 == "allies") {
    self.model = "ship_exterior_ca_cannon_a_rig";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_ca_cannon_a_rig";
    self.team = "axis";
  }

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  if(!isDefined(var_2) || int(var_2) < 0) {
    var_2 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_med_flak";
  self.var_12AE6 = "cap_turret_med_flak";
  self.var_6D1D = "cap_turret_proj_med_flak";
  self.tag = ["amb_turret_l", "amb_turret_r"];
  self.var_2103 = 90;
  self.var_2107 = 90;
  self.var_2109 = 75;
  self.var_2100 = 2;
  self.var_2106 = [];
  self.var_45E4 = 1;
  self.var_45E3 = 1;
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_DCCC = 15000;
  self.var_4D1E.var_DCCB = 2000;
  self.var_4D1E.var_B428 = 0 * int(var_2);
  self.var_4D1E.var_B73D = 0 * int(var_2);
  self.var_4D1E.var_B465 = self.var_4D1E.var_B428;
  self.var_4D1E.var_B753 = self.var_4D1E.var_B73D;
  self.var_4D1E.var_1060D = 500;
  self.var_4D1E.var_32B9 = 500;
  self.var_4D1E.var_32B2 = self.var_4D1E.var_B428;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_flak_cheap";
  self.var_4D1E.fx.var_11A7B = "capital_turret_flak_cheap";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_md";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_md";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_md";
  self.var_4D1E.fx.death = "capital_turret_death_md";
  self.var_4D1E.fx.var_69DA = "capital_turret_explosion_md";
  self.var_934D = "turret";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 3;
  self.var_10241.var_13536 = [1, 1];
  self.var_10241.var_13535 = [0.5, 2];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.health = 2500 * int(var_1);
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;
  self.var_10241.var_6CF8 = func_0BB6::func_6D4C;
  self.var_10241.var_6D32 = "weap_capital_ship_flak_fire";
  self.var_10241.var_6D33 = "capitalship_cannon_fire_plr";
  self.var_3AF3 = "large_target";
  self.var_11549 = "JACKAL_R28_TASKMASTER";
}

func_F8FD(var_0, var_1, var_2) {
  self.model = "ship_exterior_un_turret_a_rig";
  self.team = var_0;

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  if(!isDefined(var_2) || int(var_2) < 0) {
    var_2 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_phalanx";
  self.var_12AE6 = "cap_turret_phalanx";
  self.tag = ["amb_turret_sml_m"];
  self.var_2103 = 180;
  self.var_2107 = 180;
  self.var_2109 = 80;
  self.var_2100 = 0;
  self.var_2106 = [];
  self.var_45E4 = 1;
  self.var_45E3 = 1;
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_DCCC = 15000;
  self.var_4D1E.var_DCCB = 2000;
  self.var_4D1E.var_B465 = self.var_4D1E.var_B428;
  self.var_4D1E.var_B753 = self.var_4D1E.var_B73D;
  self.var_4D1E.var_1060D = 500;
  self.var_4D1E.var_32B9 = 500;
  self.var_4D1E.var_32B2 = self.var_4D1E.var_B428;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_md";
  self.var_4D1E.fx.var_11A7B = "capital_turret_trace_md";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_md";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_md";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_md";
  self.var_4D1E.fx.death = "capital_turret_death_md";
  self.var_4D1E.fx.var_69DA = "capital_turret_explosion_md";
  self.var_934D = "turret";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 1;
  self.var_10241.var_13536 = [1, 1];
  self.var_10241.var_13535 = [0.05, 0.5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.health = 400 * int(var_1);
  self.var_10241.var_10943 = ::func_CA98;
  self.var_10241.var_102A6 = 1;
  self.var_10241.var_AF57 = ::func_5F1E;
  self.var_10241.var_6CF8 = ::func_5F1E;
  self.var_10241.var_6D32 = "capship_phalanx_fire_lp";
  self.var_10241.var_6D36 = "capship_phalanx_fire_stop";
  self.var_3AF3 = "small_target";
  self.var_11549 = "JACKAL_20MM_OST";
}

func_F8FA(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 == "allies") {
    self.model = "cap_turret_missile_un";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "axis";
  }

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  if(!isDefined(var_2) || int(var_2) < 0) {
    var_2 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_missile_barrage";
  self.var_12AE6 = "cap_turret_missile_barrage";
  self.var_6D1D = "cap_turret_proj_missile_barrage";
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.var_2103 = 0;
  self.var_2107 = 0;
  self.var_2109 = 0;
  self.var_2100 = 0;
  self.var_2106 = [];
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_DCCC = 600;
  self.var_4D1E.var_B428 = 100 * int(var_2);
  self.var_4D1E.var_B73D = 50 * int(var_2);
  self.var_4D1E.var_B465 = 10 * int(var_2);
  self.var_4D1E.var_B753 = 5 * int(var_2);
  self.var_4D1E.var_1060D = 500;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_smt";
  self.var_4D1E.fx.var_BE00 = 256;
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_smt";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_smt";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_smt";
  self.var_4D1E.fx.death = "capital_turret_death_smt";
  self.var_4D1E.fx.var_B036 = "capital_missile_flare_smt";
  self.var_4D1E.fx.var_69DA = "capital_missile_imp_airburst_smt";
  self.var_934D = "missile";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 10;
  self.var_10241.var_6D39 = 0.05;
  self.var_10241.var_13536 = [1, 5];
  self.var_10241.var_13535 = [1, 5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.var_AC75 = 6;
  self.var_10241.health = 1000 * int(var_1);
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;
  self.var_3AF3 = "small_target";
  self.var_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F8FC(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0 == "allies") {
    self.model = "cap_turret_missile_un";
    self.team = "allies";
  } else {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "axis";
  }

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  if(!isDefined(var_2) || int(var_2) < 0) {
    var_2 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_missile_barrage";
  self.var_12AE6 = "cap_turret_missile_barrage";
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.var_2103 = 0;
  self.var_2107 = 0;
  self.var_2109 = 0;
  self.var_2100 = 0;
  self.var_2106 = [];
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 100000;
  self.var_4D1E.var_DCCC = 600;
  self.var_4D1E.var_B428 = 100 * int(var_2);
  self.var_4D1E.var_B73D = 50 * int(var_2);
  self.var_4D1E.var_B465 = 10 * int(var_2);
  self.var_4D1E.var_B753 = 5 * int(var_2);
  self.var_4D1E.var_1060D = 500;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_smt";
  self.var_4D1E.fx.var_BE00 = 256;
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_smt";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_smt";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_smt";
  self.var_4D1E.fx.death = "capital_turret_death_smt";
  self.var_4D1E.fx.var_B036 = "capital_missile_flare_smt";
  self.var_4D1E.fx.var_69DA = "capital_missile_imp_airburst_smt";
  self.var_934D = "missile";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 5;
  self.var_10241.var_6D39 = 0.3;
  self.var_10241.var_13536 = [1, 5];
  self.var_10241.var_13535 = [1, 5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.var_AC75 = 70;
  self.var_10241.health = 2500 * int(var_1);
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;
  self.var_3AF3 = "small_target";
  self.var_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F9D6(var_0, var_1, var_2) {
  self.model = "ship_exterior_missile_pod_a_rig";
  self.team = "allies";
  self.var_B8F9 = "manual";
  self.type = "cap_turret_missile_barrage";
  self.var_12AE6 = "cap_turret_missile_barrage";
  self.var_6D1D = "cap_turret_proj_missile_barrage";
  self.tag = ["amb_missile_r", "amb_missile_l"];
  self.var_2103 = 180;
  self.var_2107 = 180;
  self.var_2109 = 88;
  self.var_2100 = 10;
  self.var_2106 = [];
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 30000;
  self.var_4D1E.var_DCCC = 600;
  self.var_4D1E.var_B428 = 100;
  self.var_4D1E.var_B73D = 50;
  self.var_4D1E.var_B465 = 10;
  self.var_4D1E.var_B753 = 5;
  self.var_4D1E.var_1060D = 500;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_smt";
  self.var_4D1E.fx.var_BE00 = 256;
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_smt";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_smt";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_smt";
  self.var_4D1E.fx.death = "capital_turret_death_smt";
  self.var_4D1E.fx.var_B036 = "capital_missile_flare_smt";
  self.var_4D1E.fx.var_69DA = "capital_missile_imp_airburst_smt";
  self.var_934D = "missile";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 10;
  self.var_10241.var_6D39 = 0.05;
  self.var_10241.var_13536 = [1, 5];
  self.var_10241.var_13535 = [1, 5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.var_AC75 = 6;
  self.var_10241.health = 1000;
  self.var_10241.var_AF57 = func_0BB6::func_6D0E;
  self.var_3AF3 = "small_target";
  self.var_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F8FB(var_0, var_1, var_2, var_3) {
  self.var_8B3B = 1;
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.team = "allies";
  self.var_B8F9 = "manual";
  self.type = "cap_hardpoint_missile_barrage";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 10;
  self.var_10241.var_6D39 = 0.05;
  self.var_10241.var_13536 = [1, 5];
  self.var_10241.var_13535 = [1, 5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.var_AC75 = 6;
  self.var_10241.health = 1300;
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;
  self.var_10241.var_B46E = 9;
  self.var_10241.var_EF5F = "capitalship_missile_fire";
  self.var_10241.var_EF60 = "capitalship_missile_fire_for_plr";
  self.var_4D1E = spawnStruct();
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_smt";
  self.var_4D1E.fx.death = "capital_turret_death_smt";

  if(isDefined(var_0) && var_0 == "allies") {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "allies";
    self.var_10241.var_6CF8 = func_0BB6::func_6D0C;
  } else {
    self.model = "ship_exterior_ca_turret_missile_b";
    self.team = "axis";
    self.var_10241.var_6CF8 = func_0BB6::func_6D0C;
  }

  self.var_3AF3 = "small_target";

  if(isDefined(var_3) && var_3.classname == "script_vehicle_capitalship_missileboat_ca") {
    self.model = "ship_exterior_ca_turret_missile_b_s0p75";
    self.var_10241.health = 1800;
    self.var_10241.var_EF5F = "missileboat_missile_launch";
    self.var_10241.var_EF60 = "missileboat_missile_launch_for_plr";
    self.var_4D1E.fx.var_1037F = "capital_turret_smolder_smt_mb";
    self.var_4D1E.fx.death = "capital_turret_death_smt_mb";
  }

  self.var_11549 = "JACKAL_MMT38_WHIPLASH";
}

func_F9DA(var_0) {
  self.type = "cap_missile_tube_un";
  self.var_8B3B = 1;
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.team = "allies";
  self.var_B8F9 = "manual";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 0.3;
  self.var_10241.var_13535 = [18, 32];
  self.var_10241.var_6CF8 = func_0BB6::func_6D0E;
  self.var_10241.var_B46E = 6;
}

func_F9D8(var_0) {
  self.type = "cap_missile_tube_ca";
  self.var_8B3B = 1;
  self.tag = ["amb_missile_l", "amb_missile_r"];
  self.team = "axis";
  self.var_B8F9 = "manual";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 0.1;
  self.var_10241.var_13535 = [24, 36];
  self.var_10241.var_6CF8 = func_0BB6::func_6D0C;
  self.var_10241.var_B46E = 9;
}

func_F9D9(var_0) {}

func_F9DB(var_0, var_1) {
  self.model = "veh_mil_air_ca_missile_boat_turret";
  self.team = "axis";

  if(!isDefined(var_0) || int(var_0) < 0) {
    var_0 = 1;
  }

  if(!isDefined(var_1) || int(var_1) < 0) {
    var_1 = 1;
  }

  self.var_B8F9 = "manual";
  self.type = "cap_turret_small_constant";
  self.var_12AE6 = "cap_turret_small_constant";
  self.tag = ["amb_turret_sml_m", "amb_turret_sml_t_l", "amb_turret_sml_t_r"];
  self.var_2103 = 180;
  self.var_2107 = 180;
  self.var_2109 = 90;
  self.var_2100 = 5;
  self.var_2106 = [];
  self.var_45E4 = 1;
  self.var_4D1E = spawnStruct();
  self.var_4D1E.var_DCCA = 15000;
  self.var_4D1E.var_10AA2 = 600;
  self.var_4D1E.var_B428 = 10 * int(var_1);
  self.var_4D1E.var_B73D = 5 * int(var_1);
  self.var_4D1E.var_B465 = 1 * int(var_1);
  self.var_4D1E.var_B753 = 1 * int(var_1);
  self.var_4D1E.var_1060D = 1;
  self.var_4D1E.fx = spawnStruct();
  self.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_sm";
  self.var_4D1E.fx.var_BE00 = 60;
  self.var_4D1E.fx.var_11A7B = "capital_turret_trace_sm";
  self.var_4D1E.fx.var_1037F = "capital_turret_smolder_sm";
  self.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_sm";
  self.var_4D1E.fx.var_4CDA = "capital_turret_damage2_sm";
  self.var_4D1E.fx.death = "capital_turret_death_sm";
  self.var_10241 = spawnStruct();
  self.var_10241.var_6D20 = 0.1;
  self.var_10241.var_13536 = [0.5, 1.5];
  self.var_10241.var_13535 = [0.25, 0.5];
  self.var_10241.var_1DFC = 1.0;
  self.var_10241.health = 4000 * int(var_0);
  self.var_10241.var_AF57 = func_0BB6::func_6D4D;
  self.var_10241.var_6CF8 = func_0BB6::func_6D4F;
  self.var_1D52 = 4;
  self.var_3AF3 = "none";
  self.var_11549 = "JACKAL_MMT38_WHIPLASH";
}

#using_animtree("vehicles");

func_B878(var_0, var_1, var_2) {
  var_0.script_team = "axis";
  var_0.health = 2000;
  var_0 glinton(#animtree);
  var_0.var_BEED = scripts\engine\utility::spawn_tag_origin();
  var_0.var_BEED linkto(var_0, "tag_origin", (500, 0, 0), (0, 0, 0));
  var_0.var_5978 = spawn("script_model", var_1.origin);
  var_0.var_5978 setModel("veh_mil_air_ca_missile_boat_turret_door");
  var_0.var_5978 linkto(var_1, var_2, (0, 0, 0), (0, 0, 0));
  var_0.var_5978.var_1BE4 = 1;
  var_0.var_5978.state = "open";
  var_0.var_5978 glinton(#animtree);
  var_3 = 1;
  var_0.var_4D1E = spawnStruct();
  var_0.var_4D1E.var_DCCA = 30000;
  var_0.var_4D1E.var_10AA2 = 1;
  var_0.var_4D1E.var_B832 = 50;
  var_0.var_4D1E.var_B428 = 10 * int(var_3);
  var_0.var_4D1E.var_B73D = 5 * int(var_3);
  var_0.var_4D1E.var_B465 = 1 * int(var_3);
  var_0.var_4D1E.var_B753 = 1 * int(var_3);
  var_0.var_4D1E.var_1060D = 1;
  var_0.var_4D1E.fx = spawnStruct();
  var_0.var_4D1E.fx.var_BDFF = "capital_turret_muzzle_sm";
  var_0.var_4D1E.fx.var_BE00 = 60;
  var_0.var_4D1E.fx.var_11A7B = "capital_turret_trace_sm";
  var_0.var_4D1E.fx.var_1037F = "capital_turret_smoke_trail";
  var_0.var_4D1E.fx.var_4CD9 = "capital_turret_damage1_sm";
  var_0.var_4D1E.fx.var_4CDA = "capital_turret_damage2_sm";
  var_0.var_4D1E.fx.death = "capital_turret_death_md";
  var_0.var_4D1E.fx.var_B036 = "capital_missile_flare_smt";
  var_0.var_4D1E.fx.var_69DA = "capital_missile_imp_airburst_smt";
  var_0.var_934D = "turret";
  var_0.var_2103 = 120;
  var_0.var_2107 = 120;
  var_0.var_2109 = 20;
  var_0.var_2100 = 20;
  var_0.var_2106 = [];
  var_0 setleftarc(120);
  var_0 setrightarc(120);
  var_0 settoparc(20);
  var_0 give_crafted_gascan(20);
  var_0 func_82C9(0.5, "yaw");
  var_0 func_82C9(0.5, "pitch");
  var_4 = "JACKAL_MMT38_WHIPLASH";
  var_5 = "small_target";

  if(scripts\sp\utility::func_B324()) {
    var_0[[level.var_A056.var_11543]]("missileboat_turret", var_4, var_5, "enemy_jackal");
    var_0[[level.var_A056.var_F389]]("tag_lockon", [var_0.var_5978]);
  }
}

func_5F1E(var_0, var_1, var_2, var_3, var_4) {}

func_CA98(var_0) {
  if(isDefined(self.var_CA99)) {
    return;
  }
  self.var_CA99 = 1;
  playFXOnTag(level._effect["phalanx_burst_fire"], self, var_0);

  if(!isDefined(self.var_B04A) && isDefined(self.var_10241.var_6D32)) {
    self.var_B04A = spawn("script_origin", self gettagorigin("TAG_FLASH"));
    self.var_B04A.angles = self gettagangles("TAG_FLASH");
    self.var_B04A linkto(self);
    self.var_B04A playLoopSound(self.var_10241.var_6D32);
  }
}