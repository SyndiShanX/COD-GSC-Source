/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_camera.gsc
*********************************************/

_id_05E0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_2CCC(var_0, var_1, var_2) {
  wait(var_0);
  self notify("luinotifyserver", var_1, var_2);
}

_id_87B1() {
  var_0 = common_scripts\utility::_id_46B7("player_pos", "targetname");

  foreach(var_5, var_2 in var_0) {
    var_3 = common_scripts\utility::_id_46B5(var_2.target, "targetname");
    var_4 = common_scripts\utility::_id_46B5(var_3.target, "targetname");
  }

  var_6 = _getEnt("cao_spawnpoint", "targetname");
  var_7 = spawnStruct();
  var_7._id_9839 = 40;
  var_7._id_15F7 = 0.25;
  var_7._id_9935 = var_7._id_15F7;
  var_7._id_084C = 0.01;
  var_7._id_2D5F = 0;
  var_7._id_15F6 = 0.5;
  var_7._id_0DD6 = 0.01;
  var_7._id_9934 = var_7._id_15F6;
  var_7._id_2A2C = 0;
  var_7._id_6090 = 60;
  var_7._id_621D = 60;
  var_7._id_6091 = 120;
  var_7._id_0DCF = 0;
  var_7._id_3018 = 120;
  var_7._id_3184 = 12;
  var_7._id_399C = -10;
  var_7._id_1FA9 = 3;
  var_7._id_1FAA = 0;
  var_7._id_3FC0 = 0.0;
  var_7._id_3FBF = 45;
  var_7._id_3FC2 = 50;
  var_7._id_3FBC = 6;
  var_7._id_3FBD = 6;
  var_7._id_3FBE = 513;
  var_7._id_3FBB = 40;
  var_7._id_3FB5 = 483;
  var_7._id_3FB8 = 502;
  var_7._id_3FB2 = 71.5;
  var_7._id_3FB9 = 150;
  var_7._id_3FB3 = 96.8;
  var_7._id_3FB6 = 96.8;
  var_7._id_3FB4 = 490;
  var_7._id_3FB7 = 504.5;
  var_7._id_3FBA = 509.5;
  var_7._id_3FC1 = 0.95;
  var_7._id_1DFD = 0.0;
  var_7._id_1DFC = 7;
  var_7._id_1E17 = 13;
  var_7._id_1DF9 = 0;
  var_7._id_1DFA = 0;
  var_7._id_1EBB = 0.1;
  var_7._id_1E14 = 0.2;
  var_7._id_1E00 = 0;
  var_7._id_1DFB = 17;
  var_7._id_1E16 = 14.5;
  var_7._id_1DFF = 69;
  var_7._id_1E19 = 8;
  var_7._id_1E1B = 0;
  var_7._id_1E1C = 0;
  var_7._id_1E1D = 0;
  var_7._id_1E1E = 0;
  var_7._id_1E29 = 0.35;
  var_7._id_1E27 = 0.1;
  var_7._id_1E28 = 0.05;
  var_7._id_3FB0 = 150;
  var_7._id_3FAF = 0.2;
  var_7._id_3FAE = 45;
  var_7._id_3FB1 = 55;
  var_7._id_3FAB = 16;
  var_7._id_3FAD = 24;
  var_7._id_3FAC = 0.5;
  var_7._id_4800 = "avatar";
  var_7._id_3FA7 = 0.005;
  var_7._id_3FA9 = 0;
  var_7._id_3FA8 = 64;
  var_7._id_3FAA = 0;
  var_7._id_9933 = var_7._id_1EBE;
  var_7._id_28C4 = var_7._id_9933;
  var_7._id_1DFE = 0;
  var_7._id_1E18 = (-0.02, 0, -0.08);
  var_7._id_1E1A = (0.05, 0, -0.06);
  var_7._id_1EBD = 0.25;
  var_7._id_1F0A = 10;
  var_7._id_64C8 = 150;
  var_7._id_0DE1 = 800;
  var_7._id_768F = 0;
  var_8 = self getunnormalizedcameramovement();
  var_7._id_6A69 = var_8[0];
  var_7._id_6A6A = var_8[1];
  var_7._id_ACC5 = 0.5;
  var_7._id_7EE0 = 0.5;
  var_7._id_3E72 = 0;
  var_7._id_7635 = 4;
  var_7._id_2CC8 = 0;
  var_7._id_3174 = 0;
  var_7._id_3173 = 0;
  var_7._id_316C = 159.8;
  var_7._id_316B = 205.59;
  var_7._id_3172 = 7.5;
  var_7._id_316A = 2;
  var_7._id_6C41 = (0, 0, 40);
  var_7._id_768A = 300;
  var_7._id_768E = 10;
  var_7._id_768D = 42;
  var_7._id_768B = 40;
  var_7._id_7689 = 200;
  var_7._id_7687 = 0;
  var_7._id_7688 = 20;
  var_7._id_7686 = 0.325;
  var_7._id_768C = 0.2;
  var_7._id_1EBC = -0.1;
  var_7._id_1EBE = 0.19;
  var_7._id_1EBF = -1;
  var_7._id_2095 = 36;
  var_7._id_2096 = 42;
  var_7._id_9C7B = 0;
  var_7._id_1FA5 = 10;
  var_7._id_1FA4 = 31;
  var_7._id_1F9C = 40;
  var_7._id_1F94 = 200;
  var_7._id_1F90 = 0;
  var_7._id_1F91 = 20;
  var_7._id_1F8F = 0.77;
  var_7._id_1F9E = 0.2;
  var_7._id_1F92 = 0.25;
  var_9 = getdvarint("virtualLobbyMode", 0);

  if(var_9 == 0) {
    var_7._id_627E = "game_lobby";
    _id_9271();
  } else {
    var_7._id_627E = "transition";
    var_7._id_9933 = var_7._id_1EBC;
    var_7._id_28C4 = var_7._id_9933;
    _id_9243();

    if(getdvarint("5666", 0) == 0) {
      setDvar("5666", "1");
    }

    if(var_9 == 2) {
      thread _id_2CCC(0.1, "cac", 0);
    } else if(var_9 == 3) {
      thread _id_2CCC(0.1, "cao", 0);
    }
  }

  var_7._id_669A = var_7._id_627E;
  self._id_1EFF = var_7;
}

_id_A09D(var_0) {
  if(isDefined(self._id_2988)) {
    var_0._id_28C4 = var_0._id_9933;
  } else {
    var_1 = var_0._id_9933 - var_0._id_28C4;

    if(var_1 < -1 * var_0._id_1EBD) {
      var_1 = -1 * var_0._id_1EBD;
    } else if(var_1 > var_0._id_1EBD) {
      var_1 = var_0._id_1EBD;
    }

    var_0._id_28C4 = var_0._id_28C4 + var_1;
  }
}

_id_4697(var_0) {
  var_1 = common_scripts\utility::_id_46B7("player_pos", "targetname");
  var_2 = undefined;

  foreach(var_2 in var_1) {
    if(var_2._id_0165 == "" + var_0) {
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = var_1[0];
  }

  self._id_13B6 = var_2;
  return var_2;
}

_id_A59B() {
  var_0 = self;

  if(isDefined(level._id_A590)) {
    var_0[[level._id_A590]]();
  } else {
    var_0 enablephysicaldepthoffieldscripting();
    var_0 setphysicaldepthoffield(0.613159, 89.8318, var_0._id_1EFF._id_3184, var_0._id_1EFF._id_3184);
  }
}

_id_841A() {
  var_0 = self;

  if(isDefined(var_0._id_1EFF._id_4800)) {
    if(var_0._id_1EFF._id_4800 == "moving" || var_0._id_1EFF._id_4800 == "finding_new_position" || level._id_A595[self._id_A58C] != level._id_A595[self._id_6A4F]) {
      return;
    }
  }

  if(isDefined(var_0._id_1EFF._id_1E99._id_2988) && var_0._id_1EFF._id_1E99._id_2988 == 1) {
    return;
  }
  if(isDefined(var_0._id_1EFF._id_1E99._id_4802)) {
    var_1 = var_0._id_1EFF._id_1E99._id_4802;
  } else {
    var_2 = level._id_A595[self._id_6A4F];
    var_3 = var_2 gettagorigin("TAG_STOWED_BACK");
    var_4 = _distance2d(var_3, var_2._id_13B6.origin);
    var_5 = var_2._id_13B6.origin + anglesToForward(var_2._id_13B6.angles) * var_4;
    var_1 = (var_5[0], var_5[1], var_3[2]);
  }

  var_6 = _id_21AE(var_0._id_1EFF._id_1E99, var_1, 1.5);

  if(var_6 == 1) {
    var_7 = var_1;
  } else {
    var_7 = var_0._id_1EFF._id_1E99.origin;
  }
}

_id_A599(var_0) {
  if(var_0 <= 0.0) {
    return;
  }
  var_1 = self;
  var_2 = var_1._id_1EFF._id_3184;

  if(isDefined(level._id_A58B)) {
    var_1[[level._id_A58B]](var_0);
  } else {
    var_3 = var_0;
    var_1 = self;
    var_4 = 0.025;
    var_5 = 0.65;
    var_6 = 0.613159;
    var_7 = 94.9504;
    var_8 = (var_7 - var_3) * var_4;
    var_9 = var_6 + var_8 + var_8 * var_5;

    if(var_9 < 0.125) {
      var_9 = 0.125;
    } else if(var_9 > 128) {
      var_9 = 128;
    }

    var_1 setphysicaldepthoffield(var_9, var_3, var_1._id_1EFF._id_3184, var_1._id_1EFF._id_3184 * 2);
  }
}

_id_A59A(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(level._id_A58E)) {
    var_3[[level._id_A58E]](var_0, var_1, var_2);
  } else {
    if(var_0 == "cac") {
      var_3 _id_8662();
    } else if(var_0 == "cao") {}

    if(var_1 == "cac") {
      var_3 visionsetnakedforplayer("mp_hub_allies", 0);
    } else if(var_1 == "cao") {
      var_3 setphysicaldepthoffield(3.99, 119.339, var_3._id_1EFF._id_3184, var_3._id_1EFF._id_3184);
    } else if(var_1 == "clanprofile") {
      var_3 _id_8661();
    } else if(var_1 == "prelobby") {
      var_3 _id_8662();
    } else {
      if(var_0 == "prelobby_members") {
        return;
      }
      if(var_0 == "prelobby_loadout") {
        return;
      }
      if(var_0 == "prelobby_loot") {
        return;
      }
      if(var_1 == "game_lobby") {
        var_3 _id_8662();
      } else {
        if(var_0 == "startmenu") {
          return;
        }
        if(var_0 == "transition") {
          return;
        }
        return;
        return;
        return;
        return;
      }
    }
  }
}

_id_8662() {
  var_0 = self;
  var_0 visionsetnakedforplayer("mp_hub_allies_vlobby", 0);
}

_id_8661() {
  var_0 = self;
  var_0 setphysicaldepthoffield(0.613159, 89.8318, var_0._id_1EFF._id_3184, var_0._id_1EFF._id_3184);
}

_id_3C75() {
  if(!isDefined(level._id_A595[self._id_A58C])) {
    foreach(var_2, var_1 in level._id_A595) {
      self._id_A58C = var_2;
      break;
    }
  }
}

_id_6BA9() {
  level._id_0A41["player"]["on_killed"] = maps\mp\hub_vl_base::_id_6A75;
  thread _id_A59C();
  thread _id_631F();

  for(var_0 = undefined; !isDefined(var_0) || !isDefined(self._id_01D6); var_0 = level._id_AAE2[self._id_01D6]) {
    waitframe();
  }

  thread _id_62F9(var_0);
  thread _id_62F8(var_0);
  thread _id_62F4();
  thread maps\mp\hub_vl_base::_id_636A(self);
}

_id_A59C() {
  self endon("disconnect");

  while(!isDefined(self.botclearscriptenemy)) {
    waitframe();
  }

  var_0 = self;
  var_0._id_00C7 = 0;
  var_0 setclientomnvar("ui_vlobby_round_state", 0);
  var_0 setclientomnvar("ui_vlobby_round_timer", 0);
  var_0 _id_4835();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = var_1 - (0, 0, 30);
  var_0 _id_87B1();
  var_4 = anglesToForward(var_0.angles);
  var_5 = anglestoright(var_0.angles);
  var_6 = var_4;
  var_7 = _getgroundposition(var_1, 20, 512, 120);
  var_8 = var_0 getxuid();
  var_9 = var_8 == "";
  var_10 = undefined;
  level._id_6648 = 1;
  var_11 = "none";
  var_12 = "none";
  var_13 = "none";
  var_14 = var_0._id_5E01["customClasses"][0];
  var_15 = var_14["division"];

  if(isDefined(var_14["primaryWeaponStruct"]) && isDefined(var_14["primaryWeaponStruct"].guid) && var_14["primaryWeaponStruct"].guid != 0) {
    var_16 = var_14["primaryWeaponStruct"];
    var_17 = var_14["primaryAttachmentsGUID"][0];
    var_18 = var_14["primaryAttachmentsGUID"][1];
    var_19 = var_14["primaryAttachmentsGUID"][2];
    var_20 = var_14["primaryAttachmentsGUID"][3];
    var_21 = var_14["primaryAttachmentsGUID"][4];
    var_22 = var_14["primaryAttachmentsGUID"][5];
    var_23 = var_14["primaryCamoGUID"];
    var_24 = var_14["primaryReticleGUID"];
    var_25 = var_14["primaryCustomization"];
    var_26 = maps\mp\_utility::_id_4737(var_16);
    var_11 = maps\mp\gametypes\_class::_id_1D66(var_26, var_17, var_18, var_19, var_20, var_21, var_22, maps\mp\_utility::_id_472D(var_16), var_23, var_24, var_25);
  } else if(isDefined(var_14["secondaryWeaponStruct"]) && isDefined(var_14["secondaryWeaponStruct"].guid) && var_14["secondaryWeaponStruct"].guid != 0) {
    var_27 = var_14["secondaryWeaponStruct"];
    var_17 = var_14["secondaryAttachmentsGUID"][0];
    var_18 = var_14["secondaryAttachmentsGUID"][1];
    var_19 = var_14["secondaryAttachmentsGUID"][2];
    var_20 = var_14["secondaryAttachmentsGUID"][3];
    var_21 = var_14["secondaryAttachmentsGUID"][4];
    var_22 = var_14["secondaryAttachmentsGUID"][5];
    var_23 = var_14["secondaryCamoGUID"];
    var_24 = var_14["secondaryReticleGUID"];
    var_25 = var_14["secondaryCustomization"];
    var_26 = maps\mp\_utility::_id_4737(var_27);
    var_12 = maps\mp\gametypes\_class::_id_1D66(var_26, var_17, var_18, var_19, var_20, var_21, var_22, maps\mp\_utility::_id_472D(var_27), var_23, var_24, var_25);
  } else if(isDefined(var_14["meleeWeaponStruct"]) && isDefined(var_14["meleeWeaponStruct"].guid) && var_14["meleeWeaponStruct"].guid != 0) {
    var_28 = var_14["meleeWeaponStruct"];
    var_29 = maps\mp\_utility::_id_4737(var_28);
  }

  var_30 = _getEnt("cao_spawnpoint", "targetname");
  var_31 = 0;

  if(!var_9) {
    maps\mp\hub_vl_base::_id_A59F("adding xuid " + var_8 + "from vlobby_player");
    var_31 = maps\mp\hub_vl_base::_id_0902(var_8);
    _id_4696(0);
    var_0 _id_8F7D(var_0._id_13B6, var_15, var_11, var_12, var_13, var_0._id_5DF4, var_0._id_5DF7, var_0._id_6F65, var_0.setnameplatematerial, var_0.name, var_31, 0);

    if(!level._id_A1FE) {
      _setentplayerxuidforemblem(level._id_A595[var_31], var_8);
    }

    thread _id_8A5F();
  } else
    level._id_6651 = 1;

  setDvar("1999", level._id_AAE2.size);
  var_0._id_1FA3 = var_30;
  var_0._id_1F9D = var_11;

  if(isDefined(level._id_A1DB)) {
    var_0._id_2316 = [];
    var_32 = [0, 1, 4];

    for(var_33 = 0; var_33 < 3; var_33++) {
      var_34 = _id_4696(var_32[var_33]);
      var_0._id_2316[var_33] = var_0 _id_8F7D(var_34, var_15, var_11, var_12, var_13, var_0._id_5DF4, var_0._id_5DF7, var_0._id_6F65, var_0.setnameplatematerial, var_0.name, 0, 0, 1);
      _id_4CCD(var_0._id_2316[var_33]);
    }
  }

  var_0._id_A58C = var_31;
  var_0._id_A588 = undefined;
  var_0 thread _id_62F5(var_31);

  if(!var_9) {
    var_10 = level._id_A595[var_0._id_A58C];
    var_10._id_6101 = gettime();
    var_10._id_294D = var_0._id_294D;
    var_10.player = var_0;
    var_10.setnameplatematerial = var_10._id_267E;
  }

  thread _id_62FC(var_0, var_0._id_1EFF);
  var_35 = common_scripts\utility::_id_46B5("camera_pos", "targetname");
  var_36 = var_35.origin;
  var_37 = var_35.angles;
  var_38 = var_0._id_13B6.origin - var_36;
  var_38 = vectorNormalize(var_38);
  var_39 = spawn("script_model", var_36);
  var_39.angles = var_37;
  var_39 setModel("tag_player");
  var_39.targetname = "vlcamera";
  var_39._id_92F0 = var_36;
  var_39._id_92B8 = var_37;
  var_39.setmovingplatformplayerturnrate = (0, 0, 0);
  var_39._id_1E91 = 0;
  var_39._id_4B88 = 1;
  var_39._id_1E98 = 1;
  var_39._id_2988 = 1;
  var_39._id_3FE2 = 0;
  var_39._id_3BA7 = 1;
  var_39._id_4802 = var_36;
  _id_9422(var_39);
  var_40 = 400;
  var_0._id_1E99 = var_39;
  var_39.player = var_0;
  var_0._id_4B9E = 0;
  var_41 = (0, 90, 0);
  var_39._id_64ED = "starting";
  var_0._id_50CA = 0;
  var_0 allowfire(0);
  var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_9042, var_0._id_9042._id_8F80);

  if(isDefined(level._id_A1DB)) {
    var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_2316[0], var_0._id_2316[0]._id_8F80);
    var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_2316[1], var_0._id_2316[1]._id_8F80);
    var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_2316[2], var_0._id_2316[2]._id_8F80);
  }

  var_42 = var_0._id_1EFF;
  var_42._id_1E99 = var_39;
  _id_5232(var_39);
  var_43 = 300;
  var_0._id_6A4F = var_0._id_A58C;
  var_40 = 1000;
  var_44 = anglesToForward(var_39.angles);
  var_45 = undefined;
  var_46 = undefined;
  var_47 = undefined;
  var_48 = undefined;
  var_0._id_1EFF._id_3E72 = var_0._id_1EFF._id_7635;
  thread _id_6338();
  thread _id_635D(var_42);
  var_49 = 0;
  var_50 = 0;
  self setclientomnvar("char_scene_state", 3);
  var_0 notify("fade_in");

  for(;;) {
    if(!var_0._id_537A) {
      var_0 waittill("virtualLobbyActive");
      var_0._id_8068 = var_0 getplayerangles();
      var_0._id_9042.angles = var_0._id_9042._id_8F80;
      _id_05E0(var_0 getentitynumber(), var_0._id_9042._id_20F1, "angles", var_0._id_9042.angles);
      var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_9042, var_0._id_9042._id_8F80);
      var_0 setclientomnvar("char_scene_state", 3);
    }

    maps\mp\hub_vl_base::_id_13B4();

    if(level._id_A595.size == 0) {
      if(var_42._id_627E == "game_lobby" || var_42._id_627E == "prelobby_loot") {
        var_0 _id_2D00();

        if(isDefined(level._id_A1DB)) {
          for(var_33 = 0; var_33 < 3; var_33++) {
            _id_4CCD(var_0._id_2316[var_33]);
          }
        }

        var_39._id_2988 = 1;
        var_0._id_13B6 = _id_4696(0);
        _id_5E39(var_39, undefined, var_42, var_0._id_13B6);
        _id_A59D(0, "ac130_overlay_pip_vignette_vlobby");
      }

      waitframe();
      continue;
    }

    if(var_50) {
      var_50 = 0;
      var_0 thread _id_2AFB();
    }

    if(getdvarint("scr_vl_debugfly") > 0) {
      if(!var_49) {
        var_49 = 1;
        setDvar("5718", "0");
        level._id_2AE5 = undefined;
        var_0 allowfire(1);
      }

      var_0 _id_2AE5(var_39);
    } else if(var_49) {
      setDvar("5718", "1");
      var_49 = 0;
      var_39.origin = var_39._id_92F0;
      var_39.angles = var_39._id_92B8;
      var_0 allowfire(0);
    }

    if(!var_0._id_50CA) {
      if(var_0._id_A58C != var_0._id_6A4F) {
        var_0 maps\mp\hub_vl_base::_id_7699(level._id_A595[var_0._id_A58C], level._id_A595[var_0._id_A58C].angles);

        if(var_42._id_627E != "game_lobby") {
          var_42._id_669A = "transition";
        }

        var_0._id_6A4F = var_0._id_A58C;
        var_42._id_9C7B = 1;
      }

      if(isDefined(var_0._id_A588) || isDefined(var_0._id_77A2)) {
        if(!isDefined(var_0._id_A588)) {
          var_42._id_669A = var_42._id_77BF;
          var_0._id_77A2 = undefined;
        } else if(!isDefined(var_0._id_77A2)) {
          var_42._id_669A = "cao";
          var_42._id_77BF = var_42._id_627E;
          var_0._id_77A2 = var_0._id_A588;
        } else if(var_0._id_A588 != var_0._id_77A2)
          var_0._id_77A2 = var_0._id_A588;
      }

      if(isDefined(var_0._id_1DF8) || isDefined(var_0._id_77A0)) {
        if(!isDefined(var_0._id_1DF8)) {
          var_42._id_669A = var_42._id_77BF;
          var_0._id_77A0 = undefined;
          var_0._id_77A1 = "none";
        } else if(!isDefined(var_0._id_77A0)) {
          var_42._id_669A = "cac";
          var_42._id_77BF = var_42._id_627E;
          var_0._id_77A0 = var_0._id_1DF8;
        }
      }

      if(isDefined(var_0._id_A589) || isDefined(var_0._id_77A3)) {
        if(!isDefined(var_0._id_A589)) {
          var_42._id_669A = var_42._id_77BF;
          var_0._id_77A3 = undefined;
        } else if(!isDefined(var_0._id_77A3)) {
          var_42._id_669A = "clanprofile";
          var_42._id_77BF = var_42._id_627E;
          var_0._id_77A3 = var_0._id_A589;
        } else if(var_0._id_A589 != var_0._id_77A3) {
          var_0._id_77A3 = var_0._id_A589;

          if(isDefined(level._id_A1DB)) {
            var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_2316[var_0._id_A589], var_0._id_2316[var_0._id_A589].angles);
          }
        }
      }

      if(level._id_A595.size == 0) {
        continue;
      }
      var_0 _id_3C75();
      var_10 = level._id_A595[var_0._id_A58C];

      if(var_42._id_669A != var_42._id_627E) {
        var_0 _id_A59A(var_42._id_627E, var_42._id_669A, var_42);

        if(var_42._id_669A == "cac") {
          var_0 _id_2D00();

          if(isDefined(level._id_A1DB)) {
            for(var_33 = 0; var_33 < 3; var_33++) {
              _id_4CCD(var_0._id_2316[var_33]);
            }
          }

          var_0._id_4B9E = 0;
          var_42._id_627E = var_42._id_669A;
          var_42._id_9933 = var_42._id_1DFD;
          var_10 = level._id_A595[var_0._id_A58C];
          _id_4CCD(var_10);
          var_0 maps\mp\hub_vl_base::_id_7699(var_10, var_10.angles);
        } else if(var_42._id_627E == "cac") {
          var_10 = level._id_A595[var_0._id_A58C];
          _id_8BBB(var_10);
          var_0._id_4B9E = 0;
        }

        if(var_42._id_669A == "cao") {
          var_51 = level._id_A595[var_0._id_A58C];
          var_0._id_267E = var_51._id_267E;
          var_52 = var_0 _id_0510::_id_73CA();

          if(!isDefined(var_51._id_5097) || !var_51._id_5097) {
            if(level._id_A1FE) {
              _id_05E0(var_0 getentitynumber(), var_51._id_20F1, "costume", var_51._id_267E[0], var_51._id_267E[1], var_51._id_267E[2], var_51._id_267E[3], var_51._id_267E[4], var_51._id_267E[5]);
            } else {
              var_51 _meth_84C7(var_51._id_267E, "free");
            }
          }

          var_0 _id_2785();
          var_53 = var_0._id_1F8E;
          _id_A586(var_53, var_51._id_267E);

          if(!isDefined(var_53._id_5097) || !var_53._id_5097) {
            if(level._id_A1FE) {
              _id_05E0(var_0 getentitynumber(), var_53._id_20F1, "costume", var_51._id_267E[0], var_51._id_267E[1], var_51._id_267E[2], var_51._id_267E[3], var_51._id_267E[4], var_51._id_267E[5]);
            } else {
              var_53 _meth_84C7(var_53._id_267E, "free");
            }
          }

          foreach(var_8, var_55 in level._id_AAE2) {
            if(var_55 == var_0._id_A58C) {
              if(!level._id_A1FE) {
                if(isDefined(level._id_1FA7) && level._id_1FA7 != var_8) {
                  _setentplayerxuidforemblem(var_53, level._id_1FA7, 1);
                }

                _setentplayerxuidforemblem(var_53, var_8);
              }

              level._id_1FA7 = var_8;
              break;
            }
          }

          if(!level._id_A1FE) {
            var_0._id_1F8E showtoplayer(var_0);
          }

          var_0._id_1F8E.angles = var_0._id_1F8E._id_8F80;
          _id_05E0(var_0 getentitynumber(), var_0._id_1F8E._id_20F1, "angles", var_0._id_1F8E.angles);

          if(isDefined(level._id_A1DB)) {
            for(var_33 = 0; var_33 < 3; var_33++) {
              _id_4CCD(var_0._id_2316[var_33]);
            }
          }

          var_10 = var_0._id_1F8E;
          var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_1F8E, var_0._id_1F8E.angles);
          _id_91B5();
          var_42._id_627E = var_42._id_669A;
          var_39._id_2988 = 1;
        } else if(var_42._id_669A == "clanprofile") {
          var_0 _id_2D00();
          _id_4CD2();

          if(isDefined(level._id_A1DB)) {
            for(var_33 = 0; var_33 < 3; var_33++) {
              var_0._id_2316[var_33].angles = var_0._id_2316[var_33]._id_8F80;
              _id_05E0(var_0 getentitynumber(), var_0._id_2316[var_33]._id_20F1, "angles", var_0._id_2316[var_33].angles);
              var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_2316[var_33], var_0._id_2316[var_33].angles);
            }

            var_10 = var_0._id_2316[0];
          }

          var_42._id_627E = var_42._id_669A;
          var_0 setOrigin(var_10.origin);
        } else if(var_42._id_669A == "prelobby_loot")
          var_39._id_2988 = 1;
        else if(var_42._id_669A == "transition") {
          var_42._id_669A = "game_lobby";
        }

        if(var_42._id_669A == "game_lobby") {
          var_0 _id_3C75();
          var_56 = var_31;

          if(var_42._id_627E == "cao" || var_42._id_627E == "cac" || var_42._id_627E == "clanprofile") {
            var_39._id_3BA7 = 1;

            if(isDefined(var_0._id_A588)) {
              var_56 = var_0._id_A588;
            } else if(isDefined(var_0._id_A589)) {
              var_56 = _id_44E9(var_0._id_A589);
            }
          }

          if(isDefined(level._id_A595) && isDefined(var_0._id_6A4F) && isDefined(level._id_A595[var_0._id_6A4F])) {
            var_0 maps\mp\hub_vl_base::_id_7699(level._id_A595[var_0._id_6A4F], level._id_A595[var_0._id_6A4F].angles);
          }

          var_42._id_4800 = "waiting";

          if(var_42._id_627E != "cac") {
            _id_8BBC();
          }

          var_0._id_A58C = var_56;
          var_0._id_6A4F = var_56;
          var_10 = level._id_A595[var_0._id_A58C];

          if(var_42._id_627E != "cac") {
            var_39._id_2988 = 1;
          } else if(var_42._id_627E == "cac" && isDefined(var_39._id_13B6) && var_39._id_13B6 != var_10._id_13B6) {
            var_39._id_2988 = 1;
          }

          _id_9243();
          var_39._id_5B16 = var_10._id_13B6;
          var_39._id_13B6 = var_10._id_13B6;
          var_0 maps\mp\hub_vl_base::_id_7699(var_10, var_10.angles);
          var_39._id_64ED = "starting";
        }

        var_42._id_627E = var_42._id_669A;
      }

      if(var_42._id_627E == "startmenu") {
        _id_924B(var_39, var_42);
      } else if(var_42._id_627E == "cao") {
        var_0 _id_2785();
        var_10 = var_0._id_1F8E;
        _id_1FA6(var_39, var_10, var_42);
      } else if(var_42._id_627E == "clanprofile") {
        if(isDefined(level._id_A1DB)) {
          var_10 = var_0._id_2316[var_0._id_A589];
          _id_2317(var_39, var_10, var_42);
        }
      } else if(var_42._id_627E == "cac")
        _id_5E39(var_39, level._id_A595[var_0._id_A58C], var_42, var_0._id_13B6);
      else if(var_42._id_627E == "transition") {
        var_42._id_669A = "game_lobby";
      } else if(var_42._id_1FAA <= 0) {
        var_0 _id_2D00();

        if(isDefined(level._id_A1DB)) {
          for(var_33 = 0; var_33 < 3; var_33++) {
            _id_4CCD(var_0._id_2316[var_33]);
          }
        }

        _id_5E39(var_39, var_10, var_42, var_0._id_13B6);
        _id_A59D(0, "ac130_overlay_pip_vignette_vlobby");
      } else
        var_42._id_1FAA = var_42._id_1FAA - 1;
    }

    if(var_0._id_50CA) {
      var_0 visionsetnakedforplayer("mp_vlobby_room_fr", 0);
    }

    waitframe();
  }
}

_id_9593(var_0, var_1, var_2) {
  var_3 = _float(tablelookup("mp/vlobby_cac_offsets.csv", var_1, var_0, var_2));

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  return var_3;
}

_id_9422(var_0) {
  var_1 = common_scripts\utility::_id_46B7("player_pos", "targetname");
  var_0._id_1EB7 = [];

  foreach(var_3 in var_1) {
    var_0._id_1EB7[var_0._id_1EB7.size] = var_3;
  }

  foreach(var_3 in var_1) {
    var_6 = common_scripts\utility::_id_46B5(var_3.target, "targetname");

    if(var_6._id_0165 == "camera_target") {
      var_3._id_1E9F = var_6;
    }

    var_7 = common_scripts\utility::_id_46B5(var_6.target, "targetname");

    if(var_7._id_0165 == "camera") {
      var_3._id_1E9D = var_7;
      var_7._id_1E9C = var_3;
      var_7._id_1E9F = var_3._id_1E9F;
    }

    if(var_3._id_0165 == "0") {
      self._id_1EFF._id_5B1A = var_3._id_1E9D;
    }

    var_8 = int(var_3._id_0165);
    var_0._id_1EB7[var_8] = var_3;
  }
}

_id_1E3F(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = _length2d(var_3);
  var_5 = var_4 / _sqrt(1 + var_2._id_28C4 * var_2._id_28C4);
  var_6 = var_3[0] - var_2._id_28C4 * var_3[1];
  var_7 = var_2._id_28C4 * var_3[0] + var_3[1];
  var_8 = var_5 * vectorNormalize((var_6, var_7, 0));
  var_8 = var_8 + (0, 0, var_3[2]);
  return var_8;
}

_id_4951(var_0, var_1) {
  var_2 = var_1 - var_0._id_6A69;

  if(var_2 < -180) {
    var_2 = 360 + var_2;
  } else if(var_2 > 180) {
    var_2 = 360 - var_2;
  }

  var_0._id_6A69 = var_1;
  return var_2;
}

_id_4952(var_0, var_1) {
  var_2 = var_1 - var_0._id_6A6A;

  if(var_2 < -180) {
    var_2 = -1;
  } else if(var_2 > 180) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  var_0._id_6A6A = var_1;
  return var_2;
}

_id_1EB8(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_2988)) {
    self.origin = var_0;
  } else {
    self moveTo(var_0, var_1, var_2, var_3);
  }
}

_id_1F09(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_2988)) {
    self.angles = var_0;
  } else {
    self rotateTo(var_0, var_1, var_2, var_3);
  }
}

_id_7EED(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = spawnStruct();
    var_2._id_1EAF = (-70.8, -691.3, 502.2);
    var_2._id_1EAE = (0, 87, 0);
    return var_2;
  }

  var_3 = var_0 gettagorigin("TAG_STOWED_BACK");
  var_4 = var_0 gettagangles("TAG_STOWED_BACK");
  var_5 = var_0._id_8F80[1] - var_0.angles[1];
  var_6 = (0, 0, 1);
  var_7 = var_3 - var_0.origin;
  var_8 = _rotatepointaroundvector(var_6, var_7, var_5);
  var_9 = var_0.origin + var_8;
  var_0._id_1EAF = var_9;
  var_0._id_1EAE = (var_4[0], _angleclamp(var_4[1] + var_5), var_4[2]);
  var_2 = spawnStruct();
  var_2._id_1EAF = var_0._id_1EAF;
  var_2._id_1EAE = var_0._id_1EAE;
  return var_2;
}

_id_21AE(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 2;
  }

  var_3 = distance(var_1, var_0.origin);

  if(var_3 >= var_2) {
    return 1;
  } else {
    return 0;
  }
}

_id_5E39(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_2._id_3E72 = var_2._id_7635;
    var_4 = var_0._id_92B8;

    if(isDefined(var_3)) {
      var_4 = (0, var_3.angles[1] + 180, 0);
    }

    var_5 = var_0._id_92F0;
    var_6 = distance(var_0.origin, var_5);
    var_7 = var_6 / var_2._id_768A;

    if(var_7 < 0.1) {
      var_7 = 0.1;
    }

    var_0 _id_1EB8(var_5, var_7, var_7 * 0.5, var_7 * 0.5);
    var_0 _id_1F09(var_4, var_7, var_7 * 0.5, var_7 * 0.5);
  } else {
    if(var_2._id_3E72 == var_2._id_7635) {
      maps\mp\hub_vl_base::_id_7699(var_1, var_1.angles);
    }

    var_4 = (0, 87, 0);

    if(isDefined(var_1._id_13B6)) {
      var_4 = (0, var_1._id_13B6.angles[1] + 180, 0);
    }

    if(level._id_A1FE) {
      var_8 = var_1.origin;
    } else {
      var_8 = var_1 gettagorigin("TAG_STOWED_BACK");
    }

    if(!isDefined(var_1._id_1EAD)) {
      var_1._id_1EAD = "stand";
    }

    if(var_1._id_1EAD == "crouch") {
      var_9 = var_1._id_13B6.origin + anglesToForward(var_1._id_13B6.angles) * var_2._id_3FB3;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2._id_3FB5);
    } else if(var_1._id_1EAD == "hunch") {
      var_9 = var_1._id_13B6.origin + anglesToForward(var_1._id_13B6.angles) * var_2._id_3FB6;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2._id_3FB8);
    } else if(var_1._id_1EAD == "stand") {
      var_9 = var_1._id_13B6.origin + anglesToForward(var_1._id_13B6.angles) * var_2._id_3FB9;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2._id_3FBB);
    } else if(var_1._id_1EAD == "zoom_high") {
      var_9 = var_1._id_13B6.origin + anglesToForward(var_1._id_13B6.angles) * var_2._id_3FB2;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2._id_3FBE);
    } else {
      var_9 = var_1._id_13B6.origin + anglesToForward(var_1._id_13B6.angles) * var_2._id_3FB9;
      var_10 = (var_9[0], var_9[1], var_9[2] + var_2._id_3FBB);
    }

    if(getdvarint("scr_vl_camera_test") != 0) {
      var_11 = _distance2d(var_1._id_13B6.origin, var_1._id_13B6._id_1E9D.origin);

      if(var_11 < var_2._id_3FB9) {
        var_11 = var_2._id_3FB9;
      }

      var_12 = var_8[2] - var_2._id_3FBB;
      var_13 = _atan(var_12 / var_2._id_3FB9);
      var_14 = _tan(var_13) * var_2._id_3FB9;
      var_15 = _tan(var_13) * var_11;
      var_16 = var_8[2] - var_15;
      var_9 = var_1._id_13B6.origin + anglesToForward(var_1._id_13B6.angles) * var_11;
      var_10 = (var_9[0], var_9[1], var_16);
    }

    var_0._id_4802 = var_10;
    var_17 = 0;

    if(var_2._id_3E72 == 0) {
      var_17 = _id_21AE(var_0, var_10, 1.5);
    }

    var_2._id_28C4 = var_2._id_3FC0;
    var_2._id_9933 = var_2._id_3FC0;
    var_0 _id_A09D(var_2);
    var_18 = 0;
    var_19 = 0;
    var_6 = distance(var_0.origin, var_10);
    var_7 = var_6 / var_2._id_3FB0;

    if(var_7 < 0.1) {
      var_7 = 0.1;
    }

    var_20 = var_6 / (var_2._id_3FB0 * var_2._id_3FC1);

    if(var_20 < 0.1) {
      var_20 = 0.1;
    }

    var_21 = 1;
    var_22 = getdvarint("virtualLobbyMode", 0);

    if(var_22 != 2 && var_22 != 4 && var_22 != 3) {
      if(isDefined(var_1.player) && var_1.player == self) {
        maps\mp\hub_vl_base::_id_7E92(var_1, 0.5);
      }
    } else if(var_22 == 4 || var_22 == 3) {
      maps\mp\hub_vl_base::_id_7699(var_1, var_1.angles);
      var_0._id_2988 = 1;
    } else if(var_22 == 2)
      maps\mp\hub_vl_base::_id_7699(var_1, var_1.angles);

    if(var_2._id_3E72 > 0) {
      var_2._id_3E72 = var_2._id_3E72 - 1;
    }

    if(isDefined(var_1._id_13B6) && isDefined(var_0._id_13B6) && var_1._id_13B6 != var_0._id_13B6) {
      var_0._id_5B72 = var_0._id_13B6;
      var_0._id_13B6 = var_1._id_13B6;
      var_2._id_4800 = "finding_new_position";
      var_17 = 1;
      var_0._id_3BA7 = 0;
    } else if(var_17 == 1)
      var_2._id_4800 = "moving";

    if(var_2._id_4800 == "waiting") {
      if(var_17 == 1) {
        var_2._id_4800 = "moving";
        var_0._id_3BA7 = 1;
      }

      var_0._id_5B16 = var_1._id_13B6;
    }

    if(var_2._id_4800 == "finding_new_position") {
      if(var_17 == 1) {
        var_0._id_5B72 = var_0._id_13B6;
        var_0._id_13B6 = var_1._id_13B6;
        var_0._id_699B = [];
        var_23 = 16;

        foreach(var_25 in level._id_A595) {
          var_26 = [];
          var_26["center"] = var_25._id_13B6.origin;
          var_26["radius"] = var_23;
          var_0._id_699B[var_0._id_699B.size] = var_26;
        }

        _id_1D1A(var_0, var_2, var_0.origin, var_10, var_4);
        var_0._id_3E6A = _id_1E3A(var_1);
        var_0._id_9809 = _id_4377(var_1);
        var_2._id_4800 = "moving";
      }

      var_2._id_4800 = "moving";
    }

    if(var_2._id_4800 == "moving") {
      if(var_2._id_3E72 <= 0) {
        var_2._id_3E72 = 0;

        if(var_0._id_3BA7 == 0) {
          if(isDefined(var_0._id_2988)) {
            var_0 _id_1EB8(var_10, var_7, var_18, var_19);
            var_0 _id_1F09(var_4, var_21, var_21 * 0.5, var_21 * 0.5);
            var_0._id_3BA7 = 1;
          } else
            var_0._id_3BA7 = _id_A09C(var_0, var_2);
        }

        if(var_0._id_3BA7) {
          var_0 _id_1EB8(var_10, var_20, var_20 * 0.5, var_20 * 0.5);
          var_0 _id_1F09(var_4, var_20, var_20 * 0.5, var_20 * 0.5);
          var_2._id_4800 = "waiting";
        }
      }
    }

    _id_841A();
  }

  if(isDefined(var_0._id_2988)) {
    if(isDefined(var_0._id_4802)) {
      var_0.origin = var_0._id_4802;
      var_0.angles = var_4;
    }

    var_0 dontinterpolate();
    var_0._id_2988 = undefined;
  }

  if(getdvarint("5666", 0) == 0) {
    wait 1.0;
    setDvar("5666", "1");
    thread _id_8A5F();
  }
}

_id_8A5F() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");

  if(level._id_A595.size > 0 && isDefined(level._id_A595[0]) && isDefined(level._id_A595[0].primaryweapon) && _id_5854(level._id_A595[0].primaryweapon)) {
    level._id_6651 = undefined;
    wait 0.5;
    setDvar("3965", "1");
  } else
    level._id_6651 = 1;
}

_id_7D77() {
  level notify("cancel_vlp");
  level endon("cancel_vlp");
  level._id_6651 = undefined;
  wait 0.25;
  setDvar("3965", "0");
}

_id_4590(var_0, var_1, var_2) {
  if(_abs(var_1 - var_0._id_7EF8) > 100) {
    if(var_1 >= 270) {
      var_0._id_09F8 = var_0._id_09F8 + -360 * var_2;

      if(var_0._id_09F8 == -360) {
        var_0._id_09F8 = 0;
      }
    }

    if(var_1 <= 100) {
      var_0._id_09F8 = var_0._id_09F8 + 360 * var_2;

      if(var_0._id_09F8 == 360) {
        var_0._id_09F8 = 0;
      }
    }
  }

  var_0._id_7EF8 = var_1;
  var_3 = var_1 * var_2 + var_0._id_09F8;
  return var_3;
}

_id_1FA6(var_0, var_1, var_2) {
  maps\mp\hub_vl_base::_id_7E92(var_1, 0.5);
  var_2._id_1FAA = var_2._id_1FA9;
  var_3 = var_1.origin + (0, 0, -20) + anglesToForward(var_1._id_8F80) * 120;
  var_2._id_ACC5 = var_2._id_1F8F;
  var_2._id_3018 = var_2._id_1F9C + (var_2._id_1F94 - var_2._id_1F9C) * var_2._id_ACC5;
  var_4 = var_2._id_1F90 + var_2._id_1F91 * var_2._id_ACC5;
  var_5 = var_2._id_1FA4 + var_2._id_1FA5 * (1 - var_2._id_ACC5);
  var_2._id_9933 = var_2._id_1F92 + var_2._id_768C * (var_2._id_ACC5 - 1);
  var_0 _id_A09D(var_2);
  var_6 = var_2._id_2096 + (var_2._id_2095 - var_2._id_2096) * var_2._id_ACC5;
  var_7 = var_1.origin + (0, 0, var_5);
  var_8 = var_7 - (var_3 + var_2._id_6C41);
  var_8 = var_2._id_3018 * vectorNormalize(var_8);
  var_8 = (var_8[0], var_8[1], -1 * var_4);
  var_8 = var_2._id_3018 * vectorNormalize(var_8);
  var_9 = var_7 - var_8;

  if(isDefined(self._id_1FA8)) {
    var_7 = var_7 + self._id_1FA8;
    var_9 = var_9 + self._id_1FA8;
  }

  var_10 = -1 * var_8;
  var_11 = vectortoangles(var_10);
  var_2._id_0DCF = var_11[1] - var_1._id_92B8[1];
  var_12 = distance(var_0.origin, var_9);
  var_13 = var_12 / var_2._id_768A;

  if(var_13 < 0.1) {
    var_13 = 0.1;
  }

  var_0 _id_1EB8(var_9, var_13, var_13 * 0.5, var_13 * 0.5);
  var_14 = _id_1E3F(var_9, var_7, var_2);
  var_15 = vectortoangles(var_14);
  var_0 _id_1F09(var_15, var_13, var_13 * 0.5, var_13 * 0.5);

  if(isDefined(var_0._id_2988)) {
    var_0 dontinterpolate();
    var_0._id_2988 = undefined;
  }
}

_id_924B(var_0, var_1) {}

_id_2317(var_0, var_1, var_2) {
  var_3 = (0, 87, 0);

  if(isDefined(var_1._id_13B6)) {
    var_3 = (0, var_1._id_13B6.angles[1] + 180, 0);
  }

  var_0 _id_A09D(var_2);
  var_4 = (14, 0, 0);
  var_5 = var_1.origin + var_4 + anglesToForward(var_1._id_13B6.angles) * 110;
  var_6 = (var_5[0], var_5[1], var_2._id_3FBB);
  var_0._id_4802 = var_6;
  var_7 = distance(var_0.origin, var_6);
  var_8 = max(var_7 / var_2._id_3FB0, 0.1);
  var_9 = 0.2;
  var_0 _id_1EB8(var_6, var_8, 0, 0);
  var_0 _id_1F09(var_3, var_9, 0, 0);
  maps\mp\hub_vl_base::_id_7E92(var_1, 0.5);
}

_id_635D(var_0) {
  self endon("disconnect");

  for(;;) {
    var_1 = getdvarint("virtualLobbyMode", 0);

    if(var_0._id_627E != "cao" && var_0._id_627E != "cac") {
      if(var_0._id_627E != "prelobby" && var_1 == 0) {
        var_0._id_669A = "game_lobby";
      }

      if(issubstr(var_0._id_627E, "prelobby") && var_1 == 1) {
        var_0._id_669A = "game_lobby";
      }
    }

    waitframe();
  }
}

_id_3B96() {
  var_0 = self._id_0165;
  var_0 = int(var_0);
  return var_0;
}

_id_6338() {}

_id_A66A(var_0) {
  var_1 = isDefined(self._id_1DF8);
  var_2 = getdvarint("664") && var_0._id_6DAC != 0;

  if(!var_1 && !var_2) {
    _id_8BBB(var_0);
  }
}

_id_A66B(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("wait_load_costume");
  var_1 endon("death");
  wait(var_0);
  _id_A66A(var_1);
  var_1 notify("wait_load_costume");
}

_id_A669(var_0, var_1) {
  self endon("disconnect");
  var_0 notify("wait_load_costume");
  var_0 endon("wait_load_costume");
  var_0 endon("death");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  _id_4CCD(var_0);
  thread _id_A66B(5.0, var_0);

  for(var_2 = self loadcostumemodels(var_0._id_267E, var_0.team); !var_2; var_2 = self loadcostumemodels(var_0._id_267E, var_0.team)) {
    wait 0.1;
  }

  if(var_1) {
    _id_A66A(var_0);
  }

  var_0 notify("wait_load_costume");
}

_id_8F7D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(!isDefined(var_11)) {
    var_11 = 0;
  }

  if(!isDefined(var_12)) {
    var_12 = 0;
  }

  var_14 = !var_12;
  var_15 = "spectator";
  var_16 = "none";
  var_17 = maps\mp\hub_vl_base::_id_0C0E();
  var_18 = "avatar";
  var_19 = var_10;

  if(var_11) {
    var_18 = "cao_agent";
    var_19 = var_19 | 32768;
  }

  if(var_12) {
    var_18 = "clan_agent";
    var_19 = var_19 | 16384;
  }

  var_17.targetname = var_18;

  for(var_20 = 0; var_20 < 48; var_20++) {
    var_17._id_A561[var_20] = 0;
  }

  var_0._id_9042 = var_17;
  var_17._id_13B6 = var_0;
  var_17._id_267E = var_8;
  var_17._id_08D2 = 0;
  var_17._id_7EF4 = 0;

  if(var_11) {
    var_21 = var_17._id_13B6.origin;
  } else {
    var_21 = _getgroundposition(var_17._id_13B6.origin, 20, 512, 60);
  }

  var_17._id_8F80 = (var_0.angles[0], var_0.angles[1] + var_17._id_7EF4, var_0.angles[2]);
  var_17.angles = var_17._id_8F80;

  if(!var_12 && !level._id_A1FE) {
    var_17 show();
  }

  var_17._id_6DAC = var_10;
  var_17.origin = var_21;
  var_17.angles = var_17._id_8F80;
  var_17._id_92B8 = var_17._id_8F80;
  var_17._id_942A = var_17.angles[1];
  var_17._id_6469 = 0;
  var_17._id_942C = 0;
  var_17._id_7EF8 = 0;
  var_17._id_09F8 = 0;
  var_17._id_1E9B = 1;
  var_17.player = self;

  if(!isDefined(var_13) || !var_13) {
    var_22 = var_17._id_13B6.origin + (0, 0, -11);
    var_17._id_20F1 = var_19;
    _id_05E0(self getentitynumber(), var_19, "create", var_22);
    _id_05E0(self getentitynumber(), var_19, "angles", var_17.angles);

    if(isDefined(self)) {
      var_17._id_A561[self.clientid] = 1;
    }
  }

  var_17._id_1EAF = (0, 0, 0);
  var_17._id_1EAE = (0, 0, 0);

  if(!isDefined(self._id_9042)) {
    self._id_9042 = var_17;
  }

  if(var_11 == 1) {
    var_17._id_5541 = 1;
    var_2 = undefined;
    var_17.primaryweapon = undefined;
    var_17 _id_A1D5("cao_01", 1, "lobby_idle");
  } else if(var_12 == 1) {
    var_2 = undefined;
    var_17.primaryweapon = undefined;
    var_17 _id_A1D5("cao_01", 1, "lobby_idle");
  } else {
    level._id_A595[var_10] = var_17;
    var_23 = var_17 _id_441B(var_2);
    var_17 _id_A1D5(var_23._id_0BB4, 1, var_23._id_0EE8);
    var_17 thread _id_21F1(var_2, var_3, var_4, self);
  }

  _id_A587(self, var_10, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_17);
  thread _id_A669(var_17, var_14);

  if(getdvarint("664") && var_10 != 0 || var_12) {
    _id_4CCD(var_17);
  } else {
    _id_8BBB(var_17);
  }

  return var_17;
}

_id_21F1(var_0, var_1, var_2, var_3) {
  var_3 endon("disconnect");
  self endon("death");
  self endon("free_avatar");
  self._id_9428 = "m1garand_mp";

  if(!isDefined(var_0) && var_0 != "none") {
    self._id_9428 = var_0;
  } else if(isDefined(var_1) && var_1 != "none") {
    self._id_9428 = var_1;
  } else if(isDefined(var_2) && var_2 != "none") {
    self._id_9428 = var_2;
  }

  var_4 = undefined;

  for(;;) {
    if(!isDefined(self._id_7705)) {
      waitframe();
      continue;
    }

    if(isDefined(self) && isDefined(self.primaryweapon) && self.primaryweapon != "none") {
      var_5 = strtok(self.primaryweapon, "+");
      var_4 = var_5[0];
    }

    var_6 = self._id_0EEC;
    var_7 = level._id_0EE9["lobby_idle"]["cao_01"];
    var_8 = _id_441B(var_4);
    var_9 = var_7;

    if(isDefined(level._id_0EE9[var_8._id_0EE8]) && isDefined(level._id_0EE9[var_8._id_0EE8][var_8._id_0BB4])) {
      var_9 = level._id_0EE9[var_8._id_0EE8][var_8._id_0BB4];
    }

    if(isDefined(var_3._id_1EFF._id_627E)) {
      if(var_3._id_1EFF._id_669A != "cao" && var_3._id_1EFF._id_627E != "cao") {
        if(isDefined(self) && isDefined(var_4) && self.primaryweapon != "none") {
          var_12 = _id_5854(self.primaryweapon);
          var_13 = self._id_9428 != self.primaryweapon;
          var_14 = var_13 || var_6 != var_9;
          var_15 = self._id_9428 != "none" && _getweaponbasename(self._id_9428) != _getweaponbasename(self.primaryweapon);

          if(_weapontype(self.primaryweapon) == "melee") {
            _id_4CCF(self);
            _id_4CCE(self);
          } else if(var_14) {
            if(var_12) {
              if(var_15) {
                _id_4CCF(self);
                _id_4CCE(self);
                thread _id_115D(self, var_3);
                thread _id_8C12(self, var_3);
              }

              if(level._id_A1FE) {
                _id_05E0(var_3 getentitynumber(), self._id_20F1, "prim_weapon", self.primaryweapon);
              } else {
                self._id_7705 setpickupweapon(self.primaryweapon);
              }

              if(issubstr(self.primaryweapon, "akimbo")) {
                if(var_15) {
                  _id_A58A(var_3, self);
                }
              } else
                _id_A593(var_3._id_01D6, self);

              self._id_9428 = self.primaryweapon;
              var_8 = _id_441B(var_4);
              self._id_1EAD = var_8._id_1EAD;
              thread _id_0EB2(var_8._id_0BB4, var_8._id_0EE8, var_3);
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

_id_5854(var_0) {
  var_1 = 0;

  if(level.players.size > 0) {
    var_1 = level.players[0] worldweaponsloaded(var_0);

    if(!var_1) {
      level.players[0] loadweapons(var_0);
    }
  }

  return var_1;
}

_id_115D(var_0, var_1) {
  wait(var_1._id_1EFF._id_1E28);
  _id_1158(var_0);
}

_id_0EB2(var_0, var_1, var_2) {
  wait(var_2._id_1EFF._id_1E27);
  _id_A1D5(var_0, undefined, var_1);
}

_id_441B(var_0) {
  var_0 = maps\mp\_utility::_id_4431(var_0);
  var_1 = spawnStruct();
  var_1._id_0BB4 = var_0;

  if(isDefined(var_0) && var_0 != "" && var_0 != "none") {
    var_1._id_0EE8 = tablelookup("mp/vlobby_cac_offsets.csv", 0, var_0, 5);
    var_1._id_1EAD = tablelookup("mp/vlobby_cac_offsets.csv", 0, var_0, 6);

    if(isDefined(var_1._id_1EAD)) {
      if(var_1._id_1EAD == "") {
        self._id_1EAD = "stand";
      } else {
        self._id_1EAD = var_1._id_1EAD;
      }
    }
  }

  if(!isDefined(var_1._id_0EE8) || var_1._id_0EE8 == "") {
    var_1._id_0EE8 = "lobby_idle";
    var_1._id_0BB4 = "cao_01";
    var_1._id_1EAD = "stand";
  }

  if(!isDefined(var_1._id_1EAD)) {
    var_1._id_1EAD = "stand";
  }

  if(!isDefined(self._id_1EAD)) {
    self._id_1EAD = var_1._id_1EAD;
  }

  return var_1;
}

_id_A593(var_0, var_1) {
  if(isDefined(var_1._id_0BA9)) {
    if(level._id_A1FE) {
      _id_05E0(var_1.player getentitynumber(), var_1._id_20F1, "sec_weapon", "");
    } else {
      _setentplayerxuidforemblem(var_1._id_0BA9, var_0, 1);
      var_1._id_0BA9 delete();
      var_1._id_0BA9 = undefined;
    }
  }
}

_id_A58A(var_0, var_1) {
  if(issubstr(var_1._id_7705.primaryweapon, "akimbo")) {
    if(!isDefined(var_1._id_0BA9)) {
      if(level._id_A1FE) {
        var_2 = spawnStruct();
      } else {
        var_2 = spawn("weapon_" + var_1.primaryweapon, (0, 0, 0));
        var_3 = _id_43EA(var_1);
        _setentplayerxuidforemblem(var_2, var_3);
      }

      var_1._id_0BA9 = var_2;
      var_2.primaryweapon = var_1.primaryweapon;
    } else if(var_1._id_0BA9.primaryweapon != var_1.primaryweapon)
      var_1._id_0BA9.primaryweapon = var_1.primaryweapon;

    if(!level._id_A1FE) {
      var_1._id_0BA9 setpickupweapon(var_1.primaryweapon);
      var_4 = "tag_weapon_left";

      if(issubstr(var_1._id_0BA9.primaryweapon, "combatknife")) {
        var_4 = "tag_inhand";
      }

      if(issubstr(var_1._id_0BA9.primaryweapon, "riotshield")) {
        var_4 = "tag_weapon_left";
      }

      var_1._id_0BA9 unlink();
      var_1._id_0BA9.origin = var_1 gettagorigin(var_4);
      var_1._id_0BA9.angles = var_1 gettagangles(var_4);
      var_1._id_0BA9 hide();
      var_1._id_0BA9 showtoplayer(var_0);
      var_1._id_0BA9 linktosynchronizedparent(var_1, var_4);
      var_1._id_0BA9 setowneroriginal(var_0);
    } else
      _id_05E0(var_0 getentitynumber(), var_1._id_20F1, "sec_weapon", var_1._id_0BA9.primaryweapon);

    if(issubstr(var_1._id_7705.primaryweapon, "akimbo")) {
      thread _id_8BE9(var_1, var_0);
    } else if(!isDefined(var_1._id_9428)) {
      if(!level._id_A1FE) {
        var_1._id_0BA9 hide();
        var_1._id_0BA9 hideallparts();
      }
    }
  }
}

_id_A58D(var_0, var_1) {
  if(!isDefined(var_1.primaryweapon)) {
    return;
  }
  if(!isDefined(var_1._id_0E93)) {
    return;
  }
  if(var_1.primaryweapon != "none") {
    if(!isDefined(var_1._id_7705)) {
      if(level._id_A1FE) {
        var_2 = spawnStruct();
      } else {
        var_2 = spawn("weapon_" + var_1.primaryweapon, (0, 0, 0));
        var_3 = _id_43EA(var_1);
        _setentplayerxuidforemblem(var_2, var_3);
      }

      var_2.targetname = "avatar_weapon";
      var_1._id_7705 = var_2;
      var_2.primaryweapon = var_1.primaryweapon;

      if(!level._id_A1FE) {
        var_1._id_7705 hide();
        var_1._id_7705 showtoplayer(var_0);
        var_1._id_7705 setpickupweapon(var_1.primaryweapon);
      }

      _id_1158(var_1);
    } else if(var_1._id_7705.primaryweapon != var_1.primaryweapon)
      var_1._id_7705.primaryweapon = var_1.primaryweapon;
  } else {}
}

_id_1158(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.player)) {
    var_1 = var_0.player;
  }

  var_2 = "tag_weapon_right";

  if(issubstr(var_0._id_7705.primaryweapon, "combatknife")) {
    var_2 = "tag_inhand";
  }

  if(issubstr(var_0._id_7705.primaryweapon, "riotshield")) {
    var_2 = "tag_weapon_left";
  }

  if(level._id_A1FE) {
    _id_05E0(var_1 getentitynumber(), var_0._id_20F1, "prim_weapon", var_0.primaryweapon);
  } else {
    var_0._id_7705 unlink();
    var_0._id_7705.origin = var_0 gettagorigin(var_2);
    var_0._id_7705.angles = var_0 gettagangles(var_2);
    var_0._id_7705 linktosynchronizedparent(var_0, var_2);
    var_0._id_7705 setowneroriginal(var_1);
  }
}

_id_8BE9(var_0, var_1) {
  var_0 endon("death");
  var_0._id_7705 endon("death");
  var_0 endon("hide_akimbo_weapon");
  wait(var_1._id_1EFF._id_1E29);

  if(var_1._id_1EFF._id_669A != "cao" && var_1._id_1EFF._id_627E != "cao") {
    if(issubstr(var_0._id_7705.primaryweapon, "akimbo")) {
      if(!level._id_A1FE) {
        var_0._id_0BA9 showtoplayer(var_1);
      }
    }
  }
}

_id_8C12(var_0, var_1) {
  var_0 endon("death");
  var_0._id_7705 endon("death");
  var_0 endon("hide_primary_weapon");
  wait(var_1._id_1EFF._id_1E29);
  var_2 = getdvarint("664") && var_0._id_6DAC != 0;

  if(var_1._id_1EFF._id_669A != "cao" && var_1._id_1EFF._id_627E != "cao" && !var_2) {
    if(!level._id_A1FE) {
      var_0._id_7705 showtoplayer(var_1);
    }
  }
}

_id_A586(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_0._id_267E = var_1;
  }

  var_3 = "free";

  if(isDefined(var_0._id_76D2)) {
    if((var_0._id_76D2 & 1) == 0) {
      var_3 = "allies";
    }

    if((var_0._id_76D2 & 1) == 1) {
      var_3 = "axis";
    }
  }

  if(!isDefined(var_0._id_267E) || !_id_0510::_id_A27D(var_0._id_267E, var_3)) {
    if(isDefined(var_0.setnameplatematerial) && _id_0510::_id_A27D(var_0.setnameplatematerial, var_3)) {
      var_0._id_267E = var_0.setnameplatematerial;
    } else {
      var_0._id_267E = _id_0510::_id_448C();
      var_0.setnameplatematerial = var_0._id_267E;
    }
  }

  if(isDefined(var_2) && var_2) {
    self._id_267E = var_0._id_267E;
    var_4 = _id_0510::_id_73CA();

    if(!isDefined(var_0._id_5097) || !var_0._id_5097) {
      if(level._id_A1FE) {
        _id_05E0(var_0.player getentitynumber(), var_0._id_20F1, "costume", var_0._id_267E[0], var_0._id_267E[1], var_0._id_267E[2], var_0._id_267E[3], var_0._id_267E[4], var_0._id_267E[5]);
      } else {
        var_0 _meth_84C7(var_0._id_267E, "free");
      }
    }

    if(isDefined(self._id_1F8E)) {
      var_5 = self._id_1F8E;
      _id_A586(var_5, var_0._id_267E);

      if(!isDefined(var_5._id_5097) || !var_5._id_5097) {
        if(level._id_A1FE) {
          _id_05E0(var_5.player getentitynumber(), var_5._id_20F1, "costume", var_0._id_267E[0], var_0._id_267E[1], var_0._id_267E[2], var_0._id_267E[3], var_0._id_267E[4], var_0._id_267E[5]);
          return;
        }

        var_5 _meth_84C7(var_5._id_267E, "free");
        return;
        return;
      }

      return;
    }
  } else if(!isDefined(var_0._id_5097) || !var_0._id_5097) {
    if(level._id_A1FE) {
      _id_05E0(var_0.player getentitynumber(), var_0._id_20F1, "costume", var_0._id_267E[0], var_0._id_267E[1], var_0._id_267E[2], var_0._id_267E[3], var_0._id_267E[4], var_0._id_267E[5]);
    } else {
      var_0 _meth_84C7(var_0._id_267E, "free");
    }
  }
}

_id_A587(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_10)) {
    var_10 = level._id_A595[var_1];
  }

  var_11 = 0;

  if(isDefined(var_10._id_5DEE) && var_10._id_5DEE._id_012F >= 0) {
    var_11 = 1;
  }

  _id_A586(var_10, var_9);

  if(var_11 && isDefined(var_0)) {
    if(level._id_A1FE) {
      _id_05E0(var_0 getentitynumber(), var_10._id_20F1, "costume", var_10._id_267E[0], var_10._id_267E[1], var_10._id_267E[2], var_10._id_267E[3], var_10._id_267E[4], var_10._id_267E[5]);
    }

    var_0 _meth_84C7(var_10._id_267E);
  }

  var_13 = "m1garand_mp";

  if(!isDefined(var_3)) {
    var_13 = undefined;
  } else if(var_3 != "none") {
    var_13 = var_3;
  } else if(isDefined(var_4) && var_4 != "none") {
    var_13 = var_4;
  } else if(isDefined(var_5) && var_5 != "none") {
    var_13 = var_5;
  }

  var_10._id_0079 = var_2;
  var_10.primaryweapon = var_13;
  var_10._id_01A0 = var_7;
  var_10._id_00ED = var_6;
  var_10._id_6F65 = var_8;
  _id_A58D(var_0, var_10);
}

_id_62F5(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if((var_1 == "classpreview" || var_1 == "classpreview_postcopy") && isDefined(var_2)) {
      if(var_2 >= 0) {
        var_3 = var_2 & 15;
        var_4 = int(var_2 / 16);
        maps\mp\hub_vl_base::_id_A59E("classpreview " + var_1 + " controller=" + var_3 + "class=" + var_4 + " owner " + var_0);

        if(var_4 > 0) {
          self._id_1DF8 = 1;
          self._id_294D = var_4 - 1;
        }

        var_5 = var_1 == "classpreview_postcopy";
        var_6 = level._id_A595[var_0];

        if(isDefined(var_6)) {
          self._id_A58C = var_0;
          _id_A558(var_0, "lobby" + (self._id_294D + 1), !var_5);
          self._id_1E1F = var_6.primaryweapon;
        }

        level._id_3E0C = var_5;
        continue;
      }

      self._id_1DF8 = undefined;
    }
  }
}

_id_62EC(var_0, var_1) {
  var_2 = "";

  if(var_1 != "current" && var_1 != "none" && var_2 == "") {
    var_3 = tablelookup("mp/statstable.csv", 2, var_1, 9);

    if(var_3 == "") {
      var_3 = 0;
    }

    var_4 = maps\mp\gametypes\_class::_id_1D66(var_1, var_3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  } else if(var_1 == "none")
    var_4 = "none";
  else {
    var_5 = level._id_A595[var_0];
    var_4 = var_5.primaryweapon;
  }

  self._id_1E1F = var_4;
}

_id_4B46(var_0, var_1) {
  if(var_0.size >= var_1.size) {
    if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_62F8(var_0) {
  self endon("disconnect");
  var_1 = [];

  while(!isDefined(self._id_1EFF)) {
    self waittill("luinotifyserver", var_2, var_3);

    if(isDefined(var_3)) {
      var_1[var_1.size] = [var_2, var_3];
      continue;
    }

    var_1[var_1.size] = [var_2];
  }

  for(;;) {
    if(var_1.size > 0) {
      var_4 = var_1[0];
      var_5 = [];

      for(var_6 = 1; var_6 < var_1.size; var_6++) {
        var_5[var_5.size] = var_1[var_6];
      }

      var_1 = var_5;
      var_2 = var_4[0];

      if(var_4.size > 1) {
        var_3 = var_4[1];
      } else {
        var_3 = undefined;
      }
    } else
      self waittill("luinotifyserver", var_2, var_3);

    if(var_2 == "cac" && isDefined(var_3)) {
      if(var_3 == 0) {
        self._id_1DF8 = undefined;
      } else {
        self._id_1DF8 = 1;
      }

      self._id_A588 = undefined;
      continue;
    }

    if(var_2 == "weapon_highlighted" && isDefined(var_3)) {
      if(issubstr(var_3, "stream:")) {
        var_7 = strtok(var_3, ":");

        if(var_7.size > 1) {
          var_8 = var_7[var_7.size - 1];

          if(!_id_4B46(var_8, "_mp")) {
            var_8 = var_8 + "_mp";
          }

          maps\mp\hub_vl_base::_id_A59F("weapon_stream: " + var_8);
          var_9 = [var_8];
          self loadweapons(var_9);
        }

        _id_62EC(var_0, "none");
      } else {
        maps\mp\hub_vl_base::_id_A59F("weapon_highlighted" + var_3);
        _id_62EC(var_0, var_3);
      }

      continue;
    }

    if(var_2 == "lootscreen_weapon_highlighted" && isDefined(var_3)) {
      if(var_3 == "none") {
        self._id_1DF8 = undefined;
      } else if(var_3 == "reset") {
        self._id_1DF8 = 1;
      } else {
        self._id_1DF8 = 1;
      }

      self._id_A588 = undefined;
      continue;
    }

    var_10 = 0;

    if(var_2 == "preview_attach1") {
      var_10 = 1;
    } else if(var_2 == "preview_attach2") {
      var_10 = 2;
    } else if(var_2 == "preview_attach3") {
      var_10 = 3;
    }

    if(var_10 > 0 && isDefined(var_3)) {
      var_11 = level._id_A595[var_0];
      var_12 = var_11._id_5DEE;
      var_13 = var_12._id_013B;
      var_14 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013C, 3);
      var_15 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013D, 3);
      var_16 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013E, 3);
      var_17 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_013F, 3);
      var_18 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_0140, 3);
      var_19 = tablelookup("mp/attachmenttable.csv", 0, var_12._id_0141, 3);
      var_20 = var_12._id_0142;

      if(var_3 != "current") {
        if(var_10 == 1) {
          var_14 = var_3;
        } else if(var_10 == 2) {
          var_15 = var_3;
        } else if(var_10 == 3) {
          var_16 = var_3;
        } else if(var_10 == 4) {
          var_17 = var_3;
        } else if(var_10 == 5) {
          var_18 = var_3;
        } else if(var_10 == 6) {
          var_19 = var_3;
        }
      }

      self._id_1E1F = maps\mp\gametypes\_class::_id_1D66(maps\mp\_utility::_id_452B(var_13), var_14, var_15, var_16, var_17, var_18, var_19, maps\mp\_utility::_id_472C(var_13), var_20, 0, 0);
    }
  }
}

_id_44E9(var_0) {
  foreach(var_3, var_2 in level._id_A595) {
    if(isDefined(var_2._id_5DEE) && isDefined(var_2._id_5DEE._id_012F) && var_2._id_5DEE._id_012F == var_0) {
      return var_3;
    }
  }

  maps\mp\hub_vl_base::_id_A59F("unable to find avatar for controller " + var_0);
  return -1;
}

_id_A558(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.pers["class"]) && self.pers["class"] == var_1 && (!isDefined(var_3) || !var_3)) {
    return;
  }
  self.pers["class"] = var_1;
  self.class = var_1;
  maps\mp\gametypes\_class::setclass(self.pers["class"]);
  self._id_95AE = undefined;
  self._id_95AF = undefined;
  maps\mp\gametypes\_class::_id_4773(self.pers["team"], self.pers["class"]);

  if(var_2) {
    _id_A587(self, var_0, self.primaryweapon, self.botclearscriptenemy, self._id_60FA, self._id_5DF4, self._id_5DF7, self._id_6F65, self._id_267E);

    if(isDefined(self._id_1F8E)) {
      _id_A587(self, var_0, undefined, self.botclearscriptenemy, self._id_60FA, self._id_5DF4, self._id_5DF7, self._id_6F65, self._id_267E, self._id_1F8E);
    }
  }
}

_id_4835() {
  var_0 = ["privateMatchCustomClasses", "customClasses"];
  var_1 = [10, 20];
  var_2 = 0;
  self._id_5E01 = [];
  self._id_294D = 0;

  foreach(var_4 in var_0) {
    level._id_3E0E = var_4;
    self._id_5E01[var_4] = [];
    var_5 = var_1[var_2];
    var_2++;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      self._id_5E01[var_4][var_6] = _id_04E0::_id_4834(var_4, var_6);
    }
  }

  level._id_3E0E = undefined;
}

_id_A0AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25, var_26, var_27, var_28, var_29, var_30, var_31, var_32) {
  var_33 = int(self._id_294D);
  var_34 = maps\mp\_utility::_id_1E01();
  self._id_5E01[var_34][var_33]["division"] = var_0;
  self._id_5E01[var_34][var_33]["primaryWeaponStruct"] = maps\mp\_utility::_id_473C(var_1, 0);
  self._id_5E01[var_34][var_33]["primaryAttachmentsGUID"][0] = var_2;
  self._id_5E01[var_34][var_33]["primaryAttachmentsGUID"][1] = var_3;
  self._id_5E01[var_34][var_33]["primaryAttachmentsGUID"][2] = var_4;
  self._id_5E01[var_34][var_33]["primaryAttachmentsGUID"][3] = var_5;
  self._id_5E01[var_34][var_33]["primaryAttachmentsGUID"][4] = var_6;
  self._id_5E01[var_34][var_33]["primaryAttachmentsGUID"][5] = var_7;
  self._id_5E01[var_34][var_33]["primaryCamoGUID"] = var_8;
  self._id_5E01[var_34][var_33]["primaryReticleGUID"] = var_9;
  self._id_5E01[var_34][var_33]["primaryCustomization"] = var_31;
  self._id_5E01[var_34][var_33]["secondaryWeaponStruct"] = maps\mp\_utility::_id_473C(var_10, 0);
  self._id_5E01[var_34][var_33]["secondaryAttachmentsGUID"][0] = var_11;
  self._id_5E01[var_34][var_33]["secondaryAttachmentsGUID"][1] = var_12;
  self._id_5E01[var_34][var_33]["secondaryAttachmentsGUID"][2] = var_13;
  self._id_5E01[var_34][var_33]["secondaryAttachmentsGUID"][3] = var_14;
  self._id_5E01[var_34][var_33]["secondaryAttachmentsGUID"][4] = var_15;
  self._id_5E01[var_34][var_33]["secondaryAttachmentsGUID"][5] = var_16;
  self._id_5E01[var_34][var_33]["secondaryCamoGUID"] = var_17;
  self._id_5E01[var_34][var_33]["secondaryReticleGUID"] = var_18;
  self._id_5E01[var_34][var_33]["secondaryCustomization"] = var_32;
  self._id_5E01[var_34][var_33]["meleeWeaponStruct"] = maps\mp\_utility::_id_473C(var_19, 0);
  self._id_5E01[var_34][var_33]["equipmentStruct"] = maps\mp\_utility::_id_44CE(var_20, 0);
  self._id_5E01[var_34][var_33]["lethalGUID"] = var_20;
  self._id_5E01[var_34][var_33]["offhandStruct"] = maps\mp\_utility::_id_44CE(var_21, 0);
  self._id_5E01[var_34][var_33]["tacticalGUID"] = var_21;
  self._id_5E01[var_34][var_33]["perkGUID0"] = var_22;
  self._id_5E01[var_34][var_33]["perkGUID1"] = var_23;
  self._id_5E01[var_34][var_33]["perkGUID2"] = var_24;
  self._id_5E01[var_34][var_33]["perkGUID3"] = var_25;
  self._id_5E01[var_34][var_33]["perkGUID4"] = var_26;
  self._id_5E01[var_34][var_33]["perkGUID5"] = var_27;
  self._id_5E01[var_34][var_33]["perkGUID6"] = var_28;
  self._id_5E01[var_34][var_33]["perkGUID7"] = var_29;
  self._id_5E01[var_34][var_33]["perkGUID8"] = var_30;
}

_id_5DEF(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(var_0._id_013B != var_1._id_013B) {
    return 1;
  }

  if(var_0._id_013C != var_1._id_013C) {
    return 1;
  }

  if(var_0._id_013D != var_1._id_013D) {
    return 1;
  }

  if(var_0._id_013E != var_1._id_013E) {
    return 1;
  }

  if(var_0._id_013F != var_1._id_013F) {
    return 1;
  }

  if(var_0._id_0140 != var_1._id_0140) {
    return 1;
  }

  if(var_0._id_0141 != var_1._id_0141) {
    return 1;
  }

  if(var_0._id_0142 != var_1._id_0142) {
    return 1;
  }

  if(var_0._id_0143 != var_1._id_0143) {
    return 1;
  }

  if(var_0._id_016E != var_1._id_016E) {
    return 1;
  }

  if(var_0._id_0170 != var_1._id_0170) {
    return 1;
  }

  if(var_0._id_0171 != var_1._id_0171) {
    return 1;
  }

  if(var_0._id_0172 != var_1._id_0172) {
    return 1;
  }

  if(var_0.disableforcethirdpersonwhenfollowing != var_1.disableforcethirdpersonwhenfollowing) {
    return 1;
  }

  if(var_0._id_8351 != var_1._id_8351) {
    return 1;
  }

  if(var_0._id_8352 != var_1._id_8352) {
    return 1;
  }

  if(var_0._id_0173 != var_1._id_0173) {
    return 1;
  }

  if(var_0._id_0174 != var_1._id_0174) {
    return 1;
  }

  if(var_0._id_01A0 != var_1._id_01A0) {
    return 1;
  }

  if(var_0._id_00ED != var_1._id_00ED) {
    return 1;
  }

  return 0;
}

_id_267F(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(!isDefined(var_1)) {
      return 0;
    }

    return 1;
  }

  if(var_0.size != var_1.size) {
    return 1;
  }

  if(!_id_0510::_id_A27D(var_1, var_2)) {
    return 0;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_1[var_3] < 0) {
      return 0;
    }

    if(var_0[var_3] != var_1[var_3]) {
      return 1;
    }
  }

  return 0;
}

_id_8660(var_0) {
  if(var_0[level._id_2682["head"]] == 0) {
    var_0[level._id_2682["head"]] = 1;
  }

  if(!var_0[level._id_2682["shirt"]]) {
    var_0[level._id_2682["shirt"]] = 1;
  }

  if(!var_0[level._id_2682["pants"]]) {
    var_0[level._id_2682["pants"]] = 1;
  }

  if(!var_0[level._id_2682["gear"]]) {
    var_0[level._id_2682["gear"]] = 1;
  }

  return var_0;
}

_id_3B94(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3._id_01D6 == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_631E() {
  level._id_60B7 = [];
  var_0 = maps\mp\_utility::_id_4604();

  for(;;) {
    while(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
    }

    while(isDefined(level.players) && level.players.size > 0) {
      var_1 = [];
      var_2 = [];
      var_3 = 0;
      var_4 = 0;
      var_5 = 0;

      foreach(var_7 in level._id_60B7) {
        var_8 = var_7._id_0079;
        var_9 = var_7._id_013B;
        var_10[0] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013C, 3));
        var_10[1] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013D, 3));
        var_10[2] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013E, 3));
        var_10[3] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_013F, 3));
        var_10[4] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0140, 3));
        var_10[5] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0141, 3));
        var_11 = var_7._id_0144;
        var_12 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0142, 1));
        var_13 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0143, 1));
        var_14 = maps\mp\_utility::_id_452A(tablelookup("mp/reticleTable.csv", 0, var_7._id_0145, 1));
        var_15 = var_7._id_016E;
        var_16[0] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0170, 3));
        var_16[1] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0171, 3));
        var_16[2] = maps\mp\_utility::_id_452A(tablelookup("mp/attachmenttable.csv", 0, var_7._id_0172, 3));
        var_16[3] = 0;
        var_16[4] = 0;
        var_16[5] = 0;
        var_17 = var_7._id_0176;
        var_18 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0173, 1));
        var_19 = maps\mp\_utility::_id_452A(tablelookup("mp/camoTable.csv", 0, var_7._id_0174, 1));
        var_20 = maps\mp\_utility::_id_452A(tablelookup("mp/reticleTable.csv", 0, var_7._id_0177, 1));
        var_21 = var_7._id_0101;
        var_22 = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_00ED, 1));
        var_23 = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_01A0, 1));
        var_24[0] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0123, 1));
        var_24[1] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0124, 1));
        var_24[2] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0125, 1));
        var_24[3] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0126, 1));
        var_24[4] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0127, 1));
        var_24[5] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0128, 1));
        var_24[6] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_0129, 1));
        var_24[7] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_012A, 1));
        var_24[8] = maps\mp\_utility::_id_452A(tablelookup(var_0, 0, var_7._id_012B, 1));
        var_25 = 1;

        if(!maps\mp\gametypes\_class::isvalidprimary(var_9, var_25) && !maps\mp\gametypes\_class::isvalidsecondary(var_15, var_25)) {
          var_9 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 0);

          for(var_26 = 0; var_26 < 6; var_26++) {
            var_10[var_26] = 0;
          }
        }

        if(!maps\mp\gametypes\_class::isvalidsecondary(var_15, var_25)) {
          var_15 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 1);

          for(var_26 = 0; var_26 < 6; var_26++) {
            var_16[var_26] = 0;
          }
        }

        var_27 = maps\mp\gametypes\_class::_id_1D66(maps\mp\_utility::_id_452B(var_9), var_10[0], var_10[1], var_10[2], var_10[3], var_10[4], var_10[5], maps\mp\_utility::_id_472C(var_9), var_12, var_14, var_11);
        var_28 = maps\mp\gametypes\_class::_id_1D66(maps\mp\_utility::_id_452B(var_15), var_16[0], var_16[1], var_16[2], var_16[3], var_16[4], var_16[5], maps\mp\_utility::_id_472C(var_15), var_18, var_20, var_17);
        var_29 = maps\mp\_utility::_id_452B(var_21);
        var_30 = [];
        var_30[level._id_2682["shirt"]] = var_7._id_017F;
        var_30[level._id_2682["head"]] = var_7._id_00B9;
        var_30[level._id_2682["pants"]] = var_7._id_011A;
        var_30[level._id_2682["eyewear"]] = var_7._id_0091;
        var_30[level._id_2682["hat"]] = var_7._id_00B8;
        var_30[level._id_2682["gear"]] = var_7._id_00A8;
        var_31 = [];

        if(!isDefined(level._id_AAE2[var_7._id_01D6]) && maps\mp\hub_vl_base::_id_0BC6()) {
          maps\mp\hub_vl_base::_id_7E37(var_7._id_01D6);
        }

        var_32 = _id_3B94(var_7._id_01D6);

        if(isDefined(var_32) && var_7._id_011C != 0) {
          var_2[var_4] = var_32;
          var_4++;
        } else if(!isDefined(var_32)) {}

        if(!isDefined(level._id_AAE2[var_7._id_01D6])) {
          if(var_7._id_011C != 0) {
            var_33 = maps\mp\hub_vl_base::_id_0902(var_7._id_01D6);
            maps\mp\hub_vl_base::_id_A59E("PartyMemberClassChange " + var_7._id_01D6 + " : " + var_27 + "," + var_28 + "," + var_22 + "," + var_23 + "\n");
            setDvar("1999", level._id_AAE2.size);
            var_34 = _id_4696(var_33);

            if(isDefined(var_32)) {
              var_1[var_3] = var_32 _id_8F7D(var_34, var_8, var_27, var_28, var_29, var_22, var_23, var_31, var_30, var_7.name, var_33, 0, 0, 0);
            } else {
              var_1[var_3] = _id_8F7D(var_34, var_8, var_27, var_28, var_29, var_22, var_23, var_31, var_30, var_7.name, var_33, 0, 0, 0);
            }

            var_3++;
            maps\mp\hub_vl_base::_id_13B4(var_33);
            _setentplayerxuidforemblem(level._id_A595[var_33], var_7._id_01D6);
            level._id_A595[var_33]._id_5DEE = var_7;
            level._id_A595[var_33]._id_6101 = gettime() + 4000;
            var_35 = _getEnt("cao_spawnpoint", "targetname");
            var_32._id_1FA3 = var_35;
            var_32._id_1F9D = var_27;

            if(isDefined(level._id_A589)) {
              _id_4CCD(level._id_A595[var_33]);
            }
          }
        } else {
          var_33 = level._id_AAE2[var_7._id_01D6];
          var_36 = level._id_A595[var_33];

          if(var_7._id_011C != 0) {
            var_1[var_3] = var_36;
            var_3++;
          }

          if(var_7._id_012F >= 0) {
            foreach(var_38 in level.players) {
              if(var_38._id_A58C == var_33) {
                var_38 _id_A0AD(var_8, var_9, var_10[0], var_10[1], var_10[2], var_10[3], var_10[4], var_10[5], var_12, var_14, var_15, var_16[0], var_16[1], var_16[2], var_16[3], var_16[4], var_16[5], var_18, var_20, var_21, var_22, var_23, var_24[0], var_24[1], var_24[2], var_24[3], var_24[4], var_24[5], var_24[6], var_24[7], var_24[8], var_11, var_17);
              }
            }

            if(isDefined(var_36._id_76D2)) {
              if(isDefined(var_36._id_2685) && isDefined(var_36._id_2685[var_36._id_76D2])) {
                var_30 = var_36._id_2685[var_36._id_76D2];
              } else {
                var_30 = level.players[0] maps\mp\gametypes\_class::_id_1F97(var_36._id_76D2);
              }

              var_30 = _id_8660(var_30);

              if(!isDefined(var_36._id_2685)) {
                var_36._id_2685 = [];
              }

              var_36._id_2685[var_36._id_76D2] = var_30;

              if(var_36._id_76D3 != "none") {
                var_40 = level._id_2682[var_36._id_76D3];
                var_30[var_40] = var_36._id_76D4;
              }
            }
          }

          var_41 = "free";

          if(isDefined(var_36._id_76D2)) {
            if((var_36._id_76D2 & 1) == 0) {
              var_41 = "allies";
            }

            if((var_36._id_76D2 & 1) == 1) {
              var_41 = "axis";
            }

            var_30 = _func_282(var_30, var_41);
          }

          if(_id_5DEF(var_36._id_5DEE, var_7) || _id_267F(var_36._id_267E, var_30, var_41) || isDefined(level._id_3E0C) && level._id_3E0C) {
            var_5 = 1;
            maps\mp\hub_vl_base::_id_A59E("Updating xuid " + var_7._id_01D6 + " with ownerId=" + var_33 + "\n");
            maps\mp\hub_vl_base::_id_A59E("PartyMemberClassChange " + var_7._id_01D6 + " : " + var_27 + "," + var_28 + "," + var_22 + "," + var_23 + "\n");

            if(isDefined(var_36.player)) {
              var_36.player._id_267E = var_30;
            }

            _id_A587(var_36.player, var_33, var_27, var_28, var_29, var_22, var_23, var_31, var_30);

            if(var_7._id_012F >= 0 && isDefined(var_36.player._id_1F8E)) {
              _id_A587(var_36.player, var_33, undefined, var_28, "none", var_22, var_23, var_31, var_30, var_36.player._id_1F8E);
            }

            var_36._id_5DEE = var_7;
            level._id_3E0C = 0;
          }
        }

        if(var_7._id_011C != 0) {
          var_3++;
        }
      }

      _id_13B9(var_1, var_2, var_5);
      level._id_60B7 = [];
      maps\mp\hub_vl_base::_id_A095();
      waitframe();
    }
  }
}

_id_13B9(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_5 _id_4697(var_3);
    var_6 = _getgroundposition(var_5._id_13B6.origin, 20, 512, 60);
    var_7 = distance(var_6, var_5.origin) >= 0.1;
    var_5.origin = var_6;
    _id_4CCD(var_5);

    if(isDefined(var_5._id_20F1)) {
      var_8 = var_5._id_20F1;
    } else {
      var_8 = var_3 + 1;
      var_5._id_20F1 = var_8;
    }

    foreach(var_10 in var_1) {
      if(var_5._id_A561[var_10.clientid] == 0) {
        var_11 = var_10 getentitynumber();
        _id_05E0(var_10 getentitynumber(), var_8, "create", var_5.origin);
        _id_05E0(var_10 getentitynumber(), var_8, "angles", var_5.angles);
        _id_05E0(var_10 getentitynumber(), var_8, "costume", var_5._id_267E[0], var_5._id_267E[1], var_5._id_267E[2], var_5._id_267E[3], var_5._id_267E[4], var_5._id_267E[5]);

        if(isDefined(var_5._id_0EEC)) {
          _id_05E0(var_10 getentitynumber(), var_8, "anim", var_5._id_0EEC);
        }

        var_5._id_A561[var_10.clientid] = 1;
      } else if(var_2)
        _id_05E0(var_10 getentitynumber(), var_8, "costume", var_5._id_267E[0], var_5._id_267E[1], var_5._id_267E[2], var_5._id_267E[3], var_5._id_267E[4], var_5._id_267E[5]);

      if(var_7) {
        _id_05E0(var_10 getentitynumber(), var_8, "pos", var_5.origin);
      }
    }

    _id_8BBB(var_5);
    var_3++;
  }
}

_id_6CC1(var_0) {
  if(!isDefined(level._id_7613)) {
    level._id_7614 = _tablegetcolumncount(level._id_761B) - 1;
    level._id_7613 = randomint(level._id_7614);
  }

  if(!isDefined(level._id_7612)) {
    var_1 = _tablegetcolumncount(level._id_761A) - 1;
    level._id_7612 = randomint(var_1);
  }

  var_4 = var_0;
  var_5 = _getcostumefromtable(level._id_761B, level._id_7613 + 1);
  var_4._id_017F = var_5[level._id_2682["shirt"]];
  var_4._id_00B9 = var_5[level._id_2682["head"]];
  var_4._id_011A = var_5[level._id_2682["pants"]];
  var_4._id_0091 = var_5[level._id_2682["eyewear"]];
  var_4._id_00B8 = var_5[level._id_2682["hat"]];
  var_4._id_00A8 = var_5[level._id_2682["gear"]];
  var_6 = level._id_7612;
  var_7 = var_6 + 1;
  var_8 = tablelookup(level._id_761A, 0, "loadoutPrimaryAttachment", var_7);
  var_9 = tablelookup(level._id_761A, 0, "loadoutPrimaryAttachment2", var_7);
  var_10 = tablelookup(level._id_761A, 0, "loadoutPrimaryAttachment3", var_7);
  var_11 = tablelookup(level._id_761A, 0, "loadoutPrimaryAttachment4", var_7);
  var_12 = tablelookup(level._id_761A, 0, "loadoutPrimaryAttachment5", var_7);
  var_13 = tablelookup(level._id_761A, 0, "loadoutPrimaryAttachment6", var_7);
  var_4._id_7709 = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::table_getweapon(level._id_761A, var_7, 0), 0);
  var_4._id_013C = int(tablelookup("mp/attachmenttable.csv", 3, var_8, 0));
  var_4._id_013D = int(tablelookup("mp/attachmenttable.csv", 3, var_9, 0));
  var_4._id_013E = int(tablelookup("mp/attachmenttable.csv", 3, var_10, 0));
  var_4._id_013F = int(tablelookup("mp/attachmenttable.csv", 3, var_11, 0));
  var_4._id_0140 = int(tablelookup("mp/attachmenttable.csv", 3, var_12, 0));
  var_4._id_0141 = int(tablelookup("mp/attachmenttable.csv", 3, var_13, 0));
  var_4._id_76F5 = maps\mp\gametypes\_class::table_getweaponcamo(level._id_761A, var_7, 0);
  var_4._id_7700 = maps\mp\gametypes\_class::table_getweaponreticle(level._id_761A, var_7, 0);
  var_14 = tablelookup(level._id_761A, 0, "loadoutSecondaryAttachment", var_7);
  var_15 = tablelookup(level._id_761A, 0, "loadoutSecondaryAttachment2", var_7);
  var_16 = tablelookup(level._id_761A, 0, "loadoutSecondaryAttachment3", var_7);
  var_17 = tablelookup(level._id_761A, 0, "loadoutSecondaryAttachment4", var_7);
  var_18 = tablelookup(level._id_761A, 0, "loadoutSecondaryAttachment5", var_7);
  var_19 = tablelookup(level._id_761A, 0, "loadoutSecondaryAttachment6", var_7);
  var_4.botgetscriptgoalradius = maps\mp\_utility::_id_473C(maps\mp\gametypes\_class::table_getweapon(level._id_761A, var_7, 1), 0);
  var_4._id_0170 = int(tablelookup("mp/attachmenttable.csv", 3, var_14, 0));
  var_4._id_0171 = int(tablelookup("mp/attachmenttable.csv", 3, var_15, 0));
  var_4._id_0172 = int(tablelookup("mp/attachmenttable.csv", 3, var_16, 0));
  var_4.disableforcethirdpersonwhenfollowing = int(tablelookup("mp/attachmenttable.csv", 3, var_17, 0));
  var_4._id_8351 = int(tablelookup("mp/attachmenttable.csv", 3, var_18, 0));
  var_4._id_8352 = int(tablelookup("mp/attachmenttable.csv", 3, var_19, 0));
  var_4.botsetscriptmove = maps\mp\gametypes\_class::table_getweaponcamo(level._id_761A, var_7, 1);
  var_4.botsetscriptenemy = maps\mp\gametypes\_class::table_getweaponreticle(level._id_761A, var_7, 1);
  return var_4;
}

_id_0953(var_0) {
  if(getdvarint("664")) {
    var_0 = _id_6CC1(var_0);
  }

  for(var_1 = 0; var_1 < level._id_60B7.size; var_1++) {
    if(level._id_60B7[var_1]._id_01D6 == var_0._id_01D6) {
      level._id_60B7[var_1] = var_0;
      var_0 = undefined;
      break;
    }
  }

  if(isDefined(var_0)) {
    level._id_60B7[level._id_60B7.size] = var_0;
  }
}

_id_6EA2(var_0) {
  if(!isDefined(level._id_AAE2)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = var_2._id_01D6;
    var_4 = level._id_AAE2[var_3];

    if(isDefined(var_4)) {
      var_5 = level._id_A595[var_4];

      if(isDefined(var_5)) {
        var_5._id_6101 = gettime() + 2000;
        var_5._id_6100 = undefined;
      }
    }

    if(var_2._id_013B >= 0) {
      _id_0953(var_2);
    }
  }
}

_id_6320() {
  for(;;) {
    var_0 = getdvarint("splitscreen", 0);
    var_1 = _isonlinegame();
    var_2 = _issystemlink();

    foreach(var_5, var_4 in level._id_A595) {
      if(maps\mp\hub_vl_base::_id_13B5(var_5)) {
        continue;
      }
      if(var_4._id_6101 >= 0) {
        if(var_4._id_6101 < gettime()) {
          if(var_5 == 0 && !isDefined(var_4._id_6100)) {
            var_4._id_6101 = gettime() + 2000;
            var_4._id_6100 = 1;
            continue;
          }

          maps\mp\hub_vl_base::_id_A59E("Schedule removal of ownerId " + var_5 + " from timeout\n");
          maps\mp\hub_vl_base::springcamdisabled(var_5);
        }
      }
    }

    waitframe();
  }
}

_id_4169(var_0) {
  var_1 = "mp/E3CostumeTable.csv";
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_2682.size; var_3++) {
    var_2[var_3] = int(_tablelookupbyrow(var_1, var_3 + 1, var_0 + 1));
  }

  return var_2;
}

_id_62FC(var_0, var_1) {}

_id_631F() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "member_select") {
      self._id_A58C = level._id_AAE2[var_1];

      if(!isDefined(self._id_A58C)) {
        maps\mp\hub_vl_base::_id_A59E("vl_focus undefined, setting to 0\n");
        self._id_A58C = 0;
      }

      maps\mp\hub_vl_base::_id_A59E("selected member " + var_1 + " ownerId=" + self._id_A58C + "\n");
    }

    if(var_0 == "vlpresentable") {
      maps\mp\hub_vl_base::_id_A59E("in main menu\n");
      thread _id_8A5F();
    }

    if(var_0 == "leave_lobby") {
      maps\mp\hub_vl_base::_id_A59E("leave_lobby xuid=" + var_1 + "\n");

      if(var_1 == "0") {
        foreach(var_1, var_3 in level._id_AAE2) {
          maps\mp\hub_vl_base::_id_A59E("Schedule removal of ownerId " + var_3 + "\n");
          maps\mp\hub_vl_base::springcamdisabled(var_3, 0.25);
        }
      } else {
        var_3 = level._id_AAE2[var_1];

        if(isDefined(var_3)) {
          maps\mp\hub_vl_base::_id_A59E("Schedule removal of ownerId " + var_3 + "\n");
          maps\mp\hub_vl_base::springcamdisabled(var_3, 0.25);
        }
      }

      thread _id_7D77();
    }
  }
}

_id_62EF(var_0, var_1) {
  if(var_0 < 0) {
    self._id_A588 = undefined;
  } else {
    self._id_A588 = var_1;
  }
}

_id_1F9F(var_0, var_1) {
  maps\mp\hub_vl_base::_id_A59F("Cao set costumes from lua:" + var_0);
  var_2 = strtok(var_0, "#");

  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "|");

    if(var_5.size > 0) {
      var_6 = level._id_A595[var_1];

      if(isDefined(var_6)) {
        var_6._id_08D2 = int(var_5[1]);

        for(var_7 = 2; var_7 < var_5.size; var_7++) {
          var_8 = strtok(var_5[var_7], ",");
          var_9 = [];

          for(var_10 = 1; var_10 < var_8.size; var_10++) {
            var_9[var_9.size] = int(var_8[var_10]);
          }

          if(!isDefined(var_6._id_2685)) {
            var_6._id_2685 = [];
          }

          var_6._id_2685[int(var_8[0])] = var_9;
        }
      }
    }
  }
}

_id_62F0(var_0, var_1) {
  var_2 = strtok(var_0, ":");
  var_3 = int(var_2[0]);
  var_4 = strtok(var_2[1], ",");
  var_5 = level._id_A595[var_1];

  if(isDefined(var_5)) {
    var_5._id_76D2 = int(var_4[0]);
    var_5._id_76D3 = var_4[1];
    var_5._id_76D4 = int(var_4[2]);
  }

  return var_5;
}

_id_62F9(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "cao") {
      _id_62EF(var_2, var_0);
      self._id_1FA8 = undefined;
      var_3 = level._id_A595[var_0];

      if(var_2 < 0 && isDefined(var_3)) {
        var_3._id_76D3 = undefined;
        var_3._id_76D4 = undefined;
        var_3._id_76D2 = undefined;

        if(isDefined(var_3._id_2685)) {
          _id_A586(var_3, var_3._id_2685[var_3._id_08D2], 1);
        }
      }

      continue;
    }

    if(var_1 == "lootscreen_gear_highlighted") {
      self._id_1DF8 = undefined;
      _id_62EF(var_2, var_0);

      if(isDefined(self._id_A588)) {
        self._id_1FA8 = (56, 0, 5);
      } else {
        self._id_1FA8 = undefined;
      }

      self._id_1EFF._id_77BF = "prelobby_loot";
      continue;
    }

    if(var_1 == "costumes") {
      _id_1F9F(var_2, var_0);
      continue;
    }

    if(var_1 == "costume_preview") {
      _id_62F0(var_2, var_0);
      continue;
    }

    if(var_1 == "costume_apply") {
      var_3 = _id_62F0(var_2, var_0);

      if(isDefined(var_3)) {
        var_4 = level._id_2682[var_3._id_76D3];

        if(isDefined(var_3._id_2685) && isDefined(var_3._id_2685[var_3._id_76D2])) {
          var_3._id_2685[var_3._id_76D2][var_4] = var_3._id_76D4;

          if(var_3._id_76D2 == var_3._id_08D2) {
            if(level._id_A1FE) {
              _id_05E0(var_3.player getentitynumber(), var_3._id_20F1, "costume", var_3._id_2685[var_3._id_76D2][0], var_3._id_2685[var_3._id_76D2][1], var_3._id_2685[var_3._id_76D2][2], var_3._id_2685[var_3._id_76D2][3], var_3._id_2685[var_3._id_76D2][4], var_3._id_2685[var_3._id_76D2][5]);
            } else {
              var_3 _meth_84C7(var_3._id_2685[var_3._id_76D2]);
            }
          }
        }
      }

      continue;
    }

    if(var_1 == "hub_findgame") {
      var_3 = level._id_A595[var_0];

      if(isDefined(var_3)) {
        if(var_2 == 1) {
          _id_4CCD(var_3);
        } else {
          _id_8BBB(var_3);
        }
      }
    }
  }
}

_id_2318(var_0) {
  setDvar("3784", 0);

  if(isDefined(level._id_A1DB)) {
    var_1 = strtok(var_0, "#");

    foreach(var_3 in var_1) {
      var_4 = strtok(var_3, "|");

      if(var_4.size > 0) {
        var_5 = int(var_4[0]);
        var_6 = level.players[0]._id_2316[var_5];

        if(isDefined(var_6)) {
          var_6._id_08D2 = 0;
          var_6._id_582A = int(var_4[1]) > 0;

          for(var_7 = 2; var_7 < var_4.size; var_7++) {
            var_8 = strtok(var_4[var_7], ",");
            var_9 = [];

            for(var_10 = 1; var_10 < var_8.size; var_10++) {
              var_9[var_9.size] = int(var_8[var_10]);
            }

            if(!isDefined(var_6._id_2685)) {
              var_6._id_2685 = [];
            }

            var_6._id_2685[int(var_8[0])] = var_9;
            _id_A586(var_6, var_9, 1);

            if(var_6._id_582A) {
              _id_A669(var_6);
              continue;
            }

            _id_4CCD(var_6);
          }
        }
      }
    }
  }

  setDvar("3784", 1);
}

_id_62F4() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "clanprofile") {
      maps\mp\hub_vl_base::_id_A59E("Using clan profile VL settings\n");

      if(var_1 < 0) {
        self._id_A589 = undefined;
      } else {
        self._id_A589 = var_1;
      }

      continue;
    }

    if(var_0 == "clan_highlight_data") {
      maps\mp\hub_vl_base::_id_A59E("Handling clan highlight information\n");
      _id_2318(var_1);
    }
  }
}

_id_4CCD(var_0) {
  for(var_1 = 0; var_1 < 48; var_1++) {
    var_2 = level.players[var_1];

    if(!isDefined(var_2)) {
      continue;
    }
    _id_05E0(var_2 getentitynumber(), var_0._id_20F1, "show", 0);
  }

  if(!level._id_A1FE) {
    var_0 hide();
  }

  _id_4CD1(var_0);
}

_id_8BBB(var_0) {
  for(var_1 = 0; var_1 < 48; var_1++) {
    if(var_0._id_A561[var_1]) {
      var_2 = level.players[var_1];

      if(!isDefined(var_2)) {
        var_0._id_A561[var_1] = 0;
        continue;
      }

      if(level._id_A1FE) {
        _id_05E0(var_2 getentitynumber(), var_0._id_20F1, "show", 1);
      } else {
        var_0 showtoplayer(var_2);

        if(isDefined(var_0._id_7705)) {
          var_0._id_7705 showtoplayer(var_2);
        }

        if(isDefined(var_0.botsetattacker)) {
          var_0.botsetattacker showtoplayer(var_2);
        }
      }

      if(isDefined(var_0.primaryweapon) && issubstr(var_0.primaryweapon, "akimbo")) {
        _id_A58A(var_2, var_0);
      }
    }
  }
}

_id_4CCF(var_0) {
  if(isDefined(var_0._id_7705)) {
    var_0 notify("hide_primary_weapon");

    if(!level._id_A1FE) {
      var_0._id_7705 hide();
      var_0._id_7705 hideallparts();
    }
  }
}

_id_4CD0(var_0) {
  if(isDefined(var_0.botsetattacker)) {
    var_0 notify("hide_secondary_weapon");

    if(!level._id_A1FE) {
      var_0.botsetattacker hide();
      var_0.botsetattacker hideallparts();
    }
  }
}

_id_4CCE(var_0) {
  if(isDefined(var_0._id_0BA9)) {
    var_0 notify("hide_akimbo_weapon");

    if(!level._id_A1FE) {
      var_0._id_0BA9 hide();
      var_0._id_0BA9 hideallparts();
    }
  }
}

_id_4CD1(var_0) {
  _id_4CCF(var_0);
  _id_4CD0(var_0);
  _id_4CCE(var_0);
}

_id_4CD2() {
  foreach(var_1 in level._id_A595) {
    _id_4CCD(var_1);
  }
}

_id_8BBC() {
  foreach(var_1 in level._id_A595) {
    _id_8BBB(var_1);
  }
}

_id_43EA(var_0) {
  foreach(var_3, var_2 in level._id_AAE2) {
    if(isDefined(level._id_A595[var_2]) && level._id_A595[var_2] == var_0) {
      return var_3;
    }
  }

  return "";
}

_id_7C75(var_0) {
  var_1 = -1;

  foreach(var_3, var_1 in level._id_AAE2) {
    if(var_1 == var_0) {
      break;
    }
  }

  maps\mp\hub_vl_base::_id_A59E("Removing xuid " + var_3 + " for ownerId " + var_0 + "\n");
  _setentplayerxuidforemblem(level._id_A595[var_0], var_3, 1);
  level._id_AAE2[var_3] = undefined;
  level._id_13B8[var_0]._id_9A1A = 0;
  level._id_13B8[var_0]._id_13B3 = undefined;
  setDvar("1999", level._id_AAE2.size);
  var_4 = level._id_A595[var_0];
  level._id_A595[var_0] = undefined;
  _id_4CCD(var_4);
  var_4 hideallparts();

  if(isDefined(var_4._id_13B6._id_9042)) {
    var_4._id_13B6._id_9042 = undefined;
  }

  if(isDefined(var_4._id_7705)) {
    if(!level._id_A1FE) {
      _setentplayerxuidforemblem(var_4._id_7705, var_3, 1);
      var_4._id_7705 delete();
    }

    var_4._id_7705 = undefined;
  }

  if(isDefined(var_4.botsetattacker)) {
    if(!level._id_A1FE) {
      _setentplayerxuidforemblem(var_4.botsetattacker, var_3, 1);
      var_4.botsetattacker delete();
    }

    var_4.botsetattacker = undefined;
  }

  if(isDefined(var_4._id_0BA9)) {
    _id_A593(var_3, var_4);
  }

  var_4.primaryweapon = undefined;
  var_4._id_9428 = undefined;
  maps\mp\hub_vl_base::_id_3E76(var_4);

  foreach(var_6 in level.players) {
    if(var_6._id_A58C == var_0) {
      var_6._id_A58C = 0;
    }
  }
}

_id_8774() {
  level._id_0EE9 = [];
  var_0 = [];
  var_0["cao_01"] = "pb_cao_pose_01";
  var_0[0] = var_0["cao_01"];
  var_0["selfie_01"] = "pb_selfie_pose_01";
  var_0[1] = var_0["selfie_01"];
  var_0["operator_a"] = "pb_lobby_operator_pose_a";
  var_0[7] = var_0["operator_a"];
  var_0["operator_b"] = "pb_lobby_operator_pose_b";
  var_0[8] = var_0["operator_b"];
  var_0["operator_c"] = "pb_lobby_operator_pose_c";
  var_0[9] = var_0["operator_c"];
  var_0["operator_d"] = "pb_lobby_operator_pose_d";
  var_0[10] = var_0["operator_d"];
  var_0["operator_e"] = "pb_lobby_operator_pose_e";
  var_0[11] = var_0["operator_e"];
  var_0["assault_checkgun"] = "pb_lobby_assault_checkgun";
  var_0[12] = var_0["assault_checkgun"];
  var_0["assault_face"] = "pb_lobby_assault_face";
  var_0[13] = var_0["assault_face"];
  var_0["assault_gear"] = "pb_lobby_assault_gear";
  var_0[14] = var_0["assault_gear"];
  var_0["assault_gloves"] = "pb_lobby_assault_gloves";
  var_0[15] = var_0["assault_gloves"];
  var_0["assault_idle"] = "pb_lobby_assault_idle";
  var_0[16] = var_0["assault_idle"];
  var_0["assault_shoes"] = "pb_lobby_assault_shoes";
  var_0[17] = var_0["assault_shoes"];
  level._id_0EE9["lobby_idle"] = var_0;

  for(var_1 = 0; var_1 < 18; var_1++) {
    _precachempanim(var_0[var_1]);
  }
}

_id_A1D5(var_0, var_1, var_2) {
  var_3 = _randomfloatrange(0.85, 1.15);
  var_4 = 0;

  if(!isDefined(self._id_0E93)) {
    var_4 = 1;
    self.angles = self._id_8F80;
  }

  if(!isDefined(var_2)) {
    var_2 = "lobby_idle";
    var_0 = "assault_pose_06";
  }

  self._id_0E93 = var_0;
  self._id_0EE8 = var_2;
  var_5 = level._id_0EE9[var_2][var_0];
  self._id_0EEC = var_5;

  if(isDefined(self.player)) {
    _id_05E0(self.player getentitynumber(), self._id_20F1, "anim", var_5);
  }

  if(!level._id_A1FE) {
    self scriptmodelplayanim(var_5);
  }

  if(!isDefined(var_1) || !var_1) {
    self._id_0E93 = var_0;

    if(var_4) {
      _id_A58D(self);
    }
  }
}

_id_918A(var_0) {
  if(isDefined(var_0._id_1EFF) && isDefined(var_0._id_1EFF._id_627E)) {
    switch (var_0._id_1EFF._id_627E) {
      case "prelobby_loot":
      case "prelobby":
        var_1 = 0;

        if(isDefined(level._id_A595)) {
          foreach(var_3 in level._id_A595) {
            if(!isDefined(var_3._id_0E93)) {
              var_4 = var_3._id_13B6 _id_3B96();

              if(isDefined(self._id_6DAC) && self._id_6DAC == 0) {
                var_1 = 8;
              } else if(var_4 < level._id_6871) {
                var_1 = var_4;
              } else {
                var_1++;

                if(var_1 >= level._id_6871) {
                  var_1 = 0;
                }
              }

              var_5 = "lobby_idle";
              _id_A1D5(var_1, undefined, var_5);
            }
          }
        }

        break;
      case "transition":
      case "game_lobby":
      case "cac":
        var_1 = 0;

        if(isDefined(level._id_A595)) {
          foreach(var_3 in level._id_A595) {
            if(!isDefined(var_3._id_0E93)) {
              var_4 = var_3._id_13B6 _id_3B96();

              if(isDefined(self._id_6DAC) && self._id_6DAC == 0) {
                var_1 = 8;
              } else if(var_4 < level._id_6871) {
                var_1 = var_4;
              } else {
                var_1++;

                if(var_1 >= level._id_6871) {
                  var_1 = 0;
                }
              }

              var_5 = "lobby_idle";
              _id_A1D5(var_1, undefined, var_5);
            }
          }
        }

        break;
      case "clanprofile":
      case "cao":
        if(!isDefined(self._id_0E93)) {
          if(isDefined(self._id_6DAC) && self._id_6DAC == 0) {
            var_1 = 8;
          } else {
            var_1 = _randomintrange(0, level._id_6871 - 1);
          }

          var_5 = "lobby_idle";
          _id_A1D5(var_1, undefined, var_5);
        }

        break;
      default:
        if(!isDefined(self._id_0E93)) {
          if(isDefined(self._id_6DAC) && self._id_6DAC == 0) {
            var_1 = 8;
          } else {
            var_1 = _randomintrange(0, level._id_6871 - 1);
          }

          var_5 = "lobby_idle";
          _id_A1D5(var_1, undefined, var_5);
        }

        break;
    }
  }
}

_id_9271() {
  if(!isDefined(level._id_A595)) {
    return;
  }
  foreach(var_1 in level._id_A595) {
    if(!isDefined(var_1._id_0E93) || !isDefined(var_1._id_0EE8)) {
      var_2 = var_1 _id_441B(var_1.primaryweapon);
      var_1 _id_A1D5(var_2._id_0BB4, undefined, var_2._id_0EE8);
    }
  }
}

_id_9243() {
  if(!isDefined(level._id_A595)) {
    return;
  }
  foreach(var_1 in level._id_A595) {
    if(!isDefined(var_1._id_0E93) || !isDefined(var_1._id_0EE8)) {
      var_2 = var_1 _id_441B(var_1.primaryweapon);
      var_1 _id_A1D5(var_2._id_0BB4, undefined, var_2._id_0EE8);
    }
  }
}

_id_91B5() {
  if(!isDefined(level._id_A595)) {
    return;
  }
  foreach(var_1 in level._id_A595) {
    if(!isDefined(var_1._id_0E93) || !isDefined(var_1._id_0EE8)) {
      var_2 = var_1 _id_441B(var_1.primaryweapon);
      var_1 _id_A1D5(var_2._id_0BB4, undefined, var_2._id_0EE8);
    }
  }
}

_id_3B65(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  var_3[1] = var_1;
  var_4 = 20;

  for(var_5 = 1; var_5 && var_4 > 0; var_3 = var_6) {
    var_4--;
    var_5 = 0;
    var_6 = [];
    var_6[var_6.size] = var_3[0];
    var_7 = 0;
    var_8 = 0;

    for(var_9 = 0; var_9 < var_3.size - 1 && !var_7; var_9++) {
      var_10 = 1;
      var_11 = var_3[var_9];
      var_12 = var_3[var_9 + 1];

      while(var_10) {
        var_10 = 0;
        var_13 = undefined;
        var_14 = undefined;

        foreach(var_16 in var_2) {
          var_17 = _id_9B85(var_11, var_12, var_16);

          if(var_17["intersect"]) {
            if(_distance2d(var_6[var_6.size - 1], var_17["closestpoint"]) > 0.1 && _distance2d(var_12, var_17["closestpoint"]) > 0.1) {
              var_10 = 1;

              if(!isDefined(var_14) || var_14["radratio"] > var_17["radratio"]) {
                var_13 = var_16;
                var_14 = var_17;
              }
            }
          }
        }

        if(var_10) {
          var_5 = 1;

          if(_length2d(var_11, var_13["center"]) < var_13["radius"]) {
            var_11 = _id_6485(var_11, var_13);
            var_6[var_6.size - 1] = var_11;
            var_10 = 0;
            var_7 = 1;
            var_8 = var_9 + 1;
          } else if(_length2d(var_12, var_13["center"]) < var_13["radius"]) {
            var_12 = _id_6485(var_12, var_13);
            var_6[var_6.size] = var_12;
            var_10 = 0;
            var_7 = 1;
            var_8 = var_9 + 2;
          } else {
            var_6[var_6.size] = var_14["closestpoint"];
            var_6[var_6.size] = var_12;
            var_10 = 0;
          }

          continue;
        }

        var_6[var_6.size] = var_12;
      }
    }

    if(var_7) {
      for(var_9 = var_8; var_9 < var_3.size; var_9++) {
        var_6[var_6.size] = var_3[var_9];
      }
    }
  }

  return var_3;
}

_id_6485(var_0, var_1) {
  var_2 = var_1["center"];
  var_3 = var_1["radius"];
  var_4 = vectorNormalize((var_0[0] - var_2[0], var_0[1] - var_2[1], 0));
  var_0 = (var_2[0] + var_3 * var_4[0], var_2[1] + var_3 * var_4[1], var_0[2]);
  return var_0;
}

_id_9B85(var_0, var_1, var_2) {
  var_3 = 5;
  var_4 = var_2["center"];
  var_5 = var_2["radius"];
  var_6 = var_5 + var_3;
  var_7 = (var_1[0] - var_0[0], var_1[1] - var_0[1], 0);
  var_8 = vectorNormalize(var_7);
  var_9 = _length2d(var_7);
  var_10 = (var_4[0] - var_0[0], var_4[1] - var_0[1], 0);
  var_11 = vectordot(var_8, var_10);

  if(var_11 < 0) {
    var_11 = 0.0;
  } else if(var_11 > var_9) {
    var_11 = var_9;
  }

  var_12 = (var_0[0] + var_11 * var_8[0], var_0[1] + var_11 * var_8[1], 0);
  var_13 = var_11 / var_9;
  var_14 = (var_12[0] - var_4[0], var_12[1] - var_4[1], 0);
  var_9 = _length2d(var_14);
  var_15 = 0;
  var_16 = 1.0;

  if(var_9 < var_5) {
    var_15 = 1;
    var_14 = vectorNormalize(var_14);
    var_12 = (var_4[0] + var_6 * var_14[0], var_4[1] + var_6 * var_14[1], var_0[2] + var_13 * (var_1[2] - var_0[2]));
    var_16 = var_9 / var_5;
  }

  var_17 = [];
  var_17["intersect"] = var_15;
  var_17["fraction"] = var_13;
  var_17["closestpoint"] = var_12;
  var_17["radratio"] = var_16;
  return var_17;
}

_id_1E3D(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_2);

  if(var_3 > var_1) {
    var_4 = vectorNormalize(var_2 - var_0);
    var_2 = var_0 + var_1 * var_4;
  }

  return var_2;
}

_id_5EBB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4[var_0];

  if(var_0 + 1 >= var_4.size) {
    return [var_0, _id_1E3D(var_1, var_2, var_4[var_0])];
  }

  var_6 = var_4[var_0 + 1];
  var_7 = distance(var_5, var_6);
  var_8 = vectorNormalize(var_6 - var_5);
  var_9 = vectordot(var_8, var_1 - var_5);

  if(var_9 < 0) {
    var_9 = 0;
  }

  if(var_9 > var_7) {
    var_9 = var_7;
  }

  var_10 = var_5 + var_9 * var_8;
  var_11 = var_3;
  var_12 = var_7 - var_9;
  var_13 = var_4[var_4.size - 1];

  while(var_11 > 0) {
    if(var_12 > var_11) {
      var_13 = var_10 + var_11 * var_8;
      var_11 = 0;
      continue;
    }

    if(var_0 + 1 >= var_4.size) {
      var_13 = var_4[var_0];
      var_11 = 0;
    }

    var_11 = var_11 - var_12;
    var_0++;
    var_10 = var_4[var_0];
  }

  return [var_0, _id_1E3D(var_1, var_2, var_13)];
}

_id_5233(var_0) {
  var_0._id_3033 = 0;
  var_0._id_6EDD = 0;
  var_0._id_3041 = 0;
  var_0._id_6EF2 = 0;
  var_1 = var_0._id_6EE3 / var_0._id_6EC7;

  if(var_1 < var_0._id_6ECA) {
    var_1 = var_0._id_6ECA;
  }

  if(var_1 > var_0._id_6EC8) {
    var_1 = var_0._id_6EC8;
  }

  var_0._id_6ED5 = 0.05 * var_1 / var_0._id_6EB8;
  var_0._id_6ED8 = 0.05 * var_1 / var_0._id_6EBD;
  var_0._id_6EF4 = var_1;
  var_0._id_6ED6 = 1;
  var_0._id_6EE9 = 0;
  var_0._id_6EEA = var_0._id_6EC7;
  var_2 = var_0._id_6EBD / 0.05;
  var_3 = 0;
  var_4 = var_1;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_4 = var_4 - var_0._id_6ED8;

    if(var_4 < var_0._id_6EC9) {
      var_4 = var_0._id_6EC9;
    }

    var_3 = var_3 + var_4;
  }

  var_0._id_6EF3 = var_0._id_6EE3 - var_3;
  var_0._id_6FF7 = var_0._id_6EE7;
}

_id_A0BD(var_0) {
  if(var_0._id_3033 < var_0._id_6EF3) {
    var_0._id_6EF2 = var_0._id_6EF2 + var_0._id_6ED5;

    if(var_0._id_6EF2 > var_0._id_6EF4) {
      var_0._id_6EF2 = var_0._id_6EF4;
    }
  } else {
    var_0._id_6EF2 = var_0._id_6EF2 - var_0._id_6ED8;

    if(var_0._id_6EF2 < var_0._id_6EC9) {
      var_0._id_6EF2 = var_0._id_6EC9;
    }
  }
}

_id_5232(var_0) {
  var_0._id_6EC8 = 15.0;
  var_0._id_6ECA = 1.8;
  var_0._id_6EC9 = 0.3;
  var_0._id_6EC7 = 0.5;
  var_0._id_6EB8 = 0.15 * var_0._id_6EC7;
  var_0._id_6EBD = 0.15 * var_0._id_6EC7;
  var_0._id_6EED = 4.5;
  var_0._id_6EEC = 4.5;
}

_id_1D1A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_3B65(var_0.origin, var_3, var_0._id_699B);
  var_0._id_6EB7 = var_5;
  var_6 = 0;

  foreach(var_9, var_8 in var_0._id_6EB7) {
    if(var_9 > 0) {
      var_6 = var_6 + distance(var_0._id_6EB7[var_9], var_0._id_6EB7[var_9 - 1]);
    }
  }

  var_0._id_6EE9 = 0;
  var_0._id_6EEA = var_0._id_6EC7;
  var_0._id_6EE3 = var_6;
  var_0._id_6EE6 = anglesToForward(var_0.angles);
  var_0._id_6EE0 = anglesToForward(var_4);
  var_0._id_6EE7 = _angleclamp180(var_0.angles[0]);
  var_0._id_6EDE = var_0._id_6EE7;
  var_0._id_6EE1 = _angleclamp180(var_4[0]);
  var_0._id_6EE8 = _angleclamp180(var_0.angles[1]);
  var_0._id_6EE2 = _angleclamp180(var_4[1]);
  var_0._id_6EE5 = var_2;
  var_0._id_6EDF = var_3;
  var_0._id_6EEB = (0, 0, 0);
  var_10 = vectorNormalize(var_0._id_6EDF - var_0._id_6EE5);
  var_11 = vectordot(var_10, var_0._id_6EE6);
  var_12 = vectordot(var_10, var_0._id_6EE0);
  var_13 = 0;

  if(var_12 < -0.707 && var_11 < -0.707) {
    var_13 = 1;
  }

  var_0._id_6EE4 = var_13;
  _id_5233(var_0);
}

_id_3B93(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = var_2 - var_1;
  var_5 = vectordot(var_4, var_3);
  var_6 = var_1 + var_3 * var_5;
  return var_6;
}

_id_8C4E(var_0, var_1) {
  var_2 = -0.5;
  var_0 = var_0 + var_2;
  var_0 = var_0 * (2 * var_1);
  var_3 = _sqrt(1 + var_1 * var_1) / (2 * var_1);
  var_4 = 0.5;
  var_5 = var_3 * (var_0 / _sqrt(1 + var_0 * var_0)) + var_4;
  return var_5;
}

_id_5CA0(var_0, var_1) {
  var_2 = _angleclamp180(var_1[0]);
  var_3 = _angleclamp180(var_0.angles[0]);
  var_4 = _angleclamp180(var_1[1] - var_0.angles[1]);
  var_5 = _angleclamp180(var_2 - var_3);

  if(var_4 < -1 * var_0._id_6EED) {
    var_4 = -1 * var_0._id_6EED;
  }

  if(var_4 > var_0._id_6EED) {
    var_4 = var_0._id_6EED;
  }

  if(var_5 < -1 * var_0._id_6EEC) {
    var_5 = -1 * var_0._id_6EEC;
  }

  if(var_5 > var_0._id_6EEC) {
    var_5 = var_0._id_6EEC;
  }

  var_6 = (var_5, var_4, 0);
  var_0.angles = var_0.angles + var_6;

  if(_abs(var_5) < 0.1 && _abs(var_4) < 0.1) {
    return 1;
  } else {
    return 0;
  }
}

_id_A09B(var_0, var_1) {
  var_2 = var_0._id_6EE9 / var_0._id_6EEA;
  var_2 = _id_8C4E(var_2, 2);
  var_3 = var_0.angles;
  var_4 = var_2 * (var_0._id_6EE1 - var_0._id_6EE7) + var_0._id_6EE7;
  var_5 = var_0._id_6EE8 + var_2 * (var_0._id_6EE2 - var_0._id_6EE8);
  var_6 = var_0.angles[1] + _angleclamp180(var_5 - var_0.angles[1]);
  var_3 = (var_4, var_6, var_3[2]);
  return _id_5CA0(var_0, var_3);
}

_id_A09E(var_0) {
  var_1 = var_0._id_6EE9 / var_0._id_6EEA;
  var_1 = _id_8C4E(var_1, 2);
  var_2 = var_1 * var_0._id_6EE3;
  var_0._id_6EDD = 0;
  var_0._id_3041 = 0;
  var_0._id_3033 = 0;

  while(var_2 > 0) {
    var_3 = distance(var_0._id_6EB7[var_0._id_6EDD], var_0._id_6EB7[var_0._id_6EDD + 1]);
    var_4 = var_3 - var_0._id_3041;

    if(var_4 > var_2) {
      var_0._id_3041 = var_0._id_3041 + var_2;
      var_5 = var_0._id_6EB7[var_0._id_6EDD] + var_0._id_3041 * vectorNormalize(var_0._id_6EB7[var_0._id_6EDD + 1] - var_0._id_6EB7[var_0._id_6EDD]);
      var_0._id_6EEB = var_5 - var_0.origin;
      var_0.origin = var_5;
      var_0._id_3033 = var_0._id_3033 + var_2;
      var_2 = 0;
      continue;
    }

    var_2 = var_2 - var_4;
    var_0._id_6EDD++;

    if(var_0._id_6EDD >= var_0._id_6EB7.size - 1) {
      if(var_0._id_6EDD < var_0._id_6EB7.size) {
        var_5 = var_0._id_6EB7[var_0._id_6EDD];
      } else {
        var_5 = var_0._id_6EB7[var_0._id_6EB7.size - 1];
      }

      var_0._id_6EEB = var_5 - var_0.origin;
      var_0.origin = var_5;
      var_0._id_3033 = var_0._id_6EE3;
      var_2 = 0;
      continue;
    }

    var_0._id_3033 = var_0._id_3033 + var_4;
    var_0._id_3041 = 0;
  }
}

_id_A09C(var_0, var_1) {
  var_2 = 0;
  var_0._id_6EE9 = var_0._id_6EE9 + 0.05;

  if(var_0._id_6EE9 >= var_0._id_6EEA) {
    var_0._id_6EE9 = var_0._id_6EEA;
    var_2 = 1;
    var_0._id_6EEB = (0, 0, 0);
  }

  _id_A09E(var_0);
  _id_A09B(var_0, var_1);
  return var_2;
}

_id_4377(var_0) {
  var_1 = "j_neck";
  var_2 = var_0 gettagorigin(var_1);
  return var_2;
}

_id_1E3A(var_0) {
  var_1 = _id_7EED(var_0);
  var_2 = var_1._id_1EAF;
  var_3 = var_1._id_1EAE;
  var_4 = _id_4377(var_0);
  var_5 = var_2;
  var_6 = var_2 + anglesToForward(var_3) * 64;
  return _id_1E39(var_5, var_6, var_4);
}

_id_1E3B(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0._id_1E9D.origin;
  var_3 = var_0._id_1E9F.origin;
  return _id_1E39(var_2, var_3, var_1);
}

_id_1E39(var_0, var_1, var_2) {
  var_3 = var_1;
  var_4 = var_0;
  var_5 = var_2;
  var_6 = [];
  var_7 = vectorNormalize(_vectorcross(var_3 - var_4, (0, 0, 1)));
  var_8 = vectorNormalize(_vectorcross(var_7, var_3 - var_4));
  var_9 = var_5 - var_4;
  var_10 = var_5 - vectordot(var_8, var_9) * var_8;
  var_11 = var_5 - vectordot(var_7, var_9) * var_7;
  var_12 = distance(var_10, var_3);
  var_13 = distance(var_10, var_4);
  var_14 = var_12 / var_13;
  var_15 = 1;

  if(vectordot(var_9, var_7) < 0) {
    var_15 = -1;
  }

  var_6["fx"] = var_14;
  var_6["sx"] = var_15;
  var_16 = distance(var_11, var_3);
  var_17 = distance(var_11, var_4);
  var_18 = var_16 / var_17;
  var_19 = 1;

  if(vectordot(var_9, var_8) < 0) {
    var_19 = -1;
  }

  var_6["fz"] = var_18;
  var_6["sz"] = var_19;
  return var_6;
}

_id_1E3C(var_0, var_1) {
  var_2 = getdvarfloat("cg_fov", 45) * getdvarfloat("3078", 1.0);
  var_3 = 1.0;
  var_4 = _tan(var_2);
  var_5 = [];
  var_6 = var_4 * _abs(var_0);
  var_7 = 1;

  if(var_0 < 0) {
    var_7 = -1;
  }

  var_8 = var_6 / _sqrt(1 - var_6 * var_6);
  var_5["sx"] = var_7;
  var_5["fx"] = var_8;
  var_9 = var_3 * var_4 * _abs(var_1);
  var_10 = 1;

  if(var_1 < 0) {
    var_10 = -1;
  }

  var_11 = var_9 / _sqrt(1 - var_9 * var_9);
  var_5["sz"] = var_10;
  var_5["fz"] = var_11;
  return var_5;
}

_id_1E37(var_0, var_1, var_2) {
  var_3 = var_1;
  var_4 = var_2;
  var_5 = var_4 - var_3;
  var_6 = vectorNormalize(_vectorcross(var_5, (0, 0, 1)));
  var_7 = vectorNormalize(_vectorcross(var_6, var_5));
  var_8 = var_5 - vectordot(var_5, var_7) * var_7;
  var_9 = length(var_8);
  var_10 = var_0["fx"];
  var_11 = var_0["sx"];
  var_12 = var_9 * var_10;
  var_9 = var_9 * var_10 * var_10;
  var_13 = var_9 * var_10 * _sqrt(1 - var_10 * var_10);
  var_14 = var_9 * var_8 + var_13 * var_6;
  var_15 = var_5 - vectordot(var_5, var_6) * var_6;
  var_16 = length(var_15);
  var_17 = var_0["fz"];
  var_18 = var_0["sz"];
  var_19 = var_16 * var_17;
  var_16 = var_16 * var_17 * var_17;
  var_20 = var_16 * var_17 * _sqrt(1 - var_17 * var_17);
  var_21 = var_16 * var_15 + var_20 * var_7;
  var_22 = var_4 + var_11 * var_14 + var_18 * var_21;
  return var_22;
}

_id_2AD9(var_0) {
  var_1 = (1, 1, 1);
  var_2 = var_0[0];
  var_3 = var_2;
  var_4 = 0;
  var_5 = 10;
  var_6 = 30;

  if(level._id_A1E9) {
    for(;;) {
      var_7 = _id_5EBB(var_4, var_2, var_5, var_6, var_0);
      var_4 = var_7[0];
      var_3 = var_7[1];

      if(distance(var_2, var_3) < 0.1) {
        break;
      }

      var_2 = var_3;

      if(var_4 >= var_0.size) {
        break;
      }
    }
  } else {
    for(var_8 = 0; var_8 < var_0.size - 1; var_8++) {}
  }
}

_id_2AD7(var_0) {
  var_1 = (1, 0.5, 0);

  foreach(var_3 in var_0) {
    var_4 = var_3["center"];
    var_5 = var_3["radius"];
  }
}

_id_2AD1(var_0) {
  var_1 = 1;
  var_2 = var_1;
  var_3 = 36;
  _id_5233(var_0);
  var_0._id_9809 = _id_4377(var_0._id_9822);

  while(!_id_A09C(var_0)) {
    var_4 = var_0._id_9809;
    var_5 = _id_1E37(var_0._id_3E6A, var_0.origin, var_4);
    var_2--;

    if(var_2 <= 0) {
      var_2 = var_1;
    }
  }

  var_0.angles = (_angleclamp180(var_0.angles[0]), _angleclamp180(var_0.angles[1]), _angleclamp180(var_0.angles[2]));
  var_0 dontinterpolate();
}

_id_9911(var_0, var_1, var_2, var_3) {
  level notify("stop_test_pathing");
  level endon("stop_test_pathing");
  var_4 = common_scripts\utility::_id_46B7("player_pos", "targetname");
  var_5 = var_2._id_9042;
  var_6 = _id_7EED(var_5);
  var_7 = var_6._id_1EAF;
  var_8 = var_6._id_1EAE;
  var_9 = var_7;
  var_10 = var_8;
  var_11 = var_0.origin;
  var_12 = var_11 + anglesToForward(var_0.angles) * 64;
  var_13 = var_9 + anglesToForward(var_10) * 64;
  var_0.origin = var_11;
  var_0.angles = var_10;
  var_0._id_699B = var_3;
  _id_5232(var_0);
  _id_1D1A(var_0, undefined, var_0.origin, var_9, var_10);
  var_0._id_3E6A = _id_1E3A(var_5);
  var_0._id_9822 = var_5;

  for(;;) {
    var_0.origin = var_11;
    var_0.angles = var_10;
    _id_2AD9(var_0._id_6EB7);
    _id_2AD7(var_0._id_699B);
    _id_2AD1(var_0);
    waitframe();
  }
}

_id_2AFB() {
  var_0 = 0;
  var_1 = common_scripts\utility::_id_46B7("player_pos", "targetname");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::_id_46B5(var_3.target, "targetname");

    if(var_4._id_0165 == "camera_target") {
      var_3._id_1E9F = var_4;
    }

    var_5 = common_scripts\utility::_id_46B5(var_4.target, "targetname");

    if(var_5._id_0165 == "camera") {
      var_3._id_1E9D = var_5;
      var_5._id_1E9C = var_3;
      var_5._id_1E9F = var_3._id_1E9F;
    }
  }

  var_7 = spawn("script_model", (0, 0, 0));
  var_7 setModel("tag_player");
  var_7.targetname = "fakecamera";
  level._id_A1E9 = 0;
  var_8 = 0;
  var_9 = 1;
  var_10 = "111111111111111111";
  var_11 = 16;

  for(;;) {
    if(self fragButtonPressed()) {
      while(self fragButtonPressed()) {
        waitframe();
      }

      var_9++;

      if(var_9 >= 48) {
        var_9 = 0;
      }

      if(var_9 == var_8) {
        var_9++;

        if(var_9 >= 48) {
          var_9 = 0;
        }
      }

      var_0 = 1;
    }

    if(self secondaryoffhandbuttonPressed()) {
      while(self secondaryoffhandbuttonPressed()) {
        waitframe();
      }

      var_8++;

      if(var_8 >= 48) {
        var_8 = 0;
      }

      if(var_9 == var_8) {
        var_8++;

        if(var_8 >= 48) {
          var_8 = 0;
        }
      }

      var_0 = 1;
    }

    if(var_0) {
      var_0 = 0;
      var_12 = [];
      var_13 = undefined;
      var_14 = undefined;

      foreach(var_18, var_16 in var_1) {
        if(getsubstr(var_10, var_18, var_18 + 1) == "0") {
          continue;
        }
        var_17 = [];
        var_17["center"] = var_16.origin;
        var_17["radius"] = var_11;
        var_12[var_12.size] = var_17;

        if(var_16._id_0165 == "" + var_8) {
          var_13 = var_16;
        }

        if(var_16._id_0165 == "" + var_9) {
          var_14 = var_16;
        }
      }

      thread _id_9911(var_7, var_13, var_14, var_12);
    }

    wait 0.2;
  }
}

_id_2AE5(var_0) {
  level._id_2AE5 = 1;
  var_1 = 30;
  var_2 = 10;
  var_3 = 10;
  var_4 = self getunnormalizedcameramovement();
  var_5 = self getnormalizedmovement();
  var_6 = anglesToForward(var_4);
  var_7 = anglestoup(var_4);
  var_8 = anglestoright(var_4);
  var_9 = 0;

  if(self adsButtonPressed()) {
    var_9 = -1;
  } else if(self attackButtonPressed()) {
    var_9 = 1;
  }

  if(self secondaryoffhandbuttonPressed()) {
    var_1 = var_1 * 0.1;
    var_2 = var_2 * 0.1;
    var_3 = var_3 * 0.1;
  }

  var_0.angles = var_4;
  var_0.origin = var_0.origin + var_5[0] * var_1 * var_6 + var_5[1] * var_2 * var_8 + var_9 * var_3 * var_7;
}

_id_A59D(var_0, var_1) {
  if(!isDefined(self._id_A4B5)) {
    self._id_A4B5 = _newclienthudelem(self);
    self._id_A4B5.x = 0;
    self._id_A4B5.y = 0;
    self._id_A4B5 setshader(var_1, 640, 480);
    self._id_A4B5.alignx = "left";
    self._id_A4B5.aligny = "top";
    self._id_A4B5._id_00C6 = "fullscreen";
    self._id_A4B5._id_01CA = "fullscreen";
    self._id_A4B5.alpha = var_0;
  }

  if(isDefined(self._id_A4B5) && self._id_A4B5.alpha > 0 && var_0 == 0) {
    self._id_A4B5 setshader(var_1, 640, 480);
    self._id_A4B5.alpha = 0;
  }

  if(isDefined(self._id_A4B5) && self._id_A4B5.alpha < 1 && var_0 == 1) {
    self._id_A4B5 setshader(var_1, 640, 480);
    self._id_A4B5.alpha = 1;
  }
}

_id_4696(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(level.players[var_1] == self) {
        var_0 = var_1;
        break;
      }
    }
  }

  var_2 = common_scripts\utility::_id_46B7("player_pos", "targetname");
  var_3 = undefined;

  foreach(var_3 in var_2) {
    if(var_3._id_0165 == "" + var_0) {
      break;
    }
  }

  if(!isDefined(var_3)) {
    var_3 = var_2[0];
  }

  self._id_13B6 = var_3;
  return var_3;
}

_id_2785() {
  var_0 = self;

  if(isDefined(var_0._id_1F8E)) {
    return;
  }
  var_1 = var_0 getxuid();
  var_0._id_1F8E = var_0 _id_8F7D(var_0._id_1FA3, var_0._id_0079, var_0._id_1F9D, var_0.botclearscriptenemy, "none", var_0._id_5DF4, var_0._id_5DF7, var_0._id_6F65, var_0.setnameplatematerial, var_0.name, 0, 1);

  if(!level._id_A1FE) {
    _setentplayerxuidforemblem(var_0._id_1F8E, var_1);
  }

  var_0 maps\mp\hub_vl_base::_id_7699(var_0._id_1F8E, var_0._id_1F8E._id_8F80);
}

_id_2D00() {
  var_0 = self;

  if(!isDefined(var_0._id_1F8E)) {
    return;
  }
  maps\mp\hub_vl_base::_id_3E76(var_0._id_1F8E);
  var_0._id_1F8E = undefined;
}