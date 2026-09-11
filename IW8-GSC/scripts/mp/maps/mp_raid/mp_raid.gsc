/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_raid\mp_raid.gsc
***********************************************/

function main() {
  _start_spawn_modules::keypad_check_levelinput();
  _startragdollwithvehiclefeature::keypad_check_levelinput();
  level.music_style = "eastern_europe";
  scripts\mp\maps\mp_raid\mp_raid_precache::main();
  scripts\mp\maps\mp_raid\gen\mp_raid_art::main();
  scripts\mp\maps\mp_raid\mp_raid_fx::main();
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("PKKMTTRQO", 8);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.3);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 2);
  setDvar("LKOLRONRNQ", 1000);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("NKLMONNPNN", 768);
  setDvar("NOSQLKNSQO", 45);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_raid", "codcaster_compass_map_mp_raid");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "woodland";
  game["axis_outfit"] = "woodland";
  game["allies"] = "SAS";
  game["axis"] = "RUSF";
  thread managegate();
  thread player_exfil_struct();
  thread ref_12f8e();
}

function managegate() {
  level waittill("infil_setup_complete");

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  var_0 = getEntArray("infil_barrier", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  level waittill("prematch_countdown");
  wait 4;

  foreach(var_2 in var_0) {
    var_2 show();
  }
}

function player_exfil_struct() {
  var_0 = getEnt("clip32x32x32", "targetname");
  var_1 = spawn("script_model", (-2958, 224, 292));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip32x32x32", "targetname");
  var_3 = spawn("script_model", (-2958, 256, 292));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("clip128x128x256", "targetname");
  var_5 = spawn("script_model", (-732.75, 1859.25, 268.25));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip32x32x32", "targetname");
  var_7 = spawn("script_model", (-2133, 1986, 400.5));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("nosight128x128x8", "targetname");
  var_9 = spawn("script_model", (-2974, 2202, 304));
  var_9.angles = (270, 358, -66);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("clip64x64x8", "targetname");
  var_11 = spawn("script_model", (-448, 940, 480));
  var_11.angles = (90, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("clip64x64x8", "targetname");
  var_13 = spawn("script_model", (-448, 1048, 480));
  var_13.angles = (90, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("clip64x64x64", "targetname");
  var_15 = spawn("script_model", (-1320, 4035, 400));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("clip64x64x64", "targetname");
  var_17 = spawn("script_model", (-1320, 3971, 400));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
}

function ref_12f8e() {
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((-2075, 512, 272), 100, 0, 100);
  var_0 = getnodesinradius((-2226, 1811, 272), 32, 0, 100);

  foreach(var_2 in var_0) {
    var_2 disconnectnode();
  }

  var_4 = [];
  GscBinSkip0(0x2e, var_4.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-3392.8, -126.1, 300), (0, 360, 0)));
}