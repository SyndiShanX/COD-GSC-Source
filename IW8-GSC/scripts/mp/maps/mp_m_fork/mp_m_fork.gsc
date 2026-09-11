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
  setDvar("PKKMTTRQO", 8);
  setDvar("LKOLRONRNQ", 800);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.3);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 1);
  setDvar("MROOOROPKL", 6);
  setDvar("QSLRKRNKL", 2);
  setDvar("MNQKPNLOPT", 1);
  setDvar("NRSOTSLSSO", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}