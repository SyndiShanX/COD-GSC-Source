/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_rust\mp_rust.gsc
***********************************************/

function main() {
  _redbuttonused_internal::keypad_check_levelinput();
  _start_rooftop_raid_heli::keypad_check_levelinput();
  scripts\mp\maps\mp_rust\mp_rust_precache::main();
  scripts\mp\maps\mp_rust\gen\mp_rust_art::main();
  scripts\mp\maps\mp_rust\mp_rust_fx::main();
  scripts\mp\maps\mp_rust\mp_rust_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_rust", "codcaster_compass_map_mp_rust");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12B3B();
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread player_exfil_struct();
  battle_tracks_vehicleoccupancyenter(level);
}

function player_exfil_struct() {
  var_0 = getEnt("nosight128x128x8", "targetname");
  var_1 = spawn("script_model", (1394, 1382.5, -167.5));
  var_1.angles = (90, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("nosight128x128x8", "targetname");
  var_3 = spawn("script_model", (1157, 1382.5, -167.5));
  var_3.angles = (90, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("nosight128x128x8", "targetname");
  var_5 = spawn("script_model", (1707.5, 1623, -114.5));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("nosight128x128x8", "targetname");
  var_7 = spawn("script_model", (1707.5, 1711, -114.5));
  var_7.angles = (0, 0, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("nosight128x128x8", "targetname");
  var_9 = spawn("script_model", (1669, 1656, -208.5));
  var_9.angles = (0, 270, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("nosight128x128x8", "targetname");
  var_11 = spawn("script_model", (1727, 1674, -158.5));
  var_11.angles = (0, 0, 37);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("nosight128x128x8", "targetname");
  var_13 = spawn("script_model", (1727, 1648, -156.5));
  var_13.angles = (0, 180, 33);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("nosight128x128x8", "targetname");
  var_15 = spawn("script_model", (1779.5, 1623, -114.5));
  var_15.angles = (0, 0, 90);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("nosight128x128x8", "targetname");
  var_17 = spawn("script_model", (1725, 1662, -50.5));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("player32x32x256", "targetname");
  var_19 = spawn("script_model", (1669, 1595.5, -228.5));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}

function battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "dd":
      level.modifiedspawnpoints["1636 1392"]["mp_dd_spawn_defender_start"]["remove"] = 1;
      level.modifiedspawnpoints["1636 1272"]["mp_dd_spawn_defender_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dd_spawn_defender_start", (1636, 1394, -208), (0, 180, 0)));

    case "sd":
      level.modifiedspawnpoints["1636 1392"]["mp_sd_spawn_defender"]["remove"] = 1;
      level.modifiedspawnpoints["1636 1272"]["mp_sd_spawn_defender"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_sd_spawn_defender", (1636, 1394, -208), (0, 180, 0)));

    case "rugby":
      level.modifiedspawnpoints["1636 1392"]["mp_rugby_spawn_axis_start"]["remove"] = 1;
      level.modifiedspawnpoints["1636 1272"]["mp_rugby_spawn_axis_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_rugby_spawn_axis_start", (1636, 1394, -208), (0, 180, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}