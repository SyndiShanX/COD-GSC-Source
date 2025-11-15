/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_farm_spring_fog_hdr.gsc
*****************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_farm_spring");
  var_0.startdist = 100000;
  var_0.halfwaydist = 300000;
  var_0.red = 0.925474;
  var_0.green = 1;
  var_0.blue = 0.999999;
  var_0.hdrcolorintensity = 14.4735;
  var_0.maxopacity = 0.893394;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 1;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (1, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 180;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 1;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 87.6317;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.729, 1, 0.921);
  var_0.atmosfoghazecolor = (1, 0.897, 0.671);
  var_0.atmosfoghazestrength = 0.78;
  var_0.atmosfoghazespread = 0.065;
  var_0.atmosfogextinctionstrength = 0.5;
  var_0.atmosfoginscatterstrength = 17.5;
  var_0.atmosfoghalfplanedistance = 10000;
  var_0.atmosfogstartdistance = 500;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 90927;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 3;
  var_0.atmosfogskyfalloffanglerange = 88;
  var_0.atmosfogsundirection = (-0.468, -0.497, 0.731);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 800;
  var_0.atmosfogheightfoghalfplanedistance = 1800;
  var_0 = maps\mp\_art::create_vision_set_fog("mp_farm_spring_int");
  var_0.startdist = 100000;
  var_0.halfwaydist = 300000;
  var_0.red = 0.925474;
  var_0.green = 1;
  var_0.blue = 0.999999;
  var_0.hdrcolorintensity = 14.4735;
  var_0.maxopacity = 0.893394;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 1;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (1, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 180;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 1;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 87.6317;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.729, 1, 0.921);
  var_0.atmosfoghazecolor = (1, 0.897, 0.671);
  var_0.atmosfoghazestrength = 0.78;
  var_0.atmosfoghazespread = 0.065;
  var_0.atmosfogextinctionstrength = 0.5;
  var_0.atmosfoginscatterstrength = 17.5;
  var_0.atmosfoghalfplanedistance = 10000;
  var_0.atmosfogstartdistance = 500;
  var_0.atmosfogdistancescale = 0.85;
  var_0.atmosfogskydistance = 90927;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 3;
  var_0.atmosfogskyfalloffanglerange = 88;
  var_0.atmosfogsundirection = (-0.468, -0.497, 0.731);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 7432.35;
  var_0.atmosfogheightfoghalfplanedistance = 6008.52;
}

setupfog() {}