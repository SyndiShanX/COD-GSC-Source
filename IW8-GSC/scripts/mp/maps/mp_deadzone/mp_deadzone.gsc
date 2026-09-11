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
  setDvar("PKKMTTRQO", 8);
  setDvar("NKLMONNPNN", 768);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("NOSQLKNSQO", 45);
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

  var0 = getnodesinradius((-130, 1850, 400), 200, 0, 200);

  foreach(var2 in var0) {
    if(isDefined(var2.animscript) && (var2.animscript == "jump_up_80" || var2.animscript == "jump_down_80")) {
      destroynavlink(var2);
    }
  }
}

function incorrectswitch() {
  var0 = spawn("script_model", (-73.0545, -2981.88, 410.847));
  var0.angles = (0, 0, 0);
  var0 setModel("roof_shingles_01_deadzone_coverup");
  var1 = spawn("script_model", (-73.0545, -2981.88, 410.847));
  var1.angles = (0, 0, 0);
  var1 setModel("roof_shingles_01_deadzone_coverup_b");
}

function windmilllinkcol() {
  var0 = getEnt("wind", "script_noteworthy");
  var1 = getEnt("windcoll", "targetname");
  var1 linkTo(var0);
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
  var0 = getEnt("clip128x128x256", "targetname");
  var1 = spawn("script_model", (54, 1702, 353));
  var1.angles = (276, 90, 90);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip64x64x256", "targetname");
  var3 = spawn("script_model", (1828, 1564, 432));
  var3.angles = (0, 315, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("nosight128x128x8", "targetname");
  var5 = spawn("script_model", (-636, 266, 442));
  var5.angles = (0, 270, 90);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("nosight128x128x8", "targetname");
  var7 = spawn("script_model", (-618, 276, 442));
  var7.angles = (0, 270, 90);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("nosight128x128x8", "targetname");
  var9 = spawn("script_model", (-618, 248, 442));
  var9.angles = (0, 0, 90);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("nosight128x128x8", "targetname");
  var11 = spawn("script_model", (-608, 266, 442));
  var11.angles = (0, 0, 90);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("nosight128x128x8", "targetname");
  var13 = spawn("script_model", (1920, -1367, 524));
  var13.angles = (330.796, 277.762, 89.9931);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("nosight128x128x8", "targetname");
  var15 = spawn("script_model", (1926, -1412, 524));
  var15.angles = (299.999, 277.769, 89.9912);
  var15 clonebrushmodeltoscriptmodel(var14);
  var16 = getEnt("nosight128x128x8", "targetname");
  var17 = spawn("script_model", (1551.5, -1029, 396));
  var17.angles = (360, 7.99995, -90.0002);
  var17 clonebrushmodeltoscriptmodel(var16);
  var18 = getEnt("nosight128x128x8", "targetname");
  var19 = spawn("script_model", (-1720, -232, 592));
  var19.angles = (360, 3.00002, -89.9997);
  var19 clonebrushmodeltoscriptmodel(var18);
  var20 = getEnt("nosight128x128x8", "targetname");
  var21 = spawn("script_model", (-1770, 270, 592));
  var21.angles = (360, 4.2995, 89.9997);
  var21 clonebrushmodeltoscriptmodel(var20);
  var22 = getEnt("nosight128x128x8", "targetname");
  var23 = spawn("script_model", (1479, -1039, 396));
  var23.angles = (360, 7.99995, -90.0002);
  var23 clonebrushmodeltoscriptmodel(var22);
  var24 = getEnt("nosight128x128x8", "targetname");
  var25 = spawn("script_model", (1551.5, -1029, 489));
  var25.angles = (360, 7.99995, -90.0002);
  var25 clonebrushmodeltoscriptmodel(var24);
  var26 = getEnt("nosight128x128x8", "targetname");
  var27 = spawn("script_model", (1479, -1039, 489));
  var27.angles = (360, 7.99995, -90.0002);
  var27 clonebrushmodeltoscriptmodel(var26);
  var28 = getEnt("clip64x64x256", "targetname");
  var29 = spawn("script_model", (-1476.5, 2738.5, 632));
  var29.angles = (0, 0, 0);
  var29 clonebrushmodeltoscriptmodel(var28);
}

function battle_tracks_vehicleoccupancyenter() {
  var0 = [];

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
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-2424, 1568, 458.505), (0, 300, 0)));

    case "dom":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_secondary", (-2424, 1568, 458.505), (0, 300, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}