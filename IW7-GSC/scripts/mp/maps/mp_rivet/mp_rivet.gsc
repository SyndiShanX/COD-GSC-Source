/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_rivet\mp_rivet.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_rivet\mp_rivet_precache::main();
  scripts\mp\maps\mp_rivet\gen\mp_rivet_art::main();
  scripts\mp\maps\mp_rivet\mp_rivet_fx::main();
  level func_D80C();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_rivet");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraaccurateocclusionthreshold", 500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  level thread func_E563();
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
  thread patchoutofboundstrigger();
}

fix_collision() {
  var_0 = spawn("script_model", (0, 0, 1024));
  var_0.angles = (0, 0, 0);
  var_0 setModel("mp_rivet_clip_patch_clip_all_01");
  var_1 = getent("player512x512x8", "targetname");
  var_2 = spawn("script_model", (-1192, -944, 1500));
  var_2.angles = (26, 0, 0);
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = getent("player512x512x8", "targetname");
  var_4 = spawn("script_model", (462, 2064, 1536));
  var_4.angles = (0, 0, 90);
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_5 = getent("player512x512x8", "targetname");
  var_6 = spawn("script_model", (-400, 360, 1360));
  var_6.angles = (0, 0, 90);
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = spawn("script_model", (110, 1969, 823.5));
  var_7.angles = (0, 315, -90);
  var_7 setModel("sdf_rivet_runwall_01");
  var_8 = spawn("script_model", (196, -1972, 823));
  var_8.angles = (0, 315, -90);
  var_8 setModel("ship_wall_panel_a_32_clean");
  var_9 = spawn("script_model", (173, -1950, 823));
  var_9.angles = (0, 315, -90);
  var_9 setModel("ship_wall_panel_a_32_clean");
  var_10 = spawn("script_model", (151, -1927, 823));
  var_10.angles = (0, 315, -90);
  var_10 setModel("ship_wall_panel_a_32_clean");
  var_11 = spawn("script_model", (983.5, -524.5, 840));
  var_11.angles = (0, 0, 180);
  var_11 setModel("com_plastic_crate_pallet_mp_rivet_patch");
  var_12 = spawn("script_model", (1134, 238, 788));
  var_12.angles = (0, 90, 0);
  var_12 setModel("ship_wall_panel_a_32_clean");
  var_13 = spawn("script_model", (1134, -270, 788));
  var_13.angles = (0, 90, 0);
  var_13 setModel("ship_wall_panel_a_32_clean");
  var_14 = spawn("script_model", (1032.5, -195, 788));
  var_14.angles = (0, 325, 0);
  var_14 setModel("ship_wall_panel_a_32_clean");
  var_15 = spawn("script_model", (968.4, -122.3, 788));
  var_15.angles = (0, 302, 0);
  var_15 setModel("ship_wall_panel_a_32_clean");
  var_10 = spawn("script_model", (937, -30.8, 788));
  var_10.angles = (0, 280, 0);
  var_10 setModel("ship_wall_panel_a_32_clean");
  var_11 = spawn("script_model", (942.6, 64, 788));
  var_11.angles = (0, 256, 0);
  var_11 setModel("ship_wall_panel_a_32_clean");
  var_12 = spawn("script_model", (987.5, 149.9, 788));
  var_12.angles = (0, 233, 0);
  var_12 setModel("ship_wall_panel_a_32_clean");
  var_13 = spawn("script_model", (1059.7, 212, 788));
  var_13.angles = (0, 211, 0);
  var_13 setModel("ship_wall_panel_a_32_clean");
  var_14 = spawn("script_model", (-1030, 486, 868));
  var_14.angles = (0, 240, 0);
  var_14 setModel("ship_wall_panel_a_32_clean");
  var_15 = getent("player512x512x8", "targetname");
  var_16 = spawn("script_model", (736, 1320, 960));
  var_16.angles = (270, 45, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getent("player64x64x256", "targetname");
  var_18 = spawn("script_model", (-488, 1552, 1168));
  var_18.angles = (350, 0, 0);
  var_18 clonebrushmodeltoscriptmodel(var_17);
  var_19 = getent("clip128x128x256", "targetname");
  var_1A = spawn("script_model", (1432, -392, 816));
  var_1A.angles = (0, 330, -90);
  var_1A clonebrushmodeltoscriptmodel(var_19);
  var_1B = getent("player128x128x256", "targetname");
  var_1C = spawn("script_model", (-1184, 960, 904));
  var_1C.angles = (0, 0, 0);
  var_1C clonebrushmodeltoscriptmodel(var_1B);
  var_1D = getent("player512x512x8", "targetname");
  var_1E = spawn("script_model", (-448, 2464, 1328));
  var_1E.angles = (0, 0, 0);
  var_1E clonebrushmodeltoscriptmodel(var_1D);
  var_1F = spawn("script_model", (-448, 2208, 1584));
  var_1F.angles = (0, 0, 90);
  var_1F clonebrushmodeltoscriptmodel(var_1D);
  var_20 = spawn("script_model", (-192, 0, 960));
  var_20.angles = (0, 0, 0);
  var_20 setModel("mp_rivet_missile_patch_01");
  var_21 = getent("player32x32x32", "targetname");
  var_22 = spawn("script_model", (1364, -360, 1104));
  var_22.angles = (30, 345, 0);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getent("player512x512x8", "targetname");
  var_24 = spawn("script_model", (-1448, 1312, 1504));
  var_24.angles = (270, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_23);
  var_25 = getent("player64x64x256", "targetname");
  var_26 = spawn("script_model", (-1424, 1572, 1504));
  var_26.angles = (0, 0, 0);
  var_26 clonebrushmodeltoscriptmodel(var_25);
  var_27 = spawn("script_model", (-1424, 1572, 1248));
  var_27.angles = (0, 0, 0);
  var_27 clonebrushmodeltoscriptmodel(var_25);
  var_28 = getent("player256x256x8", "targetname");
  var_27 = spawn("script_model", (-336, 300, 1344));
  var_27.angles = (0, 0, 90);
  var_27 clonebrushmodeltoscriptmodel(var_28);
  var_29 = getent("player256x256x8", "targetname");
  var_2A = spawn("script_model", (-600, 2100, 1338));
  var_2A.angles = (0, 0, 77.9998);
  var_2A clonebrushmodeltoscriptmodel(var_29);
  var_2B = getent("player256x256x8", "targetname");
  var_2C = spawn("script_model", (-1620, -940, 1536));
  var_2C.angles = (270, 330, -60);
  var_2C clonebrushmodeltoscriptmodel(var_2B);
  var_2D = getent("player256x256x8", "targetname");
  var_2E = spawn("script_model", (-1364, -940, 1536));
  var_2E.angles = (270, 330, -60);
  var_2E clonebrushmodeltoscriptmodel(var_2D);
  var_2F = getent("player256x256x8", "targetname");
  var_30 = spawn("script_model", (-1620, 468, 1504));
  var_30.angles = (270, 330, -60);
  var_30 clonebrushmodeltoscriptmodel(var_2F);
  var_31 = getent("player256x256x8", "targetname");
  var_32 = spawn("script_model", (-1621.87, 1197.54, 1504));
  var_32.angles = (270, 355, -74);
  var_32 clonebrushmodeltoscriptmodel(var_31);
  var_33 = getent("player128x128x256", "targetname");
  var_34 = spawn("script_model", (-768, 2132, 1264));
  var_34.angles = (0.8, 4.92, -10);
  var_34 clonebrushmodeltoscriptmodel(var_33);
  var_35 = getent("player64x64x256", "targetname");
  var_36 = spawn("script_model", (352, -224, 960));
  var_36.angles = (0, 0, 0);
  var_36 clonebrushmodeltoscriptmodel(var_35);
  var_37 = getent("player64x64x256", "targetname");
  var_38 = spawn("script_model", (352, 224, 960));
  var_38.angles = (0, 0, 0);
  var_38 clonebrushmodeltoscriptmodel(var_37);
}

patchoutofboundstrigger() {
  level.outofboundstriggerpatches = [];
  var_0 = [(-334, -1727, 825), (1131, -994, 825), (1137, 1003, 825), (291, -1858, 825)];
  foreach(var_2 in var_0) {
    var_3 = spawn("trigger_radius", var_2, 0, 300, 15);
    level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_3;
  }

  level waittill("game_ended");
  foreach(var_3 in level.outofboundstriggerpatches) {
    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}

func_D80C() {
  precachemodel("crane_hangar_04");
  precachemodel("sdf_rivet_runwall_01");
  precachemodel("shipyard_drone_01");
  precachemodel("shipyard_drone_01_paths");
  level.var_1D93 = ["ship_wall_panel", "ship_wall_panel_a_32", "ship_wall_panel_a_32_clean", "ship_wall_panel_a_64", "ship_wall_panel_a_64_clean"];
  foreach(var_1 in level.var_1D93) {
    precachemodel(var_1);
  }

  precachempanim("mp_rivet_drone_path_01");
  precachempanim("mp_rivet_drone_path_02");
  precachempanim("mp_rivet_drone_path_03");
  precachempanim("mp_rivet_drone_path_04");
  precachempanim("mp_rivet_drone_path_05");
  precachempanim("mp_rivet_drone_path_06");
  precachempanim("mp_rivet_drone_path_07");
  precachempanim("mp_rivet_drone_path_08");
  precachempanim("mp_rivet_drone_path_09");
  precachempanim("mp_rivet_drone_path_10");
  precachempanim("mp_rivet_drone_path_11");
  precachempanim("mp_rivet_drone_path_12");
  precachempanim("mp_rivet_drone_path_13");
  precachempanim("mp_rivet_drone_path_14");
}

func_E563() {
  if(getDvar("r_reflectionProbeGenerate") != "1") {
    level thread func_FA3A();
    level thread func_F03C();
    level thread func_1DA5();
    return;
  }

  waittillframeend;
  var_0 = getscriptablearray("rivet_scriptable_light", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("onoff", "off");
  }
}

func_FA3A() {
  waittillframeend;
  var_0 = getscriptablearray("mp_rivet_hanging_turret", "targetname");
  if(var_0.size != 0) {
    foreach(var_2 in var_0) {
      var_3 = spawn("script_model", var_2.origin);
      var_3.angles = var_2.angles;
      var_3 setModel("crane_hangar_04");
      var_3 linkto(var_2, "j_prop_1");
      var_3 show();
    }
  }

  var_5 = getscriptablearray("mp_rivet_hanging_wall", "targetname");
  if(var_5.size != 0) {
    foreach(var_7 in var_5) {
      var_3 = spawn("script_model", var_7 gettagorigin("j_prop_1") + (0, 0, 112));
      var_3.angles = var_7 gettagangles("j_prop_1");
      var_3 setModel("sdf_rivet_runwall_01");
      var_3 linkto(var_7, "j_prop_1");
      var_3 show();
      var_3 = spawn("script_model", var_7 gettagorigin("j_prop_2") + (0, 0, 112));
      var_3.angles = var_7 gettagangles("j_prop_2");
      var_3 setModel("shipyard_drone_01");
      var_3 linkto(var_7, "j_prop_2");
      var_3 show();
      var_3 setscriptablepartstate("anims", "drone1");
      var_3 = spawn("script_model", var_7 gettagorigin("j_prop_3") + (0, 0, 112));
      var_3.angles = var_7 gettagangles("j_prop_3");
      var_3 setModel("shipyard_drone_01");
      var_3 linkto(var_7, "j_prop_3");
      var_3 show();
      var_3 setscriptablepartstate("anims", "drone2");
    }
  }
}

func_1DA5() {
  level.var_1D99 = func_1D9F();
  if(level.var_1D99.size != 0) {
    level thread func_1DA2();
  }
}

func_1D9F() {
  level endon("game_ended");
  var_0 = [];
  var_1 = scripts\engine\utility::getstructarray("ambient_drone_start_loc", "script_noteworthy");
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_parameters)) {
      continue;
    }

    var_4 = spawn("script_model", (0, 0, 0));
    var_4.angles = (0, 0, 0);
    var_4 setModel("shipyard_drone_01_paths");
    var_4.var_10DC1 = var_3.origin;
    var_4.var_10D6D = var_3.angles;
    var_4.running = 0;
    var_4.script_parameters = func_1D92(var_3.script_parameters);
    if(isDefined(var_4.script_parameters)) {
      var_4.var_1FB8 = getanimlength(var_4.script_parameters);
      var_4.var_C891 = var_4 func_1D9B();
      var_4.var_C891 linkto(var_4, "tag_ship_wall_panel");
      var_4 func_1D94();
      var_4 hide();
      var_4.origin = var_4.var_10DC1;
      var_4.angles = var_4.var_10D6D;
      var_4 scriptmodelplayanimdeltamotion(var_4.script_parameters);
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

func_1D92(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  switch (var_0) {
    case "mp_rivet_drone_path_01":
      return % mp_rivet_drone_path_01;

    case "mp_rivet_drone_path_02":
      return % mp_rivet_drone_path_02;

    case "mp_rivet_drone_path_03":
      return % mp_rivet_drone_path_03;

    case "mp_rivet_drone_path_04":
      return % mp_rivet_drone_path_04;

    case "mp_rivet_drone_path_05":
      return % mp_rivet_drone_path_05;

    case "mp_rivet_drone_path_06":
      return % mp_rivet_drone_path_06;

    case "mp_rivet_drone_path_07":
      return % mp_rivet_drone_path_07;

    case "mp_rivet_drone_path_08":
      return % mp_rivet_drone_path_08;

    case "mp_rivet_drone_path_09":
      return % mp_rivet_drone_path_09;

    case "mp_rivet_drone_path_10":
      return % mp_rivet_drone_path_10;

    case "mp_rivet_drone_path_11":
      return % mp_rivet_drone_path_11;

    case "mp_rivet_drone_path_12":
      return % mp_rivet_drone_path_12;

    case "mp_rivet_drone_path_13":
      return % mp_rivet_drone_path_13;

    case "mp_rivet_drone_path_14":
      return % mp_rivet_drone_path_14;

    default:
      return undefined;
  }

  return undefined;
}

func_1DA2() {
  level endon("game_ended");
  for(;;) {
    foreach(var_1 in level.var_1D99) {
      if(!isDefined(var_1.running)) {
        var_1.running = 0;
      }

      if(var_1.running == 0) {
        var_1 thread func_1DA3();
      }
    }

    wait(10);
  }
}

func_1DA3() {
  level endon("game_ended");
  self endon("death");
  self.running = 1;
  wait(randomfloat(8));
  self scriptmodelclearanim();
  self.origin = self.var_10DC1;
  self.angles = self.var_10D6D;
  if(func_4346() == 1) {
    func_1D95();
  }

  self show();
  thread scripts\mp\maps\mp_rivet\mp_rivet_fx::func_CCEB();
  if(isDefined(self.script_parameters)) {
    self scriptmodelplayanimdeltamotion(self.script_parameters);
  }

  if(isDefined(self.var_1FB8)) {
    wait(self.var_1FB8);
  } else {
    wait(20);
  }

  func_1D94();
  scripts\mp\maps\mp_rivet\mp_rivet_fx::func_10FDF();
  self hide();
  self.running = 0;
}

func_1D9B() {
  var_0 = spawn("script_model", self.origin + (-64, 1, 0));
  var_0 setModel("tag_origin");
  var_0.angles = self.angles + (90, 0, 0);
  return var_0;
}

func_1D94() {
  self.var_10131 = 0;
  self.var_C891 hide();
}

func_1D95() {
  self.var_10131 = 1;
  self.var_C891 setModel(scripts\engine\utility::random(level.var_1D93));
  self.var_C891 show();
}

func_F03C() {
  waittillframeend;
  var_0 = getscriptablearray("mp_rivet_rocket", "targetname")[0];
  if(!isDefined(level.var_E5E1)) {
    level.var_E5E1 = 0;
  }

  if(isDefined(var_0)) {
    var_0.var_4D29 = getent("mp_rivet_rocket_damage_vol", "targetname");
    var_0 thread scripts\mp\maps\mp_rivet\mp_rivet_fx::func_F03D();
    var_0 thread func_F03F();
  }
}

func_F03F() {
  thread func_6D22();
  thread fire_rocket();
}

fire_rocket() {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    wait(45 + randomint(30) - 5);
    level notify("rivet_rocket_firing_soon");
    wait(5);
    level.var_E5E1 = 1;
    level notify("rivet_rocket_firing");
    self setscriptablepartstate("base", "fire");
    foreach(var_1 in self.var_75A4) {
      var_1 setscriptablepartstate("onoff", "on");
    }

    wait(14.8);
    foreach(var_1 in self.var_75A4) {
      var_1 setscriptablepartstate("onoff", "off");
    }

    wait(0.2);
    self setscriptablepartstate("base", "idle");
    level.var_E5E1 = 0;
    level notify("rivet_rocket_done");
  }
}

func_6D22() {
  level endon("game_ended");
  self endon("death");
  self.var_4D29 thread func_6D26();
  for(;;) {
    level waittill("rivet_rocket_firing");
    while(level.var_E5E1 == 1) {
      self.var_4D29 waittill("trigger", var_0);
      if(level.var_E5E1 != 1) {
        break;
      }

      if(scripts\mp\utility::isreallyalive(var_0)) {
        var_0 dodamage(var_0.maxhealth, self.origin, var_0, undefined, "MOD_EXPLOSIVE");
        if(isPlayer(var_0) || isagent(var_0)) {
          thread func_57D4(var_0 func_8113());
        }
      }
    }
  }
}

func_6D26() {
  level endon("game_ended");
  self endon("death");
  if(!isDefined(level.grenades)) {
    level.grenades = [];
  }

  if(!isDefined(level.missiles)) {
    level.missiles = [];
  }

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  for(;;) {
    level waittill("rivet_rocket_firing");
    while(level.var_E5E1 == 1) {
      var_0 = scripts\engine\utility::array_combine(self getistouchingentities(level.grenades), self getistouchingentities(level.missiles));
      var_0 = scripts\engine\utility::array_combine(self getistouchingentities(level.mines), var_0);
      foreach(var_2 in var_0) {
        var_2 scripts\mp\weapons::deleteexplosive();
      }

      scripts\engine\utility::waitframe();
    }
  }
}

func_57D4(var_0) {
  waittillframeend;
  if(isDefined(var_0)) {
    var_0 hide();
  }
}

func_4346() {
  if(randomint(100) > 50) {
    return -1;
  }

  return 1;
}