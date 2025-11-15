/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_killhouse_fog_hdr.gsc
***************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_killhouse");
  var_0.startdist = 3764.17;
  var_0.halfwaydist = 19391;
  var_0.red = 0;
  var_0.green = 0;
  var_0.blue = 0;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 0;
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
  var_0.heightfoghalfplanedistance = 4743.87;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.578321, 0.539951, 0.496524);
  var_0.atmosfoghazecolor = (0.513988, 0.475895, 0.387387);
  var_0.atmosfoghazestrength = 0.409051;
  var_0.atmosfoghazespread = 0.00102028;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 17;
  var_0.atmosfoghalfplanedistance = 8000;
  var_0.atmosfogstartdistance = 1186.42;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 32319;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 8;
  var_0.atmosfogskyfalloffanglerange = 40;
  var_0.atmosfogsundirection = (0.253516, -0.733714, 0.630391);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = -353.076;
  var_0.atmosfogheightfoghalfplanedistance = 128.876;
}

setupfog() {}