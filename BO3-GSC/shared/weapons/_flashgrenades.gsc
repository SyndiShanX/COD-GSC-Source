/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_flashgrenades.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace flashgrenades;

function init_shared() {
  level.sound_flash_start = "";
  level.sound_flash_loop = "";
  level.sound_flash_stop = "";
  callback::on_connect( & monitorflash);
}

function flashrumbleloop(duration) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  goaltime = gettime() + (duration * 1000);
  while(gettime() < goaltime) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

function monitorflash_internal(amount_distance, amount_angle, attacker, direct_on_player) {
  hurtattacker = 0;
  hurtvictim = 1;
  duration = amount_distance * 3.5;
  min_duration = 2.5;
  max_self_duration = 2.5;
  if(duration < min_duration) {
    duration = min_duration;
  }
  if(isDefined(attacker) && attacker == self) {
    duration = duration / 3;
  }
  if(duration < 0.25) {
    return;
  }
  rumbleduration = undefined;
  if(duration > 2) {
    rumbleduration = 0.75;
  } else {
    rumbleduration = 0.25;
  }
  assert(isDefined(self.team));
  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team && attacker != self) {
    friendlyfire = [[level.figure_out_friendly_fire]](self);
    if(friendlyfire == 0) {
      return;
    }
    if(friendlyfire == 1) {} else {
      if(friendlyfire == 2) {
        duration = duration * 0.5;
        rumbleduration = rumbleduration * 0.5;
        hurtvictim = 0;
        hurtattacker = 1;
      } else if(friendlyfire == 3) {
        duration = duration * 0.5;
        rumbleduration = rumbleduration * 0.5;
        hurtattacker = 1;
      }
    }
  }
  if(self hasperk("specialty_flashprotection")) {
    duration = duration * 0.1;
    rumbleduration = rumbleduration * 0.1;
  }
  if(hurtvictim) {
    if(self util::mayapplyscreeneffect() || (!direct_on_player && self isremotecontrolling())) {
      if(isDefined(attacker) && self != attacker && isplayer(attacker)) {
        attacker addweaponstat(getweapon("flash_grenade"), "hits", 1);
        attacker addweaponstat(getweapon("flash_grenade"), "used", 1);
      }
      self thread applyflash(duration, rumbleduration, attacker);
    }
  }
  if(hurtattacker) {
    if(attacker util::mayapplyscreeneffect()) {
      attacker thread applyflash(duration, rumbleduration, attacker);
    }
  }
}

function monitorflash() {
  self endon("disconnect");
  self endon("killflashmonitor");
  self.flashendtime = 0;
  while(true) {
    self waittill("flashbang", amount_distance, amount_angle, attacker);
    if(!isalive(self)) {
      continue;
    }
    self monitorflash_internal(amount_distance, amount_angle, attacker, 1);
  }
}

function monitorrcbombflash() {
  self endon("death");
  self.flashendtime = 0;
  while(true) {
    self waittill("flashbang", amount_distance, amount_angle, attacker);
    driver = self getseatoccupant(0);
    if(!isDefined(driver) || !isalive(driver)) {
      continue;
    }
    driver monitorflash_internal(amount_distance, amount_angle, attacker, 0);
  }
}

function applyflash(duration, rumbleduration, attacker) {
  if(!isDefined(self.flashduration) || duration > self.flashduration) {
    self.flashduration = duration;
  }
  if(!isDefined(self.flashrumbleduration) || rumbleduration > self.flashrumbleduration) {
    self.flashrumbleduration = rumbleduration;
  }
  self thread playflashsound(duration);
  wait(0.05);
  if(isDefined(self.flashduration)) {
    if(self hasperk("specialty_flashprotection") == 0) {
      self shellshock("flashbang", self.flashduration, 0);
    }
    self.flashendtime = gettime() + (self.flashduration * 1000);
    self.lastflashedby = attacker;
  }
  if(isDefined(self.flashrumbleduration)) {
    self thread flashrumbleloop(self.flashrumbleduration);
  }
  self.flashduration = undefined;
  self.flashrumbleduration = undefined;
}

function playflashsound(duration) {
  self endon("death");
  self endon("disconnect");
  flashsound = spawn("script_origin", (0, 0, 1));
  flashsound.origin = self.origin;
  flashsound linkto(self);
  flashsound thread deleteentonownerdeath(self);
  flashsound playSound(level.sound_flash_start);
  flashsound playLoopSound(level.sound_flash_loop);
  if(duration > 0.5) {
    wait(duration - 0.5);
  }
  flashsound playSound(level.sound_flash_start);
  flashsound stoploopsound(0.5);
  wait(0.5);
  flashsound notify("delete");
  flashsound delete();
}

function deleteentonownerdeath(owner) {
  self endon("delete");
  owner waittill("death");
  self delete();
}