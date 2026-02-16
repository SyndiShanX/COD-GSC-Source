/******************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\streak_mp_recovery.gsc
******************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.mp_recovery_killstreak = spawnStruct();
  level.mp_recovery_killstreak.killstreak_InUse = false;
  level.mp_recovery_killstreak.killstreak_duration = 25;
  level.mp_recovery_killstreak.speed_scale = 1.25;
  level.mp_recovery_killstreak.health_scale = 1.75;
  level.mp_recovery_killstreak.max_health_amplify_object = 1500;
  level.mp_recovery_killstreak.exo_super_vfx = LoadFX("vfx/lights/air_light_exosuper_yellow");
  level.mp_recovery_killstreak.amplify_vfx = LoadFX("vfx/lights/air_light_amplifymachine_yellow");

  amplify_ring_side_01 = getent("damage_ring_01", "targetname");
  amplify_ring_side_02 = getent("damage_ring_02", "targetname");
  level.mp_recovery_killstreak.DamageRingsArray = [amplify_ring_side_01, amplify_ring_side_02];

  foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
    damage_ring HudOutlineEnable(1, true);
    damage_ring setCanDamage(true);
    damage_ring setCanRadiusDamage(true);
    damage_ring.Max_fake_health = level.mp_recovery_killstreak.max_health_amplify_object;
    damage_ring.health = damage_ring.Max_fake_health;
    damage_ring.maxhealth = damage_ring.Max_fake_health;
    damage_ring.fakehealth = damage_ring.Max_fake_health;

    VFX_points = getStructArray(damage_ring.target, "targetname");
    damage_ring.tag_array = [];
    foreach(VFX_point in VFX_points) {
      tag = spawn_tag_origin();
      tag.origin = VFX_point.origin;
      tag show();
      damage_ring.tag_array[damage_ring.tag_array.size] = tag;
    }
  }

  precacheString(&"KILLSTREAKS_MP_RECOVERY");

  level.killStreakFuncs["mp_recovery"] = ::tryUseMpRecovery;
  level.mapKillStreak = "mp_recovery";

  level thread onRecoveryPlayerConnect();
}

tryUseMpRecovery(lifeId, modules) {
  if(level.mp_recovery_killstreak.killstreak_InUse) {
    self iPrintLnBold(&"MP_RECOVERY_IN_USE");
    return false;
  }

  if(self isUsingRemote()) {
    return false;
  }

  if(self isAirDenied()) {
    return false;
  }

  if(self isEMPed()) {
    return false;
  }

  result = exoTeamBuffSetup(self);

  if(isDefined(result) && result) {
    self maps\mp\_matchdata::logKillstreakEvent("mp_recovery", self.origin);
  }

  return result;
}

exoTeamBuffSetup(owner) {
  if(isDefined(owner)) {
    level.mp_recovery_killstreak.killstreak_InUse = true;
    level.mp_recovery_killstreak.owner = owner;
    level.mp_recovery_killstreak.killstreak_team = owner.team;
  } else {
    return false;
  }

  killstreakTeam = owner.team;

  thread StartExoRecoveryKillstreak(owner, killstreakTeam);

  return true;
}

StartExoRecoveryKillstreak(owner, killstreakTeam) {
  SetupAmplifierDamageMonitor(owner, killstreakTeam);

  SortPlayersAndGivePowers(owner, killstreakTeam);
  thread SetMapKillstreakTimer();

  level waittill_any("time_up", "amplifier_destroyed");

  ShutOffAmplifyObjectVFX();
  ShutOffAllPlayersExoBuffs();

  level notify("recovery_streak_over");

  wait(0.25);

  level.mp_recovery_killstreak.killstreak_InUse = false;
}

SetMapKillstreakTimer() {
  level endon("recovery_streak_over");

  wait(level.mp_recovery_killstreak.killstreak_duration);

  level notify("time_up");
}

SetupAmplifierDamageMonitor(owner, killstreakTeam) {
  faction = "atlas";
  teamToShow = "axis";

  if(killstreakTeam == "axis") {
    faction = "atlas";
    teamToShow = "allies";
  } else if(killstreakTeam == "allies") {
    faction = "sentinel";
    teamToShow = "axis";
  }
  AmplifyIconArt = "faction_128_" + faction;

  foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
    damage_ring setCanDamage(true);
    damage_ring setCanRadiusDamage(true);
    damage_ring.health = damage_ring.Max_fake_health;
    damage_ring.maxhealth = damage_ring.Max_fake_health;
    damage_ring.fakehealth = damage_ring.Max_fake_health;

    damage_ring thread StartAmplifyObjectVFX();
    damage_ring thread MonitorAmplifierDamage(owner, killstreakTeam);

    if(level.DynamicEventStatus == "before" && damage_ring.targetname == "damage_ring_02") {
      continue;
    } else if(level.DynamicEventStatus == "after" && damage_ring.targetname == "damage_ring_01") {
      continue;
    }

    if(level.teamBased == false) {
      foreach(player in level.players) {
        if(player != owner) {
          damage_ring maps\mp\_entityheadIcons::setHeadIcon(player, AmplifyIconArt, (0, 0, 0), 18, 18, undefined, undefined, undefined, true, false, false);
        }
      }
    } else if(level.teamBased == true) {
      damage_ring maps\mp\_entityheadIcons::setHeadIcon(teamToShow, AmplifyIconArt, (0, 0, 0), 18, 18, undefined, undefined, undefined, true, false, false);
    }
  }
}

MonitorAmplifierDamage(owner, killstreakTeam) {
  level endon("recovery_streak_over");

  while(level.mp_recovery_killstreak.killstreak_InUse == true) {
    self waittill("damage", amount, attacker, direction, point, means_of_death, model, tag, part_name, damage_flags, weapon_name);

    if(!IsValidStreakPlayer(attacker, owner, killstreakTeam)) {
      self.fakehealth += (amount * -1);
      if(self.fakehealth <= 0) {
        level notify("amplifier_destroyed");
        return;
      }
    }
  }
}

StartAmplifyObjectVFX() {
  foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
    foreach(tag in damage_ring.tag_array) {
      playFXOnTag(level.mp_recovery_killstreak.amplify_vfx, tag, "tag_origin");
    }
  }
}

ShutOffAmplifyObjectVFX() {
  ShutOffPlayerHUDOutline();
  foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
    damage_ring destroyPlayerIcons();
    foreach(tag in damage_ring.tag_array) {
      stopFXOnTag(level.mp_recovery_killstreak.amplify_vfx, tag, "tag_origin");
    }
  }
}

destroyPlayerIcons() {
  if(isDefined(self.entityHeadIcons)) {
    if(isDefined(self.entityHeadIcons["allies"])) {
      self.entityHeadIcons["allies"] destroy();
      self.entityHeadIcons["allies"] = undefined;
    }
    if(isDefined(self.entityHeadIcons["axis"])) {
      self.entityHeadIcons["axis"] destroy();
      self.entityHeadIcons["axis"] = undefined;
    }
    foreach(player in level.players) {
      if(isDefined(self.entityHeadIcons[player.guid])) {
        self.entityHeadIcons[player.guid] destroy();
        self.entityHeadIcons[player.guid] = undefined;
      }
    }
  }
}

ShutOffPlayerHUDOutline() {
  foreach(player in level.players) {
    foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
      damage_ring HudOutlineDisableForClient(player);
    }
  }
}

TurnOnPlayerHUDOutline(owner, killstreakTeam) {
  foreach(player in level.players) {
    if(!IsValidStreakPlayer(player, owner, killstreakTeam)) {
      foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
        damage_ring HudOutlineEnableForClient(player, 1, true);
      }
    }
  }
}

SortPlayersAndGivePowers(owner, killstreakTeam) {
  foreach(player in level.players) {
    if(IsValidStreakPlayer(player, owner, killstreakTeam) == true) {
      if(isReallyAlive(player)) {
        player SetupSuperExo();
        player thread GiveSuperExo();
      }
    }

    player thread MonitorSpawnDurringStreak(owner, killstreakTeam);
  }

  thread MonitorConnectedDuringStreak(owner, killstreakTeam);
}

ShutOffAllPlayersExoBuffs() {
  foreach(player in level.players) {
    player ShutOffExoBuffs();
  }
}

ShutOffExoBuffs() {
  if(isDefined(self.SuperExoSettings) && isDefined(self.SuperExoSettings.IsActive)) {
    self.SuperExoSettings.IsActive = false;
  }
  self ShutOffSpeed();
  self ShutOffFX();
  self ShutOffHealth();
  self ShutOffSlam();
}

ShutOffSlam() {
  if(isDefined(self.CAC_has_slam) && self.CAC_has_slam == true) {} else {
    if(self _hasPerk("specialty_exo_slamboots")) {
      _unsetPerk("specialty_exo_slamboots");
    }
  }
  self.CAC_has_slam = undefined;
}

ShutOffSpeed() {
  self.moveSpeedScaler = level.basePlayerMoveScale;
  if(self _hasPerk("specialty_lightweight")) {
    self.moveSpeedScaler = lightWeightScalar();
  }
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

ShutOffHealth() {
  self.maxhealth = int(self.maxhealth / level.mp_recovery_killstreak.health_scale);

  if(self.health > self.maxhealth) {
    self.health = self.maxhealth;
  }

  self.healthRegenLevel = undefined;
}

ShutOffFX() {
  if(isDefined(self.SuperExoSettings) && isDefined(self.SuperExoSettings.overlay)) {
    self.SuperExoSettings.overlay Destroy();
  }

  if(isDefined(level.mp_recovery_killstreak.exo_super_vfx)) {
    if(isReallyAlive(self)) {
      stopFXOnTag(level.mp_recovery_killstreak.exo_super_vfx, self, "tag_shield_back");
      stopFXOnTag(level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_le");
      stopFXOnTag(level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_ri");
    }
  }
}

GiveSuperExo() {
  self SetupSuperExo();
  self.SuperExoSettings.IsActive = true;
  self GiveSuperSpeed();
  self GiveSuperHealth();
  self GiveSuperStomp();
  self GiveSuperPunch();
  self GiveSuperRepulse();
  self TurnOnSuperFX();

  self thread WatchForDeath();
}

WatchForDeath() {
  level endon("game_ended");
  level endon("recovery_streak_over");
  self endon("disconnect");

  self waittill("death");
  if(level.mp_recovery_killstreak.killstreak_InUse == true) {
    self ShutOffExoBuffs();
  }
}

GiveSuperSpeed() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  self.moveSpeedScaler = level.mp_recovery_killstreak.speed_scale;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

GiveSuperHealth() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  self.maxhealth = int(self.maxhealth * level.mp_recovery_killstreak.health_scale);
  self.ignoreRegenDelay = true;
  self.healthRegenLevel = .99;
  self notify("damage");
}
GiveSuperStomp() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  self.CAC_has_slam = undefined;

  if(self _hasPerk("specialty_exo_slamboots")) {
    self.CAC_has_slam = true;
  } else {
    self givePerk("specialty_exo_slamboots", false);
    self.CAC_has_slam = false;
  }
}

GiveSuperPunch() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
}

GiveSuperRepulse() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  self thread maps\mp\_exo_repulsor::do_exo_repulsor();
}

TurnOnSuperFX() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");

  if(!isDefined(self.SuperExoSettings.overlay)) {
    self.SuperExoSettings.overlay = NewClientHudElem(self);
    self.SuperExoSettings.overlay.x = 0;
    self.SuperExoSettings.overlay.y = 0;
    self.SuperExoSettings.overlay.horzAlign = "fullscreen";
    self.SuperExoSettings.overlay.vertAlign = "fullscreen";
    self.SuperExoSettings.overlay SetShader("exo_hud_cloak_overlay", 640, 480);
    self.SuperExoSettings.overlay.archive = true;
    self.SuperExoSettings.overlay.alpha = 1.0;
  }

  if(isDefined(level.mp_recovery_killstreak.exo_super_vfx)) {
    playFXOnTag(level.mp_recovery_killstreak.exo_super_vfx, self, "tag_shield_back");
    playFXOnTag(level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_le");
    playFXOnTag(level.mp_recovery_killstreak.exo_super_vfx, self, "j_knee_ri");
  }
}

SetupSuperExo() {
  if(!isDefined(self.SuperExoSettings)) {
    self.SuperExoSettings = spawnStruct();
  }

  if(!isDefined(level.mp_recovery_killstreak.exo_super_vfx)) {
    level.mp_recovery_killstreak.exo_super_vfx = LoadFX("vfx/lights/air_light_exosuper_yellow");
  }
  self.SuperExoSettings.IsActive = false;
}

IsValidStreakPlayer(player, owner, killstreakTeam) {
  if(level.teamBased == false && isDefined(owner) && player == owner) {
    return true;
  } else if(level.teamBased == true && player.team == killstreakTeam) {
    return true;
  } else {
    return false;
  }
}

MonitorSpawnDurringStreak(owner, killstreakTeam) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("recovery_streak_over");

  while(level.mp_recovery_killstreak.killstreak_InUse == true) {
    self waittill("spawned_player");

    if(IsValidStreakPlayer(self, owner, killstreakTeam) == true) {
      wait(0.25);
      if(level.mp_recovery_killstreak.killstreak_InUse == true) {
        self SetupSuperExo();
        self thread GiveSuperExo();
      }
    }
  }
}

MonitorConnectedDuringStreak(owner, killstreakTeam) {
  level endon("game_ended");
  level endon("recovery_streak_over");

  while(level.mp_recovery_killstreak.killstreak_InUse == true) {
    level waittill("connected", player);

    player MonitorSpawnDurringStreak(owner, killstreakTeam);
  }
}

onRecoveryPlayerConnect() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    foreach(damage_ring in level.mp_recovery_killstreak.DamageRingsArray) {
      damage_ring HudOutlineDisableForClient(player);
    }
    player thread onRecoveryPlayerDisconnect();
  }
}

onRecoveryPlayerDisconnect() {
  level endon("game_ended");

  self waittill("disconnect");
}