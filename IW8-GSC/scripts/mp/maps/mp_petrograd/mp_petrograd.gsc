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
  setDvar("NSSMQLPRNT", 0.01);
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
  var0 = getEntArray("bake_shadow_brush", "targetname");

  foreach(var2 in var0) {
    var2 delete();
  }
}

function set_lighting_dvars() {
  setDvar("PKKMTTRQO", 8);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.425);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 4);
  setDvar("QSLRKRNKL", 2);
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
  var0 = getEnt("player32x32x256", "targetname");
  var1 = spawn("script_model", (1620, -1772, 258));
  var1.angles = (351, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEntArray("hardpoint_zone", "targetname");

  foreach(var4 in var2) {
    if(var4.script_label == "9") {
      var4.origin += (0, -2, 0);
    }
  }
}

function battle_tracks_vehicleoccupancyenter() {
  var0 = [];

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
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (1280, -2400, 156), (0, 160, 0)));

    case "dom":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn", (1280, -2400, 156), (0, 160, 0)));

    case "sd":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_sd_spawn_defender", (610, 2640, 176), (0, 278, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}

function ref_121f5() {
  level.outofboundstriggerpatches = [];
  var0 = spawn("trigger_radius", (-1369, -543, 150), 0, 16, 48);
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var0;
  level waittill("game_ended");

  foreach(var0 in level.outofboundstriggerpatches) {
    if(isDefined(var0)) {
      var0 delete();
    }
  }
}