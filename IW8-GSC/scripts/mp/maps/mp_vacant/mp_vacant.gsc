/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_vacant\mp_vacant.gsc
***************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_vacant\mp_vacant_precache::main();
  scripts\mp\maps\mp_vacant\gen\mp_vacant_art::main();
  scripts\mp\maps\mp_vacant\mp_vacant_fx::main();
  scripts\mp\maps\mp_vacant\mp_vacant_lighting::main();
  scripts\mp\load::main();
  var0 = spawn("trigger_radius", (5120, 0, -512), 0, 512, 800);
  var0.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_vacant", "codcaster_compass_map_mp_vacant");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  thread player_fired_gun_monitor();
  thread ref_1362c();
}

function player_fired_gun_monitor() {
  var0 = getEnt("mount64", "targetname");
  var1 = spawn("script_model", (2830, 1212, 112));
  var1.angles = (270, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0, 1);
}

function ref_1362c() {
  var0 = spawn("trigger_radius", (1720, 1737, 100), 0, 64, 100);
  thread ref_144ff(var0);
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
    }
  }
}

function ref_14491(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (2883, 712, 60);
  var4.radius = 128;
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