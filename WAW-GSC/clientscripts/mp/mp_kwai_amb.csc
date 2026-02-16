/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_kwai_amb.csc
********************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientpackage("outdoor_pkg");

  declareAmbientpackage("cave_pkg");

  declareAmbientpackage("partial_pkg");

  declareAmbientpackage("full_pkg");

  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "mountains", .8, 1);
  setAmbientRoomtone("outdoor_room", "bg_steady");

  declareAmbientRoom("cave_room");
  setAmbientRoomReverb("cave_room", "stoneroom", 1, 1);
  setAmbientRoomtone("cave_room", "cave_int");

  declareAmbientRoom("partial_room");
  setAmbientRoomReverb("partial_room", "wood_room", 1, 1);
  setAmbientRoomtone("partial_room", "partial");

  declareAmbientRoom("full_room");
  setAmbientRoomReverb("full_room", "wood_room", 1, 1);
  setAmbientRoomtone("full_room", "full");

  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}