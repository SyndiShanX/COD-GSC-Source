/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_missions.gsc
***************************************************/

#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;

CH_REF_COL = 0;
CH_NAME_COL = 1;
CH_DESC_COL = 2;
CH_LABEL_COL = 3;
CH_RES1_COL = 4;
CH_RES2_COL = 5;
CH_LEVEL_COL = 6;
CH_CHALLENGE_COL = 7;
CH_PRESTIGE_COL = 8;
CH_TARGET_COL = 9;
CH_REWARD_COL = 10;
CH_PARENTCHALLENGE_COL = 42;
CH_SKIPVALIDATION_COL = 43;

TIER_FILE_COL = 4;

CH_REGULAR = 0;
CH_DAILY = 1;
CH_WEEKLY = 2;

UNLOCK_TABLE_REF = "mp/unlockTable.csv";
CHALLENGE_TABLE_REF = "mp/challengeTable.csv";
ALL_CHALLENGES_TABLE_REF = "mp/allChallengesTable.csv";
DAILY_CHALLENGES_TABLE_REF = "mp/dailychallengesTable.csv";
WEEKLY_CHALLENGES_TABLE_REF = "mp/weeklychallengesTable.csv";

init() {
  SetDevDvarIfUninitialized("debug_challenges_by_name", "");
  SetDevDvarIfUninitialized("debug_challenges", 0);

  precacheString(&"MP_CHALLENGE_COMPLETED");

  if(!mayProcessChallenges()) {
    return;
  }

  if(GetDvarInt("debug_challenges", 0) == 1) {
    if(inVirtualLobby())
  }
  return;

  level.missionCallbacks = [];

  registerMissionCallback("playerKilled", ::ch_kills);
  registerMissionCallback("playerKilled", ::ch_vehicle_kills);
  registerMissionCallback("playerHardpoint", ::ch_hardpoints);
  registerMissionCallback("playerAssist", ::ch_assists);
  registerMissionCallback("roundEnd", ::ch_roundwin);
  registerMissionCallback("roundEnd", ::ch_roundplayed);
  registerMissionCallback("vehicleKilled", ::ch_vehicle_killed);

  level thread onPlayerConnect();
}

debug_challenges_by_name() {
  self endon("disconnect");

  while(true) {
    wait(0.1);

    challenge_name = getDvar("debug_challenges_by_name", "");
    if(challenge_name == "") {
      continue;
    } else {
      self processChallenge(challenge_name);
      SetDevDvar("debug_challenges_by_name", "");
    }
  }
}

mayProcessChallenges() {
  if(getDvarInt("debug_challenges", 0)) {
    return true;
  }

  if(practiceRoundGame()) {
    return false;
  }

  return (level.rankedMatch);
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(IsBot(player)) {
      continue;
    }

    if(isPlayer(player) && !IsAgent(player) && !isAI(player) && !IsTestClient(player)) {
      if(getDvarInt("debug_challenges", 0) == 1)
    }
    player thread debug_challenges_by_name();

    if(!isDefined(player.pers["postGameChallenges"])) {
      player.pers["postGameChallenges"] = 0;
    }

    player thread onPlayerSpawned();
    player thread initMissionData();
    player thread monitorBombUse();

    player thread monitorStreaks();
    player thread monitorStreakReward();
    player thread monitorScavengerPickup();
    player thread monitorBlastShieldSurvival();
    player thread monitorProcessChallenge();
    player thread monitorKillstreakProgress();
    player thread monitorFinalStandSurvival();

    player thread monitorADSTime();
    player thread monitorProneTime();
    player thread monitorPowerSlideTime();
    player thread monitorWeaponSwap();
    player thread monitorFlashbang();
    player thread monitorConcussion();
    player thread monitorMineTriggering();
    player thread monitorBoostJumpDistance();
    player thread monitorPlayerMatchChallenges();

    player NotifyOnPlayerCommand("hold_breath", "+breath_sprint");
    player NotifyOnPlayerCommand("hold_breath", "+melee_breath");
    player NotifyOnPlayerCommand("release_breath", "-breath_sprint");
    player NotifyOnPlayerCommand("release_breath", "-melee_breath");
    player thread monitorHoldBreath();

    player NotifyOnPlayerCommand("jumped", "+goStand");
    player thread monitorMantle();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    self thread onPlayerDeath();
    self thread monitorSprintDistance();
  }
}

onPlayerDeath() {
  self endon("disconnect");

  self waittill("death");

  if(isDefined(self.hasScavengedAmmoThisLife)) {
    self.hasScavengedAmmoThisLife = 0;
  }
}

monitorScavengerPickup() {
  self endon("disconnect");

  for(;;) {
    self waittill("scavenger_pickup");

    if(self IsItemUnlocked("specialty_scavenger") && self _hasPerk("specialty_scavenger") && !self isJuggernaut()) {
      self processChallenge("ch_scavenger_pro");
      self.hasScavengedAmmoThisLife = 1;
    }

    wait(0.05);
  }
}

monitorStreakReward() {
  self endon("disconnect");

  for(;;) {
    self waittill("received_earned_killstreak");

    if(self IsItemUnlocked("specialty_hardline") && self _hasPerk("specialty_hardline")) {
      self processChallenge("ch_hardline_pro");
    }

    wait(0.05);
  }
}

monitorBlastShieldSurvival() {
  self endon("disconnect");

  for(;;) {
    self waittill("survived_explosion", attacker);

    if(isDefined(attacker) && isPlayer(attacker) && self == attacker) {
      continue;
    }

    if(self IsItemUnlocked("_specialty_blastshield") && self _hasPerk("_specialty_blastshield")) {
      self processChallenge("ch_blastshield_pro");
    }

    waitframe();
  }
}

monitorFinalStandSurvival() {
  self endon("disconnect");

  for(;;) {
    self waittill("revive");

    self processChallenge("ch_livingdead");

    waitframe();
  }
}

initMissionData() {
  keys = getArrayKeys(level.killstreakFuncs);
  foreach(key in keys) {
    self.pers[key] = 0;
  }

  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveInfo = [];
}

registerMissionCallback(callback, func) {
  if(!isDefined(level.missionCallbacks[callback])) {
    level.missionCallbacks[callback] = [];
  }
  level.missionCallbacks[callback][level.missionCallbacks[callback].size] = func;
}

getChallengeStatus(name) {
  assertEx(isDefined(self.challengeData), "Player: " + self.name + " doesnt have challenge data.");

  if(isDefined(self.challengeData[name])) {
    return self.challengeData[name];
  } else {
    return 0;
  }
}

ch_assists(data) {
  player = data.player;
  player processChallenge("ch_assists");
}

ch_streak_kill(event) {
  switch (event) {
    case "vulcan_kill":
      processChallenge("ch_streak_orbitallaser");
      break;
    case "warbird_kill":
      processChallenge("ch_streak_warbird");
      break;
    case "paladin_kill":
      processChallenge("ch_streak_paladin");
      break;
    case "missile_strike_kill":
      processChallenge("ch_streak_missle");
      break;
    case "sentry_gun_kill":
      processChallenge("ch_streak_sentry");
      break;
    case "strafing_run_kill":
      processChallenge("ch_streak_strafing");
      break;
    case "assault_drone_kill":
      processChallenge("ch_streak_assault");
      break;
    case "goliath_kill":
      processChallenge("ch_streak_goliath");
      break;

    default:
      break;
  }
}

ch_hardpoints(data) {
  if(IsBot(data.player)) {
    return;
  }

  player = data.player;
  player.pers[data.hardpointType]++;

  switch (data.hardpointType) {
    case "uav":
      player processChallenge("ch_uav");
      player processChallenge("ch_assault_streaks");
      if(player.pers["uav"] >= 3) {
        player processChallenge("ch_nosecrets");
      }
      break;
    case "airdrop_assault":
      player processChallenge("ch_airdrop_assault");
      player processChallenge("ch_assault_streaks");

      break;
    case "airdrop_sentry_minigun":
      player processChallenge("ch_airdrop_sentry_minigun");
      player processChallenge("ch_assault_streaks");

      break;

    case "nuke":
      player processChallenge("ch_nuke");
      break;
  }
}

ch_vehicle_kills(data) {
  if(!isDefined(data.attacker) || !isPlayer(data.attacker)) {
    return;
  }

  if(!isKillstreakWeapon(data.sWeapon)) {
    return;
  }

  player = data.attacker;

  if(!isDefined(player.pers[data.sWeapon + "_streak"]) || (isDefined(player.pers[data.sWeapon + "_streakTime"]) && GetTime() - player.pers[data.sWeapon + "_streakTime"] > 7000)) {
    player.pers[data.sWeapon + "_streak"] = 0;
    player.pers[data.sWeapon + "_streakTime"] = GetTime();
  }

  player.pers[data.sWeapon + "_streak"]++;

  switch (data.sWeapon) {
    case "artillery_mp":
      player processChallenge("ch_carpetbomber");

      if(player.pers[data.sWeapon + "_streak"] >= 5) {
        player processChallenge("ch_carpetbomb");
      }

      if(isDefined(player.finalKill)) {
        player processChallenge("ch_finishingtouch");
      }
      break;

    case "stealth_bomb_mp":
      player processChallenge("ch_thespirit");

      if(player.pers[data.sWeapon + "_streak"] >= 6) {
        player processChallenge("ch_redcarpet");
      }

      if(isDefined(player.finalKill)) {
        player processChallenge("ch_technokiller");
      }
      break;

    case "sentry_minigun_mp":
      player processChallenge("ch_looknohands");

      if(isDefined(player.finalKill)) {
        player processChallenge("ch_absentee");
      }
      break;

    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      player processChallenge("ch_spectre");

      if(isDefined(player.finalKill)) {
        player processChallenge("ch_deathfromabove");
      }
      break;

    case "remotemissile_projectile_mp":
      player processChallenge("ch_predator");

      if(player.pers[data.sWeapon + "_streak"] >= 4) {
        player processChallenge("ch_reaper");
      }

      if(isDefined(player.finalKill)) {
        player processChallenge("ch_dronekiller");
      }
      break;

    case "nuke_mp":
      data.victim processChallenge("ch_radiationsickness");
      break;

    default:
      break;
  }
}

ch_vehicle_killed(data) {
  if(!isDefined(data.attacker) || !isPlayer(data.attacker)) {
    return;
  }

  player = data.attacker;

  baseWeapon = getBaseWeaponName(data.sWeapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }

  weaponClass = get_challenge_weapon_class(data.sWeapon, baseWeapon);

  if(weaponClass == "weapon_launcher") {
    player processChallenge("ch_launcher_kill");

    if(isDefined(level.challengeInfo["ch_vehicle_" + baseWeapon])) {
      player processChallenge("ch_vehicle_" + baseWeapon);
    }

    if(isDefined(level.challengeInfo["ch_marksman_" + baseWeapon])) {
      player processChallenge("ch_marksman_" + baseWeapon);
    }
  }

  if(player _hasPerk("specialty_coldblooded") && player _hasPerk("specialty_spygame") && player _hasPerk("specialty_heartbreaker")) {
    if(!isDefined(data.vehicle) || !isDefined(data.vehicle.sentrytype) || data.vehicle.sentrytype != "prison_turret") {
      player processChallenge("ch_precision_airhunt");
    }
  }

  if(isDefined(data.vehicle) && isDefined(data.vehicle.vehicletype) && data.vehicle.vehicletype == "drone_recon" && IsSubStr(baseWeapon, "exoknife")) {
    player processChallenge("ch_precision_knife");
  }

  if(player _hasPerk("specialty_class_blindeye") && (!isDefined(data.vehicle.vehicleInfo) || (data.vehicle.vehicleInfo != "vehicle_tracking_drone_mp"))) {
    player processChallenge("ch_perk_blindeye");
  }
}

clearIDShortly(expId) {
  self endon("disconnect");

  self notify("clearing_expID_" + expID);
  self endon("clearing_expID_" + expID);

  wait(3.0);
  self.explosiveKills[expId] = undefined;
}

MGKill() {
  player = self;
  if(!isDefined(player.pers["MGStreak"])) {
    player.pers["MGStreak"] = 0;
    player thread endMGStreakWhenLeaveMG();
    if(!isDefined(player.pers["MGStreak"])) {
      return;
    }
  }
  player.pers["MGStreak"]++;

  if(player.pers["MGStreak"] >= 5) {
    player processChallenge("ch_mgmaster");
  }
}

endMGStreakWhenLeaveMG() {
  self endon("disconnect");
  while(1) {
    if(!isAlive(self) || self useButtonPressed()) {
      self.pers["MGStreak"] = undefined;

      break;
    }
    wait .05;
  }
}

endMGStreak() {
  self.pers["MGStreak"] = undefined;
}

killedBestEnemyPlayer(wasBest) {
  if(!isDefined(self.pers["countermvp_streak"]) || !wasBest) {
    self.pers["countermvp_streak"] = 0;
  }

  self.pers["countermvp_streak"]++;

  if(self.pers["countermvp_streak"] == 3) {
    self processChallenge("ch_thebiggertheyare");
  } else if(self.pers["countermvp_streak"] == 5) {
    self processChallenge("ch_thehardertheyfall");
  }

  if(self.pers["countermvp_streak"] >= 10) {
    self processChallenge("ch_countermvp");
  }
}

isHighestScoringPlayer(player) {
  if(!isDefined(player.score) || player.score < 1) {
    return false;
  }

  players = level.players;
  if(level.teamBased) {
    team = player.pers["team"];
  } else {
    team = "all";
  }

  highScore = player.score;

  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].score)) {
      continue;
    }

    if(players[i].score < 1) {
      continue;
    }

    if(team != "all" && players[i].pers["team"] != team) {
      continue;
    }

    if(players[i].score > highScore) {
      return false;
    }
  }

  return true;
}

processChallengeDaily(daily_index_arg, arg1, arg2) {
  if(!(self rankingEnabled()) || privateMatch()) {
    return;
  }

  if(!(GetDvarInt("dailychallenge_killswitch", 0) > 0)) {
    return;
  }

  daily_index_actual = self getPlayerData("dailyChallengeId", 0);
  current_playlist = GetDvarInt("scr_current_playlist", 0);

  if(!isDefined(daily_index_actual) || !isDefined(daily_index_arg) || daily_index_actual != daily_index_arg) {
    return;
  }

  switch (daily_index_actual) {
    case 1:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "war" && weapon_class == "weapon_shotgun") {
        self processChallenge("ch_daily_01");
      }
      break;

    case 2:
      if(level.gametype == "war") {
        self processChallenge("ch_daily_02");
      }
      break;

    case 3:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "conf" && weapon_class == "weapon_sniper") {
        self processChallenge("ch_daily_03");
      }
      break;

    case 4:
      if(level.gametype == "conf") {
        self processChallenge("ch_daily_04");
      }
      break;

    case 5:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "dom" && weapon_class == "weapon_heavy") {
        self processChallenge("ch_daily_05");
      }
      break;

    case 6:
      if(level.gametype == "dom") {
        self processChallenge("ch_daily_06");
      }
      break;

    case 7:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "dom" && weapon_class == "weapon_smg") {
        self processChallenge("ch_daily_07");
      }
      break;

    case 8:
      weapon_class = arg1;
      if(isDefined(weapon_class) && current_playlist == 1 && weapon_class == "weapon_smg") {
        self processChallenge("ch_daily_08");
      }
      break;

    case 9:
      weapon_class = arg1;
      if(isDefined(weapon_class) && current_playlist == 1 && weapon_class == "weapon_heavy") {
        self processChallenge("ch_daily_09");
      }
      break;

    case 10:
      weapon_class = arg1;
      if(isDefined(weapon_class) && current_playlist == 1 && weapon_class == "weapon_launcher") {
        self processChallenge("ch_daily_10");
      }
      break;

    case 11:
      sWeapon = arg1;
      if(isDefined(sWeapon) && current_playlist == 1 && isKillstreakWeapon(sWeapon)) {
        self processChallenge("ch_daily_11");
      }
      break;

    case 12:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "ball" && weapon_class == "weapon_shotgun") {
        self processChallenge("ch_daily_12");
      }
      break;

    case 13:
      score = arg1;
      if(isDefined(score) && level.gametype == "ball") {
        self processChallenge("ch_daily_13", score);
      }
      break;

    case 14:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "hp" && weapon_class == "weapon_smg") {
        self processChallenge("ch_daily_14");
      }
      break;

    case 15:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "hp" && weapon_class == "weapon_heavy") {
        self processChallenge("ch_daily_15");
      }
      break;

    case 16:
      if(level.gametype == "ctf") {
        self processChallenge("ch_daily_16");
      }
      break;

    case 17:
      if(level.gametype == "ctf") {
        self processChallenge("ch_daily_17");
      }
      break;

    case 18:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "ctf" && weapon_class == "weapon_smg") {
        self processChallenge("ch_daily_18");
      }
      break;

    case 19:
      weapon_class = arg1;
      if(isDefined(weapon_class) && level.gametype == "ctf" && weapon_class == "weapon_heavy") {
        self processChallenge("ch_daily_19");
      }
      break;

    case 20:
      sWeapon = arg1;
      if(isDefined(sWeapon) && IsSubStr(sWeapon, "_lefthand")) {
        sWeapon = maps\mp\_utility::strip_suffix(sWeapon, "_lefthand");
      }

      if(isDefined(sWeapon) && level.gametype == "hp" && is_lethal_equipment(sWeapon)) {
        self processChallenge("ch_daily_20");
      }
      break;

    case 21:
      if(level.gametype == "conf") {
        self processChallenge("ch_daily_21");
      }
      break;

    case 22:
      streakName = arg1;
      streak_found = false;
      foreach(earned_streak in self.ch_unique_earned_streaks) {
        if(earned_streak == streakName) {
          streak_found = true;
          break;
        }
      }
      if(streak_found == false) {
        self.ch_unique_earned_streaks[self.ch_unique_earned_streaks.size] = streakName;
      }

      if(self.ch_unique_earned_streaks.size == 4) {
        self processChallenge("ch_daily_22");
      }

      break;

    case 23:
      streakName = arg1;
      if(streakName == "orbital_carepackage") {
        self processChallenge("ch_daily_23");
      }
      break;

    case 24:
      sWeapon = arg1;
      weaponAttachments = getWeaponAttachments(sWeapon);
      if(level.gameType == "war" && isCACPrimaryWeapon(sWeapon) && weaponAttachments.size == 3) {
        self processChallenge("ch_daily_24");
      }
      break;

    case 25:
      if(level.gametype == "ctf") {
        self processChallenge("ch_daily_25");
      }
      break;

    case 26:
      if(level.gametype == "dom") {
        self processChallenge("ch_daily_26");
      }
      break;

    case 27:
      if(level.gametype == "conf") {
        self processChallenge("ch_daily_27");
      }
      break;

    case 28:
      if(level.gametype == "ball") {
        self processChallenge("ch_daily_28");
      }
      break;

    case 29:
      if(level.gametype == "twar") {
        self processChallenge("ch_daily_29");
      }
      break;

    case 30:
      if(level.gametype == "hp") {
        self processChallenge("ch_daily_30");
      }
      break;

    default:
      break;
  }
}

ch_kills(data) {
  data.victim playerDied();

  if(!isDefined(data.attacker) || !isPlayer(data.attacker)) {
    return;
  } else {
    player = data.attacker;
  }

  if(IsBot(player)) {
    return;
  }

  oneLeftCount = 0;
  secondaryCount = 0;
  killsLast10s = 1;
  killedPlayers[data.victim.name] = data.victim.name;
  usedWeapons[data.sWeapon] = data.sWeapon;
  uniqueKills = 1;
  killstreakKills = [];
  MoD = data.sMeansOfDeath;
  time = data.time;

  killswithstolenweapon = 0;
  if(isDefined(player.pickedUpWeaponFrom[data.sweapon]) && !isMeleeMOD(MoD)) {
    killswithstolenweapon++;
  }

  was_killstreak_weap = isKillstreakWeapon(data.sWeapon);
  was_environment_weap = isEnvironmentWeapon(data.sWeapon);

  was_headshot = false;
  if(MoD == "MOD_HEAD_SHOT") {
    was_headshot = true;
  }

  was_longshot = false;
  longshotCount = 0;
  if(isDefined(data.modifiers["longshot"])) {
    was_longshot = true;
    longshotCount++;
  }

  was_ads = data.was_ads;

  was_doublekill = false;
  if(player.recentKillCount == 2) {
    was_doublekill = true;
  }

  was_triplekill = false;
  if(player.recentKillCount == 3) {
    was_triplekill = true;
  }

  stance = "";
  if(isDefined(data.attackerstance)) {
    stance = data.attackerstance;
  }

  was_streaking_5 = false;
  was_streaking_10 = false;
  was_streaking_15 = false;
  was_streaking_20 = false;
  was_streaking_25 = false;
  was_streaking_30 = false;
  switch (player.killsthislife.size + 1) {
    case 5:
      was_streaking_5 = true;
      break;
    case 10:
      was_streaking_10 = true;
      break;
    case 15:
      was_streaking_15 = true;
      break;
    case 20:
      was_streaking_20 = true;
      break;
    case 25:
      was_streaking_25 = true;
      break;
    case 30:
      was_streaking_30 = true;
      break;
    default:
      break;
  }

  foreach(killData in player.killsThisLife) {
    if(isCACSecondaryWeapon(killData.sWeapon) && !isMeleeMOD(killData.sMeansOfDeath)) {
      secondaryCount++;
    }

    if(isDefined(killData.modifiers["longshot"])) {
      longshotCount++;
    }

    if(longshotCount == 3) {
      player processChallenge("ch_precision_farsight");
    }

    if(time - killData.time < 10000) {
      killsLast10s++;
    }

    if(isDefined(player.pickedUpWeaponFrom[killdata.sWeapon]) && !isMeleeMOD(killdata.sMeansOfDeath)) {
      killswithstolenweapon++;
      if(killswithstolenweapon == 5) {
        player processChallenge("ch_humiliation_finders");
      }
    }

    if(isKillstreakWeapon(killData.sWeapon)) {
      if(!isDefined(killstreakKills[killData.sWeapon])) {
        killstreakKills[killData.sWeapon] = 0;
      }

      killstreakKills[killData.sWeapon]++;
    } else {
      if(isDefined(level.oneLeftTime[player.team]) && killData.time > level.oneLeftTime[player.team]) {
        oneLeftCount++;
      }

      if(isDefined(killData.victim)) {
        if(!isDefined(killedPlayers[killData.victim.name]) && !isDefined(usedWeapons[killData.sWeapon]) && !isKillStreakWeapon(killData.sWeapon)) {
          uniqueKills++;
        }

        killedPlayers[killData.victim.name] = killData.victim.name;
      }

      usedWeapons[killData.sWeapon] = killData.sWeapon;
    }
  }

  baseWeapon = getBaseWeaponName(data.sWeapon);
  if(isLootWeapon(baseWeapon)) {
    baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
  }

  shortWeaponName = baseWeapon;

  if(string_starts_with(baseWeapon, "iw5_")) {
    shortWeaponName = GetSubStr(baseWeapon, 4);
  }

  weaponClass = get_challenge_weapon_class(data.sWeapon, baseWeapon);

  if(level.teamBased) {
    if(level.teamCount[data.victim.pers["team"]] > 3 && player.killedPlayers.size >= level.teamCount[data.victim.pers["team"]]) {
      player processChallenge("ch_precision_cleanhouse");
    }
  }

  if(isDefined(player.explosive_drone_owner) && data.victim == player.explosive_drone_owner) {
    player processChallenge("ch_precision_protected");
  }

  if(isDefined(player.powerslideTime) && (time - player.powerslideTime < 3000)) {
    player processChallenge("ch_boot_hero");
  }

  if(isDefined(player.pickedUpWeaponFrom[data.sWeapon])) {
    if(!isMeleeMOD(MoD)) {
      player processChallenge("ch_boot_stolen");
    }
  }

  if(stance == "crouch") {
    player processChallenge("ch_boot_crouch");
  }

  if(stance == "prone") {
    player processChallenge("ch_boot_prone");
  }

  if(data.victim != data.attacker) {
    foreach(wildcard in player.loadoutWildcards) {
      perk_group = undefined;
      perk_group_id = 0;
      if(wildcard == "specialty_wildcard_perkslot1") {
        perk_group_id = 1;
        perk_group = ["specialty_extended_battery", "specialty_class_lowprofile", "specialty_class_flakjacket", "specialty_class_lightweight", "specialty_class_dangerclose"];
      }
      if(wildcard == "specialty_wildcard_perkslot2") {
        perk_group_id = 2;
        perk_group = ["specialty_class_blindeye", "specialty_class_coldblooded", "specialty_class_peripherals", "specialty_class_fasthands", "specialty_class_dexterity"];
      }
      if(wildcard == "specialty_wildcard_perkslot3") {
        perk_group_id = 3;
        perk_group = ["specialty_class_hardwired", "specialty_class_toughness", "specialty_class_scavenger", "specialty_class_hardline", "specialty_exo_blastsuppressor"];
      }

      if(isDefined(perk_group) && (perk_group_id > 0)) {
        count = 0;
        foreach(perk in player.loadoutperks) {
          if(array_contains(perk_group, perk))
        }
        count++;

        if((count >= 2) && (perk_group_id == 1) && (wildcard == "specialty_wildcard_perkslot1")) {
          player processChallenge("ch_wild_perk1");
        }
        if((count >= 2) && (perk_group_id == 2) && (wildcard == "specialty_wildcard_perkslot2")) {
          player processChallenge("ch_wild_perk2");
        }
        if((count >= 2) && (perk_group_id == 3) && (wildcard == "specialty_wildcard_perkslot3")) {
          player processChallenge("ch_wild_perk3");
        }
      }

      if((wildcard == "specialty_wildcard_primaryattachment") || (wildcard == "specialty_wildcard_secondaryattachment")) {
        weapon = data.sWeapon;
        attachments = GetWeaponAttachments(weapon);

        if((wildcard == "specialty_wildcard_primaryattachment") && isCACPrimaryWeapon(weapon) && (attachments.size >= 3)) {
          player processChallenge("ch_wild_primary");
        }
        if((wildcard == "specialty_wildcard_secondaryattachment") && isCACSecondaryWeapon(weapon) && (attachments.size >= 2)) {
          player processChallenge("ch_wild_secondary");
        }
      }

      if(wildcard == "specialty_wildcard_dualprimaries") {
        gun1 = player.loadoutprimary;
        gun2 = player.loadoutsecondary;
        if(!isCACPrimaryWeapon(gun1) || !isCACPrimaryWeapon(gun2)) {
          continue;
        }

        weapon = getBaseWeaponName(data.sWeapon);

        looking_for = undefined;
        if(weapon == gun1) {
          looking_for = gun2;
        } else if(weapon == gun2) {
          looking_for = gun1;
        } else {
          continue;
        }

        kills = player.killsthislife;
        passed = false;
        found_self = false;
        foreach(lastkill in kills) {
          if(getBaseWeaponName(lastkill.sweapon) == looking_for) {
            passed = true;
          }
          if(getBaseWeaponName(lastkill.sweapon) == weapon) {
            found_self = true;
          }
        }

        if(passed && !found_self) {
          player processChallenge("ch_wild_overkill");
          player processChallengeDaily(2, baseWeapon, weaponClass);
        }
      }

      if(wildcard == "specialty_wildcard_dualtacticals") {
        if(is_exo_ability_weapon(player.loadoutequipment) && is_exo_ability_weapon(player.loadoutoffhand)) {
          player processChallenge("ch_wild_exotac");
        }
      }

      if(wildcard == "specialty_wildcard_duallethals") {
        if(maps\mp\gametypes\_weapons::isgrenade(data.sWeapon) && !IsSubStr(data.sWeapon, "exoknife_mp")) {
          if((player.loadoutequipment != "specialty_null") && maps\mp\gametypes\_class::isValidEquipment(player.loadoutequipment, false) &&
          }
          (player.loadoutoffhand != "specialty_null") && maps\mp\gametypes\_class::isValidEquipment(player.loadoutoffhand, false))
        player processChallenge("ch_wild_exobomb");
      }

      if(wildcard == "specialty_wildcard_extrastreak") {
        if(!was_killstreak_weap) {
          continue;
        }

        if(player.killstreaks.size < 4) {
          continue;
        }

        player processChallenge("ch_wild_fourthscore");
      }
    }
  }

  if(data.victim != data.attacker) {
    is_on_enemy_team = !level.teambased || data.victim.team != data.attacker.team;

    if(is_on_enemy_team && player _hasPerk("specialty_class_lowprofile")) {
      numuav = 0;
      if(isDefined(level.UAVModels)) {
        if(level.teamBased) {
          numuav = level.UAVModels[getOtherTeam(data.attacker.team)].size;
        } else {
          if(level.UAVModels.size > 0) {
            player_uavs = 0;
            foreach(uav in level.UAVModels) {
              if(uav.owner == player) {
                player_uavs++;
              }
            }

            if(player_uavs > 0) {
              numuav = level.UAVModels.size - player_uavs;
            } else {
              numuav = level.UAVModels.size;
            }
          }
        }
      }
      if(numuav > 0) {
        player processChallenge("ch_perk_lowprofile");
      }
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_quickdraw") && player AdsButtonPressed()) {
      player processChallenge("ch_perk_quickdraw");
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_lightweight")) {
      player processChallenge("ch_perk_lightweight");
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_coldblooded")) {
      player processChallenge("ch_perk_coldblood");
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_peripherals")) {
      player processChallenge("ch_perk_peripheral");
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_dexterity") && (player IsSprinting() || player IsPowerSliding())) {
      player processChallenge("ch_perk_gungho");
    }

    if(is_on_enemy_team && player _hasPerk("specialty_exo_blastsuppressor")) {
      player processChallenge("ch_perk_blast");
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_hardwired")) {
      uavEmpUp = false;
      if(isDefined(level.UAVModels)) {
        if(level.teamBased) {
          foreach(uav in level.UAVModels[getOtherTeam(player.team)]) {
            if(uav.uavType == "counter") {
              uavEmpUp = true;
              break;
            }
          }

          if(isDefined(level.empOwner) && level.empOwner.team != player.team) {
            uavEmpUp = true;
          }
        } else {
          foreach(uav in level.UAVModels) {
            if(uav.uavType == "counter" && !(uav.owner == player)) {
              uavEmpUp = true;
              break;
            }
          }
        }
      }
      if(uavEmpUp) {
        player processChallenge("ch_perk_hardwire");
      }
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_fasthands")) {
      if(isDefined(player.lastPrimaryWeaponSwapTime) && (GetTime() - player.lastPrimaryWeaponSwapTime) < 5000) {
        player processChallenge("ch_perk_fasthand");
      }
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_toughness")) {
      if(isDefined(player.lastDamageFromEnemyTargetTime) && (GetTime() - player.lastDamageFromEnemyTargetTime) < 2000) {
        player processChallenge("ch_perk_tough");
      }
    }

    if(is_on_enemy_team && player _hasPerk("specialty_class_scavenger") && isDefined(player.hasScavengedAmmoThisLife) && player.hasScavengedAmmoThisLife == 1) {
      player processChallenge("ch_perk_scavenge");
    }
  }

  if(time < data.victim.concussionEndTime) {
    player processChallenge("ch_exolauncher_stun");
  }

  if(isDefined(data.victim.inPlayerSmokeScreen)) {
    player processChallenge("ch_exolauncher_smoke");
  }

  foreach(threat in data.victim._threatdetection.showlist) {
    if((threat.eventtype == "PAINT_GRENADE") && (time < threat.endTime)) {
      player processChallenge("ch_exolauncher_threat");
      break;
    }
  }

  if(isDefined(data.victim.empGrenaded) && ((data.victim.empGrenaded == true) || (time < data.victim.empendtime))) {
    player processChallenge("ch_exolauncher_emp");
  }

  if(isDefined(data.victim.died_being_tracked) && (data.victim.died_being_tracked == true)) {
    data.victim.died_being_tracked = undefined;
    player processChallenge("ch_exolauncher_tracking");
  }

  if(((player.loadoutequipment == "adrenaline_mp") || (player.loadoutoffhand == "adrenaline_mp")) && (player.overclock_on == true)) {
    player processChallenge("ch_exoability_overclock");
  }

  if((player.loadoutequipment == "exocloak_equipment_mp") || (player.loadoutoffhand == "exocloak_equipment_mp")) {
    if((player.exo_cloak_on == true) || (isDefined(player.exo_cloak_off_time) && (data.time < (player.exo_cloak_off_time + 3000)))) {
      player processChallenge("ch_exoability_cloak");
    }
  }

  if(((player.loadoutequipment == "exohover_equipment_mp") || (player.loadoutoffhand == "exohover_equipment_mp")) && (player.exo_hover_on == true)) {
    player processChallenge("ch_exoability_hover");
  }

  if(((player.loadoutequipment == "exomute_equipment_mp") || (player.loadoutoffhand == "exomute_equipment_mp")) && (player.mute_on == true)) {
    player processChallenge("ch_exoability_mute");
  }

  if(((player.loadoutequipment == "ch_exoability_health") || (player.loadoutoffhand == "extra_health_mp")) && player.exo_health_on == true) {
    foreach(attacker in player.attackerdata) {
      if(data.time < (attacker.lasttimedamaged + 4000)) {
        player processChallenge("ch_exoability_health");
        break;
      }
    }
  }

  attachment = "";
  weaponAttachments = getWeaponAttachments(data.sWeapon);
  foreach(weaponAttachment in weaponAttachments) {
    switch (weaponAttachment) {
      case "opticsacog2":
      case "opticsacog2ar":
        if(was_ads) {
          player processChallenge("ch_attach_kill_opticsacog2");
        }
        break;
      case "opticseotech":
      case "opticsreddot":
      case "opticstargetenhancer":
      case "variablereddot":
      case "ironsights":
        if(was_ads) {
          player processChallenge("ch_attach_kill_" + weaponAttachment);
        }
        break;

      case "akimbo":
      case "firerate":
      case "foregrip":
      case "heatsink":
      case "lasersight":
      case "longrange":
      case "parabolicmicrophone":
      case "quickdraw":
      case "stock":
      case "trackrounds":
      case "xmags":
      case "dualmag":
        player processChallenge("ch_attach_kill_" + weaponAttachment);
        break;

      case "opticsthermal":
      case "opticsthermalar":
        player processChallenge("ch_attach_kill_opticsthermal");
        break;

      case "silencer01":
      case "silencerpistol":
      case "silencersniper":
        player processChallenge("ch_attach_kill_silencer01");
        break;

      case "stabilizer":
      case "morsstabilizer":
      case "gm6stabilizer":
      case "m990stabilizer":
      case "thorstabilizer":
        player processChallenge("ch_attach_kill_stabilizer");
        break;

      case "scopevz":
      case "morsscopevz":
      case "m990scopevz":
      case "thorscopevz":
      case "gm6scopevz":
        player processChallenge("ch_attach_kill_scopevz");
        break;
    }
  }

  if((MoD == "MOD_PISTOL_BULLET" || MoD == "MOD_RIFLE_BULLET" || MoD == "MOD_HEAD_SHOT" || baseWeapon == "iw5_m990") && !was_environment_weap && !was_killstreak_weap) {
    switch (weaponClass) {
      case "weapon_smg":
        player processChallenge("ch_smg_kill");
        if(was_headshot) {
          player processChallenge("ch_smg_headshot");
        }
        break;
      case "weapon_assault":
        player processChallenge("ch_ar_kill");
        if(was_headshot) {
          player processChallenge("ch_ar_headshot");
        }
        break;
      case "weapon_shotgun":
        player processChallenge("ch_shotgun_kill");
        if(was_headshot) {
          player processChallenge("ch_shotgun_headshot");
        }
        break;
      case "weapon_sniper":
        player processChallenge("ch_sniper_kill");
        if(was_headshot) {
          player processChallenge("ch_sniper_headshot");
        }
        break;
      case "weapon_pistol":
        player processChallenge("ch_pistol_kill");
        if(was_headshot) {
          player processChallenge("ch_pistol_headshot");
        }
        break;
      case "weapon_heavy":
        player processChallenge("ch_heavy_kill");
        if(was_headshot) {
          player processChallenge("ch_heavy_headshot");
        }
        break;
      default:
    }

    if(MoD == "MOD_HEAD_SHOT") {
      if(weaponClass == "weapon_pistol") {
        player notify("increment_pistol_headshots");
      } else if(weaponClass == "weapon_assault") {
        player notify("increment_ar_headshots");
      }
    }

    if(isDefined(level.challengeInfo["ch_marksman_" + baseWeapon]) && player getChallengeStatus("ch_marksman_" + baseWeapon) > 0) {
      player processChallenge("ch_marksman_" + baseWeapon);
    }

    player processChallengeDaily(1, weaponClass, undefined);
    player processChallengeDaily(3, weaponClass, undefined);
    player processChallengeDaily(5, weaponClass, undefined);
    player processChallengeDaily(7, weaponClass, undefined);
    player processChallengeDaily(8, weaponClass, undefined);
    player processChallengeDaily(9, weaponClass, undefined);
    player processChallengeDaily(12, weaponClass, undefined);
    player processChallengeDaily(14, weaponClass, undefined);
    player processChallengeDaily(15, weaponClass, undefined);
    player processChallengeDaily(18, weaponClass, undefined);
    player processChallengeDaily(19, weaponClass, undefined);
    player processChallengeDaily(24, data.sWeapon, undefined);
  } else if(IsSubStr(baseWeapon, "microdronelauncher")) {
    if(isDefined(level.challengeInfo["ch_marksman_" + baseWeapon]) && player getChallengeStatus("ch_marksman_" + baseWeapon) > 0) {
      player processChallenge("ch_marksman_" + baseWeapon);
    }
  } else if(IsSubStr(baseWeapon, "exocrossbow")) {
    if(isDefined(level.challengeInfo["ch_marksman_" + baseWeapon]) && player getChallengeStatus("ch_marksman_" + baseWeapon) > 0) {
      player processChallenge("ch_marksman_" + baseWeapon);
    }
  }

  player processChallengeDaily(20, data.sWeapon, undefined);
  player processChallengeDaily(11, data.sWeapon, undefined);

  if((MoD == "MOD_PISTOL_BULLET" || MoD == "MOD_RIFLE_BULLET" || MoD == "MOD_HEAD_SHOT" || baseWeapon == "iw5_m990") && !was_environment_weap && !was_killstreak_weap) {
    switch (weaponClass) {
      case "weapon_smg":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_heavy":
      case "weapon_pistol":
      case "weapon_assault":
        if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
          player processChallenge("ch_attach_unlock_type1_" + shortWeaponName);
        } else {
          player processChallenge("ch_attach_unlock_kills_" + shortWeaponName);
        }

        if(was_ads) {
          if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
            player processChallenge("ch_attach_unlock_type3_" + shortWeaponName);
          } else {
            player processChallenge("ch_attach_unlock_ads_" + shortWeaponName);
          }
        } else {
          if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
            player processChallenge("ch_attach_unlock_type2_" + shortWeaponName);
          } else {
            player processChallenge("ch_attach_unlock_hipfirekills_" + shortWeaponName);
          }
        }
        break;
      default:
        break;
    }

    if(MoD == "MOD_HEAD_SHOT") {
      if(isDefined(level.challengeInfo["ch_attach_unlock_headShots_" + shortWeaponName]))
    }
    player processChallenge("ch_attach_unlock_headShots_" + shortWeaponName);
  }

  if(isDefined(player.riotshieldEntity)) {
    if(time - player.riotshieldEntity.birthtime < 3000) {
      player processChallenge("ch_attach_unlock_postplant_riotshieldt6");
    }
  }

  if(isMeleeMOD(MoD) && !was_environment_weap && !was_killstreak_weap) {
    if(!isSubStr(baseWeapon, "riotshield")) {
      player.pers["meleeKillStreak"]++;

      weaponAttachments = getWeaponAttachments(data.sWeapon);
      foreach(weaponAttachment in weaponAttachments) {
        if(weaponAttachment == "tactical") {
          player processChallenge("ch_attach_kill_tactical");
        }
      }
    } else if(isSubStr(baseWeapon, "riotshield")) {
      if(baseWeapon == "iw5_riotshieldt6") {
        player processChallenge("ch_attach_unlock_meleekills_riotshieldt6");
        player processChallenge("ch_marksman_iw5_riotshieldt6");
        player processChallenge("ch_special_kill");
        player.pers["shieldKillStreak"]++;
      }
    }

    if(isSubStr(baseWeapon, "exoshield")) {
      player processChallenge("ch_exoability_shield");
    }

    if(isSubstr(baseWeapon, "combatknife")) {
      player notify("increment_knife_kill");
    }
  }

  if(isSubStr(MoD, "MOD_IMPACT") && !was_environment_weap && !was_killstreak_weap) {
    if(IsSubStr(data.sWeapon, "exoknife_mp")) {
      player notify("increment_knife_kill");

      player processChallenge("ch_exolauncher_knife");
      if(was_longshot) {
        player processChallenge("ch_humiliation_hailmary");
      }

      foreach(wildcard in player.loadoutWildcards) {
        if(wildcard == "specialty_wildcard_duallethals") {
          equipment = maps\mp\_utility::strip_suffix(player.loadoutequipment, "_lefthand");
          offhand = maps\mp\_utility::strip_suffix(player.loadoutoffhand, "_lefthand");

          if(is_lethal_equipment(equipment) && is_lethal_equipment(offhand)) {
            player notify("increment_duallethal_kills");
          }

          break;
        }
      }
    }

    if(baseWeapon == "iw5_microdronelauncher" && isDefined(level.challengeInfo["ch_impact_iw5_microdronelauncher"])) {
      player processChallenge("ch_impact_iw5_microdronelauncher");
    }

    if(baseWeapon == "iw5_exocrossbow") {
      if(isDefined(level.challengeInfo["ch_attach_unlock_kills_" + shortWeaponName])) {
        player processChallenge("ch_attach_unlock_kills_" + shortWeaponName);
      }
      if(was_ads) {
        if(isDefined(level.challengeInfo["ch_attach_unlock_ads_" + shortWeaponName]))
      }
      player processChallenge("ch_attach_unlock_ads_" + shortWeaponName);
    }
  }

  if(isSubStr(MoD, "MOD_GRENADE") || isSubStr(MoD, "MOD_PROJECTILE") || isSubStr(MoD, "MOD_EXPLOSIVE") && !was_environment_weap && !was_killstreak_weap) {
    switch (weaponClass) {
      case "weapon_special":
        player processChallenge("ch_special_kill");
        break;
      default:
    }

    if(baseWeapon == "iw5_exocrossbow") {
      if(isDefined(level.challengeInfo["ch_attach_unlock_kills_" + shortWeaponName])) {
        player processChallenge("ch_attach_unlock_kills_" + shortWeaponName);
      }

      if(was_ads) {
        if(isDefined(level.challengeInfo["ch_attach_unlock_ads_" + shortWeaponName]))
      }
      player processChallenge("ch_attach_unlock_ads_" + shortWeaponName);
    }

    if(isStrStart(data.sWeapon, "frag_")) {
      player processChallenge("ch_exolauncher_frag");

      if(data.victim.explosiveInfo["cookedKill"]) {
        player processChallenge("ch_precision_masterchef");
      }

      if(data.victim.explosiveInfo["throwbackKill"]) {
        player processChallenge("ch_precision_return");
      }
    }

    if(isStrStart(data.sWeapon, "semtex_")) {
      player processChallenge("ch_exolauncher_semtex");
    }

    if(isStrStart(data.sWeapon, "explosive_drone")) {
      player processChallenge("ch_exolauncher_explosive_drone");
    }

    if(isDefined(data.einflictor.classname) && data.einflictor.classname == "scriptable") {
      player processChallenge("ch_boot_vandalism");
      player processChallenge("ch_precision_sitaware");
    }

    if(isDefined(data.sWeapon) && data.sWeapon == "mp_lab_gas_explosion") {
      player processChallenge("ch_precision_sitaware");
    }

    if(IsSubStr(data.sWeapon, "frag") || IsSubStr(data.sWeapon, "semtex") || IsSubStr(data.sWeapon, "explosive_drone")) {
      foreach(wildcard in player.loadoutWildcards) {
        if(wildcard == "specialty_wildcard_duallethals") {
          equipment = maps\mp\_utility::strip_suffix(player.loadoutequipment, "_lefthand");
          offhand = maps\mp\_utility::strip_suffix(player.loadoutoffhand, "_lefthand");

          if(is_lethal_equipment(equipment) && is_lethal_equipment(offhand)) {
            player notify("increment_duallethal_kills");
          }
          break;
        }
      }
    }

    if(isPlayerOnEnemyTeam(player) && player _hasPerk("specialty_class_dangerclose")) {
      player processChallenge("ch_perk_dangerclose");
    }
  }

  attachment = "";
  weaponAttachments = getWeaponAttachments(data.sWeapon);
  foreach(weaponAttachment in weaponAttachments) {
    switch (weaponAttachment) {
      case "gl":
        if(isDefined(level.challengeInfo["ch_attach_kill_" + weaponAttachment])) {
          player processChallenge("ch_attach_kill_" + weaponAttachment);
        }
        break;
    }
  }

  if(IsSubStr(MoD, "MOD_EXPLOSIVE") && data.sWeapon == "airdrop_trap_explosive_mp") {
    player maps\mp\gametypes\_missions::processChallenge("ch_precision_surprise");
  }

  if(MoD == "MOD_PISTOL_BULLET" || MoD == "MOD_RIFLE_BULLET" || MoD == "MOD_HEAD_SHOT" || baseWeapon == "iw5_microdronelauncher" || baseWeapon == "iw5_exocrossbow" || baseWeapon == "iw5_m990") {
    if(was_longshot) {
      if(WeaponClass == "weapon_assault" || WeaponClass == "weapon_sniper" || baseWeapon == "iw5_exocrossbow" || WeaponClass == "weapon_heavy") {
        if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
          player processChallenge("ch_tier1_1_" + baseWeapon);
        } else {
          player processChallenge("ch_longshot_" + baseWeapon);
        }
      }
    }

    if(!was_ads) {
      if(WeaponClass == "weapon_shotgun" || WeaponClass == "weapon_smg" || WeaponClass == "weapon_heavy" || baseweapon == "iw5_microdronelauncher") {
        if(isDefined(level.challengeInfo["ch_hip_" + baseWeapon])) {
          player processChallenge("ch_hip_" + baseWeapon);
        }
      }
    }

    if(IsSubStr(baseWeapon, "iw5_exocrossbow")) {
      if(!was_ads) {
        player processChallenge("ch_hip_iw5_exocrossbow");
      }
    }

    if(was_headshot) {
      switch (weaponClass) {
        case "weapon_pistol":
        case "weapon_sniper":
        case "weapon_shotgun":
        case "weapon_smg":
        case "weapon_assault":
          if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
            player processChallenge("ch_tier1_2_" + baseWeapon);
          } else {
            player processChallenge("ch_headshot_" + baseWeapon);
          }
          break;
      }
    }

    if(baseWeapon == "iw5_microdronelauncher") {
      if(isDefined(level.challengeInfo["ch_kills_iw5_microdronelauncher"])) {
        player processChallenge("ch_kills_iw5_microdronelauncher");
      }
    }
  }
  if(weaponClass == "weapon_launcher") {
    if(isDefined(level.challengeInfo["ch_kills_" + baseWeapon])) {
      player processChallenge("ch_kills_" + baseWeapon);
    }

    player processChallengeDaily(10, weaponClass, undefined);

    if(IsSubStr(data.victim.model, "npc_exo_armor_mp_base")) {
      player processChallenge("ch_launcher_kill");

      if(isDefined(level.challengeInfo["ch_vehicle_" + baseWeapon])) {
        player processChallenge("ch_vehicle_" + baseWeapon);
      }
      if(isDefined(level.challengeInfo["ch_goliath_" + baseWeapon])) {
        player processChallenge("ch_goliath_" + baseWeapon);
      }
    }
  }

  if(was_streaking_5 || was_streaking_10 || was_streaking_15 || was_streaking_20 || was_streaking_25 || was_streaking_30) {
    if(WeaponClass == "weapon_sniper") {
      if(isDefined(level.challengeInfo["ch_blood_" + baseWeapon])) {
        player processChallenge("ch_blood_" + baseWeapon);
      }
    }

    if(WeaponClass == "weapon_assault" || WeaponClass == "weapon_heavy" || baseWeapon == "iw5_microdronelauncher") {
      if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
        player processChallenge("ch_tier2_2_" + baseWeapon);
      } else {
        player processChallenge("ch_triple_" + baseWeapon);
      }
    }
  }

  weaponAttachments = getWeaponAttachments(data.sWeapon);
  if(weaponAttachments.size == 0) {
    if(!IsSubStr(MoD, "MOD_MELEE")) {
      switch (WeaponClass) {
        case "weapon_smg":
        case "weapon_assault":
        case "weapon_shotgun":
        case "weapon_sniper":
        case "weapon_pistol":
        case "weapon_heavy":
          if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
            player processChallenge("ch_tier2_4_" + baseWeapon);
          } else {
            player processChallenge("ch_barebone_" + baseWeapon);
          }
          break;
      }
      if(baseWeapon == "iw5_exocrossbow") {
        if(isDefined(level.challengeInfo["ch_barebone_" + baseWeapon])) {
          player processChallenge("ch_barebone_" + baseWeapon);
        }
      }
    }
  }

  numNull = 0;
  foreach(perkslot in player.loadoutperks) {
    if(perkslot == "specialty_null") {
      numNull++;
    } else {
      break;
    }
  }
  if(numNull == 6) {
    switch (WeaponClass) {
      case "weapon_assault":
      case "weapon_smg":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_pistol":
      case "weapon_heavy":
      case "weapon_special":
        if(IsSubStr(baseWeapon, "dlcgun") && weaponClass == "weapon_assault") {
          player processChallenge("ch_tier2_5_" + baseWeapon);
        } else {
          player processChallenge("ch_noperk_" + baseWeapon);
        }
        break;
    }
  }

  if(isDefined(player.patient_zero)) {
    player.patient_zero++;

    if(player.patient_zero == 3) {
      player maps\mp\gametypes\_missions::processChallenge("ch_infect_patientzero");
    }
  }
}

get_challenge_weapon_class(weaponRef, baseWeapon) {
  weaponClass = getWeaponClass(weaponRef);

  if(!isDefined(baseWeapon)) {
    baseWeapon = getBaseWeaponName(weaponRef);
    if(isLootWeapon(baseWeapon)) {
      baseWeapon = maps\mp\gametypes\_class::getBaseFromLootVersion(baseWeapon);
    }
  }

  if(baseWeapon == "iw5_exocrossbow" || baseWeapon == "iw5_exocrossbowblops2") {
    return "weapon_special";
  }

  if(baseWeapon == "iw5_maaws" || baseWeapon == "iw5_mahem" || baseWeapon == "iw5_stingerm7") {
    return "weapon_launcher";
  }

  return weaponClass;
}

ch_bulletDamageCommon(data, player, time, weaponClass) {
  if(!isEnvironmentWeapon(data.sWeapon)) {
    player endMGStreak();
  }

  if(isKillstreakWeapon(data.sWeapon)) {
    return;
  }

  if(IsBot(player)) {
    return;
  }

  if(player.pers["lastBulletKillTime"] == time) {
    player.pers["bulletStreak"]++;
  } else {
    player.pers["bulletStreak"] = 1;
  }

  player.pers["lastBulletKillTime"] = time;

  if(!data.victimOnGround) {
    player processChallenge("ch_hardlanding");
  }

  assert(data.attacker == player);
  if(!data.attackerOnGround) {
    player.pers["midairStreak"]++;
  }

  if(player.pers["midairStreak"] == 2) {
    player processChallenge("ch_airborne");
  }

  if(time < data.victim.flashEndTime) {
    player processChallenge("ch_flashbangvet");
  }

  if(time < player.flashEndTime) {
    player processChallenge("ch_blindfire");
  }

  if(time < data.victim.concussionEndTime) {
    player processChallenge("ch_concussionvet");
  }

  if(time < player.concussionEndTime) {
    player processChallenge("ch_slowbutsure");
  }

  if(player.pers["bulletStreak"] == 2) {
    if(isDefined(data.modifiers["headshot"])) {
      foreach(killData in player.killsThisLife) {
        if(killData.time != time) {
          continue;
        }

        if(!isDefined(data.modifiers["headshot"])) {
          continue;
        }

        player processChallenge("ch_allpro");
      }
    }

    if(weaponClass == "weapon_sniper") {
      player processChallenge("ch_collateraldamage");
    }
  }

  if(weaponClass == "weapon_pistol") {
    if(isDefined(data.victim.attackerData) && isDefined(data.victim.attackerData[player.guid])) {
      if(isDefined(data.victim.attackerData[player.guid].isPrimary)) {
        player processChallenge("ch_fastswap");
      }
    }
  }

  if(!isDefined(player.inFinalStand) || !player.inFinalStand) {
    if(data.attackerStance == "crouch") {
      player processChallenge("ch_crouchshot");
    } else if(data.attackerStance == "prone") {
      player processChallenge("ch_proneshot");
      if(weaponClass == "weapon_sniper") {
        player processChallenge("ch_invisible");
      }
    }
  }

  if(weaponClass == "weapon_sniper") {
    if(isDefined(data.modifiers["oneshotkill"])) {
      player processChallenge("ch_ghillie");
    }
  }

  if(isSubStr(data.sWeapon, "silencer")) {
    player processChallenge("ch_stealthvet");
  }
}

ch_roundplayed(data) {
  player = data.player;

  if(player.wasAliveAtMatchStart) {
    deaths = player.pers["deaths"];
    kills = player.pers["kills"];

    kdratio = 1000000;
    if(deaths > 0) {
      kdratio = kills / deaths;
    }

    if(kdratio >= 5.0 && kills >= 5.0) {
      player processChallenge("ch_starplayer");
    }

    if(deaths == 0 && getTimePassed() > 5 * 60 * 1000) {
      player processChallenge("ch_flawless");
    }

    if(level.placement["all"].size < 3) {
      return;
    }

    if(player.score > 0) {
      switch (level.gameType) {
        case "dm":
          if(data.place < 3) {
            player processChallenge("ch_victor_dm");
            player processChallenge("ch_ffa_win");
          }
          player processChallenge("ch_ffa_participate");
          break;
        case "war":
          if(data.winner) {
            player processChallenge("ch_war_win");
          }
          player processChallenge("ch_war_participate");
          break;
        case "kc":
          if(data.winner) {
            player processChallenge("ch_kc_win");
          }
          player processChallenge("ch_kc_participate");
          break;
        case "dd":
          if(data.winner) {
            player processChallenge("ch_dd_win");
          }
          player processChallenge("ch_dd_participate");
          break;
        case "koth":
          if(data.winner) {
            player processChallenge("ch_koth_win");
          }
          player processChallenge("ch_koth_participate");
          break;
        case "sab":
          if(data.winner) {
            player processChallenge("ch_sab_win");
          }
          player processChallenge("ch_sab_participate");
          break;
        case "sd":
          if(data.winner) {
            player processChallenge("ch_sd_win");
          }
          player processChallenge("ch_sd_participate");
          break;
        case "dom":
          if(data.winner) {
            player processChallenge("ch_dom_win");
          }
          player processChallenge("ch_dom_participate");
          break;
        case "ctf":
          if(data.winner) {
            player processChallenge("ch_ctf_win");
          }
          player processChallenge("ch_ctf_participate");
          break;
        case "tdef":
          if(data.winner) {
            player processChallenge("ch_tdef_win");
          }
          player processChallenge("ch_tdef_participate");
          break;
        case "hp":
          if(data.winner) {
            player processChallenge("ch_hp_win");
          }
          player processChallenge("ch_hp_participate");
      }
    }
  }
}

ch_roundwin(data) {
  if(!data.winner) {
    return;
  }

  player = data.player;
  if(player.wasAliveAtMatchStart) {
    switch (level.gameType) {
      case "war":
        if(level.hardcoreMode) {
          player processChallenge("ch_teamplayer_hc");
          if(data.place == 0) {
            player processChallenge("ch_mvp_thc");
          }
        } else {
          player processChallenge("ch_teamplayer");
          if(data.place == 0) {
            player processChallenge("ch_mvp_tdm");
          }
        }
        break;
      case "sab":
        player processChallenge("ch_victor_sab");
        break;
      case "sd":
        player processChallenge("ch_victor_sd");
        break;
      case "ctf":
      case "dom":
      case "dm":
      case "hc":
      case "koth":
      case "hp":
        break;
      default:
        break;
    }
  }
}

playerDamaged(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  if(isDefined(attacker)) {
    attacker endon("disconnect");
  }

  wait .05;
  WaitTillSlowProcessAllowed();

  data = spawnStruct();

  data.victim = self;
  data.eInflictor = eInflictor;
  data.attacker = attacker;
  data.iDamage = iDamage;
  data.sMeansOfDeath = sMeansOfDeath;
  data.sWeapon = sWeapon;
  data.sHitLoc = sHitLoc;

  data.victimOnGround = data.victim isOnGround();

  if(isPlayer(attacker)) {
    data.attackerInLastStand = isDefined(data.attacker.lastStand);
    data.attackerOnGround = data.attacker isOnGround();
    data.attackerStance = data.attacker getStance();
  } else {
    data.attackerInLastStand = false;
    data.attackerOnGround = false;
    data.attackerStance = "stand";
  }

  if(isDefined(self) && isDefined(attacker) && isDefined(self.team) && isDefined(attacker.team)) {
    if((self.team != attacker.team) && self _hasPerk("specialty_class_flakjacket") && IsExplosiveDamageMOD(data.sMeansOfDeath) && isReallyAlive(self) && sWeapon != "killstreak_solar_mp") {
      self processChallenge("ch_perk_flakjack");
    }

    if((self.team != attacker.team) && self _hasPerk("specialty_class_toughness")) {
      self.lastDamageFromEnemyTargetTime = GetTime();
    }
  }

  doMissionCallback("playerDamaged", data);
}

playerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc, modifiers) {
  self.anglesOnDeath = self getPlayerAngles();
  if(isDefined(attacker)) {
    attacker.anglesOnKill = attacker getPlayerAngles();
  }

  self endon("disconnect");

  data = spawnStruct();

  data.victim = self;
  data.eInflictor = eInflictor;
  data.attacker = attacker;
  data.iDamage = iDamage;
  data.sMeansOfDeath = sMeansOfDeath;
  data.sWeapon = sWeapon;
  data.sPrimaryWeapon = sPrimaryWeapon;
  data.sHitLoc = sHitLoc;
  data.time = gettime();
  data.modifiers = modifiers;

  data.victimOnGround = data.victim isOnGround();

  if(isPlayer(attacker)) {
    data.attackerInLastStand = isDefined(data.attacker.lastStand);
    data.attackerOnGround = data.attacker isOnGround();
    data.attackerStance = data.attacker getStance();
  } else {
    data.attackerInLastStand = false;
    data.attackerOnGround = false;
    data.attackerStance = "stand";
  }

  ads_ratio = 0;
  if(isDefined(data.eInflictor) && isDefined(data.eInflictor.firedAds)) {
    ads_ratio = data.eInflictor.firedAds;
  } else if(isDefined(attacker) && isPlayer(attacker)) {
    ads_ratio = attacker PlayerAds();
  }

  data.was_ads = false;
  if(ads_ratio >= 0.2) {
    data.was_ads = true;
  }

  waitAndProcessPlayerKilledCallback(data);

  if(isDefined(attacker) && isReallyAlive(attacker)) {
    attacker.killsThisLife[attacker.killsThisLife.size] = data;
  }

  data.attacker notify("playerKilledChallengesProcessed");
}

vehicleKilled(owner, vehicle, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon) {
  data = spawnStruct();

  data.vehicle = vehicle;
  data.victim = owner;
  data.eInflictor = eInflictor;
  data.attacker = attacker;
  data.iDamage = iDamage;
  data.sMeansOfDeath = sMeansOfDeath;
  data.sWeapon = sWeapon;
  data.time = gettime();

  doMissionCallback("vehicleKilled", data);
}

waitAndProcessPlayerKilledCallback(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon("disconnect");
  }

  self.processingKilledChallenges = true;
  wait 0.05;
  WaitTillSlowProcessAllowed();

  doMissionCallback("playerKilled", data);
  self.processingKilledChallenges = undefined;
}

playerAssist() {
  data = spawnStruct();

  data.player = self;

  doMissionCallback("playerAssist", data);
}

useHardpoint(hardpointType) {
  self endon("disconnect");

  wait .05;
  WaitTillSlowProcessAllowed();

  data = spawnStruct();

  data.player = self;
  data.hardpointType = hardpointType;

  doMissionCallback("playerHardpoint", data);
}

roundBegin() {
  if(GetDvarInt("debug_challenges", 0) == 1) {
    if(inVirtualLobby())
  }
  return;

  doMissionCallback("roundBegin");
}

roundEnd(winner) {
  data = spawnStruct();

  if(level.teamBased) {
    team = "allies";
    for(index = 0; index < level.placement[team].size; index++) {
      data.player = level.placement[team][index];
      data.winner = (team == winner);
      data.place = index;

      doMissionCallback("roundEnd", data);
    }
    team = "axis";
    for(index = 0; index < level.placement[team].size; index++) {
      data.player = level.placement[team][index];
      data.winner = (team == winner);
      data.place = index;

      doMissionCallback("roundEnd", data);
    }
  } else {
    for(index = 0; index < level.placement["all"].size; index++) {
      data.player = level.placement["all"][index];
      data.winner = (isDefined(winner) && isPlayer(winner) && (data.player == winner));
      data.place = index;

      doMissionCallback("roundEnd", data);
    }
  }
}

doMissionCallback(callback, data) {
  if(!mayProcessChallenges()) {
    return;
  }

  if(getDvarInt("disable_challenges") > 0) {
    return;
  }

  if(!isDefined(level.missionCallbacks[callback])) {
    return;
  }

  if(isDefined(data)) {
    for(i = 0; i < level.missionCallbacks[callback].size; i++) {
      thread[[level.missionCallbacks[callback][i]]](data);
    }
  } else {
    for(i = 0; i < level.missionCallbacks[callback].size; i++) {
      thread[[level.missionCallbacks[callback][i]]]();
    }
  }
}

monitorSprintDistance() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");

  while(1) {
    self waittill("sprint_begin");

    self.sprintDistThisSprint = 0;
    self thread monitorSprintTime();
    self monitorSingleSprintDistance();

    if(self IsItemUnlocked("specialty_longersprint") && self _hasPerk("specialty_longersprint")) {
      self processChallenge("ch_longersprint_pro", int(self.sprintDistThisSprint / 12));
    }
  }
}

monitorSingleSprintDistance() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");
  self endon("sprint_end");

  prevpos = self.origin;
  while(1) {
    wait .1;

    self.sprintDistThisSprint += distance(self.origin, prevpos);
    prevpos = self.origin;
  }
}

monitorSprintTime() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");

  self waittill("sprint_end");

  self.lastSprintEndTime = GetTime();
}

monitorFallDistance() {
  self endon("disconnect");
  level endon("game_ended");

  while(1) {
    if(!isAlive(self)) {
      self waittill("spawned_player");
      continue;
    }

    if(!self isOnGround()) {
      highestPoint = self.origin[2];
      while(!self isOnGround() && isAlive(self)) {
        if(self.origin[2] > highestPoint) {
          highestPoint = self.origin[2];
        }
        wait .05;
      }

      falldist = highestPoint - self.origin[2];
      if(falldist < 0) {
        falldist = 0;
      }

      if(falldist / 12.0 > 15 && isAlive(self) && self isEMPed()) {
        self processChallenge("ch_boot_shortcut");
      }

      if(falldist / 12.0 > 30 && !isAlive(self) && self isEMPed()) {
        self processChallenge("ch_boot_gravity");
      }
    }
    wait .05;
  }
}

monitorBoostJumpDistance() {
  level endon("game_ended");
  self endon("disconnect");

  while(1) {
    if(!isAlive(self)) {
      self waittill("spawned_player");
      continue;
    }

    self waittill("exo_boost");

    if(!self isOnGround()) {
      highestPoint = self.origin[2];
      startingPoint = self.origin[2];
      while(!self isOnGround() && isAlive(self)) {
        if(self.origin[2] > highestPoint) {
          highestPoint = self.origin[2];
        }
        wait .05;
      }

      jumpHeight = highestPoint - startingPoint;

      if(jumpHeight < 0) {
        jumpHeight = 0;
      }

      self processChallenge("ch_exomech_frontier", int(ceil(jumpHeight / 12 / 10)));
    }
    wait .05;
  }
}

monitorPlayerMatchChallenges() {
  self thread monitorMatchChallenges("increment_knife_kill", 15, "ch_precision_slice");

  self thread monitorMatchChallenges("increment_stuck_kills", 5, "ch_precision_ticktick");

  self thread monitorMatchChallenges("increment_pistol_headshots", 10, "ch_precision_pistoleer");

  self thread monitorMatchChallenges("increment_ar_headshots", 5, "ch_precision_headhunt");

  self thread monitorMatchChallenges("increment_sharpshooter_kills", 10, "ch_precision_sharpshoot");

  self thread monitorMatchChallenges("increment_oneshotgun_kills", 10, "ch_precision_cqexpert");

  self thread monitorMatchChallenges("increment_duallethal_kills", 5, "ch_precision_dangerclose");
}

monitorMatchChallenges(sNotify, target_value, challenge) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(game[challenge])) {
    game[challenge] = [];
  }

  if(!isDefined(game[challenge][self.guid])) {
    game[challenge][self.guid] = 0;
  }

  self thread remove_tracking_on_disconnect(challenge);

  while(true) {
    self waittill(sNotify);

    counter = game[challenge][self.guid];
    counter++;
    game[challenge][self.guid] = counter;
    if(counter == target_value) {
      self processChallenge(challenge);
    }
  }
}

remove_tracking_on_disconnect(challenge) {
  level endon("game_ended");

  self waittill("disconnect");

  if(isDefined(game[challenge][self.guid])) {
    game[challenge][self.guid] = undefined;
  }
}

lastManSD() {
  if(!mayProcessChallenges()) {
    return;
  }

  if(!self.wasAliveAtMatchStart) {
    return;
  }

  if(self.teamkillsThisRound > 0) {
    return;
  }

  self processChallenge("ch_lastmanstanding");
}

monitorBombUse() {
  self endon("disconnect");

  for(;;) {
    result = self waittill_any_return("bomb_planted", "bomb_defused");

    if(!isDefined(result)) {
      continue;
    }

    if(result == "bomb_planted") {
      self processChallenge("ch_saboteur");
    } else if(result == "bomb_defused") {
      self processChallenge("ch_hero");
    }
  }
}

monitorLiveTime() {
  for(;;) {
    self waittill("spawned_player");

    self thread survivalistChallenge();
  }
}

survivalistChallenge() {
  self endon("death");
  self endon("disconnect");

  wait 5 * 60;

  if(isDefined(self)) {
    self processChallenge("ch_survivalist");
  }
}

monitorStreaks() {
  self endon("disconnect");

  self.pers["airstrikeStreak"] = 0;
  self.pers["meleeKillStreak"] = 0;
  self.pers["shieldKillStreak"] = 0;

  self thread monitorMisc();

  for(;;) {
    self waittill("death");

    self.pers["airstrikeStreak"] = 0;
    self.pers["meleeKillStreak"] = 0;
    self.pers["shieldKillStreak"] = 0;
  }
}

monitorMisc() {
  self endon("disconnect");

  while(true) {
    waittillString = self waittill_any_return_no_endon_death("destroyed_explosive", "begin_airstrike", "destroyed_car", "destroyed_car");

    monitorMiscCallback(waittillString);
  }
}

monitorMiscCallback(result) {
  assert(isDefined(result));

  switch (result) {
    case "begin_airstrike": {
      self.pers["airstrikeStreak"] = 0;
      break;
    }
    case "destroyed_explosive": {
      self processChallenge("ch_backdraft");

      if(self IsItemUnlocked("specialty_detectexplosive") && self _hasPerk("specialty_detectexplosive")) {
        self processChallenge("ch_detectexplosives_pro");
      }

      break;
    }
    case "destroyed_car": {
      self processChallenge("ch_vandalism");
      break;
    }
    case "crushed_enemy": {
      self processChallenge("ch_heads_up");

      if(isDefined(self.finalKill)) {
        self processChallenge("ch_droppincrates");
      }

      break;
    }
  }
}

healthRegenerated() {
  if(!isalive(self)) {
    return;
  }

  if(!mayProcessChallenges()) {
    return;
  }

  if(!self rankingEnabled()) {
    return;
  }

  self thread resetBrinkOfDeathKillStreakShortly();

  if(isDefined(self.lastDamageWasFromEnemy) && self.lastDamageWasFromEnemy) {
    self.healthRegenerationStreak++;
    if(self.healthRegenerationStreak >= 5) {
      self processChallenge("ch_invincible");
    }
  }
}

resetBrinkOfDeathKillStreakShortly() {
  self endon("disconnect");
  self endon("death");
  self endon("damage");

  wait 1;

  self.brinkOfDeathKillStreak = 0;
}

playerSpawned() {
  self.brinkOfDeathKillStreak = 0;
  self.healthRegenerationStreak = 0;
}

playerDied() {
  self.brinkOfDeathKillStreak = 0;
  self.healthRegenerationStreak = 0;
}

isAtBrinkOfDeath() {
  ratio = self.health / self.maxHealth;
  return (ratio <= level.healthOverlayCutoff);
}

processChallenge(baseName, progressInc, forceSetProgress) {
  if(!mayProcessChallenges()) {
    return;
  }

  if((level.players.size < 2) && !getdvarint("force_ranking")) {
    debug_challenges = undefined;
    debug_challenges = getDvarInt("debug_challenges", 0);
    if(isDefined(debug_challenges)) {
      if(debug_challenges == 0) {
        return;
      }
    } else {
      return;
    }
  }

  if(!self rankingEnabled()) {
    return;
  }

  if(!isDefined(progressInc)) {
    progressInc = 1;
  }

  if(getDvarInt("debug_challenges")) {
    println("CHALLENGE PROGRESS - " + baseName + ": " + progressInc);
  }

  missionStatus = getChallengeStatus(baseName);

  if(missionStatus == 0) {
    return;
  }

  if(missionStatus > level.challengeInfo[baseName]["targetval"].size) {
    return;
  }

  currentProgress = ch_getProgress(baseName);

  if(isDefined(forceSetProgress) && forceSetProgress) {
    newProgress = progressInc;
    assertex(newProgress >= currentProgress, "Attempted progress regression (forceSet) for challenge '" + baseName + "' - from " + currentProgress + " to " + newProgress + " for player " + self.name);
  } else if(isWeaponClassChallenge(baseName)) {
    newProgress = currentProgress;
  } else {
    newProgress = currentProgress + progressInc;
    assertex(newProgress >= currentProgress, "Attempted progress regression (inc) for challenge '" + baseName + "' - from " + currentProgress + " to " + newProgress + " for player " + self.name);
  }

  tiersReached = 0;
  targetProgress = level.challengeInfo[baseName]["targetval"][missionStatus];
  while(isDefined(targetProgress) && newProgress >= targetProgress) {
    tiersReached++;
    targetProgress = level.challengeInfo[baseName]["targetval"][missionStatus + tiersReached];
  }

  if(currentProgress < newProgress) {
    self ch_setProgress(baseName, newProgress);
  }

  if(tiersReached > 0) {
    originalMissionStatus = missionStatus;

    while(tiersReached) {
      self thread giveRankXpAfterWait(baseName, missionStatus);

      challengeID = getchallengeid(baseName, missionStatus);
      self ChallengeNotification(challengeID);
      challengeID_string = toString(challengeID);
      ch_uid = int(GetSubStr(challengeID_string, 0, (challengeID_string.size - 2)));

      if(!isDefined(game["challengeStruct"]["challengesCompleted"][self.guid])) {
        game["challengeStruct"]["challengesCompleted"][self.guid] = [];
      }

      chFound = false;
      foreach(challenge in game["challengeStruct"]["challengesCompleted"][self.guid]) {
        if(challenge == ch_uid) {
          chFound = true;
        }
      }
      if(!chFound) {
        game["challengeStruct"]["challengesCompleted"][self.guid][(game["challengeStruct"]["challengesCompleted"][self.guid].size)] = ch_uid;
      }

      if((missionStatus >= level.challengeInfo[baseName]["targetval"].size) && level.challengeInfo[baseName]["parent_challenge"] != "") {
        self maps\mp\gametypes\_missions::processChallenge(level.challengeInfo[baseName]["parent_challenge"]);
      }

      missionStatus++;
      tiersReached--;

      rewardItemID = getchallengerewarditem(challengeID);

      if(rewardItemID != 0) {
        self maps\mp\_matchdata::logCompletedChallenge(challengeID);
      }
    }

    if(!(IsSubStr(baseName, "ch_limited_bloodshed"))) {
      self thread maps\mp\gametypes\_hud_message::challengeSplashNotify(baseName, originalMissionStatus, missionStatus);
    }

    self ch_setState(baseName, missionStatus);
    self.challengeData[baseName] = missionStatus;
  }
}

giveRankXpAfterWait(baseName, missionStatus) {
  self endon("disconnect");

  wait(0.25);
  self maps\mp\gametypes\_rank::giveRankXP("challenge", level.challengeInfo[baseName]["reward"][missionStatus], undefined, undefined, baseName);
}

getMarksmanUnlockAttachment(baseName, index) {
  return (tableLookup(UNLOCK_TABLE_REF, 0, baseName, 4 + index));
}

masteryChallengeProcess(baseWeapon) {
  if(tableLookup(ALL_CHALLENGES_TABLE_REF, 0, "ch_" + baseWeapon + "_mastery", 1) == "") {
    return;
  }

  progress = 0;
  all_attachments = getWeaponAttachmentFromStats(baseWeapon);
  foreach(attachmentName in all_attachments) {
    if(attachmentName == "") {
      continue;
    }

    if(self maps\mp\gametypes\_class::isAttachmentUnlocked(baseWeapon, attachmentName)) {
      progress++;
    }
  }

  processChallenge("ch_" + baseWeapon + "_mastery", progress, true);
}

isChallengeUnlocked(challengeRef, challengeIndex) {
  prestigeShopString = tableLookupByRow(ALL_CHALLENGES_TABLE_REF, challengeIndex, CH_PRESTIGE_COL);
  if(prestigeShopString != "") {
    prestigeShopStatus = self getChallengeStatus(prestigeShopString);

    if(prestigeShopStatus > 1) {
      return true;
    }
  }

  rankString = tableLookupByRow(ALL_CHALLENGES_TABLE_REF, challengeIndex, CH_LEVEL_COL);
  if(rankString != "") {
    rank = self maps\mp\gametypes\_rank::getRank();
    if(rank < int(rankString)) {
      return false;
    }
  }

  challengeString = tableLookupByRow(ALL_CHALLENGES_TABLE_REF, challengeIndex, CH_CHALLENGE_COL);
  if(challengeString != "") {
    challengeStatus = self getChallengeStatus(challengeString);

    if(challengeStatus <= 1) {
      return false;
    }
  }

  return true;
}

updateChallenges() {
  self.challengeData = [];

  if(!isDefined(self.ch_unique_earned_streaks)) {
    self.ch_unique_earned_streaks = [];
  }

  if(!isDefined(game["challengeStruct"])) {
    game["challengeStruct"] = [];
  }

  if(!isDefined(game["challengeStruct"]["limitedChallengesReset"])) {
    game["challengeStruct"]["limitedChallengesReset"] = [];
  }

  if(!isDefined(game["challengeStruct"]["challengesCompleted"])) {
    game["challengeStruct"]["challengesCompleted"] = [];
  }

  self endon("disconnect");

  if(!mayProcessChallenges()) {
    return;
  }

  if(!self IsItemUnlocked("challenges")) {
    return;
  }

  challengeCount = 0;

  foreach(challengeRef, levelChallengeData in level.challengeInfo) {
    challengeCount++;
    if((challengeCount % 40) == 0) {
      wait(0.05);
    }

    self.challengeData[challengeRef] = 0;

    assertEx(isDefined(levelChallengeData["index"]), "Challenge index not defined: " + challengeRef + " for player " + self.name + " from " + level.challengeInfo.size + " total challenges");
    challengeIndex = levelChallengeData["index"];

    status = ch_getState(challengeRef);
    if(isTimeLimitedChallenge(challengeRef) && !isDefined(game["challengeStruct"]["limitedChallengesReset"][self.guid])) {
      self ch_setProgress(challengeRef, 0);
      status = 0;
    }

    if(status == 0) {
      ch_setState(challengeRef, 1);
      status = 1;
    }

    self.challengeData[challengeRef] = status;
  }

  game["challengeStruct"]["limitedChallengesReset"][self.guid] = true;
}

isInUnlockTable(challengeName) {
  return (TableLookup(UNLOCK_TABLE_REF, 0, challengeName, 0) != "");
}

getChallengeFilter(challengeName) {
  return TableLookup(ALL_CHALLENGES_TABLE_REF, 0, challengeName, 5);
}

getChallengeTable(challengeFilter) {
  return TableLookup(CHALLENGE_TABLE_REF, 8, challengeFilter, 4);
}

getTierFromTable(challengeTable, challengeName) {
  return TableLookup(challengeTable, 0, challengeName, 1);
}

isWeaponChallenge(challengeName) {
  if(!isDefined(challengeName)) {
    return false;
  }

  tableValue = getChallengeFilter(challengeName);
  if(isDefined(tableValue) && tableValue == "riotshield") {
    return true;
  }

  tokens = getWeaponNameTokens(challengeName);
  for(i = 0; i < tokens.size; i++) {
    concatName = tokens[i];
    if(concatName == "iw5" || concatName == "iw6") {
      concatName = tokens[i] + "_" + tokens[i + 1];
    }

    if(maps\mp\gametypes\_class::isValidPrimary(concatName) || maps\mp\gametypes\_class::isValidSecondary(concatName, false)) {
      return true;
    }
  }

  return false;
}

getWeaponFromChallenge(challengeRef) {
  prefix = "ch_";
  if(isSubStr(challengeRef, "ch_marksman_")) {
    prefix = "ch_marksman_";
  } else if(isSubStr(challengeRef, "ch_expert_")) {
    prefix = "ch_expert_";
  } else if(isSubStr(challengeRef, "pr_marksman_")) {
    prefix = "pr_marksman_";
  } else if(isSubStr(challengeRef, "pr_expert_")) {
    prefix = "pr_expert_";
  }

  weaponName = GetSubStr(challengeRef, prefix.size, challengeRef.size);

  weaponTokens = getWeaponNameTokens(weaponName);
  weaponName = undefined;
  if(weaponTokens[0] == "iw5" || weaponTokens[0] == "iw6") {
    weaponName = weaponTokens[0] + "_" + weaponTokens[1];
  } else {
    weaponName = weaponTokens[0];
  }

  return weaponName;
}

getWeaponAttachmentFromChallenge(challengeRef) {
  prefix = "ch_";
  if(isSubStr(challengeRef, "ch_marksman_")) {
    prefix = "ch_marksman_";
  } else if(isSubStr(challengeRef, "ch_expert_")) {
    prefix = "ch_expert_";
  } else if(isSubStr(challengeRef, "pr_marksman_")) {
    prefix = "pr_marksman_";
  } else if(isSubStr(challengeRef, "pr_expert_")) {
    prefix = "pr_expert_";
  }

  baseWeapon = GetSubStr(challengeRef, prefix.size, challengeRef.size);

  weaponTokens = getWeaponNameTokens(baseWeapon);
  attachment = undefined;
  if(isDefined(weaponTokens[2]) && isAttachment(weaponTokens[2])) {
    attachment = weaponTokens[2];
  }

  return attachment;
}

isKillstreakChallenge(challengeName) {
  if(!isDefined(challengeName)) {
    return false;
  }

  tableValue = getChallengeFilter(challengeName);
  if(isDefined(tableValue) && (tableValue == "killstreaks_assault" || tableValue == "killstreaks_support")) {
    return true;
  }

  return false;
}

getKillstreakFromChallenge(challengeRef) {
  prefix = "ch_";
  killstreakName = GetSubStr(challengeRef, prefix.size, challengeRef.size);

  if(killstreakName == "assault_streaks" || killstreakName == "support_streaks") {
    killstreakName = undefined;
  }

  return killstreakName;
}

challenge_targetVal(tableName, refString, tierId) {
  value = tableLookup(tableName, CH_REF_COL, refString, CH_TARGET_COL + ((tierId - 1) * 2));
  return int(value);
}

challenge_rewardVal(tableName, refString, tierId) {
  value = tableLookup(tableName, CH_REF_COL, refString, CH_REWARD_COL + ((tierId - 1) * 2));
  return int(value);
}

challenge_parentChallenge(tableName, stringRef) {
  value = tableLookup(tableName, CH_REF_COL, stringRef, CH_PARENTCHALLENGE_COL);
  if(!isDefined(value)) {
    value = "";
  }
  return value;
}

buildChallengeTableInfo(tableName, typeId) {
  totalRewardXP = 0;
  index = 0;
  while(true) {
    index++;
    refString = tableLookupByRow(tableName, index, CH_REF_COL);
    if(refString == "") {
      break;
    }

    skipValidation = TableLookupByRow(tableName, index, CH_SKIPVALIDATION_COL);
    if(skipValidation == "1") {
      continue;
    }

    assertEx(isSubStr(refString, "ch_") || isSubStr(refString, "pr_"), "Invalid challenge name: " + refString + " found in " + tableName);

    level.challengeInfo[refString] = [];
    level.challengeInfo[refString]["index"] = index;
    level.challengeInfo[refString]["type"] = typeId;
    level.challengeInfo[refString]["targetval"] = [];
    level.challengeInfo[refString]["reward"] = [];
    level.challengeInfo[refString]["parent_challenge"] = "";

    if(isWeaponChallenge(refString)) {
      baseWeapon = getWeaponFromChallenge(refString);
      attachment = getWeaponAttachmentFromChallenge(refString);

      if(isDefined(baseWeapon)) {
        level.challengeInfo[refString]["weapon"] = baseWeapon;
      }
      if(isDefined(attachment)) {
        level.challengeInfo[refString]["attachment"] = attachment;
      }
    } else if(isKillstreakChallenge(refString)) {
      killstreakName = getKillstreakFromChallenge(refString);
      if(isDefined(killstreakName)) {
        level.challengeInfo[refString]["killstreak"] = killstreakName;
      }
    }

    for(tierId = 1; tierId < 11; tierId++) {
      targetVal = challenge_targetVal(tableName, refString, tierId);
      rewardVal = challenge_rewardVal(tableName, refString, tierId);

      if(targetVal == 0) {
        break;
      }

      level.challengeInfo[refString]["targetval"][tierId] = targetVal;
      level.challengeInfo[refString]["reward"][tierId] = rewardVal;

      totalRewardXP += rewardVal;
    }

    level.challengeInfo[refString]["parent_challenge"] = challenge_parentChallenge(tableName, refstring);

    assert(isDefined(level.challengeInfo[refString]["targetval"][1]));
  }

  printLn("Added " + (index - 1) + " challenges from " + tableName);

  return int(totalRewardXP);
}

buildChallegeInfo() {
  level.challengeInfo = [];
  if(getDvar("virtualLobbyActive") == "1") {
    return;
  }

  totalRewardXP = 0;

  totalRewardXP += buildChallengeTableInfo(ALL_CHALLENGES_TABLE_REF, CH_REGULAR);

  printLn("TOTAL CHALLENGE REWARD XP: " + totalRewardXP);
}

verifyMarksmanChallenges() {}

verifyExpertChallenges() {}

completeAllChallenges(percentage) {
  foreach(challengeRef, challengeData in level.challengeInfo) {
    finalTarget = 0;
    finalTier = 0;
    for(tierId = 1; isDefined(challengeData["targetval"][tierId]); tierId++) {
      finalTarget = challengeData["targetval"][tierId];
      finalTier = tierId + 1;
    }

    if(percentage != 1.0) {
      finalTarget--;
      finalTier--;
    }

    if(self IsItemUnlocked(challengeRef) || percentage == 1.0) {
      self maps\mp\gametypes\_hud_util::ch_setProgress(challengeRef, finalTarget);
      self maps\mp\gametypes\_hud_util::ch_setState(challengeRef, finalTier);
    }

    wait(0.05);
  }

  println("Done unlocking challenges");
}

monitorProcessChallenge() {
  self endon("disconnect");
  level endon("game_end");

  for(;;) {
    if(!mayProcessChallenges()) {
      return;
    }

    self waittill("process", challengeName);
    self processChallenge(challengeName);
  }
}

monitorKillstreakProgress() {
  self endon("disconnect");
  level endon("game_end");

  for(;;) {
    self waittill("got_killstreak", streakCount);

    if(!isDefined(streakCount)) {
      continue;
    }

    if((streakCount == 9) && isDefined(self.killstreaks[7]) && isDefined(self.killstreaks[8]) && isDefined(self.killstreaks[9])) {
      self processChallenge("ch_6fears7");
    }

    if(streakCount == 10 && self.killstreaks.size == 0) {
      self processChallenge("ch_theloner");
    }
  }
}

monitorKilledKillstreak() {
  self endon("disconnect");
  level endon("game_end");

  for(;;) {
    self waittill("destroyed_killstreak", weapon);

    if(self IsItemUnlocked("specialty_blindeye") && self _hasPerk("specialty_blindeye")) {
      self processChallenge("ch_blindeye_pro");
    }

    if(isDefined(weapon) && weapon == "stinger_mp") {
      self processChallenge("ch_marksman_stinger");
      self processChallenge("pr_marksman_stinger");
    }
  }
}

genericChallenge(challengeType, value) {
  switch (challengeType) {
    case "hijacker_airdrop":
      self processChallenge("ch_smoothcriminal");
      break;
    case "wargasm":
      self processChallenge("ch_wargasm");
      break;
    case "weapon_assault":
      self processChallenge("ch_surgical_assault");
      break;
    case "weapon_smg":
      self processChallenge("ch_surgical_smg");
      break;
    case "weapon_lmg":
      self processChallenge("ch_surgical_lmg");
      break;
    case "weapon_dmr":

      break;
    case "weapon_sniper":
      self processChallenge("ch_surgical_sniper");
      break;
    case "shield_damage":
      if(!self isJuggernaut()) {
        self processChallenge("ch_shield_damage", value);
      }
      break;
    case "shield_bullet_hits":
      if(!self isJuggernaut()) {
        self processChallenge("ch_shield_bullet", value);
      }
      break;
    case "shield_explosive_hits":
      if(!self isJuggernaut()) {
        self processChallenge("ch_shield_explosive", value);
      }
      break;
  }
}

playerHasAmmo() {
  primaryWeapons = self getWeaponsListPrimaries();

  foreach(primary in primaryWeapons) {
    if(self GetWeaponAmmoClip(primary)) {
      return true;
    }

    altWeapon = weaponAltWeaponName(primary);

    if(!isDefined(altWeapon) || (altWeapon == "none")) {
      continue;
    }

    if(self GetWeaponAmmoClip(altWeapon)) {
      return true;
    }
  }

  return false;
}

monitorADSTime() {
  self endon("disconnect");

  self.adsTime = 0.0;
  while(true) {
    if(self PlayerAds() == 1) {
      self.adsTime += 0.05;
    } else {
      self.adsTime = 0.0;
    }

    wait(0.05);
  }
}

monitorProneTime() {
  self endon("disconnect");
  level endon("game_ended");

  self.proneTime = undefined;
  was_prev_prone = false;
  while(true) {
    stance = self GetStance();
    if(stance == "prone" && was_prev_prone == false) {
      self.proneTime = getTime();
      was_prev_prone = true;
    } else if(stance != "prone") {
      self.proneTime = undefined;
      was_prev_prone = false;
    }

    wait(0.05);
  }
}

monitorPowerSlideTime() {
  self endon("disconnect");
  level endon("game_ended");

  self.powerslideTime = undefined;

  while(true) {
    while(!self IsPowerSliding()) {
      wait 0.05;
    }

    self.powerslideTime = getTime();

    wait(0.05);
  }
}

monitorHoldBreath() {
  self endon("disconnect");

  self.holdingBreath = false;
  while(true) {
    self waittill("hold_breath");
    self.holdingBreath = true;
    self waittill("release_breath");
    self.holdingBreath = false;
  }
}

monitorMantle() {
  self endon("disconnect");

  self.mantling = false;
  while(true) {
    self waittill("jumped");
    prevWeaponName = self GetCurrentWeapon();
    self waittill_notify_or_timeout("weapon_change", 1);
    currWeaponName = self GetCurrentWeapon();
    if(currWeaponName == "none") {
      self.mantling = true;
    } else {
      self.mantling = false;
    }

    if(self.mantling) {
      if(self IsItemUnlocked("specialty_fastmantle") && self _hasPerk("specialty_fastmantle")) {
        self processChallenge("ch_fastmantle");
      }

      self waittill_notify_or_timeout("weapon_change", 1);
      currWeaponName = self GetCurrentWeapon();
      if(currWeaponName == prevWeaponName) {
        self.mantling = false;
      }
    }
  }
}

monitorWeaponSwap() {
  self endon("disconnect");

  prevWeaponName = self GetCurrentWeapon();
  while(true) {
    self waittill("weapon_change", newWeaponName);

    if(newWeaponName == "none") {
      continue;
    }

    if(newWeaponName == prevWeaponName) {
      continue;
    }

    if(isKillstreakWeapon(newWeaponName)) {
      continue;
    }

    if(isBombSiteWeapon(newWeaponName)) {
      continue;
    }

    weaponInvType = WeaponInventoryType(newWeaponName);
    if(weaponInvType != "primary") {
      continue;
    }

    self.lastPrimaryWeaponSwapTime = GetTime();
  }
}

monitorFlashbang() {
  self endon("disconnect");

  while(true) {
    self waittill("flashbang", origin, amount_distance, amount_angle, attacker);

    if(isDefined(attacker) && (self == attacker)) {
      continue;
    }

    self.lastFlashedTime = GetTime();
  }
}

monitorConcussion() {
  self endon("disconnect");

  while(true) {
    self waittill("concussed", attacker);

    if(self == attacker) {
      continue;
    }

    self.lastConcussedTime = GetTime();
  }
}

monitorMineTriggering() {
  self endon("disconnect");

  while(true) {
    self waittill_any("triggered_mine", "triggered_claymore");

    self thread waitDelayMineTime();
  }
}

waitDelayMineTime() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  wait(level.delayMineTime + 2);

  self processChallenge("ch_delaymine");
}

is_lethal_equipment(equipment) {
  if(!isDefined(equipment)) {
    return false;
  }

  switch (equipment) {
    case "frag_grenade_mp":
    case "semtex_mp":
    case "exoknife_mp":
    case "explosive_drone_mp":
      return true;
    default:
      return false;
  }
}