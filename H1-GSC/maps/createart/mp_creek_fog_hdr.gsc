/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_creek_fog_hdr.gsc
***********************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_creek");
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
  var_0.atmosfogsunfogcolor = (0.525, 0.804, 1);
  var_0.atmosfoghazecolor = (0.624, 0.88, 1);
  var_0.atmosfoghazestrength = 0.35;
  var_0.atmosfoghazespread = 0.35;
  var_0.atmosfogextinctionstrength = 0.4;
  var_0.atmosfoginscatterstrength = 19.5;
  var_0.atmosfoghalfplanedistance = 10000;
  var_0.atmosfogstartdistance = 650;
  var_0.atmosfogdistancescale = 0.875;
  var_0.atmosfogskydistance = 40960;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 90;
  var_0.atmosfogsundirection = (-0.5, -0.61, 0.62);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 1000;
  var_0 = maps\mp\_art::create_vision_set_fog("mp_creek_cave");
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
  var_0.atmosfogsunfogcolor = (0.525, 0.804, 1);
  var_0.atmosfoghazecolor = (0.624, 0.88, 1);
  var_0.atmosfoghazestrength = 0.35;
  var_0.atmosfoghazespread = 0.35;
  var_0.atmosfogextinctionstrength = 0.15;
  var_0.atmosfoginscatterstrength = 14;
  var_0.atmosfoghalfplanedistance = 1000;
  var_0.atmosfogstartdistance = 450;
  var_0.atmosfogdistancescale = 0.75;
  var_0.atmosfogskydistance = 40960;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 90;
  var_0.atmosfogsundirection = (-0.5, -0.61, 0.62);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 1000;
}

setupfog() {}