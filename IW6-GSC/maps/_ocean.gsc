/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ocean.gsc
*****************************************************/

setup_ocean_params(var_0, var_1, var_2, var_3, var_4) {
  var_5[0] = 3;
  var_6[0] = 3;
  var_7[0] = 30;
  var_8[0] = 4;
  var_9[0] = 0;
  var_5[1] = 8;
  var_6[1] = 8;
  var_7[1] = 10;
  var_8[1] = 1.75;
  var_9[1] = 45;
  var_5[2] = 2;
  var_6[2] = 2;
  var_7[2] = 0;
  var_8[2] = 2;
  var_9[2] = 315;
  maps\ocean_perlin::setup_ocean_perlin(var_0);

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_0.uscale[var_10] = 0.0001 * var_1 * var_5[var_10];
    var_0.vscale[var_10] = 0.0001 * var_2 * var_6[var_10];
    var_0.amplitude[var_10] = var_3 * var_7[var_10];
    var_0.uscrollrate[var_10] = cos(var_9[var_10]) * var_4 * var_8[var_10];
    var_0.vscrollrate[var_10] = sin(var_9[var_10]) * var_4 * var_8[var_10];
  }

  var_0.uoff = -0.5;
  var_0.voff = -0.5;
  var_0.gametimeoffset = 0.0;
  var_0.displacement_uvscale = 1.0;
}

setup_ocean() {
  var_0 = 1;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0.025;
  level.oceantextures["water_patch"] = spawnStruct();
  setup_ocean_params(level.oceantextures["water_patch"], var_0, var_1, var_2, var_3);
  level.oceantextures["water_patch_med"] = spawnStruct();
  setup_ocean_params(level.oceantextures["water_patch_med"], var_0, var_1, 0.5 * var_2, var_3);
  level.oceantextures["water_patch_calm"] = spawnStruct();
  setup_ocean_params(level.oceantextures["water_patch_calm"], var_0, var_1, 0, var_3);
}

gettransformeduv(var_0, var_1, var_2, var_3) {
  var_4 = gettime();
  var_4 = var_4 / 43200000.0;
  var_4 = var_4 - int(var_4);
  var_4 = var_4 * 43200.0;
  var_4 = var_4 + var_0.gametimeoffset;
  var_5 = (var_1[0] * var_0.uscale[var_2] * var_3, var_1[1] * var_0.vscale[var_2] * var_3, 0);
  var_5 = var_5 + (var_4 * var_0.uscrollrate[var_2] * var_3, var_4 * var_0.vscrollrate[var_2] * var_3, 0);
  return var_5;
}

gettexturesamplefromint(var_0, var_1) {
  var_2 = animscripts\utility::safemod(var_1[0], var_0.width);
  var_3 = animscripts\utility::safemod(var_1[1], var_0.height);
  var_4 = var_0.image[var_3][var_2];
  var_4 = var_4 / 255.0;
  return var_4;
}

getinterpolatedtexturesample(var_0, var_1) {
  var_2 = var_1[0] - floor(var_1[0]);
  var_3 = var_1[1] - floor(var_1[1]);
  var_4 = (var_2 * var_0.width, var_3 * var_0.height, 0);
  var_1 = (var_4[0] + var_0.uoff, var_4[1] + var_0.voff, 0);
  var_5 = (floor(var_1[0]), floor(var_1[1]), 0);
  var_6 = var_1 - var_5;
  var_2 = animscripts\utility::safemod(var_5[0], var_0.width);
  var_3 = animscripts\utility::safemod(var_5[1], var_0.height);
  var_7 = (var_2, var_3, 0);

  var_9 = 0;
  return var_9;
}

getperlintexturesample(var_0, var_1) {
  var_2 = var_1[0] - floor(var_1[0]);
  var_3 = var_1[1] - floor(var_1[1]);
  var_4 = (var_2 * var_0.width, var_3 * var_0.height, 0);
  var_1 = (var_4[0] + var_0.uoff, var_4[1] + var_0.voff, 0);
  var_5 = maps\_perlin_noise::getperlinnoisesample(var_0, var_1[0], var_1[1]) / 255.0;
  return var_5;
}

getdisplacementforvertex(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < 3; var_3++) {
    if(var_0.amplitude[var_3] > 0) {
      var_4 = gettransformeduv(var_0, var_1, var_3, var_0.displacement_uvscale);
      var_5 = getperlintexturesample(var_0, var_4);
      var_2 = var_2 + (var_5 * 2.0 - 1.0) * var_0.amplitude[var_3];
    }
  }

  return var_2;
}