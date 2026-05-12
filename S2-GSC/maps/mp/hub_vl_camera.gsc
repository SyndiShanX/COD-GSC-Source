/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\hub_vl_camera.gsc
*********************************************/

func_05E0(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {}

func_2CCC(param_00, param_01, param_02) {
  wait(param_00);
  self notify("luinotifyserver", param_01, param_02);
}

func_87B1() {
  var_00 = common_scripts\utility::func_46B7("player_pos", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_46B5(var_02.var_01A2, "targetname");
    var_04 = common_scripts\utility::func_46B5(var_03.var_01A2, "targetname");
  }

  var_06 = getent("cao_spawnpoint", "targetname");
  var_07 = spawnStruct();
  var_07.var_9839 = 40;
  var_07.var_15F7 = 0.25;
  var_07.var_9935 = var_07.var_15F7;
  var_07.var_084C = 0.01;
  var_07.var_2D5F = 0;
  var_07.var_15F6 = 0.5;
  var_07.var_0DD6 = 0.01;
  var_07.var_9934 = var_07.var_15F6;
  var_07.var_2A2C = 0;
  var_07.var_6090 = 60;
  var_07.var_621D = 60;
  var_07.var_6091 = 120;
  var_07.var_0DCF = 0;
  var_07.var_3018 = 120;
  var_07.var_3184 = 12;
  var_07.var_399C = -10;
  var_07.var_1FA9 = 3;
  var_07.var_1FAA = 0;
  var_07.var_3FC0 = 0;
  var_07.var_3FBF = 45;
  var_07.var_3FC2 = 50;
  var_07.var_3FBC = 6;
  var_07.var_3FBD = 6;
  var_07.var_3FBE = 513;
  var_07.var_3FBB = 40;
  var_07.var_3FB5 = 483;
  var_07.var_3FB8 = 502;
  var_07.var_3FB2 = 71.5;
  var_07.var_3FB9 = 150;
  var_07.var_3FB3 = 96.8;
  var_07.var_3FB6 = 96.8;
  var_07.var_3FB4 = 490;
  var_07.var_3FB7 = 504.5;
  var_07.var_3FBA = 509.5;
  var_07.var_3FC1 = 0.95;
  var_07.var_1DFD = 0;
  var_07.var_1DFC = 7;
  var_07.var_1E17 = 13;
  var_07.var_1DF9 = 0;
  var_07.var_1DFA = 0;
  var_07.var_1EBB = 0.1;
  var_07.var_1E14 = 0.2;
  var_07.var_1E00 = 0;
  var_07.var_1DFB = 17;
  var_07.var_1E16 = 14.5;
  var_07.var_1DFF = 69;
  var_07.var_1E19 = 8;
  var_07.var_1E1B = 0;
  var_07.var_1E1C = 0;
  var_07.var_1E1D = 0;
  var_07.var_1E1E = 0;
  var_07.var_1E29 = 0.35;
  var_07.var_1E27 = 0.1;
  var_07.var_1E28 = 0.05;
  var_07.var_3FB0 = 150;
  var_07.var_3FAF = 0.2;
  var_07.var_3FAE = 45;
  var_07.var_3FB1 = 55;
  var_07.var_3FAB = 16;
  var_07.var_3FAD = 24;
  var_07.var_3FAC = 0.5;
  var_07.var_4800 = "avatar";
  var_07.var_3FA7 = 0.005;
  var_07.var_3FA9 = 0;
  var_07.var_3FA8 = 64;
  var_07.var_3FAA = 0;
  var_07.var_9933 = var_07.var_1EBE;
  var_07.var_28C4 = var_07.var_9933;
  var_07.var_1DFE = 0;
  var_07.var_1E18 = (-0.02, 0, -0.08);
  var_07.var_1E1A = (0.05, 0, -0.06);
  var_07.var_1EBD = 0.25;
  var_07.var_1F0A = 10;
  var_07.var_64C8 = 150;
  var_07.var_0DE1 = 800;
  var_07.var_768F = 0;
  var_08 = self method_8451();
  var_07.var_6A69 = var_08[0];
  var_07.var_6A6A = var_08[1];
  var_07.var_ACC5 = 0.5;
  var_07.var_7EE0 = 0.5;
  var_07.var_3E72 = 0;
  var_07.var_7635 = 4;
  var_07.var_2CC8 = 0;
  var_07.var_3174 = 0;
  var_07.var_3173 = 0;
  var_07.var_316C = 159.8;
  var_07.var_316B = 205.59;
  var_07.var_3172 = 7.5;
  var_07.var_316A = 2;
  var_07.var_6C41 = (0, 0, 40);
  var_07.var_768A = 300;
  var_07.var_768E = 10;
  var_07.var_768D = 42;
  var_07.var_768B = 40;
  var_07.var_7689 = 200;
  var_07.var_7687 = 0;
  var_07.var_7688 = 20;
  var_07.var_7686 = 0.325;
  var_07.var_768C = 0.2;
  var_07.var_1EBC = -0.1;
  var_07.var_1EBE = 0.19;
  var_07.var_1EBF = -1;
  var_07.var_2095 = 36;
  var_07.var_2096 = 42;
  var_07.var_9C7B = 0;
  var_07.var_1FA5 = 10;
  var_07.var_1FA4 = 31;
  var_07.var_1F9C = 40;
  var_07.var_1F94 = 200;
  var_07.var_1F90 = 0;
  var_07.var_1F91 = 20;
  var_07.var_1F8F = 0.77;
  var_07.var_1F9E = 0.2;
  var_07.var_1F92 = 0.25;
  var_09 = getdvarint("virtualLobbyMode", 0);
  if(var_09 == 0) {
    var_07.var_627E = "game_lobby";
    func_9271();
  } else {
    var_07.var_627E = "transition";
    var_07.var_9933 = var_07.var_1EBC;
    var_07.var_28C4 = var_07.var_9933;
    func_9243();
    if(getdvarint("5666", 0) == 0) {
      setDvar("5666", "1");
    }

    if(var_09 == 2) {
      thread func_2CCC(0.1, "cac", 0);
    } else if(var_09 == 3) {
      thread func_2CCC(0.1, "cao", 0);
    }
  }

  var_07.var_669A = var_07.var_627E;
  self.var_1EFF = var_07;
}

func_A09D(param_00) {
  if(isDefined(self.var_2988)) {
    param_00.var_28C4 = param_00.var_9933;
    return;
  }

  var_01 = param_00.var_9933 - param_00.var_28C4;
  if(var_01 < -1 * param_00.var_1EBD) {
    var_01 = -1 * param_00.var_1EBD;
  } else if(var_01 > param_00.var_1EBD) {
    var_01 = param_00.var_1EBD;
  }

  param_00.var_28C4 = param_00.var_28C4 + var_01;
}

func_4697(param_00) {
  var_01 = common_scripts\utility::func_46B7("player_pos", "targetname");
  var_02 = undefined;
  foreach(var_02 in var_01) {
    if(var_02.var_0165 == "" + param_00) {
      break;
    }
  }

  if(!isDefined(var_02)) {
    var_02 = var_01[0];
  }

  self.var_13B6 = var_02;
  return var_02;
}

func_A59B() {
  var_00 = self;
  if(isDefined(level.var_A590)) {
    var_00[[level.var_A590]]();
    return;
  }

  var_00 method_84B4();
  var_00 method_84B7(0.613159, 89.8318, var_00.var_1EFF.var_3184, var_00.var_1EFF.var_3184);
}

func_841A() {
  var_00 = self;
  if(isDefined(var_00.var_1EFF.var_4800)) {
    if(var_00.var_1EFF.var_4800 == "moving" || var_00.var_1EFF.var_4800 == "finding_new_position" || level.var_A595[self.var_A58C] != level.var_A595[self.var_6A4F]) {
      return;
    }
  }

  if(isDefined(var_00.var_1EFF.var_1E99.var_2988) && var_00.var_1EFF.var_1E99.var_2988 == 1) {
    return;
  }

  if(isDefined(var_00.var_1EFF.var_1E99.var_4802)) {
    var_01 = var_00.var_1EFF.var_1E99.var_4802;
  } else {
    var_02 = level.var_A595[self.var_6A4F];
    var_03 = var_02 gettagorigin("TAG_STOWED_BACK");
    var_04 = distance2d(var_03, var_02.var_13B6.var_0116);
    var_05 = var_02.var_13B6.var_0116 + anglesToForward(var_02.var_13B6.var_001D) * var_04;
    var_01 = (var_05[0], var_05[1], var_03[2]);
  }

  var_06 = func_21AE(var_00.var_1EFF.var_1E99, var_01, 1.5);
  if(var_06 == 1) {
    var_07 = var_01;
    return;
  }

  var_07 = var_00.var_1EFF.var_1E99.var_0116;
}

func_A599(param_00) {
  if(param_00 <= 0) {
    return;
  }

  var_01 = self;
  var_02 = var_01.var_1EFF.var_3184;
  if(isDefined(level.var_A58B)) {
    var_01[[level.var_A58B]](param_00);
    return;
  }

  var_03 = param_00;
  var_01 = self;
  var_04 = 0.025;
  var_05 = 0.65;
  var_06 = 0.613159;
  var_07 = 94.9504;
  var_08 = var_07 - var_03 * var_04;
  var_09 = var_06 + var_08 + var_08 * var_05;
  if(var_09 < 0.125) {
    var_09 = 0.125;
  } else if(var_09 > 128) {
    var_09 = 128;
  }

  var_01 method_84B7(var_09, var_03, var_01.var_1EFF.var_3184, var_01.var_1EFF.var_3184 * 2);
}

func_A59A(param_00, param_01, param_02) {
  var_03 = self;
  if(isDefined(level.var_A58E)) {
    var_03[[level.var_A58E]](param_00, param_01, param_02);
    return;
  }

  if(param_00 == "cac") {
    var_03 func_8662();
  } else if(param_00 == "cao") {}

  if(param_01 == "cac") {
    var_03 visionsetnakedforplayer("mp_hub_allies", 0);
    return;
  }

  if(param_01 == "cao") {
    var_03 method_84B7(3.99, 119.339, var_03.var_1EFF.var_3184, var_03.var_1EFF.var_3184);
    return;
  }

  if(param_01 == "clanprofile") {
    var_03 func_8661();
    return;
  }

  if(param_01 == "prelobby") {
    var_03 func_8662();
    return;
  }

  if(param_00 == "prelobby_members") {
    return;
  }

  if(param_00 == "prelobby_loadout") {
    return;
  }

  if(param_00 == "prelobby_loot") {
    return;
  }

  if(param_01 == "game_lobby") {
    var_03 func_8662();
    return;
  }

  if(param_00 == "startmenu") {
    return;
  }

  if(param_00 == "transition") {
    return;
  }
}

func_8662() {
  var_00 = self;
  var_00 visionsetnakedforplayer("mp_hub_allies_vlobby", 0);
}

func_8661() {
  var_00 = self;
  var_00 method_84B7(0.613159, 89.8318, var_00.var_1EFF.var_3184, var_00.var_1EFF.var_3184);
}

func_3C75() {
  if(!isDefined(level.var_A595[self.var_A58C])) {
    foreach(var_02, var_01 in level.var_A595) {
      self.var_A58C = var_02;
      break;
    }
  }
}

func_6BA9() {
  level.var_0A41["player"]["on_killed"] = ::maps\mp\hub_vl_base::func_6A75;
  thread func_A59C();
  thread func_631F();
  var_00 = undefined;
  while(!isDefined(var_00) || !isDefined(self.var_01D6)) {
    wait 0.05;
    var_00 = level.var_AAE2[self.var_01D6];
  }

  thread func_62F9(var_00);
  thread func_62F8(var_00);
  thread func_62F4();
  thread maps\mp\hub_vl_base::func_636A(self);
}

func_A59C() {
  self endon("disconnect");
  while(!isDefined(self.var_835A)) {
    wait 0.05;
  }

  var_00 = self;
  var_00.var_00C7 = 0;
  var_00 setclientomnvar("ui_vlobby_round_state", 0);
  var_00 setclientomnvar("ui_vlobby_round_timer", 0);
  var_00 func_4835();
  var_01 = var_00.var_0116;
  var_02 = var_00.var_001D;
  var_03 = var_01 - (0, 0, 30);
  var_00 func_87B1();
  var_04 = anglesToForward(var_00.var_001D);
  var_05 = anglestoright(var_00.var_001D);
  var_06 = var_04;
  var_07 = getgroundposition(var_01, 20, 512, 120);
  var_08 = var_00 getxuid();
  var_09 = var_08 == "";
  var_0A = undefined;
  level.var_6648 = 1;
  var_0B = "none";
  var_0C = "none";
  var_0D = "none";
  var_0E = var_00.var_5E01["customClasses"][0];
  var_0F = var_0E["division"];
  if(isDefined(var_0E["primaryWeaponStruct"]) && isDefined(var_0E["primaryWeaponStruct"].var_48CA) && var_0E["primaryWeaponStruct"].var_48CA != 0) {
    var_10 = var_0E["primaryWeaponStruct"];
    var_11 = var_0E["primaryAttachmentsGUID"][0];
    var_12 = var_0E["primaryAttachmentsGUID"][1];
    var_13 = var_0E["primaryAttachmentsGUID"][2];
    var_14 = var_0E["primaryAttachmentsGUID"][3];
    var_15 = var_0E["primaryAttachmentsGUID"][4];
    var_16 = var_0E["primaryAttachmentsGUID"][5];
    var_17 = var_0E["primaryCamoGUID"];
    var_18 = var_0E["primaryReticleGUID"];
    var_19 = var_0E["primaryCustomization"];
    var_1A = maps\mp\_utility::func_4737(var_10);
    var_0B = maps\mp\gametypes\_class::func_1D66(var_1A, var_11, var_12, var_13, var_14, var_15, var_16, maps\mp\_utility::func_472D(var_10), var_17, var_18, var_19);
  } else if(isDefined(var_0E["secondaryWeaponStruct"]) && isDefined(var_0E["secondaryWeaponStruct"].var_48CA) && var_0E["secondaryWeaponStruct"].var_48CA != 0) {
    var_1B = var_0E["secondaryWeaponStruct"];
    var_11 = var_0E["secondaryAttachmentsGUID"][0];
    var_12 = var_0E["secondaryAttachmentsGUID"][1];
    var_13 = var_0E["secondaryAttachmentsGUID"][2];
    var_14 = var_0E["secondaryAttachmentsGUID"][3];
    var_15 = var_0E["secondaryAttachmentsGUID"][4];
    var_16 = var_0E["secondaryAttachmentsGUID"][5];
    var_17 = var_0E["secondaryCamoGUID"];
    var_18 = var_0E["secondaryReticleGUID"];
    var_19 = var_0E["secondaryCustomization"];
    var_1A = maps\mp\_utility::func_4737(var_1B);
    var_0C = maps\mp\gametypes\_class::func_1D66(var_1A, var_11, var_12, var_13, var_14, var_15, var_16, maps\mp\_utility::func_472D(var_1B), var_17, var_18, var_19);
  } else if(isDefined(var_0E["meleeWeaponStruct"]) && isDefined(var_0E["meleeWeaponStruct"].var_48CA) && var_0E["meleeWeaponStruct"].var_48CA != 0) {
    var_1C = var_0E["meleeWeaponStruct"];
    var_1D = maps\mp\_utility::func_4737(var_1C);
  }

  var_1E = getent("cao_spawnpoint", "targetname");
  var_1F = 0;
  if(!var_09) {
    maps\mp\hub_vl_base::func_A59F("adding xuid " + var_08 + "from vlobby_player");
    var_1F = maps\mp\hub_vl_base::func_0902(var_08);
    func_4696(0);
    var_00 func_8F7D(var_00.var_13B6, var_0F, var_0B, var_0C, var_0D, var_00.var_5DF4, var_00.var_5DF7, var_00.var_6F65, var_00.var_83F4, var_00.var_0109, var_1F, 0);
    if(!level.var_A1FE) {
      function_02BA(level.var_A595[var_1F], var_08);
    }

    thread func_8A5F();
  } else {
    level.var_6651 = 1;
  }

  setDvar("1999", level.var_AAE2.size);
  var_00.var_1FA3 = var_1E;
  var_00.var_1F9D = var_0B;
  if(isDefined(level.var_A1DB)) {
    var_00.var_2316 = [];
    var_20 = [0, 1, 4];
    for(var_21 = 0; var_21 < 3; var_21++) {
      var_22 = func_4696(var_20[var_21]);
      var_00.var_2316[var_21] = var_00 func_8F7D(var_22, var_0F, var_0B, var_0C, var_0D, var_00.var_5DF4, var_00.var_5DF7, var_00.var_6F65, var_00.var_83F4, var_00.var_0109, 0, 0, 1);
      func_4CCD(var_00.var_2316[var_21]);
    }
  }

  var_00.var_A58C = var_1F;
  var_00.var_A588 = undefined;
  var_00 thread func_62F5(var_1F);
  if(!var_09) {
    var_0A = level.var_A595[var_00.var_A58C];
    var_0A.var_6101 = gettime();
    var_0A.var_294D = var_00.var_294D;
    var_0A.var_721C = var_00;
    var_0A.var_83F4 = var_0A.var_267E;
  }

  thread func_62FC(var_00, var_00.var_1EFF);
  var_23 = common_scripts\utility::func_46B5("camera_pos", "targetname");
  var_24 = var_23.var_0116;
  var_25 = var_23.var_001D;
  var_26 = var_00.var_13B6.var_0116 - var_24;
  var_26 = vectornormalize(var_26);
  var_27 = spawn("script_model", var_24);
  var_27.var_001D = var_25;
  var_27 setModel("tag_player");
  var_27.var_01A5 = "vlcamera";
  var_27.var_92F0 = var_24;
  var_27.var_92B8 = var_25;
  var_27.var_8066 = (0, 0, 0);
  var_27.var_1E91 = 0;
  var_27.var_4B88 = 1;
  var_27.var_1E98 = 1;
  var_27.var_2988 = 1;
  var_27.var_3FE2 = 0;
  var_27.var_3BA7 = 1;
  var_27.var_4802 = var_24;
  func_9422(var_27);
  var_28 = 400;
  var_00.var_1E99 = var_27;
  var_27.var_721C = var_00;
  var_00.var_4B9E = 0;
  var_29 = (0, 90, 0);
  var_27.var_64ED = "starting";
  var_00.var_50CA = 0;
  var_00 method_812B(0);
  var_00 maps\mp\hub_vl_base::func_7699(var_00.var_9042, var_00.var_9042.var_8F80);
  if(isDefined(level.var_A1DB)) {
    var_00 maps\mp\hub_vl_base::func_7699(var_00.var_2316[0], var_00.var_2316[0].var_8F80);
    var_00 maps\mp\hub_vl_base::func_7699(var_00.var_2316[1], var_00.var_2316[1].var_8F80);
    var_00 maps\mp\hub_vl_base::func_7699(var_00.var_2316[2], var_00.var_2316[2].var_8F80);
  }

  var_2A = var_00.var_1EFF;
  var_2A.var_1E99 = var_27;
  func_5232(var_27);
  var_2B = 300;
  var_00.var_6A4F = var_00.var_A58C;
  var_28 = 1000;
  var_2C = anglesToForward(var_27.var_001D);
  var_2D = undefined;
  var_2E = undefined;
  var_2F = undefined;
  var_30 = undefined;
  var_00.var_1EFF.var_3E72 = var_00.var_1EFF.var_7635;
  thread func_6338();
  thread func_635D(var_2A);
  var_31 = 0;
  var_32 = 0;
  self setclientomnvar("char_scene_state", 3);
  var_00 notify("fade_in");
  for(;;) {
    if(!var_00.var_537A) {
      var_00 waittill("virtualLobbyActive");
      var_00.var_8068 = var_00 getangles();
      var_00.var_9042.var_001D = var_00.var_9042.var_8F80;
      func_05E0(var_00 getentitynumber(), var_00.var_9042.var_20F1, "angles", var_00.var_9042.var_001D);
      var_00 maps\mp\hub_vl_base::func_7699(var_00.var_9042, var_00.var_9042.var_8F80);
      var_00 setclientomnvar("char_scene_state", 3);
    }

    maps\mp\hub_vl_base::func_13B4();
    if(level.var_A595.size == 0) {
      if(var_2A.var_627E == "game_lobby" || var_2A.var_627E == "prelobby_loot") {
        var_00 func_2D00();
        if(isDefined(level.var_A1DB)) {
          for(var_21 = 0; var_21 < 3; var_21++) {
            func_4CCD(var_00.var_2316[var_21]);
          }
        }

        var_27.var_2988 = 1;
        var_00.var_13B6 = func_4696(0);
        func_5E39(var_27, undefined, var_2A, var_00.var_13B6);
        func_A59D(0, "ac130_overlay_pip_vignette_vlobby");
      }

      wait 0.05;
      continue;
    }

    if(var_32) {
      var_32 = 0;
      var_00 thread func_2AFB();
    }

    if(getdvarint("scr_vl_debugfly") > 0) {
      if(!var_31) {
        var_31 = 1;
        setDvar("5718", "0");
        level.var_2AE5 = undefined;
        var_00 method_812B(1);
      }

      var_00 func_2AE5(var_27);
    } else if(var_31) {
      setDvar("5718", "1");
      var_31 = 0;
      var_27.var_0116 = var_27.var_92F0;
      var_27.var_001D = var_27.var_92B8;
      var_00 method_812B(0);
    }

    if(!var_00.var_50CA) {
      if(var_00.var_A58C != var_00.var_6A4F) {
        var_00 maps\mp\hub_vl_base::func_7699(level.var_A595[var_00.var_A58C], level.var_A595[var_00.var_A58C].var_001D);
        if(var_2A.var_627E != "game_lobby") {
          var_2A.var_669A = "transition";
        }

        var_00.var_6A4F = var_00.var_A58C;
        var_2A.var_9C7B = 1;
      }

      if(isDefined(var_00.var_A588) || isDefined(var_00.var_77A2)) {
        if(!isDefined(var_00.var_A588)) {
          var_2A.var_669A = var_2A.var_77BF;
          var_00.var_77A2 = undefined;
        } else if(!isDefined(var_00.var_77A2)) {
          var_2A.var_669A = "cao";
          var_2A.var_77BF = var_2A.var_627E;
          var_00.var_77A2 = var_00.var_A588;
        } else if(var_00.var_A588 != var_00.var_77A2) {
          var_00.var_77A2 = var_00.var_A588;
        }
      }

      if(isDefined(var_00.var_1DF8) || isDefined(var_00.var_77A0)) {
        if(!isDefined(var_00.var_1DF8)) {
          var_2A.var_669A = var_2A.var_77BF;
          var_00.var_77A0 = undefined;
          var_00.var_77A1 = "none";
        } else if(!isDefined(var_00.var_77A0)) {
          var_2A.var_669A = "cac";
          var_2A.var_77BF = var_2A.var_627E;
          var_00.var_77A0 = var_00.var_1DF8;
        }
      }

      if(isDefined(var_00.var_A589) || isDefined(var_00.var_77A3)) {
        if(!isDefined(var_00.var_A589)) {
          var_2A.var_669A = var_2A.var_77BF;
          var_00.var_77A3 = undefined;
        } else if(!isDefined(var_00.var_77A3)) {
          var_2A.var_669A = "clanprofile";
          var_2A.var_77BF = var_2A.var_627E;
          var_00.var_77A3 = var_00.var_A589;
        } else if(var_00.var_A589 != var_00.var_77A3) {
          var_00.var_77A3 = var_00.var_A589;
          if(isDefined(level.var_A1DB)) {
            var_00 maps\mp\hub_vl_base::func_7699(var_00.var_2316[var_00.var_A589], var_00.var_2316[var_00.var_A589].var_001D);
          }
        }
      }

      if(level.var_A595.size == 0) {
        continue;
      }

      var_00 func_3C75();
      var_0A = level.var_A595[var_00.var_A58C];
      if(var_2A.var_669A != var_2A.var_627E) {
        var_00 func_A59A(var_2A.var_627E, var_2A.var_669A, var_2A);
        if(var_2A.var_669A == "cac") {
          var_00 func_2D00();
          if(isDefined(level.var_A1DB)) {
            for(var_21 = 0; var_21 < 3; var_21++) {
              func_4CCD(var_00.var_2316[var_21]);
            }
          }

          var_00.var_4B9E = 0;
          var_2A.var_627E = var_2A.var_669A;
          var_2A.var_9933 = var_2A.var_1DFD;
          var_0A = level.var_A595[var_00.var_A58C];
          func_4CCD(var_0A);
          var_00 maps\mp\hub_vl_base::func_7699(var_0A, var_0A.var_001D);
        } else if(var_2A.var_627E == "cac") {
          var_0A = level.var_A595[var_00.var_A58C];
          func_8BBB(var_0A);
          var_00.var_4B9E = 0;
        }

        if(var_2A.var_669A == "cao") {
          var_33 = level.var_A595[var_00.var_A58C];
          var_00.var_267E = var_33.var_267E;
          var_34 = var_00 maps\mp\gametypes\_teams::func_73CA();
          if(!isDefined(var_33.var_5097) || !var_33.var_5097) {
            if(level.var_A1FE) {
              func_05E0(var_00 getentitynumber(), var_33.var_20F1, "costume", var_33.var_267E[0], var_33.var_267E[1], var_33.var_267E[2], var_33.var_267E[3], var_33.var_267E[4], var_33.var_267E[5]);
            } else {
              var_33 setcostumemodels(var_33.var_267E, "free");
            }
          }

          var_00 func_2785();
          var_35 = var_00.var_1F8E;
          func_A586(var_35, var_33.var_267E);
          if(!isDefined(var_35.var_5097) || !var_35.var_5097) {
            if(level.var_A1FE) {
              func_05E0(var_00 getentitynumber(), var_35.var_20F1, "costume", var_33.var_267E[0], var_33.var_267E[1], var_33.var_267E[2], var_33.var_267E[3], var_33.var_267E[4], var_33.var_267E[5]);
            } else {
              var_35 setcostumemodels(var_35.var_267E, "free");
            }
          }

          foreach(var_08, var_37 in level.var_AAE2) {
            if(var_37 == var_00.var_A58C) {
              if(!level.var_A1FE) {
                if(isDefined(level.var_1FA7) && level.var_1FA7 != var_08) {
                  function_02BA(var_35, level.var_1FA7, 1);
                }

                function_02BA(var_35, var_08);
              }

              level.var_1FA7 = var_08;
              break;
            }
          }

          if(!level.var_A1FE) {
            var_00.var_1F8E showtoclient(var_00);
          }

          var_00.var_1F8E.var_001D = var_00.var_1F8E.var_8F80;
          func_05E0(var_00 getentitynumber(), var_00.var_1F8E.var_20F1, "angles", var_00.var_1F8E.var_001D);
          if(isDefined(level.var_A1DB)) {
            for(var_21 = 0; var_21 < 3; var_21++) {
              func_4CCD(var_00.var_2316[var_21]);
            }
          }

          var_0A = var_00.var_1F8E;
          var_00 maps\mp\hub_vl_base::func_7699(var_00.var_1F8E, var_00.var_1F8E.var_001D);
          func_91B5();
          var_2A.var_627E = var_2A.var_669A;
          var_27.var_2988 = 1;
        } else if(var_2D.var_669A == "clanprofile") {
          var_03 func_2D00();
          func_4CD2();
          if(isDefined(level.var_A1DB)) {
            for(var_21 = 0; var_21 < 3; var_21++) {
              var_03.var_2316[var_21].var_001D = var_03.var_2316[var_21].var_8F80;
              func_05E0(var_03 getentitynumber(), var_03.var_2316[var_21].var_20F1, "angles", var_03.var_2316[var_21].var_001D);
              var_03 maps\mp\hub_vl_base::func_7699(var_03.var_2316[var_21], var_03.var_2316[var_21].var_001D);
            }

            var_0D = var_03.var_2316[0];
          }

          var_2D.var_627E = var_2D.var_669A;
          var_03 setorigin(var_0D.var_0116);
        } else if(var_2D.var_669A == "prelobby_loot") {
          var_2A.var_2988 = 1;
        } else if(var_2D.var_669A == "transition") {
          var_2D.var_669A = "game_lobby";
        }

        if(var_2D.var_669A == "game_lobby") {
          var_03 func_3C75();
          var_38 = var_25;
          if(var_2D.var_627E == "cao" || var_2D.var_627E == "cac" || var_2D.var_627E == "clanprofile") {
            var_2A.var_3BA7 = 1;
            if(isDefined(var_03.var_A588)) {
              var_38 = var_03.var_A588;
            } else if(isDefined(var_03.var_A589)) {
              var_38 = func_44E9(var_03.var_A589);
            }
          }

          if(isDefined(level.var_A595) && isDefined(var_03.var_6A4F) && isDefined(level.var_A595[var_03.var_6A4F])) {
            var_03 maps\mp\hub_vl_base::func_7699(level.var_A595[var_03.var_6A4F], level.var_A595[var_03.var_6A4F].var_001D);
          }

          var_2D.var_4800 = "waiting";
          if(var_2D.var_627E != "cac") {
            func_8BBC();
          }

          var_03.var_A58C = var_38;
          var_03.var_6A4F = var_38;
          var_0D = level.var_A595[var_03.var_A58C];
          if(var_2D.var_627E != "cac") {
            var_2A.var_2988 = 1;
          } else if(var_2D.var_627E == "cac" && isDefined(var_2A.var_13B6) && var_2A.var_13B6 != var_0D.var_13B6) {
            var_2A.var_2988 = 1;
          }

          func_9243();
          var_2A.var_5B16 = var_0D.var_13B6;
          var_2A.var_13B6 = var_0D.var_13B6;
          var_03 maps\mp\hub_vl_base::func_7699(var_0D, var_0D.var_001D);
          var_2A.var_64ED = "starting";
        }

        var_2E.var_627E = var_2E.var_669A;
      }

      if(var_2E.var_627E == "startmenu") {
        func_924B(var_2B, var_2E);
      } else if(var_2E.var_627E == "cao") {
        var_04 func_2785();
        var_0E = var_04.var_1F8E;
        func_1FA6(var_2B, var_0E, var_2E);
      } else if(var_2E.var_627E == "clanprofile") {
        if(isDefined(level.var_A1DB)) {
          var_0E = var_04.var_2316[var_04.var_A589];
          func_2317(var_2B, var_0E, var_2E);
        }
      } else if(var_2E.var_627E == "cac") {
        func_5E39(var_2B, level.var_A595[var_04.var_A58C], var_2E, var_04.var_13B6);
      } else if(var_2E.var_627E == "transition") {
        var_2E.var_669A = "game_lobby";
      } else if(var_2E.var_1FAA <= 0) {
        var_04 func_2D00();
        if(isDefined(level.var_A1DB)) {
          for(var_21 = 0; var_21 < 3; var_21++) {
            func_4CCD(var_04.var_2316[var_21]);
          }
        }

        func_5E39(var_2B, var_0E, var_2E, var_04.var_13B6);
        func_A59D(0, "ac130_overlay_pip_vignette_vlobby");
      } else {
        var_2E.var_1FAA = var_2E.var_1FAA - 1;
      }
    }

    if(var_04.var_50CA) {
      var_04 visionsetnakedforplayer("mp_vlobby_room_fr", 0);
    }

    wait 0.05;
  }
}

func_9593(param_00, param_01, param_02) {
  var_03 = float(tablelookup("mp/vlobby_cac_offsets.csv", param_01, param_00, param_02));
  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  return var_03;
}

func_9422(param_00) {
  var_01 = common_scripts\utility::func_46B7("player_pos", "targetname");
  param_00.var_1EB7 = [];
  foreach(var_03 in var_01) {
    param_00.var_1EB7[param_00.var_1EB7.size] = var_03;
  }

  foreach(var_03 in var_01) {
    var_06 = common_scripts\utility::func_46B5(var_03.var_01A2, "targetname");
    if(var_06.var_0165 == "camera_target") {
      var_03.var_1E9F = var_06;
    }

    var_07 = common_scripts\utility::func_46B5(var_06.var_01A2, "targetname");
    if(var_07.var_0165 == "camera") {
      var_03.var_1E9D = var_07;
      var_07.var_1E9C = var_03;
      var_07.var_1E9F = var_03.var_1E9F;
    }

    if(var_03.var_0165 == "0") {
      self.var_1EFF.var_5B1A = var_03.var_1E9D;
    }

    var_08 = int(var_03.var_0165);
    param_00.var_1EB7[var_08] = var_03;
  }
}

func_1E3F(param_00, param_01, param_02) {
  var_03 = param_01 - param_00;
  var_04 = length2d(var_03);
  var_05 = var_04 / sqrt(1 + param_02.var_28C4 * param_02.var_28C4);
  var_06 = var_03[0] - param_02.var_28C4 * var_03[1];
  var_07 = param_02.var_28C4 * var_03[0] + var_03[1];
  var_08 = var_05 * vectornormalize((var_06, var_07, 0));
  var_08 = var_08 + (0, 0, var_03[2]);
  return var_08;
}

func_4951(param_00, param_01) {
  var_02 = param_01 - param_00.var_6A69;
  if(var_02 < -180) {
    var_02 = 360 + var_02;
  } else if(var_02 > 180) {
    var_02 = 360 - var_02;
  }

  param_00.var_6A69 = param_01;
  return var_02;
}

func_4952(param_00, param_01) {
  var_02 = param_01 - param_00.var_6A6A;
  if(var_02 < -180) {
    var_02 = -1;
  } else if(var_02 > 180) {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  param_00.var_6A6A = param_01;
  return var_02;
}

func_1EB8(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_2988)) {
    self.var_0116 = param_00;
    return;
  }

  self moveto(param_00, param_01, param_02, param_03);
}

func_1F09(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_2988)) {
    self.var_001D = param_00;
    return;
  }

  self rotateto(param_00, param_01, param_02, param_03);
}

func_7EED(param_00, param_01) {
  if(!isDefined(param_00)) {
    var_02 = spawnStruct();
    var_02.var_1EAF = (-70.8, -691.3, 502.2);
    var_02.var_1EAE = (0, 87, 0);
    return var_02;
  }

  var_03 = param_00 gettagorigin("TAG_STOWED_BACK");
  var_04 = param_00 gettagangles("TAG_STOWED_BACK");
  var_05 = param_00.var_8F80[1] - param_00.var_001D[1];
  var_06 = (0, 0, 1);
  var_07 = var_03 - param_00.var_0116;
  var_08 = rotatepointaroundvector(var_06, var_07, var_05);
  var_09 = param_00.var_0116 + var_08;
  param_00.var_1EAF = var_09;
  param_00.var_1EAE = (var_04[0], angleclamp360(var_04[1] + var_05), var_04[2]);
  var_02 = spawnStruct();
  var_02.var_1EAF = param_00.var_1EAF;
  var_02.var_1EAE = param_00.var_1EAE;
  return var_02;
}

func_21AE(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 2;
  }

  var_03 = distance(param_01, param_00.var_0116);
  if(var_03 >= param_02) {
    return 1;
  }

  return 0;
}

func_5E39(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_02.var_3E72 = param_02.var_7635;
    var_04 = param_00.var_92B8;
    if(isDefined(param_03)) {
      var_04 = (0, param_03.var_001D[1] + 180, 0);
    }

    var_05 = param_00.var_92F0;
    var_06 = distance(param_00.var_0116, var_05);
    var_07 = var_06 / param_02.var_768A;
    if(var_07 < 0.1) {
      var_07 = 0.1;
    }

    param_00 func_1EB8(var_05, var_07, var_07 * 0.5, var_07 * 0.5);
    param_00 func_1F09(var_04, var_07, var_07 * 0.5, var_07 * 0.5);
  } else {
    if(var_06.var_3E72 == var_06.var_7635) {
      maps\mp\hub_vl_base::func_7699(var_04, var_04.var_001D);
    }

    var_04 = (0, 87, 0);
    if(isDefined(param_03.var_13B6)) {
      var_07 = (0, param_03.var_13B6.var_001D[1] + 180, 0);
    }

    if(level.var_A1FE) {
      var_08 = param_03.var_0116;
    } else {
      var_08 = var_04 gettagorigin("TAG_STOWED_BACK");
    }

    if(!isDefined(param_01.var_1EAD)) {
      param_01.var_1EAD = "stand";
    }

    if(param_01.var_1EAD == "crouch") {
      var_09 = param_01.var_13B6.var_0116 + anglesToForward(param_01.var_13B6.var_001D) * param_02.var_3FB3;
      var_0A = (var_09[0], var_09[1], var_09[2] + param_02.var_3FB5);
    } else if(param_03.var_1EAD == "hunch") {
      var_09 = param_03.var_13B6.var_0116 + anglesToForward(param_03.var_13B6.var_001D) * var_04.var_3FB6;
      var_0A = (var_0A[0], var_0A[1], var_0A[2] + param_03.var_3FB8);
    } else if(param_03.var_1EAD == "stand") {
      var_09 = param_03.var_13B6.var_0116 + anglesToForward(param_03.var_13B6.var_001D) * var_04.var_3FB9;
      var_0A = (var_0A[0], var_0A[1], var_0A[2] + param_03.var_3FBB);
    } else if(param_03.var_1EAD == "zoom_high") {
      var_09 = param_03.var_13B6.var_0116 + anglesToForward(param_03.var_13B6.var_001D) * var_04.var_3FB2;
      var_0A = (var_0A[0], var_0A[1], var_0A[2] + param_03.var_3FBE);
    } else {
      var_09 = param_03.var_13B6.var_0116 + anglesToForward(param_03.var_13B6.var_001D) * var_04.var_3FB9;
      var_0A = (var_0A[0], var_0A[1], var_0A[2] + param_03.var_3FBB);
    }

    if(getdvarint("scr_vl_camera_test") != 0) {
      var_0B = distance2d(param_01.var_13B6.var_0116, param_01.var_13B6.var_1E9D.var_0116);
      if(var_0B < param_02.var_3FB9) {
        var_0B = param_02.var_3FB9;
      }

      var_0C = var_08[2] - param_02.var_3FBB;
      var_0D = atan(var_0C / param_02.var_3FB9);
      var_0E = tan(var_0D) * param_02.var_3FB9;
      var_0F = tan(var_0D) * var_0B;
      var_10 = var_08[2] - var_0F;
      var_09 = param_01.var_13B6.var_0116 + anglesToForward(param_01.var_13B6.var_001D) * var_0B;
      var_0A = (var_09[0], var_09[1], var_10);
    }

    param_00.var_4802 = var_0A;
    var_11 = 0;
    if(param_02.var_3E72 == 0) {
      var_11 = func_21AE(param_00, var_0A, 1.5);
    }

    param_02.var_28C4 = param_02.var_3FC0;
    param_02.var_9933 = param_02.var_3FC0;
    param_00 func_A09D(param_02);
    var_12 = 0;
    var_13 = 0;
    var_06 = distance(param_00.var_0116, var_0A);
    var_07 = var_06 / param_02.var_3FB0;
    if(var_07 < 0.1) {
      var_07 = 0.1;
    }

    var_14 = var_06 / param_02.var_3FB0 * param_02.var_3FC1;
    if(var_14 < 0.1) {
      var_14 = 0.1;
    }

    var_15 = 1;
    var_16 = getdvarint("virtualLobbyMode", 0);
    if(var_16 != 2 && var_16 != 4 && var_16 != 3) {
      if(isDefined(param_01.var_721C) && param_01.var_721C == self) {
        maps\mp\hub_vl_base::func_7E92(param_01, 0.5);
      }
    } else if(var_16 == 4 || var_16 == 3) {
      maps\mp\hub_vl_base::func_7699(param_01, param_01.var_001D);
      param_00.var_2988 = 1;
    } else if(var_16 == 2) {
      maps\mp\hub_vl_base::func_7699(param_01, param_01.var_001D);
    }

    if(param_02.var_3E72 > 0) {
      param_02.var_3E72 = param_02.var_3E72 - 1;
    }

    if(isDefined(param_01.var_13B6) && isDefined(param_00.var_13B6) && param_01.var_13B6 != param_00.var_13B6) {
      param_00.var_5B72 = param_00.var_13B6;
      param_00.var_13B6 = param_01.var_13B6;
      param_02.var_4800 = "finding_new_position";
      var_11 = 1;
      param_00.var_3BA7 = 0;
    } else if(var_11 == 1) {
      param_02.var_4800 = "moving";
    }

    if(param_02.var_4800 == "waiting") {
      if(var_11 == 1) {
        param_02.var_4800 = "moving";
        param_00.var_3BA7 = 1;
      }

      param_00.var_5B16 = param_01.var_13B6;
    }

    if(param_02.var_4800 == "finding_new_position") {
      if(var_11 == 1) {
        param_00.var_5B72 = param_00.var_13B6;
        param_00.var_13B6 = param_01.var_13B6;
        param_00.var_699B = [];
        var_17 = 16;
        foreach(var_19 in level.var_A595) {
          var_1A = [];
          var_1A["center"] = var_19.var_13B6.var_0116;
          var_1A["radius"] = var_17;
          param_00.var_699B[param_00.var_699B.size] = var_1A;
        }

        func_1D1A(param_00, param_02, param_00.var_0116, var_0A, var_04);
        param_00.var_3E6A = func_1E3A(param_01);
        param_00.var_9809 = func_4377(param_01);
        param_02.var_4800 = "moving";
      }

      param_02.var_4800 = "moving";
    }

    if(param_02.var_4800 == "moving") {
      if(param_02.var_3E72 <= 0) {
        param_02.var_3E72 = 0;
        if(param_00.var_3BA7 == 0) {
          if(isDefined(param_00.var_2988)) {
            param_00 func_1EB8(var_0A, var_07, var_12, var_13);
            param_00 func_1F09(var_04, var_15, var_15 * 0.5, var_15 * 0.5);
            param_00.var_3BA7 = 1;
          } else {
            param_00.var_3BA7 = func_A09C(param_00, param_02);
          }
        }

        if(param_00.var_3BA7) {
          param_00 func_1EB8(var_0A, var_14, var_14 * 0.5, var_14 * 0.5);
          param_00 func_1F09(var_04, var_14, var_14 * 0.5, var_14 * 0.5);
          param_02.var_4800 = "waiting";
        }
      }
    }

    func_841A();
  }

  if(isDefined(var_0A.var_2988)) {
    if(isDefined(var_0A.var_4802)) {
      var_0A.var_0116 = var_0A.var_4802;
      var_0A.var_001D = var_14;
    }

    var_0A method_808C();
    var_0A.var_2988 = undefined;
  }

  if(getdvarint("5666", 0) == 0) {
    wait(1);
    setDvar("5666", "1");
    thread func_8A5F();
  }
}

func_8A5F() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");
  if(level.var_A595.size > 0 && isDefined(level.var_A595[0]) && isDefined(level.var_A595[0].var_7704) && func_5854(level.var_A595[0].var_7704)) {
    level.var_6651 = undefined;
    wait(0.5);
    setDvar("3965", "1");
    return;
  }

  level.var_6651 = 1;
}

func_7D77() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");
  level.var_6651 = undefined;
  wait(0.25);
  setDvar("3965", "0");
}

func_4590(param_00, param_01, param_02) {
  if(abs(param_01 - param_00.var_7EF8) > 100) {
    if(param_01 >= 270) {
      param_00.var_09F8 = param_00.var_09F8 + -360 * param_02;
      if(param_00.var_09F8 == -360) {
        param_00.var_09F8 = 0;
      }
    }

    if(param_01 <= 100) {
      param_00.var_09F8 = param_00.var_09F8 + 360 * param_02;
      if(param_00.var_09F8 == 360) {
        param_00.var_09F8 = 0;
      }
    }
  }

  param_00.var_7EF8 = param_01;
  var_03 = param_01 * param_02 + param_00.var_09F8;
  return var_03;
}

func_1FA6(param_00, param_01, param_02) {
  maps\mp\hub_vl_base::func_7E92(param_01, 0.5);
  param_02.var_1FAA = param_02.var_1FA9;
  var_03 = param_01.var_0116 + (0, 0, -20) + anglesToForward(param_01.var_8F80) * 120;
  param_02.var_ACC5 = param_02.var_1F8F;
  param_02.var_3018 = param_02.var_1F9C + param_02.var_1F94 - param_02.var_1F9C * param_02.var_ACC5;
  var_04 = param_02.var_1F90 + param_02.var_1F91 * param_02.var_ACC5;
  var_05 = param_02.var_1FA4 + param_02.var_1FA5 * 1 - param_02.var_ACC5;
  param_02.var_9933 = param_02.var_1F92 + param_02.var_768C * param_02.var_ACC5 - 1;
  param_00 func_A09D(param_02);
  var_06 = param_02.var_2096 + param_02.var_2095 - param_02.var_2096 * param_02.var_ACC5;
  var_07 = param_01.var_0116 + (0, 0, var_05);
  var_08 = var_07 - var_03 + param_02.var_6C41;
  var_08 = param_02.var_3018 * vectornormalize(var_08);
  var_08 = (var_08[0], var_08[1], -1 * var_04);
  var_08 = param_02.var_3018 * vectornormalize(var_08);
  var_09 = var_07 - var_08;
  if(isDefined(self.var_1FA8)) {
    var_07 = var_07 + self.var_1FA8;
    var_09 = var_09 + self.var_1FA8;
  }

  var_0A = -1 * var_08;
  var_0B = vectortoangles(var_0A);
  param_02.var_0DCF = var_0B[1] - param_01.var_92B8[1];
  var_0C = distance(param_00.var_0116, var_09);
  var_0D = var_0C / param_02.var_768A;
  if(var_0D < 0.1) {
    var_0D = 0.1;
  }

  param_00 func_1EB8(var_09, var_0D, var_0D * 0.5, var_0D * 0.5);
  var_0E = func_1E3F(var_09, var_07, param_02);
  var_0F = vectortoangles(var_0E);
  param_00 func_1F09(var_0F, var_0D, var_0D * 0.5, var_0D * 0.5);
  if(isDefined(param_00.var_2988)) {
    param_00 method_808C();
    param_00.var_2988 = undefined;
  }
}

func_924B(param_00, param_01) {}

func_2317(param_00, param_01, param_02) {
  var_03 = (0, 87, 0);
  if(isDefined(param_01.var_13B6)) {
    var_03 = (0, param_01.var_13B6.var_001D[1] + 180, 0);
  }

  param_00 func_A09D(param_02);
  var_04 = (14, 0, 0);
  var_05 = param_01.var_0116 + var_04 + anglesToForward(param_01.var_13B6.var_001D) * 110;
  var_06 = (var_05[0], var_05[1], param_02.var_3FBB);
  param_00.var_4802 = var_06;
  var_07 = distance(param_00.var_0116, var_06);
  var_08 = max(var_07 / param_02.var_3FB0, 0.1);
  var_09 = 0.2;
  param_00 func_1EB8(var_06, var_08, 0, 0);
  param_00 func_1F09(var_03, var_09, 0, 0);
  maps\mp\hub_vl_base::func_7E92(param_01, 0.5);
}

func_635D(param_00) {
  self endon("disconnect");
  for(;;) {
    var_01 = getdvarint("virtualLobbyMode", 0);
    if(param_00.var_627E != "cao" && param_00.var_627E != "cac") {
      if(param_00.var_627E != "prelobby" && var_01 == 0) {
        param_00.var_669A = "game_lobby";
      }

      if(issubstr(param_00.var_627E, "prelobby") && var_01 == 1) {
        param_00.var_669A = "game_lobby";
      }
    }

    wait 0.05;
  }
}

func_3B96() {
  var_00 = self.var_0165;
  var_00 = int(var_00);
  return var_00;
}

func_6338() {}

func_A66A(param_00) {
  var_01 = isDefined(self.var_1DF8);
  var_02 = getdvarint("664") && param_00.var_6DAC != 0;
  if(!var_01 && !var_02) {
    func_8BBB(param_00);
  }
}

func_A66B(param_00, param_01) {
  self endon("disconnect");
  param_01 endon("wait_load_costume");
  param_01 endon("death");
  wait(param_00);
  func_A66A(param_01);
  param_01 notify("wait_load_costume");
}

func_A669(param_00, param_01) {
  self endon("disconnect");
  param_00 notify("wait_load_costume");
  param_00 endon("wait_load_costume");
  param_00 endon("death");
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  func_4CCD(param_00);
  thread func_A66B(5, param_00);
  var_02 = self loadcostumemodels(param_00.var_267E, param_00.var_01A7);
  while(!var_02) {
    wait(0.1);
    var_02 = self loadcostumemodels(param_00.var_267E, param_00.var_01A7);
  }

  if(param_01) {
    func_A66A(param_00);
  }

  param_00 notify("wait_load_costume");
}

func_8F7D(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  if(!isDefined(param_0B)) {
    param_0B = 0;
  }

  if(!isDefined(param_0C)) {
    param_0C = 0;
  }

  var_0E = !param_0C;
  var_0F = "spectator";
  var_10 = "none";
  var_11 = maps\mp\hub_vl_base::func_0C0E();
  var_12 = "avatar";
  var_13 = param_0A;
  if(param_0B) {
    var_12 = "cao_agent";
    var_13 = var_13 | -32768;
  }

  if(param_0C) {
    var_12 = "clan_agent";
    var_13 = var_13 | 16384;
  }

  var_11.var_01A5 = var_12;
  for(var_14 = 0; var_14 < 48; var_14++) {
    var_11.var_A561[var_14] = 0;
  }

  param_00.var_9042 = var_11;
  var_11.var_13B6 = param_00;
  var_11.var_267E = param_08;
  var_11.var_08D2 = 0;
  var_11.var_7EF4 = 0;
  if(param_0B) {
    var_15 = var_11.var_13B6.var_0116;
  } else {
    var_15 = getgroundposition(var_12.var_13B6.var_0116, 20, 512, 60);
  }

  var_11.var_8F80 = (param_00.var_001D[0], param_00.var_001D[1] + var_11.var_7EF4, param_00.var_001D[2]);
  var_11.var_001D = var_11.var_8F80;
  if(!param_0C && !level.var_A1FE) {
    var_11 method_805B();
  }

  var_11.var_6DAC = param_0A;
  var_11.var_0116 = var_15;
  var_11.var_001D = var_11.var_8F80;
  var_11.var_92B8 = var_11.var_8F80;
  var_11.var_942A = var_11.var_001D[1];
  var_11.var_6469 = 0;
  var_11.var_942C = 0;
  var_11.var_7EF8 = 0;
  var_11.var_09F8 = 0;
  var_11.var_1E9B = 1;
  var_11.var_721C = self;
  if(!isDefined(param_0D) || !param_0D) {
    var_16 = var_11.var_13B6.var_0116 + (0, 0, -11);
    var_11.var_20F1 = var_13;
    func_05E0(self getentitynumber(), var_13, "create", var_16);
    func_05E0(self getentitynumber(), var_13, "angles", var_11.var_001D);
    if(isDefined(self)) {
      var_11.var_A561[self.var_2418] = 1;
    }
  }

  var_11.var_1EAF = (0, 0, 0);
  var_11.var_1EAE = (0, 0, 0);
  if(!isDefined(self.var_9042)) {
    self.var_9042 = var_11;
  }

  if(param_0B == 1) {
    var_11.var_5541 = 1;
    param_02 = undefined;
    var_11.var_7704 = undefined;
    var_11 func_A1D5("cao_01", 1, "lobby_idle");
  } else if(param_0C == 1) {
    param_02 = undefined;
    var_11.var_7704 = undefined;
    var_11 func_A1D5("cao_01", 1, "lobby_idle");
  } else {
    level.var_A595[param_0A] = var_11;
    var_17 = var_11 func_441B(param_02);
    var_11 func_A1D5(var_17.var_0BB4, 1, var_17.var_0EE8);
    var_11 thread func_21F1(param_02, param_03, param_04, self);
  }

  func_A587(self, param_0A, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, var_11);
  thread func_A669(var_11, var_0E);
  if((getdvarint("664") && param_0A != 0) || param_0C) {
    func_4CCD(var_11);
  } else {
    func_8BBB(var_11);
  }

  return var_11;
}

func_21F1(param_00, param_01, param_02, param_03) {
  param_03 endon("disconnect");
  self endon("death");
  self endon("free_avatar");
  self.var_9428 = "m1garand_mp";
  if(!isDefined(param_00) && param_00 != "none") {
    self.var_9428 = param_00;
  } else if(isDefined(param_01) && param_01 != "none") {
    self.var_9428 = param_01;
  } else if(isDefined(param_02) && param_02 != "none") {
    self.var_9428 = param_02;
  }

  var_04 = undefined;
  for(;;) {
    if(!isDefined(self.var_7705)) {
      wait 0.05;
      continue;
    }

    if(isDefined(self) && isDefined(self.var_7704) && self.var_7704 != "none") {
      var_05 = strtok(self.var_7704, "+");
      var_04 = var_05[0];
    }

    var_06 = self.var_0EEC;
    var_07 = level.var_0EE9["lobby_idle"]["cao_01"];
    var_08 = func_441B(var_04);
    var_09 = var_07;
    if(isDefined(level.var_0EE9[var_08.var_0EE8]) && isDefined(level.var_0EE9[var_08.var_0EE8][var_08.var_0BB4])) {
      var_09 = level.var_0EE9[var_08.var_0EE8][var_08.var_0BB4];
    }

    if(isDefined(param_03.var_1EFF.var_627E)) {
      if(param_03.var_1EFF.var_669A != "cao" && param_03.var_1EFF.var_627E != "cao") {
        if(isDefined(self) && isDefined(var_04) && self.var_7704 != "none") {
          var_0C = func_5854(self.var_7704);
          var_0D = self.var_9428 != self.var_7704;
          var_0E = var_0D || var_06 != var_09;
          var_0F = self.var_9428 != "none" && getweapondisplayname(self.var_9428) != getweapondisplayname(self.var_7704);
          if(function_01A9(self.var_7704) == "melee") {
            func_4CCF(self);
            func_4CCE(self);
          } else if(var_0E) {
            if(var_0C) {
              if(var_0F) {
                func_4CCF(self);
                func_4CCE(self);
                thread func_115D(self, param_03);
                thread func_8C12(self, param_03);
              }

              if(level.var_A1FE) {
                func_05E0(param_03 getentitynumber(), self.var_20F1, "prim_weapon", self.var_7704);
              } else {
                self.var_7705 method_848E(self.var_7704);
              }

              if(issubstr(self.var_7704, "akimbo")) {
                if(var_0F) {
                  func_A58A(param_03, self);
                }
              } else {
                func_A593(param_03.var_01D6, self);
              }

              self.var_9428 = self.var_7704;
              var_08 = func_441B(var_04);
              self.var_1EAD = var_08.var_1EAD;
              thread func_0EB2(var_08.var_0BB4, var_08.var_0EE8, param_03);
            }
          }
        }
      }
    }

    wait(0.5);
  }
}

func_5854(param_00) {
  var_01 = 0;
  if(level.var_744A.size > 0) {
    var_01 = level.var_744A[0] method_8530(param_00);
    if(!var_01) {
      level.var_744A[0] method_8512(param_00);
    }
  }

  return var_01;
}

func_115D(param_00, param_01) {
  wait(param_01.var_1EFF.var_1E28);
  func_1158(param_00);
}

func_0EB2(param_00, param_01, param_02) {
  wait(param_02.var_1EFF.var_1E27);
  func_A1D5(param_00, undefined, param_01);
}

func_441B(param_00) {
  param_00 = maps\mp\_utility::func_4431(param_00);
  var_01 = spawnStruct();
  var_01.var_0BB4 = param_00;
  if(isDefined(param_00) && param_00 != "" && param_00 != "none") {
    var_01.var_0EE8 = tablelookup("mp/vlobby_cac_offsets.csv", 0, param_00, 5);
    var_01.var_1EAD = tablelookup("mp/vlobby_cac_offsets.csv", 0, param_00, 6);
    if(isDefined(var_01.var_1EAD)) {
      if(var_01.var_1EAD == "") {
        self.var_1EAD = "stand";
      } else {
        self.var_1EAD = var_01.var_1EAD;
      }
    }
  }

  if(!isDefined(var_01.var_0EE8) || var_01.var_0EE8 == "") {
    var_01.var_0EE8 = "lobby_idle";
    var_01.var_0BB4 = "cao_01";
    var_01.var_1EAD = "stand";
  }

  if(!isDefined(var_01.var_1EAD)) {
    var_01.var_1EAD = "stand";
  }

  if(!isDefined(self.var_1EAD)) {
    self.var_1EAD = var_01.var_1EAD;
  }

  return var_01;
}

func_A593(param_00, param_01) {
  if(isDefined(param_01.var_0BA9)) {
    if(level.var_A1FE) {
      func_05E0(param_01.var_721C getentitynumber(), param_01.var_20F1, "sec_weapon", "");
      return;
    }

    function_02BA(param_01.var_0BA9, param_00, 1);
    param_01.var_0BA9 delete();
    param_01.var_0BA9 = undefined;
  }
}

func_A58A(param_00, param_01) {
  if(issubstr(param_01.var_7705.var_7704, "akimbo")) {
    if(!isDefined(param_01.var_0BA9)) {
      if(level.var_A1FE) {
        var_02 = spawnStruct();
      } else {
        var_02 = spawn("weapon_" + var_02.var_7704, (0, 0, 0));
        var_03 = func_43EA(param_01);
        function_02BA(var_02, var_03);
      }

      param_01.var_0BA9 = var_02;
      var_02.var_7704 = param_01.var_7704;
    } else if(param_01.var_0BA9.var_7704 != param_01.var_7704) {
      param_01.var_0BA9.var_7704 = param_01.var_7704;
    }

    if(!level.var_A1FE) {
      param_01.var_0BA9 method_848E(param_01.var_7704);
      var_04 = "tag_weapon_left";
      if(issubstr(param_01.var_0BA9.var_7704, "combatknife")) {
        var_04 = "tag_inhand";
      }

      if(issubstr(param_01.var_0BA9.var_7704, "riotshield")) {
        var_04 = "tag_weapon_left";
      }

      param_01.var_0BA9 unlink();
      param_01.var_0BA9.var_0116 = param_01 gettagorigin(var_04);
      param_01.var_0BA9.var_001D = param_01 gettagangles(var_04);
      param_01.var_0BA9 method_805C();
      param_01.var_0BA9 showtoclient(param_00);
      param_01.var_0BA9 method_8449(param_01, var_04);
      param_01.var_0BA9 method_852B(param_00);
    } else {
      func_05E0(param_00 getentitynumber(), param_01.var_20F1, "sec_weapon", param_01.var_0BA9.var_7704);
    }

    if(issubstr(param_01.var_7705.var_7704, "akimbo")) {
      thread func_8BE9(param_01, param_00);
      return;
    }

    if(!isDefined(param_01.var_9428)) {
      if(!level.var_A1FE) {
        param_01.var_0BA9 method_805C();
        param_01.var_0BA9 hideallparts();
        return;
      }

      return;
    }
  }
}

func_A58D(param_00, param_01) {
  if(!isDefined(param_01.var_7704)) {
    return;
  }

  if(!isDefined(param_01.var_0E93)) {
    return;
  }

  if(param_01.var_7704 != "none") {
    if(!isDefined(param_01.var_7705)) {
      if(level.var_A1FE) {
        var_02 = spawnStruct();
      } else {
        var_02 = spawn("weapon_" + var_02.var_7704, (0, 0, 0));
        var_03 = func_43EA(param_01);
        function_02BA(var_02, var_03);
      }

      var_02.var_01A5 = "avatar_weapon";
      param_01.var_7705 = var_02;
      var_02.var_7704 = param_01.var_7704;
      if(!level.var_A1FE) {
        param_01.var_7705 method_805C();
        param_01.var_7705 showtoclient(param_00);
        param_01.var_7705 method_848E(param_01.var_7704);
      }

      func_1158(param_01);
      return;
    }

    if(param_01.var_7705.var_7704 != param_01.var_7704) {
      param_01.var_7705.var_7704 = param_01.var_7704;
      return;
    }

    return;
  }
}

func_1158(param_00) {
  var_01 = undefined;
  if(isDefined(param_00.var_721C)) {
    var_01 = param_00.var_721C;
  }

  var_02 = "tag_weapon_right";
  if(issubstr(param_00.var_7705.var_7704, "combatknife")) {
    var_02 = "tag_inhand";
  }

  if(issubstr(param_00.var_7705.var_7704, "riotshield")) {
    var_02 = "tag_weapon_left";
  }

  if(level.var_A1FE) {
    func_05E0(var_01 getentitynumber(), param_00.var_20F1, "prim_weapon", param_00.var_7704);
    return;
  }

  param_00.var_7705 unlink();
  param_00.var_7705.var_0116 = param_00 gettagorigin(var_02);
  param_00.var_7705.var_001D = param_00 gettagangles(var_02);
  param_00.var_7705 method_8449(param_00, var_02);
  param_00.var_7705 method_852B(var_01);
}

func_8BE9(param_00, param_01) {
  param_00 endon("death");
  param_00.var_7705 endon("death");
  param_00 endon("hide_akimbo_weapon");
  wait(param_01.var_1EFF.var_1E29);
  if(param_01.var_1EFF.var_669A != "cao" && param_01.var_1EFF.var_627E != "cao") {
    if(issubstr(param_00.var_7705.var_7704, "akimbo")) {
      if(!level.var_A1FE) {
        param_00.var_0BA9 showtoclient(param_01);
        return;
      }
    }
  }
}

func_8C12(param_00, param_01) {
  param_00 endon("death");
  param_00.var_7705 endon("death");
  param_00 endon("hide_primary_weapon");
  wait(param_01.var_1EFF.var_1E29);
  var_02 = getdvarint("664") && param_00.var_6DAC != 0;
  if(param_01.var_1EFF.var_669A != "cao" && param_01.var_1EFF.var_627E != "cao" && !var_02) {
    if(!level.var_A1FE) {
      param_00.var_7705 showtoclient(param_01);
    }
  }
}

func_A586(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    param_00.var_267E = param_01;
  }

  var_03 = "free";
  if(isDefined(param_00.var_76D2)) {
    if(param_00.var_76D2 & 1 == 0) {
      var_03 = "allies";
    }

    if(param_00.var_76D2 & 1 == 1) {
      var_03 = "axis";
    }
  }

  if(!isDefined(param_00.var_267E) || !maps\mp\gametypes\_teams::func_A27D(param_00.var_267E, var_03)) {
    if(isDefined(param_00.var_83F4) && maps\mp\gametypes\_teams::func_A27D(param_00.var_83F4, var_03)) {
      param_00.var_267E = param_00.var_83F4;
    } else {
      param_00.var_267E = maps\mp\gametypes\_teams::func_448C();
      param_00.var_83F4 = param_00.var_267E;
    }
  }

  if(isDefined(param_02) && param_02) {
    self.var_267E = param_00.var_267E;
    var_04 = maps\mp\gametypes\_teams::func_73CA();
    if(!isDefined(param_00.var_5097) || !param_00.var_5097) {
      if(level.var_A1FE) {
        func_05E0(param_00.var_721C getentitynumber(), param_00.var_20F1, "costume", param_00.var_267E[0], param_00.var_267E[1], param_00.var_267E[2], param_00.var_267E[3], param_00.var_267E[4], param_00.var_267E[5]);
      } else {
        param_00 setcostumemodels(param_00.var_267E, "free");
      }
    }

    if(isDefined(self.var_1F8E)) {
      var_05 = self.var_1F8E;
      func_A586(var_05, param_00.var_267E);
      if(!isDefined(var_05.var_5097) || !var_05.var_5097) {
        if(level.var_A1FE) {
          func_05E0(var_05.var_721C getentitynumber(), var_05.var_20F1, "costume", param_00.var_267E[0], param_00.var_267E[1], param_00.var_267E[2], param_00.var_267E[3], param_00.var_267E[4], param_00.var_267E[5]);
          return;
        }

        var_05 setcostumemodels(var_05.var_267E, "free");
        return;
      }

      return;
    }

    return;
  }

  if(!isDefined(param_01.var_5097) || !param_01.var_5097) {
    if(level.var_A1FE) {
      func_05E0(param_01.var_721C getentitynumber(), param_01.var_20F1, "costume", param_01.var_267E[0], param_01.var_267E[1], param_01.var_267E[2], param_01.var_267E[3], param_01.var_267E[4], param_01.var_267E[5]);
      return;
    }

    param_01 setcostumemodels(param_01.var_267E, "free");
    return;
  }
}

func_A587(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_0A)) {
    param_0A = level.var_A595[param_01];
  }

  var_0B = 0;
  if(isDefined(param_0A.var_5DEE) && param_0A.var_5DEE.var_012F >= 0) {
    var_0B = 1;
  }

  func_A586(param_0A, param_09);
  if(var_0B && isDefined(param_00)) {
    if(level.var_A1FE) {
      func_05E0(param_00 getentitynumber(), param_0A.var_20F1, "costume", param_0A.var_267E[0], param_0A.var_267E[1], param_0A.var_267E[2], param_0A.var_267E[3], param_0A.var_267E[4], param_0A.var_267E[5]);
    }

    param_00 setcostumemodels(param_0A.var_267E);
  }

  var_0D = "m1garand_mp";
  if(!isDefined(param_03)) {
    var_0D = undefined;
  } else if(param_03 != "none") {
    var_0D = param_03;
  } else if(isDefined(param_04) && param_04 != "none") {
    var_0D = param_04;
  } else if(isDefined(param_05) && param_05 != "none") {
    var_0D = param_05;
  }

  param_0A.var_0079 = param_02;
  param_0A.var_7704 = var_0D;
  param_0A.var_01A0 = param_07;
  param_0A.var_00ED = param_06;
  param_0A.var_6F65 = param_08;
  func_A58D(param_00, param_0A);
}

func_62F5(param_00) {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if((var_01 == "classpreview" || var_01 == "classpreview_postcopy") && isDefined(var_02)) {
      if(var_02 >= 0) {
        var_03 = var_02 & 15;
        var_04 = int(var_02 / 16);
        maps\mp\hub_vl_base::func_A59E("classpreview " + var_01 + " controller=" + var_03 + "class=" + var_04 + " owner " + param_00);
        if(var_04 > 0) {
          self.var_1DF8 = 1;
          self.var_294D = var_04 - 1;
        }

        var_05 = var_01 == "classpreview_postcopy";
        var_06 = level.var_A595[param_00];
        if(isDefined(var_06)) {
          self.var_A58C = param_00;
          func_A558(param_00, "lobby" + self.var_294D + 1, !var_05);
          self.var_1E1F = var_06.var_7704;
        }

        level.var_3E0C = var_05;
        continue;
      }

      self.var_1DF8 = undefined;
    }
  }
}

func_62EC(param_00, param_01) {
  var_02 = "";
  if(param_01 != "current" && param_01 != "none" && var_02 == "") {
    var_03 = tablelookup("mp/statstable.csv", 2, param_01, 9);
    if(var_03 == "") {
      var_03 = 0;
    }

    var_04 = maps\mp\gametypes\_class::func_1D66(param_01, var_03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  } else if(var_02 == "none") {
    var_04 = "none";
  } else {
    var_05 = level.var_A595[param_01];
    var_04 = var_05.var_7704;
  }

  self.var_1E1F = var_04;
}

func_4B46(param_00, param_01) {
  if(param_00.size >= param_01.size) {
    if(getsubstr(param_00, param_00.size - param_01.size, param_00.size) == param_01) {
      return 1;
    }
  }

  return 0;
}

func_62F8(param_00) {
  self endon("disconnect");
  var_01 = [];
  while(!isDefined(self.var_1EFF)) {
    self waittill("luinotifyserver", var_02, var_03);
    if(isDefined(var_03)) {
      var_01[var_01.size] = [var_02, var_03];
      continue;
    }

    var_01[var_01.size] = [var_02];
  }

  for(;;) {
    if(var_01.size > 0) {
      var_04 = var_01[0];
      var_05 = [];
      for(var_06 = 1; var_06 < var_01.size; var_06++) {
        var_05[var_05.size] = var_01[var_06];
      }

      var_01 = var_05;
      var_02 = var_04[0];
      if(var_04.size > 1) {
        var_03 = var_04[1];
      } else {
        var_03 = undefined;
      }
    } else {
      self waittill("luinotifyserver", var_05, var_06);
    }

    if(var_05 == "cac" && isDefined(var_06)) {
      if(var_06 == 0) {
        self.var_1DF8 = undefined;
      } else {
        self.var_1DF8 = 1;
      }

      self.var_A588 = undefined;
      continue;
    }

    if(var_05 == "weapon_highlighted" && isDefined(var_06)) {
      if(issubstr(var_06, "stream:")) {
        var_07 = strtok(var_06, ":");
        if(var_07.size > 1) {
          var_08 = var_07[var_07.size - 1];
          if(!func_4B46(var_08, "_mp")) {
            var_08 = var_08 + "_mp";
          }

          maps\mp\hub_vl_base::func_A59F("weapon_stream: " + var_08);
          var_09 = [var_08];
          self method_8512(var_09);
        }

        func_62EC(var_03, "none");
      } else {
        maps\mp\hub_vl_base::func_A59F("weapon_highlighted" + var_06);
        func_62EC(var_03, var_06);
      }

      continue;
    }

    if(var_05 == "lootscreen_weapon_highlighted" && isDefined(var_06)) {
      if(var_06 == "none") {
        self.var_1DF8 = undefined;
      } else if(var_06 == "reset") {
        self.var_1DF8 = 1;
      } else {
        self.var_1DF8 = 1;
      }

      self.var_A588 = undefined;
      continue;
    }

    var_0A = 0;
    if(var_05 == "preview_attach1") {
      var_0A = 1;
    } else if(var_05 == "preview_attach2") {
      var_0A = 2;
    } else if(var_05 == "preview_attach3") {
      var_0A = 3;
    }

    if(var_0A > 0 && isDefined(var_06)) {
      var_0B = level.var_A595[var_03];
      var_0C = var_0B.var_5DEE;
      var_0D = var_0C.var_013B;
      var_0E = tablelookup("mp/attachmenttable.csv", 0, var_0C.var_013C, 3);
      var_0F = tablelookup("mp/attachmenttable.csv", 0, var_0C.var_013D, 3);
      var_10 = tablelookup("mp/attachmenttable.csv", 0, var_0C.var_013E, 3);
      var_11 = tablelookup("mp/attachmenttable.csv", 0, var_0C.var_013F, 3);
      var_12 = tablelookup("mp/attachmenttable.csv", 0, var_0C.var_0140, 3);
      var_13 = tablelookup("mp/attachmenttable.csv", 0, var_0C.var_0141, 3);
      var_14 = var_0C.var_0142;
      if(var_06 != "current") {
        if(var_0A == 1) {
          var_0E = var_06;
        } else if(var_0A == 2) {
          var_0F = var_06;
        } else if(var_0A == 3) {
          var_10 = var_06;
        } else if(var_0A == 4) {
          var_11 = var_06;
        } else if(var_0A == 5) {
          var_12 = var_06;
        } else if(var_0A == 6) {
          var_13 = var_06;
        }
      }

      self.var_1E1F = maps\mp\gametypes\_class::func_1D66(maps\mp\_utility::func_452B(var_0D), var_0E, var_0F, var_10, var_11, var_12, var_13, maps\mp\_utility::func_472C(var_0D), var_14, 0, 0);
    }
  }
}

func_44E9(param_00) {
  foreach(var_03, var_02 in level.var_A595) {
    if(isDefined(var_02.var_5DEE) && isDefined(var_02.var_5DEE.var_012F) && var_02.var_5DEE.var_012F == param_00) {
      return var_03;
    }
  }

  maps\mp\hub_vl_base::func_A59F("unable to find avatar for controller " + param_00);
  return -1;
}

func_A558(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(self.var_012C["class"]) && self.var_012C["class"] == param_01 && !isDefined(param_03) || !param_03) {
    return;
  }

  self.var_012C["class"] = param_01;
  self.var_2319 = param_01;
  maps\mp\gametypes\_class::func_864F(self.var_012C["class"]);
  self.var_95AE = undefined;
  self.var_95AF = undefined;
  maps\mp\gametypes\_class::func_4773(self.var_012C["team"], self.var_012C["class"]);
  if(param_02) {
    func_A587(self, param_00, self.var_7704, self.var_835A, self.var_60FA, self.var_5DF4, self.var_5DF7, self.var_6F65, self.var_267E);
    if(isDefined(self.var_1F8E)) {
      func_A587(self, param_00, undefined, self.var_835A, self.var_60FA, self.var_5DF4, self.var_5DF7, self.var_6F65, self.var_267E, self.var_1F8E);
    }
  }
}

func_4835() {
  var_00 = ["privateMatchCustomClasses", "customClasses"];
  var_01 = [10, 20];
  var_02 = 0;
  self.var_5E01 = [];
  self.var_294D = 0;
  foreach(var_04 in var_00) {
    level.var_3E0E = var_04;
    self.var_5E01[var_04] = [];
    var_05 = var_01[var_02];
    var_02++;
    for(var_06 = 0; var_06 < var_05; var_06++) {
      self.var_5E01[var_04][var_06] = maps\mp\gametypes\_hub_unk1::func_4834(var_04, var_06);
    }
  }

  level.var_3E0E = undefined;
}

func_A0AD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10, param_11, param_12, param_13, param_14, param_15, param_16, param_17, param_18, param_19, param_1A, param_1B, param_1C, param_1D, param_1E, param_1F, param_20) {
  var_21 = int(self.var_294D);
  var_22 = maps\mp\_utility::func_1E01();
  self.var_5E01[var_22][var_21]["division"] = param_00;
  self.var_5E01[var_22][var_21]["primaryWeaponStruct"] = maps\mp\_utility::func_473C(param_01, 0);
  self.var_5E01[var_22][var_21]["primaryAttachmentsGUID"][0] = param_02;
  self.var_5E01[var_22][var_21]["primaryAttachmentsGUID"][1] = param_03;
  self.var_5E01[var_22][var_21]["primaryAttachmentsGUID"][2] = param_04;
  self.var_5E01[var_22][var_21]["primaryAttachmentsGUID"][3] = param_05;
  self.var_5E01[var_22][var_21]["primaryAttachmentsGUID"][4] = param_06;
  self.var_5E01[var_22][var_21]["primaryAttachmentsGUID"][5] = param_07;
  self.var_5E01[var_22][var_21]["primaryCamoGUID"] = param_08;
  self.var_5E01[var_22][var_21]["primaryReticleGUID"] = param_09;
  self.var_5E01[var_22][var_21]["primaryCustomization"] = param_1F;
  self.var_5E01[var_22][var_21]["secondaryWeaponStruct"] = maps\mp\_utility::func_473C(param_0A, 0);
  self.var_5E01[var_22][var_21]["secondaryAttachmentsGUID"][0] = param_0B;
  self.var_5E01[var_22][var_21]["secondaryAttachmentsGUID"][1] = param_0C;
  self.var_5E01[var_22][var_21]["secondaryAttachmentsGUID"][2] = param_0D;
  self.var_5E01[var_22][var_21]["secondaryAttachmentsGUID"][3] = param_0E;
  self.var_5E01[var_22][var_21]["secondaryAttachmentsGUID"][4] = param_0F;
  self.var_5E01[var_22][var_21]["secondaryAttachmentsGUID"][5] = param_10;
  self.var_5E01[var_22][var_21]["secondaryCamoGUID"] = param_11;
  self.var_5E01[var_22][var_21]["secondaryReticleGUID"] = param_12;
  self.var_5E01[var_22][var_21]["secondaryCustomization"] = param_20;
  self.var_5E01[var_22][var_21]["meleeWeaponStruct"] = maps\mp\_utility::func_473C(param_13, 0);
  self.var_5E01[var_22][var_21]["equipmentStruct"] = maps\mp\_utility::func_44CE(param_14, 0);
  self.var_5E01[var_22][var_21]["lethalGUID"] = param_14;
  self.var_5E01[var_22][var_21]["offhandStruct"] = maps\mp\_utility::func_44CE(param_15, 0);
  self.var_5E01[var_22][var_21]["tacticalGUID"] = param_15;
  self.var_5E01[var_22][var_21]["perkGUID0"] = param_16;
  self.var_5E01[var_22][var_21]["perkGUID1"] = param_17;
  self.var_5E01[var_22][var_21]["perkGUID2"] = param_18;
  self.var_5E01[var_22][var_21]["perkGUID3"] = param_19;
  self.var_5E01[var_22][var_21]["perkGUID4"] = param_1A;
  self.var_5E01[var_22][var_21]["perkGUID5"] = param_1B;
  self.var_5E01[var_22][var_21]["perkGUID6"] = param_1C;
  self.var_5E01[var_22][var_21]["perkGUID7"] = param_1D;
  self.var_5E01[var_22][var_21]["perkGUID8"] = param_1E;
}

func_5DEF(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 1;
  }

  if(param_00.var_013B != param_01.var_013B) {
    return 1;
  }

  if(param_00.var_013C != param_01.var_013C) {
    return 1;
  }

  if(param_00.var_013D != param_01.var_013D) {
    return 1;
  }

  if(param_00.var_013E != param_01.var_013E) {
    return 1;
  }

  if(param_00.var_013F != param_01.var_013F) {
    return 1;
  }

  if(param_00.var_0140 != param_01.var_0140) {
    return 1;
  }

  if(param_00.var_0141 != param_01.var_0141) {
    return 1;
  }

  if(param_00.var_0142 != param_01.var_0142) {
    return 1;
  }

  if(param_00.var_0143 != param_01.var_0143) {
    return 1;
  }

  if(param_00.var_016E != param_01.var_016E) {
    return 1;
  }

  if(param_00.var_0170 != param_01.var_0170) {
    return 1;
  }

  if(param_00.var_0171 != param_01.var_0171) {
    return 1;
  }

  if(param_00.var_0172 != param_01.var_0172) {
    return 1;
  }

  if(param_00.var_8350 != param_01.var_8350) {
    return 1;
  }

  if(param_00.var_8351 != param_01.var_8351) {
    return 1;
  }

  if(param_00.var_8352 != param_01.var_8352) {
    return 1;
  }

  if(param_00.var_0173 != param_01.var_0173) {
    return 1;
  }

  if(param_00.var_0174 != param_01.var_0174) {
    return 1;
  }

  if(param_00.var_01A0 != param_01.var_01A0) {
    return 1;
  }

  if(param_00.var_00ED != param_01.var_00ED) {
    return 1;
  }

  return 0;
}

func_267F(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    if(!isDefined(param_01)) {
      return 0;
    }

    return 1;
  }

  if(param_00.size != param_01.size) {
    return 1;
  }

  if(!maps\mp\gametypes\_teams::func_A27D(param_01, param_02)) {
    return 0;
  }

  for(var_03 = 0; var_03 < param_01.size; var_03++) {
    if(param_01[var_03] < 0) {
      return 0;
    }

    if(param_00[var_03] != param_01[var_03]) {
      return 1;
    }
  }

  return 0;
}

func_8660(param_00) {
  if(param_00[level.var_2682["head"]] == 0) {
    param_00[level.var_2682["head"]] = 1;
  }

  if(!param_00[level.var_2682["shirt"]]) {
    param_00[level.var_2682["shirt"]] = 1;
  }

  if(!param_00[level.var_2682["pants"]]) {
    param_00[level.var_2682["pants"]] = 1;
  }

  if(!param_00[level.var_2682["gear"]]) {
    param_00[level.var_2682["gear"]] = 1;
  }

  return param_00;
}

func_3B94(param_00) {
  var_01 = undefined;
  foreach(var_03 in level.var_744A) {
    if(var_03.var_01D6 == param_00) {
      var_01 = var_03;
      break;
    }
  }

  return var_01;
}

func_631E() {
  level.var_60B7 = [];
  var_00 = maps\mp\_utility::func_4604();
  for(;;) {
    while(!isDefined(level.var_744A) || level.var_744A.size == 0) {
      wait 0.05;
    }

    while(isDefined(level.var_744A) && level.var_744A.size > 0) {
      var_01 = [];
      var_02 = [];
      var_03 = 0;
      var_04 = 0;
      var_05 = 0;
      foreach(var_2A, var_07 in level.var_60B7) {
        var_08 = var_07.var_0079;
        var_09 = var_07.var_013B;
        var_0A[0] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_013C, 3));
        var_0A[1] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_013D, 3));
        var_0A[2] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_013E, 3));
        var_0A[3] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_013F, 3));
        var_0A[4] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_0140, 3));
        var_0A[5] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_0141, 3));
        var_0B = var_07.var_0144;
        var_0C = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv", 0, var_07.var_0142, 1));
        var_0D = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv", 0, var_07.var_0143, 1));
        var_0E = maps\mp\_utility::func_452A(tablelookup("mp/reticleTable.csv", 0, var_07.var_0145, 1));
        var_0F = var_07.var_016E;
        var_10[0] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_0170, 3));
        var_10[1] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_0171, 3));
        var_10[2] = maps\mp\_utility::func_452A(tablelookup("mp/attachmenttable.csv", 0, var_07.var_0172, 3));
        var_10[3] = 0;
        var_10[4] = 0;
        var_10[5] = 0;
        var_11 = var_07.var_0176;
        var_12 = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv", 0, var_07.var_0173, 1));
        var_13 = maps\mp\_utility::func_452A(tablelookup("mp/camoTable.csv", 0, var_07.var_0174, 1));
        var_14 = maps\mp\_utility::func_452A(tablelookup("mp/reticleTable.csv", 0, var_07.var_0177, 1));
        var_15 = var_07.var_0101;
        var_16 = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_00ED, 1));
        var_17 = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_01A0, 1));
        var_18[0] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0123, 1));
        var_18[1] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0124, 1));
        var_18[2] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0125, 1));
        var_18[3] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0126, 1));
        var_18[4] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0127, 1));
        var_18[5] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0128, 1));
        var_18[6] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_0129, 1));
        var_18[7] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_012A, 1));
        var_18[8] = maps\mp\_utility::func_452A(tablelookup(var_00, 0, var_07.var_012B, 1));
        var_19 = 1;
        if(!maps\mp\gametypes\_class::func_5835(var_09, var_19) && !maps\mp\gametypes\_class::func_5839(var_0F, var_19)) {
          var_09 = maps\mp\gametypes\_class::func_9590(level.var_2324, 10, 0);
          for(var_1A = 0; var_1A < 6; var_1A++) {
            var_0A[var_1A] = 0;
          }
        }

        if(!maps\mp\gametypes\_class::func_5839(var_0F, var_19)) {
          var_0F = maps\mp\gametypes\_class::func_9590(level.var_2324, 10, 1);
          for(var_1A = 0; var_1A < 6; var_1A++) {
            var_10[var_1A] = 0;
          }
        }

        var_1B = maps\mp\gametypes\_class::func_1D66(maps\mp\_utility::func_452B(var_09), var_0A[0], var_0A[1], var_0A[2], var_0A[3], var_0A[4], var_0A[5], maps\mp\_utility::func_472C(var_09), var_0C, var_0E, var_0B);
        var_1C = maps\mp\gametypes\_class::func_1D66(maps\mp\_utility::func_452B(var_0F), var_10[0], var_10[1], var_10[2], var_10[3], var_10[4], var_10[5], maps\mp\_utility::func_472C(var_0F), var_12, var_14, var_11);
        var_1D = maps\mp\_utility::func_452B(var_15);
        var_1E = [];
        var_1E[level.var_2682["shirt"]] = var_07.var_017F;
        var_1E[level.var_2682["head"]] = var_07.var_00B9;
        var_1E[level.var_2682["pants"]] = var_07.var_011A;
        var_1E[level.var_2682["eyewear"]] = var_07.var_0091;
        var_1E[level.var_2682["hat"]] = var_07.var_00B8;
        var_1E[level.var_2682["gear"]] = var_07.var_00A8;
        var_1F = [];
        if(!isDefined(level.var_AAE2[var_07.var_01D6]) && maps\mp\hub_vl_base::func_0BC6()) {
          maps\mp\hub_vl_base::func_7E37(var_07.var_01D6);
        }

        var_20 = func_3B94(var_07.var_01D6);
        if(isDefined(var_20) && var_07.var_011C != 0) {
          var_02[var_04] = var_20;
          var_04++;
        } else if(!isDefined(var_20)) {}

        if(!isDefined(level.var_AAE2[var_07.var_01D6])) {
          if(var_07.var_011C != 0) {
            var_21 = maps\mp\hub_vl_base::func_0902(var_07.var_01D6);
            maps\mp\hub_vl_base::func_A59E("PartyMemberClassChange " + var_07.var_01D6 + " : " + var_1B + "," + var_1C + "," + var_16 + "," + var_17 + "\n");
            setDvar("1999", level.var_AAE2.size);
            var_22 = func_4696(var_21);
            if(isDefined(var_20)) {
              var_01[var_03] = var_20 func_8F7D(var_22, var_08, var_1B, var_1C, var_1D, var_16, var_17, var_1F, var_1E, var_07.var_0109, var_21, 0, 0, 0);
            } else {
              var_01[var_03] = func_8F7D(var_22, var_08, var_1B, var_1C, var_1D, var_16, var_17, var_1F, var_1E, var_07.var_0109, var_21, 0, 0, 0);
            }

            var_03++;
            maps\mp\hub_vl_base::func_13B4(var_21);
            function_02BA(level.var_A595[var_21], var_07.var_01D6);
            level.var_A595[var_21].var_5DEE = var_07;
            level.var_A595[var_21].var_6101 = gettime() + 4000;
            var_23 = getent("cao_spawnpoint", "targetname");
            var_20.var_1FA3 = var_23;
            var_20.var_1F9D = var_1B;
            if(isDefined(level.var_A589)) {
              func_4CCD(level.var_A595[var_21]);
            }
          }
        } else {
          var_21 = level.var_AAE2[var_09.var_01D6];
          var_24 = level.var_A595[var_22];
          if(var_08.var_011C != 0) {
            var_02[var_04] = var_24;
            var_04++;
          }

          if(var_08.var_012F >= 0) {
            foreach(var_26 in level.var_744A) {
              if(var_26.var_A58C == var_22) {
                var_26 func_A0AD(var_09, var_0A, var_0B[0], var_0B[1], var_0B[2], var_0B[3], var_0B[4], var_0B[5], var_0D, var_0F, var_10, var_11[0], var_11[1], var_11[2], var_11[3], var_11[4], var_11[5], var_13, var_15, var_16, var_17, var_18, var_19[0], var_19[1], var_19[2], var_19[3], var_19[4], var_19[5], var_19[6], var_19[7], var_19[8], var_0C, var_12);
              }
            }

            if(isDefined(var_24.var_76D2)) {
              if(isDefined(var_24.var_2685) && isDefined(var_24.var_2685[var_24.var_76D2])) {
                var_1F = var_24.var_2685[var_24.var_76D2];
              } else {
                var_1F = level.var_744A[0] maps\mp\gametypes\_class::func_1F97(var_24.var_76D2);
              }

              var_1F = func_8660(var_1F);
              if(!isDefined(var_24.var_2685)) {
                var_24.var_2685 = [];
              }

              var_24.var_2685[var_24.var_76D2] = var_1F;
              if(var_24.var_76D3 != "none") {
                var_28 = level.var_2682[var_24.var_76D3];
                var_1F[var_28] = var_24.var_76D4;
              }
            }
          }

          var_29 = "free";
          if(isDefined(var_27.var_76D2)) {
            if(var_27.var_76D2 & 1 == 0) {
              var_29 = "allies";
            }

            if(var_27.var_76D2 & 1 == 1) {
              var_29 = "axis";
            }

            var_21 = function_0282(var_21, var_29);
          }

          if(func_5DEF(var_27.var_5DEE, var_0B) || func_267F(var_27.var_267E, var_21, var_29) || isDefined(level.var_3E0C) && level.var_3E0C) {
            var_09 = 1;
            maps\mp\hub_vl_base::func_A59E("Updating xuid " + var_0B.var_01D6 + " with ownerId=" + var_26 + "\n");
            maps\mp\hub_vl_base::func_A59E("PartyMemberClassChange " + var_0B.var_01D6 + " : " + var_1F + "," + var_20 + "," + var_1B + "," + var_1C + "\n");
            if(isDefined(var_27.var_721C)) {
              var_27.var_721C.var_267E = var_21;
            }

            func_A587(var_27.var_721C, var_26, var_1F, var_20, var_2A, var_1B, var_1C, var_22, var_21);
            if(var_0B.var_012F >= 0 && isDefined(var_27.var_721C.var_1F8E)) {
              func_A587(var_27.var_721C, var_26, undefined, var_20, "none", var_1B, var_1C, var_22, var_21, var_27.var_721C.var_1F8E);
            }

            var_27.var_5DEE = var_0B;
            level.var_3E0C = 0;
          }
        }

        if(var_0B.var_011C != 0) {
          var_07++;
        }
      }

      func_13B9(var_01, var_02, var_05);
      level.var_60B7 = [];
      maps\mp\hub_vl_base::func_A095();
      wait 0.05;
    }
  }
}

func_13B9(param_00, param_01, param_02) {
  var_03 = 0;
  foreach(var_05 in param_00) {
    var_05 func_4697(var_03);
    var_06 = getgroundposition(var_05.var_13B6.var_0116, 20, 512, 60);
    var_07 = distance(var_06, var_05.var_0116) >= 0.1;
    var_05.var_0116 = var_06;
    func_4CCD(var_05);
    if(isDefined(var_05.var_20F1)) {
      var_08 = var_05.var_20F1;
    } else {
      var_08 = var_03 + 1;
      var_05.var_20F1 = var_08;
    }

    foreach(var_0A in param_01) {
      if(var_05.var_A561[var_0A.var_2418] == 0) {
        var_0B = var_0A getentitynumber();
        func_05E0(var_0A getentitynumber(), var_08, "create", var_05.var_0116);
        func_05E0(var_0A getentitynumber(), var_08, "angles", var_05.var_001D);
        func_05E0(var_0A getentitynumber(), var_08, "costume", var_05.var_267E[0], var_05.var_267E[1], var_05.var_267E[2], var_05.var_267E[3], var_05.var_267E[4], var_05.var_267E[5]);
        if(isDefined(var_05.var_0EEC)) {
          func_05E0(var_0A getentitynumber(), var_08, "anim", var_05.var_0EEC);
        }

        var_05.var_A561[var_0A.var_2418] = 1;
      } else if(param_02) {
        func_05E0(var_0A getentitynumber(), var_08, "costume", var_05.var_267E[0], var_05.var_267E[1], var_05.var_267E[2], var_05.var_267E[3], var_05.var_267E[4], var_05.var_267E[5]);
      }

      if(var_07) {
        func_05E0(var_0A getentitynumber(), var_08, "pos", var_05.var_0116);
      }
    }

    func_8BBB(var_05);
    var_03++;
  }
}

func_6CC1(param_00) {
  if(!isDefined(level.var_7613)) {
    level.var_7614 = function_027B(level.var_761B) - 1;
    level.var_7613 = randomint(level.var_7614);
  }

  if(!isDefined(level.var_7612)) {
    var_01 = function_027B(level.var_761A) - 1;
    level.var_7612 = randomint(var_01);
  }

  var_04 = param_00;
  var_05 = getcostumefromtable(level.var_761B, level.var_7613 + 1);
  var_04.var_017F = var_05[level.var_2682["shirt"]];
  var_04.var_00B9 = var_05[level.var_2682["head"]];
  var_04.var_011A = var_05[level.var_2682["pants"]];
  var_04.var_0091 = var_05[level.var_2682["eyewear"]];
  var_04.var_00B8 = var_05[level.var_2682["hat"]];
  var_04.var_00A8 = var_05[level.var_2682["gear"]];
  var_06 = level.var_7612;
  var_07 = var_06 + 1;
  var_08 = tablelookup(level.var_761A, 0, "loadoutPrimaryAttachment", var_07);
  var_09 = tablelookup(level.var_761A, 0, "loadoutPrimaryAttachment2", var_07);
  var_0A = tablelookup(level.var_761A, 0, "loadoutPrimaryAttachment3", var_07);
  var_0B = tablelookup(level.var_761A, 0, "loadoutPrimaryAttachment4", var_07);
  var_0C = tablelookup(level.var_761A, 0, "loadoutPrimaryAttachment5", var_07);
  var_0D = tablelookup(level.var_761A, 0, "loadoutPrimaryAttachment6", var_07);
  var_04.var_7709 = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_9590(level.var_761A, var_07, 0), 0);
  var_04.var_013C = int(tablelookup("mp/attachmenttable.csv", 3, var_08, 0));
  var_04.var_013D = int(tablelookup("mp/attachmenttable.csv", 3, var_09, 0));
  var_04.var_013E = int(tablelookup("mp/attachmenttable.csv", 3, var_0A, 0));
  var_04.var_013F = int(tablelookup("mp/attachmenttable.csv", 3, var_0B, 0));
  var_04.var_0140 = int(tablelookup("mp/attachmenttable.csv", 3, var_0C, 0));
  var_04.var_0141 = int(tablelookup("mp/attachmenttable.csv", 3, var_0D, 0));
  var_04.var_76F5 = maps\mp\gametypes\_class::func_958E(level.var_761A, var_07, 0);
  var_04.var_7700 = maps\mp\gametypes\_class::func_9591(level.var_761A, var_07, 0);
  var_0E = tablelookup(level.var_761A, 0, "loadoutSecondaryAttachment", var_07);
  var_0F = tablelookup(level.var_761A, 0, "loadoutSecondaryAttachment2", var_07);
  var_10 = tablelookup(level.var_761A, 0, "loadoutSecondaryAttachment3", var_07);
  var_11 = tablelookup(level.var_761A, 0, "loadoutSecondaryAttachment4", var_07);
  var_12 = tablelookup(level.var_761A, 0, "loadoutSecondaryAttachment5", var_07);
  var_13 = tablelookup(level.var_761A, 0, "loadoutSecondaryAttachment6", var_07);
  var_04.var_835D = maps\mp\_utility::func_473C(maps\mp\gametypes\_class::func_9590(level.var_761A, var_07, 1), 0);
  var_04.var_0170 = int(tablelookup("mp/attachmenttable.csv", 3, var_0E, 0));
  var_04.var_0171 = int(tablelookup("mp/attachmenttable.csv", 3, var_0F, 0));
  var_04.var_0172 = int(tablelookup("mp/attachmenttable.csv", 3, var_10, 0));
  var_04.var_8350 = int(tablelookup("mp/attachmenttable.csv", 3, var_11, 0));
  var_04.var_8351 = int(tablelookup("mp/attachmenttable.csv", 3, var_12, 0));
  var_04.var_8352 = int(tablelookup("mp/attachmenttable.csv", 3, var_13, 0));
  var_04.var_8355 = maps\mp\gametypes\_class::func_958E(level.var_761A, var_07, 1);
  var_04.var_8359 = maps\mp\gametypes\_class::func_9591(level.var_761A, var_07, 1);
  return var_04;
}

func_0953(param_00) {
  if(getdvarint("664")) {
    param_00 = func_6CC1(param_00);
  }

  for(var_01 = 0; var_01 < level.var_60B7.size; var_01++) {
    if(level.var_60B7[var_01].var_01D6 == param_00.var_01D6) {
      level.var_60B7[var_01] = param_00;
      param_00 = undefined;
      break;
    }
  }

  if(isDefined(param_00)) {
    level.var_60B7[level.var_60B7.size] = param_00;
  }
}

func_6EA2(param_00) {
  if(!isDefined(level.var_AAE2)) {
    return;
  }

  foreach(var_02 in param_00) {
    var_03 = var_02.var_01D6;
    var_04 = level.var_AAE2[var_03];
    if(isDefined(var_04)) {
      var_05 = level.var_A595[var_04];
      if(isDefined(var_05)) {
        var_05.var_6101 = gettime() + 2000;
        var_05.var_6100 = undefined;
      }
    }

    if(var_02.var_013B >= 0) {
      func_0953(var_02);
    }
  }
}

func_6320() {
  for(;;) {
    var_00 = getdvarint("splitscreen", 0);
    var_01 = function_02A3();
    var_02 = function_02A4();
    foreach(var_05, var_04 in level.var_A595) {
      if(maps\mp\hub_vl_base::func_13B5(var_05)) {
        continue;
      }

      if(var_04.var_6101 >= 0) {
        if(var_04.var_6101 < gettime()) {
          if(var_05 == 0 && !isDefined(var_04.var_6100)) {
            var_04.var_6101 = gettime() + 2000;
            var_04.var_6100 = 1;
            continue;
          }

          maps\mp\hub_vl_base::func_A59E("Schedule removal of ownerId " + var_05 + " from timeout\n");
          maps\mp\hub_vl_base::func_8099(var_05);
        }
      }
    }

    wait 0.05;
  }
}

func_4169(param_00) {
  var_01 = "mp/E3CostumeTable.csv";
  var_02 = [];
  for(var_03 = 0; var_03 < level.var_2682.size; var_03++) {
    var_02[var_03] = int(tablelookupbyrow(var_01, var_03 + 1, param_00 + 1));
  }

  return var_02;
}

func_62FC(param_00, param_01) {}

func_631F() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "member_select") {
      self.var_A58C = level.var_AAE2[var_01];
      if(!isDefined(self.var_A58C)) {
        maps\mp\hub_vl_base::func_A59E("vl_focus undefined, setting to 0\n");
        self.var_A58C = 0;
      }

      maps\mp\hub_vl_base::func_A59E("selected member " + var_01 + " ownerId=" + self.var_A58C + "\n");
    }

    if(var_00 == "vlpresentable") {
      maps\mp\hub_vl_base::func_A59E("in main menu\n");
      thread func_8A5F();
    }

    if(var_00 == "leave_lobby") {
      maps\mp\hub_vl_base::func_A59E("leave_lobby xuid=" + var_01 + "\n");
      if(var_01 == "0") {
        foreach(var_03 in level.var_AAE2) {
          maps\mp\hub_vl_base::func_A59E("Schedule removal of ownerId " + var_03 + "\n");
          maps\mp\hub_vl_base::func_8099(var_03, 0.25);
        }
      } else {
        var_03 = level.var_AAE2[var_03];
        if(isDefined(var_03)) {
          maps\mp\hub_vl_base::func_A59E("Schedule removal of ownerId " + var_03 + "\n");
          maps\mp\hub_vl_base::func_8099(var_03, 0.25);
        }
      }

      thread func_7D77();
    }
  }
}

func_62EF(param_00, param_01) {
  if(param_00 < 0) {
    self.var_A588 = undefined;
    return;
  }

  self.var_A588 = param_01;
}

func_1F9F(param_00, param_01) {
  maps\mp\hub_vl_base::func_A59F("Cao set costumes from lua:" + param_00);
  var_02 = strtok(param_00, "#");
  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "|");
    if(var_05.size > 0) {
      var_06 = level.var_A595[param_01];
      if(isDefined(var_06)) {
        var_06.var_08D2 = int(var_05[1]);
        for(var_07 = 2; var_07 < var_05.size; var_07++) {
          var_08 = strtok(var_05[var_07], ",");
          var_09 = [];
          for(var_0A = 1; var_0A < var_08.size; var_0A++) {
            var_09[var_09.size] = int(var_08[var_0A]);
          }

          if(!isDefined(var_06.var_2685)) {
            var_06.var_2685 = [];
          }

          var_06.var_2685[int(var_08[0])] = var_09;
        }
      }
    }
  }
}

func_62F0(param_00, param_01) {
  var_02 = strtok(param_00, ":");
  var_03 = int(var_02[0]);
  var_04 = strtok(var_02[1], ",");
  var_05 = level.var_A595[param_01];
  if(isDefined(var_05)) {
    var_05.var_76D2 = int(var_04[0]);
    var_05.var_76D3 = var_04[1];
    var_05.var_76D4 = int(var_04[2]);
  }

  return var_05;
}

func_62F9(param_00) {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "cao") {
      func_62EF(var_02, param_00);
      self.var_1FA8 = undefined;
      var_03 = level.var_A595[param_00];
      if(var_02 < 0 && isDefined(var_03)) {
        var_03.var_76D3 = undefined;
        var_03.var_76D4 = undefined;
        var_03.var_76D2 = undefined;
        if(isDefined(var_03.var_2685)) {
          func_A586(var_03, var_03.var_2685[var_03.var_08D2], 1);
        }
      }

      continue;
    }

    if(var_01 == "lootscreen_gear_highlighted") {
      self.var_1DF8 = undefined;
      func_62EF(var_02, param_00);
      if(isDefined(self.var_A588)) {
        self.var_1FA8 = (56, 0, 5);
      } else {
        self.var_1FA8 = undefined;
      }

      self.var_1EFF.var_77BF = "prelobby_loot";
      continue;
    }

    if(var_01 == "costumes") {
      func_1F9F(var_02, param_00);
      continue;
    }

    if(var_01 == "costume_preview") {
      func_62F0(var_02, param_00);
      continue;
    }

    if(var_01 == "costume_apply") {
      var_03 = func_62F0(var_02, param_00);
      if(isDefined(var_03)) {
        var_04 = level.var_2682[var_03.var_76D3];
        if(isDefined(var_03.var_2685) && isDefined(var_03.var_2685[var_03.var_76D2])) {
          var_03.var_2685[var_03.var_76D2][var_04] = var_03.var_76D4;
          if(var_03.var_76D2 == var_03.var_08D2) {
            if(level.var_A1FE) {
              func_05E0(var_03.var_721C getentitynumber(), var_03.var_20F1, "costume", var_03.var_2685[var_03.var_76D2][0], var_03.var_2685[var_03.var_76D2][1], var_03.var_2685[var_03.var_76D2][2], var_03.var_2685[var_03.var_76D2][3], var_03.var_2685[var_03.var_76D2][4], var_03.var_2685[var_03.var_76D2][5]);
            } else {
              var_03 setcostumemodels(var_03.var_2685[var_03.var_76D2]);
            }
          }
        }
      }

      continue;
    }

    if(var_02 == "hub_findgame") {
      var_03 = level.var_A595[var_01];
      if(isDefined(var_03)) {
        if(var_02 == 1) {
          func_4CCD(var_03);
        } else {
          func_8BBB(var_03);
        }
      }
    }
  }
}

func_2318(param_00) {
  setDvar("3784", 0);
  if(isDefined(level.var_A1DB)) {
    var_01 = strtok(param_00, "#");
    foreach(var_03 in var_01) {
      var_04 = strtok(var_03, "|");
      if(var_04.size > 0) {
        var_05 = int(var_04[0]);
        var_06 = level.var_744A[0].var_2316[var_05];
        if(isDefined(var_06)) {
          var_06.var_08D2 = 0;
          var_06.var_582A = int(var_04[1]) > 0;
          for(var_07 = 2; var_07 < var_04.size; var_07++) {
            var_08 = strtok(var_04[var_07], ",");
            var_09 = [];
            for(var_0A = 1; var_0A < var_08.size; var_0A++) {
              var_09[var_09.size] = int(var_08[var_0A]);
            }

            if(!isDefined(var_06.var_2685)) {
              var_06.var_2685 = [];
            }

            var_06.var_2685[int(var_08[0])] = var_09;
            func_A586(var_06, var_09, 1);
            if(var_06.var_582A) {
              func_A669(var_06);
              continue;
            }

            func_4CCD(var_06);
          }
        }
      }
    }
  }

  setDvar("3784", 1);
}

func_62F4() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "clanprofile") {
      maps\mp\hub_vl_base::func_A59E("Using clan profile VL settings\n");
      if(var_01 < 0) {
        self.var_A589 = undefined;
      } else {
        self.var_A589 = var_01;
      }

      continue;
    }

    if(var_00 == "clan_highlight_data") {
      maps\mp\hub_vl_base::func_A59E("Handling clan highlight information\n");
      func_2318(var_01);
    }
  }
}

func_4CCD(param_00) {
  for(var_01 = 0; var_01 < 48; var_01++) {
    var_02 = level.var_744A[var_01];
    if(!isDefined(var_02)) {
      continue;
    }

    func_05E0(var_02 getentitynumber(), param_00.var_20F1, "show", 0);
  }

  if(!level.var_A1FE) {
    param_00 method_805C();
  }

  func_4CD1(param_00);
}

func_8BBB(param_00) {
  for(var_01 = 0; var_01 < 48; var_01++) {
    if(param_00.var_A561[var_01]) {
      var_02 = level.var_744A[var_01];
      if(!isDefined(var_02)) {
        param_00.var_A561[var_01] = 0;
        continue;
      }

      if(level.var_A1FE) {
        func_05E0(var_02 getentitynumber(), param_00.var_20F1, "show", 1);
      } else {
        param_00 showtoclient(var_02);
        if(isDefined(param_00.var_7705)) {
          param_00.var_7705 showtoclient(var_02);
        }

        if(isDefined(param_00.var_835B)) {
          param_00.var_835B showtoclient(var_02);
        }
      }

      if(isDefined(param_00.var_7704) && issubstr(param_00.var_7704, "akimbo")) {
        func_A58A(var_02, param_00);
      }
    }
  }
}

func_4CCF(param_00) {
  if(isDefined(param_00.var_7705)) {
    param_00 notify("hide_primary_weapon");
    if(!level.var_A1FE) {
      param_00.var_7705 method_805C();
      param_00.var_7705 hideallparts();
    }
  }
}

func_4CD0(param_00) {
  if(isDefined(param_00.var_835B)) {
    param_00 notify("hide_secondary_weapon");
    if(!level.var_A1FE) {
      param_00.var_835B method_805C();
      param_00.var_835B hideallparts();
    }
  }
}

func_4CCE(param_00) {
  if(isDefined(param_00.var_0BA9)) {
    param_00 notify("hide_akimbo_weapon");
    if(!level.var_A1FE) {
      param_00.var_0BA9 method_805C();
      param_00.var_0BA9 hideallparts();
    }
  }
}

func_4CD1(param_00) {
  func_4CCF(param_00);
  func_4CD0(param_00);
  func_4CCE(param_00);
}

func_4CD2() {
  foreach(var_01 in level.var_A595) {
    func_4CCD(var_01);
  }
}

func_8BBC() {
  foreach(var_01 in level.var_A595) {
    func_8BBB(var_01);
  }
}

func_43EA(param_00) {
  foreach(var_03, var_02 in level.var_AAE2) {
    if(isDefined(level.var_A595[var_02]) && level.var_A595[var_02] == param_00) {
      return var_03;
    }
  }

  return "";
}

func_7C75(param_00) {
  var_01 = -1;
  foreach(var_01 in level.var_AAE2) {
    if(var_01 == param_00) {
      break;
    }
  }

  maps\mp\hub_vl_base::func_A59E("Removing xuid " + var_03 + " for ownerId " + param_00 + "\n");
  function_02BA(level.var_A595[param_00], var_03, 1);
  level.var_AAE2[var_03] = undefined;
  level.var_13B8[param_00].var_9A1A = 0;
  level.var_13B8[param_00].var_13B3 = undefined;
  setDvar("1999", level.var_AAE2.size);
  var_04 = level.var_A595[param_00];
  level.var_A595[param_00] = undefined;
  func_4CCD(var_04);
  var_04 hideallparts();
  if(isDefined(var_04.var_13B6.var_9042)) {
    var_04.var_13B6.var_9042 = undefined;
  }

  if(isDefined(var_04.var_7705)) {
    if(!level.var_A1FE) {
      function_02BA(var_04.var_7705, var_03, 1);
      var_04.var_7705 delete();
    }

    var_04.var_7705 = undefined;
  }

  if(isDefined(var_04.var_835B)) {
    if(!level.var_A1FE) {
      function_02BA(var_04.var_835B, var_03, 1);
      var_04.var_835B delete();
    }

    var_04.var_835B = undefined;
  }

  if(isDefined(var_04.var_0BA9)) {
    func_A593(var_03, var_04);
  }

  var_04.var_7704 = undefined;
  var_04.var_9428 = undefined;
  maps\mp\hub_vl_base::func_3E76(var_04);
  foreach(var_06 in level.var_744A) {
    if(var_06.var_A58C == param_00) {
      var_06.var_A58C = 0;
    }
  }
}

func_8774() {
  level.var_0EE9 = [];
  var_00 = [];
  var_00["cao_01"] = "pb_cao_pose_01";
  var_00[0] = var_00["cao_01"];
  var_00["selfie_01"] = "pb_selfie_pose_01";
  var_00[1] = var_00["selfie_01"];
  var_00["operator_a"] = "pb_lobby_operator_pose_a";
  var_00[7] = var_00["operator_a"];
  var_00["operator_b"] = "pb_lobby_operator_pose_b";
  var_00[8] = var_00["operator_b"];
  var_00["operator_c"] = "pb_lobby_operator_pose_c";
  var_00[9] = var_00["operator_c"];
  var_00["operator_d"] = "pb_lobby_operator_pose_d";
  var_00[10] = var_00["operator_d"];
  var_00["operator_e"] = "pb_lobby_operator_pose_e";
  var_00[11] = var_00["operator_e"];
  var_00["assault_checkgun"] = "pb_lobby_assault_checkgun";
  var_00[12] = var_00["assault_checkgun"];
  var_00["assault_face"] = "pb_lobby_assault_face";
  var_00[13] = var_00["assault_face"];
  var_00["assault_gear"] = "pb_lobby_assault_gear";
  var_00[14] = var_00["assault_gear"];
  var_00["assault_gloves"] = "pb_lobby_assault_gloves";
  var_00[15] = var_00["assault_gloves"];
  var_00["assault_idle"] = "pb_lobby_assault_idle";
  var_00[16] = var_00["assault_idle"];
  var_00["assault_shoes"] = "pb_lobby_assault_shoes";
  var_00[17] = var_00["assault_shoes"];
  level.var_0EE9["lobby_idle"] = var_00;
  for(var_01 = 0; var_01 < 18; var_01++) {
    precachempanim(var_00[var_01]);
  }
}

func_A1D5(param_00, param_01, param_02) {
  var_03 = randomfloatrange(0.85, 1.15);
  var_04 = 0;
  if(!isDefined(self.var_0E93)) {
    var_04 = 1;
    self.var_001D = self.var_8F80;
  }

  if(!isDefined(param_02)) {
    param_02 = "lobby_idle";
    param_00 = "assault_pose_06";
  }

  self.var_0E93 = param_00;
  self.var_0EE8 = param_02;
  var_05 = level.var_0EE9[param_02][param_00];
  self.var_0EEC = var_05;
  if(isDefined(self.var_721C)) {
    func_05E0(self.var_721C getentitynumber(), self.var_20F1, "anim", var_05);
  }

  if(!level.var_A1FE) {
    self scriptmodelplayanim(var_05);
  }

  if(!isDefined(param_01) || !param_01) {
    self.var_0E93 = param_00;
    if(var_04) {
      func_A58D(self);
    }
  }
}

func_918A(param_00) {
  if(isDefined(param_00.var_1EFF) && isDefined(param_00.var_1EFF.var_627E)) {
    switch (param_00.var_1EFF.var_627E) {
      case "prelobby_loot":
      case "prelobby":
        var_01 = 0;
        if(isDefined(level.var_A595)) {
          foreach(var_03 in level.var_A595) {
            if(!isDefined(var_03.var_0E93)) {
              var_04 = var_03.var_13B6 func_3B96();
              if(isDefined(self.var_6DAC) && self.var_6DAC == 0) {
                var_01 = 8;
              } else if(var_04 < level.var_6871) {
                var_01 = var_04;
              } else {
                var_01++;
                if(var_01 >= level.var_6871) {
                  var_01 = 0;
                }
              }

              var_05 = "lobby_idle";
              func_A1D5(var_01, undefined, var_05);
            }
          }
        }
        break;

      case "transition":
      case "game_lobby":
      case "cac":
        var_01 = 0;
        if(isDefined(level.var_A595)) {
          foreach(var_07 in level.var_A595) {
            if(!isDefined(var_07.var_0E93)) {
              var_04 = var_07.var_13B6 func_3B96();
              if(isDefined(self.var_6DAC) && self.var_6DAC == 0) {
                var_03 = 8;
              } else if(var_04 < level.var_6871) {
                var_03 = var_04;
              } else {
                var_03++;
                if(var_03 >= level.var_6871) {
                  var_03 = 0;
                }
              }

              var_05 = "lobby_idle";
              func_A1D5(var_03, undefined, var_05);
            }
          }
        }
        break;

      case "clanprofile":
      case "cao":
        if(!isDefined(self.var_0E93)) {
          if(isDefined(self.var_6DAC) && self.var_6DAC == 0) {
            var_01 = 8;
          } else {
            var_01 = randomintrange(0, level.var_6871 - 1);
          }

          var_05 = "lobby_idle";
          func_A1D5(var_08, undefined, var_05);
        }
        break;

      default:
        if(!isDefined(self.var_0E93)) {
          if(isDefined(self.var_6DAC) && self.var_6DAC == 0) {
            var_01 = 8;
          } else {
            var_01 = randomintrange(0, level.var_6871 - 1);
          }

          var_05 = "lobby_idle";
          func_A1D5(var_08, undefined, var_05);
        }
        break;
    }
  }
}

func_9271() {
  if(!isDefined(level.var_A595)) {
    return;
  }

  foreach(var_01 in level.var_A595) {
    if(!isDefined(var_01.var_0E93) || !isDefined(var_01.var_0EE8)) {
      var_02 = var_01 func_441B(var_01.var_7704);
      var_01 func_A1D5(var_02.var_0BB4, undefined, var_02.var_0EE8);
    }
  }
}

func_9243() {
  if(!isDefined(level.var_A595)) {
    return;
  }

  foreach(var_01 in level.var_A595) {
    if(!isDefined(var_01.var_0E93) || !isDefined(var_01.var_0EE8)) {
      var_02 = var_01 func_441B(var_01.var_7704);
      var_01 func_A1D5(var_02.var_0BB4, undefined, var_02.var_0EE8);
    }
  }
}

func_91B5() {
  if(!isDefined(level.var_A595)) {
    return;
  }

  foreach(var_01 in level.var_A595) {
    if(!isDefined(var_01.var_0E93) || !isDefined(var_01.var_0EE8)) {
      var_02 = var_01 func_441B(var_01.var_7704);
      var_01 func_A1D5(var_02.var_0BB4, undefined, var_02.var_0EE8);
    }
  }
}

func_3B65(param_00, param_01, param_02) {
  var_03 = [];
  var_03[0] = param_00;
  var_03[1] = param_01;
  var_04 = 20;
  var_05 = 1;
  while(var_05 && var_04 > 0) {
    var_04--;
    var_05 = 0;
    var_06 = [];
    var_06[var_06.size] = var_03[0];
    var_07 = 0;
    var_08 = 0;
    for(var_09 = 0; var_09 < var_03.size - 1 && !var_07; var_09++) {
      var_0A = 1;
      var_0B = var_03[var_09];
      var_0C = var_03[var_09 + 1];
      while(var_0A) {
        var_0A = 0;
        var_0D = undefined;
        var_0E = undefined;
        foreach(var_10 in param_02) {
          var_11 = func_9B85(var_0B, var_0C, var_10);
          if(var_11["intersect"]) {
            if(distance2d(var_06[var_06.size - 1], var_11["closestpoint"]) > 0.1 && distance2d(var_0C, var_11["closestpoint"]) > 0.1) {
              var_0A = 1;
              if(!isDefined(var_0E) || var_0E["radratio"] > var_11["radratio"]) {
                var_0D = var_10;
                var_0E = var_11;
              }
            }
          }
        }

        if(var_0A) {
          var_05 = 1;
          if(length2d(var_0B, var_0D["center"]) < var_0D["radius"]) {
            var_0B = func_6485(var_0B, var_0D);
            var_06[var_06.size - 1] = var_0B;
            var_0A = 0;
            var_07 = 1;
            var_08 = var_09 + 1;
          } else if(length2d(var_0C, var_0D["center"]) < var_0D["radius"]) {
            var_0C = func_6485(var_0C, var_0D);
            var_06[var_06.size] = var_0C;
            var_0A = 0;
            var_07 = 1;
            var_08 = var_09 + 2;
          } else {
            var_06[var_06.size] = var_0E["closestpoint"];
            var_06[var_06.size] = var_0C;
            var_0A = 0;
          }

          continue;
        }

        var_06[var_06.size] = var_0C;
      }
    }

    if(var_07) {
      for(var_09 = var_08; var_09 < var_03.size; var_09++) {
        var_06[var_06.size] = var_03[var_09];
      }
    }

    var_03 = var_06;
  }

  return var_03;
}

func_6485(param_00, param_01) {
  var_02 = param_01["center"];
  var_03 = param_01["radius"];
  var_04 = vectornormalize((param_00[0] - var_02[0], param_00[1] - var_02[1], 0));
  param_00 = (var_02[0] + var_03 * var_04[0], var_02[1] + var_03 * var_04[1], param_00[2]);
  return param_00;
}

func_9B85(param_00, param_01, param_02) {
  var_03 = 5;
  var_04 = param_02["center"];
  var_05 = param_02["radius"];
  var_06 = var_05 + var_03;
  var_07 = (param_01[0] - param_00[0], param_01[1] - param_00[1], 0);
  var_08 = vectornormalize(var_07);
  var_09 = length2d(var_07);
  var_0A = (var_04[0] - param_00[0], var_04[1] - param_00[1], 0);
  var_0B = vectordot(var_08, var_0A);
  if(var_0B < 0) {
    var_0B = 0;
  } else if(var_0B > var_09) {
    var_0B = var_09;
  }

  var_0C = (param_00[0] + var_0B * var_08[0], param_00[1] + var_0B * var_08[1], 0);
  var_0D = var_0B / var_09;
  var_0E = (var_0C[0] - var_04[0], var_0C[1] - var_04[1], 0);
  var_09 = length2d(var_0E);
  var_0F = 0;
  var_10 = 1;
  if(var_09 < var_05) {
    var_0F = 1;
    var_0E = vectornormalize(var_0E);
    var_0C = (var_04[0] + var_06 * var_0E[0], var_04[1] + var_06 * var_0E[1], param_00[2] + var_0D * param_01[2] - param_00[2]);
    var_10 = var_09 / var_05;
  }

  var_11 = [];
  var_11["intersect"] = var_0F;
  var_11["fraction"] = var_0D;
  var_11["closestpoint"] = var_0C;
  var_11["radratio"] = var_10;
  return var_11;
}

func_1E3D(param_00, param_01, param_02) {
  var_03 = distance(param_00, param_02);
  if(var_03 > param_01) {
    var_04 = vectornormalize(param_02 - param_00);
    param_02 = param_00 + param_01 * var_04;
  }

  return param_02;
}

func_5EBB(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_04[param_00];
  if(param_00 + 1 >= param_04.size) {
    return [param_00, func_1E3D(param_01, param_02, param_04[param_00])];
  }

  var_06 = param_04[param_00 + 1];
  var_07 = distance(var_05, var_06);
  var_08 = vectornormalize(var_06 - var_05);
  var_09 = vectordot(var_08, param_01 - var_05);
  if(var_09 < 0) {
    var_09 = 0;
  }

  if(var_09 > var_07) {
    var_09 = var_07;
  }

  var_0A = var_05 + var_09 * var_08;
  var_0B = param_03;
  var_0C = var_07 - var_09;
  var_0D = param_04[param_04.size - 1];
  while(var_0B > 0) {
    if(var_0C > var_0B) {
      var_0D = var_0A + var_0B * var_08;
      var_0B = 0;
      continue;
    }

    if(param_00 + 1 >= param_04.size) {
      var_0D = param_04[param_00];
      var_0B = 0;
    }

    var_0B = var_0B - var_0C;
    param_00++;
    var_0A = param_04[param_00];
  }

  return [param_00, func_1E3D(param_01, param_02, var_0D)];
}

func_5233(param_00) {
  param_00.var_3033 = 0;
  param_00.var_6EDD = 0;
  param_00.var_3041 = 0;
  param_00.var_6EF2 = 0;
  var_01 = param_00.var_6EE3 / param_00.var_6EC7;
  if(var_01 < param_00.var_6ECA) {
    var_01 = param_00.var_6ECA;
  }

  if(var_01 > param_00.var_6EC8) {
    var_01 = param_00.var_6EC8;
  }

  param_00.var_6ED5 = 0.05 * var_01 / param_00.var_6EB8;
  param_00.var_6ED8 = 0.05 * var_01 / param_00.var_6EBD;
  param_00.var_6EF4 = var_01;
  param_00.var_6ED6 = 1;
  param_00.var_6EE9 = 0;
  param_00.var_6EEA = param_00.var_6EC7;
  var_02 = param_00.var_6EBD / 0.05;
  var_03 = 0;
  var_04 = var_01;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    var_04 = var_04 - param_00.var_6ED8;
    if(var_04 < param_00.var_6EC9) {
      var_04 = param_00.var_6EC9;
    }

    var_03 = var_03 + var_04;
  }

  param_00.var_6EF3 = param_00.var_6EE3 - var_03;
  param_00.var_6FF7 = param_00.var_6EE7;
}

func_A0BD(param_00) {
  if(param_00.var_3033 < param_00.var_6EF3) {
    param_00.var_6EF2 = param_00.var_6EF2 + param_00.var_6ED5;
    if(param_00.var_6EF2 > param_00.var_6EF4) {
      param_00.var_6EF2 = param_00.var_6EF4;
      return;
    }

    return;
  }

  param_00.var_6EF2 = param_00.var_6EF2 - param_00.var_6ED8;
  if(param_00.var_6EF2 < param_00.var_6EC9) {
    param_00.var_6EF2 = param_00.var_6EC9;
  }
}

func_5232(param_00) {
  param_00.var_6EC8 = 15;
  param_00.var_6ECA = 1.8;
  param_00.var_6EC9 = 0.3;
  param_00.var_6EC7 = 0.5;
  param_00.var_6EB8 = 0.15 * param_00.var_6EC7;
  param_00.var_6EBD = 0.15 * param_00.var_6EC7;
  param_00.var_6EED = 4.5;
  param_00.var_6EEC = 4.5;
}

func_1D1A(param_00, param_01, param_02, param_03, param_04) {
  var_05 = func_3B65(param_00.var_0116, param_03, param_00.var_699B);
  param_00.var_6EB7 = var_05;
  var_06 = 0;
  foreach(var_09, var_08 in param_00.var_6EB7) {
    if(var_09 > 0) {
      var_06 = var_06 + distance(param_00.var_6EB7[var_09], param_00.var_6EB7[var_09 - 1]);
    }
  }

  param_00.var_6EE9 = 0;
  param_00.var_6EEA = param_00.var_6EC7;
  param_00.var_6EE3 = var_06;
  param_00.var_6EE6 = anglesToForward(param_00.var_001D);
  param_00.var_6EE0 = anglesToForward(param_04);
  param_00.var_6EE7 = angleclamp180(param_00.var_001D[0]);
  param_00.var_6EDE = param_00.var_6EE7;
  param_00.var_6EE1 = angleclamp180(param_04[0]);
  param_00.var_6EE8 = angleclamp180(param_00.var_001D[1]);
  param_00.var_6EE2 = angleclamp180(param_04[1]);
  param_00.var_6EE5 = param_02;
  param_00.var_6EDF = param_03;
  param_00.var_6EEB = (0, 0, 0);
  var_0A = vectornormalize(param_00.var_6EDF - param_00.var_6EE5);
  var_0B = vectordot(var_0A, param_00.var_6EE6);
  var_0C = vectordot(var_0A, param_00.var_6EE0);
  var_0D = 0;
  if(var_0C < -0.707 && var_0B < -0.707) {
    var_0D = 1;
  }

  param_00.var_6EE4 = var_0D;
  func_5233(param_00);
}

func_3B93(param_00, param_01, param_02) {
  var_03 = anglesToForward(param_00);
  var_04 = param_02 - param_01;
  var_05 = vectordot(var_04, var_03);
  var_06 = param_01 + var_03 * var_05;
  return var_06;
}

func_8C4E(param_00, param_01) {
  var_02 = -0.5;
  param_00 = param_00 + var_02;
  param_00 = param_00 * 2 * param_01;
  var_03 = sqrt(1 + param_01 * param_01) / 2 * param_01;
  var_04 = 0.5;
  var_05 = var_03 * param_00 / sqrt(1 + param_00 * param_00) + var_04;
  return var_05;
}

func_5CA0(param_00, param_01) {
  var_02 = angleclamp180(param_01[0]);
  var_03 = angleclamp180(param_00.var_001D[0]);
  var_04 = angleclamp180(param_01[1] - param_00.var_001D[1]);
  var_05 = angleclamp180(var_02 - var_03);
  if(var_04 < -1 * param_00.var_6EED) {
    var_04 = -1 * param_00.var_6EED;
  }

  if(var_04 > param_00.var_6EED) {
    var_04 = param_00.var_6EED;
  }

  if(var_05 < -1 * param_00.var_6EEC) {
    var_05 = -1 * param_00.var_6EEC;
  }

  if(var_05 > param_00.var_6EEC) {
    var_05 = param_00.var_6EEC;
  }

  var_06 = (var_05, var_04, 0);
  param_00.var_001D = param_00.var_001D + var_06;
  if(abs(var_05) < 0.1 && abs(var_04) < 0.1) {
    return 1;
  }

  return 0;
}

func_A09B(param_00, param_01) {
  var_02 = param_00.var_6EE9 / param_00.var_6EEA;
  var_02 = func_8C4E(var_02, 2);
  var_03 = param_00.var_001D;
  var_04 = var_02 * param_00.var_6EE1 - param_00.var_6EE7 + param_00.var_6EE7;
  var_05 = param_00.var_6EE8 + var_02 * param_00.var_6EE2 - param_00.var_6EE8;
  var_06 = param_00.var_001D[1] + angleclamp180(var_05 - param_00.var_001D[1]);
  var_03 = (var_04, var_06, var_03[2]);
  return func_5CA0(param_00, var_03);
}

func_A09E(param_00) {
  var_01 = param_00.var_6EE9 / param_00.var_6EEA;
  var_01 = func_8C4E(var_01, 2);
  var_02 = var_01 * param_00.var_6EE3;
  param_00.var_6EDD = 0;
  param_00.var_3041 = 0;
  param_00.var_3033 = 0;
  while(var_02 > 0) {
    var_03 = distance(param_00.var_6EB7[param_00.var_6EDD], param_00.var_6EB7[param_00.var_6EDD + 1]);
    var_04 = var_03 - param_00.var_3041;
    if(var_04 > var_02) {
      param_00.var_3041 = param_00.var_3041 + var_02;
      var_05 = param_00.var_6EB7[param_00.var_6EDD] + param_00.var_3041 * vectornormalize(param_00.var_6EB7[param_00.var_6EDD + 1] - param_00.var_6EB7[param_00.var_6EDD]);
      param_00.var_6EEB = var_05 - param_00.var_0116;
      param_00.var_0116 = var_05;
      param_00.var_3033 = param_00.var_3033 + var_02;
      var_02 = 0;
      continue;
    }

    var_02 = var_02 - var_04;
    param_00.var_6EDD++;
    if(param_00.var_6EDD >= param_00.var_6EB7.size - 1) {
      if(param_00.var_6EDD < param_00.var_6EB7.size) {
        var_05 = param_00.var_6EB7[param_00.var_6EDD];
      } else {
        var_05 = var_01.var_6EB7[var_01.var_6EB7.size - 1];
      }

      param_00.var_6EEB = var_05 - param_00.var_0116;
      param_00.var_0116 = var_05;
      param_00.var_3033 = param_00.var_6EE3;
      var_02 = 0;
      continue;
    }

    param_00.var_3033 = param_00.var_3033 + var_04;
    param_00.var_3041 = 0;
  }
}

func_A09C(param_00, param_01) {
  var_02 = 0;
  param_00.var_6EE9 = param_00.var_6EE9 + 0.05;
  if(param_00.var_6EE9 >= param_00.var_6EEA) {
    param_00.var_6EE9 = param_00.var_6EEA;
    var_02 = 1;
    param_00.var_6EEB = (0, 0, 0);
  }

  func_A09E(param_00);
  func_A09B(param_00, param_01);
  return var_02;
}

func_4377(param_00) {
  var_01 = "j_neck";
  var_02 = param_00 gettagorigin(var_01);
  return var_02;
}

func_1E3A(param_00) {
  var_01 = func_7EED(param_00);
  var_02 = var_01.var_1EAF;
  var_03 = var_01.var_1EAE;
  var_04 = func_4377(param_00);
  var_05 = var_02;
  var_06 = var_02 + anglesToForward(var_03) * 64;
  return func_1E39(var_05, var_06, var_04);
}

func_1E3B(param_00) {
  var_01 = param_00.var_0116;
  var_02 = param_00.var_1E9D.var_0116;
  var_03 = param_00.var_1E9F.var_0116;
  return func_1E39(var_02, var_03, var_01);
}

func_1E39(param_00, param_01, param_02) {
  var_03 = param_01;
  var_04 = param_00;
  var_05 = param_02;
  var_06 = [];
  var_07 = vectornormalize(vectorcross(var_03 - var_04, (0, 0, 1)));
  var_08 = vectornormalize(vectorcross(var_07, var_03 - var_04));
  var_09 = var_05 - var_04;
  var_0A = var_05 - vectordot(var_08, var_09) * var_08;
  var_0B = var_05 - vectordot(var_07, var_09) * var_07;
  var_0C = distance(var_0A, var_03);
  var_0D = distance(var_0A, var_04);
  var_0E = var_0C / var_0D;
  var_0F = 1;
  if(vectordot(var_09, var_07) < 0) {
    var_0F = -1;
  }

  var_06["fx"] = var_0E;
  var_06["sx"] = var_0F;
  var_10 = distance(var_0B, var_03);
  var_11 = distance(var_0B, var_04);
  var_12 = var_10 / var_11;
  var_13 = 1;
  if(vectordot(var_09, var_08) < 0) {
    var_13 = -1;
  }

  var_06["fz"] = var_12;
  var_06["sz"] = var_13;
  return var_06;
}

func_1E3C(param_00, param_01) {
  var_02 = getdvarfloat("cg_fov", 45) * getdvarfloat("3078", 1);
  var_03 = 1;
  var_04 = tan(var_02);
  var_05 = [];
  var_06 = var_04 * abs(param_00);
  var_07 = 1;
  if(param_00 < 0) {
    var_07 = -1;
  }

  var_08 = var_06 / sqrt(1 - var_06 * var_06);
  var_05["sx"] = var_07;
  var_05["fx"] = var_08;
  var_09 = var_03 * var_04 * abs(param_01);
  var_0A = 1;
  if(param_01 < 0) {
    var_0A = -1;
  }

  var_0B = var_09 / sqrt(1 - var_09 * var_09);
  var_05["sz"] = var_0A;
  var_05["fz"] = var_0B;
  return var_05;
}

func_1E37(param_00, param_01, param_02) {
  var_03 = param_01;
  var_04 = param_02;
  var_05 = var_04 - var_03;
  var_06 = vectornormalize(vectorcross(var_05, (0, 0, 1)));
  var_07 = vectornormalize(vectorcross(var_06, var_05));
  var_08 = var_05 - vectordot(var_05, var_07) * var_07;
  var_09 = length(var_08);
  var_0A = param_00["fx"];
  var_0B = param_00["sx"];
  var_0C = var_09 * var_0A;
  var_09 = var_09 * var_0A * var_0A;
  var_0D = var_09 * var_0A * sqrt(1 - var_0A * var_0A);
  var_0E = var_09 * var_08 + var_0D * var_06;
  var_0F = var_05 - vectordot(var_05, var_06) * var_06;
  var_10 = length(var_0F);
  var_11 = param_00["fz"];
  var_12 = param_00["sz"];
  var_13 = var_10 * var_11;
  var_10 = var_10 * var_11 * var_11;
  var_14 = var_10 * var_11 * sqrt(1 - var_11 * var_11);
  var_15 = var_10 * var_0F + var_14 * var_07;
  var_16 = var_04 + var_0B * var_0E + var_12 * var_15;
  return var_16;
}

func_2AD9(param_00) {
  var_01 = (1, 1, 1);
  var_02 = param_00[0];
  var_03 = var_02;
  var_04 = 0;
  var_05 = 10;
  var_06 = 30;
  if(level.var_A1E9) {
    for(;;) {
      var_07 = func_5EBB(var_04, var_02, var_05, var_06, param_00);
      var_04 = var_07[0];
      var_03 = var_07[1];
      if(distance(var_02, var_03) < 0.1) {
        break;
      }

      var_02 = var_03;
      if(var_04 >= param_00.size) {
        break;
      }
    }

    return;
  }

  for(var_08 = 0; var_08 < param_00.size - 1; var_08++) {}
}

func_2AD7(param_00) {
  var_01 = (1, 0.5, 0);
  foreach(var_03 in param_00) {
    var_04 = var_03["center"];
    var_05 = var_03["radius"];
  }
}

func_2AD1(param_00) {
  var_01 = 1;
  var_02 = var_01;
  var_03 = 36;
  func_5233(param_00);
  param_00.var_9809 = func_4377(param_00.var_9822);
  while(!func_A09C(param_00)) {
    var_04 = param_00.var_9809;
    var_05 = func_1E37(param_00.var_3E6A, param_00.var_0116, var_04);
    var_02--;
    if(var_02 <= 0) {
      var_02 = var_01;
    }
  }

  param_00.var_001D = (angleclamp180(param_00.var_001D[0]), angleclamp180(param_00.var_001D[1]), angleclamp180(param_00.var_001D[2]));
  param_00 method_808C();
}

func_9911(param_00, param_01, param_02, param_03) {
  level notify("stop_test_pathing");
  level endon("stop_test_pathing");
  var_04 = common_scripts\utility::func_46B7("player_pos", "targetname");
  var_05 = param_02.var_9042;
  var_06 = func_7EED(var_05);
  var_07 = var_06.var_1EAF;
  var_08 = var_06.var_1EAE;
  var_09 = var_07;
  var_0A = var_08;
  var_0B = param_00.var_0116;
  var_0C = var_0B + anglesToForward(param_00.var_001D) * 64;
  var_0D = var_09 + anglesToForward(var_0A) * 64;
  param_00.var_0116 = var_0B;
  param_00.var_001D = var_0A;
  param_00.var_699B = param_03;
  func_5232(param_00);
  func_1D1A(param_00, undefined, param_00.var_0116, var_09, var_0A);
  param_00.var_3E6A = func_1E3A(var_05);
  param_00.var_9822 = var_05;
  for(;;) {
    param_00.var_0116 = var_0B;
    param_00.var_001D = var_0A;
    func_2AD9(param_00.var_6EB7);
    func_2AD7(param_00.var_699B);
    func_2AD1(param_00);
    wait 0.05;
  }
}

func_2AFB() {
  var_00 = 0;
  var_01 = common_scripts\utility::func_46B7("player_pos", "targetname");
  foreach(var_03 in var_01) {
    var_04 = common_scripts\utility::func_46B5(var_03.var_01A2, "targetname");
    if(var_04.var_0165 == "camera_target") {
      var_03.var_1E9F = var_04;
    }

    var_05 = common_scripts\utility::func_46B5(var_04.var_01A2, "targetname");
    if(var_05.var_0165 == "camera") {
      var_03.var_1E9D = var_05;
      var_05.var_1E9C = var_03;
      var_05.var_1E9F = var_03.var_1E9F;
    }
  }

  var_07 = spawn("script_model", (0, 0, 0));
  var_07 setModel("tag_player");
  var_07.var_01A5 = "fakecamera";
  level.var_A1E9 = 0;
  var_08 = 0;
  var_09 = 1;
  var_0A = "111111111111111111";
  var_0B = 16;
  for(;;) {
    if(self fragButtonPressed()) {
      while(self fragButtonPressed()) {
        wait 0.05;
      }

      var_09++;
      if(var_09 >= 48) {
        var_09 = 0;
      }

      if(var_09 == var_08) {
        var_09++;
        if(var_09 >= 48) {
          var_09 = 0;
        }
      }

      var_00 = 1;
    }

    if(self secondaryoffhandbuttonPressed()) {
      while(self secondaryoffhandbuttonPressed()) {
        wait 0.05;
      }

      var_08++;
      if(var_08 >= 48) {
        var_08 = 0;
      }

      if(var_09 == var_08) {
        var_08++;
        if(var_08 >= 48) {
          var_08 = 0;
        }
      }

      var_00 = 1;
    }

    if(var_00) {
      var_00 = 0;
      var_0C = [];
      var_0D = undefined;
      var_0E = undefined;
      foreach(var_12, var_10 in var_01) {
        if(getsubstr(var_0A, var_12, var_12 + 1) == "0") {
          continue;
        }

        var_11 = [];
        var_11["center"] = var_10.var_0116;
        var_11["radius"] = var_0B;
        var_0C[var_0C.size] = var_11;
        if(var_10.var_0165 == "" + var_08) {
          var_0D = var_10;
        }

        if(var_10.var_0165 == "" + var_09) {
          var_0E = var_10;
        }
      }

      thread func_9911(var_07, var_0D, var_0E, var_0C);
    }

    wait(0.2);
  }
}

func_2AE5(param_00) {
  level.var_2AE5 = 1;
  var_01 = 30;
  var_02 = 10;
  var_03 = 10;
  var_04 = self method_8451();
  var_05 = self getnormalizedmovement();
  var_06 = anglesToForward(var_04);
  var_07 = anglestoup(var_04);
  var_08 = anglestoright(var_04);
  var_09 = 0;
  if(self adsButtonPressed()) {
    var_09 = -1;
  } else if(self attackButtonPressed()) {
    var_09 = 1;
  }

  if(self secondaryoffhandbuttonPressed()) {
    var_01 = var_01 * 0.1;
    var_02 = var_02 * 0.1;
    var_03 = var_03 * 0.1;
  }

  param_00.var_001D = var_04;
  param_00.var_0116 = param_00.var_0116 + var_05[0] * var_01 * var_06 + var_05[1] * var_02 * var_08 + var_09 * var_03 * var_07;
}

func_A59D(param_00, param_01) {
  if(!isDefined(self.var_A4B5)) {
    self.var_A4B5 = newclienthudelem(self);
    self.var_A4B5.var_01D3 = 0;
    self.var_A4B5.var_01D7 = 0;
    self.var_A4B5 setshader(param_01, 640, 480);
    self.var_A4B5.var_0010 = "left";
    self.var_A4B5.var_0011 = "top";
    self.var_A4B5.var_00C6 = "fullscreen";
    self.var_A4B5.var_01CA = "fullscreen";
    self.var_A4B5.var_0018 = param_00;
  }

  if(isDefined(self.var_A4B5) && self.var_A4B5.var_0018 > 0 && param_00 == 0) {
    self.var_A4B5 setshader(param_01, 640, 480);
    self.var_A4B5.var_0018 = 0;
  }

  if(isDefined(self.var_A4B5) && self.var_A4B5.var_0018 < 1 && param_00 == 1) {
    self.var_A4B5 setshader(param_01, 640, 480);
    self.var_A4B5.var_0018 = 1;
  }
}

func_4696(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
    for(var_01 = 0; var_01 < level.var_744A.size; var_01++) {
      if(level.var_744A[var_01] == self) {
        param_00 = var_01;
        break;
      }
    }
  }

  var_02 = common_scripts\utility::func_46B7("player_pos", "targetname");
  var_03 = undefined;
  foreach(var_03 in var_02) {
    if(var_03.var_0165 == "" + param_00) {
      break;
    }
  }

  if(!isDefined(var_03)) {
    var_03 = var_02[0];
  }

  self.var_13B6 = var_03;
  return var_03;
}

func_2785() {
  var_00 = self;
  if(isDefined(var_00.var_1F8E)) {
    return;
  }

  var_01 = var_00 getxuid();
  var_00.var_1F8E = var_00 func_8F7D(var_00.var_1FA3, var_00.var_0079, var_00.var_1F9D, var_00.var_835A, "none", var_00.var_5DF4, var_00.var_5DF7, var_00.var_6F65, var_00.var_83F4, var_00.var_0109, 0, 1);
  if(!level.var_A1FE) {
    function_02BA(var_00.var_1F8E, var_01);
  }

  var_00 maps\mp\hub_vl_base::func_7699(var_00.var_1F8E, var_00.var_1F8E.var_8F80);
}

func_2D00() {
  var_00 = self;
  if(!isDefined(var_00.var_1F8E)) {
    return;
  }

  maps\mp\hub_vl_base::func_3E76(var_00.var_1F8E);
  var_00.var_1F8E = undefined;
}