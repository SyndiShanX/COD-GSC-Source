/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_dome_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");
  declareAmbientPackage("dome_out_hall_pkg");
  declareAmbientPackage("dome_int_hall_pkg");
  addambientelement("dome_int_hall_pkg", "arty_aftershock", 15, 45, 100, 500);
  declareAmbientPackage("dome_int_pkg");
  addambientelement("dome_int_pkg", "arty_aftershock", 15, 45, 100, 500);
  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "dome_out", 0.8, 1);
  declareAmbientRoom("dome_out_hall_room");
  setAmbientRoomReverb("dome_out_hall_room", "dome_out_hall", 0.8, 1);
  declareAmbientRoom("dome_int_hall_room");
  setAmbientRoomReverb("dome_int_hall_room", "dome_int_hall", 1, 1);
  declareAmbientRoom("dome_int_room");
  setAmbientRoomReverb("dome_int_room", "dome_int", 1, 1);
  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}