/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\sd.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

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
  level.initGametypeAwards = ::initGametypeAwards;
  level.gameModeMayDropWeapon = ::isPlayerOutsideOfAnyBombSite;

  level.allowLateComers = false;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  game["dialog"]["gametype"] = "searchdestroy";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
  else if(getDvarInt("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }
  else if(getDvarInt("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  }
  else if(getDvarInt("scr_" + level.gameType + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";

  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";

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

  SetDynamicDvar("scr_sd_roundlimit", 0);
  registerRoundLimitDvar("sd", 0);
  SetDynamicDvar("scr_sd_scorelimit", 1);
  registerScoreLimitDvar("sd", 1);
  SetDynamicDvar("scr_sd_halftime", 0);
  registerHalfTimeDvar("sd", 0);

  SetDynamicDvar("scr_sd_promode", 0);
}

onPrecacheGameType() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
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

  level._effect["bomb_explosion"] = loadfx("fx/explosions/tanker_explosion");
  level._effect["vehicle_explosion"] = loadfx("fx/explosions/small_vehicle_explosion_new");
  level._effect["building_explosion"] = loadfx("fx/explosions/building_explosion_gulag");

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

  return spawnpoint;
}

onSpawnPlayer() {
  if(IsGameParticipant(self)) {
    self.isPlanting = false;
    self.isDefusing = false;
    self.isBombCarrier = false;
  }

  if(level.multiBomb && self.pers["team"] == game["attackers"]) {
    self SetClientOmnvar("ui_carrying_bomb", true);
  }
  else {
    self SetClientOmnvar("ui_carrying_bomb", false);
  }

  self setExtraScore0(0);
  if(isDefined(self.pers["plants"])) {
    self setExtraScore0(self.pers["plants"]);
  }

  level notify("spawned_player");
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, killId) {
  self SetClientOmnvar("ui_carrying_bomb", false);

  thread checkAllowSpectating();
}

checkAllowSpectating() {
  wait(0.05);

  update = false;
  if(!level.aliveCount[game["attackers"]]) {
    level.spectateOverride[game["attackers"]].allowEnemySpectate = 1;
    update = true;
  }
  if(!level.aliveCount[game["defenders"]]) {
    level.spectateOverride[game["defenders"]].allowEnemySpectate = 1;
    update = true;
  }
  if(update) {
    maps\mp\gametypes\_spectating::updateSpectateSettings();
  }
}

sd_endGame(winningTeam, endReasonText) {
  foreach(player in level.players) {
    if(!IsAI(player)) {
      player SetClientOmnvar("ui_bomb_planting_defusing", 0);
    }
  }

  level.finalKillCam_winner = winningTeam;

  if(endReasonText == game["end_reason"]["target_destroyed"] || endReasonText == game["end_reason"]["bomb_defused"]) {
    eraseKillCam = true;
    foreach(bombZone in level.bombZones) {
      if(isDefined(level.finalKillCam_killCamEntityIndex[winningTeam]) && level.finalKillCam_killCamEntityIndex[winningTeam] == bombZone.killCamEntNum) {
        eraseKillCam = false;
        break;
      }
    }

    if(eraseKillCam) {
      maps\mp\gametypes\_damage::eraseFinalKillCam();
    }
  }

  thread maps\mp\gametypes\_gamelogic::endGame(winningTeam, endReasonText);
}

onDeadEvent(team) {
  if(level.bombExploded || level.bombDefused) {
    return;
  }
  if(team == "all") {
    if(level.bombPlanted) {
      sd_endGame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    }
    else {
      sd_endGame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    }
  } else if(team == game["attackers"]) {
    if(level.bombPlanted) {
      return;
    }
    level thread sd_endGame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(team == game["defenders"]) {
    level thread sd_endGame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
  }
}

onOneLeftEvent(team) {
  if(level.bombExploded || level.bombDefused) {
    return;
  }
  lastPlayer = getLastLivingPlayer(team);

  lastPlayer thread giveLastOnTeamWarning();
}

onNormalDeath(victim, attacker, lifeId) {
  score = maps\mp\gametypes\_rank::getScoreInfoValue("kill");
  assert(isDefined(score));

  team = victim.team;

  if(game["state"] == "postgame" && (victim.team == game["defenders"] || !level.bombPlanted)) {
    attacker.finalKill = true;
  }

  if(victim.isPlanting) {
    thread maps\mp\_matchdata::logKillEvent(lifeId, "planting");

    attacker incPersStat("defends", 1);
    attacker maps\mp\gametypes\_persistence::statSetChild("round", "defends", attacker.pers["defends"]);

  } else if(victim.isBombCarrier) {
    attacker incPlayerStat("bombcarrierkills", 1);
    thread maps\mp\_matchdata::logKillEvent(lifeId, "carrying");
  } else if(victim.isDefusing) {
    thread maps\mp\_matchdata::logKillEvent(lifeId, "defusing");

    attacker incPersStat("defends", 1);
    attacker maps\mp\gametypes\_persistence::statSetChild("round", "defends", attacker.pers["defends"]);
  }

  if(attacker.isBombCarrier) {
    attacker incPlayerStat("killsasbombcarrier", 1);
  }
}

giveLastOnTeamWarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  self waitTillRecoveredHealth(3);

  otherTeam = getOtherTeam(self.pers["team"]);
  level thread teamPlayerCardSplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread teamPlayerCardSplash("callout_lastenemyalive", self, otherTeam);
  level notify("last_alive", self);
  self maps\mp\gametypes\_missions::lastManSD();
}

onTimeLimit() {
  sd_endGame(game["defenders"], game["end_reason"]["time_limit_reached"]);

  foreach(player in level.players) {
    if(isDefined(player.bombPlantWeapon)) {
      player TakeWeapon(player.bombPlantWeapon);
      break;
    }
  }
}

updateGametypeDvars() {
  level.plantTime = dvarFloatValue("planttime", 5, 0, 20);
  level.defuseTime = dvarFloatValue("defusetime", 5, 0, 20);
  level.bombTimer = dvarFloatValue("bombtimer", 45, 1, 300);
  level.multiBomb = dvarIntValue("multibomb", 0, 0, 1);
}

removeBombZoneC(bombZones) {
  cZones = [];
  brushModels = getEntArray("script_brushmodel", "classname");
  foreach(brushModel in BrushModels) {
    if(isDefined(brushModel.script_gameobjectname) && brushModel.script_gameobjectname == "bombzone") {
      foreach(bombZone in bombZones) {
        if(distance(brushModel.origin, bombZone.origin) < 100 && isSubStr(toLower(bombZone.script_label), "c")) {
          bombZone.relatedBrushModel = brushModel;
          cZones[cZones.size] = bombZone;
          break;
        }
      }
    }
  }

  foreach(cZone in cZones) {
    cZone.relatedBrushModel delete();
    visuals = getEntArray(cZone.target, "targetname");
    foreach(visual in visuals) {
    visual delete();
    }
    cZone delete();
  }

  return array_removeUndefined(bombZones);
}

bombs() {
  level.bombPlanted = false;
  level.bombDefused = false;
  level.bombExploded = false;

  trigger = getEnt("sd_bomb_pickup_trig", "targetname");
  if(!isDefined(trigger)) {
    error("No sd_bomb_pickup_trig trigger found in map.");
    return;
  }

  visuals[0] = getEnt("sd_bomb", "targetname");
  if(!isDefined(visuals[0])) {
    error("No sd_bomb script_model found in map.");
    return;
  }

  visuals[0] setModel("weapon_briefcase_bomb_iw6");

  if(!level.multiBomb) {
    level.sdBomb = maps\mp\gametypes\_gameobjects::createCarryObject(game["attackers"], trigger, visuals, (0, 0, 32));
    level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry("friendly");
    level.sdBomb maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_bomb");
    level.sdBomb maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_bomb");
    level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam("friendly");

    level.sdBomb.allowWeapons = true;
    level.sdBomb.onPickup = ::onPickup;
    level.sdBomb.onDrop = ::onDrop;
  } else {
    trigger delete();
    visuals[0] delete();
  }

  level.bombZones = [];

  bombZones = getEntArray("bombzone", "targetname");
  bombZones = removeBombZoneC(bombZones);

  for(index = 0; index < bombZones.size; index++) {
    trigger = bombZones[index];
    visuals = getEntArray(bombZones[index].target, "targetname");

    bombZone = maps\mp\gametypes\_gameobjects::createUseObject(game["defenders"], trigger, visuals, (0, 0, 64));
    bombZone.id = "bomb_zone";
    bombZone maps\mp\gametypes\_gameobjects::allowUse("enemy");
    bombZone maps\mp\gametypes\_gameobjects::setUseTime(level.plantTime);
    bombZone maps\mp\gametypes\_gameobjects::setWaitWeaponChangeOnUse(false);
    bombZone maps\mp\gametypes\_gameobjects::setUseText(&"MP_PLANTING_EXPLOSIVE");
    bombZone maps\mp\gametypes\_gameobjects::setUseHintText(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
    if(!level.multiBomb) {
      bombZone maps\mp\gametypes\_gameobjects::setKeyObject(level.sdBomb);
    }
    label = bombZone maps\mp\gametypes\_gameobjects::getLabel();
    bombZone.label = label;
    bombZone maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_defend" + label);
    bombZone maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_defend" + label);
    bombZone maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_target" + label);
    bombZone maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_target" + label);
    bombZone maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
    bombZone.onBeginUse = ::onBeginUse;
    bombZone.onEndUse = ::onEndUse;
    bombZone.onUse = ::onUsePlantObject;
    bombZone.onCantUse = ::onCantUse;
    bombZone.useWeapon = "briefcase_bomb_mp";

    for(i = 0; i < visuals.size; i++) {
      if(isDefined(visuals[i].script_exploder)) {
        bombZone.exploderIndex = visuals[i].script_exploder;

        visuals[i] thread setupKillCamEnt(bombZone);
        break;
      }
    }

    level.bombZones[level.bombZones.size] = bombZone;

    bombZone.bombDefuseTrig = getent(visuals[0].target, "targetname");
    assert(isDefined(bombZone.bombDefuseTrig));
    bombZone.bombDefuseTrig.origin += (0, 0, -10000);
    bombZone.bombDefuseTrig.label = label;
  }

  for(index = 0; index < level.bombZones.size; index++) {
    array = [];
    for(otherindex = 0; otherindex < level.bombZones.size; otherindex++) {
      if(otherindex != index) {
        array[array.size] = level.bombZones[otherindex];
      }
    }
    level.bombZones[index].otherBombZones = array;
  }
}

setupKillCamEnt(bombZone) {
  tempOrg = spawn("script_origin", self.origin);
  tempOrg.angles = self.angles;
  tempOrg RotateYaw(-45, 0.05);
  wait(0.05);

  camPos = undefined;

  if(isDefined(level.srKillCamOverridePosition) && isDefined(level.srKillCamOverridePosition[bombZone.label])) {
    camPos = level.srKillCamOverridePosition[bombZone.label];
  } else {
    bulletStart = self.origin + (0, 0, 5);
    bulletEnd = (self.origin + (anglesToForward(tempOrg.angles) * 100)) + (0, 0, 128);
    result = bulletTrace(bulletStart, bulletEnd, false, self);
    camPos = result["position"];
  }

  self.killCamEnt = spawn("script_model", camPos);

  self.killCamEnt SetScriptMoverKillCam("explosive");
  bombZone.killCamEntNum = self.killCamEnt GetEntityNumber();
  tempOrg delete();

  self.killCamEnt thread debugKillCamEnt(self);
}

debugKillCamEnt(visual) {
  self endon("death");
  level endon("game_ended");
  visual endon("death");

  while(true) {
    if(GetDvarInt("scr_sd_debugBombKillCamEnt") > 0) {
      Line(self.origin, self.origin + (anglesToForward(self.angles) * 10), (1, 0, 0));
      Line(self.origin, self.origin + (AnglesToRight(self.angles) * 10), (0, 1, 0));
      Line(self.origin, self.origin + (AnglesToUp(self.angles) * 10), (0, 0, 1));

      Line(visual.origin + (0, 0, 5), self.origin, (0, 0, 1));

      Line(visual.origin, visual.origin + (anglesToForward(visual.angles) * 10), (1, 0, 0));
      Line(visual.origin, visual.origin + (AnglesToRight(visual.angles) * 10), (0, 1, 0));
      Line(visual.origin, visual.origin + (AnglesToUp(visual.angles) * 10), (0, 0, 1));
    }
    wait(0.05);
  }
}

onBeginUse(player) {
  if(self maps\mp\gametypes\_gameobjects::isFriendlyTeam(player.pers["team"])) {
    player notify_enemy_bots_bomb_used("defuse");
    player.isDefusing = true;

    if(isDefined(level.sdBombModel)) {
      level.sdBombModel hide();
    }

    player thread startNpcBombUseSound("briefcase_bomb_defuse_mp", "weap_suitcase_defuse_button");
  } else {
    player notify_enemy_bots_bomb_used("plant");
    player.isPlanting = true;
    player.bombPlantWeapon = self.useWeapon;

    player thread startNpcBombUseSound("briefcase_bomb_mp", "weap_suitcase_raise_button");

    if(level.multibomb) {
      for(i = 0; i < self.otherBombZones.size; i++) {
        self.otherBombZones[i] maps\mp\gametypes\_gameobjects::allowUse("none");
        self.otherBombZones[i] maps\mp\gametypes\_gameobjects::setVisibleTeam("friendly");
      }
    }
  }
}

onEndUse(team, player, result) {
  if(!isDefined(player)) {
    return;
  }
  player.bombPlantWeapon = undefined;

  if(isAlive(player)) {
    player.isDefusing = false;
    player.isPlanting = false;
  }

  if(IsPlayer(player)) {
    player SetClientOmnvar("ui_bomb_planting_defusing", 0);
    player.ui_bomb_planting_defusing = undefined;
  }

  if(self maps\mp\gametypes\_gameobjects::isFriendlyTeam(player.pers["team"])) {
    if(isDefined(level.sdBombModel) && !result) {
      level.sdBombModel show();
    }
  } else {
    if(level.multibomb && !result) {
      for(i = 0; i < self.otherBombZones.size; i++) {
        self.otherBombZones[i] maps\mp\gametypes\_gameobjects::allowUse("enemy");
        self.otherBombZones[i] maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
      }
    }
  }
}

startNpcBombUseSound(weaponName, soundName) {
  self endon("death");
  self endon("stopNpcBombSound");

  if(isAnyMLGMatch()) {
    return;
  }
  newWeapon = "";
  while(newWeapon != weaponName) {
    self waittill("weapon_change", newWeapon);
  }

  self PlaySoundToTeam(soundName, self.team, self);
  enemyTeam = getOtherTeam(self.team);
  self PlaySoundToTeam(soundName, enemyTeam);

  self waittill("weapon_change");

  self notify("stopNpcBombSound");
}

onCantUse(player) {
  player iPrintLnBold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

onUsePlantObject(player) {
  if(!self maps\mp\gametypes\_gameobjects::isFriendlyTeam(player.pers["team"])) {
    level thread bombPlanted(self, player);

    for(index = 0; index < level.bombZones.size; index++) {
      if(level.bombZones[index] == self) {
        continue;
      }
      level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
    }

    player playSound("mp_bomb_plant");
    player notify("bomb_planted");
    player notify("objective", "plant");

    player incPersStat("plants", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "plants", player.pers["plants"]);

    player setExtraScore0(player.pers["plants"]);

    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[player.team])) {
      player thread removeBombCarrierClass();
    }

    leaderDialog("bomb_planted");

    level thread teamPlayerCardSplash("callout_bombplanted", player);

    level.bombOwner = player;
    player thread maps\mp\gametypes\_hud_message::SplashNotify("plant", maps\mp\gametypes\_rank::getScoreInfoValue("plant"));
    player thread maps\mp\gametypes\_rank::xpEventPopup("plant");
    player thread maps\mp\gametypes\_rank::giveRankXP("plant");
    player.bombPlantedTime = getTime();
    maps\mp\gametypes\_gamescore::givePlayerScore("plant", player);

    if(IsPlayer(player)) {
      player thread maps\mp\_matchdata::logGameEvent("plant", player.origin);
    }
  }
}

applyBombCarrierClass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.isCarrying) && self.isCarrying == true) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self IsMantling()) {
    wait(0.05);
  }

  while(!self isOnGround()) {
    wait(0.05);
  }

  if(self isJuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];

  if(isDefined(self.setSpawnpoint)) {
    self maps\mp\perks\_perkfunctions::deleteTI(self.setSpawnpoint);
  }

  spawnPoint = spawn("script_model", self.origin);
  spawnPoint.angles = self.angles;
  spawnPoint.playerSpawnPos = self.origin;
  spawnPoint.notTI = true;
  self.setSpawnPoint = spawnPoint;

  self.gamemode_chosenClass = self.class;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastClass = "gamemode";

  self notify("faux_spawn");
  self.gameObject_fauxSpawn = true;
  self.faux_spawn_stance = self getStance();
  self thread maps\mp\gametypes\_playerlogic::spawnPlayer(true);
}

removeBombCarrierClass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.isCarrying) && self.isCarrying == true) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self IsMantling()) {
    wait(0.05);
  }

  while(!self isOnGround()) {
    wait(0.05);
  }

  if(self isJuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = undefined;

  if(isDefined(self.setSpawnpoint)) {
    self maps\mp\perks\_perkfunctions::deleteTI(self.setSpawnpoint);
  }

  spawnPoint = spawn("script_model", self.origin);
  spawnPoint.angles = self.angles;
  spawnPoint.playerSpawnPos = self.origin;
  spawnPoint.notTI = true;
  self.setSpawnPoint = spawnPoint;

  self notify("faux_spawn");
  self.faux_spawn_stance = self getStance();
  self thread maps\mp\gametypes\_playerlogic::spawnPlayer(true);
}

onUseDefuseObject(player) {
  player notify("bomb_defused");
  player notify("objective", "defuse");

  level thread bombDefused();

  self maps\mp\gametypes\_gameobjects::disableObject();

  leaderDialog("bomb_defused_" + player.team);

  level thread teamPlayerCardSplash("callout_bombdefused", player);

  if(isDefined(level.bombOwner) && (level.bombOwner.bombPlantedTime + 3000 + (level.defuseTime * 1000)) > getTime() && isReallyAlive(level.bombOwner)) {
    player thread maps\mp\gametypes\_hud_message::SplashNotify("ninja_defuse", (maps\mp\gametypes\_rank::getScoreInfoValue("defuse")));
  }
  else {
    player thread maps\mp\gametypes\_hud_message::SplashNotify("defuse", maps\mp\gametypes\_rank::getScoreInfoValue("defuse"));
  }

  player thread maps\mp\gametypes\_rank::xpEventPopup("defuse");
  player thread maps\mp\gametypes\_rank::giveRankXP("defuse");
  maps\mp\gametypes\_gamescore::givePlayerScore("defuse", player);

  player incPersStat("defuses", 1);
  player maps\mp\gametypes\_persistence::statSetChild("round", "defuses", player.pers["defuses"]);

  if(IsPlayer(player)) {
    player thread maps\mp\_matchdata::logGameEvent("defuse", player.origin);
  }
}

onDrop(player) {
  level notify("bomb_dropped");
  SetOmnvar("ui_bomb_carrier", -1);

  self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_bomb");
  self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_bomb");

  maps\mp\_utility::playSoundOnPlayers(game["bomb_dropped_sound"], game["attackers"]);
}

onPickup(player) {
  player.isBombCarrier = true;
  player incPlayerStat("bombscarried", 1);

  if(IsPlayer(player)) {
    player thread maps\mp\_matchdata::logGameEvent("pickup", player.origin);
  }
  player SetClientOmnvar("ui_carrying_bomb", true);
  SetOmnvar("ui_bomb_carrier", player GetEntityNumber());

  self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_escort");
  self maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_escort");

  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[player.team])) {
    player thread applyBombCarrierClass();
  }

  if(!level.bombDefused) {
    teamPlayerCardSplash("callout_bombtaken", player, player.team);
    leaderDialog("bomb_taken", player.pers["team"]);
  }
  maps\mp\_utility::playSoundOnPlayers(game["bomb_recovered_sound"], game["attackers"]);
}

onReset() {}

bombPlanted(destroyedObj, player) {
  level notify("bomb_planted", destroyedObj);

  maps\mp\gametypes\_gamelogic::pauseTimer();
  level.bombPlanted = true;

  player SetClientOmnvar("ui_carrying_bomb", false);
  SetOmnvar("ui_bomb_carrier", -1);

  destroyedObj.visuals[0] thread maps\mp\gametypes\_gamelogic::playTickingSound();
  level.tickingObject = destroyedObj.visuals[0];

  level.timeLimitOverride = true;
  level.defuseEndTime = int(gettime() + (level.bombTimer * 1000));
  setGameEndTime(level.defuseEndTime);
  SetOmnvar("ui_bomb_timer", 1);

  if(!level.multiBomb) {
    level.sdBomb maps\mp\gametypes\_gameobjects::allowCarry("none");
    level.sdBomb maps\mp\gametypes\_gameobjects::setVisibleTeam("none");
    level.sdBomb maps\mp\gametypes\_gameobjects::setDropped();
    level.sdBombModel = level.sdBomb.visuals[0];
  } else {
    level.sdBombModel = spawn("script_model", player.origin);
    level.sdBombModel.angles = player.angles;
    level.sdBombModel setModel("weapon_briefcase_bomb_iw6");
  }
  destroyedObj maps\mp\gametypes\_gameobjects::allowUse("none");
  destroyedObj maps\mp\gametypes\_gameobjects::setVisibleTeam("none");

  label = destroyedObj maps\mp\gametypes\_gameobjects::getLabel();

  trigger = destroyedObj.bombDefuseTrig;
  trigger.origin = level.sdBombModel.origin;
  visuals = [];
  defuseObject = maps\mp\gametypes\_gameobjects::createUseObject(game["defenders"], trigger, visuals, (0, 0, 32));
  defuseObject.id = "defuse_object";
  defuseObject maps\mp\gametypes\_gameobjects::allowUse("friendly");
  defuseObject maps\mp\gametypes\_gameobjects::setUseTime(level.defuseTime);
  defuseObject maps\mp\gametypes\_gameobjects::setWaitWeaponChangeOnUse(false);
  defuseObject maps\mp\gametypes\_gameobjects::setUseText(&"MP_DEFUSING_EXPLOSIVE");
  defuseObject maps\mp\gametypes\_gameobjects::setUseHintText(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  defuseObject maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
  defuseObject maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_defuse" + label);
  defuseObject maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_defend" + label);
  defuseObject maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_defuse" + label);
  defuseObject maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_defend" + label);
  defuseObject.label = label;
  defuseObject.onBeginUse = ::onBeginUse;
  defuseObject.onEndUse = ::onEndUse;
  defuseObject.onUse = ::onUseDefuseObject;
  defuseObject.useWeapon = "briefcase_bomb_defuse_mp";

  BombTimerWait();
  SetOmnvar("ui_bomb_timer", 0);

  destroyedObj.visuals[0] maps\mp\gametypes\_gamelogic::stopTickingSound();

  if(level.gameEnded || level.bombDefused) {
    return;
  }
  level.bombExploded = true;

  level notify("bomb_exploded");

  if(isDefined(level.sd_onBombTimerEnd)) {
    level thread[[level.sd_onBombTimerEnd]]();
  }

  explosionOrigin = level.sdBombModel.origin;
  level.sdBombModel hide();

  if(isDefined(player)) {
    destroyedObj.visuals[0] RadiusDamage(explosionOrigin, 512, 200, 20, player, "MOD_EXPLOSIVE", "bomb_site_mp");
    player incPersStat("destructions", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "destructions", player.pers["destructions"]);
  } else
    destroyedObj.visuals[0] RadiusDamage(explosionOrigin, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  rot = randomfloat(360);
  if(isDefined(destroyedObj.trigger.effect)) {
    effect = destroyedObj.trigger.effect;
  }
  else {
    effect = "bomb_explosion";
  }

  explosionPos = explosionOrigin + (0, 0, 50);
  explosionEffect = spawnFx(level._effect[effect], explosionPos, (0, 0, 1), (cos(rot), sin(rot), 0));
  triggerFx(explosionEffect);
  PhysicsExplosionSphere(explosionPos, 200, 100, 3);

  PlayRumbleOnPosition("grenade_rumble", explosionOrigin);
  earthquake(0.75, 2.0, explosionOrigin, 2000);

  thread playSoundinSpace("exp_suitcase_bomb_main", explosionOrigin);

  if(isDefined(destroyedObj.exploderIndex)) {
    exploder(destroyedObj.exploderIndex);
  }

  for(index = 0; index < level.bombZones.size; index++) {
    level.bombZones[index] maps\mp\gametypes\_gameobjects::disableObject();
  }
  defuseObject maps\mp\gametypes\_gameobjects::disableObject();

  setGameEndTime(0);

  wait(3);

  sd_endGame(game["attackers"], game["end_reason"]["target_destroyed"]);
}

initObjectiveCam(objective) {
  camStart = undefined;
  startNodes = getEntArray("sd_bombcam_start", "targetname");
  foreach(startNode in startNodes) {
    if(startNode.script_label == objective.label) {
      camStart = startNode;
      break;
    }
  }

  camPath = [];
  if(isDefined(camStart) && isDefined(camStart.target)) {
    nextNode = getEnt(camStart.target, "targetname");
    while(isDefined(nextNode)) {
      camPath[camPath.size] = nextNode;
      if(isDefined(nextNode.target)) {
        nextNode = getEnt(nextNode.target, "targetname");
      }
      else {
        break;
      }
    }
  }

  if(isDefined(camStart) && camPath.size) {
    cam = spawn("script_model", camStart.origin);
    cam.origin = camStart.origin;
    cam.angles = camStart.angles;
    cam.path = camPath;
    cam setModel("tag_origin");
    cam hide();

    return cam;
  } else
    return undefined;
}

runObjectiveCam() {
  level notify("objective_cam");

  foreach(player in level.players) {
    if(!IsAI(player)) {
      player freezeControlsWrapper(true);
      player VisionSetNakedForPlayer("black_bw", 0.5);
    }
  }

  wait(0.5);
  foreach(player in level.players) {
    if(!IsAI(player)) {
      if(isDefined(player.disabledOffhandWeapons)) {
        player setUsingRemote("objective_cam");
        player _disableWeapon();
      }
      player playerLinkWeaponViewToDelta(self, "tag_player", 1, 180, 180, 180, 180, true);
      player freezeControlsWrapper(true);
      player setPlayerAngles(self.angles);
      player VisionSetNakedForPlayer("", 0.5);
    }
  }

  resetHardcore = false;
  if(!getDvarInt("g_hardcore")) {
    SetDynamicDvar("g_hardcore", 1);
    resetHardcore = true;
  }

  for(i = 0; i < self.path.size; i++) {
    accelTime = 0;
    if(i == 0) {
      accelTime = (5 / self.path.size) / 2;
    }

    decelTime = 0;
    if(i == self.path.size - 1) {
      decelTime = (5 / self.path.size) / 2;
    }

    self moveTo(self.path[i].origin, 5 / self.path.size, accelTime, decelTime);
    self rotateTo(self.path[i].angles, 5 / self.path.size, accelTime, decelTime);

    wait(5 / self.path.size);
  }

  if(resetHardcore) {
    wait(0.5);
    SetDynamicDvar("g_hardcore", 0);
  }
}

BombTimerWait() {
  level endon("game_ended");
  level endon("bomb_defused");

  bombEndMilliseconds = int((level.bombTimer * 1000) + gettime());
  SetOmnvar("ui_bomb_timer_endtime", bombEndMilliseconds);

  level thread handleHostMigration(bombEndMilliseconds);
  maps\mp\gametypes\_hostmigration::waitLongDurationWithGameEndTimeUpdate(level.bombTimer);
}

handleHostMigration(bombEndMilliseconds) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");

  level waittill("host_migration_begin");

  SetOmnvar("ui_bomb_timer_endtime", 0);

  timePassed = maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(timePassed > 0) {
    SetOmnvar("ui_bomb_timer_endtime", bombEndMilliseconds + timePassed);
  }
}

bombDefused() {
  level.tickingObject maps\mp\gametypes\_gamelogic::stopTickingSound();
  level.bombDefused = true;
  SetOmnvar("ui_bomb_timer", 0);

  level notify("bomb_defused");

  wait 1.5;

  setGameEndTime(0);

  sd_endGame(game["defenders"], game["end_reason"]["bomb_defused"]);
}

initGametypeAwards() {
  maps\mp\_awards::initStatAward("targetsdestroyed", 0, maps\mp\_awards::highestWins);
  maps\mp\_awards::initStatAward("bombsplanted", 0, maps\mp\_awards::highestWins);
  maps\mp\_awards::initStatAward("bombsdefused", 0, maps\mp\_awards::highestWins);
  maps\mp\_awards::initStatAward("bombcarrierkills", 0, maps\mp\_awards::highestWins);
  maps\mp\_awards::initStatAward("bombscarried", 0, maps\mp\_awards::highestWins);
  maps\mp\_awards::initStatAward("killsasbombcarrier", 0, maps\mp\_awards::highestWins);
}

setSpecialLoadout() {
  if(isUsingMatchRulesData() && GetMatchRulesData("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level.sd_loadout[game["attackers"]] = getMatchRulesSpecialClass(game["attackers"], 5);
  }
}