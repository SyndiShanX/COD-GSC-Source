/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_events.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init() {
  game_type_col = [];
  game_type_col["dm"] = 3;
  game_type_col["war"] = 4;
  game_type_col["sd"] = 5;
  game_type_col["dom"] = 6;
  game_type_col["conf"] = 7;
  game_type_col["sr"] = 8;
  game_type_col["bnty"] = 9;
  game_type_col["grind"] = 10;
  game_type_col["blitz"] = 11;
  game_type_col["cranked"] = 12;
  game_type_col["infect"] = 13;
  game_type_col["sotf"] = 14;
  game_type_col["sotf_ffa"] = 15;
  game_type_col["horde"] = 16;
  game_type_col["mugger"] = 17;
  game_type_col["aliens"] = 18;
  game_type_col["gun"] = 19;
  game_type_col["grnd"] = 20;
  game_type_col["siege"] = 21;

  game_type = level.gameType;
  if(!isDefined(game_type)) {
    game_type = GetDvar("g_gametype");
  }

  row = 0;
  while(true) {
    value = TableLookupByRow("mp/xp_event_table.csv", row, game_type_col[game_type]);
    if(!isDefined(value) || value == "") {
      break;
    }

    ref = TableLookupByRow("mp/xp_event_table.csv", row, 0);

    if(ref == "win" || ref == "loss" || ref == "tie") {
      value = float(value);
    } else {
      value = int(value);
    }

    if(value != -1) {
      maps\mp\gametypes\_rank::registerScoreInfo(ref, value);
    }

    row++;
  }

  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("damage", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("heavy_damage", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("damaged", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("kill", 1);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("killed", 0);

  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("healed", 0);

  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("headshot", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("melee", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("backstab", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("longshot", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("pointblank", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("assistedsuicide", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("defender", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("avenger", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("execution", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("comeback", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("revenge", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("buzzkill", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("double", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("triple", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("multi", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("assist", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("firstBlood", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("capture", 1);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("assistedCapture", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("plant", 1);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("defuse", 1);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("vehicleDestroyed", 1);

  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("3streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("4streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("5streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("6streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("7streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("8streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("9streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("10streak", 0);
  maps\mp\killstreaks\_killstreaks::registerAdrenalineInfo("regen", 0);

  precacheShader("crosshair_red");

  level._effect["money"] = loadfx("fx/props/cash_player_drop");

  level.numKills = 0;

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player.killedPlayers = [];
    player.killedPlayersCurrent = [];
    player.ch_extremeCrueltyComplete = false;
    player.ch_tangoDownComplete = false;
    player.killedBy = [];
    player.lastKilledBy = undefined;
    player.greatestUniquePlayerKills = 0;

    player.recentKillCount = 0;
    player.lastKillTime = 0;
    player.lastKillDogTime = 0;
    player.damagedPlayers = [];

    player thread monitorCrateJacking();
    player thread monitorObjectives();
    player thread monitorHealed();
  }
}

damagedPlayer(victim, damage, weapon) {
  if(damage < 50 && damage > 10) {
    self maps\mp\killstreaks\_killstreaks::giveAdrenaline("damage");
  } else {
    self maps\mp\killstreaks\_killstreaks::giveAdrenaline("heavy_damage");
  }
}

killedPlayerNotifySys(killId, victim, weapon, meansOfDeath) {
  self endon("disconnect");
  level endon("game_ended");

  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self.killsInAFrameCount)) {
    self.killsInAFrameCount = 0;
  }

  self.killsInAFrameCount++;

  wait(0.05);

  if(self.killsInAFrameCount > 1) {
    self thread notifyKilledPlayer(killId, victim, weapon, meansOfDeath, self.killsInAFrameCount);
  } else {
    self notify("got_a_kill", victim, weapon, meansOfDeath);
  }

  self.killsInAFrameCount = 0;
}

notifyKilledPlayer(killId, victim, weapon, meansOfDeath, numKills) {
  for(i = 0; i < numKills; i++) {
    self notify("got_a_kill", victim, weapon, meansOfDeath);
    wait(0.05);
  }
}

killedPlayer(killId, victim, weapon, meansOfDeath) {
  victimGuid = victim.guid;
  myGuid = self.guid;
  curTime = getTime();

  self thread killedPlayerNotifySys(killId, victim, weapon, meansOfDeath);
  self thread updateRecentKills(killId);
  self.lastKillTime = getTime();
  self.lastKilledPlayer = victim;

  self.modifiers = [];

  level.numKills++;

  self.damagedPlayers[victimGuid] = undefined;

  if(!isKillstreakWeapon(weapon) && !self isJuggernaut() && !self _hasPerk("specialty_explosivebullets")) {
    if(weapon == "none") {
      return false;
    }

    if(victim.attackers.size == 1 && !isDefined(victim.attackers[victim.guid])) {
      if(!isDefined(victim.attackers[self.guid])) {
        println("Weapon: " + weapon);
        println("meansOfDeath: " + meansOfDeath);
        println("Attacker GUID: " + self.guid + " (name: " + self.name + ")");

        i = 0;
        foreach(key, value in victim.attackers) {
          println("victim.attackers " + i + " GUID: " + key + " (name: " + value.name + ")");
          i++;
        }
      }

      assertEx(isDefined(victim.attackers[self.guid]), "See console log for details");

      weaponClass = getWeaponClass(weapon);

      if(weaponClass == "weapon_sniper" &&
        meansOfDeath != "MOD_MELEE" &&
        getTime() == victim.attackerData[self.guid].firstTimeDamaged) {
        self.modifiers["oneshotkill"] = true;
        self thread maps\mp\gametypes\_rank::xpEventPopup("one_shot_kill");
      }
    }

    if(isDefined(victim.throwingGrenade) && victim.throwingGrenade == "frag_grenade_mp") {
      self.modifiers["cooking"] = true;
    }

    if(isDefined(self.assistedSuicide) && self.assistedSuicide) {
      self assistedSuicide(killId, weapon, meansOfDeath);
    }

    if(level.numKills == 1) {
      self firstBlood(killId, weapon, meansOfDeath);
    }

    if(self.pers["cur_death_streak"] > 3) {
      self comeBack(killId, weapon, meansOfDeath);
    }

    if(meansOfDeath == "MOD_HEAD_SHOT") {
      if(isDefined(victim.lastStand)) {
        execution(killId, weapon, meansOfDeath);
      } else {
        headShot(killId, weapon, meansOfDeath);
      }
    }

    if(isDefined(self.wasti) && self.wasti && getTime() - self.spawnTime <= 5000) {
      self.modifiers["jackintheboxkill"] = true;
    }

    if(!isAlive(self) && self.deathtime + 800 < getTime()) {
      postDeathKill(killId);
    }

    if(level.teamBased && curTime - victim.lastKillTime < 500) {
      if(victim.lastkilledplayer != self) {
        self avengedPlayer(killId, weapon, meansOfDeath);
      }
    }

    if(isDefined(victim.lastKillDogTime) && curTime - victim.lastKillDogTime < 2000) {
      self avengedDog(killId, weapon, meansOfDeath);
    }

    foreach(guid, damageTime in victim.damagedPlayers) {
      if(guid == self.guid) {
        continue;
      }
      if(level.teamBased && curTime - damageTime < 500) {
        self defendedPlayer(killId, weapon, meansOfDeath);
      }
    }

    if(isDefined(victim.attackerPosition)) {
      attackerPosition = victim.attackerPosition;
    } else {
      attackerPosition = self.origin;
    }

    if(isPointBlank(self, weapon, meansOfDeath, attackerPosition, victim)) {
      self thread pointblank(killId, weapon, meansOfDeath);
    } else if(isLongShot(self, weapon, meansOfDeath, attackerPosition, victim)) {
      self thread longshot(killId, weapon, meansOfDeath);
    }

    victim_pers_cur_kill_streak = victim.pers["cur_kill_streak"];
    if(victim_pers_cur_kill_streak > 0 && isDefined(victim.killstreaks[victim_pers_cur_kill_streak + 1])) {
      self buzzKill(killId, victim, weapon, meansOfDeath);
    }

    self thread checkMatchDataKills(killId, victim, weapon, meansOfDeath);

  } else if(weapon == "guard_dog_mp") {
    if(!isAlive(self) && self.deathtime < GetTime()) {
      postDeathDogKill();
    }
  }

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

  if(self.killedPlayers[victimGuid] > self.greatestUniquePlayerKills) {
    self setPlayerStat("killedsameplayer", self.killedPlayers[victimGuid]);
  }

  self.killedPlayersCurrent[victimGuid]++;
  victim.killedBy[myGuid]++;

  victim.lastKilledBy = self;
}

isLongShot(attacker, weapon, meansOfDeath, attackerPosition, victim) {
  if(isAlive(attacker) &&
    !attacker isUsingRemote() &&
    (meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET" || meansOfDeath == "MOD_HEAD_SHOT") &&
    !isKillstreakWeapon(weapon) && !isDefined(attacker.assistedSuicide)) {
    thisWeaponClass = getWeaponClass(weapon);
    switch (thisWeaponClass) {
      case "weapon_pistol":
        weapDist = 800;
        break;
      case "weapon_smg":
        weapDist = 1200;
        break;
      case "weapon_dmr":
      case "weapon_assault":
      case "weapon_lmg":
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

    weapDistSq = weapDist * weapDist;
    if(DistanceSquared(attackerPosition, victim.origin) > weapDistSq) {
      if(attacker IsItemUnlocked("specialty_holdbreath") && attacker _hasPerk("specialty_holdbreath")) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_longdistance");
      }

      return true;
    }
  }

  return false;
}

isPointBlank(attacker, weapon, meansOfDeath, attackerPosition, victim) {
  if(isAlive(attacker) &&
    !attacker isUsingRemote() &&
    (meansOfDeath == "MOD_RIFLE_BULLET" || meansOfDeath == "MOD_PISTOL_BULLET" || meansOfDeath == "MOD_HEAD_SHOT") &&
    !isKillstreakWeapon(weapon) && !isDefined(attacker.assistedSuicide)) {
    weapDistSq = 96 * 96;
    if(DistanceSquared(attackerPosition, victim.origin) < weapDistSq) {
      return true;
    }
  }

  return false;
}

checkMatchDataKills(killId, victim, weapon, meansOfDeath) {
  weaponClass = getWeaponClass(weapon);
  alreadyUsed = false;

  self thread camperCheck();

  if(isDefined(self.lastKilledBy) && self.lastKilledBy == victim) {
    self.lastKilledBy = undefined;
    self revenge(killId);
  }

  if(victim.iDFlags &level.iDFLAGS_PENETRATION) {
    self incPlayerStat("bulletpenkills", 1);
  }

  self_pers_rank = self.pers["rank"];
  victim_pers_rank = victim.pers["rank"];
  if(self_pers_rank < victim_pers_rank) {
    self incPlayerStat("higherrankkills", 1);
  }

  if(self_pers_rank > victim_pers_rank) {
    self incPlayerStat("lowerrankkills", 1);
  }

  if(isDefined(self.inFinalStand) && self.inFinalStand) {
    self incPlayerStat("laststandkills", 1);
  }

  if(isDefined(victim.inFinalStand) && victim.inFinalStand) {
    self incPlayerStat("laststanderkills", 1);
  }

  if(self getCurrentWeapon() != self.primaryWeapon && self getCurrentWeapon() != self.secondaryWeapon) {
    self incPlayerStat("otherweaponkills", 1);
  }

  timeAlive = getTime() - victim.spawnTime;

  if(!matchMakingGame()) {
    victim setPlayerStatIfLower("shortestlife", timeAlive);
  }

  victim setPlayerStatIfGreater("longestlife", timeAlive);

  if(meansOfDeath != "MOD_MELEE") {
    switch (weaponClass) {
      case "weapon_pistol":
      case "weapon_smg":
      case "weapon_assault":
      case "weapon_projectile":
      case "weapon_dmr":
      case "weapon_sniper":
      case "weapon_shotgun":
      case "weapon_lmg":
        self checkMatchDataWeaponKills(victim, weapon, meansOfDeath, weaponClass);
        break;
      case "weapon_grenade":
      case "weapon_explosive":
        self checkMatchDataEquipmentKills(victim, weapon, meansOfDeath);
        break;
      default:
        break;
    }
  }
}

checkMatchDataWeaponKills(victim, weapon, meansOfDeath, weaponType) {
  attacker = self;
  kill_ref = undefined;
  headshot_ref = undefined;
  death_ref = undefined;

  switch (weaponType) {
    case "weapon_pistol":
      kill_ref = "pistolkills";
      headshot_ref = "pistolheadshots";
      break;
    case "weapon_smg":
      kill_ref = "smgkills";
      headshot_ref = "smgheadshots";
      break;
    case "weapon_assault":
      kill_ref = "arkills";
      headshot_ref = "arheadshots";
      break;
    case "weapon_projectile":
      if(weaponClass(weapon) == "rocketlauncher") {
        kill_ref = "rocketkills";
      }
      break;
    case "weapon_dmr":
      kill_ref = "dmrkills";
      headshot_ref = "dmrheadshots";
      break;
    case "weapon_sniper":
      kill_ref = "sniperkills";
      headshot_ref = "sniperheadshots";
      break;
    case "weapon_shotgun":
      kill_ref = "shotgunkills";
      headshot_ref = "shotgunheadshots";
      death_ref = "shotgundeaths";
      break;
    case "weapon_lmg":
      kill_ref = "lmgkills";
      headshot_ref = "lmgheadshots";
      break;
    default:
      break;
  }

  if(isDefined(kill_ref)) {
    attacker incPlayerStat(kill_ref, 1);
  }

  if(isDefined(headshot_ref) && meansOfDeath == "MOD_HEAD_SHOT") {
    attacker incPlayerStat(headshot_ref, 1);
  }

  if(isDefined(death_ref) && !matchMakingGame()) {
    victim incPlayerStat(death_ref, 1);
  }

  if(attacker isPlayerAds()) {
    attacker incPlayerStat("adskills", 1);

    isThermal = IsSubStr(weapon, "thermal");

    if(isThermal || IsSubStr(weapon, "acog") || IsSubStr(weapon, "scope")) {
      attacker incPlayerStat("scopedkills", 1);
    }

    if(isThermal) {
      attacker incPlayerStat("thermalkills", 1);
    }
  } else {
    attacker incPlayerStat("hipfirekills", 1);
  }
}

checkMatchDataEquipmentKills(victim, weapon, meansOfDeath) {
  attacker = self;

  switch (weapon) {
    case "frag_grenade_mp":
      attacker incPlayerStat("fragkills", 1);
      attacker incPlayerStat("grenadekills", 1);
      isEquipment = true;
      break;
    case "c4_mp":
      attacker incPlayerStat("c4kills", 1);
      isEquipment = true;
      break;
    case "semtex_mp":
      attacker incPlayerStat("semtexkills", 1);
      attacker incPlayerStat("grenadekills", 1);
      isEquipment = true;
      break;
    case "claymore_mp":
      attacker incPlayerStat("claymorekills", 1);
      isEquipment = true;
      break;
    case "throwingknife_mp":
      attacker incPlayerStat("throwingknifekills", 1);
      self thread maps\mp\gametypes\_rank::xpEventPopup("knifethrow");
      isEquipment = true;
      break;
    default:
      isEquipment = false;
      break;
  }

  if(isEquipment) {
    attacker incPlayerStat("equipmentkills", 1);
  }
}

camperCheck() {
  self.lastKillWasCamping = false;
  if(!isDefined(self.lastKillLocation)) {
    self.lastKillLocation = self.origin;
    self.lastCampKillTime = getTime();
    return;
  }

  if(Distance(self.lastKillLocation, self.origin) < 512 && getTime() - self.lastCampKillTime > 5000) {
    self incPlayerStat("mostcamperkills", 1);
    self.lastKillWasCamping = true;
  }

  self.lastKillLocation = self.origin;
  self.lastCampKillTime = getTime();
}

consolation(killId) {}

proximityAssist(killId) {
  self.modifiers["proximityAssist"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("proximityassist");

  self thread maps\mp\gametypes\_rank::giveRankXP("proximityassist");
}

proximityKill(killId) {
  self.modifiers["proximityKill"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("proximitykill");

  self thread maps\mp\gametypes\_rank::giveRankXP("proximitykill");
}

longshot(killId, weapon, meansOfDeath) {
  self.modifiers["longshot"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("longshot");

  self thread maps\mp\gametypes\_rank::giveRankXP("longshot", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("longshot");
  self incPlayerStat("longshots", 1);
  self thread maps\mp\_matchdata::logKillEvent(killId, "longshot");
}

pointblank(killId, weapon, meansOfDeath) {
  self.modifiers["pointblank"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("pointblank");

  self thread maps\mp\gametypes\_rank::giveRankXP("pointblank", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("pointblank");

  self thread maps\mp\_matchdata::logKillEvent(killId, "pointblank");
}

execution(killId, weapon, meansOfDeath) {
  self.modifiers["execution"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("execution");

  self thread maps\mp\gametypes\_rank::giveRankXP("execution", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("execution");
  self thread maps\mp\_matchdata::logKillEvent(killId, "execution");
}

headShot(killId, weapon, meansOfDeath) {
  self.modifiers["headshot"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("headshot");

  self thread maps\mp\gametypes\_rank::giveRankXP("headshot", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("headshot");
  self thread maps\mp\_matchdata::logKillEvent(killId, "headshot");
}

avengedPlayer(killId, weapon, meansOfDeath) {
  self.modifiers["avenger"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("avenger");

  self thread maps\mp\gametypes\_rank::giveRankXP("avenger", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("avenger");
  self thread maps\mp\_matchdata::logKillEvent(killId, "avenger");

  self incPlayerStat("avengekills", 1);
}

avengedDog(killId, weapon, meansOfDeath) {
  self thread maps\mp\gametypes\_rank::xpEventPopup("dog_avenger");

  self thread maps\mp\gametypes\_rank::giveRankXP("dog_avenger", undefined, weapon, meansOfDeath);
}

assistedSuicide(killId, weapon, meansOfDeath) {
  self.modifiers["assistedsuicide"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("assistedsuicide");

  self thread maps\mp\gametypes\_rank::giveRankXP("assistedsuicide", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("assistedsuicide");
  self thread maps\mp\_matchdata::logKillEvent(killId, "assistedsuicide");
}

defendedPlayer(killId, weapon, meansOfDeath) {
  self.modifiers["defender"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("defender");

  self thread maps\mp\gametypes\_rank::giveRankXP("defender", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("defender");
  self thread maps\mp\_matchdata::logKillEvent(killId, "defender");

  self incPlayerStat("rescues", 1);
}

postDeathKill(killId) {
  self.modifiers["posthumous"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("posthumous");

  self thread maps\mp\gametypes\_rank::giveRankXP("posthumous");
  self thread maps\mp\_matchdata::logKillEvent(killId, "posthumous");
}

postDeathDogKill() {
  self thread maps\mp\gametypes\_rank::xpEventPopup("martyrdog");

  self thread maps\mp\gametypes\_rank::giveRankXP("martyrdog");
}

backStab(killId) {
  self iPrintLnBold("backstab");
}

revenge(killId) {
  self.modifiers["revenge"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("revenge");

  self thread maps\mp\gametypes\_rank::giveRankXP("revenge");
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("revenge");
  self thread maps\mp\_matchdata::logKillEvent(killId, "revenge");

  self incPlayerStat("revengekills", 1);
}

multiKill(killId, killCount) {
  assert(killCount > 1);

  if(killCount == 2) {
    self thread maps\mp\gametypes\_rank::xpEventPopup("double");

    self maps\mp\killstreaks\_killstreaks::giveAdrenaline("double");
  } else if(killCount == 3) {
    self thread maps\mp\gametypes\_rank::xpEventPopup("triple");

    self maps\mp\killstreaks\_killstreaks::giveAdrenaline("triple");
    thread teamPlayerCardSplash("callout_3xkill", self);
  } else {
    self thread maps\mp\gametypes\_rank::xpEventPopup("multi");

    self maps\mp\killstreaks\_killstreaks::giveAdrenaline("multi");
    thread teamPlayerCardSplash("callout_3xpluskill", self);
  }

  self thread maps\mp\_matchdata::logMultiKill(killId, killCount);

  self setPlayerStatIfGreater("multikill", killCount);

  self incPlayerStat("mostmultikills", 1);
}

firstBlood(killId, weapon, meansOfDeath) {
  self.modifiers["firstblood"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("firstblood");

  self thread maps\mp\gametypes\_rank::giveRankXP("firstblood", undefined, weapon, meansOfDeath);
  self thread maps\mp\_matchdata::logKillEvent(killId, "firstblood");
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("firstBlood");

  thread teamPlayerCardSplash("callout_firstblood", self);

  self maps\mp\gametypes\_missions::processChallenge("ch_bornready");
}

winningShot(killId) {}

buzzKill(killId, victim, weapon, meansOfDeath) {
  self.modifiers["buzzkill"] = victim.pers["cur_kill_streak"];

  self thread maps\mp\gametypes\_rank::xpEventPopup("buzzkill");

  self thread maps\mp\gametypes\_rank::giveRankXP("buzzkill", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("buzzkill");
  self thread maps\mp\_matchdata::logKillEvent(killId, "buzzkill");
}

comeBack(killId, weapon, meansOfDeath) {
  self.modifiers["comeback"] = true;

  self thread maps\mp\gametypes\_rank::xpEventPopup("comeback");

  self thread maps\mp\gametypes\_rank::giveRankXP("comeback", undefined, weapon, meansOfDeath);
  self maps\mp\killstreaks\_killstreaks::giveAdrenaline("comeback");
  self thread maps\mp\_matchdata::logKillEvent(killId, "comeback");

  self incPlayerStat("comebacks", 1);
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

monitorHealed() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("healed");
    self maps\mp\killstreaks\_killstreaks::giveAdrenaline("healed");
  }
}

updateRecentKills(killId) {
  self endon("disconnect");
  level endon("game_ended");

  self notify("updateRecentKills");
  self endon("updateRecentKills");

  self.recentKillCount++;

  wait(1.0);

  if(self.recentKillCount > 1) {
    self multiKill(killId, self.recentKillCount);
  }

  self.recentKillCount = 0;
}

monitorCrateJacking() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", crateType, owner);

    self thread maps\mp\gametypes\_rank::xpEventPopup("hijacker");
    self thread maps\mp\gametypes\_rank::giveRankXP("hijacker");

    splashName = "hijacked_airdrop";
    challengeName = "ch_hijacker";

    switch (crateType) {
      case "sentry":
        splashName = "hijacked_sentry";
        break;
      case "juggernaut":
        splashName = "hijacked_juggernaut";
        break;
      case "maniac":
        splashname = "hijacked_maniac";
        break;
      case "juggernaut_swamp_slasher":
        splashname = "hijacked_juggernaut_swamp_slasher";
        break;
      case "juggernaut_predator":
        splashname = "hijacked_juggernaut_predator";
        break;
      case "juggernaut_death_mariachi":
        splashname = "hijacked_juggernaut_death_mariachi";
        break;
      case "remote_tank":
        splashName = "hijacked_remote_tank";
        break;
      case "mega":
      case "emergency_airdrop":
        splashName = "hijacked_emergency_airdrop";
        challengeName = "ch_newjack";
        break;

      default:
        break;
    }

    if(isDefined(owner)) {
      owner maps\mp\gametypes\_hud_message::playerCardSplashNotify(splashName, self);
    }
    self notify("process", challengeName);
  }
}

monitorObjectives() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("objective", objType);

    switch (objType) {
      case "captured":
        self maps\mp\killstreaks\_killstreaks::giveAdrenaline("capture");
        if(isDefined(self.lastStand) && self.lastStand) {
          self thread maps\mp\gametypes\_hud_message::SplashNotifyDelayed("heroic", maps\mp\gametypes\_rank::getScoreInfoValue("reviver"));
          self thread maps\mp\gametypes\_rank::giveRankXP("reviver");
        }
        break;
      case "plant":
        self maps\mp\killstreaks\_killstreaks::giveAdrenaline("plant");
        break;
      case "defuse":
        self maps\mp\killstreaks\_killstreaks::giveAdrenaline("defuse");
        break;
    }
  }
}

giveObjectivePointStreaks() {
  halfTick_activate = true;
  if(halfTick_activate) {
    if(!IsAgent(self)) {
      self.pers["objectivePointStreak"]++;

      should_give_point = (self.pers["objectivePointStreak"] % 2 == 0);

      if(should_give_point) {
        self maps\mp\killstreaks\_killstreaks::giveAdrenaline("kill");
      }

      self SetClientOmnvar("ui_half_tick", !should_give_point);
    }
  }
}