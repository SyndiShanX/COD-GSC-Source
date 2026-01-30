/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_zombie_h2o_fog.gsc
************************************************/

main() {
  var_0 = maps\mp\_art::create_vision_set_fog("mp_zombie_h2o");
  var_0.startdist = 786.0;
  var_0.halfwaydist = 55000.0;
  var_0.red = 0.586;
  var_0.green = 0.833;
  var_0.blue = 0.817;
  var_0.maxopacity = 0.5;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
}

setupfog() {}