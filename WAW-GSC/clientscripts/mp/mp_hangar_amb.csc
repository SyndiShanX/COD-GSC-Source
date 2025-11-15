/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_hangar_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");
  declareambientpackage("main_hangar_pkg");
  declareambientpackage("hangar_sml_pkg");
  declareambientpackage("hangar_med_pkg");
  declareambientpackage("outside_sml_pkg");
  declareambientpackage("stone_pkg");
  declareambientpackage("outside_walkway_pkg");
  declareambientpackage("outside_dirt_pkg");
  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "mountains", 1, 1);
  declareAmbientRoom("main_hangar_room");
  setAmbientRoomReverb("main_hangar_room", "dome_int", 1, .7);
  declareAmbientRoom("hangar_sml_room");
  setAmbientRoomReverb("hangar_sml_room", "smallroom", 1, .5);
  declareAmbientRoom("hangar_med_room");
  setAmbientRoomReverb("hangar_med_room", "dome_int", 1, .5);
  declareAmbientRoom("outside_sml_room");
  setAmbientRoomReverb("outside_sml_room", "mediumroom", 1, .7);
  declareAmbientRoom("stone_room");
  setAmbientRoomReverb("stone_room", "stoneroom", 1, .3);
  declareAmbientRoom("outside_walkway_room");
  setAmbientRoomReverb("outside_walkway_room", "mountains", 1, .6);
  declareAmbientRoom("outside_dirt_room");
  setAmbientRoomReverb("outside_dirt_room", "livingroom", 1, .8);
  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}