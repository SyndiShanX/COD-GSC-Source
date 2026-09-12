/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_broadcast2\mp_broadcast2.gsc
***********************************************************/

function main() {
  scripts\mp\maps\mp_broadcast2\mp_broadcast2_precache::main();
  scripts\mp\maps\mp_broadcast2\gen\mp_broadcast2_art::main();
  scripts\mp\maps\mp_broadcast2\mp_broadcast2_fx::main();
  scripts\mp\maps\mp_broadcast2\mp_broadcast2_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::ref_12B18();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_broadcast2", "codcaster_compass_map_mp_broadcast2");
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  thread scripts\mp\animation_suite::animationsuite();
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((12590.3, 17293.2, 330.066), 250, 0, 100);
}