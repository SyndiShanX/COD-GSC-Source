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
  setDvar("PKKMTTRQO", 3);
  setDvar("LKOLRONRNQ", 1500);
  setDvar("LTQMSPKRKO", 6);
  setDvar("MROOOROPKL", 10);
  setDvar("MNQKPNLOPT", 1);
  setDvar("NRSOTSLSSO", 1);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("MMNMQTSOSP", 0);
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
  var0 = getEnt("infil_van_col", "targetname");

  if(isDefined(var0)) {
    var0 hide();
    var0 connectpaths();
  }

  thread ref_136ad();
  thread hide_multiple_brush();
  wait 10;
  thread palfa_lights_thread();
  var1 = getnodesinradius((808, -350, 185), 200, 0, 200);

  foreach(var3 in var1) {
    if(isDefined(var3.animscript) && var3.animscript == "jump_down_136") {
      destroynavlink(var3);
    }
  }

  var1 = getnodesinradius((766, 1259, 188), 200, 0, 200);

  foreach(var3 in var1) {
    if(isDefined(var3.animscript) && var3.animscript == "jump_up_80") {
      destroynavlink(var3);
    }
  }
}

function spawntraincar(var0) {
  var1 = spawn("script_model", var0);
  var1 setModel("veh8_civ_lnd_tromeo_animated");
  return var1;
}

function neartrackthink() {
  level waittill("infil_setup_complete");

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    level waittill("infil_started");
  }

  var0 = [];
  var1 = (-5930, -605, 510);
  var2 = spawntraincar(var1);
  var0 = var2;
  var3 = var2;
  var0[0].angles = (0, 166, 0);
  var4 = (0, 526, 0);
  var5 = var1 + anglesToForward(var4) * -27000;
  wait 2;
  var0[0] setscriptablepartstate("lightsFront", "on");
  var0[var0.size - 1] setscriptablepartstate("lightsRear", "on");
  thread nearexploderthink(var0);

  for(;;) {
    var0[0].origin = var1;
    wait 1;
    var0[0] show();
    var0[0] moveTo(var5, 30, 0.1, 0.1);
    var0[0] setscriptablepartstate("nearsfx", "on");
    wait 15 + randomfloatrange(20, 40);
    var0[0] hide();
    waitframe();
  }
}

function fartrackthink() {
  var0 = [];
  var1 = (9240, -4705, 510);
  var2 = spawntraincar(var1);
  var0 = var2;
  var3 = var2;
  var0[0].angles = (0, 346, 0);
  var4 = (0, 346, 0);
  var5 = var1 + anglesToForward(var4) * -35000;
  wait 2;
  var0[0] setscriptablepartstate("lightsFront", "on");
  var0[var0.size - 1] setscriptablepartstate("lightsRear", "on");
  thread farexploderthink(var0);

  for(;;) {
    var0[0].origin = var1;
    wait 1;
    var0[0] show();
    var0[0] moveTo(var5, 30, 0.1, 0.1);
    var0[0] setscriptablepartstate("farsfx", "on");
    wait 20 + randomfloatrange(25, 35);
    var0[0] hide();
    waitframe();
  }
}

function nearexploderthink(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, (1081.93, -2260.39, 411.6));
}

function farexploderthink(var0) {
  var1 = [];
  GscBinSkip0(0x2e, 0, (-711.066, -2248.86, 440));
}

function raindrop_fx_manager() {
  wait 3;
  var0 = scripts\engine\utility::spawn_tag_origin();
  thread raindrop_fx_thread();
  var1 = getEntArray("rain_exclusion", "script_noteworthy");

  foreach(var3 in var1) {
    thread raindrop_fx_trigger_think(var3);
  }
}

function raindrop_fx_thread(var0) {
  self endon("stop_raindrop_fx");
  var1 = "tag_origin";

  for(;;) {
    foreach(var0 in level.players) {
      if(var0.sessionstate == "spectator") {
        continue;
      }

      if(istrue(var0.in_rain)) {
        var3 = angleclamp180(var0 getplayerangles()[0]);

        if(var3 < -35 && !istrue(var0.looking_up)) {
          playFXOnTag(level._effect["vfx_scrn_lookup_drops"], var0, "tag_origin");
          var0.looking_up = 1;
        } else if(var3 >= -35 && istrue(var0.looking_up)) {
          if(isDefined("vfx_scrn_lookup_drops")) {
            stopFXOnTag(level._effect["vfx_scrn_lookup_drops"], var0, "tag_origin");
          }

          var0.looking_up = 0;
        }
      }
    }

    wait 0.05;
  }
}

function raindrop_fx_trigger_think(var0) {
  for(;;) {
    foreach(var2 in level.players) {
      if(var2 istouching(var0)) {
        var2.in_rain = 0;
        continue;
      }

      var2.in_rain = 1;
    }

    wait 0.05;
  }
}

function maintvdestructibles() {
  level endon("game_ended");
  wait 5;
  var0 = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(var2 in var0) {
    thread runtvdestructible();
  }
}

function runtvdestructible() {
  level endon("game_ended");
  self endon("end_watchTVDamage");
  var0 = scripts\engine\utility::get_target_array();
  var1 = spawnStruct();
  var1.lights = [];
  var1.tvs = getscriptablearray(self.target, "targetname");
  var1.activetvs = var1.tvs.size;

  foreach(var3 in var0) {
    if(var3.code_classname == "light") {
      var4 = var1.lights.size;
      var1.lights[var4] = var3;
      var1.lights[var4].startintensity = var3 getlightintensity();
      var1.lights[var4].currentintensity = var3 getlightintensity();
      thread runflickerroutine();
    }
  }

  foreach(var7 in var1.tvs) {
    thread watchtvdamage(var7);
    thread watchdestructibletvs(var7);
  }

  var9 = var1.activetvs;

  for(;;) {
    level waittill("destructibleTV_died");
    waittillframeend();

    if(istrue(var1.dead)) {
      return;
    }

    foreach(var11 in var1.lights) {
      var12 = var11.startintensity * var1.tvs.size / var9;
      var11 setlightintensity(var12);
      var11.currentintensity = var12;

      if(var12 <= 0) {
        var11 notify("flickerRoutine_stop");
        break;
      }
    }

    waitframe();
  }
}

function watchtvdamage(var0) {
  level endon("game_ended");
  self endon("end_watchTVDamage");
  self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

  if(var5 == "MOD_EXPLOSIVE" || var5 == "MOD_GRENADE_SPLASH") {
    var0.dead = 1;

    foreach(var16 in var0.tvs) {
      var16 setscriptablepartstate("tv", "dead");

      if(var16 != self) {
        var16 notify("end_watchTVDamage");
      }
    }

    foreach(var19 in var0.lights) {
      var19 notify("flickerRoutine_stop");
      var19 setlightintensity(0);
    }

    self notify("end_watchTVDamage");
    return;
  }
}

function watchdestructibletvs(var0) {
  level endon("game_ended");
  self waittill("scriptableNotification", var1);

  if(var1 == "tv_dead") {
    var0.tvs = scripts\engine\utility::array_remove(var0.tvs, self);
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
  var0 = getEntArray("bake_shadow_brush", "targetname");

  foreach(var2 in var0) {
    var2 delete();
  }
}

function palfa_lights_thread() {
  level endon("game_ended");
  var0 = 2;

  while(var0) {
    self waittill("scriptableNotification", var1);

    if(var1 == "light_front_left_dead") {
      getEnt("light_front_left", "targetname") setlightintensity(0);
      var0--;
    } else if(var1 == "light_front_right_dead") {
      getEnt("light_front_right", "targetname") setlightintensity(0);
      var0--;
    }

    wait 0.05;
  }
}

function player_exfil_struct() {
  var0 = getEnt("clip64x64x8", "targetname");
  var1 = spawn("script_model", (504, 1225, 140));
  var1.angles = (0, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("player32x32x256", "targetname");
  var3 = spawn("script_model", (-575, -2143, 92));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
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
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn", (128, -768, 24), (0, 0, 0)));

    case "dom":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn", (128, -768, 24), (0, 0, 0)));

    case "dd":
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dd_spawn_defender", (-645, 1343, 156), (0, 330, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}

function ref_136ad() {
  var0 = spawn("trigger_radius", (1416, -80, 97), 0, 64, 100);
  thread ref_144ff(var0);
  var1 = spawn("trigger_radius", (1595, -150, 97), 0, 64, 100);
  thread ref_144ff(var1);
  var2 = spawn("trigger_radius", (1585, -920, 50), 0, 32, 100);
  thread ref_144ff(var2);
}

function ref_144ff(var0) {
  for(;;) {
    self waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(!isDefined(self.ref_126ce)) {
      self.ref_126ce = [];
    }

    if(scripts\engine\utility::array_contains(self.ref_126ce, var1.guid)) {
      continue;
    }

    self.ref_126ce = scripts\engine\utility::array_add(self.ref_126ce, var1.guid);

    switch (var0) {
      case "box":
        thread ref_14491(var1);
        break;
      case "dumpster":
        thread ref_1449c(var1);
        break;
      case "trashcan":
        thread ref_144fe(var1);
        break;
    }
  }
}

function ref_14491(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (1579.86, -232.75, 18.1071);
  var4.radius = 64;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (1564.49, -784.368, 18.125);
  var4.radius = 128;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (1567.63, -2088.98, 24.0016);
  var4.radius = 256;
  var3 = var4;
  var5 = [];

  foreach(var7 in var3) {
    var5 = scripts\mp\spawnlogic::addspawndangerzone(var7.origin, var7.radius, 100, var1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var0)) {
    waitframe();
  }

  foreach(var10 in var5) {
    scripts\mp\spawnlogic::removespawndangerzone(var10);
  }

  var0.ref_126ce = scripts\engine\utility::array_remove(var0.ref_126ce, var2);
}

function ref_1449c(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (1430.82, 605.449, 23.759);
  var4.radius = 256;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (1574.82, -49.8372, 23.8122);
  var4.radius = 64;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (1500, 1300, 15);
  var4.radius = 256;
  var3 = var4;
  var5 = [];

  foreach(var7 in var3) {
    var5 = scripts\mp\spawnlogic::addspawndangerzone(var7.origin, var7.radius, 70, var1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var0)) {
    waitframe();
  }

  foreach(var10 in var5) {
    scripts\mp\spawnlogic::removespawndangerzone(var10);
  }

  var0.ref_126ce = scripts\engine\utility::array_remove(var0.ref_126ce, var2);
}

function ref_144fe(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (1020, -1750, 15);
  var4.radius = 850;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-617, -1765, 15);
  var4.radius = 128;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (1500, -1865, 160);
  var4.radius = 128;
  var3 = var4;
  var5 = [];

  foreach(var7 in var3) {
    var5 = scripts\mp\spawnlogic::addspawndangerzone(var7.origin, var7.radius, 70, var1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var0)) {
    waitframe();
  }

  foreach(var10 in var5) {
    scripts\mp\spawnlogic::removespawndangerzone(var10);
  }

  var0.ref_126ce = scripts\engine\utility::array_remove(var0.ref_126ce, var2);
}

function ref_121f5() {
  if(level.gametype == "infect") {
    if(!isDefined(level.outofboundstriggers)) {
      level.outofboundstriggers = [];
    }

    var0 = [(689, 935, 371)];

    foreach(var2 in var0) {
      var3 = spawn("trigger_radius", var2, 0, 300, 128);
      level.outofboundstriggers[level.outofboundstriggers.size] = var3;
    }

    return;
  }
}