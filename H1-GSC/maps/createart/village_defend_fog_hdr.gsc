/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\village_defend_fog_hdr.gsc
*****************************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("village_defend");
  var_0.startdist = 0;
  var_0.halfwaydist = 5000;
  var_0.red = 0;
  var_0.green = 0;
  var_0.blue = 0;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 0;
  var_0.transitiontime = 0.6;
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
  var_0.skyfogminangle = 68.5989;
  var_0.skyfogmaxangle = 80;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.533291, 0.607348, 0.716305);
  var_0.atmosfoghazecolor = (0.486205, 0.484346, 0.490571);
  var_0.atmosfoghazestrength = 0.135098;
  var_0.atmosfoghazespread = 0.167773;
  var_0.atmosfogextinctionstrength = 0.937041;
  var_0.atmosfoginscatterstrength = 17.25;
  var_0.atmosfoghalfplanedistance = 12339.5;
  var_0.atmosfogstartdistance = 268.618;
  var_0.atmosfogdistancescale = 1.01734;
  var_0.atmosfogskydistance = 163840;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = -2;
  var_0.atmosfogskyfalloffanglerange = 36;
  var_0.atmosfogsundirection = (-0.696097, -0.605914, 0.385121);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 768;
  var_0.atmosfogheightfoghalfplanedistance = 535.128;
  var_0 = maps\_utility::create_vision_set_fog("village_defend_interior");
  var_0.startdist = 0;
  var_0.halfwaydist = 5000;
  var_0.red = 0;
  var_0.green = 0;
  var_0.blue = 0;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 0;
  var_0.transitiontime = 0.8;
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
  var_0.skyfogminangle = 68.5989;
  var_0.skyfogmaxangle = 80;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.566868, 0.627338, 0.716305);
  var_0.atmosfoghazecolor = (0.486205, 0.484346, 0.490571);
  var_0.atmosfoghazestrength = 0.135098;
  var_0.atmosfoghazespread = 0.167773;
  var_0.atmosfogextinctionstrength = 0.937041;
  var_0.atmosfoginscatterstrength = 17.25;
  var_0.atmosfoghalfplanedistance = 13014.2;
  var_0.atmosfogstartdistance = 800;
  var_0.atmosfogdistancescale = 1.01734;
  var_0.atmosfogskydistance = 163840;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = -2;
  var_0.atmosfogskyfalloffanglerange = 36;
  var_0.atmosfogsundirection = (-0.696097, -0.605914, 0.385121);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 768;
  var_0.atmosfogheightfoghalfplanedistance = 535.128;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-35.7001, -138.562, 0);
  maps\_art::sunflare_changes("default", 0);
}