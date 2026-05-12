/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc2.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_raid_dlc2_precache::func_F9();
  maps\createart\mp_raid_dlc2_art::func_F9();
  maps\mp\mp_raid_dlc2_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_dlc2_lighting::func_F9();
  maps\mp\mp_raid_dlc2_aud::func_F9();
  maps\mp\_audio_submixes::func_524C();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_dlc2");
  maps\mp\_special_weapons::func_D5();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  lib_04FA::func_52FD(2);
  level.var_6C5F = "mp_raid_dlc2_osp";
  level.var_6C5E = "mp_raid_dlc2_osp";
  level.var_3445 = "mp_raid_dlc2_drone";
  level.var_343A = "mp_raid_dlc2_drone";
  level.var_A853 = "mp_raid_dlc2_warbird";
  level.var_A852 = "mp_raid_dlc2_warbird";
  level.raidclearloadoutcacheonspawn = 1;
  level.var_BC2 = [];
  level.var_75EE = 7;
  level.numfighterkillsrequired = 30;
  if(!isDefined(level.var_A3FB)) {
    level.var_A3FB = [];
  }

  level.var_A16 = 0;
  level.var_696E = ["intel_collect", "radio_hardpoint", "fighter_deathmatch", "fighter_deathmatch_attackers", "fighter_deathmatch_defenders", "end"];
  level.var_7919 = ::maps\mp\mp_raid_dlc2_vo::func_A617;
  lib_04FF::func_86DA("intel_collect", "flagPickupWeapon", "noWeapSwitch");
  lib_04FF::func_86DA("intel_collect", "flagGrenadeThrowEnabled", 0);
  lib_04FF::func_86DA("intel_collect", "flagAttachModel", "hus_intel_case_01");
  lib_04FF::func_86DA("intel_collect", "objectiveScoreGoal", 3);
  lib_04FF::func_86DA("intel_collect", "objModelDissappearsOnPickup", 1);
  lib_04FF::func_86DA("intel_collect", "useSourceTextIndex", 19);
  lib_04FF::func_86DA("intel_collect", "useDestTextIndex", 19);
  lib_04FF::func_86DA("intel_collect", "highlightDeliverZoneModel", 1);
  var_00 = lib_0501::func_4647("ctf_flagPickupTime");
  lib_04FF::func_86DA("intel_collect", "flagPickupTime", var_00);
  var_01 = lib_0501::func_4647("ctf_droppedFlagPickupTime");
  lib_04FF::func_86DA("intel_collect", "droppedFlagPickupTime", var_01);
  var_02 = lib_0501::func_4647("ctf_flagReturnTime");
  lib_04FF::func_86DA("intel_collect", "flagReturnTime", var_02);
  var_03 = lib_0501::func_4647("ctf_flagCaptureTime");
  lib_04FF::func_86DA("intel_collect", "flagCaptureTime", var_03);
  var_04 = lib_0501::func_4647("ctf_autoReturnTime");
  lib_04FF::func_86DA("intel_collect", "autoReturnTime", var_04);
  var_05 = lib_0501::func_4647("capture_time");
  lib_04FF::func_86DA("radio_hardpoint", "captureTimeSec", var_05);
  maps\mp\_utility::func_3FA3("started_vignettes", 1);
  maps\mp\_utility::func_3FA3("finished_intro_vignette_allies", 0);
  maps\mp\_utility::func_3FA3("finished_intro_vignette_axis", 0);
  runvignettes();
  thread maps\mp\mp_raid_dlc2_vo::func_5366();
  thread maps\mp\mp_raid_dlc2_vo::func_7FDF();
  thread func_7FC4();
  thread func_7FC0();
  thread func_7F89();
  thread func_7FCF();
  thread func_7F7D();
  thread func_7FB5();
  thread func_7FDB();
  thread maps\mp\gametypes\_raid_bomber::runbomberfirstframesetup();
  thread setup_window_open_close("window_church", "mp_raids_husky_churchwindow_open", "mp_raids_husky_churchwindow_close");
  thread setup_window_open_close("window_house", "mp_raids_husky_window_open", "mp_raids_husky_window_close");
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
}

func_7FC4() {}

runvignettes() {
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
  thread func_7FB4();
}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_husky_ally_intro_ally_player_01", "mp_raids_husky_ally_intro_ally_player_02", "mp_raids_husky_ally_intro_ally_player_03", "mp_raids_husky_ally_intro_ally_player_04", "mp_raids_husky_ally_intro_ally_player_05", "mp_raids_husky_ally_intro_ally_player_06"];
  var_01 = ["mp_raids_husky_ally_intro_camera_01", "mp_raids_husky_ally_intro_camera_02"];
  var_02 = [::func_0BF8, ::func_0BF9];
  level.var_54D0["allies"].var_8F2 = "attackers";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_intro", "targetname");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 25;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].var_73E6 = ::func_54D4;
  level.var_54D0["allies"].var_6F27 = 1;
}

func_0BF8(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 1400, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 3, 150, 2, 4, 4);
  var_01 = lib_0505::func_3187(var_01, 3, 250, 2, 4, 6);
  var_01 = lib_0505::func_3187(var_01, 3, 150, 2, 4, 8);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_husky_ally_intro_camera_01;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  var_03 = function_021F("axis_outro_light", "targetname");
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("lightpart", "off");
  }

  var_07 = function_021F("axis_outro_light2", "targetname");
  foreach(var_05 in var_07) {
    var_05 setscriptablepartstate("lightpart", "off");
  }

  var_0A = function_021F("allies_intro_light", "targetname");
  foreach(var_05 in var_0A) {
    var_05 setscriptablepartstate("lightpart", "on");
  }

  self method_8483("mp_raid_dlc2_allies_intro");
  level.var_A4B5["intensity"] = 0.5;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_0E in level.var_744A) {
      if(isalive(var_0E)) {
        self vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }
}

func_0BF9(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 4, 50, 8, 16, 0);
  var_01 = lib_0505::func_3187(var_01, 4, 70, 8, 16, 6);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_husky_ally_intro_camera_02;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  self method_8483("mp_raid_dlc2");
}

func_54D7() {
  var_00 = common_scripts\utility::func_46B5("anim_allies_intro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = [];
  var_04 = ["mp_raids_husky_ally_intro_axis_player_01"];
  var_05 = undefined;
  lib_0378::func_8D74("aud_intro_start_sfx");
  foreach(var_07 in var_04) {
    var_08 = "kar98_mp";
    var_09 = spawn("script_model", var_01);
    var_09 setcostumemodels([2, 1, 2, 2, 2, 1], "axis");
    var_05 = spawn("weapon_" + var_08, (0, 0, 0), 1);
    var_05 linkto(var_09, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_09 method_8495(var_07, var_01, var_02);
    var_03[var_03.size] = var_09;
  }

  var_0B = lib_0502::func_4627(game["attackers"]);
  var_0C = spawn("script_model", level.var_54D0["allies"].var_8CA7[0].var_13B3 gettagorigin("TAG_INHAND"));
  var_0C setModel("npc_gen_trench_knife_01_excellent");
  var_0C.var_1D = level.var_54D0["allies"].var_8CA7[0].var_13B3 gettagangles("TAG_INHAND");
  var_0C linkto(level.var_54D0["allies"].var_8CA7[0].var_13B3, "TAG_INHAND");
  level.introvignette_allies = spawnStruct();
  level.introvignette_allies.var_8F0A = var_03;
  level.introvignette_allies.var_5A9F = var_0C;
  level.introvignette_allies.var_1D0 = var_05;
}

func_54D4(param_00) {
  lib_0378::func_8D74("aud_intro_allies_mixing");
}

func_54D3() {
  var_00 = function_021F("cinematics_off", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on");
  }

  var_04 = function_021F("allies_intro_light", "targetname");
  foreach(var_02 in var_04) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  var_07 = level.introvignette_allies.var_5A9F;
  var_08 = level.introvignette_allies.var_8F0A;
  var_09 = level.introvignette_allies.var_1D0;
  common_scripts\utility::func_F71(var_08, ::delete);
  var_09 delete();
  var_07 delete();
  var_0A = lib_0502::func_4627(game["attackers"]);
  foreach(var_0C in var_0A) {
    var_0C method_8036(1, 0.1);
  }

  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  foreach(var_0C in var_0A) {
    var_0C vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
    var_0C setscriptmotionblurparams(0.35, 0, 0);
    var_0C lightsetforplayer("mp_raid_dlc2");
    var_0C method_8483("mp_raid_dlc2");
  }
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_husky_axis_intro_npc_03", "mp_raids_husky_axis_intro_npc_02", "mp_raids_husky_axis_intro_npc_07", "mp_raids_husky_axis_intro_npc_04", "mp_raids_husky_axis_intro_npc_05", "mp_raids_husky_axis_intro_npc_01"];
  var_01 = ["mp_raids_husky_axis_intro_camera_01", "mp_raids_husky_axis_intro_camera_02", "mp_raids_husky_axis_intro_camera_03", "mp_raids_husky_axis_intro_camera_04"];
  var_02 = [::func_147F, ::func_1480, ::func_1481, ::func_1482];
  level.var_54D0["axis"].var_8F2 = "defenders";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_axis_intro", "targetname");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 14;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].var_92D5 = ::func_54E1;
  level.var_54D0["axis"].var_2381 = ::func_54D9;
  level.var_54D0["axis"].var_73E6 = ::func_54DC;
}

func_147F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 400, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_husky_axis_intro_camera_01;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  var_03 = function_021F("axis_intro_light", "targetname");
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("lightpart", "on");
  }

  level.var_A4B5["intensity"] = 0.6;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_08 in level.var_744A) {
      if(isalive(var_08)) {
        self vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }
}

func_1480(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 30, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_husky_axis_intro_camera_02;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  self lightsetforplayer("mp_raid_dlc2_case");
}

func_1481(param_00) {
  level.introvignette_axis_data.briefcase method_805B();
  level.introvignette_axis_data.briefcase_big method_805C();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 53, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_husky_axis_intro_camera_03;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  self lightsetforplayer("mp_raid_dlc2");
}

func_1482(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.25, 400, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_husky_axis_intro_camera_04;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  self lightsetforplayer("mp_raid_dlc2");
}

func_54E1() {
  var_00 = common_scripts\utility::func_46B5("anim_axis_intro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = [];
  var_04 = ["mp_raids_husky_axis_intro_npc"];
  foreach(var_06 in var_04) {
    var_07 = "stg44_mp";
    var_08 = spawn("script_model", var_01);
    var_08 setcostumemodels([2, 3, 3, 3, 0, 0], "axis");
    var_08 animscripts\notetracks_common::give_player_xp(var_06, var_01, var_02);
    var_03[var_03.size] = var_08;
  }

  var_0A = getEntArray("objective_model", "script_noteworthy");
  common_scripts\utility::func_F71(var_0A, ::method_805C);
  var_0B = "mp_raids_husky_axis_intro_folder";
  var_0C = spawn("script_model", var_01);
  var_0C setModel("hus_german_folder_01");
  var_0C method_8495(var_0B, var_01, var_02);
  var_0D = "mp_raids_husky_axis_intro_briefcase";
  var_0E = spawn("script_model", var_01);
  var_0E setModel("par_briefcase_german_01_big");
  var_0E method_8495(var_0D, var_01, var_02);
  var_0F = "mp_raids_husky_axis_intro_briefcase";
  var_10 = spawn("script_model", var_01);
  var_10 setModel("par_briefcase_german_01_anim_dlc");
  var_10 method_8495(var_0F, var_01, var_02);
  var_10 method_805C();
  var_11 = "mp_raids_husky_axis_intro_lamp";
  var_12 = spawn("script_model", var_01);
  var_12 setModel("ger_oil_lamp_01_b_rig");
  var_12 method_8495(var_11, var_01, var_02);
  level.introvignette_axis_data = spawnStruct();
  level.introvignette_axis_data.var_8F0A = var_03;
  level.introvignette_axis_data.briefcase = var_10;
  level.introvignette_axis_data.briefcase_big = var_0E;
  level.introvignette_axis_data.lamp = var_12;
  level.introvignette_axis_data.folder = var_0C;
  level.introvignette_axis_data.objective_array = var_0A;
}

func_54DC(param_00) {
  lib_0378::func_8D74("aud_intro_axis_mixing");
}

func_54D9() {
  var_00 = level.introvignette_axis_data.var_8F0A;
  var_01 = level.introvignette_axis_data.briefcase;
  var_02 = level.introvignette_axis_data.briefcase_big;
  var_03 = level.introvignette_axis_data.lamp;
  var_04 = level.introvignette_axis_data.folder;
  var_05 = level.introvignette_axis_data.objective_array;
  var_01 delete();
  var_02 delete();
  var_03 delete();
  var_04 delete();
  common_scripts\utility::func_F71(var_00, ::delete);
  var_06 = lib_0502::func_4627(game["defenders"]);
  foreach(var_08 in var_06) {
    var_08 method_8036(1, 0.1);
  }

  var_0A = function_021F("axis_intro_light", "targetname");
  foreach(var_0C in var_0A) {
    var_0C setscriptablepartstate("lightpart", "off");
  }

  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  foreach(var_08 in var_06) {
    var_08 setscriptmotionblurparams(0.35, 0, 0);
    var_08 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
    var_08 lightsetforplayer("mp_raid_dlc2");
    var_08 method_8483("mp_raid_dlc2");
  }

  common_scripts\utility::func_F71(var_05, ::method_805B);
}

func_7FB4() {}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = [];
  var_01 = ["mp_raids_husky_ally_win_air_outro_Camera_01", "mp_raids_husky_ally_win_air_outro_Camera_02"];
  var_02 = [::func_6C87, ::func_6C88];
  level.var_6C86["allies"].var_8F2 = "attackers";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_air_outro", "targetname");
  level.var_6C86["allies"].var_73B4 = var_00;
  level.var_6C86["allies"].var_8097 = 12;
  level.var_6C86["allies"].var_1F03 = var_01;
  level.var_6C86["allies"].var_1F05 = var_02;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
  level.var_6C86["allies"].var_1F06 = "genericprop_x3";
  level.var_6C86["allies"].var_1F08 = "j_prop_1";
}

func_6C87(param_00) {
  wait 0.05;
  level.var_6465["velocityscaler"] = 2;
  level.var_6465["cameraRotationInfluence"] = 1;
  level.var_6465["cameraTranslationInfluence"] = 1;
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        var_02 setscriptmotionblurparams(2, 1, 1);
      }
    }
  }

  level.var_A4B5["intensity"] = 0.6;
  level.var_A4B5["falloff"] = 1.3;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        self vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  self lightsetforplayer("mp_raid_dlc2_air_dark");
  self method_8483("mp_raid_dlc2_air_cine");
  var_06 = [];
  var_06 = lib_0505::func_3187(var_06, 1.5, 150, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_06);
  wait(1.25);
  self lightsetforplayer("mp_raid_dlc2_air_dark_open");
}

func_6C88(param_00) {
  level.outrovignette_allies.hero_bomer method_805B();
  level.outrovignette_allies.hero_bomer_doors method_805C();
  self lightsetforplayer("mp_raid_dlc2_air_dark2");
  self method_8483("mp_raid_dlc2_air_cine");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 40, 4, 8, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C8D() {
  preoutrovignettecleanup();
  lib_0378::func_8D74("aud_allies_victory_sfx");
  level.outrovignette_allies = spawnStruct();
  var_00 = common_scripts\utility::func_46B5("anim_allies_air_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = [];
  var_04 = ["mp_raids_husky_ally_win_air_outro_ally_b17_03", "mp_raids_husky_ally_win_air_outro_ally_b17_05", "mp_raids_husky_ally_win_air_outro_ally_b17_06", "mp_raids_husky_ally_win_air_outro_ally_b17_07", "mp_raids_husky_ally_win_air_outro_ally_b17_08", "mp_raids_husky_ally_win_air_outro_ally_b17_09", "mp_raids_husky_ally_win_air_outro_ally_b17_10", "mp_raids_husky_ally_win_air_outro_ally_b17_11", "mp_raids_husky_ally_win_air_outro_ally_b17_12", "mp_raids_husky_ally_win_air_outro_ally_b17_14", "mp_raids_husky_ally_win_air_outro_ally_b17_15", "mp_raids_husky_ally_win_air_outro_ally_b17_17", "mp_raids_husky_ally_win_air_outro_ally_b17_18", "mp_raids_husky_ally_win_air_outro_ally_b17_19", "mp_raids_husky_ally_win_air_outro_ally_b17_20"];
  foreach(var_06 in var_04) {
    var_07 = spawn("script_model", var_01);
    var_07 setModel("usa_bomber_b17_raid");
    var_07 animscripts\notetracks_common::give_player_xp(var_06, var_01, var_02);
    var_03[var_03.size] = var_07;
  }

  var_09 = "mp_raids_husky_ally_win_air_outro_ally_husky_hangardoors";
  var_0A = spawn("script_model", var_01);
  var_0A setModel("vm_hus_usa_glidebomb_hatchdoors");
  var_0A animscripts\notetracks_common::give_player_xp(var_09, var_01, var_02);
  var_0B = "mp_raids_husky_ally_win_air_outro_ally_b17_hero";
  var_0C = spawn("script_model", var_01);
  var_0C setModel("usa_bomber_b17_raid");
  var_0C method_805C();
  var_0C animscripts\notetracks_common::give_player_xp(var_0B, var_01, var_02);
  var_0D = [];
  var_0E = ["mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_01", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_02", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_03", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_04", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_05", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_06", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_07", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_08", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_09", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_11", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_12", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_13", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_14", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_15", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_16", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_17", "mp_raids_husky_ally_win_air_outro_ally_carpetbomb_hero_18"];
  foreach(var_10 in var_0E) {
    var_11 = spawn("script_model", var_01);
    var_11 setModel("vm_usa_carpetbomb_m57");
    var_11 animscripts\notetracks_common::give_player_xp(var_10, var_01, var_02);
    var_0D[var_0D.size] = var_11;
  }

  level.outrovignette_allies.hero_bomer = var_0C;
  level.outrovignette_allies.hero_bomer_doors = var_0A;
  level.outrovignette_allies.ally_planes = var_03;
  level.outrovignette_allies.ally_bombs = var_0D;
}

func_6C8B() {
  var_00 = level.outrovignette_allies.ally_planes;
  var_01 = level.outrovignette_allies.hero_bomer_doors;
  var_02 = level.outrovignette_allies.hero_bomer;
  var_03 = level.outrovignette_allies.ally_bombs;
  var_01 delete();
  var_02 delete();
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  maps\mp\gametypes\_raid_bomber::stop_bomber_clouds();
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_05 in level.var_744A) {
      if(isalive(var_05)) {
        var_05 setscriptmotionblurparams(0.35, 0, 0);
      }

      var_05 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      var_05 lightsetforplayer("mp_raid_dlc2");
      var_05 method_8483("mp_raid_dlc2");
    }
  }
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_husky_axis_win_ground_outro_Camera_01", "mp_raids_husky_axis_win_ground_outro_Camera_02", "mp_raids_husky_axis_win_ground_outro_Camera_03", "mp_raids_husky_axis_win_ground_outro_Camera_04"];
  var_01 = [::func_6C8E, ::func_6C8F, ::func_6C90, ::func_6C91];
  level.var_6C86["axis"].var_8F2 = "defenders";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_intro", "targetname");
  level.var_6C86["axis"].var_8097 = 12;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
  level.var_6C86["axis"].var_1F06 = "genericprop_x3";
  level.var_6C86["axis"].var_1F08 = "j_prop_1";
}

func_6C8E(param_00) {
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        var_02 setscriptmotionblurparams(0.35, 0, 0);
      }
    }
  }

  level.var_A4B5["intensity"] = 0.5;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        self vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  var_06 = [];
  self method_8483("mp_raid_dlc2_axisoutro");
  var_06 = lib_0505::func_3187(var_06, 8, 250, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_06);
  var_07 = function_021F("axis_outro_light", "targetname");
  foreach(var_09 in var_07) {
    var_09 setscriptablepartstate("lightpart", "on");
  }

  var_0B = function_021F("allies_intro_light", "targetname");
  foreach(var_09 in var_0B) {
    var_09 setscriptablepartstate("lightpart", "off");
  }

  var_0E = function_021F("cinematics_off", "targetname");
  foreach(var_09 in var_0E) {
    var_09 setscriptablepartstate("lightpart", "off");
  }
}

func_6C8F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 220, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = function_021F("axis_outro_light2", "targetname");
  foreach(var_04 in var_02) {
    var_04 setscriptablepartstate("lightpart", "on");
  }
}

func_6C90(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 250, 4, 8, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C91(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 4, 150, 16, 32, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C94() {
  preoutrovignettecleanup();
  lib_0378::func_8D74("aud_axis_ground_victory_sfx");
  var_00 = common_scripts\utility::func_46B5("anim_allies_intro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  level.outrovignette_axis_ground = spawnStruct();
  var_03 = [];
  var_04 = [];
  var_05 = ["mp_raids_husky_axis_win_ground_outro_ally_player_01", "mp_raids_husky_axis_win_ground_outro_ally_player_02", "mp_raids_husky_axis_win_ground_outro_ally_player_03", "mp_raids_husky_axis_win_ground_outro_ally_player_04", "mp_raids_husky_axis_win_ground_outro_ally_player_05", "mp_raids_husky_axis_win_ground_outro_ally_player_06"];
  var_06 = lib_0502::func_4627(game["attackers"]);
  if(var_06.size > 0) {
    foreach(var_0B, var_08 in var_06) {
      var_09 = "stg44_mp";
      var_0A = spawn("script_model", var_01);
      var_0A setcostumemodels(var_08.var_267E, "allies");
      var_0A animscripts\notetracks_common::give_player_xp(var_05[var_0B], var_01, var_02);
      var_04[var_04.size] = var_0A;
    }
  } else {
    var_0A = spawn("script_model", var_02);
    var_0A setcostumemodels([1, 1, 1, 1, 1, 1], "allies");
    var_0A animscripts\notetracks_common::give_player_xp("mp_raids_husky_axis_win_ground_outro_ally_player_01", var_01, var_02);
    var_04[var_04.size] = var_0A;
  }

  var_0C = [];
  var_0D = ["mp_raids_husky_axis_win_ground_outro_axis_player_01", "mp_raids_husky_axis_win_ground_outro_axis_player_02", "mp_raids_husky_axis_win_ground_outro_axis_player_03", "mp_raids_husky_axis_win_ground_outro_axis_player_04", "mp_raids_husky_axis_win_ground_outro_axis_player_05", "mp_raids_husky_axis_win_ground_outro_axis_player_06", "mp_raids_husky_axis_win_ground_outro_axis_player_07", "mp_raids_husky_axis_win_ground_outro_axis_player_08", "mp_raids_husky_axis_win_ground_outro_axis_player_09", "mp_raids_husky_axis_win_ground_outro_axis_player_10", "mp_raids_husky_axis_win_ground_outro_axis_player_11"];
  foreach(var_0F in var_0D) {
    var_09 = "mp40_mp";
    var_0A = spawn("script_model", var_01);
    var_0A setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
    var_10 = spawn("weapon_" + var_09, (0, 0, 0), 1);
    var_10 linkto(var_0A, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_03[var_03.size] = var_10;
    var_0A animscripts\notetracks_common::give_player_xp(var_0F, var_01, var_02);
    var_0C[var_0C.size] = var_0A;
  }

  var_0D = ["mp_raids_husky_axis_win_ground_outro_german_commander_01", "mp_raids_husky_axis_win_ground_outro_german_commander_02"];
  foreach(var_0F in var_0D) {
    var_09 = "p38_mp";
    var_0A = spawn("script_model", var_01);
    var_0A setcostumemodels([4, 3, 3, 3, 0, 0], "axis");
    if(var_0F == "mp_raids_husky_axis_win_ground_outro_german_commander_02") {
      var_10 = spawn("weapon_" + var_09, (0, 0, 0), 1);
      var_10 linkto(var_0A, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_03[var_03.size] = var_10;
    }

    var_0A animscripts\notetracks_common::give_player_xp(var_0F, var_01, var_02);
    var_0C[var_0C.size] = var_0A;
  }

  level.outrovignette_axis_ground.axis_soldiers = var_0C;
  level.outrovignette_axis_ground.var_A9E7 = var_03;
  level.outrovignette_axis_ground.ally_soldiers = var_04;
}

func_6C92() {
  var_00 = level.outrovignette_axis_ground.axis_soldiers;
  var_01 = level.outrovignette_axis_ground.var_A9E7;
  var_02 = level.outrovignette_axis_ground.ally_soldiers;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_04 in level.var_744A) {
      if(isalive(var_04)) {
        var_04 setscriptmotionblurparams(0.35, 0, 0);
      }

      var_04 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      var_04 lightsetforplayer("mp_raid_dlc2");
      var_04 method_8483("mp_raid_dlc2");
    }
  }
}

outrovignette_axis_air_setup() {
  lib_0505::func_5325();
  var_00 = [];
  var_01 = ["mp_raids_husky_axis_win_air_outro_camera01", "mp_raids_husky_axis_win_air_outro_camera02"];
  var_02 = [::outrovignette_axis_air_cam01_func, ::outrovignette_axis_air_cam02_func];
  level.var_6C86["axis"].var_8F2 = "defenders";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_axis_air_outro", "targetname");
  level.var_6C86["axis"].var_73B4 = var_00;
  level.var_6C86["axis"].var_8097 = 12;
  level.var_6C86["axis"].var_1F03 = var_01;
  level.var_6C86["axis"].var_1F05 = var_02;
  level.var_6C86["axis"].var_92D5 = ::outrovignette_axis_air_start;
  level.var_6C86["axis"].var_2381 = ::outrovignette_axis_air_cleanup;
  level.var_6C86["axis"].var_1F06 = "genericprop_x3";
  level.var_6C86["axis"].var_1F08 = "j_prop_1";
}

outrovignette_axis_air_cam01_func(param_00) {
  level.var_6465["velocityscaler"] = 2;
  level.var_6465["cameraRotationInfluence"] = 1;
  level.var_6465["cameraTranslationInfluence"] = 1;
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        var_02 setscriptmotionblurparams(2, 1, 1);
      }
    }
  }

  level.var_A4B5["intensity"] = 0.7;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        self vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  var_06 = [];
  var_06 = lib_0505::func_3187(var_06, 0.5, 5000, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_06);
  wait 0.05;
  self lightsetforplayer("mp_raid_dlc2_air_dark2");
  self method_8483("mp_raid_dlc2_air_cine");
}

outrovignette_axis_air_cam02_func(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 600, 4, 8, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

outrovignette_axis_air_start() {
  preoutrovignettecleanup();
  lib_0378::func_8D74("aud_axis_air_victory_sfx");
  level.outrovignette_axis_air = spawnStruct();
  var_00 = common_scripts\utility::func_46B5("anim_axis_air_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = [];
  var_04 = ["mp_raids_husky_axis_win_air_outro_ally_plane01", "mp_raids_husky_axis_win_air_outro_ally_plane02"];
  foreach(var_06 in var_04) {
    var_07 = spawn("script_model", var_01);
    var_07 setModel("usa_bomber_b17_hero_dest_dlc2");
    var_07 animscripts\notetracks_common::give_player_xp(var_06, var_01, var_02);
    var_03[var_03.size] = var_07;
  }

  var_09 = [];
  var_0A = ["mp_raids_husky_axis_win_air_outro_axis_plane01", "mp_raids_husky_axis_win_air_outro_axis_plane02"];
  foreach(var_0C in var_0A) {
    var_07 = spawn("script_model", var_01);
    var_07 setModel("ger_fighter_bf109_base_clean");
    var_07 animscripts\notetracks_common::give_player_xp(var_0C, var_01, var_02);
    var_09[var_09.size] = var_07;
  }

  level.outrovignette_axis_air.ally_planes = var_03;
  level.outrovignette_axis_air.axis_planes = var_09;
}

outrovignette_axis_air_cleanup() {
  var_00 = level.outrovignette_axis_air.ally_planes;
  var_01 = level.outrovignette_axis_air.axis_planes;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  maps\mp\gametypes\_raid_bomber::stop_bomber_clouds();
  self lightsetforplayer("mp_raid_dlc2 ");
  self method_8483("mp_raid_dlc2 ");
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_03 in level.var_744A) {
      if(isalive(var_03)) {
        var_03 setscriptmotionblurparams(0.35, 0, 0);
      }

      var_03 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      var_03 lightsetforplayer("mp_raid_dlc2");
      var_03 method_8483("mp_raid_dlc2");
    }
  }
}

func_7F7D() {}

func_7FCF() {
  setgamespawnpointactivelabel("A", "A", "A");
  level waittill("intelComplete");
  level thread shiftspawnsobj2();
}

shiftspawnsobj2() {
  wait(0.1);
  level endon("objectiveComplete");
  level thread lib_0502::func_90A4("B", "B");
  maps\mp\gametypes\_hostmigration::func_A6F5(14.9);
  level thread lib_0502::func_90A4("C", "C");
}

func_7F89() {
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_04F4::func_863D("allies_A", "active", 5);
  lib_04F4::func_863D("axis_A", "active", 5);
  lib_04F4::func_863D("axis_B", "active", 5);
  lib_04F4::func_8BEF(["allies_A", "axis_A"]);
  level waittill("intelComplete");
  lib_04F4::func_863D("axis_A", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
  level thread lib_04F4::func_9C77("allies_B", 20);
}

func_7FB5() {}

func_7FDB() {}

func_7FC0() {
  waittillframeend;
  maps\mp\gametypes\_raid_bomber::bomber_reset_dvars();
  var_00 = runintelobjective();
  lib_0502::func_7B35();
  var_00 = runradioobjective();
  lib_0502::func_7B35();
  var_00 = runbomberobjective();
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

runintelobjective() {
  if(!function_0371()) {
    level.defendersrespawndelay = 4;
  }

  level notify("runObjectiveTankRefuel");
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 3);
  lib_04FF::func_6972("intel_collect");
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_0502::func_86DE(lib_0501::func_4647("ctf_objectiveTime"), 1);
  lib_04FF::func_6982("intel_collect");
  var_00 = 1;
  level notify("intelComplete");
  return var_00;
}

runradioobjective() {
  if(!function_0371()) {
    level.defendersrespawndelay = 3;
  }

  level notify("runRadioObjective");
  wait 0.05;
  lib_04FF::func_6972("radio_hardpoint");
  lib_0502::func_86DE(lib_0501::func_4647("capture_objectiveTime"), 2);
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 4);
  level thread lib_0500::func_1E85(game["defenders"], 15, "radio_hardpoint");
  var_00 = lib_0502::func_6514();
  var_00 thread lib_0502::func_6517("radio_hardpoint", ::lib_04FF::func_6982, "radio_hardpoint");
  var_01 = var_00 lib_0502::func_6516();
  level notify("runradioObjectiveComplete", var_01);
  return var_01;
}

monitorbomberraidobjective(param_00) {
  level endon("bomberObjectiveComplete");
  for(;;) {
    level waittill("fighter_downed", var_01);
    var_02 = "invalid";
    if(var_01 == game["attackers"]) {
      var_02 = "defenders";
    } else if(var_01 == game["defenders"]) {
      var_02 = "attackers";
    }

    param_00 maps\mp\gametypes\_raid_objective_deathmatch::deathmatchobjectupdatescore(var_02, -1);
  }
}

cleanupgroundentities() {
  var_00 = common_scripts\utility::func_44BE("ground_light", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 delete();
  }

  for(var_04 = 0; var_04 < 32; var_04++) {
    objective_delete(var_04);
  }
}

runbomberobjective() {
  level.forcenokillcam = 1;
  setDvar("fd_enable_fbw", 1);
  level notify("runBomberObjective");
  bomberobjectivetransition();
  bomberobjectivetakeallweapons();
  lib_04FF::func_79B3("radio_hardpoint");
  outrovignette_axis_air_setup();
  level.dlc2wardogfightactive = 1;
  level.fighters_downed = 0;
  level.alliedfightersdowned = 0;
  level.axisfightersdowned = 0;
  maps\mp\_utility::func_2CED(2, ::enable_scorestreaks);
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    thread fake_bomber_raid_ui();
  }

  if(getdvarint("fighter_vs_fighter_mode") == 1) {}

  foreach(var_01 in level.var_744A) {
    if(var_01 maps\mp\_utility::func_5727()) {
      var_01 notify("abort_killcam");
    }
  }

  function_03BB();
  cleanupgroundentities();
  function_03BF();
  wait 0.05;
  maps\mp\mp_raid_dlc2_fx::sunflare_flying();
  level thread onplayerconnectbomberobjective();
  var_03 = common_scripts\utility::func_46B5("fighter_deathmatch", "targetname");
  var_04 = getent("mp_global_intermission", "classname");
  var_04.var_1D = (0, 0, 0);
  var_04.var_116 = (-5000, 0, var_03.var_116[2]);
  maps\mp\gametypes\_raid_bomber::run_bomber_objective(var_03.var_116, "compass_map_mp_raid_dlc2_objective3");
  if(getdvarint("fighter_vs_fighter_mode") != 1) {
    setomnvar("ui_war_attacker_flipped", 1);
    setDvar("ui_war_last_obj_flipped", 1);
  }

  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  thread monitorbomberraidobjective(var_03);
  lib_04FF::func_6972("fighter_deathmatch");
  lib_0502::func_86DE(lib_0501::func_4647("deathmatch_objectiveTime"), 3);
  level.forcenokillcam = undefined;
  if(!function_0371()) {
    level.defendersrespawndelay = 4;
    level.attackersrespawndelay = 4;
  } else {
    level.defendersrespawndelay = lib_0501::func_4647("deathmatch_respawnDelay");
    level.attackersrespawndelay = lib_0501::func_4647("deathmatch_respawnDelay");
  }

  lib_04FF::func_6982("fighter_deathmatch");
  level notify("bomberObjectiveComplete");
  maps\mp\gametypes\_raid_bomber::end_bomber_objective();
  disable_scorestreaks();
  return var_03.objectivesuccess;
}

onplayerconnectbomberobjective() {
  level endon("game_ended");
  level endon("bomberObjectiveComplete");
  for(;;) {
    level waittill("connected", var_00);
    maps\mp\mp_raid_dlc2_fx::start_sunflare_flying_exploder_for_player(var_00);
  }
}

enable_scorestreaks() {
  setDvar("raid_allow_scorestreaks", 1);
  level.var_5A6F = 1;
}

disable_scorestreaks() {
  setDvar("raid_allow_scorestreaks", 0);
  level.var_5A6F = 0;
}

fake_bomber_raid_ui() {
  level endon("game_ended");
  var_00 = level.num_bombers;
  level.tempbomberui = newhudelem();
  level.tempbomberui.maxsightdistsqrd = -20;
  level.tempbomberui.var_1D7 = 120;
  level.tempbomberui.var_9B = 1.5;
  level.tempbomberui.accuracy = "left";
  level.tempbomberui.var_11 = "top";
  level.tempbomberui.var_C6 = "left";
  level.tempbomberui.var_1CA = "top";
  level.tempbomberui.ignoreme = 1;
  level.tempbomberui settext(common_scripts\utility::func_9AAD(level.num_bombers) + " of 6");
  for(;;) {
    if(level.num_bombers != var_00) {
      level.tempbomberui settext(common_scripts\utility::func_9AAD(level.num_bombers) + " of 6");
    }

    level waittill("bomber_destroyed");
  }
}

fake_dogfight_raid_ui(param_00) {
  level endon("game_ended");
  var_01 = 30;
  level.tempbomberui = newhudelem();
  level.tempbomberui.maxsightdistsqrd = -20;
  level.tempbomberui.var_1D7 = 140;
  level.tempbomberui.var_9B = 1.5;
  level.tempbomberui.accuracy = "left";
  level.tempbomberui.var_11 = "top";
  level.tempbomberui.var_C6 = "left";
  level.tempbomberui.var_1CA = "top";
  level.tempbomberui.ignoreme = 1;
  level.tempbomberui settext(common_scripts\utility::func_9AAD(20 - level.fighters_downed) + " of 20 Axis fighters left");
  for(;;) {
    level waittill("fighter_downed");
    level.tempbomberui settext(common_scripts\utility::func_9AAD(20 - level.fighters_downed) + " of 20 Axis fighters left");
  }
}

bomberobjectivetransition() {
  lib_04FF::func_79B2("radio_hardpoint");
  level notify("stop_overtime");
  setomnvar("ui_war_overtime_starttime", 0);
  setomnvar("ui_war_overtime_endtime", 0);
  setomnvar("ui_war_overtime_maxed", 0);
  maps\mp\gametypes\_hostmigration::func_A6F5(6);
  var_00 = newhudelem();
  var_00.maxsightdistsqrd = 0;
  var_00.var_1D7 = 0;
  var_00.var_C6 = "fullscreen";
  var_00.var_1CA = "fullscreen";
  var_00 setshader("black", 640, 480);
  var_00.var_18 = 0;
  if(isDefined(level.var_75CC)) {
    level.var_75CC.var_18 = 0;
  }

  wait 0.05;
  var_00 fadeovertime(2);
  var_00.var_18 = 1;
  thread bomberhidehud();
  maps\mp\gametypes\_hostmigration::func_A6F5(3);
  thread bomberfadeup(var_00);
}

bomberfadeup(param_00) {
  maps\mp\gametypes\_hostmigration::func_A6F5(2);
  param_00 fadeovertime(3);
  param_00.var_18 = 0;
}

bomberhidehud() {
  maps\mp\gametypes\_hostmigration::func_A6F5(1);
  foreach(var_01 in level.var_744A) {
    var_01 setclientomnvar("ui_hide_hud", 1);
    var_01 method_8322();
    var_01 maps\mp\_utility::func_3E8E(1);
    var_01 setclientdvar("ui_force_dont_draw_fighter_names", 1);
    var_01 setclientdvar("cg_drawVehicleCrosshair", 0);
  }
}

bomberobjectivetakeallweapons() {
  var_00 = 0;
  var_01 = level.var_744A;
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_1A7) && var_03.var_1A7 == "allies") {
      if(game["switchedsides"]) {
        var_04 = maps\mp\_utility::func_452A("raid_flak");
      } else {
        var_04 = maps\mp\_utility::func_452A("raid_fighters");
      }
    } else if(game["switchedsides"]) {
      var_04 = maps\mp\_utility::func_452A("raid_fighters");
    } else {
      var_04 = maps\mp\_utility::func_452A("raid_flak");
    }

    var_03 maps\mp\gametypes\_class::func_86B9(var_04, 0, 0, 0);
    var_03 maps\mp\killstreaks\_killstreaks::func_A129();
    var_03 maps\mp\killstreaks\_killstreaks::func_2400(1);
  }
}

preoutrovignettecleanup() {
  if(isDefined(level.old_mapcenter_bomber)) {
    foreach(var_01 in level.var_744A) {
      var_02 = var_01 method_85E2();
      if(isDefined(var_02)) {
        var_01 method_80F4();
        maps\mp\gametypes\_raid_bomber::delete_plane(var_02);
      }
    }

    maps\mp\gametypes\_raid_bomber::cleanup_all_turrets();
    maps\mp\gametypes\_raid_bomber::update_map_center(level.old_mapcenter_bomber);
  }
}

setup_window_open_close(param_00, param_01, param_02) {
  var_03 = getent(param_00, "script_noteworthy");
  var_04 = getent(var_03.var_1A2, "targetname");
  var_05 = getent(param_00 + "_clip_left", "script_noteworthy");
  var_06 = getent(param_00 + "_clip_right", "script_noteworthy");
  var_07 = getent(param_00 + "_mantle", "script_noteworthy");
  var_08 = var_05.var_116 - var_04 gettagorigin("window_L");
  var_09 = var_05.var_1D - var_04 gettagangles("window_L");
  var_0A = var_06.var_116 - var_04 gettagorigin("window_R");
  var_0B = var_06.var_1D - var_04 gettagangles("window_R");
  var_05 linkto(var_04, "window_L", var_08, var_09);
  var_06 linkto(var_04, "window_R", var_0A, var_0B);
  lib_0502::func_1D39(var_04);
  var_04 lib_0502::func_1D3A(var_04.var_116, 1);
  level thread window_open_logic(var_03, var_04, param_01, param_02, var_07);
}

window_open_logic(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  level endon("runBomberObjective");
  param_04 method_805C();
  param_00 sethintstring(&"RAIDS_HUSKY_OPEN_WINDOW");
  param_00 waittill("trigger");
  param_01 lib_0502::func_1D3B(0);
  param_00 method_805C();
  param_01 method_8278(param_02);
  wait(1);
  param_00 method_805B();
  window_close_logic(param_00, param_01, param_02, param_03, param_04);
}

window_close_logic(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  level endon("runBomberObjective");
  param_04 method_805B();
  param_00 sethintstring(&"RAIDS_HUSKY_CLOSE_WINDOW");
  param_00 waittill("trigger");
  param_01 lib_0502::func_1D3B(1);
  param_00 method_805C();
  param_01 method_8278(param_03);
  wait(1);
  param_00 method_805B();
  window_open_logic(param_00, param_01, param_02, param_03, param_04);
}