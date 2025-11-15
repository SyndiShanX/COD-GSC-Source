/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_ai_napalm.csc
***************************************************/

#include clientscripts\_utility;

init_napalm_zombie() {
  register_clientflag_callback("actor", level._CF_ACTOR_IS_NAPALM_ZOMBIE, ::napalm_zombie_spawn);
  register_clientflag_callback("actor", level._CF_ACTOR_NAPALM_ZOMBIE_EXPLODE, ::napalm_zombie_explode_callback);
  register_clientflag_callback("actor", level._CF_ACTOR_NAPALM_ZOMBIE_WET, ::napalm_zombie_wet_callback);
  level.napalmPlayerWarningRadiusSqr = 400.0;
  level.napalmPlayerWarningRadiusSqr *= level.napalmPlayerWarningRadiusSqr;
  napalm_fx();
}

napalm_fx() {
  level._effect["napalm_fire_forearm"] = LoadFX("maps/zombie_temple/fx_ztem_napalm_zombie_forearm");
  level._effect["napalm_fire_torso"] = LoadFX("maps/zombie_temple/fx_ztem_napalm_zombie_torso");
  level._effect["napalm_distortion"] = LoadFX("maps/zombie_temple/fx_ztem_napalm_zombie_heat");
  level._effect["napalm_fire_forearm_end"] = LoadFX("maps/zombie_temple/fx_ztem_napalm_zombie_torso_end");
  level._effect["napalm_fire_torso_end"] = LoadFX("maps/zombie_temple/fx_ztem_napalm_zombie_forearm_end");
  level._effect["napalm_steam"] = LoadFX("maps/zombie_temple/fx_ztem_zombie_torso_steam_runner");
  level._effect["napalm_feet_steam"] = LoadFX("maps/zombie_temple/fx_ztem_zombie_torso_steam_runner");
}

napalm_zombie_spawn(client_num, set, newEnt) {
  if(set) {
    level.napalm_zombie = self;
    self thread napalm_glow_normal(client_num);
    self thread _napalm_zombie_RunEffects(client_num);
    self thread _napalm_zombie_RunSteamEffects(client_num);
  } else {
    self notify("stop_fx");
    self notify("napalm_killed");
    if(isDefined(self.steam_fx)) {
      self.steam_fx delete();
    }
    level.napalm_zombie = undefined;
  }
}

_napalm_zombie_RunSteamEffects(client_num) {
  self endon("napalm_killed");
  self endon("death");
  self endon("entityshutdown");
  while(1) {
    waterheight = getwaterHeight(self.origin);
    underWater = waterHeight > self.origin[2];
    if((isDefined(self.wet) && self.wet) || underWater) {
      self thread set_footstep_override_for_napalm_zombie(false);
    } else {
      self thread set_footstep_override_for_napalm_zombie(true);
    }
    if(underWater) {
      if(!isDefined(self.steam_fx)) {
        effectEnt = spawn(client_num, self.origin, "script_model");
        effectEnt setModel("tag_origin");
        playFXOnTag(client_num, level._effect["napalm_feet_steam"], effectEnt, "tag_origin");
        self.steam_fx = effectEnt;
      }
      origin = (self.origin[0], self.origin[1], waterHeight);
      self.steam_fx.origin = origin;
    } else {
      if(isDefined(self.steam_fx)) {
        self.steam_fx Delete();
        self.steam_fx = undefined;
      }
    }
    wait .1;
  }
}

_napalm_zombie_RunEffects(client_num) {
  fx = [];
  fx["J_Wrist_RI"] = "napalm_fire_forearm";
  fx["J_Wrist_LE"] = "napalm_fire_forearm";
  fx["J_SpineLower"] = "napalm_fire_torso";
  fx["J_Head"] = "napalm_fire_forearm";
  fx["tag_origin"] = "napalm_distortion";
  offsets["J_SpineLower"] = (0.0, 10.0, 0.0);
  watch = [];
  keys = GetArrayKeys(fx);
  for(i = 0; i < keys.size; i++) {
    jointName = keys[i];
    fxName = fx[jointName];
    offset = offsets[jointName];
    effectEnt = self _zombie_SetupFXOnJoint(client_num, jointName, fxName, offset);
    watch[i] = effectEnt;
  }
  if(isDefined(watch[0])) {
    watch[0] playLoopSound("evt_napalm_zombie_loop", 2);
  }
  self waittill("stop_fx");
  if(isDefined(watch[0])) {
    watch[0] stopLoopSound(.25);
  }
  for(i = 0; i < watch.size; i++) {
    if(isDefined(watch[i])) {
      watch[i] Delete();
    }
  }
}

napalm_zombie_explode_callback(client_num, set, newEnt) {
  self thread napalm_glow_explode(client_num);
  self thread _zombie_RunExplosionWindupEffects(client_num);
}

_zombie_RunExplosionWindupEffects(client_num) {
  fx = [];
  fx["J_Elbow_LE"] = "napalm_fire_forearm_end";
  fx["J_Elbow_RI"] = "napalm_fire_forearm_end";
  fx["J_Clavicle_RI"] = "napalm_fire_forearm_end";
  fx["J_Clavicle_LE"] = "napalm_fire_forearm_end";
  fx["J_SpineLower"] = "napalm_fire_torso_end";
  offsets["J_SpineLower"] = (0.0, 10.0, 0.0);
  watch = [];
  keys = GetArrayKeys(fx);
  for(i = 0; i < keys.size; i++) {
    jointName = keys[i];
    fxName = fx[jointName];
    offset = offsets[jointName];
    effectEnt = self _zombie_SetupFXOnJoint(client_num, jointName, fxName, offset);
    watch[i] = effectEnt;
  }
  self waittill("stop_fx");
  for(i = 0; i < watch.size; i++) {
    if(isDefined(watch[i])) {
      watch[i] Delete();
    }
  }
}

_napalm_zombie_RunWetEffects(client_num) {
  fx = [];
  fx["J_SpineLower"] = "napalm_steam";
  offsets["J_SpineLower"] = (0.0, 10.0, 0.0);
  watch = [];
  keys = GetArrayKeys(fx);
  for(i = 0; i < keys.size; i++) {
    jointName = keys[i];
    fxName = fx[jointName];
    offset = offsets[jointName];
    effectEnt = self _zombie_SetupFXOnJoint(client_num, jointName, fxName, offset);
    watch[i] = effectEnt;
  }
  self waittill("stop_fx");
  for(i = 0; i < watch.size; i++) {
    if(isDefined(watch[i])) {
      watch[i] Delete();
    }
  }
}

_zombie_SetupFXOnJoint(client_num, jointName, fxName, offset) {
  origin = self GetTagOrigin(jointName);
  effectEnt = spawn(client_num, origin, "script_model");
  effectEnt setModel("tag_origin");
  effectEnt.angles = self GetTagAngles(jointName);
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  effectEnt LinkTo(self, jointName, offset);
  playFXOnTag(client_num, level._effect[fxName], effectEnt, "tag_origin");
  return effectEnt;
}

set_footstep_override_for_napalm_zombie(set) {
  if(set) {
    self._footstepOverrideEffect = "napalm_zombie_footstep";
    self.step_sound = "zmb_napalm_step";
  } else {
    self._footstepOverrideEffect = undefined;
    self.step_sound = "zmb_napalm_step";
  }
}

player_napalm_radius_overlay_fade() {
  self endon("death");
  self endon("disconnect");
  self endon("entityshutdown");
  prevFrac = 0.0;
  while(1) {
    frac = 0.0;
    if(!isDefined(level.napalm_zombie) || isDefined(level.napalm_zombie.wet) && level.napalm_zombie.wet ||
      player_can_see_napalm(level.napalm_zombie)) {
      frac = 0.0;
    } else {
      dist_to_napalm = distancesquared(self.origin, level.napalm_zombie.origin);
      if(dist_to_napalm < level.napalmPlayerWarningRadiusSqr) {
        frac = (level.napalmPlayerWarningRadiusSqr - dist_to_napalm) / level.napalmPlayerWarningRadiusSqr;
        frac *= 1.1;
        if(frac > 1.0) {
          frac = 1.0;
        }
      }
    }
    delta = Clamp(frac - prevFrac, -.1, .1);
    frac = prevFrac + delta;
    prevFrac = frac;
    SetSavedDvar("r_flameScaler", frac);
    wait(0.1);
  }
}

player_can_see_napalm(ent_napalm) {
  trace = undefined;
  if(isDefined(level.napalm_zombie)) {
    trace = bulletTrace(self getEye(), level.napalm_zombie.origin, false, self);
    if(isDefined(trace) && trace["fraction"] < 0.85) {
      return true;
    }
  }
  return false;
}

napalm_zombie_wet_callback(client_num, set, newEnt) {
  if(set) {
    self napalm_start_wet_fx(client_num);
  } else {
    self napalm_end_wet_fx(client_num);
  }
}

napalm_start_wet_fx(client_num) {
  self notify("stop_fx");
  self thread _napalm_zombie_RunWetEffects(client_num);
  self.wet = true;
  self thread napalm_glow_wet(client_num);
}

napalm_end_wet_fx(client_num) {
  self notify("stop_fx");
  self thread _napalm_zombie_RunEffects(client_num);
  self.wet = false;
  self thread napalm_glow_normal(client_num);
}

napalm_set_glow(client_num, glowVal) {
  self.glow_val = glowVal;
  self setshaderconstant(client_num, 0, 0, 0, 0, glowVal);
}

napalm_glow_normal(client_num) {
  self thread napalm_glow_lerp(client_num, 2.5);
}

napalm_glow_explode(client_num) {
  self thread napalm_glow_lerp(client_num, 10.0);
}

napalm_glow_wet(client_num) {
  self thread napalm_glow_lerp(client_num, 0.5);
}

napalm_glow_lerp(client_num, glowVal) {
  self notify("glow_lerp");
  self endon("glow_lerp");
  self endon("death");
  self endon("entityshutdown");
  startVal = self.glow_val;
  endVal = glowVal;
  if(isDefined(startVal)) {
    delta = glowVal - self.glow_val;
    lerpTime = 1000;
    startTime = GetRealTime();
    while(startTime + lerpTime > GetRealTime()) {
      s = (GetRealTime() - startTime) / lerpTime;
      newVal = startVal + ((endVal - startVal) * s);
      self napalm_set_glow(client_num, newVal);
      realwait(.05);
    }
  }
  self napalm_set_glow(client_num, endVal);
}