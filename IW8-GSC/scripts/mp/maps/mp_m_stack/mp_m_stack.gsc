/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_stack\mp_m_stack.gsc
*****************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_m_stack\mp_m_stack_precache::main();
  scripts\mp\maps\mp_m_stack\gen\mp_m_stack_art::main();
  scripts\mp\maps\mp_m_stack\mp_m_stack_fx::main();
  scripts\mp\maps\mp_m_stack\mp_m_stack_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_stack", "codcaster_compass_map_mp_m_stack");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("TMNTMTQRM", 1);
  setDvar("NPONLLLSPL", 0.3);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 2);
  setDvar("r_useCompressedSunShadow", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
}