/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_asylum_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");
  declareAmbientPackage("building_interior_pkg");
  declareAmbientPackage("building_washroom_pkg");
  declareAmbientPackage("courtyard_pkg");
  declareAmbientPackage("alcove_pkg");
  declareAmbientPackage("tunnel_pkg");
  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "mountains", 1, 1);
  declareAmbientRoom("building_interior_room");
  setAmbientRoomTone("building_interior_room", "building_interior_room");
  setAmbientRoomReverb("building_interior_room", "mediumroom", 1, 1);
  declareAmbientRoom("building_washroom_room");
  setAmbientRoomTone("building_washroom_room", "building_washroom_room");
  setAmbientRoomReverb("building_washroom_room", "stoneroom", 1, .3);
  declareAmbientRoom("courtyard_room");
  setAmbientRoomReverb("courtyard_room", "mediumroom", 1, .8);
  declareAmbientRoom("alcove_room");
  setAmbientRoomReverb("alcove_room", "mediumroom", 1, .8);
  declareAmbientRoom("tunnel_room");
  setAmbientRoomReverb("tunnel_room", "mediumroom", 1, .8);
  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}