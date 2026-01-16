/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_desert\mp_desert.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_desert\mp_desert_precache::main();
  scripts\mp\maps\mp_desert\gen\mp_desert_art::main();
  scripts\mp\maps\mp_desert\mp_desert_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_desert");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraAccurateOcclusionThreshold", 1200);
  setdvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread func_FAE6("roomba", 32, 1);
  thread func_FAE6("roomba2", 16, 0.15);
  thread fix_collision();
  runmodespecifictriggers();
}

fix_collision() {
  var_0 = getent("clip64x64x128", "targetname");
  var_1 = spawn("script_model", (2342, -92, 354));
  var_1.angles = (2, 50, 2);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip64x64x256", "targetname");
  var_3 = spawn("script_model", (2292, -212, 362));
  var_3.angles = (6, 51, 18);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip256x256x8", "targetname");
  var_5 = spawn("script_model", (996, 796, 524));
  var_5.angles = (0, 335, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = spawn("script_model", (313.1, -516, 470));
  var_6.angles = (356.01, 210.28, -4.00982);
  var_6 setModel("mp_desert_uplink_col_01");
  var_7 = getent("clip512x512x8", "targetname");
  var_8 = spawn("script_model", (896, 656, 584));
  var_8.angles = (0, 0, 0);
  var_8 clonebrushmodeltoscriptmodel(var_7);
  var_9 = spawn("script_model", (1064, 616, 584));
  var_9.angles = (0, 45, 0);
  var_9 clonebrushmodeltoscriptmodel(var_7);
  var_10 = spawn("script_model", (-2841.4, -24.5, 757.2));
  var_10.angles = (303, 309, 145);
  var_10 setModel("rock_large_titan_02_mp_desert_patch");
  var_11 = getent("player32x32x8", "targetname");
  var_12 = spawn("script_model", (-2044, 116, 572));
  var_12.angles = (285, 225, 0);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = spawn("script_model", (-1932, 4, 572));
  var_13.angles = (285, 225, 0);
  var_13 clonebrushmodeltoscriptmodel(var_11);
  var_14 = getent("clip128x128x256", "targetname");
  var_15 = spawn("script_model", (-764, -1376, 712));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_10 = getent("clip128x128x256", "targetname");
  var_11 = spawn("script_model", (1216, -1576, 704));
  var_11.angles = (0, 0, 30);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip128x128x128", "targetname");
  var_13 = spawn("script_model", (1256, -1592, 816));
  var_13.angles = (15, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player256x256x256", "targetname");
  var_15 = spawn("script_model", (1232, -1640, 896));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip256x256x256", "targetname");
  var_17 = spawn("script_model", (72, -8, 832));
  var_17.angles = (15, 300, 15);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("player256x256x256", "targetname");
  var_19 = spawn("script_model", (-1840, -1296, 720));
  var_19.angles = (0, 330, -30);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_1A = getent("player256x256x256", "targetname");
  var_1B = spawn("script_model", (-1776, -1136, 552));
  var_1B.angles = (340, 290, -22);
  var_1B clonebrushmodeltoscriptmodel(var_1A);
  var_1C = spawn("script_model", (832, -464, 712));
  var_1C.angles = (10, 30, 33);
  var_1C setModel("mp_quarry_uplink_02");
  var_1D = spawn("script_model", (1572, -324, 696));
  var_1D.angles = (270, 15, -120);
  var_1D setModel("mp_quarry_uplink_02");
  var_1E = spawn("script_model", (-2292, 256, 368));
  var_1E.angles = (270, 90, 0);
  var_1E setModel("mp_desert_uplink_col_01");
  var_1F = spawn("script_model", (-2108, 256, 308));
  var_1F.angles = (300, 0, 90);
  var_1F setModel("mp_desert_uplink_col_01");
  var_20 = spawn("script_model", (-2748, 704, 448));
  var_20.angles = (0, 195, -180);
  var_20 setModel("mp_desert_uplink_col_01");
  var_21 = getent("player64x64x128", "targetname");
  var_22 = spawn("script_model", (-1376, 1056, 560));
  var_22.angles = (0, 0, 0);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getent("player64x64x128", "targetname");
  var_24 = spawn("script_model", (-2068, -872, 404));
  var_24.angles = (90, 4, 69);
  var_24 clonebrushmodeltoscriptmodel(var_23);
  var_25 = getent("player64x64x128", "targetname");
  var_26 = spawn("script_model", (-910, -75, 392));
  var_26.angles = (1.7, 294, 90);
  var_26 clonebrushmodeltoscriptmodel(var_25);
  var_27 = getent("player128x128x128", "targetname");
  var_28 = spawn("script_model", (-1512, 864, 518));
  var_28.angles = (352, 0, 0);
  var_28 clonebrushmodeltoscriptmodel(var_27);
  var_29 = getent("player64x64x64", "targetname");
  var_2A = spawn("script_model", (232, -246, -58));
  var_2A.angles = (0, 34, 0);
  var_2A clonebrushmodeltoscriptmodel(var_29);
  var_2B = getent("player64x64x64", "targetname");
  var_2C = spawn("script_model", (200, -192, -58));
  var_2C.angles = (0, 30, 0);
  var_2C clonebrushmodeltoscriptmodel(var_2B);
  var_2D = getent("player64x64x128", "targetname");
  var_2E = spawn("script_model", (1109, -1007, 629));
  var_2E.angles = (10, 180, 125);
  var_2E clonebrushmodeltoscriptmodel(var_2D);
  var_2F = getent("player64x64x128", "targetname");
  var_30 = spawn("script_model", (1133, -1147, 637));
  var_30.angles = (90, 88.8, -16);
  var_30 clonebrushmodeltoscriptmodel(var_2F);
  var_31 = getent("player64x64x128", "targetname");
  var_32 = spawn("script_model", (-920, -58, 454));
  var_32.angles = (1.7, 302, 90);
  var_32 clonebrushmodeltoscriptmodel(var_31);
}

func_FAE6(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_3.destination = scripts\engine\utility::getstruct(var_3.target, "targetname");
  var_3.var_BCEF = 1 / var_1;
  var_3.destination = func_E6E1(var_3, var_2);
}

func_E6E1(var_0, var_1) {
  var_0 endon("death");
  var_2 = scripts\engine\utility::getstruct(var_0.destination.target, "targetname");
  var_3 = abs(distance(var_0.origin, var_2.origin) * var_0.var_BCEF);
  var_0 playLoopSound("rolling_bot_move_lp");
  var_0 moveto(var_2.origin, var_3, var_3 * 0.25, var_3 * 0.25);
  wait(var_3);
  var_0 stoploopsound("rolling_bot_move_lp");
  var_0 rotateto(var_2.angles, var_1, 0, 0);
  var_0 playLoopSound("rolling_bot_turn_lp");
  wait(var_1);
  var_0 stoploopsound("rolling_bot_turn_lp");
  return var_2;
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    var_0 = spawn("trigger_radius", (-596, -972, 336), 0, 64, 128);
    var_0.var_336 = "uplink_nozone";
    var_0.angles = (0, 0, 0);
    var_0 hide();
    var_0 = spawn("trigger_radius", (-240, -608, 496), 0, 160, 150);
    var_0.var_336 = "OutOfBounds";
    var_0 hide();
    level.var_C7B3 = scripts\engine\utility::array_add(level.var_C7B3, var_0);
    var_0 = spawn("trigger_radius", (-1088, -1584, 416), 0, 230, 80);
    var_0.var_336 = "OutOfBounds";
    var_0 hide();
    level.var_C7B3 = scripts\engine\utility::array_add(level.var_C7B3, var_0);
    var_0 = spawn("trigger_radius", (-1952, -96, 272), 0, 100, 100);
    var_0.var_336 = "OutOfBounds";
    var_0 hide();
    level.var_C7B3 = scripts\engine\utility::array_add(level.var_C7B3, var_0);
    var_0 = spawn("trigger_radius", (580, -580, 730), 0, 100, 90);
    var_0.var_336 = "OutOfBounds";
    var_0 hide();
    level.var_C7B3 = scripts\engine\utility::array_add(level.var_C7B3, var_0);
  }
}