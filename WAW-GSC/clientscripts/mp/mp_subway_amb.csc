/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_subway_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("station_int_pkg");
  declareAmbientPackage("main_tunnel_pkg");
  declareAmbientPackage("car_int_pkg");
  declareAmbientRoom("station_int_room");
  setAmbientRoomReverb("station_int_room", "STONECORRIDOR", 1, 0.6);
  declareAmbientRoom("main_tunnel_room");
  setAmbientRoomReverb("main_tunnel_room", "CONCERTHALL", 1, 0.9);
  declareAmbientRoom("car_int_room");
  setAmbientRoomReverb("car_int_room", "sewerpipe", 1, 1);
  activateAmbientPackage(0, "station_int_pkg", 0);
  activateAmbientRoom(0, "station_int_room", 0);
}