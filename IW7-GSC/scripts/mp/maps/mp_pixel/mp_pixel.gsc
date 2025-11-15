/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_pixel\mp_pixel.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_pixel\mp_pixel_precache::main();
  scripts\mp\maps\mp_pixel\gen\mp_pixel_art::main();
  scripts\mp\maps\mp_pixel\mp_pixel_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_pixel");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 3);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread fix_collision();
}

fix_collision() {
  var_00 = getent("clip256x256x256", "targetname");
  var_01 = spawn("script_model", (1336, 1272, 56));
  var_01.angles = (0, 323, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("clip32x32x8", "targetname");
  var_03 = spawn("script_model", (-1512, 572, 319));
  var_03.angles = (0, 0, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("clip32x32x8", "targetname");
  var_05 = spawn("script_model", (-1105, 1954, 246));
  var_05.angles = (0, 0, 0);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("clip32x32x8", "targetname");
  var_07 = spawn("script_model", (655, 2626, 184));
  var_07.angles = (0, 0, 0);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("clip32x32x8", "targetname");
  var_09 = spawn("script_model", (1675, 1446, 184));
  var_09.angles = (0, 0, 0);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("clip32x32x8", "targetname");
  var_0B = spawn("script_model", (84, 1160, 47));
  var_0B.angles = (0, 0, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("clip32x32x8", "targetname");
  var_0D = spawn("script_model", (1392, 520, 184));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("clip32x32x8", "targetname");
  var_0F = spawn("script_model", (-1588, -524, 184));
  var_0F.angles = (0, 0, 0);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
  var_10 = getent("clip32x32x8", "targetname");
  var_11 = spawn("script_model", (-712, 444, 184));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip32x32x256", "targetname");
  var_13 = spawn("script_model", (-253, 1601, 315));
  var_13.angles = (90, 50, -40.3);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip32x32x256", "targetname");
  var_15 = spawn("script_model", (199, 1601, 315));
  var_15.angles = (90, 50, -40.3);
  var_15 clonebrushmodeltoscriptmodel(var_14);
}