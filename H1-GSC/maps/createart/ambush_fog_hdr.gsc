/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\ambush_fog_hdr.gsc
*********************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("ambush");
  var_0.startdist = 3764.17;
  var_0.halfwaydist = 19391;
  var_0.red = 1;
  var_0.green = 0.925269;
  var_0.blue = 0.847076;
  var_0.hdrcolorintensity = 12.2088;
  var_0.maxopacity = 0.7;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 1;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.hdrsuncolorintensity = -8;
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
  var_0.atmosfogsunfogcolor = (0.609375, 0.609375, 0.609375);
  var_0.atmosfoghazecolor = (0.5, 0.5, 0.5);
  var_0.atmosfoghazestrength = 0;
  var_0.atmosfoghazespread = 0.25;
  var_0.atmosfogextinctionstrength = 0.757813;
  var_0.atmosfoginscatterstrength = 16.5;
  var_0.atmosfoghalfplanedistance = 6145;
  var_0.atmosfogstartdistance = 24;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 106496;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 11;
  var_0.atmosfogskyfalloffanglerange = 34;
  var_0.atmosfogsundirection = (-0.627929, 0.778232, -0.0077657);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 1000;
  var_0 = maps\_utility::create_vision_set_fog("ambush_start");
  var_0.startdist = 3764.17;
  var_0.halfwaydist = 19391;
  var_0.red = 1;
  var_0.green = 0.925269;
  var_0.blue = 0.847076;
  var_0.hdrcolorintensity = 12.2088;
  var_0.maxopacity = 0.320313;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 1;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.hdrsuncolorintensity = -8;
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
  var_0.atmosfogsunfogcolor = (0.5, 0.5, 0.5);
  var_0.atmosfoghazecolor = (0.601563, 0.522624, 0.435058);
  var_0.atmosfoghazestrength = 0.309895;
  var_0.atmosfoghazespread = 0.128805;
  var_0.atmosfogextinctionstrength = 0.482125;
  var_0.atmosfoginscatterstrength = 17.0069;
  var_0.atmosfoghalfplanedistance = 535.878;
  var_0.atmosfogstartdistance = 274.602;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 453337;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 13.6963;
  var_0.atmosfogskyfalloffanglerange = 22.3016;
  var_0.atmosfogsundirection = (-0.7428, 0.621815, 0.248185);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 4543.14;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-25.2686, 137.963, 0);
  maps\_art::sunflare_changes("default", 0);
}