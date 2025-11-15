/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_rivet\mp_rivet.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_rivet\mp_rivet_precache::main();
  scripts\mp\maps\mp_rivet\gen\mp_rivet_art::main();
  scripts\mp\maps\mp_rivet\mp_rivet_fx::main();
  level func_D80C();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_rivet");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraaccurateocclusionthreshold", 500);
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
  var_00 = spawn("script_model", (0, 0, 1024));
  var_00.angles = (0, 0, 0);
  var_00 setModel("mp_rivet_clip_patch_clip_all_01");
  var_01 = getent("player512x512x8", "targetname");
  var_02 = spawn("script_model", (-1192, -944, 1500));
  var_02.angles = (26, 0, 0);
  var_02 clonebrushmodeltoscriptmodel(var_01);
  var_03 = getent("player512x512x8", "targetname");
  var_04 = spawn("script_model", (462, 2064, 1536));
  var_04.angles = (0, 0, 90);
  var_04 clonebrushmodeltoscriptmodel(var_03);
  var_05 = getent("player512x512x8", "targetname");
  var_06 = spawn("script_model", (-400, 360, 1360));
  var_06.angles = (0, 0, 90);
  var_06 clonebrushmodeltoscriptmodel(var_05);
  var_07 = spawn("script_model", (110, 1969, 823.5));
  var_07.angles = (0, 315, -90);
  var_07 setModel("sdf_rivet_runwall_01");
  var_08 = spawn("script_model", (196, -1972, 823));
  var_08.angles = (0, 315, -90);
  var_08 setModel("ship_wall_panel_a_32_clean");
  var_09 = spawn("script_model", (173, -1950, 823));
  var_09.angles = (0, 315, -90);
  var_09 setModel("ship_wall_panel_a_32_clean");
  var_0A = spawn("script_model", (151, -1927, 823));
  var_0A.angles = (0, 315, -90);
  var_0A setModel("ship_wall_panel_a_32_clean");
  var_0B = spawn("script_model", (983.5, -524.5, 840));
  var_0B.angles = (0, 0, 180);
  var_0B setModel("com_plastic_crate_pallet_mp_rivet_patch");
  var_0C = spawn("script_model", (1134, 238, 788));
  var_0C.angles = (0, 90, 0);
  var_0C setModel("ship_wall_panel_a_32_clean");
  var_0D = spawn("script_model", (1134, -270, 788));
  var_0D.angles = (0, 90, 0);
  var_0D setModel("ship_wall_panel_a_32_clean");
  var_0E = spawn("script_model", (1032.5, -195, 788));
  var_0E.angles = (0, 325, 0);
  var_0E setModel("ship_wall_panel_a_32_clean");
  var_0F = spawn("script_model", (968.4, -122.3, 788));
  var_0F.angles = (0, 302, 0);
  var_0F setModel("ship_wall_panel_a_32_clean");
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
  var_00 = [(-334, -1727, 825), (1131, -994, 825), (1137, 1003, 825), (291, -1858, 825)];
  foreach(var_02 in var_00) {
    var_03 = spawn("trigger_radius", var_02, 0, 300, 15);
    level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_03;
  }

  level waittill("game_ended");
  foreach(var_03 in level.outofboundstriggerpatches) {
    if(isDefined(var_03)) {
      var_03 delete();
    }
  }
}

func_D80C() {
  precachemodel("crane_hangar_04");
  precachemodel("sdf_rivet_runwall_01");
  precachemodel("shipyard_drone_01");
  precachemodel("shipyard_drone_01_paths");
  level.var_1D93 = ["ship_wall_panel", "ship_wall_panel_a_32", "ship_wall_panel_a_32_clean", "ship_wall_panel_a_64", "ship_wall_panel_a_64_clean"];
  foreach(var_01 in level.var_1D93) {
    precachemodel(var_01);
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
  if(getdvar("r_reflectionProbeGenerate") != "1") {
    level thread func_FA3A();
    level thread func_F03C();
    level thread func_1DA5();
    return;
  }

  waittillframeend;
  var_00 = getscriptablearray("rivet_scriptable_light", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("onoff", "off");
  }
}

func_FA3A() {
  waittillframeend;
  var_00 = getscriptablearray("mp_rivet_hanging_turret", "targetname");
  if(var_00.size != 0) {
    foreach(var_02 in var_00) {
      var_03 = spawn("script_model", var_02.origin);
      var_03.angles = var_02.angles;
      var_03 setModel("crane_hangar_04");
      var_03 linkto(var_02, "j_prop_1");
      var_03 show();
    }
  }

  var_05 = getscriptablearray("mp_rivet_hanging_wall", "targetname");
  if(var_05.size != 0) {
    foreach(var_07 in var_05) {
      var_03 = spawn("script_model", var_07 gettagorigin("j_prop_1") + (0, 0, 112));
      var_03.angles = var_07 gettagangles("j_prop_1");
      var_03 setModel("sdf_rivet_runwall_01");
      var_03 linkto(var_07, "j_prop_1");
      var_03 show();
      var_03 = spawn("script_model", var_07 gettagorigin("j_prop_2") + (0, 0, 112));
      var_03.angles = var_07 gettagangles("j_prop_2");
      var_03 setModel("shipyard_drone_01");
      var_03 linkto(var_07, "j_prop_2");
      var_03 show();
      var_03 setscriptablepartstate("anims", "drone1");
      var_03 = spawn("script_model", var_07 gettagorigin("j_prop_3") + (0, 0, 112));
      var_03.angles = var_07 gettagangles("j_prop_3");
      var_03 setModel("shipyard_drone_01");
      var_03 linkto(var_07, "j_prop_3");
      var_03 show();
      var_03 setscriptablepartstate("anims", "drone2");
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
  var_00 = [];
  var_01 = scripts\engine\utility::getstructarray("ambient_drone_start_loc", "script_noteworthy");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.script_parameters)) {
      continue;
    }

    var_04 = spawn("script_model", (0, 0, 0));
    var_04.angles = (0, 0, 0);
    var_04 setModel("shipyard_drone_01_paths");
    var_04.var_10DC1 = var_03.origin;
    var_04.var_10D6D = var_03.angles;
    var_04.running = 0;
    var_04.script_parameters = func_1D92(var_03.script_parameters);
    if(isDefined(var_04.script_parameters)) {
      var_04.var_1FB8 = getanimlength(var_04.script_parameters);
      var_04.var_C891 = var_04 func_1D9B();
      var_04.var_C891 linkto(var_04, "tag_ship_wall_panel");
      var_04 func_1D94();
      var_04 hide();
      var_04.origin = var_04.var_10DC1;
      var_04.angles = var_04.var_10D6D;
      var_04 scriptmodelplayanimdeltamotion(var_04.script_parameters);
      var_00[var_00.size] = var_04;
    }
  }

  return var_00;
}

func_1D92(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  switch (param_00) {
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
    foreach(var_01 in level.var_1D99) {
      if(!isDefined(var_01.running)) {
        var_01.running = 0;
      }

      if(var_01.running == 0) {
        var_01 thread func_1DA3();
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
  var_00 = spawn("script_model", self.origin + (-64, 1, 0));
  var_00 setModel("tag_origin");
  var_00.angles = self.angles + (90, 0, 0);
  return var_00;
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
  var_00 = getscriptablearray("mp_rivet_rocket", "targetname")[0];
  if(!isDefined(level.var_E5E1)) {
    level.var_E5E1 = 0;
  }

  if(isDefined(var_00)) {
    var_00.var_4D29 = getent("mp_rivet_rocket_damage_vol", "targetname");
    var_00 thread scripts\mp\maps\mp_rivet\mp_rivet_fx::func_F03D();
    var_00 thread func_F03F();
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
    foreach(var_01 in self.var_75A4) {
      var_01 setscriptablepartstate("onoff", "on");
    }

    wait(14.8);
    foreach(var_01 in self.var_75A4) {
      var_01 setscriptablepartstate("onoff", "off");
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
      self.var_4D29 waittill("trigger", var_00);
      if(level.var_E5E1 != 1) {
        break;
      }

      if(scripts\mp\utility::isreallyalive(var_00)) {
        var_00 dodamage(var_00.maxhealth, self.origin, var_00, undefined, "MOD_EXPLOSIVE");
        if(isplayer(var_00) || isagent(var_00)) {
          thread func_57D4(var_00 _meth_8113());
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
      var_00 = scripts\engine\utility::array_combine(self getistouchingentities(level.grenades), self getistouchingentities(level.missiles));
      var_00 = scripts\engine\utility::array_combine(self getistouchingentities(level.mines), var_00);
      foreach(var_02 in var_00) {
        var_02 scripts\mp\weapons::deleteexplosive();
      }

      scripts\engine\utility::waitframe();
    }
  }
}

func_57D4(param_00) {
  waittillframeend;
  if(isDefined(param_00)) {
    param_00 hide();
  }
}

func_4346() {
  if(randomint(100) > 50) {
    return -1;
  }

  return 1;
}