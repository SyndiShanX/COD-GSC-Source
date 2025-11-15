/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_courtyard_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoors_pkg");
  declareAmbientPackage("under_balcony_pkg");
  declareAmbientPackage("underground_pkg");
  declareAmbientPackage("wooden_pkg");
  declareAmbientRoom("outdoors_room");
  setAmbientRoomReverb("outdoors_room", "mountains", 1, 1);
  declareAmbientRoom("under_balcony_room");
  setAmbientRoomReverb("under_balcony_room", "partial_room", 1, 1);
  declareAmbientRoom("underground_room");
  setAmbientRoomTone("underground_room", "underground_tone");
  setAmbientRoomReverb("underground_room", "stonecorridor", 1, .8);
  declareAmbientRoom("wooden_room");
  setAmbientRoomReverb("wooden_room", "wood_room", 1, 1);
  activateAmbientPackage(0, "outdoors_pkg", 0);
  activateAmbientRoom(0, "outdoors_room", 0);
}