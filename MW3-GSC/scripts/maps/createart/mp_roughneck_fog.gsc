/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_roughneck_fog.gsc
*******************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_roughneck");
  var_0.startdist = 512.098;
  var_0.halfwaydist = 4150;
  var_0.red = 0.331909;
  var_0.green = 0.373677;
  var_0.blue = 0.394813;
  var_0.maxopacity = 1;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.837117;
  var_0._id_1AF1 = 0.834223;
  var_0._id_1AF2 = 0.813915;
  var_0._id_1AF3 = (-0.00178854, 0.413538, 0.910485);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 121.977;
  var_0._id_1AF6 = 0.310851;
  var_0 = maps\_utility::create_vision_set_fog("mp_roughneck_indoor");
  var_0.startdist = 256;
  var_0.halfwaydist = 2700;
  var_0.red = 0.331909;
  var_0.green = 0.373677;
  var_0.blue = 0.394813;
  var_0.maxopacity = 0.75;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.837117;
  var_0._id_1AF1 = 0.834223;
  var_0._id_1AF2 = 0.813915;
  var_0._id_1AF3 = (-0.00178854, 0.413538, 0.910485);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 121.977;
  var_0._id_1AF6 = 0.310851;
  var_0 = maps\_utility::create_vision_set_fog("mp_roughneck_water");
  var_0.startdist = 0.0;
  var_0.halfwaydist = 97.41;
  var_0.red = 0.1;
  var_0.green = 0.2;
  var_0.blue = 0.2;
  var_0.maxopacity = 1.0;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.267;
  var_0._id_1AF1 = 0.275;
  var_0._id_1AF2 = 0.277;
  var_0._id_1AF3 = (0.72, -0.6, 0.32);
  var_0._id_1AF4 = 24.1;
  var_0._id_1AF5 = 52.7;
  var_0._id_1AF6 = 8.3;
  var_0 = maps\_utility::create_vision_set_fog("mp_roughneck_water_deep");
  var_0.startdist = 0.0;
  var_0.halfwaydist = 97.41;
  var_0.red = 0.1;
  var_0.green = 0.2;
  var_0.blue = 0.2;
  var_0.maxopacity = 1.0;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 1;
  var_0._id_1AF0 = 0.267;
  var_0._id_1AF1 = 0.275;
  var_0._id_1AF2 = 0.277;
  var_0._id_1AF3 = (0.72, -0.6, 0.32);
  var_0._id_1AF4 = 24.1;
  var_0._id_1AF5 = 52.7;
  var_0._id_1AF6 = 8.3;
  maps\_utility::vision_set_fog_changes("mp_roughneck", 0);
}