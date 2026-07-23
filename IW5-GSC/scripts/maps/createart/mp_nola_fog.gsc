/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_nola_fog.gsc
**************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_nola");
  var_0.startdist = 168.45;
  var_0.halfwaydist = 5503.32;
  var_0.red = 0.681;
  var_0.green = 0.684;
  var_0.blue = 0.687;
  var_0.maxopacity = 0.2875;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.826;
  var_0._id_1AF1 = 0.763;
  var_0._id_1AF2 = 0.696;
  var_0._id_1AF3 = (-0.046, -0.78, 0.622);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 115.8;
  var_0._id_1AF6 = 1.0;
  var_0 = maps\_utility::create_vision_set_fog("mp_nola_indoor");
  var_0.startdist = 300;
  var_0.halfwaydist = 7971;
  var_0.red = 0.681;
  var_0.green = 0.684;
  var_0.blue = 0.687;
  var_0.maxopacity = 0.2;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.826;
  var_0._id_1AF1 = 0.763;
  var_0._id_1AF2 = 0.696;
  var_0._id_1AF3 = (-0.046, -0.78, 0.622);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 105.8;
  var_0._id_1AF6 = 1.0;
  var_0 = maps\_utility::create_vision_set_fog("mp_nola_church");
  var_0.startdist = 300;
  var_0.halfwaydist = 7971;
  var_0.red = 0.681;
  var_0.green = 0.684;
  var_0.blue = 0.687;
  var_0.maxopacity = 0.2;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.826;
  var_0._id_1AF1 = 0.763;
  var_0._id_1AF2 = 0.696;
  var_0._id_1AF3 = (-0.046, -0.78, 0.622);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 105.8;
  var_0._id_1AF6 = 1.0;
  maps\_utility::vision_set_fog_changes("mp_nola", 0);
}