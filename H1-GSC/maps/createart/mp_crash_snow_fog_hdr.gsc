/****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_crash_snow_fog_hdr.gsc
****************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_crash_snow");
  var_0.startdist = 17346.3;
  var_0.halfwaydist = 32487.7;
  var_0.red = 1;
  var_0.green = 0.957944;
  var_0.blue = 0.747583;
  var_0.hdrcolorintensity = 23;
  var_0.maxopacity = 0.984375;
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
  var_0.atmosfogsunfogcolor = (0.810759, 0.823193, 1);
  var_0.atmosfoghazecolor = (1, 0.834471, 0.787334);
  var_0.atmosfoghazestrength = 0.958067;
  var_0.atmosfoghazespread = 0.00407191;
  var_0.atmosfogextinctionstrength = 0.903679;
  var_0.atmosfoginscatterstrength = 8.8236;
  var_0.atmosfoghalfplanedistance = 2785.36;
  var_0.atmosfogstartdistance = 513.988;
  var_0.atmosfogdistancescale = 1.04539;
  var_0.atmosfogskydistance = 40960;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 90;
  var_0.atmosfogskyfalloffanglerange = 0;
  var_0.atmosfogsundirection = (-0.243001, 0.240683, -0.939693);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = -3563.97;
  var_0.atmosfogheightfoghalfplanedistance = 674.946;
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