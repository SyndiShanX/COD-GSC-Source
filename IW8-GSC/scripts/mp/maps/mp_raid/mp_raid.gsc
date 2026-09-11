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
  var0 = getEntArray("infil_barrier", "targetname");

  foreach(var2 in var0) {
    var2 hide();
  }

  level waittill("prematch_countdown");
  wait 4;

  foreach(var2 in var0) {
    var2 show();
  }
}

function player_exfil_struct() {
  var0 = getEnt("clip32x32x32", "targetname");
  var1 = spawn("script_model", (-2958, 224, 292));
  var1.angles = (0, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip32x32x32", "targetname");
  var3 = spawn("script_model", (-2958, 256, 292));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("clip128x128x256", "targetname");
  var5 = spawn("script_model", (-732.75, 1859.25, 268.25));
  var5.angles = (0, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("clip32x32x32", "targetname");
  var7 = spawn("script_model", (-2133, 1986, 400.5));
  var7.angles = (0, 0, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("nosight128x128x8", "targetname");
  var9 = spawn("script_model", (-2974, 2202, 304));
  var9.angles = (270, 358, -66);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("clip64x64x8", "targetname");
  var11 = spawn("script_model", (-448, 940, 480));
  var11.angles = (90, 0, 0);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("clip64x64x8", "targetname");
  var13 = spawn("script_model", (-448, 1048, 480));
  var13.angles = (90, 0, 0);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("clip64x64x64", "targetname");
  var15 = spawn("script_model", (-1320, 4035, 400));
  var15.angles = (0, 0, 0);
  var15 clonebrushmodeltoscriptmodel(var14);
  var16 = getEnt("clip64x64x64", "targetname");
  var17 = spawn("script_model", (-1320, 3971, 400));
  var17.angles = (0, 0, 0);
  var17 clonebrushmodeltoscriptmodel(var16);
}

function ref_12f8e() {
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((-2075, 512, 272), 100, 0, 100);
  var0 = getnodesinradius((-2226, 1811, 272), 32, 0, 100);

  foreach(var2 in var0) {
    var2 disconnectnode();
  }

  var4 = [];
  GscBinSkip0(0x2e, var4.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-3392.8, -126.1, 300), (0, 360, 0)));
}