/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_piccadilly\mp_piccadilly.gsc
***********************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "england";
  scripts\mp\maps\mp_piccadilly\mp_piccadilly_precache::main();
  scripts\mp\maps\mp_piccadilly\gen\mp_piccadilly_art::main();
  scripts\mp\maps\mp_piccadilly\mp_piccadilly_fx::main();
  scripts\mp\maps\mp_piccadilly\mp_piccadilly_lighting::main();
  scripts\cp_mp\utility\game_utility::ref_12b2c();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.outofboundstriggers[0].origin -= (0, 0, 20);
  scripts\mp\compass::setupminimap("compass_map_mp_piccadilly", "codcaster_compass_map_mp_piccadilly");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  var0 = ref_12333(level);
  level.kill_border_triggers = scripts\engine\utility::array_combine(level.kill_border_triggers, var0);
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("LTMPKRLLNM", 8192);
  setDvar("LTQMSPKRKO", 6);
  setDvar("MROOOROPKL", 10);
  setDvar("MNQKPNLOPT", 1);
  setDvar("NRSOTSLSSO", 1);
  setDvar("scr_ignore_frontline_anchor", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "urban";
  thread play_movie("mp_pic_screens_002");
  thread metal_detectors();
  thread laser_shut_down_button();
  thread ref_12f8e();
  thread ref_121f3();
  thread ref_121f5();
  thread spawnstaticvan();
  scripts\mp\flags::levelflagwait("scriptables_ready");
  wait 6;
  scripts\engine\utility::array_thread(getscriptablearray("scriptable_veh8_civ_lnd_victor40_police_mp_piccadilly", "classname"), &ref_141bd);
  scripts\engine\utility::array_thread(getscriptablearray("scriptable_veh8_civ_lnd_palfa_ambulance_london", "classname"), &ref_141bd);
  thread ref_12f82();
  level.outofboundstime = 2;
}

function play_movie(var0) {
  if(getdvarint("LLQQOPKTKM") == 1) {
    return;
  }

  for(;;) {
    playcinematicforalllooping(var0);
    wait 3;
  }
}

function laser_shut_down_button() {
  var0 = getEnt("big_screen", "targetname");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function metal_detectors() {
  level endon("game_ended");
  var0 = getEnt("audio_metal_detector", "targetname");

  if(isDefined(var0)) {
    for(;;) {
      var0 waittill("trigger", var1);
      playsoundatpos(var1.origin + (0, 0, 80), "emt_metal_detector_beep");
      wait 1.5;
    }

    return;
  }
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

  if(self.classname == "scriptable_veh8_civ_lnd_victor40_police_mp_piccadilly") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_piccadilly_police_lights"), self.wire_think, "tag_origin");
    goto LOC_000000dd;
  }

  if(self.classname == "scriptable_veh8_civ_lnd_palfa_ambulance_london") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_piccadilly_ambulance_lights"), self.wire_think, "tag_origin");
    goto LOC_000000dd;
  }

  return;
}

function spawnstaticvan() {
  level waittill("infil_setup_complete");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "spawnPersistentVan")) {
    return;
  }

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    foreach(var1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "get_all_infils")]]()) {
      if(var1.script_noteworthy != "infil_van_hackney") {
        continue;
      }

      if(var1.name != "alpha") {
        continue;
      }

      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleOrg"] = (1796.56, 883.661, 131.75);
      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleAng"] = (0, 35, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "spawnPersistentVan")]]("infil_van_hackney", "alpha");
      break;
    }

    return;
  }
}

function ref_12f82() {
  while(!istrue(level.doorsetupfinished)) {
    waitframe();
  }

  wait 2;

  foreach(var1 in level.doors) {
    var1 notify("stateChanged");
    var2 = 0;
    var3 = 90;

    if(distancesquared(var1.origin, (214, 745, 132)) < 12) {
      var3 = -110;
    } else if(distancesquared(var1.origin, (854, 1254, 140)) < 12) {
      var3 = 110;
    } else if(distancesquared(var1.origin, (795, 1339, 140)) < 12) {
      var2 = 1;
    } else if(distancesquared(var1.origin, (-116, 1025, 128)) < 12) {
      var3 = 105;
    }

    var1.angles = (var1.angles[0], var1.angles[1] + var3, var1.angles[2]);
    var1.useprompt makeunusable();

    if(isDefined(var1.lockprompt)) {
      var1.lockprompt makeunusable();
    }

    if(var2) {
      var1.clipent delete();
      var1 delete();
    }
  }
}

function ref_12f8e() {
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
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-2783, 94, 208), (0, 8, 0)));

    case "dom":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_secondary", (-831, 1079, 196), (0, 272, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}

function ref_121f3() {
  var0 = getEnt("clip512x512x8", "targetname");
  var1 = spawn("script_model", (-3248, -976, 0));
  var1.angles = (270, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip512x512x8", "targetname");
  var3 = spawn("script_model", (-3248, -1488, 0));
  var3.angles = (270, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("clip512x512x8", "targetname");
  var5 = spawn("script_model", (6384, -9880, 776));
  var5.angles = (0, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("tactical_cover_col", "targetname");
  var7 = spawn("script_model", (-86, -1430, 108));
  var7.angles = (0, 0, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("tactical_cover_col", "targetname");
  var9 = spawn("script_model", (-1132, -52, 142));
  var9.angles = (0, 60, 0);
  var9 clonebrushmodeltoscriptmodel(var8);
  var1 disconnectPaths();
  var3 disconnectPaths();
  waitframe();
  var1 notsolid();
  var3 notsolid();
}

function ref_121f5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var0 = [(859, 1989, 135)];

  foreach(var2 in var0) {
    var3 = spawn("trigger_radius", var2, 0, 300, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var3;
  }
}

function ref_12333() {
  var0 = [];
  var1 = spawn("trigger_radius", (-536, -1072, -108), 0, 24000, 125);
  var0 = var1;
  return var0;
}