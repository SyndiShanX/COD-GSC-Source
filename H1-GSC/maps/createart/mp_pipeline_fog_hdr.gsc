/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_pipeline_fog_hdr.gsc
**************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_pipeline");
  var_0.startdist = 17346.3;
  var_0.halfwaydist = 32487.6;
  var_0.red = 1;
  var_0.green = 0.957944;
  var_0.blue = 0.747583;
  var_0.hdrcolorintensity = 12.029;
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
  var_0.atmosfogsunfogcolor = (0.276477, 0.396808, 0.460938);
  var_0.atmosfoghazecolor = (0.315204, 0.411132, 0.539063);
  var_0.atmosfoghazestrength = 0.75;
  var_0.atmosfoghazespread = 0.25;
  var_0.atmosfogextinctionstrength = 0.0445922;
  var_0.atmosfoginscatterstrength = 22.0724;
  var_0.atmosfoghalfplanedistance = 1732.58;
  var_0.atmosfogstartdistance = 500;
  var_0.atmosfogdistancescale = 0.400038;
  var_0.atmosfogskydistance = 24576;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 90;
  var_0.atmosfogskyfalloffanglerange = 90.8932;
  var_0.atmosfogsundirection = (-0.548014, -0.464835, 0.69542);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 0;
  var_0.atmosfogheightfoghalfplanedistance = 1000;
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