/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_deadzone\mp_deadzone.gsc
*******************************************************/

function main() {
  _start_rooftop_raid_heli::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  level.music_style = "eastern_europe";
  scripts\mp\maps\mp_deadzone\mp_deadzone_precache::main();
  scripts\mp\maps\mp_deadzone\gen\mp_deadzone_art::main();
  scripts\mp\maps\mp_deadzone\mp_deadzone_fx::main();
  scripts\mp\maps\mp_deadzone\mp_deadzone_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_deadzone", "codcaster_compass_map_mp_deadzone");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 768);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("r_tessellationFactor", 45);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread player_exfil_struct();
  thread incorrectswitch();
  battle_tracks_vehicleoccupancyenter(level);
  windmilllinkcol();

  if(scripts\mp\utility\game::getgametype() == "br") {
    brinit();
  }

  var_0 = getnodesinradius((-130, 1850, 400), 200, 0, 200);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.animscript) && (var_2.animscript == "jump_up_80" || var_2.animscript == "jump_down_80")) {
      destroynavlink(var_2);
    }
  }
}

function incorrectswitch() {
  var_0 = spawn("script_model", (-73.0545, -2981.88, 410.847));
  var_0.angles = (0, 0, 0);
  var_0 setModel("roof_shingles_01_deadzone_coverup");
  var_1 = spawn("script_model", (-73.0545, -2981.88, 410.847));
  var_1.angles = (0, 0, 0);
  var_1 setModel("roof_shingles_01_deadzone_coverup_b");
}

function windmilllinkcol() {
  var_0 = getEnt("wind", "script_noteworthy");
  var_1 = getEnt("windcoll", "targetname");
  var_1 linkTo(var_0);
}

function brinit() {
  scripts\mp\door::door_system_init("retract_door_trigger");
  level.br_level = spawnStruct();
  level.br_level.copterpath = [(2202.03, -556.476, 1793.91), (2097.7, -138.627, 1793.91), (1838.1, 202.261, 1793.91), (1656.1, 681.495, 1793.91), (1292.53, 1214.28, 1793.91), (1095.45, 1794.95, 1793.91), (886.622, 2519.31, 1793.91), (307.793, 3026.63, 1793.91), (-415.485, 3126.58, 1793.91), (-860.034, 2672.91, 1793.91), (-1099.85, 2211.41, 1793.91), (-1611.58, 1827.99, 1793.91), (-1652.05, 1171.92, 1793.91), (-1620.95, 388.386, 1793.91), (-1685.17, -262.896, 1793.91), (-1709.18, -1018.64, 1793.91), (-1500.51, -1753.17, 1793.91), (-1488.46, -2271.66, 1793.91), (-861.884, -2868.1, 1793.91), (-240.021, -3248.69, 1793.91), (517.867, -2690.86, 1793.91), (960.791, -1925.54, 1793.91), (1142.82, -1727.82, 1793.91)];
  level.br_level.br_mapbounds = [];
  level.br_level.br_mapbounds[0] = (801, 3472, 0);
  level.br_level.br_mapbounds[1] = (-2967, -3646, 0);
  level.br_level.br_guncount = 40;
  level.br_level.br_circleclosetimes = [20, 20, 15, 10];
  level.br_level.br_circledelaytimes = [90, 35, 20, 20];
  level.br_level.br_circleradii = [4800, 1500, 1020, 480, 0];
  level.br_level.br_circlestaticvfx = ["vfx_br_zone_static_0", "vfx_br_zone_static_1", "vfx_br_zone_static_2", "vfx_br_zone_static_3"];
  level.br_level.br_circledynamicvfx = ["vfx_br_zone_0_1", "vfx_br_zone_1_2", "vfx_br_zone_2_3", "vfx_br_zone_3_4"];
  level.br_level.br_circleinnervfx = ["vfx_br_inner_zone_0", "vfx_br_inner_zone_1", "vfx_br_inner_zone_2"];
}

function player_exfil_struct() {
  var_0 = getEnt("clip128x128x256", "targetname");
  var_1 = spawn("script_model", (54, 1702, 353));
  var_1.angles = (276, 90, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x256", "targetname");
  var_3 = spawn("script_model", (1828, 1564, 432));
  var_3.angles = (0, 315, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("nosight128x128x8", "targetname");
  var_5 = spawn("script_model", (-636, 266, 442));
  var_5.angles = (0, 270, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("nosight128x128x8", "targetname");
  var_7 = spawn("script_model", (-618, 276, 442));
  var_7.angles = (0, 270, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("nosight128x128x8", "targetname");
  var_9 = spawn("script_model", (-618, 248, 442));
  var_9.angles = (0, 0, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("nosight128x128x8", "targetname");
  var_11 = spawn("script_model", (-608, 266, 442));
  var_11.angles = (0, 0, 90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("nosight128x128x8", "targetname");
  var_13 = spawn("script_model", (1920, -1367, 524));
  var_13.angles = (330.796, 277.762, 89.9931);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("nosight128x128x8", "targetname");
  var_15 = spawn("script_model", (1926, -1412, 524));
  var_15.angles = (299.999, 277.769, 89.9912);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("nosight128x128x8", "targetname");
  var_17 = spawn("script_model", (1551.5, -1029, 396));
  var_17.angles = (360, 7.99995, -90.0002);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("nosight128x128x8", "targetname");
  var_19 = spawn("script_model", (-1720, -232, 592));
  var_19.angles = (360, 3.00002, -89.9997);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("nosight128x128x8", "targetname");
  var_21 = spawn("script_model", (-1770, 270, 592));
  var_21.angles = (360, 4.2995, 89.9997);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("nosight128x128x8", "targetname");
  var_23 = spawn("script_model", (1479, -1039, 396));
  var_23.angles = (360, 7.99995, -90.0002);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("nosight128x128x8", "targetname");
  var_25 = spawn("script_model", (1551.5, -1029, 489));
  var_25.angles = (360, 7.99995, -90.0002);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getEnt("nosight128x128x8", "targetname");
  var_27 = spawn("script_model", (1479, -1039, 489));
  var_27.angles = (360, 7.99995, -90.0002);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getEnt("clip64x64x256", "targetname");
  var_29 = spawn("script_model", (-1476.5, 2738.5, 632));
  var_29.angles = (0, 0, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
}

function battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "tjugg":
    case "cranked":
    case "infect":
    case "tdef":
    case "grnd":
    case "grind":
    case "conf":
    case "war":
    case "sr":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-2424, 1568, 458.505), (0, 300, 0)));

    case "dom":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_secondary", (-2424, 1568, 458.505), (0, 300, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}