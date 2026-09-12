/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_layover_gw\mp_layover_gw.gsc
***********************************************************/

function main() {
  _start_spawn_modules::keypad_check_levelinput();
  scripts\mp\maps\mp_layover_gw\mp_layover_gw_precache::main();
  scripts\mp\maps\mp_layover_gw\gen\mp_layover_gw_art::main();
  scripts\mp\maps\mp_layover_gw\mp_layover_gw_fx::main();
  scripts\mp\maps\mp_layover_gw\mp_layover_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 10);
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  setDvar("mantle_force_legacy_system", 1);
  level.music_style = "eastern_europe";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_layover_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}