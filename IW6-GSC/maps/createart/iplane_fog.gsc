/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\iplane_fog.gsc
*****************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("iplane");
  var_0.startdist = 9266;
  var_0.halfwaydist = 60852.7;
  var_0.red = 0.561796;
  var_0.green = 0.530604;
  var_0.blue = 0.439498;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0.5;
  var_0.sungreen = 0.5;
  var_0.sunblue = 0.5;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (-0.98165, 0.166975, -0.0920999);
  var_0.sunbeginfadeangle = 11.2717;
  var_0.sunendfadeangle = 19.6979;
  var_0.normalfogscale = 4.19862;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-30, 85, 0);
  maps\_art::sunflare_changes("default", 0);
}