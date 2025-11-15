/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_fallen\mp_fallen.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_fallen\mp_fallen_precache::main();
  scripts\mp\maps\mp_fallen\gen\mp_fallen_art::main();
  scripts\mp\maps\mp_fallen\mp_fallen_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_fallen");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraaccurateocclusionthreshold", 400);
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
  var_00 = spawn("script_origin", (1583, 253, 988));
  var_00 playLoopSound("amb_mp_fallen_pa_amb");
}

func_CBF3() {
  var_00 = scripts\engine\utility::getstruct("pitching_machine", "script_noteworthy");
  if(isDefined(var_00)) {
    var_00 thread func_CBF1();
  }
}

func_CBF1() {
  level endon("game_ended");
  precachemodel("baseball_single_fn_01_dyn");
  level waittill("connected", var_00);
  var_01 = func_CBF0();
  var_02 = getEntArray("pitching_wheel", "script_noteworthy");
  foreach(var_04 in var_02) {
    var_04.physicsactivated = 0;
  }

  for(;;) {
    for(var_06 = 0; var_06 < 5; var_06++) {
      wait(5);
      var_01[var_06] notify("pitching_machine_ball_reset");
      thread func_CBF2(var_01[var_06]);
    }
  }
}

func_CBF0() {
  var_00 = [];
  for(var_01 = 0; var_01 < 5; var_01++) {
    var_00[var_01] = func_CBF4();
  }

  return var_00;
}

func_CBF4() {
  var_00 = spawn("script_model", self.origin);
  var_00 setModel("baseball_single_fn_01_dyn");
  var_00.var_9037 = spawn("trigger_radius", self.origin, 0, 40, 40);
  var_00.var_9037 enablelinkto();
  var_00.var_9037 linkto(var_00);
  var_00 hide();
  return var_00;
}

func_CBF2(param_00) {
  param_00.physicsactivated = 0;
  param_00 hide();
  param_00.origin = self.origin;
  var_01 = anglesToForward(self.angles);
  var_02 = 2000 + randomint(500) * var_01;
  scripts\engine\utility::waitframe();
  param_00 show();
  param_00 thread func_139A8();
  param_00 thread func_139A9();
  param_00 physicslaunchserver(self.origin, var_02);
  param_00.physicsactivated = 1;
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
    self.var_9037 waittill("trigger", var_00);
    if(isplayer(var_00) && scripts\mp\utility::isreallyalive(var_00)) {
      var_00 dodamage(35, self.origin, self, self, "MOD_IMPACT");
      thread func_10830(self.origin);
      break;
    }
  }
}

func_10830(param_00) {
  self hide();
  var_01 = spawn("script_model", param_00);
  var_01 setModel("baseball_single_fn_01_dyn");
  var_01.physicsactivated = 1;
  var_02 = (0, 0, 0);
  var_01 physicslaunchserver(param_00, var_02);
  self waittill("pitching_machine_ball_reset");
  var_01 delete();
}

func_10A0E(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  for(;;) {
    var_02 rotatepitch(-360, param_01, 0, 0);
    wait(1);
  }
}

func_F9BA() {
  level.var_A582 = 600;
  level.var_A583 = 1200;
  level.var_BF47 = -1;
  var_00 = getEntArray("beer_keg", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread func_13957();
  }
}

func_13957() {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04);
    if(!issubstr(var_04, "BULLET")) {
      continue;
    }

    if(!func_3827()) {
      continue;
    }

    var_05 = func_7A63(var_01, var_02, var_03);
    if(!isDefined(var_05)) {
      continue;
    }

    func_B27C();
    var_05 = vectortoangles(var_05);
    playFX(level._effect["vfx_imp_sm_beer_pallet"], var_03, anglesToForward(var_05), anglestoup(var_05));
    playFX(level._effect["vfx_fallen_beer_stream"], var_03, anglesToForward(var_05), anglestoup(var_05));
    playsoundatpos(var_03, "emt_beer_puncture");
  }
}

func_7A63(param_00, param_01, param_02) {
  var_03 = param_00.origin;
  var_04 = param_02 - var_03;
  var_05 = bulletTrace(var_03, var_03 + 1.5 * var_04, 0, param_00, 0);
  if(isDefined(var_05["normal"]) && isDefined(var_05["entity"]) && var_05["entity"] == self) {
    return var_05["normal"];
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
  var_00 = getent("clip32x32x32", "targetname");
  var_01 = spawn("script_model", (1192, 2480, 1008));
  var_01.angles = (0, 0, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("clip32x32x32", "targetname");
  var_03 = spawn("script_model", (-24, -289.5, 1207));
  var_03.angles = (0, 0, -75);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("clip32x32x32", "targetname");
  var_05 = spawn("script_model", (-536, -289.5, 1207));
  var_05.angles = (0, 0, -75);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("clip64x64x8", "targetname");
  var_07 = spawn("script_model", (1436, 3105, 1168));
  var_07.angles = (0, 0, -90);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("clip64x64x8", "targetname");
  var_09 = spawn("script_model", (1372, 3105, 1168));
  var_09.angles = (0, 0, -90);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = spawn("script_model", (428, 1048, 960));
  var_0A.angles = (45, 0, 90);
  var_0A setModel("com_plastic_crate_pallet_mp_rivet_patch");
  var_0B = spawn("script_model", (428, 120, 960));
  var_0B.angles = (45, 0, 90);
  var_0B setModel("com_plastic_crate_pallet_mp_rivet_patch");
  var_0C = getent("player256x256x256", "targetname");
  var_0D = spawn("script_model", (-448, 2408, 1280));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = spawn("script_model", (-448, 2408, 1536));
  var_0E.angles = (0, 0, 0);
  var_0E clonebrushmodeltoscriptmodel(var_0C);
  var_0F = spawn("script_model", (-448, 2408, 1792));
  var_0F.angles = (0, 0, 0);
  var_0F clonebrushmodeltoscriptmodel(var_0C);
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
    var_00 = spawn("script_model", (424, 1420, 960));
    var_00.angles = (0, 0, 0);
    var_00 setModel("mp_fallen_uplink_col_01");
    var_01 = spawn("script_model", (-2020, 2365, 912));
    var_01.angles = (340, 345, 0);
    var_01 setModel("mp_desert_uplink_col_01");
    var_02 = spawn("script_model", (1594, 2132, 1148));
    var_02.angles = (1.7, 25, -90);
    var_02 setModel("mp_desert_uplink_col_01");
    var_03 = spawn("script_model", (1352, 3112, 1092));
    var_03.angles = (270, 270, 0);
    var_03 setModel("mp_desert_uplink_col_01");
    var_04 = spawn("script_model", (1358, 3112, 992));
    var_04.angles = (270, 270, 0);
    var_04 setModel("mp_desert_uplink_col_01");
    var_05 = spawn("script_model", (1718, 2304, 976));
    var_05.angles = (270, 270, 90);
    var_05 setModel("mp_desert_uplink_col_01");
    var_06 = spawn("script_model", (-738, 1254, 876));
    var_06.angles = (0, 350, 90);
    var_06 setModel("mp_desert_uplink_col_01");
    var_07 = spawn("script_model", (-688, 1808, 720));
    var_07.angles = (315, 180, -90);
    var_07 setModel("mp_fallen_uplink_col_01");
    var_08 = spawn("script_model", (-912, 1472, 720));
    var_08.angles = (315, 0, -90);
    var_08 setModel("mp_fallen_uplink_col_01");
    var_09 = spawn("script_model", (-796, 1904, 720));
    var_09.angles = (315, 90, -90);
    var_09 setModel("mp_fallen_uplink_col_01");
    var_0A = spawn("script_model", (-548, 1904, 720));
    var_0A.angles = (315, 90, -90);
    var_0A setModel("mp_fallen_uplink_col_01");
  }
}

spawn_ball_allowed_trigger() {
  wait(1);
  var_00 = spawn("trigger_radius", (409, 1234, 1500), 0, 4000, 500);
  var_01 = spawn("trigger_radius", (-1418, 625, 1240), 0, 700, 500);
  var_00 hide();
  var_01 hide();
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_00;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_01;
}

patchoutofboundstrigger() {
  level.outofboundstriggerpatches = [];
  var_00 = [(2032, 40, 920), (2032, -127, 920), (2032, -278, 920)];
  foreach(var_02 in var_00) {
    var_03 = spawn("trigger_radius", var_02, 0, 150, 500);
    level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_03;
  }

  level waittill("game_ended");
  foreach(var_03 in level.outofboundstriggerpatches) {
    if(isDefined(var_03)) {
      var_03 delete();
    }
  }
}