/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_king\mp_m_king.gsc
***************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_m_king\mp_m_king_precache::main();
  scripts\mp\maps\mp_m_king\gen\mp_m_king_art::main();
  scripts\mp\maps\mp_m_king\mp_m_king_fx::main();
  scripts\mp\maps\mp_m_king\mp_m_king_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_king", "codcaster_compass_map_mp_m_king");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("mantle_edge_ledge_check_rise_amount", 15);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread ref_121f4();
}

function ref_121f4() {
  var_0 = spawn("script_model", (0, 0, 8));
  var_0 setModel("mp_m_king_shotblocker");
  var_0.angles = (0, 180, 0);
}