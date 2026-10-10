/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw.gsc
********************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\compass;
#using scripts\mp\gametypes\arm;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_resort_gw\gen\mp_jup_resort_gw_art;
#using scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw_fx;
#using scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw_lighting;
#using scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw_precache;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_resort_gw;

function main() {
  scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw_precache::main();
  scripts\mp\maps\mp_jup_resort_gw\gen\mp_jup_resort_gw_art::main();
  scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw_fx::main();
  scripts\mp\maps\mp_jup_resort_gw\mp_jup_resort_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::function_3673befc7dcade8b();

  if(function_a7caa13ebe4c4ba5() || isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      if(getgametype() == "gwtdm") {
        setDvar(@ "hash_6beec004cdf37c0", 188);
      } else {
        setDvar(@ "hash_6beec004cdf37c0", 187);
      }
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
    setDvar(@ "hash_9365c7a237edaa2f", 1);
    level.parachutecancutautodeploy = 1;
    level.parachutecancutparachute = 1;
  }

  scripts\mp\compass::setupminimap("compass_map_mp_jup_resort_gw");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  setDvar(@ "fd_helicopter_altitude_limiter", 4500);
  level.var_56bcdc219d432f80["axis"] = 15;
  level.var_56bcdc219d432f80["allies"] = 15;

  if(istrue(level.supportsai)) {
    scripts\mp\ai_mp_controller::function_c8393014dd7f8ab6();
  }
}