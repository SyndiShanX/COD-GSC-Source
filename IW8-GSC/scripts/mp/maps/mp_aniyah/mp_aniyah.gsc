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
  var0 = scripts\mp\utility\game::getgametype();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "infect") {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 17);
    }
  } else if(var0 == "dom") {
    setDvar("scr_localeID", 0);
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_aniyah", "codcaster_compass_map_mp_aniyah");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("PKKMTTRQO", 3);
  setDvar("LRKPOKNKRM", 0);
  setDvar("NOSQLKNSQO", 45);
  setDvar("MMNMQTSOSP", 0);
  setDvar("NSSMQLPRNT", 0.01);
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
  var0 = spawn("script_model", (6022.96, -1678.46, 260));
  var0.angles = (0, 280.098, 0);
  var0 setModel("building_wall_corner_brick_01_144_coverup");
  var1 = spawn("script_model", (5644.9, -1745.78, 260));
  var1.angles = (0, 190.098, 0);
  var1 setModel("building_wall_corner_brick_01_144_coverup");
  var2 = spawn("script_model", (5966.85, -1363.41, 260));
  var2.angles = (0, 10.098, 0);
  var2 setModel("building_wall_corner_brick_01_144_coverup");
  var3 = spawn("script_model", (5588.8, -1430.74, 260));
  var3.angles = (0, 100.098, 0);
  var3 setModel("building_wall_corner_brick_01_144_coverup");
  var4 = spawn("script_model", (-605.51, 472.007, 314));
  var4.angles = (0, 80.0989, 0);
  var4 setModel("building_wall_corner_brick_01_144_coverup");
  var5 = spawn("script_model", (-227.229, 405.979, 314));
  var5.angles = (0, 350.099, 0);
  var5 setModel("building_wall_corner_brick_01_144_coverup");
  var6 = spawn("script_model", (-660.533, 156.772, 314));
  var6.angles = (0, 170.099, 0);
  var6 setModel("building_wall_corner_brick_01_144_coverup");
  var7 = spawn("script_model", (-282.252, 90.7446, 314));
  var7.angles = (0, 260.099, 0);
  var7 setModel("building_wall_corner_brick_01_144_coverup");
  var8 = spawn("script_model", (-2146.45, 101.041, 328));
  var8.angles = (0, 190.1, 0);
  var8 setModel("building_wall_corner_brick_01_144_coverup");
  var9 = spawn("script_model", (-2051.81, -256.525, 338));
  var9.angles = (0, 70.0987, 0);
  var9 setModel("building_wall_corner_brick_01_144_coverup");
  var10 = spawn("script_model", (-1881.63, -726.52, 338));
  var10.angles = (0, 250.099, 0);
  var10 setModel("building_wall_corner_brick_01_144_coverup");
  var11 = spawn("script_model", (-1750.92, -365.452, 338));
  var11.angles = (0, 340.099, 0);
  var11 setModel("building_wall_corner_brick_01_144_coverup");
  var12 = spawn("script_model", (-1353.8, 2143.24, 352));
  var12.angles = (0, 285, 0);
  var12 setModel("building_wall_corner_brick_01_128_coverup");
  var13 = spawn("script_model", (-3252.33, -1933.49, 284.5));
  var13.angles = (0, 270, 0);
  var13 setModel("building_wall_corner_brick_01_128_coverup");
}

function deleteinfilclip() {
  level waittill("prematch_countdown");
  var0 = getEnt("infil_clip", "targetname");
  var0 moveTo(var0.origin + (0, 0, -8), 30, 10, 10);
  wait 30;
  var0 hide();
  var0 notsolid();
}

function player_exfil_struct() {
  var0 = getEnt("clip64x64x64", "targetname");
  var1 = spawn("script_model", (2946, 854, 402));
  var1.angles = (0, 325, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip64x64x64", "targetname");
  var3 = spawn("script_model", (2955, 866, 401));
  var3.angles = (0, 325, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("player256x256x8", "targetname");
  var5 = spawn("script_model", (724, -815, 740));
  var5.angles = (90, 270, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("player256x256x8", "targetname");
  var7 = spawn("script_model", (716, 816, 748));
  var7.angles = (90, 270, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("clip32x32x256", "targetname");
  var9 = spawn("script_model", (2658, -675, 188));
  var9.angles = (0, 0, 0);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("clip512x512x8", "targetname");
  var11 = spawn("script_model", (10071, 1247, 102));
  var11.angles = (270, 0, 0);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("nosight128x128x8", "targetname");
  var13 = spawn("script_model", (-4738, -326, 364));
  var13.angles = (270, 164, 176);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("clip64x64x64", "targetname");
  var15 = spawn("script_model", (6412, -1156, 340));
  var15.angles = (0, 25, 0);
  var15 clonebrushmodeltoscriptmodel(var14);
  var16 = getEnt("clip64x64x64", "targetname");
  var17 = spawn("script_model", (6472, -1128, 340));
  var17.angles = (0, 25, 0);
  var17 clonebrushmodeltoscriptmodel(var16);
  var18 = getEnt("clip32x32x32", "targetname");
  var19 = spawn("script_model", (-4367, -112, 347));
  var19.angles = (0, 335, 0);
  var19 clonebrushmodeltoscriptmodel(var18);
  var20 = getEnt("player32x32x256", "targetname");
  var21 = spawn("script_model", (1652, -706, 604));
  var21.angles = (0, 0, 0);
  var21 clonebrushmodeltoscriptmodel(var20);
  var22 = getEnt("player32x32x256", "targetname");
  var23 = spawn("script_model", (1918, 106, 626));
  var23.angles = (0, 0, 0);
  var23 clonebrushmodeltoscriptmodel(var22);
  var24 = getEnt("player256x256x8", "targetname");
  var25 = spawn("script_model", (1670, -267, 458.5));
  var25.angles = (270, 0, 0);
  var25 clonebrushmodeltoscriptmodel(var24);
  var26 = getEnt("clip64x64x64", "targetname");
  var27 = spawn("script_model", (6350, -1276, 234));
  var27.angles = (353, 344, 0);
  var27 clonebrushmodeltoscriptmodel(var26);
  var28 = getEnt("clip64x64x64", "targetname");
  var29 = spawn("script_model", (6416, -1296, 248));
  var29.angles = (0, 344, 0);
  var29 clonebrushmodeltoscriptmodel(var28);
  var30 = getEnt("clip64x64x64", "targetname");
  var31 = spawn("script_model", (6482, -1320, 230));
  var31.angles = (0, 342, 0);
  var31 clonebrushmodeltoscriptmodel(var30);
}

function ref_12f8e() {
  var0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "arm":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (-940, 1828, 292), (0, 9.999, 0), "gw_fob_02_safe_allies", "locale_17"));

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
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-3256, 2796, 264), (0, 19, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}

function ref_136ad() {
  var0 = spawn("trigger_radius", (-2010, 1930, 430), 0, 192, 100);
  thread ref_144ff();
}

function ref_144ff() {
  for(;;) {
    self waittill("trigger", var0);

    if(!isDefined(self.ref_126ce)) {
      self.ref_126ce = [];
    }

    if(scripts\engine\utility::array_contains(self.ref_126ce, var0.guid)) {
      continue;
    }

    self.ref_126ce = scripts\engine\utility::array_add(self.ref_126ce, var0.guid);
    thread ref_14491(var0);
  }
}

function ref_14491(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-2271, 3199, 220);
  var4.radius = 512;
  var3 = var4;
  var5 = [];

  foreach(var7 in var3) {
    var5 = scripts\mp\spawnlogic::addspawndangerzone(var7.origin, var7.radius, 200, var1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var0)) {
    waitframe();
  }

  foreach(var10 in var5) {
    scripts\mp\spawnlogic::removespawndangerzone(var10);
  }

  var0.ref_126ce = scripts\engine\utility::array_remove(var0.ref_126ce, var2);
}

function ref_121f5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var0 = (6426, -1140, 400);
  var1 = spawn("trigger_radius", var0, 0, 100, 128);
  level.outofboundstriggers[level.outofboundstriggers.size] = var1;
}