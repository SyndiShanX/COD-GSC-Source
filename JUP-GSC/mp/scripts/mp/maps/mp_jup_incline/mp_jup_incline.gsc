/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_incline\mp_jup_incline.gsc
*************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_incline\gen\mp_jup_incline_art;
#using scripts\mp\maps\mp_jup_incline\mp_jup_incline_fx;
#using scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting;
#namespace mp_jup_incline;

function main() {
  scripts\mp\maps\mp_jup_incline\gen\mp_jup_incline_art::main();
  scripts\mp\maps\mp_jup_incline\mp_jup_incline_fx::main();
  scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_incline");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  scripts\cp_mp\utility\game_utility::registersmallmap();
}