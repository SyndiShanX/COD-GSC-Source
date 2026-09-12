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
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("MTRRKPRML", 2);
  setDvar("r_vertexDeformCutOffDist", 5000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_139C6();
  thread ref_139C5("hanging_cord01");
  thread ref_139C5("hanging_cord02");
  thread total_puddle_count("ship01");
  thread carriable_respawn();
  thread ref_121F5();
  thread onplayerconnect();
  thread scripts\mp\animation_suite::animationsuite();
  level.ref_12C49 = 1;
  level.requiredplayercount["allies"] = 4;
  level.requiredplayercount["axis"] = 4;
  thread check_trigger_spawnflags();
}

function ref_121F5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var_0 = [(-2126, -1616, 983), (-2175, -1400, 980), (-1500, -2600, 850)];

  foreach(var_2 in var_0) {
    var_3 = spawn("trigger_radius", var_2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}

function carriable_respawn() {
  var_0 = getEnt("drillAnimatedPivot", "targetname");
  var_1 = getEnt("drillPivot", "script_noteworthy");
  var_2 = getEnt("drillAnimatedPivotSight", "targetname");

  if(isDefined(var_0)) {
    var_0 linkTo(var_1);
    var_2 linkTo(var_1);
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread ref_13892();
    thread ref_13893();
  }
}

function ref_13892() {
  self endon("disconnect");
  level endon("game_ended");
  self.update_tracks_operational_status = 1;
  var_0 = "TAG_EYE";

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.update_tracks_operational_status) {
      playFXOnTag(level._effect["cold_breath_run"], self, var_0);
    }

    wait 2.5 + randomfloat(3);
  }
}

function ref_13893() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getEnt("insideTrigger", "targetname");

  for(;;) {
    if(var_0 istouching(self)) {
      self.update_tracks_operational_status = 0;
    } else {
      self.update_tracks_operational_status = 1;
    }

    wait 1;
  }
}

function ref_139C6() {
  var_0 = getEnt("swayCrate", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3.modelscale = 0.5;
    var_3 linkTo(var_0);
  }

  thread ref_139C8(var_0, 4);
}

function ref_139C5(var_0) {
  var_1 = getEnt(var_0, "targetname");
  thread ref_139C8(var_1, 1.25);
}

function ref_139C8(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_1;

  for(;;) {
    var_3 = 7;
    var_2 *= -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_2);
    var_0 rotateTo(var_0.goalang, var_3, var_3 * 0.45, var_3 * 0.45);
    wait var_3;
    scripts\engine\utility::exploder("left");
    var_2 *= -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_2);
    var_0 rotateTo(var_0.goalang, var_3, var_3 * 0.45, var_3 * 0.45);
    wait var_3;
    scripts\engine\utility::exploder("right");
  }
}

function total_puddle_count(var_0) {
  level waittill("infil_setup_complete");
  var_1 = getEnt("ship01_link", "targetname");
  var_2 = getEntArray("ship02_link", "targetname");
  var_3 = getEnt("shipPivot", "script_noteworthy");

  if(isDefined(var_1)) {
    var_1 linkTo(var_3);
  }

  if(isDefined(var_2) && isDefined(var_3)) {
    foreach(var_5 in var_2) {
      var_5 linkTo(var_3);
    }
  }

  wait 6;
  var_1.ref_132A9 = scripts\engine\utility::spawn_tag_origin();
  var_1.ref_132A9.origin = var_1.origin;
  var_1.ref_132A9.angles = var_1.angles;
  var_1.ref_132A9.targetname = "shipFX";
  var_1.ref_132A9 show();
  var_1.ref_132A9 linkTo(var_1);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_oil_cargo_ship"), var_1.ref_132A9, "tag_origin");
  var_1 playLoopSound("emt_cargo_ship_wake");
}

function check_trigger_spawnflags() {
  level endon("game_ended");
  level waittill("connected", var_0);
  var_1 = 35;
  var_2 = 35;
  var_3 = 50;
  var_4 = [];

  for(var_5 = 1; var_5 < var_1 + 1; var_5++) {
    var_6 = "dx_mpm_rupa_loudspeaker_announcements_" + var_5 + "0";

    if(soundexists(var_6)) {
      var_4 = var_6;
    }
  }

  var_7 = spawn("script_origin", (0, 0, 0));
  thread check_if_frozen();
  var_8 = [];
  GscBinSkip0(0x2e, var_8.size, -1, level);
}

function check_if_frozen() {
  wait 10;
  enablepaspeaker("oilrig_pa");
}