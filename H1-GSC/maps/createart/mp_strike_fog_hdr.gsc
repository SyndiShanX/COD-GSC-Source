/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_strike_fog_hdr.gsc
************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_strike");
  var_0.startdist = 512;
  var_0.halfwaydist = 202753;
  var_0.red = 1;
  var_0.green = 0.957944;
  var_0.blue = 0.747583;
  var_0.hdrcolorintensity = -8;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 1;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (1, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 180;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 0;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.871, 0.847, 0.742);
  var_0.atmosfoghazecolor = (0.939, 0.773, 0.607);
  var_0.atmosfoghazestrength = 0.15;
  var_0.atmosfoghazespread = 0.039;
  var_0.atmosfogextinctionstrength = 0.45;
  var_0.atmosfoginscatterstrength = 17.25;
  var_0.atmosfoghalfplanedistance = 6500;
  var_0.atmosfogstartdistance = 1000;
  var_0.atmosfogdistancescale = 0.8;
  var_0.atmosfogskydistance = 175215;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 26;
  var_0.atmosfogskyfalloffanglerange = 11;
  var_0.atmosfogsundirection = (-0.59, -0.4, 0.695);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 2134.99;
  var_0.atmosfogheightfoghalfplanedistance = 438.531;
}

setupfog() {}