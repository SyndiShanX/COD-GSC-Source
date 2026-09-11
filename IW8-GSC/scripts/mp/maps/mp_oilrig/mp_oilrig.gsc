/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_oilrig\mp_oilrig.gsc
***************************************************/

function main() {
  _start_spawn_modules::keypad_check_levelinput();
  level.music_style = "eastern_europe";
  scripts\mp\maps\mp_oilrig\mp_oilrig_precache::main();
  scripts\mp\maps\mp_oilrig\gen\mp_oilrig_art::main();
  scripts\mp\maps\mp_oilrig\mp_oilrig_fx::main();
  scripts\mp\maps\mp_oilrig\mp_oilrig_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level.music_style = "england";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_oilrig", "codcaster_compass_map_mp_oilrig");
  setDvar("PKKMTTRQO", 8);
  setDvar("MTRRKPRML", 2);
  setDvar("LTMPKRLLNM", 5000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_139c6();
  thread ref_139c5("hanging_cord01");
  thread ref_139c5("hanging_cord02");
  thread total_puddle_count("ship01");
  thread carriable_respawn();
  thread ref_121f5();
  thread onplayerconnect();
  thread scripts\mp\animation_suite::animationsuite();
  level.ref_12c49 = 1;
  level.requiredplayercount["allies"] = 4;
  level.requiredplayercount["axis"] = 4;
  thread check_trigger_spawnflags();
}

function ref_121f5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var0 = [(-2126, -1616, 983), (-2175, -1400, 980), (-1500, -2600, 850)];

  foreach(var2 in var0) {
    var3 = spawn("trigger_radius", var2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var3;
  }
}

function carriable_respawn() {
  var0 = getEnt("drillAnimatedPivot", "targetname");
  var1 = getEnt("drillPivot", "script_noteworthy");
  var2 = getEnt("drillAnimatedPivotSight", "targetname");

  if(isDefined(var0)) {
    var0 linkTo(var1);
    var2 linkTo(var1);
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    thread ref_13892();
    thread ref_13893();
  }
}

function ref_13892() {
  self endon("disconnect");
  level endon("game_ended");
  self.update_tracks_operational_status = 1;
  var0 = "TAG_EYE";

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.update_tracks_operational_status) {
      playFXOnTag(level._effect["cold_breath_run"], self, var0);
    }

    wait 2.5 + randomfloat(3);
  }
}

function ref_13893() {
  self endon("disconnect");
  level endon("game_ended");
  var0 = getEnt("insideTrigger", "targetname");

  for(;;) {
    if(var0 istouching(self)) {
      self.update_tracks_operational_status = 0;
    } else {
      self.update_tracks_operational_status = 1;
    }

    wait 1;
  }
}

function ref_139c6() {
  var0 = getEnt("swayCrate", "targetname");
  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    var3.modelscale = 0.5;
    var3 linkTo(var0);
  }

  thread ref_139c8(var0, 4);
}

function ref_139c5(var0) {
  var1 = getEnt(var0, "targetname");
  thread ref_139c8(var1, 1.25);
}

function ref_139c8(var0, var1) {
  level endon("game_ended");
  var2 = var1;

  for(;;) {
    var3 = 7;
    var2 *= -1;
    var0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var2);
    var0 rotateTo(var0.goalang, var3, var3 * 0.45, var3 * 0.45);
    wait var3;
    scripts\engine\utility::exploder("left");
    var2 *= -1;
    var0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var2);
    var0 rotateTo(var0.goalang, var3, var3 * 0.45, var3 * 0.45);
    wait var3;
    scripts\engine\utility::exploder("right");
  }
}

function total_puddle_count(var0) {
  level waittill("infil_setup_complete");
  var1 = getEnt("ship01_link", "targetname");
  var2 = getEntArray("ship02_link", "targetname");
  var3 = getEnt("shipPivot", "script_noteworthy");

  if(isDefined(var1)) {
    var1 linkTo(var3);
  }

  if(isDefined(var2) && isDefined(var3)) {
    foreach(var5 in var2) {
      var5 linkTo(var3);
    }
  }

  wait 6;
  var1.ref_132a9 = scripts\engine\utility::spawn_tag_origin();
  var1.ref_132a9.origin = var1.origin;
  var1.ref_132a9.angles = var1.angles;
  var1.ref_132a9.targetname = "shipFX";
  var1.ref_132a9 show();
  var1.ref_132a9 linkTo(var1);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_oil_cargo_ship"), var1.ref_132a9, "tag_origin");
  var1 playLoopSound("emt_cargo_ship_wake");
}

function check_trigger_spawnflags() {
  level endon("game_ended");
  level waittill("connected", var0);
  var1 = 35;
  var2 = 35;
  var3 = 50;
  var4 = [];

  for(var5 = 1; var5 < var1 + 1; var5++) {
    var6 = "dx_mpm_rupa_loudspeaker_announcements_" + var5 + "0";

    if(soundexists(var6)) {
      var4 = var6;
    }
  }

  var7 = spawn("script_origin", (0, 0, 0));
  thread check_if_frozen();
  var8 = [];
  GscBinSkip0(0x2e, var8.size, -1, level);
}

function check_if_frozen() {
  wait 10;
  enablepaspeaker("oilrig_pa");
}