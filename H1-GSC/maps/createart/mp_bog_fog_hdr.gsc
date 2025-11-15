/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_bog_fog_hdr.gsc
*********************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_bog");
  var_0.startdist = 1267.61;
  var_0.halfwaydist = 2049;
  var_0.red = 1;
  var_0.green = 0.784136;
  var_0.blue = 0.675201;
  var_0.hdrcolorintensity = 4.59;
  var_0.maxopacity = 0.378365;
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
  var_0.skyfogminangle = 48.0714;
  var_0.skyfogmaxangle = 96.2788;
  var_0.heightfogenabled = 1;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 206.435;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.615273, 0.477913, 0.407925);
  var_0.atmosfoghazecolor = (0.902738, 0.722815, 0.670975);
  var_0.atmosfoghazestrength = 0.501789;
  var_0.atmosfoghazespread = 0.831624;
  var_0.atmosfogextinctionstrength = 0.75;
  var_0.atmosfoginscatterstrength = 4.85015;
  var_0.atmosfoghalfplanedistance = 513.962;
  var_0.atmosfogstartdistance = 959.662;
  var_0.atmosfogdistancescale = 0.803994;
  var_0.atmosfogskydistance = 94808;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 8.06833;
  var_0.atmosfogskyfalloffanglerange = 14.8565;
  var_0.atmosfogsundirection = (-0.273865, -0.959554, 0.0652224);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = -42;
  var_0.atmosfogheightfoghalfplanedistance = 170;
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