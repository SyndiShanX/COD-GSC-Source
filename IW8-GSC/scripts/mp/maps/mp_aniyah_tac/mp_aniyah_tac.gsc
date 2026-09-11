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
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread battle_tracks_vehicleoccupancyenter();
  thread player_exfil_struct();
}

function battle_tracks_vehicleoccupancyenter() {
  var0 = [];

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
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_axis_start", (5934, -82, 262), (0, 206, 0)));

    case "dom":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_axis_start", (5934, -82, 262), (0, 206, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}

function player_exfil_struct() {
  var0 = getEnt("player32x32x256", "targetname");
  var1 = spawn("script_model", (1652, -706, 604));
  var1.angles = (0, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("player32x32x256", "targetname");
  var3 = spawn("script_model", (1918, 106, 626));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("player256x256x8", "targetname");
  var5 = spawn("script_model", (1670, -267, 458.5));
  var5.angles = (270, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = spawn("trigger_radius", (2268, -1961, 360), 0, 800, 800);
  var6.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
}