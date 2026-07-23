/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\33375.gsc
**************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_overwatch");
  var_0.startdist = 1200;
  var_0.halfwaydist = 88053.4;
  var_0.red = 0.729014;
  var_0.green = 0.702022;
  var_0.blue = 0.698223;
  var_0.maxopacity = 0.156545;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.4312;
  var_0._id_1AF1 = 0.4302;
  var_0._id_1AF2 = 0.4313;
  var_0._id_1AF3 = (0, 0, -1);
  var_0._id_1AF4 = 12;
  var_0._id_1AF5 = 78;
  var_0._id_1AF6 = 0.7343;
  maps\_utility::vision_set_fog_changes("mp_overwatch", 0);
}