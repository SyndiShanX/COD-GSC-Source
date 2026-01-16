/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_breakneck\mp_breakneck.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_breakneck\mp_breakneck_precache::main();
  scripts\mp\maps\mp_breakneck\gen\mp_breakneck_art::main();
  scripts\mp\maps\mp_breakneck\mp_breakneck_fx::main();
  level func_D80C();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_breakneck");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 4);
  setdvar("r_umbraShadowCasters", 1);
  setdvar("sm_roundRobinPrioritySpotShadows", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 400);
  setdvar("sm_sunCascadeSizeMultiplier1", 3);
  setdvar("sm_sunCascadeSizeMultiplier2", 2);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  level func_2FBC();
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
}

fix_collision() {
  var_0 = getent("clip512x512x8", "targetname");
  var_1 = spawn("script_model", (-43104, 296, 512));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip512x512x8", "targetname");
  var_3 = spawn("script_model", (-43104, 808, 512));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (-38963.5, -781.5, 80));
  var_4.angles = (0, 0, 0);
  var_4 setModel("cnd_electric_panels_004_grey_dk_mp_breakneck_patch");
  var_5 = spawn("script_model", (-40748.5, -520.5, 80));
  var_5.angles = (0, 180, 0);
  var_5 setModel("cnd_electric_panels_004_grey_dk_mp_breakneck_patch");
  var_5 = spawn("script_model", (-37408, 288, 80));
  var_5.angles = (0, 270, 0);
  var_5 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_6 = spawn("script_model", (-37408, 496, 80));
  var_6.angles = (0, 270, 0);
  var_6 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_7 = spawn("script_model", (-37504, 208, 80));
  var_7.angles = (0, 180, 0);
  var_7 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_8 = spawn("script_model", (-39852, 416, 168));
  var_8.angles = (0, 0, 0);
  var_8 setModel("mp_breakneck_missile_patch_01");
  var_9 = spawn("trigger_radius", (-37408, 1056, -16), 0, 128, 64);
  var_9.fgetarg = 128;
  var_9.height = 64;
  thread killtriggerloop(var_9);
  var_10 = getent("player32x32x8", "targetname");
  var_11 = spawn("script_model", (-40556, -288, 294));
  var_11.angles = (290, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = spawn("script_model", (-39772, 398, 44));
  var_12.angles = (70, 270, 90);
  var_12 setModel("mp_breakneck_missile_patch_01");
  var_13 = getent("player32x32x256", "targetname");
  var_14 = spawn("script_model", (-39288, 1136, 448));
  var_14.angles = (0, 45, 0);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getent("player32x32x256", "targetname");
  var_10 = spawn("script_model", (-37816, 84, 288));
  var_10.angles = (0, 0, 10);
  var_10 clonebrushmodeltoscriptmodel(var_15);
  var_11 = getent("player32x32x8", "targetname");
  var_12 = spawn("script_model", (-40188, -1052, 324));
  var_12.angles = (0, 0, 75);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = getent("clip512x512x8", "targetname");
  var_14 = spawn("script_model", (-40656, -1020, -180));
  var_14.angles = (0, 0, 90);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getent("clip256x256x8", "targetname");
  var_16 = spawn("script_model", (-40272, -1020, -52));
  var_16.angles = (0, 0, 90);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getent("clip32x32x256", "targetname");
  var_18 = spawn("script_model", (-39184, -1004, 60));
  var_18.angles = (42, 90, 90);
  var_18 clonebrushmodeltoscriptmodel(var_17);
  var_19 = getent("clip32x32x128", "targetname");
  var_1A = spawn("script_model", (-38952, -1004, 60));
  var_1A.angles = (42, 90, 90);
  var_1A clonebrushmodeltoscriptmodel(var_19);
  var_1B = getent("player32x32x8", "targetname");
  var_1C = spawn("script_model", (-41560, 832, 360));
  var_1C.angles = (285, 0, 0);
  var_1C clonebrushmodeltoscriptmodel(var_1B);
  var_1D = getent("player32x32x8", "targetname");
  var_1E = spawn("script_model", (-38656, -820, 112));
  var_1E.angles = (285, 123, 0);
  var_1E clonebrushmodeltoscriptmodel(var_1D);
  var_1F = getent("player32x32x8", "targetname");
  var_20 = spawn("script_model", (-39596, 1554, 98));
  var_20.angles = (285, 75, 0);
  var_20 clonebrushmodeltoscriptmodel(var_1F);
  var_21 = getent("player256x256x8", "targetname");
  var_22 = spawn("script_model", (-42360, 832, 376));
  var_22.angles = (0, 0, 90);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getent("clip64x64x256", "targetname");
  var_24 = spawn("script_model", (-41840, 880, -160));
  var_24.angles = (0, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_23);
  var_25 = getent("player512x512x8", "targetname");
  var_26 = spawn("script_model", (-41352, 1224, -112));
  var_26.angles = (90, 0, 0);
  var_26 clonebrushmodeltoscriptmodel(var_25);
  var_27 = getent("player512x512x8", "targetname");
  var_28 = spawn("script_model", (-41096, 1488, -112));
  var_28.angles = (0, 0, 90);
  var_28 clonebrushmodeltoscriptmodel(var_27);
  var_29 = getent("clip64x64x256", "targetname");
  var_2A = spawn("script_model", (-38732, 1632, 144));
  var_2A.angles = (30, 270, 90);
  var_2A clonebrushmodeltoscriptmodel(var_29);
  var_2B = getent("player128x128x256", "targetname");
  var_2C = spawn("script_model", (-37888, 136, 300));
  var_2C.angles = (0, 0, 0);
  var_2C clonebrushmodeltoscriptmodel(var_2B);
  var_2D = getent("player128x128x256", "targetname");
  var_2E = spawn("script_model", (-37888, 136, 556));
  var_2E.angles = (0, 0, 0);
  var_2E clonebrushmodeltoscriptmodel(var_2D);
  var_2F = getent("player256x256x8", "targetname");
  var_30 = spawn("script_model", (-40264, -920, 424));
  var_30.angles = (90, 0, 0);
  var_30 clonebrushmodeltoscriptmodel(var_2F);
  var_31 = getent("player256x256x8", "targetname");
  var_32 = spawn("script_model", (-40264, -920, 680));
  var_32.angles = (90, 0, 0);
  var_32 clonebrushmodeltoscriptmodel(var_31);
  var_33 = spawn("trigger_radius", (-41840, -640, -144), 0, 144, 208);
  var_33.fgetarg = 144;
  var_33.height = 208;
  thread killtriggerloop(var_33);
}

killtriggerloop(var_0) {
  level endon("game_ended");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isDefined(var_1)) {
      if(isplayer(var_1)) {
        var_1 suicide();
        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
        if(isDefined(var_1.streakname)) {
          if(var_1.streakname == "minijackal") {
            var_1 notify("minijackal_end");
            continue;
          }

          if(var_1.streakname == "venom") {
            var_1 notify("venom_end", var_1.origin);
          }
        }
      }
    }
  }
}

func_D80C() {
  level.var_2B31 = ["superstructure_hull_chunk_01", "superstructure_hull_chunk_02", "debris_exterior_damaged_metal_panels_01", "debris_exterior_damaged_metal_panels_02", "debris_exterior_damaged_metal_panels_03", "debris_exterior_damaged_metal_panels_08", "machinery_tower_pipe_beam_support_01_destroyed"];
  foreach(var_1 in level.var_2B31) {
    precachemodel(var_1);
  }

  level.var_871B = ["weapon_spas12_wm", "weapon_ripper_rare_wm", "weapon_vr_rifle_wm"];
  foreach(var_4 in level.var_871B) {
    precachemodel(var_4);
  }

  precachemodel("armory_weapon_locker_clamp_bn");
}

func_2FBC() {
  if(getdvar("r_reflectionProbeGenerate") != "1") {
    thread func_CDA4("mp_breakneck_collision_bink_01");
    thread func_FA92();
    thread func_226A();
  }
}

func_226A() {
  scripts\engine\utility::waitframe();
  if(isDefined(scripts\engine\utility::getstruct("gunrack_up", "targetname")) && isDefined(scripts\engine\utility::getstruct("gunrack_down", "targetname"))) {
    level.var_871A = spawnStruct();
    level.var_871A.var_12F6C = spawnStruct();
    level.var_871A.var_12F6C.start = scripts\engine\utility::getstruct("gunrack_up", "targetname");
    level.var_871A.var_12F6C.end = scripts\engine\utility::getstruct(level.var_871A.var_12F6C.start.target, "targetname");
    level.var_871A.var_12F6C.var_871C = func_226B(level.var_871A.var_12F6C.start.origin, 1);
    level.var_871A.var_5AF4 = spawnStruct();
    level.var_871A.var_5AF4.start = scripts\engine\utility::getstruct("gunrack_down", "targetname");
    level.var_871A.var_5AF4.end = scripts\engine\utility::getstruct(level.var_871A.var_5AF4.start.target, "targetname");
    level.var_871A.var_5AF4.var_871C = func_226B(level.var_871A.var_5AF4.start.origin, 0);
    level.var_871A.var_12F6C thread func_2268();
    level.var_871A.var_5AF4 thread func_2268();
  }
}

func_226B(var_0, var_1) {
  level endon("game_ended");
  var_2 = [];
  for(;;) {
    var_3 = spawn("script_model", (0, 0, 0));
    var_3 setModel("armory_weapon_locker_clamp_bn");
    var_3.var_870F = spawn("script_model", (0, 0, 0));
    var_3.var_870F setModel("tag_origin");
    var_3.var_870F.offsets = [];
    if(var_1 == 1) {
      var_3.angles = (90, 0, 0);
      var_3.var_870F.angles = (0, 354, 0);
      var_3.var_870F.offsets["weapon_spas12_wm"] = (-15.7, -5, 3.2);
      var_3.var_870F.offsets["weapon_ripper_rare_wm"] = (-14.1, -3.7, 2.8);
      var_3.var_870F.offsets["weapon_vr_rifle_wm"] = (-15.5, -4.8, 2.3);
    } else {
      var_3.angles = (90, 0, -180);
      var_3.var_870F.angles = (0, 174, 0);
      var_3.var_870F.offsets["weapon_spas12_wm"] = (15.7, 5, 3.2);
      var_3.var_870F.offsets["weapon_ripper_rare_wm"] = (14.1, 3.7, 2.8);
      var_3.var_870F.offsets["weapon_vr_rifle_wm"] = (15.5, 4.8, 2.3);
    }

    var_3.var_870F linkto(var_3);
    var_3.origin = var_0;
    var_2[var_2.size] = var_3;
    if(var_2.size == 10) {
      break;
    }
  }

  return var_2;
}

func_2268() {
  foreach(var_1 in self.var_871C) {
    thread func_2269(var_1);
    wait(8);
  }
}

func_2269(var_0) {
  for(;;) {
    var_0.var_870F unlink();
    var_0 dontinterpolate();
    var_0.origin = self.start.origin;
    scripts\engine\utility::waitframe();
    if(randomint(100) < 90) {
      var_0.var_870F setModel(scripts\engine\utility::random(level.var_871B));
      var_0.var_870F.origin = var_0.origin + var_0.var_870F.offsets[var_0.var_870F.model];
    } else {
      var_0.var_870F setModel("tag_origin");
      var_0.var_870F.origin = var_0.origin;
    }

    var_0.var_870F linkto(var_0);
    var_0 moveto(self.end.origin, 80);
    var_0 waittill("movedone");
  }
}

func_FA92() {
  level.var_2B2F = spawnStruct();
  level thread func_FA94();
}

func_FA94() {
  if(!isDefined(game["roundsPlayed"])) {
    level.var_2B2F.var_DAE3 = scripts\engine\utility::getstruct("breakneck_blackhole_target_loc", "script_noteworthy");
    level.var_2B2F.var_DAE5 = func_FA93(scripts\engine\utility::getstructarray("breakneck_blackhole_spawn_loc", "script_noteworthy"));
    level.var_2B2F.var_DAE4 = getEntArray("breakneck_blackhole_pull", "targetname");
    if(isDefined(level.var_2B2F.var_DAE3)) {
      if(level.var_2B2F.var_DAE3.size != 0) {
        scripts\engine\utility::array_thread(level.var_2B2F.var_DAE5, ::func_139AE);
      }

      if(level.var_2B2F.var_DAE4.size != 0) {
        level thread func_139AF();
      }
    }
  }

  level thread func_2B44();
}

func_FA93(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("tag_origin");
    var_4.angles = (0, 0, 0);
    var_4.var_2887 = var_4.origin;
    var_4.physicsactivated = 0;
    var_4.var_C2CD = 0;
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

func_2B44() {
  level waittill("match_start_real_countdown");
  var_0 = getscriptablearray("scriptable_spawn_pulls", "targetname");
  if(game["roundsPlayed"] == 0) {
    foreach(var_2 in var_0) {
      var_2 setscriptablepartstate("default", "countdown_anim");
    }

    return;
  }

  foreach(var_2 in var_2) {
    var_2 setscriptablepartstate("default", "fast_anim");
  }
}

func_139AE() {
  level endon("game_ended");
  wait(randomint(15));
  for(;;) {
    self.angles = (scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360));
    self setModel(scripts\engine\utility::random(level.var_2B31));
    self moveto(level.var_2B2F.var_DAE3.origin, 60 + scripts\engine\utility::cointoss() * randomint(15), 0, 0);
    self ghost_killed_update_func((scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360)), 30, 0, 0);
    self waittill("movedone");
    wait(15 + scripts\engine\utility::cointoss() * randomint(15));
    self dontinterpolate();
    self.origin = self.var_2887;
    scripts\engine\utility::waitframe();
  }
}

func_139AF() {
  level endon("game_ended");
  foreach(var_1 in level.var_2B2F.var_DAE4) {
    var_1.physicsactivated = 0;
  }

  for(;;) {
    wait(15 + scripts\engine\utility::cointoss() * randomint(15));
    var_3 = scripts\engine\utility::random(level.var_2B2F.var_DAE4);
    var_3 thread func_2B43();
    level.var_2B2F.var_DAE4 = scripts\engine\utility::array_remove(level.var_2B2F.var_DAE4, var_3);
    if(level.var_2B2F.var_DAE4.size == 0) {
      break;
    }
  }
}

func_2B43() {
  level endon("game_ended");
  self endon("death");
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 32), self.angles);
  var_0 show();
  var_1 = vectortoangles(level.var_2B2F.var_DAE3.origin - self.origin);
  self rotateto(var_1, 1);
  wait(1);
  self moveto(level.var_2B2F.var_DAE3.origin, 60 + scripts\engine\utility::cointoss() * randomint(15), 0, 0);
  wait(0.1);
  playFXOnTag(level._effect["vfx_breakneck_explosion_01"], var_0, "tag_origin");
  self rotatevelocity((var_1[0] / 4, 0, 0), 30);
  self waittill("movedone");
  stopFXOnTag(level._effect["vfx_breakneck_explosion_01"], var_0, "tag_origin");
  var_0 delete();
  self delete();
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}