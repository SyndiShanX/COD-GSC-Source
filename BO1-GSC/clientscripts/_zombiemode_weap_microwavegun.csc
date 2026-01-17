/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_weap_microwavegun.csc
***********************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;

init() {
  if(getDvar(#"createfx") == "on") {
    return;
  }
  if(!clientscripts\_zombiemode_weapons::is_weapon_included("microwavegundw_zm")) {
    return;
  }
  level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_INITIAL_HIT_RESPONSE = 6;
  register_clientflag_callback("actor", level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_INITIAL_HIT_RESPONSE, ::microwavegun_zombie_initial_hit_response);
  level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_EXPAND_RESPONSE = 9;
  register_clientflag_callback("actor", level._ZOMBIE_ACTOR_FLAG_MICROWAVEGUN_EXPAND_RESPONSE, ::microwavegun_zombie_expand_response);
  level._effect["microwavegun_sizzle_blood_eyes"] = loadfx("weapon/microwavegun/fx_sizzle_blood_eyes");
  level._effect["microwavegun_sizzle_death_mist"] = loadfx("weapon/microwavegun/fx_sizzle_mist");
  level._effect["microwavegun_sizzle_death_mist_low_g"] = loadfx("weapon/microwavegun/fx_sizzle_mist_low_g");
  level thread player_init();
}

player_init() {
  waitforclient(0);
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
  }
}

microwavegun_create_hit_response_fx(localClientNum, tag, effect) {
  if(!isDefined(self._microwavegun_hit_response_fx[localClientNum][tag])) {
    self._microwavegun_hit_response_fx[localClientNum][tag] = playFXOnTag(localClientNum, effect, self, tag);
  }
}

microwavegun_delete_hit_response_fx(localClientNum, tag) {
  if(isDefined(self._microwavegun_hit_response_fx[localClientNum][tag])) {
    DeleteFx(localClientNum, self._microwavegun_hit_response_fx[localClientNum][tag], false);
    self._microwavegun_hit_response_fx[localClientNum][tag] = undefined;
  }
}

microwavegun_bloat(localClientNum) {
  self endon("entityshutdown");
  durationMsec = 2500;
  tag_pos = self gettagorigin("J_SpineLower");
  bloat_max_fraction = 1.0;
  if(!isDefined(tag_pos)) {
    durationMsec = 1000;
  }
  self mapshaderconstant(localClientNum, 0, "scriptVector3");
  begin_time = GetRealTime();
  while(1) {
    age = GetRealTime() - begin_time;
    bloat_fraction = age / durationMsec;
    if(bloat_fraction > bloat_max_fraction)
      bloat_fraction = bloat_max_fraction;
    if(!isDefined(self)) {
      return;
    }
    self setshaderconstant(localClientNum, 0, (bloat_fraction * 4.0), 0, 0, 0);
    if(bloat_fraction >= bloat_max_fraction) {
      break;
    }
    realwait(0.05);
  }
}

microwavegun_zombie_initial_hit_response(localClientNum, set, newEnt) {
  if(isDefined(self.microwavegun_zombie_hit_response)) {
    self[[self.microwavegun_zombie_hit_response]](localClientNum, set, newEnt);
    return;
  }
  if(localClientNum != 0) {
    return;
  }
  if(!isDefined(self._microwavegun_hit_response_fx)) {
    self._microwavegun_hit_response_fx = [];
  }
  self.microwavegun_initial_hit_response = true;
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(self._microwavegun_hit_response_fx[i])) {
      self._microwavegun_hit_response_fx[i] = [];
    }
    if(set) {
      self microwavegun_create_hit_response_fx(i, "J_Eyeball_LE", level._effect["microwavegun_sizzle_blood_eyes"]);
      playSound(0, "wpn_mgun_impact_zombie", self.origin);
    }
  }
}

microwavegun_zombie_expand_response(localClientNum, set, newEnt) {
  if(isDefined(self.microwavegun_zombie_hit_response)) {
    self[[self.microwavegun_zombie_hit_response]](localClientNum, set, newEnt);
    return;
  }
  if(localClientNum != 0) {
    return;
  }
  if(!isDefined(self._microwavegun_hit_response_fx)) {
    self._microwavegun_hit_response_fx = [];
  }
  initial_hit_occurred = isDefined(self.microwavegun_initial_hit_response) && self.microwavegun_initial_hit_response;
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(self._microwavegun_hit_response_fx[i])) {
      self._microwavegun_hit_response_fx[i] = [];
    }
    if(set && initial_hit_occurred) {
      playSound(0, "wpn_mgun_impact_zombie", self.origin);
      self thread microwavegun_bloat(i);
    } else {
      if(initial_hit_occurred) {
        self microwavegun_delete_hit_response_fx(i, "J_Eyeball_LE");
      }
      tag_pos = self gettagorigin("J_SpineLower");
      if(!isDefined(tag_pos)) {
        tag_pos = self gettagorigin("J_Spine1");
      }
      fx = level._effect["microwavegun_sizzle_death_mist"];
      if(isDefined(self.in_low_g) && self.in_low_g) {
        fx = level._effect["microwavegun_sizzle_death_mist_low_g"];
      }
      playFX(i, fx, tag_pos);
      playSound(0, "wpn_mgun_explode_zombie", self.origin);
    }
  }
}