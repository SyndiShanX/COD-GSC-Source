/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_kneedeep_amb.csc
************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientpackage("outdoor_pkg");

  declareAmbientpackage("indoor_stone_pkg");

  declareAmbientpackage("indoor_wood_pkg");

  declareAmbientpackage("indoor_metallic_pkg");

  declareAmbientRoom("outdoor_room");
  setAmbientRoomtone("outdoor_room", "bg_steady");
  setAmbientRoomReverb("outdoor_room", "mountains", .8, 1);

  declareAmbientRoom("indoor_stone_room");
  setAmbientRoomReverb("indoor_stone_room", "stoneroom", 1, .9);

  declareAmbientRoom("indoor_wood_room");
  setAmbientRoomReverb("indoor_wood_room", "wood_room", 1, 1);

  declareAmbientRoom("indoor_metallic_room");
  setAmbientRoomReverb("indoor_metallic_room", "sewerpipe", 1, .4);

  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}