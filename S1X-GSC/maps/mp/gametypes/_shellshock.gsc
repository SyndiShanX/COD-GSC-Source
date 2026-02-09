/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_shellshock.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {}

shellshockOnDamage(cause, damage) {
  if(self maps\mp\_flashgrenades::isFlashbanged()) {
    return;
  }

  if(self isUsingRemote() || self isInRemoteTransition()) {
    return;
  }

  if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
    if(damage > 10) {
      if(!_hasPerk("specialty_hard_shell")) {
        self shellshock("frag_grenade_mp", 0.5);
      }
    }
  }
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
  Earthquake(0.5, 0.75, position, 800);

  foreach(player in level.players) {
    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    if(DistanceSquared(position, player.origin) > 600 * 600) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

dirtEffect(position) {
  self notify("dirtEffect");
  self endon("dirtEffect");

  self endon("disconnect");

  if(!isReallyAlive(self)) {
    return;
  }

  forwardVec = VectorNormalize(anglesToForward(self.angles));
  rightVec = VectorNormalize(AnglesToRight(self.angles));
  grenadeVec = VectorNormalize(position - self.origin);

  fDot = VectorDot(grenadeVec, forwardVec);
  rDot = VectorDot(grenadeVec, rightVec);

  if(GetDvarInt("g_debugDamage")) {
    PrintLn(fDot);
    PrintLn(rDot);
  }

  string_array = ["death", "damage"];

  if(fDot > 0 && fDot > 0.5 && self GetCurrentWeapon() != "iw6_riotshield_mp") {
    self waittill_any_in_array_or_timeout(string_array, 2.0);
  } else if(abs(fDot) < 0.866) {
    if(rDot > 0) {
      self waittill_any_in_array_or_timeout(string_array, 2.0);
    } else {
      self waittill_any_in_array_or_timeout(string_array, 2.0);
    }
  }
}

bloodEffect(position) {
  self notify("bloodEffect");
  self endon("bloodEffect");

  self endon("disconnect");

  if(!isReallyAlive(self)) {
    return;
  }

  forwardVec = VectorNormalize(anglesToForward(self.angles));
  rightVec = VectorNormalize(AnglesToRight(self.angles));
  damageVec = VectorNormalize(position - self.origin);

  fDot = VectorDot(damageVec, forwardVec);
  rDot = VectorDot(damageVec, rightVec);

  if(GetDvarInt("g_debugDamage")) {
    PrintLn(fDot);
    PrintLn(rDot);
  }

  string_array = ["death", "damage"];

  if(fDot > 0 && fDot > 0.5) {
    self waittill_any_in_array_or_timeout(string_array, 7.0);
  } else if(abs(fDot) < 0.866) {
    if(rDot > 0) {
      self waittill_any_in_array_or_timeout(string_array, 7.0);
    } else {
      self waittill_any_in_array_or_timeout(string_array, 7.0);
    }
  }
}

bloodMeleeEffect() {
  self endon("disconnect");

  wait(0.5);

  if(IsAlive(self)) {
    self waittill_notify_or_timeout("death", 1.5);
  }
}

c4_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.4, 0.75, position, 512);

  foreach(player in level.players) {
    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    if(distance(position, player.origin) > 512) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

barrel_earthQuake() {
  position = self.origin;
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.4, 0.5, position, 512);

  foreach(player in level.players) {
    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    if(distance(position, player.origin) > 512) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

artillery_earthQuake() {
  position = self.origin;
  PlayRumbleOnPosition("artillery_rumble", self.origin);
  Earthquake(0.7, 0.5, self.origin, 800);

  foreach(player in level.players) {
    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    if(distance(position, player.origin) > 600) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

stealthAirstrike_earthQuake(position) {
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.6, 0.6, position, 2000);

  foreach(player in level.players) {
    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    if(distance(position, player.origin) > 1000) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

airstrike_earthQuake(position) {
  PlayRumbleOnPosition("artillery_rumble", position);
  Earthquake(0.7, 0.75, position, 1000);

  foreach(player in level.players) {
    if(player isUsingRemote() || player isInRemoteTransition()) {
      continue;
    }

    if(distance(position, player.origin) > 900) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }

    player SetClientOmnvar("ui_hud_shake", true);
  }
}