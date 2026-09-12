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
  var_0 = spawn("trigger_radius", (5120, 0, -512), 0, 512, 800);
  var_0.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_vacant", "codcaster_compass_map_mp_vacant");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "eastern_europe";
  thread player_fired_gun_monitor();
  thread ref_1362C();
}

function player_fired_gun_monitor() {
  var_0 = getEnt("mount64", "targetname");
  var_1 = spawn("script_model", (2830, 1212, 112));
  var_1.angles = (270, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0, 1);
}

function ref_1362C() {
  var_0 = spawn("trigger_radius", (1720, 1737, 100), 0, 64, 100);
  thread ref_144FF(var_0);
}

function ref_144FF(var_0) {
  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(!isDefined(self.ref_126CE)) {
      self.ref_126CE = [];
    }

    if(scripts\engine\utility::array_contains(self.ref_126CE, var_1.guid)) {
      continue;
    }

    self.ref_126CE = scripts\engine\utility::array_add(self.ref_126CE, var_1.guid);

    switch (var_0) {
      case "box":
        thread ref_14491(var_1);
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
  var_4.origin = (2883, 712, 60);
  var_4.radius = 128;
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

  var_0.ref_126CE = scripts\engine\utility::array_remove(var_0.ref_126CE, var_2);
}