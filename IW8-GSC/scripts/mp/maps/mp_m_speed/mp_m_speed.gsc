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
  var0 = getEnt("crane", "targetname");
  var1 = getEntArray("crane_bits", "targetname");

  foreach(var3 in var1) {
    var3 linkTo(var0);
  }

  var0.ref_12149 = var0.angles;
  thread ref_139c8(var0);
}

function ref_139c8(var0) {
  level endon("game_ended");
  var1 = 0.75;

  for(;;) {
    var2 = 4;
    var1 *= -1;
    var0.goalang = var0.ref_12149 + (randomfloatrange(-0.5, 0.5), randomfloatrange(-4, 4), var1);
    var0 rotateTo(var0.goalang, var2, var2 * 0.25, var2 * 0.25);
    wait var2 - 0.1;
  }
}

function ref_136ad() {
  var0 = spawn("trigger_radius", (-20, 2235, 190), 0, 32, 100);
  thread ref_144ff(var0);
  var1 = spawn("trigger_radius", (-216, 2236, 190), 0, 32, 100);
  thread ref_144ff(var1);
  var2 = spawn("trigger_radius", (-700, 3040, 65), 0, 128, 100);
  thread ref_144ff(var2);
  var3 = spawn("trigger_radius", (-450, 1375, 125), 0, 128, 100);
  thread ref_144ff(var3);
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
      case "window":
        thread ref_14509(var1);
        break;
      case "spawn_wall":
        thread ref_144f5(var1);
        break;
      case "mid_side":
        thread ref_144e6(var1);
        break;
    }
  }
}

function ref_14509(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-1022, 2190, 20);
  var4.radius = 64;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-1725, 2245, 20);
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

function ref_144f5(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-790, 2850, 20);
  var4.radius = 256;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-760, 1290, 20);
  var4.radius = 220;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-770, 780, 20);
  var4.radius = 100;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-750, 1800, 20);
  var4.radius = 200;
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

function ref_144e6(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-1720, 1325, 20);
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

function player_exfil_struct() {
  var0 = getEnt("nosight128x128x8", "targetname");
  var1 = spawn("script_model", (-151, 2496, 224));
  var1.angles = (0, 0, -90);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("nosight128x128x8", "targetname");
  var3 = spawn("script_model", (-279, 2496, 224));
  var3.angles = (0, 0, -90);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("player256x256x8", "targetname");
  var5 = spawn("script_model", (-216, 2496, 416));
  var5.angles = (0, 0, -90);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("nosight128x128x8", "targetname");
  var7 = spawn("script_model", (-840, 2230, 224));
  var7.angles = (0, 0, -90);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("nosight128x128x8", "targetname");
  var9 = spawn("script_model", (-712, 2230, 224));
  var9.angles = (0, 0, -90);
  var9 clonebrushmodeltoscriptmodel(var8);
  var10 = getEnt("player256x256x8", "targetname");
  var11 = spawn("script_model", (-776, 2230, 416));
  var11.angles = (0, 0, -90);
  var11 clonebrushmodeltoscriptmodel(var10);
  var12 = getEnt("nosight128x128x8", "targetname");
  var13 = spawn("script_model", (-879, 2705, 224));
  var13.angles = (0, 0, -90);
  var13 clonebrushmodeltoscriptmodel(var12);
  var14 = getEnt("player256x256x8", "targetname");
  var15 = spawn("script_model", (-815, 2705, 416));
  var15.angles = (0, 0, -90);
  var15 clonebrushmodeltoscriptmodel(var14);
  var16 = getEnt("mantle64", "targetname");
  var17 = spawn("script_model", (-1035, 1444.5, 74));
  var17.angles = (0, 270, 0);
  var17 clonebrushmodeltoscriptmodel(var16, 1);
}