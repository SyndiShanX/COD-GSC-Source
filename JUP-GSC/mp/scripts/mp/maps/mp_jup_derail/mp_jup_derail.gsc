/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_derail\mp_jup_derail.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_derail\gen\mp_jup_derail_art;
#using scripts\mp\maps\mp_jup_derail\mp_jup_derail_fx;
#using scripts\mp\maps\mp_jup_derail\mp_jup_derail_lighting;
#namespace mp_jup_derail;

function main() {
  scripts\mp\maps\mp_jup_derail\gen\mp_jup_derail_art::main();
  scripts\mp\maps\mp_jup_derail\mp_jup_derail_fx::main();
  scripts\mp\maps\mp_jup_derail\mp_jup_derail_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_derail");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.ttlos_suppressasserts = 1;
}