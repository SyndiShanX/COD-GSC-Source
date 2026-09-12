/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_promenade_gw\mp_promenade_gw.gsc
***************************************************************/

function main() {
  scripts\mp\maps\mp_promenade_gw\mp_promenade_gw_precache::main();
  scripts\mp\maps\mp_promenade_gw\gen\mp_promenade_gw_art::main();
  scripts\mp\maps\mp_promenade_gw\mp_promenade_gw_fx::main();
  scripts\mp\maps\mp_promenade_gw\mp_promenade_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 18);
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_promenade_gw");
  setDvar("r_umbraMinObjectContribution", 8);
  level.music_style = "eastern_europe";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_12f8e();
}

function ref_12f8e() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_allies_start_mod", (-10592, -19208, -360), (0, 216, 0)));
      }

      break;
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}