/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\loki_fog.gsc
***************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("loki");
  var_0.startdist = 0;
  var_0.halfwaydist = 32487.6;
  var_0.red = 0.688;
  var_0.green = 0.854;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.01;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.skyfogintensity = 0.72;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0 = maps\_utility::create_vision_set_fog("loki_combat2");
  var_0.startdist = 0;
  var_0.halfwaydist = 32487.6;
  var_0.red = 0.698;
  var_0.green = 0.964;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.015;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.skyfogintensity = 0.95;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0 = maps\_utility::create_vision_set_fog("loki_breach");
  var_0.startdist = 0;
  var_0.halfwaydist = 32487.6;
  var_0.red = 0.698;
  var_0.green = 0.964;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.015;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.skyfogintensity = 0.95;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0 = maps\_utility::create_vision_set_fog("loki_infil");
  var_0.startdist = 0;
  var_0.halfwaydist = 32487.6;
  var_0.red = 0.698;
  var_0.green = 0.964;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.015;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.skyfogintensity = 0.95;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0 = maps\_utility::create_vision_set_fog("loki_ending");
  var_0.startdist = 0;
  var_0.halfwaydist = 32487.6;
  var_0.red = 0.698;
  var_0.green = 0.964;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.015;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.skyfogintensity = 0.95;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0 = maps\_utility::create_vision_set_fog("loki_rog");
  var_0.startdist = 15000;
  var_0.halfwaydist = 85000;
  var_0.red = 0.84;
  var_0.green = 0.91;
  var_0.blue = 0.96;
  var_0.maxopacity = 0.48;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0.sunred = 0;
  var_0.sungreen = 0;
  var_0.sunblue = 0;
  var_0.sundir = (0, 0, 0);
  var_0.sunbeginfadeangle = 0;
  var_0.sunendfadeangle = 0;
  var_0.normalfogscale = 0;
  var_0.skyfogintensity = 0.5;
  var_0.skyfogminangle = 0;
  var_0.skyfogmaxangle = 0;
  var_0.hdrcolorintensity = 2.1;
  sunflare();
}

sunflare() {
  var_0 = maps\_utility::create_sunflare_setting("default");
  var_0.position = (-39, 4, 0);
  maps\_art::sunflare_changes("default", 0);
}