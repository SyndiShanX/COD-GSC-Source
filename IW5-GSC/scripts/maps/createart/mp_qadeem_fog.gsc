/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_qadeem_fog.gsc
****************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_qadeem");
  var_0.startdist = 1886.38;
  var_0.halfwaydist = 5665.21;
  var_0.red = 0.6274;
  var_0.green = 0.7176;
  var_0.blue = 0.745;
  var_0.maxopacity = 0.2445;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.8392;
  var_0.sungreen = 0.6901;
  var_0.sunblue = 0.5686;
  var_0.sundir = (0.7875, -0.5897, 0.179);
  var_0.sunbeginfadeangle = 40.0377;
  var_0.sunendfadeangle = 72.0691;
  var_0.normalfogscale = 0.524;
  var_0 = maps\_utility::create_vision_set_fog("hillside_pool");
  var_0.startdist = 0.0;
  var_0.halfwaydist = 97.41;
  var_0.red = 0.4857;
  var_0.green = 0.7452;
  var_0.blue = 0.8666;
  var_0.maxopacity = 1.0;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.267;
  var_0.sungreen = 0.275;
  var_0.sunblue = 0.277;
  var_0.sundir = (0.72, -0.6, 0.32);
  var_0.sunbeginfadeangle = 24.1;
  var_0.sunendfadeangle = 52.7;
  var_0.normalfogscale = 8.3;
}