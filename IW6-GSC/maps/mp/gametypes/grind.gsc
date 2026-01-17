/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\grind.gsc
***************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerRoundSwitchDvar(level.gameType, 0, 0, 9);
    registerTimeLimitDvar(level.gameType, 10);
    registerScoreLimitDvar(level.gameType, 500);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);
  }

  level.teamBased = true;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onPrecacheGameType = ::onPrecacheGameType;
  level.onSpawnPlayer = ::onSpawnPlayer;
}

onPrecacheGameType() {
  level.flagBaseFXid["friendly"] = LoadFx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_grind_roundswitch", 0);
  registerRoundSwitchDvar("grind", 0, 0, 9);
  SetDynamicDvar("scr_grind_roundlimit", 1);
  registerRoundLimitDvar("grind", 1);
  SetDynamicDvar("scr_grind_winlimit", 1);
  registerWinLimitDvar("grind", 1);
  SetDynamicDvar("scr_grind_halftime", 0);
  registerHalfTimeDvar("grind", 0);
  SetDynamicDvar("scr_grind_promode", 0);
}

onStartGameType() {
  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = false;

  setObjectiveText("allies", &"OBJECTIVES_WAR");
  setObjectiveText("axis", &"OBJECTIVES_WAR");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", &"OBJECTIVES_WAR");
    setObjectiveScoreText("axis", &"OBJECTIVES_WAR");
  } else {
    setObjectiveScoreText("allies", &"OBJECTIVES_WAR_SCORE");
    setObjectiveScoreText("axis", &"OBJECTIVES_WAR_SCORE");
  }

  setObjectiveHintText("allies", &"OBJECTIVES_WAR_HINT");
  setObjectiveHintText("axis", &"OBJECTIVES_WAR_HINT");

  initSpawns();
  createTags();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);

  createZones();

  level thread onPlayerConnect();
  level thread runZones();
  level thread removeTagsOnGameEnded();
}

onSpawnPlayer() {
  if(isDefined(self.tagsCarried))
    self SetClientOmnvar("ui_grind_tags", self.tagsCarried);
}

createTags() {
  level.dogtags = [];

  for(i = 0; i < 50; i++) {
    visual = spawn("script_model", (0, 0, 0));
    visual setModel("prop_dogtags_foe_iw6");
    visual.baseOrigin = visual.origin;
    visual ScriptModelPlayAnim("mp_dogtag_spin");
    visual hide();

    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    trigger.targetname = "trigger_dogtag";
    trigger Hide();

    newTag = spawnStruct();
    newTag.type = "useObject";
    newTag.curOrigin = trigger.origin;
    newTag.entNum = trigger getEntityNumber();
    newTag.lastUsedTime = 0;
    newTag.visual = visual;
    newTag.offset3d = (0, 0, 16);
    newTag.trigger = trigger;
    newTag.triggerType = "proximity";
    newTag maps\mp\gametypes\_gameobjects::allowUse("none");

    level.dogtags[level.dogtags.size] = newTag;
  }
}

getTag() {
  bestTag = level.dogtags[0];
  oldestTime = GetTime();

  foreach(tag in level.dogtags) {
    if(tag.interactTeam == "none") {
      bestTag = tag;
      break;
    }

    if(tag.lastUsedTime < oldestTime) {
      oldestTime = tag.lastUsedTime;
      bestTag = tag;
    }
  }

  bestTag notify("reset");
  bestTag maps\mp\gametypes\_gameobjects::initializeTagPathVariables();
  bestTag.lastUsedTime = GetTime();

  return bestTag;
}

spawnTag(dropLocation, bRabdom) {
  startPos = dropLocation + (0, 0, 14);

  if(isDefined(bRabdom) && bRabdom) {
    randomAngle = (0, RandomFloat(360), 0);
    randomDir = anglesToForward(randomAngle);
    randomDst = RandomFloatRange(40, 300);

    testpos = startpos + (randomDst * randomDir);
    startPos = PlayerPhysicsTrace(startPos, testpos);
  }

  newTag = getTag();
  newTag.curOrigin = startPos;
  newTag.trigger.origin = startPos;
  newTag.visual.origin = startPos;

  newTag.trigger show();
  newTag.visual show();

  newTag maps\mp\gametypes\_gameobjects::allowUse("any");

  playSoundAtPos(startPos, "mp_grind_token_drop");

  return newTag;
}

monitorTagUse(tag) {
  level endon("game_ended");
  tag endon("deleted");
  tag endon("reset");

  while(true) {
    tag.trigger waittill("trigger", player);

    if(!isReallyAlive(player)) {
      continue;
    }
    if(player isUsingRemote() || isDefined(player.spawningAfterRemoteDeath)) {
      continue;
    }
    if(isDefined(player.classname) && player.classname == "script_vehicle") {
      continue;
    }
    if(IsAgent(player) && isDefined(player.owner))
      player = player.owner;

    tag.visual hide();
    tag.trigger hide();

    tag.curOrigin = (0, 0, 1000);
    tag.trigger.origin = (0, 0, 1000);
    tag.visual.origin = (0, 0, 1000);

    tag maps\mp\gametypes\_gameobjects::allowUse("none");

    player thread maps\mp\gametypes\_rank::giveRankXP("tag");
    player playerSetTagCount(player.tagsCarried + 1);
    player playSound("mp_killconfirm_tags_pickup");

    playSoundAtPos(player.origin, "mp_grind_token_pickup");

    break;
  }
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    player.isScoring = false;
    player thread monitorJoinTeam();
  }
}

playerSetTagCount(tagCount) {
  self.tagsCarried = tagCount;
  self.game_extrainfo = tagCount;
  if(tagCount > 999)
    tagCount = 999;
  self SetClientOmnvar("ui_grind_tags", tagCount);
}

monitorJoinTeam() {
  self endon("disconnect");

  while(1) {
    self waittill_any("joined_team", "joined_spectators");

    if(level.inGracePeriod) {
      self playerSetTagCount(1);
    } else {
      self playerSetTagCount(0);
    }
  }
}

hideHudElementOnGameEnd(hudElement) {
  level waittill("game_ended");

  if(isDefined(hudElement))
    hudElement.alpha = 0;
}

createZones() {
  level.zoneList = [];
  game["flagmodels"] = [];

  game["flagmodels"]["neutral"] = "prop_flag_neutral";
  game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getTeamFlagModel("allies");
  game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getTeamFlagModel("axis");

  grindTriggers = getEntArray("grind_location", "targetname");

  foreach(grindTrigger in grindTriggers) {
    level.zoneList[level.zoneList.size] = addZone(grindTrigger);
  }
}

addZone(zoneTrigger) {
  AssertEx(isDefined(zoneTrigger), "map needs grind game objects");

  zone = spawnStruct();
  zone.origin = zoneTrigger.origin;
  zone.angles = zoneTrigger.angles;
  zone.trigger = zoneTrigger;
  zone.ownerTeam = "neutral";

  traceStart = zone.origin + (0, 0, 32);
  traceEnd = zone.origin + (0, 0, -32);
  trace = bulletTrace(traceStart, traceEnd, false, undefined);

  zone.origin = trace["position"];
  zone.upangles = vectorToAngles(trace["normal"]);
  zone.forward = anglesToForward(zone.upangles);
  zone.right = anglesToRight(zone.upangles);

  zone.visuals[0] = spawn("script_model", zone.origin);
  zone.visuals[0].angles = zone.angles;
  zone.visuals[0] setModel(game["flagmodels"]["neutral"]);

  return zone;
}

runZones() {
  foreach(zone in level.zoneList) {
    level thread startZone(zone, zone.trigger.script_label);
  }
}

startZone(zone, hudIcon) {
  level thread runZoneFX(zone);
  level thread runZoneStatus(zone, hudIcon);
  level thread runZoneThink(zone);
}

runZoneFX(zone) {
  gameFlagWait("prematch_done");

  zoneFX = spawnFx(level.flagBaseFXid["friendly"], zone.origin, zone.forward, zone.upangles);
  triggerFx(zoneFX);
}

runZoneStatus(zone, hudIcon) {
  offset = (0, 0, 100);

  zone.objId_axis = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(zone.objId_axis, "active", zone.origin + offset, "waypoint_target_" + hudIcon);
  Objective_Team(zone.objId_axis, "axis");

  zone.objId_allies = maps\mp\gametypes\_gameobjects::getNextObjID();
  objective_add(zone.objId_allies, "active", zone.origin + offset, "waypoint_target_" + hudIcon);
  Objective_Team(zone.objId_allies, "allies");

  lastScoredTime = 0;
  lastOwnerTeam = "none";

  while(true) {
    ownerTeam = "neutral";

    foreach(player in level.players) {
      if(!isReallyAlive(player)) {
        continue;
      }
      if(!player.tagsCarried) {
        continue;
      }
      if(player.team == ownerTeam) {
        continue;
      }

      if(isInZone(player, zone)) {
        if(ownerTeam == "neutral") {
          ownerTeam = player.team;
          continue;
        }

        ownerTeam = "contested";
        break;
      }
    }

    zone.ownerTeam = ownerTeam;

    if(lastOwnerTeam == ownerTeam) {
      waitframe();
      continue;
    }

    switch (ownerTeam) {
      case "neutral":

        if((lastScoredTime + 1250) > GetTime()) {
          break;
        }

        lastOwnerTeam = ownerTeam;
        zone.grind_headIcon_allies = zone maps\mp\_entityheadIcons::setHeadIcon("allies", "waypoint_bank_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        zone.grind_headIcon_axis = zone maps\mp\_entityheadIcons::setHeadIcon("axis", "waypoint_bank_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        Objective_Icon(zone.objId_allies, "waypoint_bank_" + hudIcon);
        Objective_Icon(zone.objId_axis, "waypoint_bank_" + hudIcon);
        break;
      case "contested":
        lastOwnerTeam = ownerTeam;
        zone.grind_headIcon_allies = zone maps\mp\_entityheadIcons::setHeadIcon("allies", "waypoint_contested_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        zone.grind_headIcon_axis = zone maps\mp\_entityheadIcons::setHeadIcon("axis", "waypoint_contested_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        Objective_Icon(zone.objId_allies, "waypoint_contested_" + hudIcon);
        Objective_Icon(zone.objId_axis, "waypoint_contested_" + hudIcon);
        break;
      case "axis":
        lastOwnerTeam = ownerTeam;
        zone.grind_headIcon_allies = zone maps\mp\_entityheadIcons::setHeadIcon("allies", "waypoint_scoring_foe_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        zone.grind_headIcon_axis = zone maps\mp\_entityheadIcons::setHeadIcon("axis", "waypoint_scoring_friend_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        Objective_Icon(zone.objId_allies, "waypoint_scoring_foe_" + hudIcon);
        Objective_Icon(zone.objId_axis, "waypoint_scoring_friend_" + hudIcon);
        lastScoredTime = GetTime();
        break;
      case "allies":
        lastOwnerTeam = ownerTeam;
        zone.grind_headIcon_allies = zone maps\mp\_entityheadIcons::setHeadIcon("allies", "waypoint_scoring_friend_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        zone.grind_headIcon_axis = zone maps\mp\_entityheadIcons::setHeadIcon("axis", "waypoint_scoring_foe_" + hudIcon, offset, 4, 4, undefined, undefined, undefined, true, undefined, false);
        Objective_Icon(zone.objId_allies, "waypoint_scoring_friend_" + hudIcon);
        Objective_Icon(zone.objId_axis, "waypoint_scoring_foe_" + hudIcon);
        lastScoredTime = GetTime();
        break;
    }

    waitframe();
  }
}

isInZone(player, zone) {
  if(isReallyAlive(player) && (player IsTouching(zone.trigger))) {
    return true;
  }

  return false;
}

runZoneThink(zone) {
  level endon("game_ended");

  while(true) {
    zone.trigger waittill("trigger", player);

    if(IsAgent(player)) {
      continue;
    }
    if(!IsPlayer(player)) {
      continue;
    }
    if(player.isScoring) {
      continue;
    }
    player.isScoring = true;

    level thread processScoring(player, zone);
  }
}

removeTagsOnGameEnded() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.tagsCarried)) {
      continue;
    }
    player.tagsCarried = 0;
  }
}

processScoring(player, zone) {
  while(player.tagsCarried && isInZone(player, zone)) {
    player PlaySoundToPlayer("mp_grind_token_banked", player);
    player playerSetTagCount(player.tagsCarried - 1);

    maps\mp\gametypes\_gamescore::giveTeamScoreForObjective(player.team, 1);
    player setExtraScore0(player.extrascore0 + 1);
    maps\mp\gametypes\_gamescore::givePlayerScore("tagScore", player);

    player maps\mp\_events::giveObjectivePointStreaks();

    player maps\mp\gametypes\_missions::processChallenge("ch_grinder");

    wait(2);
  }

  player.isScoring = false;
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_tdm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint() {
  spawnteam = self.pers["team"];
  if(game["switchedsides"])
    spawnteam = getOtherTeam(spawnteam);

  if(maps\mp\gametypes\_spawnlogic::shouldUseTeamStartspawn()) {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray("mp_tdm_spawn_" + spawnteam + "_start");
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_startspawn(spawnPoints);
  } else {
    spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(spawnteam);
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_NearTeam(spawnPoints);
  }

  return spawnPoint;
}

onNormalDeath(victim, attacker, lifeId) {
  level thread dropTags(victim, attacker);

  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherTeam[attacker.team]])
    attacker.finalKill = true;
}

dropTags(victim, attacker) {
  if(IsAgent(victim)) {
    return;
  }
  dropNumber = 1;
  radomDropLocation = false;
  counter = 0;

  while(counter < dropNumber) {
    if(counter > 0)
      radomDropLocation = true;

    newTag = spawnTag(victim.origin, radomDropLocation);
    newTag.victim = victim;
    newTag.attacker = attacker;
    level notify("new_tag_spawned", newTag);
    level thread monitorTagUse(newTag);
    counter++;
  }

  playSoundAtPos(victim.origin, "mp_killconfirm_tags_drop");

  newTagCount = victim.tagsCarried - dropNumber;
  newTagCount = int(max(0, newTagCount));

  victim playerSetTagCount(newTagCount);
}