/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_mutebomb.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;

CONST_mute_device_radius_min = 350;
CONST_mute_device_radius_max = 600;
CONST_mute_device_timeout = 20;
CONST_mute_device_fade_time = 0.25;

watchMuteBombUsage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.adrenalineSettings)) {
    MuteBombInit();
  }

  while(1) {
    self waittill("grenade_fire", mute_device, weapname);
    if(weapname == "mute_bomb_mp") {
      if(!IsAlive(self)) {
        mute_device delete();
        return;
      }

      thread tryUseMuteBomb(mute_device);
    }
  }
}

MuteBombInit() {
  self.adrenalineSettings = spawnStruct();
}

tryUseMuteBomb(mute_device) {
  if(!isDefined(self.adrenalineSettings)) {
    MuteBombInit();
  }

  thread StartMuteBomb(mute_device);
  thread MonitorPlayerDeath(mute_device);
  mute_device thread MonitorMuteBombDeath();

  return true;
}

StartMuteBomb(mute_device) {
  self endon("ClearMuteBomb");
  self endon("death");
  mute_device endon("death");

  mute_device playSound("mute_device_activate");
  wait(0.75);

  mute_device AddSoundMuteDevice(CONST_mute_device_radius_min, CONST_mute_device_radius_max, CONST_mute_device_fade_time);
  mute_device playLoopSound("mute_device_active_lp");
  mute_device thread MonitorMuteBombPlayers();

  wait(CONST_mute_device_timeout);

  mute_device ScaleVolume(0.0, CONST_mute_device_fade_time);
  mute_device RemoveSoundMuteDevice(CONST_mute_device_fade_time);
  mute_device notify("ShutdownMuteBomb");

  wait(CONST_mute_device_fade_time);

  mute_device StopLoopSound();
}

MonitorPlayerDeath(mute_device) {
  mute_device endon("ShutdownMuteBomb");

  self waittill("death");

  if(isDefined(mute_device)) {
    mute_device RemoveSoundMuteDevice(CONST_mute_device_fade_time);
    mute_device notify("ShutdownMuteBomb");
  }
}

MonitorMuteBombDeath() {
  self endon("ShutdownMuteBomb");

  self waittill("death");

  if(isDefined(self)) {
    self RemoveSoundMuteDevice(CONST_mute_device_fade_time);
    self notify("ShutdownMuteBomb");
  }
}

MonitorMuteBombPlayers() {
  self endon("ShutdownMuteBomb");

  radius = CONST_mute_device_radius_min + ((CONST_mute_device_radius_max - CONST_mute_device_radius_min) / 2);

  self.touchingPlayers = [];

  while(1) {
    foreach(player in level.players) {
      dist = Distance(self.origin, player.origin);
      touching = array_contains(self.touchingPlayers, player);

      if(dist <= radius) {
        if(!touching) {
          self.touchingPlayers = array_add(self.touchingPlayers, player);
          player PlayLocalSound("mute_device_active_enter");
        }
      } else {
        if(touching) {
          self.touchingPlayers = array_remove(self.touchingPlayers, player);
          player PlayLocalSound("mute_device_active_exit");
        }
      }
    }

    wait(0.05);
  }
}