/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_prime\mp_prime.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_prime\mp_prime_precache::main();
  scripts\mp\maps\mp_prime\gen\mp_prime_art::main();
  scripts\mp\maps\mp_prime\mp_prime_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_prime");
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread sfx_club_music();
  thread fix_collision();
}

fix_collision() {
  var_0 = getent("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-708, -1759, 476));
  var_1.angles = (0, 0, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player512x512x8", "targetname");
  var_3 = spawn("script_model", (-708, -1759, 988));
  var_3.angles = (0, 0, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player512x512x8", "targetname");
  var_5 = spawn("script_model", (-708, -1759, 1500));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip32x32x128", "targetname");
  var_7 = spawn("script_model", (-1160, -1616, 232));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip128x128x8", "targetname");
  var_9 = spawn("script_model", (-1000, -1380, 340));
  var_9.angles = (270, 180, 180);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_0A = getent("player64x64x256", "targetname");
  var_0B = spawn("script_model", (-1298, 1862, 156));
  var_0B.angles = (0, 0, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("player64x64x256", "targetname");
  var_0D = spawn("script_model", (-1298, 1862, 412));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("player64x64x256", "targetname");
  var_0F = spawn("script_model", (-1298, 1862, 668));
  var_0F.angles = (0, 0, 0);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
  var_10 = getent("clip64x64x64", "targetname");
  var_11 = spawn("script_model", (-156, 2484, -8));
  var_11.angles = (0, 225, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip64x64x64", "targetname");
  var_13 = spawn("script_model", (-188, 2520, -8));
  var_13.angles = (0, 10, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = spawn("script_model", (0, 0, 0));
  var_14.angles = (0, 0, 0);
  var_14 setModel("mp_prime_umbra_1");
  var_14 = spawn("script_model", (1374, 3005, 16));
  var_14.angles = (0, 0, 0);
  var_14 setModel("mp_prime_umbra_2");
  var_15 = getent("clip512x512x8", "targetname");
  var_16 = spawn("script_model", (-1321, 39, -183));
  var_16.angles = (89.9999, 0, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getent("clip512x512x8", "targetname");
  var_18 = spawn("script_model", (-1321, 516, -216));
  var_18.angles = (89.9999, 0, 0);
  var_18 clonebrushmodeltoscriptmodel(var_17);
  var_19 = getent("clip256x256x8", "targetname");
  var_1A = spawn("script_model", (392, 2312, 448));
  var_1A.angles = (0, 0, 94);
  var_1A clonebrushmodeltoscriptmodel(var_19);
  var_1B = getent("clip128x128x8", "targetname");
  var_1C = spawn("script_model", (1116, -1008, 328));
  var_1C.angles = (277, 180, 180);
  var_1C clonebrushmodeltoscriptmodel(var_1B);
  var_1D = getent("clip128x128x8", "targetname");
  var_1E = spawn("script_model", (30, -590, 300));
  var_1E.angles = (277, 360, -180);
  var_1E clonebrushmodeltoscriptmodel(var_1D);
  var_1F = spawn("script_model", (1382, -277, -128));
  var_1F.angles = (0, 270, 0);
  var_1F setModel("mp_prime_cart");
  var_20 = getent("player32x32x128", "targetname");
  var_21 = spawn("script_model", (1270, 1428, 236));
  var_21.angles = (0, 0, 7.99996);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getent("clip64x64x64", "targetname");
  var_23 = spawn("script_model", (328, 3344, 166));
  var_23.angles = (0, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getent("clip256x256x256", "targetname");
  var_25 = spawn("script_model", (1736, 3528, -128));
  var_25.angles = (0, 0, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getent("clip256x256x256", "targetname");
  var_27 = spawn("script_model", (1736, 3528, 128));
  var_27.angles = (0, 0, 0);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getent("clip32x32x128", "targetname");
  var_29 = spawn("script_model", (536, 12, -8));
  var_29.angles = (90, 0, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_2A = getent("clip64x64x64", "targetname");
  var_2B = spawn("script_model", (442, -1696, 88));
  var_2B.angles = (0, 0, 0);
  var_2B clonebrushmodeltoscriptmodel(var_2A);
  var_2C = getent("clip32x32x8", "targetname");
  var_2D = spawn("script_model", (469, -1696, 144));
  var_2D.angles = (0, 0, 0);
  var_2D clonebrushmodeltoscriptmodel(var_2C);
  var_2E = getent("clip32x32x128", "targetname");
  var_2F = spawn("script_model", (657, 1315, -32));
  var_2F.angles = (270, 0, 0);
  var_2F clonebrushmodeltoscriptmodel(var_2E);
  var_28 = getent("clip32x32x128", "targetname");
  var_29 = spawn("script_model", (536, -20, -2));
  var_29.angles = (90, 0, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_2E = getent("clip32x32x128", "targetname");
  var_2F = spawn("script_model", (657, 1347, -26));
  var_2F.angles = (270, 0, 0);
  var_2F clonebrushmodeltoscriptmodel(var_2E);
}

wr_mover_setup() {
  thread func_5CC7("wr_mover", "wr_mover_start", 200, undefined, undefined);
  wait(60);
  thread func_5CC7("wr_mover_1", "wr_mover_start", 200, undefined, undefined);
  wait(60);
  thread func_5CC7("wr_mover_2", "wr_mover_start", 200, undefined, undefined);
}

func_5CC7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getent(var_0, "targetname");
  if(isDefined(var_3)) {
    var_5.var_4380 = getent(var_3, "targetname");
    var_5.var_4380 linkto(var_5);
  }

  var_6 = 1 / var_2;
  var_5.var_C72D = scripts\engine\utility::getstruct(var_1, "targetname");
  var_5 moveto(var_5.var_C72D.origin, 0.1, 0, 0);
  var_5 rotateto(var_5.var_C72D.angles, 0.1, 0, 0);
  var_5.getclosestpointonnavmesh3d = 0;
  wait(0.5);
  if(isDefined(var_4)) {
    var_5 playLoopSound(var_4);
  }

  var_5.destination = var_5.var_C72D;
  var_5.destination = func_5CBC(var_5, var_5.destination, var_6);
}

func_5CBC(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  if(isDefined(var_3.target)) {
    var_4 = abs(distance(var_0.origin, var_3.origin) * var_2);
    var_0 moveto(var_3.origin, var_4, 0, 0);
    var_0 rotateto(var_3.angles, var_4, 0, 0);
    wait(var_4);
    return var_3;
  }

  var_1 hide();
  if(isDefined(var_1.var_4380)) {
    var_1.var_4380 notsolid();
  }

  wait(1);
  var_1.origin = var_1.var_C72D.origin;
  var_1.angles = var_1.var_C72D.angles;
  wait(1);
  var_1 show();
  if(isDefined(var_1.var_4380)) {
    var_1.var_4380 solid();
  }

  return var_1.var_C72D;
}

sfx_club_music() {
  var_0 = spawn("script_origin", (1200, 703, 238));
  scripts\engine\utility::waitframe();
  var_0 playLoopSound("emt_mus_prime_club");
}