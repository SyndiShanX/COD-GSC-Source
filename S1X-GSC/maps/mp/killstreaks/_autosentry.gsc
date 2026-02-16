/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_autosentry.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  if(!isDefined(level.sentryType)) {
    level.sentryType = [];
  }

  level.sentryType["sentry_minigun"] = "sentry";
  level.sentryType["sam_turret"] = "sam_turret";

  level.killStreakFuncs[level.sentryType["sentry_minigun"]] = ::tryUseAutoSentry;
  level.killStreakFuncs[level.sentryType["sam_turret"]] = ::tryUseSAM;

  if(!isDefined(level.sentrySettings)) {
    level.sentrySettings = [];
  }

  level.sentrySettings["sentry_minigun"] = spawnStruct();
  level.sentrySettings["sentry_minigun"].health = 999999;
  level.sentrySettings["sentry_minigun"].maxHealth = 1000;
  level.sentrySettings["sentry_minigun"].burstMin = 20;
  level.sentrySettings["sentry_minigun"].burstMax = 120;
  level.sentrySettings["sentry_minigun"].pauseMin = 0.15;
  level.sentrySettings["sentry_minigun"].pauseMax = 0.35;
  level.sentrySettings["sentry_minigun"].sentryModeOn = "sentry";
  level.sentrySettings["sentry_minigun"].sentryModeOff = "sentry_offline";
  level.sentrySettings["sentry_minigun"].timeOut = 90.0;
  level.sentrySettings["sentry_minigun"].spinupTime = 0.05;
  level.sentrySettings["sentry_minigun"].overheatTime = 8.0;
  level.sentrySettings["sentry_minigun"].cooldownTime = 0.1;
  level.sentrySettings["sentry_minigun"].fxTime = 0.3;
  level.sentrySettings["sentry_minigun"].streakName = "sentry";
  level.sentrySettings["sentry_minigun"].weaponInfo = "sentry_minigun_mp";
  level.sentrySettings["sentry_minigun"].modelBase = "sentry_minigun_weak";
  level.sentrySettings["sentry_minigun"].modelPlacement = "sentry_minigun_weak_obj";
  level.sentrySettings["sentry_minigun"].modelPlacementFailed = "sentry_minigun_weak_obj_red";
  level.sentrySettings["sentry_minigun"].modelDestroyed = "sentry_minigun_weak_destroyed";
  level.sentrySettings["sentry_minigun"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["sentry_minigun"].headIcon = true;
  level.sentrySettings["sentry_minigun"].teamSplash = "used_sentry";
  level.sentrySettings["sentry_minigun"].shouldSplash = false;
  level.sentrySettings["sentry_minigun"].voDestroyed = "sentry_destroyed";

  level.sentrySettings["sam_turret"] = spawnStruct();
  level.sentrySettings["sam_turret"].health = 999999;
  level.sentrySettings["sam_turret"].maxHealth = 1000;
  level.sentrySettings["sam_turret"].burstMin = 20;
  level.sentrySettings["sam_turret"].burstMax = 120;
  level.sentrySettings["sam_turret"].pauseMin = 0.15;
  level.sentrySettings["sam_turret"].pauseMax = 0.35;
  level.sentrySettings["sam_turret"].sentryModeOn = "sentry_manual";
  level.sentrySettings["sam_turret"].sentryModeOff = "sentry_offline";
  level.sentrySettings["sam_turret"].timeOut = 90.0;
  level.sentrySettings["sam_turret"].spinupTime = 0.05;
  level.sentrySettings["sam_turret"].overheatTime = 8.0;
  level.sentrySettings["sam_turret"].cooldownTime = 0.1;
  level.sentrySettings["sam_turret"].fxTime = 0.3;
  level.sentrySettings["sam_turret"].streakName = "sam_turret";
  level.sentrySettings["sam_turret"].weaponInfo = "sam_mp";
  level.sentrySettings["sam_turret"].modelBase = "mp_sam_turret";
  level.sentrySettings["sam_turret"].modelPlacement = "mp_sam_turret_placement";
  level.sentrySettings["sam_turret"].modelPlacementFailed = "mp_sam_turret_placement_failed";
  level.sentrySettings["sam_turret"].modelDestroyed = "mp_sam_turret";
  level.sentrySettings["sam_turret"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["sam_turret"].headIcon = true;
  level.sentrySettings["sam_turret"].teamSplash = "used_sam_turret";
  level.sentrySettings["sam_turret"].shouldSplash = false;
  level.sentrySettings["sam_turret"].voDestroyed = "sam_destroyed";

  level._effect["sentry_overheat_mp"] = loadfx("vfx/distortion/sentrygun_overheat");
  level._effect["sentry_explode_mp"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/smoke/vehicle_sentrygun_damaged_smoke");
  level._effect["sentry_stunned"] = Loadfx("vfx/sparks/direct_hack_stun");

  SetDevDvarIfUninitialized("scr_sam_timeout", 90.0);
}

tryUseAutoSentry(lifeId, modules) {
  result = self giveSentry("sentry_minigun");
  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.sentrySettings["sentry_minigun"].streakName, self.origin);
  }

  return (result);
}

tryUseSAM(lifeId, modules) {
  result = self giveSentry("sam_turret");
  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.sentrySettings["sam_turret"].streakName, self.origin);
  }

  return (result);
}

giveSentry(sentryType) {
  if(!self validateUseStreak()) {
    return false;
  }

  self.last_sentry = sentryType;

  sentryGun = createSentryForPlayer(sentryType, self);

  self removePerks();

  result = self setCarryingSentry(sentryGun, true);

  self thread waitRestorePerks();

  self.isCarrying = false;

  if(isDefined(sentryGun)) {
    return true;
  } else {
    return false;
  }
}

setCarryingSentry(sentryGun, allowCancel) {
  self endon("death");
  self endon("disconnect");

  assert(isReallyAlive(self));

  sentryGun sentry_setCarried(self);

  self _disableWeapon();

  if(!IsAI(self)) {
    self notifyOnPlayerCommand("place_sentry", "+attack");
    self notifyOnPlayerCommand("place_sentry", "+attack_akimbo_accessible");
    self notifyOnPlayerCommand("cancel_sentry", "+actionslot 4");
    if(!level.console) {
      self notifyOnPlayerCommand("cancel_sentry", "+actionslot 5");
      self notifyOnPlayerCommand("cancel_sentry", "+actionslot 6");
      self notifyOnPlayerCommand("cancel_sentry", "+actionslot 7");
      self notifyOnPlayerCommand("cancel_sentry", "+actionslot 8");
    }
  }

  for(;;) {
    result = waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement");

    if(result == "cancel_sentry" || result == "force_cancel_placement") {
      if(!allowCancel && result == "cancel_sentry") {
        continue;
      }

      if(level.console) {
        killstreakWeapon = getKillstreakWeapon(level.sentrySettings[sentryGun.sentryType].streakName);
        if(isDefined(self.killstreakIndexWeapon) &&
          killstreakWeapon == getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName) &&
          !(self GetWeaponsListItems()).size) {
          self _giveWeapon(killstreakWeapon, 0);
          self _setActionSlot(4, "weapon", killstreakWeapon);
        }
      }

      sentryGun sentry_setCancelled();
      self _enableWeapon();
      return false;
    }

    if(!sentryGun.canBePlaced) {
      continue;
    }

    sentryGun sentry_setPlaced();
    self _enableWeapon();
    return true;
  }
}

removeWeapons() {
  if(self HasWeapon("riotshield_mp")) {
    self.restoreWeapon = "riotshield_mp";
    self takeWeapon("riotshield_mp");
  }
}

removePerks() {
  if(self _hasPerk("specialty_explosivebullets")) {
    self.restorePerk = "specialty_explosivebullets";
    self _unsetPerk("specialty_explosivebullets");
  }
}

restoreWeapons() {
  if(isDefined(self.restoreWeapon)) {
    self _giveWeapon(self.restoreWeapon);
    self.restoreWeapon = undefined;
  }
}

restorePerks() {
  if(isDefined(self.restorePerk)) {
    self givePerk(self.restorePerk, false);
    self.restorePerk = undefined;
  }
}

waitRestorePerks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  self restorePerks();
}

createSentryForPlayer(sentryType, owner) {
  assertEx(isDefined(owner), "createSentryForPlayer() called without owner specified");

  sentryGun = spawnTurret("misc_turret", owner.origin, level.sentrySettings[sentryType].weaponInfo);
  sentryGun.angles = owner.angles;

  sentryGun sentry_initSentry(sentryType, owner);

  return (sentryGun);
}

sentry_initSentry(sentryType, owner) {
  self.sentryType = sentryType;
  self.canBePlaced = true;

  self setModel(level.sentrySettings[self.sentryType].modelBase);
  self.shouldSplash = true;

  self setCanDamage(true);
  switch (sentryType) {
    case "sam_turret":
      self makeTurretInoperable();
      self SetLeftArc(180);
      self SetRightArc(180);
      self SetTopArc(80);
      self SetDefaultDropPitch(-89.0);
      self.laser_on = false;

      killCamEnt = spawn("script_model", self GetTagOrigin("tag_laser"));
      killCamEnt LinkTo(self);
      self.killCamEnt = killCamEnt;
      self.killCamEnt SetScriptMoverKillCam("explosive");
      break;
    default:
      self makeTurretInoperable();
      self SetDefaultDropPitch(-89.0);
      break;
  }

  self setTurretModeChangeWait(true);

  self sentry_setInactive();

  self sentry_setOwner(owner);
  self thread sentry_handleDeath();
  self thread sentry_timeOut();

  switch (sentryType) {
    case "sam_turret":
      self thread sentry_handleUse();
      self thread sentry_beepSounds();
      break;
    default:
      self thread sentry_handleUse();
      self thread sentry_attackTargets();
      self thread sentry_beepSounds();
      break;
  }
}

sentry_watchDisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    playFXOnTag(getfx("sentry_stunned"), self, "tag_aim");

    self SetDefaultDropPitch(40);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);

    wait(duration);

    stopFXOnTag(getfx("sentry_stunned"), self, "tag_aim");

    self SetDefaultDropPitch(-89.0);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
  }
}

sentry_directHacked() {
  self endon("death");
  level endon("game_ended");

  self.directHackDuration = 0.25;

  if(isDefined(self.directHackEndTime) && gettime() < self.directHackEndTime) {
    self.directHackEndTime = getTime() + (self.directHackDuration * 1000);
    return;
  }

  playFXOnTag(getfx("sentry_stunned"), self, "tag_aim");
  self.directHackEndTime = getTime() + (self.directHackDuration * 1000);
  self SetDefaultDropPitch(40);
  self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);

  while(1) {
    if(getTime() > self.directHackEndTime) {
      break;
    }
    wait(0.05);
  }

  self SetDefaultDropPitch(-89.0);
  self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);

  stopFXOnTag(getfx("sentry_stunned"), self, "tag_aim");
}

sentry_handleDeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self setModel(level.sentrySettings[self.sentryType].modelDestroyed);

  self sentry_setInactive();
  self SetDefaultDropPitch(40);
  self SetSentryOwner(undefined);
  self SetTurretMinimapVisible(false);

  if(isDefined(self.ownerTrigger)) {
    self.ownerTrigger delete();
  }

  self playSound("sentry_explode");

  if(isDefined(self.inUseBy)) {
    playFXOnTag(getFx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

    self.inUseBy.turret_overheat_bar destroyElem();
    self.inUseBy restorePerks();
    self.inUseBy restoreWeapons();

    self notify("deleting");
    wait(1.0);
    stopFXOnTag(getFx("sentry_explode_mp"), self, "tag_origin");
    stopFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
  } else {
    playFXOnTag(getFx("sentry_explode_mp"), self, "tag_aim");
    wait(1.5);
    self playSound("sentry_explode_smoke");
    for(smokeTime = 8; smokeTime > 0; smokeTime -= 0.4) {
      playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
      wait(0.4);
    }
    self notify("deleting");
  }

  if(isDefined(self.killCamEnt)) {
    self.killCamEnt delete();
  }

  self delete();
}

sentry_handleUse() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    assert(player == self.owner);
    assert(!isDefined(self.carriedBy));

    if(!isReallyAlive(player)) {
      continue;
    }

    if(self.sentryType == "sam_turret") {
      self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
    }

    player setCarryingSentry(self, false);
  }
}

turret_handlePickup(turret) {
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");

  if(!isDefined(turret.ownerTrigger)) {
    return;
  }

  buttonTime = 0;
  for(;;) {
    if(IsAlive(self) &&
      self IsTouching(turret.ownerTrigger) &&
      !isDefined(turret.inUseBy) &&
      !isDefined(turret.carriedBy) &&
      self IsOnGround()) {
      if(self useButtonPressed()) {
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        buttonTime = 0;
        while(self useButtonPressed()) {
          buttonTime += 0.05;
          wait(0.05);
        }

        println("pressTime1: " + buttonTime);
        if(buttonTime >= 0.5) {
          continue;
        }

        buttonTime = 0;
        while(!self useButtonPressed() && buttonTime < 0.5) {
          buttonTime += 0.05;
          wait(0.05);
        }

        println("delayTime: " + buttonTime);
        if(buttonTime >= 0.5) {
          continue;
        }

        if(!isReallyAlive(self)) {
          continue;
        }

        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        turret setMode(level.sentrySettings[turret.sentryType].sentryModeOff);
        self thread setCarryingSentry(turret, false);
        turret.ownerTrigger delete();
        return;
      }
    }
    wait(0.05);
  }
}

turret_handleUse() {
  self notify("turret_handluse");
  self endon("turret_handleuse");
  self endon("deleting");
  level endon("game_ended");

  self.forceDisable = false;
  colorStable = (1, 0.9, 0.7);
  colorUnstable = (1, 0.65, 0);
  colorOverheated = (1, 0.25, 0);

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(self.carriedBy)) {
      continue;
    }
    if(isDefined(self.inUseBy)) {
      continue;
    }
    if(!isReallyAlive(player)) {
      continue;
    }
    player removePerks();
    player removeWeapons();

    self.inUseBy = player;
    self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
    self sentry_setOwner(player);
    self setMode(level.sentrySettings[self.sentryType].sentryModeOn);
    player thread turret_shotMonitor(self);

    player.turret_overheat_bar = player createBar(colorStable, 100, 6);
    player.turret_overheat_bar setPoint("CENTER", "BOTTOM", 0, -70);
    player.turret_overheat_bar.alpha = 0.65;
    player.turret_overheat_bar.bar.alpha = 0.65;

    playingHeatFX = false;

    for(;;) {
      if(!isReallyAlive(player)) {
        self.inUseBy = undefined;
        player.turret_overheat_bar destroyElem();
        break;
      }
      if(!player IsUsingTurret()) {
        self notify("player_dismount");
        self.inUseBy = undefined;
        player.turret_overheat_bar destroyElem();
        player restorePerks();
        player restoreWeapons();
        self setHintString(level.sentrySettings[self.sentryType].hintString);
        self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
        self sentry_setOwner(self.originalOwner);
        self setMode(level.sentrySettings[self.sentryType].sentryModeOn);
        break;
      }

      if(self.heatLevel >= level.sentrySettings[self.sentryType].overheatTime) {
        barFrac = 1;
      } else {
        barFrac = self.heatLevel / level.sentrySettings[self.sentryType].overheatTime;
      }
      player.turret_overheat_bar updateBar(barFrac);

      if(self.forceDisable || self.overheated) {
        self TurretFireDisable();
        player.turret_overheat_bar.bar.color = colorOverheated;
        playingHeatFX = false;
      } else {
        player.turret_overheat_bar.bar.color = colorStable;
        self TurretFireEnable();
        playingHeatFX = false;
        self notify("not_overheated");
      }

      wait(0.05);
    }
    self SetDefaultDropPitch(0.0);
  }
}

sentry_handleOwnerDisconnect() {
  self endon("death");
  level endon("game_ended");

  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("death");
}

sentry_setOwner(owner) {
  assertEx(isDefined(owner), "sentry_setOwner() called without owner specified");
  assertEx(isPlayer(owner), "sentry_setOwner() called on non-player entity type: " + owner.classname);

  self.owner = owner;

  self SetSentryOwner(self.owner);
  self SetTurretMinimapVisible(true, self.sentryType);

  if(level.teamBased) {
    self.team = self.owner.team;
    self setTurretTeam(self.team);
  }

  self thread sentry_handleOwnerDisconnect();
}

sentry_setPlaced() {
  self setModel(level.sentrySettings[self.sentryType].modelBase);

  if(self GetMode() == "manual") {
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);
  }

  self setSentryCarrier(undefined);
  self setCanDamage(true);

  self sentry_makeSolid();

  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  self sentry_setActive();

  self playSound("sentry_gun_plant");

  self notify("placed");
}

sentry_setCancelled() {
  self.carriedBy forceUseHintOff();
  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
  }

  self delete();
}

sentry_setCarried(carrier) {
  assert(isPlayer(carrier));
  if(isDefined(self.originalOwner)) {
    assertEx(carrier == self.originalOwner, "sentry_setCarried() specified carrier does not own this sentry");
  } else {
    assertEx(carrier == self.owner, "sentry_setCarried() specified carrier does not own this sentry");
  }

  self setModel(level.sentrySettings[self.sentryType].modelPlacement);

  self setSentryCarrier(carrier);
  self setCanDamage(false);
  self sentry_makeNotSolid();

  self.carriedBy = carrier;
  carrier.isCarrying = true;

  carrier thread updateSentryPlacement(self);

  self thread sentry_onCarrierDeath(carrier);
  self thread sentry_onCarrierDisconnect(carrier);
  self thread sentry_onCarrierChangedTeam(carrier);
  self thread sentry_onGameEnded();

  self SetDefaultDropPitch(-89.0);

  self sentry_setInactive();

  self notify("carried");
}

updateSentryPlacement(sentryGun) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  sentryGun endon("placed");
  sentryGun endon("death");

  sentryGun.canBePlaced = true;
  lastCanPlaceSentry = -1;

  for(;;) {
    placement = self canPlayerPlaceSentry(true, 22);

    sentryGun.origin = placement["origin"];
    sentryGun.angles = placement["angles"];
    sentryGun.canBePlaced = self isOnGround() && placement["result"] && (abs(sentryGun.origin[2] - self.origin[2]) < 30);

    if(sentryGun.canBePlaced != lastCanPlaceSentry) {
      if(sentryGun.canBePlaced) {
        sentryGun setModel(level.sentrySettings[sentryGun.sentryType].modelPlacement);
        self ForceUseHintOn(&"SENTRY_PLACE");
      } else {
        sentryGun setModel(level.sentrySettings[sentryGun.sentryType].modelPlacementFailed);
        self ForceUseHintOn(&"SENTRY_CANNOT_PLACE");
      }
    }

    lastCanPlaceSentry = sentryGun.canBePlaced;
    wait(0.05);
  }
}

sentry_onCarrierDeath(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill("death");

  if(self.canBePlaced) {
    self sentry_setPlaced();
  } else {
    self delete();
  }
}

sentry_onCarrierDisconnect(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill("disconnect");

  self delete();
}

sentry_onCarrierChangedTeam(carrier) {
  self endon("placed");
  self endon("death");

  carrier waittill_any("joined_team", "joined_spectators");

  self delete();
}

sentry_onGameEnded(carrier) {
  self endon("placed");
  self endon("death");

  level waittill("game_ended");

  self delete();
}

sentry_setActive() {
  self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
  self setCursorHint("HINT_NOICON");
  self setHintString(level.sentrySettings[self.sentryType].hintString);

  if(level.sentrySettings[self.sentryType].headIcon) {
    if(level.teamBased) {
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 65));
    } else {
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 65));
    }
  }

  self makeUsable();

  foreach(player in level.players) {
    entNum = self GetEntityNumber();
    self addToTurretList(entNum);

    if(player == self.owner) {
      self enablePlayerUse(player);
    } else {
      self disablePlayerUse(player);
    }
  }

  if(self.shouldSplash) {
    level thread teamPlayerCardSplash(level.sentrySettings[self.sentryType].teamSplash, self.owner, self.owner.team);
    self.shouldSplash = false;
  }

  if(self.sentryType == "sam_turret") {
    self thread sam_attackTargets();
  }

  self thread sentry_watchDisabled();
}

sentry_setInactive() {
  self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
  self makeUnusable();
  self FreeEntitySentient();

  entNum = self GetEntityNumber();

  self removeFromTurretList(entNum);

  if(level.teamBased) {
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));
  }
}

sentry_makeSolid() {
  self makeTurretSolid();
}

sentry_makeNotSolid() {
  self setContents(0);
}

isFriendlyToSentry(sentryGun) {
  if(level.teamBased && self.team == sentryGun.team) {
    return true;
  }

  return false;
}

addToTurretList(entNum) {
  level.turrets[entNum] = self;
}

removeFromTurretList(entNum) {
  level.turrets[entNum] = undefined;
}

sentry_attackTargets() {
  self endon("death");
  level endon("game_ended");

  self.momentum = 0;
  self.heatLevel = 0;
  self.overheated = false;

  self thread sentry_heatMonitor();

  for(;;) {
    self waittill_either("turretstatechange", "cooled");

    if(self isFiringTurret()) {
      self thread sentry_burstFireStart();
    } else {
      self sentry_spinDown();
      self thread sentry_burstFireStop();
    }
  }
}

sentry_timeOut() {
  self endon("death");
  level endon("game_ended");

  lifeSpan = level.sentrySettings[self.sentryType].timeOut;

  if(self.sentryType == "sam_turret") {
    lifeSpan = GetDvarInt("scr_sam_timeout", 90);
  }

  while(lifeSpan) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(!isDefined(self.carriedBy)) {
      lifeSpan = max(0, lifeSpan - 1.0);
    }
  }

  if(isDefined(self.owner)) {
    if(self.sentryType == "sam_turret") {
      self.owner thread leaderDialogOnPlayer("sam_gone");
    } else {
      self.owner thread leaderDialogOnPlayer("sentry_gone");
    }
  }
  self notify("death");
}

sentry_targetLockSound() {
  self endon("death");

  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
}

sentry_spinUp() {
  self thread sentry_targetLockSound();

  while(self.momentum < level.sentrySettings[self.sentryType].spinupTime) {
    self.momentum += 0.1;

    wait(0.1);
  }
}

sentry_spinDown() {
  self.momentum = 0;
}

sentry_burstFireStart() {
  self endon("death");
  self endon("stop_shooting");

  level endon("game_ended");

  self sentry_spinUp();

  fireTime = weaponFireTime(level.sentrySettings[self.sentryType].weaponInfo);
  minShots = level.sentrySettings[self.sentryType].burstMin;
  maxShots = level.sentrySettings[self.sentryType].burstMax;
  minPause = level.sentrySettings[self.sentryType].pauseMin;
  maxPause = level.sentrySettings[self.sentryType].pauseMax;

  for(;;) {
    numShots = randomIntRange(minShots, maxShots + 1);

    for(i = 0; i < numShots && !self.overheated; i++) {
      self shootTurret();
      self.heatLevel += fireTime;
      wait(fireTime);
    }

    wait(randomFloatRange(minPause, maxPause));
  }
}

sentry_burstFireStop() {
  self notify("stop_shooting");
}

turret_shotMonitor(turret) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  turret endon("death");
  turret endon("player_dismount");

  fireTime = weaponFireTime(level.sentrySettings[turret.sentryType].weaponInfo);
  for(;;) {
    turret waittill("turret_fire");
    turret.heatLevel += fireTime;

    turret.cooldownWaitTime = fireTime;
  }
}

sentry_heatMonitor() {
  self endon("death");

  fireTime = weaponFireTime(level.sentrySettings[self.sentryType].weaponInfo);

  lastHeatLevel = 0;
  lastFxTime = 0;

  overheatTime = level.sentrySettings[self.sentryType].overheatTime;
  overheatCoolDown = level.sentrySettings[self.sentryType].cooldownTime;

  for(;;) {
    if(self.heatLevel != lastHeatLevel) {
      wait(fireTime);
    } else {
      self.heatLevel = max(0, self.heatLevel - 0.05);
    }

    if(self.heatLevel > overheatTime) {
      self.overheated = true;
      self thread PlayHeatFX();

      while(self.heatLevel) {
        self.heatLevel = max(0, self.heatLevel - overheatCoolDown);
        wait(0.1);
      }

      self.overheated = false;
      self notify("not_overheated");
    }

    lastHeatLevel = self.heatLevel;
    wait(0.05);
  }
}

turret_heatMonitor() {
  self endon("death");

  overheatTime = level.sentrySettings[self.sentryType].overheatTime;

  while(true) {
    if(self.heatLevel > overheatTime) {
      self.overheated = true;
      self thread PlayHeatFX();

      while(self.heatLevel) {
        wait(0.1);
      }

      self.overheated = false;
      self notify("not_overheated");
    }

    wait(0.05);
  }
}

turret_coolMonitor() {
  self endon("death");

  while(true) {
    if(self.heatLevel > 0) {
      if(self.cooldownWaitTime <= 0) {
        self.heatLevel = max(0, self.heatLevel - 0.05);
      } else {
        self.cooldownWaitTime = max(0, self.cooldownWaitTime - 0.05);
      }
    }

    wait(0.05);
  }
}

playHeatFX() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(getFx("sentry_overheat_mp"), self, "tag_flash");

    wait(level.sentrySettings[self.sentryType].fxTime);
  }
}

playSmokeFX() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
    wait(0.4);
  }
}

sentry_beepSounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait(3.0);

    if(!isDefined(self.carriedBy)) {
      self playSound("sentry_gun_beep");
    }
  }
}

sam_attackTargets() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  self.samTargetEnt = undefined;
  self.samMissileGroups = [];

  while(true) {
    self.samTargetEnt = sam_acquireTarget();
    self sam_fireOnTarget();
    wait(0.05);
  }
}

sam_acquireTarget() {
  eyeLine = self GetTagOrigin("tag_laser");
  if(!isDefined(self.samTargetEnt)) {
    if(level.teambased) {
      entityList = [];
      if(level.multiTeamBased) {
        foreach(teamName in level.teamNameList) {
          if(teamName != self.team) {
            foreach(model in level.uavmodels[teamName]) {
              entityList[entityList.size] = model;
            }
          }
        }
      } else {
        if(isDefined(self.team)) {
          entityList = level.UAVModels[level.otherTeam[self.team]];
        }
      }

      foreach(uav in entityList) {
        if((isDefined(uav.isLeaving) && uav.isLeaving)) {
          continue;
        }

        if(isDefined(uav.orbit) && uav.orbit) {
          continue;
        }

        if(SightTracePassed(eyeLine, uav.origin, false, self)) {
          return uav;
        }
      }

      foreach(lb in level.littleBirds) {
        if(isDefined(lb.team) && lb.team == self.team) {
          continue;
        }

        if(SightTracePassed(eyeLine, lb.origin, false, self)) {
          return lb;
        }
      }

      foreach(heli in level.helis) {
        if(isDefined(heli.team) && heli.team == self.team) {
          continue;
        }
        if(isDefined(heli.cloakstate) && heli.cloakstate < 1) {
          continue;
        }
        if(SightTracePassed(eyeLine, heli.origin, false, self, heli)) {
          return heli;
        }
      }

      if(level.orbitalsupportInUse && isDefined(level.orbitalsupport_planemodel.owner) && level.orbitalsupport_planemodel.owner.team != self.team) {
        if(SightTracePassed(eyeLine, level.orbitalsupport_planemodel.origin, false, self)) {
          return level.orbitalsupport_planemodel;
        }
      }

      if(isDefined(level._orbital_care_pod)) {
        foreach(pod in level._orbital_care_pod) {
          if(isDefined(pod.podrocket) && pod.owner.team != self.team) {
            if(SightTracePassed(eyeLine, pod.podrocket.origin, false, self)) {
              return pod.podrocket;
            }
          }
        }
      }

      foreach(plane in level.planes) {
        if(isDefined(plane.team) && plane.team == self.team) {
          continue;
        }
        if(SightTracePassed(eyeLine, plane.origin, false, self)) {
          return plane;
        }
      }
    } else {
      foreach(uav in level.UAVModels) {
        if(isDefined(uav.isLeaving) && uav.isLeaving) {
          continue;
        }

        if(isDefined(uav.owner) && isDefined(self.owner) && uav.owner == self.owner) {
          continue;
        }

        if(isDefined(uav.orbit) && uav.orbit) {
          continue;
        }

        if(SightTracePassed(eyeLine, uav.origin, false, self)) {
          return uav;
        }
      }

      foreach(lb in level.littleBirds) {
        if(isDefined(lb.owner) && isDefined(self.owner) && lb.owner == self.owner) {
          continue;
        }

        if(SightTracePassed(eyeLine, lb.origin, false, self)) {
          return lb;
        }
      }

      foreach(heli in level.helis) {
        if(isDefined(heli.owner) && isDefined(self.owner) && heli.owner == self.owner) {
          continue;
        }
        if(isDefined(heli.cloakstate) && heli.cloakstate < 1) {
          continue;
        }
        if(SightTracePassed(eyeLine, heli.origin, false, self, heli)) {
          return heli;
        }
      }

      if(level.orbitalsupportInUse && isDefined(level.orbitalsupport_planemodel.owner) && isDefined(self.owner) && level.orbitalsupport_planemodel.owner != self.owner) {
        if(SightTracePassed(eyeLine, level.orbitalsupport_planemodel.owner.origin, false, self)) {
          return level.orbitalsupport_planemodel.owner;
        }
      }

      if(isDefined(level._orbital_care_pod)) {
        foreach(pod in level._orbital_care_pod) {
          if(isDefined(pod.podrocket) && pod.owner != self) {
            if(SightTracePassed(eyeLine, pod.podrocket.origin, false, self)) {
              return pod.podrocket;
            }
          }
        }
      }

      foreach(plane in level.planes) {
        if(isDefined(plane.team) && plane.owner == self.owner) {
          continue;
        }
        if(SightTracePassed(eyeLine, plane.origin, false, self)) {
          return plane;
        }
      }
    }

    self ClearTargetEntity();
    return undefined;
  } else {
    if(!SightTracePassed(eyeLine, self.samTargetEnt.origin, false, self, self.samTargetEnt)) {
      self ClearTargetEntity();
      return undefined;
    }

    return self.samTargetEnt;
  }
}

sam_fireOnTarget() {
  if(isDefined(self.samTargetEnt)) {
    if((self.samTargetEnt == level.ac130.planemodel && !isDefined(level.ac130player)) || (isDefined(level.orbitalsupport_planeModel) && self.samTargetEnt == level.orbitalsupport_planeModel && !isDefined(level.orbitalsupport_player))) {
      self.samTargetEnt = undefined;
      self ClearTargetEntity();
      return;
    }

    self SetTargetEntity(self.samTargetEnt);
    self waittill("turret_on_target");
    if(!isDefined(self.samTargetEnt)) {
      return;
    }

    if(!self.laser_on) {
      self thread sam_watchLaser();
      self thread sam_watchCrashing();
      self thread sam_watchLeaving();
      self thread sam_watchLineOfSight();
    }

    wait(2.0);

    if(!isDefined(self.samTargetEnt)) {
      return;
    }

    if(self.samTargetEnt == level.ac130.planemodel && !isDefined(level.ac130player)) {
      self.samTargetEnt = undefined;
      self ClearTargetEntity();
      return;
    }

    rocketOffsets = [];
    rocketOffsets[0] = self GetTagOrigin("tag_le_missile1");
    rocketOffsets[1] = self GetTagOrigin("tag_le_missile2");
    rocketOffsets[2] = self GetTagOrigin("tag_ri_missile1");
    rocketOffsets[3] = self GetTagOrigin("tag_ri_missile2");

    missileGroup = self.samMissileGroups.size;
    for(i = 0; i < 4; i++) {
      if(!isDefined(self.samTargetEnt)) {
        return;
      }

      if(isDefined(self.carriedBy)) {
        return;
      }

      self ShootTurret();

      rocket = MagicBullet("sam_projectile_mp", rocketOffsets[i], self.samTargetEnt.origin, self.owner);
      rocket Missile_SetTargetEnt(self.samTargetEnt);
      rocket Missile_SetFlightmodeDirect();
      rocket.samTurret = self;

      rocket.samMissileGroup = missileGroup;
      self.samMissileGroups[missileGroup][i] = rocket;

      level notify("sam_missile_fired", self.owner, rocket, self.samTargetEnt);

      if(i == 3) {
        break;
      }

      wait(0.25);
    }
    level notify("sam_fired", self.owner, self.samMissileGroups[missileGroup], self.samTargetEnt);

    wait(3.0);
  }
}

sam_watchLineOfSight() {
  level endon("game_ended");
  self endon("death");
  self endon("fakedeath");

  while(isDefined(self.samTargetEnt) && isDefined(self GetTurretTarget(true)) && self GetTurretTarget(true) == self.samTargetEnt) {
    eyeLine = self GetTagOrigin("tag_laser");
    if(!SightTracePassed(eyeLine, self.samTargetEnt.origin, false, self, self.samTargetEnt)) {
      self ClearTargetEntity();
      self.samTargetEnt = undefined;
      break;
    }

    wait(0.05);
  }
}

sam_watchLaser() {
  self endon("death");

  self LaserOn();
  self.laser_on = true;
  self notify("laser_on");

  while(isDefined(self.samTargetEnt) && isDefined(self GetTurretTarget(true)) && self GetTurretTarget(true) == self.samTargetEnt) {
    wait(0.05);
  }

  self LaserOff();
  self.laser_on = false;
  self notify("laser_off");
}

sam_watchCrashing() {
  self endon("death");
  self endon("fakedeath");
  self.samTargetEnt endon("death");

  if(!isDefined(self.samTargetEnt.heliType)) {
    return;
  }

  self.samTargetEnt waittill("crashing");
  self ClearTargetEntity();
  self.samTargetEnt = undefined;
}

sam_watchLeaving() {
  self endon("death");
  self endon("fakedeath");
  self.samTargetEnt endon("death");

  if(!isDefined(self.samTargetEnt.model)) {
    return;
  }

  if(self.samTargetEnt.model == "vehicle_uav_static_mp") {
    self.samTargetEnt waittill("leaving");
    self ClearTargetEntity();
    self.samTargetEnt = undefined;
  }
}