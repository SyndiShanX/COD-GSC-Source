/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hackney_yard\mp_hackney_yard.gsc
***************************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "england";
  scripts\mp\maps\mp_hackney_yard\mp_hackney_yard_precache::main();
  scripts\mp\maps\mp_hackney_yard\gen\mp_hackney_yard_art::main();
  scripts\mp\maps\mp_hackney_yard\mp_hackney_yard_fx::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("nvg_base_mp_hackney_yard");
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_hackney_yard", "codcaster_compass_map_mp_hackney_yard");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraMinObjectContribution", 3);
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 10);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("r_tessellation", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "urban";
  thread scripts\mp\motiondetectors::init();
  thread player_exfil_struct();
  battle_tracks_vehicleoccupancyenter(level);
  thread ref_121f5();
  thread neartrackthink();
  thread fartrackthink();
  thread maintvdestructibles();
  var_0 = getEnt("infil_van_col", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 connectpaths();
  }

  thread ref_136ad();
  thread hide_multiple_brush();
  wait 10;
  thread palfa_lights_thread();
  var_1 = getnodesinradius((808, -350, 185), 200, 0, 200);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.animscript) && var_3.animscript == "jump_down_136") {
      destroynavlink(var_3);
    }
  }

  var_1 = getnodesinradius((766, 1259, 188), 200, 0, 200);

  foreach(var_3 in var_1) {
    if(isDefined(var_3.animscript) && var_3.animscript == "jump_up_80") {
      destroynavlink(var_3);
    }
  }
}

function spawntraincar(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("veh8_civ_lnd_tromeo_animated");
  return var_1;
}

function neartrackthink() {
  level waittill("infil_setup_complete");

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    level waittill("infil_started");
  }

  var_0 = [];
  var_1 = (-5930, -605, 510);
  var_2 = spawntraincar(var_1);
  var_0 = var_2;
  var_3 = var_2;
  var_0[0].angles = (0, 166, 0);
  var_4 = (0, 526, 0);
  var_5 = var_1 + anglesToForward(var_4) * -27000;
  wait 2;
  var_0[0] setscriptablepartstate("lightsFront", "on");
  var_0[var_0.size - 1] setscriptablepartstate("lightsRear", "on");
  thread nearexploderthink(var_0);

  for(;;) {
    var_0[0].origin = var_1;
    wait 1;
    var_0[0] show();
    var_0[0] moveTo(var_5, 30, 0.1, 0.1);
    var_0[0] setscriptablepartstate("nearsfx", "on");
    wait 15 + randomfloatrange(20, 40);
    var_0[0] hide();
    waitframe();
  }
}

function fartrackthink() {
  var_0 = [];
  var_1 = (9240, -4705, 510);
  var_2 = spawntraincar(var_1);
  var_0 = var_2;
  var_3 = var_2;
  var_0[0].angles = (0, 346, 0);
  var_4 = (0, 346, 0);
  var_5 = var_1 + anglesToForward(var_4) * -35000;
  wait 2;
  var_0[0] setscriptablepartstate("lightsFront", "on");
  var_0[var_0.size - 1] setscriptablepartstate("lightsRear", "on");
  thread farexploderthink(var_0);

  for(;;) {
    var_0[0].origin = var_1;
    wait 1;
    var_0[0] show();
    var_0[0] moveTo(var_5, 30, 0.1, 0.1);
    var_0[0] setscriptablepartstate("farsfx", "on");
    wait 20 + randomfloatrange(25, 35);
    var_0[0] hide();
    waitframe();
  }
}

function nearexploderthink(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, (1081.93, -2260.39, 411.6));
}

function farexploderthink(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, 0, (-711.066, -2248.86, 440));
}

function raindrop_fx_manager() {
  wait 3;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  thread raindrop_fx_thread();
  var_1 = getEntArray("rain_exclusion", "script_noteworthy");

  foreach(var_3 in var_1) {
    thread raindrop_fx_trigger_think(var_3);
  }
}

function raindrop_fx_thread(var_0) {
  self endon("stop_raindrop_fx");
  var_1 = "tag_origin";

  for(;;) {
    foreach(var_0 in level.players) {
      if(var_0.sessionstate == "spectator") {
        continue;
      }

      if(istrue(var_0.in_rain)) {
        var_3 = angleclamp180(var_0 getplayerangles()[0]);

        if(var_3 < -35 && !istrue(var_0.looking_up)) {
          playFXOnTag(level._effect["vfx_scrn_lookup_drops"], var_0, "tag_origin");
          var_0.looking_up = 1;
        } else if(var_3 >= -35 && istrue(var_0.looking_up)) {
          if(isDefined("vfx_scrn_lookup_drops")) {
            stopFXOnTag(level._effect["vfx_scrn_lookup_drops"], var_0, "tag_origin");
          }

          var_0.looking_up = 0;
        }
      }
    }

    wait 0.05;
  }
}

function raindrop_fx_trigger_think(var_0) {
  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 istouching(var_0)) {
        var_2.in_rain = 0;
        continue;
      }

      var_2.in_rain = 1;
    }

    wait 0.05;
  }
}

function maintvdestructibles() {
  level endon("game_ended");
  wait 5;
  var_0 = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(var_2 in var_0) {
    thread runtvdestructible();
  }
}

function runtvdestructible() {
  level endon("game_ended");
  self endon("end_watchTVDamage");
  var_0 = scripts\engine\utility::get_target_array();
  var_1 = spawnStruct();
  var_1.lights = [];
  var_1.tvs = getscriptablearray(self.target, "targetname");
  var_1.activetvs = var_1.tvs.size;

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "light") {
      var_4 = var_1.lights.size;
      var_1.lights[var_4] = var_3;
      var_1.lights[var_4].startintensity = var_3 getlightintensity();
      var_1.lights[var_4].currentintensity = var_3 getlightintensity();
      thread runflickerroutine();
    }
  }

  foreach(var_7 in var_1.tvs) {
    thread watchtvdamage(var_7);
    thread watchdestructibletvs(var_7);
  }

  var_9 = var_1.activetvs;

  for(;;) {
    level waittill("destructibleTV_died");
    waittillframeend();

    if(istrue(var_1.dead)) {
      return;
    }

    foreach(var_11 in var_1.lights) {
      var_12 = var_11.startintensity * var_1.tvs.size / var_9;
      var_11 setlightintensity(var_12);
      var_11.currentintensity = var_12;

      if(var_12 <= 0) {
        var_11 notify("flickerRoutine_stop");
        break;
      }
    }

    waitframe();
  }
}

function watchtvdamage(var_0) {
  level endon("game_ended");
  self endon("end_watchTVDamage");
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

  if(var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH") {
    var_0.dead = 1;

    foreach(var_16 in var_0.tvs) {
      var_16 setscriptablepartstate("tv", "dead");

      if(var_16 != self) {
        var_16 notify("end_watchTVDamage");
      }
    }

    foreach(var_19 in var_0.lights) {
      var_19 notify("flickerRoutine_stop");
      var_19 setlightintensity(0);
    }

    self notify("end_watchTVDamage");
    return;
  }
}

function watchdestructibletvs(var_0) {
  level endon("game_ended");
  self waittill("scriptableNotification", var_1);

  if(var_1 == "tv_dead") {
    var_0.tvs = scripts\engine\utility::array_remove(var_0.tvs, self);
    level notify("destructibleTV_died");
    return;
  }
}

function runflickerroutine() {
  self endon("death");
  self endon("flickerRoutine_stop");
  level endon("game_ended");

  for(;;) {
    wait randomfloatrange(0.01, 0.2);
    self setlightintensity(randomfloatrange(self.currentintensity * 0.5, self.currentintensity * 1.5));
  }
}

function hide_multiple_brush() {
  var_0 = getEntArray("bake_shadow_brush", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

function palfa_lights_thread() {
  level endon("game_ended");
  var_0 = 2;

  while(var_0) {
    self waittill("scriptableNotification", var_1);

    if(var_1 == "light_front_left_dead") {
      getEnt("light_front_left", "targetname") setlightintensity(0);
      var_0--;
    } else if(var_1 == "light_front_right_dead") {
      getEnt("light_front_right", "targetname") setlightintensity(0);
      var_0--;
    }

    wait 0.05;
  }
}

function player_exfil_struct() {
  var_0 = getEnt("clip64x64x8", "targetname");
  var_1 = spawn("script_model", (504, 1225, 140));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player32x32x256", "targetname");
  var_3 = spawn("script_model", (-575, -2143, 92));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
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
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (128, -768, 24), (0, 0, 0)));

    case "dom":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn", (128, -768, 24), (0, 0, 0)));

    case "dd":
      GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dd_spawn_defender", (-645, 1343, 156), (0, 330, 0)));
  }

  if(var_0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var_0);
    return;
  }
}

function ref_136ad() {
  var_0 = spawn("trigger_radius", (1416, -80, 97), 0, 64, 100);
  thread ref_144ff(var_0);
  var_1 = spawn("trigger_radius", (1595, -150, 97), 0, 64, 100);
  thread ref_144ff(var_1);
  var_2 = spawn("trigger_radius", (1585, -920, 50), 0, 32, 100);
  thread ref_144ff(var_2);
}

function ref_144ff(var_0) {
  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(!isDefined(self.ref_126ce)) {
      self.ref_126ce = [];
    }

    if(scripts\engine\utility::array_contains(self.ref_126ce, var_1.guid)) {
      continue;
    }

    self.ref_126ce = scripts\engine\utility::array_add(self.ref_126ce, var_1.guid);

    switch (var_0) {
      case "box":
        thread ref_14491(var_1);
        break;
      case "dumpster":
        thread ref_1449c(var_1);
        break;
      case "trashcan":
        thread ref_144fe(var_1);
        break;
    }
  }
}

function ref_14491(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (1579.86, -232.75, 18.1071);
  var_4.radius = 64;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1564.49, -784.368, 18.125);
  var_4.radius = 128;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1567.63, -2088.98, 24.0016);
  var_4.radius = 256;
  var_3 = var_4;
  var_5 = [];

  foreach(var_7 in var_3) {
    var_5 = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 100, var_1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var_0)) {
    waitframe();
  }

  foreach(var_10 in var_5) {
    scripts\mp\spawnlogic::removespawndangerzone(var_10);
  }

  var_0.ref_126ce = scripts\engine\utility::array_remove(var_0.ref_126ce, var_2);
}

function ref_1449c(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (1430.82, 605.449, 23.759);
  var_4.radius = 256;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1574.82, -49.8372, 23.8122);
  var_4.radius = 64;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1500, 1300, 15);
  var_4.radius = 256;
  var_3 = var_4;
  var_5 = [];

  foreach(var_7 in var_3) {
    var_5 = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 70, var_1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var_0)) {
    waitframe();
  }

  foreach(var_10 in var_5) {
    scripts\mp\spawnlogic::removespawndangerzone(var_10);
  }

  var_0.ref_126ce = scripts\engine\utility::array_remove(var_0.ref_126ce, var_2);
}

function ref_144fe(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (1020, -1750, 15);
  var_4.radius = 850;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-617, -1765, 15);
  var_4.radius = 128;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (1500, -1865, 160);
  var_4.radius = 128;
  var_3 = var_4;
  var_5 = [];

  foreach(var_7 in var_3) {
    var_5 = scripts\mp\spawnlogic::addspawndangerzone(var_7.origin, var_7.radius, 70, var_1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var_0)) {
    waitframe();
  }

  foreach(var_10 in var_5) {
    scripts\mp\spawnlogic::removespawndangerzone(var_10);
  }

  var_0.ref_126ce = scripts\engine\utility::array_remove(var_0.ref_126ce, var_2);
}

function ref_121f5() {
  if(level.gametype == "infect") {
    if(!isDefined(level.outofboundstriggers)) {
      level.outofboundstriggers = [];
    }

    var_0 = [(689, 935, 371)];

    foreach(var_2 in var_0) {
      var_3 = spawn("trigger_radius", var_2, 0, 300, 128);
      level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
    }

    return;
  }
}