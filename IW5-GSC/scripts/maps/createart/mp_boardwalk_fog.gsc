/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_boardwalk_fog.gsc
*******************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_boardwalk");
  var_0.startdist = 637;
  var_0.halfwaydist = 7043;
  var_0.red = 0.61;
  var_0.green = 0.72;
  var_0.blue = 0.74;
  var_0.maxopacity = 0.45;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.73;
  var_0._id_1AF1 = 0.65;
  var_0._id_1AF2 = 0.56;
  var_0._id_1AF3 = (0.7, 0.25, 0.66);
  var_0._id_1AF4 = 35.5;
  var_0._id_1AF5 = 100.0;
  var_0._id_1AF6 = 1.0;
  var_0 = maps\_utility::create_vision_set_fog("mp_boardwalk_indoor");
  var_0.startdist = 637;
  var_0.halfwaydist = 7043;
  var_0.red = 0.61;
  var_0.green = 0.72;
  var_0.blue = 0.74;
  var_0.maxopacity = 0.45;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.73;
  var_0._id_1AF1 = 0.65;
  var_0._id_1AF2 = 0.56;
  var_0._id_1AF3 = (0.7, 0.25, 0.66);
  var_0._id_1AF4 = 35.5;
  var_0._id_1AF5 = 100.0;
  var_0._id_1AF6 = 1.0;
  var_0 = maps\_utility::create_vision_set_fog("mp_boardwalk_bar");
  var_0.startdist = 637;
  var_0.halfwaydist = 7043;
  var_0.red = 0.61;
  var_0.green = 0.72;
  var_0.blue = 0.74;
  var_0.maxopacity = 0.45;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.73;
  var_0._id_1AF1 = 0.65;
  var_0._id_1AF2 = 0.56;
  var_0._id_1AF3 = (0.7, 0.25, 0.66);
  var_0._id_1AF4 = 35.5;
  var_0._id_1AF5 = 100.0;
  var_0._id_1AF6 = 1.0;
  var_0 = maps\_utility::create_vision_set_fog("mp_boardwalk_hall");
  var_0.startdist = 637;
  var_0.halfwaydist = 7043;
  var_0.red = 0.61;
  var_0.green = 0.72;
  var_0.blue = 0.74;
  var_0.maxopacity = 0.45;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.73;
  var_0._id_1AF1 = 0.65;
  var_0._id_1AF2 = 0.56;
  var_0._id_1AF3 = (0.7, 0.25, 0.66);
  var_0._id_1AF4 = 35.5;
  var_0._id_1AF5 = 100.0;
  var_0._id_1AF6 = 1.0;
  maps\_utility::vision_set_fog_changes("mp_boardwalk", 0);
}