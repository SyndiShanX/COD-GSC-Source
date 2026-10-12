/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_st_c_gw_wz\mp_jup_st_c_gw_wz.gsc
*******************************************************************/

#using script_2165d661d946d128;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\arm;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_st_c_gw\gen\mp_jup_st_c_gw_art;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_create_script;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_fx;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#namespace mp_jup_st_c_gw_wz;

function main() {
  scripts\mp\maps\mp_jup_st_c_gw\gen\mp_jup_st_c_gw_art::main();
  scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_fx::main();
  scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_lighting::main();
  namespace_a9afa590a6465da6::function_637a32c2ae8e99c2();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::function_3673befc7dcade8b();

  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  }

  if(function_a7caa13ebe4c4ba5() || isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      if(getgametype() == "gwtdm") {
        setDvar(@ "hash_6beec004cdf37c0", 142);
      } else {
        setDvar(@ "hash_6beec004cdf37c0", 141);
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

  allvolumes = getnoentvolumearray("noent_volume_minimap", "classname");

  foreach(volume in allvolumes) {
    volume delete();
  }

  scripts\mp\compass::setupminimap("compass_map_mp_jup_st_c_gw");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  setDvar(@ "hash_9365c7a237edaa2f", 1);
  scripts\common\create_script_utility::initialize_create_script();
  level thread scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_create_script::main();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  setDvar(@ "fd_helicopter_altitude_limiter", 3500);
}