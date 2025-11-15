/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\conf.gsc
**************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;

CONST_FRIENDLY_TAG_MODEL = "prop_dogtags_friend_iw6";
CONST_ENEMY_TAG_MODEL = "prop_dogtags_foe_iw6";

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
    registerRoundSwitchDvar(level.gameType, 0, 0, 9);
    registerTimeLimitDvar(level.gameType, 10);
    registerScoreLimitDvar(level.gameType, 65);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  level.teamBased = true;
  level.initGametypeAwards = ::initGametypeAwards;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onNormalDeath = ::onNormalDeath;
  level.onPrecacheGameType = ::onPrecacheGameType;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism)
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;

  game["dialog"]["gametype"] = "kill_confirmed";

  game["dialog"]["kill_confirmed"] = "kill_confirmed";

  if(getDvarInt("g_hardcore"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

  level.conf_fx["vanish"] = loadFx("fx/impacts/small_snowhit");
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_conf_roundswitch", 0);
  registerRoundSwitchDvar("conf", 0, 0, 9);
  SetDynamicDvar("scr_conf_roundlimit", 1);
  registerRoundLimitDvar("conf", 1);
  SetDynamicDvar("scr_conf_winlimit", 1);
  registerWinLimitDvar("conf", 1);
  SetDynamicDvar("scr_conf_halftime", 0);
  registerHalfTimeDvar("conf", 0);

  SetDynamicDvar("scr_conf_promode", 0);
}

onPrecacheGameType() {
  precacheMpAnim("mp_dogtag_spin");
  precacheshader("waypoint_dogtags");
}

onStartGameType() {
  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = false;

  if(game["switchedsides"]) {
    oldAttackers = game["attackers"];
    oldDefenders = game["defenders"];
    game["attackers"] = oldDefenders;
    game["defenders"] = oldAttackers;
  }

  setObjectiveText("allies", & "OBJECTIVES_CONF");
  setObjectiveText("axis", & "OBJECTIVES_CONF");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", & "OBJECTIVES_CONF");
    setObjectiveScoreText("axis", & "OBJECTIVES_CONF");
  } else {
    setObjectiveScoreText("allies", & "OBJECTIVES_CONF_SCORE");
    setObjectiveScoreText("axis", & "OBJECTIVES_CONF_SCORE");
  }
  setObjectiveHintText("allies", & "OBJECTIVES_CONF_HINT");
  setObjectiveHintText("axis", & "OBJECTIVES_CONF_HINT");

  initSpawns();

  level.dogtags = [];

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);
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
  level thread spawnDogTags(victim, attacker);

  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherTeam[attacker.team]])
    attacker.finalKill = true;
}

spawnDogTags(victim, attacker) {
  if(victim maps\mp\killstreaks\_killstreaks::isUsingHeliSniper()) {
    return;
  }

  victim_pers_team = victim.pers["team"];
  if(isDefined(level.dogtags[victim.guid])) {
    playFX(level.conf_fx["vanish"], level.dogtags[victim.guid].curOrigin);
    level.dogtags[victim.guid] notify("reset");
  } else {
    visuals[0] = spawn("script_model", (0, 0, 0));
    visuals[0] setModel(CONST_ENEMY_TAG_MODEL);
    visuals[1] = spawn("script_model", (0, 0, 0));
    visuals[1] setModel(CONST_FRIENDLY_TAG_MODEL);

    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);

    level.dogtags[victim.guid] = maps\mp\gametypes\_gameobjects::createUseObject("any", trigger, visuals, (0, 0, 16));

    _objective_delete(level.dogtags[victim.guid].teamObjIds["allies"]);
    _objective_delete(level.dogtags[victim.guid].teamObjIds["axis"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["allies"]);
    maps\mp\gametypes\_objpoints::deleteObjPoint(level.dogtags[victim.guid].objPoints["axis"]);

    level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::setUseTime(0);
    level.dogtags[victim.guid].onUse = ::onUse;
    level.dogtags[victim.guid].victim = victim;
    level.dogtags[victim.guid].victimTeam = victim_pers_team;

    level.dogtags[victim.guid].objId = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add(level.dogtags[victim.guid].objId, "invisible", (0, 0, 0));
    objective_icon(level.dogtags[victim.guid].objId, "waypoint_dogtags");

    level thread clearOnVictimDisconnect(victim);
    victim thread tagTeamUpdater(level.dogtags[victim.guid]);
  }

  pos = victim.origin + (0, 0, 14);
  level.dogtags[victim.guid].curOrigin = pos;
  level.dogtags[victim.guid].trigger.origin = pos;
  level.dogtags[victim.guid].visuals[0].origin = pos;
  level.dogtags[victim.guid].visuals[1].origin = pos;
  level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::initializeTagPathVariables();

  level.dogtags[victim.guid] maps\mp\gametypes\_gameobjects::allowUse("any");

  level.dogtags[victim.guid].visuals[0] thread showToTeam(level.dogtags[victim.guid], getOtherTeam(victim_pers_team));
  level.dogtags[victim.guid].visuals[1] thread showToTeam(level.dogtags[victim.guid], victim_pers_team);

  level.dogtags[victim.guid].attacker = attacker;

  if(IsPlayer(attacker)) {
    objective_position(level.dogtags[victim.guid].objId, pos);
    objective_state(level.dogtags[victim.guid].objId, "active");
    objective_player(level.dogtags[victim.guid].objId, attacker getEntityNumber());
  }

  playSoundAtPos(pos, "mp_killconfirm_tags_drop");
  level notify("new_tag_spawned", level.dogtags[victim.guid]);

  level.dogtags[victim.guid].visuals[0] ScriptModelPlayAnim("mp_dogtag_spin");
  level.dogtags[victim.guid].visuals[1] ScriptModelPlayAnim("mp_dogtag_spin");
}

showToTeam(gameObject, team) {
  gameObject endon("death");
  gameObject endon("reset");

  self hide();

  foreach(player in level.players) {
    if(player.team == team)
      self ShowToPlayer(player);

    if(player.team == "spectator" && team == "allies")
      self ShowToPlayer(player);
  }

  for(;;) {
    level waittill("joined_team");

    self hide();
    foreach(player in level.players) {
      if(player.team == team)
        self ShowToPlayer(player);

      if(player.team == "spectator" && team == "allies")
        self ShowToPlayer(player);

      if(gameObject.victimTeam == player.team && player == gameObject.attacker)
        objective_state(gameObject.objId, "invisible");
    }
  }
}

onUse(player) {
  if(isDefined(player.owner)) {
    player = player.owner;
  }

  player maps\mp\_events::giveObjectivePointStreaks();

  player_pers_team = player.pers["team"];
  if(player_pers_team == self.victimTeam) {
    self.trigger playSound("mp_killconfirm_tags_deny");

    player incPlayerStat("killsdenied", 1);
    player incPersStat("denied", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "denied", player.pers["denied"]);

    if(IsPlayer(player))
      player setExtraScore0(player.pers["confirmed"] + player.pers["denied"]);

    if(self.victim == player) {
      event = "tags_retrieved";
    } else {
      event = "kill_denied";
    }

    if(isDefined(self.attacker))
      self.attacker thread maps\mp\gametypes\_rank::xpEventPopup("kill_denied");

    player thread onPickup(event);

    player maps\mp\gametypes\_missions::processChallenge("ch_denier");
  } else {
    self.trigger playSound("mp_killconfirm_tags_pickup");

    event = "kill_confirmed";

    player incPlayerStat("killsconfirmed", 1);
    player incPersStat("confirmed", 1);
    player maps\mp\gametypes\_persistence::statSetChild("round", "confirmed", player.pers["confirmed"]);

    if(self.attacker != player)
      self.attacker thread onPickup(event);

    player onPickup(event);

    if(IsPlayer(player)) {
      player leaderDialogOnPlayer("kill_confirmed");
      player setExtraScore0(player.pers["confirmed"] + player.pers["denied"]);
    }

    player maps\mp\gametypes\_missions::processChallenge("ch_collector");

    player maps\mp\gametypes\_gamescore::giveTeamScoreForObjective(player_pers_team, 1);
  }

  self resetTags();
}

onPickup(event) {
  level endon("game_ended");
  selfendon("disconnect");

  while(!isDefined(self.pers))
    wait(0.05);

  self thread maps\mp\gametypes\_rank::xpEventPopup(event);
  maps\mp\gametypes\_gamescore::givePlayerScore(event, self, undefined, true);
  self thread maps\mp\gametypes\_rank::giveRankXP(event);
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
  objective_state(self.objId, "invisible");
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

    if(isDefined(level.dogtags[guid].attacker))
      level.dogtags[guid].attacker thread maps\mp\gametypes\_rank::xpEventPopup("kill_denied");

    playFX(level.conf_fx["vanish"], level.dogtags[guid].curOrigin);
    level.dogtags[guid] notify("reset");
    wait(0.05);

    if(isDefined(level.dogtags[guid])) {
      objective_delete(level.dogtags[guid].objId);
      level.dogtags[guid].trigger delete();
      for(i = 0; i < level.dogtags[guid].visuals.size; i++)
        level.dogtags[guid].visuals[i] delete();
      level.dogtags[guid] notify("deleted");

      level.dogtags[guid] = undefined;
    }
  }
}

initGametypeAwards() {}