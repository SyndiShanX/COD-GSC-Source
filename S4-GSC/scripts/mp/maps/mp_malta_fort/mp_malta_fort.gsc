/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_malta_fort\mp_malta_fort.gsc
***********************************************************/

main() {
  scripts\mp\maps\mp_malta_fort\mp_malta_fort_precache::main();
  scripts\mp\maps\mp_malta_fort\gen\mp_malta_fort_art::main();
  scripts\mp\maps\mp_malta_fort\mp_malta_fort_fx::main();
  scripts\mp\maps\mp_malta_fort\mp_malta_fort_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_malta_fort");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("mantle_force_legacy_system", 1);
  setDvar("#x3e634b52165a47381", 4096);
  setDvar("#x3d2f3327c3c633b22", 4096);
  level.airstrikeheightoffset = 500;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 1;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  thread fixcollision();
  thread fixcollision2();
  thread fixcollision3();
  thread fixcollision4();
  thread fixcollision5();
}

fixcollision() {
  var_0 = getent("clip128x128x128", "targetname");
  var_1 = spawn("script_model", (1038, -508, 636));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip128x128x128", "targetname");
  var_3 = spawn("script_model", (910, -508, 636));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip128x128x128", "targetname");
  var_5 = spawn("script_model", (782, -508, 636));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip128x128x128", "targetname");
  var_7 = spawn("script_model", (636, -522, 636));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip128x128x128", "targetname");
  var_9 = spawn("script_model", (518, -514, 636));
  var_9.angles = (0, 352, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip128x128x128", "targetname");
  var_11 = spawn("script_model", (-762, -554, 719));
  var_11.angles = (0, 179.8, 90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip128x128x128", "targetname");
  var_13 = spawn("script_model", (-1176, -621, 622));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip128x128x128", "targetname");
  var_15 = spawn("script_model", (-1176, -493, 622));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip128x128x8", "targetname");
  var_17 = spawn("script_model", (147, -367, 832));
  var_17.angles = (0, 180, 90);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip64x64x256", "targetname");
  var_19 = spawn("script_model", (-1313, -432, 766));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getent("clip64x64x256", "targetname");
  var_21 = spawn("script_model", (-1313, -496, 766));
  var_21.angles = (0, 0, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getent("clip64x64x256", "targetname");
  var_23 = spawn("script_model", (-1313, -560, 766));
  var_23.angles = (0, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
}

fixcollision2() {
  var_0 = getent("clip32x32x256", "targetname");
  var_1 = spawn("script_model", (400, -138, 962));
  var_1.angles = (0, 180, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip32x32x256", "targetname");
  var_3 = spawn("script_model", (393, -133, 962));
  var_3.angles = (0, 202, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip32x32x256", "targetname");
  var_5 = spawn("script_model", (386, -115, 962));
  var_5.angles = (0, 45, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip32x32x256", "targetname");
  var_7 = spawn("script_model", (386, -83, 962));
  var_7.angles = (0, 315, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip32x32x256", "targetname");
  var_9 = spawn("script_model", (402, -77, 962));
  var_9.angles = (0, 270, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip32x32x256", "targetname");
  var_11 = spawn("script_model", (418, -84, 962));
  var_11.angles = (0, 225, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip32x32x256", "targetname");
  var_13 = spawn("script_model", (424, -100, 962));
  var_13.angles = (0, 180, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip32x32x256", "targetname");
  var_15 = spawn("script_model", (418, -116, 962));
  var_15.angles = (0, 135, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip32x32x256", "targetname");
  var_17 = spawn("script_model", (409, -132, 962));
  var_17.angles = (0, 243, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip32x32x256", "targetname");
  var_19 = spawn("script_model", (380, -99, 962));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}

fixcollision3() {
  var_0 = getent("clip8x8x256", "targetname");
  var_1 = spawn("script_model", (290.5, -1018.25, 562));
  var_1.angles = (0, 207.676, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip8x8x256", "targetname");
  var_3 = spawn("script_model", (294, -1024.5, 562));
  var_3.angles = (0, 210.676, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip8x8x256", "targetname");
  var_5 = spawn("script_model", (302.75, -1036.5, 562));
  var_5.angles = (0, 218.076, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip8x8x256", "targetname");
  var_7 = spawn("script_model", (312.5, -1046.75, 562));
  var_7.angles = (0, 229.143, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip8x8x256", "targetname");
  var_9 = spawn("script_model", (329.75, -1060.5, 562));
  var_9.angles = (0, 232.124, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip8x8x256", "targetname");
  var_11 = spawn("script_model", (342.25, -1068.25, 562));
  var_11.angles = (0, 241.506, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip8x8x256", "targetname");
  var_13 = spawn("script_model", (355.5, -1074, 562));
  var_13.angles = (0, 251.344, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip8x8x256", "targetname");
  var_15 = spawn("script_model", (370.25, -1078.25, 562));
  var_15.angles = (0, 258.921, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip8x8x256", "targetname");
  var_17 = spawn("script_model", (384.75, -1081.75, 562));
  var_17.angles = (0, 263.97, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip8x8x256", "targetname");
  var_19 = spawn("script_model", (399.25, -1081.75, 562));
  var_19.angles = (0, 274.006, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getent("clip8x8x256", "targetname");
  var_21 = spawn("script_model", (413.481, -1079.8, 562));
  var_21.angles = (0, 284.404, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getent("clip8x8x256", "targetname");
  var_23 = spawn("script_model", (427.498, -1075.84, 562));
  var_23.angles = (0, 290.183, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getent("clip8x8x256", "targetname");
  var_25 = spawn("script_model", (440.185, -1069.94, 562));
  var_25.angles = (0, 298.453, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getent("clip8x8x256", "targetname");
  var_27 = spawn("script_model", (453.703, -1062.76, 562));
  var_27.angles = (0, 298.453, 0);
  var_27 clonebrushmodeltoscriptmodel(var_26);
  var_28 = getent("clip8x8x256", "targetname");
  var_29 = spawn("script_model", (465.82, -1054.43, 562));
  var_29.angles = (0, 307.834, 0);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_30 = getent("clip8x8x256", "targetname");
  var_31 = spawn("script_model", (476.405, -1044.6, 562));
  var_31.angles = (0, 317.672, 0);
  var_31 clonebrushmodeltoscriptmodel(var_30);
  var_32 = getent("clip8x8x256", "targetname");
  var_33 = spawn("script_model", (486.219, -1032.8, 562));
  var_33.angles = (0, 325.248, 0);
  var_33 clonebrushmodeltoscriptmodel(var_32);
  var_34 = getent("clip8x8x256", "targetname");
  var_35 = spawn("script_model", (495.247, -1020.92, 562));
  var_35.angles = (0, 330.299, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
}

fixcollision4() {
  var_0 = getent("clip128x128x256", "targetname");
  var_1 = spawn("script_model", (325, -514, 677));
  var_1.angles = (270, 89.55, -84.6502);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}

fixcollision5() {
  var_0 = getent("clip128x128x256", "targetname");
  var_1 = spawn("script_model", (-1592, -272, 768));
  var_1.angles = (0, 348.8, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
}