/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_drainage\mp_m_drainage.gsc
***********************************************************/

function main() {
  scripts\mp\maps\mp_m_drainage\mp_m_drainage_precache::main();
  scripts\mp\maps\mp_m_drainage\gen\mp_m_drainage_art::main();
  scripts\mp\maps\mp_m_drainage\mp_m_drainage_fx::main();
  scripts\mp\maps\mp_m_drainage\mp_m_drainage_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_drainage", "codcaster_compass_map_mp_m_drainage");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  setDvar("r_vertexDeformCutOffDist", 5000);
  thread playerzombiejumpmaxholdwarning();
}

function playerzombiejumpmaxholdwarning() {
  if(scripts\mp\utility\game::getgametype() == "arena") {
    level waittill("prematch_countdown");
    scripts\engine\utility::exploder("bombing_run");
    return;
  }
}