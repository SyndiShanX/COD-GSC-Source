/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\infect.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_class;

CONST_FIRST_INFECTED_TIMER = 15;
CONST_INFECTED_MOVE_SCALAR = 1.2;
CONST_PLAYER_START_LETHAL = "explosive_drone_mp";
CONST_PLAYER_START_TACTICAL = "exoshield_equipment_mp";
CONST_INFECTED_LETHAL = "exoknife_mp";
CONST_INFECTED_TACTICAL = "s1_tactical_insertion_device_mp";

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerTimeLimitDvar(level.gameType, 10);
    setOverrideWatchDvar("scorelimit", 0);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_numInitialInfected = 1;
    level.matchRules_damageMultiplier = 0;
  }

  SetDynamicDvar("scr_game_high_jump", 1);
  SetDynamicDvar("jump_slowdownEnable", 0);

  setSpecialLoadouts();

  level.teamBased = true;
  level.doPrematch = true;
  level.disableForfeit = true;
  level.noBuddySpawns = true;
  level.onStartGameType = ::onStartGameType;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onPlayerKilled = ::onPlayerKilled;
  level.onDeadEvent = ::onDeadEvent;
  level.onTimeLimit = ::onTimeLimit;
  level.autoassign = ::infectAutoAssign;
  level.bypassClassChoiceFunc = ::infectedClass;

  if(level.matchRules_damageMultiplier) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  game["dialog"]["gametype"] = "inf_intro";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "inf_survive";
  game["dialog"]["defense_obj"] = "inf_survive";
  game["dialog"]["first_infected"] = "inf_patientzero";
  game["dialog"]["time_extended"] = "inf_extratime";
  game["dialog"]["lone_survivor"] = "inf_lonesurvivor";
  game["dialog"]["been_infected"] = "inf_been_infected";
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  level.matchRules_numInitialInfected = GetMatchRulesData("infectData", "numInitialInfected");

  SetDynamicDvar("scr_" + level.gameType + "_numLives", 0);
  registerNumLivesDvar(level.gameType, 0);

  setOverrideWatchDvar("scorelimit", 0);
  SetDynamicDvar("scr_infect_roundswitch", 0);
  registerRoundSwitchDvar("infect", 0, 0, 9);
  SetDynamicDvar("scr_infect_roundlimit", 1);
  registerRoundLimitDvar("infect", 1);
  SetDynamicDvar("scr_infect_winlimit", 1);
  registerWinLimitDvar("infect", 1);
  SetDynamicDvar("scr_infect_halftime", 0);
  registerHalfTimeDvar("infect", 0);

  SetDynamicDvar("scr_infect_playerrespawndelay", 0);
  SetDynamicDvar("scr_infect_waverespawndelay", 0);
  SetDynamicDvar("scr_player_forcerespawn", 1);
  SetDynamicDvar("scr_team_fftype", 0);
  SetDynamicDvar("scr_game_hardpoints", 0);
}

onStartGameType() {
  setClientNameMode("auto_change");

  setObjectiveText("allies", &"OBJECTIVES_INFECT");
  setObjectiveText("axis", &"OBJECTIVES_INFECT");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", &"OBJECTIVES_INFECT");
    setObjectiveScoreText("axis", &"OBJECTIVES_INFECT");
  } else {
    setObjectiveScoreText("allies", &"OBJECTIVES_INFECT_SCORE");
    setObjectiveScoreText("axis", &"OBJECTIVES_INFECT_SCORE");
  }
  setObjectiveHintText("allies", &"OBJECTIVES_INFECT_HINT");
  setObjectiveHintText("axis", &"OBJECTIVES_INFECT_HINT");

  initSpawns();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);

  level.QuickMessageToAll = true;
  level.blockWeaponDrops = true;
  level.infect_allowSuicide = false;

  level.infect_choseFirstInfected = false;
  level.infect_choosingFirstInfected = false;
  level.infect_countdownInProgress = false;

  level.infect_teamScores["axis"] = 0;
  level.infect_teamScores["allies"] = 0;
  level.infect_players = [];

  level thread onPlayerConnect();
  level thread gameTimer();
}

gameTimer() {
  level endon("game_ended");

  SetDynamicDvar("scr_infect_timelimit", 0);
  playTimeVO = false;

  while(true) {
    level waittill("update_game_time", newGameTime);

    if(!isDefined(newGameTime)) {
      newGameTime = ((getTimePassed() + 1500) / (60 * 1000)) + 2;
    }

    SetDynamicDvar("scr_infect_timelimit", newGameTime);
    level thread watchHostMigration(newGameTime);

    if(playTimeVO) {
      level thread leaderDialogBothTeams("time_extended", "axis", "time_extended", "allies", "status");
    }

    playTimeVO = true;
  }
}

watchHostMigration(newGameTime) {
  level notify("watchHostMigration");
  level endon("watchHostMigration");

  level endon("game_ended");

  level waittill("host_migration_begin");
  SetDynamicDvar("scr_infect_timelimit", 0);

  waittillframeend;

  SetDynamicDvar("scr_infect_timelimit", 0);
  level waittill("host_migration_end");
  level notify("update_game_time", newGameTime);
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    player.infectedRejoined = false;
    player.killsAsInfected = 0;

    if(gameFlag("prematch_done")) {
      if(isDefined(level.infect_choseFirstInfected) && level.infect_choseFirstInfected) {
        player.survivalStartTime = GetTime();
      }
    }

    if(isDefined(level.infect_players[player.name])) {
      player.infectedRejoined = true;
    }

    player thread monitorSurvivalTime();
  }
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_tdm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

infectAutoAssign() {
  teamChoice = "allies";

  if(self.infectedRejoined) {
    teamChoice = "axis";
  }

  self thread maps\mp\gametypes\_menus::setTeam(teamChoice);
}

getSpawnPoint() {
  if(level.inGracePeriod) {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_tdm_spawn");
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
  } else {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_NearTeam(spawnPoints);
  }

  self maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(spawnpoint);

  return spawnPoint;
}

infectedClass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastClass = self.pers["lastClass"];

  self preLoadWeapons();
}

preLoadWeapons() {
  weapons = [];
  foreach(loadout in level.infect_loadouts) {
    if(isDefined(loadout["loadoutPrimary"]) && (loadout["loadoutPrimary"] != "iw5_combatknife") && (loadout["loadoutPrimary"] != "none")) {
      weapons[weapons.size] = loadout["loadoutPrimary"];
    }

    if(isDefined(loadout["loadoutSecondary"]) && (loadout["loadoutSecondary"] != "iw5_combatknife") && (loadout["loadoutSecondary"] != "none")) {
      weapons[weapons.size] = loadout["loadoutSecondary"];
    }
  }

  if(weapons.size > 0) {
    self LoadWeapons(weapons);
  }
}

onSpawnPlayer() {
  if(isDefined(self.teamChangedThisFrame)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
    self maps\mp\gametypes\_class::giveLoadout(self.team, self.class);

    self thread monitorDisconnect();
  }

  self.teamChangedThisFrame = undefined;

  self preLoadWeapons();

  updateTeamScores();

  if(!level.infect_choosingFirstInfected) {
    level.infect_choosingFirstInfected = true;
    level thread chooseFirstInfected();
  }

  if(self.infectedRejoined) {
    if(!level.infect_allowSuicide) {
      level notify("infect_stopCountdown");
      level.infect_choseFirstInfected = true;
      level.infect_allowSuicide = true;
      foreach(player in level.players) {
        if(isDefined(player.infect_isBeingChosen)) {
          player.infect_isBeingChosen = undefined;
        }
      }
    }

    foreach(player in level.players) {
      if(isDefined(player.isInitialInfected)) {
        player thread setInitialToNormalInfected();
      }
    }

    if(level.infect_teamScores["axis"] == 1) {
      self.isInitialInfected = true;
    }

    self clearSurvivalTime();
  }

  if(isDefined(self.isInitialInfected)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
    self maps\mp\gametypes\_class::giveLoadout(self.team, self.class);
  }

  self thread onSpawnFinished();

  level notify("spawned_player");
}

onSpawnFinished() {
  self endon("death");
  self endon("disconnect");

  self waittill("applyLoadout");

  updateLoadouts();
}

updateLoadouts() {
  if(self.pers["team"] == "allies") {
    self givePerk("specialty_extended_battery", false);
  }

  if(self.pers["team"] == "axis") {
    self thread setInfectedMsg();
    self thread setInfectedModels();

    self setMoveSpeedScale(CONST_INFECTED_MOVE_SCALAR);
  }
}

setInfectedModels() {
  self DetachAll();

  self setModel("kva_hazmat_body_infected_mp");
  self Attach("kva_hazmat_head_infected");
  self SetViewmodel("vm_kva_hazmat_infected");
  self SetClothType("cloth");
}

setInfectedMsg() {
  if(!isDefined(self.shownInfected) || !self.shownInfected) {
    self thread maps\mp\_events::gotInfectedEvent();
    self PlaySoundToPlayer("mp_inf_got_infected", self);
    self leaderDialogOnPlayer("been_infected", "status");
    self.shownInfected = true;
  }
}

chooseFirstInfected() {
  level endon("game_ended");
  level endon("infect_stopCountdown");

  level.infect_allowSuicide = false;
  gameFlagWait("prematch_done");

  level.infect_countdownInProgress = true;

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(1.0);

  countTime = CONST_FIRST_INFECTED_TIMER;

  SetOmnvar("ui_match_countdown_title", 7);
  SetOmnvar("ui_match_countdown_toggle", 1);
  while(countTime > 0 && !level.gameEnded) {
    countTime--;
    SetOmnvar("ui_match_countdown", countTime + 1);
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(1.0);
  }
  SetOmnvar("ui_match_countdown", 1);
  SetOmnvar("ui_match_countdown_title", 0);
  SetOmnvar("ui_match_countdown_toggle", 0);

  level.infect_countdownInProgress = false;

  possibleInfected = [];

  ignoredHostPlayer = undefined;
  foreach(player in level.players) {
    if(matchMakingGame() && (level.players.size > 1) && (player IsHost())) {
      ignoredHostPlayer = player;
      continue;
    }

    if(player.team == "spectator") {
      continue;
    }

    if(!player.hasSpawned) {
      continue;
    }

    possibleInfected[possibleInfected.size] = player;
  }

  if(!possibleInfected.size && isDefined(ignoredHostPlayer)) {
    possibleInfected[possibleInfected.size] = ignoredHostPlayer;
  }

  firstInfectedPlayer = possibleInfected[randomInt(possibleInfected.size)];
  firstInfectedPlayer setFirstInfected(true);

  foreach(player in level.players) {
    if(player == firstInfectedPlayer) {
      continue;
    }

    player.survivalStartTime = GetTime();
  }
}

prepareForClassChange() {
  while(!isReallyAlive(self) || self isUsingRemote()) {
    wait(0.05);
  }

  if(isDefined(self.isCarrying) && (self.isCarrying == true)) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self IsMeleeing()) {
    wait(0.05);
  }

  while(self IsMantling()) {
    wait(0.05);
  }

  while(!self isOnGround() && !self IsOnLadder()) {
    wait(0.05);
  }

  if(self isJuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self maps\mp\_exo_ping::stop_exo_ping();
  self maps\mp\_extrahealth::StopExtraHealth();
  self maps\mp\_adrenaline::StopAdrenaline();
  self maps\mp\_exo_cloak::active_cloaking_disable();
  self maps\mp\_exo_mute::stop_exo_mute();
  self maps\mp\_exo_repulsor::stop_repulsor();

  wait(0.05);

  while(!isReallyAlive(self)) {
    wait(0.05);
  }
}

setFirstInfected(wasChosen) {
  self endon("disconnect");

  self prepareForClassChange();

  if(wasChosen) {
    self.infect_isBeingChosen = true;
    self maps\mp\gametypes\_menus::addToTeam("axis", undefined, true);
    self thread monitorDisconnect();
    level.infect_choseFirstInfected = true;
    self.infect_isBeingChosen = undefined;

    level notify("update_game_time");
    updateTeamScores();

    level.infect_allowSuicide = true;

    level.infect_players[self.name] = true;
  }

  self.isInitialInfected = true;
  self.shownInfected = true;

  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  self giveAndApplyLoadout(self.team, "gamemode");
  self updateLoadouts();

  self thread maps\mp\_events::firstInfectedEvent();
  self PlaySoundToPlayer("mp_inf_got_infected", self);
  self leaderDialogOnPlayer("first_infected", "status");

  self clearSurvivalTime();
  self refillBattery();
}

setInitialToNormalInfected() {
  level endon("game_ended");

  self.isInitialInfected = undefined;
  self prepareForClassChange();

  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  self thread onSpawnFinished();
  self giveAndApplyLoadout(self.team, "gamemode");
  self refillBattery();
}

refillBattery() {
  offhandWeapons = self getWeaponsListOffhands();

  foreach(offhand in offhandWeapons) {
    self BatteryFullRecharge(offhand);
  }
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, lifeId) {
  if(!isDefined(attacker)) {
    return;
  }

  if((self.team == "axis") && isPlayer(attacker) && (attacker.team == "allies") && isMeleeMOD(sMeansOfDeath)) {
    attacker maps\mp\gametypes\_missions::processChallenge("ch_infect_tooclose");
  }

  if(self.team == "axis") {
    return;
  }

  wasSuicide = (attacker == self) || !isPlayer(attacker);

  if(wasSuicide && !level.infect_allowSuicide) {
    return;
  }

  level notify("update_game_time");

  self notify("delete_explosive_drones");

  self.teamChangedThisFrame = true;
  self maps\mp\gametypes\_menus::addToTeam("axis");
  self setSurvivalTime(true);

  updateTeamScores();
  playSoundOnPlayers("mp_enemy_obj_captured", "allies");
  playSoundOnPlayers("mp_war_objective_taken", "axis");

  level.infect_players[self.name] = true;
  level thread teamPlayerCardSplash("callout_got_infected", self, "allies");

  if(!wasSuicide) {
    attacker thread maps\mp\_events::infectedSurvivorEvent();
    attacker PlaySoundToPlayer("mp_inf_infection_kill", attacker);
    attacker.killsAsInfected++;

    if(attacker.killsAsInfected == 3) {
      attacker thread maps\mp\_events::plagueEvent();
      attacker.killsAsInfected = 0;
    }
  }

  if(level.infect_teamScores["axis"] == 2) {
    foreach(player in level.players) {
      if(isDefined(player.isInitialInfected)) {
        player thread setInitialToNormalInfected();
      }
    }
  }

  if(level.infect_teamScores["allies"] == 0) {
    onSurvivorsEliminated();
    return;
  }

  if(level.infect_teamScores["allies"] == 1) {
    onFinalSurvivor();
    return;
  }
}

onFinalSurvivor() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.team != "allies") {
      continue;
    }

    if(isDefined(player.awardedFinalSurvivor)) {
      continue;
    }

    player.awardedFinalSurvivor = true;
    player thread maps\mp\_events::finalSurvivorEvent();
    player thread leaderDialogOnPlayer("lone_survivor", "status");
    level thread finalSurvivorUAV(player);

    break;
  }
}

finalSurvivorUAV(finalPlayer) {
  level endon("game_ended");
  finalPlayer endon("disconnect");
  finalPlayer endon("eliminated");
  level endon("infect_lateJoiner");
  level thread endUAVonLateJoiner(finalPlayer);

  removeUAV = false;
  level.radarMode["axis"] = "normal_radar";
  foreach(player in level.players) {
    if(player.team == "axis") {
      player.radarMode = "normal_radar";
    }
  }
  setTeamRadarStrength("axis", 1);

  while(true) {
    prevPos = finalPlayer.origin;

    wait(4);
    if(removeUAV) {
      setTeamRadar("axis", 0);
      removeUAV = false;
    }

    wait(6);
    if(distance(prevPos, finalPlayer.origin) < 200) {
      setTeamRadar("axis", 1);
      removeUAV = true;

      foreach(player in level.players) {
        player playLocalSound("recondrone_tag");
      }
    }
  }
}

endUAVonLateJoiner(finalPlayer) {
  level endon("game_ended");
  finalPlayer endon("disconnect");
  finalPlayer endon("eliminated");

  while(true) {
    if(level.infect_teamScores["allies"] > 1) {
      level notify("infect_lateJoiner");
      wait(0.05);
      setTeamRadar("axis", 0);
      break;
    }
    wait(0.05);
  }
}

monitorDisconnect() {
  level endon("game_ended");
  self endon("eliminated");

  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");

  team = self.team;
  if(!isDefined(team) && isDefined(self.bot_team)) {
    team = self.bot_team;
  }

  self waittill("disconnect");

  updateTeamScores();

  if(isDefined(self.infect_isBeingChosen) || level.infect_choseFirstInfected) {
    if(level.infect_teamScores["axis"] && level.infect_teamScores["allies"]) {
      if(team == "allies" && level.infect_teamScores["allies"] == 1) {
        onFinalSurvivor();
      } else if(team == "axis" && level.infect_teamScores["axis"] == 1) {
        foreach(player in level.players) {
          if(player != self && player.team == "axis") {
            player setFirstInfected(false);
          }
        }
      }
    } else if(level.infect_teamScores["allies"] == 0) {
      onSurvivorsEliminated();
    } else if(level.infect_teamScores["axis"] == 0) {
      if(level.infect_teamScores["allies"] == 1) {
        level.finalKillCam_winner = "allies";
        level thread maps\mp\gametypes\_gamelogic::endGame("allies", game["end_reason"]["infected_eliminated"]);
      } else if(level.infect_teamScores["allies"] > 1) {
        level.infect_choseFirstInfected = false;
        level thread chooseFirstInfected();
      }
    }
  } else if(level.infect_countdownInProgress && level.infect_teamScores["allies"] == 0 && level.infect_teamScores["axis"] == 0) {
    level notify("infect_stopCountdown");
    level.infect_choosingFirstInfected = false;
    SetOmnvar("ui_match_start_countdown", 0);
  }

  self.isInitialInfected = undefined;
}

onDeadEvent(team) {
  return;
}

onTimeLimit() {
  level.finalKillCam_winner = "allies";
  level thread maps\mp\gametypes\_gamelogic::endGame("allies", game["end_reason"]["time_limit_reached"]);
}

onSurvivorsEliminated() {
  level.finalKillCam_winner = "axis";
  level thread maps\mp\gametypes\_gamelogic::endGame("axis", game["end_reason"]["survivors_eliminated"]);
}

getTeamSize(team) {
  size = 0;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator" && !player.spectatekillcam) {
      continue;
    }

    if(player.team == team) {
      size++;
    }
  }

  return size;
}

updateTeamScores() {
  level.infect_teamScores["allies"] = getTeamSize("allies");
  game["teamScores"]["allies"] = level.infect_teamScores["allies"];
  setTeamScore("allies", level.infect_teamScores["allies"]);

  level.infect_teamScores["axis"] = getTeamSize("axis");
  game["teamScores"]["axis"] = level.infect_teamScores["axis"];
  setTeamScore("axis", level.infect_teamScores["axis"]);
}

setSpecialLoadouts() {
  if(isUsingMatchRulesData() && GetMatchRulesData("defaultClasses", "allies", 0, "class", "inUse")) {
    level.infect_loadouts["allies"] = getMatchRulesSpecialClass("allies", 0);
  } else {
    level.infect_loadouts["allies"] = getEmptyLoadout();

    level.infect_loadouts["allies"]["loadoutPrimary"] = "iw5_maul";;
    level.infect_loadouts["allies"]["loadoutPerks"][4] = "specialty_class_scavenger";
    level.infect_loadouts["allies"]["loadoutEquipment"] = CONST_PLAYER_START_LETHAL;
    level.infect_loadouts["allies"]["loadoutEquipmentExtra"] = true;
    level.infect_loadouts["allies"]["loadoutOffhand"] = CONST_PLAYER_START_TACTICAL;
  }

  if(isUsingMatchRulesData() && GetMatchRulesData("defaultClasses", "axis", 1, "class", "inUse")) {
    level.infect_loadouts["axis_initial"] = getMatchRulesSpecialClass("axis", 1);
  } else {
    level.infect_loadouts["axis_initial"] = getEmptyLoadout();

    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = "iw5_rw1";
    level.infect_loadouts["axis_initial"]["loadoutEquipment"] = CONST_INFECTED_LETHAL;
    level.infect_loadouts["axis_initial"]["loadoutOffhand"] = CONST_INFECTED_TACTICAL;
    level.infect_loadouts["axis_initial"]["loadoutWildcards"] = "specialty_wildcard_duallethals";
  }

  if(isUsingMatchRulesData() && GetMatchRulesData("defaultClasses", "axis", 0, "class", "inUse")) {
    level.infect_loadouts["axis"] = getMatchRulesSpecialClass("axis", 0);
  } else {
    level.infect_loadouts["axis"] = getEmptyLoadout();

    level.infect_loadouts["axis"]["loadoutPrimary"] = "iw5_combatknife";
    level.infect_loadouts["axis"]["loadoutEquipment"] = CONST_INFECTED_LETHAL;
    level.infect_loadouts["axis"]["loadoutOffhand"] = CONST_INFECTED_TACTICAL;
    level.infect_loadouts["axis"]["loadoutWildcards"] = "specialty_wildcard_duallethals";
  }
}

monitorSurvivalTime() {
  self endon("death");
  self endon("disconnect");
  self endon("infected");
  level endon("game_ended");

  survivorCount = 0;

  while(true) {
    if(!level.infect_choseFirstInfected || !isDefined(self.survivalStartTime) || !isAlive(self)) {
      wait(0.05);
      continue;
    }

    self setSurvivalTime(false);
    survivorCount++;
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(1.0);

    if(survivorCount == 30) {
      self thread maps\mp\_events::survivorEvent();
      survivorCount = 0;
    }
  }
}

clearSurvivalTime() {
  self setExtraScore0(0);
  self notify("infected");
  self setExtraScore1(1);
}

setSurvivalTime(infected) {
  if(!isDefined(self.survivalStartTime)) {
    self.survivalStartTime = self.spawnTime;
  }

  timeSurvived = int((GetTime() - self.survivalStartTime) / 1000);

  if(timeSurvived > 999) {
    timeSurvived = 999;
  }

  self setExtraScore0(timeSurvived);

  if(isDefined(infected) && infected) {
    self notify("infected");
    self setExtraScore1(1);
  }
}