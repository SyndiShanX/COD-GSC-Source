/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_malyshev\mp_malyshev.gsc
*******************************************************/

function main() {
  scripts\mp\maps\mp_malyshev\mp_malyshev_precache::main();
  scripts\mp\maps\mp_malyshev\gen\mp_malyshev_art::main();
  scripts\mp\maps\mp_malyshev\mp_malyshev_fx::main();
  scripts\mp\maps\mp_malyshev\mp_malyshev_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");

  if(istrue(level.ref_11ad3)) {
    scripts\mp\compass::setupminimap("compass_map_mp_malyshev_10v10", "codcaster_compass_map_mp_malyshev_10v10");
  } else {
    scripts\mp\compass::setupminimap("compass_map_mp_malyshev", "codcaster_compass_map_mp_malyshev");
  }

  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread onplayerconnect();
  thread player_exfil_struct();
  level.music_style = "eastern_europe";

  if(getdvarint("scr_map_use10v10_objectives", 0) == 0) {
    scripts\cp_mp\utility\game_utility::ref_12b25();
    thread little_bird_mg_mp_waitandspawn();
  }

  if(scripts\mp\spawnlogic::generatinglosdata()) {
    var_0 = getEntArray("6v6_blockers", "targetname");

    foreach(var_2 in var_0) {
      var_2 hide();

      if(var_2.spawnflags & 1) {
        var_2 connectpaths();
        var_2 delete();
      }
    }

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

function player_exfil_struct() {
  var_0 = getEnt("clip64x64x64", "targetname");
  var_1 = spawn("script_model", (712.5, 3364, 21));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip64x64x64", "targetname");
  var_3 = spawn("script_model", (712.5, 3340, 21));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (-3129, 3548.95, 80));
  var_4 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var_4.angles = (86.6, 293, -69.3);
  var_5 = spawn("script_model", (-3126.25, 3548.3, 77.75));
  var_5 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var_5.angles = (85.94, 330.58, 148);
  var_6 = spawn("script_model", (-3035.2, 3553.25, 80.5));
  var_6 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var_6.angles = (86.7, 175.2, 88.8);
  var_7 = spawn("script_model", (-3026.8, 3713.5, 80.5));
  var_7 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var_7.angles = (85.9, 141.85, -128.76);
  var_8 = spawn("script_model", (-3430.5, 2158.7, 66.25));
  var_8 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var_8.angles = (86.47, 250.5, 70);
  var_9 = spawn("script_model", (-3575, 2158.3, 66.25));
  var_9 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var_9.angles = (87.8, 306, -56.25);
}

function ref_13892() {
  self endon("disconnect");
  level endon("game_ended");
  self.update_tracks_operational_status = 1;
  var_0 = "tag_eye";

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

function little_bird_mg_mp_waitandspawn() {
  if(!isDefined(level.chopper_gunner_assignedtargetmarkers_onnewai)) {
    level.chopper_gunner_assignedtargetmarkers_onnewai = [];
  }

  var_0 = [];
  var_1 = spawnStruct();
  var_1.origin = (-3100, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-3100, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-2600, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-2100, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-2100, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1600, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1100, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-600, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-100, 4950, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1800, 100, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-1300, 100, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-800, 100, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (-300, 300, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (300, 300, 30);
  var_1.radius = 500;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.origin = (300, -200, 30);
  var_1.radius = 500;
  var_0 = var_1;

  foreach(var_1 in var_0) {
    var_3 = getnodesinradius(var_1.origin, var_1.radius, 0, 1000);

    foreach(var_5 in var_3) {
      if(!scripts\engine\utility::array_contains(level.chopper_gunner_assignedtargetmarkers_onnewai, var_5)) {
        level.chopper_gunner_assignedtargetmarkers_onnewai[level.chopper_gunner_assignedtargetmarkers_onnewai.size] = var_5;
      }
    }
  }
}