/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\19641.gsc
**************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("so_deltacamp");
  var_0.startdist = 17346.3;
  var_0.halfwaydist = 32487.6;
  var_0.red = 0.583682;
  var_0.green = 0.52939;
  var_0.blue = 0.302793;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  maps\_utility::vision_set_fog_changes("so_deltacamp", 0);
}