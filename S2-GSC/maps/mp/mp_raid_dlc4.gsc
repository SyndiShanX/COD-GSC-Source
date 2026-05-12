/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc4.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_raid_dlc4_precache::func_F9();
  maps\createart\mp_raid_dlc4_art::func_F9();
  maps\mp\mp_raid_dlc4_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_dlc4_lighting::func_F9();
  maps\mp\mp_raid_dlc4_aud::func_F9();
  maps\mp\_audio_submixes::func_524C();
  setnorthyaw(90);
  level.var_1BB7 = ::func_1BB7;
  level thread func_1BB8();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_dlc4");
  maps\mp\_special_weapons::func_D5();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_raid_dlc4_osp";
  level.var_6C5E = "mp_raid_dlc4_osp";
  level.var_3445 = "mp_raid_dlc4_drone";
  level.var_343A = "mp_raid_dlc4_drone";
  level.var_A853 = "mp_raid_dlc4_warbird";
  level.var_A852 = "mp_raid_dlc4_warbird";
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
  level.var_75EE = 7;
  if(!isDefined(level.var_A3FB)) {
    level.var_A3FB = [];
  }

  level.var_A3FB["aimAtTarget"] = ::func_97DC;
  level.var_A3FB["canFireAtTarget"] = ::func_9786;
  lib_04FA::func_52FD(3);
  level.var_696E = ["breach", "breach_01", "breach_02", "acquire_tech", "tank_escort", "end"];
  level.var_696F = ["breach", "acquire_tech", "tank_escort", "end"];
  level.var_7919 = ::maps\mp\mp_raid_dlc4_vo::func_A617;
  lib_04FF::func_86DA("breach_01", "onMultiBombExplodeFunc", ::onbombexplode);
  lib_04FF::func_86DA("breach_02", "onMultiBombExplodeFunc", ::onbombexplode);
  lib_04FF::func_86DA("breach_01", "disableMultipleScoreEvents", 1);
  lib_04FF::func_86DA("breach_02", "disableMultipleScoreEvents", 1);
  lib_04FF::func_86DA("acquire_tech", "objModelDissappearsOnPickup", 1);
  runvignettes();
  thread maps\mp\mp_raid_dlc4_vo::func_5366();
  thread maps\mp\mp_raid_dlc4_vo::func_7FDF();
  thread func_7FC4();
  thread func_7FC0();
  thread func_7F89();
  thread func_7FCF();
  thread func_7F7D();
  thread func_7FB5();
  thread func_7FDB();
  var_00 = function_021F("axis_outro_light", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  var_04 = function_021F("allies_outro_light", "targetname");
  foreach(var_02 in var_04) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  var_07 = function_021F("axis_intro_light", "targetname");
  foreach(var_02 in var_07) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  thread removeextravisuals();
}

removeextravisuals() {
  var_00 = (4228, -2484, 1002);
  var_01 = 64;
  var_02 = getEntArray("script_brushmodel", "classname");
  foreach(var_04 in var_02) {
    if(isDefined(var_04.var_165) && var_04.var_165 == "visuals") {
      var_05 = distance2dsquared(var_00, var_04.var_116);
      if(var_05 <= var_01) {
        var_04 delete();
      }
    }
  }
}

func_7FC4() {}

runvignettes() {
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
  thread func_7FB4();
  thread runfanrotate();
}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_dlc4_ally_intro_guy1_shot_01", "mp_raids_dlc4_ally_intro_guy2_shot_01", "mp_raids_dlc4_ally_intro_guy3_shot_01", "mp_raids_dlc4_ally_intro_guy4_shot_01", "mp_raids_dlc4_ally_intro_guy5_shot_01", "mp_raids_dlc4_ally_intro_guy6_shot_01"];
  var_01 = ["mp_raids_dlc4_ally_intro_cam_shot_01", "mp_raids_dlc4_ally_intro_cam_shot_02", "mp_raids_dlc4_ally_intro_cam_shot_03", "mp_raids_dlc4_ally_intro_cam_shot_04", "mp_raids_dlc4_ally_intro_cam_shot_05", "mp_raids_dlc4_ally_intro_cam_shot_06"];
  var_02 = [::func_0BF8, ::func_0BF9, ::func_0BFA, ::func_0BFB, ::func_0BFC, ::func_0BFD];
  level.var_54D0["allies"].var_8F2 = "attackers";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_intro", "targetname");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 25;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_73E6 = ::func_54D4;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].basecostume = [1, 1, 1, 1, 1, 1];
  level.var_54D0["allies"].forceavatars[0] = 1;
  level.var_54D0["allies"].forceavatars[1] = 1;
  level.var_54D0["allies"].forceavatars[2] = 1;
  level.var_54D0["allies"].forceavatars[3] = 1;
  level.var_54D0["allies"].forceavatars[4] = 1;
  level.var_54D0["allies"].forceavatars[5] = 1;
  level.var_54D0["allies"].bot_costume = [3, 3, 3, 3, 3, 3];
  level.var_54D0["allies"].showfullteam = 1;
  level.var_54D0["allies"].var_6F27 = 1;
  level.var_54D0["allies"].var_1F06 = "genericprop_x3";
  level.var_54D0["allies"].var_1F08 = "j_prop_1";
}

set_allies_ents_dont_interpolate() {
  var_00 = lib_0502::func_4627(game["attackers"]);
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      var_02 dontinterpolatesafe();
    }
  }

  foreach(var_05 in level.var_54D0["allies"].var_8CA7) {
    if(isDefined(var_05) && isDefined(var_05.var_13B3)) {
      var_05.var_13B3 dontinterpolatesafe();
    }
  }

  if(isDefined(level.introvignette_allies_struct.var_9600)) {
    level.introvignette_allies_struct.var_9600 dontinterpolatesafe();
  }

  foreach(var_08 in level.introvignette_allies_struct.ally_soldiers) {
    if(isDefined(var_08)) {
      var_08 dontinterpolatesafe();
    }
  }

  foreach(var_0B in level.introvignette_allies_struct.var_A9E7) {
    if(isDefined(var_0B)) {
      var_0B dontinterpolatesafe();
    }
  }
}

func_0BF8(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        var_03 setscriptmotionblurparams(2, 1, 1);
      }
    }
  }

  set_allies_ents_dont_interpolate();
  level.var_A4B5["intensity"] = 0.7;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(var_01) && isDefined(level.var_A4B5)) {
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        var_03 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  var_07 = [];
  var_07 = lib_0505::func_3187(var_07, 2, 70, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_07);
  self lightsetforplayer("mp_raid_dlc4");
  self method_8483("mp_raid_dlc4_intro");
}

func_0BF9(param_00) {
  set_allies_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 200, 8, 16, 0);
  var_01 = lib_0505::func_3187(var_01, 3, 2500, 8, 16, 2);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_0BFA(param_00) {
  set_allies_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 200, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_0BFB(param_00) {
  set_allies_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 2000, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_0BFC(param_00) {
  set_allies_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 4, 500, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_0BFD(param_00) {
  set_allies_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 4, 100, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_54D7(param_00) {
  level.introvignette_allies_struct = spawnStruct();
  var_01 = common_scripts\utility::func_46B5("anim_allies_intro", "targetname");
  var_02 = var_01.var_116;
  var_03 = var_01.var_1D;
  lib_0378::func_8D74("aud_intro_start_sfx");
  var_04 = [];
  var_05 = ["mp_raids_dlc4_ally_intro_guy1", "mp_raids_dlc4_ally_intro_guy2", "mp_raids_dlc4_ally_intro_guy3", "mp_raids_dlc4_ally_intro_guy4", "mp_raids_dlc4_ally_intro_guy5", "mp_raids_dlc4_ally_intro_guy6"];
  var_06 = lib_0502::func_4627(game["attackers"]);
  foreach(var_08 in var_06) {
    var_08 method_8512("stg44_mp");
  }

  foreach(var_0B in level.var_54D0["allies"].var_8CA7) {
    var_04[var_04.size] = var_0B.var_13B3;
  }

  var_01 thread continue_multi_shot_anims(var_05, var_04, 6, "_shot_0", "allies");
  var_0D = ["mp_raids_dlc4_ally_intro_guy7", "mp_raids_dlc4_ally_intro_guy8"];
  var_0E = [];
  var_0F = [];
  var_10 = "stg44_mp";
  foreach(var_12 in var_0D) {
    var_13 = spawn("script_model", var_02);
    var_13.var_1A7 = "allies";
    var_13.var_267E = [2, 1, 2, 2, 2, 0];
    var_13 setcostumemodels(var_13.var_267E, "axis");
    var_14 = spawn("weapon_" + var_10, (0, 0, 0), 1);
    var_14 linkto(var_13, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_0F[var_0F.size] = var_14;
    var_13 method_8495(var_12 + "_shot_01", var_02, var_03);
    var_0E[var_0E.size] = var_13;
  }

  var_01 thread continue_multi_shot_anims(var_0D, var_0E, 6, "_shot_0", "allies");
  var_16 = spawn("script_model", var_02);
  var_16 setModel("vehicle_usa_tank_sherman_75mm_hatch");
  var_17 = "mp_raids_dlc4_ally_intro_tank";
  foreach(var_19 in level.var_97C5) {
    var_19 method_805C();
    var_19.var_9EDD method_805C();
  }

  var_16 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_ally_intro_tank_shot_01", var_02, var_03);
  var_01 thread continue_multi_shot_anim(var_17, var_16, 6, "_shot_0", "allies");
  var_1B = getEntArray("ally_intro_gate_whole", "script_noteworthy");
  var_1C = getEntArray("ally_intro_gate_broken", "script_noteworthy");
  common_scripts\utility::func_F71(var_1C, ::method_805C);
  var_16 thread introvignette_allies_show_broken_gate(var_1B, var_1C);
  level.introvignette_allies_struct.ally_soldiers = var_0E;
  level.introvignette_allies_struct.var_A9E7 = var_0F;
  level.introvignette_allies_struct.var_9600 = var_16;
}

func_54D4(param_00) {
  lib_0378::func_8D74("aud_intro_allies_mixing");
}

introvignette_allies_show_broken_gate(param_00, param_01) {
  self waittillmatch("model_swap", "default_notifynamemp_raids_dlc4_ally_intro_tank_shot_05");
  common_scripts\utility::func_F71(param_00, ::delete);
  common_scripts\utility::func_F71(param_01, ::method_805B);
}

func_54D3() {
  var_00 = level.introvignette_allies_struct.ally_soldiers;
  var_01 = level.introvignette_allies_struct.var_A9E7;
  var_02 = level.introvignette_allies_struct.var_9600;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  var_02 delete();
  foreach(var_04 in level.var_97C5) {
    var_04 method_805B();
    var_04.var_9EDD method_805B();
  }

  var_06 = lib_0502::func_4627(game["attackers"]);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  if(isDefined(var_06)) {
    foreach(var_08 in var_06) {
      var_08 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      var_08 setscriptmotionblurparams(0.35, 0, 0);
      var_08 lightsetforplayer("mp_raid_dlc4");
      var_08 method_8483("");
    }
  }
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_dlc4_axis_intro_guy01", "mp_raids_dlc4_axis_intro_guy02", "mp_raids_dlc4_axis_intro_guy03", "mp_raids_dlc4_axis_intro_guy04", "mp_raids_dlc4_axis_intro_guy05", "mp_raids_dlc4_axis_intro_guy06"];
  var_01 = ["mp_raids_dlc4_axis_intro_cam", "mp_raids_dlc4_axis_intro_cam_shot02", "mp_raids_dlc4_axis_intro_cam_shot03", "mp_raids_dlc4_axis_intro_cam_shot04", "mp_raids_dlc4_axis_intro_cam_shot05"];
  var_02 = [::func_147F, ::func_1480, ::func_1481, ::func_1482, ::func_1483];
  level.var_54D0["axis"].var_8F2 = "defenders";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_axis_intro", "targetname");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 14;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].showfullteam = 1;
  level.var_54D0["axis"].basecostume = [1, 1, 1, 1, 1, 1];
  level.var_54D0["axis"].forceavatars[0] = 1;
  level.var_54D0["axis"].forceavatars[1] = 1;
  level.var_54D0["axis"].forceavatars[2] = 1;
  level.var_54D0["axis"].forceavatars[3] = 1;
  level.var_54D0["axis"].forceavatars[4] = 1;
  level.var_54D0["axis"].forceavatars[5] = 1;
  level.var_54D0["axis"].bot_costume = [1, 1, 1, 1, 1, 1];
  level.var_54D0["axis"].var_92D5 = ::func_54E1;
  level.var_54D0["axis"].var_73E6 = ::func_54DC;
  level.var_54D0["axis"].var_2381 = ::func_54D9;
}

set_axis_ents_dont_interpolate() {
  var_00 = lib_0502::func_4627(game["defenders"]);
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      var_02 dontinterpolatesafe();
    }
  }

  if(isDefined(level.introvignette_axis_struct.var_272F)) {
    level.introvignette_axis_struct.var_272F dontinterpolatesafe();
  }

  foreach(var_05 in level.var_54D0["axis"].var_8CA7) {
    if(isDefined(var_05) && isDefined(var_05.var_13B3)) {
      var_05.var_13B3 dontinterpolatesafe();
    }
  }

  if(isDefined(level.introvignette_axis_struct.var_702B)) {
    level.introvignette_axis_struct.var_702B dontinterpolatesafe();
  }

  if(isDefined(level.introvignette_axis_struct.var_702C)) {
    level.introvignette_axis_struct.var_702C dontinterpolatesafe();
  }

  if(isDefined(level.introvignette_axis_struct.switch01)) {
    level.introvignette_axis_struct.switch01 dontinterpolatesafe();
  }

  if(isDefined(level.introvignette_axis_struct.cart01)) {
    level.introvignette_axis_struct.cart01 dontinterpolatesafe();
  }

  foreach(var_08 in level.introvignette_axis_struct.axis_soldiers) {
    if(isDefined(var_08)) {
      var_08 dontinterpolatesafe();
    }
  }

  foreach(var_0B in level.introvignette_axis_struct.var_A9E7) {
    if(isDefined(var_0B)) {
      var_0B dontinterpolatesafe();
    }
  }
}

func_54DC(param_00) {
  lib_0378::func_8D74("aud_intro_axis_mixing");
}

func_147F(param_00) {
  var_01 = lib_0502::func_4627(game["defenders"]);
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        var_03 setscriptmotionblurparams(2, 1, 1);
      }
    }
  }

  set_axis_ents_dont_interpolate();
  level.var_A4B5["intensity"] = 0.7;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(var_01) && isDefined(level.var_A4B5)) {
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        var_03 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  var_07 = [];
  var_07 = lib_0505::func_3187(var_07, 8, 40, 8, 16, 0);
  var_07 = lib_0505::func_3187(var_07, 8, 500, 8, 16, 1);
  thread lib_0505::func_3188(param_00, var_07);
  self lightsetforplayer("mp_raid_dlc4");
  self method_8483("mp_raid_dlc4_intro");
  var_08 = function_021F("axis_intro_light", "targetname");
  foreach(var_0A in var_08) {
    var_0A setscriptablepartstate("lightpart", "on");
  }
}

func_1480(param_00) {
  set_axis_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 10, 60, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_1481(param_00) {
  set_axis_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 8, 500, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_1482(param_00) {
  set_axis_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 100, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_1483(param_00) {
  set_axis_ents_dont_interpolate();
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 10, 750, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc4");
}

func_54E1() {
  level.introvignette_axis_struct = spawnStruct();
  var_00 = common_scripts\utility::func_46B5("anim_axis_intro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = level.var_54D0["axis"].var_8CA7;
  var_04 = [];
  var_05 = ["mp_raids_dlc4_axis_intro_guy01", "mp_raids_dlc4_axis_intro_guy02", "mp_raids_dlc4_axis_intro_guy03", "mp_raids_dlc4_axis_intro_guy04", "mp_raids_dlc4_axis_intro_guy05", "mp_raids_dlc4_axis_intro_guy06"];
  foreach(var_07 in var_03) {
    var_04[var_04.size] = var_07.var_13B3;
  }

  var_00 thread continue_multi_shot_anims(var_05, var_04, 5, "_shot0", "axis");
  var_03[1].forceweaponless = 1;
  var_09 = spawn("weapon_teslagunmtx_mp", (0, 0, 0), 1);
  var_09 linkto(var_04[1], "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_0A = ["mp_raids_dlc4_axis_intro_guy07", "mp_raids_dlc4_axis_intro_guy08"];
  var_0B = [];
  var_0C = [];
  var_0C[var_0C.size] = var_09;
  var_0D = "stg44_mp";
  foreach(var_0F in var_0A) {
    var_10 = spawn("script_model", var_01);
    var_10.var_1A7 = "allies";
    var_10.var_267E = function_0283();
    var_10 setcostumemodels(var_10.var_267E, "axis");
    var_09 = spawn("weapon_" + var_0D, (0, 0, 0), 1);
    var_09 linkto(var_10, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_0C[var_0C.size] = var_09;
    var_10 method_8495(var_0F, var_01, var_02);
    var_0B[var_0B.size] = var_10;
  }

  var_00 thread continue_multi_shot_anims(var_0A, var_0B, 5, "_shot0", "axis");
  var_0B[1] attach("npc_zom_elek_01", "TAG_WEAPON_LEFT");
  var_12 = spawn("script_model", var_01);
  var_12 setModel("hub_lootcrate_a");
  var_13 = "mp_raids_dlc4_axis_intro_crate01";
  var_12 method_8495(var_13, var_01, var_02);
  var_00 thread continue_multi_shot_anim(var_13, var_12, 5, "_shot0", "axis");
  var_14 = spawn("script_model", var_01);
  var_14 setModel("usa_fighter_thunderbolt_mp");
  var_15 = "mp_raids_dlc4_axis_intro_plane01";
  var_14 method_8495(var_15, var_01, var_02);
  var_00 thread continue_multi_shot_anim(var_15, var_14, 5, "_shot0", "axis");
  var_16 = spawn("script_model", var_01);
  var_16 setModel("usa_fighter_thunderbolt_mp");
  var_17 = "mp_raids_dlc4_axis_intro_plane02";
  var_16 method_8495(var_17, var_01, var_02);
  var_00 thread continue_multi_shot_anim(var_17, var_16, 5, "_shot0", "axis");
  var_18 = spawn("script_model", var_01);
  var_18 setModel("zmi_artillery_switch");
  var_19 = "mp_raids_dlc4_axis_intro_switch01";
  var_18 method_8495(var_19, var_01, var_02);
  var_00 thread continue_multi_shot_anim(var_19, var_18, 5, "_shot0", "axis");
  var_1A = spawn("script_model", var_01);
  var_1A setModel("swf_transport_cart_01");
  var_1B = "mp_raids_dlc4_axis_intro_cart01";
  var_1A method_8495(var_1B, var_01, var_02);
  var_00 thread continue_multi_shot_anim(var_1B, var_1A, 5, "_shot0", "axis");
  level.introvignette_axis_struct.var_272F = var_12;
  level.introvignette_axis_struct.var_702B = var_14;
  level.introvignette_axis_struct.var_702C = var_16;
  level.introvignette_axis_struct.switch01 = var_18;
  level.introvignette_axis_struct.cart01 = var_1A;
  level.introvignette_axis_struct.axis_soldiers = var_0B;
  level.introvignette_axis_struct.var_A9E7 = var_0C;
}

continue_multi_shot_anim(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self.var_116;
  var_06 = self.var_1D;
  for(var_07 = 1; var_07 < param_02; var_07++) {
    level waittill("next_shot_anim_" + param_04);
    param_01 animscripts\notetracks_common::give_player_xp(param_00 + param_03 + var_07 + 1, var_05, var_06);
  }
}

continue_multi_shot_anims(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self.var_116;
  var_06 = self.var_1D;
  for(var_07 = 1; var_07 < param_02; var_07++) {
    level waittill("next_shot_anim_" + param_04);
    foreach(var_0A, var_09 in param_01) {
      var_09 method_8495(param_00[var_0A] + param_03 + var_07 + 1, var_05, var_06);
    }
  }
}

func_54D9() {
  var_00 = level.introvignette_axis_struct.var_272F;
  var_01 = level.introvignette_axis_struct.var_702B;
  var_02 = level.introvignette_axis_struct.var_702C;
  var_03 = level.introvignette_axis_struct.switch01;
  var_04 = level.introvignette_axis_struct.cart01;
  var_05 = level.introvignette_axis_struct.axis_soldiers;
  var_06 = level.introvignette_axis_struct.var_A9E7;
  var_00 delete();
  var_01 delete();
  var_02 delete();
  var_03 delete();
  var_04 delete();
  common_scripts\utility::func_F71(var_05, ::delete);
  common_scripts\utility::func_F71(var_06, ::delete);
  var_07 = lib_0502::func_4627(game["defenders"]);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  if(isDefined(var_07)) {
    foreach(var_09 in var_07) {
      if(isalive(var_09)) {
        var_09 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_09 setscriptmotionblurparams(0.35, 0, 0);
        var_09 lightsetforplayer("mp_raid_dlc4");
        var_09 visionsetnakedforplayer("", 0);
        var_09 visionsetpostapplyforplayer("", 0);
        var_09 method_8483("");
      }
    }
  }

  var_0B = function_021F("axis_intro_light", "targetname");
  foreach(var_0D in var_0B) {
    var_0D setscriptablepartstate("lightpart", "off");
  }
}

func_7FB4() {
  thread bellanimationthink();
  var_00 = common_scripts\utility::func_46B5("truck_push_node", "targetname");
  var_01 = getent("truck_push", "script_noteworthy");
  var_02 = getent(var_01.var_1A2, "targetname");
  var_02 linkto(var_01, "truck");
  var_03 = getent("tank_push_trigger", "script_noteworthy");
  var_04 = getent("obj1_tankpush_kill", "targetname");
  level waittill("tank_push");
  foreach(var_06 in level.var_744A) {
    if(isalive(var_06) && var_06 istouching(var_04)) {
      var_06 dodamage(999999, var_06.var_116);
    }

    if(isDefined(var_06.var_872A)) {
      if(var_06.var_872A istouching(var_02) || var_06.var_872A istouching(var_04)) {
        level maps\mp\perks\_perkfunctions::func_2D54(var_06.var_872A);
      }
    }
  }

  var_01 method_8495("mp_raids_dlc4_halftrack_push", var_01.var_116, var_01.var_1D);
  lib_0378::func_8D74("aud_tank_push_truck", var_01);
}

runfanrotate() {
  var_00 = getEntArray("fan_vault_rotate", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread fanrotate();
  }
}

fanrotate() {
  level endon("game_ended");
  var_00 = 20;
  for(;;) {
    self rotateby((360, 0, 0), var_00);
    wait(var_00);
  }
}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_dlc4_ally_outro_cam_shot1", "mp_raids_dlc4_ally_outro_cam_shot2"];
  var_01 = [::func_6C87, ::func_6C88];
  level.var_6C86["allies"].var_8F2 = "attackers";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_win_outro", "targetname");
  level.var_6C86["allies"].var_8097 = 12;
  level.var_6C86["allies"].var_1F03 = var_00;
  level.var_6C86["allies"].var_1F05 = var_01;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
  level.var_6C86["allies"].var_1F06 = "genericprop_x3";
  level.var_6C86["allies"].var_1F08 = "j_prop_1";
  level.outro_weapons = [];
  level.outro_weapons[level.outro_weapons.size] = outrovignette_allies_spawn_weapon("thompson_mp");
  level.outro_weapons[level.outro_weapons.size] = outrovignette_allies_spawn_weapon("bar_mp");
  level.outro_weapons[level.outro_weapons.size] = outrovignette_allies_spawn_weapon("m1911_mp");
  level.outro_weapons[level.outro_weapons.size] = outrovignette_allies_spawn_weapon("m1919_mp");
  level.outro_weapons[level.outro_weapons.size] = outrovignette_allies_spawn_weapon("teslagunmtx_mp");
  thread outro_vignette_allies_late_setup();
}

outro_vignette_allies_late_setup() {
  wait(10);
  foreach(var_01 in level.var_744A) {
    var_01 method_8512("thompson_mp", "bar_mp", "m1911_mp", "m1919_mp", "teslagunmtx_mp");
  }

  lib_04FF::func_6982("tank_escort");
  foreach(var_01 in level.var_744A) {
    var_01 method_8512("thompson_mp", "bar_mp", "m1911_mp", "m1919_mp", "teslagunmtx_mp");
  }
}

func_6C87(param_00) {
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
        var_02 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  var_06 = [];
  var_06 = lib_0505::func_3187(var_06, 3, 300, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_06);
  self lightsetforplayer("mp_raid_dlc4");
  self method_8483("mp_raid_dlc4");
  var_07 = function_021F("allies_outro_light", "targetname");
  foreach(var_09 in var_07) {
    var_09 setscriptablepartstate("lightpart", "on");
  }
}

func_6C88(param_00) {
  level notify("next_camera");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 10, 700, 8, 16, 0);
  var_01 = lib_0505::func_3187(var_01, 1, 700, 8, 16, 2);
  var_01 = lib_0505::func_3187(var_01, 3, 100, 8, 16, 4);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C8D() {
  level notify("allied_win_outro_start");
  lib_0378::func_8D74("aud_allies_victory_sfx");
  level.outrovignette_ally_struct = spawnStruct();
  var_00 = common_scripts\utility::func_46B5("anim_allies_win_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = ["mp_raids_dlc4_ally_outro_guy1", "mp_raids_dlc4_ally_outro_guy2", "mp_raids_dlc4_ally_outro_guy3", "mp_raids_dlc4_ally_outro_guy4", "mp_raids_dlc4_ally_outro_guy5", "mp_raids_dlc4_ally_outro_guy6"];
  var_04 = [];
  var_05 = lib_0502::func_4627(game["attackers"]);
  foreach(var_09, var_07 in var_03) {
    var_08 = spawn("script_model", var_01);
    var_08.var_1A7 = "allies";
    if(var_09 >= var_05.size) {
      var_08.var_267E = [1, 1, 1, 1, 1, 1];
      var_08 setcostumemodels(var_08.var_267E, "allies");
    } else {
      var_08 setcostumemodels(var_05[var_09].var_267E, "allies");
    }

    switch (var_09) {
      case 0:
        outrovignette_allies_assign_weapon(level.outro_weapons[0], var_08);
        break;

      case 1:
        outrovignette_allies_assign_weapon(level.outro_weapons[1], var_08);
        break;

      case 3:
        outrovignette_allies_assign_weapon(level.outro_weapons[2], var_08);
        break;

      case 4:
        outrovignette_allies_assign_weapon(level.outro_weapons[3], var_08);
        break;

      case 5:
        outrovignette_allies_assign_weapon(level.outro_weapons[4], var_08);
        break;
    }

    var_08 animscripts\notetracks_common::give_player_xp(var_07, var_01, var_02);
    var_04[var_04.size] = var_08;
  }

  var_0A = spawn("script_model", var_01);
  var_0A setModel("vehicle_usa_tank_sherman_75mm_hatch");
  var_0A animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_ally_outro_tank", var_01, var_02);
  foreach(var_0C in level.var_97C5) {
    var_0C method_805C();
    var_0C.var_9EDD method_805C();
  }

  var_0E = getent("axis_outro_bell", "targetname");
  var_0E animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_ally_outro_bell", var_01, var_02);
  var_0E thread outrovignette_allies_switch_model();
  var_0F = ["mp_raids_dlc4_ally_outro_cable_front", "mp_raids_dlc4_ally_outro_cable_rear", "mp_raids_dlc4_ally_outro_cable_right", "mp_raids_dlc4_ally_outro_cable_left"];
  var_10 = [];
  foreach(var_12 in var_0F) {
    var_13 = spawn("script_model", var_01);
    var_13 setModel("nazi_bell_01_cable");
    var_13 animscripts\notetracks_common::give_player_xp(var_12, var_01, var_02);
    var_10[var_10.size] = var_13;
  }

  level.outrovignette_ally_struct.ally_soldiers = var_04;
  level.outrovignette_ally_struct.var_9600 = var_0A;
  level.outrovignette_ally_struct.bell = var_0E;
  level.outrovignette_ally_struct.cable_models = var_10;
}

outrovignette_allies_spawn_weapon(param_00) {
  var_01 = spawn("weapon_" + param_00, (0, 0, 0), 1);
  return var_01;
}

outrovignette_allies_assign_weapon(param_00, param_01) {
  param_00 linkto(param_01, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
}

outrovignette_allies_switch_model() {
  level waittill("next_camera");
  wait(2.2);
  self setModel("swf_german_bell_01_destroyed");
}

func_6C8B() {
  var_00 = level.outrovignette_ally_struct.var_9600;
  var_01 = level.outrovignette_ally_struct.ally_soldiers;
  var_02 = level.outrovignette_ally_struct.bell;
  var_03 = level.outrovignette_ally_struct.cable_models;
  var_02 setModel("swf_german_bell_01");
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  var_00 delete();
  foreach(var_05 in level.var_97C5) {
    var_05 method_805B();
    var_05.var_9EDD method_805B();
  }

  if(isDefined(level.var_744A)) {
    foreach(var_08 in level.var_744A) {
      if(isalive(var_08)) {
        var_08 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_08 setscriptmotionblurparams(0.35, 0, 0);
        var_08 lightsetforplayer("mp_raid_dlc4");
        var_08 visionsetnakedforplayer("", 0);
        var_08 visionsetpostapplyforplayer("", 0);
      }
    }
  }

  var_0A = function_021F("allies_outro_light", "targetname");
  foreach(var_0C in var_0A) {
    var_0C setscriptablepartstate("lightpart", "off");
  }
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_dlc4_axis_outro_shot_01_camera_01", "mp_raids_dlc4_axis_outro_shot_01_camera_02"];
  var_01 = [::func_6C8E, ::func_6C8F];
  level.var_6C86["axis"].var_8F2 = "attackers";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_axis_win_outro", "targetname");
  level.var_6C86["axis"].var_8097 = 12;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
  level.var_6C86["axis"].var_1F06 = "genericprop_x3";
  level.var_6C86["axis"].var_1F08 = "j_prop_1";
}

func_6C8E(param_00) {
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
        var_02 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
      }
    }
  }

  var_06 = [];
  var_06 = lib_0505::func_3187(var_06, 2, 47, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_06);
  self method_8483("mp_raid_dlc4_axis_outro");
  self lightsetforplayer("mp_raid_dlc4_axis_outro");
  var_07 = function_021F("axis_outro_light", "targetname");
  foreach(var_09 in var_07) {
    var_09 setscriptablepartstate("lightpart", "on");
  }
}

func_6C8F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 150, 8, 8, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C94() {
  level.outrovignette_axis_struct = spawnStruct();
  lib_0378::func_8D74("aud_axis_victory_sfx");
  var_00 = common_scripts\utility::func_46B5("anim_axis_win_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = ["mp_raids_dlc4_axis_outro_shot_01_ally_01", "mp_raids_dlc4_axis_outro_shot_01_ally_02", "mp_raids_dlc4_axis_outro_shot_01_ally_03", "mp_raids_dlc4_axis_outro_shot_01_ally_04", "mp_raids_dlc4_axis_outro_shot_01_ally_05", "mp_raids_dlc4_axis_outro_shot_01_ally_06"];
  var_04 = [];
  var_05 = lib_0502::func_4627(game["attackers"]);
  foreach(var_0A, var_07 in var_03) {
    var_08 = spawn("script_model", var_01);
    var_08.var_1A7 = "allies";
    var_09 = var_0A >= var_05.size || var_0A == 0;
    if(var_09) {
      var_08.var_267E = [1, 1, 1, 1, 1, 1];
      var_08 setcostumemodels(var_08.var_267E, "allies");
    } else {
      var_08 setcostumemodels(var_05[var_0A].var_267E, "allies");
    }

    var_08 animscripts\notetracks_common::give_player_xp(var_07, var_01, var_02);
    var_04[var_04.size] = var_08;
  }

  var_0B = [];
  var_0C = ["mp_raids_dlc4_axis_outro_shot_01_axis_01", "mp_raids_dlc4_axis_outro_shot_01_axis_02", "mp_raids_dlc4_axis_outro_shot_01_axis_04", "mp_raids_dlc4_axis_outro_shot_01_axis_05"];
  var_0D = lib_0502::func_4627(game["defenders"]);
  foreach(var_0A, var_0F in var_0C) {
    var_10 = "stg44_mp";
    var_08 = spawn("script_model", var_01);
    var_08.var_1A7 = "axis";
    if(var_0A >= var_0D.size) {
      var_08.var_267E = [2, 1, 2, 2, 2, 0];
      var_08 setcostumemodels(var_08.var_267E, "axis");
    } else {
      var_08 setcostumemodels(var_0D[var_0A].var_267E, "axis");
    }

    var_08 animscripts\notetracks_common::give_player_xp(var_0F, var_01, var_02);
    var_0B[var_0B.size] = var_08;
  }

  var_11 = spawn("script_model", var_01);
  var_11 setModel("zom_hero_straub_wholebody");
  var_11.color = spawn("script_model", var_01);
  var_11.color setModel("mp_head_joyce_hub");
  var_11.color linkto(var_11, "J_Neck", (-13.2, 0, 0), (0, 0, 0));
  var_11.goggles = spawn("script_model", var_01);
  var_11.goggles setModel("zom_auergog_org1");
  var_11.goggles linkto(var_11.color, "J_Head", (0, 0, 0), (0, 0, 0));
  var_12 = "mp_raids_dlc4_axis_outro_shot_01_axis_03";
  var_11 animscripts\notetracks_common::give_player_xp(var_12, var_01, var_02);
  var_0B[var_0B.size] = var_11;
  var_0B[var_0B.size] = var_11.color;
  var_0B[var_0B.size] = var_11.goggles;
  var_13 = ["mp_raids_dlc4_axis_outro_shot_01_rope_01", "mp_raids_dlc4_axis_outro_shot_01_rope_02", "mp_raids_dlc4_axis_outro_shot_01_rope_03"];
  var_14 = [];
  foreach(var_16 in var_13) {
    var_17 = spawn("script_model", var_01);
    var_17 setModel("zbr_drop_pod_02_cable");
    var_17 animscripts\notetracks_common::give_player_xp(var_16, var_01, var_02);
    var_14[var_14.size] = var_17;
  }

  var_19 = getent("axis_outro_door", "targetname");
  var_19 method_805C();
  level.outrovignette_axis_struct.ally_soldiers = var_04;
  level.outrovignette_axis_struct.axis_soldiers = var_0B;
  level.outrovignette_axis_struct.rope_models = var_14;
}

func_6C92() {
  var_00 = level.outrovignette_axis_struct.ally_soldiers;
  var_01 = level.outrovignette_axis_struct.axis_soldiers;
  var_02 = level.outrovignette_axis_struct.rope_models;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  var_03 = getent("axis_outro_door", "targetname");
  var_03 method_805B();
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  if(isDefined(level.var_744A)) {
    foreach(var_05 in level.var_744A) {
      if(isalive(var_05)) {
        var_05 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_05 setscriptmotionblurparams(0.35, 0, 0);
        var_05 lightsetforplayer("mp_raid_dlc4");
        var_05 method_8483("mp_raid_dlc4");
      }
    }
  }

  var_07 = function_021F("axis_outro_light", "targetname");
  foreach(var_09 in var_07) {
    var_09 setscriptablepartstate("lightpart", "off");
  }
}

func_7F7D() {}

func_7FCF() {
  setgamespawnpointactivelabel("A", "A", "A");
  level waittill("breach_done");
  level thread lib_0502::func_90A7("B", "A", 20, "B", "B");
  level waittill("tank_checkpoint_1");
  thread deactivatepickupbox("defender_pickups_a");
  thread deactivatepickupbox("attacker_pickups_a");
  thread activatepickupbox("defender_pickups_b");
  thread activatepickupbox("attacker_pickups_b");
  lib_0502::func_90A4("C", "C");
  level waittill("tank_checkpoint_2");
  thread deactivatepickupbox("defender_pickups_b");
  thread deactivatepickupbox("attacker_pickups_b");
  thread activatepickupbox("defender_pickups_c");
  thread activatepickupbox("attacker_pickups_c");
  lib_0502::func_90A4("D", "D");
  level waittill("tank_checkpoint_3");
  lib_0502::func_90A4("E", "E");
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
  lib_04F4::func_8BEF(["allies_A", "axis_A"]);
  level waittill("breach_done");
  level thread lib_04F4::func_9C77("allies_B", 20);
  lib_04F4::func_863D("axis_A", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
  level waittill("tank_checkpoint_1");
  level thread lib_04F4::func_9C77("allies_C", 20);
  lib_04F4::func_863D("axis_B", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C", "axis_C"]);
  level waittill("tank_checkpoint_2");
  level thread lib_04F4::func_9C77("allies_D", 20);
  lib_04F4::func_863D("axis_C", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_D", "axis_D"]);
  level waittill("tank_checkpoint_3");
  level thread lib_04F4::func_9C77("allies_E", 20);
  lib_04F4::func_863D("axis_D", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_E", "axis_E"]);
}

func_7FB5() {}

func_7FDB() {}

func_7FC0() {
  level endon("game_ended");
  waittillframeend;
  runbreachobjective();
  lib_0502::func_7B35();
  runacquireobjective();
  lib_0502::func_7B35();
  runescortobjective();
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

runpreobjective() {
  level notify("tank_move_to_bridge");
  if(!isDefined(level.var_79C2.var_97C0)) {
    level.var_79C2.var_97C0 = [];
  }

  level.var_79C2.var_97C0["tank_move_to_bridge"] = 1;
  wait(10);
  level notify("tank_move_to_ammo_dump");
  if(!isDefined(level.var_79C2.var_97C0)) {
    level.var_79C2.var_97C0 = [];
  }

  level.var_79C2.var_97C0["tank_move_to_ammo_dump"] = 1;
}

runbreachobjective() {
  lib_0502::func_697F("breach");
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 3);
  lib_04FF::func_6972("breach");
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_0502::func_86DE(lib_0501::func_4647("bomb_objectiveTime"), 1);
  lib_04FF::func_6982("breach");
  level notify("tank_move_to_tunnell");
  level notify("breach_done");
}

onbombexplode(param_00) {
  lib_04FF::func_6981("breach", undefined, 0);
  lib_04FF::func_6981("breach_01", undefined, 0);
  lib_04FF::func_6981("breach_02", undefined, 0);
  lib_04FF::func_6935("breach_01");
  lib_04FF::func_6935("breach_02");
  level lib_04FF::func_79B3("breach_01");
  level lib_04FF::func_79B3("breach_02");
  removebreakables("breach_delete");
}

runacquireobjective() {
  wait 0.05;
  lib_0502::func_697F("acquire_tech");
  thread tankbreakables();
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 4);
  thread activatepickupbox("defender_pickups_a");
  thread monitorsecretweaponunlock();
  var_00 = getEntArray("relayPickupZone", "script_noteworthy");
  foreach(var_02 in var_00) {
    thread randomizepickuplocation(var_02);
  }

  lib_04FF::func_6972("acquire_tech");
  lib_0502::func_86DE(lib_0501::func_4647("ctf_objectiveTime"), 2);
  level lib_04FF::func_79B3("breach_01");
  level lib_04FF::func_79B3("breach_02");
  function_0226(&"add_image_timer_hack", 0);
  lib_04FF::func_6982("acquire_tech");
  level notify("acquire_done");
}

randomizepickuplocation(param_00) {
  if(common_scripts\utility::func_24A6()) {
    return;
  }

  if(param_00.var_81E1 == 1) {
    var_01 = "weapon_location_b";
  } else {
    var_01 = "plans_location_b";
  }

  var_02 = getEntArray(param_00.var_1A2, "targetname");
  var_03 = common_scripts\utility::func_46B7(param_00.var_1A2, "targetname");
  var_04 = common_scripts\utility::func_F73(var_02, var_03);
  var_04 = common_scripts\utility::func_F6F(var_04, param_00);
  var_05 = common_scripts\utility::func_46B5(var_01, "targetname");
  var_06 = var_05.var_116 - param_00.var_116;
  foreach(var_08 in var_04) {
    var_08.var_116 = var_08.var_116 + var_06;
  }
}

runescortobjective() {
  lib_0502::func_697F("tank_escort");
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  lib_04FF::func_6972("tank_escort");
  lib_0502::func_86DE(lib_0501::func_4647("escort_objectiveTime"), 3);
  lib_04FF::func_6982("tank_escort");
}

monitorsecretweaponunlock() {
  level waittill("unlockSecretWeapon");
  thread activatepickupbox("attacker_pickups_a");
}

activatepickupbox(param_00) {
  var_01 = getent(param_00, "targetname");
  var_02 = common_scripts\utility::func_46B7("special_weapon", "targetname");
  foreach(var_04 in level.var_744A) {
    var_04 method_8512("teslagun_war_regular_mp");
  }

  foreach(var_07 in var_02) {
    if(var_07.var_272F istouching(var_01)) {
      var_07 maps\mp\_special_weapons::enablespecialweaponpickup();
    }
  }
}

deactivatepickupbox(param_00) {
  var_01 = getent(param_00, "targetname");
  var_02 = common_scripts\utility::func_46B7("special_weapon", "targetname");
  foreach(var_04 in var_02) {
    if(var_04.var_272F istouching(var_01)) {
      var_04 maps\mp\_special_weapons::disablespecialweaponpickup();
    }
  }
}

tankbreakables() {
  level waittill("break_boxes_01");
  removebreakables("tank_boxes_01");
  level waittill("break_boxes_02");
  removebreakables("tank_boxes_02");
  level waittill("break_boxes_03");
  removebreakables("tank_boxes_03");
}

removebreakables(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    var_03 method_805C();
    var_03 notsolid();
  }
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

      case "animate_hide":
        func_1BB3(var_04, level.var_1BB5[param_00][var_04.var_81E1]);
        var_04 common_scripts\utility::func_2CBE(1, ::method_805C);
        break;

      default:
        break;
    }
  }
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
      var_02 = [1];
      var_03 = 1;
      break;

    case "mp_raids_cobra_tank_crates_group_c_02b_start":
      var_02 = [0.8];
      var_03 = 0.7;
      break;

    case "mp_raids_cobra_tank_crates_group_c_01b_start":
      var_02 = [0.05];
      var_03 = 0;
      break;

    case "mp_raids_cobra_tank_crates_group_c_01a_start":
      var_02 = [0.05];
      var_03 = 0;
      break;
  }

  param_00 thread breakobjectdisconnectpathnodes(param_00);
  param_00 thread func_1BBA(param_00, var_02);
  param_00 thread func_1BB6(param_00, param_01, var_03);
}

breakobjectdisconnectpathnodes(param_00) {
  if(!isDefined(param_00) || !isDefined(param_00.var_1A5)) {
    return;
  }

  if(param_00.var_1A5 != "break_objects_C" || !isDefined(param_00.var_116)) {
    return;
  }

  var_01 = getnodesinradius(param_00.var_116, 512, 0, 128, "Begin");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_1A2)) {
      var_04 = getnode(var_03.var_1A2, "targetname");
      if(isDefined(var_04) && isDefined(var_03)) {
        disconnectnodepair(var_03, var_04);
      }
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

func_1BBA(param_00, param_01) {
  var_02 = 0;
  var_03 = randomfloatrange(0.05, 0.35);
  if(isDefined(param_01) && isarray(param_01)) {
    foreach(var_05 in param_01) {
      wait(var_05);
      param_00 lib_0378::func_8D74("aud_tank_break_crate");
    }
  }
}

func_1BB8() {
  level.var_1BB9["dun_wood_crate_01"] = "dun_wood_single_crate_war_chunks";
  level.var_1BB9["rkt_wood_crate_01_b"] = "dun_wood_single_crate_war_chunks";
  level.var_1BB9["dun_wood_crate_01_blank"] = "dun_wood_single_crate_war_chunks";
  level.var_1BB9["dun_wood_crate_01_ammo"] = "dun_wood_single_crate_war_chunks";
  level.var_1BB9["swf_wood_crate_01"] = "swf_wood_single_crate_war_chunks_01";
  level.var_1BB9["swf_wood_crate_02"] = "swf_wood_single_crate_war_chunks_02";
  level.var_1BB5 = [];
  level.var_1BB5["break_objects_A"] = ["mp_raids_cobra_tank_crates_group_c_01b_start", "mp_raids_cobra_tank_crates_group_c_01a_start"];
  level.var_1BB5["break_objects_B"] = ["mp_raids_cobra_tank_crates_group_c_02a_start", "mp_raids_cobra_tank_crates_group_c_02b_start", "mp_raids_cobra_tank_crates_group_c_01b_start", "mp_raids_cobra_tank_crates_group_c_01a_start"];
  level.var_1BB5["break_objects_C"] = ["mp_raids_cobra_tank_crates_group_c_02a_start", "mp_raids_cobra_tank_crates_group_c_02b_start", "mp_raids_cobra_tank_crates_group_c_01b_start", "mp_raids_cobra_tank_crates_group_c_01a_start"];
  level.var_1BB5["break_objects_D"] = ["mp_raids_cobra_tank_crates_group_c_02a_start", "mp_raids_cobra_tank_crates_group_c_02b_start", "mp_raids_cobra_tank_crates_group_c_01b_start", "mp_raids_cobra_tank_crates_group_c_01a_start"];
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

  firevehicleturret_dlc4(self);
  self.var_9696.var_1A4 thread func_4AFA();
  level notify("escort_tank_fired_at_target");
  if(!isDefined(self.var_9716)) {
    self.var_9716 = [];
  }

  self.var_9716[self.var_9716.size] = param_00;
  wait(0.5);
  func_97B3();
}

func_4AFA() {}

func_97B3() {
  self.var_9696 = undefined;
  self.var_9734 = 0;
  self method_825D();
}

dontinterpolatesafe() {
  if(!isDefined(self.dontinterpolate_timestamp) || gettime() > self.dontinterpolate_timestamp) {
    self.dontinterpolate_timestamp = gettime();
    self method_808C();
  }
}

bellanimationthink() {
  thread finalebellthink();
  var_00 = common_scripts\utility::func_46B5("bell_arena_animorg", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = getent("bell01", "targetname");
  var_03 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_idle", var_01, var_02);
  var_04 = getent("bell_cable_front", "targetname");
  var_05 = getent("bell_cable_left", "targetname");
  var_06 = getent("bell_cable_right", "targetname");
  var_07 = getent("bell_cable_rear", "targetname");
  var_04 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_front_idle", var_01, var_02);
  var_05 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_left_idle", var_01, var_02);
  var_06 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_right_idle", var_01, var_02);
  var_07 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_rear_idle", var_01, var_02);
  while(!isDefined(level.var_97C5) || level.var_97C5.size <= 0) {
    wait 0.05;
  }

  var_08 = level.var_97C5[0];
  var_09 = getent("flakTarget3", "targetname");
  while(!isDefined(var_08.var_9696) || !isDefined(var_08.var_9696.var_1A4) || var_08.var_9696.var_1A4 != var_09) {
    wait(0.25);
  }

  level waittill("escort_tank_fired_at_target");
  lib_0378::func_8D74("aud_tank_fires_at_bell", var_08);
  wait(0.25);
  var_03 setModel("swf_german_bell_01_destroyed");
  lib_0378::func_8D74("aud_bell_impact", var_03);
  var_03 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_destroy", var_01, var_02);
  var_04 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_front_destroy", var_01, var_02);
  var_05 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_left_destroy", var_01, var_02);
  var_06 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_right_destroy", var_01, var_02);
  var_07 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_rear_destroy", var_01, var_02);
  wait(9);
  var_03 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_destroyed_idle", var_01, var_02);
  var_04 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_front_destroyed_idle", var_01, var_02);
  var_05 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_left_destroyed_idle", var_01, var_02);
  var_06 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_right_destroyed_idle", var_01, var_02);
  var_07 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_cable_rear_destroyed_idle", var_01, var_02);
}

finalebellthink() {
  var_00 = common_scripts\utility::func_46B5("anim_allies_win_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = getent("axis_outro_bell", "targetname");
  var_03 animscripts\notetracks_common::give_player_xp("mp_raids_dlc4_bell_idle_2", var_01, var_02);
  var_04 = ["mp_raids_dlc4_bell_cable_front_idle_2", "mp_raids_dlc4_bell_cable_left_idle_2", "mp_raids_dlc4_bell_cable_right_idle_2", "mp_raids_dlc4_bell_cable_rear_idle_2"];
  var_05 = [];
  foreach(var_07 in var_04) {
    var_08 = spawn("script_model", var_01);
    var_08 setModel("nazi_bell_01_cable");
    var_08 animscripts\notetracks_common::give_player_xp(var_07, var_01, var_02);
    var_05[var_05.size] = var_08;
  }

  level waittill("allied_win_outro_start");
  foreach(var_08 in var_05) {
    var_08 scriptmodelclearanim();
    var_08 delete();
  }
}

firevehicleturret_dlc4(param_00) {
  playFXOnTag(common_scripts\utility::func_44F5("mp_dlc4_tank_muzzle"), param_00, "tag_flash");
  param_00 method_8263();
}