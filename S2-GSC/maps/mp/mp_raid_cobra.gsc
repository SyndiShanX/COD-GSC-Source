/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_cobra.gsc
*********************************************/

func_00F9() {
  lib_04B7::func_F9();
  lib_041E::func_F9();
  lib_04B6::func_F9();
  maps\mp\_audio_submixes::func_524C();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_cobra_lighting::func_F9();
  maps\mp\mp_raid_cobra_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_cobra");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_raid_cobra_osp";
  level.var_6C5E = "mp_raid_cobra_osp";
  level.var_3445 = "mp_raid_cobra_drone";
  level.var_343A = "mp_raid_cobra_drone";
  level.var_A853 = "mp_raid_cobra_warbird";
  level.var_A852 = "mp_raid_cobra_warbird";
  level.var_6514 = 0;
  level.var_75EE = 7;
  level.overridemaxagents = getdvarint("scr_default_maxagents");
  level.var_1BB7 = ::func_1BB7;
  level thread func_1BB8();
  level.var_7919 = ::maps\mp\mp_raid_cobra_vo::func_A617;
  level.modeltoanimrefmapfunc = ::modeltoanimrefmapfunc;
  if(!isDefined(level.var_A3FB)) {
    level.var_A3FB = [];
  }

  level.var_A3FB["aimAtTarget"] = ::func_97DC;
  level.var_A3FB["canFireAtTarget"] = ::func_9786;
  level.var_611["b17_large_flame"] = loadfx("vfx/map/mp_raid_cobra/b17_large_flame");
  level.var_611["us_tank_sherman_player_muzzle"] = loadfx("vfx/muzzleflash/us_tank_sherman_player_muzzle");
  level.var_611["raid_flak88_death"] = loadfx("vfx/map/mp_raid_cobra/raid_flak88_death");
  level.var_611["raid_flak88_flash"] = loadfx("vfx/map/mp_flak/mp_flak88_flash");
  level.var_611["raid_flak88_death_smoke"] = loadfx("vfx/smoke/vehicle_destroyed_smoke_white_m");
  precachempanim("mp_raids_cobra_depot_tarp_explode");
  precachempanim("mp_raids_cobra_depot_tarp_loop");
  lib_04FF::func_86DA("town_bombplant", "onBombExplodeFunc", ::func_6BB7);
  lib_04FA::func_52FD(1);
  level.var_696E = ["farm_hardpoint", "bridge_1", "bridge_2", "town_bombplant", "tank_escort"];
  lib_0502::func_8671("raid_stop_watch_mode", 0);
  thread maps\mp\mp_raid_cobra_vo::func_5366();
  thread func_7FC0();
  thread maps\mp\mp_raid_cobra_vo::func_7FDF();
  thread func_7FCE();
  thread func_7FDB();
  thread func_7FA1();
  thread func_7F89();
  thread func_7FB3();
  thread maps\mp\mp_raid_cobra_bridge::func_D5();
  thread func_7FCD();
  thread func_7F9C();
  thread func_7FB0();
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_cobra_allies_start_player01", "mp_raids_cobra_allies_start_player02", "mp_raids_cobra_allies_start_player03", "mp_raids_cobra_allies_start_player04", "mp_raids_cobra_allies_start_player05", "mp_raids_cobra_allies_start_player06"];
  var_01 = ["vm_raids_cobra_allies_start_cam01", "vm_raids_cobra_allies_start_cam02", "vm_raids_cobra_allies_start_cam03", "vm_raids_cobra_allies_start_cam04"];
  var_02 = [::func_0BF8, ::func_0BF9, ::func_0BFA, ::func_0BFB];
  level.var_54D0["allies"].var_8F2 = "attackers";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_start", "targetname");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 25;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].var_73E6 = ::func_54D4;
  level.var_54D0["allies"].var_13B7 = ::func_54D2;
  level.var_54D0["allies"].var_6F27 = 1;
}

func_54D7() {
  var_00 = level.var_54D0["allies"].var_116;
  var_01 = level.var_54D0["allies"].var_1D;
  var_02 = level.var_54D0["allies"].var_8097;
  var_03 = getent("allies_intro_blocker", "targetname");
  if(isDefined(var_03)) {
    var_03 method_805C();
  }

  var_04 = spawn("script_model", var_00);
  var_04 setModel("vehicle_usa_trans_cckw_nophysics");
  var_04 thread lib_0502::func_8C21(game["attackers"], 0);
  var_04 method_8495("mp_raids_cobra_allies_start_truck", var_00, var_01);
  var_04 thread func_0C03("tag_wheel_back_left");
  var_04 thread func_0C03("tag_wheel_back_right");
  var_04 thread maps\mp\mp_raid_cobra_aud::func_5362(var_04, var_02);
  var_05 = spawn("script_model", var_00);
  var_05 setModel("vehicle_usa_tank_sherman_75mm_no_turret");
  var_05 thread lib_0502::func_8C21(game["attackers"], 0);
  var_05.var_56E8 = 1;
  var_05 method_8495("mp_raids_cobra_allies_start_tank", var_00, var_01);
  var_05 thread func_0C01("tag_wheel_front_left");
  var_05 thread func_0C01("tag_wheel_front_right");
  var_05 thread func_0C01("tag_wheel_back_left");
  var_05 thread func_0C01("tag_wheel_back_right");
  var_05 thread maps\mp\mp_raid_cobra_aud::func_535D(var_05);
  var_06 = spawn("script_model", var_00);
  var_06 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_06 thread lib_0502::func_8C21(game["attackers"], 0);
  var_06 method_8449(var_05, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_07 = spawn("script_model", var_00);
  var_07.var_267E = [1, 1, 1, 0, 0, 0];
  var_07 setcostumemodels(var_07.var_267E, "allies");
  var_07 method_8495("mp_raids_cobra_allies_start_driver", var_00, var_01);
  var_07 thread lib_0502::func_8C21(game["attackers"], 0);
  var_08 = spawn("script_model", var_00);
  var_08.var_267E = [6, 1, 6, 6, 6, 0];
  var_08 setcostumemodels(var_08.var_267E, "allies");
  var_08 method_8495("mp_raids_cobra_allies_start_commander", var_00, var_01);
  var_08 thread lib_0502::func_8C21(game["attackers"], 0);
  level.var_C6F = spawnStruct();
  level.var_C6F.var_543A = var_03;
  level.var_C6F.var_9DDD = var_04;
  level.var_C6F.var_9600 = var_05;
  level.var_C6F.var_97F3 = var_06;
  level.var_C6F.var_33F3 = var_07;
  level.var_C6F.var_253D = var_08;
}

func_0C04(param_00) {
  common_scripts\utility::func_A70C(self, "death", level, "truck_finished");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_0C03(param_00) {
  level endon("truck_finished");
  self endon("death");
  var_01 = spawnlinkedfx(common_scripts\utility::func_44F5("tank_tread_dust"), self, param_00);
  var_01 thread lib_0502::func_8C21(game["attackers"], 0);
  thread func_0C04(var_01);
  for(;;) {
    triggerfx(var_01);
    wait(0.4);
  }
}

func_0C02(param_00) {
  common_scripts\utility::func_A70C(self, "death", level, "game_ended");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_0C01(param_00) {
  level endon("game_ended");
  self endon("death");
  var_01 = spawnlinkedfx(common_scripts\utility::func_44F5("tank_tread_dust"), self, param_00);
  var_01 thread lib_0502::func_8C21(game["attackers"], 0);
  thread func_0C02(var_01);
  for(;;) {
    triggerfx(var_01);
    wait(0.2);
  }
}

func_54D4(param_00) {
  thread maps\mp\mp_raid_cobra_aud::func_C06();
}

func_54D2(param_00, param_01) {
  self endon("death");
  var_02 = 1;
  var_03 = 1;
  var_04 = 1;
  setdvarifuninitialized("scr_introquake_dist", 100);
  setdvarifuninitialized("scr_introquake_scale", 0.25);
  setdvarifuninitialized("scr_introquake_duration", 0.4);
  for(;;) {
    self waittill(param_01, var_05);
    if(!isDefined(level.var_54D0) || !isDefined(level.var_54D0["allies"])) {
      continue;
    }

    var_06 = level.var_54D0["allies"].var_8CA7[param_00].var_721C;
    if(!isDefined(var_06)) {
      continue;
    }

    var_07 = self.var_116;
    var_08 = "step";
    if(common_scripts\utility::func_9467(var_05, "footstep_left")) {
      var_08 = function_036D(var_05, "footstep_left_");
      var_07 = self gettagorigin("J_Ankle_LE");
    } else if(common_scripts\utility::func_9467(var_05, "footstep_right")) {
      var_08 = function_036D(var_05, "footstep_right_");
      var_07 = self gettagorigin("J_Ankle_RI");
    }

    if(var_02 && var_05 == "footstep_right_land" || var_05 == "footstep_left_land") {
      var_02 = 0;
      var_09 = getdvarfloat("scr_introquake_dist", 100);
      var_0A = getdvarfloat("scr_introquake_scale", 0.25);
      var_0B = getdvarfloat("scr_introquake_duration", 0.4);
      earthquake(var_0A, var_0B, var_07, var_09);
    } else if(var_04 && var_05 == "footstep_left_land") {
      var_04 = 0;
      playFX(common_scripts\utility::func_44F5("footstep_dirt"), var_07);
    } else if(var_03 && var_05 == "footstep_right_land") {
      var_03 = 0;
    }

    switch (var_08) {
      case "step":
      default:
        lib_04F3::func_79CB("step_run_dirt", var_07);
        break;

      case "truck":
        lib_04F3::func_79CB("step_land_lt_metal_vehicle", var_07);
        common_scripts\utility::func_2CB4(0.15, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
        break;

      case "land":
        playFX(common_scripts\utility::func_44F5("footstep_dirt"), var_07);
        lib_04F3::func_79CB("step_land_hv_dirt", var_07);
        common_scripts\utility::func_2CB4(0.1, ::lib_04F3::func_79CF, "gear_rattle_crouch_drop", self);
        break;

      case "scuff":
      case "scrape":
        playFX(common_scripts\utility::func_44F5("footstep_dirt"), var_07);
        lib_04F3::func_79CB("step_scrape_dirt", var_07);
        break;
    }

    common_scripts\utility::func_2CB4(0.2, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
  }
}

func_0BF8(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.25, 120, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 1.25, 450, 2, 4, 5.5);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0BF9(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2.5, 86, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0BFA(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2.5, 45, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_0BFB(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 200, 10, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 0.25, 4000, 10, 4, 1.2);
  thread lib_0505::func_3188(param_00, var_01);
}

func_54D3() {
  var_00 = level.var_C6F.var_543A;
  var_01 = level.var_C6F.var_9600;
  var_02 = level.var_C6F.var_9DDD;
  var_03 = level.var_C6F.var_97F3;
  var_04 = level.var_C6F.var_33F3;
  var_05 = level.var_C6F.var_253D;
  level.var_C6F = undefined;
  if(isDefined(var_00) && getdvarint("trailer_disable_boundaries", 0) == 0) {
    var_00 method_805B();
  }

  var_01 maps\mp\mp_raid_cobra_aud::func_A6CC();
  var_01 maps\mp\mp_raid_cobra_aud::func_9413();
  var_01 delete();
  var_03 delete();
  var_04 delete();
  var_05 delete();
  level notify("truck_finished");
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_cobra_axis_start_player01", "mp_raids_cobra_axis_start_player02", "mp_raids_cobra_axis_start_player03", "mp_raids_cobra_axis_start_player04", "mp_raids_cobra_axis_start_player05", "mp_raids_cobra_axis_start_player06"];
  var_01 = ["mp_raids_cobra_axis_start_camera"];
  var_02 = [::func_147F];
  level.var_54D0["axis"].var_8F2 = "defenders";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_axis_intro", "targetname");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 14;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].var_13B7 = ::func_54D8;
}

func_54D8(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill(param_01, var_02);
    if(!isDefined(level.var_54D0) || !isDefined(level.var_54D0["axis"])) {
      continue;
    }

    var_03 = level.var_54D0["axis"].var_8CA7[param_00].var_721C;
    if(!isDefined(var_03)) {
      continue;
    }

    var_04 = self.var_116;
    var_05 = "step";
    if(common_scripts\utility::func_9467(var_02, "footstep_left")) {
      var_05 = function_036D(var_02, "footstep_left_");
      var_04 = self gettagorigin("J_Ankle_LE");
    } else if(common_scripts\utility::func_9467(var_02, "footstep_right")) {
      var_05 = function_036D(var_02, "footstep_right_");
      var_04 = self gettagorigin("J_Ankle_RI");
    }

    switch (var_05) {
      case "step":
      default:
        lib_04F3::func_79CB("step_run_dirt", var_04);
        break;

      case "truck":
        lib_04F3::func_79CB("step_land_lt_metal_vehicle", var_04);
        common_scripts\utility::func_2CB4(0.15, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
        break;

      case "land":
        playFX(common_scripts\utility::func_44F5("footstep_dirt"), var_04);
        lib_04F3::func_79CB("step_land_hv_dirt", var_04);
        common_scripts\utility::func_2CB4(0.1, ::lib_04F3::func_79CF, "gear_rattle_crouch_drop", self);
        break;

      case "scuff":
      case "scrape":
        playFX(common_scripts\utility::func_44F5("footstep_dirt"), var_04);
        lib_04F3::func_79CB("step_scrape_dirt", var_04);
        break;
    }

    common_scripts\utility::func_2CB4(0.2, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
  }
}

func_147F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.85, 325, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 0.85, 800, 2, 4, 9);
  thread lib_0505::func_3188(param_00, var_01);
}

func_7FB3() {
  var_00 = 12;
  var_01 = 8;
  var_02 = "plane_notify";
  var_03 = common_scripts\utility::func_46B5("anim_church_steeple", "targetname");
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

  level waittill("runBridgeObjectiveComplete");
  wait(var_01);
  var_06 = spawn("script_model", var_04);
  var_06 setModel("usa_bomber_b17_raid");
  var_06 method_8495("mp_raids_cobra_church_plane_start", var_04, var_05, var_02);
  var_06 thread func_7FB1(var_02);
  var_06 thread func_7FB2();
  var_07 = getent("church_collapse_steeple", "targetname");
  if(isDefined(var_07)) {
    var_07 delete();
  }

  var_08 = spawn("script_model", var_04);
  var_08 setModel("mp_raid_cobra_church_steeple_broken_01");
  var_08 method_8495("mp_raids_cobra_church_steeple_start", var_04, var_05);
  wait(var_00);
  var_06 notify("delete");
  wait 0.05;
  var_06 delete();
}

func_7FB2() {
  self method_808C();
  var_00 = spawn("script_origin", self.var_116);
  var_00 linkto(self, "tag_origin");
  wait 0.05;
  self method_808C();
  lib_04F3::func_79CF("b17_mid_air_expl_close", self);
  wait(0.2);
  lib_04F3::func_79CF("b17_mid_air_expl_close", self);
  wait(0.1);
  lib_04F3::func_79CF("b17_tower_by", self);
  while(function_0279(self) == 0) {
    self waittill("death");
  }

  var_00 delete();
  var_00 = undefined;
}

func_7FB1(param_00) {
  self endon("death");
  for(;;) {
    self waittill(param_00, var_01);
    switch (var_01) {
      case "start_fx":
        playFXOnTag(level.var_611["b17_large_flame"], self, "tag_origin");
        break;

      case "hit_fx":
        activateclientexploder(55);
        lib_04F3::func_79CB("b17_mid_air_expl_close", (6415.13, 859.602, 1304.13));
        common_scripts\utility::func_2CB4(0.1, ::lib_04F3::func_79CB, "b17_tower_hit", (6415.13, 859.602, 1204.13));
        break;

      case "explode_fx":
      case "end":
        stopFXOnTag(level.var_611["b17_large_flame"], self, "tag_origin");
        break;

      default:
        break;
    }
  }
}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_cobra_allieswin_cam01", "mp_raids_cobra_allieswin_cam02", "mp_raids_cobra_allieswin_cam03", "mp_raids_cobra_allieswin_cam04", "mp_raids_cobra_allieswin_camhold"];
  var_01 = [::func_6C87, ::func_6C88, ::func_6C89, ::func_6C8A, undefined];
  level.var_6C86["allies"].var_8F2 = "attackers";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_team_win", "targetname");
  level.var_6C86["allies"].var_8097 = 7;
  level.var_6C86["allies"].var_1F03 = var_00;
  level.var_6C86["allies"].var_1F05 = var_01;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
  level.var_6C86["allies"].var_1F06 = "genericprop_x3";
  level.var_6C86["allies"].var_1F08 = "j_prop_1";
}

func_6C87(param_00) {
  self method_84B4();
  self method_84B7(2, 200);
  common_scripts\utility::func_2CBE(0.5, ::method_84B7, 2, 110);
}

func_6C88(param_00) {
  self method_84B4();
  self method_84B7(5, 825);
}

func_6C89(param_00) {
  self method_84B4();
  self method_84B7(0.8, 150);
}

func_6C8A(param_00) {
  self method_84B4();
  self method_84B7(0.8, 1250);
}

func_6C8D() {
  var_00 = "vignette_notify";
  maps\mp\mp_raid_cobra_aud::func_8C36();
  var_01 = getEntArray("misc_turret_flak88", "classname");
  common_scripts\utility::func_F71(var_01, ::delete);
  var_02 = vehicle_getarray();
  foreach(var_04 in var_02) {
    if(isDefined(var_04.var_9EDD)) {
      var_04.var_9EDD method_805C();
    }

    var_04 method_805C();
  }

  var_06 = level.var_6C86["allies"].var_116;
  var_07 = level.var_6C86["allies"].var_1D;
  var_08 = ["mp_raids_cobra_allieswin_flak01", "mp_raids_cobra_allieswin_flak02", "mp_raids_cobra_allieswin_flak03", "mp_raids_cobra_allieswin_flak04", "mp_raids_cobra_allieswin_flak05"];
  var_09 = [];
  for(var_0A = 0; var_0A < 5; var_0A++) {
    var_0B = spawn("script_model", var_06);
    var_0B setModel("ger_btry_flak88_turret_up_01_mp");
    var_0B method_8495(var_08[var_0A], var_06, var_07, var_00);
    var_0B thread func_0C07(var_00);
    var_09[var_09.size] = var_0B;
  }

  var_0C = spawn("script_model", var_06);
  var_0C setModel("vehicle_usa_tank_sherman_75mm_no_turret");
  var_0C.var_56E8 = 1;
  var_0C method_8495("mp_raids_cobra_allieswin_tank", var_06, var_07, var_00);
  var_0C thread func_0C07(var_00);
  var_0C thread maps\mp\mp_raid_cobra_aud::func_535D(var_0C);
  var_0D = ["mp_raids_cobra_allieswin_plane01", "mp_raids_cobra_allieswin_plane02", "mp_raids_cobra_allieswin_plane03"];
  var_0E = [];
  for(var_0F = 0; var_0F < 3; var_0F++) {
    var_10 = spawn("script_model", var_06);
    var_10 setModel("usa_fighter_thunderbolt");
    var_10 method_8495(var_0D[var_0F], var_06, var_07);
    var_0E[var_0E.size] = var_10;
  }

  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = ["mp_raids_cobra_allieswin_allies01", "mp_raids_cobra_allieswin_allies02", "mp_raids_cobra_allieswin_allies03"];
  var_15 = ["mp_raids_cobra_allieswin_axis01", "mp_raids_cobra_allieswin_axis02", "mp_raids_cobra_allieswin_axis03", "mp_raids_cobra_allieswin_axis04", "mp_raids_cobra_allieswin_axis05", "mp_raids_cobra_allieswin_axis06"];
  var_16 = lib_0502::func_4627(game["attackers"]);
  var_16 = common_scripts\utility::func_F92(var_16);
  for(var_17 = 0; var_17 < 3; var_17++) {
    var_18 = spawn("script_model", var_06);
    var_19 = "m1garand_mp";
    if(var_17 < var_16.size && isDefined(var_16[var_17].var_267E)) {
      var_18 setcostumemodels(var_16[var_17].var_267E, "allies");
      var_19 = var_16[var_17] lib_0505::func_470D("m1garand_mp");
    } else {
      var_18 setcostumemodels([2, 1, 2, 2, 2, 0], "allies");
    }

    var_1A = spawn("weapon_" + var_19, (0, 0, 0), 1);
    var_1A linkto(var_18, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_13[var_13.size] = var_1A;
    var_18 method_8495(var_14[var_17], var_06, var_07);
    var_12[var_12.size] = var_18;
  }

  for(var_17 = 0; var_17 < 6; var_17++) {
    var_1B = spawn("script_model", var_06);
    var_1B setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
    var_1A = spawn("weapon_mp40_mp", (0, 0, 0), 1);
    var_1A linkto(var_1B, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_13[var_13.size] = var_1A;
    var_1B method_8495(var_15[var_17], var_06, var_07);
    var_11[var_11.size] = var_1B;
  }

  level.var_C70 = spawnStruct();
  level.var_C70.var_9F96 = var_09;
  level.var_C70.var_3AAD = var_0E;
  level.var_C70.var_C71 = var_12;
  level.var_C70.var_148D = var_11;
  level.var_C70.var_A9E7 = var_13;
  level waittillmatch("4", "camRigCut");
  var_0C maps\mp\mp_raid_cobra_aud::func_9413();
  var_0C delete();
  var_0E[0] common_scripts\utility::func_2CB4(0.3666, ::lib_04F3::func_79CF, "p47_flyby_left", var_0E[0]);
  var_0E[1] common_scripts\utility::func_2CB4(0.6666, ::lib_04F3::func_79CF, "p47_flyby", var_0E[1]);
  var_0E[2] common_scripts\utility::func_2CB4(0.8766, ::lib_04F3::func_79CF, "p47_flyby_right", var_0E[2]);
}

func_6C8B() {
  var_00 = level.var_C70.var_9F96;
  var_01 = level.var_C70.var_3AAD;
  var_02 = level.var_C70.var_C71;
  var_03 = level.var_C70.var_148D;
  var_04 = level.var_C70.var_A9E7;
  level.var_C70 = undefined;
  common_scripts\utility::func_F71(var_04, ::delete);
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
}

func_0C07(param_00) {
  self endon("death");
  for(;;) {
    self waittill(param_00, var_01);
    switch (var_01) {
      case "hit_fx":
        playFXOnTag(common_scripts\utility::func_44F5("raid_flak88_death"), self, "tag_brass");
        lib_04F3::func_79CF("flak88_explo", self, "tag_brass");
        break;

      case "fire_artillery":
        playFXOnTag(common_scripts\utility::func_44F5("us_tank_sherman_player_muzzle"), self, "tag_flash");
        lib_04F3::func_79CF("tank_sherman_turret_fire", self, "tag_flash");
        break;

      case "switch_to_destroyed_model":
        self setModel(self.var_106 + "_destroyed");
        break;
    }
  }
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_cobra_axiswin_cam01", "mp_raids_cobra_axiswin_cam02", "mp_raids_cobra_axiswin_cam03", "mp_raids_cobra_axiswin_cam04", "mp_raids_cobra_axiswin_camhold"];
  var_01 = [::func_6C8E, ::func_6C8F, ::func_6C90, ::func_6C91, undefined];
  level.var_6C86["axis"].var_8F2 = "defenders";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_team_win", "targetname");
  level.var_6C86["axis"].var_8097 = 7;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
  level.var_6C86["axis"].var_1F06 = "genericprop_x3";
  level.var_6C86["axis"].var_1F08 = "j_prop_1";
}

func_6C8E(param_00) {
  self method_84B4();
  self method_84B7(0.6, 390);
}

func_6C8F(param_00) {
  self method_84B4();
  self method_84B7(2.9, 50);
  common_scripts\utility::func_2CBE(0.3, ::method_84B7, 2.9, 4400);
}

func_6C90(param_00) {
  self method_84B4();
  self method_84B7(0.6, 1100);
}

func_6C91(param_00) {
  self method_84B4();
  self method_84B7(0.45, 530);
}

func_6C94() {
  var_00 = "vignette_notify";
  maps\mp\mp_raid_cobra_aud::func_8C36();
  var_01 = getEntArray("misc_turret_flak88", "classname");
  common_scripts\utility::func_F71(var_01, ::delete);
  var_02 = level.var_6C86["axis"].var_116;
  var_03 = level.var_6C86["axis"].var_1D;
  var_04 = common_scripts\utility::func_46B5("anim_team_win_2", "targetname");
  if(!isDefined(var_04)) {
    return;
  }

  var_05 = var_04.var_116;
  if(!isDefined(var_05)) {
    var_05 = (0, 0, 0);
  }

  var_06 = var_04.var_1D;
  if(!isDefined(var_06)) {
    var_06 = (0, 0, 0);
  }

  var_07 = ["mp_raids_cobra_axiswin_flak01", "mp_raids_cobra_axiswin_flak02", "mp_raids_cobra_axiswin_flak03", "mp_raids_cobra_axiswin_flak04", "mp_raids_cobra_axiswin_flak05"];
  var_08 = [];
  for(var_09 = 0; var_09 < 5; var_09++) {
    var_0A = spawn("script_model", var_02);
    var_0A setModel("ger_btry_flak88_turret_up_01_mp");
    var_0A method_8495(var_07[var_09], var_02, var_03, var_00);
    var_0A thread func_1487(var_00);
    var_08[var_08.size] = var_0A;
  }

  var_0B = spawn("script_model", var_02);
  var_0B setModel("usa_bomber_b17_raid");
  var_0B method_8495("mp_raids_cobra_axiswin_plane", var_02, var_03, var_00);
  var_0B thread func_1487(var_00);
  var_0C = ["mp_raids_cobra_axiswin_farbomber01", "mp_raids_cobra_axiswin_farbomber02", "mp_raids_cobra_axiswin_farbomber03"];
  var_0D = [];
  for(var_0E = 0; var_0E < 3; var_0E++) {
    var_0F = spawn("script_model", var_02);
    var_0F setModel("usa_bomber_b17_vista");
    var_0F method_8495(var_0C[var_0E], var_02, var_03);
    var_0D[var_0D.size] = var_0F;
  }

  var_10 = [];
  var_11 = [];
  var_12 = ["mp_raids_cobra_axiswin_ger01", "mp_raids_cobra_axiswin_ger02", "mp_raids_cobra_axiswin_ger03", "mp_raids_cobra_axiswin_ger04", "mp_raids_cobra_axiswin_ger05", "mp_raids_cobra_axiswin_ger06"];
  foreach(var_14 in var_12) {
    var_15 = spawn("script_model", var_05);
    var_15 setModel("mp_raid_cobra_ger_soldier");
    var_15 method_8495(var_14, var_05, var_06);
    var_16 = spawn("weapon_mp40_mp", (0, 0, 0), 1);
    var_16 linkto(var_15, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_11[var_11.size] = var_16;
    var_10[var_10.size] = var_15;
  }

  var_18 = lib_0502::func_4627(game["defenders"]);
  var_18 = common_scripts\utility::func_F92(var_18);
  var_19 = ["mp_raids_cobra_axiswin_axis01", "mp_raids_cobra_axiswin_axis02", "mp_raids_cobra_axiswin_axis03", "mp_raids_cobra_axiswin_axis04", "mp_raids_cobra_axiswin_axis05", "mp_raids_cobra_axiswin_axis06"];
  var_1A = [];
  var_1B = [];
  for(var_1C = 0; var_1C < 6; var_1C++) {
    var_1D = spawn("script_model", var_02);
    if(var_1C < var_18.size) {
      var_1D setcostumemodels(var_18[var_1C].var_267E, "axis");
      var_1E = var_18[var_1C] lib_0505::func_470D("m1garand_mp");
      var_1F = "weapon_" + var_1E;
      var_20 = spawn(var_1F, (0, 0, 0), 1);
      var_20 linkto(var_1D, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_1B[var_1B.size] = var_20;
    } else {
      var_1D setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
      var_20 = spawn("weapon_mp40_mp", (0, 0, 0), 1);
      var_20 linkto(var_1D, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_1B[var_1B.size] = var_20;
    }

    var_1D method_8495(var_19[var_1C], var_02, var_03);
    var_1A[var_1A.size] = var_1D;
  }

  var_21 = [];
  var_22 = ["mp_raids_cobra_axiswin_truck01", "mp_raids_cobra_axiswin_truck02", "mp_raids_cobra_axiswin_truck03"];
  foreach(var_24 in var_22) {
    var_25 = spawn("script_model", var_05);
    var_25 setModel("vehicle_ger_trans_opel_blitz");
    var_25 method_8495(var_24, var_05, var_06);
    var_21[var_21.size] = var_25;
  }

  var_27 = "mp_raids_cobra_axiswin_driver";
  var_28 = spawn("script_model", var_05);
  var_28 setModel("mp_raid_cobra_ger_soldier");
  var_28 method_8495(var_27, var_05, var_06);
  var_29 = "mp_raids_cobra_axiswin_tank01";
  var_2A = spawn("script_model", var_05);
  var_2A setModel("vehicle_ger_tank_king_tiger");
  var_2A.var_56E8 = 1;
  var_2A method_8495(var_29, var_05, var_06);
  playFXOnTag(common_scripts\utility::func_44F5("tank_tread_dust_mp_vin"), var_2A, "tag_wheel_back_left");
  playFXOnTag(common_scripts\utility::func_44F5("tank_tread_dust_mp_vin"), var_2A, "tag_wheel_back_right");
  level.var_148C = spawnStruct();
  level.var_148C.var_9F96 = var_08;
  level.var_148C.var_18D7 = var_0B;
  level.var_148C.var_18E9 = var_0D;
  level.var_148C.var_8F0A = var_10;
  level.var_148C.var_A9E7 = var_11;
  level.var_148C.var_732F = var_1A;
  level.var_148C.var_73A5 = var_1B;
  level.var_148C.var_9E03 = var_21;
  level.var_148C.var_33F3 = var_28;
  level.var_148C.var_9600 = var_2A;
}

func_6C92() {
  var_00 = level.var_148C.var_9F96;
  var_01 = level.var_148C.var_18D7;
  var_02 = level.var_148C.var_18E9;
  var_03 = level.var_148C.var_8F0A;
  var_04 = level.var_148C.var_A9E7;
  var_05 = level.var_148C.var_732F;
  var_06 = level.var_148C.var_73A5;
  var_07 = level.var_148C.var_9E03;
  var_08 = level.var_148C.var_33F3;
  var_09 = level.var_148C.var_9600;
  level.var_148C = undefined;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_04, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  common_scripts\utility::func_F71(var_06, ::delete);
  common_scripts\utility::func_F71(var_05, ::delete);
  common_scripts\utility::func_F71(var_07, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  var_08 delete();
  var_01 delete();
  var_09 delete();
}

func_1487(param_00) {
  self endon("death");
  for(;;) {
    self waittill(param_00, var_01);
    thread func_1488(param_00, var_01);
  }
}

func_1488(param_00, param_01) {
  self endon("death");
  switch (param_01) {
    case "hit_fx":
      playFXOnTag(common_scripts\utility::func_44F5("b17_vin_flak"), self, "tag_origin");
      playFXOnTag(common_scripts\utility::func_44F5("raid_flak88_death"), self, "tag_origin");
      playFXOnTag(common_scripts\utility::func_44F5("b17_large_flame"), self, "tag_origin");
      playFXOnTag(common_scripts\utility::func_44F5("b17_crash_wing_effect"), self, "J_Wing_Dest_LE");
      lib_04F3::func_79CF("b17_mid_air_expl_close", self, "tag_origin");
      lib_04F3::func_79CF("b17_death_fall", self, "tag_origin");
      wait(2.333);
      playFX(common_scripts\utility::func_44F5("raid_b17_plane_impact_expl"), self gettagorigin("tag_origin"));
      break;

    case "fire_artillery":
      playFXOnTag(common_scripts\utility::func_44F5("raid_flak88_flash"), self, "tag_flash");
      lib_04F3::func_79CB("flak88_fire", self gettagorigin("tag_flash") + (0, 0, 8));
      break;

    default:
      break;
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
        case "farm_hardpoint":
          var_01 = var_01 + 6 + randomfloat(8);
          break;

        case "bridge_2":
        case "bridge_1":
          var_01 = var_01 + 4 + randomfloat(7);
          break;

        case "town_bombplant":
          var_01 = var_01 + 2 + randomfloat(6);
          break;

        case "tank_escort":
          var_01 = var_01 + randomfloat(5);
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
  var_03 = 1;
  if(param_00 == "farm_hardpoint") {
    var_01 = 0.8;
    var_02 = 0.6;
    var_03 = 0.4;
  } else if(param_00 == "bridge_1" || param_00 == "bridge_2") {
    var_01 = 0.9;
    var_02 = 0.75;
    var_03 = 0.6;
  } else if(param_00 == "town_bombplant") {
    var_01 = 1;
    var_02 = 0.9;
    var_03 = 0.8;
  }

  var_04 = [];
  var_05 = spawnStruct();
  var_05.laststand_enter_levelspecificaction = 2.285714;
  var_05.var_689D = 1;
  var_05.var_7B79 = "fighter_strike";
  var_04[var_04.size] = var_05;
  var_06 = spawnStruct();
  var_06.laststand_enter_levelspecificaction = 1.6 * var_01;
  var_06.var_689D = 3;
  var_06.var_7B79 = "mortar_strike";
  var_04[var_04.size] = var_06;
  var_07 = spawnStruct();
  var_07.laststand_enter_levelspecificaction = 1.411765 * var_02;
  var_07.var_689D = 1;
  var_07.var_7B79 = "missile_strike";
  var_04[var_04.size] = var_07;
  var_08 = spawnStruct();
  var_08.laststand_enter_levelspecificaction = 1 * var_03;
  var_08.var_689D = 1;
  var_08.var_7B79 = "airstrike";
  var_08.var_6739 = 1;
  var_04[var_04.size] = var_08;
  var_09 = 0;
  foreach(var_0B in var_04) {
    var_09 = var_09 + var_0B.laststand_enter_levelspecificaction;
  }

  return var_04;
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

func_7FC0() {
  level endon("game_ended");
  common_scripts\utility::func_FB2(getEntArray("town_bombplant_show", "targetname"), ::lib_0502::func_7997);
  waittillframeend;
  var_00 = func_7F9E();
  lib_0502::func_7B35();
  lib_0502::func_86DE(lib_0501::func_4647("useHoldBuild_objectiveTime"), 2);
  func_7F8B();
  lib_0502::func_7B35();
  lib_0502::func_86DE(lib_0501::func_4647("bomb_objectiveTime"), 3);
  childthread func_4A69();
  var_00 = func_7FD9();
  lib_0502::func_7B35();
  lib_0502::func_86DE(lib_0501::func_4647("escort_objectiveTime"), 4);
  func_7FD1(var_00);
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

func_7F9E() {
  level notify("runFarmObjective");
  if(level.var_6514) {
    lib_04FF::func_6972("farm_bombplant");
  }

  lib_04FF::func_6972("farm_hardpoint");
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_0502::func_86DE(lib_0501::func_4647("capture_objectiveTime"), 1);
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 4);
  var_00 = lib_0502::func_6514();
  var_00 thread lib_0502::func_6517("farm_hardpoint", ::lib_04FF::func_6982, "farm_hardpoint");
  if(level.var_6514) {
    var_00 thread lib_0502::func_6517("farm_bombplant", ::lib_04FF::func_6982, "farm_bombplant");
  }

  var_01 = getEntArray("farm_bombplant_show", "targetname");
  foreach(var_03 in var_01) {
    var_03 method_805C();
  }

  var_05 = var_00 lib_0502::func_6516();
  if(var_05 == "farm_bombplant") {
    lib_04FF::func_6935("farm_hardpoint");
    var_06 = getEntArray("farm_bombplant_delete", "targetname");
    foreach(var_03 in var_06) {
      var_03 delete();
    }

    foreach(var_03 in var_01) {
      var_03 method_805B();
    }
  } else if(var_05 == "farm_hardpoint") {
    if(level.var_6514) {
      lib_04FF::func_6935("farm_bombplant");
    }
  } else {}

  level notify("runFarmObjectiveComplete", var_05);
  level thread lib_0500::func_1E85(game["defenders"], 15, "farm_hardpoint");
  return var_05;
}

func_7F8B() {
  level notify("runBridgeObjective");
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 5);
  lib_04FF::func_6972("bridge_1");
  lib_04FF::func_6982("bridge_1");
  lib_04FF::func_6972("bridge_2");
  lib_04FF::func_6982("bridge_2");
  level thread lib_0500::func_1E85(game["defenders"], 15, "bridge_2");
  level notify("runBridgeObjectiveComplete");
}

func_4A69() {
  level.var_97C5[0] lib_0502::func_93FE();
  level common_scripts\utility::func_A71A(40, "raidTownObjectiveComplete");
  level.var_97C5[0] thread lib_0502::func_2FC4();
}

func_6BB7(param_00, param_01) {
  var_02 = getEntArray("town_bombplant_delete", "targetname");
  common_scripts\utility::func_FB2(var_02, ::func_9B74);
  var_03 = getEntArray("town_bombplant_show", "targetname");
  common_scripts\utility::func_FB2(var_03, ::func_9B75);
  var_04 = getEntArray("town_bombplant_swap", "targetname");
  common_scripts\utility::func_FB2(var_04, ::func_9B76);
  thread func_9B78();
}

func_9B78() {
  var_00 = getent("town_bombplant_tarp", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_00 setModel("mp_raid_cobra_supply_depot_tarp_01");
  var_00 scriptmodelplayanim("mp_raids_cobra_depot_tarp_explode");
  var_01 = getanimlength(%mp_raids_cobra_depot_tarp_explode);
  wait(var_01);
  var_00 scriptmodelplayanim("mp_raids_cobra_depot_tarp_loop");
}

func_9B77() {
  if(!isDefined(self.var_106)) {
    return;
  }

  var_00 = 1;
  var_01["ger_wagon_supply_01"] = var_00;
  var_01["ger_wagon_supply_tarp_01"] = var_00;
  var_01["mp_raid_cobra_ammo_stack_01"] = var_00;
  var_01["mp_raid_cobra_ammo_stack_dest_01"] = var_00;
  var_02 = 0.85;
  var_01["mp_raid_cobra_ammo_stack_02"] = var_02;
  var_01["mp_raid_cobra_ammo_stack_dest_02"] = var_02;
  var_03 = 0.65;
  var_01["mp_raid_cobra_ammo_stack_03"] = var_03;
  var_01["mp_raid_cobra_ammo_stack_dest_03"] = var_03;
  var_04 = var_01[self.var_106];
  if(!isDefined(var_04)) {
    return;
  }

  wait(var_04);
}

func_9B74() {
  func_9B77();
  self delete();
}

func_9B75() {
  func_9B77();
  lib_0502::func_79C6();
}

func_9B76() {
  var_00["ger_wagon_supply_01"] = "ger_wagon_supply_01_burned";
  func_9B77();
  self setModel(var_00[self.var_106]);
}

func_7FD9(param_00) {
  level notify("runAAGunObjective", param_00);
  lib_0502::func_697F("ammoDepotObjective");
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 6);
  lib_04FF::func_6972("town_bombplant");
  if(level.var_6514) {
    lib_04FF::func_6972("town_destruction");
  }

  var_01 = lib_0502::func_6514();
  var_01 thread lib_0502::func_6517("town_bombplant", ::lib_04FF::func_6982, "town_bombplant");
  if(level.var_6514) {
    var_01 thread lib_0502::func_6517("town_destruction", ::lib_04FF::func_6982, "town_destruction");
  }

  var_02 = var_01 lib_0502::func_6516();
  if(var_02 == "town_bombplant") {
    if(level.var_6514) {
      lib_04FF::func_6935("town_destruction");
    }

    level thread func_7FD8();
  } else if(var_02 == "town_destruction") {
    lib_04FF::func_6935("town_bombplant");
  } else {}

  level notify("raidTownObjectiveComplete", var_02);
  level thread lib_0500::func_1E85(game["defenders"], 15, "town_bombplant");
  return var_02;
}

func_7FD1(param_00) {
  setomnvar("ui_raid_objective_index_allies", 3);
  setomnvar("ui_raid_objective_index_axis", 7);
  var_01 = getEntArray("delete_for_tank_objective", "targetname");
  foreach(var_03 in var_01) {
    var_03 delete();
  }

  if(param_00 == "town_bombplant") {
    var_05 = "tank_escort";
  } else {
    var_05 = "tank_hedgerow";
  }

  lib_04FF::func_6972(var_05);
  lib_04FF::func_6982(var_05);
  level notify("raidTankObjectiveComplete");
}

func_7F89() {
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_04F4::func_863D("allies_A", "active", 5);
  lib_04F4::func_863D("axis_A", "active", 5);
  lib_04F4::func_863D("axis_B", "active", 5);
  lib_04F4::func_863D("axis_C", "active", 5);
  lib_04F4::func_863D("axis_D", "active", 5);
  lib_04F4::func_863D("axis_E", "active", 5);
  lib_04F4::func_863D("axis_F", "active", 5);
  lib_04F4::func_8BEF(["allies_A", "axis_A"]);
  level waittill("runFarmObjectiveComplete");
  level thread lib_04F4::func_9C77("allies_B", 20);
  lib_04F4::func_863D("axis_A", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
  level waittill("runBridgeObjectiveComplete");
  level thread lib_04F4::func_9C77("allies_C", 20);
  lib_04F4::func_863D("axis_B", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C", "axis_C"]);
  level waittill("raidTownObjectiveComplete");
  level thread lib_04F4::func_9C77("allies_D", 20);
  lib_04F4::func_863D("axis_C", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_D", "axis_D"]);
  level waittill("tank_checkpoint_1");
  level thread lib_04F4::func_9C77("allies_E", 20);
  lib_04F4::func_863D("axis_D", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_E", "axis_E"]);
  level waittill("tank_checkpoint_2");
  level thread lib_04F4::func_9C77("allies_F", 20);
  lib_04F4::func_863D("axis_E", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_F", "axis_F"]);
}

func_7FCE() {
  lib_0502::func_8691("A", "A", "A");
  level waittill("runFarmObjectiveComplete");
  level thread lib_0502::func_90A7("B", "Z", 20, "B", "B");
  level waittill("runBridgeObjectiveComplete");
  level thread lib_0502::func_90A7("E", undefined, 20, "E", "E");
  level waittill("raidTownObjectiveComplete");
  level thread lib_0502::func_90A7("F", undefined, 20, "F", "F");
  level waittill("tank_checkpoint_1");
  level thread lib_0502::func_90A7("G", undefined, 20, "G", "G");
  level waittill("tank_checkpoint_2");
  level thread lib_0502::func_90A7("H", undefined, 20, "H", "H");
}

func_7FDB() {
  level.var_7961 = [];
  func_08B5(10);
  wait(1);
  func_08B5(99);
  thread func_A482();
  thread func_A47F();
  thread func_A488();
  thread func_A481();
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

func_A482() {
  level waittill("runFarmObjectiveComplete");
  func_2A79([10], 0);
  func_08B5(20);
}

func_A47F() {
  level waittill("runBridgeObjectiveComplete");
  func_2A79([10, 20], 0);
  func_08B5(30);
}

func_A488() {
  level waittill("raidTownObjectiveComplete");
  func_2A79([10, 20, 30], 0);
  func_08B5(40);
}

func_A481() {
  level waittill("game_ended");
  func_2A79([10, 20, 30, 40], 0);
  func_2A79([99], 1);
}

func_7F9C() {
  level waittill("runFarmObjectiveComplete");
  level notify("tank_move_to_bridge");
  if(!isDefined(level.var_79C2.var_97C0)) {
    level.var_79C2.var_97C0 = [];
  }

  level.var_79C2.var_97C0["tank_move_to_bridge"] = 1;
  level waittill("runBridgeObjectiveComplete");
  level notify("tank_move_to_ammo_dump");
  if(!isDefined(level.var_79C2.var_97C0)) {
    level.var_79C2.var_97C0 = [];
  }

  level.var_79C2.var_97C0["tank_move_to_ammo_dump"] = 1;
}

func_7FB0() {
  level endon("runFarmObjectiveComplete");
  level endon("game_ended");
  var_00 = getent("manor_damage_trigger", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = 5;
  var_02 = 500;
  var_03 = 500;
  for(;;) {
    var_00 waittill("damage", var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    if(var_08 == "MOD_EXPLOSIVE" || var_08 == "MOD_GRENADE_SPLASH") {
      var_03 = var_03 + var_04;
      if(var_03 >= var_02) {
        common_scripts\_exploder::func_392A(19);
        var_03 = 0;
        wait(var_01);
      }
    }
  }
}

func_7FD8() {
  common_scripts\_exploder::func_392A(31);
  wait(1.5);
  common_scripts\_exploder::func_392A(32);
}

func_97DC(param_00, param_01) {
  level endon("game_ended");
  if(isDefined(self.var_9716) && common_scripts\utility::func_F79(self.var_9716, param_00)) {
    return;
  }

  if(isDefined(self.var_9696) && self.var_9696.var_1A5 == param_00) {
    self.var_9696.var_1A4.var_9827 = undefined;
    func_97B3();
    return;
  }

  self notify("stopRandomTankTargeting");
  var_02 = getEntArray(param_00, "targetname");
  var_03 = [];
  foreach(var_05 in var_02) {
    if(var_05.var_3A == "script_brushmodel") {
      var_05 delete();
      continue;
    }

    var_03[var_03.size] = var_05;
  }

  self.var_9734 = 1;
  self.var_9696 = spawnStruct();
  self.var_9696.var_1A5 = param_00;
  self.var_9696.var_1A4 = var_03[0];
  self.var_9696.var_9832 = var_03[0].var_116 + (0, 0, 75);
  self method_825B(self.var_9696.var_9832);
  self.var_9696.var_1A4 notify("tank_targeting_ent");
  self.var_9696.var_1A4.var_9827 = 1;
}

func_9786(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(self.var_9696)) {
    return;
  }

  while(isDefined(self.var_9696) && !lib_0503::func_57FA(self.var_9696.var_9832)) {
    wait 0.05;
  }

  if(!isDefined(self.var_9696)) {
    return;
  }

  lib_0503::func_3C22(self);
  self.var_9696.var_1A4 thread func_4AFA();
  if(!isDefined(self.var_9716)) {
    self.var_9716 = [];
  }

  self.var_9716[self.var_9716.size] = param_00;
  wait(0.5);
  func_97B3();
}

func_4AFA() {
  wait(0.15);
  var_00 = spawn("script_model", self.var_116);
  var_00.var_1D = self.var_1D;
  var_00 setModel(self.var_106 + "_destroyed");
  var_00 scriptmodelplayanim("ger_btry_flak88_turret_destroy", "flak88_anim");
  playFXOnTag(common_scripts\utility::func_44F5("raid_flak88_death"), var_00, "tag_brass");
  playFX(common_scripts\utility::func_44F5("raid_flak88_death_smoke"), var_00.var_116);
  lib_04F3::func_79CF("flak88_explo", var_00, "tag_pitch");
  self delete();
  level notify("tank_target_destroyed");
}

func_97B3() {
  self.var_9696 = undefined;
  self.var_9734 = 0;
  self method_825D();
}

func_1BBA(param_00, param_01) {
  var_02 = 0;
  var_03 = randomfloatrange(0.05, 0.35);
  if(isDefined(param_01) && isarray(param_01)) {
    foreach(var_05 in param_01) {
      wait(var_05);
      lib_04F3::func_79CB("wood_break_med_conc", param_00.var_116);
    }
  }
}

func_1BB4() {
  self notify("objectiveAnimNotetracks");
  self endon("objectiveAnimNotetracks");
  self endon("death");
  for(;;) {
    self waittill("breakObject", var_00);
    if(var_00 == "end") {
      self delete();
    }
  }
}

func_1BB6(param_00, param_01, param_02) {
  if(param_02 > 0) {
    wait(param_02);
  }

  param_00 setModel(level.var_1BB9[param_00.var_106]);
  param_00 method_8278(param_01, "breakObject");
  param_00 thread func_1BB4();
}

func_1BB3(param_00, param_01) {
  var_02 = undefined;
  var_03 = 0;
  switch (param_01) {
    default:
      break;

    case "mp_raids_cobra_tank_crates_group_a_01b_start":
      var_02 = [0.05];
      break;

    case "mp_raids_cobra_tank_crates_group_a_01a_start":
      var_02 = [0.05];
      break;

    case "mp_raids_cobra_tank_crates_group_a_02b_start":
      var_02 = [1.05];
      var_03 = 0.9;
      break;

    case "mp_raids_cobra_tank_crates_group_a_02a_start":
      var_02 = [0.9];
      var_03 = 0.9;
      break;

    case "mp_raids_cobra_tank_crates_group_a_03b_start":
      var_02 = [1.45];
      var_03 = 1.5;
      break;

    case "mp_raids_cobra_tank_crates_group_a_03a_start":
      var_02 = [1.45];
      var_03 = 1.5;
      break;

    case "mp_raids_cobra_tank_crates_group_b_05a_start":
      var_02 = [0.05];
      break;

    case "mp_raids_cobra_tank_crates_group_b_04a_start":
      var_02 = [0.05];
      break;

    case "mp_raids_cobra_tank_crates_group_b_04b_start":
      var_03 = 0.1;
      var_02 = [0.2];
      break;

    case "mp_raids_cobra_tank_crates_group_b_05b_start":
      var_02 = [0.2];
      var_03 = 0.1;
      break;

    case "mp_raids_cobra_tank_crates_group_b_06a_start":
      var_02 = [0.05];
      var_03 = 0.1;
      break;

    case "mp_raids_cobra_tank_crates_group_b_01b_start":
      var_02 = [0.85];
      var_03 = 0.8;
      break;

    case "mp_raids_cobra_tank_crates_group_b_01a_start":
      var_02 = [0.95];
      var_03 = 0.8;
      break;

    case "mp_raids_cobra_tank_crates_group_b_02b_start":
      var_02 = [1.85];
      var_03 = 1.7;
      break;

    case "mp_raids_cobra_tank_crates_group_b_02a_start":
      var_02 = [1.8];
      var_03 = 1.7;
      break;

    case "mp_raids_cobra_tank_crates_group_b_03a_start":
      var_02 = [3.8];
      var_03 = 1.3;
      break;

    case "mp_raids_cobra_tank_crates_group_c_02a_start":
      var_02 = [0.05];
      break;

    case "mp_raids_cobra_tank_crates_group_c_02b_start":
      var_02 = [0.85];
      var_03 = 0.7;
      break;

    case "mp_raids_cobra_tank_crates_group_c_01b_start":
      var_02 = [1.15];
      var_03 = 0.9;
      break;

    case "mp_raids_cobra_tank_crates_group_c_01a_start":
      var_02 = [1];
      var_03 = 0.9;
      break;
  }

  param_00 thread func_1BBA(param_00, var_02);
  param_00 thread func_1BB6(param_00, param_01, var_03);
}

func_1BB7(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  var_02 = [];
  foreach(var_04 in var_01) {
    if(!isDefined(var_04.var_165)) {
      continue;
    }

    switch (var_04.var_165) {
      case "delete":
        var_04 delete();
        break;

      case "animate":
        func_1BB3(var_04, level.var_1BB5[param_00][var_04.var_81E1]);
        break;

      default:
        break;
    }
  }
}

func_1BB8() {
  level.var_1BB9["dun_wood_crate_01"] = "dun_wood_single_crate_war_chunks";
  level.var_1BB9["farmtools_winebarrel_01"] = "farmtools_winebarrel_01_dirty_new_war_chunks";
  level.var_1BB9["dun_wood_palette_01"] = "dun_wood_palette_01_war_chunks";
  level.var_1BB5 = [];
  level.var_1BB5["break_objects_A"] = ["mp_raids_cobra_tank_crates_group_a_01b_start", "mp_raids_cobra_tank_crates_group_a_01a_start", "mp_raids_cobra_tank_crates_group_a_02b_start", "mp_raids_cobra_tank_crates_group_a_02a_start", "mp_raids_cobra_tank_crates_group_a_03b_start", "mp_raids_cobra_tank_crates_group_a_03a_start"];
  level.var_1BB5["break_objects_B"] = ["mp_raids_cobra_tank_crates_group_b_05a_start", "mp_raids_cobra_tank_crates_group_b_04a_start", "mp_raids_cobra_tank_crates_group_b_04b_start", "mp_raids_cobra_tank_crates_group_b_05b_start", "mp_raids_cobra_tank_crates_group_b_06a_start", "mp_raids_cobra_tank_crates_group_b_01b_start", "mp_raids_cobra_tank_crates_group_b_01a_start", "mp_raids_cobra_tank_crates_group_b_02b_start", "mp_raids_cobra_tank_crates_group_b_02a_start", "mp_raids_cobra_tank_crates_group_b_03a_start"];
  level.var_1BB5["break_objects_C"] = ["mp_raids_cobra_tank_crates_group_c_02a_start", "mp_raids_cobra_tank_crates_group_c_02b_start", "mp_raids_cobra_tank_crates_group_c_01b_start", "mp_raids_cobra_tank_crates_group_c_01a_start"];
}

modeltoanimrefmapfunc(param_00) {
  param_00["mp_raid_bridge_01_a"] = % mp_raids_bridge_assemble_a;
  param_00["mp_raid_bridge_01_b"] = % mp_raids_bridge_assemble_b;
  return param_00;
}