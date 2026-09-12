/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_petrograd\mp_petrograd.gsc
*********************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "eastern_europe";
  scripts\mp\maps\mp_petrograd\mp_petrograd_precache::main();
  scripts\mp\maps\mp_petrograd\gen\mp_petrograd_art::main();
  scripts\mp\maps\mp_petrograd\mp_petrograd_fx::main();
  scripts\mp\maps\mp_petrograd\mp_petrograd_lighting::main();
  scripts\cp_mp\utility\game_utility::ref_12b2c();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_petrograd", "codcaster_compass_map_mp_petrograd");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "urban";
  battle_tracks_vehicleoccupancyenter(level);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  thread set_lighting_dvars();
  thread hide_multiple_brush();
  thread scripts\mp\destructible::rockable_cars_init();
  thread managegate();
  thread player_exfil_struct();
  thread ref_121f5();
  scripts\mp\flags::levelflagwait("scriptables_ready");
  wait 7.5;
  scripts\engine\utility::array_thread(getscriptablearray("scriptable_veh8_civ_lnd_palfa_ambulance_russia", "classname"), &ref_141bd);
  scripts\engine\utility::array_thread(getscriptablearray("scriptable_veh8_civ_lnd_skilo_rus_police", "classname"), &ref_141bd);
}

function hide_multiple_brush() {
  var_0 = getEntArray("bake_shadow_brush", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

function set_lighting_dvars() {
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.425);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 4);
  setDvar("r_compressedSunShadowFiltering", 2);
}

function ref_141bd() {
  level endon("game_ended");
  wait randomfloat(2);

  if(self getscriptablehaspart("lights_controller")) {
    if(self getscriptableparthasstate("lights_controller", "siren_off")) {
      self setscriptablepartstate("lights_controller", "siren_off");
    }
  }

  self.wire_think = scripts\engine\utility::spawn_tag_origin();
  self.wire_think.origin = self gettagorigin("tag_body_animate");
  self.wire_think.angles = self gettagangles("tag_body_animate");
  self.wire_think show();
  self.wire_think linkTo(self, "tag_body_animate");
  waitframe();

  if(self.classname == "scriptable_veh8_civ_lnd_palfa_ambulance_russia") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_petrograd_ambulance_lights"), self.wire_think, "tag_origin");
    goto LOC_000000dd;
  }

  if(self.classname == "scriptable_veh8_civ_lnd_skilo_rus_police") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_petrograd_skilo_police_lights"), self.wire_think, "tag_origin");
    goto LOC_000000dd;
  }

  return;
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
  var_0 = getEnt("player32x32x256", "targetname");
  var_1 = spawn("script_model", (1620, -1772, 258));
  var_1.angles = (351, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEntArray("hardpoint_zone", "targetname");

  foreach(var_4 in var_2) {
    if(var_4.script_label == "9") {
      var_4.origin += (0, -2, 0);
    }
  }
}

function battle_tracks_vehicleoccupancyenter() {
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
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (1280, -2400, 156), (0, 160, 0)));

    case "dom":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn", (1280, -2400, 156), (0, 160, 0)));

    case "sd":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_sd_spawn_defender", (610, 2640, 176), (0, 278, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function ref_121f5() {
  level.outofboundstriggerpatches = [];
  var_0 = spawn("trigger_radius", (-1369, -543, 150), 0, 16, 48);
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_0;
  level waittill("game_ended");

  foreach(var_0 in level.outofboundstriggerpatches) {
    if(isDefined(var_0)) {
      var_0 delete();
    }
  }
}