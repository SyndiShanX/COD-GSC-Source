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

  setDvar("PKKMTTRQO", 8);
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
    var0 = getEntArray("6v6_blockers", "targetname");

    foreach(var2 in var0) {
      var2 hide();

      if(var2.spawnflags & 1) {
        var2 connectpaths();
        var2 delete();
      }
    }

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

function player_exfil_struct() {
  var0 = getEnt("clip64x64x64", "targetname");
  var1 = spawn("script_model", (712.5, 3364, 21));
  var1.angles = (0, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip64x64x64", "targetname");
  var3 = spawn("script_model", (712.5, 3340, 21));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = spawn("script_model", (-3129, 3548.95, 80));
  var4 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var4.angles = (86.6, 293, -69.3);
  var5 = spawn("script_model", (-3126.25, 3548.3, 77.75));
  var5 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var5.angles = (85.94, 330.58, 148);
  var6 = spawn("script_model", (-3035.2, 3553.25, 80.5));
  var6 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var6.angles = (86.7, 175.2, 88.8);
  var7 = spawn("script_model", (-3026.8, 3713.5, 80.5));
  var7 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var7.angles = (85.9, 141.85, -128.76);
  var8 = spawn("script_model", (-3430.5, 2158.7, 66.25));
  var8 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var8.angles = (86.47, 250.5, 70);
  var9 = spawn("script_model", (-3575, 2158.3, 66.25));
  var9 setModel("debris_corrugated_panels_metal_flat_blue_large");
  var9.angles = (87.8, 306, -56.25);
}

function ref_13892() {
  self endon("disconnect");
  level endon("game_ended");
  self.update_tracks_operational_status = 1;
  var0 = "tag_eye";

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

function little_bird_mg_mp_waitandspawn() {
  if(!isDefined(level.chopper_gunner_assignedtargetmarkers_onnewai)) {
    level.chopper_gunner_assignedtargetmarkers_onnewai = [];
  }

  var0 = [];
  var1 = spawnStruct();
  var1.origin = (-3100, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-3100, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-2600, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-2100, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-2100, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-1600, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-1100, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-600, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-100, 4950, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-1800, 100, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-1300, 100, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-800, 100, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (-300, 300, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (300, 300, 30);
  var1.radius = 500;
  var0 = var1;
  var1 = spawnStruct();
  var1.origin = (300, -200, 30);
  var1.radius = 500;
  var0 = var1;

  foreach(var1 in var0) {
    var3 = getnodesinradius(var1.origin, var1.radius, 0, 1000);

    foreach(var5 in var3) {
      if(!scripts\engine\utility::array_contains(level.chopper_gunner_assignedtargetmarkers_onnewai, var5)) {
        level.chopper_gunner_assignedtargetmarkers_onnewai[level.chopper_gunner_assignedtargetmarkers_onnewai.size] = var5;
      }
    }
  }
}