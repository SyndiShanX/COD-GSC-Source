/****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\simplecredits_fog_hdr.gsc
****************************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("simplecredits");
  var_0.startdist = 3764.17;
  var_0.halfwaydist = 19391;
  var_0.red = 1;
  var_0.green = 0.925269;
  var_0.blue = 0.847076;
  var_0.hdrcolorintensity = 12.2088;
  var_0.maxopacity = 0.7;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0.5;
  var_0.sungreen = 0.5;
  var_0.sunblue = 0.5;
  var_0.hdrsuncolorintensity = -8;
  var_0.sundir = (0, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 1;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 0;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 0;
  var_0.atmosfogsunfogcolor = (0.5, 0.5, 0.5);
  var_0.atmosfoghazecolor = (0.5, 0.5, 0.5);
  var_0.atmosfoghazestrength = 0.5;
  var_0.atmosfoghazespread = 0.25;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 0;
  var_0.atmosfoghalfplanedistance = 5000;
  var_0.atmosfogstartdistance = 0;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 100000;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 90;
  var_0.atmosfogsundirection = (0, 0, 1);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 1000;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-30, 85, 0);
  maps\_art::sunflare_changes("default", 0);
}