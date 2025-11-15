/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_showdown_fog_hdr.gsc
**************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_showdown");
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
  var_0.atmosfogsunfogcolor = (0.484, 0.413, 0.36);
  var_0.atmosfoghazecolor = (0.990991, 0.941165, 0.615029);
  var_0.atmosfoghazestrength = 0.00688299;
  var_0.atmosfoghazespread = 0.0176991;
  var_0.atmosfogextinctionstrength = 0.8;
  var_0.atmosfoginscatterstrength = 17;
  var_0.atmosfoghalfplanedistance = 10000;
  var_0.atmosfogstartdistance = 1355.98;
  var_0.atmosfogdistancescale = 2.5;
  var_0.atmosfogskydistance = 50506;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = -12.6549;
  var_0.atmosfogskyfalloffanglerange = 34.6903;
  var_0.atmosfogsundirection = (-0.389197, 0.738893, 0.550058);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 2626.11;
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