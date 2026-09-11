/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hackney_am\mp_hackney_am.gsc
***********************************************************/

function main() {
  _questtimerwait::keypad_check_levelinput();
  level.music_style = "england";
  scripts\mp\maps\mp_hackney_am\mp_hackney_am_precache::main();
  scripts\mp\maps\mp_hackney_am\gen\mp_hackney_am_art::main();
  scripts\mp\maps\mp_hackney_am\mp_hackney_am_fx::main();
  scripts\mp\maps\mp_hackney_am\mp_hackney_am_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_hackney_am", "codcaster_compass_map_mp_hackney_am");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("PKKMTTRQO", 8);
  setDvar("LKOLRONRNQ", 1500);
  setDvar("MMNMQTSOSP", 0);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.325);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 4);
  setDvar("TSSONTORK", 0);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("NSSMQLPRNT", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "urban";
  thread scripts\mp\motiondetectors::init();
  thread neartrackthink();
  thread fartrackthink();
  thread maintvdestructibles();
  var0 = getEnt("infil_van_col", "targetname");

  if(isDefined(var0)) {
    var0 hide();
    var0 connectpaths();
  }

  thread hide_multiple_brush();
  thread setup_vista_driving_boats();
  thread player_exfil_struct();
  battle_tracks_vehicleoccupancyenter(level);
  thread ref_121f5();
  thread ref_136ad();

  if(!getdvarint("LLQQOPKTKM")) {
    foreach(var2 in getEntArray("van_hackney_infil_alpha_lighting_model", "targetname")) {
      var2 hide();
    }
  }

  var4 = getnodesinradius((808, -350, 185), 200, 0, 200);

  foreach(var6 in var4) {
    if(isDefined(var6.animscript) && var6.animscript == "jump_down_136") {
      destroynavlink(var6);
    }
  }

  var4 = getnodesinradius((766, 1259, 188), 200, 0, 200);

  foreach(var6 in var4) {
    if(isDefined(var6.animscript) && var6.animscript == "jump_up_80") {
      destroynavlink(var6);
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
  var0 = scripts\engine\utility::get_target_array();
  var1 = spawnStruct();
  var1.lights = [];
  var1.tvs = getscriptablearray(self.target, "targetname");
  var1.activetvs = var1.tvs.size;

  foreach(var3 in var0) {
    if(var3.code_classname == "light") {
      var1.lights[var1.lights.size] = var3;
      var1.lights[var1.lights.size - 1].startvalue = var3 getlightintensity();
    }
  }

  foreach(var6 in var1.tvs) {
    thread watchdestructibletvs(var6);
  }

  var8 = var1.activetvs;

  for(;;) {
    level waittill("destructibleTV_died");

    foreach(var10 in var1.lights) {
      var10 setlightintensity(var10.startvalue * var1.tvs.size / var8);
    }

    waitframe();
  }
}

function watchdestructibletvs(var0) {
  level endon("game_ended");
  self waittill("scriptableNotification", var1);
  var0.tvs = scripts\engine\utility::array_remove(var0.tvs, self);
  level notify("destructibleTV_died");
}

function hide_multiple_brush() {
  var0 = getEntArray("bake_shadow_brush", "targetname");

  foreach(var2 in var0) {
    var2 delete();
  }
}

function setup_vista_driving_boats() {
  wait 10;
  var0 = getEntArray("boat_vista", "targetname");
  var1 = 0.00769231;
  var2 = 0.0166667;
  var3 = 0.0111111;
  level._effect["vfx_sailboat_wake"] = loadfx("vfx/iw8_mp/level/overund/vfx_sailboat.vfx");
  level._effect["vfx_tourboat_wake"] = loadfx("vfx/iw8_mp/level/overund/vfx_tourboat.vfx");
  wait 2;

  foreach(var5 in var0) {
    var5.boatfx = scripts\engine\utility::spawn_tag_origin();
    var5.boatfx.origin = var5.origin;
    var5.boatfx.angles = var5.angles;
    var5.boatfx.targetname = "boatFX";
    var5.boatfx show();
    var5.boatfx linkTo(var5);
    wait 0.1;

    if(isDefined(var5.script_label)) {
      if(var5.script_label == "ship") {
        thread vista_boat_drive(var5, var3);
      } else {
        thread vista_boat_drive(var5, var2);
        playFXOnTag(scripts\engine\utility::getfx("vfx_sailboat_wake"), var5.boatfx, "tag_origin");
      }

      continue;
    }

    thread vista_boat_drive(var5, var1);
    playFXOnTag(scripts\engine\utility::getfx("vfx_tourboat_wake"), var5.boatfx, "tag_origin");
  }
}

function vista_boat_drive(var0, var1) {
  level endon("game_ended");
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

  for(;;) {
    var3 = abs(distance(var0.origin, var2.origin) * var1);
    var0 moveTo(var2.origin, var3, 0, 0);
    var0 rotateTo(var2.angles, var3, 0, 0);
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
    wait var3;
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