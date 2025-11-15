/****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_bog_summer_fog_hdr.gsc
****************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_bog_summer");
  var_0.startdist = 1267.61;
  var_0.halfwaydist = 2049;
  var_0.red = 1;
  var_0.green = 0.784136;
  var_0.blue = 0.675201;
  var_0.hdrcolorintensity = 4.59;
  var_0.maxopacity = 0.378365;
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
  var_0.skyfogminangle = 48.0714;
  var_0.skyfogmaxangle = 96.2788;
  var_0.heightfogenabled = 1;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 206.435;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (1, 0.92, 0.85);
  var_0.atmosfoghazecolor = (0.97, 0.988, 1);
  var_0.atmosfoghazestrength = 0.5;
  var_0.atmosfoghazespread = 0.1;
  var_0.atmosfogextinctionstrength = 0.5;
  var_0.atmosfoginscatterstrength = 19.25;
  var_0.atmosfoghalfplanedistance = 7500;
  var_0.atmosfogstartdistance = 1750;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 94808;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = -3;
  var_0.atmosfogskyfalloffanglerange = 45;
  var_0.atmosfogsundirection = (-0.413, 0.75, 0.516);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = -42;
  var_0.atmosfogheightfoghalfplanedistance = 170;
  var_0 = maps\mp\_art::create_vision_set_fog("");
  var_0.startdist = 3764.17;
  var_0.halfwaydist = 19391;
  var_0.red = 1;
  var_0.green = 0.925269;
  var_0.blue = 0.847076;
  var_0.hdrcolorintensity = 12.2088;
  var_0.maxopacity = 0.7;
  var_0.transitiontime = 0;
  var_0.skyfogintensity = 0;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
}

setupfog() {}