/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\aftermath_fog_hdr.gsc
************************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("aftermath");
  var_0.startdist = 0;
  var_0.halfwaydist = 5000;
  var_0.red = 0;
  var_0.green = 0;
  var_0.blue = 0;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 0;
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
  var_0.skyfogminangle = -90;
  var_0.skyfogmaxangle = 180;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.965184, 0.965184, 0.965184);
  var_0.atmosfoghazecolor = (0.82205, 0.672861, 0.537433);
  var_0.atmosfoghazestrength = 0.5;
  var_0.atmosfoghazespread = 0.217312;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 16.5;
  var_0.atmosfoghalfplanedistance = 6071.44;
  var_0.atmosfogstartdistance = 633.595;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 14806;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 10;
  var_0.atmosfogskyfalloffanglerange = 11.4679;
  var_0.atmosfogsundirection = (0.640127, 0.741, 0.20287);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 768;
  var_0.atmosfogheightfoghalfplanedistance = 808;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-11.7048, 49.1773, 0);
  maps\_art::sunflare_changes("default", 0);
}