/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_parkour\mp_parkour.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_parkour\mp_parkour_precache::main();
  scripts\mp\maps\mp_parkour\gen\mp_parkour_art::main();
  scripts\mp\maps\mp_parkour\mp_parkour_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_parkour");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_tessellationCutoffFalloffBase", 600);
  setdvar("r_tessellationCutoffDistanceBase", 2000);
  setdvar("r_tessellationCutoffFalloff", 600);
  setdvar("r_tessellationCutoffDistance", 2000);
  setdvar("r_umbraAccurateOcclusionThreshold", 1200);
  setdvar("r_umbraMinObjectContribution", 6);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread func_90EF("dropship", "dropThrust");
  thread scripts\mp\animation_suite::animationsuite();
  thread func_CDA4("mp_parkour_rules");
  thread fix_collision();
  thread spawn_ball_allowed_trigger();
  thread move_sd_startspawns();
}

fix_collision() {
  var_00 = getent("player512x512x8", "targetname");
  var_01 = spawn("script_model", (-1152, 1656, 768));
  var_01.angles = (0, 315, -90);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("player32x32x8", "targetname");
  var_03 = spawn("script_model", (-652, 3340, -26));
  var_03.angles = (285, 315, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player32x32x8", "targetname");
  var_05 = spawn("script_model", (-795, 2944, -28));
  var_05.angles = (286, 0, 0);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("player512x512x8", "targetname");
  var_07 = spawn("script_model", (864, 152, 832));
  var_07.angles = (0, 45, -90);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = spawn("script_model", (-318, 642.5, 280));
  var_08.angles = (90, 315, -90);
  var_08 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_09 = spawn("script_model", (200, -272, 120));
  var_09.angles = (0, 90, 0);
  var_09 setModel("mp_desert_uplink_col_01");
  var_0A = spawn("script_model", (-225, -3316, 197));
  var_0A.angles = (0, 165, -90);
  var_0A setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_0B = spawn("script_model", (-56, -3361, 197));
  var_0B.angles = (0, 165, -90);
  var_0B setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_0C = spawn("script_model", (-177.5, -3137, 197));
  var_0C.angles = (0, 165, -90);
  var_0C setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_0D = spawn("script_model", (-8.5, -3182, 197));
  var_0D.angles = (0, 165, -90);
  var_0D setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_0E = spawn("script_model", (-378, -3277.5, 197));
  var_0E.angles = (0, 75, -90);
  var_0E setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_0F = spawn("script_model", (-68, -3357.5, 197));
  var_0F.angles = (0, 75, -90);
  var_0F setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_10 = spawn("script_model", (355, 2068, 144));
  var_10.angles = (270, 270, 0);
  var_10 setModel("panel_metal_02_16x176_mp_parkour_patch");
  var_11 = getent("clip64x64x8", "targetname");
  var_12 = spawn("script_model", (784, 2232, 150));
  var_12.angles = (0, 330, 0);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = spawn("script_model", (984, -1504, 240));
  var_13.angles = (350, 30, 0);
  var_13 setModel("mp_desert_uplink_col_01");
  if(scripts\mp\utility::isanymlgmatch()) {
    var_14 = getent("player128x128x8", "targetname");
    var_15 = spawn("script_model", (-1596, 3, 320));
    var_15.angles = (0, 0, 0);
    var_15 clonebrushmodeltoscriptmodel(var_14);
  }
}

func_90EF(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02.areanynavvolumesloaded = var_02.origin;
  var_02.var_10D6C = var_02.angles;
  var_02.var_BE10 = getEntArray(param_01, "targetname");
  var_02.var_BE1E = getEntArray("vfx_drop_ship_thrusters", "script_noteworthy");
  var_02.var_BE10 = scripts\engine\utility::array_combine(var_02.var_BE10, var_02.var_BE1E);
  foreach(var_04 in var_02.var_BE10) {
    var_04 linkto(var_02);
  }

  thread func_5EE7(var_02);
  thread func_5EE1(var_02);
  thread func_5EE9(var_02);
}

func_5EE1(param_00) {
  for(;;) {
    var_01 = randomintrange(4, 10);
    param_00.objective_playermask_hidefromall = param_00.areanynavvolumesloaded + (randomintrange(-16, 16), randomintrange(-16, 16), randomintrange(-8, 32));
    param_00 moveto(param_00.objective_playermask_hidefromall, var_01, var_01 * 0.25, var_01 * 0.25);
    wait(var_01);
  }
}

func_5EE9(param_00) {
  for(;;) {
    var_01 = randomintrange(5, 8);
    param_00.energy_getrestorerate = param_00.var_10D6C + (randomintrange(-5, 0), randomintrange(-3, 3), randomintrange(-4, 4));
    param_00 rotateto(param_00.energy_getrestorerate, var_01, var_01 * 0.25, var_01 * 0.25);
    wait(var_01);
  }
}

func_5EE7(param_00) {
  foreach(var_02 in param_00.var_BE1E) {
    var_02 thread func_5EE8();
  }
}

func_5EE8() {
  wait(5);
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 show();
  var_00 linkto(self);
  scripts\engine\utility::waitframe();
  if(isDefined(self.var_336)) {
    playFXOnTag(scripts\engine\utility::getfx(self.var_336), var_00, "tag_origin");
  }
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

spawn_ball_allowed_trigger() {
  wait(1);
  var_00 = spawn("trigger_radius", (-1589, -1950, 610), 0, 1000, 400);
  var_01 = spawn("trigger_radius", (-1475, -1341, 480), 0, 100, 200);
  var_02 = spawn("trigger_radius", (-1439, -2727, 470), 0, 110, 200);
  var_03 = spawn("trigger_radius", (-1519, -2488, 470), 0, 110, 200);
  var_00 hide();
  var_01 hide();
  var_02 hide();
  var_03 hide();
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_00;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_01;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_02;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_03;
}

move_sd_startspawns() {
  if(level.gametype == "sd" || level.gametype == "sr") {
    wait(0.1);
    var_00 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_attacker");
    foreach(var_02 in var_00) {
      if(distance(var_02.origin, (128, 3136, 166.275)) < 10) {
        var_02.origin = (295, 3625, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (64, 3200, 166.583)) < 10) {
        var_02.origin = (219, 3655, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (64, 3328, 169.539)) < 10) {
        var_02.origin = (135, 3685, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (192, 3136, 157.275)) < 10) {
        var_02.origin = (295, 3711, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (128, 3200, 168.263)) < 10) {
        var_02.origin = (219, 3741, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (64, 3264, 168.306)) < 10) {
        var_02.origin = (135, 3771, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (256, 3136, 156.141)) < 10) {
        var_02.origin = (295, 3797, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (192, 3200, 156.287)) < 10) {
        var_02.origin = (219, 3827, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin + var_03 * 45);
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
        continue;
      }

      if(distance(var_02.origin, (128, 3264, 168.432)) < 10) {
        var_02.origin = (135, 3857, 160);
        var_02.angles = (0, -100, 0);
        var_03 = anglestoright(var_02.angles);
        var_02.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_02, var_02.origin - var_03 * 45);
      }
    }
  }
}