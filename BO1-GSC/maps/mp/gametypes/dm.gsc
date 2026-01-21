/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dm.gsc
**************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();
  maps\mp\gametypes\_globallogic_utils::registerTimeLimitDvar(level.gameType, 10, 0, 1440);
  maps\mp\gametypes\_globallogic_utils::registerScoreLimitDvar(level.gameType, 1000, 0, 50000);
  maps\mp\gametypes\_globallogic_utils::registerRoundLimitDvar(level.gameType, 1, 0, 10);
  maps\mp\gametypes\_globallogic_utils::registerRoundWinLimitDvar(level.gameType, 0, 0, 10);
  maps\mp\gametypes\_globallogic_utils::registerNumLivesDvar(level.gameType, 0, 0, 10);
  maps\mp\gametypes\_weapons::registerGrenadeLauncherDudDvar(level.gameType, 10, 0, 1440);
  maps\mp\gametypes\_weapons::registerThrownGrenadeDudDvar(level.gameType, 0, 0, 1440);
  maps\mp\gametypes\_weapons::registerKillstreakDelay(level.gameType, 0, 0, 1440);
  maps\mp\gametypes\_globallogic::registerFriendlyFireDelay(level.gameType, 0, 0, 1440);
  level.scoreRoundBased = true;
  level.resetPlayerScoreEveryRound = true;
  level.onStartGameType = ::onStartGameType;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onSpawnPlayerUnified = ::onSpawnPlayerUnified;
  game["dialog"]["gametype"] = "ffa_start";
  game["dialog"]["gametype_hardcore"] = "hcffa_start";
  game["dialog"]["offense_obj"] = "generic_boost";
  game["dialog"]["defense_obj"] = "generic_boost";
  setscoreboardcolumns("kills", "deaths", "kdratio", "headshots");
}
onStartGameType() {
  setClientNameMode("auto_change");
  maps\mp\gametypes\_globallogic_ui::setObjectiveText("allies", &"OBJECTIVES_DM");
  maps\mp\gametypes\_globallogic_ui::setObjectiveText("axis", &"OBJECTIVES_DM");
  if(level.splitscreen) {
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("allies", &"OBJECTIVES_DM");
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("axis", &"OBJECTIVES_DM");
  } else {
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("allies", &"OBJECTIVES_DM_SCORE");
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("axis", &"OBJECTIVES_DM_SCORE");
  }
  maps\mp\gametypes\_globallogic_ui::setObjectiveHintText("allies", &"OBJECTIVES_DM_HINT");
  maps\mp\gametypes\_globallogic_ui::setObjectiveHintText("axis", &"OBJECTIVES_DM_HINT");
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");
  maps\mp\gametypes\_spawning::updateAllSpawnPoints();
  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
  spawnpoint = maps\mp\gametypes\_spawnlogic::getRandomIntermissionPoint();
  setDemoIntermissionPoint(spawnpoint.origin, spawnpoint.angles);
  level.useStartSpawns = false;
  allowed[0] = "dm";
  maps\mp\gametypes\_gameobjects::main(allowed);
  maps\mp\gametypes\_spawning::create_map_placed_influencers();
  maps\mp\gametypes\_rank::registerScoreInfo("kill", 50);
  maps\mp\gametypes\_rank::registerScoreInfo("headshot", 50);
  maps\mp\gametypes\_rank::registerScoreInfo("assist_75", 1);
  maps\mp\gametypes\_rank::registerScoreInfo("assist_50", 1);
  maps\mp\gametypes\_rank::registerScoreInfo("assist_25", 1);
  maps\mp\gametypes\_rank::registerScoreInfo("assist", 1);
  maps\mp\gametypes\_rank::registerScoreInfo("suicide", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("teamkill", 0);
  level.displayRoundEndText = false;
  level thread onScoreCloseMusic();
  if(!isOneRound()) {
    level.displayRoundEndText = true;
  }
}
onSpawnPlayerUnified() {
  maps\mp\gametypes\_spawning::onSpawnPlayer_Unified();
}
onSpawnPlayer() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
  spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_DM(spawnPoints);
  self spawn(spawnPoint.origin, spawnPoint.angles, "dm");
}
onEndGame(winningPlayer) {
  if(isDefined(winningPlayer) && isPlayer(winningPlayer))
    [[level._setPlayerScore]](winningPlayer, winningPlayer[[level._getPlayerScore]]() + 1);
}
onScoreCloseMusic() {
  while(!level.gameEnded) {
    scoreLimit = level.scoreLimit;
    scoreThreshold = scoreLimit * .9;
    for(i = 0; i < level.players.size; i++) {
      scoreCheck = [[level._getPlayerScore]](level.players[i]);
      if(scoreCheck >= scoreThreshold) {
        thread maps\mp\gametypes\_globallogic_audio::set_music_on_team("TIME_OUT", "both");
        thread maps\mp\gametypes\_globallogic_audio::actionMusicSet();
        return;
      }
    }
    wait(.5);
  }
}