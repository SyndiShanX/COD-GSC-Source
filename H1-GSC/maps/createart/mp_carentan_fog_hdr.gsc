/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_carentan_fog_hdr.gsc
**************************************************/

main() {
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
  var_0 = maps\mp\_art::create_vision_set_fog("mp_carentan");
  var_0.startdist = 512;
  var_0.halfwaydist = 17885.6;
  var_0.red = 0.867188;
  var_0.green = 0.925269;
  var_0.blue = 0.847076;
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
  var_0.atmosfogsunfogcolor = (0.469299, 0.867188, 0.804363);
  var_0.atmosfoghazecolor = (0.715628, 0.90625, 1);
  var_0.atmosfoghazestrength = 0.111597;
  var_0.atmosfoghazespread = 0.00552888;
  var_0.atmosfogextinctionstrength = 0.400122;
  var_0.atmosfoginscatterstrength = 14.25;
  var_0.atmosfoghalfplanedistance = 46103;
  var_0.atmosfogstartdistance = 100.931;
  var_0.atmosfogdistancescale = 0.266722;
  var_0.atmosfogskydistance = 148032;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 90;
  var_0.atmosfogskyfalloffanglerange = 0;
  var_0.atmosfogsundirection = (0.835756, 0.166909, 0.52312);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 496.096;
}

setupfog() {}