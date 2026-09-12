/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_showers\mp_m_showers.gsc
*********************************************************/

function main() {
  scripts\mp\maps\mp_m_showers\mp_m_showers_precache::main();
  scripts\mp\maps\mp_m_showers\gen\mp_m_showers_art::main();
  scripts\mp\maps\mp_m_showers\mp_m_showers_fx::main();
  scripts\mp\maps\mp_m_showers\mp_m_showers_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_showers", "codcaster_compass_map_mp_m_showers");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "urban";
  thread scripts\mp\animation_suite::animationsuite();
}