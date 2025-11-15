/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\perks\_perkfunctions.gsc
********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perks;

setOverkillPro() {}

unsetOverkillPro() {}

setEMPImmune() {}

unsetEMPImmune() {}

setAutoSpot() {
  if(!IsPlayer(self)) {
    return;
  }
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
  if(!IsPlayer(self)) {
    return;
  }
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

timeOutRegenFaster() {
  self.hasRegenFaster = undefined;
  self _unsetPerk("specialty_regenfaster");
  self SetClientDvar("ui_regen_faster_end_milliseconds", 0);
  self notify("timeOutRegenFaster");
}

setHardShell() {
  self.shellShockReduction = .25;
}

unsetHardShell() {
  self.shellShockReduction = 0;
}

setSharpFocus() {
  self thread monitorSharpFocus();
}

monitorSharpFocus() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_monitorSharpFocus");

  if(!isDefined(level.snipers)) {
    level.snipers = [];
    level.snipers["iw6_gm6_mp"] = true;
    level.snipers["iw6_l115a3_mp"] = true;
    level.snipers["iw6_usr_mp"] = true;
    level.snipers["iw6_vks_mp"] = true;
    level.snipers["iw6_dlcweap03_mp"] = true;
  }

  newWeapon = self GetCurrentWeapon();

  for(;;) {
    baseName = undefined;
    if(isDefined(newWeapon) && newWeapon != "none") {
      baseName = GetWeaponBaseName(newWeapon);
    }

    if(isDefined(baseName) && isDefined(level.snipers[baseName])) {
      self SetViewKickScale(0.5);
    } else {
      self SetViewKickScale(0.25);
    }

    self waittill("weapon_change", newWeapon);
  }
}

unsetSharpFocus() {
  self notify("stop_monitorSharpFocus");
  self setViewKickScale(1.0);
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

          if(ammoReserves - difference > 0)
            self setWeaponAmmoStock(weapon, (ammoReserves - difference));
          else
            self setWeaponAmmoStock(weapon, 0);
        }
      }
    }
  }

}

unsetDoubleLoad() {
  self notify("endDoubleLoad");
}

setMarksman(power) {
  if(!isDefined(power))
    power = 10;
  else
    power = Int(power) * 2;

  self setRecoilScale(power);
  self.recoilScale = power;
}

unsetMarksman() {
  self setRecoilScale(0);
  self.recoilScale = 0;
}

setRShieldRadar() {
  self endon("unsetRShieldRadar");

  wait(0.75);

  self MakePortableRadar();
  self thread setRShieldRadar_cleanUp();
}

setRShieldRadar_cleanUp() {
  self endon("unsetRShieldRadar");

  self waittill_any("disconnect", "death");

  if(isDefined(self)) {
    self unsetRShieldRadar();
  }
}

unsetRShieldRadar() {
  self ClearPortableRadar();
  self notify("unsetRShieldRadar");
}

setRShieldScrambler() {
  self MakeScrambler();
  self thread setRShieldScrambler_cleanUp();
}

setRShieldScrambler_cleanUp() {
  self endon("unsetRShieldScrambler");

  self waittill_any("disconnect", "death");

  if(isDefined(self)) {
    self unsetRShieldScrambler();
  }
}

unsetRShieldScrambler() {
  self ClearScrambler();
  self notify("unsetRShieldScrambler");
}

setStunResistance(power) {
  if(!isDefined(power))
    power = 10;

  power = Int(power);

  if(power == 10)
    self.stunScaler = 0;
  else
    self.stunScaler = power / 10;
}

unsetStunResistance() {
  self.stunScaler = 1;
}

applyStunResistence(time) {
  if(isDefined(self.stunScaler)) {
    return self.stunScaler * time;
  } else {
    return time;
  }
}

setWeaponLaser() {
  if(IsAgent(self)) {
    return;
  }
  self endon("unsetWeaponLaser");

  wait(0.5);

  self thread setWeaponLaser_internal();
}

unsetWeaponLaser() {
  self notify("unsetWeaponLaser");

  if(isDefined(self.perkWeaponLaserOn) && self.perkWeaponLaserOn) {
    self disableWeaponLaser();
  }

  self.perkWeaponLaserOn = undefined;
  self.perkWeaponLaserOffForSwitchStart = undefined;
}

setWeaponLaser_waitForLaserWeapon(weapon) {
  while(1) {
    weapon = GetWeaponBaseName(weapon);
    if(isDefined(weapon) && (weapon == "iw6_kac_mp" || weapon == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", weapon);
  }
}

setWeaponLaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");

  self.perkWeaponLaserOn = false;
  weapon = self GetCurrentWeapon();

  while(1) {
    self setWeaponLaser_waitForLaserWeapon(weapon);

    if(self.perkWeaponLaserOn == false) {
      self.perkWeaponLaserOn = true;
      self enableWeaponLaser();
    }

    self childthread setWeaponLaser_monitorADS();

    self childthread setWeaponLaser_monitorWeaponSwitchStart(1.0);

    self.perkWeaponLaserOffForSwitchStart = undefined;
    self waittill("weapon_change", weapon);

    if(self.perkWeaponLaserOn == true) {
      self.perkWeaponLaserOn = false;
      self disableWeaponLaser();
    }
  }
}

setWeaponLaser_monitorWeaponSwitchStart(offTime) {
  self endon("weapon_change");

  while(1) {
    self waittill("weapon_switch_started");
    childthread setWeaponLaser_onWeaponSwitchStart(offTime);
  }
}

setWeaponLaser_onWeaponSwitchStart(offTime) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkWeaponLaserOn == true) {
    self.perkWeaponLaserOffForSwitchStart = true;
    self.perkWeaponLaserOn = false;
    self disableWeaponLaser();
  }

  wait(offTime);

  self.perkWeaponLaserOffForSwitchStart = undefined;

  if(self.perkWeaponLaserOn == false && self PlayerAds() <= 0.6) {
    self.perkWeaponLaserOn = true;
    self enableWeaponLaser();
  }
}

setWeaponLaser_monitorADS() {
  self endon("weapon_change");

  while(1) {
    if(!isDefined(self.perkWeaponLaserOffForSwitchStart) || self.perkWeaponLaserOffForSwitchStart == false) {
      if(self PlayerAds() > 0.6) {
        if(self.perkWeaponLaserOn == true) {
          self.perkWeaponLaserOn = false;
          self disableWeaponLaser();
        }
      } else {
        if(self.perkWeaponLaserOn == false) {
          self.perkWeaponLaserOn = true;
          self enableWeaponLaser();
        }
      }
    }
    waitframe();
  }
}

setSteadyAimPro() {
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
  maps\mp\gametypes\_gamelogic::setHasDoneCombat(self, true);
}

unsetEndGame() {
  self notify("stopEndGame");
  self.endGame = undefined;
  self restoreBaseVisionSet(1);

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

setChallenger() {
  if(!level.hardcoreMode) {
    self.maxhealth = maps\mp\gametypes\_tweakables::getTweakableValue("player", "maxhealth");

    if(isDefined(self.xpScaler) && self.xpScaler == 1 && self.maxhealth > 30) {
      self.xpScaler = 2;
    }
  }
}

unsetChallenger() {
  self.xpScaler = 1;
}

setSaboteur() {
  self.objectiveScaler = 1.2;
}

unsetSaboteur() {
  self.objectiveScaler = 1;
}

setCombatSpeed() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetCombatSpeed");

  self.inCombatSpeed = false;
  self unsetCombatSpeedScalar();

  for(;;) {
    self waittill("damage", dmg, attacker);

    if(!isDefined(attacker.team)) {
      continue;
    }
    if(level.teamBased && attacker.team == self.team) {
      continue;
    }
    if(self.inCombatSpeed) {
      continue;
    }
    self setCombatSpeedScalar();
    self.inCombatSpeed = true;
    self thread endOfSpeedWatcher();
  }
}

endOfSpeedWatcher() {
  self notify("endOfSpeedWatcher");
  self endon("endOfSpeedWatcher");
  self endon("death");
  self endon("disconnect");

  self waittill("healed");

  self unsetCombatSpeedScalar();
  self.inCombatSpeed = false;
}

setCombatSpeedScalar() {
  if(isDefined(self.isJuggernaut) && self.isJuggernaut) {
    return;
  }
  if(self.weaponSpeed <= .8)
    self.combatSpeedScalar = 1.4;
  else if(self.weaponSpeed <= .9)
    self.combatSpeedScalar = 1.3;
  else
    self.combatSpeedScalar = 1.2;

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

unsetCombatSpeedScalar() {
  self.combatSpeedScalar = 1;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

unsetCombatSpeed() {
  unsetCombatSpeedScalar();
  self notify("unsetCombatSpeed");
}

setLightWeight() {
  if(!isDefined(self.cranked)) {
    self.moveSpeedScaler = lightWeightScalar();
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  }
}

unsetLightWeight() {
  self.moveSpeedScaler = 1;
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
  if(!self isEMPed())
    self MakeScrambler();
}

unsetLocalJammer() {
  self ClearScrambler();
}

setAC130() {
  self thread killstreakThink("ac130", 7, "end_ac130Think");
}

unsetAC130() {
  self notify("end_ac130Think");
}

setSentryMinigun() {
  self thread killstreakThink("airdrop_sentry_minigun", 2, "end_sentry_minigunThink");
}

unsetSentryMinigun() {
  self notify("end_sentry_minigunThink");
}

setTank() {
  self thread killstreakThink("tank", 6, "end_tankThink");
}

unsetTank() {
  self notify("end_tankThink");
}

setPrecision_airstrike() {
  println("!precision airstrike!");
  self thread killstreakThink("precision_airstrike", 6, "end_precision_airstrike");
}

unsetPrecision_airstrike() {
  self notify("end_precision_airstrike");
}

setPredatorMissile() {
  self thread killstreakThink("predator_missile", 4, "end_predator_missileThink");
}

unsetPredatorMissile() {
  self notify("end_predator_missileThink");
}

setHelicopterMinigun() {
  self thread killstreakThink("helicopter_minigun", 5, "end_helicopter_minigunThink");
}

unsetHelicopterMinigun() {
  self notify("end_helicopter_minigunThink");
}

killstreakThink(streakName, streakVal, endonString) {
  self endon("death");
  self endon("disconnect");
  self endon(endonString);

  for(;;) {
    self waittill("killed_enemy");

    if(self.pers["cur_kill_streak"] != streakVal) {
      continue;
    }
    self thread maps\mp\killstreaks\_killstreaks::giveKillstreak(streakName);
    self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakName, streakVal);
    return;
  }
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
  if(menu == game["menu_onemanarmy"])
    return true;

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && menu == game["menu_onemanarmy_defaults_splitscreen"])
    return true;

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && menu == game["menu_onemanarmy_custom_splitscreen"])
    return true;

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
}

giveOneManArmyClass(className) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(self _hasPerk("specialty_omaquickchange")) {
    changeDuration = 3.0;
    playPlayerAndNpcSounds(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    changeDuration = 6.0;
    playPlayerAndNpcSounds(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
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

  self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], className);

  if(isDefined(self.carryFlag))
    self attach(self.carryFlag, "J_spine4", true);

  self notify("changed_kit");
  level notify("changed_kit");
}

omaUseBar(duration) {
  self endon("disconnect");

  useBar = createPrimaryProgressBar();
  useBarText = createPrimaryProgressBarText();
  useBarText setText(&"MPUI_CHANGING_KIT");

  useBar updateBar(0, 1 / duration);
  for(waitedTime = 0; waitedTime < duration && isAlive(self) && !level.gameEnded; waitedTime += 0.05)
    wait(0.05);

  useBar destroyElem();
  useBarText destroyElem();
}

setBlastShield() {
  self SetWeaponHudIconOverride("primaryoffhand", "specialty_blastshield");
}

unsetBlastShield() {
  self SetWeaponHudIconOverride("primaryoffhand", "none");
}

setFreefall() {}

unsetFreefall() {}

setTacticalInsertion() {
  self SetOffhandSecondaryClass("flash");
  self _giveWeapon("flare_mp", 0);
  self giveStartAmmo("flare_mp");

  self thread monitorTIUse();
}

unsetTacticalInsertion() {
  self notify("end_monitorTIUse");
}

clearPreviousTISpawnpoint() {
  self waittill_any("disconnect", "joined_team", "joined_spectators");

  if(isDefined(self.setSpawnpoint))
    self deleteTI(self.setSpawnpoint);
}

updateTISpawnPosition() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");

  while(isReallyAlive(self)) {
    if(self isValidTISpawnPosition())
      self.TISpawnPosition = self.origin;

    wait(0.05);
  }
}

isValidTISpawnPosition() {
  if(Canspawn(self.origin) && self IsOnGround())
    return true;
  else
    return false;
}

TI_overrideMovingPlatformDeath(data) {
  if(IsReallyAlive(data.owner))
    data.owner deleteTI(self);
}

monitorTIUse() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_monitorTIUse");

  self thread updateTISpawnPosition();
  self thread clearPreviousTISpawnpoint();

  for(;;) {
    self waittill("grenade_fire", lightstick, weapName);

    if(weapName != "flare_mp") {
      continue;
    }
    if(isDefined(self.setSpawnPoint))
      self deleteTI(self.setSpawnPoint);

    if(!isDefined(self.TISpawnPosition)) {
      continue;
    }
    if(self touchingBadTrigger()) {
      continue;
    }
    startPos = self.TISpawnPosition + (0, 0, 16);
    endPos = self.TISpawnPosition - (0, 0, 2048);
    TIGroundPosition = PlayerPhysicsTrace(startPos, endPos) + (0, 0, 1);
    traceResult = bulletTrace(startPos, endPos, false);

    glowStick = spawn("script_model", TIGroundPosition);
    glowStick.angles = self.angles;
    glowStick.team = self.team;
    glowStick.owner = self;
    glowStick.enemyTrigger = spawn("script_origin", TIGroundPosition);
    glowStick thread GlowStickSetupAndWaitForDeath(self);
    glowStick.playerSpawnPos = self.TISpawnPosition;
    glowStick SetOtherEnt(self);
    glowStick make_entity_sentient_mp(self.team, true);

    glowStick thread maps\mp\gametypes\_weapons::createBombSquadModel("weapon_light_stick_tactical_bombsquad", "tag_fire_fx", self);

    glowStick maps\mp\gametypes\_weapons::explosiveHandleMovers(traceResult["entity"]);
    maps\mp\gametypes\_weapons::onTacticalEquipmentPlanted(glowStick);

    self.setSpawnPoint = glowStick;
    return;
  }
}

CONST_TI_FX_TAG = "tag_fire_fx";
GlowStickSetupAndWaitForDeath(owner) {
  self setModel(level.spawnGlowModel["enemy"]);
  if(level.teamBased)
    self maps\mp\_entityheadIcons::setTeamHeadIcon(self.team, (0, 0, 20));
  else
    self maps\mp\_entityheadicons::setPlayerHeadIcon(owner, (0, 0, 20));

  self thread GlowStickDamageListener(owner);
  self thread GlowStickEnemyUseListener(owner);
  self thread GlowStickUseListener(owner);
  self thread glowStickWaitForOwnerDisconnect(owner);

  dummyGlowStick = spawn("script_model", self.origin + (0, 0, 0));
  dummyGlowStick.angles = self.angles;
  dummyGlowStick setModel(level.spawnGlowModel["friendly"]);
  dummyGlowStick setContents(0);
  dummyGlowStick LinkTo(self);

  dummyGlowStick playLoopSound("emt_road_flare_burn");

  thread GlowStickTeamUpdater(self, dummyGlowStick, owner);

  self waittill("death");

  dummyGlowStick stopLoopSound();
  dummyGlowStick delete();
}

GlowStickTeamUpdater(enemyStick, friendlyStick, owner) {
  enemyStick endon("death");

  wait(0.05);

  glowstickEnts = [];
  glowstickEnts["enemy"] = enemyStick;
  glowstickEnts["friendly"] = friendlyStick;

  for(;;) {
    foreach(glowstick in glowstickEnts) {
      glowstick Hide();
    }

    foreach(player in level.players) {
      key = "friendly";
      if(owner isEnemy(player)) {
        key = "enemy";
      }

      glowstick = glowstickEnts[key];
      glowstick Show();
      PlayFXOnTagForClients(level.spawnGlow[key], glowstick, CONST_TI_FX_TAG, player);
      waitframe();
    }

    level waittill("joined_team");

    foreach(key, glowstick in glowstickEnts) {
      stopFXOnTag(level.spawnGlow[key], glowstick, CONST_TI_FX_TAG);
    }

    waitframe();
  }
}

deleteOnDeath(ent) {
  self waittill("death");
  if(isDefined(ent))
    ent delete();
}

GlowStickDamageListener(owner) {
  self maps\mp\gametypes\_damage::monitorDamage(
    100,
    "tactical_insertion", ::GlowStickModifyDamage, ::GlowStickHandleDeathDamage,
    true
  );
}

GlowStickModifyDamage(attacker, weapon, type, damage) {
  return self maps\mp\gametypes\_damage::handleMeleeDamage(weapon, type);
}

GlowStickHandleDeathDamage(attacker, weapon, type, damage) {
  if(isDefined(self.owner) && attacker != self.owner) {
    attacker notify("destroyed_insertion", self.owner);
    attacker notify("destroyed_equipment");
    self.owner thread leaderDialogOnPlayer("ti_destroyed", undefined, undefined, self.origin);
  }

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

    player playSound("tactical_insert_flare_pu");

    if(!player isJuggernaut())
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

glowStickWaitForOwnerDisconnect(owner) {
  self endon("death");
  owner waittill("disconnect");

  thread deleteTI(self);
}

deleteTI(TI) {
  if(isDefined(TI.enemyTrigger))
    TI.enemyTrigger Delete();

  spot = TI.origin;
  spotAngles = TI.angles;
  parent = TI GetLinkedParent();

  TI Delete();

  dummyGlowStick = spawn("script_model", spot);
  dummyGlowStick.angles = spotAngles;
  dummyGlowStick setModel(level.spawnGlowModel["friendly"]);

  dummyGlowStick setContents(0);
  if(isDefined(parent))
    dummyGlowStick LinkTo(parent);

  thread dummyGlowStickDelete(dummyGlowStick);
}

dummyGlowStickDelete(stick) {
  wait(2.5);
  stick Delete();
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

    player notify("destroyed_insertion", owner);
    player notify("destroyed_equipment");

    if(isDefined(owner) && player != owner)
      owner thread leaderDialogOnPlayer("ti_destroyed", undefined, undefined, self.origin);

    player thread deleteTI(self);
  }
}

setLittlebirdSupport() {
  self thread killstreakThink("littlebird_support", 2, "end_littlebird_support_think");
}

unsetLittlebirdSupport() {
  self notify("end_littlebird_support_think");
}

setPainted(attacker) {
  if(IsPlayer(self)) {
    outlineTime = 1;

    if(!self _hasPerk("specialty_incog")) {
      self.painted = true;

      if(level.teamBased) {
        id = outlineEnableForTeam(self, "orange", attacker.team, false, "perk");
        self thread watchPainted(id, outlineTime);
        self thread watchPaintedAgain(id);
      } else {
        id = outlineEnableForPlayer(self, "orange", attacker, false, "perk");
        self thread watchPainted(id, outlineTime);
        self thread watchPaintedAgain(id);
      }
    }
  }
}

watchPainted(id, timeout) {
  self notify("painted_again");

  self endon("painted_again");

  self endon("disconnect");
  level endon("game_ended");

  self waittill_any_timeout(timeout, "death");

  self.painted = false;
  outlineDisable(id, self);

  self notify("painted_end");
}

watchPaintedAgain(id) {
  self endon("disconnect");
  level endon("game_ended");

  self waittill_any("painted_again", "painted_end");

  outlineDisable(id, self);
}

isPainted() {
  return (isDefined(self.painted) && self.painted);
}

setAssists() {}

unsetAssists() {}

setRefillGrenades() {
  if(isDefined(self.primaryGrenade)) {
    self GiveMaxAmmo(self.primaryGrenade);
  }
  if(isDefined(self.secondaryGrenade)) {
    self GiveMaxAmmo(self.secondaryGrenade);
  }
}

unsetRefillGrenades() {}

setRefillAmmo() {
  if(isDefined(self.primaryWeapon)) {
    self GiveMaxAmmo(self.primaryWeapon);
  }
  if(isDefined(self.secondaryWeapon)) {
    self GiveMaxAmmo(self.secondaryWeapon);
  }
}

unsetRefillAmmo() {}

setGunsmith() {
  self thread setGunsmithInternal();
}

setGunsmithInternal() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self endon("unsetGunsmith");

  self waittill("giveLoadout");

  if(self.loadoutPrimaryAttachments.size == 0 && self.loadoutSecondaryAttachments.size == 0) {
    return;
  }
  while(1) {
    self waittill("weapon_change", weaponNew);

    if(weaponNew == "none") {
      continue;
    }
    if(isKillstreakWeapon(weaponNew)) {
      continue;
    }
    if(!isStrStart(weaponNew, "iw5_") && !isStrStart(weaponNew, "iw6_")) {
      continue;
    }
    attachmentsLoadout = undefined;

    if(getWeaponClass(weaponNew) == "weapon_pistol") {
      if(self.loadoutSecondaryAttachments.size > 0) {
        attachmentsLoadout = self.loadoutSecondaryAttachments;
      }
    } else {
      if(self.loadoutPrimaryAttachments.size > 0) {
        attachmentsLoadout = self.loadoutPrimaryAttachments;
      }
    }

    if(!isDefined(attachmentsLoadout)) {
      continue;
    }
    shouldAdd = false;
    attachmentsCurrent = getWeaponAttachmentsBaseNames(weaponNew);

    if(attachmentsCurrent.size == 0) {
      shouldAdd = true;
    } else {
      foreach(attachment in attachmentsLoadout) {
        if(!array_contains(attachmentsCurrent, attachment)) {
          shouldAdd = true;
          break;
        }
      }
    }

    if(!shouldAdd) {
      continue;
    }
    attachmentsLoadoutCleaned = [];
    attachmentsValid = getWeaponAttachmentArrayFromStats(weaponNew);
    foreach(attachment in attachmentsLoadout) {
      if(array_contains(attachmentsValid, attachment)) {
        attachmentsLoadoutCleaned[attachmentsLoadoutCleaned.size] = attachment;
      }
    }

    attachmentsLoadout = attachmentsLoadoutCleaned;

    attachmentsCompatible = [];

    foreach(attachCurr in attachmentsCurrent) {
      compatible = true;
      foreach(attachLoadout in attachmentsLoadout) {
        if(!attachmentsCompatible(attachLoadout, attachCurr)) {
          compatible = false;
          break;
        }
      }

      if(compatible) {
        attachmentsCompatible[attachmentsCompatible.size] = attachCurr;
      }
    }

    attachmentsCurrent = attachmentsCompatible;

    totalPossible = attachmentsLoadout.size + attachmentsCurrent.size;

    if(totalPossible > 4) {
      attachmentsCurrent = array_randomize(attachmentsCurrent);
    }

    idx = 0;
    while(attachmentsLoadout.size < 4 && idx < attachmentsCurrent.size) {
      attachmentsLoadout[attachmentsLoadout.size] = attachmentsCurrent[idx];

      idx++;
    }

    weaponNewBase = GetWeaponBaseName(weaponNew);
    weaponUpdated = weaponNewBase;

    foreach(idx, attachment in attachmentsLoadout) {
      attachUnique = attachmentMap_toUnique(attachment, weaponNew);

      attachmentsLoadout[idx] = attachUnique;
    }

    attachmentsLoadout = alphabetize(attachmentsLoadout);

    foreach(attachment in attachmentsLoadout) {
      weaponUpdated += "_" + attachment;
    }

    if(weaponUpdated != weaponNewBase) {
      ammoClip = self GetWeaponAmmoClip(weaponNew);
      ammoStock = self GetWeaponAmmoStock(weaponNew);

      self TakeWeapon(weaponNew);

      self GiveWeapon(weaponUpdated);
      self SetWeaponAmmoClip(weaponUpdated, ammoClip);
      self SetWeaponAmmoStock(weaponUpdated, ammoStock);
      self SwitchToWeapon(weaponUpdated);
    }
  }
}

unsetGunsmith() {
  self notify("unsetGunsmith");
}

setGambler() {
  self SetClientOmnvar("ui_gambler_show", -1);
  self setGamblerInternal();
}

setGamblerInternal() {
  level.abilityMaxVal = [];

  abilityCategories = maps\mp\gametypes\_class::getNumAbilityCategories();
  abilityPerCategory = maps\mp\gametypes\_class::getNumSubAbility();

  validAbilities = [];
  abilityWeight = 0;
  loadoutPerks = undefined;

  if(isAI(self))
    loadoutPerks = self.pers["loadoutPerks"];

  if(!isDefined(level.perkNamesForGambler)) {
    level.perkNamesForGambler = [];
    level.perkCostsForGambler = [];
    level.perkRowsForGambler = [];

    for(abilityCategoryIndex = 0; abilityCategoryIndex < abilityCategories; abilityCategoryIndex++) {
      for(abilityIndex = 0; abilityIndex < abilityPerCategory; abilityIndex++) {
        perkName = TableLookup("mp/cacAbilityTable.csv", 0, abilityCategoryIndex + 1, 4 + abilityIndex);

        level.perkNamesForGambler[abilityCategoryIndex][abilityIndex] = perkName;

        for(row = 0; TableLookupByRow("mp/perktable.csv", row, 0) != ""; row++) {
          if(perkName == TableLookupByRow("mp/perktable.csv", row, 1)) {
            level.perkCostsForGambler[abilityCategoryIndex][abilityIndex] = int(TableLookupByRow("mp/perktable.csv", row, 10));
            level.perkRowsForGambler[abilityCategoryIndex][abilityIndex] = row;
            break;
          }
        }
      }
    }
  }

  isGamblerCommonLoadout = self gamblerCommonChecker();
  isGamblerDefaultLoadout = false;

  if(level.gameType == "infect")
    isGamblerCommonLoadout = false;

  if(isDefined(self.teamName)) {
    isGamblerDefaultLoadout = getMatchRulesData("defaultClasses", self.teamName, self.class_num, "class", "abilitiesPicked", 6, 0);
  }

  for(abilityCategoryIndex = 0; abilityCategoryIndex < abilityCategories; abilityCategoryIndex++) {
    for(abilityIndex = 0; abilityIndex < abilityPerCategory; abilityIndex++) {
      abilityRef = level.perkNamesForGambler[abilityCategoryIndex][abilityIndex];

      alreadyPicked = perkPickedChecker(abilityRef, abilityCategoryIndex, abilityIndex);

      if(alreadyPicked && (self.streakType == "specialist" || !self.perkPickedSpecialist)) {
        continue;
      }
      if(!isDefined(abilityRef)) {
        continue;
      }
      if(abilityRef == "") {
        continue;
      }
      if(abilityRef == "specialty_extra_attachment" || abilityRef == "specialty_twoprimaries") {
        continue;
      }
      if(isDefined(isGamblerCommonLoadout) && !isGamblerCommonLoadout && !isGamblerDefaultLoadout) {
        if(abilityRef == "specialty_extraammo" || abilityRef == "specialty_extra_equipment" || abilityRef == "specialty_extra_deadly")
          continue;
      }

      if(self.streakType == "support") {
        if(abilityRef == "specialty_hardline")
          continue;
      }

      if(isAI(self) && isDefined(loadoutPerks) && array_contains(loadoutPerks, abilityRef)) {
        continue;
      }
      abilityCost = level.perkCostsForGambler[abilityCategoryIndex][abilityIndex];
      row = level.perkRowsForGambler[abilityCategoryIndex][abilityIndex];

      switch (abilityCost) {
        case 1:
          abilityWeight = 150;
          break;

        case 2:
          abilityWeight = 40;
          break;

        case 3:
          abilityWeight = 60;
          break;

        case 4:
          abilityWeight = 20;
          break;

        case 5:
          abilityWeight = 20;
          break;

        default:
          AssertMsg("setGambler() did not handle perk: " + abilityRef + " of cost: " + abilityCost);
          break;
      }

      validAbilities[validAbilities.size] = spawnStruct();
      validAbilities[validAbilities.size - 1].row = row;
      validAbilities[validAbilities.size - 1].id = abilityRef;
      validAbilities[validAbilities.size - 1].weight = abilityWeight;
    }
  }

  self.perkPickedSpecialist = undefined;

  if(validAbilities.size > 0) {
    self thread giveGamblerChoice(validAbilities);
  }
}

gamblerCommonChecker() {
  if(!isAI(self)) {
    return self GetCaCPlayerData("loadouts", self.class_num, "abilitiesPicked", 6, 0);
  } else {
    itemsToCheck = [];

    if(isDefined(self.pers["loadoutPerks"]))
      itemsToCheck = array_combine(itemsToCheck, self.pers["loadoutPerks"]);

    foreach(item in itemsToCheck) {
      if(getBasePerkName(item) == "specialty_gambler")
        return true;
    }
  }

  return false;
}

perkPickedChecker(perkName, abilityCategoryIndex, abilityIndex) {
  self.perkPickedSpecialist = false;

  if(!isDefined(perkName))
    return false;

  if(perkName == "")
    return false;

  if(!isAI(self)) {
    abilityCategories = maps\mp\gametypes\_class::getNumAbilityCategories();
    abilityPerCategory = maps\mp\gametypes\_class::getNumSubAbility();

    if(self GetCaCPlayerData("loadouts", self.class_num, "abilitiesPicked", abilityCategoryIndex, abilityIndex))
      return true;

    for(index = 0; index < 3; index++) {
      killstreak = self getCaCPlayerData("loadouts", self.class_num, "specialistStreaks", index);

      if(isDefined(killstreak) && killstreak != "none") {
        basePerkName = getBasePerkName(killstreak);

        if(basePerkName == perkName) {
          self.perkPickedSpecialist = true;
          return true;
        }
      }
    }

    picked = self GetCaCPlayerData("loadouts", self.class_num, "specialistBonusStreaks", abilityCategoryIndex, abilityIndex);

    if(isDefined(picked) && picked) {
      bonusPerkName = level.perkNamesForGambler[abilityCategoryIndex][abilityIndex];

      if(bonusPerkName == perkName) {
        self.perkPickedSpecialist = true;
        return true;
      }
    }
  } else {
    itemsToCheck = [];

    if(isDefined(self.pers["loadoutPerks"]))
      itemsToCheck = array_combine(itemsToCheck, self.pers["loadoutPerks"]);

    foreach(item in itemsToCheck) {
      if(getBasePerkName(item) == perkName)
        return true;
    }

    itemsToCheck = [];
    if(isDefined(self.pers["specialistStreaks"]))
      itemsToCheck = array_combine(itemsToCheck, self.pers["specialistStreaks"]);

    if(isDefined(self.pers["specialistBonusStreaks"]))
      itemsToCheck = array_combine(itemsToCheck, self.pers["specialistBonusStreaks"]);

    foreach(item in itemsToCheck) {
      if(getBasePerkName(item) == perkName) {
        self.perkPickedSpecialist = true;
        return true;
      }
    }
  }

  return false;
}

giveGamblerChoice(abilityArray) {
  self endon("death");
  self endon("disconnect");
  self endon("unsetGambler");
  level endon("game_ended");

  if(!gameFlag("prematch_done"))
    gameFlagWait("prematch_done");
  else if(gameFlag("prematch_done") && self.streakType != "specialist")
    self waittill("giveLoadout");

  if(!isDefined(self.abilityChosen))
    self.abilityChosen = false;

  if(!self.abilityChosen) {
    randomAbility = getRandomAbility(abilityArray);
    self.gamblerAbility = randomAbility;
  } else
    randomAbility = self.gamblerAbility;

  self givePerk(randomAbility.id, false);

  if(randomAbility.id == "specialty_hardline")
    self maps\mp\killstreaks\_killstreaks::setStreakCountToNext();

  if(showGambler()) {
    self PlayLocalSound("mp_suitcase_pickup");
    self SetClientOmnvar("ui_gambler_show", randomAbility.row);
    self thread gamblerAnimWatcher();
  }

  if(level.gameType != "infect")
    self.abilityChosen = true;
}

showGambler() {
  showGambler = true;

  if(!level.inGracePeriod && self.abilityChosen)
    showGambler = false;

  if(!allowClassChoice() && level.gameType != "infect")
    showGambler = false;

  return showGambler;
}

gamblerAnimWatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetGambler");
  level endon("game_ended");

  self waittill("luinotifyserver", channel, value);

  if(channel == "gambler_anim_complete")
    self SetClientOmnvar("ui_gambler_show", -1);
}

getRandomAbility(abilityArray) {
  weightArray = [];

  weightArray = self thread sortByWeight(abilityArray);

  weightArray = self thread setBucketVal(weightArray);

  randValue = RandomInt(level.abilityMaxVal["sum"]);
  newAbility = undefined;

  foreach(ability in weightArray) {
    if(!ability.weight || ability.id == "specialty_gambler")
      continue;
    if(ability.weight > randValue) {
      newAbility = ability;
      break;
    }
  }

  return newAbility;
}

sortByWeight(abilityArray) {
  nextAbility = [];
  prevAbility = [];

  for(nextIndex = 1; nextIndex < abilityArray.size; nextIndex++) {
    nextWeight = abilityArray[nextIndex].weight;
    nextAbility = abilityArray[nextIndex];

    for(prevIndex = nextIndex - 1;
      (prevIndex >= 0) && is_weight_a_less_than_b(abilityArray[prevIndex].weight, nextWeight); prevIndex--) {
      prevAbility = abilityArray[prevIndex];

      abilityArray[prevIndex] = nextAbility;
      abilityArray[prevIndex + 1] = prevAbility;
    }
  }

  return abilityArray;
}

is_weight_a_less_than_b(a, b) {
  return (a < b);
}

setBucketVal(abilityArray) {
  level.abilityMaxVal["sum"] = 0;

  foreach(ability in abilityArray) {
    if(!ability.weight) {
      continue;
    }
    level.abilityMaxVal["sum"] += ability.weight;
    ability.weight = level.abilityMaxVal["sum"];
  }

  return abilityArray;
}

unsetGambler() {
  self notify("unsetGambler");
}

setComExp() {
  assert(isDefined(level.comExpFuncs));
  assert(isDefined(level.comExpFuncs["giveComExpBenefits"]));
  give_com_exp_func = level.comExpFuncs["giveComExpBenefits"];
  self[[give_com_exp_func]]();
}

unsetComExp() {
  assert(isDefined(level.comExpFuncs));
  assert(isDefined(level.comExpFuncs["removeComExpBenefits"]));
  unset_com_exp_func = level.comExpFuncs["removeComExpBenefits"];
  self[[unset_com_exp_func]]();
}

setTagger() {
  self thread setTaggerInternal();
}

setTaggerInternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetTagger");
  level endon("game_ended");

  while(true) {
    self waittill("eyesOn");

    sightingPlayers = self GetPlayersSightingMe();

    foreach(otherPlayer in sightingPlayers) {
      if(level.teamBased && (otherPlayer.team == self.team)) {
        continue;
      }
      if(isAlive(otherPlayer) && otherplayer.sessionstate == "playing") {
        if(!isDefined(otherplayer.perkOutlined))
          otherplayer.perkOutlined = false;

        if(!otherplayer.perkOutlined) {
          otherplayer.perkOutlined = true;
        }

        otherplayer thread outlineWatcher(self);
      }
    }
  }
}

outlineWatcher(victim) {
  self endon("death");
  self endon("disconnect");
  self endon("eyesOff");
  level endon("game_ended");

  for(;;) {
    notWatching = true;
    sightingPlayers = victim GetPlayersSightingMe();

    foreach(otherPlayer in sightingPlayers) {
      if(otherPlayer == self) {
        notWatching = false;
        break;
      }
    }

    if(notWatching) {
      self.perkOutlined = false;
      self notify("eyesOff");
    }

    wait(0.5);
  }
}

unsetTagger() {
  self notify("unsetTagger");
}

setPitcher() {
  self thread setPitcherInternal();
}

setPitcherInternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");

  self _setPerk("specialty_throwback", false);
  self SetGrenadeCookScale(1.5);

  for(;;) {
    self SetGrenadeThrowScale(1.25);

    self waittill("grenade_pullback", grenadeName);

    if(grenadeName == "airdrop_marker_mp" || grenadeName == "killstreak_uplink_mp" || grenadeName == "deployable_vest_marker_mp" || grenadeName == "deployable_weapon_crate_marker_mp" || grenadeName == "airdrop_juggernaut_mp")
      self SetGrenadeThrowScale(1);

    self waittill("grenade_fire", grenade, weaponName);
  }
}

unsetPitcher() {
  self SetGrenadeCookScale(1);
  self SetGrenadeThrowScale(1);
  self _unsetPerk("specialty_throwback");
  self notify("unsetPitcher");
}

setBoom() {}

setBoomInternal(attacker) {
  self endon("death");
  self endon("disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  attacker endon("death");
  attacker endon("disconnect");

  waitframe();

  TriggerPortableRadarPing(self.origin, attacker);

  attacker boomTrackPlayers(self.origin);
}

BOOM_DIST_SQ = 700 * 700;
BOOM_DURATION = 2000;

boomTrackPlayers(targetPos) {
  foreach(player in level.players) {
    if(self isEnemy(player) &&
      IsAlive(player) &&
      !player _hasPerk("specialty_gpsjammer") &&
      (DistanceSquared(targetPos, player.origin) <= BOOM_DIST_SQ)) {
      player.markedByBoomPerk[self getUniqueId()] = GetTime() + BOOM_DURATION;
    }
  }
}

unsetBoom() {
  self notify("unsetBoom");
}

setSilentkill() {}

unsetSilentkill() {}

setBloodrush() {
  self.bloodrushRegenSpeedMod = 1;
  self.bloodrushRegenHealthMod = 1;
}

setBloodrushInternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetBloodrush");
  level endon("game_ended");

  if(!isDefined(self.isJuiced) || !self.isJuiced) {
    self.rushtime = 5;
    self thread customJuiced(self.rushtime);
    self.bloodrushRegenSpeedMod = 0.25;
    self.bloodrushRegenHealthMod = 5;
    self notify("bloodrush_active");
  }

  self waittill("unset_custom_juiced");
  self unsetBloodrush();
}

customJuiced(waittime) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level endon("game_ended");

  self.isJuiced = true;
  self.moveSpeedScaler = 1.1;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self givePerk("specialty_fastreload", false);

  self givePerk("specialty_quickdraw", false);

  self givePerk("specialty_stalker", false);

  self givePerk("specialty_fastoffhand", false);

  self givePerk("specialty_fastsprintrecovery", false);

  self givePerk("specialty_quickswap", false);

  self thread unsetCustomJuicedOnDeath();
  self thread unsetCustomJuicedOnRide();
  self thread unsetCustomJuicedOnMatchEnd();

  endTime = (waittime * 1000) + GetTime();

  if(!IsAI(self)) {
    self SetClientDvar("ui_juiced_end_milliseconds", endTime);
  }

  wait(waittime);

  self unsetCustomJuiced();
}

unsetCustomJuiced(death) {
  if(!isDefined(death)) {
    if(self isJuggernaut()) {
      Assert(isDefined(self.juggMoveSpeedScaler));
      if(isDefined(self.juggMoveSpeedScaler))
        self.moveSpeedScaler = self.juggMoveSpeedScaler;
      else
        self.moveSpeedScaler = 0.7;
    } else {
      self.moveSpeedScaler = 1;
      if(self _hasPerk("specialty_lightweight"))
        self.moveSpeedScaler = lightWeightScalar();
    }
    Assert(isDefined(self.moveSpeedScaler));
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  }

  self _unsetPerk("specialty_fastreload");

  self _unsetPerk("specialty_quickdraw");

  self _unsetPerk("specialty_stalker");

  self _unsetPerk("specialty_fastoffhand");

  self _unsetPerk("specialty_fastsprintrecovery");

  self _unsetPerk("specialty_quickswap");

  if(isDefined(self.pers["loadoutPerks"])) {
    self maps\mp\perks\_abilities::givePerksFromKnownLoadout(self.pers["loadoutPerks"]);
  }

  self.isJuiced = undefined;

  if(!IsAI(self)) {
    self SetClientDvar("ui_juiced_end_milliseconds", 0);
  }

  self notify("unset_custom_juiced");
}

unsetCustomJuicedOnRide() {
  self endon("disconnect");
  self endon("unset_custom_juiced");

  while(true) {
    wait(0.05);

    if(self isUsingRemote()) {
      self thread unsetCustomJuiced();
      break;
    }
  }
}

unsetCustomJuicedOnDeath() {
  self endon("disconnect");
  self endon("unset_custom_juiced");

  self waittill_any("death", "faux_spawn");

  self thread unsetCustomJuiced(true);
}

unsetCustomJuicedOnMatchEnd() {
  self endon("disconnect");
  self endon("unset_custom_juiced");

  level waittill_any("round_end_finished", "game_ended");

  self thread unsetCustomJuiced();
}

regenSpeedWatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetBloodrush");
  level endon("game_ended");

  for(;;) {
    self waittill("bloodrush_active");
    self.regenSpeed = self.bloodrushRegenSpeedMod;
    break;
  }
}

unsetBloodrush() {
  self.bloodrushRegenSpeedMod = 1;
  self.regenSpeed = 1;
  self notify("unsetBloodrush");
}

setTriggerHappy() {}

setTriggerHappyInternal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");

  playerWeapon = self.lastDroppableWeapon;

  playerOldStock = self GetWeaponAmmoStock(playerWeapon);

  playerOldClip = self GetWeaponAmmoClip(playerWeapon);

  self GiveStartAmmo(playerWeapon);
  playerDefaultClip = self GetWeaponAmmoClip(playerWeapon);

  clipDifference = playerDefaultClip - playerOldClip;
  playerNewStock = playerOldStock - clipDifference;

  if(clipDifference > playerOldStock) {
    self SetWeaponAmmoClip(playerWeapon, playerOldClip + playerOldStock);
    playerNewStock = 0;
  }

  self SetWeaponAmmoStock(playerWeapon, playerNewStock);

  self PlayLocalSound("ammo_crate_use");

  self SetClientOmnvar("ui_trigger_happy", true);

  wait(0.2);

  self SetClientOmnvar("ui_trigger_happy", false);
}

unsetTriggerHappy() {
  self SetClientOmnvar("ui_trigger_happy", false);
  self notify("unsetTriggerHappy");
}

setDeadeye() {
  self.critChance = 10;
  self.deadeyekillCount = 0;
}

setDeadeyeInternal() {
  if(self.critChance < 50)
    self.critChance = (self.deadeyekillCount + 1) * 10;
  else
    self.critChance = 50;

  chance = randomint(100);

  if(chance <= self.critChance)
    self givePerk("specialty_moredamage", false);
}

unsetDeadeye() {
  if(self _hasPerk("specialty_moredamage"))
    self _unsetPerk("specialty_moredamage");
}

setIncog() {}

unsetIncog() {}

setBlindeye() {}

unsetBlindeye() {
  self _unsetPerk("specialty_noplayertarget");
  self notify("removed_specialty_noplayertarget");
}

setQuickswap() {}

unsetQuickswap() {
  self _unsetPerk("specialty_fastoffhand");
}

setExtraAmmo() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_extraammo");
  level endon("game_ended");

  if(self.gettingLoadout)
    self waittill("giveLoadout");

  playerPrimaries = self getValidExtraAmmoWeapons();

  foreach(primary in playerPrimaries) {
    if(isDefined(primary) && primary != "none")
      self GiveMaxAmmo(primary);
  }
}

unsetExtraAmmo() {
  self notify("unset_extraammo");
}

setExtraEquipment() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_extraequipment");
  level endon("game_ended");

  if(self.gettingLoadout)
    self waittill("giveLoadout");

  playerTactical = self.loadoutPerkOffhand;

  if(isDefined(playerTactical) && playerTactical != "specialty_null") {
    if(playerTactical != "specialty_tacticalinsertion")
      self SetWeaponAmmoClip(playerTactical, 2);
  }
}

unsetExtraEquipment() {
  self notify("unset_extraequipment");
}

setExtraDeadly() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_extradeadly");
  level endon("game_ended");

  if(self.gettingLoadout)
    self waittill("giveLoadout");

  playerLethal = self.loadoutPerkEquipment;

  if(isDefined(playerLethal) && playerLethal != "specialty_null")
    self SetWeaponAmmoClip(playerLethal, 2);
}

unsetExtraDeadly() {
  self notify("unset_extradeadly");
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

setC4Death() {
  if(!self _hasperk("specialty_pistoldeath"))
    self givePerk("specialty_pistoldeath", false);
}

unsetC4Death() {
  if(self _hasperk("specialty_pistoldeath"))
    self _unsetperk("specialty_pistoldeath");
}

setJuiced(waitTime) {
  self endon("death");
  self endon("faux_spawn");
  self endon("disconnect");
  self endon("unset_juiced");
  level endon("game_ended");

  self.isJuiced = true;
  self.moveSpeedScaler = 1.25;
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self givePerk("specialty_fastreload", false);

  self givePerk("specialty_quickdraw", false);

  self givePerk("specialty_stalker", false);

  self givePerk("specialty_fastoffhand", false);

  self givePerk("specialty_fastsprintrecovery", false);

  self givePerk("specialty_quickswap", false);

  self thread unsetJuicedOnDeath();
  self thread unsetJuicedOnRide();
  self thread unsetJuicedOnMatchEnd();

  if(!isDefined(waitTime)) {
    waitTime = 10;
  }
  endTime = (waitTime * 1000) + GetTime();
  if(!IsAI(self)) {
    self SetClientDvar("ui_juiced_end_milliseconds", endTime);
  }
  wait(waitTime);
  self unsetJuiced();
}

unsetJuiced(death) {
  if(!isDefined(death)) {
    if(!is_aliens())
      Assert(IsAlive(self));

    if(self isJuggernaut()) {
      Assert(isDefined(self.juggMoveSpeedScaler));
      if(isDefined(self.juggMoveSpeedScaler))
        self.moveSpeedScaler = self.juggMoveSpeedScaler;
      else
        self.moveSpeedScaler = 0.7;
    } else {
      self.moveSpeedScaler = 1;
      if(self _hasPerk("specialty_lightweight"))
        self.moveSpeedScaler = lightWeightScalar();
    }
    Assert(isDefined(self.moveSpeedScaler));
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  }

  self _unsetPerk("specialty_fastreload");

  self _unsetPerk("specialty_quickdraw");

  self _unsetPerk("specialty_stalker");

  self _unsetPerk("specialty_fastoffhand");

  self _unsetPerk("specialty_fastsprintrecovery");

  self _unsetPerk("specialty_quickswap");

  if(isDefined(self.pers["loadoutPerks"])) {
    self maps\mp\perks\_abilities::givePerksFromKnownLoadout(self.pers["loadoutPerks"]);
  }

  self.isJuiced = undefined;
  if(!IsAI(self)) {
    self SetClientDvar("ui_juiced_end_milliseconds", 0);
  }

  self notify("unset_juiced");
}

unsetJuicedOnRide() {
  self endon("disconnect");
  self endon("unset_juiced");

  while(true) {
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

unsetJuicedOnMatchEnd() {
  self endon("disconnect");
  self endon("unset_juiced");

  level waittill_any("round_end_finished", "game_ended");

  self thread unsetJuiced();
}

hasJuiced() {
  return (isDefined(self.isJuiced));
}

setCombatHigh() {
  self endon("death");
  self endon("disconnect");
  self endon("unset_combathigh");
  level endon("end_game");

  self.damageBlockedTotal = 0;

  if(level.splitscreen) {
    yOffset = 56;
    iconSize = 21;
  } else {
    yOffset = 112;
    iconSize = 32;
  }

  if(isDefined(self.juicedTimer))
    self.juicedTimer Destroy();
  if(isDefined(self.juicedIcon))
    self.juicedIcon Destroy();

  self.combatHighOverlay = newClientHudElem(self);
  self.combatHighOverlay.x = 0;
  self.combatHighOverlay.y = 0;
  self.combatHighOverlay.alignX = "left";
  self.combatHighOverlay.alignY = "top";
  self.combatHighOverlay.horzAlign = "fullscreen";
  self.combatHighOverlay.vertAlign = "fullscreen";
  self.combatHighOverlay setshader("combathigh_overlay", 640, 480);
  self.combatHighOverlay.sort = -10;
  self.combatHighOverlay.archived = true;

  self.combatHighTimer = createTimer("hudsmall", 1.0);
  self.combatHighTimer setPoint("CENTER", "CENTER", 0, yOffset);
  self.combatHighTimer setTimer(10.0);
  self.combatHighTimer.color = (.8, .8, 0);
  self.combatHighTimer.archived = false;
  self.combatHighTimer.foreground = true;

  self.combatHighIcon = self createIcon("specialty_painkiller", iconSize, iconSize);
  self.combatHighIcon.alpha = 0;
  self.combatHighIcon setParent(self.combatHighTimer);
  self.combatHighIcon setPoint("BOTTOM", "TOP");
  self.combatHighIcon.archived = true;
  self.combatHighIcon.sort = 1;
  self.combatHighIcon.foreground = true;

  self.combatHighOverlay.alpha = 0.0;
  self.combatHighOverlay fadeOverTime(1.0);
  self.combatHighIcon fadeOverTime(1.0);
  self.combatHighOverlay.alpha = 1.0;
  self.combatHighIcon.alpha = 0.85;

  self thread unsetCombatHighOnDeath();
  self thread unsetCombatHighOnRide();

  wait(8);

  self.combatHighIcon fadeOverTime(2.0);
  self.combatHighIcon.alpha = 0.0;

  self.combatHighOverlay fadeOverTime(2.0);
  self.combatHighOverlay.alpha = 0.0;

  self.combatHighTimer fadeOverTime(2.0);
  self.combatHighTimer.alpha = 0.0;

  wait(2);
  self.damageBlockedTotal = undefined;

  self _unsetPerk("specialty_combathigh");
}

unsetCombatHighOnDeath() {
  self endon("disconnect");
  self endon("unset_combathigh");

  self waittill("death");

  self thread _unsetPerk("specialty_combathigh");
}

unsetCombatHighOnRide() {
  self endon("disconnect");
  self endon("unset_combathigh");

  for(;;) {
    wait(0.05);

    if(self isUsingRemote()) {
      self thread _unsetPerk("specialty_combathigh");
      break;
    }
  }
}

unsetCombatHigh() {
  self notify("unset_combathigh");
  self.combatHighOverlay destroy();
  self.combatHighIcon destroy();
  self.combatHighTimer destroy();
}

setLightArmor(optionalArmorValue) {
  self notify("give_light_armor");

  if(isDefined(self.lightArmorHP))
    unsetLightArmor();

  self thread removeLightArmorOnDeath();
  self thread removeLightArmorOnMatchEnd();

  self.lightArmorHP = 150;

  if(isDefined(optionalArmorValue))
    self.lightArmorHP = optionalArmorValue;

  if(IsPlayer(self)) {
    self SetClientOmnvar("ui_light_armor", true);
    self _setNameplateMaterial("player_name_bg_green_vest", "player_name_bg_red_vest");
  }
}

removeLightArmorOnDeath() {
  self endon("disconnect");
  self endon("give_light_armor");
  self endon("remove_light_armor");

  self waittill("death");
  unsetLightArmor();
}

unsetLightArmor() {
  self.lightArmorHP = undefined;
  if(IsPlayer(self)) {
    self SetClientOmnvar("ui_light_armor", false);
    self _restorePreviousNameplateMaterial();
  }

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

hasHeavyArmor(player) {
  return (isDefined(player.heavyArmorHP) && (player.heavyArmorHP > 0));
}

setHeavyArmor(armorValue) {
  if(isDefined(armorValue)) {
    self.heavyArmorHP = armorValue;
  }
}

setRevenge() {
  self notify("stopRevenge");
  wait(0.05);

  if(!isDefined(self.lastKilledBy)) {
    return;
  }
  if(level.teamBased && self.team == self.lastKilledBy.team) {
    return;
  }
  revengeParams = spawnStruct();
  revengeParams.showTo = self;
  revengeParams.icon = "compassping_revenge";
  revengeParams.offset = (0, 0, 64);
  revengeParams.width = 10;
  revengeParams.height = 10;
  revengeParams.archived = false;
  revengeParams.delay = 1.5;
  revengeParams.constantSize = false;
  revengeParams.pinToScreenEdge = true;
  revengeParams.fadeOutPinnedIcon = false;
  revengeParams.is3D = false;
  self.revengeParams = revengeParams;

  self.lastKilledBy maps\mp\_entityheadIcons::setHeadIcon(
    revengeParams.showTo,
    revengeParams.icon,
    revengeParams.offset,
    revengeParams.width,
    revengeParams.height,
    revengeParams.archived,
    revengeParams.delay,
    revengeParams.constantSize,
    revengeParams.pinToScreenEdge,
    revengeParams.fadeOutPinnedIcon,
    revengeParams.is3D);

  self thread watchRevengeDeath();
  self thread watchRevengeKill();
  self thread watchRevengeDisconnected();
  self thread watchRevengeVictimDisconnected();
  self thread watchStopRevenge();
}

watchRevengeDeath() {
  self endon("stopRevenge");
  self endon("disconnect");

  lastKilledBy = self.lastKilledBy;

  while(true) {
    lastKilledBy waittill("spawned_player");
    lastKilledBy maps\mp\_entityheadIcons::setHeadIcon(
      self.revengeParams.showTo,
      self.revengeParams.icon,
      self.revengeParams.offset,
      self.revengeParams.width,
      self.revengeParams.height,
      self.revengeParams.archived,
      self.revengeParams.delay,
      self.revengeParams.constantSize,
      self.revengeParams.pinToScreenEdge,
      self.revengeParams.fadeOutPinnedIcon,
      self.revengeParams.is3D);
  }
}

watchRevengeKill() {
  self endon("stopRevenge");

  self waittill("killed_enemy");

  self notify("stopRevenge");
}

watchRevengeDisconnected() {
  self endon("stopRevenge");

  self.lastKilledBy waittill("disconnect");

  self notify("stopRevenge");
}

watchStopRevenge() {
  lastKilledBy = self.lastKilledBy;

  self waittill("stopRevenge");

  if(!isDefined(lastKilledBy)) {
    return;
  }
  foreach(key, headIcon in lastKilledBy.entityHeadIcons) {
    if(!isDefined(headIcon)) {
      continue;
    }
    headIcon destroy();
  }

}

watchRevengeVictimDisconnected() {
  objID = self.objIdFriendly;
  lastKilledBy = self.lastKilledBy;
  lastKilledBy endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");

  self waittill("disconnect");

  if(!isDefined(lastKilledBy)) {
    return;
  }
  foreach(key, headIcon in lastKilledBy.entityHeadIcons) {
    if(!isDefined(headIcon)) {
      continue;
    }
    headIcon destroy();
  }

}

unsetRevenge() {
  self notify("stopRevenge");
}