/******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\village_assault_fog_hdr.gsc
******************************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("village_assault");
  var_0.startdist = 1024;
  var_0.halfwaydist = 4097;
  var_0.red = 0.0845683;
  var_0.green = 0.101563;
  var_0.blue = 0.210938;
  var_0.hdrcolorintensity = 4.25;
  var_0.maxopacity = 0.625;
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
  var_0.skyfogminangle = 46.4867;
  var_0.skyfogmaxangle = 78;
  var_0.heightfogenabled = 1;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 424;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.617188, 0.697431, 1);
  var_0.atmosfoghazecolor = (0.59375, 0.679688, 0.945313);
  var_0.atmosfoghazestrength = 0.257187;
  var_0.atmosfoghazespread = 0.0228232;
  var_0.atmosfogextinctionstrength = 0.609375;
  var_0.atmosfoginscatterstrength = 7.75;
  var_0.atmosfoghalfplanedistance = 2143.14;
  var_0.atmosfogstartdistance = -9.7886;
  var_0.atmosfogdistancescale = 0.0516518;
  var_0.atmosfogskydistance = 2765;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 14.2;
  var_0.atmosfogskyfalloffanglerange = 19.6755;
  var_0.atmosfogsundirection = (-0.0710914, 0.869021, 0.489641);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 228.052;
  var_0.atmosfogheightfoghalfplanedistance = 346.845;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-30.0037, 91.0018, 0);
  maps\_art::sunflare_changes("default", 0);
}