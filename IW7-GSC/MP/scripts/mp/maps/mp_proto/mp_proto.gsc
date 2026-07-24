/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_proto\mp_proto.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_proto\mp_proto_precache::main();
  scripts\mp\maps\mp_proto\gen\mp_proto_art::main();
  scripts\mp\maps\mp_proto\mp_proto_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_proto");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_drawsun", 0);
  setDvar("r_tessellation", 0);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread _id_9284();
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
}

fix_collision() {
  var_0 = getEnt("clip64x64x128", "targetname");
  var_1 = spawn("script_model", (-874, -92, 602));
  var_1.angles = (0, 270, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x128", "targetname");
  var_3 = spawn("script_model", (-874, -129, 602));
  var_3.angles = (0, 270, -90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip64x64x128", "targetname");
  var_5 = spawn("script_model", (-874, -92, 538));
  var_5.angles = (0, 270, -90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip64x64x128", "targetname");
  var_7 = spawn("script_model", (-874, -129, 538));
  var_7.angles = (0, 270, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
}

_id_9284() {
  var_0 = 17;
  level._id_9285 = getEntArray("ice_drill", "targetname");

  foreach(var_3, var_2 in level._id_9285)
  var_2 thread _id_E6FD(var_0 * (level._id_9285.size - var_3));
}

_id_E6FD(var_0) {
  level endon("stop drill");

  for(;;) {
    self rotatepitch(360, var_0, 0, 0);
    wait(var_0);
  }
}