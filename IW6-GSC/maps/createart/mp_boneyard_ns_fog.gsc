/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_boneyard_ns_fog.gsc
*************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_boneyard_ns");
  var_0.startdist = 49;
  var_0.halfwaydist = 9006;
  var_0.red = 0.556;
  var_0.green = 0.578;
  var_0.blue = 0.663;
  var_0.maxopacity = 0.9;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 1;
  var_0.sungreen = 0.774;
  var_0.sunblue = 0.573;
  var_0.sundir = (0.804, 0.586, 0.091);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 50;
  var_0.skyfogintensity = 0.54;
  var_0.skyfogminangle = 24;
  var_0.skyfogmaxangle = 76;
  var_0.normalfogscale = 0.7475;
  var_0.hdroverride = "mp_boneyard_ns_HDR";
  var_0 = maps\mp\_art::create_vision_set_fog("mp_boneyard_ns_HDR");
  var_0.startdist = 403;
  var_0.halfwaydist = 9006;
  var_0.red = 0.541;
  var_0.green = 0.558;
  var_0.blue = 0.578;
  var_0.maxopacity = 0.9;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0.sunred = 1;
  var_0.sungreen = 0.77;
  var_0.sunblue = 0.57;
  var_0.sundir = (0.804, 0.586, 0.091);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 50;
  var_0.normalfogscale = 0.374;
  var_0.skyfogintensity = 0.54;
  var_0.skyfogminangle = 40;
  var_0.skyfogmaxangle = 76;
  var_0.hdrcolorintensity = 1.49;
  var_0.hdrsuncolorintensity = 1.5;
}