/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_prisonbreak_fog.gsc
*************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_prisonbreak");
  var_0.startdist = 500;
  var_0.halfwaydist = 25000;
  var_0.red = 0.62;
  var_0.green = 0.78;
  var_0.blue = 0.86;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 0.5;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.55;
  var_0.sungreen = 0.45;
  var_0.sunblue = 0.31;
  var_0.hdrsuncolorintensity = 1.0;
  var_0.sundir = (0.99, 0.112215, -0.0120798);
  var_0.sunbeginfadeangle = 10;
  var_0.sunendfadeangle = 92;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 1;
  var_0.skyfogminangle = 2;
  var_0.skyfogmaxangle = 64;
  var_0.hdroverride = "mp_prisonbreak_HDR";
  var_0 = maps\mp\_art::create_vision_set_fog("mp_prisonbreak_indoor");
  var_0.startdist = 2500;
  var_0.halfwaydist = 9500;
  var_0.red = 0.627451;
  var_0.green = 0.717647;
  var_0.blue = 0.745098;
  var_0.maxopacity = 0.41;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.554666;
  var_0.sungreen = 0.458303;
  var_0.sunblue = 0.312117;
  var_0.sundir = (0.99, 0.112215, -0.0120798);
  var_0.sunbeginfadeangle = 10;
  var_0.sunendfadeangle = 92;
  var_0.normalfogscale = 1.0;
  var_0 = maps\mp\_art::create_vision_set_fog("mp_prisonbreak_HDR");
  var_0.startdist = 500;
  var_0.halfwaydist = 4500;
  var_0.red = 0.62;
  var_0.green = 0.71;
  var_0.blue = 0.86;
  var_0.hdrcolorintensity = 1.2;
  var_0.maxopacity = 0.71;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.55;
  var_0.sungreen = 0.5;
  var_0.sunblue = 0.43;
  var_0.hdrsuncolorintensity = 1.0;
  var_0.sundir = (0.99, 0.112215, -0.0120798);
  var_0.sunbeginfadeangle = 10;
  var_0.sunendfadeangle = 92;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 1;
  var_0.skyfogminangle = 8;
  var_0.skyfogmaxangle = 82;
}