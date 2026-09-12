/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_aniyah\mp_aniyah.gsc
***************************************************/

function main() {
  _start_spawn_modules::keypad_check_levelinput();
  level.music_style = "middle_east";
  scripts\mp\maps\mp_aniyah\mp_aniyah_precache::main();
  scripts\mp\maps\mp_aniyah\gen\mp_aniyah_art::main();
  scripts\mp\maps\mp_aniyah\mp_aniyah_fx::main();
  scripts\mp\maps\mp_aniyah\mp_aniyah_lighting::main();
  scripts\mp\load::main();
  var_0 = scripts\mp\utility\game::getgametype();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "infect") {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 17);
    }
  } else if(var_0 == "dom") {
    setDvar("scr_localeID", 0);
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_aniyah", "codcaster_compass_map_mp_aniyah");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("r_umbraMinObjectContribution", 3);
  setDvar("r_identifyOldMaterial", 0);
  setDvar("r_tessellationFactor", 45);
  setDvar("r_tessellation", 0);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  thread incorrectswitch();
  thread deleteinfilclip();
  thread player_exfil_struct();
  thread ref_12f8e();
  thread ref_136ad();
  thread ref_121f5();
}

function incorrectswitch() {
  var_0 = spawn("script_model", (6022.96, -1678.46, 260));
  var_0.angles = (0, 280.098, 0);
  var_0 setModel("building_wall_corner_brick_01_144_coverup");
  var_1 = spawn("script_model", (5644.9, -1745.78, 260));
  var_1.angles = (0, 190.098, 0);
  var_1 setModel("building_wall_corner_brick_01_144_coverup");
  var_2 = spawn("script_model", (5966.85, -1363.41, 260));
  var_2.angles = (0, 10.098, 0);
  var_2 setModel("building_wall_corner_brick_01_144_coverup");
  var_3 = spawn("script_model", (5588.8, -1430.74, 260));
  var_3.angles = (0, 100.098, 0);
  var_3 setModel("building_wall_corner_brick_01_144_coverup");
  var_4 = spawn("script_model", (-605.51, 472.007, 314));
  var_4.angles = (0, 80.0989, 0);
  var_4 setModel("building_wall_corner_brick_01_144_coverup");
  var_5 = spawn("script_model", (-227.229, 405.979, 314));
  var_5.angles = (0, 350.099, 0);
  var_5 setModel("building_wall_corner_brick_01_144_coverup");
  var_6 = spawn("script_model", (-660.533, 156.772, 314));
  var_6.angles = (0, 170.099, 0);
  var_6 setModel("building_wall_corner_brick_01_144_coverup");
  var_7 = spawn("script_model", (-282.252, 90.7446, 314));
  var_7.angles = (0, 260.099, 0);
  var_7 setModel("building_wall_corner_brick_01_144_coverup");
  var_8 = spawn("script_model", (-2146.45, 101.041, 328));
  var_8.angles = (0, 190.1, 0);
  var_8 setModel("building_wall_corner_brick_01_144_coverup");
  var_9 = spawn("script_model", (-2051.81, -256.525, 338));
  var_9.angles = (0, 70.0987, 0);
  var_9 setModel("building_wall_corner_brick_01_144_coverup");
  var_10 = spawn("script_model", (-1881.63, -726.52, 338));
  var_10.angles = (0, 250.099, 0);
  var_10 setModel("building_wall_corner_brick_01_144_coverup");
  var_11 = spawn("script_model", (-1750.92, -365.452, 338));
  var_11.angles = (0, 340.099, 0);
  var_11 setModel("building_wall_corner_brick_01_144_coverup");
  var_12 = spawn("script_model", (-1353.8, 2143.24, 352));
  var_12.angles = (0, 285, 0);
  var_12 setModel("building_wall_corner_brick_01_128_coverup");
  var_13 = spawn("script_model", (-3252.33, -1933.49, 284.5));
  var_13.angles = (0, 270, 0);
  var_13 setModel("building_wall_corner_brick_01_128_coverup");
}

function deleteinfilclip() {
  level waittill("prematch_countdown");
  var_0 = getEnt("infil_clip", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, -8), 30, 10, 10);
  wait 30;
  var_0 hide();
  var_0 notsolid();
}

function player_exfil_struct() {
  var_0 = getEnt("clip64x64x64", "targetname");
  var_1 = spawn("script_model", (2946, 854, 402));
  var_1.angles = (0, 325, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x64", "targetname");
  var_3 = spawn("script_model", (2955, 866, 401));
  var_3.angles = (0, 325, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player256x256x8", "targetname");
  var_5 = spawn("script_model", (724, -815, 740));
  var_5.angles = (90, 270, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("player256x256x8", "targetname");
  var_7 = spawn("script_model", (716, 816, 748));
  var_7.angles = (90, 270, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("clip32x32x256", "targetname");
  var_9 = spawn("script_model", (2658, -675, 188));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("clip512x512x8", "targetname");
  var_11 = spawn("script_model", (10071, 1247, 102));
  var_11.angles = (270, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("nosight128x128x8", "targetname");
  var_13 = spawn("script_model", (-4738, -326, 364));
  var_13.angles = (270, 164, 176);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("clip64x64x64", "targetname");
  var_15 = spawn("script_model", (6412, -1156, 340));
  var_15.angles = (0, 25, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("clip64x64x64", "targetname");
  var_17 = spawn("script_model", (6472, -1128, 340));
  var_17.angles = (0, 25, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("clip32x32x32", "targetname");
  var_19 = spawn("script_model", (-4367, -112, 347));
  var_19.angles = (0, 335, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("player32x32x256", "targetname");
  var_21 = spawn("script_model", (1652, -706, 604));
  var_21.angles = (0, 0, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("player32x32x256", "targetname");
  var_23 = spawn("script_model", (1918, 106, 626));
  var_23.angles = (0, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("player256x256x8", "targetname");
  var_25 = spawn("script_model", (1670, -267, 458.5));
  var_25.angles = (270, 0, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getEnt("clip64x64x64", "targetname");
  var_27 = spawn("script_model", (6350, -1276, 234));
  var_27.angles = (353, 344, 0);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getEnt("clip64x64x64", "targetname");
  var_29 = spawn("script_model", (6416, -1296, 248));
  var_29.angles = (0, 344, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_30 = getEnt("clip64x64x64", "targetname");
  var_31 = spawn("script_model", (6482, -1320, 230));
  var_31.angles = (0, 342, 0);
  var_31 clonebrushmodeltoscriptmodel(var_30);
}

function ref_12f8e() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "arm":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (-940, 1828, 292), (0, 9.999, 0), "gw_fob_02_safe_allies", "locale_17"));

    case "war":
      level.modifiedspawnpoints["-3256 2796"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-3637 2049"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-2672 1464"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-3328 996"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-3956 797"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-4724 -26"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-4092 981"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-3768 1116"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["8468 1500"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["8608 640"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["9452 252"]["mp_tdm_spawn"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-3256, 2796, 264), (0, 19, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function ref_136ad() {
  var_0 = spawn("trigger_radius", (-2010, 1930, 430), 0, 192, 100);
  thread ref_144ff();
}

function ref_144ff() {
  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(self.ref_126ce)) {
      self.ref_126ce = [];
    }

    if(scripts\engine\utility::array_contains(self.ref_126ce, var_0.guid)) {
      continue;
    }

    self.ref_126ce = scripts\engine\utility::array_add(self.ref_126ce, var_0.guid);
    thread ref_14491(var_0);
  }
}

function ref_14491(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-2271, 3199, 220);
  var_4.radius = 512;
  var_3 = var_4;
  var_5 = [];

  foreach(var_7 in var_3) {
    var_5 = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 200, var_1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var_0)) {
    waitframe();
  }

  foreach(var_10 in var_5) {
    scripts\mp\spawnlogic::removespawndangerzone(var_10);
  }

  var_0.ref_126ce = scripts\engine\utility::array_remove(var_0.ref_126ce, var_2);
}

function ref_121f5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var_0 = (6426, -1140, 400);
  var_1 = spawn("trigger_radius", var_0, 0, 100, 128);
  level.outofboundstriggers[level.outofboundstriggers.size] = var_1;
}