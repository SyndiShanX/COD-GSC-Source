/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\dcburning_fog.gsc
********************************************************/

main() {
  level.tweakfile = false;

  setDevDvar("scr_fog_disable", "0");

  ent = maps\_utility::create_vision_set_fog("dcburning_bunker");
  ent.startDist = 4430;
  ent.halfwayDist = 11791;
  ent.red = 0.0992;
  ent.green = 0.0791;
  ent.blue = 0.0711;
  ent.maxOpacity = 0.366379;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("dcburning_trenches");
  ent.startDist = 4430;
  ent.halfwayDist = 11791;
  ent.red = 0.0992;
  ent.green = 0.0791;
  ent.blue = 0.0711;
  ent.maxOpacity = 0.366379;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("dcburning_commerce");
  ent.startDist = 4430;
  ent.halfwayDist = 11791;
  ent.red = 0.0992;
  ent.green = 0.0791;
  ent.blue = 0.0711;
  ent.maxOpacity = 0.366379;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("dcburning_rooftops");
  ent.startDist = 4430;
  ent.halfwayDist = 11791;
  ent.red = 0.0992;
  ent.green = 0.0791;
  ent.blue = 0.0711;
  ent.maxOpacity = 0.366379;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("dcburning_heliride");
  ent.startDist = 4430;
  ent.halfwayDist = 24073.8;
  ent.red = 0.0992;
  ent.green = 0.0791;
  ent.blue = 0.0711;
  ent.maxOpacity = 0.568751;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("dcburning_crash");
  ent.startDist = 4430;
  ent.halfwayDist = 24073.8;
  ent.red = 0.0992;
  ent.green = 0.0791;
  ent.blue = 0.0711;
  ent.maxOpacity = 0.568751;
  ent.transitionTime = 0;

  maps\_utility::vision_set_fog_changes("dcburning_bunker", 0);
}