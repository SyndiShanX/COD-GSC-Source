/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_suburban_amb.csc
************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");

  declareAmbientPackage("indoor_pkg");

  declareAmbientPackage("train_pkg");

  declareAmbientPackage("shed_pkg");

  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "mountains", 1, 1);

  declareAmbientRoom("indoor_room");
  setAmbientRoomReverb("indoor_room", "mediumroom", 1, 1);

  declareAmbientRoom("train_room");
  setAmbientRoomReverb("train_room", "plate", 1, 1);

  declareAmbientRoom("shed_room");
  setAmbientRoomReverb("shed_room", "smallroom", 1, 1);

  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}