/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_fallen\mp_fallen.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_fallen\mp_fallen_precache::main();
  scripts\mp\maps\mp_fallen\gen\mp_fallen_art::main();
  scripts\mp\maps\mp_fallen\mp_fallen_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_fallen");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraaccurateocclusionthreshold", 400);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread func_F9BA();
  thread func_CBF3();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread scripts\mp\animation_suite::animationsuite();
  thread func_C853();
  thread fixyourcollision();
  thread fixyourballs();
  thread spawn_ball_allowed_trigger();
  thread patchoutofboundstrigger();
}

func_C853() {
  level endon("game_ended");
  wait(0.2);
  var_0 = spawn("script_origin", (1583, 253, 988));
  var_0 playLoopSound("amb_mp_fallen_pa_amb");
}

func_CBF3() {
  var_0 = scripts\engine\utility::getstruct("pitching_machine", "script_noteworthy");
  if(isDefined(var_0)) {
    var_0 thread func_CBF1();
  }
}

func_CBF1() {
  level endon("game_ended");
  precachemodel("baseball_single_fn_01_dyn");
  level waittill("connected", var_0);
  var_1 = func_CBF0();
  var_2 = getEntArray("pitching_wheel", "script_noteworthy");
  foreach(var_4 in var_2) {
    var_4.physicsactivated = 0;
  }

  for(;;) {
    for(var_6 = 0; var_6 < 5; var_6++) {
      wait(5);
      var_1[var_6] notify("pitching_machine_ball_reset");
      thread func_CBF2(var_1[var_6]);
    }
  }
}

func_CBF0() {
  var_0 = [];
  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0[var_1] = func_CBF4();
  }

  return var_0;
}

func_CBF4() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("baseball_single_fn_01_dyn");
  var_0.var_9037 = spawn("trigger_radius", self.origin, 0, 40, 40);
  var_0.var_9037 enablelinkto();
  var_0.var_9037 linkto(var_0);
  var_0 hide();
  return var_0;
}

func_CBF2(var_0) {
  var_0.physicsactivated = 0;
  var_0 hide();
  var_0.origin = self.origin;
  var_1 = anglesToForward(self.angles);
  var_2 = 2000 + randomint(500) * var_1;
  scripts\engine\utility::waitframe();
  var_0 show();
  var_0 thread func_139A8();
  var_0 thread func_139A9();
  var_0 physicslaunchserver(self.origin, var_2);
  var_0.physicsactivated = 1;
}

func_139A9() {
  self endon("death");
  wait(1);
  self notify("ball_initial_pitch_over");
}

func_139A8() {
  self endon("death");
  self endon("ball_initial_pitch_over");
  for(;;) {
    self.var_9037 waittill("trigger", var_0);
    if(isPlayer(var_0) && scripts\mp\utility::isreallyalive(var_0)) {
      var_0 dodamage(35, self.origin, self, self, "MOD_IMPACT");
      thread func_10830(self.origin);
      break;
    }
  }
}

func_10830(var_0) {
  self hide();
  var_1 = spawn("script_model", var_0);
  var_1 setModel("baseball_single_fn_01_dyn");
  var_1.physicsactivated = 1;
  var_2 = (0, 0, 0);
  var_1 physicslaunchserver(var_0, var_2);
  self waittill("pitching_machine_ball_reset");
  var_1 delete();
}

func_10A0E(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  for(;;) {
    var_2 rotatepitch(-360, var_1, 0, 0);
    wait(1);
  }
}

func_F9BA() {
  level.var_A582 = 600;
  level.var_A583 = 1200;
  level.var_BF47 = -1;
  var_0 = getEntArray("beer_keg", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread func_13957();
  }
}

func_13957() {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    if(!issubstr(var_4, "BULLET")) {
      continue;
    }

    if(!func_3827()) {
      continue;
    }

    var_5 = func_7A63(var_1, var_2, var_3);
    if(!isDefined(var_5)) {
      continue;
    }

    func_B27C();
    var_5 = vectortoangles(var_5);
    playFX(level._effect["vfx_imp_sm_beer_pallet"], var_3, anglesToForward(var_5), anglestoup(var_5));
    playFX(level._effect["vfx_fallen_beer_stream"], var_3, anglesToForward(var_5), anglestoup(var_5));
    playsoundatpos(var_3, "emt_beer_puncture");
  }
}

func_7A63(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_2 - var_3;
  var_5 = bulletTrace(var_3, var_3 + 1.5 * var_4, 0, var_0, 0);
  if(isDefined(var_5["normal"]) && isDefined(var_5["entity"]) && var_5["entity"] == self) {
    return var_5["normal"];
  }

  return undefined;
}

func_3827() {
  if(gettime() < level.var_BF47) {
    return 0;
  }

  return 1;
}

func_B27C() {
  level.var_BF47 = gettime() + randomfloatrange(level.var_A582, level.var_A583);
}

fixyourcollision() {
  var_0 = getent("clip32x32x32", "targetname");
  var_1 = spawn("script_model", (1192, 2480, 1008));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip32x32x32", "targetname");
  var_3 = spawn("script_model", (-24, -289.5, 1207));
  var_3.angles = (0, 0, -75);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip32x32x32", "targetname");
  var_5 = spawn("script_model", (-536, -289.5, 1207));
  var_5.angles = (0, 0, -75);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip64x64x8", "targetname");
  var_7 = spawn("script_model", (1436, 3105, 1168));
  var_7.angles = (0, 0, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip64x64x8", "targetname");
  var_9 = spawn("script_model", (1372, 3105, 1168));
  var_9.angles = (0, 0, -90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = spawn("script_model", (428, 1048, 960));
  var_10.angles = (45, 0, 90);
  var_10 setModel("com_plastic_crate_pallet_mp_rivet_patch");
  var_11 = spawn("script_model", (428, 120, 960));
  var_11.angles = (45, 0, 90);
  var_11 setModel("com_plastic_crate_pallet_mp_rivet_patch");
  var_12 = getent("player256x256x256", "targetname");
  var_13 = spawn("script_model", (-448, 2408, 1280));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = spawn("script_model", (-448, 2408, 1536));
  var_14.angles = (0, 0, 0);
  var_14 clonebrushmodeltoscriptmodel(var_12);
  var_15 = spawn("script_model", (-448, 2408, 1792));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_12);
  var_10 = spawn("script_model", (-1050, 1813, 890));
  var_10.angles = (270, 0, 180);
  var_10 setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_11 = spawn("script_model", (-590, 424, 1150));
  var_11.angles = (90, -90, 0);
  var_11 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_12 = getent("player32x32x128", "targetname");
  var_13 = spawn("script_model", (2168, -264, 1440));
  var_13.angles = (0, 0, 25);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player512x512x8", "targetname");
  var_15 = spawn("script_model", (-768, 2320, 1584));
  var_15.angles = (0, 0, -89);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = spawn("script_model", (436, 1416, 1360));
  var_16.angles = (0, 0, -90);
  var_16 setModel("mp_desert_uplink_col_01");
  var_17 = spawn("script_model", (1892, 412, 972));
  var_17.angles = (90, 0, 0);
  var_17 setModel("mp_desert_uplink_col_01");
  var_18 = spawn("script_model", (1892, 412, 1072));
  var_18.angles = (90, 0, 0);
  var_18 setModel("mp_desert_uplink_col_01");
  var_19 = getent("player128x128x8", "targetname");
  var_1A = spawn("script_model", (1098, 453, 1236.5));
  var_1A.angles = (90, 68, -22);
  var_1A clonebrushmodeltoscriptmodel(var_19);
  var_1B = getent("player128x128x8", "targetname");
  var_1C = spawn("script_model", (1098, 453, 1364.5));
  var_1C.angles = (90, 68, -22);
  var_1C clonebrushmodeltoscriptmodel(var_1B);
  var_1D = getent("player512x512x8", "targetname");
  var_1E = spawn("script_model", (1682, 2316, 918));
  var_1E.angles = (0, 0, 0);
  var_1E clonebrushmodeltoscriptmodel(var_1D);
  var_1F = getent("player512x512x8", "targetname");
  var_20 = spawn("script_model", (1970, 1132, 919));
  var_20.angles = (0, 90, 0);
  var_20 clonebrushmodeltoscriptmodel(var_1F);
  var_21 = getent("player32x32x32", "targetname");
  var_22 = spawn("script_model", (1520, 512, 894));
  var_22.angles = (0, 0, 0);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getent("player32x32x32", "targetname");
  var_24 = spawn("script_model", (1354, 1190, 894));
  var_24.angles = (0, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_23);
}

fixyourballs() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    var_0 = spawn("script_model", (424, 1420, 960));
    var_0.angles = (0, 0, 0);
    var_0 setModel("mp_fallen_uplink_col_01");
    var_1 = spawn("script_model", (-2020, 2365, 912));
    var_1.angles = (340, 345, 0);
    var_1 setModel("mp_desert_uplink_col_01");
    var_2 = spawn("script_model", (1594, 2132, 1148));
    var_2.angles = (1.7, 25, -90);
    var_2 setModel("mp_desert_uplink_col_01");
    var_3 = spawn("script_model", (1352, 3112, 1092));
    var_3.angles = (270, 270, 0);
    var_3 setModel("mp_desert_uplink_col_01");
    var_4 = spawn("script_model", (1358, 3112, 992));
    var_4.angles = (270, 270, 0);
    var_4 setModel("mp_desert_uplink_col_01");
    var_5 = spawn("script_model", (1718, 2304, 976));
    var_5.angles = (270, 270, 90);
    var_5 setModel("mp_desert_uplink_col_01");
    var_6 = spawn("script_model", (-738, 1254, 876));
    var_6.angles = (0, 350, 90);
    var_6 setModel("mp_desert_uplink_col_01");
    var_7 = spawn("script_model", (-688, 1808, 720));
    var_7.angles = (315, 180, -90);
    var_7 setModel("mp_fallen_uplink_col_01");
    var_8 = spawn("script_model", (-912, 1472, 720));
    var_8.angles = (315, 0, -90);
    var_8 setModel("mp_fallen_uplink_col_01");
    var_9 = spawn("script_model", (-796, 1904, 720));
    var_9.angles = (315, 90, -90);
    var_9 setModel("mp_fallen_uplink_col_01");
    var_10 = spawn("script_model", (-548, 1904, 720));
    var_10.angles = (315, 90, -90);
    var_10 setModel("mp_fallen_uplink_col_01");
  }
}

spawn_ball_allowed_trigger() {
  wait(1);
  var_0 = spawn("trigger_radius", (409, 1234, 1500), 0, 4000, 500);
  var_1 = spawn("trigger_radius", (-1418, 625, 1240), 0, 700, 500);
  var_0 hide();
  var_1 hide();
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_0;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_1;
}

patchoutofboundstrigger() {
  level.outofboundstriggerpatches = [];
  var_0 = [(2032, 40, 920), (2032, -127, 920), (2032, -278, 920)];
  foreach(var_2 in var_0) {
    var_3 = spawn("trigger_radius", var_2, 0, 150, 500);
    level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_3;
  }

  level waittill("game_ended");
  foreach(var_3 in level.outofboundstriggerpatches) {
    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}