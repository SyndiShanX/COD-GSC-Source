/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_fork\mp_m_fork.gsc
***************************************************/

function main() {
  scripts\mp\maps\mp_m_fork\mp_m_fork_precache::main();
  scripts\mp\maps\mp_m_fork\gen\mp_m_fork_art::main();
  scripts\mp\maps\mp_m_fork\mp_m_fork_fx::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_fork", "codcaster_compass_map_mp_m_fork");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_spotDistCull", 800);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.3);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_roundRobinPrioritySpotShadows", 6);
  setDvar("r_compressedSunShadowFiltering", 2);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}