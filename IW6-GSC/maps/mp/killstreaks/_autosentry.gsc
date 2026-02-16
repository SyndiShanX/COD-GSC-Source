/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_autosentry.gsc
***********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  level.sentryType = [];
  level.sentryType["sentry_minigun"] = "sentry";
  level.sentryType["sam_turret"] = "sam_turret";

  level.killStreakFuncs[level.sentryType["sentry_minigun"]] = ::tryUseAutoSentry;
  level.killStreakFuncs[level.sentryType["sam_turret"]] = ::tryUseSAM;

  level.sentrySettings = [];

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
  level.sentrySettings["sentry_minigun"].modelBase = "weapon_sentry_chaingun";
  level.sentrySettings["sentry_minigun"].modelPlacement = "weapon_sentry_chaingun_obj";
  level.sentrySettings["sentry_minigun"].modelPlacementFailed = "weapon_sentry_chaingun_obj_red";
  level.sentrySettings["sentry_minigun"].modelBombSquad = "weapon_sentry_chaingun_bombsquad";
  level.sentrySettings["sentry_minigun"].modelDestroyed = "weapon_sentry_chaingun_destroyed";
  level.sentrySettings["sentry_minigun"].hintString = &"SENTRY_PICKUP";
  level.sentrySettings["sentry_minigun"].headIcon = true;
  level.sentrySettings["sentry_minigun"].teamSplash = "used_sentry";
  level.sentrySettings["sentry_minigun"].shouldSplash = false;
  level.sentrySettings["sentry_minigun"].voDestroyed = "sentry_destroyed";
  level.sentrySettings["sentry_minigun"].xpPopup = "destroyed_sentry";
  level.sentrySettings["sentry_minigun"].lightFXTag = "tag_fx";

  level.sentrySettings["sam_turret"] = spawnStruct();
  level.sentrySettings["sam_turret"].health = 999999;
  level.sentrySettings["sam_turret"].maxHealth = 1000;
  level.sentrySettings["sam_turret"].burstMin = 20;
  level.sentrySettings["sam_turret"].burstMax = 120;
  level.sentrySettings["sam_turret"].pauseMin = 0.15;
  level.sentrySettings["sam_turret"].pauseMax = 0.35;
  level.sentrySettings["sam_turret"].sentryModeOn = "manual_target";
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
  level.sentrySettings["sam_turret"].xpPopup = undefined;
  level.sentrySettings["sam_turret"].lightFXTag = "tag_fx";

  level._effect["sentry_overheat_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
  level._effect["sentry_sparks_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");

  SetDevDvarIfUninitialized("scr_sentry_timeout", 90.0);
}

tryUseAutoSentry(lifeId, streakName) {
  result = self giveSentry("sentry_minigun");
  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.sentrySettings["sentry_minigun"].streakName, self.origin);
  }

  return (result);
}

tryUseSAM(lifeId, streakName) {
  result = self giveSentry("sam_turret");
  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent(level.sentrySettings["sam_turret"].streakName, self.origin);
  }

  return (result);
}

giveSentry(sentryType) {
  self.last_sentry = sentryType;

  sentryGun = createSentryForPlayer(sentryType, self);

  self removePerks();

  self.carriedSentry = sentryGun;

  result = self setCarryingSentry(sentryGun, true);

  self.carriedSentry = undefined;

  self thread waitRestorePerks();

  self.isCarrying = false;

  if(isDefined(sentryGun))
    return true;
  else
    return false;
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
    }
  }

  for(;;) {
    result = waittill_any_return("place_sentry", "cancel_sentry", "force_cancel_placement");

    if(!isDefined(sentryGun)) {
      self _enableWeapon();
      return true;
    }

    if(result == "cancel_sentry" || result == "force_cancel_placement") {
      if(!allowCancel && result == "cancel_sentry") {
        continue;
      }
      if(level.console) {
        killstreakWeapon = getKillstreakWeapon(level.sentrySettings[sentryGun.sentryType].streakName);
        if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon == getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName) && !(self GetWeaponsListItems()).size) {
          self _giveWeapon(killstreakWeapon, 0);
          self _setActionSlot(4, "weapon", killstreakWeapon);
        }
      }

      sentryGun sentry_setCancelled(result == "force_cancel_placement" && !isDefined(sentryGun.firstPlacement));
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
  if(!is_aliens()) {
    if(self HasWeapon("iw6_riotshield_mp")) {
      self.restoreWeapon = "iw6_riotshield_mp";
      self takeWeapon("iw6_riotshield_mp");
    }
  } else {
    if(self HasWeapon("iw5_alienriotshield_mp")) {
      self.restoreWeapon = "iw5_alienriotshield_mp";
      self.riotshieldAmmo = self GetAmmoCount("iw5_alienriotshield_mp");
      self takeWeapon("iw5_alienriotshield_mp");
    }
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

    if(is_aliens()) {
      if(self.restoreWeapon == "iw5_alienriotshield_mp") {
        self SetWeaponAmmoClip("iw5_alienriotshield_mp", self.riotshieldAmmo);
      }
    }

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
  sentryGun thread sentry_createBombSquadModel(sentryType);

  return (sentryGun);
}

sentry_initSentry(sentryType, owner) {
  self.sentryType = sentryType;
  self.canBePlaced = true;

  self setModel(level.sentrySettings[self.sentryType].modelBase);
  self.shouldSplash = true;
  self.firstPlacement = true;

  self setCanDamage(true);
  switch (sentryType) {
    case "minigun_turret":
    case "minigun_turret_1":
    case "minigun_turret_2":
    case "minigun_turret_3":
    case "minigun_turret_4":
    case "gl_turret":
    case "gl_turret_1":
    case "gl_turret_2":
    case "gl_turret_3":
    case "gl_turret_4":
      self SetLeftArc(80);
      self SetRightArc(80);
      self SetBottomArc(50);
      self SetDefaultDropPitch(0.0);
      self.originalOwner = owner;
      break;
    case "sam_turret":
    case "scramble_turret":
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
  self thread sentry_timeOut();

  switch (sentryType) {
    case "minigun_turret":
    case "minigun_turret_1":
    case "minigun_turret_2":
    case "minigun_turret_3":
    case "minigun_turret_4":
      self.momentum = 0;
      self.heatLevel = 0;
      self.overheated = false;
      self thread sentry_heatMonitor();
      break;
    case "gl_turret":
    case "gl_turret_1":
    case "gl_turret_2":
    case "gl_turret_3":
    case "gl_turret_4":
      self.momentum = 0;
      self.heatLevel = 0;
      self.cooldownWaitTime = 0;
      self.overheated = false;
      self thread turret_heatMonitor();
      self thread turret_coolMonitor();
      break;
    case "sam_turret":
    case "scramble_turret":
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

sentry_createBombSquadModel(sentryType) {
  if(isDefined(level.sentrySettings[sentryType].modelBombSquad)) {
    bombSquadModel = spawn("script_model", self.origin);
    bombSquadModel.angles = self.angles;
    bombSquadModel hide();

    bombSquadModel thread maps\mp\gametypes\_weapons::bombSquadVisibilityUpdater(self.owner);
    bombSquadModel setModel(level.sentrySettings[sentryType].modelBombSquad);
    bombSquadModel LinkTo(self);
    bombSquadModel SetContents(0);
    self.bombSquadModel = bombSquadModel;

    self waittill("death");

    if(isDefined(bombSquadModel)) {
      bombSquadModel delete();
    }
  }
}

sentry_handleDamage() {
  self endon("carried");
  self maps\mp\gametypes\_damage::monitorDamage(level.sentrySettings[self.sentryType].maxHealth, "sentry", ::sentryHandleDeathDamage, ::sentryModifyDamage, true);
}

sentryModifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  if(type == "MOD_MELEE") {
    modifiedDamage = self.maxhealth * 0.34;
  }

  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

sentryHandleDeathDamage(attacker, weapon, type, damage) {
  config = level.sentrySettings[self.sentryType];
  notifyAttacker = self maps\mp\gametypes\_damage::onKillstreakKilled(attacker, weapon, type, damage, config.xpPopup, config.voDestroyed);
  if(notifyAttacker) {
    attacker notify("destroyed_equipment");
  }
}

sentry_watchDisabled() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("emp_damage", attacker, duration);

    self maps\mp\gametypes\_weapons::stopBlinkingLight();
    playFXOnTag(getfx("emp_stun"), self, "tag_aim");

    self SetDefaultDropPitch(40);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);

    wait(duration);

    self SetDefaultDropPitch(-89.0);
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOn);
    self thread maps\mp\gametypes\_weapons::doBlinkingLight(level.sentrySettings[self.sentryType].lightFXTag);
  }
}

sentry_handleDeath() {
  self endon("carried");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self FreeEntitySentient();

  self setModel(level.sentrySettings[self.sentryType].modelDestroyed);

  self sentry_setInactive();
  self SetDefaultDropPitch(40);
  self SetSentryOwner(undefined);
  if(isDefined(self.inUseBy)) {
    self useby(self.inUseBy);
  }
  self SetTurretMinimapVisible(false);

  if(isDefined(self.ownerTrigger))
    self.ownerTrigger delete();

  self playSound("sentry_explode");

  switch (self.sentryType) {
    case "minigun_turret":
    case "gl_turret":
      self.forceDisable = true;
      self TurretFireDisable();
      break;
    default:
      break;
  }

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
    playFXOnTag(getFx("sentry_sparks_mp"), self, "tag_aim");
    self playSound("sentry_explode_smoke");
    for(smokeTime = 8; smokeTime > 0; smokeTime -= 0.4) {
      playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");
      wait(0.4);
    }
    playFX(getFx("sentry_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  }

  self maps\mp\gametypes\_weapons::equipmentDeleteVfx();

  if(isDefined(self.killCamEnt))
    self.killCamEnt delete();

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
    if(self.sentryType == "sam_turret" || self.sentryType == "scramble_turret")
      self setMode(level.sentrySettings[self.sentryType].sentryModeOff);

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
    if(IsAlive(self) && self IsTouching(turret.ownerTrigger) && !isDefined(turret.inUseBy) && !isDefined(turret.carriedBy) && self IsOnGround()) {
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

    if(isDefined(self.carriedBy))
      continue;
    if(isDefined(self.inUseBy))
      continue;
    if(!isReallyAlive(player))
      continue;
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

      if(self.heatLevel >= level.sentrySettings[self.sentryType].overheatTime)
        barFrac = 1;
      else
        barFrac = self.heatLevel / level.sentrySettings[self.sentryType].overheatTime;
      player.turret_overheat_bar updateBar(barFrac);

      if(string_starts_with(self.sentryType, "minigun_turret"))
        minigun_turret = "minigun_turret";

      if(self.forceDisable || self.overheated) {
        self TurretFireDisable();
        player.turret_overheat_bar.bar.color = colorOverheated;
        playingHeatFX = false;
      } else if(self.heatLevel > level.sentrySettings[self.sentryType].overheatTime * 0.75 && string_starts_with(self.sentryType, "minigun_turret")) {
        player.turret_overheat_bar.bar.color = colorUnstable;
        if(RandomIntRange(0, 10) < 6)
          self TurretFireEnable();
        else
          self TurretFireDisable();
        if(!playingHeatFX) {
          playingHeatFX = true;
          self thread PlayHeatFX();
        }
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

  self.owner waittill("killstreak_disowned");

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

sentry_moving_platform_death(data) {
  self notify("death");
}

sentry_setPlaced() {
  self setModel(level.sentrySettings[self.sentryType].modelBase);

  if(self GetMode() == "manual")
    self SetMode(level.sentrySettings[self.sentryType].sentryModeOff);

  self thread sentry_handleDamage();
  self thread sentry_handleDeath();

  self setSentryCarrier(undefined);
  self setCanDamage(true);

  switch (self.sentryType) {
    case "minigun_turret":
    case "minigun_turret_1":
    case "minigun_turret_2":
    case "minigun_turret_3":
    case "minigun_turret_4":
    case "gl_turret":
    case "gl_turret_1":
    case "gl_turret_2":
    case "gl_turret_3":
    case "gl_turret_4":
      self.angles = self.carriedBy.angles;

      if(IsAlive(self.originalOwner))
        self.originalOwner setLowerMessage("pickup_hint", level.sentrySettings[self.sentryType].ownerHintString, 3.0, undefined, undefined, undefined, undefined, undefined, true);

      self.ownerTrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
      self.ownerTrigger EnableLinkTo();
      self.ownerTrigger LinkTo(self);
      assert(isDefined(self.ownerTrigger));
      self.originalOwner thread turret_handlePickup(self);
      self thread turret_handleUse();
      break;
    default:
      break;
  }

  self sentry_makeSolid();

  if(isDefined(self.bombSquadModel)) {
    self.bombSquadModel Show();
    level notify("update_bombsquad");
  }

  self.carriedBy forceUseHintOff();
  self.carriedBy = undefined;
  self.firstPlacement = undefined;

  if(isDefined(self.owner)) {
    self.owner.isCarrying = false;
    self make_entity_sentient_mp(self.owner.team);
    if(IsSentient(self)) {
      self SetThreatBiasGroup("DogsDontAttack");
    }
    self.owner notify("new_sentry", self);
  }

  self sentry_setActive();

  data = spawnStruct();
  if(isDefined(self.moving_platform)) {
    data.linkparent = self.moving_platform;
  }
  data.endonString = "carried";
  data.deathOverrideCallback = ::sentry_moving_platform_death;
  self thread maps\mp\_movers::handle_moving_platforms(data);

  if(self.sentryType != "multiturret")
    self playSound("sentry_gun_plant");

  self thread maps\mp\gametypes\_weapons::doBlinkingLight(level.sentrySettings[self.sentryType].lightFXTag);

  self notify("placed");
}

sentry_setCancelled(playDestroyVfx) {
  if(isDefined(self.carriedBy)) {
    owner = self.carriedBy;
    owner ForceUseHintOff();
    owner.isCarrying = undefined;

    owner.carriedItem = undefined;

    owner _enableWeapon();

    if(isDefined(self.bombSquadModel))
      self.bombSquadModel delete();
  }

  if(isDefined(playDestroyVfx) && playDestroyVfx) {
    self maps\mp\gametypes\_weapons::equipmentDeleteVfx();
  }

  self delete();
}

sentry_setCarried(carrier) {
  assert(isPlayer(carrier));
  if(isDefined(self.originalOwner))
    assertEx(carrier == self.originalOwner, "sentry_setCarried() specified carrier does not own this sentry");
  else
    assertEx(carrier == self.owner, "sentry_setCarried() specified carrier does not own this sentry");

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

  self FreeEntitySentient();

  self SetDefaultDropPitch(-89.0);

  self sentry_setInactive();

  if(isDefined(self GetLinkedParent()))
    self unlink();

  self notify("carried");

  if(isDefined(self.bombSquadModel))
    self.bombSquadModel Hide();
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

    if(isDefined(placement["entity"])) {
      sentryGun.moving_platform = placement["entity"];
    } else {
      sentryGun.moving_platform = undefined;
    }

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

  if(self.canBePlaced)
    self sentry_setPlaced();
  else {
    self sentry_setCancelled(false);
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
    if(level.teamBased)
      self maps\mp\_entityheadicons::setTeamHeadIcon(self.team, (0, 0, 65));
    else
      self maps\mp\_entityheadicons::setPlayerHeadIcon(self.owner, (0, 0, 65));
  }

  self makeUsable();

  foreach(player in level.players) {
    switch (self.sentryType) {
      case "minigun_turret":
      case "minigun_turret_1":
      case "minigun_turret_2":
      case "minigun_turret_3":
      case "minigun_turret_4":
      case "gl_turret":
      case "gl_turret_1":
      case "gl_turret_2":
      case "gl_turret_3":
      case "gl_turret_4":
        self enablePlayerUse(player);
        if(is_aliens()) {
          entNum = self GetEntityNumber();
          self addToTurretList(entNum);
        }
        break;
      default:
        entNum = self GetEntityNumber();
        self addToTurretList(entNum);

        if(player == self.owner)
          self enablePlayerUse(player);
        else
          self disablePlayerUse(player);
        break;
    }
  }

  if(self.shouldSplash) {
    level thread teamPlayerCardSplash(level.sentrySettings[self.sentryType].teamSplash, self.owner, self.owner.team);
    self.shouldSplash = false;
  }

  if(self.sentryType == "sam_turret") {
    self thread sam_attackTargets();
  }

  if(self.sentryType == "scramble_turret") {
    self thread scrambleTurretAttackTargets();
  }

  self thread sentry_watchDisabled();
}

sentry_setInactive() {
  self setMode(level.sentrySettings[self.sentryType].sentryModeOff);
  self makeUnusable();
  self FreeEntitySentient();

  self maps\mp\gametypes\_weapons::stopBlinkingLight();

  entNum = self GetEntityNumber();
  switch (self.sentryType) {
    case "gl_turret":
      break;
    default:
      self removeFromTurretList(entNum);
      break;
  }

  if(level.teamBased)
    self maps\mp\_entityheadicons::setTeamHeadIcon("none", (0, 0, 0));
  else if(isDefined(self.owner))
    self maps\mp\_entityheadicons::setPlayerHeadIcon(undefined, (0, 0, 0));
}

sentry_makeSolid() {
  self makeTurretSolid();
}

sentry_makeNotSolid() {
  self setContents(0);
}

isFriendlyToSentry(sentryGun) {
  if(level.teamBased && self.team == sentryGun.team)
    return true;

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
  if(!is_aliens()) {
    lifeSpan = GetDvarFloat("scr_sentry_timeout");
  }

  while(lifeSpan) {
    wait(1.0);
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    if(!isDefined(self.carriedBy))
      lifeSpan = max(0, lifeSpan - 1.0);
  }

  if(isDefined(self.owner)) {
    if(self.sentryType == "sam_turret")
      self.owner thread leaderDialogOnPlayer("sam_gone");
    else if(self.sentryType == "scramble_turret")
      self.owner thread leaderDialogOnPlayer("sam_gone");
    else
      self.owner thread leaderDialogOnPlayer("sentry_gone");
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
      self notify("bullet_fired");
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
    if(self.heatLevel != lastHeatLevel)
      wait(fireTime);
    else
      self.heatLevel = max(0, self.heatLevel - 0.05);

    if(self.heatLevel > overheatTime) {
      self.overheated = true;
      self thread PlayHeatFX();
      switch (self.sentryType) {
        case "minigun_turret":
        case "minigun_turret_1":
        case "minigun_turret_2":
        case "minigun_turret_3":
        case "minigun_turret_4":

          playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

          break;
        default:
          break;
      }

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
      switch (self.sentryType) {
        case "gl_turret":
          playFXOnTag(getFx("sentry_smoke_mp"), self, "tag_aim");

          break;
        default:
          break;
      }

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

    if(!isDefined(self.carriedBy))
      self playSound("sentry_gun_beep");
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
        entityList = level.UAVModels[level.otherTeam[self.team]];
      }

      foreach(uav in entityList) {
        if(isDefined(uav.isLeaving) && uav.isLeaving) {
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
        if(SightTracePassed(eyeLine, heli.origin, false, self)) {
          return heli;
        }
      }

      foreach(uav in level.remote_uav) {
        if(!isDefined(uav)) {
          continue;
        }
        if(isDefined(uav.team) && uav.team == self.team) {
          continue;
        }
        if(SightTracePassed(eyeLine, uav.origin, false, self, uav)) {
          return uav;
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
        if(SightTracePassed(eyeLine, heli.origin, false, self)) {
          return heli;
        }
      }

      foreach(uav in level.remote_uav) {
        if(!isDefined(uav)) {
          continue;
        }
        if(isDefined(uav.owner) && isDefined(self.owner) && uav.owner == self.owner) {
          continue;
        }
        if(SightTracePassed(eyeLine, uav.origin, false, self, uav)) {
          return uav;
        }
      }

    }

    self ClearTargetEntity();
    return undefined;
  } else {
    if(!SightTracePassed(eyeLine, self.samTargetEnt.origin, false, self)) {
      self ClearTargetEntity();
      return undefined;
    }

    return self.samTargetEnt;
  }
}

sam_fireOnTarget() {
  if(isDefined(self.samTargetEnt)) {
    if(self.samTargetEnt == level.ac130.planemodel && !isDefined(level.ac130player)) {
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

  while(isDefined(self.samTargetEnt) && isDefined(self GetTurretTarget(true)) && self GetTurretTarget(true) == self.samTargetEnt) {
    wait(0.05);
  }

  self LaserOff();
  self.laser_on = false;
}

sam_watchCrashing() {
  self endon("death");
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

scrambleTurretAttackTargets() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");

  self.scrambleTargetEnt = undefined;

  while(true) {
    self.scrambleTargetEnt = scramble_acquireTarget();

    if(isDefined(self.scrambleTargetEnt) && isDefined(self.scrambleTargetEnt.scrambled) && !self.scrambleTargetEnt.scrambled)
      self scrambleTarget();

    wait(0.05);
  }
}

scramble_acquireTarget() {
  return sam_acquireTarget();
}

scrambleTarget() {
  if(isDefined(self.scrambleTargetEnt)) {
    if(self.scrambleTargetEnt == level.ac130.planemodel && !isDefined(level.ac130player)) {
      self.scrambleTargetEnt = undefined;
      self ClearTargetEntity();
      return;
    }

    self SetTargetEntity(self.scrambleTargetEnt);
    self waittill("turret_on_target");

    if(!isDefined(self.scrambleTargetEnt)) {
      return;
    }
    if(!self.laser_on) {
      self thread scramble_watchLaser();
      self thread scramble_watchCrashing();
      self thread scramble_watchLeaving();
      self thread scramble_watchLineOfSight();
    }

    wait(2.0);

    if(!isDefined(self.scrambleTargetEnt)) {
      return;
    }
    if(self.scrambleTargetEnt == level.ac130.planemodel && !isDefined(level.ac130player)) {
      self.scrambleTargetEnt = undefined;
      self ClearTargetEntity();
      return;
    }

    if(!isDefined(self.scrambleTargetEnt)) {
      return;
    }
    if(isDefined(self.carriedBy)) {
      return;
    }
    self ShootTurret();

    self thread setScrambled();

    self notify("death");
  }
}

setScrambled() {
  scrambledTarget = self.scrambleTargetEnt;

  scrambledTarget notify("scramble_fired", self.owner);

  scrambledTarget endon("scramble_fired");
  scrambledTarget endon("death");

  scrambledTarget thread maps\mp\killstreaks\_helicopter::heli_targeting();

  scrambledTarget.scrambled = true;
  scrambledTarget.secondOwner = self.owner;

  scrambledTarget notify("findNewTarget");

  wait 30;

  if(isDefined(scrambledTarget)) {
    scrambledTarget.scrambled = false;
    scrambledTarget.secondOwner = undefined;

    scrambledTarget thread maps\mp\killstreaks\_helicopter::heli_targeting();
  }
}

scramble_watchLineOfSight() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self.scrambleTargetEnt) && isDefined(self GetTurretTarget(true)) && self GetTurretTarget(true) == self.scrambleTargetEnt) {
    eyeLine = self GetTagOrigin("tag_laser");
    if(!SightTracePassed(eyeLine, self.scrambleTargetEnt.origin, false, self, self.scrambleTargetEnt)) {
      self ClearTargetEntity();
      self.scrambleTargetEnt = undefined;
      break;
    }

    wait(0.05);
  }
}

scramble_watchLaser() {
  self endon("death");

  self LaserOn();
  self.laser_on = true;

  while(isDefined(self.scrambleTargetEnt) && isDefined(self GetTurretTarget(true)) && self GetTurretTarget(true) == self.scrambleTargetEnt) {
    wait(0.05);
  }

  self LaserOff();
  self.laser_on = false;
}

scramble_watchCrashing() {
  self endon("death");
  self.scrambleTargetEnt endon("death");

  if(!isDefined(self.scrambleTargetEnt.heliType)) {
    return;
  }
  self.scrambleTargetEnt waittill("crashing");
  self ClearTargetEntity();
  self.scrambleTargetEnt = undefined;
}

scramble_watchLeaving() {
  self endon("death");
  self.scrambleTargetEnt endon("death");

  if(!isDefined(self.scrambleTargetEnt.model)) {
    return;
  }
  if(self.scrambleTargetEnt.model == "vehicle_uav_static_mp") {
    self.scrambleTargetEnt waittill("leaving");
    self ClearTargetEntity();
    self.scrambleTargetEnt = undefined;
  }
}