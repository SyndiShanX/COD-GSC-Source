/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc3.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_raid_dlc3_precache::func_F9();
  maps\createart\mp_raid_dlc3_art::func_F9();
  maps\createart\mp_raid_dlc3_fog_hdr::func_F9();
  maps\mp\mp_raid_dlc3_fx::func_F9();
  maps\mp\_audio_submixes::func_524C();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_dlc3_lighting::func_F9();
  maps\mp\mp_raid_dlc3_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_dlc3");
  maps\mp\_special_weapons::func_D5();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_raid_dlc3_osp";
  level.var_6C5E = "mp_raid_dlc3_osp";
  level.var_3445 = "mp_raid_dlc3_drone";
  level.var_343A = "mp_raid_dlc3_drone";
  level.var_A853 = "mp_raid_dlc3_warbird";
  level.var_A852 = "mp_raid_dlc3_warbird";
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

  lib_04FA::func_52FD(4);
  level.var_696E = ["secure_supplies", "bomb_plant", "bomb_01", "bomb_02", "bomb_03", "bomb_04", "capture_flags", "end"];
  level.var_696F = ["secure_supplies", "bomb_plant", "capture_flags", "end"];
  var_00 = lib_0501::func_4647("bomb_timer");
  lib_04FF::func_86DA("bomb_01", "onMultiBombExplodeFunc", ::onbombexplode);
  lib_04FF::func_86DA("bomb_02", "onMultiBombExplodeFunc", ::onbombexplode);
  lib_04FF::func_86DA("bomb_03", "onMultiBombExplodeFunc", ::onbombexplode);
  lib_04FF::func_86DA("bomb_04", "onMultiBombExplodeFunc", ::onbombexplode);
  lib_04FF::func_86DA("capture_flags", "flagsCapFunc", ::onflagcap);
  lib_04FF::func_86DA("bomb_01", "bomb_timer", 35);
  lib_04FF::func_86DA("bomb_02", "bomb_timer", 35);
  lib_04FF::func_86DA("bomb_03", "bomb_timer", 35);
  lib_04FF::func_86DA("bomb_04", "bomb_timer", 35);
  level.custom_earthquake_scale = 0.25;
  level.custom_earthquake_duration = 1;
  level.custom_earthquake_delay = 1;
  runvignettes();
  thread maps\mp\mp_raid_dlc3_vo::func_5366();
  thread maps\mp\mp_raid_dlc3_vo::func_7FDF();
  thread func_7FC4();
  thread armoredtrainsetup();
  thread func_7FC0();
  thread func_7F89();
  thread func_7FCF();
  thread func_7F7D();
  thread func_7FB5();
  thread func_7FDB();
  thread initbunkerturrets();
  thread onplayerconnecttunisia();
  thread run_sandstorm();
  thread run_palmtree_anims();
  thread performance_stuff();
  thread replacebadturrets();
}

replacebadturrets() {
  var_00 = (5569, 6054.5, 424.3);
  var_01 = (5754, 6593.5, 423.3);
  var_02 = 4096;
  var_03 = "turret_mg42_raid_stand_mp";
  var_04 = function_0024();
  foreach(var_06 in var_04) {
    if(var_06.maxhealth == var_03) {
      var_07 = distancesquared(var_00, var_06.var_116);
      var_08 = distancesquared(var_01, var_06.var_116);
      if(var_07 <= var_02 || var_08 <= var_02) {
        var_06 delete();
      }
    }
  }
}

onplayerconnecttunisia() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread sandstormwatchplayerspawn();
  }
}

func_7FC4() {}

runvignettes() {
  thread introvignette_spawn_setup();
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
  thread func_7FB4();
}

introvignette_spawn_setup() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread introvignette_onplayerspawned();
  }
}

introvignette_onplayerspawned() {
  self endon("disconnect");
  level endon("game_ended");
  level endon("runBomberObjective");
  level endon("finished_intro_vignette_allies");
  for(;;) {
    self waittill("spawned_player");
    if(isDefined(level.var_54D0["allies"]) && isDefined(level.var_54D0["allies"].plane_array)) {
      var_00 = lib_0502::func_4627(game["attackers"]);
      var_01 = common_scripts\utility::func_F79(var_00, self);
      if(level.var_54D0["allies"].plane_array.size > 0) {
        foreach(var_03 in level.var_54D0["allies"].plane_array) {
          if(isDefined(var_03)) {
            if(var_01) {
              var_03 showtoclient(self);
              continue;
            }

            var_03 hidefromclient(self);
          }
        }
      }
    }
  }
}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_tunisia_allies_intro_player_01", "mp_raids_tunisia_allies_intro_player_02", "mp_raids_tunisia_allies_intro_player_03", "mp_raids_tunisia_allies_intro_player_04", "mp_raids_tunisia_allies_intro_player_05", "mp_raids_tunisia_allies_intro_player_06"];
  var_01 = ["mp_raids_tunisia_allies_intro_camera_01", "mp_raids_tunisia_allies_intro_camera_02", "mp_raids_tunisia_allies_intro_camera_03", "mp_raids_tunisia_allies_intro_camera_04", "mp_raids_tunisia_allies_intro_camera_06"];
  var_02 = [::func_0BF8, ::func_0BF9, ::func_0BFA, ::func_0BFB, ::func_0BFD];
  level.var_54D0["allies"].var_8F2 = "attackers";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_start", "targetname");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 25;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].forceavatarsweaponless = 1;
  level.var_54D0["allies"].bot_costume = [3, 3, 3, 3, 3, 3];
  level.var_54D0["allies"].showfullteam = 1;
  level.var_54D0["allies"].var_73E6 = ::func_54D4;
  level.var_54D0["allies"].var_6F27 = 1;
  level.var_54D0["allies"].var_1F06 = "genericprop_x3";
  level.var_54D0["allies"].var_1F08 = "j_prop_1";
  level.var_54D0["allies"].forceavatarsweaponless = 1;
  setDvar("5800", "6");
  setDvar("1512", "1");
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

  level.var_A4B5["intensity"] = 0.7;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(var_01) && isDefined(level.var_A4B5)) {
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        var_03 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_03 set_no_sand_visionset_lightset();
      }
    }
  }

  var_07 = [];
  var_07 = lib_0505::func_3187(var_07, 0.5, 1000, 8, 16, 0);
  var_07 = lib_0505::func_3187(var_07, 0.5, 2000, 8, 16, 3);
  thread lib_0505::func_3188(param_00, var_07);
  var_08 = % mp_raids_tunisia_allies_intro_camera_01;
  thread lib_0505::fovnotetracksaddtolistall(var_08, param_00);
  self method_8483("mp_raid_dlc3_allies_air");
  thread groundlights_off();
}

groundlights_off() {
  var_00 = function_021F("ground_lights_switch", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  var_04 = function_021F("ground_lights_switch2", "targetname");
  foreach(var_02 in var_04) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  var_07 = function_021F("ground_lights_switch3", "targetname");
  foreach(var_02 in var_07) {
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

func_0BF9(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 0.5, 1000, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = function_021F("plane_lights", "targetname");
  foreach(var_04 in var_02) {
    var_04 setscriptablepartstate("lightpart", "on");
  }

  var_06 = % mp_raids_tunisia_allies_intro_camera_02;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BFA(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 180, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc3_plane");
  var_02 = % mp_raids_tunisia_allies_intro_camera_03;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
  self method_8483("mp_raid_dlc3_allies_air_int");
}

func_0BFB(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1, 80, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_tunisia_allies_intro_camera_04;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_0BFC(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 5000, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc3");
  self method_8483("mp_raid_dlc3_allies_air");
}

func_0BFD(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 5000, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  self lightsetforplayer("mp_raid_dlc3");
  self method_8483("mp_raid_dlc3_allies_air");
  var_02 = function_021F("plane_lights", "targetname");
  foreach(var_04 in var_02) {
    var_04 setscriptablepartstate("lightpart", "off");
  }

  var_06 = % mp_raids_tunisia_allies_intro_camera_06;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

vignetteparatroopers(param_00, param_01, param_02, param_03, param_04) {
  if(1 && param_00 == param_01) {
    delete_vignette_weapons(param_00);
  }

  var_05 = param_00;
  var_06 = level.var_54D0[var_05].var_8F53.var_116;
  var_07 = level.var_54D0[var_05].var_8F53.var_1D;
  var_08 = spawn("script_model", var_06);
  var_08.var_1D = var_07;
  var_08 setModel("genericattacher32");
  var_08 animscripts\notetracks_common::give_player_xp(param_02, var_06, var_07);
  var_08 scriptmodelpauseanim(1);
  if(isDefined(param_04)) {
    level waittill(param_04);
  } else {
    wait 0.05;
  }

  var_09 = var_08.var_116;
  var_0A = [];
  for(var_0B = 1; var_0B <= 32; var_0B++) {
    var_0C = "TAG_ATTACH" + var_0B;
    var_0A[var_0B] = var_08 gettagorigin(var_0C);
  }

  var_08 delete();
  var_0D = [];
  var_0E = [];
  for(var_0B = 0; var_0B < 32; var_0B++) {
    var_0F = var_0A[var_0B + 1];
    if(var_09 == var_0F) {
      continue;
    }

    var_10 = undefined;
    var_11 = 1;
    if(var_0B < 6) {
      if(var_05 == param_01) {
        if(isDefined(level.var_54D0[var_05].var_8CA7) && isDefined(level.var_54D0[var_05].var_8CA7[var_0B]) && isDefined(level.var_54D0[var_05].var_8CA7[var_0B].var_13B3)) {
          var_10 = level.var_54D0[var_05].var_8CA7[var_0B].var_13B3;
          var_10 scriptmodelclearanim();
          if(isDefined(level.var_54D0[param_01].var_8CA7[var_0B].var_721C)) {
            var_10 setclientowner(level.var_54D0[param_01].var_8CA7[var_0B].var_721C);
          }

          var_11 = 0;
        }
      } else if(isDefined(level.var_54D0[param_01].var_8CA7) && isDefined(level.var_54D0[param_01].var_8CA7[var_0B]) && isDefined(level.var_54D0[param_01].var_8CA7[var_0B].var_721C)) {
        var_12 = level.var_54D0[param_01].var_8CA7[var_0B].var_721C;
        var_10 = spawn("script_model", var_0F);
        var_13 = var_12.var_1A7;
        if(common_scripts\utility::func_562E(level.var_9565) && game["switchedsides"]) {
          var_13 = maps\mp\_utility::func_45DE(var_12.var_1A7);
        }

        var_10 setcostumemodels(var_12.var_267E, var_13);
        var_11 = 0;
        var_10 setclientowner(var_12);
        var_0D[var_0D.size] = var_10;
      }
    }

    if(var_11) {
      var_10 = spawn("script_model", var_0F);
      var_14 = level.var_54D0[param_01].basecostume;
      if(!isDefined(var_14)) {
        var_14 = [1, 1, 1, 1, 1, 1];
      }

      var_10 setcostumemodels(var_14, param_01);
      var_0D[var_0D.size] = var_10;
    }

    if(isDefined(var_10)) {
      var_15 = 1;
      var_10.var_1A7 = param_01;
      var_10.var_116 = var_0F;
      var_10.var_1D = (0, randomfloatrange(-45, 45), 0);
      var_10.no_fx = 1;
      var_16 = bulletTrace(var_10.var_116, var_10.var_116 - (0, 0, 3000), 0, undefined, 0);
      var_17 = var_16["position"];
      var_10.parachute_idle_starttime = randomfloat(level.paratrooper_chute_loop_anim_duration[var_15] * 0.8);
      var_10 thread maps\mp\killstreaks\_paratroopers::do_paratrooper_drop(var_15, var_17[2], param_03, 1);
      var_0E[var_0E.size] = var_10.var_6E4F;
      var_18 = var_05;
      if(game["switchedsides"]) {
        var_18 = maps\mp\_utility::func_45DE(var_05);
      }

      var_10 lib_0502::func_8C21(var_18);
      var_10.var_6E4F thread lib_0502::func_8C21(var_18);
    }
  }

  level.var_54D0[param_00].nonavatar_paratroopers_array = var_0D;
  level.var_54D0[param_00].parachute_models = var_0E;
}

vignetteparatrooperscleanup(param_00) {
  if(isDefined(level.var_54D0[param_00].nonavatar_paratroopers_array)) {
    foreach(var_02 in level.var_54D0[param_00].nonavatar_paratroopers_array) {
      if(isDefined(var_02)) {
        var_02 delete();
      }
    }

    foreach(var_05 in level.var_54D0[param_00].parachute_models) {
      if(isDefined(var_05)) {
        var_05 delete();
      }
    }
  }
}

play_animations_back_to_back(param_00, param_01, param_02, param_03) {
  animscripts\notetracks_common::give_player_xp(param_00, param_02, param_03, "plane_part_a");
  self waittillmatch("end", "plane_part_a");
  animscripts\notetracks_common::give_player_xp(param_01, param_02, param_03);
}

func_54D7() {
  activateclientexploder(27);
  var_00 = common_scripts\utility::func_46B5("anim_allies_start", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  lib_0378::func_8D74("aud_intro_start_sfx");
  var_03 = ["mp_raids_tunisia_allies_intro_plane_01_2", "mp_raids_tunisia_allies_intro_plane_02_2", "mp_raids_tunisia_allies_intro_plane_03_2", "mp_raids_tunisia_allies_intro_plane_04", "mp_raids_tunisia_allies_intro_plane_05"];
  var_04 = ["mp_raids_tunisia_allies_intro_plane_01", "mp_raids_tunisia_allies_intro_plane_02", "mp_raids_tunisia_allies_intro_plane_03", undefined, undefined];
  var_05 = [];
  var_06 = "usa_bomber_skytrain_01";
  foreach(var_0F, var_08 in var_03) {
    var_09 = spawn("script_model", var_01);
    var_09 setModel(var_06);
    var_0A = lib_0502::func_4627(game["defenders"], 1);
    foreach(var_0C in var_0A) {
      var_09 hidefromclient(var_0C);
    }

    var_05[var_05.size] = var_09;
    var_0E = var_04[var_0F];
    if(isDefined(var_0E)) {
      var_09 thread play_animations_back_to_back(var_08, var_0E, var_01, var_02);
      continue;
    }

    var_09 animscripts\notetracks_common::give_player_xp(var_08, var_01, var_02);
  }

  var_10 = spawn("script_model", var_01);
  var_10 setcostumemodels([1, 1, 1, 1, 1, 1], "allies");
  var_10 animscripts\notetracks_common::give_player_xp("mp_raids_tunisia_allies_intro_npc", var_01, var_02);
  level.var_54D0["allies"].soldier = var_10;
  level.var_54D0["allies"].plane_array = var_05;
  var_11 = ["mp_raids_tunisia_allies_intro_static_line_01", "mp_raids_tunisia_allies_intro_static_line_02", "mp_raids_tunisia_allies_intro_static_line_03", "mp_raids_tunisia_allies_intro_static_line_04", "mp_raids_tunisia_allies_intro_static_line_05", "mp_raids_tunisia_allies_intro_static_line_06"];
  var_12 = "gen_human_parachute_static_line_01";
  var_13 = [];
  foreach(var_15 in var_11) {
    var_16 = spawn("script_model", var_01);
    var_16 setModel(var_12);
    var_13[var_13.size] = var_16;
    var_16 animscripts\notetracks_common::give_player_xp(var_15, var_01, var_02);
  }

  for(;;) {
    if(!isDefined(level.var_54D0["allies"].var_1F02) || level.var_54D0["allies"].var_1F02.camriganim == "mp_raids_tunisia_allies_intro_camera_04") {
      break;
    }

    wait 0.05;
  }

  thread vignetteparatroopers("allies", "allies", "mp_raids_tunisia_allies_intro_paratroopers", -7.5, "allies_vignette_paratroopers");
  level.var_54D0["allies"].var_1F02 waittillmatch("end", "camRig");
  level notify("allies_vignette_paratroopers");
  level.var_54D0["allies"].soldier delete();
  level.var_54D0["allies"].plane_array = common_scripts\utility::func_FA0(level.var_54D0["allies"].plane_array);
  common_scripts\utility::func_F71(level.var_54D0["allies"].plane_array, ::delete);
  level.var_54D0["allies"].soldier = undefined;
  level.var_54D0["allies"].plane_array = undefined;
  level.var_54D0["allies"].static_line_array = var_13;
}

func_54D4(param_00) {
  lib_0378::func_8D74("aud_intro_allies_mixing");
}

func_54D3() {
  if(isDefined(level.var_54D0["allies"].soldier)) {
    level.var_54D0["allies"].soldier delete();
  }

  if(isDefined(level.var_54D0["allies"].plane_array)) {
    common_scripts\utility::func_F71(level.var_54D0["allies"].plane_array, ::delete);
  }

  if(isDefined(level.var_54D0["allies"].static_line_array)) {
    common_scripts\utility::func_F71(level.var_54D0["allies"].static_line_array, ::delete);
  }

  vignetteparatrooperscleanup("allies");
  var_00 = lib_0502::func_4627(game["attackers"]);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      if(isalive(var_02)) {
        var_02 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_02 setscriptmotionblurparams(0.35, 0, 0);
        var_02 set_no_sand_visionset_lightset();
        var_02 lightsetforplayer("mp_raid_dlc3");
        var_02 method_8483("mp_raid_dlc3");
      }
    }
  }

  var_04 = function_021F("ground_lights_switch", "targetname");
  foreach(var_06 in var_04) {
    var_06 setscriptablepartstate("lightpart", "on");
  }

  var_08 = function_021F("ground_lights_switch2", "targetname");
  foreach(var_06 in var_08) {
    var_06 setscriptablepartstate("lightpart", "on");
  }

  var_0B = function_021F("ground_lights_switch3", "targetname");
  foreach(var_06 in var_0B) {
    var_06 setscriptablepartstate("lightpart", "on");
  }

  setDvar("5800", "0");
  setDvar("1512", "0");
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_tunisia_axis_intro_player_01", "mp_tunisia_axis_intro_player_02", "mp_tunisia_axis_intro_player_03", "mp_tunisia_axis_intro_player_04", "mp_tunisia_axis_intro_player_05", "mp_tunisia_axis_intro_player_06"];
  var_01 = ["mp_tunisia_axis_intro_cam_01", "mp_tunisia_axis_intro_cam_02", "mp_tunisia_axis_intro_cam_03", "mp_tunisia_axis_intro_cam_04", "mp_tunisia_axis_intro_cam_05"];
  var_02 = [::func_147F, ::func_1480, ::func_1481, ::func_1482, ::func_1483, ::axisintrocam06func];
  level.var_54D0["axis"].var_8F2 = "defenders";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_loc_axis_intro", "targetname");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 14;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].showfullteam = 1;
  level.var_54D0["axis"].bot_costume = [34, 34, 34, 34, 34, 34];
  level.var_54D0["axis"].var_92D5 = ::func_54E1;
  level.var_54D0["axis"].var_73E6 = ::func_54DC;
  level.var_54D0["axis"].var_2381 = ::func_54D9;
  level.var_54D0["axis"].var_13B7 = ::func_54D8;
  setDvar("5800", "6");
  setDvar("1512", "1");
}

func_54E1() {
  thread axisintropropsanimate();
  for(;;) {
    if(!isDefined(level.var_54D0["axis"].var_1F02) || level.var_54D0["axis"].var_1F02.camriganim == "mp_tunisia_axis_intro_cam_03") {
      break;
    }

    wait 0.05;
  }

  thread vignetteparatroopers("axis", "allies", "mp_tunisia_axis_intro_parachutes", -7.5, "axis_vignette_paratroopers");
  level.var_54D0["axis"].var_1F02 waittillmatch("end", "camRig");
  level notify("axis_vignette_paratroopers");
}

func_54DC(param_00) {
  lib_0378::func_8D74("aud_intro_axis_mixing");
}

func_147F(param_00) {
  var_01 = lib_0502::func_4627(game["defenders"]);
  if(isDefined(var_01)) {
    foreach(var_03 in level.var_744A) {
      if(isalive(var_03)) {
        var_03 setscriptmotionblurparams(2, 1, 1);
      }
    }
  }

  level.var_A4B5["intensity"] = 0.7;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        var_03 set_no_sand_visionset_lightset();
      }
    }
  }

  var_07 = [];
  var_07 = lib_0505::func_3187(var_07, 0.25, 1000, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_07);
  var_08 = % mp_tunisia_axis_intro_cam_01;
  thread lib_0505::fovnotetracksaddtolistall(var_08, param_00);
}

func_1480(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 200, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_tunisia_axis_intro_cam_02;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1481(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 40, 16, 32, 0);
  var_01 = lib_0505::func_3187(var_01, 5, 35, 16, 32, 2.5);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_tunisia_axis_intro_cam_03;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1482(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 4200, 16, 32, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_tunisia_axis_intro_cam_04;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1483(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 250, 16, 32, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_tunisia_axis_intro_cam_05;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

axisintrocam06func(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 5, 250, 16, 32, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_tunisia_axis_intro_cam_05;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_54D8(param_00, param_01) {
  if(param_00 == 5) {
    level.notebook_dudebro = self;
  }
}

axisintropropsanimate() {
  var_00 = lib_0502::func_4627(game["defenders"]);
  var_01 = spawn("script_origin", level.var_54D0["axis"].var_8F53.var_116);
  var_01.var_1D = level.var_54D0["axis"].var_8F53.var_1D;
  var_02 = [];
  var_03 = spawn("script_model", (0, 0, 0));
  var_03 setModel("tun_soccer_ball_01");
  var_03 method_8495("mp_tunisia_axis_intro_soccer_ball", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_03;
  var_04 = spawn("script_model", (0, 0, 0));
  var_04 setModel("tun_card_deck_01");
  var_04 method_8495("mp_tunisia_axis_intro_cards_deck", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_04;
  var_05 = spawn("script_model", (0, 0, 0));
  var_05 setModel("tun_card_hand_01");
  var_05 method_8495("mp_tunisia_axis_intro_cards_hand_01", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_05;
  var_06 = spawn("script_model", (0, 0, 0));
  var_06 setModel("tun_card_hand_01");
  var_06 method_8495("mp_tunisia_axis_intro_cards_hand_02", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_06;
  var_07 = spawn("script_model", (0, 0, 0));
  var_07 setModel("tun_card_hand_01");
  var_07 method_8495("mp_tunisia_axis_intro_cards_hand_03", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_07;
  var_08 = spawn("script_model", (0, 0, 0));
  var_08 setModel("tun_ammo_crate_01");
  var_08 method_8495("mp_tunisia_axis_intro_seat_03", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_08;
  var_09 = spawn("script_model", (0, 0, 0));
  var_09 setModel("tun_crate_wooden_01");
  var_09 method_8495("mp_tunisia_axis_intro_seat_01", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_09;
  var_0A = spawn("script_model", (0, 0, 0));
  var_0A setModel("tun_crate_wooden_01");
  var_0A method_8495("mp_tunisia_axis_intro_seat_02", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_0A;
  var_0B = spawn("script_model", (0, 0, 0));
  var_0B setModel("tun_crate_wooden_01");
  var_0B method_8495("mp_tunisia_axis_intro_seat_04", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_0B;
  var_0C = spawn("script_model", (0, 0, 0));
  var_0C setModel("tun_crate_wooden_01");
  var_0C method_8495("mp_tunisia_axis_intro_table", var_01.var_116, var_01.var_1D);
  var_02[var_02.size] = var_0C;
  var_0D = spawn("script_model", level.notebook_dudebro gettagorigin("TAG_WEAPON_LEFT"));
  var_0D setModel("tun_book_01");
  var_0D.var_1D = level.notebook_dudebro gettagangles("TAG_WEAPON_LEFT");
  var_0D method_8449(level.notebook_dudebro, "TAG_WEAPON_LEFT");
  var_02[var_02.size] = var_0D;
  var_0E = spawn("script_model", level.notebook_dudebro gettagorigin("TAG_INHAND"));
  var_0E setModel("tun_pencil_01");
  var_0E.var_1D = level.notebook_dudebro gettagangles("TAG_INHAND");
  var_0E method_8449(level.notebook_dudebro, "TAG_INHAND");
  var_02[var_02.size] = var_0E;
  level.axis_intro_props = var_02;
}

func_54D9() {
  vignetteparatrooperscleanup("axis");
  var_00 = lib_0502::func_4627(game["defenders"]);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  if(isDefined(var_00)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        var_02 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_02 setscriptmotionblurparams(0.35, 0, 0);
        var_02 set_no_sand_visionset_lightset();
      }
    }
  }

  foreach(var_05 in level.axis_intro_props) {
    var_05 delete();
  }

  setDvar("5800", "0");
  setDvar("1512", "0");
}

func_7FB4() {
  thread vistatankvignettes();
}

vistatankvignettes() {
  function_01DF("usa_tank_sherman_mp");
  wait(5);
  maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  var_00 = getent("sherman_tank_vista01", "targetname");
  var_01 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_01 setCanDamage(0);
  var_01 lib_0378::func_8D74("aud_npc_tank_enter");
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_02 method_8449(var_01, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_00 = getent("sherman_tank_vista02", "targetname");
  var_03 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_03 setCanDamage(0);
  var_03 lib_0378::func_8D74("aud_npc_tank_enter");
  var_02 = spawn("script_model", var_03.var_116);
  var_02 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_02 method_8449(var_03, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_00 = getent("sherman_tank_vista03", "targetname");
  var_04 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_04 setCanDamage(0);
  var_04 lib_0378::func_8D74("aud_npc_tank_enter");
  var_02 = spawn("script_model", var_04.var_116);
  var_02 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_02 method_8449(var_04, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_00 = getent("sherman_tank_vista04", "targetname");
  var_05 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_05 setCanDamage(0);
  var_05 lib_0378::func_8D74("aud_npc_tank_enter");
  var_02 = spawn("script_model", var_05.var_116);
  var_02 setModel("usa_tank_sherman_m1919_bucket_turret_mp");
  var_02 method_8449(var_05, "TAG_TURRET_ATTACH2", (0, 0, 0), (0, 0, 0));
  var_01 thread vistatankvignettestankmove("path01_start", 0, 27, "sherman01_target00", "objective_A_complete");
  var_03 thread vistatankvignettestankmove("path01b_start", 0, 31, "sherman01_target00", "objective_A_complete");
  var_04 thread vistatankvignettestankmove("path01c_start", 0, 42, "sherman01_target00", "objective_A_complete");
  var_05 vistatankvignettestankmove("path01d_start", 0, 42, "sherman01_target00", "objective_A_complete");
  var_01 thread vistatankvignettestankmove("path02_start", 0, 45, "sherman01_target01", "objective_B_complete");
  var_03 thread vistatankvignettestankmove("path02b_start", 18, 41, "sherman01_target01", "objective_B_complete");
  var_04 thread vistatankvignettestankmove("path02c_start", 10, 41, "sherman01_target01", "objective_B_complete");
  var_05 vistatankvignettestankmove("path02d_start", 26, 37, "sherman01_target01", "objective_B_complete");
  thread vistatankvignettesfinalobjective();
  var_01 thread vistatankvignettestankmove("path03_start", 0, 27, "sherman01_target02", "objective_C_complete");
  var_03 thread vistatankvignettestankmove("path03b_start", 16, 26, "sherman01_target02", "objective_C_complete");
  var_04 thread vistatankvignettestankmove("path03c_start", 7, 35, "sherman01_target03", "objective_C_complete");
  var_05 vistatankvignettestankmove("path03d_start", 13, 40, "sherman01_target03", "objective_C_complete");
}

vistatankvignettestankmove(param_00, param_01, param_02, param_03, param_04) {
  level endon(param_04);
  self method_825D();
  wait(param_01);
  var_05 = getvehiclenode(param_00, "targetname");
  self attachpath(var_05);
  self startpath(var_05);
  wait(param_02);
  var_06 = getent(param_03, "targetname");
  self method_825B(var_06.var_116);
  wait(3);
  for(;;) {
    self method_8263();
    wait(randomfloatrange(10, 15));
  }
}

vistatankvignettesfinalobjective() {
  level waittill("momentum_point_0_attackers");
  var_00 = getent("flag01_tank01", "targetname");
  var_01 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_01 setCanDamage(0);
  var_01 thread vistatankvignettestankmove(var_00.var_1A2, 0, 2, "sherman01_target03", "game_over");
  var_01 lib_0378::func_8D74("aud_npc_tank_enter");
  var_00 = getent("flag01_tank02", "targetname");
  var_02 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_02 setCanDamage(0);
  var_02 thread vistatankvignettestankmove(var_00.var_1A2, 3, 2, "sherman01_target03", "game_over");
  var_02 lib_0378::func_8D74("aud_npc_tank_enter");
  level waittill("momentum_point_1_attackers");
  var_00 = getent("flag02_tank01", "targetname");
  var_03 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_03 setCanDamage(0);
  var_03 thread vistatankvignettestankmove(var_00.var_1A2, 0, 2, "sherman01_target03", "game_over");
  var_03 lib_0378::func_8D74("aud_npc_tank_enter");
  level waittill("momentum_point_2_attackers");
  var_00 = getent("flag03_tank01", "targetname");
  var_04 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_04 setCanDamage(0);
  var_04 thread vistatankvignettestankmove(var_00.var_1A2, 0, 2, "sherman01_target04", "game_over");
  var_04 lib_0378::func_8D74("aud_npc_tank_enter");
  var_00 = getent("flag03_tank02", "targetname");
  var_05 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_05 setCanDamage(0);
  var_05 thread vistatankvignettestankmove(var_00.var_1A2, 8, 2, "sherman01_target05", "game_over");
  var_05 lib_0378::func_8D74("aud_npc_tank_enter");
  var_00 = getent("flag03_tank03", "targetname");
  var_06 = function_01E0(var_00.var_106, var_00.var_1A5, var_00.var_1C8, var_00.var_116, var_00.var_1D);
  var_06 setCanDamage(0);
  var_06 thread vistatankvignettestankmove(var_00.var_1A2, 4, 2, "sherman01_target05", "game_over");
  var_06 lib_0378::func_8D74("aud_npc_tank_enter");
}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_tunisia_allies_win_outro_camera_01"];
  var_01 = [::func_6C87];
  level.var_6C86["allies"].var_8F2 = "attackers";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("allies_win_outro", "targetname");
  level.var_6C86["allies"].var_8097 = 12;
  level.var_6C86["allies"].var_1F03 = var_00;
  level.var_6C86["allies"].var_1F05 = var_01;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
  level.var_6C86["allies"].var_1F06 = "genericprop_x3";
  level.var_6C86["allies"].var_1F08 = "j_prop_1";
}

func_6C87(param_00) {
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(isalive(var_02)) {
        var_02 setscriptmotionblurparams(0.5, 1, 1);
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
        var_02 set_no_sand_visionset_lightset();
      }
    }
  }

  var_06 = [];
  var_06 = lib_0505::func_3187(var_06, 6, 80, 2, 4, 0);
  var_06 = lib_0505::func_3187(var_06, 5, 250, 2, 4, 1.5);
  var_06 = lib_0505::func_3187(var_06, 2, 153, 2, 4, 5);
  thread lib_0505::func_3188(param_00, var_06);
  self method_8483("mp_raid_dlc3_allies_end");
  setDvar("5800", "6");
  setDvar("1512", "1");
}

func_6C88(param_00) {
  var_01 = [];
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C89(param_00) {
  var_01 = [];
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C8A(param_00) {
  var_01 = [];
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C8D() {
  lib_0378::func_8D74("aud_allies_victory_sfx");
  level.outrovignette_allies = spawnStruct();
  var_00 = common_scripts\utility::func_46B5("allies_win_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  var_03 = [];
  var_04 = ["mp_raids_tunisia_allies_win_outro_allies_02", "mp_raids_tunisia_allies_win_outro_allies_03"];
  var_05 = [];
  foreach(var_07 in var_04) {
    var_08 = "m1a1_mp";
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = function_0283();
    var_09.var_1A7 = "allies";
    var_09 setcostumemodels(var_09.var_267E, "allies");
    var_0A = spawn("weapon_" + var_08, (0, 0, 0), 1);
    var_0A linkto(var_09, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_03[var_03.size] = var_0A;
    var_09 animscripts\notetracks_common::give_player_xp(var_07, var_01, var_02);
    var_05[var_05.size] = var_09;
  }

  var_04 = ["mp_raids_tunisia_allies_win_outro_allies_01"];
  foreach(var_07 in var_04) {
    var_0D = "+bayonet_allies";
    var_08 = "m1a1_mp";
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = function_0283();
    var_09.var_1A7 = "allies";
    var_09 setcostumemodels(var_09.var_267E, "allies");
    var_0A = spawn("weapon_" + var_08 + var_0D, (0, 0, 0), 1);
    var_0A linkto(var_09, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_03[var_03.size] = var_0A;
    var_09 animscripts\notetracks_common::give_player_xp(var_07, var_01, var_02);
    var_05[var_05.size] = var_09;
  }

  var_0E = ["mp_raids_tunisia_allies_win_outro_axis_01", "mp_raids_tunisia_allies_win_outro_axis_02", "mp_raids_tunisia_allies_win_outro_axis_03"];
  var_0F = [];
  foreach(var_11 in var_0E) {
    var_08 = "stg44_mp";
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = function_0283();
    var_09.var_1A7 = "axis";
    var_09 setcostumemodels(var_09.var_267E, "axis");
    var_0A = spawn("weapon_" + var_08, (0, 0, 0), 1);
    var_0A linkto(var_09, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_03[var_03.size] = var_0A;
    var_09 animscripts\notetracks_common::give_player_xp(var_11, var_01, var_02);
    var_0F[var_0F.size] = var_09;
  }

  var_0E = ["mp_raids_tunisia_allies_win_outro_axis_04"];
  foreach(var_11 in var_0E) {
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = function_0283();
    var_09.var_1A7 = "axis";
    var_09 setcostumemodels(var_09.var_267E, "axis");
    var_09 animscripts\notetracks_common::give_player_xp(var_11, var_01, var_02);
    var_0F[var_0F.size] = var_09;
  }

  level.outrovignette_allies.ally_soldiers = var_05;
  level.outrovignette_allies.var_A9E7 = var_03;
  level.outrovignette_allies.axis_soldiers = var_0F;
}

func_6C8B() {
  var_00 = level.outrovignette_allies.ally_soldiers;
  var_01 = level.outrovignette_allies.var_A9E7;
  var_02 = level.outrovignette_allies.axis_soldiers;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  if(isDefined(level.var_744A)) {
    foreach(var_04 in level.var_744A) {
      if(isalive(var_04)) {
        var_04 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_04 setscriptmotionblurparams(0.35, 0, 0);
        var_04 set_no_sand_visionset_lightset();
      }
    }
  }

  setDvar("5800", "0");
  setDvar("1512", "0");
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_tunisia_axis_win_outro_camera_01"];
  var_01 = [::func_6C8E, ::func_6C8F, ::func_6C90, ::func_6C91];
  level.var_6C86["axis"].var_8F2 = "defenders";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("axis_win_outro", "targetname");
  level.var_6C86["axis"].var_8097 = 12;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
  level.var_6C86["axis"].var_1F06 = "genericprop_x3";
  level.var_6C86["axis"].var_1F08 = "j_prop_1";
  setDvar("5800", "6");
  setDvar("1512", "1");
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
        var_02 set_no_sand_visionset_lightset();
      }
    }
  }

  var_06 = [];
  var_06 = lib_0505::func_3187(var_06, 5.25, 340, 8, 16, 0);
  thread lib_0505::func_3188(param_00, var_06);
  wait 0.05;
  self method_8483("mp_raid_dlc3_allies_end");
}

func_6C8F(param_00) {
  var_01 = [];
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C90(param_00) {
  var_01 = [];
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C91(param_00) {
  var_01 = [];
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C94() {
  preoutrovignettecleanup();
  lib_0378::func_8D74("aud_axis_victory_sfx");
  var_00 = common_scripts\utility::func_46B5("axis_win_outro", "targetname");
  var_01 = var_00.var_116;
  var_02 = var_00.var_1D;
  if(!isDefined(var_02)) {
    var_02 = (0, 0, 0);
  }

  level.outrovignette_axis_ground = spawnStruct();
  var_03 = [];
  var_04 = [];
  var_05 = ["mp_raids_tunisia_axis_win_outro_allies_01", "mp_raids_tunisia_axis_win_outro_allies_02", "mp_raids_tunisia_axis_win_outro_allies_03", "mp_raids_tunisia_axis_win_outro_allies_04", "mp_raids_tunisia_axis_win_outro_allies_05", "mp_raids_tunisia_axis_win_outro_allies_06", "mp_raids_tunisia_axis_win_outro_allies_07", "mp_raids_tunisia_axis_win_outro_allies_08", "mp_raids_tunisia_axis_win_outro_allies_09", "mp_raids_tunisia_axis_win_outro_allies_10", "mp_raids_tunisia_axis_win_outro_allies_11", "mp_raids_tunisia_axis_win_outro_allies_12"];
  var_06 = lib_0502::func_4627(game["attackers"]);
  if(var_06.size > 0) {
    foreach(var_0A, var_08 in var_06) {
      var_09 = spawn("script_model", var_01);
      var_09.var_267E = var_08.var_267E;
      var_09.var_1A7 = "allies";
      var_09 setcostumemodels(var_09.var_267E, "allies");
      var_09 animscripts\notetracks_common::give_player_xp(var_05[var_0A], var_01, var_02);
      var_04[var_04.size] = var_09;
    }
  } else {
    var_09 = spawn("script_model", var_02);
    var_09.var_267E = [1, 1, 1, 1, 1, 1];
    var_09.var_1A7 = "allies";
    var_09 setcostumemodels(var_09.var_267E, "allies");
    var_09 animscripts\notetracks_common::give_player_xp("mp_raids_tunisia_axis_win_outro_allies_01", var_01, var_02);
    var_04[var_04.size] = var_09;
  }

  foreach(var_0C in var_05) {
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = [1, 1, 1, 1, 1, 1];
    var_09.var_1A7 = "allies";
    var_09 setcostumemodels(var_09.var_267E, "allies");
    var_09 animscripts\notetracks_common::give_player_xp(var_0C, var_01, var_02);
    var_04[var_04.size] = var_09;
  }

  var_0D = [];
  var_0E = ["mp_raids_tunisia_axis_win_outro_axis_02", "mp_raids_tunisia_axis_win_outro_axis_03", "mp_raids_tunisia_axis_win_outro_axis_04"];
  foreach(var_10 in var_0E) {
    var_11 = "stg44_mp";
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = [2, 1, 2, 2, 2, 0];
    var_09.var_1A7 = "axis";
    var_09 setcostumemodels(var_09.var_267E, "axis");
    var_09 animscripts\notetracks_common::give_player_xp(var_10, var_01, var_02);
    var_0D[var_0D.size] = var_09;
  }

  var_0E = ["mp_raids_tunisia_axis_win_outro_axis_01"];
  foreach(var_10 in var_0E) {
    var_11 = "stg44_mp";
    var_09 = spawn("script_model", var_01);
    var_09.var_267E = [4, 3, 3, 3, 0, 0];
    var_09.var_1A7 = "axis";
    var_09 setcostumemodels(var_09.var_267E, "axis");
    if(var_10 == "mp_raids_tunisia_axis_win_outro_axis_01") {}

    var_09 animscripts\notetracks_common::give_player_xp(var_10, var_01, var_02);
    var_0D[var_0D.size] = var_09;
  }

  var_13 = ["mp_raids_tunisia_axis_win_outro_axis_01_strap"];
  var_14 = "gen_human_parachute_static_line_thinner_01";
  var_15 = [];
  foreach(var_17 in var_13) {
    var_18 = spawn("script_model", var_01);
    var_18 setModel(var_14);
    var_15[var_15.size] = var_18;
    var_18 animscripts\notetracks_common::give_player_xp(var_17, var_01, var_02);
  }

  level.outrovignette_axis_ground.axis_soldiers = var_0D;
  level.outrovignette_axis_ground.var_A9E7 = var_03;
  level.outrovignette_axis_ground.ally_soldiers = var_04;
  level.outrovignette_axis_ground.staic_line_array = var_15;
}

func_6C92() {
  var_00 = level.outrovignette_axis_ground.axis_soldiers;
  var_01 = level.outrovignette_axis_ground.var_A9E7;
  var_02 = level.outrovignette_axis_ground.ally_soldiers;
  var_03 = level.outrovignette_axis_ground.staic_line_array;
  common_scripts\utility::func_F71(var_00, ::delete);
  common_scripts\utility::func_F71(var_01, ::delete);
  common_scripts\utility::func_F71(var_02, ::delete);
  common_scripts\utility::func_F71(var_03, ::delete);
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_05 in level.var_744A) {
      if(isalive(var_05)) {
        var_05 setscriptmotionblurparams(0.35, 0, 0);
        var_05 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_05 set_no_sand_visionset_lightset();
      }
    }
  }

  setDvar("5800", "0");
  setDvar("1512", "0");
}

func_7F7D() {}

func_7FCF() {
  level endon("game_ended");
  setgamespawnpointactivelabel("A", "A", "A");
  level waittill("objective_A_complete");
  lib_0502::func_90A4("X", "X");
  thread func_8B04();
  level waittill("objective_B_complete");
  lib_0502::func_90A4("Z", "Z");
  thread shiftdefenderspawnsobj3();
  level waittill("momentum_point_0_attackers");
  lib_0502::func_90A4("D", "D");
  level waittill("momentum_point_1_attackers");
  lib_0502::func_90A4("E", "E");
  level waittill("momentum_point_2_attackers");
  lib_0502::func_90A4("F", "F");
}

func_8B04() {
  wait(0.1);
  level endon("objectiveComplete");
  maps\mp\gametypes\_hostmigration::func_A6F5(20);
  level thread lib_0502::func_90A4("Y", "Y");
}

shiftdefenderspawnsobj3() {
  wait(0.1);
  level endon("objectiveComplete");
  maps\mp\gametypes\_hostmigration::func_A6F5(30);
  level thread lib_0502::func_90A4("C", "C");
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
  level waittill("objective_A_complete");
  lib_04F4::func_863D("axis_A", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
  level thread lib_04F4::func_9C77("allies_B", 20);
  level waittill("objective_B_complete");
  lib_04F4::func_863D("axis_B", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C", "axis_C"]);
  level thread lib_04F4::func_9C77("allies_C", 30);
  level waittill("momentum_point_0_attackers");
  lib_04F4::func_863D("axis_C", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_D", "axis_D"]);
  level thread lib_04F4::func_9C77("allies_D", 20);
  level waittill("momentum_point_1_attackers");
  lib_04F4::func_863D("axis_D", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_E", "axis_E"]);
  level thread lib_04F4::func_9C77("allies_E", 20);
  level waittill("momentum_point_2_attackers");
  lib_04F4::func_863D("axis_E", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_F", "axis_F"]);
  level thread lib_04F4::func_9C77("allies_F", 20);
}

func_7FB5() {}

func_7FDB() {}

func_7FC0() {
  level endon("game_ended");
  maps\mp\killstreaks\_paratroopers::func_D5();
  thread removebridgedebris();
  waittillframeend;
  runsecuresupplies();
  lib_0502::func_7B35();
  runbombplant();
  lib_0502::func_7B35();
  runflagsraise();
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

removebridgedebris() {
  var_00 = getEntArray("bomb_model", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.storeddata = spawnStruct();
    if(isDefined(var_02.var_81EF)) {
      var_03 = getEntArray(var_02.var_81EF, "script_linkname");
      foreach(var_05 in var_03) {
        if(isDefined(var_05.var_165)) {
          if(var_05.var_165 == "bridge_destroyed_clip") {
            if(!isDefined(var_02.storeddata.clipdestruction)) {
              var_02.storeddata.clipdestruction = [];
            }

            var_06 = var_05;
            var_06.var_8066 = var_06.var_116 + (0, 0, 2000);
            var_06.hurttrigger = getent(var_06.var_1A2, "targetname");
            var_02.storeddata.clipdestruction[var_02.storeddata.clipdestruction.size] = var_06;
            continue;
          }

          if(var_05.var_165 == "bomb_mesh") {
            var_02.storeddata.mesh = var_05;
            continue;
          }

          if(var_05.var_165 == "animated_model") {
            var_02.storeddata.animatedmodel = var_05;
            continue;
          }

          if(var_05.var_165 == "bomb_clip") {
            var_02.storeddata.var_241F = var_05;
            var_02.storeddata.debrisarray = getEntArray(var_02.storeddata.var_241F.var_1A2, "targetname");
            foreach(var_08 in var_02.storeddata.debrisarray) {
              var_08.var_8066 = var_08.var_116;
              var_08 method_808C();
              var_08.var_116 = var_08.var_116 + (0, 0, -80);
              var_08 method_805C();
            }
          }
        }
      }
    }
  }

  level notify("connect_bridge_debris_paths");
}

handlebridgedebrispaths() {
  level waittill("connect_bridge_debris_paths");
  wait(0.25);
  var_00 = getent("bridge_nodes_connect_clip", "targetname");
  var_00.var_116 = var_00.var_116 + (0, 0, 1024);
  wait(0.25);
  var_00 method_8060();
  wait(0.25);
  var_00 delete();
}

runsecuresupplies() {
  thread maps\mp\killstreaks\_paratroopers::player_paratroopers_spawn_after_raidvignette("allies");
  var_00 = "secure_supplies";
  lib_04FF::func_6972(var_00);
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 3);
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_0502::func_86DE(lib_0501::func_4647("capture_objectiveTime"), 1);
  lib_04FF::func_6982(var_00);
  level thread lib_0500::func_1E85(game["defenders"], 15, "bomb_plant");
  level notify("objective_A_complete");
}

runbombplant() {
  if(isDefined(level.droppedcratearray)) {
    wait 0.05;
    foreach(var_01 in level.droppedcratearray) {
      var_01 maps\mp\gametypes\_raid_objective_securedrops::func_2D30(0, 0, 0);
    }
  }

  wait 0.05;
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 4);
  level.bomb_entries = [];
  lib_04FF::func_6972("bomb_plant");
  lib_0502::func_86DE(lib_0501::func_4647("multibomb_objectiveTime"), 2);
  lib_04FF::func_6982("bomb_plant");
  foreach(var_04 in level.bomb_entries) {
    var_04 lib_04FF::func_7CCA();
  }

  level.bomb_entries = undefined;
  level thread lib_0500::func_1E85(game["defenders"], 15, "capture_flags");
  lib_0502::func_697A("bomb_plant");
  level notify("objective_B_complete");
}

onbombexplode(param_00) {
  thread delayedextratime();
  thread addbridgedebris(param_00);
}

delayedextratime() {
  waittillframeend;
  if(!level.var_3C77["raid_obj_complete_bomb_01"] && level.var_3C77["raid_obj_complete_bomb_02"] && level.var_3C77["raid_obj_complete_bomb_03"] && level.var_3C77["raid_obj_complete_bomb_04"]) {
    level thread lib_0502::addtoobjectivetimelimit(lib_0501::func_4647("multibomb_objectiveAddTime"), 2);
    foreach(var_01 in level.var_744A) {
      var_01 thread maps\mp\gametypes\_hud_message::func_9102("raids_extratime");
    }
  }
}

killbombdwalls(param_00, param_01, param_02, param_03) {
  wait(param_03);
  var_04 = param_01 * param_01;
  var_05 = lib_04F7::func_440F();
  foreach(var_07 in var_05) {
    var_08 = distancesquared(param_00, var_07.var_116);
    if(var_08 < var_04) {
      var_09 = var_07 lib_0502::func_207E("explosive_trigger");
      if(isDefined(var_09)) {
        var_0A = var_09 lib_0502::func_207E("explosive_model");
        if((var_07.var_2599 || var_07.var_5708) && isDefined(var_0A)) {
          var_0A thread lib_04F7::func_7A01(param_02, "bomb_site_mp", "MOD_EXPLOSIVE", 10000, 1);
        }
      }
    }
  }
}

addbridgedebris(param_00) {
  var_01 = 1.1;
  if(isDefined(param_00.var_982D["trigger"][0].var_982D["bomb_model"][0])) {
    var_02 = param_00.var_982D["trigger"][0].var_982D["bomb_model"][0];
    var_03 = var_02.storeddata;
    var_03.bomborigin = var_02.var_116;
    var_03.var_241F delete();
    var_03.mesh delete();
    if(param_00.var_695A == "bomb_01") {
      level thread common_scripts\_exploder::func_88E(9);
      lib_0378::func_8D74("aud_bridge_bomb_B_exp", var_01);
    } else if(param_00.var_695A == "bomb_02") {
      level thread common_scripts\_exploder::func_88E(11);
      thread killbombdwalls(var_02.var_116, 100, undefined, var_01);
      lib_0378::func_8D74("aud_bridge_bomb_D_exp", var_01);
    } else if(param_00.var_695A == "bomb_03") {
      level thread common_scripts\_exploder::func_88E(8);
      lib_0378::func_8D74("aud_bridge_bomb_A_exp", var_01);
    } else if(param_00.var_695A == "bomb_04") {
      level thread common_scripts\_exploder::func_88E(10);
      lib_0378::func_8D74("aud_bridge_bomb_C_exp", var_01);
    }

    wait(var_01);
    earthquake(0.7, 1, param_00.var_116, 2000);
    var_03.animatedmodel method_8278(var_03.animatedmodel.var_EA4, "bridge_debris");
    var_03.animatedmodel thread animscripts\notetracks_common::func_3222(undefined, "bridge_debris", ::waitforbridgenote, undefined, undefined, var_03);
  }
}

waitforbridgenote(param_00, param_01) {
  level endon("game_ended");
  var_02 = param_01;
  var_03 = self;
  var_04 = undefined;
  if(param_00 == "impact_1_b_1" || param_00 == "impact_2_b_3") {
    foreach(var_06 in var_02.debrisarray) {
      var_06 method_805B();
      var_06.var_A046 = 1;
      var_06 moveto(var_06.var_8066, 0.25, 0, 0.1);
      if(!isDefined(var_04) && isDefined(var_06.var_1A2)) {
        var_04 = getent(var_06.var_1A2, "targetname");
      }
    }
  }

  if(isDefined(var_04)) {
    var_04 thread triggerkillplayers(1, 3, 0.75);
  }

  if(param_00 == "impact_1_a_5" || param_00 == "impact_2_b_5") {
    thread stopdebriskill(var_02);
  }

  foreach(var_09 in var_02.clipdestruction) {
    if(var_09.var_8260 == param_00) {
      var_09.var_A046 = 1;
      var_09 method_808C();
      var_09.var_116 = var_09.var_8066;
      var_09 common_scripts\utility::func_2CBE(0.05, ::method_805F, 1);
      var_09.hurttrigger method_808C();
      var_09.hurttrigger.var_116 = var_09.hurttrigger.var_116 + (0, 0, 2000);
      var_09.hurttrigger thread triggerkillplayers(1.5, 3, 0);
      thread removeclipkill(var_09);
    }
  }
}

triggerkillplayers(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = 0.05;
  var_05 = int(exp(param_00 / param_01 * var_04));
  wait(param_02);
  for(var_06 = 0; var_06 < var_05; var_06++) {
    foreach(var_08 in level.var_744A) {
      if(isDefined(var_08) && !function_0279(var_08) && isalive(var_08) && var_08 istouching(var_03)) {
        var_08 dodamage(var_08.var_BC + 1000, var_08.var_116, undefined, var_03, "MOD_CRUSH", undefined, undefined);
      }
    }

    wait(param_01 * var_04);
  }
}

removeclipkill(param_00) {
  wait(1);
  param_00.var_A046 = 0;
}

stopdebriskill(param_00) {
  wait(1);
  foreach(var_02 in param_00.debrisarray) {
    var_02.var_A046 = 0;
  }
}

turret_build_armored_train(param_00, param_01, param_02, param_03) {
  var_04 = spawnturret("misc_turret", self.var_116, param_00);
  var_04.var_1D = self.var_1D;
  var_04 setModel(param_01);
  var_04 setdefaultdroppitchyaw(0);
  var_04 setmode("sentry_manual");
  var_04 setCanDamage(0);
  var_04 method_80F9(undefined);
  var_04 method_80FB(0);
  var_04 method_8131();
  var_04 makeunusable();
  var_04 method_8130(game["defenders"]);
  var_04 setentityowner(var_04);
  var_04 turretdontresetanglesonexitornotarget(1);
  if(isDefined(param_02)) {
    var_04.var_62AD = param_02;
  }

  if(isDefined(param_03)) {
    var_04.var_6B73 = param_03;
  }

  return var_04;
}

armoredtrainsetup() {
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = getent("armored_train", "targetname");
  var_01 = getent("train_engine_01", "targetname");
  var_01.var_EA4 = "mp_raids_tun_train_01";
  var_00.train_engine = var_01;
  var_02 = getEntArray("armored_train_turret", "targetname");
  var_03 = getEntArray("armored_train_turret_towers", "targetname");
  level.train_turret_target = [];
  var_00.var_9F96 = [];
  var_00.towers = [];
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = ["turretweapon_tank_panzer_cannon_mp_right", "turretweapon_tank_panzer_cannon_mp_left"];
    var_06 = var_02[var_04];
    var_07 = var_06 turret_build_armored_train(var_05[var_04], "ger_tra_panzerzug_61_bp42_base_01_turret_desert_camo", undefined, undefined);
    var_07 thread turretthink(var_00, var_04);
    var_07 method_8449(var_00);
    var_00.var_9F96[var_00.var_9F96.size] = var_07;
    var_06 delete();
  }

  foreach(var_09 in var_03) {
    var_09 linkto(var_00);
    var_00.towers[var_00.towers.size] = var_09;
  }

  var_01 linkto(var_00);
  var_00 thread traincleanup();
  var_00 armoredtrainthink();
}

traincleanup() {
  level endon("game_ended");
  self waittill("Armored_Train_Cleanup");
  self.train_engine delete();
  foreach(var_01 in self.var_9F96) {
    var_01 delete();
  }

  foreach(var_04 in self.towers) {
    var_04 delete();
  }

  self delete();
}

turretdiscovertarget(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("Armored_Train_Inactive");
  var_02 = (-335, 3775, 500);
  var_03 = getent("tank_targets", "targetname");
  var_04 = 0;
  if(param_01 == 0) {
    var_04 = 1;
  }

  for(;;) {
    var_05 = undefined;
    var_06 = 9999999;
    foreach(var_08 in level.var_744A) {
      if(!isDefined(level.train_turret_target[var_04]) || level.train_turret_target[var_04] != var_08) {
        if(var_08.var_1A7 == game["attackers"]) {
          var_09 = distance2dsquared(var_02, var_08.var_116);
          if(var_09 < var_06) {
            var_0A = self gettagorigin("tag_flash");
            if(turretcanseetarget(var_08, var_0A, var_03, param_00)) {
              var_05 = var_08;
              var_06 = var_09;
            }
          }
        }
      }
    }

    if(!isDefined(var_05) && isDefined(level.train_turret_target[var_04])) {
      var_08 = level.train_turret_target[var_04];
      var_0A = self gettagorigin("tag_flash");
      if(turretcanseetarget(var_08, var_0A, var_03, param_00)) {
        var_05 = var_08;
      }
    }

    if(isDefined(var_05)) {
      self setturrettargetentity(var_05, (0, 0, 0), 1, 0);
      level.train_turret_target[param_01] = var_05;
      wait(2.5);
      continue;
    }

    self clearturrettargetentity();
    wait(0.25);
  }
}

turretfoldintotunnel(param_00) {
  level endon("game_ended");
  param_00 endon("Armored_Train_Cleanup");
  param_00 waittill("Armored_Train_Inactive");
  self clearturrettargetentity();
  self method_8150(115);
  for(;;) {
    var_01 = self gettagorigin("tag_turret");
    var_02 = var_01 + (-1000, 1700, 100);
    self setturrettargetorigin(var_02);
    wait 0.05;
  }
}

turretcanseetarget(param_00, param_01, param_02, param_03) {
  if(param_00 istouching(param_02)) {
    var_04 = bulletTrace(param_01, param_00.var_116 + (0, 0, 48), 0, param_03);
    if(var_04["fraction"] == 1) {
      return 1;
    }
  }

  return 0;
}

turretshoottarget(param_00) {
  level endon("game_ended");
  param_00 endon("Armored_Train_Inactive");
  for(;;) {
    while(!turretaimedatenemy()) {
      wait 0.05;
    }

    self method_80E1();
    wait(randomfloatrange(1.3, 2.3));
  }
}

turretaimedatenemy() {
  return isDefined(self getturrettargetent()) && targetwithinturretangles();
}

targetwithinturretangles() {
  var_00 = self gettagorigin("tag_aim");
  var_01 = self gettagangles("tag_aim");
  var_02 = self getturrettargetent();
  var_03 = var_02.var_116;
  var_04 = vectornormalize(var_03 - var_00);
  var_05 = anglesToForward(var_01);
  var_06 = vectordot(var_05, var_04);
  return var_06 >= 0.995;
}

setupkillcam(param_00) {
  level endon("game_ended");
  param_00 endon("Armored_Train_Inactive");
  var_01 = spawn("script_model", (0, 0, 0));
  var_01 setModel("tag_origin");
  var_01 linkto(self, "tag_flash", (-225, 0, 40), (5, 0, 0));
  var_01 setscriptmoverkillcam("script_entity");
  self.var_5A2C = var_01;
  var_01 thread cleanupkillcam(param_00);
  for(;;) {
    self waittill("turret_fire", var_02);
    var_02[0].var_5A2C = self.var_5A2C;
    self.var_5A2C.var_5A32 = gettime() - 5000;
  }
}

cleanupkillcam(param_00) {
  level endon("game_ended");
  param_00 waittill("Armored_Train_Inactive");
  self delete();
}

turretthink(param_00, param_01) {
  level waittill("objective_A_complete");
  thread setupkillcam(param_00);
  thread turretdiscovertarget(param_00, param_01);
  thread turretshoottarget(param_00);
  thread turretfoldintotunnel(param_00);
}

armoredtrainthink() {
  var_00 = -5500;
  level waittill("objective_A_complete");
  lib_0378::func_8D74("aud_train_start_moving");
  wait(5);
  self moveto(self.var_116 + anglesToForward(self.var_1D) * var_00, 25, 4);
  self.train_engine scriptmodelplayanim(self.train_engine.var_EA4);
  wait(13);
  self notify("Armored_Train_Inactive");
  wait(12);
  self notify("Armored_Train_Cleanup");
}

runflagsraise() {
  lib_04FF::func_6972("capture_flags");
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  lib_0502::func_86DE(lib_0501::func_4647("flags_objectiveTime"), 3);
  level notify("runBunkerCapture");
  level.bunkersobjectiveactive = 1;
  level.bots_build_walls_radius = 2000;
  var_00 = lib_0502::func_6514();
  lib_04FF::func_6982("capture_flags");
  level.bots_build_walls_radius = undefined;
  lib_0502::func_697A("capture_flags");
  level notify("bunkers_done");
}

onflagcap() {
  thread delayedaddflagtime();
}

delayedaddflagtime() {
  waittillframeend;
  if(self.var_62C7.var_292D != 4) {
    level thread lib_0502::addtoobjectivetimelimit(lib_0501::func_4647("flags_addTime"), 3);
    foreach(var_01 in level.var_744A) {
      var_01 thread maps\mp\gametypes\_hud_message::func_9102("raids_extratime");
    }
  }
}

initbunkerturrets() {
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  var_00 = getEntArray("raid_tank_bunker", "targetname");
  foreach(var_02 in var_00) {
    var_02 sethintstring("Press and hold X to use turret");
    var_02.ownedturret = getent(var_02.var_1A2, "targetname");
    var_02 thread watchbunkerturretuse();
    if(isDefined(var_02.ownedturret)) {
      var_02.ownedturret setdamagecallbackon(1);
      var_02.ownedturret.var_29B5 = ::turret_damage_callback;
      var_02.ownedturret setCanDamage(1);
      var_02.ownedturret method_8131();
      var_02.ownedturret.var_BC = 4000;
      var_02.ownedturret.var_FB = 4000;
      if(isDefined(var_02.ownedturret.var_9D65)) {
        var_02.ownedturret.var_9D65.ownedturret = undefined;
      }

      var_02.ownedturret.var_9D65 = var_02;
      if(game["switchedsides"]) {
        var_02.ownedturret.var_1A7 = "allies";
      } else {
        var_02.ownedturret.var_1A7 = "axis";
      }

      var_02.ownedturret setdefaultdroppitch(0);
      thread lib_0504::func_7954(var_02.ownedturret);
    }
  }
}

watchbunkerturretuse() {
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_00);
    common_scripts\utility::func_9D9F();
    if(!isDefined(self.ownedturret)) {
      continue;
    }

    var_00 method_80DF(self.ownedturret);
    self.var_117 = var_00;
    self.ownedturret.var_1A7 = self.var_117.var_1A7;
    var_00 turret_mount_callback(self.ownedturret);
    var_00 watchdismountbunkerturret(self.ownedturret);
    var_00 turret_dismount_callback(self.ownedturret);
    self.ownedturret.var_1A7 = "axis";
    if(self.ownedturret.var_BC < 0) {
      waittillturretrepaired(self.ownedturret);
    }

    common_scripts\utility::func_9DA3();
  }
}

waittillturretrepaired(param_00) {
  level endon("game_ended");
  for(;;) {
    if(param_00.var_BC > 0) {
      break;
    } else {
      wait 0.05;
    }
  }
}

watchdismountbunkerturret(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  while(self useButtonPressed()) {
    if(param_00.var_BC <= 0) {
      return;
    }

    if(self.var_BC <= 0) {
      return;
    }

    wait 0.05;
  }

  for(;;) {
    if(param_00.var_BC <= 0) {
      return;
    }

    if(self.var_BC <= 0) {
      return;
    }

    if(self useButtonPressed()) {
      self method_80E0(param_00);
      param_00.var_117 = undefined;
      return;
    }

    wait 0.05;
  }
}

turret_damage_callback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = undefined;
  var_0D = self;
  var_0E = var_0D method_80E2();
  if(lib_0502::func_5845(param_01)) {
    var_0C = param_01 method_8251();
  } else if(lib_0504::func_5812(param_01)) {
    var_0C = param_01 method_80E2();
  }

  if(isDefined(var_0C)) {
    param_01 = var_0C;
  }

  if(issubstr(param_04, "BULLET")) {
    return;
  }

  if(issubstr(param_05, "bazooka") || issubstr(param_05, "panzerschreck")) {
    param_02 = param_02 * 0.3;
  } else if(issubstr(param_05, "launcher")) {
    param_02 = param_02 * 3.5;
  }

  if(!isDefined(var_0E) || param_01 != var_0E) {
    var_0F = "standard";
    param_01 maps\mp\gametypes\_damagefeedback::func_A102(var_0F);
  }

  var_0D.var_BC = var_0D.var_BC - int(param_02);
  if(isDefined(var_0E)) {
    var_10 = var_0D.var_BC / var_0D.var_FB;
    var_0E setclientomnvar("ui_raid_vehicle_health_percent", var_10);
  }

  lib_0503::bomber_healthbar_update(param_01, var_0D);
  if(var_0D.var_BC <= 0) {
    var_0D thread func_9EFF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
  }
}

func_9EFF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self notify("turret_destroyed");
  self setdefaultdroppitchyaw(0, 0);
  self makeunusable();
  self method_805C();
  self.var_9D65 common_scripts\utility::func_9D9F();
  self setCanDamage(0);
  self setdamagecallbackon(0);
  self.var_29B5 = undefined;
  self.var_566B = 0;
  var_0C = self method_80E2();
  if(isDefined(var_0C)) {
    var_0C method_80E0(self);
    var_0C method_85E9();
    if(1) {
      var_0C turret_dismount_callback(self);
      var_0C dodamage(99999, param_06, param_01, param_00, param_04, param_05, param_08);
    }
  }

  lib_04F3::func_79CF("mp_war_bomb_explo", self, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("turret_destruction"), self, "tag_origin");
}

turret_mount_callback(param_00) {
  self setclientdvar("ui_raid_hide_fighter", 0);
  param_00 setclientowner(self);
}

turret_dismount_callback(param_00) {
  if(isDefined(self)) {
    self setclientdvar("ui_raid_hide_fighter", 1);
  }

  param_00 setclientowner(undefined);
}

run_sandstorm() {
  level waittill("momentum_point_1_attackers");
  wait(randomintrange(15, 30));
  level.sandstorm = 1;
  lib_0378::func_8D74("aud_sandstorm_start");
  foreach(var_01 in level.var_744A) {
    var_01 set_exterior_sand_visionset_lightset(2);
    var_01.sand_int_on = 0;
  }

  thread sandstorm_palmtree_anims();
}

watch_sandstorm_trigger(param_00) {
  level endon("game_ended");
  while(self istouching(param_00)) {
    wait(0.1);
  }

  param_00 set_exterior_sand_visionset_lightset(2);
  param_00.sand_int_on = 0;
}

sandstormwatchplayerspawn() {
  level endon("game_ended");
  level endon("bunkers_done");
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    if(isDefined(level.bunkersobjectiveactive) && isDefined(level.sandstorm) && level.sandstorm == 1) {
      set_exterior_sand_visionset_lightset(0);
      self.sand_int_on = 0;
    }

    wait 0.05;
  }
}

preoutrovignettecleanup() {
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_01 in level.var_744A) {
      if(isalive(var_01)) {
        var_01 setscriptmotionblurparams(0.35, 0, 0);
        var_01 vignettesetparams(level.var_A4B5["intensity"], level.var_A4B5["falloff"], level.var_A4B5["scaleX"], level.var_A4B5["scaleY"], level.var_A4B5["squareAspectRatio"]);
        var_01 set_no_sand_visionset_lightset();
      }
    }
  }
}

set_no_sand_visionset_lightset(param_00) {}

set_exterior_sand_visionset_lightset(param_00) {}

run_palmtree_anims() {
  level.palmtrees_array = getEntArray("palm_tree_animated", "targetname");
  level.palmtree_anims_resting["default"] = "raiddlc3_palm_sandstorm_loop_weak";
  level.palmtree_anims_resting_mayaframes["default"] = 120;
  level.palmtree_anims_sandstorm_start["default"] = "raiddlc3_palm_sandstorm_loop";
  level.palmtree_anims_sandstorm_start_mayaframes["default"] = 35;
  level.palmtree_anims_sandstorm_loop["default"] = "raiddlc3_palm_sandstorm_loop";
  level.palmtree_anims_sandstorm_loop_mayaframes["default"] = 120;
  level.palmtree_anims_resting["wall"] = "raiddlc3_palm_sandstorm_loop_weak";
  level.palmtree_anims_resting_mayaframes["wall"] = 120;
  level.palmtree_anims_sandstorm_start["wall"] = "raiddlc3_palm_sandstorm_loop";
  level.palmtree_anims_sandstorm_start_mayaframes["wall"] = 35;
  level.palmtree_anims_sandstorm_loop["wall"] = "raiddlc3_palm_sandstorm_loop";
  level.palmtree_anims_sandstorm_loop_mayaframes["wall"] = 120;
  level.palmtrees_state = "init";
  thread resting_palmtree_anims();
}

get_palmtree_anim_and_duration(param_00) {
  var_01 = "default";
  if(isDefined(self.var_8260)) {
    var_01 = self.var_8260;
  }

  if(param_00 == "resting") {
    return [level.palmtree_anims_resting[var_01], level.palmtree_anims_resting_mayaframes[var_01] / 30];
  }

  if(param_00 == "sandstorm_start") {
    return [level.palmtree_anims_sandstorm_start[var_01], level.palmtree_anims_sandstorm_start_mayaframes[var_01] / 30];
  }

  if(param_00 == "sandstorm_loop") {
    return [level.palmtree_anims_sandstorm_loop[var_01], level.palmtree_anims_sandstorm_loop_mayaframes[var_01] / 30];
  }
}

resting_palmtree_anims() {
  if(level.palmtrees_state == "resting") {
    return;
  }

  level notify("kill_sandstorm_palmtree_anim_single");
  level.palmtrees_state = "resting";
  foreach(var_01 in level.palmtrees_array) {
    var_02 = var_01 get_palmtree_anim_and_duration("resting");
    var_03 = var_02[0];
    var_04 = var_02[1];
    var_05 = var_04 * randomfloatrange(0, 0.75);
    var_01 thread animscripts\notetracks_common::func_3222(undefined, "resting");
    var_01 scriptmodelplayanim(var_03, "resting", var_05);
  }
}

sandstorm_palmtree_anims() {
  if(level.palmtrees_state == "sandstorm") {
    return;
  }

  level notify("kill_sandstorm_palmtree_anim_single");
  level.palmtrees_state = "sandstorm";
  foreach(var_01 in level.palmtrees_array) {
    var_01 thread sandstorm_palmtree_anim_single(var_01);
  }
}

sandstorm_palmtree_anim_single(param_00) {
  level endon("kill_sandstorm_palmtree_anim_single");
  var_01 = param_00 get_palmtree_anim_and_duration("sandstorm_start");
  var_02 = var_01[0];
  var_03 = var_01[1];
  var_04 = var_03 * randomfloatrange(0, 0.75);
  param_00 scriptmodelplayanim(var_02, "sandstorm_start", var_04);
  param_00 animscripts\notetracks_common::func_3222(undefined, "sandstorm_start");
  var_05 = param_00 get_palmtree_anim_and_duration("sandstorm_loop");
  var_02 = var_05[0];
  var_03 = var_05[1];
  var_04 = var_03 * randomfloatrange(0, 0.75);
  param_00 thread animscripts\notetracks_common::func_3222(undefined, "sandstorm_loop");
  param_00 scriptmodelplayanim(var_02, "sandstorm_loop", var_04);
}

delete_vignette_weapons(param_00) {
  for(var_01 = 0; var_01 < 6; var_01++) {
    if(isDefined(level.var_54D0[param_00].var_8CA7) && isDefined(level.var_54D0[param_00].var_8CA7[var_01]) && isDefined(level.var_54D0[param_00].var_8CA7[var_01].var_13B3) && isDefined(level.var_54D0[param_00].var_8CA7[var_01].var_7490)) {
      level.var_54D0[param_00].var_8CA7[var_01].var_7490 delete();
    }
  }
}

compass_handler() {
  level endon("game_ended");
  if(getDvar("compass_continue") != "") {
    level waittill("player_spawned", var_00);
    wait(27);
    for(;;) {
      wait 0.05;
      if(var_00 isonground()) {
        iprintlnbold(getDvar("compass_continue"));
        wait(1);
        setDvar("compass_continue", 1);
        wait(1);
        iprintlnbold(getDvar("compass_continue"));
        break;
      }
    }
  }
}

performance_stuff() {
  setDvar("634", 0);
}