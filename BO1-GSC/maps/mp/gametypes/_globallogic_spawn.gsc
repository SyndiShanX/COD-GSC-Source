/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_globallogic_spawn.gsc
****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

TimeUntilspawn(includeTeamkillDelay) {
  if(level.inGracePeriod && !self.hasSpawned) {
    return 0;
  }
  respawnDelay = 0;
  if(self.hasSpawned) {
    result = self[[level.onRespawnDelay]]();
    if(isDefined(result)) {
      respawnDelay = result;
    } else {
      respawnDelay = GetDvarInt("scr_" + level.gameType + "_playerrespawndelay");
    }
    if(includeTeamkillDelay && self.teamKillPunish) {
      respawnDelay += maps\mp\gametypes\_globallogic_player::TeamKillDelay();
    }
  }
  waveBased = (GetDvarInt("scr_" + level.gameType + "_waverespawndelay") > 0);
  if(waveBased) {
    return self TimeUntilWavespawn(respawnDelay);
  }
  return respawnDelay;
}
mayspawn() {
  if(isDefined(level.maySpawn) && !(self[[level.maySpawn]]())) {
    return false;
  }
  if(level.inOvertime) {
    return false;
  }
  if(level.numLives) {
    if(level.teamBased) {
      gameHasStarted = (level.everExisted["axis"] && level.everExisted["allies"]);
    } else {
      gameHasStarted = (level.maxPlayerCount > 1) || (!isOneRound() && !isFirstRound());
    }
    if(!self.pers["lives"] && gameHasStarted) {
      return false;
    } else if(gameHasStarted) {
      if(!level.inGracePeriod && !self.hasSpawned && !level.wagerMatch) {
        return false;
      }
    }
  }
  return true;
}
TimeUntilWavespawn(minimumWait) {
  earliestSpawnTime = gettime() + minimumWait * 1000;
  lastWaveTime = level.lastWave[self.pers["team"]];
  waveDelay = level.waveDelay[self.pers["team"]] * 1000;
  if(waveDelay == 0) {
    return 0;
  }
  numWavesPassedEarliestSpawnTime = (earliestSpawnTime - lastWaveTime) / waveDelay;
  numWaves = ceil(numWavesPassedEarliestSpawnTime);
  timeOfSpawn = lastWaveTime + numWaves * waveDelay;
  if(isDefined(self.waveSpawnIndex)) {
    timeOfSpawn += 50 * self.waveSpawnIndex;
  }
  return (timeOfSpawn - gettime()) / 1000;
}
stopPoisoningAndFlareOnspawn() {
  self endon("disconnect");
  self.inPoisonArea = false;
  self.inBurnArea = false;
  self.inFlareVisionArea = false;
  self.inGroundNapalm = false;
}
spawnPlayer() {
  pixbeginevent("spawnPlayer_preUTS");
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  level notify("player_spawned");
  self notify("end_respawn");
  self setSpawnVariables();
  if(!self.hasSpawned) {
    self thread sndStartMusicSystem();
  }
  if(level.teamBased) {
    self.sessionteam = self.team;
  } else {
    self.sessionteam = "none";
    self.ffateam = self.team;
  }
  hadSpawned = self.hasSpawned;
  self.sessionstate = "playing";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.statusicon = "";
  self.damagedPlayers = [];
  if(GetDvarInt(#"scr_csmode") > 0) {
    self.maxhealth = GetDvarInt(#"scr_csmode");
  } else {
    self.maxhealth = maps\mp\gametypes\_tweakables::getTweakableValue("player", "maxhealth");
  }
  self.health = self.maxhealth;
  self.friendlydamage = undefined;
  self.hasSpawned = true;
  self.spawnTime = getTime();
  self.afk = false;
  if(self.pers["lives"] && (!isDefined(level.takeLivesOnDeath) || (level.takeLivesOnDeath == false))) {
    self.pers["lives"]--;
    if(self.pers["lives"] == 0) {
      level notify("player_eliminated");
      self notify("player_eliminated");
    }
  }
  self.lastStand = undefined;
  self.revivingTeammate = false;
  self.burning = undefined;
  self.disabledWeapon = 0;
  self resetUsability();
  self.diedOnVehicle = undefined;
  if(!self.wasAliveAtMatchStart) {
    if(level.inGracePeriod || maps\mp\gametypes\_globallogic_utils::getTimePassed() < 20 * 1000) {
      self.wasAliveAtMatchStart = true;
    }
  }
  self setDepthOfField(0, 0, 512, 512, 4, 0);
  if(level.console) {
    self setClientDvar("cg_fov", "65");
  } {
    pixbeginevent("onSpawnPlayer");
    if(isDefined(level.onSpawnPlayerUnified) &&
      GetDvarInt(#"scr_disableunifiedspawning") == 0) {
      self[[level.onSpawnPlayerUnified]]();
    } else {
      self[[level.onSpawnPlayer]]();
    }
    if(isDefined(level.playerSpawnedCB)) {
      self[[level.playerSpawnedCB]]();
    }
    pixendevent();
  }
  self maps\mp\gametypes\_missions::playerSpawned();
  pixendevent("END: spawnPlayer_preUTS");
  level thread maps\mp\gametypes\_globallogic::updateTeamStatus();
  pixbeginevent("spawnPlayer_postUTS");
  self thread stopPoisoningAndFlareOnspawn();
  self StopBurning();
  assert(maps\mp\gametypes\_globallogic_utils::isValidClass(self.class));
  self maps\mp\gametypes\_class::setClass(self.class);
  self maps\mp\gametypes\_class::giveLoadout(self.team, self.class);
  if(level.inPrematchPeriod) {
    self freeze_player_controls(true);
    self setClientDvar("scr_objectiveText", maps\mp\gametypes\_globallogic_ui::getObjectiveHintText(self.pers["team"]));
    team = self.pers["team"];
    if(isDefined(self.pers["music"].spawn) && self.pers["music"].spawn == false) {
      if(level.wagerMatch) {
        music = "SPAWN_WAGER";
      } else {
        music = game["music"]["spawn_" + team];
      }
      self thread maps\mp\gametypes\_globallogic_audio::set_music_on_player(music, false, false);
      self.pers["music"].spawn = true;
    }
    if(level.splitscreen) {
      if(isDefined(level.playedStartingMusic)) {
        music = undefined;
      } else {
        level.playedStartingMusic = true;
      }
    }
    thread maps\mp\gametypes\_hud_message::oldNotifyMessage(game["strings"][team + "_name"], undefined, game["icons"][team], game["colors"][team]);
    if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
      if(!isDefined(level.inFinalFight) || !level.inFinalFight) {
        if(level.hardcoreMode) {
          self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("gametype_hardcore");
        } else {
          self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("gametype");
        }
      }
    }
    thread maps\mp\gametypes\_hud::showClientScoreBar(5.0);
  } else {
    self freeze_player_controls(false);
    self enableWeapons();
    if(!hadSpawned && game["state"] == "playing") {
      pixbeginevent("sound");
      team = self.team;
      if(isDefined(self.pers["music"].spawn) && self.pers["music"].spawn == false) {
        self thread maps\mp\gametypes\_globallogic_audio::set_music_on_player("SPAWN_SHORT", false, false);
        self.pers["music"].spawn = true;
      }
      if(level.splitscreen) {
        if(isDefined(level.playedStartingMusic)) {
          music = undefined;
        } else {
          level.playedStartingMusic = true;
        }
      }
      thread maps\mp\gametypes\_hud_message::oldNotifyMessage(game["strings"][team + "_name"], undefined, game["icons"][team], game["colors"][team]);
      if(isDefined(game["dialog"]["gametype"]) && (!level.splitscreen || self == level.players[0])) {
        if(!isDefined(level.inFinalFight) || !level.inFinalFight) {
          if(level.hardcoreMode) {
            self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("gametype_hardcore");
          } else {
            self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("gametype");
          }
          if(team == game["attackers"]) {
            self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("offense_obj", "introboost");
          } else {
            self maps\mp\gametypes\_globallogic_audio::leaderDialogOnPlayer("defense_obj", "introboost");
          }
        }
      }
      self setClientDvar("scr_objectiveText", maps\mp\gametypes\_globallogic_ui::getObjectiveHintText(self.pers["team"]));
      thread maps\mp\gametypes\_hud::showClientScoreBar(5.0);
      pixendevent("sound");
    }
  }
  if(GetDvar(#"scr_showperksonspawn") == "") {
    setdvar("scr_showperksonspawn", "1");
  }
  if(level.hardcoreMode) {
    setdvar("scr_showperksonspawn", "0");
  }
  if(!level.splitscreen && GetDvarInt(#"scr_showperksonspawn") == 1 && game["state"] != "postgame") {
    pixbeginevent("showperksonspawn");
    if(GetDvarInt(#"scr_game_perks") == 1) {
      perks = maps\mp\gametypes\_globallogic::getPerks(self);
      self maps\mp\gametypes\_hud_util::showPerk(0, perks[0], 10);
      self maps\mp\gametypes\_hud_util::showPerk(1, perks[1], 10);
      self maps\mp\gametypes\_hud_util::showPerk(2, perks[2], 10);
      self maps\mp\gametypes\_hud_util::showPerk(3, perks[3], 10);
    }
    self thread maps\mp\gametypes\_globallogic_ui::hideLoadoutAfterTime(3.0);
    self thread maps\mp\gametypes\_globallogic_ui::hideLoadoutOnDeath();
    pixendevent("showperksonspawn");
  }
  pixendevent("END: spawnPlayer_postUTS");
  waittillframeend;
  self notify("spawned_player");
  self maps\mp\gametypes\_gametype_variants::onPlayerspawn();
  self logstring("S " + self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  setdvar("scr_selecting_location", "");
  self thread maps\mp\gametypes\_hardpoints::killstreakWaiter();
  self thread maps\mp\_mortar::mortarWaiter();
  self thread maps\mp\_vehicles::vehicleDeathWaiter();
  self thread maps\mp\_vehicles::turretDeathWaiter();
  if(game["state"] == "postgame") {
    assert(!level.intermission);
    self maps\mp\gametypes\_globallogic_player::freezePlayerForRoundEnd();
  }
}
spawnSpectator(origin, angles) {
  self notify("spawned");
  self notify("end_respawn");
  in_spawnSpectator(origin, angles);
}
respawn_asSpectator(origin, angles) {
  in_spawnSpectator(origin, angles);
}
in_spawnSpectator(origin, angles) {
  pixmarker("BEGIN: in_spawnSpectator");
  self setSpawnVariables();
  if(self.pers["team"] == "spectator") {
    self clearLowerMessage();
  }
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  if(self.pers["team"] == "spectator") {
    self.statusicon = "";
  } else {
    self.statusicon = "hud_status_dead";
  }
  maps\mp\gametypes\_spectating::setSpectatePermissionsForMachine();
  [[level.onSpawnSpectator]](origin, angles);
  if(level.teamBased && !level.splitscreen) {
    self thread spectatorThirdPersonness();
  }
  level thread maps\mp\gametypes\_globallogic::updateTeamStatus();
  pixmarker("END: in_spawnSpectator");
}
spectatorThirdPersonness() {
  self endon("disconnect");
  self endon("spawned");
  self notify("spectator_thirdperson_thread");
  self endon("spectator_thirdperson_thread");
  self.spectatingThirdPerson = false;
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
  if(!maps\mp\gametypes\_globallogic_utils::isValidClass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";
    self.class = self.pers["class"];
  }
  self maps\mp\gametypes\_globallogic_ui::closeMenus();
  self thread[[level.spawnClient]]();
}
kickIfDontspawn() {
  if(self IsHost()) {
    return;
  }
  self kickIfIDontSpawnInternal();
}
kickIfIDontSpawnInternal() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  waittime = 90;
  if(GetDvar(#"scr_kick_time") != "") {
    waittime = GetDvarFloat(#"scr_kick_time");
  }
  mintime = 45;
  if(GetDvar(#"scr_kick_mintime") != "") {
    mintime = GetDvarFloat(#"scr_kick_mintime");
  }
  starttime = gettime();
  kickWait(waittime);
  timePassed = (gettime() - starttime) / 1000;
  if(timePassed < waittime - .1 && timePassed < mintime) {
    return;
  }
  if(self.hasSpawned) {
    return;
  }
  if(GetDvarInt(#"xblive_basictraining")) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  kick(self getEntityNumber());
}
kickWait(waittime) {
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(waittime);
}
spawnInterRoundIntermission() {
  if(self isdemoclient()) {
    return;
  }
  self notify("spawned");
  self notify("end_respawn");
  self setSpawnVariables();
  self clearLowerMessage();
  self freeze_player_controls(false);
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  self maps\mp\gametypes\_globallogic_defaults::default_onSpawnIntermission();
  self SetOrigin(self.origin);
  self SetPlayerAngles(self.angles);
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}
spawnIntermission(useDefaultCallback) {
  if(self isdemoclient()) {
    return;
  }
  self notify("spawned");
  self notify("end_respawn");
  self setSpawnVariables();
  self clearLowerMessage();
  self freeze_player_controls(false);
  if(level.rankedmatch && wasLastRound()) {
    self maps\mp\_popups::displayEndGamePopUps();
    if((self.postGameMilestones || self.postGameContracts || self.postGamePromotion)) {
      if(self.postGamePromotion) {
        self playLocalSound("mus_level_up");
      } else if(self.postGameContracts) {
        self playLocalSound("mus_challenge_complete");
      } else if(self.postGameMilestones) {
        self playLocalSound("mus_contract_complete");
      }
      self clearPopups();
      self closeInGameMenu();
      self openMenu(game["menu_endgameupdate"]);
      waitTime = 4.0;
      while(waitTime) {
        wait(0.25);
        waitTime -= 0.25;
        self openMenu(game["menu_endgameupdate"]);
      }
      self closeMenu(game["menu_endgameupdate"]);
    }
  }
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  if(isDefined(useDefaultCallback) && useDefaultCallback) {
    maps\mp\gametypes\_globallogic_defaults::default_onSpawnIntermission();
  } else {
    [[level.onSpawnIntermission]]();
  }
  self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
}
spawnClient(timeAlreadyPassed) {
  pixbeginevent("spawnClient");
  assert(isDefined(self.team));
  assert(maps\mp\gametypes\_globallogic_utils::isValidClass(self.class));
  if(!self mayspawn()) {
    currentorigin = self.origin;
    currentangles = self.angles;
    shouldShowRespawnMessage = true;
    if(wasLastRound() || isOneRound() || (isDefined(level.livesDoNotReset) && level.livesDoNotReset)) {
      shouldShowRespawnMessage = false;
    }
    if(level.scoreLimit > 1 && level.teambased && game["teamScores"]["allies"] >= level.scoreLimit - 1 && game["teamScores"]["axis"] >= level.scoreLimit - 1) {
      shouldShowRespawnMessage = false;
    }
    if(shouldShowRespawnMessage) {
      setLowerMessage(game["strings"]["spawn_next_round"]);
      self thread maps\mp\gametypes\_globallogic_ui::removeSpawnMessageShortly(3);
    }
    self thread[[level.spawnSpectator]](currentorigin + (0, 0, 60), currentangles);
    pixendevent();
    return;
  }
  if(self.waitingToSpawn) {
    pixendevent();
    return;
  }
  self.waitingToSpawn = true;
  self waitAndSpawnClient(timeAlreadyPassed);
  if(isDefined(self)) {
    self.waitingToSpawn = false;
  }
  pixendevent();
}
waitAndSpawnClient(timeAlreadyPassed) {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  if(!isDefined(timeAlreadyPassed)) {
    timeAlreadyPassed = 0;
  }
  spawnedAsSpectator = false;
  if(self.teamKillPunish) {
    teamKillDelay = maps\mp\gametypes\_globallogic_player::TeamKillDelay();
    if(teamKillDelay > timeAlreadyPassed) {
      teamKillDelay -= timeAlreadyPassed;
      timeAlreadyPassed = 0;
    } else {
      timeAlreadyPassed -= teamKillDelay;
      teamKillDelay = 0;
    }
    if(teamKillDelay > 0) {
      setLowerMessage(&"MP_FRIENDLY_FIRE_WILL_NOT", teamKillDelay);
      self thread respawn_asSpectator(self.origin + (0, 0, 60), self.angles);
      spawnedAsSpectator = true;
      wait(teamKillDelay);
    }
    self.teamKillPunish = false;
  }
  if(!isDefined(self.waveSpawnIndex) && isDefined(level.wavePlayerSpawnIndex[self.team])) {
    self.waveSpawnIndex = level.wavePlayerSpawnIndex[self.team];
    level.wavePlayerSpawnIndex[self.team]++;
  }
  timeUntilSpawn = TimeUntilspawn(false);
  if(timeUntilSpawn > timeAlreadyPassed) {
    timeUntilSpawn -= timeAlreadyPassed;
    timeAlreadyPassed = 0;
  } else {
    timeAlreadyPassed -= timeUntilSpawn;
    timeUntilSpawn = 0;
  }
  if(timeUntilSpawn > 0) {
    if(self IsSplitscreen()) {
      setLowerMessage(game["strings"]["waiting_to_spawn_ss"], timeUntilSpawn, true);
    } else {
      setLowerMessage(game["strings"]["waiting_to_spawn"], timeUntilSpawn);
    }
    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(self.origin + (0, 0, 60), self.angles);
    }
    spawnedAsSpectator = true;
    self maps\mp\gametypes\_globallogic_utils::waitForTimeOrNotify(timeUntilSpawn, "force_spawn");
    self notify("stop_wait_safe_spawn_button");
  }
  waveBased = (GetDvarInt("scr_" + level.gameType + "_waverespawndelay") > 0);
  if(maps\mp\gametypes\_tweakables::getTweakableValue("player", "forcerespawn") == 0 && self.hasSpawned && !waveBased && !self.wantSafeSpawn) {
    setLowerMessage(game["strings"]["press_to_spawn"]);
    if(!spawnedAsSpectator) {
      self thread respawn_asSpectator(self.origin + (0, 0, 60), self.angles);
    }
    spawnedAsSpectator = true;
    self waitRespawnOrSafeSpawnButton();
  }
  self.waitingToSpawn = false;
  self clearLowerMessage();
  self.waveSpawnIndex = undefined;
  self thread[[level.spawnPlayer]]();
}
waitRespawnOrSafeSpawnButton() {
  self endon("disconnect");
  self endon("end_respawn");
  while(1) {
    if(self useButtonPressed()) {
      break;
    }
    wait .05;
  }
}
setThirdPerson(value) {
  if(!level.console) {
    return;
  }
  if(!isDefined(self.spectatingThirdPerson) || value != self.spectatingThirdPerson) {
    self.spectatingThirdPerson = value;
    if(value) {
      self setClientDvar("cg_thirdPerson", "1");
      self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
      self setClientDvar("cg_fov", "40");
    } else {
      self setClientDvar("cg_thirdPerson", "0");
      self setDepthOfField(0, 0, 512, 4000, 4, 0);
      self setClientDvar("cg_fov", "65");
    }
  }
}
setSpawnVariables() {
  resetTimeout();
  self StopShellshock();
  self StopRumble("damage_heavy");
}
sndStartMusicSystem() {
  self endon("disconnect");
  if(game["state"] == "postgame") {
    return;
  }
  if(game["state"] == "pregame") {
    if(getdvarint(#"debug_music") > 0) {
      println("Music System - music state is undefined Waiting 15 seconds to set music state");
    }
    wait 20;
    if(!isDefined(level.nextMusicState)) {
      self.pers["music"].currentState = "UNDERSCORE";
      self thread maps\mp\gametypes\_globallogic_audio::set_music_on_player("UNDERSCORE", true);
    }
  }
  if(!isDefined(level.nextMusicState)) {
    if(getdvarint(#"debug_music") > 0) {
      println("Music System - music state is undefined Waiting 15 seconds to set music state");
    }
    wait 15;
    self.pers["music"].currentState = "UNDERSCORE";
    self thread maps\mp\gametypes\_globallogic_audio::set_music_on_player("UNDERSCORE", true);
  }
}