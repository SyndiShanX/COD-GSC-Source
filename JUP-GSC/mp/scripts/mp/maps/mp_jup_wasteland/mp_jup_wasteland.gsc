/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland.gsc
********************************************************************/

#using scripts\common\basic_wind;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_wasteland\gen\mp_jup_wasteland_art;
#using scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland_fx;
#using scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland_lighting;
#namespace mp_jup_wasteland;

function main() {
  scripts\mp\maps\mp_jup_wasteland\gen\mp_jup_wasteland_art::main();
  scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland_fx::main();
  scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_wasteland");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 512);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}