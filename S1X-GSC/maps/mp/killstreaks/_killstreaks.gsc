/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_killstreaks.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

KILLSTREAK_NAME_COLUMN = 1;
KILLSTREAK_EARNED_HINT_COLUMN = 5;
KILLSTREAK_EARN_DIALOG_COLUMN = 7;
KILLSTREAK_ENEMY_USE_DIALOG_COLUMN = 10;
KILLSTREAK_ICON_COLUMN = 13;
KILLSTREAK_OVERHEAD_ICON_COLUMN = 14;
KILLSTREAK_OVERHEAD_ICON_PLUS_1_COLUMN = 15;
KILLSTREAK_OVERHEAD_ICON_PLUS_2_COLUMN = 16;
KILLSTREAK_OVERHEAD_ICON_PLUS_3_COLUMN = 17;

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["killstreaks"])) {
      player.pers["killstreaks"] = [];
    }

    if(!isDefined(player.pers["kID"])) {
      player.pers["kID"] = 10;
    }

    player.lifeId = 0;
    player.curDefValue = 0;

    if(isDefined(player.pers["deaths"])) {
      player.lifeId = player.pers["deaths"];
    }

    player.spUpdateTotal = 0;

    if(GetDvarInt("virtualLobbyActive", 0)) {
      return;
    }

    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill_any("spawned_player", "faux_spawn");

    self thread killstreakUseWaiter();
    self thread streakNotifyTracker();
    self thread waitForChangeTeam();

    self thread streakSelectUpTracker();
    self thread streakSelectDownTracker();

    if(!level.console) {
      self thread pc_watchStreakUse();
    }

    if(!isDefined(self.pers["killstreaks"][0])) {
      self initPlayerKillstreaks();
    }

    if(!isDefined(self.earnedStreakLevel)) {
      self.earnedStreakLevel = 0;
    }

    if(!isDefined(self.adrenaline) || self.adrenaline == 0) {
      self.adrenaline = self.pers["ks_totalPoints"];
      self.adrenalineSupport = self.pers["ks_totalPointsSupport"];
      self updateStreakCount();

      for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
        streakName = self.pers["killstreaks"][i].streakName;
        available = self.pers["killstreaks"][i].available;

        if(isDefined(streakName)) {
          if((i == level.KILLSTREAK_GIMME_SLOT) && (!isDefined(available) || !available)) {
            continue;
          }

          streakIndex = getKillstreakIndex(self.pers["killstreaks"][i].streakName);
          killstreak_iconName = "ks_icon" + toString(i);
          self SetClientOmnvar(killstreak_iconName, streakIndex);
        }
      }

      self updateStreakIcons(false);
    }

    self updateStreakSlots();
    self giveOwnedKillstreakItem();
    self updateStreakCount();
  }
}

updateStreakIcons(isInit) {
  assert(level.KILLSTREAK_STACKING_START_SLOT <= 16);
  for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    if(!isInit && i == level.KILLSTREAK_GIMME_SLOT) {
      continue;
    }

    killstreak_iconName = "ks_icon" + toString(i);
    self SetClientOmnvar(killstreak_iconName, 0);

    previousHasStreak = self GetClientOmnvar("ks_hasStreak");
    newHasStreak = previousHasStreak &(~(1 << i)) &(~(1 << (i + level.KILLSTREAK_STACKING_START_SLOT)));
    self SetClientOmnvar("ks_hasStreak", newHasStreak);
  }

  index = 1;

  if(isDefined(self.killstreaks)) {
    foreach(streakName in self.killstreaks) {
      self_pers_killstreaks_index = self.pers["killstreaks"][index];
      self_pers_killstreaks_index.streakName = streakName;

      killstreakIndexName = self_pers_killstreaks_index.streakName;
      killstreak_iconName = "ks_icon" + toString(index);
      self SetClientOmnvar(killstreak_iconName, getKillstreakIndex(killstreakIndexName));

      assert(index < level.KILLSTREAK_STACKING_START_SLOT);

      previousHasStreak = self GetClientOmnvar("ks_hasStreak");
      newHasStreak = previousHasStreak &(~(1 << index));

      if(isSupportStreak(self, streakName)) {
        newHasStreak = newHasStreak | (1 << (index + level.KILLSTREAK_STACKING_START_SLOT));
      } else {
        newHasStreak = newHasStreak &(~(1 << (index + level.KILLSTREAK_STACKING_START_SLOT)));
      }
      self SetClientOmnvar("ks_hasStreak", newHasStreak);

      index++;
    }
  }
}

initPlayerKillstreaks() {
  self_pers_killstreaks_gimme_slot = spawnStruct();
  self_pers_killstreaks_gimme_slot.available = false;
  self_pers_killstreaks_gimme_slot.streakName = undefined;
  self_pers_killstreaks_gimme_slot.earned = false;
  self_pers_killstreaks_gimme_slot.awardxp = undefined;
  self_pers_killstreaks_gimme_slot.owner = undefined;
  self_pers_killstreaks_gimme_slot.kID = undefined;
  self_pers_killstreaks_gimme_slot.lifeId = undefined;
  self_pers_killstreaks_gimme_slot.isGimme = true;
  self_pers_killstreaks_gimme_slot.nextSlot = undefined;
  self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT] = self_pers_killstreaks_gimme_slot;

  for(i = level.KILLSTREAK_SLOT_1; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    self_pers_killstreaks_i = spawnStruct();

    self_pers_killstreaks_i.available = false;
    self_pers_killstreaks_i.streakName = undefined;
    self_pers_killstreaks_i.earned = true;
    self_pers_killstreaks_i.awardxp = 1;
    self_pers_killstreaks_i.owner = undefined;
    self_pers_killstreaks_i.kID = undefined;
    self_pers_killstreaks_i.lifeId = -1;
    self_pers_killstreaks_i.isGimme = false;
    self.pers["killstreaks"][i] = self_pers_killstreaks_i;
  }

  self updateStreakIcons(true);

  self SetClientOmnvar("ks_selectedIndex", -1);

  previousHasStreak = self GetClientOmnvar("ks_hasStreak");
  newHasStreak = previousHasStreak &(~(1 << level.KILLSTREAK_STACKING_START_SLOT));
  self SetClientOmnvar("ks_hasStreak", newHasStreak);
}

isSupportStreak(player, streakName) {
  moduleRefs = GetArrayKeys(self.killStreakModules);

  foreach(moduleName in moduleRefs) {
    baseStreakName = getStreakModuleBaseKillstreak(moduleName);

    if(baseStreakName == streakName) {
      supportColumn = TableLookup(level.KS_MODULES_TABLE, level.KS_MODULE_REF_COLUMN, moduleName, level.KS_MODULE_SUPPORT_COLUMN);

      if(isDefined(supportColumn) && supportColumn != "" && supportcolumn != "0") {
        return true;
      }
    }
  }

  return false;
}

updateStreakCount() {
  if(!isDefined(self.pers["killstreaks"])) {
    for(i = level.KILLSTREAK_SLOT_1; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
      self SetClientOmnvar("ks_count" + toString(i), 0);
    }
    self SetClientOmnvar("ks_count_updated", 1);
    return;
  }

  for(i = level.KILLSTREAK_SLOT_1; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    streakName = self.pers["killstreaks"][i].streakName;
    ksBarName = "ks_count" + toString(i);
    ksPointsName = "ks_points" + toString(i);

    if(!isDefined(streakName)) {
      self SetClientOmnvar(ksBarName, 0);
      continue;
    }

    streakVal = self getStreakCost(self.pers["killstreaks"][i].streakName);
    if(isSupportStreak(self, streakName)) {
      barFillPercent = self.adrenalineSupport / streakVal;
      score_remaining = streakVal - self.adrenalineSupport;
    } else {
      barFillPercent = self.adrenaline / streakVal;
      score_remaining = streakVal - self.adrenaline;
    }

    if(barFillPercent >= 1) {
      barFillPercent = 0;
      score_remaining = streakVal;
    }

    self SetClientOmnvar(ksPointsName, score_remaining);
    self SetClientOmnvar(ksBarName, barFillPercent);
  }

  self SetClientOmnvar("ks_count_updated", 1);
}

getMaxStreakCost(isSupport) {
  if(!isDefined(self.killstreaks)) {
    return 0;
  }

  maxCost = 0;

  foreach(streakName in self.killstreaks) {
    supportStreak = isSupportStreak(self, streakName);
    if((isSupport && !supportStreak) || (!isSupport && supportStreak)) {
      continue;
    }

    streakVal = self getStreakCost(streakName);

    if(streakVal > maxCost) {
      maxCost = streakVal;
    }
  }
  return maxCost;
}

updateStreakSlots() {
  if(!isReallyAlive(self)) {
    return;
  }

  self_pers_killstreaks = self.pers["killstreaks"];

  numStreaks = 0;
  for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    if(isDefined(self_pers_killstreaks[i]) && isDefined(self_pers_killstreaks[i].streakName)) {
      previousHasStreak = self GetClientOmnvar("ks_hasStreak");
      if(self_pers_killstreaks[i].available == true) {
        newHasStreak = previousHasStreak | (1 << i);
      } else {
        newHasStreak = previousHasStreak &(~(1 << i));
      }
      self SetClientOmnvar("ks_hasStreak", newHasStreak);

      if(self_pers_killstreaks[i].available == true) {
        numStreaks++;
      }
    }
  }

  if(isDefined(self.killstreakIndexWeapon)) {
    self SetClientOmnvar("ks_selectedIndex", self.killstreakIndexWeapon);
  } else {
    self SetClientOmnvar("ks_selectedIndex", -1);
  }
}

waitForChangeTeam() {
  self endon("disconnect");
  self endon("faux_spawn");

  self notify("waitForChangeTeam");
  self endon("waitForChangeTeam");

  for(;;) {
    self waittill("joined_team");
    clearKillstreaks(true);
  }
}

killstreakUsePressed() {
  self_pers_killstreaks = self.pers["killstreaks"];

  streakName = self_pers_killstreaks[self.killstreakIndexWeapon].streakName;
  lifeId = self_pers_killstreaks[self.killstreakIndexWeapon].lifeId;
  isEarned = self_pers_killstreaks[self.killstreakIndexWeapon].earned;
  awardXp = self_pers_killstreaks[self.killstreakIndexWeapon].awardXp;
  kID = self_pers_killstreaks[self.killstreakIndexWeapon].kID;
  isGimme = self_pers_killstreaks[self.killstreakIndexWeapon].isGimme;
  modules = self_pers_killstreaks[self.killstreakIndexWeapon].modules;

  PrintLn("Killstreak " + streakName + " activated by player " + self GetEntityNumber());

  clearSlotNumber = undefined;
  stackedSlotNumber = undefined;
  keepCurrentKillstreak = undefined;
  if(self.killstreakIndexWeapon == level.KILLSTREAK_GIMME_SLOT) {
    stackedSlotNumber = self_pers_killstreaks[level.KILLSTREAK_GIMME_SLOT].nextSlot;
  }

  if(!validateUseStreak(streakName)) {
    return false;
  }

  removeExplosiveAmmo = false;
  if(self _hasPerk("specialty_explosivebullets") && !issubstr(streakName, "explosive_ammo")) {
    removeExplosiveAmmo = true;
  }

  if(IsSubStr(streakName, "airdrop")) {
    if(!self[[level.killstreakFuncs[streakName]]](lifeId, kID, modules)) {
      return (false);
    }
  } else {
    if(!self[[level.killstreakFuncs[streakName]]](lifeId, modules)) {
      return (false);
    }
  }

  if(IsTestClient(self)) {
    return true;
  }

  if(removeExplosiveAmmo) {
    self _unsetPerk("specialty_explosivebullets");
  }

  if(isDefined(stackedSlotNumber) && streakName != self_pers_killstreaks[self.killstreakIndexWeapon].streakName) {
    keepCurrentKillstreak = true;
    clearSlotNumber = stackedSlotNumber;
  }

  self thread updateKillstreaks(keepCurrentKillstreak, clearSlotNumber);
  self usedKillstreak(streakName, modules, awardXp);

  return (true);
}

usedKillstreak(streakName, modules, awardXp) {
  self incPlayerStat("killStreaksUsed", 1);

  if(awardXp) {
    self thread maps\mp\gametypes\_missions::useHardpoint(streakName);
  }

  team = self.team;
  friendlyLine = team + "_friendly_" + streakName + "_inbound";
  enemyLine = team + "_enemy_" + streakName + "_inbound";

  if(streakName == "emp") {
    moduleLine = maps\mp\killstreaks\_emp::getModuleLineEMP(modules);
    friendlyLine += moduleLine;
    enemyLine += moduleLine;
  }

  if(level.teamBased) {
    thread leaderDialog(friendlyLine, team);

    if(getKillstreakInformEnemy(streakName)) {
      thread leaderDialog(enemyLine, level.otherTeam[team]);
    }
  } else {
    self thread leaderDialogOnPlayer(friendlyLine);

    if(getKillstreakInformEnemy(streakName)) {
      excludeList[0] = self;
      thread leaderDialog(enemyLine, undefined, undefined, excludeList);
    }
  }

  if(isDefined(level.mapKillStreak)) {
    if(streakName == level.mapKillStreak) {
      mapStreaksUsed = getMatchData("players", self.clientId, "numberOfMapstreaksUsed");
      mapStreaksUsed++;
      setMatchData("players", self.clientId, "numberOfMapstreaksUsed", clampToByte(mapStreaksUsed));
    }
  }
}

updateKillstreaks(keepCurrent, clearSlotNumber) {
  if(!isDefined(keepCurrent)) {
    self.pers["killstreaks"][self.killstreakIndexWeapon].available = false;

    if(self.killstreakIndexWeapon == level.KILLSTREAK_GIMME_SLOT) {
      self.pers["killstreaks"][self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT].nextSlot] = undefined;

      streakName = undefined;
      modules = undefined;
      self_pers_killstreaks = self.pers["killstreaks"];
      for(i = level.KILLSTREAK_STACKING_START_SLOT; i < self_pers_killstreaks.size; i++) {
        if(!isDefined(self_pers_killstreaks[i]) || !isDefined(self_pers_killstreaks[i].streakName)) {
          continue;
        }

        streakName = self_pers_killstreaks[i].streakName;
        if(isDefined(self_pers_killstreaks[i].modules)) {
          modules = self_pers_killstreaks[i].modules;
        }
        self_pers_killstreaks[level.KILLSTREAK_GIMME_SLOT].nextSlot = i;
      }

      if(isDefined(streakName)) {
        self_pers_killstreaks[level.KILLSTREAK_GIMME_SLOT].available = true;
        self_pers_killstreaks[level.KILLSTREAK_GIMME_SLOT].streakName = streakName;
        if(isDefined(modules)) {
          self_pers_killstreaks[level.KILLSTREAK_GIMME_SLOT].modules = modules;
        }

        streakIndex = getKillstreakIndex(streakName);
        killstreak_iconName = "ks_icon" + toString(level.KILLSTREAK_GIMME_SLOT);
        self SetClientOmnvar(killstreak_iconName, streakIndex);

        if(!level.console && !self is_player_gamepad_enabled()) {
          killstreakWeapon = getKillstreakWeapon(streakName, modules);
          _setActionSlot(4, "weapon", killstreakWeapon);
        }
      } else {
        killstreak_iconName = "ks_icon" + toString(level.KILLSTREAK_GIMME_SLOT);
        self SetClientOmnvar(killstreak_iconName, 0);
      }
    }
  }

  if(isDefined(clearSlotNumber)) {
    self.pers["killstreaks"][clearSlotNumber] = undefined;
  }

  highestStreakIndex = undefined;

  for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    self_pers_killstreaks_i = self.pers["killstreaks"][i];
    if(isDefined(self_pers_killstreaks_i) &&
      isDefined(self_pers_killstreaks_i.streakName) &&
      self_pers_killstreaks_i.available) {
      highestStreakIndex = i;
    }
  }

  if(isDefined(highestStreakIndex)) {
    if(level.console || self is_player_gamepad_enabled()) {
      self.killstreakIndexWeapon = highestStreakIndex;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][highestStreakIndex].streakName;

      self giveSelectedKillstreakItem();
    } else {
      for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
        self_pers_killstreaks_i = self.pers["killstreaks"][i];
        if(isDefined(self_pers_killstreaks_i) &&
          isDefined(self_pers_killstreaks_i.streakName) &&
          self_pers_killstreaks_i.available) {
          killstreakWeapon = getKillstreakWeapon(self_pers_killstreaks_i.streakName, self_pers_killstreaks_i.modules);
          weaponsListItems = self GetWeaponsListItems();
          hasKillstreakWeapon = false;
          for(j = 0; j < weaponsListItems.size; j++) {
            if(killstreakWeapon == weaponsListItems[j]) {
              hasKillstreakWeapon = true;
              break;
            }
          }

          if(!hasKillstreakWeapon) {
            self _giveWeapon(killstreakWeapon);
          } else {
            if(IsSubStr(killstreakWeapon, "airdrop_")) {
              self SetWeaponAmmoClip(killstreakWeapon, 1);
            }
          }

          self _setActionSlot(i + 4, "weapon", killstreakWeapon);
        }
      }

      self.killstreakIndexWeapon = undefined;
      self.pers["lastEarnedStreak"] = self.pers["killstreaks"][highestStreakIndex].streakName;
      self updateStreakSlots();
    }
  } else {
    self.killstreakIndexWeapon = undefined;
    self.pers["lastEarnedStreak"] = undefined;
    self updateStreakSlots();
  }

  self SetClientOmnvar("ks_used", 1);
}

clearKillstreaks(clearSupportStreaks) {
  if(!isDefined(clearSupportStreaks)) {
    clearSupportStreaks = true;
  }

  self_pers_killstreaks = self.pers["killstreaks"];
  if(!isDefined(self_pers_killstreaks)) {
    return;
  }

  for(i = self_pers_killstreaks.size - 1; i > -1; i--) {
    self.pers["killstreaks"][i] = undefined;
  }

  initPlayerKillstreaks();

  self resetAdrenaline(clearSupportStreaks);
  self.killstreakIndexWeapon = undefined;
  self updateStreakSlots();
}

getFirstPrimaryWeapon() {
  weaponsList = self getWeaponsListPrimaries();

  assert(isDefined(weaponsList[0]));
  assertEx(!isKillstreakWeapon(weaponsList[0]), "Killstreak weapon: " + weaponsList[0]);

  return weaponsList[0];
}

isTryingToUseKillstreakSlot() {
  return isDefined(self.tryingToUseKS) && self.tryingToUseKS && isDefined(self.killstreakIndexWeapon);
}

waitForKillstreakWeaponSwitchStarted() {
  self endon("weapon_switch_invalid");

  self waittill("weapon_switch_started", newWeapon);
  self notify("killstreak_weapon_change", "switch_started", newWeapon);
}

waitForKillstreakWeaponSwitchInvalid() {
  self endon("weapon_switch_started");

  self waittill("weapon_switch_invalid", invalidWeapon);
  self notify("killstreak_weapon_change", "switch_invalid", invalidWeapon);
}

waitForKillstreakWeaponChange() {
  self childthread waitForKillstreakWeaponSwitchStarted();
  self childthread waitForKillstreakWeaponSwitchInvalid();

  self waittill("killstreak_weapon_change", result, weapon);

  if(result == "switch_started") {
    return weapon;
  }

  assert(result == "switch_invalid");
  assert(isTryingToUseKillstreakSlot());

  killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName, self.pers["killstreaks"][self.killstreakIndexWeapon].modules);

  PrintLn("Invalid killstreak weapon switch: " + weapon + ". Forcing switch to " + killstreakWeapon + " instead.");

  self SwitchToWeapon(killstreakWeapon);

  self waittill("weapon_switch_started", newWeapon);

  if(newWeapon != killstreakWeapon) {
    PrintLn("Player switched weapons after script forced killstreak weapon. Skipping killstreak weapon change. " + newWeapon + " != " + killstreakWeapon);
    return undefined;
  }

  return killstreakWeapon;
}

updateAerialKillStreakMarker() {
  foreach(player in level.players) {
    player notify("updateKillStreakMarker");
  }
}

aerialKillstreakMarker() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  level endon("game_ended");

  enemyTeam = maps\mp\gametypes\_gameobjects::getEnemyTeam(self.team);

  while(true) {
    self waittill_any("weapon_change", "updateKillStreakMarker");

    playerWeapon = self GetCurrentWeapon();
    sWeaponClass = weaponClass(playerWeapon);

    if(sWeaponClass != "rocketlauncher") {
      continue;
    }

    targetList = [];
    targetList = getAerialKillstreakArray(enemyTeam);

    if(targetList.size == 0) {
      continue;
    }

    foreach(target in targetList) {
      createThreatIcon(target, self);
    }
  }
}

getAerialKillstreakArray(team) {
  entityList = [];
  UAVModels = [];

  if(inVirtualLobby()) {
    return entityList;
  }

  if(level.teamBased) {
    UAVModels = level.uavmodels[team];
  } else {
    UAVModels = level.UAVModels;
  }

  foreach(uav in UAVModels) {
    if(isDefined(uav.isLeaving) && uav.isLeaving) {
      continue;
    }

    if(isDefined(uav.orbit) && uav.orbit) {
      continue;
    }

    entityList[entityList.size] = uav;
  }

  foreach(plane in level.planes) {
    if(!level.teamBased || plane.team == team) {
      entityList[entityList.size] = plane;
    }
  }

  if(level.orbitalsupportInUse && isDefined(level.orbitalsupport_planemodel) && isDefined(level.orbitalsupport_planemodel.owner) && isDefined(level.orbitalsupport_planemodel.showThreatMarker) && level.orbitalsupport_planemodel.showThreatMarker) {
    if(level.teamBased && (level.orbitalsupport_planemodel.owner.team == team)) {
      entityList[entityList.size] = level.orbitalsupport_planemodel;
    }

    if(!level.teamBased) {
      entityList[entityList.size] = level.orbitalsupport_planemodel;
    }
  }

  if(isDefined(level.getAerialKillstreakArray)) {
    levelAerialKillstreak = [[level.getAerialKillstreakArray]](team);
    foreach(killstreak in levelAerialKillstreak) {
      entityList[entityList.size] = killstreak;
    }
  }

  return entityList;
}

createThreatIcon(target, player) {
  if(!isDefined(target.wayPoint)) {
    target.wayPoint = [];
  }

  id = player.guid;

  if(isDefined(target.wayPoint[id])) {
    return;
  }

  target.wayPoint[id] = newHudElem();
  target.wayPoint[id] SetShader("waypoint_threat_hostile", 1, 1);
  target.wayPoint[id].alpha = .75;
  target.wayPoint[id].color = (1, 1, 1);
  target.wayPoint[id].x = target.origin[0];
  target.wayPoint[id].y = target.origin[1];
  target.wayPoint[id].z = target.origin[2];
  target.wayPoint[id] SetWayPoint(true, true, true);
  target.wayPoint[id] SetTargetEnt(target);
  target.wayPoint[id].showinkillcam = 0;
  target.wayPoint[id].archived = 0;

  level thread removeThreatIcon(self, target, target.wayPoint[id]);
}

removeThreatIcon(player, target, wayPoint) {
  level endon("game_ended");

  player waittill_any_ents(player, "death", target, "death", player, "weapon_change", player, "disconnect", target, "leaving");
  wayPoint Destroy();
}

killstreakUseWaiter() {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  self endon("faux_spawn");
  level endon("game_ended");

  self notify("killstreakUseWaiter");
  self endon("killstreakUseWaiter");

  self.lastKillStreak = 0;
  if(!isDefined(self.pers["lastEarnedStreak"])) {
    self.pers["lastEarnedStreak"] = undefined;
  }

  self thread finishDeathWaiter();

  for(;;) {
    if(!isDefined(self.justSwitchedToKillstreakWeapon)) {
      self waittill("weapon_change", newWeapon);
    } else {
      newWeapon = self.justSwitchedToKillstreakWeapon;
      self.justSwitchedToKillstreakWeapon = undefined;
    }

    isKillstreakWeap = isKillstreakWeapon(newWeapon);

    if(!isAlive(self)) {
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 0 activated by player " + self GetEntityNumber());
    }

    if(isDefined(self.ball_carried)) {
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 1 activated by player " + self GetEntityNumber());
    }

    if(!isDefined(self.killstreakIndexWeapon)) {
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 2 activated by player " + self GetEntityNumber());
    }

    if(isDefined(self.manuallyJoiningKillStreak) && self.manuallyJoiningKillStreak) {
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 3 activated by player " + self GetEntityNumber());
    }

    if(isDefined(self.isCarrying) && self.isCarrying) {
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 4 activated by player " + self GetEntityNumber());
    }

    if(!isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon]) || !isDefined(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName)) {
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 5 activated by player " + self GetEntityNumber());
    }

    killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName, self.pers["killstreaks"][self.killstreakIndexWeapon].modules);
    if(newWeapon != killstreakWeapon) {
      if(isStrStart(newWeapon, "airdrop_")) {
        self TakeWeapon(newWeapon);
        self SwitchToWeapon(self.lastdroppableweapon);
      }
      continue;
    }

    if(isKillstreakWeap) {
      PrintLn("killstreakUseWaiter 6 activated by player " + self GetEntityNumber());
    }

    waittillframeend;

    streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
    isGimme = self.pers["killstreaks"][self.killstreakIndexWeapon].isGimme;
    modules = self.pers["killstreaks"][self.killstreakIndexWeapon].modules;

    assert(isDefined(streakName));
    assert(isDefined(level.killstreakFuncs[streakName]));

    lastWeapon = self playerGetKillstreakLastWeapon();
    slotNumber = self.killstreakIndexWeapon;

    if(shouldSwitchWeaponAfterRaiseAnimation(killstreakWeapon)) {
      self childthread switchWeaponAfterRaiseAnimation(killstreakWeapon, lastWeapon);
    }

    startUsePressed = GetTime();
    result = self killstreakUsePressed();
    endUsePressed = GetTime();
    elapsedSec = (endUsePressed - startUsePressed) / 1000;

    if(!result && !isAlive(self) && !self hasWeapon(self getLastWeapon())) {
      lastWeapon = self playerGetKillstreakLastWeapon(result);
      self _giveWeapon(lastWeapon);
    }

    if(result) {
      self thread waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);
    }

    if(shouldSwitchWeaponPostKillstreak(result, killstreakWeapon, streakName, modules) && !isDefined(self.justSwitchedToKillstreakWeapon)) {
      switch (killstreakWeapon) {
        case "killstreak_predator_missile_mp":
          if(!result && (1.2 - elapsedSec) > 0) {
            wait(1.2 - elapsedSec);
          }
          break;
      }

      if(!isDefined(self.underWater)) {
        if(!isDefined(level.isHorde) || ((isDefined(level.isHorde) && level.isHorde) && !(level.hordeWeaponsJammed && issubstr(killstreakWeapon, "turrethead")))) {
          self switch_to_last_weapon(lastWeapon);
        }
      } else {
        self.water_last_weapon = lastWeapon;
      }
    }

    if(self GetCurrentWeapon() == "none") {
      while(self GetCurrentWeapon() == "none") {
        wait(0.05);
      }

      waittillframeend;
    }

    if(isDefined(level.cb_usedKillstreak) && result) {
      [[level.cb_usedKillstreak]](streakName, isGimme, slotNumber);
    }
  }
}

switchWeaponAfterRaiseAnimation(weapon, lastWeapon) {
  switch (weapon) {
    case "killstreak_uav_mp":
      wait 0.75;
      break;
    default:
      return;
  }

  self switch_to_last_weapon(lastWeapon);
}

playerGetKillstreakLastWeapon(result) {
  if((!isDefined(result) || (isDefined(result) && !result)) && !isAlive(self) && !self hasWeapon(self getLastWeapon())) {
    return self getLastWeapon();
  } else if(!self hasWeapon(self getLastWeapon())) {
    return self getFirstPrimaryWeapon();
  } else {
    return self getLastWeapon();
  }
}

waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon) {
  self endon("disconnect");
  self endon("finish_death");
  self endon("joined_team");
  level endon("game_ended");
  self endon("faux_spawn");

  self notify("waitTakeKillstreakWeapon");
  self endon("waitTakeKillstreakWeapon");

  wasNone = (self GetCurrentWeapon() == "none");

  self waittill("weapon_change", newWeapon);

  if(newWeapon == lastWeapon) {
    takeKillstreakWeaponIfNoDupe(killstreakWeapon);

    if(!level.console && !self is_player_gamepad_enabled()) {
      self.killstreakIndexWeapon = undefined;
    }
  } else if(newWeapon != killstreakWeapon) {
    self thread waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);
  } else if(wasNone && self GetCurrentWeapon() == killstreakWeapon) {
    self thread waitTakeKillstreakWeapon(killstreakWeapon, lastWeapon);
  }
}

takeKillstreakWeaponIfNoDupe(killstreakWeapon) {
  hasKillstreak = false;
  self_pers_killstreaks = self.pers["killstreaks"];
  for(i = 0; i < self_pers_killstreaks.size; i++) {
    if(isDefined(self_pers_killstreaks[i]) && isDefined(self_pers_killstreaks[i].streakName) && self_pers_killstreaks[i].available) {
      if(killstreakWeapon == getKillstreakWeapon(self_pers_killstreaks[i].streakName, self_pers_killstreaks[i].modules)) {
        hasKillstreak = true;
        break;
      }
    }
  }

  if(hasKillstreak) {
    if(level.console || self is_player_gamepad_enabled()) {
      if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon != getKillstreakWeapon(self_pers_killstreaks[self.killstreakIndexWeapon].streakName, self_pers_killstreaks[self.killstreakIndexWeapon].modules)) {
        self TakeWeapon(killstreakWeapon);
      } else if(isDefined(self.killstreakIndexWeapon) && killstreakWeapon == getKillstreakWeapon(self_pers_killstreaks[self.killstreakIndexWeapon].streakName, self_pers_killstreaks[self.killstreakIndexWeapon].modules)) {
        self TakeWeapon(killstreakWeapon);
        self _giveWeapon(killstreakWeapon, 0);
        self _setActionSlot(4, "weapon", killstreakWeapon);
      }
    } else {
      self TakeWeapon(killstreakWeapon);
      self _giveWeapon(killstreakWeapon, 0);
    }
  } else {
    self TakeWeapon(killstreakWeapon);
  }
}

shouldSwitchWeaponPostKillstreak(result, killstreakWeapon, streakName, modules) {
  if(shouldSwitchWeaponAfterRaiseAnimation(killstreakWeapon)) {
    return false;
  }

  if(!result) {
    return true;
  }

  switch (streakName) {
    case "warbird":
      return (array_contains(modules, "warbird_ai_attack") || array_contains(modules, "warbird_ai_follow"));
    case "assault_ugv":
      return (array_contains(modules, "assault_ugv_ai"));
  }
  if(isRideKillstreak(streakName)) {
    return false;
  }

  return true;
}

shouldSwitchWeaponAfterRaiseAnimation(weapon) {
  switch (weapon) {
    case "killstreak_uav_mp":
      return true;
    default:
      return false;
  }
}

finishDeathWaiter() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");

  self notify("finishDeathWaiter");
  self endon("finishDeathWaiter");

  self waittill("death");
  wait(0.05);
  self notify("finish_death");
  self.pers["lastEarnedStreak"] = undefined;
}

checkStreakReward() {
  foreach(streakName in self.killstreaks) {
    streakVal = getStreakCost(streakName);

    adrenaline = self.adrenaline;
    previousAdrenaline = self.previousAdrenaline;
    if(isSupportStreak(self, streakName)) {
      adrenaline = self.adrenalineSupport;
      previousAdrenaline = self.previousAdrenalineSupport;
    }

    if(streakVal > adrenaline && adrenaline > previousAdrenaline) {
      continue;
    }

    if(previousAdrenaline < streakVal && (adrenaline >= streakVal || adrenaline <= previousAdrenaline)) {
      self earnKillstreak(streakName, streakVal);
    }
  }
}

killstreakEarned(streakName) {
  if(isDefined(self.class_num)) {
    class_num = self.class_num;
    if(class_num == -1) {
      actual_class_name = self.pers["copyCatLoadout"]["className"];
      class_num = getClassIndex(actual_class_name);
      if(IsSubStr(actual_class_name, "practice")) {
        class_num = self.pers["copyCatLoadout"]["practiceClassNum"];
      }
    }

    if(isSubstr(self.class, "custom")) {
      if(self getCacPlayerData(class_num, "assaultStreaks", 0, "streak") == streakName) {
        self.firstKillstreakEarned = getTime();
      } else if(self getCaCPlayerData(class_num, "assaultStreaks", 2, "streak") == streakName && isDefined(self.firstKillstreakEarned)) {
        if(getTime() - self.firstKillstreakEarned < 20000) {
          self thread maps\mp\gametypes\_missions::genericChallenge("wargasm");
        }
      }
    }
  }
}

earnKillstreak(streakName, streakVal) {
  self.earnedStreakLevel = streakVal;

  modules = getKillstreakModules(self, streakName);

  slotIndex = self maps\mp\killstreaks\_killstreaks::getNextKillstreakSlotIndex(streakName, true);

  self thread maps\mp\_events::earnedKillStreakEvent(streakName, streakVal, modules, slotIndex);
  self thread killstreakEarned(streakName);
  self.pers["lastEarnedStreak"] = streakName;

  self giveKillstreak(streakName, true, true, self, modules);

  if(self _hasPerk("specialty_class_hardline")) {
    self maps\mp\gametypes\_missions::processChallenge("ch_perk_hardline");
  }
}

getKillstreakModules(owner, streakName) {
  Assert(IsPlayer(owner) && isDefined(owner.killStreakModules));

  modules = [];

  moduleRefs = GetArrayKeys(self.killStreakModules);

  foreach(module in moduleRefs) {
    baseKillstreakRef = getStreakModuleBaseKillstreak(module);
    if(baseKillstreakRef == streakName) {
      modules[modules.size] = module;
    }
  }

  return modules;
}

getNextHordeKillStreakSlotIndex(slotNumber) {
  if(!isDefined(slotNumber)) {
    slotNumber = level.KILLSTREAK_GIMME_SLOT;
  }

  return slotNumber;
}

giveHordeKillStreak(streakName, owner, modules, slotNumber, available) {
  self endon("givingLoadout");

  if(!isDefined(level.killstreakFuncs[streakName]) || tableLookup(level.KILLSTREAK_STRING_TABLE, 1, streakName, 0) == "") {
    AssertMsg("giveKillstreak() called with invalid killstreak: " + streakName);
    return;
  }

  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }

  self endon("disconnect");

  index = undefined;

  nextSlot = self.pers["killstreaks"].size;

  if(isDefined(slotNumber)) {
    nextSlot = slotNumber;
  }

  if(!isDefined(self.pers["killstreaks"][nextSlot])) {
    self.pers["killstreaks"][nextSlot] = spawnStruct();
  }

  self_pers_killstreak_nextSlot = self.pers["killstreaks"][nextSlot];

  self_pers_killstreak_nextSlot.available = false;
  self_pers_killstreak_nextSlot.streakName = streakName;
  self_pers_killstreak_nextSlot.earned = false;
  self_pers_killstreak_nextSlot.awardxp = false;
  self_pers_killstreak_nextSlot.owner = owner;
  self_pers_killstreak_nextSlot.kID = self.pers["kID"];
  self_pers_killstreak_nextSlot.lifeId = -1;
  self_pers_killstreak_nextSlot.isGimme = true;

  index = getNextHordeKillStreakSlotIndex(slotNumber);

  if(!isDefined(modules) || !IsArray(modules)) {
    modules = getKillstreakModules(self, streakName);
  }
  self_pers_killstreak_nextSlot.modules = modules;

  self.pers["killstreaks"][index].nextSlot = nextSlot;
  self.pers["killstreaks"][index].streakName = streakName;

  streakIndex = getKillstreakIndex(streakName);
  killstreak_iconName = "ks_icon" + toString(index);
  self SetClientOmnvar(killstreak_iconName, streakIndex);

  if(!available) {
    self updateStreakSlots();

    if(isDefined(level.killstreakSetupFuncs[streakName])) {
      self[[level.killstreakSetupFuncs[streakName]]]();
    }

    self SetClientOmnvar("ks_acquired", 1);

    return;
  }

  self_pers_killstreak_index = self.pers["killstreaks"][index];
  self_pers_killstreak_index.available = true;
  self_pers_killstreak_index.earned = false;
  self_pers_killstreak_index.awardxp = false;
  self_pers_killstreak_index.owner = owner;
  self_pers_killstreak_index.kID = self.pers["kID"];
  if(isDefined(modules) && IsArray(modules)) {
    self_pers_killstreak_index.modules = modules;
  } else {
    self_pers_killstreak_index.modules = getKillstreakModules(self, streakName);
  }
  self.pers["kID"]++;

  self_pers_killstreak_index.lifeId = -1;

  if(level.console || self is_player_gamepad_enabled()) {
    weapon = getKillstreakWeapon(streakName, modules);
    self giveKillstreakWeapon(weapon);

    if(isDefined(self.killstreakIndexWeapon)) {
      streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
      killstreakWeapon = getKillstreakWeapon(streakName, modules);
      currentWeapon = self GetCurrentWeapon();
      if(currentWeapon != killstreakWeapon && !IsSubStr(currentWeapon, "turrethead")) {
        self.killstreakIndexWeapon = index;
      }
    } else {
      self.killstreakIndexWeapon = index;
    }
  } else {
    if(level.KILLSTREAK_GIMME_SLOT == index && self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT].nextSlot > level.KILLSTREAK_STACKING_START_SLOT) {
      slotToTake = self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT].nextSlot - 1;
      killstreakWeaponToTake = getKillstreakWeapon(self.pers["killstreaks"][slotToTake].streakName, self.pers["killstreaks"][slotToTake].modules);
      self TakeWeapon(killstreakWeaponToTake);
    }

    killstreakWeapon = getKillstreakWeapon(streakName, modules);
    self _giveWeapon(killstreakWeapon, 0);
    self _setActionSlot(index + 4, "weapon", killstreakWeapon);
  }

  self updateStreakSlots();

  if(isDefined(level.killstreakSetupFuncs[streakName])) {
    self[[level.killstreakSetupFuncs[streakName]]]();
  }

  self SetClientOmnvar("ks_acquired", 1);
}

getNextKillstreakSlotIndex(streakName, isEarned, slotNumber) {
  nextSlotIndex = undefined;

  if(!isDefined(isEarned) || isEarned == false) {
    if(!isDefined(slotNumber)) {
      nextSlotIndex = level.KILLSTREAK_GIMME_SLOT;
    } else {
      nextSlotIndex = slotNumber;
    }
  } else {
    for(i = level.KILLSTREAK_SLOT_1; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
      self_pers_killstreak_i = self.pers["killstreaks"][i];
      if(isDefined(self_pers_killstreak_i) && isDefined(self_pers_killstreak_i.streakName) && streakName == self_pers_killstreak_i.streakName) {
        nextSlotIndex = i;
        break;
      }
    }
  }

  return nextSlotIndex;
}

giveKillstreak(streakName, isEarned, awardXp, owner, modules, slotNumber) {
  self endon("givingLoadout");

  if(!isDefined(level.killstreakFuncs[streakName]) || tableLookup(level.KILLSTREAK_STRING_TABLE, 1, streakName, 0) == "") {
    AssertMsg("giveKillstreak() called with invalid killstreak: " + streakName);
    return;
  }

  if(!isDefined(self.pers["killstreaks"])) {
    return;
  }

  self endon("disconnect");

  index = undefined;
  if(!isDefined(isEarned) || isEarned == false) {
    nextSlot = self.pers["killstreaks"].size;

    if(isDefined(slotNumber)) {
      nextSlot = slotNumber;
    }

    if(!isDefined(self.pers["killstreaks"][nextSlot])) {
      self.pers["killstreaks"][nextSlot] = spawnStruct();
    }

    self_pers_killstreak_nextSlot = self.pers["killstreaks"][nextSlot];

    self_pers_killstreak_nextSlot.available = false;
    self_pers_killstreak_nextSlot.streakName = streakName;
    self_pers_killstreak_nextSlot.earned = false;
    self_pers_killstreak_nextSlot.awardxp = isDefined(awardXp) && awardXp;
    self_pers_killstreak_nextSlot.owner = owner;
    self_pers_killstreak_nextSlot.kID = self.pers["kID"];
    self_pers_killstreak_nextSlot.lifeId = -1;
    self_pers_killstreak_nextSlot.isGimme = true;

    index = getNextKillstreakSlotIndex(streakName, isEarned, slotNumber);

    if(!isDefined(modules) || !IsArray(modules)) {
      modules = getKillstreakModules(self, streakName);
    }
    self_pers_killstreak_nextSlot.modules = modules;

    self.pers["killstreaks"][index].nextSlot = nextSlot;
    self.pers["killstreaks"][index].streakName = streakName;

    streakIndex = getKillstreakIndex(streakName);
    killstreak_iconName = "ks_icon" + toString(index);
    self SetClientOmnvar(killstreak_iconName, streakIndex);
  } else {
    index = getNextKillstreakSlotIndex(streakName, isEarned, slotNumber);

    if(!isDefined(index)) {
      println("self.killstreaks");
      keys = getArrayKeys(self.killstreaks);
      for(i = 0; i < keys.size; i++) {
        println(" self.killstreaks[\"" + keys[i] + "\"] = ", self.killstreaks[keys[i]]);
      }

      println("self.pers[\"killstreaks\"]");
      for(i = 0; i < self.pers["killstreaks"].size; i++) {
        killstreak_struct = self.pers["killstreaks"][i];
        if(isDefined(killstreak_struct.streakname)) {
          println(" self.pers[\"killstreaks\"][\"" + i + "\"] = ", killstreak_struct.streakname);
        }
      }
      AssertMsg("earnKillstreak() trying to give unearnable killstreak with giveKillstreak(): " + streakName + ". See log for details");

      return;
    }
  }

  self_pers_killstreak_index = self.pers["killstreaks"][index];
  self_pers_killstreak_index.available = true;
  self_pers_killstreak_index.earned = isDefined(isEarned) && isEarned;
  self_pers_killstreak_index.awardxp = isDefined(awardXp) && awardXp;
  self_pers_killstreak_index.owner = owner;
  self_pers_killstreak_index.kID = self.pers["kID"];
  if(isDefined(modules) && IsArray(modules)) {
    self_pers_killstreak_index.modules = modules;
  } else {
    self_pers_killstreak_index.modules = getKillstreakModules(self, streakName);
  }

  self.pers["kID"]++;

  if(!self_pers_killstreak_index.earned) {
    self_pers_killstreak_index.lifeId = -1;
  } else {
    self_pers_killstreak_index.lifeId = self.pers["deaths"];
  }

  if(level.console || self is_player_gamepad_enabled()) {
    weapon = getKillstreakWeapon(streakName, modules);
    self giveKillstreakWeapon(weapon);

    if(isDefined(self.killstreakIndexWeapon)) {
      streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
      killstreakWeapon = getKillstreakWeapon(streakName, modules);
      currentWeapon = self GetCurrentWeapon();
      if(currentWeapon != killstreakWeapon && !IsSubStr(currentWeapon, "turrethead")) {
        self.killstreakIndexWeapon = index;
      }
    } else {
      self.killstreakIndexWeapon = index;
    }
  } else {
    if(level.KILLSTREAK_GIMME_SLOT == index && self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT].nextSlot > level.KILLSTREAK_STACKING_START_SLOT) {
      slotToTake = self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT].nextSlot - 1;
      killstreakWeaponToTake = getKillstreakWeapon(self.pers["killstreaks"][slotToTake].streakName, self.pers["killstreaks"][slotToTake].modules);
      self TakeWeapon(killstreakWeaponToTake);
    }

    killstreakWeapon = getKillstreakWeapon(streakName, modules);
    self _giveWeapon(killstreakWeapon, 0);
    self _setActionSlot(index + 4, "weapon", killstreakWeapon);
  }

  self updateStreakSlots();

  if(isDefined(level.killstreakSetupFuncs[streakName])) {
    self[[level.killstreakSetupFuncs[streakName]]]();
  }

  if(isDefined(isEarned) && isEarned && isDefined(awardXp) && awardXp) {
    self notify("received_earned_killstreak");
  }

  self SetClientOmnvar("ks_acquired", 1);
}

giveKillstreakWeapon(weapon) {
  self endon("disconnect");

  if(!level.console && !self is_player_gamepad_enabled()) {
    return;
  }

  weaponList = self GetWeaponsListItems();

  foreach(item in weaponList) {
    if(!isStrStart(item, "killstreak_") && !isStrStart(item, "airdrop_") && !isStrStart(item, "deployable_")) {
      continue;
    }

    if(self GetCurrentWeapon() == item) {
      continue;
    }

    while(self isChangingWeapon()) {
      wait(0.05);
    }

    self TakeWeapon(item);
  }

  if(isDefined(self.killstreakIndexWeapon)) {
    streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
    modules = self.pers["killstreaks"][self.killstreakIndexWeapon].modules;
    killstreakWeapon = getKillstreakWeapon(streakName, modules);
    if(self GetCurrentWeapon() != killstreakWeapon) {
      self _giveWeapon(weapon, 0);
      self _setActionSlot(4, "weapon", weapon);
    }
  } else {
    self _giveWeapon(weapon, 0);
    self _setActionSlot(4, "weapon", weapon);
  }
}

getStreakModuleCost(moduleName) {
  return int(TableLookup(level.KS_MODULES_TABLE, level.KS_MODULE_REF_COLUMN, moduleName, level.KS_MODULE_ADDED_POINTS_COLUMN));
}

getStreakModuleBaseKillstreak(moduleName) {
  return TableLookup(level.KS_MODULES_TABLE, level.KS_MODULE_REF_COLUMN, moduleName, level.KS_MODULE_KILLSTREAK_REF_COLUMN);
}

getAllStreakModulesCost(streakName) {
  Assert(IsPlayer(self) && isDefined(self.killStreakModules));

  cost = 0;

  moduleRefs = GetArrayKeys(self.killStreakModules);

  foreach(module in moduleRefs) {
    baseKillstreakRef = getStreakModuleBaseKillstreak(module);
    if(baseKillstreakRef == streakName) {
      cost += self.killStreakModules[module];
    }
  }

  return cost;
}

getStreakCost(streakName) {
  cost = int(getKillstreakKills(streakName));

  if(IsPlayer(self)) {
    cost += getAllStreakModulesCost(streakName);
  }

  if(isDefined(self) && IsPlayer(self)) {
    if(cost > 100 && self _hasPerk("specialty_hardline")) {
      cost -= 100;
    }
  }

  return cost;
}

getKillstreakHint(streakName) {
  return tableLookupIString(level.KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_EARNED_HINT_COLUMN);
}

getKillstreakInformEnemy(streakName) {
  return int(tableLookup(level.KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_ENEMY_USE_DIALOG_COLUMN));
}

getKillstreakDialog(streakName) {
  return tableLookup(level.KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, KILLSTREAK_EARN_DIALOG_COLUMN);
}

getKillstreakCrateIcon(streakName, modules) {
  column = KILLSTREAK_OVERHEAD_ICON_COLUMN;
  if(isDefined(modules) && modules.size > 0) {
    switch (modules.size) {
      case 1:
        column = KILLSTREAK_OVERHEAD_ICON_PLUS_1_COLUMN;
        break;
      case 2:
        column = KILLSTREAK_OVERHEAD_ICON_PLUS_2_COLUMN;
        break;
      case 3:
        column = KILLSTREAK_OVERHEAD_ICON_PLUS_3_COLUMN;
        break;
      default:
        AssertMsg("Too many modules for func getKillstreakCrateIcon");
        break;
    }
  }

  return tableLookup(level.KILLSTREAK_STRING_TABLE, KILLSTREAK_NAME_COLUMN, streakName, column);
}

giveOwnedKillstreakItem(skipDialog) {
  self_pers_killstreaks = self.pers["killstreaks"];

  if(level.console || self is_player_gamepad_enabled()) {
    keepIndex = -1;
    highestCost = -1;
    for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
      if(isDefined(self_pers_killstreaks[i]) &&
        isDefined(self_pers_killstreaks[i].streakName) &&
        self_pers_killstreaks[i].available &&
        getStreakCost(self_pers_killstreaks[i].streakName) > highestCost) {
        highestCost = 0;
        if(!self_pers_killstreaks[i].isGimme) {
          highestCost = getStreakCost(self_pers_killstreaks[i].streakName);
        }
        keepIndex = i;
      }
    }

    if(keepIndex != -1) {
      self.killstreakIndexWeapon = keepIndex;

      streakName = self_pers_killstreaks[self.killstreakIndexWeapon].streakName;
      modules = self.pers["killstreaks"][self.killstreakIndexWeapon].modules;
      weapon = getKillstreakWeapon(streakName, modules);
      self giveKillstreakWeapon(weapon);
    } else {
      self.killstreakIndexWeapon = undefined;
    }
  } else {
    keepIndex = -1;
    highestCost = -1;

    for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
      if(isDefined(self_pers_killstreaks[i]) &&
        isDefined(self_pers_killstreaks[i].streakName) &&
        self_pers_killstreaks[i].available) {
        killstreakWeapon = getKillstreakWeapon(self_pers_killstreaks[i].streakName, self_pers_killstreaks[i].modules);
        weaponsListItems = self GetWeaponsListItems();
        hasKillstreakWeapon = false;
        for(j = 0; j < weaponsListItems.size; j++) {
          if(killstreakWeapon == weaponsListItems[j]) {
            hasKillstreakWeapon = true;
            break;
          }
        }

        if(!hasKillstreakWeapon) {
          self _giveWeapon(killstreakWeapon);
        } else {
          if(IsSubStr(killstreakWeapon, "airdrop_")) {
            self SetWeaponAmmoClip(killstreakWeapon, 1);
          }
        }

        self _setActionSlot(i + 4, "weapon", killstreakWeapon);

        if(getStreakCost(self_pers_killstreaks[i].streakName) > highestCost) {
          highestCost = 0;
          if(!self_pers_killstreaks[i].isGimme) {
            highestCost = getStreakCost(self_pers_killstreaks[i].streakName);
          }
          keepIndex = i;
        }
      }
    }

    if(keepIndex != -1) {
      streakName = self_pers_killstreaks[keepIndex].streakName;
    }

    self.killstreakIndexWeapon = undefined;
  }

  updateStreakSlots();
}

playerWaittillRideKillstreakComplete() {
  if(!isDefined(self.remoteRideTransition)) {
    return;
  }

  self endon("rideKillstreakComplete");

  self waittill("rideKillstreakFailed");
}

playerWaittillRideKillstreakBlack() {
  if(!isDefined(self.remoteRideTransition)) {
    return;
  }

  self endon("rideKillstreakBlack");

  self waittill("rideKillstreakFailed");
}

initRideKillstreak(streak, bSkipScreenFade, blackoutTimeOverride, fullBlackoutDelayOverride) {
  if(!isDefined(bSkipScreenFade)) {
    bSkipScreenFade = false;
  }

  self playerDestroyGlassBelow();
  self _disableUsability();
  self freezeControlsWrapper(true);
  self.remoteRideTransition = true;
  result = self initRideKillstreak_internal(streak, bSkipScreenFade, blackoutTimeOverride, fullBlackoutDelayOverride);

  if(isDefined(self)) {
    self freezeControlsWrapper(false);
    self _enableUsability();
    self.remoteRideTransition = undefined;

    if(result == "success") {
      self notify("rideKillstreakBlack");
    } else {
      self playerRemoteKillstreakShowHud();
      self notify("rideKillstreakFailed");
    }
  }

  return result;
}

initRideKillstreak_internal(streak, bSkipScreenFade, blackoutTimeOverride, fullBlackoutDelayOverride) {
  self thread resetPlayerOnTeamChange();

  laptopWait = "none";
  laptopWaitTime = 0.75;
  if(isDefined(streak) && streak == "coop") {
    laptopWaitTime = 0.05;
  }

  laptopWait = self waittill_any_timeout(laptopWaitTime, "disconnect", "death", "weapon_switch_started");

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  if(laptopWait == "disconnect") {
    return "disconnect";
  }

  if(laptopWait == "death") {
    return "fail";
  }

  if(laptopWait == "weapon_switch_started") {
    return "fail";
  }

  if(!isDefined(self) || !isAlive(self)) {
    return "fail";
  }

  if(!self IsOnGround() && !self IsLinked()) {
    return "fail";
  }

  if(isDefined(self.underWater) && self.underWater) {
    return "fail";
  }

  if(level.gameEnded) {
    return "fail";
  }

  if(self isEMPed() || self isAirDenied()) {
    return "fail";
  }

  self playerRemoteKillstreakHideHud();
  self playerDestroyGlassBelow();

  if(bSkipScreenFade) {
    if(!isDefined(blackoutTimeOverride)) {
      blackoutTimeOverride = 1.0;
    }
  } else {
    if(!isDefined(blackoutTimeOverride)) {
      blackoutTimeOverride = 0.80;
    }

    self SetClientOmnvar("ui_killstreak_blackout", 1);
    self SetClientOmnvar("ui_killstreak_blackout_fade_end", GetTime() + int(blackoutTimeOverride * 1000));
    self thread clearRideIntroOnTeamChange();
    self thread clearRideIntroOnRoundTransition();
  }

  laptopWait = self waittill_any_timeout(blackoutTimeOverride, "disconnect", "death");

  if(laptopWait == "disconnect" || !isDefined(self)) {
    return "disconnect";
  }

  if(!isDefined(fullBlackoutDelayOverride)) {
    fullBlackoutDelayOverride = 0.6;
  }

  if(bSkipScreenFade) {
    self notify("intro_cleared");
  } else {
    self thread clearRideIntro(fullBlackoutDelayOverride);
  }

  if(laptopWait == "death") {
    return "fail";
  }

  if(!isDefined(self) || !isAlive(self)) {
    return "fail";
  }

  if(!self IsOnGround() && !self IsLinked()) {
    return "fail";
  }

  if(isDefined(self.underWater) && self.underWater) {
    return "fail";
  }

  if(level.gameEnded) {
    return "fail";
  }

  if(self isEMPed() || self isAirDenied()) {
    return "fail";
  }

  maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

  return "success";
}

clearRideIntro(delay) {
  self endon("disconnect");
  self endon("joined_team");

  if(isDefined(delay)) {
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(delay);
  }

  transitionFade = 0.5;

  self SetClientOmnvar("ui_killstreak_blackout", 0);
  self SetClientOmnvar("ui_killstreak_blackout_fade_end", GetTime() + int(transitionFade * 1000));

  wait transitionFade;

  if(!isDefined(self)) {
    return;
  }

  self notify("rideKillstreakComplete");
}

resetPlayerOnTeamChange() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");

  self waittill("joined_team");

  self freezeControlsWrapper(false);
  self.remoteRideTransition = undefined;
  if(self.disabledUsability) {
    self _enableUsability();
  }
  if(self isUsingRemote()) {
    self clearUsingRemote();
  }
}

clearRideIntroOnTeamChange() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");

  self waittill("joined_team");

  self SetClientOmnvar("ui_killstreak_blackout", 0);
  self SetClientOmnvar("ui_killstreak_blackout_fade_end", 0);
  self playerRemoteKillstreakShowHud();

  self notify("rideKillstreakComplete");
}

clearRideIntroOnRoundTransition() {
  self endon("rideKillstreakComplete");
  self endon("rideKillstreakFailed");

  level waittill("game_ended");

  self SetClientOmnvar("ui_killstreak_blackout", 0);
  self SetClientOmnvar("ui_killstreak_blackout_fade_end", 0);
  self playerRemoteKillstreakShowHud();

  self notify("rideKillstreakComplete");
}

playerDestroyGlassBelow() {
  if(self IsOnGround()) {
    trace = bulletTrace(self.origin + (0, 0, 5), self.origin + (0, 0, -5), false);
    if(isDefined(trace["glass"])) {
      DestroyGlass(trace["glass"]);
    }
  }
}

giveSelectedKillstreakItem() {
  streakName = self.pers["killstreaks"][self.killstreakIndexWeapon].streakName;
  modules = self.pers["killstreaks"][self.killstreakIndexWeapon].modules;

  weapon = getKillstreakWeapon(streakName, modules);
  self giveKillstreakWeapon(weapon);

  self updateStreakSlots();
}

getKillstreakCount() {
  numAvailable = 0;
  for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    if(isDefined(self.pers["killstreaks"][i]) &&
      isDefined(self.pers["killstreaks"][i].streakName) &&
      self.pers["killstreaks"][i].available) {
      numAvailable++;
    }
  }
  return numAvailable;
}

shuffleKillstreaksUp() {
  if(getKillstreakCount() > 1) {
    while(true) {
      self.killstreakIndexWeapon++;
      if(self.killstreakIndexWeapon >= level.KILLSTREAK_STACKING_START_SLOT) {
        self.killstreakIndexWeapon = 0;
      }
      if(self.pers["killstreaks"][self.killstreakIndexWeapon].available == true) {
        break;
      }
    }

    giveSelectedKillstreakItem();
  }
}

shuffleKillstreaksDown() {
  if(getKillstreakCount() > 1) {
    while(true) {
      self.killstreakIndexWeapon--;
      if(self.killstreakIndexWeapon < 0) {
        self.killstreakIndexWeapon = level.KILLSTREAK_STACKING_START_SLOT - 1;
      }
      if(self.pers["killstreaks"][self.killstreakIndexWeapon].available == true) {
        break;
      }
    }

    giveSelectedKillstreakItem();
  }
}

streakSelectUpTracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("horde_end_spectate");
  }

  for(;;) {
    self waittill("toggled_up");

    if(!level.Console && !self is_player_gamepad_enabled()) {
      continue;
    }

    if(canShuffleKillstreaks()) {
      self shuffleKillstreaksUp();
    }
    wait(.12);
  }
}

streakSelectDownTracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  if(isDefined(level.isHorde) && level.isHorde) {
    self endon("horde_end_spectate");
  }

  for(;;) {
    self waittill("toggled_down");

    if(!level.Console && !self is_player_gamepad_enabled()) {
      continue;
    }

    if(canShuffleKillstreaks()) {
      self shuffleKillstreaksDown();
    }
    wait(.12);
  }
}

canShuffleKillstreaks() {
  return (!self isMantling() &&
    (!isDefined(self.changingWeapon) || (isDefined(self.changingWeapon) && self.changingWeapon == "none")) &&
    (canShuffleWithKillstreakWeapon()) &&
    (!isDefined(self.isCarrying) || (isDefined(self.isCarrying) && self.isCarrying == false)));
}

canShuffleWithKillstreakWeapon() {
  curWeapon = self GetCurrentWeapon();
  return (!isKillstreakWeapon(curWeapon) ||
    (isKillstreakWeapon(curWeapon) && self isJuggernaut()));
}

streakNotifyTracker() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");

  if(IsBot(self)) {
    return;
  }

  gameFlagWait("prematch_done");

  self notifyOnPlayerCommand("toggled_up", "+actionslot 1");
  self notifyOnPlayerCommand("toggled_down", "+actionslot 2");

  if(!level.console) {
    self notifyOnPlayerCommand("streakUsed1", "+actionslot 4");
    self notifyOnPlayerCommand("streakUsed2", "+actionslot 5");
    self notifyOnPlayerCommand("streakUsed3", "+actionslot 6");
    self notifyOnPlayerCommand("streakUsed4", "+actionslot 7");
    self notifyOnPlayerCommand("streakUsed5", "+actionslot 8");
  }
}

giveAdrenalineDirect(value) {
  if(!value) {
    return;
  }

  totalKillStreakScore = self.adrenaline + value;
  maxStreakCost = self getMaxStreakCost(false);

  if(totalKillStreakScore >= maxStreakCost) {
    totalKillStreakScore = totalKillStreakScore - maxStreakCost;
  }

  self setAdrenaline(totalKillStreakScore);

  totalKillStreakScore = self.adrenalineSupport + value;
  maxStreakCost = self getMaxStreakCost(true);

  if(totalKillStreakScore >= maxStreakCost) {
    totalKillStreakScore = totalKillStreakScore - maxStreakCost;
  }

  self setAdrenalineSupport(totalKillStreakScore);

  self updateStreakCount();
  self checkStreakReward();
}

roundUp(floatVal) {
  if(int(floatVal) != floatVal) {
    return int(floatVal + 1);
  } else {
    return int(floatVal);
  }
}

giveAdrenaline(event) {
  scoreReward = maps\mp\gametypes\_rank::getScoreInfoValue(event);

  if(isReallyAlive(self)) {
    self giveAdrenalineDirect(scoreReward);
  }

  self displayKillStreakPoints(event, scoreReward);
}

displayKillStreakPoints(event, scoreReward) {
  if(!level.hardcoreMode) {
    self thread maps\mp\gametypes\_rank::xpPointsPopup(event, scoreReward);
  }
}

resetAdrenaline(clearSupportStreaks) {
  self.earnedStreakLevel = 0;
  self setAdrenaline(0);
  if(clearSupportStreaks) {
    self setAdrenalineSupport(0);
    self.pers["ks_totalPointsSupport"] = 0;
  }
  self updateStreakCount();
  self.pers["ks_totalPoints"] = 0;
  self.pers["lastEarnedStreak"] = undefined;
}

setAdrenaline(value) {
  if(value < 0) {
    value = 0;
  }

  if(isDefined(self.adrenaline) && self.adrenaline != 0) {
    self.previousAdrenaline = self.adrenaline;
  } else {
    self.previousAdrenaline = 0;
  }

  self.adrenaline = value;
  self.pers["ks_totalPoints"] = self.adrenaline;
}

setAdrenalineSupport(value) {
  if(value < 0) {
    value = 0;
  }

  if(isDefined(self.adrenalineSupport) && self.adrenalineSupport != 0) {
    self.previousAdrenalineSupport = self.adrenalineSupport;
  } else {
    self.previousAdrenalineSupport = 0;
  }

  self.adrenalineSupport = value;
  self.pers["ks_totalPointsSupport"] = self.adrenalineSupport;
}

pc_watchControlsChanged() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  usingController = self is_player_gamepad_enabled();

  while(true) {
    if(self isInRemoteTransition() || self isUsingRemote() || self isChangingWeapon()) {
      while(self isInRemoteTransition() || self isUsingRemote() || self isChangingWeapon()) {
        waitframe();
      }
      waitframe();
    }

    if(usingController != self is_player_gamepad_enabled()) {
      self thread updateKillstreaks(true);
      usingController = self is_player_gamepad_enabled();
    }

    waitframe();
  }
}

pc_watchStreakUse() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("faux_spawn");

  self.actionSlotEnabled = [];
  self.actionSlotEnabled[level.KILLSTREAK_GIMME_SLOT] = true;
  self.actionSlotEnabled[level.KILLSTREAK_SLOT_1] = true;
  self.actionSlotEnabled[level.KILLSTREAK_SLOT_2] = true;
  self.actionSlotEnabled[level.KILLSTREAK_SLOT_3] = true;
  self.actionSlotEnabled[level.KILLSTREAK_SLOT_4] = true;

  if(!IsBot(self)) {
    self thread pc_watchControlsChanged();
  }

  while(true) {
    result = self waittill_any_return("streakUsed1", "streakUsed2", "streakUsed3", "streakUsed4", "streakUsed5");

    if(self is_player_gamepad_enabled()) {
      continue;
    }

    if(!isDefined(result)) {
      continue;
    }

    if(isDefined(self.changingWeapon) && self.changingWeapon == "none") {
      continue;
    }

    switch (result) {
      case "streakUsed1":
        if(self.pers["killstreaks"][level.KILLSTREAK_GIMME_SLOT].available && self.actionSlotEnabled[level.KILLSTREAK_GIMME_SLOT]) {
          self.killstreakIndexWeapon = level.KILLSTREAK_GIMME_SLOT;
        }
        break;
      case "streakUsed2":
        if(self.pers["killstreaks"][level.KILLSTREAK_SLOT_1].available && self.actionSlotEnabled[level.KILLSTREAK_SLOT_1]) {
          self.killstreakIndexWeapon = level.KILLSTREAK_SLOT_1;
        }
        break;
      case "streakUsed3":
        if(self.pers["killstreaks"][level.KILLSTREAK_SLOT_2].available && self.actionSlotEnabled[level.KILLSTREAK_SLOT_2]) {
          self.killstreakIndexWeapon = level.KILLSTREAK_SLOT_2;
        }
        break;
      case "streakUsed4":
        if(self.pers["killstreaks"][level.KILLSTREAK_SLOT_3].available && self.actionSlotEnabled[level.KILLSTREAK_SLOT_3]) {
          self.killstreakIndexWeapon = level.KILLSTREAK_SLOT_3;
        }
        break;
      case "streakUsed5":
        if(self.pers["killstreaks"][level.KILLSTREAK_SLOT_4].available && self.actionSlotEnabled[level.KILLSTREAK_SLOT_4]) {
          self.killstreakIndexWeapon = level.KILLSTREAK_SLOT_4;
        }
        break;
    }

    if(isDefined(self.killstreakIndexWeapon) && !self.pers["killstreaks"][self.killstreakIndexWeapon].available) {
      self.killstreakIndexWeapon = undefined;
    }

    if(isDefined(self.killstreakIndexWeapon)) {
      if(!IsBot(self)) {
        self disableKillstreakActionSlots();
      }
      while(true) {
        self waittill("weapon_change", newWeapon);
        if(isDefined(self.killstreakIndexWeapon)) {
          killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][self.killstreakIndexWeapon].streakName, self.pers["killstreaks"][self.killstreakIndexWeapon].modules);

          if(newWeapon == killstreakWeapon ||
            newWeapon == "none" ||
            (killstreakWeapon == "killstreak_uav_mp" && newWeapon == "uav_remote_mp") ||
            (killstreakWeapon == "killstreak_recreation_mp" && newWeapon == "uav_remote_mp")) {
            continue;
          }
          break;
        }

        break;
      }

      if(!IsBot(self)) {
        self enableKillstreakActionSlots();
      }
      self.killstreakIndexWeapon = undefined;
    }
  }
}

disableKillstreakActionSlots() {
  for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    if(!isDefined(self.killstreakIndexWeapon)) {
      break;
    }

    if(self.killstreakIndexWeapon == i) {
      continue;
    }

    self _setActionSlot(i + 4, "");
    self.actionSlotEnabled[i] = false;
  }
}

enableKillstreakActionSlots() {
  for(i = 0; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
    if(self.pers["killstreaks"][i].available) {
      killstreakWeapon = getKillstreakWeapon(self.pers["killstreaks"][i].streakName, self.pers["killstreaks"][i].modules);
      self _setActionSlot(i + 4, "weapon", killstreakWeapon);
    } else {
      self _setActionSlot(i + 4, "");
    }

    self.actionSlotEnabled[i] = true;
  }
}

killstreakHit(attacker, weapon, vehicle) {
  if(isDefined(weapon) && isPlayer(attacker) && isDefined(vehicle.owner) && isDefined(vehicle.owner.team)) {
    if(((level.teamBased && vehicle.owner.team != attacker.team) || !level.teamBased) && attacker != vehicle.owner) {
      if(isKillstreakWeapon(weapon)) {
        return;
      }

      if(!isDefined(attacker.lastHitTime[weapon])) {
        attacker.lastHitTime[weapon] = 0;
      }

      if(attacker.lastHitTime[weapon] == getTime()) {
        return;
      }

      attacker.lastHitTime[weapon] = getTime();

      attacker thread maps\mp\gametypes\_gamelogic::threadedSetWeaponStatByName(weapon, 1, "hits");

      totalShots = attacker maps\mp\gametypes\_persistence::statGetBuffered("totalShots");
      hits = attacker maps\mp\gametypes\_persistence::statGetBuffered("hits") + 1;

      if(hits <= totalShots) {
        attacker maps\mp\gametypes\_persistence::statSetBuffered("hits", hits);
        attacker maps\mp\gametypes\_persistence::statSetBuffered("misses", int(totalShots - hits));

        accuracy = Clamp(float(hits) / float(totalShots), 0.0, 1.0) * 10000.0;
        attacker maps\mp\gametypes\_persistence::statSetBuffered("accuracy", int(accuracy));
      }
    }
  }
}