/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw.gsc
****************************************************************/

#using script_1d1428a3b7b402b0;
#using script_248ec5040062d3ce;
#using script_261f1b574c15eab1;
#using script_2d3fead1b9e1d7e5;
#using script_2d4b9c58ed0e3d91;
#using script_36967ce8ee2ea745;
#using script_3a535b44f9ecc6df;
#using script_49314540c657d352;
#using script_66e0e331f9783820;
#using script_69a61780e1cc21a9;
#using script_7abaa04d5f9fc22e;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_st_c_gw\gen\mp_jup_st_c_gw_art;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_create_script;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_fx;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_lighting;
#namespace mp_jup_st_c_gw;

function main() {
  scripts\mp\maps\mp_jup_st_c_gw\gen\mp_jup_st_c_gw_art::main();
  scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_fx::main();
  scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_lighting::main();
  initvehicles();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::function_3673befc7dcade8b();

  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  }

  setDvar(@ "hash_6beec004cdf37c0", 141);
  scripts\mp\compass::setupminimap("compass_map_mp_jup_st_c_gw");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "hash_9365c7a237edaa2f", 1);
  scripts\common\create_script_utility::initialize_create_script();
  level thread scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_create_script::main();
  level.parachutecancutautodeploy = 1;
  level.parachutecancutparachute = 1;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}

function initvehicles() {
  level.var_1b4da6b781c9dfbd = 1;
  namespace_8db7d778efdc3d65::main();
  namespace_15896d40cab0d429::main();
  namespace_a8c01726524388f5::main();
  namespace_d8c2d739478db8bb::main();
  namespace_a8b2611e1c2c0f9c::main();
  namespace_65ad5249b19d5d41::main();
  namespace_9972b4aee3d673ca::main();
  namespace_a5c3c313b4f6886a::main();
  namespace_3568ab3cfd523b38::main();
  namespace_405c71940c7ec9ea::main();
  namespace_8624e3257d13b029::main();
}