/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_desert\mp_desert.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_desert\mp_desert_precache::main();
  scripts\mp\maps\mp_desert\gen\mp_desert_art::main();
  scripts\mp\maps\mp_desert\mp_desert_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_desert");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraAccurateOcclusionThreshold", 1200);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread _id_FAE6("roomba", 32, 1);
  thread _id_FAE6("roomba2", 16, 0.15);
  thread fix_collision();
}

fix_collision() {
  var_0 = getEnt("clip64x64x128", "targetname");
  var_1 = spawn("script_model", (2342, -92, 354));
  var_1.angles = (2, 50, 2);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x256", "targetname");
  var_3 = spawn("script_model", (2292, -212, 362));
  var_3.angles = (6, 51, 18);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip256x256x8", "targetname");
  var_5 = spawn("script_model", (996, 796, 524));
  var_5.angles = (0, 335, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
}

_id_FAE6(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_3.destination = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_3._id_BCEF = 1.0 / var_1;

  for(;;)
    var_3.destination = _id_E6E1(var_3, var_2);
}

_id_E6E1(var_0, var_1) {
  var_0 endon("death");
  var_2 = scripts\engine\utility::getStruct(var_0.destination.target, "targetname");
  var_3 = abs(distance(var_0.origin, var_2.origin) * var_0._id_BCEF);
  var_0 playLoopSound("rolling_bot_move_lp");
  var_0 moveTo(var_2.origin, var_3, var_3 * 0.25, var_3 * 0.25);
  wait(var_3);
  var_0 stoploopsound("rolling_bot_move_lp");
  var_0 rotateTo(var_2.angles, var_1, 0, 0);
  var_0 playLoopSound("rolling_bot_turn_lp");
  wait(var_1);
  var_0 stoploopsound("rolling_bot_turn_lp");
  return var_2;
}