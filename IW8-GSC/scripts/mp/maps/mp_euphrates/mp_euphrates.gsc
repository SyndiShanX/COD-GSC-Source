/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_euphrates\mp_euphrates.gsc
*********************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _startragdollwithvehiclefeature::keypad_check_levelinput();
  _start_spawn_modules::keypad_check_levelinput();
  scripts\mp\maps\mp_euphrates\mp_euphrates_precache::main();
  scripts\mp\maps\mp_euphrates\gen\mp_euphrates_art::main();
  scripts\mp\maps\mp_euphrates\mp_euphrates_fx::main();
  setDvar("PKKMTTRQO", 3.5);
  setDvar("NKLMONNPNN", 512);
  scripts\mp\load::main();
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.5);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 4);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("sm_compressedSunShadowFiltering", 1);
  setDvar("sm_compressedSunShadowFilteringMaxRadius", 4);
  setDvar("MQPQKNPQOK", 3);
  setDvar("MRNRKKOPLN", 3);
  setDvar("OLSKLTPPMR", 0.5);
  thread ref_12f8e();
  thread player_exfil_struct();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_euphrates", "codcaster_compass_map_mp_euphrates");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  thread ref_121f5();
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "sd" || var_0 == "dd") {
    game["defenders"] = "allies";
    game["attackers"] = "axis";
  } else {
    game["attackers"] = "allies";
    game["defenders"] = "axis";
  }

  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  level.modifiedspawnpoints["-2434 1586 -168"]["mp_rugby_spawn_allies_start"]["origin"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["-2434 1586 -168"]["mp_ctf_spawn_allies_start"]["origin"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["-2436 1588 -168"]["mp_koth_spawn_allies_start"]["origin"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["-2432 1592 -168"]["mp_tdm_spawn_allies_start"]["origin"] = (-2260, 1592, -168);
  level.modifiedspawnpoints["-2466 1682 -168"]["mp_rugby_spawn_allies_start"]["origin"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["-2466 1682 -168"]["mp_ctf_spawn_allies_start"]["origin"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["-2468 1684 -168"]["mp_koth_spawn_allies_start"]["origin"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["-2464 1688 -168"]["mp_tdm_spawn_allies_start"]["origin"] = (-2424, 1296, -158);
  level.modifiedspawnpoints["-2370 1634 -168"]["mp_rugby_spawn_allies_start"]["origin"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["-2370 1634 -168"]["mp_ctf_spawn_allies_start"]["origin"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["-2372 1636 -168"]["mp_koth_spawn_allies_start"]["origin"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["-2368 1640 -168"]["mp_tdm_spawn_allies_start"]["origin"] = (-2176, 1448, -168);
  level.modifiedspawnpoints["-2514 1610 -168"]["mp_rugby_spawn_allies_start"]["origin"] = (-2408, 1056, -178);
  level.modifiedspawnpoints["-2514 1610 -168"]["mp_ctf_spawn_allies_start"]["origin"] = (-2408, 1056, -178);
  level.modifiedspawnpoints["-2516 1612 -168"]["mp_koth_spawn_allies_start"]["origin"] = (-2408, 1056, -178);
  level.modifiedspawnpoints["-2512 1616 -168"]["mp_tdm_spawn_allies_start"]["origin"] = (-2408, 1056, -178);
}

function player_exfil_struct() {
  var_0 = spawn("trigger_radius", (-4320, 2176, -160), 0, 576, 576);
  var_0.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
}

function ref_12f8e() {
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
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (2102, -1369, -134), (0, 153, 0)));

    case "dom":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_secondary", (271, 631, 74), (0, 270, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function ref_121f5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var_0 = [(-72, 200, 32), (-4044, 2360, -100)];

  foreach(var_2 in var_0) {
    var_3 = spawn("trigger_radius", var_2, 0, 128, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
    var_3 = spawn("trigger_radius", var_2, 0, 96, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}