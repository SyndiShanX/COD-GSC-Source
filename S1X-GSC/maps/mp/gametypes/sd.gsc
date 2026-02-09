/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\sd.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\common_sd_sr;

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 3, 0, 9);
    registerTimeLimitDvar(level.gameType, 2.5);
    registerScoreLimitDvar(level.gameType, 1);
    registerRoundLimitDvar(level.gameType, 0);
    registerWinLimitDvar(level.gameType, 4);
    registerNumLivesDvar(level.gameType, 1);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.objectiveBased = true;
  level.teamBased = true;
  level.onPrecacheGameType = ::onPrecacheGameType;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onPlayerKilled = ::onPlayerKilled;
  level.onDeadEvent = ::onDeadEvent;
  level.onOneLeftEvent = ::onOneLeftEvent;
  level.onTimeLimit = ::onTimeLimit;
  level.onNormalDeath = ::onNormalDeath;
  level.gameModeMayDropWeapon = ::isPlayerOutsideOfAnyBombSite;

  level.allowLateComers = false;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  game["dialog"]["gametype"] = "sd_intro";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "gbl_destroyobj";
  game["dialog"]["defense_obj"] = "gbl_defendobj";

  SetOmnvar("ui_bomb_timer_endtime", 0);

  SetDevDvarIfUninitialized("scr_sd_debugBombKillCamEnt", 0);
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  roundLength = GetMatchRulesData("sdData", "roundLength");
  SetDynamicDvar("scr_sd_timelimit", roundLength);
  registerTimeLimitDvar("sd", roundLength);

  roundSwitch = GetMatchRulesData("sdData", "roundSwitch");
  SetDynamicDvar("scr_sd_roundswitch", roundSwitch);
  registerRoundSwitchDvar("sd", roundSwitch, 0, 9);

  winLimit = GetMatchRulesData("commonOption", "scoreLimit");
  SetDynamicDvar("scr_sd_winlimit", winLimit);
  registerWinLimitDvar("sd", winLimit);

  SetDynamicDvar("scr_sd_bombtimer", GetMatchRulesData("sdData", "bombTimer"));
  SetDynamicDvar("scr_sd_planttime", GetMatchRulesData("sdData", "plantTime"));
  SetDynamicDvar("scr_sd_defusetime", GetMatchRulesData("sdData", "defuseTime"));
  SetDynamicDvar("scr_sd_multibomb", GetMatchRulesData("sdData", "multiBomb"));
  SetDynamicDvar("scr_sd_silentplant", GetMatchRulesData("sdData", "silentPlant"));

  SetDynamicDvar("scr_sd_roundlimit", 0);
  registerRoundLimitDvar("sd", 0);
  SetDynamicDvar("scr_sd_scorelimit", 1);
  registerScoreLimitDvar("sd", 1);
  SetDynamicDvar("scr_sd_halftime", 0);
  registerHalfTimeDvar("sd", 0);
}

onStartGameType() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = false;
  }

  if(game["switchedsides"]) {
    oldAttackers = game["attackers"];
    oldDefenders = game["defenders"];
    game["attackers"] = oldDefenders;
    game["defenders"] = oldAttackers;
  }

  setClientNameMode("manual_change");

  level._effect["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
  level._effect["bomb_light_blinking"] = loadfx("vfx/lights/light_sdbomb_blinking");
  level._effect["bomb_light_planted"] = loadfx("vfx/lights/light_beacon_sdbomb");

  setObjectiveText(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  setObjectiveText(game["defenders"], &"OBJECTIVES_SD_DEFENDER");

  if(level.splitscreen) {
    setObjectiveScoreText(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    setObjectiveScoreText(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    setObjectiveScoreText(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    setObjectiveScoreText(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }
  setObjectiveHintText(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  setObjectiveHintText(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");

  initSpawns();

  allowed[0] = "sd";
  allowed[1] = "bombzone";
  allowed[2] = "blocker";
  maps\mp\gametypes\_gameobjects::main(allowed);

  thread updateGametypeDvars();

  setSpecialLoadout();

  thread bombs();
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_sd_spawn_attacker");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_sd_spawn_defender");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  spawnPointName = "mp_sd_spawn_defender";

  if(self.pers["team"] == game["attackers"]) {
    spawnPointName = "mp_sd_spawn_attacker";
  }

  spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(spawnPointName);
  assert(spawnPoints.size);

  spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);

  self maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(spawnpoint);

  return spawnpoint;
}

onSpawnPlayer() {
  is_respawning_with_bomb_carrier_class = isDefined(self.isRespawningWithBombCarrierClass) && self.isRespawningWithBombCarrierClass;
  if(IsGameParticipant(self)) {
    self.isPlanting = false;
    self.isDefusing = false;
    if(!is_respawning_with_bomb_carrier_class) {
      self.isBombCarrier = false;
      self.objective = 0;
    }
  }

  if(isPlayer(self) && !is_respawning_with_bomb_carrier_class) {
    if(level.multiBomb && self.pers["team"] == game["attackers"]) {
      self SetClientOmnvar("ui_carrying_bomb", true);
    } else {
      self SetClientOmnvar("ui_carrying_bomb", false);
    }
  }

  self setExtraScore0(0);
  if(isDefined(self.pers["plants"])) {
    self setExtraScore0(self.pers["plants"]);
  }
  self setExtraScore1(0);
  if(isDefined(self.pers["defuses"])) {
    self setExtraScore1(self.pers["defuses"]);
  }

  self.isRespawningWithBombCarrierClass = undefined;
  level notify("spawned_player");
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  if(isPlayer(self)) {
    self SetClientOmnvar("ui_carrying_bomb", false);
  }

  thread checkAllowSpectating();
}