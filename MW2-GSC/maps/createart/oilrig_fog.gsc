/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\oilrig_fog.gsc
********************************************************/

main() {
  level.tweakfile = false;

  setDevDvar("scr_fog_disable", "0");

  ent = maps\_utility::create_vision_set_fog("oilrig_underwater");
  ent.startDist = 0;
  ent.halfwayDist = 852;
  ent.red = 0.0431373;
  ent.green = 0.219608;
  ent.blue = 0.247059;
  ent.maxOpacity = 1;
  ent.transitionTime = 0;

  ent.sunRed = 0.0370898;
  ent.sunGreen = 0.0748127;
  ent.sunBlue = 0.125266;
  ent.sunDir = (-0.0563281, 0.0228246, -1);
  ent.sunBeginFadeAngle = 85;
  ent.sunEndFadeAngle = 101.5;
  ent.normalFogScale = 1;

  ent = maps\_utility::create_vision_set_fog("oilrig_exterior_deck0");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_interior");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_exterior_deck1");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_exterior_deck2");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_exterior_deck3");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_exterior_deck4");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_exterior_heli");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;

  ent = maps\_utility::create_vision_set_fog("oilrig_interior2");
  ent.startDist = 903.412;
  ent.halfwayDist = 2990.19;
  ent.red = 0.175482;
  ent.green = 0.221931;
  ent.blue = 0.293875;
  ent.maxOpacity = 0.751126;
  ent.transitionTime = 0;
}