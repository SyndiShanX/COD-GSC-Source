/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_hydro\mp_jup_hydro.gsc
*********************************************************/

#using scripts\common\callbacks;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#namespace mp_jup_hydro;

function main() {
  level.var_b017944f02bb5e97 = 1;
  scripts\mp\compass::setupminimap("compass_map_mp_jup_hydro");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  scripts\cp_mp\utility\game_utility::function_35f5b4e643757db7();
  scripts\mp\load::main();
}