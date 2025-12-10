/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_microwavegun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_microwavegun;

function autoexec __init__sytem__() {
  system::register("zm_weap_microwavegun", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "toggle_microwavegun_hit_response", 21000, 1, "int", &microwavegun_zombie_initial_hit_response, 0, 0);
  clientfield::register("actor", "toggle_microwavegun_expand_response", 21000, 1, "int", &microwavegun_zombie_expand_response, 0, 0);
  clientfield::register("clientuimodel", "hudItems.showDpadLeft_WaveGun", 21000, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "hudItems.dpadLeftAmmo", 21000, 5, "int", undefined, 0, 0);
  level._effect["microwavegun_sizzle_blood_eyes"] = "dlc5/zmb_weapon/fx_sizzle_blood_eyes";
  level._effect["microwavegun_sizzle_death_mist"] = "dlc5/zmb_weapon/fx_sizzle_mist";
  level._effect["microwavegun_sizzle_death_mist_low_g"] = "dlc5/zmb_weapon/fx_sizzle_mist_low_g";
  level thread player_init();
}

function player_init() {
  util::waitforclient(0);
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
  }
}

function microwavegun_create_hit_response_fx(localclientnum, tag, effect) {
  if(!isDefined(self._microwavegun_hit_response_fx[localclientnum][tag])) {
    self._microwavegun_hit_response_fx[localclientnum][tag] = playFXOnTag(localclientnum, effect, self, tag);
  }
}

function microwavegun_delete_hit_response_fx(localclientnum, tag) {
  if(isDefined(self._microwavegun_hit_response_fx[localclientnum][tag])) {
    deletefx(localclientnum, self._microwavegun_hit_response_fx[localclientnum][tag], 0);
    self._microwavegun_hit_response_fx[localclientnum][tag] = undefined;
  }
}

function microwavegun_bloat(localclientnum) {
  self endon("entityshutdown");
  durationmsec = 2500;
  tag_pos = self gettagorigin("J_SpineLower");
  bloat_max_fraction = 1;
  if(!isDefined(tag_pos)) {
    durationmsec = 1000;
  }
  self mapshaderconstant(localclientnum, 0, "scriptVector6", 0, 0, 0, 0);
  begin_time = getrealtime();
  while(true) {
    age = getrealtime() - begin_time;
    bloat_fraction = age / durationmsec;
    if(bloat_fraction > bloat_max_fraction) {
      bloat_fraction = bloat_max_fraction;
    }
    if(!isDefined(self)) {
      return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector6", 4 * bloat_fraction, 0, 0, 0);
    if(bloat_fraction >= bloat_max_fraction) {
      break;
    }
    waitrealtime(0.05);
  }
}

function microwavegun_zombie_initial_hit_response(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.microwavegun_zombie_hit_response)) {
    self[[self.microwavegun_zombie_hit_response]](localclientnum, newval, bnewent);
    return;
  }
  if(localclientnum != 0) {
    return;
  }
  if(!isDefined(self._microwavegun_hit_response_fx)) {
    self._microwavegun_hit_response_fx = [];
  }
  self.microwavegun_initial_hit_response = 1;
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(self._microwavegun_hit_response_fx[i])) {
      self._microwavegun_hit_response_fx[i] = [];
    }
    if(newval) {
      self microwavegun_create_hit_response_fx(i, "J_Eyeball_LE", level._effect["microwavegun_sizzle_blood_eyes"]);
      playSound(0, "wpn_mgun_impact_zombie", self.origin);
    }
  }
}

function microwavegun_zombie_expand_response(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.microwavegun_zombie_hit_response)) {
    self[[self.microwavegun_zombie_hit_response]](localclientnum, newval, bnewent);
    return;
  }
  if(localclientnum != 0) {
    return;
  }
  if(!isDefined(self._microwavegun_hit_response_fx)) {
    self._microwavegun_hit_response_fx = [];
  }
  initial_hit_occurred = isDefined(self.microwavegun_initial_hit_response) && self.microwavegun_initial_hit_response;
  players = getlocalplayers();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(self._microwavegun_hit_response_fx[i])) {
      self._microwavegun_hit_response_fx[i] = [];
    }
    if(newval && initial_hit_occurred) {
      playSound(0, "wpn_mgun_impact_zombie", self.origin);
      self thread microwavegun_bloat(i);
      continue;
    }
    self thread microwavegun_bloat(i);
    if(initial_hit_occurred) {
      self microwavegun_delete_hit_response_fx(i, "J_Eyeball_LE");
    }
    tag_pos = self gettagorigin("J_SpineLower");
    tag_angles = self gettagangles("J_SpineLower");
    if(!isDefined(tag_pos)) {
      tag_pos = self gettagorigin("J_Spine1");
      tag_angles = self gettagangles("J_Spine1");
    }
    fx = level._effect["microwavegun_sizzle_death_mist"];
    if(isDefined(self.in_low_g) && self.in_low_g) {
      fx = level._effect["microwavegun_sizzle_death_mist_low_g"];
    }
    if(isDefined(tag_pos)) {
      playFX(i, fx, tag_pos, anglesToForward(tag_angles), anglestoup(tag_angles));
    }
    playSound(0, "wpn_mgun_explode_zombie", self.origin);
  }
}