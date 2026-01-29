/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_cement_fog.gsc
****************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_cement");
  var_0.startdist = 541;
  var_0.halfwaydist = 5000;
  var_0.red = 0.498;
  var_0.green = 0.557;
  var_0.blue = 0.556;
  var_0.maxopacity = 0.568;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
}