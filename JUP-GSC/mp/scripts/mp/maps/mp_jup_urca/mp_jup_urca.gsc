/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_urca\mp_jup_urca.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_urca\gen\mp_jup_urca_art;
#using scripts\mp\maps\mp_jup_urca\mp_jup_urca_fx;
#using scripts\mp\maps\mp_jup_urca\mp_jup_urca_lighting;
#namespace mp_jup_urca;

function main() {
  scripts\mp\maps\mp_jup_urca\gen\mp_jup_urca_art::main();
  scripts\mp\maps\mp_jup_urca\mp_jup_urca_fx::main();
  scripts\mp\maps\mp_jup_urca\mp_jup_urca_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_urca");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 512);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}