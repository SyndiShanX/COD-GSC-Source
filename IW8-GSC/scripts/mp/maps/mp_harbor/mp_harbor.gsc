/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_harbor\mp_harbor.gsc
***************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  scripts\mp\maps\mp_harbor\mp_harbor_precache::main();
  scripts\mp\maps\mp_harbor\gen\mp_harbor_art::main();
  scripts\mp\maps\mp_harbor\mp_harbor_fx::main();
  scripts\mp\maps\mp_harbor\mp_harbor_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level thread scripts\engine\scriptable_door::system_init();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_harbor", "codcaster_compass_map_mp_harbor");
  setDvar("NKLMONNPNN", 512);
  setDvar("PKKMTTRQO", 8);
  setDvar("NOSQLKNSQO", 30);
  setDvar("TSPOQPTMS", 256);
  setDvar("MQPQKNPQOK", 3);
  setDvar("MRNRKKOPLN", 3);
  setDvar("OLSKLTPPMR", 0.5);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread ref_13229("bobbingBoat");
  thread player_exfil_struct();
}

function player_exfil_struct() {
  var0 = getEnt("clip128x128x8", "targetname");
  var1 = spawn("script_model", (1943, -2824, 477));
  var1.angles = (0, 0, 90);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip128x128x8", "targetname");
  var3 = spawn("script_model", (2071, -2824, 477));
  var3.angles = (0, 0, 90);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("clip128x128x8", "targetname");
  var5 = spawn("script_model", (2199, -2824, 477));
  var5.angles = (0, 0, 90);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("clip128x128x8", "targetname");
  var7 = spawn("script_model", (2327, -2824, 477));
  var7.angles = (0, 0, 90);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("clip128x128x8", "targetname");
  var9 = spawn("script_model", (2455, -2824, 477));
  var9.angles = (0, 0, 90);
  var9 clonebrushmodeltoscriptmodel(var8);
}

function ref_13229(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3.startpos = var3.origin;
    var3.startang = var3.angles;
    thread boatbob(var3);
    thread boatwobble(var3);
  }
}

function boatbob(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = randomfloatrange(4, 7);
    var0.goalpos = var0.startpos + (randomintrange(-4, 4), randomintrange(-4, 4), randomintrange(-6, 6));
    var0 moveTo(var0.goalpos, var1, var1 * 0.25, var1 * 0.25);
    wait var1;
  }
}

function boatwobble(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = randomfloatrange(4, 6);
    var0.goalang = var0.startang + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
    var0 rotateTo(var0.goalang, var1, var1 * 0.25, var1 * 0.25);
    wait var1;
  }
}