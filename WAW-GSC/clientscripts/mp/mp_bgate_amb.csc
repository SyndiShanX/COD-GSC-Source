/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_bgate_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoors_pkg");
  declareAmbientPackage("small_room_pkg");
  declareAmbientPackage("partial_room_pkg");
  declareAmbientRoom("outdoors_room");
  setAmbientRoomTone("outdoors_room", "outdoor_wind");
  setAmbientRoomReverb("outdoors_room", "mountains", 1, 1);
  declareAmbientRoom("small_room");
  setAmbientRoomTone("small_room", "indoor_wind");
  setAmbientRoomReverb("small_room", "partial_room", 1, .9);
  declareAmbientRoom("partial_room");
  setAmbientRoomTone("partial_room", "partial_wind");
  setAmbientRoomReverb("partial_room", "partial_room", 1, 1);
  activateAmbientPackage(0, "outdoors_pkg", 0);
  activateAmbientRoom(0, "outdoors_room", 0);
}