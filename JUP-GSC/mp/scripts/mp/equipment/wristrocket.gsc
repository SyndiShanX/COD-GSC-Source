/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\wristrocket.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\shellshock;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace wristrocket;

function wristrocketinit() {
  level._effect["wristrocket_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_exp.vfx");
  level._effect["wristrocket_thruster"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_thruster");
}

function wristrocket_set() {
  thread wristrocket_watcheffects();
}

function wristrocket_unset() {
  self notify("wristRocket_unset");
}

function wristrocketused(grenade) {
  if(grenade.tickpercent == 1) {
    return;
  }

  rocket = wristrocket_createrocket(grenade);
  rocket.grenade = grenade;
  grenade = _launchgrenade("pop_rocket_mp", self.origin, (0, 0, 0), 100, 1, grenade);
  grenade forcehidegrenadehudwarning(1);
  grenade linkTo(rocket);
  grenade thread wristrocket_cleanuponparentdeath(rocket);
  grenade thread wristrocket_cleanuponownerdisconnect(self);
  rocket setscriptablepartstate("launch", "active", 0);
  rocket thread wristrocket_watchfuse(2);
  rocket thread wristrocket_watchstuck();
}

function wristrocket_watchfuse(fusetime) {
  self endon("death");
  self.owner endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait fusetime;
  thread wristrocket_explode();
}

function wristrocket_watchstuck() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", stuckto);

  if(isPlayer(stuckto)) {
    self.owner scripts\mp\weapons::grenadestuckto(self, stuckto);
  }

  self stoploopsound();
  self setscriptablepartstate("stuck", "active", 0);
  self setscriptablepartstate("beacon", "active", 0);
  self.grenade forcehidegrenadehudwarning(0);
  thread wristrocket_watchfuse(1.35);
}

function wristrocket_explode() {
  self setscriptablepartstate("stuck", "neutral", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread wristrocket_delete();
}

function wristrocket_delete() {
  self notify("death");
  self.exploding = 1;
  wait 0.1;
  self delete();
}

function wristrocket_createrocket(grenade) {
  rocket = _magicbullet(makeweapon("pop_rocket_proj_mp"), grenade.origin, grenade.origin + anglesToForward(self getgunangles()), self);
  rocket.owner = self;
  rocket.team = self.team;
  rocket.weapon_name = "pop_rocket_proj_mp";
  rocket.power = "power_wristrocket";
  rocket setotherent(self);
  rocket setentityowner(self);
  rocket thread wristrocket_cleanuponownerdisconnect(self);
  return rocket;
}

function wristrocket_watcheffects() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  var_fb0b2f8f6aa55804 = 0;

  while(true) {
    raceresult = spawnStruct();

    if(var_fb0b2f8f6aa55804) {
      childthread wristrocket_watcheffectsraceheldoffhandbreak(raceresult);
    } else {
      childthread wristrocket_watcheffectsracegrenadepullback(raceresult);
    }

    childthread wristrocket_watcheffectsracegrenadefired(raceresult);
    childthread wristrocket_watcheffectsracesuperstarted(raceresult);
    childthread wristrocket_watcheffectsracedeath(raceresult);
    childthread wristrocket_watcheffectsraceunset(raceresult);
    var_fb0b2f8f6aa55804 = 0;
    self waittill("wristRocket_watchEffectsRaceStart");
    waittillframeend();
    grenadepullback = istrue(raceresult.grenadepullback);
    grenadefire = istrue(raceresult.grenadefire);
    superstarted = istrue(raceresult.superstarted);
    death = istrue(raceresult.death);
    unset = istrue(raceresult.unset);
    heldoffhandbreak = istrue(raceresult.heldoffhandbreak);

    if(death) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(unset) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(superstarted) {
      thread wristrocket_endeffects();
    } else if(heldoffhandbreak) {
      thread wristrocket_endeffects();
    } else if(grenadefire) {
      thread wristrocket_endeffects();
    } else if(grenadepullback) {
      thread wristrocket_begineffects();
      var_fb0b2f8f6aa55804 = 1;
    }

    self notify("wristRocket_watchEffectsRaceEnd");
  }
}

function wristrocket_watcheffectsracegrenadepullback(raceresult) {
  self endon("wristRocket_watchEffectsRaceEnd");

  while(true) {
    self waittill("grenade_pullback", objweapon);

    if(objweapon.basename == "pop_rocket_mp") {
      break;
    }
  }

  raceresult.grenadepullback = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracegrenadefired(raceresult) {
  self endon("wristRocket_watchEffectsRaceEnd");

  while(true) {
    self waittill("grenade_fire", grenade, objweapon);

    if(objweapon.basename == "pop_rocket_mp") {
      break;
    }
  }

  raceresult.grenadefire = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracesuperstarted(raceresult) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  raceresult.superstarted = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracedeath(raceresult) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  raceresult.death = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsraceunset(raceresult) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  raceresult.unset = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsraceheldoffhandbreak(raceresult) {
  self endon("wristRocket_watchEffectsRaceEnd");
  waitframe();
  weapon = makeweapon("pop_rocket_mp");

  while(self getheldoffhand() == weapon) {
    waitframe();
  }

  raceresult.heldoffhandbreak = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_begineffects() {
  self notify("wristRocket_beginEffects");
  self endon("wristRocket_beginEffects");
  self endon("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
  wait 0.15;
  self setscriptablepartstate("wristRocketWorld", "active", 0);
}

function wristrocket_endeffects() {
  self notify("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
}

function wristrocketcooksuicideexplodecheck(inflictor, attacker, victim, meansofdeath, objweapon) {
  if(attacker != victim) {
    return;
  }

  if(meansofdeath != "MOD_SUICIDE") {
    return;
  }

  if(!isDefined(inflictor) || inflictor != attacker) {
    return;
  }

  if(!isDefined(objweapon) || objweapon.basename != "pop_rocket_mp") {
    return;
  }

  explodepos = victim gettagorigin("tag_weapon_left");
  radiusdamage(explodepos, 175, 200, 70, attacker, "MOD_EXPLOSIVE", "pop_rocket_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(explodepos, 0.6);
  playFX(getfx("wristrocket_explode"), explodepos);
}

function wristrocket_cleanuponparentdeath(parent, delay) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(parent)) {
    parent waittill("death");
  }

  if(isDefined(delay)) {
    wait delay;
  }

  self delete();
}

function wristrocket_cleanuponownerdisconnect(owner) {
  self endon("death");
  owner waittill("disconnect");

  if(isDefined(self)) {
    self delete();
  }
}