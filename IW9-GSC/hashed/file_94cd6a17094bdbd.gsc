/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_94cd6a17094bdbd.gsc
***********************************************/

main() {
  _id_192702EE5B99E604::main();
  _id_369511E2EBB2DAA6::main();
  _id_0C440494903971CC::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_mercado");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}