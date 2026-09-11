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
  scripts\cp_mp\utility\game_utility::ref_12b3b();
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread player_exfil_struct();
  battle_tracks_vehicleoccupancyenter(level);
}

function player_exfil_struct() {
  var0 = getEnt("nosight128x128x8", "targetname");
  var1 = spawn("script_model", (1394, 1382.5, -167.5));
  var1.angles = (90, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("nosight128x128x8", "targetname");
  var3 = spawn("script_model", (1157, 1382.5, -167.5));
  var3.angles = (90, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("nosight128x128x8", "targetname");
  var5 = spawn("script_model", (1707.5, 1623, -114.5));
  var5.angles = (0, 0, 90);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("nosight128x128x8", "targetname");
  var7 = spawn("script_model", (1707.5, 1711, -114.5));
  var7.angles = (0, 0, 90);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("nosight128x128x8", "targetname");
  var9 = spawn("script_model", (1669, 1656, -208.5));
  var9.angles = (0, 270, 90);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("nosight128x128x8", "targetname");
  var11 = spawn("script_model", (1727, 1674, -158.5));
  var11.angles = (0, 0, 37);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("nosight128x128x8", "targetname");
  var13 = spawn("script_model", (1727, 1648, -156.5));
  var13.angles = (0, 180, 33);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("nosight128x128x8", "targetname");
  var15 = spawn("script_model", (1779.5, 1623, -114.5));
  var15.angles = (0, 0, 90);
  var15 clonebrushmodeltoscriptmodel(var14);
  var16 = getEnt("nosight128x128x8", "targetname");
  var17 = spawn("script_model", (1725, 1662, -50.5));
  var17.angles = (0, 0, 0);
  var17 clonebrushmodeltoscriptmodel(var16);
  var18 = getEnt("player32x32x256", "targetname");
  var19 = spawn("script_model", (1669, 1595.5, -228.5));
  var19.angles = (0, 0, 0);
  var19 clonebrushmodeltoscriptmodel(var18);
}

function battle_tracks_vehicleoccupancyenter() {
  var0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "dd":
      level.modifiedspawnpoints["1636 1392"]["mp_dd_spawn_defender_start"]["remove"] = 1;
      level.modifiedspawnpoints["1636 1272"]["mp_dd_spawn_defender_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dd_spawn_defender_start", (1636, 1394, -208), (0, 180, 0)));

    case "sd":
      level.modifiedspawnpoints["1636 1392"]["mp_sd_spawn_defender"]["remove"] = 1;
      level.modifiedspawnpoints["1636 1272"]["mp_sd_spawn_defender"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_sd_spawn_defender", (1636, 1394, -208), (0, 180, 0)));

    case "rugby":
      level.modifiedspawnpoints["1636 1392"]["mp_rugby_spawn_axis_start"]["remove"] = 1;
      level.modifiedspawnpoints["1636 1272"]["mp_rugby_spawn_axis_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_rugby_spawn_axis_start", (1636, 1394, -208), (0, 180, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}