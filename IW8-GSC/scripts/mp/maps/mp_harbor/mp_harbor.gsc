/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_harbor\mp_harbor.gsc
***************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  scripts\mp\maps\mp_harbor\mp_harbor_precache::main();
  scripts\mp\maps\mp_harbor\gen\mp_harbor_art::main();
  scripts\mp\maps\mp_harbor\mp_harbor_fx::main();
  scripts\mp\maps\mp_harbor\mp_harbor_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_harbor", "codcaster_compass_map_mp_harbor");
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_tessellationFactor", 30);
  setDvar("r_tessellationCutoffFalloff", 256);
  setDvar("cg_defaultWindAmplitudeScale", 3);
  setDvar("cg_defaultWindFrequencyScale", 3);
  setDvar("cg_defaultWindNoiseScale", 0.5);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread ref_13229("bobbingBoat");
  thread player_exfil_struct();
}

function player_exfil_struct() {
  var_0 = getEnt("clip128x128x8", "targetname");
  var_1 = spawn("script_model", (1943, -2824, 477));
  var_1.angles = (0, 0, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip128x128x8", "targetname");
  var_3 = spawn("script_model", (2071, -2824, 477));
  var_3.angles = (0, 0, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip128x128x8", "targetname");
  var_5 = spawn("script_model", (2199, -2824, 477));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip128x128x8", "targetname");
  var_7 = spawn("script_model", (2327, -2824, 477));
  var_7.angles = (0, 0, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("clip128x128x8", "targetname");
  var_9 = spawn("script_model", (2455, -2824, 477));
  var_9.angles = (0, 0, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
}

function ref_13229(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3.startpos = var_3.origin;
    var_3.startang = var_3.angles;
    thread boatbob(var_3);
    thread boatwobble(var_3);
  }
}

function boatbob(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = randomfloatrange(4, 7);
    var_0.goalpos = var_0.startpos + (randomintrange(-4, 4), randomintrange(-4, 4), randomintrange(-6, 6));
    var_0 moveTo(var_0.goalpos, var_1, var_1 * 0.25, var_1 * 0.25);
    wait var_1;
  }
}

function boatwobble(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = randomfloatrange(4, 6);
    var_0.goalang = var_0.startang + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
    var_0 rotateTo(var_0.goalang, var_1, var_1 * 0.25, var_1 * 0.25);
    wait var_1;
  }
}