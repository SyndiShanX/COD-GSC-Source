/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_speed\mp_m_speed.gsc
*****************************************************/

function main() {
  _start_rooftop_raid_heli::keypad_check_levelinput();
  level.music_style = "middle_east";
  scripts\mp\maps\mp_m_speed\mp_m_speed_precache::main();
  scripts\mp\maps\mp_m_speed\gen\mp_m_speed_art::main();
  scripts\mp\maps\mp_m_speed\mp_m_speed_fx::main();
  scripts\mp\maps\mp_m_speed\mp_m_speed_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_speed", "codcaster_compass_map_mp_m_speed");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("PKKMTTRQO", 8);
  scripts\cp_mp\utility\game_utility::ref_12b3b();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_139c6();
  thread player_exfil_struct();
  thread ref_136ad();
}

function ref_139c6() {
  var_0 = getEnt("crane", "targetname");
  var_1 = getEntArray("crane_bits", "targetname");

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);
  }

  var_0.ref_12149 = var_0.angles;
  thread ref_139c8(var_0);
}

function ref_139c8(var_0) {
  level endon("game_ended");
  var_1 = 0.75;

  for(;;) {
    var_2 = 4;
    var_1 *= -1;
    var_0.goalang = var_0.ref_12149 + (randomfloatrange(-0.5, 0.5), randomfloatrange(-4, 4), var_1);
    var_0 rotateTo(var_0.goalang, var_2, var_2 * 0.25, var_2 * 0.25);
    wait var_2 - 0.1;
  }
}

function ref_136ad() {
  var_0 = spawn("trigger_radius", (-20, 2235, 190), 0, 32, 100);
  thread ref_144ff(var_0);
  var_1 = spawn("trigger_radius", (-216, 2236, 190), 0, 32, 100);
  thread ref_144ff(var_1);
  var_2 = spawn("trigger_radius", (-700, 3040, 65), 0, 128, 100);
  thread ref_144ff(var_2);
  var_3 = spawn("trigger_radius", (-450, 1375, 125), 0, 128, 100);
  thread ref_144ff(var_3);
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
      case "window":
        thread ref_14509(var_1);
        break;
      case "spawn_wall":
        thread ref_144f5(var_1);
        break;
      case "mid_side":
        thread ref_144e6(var_1);
        break;
    }
  }
}

function ref_14509(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-1022, 2190, 20);
  var_4.radius = 64;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-1725, 2245, 20);
  var_4.radius = 64;
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

function ref_144f5(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-790, 2850, 20);
  var_4.radius = 256;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-760, 1290, 20);
  var_4.radius = 220;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-770, 780, 20);
  var_4.radius = 100;
  var_3 = var_4;
  var_4 = spawnStruct();
  var_4.origin = (-750, 1800, 20);
  var_4.radius = 200;
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

function ref_144e6(var_0) {
  self endon("death_or_disconnect");
  var_1 = self.team;
  var_2 = self.guid;
  var_3 = [];
  var_4 = spawnStruct();
  var_4.origin = (-1720, 1325, 20);
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

function player_exfil_struct() {
  var_0 = getEnt("nosight128x128x8", "targetname");
  var_1 = spawn("script_model", (-151, 2496, 224));
  var_1.angles = (0, 0, -90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("nosight128x128x8", "targetname");
  var_3 = spawn("script_model", (-279, 2496, 224));
  var_3.angles = (0, 0, -90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player256x256x8", "targetname");
  var_5 = spawn("script_model", (-216, 2496, 416));
  var_5.angles = (0, 0, -90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("nosight128x128x8", "targetname");
  var_7 = spawn("script_model", (-840, 2230, 224));
  var_7.angles = (0, 0, -90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("nosight128x128x8", "targetname");
  var_9 = spawn("script_model", (-712, 2230, 224));
  var_9.angles = (0, 0, -90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("player256x256x8", "targetname");
  var_11 = spawn("script_model", (-776, 2230, 416));
  var_11.angles = (0, 0, -90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("nosight128x128x8", "targetname");
  var_13 = spawn("script_model", (-879, 2705, 224));
  var_13.angles = (0, 0, -90);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("player256x256x8", "targetname");
  var_15 = spawn("script_model", (-815, 2705, 416));
  var_15.angles = (0, 0, -90);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("mantle64", "targetname");
  var_17 = spawn("script_model", (-1035, 1444.5, 74));
  var_17.angles = (0, 270, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16, 1);
}