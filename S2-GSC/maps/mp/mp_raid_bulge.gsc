/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_bulge.gsc
*********************************************/

func_00F9() {
  lib_04B5::func_F9();
  lib_041C::func_F9();
  lib_04B4::func_F9();
  maps\mp\_audio_submixes::func_524C();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_bulge_lighting::func_F9();
  maps\mp\mp_raid_bulge_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_bulge");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  level.var_6C5F = "mp_raid_bulge_osp";
  level.var_6C5E = "mp_raid_bulge_osp";
  level.var_3445 = "mp_raid_bulge_drone";
  level.var_343A = "mp_raid_bulge_drone";
  level.var_A853 = "mp_raid_bulge_warbird";
  level.var_A852 = "mp_raid_bulge_warbird";
  level.var_75EE = 7;
  level.overridemaxagents = getdvarint("scr_default_maxagents");
  lib_0503::initscriptedtanktargeting();
  level.tanktargethitfunc = ::func_97DE;
  level.var_A16 = 0;
  level.var_7919 = ::maps\mp\mp_raid_bulge_vo::func_A617;
  level.var_1B45 = ["tank_escort_1"];
  var_00 = lib_0501::func_4647("escort3x_forwardSpeed");
  var_01 = lib_0501::func_4647("escort3x_rollbackSpeed");
  var_02 = lib_0501::func_4648("escort3x_contestable");
  var_03 = lib_0501::func_4648("escort3x_turretActive");
  lib_04FF::func_86DA("escort_tanks", "centerObjectiveName", "tank_escort_2");
  lib_04FF::func_86DA("tank_escort_1", "speed", var_00);
  lib_04FF::func_86DA("tank_escort_2", "speed", var_00);
  lib_04FF::func_86DA("tank_escort_3", "speed", var_00);
  lib_04FF::func_86DA("tank_escort_1", "speedReverse", var_01);
  lib_04FF::func_86DA("tank_escort_2", "speedReverse", var_01);
  lib_04FF::func_86DA("tank_escort_3", "speedReverse", var_01);
  lib_04FF::func_86DA("tank_escort_1", "escort_contestable", var_02);
  lib_04FF::func_86DA("tank_escort_2", "escort_contestable", var_02);
  lib_04FF::func_86DA("tank_escort_3", "escort_contestable", var_02);
  lib_04FF::func_86DA("tank_escort_1", "escort_turretActive", var_03);
  lib_04FF::func_86DA("tank_escort_2", "escort_turretActive", var_03);
  lib_04FF::func_86DA("tank_escort_3", "escort_turretActive", var_03);
  lib_04FF::func_86DA("tank_refuel", "flagDeliverStartSound", "gascan_start");
  lib_04FF::func_86DA("tank_refuel", "flagDeliverStopSound", "gascan_stop");
  lib_04FF::func_86DA("tank_refuel", "flagDeliverStopSoundFade", 0.5);
  lib_04FF::func_86DA("tank_refuel", "flagPickupStartSound", "gascan_fill_can");
  lib_04FF::func_86DA("tank_refuel", "flagPickupStopSound", "gascan_stop");
  lib_04FF::func_86DA("tank_refuel", "flagPickupStopSoundFade", 0.5);
  lib_04FA::func_52FD(3);
  maps\mp\_utility::func_3FA3("raid_objective_a_complete", 0);
  maps\mp\_utility::func_3FA3("raid_objective_b_complete", 0);
  maps\mp\_utility::func_3FA3("raid_objective_c1_complete", 0);
  maps\mp\_utility::func_3FA3("raid_objective_c2_complete", 0);
  maps\mp\_utility::func_3FA3("raid_objective_c3_complete", 0);
  maps\mp\_utility::func_3FA3("raid_objective_c4_complete", 0);
  maps\mp\_utility::func_3FA3("raid_objective_c_complete", 0);
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
  level.var_696E = ["escort_tanks", "tank_escort_1", "tank_escort_2", "tank_escort_3", "tank_refuel", "bridge_escort", "end"];
  level.var_696F = ["escort_tanks", "tank_refuel", "bridge_escort", "end"];
  thread maps\mp\mp_raid_bulge_vo::func_5366();
  thread func_7FC4();
  thread func_7FC0();
  thread maps\mp\mp_raid_bulge_vo::func_7FDF();
  thread func_7F89();
  thread func_7FCF();
  thread func_7F7D();
  thread func_7FB5();
  thread func_7FDB();
  thread func_7FB4();
  level thread func_97E4();
  level thread func_97EA();
  level thread func_7F6C();
}

func_7FC4() {}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_bulge_allies_start_player01", "mp_raids_bulge_allies_start_player02", "mp_raids_bulge_allies_start_player03", "mp_raids_bulge_allies_start_player04", "mp_raids_bulge_allies_start_player05", "mp_raids_bulge_allies_start_player06"];
  var_01 = ["mp_raids_bulge_allies_start_cam01", "mp_raids_bulge_allies_start_cam02", "mp_raids_bulge_allies_start_cam03"];
  var_02 = [::func_0BF8, ::func_0BF9, ::func_0BFA];
  level.var_54D0["allies"].var_8F2 = "defenders";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_allies_start", "script_noteworthy");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 14;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_765B = ::func_54D5;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].var_13B7 = ::func_54D1;
  level.var_54D0["allies"].var_73E6 = ::func_54D4;
}

func_54D7() {
  var_00 = level.var_54D0["allies"].var_116;
  var_01 = level.var_54D0["allies"].var_1D;
  var_02 = spawn("script_model", var_00);
  var_02 setModel("foliage_s2_blg_pine_tree_tall_02_artillery_01_anim");
  var_02 method_8495("mp_raids_bulge_allies_start_tree01", var_00, var_01);
  var_02 thread lib_0502::func_8C21(game["defenders"], 0);
  var_03 = ["ger_crate_ammo_closed_02_snow"];
  var_04 = ["j_prop_1"];
  var_05 = spawn("script_model", var_00);
  var_05 setModel("genericprop_x10");
  var_05 method_8495("mp_raids_bulge_allies_start_props01", var_00, var_01, "prop_rig");
  var_05 thread func_0C05("prop_rig");
  var_06 = [];
  for(var_07 = 0; var_07 < var_03.size; var_07++) {
    var_08 = spawn("script_model", var_00);
    var_08 setModel(var_03[var_07]);
    var_08 linkto(var_05, var_04[var_07], (0, 0, 0), (0, 0, 0));
    var_06[var_06.size] = var_08;
  }

  level.var_BFF = [];
  level.var_BFF = common_scripts\utility::func_F6F(level.var_BFF, var_02);
  level.var_BFF = common_scripts\utility::func_F73(level.var_BFF, var_06);
  level.var_BFF = common_scripts\utility::func_F6F(level.var_BFF, var_05);
  func_08B5(20);
  wait(2.5);
  lib_04F3::func_79CB("allies_intro_artillery_background", (-4363, 4355, 728));
  wait(4);
  lib_04F3::func_79CB("allies_intro_walla", (-3112, 4232, 1003));
}

func_0C05(param_00) {
  self endon("death");
  var_01 = ["j_prop_3", "j_prop_4", "j_prop_5", "j_prop_6", "j_prop_7", "j_prop_8", "j_prop_9", "j_prop_10", "j_prop_3", "j_prop_4"];
  var_02 = 0;
  for(;;) {
    self waittill(param_00, var_03);
    switch (var_03) {
      case "fire_artillery":
        if(var_02 < var_01.size) {
          var_04 = var_01[var_02];
          var_02++;
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_artillery_snow_impact"), self, var_04);
          lib_04F3::func_79CF("allies_intro_mortar", self, var_04);
        } else {
          var_04 = var_02[randomint(var_02.size)];
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_artillery_snow_impact"), self, var_04);
        }
        break;
    }
  }
}

func_54D5() {
  level notify("allies_intro_cleanup");
  func_2A79([20], 1);
  wait 0.05;
  func_08B5(21);
}

func_54D3() {
  thread func_A47A();
  common_scripts\utility::func_F71(level.var_BFF, ::delete);
  level.var_BFF = undefined;
}

func_54D1(param_00, param_01) {
  if(param_00 == 0) {
    thread func_0C00(param_01);
  }
}

func_54D4(param_00) {
  thread maps\mp\mp_raid_bulge_aud::func_54E4();
}

func_0BF8(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 9, 70, 1, 2, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignettealliesplayercameramix(1);
}

func_0BF9(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 40, 3, 3, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignettealliesplayercameramix(2);
}

func_0BFA(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 300, 10, 10, 0);
  var_01 = lib_0505::func_3187(var_01, 6, 900, 1, 2, 0.5);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignettealliesplayercameramix(3);
}

func_0C00(param_00) {
  self endon("death");
  var_01 = 0;
  var_02 = 1;
  for(;;) {
    self waittill(param_00, var_03);
    switch (var_03) {
      case "breath":
        if(var_01 < var_02) {
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_cold_breath_emitter"), self, "j_head");
          var_01++;
        }
        break;
    }
  }
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_bulge_axis_start_player01", "mp_raids_bulge_axis_start_player02", "mp_raids_bulge_axis_start_player03", "mp_raids_bulge_axis_start_player04", "mp_raids_bulge_axis_start_player05", "mp_raids_bulge_axis_start_player06"];
  var_01 = ["mp_raids_bulge_axis_start_cam01", "mp_raids_bulge_axis_start_cam02", "mp_raids_bulge_axis_start_cam03", "mp_raids_bulge_axis_start_cam04", "mp_raids_bulge_axis_start_cam05"];
  var_02 = [::func_147F, ::func_1480, ::func_1481, ::func_1482, ::func_1483];
  level.var_54D0["axis"].var_8F2 = "attackers";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_axis_start", "script_noteworthy");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 25;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].var_92D5 = ::func_54E1;
  level.var_54D0["axis"].var_765B = ::func_54DD;
  level.var_54D0["axis"].var_2381 = ::func_54D9;
  level.var_54D0["axis"].var_6F27 = 1;
  level.var_54D0["axis"].var_73E6 = ::func_54DC;
}

func_54E1() {
  var_00 = level.var_54D0["axis"].var_116;
  var_01 = level.var_54D0["axis"].var_1D;
  var_02 = spawn("script_model", var_00);
  var_02.var_267E = [4, 1, 4, 4, 4, 0];
  var_02 setcostumemodels(var_02.var_267E, "axis");
  var_02 method_8495("mp_raids_bulge_axis_start_commander", var_00, var_01);
  var_02 thread lib_0502::func_8C21(game["attackers"], 0);
  var_03 = ["mp_raids_bulge_axis_start_soldier01", "mp_raids_bulge_axis_start_soldier02", "mp_raids_bulge_axis_start_soldier03", "mp_raids_bulge_axis_start_soldier04", "mp_raids_bulge_axis_start_soldier05", "mp_raids_bulge_axis_start_soldier06", "mp_raids_bulge_axis_start_soldier07", "mp_raids_bulge_axis_start_soldier08", "mp_raids_bulge_axis_start_soldier09", "mp_raids_bulge_axis_start_soldier10"];
  var_04 = [];
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = spawn("script_model", var_00);
    var_06.var_267E = [2, 1, 2, 2, 2, 0];
    var_06 setcostumemodels(var_06.var_267E, "axis");
    var_06 method_8495(var_03[var_05], var_00, var_01);
    var_06 thread lib_0502::func_8C21(game["attackers"], 0);
    var_04[var_04.size] = var_06;
  }

  var_07 = spawn("script_model", var_00);
  var_07 setModel("foliage_s2_blg_pine_tree_tall_02_artillery_01_anim");
  var_07 method_8495("mp_raids_bulge_axis_start_tree01", var_00, var_01);
  var_07 thread lib_0502::func_8C21(game["attackers"], 0);
  var_08 = ["mp_raids_bulge_axis_start_tank01", "mp_raids_bulge_axis_start_tank02", "mp_raids_bulge_axis_start_tank03"];
  var_09 = ["vehicle_ger_tank_king_tiger_mp_snow_02", "vehicle_ger_tank_king_tiger_mp_snow_01", "vehicle_ger_tank_king_tiger_mp_snow_03"];
  var_0A = [];
  var_0B = [];
  for(var_0C = 0; var_0C < var_08.size; var_0C++) {
    var_0D = spawn("script_model", var_00);
    var_0D setModel(var_09[var_0C]);
    var_0D.var_56E8 = 1;
    var_0D method_8495(var_08[var_0C], var_00, var_01);
    lib_0502::func_9FF(var_0D, game["attackers"]);
    var_0D thread lib_0502::func_8C21(game["attackers"], 0);
    var_0A[var_0A.size] = var_0D;
    playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_tiger_tread_snow_viz"), var_0D, "tag_wheel_back_left");
    playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_tiger_tread_snow_viz"), var_0D, "tag_wheel_back_right");
    var_0E = spawn("script_model", var_00);
    var_0E setModel("npc_ger_mg42_tigerii_bucket_mp_snow");
    var_0E thread lib_0502::func_8C21(game["attackers"], 0);
    var_0E linkto(var_0D, "TAG_TURRET_4", (0, 0, 0), (0, 0, 0));
    var_0B[var_0B.size] = var_0E;
  }

  var_0F = ["ger_mortar_static", "ger_mortar_static", "ger_mortar_static", "ger_mortar_static", "ger_mortar_static", "ger_mortar_static", "ger_mortar_crate_01", "ger_mortar_crate_01", "ger_mortar_crate_01", "ger_mortar_crate_01", "ger_mortar_crate_01", "ger_mortar_crate_01", "npc_ger_mortar_round", "npc_ger_mortar_round", "npc_ger_mortar_round", "npc_ger_mortar_round", "npc_ger_mortar_round", "npc_ger_mortar_round"];
  var_10 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4", "j_prop_5", "j_prop_6", "j_prop_7", "j_prop_8", "j_prop_9", "j_prop_10", "j_prop_11", "j_prop_12", "j_prop_13", "j_prop_14", "j_prop_15", "j_prop_16", "j_prop_17", "j_prop_18"];
  var_11 = spawn("script_model", var_00);
  var_11 setModel("genericprop_x30");
  var_11 method_8495("mp_raids_bulge_axis_start_artillery", var_00, var_01, "prop_rig");
  var_11 thread func_1485("prop_rig");
  var_12 = [];
  for(var_13 = 0; var_13 < var_0F.size; var_13++) {
    var_14 = spawn("script_model", var_00);
    var_14 setModel(var_0F[var_13]);
    var_14 linkto(var_11, var_10[var_13], (0, 0, 0), (0, 0, 0));
    var_12[var_12.size] = var_14;
  }

  level.var_1484 = spawnStruct();
  level.var_1484.var_253D = var_02;
  level.var_1484.var_8F0A = var_04;
  level.var_1484.var_9D3B = var_07;
  level.var_1484.var_97C5 = var_0A;
  level.var_1484.var_9F96 = var_0B;
  level.var_1484.var_7786 = var_11;
  level.var_1484.var_778F = var_12;
  func_08B5(200);
}

func_54DC(param_00) {
  thread maps\mp\mp_raid_bulge_aud::func_54E5();
}

func_54DB() {
  self method_805C();
  if(isDefined(self.var_9EDD)) {
    self.var_9EDD method_805C();
  }

  if(isDefined(self.var_3850)) {
    self.var_3850 method_805C();
  }

  if(isDefined(self.var_9FA1)) {
    self.var_9FA1 method_805C();
  }
}

func_54E0(param_00) {
  thread lib_0502::func_8C21(param_00);
  if(isDefined(self.var_9EDD)) {
    self.var_9EDD thread lib_0502::func_8C21(param_00);
  }

  if(isDefined(self.var_3850)) {
    self.var_3850 thread lib_0502::func_8C21(param_00);
  }

  if(isDefined(self.var_9FA1)) {
    self.var_9FA1 thread lib_0502::func_8C21(param_00);
  }
}

func_54DF() {
  lib_0502::func_8C20();
  if(isDefined(self.var_9EDD)) {
    self.var_9EDD lib_0502::func_8C20();
  }

  if(isDefined(self.var_3850)) {
    self.var_3850 lib_0502::func_8C20();
  }

  if(isDefined(self.var_9FA1)) {
    self.var_9FA1 lib_0502::func_8C20();
  }
}

func_54DA() {
  while(!isDefined(level.var_9601) || !isDefined(level.var_9604) || !isDefined(level.var_9607)) {
    wait 0.05;
  }

  if(maps\mp\_utility::func_3FA0("prematch_done")) {
    return;
  }

  level.var_9601 func_54DB();
  level.var_9604 func_54DB();
  level.var_9607 func_54DB();
  while(!isDefined(level.var_79AE) || !isDefined(level.var_79AE.var_8DB) || level.var_79AE.var_8DB.size < 2) {
    wait 0.05;
  }

  foreach(var_01 in level.var_79AE.var_8DB) {
    if(isDefined(var_01.var_383C)) {
      var_01.var_383C lib_04FF::func_860F(1);
    }
  }

  level.var_9601 func_54DB();
  level.var_9604 func_54DB();
  level.var_9607 func_54DB();
  level waittill("allies_intro_cleanup");
  foreach(var_01 in level.var_79AE.var_8DB) {
    if(isDefined(var_01.var_383C)) {
      var_01.var_383C lib_04FF::func_8612(game["defenders"], 1);
    }
  }

  level.var_9601 func_54E0(game["defenders"]);
  level.var_9604 func_54E0(game["defenders"]);
  level.var_9607 func_54E0(game["defenders"]);
  level waittill("axis_intro_cleanup");
  foreach(var_01 in level.var_79AE.var_8DB) {
    if(isDefined(var_01.var_383C)) {
      var_01.var_383C lib_04FF::func_8611(1);
    }
  }

  level.var_9601 func_54DF();
  level.var_9604 func_54DF();
  level.var_9607 func_54DF();
}

func_147F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2.5, 120, 1, 1, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignetteaxisplayercameramix(1);
}

func_1480(param_00) {
  thread func_A47B(self);
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.7, 210, 1, 1, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignetteaxisplayercameramix(2);
}

func_1481(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 120, 1, 1, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignetteaxisplayercameramix(3);
}

func_1482(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 25, 30.5, 3, 3, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignetteaxisplayercameramix(4);
}

func_1483(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3.25, 1570, 1, 1, 0);
  thread lib_0505::func_3188(param_00, var_01);
  thread maps\mp\mp_raid_bulge_aud::introvignetteaxisplayercameramix(5);
}

func_54DD() {
  level notify("axis_intro_cleanup");
  foreach(var_01 in level.var_1484.var_97C5) {
    lib_0502::func_7D03(var_01);
    var_01 method_805C();
  }

  foreach(var_04 in level.var_1484.var_9F96) {
    var_04 method_805C();
  }

  func_2A79([200], 0);
}

func_54D9() {
  level.var_1484.var_253D delete();
  common_scripts\utility::func_F71(level.var_1484.var_8F0A, ::delete);
  level.var_1484.var_9D3B delete();
  common_scripts\utility::func_F71(level.var_1484.var_9F96, ::delete);
  common_scripts\utility::func_F71(level.var_1484.var_97C5, ::delete);
  level.var_1484.var_7786 delete();
  common_scripts\utility::func_F71(level.var_1484.var_778F, ::delete);
  level.var_1484 = undefined;
}

func_1485(param_00) {
  self endon("death");
  var_01 = ["j_prop_19", "j_prop_22", "j_prop_20", "j_prop_23", "j_prop_21", "j_prop_24"];
  var_02 = 0;
  for(;;) {
    self waittill(param_00, var_03);
    switch (var_03) {
      case "fire_artillery":
        if(var_02 < var_01.size) {
          var_04 = var_01[var_02];
          var_02++;
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_60mm_mortar_muzzle"), self, var_04);
        } else {
          var_04 = var_02[randomint(var_02.size)];
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_60mm_mortar_muzzle"), self, var_04);
        }
        break;
    }
  }
}

func_7FB4() {
  level thread func_7FDC();
  level thread func_7FDE();
}

func_7FDC() {
  var_00 = common_scripts\utility::func_46B5("anim_loc_vignette_bridge", "script_noteworthy");
  if(!isDefined(var_00.var_116)) {
    var_00.var_116 = (0, 0, 0);
  }

  if(!isDefined(var_00.var_1D)) {
    var_00.var_1D = (0, 0, 0);
  }

  var_01 = spawn("script_model", var_00.var_116);
  var_01 setModel("rblg_bridge_destruct_vista_02_anim");
  var_01 method_8495("mp_raids_bulge_vista_bridge_preidle", var_00.var_116, var_00.var_1D);
  level waittill("vista_bridge_destroy");
  func_A48F();
  thread func_7FDD();
  wait(0.6);
  var_02 = 11.5;
  var_01 thread lib_04B4::func_A476();
  var_01 method_8495("mp_raids_bulge_vista_bridge_start", var_00.var_116, var_00.var_1D);
  wait(var_02);
  var_01 method_8495("mp_raids_bulge_vista_bridge_idle", var_00.var_116, var_00.var_1D);
}

func_7FDD() {
  wait(2.5);
  thread lib_0506::func_A618("vista_bridge1");
  thread lib_0506::func_A618("vista_bridge2");
}

func_7FDE() {
  var_00 = common_scripts\utility::func_46B5("anim_loc_midpoint", "targetname");
  if(!isDefined(var_00.var_116)) {
    var_00.var_116 = (0, 0, 0);
  }

  if(!isDefined(var_00.var_1D)) {
    var_00.var_1D = (0, 0, 0);
  }

  level waittill("runObjectiveMultiEscortComplete");
  var_01 = "vista_trucks";
  wait(2);
  var_02 = func_90B8(var_00, "mp_raids_bulge_obj02truckpath_idle", "mp_raids_bulge_obj02truckpath_driver01_idle", var_01);
  var_03 = func_90B8(var_00, "mp_raids_bulge_obj02truckpath_truck02_idle", "mp_raids_bulge_obj02truckpath_driver02_idle", var_01);
  var_04 = func_90B8(var_00, "mp_raids_bulge_obj02truckpath_truck03_idle", "mp_raids_bulge_obj02truckpath_driver03_idle", var_01);
  level waittill("runObjectiveTankRefuelComplete");
  var_02 thread func_2D59(var_01);
  var_03 thread func_2D59(var_01);
  var_04 thread func_2D59(var_01);
}

func_90B8(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", param_00.var_116);
  var_04 setModel("vehicle_ger_trans_opel_blitz_snow");
  var_04 method_8495(param_01, param_00.var_116, param_00.var_1D, param_03);
  var_04.var_56E8 = 1;
  var_04 thread maps\mp\mp_raid_bulge_aud::func_A57E(var_04);
  var_05 = spawn("script_model", param_00.var_116);
  var_05 setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
  var_05 method_8495(param_02, param_00.var_116, param_00.var_1D);
  var_04.var_33F3 = var_05;
  return var_04;
}

func_2D59(param_00) {
  self waittillmatch("end", param_00);
  lib_0502::func_7D03(self);
  self.var_33F3 delete();
  self delete();
}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_bulge_allieswin_cam01", "mp_raids_bulge_allieswin_cam02", "mp_raids_bulge_allieswin_cam03", "mp_raids_bulge_allieswin_cam04", "mp_raids_bulge_allieswin_camhold"];
  var_01 = [::func_0C08, ::func_0C09, ::func_0C0A, ::func_0C0B, ::func_0C0C];
  level.var_6C86["allies"].var_8F2 = "defenders";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_allies_win", "script_noteworthy");
  level.var_6C86["allies"].var_8097 = 7;
  level.var_6C86["allies"].var_1F03 = var_00;
  level.var_6C86["allies"].var_1F05 = var_01;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
}

func_6C8D() {
  var_00 = "vignette_notify";
  func_08B5(86);
  var_01 = level.var_6C86["allies"].var_116;
  var_02 = level.var_6C86["allies"].var_1D;
  var_03 = common_scripts\utility::func_46B5("anim_loc_allies_win_destruction", "script_noteworthy");
  if(!isDefined(var_03)) {
    return;
  }

  var_04 = var_03.var_116;
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_05 = var_03.var_1D;
  if(!isDefined(var_05)) {
    var_05 = (0, 0, 0);
  }

  var_06 = lib_04FF::func_5761("tank_refuel");
  func_6C95();
  var_07 = spawn("script_model", var_01);
  var_07 setModel("genericprop_x10");
  var_07 enableoutofbounds(0);
  var_07 method_8495("mp_raids_bulge_allieswin_fx", var_01, var_02, var_00);
  var_07 thread func_0C0D(var_00);
  var_08 = undefined;
  var_09 = undefined;
  var_0A = [];
  var_0B = [];
  if(var_06) {
    var_08 = spawn("script_model", var_01);
    if(isDefined(level.var_960A)) {
      var_08 setModel(level.var_960A method_83BE());
    } else {
      var_08 setModel("vehicle_ger_tank_king_tiger_mp_snow_01");
    }

    var_08.var_56E8 = 1;
    var_08 enableoutofbounds(0);
    var_08 method_8495("mp_raids_bulge_allieswin_tiger01", var_01, var_02, var_00);
    var_09 = spawn("script_model", var_01);
    var_09 setModel("npc_ger_mg42_tigerii_bucket_mp_snow");
    var_09 linkto(var_08, "TAG_TURRET_4", (0, 0, 0), (0, 0, 0));
    var_09 enableoutofbounds(0);
    var_0C = ["mp_raids_bulge_allieswin_axis01", "mp_raids_bulge_allieswin_axis02"];
    var_0D = [2, 1, 2, 2, 2, 0];
    foreach(var_0F in var_0C) {
      var_10 = spawn("script_model", var_01);
      var_10 setcostumemodels(var_0D, "axis");
      var_10 enableoutofbounds(0);
      var_10 method_8495(var_0F, var_01, var_02);
      var_11 = spawn("weapon_mp40_mp", var_01, 1);
      var_11 linkto(var_10, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_0A[var_0A.size] = var_10;
      var_0B[var_0B.size] = var_11;
    }
  }

  var_13 = ["mp_raids_bulge_allieswin_simbridge", "mp_raids_bulge_allieswin_gatepieces", "mp_raids_bulge_allieswin_leftbridgepieces", "mp_raids_bulge_allieswin_rightbridgepieces"];
  var_14 = [];
  foreach(var_0F in var_13) {
    var_16 = spawn("script_model", var_04);
    var_16 setModel("rblg_bridge_destruct_01_anim");
    var_16 enableoutofbounds(0);
    var_16 method_8495(var_0F, var_04, var_05, var_00);
    var_14[var_14.size] = var_16;
  }

  thread func_A423();
  var_18 = spawn("script_model", var_04);
  var_18 setModel("rblg_tower_destruct_01_anim");
  var_18 enableoutofbounds(0);
  var_18 method_8495("mp_raids_bulge_allieswin_towerpieces", var_04, var_05, var_00);
  var_14[var_14.size] = var_18;
  var_19 = spawn("script_model", var_04);
  var_19 setModel("genericprop_x10");
  var_19 enableoutofbounds(0);
  var_19 method_8495("mp_raids_bulge_allieswin_fx_destruct", var_04, var_05, var_00);
  var_19 thread func_0C0D(var_00);
  var_1A = undefined;
  var_1B = undefined;
  if(var_06) {
    var_1A = spawn("script_model", var_04);
    if(isDefined(level.var_960A)) {
      var_1A setModel(level.var_960A method_83BE());
    } else {
      var_1A setModel("vehicle_ger_tank_king_tiger_mp_snow_01");
    }

    var_1A.var_56E8 = 1;
    var_1A enableoutofbounds(0);
    var_1A method_8495("mp_raids_bulge_allieswin_tiger01_destruct", var_04, var_05, var_00);
    var_1A thread func_A46D(var_00);
    var_1B = spawn("script_model", var_04);
    var_1B setModel("npc_ger_mg42_tigerii_bucket_mp_snow");
    var_1B linkto(var_1A, "TAG_TURRET_4", (0, 0, 0), (0, 0, 0));
    var_1B enableoutofbounds(0);
  }

  thread func_A424();
  level.var_C70 = spawnStruct();
  level.var_C70.var_778D = var_07;
  level.var_C70.var_1C2C = var_14;
  level.var_C70.var_778E = var_19;
  if(var_06) {
    level.var_C70.var_97BD = 1;
    level.var_C70.var_9600 = var_08;
    level.var_C70.var_9EDD = var_09;
    level.var_C70.var_8F0A = var_0A;
    level.var_C70.var_A9E7 = var_0B;
    level.var_C70.var_9782 = var_1A;
    level.var_C70.var_9F72 = var_1B;
  }
}

func_6C8B() {
  var_00 = level.var_C70.var_778D;
  var_01 = level.var_C70.var_1C2C;
  var_02 = level.var_C70.var_778E;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = level.var_C70.var_97BD;
  if(common_scripts\utility::func_562E(var_09)) {
    var_03 = level.var_C70.var_9600;
    var_04 = level.var_C70.var_9EDD;
    var_05 = level.var_C70.var_8F0A;
    var_06 = level.var_C70.var_A9E7;
    var_07 = level.var_C70.var_9782;
    var_08 = level.var_C70.var_9F72;
  }

  level.var_C70 = undefined;
  var_00 delete();
  common_scripts\utility::func_F71(var_01, ::delete);
  var_02 delete();
  if(common_scripts\utility::func_562E(var_09)) {
    var_04 delete();
    var_03 delete();
    common_scripts\utility::func_F71(var_06, ::delete);
    common_scripts\utility::func_F71(var_05, ::delete);
    var_08 delete();
    var_07 delete();
  }
}

func_0C08(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 230, 3, 3, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0C09(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 850, 3, 3, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0C0A(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 300, 3, 3, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0C0B(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 6, 1225, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0C0C(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 6, 1225, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0C0D(param_00) {
  self endon("death");
  var_01 = ["j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4", "j_prop_5"];
  var_02 = 0;
  func_08B5(92);
  for(;;) {
    self waittill(param_00, var_03);
    switch (var_03) {
      case "fire_artillery":
        if(var_02 < var_01.size) {
          var_04 = var_01[var_02];
          var_02++;
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_bridge_explosion_a"), self, var_04);
        } else {
          var_04 = var_02[randomint(var_02.size)];
          playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_bridge_explosion_a"), self, var_04);
        }
        break;
    }
  }
}

func_A46D(param_00) {
  self waittillmatch("splash", param_00);
  func_08B5(87);
}

func_A424() {
  func_08B5(91);
  wait(3);
  func_08B5(88);
  func_08B5(85);
}

func_A423() {
  wait(2.5);
  func_08B5(89);
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_bulge_axiswin_cam01", "mp_raids_bulge_axiswin_cam02", "mp_raids_bulge_axiswin_camhold"];
  var_01 = [::func_1489, ::func_148A, ::func_148B];
  level.var_6C86["axis"].var_8F2 = "attackers";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_axis_win", "script_noteworthy");
  level.var_6C86["axis"].var_8097 = 7;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
}

func_6C94() {
  var_00 = level.var_6C86["axis"].var_116;
  var_01 = level.var_6C86["axis"].var_1D;
  var_02 = getEntArray("axis_win_outro_delete", "targetname");
  foreach(var_04 in var_02) {
    var_04 lib_0502::func_7997();
  }

  func_6C95();
  var_06 = [];
  var_07 = [];
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_06[var_08] = [2, 1, 2, 2, 2, 0];
    var_07[var_08] = [2, 1, 2, 2, 2, 0];
  }

  var_09 = lib_0502::func_4627(game["attackers"]);
  var_09 = common_scripts\utility::func_F92(var_09);
  for(var_08 = 0; var_08 < var_09.size; var_08++) {
    var_06[var_08] = var_09[var_08].var_267E;
  }

  var_0A = ["mp_raids_bulge_axiswin_axis01", "mp_raids_bulge_axiswin_axis02", "mp_raids_bulge_axiswin_axis03", "mp_raids_bulge_axiswin_axis04", "mp_raids_bulge_axiswin_axis05", "mp_raids_bulge_axiswin_axis06"];
  var_0B = ["mp_raids_bulge_axiswin_allies01", "mp_raids_bulge_axiswin_allies02", "mp_raids_bulge_axiswin_allies03", "mp_raids_bulge_axiswin_allies04", "mp_raids_bulge_axiswin_allies05", "mp_raids_bulge_axiswin_allies06"];
  var_0C = [];
  var_0D = [];
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_0E = spawn("script_model", var_00);
    var_0E setcostumemodels(var_06[var_08], "axis");
    if(var_08 < var_09.size) {
      var_0F = var_09[var_08] lib_0505::func_470D("m1garand_mp");
      if(var_0F != "none") {
        var_10 = "weapon_" + var_0F;
        var_11 = spawn(var_10, (0, 0, 0), 1);
        var_11 linkto(var_0E, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
        var_0D[var_0D.size] = var_11;
      }
    } else {
      var_11 = spawn("weapon_mp40_mp", (0, 0, 0), 1);
      var_11 linkto(var_0E, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_0D[var_0D.size] = var_11;
    }

    var_0E method_8495(var_0A[var_08], var_00, var_01);
    var_0C[var_08] = var_0E;
  }

  var_12 = [];
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_0E = spawn("script_model", var_00);
    var_0E setcostumemodels(var_07[var_08], "allies");
    var_0E method_8495(var_0B[var_08], var_00, var_01);
    var_12[var_08] = var_0E;
  }

  var_13 = ["mp_raids_bulge_axiswin_truck01", "mp_raids_bulge_axiswin_truck02", "mp_raids_bulge_axiswin_truck03"];
  var_14 = [];
  for(var_08 = 0; var_08 < 3; var_08++) {
    var_15 = spawn("script_model", var_00);
    var_15 setModel("vehicle_ger_trans_opel_blitz");
    var_15 method_8495(var_13[var_08], var_00, var_01);
    var_14[var_08] = var_15;
  }

  var_16 = spawn("script_model", var_00);
  if(isDefined(level.var_960A)) {
    var_16 setModel(level.var_960A method_83BE());
  } else {
    var_16 setModel("vehicle_ger_tank_king_tiger_mp_snow_01");
  }

  var_16.var_56E8 = 1;
  var_16 method_8495("mp_raids_bulge_axiswin_tiger01", var_00, var_01);
  var_17 = spawn("script_model", var_00);
  var_17 setModel("npc_ger_mg42_tigerii_bucket_mp_snow");
  var_17 linkto(var_16, "TAG_TURRET_4", (0, 0, 0), (0, 0, 0));
  level notify("show_plunger");
  level.var_148C = spawnStruct();
  level.var_148C.var_148D = var_0C;
  level.var_148C.var_148F = var_0D;
  level.var_148C.var_BEB = var_12;
  level.var_148C.var_9E03 = var_14;
  level.var_148C.var_9600 = var_16;
  level.var_148C.var_9EDD = var_17;
}

func_6C92() {
  var_00 = level.var_148C.var_148D;
  var_01 = level.var_148C.var_148F;
  var_02 = level.var_148C.var_BEB;
  var_03 = level.var_148C.var_9E03;
  var_04 = level.var_148C.var_9600;
  var_05 = level.var_148C.var_9EDD;
  level.var_148C = undefined;
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  var_05 delete();
  var_04 delete();
  var_06 = getEntArray("axis_win_outro_delete", "targetname");
  foreach(var_08 in var_06) {
    var_08 lib_0502::func_79C6();
  }
}

func_6C95() {
  if(isDefined(level.var_960A)) {
    level.var_960A method_805C();
    if(isDefined(level.var_960A.var_9EDD)) {
      level.var_960A.var_9EDD method_805C();
    }

    lib_0502::func_7D03(level.var_960A);
  }

  if(isDefined(level.var_9601)) {
    lib_0502::func_7D03(level.var_9601);
  }

  if(isDefined(level.var_9604)) {
    lib_0502::func_7D03(level.var_9604);
  }

  if(isDefined(level.var_9607)) {
    lib_0502::func_7D03(level.var_9607);
  }
}

func_1489(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 6, 55, 10, 10, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_148A(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 6.5, 130, 3, 3, 0);
  var_01 = lib_0505::func_3187(var_01, 5, 560, 1, 2, 2.5);
  thread lib_0505::func_3188(param_00, var_01);
}

func_148B(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 560, 1, 2, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_7F6C() {
  var_00 = getEntArray("vignette_plunger", "targetname");
  common_scripts\utility::func_FB2(var_00, ::lib_0502::func_7997);
  level waittill("show_plunger");
  common_scripts\utility::func_FB2(var_00, ::lib_0502::func_79C6);
}

func_7F7D() {
  thread func_7FCD();
}

func_7FCF() {
  setgamespawnpointactivelabel("A", "A", "A");
  thread func_7CF9();
  maps\mp\_utility::func_3FA5("raid_objective_a_complete");
  lib_0502::func_90A7("C", "B", 20, "C", "C");
  maps\mp\_utility::func_3FA5("raid_objective_b_complete");
  level waittill("bridge_escort_checkpoint_1");
  lib_0502::func_90A4("G", "W");
  level waittill("bridge_escort_checkpoint_2");
  lib_0502::func_90A4("F", "D");
  level waittill("bridge_escort_checkpoint_3");
  lib_0502::func_90A4("E", "E");
  level waittill("bridge_escort_checkpoint_4");
  lib_0502::func_90A4("E", "H");
}

func_7CF9() {
  level endon("raid_objective_a_complete");
  var_00 = lib_04FF::func_6937("tank_escort_1");
  var_01 = lib_04FF::func_6937("tank_escort_2");
  var_02 = lib_04FF::func_6937("tank_escort_3");
  var_03 = level common_scripts\utility::func_A716(var_00, var_01, var_02);
  if(var_03 == var_00) {
    lib_0502::func_90A4(undefined, "X");
    return;
  }

  if(var_03 == var_01) {
    lib_0502::func_90A4(undefined, "Y");
    return;
  }

  lib_0502::func_90A4(undefined, "Z");
}

func_7F89() {
  waittillframeend;
  func_92FD();
  func_27D1("ObjectiveA", ::func_92BB);
  func_27D1("ObjectiveB", ::func_92BC);
  func_27D1("ObjectiveC", ::func_92BD);
  func_27D1("ObjectiveC1", ::func_92BE);
  func_27D1("ObjectiveC2", ::func_92BF);
  func_27D1("ObjectiveC3", ::func_92C0);
  func_27D1("ObjectiveC4", ::startboundries_objectivec_chk4);
  maps\mp\_utility::func_3FA5("prematch_done");
  func_20C5("ObjectiveA");
  maps\mp\_utility::func_3FA5("raid_objective_a_complete");
  func_20C5("ObjectiveB");
  maps\mp\_utility::func_3FA5("raid_objective_b_complete");
  func_20C5("ObjectiveC");
  maps\mp\_utility::func_3FA5("raid_objective_c1_complete");
  func_20C5("ObjectiveC1");
  maps\mp\_utility::func_3FA5("raid_objective_c2_complete");
  func_20C5("ObjectiveC2");
  maps\mp\_utility::func_3FA5("raid_objective_c3_complete");
  func_20C5("ObjectiveC3");
  maps\mp\_utility::func_3FA5("raid_objective_c4_complete");
  func_20C5("ObjectiveC4");
}

func_92BB() {
  lib_04F4::func_863D("allies_A", "active", 5);
  lib_04F4::func_863D("allies_B", "active", 5);
  lib_04F4::func_863D("allies_C1", "active", 5);
  lib_04F4::func_863D("allies_C2", "active", 5);
  lib_04F4::func_863D("allies_C3", "active", 5);
  lib_04F4::func_863D("axis_A", "active", 5);
  lib_04F4::func_8BEF(["allies_A", "axis_A"]);
}

func_92BC() {
  level thread lib_04F4::func_9C77("axis_B", 20);
  lib_04F4::func_863D("allies_A", "inactive");
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
  lib_04F4::func_7D4E();
}

func_92BD() {
  level thread lib_04F4::func_9C77("axis_C", 20);
  lib_04F4::func_8BEF(["allies_B", "axis_C"]);
  lib_04F4::func_7D4E();
}

func_92BE() {
  level thread lib_04F4::func_9C77("axis_C1", 20);
  lib_04F4::func_863D("allies_B", "inactive");
  lib_04F4::func_8BEF(["allies_C1", "axis_C1"]);
  lib_04F4::func_7D4E();
}

func_92BF() {
  level thread lib_04F4::func_9C77("axis_C2", 20);
  lib_04F4::func_863D("allies_C1", "inactive");
  lib_04F4::func_8BEF(["allies_C2", "axis_C2"]);
  lib_04F4::func_7D4E();
}

func_92C0() {
  level thread lib_04F4::func_9C77("axis_C3", 20);
  lib_04F4::func_863D("allies_C2", "inactive");
  lib_04F4::func_8BEF(["allies_C3", "axis_C3"]);
  lib_04F4::func_7D4E();
}

startboundries_objectivec_chk4() {
  level thread lib_04F4::func_9C77("axis_C4", 20);
  lib_04F4::func_8BEF(["allies_C3", "axis_C4"]);
  lib_04F4::func_7D4E();
}

func_92FD() {
  if(isDefined(level.var_792A)) {}

  level.var_792A = spawnStruct();
  level.var_792A.var_2951 = "NO_BOUNDARY_ACTIVE";
  level.var_792A.var_7BE0 = [];
  func_27D1("NO_BOUNDARY_ACTIVE", undefined, undefined);
}

func_20C5(param_00) {
  if(!isDefined(level.var_792A)) {}

  if(!isDefined(level.var_792A.var_7BE0[param_00])) {
    return;
  }

  if(level.var_792A.var_2951 != param_00) {
    var_01 = level.var_792A.var_7BE0[level.var_792A.var_2951];
    if(isDefined(var_01.var_36B1)) {
      [[var_01.var_36B1]]();
    }

    var_02 = level.var_792A.var_7BE0[param_00];
    if(isDefined(var_02.var_92C1)) {
      [[var_02.var_92C1]]();
    }
  }
}

func_27D1(param_00, param_01, param_02) {
  if(!isDefined(level.var_792A)) {
    func_92FD();
  }

  var_03 = spawnStruct();
  var_03.var_109 = param_00;
  var_03.var_92C1 = param_01;
  var_03.var_36B1 = param_02;
  level.var_792A.var_7BE0[param_00] = var_03;
}

func_7FB5() {}

func_7FDB() {
  level.var_7961 = [];
  waittillframeend;
  thread func_A483();
  thread func_A489();
  thread func_A48A();
  thread func_A48B();
  thread func_A487();
  thread func_A484();
  thread func_A486();
  thread func_A480();
  thread func_A485();
}

func_08B5(param_00) {
  common_scripts\_exploder::func_392A(param_00);
  level.var_7961[level.var_7961.size] = param_00;
}

func_2A79(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(common_scripts\utility::func_F79(level.var_7961, var_03)) {
      common_scripts\_exploder::func_2A6D(var_03, undefined, param_01);
      level.var_7961 = common_scripts\utility::func_F93(level.var_7961, var_03);
      wait(0.1);
    }
  }
}

func_A483() {
  maps\mp\_utility::func_3FA5("prematch_done");
  func_08B5(210);
}

func_A489() {
  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = getent("tree_fall_01", "targetname");
  if(isDefined(var_00)) {
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_preidle");
    wait(35);
    func_08B5(50);
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_start");
    wait(getanimlength(%mp_raids_bulge_obj01treefall_tree01_start));
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_idle");
  }
}

func_A48A() {
  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = getent("tree_fall_02", "targetname");
  if(isDefined(var_00)) {
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_preidle");
    level waittill("runObjectiveMultiEscortComplete");
    wait(5);
    func_08B5(56);
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_start");
    wait(getanimlength(%mp_raids_bulge_obj01treefall_tree01_start));
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_idle");
  }
}

func_A48B() {
  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = getent("tree_fall_03", "targetname");
  if(isDefined(var_00)) {
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_preidle");
    level waittill("tree_03");
    func_08B5(53);
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_start");
    wait(getanimlength(%mp_raids_bulge_obj01treefall_tree01_start));
    var_00 method_8278("mp_raids_bulge_obj01treefall_tree01_idle");
  }
}

func_A487() {
  level endon("transition_1_finished");
  level waittill("tent_crush_01");
}

func_A484() {
  level waittill("runObjectiveMultiEscortComplete");
  func_2A79([200, 210], 0);
  func_08B5(220);
}

func_A486() {
  level waittill("runObjectiveTankRefuelComplete");
  func_2A79([200, 210], 0);
  func_08B5(230);
}

func_A480() {
  level waittill("runObjectiveBridgeSecureComplete");
  func_2A79([200, 210, 220, 230], 0);
  func_2A79([21, 60, 63, 65], 0);
  func_08B5(240);
}

func_A485() {
  level waittill("game_ended");
  func_2A79([200, 210, 220, 230, 240], 0);
  func_2A79([21, 60, 63, 65], 0);
}

func_A47A() {
  var_00 = 10;
  var_01 = 12;
  var_02 = 30;
  for(var_03 = 0; var_03 < var_00; var_03++) {
    var_04 = var_02 + randomint(var_01);
    common_scripts\_exploder::func_392A(var_04);
    wait(randomfloatrange(0.25, 0.85));
  }
}

func_A47B(param_00) {
  func_08B5(10);
  playfxontagforclients(common_scripts\utility::func_44F5("raid_bulge_intro_cut_snow"), param_00, "tag_origin", param_00);
}

func_A47D() {
  func_08B5(70);
}

func_A48F() {
  func_08B5(80);
}

func_A47C() {
  func_08B5(90);
}

func_7FC0() {
  level endon("game_ended");
  waittillframeend;
  thread func_0898();
  thread func_2063();
  thread func_9E02();
  thread func_68F9();
  func_7FBE();
  lib_0502::func_7B35();
  lib_0504::func_7986();
  thread func_97EB();
  wait(0.1);
  func_7FC1();
  lib_0502::func_7B35();
  func_7FBD();
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

func_7FBE() {
  level notify("runObjectiveMultiEscort");
  lib_04FF::func_6972("escort_tanks");
  func_97E8();
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 3);
  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = lib_0502::func_6514();
  lib_0502::func_86DE(lib_0501::func_4647("escort3x_objectiveTime"), 1);
  level thread func_7FA0();
  lib_04FF::func_6982("escort_tanks");
  thread lib_04FF::func_2CDA(0.5, (-6389, 2817, 379));
  level thread lib_0500::func_1E85(game["defenders"], 15, "escort_tanks");
  maps\mp\_utility::func_3FA4("raid_objective_a_complete");
  level notify("runObjectiveMultiEscortComplete");
}

func_7FA0() {
  level endon("escort_tanks");
  level waittill("objectiveComplete", var_00);
  if(var_00 == "tank_escort_1" || var_00 == "tank_escort_2" || var_00 == "tank_escort_3") {
    lib_04F3::func_79CE(game["music"]["stinger_pos"], game["attackers"]);
    lib_04F3::func_79CE(game["music"]["stinger_neg"], game["defenders"]);
  }
}

func_97DD() {
  var_00 = getvehiclenode(level.var_9601.var_1A2, "targetname");
  var_01 = getvehiclenode(level.var_9604.var_1A2, "targetname");
  var_02 = getvehiclenode(level.var_9607.var_1A2, "targetname");
  var_00 thread func_97C2();
  var_01 thread func_97C2();
  var_02 thread func_97C2();
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  for(;;) {
    var_06 = level common_scripts\utility::func_A715("checkpoint_1_1", "checkpoint_1_2", "checkpoint_1_3");
    if(var_06 == "checkpoint_1_1") {
      var_03 = 1;
    } else if(var_06 == "checkpoint_1_2") {
      var_04 = 1;
    } else {
      var_05 = 1;
    }

    if(var_03 == 1 && var_04 == 1 && var_05 == 1) {
      break;
    }
  }

  func_20C5("ObjectiveA1");
}

func_97C1(param_00) {
  self waittill("trigger", var_01);
  level notify(self.var_8260);
}

func_97C2() {
  var_00 = self;
  var_01 = 1;
  while(isDefined(var_00)) {
    if(!var_01) {
      if(isDefined(var_00.var_8260)) {
        var_00 thread func_97C1();
      }
    }

    if(!isDefined(var_00.var_1A2)) {
      break;
    }

    var_01 = 0;
    var_00 = getvehiclenode(var_00.var_1A2, "targetname");
  }
}

func_97EB() {
  level endon("transition_1_finished");
  var_00 = lib_04FF::func_5761("tank_escort_1");
  var_01 = lib_04FF::func_5761("tank_escort_2");
  var_02 = lib_04FF::func_5761("tank_escort_3");
  var_03 = getvehiclenode("transition_path_1", "targetname");
  var_04 = getvehiclenode("transition_path_2a", "targetname");
  var_05 = getvehiclenode("transition_path_2b", "targetname");
  var_06 = getvehiclenode("transition_path_3", "targetname");
  var_07 = 1;
  var_08 = 2;
  level thread func_97E7();
  level thread func_97F0();
  level thread func_97EE();
  if(var_00) {
    if(var_01) {
      lib_04FF::func_6935("tank_escort_3");
      func_97E9(level.var_9601, level.var_9604, var_03, var_05);
      level notify("bulge_tank_1_moving");
      level.var_9607 thread func_180B();
      wait(var_08);
      func_3A55(level.var_960A, level.var_964A);
      level.var_3836 = level.var_9601;
      level notify("transition_1_started");
      level.var_960A thread tanktransition_startnewpath(var_03, var_07);
      var_03 func_97F2();
      level.var_964A thread tanktransition_startnewpath(var_05, var_07);
      var_05 func_97F2();
      return;
    }

    lib_04FF::func_6935("tank_escort_2");
    func_97E9(level.var_9601, level.var_9607, var_03, var_06);
    level notify("bulge_tank_1_moving");
    level.var_9604 thread func_180B();
    wait(var_08);
    func_3A55(level.var_960A, level.var_964A);
    level.var_3836 = level.var_9601;
    level notify("transition_1_started");
    level.var_960A thread tanktransition_startnewpath(var_03, var_07);
    var_03 func_97F2();
    level.var_964A thread tanktransition_startnewpath(var_06, var_07);
    var_06 func_97F2();
    return;
  }

  lib_04FF::func_6935("tank_escort_1");
  func_97E9(level.var_9604, level.var_9607, var_04, var_06);
  level.var_9601 thread func_180B();
  wait(var_08);
  func_3A55(level.var_960A, level.var_964A);
  level.var_3836 = level.var_9604;
  level notify("transition_1_started");
  level.var_960A thread tanktransition_startnewpath(var_04, var_07);
  var_04 func_97F2();
  level.var_964A thread tanktransition_startnewpath(var_06, var_07);
  var_06 func_97F2();
}

func_3A55(param_00, param_01) {
  if(param_00.var_291C != param_00.var_693E) {
    param_00.var_1C7 = "forward";
    param_00.var_1C1 = "forward";
    param_00 method_8281(200);
  }

  if(param_01.var_291C != param_01.var_693E) {
    param_01.var_1C7 = "forward";
    param_01.var_1C1 = "forward";
    param_01 method_8281(200);
  }

  for(;;) {
    if(param_01.var_291C == param_01.var_693E && param_00.var_291C == param_00.var_693E) {
      break;
    }

    if(param_00 method_8283() == 0 && param_01 method_8283() == 0) {
      break;
    }

    wait 0.05;
  }
}

func_97E7() {}

func_97EE() {
  var_00 = getEntArray("tank_1_to_delete", "targetname");
  var_01 = common_scripts\utility::func_46B7("tank1_to_delete_by_link", "targetname");
  var_02 = 0;
  foreach(var_07 in var_01) {
    var_08 = getEntArray(var_07.var_81EF, "script_linkname");
    foreach(var_0A in var_08) {
      var_00 = common_scripts\utility::func_F6F(var_00, var_0A);
      if(isDefined(var_0A.var_E9E)) {
        var_00 = common_scripts\utility::func_F6F(var_00, var_0A.var_E9E);
      }
    }
  }

  if(!var_02) {
    level waittill("bulge_tank_1_moving");
  }

  var_0D = common_scripts\utility::func_46B5("tank_1_to_shoot", "targetname");
  var_0E = undefined;
  if(isDefined(var_0D)) {
    var_0F = level.var_9601 gettagorigin("tag_barrel");
    var_10 = vectornormalize(var_0D.var_116 - var_0F);
    var_0E = var_0F + var_10 * 1200;
    level.var_9601.var_9734 = 1;
    level.var_9601 method_825B(var_0E);
    while(!level.var_9601 lib_0503::func_57FA(var_0E)) {
      wait 0.05;
    }

    wait(1);
    lib_0503::func_3C22(level.var_9601);
    wait(0.1);
  }

  func_08B5(55);
  if(var_00.size != 0) {
    foreach(var_12 in var_00) {
      var_12 lib_0502::func_7997();
    }
  }

  if(isDefined(var_0D)) {
    wait(1);
    level.var_9601 method_825D();
    level.var_9601.var_9734 = 0;
  }
}

func_97F0() {
  level endon("transition_1_finished");
  level waittill("path_1_End");
  level waittill("path_1_End");
  level notify("transition_1_finished");
}

func_97F1(param_00) {
  if(isDefined(self.var_165)) {
    var_01 = undefined;
    if(!param_00) {
      self waittill("trigger", var_01);
    }

    if(isDefined(self.var_8260)) {
      level notify(self.var_8260);
    }

    if(self.var_165 == "aim") {
      if(isDefined(self.var_81EF)) {
        var_02 = common_scripts\utility::func_46B5(self.var_81EF, "script_linkname");
        if(isDefined(var_02)) {
          var_01.var_9734 = 1;
          var_01 method_825B(var_02.var_116);
          return;
        }

        return;
      }

      return;
    }

    if(self.var_165 == "aimStop") {
      var_02 method_825D();
      var_02.var_9734 = 0;
      return;
    }

    level notify(self.var_165);
    return;
  }
}

tanktransition_startnewpath(param_00, param_01) {
  self.var_1C7 = "forward";
  self.var_1C1 = "forward";
  wait 0.05;
  self startpath(param_00);
  self method_8293(param_01);
}

func_97F2() {
  var_00 = self;
  var_01 = 1;
  while(isDefined(var_00)) {
    var_00 thread func_97F1(var_01);
    if(!isDefined(var_00.var_1A2)) {
      break;
    }

    var_01 = 0;
    var_00 = getvehiclenode(var_00.var_1A2, "targetname");
  }
}

func_97E4() {
  level thread func_97EF();
  level thread func_97E5();
  level thread func_97ED();
}

func_97E6(param_00, param_01) {
  level endon("transition_1_finished");
  level waittill(param_00);
  common_scripts\utility::func_3C8F(param_01);
}

func_97EC(param_00) {
  var_01 = common_scripts\utility::func_46B5("tank_tread_origin", "targetname");
  var_02 = var_01.var_116;
  if(!isDefined(var_02)) {
    var_02 = (0, 0, 0);
  }

  var_03 = var_01.var_1D;
  if(!isDefined(var_03)) {
    var_03 = (0, 0, 0);
  }

  playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_tank_treads_hit"), param_00, "tag_origin");
  lib_04F3::func_79CB("tank_hit_treads_exp", var_02);
  var_04 = 4.5;
  wait(var_04);
  stopFXOnTag(common_scripts\utility::func_44F5("raid_bulge_tank_treads_hit"), param_00, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_tank_treads_exp"), param_00, "tag_origin");
  lib_04F3::func_79CB("tank_death_treads_exp", var_02);
  param_00 method_8695("track_L_");
  var_05 = spawn("script_model", var_02);
  var_05 setModel("rblg_ger_tank_tigerii_tread");
  var_06 = 3.3;
  var_05 method_8495("mp_raids_bulge_tanktreads_treads_start", var_02, var_03);
  wait(var_06);
  var_05 method_8495("mp_raids_bulge_tanktreads_treads_idle", var_02, var_03);
  lib_0502::func_7D03(param_00, 8, 1);
}

func_97EA() {
  var_00 = getent("sherman_alive", "targetname");
  var_01 = getent("sherman_destroyed", "targetname");
  if(!isDefined(var_01) || !isDefined(var_00)) {
    return;
  }

  var_01 lib_0502::func_7997();
  var_02 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_02.var_56E8 = 1;
  wait 0.05;
  lib_0502::func_9FF(var_02);
  level waittill("transition_1_started");
  common_scripts\utility::func_3C87("sherman_fire");
  common_scripts\utility::func_3C87("tiger_fire");
  level thread func_97E6("sherman_fire_node", "sherman_fire");
  level thread func_97E6("tiger_fire_node", "tiger_fire");
  var_03 = (0, 0, 60);
  var_02 method_825C(level.var_964A, var_03);
  common_scripts\utility::func_3C9F("sherman_fire");
  lib_0503::func_3C22(var_02);
  level thread func_97EC(level.var_964A);
  wait(1);
  lib_0506::func_A618("tank1_shot", 1);
  var_02 method_825D();
  var_03 = (0, 0, 60);
  level.var_960A method_825C(var_02, var_03);
  level.var_960A.var_9734 = 1;
  common_scripts\utility::func_3C9F("tiger_fire");
  for(;;) {
    var_04 = level.var_960A gettagorigin("tag_flash");
    var_05 = var_02.var_116 + var_03 - var_04;
    var_05 = vectornormalize(var_05);
    var_06 = level.var_960A gettagangles("tag_flash");
    var_06 = anglesToForward(var_06);
    if(vectordot(var_05, var_06) > 0.99) {
      break;
    }

    wait 0.05;
  }

  lib_0503::func_3C22(level.var_960A);
  wait(0.1);
  lib_04F3::func_79CB("emt_vehicle_fire_2_lp", (-3063, 3642, 378));
  lib_04F3::func_79CB("raid_tank_explode_sweet", (-3063, 3642, 378));
  playFX(common_scripts\utility::func_44F5("veh_opel_blitz_explo_1_rnr"), var_02.var_116, anglesToForward(var_02.var_1D));
  lib_0502::func_7D03(var_02, 1);
  var_02 lib_0502::func_7997();
  var_01 lib_0502::func_79C6();
  func_08B5(63);
  lib_0506::func_A618("tank2_shot", 1);
  wait(3);
  level.var_960A method_825D();
  level.var_960A.var_9734 = 0;
  var_02 delete();
}

func_97EF() {
  var_00 = getent("truck_01", "targetname");
  var_01 = getent("truck_clip_01", "targetname");
  var_02 = getent("truck_clip_final_pos", "targetname");
  var_03 = getEntArray("truck_visblocker_01", "targetname");
  var_04 = 0;
  var_01 linkto(var_00);
  if(isDefined(var_02)) {
    var_02 lib_0502::func_7997();
  }

  if(!var_04) {
    level common_scripts\utility::func_A732("truck_push", "transition_1_finished");
  }

  var_01 thread lib_0502::func_2FC2();
  var_00 method_8278("mp_raids_bulge_tanktruck_push_truck_start");
  func_08B5(45);
  playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_00, "tag_wheel_back_left");
  playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_00, "tag_wheel_back_right");
  playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_00, "tag_wheel_front_left");
  playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_00, "tag_wheel_front_right");
  foreach(var_06 in var_03) {
    var_06 lib_0502::func_7997();
  }

  thread func_A6D3(getanimlength(%mp_raids_bulge_tanktruck_push_truck_start), var_02);
}

func_A6D3(param_00, param_01) {
  wait(param_00);
  if(isDefined(param_01)) {
    param_01 lib_0502::func_79C6();
    foreach(var_03 in level.var_744A) {
      if(var_03 istouching(param_01)) {
        param_01 maps\mp\_movers::func_A047(var_03);
      }

      if(isDefined(var_03.var_872A)) {
        if(var_03.var_872A istouching(param_01)) {
          level maps\mp\perks\_perkfunctions::func_2D54(var_03.var_872A);
        }
      }
    }
  }
}

func_97E5() {
  var_00 = getent("barrel_01a", "targetname");
  var_01 = getent("barrel_01b", "targetname");
  var_02 = getent("barrel_clip_01a", "targetname");
  var_03 = getent("barrel_clip_01b", "targetname");
  var_04 = 0;
  var_02 linkto(var_00);
  var_03 linkto(var_01);
  if(!var_04) {
    level common_scripts\utility::func_A732("truck_push", "transition_1_finished");
  }

  var_00 method_8278("mp_raids_bulge_tanktruck_push_barrel01_start");
  var_01 method_8278("mp_raids_bulge_tanktruck_push_barrel02_start");
}

func_97ED() {
  var_00 = getent("tent_crush_01", "targetname");
  var_01 = getent("tent_crush_01_clip", "targetname");
  var_02 = 0;
  if(!var_02) {
    level waittill("tent_crush_01");
  }

  var_00 method_8278("mp_raids_bulge_tanktent_tent01_start");
  var_01 lib_0502::func_7997();
}

func_97E8() {
  var_00 = common_scripts\utility::func_46B5("tank_escort_1", "targetname");
  var_01 = common_scripts\utility::func_46B5("tank_escort_2", "targetname");
  var_02 = common_scripts\utility::func_46B5("tank_escort_3", "targetname");
  level.var_9601 = var_00.var_A2C8;
  level.var_9604 = var_01.var_A2C8;
  level.var_9607 = var_02.var_A2C8;
  level thread func_54DA();
}

func_97E9(param_00, param_01, param_02, param_03) {
  level.var_960A = param_00;
  level.var_964A = param_01;
  level.var_960A.var_92ED = param_02;
  level.var_960A.var_36DA = param_02;
  level.var_960A.var_6F45 = param_02;
  while(isDefined(level.var_960A.var_36DA.var_1A2)) {
    level.var_960A.var_6F45 = level.var_960A.var_36DA;
    level.var_960A.var_36DA = getvehiclenode(level.var_960A.var_36DA.var_1A2, "targetname");
  }

  level.var_964A.var_92ED = param_03;
  level.var_964A.var_36DA = param_03;
  level.var_964A.var_6F45 = param_03;
  while(isDefined(level.var_964A.var_36DA.var_1A2)) {
    level.var_964A.var_6F45 = level.var_964A.var_36DA;
    level.var_964A.var_36DA = getvehiclenode(level.var_964A.var_36DA.var_1A2, "targetname");
  }
}

func_7FC1() {
  level notify("runObjectiveTankRefuel");
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 4);
  lib_04FF::func_6972("tank_refuel");
  lib_0502::func_86DE(lib_0501::func_4647("ctf_objectiveTime"), 2);
  lib_04FF::func_6982("tank_refuel");
  level thread lib_0500::func_1E85(game["defenders"], 2, "tank_refuel");
  maps\mp\_utility::func_3FA4("raid_objective_b_complete");
  level notify("runObjectiveTankRefuelComplete");
}

func_68F9() {
  var_00 = getent("obj2_tank_cap_clip", "targetname");
  var_01 = getent("obj2_tank_broken_clip", "targetname");
  if(isDefined(var_00) && isDefined(var_01)) {
    var_00 lib_0502::func_7997();
    var_01 lib_0502::func_7997();
    level waittill("transition_1_finished");
    var_00 lib_0502::func_79C6();
    var_01 lib_0502::func_79C6();
    foreach(var_03 in level.var_744A) {
      if(var_03 isusingturret()) {
        continue;
      }

      if(var_03 istouching(var_00)) {
        var_00 maps\mp\_movers::func_A047(var_03);
      } else if(var_03 istouching(var_01)) {
        var_01 maps\mp\_movers::func_A047(var_03);
      }

      if(isDefined(var_03.var_872A)) {
        if(var_03.var_872A istouching(var_00) || var_03.var_872A istouching(var_01)) {
          maps\mp\perks\_perkfunctions::func_2D54(var_03.var_872A);
        }
      }
    }

    level waittill("runObjectiveBridgeSecure");
    var_00 lib_0502::func_7997();
  }
}

func_7FBD() {
  level endon("objectiveComplete");
  level notify("runObjectiveBridgeSecure");
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  level thread func_1C6B();
  lib_0502::func_86DE(lib_0501::func_4647("escort_objectiveTime"), 3);
  lib_04FF::func_6972("bridge_escort");
  level waittill("bridge_escort_checkpoint_1");
  maps\mp\_utility::func_3FA4("raid_objective_c1_complete");
  thread func_2064();
  thread func_A6D5();
  level waittill("bridge_escort_checkpoint_2");
  maps\mp\_utility::func_3FA4("raid_objective_c2_complete");
  var_00 = level.var_79C2.var_693B["bridge_escort"].var_6984.var_116;
  lib_04F7::func_2F99(var_00, 3000);
  lib_0502::func_8628("bridge_escort");
  level waittill("bridge_escort_checkpoint_3");
  maps\mp\_utility::func_3FA4("raid_objective_c3_complete");
  thread func_A6D4();
  thread func_A6B3();
  level waittill("bridge_escort_checkpoint_4");
  maps\mp\_utility::func_3FA4("raid_objective_c4_complete");
  lib_04FF::func_6982("bridge_escort");
  maps\mp\_utility::func_3FA4("raid_objective_c_complete");
  level notify("runObjectiveBridgeSecureComplete");
}

func_1C6B() {
  var_00 = getEntArray("destroyed_tank_turret", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(var_02.var_3A == "misc_turret") {
      lib_0502::func_1D39(var_02);
      var_02 lib_0502::func_1D3A(var_02, 1);
      var_02 lib_0502::func_1D3B(1);
      break;
    }
  }
}

func_1C6C() {
  var_00 = common_scripts\utility::func_46B5("bridge_escort", "targetname");
  var_01 = var_00.var_A2C8;
  var_00.var_1A2 = level.var_960A;
  var_00.var_A2C8 = level.var_960A;
  var_01 delete();
  var_02 = getvehiclenode("transition_path_4", "targetname");
  level.var_960A.var_92ED = var_02;
}

cavewaitforplantedplayer() {
  level endon("game_ended");
  for(;;) {
    level.caveplantedkillvolume waittill("trigger", var_00);
    if(var_00 playerisweaponplantenabled()) {
      var_00 maps\mp\_utility::func_728();
    }
  }
}

cavecheckforti() {
  level endon("game_ended");
  var_00 = (-1240, 5814, 319.155);
  var_01 = (-1176, 5870, 317.213);
  foreach(var_03 in level.var_744A) {
    if(isDefined(var_03.var_872A) && var_03.var_872A.var_116[0] == var_00[0] && var_03.var_872A.var_116[1] == var_00[1]) {
      maps\mp\perks\_perkfunctions::func_2D54(var_03.var_872A);
      continue;
    }

    if(isDefined(var_03.var_6E6B) && var_03.var_6E6B && var_03.paratrooperinsertgroundposition[0] == var_00[0] && var_03.paratrooperinsertgroundposition[1] == var_00[1]) {
      var_03 notify("changeParachuteEndpoint", var_01);
    }
  }
}

func_2063() {
  var_00 = getEntArray("cavein_before", "targetname");
  var_01 = getEntArray("cavein_after", "targetname");
  if(var_01.size != 0) {
    foreach(var_03 in var_01) {
      var_03 lib_0502::func_7997();
    }
  }

  if(var_00.size != 0) {
    foreach(var_03 in var_00) {
      var_03 lib_0502::func_79C6();
    }
  }
}

func_2064() {
  var_00 = getEntArray("cavein_before", "targetname");
  var_01 = getEntArray("cavein_after", "targetname");
  if(var_01.size != 0) {
    func_08B5(70);
    wait(2);
    if(!isDefined(level.caveplantedkillvolume)) {
      level.caveplantedkillvolume = spawn("trigger_radius", (-1551, 5694, 310), 0, 277, 250);
    }

    level thread cavewaitforplantedplayer();
    level thread cavecheckforti();
    foreach(var_03 in var_01) {
      var_03 lib_0502::func_79C6();
    }
  }

  if(var_00.size != 0) {
    foreach(var_03 in var_00) {
      var_03 lib_0502::func_7997();
    }
  }
}

func_A6D5() {
  var_00 = getEntArray("fuel_depot_truck_push_models", "targetname");
  var_01 = getent("fuel_depot_truck_push_collision_volume", "targetname");
  var_02 = getent("fuel_depot_truck_push_collision_final", "targetname");
  var_03 = [];
  var_04 = undefined;
  var_05 = 0;
  if(!var_05) {
    level waittill("fuel_depot_truck_push");
  }

  foreach(var_08 in var_00) {
    if(!isDefined(var_08)) {
      continue;
    }

    if(!isDefined(var_08.var_165)) {
      var_08 lib_0502::func_7997();
      continue;
    }

    if(isDefined(var_08.var_1A2)) {
      var_09 = getent(var_08.var_1A2, "targetname");
      var_09 linkto(var_08);
      var_09 thread lib_0502::func_2FC2();
    }

    switch (var_08.var_165) {
      case "truck":
        var_04 = var_08;
        var_04 method_8278("mp_raids_bulge_obj03truckpush_truck01_start");
        playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_04, "tag_wheel_back_left");
        playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_04, "tag_wheel_back_right");
        playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_04, "tag_wheel_front_left");
        playFXOnTag(common_scripts\utility::func_44F5("raid_bulge_truck_tread"), var_04, "tag_wheel_front_right");
        break;

      case "truck_attach":
        var_03[var_03.size] = var_08;
        break;

      case "barrel1":
        var_08 method_8278("mp_raids_bulge_obj03truckpush_barrel01_start");
        break;

      case "barrel2":
        var_08 method_8278("mp_raids_bulge_obj03truckpush_barrel02_start");
        break;

      case "barrel3":
        var_08 method_8278("mp_raids_bulge_obj03truckpush_truckbarrel01_start");
        break;

      case "barrel4":
        var_08 method_8278("mp_raids_bulge_obj03truckpush_truckbarrel02_start");
        break;

      case "barrel5":
        var_08 method_8278("mp_raids_bulge_obj03truckpush_truckbarrel03_start");
        break;

      default:
        var_08 lib_0502::func_7997();
        break;
    }
  }

  foreach(var_0C in var_03) {
    var_0C linkto(var_04);
  }

  if(isDefined(var_01)) {
    lib_04F3::func_79CB("blg_watchtower_hit", var_01.var_116);
    var_01 lib_0502::func_7997();
  }

  thread func_A6D3(getanimlength(%mp_raids_bulge_obj03truckpush_truck01_start), var_02);
}

func_9E02() {
  var_00 = getent("fuel_depot_truck_push_collision_final", "targetname");
  if(isDefined(var_00)) {
    var_00 lib_0502::func_7997();
  }
}

func_9E01(param_00) {
  self endon("death");
  self waittillmatch("end", param_00);
  lib_0502::func_7997();
}

func_9E00(param_00, param_01, param_02, param_03) {
  var_04 = "breakObject";
  maps\mp\_utility::func_2CED(param_03, ::lib_04F3::func_79CB, "wood_break_med_conc", self.var_116);
  if(param_02 > 0) {
    wait(param_02);
  }

  self setModel(param_00);
  self method_8278(param_01, var_04);
  thread func_9E01(var_04);
}

func_A6D4() {
  var_00 = getEntArray("break_objects_A", "targetname");
  var_01 = 0;
  if(!var_01) {
    level waittill("bridge_truck_push");
  }

  var_03 = ["dun_wood_single_crate_war_chunks", "dun_wood_single_crate_war_chunks", "dun_wood_single_crate_war_chunks", "dun_wood_single_crate_war_chunks", "dun_wood_single_crate_war_chunks", "dun_wood_single_crate_war_chunks"];
  var_04 = ["mp_raids_bulge_tank_crates_group_a_01b_start", "mp_raids_bulge_tank_crates_group_a_01a_start", "mp_raids_bulge_tank_crates_group_a_02b_start", "mp_raids_bulge_tank_crates_group_a_02a_start", "mp_raids_bulge_tank_crates_group_a_03b_start", "mp_raids_bulge_tank_crates_group_a_03a_start"];
  var_05 = [0, 0, 0.9, 0.9, 1.5, 1.5];
  var_06 = [0.05, 0.05, 1.05, 0.9, 1.45, 1.45];
  thread maps\mp\mp_raid_bulge_aud::func_97B6();
  func_08B5(75);
  foreach(var_08 in var_00) {
    if(var_08.var_3A == "script_brushmodel") {
      var_08 lib_0502::func_7997();
      continue;
    }

    if(var_08.var_3A == "script_model") {
      if(var_08.var_165 == "delete") {
        var_08 lib_0502::func_7997();
        continue;
      }

      var_09 = var_08.var_81E1;
      var_0A = var_03[var_09];
      var_0B = var_04[var_09];
      var_0C = var_05[var_09];
      var_0D = var_06[var_09];
      var_08 thread func_9E00(var_0A, var_0B, var_0C, var_0D);
    }
  }
}

func_A6B3() {
  var_00 = getEntArray("bridge_push_pile", "targetname");
  var_01 = 0;
  if(!var_01) {
    level waittill("bridge_pile_push");
  }

  func_A47C();
  var_05 = 1;
  var_06 = undefined;
  foreach(var_08 in var_00) {
    if(var_05) {
      var_05 = 0;
      var_06 = var_08.var_116;
      lib_04F3::func_79CB("blg_watchtower_hit", var_08.var_116);
    }

    var_08 lib_0502::func_7997();
  }

  if(isDefined(var_06)) {
    physicsexplosionsphere(var_06, 360, 360, 1);
  }
}

func_0898() {
  var_00 = getent("m1919_bucket", "targetname");
  var_01 = [];
  if(isDefined(var_00)) {
    var_00 setdefaultdroppitch(-45);
    var_00.var_5DBC = 1;
    var_01 = getEntArray(var_00.var_1A2, "targetname");
  }

  if(var_01.size != 0) {
    foreach(var_03 in var_01) {
      if(var_03.var_3A == "trigger_use_touch") {
        thread lib_0502::isteleportenabled(var_03, game["defenders"], var_00);
        if(isDefined(var_03.var_9EDD)) {
          var_03.var_9EDD thread lib_0504::func_9F9B(game["defenders"]);
        }
      }
    }
  }
}

blowuptank_handletank3toofarforward() {
  if(self.var_383C.var_695A != "tank_escort_3") {
    return;
  }

  var_00 = -5700;
  if(self.var_116[0] > var_00) {
    self.var_383C.var_79AD lib_04FF::func_3845("reverse");
    while(self.var_116[0] > var_00) {
      wait 0.05;
    }
  }
}

func_180B() {
  var_00 = [];
  if(isDefined(self.var_3850)) {
    var_01 = self.var_3850 lib_0502::func_207F();
    if(isDefined(var_01)) {
      var_02 = var_01 lib_0502::func_207D("vehicle");
      if(var_02.size > 0) {
        var_00 = var_02[0] lib_0502::func_207D("turret_trigger");
      }
    }
  }

  if(isDefined(self.var_3850)) {
    self.var_3850 delete();
  }

  common_scripts\utility::func_F71(var_00, ::delete);
  if(isDefined(self.var_9EDD)) {
    var_03 = self.var_9EDD method_80E2();
    if(isDefined(var_03)) {
      var_03 method_85E9();
    }

    self.var_9EDD maps\mp\_utility::func_871D();
  }

  if(isDefined(self.var_383C) && isDefined(self.var_383C.var_79AD)) {
    self.var_383C.var_79AD.var_6906 = 1;
  }

  blowuptank_handletank3toofarforward();
  self method_8281(0);
  self.var_1809 = 1;
  lib_0502::func_7D03(self);
  thread func_A46C();
}

func_A46C() {
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_zone2_side_r_damage_2_heavysmoke"), self, "tag_tread_zone_r");
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_zone2_side_r_damage_2_heavysmoke"), self, "right_wheel_02_jnt");
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_zone2_side_r_damage_2_heavysmoke"), self, "right_wheel_10_jnt");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_zone1_side_l_damage_2_heavysmoke"), self, "left_wheel_02_jnt");
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_zone1_side_l_damage_2_heavysmoke"), self, "left_wheel_04_jnt");
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_zone1_side_l_damage_2_heavysmoke"), self, "left_wheel_08_jnt");
  playFXOnTag(common_scripts\utility::func_44F5("vehicle_tank_engine_damage_2_heavysmoke"), self, "tag_engine");
}

func_97E0(param_00) {
  var_01 = getent("bulge_multi_escort_watchtower", "targetname");
  var_02 = getent("bulge_multi_escort_watchtower_tarp", "targetname");
  var_01 setModel("tkn_watchtower_01_destroyed");
  var_02 lib_0502::func_7997();
  func_08B5(65);
}

func_97E1(param_00) {
  var_01 = getent("bulge_fuel_dump_watchtower", "targetname");
  var_01 setModel("tkn_watchtower_01_destroyed");
  func_08B5(60);
}

func_97DF(param_00) {
  level notify("bridge_pile_push");
}

func_97DE(param_00) {
  var_01 = common_scripts\utility::func_46B5(param_00, "script_linkname");
  var_02 = var_01.var_1A5;
  if(isDefined(var_02)) {
    switch (var_02) {
      case "watchtower_1":
        level thread func_97E0(var_01);
        break;

      case "watchtower_2":
        level thread func_97E1(var_01);
        break;

      case "bridge_pile":
        level thread func_97DF(var_01);
        break;
    }
  }
}

func_7FCD() {
  level endon("game_ended");
  maps\mp\_utility::func_3FA5("intro_vo_complete");
  maps\mp\gametypes\_hostmigration::func_A6F5(randomfloatrange(10, 20));
  var_00 = undefined;
  for(;;) {
    var_01 = 1;
    if(level.var_79AE.var_8DB.size != 0 && !common_scripts\utility::func_562E(level.var_79C2.var_6980)) {
      var_02 = func_8A42(level.var_79AE.var_8DB[0].var_695A);
      var_03 = 0;
      foreach(var_05 in var_02) {
        var_03 = var_03 + var_05.laststand_enter_levelspecificaction;
      }

      var_07 = common_scripts\utility::func_7A33(["allies", "axis"]);
      var_08 = randomfloat(var_03);
      var_09 = undefined;
      while(!isDefined(var_09)) {
        foreach(var_05 in var_02) {
          var_08 = var_08 - var_05.laststand_enter_levelspecificaction;
          if(var_08 < 0) {
            var_09 = var_05;
            break;
          }
        }

        if(isDefined(var_00) && var_09.var_7B79 == var_00.var_7B79 && common_scripts\utility::func_562E(var_09.var_6739)) {
          var_09 = undefined;
        }
      }

      var_00 = var_09;
      var_0F = undefined;
      if(var_09.var_7B79 == "airstrike") {
        if(level.var_79AE.var_8DB[0].var_695A == "farm_hardpoint") {
          var_10 = (0, randomfloatrange(-30, 0), 0);
          var_11 = spawnStruct();
          var_11.var_61BC = 30;
          var_11.var_6076 = 120;
          var_12 = spawnStruct();
          var_12.var_61BC = 210;
          var_12.var_6076 = 300;
          var_0F = [var_11, var_12];
        } else {
          var_10 = (0, randomfloatrange(0, 30), 0);
          var_11 = spawnStruct();
          var_12.var_61BC = 60;
          var_12.var_6076 = 150;
          var_12 = spawnStruct();
          var_12.var_61BC = 240;
          var_12.var_6076 = 330;
          var_0F = [var_11, var_12];
        }
      } else {
        var_10 = (0, randomfloatrange(-60, 60), 0);
      }

      if(var_07 == "axis") {
        var_10 = var_10 + (0, 180, 0);
      }

      var_13 = lib_0500::func_4678(var_09.var_689D, var_09.var_7B79, var_07, var_10, var_0F);
      lib_0500::func_1E8A(var_09.var_7B79, var_07, var_13);
      var_01 = 14;
      switch (level.var_79AE.var_8DB[0].var_695A) {
        case "tank_escort_3":
        case "tank_escort_2":
        case "escort_tanks":
        case "tank_escort_1":
          var_01 = var_01 + 6 + randomfloat(8);
          break;

        case "tank_refuel":
          var_01 = var_01 + 4 + randomfloat(7);
          break;

        case "bridge_escort":
          var_01 = 360;
          break;

        default:
          break;
      }
    }

    maps\mp\gametypes\_hostmigration::func_A6F5(var_01);
  }
}

func_8A42(param_00) {
  var_01 = 1;
  var_02 = 1;
  switch (param_00) {
    case "tank_escort_3":
    case "tank_escort_2":
    case "escort_tanks":
    case "tank_escort_1":
      var_01 = 0.8;
      var_02 = 0.6;
      break;

    case "tank_refuel":
      var_01 = 0.9;
      var_02 = 0.75;
      break;

    case "bridge_escort":
      var_01 = 1;
      var_02 = 0.9;
      break;

    default:
      break;
  }

  var_03 = [];
  var_04 = spawnStruct();
  var_04.laststand_enter_levelspecificaction = 1.6 * var_01;
  var_04.var_689D = 3;
  var_04.var_7B79 = "mortar_strike";
  var_03[var_03.size] = var_04;
  var_05 = spawnStruct();
  var_05.laststand_enter_levelspecificaction = 1.411765 * var_02;
  var_05.var_689D = 1;
  var_05.var_7B79 = "missile_strike";
  var_03[var_03.size] = var_05;
  var_06 = 0;
  foreach(var_08 in var_03) {
    var_06 = var_06 + var_08.laststand_enter_levelspecificaction;
  }

  return var_03;
}

func_7FA1() {
  var_00 = getEntArray("misc_turret_flak88", "classname");
  common_scripts\utility::func_FB2(var_00, ::func_3CD8);
}

func_3CD8() {
  thread func_3CD9();
  if(isDefined(self.var_1A2)) {
    var_00 = getent(self.var_1A2, "targetname");
    if(isDefined(var_00)) {
      var_00 linkto(self, "tag_yaw");
    }
  }

  thread func_3CDD();
}

func_3CD9() {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("player_spawned", var_00);
    self disableplayeruse(var_00);
  }
}

func_3CDD() {
  if(!isDefined(level.var_3CE5)) {
    level.var_3CE5 = common_scripts\utility::func_46B7("turret_target", "script_noteworthy");
    if(isDefined(level.var_3CE5) && level.var_3CE5.size) {
      level.var_3CE6 = 0;
      level.var_3CE4 = randomint(level.var_3CE5.size);
      level thread func_3CDB();
    }
  }

  if(!isDefined(level.var_3CE5)) {
    return;
  }

  var_00 = level.var_3CE5[level.var_3CE4].var_116;
  var_01 = spawnStruct();
  var_01.var_116 = var_00;
  self setturrettargetorigin(var_01.var_116);
  thread func_3CDA(var_01);
  thread func_3CDC(var_01);
}

func_3CDB() {
  self endon("death");
  for(;;) {
    maps\mp\gametypes\_hostmigration::func_A6F5(randomintrange(20, 30));
    level.var_3CE4 = randomint(level.var_3CE5.size);
  }
}

func_3CDC(param_00) {
  self endon("death");
  for(;;) {
    var_01 = level.var_3CE5[level.var_3CE4].var_116;
    if(common_scripts\utility::func_562E(self.var_9827)) {
      var_01 = self.var_116 + anglesToForward(self.var_1D) * 200 + (0, 0, 400);
      level.var_3CE6 = 0;
    }

    if(distancesquared(param_00.var_116, var_01) > 1) {
      if(gettime() > level.var_3CE6) {
        param_00.var_116 = var_01;
        self setturrettargetorigin(param_00.var_116);
        level.var_3CE6 = gettime() + randomintrange(800, 1200);
      }
    }

    common_scripts\utility::func_A71A(randomfloatrange(0.2, 0.4), "tank_targeting_ent");
  }
}

func_3CDA(param_00) {
  self endon("death");
  maps\mp\gametypes\_hostmigration::func_A6F5(randomfloatrange(1, 8));
  for(;;) {
    var_01 = self gettagangles("tag_aim");
    var_02 = param_00.var_116 - self gettagorigin("tag_aim");
    var_03 = vectortoangles(var_02);
    var_04 = anglesdelta(var_01, var_03);
    if(var_04 > 5) {
      wait(randomfloatrange(0.2, 0.5));
      continue;
    }

    self method_80E1(1);
    maps\mp\gametypes\_hostmigration::func_A6F5(randomfloatrange(6, 12));
  }
}