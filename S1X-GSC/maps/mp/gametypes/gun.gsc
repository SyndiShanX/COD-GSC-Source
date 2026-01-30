/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\gun.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_class;
#include common_scripts\utility;

main() {
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  setGuns();

  if(isUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerTimeLimitDvar(level.gameType, 10);
    SetDynamicDvar("scr_gun_scorelimit", level.gun_guns.size);
    registerScoreLimitDvar(level.gameType, level.gun_guns.size);
    level thread reInitializeScoreLimitOnMigration();
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 0);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_randomize = 0;
    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }
  setSpecialLoadout();

  level.teamBased = false;
  level.doPrematch = true;
  level.onStartGameType = ::onStartGameType;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onPlayerKilled = ::onPlayerKilled;
  level.onTimeLimit = ::onTimeLimit;
  level.onPlayerScore = ::onPlayerScore;
  level.bypassClassChoiceFunc = ::gunGameClass;
  level.assists_disabled = true;
  level.setBackLevel = getIntProperty("scr_setback_levels", 1);
  level.lastGunTimeVO = 0;

  if(level.matchRules_damageMultiplier) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  SetTeamMode("ffa");

  game["dialog"]["gametype"] = "gg_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  game["dialog"]["humiliation"] = "gg_humiliation";
  game["dialog"]["lastgun"] = "at_anr1_gg_lastgun";
}

initializeMatchRules() {
  setCommonRulesFromMatchRulesData(true);

  level.matchRules_randomize = GetMatchRulesData("gunData", "randomize");

  SetDynamicDvar("scr_gun_scorelimit", level.gun_guns.size);
  registerScoreLimitDvar(level.gameType, level.gun_guns.size);
  SetDynamicDvar("scr_gun_winlimit", 1);
  registerWinLimitDvar("gun", 1);
  SetDynamicDvar("scr_gun_roundlimit", 1);
  registerRoundLimitDvar("gun", 1);
  SetDynamicDvar("scr_gun_halftime", 0);
  registerHalfTimeDvar("gun", 0);

  SetDynamicDvar("scr_gun_playerrespawndelay", 0);
  SetDynamicDvar("scr_gun_waverespawndelay", 0);
  SetDynamicDvar("scr_player_forcerespawn", 1);
  SetDynamicDvar("scr_setback_levels", GetMatchRulesData("gunData", "setbackLevels"));
}

reInitializeScoreLimitOnMigration() {
  SetDynamicDvar("scr_gun_scorelimit", level.gun_guns.size);
  registerScoreLimitDvar(level.gameType, level.gun_guns.size);
}

onStartGameType() {
  setClientNameMode("auto_change");

  setObjectiveText("allies", &"OBJECTIVES_DM");
  setObjectiveText("axis", &"OBJECTIVES_DM");

  if(level.splitscreen) {
    setObjectiveScoreText("allies", &"OBJECTIVES_DM");
    setObjectiveScoreText("axis", &"OBJECTIVES_DM");
  } else {
    setObjectiveScoreText("allies", &"OBJECTIVES_DM_SCORE");
    setObjectiveScoreText("axis", &"OBJECTIVES_DM_SCORE");
  }
  setObjectiveHintText("allies", &"OBJECTIVES_DM_HINT");
  setObjectiveHintText("axis", &"OBJECTIVES_DM_HINT");

  initSpawns();

  allowed = [];
  maps\mp\gametypes\_gameobjects::main(allowed);

  level.QuickMessageToAll = true;
  level.blockWeaponDrops = true;

  level thread onPlayerConnect();
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  setMapCenter(level.mapCenter);
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player.gunGameGunIndex = 0;
    player.gunGamePrevGunIndex = 0;
    player.stabs = 0;
    player.mySetBacks = 0;
    player.lastLevelUpTime = 0;
    player.showSetBackSplash = false;

    if(level.matchRules_randomize) {
      player.gunList = array_randomize(level.gun_guns);
    }

    player thread refillAmmo();
    player thread refillSingleCountAmmo();
  }
}

getSpawnPoint() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
  if(level.inGracePeriod) {
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
  } else {
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_FreeForAll(spawnPoints);
  }

  self maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(spawnpoint);

  return spawnPoint;
}

gunGameClass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.gun_loadout;
  self.class = self.pers["class"];
  self.lastClass = self.pers["lastClass"];

  self loadweapons(level.gun_guns[0]);
}

onSpawnPlayer() {
  self thread waitLoadoutDone();
}

waitLoadoutDone() {
  level endon("game_ended");
  self endon("disconnect");

  level waittill("player_spawned");

  self giveNextGun(true);

  if(self.showSetBackSplash) {
    self.showSetBackSplash = false;
    self thread maps\mp\_events::decreaseGunLevelEvent();
  }
}

onPlayerScore(event, player, victim) {
  if(event == "gained_gun_score") {
    score = maps\mp\gametypes\_rank::getScoreInfoValue(event);
    player setExtraScore0(player.extrascore0 + score);
    player maps\mp\gametypes\_gamescore::updateScoreStatsFFA(player, score);

    return 1;
  }

  if(event == "dropped_gun_score") {
    scoreLoss = min(level.setBackLevel, self.score);
    return int(scoreLoss * -1);
  }

  return 0;
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, lifeId) {
  if(!isDefined(attacker)) {
    return;
  }

  if((sMeansOfDeath == "MOD_TRIGGER_HURT") && !IsPlayer(attacker)) {
    attacker = self;
  }

  if(sMeansOfDeath == "MOD_FALLING" || IsPlayer(attacker)) {
    if((sMeansOfDeath == "MOD_FALLING") || (attacker == self) || (isMeleeMOD(sMeansOfDeath) && (sWeapon != "riotshield_mp")) || (sWeapon == "boost_slam_mp")) {
      self playLocalSound("mp_war_objective_lost");

      self.gunGamePrevGunIndex = self.gunGameGunIndex;
      self.gunGameGunIndex = int(max(0, self.gunGameGunIndex - level.setBackLevel));

      if(self.gunGamePrevGunIndex > self.gunGameGunIndex) {
        self.mySetBacks++;
        self setExtraScore1(self.mySetBacks);
        self.showSetBackSplash = true;

        if(isMeleeMOD(sMeansOfDeath)) {
          attacker.stabs++;
          attacker.assists = attacker.stabs;
          attacker thread maps\mp\_events::setBackEnemyGunLevelEvent();

          if(self.gunGamePrevGunIndex == level.gun_guns.size - 1) {
            attacker thread maps\mp\_events::setBackFirstPlayerGunLevelEvent();
            attacker leaderDialogOnPlayer("humiliation", "status");
          }
        }
      }
    } else if((sMeansOfDeath == "MOD_PISTOL_BULLET") || (sMeansOfDeath == "MOD_RIFLE_BULLET") || (sMeansOfDeath == "MOD_HEAD_SHOT") ||
      (sMeansOfDeath == "MOD_PROJECTILE") || (sMeansOfDeath == "MOD_PROJECTILE_SPLASH") || (sMeansOfDeath == "MOD_EXPLOSIVE") ||
      (sMeansOfDeath == "MOD_IMPACT") || (sMeansOfDeath == "MOD_GRENADE") || (sMeansOfDeath == "MOD_GRENADE_SPLASH") ||
      (isMeleeMOD(sMeansOfDeath) && sWeapon == "riotshield_mp")) {
      sWeapon = getBaseWeaponName(sWeapon);

      if(!IsSubStr(attacker.primaryWeapon, sWeapon)) {
        return;
      }

      if((attacker.lastLevelUpTime + 3000) > GetTime()) {
        attacker thread maps\mp\_events::quickGunLevelEvent();
      }

      attacker.lastLevelUpTime = GetTime();
      attacker.gunGamePrevGunIndex = attacker.gunGameGunIndex;
      attacker.gunGameGunIndex++;

      attacker thread maps\mp\_events::increaseGunLevelEvent();

      if(attacker.gunGameGunIndex == level.gun_guns.size - 1) {
        playSoundOnPlayers("mp_enemy_obj_captured");
        level thread teamPlayerCardSplash("callout_top_gun_rank", attacker);

        currentTime = GetTime();

        if((level.lastGunTimeVO + 4500) < currentTime) {
          level thread leaderDialogOnPlayers("lastgun", level.players, "status");
          level.lastGunTimeVO = currentTime;
        }
      }

      if(attacker.gunGameGunIndex < level.gun_guns.size) {
        attacker giveNextGun();
      }
    }
  }
}

giveNextGun(doSetSpawnWeapon) {
  self endon("disconnect");

  newWeapon = getNextGun();
  self.gun_curGun = newWeapon;

  newWeapon = addAttachments(newWeapon);

  while(!self LoadWeapons(newWeapon)) {
    waitframe;
  }

  self takeAllWeapons();
  _giveWeapon(newWeapon);

  if(isDefined(doSetSpawnWeapon)) {
    self setSpawnWeapon(newWeapon);
  }

  weaponName = getBaseWeaponName(newWeapon);

  self.pers["primaryWeapon"] = weaponName;
  self.primaryWeapon = newWeapon;

  self GiveStartAmmo(newWeapon);
  self switchToWeapon(newWeapon);

  self.gunGamePrevGunIndex = self.gunGameGunIndex;
}

getNextGun() {
  weaponList = level.gun_guns;
  weaponsToStream = [];
  newWeapon = undefined;

  if(level.matchRules_randomize) {
    weaponList = self.gunList;
  }

  newWeapon = weaponList[self.gunGameGunIndex];
  weaponsToStream[weaponsToStream.size] = newWeapon;

  if((self.gunGameGunIndex + 1) < weaponList.size) {
    weaponsToStream[weaponsToStream.size] = weaponList[self.gunGameGunIndex + 1];
  }

  if(self.gunGameGunIndex > 0) {
    weaponsToStream[weaponsToStream.size] = weaponList[self.gunGameGunIndex - 1];
  }

  self LoadWeapons(weaponsToStream);

  return newWeapon;
}

addAttachments(weaponName) {
  fullWeaponName = buildWeaponName(weaponName, "none", "none", "none", 0, 0);

  return fullWeaponName;
}

onTimeLimit() {
  level.finalKillCam_winner = "none";
  winners = getHighestProgressedPlayers();

  if(!isDefined(winners) || !winners.size) {
    thread maps\mp\gametypes\_gamelogic::endGame("tie", game["end_reason"]["time_limit_reached"]);
  } else if(winners.size == 1) {
    thread maps\mp\gametypes\_gamelogic::endGame(winners[0], game["end_reason"]["time_limit_reached"]);
  } else {
    if(winners[winners.size - 1].gunGameGunIndex > winners[winners.size - 2].gunGameGunIndex) {
      thread maps\mp\gametypes\_gamelogic::endGame(winners[winners.size - 1], game["end_reason"]["time_limit_reached"]);
    } else {
      thread maps\mp\gametypes\_gamelogic::endGame("tie", game["end_reason"]["time_limit_reached"]);
    }
  }
}

getHighestProgressedPlayers() {
  highestProgress = -1;
  highestProgressedPlayers = [];
  foreach(player in level.players) {
    if(isDefined(player.gunGameGunIndex) && player.gunGameGunIndex >= highestProgress) {
      highestProgress = player.gunGameGunIndex;
      highestProgressedPlayers[highestProgressedPlayers.size] = player;
    }
  }
  return highestProgressedPlayers;
}

refillAmmo() {
  level endon("game_ended");
  selfendon("disconnect");

  while(true) {
    self waittill("reload");
    self GiveStartAmmo(self.primaryWeapon);
  }
}

refillSingleCountAmmo() {
  level endon("game_ended");
  selfendon("disconnect");

  while(true) {
    if(isReallyAlive(self) && self.team != "spectator" && isDefined(self.primaryWeapon) && self getAmmoCount(self.primaryWeapon) == 0) {
      wait(2);
      self notify("reload");
      wait(1);
    } else {
      wait(0.05);
    }
  }
}

setGuns() {
  level.gun_guns = [];

  level.gun_guns[0] = "iw5_pbw";
  level.gun_guns[1] = "iw5_vbr";
  level.gun_guns[2] = "iw5_uts19";
  level.gun_guns[3] = "iw5_maul";
  level.gun_guns[4] = "iw5_sac3";
  level.gun_guns[5] = "iw5_asm1";
  level.gun_guns[6] = "iw5_hbra3";
  level.gun_guns[7] = "iw5_m182spr";
  level.gun_guns[8] = "iw5_mors";
  level.gun_guns[9] = "iw5_mahem";
  level.gun_guns[10] = "iw5_bal27";
  level.gun_guns[11] = "iw5_em1";
  level.gun_guns[12] = "iw5_epm3";
  level.gun_guns[13] = "iw5_asaw";
  level.gun_guns[15] = "iw5_lsat";
  level.gun_guns[14] = "iw5_rw1";
  level.gun_guns[16] = "iw5_exoxmg";
  level.gun_guns[17] = "iw5_himar";
  level.gun_guns[18] = "iw5_thor";
  level.gun_guns[19] = "iw5_exocrossbow";

  if(!isUsingMatchRulesData()) {
    return;
  }

  closeQuarters[0] = "iw5_titan45";
  closeQuarters[1] = "iw5_pbw";
  closeQuarters[2] = "iw5_vbr";
  closeQuarters[3] = "iw5_rw1";
  closeQuarters[4] = "iw5_maul";
  closeQuarters[5] = "iw5_uts19";
  closeQuarters[6] = "iw5_rhino";
  closeQuarters[7] = "iw5_sac3";
  closeQuarters[8] = "iw5_exoxmg";
  closeQuarters[9] = "iw5_kf5";
  closeQuarters[10] = "iw5_sn6";
  closeQuarters[11] = "iw5_hmr9";
  closeQuarters[12] = "iw5_mp11";
  closeQuarters[13] = "iw5_asm1";
  closeQuarters[14] = "iw5_ak12";
  closeQuarters[15] = "iw5_bal27";
  closeQuarters[16] = "iw5_hbra3";
  closeQuarters[17] = "iw5_microdronelauncher";
  closeQuarters[18] = "iw5_mahem";
  closeQuarters[19] = "iw5_exocrossbow";

  marksman[0] = "iw5_titan45";
  marksman[1] = "iw5_pbw";
  marksman[2] = "iw5_vbr";
  marksman[3] = "iw5_rw1";
  marksman[4] = "iw5_ak12";
  marksman[5] = "iw5_bal27";
  marksman[6] = "iw5_hbra3";
  marksman[7] = "iw5_himar";
  marksman[8] = "iw5_arx160";
  marksman[9] = "iw5_m182spr";
  marksman[10] = "iw5_asaw";
  marksman[11] = "iw5_lsat";
  marksman[12] = "iw5_em1";
  marksman[13] = "iw5_epm3";
  marksman[14] = "iw5_mors";
  marksman[15] = "iw5_gm6";
  marksman[16] = "iw5_thor";
  marksman[17] = "iw5_m990";
  marksman[18] = "iw5_mahem";
  marksman[19] = "iw5_exocrossbow";

  progression = GetMatchRulesData("gunData", "progression");

  switch (progression) {
    case 1:
      level.gun_guns = closeQuarters;
      break;
    case 2:
      level.gun_guns = marksman;
      break;
    case 3:
      for(i = 0; i < level.gun_guns.size; i++) {
        level.gun_guns[i] = closeQuarters[i];

        if(cointoss()) {
          level.gun_guns[i] = marksman[i];
        }
      }
      break;
  }
}

setSpecialLoadout() {
  level.gun_loadout = getEmptyLoadout();

  if(isValidPrimary(level.gun_guns[0])) {
    level.gun_loadout["loadoutPrimary"] = level.gun_guns[0];
  } else if(isValidSecondary(level.gun_guns[0], false)) {
    level.gun_loadout["loadoutSecondary"] = level.gun_guns[0];
  }
}