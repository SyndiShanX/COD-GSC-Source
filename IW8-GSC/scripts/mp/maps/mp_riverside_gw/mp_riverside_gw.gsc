/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_riverside_gw\mp_riverside_gw.gsc
***************************************************************/

function main() {
  scripts\mp\maps\mp_riverside_gw\mp_riverside_gw_precache::main();
  scripts\mp\maps\mp_riverside_gw\gen\mp_riverside_gw_art::main();
  scripts\mp\maps\mp_riverside_gw\mp_riverside_gw_fx::main();
  scripts\mp\maps\mp_riverside_gw\mp_riverside_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::ref_12B18();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 19);
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_riverside_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  level.music_style = "eastern_europe";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}