/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_shipbreaker_fog.gsc
*********************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_shipbreaker");
  var_0.startdist = 480;
  var_0.halfwaydist = 11000;
  var_0.red = 0.842;
  var_0.green = 0.919;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.17;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.856;
  var_0._id_1AF1 = 0.901;
  var_0._id_1AF2 = 1.0;
  var_0._id_1AF3 = (0.0039, 0.0032, -1);
  var_0._id_1AF4 = 83.5416;
  var_0._id_1AF5 = 111.335;
  var_0._id_1AF6 = 1.26955;
  var_0 = maps\_utility::create_vision_set_fog("mp_shipbreaker_interior");
  var_0.startdist = 480;
  var_0.halfwaydist = 11000;
  var_0.red = 0.842;
  var_0.green = 0.919;
  var_0.blue = 1.0;
  var_0.maxopacity = 0.17;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.856;
  var_0._id_1AF1 = 0.901;
  var_0._id_1AF2 = 1.0;
  var_0._id_1AF3 = (0.0039, 0.0032, -1);
  var_0._id_1AF4 = 83.5416;
  var_0._id_1AF5 = 111.335;
  var_0._id_1AF6 = 1.26955;
}