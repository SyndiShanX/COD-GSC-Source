/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\sr.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\common_sd_sr;
#include maps\mp\agents\_agent_utility;

CONST_FRIENDLY_TAG_MODEL = "prop_dogtags_future_friend_animated";
CONST_ENEMY_TAG_MODEL = "prop_dogtags_future_enemy_animated";

OP_HELPME_NUM_TEAMMATES = 4;

main() {
  if(getdvar("mapname") == "mp_background") {
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

  level.assists_disabled = true;
  level.objectiveBased = true;
  level.teamBased = true;
  level.noBuddySpawns = true;
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

  game["dialog"]["gametype"] = "sr_intro";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";

  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";

  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["revived"] = "sr_rev";

  SetOmnvar("ui_bomb_timer_endtime", 0);

  SetDevDvarIfUninitialized("scr_sd_debugBombKillCamEnt", 0);

  level.conf_fx["vanish"] = loadFx("fx/impacts/small_snowhit");
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  roundLength = GetMatchRulesData("srData", "roundLength");
  SetDynamicDvar("scr_sr_timelimit", roundLength);
  registerTimeLimitDvar("sr", roundLength);

  roundSwitch = GetMatchRulesData("srData", "roundSwitch");
  SetDynamicDvar("scr_sr_roundswitch", roundSwitch);
  registerRoundSwitchDvar("sr", roundSwitch, 0, 9);

  winLimit = GetMatchRulesData("commonOption", "scoreLimit");
  SetDynamicDvar("scr_sr_winlimit", winLimit);
  registerWinLimitDvar("sr", winLimit);

  SetDynamicDvar("scr_sr_bombtimer", GetMatchRulesData("srData", "bombTimer"));
  SetDynamicDvar("scr_sr_planttime", GetMatchRulesData("srData", "plantTime"));
  SetDynamicDvar("scr_sr_defusetime", GetMatchRulesData("srData", "defuseTime"));
  SetDynamicDvar("scr_sr_multibomb", GetMatchRulesData("srData", "multiBomb"));
  SetDynamicDvar("scr_sr_silentplant", GetMatchRulesData("srData", "silentPlant"));

  SetDynamicDvar("scr_sr_roundlimit", 0);
  registerRoundLimitDvar("sr", 0);
  SetDynamicDvar("scr_sr_scorelimit", 1);
  registerScoreLimitDvar("sr", 1);
  SetDynamicDvar("scr_sr_halftime", 0);
  registerHalfTimeDvar("sr", 0);
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

  updateGametypeDvars();

  level.dogtags = [];

  setSpecialLoadout();

  thread bombs();
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_sd_spawn_attacker");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_sd_spawn_defender");

  maps\mp\gametypes\_spawnlogic::addSpawnPoints("attacker", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("defender", "mp_tdm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  spawnteam = "defender";

  if(self.pers["team"] == game["attackers"]) {
    spawnteam = "attacker";
  }

  if(maps\mp\gametypes\_spawnlogic::shouldUseTeamStartspawn()) {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_sd_spawn_" + spawnteam);
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);
  } else {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_SearchAndRescue(spawnPoints);
  }

  self maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(spawnpoint);

  return spawnPoint;
}

onSpawnPlayer() {
  is_respawning_with_bomb_carrier_class = isDefined(self.isRespawningWithBombCarrierClass) && self.isRespawningWithBombCarrierClass;

  self.isPlanting = false;
  self.isDefusing = false;
  if(!is_respawning_with_bomb_carrier_class) {
    self.isBombCarrier = false;
    self.objective = 0;
  }

  if(IsPlayer(self) && !is_respawning_with_bomb_carrier_class) {
    if(level.multiBomb && self.pers["team"] == game["attackers"]) {
      self SetClientOmnvar("ui_carrying_bomb", true);
    } else {
      self SetClientOmnvar("ui_carrying_bomb", false);
    }
  }

  self.isRespawningWithBombCarrierClass = undefined;
  level notify("spawned_player");

  if(self.sessionteam == "axis" || self.sessionteam == "allies") {
    level notify("sr_player_joined", self);

    self setExtraScore0(0);
    if(isDefined(self.pers["plants"])) {
      self setExtraScore0(self.pers["plants"]);
    }
    self setExtraScore1(0);
    if(isDefined(self.pers["defuses"])) {
      self setExtraScore1(self.pers["defuses"]);
    }
    self.assists = 0;
    if(isDefined(self.pers["denied"])) {
      self.assists = (self.pers["denied"]);
    }
  }
}

shouldSpawnTags(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  if(isDefined(self.switching_teams)) {
    return false;
  }

  if(isDefined(self.wasSwitchingTeamsForOnPlayerKilled)) {
    return false;
  }

  if(isDefined(attacker) && attacker == self) {
    return false;
  }

  if(level.teamBased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
    return false;
  }

  if(
    isDefined(attacker) &&
    !isDefined(attacker.team) &&
    (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")
  )
    return false;

  return true;
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  if(IsPlayer(self)) {
    self SetClientOmnvar("ui_carrying_bomb", false);
  }

  if(!gameFlag("prematch_done")) {
    self maps\mp\gametypes\_playerlogic::mayspawn();
  } else {
    should_spawn_tags = self shouldSpawnTags(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId);

    if(should_spawn_tags) {
      should_spawn_tags = should_spawn_tags && !isReallyAlive(self);
    }

    if(should_spawn_tags) {
      should_spawn_tags = should_spawn_tags && !self maps\mp\gametypes\_playerlogic::mayspawn();
    }

    if(should_spawn_tags) {
      level thread spawnDogTags(self, attacker);
    }
  }

  thread checkAllowSpectating();
}

spawnDogTags(victim, attacker) {
  if(IsAgent(victim)) {
    return;
  }

  if(IsAgent(attacker)) {
    attacker = attacker.owner;
  }

  pos = victim.origin + (0, 0, 14);

  if(isDefined(level.dogtags[victim.guid])) {
    playFX(level.conf_fx["vanish"], level.dogtags[victim.guid].curOrigin);
    level.dogtags[victim.guid] notify("reset");
  } else {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[0] SetClientOwner(victim);
    visuals[0] setModel(CONST_ENEMY_TAG_MODEL);
    visuals[1] = spawn("script_model", (0, 0, 0));
    visuals[1] SetClientOwner(victim);
    visuals[1] setModel(CONST_FRIENDLY_TAG_MODEL);

    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

    level.dogtags[victim.guid] = maps\mp\gametypes\_gameobjects::createUseObject("any", trigger, visuals, (0, 0, 16));

    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["allies"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["axis"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["mlg"]);

    level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::setUseTime(0);
    level.dogtags[victim.guid].onUse = ::onUse;
    level.dogtags[victim.guid].victim = victim;
    level.dogtags[victim.guid].victimTeam = victim.team;

    level thread clearOnVictimDisconnect(victim);
    victim thread tagTeamUpdater(level.dogtags[victim.guid]);
  }

  level.dogtags[victim.guid].curOrigin = pos;
  level.dogtags[victim.guid].trigger.origin = pos;
  level.dogtags[victim.guid].visuals[0].origin = pos;
  level.dogtags[victim.guid].visuals[1].origin = pos;
  level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::initializeTagPathVariables();

  level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::allowUse("any");

  level.dogtags[victim.guid].visuals[0] thread showToTeam(level.dogtags[victim.guid], getOtherTeam(victim.team));
  level.dogtags[victim.guid].visuals[1] thread showToTeam(level.dogtags[victim.guid], victim.team);
  level.dogtags[victim.guid].attacker = attacker;

  if(victim.team == "axis") {
    objective_icon(level.dogtags[victim.guid].objIDAxis, "waypoint_dogtags_friendlys");
    objective_team(level.dogtags[victim.guid].objIDAxis, "axis");

    objective_icon(level.dogtags[victim.guid].objIDAllies, "waypoint_dogtags");
    objective_team(level.dogtags[victim.guid].objIDAllies, "allies");
  } else {
    objective_icon(level.dogtags[victim.guid].objIDAllies, "waypoint_dogtags_friendlys");
    objective_team(level.dogtags[victim.guid].objIDAllies, "allies");

    objective_icon(level.dogtags[victim.guid].objIDAxis, "waypoint_dogtags");
    objective_team(level.dogtags[victim.guid].objIDAxis, "axis");
  }

  objective_position(level.dogtags[victim.guid].objIDAllies, pos);
  objective_position(level.dogtags[victim.guid].objIDAxis, pos);

  objective_state(level.dogtags[victim.guid].objIDAllies, "active");
  objective_state(level.dogtags[victim.guid].objIDAxis, "active");

  playSoundAtPos(pos, "mp_killconfirm_tags_drop");

  level notify("sr_player_killed", victim);

  victim.tagAvailable = true;
  victim.objective = 3;

  level.dogtags[victim.guid].visuals[0] ScriptModelPlayAnim("mp_dogtag_spin");
  level.dogtags[victim.guid].visuals[1] ScriptModelPlayAnim("mp_dogtag_spin");
}

showToTeam(gameObject, team) {
  gameObject endon("death");
  gameObject endon("reset");

  self hide();

  foreach(player in level.players) {
    if(player.team == team) {
      self ShowToPlayer(player);
    }

    if(player.team == "spectator" && team == "allies") {
      self ShowToPlayer(player);
    }
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team == team) {
        self ShowToPlayer(player);
      }

      if(player.team == "spectator" && team == "allies") {
        self ShowToPlayer(player);
      }
    }
  }
}

sr_respawn() {
  self maps\mp\gametypes\_playerlogic::incrementAliveCount(self.team);
  self.alreadyAddedToAliveCount = true;

  self thread waiTillCanSpawnClient();
}

waiTillCanSpawnClient() {
  self endon("started_spawnPlayer");

  for(;;) {
    wait(.05);
    if(isDefined(self) && (self.sessionstate == "spectator" || !isReallyAlive(self))) {
      self.pers["lives"] = 1;
      self maps\mp\gametypes\_playerlogic::spawnClient();

      continue;
    }

    return;
  }
}

onUse(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  if(player.pers["team"] == self.victimTeam) {
    self.trigger playSound("mp_snd_ally_revive");

    player thread maps\mp\_events::reviveTagEvent(self.victim);

    if(isDefined(self.victim)) {
      level notify("sr_player_respawned", self.victim);
      self.victim leaderDialogOnPlayer("revived");
    }

    if(isDefined(self.victim)) {
      if(!level.gameEnded) {
        self.victim thread sr_respawn();
      }
    }

    player maps\mp\gametypes\_missions::processChallenge("ch_rescuer");

    if(!isDefined(player.rescuedPlayers)) {
      player.rescuedPlayers = [];
    }
    player.rescuedPlayers[self.victim.guid] = true;

    if(player.rescuedPlayers.size == OP_HELPME_NUM_TEAMMATES) {
      player maps\mp\gametypes\_missions::processChallenge("ch_helpme");
    }
  } else {
    self.trigger playSound("mp_killconfirm_tags_pickup");

    player thread maps\mp\_events::eliminateTagEvent();

    if(isDefined(self.victim)) {
      if(!level.gameEnded) {
        self.victim setLowerMessage("spawn_info", game["strings"]["spawn_next_round"]);
        self.victim thread maps\mp\gametypes\_playerlogic::removeSpawnMessageShortly(3.0);
      }

      self.victim.tagAvailable = undefined;
    }

    player leaderDialogOnPlayer("kill_confirmed");

    player maps\mp\gametypes\_missions::processChallenge("ch_hideandseek");
  }

  self.victim.objective = 0;

  level thread maps\mp\_events::monitorTagCollector(player);

  self resetTags();
}

resetTags() {
  self.attacker = undefined;
  self notify("reset");
  self.visuals[0] hide();
  self.visuals[1] hide();
  self.curOrigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  self.visuals[1].origin = (0, 0, 1000);
  self maps\mp\gametypes\_gameobjects::allowUse("none");
  objective_state(self.objIDAllies, "invisible");
  objective_state(self.objIDAxis, "invisible");
}

tagTeamUpdater(tags) {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("joined_team");

    tags.victimTeam = self.pers["team"];
    tags resetTags();
  }
}

clearOnVictimDisconnect(victim) {
  level endon("game_ended");

  guid = victim.guid;
  victim waittill("disconnect");

  if(isDefined(level.dogtags[guid])) {
    level.dogtags[guid] maps\mp\gametypes\_gameobjects::allowUse("none");

    playFX(level.conf_fx["vanish"], level.dogtags[guid].curOrigin);
    level.dogtags[guid] notify("reset");
    wait(0.05);

    if(isDefined(level.dogtags[guid])) {
      objective_delete(level.dogtags[guid].objIDAllies);
      objective_delete(level.dogtags[guid].objIDAllies);
      level.dogtags[guid].trigger delete();
      for(i = 0; i < level.dogtags[guid].visuals.size; i++) {
        level.dogtags[guid].visuals[i] delete();
      }
      level.dogtags[guid] notify("deleted");

      level.dogtags[guid] = undefined;
    }
  }
}