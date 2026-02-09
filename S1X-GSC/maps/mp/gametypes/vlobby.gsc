/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\vlobby.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\agents\_scriptedAgents;

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  assert(getDvar("mapname") == getDvar("virtualLobbyMap"));

  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  level.rankedMatch = false;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onSpawnPlayer = ::onSpawnPlayer;

  registerNumLivesDvar(level.gameType, 0);
  registerTimeLimitDvar(level.gameType, 0);
  registerScoreLimitDvar(level.gameType, 1);
  registerHalfTimeDvar(level.gameType, 0);

  level.classOld = level.class;
  level.class = ::MenuClass;

  game["menu_team"] = "main";
  game["menu_class_allies"] = "main";
  game["menu_class_axis"] = "main";
  game["menu_changeclass_allies"] = "main";
  game["menu_changeclass_axis"] = "main";
  game["menu_changeclass"] = "menu_cac_assault";

  game["allies"] = "sentinel_vl";
  game["axis"] = "atlas";
}

MenuClass(response) {
  level.inGracePeriod = true;
  self.hasDoneCombat = false;
  [[level.classOld]](response);
}

onStartGameType() {
  setClientNameMode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = false;
  }

  setObjectiveText("allies", &"OBJECTIVES_WAR");
  setObjectiveText("axis", &"OBJECTIVES_WAR");

  setObjectiveScoreText("allies", &"OBJECTIVES_WAR");
  setObjectiveScoreText("axis", &"OBJECTIVES_WAR");

  setObjectiveHintText("allies", &"OBJECTIVES_WAR");
  setObjectiveHintText("axis", &"OBJECTIVES_WAR");

  init_spawns();

  allowed[0] = level.gameType;
  maps\mp\gametypes\_gameobjects::main(allowed);
  level.prematchPeriod = 0;
  level.prematchPeriodEnd = 0;
}

init_spawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_allies_start");
  maps\mp\gametypes\_spawnlogic::addStartSpawnPoints("mp_tdm_spawn_axis_start");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_tdm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_tdm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

getSpawnPoint(player_id) {
  if(!isDefined(player_id)) {
    player_id = 0;
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] == self) {
        player_id = i;
        break;
      }
    }
  }

  player_points = getEntArray("player_pos", "targetname");
  point = undefined;
  foreach(point in player_points) {
    if(point.script_noteworthy == "" + player_id) {
      break;
    }
  }
  if(!isDefined(point)) {
    point = player_points[0];
  }

  {
    self.avatar_spawnpoint = point;
  }
  return point;
}

onSpawnPlayer() {
  if(isDefined(level.vl_onSpawnPlayer)) {
    self[[level.vl_onSpawnPlayer]]();
  }
}