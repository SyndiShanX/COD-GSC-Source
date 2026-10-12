/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_elevated\mp_jup_elevated.gsc
***************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_elevated\gen\mp_jup_elevated_art;
#using scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_audio;
#using scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_fx;
#using scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_lighting;
#namespace mp_jup_elevated;

function main() {
  scripts\mp\maps\mp_jup_elevated\gen\mp_jup_elevated_art::main();
  scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_fx::main();
  scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_lighting::main();
  scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_audio::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_elevated");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}