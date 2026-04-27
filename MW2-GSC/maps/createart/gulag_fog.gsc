/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\gulag_fog.gsc
********************************************************/

main() {
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

  ent = maps\_utility::create_vision_set_fog("gulag_hallways");
  ent.startDist = 4000;
  ent.halfwayDist = 8000;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 10;

  ent = maps\_utility::create_fog("gulag_hall");
  ent.startDist = 4000;
  ent.halfwayDist = 8000;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 0;

  ent = maps\_utility::create_fog("gulag");
  ent.startDist = 750;
  ent.halfwayDist = 4000;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.5;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("gulag_ending");
  ent.startDist = 174.6;
  ent.halfwayDist = 16288;
  ent.red = 0.76;
  ent.green = 0.8;
  ent.blue = 0.85;
  ent.maxOpacity = 0.0463;
  ent.transitionTime = 5;

  ent = maps\_utility::create_vision_set_fog("gulag_cafe_falls_apart");
  ent.startDist = 260;
  ent.halfwayDist = 270;
  ent.red = 0.1 * 0.3;
  ent.green = 0.1 * 0.3;
  ent.blue = 0.11 * 0.3;
  ent.maxOpacity = 1;
  ent.transitionTime = 5;

  maps\_utility::vision_set_fog_changes("gulag_flyin", 0);
}