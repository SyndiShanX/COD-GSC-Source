/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_perlin_noise.gsc
*****************************************************/

getperlinnoisesample(var_0, var_1, var_2) {
  var_3 = var_1 * var_0.xscale;
  var_4 = var_2 * var_0.yscale;
  var_5 = var_3 - var_0.xoff;
  var_6 = var_4 - var_0.yoff;
  var_7 = var_0.refscale;

  if(var_0.tile) {
    var_8 = var_0.octaves;
    var_9 = var_0.lacunarity;
    var_10 = var_0.gain;
    var_11 = (var_7 - var_4) * ((var_7 - var_3) * perlinnoise2d(var_5, var_6, var_8, var_9, var_10) + var_3 * perlinnoise2d(var_5 - var_7, var_6, var_8, var_9, var_10)) + var_4 * ((var_7 - var_3) * perlinnoise2d(var_5, var_6 - var_7, var_8, var_9, var_10) + var_3 * perlinnoise2d(var_5 - var_7, var_6 - var_7, var_8, var_9, var_10));
  } else
    var_11 = perlinnoise2d(var_5, var_6, var_0.octaves, var_0.lacunarity, var_0.gain);

  var_11 = var_11 - var_0.sum;
  var_11 = var_11 * var_0.refsc;
  var_11 = var_11 + 127.0;

  if(var_11 < 0.0)
    var_11 = 0.0;

  if(var_11 > 255.0)
    var_11 = 255.0;

  return var_11;
}