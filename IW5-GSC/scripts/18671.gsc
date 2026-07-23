/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18671.gsc
**************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_underground");
  var_0.startdist = 1200;
  var_0.halfwaydist = 8000;
  var_0.red = 0.741176;
  var_0.green = 0.780392;
  var_0.blue = 0.823529;
  var_0.maxopacity = 0.28871;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.866667;
  var_0.sungreen = 0.858823;
  var_0.sunblue = 0.74902;
  var_0.sundir = (-0.713395, -0.188907, 0.67482);
  var_0.sunbeginfadeangle = 10;
  var_0.sunendfadeangle = 40.7289;
  var_0.normalfogscale = 1.85315;
}