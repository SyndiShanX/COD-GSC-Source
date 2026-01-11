/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\sotf_ffa.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_class;
#include maps\mp\gametypes\_hud_util;

CONST_MAX_ATTACHMENTS = 4;
CONST_CRATE_LIFE = 60;
CONST_CRATE_USE_TIME_OVERRIDE = 500;
CONST_WEAPON_NAME_COL = 2;
CONST_WEAPON_SELECTABLE_COL = 3;
CONST_DLC_MAPPACK_COL = 4;

main() {
  if(GetDvar("mapname") == "mp_background") {
    return;
  }
  maps\mp\gametypes\_globallogic::init();
  maps\mp\gametypes\_callbacksetup::SetupCallbacks();
  maps\mp\gametypes\_globallogic::SetupCallbacks();

  if(IsUsingMatchRulesData()) {
    level.initializeMatchRules = ::initializeMatchRules;
    [[level.initializeMatchRules]]();
    level thread reInitializeMatchRulesOnMigration();
  } else {
    registerScoreLimitDvar(level.gameType, 65);
    registerTimeLimitDvar(level.gameType, 10);
    registerRoundLimitDvar(level.gameType, 1);
    registerWinLimitDvar(level.gameType, 1);
    registerNumLivesDvar(level.gameType, 0);
    registerHalfTimeDvar(level.gameType, 0);

    level.matchRules_randomize = 0;
    level.matchRules_damageMultiplier = 0;
    level.matchRules_vampirism = 0;
  }

  setPlayerLoadout();

  SetTeamMode("ffa");
  level.teamBased = false;
  level.overrideCrateUseTime = CONST_CRATE_USE_TIME_OVERRIDE;
  level.onPlayerScore = ::onPlayerScore;
  level.onPrecacheGameType = ::onPrecacheGameType;
  level.onStartGameType = ::onStartGameType;
  level.getSpawnPoint = ::getSpawnPoint;
  level.onSpawnPlayer = ::onSpawnPlayer;
  level.onNormalDeath = ::onNormalDeath;
  level.customCrateFunc = ::sotfCrateContents;
  level.crateKill = ::crateKill;
  level.pickupWeaponHandler = ::pickupWeaponHandler;
  level.iconVisAll = ::iconVisAll;
  level.objVisAll = ::objVisAll;

  level.supportIntel = false;
  level.supportNuke = false;
  level.vehicleOverride = "littlebird_neutral_mp";

  level.usedLocations = [];
  level.emptyLocations = true;

  level.assists_disabled = true;

  if(level.matchRules_damageMultiplier || level.matchRules_vampirism) {
    level.modifyPlayerDamage = maps\mp\gametypes\_damage::gamemodeModifyPlayerDamage;
  }

  game["dialog"]["gametype"] = "hunted";

  if(getDvarInt("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "sotf_hint";
  game["dialog"]["defense_obj"] = "sotf_hint";
}

initializeMatchRules() {
  Assert(IsUsingMatchRulesData());

  setCommonRulesFromMatchRulesData();

  SetDynamicDvar("scr_sotf_ffa_crateamount", GetMatchRulesData("sotfFFAData", "crateAmount"));
  SetDynamicDvar("scr_sotf_ffa_crategunamount", GetMatchRulesData("sotfFFAData", "crateGunAmount"));
  SetDynamicDvar("scr_sotf_ffa_cratetimer", GetMatchRulesData("sotfFFAData", "crateDropTimer"));

  SetDynamicDvar("scr_sotf_ffa_roundlimit", 1);
  registerRoundLimitDvar("sotf_ffa", 1);
  SetDynamicDvar("scr_sotf_ffa_winlimit", 1);
  registerWinLimitDvar("sotf_ffa", 1);
  SetDynamicDvar("scr_sotf_ffa_halftime", 0);
  registerHalfTimeDvar("sotf_ffa", 0);

  SetDynamicDvar("scr_sotf_ffa_promode", 0);
}

onPrecacheGameType() {
  level._effect["signal_chest_drop"] = LoadFX("smoke/signal_smoke_airdrop");
  level._effect["signal_chest_drop_mover"] = LoadFX("smoke/airdrop_flare_mp_effect_now");
}

onStartGameType() {
  SetClientNameMode("auto_change");

  obj_text = &"OBJECTIVES_DM";
  obj_score_text = &"OBJECTIVES_DM_SCORE";
  obj_hint_text = &"OBJECTIVES_DM_HINT";

  setObjectiveText("allies", obj_text);
  setObjectiveText("axis", obj_text);

  if(level.splitscreen) {
    setObjectiveScoreText("allies", obj_text);
    setObjectiveScoreText("axis", obj_text);
  } else {
    setObjectiveScoreText("allies", obj_score_text);
    setObjectiveScoreText("axis", obj_score_text);
  }

  setObjectiveHintText("allies", obj_hint_text);
  setObjectiveHintText("axis", obj_hint_text);

  initSpawns();

  allowed = [];
  maps\mp\gametypes\_gameobjects::main(allowed);

  level thread sotf();
}

initSpawns() {
  level.spawnMins = (0, 0, 0);
  level.spawnMaxs = (0, 0, 0);

  maps\mp\gametypes\_spawnlogic::addSpawnPoints("allies", "mp_dm_spawn");
  maps\mp\gametypes\_spawnlogic::addSpawnPoints("axis", "mp_dm_spawn");

  level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
  SetMapCenter(level.mapCenter);
}

setPlayerLoadout() {
  defineChestWeapons();

  randomPistol = getRandomWeapon(level.pistolArray);

  pistolBaseName = getBaseWeaponName(randomPistol["name"]);
  pistolIndex = TableLookup("mp/sotfWeapons.csv", 2, pistolBaseName, 0);

  SetOmnvar("ui_sotf_pistol", int(pistolIndex));

  level.sotf_loadouts["axis"]["loadoutPrimary"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryBuff"] = "specialty_null";
  level.sotf_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutPrimaryReticle"] = "none";

  level.sotf_loadouts["axis"]["loadoutSecondary"] = randomPistol["name"];
  level.sotf_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryBuff"] = "specialty_null";
  level.sotf_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.sotf_loadouts["axis"]["loadoutSecondaryReticle"] = "none";

  level.sotf_loadouts["axis"]["loadoutEquipment"] = "throwingknife_mp";
  level.sotf_loadouts["axis"]["loadoutOffhand"] = "flash_grenade_mp";
  level.sotf_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.sotf_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.sotf_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.sotf_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.sotf_loadouts["axis"]["loadoutJuggernaut"] = false;
  level.sotf_loadouts["axis"]["loadoutPerks"] = ["specialty_longersprint", "specialty_extra_deadly"];

  level.sotf_loadouts["allies"] = level.sotf_loadouts["axis"];
}

getSpawnPoint() {
  spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.team);

  if(level.inGracePeriod) {
    spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
  } else {
    spawnPoint = maps\mp\gametypes\_spawnscoring::getSpawnpoint_FreeForAll(spawnPoints);
  }

  return spawnPoint;
}

onSpawnPlayer() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastClass = self.pers["lastClass"];

  self.pers["gamemodeLoadout"] = level.sotf_loadouts[self.pers["team"]];

  level notify("sotf_player_spawned", self);

  if(!isDefined(self.eventValue)) {
    self.eventValue = maps\mp\gametypes\_rank::getScoreInfoValue("kill");
    self setExtraScore0(self.eventValue);
  }

  self.oldPrimaryGun = undefined;
  self.newPrimaryGun = undefined;

  self thread waitLoadoutDone();
}

waitLoadoutDone() {
  level endon("game_ended");
  self endon("disconnect");

  self waittill("giveLoadout");

  playerWeapon = self GetCurrentWeapon();
  self SetWeaponAmmoStock(playerWeapon, 0);
  self.oldPrimaryGun = playerWeapon;

  self thread pickupWeaponHandler();
}

onPlayerScore(event, player, victim) {
  player.assists = player getPersStat("longestStreak");

  if(event == "kill") {
    score = maps\mp\gametypes\_rank::getScoreInfoValue("score_increment");
    assert(isDefined(score));

    return score;
  }

  return 0;
}

onNormalDeath(victim, attacker, lifeId) {
  attacker perkWatcher();

  score = maps\mp\gametypes\_rank::getScoreInfoValue("score_increment");
  assert(isDefined(score));

  highestScore = 0;

  foreach(player in level.players) {
    if(isDefined(player.score) && player.score > highestScore) {
      highestScore = player.score;
    }
  }

  if(game["state"] == "postgame" && attacker.score >= highestScore) {
    attacker.finalKill = true;
  }
}

sotf() {
  level thread startSpawnChest();
}

startSpawnChest() {
  level endon("game_ended");
  self endon("disconnect");

  crateAmount = GetDvarInt("scr_sotf_ffa_crateamount", 3);
  crateTimer = GetDvarInt("scr_sotf_ffa_cratetimer", 30);

  level waittill("sotf_player_spawned", player);

  for(;;) {
    if(!IsAlive(player)) {
      player = findNewOwner(level.players);

      if(!isDefined(player)) {
        continue;
      }
    } else {
      while(IsAlive(player)) {
        if(level.emptyLocations) {
          for(i = 0; i < crateAmount; i++) {
            level thread spawnChests(player);
          }

          level thread showCrateSplash("sotf_crates_incoming");

          wait(crateTimer);
        } else {
          wait(0.05);
        }
      }
    }
  }
}

showCrateSplash(splashRef) {
  foreach(player in level.players) {
    player thread maps\mp\gametypes\_hud_message::SplashNotify(splashRef);
  }
}

findNewOwner(playerPool) {
  foreach(player in playerPool) {
    if(IsAlive(player)) {
      return player;
    }
  }

  level waittill("sotf_player_spawned", newPlayer);
  return newPlayer;
}

spawnChests(player) {
  chestSpawns = getstructarray("sotf_chest_spawnpoint", "targetname");

  chestSpawnPoint = getRandomPoint(chestSpawns);

  if(isDefined(chestSpawnPoint)) {
    playFxAtPoint(chestSpawnPoint);

    level thread maps\mp\killstreaks\_airdrop::doFlyby(player, chestSpawnPoint, RandomFloat(360), "airdrop_sotf");
  }
}

playFxAtPoint(pos) {
  traceStart = pos + (0, 0, 30);
  traceEnd = pos + (0, 0, -1000);
  trace = bulletTrace(traceStart, traceEnd, false, undefined);

  spawnPoint = trace["position"] + (0, 0, 1);

  hitEntity = trace["entity"];
  if(isDefined(hitEntity)) {
    parent = hitEntity GetLinkedParent();
    while(isDefined(parent)) {
      hitEntity = parent;
      parent = hitEntity GetLinkedParent();
    }
  }

  if(isDefined(hitEntity)) {
    fxEntity = spawn("script_model", spawnPoint);
    fxEntity setModel("tag_origin");
    fxEntity.angles = (90, RandomIntRange(-180, 179), 0);

    fxEntity LinkTo(hitEntity);

    thread playLinkedSmokeEffect(getfx("signal_chest_drop_mover"), fxEntity);
  } else {
    playFX(getfx("signal_chest_drop"), spawnPoint);
  }

}

playLinkedSmokeEffect(fxId, fxEntity) {
  level endon("game_ended");

  wait(0.05);

  playFXOnTag(fxId, fxEntity, "tag_origin");

  wait(6);

  stopFXOnTag(fxId, fxEntity, "tag_origin");

  wait(0.05);

  fxEntity Delete();
}

getCenterPoint(spawnPoints) {
  chosenPoint = undefined;
  shortestDist = undefined;

  foreach(point in spawnPoints) {
    distTest = Distance2DSquared(level.mapCenter, point.origin);

    if(!isDefined(chosenPoint) || distTest < shortestDist) {
      chosenPoint = point;
      shortestDist = distTest;
    }
  }

  level.usedLocations[level.usedLocations.size] = chosenPoint.origin;

  return chosenPoint.origin;
}

getRandomPoint(spawnPoints) {
  validLocations = [];

  for(point = 0; point < spawnPoints.size; point++) {
    usedLocationFound = false;

    if(isDefined(level.usedLocations) && level.usedLocations.size > 0) {
      foreach(usedLocation in level.usedLocations) {
        if(spawnPoints[point].origin == usedLocation) {
          usedLocationFound = true;
          break;
        }
      }

      if(usedLocationFound) {
        continue;
      }
      validLocations[validLocations.size] = spawnPoints[point].origin;
    } else {
      validLocations[validLocations.size] = spawnPoints[point].origin;
    }
  }

  if(validLocations.size > 0) {
    value = RandomInt(validLocations.size);
    spawnLocation = validLocations[value];
    level.usedLocations[level.usedLocations.size] = spawnLocation;

    return spawnLocation;
  }

  level.emptyLocations = false;
  return undefined;
}

defineChestWeapons() {
  pistolArray = [];

  weaponArray = [];

  for(row = 0; TableLookupByRow("mp/sotfWeapons.csv", row, 0) != ""; row++) {
    weaponName = TableLookupIStringByRow("mp/sotfWeapons.csv", row, 2);
    weaponGroup = TableLookupIStringByRow("mp/sotfWeapons.csv", row, 1);

    selectableWeapon = isSelectableWeapon(weaponName);

    if(isDefined(weaponGroup) && selectableWeapon && (weapongroup == "weapon_pistol")) {
      weaponWeight = 30;

      pistolArray[pistolArray.size]["name"] = weaponName;
      pistolArray[pistolArray.size - 1]["weight"] = weaponWeight;
    } else if(isDefined(weaponGroup) && selectableWeapon &&
      (weapongroup == "weapon_shotgun" ||
        weapongroup == "weapon_smg" ||
        weapongroup == "weapon_assault" ||
        weapongroup == "weapon_sniper" ||
        weapongroup == "weapon_dmr" ||
        weapongroup == "weapon_lmg" ||
        weapongroup == "weapon_projectile")) {
      weaponWeight = 0;

      switch (weaponGroup) {
        case "weapon_shotgun":
          weaponWeight = 35;
          break;

        case "weapon_smg":
        case "weapon_assault":
          weaponWeight = 25;
          break;

        case "weapon_sniper":
        case "weapon_dmr":
          weaponWeight = 15;
          break;

        case "weapon_lmg":
          weaponWeight = 10;
          break;

        case "weapon_projectile":
          weaponWeight = 30;
          break;
      }

      weaponArray[weaponArray.size]["name"] = weaponName + "_mp";
      weaponArray[weaponArray.size - 1]["group"] = weaponGroup;
      weaponArray[weaponArray.size - 1]["weight"] = weaponWeight;
    } else
      continue;
  }

  weaponArray = sortByWeight(weaponArray);

  level.pistolArray = pistolArray;
  level.weaponArray = weaponArray;
}

sotfCrateContents(friendly_crate_model, enemy_crate_model) {
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_sotf", "sotf_weapon", 100, ::sotfCrateThink, friendly_crate_model, friendly_crate_model, &"KILLSTREAKS_HINTS_WEAPON_PICKUP");
}

sotfCrateThink(dropType) {
  self endon("death");
  self endon("restarting_physics");
  level endon("game_ended");

  if(isDefined(game["strings"][self.crateType + "_hint"])) {
    crateHint = game["strings"][self.crateType + "_hint"];
  } else {
    crateHint = &"PLATFORM_GET_KILLSTREAK";
  }

  weaponOverheadIcon = "icon_hunted";

  maps\mp\killstreaks\_airdrop::crateSetupForUse(crateHint, weaponOverheadIcon);

  self thread maps\mp\killstreaks\_airdrop::crateAllCaptureThink();

  self childthread crateWatcher(CONST_CRATE_LIFE);

  self childthread playerJoinWatcher();

  crateUseCount = 0;
  crateRemainingUses = GetDvarInt("scr_sotf_ffa_crategunamount", 1);

  for(;;) {
    self waittill("captured", player);

    player PlayLocalSound("ammo_crate_use");

    newWeapon = getRandomWeapon(level.weaponArray);

    newWeapon = getRandomAttachments(newWeapon);

    playerPrimary = player.lastDroppableWeapon;
    lastAmmoCount = player GetAmmoCount(playerPrimary);

    if(newWeapon == playerPrimary) {
      player GiveStartAmmo(newWeapon);
      player SetWeaponAmmoStock(newWeapon, lastAmmoCount);
    } else {
      if(isDefined(playerPrimary) && playerPrimary != "none") {
        dropped_weapon = player DropItem(playerPrimary);
        if(isDefined(dropped_weapon) && lastAmmoCount > 0) {
          dropped_weapon.targetname = "dropped_weapon";
        }
      }

      player giveWeapon(newWeapon, 0, false, 0, true);
      player SetWeaponAmmoStock(newWeapon, 0);
      player SwitchToWeaponImmediate(newWeapon);

      if(player GetWeaponAmmoClip(newWeapon) == 1) {
        player SetWeaponAmmoStock(newWeapon, 1);
      }

      player.oldPrimaryGun = newWeapon;
    }

    crateUseCount++;

    crateRemainingUses = crateRemainingUses - 1;

    if(crateRemainingUses > 0) {
      foreach(player in level.players) {
        self maps\mp\_entityheadIcons::setHeadIcon(player, "blitz_time_0" + crateRemainingUses + "_blue", (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
        self.crateHeadIcon = "blitz_time_0" + crateRemainingUses + "_blue";
      }
    }

    if(self.crateType == "sotf_weapon" && crateUseCount == GetDvarInt("scr_sotf_ffa_crategunamount", 1)) {
      self maps\mp\killstreaks\_airdrop::deleteCrate();
    }
  }
}

crateWatcher(delay) {
  wait(delay);

  while(isDefined(self.inUse) && self.inUse) {
    waitframe();
  }

  self maps\mp\killstreaks\_airdrop::deleteCrate();
}

playerJoinWatcher() {
  while(true) {
    level waittill("connected", player);

    if(!isDefined(player)) {
      continue;
    }
    self maps\mp\_entityheadIcons::setHeadIcon(player, self.crateHeadIcon, (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
  }
}

crateKill(dropPoint) {
  for(i = 0; i < level.usedLocations.size; i++) {
    if(dropPoint != level.usedLocations[i]) {
      continue;
    }
    level.usedLocations = array_remove(level.usedLocations, dropPoint);
  }

  level.emptyLocations = true;
}

isSelectableWeapon(weaponName) {
  selectableWeapon = TableLookup("mp/sotfWeapons.csv", CONST_WEAPON_NAME_COL, weaponName, CONST_WEAPON_SELECTABLE_COL);
  requiredPack = TableLookup("mp/sotfWeapons.csv", CONST_WEAPON_NAME_COL, weaponName, CONST_DLC_MAPPACK_COL);

  if(selectableWeapon == "TRUE" && (requiredPack == "" || GetDvarInt(requiredPack, 0) == 1)) {
    return true;
  }

  return false;
}

getRandomWeapon(weaponArray) {
  newWeaponArray = setBucketVal(weaponArray);

  randValue = RandomInt(level.weaponMaxVal["sum"]);

  newWeapon = undefined;

  for(i = 0; i < newWeaponArray.size; i++) {
    if(!newWeaponArray[i]["weight"]) {
      continue;
    }
    if(newWeaponArray[i]["weight"] > randValue) {
      newWeapon = newWeaponArray[i];
      break;
    }
  }

  return newWeapon;
}

getRandomAttachments(newWeapon) {
  validAttachments = [];
  usedAttachments = [];
  chosenAttachments = [];

  baseName = getBaseWeaponName(newWeapon["name"]);
  attachmentArray = getWeaponAttachmentArrayFromStats(baseName);

  if(attachmentArray.size > 0) {
    numAttachments = RandomInt(CONST_MAX_ATTACHMENTS + 1);

    for(i = 0; i < numAttachments; i++) {
      validAttachments = getValidAttachments(newWeapon, usedAttachments, attachmentArray);

      if(validAttachments.size == 0) {
        break;
      }

      randomIndex = RandomInt(validAttachments.size);

      usedAttachments[usedAttachments.size] = validAttachments[randomIndex];

      newAttachment = attachmentMap_toUnique(validAttachments[randomIndex], baseName);
      chosenAttachments[chosenAttachments.size] = newAttachment;
    }

    weapClass = getWeaponClass(newWeapon["name"]);

    if(weapClass == "weapon_dmr" || weapClass == "weapon_sniper" || baseName == "iw6_dlcweap02") {
      scopeFound = false;
      foreach(attachName in usedAttachments) {
        if(getAttachmentType(attachName) == "rail") {
          scopeFound = true;
          break;
        }
      }

      if(!scopeFound) {
        nameMid = StrTok(baseName, "_")[1];
        chosenAttachments[chosenAttachments.size] = nameMid + "scope";

      }
    }

    if(chosenAttachments.size > 0) {
      chosenAttachments = alphabetize(chosenAttachments);

      foreach(attachment in chosenAttachments) {
        newWeapon["name"] = newWeapon["name"] + "_" + attachment;
      }
    }
  }

  return newWeapon["name"];
}

getValidAttachments(newWeapon, usedAttachments, attachmentArray) {
  validAttachments = [];

  foreach(attachment in attachmentArray) {
    if(attachment == "gl" || attachment == "shotgun") {
      continue;
    }
    attachmentOK = attachmentCheck(attachment, usedAttachments);

    if(!attachmentOK) {
      continue;
    }
    validAttachments[validAttachments.size] = attachment;
  }

  return validAttachments;
}

attachmentCheck(attachment, usedAttachments) {
  for(i = 0; i < usedAttachments.size; i++) {
    if(attachment == usedAttachments[i] || !attachmentsCompatible(attachment, usedAttachments[i])) {
      return false;
    }
  }

  return true;
}

checkScopes(usedAttachments) {
  foreach(attachment in usedAttachments) {
    if(attachment == "thermal" || attachment == "vzscope" || attachment == "acog" || attachment == "ironsight") {
      return true;
    }
  }

  return false;
}

pickupWeaponHandler() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    waitframe();

    playerPrimaries = self GetWeaponsListPrimaries();

    if(playerPrimaries.size > 1) {
      foreach(weapon in playerPrimaries) {
        if(weapon == self.oldPrimaryGun) {
          oldAmmo = self GetAmmoCount(weapon);
          dropped_weapon = self DropItem(weapon);
          if(isDefined(dropped_weapon) && oldAmmo > 0) {
            dropped_weapon.targetname = "dropped_weapon";
          }
          break;
        }
      }

      playerPrimaries = array_remove(playerPrimaries, self.oldPrimaryGun);
      self.oldPrimaryGun = playerPrimaries[0];
    }
  }
}

logIncKillChain() {
  self.pers["killChains"]++;
  self maps\mp\gametypes\_persistence::statSetChild("round", "killChains", self.pers["killChains"]);
}

perkWatcher() {
  if(GetDvarInt("scr_game_perks")) {
    switch (self.adrenaline) {
      case 2:
        self givePerk("specialty_fastsprintrecovery", false);
        self thread maps\mp\gametypes\_hud_message::splashNotify("specialty_fastsprintrecovery_sotf", self.adrenaline);
        self thread logIncKillChain();
        break;
      case 3:
        self givePerk("specialty_lightweight", false);
        self thread maps\mp\gametypes\_hud_message::splashNotify("specialty_lightweight_sotf", self.adrenaline);
        self thread logIncKillChain();
        break;
      case 4:
        self givePerk("specialty_stalker", false);
        self thread maps\mp\gametypes\_hud_message::splashNotify("specialty_stalker_sotf", self.adrenaline);
        self thread logIncKillChain();
        break;
      case 5:
        self givePerk("specialty_regenfaster", false);
        self thread maps\mp\gametypes\_hud_message::splashNotify("specialty_regenfaster_sotf", self.adrenaline);
        self thread logIncKillChain();
        break;
      case 6:
        self givePerk("specialty_deadeye", false);
        self thread maps\mp\gametypes\_hud_message::splashNotify("specialty_deadeye_sotf", self.adrenaline);
        self thread logIncKillChain();
        break;
    }
  }
}

iconVisAll(crate, icon) {
  foreach(player in level.players) {
    crate maps\mp\_entityheadIcons::setHeadIcon(player, icon, (0, 0, 24), 14, 14, undefined, undefined, undefined, undefined, undefined, false);
    self.crateHeadIcon = icon;
  }
}

objVisAll(objID) {
  Objective_PlayerMask_ShowToAll(objID);
}

setBucketVal(weaponArray) {
  level.weaponMaxVal["sum"] = 0;

  modWeaponArray = weaponArray;

  for(i = 0; i < modWeaponArray.size; i++) {
    if(!modWeaponArray[i]["weight"]) {
      continue;
    }
    level.weaponMaxVal["sum"] += modWeaponArray[i]["weight"];
    modWeaponArray[i]["weight"] = level.weaponMaxVal["sum"];
  }

  return modWeaponArray;
}

sortByWeight(weaponArray) {
  nextWeapon = [];
  prevWeapon = [];

  for(nextIndex = 1; nextIndex < weaponArray.size; nextIndex++) {
    nextWeight = weaponArray[nextIndex]["weight"];
    nextWeapon = weaponArray[nextIndex];

    for(prevIndex = nextIndex - 1;
      (prevIndex >= 0) && is_weight_a_less_than_b(weaponArray[prevIndex]["weight"], nextWeight); prevIndex--) {
      prevWeapon = weaponArray[prevIndex];

      weaponArray[prevIndex] = nextWeapon;
      weaponArray[prevIndex + 1] = prevWeapon;
    }
  }

  return weaponArray;
}

is_weight_a_less_than_b(a, b) {
  return (a < b);
}