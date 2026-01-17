/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\hlnd.gsc
**************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();
  maps\mp\gametypes\_globallogic_utils::registerTimeLimitDvar(level.gameType, 5, 0, 1440);
  maps\mp\gametypes\_globallogic_utils::registerScoreLimitDvar(level.gameType, 0, 0, 5000);
  maps\mp\gametypes\_globallogic_utils::registerRoundLimitDvar(level.gameType, 1, 0, 10);
  maps\mp\gametypes\_globallogic_utils::registerRoundWinLimitDvar(level.gameType, 0, 0, 10);
  maps\mp\gametypes\_globallogic_utils::registerNumLivesDvar(level.gameType, 0, 0, 10);
  level.onStartGameType = ::onStartGameType;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onSpawnPlayerUnified = ::onSpawnPlayerUnified;
  level.onPlayerDamage = ::onPlayerDamage;
  level.onPlayerKilled = ::onPlayerKilled;
  level.onWagerAwards = ::onWagerAwards;
  game["dialog"]["gametype"] = "sstones_start";
  game["dialog"]["wm_humiliation"] = "boost_gen_08";
  game["dialog"]["wm_humiliated"] = "sstones_bank_00";
  level.giveCustomLoadout = ::giveCustomLoadout;
  PrecacheString(&"MP_HUMILIATION");
  PrecacheString(&"MP_HUMILIATED");
  PrecacheString(&"MP_BANKRUPTED");
  PrecacheString(&"MP_BANKRUPTED_OTHER");
  PrecacheShader("hud_acoustic_sensor");
  PrecacheShader("hud_us_stungrenade");
  setscoreboardcolumns("kills", "deaths", "tomahawks", "humiliated");
}
giveCustomLoadout() {
  self notify("hlnd_spectator_hud");
  self maps\mp\gametypes\_wager::setupBlankRandomPlayer();
  defaultWeapon = "crossbow_explosive_mp";
  self giveWeapon(defaultWeapon);
  self SetWeaponAmmoClip(defaultWeapon, 1);
  self SetWeaponAmmoStock(defaultWeapon, 3);
  secondaryWeapon = "knife_ballistic_mp";
  self giveWeapon(secondaryWeapon);
  self SetWeaponAmmoStock(secondaryWeapon, 2);
  offhandPrimary = "hatchet_mp";
  self setOffhandPrimaryClass(offhandPrimary);
  self giveWeapon(offhandPrimary);
  self SetWeaponAmmoClip(offhandPrimary, 1);
  self SetWeaponAmmoStock(offhandPrimary, 1);
  self giveWeapon("knife_mp");
  self switchToWeapon(defaultWeapon);
  self setSpawnWeapon(defaultWeapon);
  self.pers["hasRadar"] = true;
  self.hasSpyplane = true;
  return defaultWeapon;
}
onPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  if((sWeapon == "crossbow_explosive_mp") && (sMeansOfDeath == "MOD_IMPACT")) {
    if(isDefined(eAttacker) && IsPlayer(eAttacker)) {
      if(!isDefined(eAttacker.pers["sticks"]))
        eAttacker.pers["sticks"] = 1;
      else
        eAttacker.pers["sticks"]++;
      eAttacker.sticks = eAttacker.pers["sticks"];
    }
  }
  return iDamage;
}
onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration) {
  if(isDefined(attacker) && IsPlayer(attacker) && attacker != self) {
    if(sMeansOfDeath == "MOD_MELEE") {
      attacker thread maps\mp\gametypes\_globallogic_score::givePlayerScore("melee_kill", attacker, self);
    } else if(sWeapon == "hatchet_mp") {
      self.pers["humiliated"]++;
      self.humiliated = self.pers["humiliated"];
      attacker thread maps\mp\gametypes\_globallogic_score::givePlayerScore("hatchet_kill", attacker, self);
      maps\mp\gametypes\_globallogic_score::_setPlayerScore(self, 0);
      self thread maps\mp\gametypes\_wager::queueWagerPopup(&"MP_HUMILIATED", 0, &"MP_BANKRUPTED", "wm_humiliated");
      attacker thread maps\mp\gametypes\_wager::queueWagerPopup(&"MP_HUMILIATION", 0, &"MP_BANKRUPTED_OTHER", "wm_humiliation");
    } else {
      attacker thread maps\mp\gametypes\_globallogic_score::givePlayerScore("other_kill", attacker, self);
    }
  } else {
    self.pers["humiliated"]++;
    self.humiliated = self.pers["humiliated"];
    maps\mp\gametypes\_globallogic_score::_setPlayerScore(self, 0);
    self thread maps\mp\gametypes\_wager::queueWagerPopup(&"MP_HUMILIATED", 0, &"MP_BANKRUPTED", "wm_humiliated");
  }
}
onStartGameType() {
  setDvar("scr_disable_cac", 1);
  makedvarserverinfo("scr_disable_cac", 1);
  setDvar("scr_disable_weapondrop", 1);
  setDvar("ui_allow_teamchange", 0);
  setDvar("scr_xpscale", 0);
  makedvarserverinfo("ui_allow_teamchange", 0);
  setClientNameMode("auto_change");
  maps\mp\gametypes\_globallogic_ui::setObjectiveText("allies", &"OBJECTIVES_HLND");
  maps\mp\gametypes\_globallogic_ui::setObjectiveText("axis", &"OBJECTIVES_HLND");
  if(level.splitscreen) {
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("allies", &"OBJECTIVES_HLND");
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("axis", &"OBJECTIVES_HLND");
  } else {
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("allies", &"OBJECTIVES_HLND_SCORE");
    maps\mp\gametypes\_globallogic_ui::setObjectiveScoreText("axis", &"OBJECTIVES_HLND_SCORE");
  }
  maps\mp\gametypes\_globallogic_ui::setObjectiveHintText("allies", &"OBJECTIVES_HLND_HINT");
  maps\mp\gametypes\_globallogic_ui::setObjectiveHintText("axis", &"OBJECTIVES_HLND_HINT");
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);
  newSpawns = getEntArray("mp_wager_spawn", "classname");
  if(newSpawns.size > 0) {
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_wager_spawn");
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_wager_spawn");
  } else {
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
    maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");
  }
  maps\mp\gametypes\_spawning::updateAllSpawnPoints();
  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
  spawnpoint = maps\mp\gametypes\_spawnlogic::getRandomIntermissionPoint();
  setDemoIntermissionPoint(spawnpoint.origin, spawnpoint.angles);
  level.useStartSpawns = false;
  allowed[0] = "hlnd";
  maps\mp\gametypes\_gameobjects::main(allowed);
  maps\mp\gametypes\_spawning::create_map_placed_influencers();
  maps\mp\gametypes\_rank::registerScoreInfo("kill", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("hatchet_kill", 10);
  maps\mp\gametypes\_rank::registerScoreInfo("melee_kill", 25);
  maps\mp\gametypes\_rank::registerScoreInfo("other_kill", 100);
  maps\mp\gametypes\_rank::registerScoreInfo("headshot", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("assist_75", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("assist_50", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("assist_25", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("assist", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("suicide", 0);
  maps\mp\gametypes\_rank::registerScoreInfo("teamkill", 0);
  level.displayRoundEndText = false;
  if(isDefined(game["roundsplayed"]) && game["roundsplayed"] > 0) {
    game["dialog"]["gametype"] = undefined;
    game["dialog"]["offense_obj"] = undefined;
    game["dialog"]["defense_obj"] = undefined;
  }
}
onSpawnPlayerUnified() {
  maps\mp\gametypes\_spawning::onSpawnPlayer_Unified();
}
onSpawnPlayer() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
  spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_DM(spawnPoints);
  self spawn(spawnPoint.origin, spawnPoint.angles, "hlnd");
}
onWagerAwards() {
  tomahawks = self maps\mp\gametypes\_globallogic_score::getPersStat("tomahawks");
  if(!isDefined(tomahawks))
    tomahawks = 0;
  self maps\mp\gametypes\_persistence::setAfterActionReportStat("wagerAwards", tomahawks, 0);
  sticks = self maps\mp\gametypes\_globallogic_score::getPersStat("sticks");
  if(!isDefined(sticks))
    sticks = 0;
  self maps\mp\gametypes\_persistence::setAfterActionReportStat("wagerAwards", sticks, 1);
  bestKillstreak = self maps\mp\gametypes\_globallogic_score::getPersStat("best_kill_streak");
  if(!isDefined(bestKillstreak))
    bestKillstreak = 0;
  self maps\mp\gametypes\_persistence::setAfterActionReportStat("wagerAwards", bestKillstreak, 2);
}