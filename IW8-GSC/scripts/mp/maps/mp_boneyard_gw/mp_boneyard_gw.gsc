/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_boneyard_gw\mp_boneyard_gw.gsc
*************************************************************/

function main() {
  _start_spawn_modules::keypad_check_levelinput();
  scripts\mp\maps\mp_boneyard_gw\mp_boneyard_gw_precache::main();
  scripts\mp\maps\mp_boneyard_gw\gen\mp_boneyard_gw_art::main();
  scripts\mp\maps\mp_boneyard_gw\mp_boneyard_gw_fx::main();
  scripts\mp\maps\mp_boneyard_gw\mp_boneyard_gw_lighting::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid)) {
      setDvar("scr_localeID", 4);
    }

    scripts\mp\gametypes\arm::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("compass_map_mp_boneyard_gw");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  level.g = getEntArray("callout_area", "targetname");
  thread ref_145f0();
  thread ref_12f8e();
}

function ref_145f0() {
  var_0 = getdvarint("gw_gas_circle_size", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("gas_realfar"), (-27045, -11205, 89));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("gas_far"), (-27045, -11205, 89));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("gas_medium"), (-27045, -11205, 89));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("gas_close"), (-27045, -11205, 89));
      break;
  }
}

function ref_12f8e() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "siege":
      if(!isDefined(game["roundsPlayed"]) || game["roundsPlayed"] == 0) {
        break;
      } else {
        GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_gw_spawn_axis_start_mod", (-29384, -17824, -232), (0, 90, 0)));
      }

      break;
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}