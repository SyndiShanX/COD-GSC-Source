/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_aniyah_tac\mp_aniyah_tac.gsc
***********************************************************/

function main() {
  scripts\mp\maps\mp_aniyah_tac\mp_aniyah_tac_precache::main();
  scripts\mp\maps\mp_aniyah_tac\gen\mp_aniyah_tac_art::main();
  scripts\mp\maps\mp_aniyah_tac\mp_aniyah_tac_fx::main();
  scripts\mp\maps\mp_aniyah_tac\mp_aniyah_tac_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_aniyah_tac", "codcaster_compass_map_mp_aniyah_tac");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread battle_tracks_vehicleoccupancyenter();
  thread player_exfil_struct();
}

function battle_tracks_vehicleoccupancyenter() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "war":
    case "tjugg":
    case "tdef":
    case "sr":
    case "infect":
    case "grnd":
    case "grind":
    case "cranked":
    case "conf":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_axis_start", (5934, -82, 262), (0, 206, 0)));

    case "dom":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_axis_start", (5934, -82, 262), (0, 206, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function player_exfil_struct() {
  var_0 = getEnt("player32x32x256", "targetname");
  var_1 = spawn("script_model", (1652, -706, 604));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player32x32x256", "targetname");
  var_3 = spawn("script_model", (1918, 106, 626));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player256x256x8", "targetname");
  var_5 = spawn("script_model", (1670, -267, 458.5));
  var_5.angles = (270, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = spawn("trigger_radius", (2268, -1961, 360), 0, 800, 800);
  var_6.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
}