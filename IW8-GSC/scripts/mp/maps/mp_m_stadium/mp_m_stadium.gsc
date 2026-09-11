/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_stadium\mp_m_stadium.gsc
*********************************************************/

function main() {
  scripts\mp\maps\mp_m_stadium\mp_m_stadium_precache::main();
  scripts\mp\maps\mp_m_stadium\gen\mp_m_stadium_art::main();
  scripts\mp\maps\mp_m_stadium\mp_m_stadium_fx::main();
  scripts\mp\maps\mp_m_stadium\mp_m_stadium_lighting::main();
  scripts\mp\load::main();
  setDvar("mantle_force_legacy_system", 1);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_stadium", "codcaster_compass_map_mp_m_stadium");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread damage_multiplier();
  thread ref_12733();
  thread ref_121f4();
  thread ref_1362a();
}

function ref_12733() {
  if(getdvarint("scr_game_soccerevent", 0) == 0) {
    level.select_stairway_spawners["gos_fireworks"] = loadfx("vfx/iw8_mp/gamemode/vfx_gos_firework.vfx");
  }

  level waittill("game_ended");

  if(scripts\mp\utility\game::waslastround()) {
    scripts\engine\utility::exploder("goal_1");
    scripts\engine\utility::exploder("goal_2");
    var0 = [];

    if(!isDefined(level.ref_1346e)) {
      var1 = getEntArray("allies_goal", "targetname");
      var2 = getEntArray("axis_goal", "targetname");

      if(var1.size > 0 && var2.size > 0) {
        var3 = spawnStruct();
        var3.trigger = var1[0];
        var3.select_low_roof_spawners = 10;
        var4 = spawnStruct();
        var4.trigger = var2[0];
        var4.select_low_roof_spawners = 10;
        var0 = [var4, var3];
      }
    } else {
      foreach(var6 in level.ref_1346e) {
        var6.select_low_roof_spawners = 10;
      }

      var0 = level.ref_1346e;
    }

    for(var8 = 0; var8 < var0.size; var8++) {
      var0[var8] thread scripts\mp\gametypes\common::select_lobby_door_two_spawners(1, 0.5);
    }

    return;
  }
}

function vehicle_compass_br_shouldbevisibletoplayer(var0) {
  var1 = spawncovernode(var0, (0, randomint(360), 0), "Cover Stand");
}

function damage_multiplier() {
  var0 = (-459, -498, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-128, -337, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (405, 8, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (213, -44, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (353, 409, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (135, 308, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-332, 988, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (334, 978, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-288, -141, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-456, 381, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-467, 551, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-467, 148, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-358, 180, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-459, 18, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-289, -140, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-271, -199, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (270, -50, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (419, -67, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (331, -89, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (435, 180, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (218, -108, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-3.41, 218.7, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-6, 240, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (327.47, -158.39, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
  var0 = (-2, 208, -333);
  thread vehicle_compass_br_shouldbevisibletoplayer(var0);
}

function ref_121f4() {
  var0 = getEnt("clip64x64x64", "targetname");
  var1 = spawn("script_model", (-495, -1237, -348));
  var1.angles = (0, 330, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
}

function ref_1362a() {
  var0 = spawn("trigger_radius", (-150, -470, -230), 0, 64, 100);
  thread ref_144ff(var0);
  var1 = spawn("trigger_radius", (177, -46, -200), 0, 64, 100);
  thread ref_144ff(var1);
  var2 = spawn("trigger_radius", (-95, 125, -230), 0, 64, 100);
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
      case "truck_southwest":
        thread ref_14504(var1);
        break;
      case "truck_mid_east":
        thread ref_14502(var1);
        break;
      case "truck_mid_west":
        thread ref_14503(var1);
        break;
    }
  }
}

function ref_14504(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (125, 1115, -335);
  var4.radius = 64;
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

function ref_14502(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-24, 863, -335);
  var4.radius = 500;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (478, -1005, -335);
  var4.radius = 225;
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

function ref_14503(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-480, 1000, -335);
  var4.radius = 225;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (348, 1058, -335);
  var4.radius = 300;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (427, -866, -335);
  var4.radius = 64;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-437, -864, -335);
  var4.radius = 64;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (454, -14, -335);
  var4.radius = 64;
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