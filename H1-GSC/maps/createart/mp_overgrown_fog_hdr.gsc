/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_overgrown_fog_hdr.gsc
***************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_overgrown");
  var_0.startdist = 1423.51;
  var_0.halfwaydist = 6300.3;
  var_0.red = 0.742358;
  var_0.green = 0.671204;
  var_0.blue = 0.594049;
  var_0.hdrcolorintensity = 14.4306;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0.584281;
  var_0.sungreen = 0.496381;
  var_0.sunblue = 0.37849;
  var_0.hdrsuncolorintensity = 16.2828;
  var_0.sundir = (-0.596316, 0.596888, 0.536778);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 38.5117;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 0.529689;
  var_0.skyfogminangle = 46.4867;
  var_0.skyfogmaxangle = 78;
  var_0.heightfogenabled = 1;
  var_0.heightfogbaseheight = 14.2465;
  var_0.heightfoghalfplanedistance = 389.981;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (1, 0.95, 0.9);
  var_0.atmosfoghazecolor = (0.94, 0.96, 1);
  var_0.atmosfoghazestrength = 0.5;
  var_0.atmosfoghazespread = 0.015;
  var_0.atmosfogextinctionstrength = 0.8;
  var_0.atmosfoginscatterstrength = 17.5;
  var_0.atmosfoghalfplanedistance = 4000;
  var_0.atmosfogstartdistance = 4100;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 100000;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 0;
  var_0.atmosfogskyfalloffanglerange = 50;
  var_0.atmosfogsundirection = (0.431484, -0.751562, 0.498798);
  var_0.atmosfogheightfogenabled = 0;
  var_0.atmosfogheightfogbaseheight = 356.052;
  var_0.atmosfogheightfoghalfplanedistance = 346.845;
}

setupfog() {}