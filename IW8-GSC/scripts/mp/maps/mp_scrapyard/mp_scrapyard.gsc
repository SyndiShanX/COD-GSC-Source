/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_scrapyard\mp_scrapyard.gsc
*********************************************************/

function main() {
  scripts\mp\maps\mp_scrapyard\mp_scrapyard_precache::main();
  scripts\mp\maps\mp_scrapyard\gen\mp_scrapyard_art::main();
  scripts\mp\maps\mp_scrapyard\mp_scrapyard_fx::main();
  scripts\mp\maps\mp_scrapyard\mp_scrapyard_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::ref_12b18();
  setDvar("mantle_force_legacy_system", 1);
  level.music_style = "eastern_europe";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_scrapyard", "codcaster_compass_map_mp_scrapyard");
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread player_exfil_struct();
  thread scripts\mp\animation_suite::animationsuite();
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((-26944, -10944, -19), 100, 0, 100);
}

function player_exfil_struct() {
  var_0 = getEnt("clip64x64x256", "targetname");
  var_1 = spawn("script_model", (-25082, -12290, 220));
  var_1.angles = (270, 192, -177);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player256x256x8", "targetname");
  var_3 = spawn("script_model", (-26720, -10806, 180));
  var_3.angles = (0, 15, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
}