/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\perks\_perkfunctions.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perks;

setCrouchMovement() {
  self thread crouchStateListener();

  self crouchMovementSetSpeed();
}

crouchStateListener() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetCrouchMovement");

  self notifyOnPlayerCommand("adjustedStance", "+stance");
  self notifyOnPlayerCommand("adjustedStance", "+goStand");

  for(;;) {
    self waittill_any("adjustedStance", "sprint_begin", "weapon_change");

    wait .5;
    self crouchMovementSetSpeed();
  }
}

crouchMovementSetSpeed() {
  self.stanceCrouchMovement = self GetStance();

  scaler = 0;
  if(isDefined(self.adrenaline_speed_scalar)) {
    scaler = self.adrenaline_speed_scalar;
  } else if(self.stanceCrouchMovement == "crouch") {
    scaler = self.crouch_speed_scalar;
  } else if(_hasPerk("specialty_lightweight")) {
    scaler = lightWeightScalar();
  }

  self.moveSpeedScaler = scaler;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

unsetCrouchMovement() {
  self notify("unsetCrouchMovement");

  scaler = 1;

  if(_hasPerk("specialty_lightweight")) {
    scaler = lightWeightScalar();
  }

  self.moveSpeedScaler = scaler;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

setPersonalUav() {
  portable_radar = spawn("script_model", self.origin);
  portable_radar.team = self.team;

  portable_radar makePortableRadar(self);
  self.personalRadar = portable_radar;

  self thread radarMover(portable_radar);
}

radarMover(portableRadar) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("personal_uav_remove");
  self endon("personal_uav_removed");

  for(;;) {
    portableRadar MoveTo(self.origin, .05);
    wait(0.05);
  }
}

unsetPersonalUav() {
  if(isDefined(self.personalRadar)) {
    self notify("personal_uav_removed");
    level maps\mp\gametypes\_portable_radar::deletePortableRadar(self.personalRadar);
    self.personalRadar = undefined;
  }
}

setOverkillPro() {}

unsetOverkillPro() {}

setEMPImmune() {}

unsetEMPImmune() {}

setAutoSpot() {
  self autoSpotAdsWatcher();
  self autoSpotDeathWatcher();
}

autoSpotDeathWatcher() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");

  self AutoSpotOverlayOff();
}

unsetAutoSpot() {
  self notify("endAutoSpotAdsWatcher");
  self AutoSpotOverlayOff();
}

autoSpotAdsWatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");

  spotter = false;

  for(;;) {
    wait(0.05);

    if(self IsUsingTurret()) {
      self AutoSpotOverlayOff();
      continue;
    }

    adsLevel = self PlayerADS();

    if(adsLevel < 1 && spotter) {
      spotter = false;
      self AutoSpotOverlayOff();
    }

    if(adsLevel < 1 && !spotter) {
      continue;
    }

    if(adsLevel == 1 && !spotter) {
      spotter = true;
      self AutoSpotOverlayOn();
    }
  }
}

setRegenSpeed() {}

unsetRegenSpeed() {}

setSharpFocus() {
  self setViewKickScale(.50);
}

unsetSharpFocus() {
  self setViewKickScale(1);
}

setDoubleLoad() {
  self endon("death");
  self endon("disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");

    weapons = self GetWeaponsList("primary");

    foreach(weapon in weapons) {
      ammoInClip = self GetWeaponAmmoClip(weapon);
      clipSize = weaponClipSize(weapon);
      difference = clipSize - ammoInClip;
      ammoReserves = self getWeaponAmmoStock(weapon);

      if(ammoInClip != clipSize && ammoReserves > 0) {
        if(ammoInClip + ammoReserves >= clipSize) {
          self setWeaponAmmoClip(weapon, clipSize);
          self setWeaponAmmoStock(weapon, (ammoReserves - difference));
        } else {
          self setWeaponAmmoClip(weapon, ammoInClip + ammoReserves);

          if(ammoReserves - difference > 0) {
            self setWeaponAmmoStock(weapon, (ammoReserves - difference));
          } else {
            self setWeaponAmmoStock(weapon, 0);
          }
        }
      }
    }
  }
}

unsetDoubleLoad() {
  self notify("endDoubleLoad");
}

setMarksman(power) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(power)) {
    power = 10;
  } else {
    power = Int(power) * 2;
  }

  self setRecoilScale(power);
  self.recoilScale = power;
}

unsetMarksman() {
  self setRecoilScale(0);
  self.recoilScale = 0;
}

setStunResistance(power) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(power)) {
    self.stunScaler = .5;
  } else {
    self.stunScaler = (Int(power) / 10);
  }
}

unsetStunResistance() {
  self.stunScaler = 1;
}

setSteadyAimPro() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self setaimspreadmovementscale(0.5);
}

unsetSteadyAimPro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1.0);
}

blastshieldUseTracker(perkName, useFunc) {
  self endon("death");
  self endon("disconnect");
  self endon("end_perkUseTracker");
  level endon("game_ended");

  for(;;) {
    self waittill("empty_offhand");

    if(!isOffhandWeaponEnabled()) {
      continue;
    }

    self[[useFunc]](self _hasPerk("_specialty_blastshield"));
  }
}

perkUseDeathTracker() {
  self endon("disconnect");

  self waittill("death");
  self._usePerkEnabled = undefined;
}

setRearView() {}

unsetRearView() {
  self notify("end_perkUseTracker");
}

setEndGame() {
  if(isDefined(self.endGame)) {
    return;
  }

  self.maxhealth = (maps\mp\gametypes\_tweakables::getTweakableValue("player", "maxhealth") * 4);
  self.health = self.maxhealth;
  self.endGame = true;
  self.attackerTable[0] = "";
  self visionSetNakedForPlayer("end_game", 5);
  self thread endGameDeath(7);
  self.hasDoneCombat = true;
}

unsetEndGame() {
  self notify("stopEndGame");
  self.endGame = undefined;
  revertVisionSetForPlayer();

  if(!isDefined(self.endGameTimer)) {
    return;
  }

  self.endGameTimer destroyElem();
  self.endGameIcon destroyElem();
}

endGameDeath(duration) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");

  wait(duration + 1);

  self _suicide();
}

stanceStateListener() {
  self endon("death");
  self endon("disconnect");

  self notifyOnPlayerCommand("adjustedStance", "+stance");

  for(;;) {
    self waittill("adjustedStance");
    if(self.moveSPeedScaler != 0) {
      continue;
    }

    unsetSiege();
  }
}

jumpStateListener() {
  self endon("death");
  self endon("disconnect");

  self notifyOnPlayerCommand("jumped", "+goStand");

  for(;;) {
    self waittill("jumped");
    if(self.moveSPeedScaler != 0) {
      continue;
    }

    unsetSiege();
  }
}

unsetSiege() {
  self.moveSpeedScaler = level.basePlayerMoveScale;

  self resetSpreadOverride();
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  self player_recoilScaleOff();
  self allowJump(true);
}

setSaboteur() {
  self.objectiveScaler = 2;
}

unsetSaboteur() {
  self.objectiveScaler = 1;
}

setLightWeight(power) {
  if(!isDefined(power)) {
    power = 10;
  }

  self.moveSpeedScaler = lightWeightScalar(power);
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

unsetLightWeight() {
  self.moveSpeedScaler = level.basePlayerMoveScale;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

setBlackBox() {
  self.killStreakScaler = 1.5;
}

unsetBlackBox() {
  self.killStreakScaler = 1;
}

setSteelNerves() {
  self givePerk("specialty_bulletaccuracy", true);
  self givePerk("specialty_holdbreath", false);
}

unsetSteelNerves() {
  self _unsetperk("specialty_bulletaccuracy");
  self _unsetperk("specialty_holdbreath");
}

setDelayMine() {}

unsetDelayMine() {}

setLocalJammer() {
  if(!self isEMPed()) {
    self SetMotionTrackerVisible(false);
  }
}

unsetLocalJammer() {
  self SetMotionTrackerVisible(true);
}

setThermal() {
  self ThermalVisionOn();
}

unsetThermal() {
  self ThermalVisionOff();
}

setOneManArmy() {
  self thread oneManArmyWeaponChangeTracker();
}

unsetOneManArmy() {
  self notify("stop_oneManArmyTracker");
}

oneManArmyWeaponChangeTracker() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  for(;;) {
    self waittill("weapon_change", newWeapon);

    if(newWeapon != "onemanarmy_mp") {
      continue;
    }

    self thread selectOneManArmyClass();
  }
}

isOneManArmyMenu(menu) {
  if(menu == game["menu_onemanarmy"]) {
    return true;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && menu == game["menu_onemanarmy_defaults_splitscreen"]) {
    return true;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && menu == game["menu_onemanarmy_custom_splitscreen"]) {
    return true;
  }

  return false;
}

selectOneManArmyClass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self _disableWeaponSwitch();
  self _disableOffhandWeapons();
  self _disableUsability();

  self openPopupMenu(game["menu_onemanarmy"]);

  self thread closeOMAMenuOnDeath();

  self waittill("menuresponse", menu, className);

  self _enableWeaponSwitch();
  self _enableOffhandWeapons();
  self _enableUsability();

  if(className == "back" || !isOneManArmyMenu(menu) || self isUsingRemote()) {
    if(self getCurrentWeapon() == "onemanarmy_mp") {
      self _disableWeaponSwitch();
      self _disableOffhandWeapons();
      self _disableUsability();
      self switchToWeapon(self getLastWeapon());
      self waittill("weapon_change");
      self _enableWeaponSwitch();
      self _enableOffhandWeapons();
      self _enableUsability();
    }
    return;
  }

  self thread giveOneManArmyClass(className);
}

closeOMAMenuOnDeath() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");

  self waittill("death");

  self _enableWeaponSwitch();
  self _enableOffhandWeapons();
  self _enableUsability();

  self closePopupMenu();
}

giveOneManArmyClass(className) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(self _hasPerk("specialty_omaquickchange")) {
    changeDuration = 3.0;
    self playLocalSound("foly_onemanarmy_bag3_plr");
    self playSoundToTeam("foly_onemanarmy_bag3_npc", "allies", self);
    self playSoundToTeam("foly_onemanarmy_bag3_npc", "axis", self);
  } else {
    changeDuration = 6.0;
    self playLocalSound("foly_onemanarmy_bag6_plr");
    self playSoundToTeam("foly_onemanarmy_bag6_npc", "allies", self);
    self playSoundToTeam("foly_onemanarmy_bag6_npc", "axis", self);
  }

  self thread omaUseBar(changeDuration);

  self _disableWeapon();
  self _disableOffhandWeapons();
  self _disableUsability();

  wait(changeDuration);

  self _enableWeapon();
  self _enableOffhandWeapons();
  self _enableUsability();

  self.OMAClassChanged = true;

  self maps\mp\gametypes\_class::giveAndApplyLoadout(self.pers["team"], className, false);

  if(isDefined(self.carryFlag)) {
    self attach(self.carryFlag, "J_spine4", true);
  }

  self notify("changed_kit");
  level notify("changed_kit");
}

omaUseBar(duration) {
  self endon("disconnect");

  useBar = createPrimaryProgressBar(0, -25);
  useBarText = createPrimaryProgressBarText(0, -25);
  useBarText setText(&"MPUI_CHANGING_KIT");

  useBar updateBar(0, 1 / duration);
  for(waitedTime = 0; waitedTime < duration && isAlive(self) && !level.gameEnded; waitedTime += 0.05) {
    wait(0.05);
  }

  useBar destroyElem();
  useBarText destroyElem();
}

setBlastShield() {
  self SetWeaponHudIconOverride("primaryoffhand", "specialty_s1_temp");
}

unsetBlastShield() {
  self SetWeaponHudIconOverride("primaryoffhand", "none");
}

setFreefall() {}

unsetFreefall() {}

setTacticalInsertion() {
  self _giveWeapon("s1_tactical_insertion_device_mp", 0);
  self giveStartAmmo("s1_tactical_insertion_device_mp");

  self thread monitorTIUse();
}

clearPreviousTISpawnpoint() {
  self notify("clearPreviousTISpawnpointStarted");
  self endon("clearPreviousTISpawnpointStarted");

  self waittill_any("disconnect", "joined_team", "joined_spectators");

  if(isDefined(self.setSpawnpoint)) {
    self deleteTI(self.setSpawnpoint);
  }
}

updateTISpawnPosition() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  while(isReallyAlive(self)) {
    if(self isValidTISpawnPosition()) {
      self.TISpawnPosition = self.origin;
    }

    wait(0.05);
  }
}

isValidTISpawnPosition() {
  if(Canspawn(self.origin) && self IsOnGround()) {
    return true;
  } else {
    return false;
  }
}

monitorTIUse() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  self thread clearPreviousTISpawnpoint();
  self thread updateTISpawnPosition();
  self thread monitorThirdPersonModel();

  for(;;) {
    self waittill("grenade_fire", lightstick, weapName);

    if(weapName != "s1_tactical_insertion_device_mp") {
      continue;
    }

    if(isDefined(self.setSpawnPoint)) {
      self deleteTI(self.setSpawnPoint);
    }

    if(!isDefined(self.TISpawnPosition)) {
      continue;
    }

    if(self touchingBadTrigger()) {
      continue;
    }

    TIGroundPosition = playerPhysicsTrace(self.TISpawnPosition + (0, 0, 16), self.TISpawnPosition - (0, 0, 2048)) + (0, 0, 1);

    glowStick = spawn("script_model", TIGroundPosition);
    glowStick.angles = self.angles;
    glowStick.team = self.team;
    glowStick.owner = self;
    glowStick.enemyTrigger = spawn("script_origin", TIGroundPosition);
    glowStick thread GlowStickSetupAndWaitForDeath(self);
    glowStick.playerSpawnPos = self.TISpawnPosition;
    glowStick SetOtherEnt(self);
    glowStick make_entity_sentient_mp(self.team, true);
    glowStick playLoopSound("tac_insert_spark_lp");

    self.setSpawnPoint = glowStick;
    return;
  }
}

monitorThirdPersonModel() {
  self notify("third_person_ti");
  self endon("third_person_ti");

  while(true) {
    if(isDefined(self.attachModelTI)) {
      self detach("npc_tactical_insertion_device", "tag_inhand");
      self.attachModelTI = undefined;
    }

    self waittillmatch("grenade_pullback", "s1_tactical_insertion_device_mp");

    self attach("npc_tactical_insertion_device", "tag_inhand", true);
    self.attachModelTI = "npc_tactical_insertion_device";

    self waitForTimeOrNotify(3, "death");

    self detach("npc_tactical_insertion_device", "tag_inhand");
    self.attachModelTI = undefined;
  }
}

GlowStickSetupAndWaitForDeath(owner) {
  self setModel(level.spawnGlowModel["enemy"]);

  self thread maps\mp\gametypes\_damage::setEntityDamageCallback(100, undefined, ::onDeathTI, undefined, false);
  self thread GlowStickEnemyUseListener(owner);
  self thread GlowStickUseListener(owner);
  self thread GlowStickTeamUpdater(self.team, level.spawnGlow["enemy"], owner);

  dummyGlowStick = spawn("script_model", self.origin + (0, 0, 0));
  dummyGlowStick.angles = self.angles;
  dummyGlowStick setModel(level.spawnGlowModel["friendly"]);
  dummyGlowStick setContents(0);
  dummyGlowStick thread GlowStickTeamUpdater(self.team, level.spawnGlow["friendly"], owner);

  dummyGlowStick playLoopSound("tac_insert_spark_lp");

  self waittill("death");

  dummyGlowStick stopLoopSound();
  dummyGlowStick delete();
}

GlowStickTeamUpdater(ownerTeam, showEffect, owner) {
  self endon("death");

  wait(0.05);

  angles = self getTagAngles("tag_fire_fx");
  fxEnt = SpawnFx(showEffect, self getTagOrigin("tag_fire_fx"), anglesToForward(angles), anglesToUp(angles));
  TriggerFx(fxEnt);

  self thread perk_deleteOnDeath(fxEnt);

  for(;;) {
    self hide();
    fxEnt hide();
    foreach(player in level.players) {
      if(player.team == ownerTeam && level.teamBased && showEffect == level.spawnGlow["friendly"]) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      } else if(player.team != ownerTeam && level.teamBased && showEffect == level.spawnGlow["enemy"]) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      } else if(!level.teamBased && player == owner && showEffect == level.spawnGlow["friendly"]) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      } else if(!level.teamBased && player != owner && showEffect == level.spawnGlow["enemy"]) {
        self showToPlayer(player);
        fxEnt showToPlayer(player);
      }
    }

    level waittill_either("joined_team", "player_spawned");
  }
}

perk_deleteOnDeath(ent) {
  self waittill("death");
  if(isDefined(ent)) {
    ent delete();
  }
}

onDeathTI(attacker, weapon, meansOfDeath, damage) {
  if(isDefined(self.owner) && attacker != self.owner) {
    attacker notify("destroyed_explosive");
    attacker thread maps\mp\gametypes\_missions::processChallenge("ch_darkbringer");
  }

  playFX(level.spawnFire, self.origin);
  self.owner thread leaderDialogOnPlayer("ti_destroyed", undefined, undefined, self.origin);

  attacker thread deleteTI(self);
}

GlowStickUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  self setCursorHint("HINT_NOICON");
  self setHintString(&"MP_PATCH_PICKUP_TI");

  self thread updateEnemyUse(owner);

  for(;;) {
    self waittill("trigger", player);

    player playSound("tac_insert_pickup_plr");
    player thread setTacticalInsertion();
    player thread deleteTI(self);
  }
}

updateEnemyUse(owner) {
  self endon("death");

  for(;;) {
    self setSelfUsable(owner);
    level waittill_either("joined_team", "player_spawned");
  }
}

deleteTI(TI) {
  if(isDefined(TI.enemyTrigger)) {
    TI.enemyTrigger Delete();
  }

  TI stopLoopSound();
  TI Delete();
}

GlowStickEnemyUseListener(owner) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  self.enemyTrigger setCursorHint("HINT_NOICON");
  self.enemyTrigger setHintString(&"MP_PATCH_DESTROY_TI");
  self.enemyTrigger makeEnemyUsable(owner);

  for(;;) {
    self.enemyTrigger waittill("trigger", player);

    self thread onDeathTI(player);
  }
}

setPainted(attacker) {
  if(isPlayer(self)) {
    if(isDefined(attacker.specialty_paint_time) && !self _hasPerk("specialty_coldblooded")) {
      self.painted = true;
      self setPerk("specialty_radararrow", true, false);

      self thread unsetPainted(attacker.specialty_paint_time);
      self thread watchPaintedDeath();
    }
  }
}

watchPaintedDeath() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("unsetPainted");

  self waittill("death");

  self.painted = false;
}

unsetPainted(time) {
  self notify("painted_again");
  self endon("painted_again");

  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  wait(time);

  self.painted = false;
  self unsetPerk("specialty_radararrow", true);
  self notify("unsetPainted");
}

isPainted() {
  return (isDefined(self.painted) && self.painted);
}

setRefillGrenades() {
  if(isDefined(self.primaryGrenade)) {
    self GiveMaxAmmo(self.primaryGrenade);
  }
  if(isDefined(self.secondaryGrenade)) {
    self GiveMaxAmmo(self.secondaryGrenade);
  }
}

setFinalStand() {
  self givePerk("specialty_pistoldeath", false);
}

unsetFinalStand() {
  self _unsetperk("specialty_pistoldeath");
}

setCarePackage() {
  self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("airdrop_assault", false, false, self);
}

unsetCarePackage() {}

setUAV() {
  self thread maps\mp\killstreaks\_killstreaks::giveKillstreak("uav", false, false, self);
}

unsetUAV() {}

setStoppingPower() {
  self givePerk("specialty_bulletdamage", false);
  self thread watchStoppingPowerKill();
}

watchStoppingPowerKill() {
  self notify("watchStoppingPowerKill");
  self endon("watchStoppingPowerKill");
  self endon("disconnect");
  level endon("game_ended");

  self waittill("killed_enemy");

  self unsetStoppingPower();
}

unsetStoppingPower() {
  self _unsetperk("specialty_bulletdamage");
  self notify("watchStoppingPowerKill");
}

setJuiced(scale, time, hudCheck) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("end_game");

  self.isJuiced = true;

  if(!isDefined(scale)) {
    scale = 1.25;
  }

  self.moveSpeedScaler = scale;

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  if(level.splitscreen) {
    yOffset = 56;
    iconSize = 21;
  } else {
    yOffset = 80;
    iconSize = 32;
  }

  if(!isDefined(time)) {
    time = 7;
  }

  if(!isDefined(hudCheck) || hudCheck == true) {
    self.juicedTimer = createTimer("hudsmall", 1.0);
    self.juicedTimer setPoint("CENTER", "CENTER", 0, yOffset);
    self.juicedTimer setTimer(time);
    self.juicedTimer.color = (.8, .8, 0);
    self.juicedTimer.archived = false;
    self.juicedTimer.foreground = true;

    self.juicedIcon = self createIcon(level.specialty_juiced_icon, iconSize, iconSize);
    self.juicedIcon.alpha = 0;
    self.juicedIcon setParent(self.juicedTimer);
    self.juicedIcon setPoint("BOTTOM", "TOP");
    self.juicedIcon.archived = true;
    self.juicedIcon.sort = 1;
    self.juicedIcon.foreground = true;
    self.juicedIcon fadeOverTime(1.0);
    self.juicedIcon.alpha = 0.85;
  }

  self thread unsetJuicedOnDeath();
  self thread unsetJuicedOnRide();

  wait(time - 2);

  if(isDefined(self.juicedIcon)) {
    self.juicedIcon fadeOverTime(2.0);
    self.juicedIcon.alpha = 0.0;
  }
  if(isDefined(self.juicedTimer)) {
    self.juicedTimer fadeOverTime(2.0);
    self.juicedTimer.alpha = 0.0;
  }

  wait 2;

  self unsetJuiced();
}

unsetJuiced(death) {
  if(!isDefined(death)) {
    assert(isAlive(self));
    if(self isJuggernaut()) {
      assert(isDefined(self.juggMoveSpeedScaler));
      if(isDefined(self.juggMoveSpeedScaler)) {
        self.moveSpeedScaler = self.juggMoveSpeedScaler;
      } else {
        self.moveSpeedScaler = 0.7;
      }
    } else {
      self.moveSpeedScaler = level.basePlayerMoveScale;
      if(self _hasPerk("specialty_lightweight")) {
        self.moveSpeedScaler = lightWeightScalar();
      }
    }
    assert(isDefined(self.moveSpeedScaler));
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  }

  if(isDefined(self.juicedIcon)) {
    self.juicedIcon Destroy();
  }
  if(isDefined(self.juicedTimer)) {
    self.juicedTimer Destroy();
  }

  self.isJuiced = undefined;

  self notify("unset_juiced");
}

unsetJuicedOnRide() {
  self endon("disconnect");
  self endon("unset_juiced");

  for(;;) {
    wait(0.05);

    if(self isUsingRemote()) {
      self thread unsetJuiced();
      break;
    }
  }

}

unsetJuicedOnDeath() {
  self endon("disconnect");
  self endon("unset_juiced");

  self waittill_any("death", "faux_spawn");

  self thread unsetJuiced(true);
}

setLightArmorHP(newValue) {
  if(isDefined(newValue)) {
    self.lightArmorHP = newValue;
    if(isPlayer(self) && isDefined(self.maxLightArmorHP) && self.maxLightArmorHP > 0) {
      lightArmorPercent = clamp(self.lightArmorHP / self.maxLightArmorHP, 0, 1);
      self SetClientOmnvar("ui_light_armor_percent", lightArmorPercent);
    }
  } else {
    self.lightArmorHP = undefined;
    self.maxLightArmorHP = undefined;
    self SetClientOmnvar("ui_light_armor_percent", 0);
  }
}

setLightArmor(optionalArmorValue) {
  self notify("give_light_armor");

  if(isDefined(self.lightArmorHP)) {
    unsetLightArmor();
  }

  self thread removeLightArmorOnDeath();
  self thread removeLightArmorOnMatchEnd();

  if(isDefined(optionalArmorValue)) {
    self.maxLightArmorHP = optionalArmorValue;
  } else {
    self.maxLightArmorHP = 150;
  }

  self setLightArmorHP(self.maxLightArmorHP);
}

removeLightArmorOnDeath() {
  self endon("disconnect");
  self endon("give_light_armor");
  self endon("remove_light_armor");

  self waittill("death");
  unsetLightArmor();
}

unsetLightArmor() {
  self setLightArmorHP(undefined);

  self notify("remove_light_armor");
}

removeLightArmorOnMatchEnd() {
  self endon("disconnect");
  self endon("remove_light_armor");

  level waittill_any("round_end_finished", "game_ended");

  self thread unsetLightArmor();
}

hasLightArmor() {
  return (isDefined(self.lightArmorHP) && self.lightArmorHP > 0);
}