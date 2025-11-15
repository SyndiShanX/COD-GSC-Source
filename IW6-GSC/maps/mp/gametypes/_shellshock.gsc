/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_shellshock.gsc
*********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level._effect["slide_dust"] = LoadFX("vfx/gameplay/screen_effects/vfx_scrnfx_tocam_slidedust_m");
  level._effect["hit_left"] = LoadFX("vfx/gameplay/screen_effects/vfx_blood_hit_left");
  level._effect["hit_right"] = LoadFX("vfx/gameplay/screen_effects/vfx_blood_hit_right");
  level._effect["melee_spray"] = LoadFX("vfx/gameplay/screen_effects/vfx_melee_blood_spray");
}

shellshockOnDamage(cause, damage) {
  if(self maps\mp\_flashgrenades::isFlashbanged()) {
    return;
  }
  if(cause == "MOD_EXPLOSIVE" ||
    cause == "MOD_GRENADE" ||
    cause == "MOD_GRENADE_SPLASH" ||
    cause == "MOD_PROJECTILE" ||
    cause == "MOD_PROJECTILE_SPLASH") {
    if(damage > 10) {
      if(isDefined(self.shellShockReduction) && self.shellShockReduction)
        self shellshock("frag_grenade_mp", self.shellShockReduction);
      else
        self shellshock("frag_grenade_mp", 0.5);
    }
  }
}

endOnDeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

grenade_earthQuake() {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");

  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.5, 0.75, position, 800);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }
    if(DistanceSquared(position, player.origin) > 600 * 600) {
      continue;
    }
    if(player DamageConeTrace(position))
      player thread dirtEffect(position);

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

  if(fDot > 0 && fDot > 0.5) {} else if(abs(fDot) < 0.866) {
    fx = level._effect["hit_left"];

    if(rDot > 0)
      fx = level._effect["hit_right"];

    string_array = ["death", "damage"];
    self thread play_fx_with_entity(fx, string_array, 7.0);
  }
}

bloodMeleeEffect() {
  self endon("disconnect");

  wait(0.5);

  string_array = ["death"];
  self thread play_fx_with_entity(level._effect["melee_spray"], string_array, 1.5);
}

play_fx_with_entity(fx, string_array, timeout) {
  self endon("disconnect");

  blood_effect_ent = SpawnFXForClient(fx, self getEye(), self);
  TriggerFX(blood_effect_ent);
  blood_effect_ent SetFXKillDefOnDelete();

  self waittill_any_in_array_or_timeout(string_array, timeout);

  blood_effect_ent delete();
}

c4_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");
  self waittill("explode", position);
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.4, 0.75, position, 512);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }
    if(distance(position, player.origin) > 512) {
      continue;
    }
    if(player DamageConeTrace(position))
      player thread dirtEffect(position);

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

barrel_earthQuake() {
  position = self.origin;
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.4, 0.5, position, 512);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }
    if(distance(position, player.origin) > 512) {
      continue;
    }
    if(player DamageConeTrace(position))
      player thread dirtEffect(position);

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

artillery_earthQuake() {
  position = self.origin;
  PlayRumbleOnPosition("artillery_rumble", self.origin);
  Earthquake(0.7, 0.5, self.origin, 800);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }
    if(distance(position, player.origin) > 600) {
      continue;
    }
    if(player DamageConeTrace(position))
      player thread dirtEffect(position);

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

stealthAirstrike_earthQuake(position) {
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(1.0, 0.6, position, 2000);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }
    if(distance(position, player.origin) > 1000) {
      continue;
    }
    if(player DamageConeTrace(position))
      player thread dirtEffect(position);

    player SetClientOmnvar("ui_hud_shake", true);
  }
}

airstrike_earthQuake(position) {
  PlayRumbleOnPosition("artillery_rumble", position);
  Earthquake(0.7, 0.75, position, 1000);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }
    if(distance(position, player.origin) > 900) {
      continue;
    }
    if(player DamageConeTrace(position))
      player thread dirtEffect(position);

    player SetClientOmnvar("ui_hud_shake", true);
  }
}