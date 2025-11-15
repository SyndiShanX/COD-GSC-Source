/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_downfall_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoors_pkg");
  declareAmbientPackage("indoors1_pkg");
  declareAmbientPackage("indoors2_pkg");
  declareAmbientPackage("partial_pkg");
  declareAmbientPackage("steps_pkg");
  declareAmbientPackage("corridor_pkg");
  declareAmbientPackage("underground_pkg");
  declareAmbientRoom("outdoors_room");
  setAmbientRoomTone("outdoors_room", "outdoors_wind");
  setAmbientRoomReverb("outdoors_room", "mountains", 1, 1);
  declareAmbientRoom("indoors1_room");
  setAmbientRoomTone("indoors1_room", "indoors_wind");
  setAmbientRoomReverb("indoors1_room", "stoneroom", 1, .9);
  declareAmbientRoom("indoors2_room");
  setAmbientRoomTone("indoors2_room", "partial_wind");
  setAmbientRoomReverb("indoors2_room", "wood_room", 1, 1);
  declareAmbientRoom("partial_room");
  setAmbientRoomTone("partial_room", "outdoors_wind");
  setAmbientRoomReverb("partial_room", "partial_room", 1, 1);
  declareAmbientRoom("steps_room");
  setAmbientRoomTone("steps_room", "outdoors_wind");
  setAmbientRoomReverb("steps_room", "stoneroom", 1, .5);
  declareAmbientRoom("corridor_room");
  setAmbientRoomTone("corridor_room", "partial_wind");
  setAmbientRoomReverb("corridor_room", "stoneroom", 1, .8);
  declareAmbientRoom("underground_room");
  setAmbientRoomTone("underground_room", "underground_wind");
  setAmbientRoomReverb("underground_room", "dirt_tunnel", 1, 1);
  activateAmbientPackage(0, "outdoors_pkg", 0);
  activateAmbientRoom(0, "outdoors_room", 0);
}