/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_backlot_fog_hdr.gsc
*************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_backlot");
  var_0.startdist = 512;
  var_0.halfwaydist = 202753;
  var_0.red = 1;
  var_0.green = 0.957944;
  var_0.blue = 0.747583;
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
  var_0.atmosfogsunfogcolor = (0.52, 0.46, 0.21);
  var_0.atmosfoghazecolor = (0.96, 0.77, 0.63);
  var_0.atmosfoghazestrength = 0.5;
  var_0.atmosfoghazespread = 0.5;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 20;
  var_0.atmosfoghalfplanedistance = 11256;
  var_0.atmosfogstartdistance = 1050;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 175215;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 26;
  var_0.atmosfogskyfalloffanglerange = 11;
  var_0.atmosfogsundirection = (0.882046, 0.0400267, 0.46946);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = -843;
  var_0.atmosfogheightfoghalfplanedistance = 2374;
  var_0 = maps\mp\_art::create_vision_set_fog("mp_backlot_interior");
  var_0.startdist = 512;
  var_0.halfwaydist = 202753;
  var_0.red = 1;
  var_0.green = 0.957944;
  var_0.blue = 0.747583;
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
  var_0.atmosfogsunfogcolor = (0.52, 0.46, 0.21);
  var_0.atmosfoghazecolor = (0.96, 0.77, 0.63);
  var_0.atmosfoghazestrength = 0.5;
  var_0.atmosfoghazespread = 0.5;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 18.5;
  var_0.atmosfoghalfplanedistance = 11256;
  var_0.atmosfogstartdistance = 1250;
  var_0.atmosfogdistancescale = 1;
  var_0.atmosfogskydistance = 24576;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 26;
  var_0.atmosfogskyfalloffanglerange = 11;
  var_0.atmosfogsundirection = (0.882046, 0.0400267, 0.46946);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = -843;
  var_0.atmosfogheightfoghalfplanedistance = 2374;
}

setupfog() {}