/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_events.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  gameType = GetDvar("g_gametype");
  gameTypeRow = 0;

  gameTypeColumn = [];
  gameTypeColumn["dm"] = 4;
  gameTypeColumn["war"] = 5;
  gameTypeColumn["sd"] = 6;
  gameTypeColumn["dom"] = 7;
  gameTypeColumn["conf"] = 8;
  gameTypeColumn["sr"] = 9;
  gameTypeColumn["infect"] = 10;
  gameTypeColumn["gun"] = 11;
  gameTypeColumn["ctf"] = 12;
  gameTypeColumn["horde"] = 13;
  gameTypeColumn["twar"] = 14;
  gameTypeColumn["hp"] = 15;
  gameTypeColumn["ball"] = 16;

  while(true) {
    if(!isDefined(gameTypeColumn[gameType])) {
      gameType = "war";
    }

    name = TableLookupByRow("mp/xp_event_table.csv", gameTypeRow, 0);
    playSplash = TableLookupByRow("mp/xp_event_table.csv", gameTypeRow, 1);
    allowPlayerScore = TableLookupByRow("mp/xp_event_table.csv", gameTypeRow, 2);
    value = TableLookupByRow("mp/xp_event_table.csv", gameTypeRow, gameTypeColumn[gameType]);

    if(!isDefined(name) || name == "") {
      break;
    }

    if(name == "win" || name == "loss" || name == "tie") {
      value = float(value);
    } else {
      value = int(value);
    }

    if(value != -1) {
      allowPlayerScore = int(allowPlayerScore);
      playSplash = int(playSplash);
      maps\mp\gametypes\_rank::registerXPEventInfo(name, value, allowPlayerScore, playSplash);
    }

    gameTypeRow++;
  }

  level.numKills = 0;
  level thread onPlayerConnect();
}

onPlayerConnect() {
  while(true) {
    level waittill("connected", player);

    player.killedPlayers = [];
    player.killedPlayersCurrent = [];
    player.damagedPlayers = [];
    player.killedBy = [];
    player.lastKilledBy = undefined;
    player.recentKillCount = 0;
    player.lastKillTime = 0;
    player.bulletStreak = 0;
    player.lastCoopStreakTime = 0;
  }
}

killedPlayer(killId, victim, weapon, meansOfDeath, eInflictor) {
  level.numKills++;

  victimGuid = victim.guid;
  victimKillStreak = victim.pers["cur_kill_streak"];
  myGuid = self.guid;
  curTime = getTime();

  if(isBulletDamage(meansOfDeath)) {
    if(self.lastKillTime == curTime) {
      self.bulletStreak++;
    } else {
      self.bulletStreak = 1;
    }
  } else {
    self.bulletStreak = 0;
  }

  self.lastKillTime = getTime();
  self.lastKilledPlayer = victim;
  self.modifiers = [];
  self.damagedPlayers[victimGuid] = undefined;

  self thread updateRecentKills(killId, weapon);

  if(!isKillstreakWeapon(weapon)) {
    if(weapon == "none") {
      return false;
    }

    if(isDefined(victim.throwingGrenade)) {
      shortGrenade = maps\mp\_utility::strip_suffix(victim.throwingGrenade, "_lefthand");

      if(shortGrenade == "frag_grenade_mp") {
        self.modifiers["cooking"] = true;
      }
    }

    if(WeaponInventoryType(weapon) == "primary") {
      self.segments["killDistanceTotal"] += Distance2D(self.origin, victim.origin);
      self.segments["killDistanceCount"]++;
    }

    if(meansOfDeath == "MOD_HEAD_SHOT") {
      self headShotEvent(killId, weapon, meansOfDeath);
    }

    if(level.numKills == 1) {
      self firstBloodEvent(killId, weapon, meansOfDeath);
    }

    if(level.teamBased && ((curTime - victim.lastKillTime) < 3000) && (victim.lastkilledplayer != self)) {
      self avengedPlayerEvent(killId, weapon, meansOfDeath);
    }

    if(!isAlive(self) && (self != victim) && isDefined(self.deathtime) && ((self.deathtime + 1200) < getTime())) {
      self postDeathKillEvent(killId);
    }

    if(self.pers["cur_death_streak"] > 3) {
      self comeBackEvent(killId, weapon, meansOfDeath);
    }

    if(isDefined(self.assistedSuicide) && self.assistedSuicide) {
      self assistedSuicideEvent(killId, weapon, meansOfDeath);
    }

    if(isLongShot(self, weapon, meansOfDeath, victim)) {
      self longShotEvent(killId, weapon, meansOfDeath);
    }

    if(isResuce(victim, curTime)) {
      self defendedPlayerEvent(killId, weapon, meansOfDeath);
    }

    if((victimKillStreak > 0) && isBuzzKillEvent(victim)) {
      self buzzKillEvent(killId, victim, weapon, meansOfDeath);
    }

    if(isOneShotKill(victim, weapon, meansOfDeath)) {
      self oneShotKillEvent(killId, weapon, meansOfDeath);
    }

    if(isDefined(self.lastKilledBy) && (self.lastKilledBy == victim)) {
      self revengeEvent(killId);
    }

    if(victim.iDFlags &level.iDFLAGS_PENETRATION) {
      self bulletPenetrationEvent(killId, weapon);
    }

    if(isPointBlank(victim, meansOfDeath)) {
      self pointBlankEvent(killId, weapon, meansOfDeath);
    }

    if(isDefined(weapon) && (weapon == "boost_slam_mp")) {
      self boostSlamKillEvent(killId, weapon, meansOfDeath);
    }

    if(self.health < 20 && self.health > 0) {
      self nearDeathKillEvent(weapon, meansOfDeath);
    }

    if(self.isSiliding) {
      self sprintSlideKillEvent(weapon, meansOfDeath);
      self camoSprintSlideKillEvent(weapon, meansOfDeath);
    }

    if(self isFlashed()) {
      self flashedKillEvent(weapon, meansOfDeath);
    }

    if(isThinkFast(weapon, meansOfDeath)) {
      self thinkFastEvent();
    }

    if(self.bulletStreak == 2) {
      self multiKillOneBulletEvent();
    }

    if(isBackStabEvent(victim, weapon, meansOfDeath)) {
      self backStabEvent();
    }

    if(isThrowBackEvent(victim, weapon, meansOfDeath)) {
      self throwBackKillEvent();
    }

    if(isDefined(self.pickedUpWeaponFrom[weapon]) && (self.pickedUpWeaponFrom[weapon] == victim) && !isMeleeMOD(meansOfDeath)) {
      self takeAndKillEvent();
    }

    if(isDefined(weapon) && (weapon == "iw5_carrydrone_mp")) {
      self killWithBallEvent();
    }

    if(isDefined(victim) && victim _hasPerk("specialty_ballcarrier")) {
      self killedBallCarrierEvent();
    }

    if(isDefined(self.exoMostRecentTimeDeciSeconds["exo_dodge"]) && (20 > (getTimePassedDeciSecondsIncludingRounds() - self.exoMostRecentTimeDeciSeconds["exo_dodge"]))) {
      self killAfterDodgeEvent(weapon);
    }

    self checkHighJumpEvents(victim, killId, weapon, meansOfDeath, eInflictor);
    self checkHigherRankKillEvents(victim);
    self checkWeaponSpecificKill(victim, weapon, meansOfDeath);
  }

  self checkStreakingEvents(victim);

  if(!isDefined(self.killedPlayers[victimGuid])) {
    self.killedPlayers[victimGuid] = 0;
  }

  if(!isDefined(self.killedPlayersCurrent[victimGuid])) {
    self.killedPlayersCurrent[victimGuid] = 0;
  }

  if(!isDefined(victim.killedBy[myGuid])) {
    victim.killedBy[myGuid] = 0;
  }

  self.killedPlayers[victimGuid]++;
  self.killedPlayersCurrent[victimGuid]++;

  victim.killedBy[myGuid]++;
  victim.lastKilledBy = self;
}

isPointBlank(victim, meansOfDeath) {
  if(isBulletDamage(meansOfDeath)) {
    attackerPosition = self.origin;
    weapDistSq = 96 * 96;

    if(isDefined(victim.attackerPosition)) {
      attackerPosition = victim.attackerPosition;
    }

    if(DistanceSquared(attackerPosition, victim.origin) < weapDistSq) {
      return true;
    }
  }

  return false;
}

pointBlankEvent(killId, weapon, meansOfDeath) {
  self incPlayerStat("pointblank", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("pointblank", self, weapon, undefined, meansOfDeath);

  if(isDefined(weapon)) {
    baseWeapon = getBaseWeaponName(weapon);
    if(isLootWeapon(baseWeapon)) {
      baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
    }
    weaponClass = self maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);

    if(isDefined(level.challengeInfo["ch_pointblank_" + baseWeapon])) {
      self maps\mp\gametypes\_missions::processChallenge("ch_pointblank_" + baseWeapon);
    }
  }
}

killedPlayerEvent(victim, weapon, sMeansOfDeath) {
  self incPlayerStat("kills", 1);
  self incPersStat("kills", 1);
  self.kills = self getPersStat("kills");
  self maps\mp\gametypes\_persistence::statSetChild("round", "kills", self.kills);
  self updatePersRatio("kdRatio", "kills", "deaths");

  event = "kill";

  switch (weapon) {
    case "killstreak_orbital_laser_mp":
    case "orbital_laser_fov_mp":
      event = "vulcan_kill";
      break;
    case "warbird_remote_turret_mp":
    case "warbird_player_turret_mp":
    case "warbird_missile_mp":
    case "paint_missile_killstreak_mp":
      event = "warbird_kill";
      break;
    case "orbitalsupport_105mm_mp":
    case "orbitalsupport_40mm_mp":
    case "orbitalsupport_40mmbuddy_mp":
    case "orbitalsupport_big_turret_mp":
    case "orbitalsupport_medium_turret_mp":
    case "orbitalsupport_small_turret_mp":
    case "orbitalsupport_missile_mp":
      event = "paladin_kill";
      break;
    case "airdrop_trap_explosive_mp":
      event = "airdrop_trap_kill";
      break;
    case "orbital_carepackage_pod_mp":
      event = "airdrop_kill";
      break;
    case "remotemissile_projectile_mp":
    case "remotemissile_projectile_gas_mp":
    case "remotemissile_projectile_cluster_parent_mp":
    case "remotemissile_projectile_cluster_child_mp":
    case "remotemissile_projectile_cluster_child_hellfire_mp":
    case "remotemissile_projectile_secondary_mp":
    case "killstreak_strike_missile_gas_mp":
      event = "missile_strike_kill";
      break;
    case "remote_turret_mp":
    case "remote_energy_turret_mp":
    case "sentry_minigun_mp":
    case "killstreakmahem_mp":
    case "turretheadmg_mp":
    case "turretheadenergy_mp":
    case "turretheadrocket_mp":
      event = "sentry_gun_kill";
      break;
    case "stealth_bomb_mp":
    case "airstrike_missile_mp":
    case "orbital_carepackage_pod_plane_mp":
      event = "strafing_run_kill";
      break;
    case "drone_assault_remote_turret_mp":
    case "ugv_missile_mp":
    case "assaultdrone_c4_mp":
      event = "assault_drone_kill";
      break;
    case "juggernaut_sentry_mg_mp":
    case "iw5_juggernautrockets_mp":
    case "iw5_exoxmgjugg_mp_akimbo":
    case "iw5_juggtitan45_mp":
    case "iw5_exominigun_mp":
    case "iw5_mechpunch_mp":
    case "playermech_rocket_mp":
    case "killstreak_goliathsd_mp":
    case "orbital_carepackage_droppod_mp":
      event = "goliath_kill";
      break;
    case "detroit_tram_turret_mp":
    case "dam_turret_mp":
    case "killstreak_terrace_mp":
    case "killstreak_solar_mp":
    case "refraction_turret_mp":
    case "killstreak_comeback_mp":
    case "mp_laser2_core":
      event = "map_killstreak_kill";
      break;
  }

  if(event != "kill") {
    self incPlayerStat(event, 1);
    self maps\mp\gametypes\_missions::ch_streak_kill(event);
  }

  if(level.practiceRound) {
    self thread practiceRoundKillEvent(victim, event, weapon, sMeansOfDeath);
  }

  level thread maps\mp\gametypes\_rank::awardGameEvent(event, self, weapon, victim, sMeansOfDeath);
}

practiceRoundDialogValid() {
  return (!isDefined(self.next_pr_dialog_time) || GetTime() > self.next_pr_dialog_time);
}

practiceRoundDialogPlayed() {
  self.next_pr_dialog_time = GetTime() + RandomIntRange(20000, 40000);
}

practiceRoundKillEvent(victim, event, weapon, sMeansOfDeath) {
  self endon("disconnect");
  level endon("game_ended");

  if(IsBot(self)) {
    return;
  }

  self playlocalsound("ui_practice_round_kill");

  dialog_delay = 0.5;

  if(!isDefined(self.best_pr_kills)) {
    self.best_pr_kills = self GetCommonPlayerData("bests", "kills");
  }

  if((self.best_pr_kills > 0) && (self.kills > self.best_pr_kills)) {
    self practiceRoundDialogPlayed();
    wait(dialog_delay);
    self leaderDialogOnPlayer("ptr_new_best");
    self.best_pr_kills = 0;
  } else if(event == "kill" && !isMeleeMOD(sMeansOfDeath)) {
    if(sMeansOfDeath == "MOD_HEAD_SHOT") {
      self practiceRoundDialogPlayed();
      wait(dialog_delay);
      self leaderDialogOnPlayer("ptr_headshot");
    } else {
      if(!practiceRoundDialogValid()) {
        return;
      }

      practiceRoundDialogPlayed();
      wait(dialog_delay);
      self leaderDialogOnPlayer("ptr_greatshot");
    }
  }
}

practiceRoundAssistEvent(victim) {
  self endon("disconnect");
  level endon("game_ended");

  if(IsBot(self)) {
    return;
  }

  dialog_delay = 0.5;

  practiceRoundDialogPlayed();
  wait(dialog_delay);
  self leaderDialogOnPlayer("ptr_assist");
}

isThinkFast(weapon, meansOfDeath) {
  if(meansOfDeath == "MOD_IMPACT" || meansOfDeath == "MOD_HEAD_SHOT") {
    if(isThinkFastWeapon(weapon)) {
      return true;
    }
  }

  return false;
}

isThinkFastWeapon(weapon) {
  switch (weapon) {
    case "semtex_mp":
    case "frag_grenade_mp":
    case "stun_grenade__mp":
    case "stun_grenade_var_mp":
    case "emp_grenade_mp":
    case "emp_grenade_var_mp":
    case "paint_grenade_mp":
    case "paint_grenade_var_mp":
    case "smoke_grenade_mp":
    case "smoke_grenade_var_mp":
      return true;
    default:
      return false;
  }
}

thinkFastEvent() {
  self incPlayerStat("think_fast", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("think_fast", self);
}

boostSlamKillEvent(killId, weapon, meansOfDeath) {
  self incPlayerStat("boostslamkill", 1);

  self thread maps\mp\gametypes\_missions::processChallenge("ch_limited_lookoutbelow", 1);
  self thread maps\mp\gametypes\_missions::processChallenge("ch_exomech_hot", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("boostslamkill", self, weapon, undefined, meansOfDeath);
}

earnedKillStreakEvent(streakName, streakVal, modules, slotIndex) {
  self incPlayerStat(streakName + "_earned", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent(streakName + "_earned", self);

  self thread maps\mp\gametypes\_hud_message::killstreakSplashNotify(streakName, streakVal, undefined, modules, slotIndex);

  self maps\mp\gametypes\_missions::processChallengeDaily(22, streakName, undefined);
  self maps\mp\gametypes\_missions::processChallengeDaily(23, streakName, undefined);
}

bulletPenetrationEvent(killId, weapon) {
  self incPlayerStat("bulletpenkills", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("bulletpen", self);
  if(isDefined(weapon)) {
    baseWeapon = getBaseWeaponName(weapon);
    if(isLootWeapon(baseWeapon)) {
      baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
    }
    weaponClass = self maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);
    if(weaponClass == "weapon_sniper") {
      if(isDefined(level.challengeInfo["ch_penetrate_" + baseWeapon])) {
        self maps\mp\gametypes\_missions::processChallenge("ch_penetrate_" + baseWeapon);
      }
    }
  }
  self maps\mp\gametypes\_missions::processChallenge("ch_boot_xray");
}

multiKillOneBulletEvent() {
  self incPlayerStat("multiKillOneBullet", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("multiKillOneBullet", self);
}

checkHighJumpEvents(victim, killId, weapon, meansOfDeath, eInflictor) {
  if(isDefined(eInflictor) && isDefined(eInflictor.ch_crossbow_player_jumping)) {
    attackerIsJumping = eInflictor.ch_crossbow_player_jumping;
  } else {
    attackerIsJumping = self IsHighJumping();
  }

  if(isDefined(eInflictor) && isDefined(eInflictor.ch_crossbow_victim_jumping)) {
    victimIsJumping = eInflictor.ch_crossbow_victim_jumping;
  } else {
    victimIsJumping = victim IsHighJumping();
  }

  if(attackerIsJumping && victimIsJumping) {
    self airToAirEvent(killId, weapon, meansOfDeath);
  }

  if(attackerIsJumping && !victimIsJumping) {
    self airToGroundEvent(killId, weapon, meansOfDeath);
  }

  if(!attackerIsJumping && victimIsJumping) {
    self groundToAirEvent(killId, weapon, meansOfDeath);
  }
}

checkWeaponSpecificKill(victim, weapon, meansOfDeath) {
  if(maps\mp\gametypes\_weapons::isRiotShield(weapon) || (weapon == maps\mp\_exo_shield::get_exo_shield_weapon())) {
    riotShieldKillEvent(weapon, meansOfDeath);
  }

  if(IsSubStr(weapon, "exoknife_mp")) {
    exoKnifeKillEvent(weapon, meansOfDeath, victim);
  }
}

exoKnifeKillEvent(weapon, meansOfDeath, victim) {
  self incPlayerStat("exo_knife_kill", 1);

  if(isDefined(victim.wasRecall) && victim.wasRecall) {
    self incPlayerStat("exo_knife_recall_kill", 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent("exo_knife_recall_kill", self, weapon, undefined, meansOfDeath);
    self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_boomerang");
  } else {
    level thread maps\mp\gametypes\_rank::awardGameEvent("exo_knife_kill", self, weapon, undefined, meansOfDeath);
  }
}

nearDeathKillEvent(weapon, meansOfDeath) {
  self incPlayerStat("near_death_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("near_death_kill", self, weapon, undefined, meansOfDeath);
}

sprintSlideKillEvent(weapon, meansOfDeath) {
  self incPlayerStat("slide_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("slide_kill", self, weapon, undefined, meansOfDeath);
}

flashedKillEvent(weapon, meansOfDeath) {
  self incPlayerStat("flash_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("flash_kill", self, weapon, undefined, meansOfDeath);
}

riotShieldKillEvent(weapon, meansOfDeath) {
  self incPlayerStat("riot_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("riot_kill", self, weapon, undefined, meansOfDeath);
}

airToAirEvent(killId, weapon, meansOfDeath) {
  self incPlayerStat("air_to_air_kill", 1);
  self thread maps\mp\gametypes\_missions::processChallenge("ch_limited_acepilot", 1);
  self thread maps\mp\gametypes\_missions::processChallenge("ch_exomech_redbaron", 1);

  baseWeapon = getBaseWeaponName(weapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }
  weaponClass = self maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);
  if(isMeleeMOD(meansOfDeath)) {
    self incPlayerStat("melee_air_to_air", 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent("melee_air_to_air", self, weapon, undefined, meansOfDeath);
  } else {
    level thread maps\mp\gametypes\_rank::awardGameEvent("air_to_air_kill", self, weapon, undefined, meansOfDeath);

    if(WeaponClass == "weapon_smg" || WeaponClass == "weapon_shotgun") {
      if(isDefined(level.challengeInfo["ch_dogfight_" + baseWeapon]))
    }
    self maps\mp\gametypes\_missions::processChallenge("ch_dogfight_" + baseWeapon);
  }
}

airToGroundEvent(killId, weapon, meansOfDeath) {
  self incPlayerStat("air_to_ground_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("air_to_ground_kill", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\gametypes\_missions::processChallenge("ch_exomech_buzz");

  baseWeapon = getBaseWeaponName(weapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }
  weaponClass = self maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);

  if(WeaponClass == "weapon_assault" || WeaponClass == "weapon_heavy" || IsSubStr(weapon, "exocrossbow")) {
    if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
      self maps\mp\gametypes\_missions::processChallenge("ch_tier2_1_" + baseWeapon);
    } else {
      self maps\mp\gametypes\_missions::processChallenge("ch_strafe_" + baseWeapon);
    }
  }
}

groundToAirEvent(killId, weapon, meansOfDeath) {
  self incPlayerStat("ground_to_air_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("ground_to_air_kill", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\gametypes\_missions::processChallenge("ch_exomech_pull");

  baseWeapon = getBaseWeaponName(weapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }
  weaponClass = maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);

  if(weaponClass == "weapon_heavy" || IsSubStr(weapon, "exocrossbow")) {
    if(isDefined(level.challengeInfo["ch_skeet_" + baseWeapon])) {
      self maps\mp\gametypes\_missions::processChallenge("ch_skeet_" + baseWeapon);
    }
  }
}

isOneShotKill(victim, weapon, meansOfDeath) {
  if(victim.attackers.size != 1) {
    return false;
  }

  if(!isDefined(victim.attackers[self.guid])) {
    return false;
  }

  if(isMeleeMOD(meansOfDeath)) {
    return false;
  }

  if(getTime() != victim.attackerData[self.guid].firstTimeDamaged) {
    return false;
  }

  weaponClass = getWeaponClass(weapon);

  if((weaponClass == "weapon_sniper") || (weaponClass == "weapon_shotgun")) {
    return true;
  }

  return false;
}

isLongShot(attacker, weapon, meansOfDeath, victim) {
  if(isDefined(victim.agentBody)) {
    return false;
  }

  attackerPosition = self.origin;

  if(isDefined(victim.attackerPosition)) {
    attackerPosition = victim.attackerPosition;
  }

  if(isAlive(attacker) &&
    !attacker isUsingRemote() &&
    (meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET" || meansOfDeath == "MOD_HEAD_SHOT" || IsSubStr(weapon, "exoknife_mp") || IsSubStr(weapon, "exocrossbow") || IsSubStr(weapon, "m990")) &&
    !isKillstreakWeapon(weapon) && !isDefined(attacker.assistedSuicide)) {
    thisWeaponClass = getWeaponClass(weapon);
    switch (thisWeaponClass) {
      case "weapon_pistol":
        weapDist = 800;
        break;
      case "weapon_smg":
        weapDist = 1200;
        break;
      case "weapon_assault":
      case "weapon_heavy":
        weapDist = 1500;
        break;
      case "weapon_sniper":
        weapDist = 2000;
        break;
      case "weapon_shotgun":
        weapDist = 500;
        break;
      case "weapon_projectile":
      default:
        weapDist = 1536;
        break;
    }

    if(IsSubStr(weapon, "exoknife_mp") || IsSubStr(weapon, "exocrossbow")) {
      weapDist = 1200;
    }

    weapDistSq = weapDist * weapDist;
    if(DistanceSquared(attackerPosition, victim.origin) > weapDistSq) {
      return true;
    }
  }

  return false;
}

isResuce(victim, curTime) {
  if(!level.teamBased) {
    return false;
  }

  foreach(guid, damageTime in victim.damagedPlayers) {
    if((guid != self.guid) && (curTime - damageTime < 500)) {
      return true;
    }
  }

  return false;
}

longShotEvent(killId, weapon, meansOfDeath) {
  self.modifiers["longshot"] = true;

  self incPlayerStat("longshots", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("longshot", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "longshot");
}

headShotEvent(killId, weapon, meansOfDeath) {
  self.modifiers["headshot"] = true;

  self incPersStat("headshots", 1);
  self incPlayerStat("headshots", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "headshots", clampToShort(self.pers["headshots"]));
  self.headshots = self getPersStat("headshots");

  level thread maps\mp\gametypes\_rank::awardGameEvent("headshot", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "headshot");
  self maps\mp\gametypes\_missions::processChallenge("ch_limited_headhunter");
}

isThrowBackEvent(victim, weapon, meansOfDeath) {
  if(!IsExplosiveDamageMOD(meansOfDeath)) {
    return false;
  }

  if(!isStrStart(weapon, "frag_")) {
    return false;
  }

  if(isDefined(victim) && isDefined(victim.explosiveInfo) && isDefined(victim.explosiveInfo["throwbackKill"]) && victim.explosiveInfo["throwbackKill"]) {
    return true;
  }

  return false;
}

throwBackKillEvent() {
  self incPlayerStat("throwback_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("throwback_kill", self);
}

fourPlayEvent() {
  self incPlayerStat("four_play", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("four_play", self);
}

avengedPlayerEvent(killId, weapon, meansOfDeath) {
  self.modifiers["avenger"] = true;

  self incPlayerStat("avengekills", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("avenger", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "avenger");

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_avenger");
}

assistedSuicideEvent(killId, weapon, meansOfDeath) {
  self.modifiers["assistedsuicide"] = true;

  self incPlayerStat("assistedsuicide", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("assistedsuicide", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "assistedsuicide");
}

defendedPlayerEvent(killId, weapon, meansOfDeath) {
  self.modifiers["defender"] = true;

  self incPlayerStat("rescues", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("defender", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "defender");

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_savior");
}

defendObjectiveEvent(victim, killId) {
  self incPlayerStat("defends", 1);
  self incPersStat("defends", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "defends", self.pers["defends"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("defend", self);
  victim thread maps\mp\_matchdata::logKillEvent(killId, "assaulting");
}

assaultObjectiveEvent(victim, killId) {
  self incPlayerStat("assault", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("assault", self);

  victim thread maps\mp\_matchdata::logKillEvent(killId, "defending");

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_attacker");
  self maps\mp\gametypes\_missions::processChallengeDaily(7, undefined, undefined);
}

postDeathKillEvent(killId) {
  self.modifiers["posthumous"] = true;

  self incPlayerStat("posthumous", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("posthumous", self);
  self thread maps\mp\_matchdata::logKillEvent(killId, "posthumous");
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_afterlife");

  baseWeapon = getBaseWeaponName(self GetCurrentWeapon());
  if(baseWeapon == "iw5_microdronelauncher" || baseWeapon == "iw5_exocrossbow") {
    if(isDefined(level.challengeInfo["ch_afterlife_" + baseWeapon]))
  }
  self maps\mp\gametypes\_missions::processChallenge("ch_afterlife_" + baseWeapon);
}

isBackStabEvent(victim, weapon, meansOfDeath) {
  if(!isMeleeMOD(meansOfDeath)) {
    return false;
  }

  if(maps\mp\gametypes\_weapons::isRiotShield(weapon) || (weapon == maps\mp\_exo_shield::get_exo_shield_weapon())) {
    return false;
  }

  anglesOnDeath = victim GetPlayerAngles();
  anglesOnKill = self GetPlayerAngles();
  angleDiff = AngleClamp180(anglesOnDeath[1] - anglesOnKill[1]);

  if(abs(angleDiff) < 75) {
    return true;
  }

  return false;
}

backStabEvent(killId) {
  self incPlayerStat("backstab", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("backstab", self);
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_backstab");
}

revengeEvent(killId) {
  self.modifiers["revenge"] = true;

  self.lastKilledBy = undefined;
  self incPlayerStat("revengekills", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("revenge", self);
  self thread maps\mp\_matchdata::logKillEvent(killId, "revenge");
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_revenge");
}

multiKillEvent(killId, killCount, weapon, was_ads) {
  assert(killCount > 1);

  if(!isDefined(was_ads)) {
    was_ads = false;
  }

  weapon_class = maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon);

  baseWeapon = getBaseWeaponName(weapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }

  shortWeaponName = "";
  if(string_starts_with(baseWeapon, "iw5_")) {
    shortWeaponName = GetSubStr(baseWeapon, 4);
  }

  switch (killCount) {
    case 2:
      level thread maps\mp\gametypes\_rank::awardGameEvent("doublekill", self);
      self incPlayerStat("doublekill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_double");
      self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_double");

      if(weapon_class == "weapon_smg" || weapon_class == "weapon_shotgun" || weapon_class == "weapon_sniper" || baseWeapon == "iw5_microdronelauncher" || baseWeapon == "iw5_exocrossbow") {
        if(isDefined(level.challengeInfo["ch_double_" + baseWeapon]))
      }
      self maps\mp\gametypes\_missions::processChallenge("ch_double_" + baseWeapon);

      if(isDefined(level.challengeInfo["ch_attach_unlock_double_" + shortWeaponName])) {
        self maps\mp\gametypes\_missions::processChallenge("ch_attach_unlock_double_" + shortWeaponName);
      }

      break;
    case 3:
      level thread maps\mp\gametypes\_rank::awardGameEvent("triplekill", self);
      level thread teamPlayerCardSplash("callout_3xkill", self);
      self incPlayerStat("triplekill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_triple");
      self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_triple");

      if(maps\mp\gametypes\_missions::isAtBrinkOfDeath()) {
        self maps\mp\gametypes\_missions::processChallenge("ch_precision_sitcrit");
      }

      if((isDefined(weapon_class) && (weapon_class == "weapon_smg" || weapon_class == "weapon_heavy")) && was_ads == false) {
        self maps\mp\gametypes\_missions::processChallenge("ch_precision_hello");
      }
      break;
    case 4:
      level thread maps\mp\gametypes\_rank::awardGameEvent("fourkill", self);
      level thread teamPlayerCardSplash("callout_4xkill", self);
      self incPlayerStat("fourkill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_feed");
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_fury");
      self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed_fury");
      break;
    case 5:
      level thread maps\mp\gametypes\_rank::awardGameEvent("fivekill", self);
      level thread teamPlayerCardSplash("callout_5xkill", self);
      self incPlayerStat("fivekill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_frenzy");
      break;
    case 6:
      level thread maps\mp\gametypes\_rank::awardGameEvent("sixkill", self);
      level thread teamPlayerCardSplash("callout_6xkill", self);
      self incPlayerStat("sixkill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_super");
      break;
    case 7:
      level thread maps\mp\gametypes\_rank::awardGameEvent("sevenkill", self);
      level thread teamPlayerCardSplash("callout_7xkill", self);
      self incPlayerStat("sevenkill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_mega");
      break;
    case 8:
      level thread maps\mp\gametypes\_rank::awardGameEvent("eightkill", self);
      level thread teamPlayerCardSplash("callout_8xkill", self);
      self incPlayerStat("eightkill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_ultra");
      break;
    default:
      level thread maps\mp\gametypes\_rank::awardGameEvent("multikill", self);
      thread teamPlayerCardSplash("callout_9xpluskill", self);
      self incPlayerStat("multikill", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_chain");
      break;
  }

  self thread maps\mp\_matchdata::logMultiKill(killId, killCount);
}

takeAndKillEvent() {
  self incPlayerStat("take_and_kill", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("take_and_kill", self);
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_backfire");
}

killedBallCarrierEvent() {
  self incPlayerStat("killedBallCarrier", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("killedBallCarrier", self);
}

setUplinkStats() {
  uplinks = getPlayerStat("fieldgoal") + (getPlayerStat("touchdown") * 2);
  self maps\mp\gametypes\_persistence::statSetChild("round", "captures", uplinks);
  self setExtraScore0(uplinks);
}

touchDownEvent(score) {
  self thread teamPlayerCardSplash("callout_touchdown", self, undefined, score);

  self incPlayerStat("touchdown", 1);
  self setUplinkStats();

  level thread maps\mp\gametypes\_rank::awardGameEvent("touchdown", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_touchdown");
  self maps\mp\gametypes\_missions::processChallengeDaily(13, score, undefined);
}

fieldGoalEvent(score) {
  self thread teamPlayerCardSplash("callout_fieldgoal", self, undefined, score);

  self incPlayerStat("fieldgoal", 1);
  self setUplinkStats();

  level thread maps\mp\gametypes\_rank::awardGameEvent("fieldgoal", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_fieldgoal");
  self maps\mp\gametypes\_missions::processChallengeDaily(13, score, undefined);
}

interceptionEvent() {
  self incPlayerStat("interception", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("interception", self);
}

killWithBallEvent() {
  self incPlayerStat("kill_with_ball", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("kill_with_ball", self);
}

ballScoreAssistEvent() {
  self incPlayerStat("ball_score_assist", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("ball_score_assist", self);
  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_assist");
}

passKillPickupEvent() {
  self incPlayerStat("pass_kill_pickup", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("pass_kill_pickup", self);
}

flagPickUpEvent() {
  self thread teamPlayerCardSplash("callout_flagpickup", self);
  self incPlayerStat("flagscarried", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("flag_pickup", self);
  self thread maps\mp\_matchdata::logGameEvent("pickup", self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_flag_carry");
}

flagCaptureEvent() {
  self thread teamPlayerCardSplash("callout_flagcapture", self);

  self incPlayerStat("flagscaptured", 1);
  self incPersStat("captures", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "captures", self.pers["captures"]);
  self setExtraScore0(self.pers["captures"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("flag_capture", self);
  self thread maps\mp\_matchdata::logGameEvent("capture", self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_flag_capture");
  self maps\mp\gametypes\_missions::processChallengeDaily(16, undefined, undefined);
}

flagReturnEvent() {
  self thread teamPlayerCardSplash("callout_flagreturn", self);

  self incPlayerStat("flagsreturned", 1);
  self incPersStat("returns", 1);
  self.assists = self.pers["returns"];
  self maps\mp\gametypes\_persistence::statSetChild("round", "returns", self.pers["returns"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("flag_return", self);
  self thread maps\mp\_matchdata::logGameEvent("return", self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_flag_return");
  self maps\mp\gametypes\_missions::processChallengeDaily(17, undefined, undefined);
}

killWithFlagEvent() {
  self incPlayerStat("killsasflagcarrier", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("kill_with_flag", self);
}

killFlagCarrierEvent(killId) {
  self thread teamPlayerCardSplash("callout_killflagcarrier", self);

  self incPlayerStat("flagcarrierkills", 1);
  self incPersStat("defends", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "defends", self.pers["defends"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("kill_flag_carrier", self);
  self thread maps\mp\_matchdata::logKillEvent(killId, "carrying");

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_flag_defend");
}

killDeniedEvent(isTagOwner) {
  self incPlayerStat("killsdenied", 1);
  self incPersStat("denied", 1);
  self setExtraScore1(self.pers["denied"]);
  self maps\mp\gametypes\_persistence::statSetChild("round", "denied", self.pers["denied"]);

  event = "kill_denied";

  if(isTagOwner) {
    event = "kill_denied_retrieved";
    self incPlayerStat("kill_denied_retrieved", 1);
    self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_save_yourself");
  }

  level thread maps\mp\gametypes\_rank::awardGameEvent(event, self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_denial");
  self maps\mp\gametypes\_missions::processChallengeDaily(21, undefined, undefined);
}

killConfirmedEvent() {
  self incPlayerStat("killsconfirmed", 1);
  self incPersStat("confirmed", 1);
  self setExtraScore0(self.pers["confirmed"]);
  self maps\mp\gametypes\_persistence::statSetChild("round", "confirmed", self.pers["confirmed"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("kill_confirmed", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_collector");

  self maps\mp\gametypes\_missions::processChallengeDaily(4, undefined, undefined);
}

tagCollectorEvent() {
  self incPlayerStat("tag_collector", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("tag_collector", self);
}

monitorTagCollector(player) {
  if(!IsPlayer(player)) {
    return;
  }

  player notify("tagCollector");
  player endon("tagCollector");

  if(!isDefined(player.tagCollectorTotal)) {
    player.tagCollectorTotal = 0;
  }

  player.tagCollectorTotal++;

  if(player.tagCollectorTotal > 2) {
    player maps\mp\_events::tagCollectorEvent();
    player.tagCollectorTotal = 0;
  }

  wait(2.5);

  player.tagCollectorTotal = 0;
}

bombPlantEvent() {
  self incPlayerStat("bombsplanted", 1);
  self incPersStat("plants", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "plants", self.pers["plants"]);
  self setExtraScore0(self.pers["plants"]);

  level thread teamPlayerCardSplash("callout_bombplanted", self);
  level thread maps\mp\gametypes\_rank::awardGameEvent("plant", self);

  self thread maps\mp\_matchdata::logGameEvent("plant", self.origin);
}

bombDefuseEvent(defuseType) {
  self incPlayerStat("bombsdefused", 1);
  self incPersStat("defuses", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "defuses", self.pers["defuses"]);
  self setExtraScore1(self.pers["defuses"]);

  level thread teamPlayerCardSplash("callout_bombdefused", self);

  if((defuseType == "ninja_defuse") || (defuseType == "last_man_defuse")) {
    self incPlayerStat(defuseType, 1);

    if(defuseType == "last_man_defuse") {
      self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_ninja");
    }
  }

  level thread maps\mp\gametypes\_rank::awardGameEvent(defuseType, self);

  self thread maps\mp\_matchdata::logGameEvent("defuse", self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_bombdefuse");
}

eliminatePlayerEvent(isLastPlayerAlive, victim) {
  self incPlayerStat("elimination", 1);

  level thread teamPlayerCardSplash("callout_eliminated", victim);

  if(isLastPlayerAlive) {
    self incPlayerStat("last_man_standing", 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent("last_man_standing", self);
  } else {
    level thread maps\mp\gametypes\_rank::awardGameEvent("elimination", self);
  }
}

reviveTagEvent(playerRevived) {
  self incPlayerStat("sr_tag_revive", 1);
  self incPlayerStat("killsdenied", 1);
  self incPersStat("denied", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "denied", self.pers["denied"]);
  self.assists = (self.pers["denied"]);

  level thread teamPlayerCardSplash("callout_tag_revive", playerRevived);

  level thread maps\mp\gametypes\_rank::awardGameEvent("sr_tag_revive", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_medic");
}

eliminateTagEvent() {
  self incPlayerStat("sr_tag_elimination", 1);
  self incPlayerStat("killsconfirmed", 1);
  self incPersStat("confirmed", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "confirmed", self.pers["confirmed"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("sr_tag_elimination", self);
}

bombDetonateEvent() {
  self incPlayerStat("targetsdestroyed", 1);
  self incPersStat("destructions", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "destructions", self.pers["destructions"]);

  level thread maps\mp\gametypes\_rank::awardGameEvent("destroy", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_destroyer");
}

increaseGunLevelEvent() {
  self incPlayerStat("levelup", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("gained_gun_score", self);
}

decreaseGunLevelEvent() {
  self incPlayerStat("dejavu", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("dropped_gun_score", self);
}

setBackEnemyGunLevelEvent() {
  self incPlayerStat("humiliation", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("dropped_enemy_gun_rank", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_regression");
}

quickGunLevelEvent() {
  self incPlayerStat("gunslinger", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("quick_gun_rank", self);
}

setBackFirstPlayerGunLevelEvent() {
  self incPlayerStat("regicide", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("dropped_first_player_gun_rank", self);
}

firstInfectedEvent() {
  self incPlayerStat("patientzero", 1);

  playSoundOnPlayers("mp_enemy_obj_captured");

  level thread teamPlayerCardSplash("callout_first_infected", self);
  level thread maps\mp\gametypes\_rank::awardGameEvent("first_infected", self);

  self.patient_zero = 0;
}

finalSurvivorEvent() {
  self incPlayerStat("omegaman", 1);

  playSoundOnPlayers("mp_obj_captured");

  level thread teamPlayerCardSplash("callout_final_survivor", self);
  level thread maps\mp\gametypes\_rank::awardGameEvent("final_survivor", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_survivor");
}

gotInfectedEvent() {
  self incPlayerStat("careless", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("got_infected", self);
}

plagueEvent() {
  self incPlayerStat("plague", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("infected_plague", self);
}

infectedSurvivorEvent() {
  self incPlayerStat("contagious", 1);

  level thread teamPlayerCardSplash("callout_infected_survivor", self, "axis");
  level thread maps\mp\gametypes\_rank::awardGameEvent("infected_survivor", self);
}

survivorEvent() {
  self incPlayerStat("survivor", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("survivor", self);
}

domCaptureEvent(isOpeningMove) {
  self incPlayerStat("pointscaptured", 1);
  self incPersStat("captures", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "captures", self.pers["captures"]);
  self setExtraScore0(self.pers["captures"]);

  event = "capture";

  if(isOpeningMove) {
    event = "opening_move";
    self incPlayerStat("opening_move", 1);
  }

  level thread maps\mp\gametypes\_rank::awardGameEvent(event, self);

  self thread maps\mp\_matchdata::logGameEvent("capture", self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_aggression");
  self maps\mp\gametypes\_missions::processChallengeDaily(6, undefined, undefined);
}

domNeutralizeEvent() {
  level thread maps\mp\gametypes\_rank::awardGameEvent("neutralize", self);
}

killWhileCapture(victim, killId) {
  self incPlayerStat("assault", 1);
  self incPlayerStat("kill_while_capture", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("kill_while_capture", self);

  victim thread maps\mp\_matchdata::logKillEvent(killId, "defending");

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_defender");
  self maps\mp\gametypes\_missions::processChallengeDaily(22, undefined, undefined);
}

secureHardPointEvent() {
  self incPlayerStat("hp_secure", 1);
  self incPersStat("captures", 1);
  self maps\mp\gametypes\_persistence::statSetChild("round", "captures", self.pers["captures"]);
  self setExtraScore0(self.pers["captures"]);

  level thread teamPlayerCardSplash("callout_hp_captured_by", self);
  level thread maps\mp\gametypes\_rank::awardGameEvent("hp_secure", self);

  self thread maps\mp\_matchdata::logGameEvent("capture", self.origin);

  self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_aggression");
}

firstBloodEvent(killId, weapon, meansOfDeath) {
  self.modifiers["firstblood"] = true;

  self incPlayerStat("firstblood", 1);

  self thread teamPlayerCardSplash("callout_firstblood", self);

  level thread maps\mp\gametypes\_rank::awardGameEvent("firstblood", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "firstblood");
}

isBuzzKillEvent(victim) {
  foreach(streakName in victim.killstreaks) {
    if(maps\mp\killstreaks\_killstreaks::isSupportStreak(victim, streakName)) {
      continue;
    }

    streakVal = maps\mp\killstreaks\_killstreaks::getStreakCost(streakName);
    adrenaline = victim.adrenaline;

    if(streakVal < adrenaline) {
      continue;
    }

    if(streakVal - adrenaline < 101) {
      return true;
    }
  }

  return false;
}

buzzKillEvent(killId, victim, weapon, meansOfDeath) {
  self.modifiers["buzzkill"] = victim.pers["cur_kill_streak"];

  self incPlayerStat("buzzkill", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("buzzkill", self, weapon, undefined, meansOfDeath);
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_buzzkill");
}

oneShotKillEvent(killId, weapon, meansOfDeath) {
  self.modifiers["oneshotkill"] = true;

  self incPlayerStat("oneshotkill", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("oneshotkill", self, weapon, undefined, meansOfDeath);
  self maps\mp\gametypes\_missions::processChallenge("ch_limited_deadeye");

  if(getWeaponClass(weapon) == "weapon_sniper") {
    self notify("increment_sharpshooter_kills");
  } else if(getWeaponClass(weapon) == "weapon_shotgun") {
    self notify("increment_oneshotgun_kills");
  }
}

comeBackEvent(killId, weapon, meansOfDeath) {
  self.modifiers["comeback"] = true;

  self incPlayerStat("comebacks", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("comeback", self, weapon, undefined, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "comeback");
}

semtexStickEvent(victim) {
  self incPlayerStat("semtex_stick", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("semtex_stick", self);

  victim incPlayerStat("stuck_with_explosive", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("stuck_with_explosive", victim);
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

crossbowStickEvent(victim) {
  self incPlayerStat("crossbow_stick", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("crossbow_stick", self);

  victim incPlayerStat("stuck_with_explosive", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("stuck_with_explosive", victim);
  self maps\mp\gametypes\_missions::processChallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

disconnected() {
  myGuid = self.guid;

  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].killedPlayers[myGuid])) {
      level.players[entry].killedPlayers[myGuid] = undefined;
    }

    if(isDefined(level.players[entry].killedPlayersCurrent[myGuid])) {
      level.players[entry].killedPlayersCurrent[myGuid] = undefined;
    }

    if(isDefined(level.players[entry].killedBy[myGuid])) {
      level.players[entry].killedBy[myGuid] = undefined;
    }
  }
}

updateRecentKills(killId, weapon) {
  if(!isDefined(weapon)) {
    weapon = "";
  }

  self endon("disconnect");
  level endon("game_ended");

  self notify("updateRecentKills");
  self endon("updateRecentKills");

  self.recentKillCount++;

  was_ads = false;
  if(self PlayerAds() >= 0.2) {
    was_ads = true;
  }

  wait(2.0);

  if(self.recentKillCount > 1) {
    self multiKillEvent(killId, self.recentKillCount, weapon, was_ads);
  }

  self.recentKillCount = 0;
}

hijackerEvent(owner) {
  self incPlayerStat("hijacker", 1);

  level thread maps\mp\gametypes\_rank::awardGameEvent("hijacker", self);
  self thread maps\mp\gametypes\_missions::genericChallenge("hijacker_airdrop");

  if(isDefined(owner)) {
    owner maps\mp\gametypes\_hud_message::playerCardSplashNotify("hijacked_airdrop", self);
  }
}

sharedEvent() {
  self incPlayerStat("sharepackage", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("sharepackage", self);
}

mapKillStreakEvent() {
  mapStreaksReceived = getMatchData("players", self.clientId, "numberOfMapstreaksReceived");
  mapStreaksReceived++;
  setMatchData("players", self.clientId, "numberOfMapstreaksReceived", clampToByte(mapStreaksReceived));

  self incPlayerStat("map_killstreak", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("map_killstreak", self);
}

killStreakTagEvent() {
  self incPlayerStat("killstreak_tag", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("killstreak_tag", self);
}

killStreakJoinEvent() {
  coopStreakTime = GetTime();
  nextAllowTime = self.lastCoopStreakTime + 10000;

  if(nextAllowTime > coopStreakTime) {
    return;
  }

  self.lastCoopStreakTime = coopStreakTime;

  self incPlayerStat("killstreak_join", 1);
  level thread maps\mp\gametypes\_rank::awardGameEvent("killstreak_join", self);
}

checkVandalismMedal(killer) {
  if(isDefined(level.isHorde)) {
    return;
  }

  if(!isDefined(self.attackerList)) {
    return;
  }

  if(!isDefined(killer)) {
    killer = self;
  }

  owner = self.owner;

  if(!isDefined(owner)) {
    owner = self;
  }

  foreach(previousAttacker in self.attackerList) {
    if(!isDefined(previousAttacker)) {
      continue;
    }

    if(previousAttacker == owner) {
      continue;
    }

    if(previousAttacker == killer) {
      continue;
    }

    previousAttacker incPlayerStat("assist_killstreak_destroyed", 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent("assist_killstreak_destroyed", previousAttacker);
  }
}

checkStreakingEvents(victim) {
  currentKillStreak = self.killstreakcount + 1;

  if((currentKillStreak % 5) && (currentKillStreak < 30)) {
    return;
  }

  switch (currentKillStreak) {
    case 5:
      level thread maps\mp\gametypes\_rank::awardGameEvent("5killstreak", self);
      self incPlayerStat("5killstreak", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_blood");
      if(isDefined(self.challengeData["ch_limited_bloodshed"]) && (self.challengeData["ch_limited_bloodshed"] == 1)) {
        self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed", 5);
      }
      break;
    case 10:
      level thread maps\mp\gametypes\_rank::awardGameEvent("10killstreak", self);
      self incPlayerStat("10killstreak", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_merciless");
      self maps\mp\gametypes\_missions::processChallenge("ch_" + level.gametype + "_merciless");
      if(isDefined(self.challengeData["ch_limited_bloodshed"]) && (self.challengeData["ch_limited_bloodshed"] == 2)) {
        self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed", 5);
      }
      if(self.loadoutOffhand == "specialty_null" && self.loadoutEquipment == "specialty_null") {
        self maps\mp\gametypes\_missions::processChallenge("ch_precision_wetwork");
      }
      break;
    case 15:
      level thread maps\mp\gametypes\_rank::awardGameEvent("15killstreak", self);
      self incPlayerStat("15killstreak", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_ruthless");
      if(isDefined(self.challengeData["ch_limited_bloodshed"]) && (self.challengeData["ch_limited_bloodshed"] == 3)) {
        self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed", 5);
      }
      break;
    case 20:
      level thread maps\mp\gametypes\_rank::awardGameEvent("20killstreak", self);
      self incPlayerStat("20killstreak", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_relentless");
      if(isDefined(self.challengeData["ch_limited_bloodshed"]) && (self.challengeData["ch_limited_bloodshed"] == 4)) {
        self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed", 5);
      }
      break;
    case 25:
      level thread maps\mp\gametypes\_rank::awardGameEvent("25killstreak", self);
      self incPlayerStat("25killstreak", 1);
      self maps\mp\gametypes\_missions::processChallenge("ch_killer_brutal");
      if(isDefined(self.challengeData["ch_limited_bloodshed"]) && (self.challengeData["ch_limited_bloodshed"] == 5)) {
        self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed", 5);
      }
      break;
    case 30:
      level thread maps\mp\gametypes\_rank::awardGameEvent("30killstreak", self);
      self incPlayerStat("30killstreak", 1);
      if(isDefined(self.challengeData["ch_limited_bloodshed"]) && (self.challengeData["ch_limited_bloodshed"] == 6)) {
        self maps\mp\gametypes\_missions::processChallenge("ch_limited_bloodshed", 5);
      }
      break;
    default:
      level thread maps\mp\gametypes\_rank::awardGameEvent("30pluskillstreak", self);
      self incPlayerStat("30pluskillstreak", 1);
      break;
  }

  self thread teamPlayerCardSplash("callout_kill_streaking", self, undefined, currentKillStreak);
}

checkHigherRankKillEvents(victim) {
  if(getTimePassed() < (60 * 1.5) * 1000) {
    return;
  }

  enemyList = level.players;

  if(level.teamBased) {
    enemyList = level.teamList[getOtherTeam(self.team)];
  }

  if(enemyList.size < 3) {
    return;
  }

  enemiesSortedByRank = array_sort_with_func(enemyList, ::is_score_a_greater_than_b);

  if(isDefined(enemiesSortedByRank[0]) && (victim == enemiesSortedByRank[0])) {
    self incPlayerStat("firstplacekill", 1);
    level thread maps\mp\gametypes\_rank::awardGameEvent("firstplacekill", self);
    self maps\mp\gametypes\_missions::processChallenge("ch_precision_highvalue");
  }
}

is_score_a_greater_than_b(a, b) {
  return (a.score > b.score);
}

processAssistEvent(killedplayer, xpEventOverride) {
  if(isDefined(level.assists_disabled) && level.assists_disabled) {
    return;
  }

  xpevent = "assist";

  if(isDefined(xpEventOverride)) {
    xpevent = xpEventOverride;
  }

  self endon("disconnect");
  killedplayer endon("disconnect");

  wait(0.05);

  if((self.team != "axis") && (self.team != "allies")) {
    return;
  }

  if(self.team == killedplayer.team) {
    return;
  }

  level thread maps\mp\gametypes\_rank::awardGameEvent(xpevent, self, undefined, killedplayer);

  killedplayer maps\mp\_matchdata::logSpecialAssists(self, xpevent);

  if((xpevent == "assist") || (xpevent == "assist_riot_shield")) {
    self incPlayerStat("assists", 1);
    self incPersStat("assists", 1);
    self.assists = self getPersStat("assists");

    if(xpevent == "assist_riot_shield") {
      self incPlayerStat("assist_riot_shield", 1);
    }

    self maps\mp\gametypes\_persistence::statSetChild("round", "assists", self.assists);
    self thread maps\mp\gametypes\_missions::playerAssist();

    if(level.practiceRound) {
      self thread practiceRoundAssistEvent(killedplayer);
    }
  }
}

killAfterDodgeEvent(weapon) {
  self maps\mp\gametypes\_missions::processChallenge("ch_exomech_evasive");

  if(isDefined(weapon)) {
    baseWeapon = getBaseWeaponName(weapon);
    if(isLootWeapon(baseWeapon)) {
      baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
    }

    weaponClass = self maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);

    if(WeaponClass == "weapon_assault" || WeaponClass == "weapon_pistol") {
      if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
        self maps\mp\gametypes\_missions::processChallenge("ch_tier2_3_" + baseWeapon);
      } else {
        self maps\mp\gametypes\_missions::processChallenge("ch_dodge_" + baseWeapon);
      }
    }
  }
}
camoSprintSlideKillEvent(weapon, meansOfDeath) {
  baseWeapon = getBaseWeaponName(weapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }
  weaponClass = self maps\mp\gametypes\_missions::get_challenge_weapon_class(weapon, baseWeapon);
  switch (weaponClass) {
    case "weapon_smg":
    case "weapon_shotgun":
    case "weapon_pistol":
      if(isDefined(level.challengeInfo["ch_slide_" + baseWeapon])) {
        self maps\mp\gametypes\_missions::processChallenge("ch_slide_" + baseWeapon);
      }
      break;
  }
}