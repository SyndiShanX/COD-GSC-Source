/*******************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\launchfacility_a_fog_hdr.gsc
*******************************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("launchfacility_a");
  var_0.startdist = 1204.17;
  var_0.halfwaydist = 9151;
  var_0.red = 0.906515;
  var_0.green = 0.839342;
  var_0.blue = 0.909582;
  var_0.hdrcolorintensity = 8.4588;
  var_0.maxopacity = 1;
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
  var_0.heightfogenabled = 1;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 488;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.570313, 0.578125, 0.734375);
  var_0.atmosfoghazecolor = (0.756491, 0.710936, 0.679688);
  var_0.atmosfoghazestrength = 0.015625;
  var_0.atmosfoghazespread = 0.0390625;
  var_0.atmosfogextinctionstrength = 0.679688;
  var_0.atmosfoginscatterstrength = 15;
  var_0.atmosfoghalfplanedistance = 6053.87;
  var_0.atmosfogstartdistance = 376.726;
  var_0.atmosfogdistancescale = 1.00012;
  var_0.atmosfogskydistance = 28517;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 50;
  var_0.atmosfogsundirection = (0.931829, -0.121288, 0.34203);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = -1556.33;
  var_0.atmosfogheightfoghalfplanedistance = 684.694;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-13.3154, -7.5753, 0);
  maps\_art::sunflare_changes("default", 0);
}