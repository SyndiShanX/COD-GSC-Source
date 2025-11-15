/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_nachtfeuer_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");
  addAmbientElement("outdoor_pkg", "ember", .1, .6, 50, 150);
  declareAmbientPackage("radio_pkg");
  declareAmbientPackage("woody_pkg");
  declareAmbientPackage("central_building_pkg");
  declareAmbientPackage("alleyway_pkg");
  addAmbientElement("alleyway_pkg", "ember", .1, .6, 50, 150);
  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "quarry", .8, .6);
  declareAmbientRoom("radio_room");
  setAmbientRoomReverb("radio_room", "stonecorridor", 1, .5);
  declareAmbientRoom("woody_room");
  setAmbientRoomReverb("woody_room", "wooden_structure", 1, 1);
  declareAmbientRoom("central_building_room");
  setAmbientRoomReverb("central_building_room", "stoneroom", 1, .6);
  declareAmbientRoom("alleyway_room");
  setAmbientRoomReverb("alleyway_room", "quarry", 1, .8);
  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}