/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\gulag_art.gsc
********************************************************/

main() {
  level.tweakfile = false;

  setDevDvar("scr_fog_disable", "0");

  ent = maps\_utility::create_vision_set_fog("gulag_flyin");
  ent.startDist = 6000;
  ent.halfwayDist = 72000;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 1;

  ent = maps\_utility::create_vision_set_fog("gulag_circle");
  ent.startDist = 500;
  ent.halfwayDist = 40000;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 10;

  ent = maps\_utility::create_vision_set_fog("gulag");
  ent.startDist = 750;
  ent.halfwayDist = 4000;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 10;

  maps\_utility::vision_set_changes("gulag_flyin", 0);
}