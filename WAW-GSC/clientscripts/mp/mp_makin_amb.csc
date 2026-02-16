/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_makin_amb.csc
*********************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");

  declareAmbientPackage("hut_pkg");

  declareAmbientPackage("walkwaymetal_pkg");

  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "mountains", 1, 1);

  declareAmbientRoom("hut_room");
  setAmbientRoomReverb("hut_room", "wood_room", 1, 1);

  declareAmbientRoom("walkwaymetal_room");
  setAmbientRoomReverb("walkwaymetal_room", "mountains", 1, .3);

  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}