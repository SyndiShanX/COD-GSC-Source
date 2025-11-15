/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\hunted_fog_hdr.gsc
*********************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("hunted");
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
  var_0.atmosfogsunfogcolor = (1, 1, 1);
  var_0.atmosfoghazecolor = (0.761353, 0.951638, 0.992188);
  var_0.atmosfoghazestrength = 0.367188;
  var_0.atmosfoghazespread = 0.0138765;
  var_0.atmosfogextinctionstrength = 0.445313;
  var_0.atmosfoginscatterstrength = 4.8515;
  var_0.atmosfoghalfplanedistance = 4097;
  var_0.atmosfogstartdistance = 2561.61;
  var_0.atmosfogdistancescale = 1.375;
  var_0.atmosfogskydistance = 8192;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 6.86674;
  var_0.atmosfogskyfalloffanglerange = 18.3113;
  var_0.atmosfogsundirection = (0.459477, 0.569579, 0.681514);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 228.052;
  var_0.atmosfogheightfoghalfplanedistance = 346.845;
  var_0 = maps\_utility::create_vision_set_fog("hunted_barn_interior");
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
  var_0.atmosfogsunfogcolor = (1, 1, 1);
  var_0.atmosfoghazecolor = (0.761353, 0.951638, 0.992188);
  var_0.atmosfoghazestrength = 0.367188;
  var_0.atmosfoghazespread = 0.0138765;
  var_0.atmosfogextinctionstrength = 0.445313;
  var_0.atmosfoginscatterstrength = 4.8515;
  var_0.atmosfoghalfplanedistance = 4097;
  var_0.atmosfogstartdistance = 2561.61;
  var_0.atmosfogdistancescale = 1.375;
  var_0.atmosfogskydistance = 8192;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 6.86674;
  var_0.atmosfogskyfalloffanglerange = 18.3113;
  var_0.atmosfogsundirection = (0.459477, 0.569579, 0.681514);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 228.052;
  var_0.atmosfogheightfoghalfplanedistance = 346.845;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-44.3585, 50.2227, 0);
  maps\_art::sunflare_changes("default", 0);
}