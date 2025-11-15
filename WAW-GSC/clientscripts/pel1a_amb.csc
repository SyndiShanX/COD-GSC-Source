/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pel1a_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
  package = "pel1_atsea";
  declareAmbientPackage(package);
  declareAmbientPackage("pel1_outdoors");
  addAmbientElement("pel1_outdoors", "amb_bugs_other", 8, 15, 25, 110);
  addAmbientElement("pel1_outdoors", "amb_bugs_cicada", 35, 45, 50, 120);
  addAmbientElement("pel1_outdoors", "amb_seagull", 15, 30, 500, 1500);
  addAmbientElement("pel1_outdoors", "amb_mosquito", 15, 30);
  addAmbientElement("pel1_outdoors", "amb_flies", 10, 20, 10, 110);
  addAmbientElement("pel1_outdoors", "amb_bugs_other", 8, 15, 25, 510);
  addAmbientElement("pel1_outdoors", "amb_bugs_cicada", 15, 35, 50, 1220);
  addAmbientElement("pel1_outdoors", "amb_odd_bug", 5, 20, 100, 300);
  package = "pel1_bunker";
  declareAmbientPackage(package);
  addAmbientElement(package, "amb_mosquito", 15, 30);
  addAmbientElement(package, "amb_flies", 10, 20, 10, 110);
  addAmbientElement(package, "amb_wood_creak", 5, 20, 100, 300);
  addAmbientElement(package, "amb_sand_fall", 5, 20, 100, 300);
  addAmbientElement(package, "bomb_far_falloff_occluded", 2, 10, 1000, 4500);
  package = "pel1_wd_bunker";
  declareAmbientPackage(package);
  addAmbientElement(package, "amb_seagull", 10, 20, 10, 150);
  addAmbientElement(package, "amb_water_drips", 0.4, 6.0, 10, 25);
  package = "pel1_underground";
  declareAmbientPackage(package);
  addAmbientElement(package, "amb_mosquito", 20, 40);
  addAmbientElement(package, "amb_flies", 10, 20, 50, 410);
  addAmbientElement(package, "amb_wood_creak", 5, 10, 100, 500);
  addAmbientElement(package, "amb_sand_fall", 2, 15, 100, 500);
  addAmbientElement(package, "amb_wood_dust", 2, 10, 10, 150);
  package = "pel1_metal_cone";
  declareAmbientPackage(package);
  addAmbientElement(package, "amb_water_drips", 0.4, 6.0, 10, 25);
  package = "pel1_concrete_bldg";
  declareAmbientPackage(package);
  addAmbientElement(package, "amb_seagull", 10, 20, 10, 150);
  room = "pel1_atsea";
  declareAmbientRoom(room);
  setAmbientRoomTone(room, "bgt_wind_atsea");
  room = "pel1_outdoors";
  declareAmbientRoom(room);
  setAmbientRoomTone(room, "bgt_wind_land");
  room = "pel1_bunker";
  declareAmbientRoom(room);
  setAmbientRoomTone(room, "bgt_wind_interior");
  room = "pel1_wd_bunker";
  declareAmbientRoom(room);
  setAmbientRoomTone(room, "bgt_wind_interior");
  room = "pel1_underground";
  declareAmbientRoom(room);
  setAmbientRoomTone(room, "bgt_wind_interior");
  room = "pel1_concrete_bldg";
  declareAmbientRoom(room);
  setAmbientRoomTone(room, "bgt_wind_interior");
  declareAmbientRoom("pel1_metal_cone");
  setAmbientRoomTone("pel1_metal_cone", "bgt_wind_interior");
  activateAmbientPackage(0, "pel1_outdoors", 0);
  activateAmbientRoom(0, "pel1_outdoors", 0);
  declareMusicState("INTRO");
  musicAlias("mx_intro_stinger", 0);
  musicAliasloop("mx_underscore", 0, 8);
  declareMusicState("LEVEL_END");
  musicAlias("mx_end", 0);
}