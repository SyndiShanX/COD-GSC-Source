/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_meteora_fog.gsc
*****************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_meteora");
  var_0.startdist = 140;
  var_0.halfwaydist = 5520;
  var_0.red = 0.5;
  var_0.green = 0.55;
  var_0.blue = 0.63;
  var_0.maxopacity = 0.653;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.685;
  var_0.sungreen = 0.696;
  var_0.sunblue = 0.703;
  var_0.sundir = (0.1209, 0.375, 0.902);
  var_0.sunbeginfadeangle = 55.94;
  var_0.sunendfadeangle = 72.08;
  var_0.normalfogscale = 4.18;
}