/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_london.gsc
*********************************************/

func_00F9() {
  lib_04B3::func_F9();
  lib_041A::func_F9();
  lib_04B2::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_london_lighting::func_F9();
  maps\mp\mp_london_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_london");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_5A7C = "mp_london_killstreak";
  level.var_5A6B = "mp_london_killstreak";
  level.var_47CD = "mp_london_glide1";
  level.var_47CE = "mp_london_glide2";
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
  maps\mp\_water::func_D5();
  level thread func_6B6C();
  thread func_0E99();
  func_877E();
  setup_tri_filtering_settings();
  setup_ctf_flag_offsets();
  var_00 = getEntArray("mp_artillery", "classname");
  foreach(var_02 in var_00) {
    if(var_02.var_116[0] == -7104 && var_02.var_116[1] == -752 && var_02.var_116[2] == 60) {
      var_02.var_116 = (-6384, -1312, 924);
      continue;
    }

    if(var_02.var_116[0] == 7088 && var_02.var_116[1] == -768 && var_02.var_116[2] == 80) {
      var_02.var_116 = (6560, -1664, 992);
    }
  }
}

setup_ctf_flag_offsets() {
  level.allies_ctf_flag_offset = (64, 0, 0);
  level.axis_ctf_flag_offset = (-64, 0, 0);
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
  }
}

func_6B82() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", var_00);
    if(isDefined(var_00)) {
      var_00 thread func_9B93();
    }
  }
}

func_9B93() {
  self endon("death");
  var_00 = getent("grenade_death_trigger", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  while(isDefined(self)) {
    if(self istouching(var_00)) {
      self delete();
    }

    wait 0.05;
  }
}

func_0E99() {
  wait 0.05;
  var_00 = getent("yacht", "targetname");
  var_01 = getent("steamer", "targetname");
  playFXOnTag(common_scripts\utility::func_44F5("lon_boat_wake_01"), var_01, "boat");
  playFXOnTag(common_scripts\utility::func_44F5("lon_boat_smk_02"), var_01, "tag_fx_smoke");
  if(isDefined(var_00)) {
    var_00 method_8278("lon_boat_yacht_anim_01");
  }

  if(isDefined(var_01)) {
    var_01 method_8278("lon_boat_steamer_anim_01");
  }
}

func_877E() {
  level.var_14F4 = [];
  level.var_14F4[0] = (-1659, -1059, 316);
  level.var_14F4[1] = (-1527, -332, 316);
}

setup_tri_filtering_settings() {
  setDvar("r_gpuTriangleDepthFiltering", 0);
}