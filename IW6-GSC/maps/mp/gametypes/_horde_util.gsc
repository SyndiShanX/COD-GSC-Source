/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_horde_util.gsc
*********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

isPlayerInLastStand(player) {
  return (isDefined(player.lastStand) && player.lastStand);
}

isOnHumanTeam(player) {
  return (player.team == level.playerTeam);
}

getNumPlayers() {
  numPlayers = 0;

  if(!isDefined(level.players)) {
    return 0;
  }

  foreach(player in level.players) {
    if(isOnHumanTeam(player)) {
      numPlayers++;
    }
  }

  return numPlayers;
}

isSpecialRound(roundNumber) {
  if(!isDefined(roundNumber)) {
    roundNumber = level.currentRoundNumber;
  }

  if(!level.enableSpecialRound) {
    return false;
  }

  if((roundNumber % 5) == 1) {
    return true;
  }

  return false;
}

isDogRound() {
  return (level.chanceToSpawnDog > 0);
}

showTeamSplashHorde(splash) {
  foreach(teamMate in level.players) {
    if(isOnHumanTeam(teamMate) && isReallyAlive(teamMate)) {
      teamMate thread maps\mp\gametypes\_hud_message::SplashNotify(splash);
    }
  }
}

hasAgentSquadMember(player) {
  hasAgentSquadMember = false;

  if(IsAgent(player)) {
    return hasAgentSquadMember;
  }

  foreach(killstreak in player.pers["killstreaks"]) {
    if(isDefined(killstreak) && isDefined(killstreak.streakName) && killstreak.available && (killstreak.streakName == "agent")) {
      hasAgentSquadMember = true;
      break;
    }
  }

  return hasAgentSquadMember;
}

getPlayerWeaponHorde(player) {
  weaponName = player GetCurrentPrimaryWeapon();

  if(isDefined(player.changingWeapon)) {
    weaponName = player.changingWeapon;
  }

  if(!maps\mp\gametypes\_weapons::isPrimaryWeapon(weaponName)) {
    weaponName = player getLastWeapon();
  }

  if(!player HasWeapon(weaponName)) {
    weaponName = player maps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();
  }

  return weaponName;
}

playSoundToAllPlayers(soundName) {
  level endon("game_ended");

  foreach(player in level.players) {
    if(!isReallyAlive(player)) {
      continue;
    }
    if(!isOnHumanTeam(player)) {
      continue;
    }
    player PlaySoundToPlayer(soundName, player);
  }
}

refillAmmoHorde(player) {
  weaponList = player GetWeaponsListAll();

  foreach(weaponName in weaponList) {
    player giveMaxAmmo(weaponName);

    if(weaponName == level.intelMiniGun) {
      clipSize = WeaponClipSize(level.intelMiniGun);
      player SetWeaponAmmoClip(level.intelMiniGun, clipSize);
    }
  }
}

hordeShowDropLocations() {
  SetDevDvarIfUninitialized("scr_hordeGiveIntelReward", "0");
  SetDevDvarIfUninitialized("scr_hordeGiveWeaponLevel", "0");

  while(true) {
    if(GetDvarInt("scr_hordeShowDropLocations") > 0) {
      foreach(dropLocation in level.hordeDropLocations) {
      drawDropLocation(dropLocation);
      }
    }

    if(GetDvarInt("scr_hordeGiveIntelReward") > 0) {
      SetDevDvar("scr_hordeGiveIntelReward", 0);
      level thread maps\mp\gametypes\_intelchallenges::intelTeamReward(level.playerTeam);
    }

    if(GetDvarInt("scr_hordeGiveWeaponLevel") > 0) {
      SetDevDvar("scr_hordeGiveWeaponLevel", 0);

      foreach(player in level.players) {
        weaponName = getPlayerWeaponHorde(player);
        baseWeaponName = GetWeaponBaseName(weaponName);

        if(maps\mp\gametypes\horde::hasWeaponState(player, baseWeaponName)) {
          barSize = player.weaponState[baseWeaponName]["barSize"];
          player.weaponState[baseWeaponName]["vaule"] = barSize;
          player notify("weaponPointsEarned");
        }
      }
    }

    wait(0.05);
  }
}

drawDropLocation(dropLocation) {
  color = (0.804, 0.804, 0.035);

  center = dropLocation.origin - (0, 0, 12);
  forward = (32, 0, 0);
  right = (0, 16, 0);
  height = (0, 0, 32);

  a = center + forward - right;
  b = center + forward + right;
  c = center - forward + right;
  d = center - forward - right;

  line(a, b, color, 0);
  line(b, c, color, 0);
  line(c, d, color, 0);
  line(d, a, color, 0);

  line(a, a + height, color, 0);
  line(b, b + height, color, 0);
  line(c, c + height, color, 0);
  line(d, d + height, color, 0);

  a = a + height;
  b = b + height;
  c = c + height;
  d = d + height;

  line(a, b, color, 0);
  line(b, c, color, 0);
  line(c, d, color, 0);
  line(d, a, color, 0);

  print3d(center + height, "Air Drop", color, 1, 1);
}

awardHordeKill(player) {
  player maps\mp\gametypes\_persistence::statSetChild("round", "squardKills", player.killz + 1);
  player.killz = int(min(player.killz + 1, 999));
  player.kills = player.killz;
  player setPersStat("hordeKills", player.killz);
}

awardHordeRevive(player) {
  player maps\mp\gametypes\_persistence::statSetChild("round", "squardRevives", player.numRevives + 1);
  player.numRevives = int(min(player.numRevives + 1, 999));
  player.assists = player.numRevives;
  player setPersStat("hordeRevives", player.numRevives);
}

awardHordeCrateUsed(player) {
  player maps\mp\gametypes\_persistence::statSetChild("round", "squardCrates", player.numCrtaesCaptured + 1);
  player.numCrtaesCaptured = int(min(player.numCrtaesCaptured + 1, 999));
  player setExtraScore0(player.numCrtaesCaptured);
  player setPersStat("hordeCrates", player.numCrtaesCaptured);
}

awardHordeRoundNumber(player, value) {
  player maps\mp\gametypes\_persistence::statSetChild("round", "sguardWave", value);
  player setPersStat("hordeRound", value);
}

awardHordWeaponLevel(player, value) {
  player maps\mp\gametypes\_persistence::statSetChild("round", "sguardWeaponLevel", value);
  player setPersStat("hordeWeapon", value);
}