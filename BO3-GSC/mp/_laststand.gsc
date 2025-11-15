/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_laststand.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\gametypes\_globallogic_player;
#using scripts\mp\gametypes\_globallogic_spawn;
#using scripts\mp\gametypes\_killcam;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\abilities\gadgets\_gadget_resurrect;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\killcam_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace laststand;

function autoexec __init__sytem__() {
  system::register("laststand", & __init__, undefined, undefined);
}

function __init__() {
  if(level.script == "frontend") {
    return;
  }
}

function player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(attacker) && isplayer(attacker) && attacker != self) {
    attacker.kills++;
    if(isDefined(weapon)) {
      dmgweapon = weapon;
      weaponpickedup = 0;
      if(isDefined(attacker.pickedupweapons) && isDefined(attacker.pickedupweapons[weapon])) {
        weaponpickedup = 1;
      }
      attacker addweaponstat(dmgweapon, "kills", 1, attacker.class_num, weaponpickedup);
    }
  }
  self.downs++;
}

function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride) {
  if(self player_is_in_laststand()) {
    return;
  }
  if(isDefined(self.resurrect_not_allowed_by)) {
    return;
  }
  self globallogic_player::callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, 0, 1);
  self notify("entering_last_stand");
  if(isDefined(level._game_module_player_laststand_callback)) {
    self[[level._game_module_player_laststand_callback]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
  }
  self.laststandparams = spawnStruct();
  self.laststandparams.einflictor = einflictor;
  self.laststandparams.attacker = attacker;
  self.laststandparams.idamage = idamage;
  self.laststandparams.smeansofdeath = smeansofdeath;
  self.laststandparams.sweapon = weapon;
  self.laststandparams.vdir = vdir;
  self.laststandparams.shitloc = shitloc;
  self.laststandparams.laststandstarttime = gettime();
  self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
  self thread player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
  self.health = 1;
  self.laststand = 1;
  self.ignoreme = 1;
  self enableinvulnerability();
  self.meleeattackers = undefined;
  self.no_revive_trigger = 1;
  callback::callback("hash_6751ab5b");
  assert(isDefined(self.resurrect_weapon));
  assert(self.resurrect_weapon != level.weaponnone);
  slot = self ability_util::gadget_slot_for_type(40);
  self gadgetstatechange(slot, self.resurrect_weapon, 2);
  self laststand_disable_player_weapons();
  self thread makesureswitchtoweapon();
  self thread resurrect::enter_rejack_standby();
  self thread watch_player_input();
  demo::bookmark("player_downed", gettime(), self);
}

function makesureswitchtoweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("bleed_out");
  self endon("player_input_revive");
  self endon("player_input_suicide");
  level endon("game_ended");
  while(true) {
    if(self getcurrentweapon() != self.resurrect_weapon) {
      self switchtoweapon(self.resurrect_weapon);
    }
    wait(0.05);
  }
}

function laststand_disable_player_weapons() {
  weaponinventory = self getweaponslist(1);
  self.lastactiveweapon = self getcurrentweapon();
  if(self isthrowinggrenade()) {
    primaryweapons = self getweaponslistprimaries();
    if(isDefined(primaryweapons) && primaryweapons.size > 0) {
      self.lastactiveweapon = primaryweapons[0];
      self switchtoweaponimmediate(self.lastactiveweapon);
    }
  }
}

function laststand_enable_player_weapons(b_allow_grenades = 1) {
  self enableweaponcycling();
  if(b_allow_grenades) {
    self enableoffhandweapons();
  }
  if(isDefined(self.lastactiveweapon) && self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon)) {
    self switchtoweapon(self.lastactiveweapon);
  } else {
    primaryweapons = self getweaponslistprimaries();
    if(isDefined(primaryweapons) && primaryweapons.size > 0) {
      self switchtoweapon(primaryweapons[0]);
    }
  }
}

function laststand_clean_up_on_interrupt(playerbeingrevived, revivergun) {
  self endon("do_revive_ended_normally");
  revivetrigger = playerbeingrevived.revivetrigger;
  playerbeingrevived util::waittill_any("disconnect", "game_ended", "death");
  if(isDefined(revivetrigger)) {
    revivetrigger delete();
  }
  self cleanup_suicide_hud();
  if(isDefined(self.reviveprogressbar)) {
    self.reviveprogressbar hud::destroyelem();
  }
  if(isDefined(self.revivetexthud)) {
    self.revivetexthud destroy();
  }
}

function laststand_clean_up_reviving_any(playerbeingrevived) {
  self endon("do_revive_ended_normally");
  playerbeingrevived util::waittill_any("disconnect", "zombified", "stop_revive_trigger");
  self.is_reviving_any--;
  if(0 > self.is_reviving_any) {
    self.is_reviving_any = 0;
  }
}

function bleed_out() {
  demo::bookmark("player_bledout", gettime(), self, undefined, 1);
  level notify("bleed_out", self.characterindex);
  self undolaststand();
  self.ignoreme = 0;
  self.laststand = undefined;
  self.uselaststandparams = 1;
  if(!isDefined(self.laststandparams.attacker)) {
    self.laststandparams.attacker = self;
  }
  self suicide();
}

function watch_player_input() {
  self thread watch_player_input_revive();
  self thread watch_player_input_suicide();
}

function watch_player_input_revive() {
  level endon("game_ended");
  self endon("player_input_bleed_out");
  self endon("disconnect");
  self endon("death");
  self waittill("player_input_revive");
  demo::bookmark("player_revived", gettime(), self, self);
  self rejack();
  self laststand_enable_player_weapons();
  self.ignoreme = 0;
  self disableinvulnerability();
  self.laststand = undefined;
}

function watch_player_input_suicide() {
  level endon("game_ended");
  self endon("player_input_revive");
  self endon("disconnect");
  self endon("death");
  self waittill("player_input_suicide");
  self bleed_out();
}