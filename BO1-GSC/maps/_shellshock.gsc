/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_shellshock.gsc
**************************************/

main(origin, duration, shock_range, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock, stanceLockDuration) {
  assertex(isDefined(origin), "_shellshock::main() needs a origin passed in now for coop consideration.");
  if(!isDefined(shock_range)) {
    shock_range = 500;
  }
  if(!isDefined(duration)) {
    duration = 12;
  } else if(duration < 7) {
    duration = 7;
  }
  if(!isDefined(nMaxDamageBase)) {
    nMaxDamageBase = 150;
  }
  if(!isDefined(nRanDamageBase)) {
    nRanDamageBase = 100;
  }
  if(!isDefined(nMinDamageBase)) {
    nMinDamageBase = 100;
  }
  if(!isDefined(customShellShock)) {
    customShellShock = "default";
  }
  players = maps\_utility::get_players();
  for(q = 0; q < players.size; q++) {
    if(Distancesquared(players[q].origin, origin) < shock_range * shock_range) {
      players[q] thread shellshock_thread(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock, stanceLockDuration);
    }
  }
}
shellshock_thread(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock, stanceLockDuration) {
  origin = self GetOrigin() + (0, 8, 2);
  range = 320;
  if(isDefined(nRanDamageBase) && nRanDamageBase > 0) {
    maxdamage = nMaxDamageBase + RandomInt(nRanDamageBase);
  } else {
    maxdamage = nMaxDamageBase;
  }
  mindamage = nMinDamageBase;
  wait(0.25);
  RadiusDamage(origin, range, maxdamage, mindamage);
  Earthquake(0.75, 2, origin, 2250);
  if(IsAlive(self)) {
    if(isDefined(stanceLockDuration) && stanceLockDuration > 0) {
      self AllowStand(false);
      self AllowCrouch(false);
      self AllowProne(true);
    }
    wait(0.15);
    self ViewKick(127, self.origin);
    self ShellShock(customShellShock, duration);
    if(!isDefined(nExposed)) {
      level thread playerHitable(duration);
    }
    if(!isDefined(stanceLockDuration)) {
      stanceLockDuration = 1.5;
    }
    wait(stanceLockDuration);
    self AllowStand(true);
    self AllowCrouch(true);
  }
}
playerHitable(duration) {
  self.shellshocked = true;
  self.ignoreme = true;
  level notify("player is shell shocked");
  level endon("player is shell shocked");
  wait(duration - 1);
  self.shellshocked = false;
  self.ignoreme = false;
}
endOnDeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}
grenade_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.5, 0.5, position, 1000);
}
c4_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.5, 0.5, position, 1000);
}
satchel_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.5, 0.5, position, 1000);
}
barrel_earthQuake() {
  PlayRumbleOnPosition("grenade_rumble", self.origin);
  Earthquake(0.5, 0.5, self.origin, 1000);
}
artillery_earthQuake() {
  PlayRumbleOnPosition("artillery_rumble", self.origin);
  earthquake(0.7, 0.5, self.origin, 800);
}
rocket_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("projectile_impact", weapon_name, position, explosion_radius, rocket_entity);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.5, 0.5, position, 1000);
}
explosive_bolt_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.5, 0.5, position, 1000);
}