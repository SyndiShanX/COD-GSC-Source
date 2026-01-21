/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_tvguidedmissile.gsc
****************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_globallogic_utils;

init() {
  precacheShader("tow_overlay");
  precacheShader("tow_filter_overlay");
  precacheShader("tow_filter_overlay_no_signal");
  PreCacheString(&"MP_GUIDED_MISSILE_LOSING_SIGNAL");
  SetDvar("scr_guidedMissileMaxHeight", "4000");
  level.GuidedMissileMaxHight = getDvarIntDefault("scr_guidedMissileMaxHeight", 4000);
  level thread onPlayerConnect();
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread OnPlayerSpawned();
  }
}
OnPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self thread watchForGuidedMissileFire();
  }
}
watchForGuidedMissileFire() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("missile_fire", missile, weap);
    switch (weap) {
      case "m220_tow_mp":
        self setupGuidedMissile(missile);
        break;
      default:
        break;
    }
  }
}
setupGuidedMissile(missile) {
  self StopShellshock();
  self LinkGuidedMissileCamera();
  self thread guidedMissileOverlay();
  missile thread MissileDeathWatcher(self);
  missile thread MissileDamageWatcher(self);
  self thread MissileImpactWatcher(missile);
  self thread WatchOwnerDisconnect(missile);
  self thread GameEndWatcher(missile);
  self thread outOfBoundsWatcher(missile);
  self thread watchOwnerDeath(missile);
  missile thread killBrushWatcher(self);
  missile setTeam(self.team);
  missile.team = self.team;
  missile.outOfBoundsTime = 2.0;
  missile.fadeInTime = 1.0;
  self.killstreak_waitamount = 20000;
  Target_Set(missile);
  missile maps\mp\gametypes\_spawning::create_tvmissile_influencers(self.team);
}
WatchOwnerDisconnect(missile) {
  missile endon("death");
  self waittill("disconnect");
  Target_Remove(missile);
  missile Detonate();
}
watchOwnerDeath(missile) {
  missile endon("death");
  self endon("disconnect");
  self waittill("death");
  if(level.teamBased && self.team != missile.team) {
    Target_Remove(missile);
    missile Detonate();
  }
}
GameEndWatcher(missile) {
  missile endon("death");
  self endon("disconnect");
  level waittill("game_ended");
  Target_Remove(missile);
  missile Detonate();
}
killBrushWatcher(player) {
  player endon("disconnect");
  self endon("death");
  player endon("guided_missile_exploded");
  killbushes = getEntArray("trigger_hurt", "classname");
  while(1) {
    for(i = 0; i < killbushes.size; i++) {
      if(self istouching(killbushes[i])) {
        if(isDefined(killbushes[i].script_noteworthy) && killbushes[i].script_noteworthy == "tvguided_safe") {
          break;
        }
        if(self.origin[2] > player.origin[2]) {
          break;
        }
        Target_Remove(self);
        self Detonate();
        return;
      }
    }
    wait(0.1);
  }
}
MissileImpactWatcher(missile) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  while(1) {
    self waittill("projectile_impact", weapon);
    if(weapon != "m220_tow_mp")
      continue;
    self PlayRumbleOnEntity("grenade_rumble");
    Target_Remove(missile);
    if(!self GetWeaponAmmoStock("m220_tow_mp")) {
      self SwitchToWeapon(self.lastDroppableWeapon);
    }
    self.killstreak_waitamount = undefined;
    self thread UnlinkCameraFromRocket();
    self notify("guided_missile_exploded");
    break;
  }
}
MissileDeathWatcher(player) {
  player endon("disconnect");
  player endon("guided_missile_exploded");
  self waittill("death");
  if(!player GetWeaponAmmoStock("m220_tow_mp")) {
    player SwitchToWeapon(player.lastDroppableWeapon);
  }
  player.killstreak_waitamount = undefined;
  player thread UnlinkCameraFromRocket();
  player notify("guided_missile_exploded");
}
MissileDamageWatcher(player) {
  player endon("disconnect");
  self endon("death");
  player endon("guided_missile_exploded");
  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagName, modelName, partname, weapon);
    if(damage > 5) {
      if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weapon, attacker)) {
        attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
      }
      break;
    }
  }
  Target_Remove(self);
  if(player != attacker) {
    attacker maps\mp\_medals::destroyerM220Tow(weapon);
    attacker maps\mp\_properks::destroyedKillstreak();
    weaponStatName = "destroyed";
    switch (weapon) {
      case "auto_tow_mp":
      case "tow_turret_mp":
      case "tow_turret_drop_mp":
        weaponStatName = "kills";
        break;
    }
    attacker maps\mp\gametypes\_globallogic_score::setWeaponStat(weapon, 1, weaponStatName);
    level.globalKillstreaksDestroyed++;
    attacker maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_m220_tow_drop", 1, "destroyed");
  }
  self detonate();
  if(!player GetWeaponAmmoStock("m220_tow_mp")) {
    player SwitchToWeapon(player.lastDroppableWeapon);
  }
  player.killstreak_waitamount = undefined;
  player thread UnlinkCameraFromRocket();
  player notify("guided_missile_exploded");
}
UnlinkCameraFromRocket() {
  self endon("disconnect");
  wait(1.0);
  self UnlinkGuidedMissileCamera();
}
guidedMissileOverlay() {
  guided_missile_overlay = newClientHudElem(self);
  guided_missile_overlay.x = 0;
  guided_missile_overlay.y = 0;
  guided_missile_overlay.alignX = "center";
  guided_missile_overlay.alignY = "middle";
  guided_missile_overlay.horzAlign = "center";
  guided_missile_overlay.vertAlign = "middle";
  guided_missile_overlay.foreground = true;
  guided_missile_overlay.hidewhendead = false;
  guided_missile_overlay.hidewheninmenu = true;
  guided_missile_overlay setshader("tow_overlay", 480, 480);
  guided_missile_grain = newClientHudElem(self);
  guided_missile_grain.x = 0;
  guided_missile_grain.y = 0;
  guided_missile_grain.alignX = "left";
  guided_missile_grain.alignY = "top";
  guided_missile_grain.horzAlign = "fullscreen";
  guided_missile_grain.vertAlign = "fullscreen";
  guided_missile_grain.foreground = true;
  guided_missile_grain.hidewhendead = false;
  guided_missile_grain.hidewheninmenu = true;
  guided_missile_grain setshader("tow_filter_overlay", 640, 480);
  guided_missile_grain.alpha = 1.0;
  self.leaving_play_area = newclienthudelem(self);
  self.leaving_play_area.fontScale = 1.25;
  self.leaving_play_area.x = 0;
  self.leaving_play_area.y = 50;
  self.leaving_play_area.alignX = "center";
  self.leaving_play_area.alignY = "top";
  self.leaving_play_area.horzAlign = "center";
  self.leaving_play_area.vertAlign = "top";
  self.leaving_play_area.foreground = true;
  self.leaving_play_area.hidewhendead = false;
  self.leaving_play_area.hidewheninmenu = true;
  self.leaving_play_area.archived = false;
  self.leaving_play_area.alpha = 0.0;
  self.leaving_play_area SetText(&"MP_GUIDED_MISSILE_LOSING_SIGNAL");
  self.guided_missile_lost_signal = newclienthudelem(self);
  self.guided_missile_lost_signal.x = 0;
  self.guided_missile_lost_signal.y = 0;
  self.guided_missile_lost_signal.horzAlign = "fullscreen";
  self.guided_missile_lost_signal.vertAlign = "fullscreen";
  self.guided_missile_lost_signal.foreground = false;
  self.guided_missile_lost_signal.hidewhendead = false;
  self.guided_missile_lost_signal.hidewheninmenu = true;
  self.guided_missile_lost_signal.sort = 0;
  self.guided_missile_lost_signal SetShader("tow_filter_overlay_no_signal", 640, 480);
  self.guided_missile_lost_signal.alpha = 0;
  self thread fade_to_white_on_death();
  self thread destroy_overlay_on_missile_done(guided_missile_overlay, guided_missile_grain);
}
destroy_overlays_on_owner_disconnect(guided_missile_overlay, guided_missile_grain) {
  self endon("guided_missile_exploded");
  self waittill("disconnect");
  guided_missile_overlay Destroy();
  guided_missile_grain Destroy();
  self.guided_missile_lost_signal Destroy();
  self.leaving_play_area destroy();
}
testAlphaOut(guided_missile_grain) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  while(1) {
    guided_missile_grain.alpha += 0.05;
    wait(0.1);
  }
}
destroy_overlay_on_death(guided_missile_overlay, guided_missile_grain) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  self waittill("death");
  guided_missile_overlay Destroy();
  guided_missile_grain Destroy();
  self.leaving_play_area destroy();
}
destroy_overlay_on_missile_done(guided_missile_overlay, guided_missile_grain) {
  self endon("disconnect");
  self waittill("guided_missile_exploded");
  guided_missile_overlay Destroy();
  guided_missile_grain Destroy();
  self.leaving_play_area destroy();
}
fade_to_white_on_death() {
  self endon("disconnect");
  self waittill("guided_missile_exploded");
  waittillframeend;
  self.guided_missile_lost_signal.alpha = 1.0;
  wait(1.0);
  if(isDefined(self.guided_missile_lost_signal))
    self.guided_missile_lost_signal Destroy();
}
outOfBoundsWatcher(missile) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  missile endon("death");
  missile.launchedCorrectly = false;
  missile.useMeshBounds = true;
  for(;;) {
    if(!(missile isMissileInsideHeightLock()) && missile.useMeshBounds) {
      if(!missile.launchedCorrectly) {
        missile.useMeshBounds = false;
        wait 0.05;
        continue;
      }
      if(!isDefined(missile.beingWarnedAboutLeaving)) {
        missile.beingWarnedAboutLeaving = true;
        if(isDefined(self.leaving_play_area.alpha))
          self.leaving_play_area.alpha = 1.0;
        missile SetClientFlag(level.const_flag_outofbounds);
        self thread warnLeavingBattlefield(missile);
      }
    } else if(!missile.useMeshBounds && !(missile isMissileInsideHeightLockBackupCheck())) {
      if(!isDefined(missile.beingWarnedAboutLeaving)) {
        missile.beingWarnedAboutLeaving = true;
        if(isDefined(self.leaving_play_area.alpha))
          self.leaving_play_area.alpha = 1.0;
        missile SetClientFlag(level.const_flag_outofbounds);
        self thread warnLeavingBattlefield(missile);
      }
    } else if(missile.origin[2] >= level.GuidedMissileMaxHight) {
      if(!isDefined(missile.beingWarnedAboutLeaving)) {
        missile.beingWarnedAboutLeaving = true;
        if(isDefined(self.leaving_play_area.alpha))
          self.leaving_play_area.alpha = 1.0;
        missile SetClientFlag(level.const_flag_outofbounds);
        self thread warnLeavingBattlefield(missile);
      }
    } else if(isDefined(missile.beingWarnedAboutLeaving)) {
      missile notify("reentered_battlefield");
      missile.beingWarnedAboutLeaving = undefined;
      if(isDefined(self.leaving_play_area.alpha))
        self.leaving_play_area.alpha = 0.0;
      missile ClearClientFlag(level.const_flag_outofbounds);
      self thread FadeFromWhite(missile);
    }
    missile.launchedCorrectly = true;
    wait 0.05;
  }
}
isMissileInsideHeightLockBackupCheck() {
  boundryPadding = 1000;
  if(self.origin[0] > (level.spawnMins[0] - boundryPadding) && self.origin[0] < (level.spawnMaxs[0] + boundryPadding) && self.origin[1] > (level.spawnMins[1] - boundryPadding) && self.origin[1] < (level.spawnMaxs[1] + boundryPadding))
    return true;
  return false;
}
warnLeavingBattlefield(missile) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  missile endon("reentered_battlefield");
  self thread DestroyMissileOutOfBounds(missile);
  self thread FadeToWhite(missile);
  for(;;) {
    wait 1.0;
    earthquake(0.4, 1.0, missile.origin, 500, self);
  }
}
DestroyMissileOutOfBounds(missile) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  missile endon("reentered_battlefield");
  wait(missile.outOfBoundsTime);
  missile detonate();
}
FadeToWhite(missile) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  missile endon("reentered_battlefield");
  fadeTime = GetTime() + (missile.outOfBoundsTime * 1000);
  while(1) {
    newAlpha = 1.0 - Float((fadeTime - GetTime()) / (missile.outOfBoundsTime * 1000.0));
    self.guided_missile_lost_signal.alpha = newAlpha;
    if(newAlpha < 0.5) {
      self PlayRumbleOnEntity("damage_light");
    } else {
      self PlayRumbleOnEntity("damage_heavy");
    }
    wait(0.05);
  }
}
FadeFromWhite(missile) {
  self endon("disconnect");
  self endon("guided_missile_exploded");
  missile endon("reentered_battlefield");
  beginning_alpha = self.guided_missile_lost_signal.alpha;
  fadeTime = GetTime() + (missile.fadeInTime * 1000);
  while(1) {
    newAlpha = Float(fadeTime - GetTime()) / (missile.fadeInTime * 1000.0);
    newAlpha *= beginning_alpha;
    PrintLn("newAlpha fade out: " + newAlpha);
    if(newAlpha < 0)
      return;
    self.guided_missile_lost_signal.alpha = newAlpha;
    if(newAlpha < 0.5) {
      self PlayRumbleOnEntity("damage_light");
    } else {
      self PlayRumbleOnEntity("damage_heavy");
    }
    wait(0.05);
  }
}