/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\coup_fog_hdr.gsc
*******************************************/

main() {
  sunflare();
  var_0 = maps\_utility::create_vision_set_fog("coup");
  var_0.startdist = 104.384;
  var_0.halfwaydist = 25679.4;
  var_0.red = 0.806017;
  var_0.green = 0.722864;
  var_0.blue = 0.678453;
  var_0.hdrcolorintensity = 12.2088;
  var_0.maxopacity = 0.7;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.732365;
  var_0.sungreen = 0.439419;
  var_0.sunblue = 0.217694;
  var_0.hdrsuncolorintensity = -8;
  var_0.sundir = (0.137935, 0.629085, 0.765001);
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
  var_0.atmosfogsunfogcolor = (0.735453, 0.658574, 0.49044);
  var_0.atmosfoghazecolor = (0.807856, 0.618924, 0.370057);
  var_0.atmosfoghazestrength = 0.197062;
  var_0.atmosfoghazespread = 0.00734394;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 21.5115;
  var_0.atmosfoghalfplanedistance = 35000;
  var_0.atmosfogstartdistance = 1000;
  var_0.atmosfogdistancescale = 1.5;
  var_0.atmosfogskydistance = 100000;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 52.6096;
  var_0.atmosfogsundirection = (0.162276, 0.622061, 0.765967);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 200;
  var_0.atmosfogheightfoghalfplanedistance = 1050;
  var_0 = maps\_utility::create_vision_set_fog("coup_end");
  var_0.startdist = 104.384;
  var_0.halfwaydist = 25679.4;
  var_0.red = 0.806017;
  var_0.green = 0.722864;
  var_0.blue = 0.678453;
  var_0.hdrcolorintensity = 12.2088;
  var_0.maxopacity = 0.7;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.732365;
  var_0.sungreen = 0.439419;
  var_0.sunblue = 0.217694;
  var_0.hdrsuncolorintensity = -8;
  var_0.sundir = (0.137935, 0.629085, 0.765001);
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
  var_0.atmosfogsunfogcolor = (0.696391, 0.652812, 0.652812);
  var_0.atmosfoghazecolor = (0.807856, 0.618924, 0.370057);
  var_0.atmosfoghazestrength = 0.197062;
  var_0.atmosfoghazespread = 0.00734394;
  var_0.atmosfogextinctionstrength = 0.231334;
  var_0.atmosfoginscatterstrength = 21.5115;
  var_0.atmosfoghalfplanedistance = 9548.09;
  var_0.atmosfogstartdistance = 4686.66;
  var_0.atmosfogdistancescale = 5.20196;
  var_0.atmosfogskydistance = 100000;
  var_0.atmosfogskyangularfalloffenabled = 0;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 52.6096;
  var_0.atmosfogsundirection = (0.162276, 0.622061, 0.765967);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 200;
  var_0.atmosfogheightfoghalfplanedistance = 1050;
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-18.8014, 88.3258, 0);
  maps\_art::sunflare_changes("default", 0);
}