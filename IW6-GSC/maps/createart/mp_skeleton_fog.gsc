/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_skeleton_fog.gsc
**********************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_skeleton");
  var_0.startdist = 246;
  var_0.halfwaydist = 13816;
  var_0.red = 0.899167;
  var_0.green = 0.930833;
  var_0.blue = 1;
  var_0.hdrcolorintensity = 3.42928;
  var_0.maxopacity = 0.95;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0.5;
  var_0.sungreen = 0.5;
  var_0.sunblue = 0.5;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (0, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 1;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 1;
  var_0.skyfogminangle = 33;
  var_0.skyfogmaxangle = 80;
  var_0 = maps\mp\_art::create_vision_set_fog("mp_skeleton_indoor");
  var_0.startdist = 2500;
  var_0.halfwaydist = 9500;
  var_0.red = 0.627451;
  var_0.green = 0.717647;
  var_0.blue = 0.745098;
  var_0.hdrcolorintensity = 1;
  var_0.maxopacity = 0.41;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 0.554666;
  var_0.sungreen = 0.458303;
  var_0.sunblue = 0.312117;
  var_0.hdrsuncolorintensity = 1;
  var_0.sundir = (0.99, 0.112215, -0.0120798);
  var_0.sunbeginfadeangle = 10;
  var_0.sunendfadeangle = 92;
  var_0.normalfogscale = 1;
  var_0.skyfogintensity = 0;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
}