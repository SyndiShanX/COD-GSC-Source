/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_distraction_drone.gsc
*****************************************************************/

init() {
  level._effect["drone_distraction_scan_fx"] = loadfx("vfx/props/dlc_prop_distract_drone_fx_main");
  level._effect["zdd_explode"] = loadfx("vfx/explosion/explosive_drone_explosion");
  level.zdd_active = [];
  level thread watchagentspawn();
}

watchagentspawn() {
  for(;;) {
    level waittill("spawned_agent", var_0);

    if(isDefined(var_0.agentteam) && isDefined(level.playerteam) && var_0.agentteam == level.playerteam) {
      continue;
    }
    var_0 thread zombiedistractiondrone();
  }
}

getdistractiondroneradiussqr() {
  if(isDefined(self.maxdistsqr)) {
    return self.maxdistsqr;
  }

  return 2250000;
}

zombiedistractiondrone() {
  self endon("death");

  for(;;) {
    while(level.zdd_active.size > 0) {
      var_0 = undefined;

      foreach(var_2 in level.zdd_active) {
        if(!checkdronetrapvalid(var_2)) {
          continue;
        }
        var_3 = distance2dsquared(var_2.origin, self.origin);
        var_4 = var_2 getdistractiondroneradiussqr();

        if(var_3 < var_4) {
          var_0 = var_2;
          break;
        }
      }

      if(isDefined(var_0)) {
        self.distractiondrone = var_0;
        self.distractiondronebadpathcount = 0;

        if(isDefined(var_0.agentcount)) {
          var_0.agentcount++;
          thread distractiondronetrapmonitor(var_0);
        }

        var_0 common_scripts\utility::waittill_any("death", "stop");
        self.distractiondrone = undefined;
        waittillframeend;
        continue;
      }

      self.distractiondrone = undefined;
      waitframe();
    }

    level waittill("distraction_drone_activated");
  }
}

checkdronetrapvalid(var_0) {
  if(!isDefined(var_0.istrap) || !var_0.istrap) {
    return 1;
  }

  var_1 = 4;

  if(isDefined(var_0.maxcount)) {
    var_1 = var_0.maxcount;
  }

  if(var_0.agentcount > var_1) {
    return 0;
  }

  if(maps\mp\zombies\_util::istrapresistant()) {
    return 0;
  }

  return 1;
}

distractiondronetrapmonitor(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    var_0.agentcount--;
  }
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_2 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_2 == "distraction_drone_zombie_mp" || var_2 == "distraction_drone_throw_zombie_mp") {
      var_0.team = self.team;

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.weaponname)) {
        var_0.weaponname = var_1;
      }

      var_0 thread watchowner();
      var_0 thread watchforstick();
    }
  }
}

watchowner() {
  self endon("death");
  self.owner waittill("disconnect");
  self delete();
}

watchdroneowner() {
  self endon("death");
  self.owner waittill("disconnect");
  destroydrone();
}

watchforstick() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", var_0);
  var_1 = spawndronemodel();
  var_1.groundpos = self.origin;
  var_1 thread droneanimate();
  var_1 thread watchdeath();
  var_1 thread watchdroneowner();
  var_1 thread dronethink();
  level notify("distraction_drone_activated", var_1);
  level.zdd_active[level.zdd_active.size] = var_1;
  var_2 = [];

  foreach(var_1 in level.zdd_active) {
    if(isDefined(var_1.istrap) && var_1.istrap) {
      continue;
    }
    var_2[var_2.size] = var_1;
  }

  if(var_2.size > 4) {
    var_2[0] destroydrone();
  }

  self delete();
}

dronethink() {
  self endon("death");
  wait 7;
  destroydrone();
}

spawndronemodel() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("dlc_distraction_drone_01");
  var_0.owner = self.owner;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("drone_distraction_scan_fx"), var_0, "TAG_SIREN_FX");
  var_0.fx = 1;
  var_0 thread droneaudio();
  return var_0;
}

droneanimate() {
  self endon("death");
  thread dronerotate();
  self moveto(self.origin + (0, 0, 70), 1, 0, 1);
}

dronerotate() {
  self endon("death");
  var_0 = 600;

  for(;;) {
    self rotatevelocity((0, 60, 0), var_0);
    wait(var_0);
  }
}

droneaudio() {
  var_0 = spawn("script_model", self.origin);
  self.soundandeffectsent = var_0;
  var_0 setModel("tag_origin");
  var_0 linktosynchronizedparent(self, "tag_weapon", (0, 0, 0), (0, 0, 0));
  var_0 playsoundonmovingent("distraction_drone_deploy");
  wait 0.3;
  self playLoopSound("distraction_drone_alarm");
  self waittill("death");
  wait 3;
  var_0 delete();
}

watchdeath() {
  self waittill("death");
  level.zdd_active = common_scripts\utility::array_remove(level.zdd_active, self);
}

destroydrone(var_0) {
  if(isDefined(self.istrap) && self.istrap) {
    level.zdd_active = common_scripts\utility::array_remove(level.zdd_active, self);
    self delete();
    return;
  }

  var_1 = !(isDefined(var_0) && var_0);

  if(isDefined(self.fx)) {
    if(var_1) {
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("drone_distraction_scan_fx"), self, "TAG_SIREN_FX");
    } else {
      maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("drone_distraction_scan_fx"), self, "TAG_SIREN_FX");
      wait 0.05;
    }
  }

  playFXOnTag(common_scripts\utility::getfx("zdd_explode"), self.soundandeffectsent, "tag_origin");
  self.soundandeffectsent playsoundonmovingent("wpn_explosive_drone_exp");
  var_2 = self.origin;
  var_3 = self.owner;

  if(isremovedentity(var_3)) {
    var_3 = undefined;
  }

  if(var_1) {
    self radiusdamage(var_2, 100, 5000, 450, var_3, "MOD_EXPLOSIVE", "distraction_drone_zombie_mp");
  }

  self stoploopsound();
  self delete();
}