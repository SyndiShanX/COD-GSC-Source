/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\createart\mp_cargoship_fog_hdr.gsc
***************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_cargoship");
  var_0.startdist = 1696;
  var_0.halfwaydist = 12289;
  var_0.red = 0.258821;
  var_0.green = 0.309172;
  var_0.blue = 0.350739;
  var_0.hdrcolorintensity = 12.029;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.369427;
  var_0.sungreen = 0.467384;
  var_0.sunblue = 0.501062;
  var_0.hdrsuncolorintensity = 15.5251;
  var_0.sundir = (0.526726, -0.470463, 0.707973);
  var_0.sunbeginfadeangle = 7.10021;
  var_0.sunendfadeangle = 143.004;
  var_0.normalfogscale = 2.19207;
  var_0.skyfogintensity = 0.669102;
  var_0.skyfogminangle = -12.2129;
  var_0.skyfogmaxangle = 50.6368;
  var_0.heightfogenabled = 0;
  var_0.heightfogbaseheight = 0;
  var_0.heightfoghalfplanedistance = 1000;
  var_0.atmosfogenabled = 1;
  var_0.atmosfogsunfogcolor = (0.446809, 0.446433, 0.446396);
  var_0.atmosfoghazecolor = (0.422966, 0.537899, 0.649682);
  var_0.atmosfoghazestrength = 0.0702613;
  var_0.atmosfoghazespread = 0.012897;
  var_0.atmosfogextinctionstrength = 1;
  var_0.atmosfoginscatterstrength = 5.8;
  var_0.atmosfoghalfplanedistance = 800;
  var_0.atmosfogstartdistance = 400;
  var_0.atmosfogdistancescale = 2;
  var_0.atmosfogskydistance = 103612;
  var_0.atmosfogskyangularfalloffenabled = 1;
  var_0.atmosfogskyfalloffstartangle = 1.53992;
  var_0.atmosfogskyfalloffanglerange = 720;
  var_0.atmosfogsundirection = (0.581172, -0.39083, 0.713786);
  var_0.atmosfogheightfogenabled = 1;
  var_0.atmosfogheightfogbaseheight = 150;
  var_0.atmosfogheightfoghalfplanedistance = 7000;
}

setupfog() {}