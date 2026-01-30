/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_playerlogic.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

TimeUntilWavespawn(minimumWait) {
  if(!self.hasSpawned) {
    return 0;
  }

  earliestSpawnTime = gettime() + minimumWait * 1000;

  lastWaveTime = level.lastWave[self.pers["team"]];
  waveDelay = level.waveDelay[self.pers["team"]] * 1000;

  numWavesPassedEarliestSpawnTime = (earliestSpawnTime - lastWaveTime) / waveDelay;

  numWaves = ceil(numWavesPassedEarliestSpawnTime);

  timeOfSpawn = lastWaveTime + numWaves * waveDelay;

  if(isDefined(self.respawnTimerStartTime)) {
    timeAlreadyPassed = (gettime() - self.respawnTimerStartTime) / 1000.0;

    if(self.respawnTimerStartTime < lastWaveTime) {
      return 0;
    }
  }

  if(isDefined(self.waveSpawnIndex)) {
    timeOfSpawn += 50 * self.waveSpawnIndex;
  }

  return (timeOfSpawn - gettime()) / 1000;
}

TeamKillDelay() {
  teamKills = self.pers["teamkills"];

  if(teamkills <= level.maxAllowedTeamKills) {
    return 0;
  }

  exceeded = (teamkills - level.maxAllowedTeamKills);
  return maps\mp\gametypes\_tweakables::getTweakableValue("team", "teamkillspawndelay") * exceeded;
}

TimeUntilspawn(includePenalties) {
  if((level.inGracePeriod && !self.hasSpawned) || level.gameended) {
    return 0;
  }

  respawnDelay = 0;
  if(self.hasSpawned) {
    result = self[[level.onRespawnDelay]]();
    if(isDefined(result)) {
      respawnDelay = result;
    } else {
      respawnDelay = getDvarInt("scr_" + level.gameType + "_playerrespawndelay");
    }

    if(includePenalties) {
      if(isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
        respawnDelay += TeamKillDelay();
      }

      if(isDefined(self.pers["suicideSpawnDelay"])) {
        respawnDelay += self.pers["suicideSpawnDelay"];
      }
    }

    if(isDefined(self.respawnTimerStartTime)) {
      timeAlreadyPassed = (gettime() - self.respawnTimerStartTime) / 1000.0;
      respawnDelay -= timeAlreadyPassed;
      if(respawnDelay < 0) {
        respawnDelay = 0;
      }
    }

    if(isDefined(self.setSpawnPoint)) {
      respawnDelay += level.tiSpawnDelay;
    }

  }

  waveBased = (getDvarFloat("scr_" + level.gameType + "_waverespawndelay") > 0);

  if(waveBased) {
    return self TimeUntilWavespawn(respawnDelay);
  }

  return respawnDelay;
}

mayspawn() {
  if(getGametypeNumLives() || isDefined(level.disableSpawning)) {
    if(isDefined(level.disableSpawning) && level.disableSpawning) {
      return false;
    }

    if(isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
      return false;
    }

    if(isDefined(self.pers["suicideSpawnDelay"]) && self.pers["suicideSpawnDelay"] > 0) {
      return false;
    }

    if(!self.pers["lives"] && gameHasStarted()) {
      return false;
    } else if(gameHasStarted()) {
      if(!level.inGracePeriod && !self.hasSpawned && (isDefined(level.allowLateComers) && !level.allowLateComers)) {
        return false;
      }
    }
  }

  return true;
}

spawnClient() {
  self endon("becameSpectator");
  assert(isDefined(self.team));
  assert(isValidClass(self.class));

  if(isDefined(self.waitingToSelectClass) && self.waitingToSelectClass) {
    self waittill("notWaitingToSelectClass");
  }

  if(isDefined(self.addToTeam)) {
    self maps\mp\gametypes\_menus::addToTeam(self.addToTeam);
    self.addToTeam = undefined;
  }

  if(!self mayspawn()) {
    wait 0.05;

    self notify("attempted_spawn");

    self_pers_teamKillPunish = self.pers["teamKillPunish"];
    if(isDefined(self_pers_teamKillPunish) && self_pers_teamKillPunish) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      setLowerMessage("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT");

      if(!self.hasSpawned && TeamKillDelay() <= 0) {
        self.pers["teamKillPunish"] = false;
      }

    } else if(isRoundBased() && !isLastRound()) {
      if(isDefined(self.tagAvailable) && self.tagAvailable) {
        setLowerMessage("spawn_info", game["strings"]["spawn_tag_wait"]);
      } else {
        setLowerMessage("spawn_info", game["strings"]["spawn_next_round"]);
      }
      self thread removeSpawnMessageShortly(3.0);
    }

    self thread spawnSpectator();
    return;
  }

  if(self.waitingToSpawn) {
    return;
  }

  self.waitingToSpawn = true;

  self waitAndSpawnClient();

  if(isDefined(self)) {
    self.waitingToSpawn = false;
  }
}

streamPrimaryWeapons() {
  if(allowClassChoice() && !IsAI(self)) {
    primaries = [];
    classes = ["custom1", "custom2", "custom3", "custom4", "custom5", "class0", "class1", "class2", "class3", "class4"];
    foreach(c in classes) {
      assert(isValidClass(c));
      loadout = self maps\mp\gametypes\_class::getLoadout(self.team, c);
      primaries[primaries.size] = loadout.primaryName;
    }

    self LoadWeapons(primaries);
  }
}

gatherClassWeapons(primaryOnly, overrideClass) {
  weapons = [];

  class = overrideClass;
  if(!isValidClass(class)) {
    class = self.class;
  }

  if(isValidClass(class)) {
    loadout = self maps\mp\gametypes\_class::getLoadout(self.team, class);

    weapons[weapons.size] = loadout.primaryName;
    if(!isDefined(primaryOnly) || !primaryOnly) {
      weapons[weapons.size] = loadout.secondaryName;
    }
  }

  return weapons;
}

streamClassWeapons(shouldWait, primaryOnly, overrideClass) {
  self.classWeaponsWait = false;

  self notify("endStreamClassWeapons");
  self endon("endStreamClassWeapons");
  self endon("death");
  self endon("disconnect");

  if(IsAI(self) || !isDefined(shouldWait)) {
    shouldWait = false;
  }

  weapons = gatherClassWeapons(primaryOnly, overrideClass);

  if(weapons.size > 0) {
    while(isDefined(self.loadingPlayerWeapons) && self.loadingPlayerWeapons) {
      wait 0.05;
    }

    shouldWait = !self LoadWeapons(weapons) && shouldWait;

    self OnlyStreamActiveWeapon(true);

    self.classWeaponsWait = shouldWait;
    while(shouldWait) {
      waitframe();
      shouldWait = !self LoadWeapons(weapons);
    }

    self OnlyStreamActiveWeapon(false);
  }

  self.classWeaponsWait = false;

  self notify("streamClassWeaponsComplete");
}

waitAndSpawnClient() {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");

  self notify("attempted_spawn");

  spawnedAsSpectator = false;

  spawnPoints = getEntArray("mp_global_intermission", "classname");
  spectatorSpawnPoint = spawnPoints[RandomInt(spawnPoints.size)];

  self_pers_teamKillPunish = self.pers["teamKillPunish"];
  if(isDefined(self_pers_teamKillPunish) && self_pers_teamKillPunish) {
    teamKillDelay = TeamKillDelay();

    if(teamKillDelay > 0) {
      setLowerMessage("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT", teamKillDelay, 1, true);

      self thread respawn_asSpectator(spectatorSpawnPoint.origin, spectatorSpawnPoint.angles);
      spawnedAsSpectator = true;

      wait(teamKillDelay);
      clearLowerMessage("friendly_fire");
      self.respawnTimerStartTime = gettime();
    }

    self.pers["teamKillPunish"] = false;
  } else if(TeamKillDelay()) {
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
  }

  self_pers_suicideSpawnDelay = self.pers["suicideSpawnDelay"];
  if(isDefined(self_pers_suicideSpawnDelay) && self_pers_suicideSpawnDelay > 0) {
    setLowerMessage("suicidePenalty", &"MP_SUICIDE_PUNISHED", self_pers_suicideSpawnDelay, 1, true);

    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(spectatorSpawnPoint.origin, spectatorSpawnPoint.angles);
    }
    spawnedAsSpectator = true;

    wait(self_pers_suicideSpawnDelay);
    clearLowerMessage("suicidePenalty");
    self.respawnTimerStartTime = gettime();

    self.pers["suicideSpawnDelay"] = 0;
  }

  if(self isUsingRemote()) {
    self.spawningAfterRemoteDeath = true;
    self.deathPosition = self.origin;

    self waittill("stopped_using_remote");
  }

  if(!isDefined(self.waveSpawnIndex) && isDefined(level.wavePlayerSpawnIndex[self.team])) {
    self.waveSpawnIndex = level.wavePlayerSpawnIndex[self.team];
    level.wavePlayerSpawnIndex[self.team]++;
  }

  timeUntilSpawn = TimeUntilspawn(false);

  if(timeUntilSpawn > 0) {
    self SetClientOmnvar("ui_killcam_time_until_spawn", GetTime() + timeUntilSpawn * 1000);

    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(spectatorSpawnPoint.origin, spectatorSpawnPoint.angles);
    }
    spawnedAsSpectator = true;

    self waitForTimeOrNotify(timeUntilSpawn, "force_spawn");

    self notify("stop_wait_safe_spawn_button");
  }

  if(self needsButtonToRespawn()) {
    setLowerMessage("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, true);

    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(spectatorSpawnPoint.origin, spectatorSpawnPoint.angles);
    }
    spawnedAsSpectator = true;

    self waitRespawnButton();
  }

  self.waitingToSpawn = false;

  self clearLowerMessage("spawn_info");

  self.waveSpawnIndex = undefined;

  self thread spawnPlayer();
}

needsButtonToRespawn() {
  if(maps\mp\gametypes\_tweakables::getTweakableValue("player", "forcerespawn") != 0) {
    return false;
  }

  if(!self.hasSpawned) {
    return false;
  }

  waveBased = (getDvarFloat("scr_" + level.gameType + "_waverespawndelay") > 0);
  if(waveBased) {
    return false;
  }

  if(self.wantSafeSpawn) {
    return false;
  }

  return true;
}

waitRespawnButton() {
  self endon("disconnect");
  self endon("end_respawn");

  while(1) {
    if(self useButtonPressed()) {
      break;
    }

    wait .05;
  }
}

removeSpawnMessageShortly(delay) {
  self endon("disconnect");
  level endon("game_ended");

  waittillframeend;

  self endon("end_respawn");

  wait delay;

  self clearLowerMessage("spawn_info");
}

lastStandRespawnPlayer() {
  self LastStandRevive();

  if(self _hasPerk("specialty_finalstand") && !level.dieHardMode) {
    self _unsetPerk("specialty_finalstand");
  }

  if(level.dieHardMode) {
    self.headicon = "";
  }

  self setStance("crouch");
  self.revived = true;

  self notify("revive");

  if(isDefined(self.standardmaxHealth)) {
    self.maxHealth = self.standardMaxHealth;
  }

  self.health = self.maxHealth;
  self _enableUsability();

  if(game["state"] == "postgame") {
    assert(!level.intermission);

    self maps\mp\gametypes\_gamelogic::freezePlayerForRoundEnd();
  }
}

getDeathSpawnPoint() {
  spawnpoint = spawn("script_origin", self.origin);
  spawnpoint hide();
  spawnpoint.angles = self.angles;
  return spawnpoint;
}

showSpawnNotifies() {}

getSpawnOrigin(spawnpoint) {
  if(!positionWouldTelefrag(spawnpoint.origin)) {
    return spawnpoint.origin;
  }

  if(!isDefined(spawnpoint.alternates)) {
    return spawnpoint.origin;
  }

  foreach(alternate in spawnpoint.alternates) {
    if(!positionWouldTelefrag(alternate)) {
      return alternate;
    }
  }

  return spawnpoint.origin;
}

tiValidationCheck() {
  if(!isDefined(self.setSpawnPoint)) {
    return false;
  }

  carePackages = getEntArray("care_package", "targetname");

  foreach(package in carePackages) {
    if(DistanceSquared(package.origin, self.setSpawnPoint.playerSpawnPos) > (64 * 64)) {
      continue;
    }

    maps\mp\perks\_perkfunctions::deleteTI(self.setSpawnpoint);
    return false;
  }

  return true;
}

spawningClientThisFrameReset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");

  wait 0.05;
  level.numPlayersWaitingToSpawn--;
}

setUIOptionsMenu(value) {
  self endon("disconnect");
  self endon("joined_spectators");

  while(self isMLGSpectator() && !inVirtualLobby()) {
    waitframe;
  }

  self setClientOmnvar("ui_options_menu", value);
}

gather_spawn_weapons() {
  weapons = [];

  if(isDefined(self.loadout)) {
    weapons[weapons.size] = get_spawn_weapon_name(self.loadout);
    if(isDefined(self.loadout.secondaryName) && (self.loadout.secondaryName != "none")) {
      weapons[weapons.size] = self.loadout.secondaryName;
    }
  } else {
    if(isDefined(self.primaryWeapon) && self.primaryWeapon != "none") {
      weapons[weapons.size] = self.primaryWeapon;
    }
    if(isDefined(self.secondaryWeapon) && self.secondaryWeapon != "none") {
      weapons[weapons.size] = self.secondaryWeapon;
    }
  }

  return weapons;
}

spawnPlayer(fauxSpawn, shouldGiveLoadout) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(!isDefined(fauxSpawn)) {
    fauxSpawn = false;
  }

  if(!isDefined(shouldGiveLoadout)) {
    shouldGiveLoadout = true;
  }

  self.lifeId = getNextLifeId();
  self.totalLifeTime = 0;

  self.isspawning = true;

  spawnPoint = undefined;
  self.TI_spawn = false;

  self thread setUIOptionsMenu(0);

  self SetClientOmnvar("ui_hud_shake", false);

  self SetClientOmnvar("ui_exo_cooldown_in_use", 0);

  self SetDemiGod(false);

  self DisableForceFirstPersonWhenFollowed();

  if(!level.inGracePeriod && !self.hasDoneCombat) {
    level.numPlayersWaitingToSpawn++;
    if(level.numPlayersWaitingToSpawn > 1) {
      println("spawning more than one client this frame");

      self.waitingToSpawnAmortize = true;
      wait 0.05 * (level.numPlayersWaitingToSpawn - 1);
    }

    self thread spawningClientThisFrameReset();
    self.waitingToSpawnAmortize = false;
  }

  if(shouldGiveLoadout) {
    self maps\mp\gametypes\_class::giveLoadout(self.team, self.class);

    weapons = self gather_spawn_weapons();

    self.loadingPlayerWeapons = true;

    if(!self HasLoadedCustomizationPlayerView(self, weapons)) {
      println("Waiting for client to load view models " + self.name + " at time " + gettime());

      self.waitingToSpawnAmortize = true;

      self OnlyStreamActiveWeapon(true);

      while(true) {
        waitframe();

        weapons = self gather_spawn_weapons();

        if(self HasLoadedCustomizationPlayerView(self, weapons)) {
          break;
        }
      }

      self OnlyStreamActiveWeapon(false);

      println("Finished waiting for client to load view models " + self.name + " at time " + gettime());

      self.waitingToSpawnAmortize = false;
    }

    self.loadingPlayerWeapons = false;
  }

  if(isDefined(self.forceSpawnOrigin)) {
    spawnOrigin = self.forceSpawnOrigin;
    self.forceSpawnOrigin = undefined;

    if(isDefined(self.forceSpawnAngles)) {
      spawnAngles = self.forceSpawnAngles;
      self.forceSpawnAngles = undefined;
    } else {
      spawnAngles = (0, RandomFloatRange(0, 360), 0);
    }
  } else if(isDefined(self.setSpawnPoint) && (isDefined(self.setSpawnPoint.notTI) || self tiValidationCheck())) {
    spawnPoint = self.setSpawnPoint;

    if(!isDefined(self.setSpawnPoint.notTI)) {
      self.TI_spawn = true;
      self playLocalSound("tactical_spawn");

      if(level.multiTeamBased) {
        foreach(teamname in level.teamNameList) {
          if(teamname != self.team) {
            self playSoundToTeam("tactical_spawn", teamname);
          }
        }
      } else if(level.teamBased) {
        self playSoundToTeam("tactical_spawn", level.otherTeam[self.team]);
      } else {
        self playSound("tactical_spawn");
      }
    }

    foreach(tank in level.ugvs) {
      if(DistanceSquared(tank.origin, spawnPoint.playerSpawnPos) < 1024) {
        tank notify("damage", 5000, tank.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, "killstreak_emp_mp");
      }
    }

    assert(isDefined(spawnPoint.playerSpawnPos));
    assert(isDefined(spawnPoint.angles));

    spawnOrigin = self.setSpawnPoint.playerSpawnPos;
    spawnAngles = self.setSpawnPoint.angles;

    if(isDefined(self.setSpawnPoint.enemyTrigger)) {
      self.setSpawnPoint.enemyTrigger Delete();
    }

    self.setSpawnPoint delete();

    spawnPoint = undefined;
  } else if(isDefined(self.isSpawningOnBattleBuddy) && isDefined(self.battleBuddy)) {
    spawnOrigin = undefined;
    spawnAngles = undefined;
    result = self maps\mp\gametypes\_battlebuddy::checkBuddyspawn();
    if(result.status == 0) {
      spawnOrigin = result.origin;
      spawnAngles = result.angles;
    } else {
      print("BattleBuddy Spawn error: " + result.status);

      spawnPoint = self[[level.getSpawnPoint]]();
      spawnOrigin = spawnPoint.origin;
      spawnAngles = spawnPoint.angles;
    }
    self maps\mp\gametypes\_battlebuddy::cleanupBuddyspawn();

    self SetClientOmnvar("cam_scene_name", "battle_spawn");
    self SetClientOmnvar("cam_scene_lead", self.battleBuddy getEntityNumber());
    self SetClientOmnvar("cam_scene_support", self getEntityNumber());
  } else if(isDefined(self.heliSpawning) && (!isDefined(self.firstSpawn) || isDefined(self.firstSpawn) && self.firstSpawn) && level.prematchPeriod > 0 && self.team == "allies") {
    while(!isDefined(level.alliesChopper)) {
      wait 0.1;
    }

    spawnOrigin = level.alliesChopper.origin;
    spawnAngles = level.alliesChopper.angles;

    self.firstSpawn = false;
  } else if(isDefined(self.heliSpawning) && (!isDefined(self.firstSpawn) || isDefined(self.firstSpawn) && self.firstSpawn) && level.prematchPeriod > 0 && self.team == "axis") {
    while(!isDefined(level.axisChopper)) {
      wait 0.1;
    }

    spawnOrigin = level.axisChopper.origin;
    spawnAngles = level.axisChopper.angles;

    self.firstSpawn = false;
  } else {
    spawnPoint = self[[level.getSpawnPoint]]();

    assert(isDefined(spawnPoint));
    assert(isDefined(spawnPoint.origin));
    assert(isDefined(spawnPoint.angles));

    spawnOrigin = spawnPoint.origin;
    spawnAngles = spawnPoint.angles;
  }

  self setSpawnVariables();

  if(!getDvarInt("force_ranking")) {
    assert((level.teamBased && (!allowTeamChoice() || self.sessionteam == self.team)) || (!level.teamBased && self.sessionteam == "none"));
  }

  hadSpawned = self.hasSpawned;

  self.fauxDead = undefined;

  if(!fauxSpawn) {
    self.killsThisLife = [];

    self updateSessionState("playing");
    self ClearKillcamState();
    self.cancelkillcam = undefined;

    self.maxhealth = maps\mp\gametypes\_tweakables::getTweakableValue("player", "maxhealth");
    self.health = self.maxhealth;

    self.friendlydamage = undefined;
    self.hasSpawned = true;
    self.spawnTime = getTime();
    self.spawnTimeDeciSecondsFromMatchStart = getTimePassedDeciSecondsIncludingRounds();
    self.wasTI = !isDefined(spawnPoint);
    self.afk = false;
    self.damagedPlayers = [];
    self.killStreakScaler = 1;
    self.objectiveScaler = 1;
    self.clampedHealth = undefined;
    self.shieldDamage = 0;
    self.shieldBulletHits = 0;

    self.exoCount = [];
    self.exoCount["exo_boost"] = 0;
    self.exoCount["ground_slam"] = 0;
    self.exoCount["exo_dodge"] = 0;
    self.exoCount["exo_slide"] = 0;
    self.exoMostRecentTimeDeciSeconds = [];

    self thread listenForExoMoveEvent();

    self.exo_shield_on = false;
    self.exo_hover_on = false;

    self.enemyHitCounts = [];
    self.currentFirefightShots = 0;

    if(!IsAI(self)) {
      self thread maps\mp\gametypes\_damage::clearFirefightShotsOnInterval();
    }

    self.scoreAtLifeStart = self.pers["score"];
    if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"])) {
      self.xpAtLifeStart = self.pers["summary"]["xp"];
    }
  }

  self.moveSpeedScaler = level.basePlayerMoveScale;
  self.inLastStand = false;
  self.lastStand = undefined;
  self.infinalStand = undefined;
  self.disabledWeapon = 0;
  self.disabledWeaponSwitch = 0;
  self.disabledOffhandWeapons = 0;
  self resetUsability();
  self.playerDisableAbilityTypes = [];

  if(!fauxSpawn) {
    self.avoidKillstreakOnSpawnTimer = 5.0;

    self_pers_lives = self.pers["lives"];
    if(self_pers_lives == getGametypeNumLives()) {
      maps\mp\gametypes\_playerlogic::addToLivesCount();
    }

    if(self_pers_lives) {
      self.pers["lives"]--;
    }

    self maps\mp\gametypes\_playerlogic::addToAliveCount();

    if(!hadSpawned || gameHasStarted() || (gameHasStarted() && level.inGracePeriod && self.hasDoneCombat)) {
      self maps\mp\gametypes\_playerlogic::removeFromLivesCount();
    }

    if(!self.wasAliveAtMatchStart) {
      acceptablePassedTime = 20;
      if(getTimeLimit() > 0 && acceptablePassedTime < getTimeLimit() * 60 / 4) {
        acceptablePassedTime = getTimeLimit() * 60 / 4;
      }

      if(level.inGracePeriod || getTimePassed() < acceptablePassedTime * 1000) {
        self.wasAliveAtMatchStart = true;
      }
    }
  }

  if(level.console) {
    self SetClientDvar("cg_fov", "65");
  }

  self resetUIDvarsOnspawn();

  if(isDefined(spawnPoint)) {
    self maps\mp\gametypes\_spawnlogic::finalizeSpawnpointChoice(spawnpoint);
    spawnOrigin = getSpawnOrigin(spawnpoint);
    spawnAngles = spawnpoint.angles;
  } else {
    self.lastSpawnTime = getTime();
  }

  self.spawnPos = spawnOrigin;

  self spawn(spawnOrigin, spawnAngles);

  self setDOF(level.dofDefault);

  if(fauxSpawn && isDefined(self.faux_spawn_stance)) {
    self setStance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  [[level.onSpawnPlayer]]();

  level.lastspawnedplayer = self;

  if(!fauxSpawn) {
    self maps\mp\gametypes\_missions::playerSpawned();

    if(IsAI(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"])) {
      self[[level.bot_funcs["player_spawned"]]]();
    }
  }

  prof_begin("spawnPlayer_postUTS");

  assert(isValidClass(self.class));

  self maps\mp\gametypes\_class::setClass(self.class);
  if(isDefined(level.custom_giveloadout)) {
    self[[level.custom_giveloadout]](fauxSpawn);
  } else if(shouldGiveLoadout) {
    self maps\mp\gametypes\_class::applyLoadout();
  }

  if(getDvarInt("camera_thirdPerson")) {
    self setThirdPersonDOF(true);
  }

  if(!gameFlag("prematch_done")) {
    self freezeControlsWrapper(true);
    self DisableAmmoGeneration();
  } else {
    self freezeControlsWrapper(false);
    self EnableAmmoGeneration();
  }

  if(!gameFlag("prematch_done") || !hadSpawned && game["state"] == "playing") {
    team = self.pers["team"];

    if(inOvertime()) {
      thread maps\mp\gametypes\_hud_message::oldNotifyMessage(game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, (1, 0, 0), "mp_last_stand");
    }

    thread showSpawnNotifies();
  }

  if(getIntProperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {}

  prof_end("spawnPlayer_postUTS");

  waittillframeend;

  self.spawningAfterRemoteDeath = undefined;

  self notify("spawned_player");
  level notify("player_spawned", self);

  if(game["state"] == "postgame") {
    assert(!level.intermission);

    self maps\mp\gametypes\_gamelogic::freezePlayerForRoundEnd();
  }

  if(isDefined(level.matchRules_switchTeamDisabled) && level.matchRules_switchTeamDisabled) {
    self SetClientOmnvar("ui_disable_team_change", 1);
  }
}

listenForExoMoveEvent() {
  self endon("disconnect");
  self endon("death");

  while(1) {
    type = self waittill_any_return("exo_boost", "ground_slam", "exo_dodge", "exo_slide");
    self.exoCount[type]++;
    self.exoMostRecentTimeDeciSeconds[type] = getTimePassedDeciSecondsIncludingRounds();
  }
}

spawnSpectator(origin, angles) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  in_spawnSpectator(origin, angles);
}

respawn_asSpectator(origin, angles) {
  in_spawnSpectator(origin, angles);
}

in_spawnSpectator(origin, angles) {
  self setSpawnVariables();

  self_pers_team = self.pers["team"];
  if(isDefined(self_pers_team) && self_pers_team == "spectator" && !level.gameEnded) {
    self clearLowerMessage("spawn_info");
  }

  self updateSessionState("spectator");
  self ClearKillcamState();
  self.friendlydamage = undefined;
  self.loadingPlayerWeapons = undefined;

  self resetUIDvarsOnSpectate();

  maps\mp\gametypes\_spectating::setSpectatePermissions();

  onSpawnSpectator(origin, angles);

  if(level.teamBased && !level.splitscreen && !self IsSplitScreenPlayer()) {
    self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
  }
}

getPlayerFromClientNum(clientNum) {
  if(clientNum < 0) {
    return undefined;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] getEntityNumber() == clientNum) {
      return level.players[i];
    }
  }
  return undefined;
}

getRandomSpectatorSpawnPoint() {
  spawnpointname = "mp_global_intermission";
  spawnpoints = getEntArray(spawnpointname, "classname");
  assert(spawnpoints.size);
  spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
  return spawnpoint;
}

onSpawnSpectator(origin, angles) {
  if(isDefined(origin) && isDefined(angles)) {
    self SetSpectateDefaults(origin, angles);
    self spawn(origin, angles);

    return;
  }

  spawnpoint = getRandomSpectatorSpawnPoint();

  self SetSpectateDefaults(spawnpoint.origin, spawnpoint.angles);
  self spawn(spawnpoint.origin, spawnpoint.angles);
}

spawnIntermission() {
  self endon("disconnect");

  self notify("spawned");
  self notify("end_respawn");

  self setSpawnVariables();

  self clearLowerMessages();

  self freezeControlsWrapper(true);
  self DisableAmmoGeneration();

  self SetClientDvar("cg_everyoneHearsEveryone", 1);

  self_pers_postGameChallenges = self.pers["postGameChallenges"];
  if(level.rankedMatch && (self.postGamePromotion || (isDefined(self_pers_postGameChallenges) && self_pers_postGameChallenges))) {
    if(self.postGamePromotion) {
      self playLocalSound("mp_level_up");
    } else if(isDefined(self_pers_postGameChallenges)) {
      self playLocalSound("mp_challenge_complete");
    }

    if(self.postGamePromotion > level.postGameNotifies) {
      level.postGameNotifies = 1;
    }

    if(isDefined(self_pers_postGameChallenges) && self_pers_postGameChallenges > level.postGameNotifies) {
      level.postGameNotifies = self_pers_postGameChallenges;
    }

    waitTime = 7.0;
    if(isDefined(self_pers_postGameChallenges)) {
      waitTime = 4.0 + min(self_pers_postGameChallenges, 3);
    }

    while(waitTime) {
      wait(0.25);
      waitTime -= 0.25;
    }
  }

  self updateSessionState("intermission");
  self ClearKillcamState();
  self.friendlydamage = undefined;

  spawnPoints = getEntArray("mp_global_intermission", "classname");
  assertEx(spawnPoints.size, "NO mp_global_intermission SPAWNPOINTS IN MAP");

  spawnPoint = spawnPoints[0];
  self spawn(spawnPoint.origin, spawnPoint.angles);

  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

spawnEndOfGame() {
  if(1) {
    self freezeControlsWrapper(true);
    self DisableAmmoGeneration();
    self spawnSpectator();
    self freezeControlsWrapper(true);
    self DisableAmmoGeneration();
    return;
  }

  self notify("spawned");
  self notify("end_respawn");

  self setSpawnVariables();

  self clearLowerMessages();

  self SetClientDvar("cg_everyoneHearsEveryone", 1);

  self updateSessionState("dead");
  self ClearKillcamState();
  self.friendlydamage = undefined;

  spawnPoints = getEntArray("mp_global_intermission", "classname");
  assertEx(spawnPoints.size, "NO mp_global_intermission SPAWNPOINTS IN MAP");
  spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

  self spawn(spawnPoint.origin, spawnPoint.angles);

  spawnPoint setModel("tag_origin");

  self playerLinkTo(spawnPoint);

  self PlayerHide();
  self freezeControlsWrapper(true);
  self DisableAmmoGeneration();

  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}

setSpawnVariables() {
  self StopShellshock();
  self StopRumble("damage_heavy");
  self.deathPosition = undefined;
}

notifyConnecting() {
  waittillframeend;

  if(isDefined(self)) {
    level notify("connecting", self);
  }
}

logExoStats() {
  if(isDefined(self.pers["numberOfTimesCloakingUsed"])) {
    setMatchData("players", self.clientid, "numberOfTimesCloakingUsed", clampToByte(self.pers["numberOfTimesCloakingUsed"]));
  }

  if(isDefined(self.pers["numberOfTimesHoveringUsed"])) {
    setMatchData("players", self.clientid, "numberOfTimesHoveringUsed", clampToByte(self.pers["numberOfTimesHoveringUsed"]));
  }

  if(isDefined(self.pers["numberOfTimesShieldUsed"])) {
    setMatchData("players", self.clientid, "numberOfTimesShieldUsed", clampToByte(self.pers["numberOfTimesShieldUsed"]));
  }

  if(isDefined(self.pers["bulletsBlockedByShield"])) {
    setMatchData("players", self.clientid, "bulletsBlockedByShield", self.pers["bulletsBlockedByShield"]);
  }
}

logPlayerStats() {
  self logExoStats();

  if(isDefined(self.pers["totalKillcamsSkipped"])) {
    setMatchData("players", self.clientid, "totalKillcamsSkipped", clampToByte(self.pers["totalKillcamsSkipped"]));
  }

  if(isDefined(self.pers["weaponPickupsCount"])) {
    setMatchData("players", self.clientid, "weaponPickupsCount", clampToByte(self.pers["weaponPickupsCount"]));
  }

  if(isDefined(self.pers["suicides"])) {
    setMatchData("players", self.clientid, "suicidesTotal", clampToByte(self.pers["suicides"]));
  }

  if(isDefined(self.pers["headshots"])) {
    setMatchData("players", self.clientid, "headshotsTotal", clampToShort(self.pers["headshots"]));
  }

  if(isDefined(self.pers["pingAccumulation"]) && isDefined(self.pers["pingSampleCount"])) {
    if(self.pers["pingSampleCount"] > 0) {
      averagePing = clampToByte(self.pers["pingAccumulation"] / self.pers["pingSampleCount"]);
      setMatchData("players", self.clientid, "averagePing", averagePing);
    }
  }

  if(self rankingEnabled()) {
    const_XpMultiplierCount = 3;
    xpMultHighest = 0;
    for(i = 0; i < const_XpMultiplierCount; i++) {
      xpMult = self getRankedPlayerData("xpMultiplier", i);
      if(isDefined(xpMult) && xpMult > xpMultHighest) {
        xpMultHighest = xpMult;
      }
    }
    if(xpMultHighest > 0) {
      setMatchData("players", self.clientid, "xpMultiplier", xpMultHighest);
    }
  }

  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["clanWarsXP"])) {
    setMatchData("players", self.clientid, "clanWarsXp", self.pers["summary"]["clanWarsXP"]);
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    [[level.hordeUpdateTimeStats]](self);
  }
}

Callback_PlayerDisconnect(reason) {
  if(!isDefined(self.connected)) {
    return;
  }

  setMatchData("players", self.clientid, "disconnectTimeUTC", getSystemTime());
  setMatchData("players", self.clientid, "disconnectReason", reason);

  if(self rankingEnabled()) {
    self maps\mp\_matchdata::logFinalStats();
  }

  if(isDefined(self.pers["confirmed"])) {
    self maps\mp\_matchdata::logKillsConfirmed();
  }
  if(isDefined(self.pers["denied"])) {
    self maps\mp\_matchdata::logKillsDenied();
  }

  self logPlayerStats();

  if(isRoundBased()) {
    currRound = game["roundsPlayed"] + 1;
    setMatchData("players", self.clientid, "playerQuitRoundNumber", currRound);

    if(isDefined(self.team) && (self.team == "allies" || self.team == "axis")) {
      if(self.team == "allies") {
        setMatchData("players", self.clientid, "playerQuitTeamScore", game["roundsWon"]["allies"]);
        setMatchData("players", self.clientid, "playerQuitOpposingTeamScore", game["roundsWon"]["axis"]);
      } else {
        setMatchData("players", self.clientid, "playerQuitTeamScore", game["roundsWon"]["axis"]);
        setMatchData("players", self.clientid, "playerQuitOpposingTeamScore", game["roundsWon"]["allies"]);
      }
    }

  } else {
    if(isDefined(self.team) && (self.team == "allies" || self.team == "axis") && level.teamBased) {
      if(self.team == "allies") {
        setMatchData("players", self.clientid, "playerQuitTeamScore", game["teamScores"]["allies"]);
        setMatchData("players", self.clientid, "playerQuitOpposingTeamScore", game["teamScores"]["axis"]);
      } else {
        setMatchData("players", self.clientid, "playerQuitTeamScore", game["teamScores"]["axis"]);
        setMatchData("players", self.clientid, "playerQuitOpposingTeamScore", game["teamScores"]["allies"]);
      }
    }
  }

  self removePlayerOnDisconnect();
  self maps\mp\gametypes\_spawnlogic::removeFromParticipantsArray();
  self maps\mp\gametypes\_spawnlogic::removeFromCharactersArray();

  entNum = self GetEntityNumber();

  if(!level.teamBased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(!level.gameEnded) {
    self logXPGains();
  }

  if(level.splitscreen) {
    players = level.players;

    if(players.size <= 1) {
      level thread maps\mp\gametypes\_gamelogic::forceEnd();
    }
  }

  if(isDefined(self.score) && isDefined(self.pers["team"])) {
    spm = self.score;
    if(getMinutesPassed()) {
      spm = self.score / getMinutesPassed();
    }

    println("Score:" + self.score + " Minutes Passed:" + getMinutesPassed() + " SPM:" + spm);

    setPlayerTeamRank(self, self.clientid, int(spm));
  }

  ReconEvent("script_mp_playerquit: player_name %s, player %d, gameTime %d", self.name, self.clientid, GetTime());

  lpselfnum = self getEntityNumber();
  lpGuid = self.guid;
  logPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.name + "\n");

  self thread maps\mp\_events::disconnected();

  if(level.gameEnded) {
    self maps\mp\gametypes\_gamescore::removeDisconnectedPlayerFromPlacement();
  }

  if(isDefined(self.team)) {
    self maps\mp\gametypes\_playerlogic::removeFromTeamCount();
  }

  if(self.sessionstate == "playing" && !(isDefined(self.fauxDead) && self.fauxdead)) {
    self maps\mp\gametypes\_playerlogic::removeFromAliveCount(true);
  } else if(self.sessionstate == "spectator" || self.sessionstate == "dead") {
    level thread maps\mp\gametypes\_gamelogic::updateGameEvents();
  }
}

removePlayerOnDisconnect() {
  found = false;
  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      found = true;
      while(entry < level.players.size - 1) {
        level.players[entry] = level.players[entry + 1];
        assert(level.players[entry] != self);
        entry++;
      }
      level.players[entry] = undefined;
      break;
    }
  }
  assert(found);
}

initClientDvarsSplitScreenSpecific() {
  if(level.splitScreen || self IsSplitscreenPlayer()) {
    self SetClientDvars("cg_hudGrenadeIconHeight", "37.5", "cg_hudGrenadeIconWidth", "37.5", "cg_hudGrenadeIconOffset", "75", "cg_hudGrenadePointerHeight", "18", "cg_hudGrenadePointerWidth", "37.5", "cg_hudGrenadePointerPivot", "18 40.5", "cg_fovscale", "0.75");
  } else {
    self SetClientDvars("cg_hudGrenadeIconHeight", "75", "cg_hudGrenadeIconWidth", "75", "cg_hudGrenadeIconOffset", "50", "cg_hudGrenadePointerHeight", "36", "cg_hudGrenadePointerWidth", "75", "cg_hudGrenadePointerPivot", "36 81", "cg_fovscale", "1");
  }
}

initClientDvars() {
  setDvar("cg_drawTalk", 1);
  setDvar("cg_drawCrosshair", 1);
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_hudGrenadeIconMaxRangeFrag", 250);

  if(level.hardcoreMode) {
    setDvar("cg_drawTalk", 3);
    setDvar("cg_drawCrosshair", 0);
    setDvar("cg_drawCrosshairNames", 1);
    setDvar("cg_hudGrenadeIconMaxRangeFrag", 0);
  }

  if(isDefined(level.alwaysdrawfriendlyNames) && level.alwaysdrawfriendlyNames) {
    setDvar("cg_drawFriendlyNamesAlways", 1);
  } else {
    setDvar("cg_drawFriendlyNamesAlways", 0);
  }

  self initClientDvarsSplitScreenSpecific();

  if(getGametypeNumLives()) {
    self SetClientDvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
  } else {
    self SetClientDvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);
  }

  if(level.teamBased) {
    self SetClientDvars("cg_everyonehearseveryone", 0);
  }

  if(getdvarint("scr_hitloc_debug")) {
    for(i = 0; i < 6; i++) {
      self SetClientDvar("ui_hitloc_" + i, "");
    }
    self.hitlocInited = true;
  }
}

getLowestAvailableClientId() {
  found = false;

  for(i = 0; i < 30; i++) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(player.clientId == i) {
        found = true;
        break;
      }

      found = false;
    }

    if(!found) {
      return i;
    }
  }

}

setupSavedActionSlots() {
  self.saved_actionSlotData = [];
  for(slotID = 1; slotID <= 4; slotID++) {
    self.saved_actionSlotData[slotID] = spawnStruct();
    self.saved_actionSlotData[slotID].type = "";
    self.saved_actionSlotData[slotID].item = undefined;
  }

  if(!level.console) {
    for(slotID = 5; slotID <= 8; slotID++) {
      self.saved_actionSlotData[slotID] = spawnStruct();
      self.saved_actionSlotData[slotID].type = "";
      self.saved_actionSlotData[slotID].item = undefined;
    }
  }
}

logPlayerConsoleIDAndOnWifiInMatchData() {
  platform = getCODAnywhereCurrentPlatform();

  consoleIDChunkLow = self getCommonPlayerData("consoleIDChunkLow", platform);
  consoleIDChunkHigh = self getCommonPlayerData("consoleIDChunkHigh", platform);

  if(isDefined(consoleIDChunkLow) && consoleIDChunkLow != 0) {
    setMatchData("players", self.clientid, "consoleIDChunkLow", consoleIDChunkLow);
  }
  if(isDefined(consoleIDChunkHigh) && consoleIDChunkHigh != 0) {
    setMatchData("players", self.clientid, "consoleIDChunkHigh", consoleIDChunkHigh);
  }

  const_DeviceConnectionHistoryCount = 3;

  slot = -1;
  if(isDefined(consoleIdChunkHigh) && consoleIDChunkHigh != 0 &&
    isDefined(consoleIdChunkLow) && consoleIDChunkLow != 0) {
    for(i = 0; i < const_DeviceConnectionHistoryCount; i++) {
      deviceIdHigh = self getCommonPlayerData("deviceConnectionHistory", i, "device_id_high");
      deviceIdLow = self getCommonPlayerData("deviceConnectionHistory", i, "device_id_low");
      if(deviceIdHigh == consoleIdChunkHigh && deviceIdLow == consoleIdChunkLow) {
        slot = i;
        break;
      }
    }
  }
  if(slot == -1) {
    highestFreq = 0;
    for(i = 0; i < const_DeviceConnectionHistoryCount; i++) {
      deviceUseFrequency = self getCommonPlayerData("deviceConnectionHistory", i, "deviceUseFrequency");
      if(deviceUseFrequency > highestFreq) {
        highestFreq = deviceUseFrequency;
        slot = i;
      }
    }
  }
  if(slot == -1) {
    slot = 0;
  }

  wifi = self getCommonPlayerData("deviceConnectionHistory", slot, "onWifi");
  if(wifi) {
    setMatchData("players", self.clientid, "playingOnWifi", true);
  }
}

truncatePlayername(playername) {
  if(level.xb3 && playername.size > 18) {
    endBracket = string_find(playername, "]");

    if(endBracket >= 0 && string_starts_with(playername, "[")) {
      playername = GetSubStr(playername, endBracket + 1);
    }
  }

  return playername;
}

Callback_PlayerConnect() {
  spawnpoint = getRandomSpectatorSpawnPoint();
  self SetSpectateDefaults(spawnpoint.origin, spawnpoint.angles);

  thread notifyConnecting();

  self waittill("begin");
  self.connectTime = getTime();

  level notify("connected", self);
  self.connected = true;

  if(self isHost()) {
    level.player = self;
  }

  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    iPrintLn(&"MP_CONNECTED", self);
  }

  self.usingOnlineDataOffline = self isUsingOnlineDataOffline();

  self initClientDvars();
  self initPlayerStats();

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self.guid = self getGuid();
  self.xuid = self getXuid();
  self.totalLifeTime = 0;

  firstConnect = false;
  if(!isDefined(self.pers["clientid"])) {
    if(game["clientid"] >= 30) {
      self.pers["clientid"] = getLowestAvailableClientId();
    } else {
      self.pers["clientid"] = game["clientid"];
    }

    if(game["clientid"] < 30) {
      game["clientid"]++;
    }

    firstConnect = true;
  }

  if(firstConnect && !InVIrtualLobby()) {
    self maps\mp\killstreaks\_killstreaks::resetAdrenaline(true);
  }

  if(practiceRoundGame() && firstConnect) {
    self maps\mp\gametypes\_class::assignPracticeRoundClasses();
  }

  if(firstConnect) {
    streamPrimaryWeapons();
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = false;
  self.pers["suicideSpawnDelay"] = 0;

  if(firstConnect) {
    ReconEvent("script_mp_playerjoin: player_name %s, player %d, gameTime %d", self.name, self.clientid, GetTime());
  }

  logPrint("J;" + self.guid + ";" + self getEntityNumber() + ";" + self.name + "\n");

  if(game["clientid"] <= 30 && game["clientid"] != getMatchData("playerCount")) {
    connectionIDChunkHigh = 0;
    connectionIDChunkLow = 0;

    if(!isAI(self) && matchMakingGame()) {
      self registerParty(self.clientid);
    }

    setMatchData("playerCount", game["clientid"]);
    setMatchData("players", self.clientid, "playerID", "xuid", self getXuid());
    setMatchData("players", self.clientid, "playerID", "ucdIDHigh", self getUcdIdHigh());
    setMatchData("players", self.clientid, "playerID", "ucdIDLow", self getUcdIdLow());
    setMatchData("players", self.clientid, "playerID", "clanIDHigh", self getClanIdHigh());
    setMatchData("players", self.clientid, "playerID", "clanIDLow", self getClanIdLow());

    setMatchData("players", self.clientid, "gamertag", truncatePlayername(self.name));
    setMatchData("players", self.clientid, "isBot", isAI(self));

    codeClientNum = self GetEntityNumber();
    setMatchData("players", self.clientid, "codeClientNum", clampToByte(codeClientNum));

    platform = getCODAnywhereCurrentPlatform();
    connectionIDChunkLow = self getCommonPlayerData("connectionIDChunkLow", platform);
    connectionIDChunkHigh = self getCommonPlayerData("connectionIDChunkHigh", platform);
    setMatchData("players", self.clientid, "connectionIDChunkLow", connectionIDChunkLow);
    setMatchData("players", self.clientid, "connectionIDChunkHigh", connectionIDChunkHigh);
    setmatchclientip(self, self.clientid);

    setMatchData("players", self.clientid, "joinType", self getJoinType());
    setMatchData("players", self.clientid, "connectTimeUTC", getSystemTime());

    setMatchData("players", self.clientid, "isSplitscreen", isSplitscreen());

    self logPlayerConsoleIDAndOnWifiInMatchData();

    if(self isHost()) {
      setMatchData("players", self.clientid, "wasAHost", true);
    }

    if(self rankingEnabled()) {
      self maps\mp\_matchdata::logInitialStats();
    }

    if(IsTestClient(self) || IsAI(self)) {
      connectedBot = true;
    } else {
      connectedBot = false;
    }

    if(matchMakingGame() && allowTeamChoice() && !connectedBot) {
      if((getDvarInt("force_ranking") && level.teamBased) || ((IsBot(self) || IsTestClient(self)) && level.teamBased)) {
        self.sessionteam = "allies";
      }

      assert(getdvarint("scr_runlevelandquit") == 1 || (level.multiTeamBased) || (level.teamBased && (self.sessionteam == "allies" || self.sessionteam == "axis")) || (!level.teamBased && self.sessionteam == "none"));
      setMatchData("players", self.clientid, "team", self.sessionteam);
    }

    if(IsAITeamParticipant(self)) {
      if(!isDefined(level.matchData)) {
        level.matchData = [];
      }

      if(!isDefined(level.matchData["botJoinCount"])) {
        level.matchData["botJoinCount"] = 1;
      } else {
        level.matchData["botJoinCount"]++;
      }
    }
  }

  if(!level.teamBased) {
    game["roundsWon"][self.guid] = 0;
  }

  self.leaderDialogQueue = [];
  self.leaderDialogLocQueue = [];
  self.leaderDialogActive = "";
  self.leaderDialogGroups = [];
  self.leaderDialogGroup = "";

  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
    self.killstreakCount = 0;
  }
  if(!isDefined(self.pers["cur_death_streak"])) {
    self.pers["cur_death_streak"] = 0;
  }
  if(!isDefined(self.pers["cur_kill_streak_for_nuke"])) {
    self.pers["cur_kill_streak_for_nuke"] = 0;
  }

  if(self rankingEnabled()) {
    self.kill_streak = self maps\mp\gametypes\_persistence::statGet("killStreak");
  }

  self.lastGrenadeSuicideTime = -1;

  self.teamkillsThisRound = 0;

  self.hasSpawned = false;
  self.waitingToSpawn = false;
  self.wantSafeSpawn = false;

  self.wasAliveAtMatchStart = false;
  self.moveSpeedScaler = level.basePlayerMoveScale;
  self.killStreakScaler = 1;
  self.objectiveScaler = 1;
  self.isSniper = false;

  self setupSavedActionSlots();

  level thread monitorPlayerSegments(self);
  self thread maps\mp\_flashgrenades::monitorFlash();

  self resetUIDvarsOnConnect();

  self maps\mp\_snd_common_mp::snd_mp_player_join();

  waittillframeend;

  foreach(player in level.players) {
    assert(player != self);
  }

  level.players[level.players.size] = self;
  self maps\mp\gametypes\_spawnlogic::addToParticipantsArray();
  self maps\mp\gametypes\_spawnlogic::addToCharactersArray();

  if(level.teambased) {
    self updateScores();
  }

  if(game["state"] == "postgame") {
    self.connectedPostGame = true;

    spawnIntermission();
    return;
  }

  if(getDvarInt("scr_debug_postgameconnect")) {
    self.pers["class"] = "";
    self.class = "";
    if(self.sessionteam != "spectator") {
      self.pers["team"] = self.sessionteam;
    }

    self.team = "free";
  }

  if(IsAI(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"])) {
    self thread[[level.bot_funcs["think"]]]();
  }

  level endon("game_ended");

  if(isDefined(level.hostMigrationTimer)) {
    println("Connect while level.hostMigrationTimer is active");
    if(!isDefined(self.hostMigrationControlsFrozen) || self.hostMigrationControlsFrozen == false) {
      println("Reset hostMigrationControlsFrozen to false");
      self.hostMigrationControlsFrozen = false;
      self thread maps\mp\gametypes\_hostmigration::hostMigrationTimerThink();
    }
  }

  if(isDefined(level.onPlayerConnectAudioInit)) {
    [[level.onPlayerConnectAudioInit]]();
  }

  if(!isDefined(self.pers["team"])) {
    if(matchMakingGame() && self.sessionteam != "none") {
      self thread spawnSpectator();

      if(isDefined(level.waitingForPlayers) && level.waitingForPlayers) {
        self freezeControlsWrapper(true);
      }

      self thread maps\mp\gametypes\_menus::setTeam(self.sessionteam);

      if(allowClassChoice()) {
        self thread setUIOptionsMenu(2);
      }

      self thread kickIfDontspawn();
      return;
    } else if(!matchMakingGame() && allowTeamChoice()) {
      self maps\mp\gametypes\_menus::menuSpectator();
      self thread setUIOptionsMenu(1);
    } else {
      self thread spawnSpectator();
      self[[level.autoassign]]();

      if(allowClassChoice()) {
        self thread setUIOptionsMenu(2);
      }

      if(matchMakingGame()) {
        self thread kickIfDontspawn();
      }

      return;
    }
  } else {
    self maps\mp\gametypes\_menus::addToTeam(self.pers["team"], true);

    if(isValidClass(self.pers["class"])) {
      self thread spawnClient();
      return;
    }

    self thread spawnSpectator();

    if(self.pers["team"] == "spectator") {
      if(allowTeamChoice()) {
        self maps\mp\gametypes\_menus::beginTeamChoice();
      } else {
        self[[level.autoassign]]();
      }
    } else {
      self maps\mp\gametypes\_menus::beginClassChoice();
    }
  }

  /#	
  assert(self.connectTime == getTime());
}

Callback_PlayerMigrated() {
  println("Player " + self.name + " finished migrating at time " + gettime());

  if(isDefined(self.connected) && self.connected) {
    self updateObjectiveText();
    self updateMainMenu();

    if(level.teambased) {
      self updateScores();
    }
  }

  if(self isHost()) {
    self initClientDvarsSplitScreenSpecific();
    setMatchData("players", self.clientid, "wasAHost", true);
  }

  humanPlayerCount = 0;
  foreach(player in level.players) {
    if(!IsBot(player) && !IsTestClient(player)) {
      humanPlayerCount++;
    }
  }

  if(!IsBot(self) && !IsTestClient(self)) {
    level.hostMigrationReturnedPlayerCount++;
    if(level.hostMigrationReturnedPlayerCount >= humanPlayerCount * 2 / 3) {
      println("2/3 of human players have finished migrating");
      level notify("hostmigration_enoughplayers");
    }
    self notify("player_migrated");
  }
}

forcespawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");

  wait(60.0);

  if(self.hasSpawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  if(!isValidClass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";

    self.class = self.pers["class"];

    self maps\mp\gametypes\_class::clearCopyCatLoadout();
  }

  self thread spawnClient();
}

kickIfDontspawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  self endon("attempted_spawn");

  waittime = getdvarfloat("scr_kick_time", 90);
  mintime = getdvarfloat("scr_kick_mintime", 45);

  starttime = gettime();

  if(self isHost()) {
    kickWait(120);
  } else {
    kickWait(waittime);
  }

  timePassed = (gettime() - starttime) / 1000;
  if(timePassed < waittime - .1 && timePassed < mintime) {
    return;
  }

  if(self.hasSpawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  kick(self getEntityNumber(), "EXE_PLAYERKICKED_INACTIVE");

  level thread maps\mp\gametypes\_gamelogic::updateGameEvents();
}

kickWait(waittime) {
  level endon("game_ended");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(waittime);
}

initPlayerStats() {
  self maps\mp\gametypes\_persistence::initBufferedStats();

  self.pers["lives"] = getGametypeNumLives();

  if(!isDefined(self.pers["deaths"])) {
    self initPersStat("deaths");
    self maps\mp\gametypes\_persistence::statSetChild("round", "deaths", 0);
  }
  self.deaths = self getPersStat("deaths");

  if(!isDefined(self.pers["score"])) {
    self initPersStat("score");
    self maps\mp\gametypes\_persistence::statSetChild("round", "score", 0);
    self maps\mp\gametypes\_persistence::statSetChildBuffered("round", "timePlayed", 0);
  }
  self.score = self getPersStat("score");
  self.timePlayed["total"] = maps\mp\gametypes\_persistence::statGetChildBuffered("round", "timePlayed");

  if(!isDefined(self.pers["suicides"])) {
    self initPersStat("suicides");
  }
  self.suicides = self getPersStat("suicides");

  if(!isDefined(self.pers["kills"])) {
    self initPersStat("kills");
    self maps\mp\gametypes\_persistence::statSetChild("round", "kills", 0);
  }
  self.kills = self getPersStat("kills");

  if(!isDefined(self.pers["headshots"])) {
    self initPersStat("headshots");
    self maps\mp\gametypes\_persistence::statSetChild("round", "headshots", 0);
  }
  self.headshots = self getPersStat("headshots");

  if(!isDefined(self.pers["assists"])) {
    self initPersStat("assists");
    self maps\mp\gametypes\_persistence::statSetChild("round", "assists", 0);
  }
  self.assists = self getPersStat("assists");

  if(!isDefined(self.pers["captures"])) {
    self initPersStat("captures");
    self maps\mp\gametypes\_persistence::statSetChild("round", "captures", 0);
  }

  if(!isDefined(self.pers["returns"])) {
    self initPersStat("returns");
    self maps\mp\gametypes\_persistence::statSetChild("round", "returns", 0);
  }
  self.returns = self getPersStat("returns");

  if(!isDefined(self.pers["defends"])) {
    self initPersStat("defends");
    self maps\mp\gametypes\_persistence::statSetChild("round", "defends", 0);
  }

  if(!isDefined(self.pers["plants"])) {
    self initPersStat("plants");
    self maps\mp\gametypes\_persistence::statSetChild("round", "plants", 0);
  }

  if(!isDefined(self.pers["defuses"])) {
    self initPersStat("defuses");
    self maps\mp\gametypes\_persistence::statSetChild("round", "defuses", 0);
  }

  if(!isDefined(self.pers["destructions"])) {
    self initPersStat("destructions");
    self maps\mp\gametypes\_persistence::statSetChild("round", "destructions", 0);
  }

  if(!isDefined(self.pers["confirmed"])) {
    self initPersStat("confirmed");
    self maps\mp\gametypes\_persistence::statSetChild("round", "confirmed", 0);
  }

  if(!isDefined(self.pers["denied"])) {
    self initPersStat("denied");
    self maps\mp\gametypes\_persistence::statSetChild("round", "denied", 0);
  }

  if(!isDefined(self.pers["rescues"])) {
    self initPersStat("rescues");
    self maps\mp\gametypes\_persistence::statSetChild("round", "rescues", 0);
  }

  if(!isDefined(self.pers["teamkills"])) {
    self initPersStat("teamkills");
  }

  if(!isDefined(self.pers["totalTeamKills"])) {
    self initPersStat("totalTeamKills");
  }

  if(!isDefined(self.pers["extrascore0"])) {
    self initPersStat("extrascore0");
  }

  if(!isDefined(self.pers["extrascore1"])) {
    self initPersStat("extrascore1");
  }

  if(!isDefined(self.pers["teamKillPunish"])) {
    self.pers["teamKillPunish"] = false;
  }

  if(!isDefined(self.pers["suicideSpawnDelay"])) {
    self.pers["suicideSpawnDelay"] = 0;
  }

  self initPersStat("longestStreak");

  self.pers["lives"] = getGametypeNumLives();

  self maps\mp\gametypes\_persistence::statSetChild("round", "killStreak", 0);
  self maps\mp\gametypes\_persistence::statSetChild("round", "loss", false);
  self maps\mp\gametypes\_persistence::statSetChild("round", "win", false);
  self maps\mp\gametypes\_persistence::statSetChild("round", "scoreboardType", "none");

  if(self rankingEnabled()) {
    if(!isDefined(self.pers["previous_shots"])) {
      self.pers["previous_shots"] = self getRankedPlayerData("totalShots");
    }

    if(!isDefined(self.pers["previous_hits"])) {
      self.pers["previous_hits"] = self getRankedPlayerData("hits");
    }
  }

  if(!isDefined(self.pers["mpWeaponStats"])) {
    self.pers["mpWeaponStats"] = [];
  }

  if(!isDefined(self.pers["numberOfTimesCloakingUsed"])) {
    self.pers["numberOfTimesCloakingUsed"] = 0;
  }

  if(!isDefined(self.pers["numberOfTimesHoveringUsed"])) {
    self.pers["numberOfTimesHoveringUsed"] = 0;
  }

  if(!isDefined(self.pers["numberOfTimesShieldUsed"])) {
    self.pers["numberOfTimesShieldUsed"] = 0;
  }

  if(!isDefined(self.pers["bulletsBlockedByShield"])) {
    self.pers["bulletsBlockedByShield"] = 0;
  }

  if(!isDefined(self.pers["totalKillcamsSkipped"])) {
    self.pers["totalKillcamsSkipped"] = 0;
  }

  if(!isDefined(self.pers["weaponPickupsCount"])) {
    self.pers["weaponPickupsCount"] = 0;
  }

  if(!isDefined(self.pers["pingAccumulation"])) {
    self.pers["pingAccumulation"] = 0;
  }

  if(!isDefined(self.pers["pingSampleCount"])) {
    self.pers["pingSampleCount"] = 0;
  }

  if(!isDefined(self.pers["minPing"])) {
    self.pers["minPing"] = 32767;
  }

  if(!isDefined(self.pers["maxPing"])) {
    self.pers["maxPing"] = 0;
  }

  if(!isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] = 0;
  }
}

addToTeamCount() {
  assert(isPlayer(self));
  assert(isDefined(self.team));
  assert(isDefined(self.pers["team"]));
  assert(self.team == self.pers["team"]);

  level.teamCount[self.team]++;

  if(!isDefined(level.teamList)) {
    level.teamList = [];
  }
  if(!isDefined(level.teamList[self.team])) {
    level.teamList[self.team] = [];
  }
  level.teamList[self.team][level.teamList[self.team].size] = self;

  maps\mp\gametypes\_gamelogic::updateGameEvents();
}

removeFromTeamCount() {
  assert(isPlayer(self));
  assert(isDefined(self.team));
  assert(isDefined(self.pers["team"]));
  assert(self.team == self.pers["team"]);

  level.teamCount[self.team]--;

  if(isDefined(level.teamList) && isDefined(level.teamList[self.team])) {
    teamList = [];
    foreach(player in level.teamList[self.team]) {
      if(!isDefined(player) || player == self) {
        continue;
      }
      teamList[teamList.size] = player;
    }
    level.teamList[self.team] = teamList;
  }
}

addToAliveCount() {
  assert(isPlayer(self));

  teamAdding = self.team;

  if(!(isDefined(self.alreadyAddedToAliveCount) && self.alreadyAddedToAliveCount)) {
    level.hasSpawned[teamAdding]++;
    self incrementAliveCount(teamAdding);
  }

  self.alreadyAddedToAliveCount = undefined;

  if(level.aliveCount["allies"] + level.aliveCount["axis"] > level.maxPlayerCount) {
    level.maxPlayerCount = level.aliveCount["allies"] + level.aliveCount["axis"];
  }
}

incrementAliveCount(teamAdding) {
  level.aliveCount[teamAdding]++;
  /#	
  if(!isDefined(level.alive_players)) {
    level.alive_players = [];
  }
  if(!isDefined(level.alive_players[teamAdding])) {
    level.alive_players[teamAdding] = [];
  }

  AssertEx(!array_contains(level.alive_players[teamAdding], self), "Player " + self.name + " somehow added to level.aliveCount twice");
  level.alive_players[teamAdding] = array_add(level.alive_players[teamAdding], self);

  if(level.alive_players[teamAdding].size != level.aliveCount[teamAdding]) {
    AssertMsg("WARNING: level.alive_players and level.aliveCount are out of sync!");
  }

}

removeFromAliveCount(disconnected) {
  assert(isPlayer(self));

  teamRemoving = self.team;
  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team) {
    teamRemoving = self.leaving_team;
  }

  if(isDefined(self.switching_teams) || isDefined(disconnected)) {
    self maps\mp\gametypes\_playerlogic::removeAllFromLivesCount();

    if(isDefined(self.switching_teams)) {
      self.pers["lives"] = 0;
    }
  }

  self decrementAliveCount(teamRemoving);
  return maps\mp\gametypes\_gamelogic::updateGameEvents();
}

decrementAliveCount(teamRemoving) {
  level.aliveCount[teamRemoving]--;
  /#	
  for(i = 0; i < level.alive_players[teamRemoving].size; i++) {
    if(level.alive_players[teamRemoving][i] == self) {
      level.alive_players[teamRemoving][i] = level.alive_players[teamRemoving][level.alive_players[teamRemoving].size - 1];
      level.alive_players[teamRemoving][level.alive_players[teamRemoving].size - 1] = undefined;
      break;
    }
  }

  if(level.alive_players[teamRemoving].size != level.aliveCount[teamRemoving]) {
    AssertMsg("WARNING: level.alive_players and level.aliveCount are out of sync!");
  }

}

addToLivesCount() {
  assert(isPlayer(self));
  level.livesCount[self.team] += self.pers["lives"];
}

removeFromLivesCount() {
  assert(isPlayer(self));
  level.livesCount[self.team]--;

  level.livesCount[self.team] = int(max(0, level.livesCount[self.team]));
}

removeAllFromLivesCount() {
  assert(isPlayer(self));
  level.livesCount[self.team] -= self.pers["lives"];

  level.livesCount[self.team] = int(max(0, level.livesCount[self.team]));
}

resetUIDvarsOnspawn() {
  self SetClientOmnvar("ui_carrying_bomb", false);
  self SetClientOmnvar("ui_capture_icon", 0);
  self SetClientOmnvar("ui_light_armor", false);

  self SetClientOmnvar("ui_killcam_end_milliseconds", 0);

  self SetClientOmnvar("ui_uplink_can_pass", false);
  self SetClientOmnvar("ui_light_armor_percent", 0);
  self SetClientOmnvar("ui_killcam_time_until_spawn", 0);
}

resetUIDvarsOnConnect() {
  self SetClientOmnvar("ui_carrying_bomb", false);
  self SetClientOmnvar("ui_capture_icon", 0);
  self SetClientOmnvar("ui_light_armor", false);
  self SetClientOmnvar("ui_killcam_end_milliseconds", 0);
}

resetUIDvarsOnSpectate() {
  self SetClientOmnvar("ui_carrying_bomb", false);
  self SetClientOmnvar("ui_capture_icon", 0);
  self SetClientOmnvar("ui_light_armor", false);
  self SetClientOmnvar("ui_killcam_end_milliseconds", 0);
}

resetUIDvarsOnDeath() {}

monitorPlayerSegments(player) {
  player endon("disconnect");
  levelendon("game_ended");

  createPlayerSegmentStats(player);

  while(true) {
    player waittill("spawned_player");
    recordSegemtData(player);
  }
}

createPlayerSegmentStats(player) {
  if(!isDefined(player.pers["segments"])) {
    player.pers["segments"] = [];
  }

  player.segments = player.pers["segments"];

  if(!player.segments.size) {
    player.segments["distanceTotal"] = 0;
    player.segments["movingTotal"] = 0;
    player.segments["movementUpdateCount"] = 0;
    player.segments["killDistanceTotal"] = 0;
    player.segments["killDistanceCount"] = 0;
  }
}

recordSegemtData(player) {
  player endon("death");

  while(!gameFlag("prematch_done")) {
    wait(0.5);
  }

  wait(4);

  player.savedPosition = player.origin;
  player.positionPTM = player.origin;

  while(true) {
    wait(1);

    if(player isUsingRemote()) {
      player waittill("stopped_using_remote");
      player.savedPosition = player.origin;
      player.positionPTM = player.origin;
      continue;
    }

    player.segments["movementUpdateCount"]++;
    player.segments["distanceTotal"] += Distance2D(player.savedPosition, player.origin);
    player.savedPosition = player.origin;

    if((player.segments["movementUpdateCount"] % 5) == 0) {
      distanceTraveled = Distance2D(player.positionPTM, player.origin);
      player.positionPTM = player.origin;

      if(distanceTraveled > 16) {
        player.segments["movingTotal"]++;
      }
    }
  }
}

const_segmentTableName = "mp/playerSegments.csv";
const_columnIndex = 1;
const_columnSpeed = 2;
const_columnPTM = 3;
const_columnAKD = 4;

writeSegmentData(player) {
  if(level.players.size < 2) {
    return;
  }

  player endon("disconnect");

  if((player.segments["movementUpdateCount"] < 30) || (player.segments["killDistanceCount"] < 1)) {
    return;
  }

  percentTimeMoving = (player.segments["movingTotal"] / int(player.segments["movementUpdateCount"] / 5)) * 100;
  averageSpeed = player.segments["distanceTotal"] / player.segments["movementUpdateCount"];
  averageKillDistance = player.segments["killDistanceTotal"] / player.segments["killDistanceCount"];

  percentTimeMoving = min(percentTimeMoving, float(TableLookup(const_segmentTableName, 0, "MAX", const_columnPTM)));
  averageSpeed = min(averageSpeed, float(TableLookup(const_segmentTableName, 0, "MAX", const_columnSpeed)));
  averageKillDistance = min(averageKillDistance, float(TableLookup(const_segmentTableName, 0, "MAX", const_columnAKD)));

  matchPlayStyle = calculateMatchPlayStyle(percentTimeMoving, averageSpeed, averageKillDistance);

  setMatchData("players", player.clientid, "averageSpeedDuringMatch", averageSpeed);
  setMatchData("players", player.clientid, "percentageOfTimeMoving", percentTimeMoving);
  setMatchData("players", player.clientid, "averageKillDistance", averageKillDistance);
  setMatchData("players", player.clientid, "totalDistanceTravelled", player.segments["distanceTotal"]);
  setMatchData("players", player.clientid, "playstyle", clampToByte(matchPlayStyle));

  if(IsAI(player)) {
    return;
  }

  ReconEvent("script_PlayerSegments: percentTimeMoving %f, averageSpeed %f, averageKillDistance %f, playStyle %d, name %s", percentTimeMoving, averageSpeed, averageKillDistance, matchPlayStyle, player.name);

  if(!(player rankingEnabled())) {
    return;
  }

  PlayStlyeTrendCount = 50;

  numTrends = player getRankedPlayerData("combatRecord", "numPlayStyleTrends");
  numTrends++;

  if(numTrends > PlayStlyeTrendCount) {
    numTrends = PlayStlyeTrendCount;

    if(PlayStlyeTrendCount > 1) {
      for(i = 0; i < (PlayStlyeTrendCount - 1); i++) {
        timestamp = player getRankedPlayerData("combatRecord", "playStyleTimeStamp", i + 1);
        playStyle = player getRankedPlayerData("combatRecord", "playStyle", i + 1);

        player setRankedPlayerData("combatRecord", "playStyleTimeStamp", i, timestamp);
        player setRankedPlayerData("combatRecord", "playStyle", i, playStyle);
      }
    }
  }

  timestamp = GetTimeUTC();
  player setRankedPlayerData("combatRecord", "playStyleTimeStamp", numTrends - 1, timestamp);
  player setRankedPlayerData("combatRecord", "playStyle", numTrends - 1, matchPlayStyle);
  player setRankedPlayerData("combatRecord", "numPlayStyleTrends", numTrends);
}

calculateMatchPlayStyle(PTM, speed, AKD) {
  PTM = normalizePlayerSegment(PTM, float(TableLookup(const_segmentTableName, 0, "Mean", const_columnPTM)), float(TableLookup(const_segmentTableName, 0, "SD", const_columnPTM)));
  speed = normalizePlayerSegment(speed, float(TableLookup(const_segmentTableName, 0, "Mean", const_columnSpeed)), float(TableLookup(const_segmentTableName, 0, "SD", const_columnSpeed)));
  AKD = normalizePlayerSegment(AKD, float(TableLookup(const_segmentTableName, 0, "Mean", const_columnAKD)), float(TableLookup(const_segmentTableName, 0, "SD", const_columnAKD)));

  playerCentroid = (PTM, speed, AKD);
  playStyles = ["Camper", "Mobile", "Run", "Sniper", "TacCQ"];
  bestPlayStyleName = "Camper";
  bestPlayStyleDist = 1000;

  foreach(playStyle in playStyles) {
    playStyleDistance = getCentroidDistance(playerCentroid, playStyle);

    if(playStyleDistance < bestPlayStyleDist) {
      bestPlayStyleName = playStyle;
      bestPlayStyleDist = playStyleDistance;
    }
  }

  return int(TableLookup(const_segmentTableName, 0, bestPlayStyleName, const_columnIndex));
}

normalizePlayerSegment(value, mean, SD) {
  return (value - mean) / SD;
}

getCentroidDistance(playerCentroid, playStyle) {
  playStyleCentroid = (float(TableLookup(const_segmentTableName, 0, playStyle, const_columnPTM)), float(TableLookup(const_segmentTableName, 0, playStyle, const_columnSpeed)), float(TableLookup(const_segmentTableName, 0, playStyle, const_columnAKD)));

  return Distance(playerCentroid, playStyleCentroid);
}

clearPracticeRoundLockoutData(player, matchCountMax) {
  player SetCommonPlayerData("practiceRoundLockoutTime", 0);
  for(i = 0; i < matchCountMax; i++) {
    player SetCommonPlayerData("practiceRoundLockoutMatchTimes", i, 0);
  }
}

checkPracticeRoundLockout(player) {
  assert(practiceRoundGame());

  if(IsBot(player) || IsAgent(player)) {
    return;
  }

  matchCountMax = 10;
  matchCountNeeded = 3;
  kdRatioThreshold = 5.0;
  goodMatchTimeThreshold = Int(24 * 60 * 60);
  lockoutTimeLength = Int(24 * 60 * 60);

  curLockoutTime = player GetCommonPlayerData("practiceRoundLockoutTime");
  if(curLockoutTime > 0) {
    clearPracticeRoundLockoutData(player, matchCountMax);
  }

  roundKills = player GetCommonPlayerData("round", "kills");
  roundDeaths = player GetCommonPlayerData("round", "deaths");
  roundDeaths = max(roundDeaths, 1);
  roundKD = (roundKills / roundDeaths);
  if(roundKD < kdRatioThreshold) {
    clearPracticeRoundLockoutData(player, matchCountMax);
    return;
  } else {
    curTimeUTC = GetTimeUTC();

    goodMatchTimeUTC = curTimeUTC - goodMatchTimeThreshold;

    leastRecentIndex = -1;
    leastRecentTimeUTC = curTimeUTC;
    goodMatchCount = 1;

    for(i = 0; i < matchCountMax; i++) {
      prevMatchTimeUTC = player GetCommonPlayerData("practiceRoundLockoutMatchTimes", i);

      if(prevMatchTimeUTC < leastRecentTimeUTC) {
        leastRecentTimeUTC = prevMatchTimeUTC;
        leastRecentIndex = i;
      }

      if(prevMatchTimeUTC >= goodMatchTimeUTC) {
        goodMatchCount++;
      }
    }

    assert(leastRecentIndex >= 0 && leastRecentIndex < matchCountMax);

    player SetCommonPlayerData("practiceRoundLockoutMatchTimes", leastRecentIndex, curTimeUTC);

    if(goodMatchCount >= matchCountNeeded) {
      lockoutTime = curTimeUTC + lockoutTimeLength;
      player SetCommonPlayerData("practiceRoundLockoutTime", lockoutTime);
    }
  }
}