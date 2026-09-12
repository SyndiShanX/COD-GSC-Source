/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_shipment\mp_shipment.gsc
*******************************************************/

function main() {
  _start_rooftop_raid_heli::keypad_check_levelinput();
  level.music_style = "england";
  scripts\mp\maps\mp_shipment\mp_shipment_precache::main();
  scripts\mp\maps\mp_shipment\gen\mp_shipment_art::main();
  scripts\mp\maps\mp_shipment\mp_shipment_fx::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_shipment", "codcaster_compass_map_mp_shipment");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  var_0 = ref_132aa(level);
  level.kill_border_triggers = scripts\engine\utility::array_combine(level.kill_border_triggers, var_0);
  scripts\cp_mp\utility\game_utility::ref_12b3b();
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 0.32);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 6);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.usetdmspawns = 1;
  level.binoculars_clearuidata = 1;

  if(getdvarint("scr_shipment_spawnmove_enable", 0) == 1) {
    thread binoculars_addtolosqueue();
  }

  battle_tracks_vehicleoccupancyenter(level);
  level.loadoutdefaultfiresalediscount = 1;
  level.ref_133d1 = 1;
}

function binoculars_addtolosqueue() {
  wait 1;

  if(level.teambased) {
    scripts\mp\spawnlogic::setactivespawnlogic("Shipment", "Crit_Default");
    return;
  }
}

function battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "tjugg":
    case "cranked":
    case "infect":
    case "tdef":
    case "grnd":
    case "grind":
    case "conf":
    case "war":
    case "sr":
      level.modifiedspawnpoints["-112 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-39 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["184 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["312 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-552 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-744 2608"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-864 2616"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 2616"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-528 1408"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 1416"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-784 1360"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 1368"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-144 1400"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-64 1352"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["64 1352"]["mp_tdm_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-296 1368"]["mp_tdm_spawn"]["remove"] = 1;

      if(getdvarint("scr_shipment_spawnmove_enable", 0) == 1) {
        level.modifiedspawnpoints["-224 1984"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-56 1992"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-336 2096"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-336 2216"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-424 1592"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-256 1592"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-824 1920"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-824 2056"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-264 2408"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["-408 2408"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["144 2080"]["mp_tdm_spawn_secondary"]["remove"] = 1;
        level.modifiedspawnpoints["136 1912"]["mp_tdm_spawn_secondary"]["remove"] = 1;
      }

      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (-112, 2544, 40), (0, 270, 0)));

    case "dom":
      level.modifiedspawnpoints["-112 2608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-462608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["184 2608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["312 2608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-552 2608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 2608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-744 2608"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-864 2616"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 2616"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-528 1408"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 1416"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-784 1360"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 1368"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-144 1400"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-64 1352"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["64 1352"]["mp_dom_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-296 1368"]["mp_dom_spawn"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn", (-112, 2544, 40), (0, 270, 0)));

    case "ctf":
      level.modifiedspawnpoints["-112 2608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-352608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["184 2608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["312 2608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-552 2608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 2608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-744 2608"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-864 2616"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 2616"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-528 1408"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 1416"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-784 1360"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 1368"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-144 1400"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-64 1352"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["64 1352"]["mp_ctf_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-296 1368"]["mp_ctf_spawn"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_ctf_spawn", (-112, 2544, 40), (0, 270, 0)));

    case "koth":
    case "hq":
      level.modifiedspawnpoints["-112 2608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-392608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["184 2608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["312 2608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-552 2608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 2608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-744 2608"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-864 2616"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-984 2616"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-528 1408"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-656 1416"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-784 1360"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-952 1368"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-144 1400"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-64 1352"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["64 1352"]["mp_koth_spawn"]["remove"] = 1;
      level.modifiedspawnpoints["-296 1368"]["mp_koth_spawn"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_koth_spawn", (-112, 2544, 40), (0, 270, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function ref_132aa() {
  var_0 = [];
  var_1 = spawn("trigger_radius", (5704, 1456, -176), 0, 24000, 25);
  var_0 = var_1;
  return var_0;
}