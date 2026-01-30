/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_class.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
  level.classMap["class0"] = 0;
  level.classMap["class1"] = 1;
  level.classMap["class2"] = 2;
  level.classMap["class3"] = 3;
  level.classMap["class4"] = 4;
  level.classMap["class5"] = 5;
  level.classMap["class6"] = 6;
  level.classMap["class7"] = 7;
  level.classMap["class8"] = 8;
  level.classMap["class9"] = 9;
  level.classMap["class10"] = 10;
  level.classMap["class11"] = 11;
  level.classMap["class12"] = 12;
  level.classMap["class13"] = 13;
  level.classMap["class14"] = 14;

  level.classMap["custom1"] = 0;
  level.classMap["custom2"] = 1;
  level.classMap["custom3"] = 2;
  level.classMap["custom4"] = 3;
  level.classMap["custom5"] = 4;
  level.classMap["custom6"] = 5;
  level.classMap["custom7"] = 6;
  level.classMap["custom8"] = 7;
  level.classMap["custom9"] = 8;
  level.classMap["custom10"] = 9;
  level.classMap["custom11"] = 10;
  level.classMap["custom12"] = 11;
  level.classMap["custom13"] = 12;
  level.classMap["custom14"] = 13;
  level.classMap["custom15"] = 14;

  level.classMap["practice1"] = 0;
  level.classMap["practice2"] = 1;
  level.classMap["practice3"] = 2;
  level.classMap["practice4"] = 3;
  level.classMap["practice5"] = 4;
  level.classMap["practice6"] = 5;
  level.classMap["practice7"] = 6;
  level.classMap["practice8"] = 7;
  level.classMap["practice9"] = 8;
  level.classMap["practice10"] = 9;

  level.classMap["lobby1"] = 0;
  level.classMap["lobby2"] = 1;
  level.classMap["lobby3"] = 2;
  level.classMap["lobby4"] = 3;
  level.classMap["lobby5"] = 4;
  level.classMap["lobby6"] = 5;
  level.classMap["lobby7"] = 6;
  level.classMap["lobby8"] = 7;
  level.classMap["lobby9"] = 8;
  level.classMap["lobby10"] = 9;
  level.classMap["lobby11"] = 10;
  level.classMap["lobby12"] = 11;
  level.classMap["lobby13"] = 12;
  level.classMap["lobby14"] = 13;
  level.classMap["lobby15"] = 14;

  level.classMap["axis_recipe1"] = 0;
  level.classMap["axis_recipe2"] = 1;
  level.classMap["axis_recipe3"] = 2;
  level.classMap["axis_recipe4"] = 3;
  level.classMap["axis_recipe5"] = 4;
  level.classMap["axis_recipe6"] = 5;

  level.classMap["allies_recipe1"] = 0;
  level.classMap["allies_recipe2"] = 1;
  level.classMap["allies_recipe3"] = 2;
  level.classMap["allies_recipe4"] = 3;
  level.classMap["allies_recipe5"] = 4;
  level.classMap["allies_recipe6"] = 5;

  level.classMap["copycat"] = -1;

  level.classMap["gamemode"] = 0;

  level.classMap["callback"] = 0;

  level.botClasses = [];
  level.botClasses[0] = "class0";
  level.botClasses[1] = "class0";
  level.botClasses[2] = "class0";
  level.botClasses[3] = "class0";
  level.botClasses[4] = "class0";

  level.defaultClass = "CLASS_ASSAULT";

  level.classTableName = "mp/classTable.csv";
  level.practiceRoundClassTableName = "mp/practiceRoundClassTable.csv";
  level.practiceRoundCostumeTableName = "mp/practiceRoundCostumeTable.csv";
  level.agentCostumeTableName = "mp/agentCostumeTable.csv";
  level.hardcoreCostumeTableName = "mp/hardcoreCostumeTable.csv";

  level.classPickCount = 13;
  if(!isDefined(level.customClassPickCount)) {
    level.customClassPickCount = 13;
  }

  level thread onPlayerConnecting();
}

getEmptyLoadout() {
  emptyLoadout = [];

  emptyLoadout["loadoutPrimary"] = "iw5_combatknife";
  emptyLoadout["loadoutPrimaryAttachment"] = "none";
  emptyLoadout["loadoutPrimaryAttachment2"] = "none";
  emptyLoadout["loadoutPrimaryAttachment3"] = "none";
  emptyLoadout["loadoutPrimaryCamo"] = "none";
  emptyLoadout["loadoutPrimaryReticle"] = "none";

  emptyLoadout["loadoutSecondary"] = "none";
  emptyLoadout["loadoutSecondaryAttachment"] = "none";
  emptyLoadout["loadoutSecondaryAttachment2"] = "none";
  emptyLoadout["loadoutSecondaryAttachment3"] = "none";
  emptyLoadout["loadoutSecondaryCamo"] = "none";
  emptyLoadout["loadoutSecondaryReticle"] = "none";

  emptyLoadout["loadoutEquipment"] = "specialty_null";
  emptyLoadout["loadoutEquipmentExtra"] = false;
  emptyLoadout["loadoutOffhand"] = "none";
  emptyLoadout["loadoutOffhandExtra"] = false;

  emptyLoadout["loadoutKillstreaks"][0] = "none";
  emptyLoadout["loadoutKillstreaks"][1] = "none";
  emptyLoadout["loadoutKillstreaks"][2] = "none";
  emptyLoadout["loadoutKillstreaks"][3] = "none";
  emptyLoadout["loadoutKillstreakModules"][0][0] = "none";
  emptyLoadout["loadoutKillstreakModules"][0][1] = "none";
  emptyLoadout["loadoutKillstreakModules"][0][2] = "none";
  emptyLoadout["loadoutKillstreakModules"][1][0] = "none";
  emptyLoadout["loadoutKillstreakModules"][1][1] = "none";
  emptyLoadout["loadoutKillstreakModules"][1][2] = "none";
  emptyLoadout["loadoutKillstreakModules"][2][0] = "none";
  emptyLoadout["loadoutKillstreakModules"][2][1] = "none";
  emptyLoadout["loadoutKillstreakModules"][2][2] = "none";
  emptyLoadout["loadoutKillstreakModules"][3][0] = "none";
  emptyLoadout["loadoutKillstreakModules"][3][1] = "none";
  emptyLoadout["loadoutKillstreakModules"][3][2] = "none";

  emptyLoadout["loadoutPerks"] = maps\mp\perks\_perks::getEmptyPerks();
  emptyLoadout["loadoutWildcards"] = ["specialty_null", "specialty_null", "specialty_null"];

  emptyLoadout["loadoutJuggernaut"] = false;

  return emptyLoadout;
}

getClassChoice(response) {
  assert(isDefined(level.classMap[response]));

  return response;
}

getWeaponChoice(response) {
  tokens = strtok(response, ",");
  if(tokens.size > 1) {
    return int(tokens[1]);
  } else {
    return 0;
  }
}

logClassChoice(class, primaryWeapon, specialType, perks) {
  if(class == self.lastClass) {
    return;
  }

  self logstring("choseclass: " + class + " weapon: " + primaryWeapon + " special: " + specialType);
  for(i = 0; i < perks.size; i++) {
    self logstring("perk" + i + ": " + perks[i]);
  }

  self.lastClass = class;
}

cac_getWeapon(classIndex, weaponIndex) {
  if(isDefined(level.forceCustomClassLoc)) {
    return self getCaCPlayerDataForGroup(level.forceCustomClassLoc, classIndex, "weaponSetups", weaponIndex, "weapon");
  } else {
    return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "weapon");
  }
}

cac_getWeaponAttachment(classIndex, weaponIndex) {
  if(isDefined(level.forceCustomClassLoc)) {
    return self getCaCPlayerDataForGroup(level.forceCustomClassLoc, classIndex, "weaponSetups", weaponIndex, "attachment", 0);
  } else {
    return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "attachment", 0);
  }
}

cac_getWeaponAttachmentTwo(classIndex, weaponIndex) {
  if(isDefined(level.forceCustomClassLoc)) {
    return self getCaCPlayerDataForGroup(level.forceCustomClassLoc, classIndex, "weaponSetups", weaponIndex, "attachment", 1);
  } else {
    return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "attachment", 1);
  }
}

cac_getWeaponAttachmentThree(classIndex, weaponIndex) {
  if(isDefined(level.forceCustomClassLoc)) {
    return self getCaCPlayerDataForGroup(level.forceCustomClassLoc, classIndex, "weaponSetups", weaponIndex, "attachment", 2);
  } else {
    return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "attachment", 2);
  }
}

cac_getWeaponCamo(classIndex, weaponIndex) {
  if(isDefined(level.forceCustomClassLoc)) {
    return self getCaCPlayerDataForGroup(level.forceCustomClassLoc, classIndex, "weaponSetups", weaponIndex, "camo");
  } else {
    return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "camo");
  }
}

cac_getWeaponReticle(classIndex, weaponIndex) {
  if(isDefined(level.forceCustomClassLoc)) {
    return self getCaCPlayerDataForGroup(level.forceCustomClassLoc, classIndex, "weaponSetups", weaponIndex, "reticle");
  } else {
    return self getCaCPlayerData(classIndex, "weaponSetups", weaponIndex, "reticle");
  }
}

cac_getPerk(classIndex, perkIndex) {
  return self getCaCPlayerData(classIndex, "perkSlots", perkIndex);
}

cac_getWildcard(classIndex, wildcardIndex) {
  return self getCacPlayerData(classIndex, "wildcardSlots", wildcardIndex);
}

cac_getKillstreak(class_num, streakIndex) {
  return self getCaCPlayerData(class_num, "assaultStreaks", streakIndex, "streak");
}

cac_getKillstreakModule(class_num, streakIndex, moduleIndex) {
  return self getCaCPlayerData(class_num, "assaultStreaks", streakIndex, "modules", moduleIndex);
}

cac_getEquipment(classIndex, equipmentIndex) {
  return self getCaCPlayerData(classIndex, "equipmentSetups", equipmentIndex, "equipment");
}

cac_getEquipmentExtra(classIndex, equipmentIndex) {
  return self getCaCPlayerData(classIndex, "equipmentSetups", equipmentIndex, "extra");
}

cac_getOffhand(classIndex) {
  return self cac_getEquipment(classIndex, 1);
}

cao_isGlobalCostumeCategory(category) {
  return category == "gender" || category == "head";
}

cao_getGlobalCostumeCategory(category) {
  return self GetCommonPlayerData("globalCostume", category);
}

cao_getPerCostumeCategory(category, costumeIndex) {
  return self GetCommonPlayerData("costumes", costumeIndex, category);
}

cao_setGlobalCostumeCategory(category, value) {
  return self SetCommonPlayerData("globalCostume", category, value);
}

cao_setPerCostumeCategory(category, value, costumeIndex) {
  return self SetCommonPlayerData("costumes", costumeIndex, category, value);
}

cao_getActiveCostumeIndex() {
  return self GetCommonPlayerData("activeCostume");
}

cao_getCostumeByIndex(costumeIndex) {
  costume = [];
  for(i = 0; i < level.costumeCategories.size; i++) {
    category = level.costumeCategories[i];
    if(cao_isGlobalCostumeCategory(category)) {
      costume[i] = cao_getGlobalCostumeCategory(category);
    } else {
      costume[i] = cao_getPerCostumeCategory(category, costumeIndex);
    }
  }

  return costume;
}

cao_getActiveCostume() {
  costumeIndex = cao_getActiveCostumeIndex();
  return cao_getCostumeByIndex(costumeIndex);
}

cao_setCostumeByIndex(costume, costumeIndex) {
  costume = ValidateCostume(costume);

  for(i = 0; i < level.costumeCategories.size; i++) {
    category = level.costumeCategories[i];
    if(cao_isGlobalCostumeCategory(category)) {
      cao_setGlobalCostumeCategory(category, costume[i]);
    } else {
      cao_setPerCostumeCategory(category, costume[i], costumeIndex);
    }
  }
}

cao_setActiveCostume(costume) {
  costumeIndex = cao_getActiveCostumeIndex();
  cao_setCostumeByIndex(costume, costumeIndex);
}

table_getWeapon(tableName, classIndex, weaponIndex) {
  if(weaponIndex == 0) {
    return tableLookup(tableName, 0, "loadoutPrimary", classIndex + 1);
  } else {
    return tableLookup(tableName, 0, "loadoutSecondary", classIndex + 1);
  }
}

table_getWeaponAttachment(tableName, classIndex, weaponIndex, attachmentIndex) {
  tempName = "none";

  str = "loadoutPrimaryAttachment";
  if(weaponIndex) {
    str = "loadoutSecondaryAttachment";
  }

  if(!isDefined(attachmentIndex)) {
    attachmentIndex = 0;
  }

  switch (attachmentIndex) {
    case 0:
      break;
    case 1:
      str += "2";
      break;
    case 2:
      str += "3";
      break;
    default:
      AssertMsg("unhandled attachment index in default classes ");
  };

  tempName = TableLookup(tableName, 0, str, classIndex + 1);

  if(tempName == "" || tempName == "none") {
    return "none";
  } else {
    return tempName;
  }

}

table_getWeaponBuff(tableName, classIndex, weaponIndex) {
  if(weaponIndex == 0) {
    return TableLookup(tableName, 0, "loadoutPrimaryBuff", classIndex + 1);
  } else {
    return TableLookup(tableName, 0, "loadoutSecondaryBuff", classIndex + 1);
  }
}

table_getWeaponCamo(tableName, classIndex, weaponIndex) {
  if(weaponIndex == 0) {
    return tableLookup(tableName, 0, "loadoutPrimaryCamo", classIndex + 1);
  } else {
    return tableLookup(tableName, 0, "loadoutSecondaryCamo", classIndex + 1);
  }
}

table_getWeaponReticle(tableName, classIndex, weaponIndex) {
  if(weaponIndex == 0) {
    return tableLookup(tableName, 0, "loadoutPrimaryReticle", classIndex + 1);
  } else {
    return tableLookup(tableName, 0, "loadoutSecondaryReticle", classIndex + 1);
  }
}

table_getPerk(tableName, classIndex, perkIndex) {
  assert(perkIndex <= 6);
  perkIndex++;
  field = "loadoutPerk" + perkIndex;
  return tableLookup(tableName, 0, field, classIndex + 1);
}

table_getWildcard(tableName, classIndex, wildcardIndex) {
  assert(wildcardIndex <= 3);
  wildcardIndex++;
  field = "loadoutWildcard" + wildcardIndex;
  return tableLookup(tableName, 0, field, classIndex + 1);
}

table_getEquipment(tableName, classIndex) {
  return tableLookup(tableName, 0, "loadoutEquipment", classIndex + 1);
}

table_getEquipmentExtra(tableName, classIndex) {
  stringVal = tableLookup(tableName, 0, "loadoutEquipment2", classIndex + 1);
  return (stringVal != "") && (stringVal != "specialty_null");
}

table_getTeamPerk(tableName, classIndex) {
  return tableLookup(tableName, 0, "loadoutTeamPerk", classIndex + 1);
}

table_getOffhand(tableName, classIndex) {
  return tableLookup(tableName, 0, "loadoutOffhand", classIndex + 1);
}

table_getOffhandExtra(tableName, classIndex) {
  stringVal = tableLookup(tableName, 0, "loadoutOffhand2", classIndex + 1);
  return (stringVal != "") && (stringVal != "specialty_null");
}

table_getKillstreak(tableName, classIndex, streakIndex) {
  return tableLookup(tableName, 0, "loadoutStreak" + (streakIndex + 1), (classIndex + 1));
}

table_getKillstreakModule(tableName, classIndex, streakIndex, moduleIndex) {
  switch (moduleIndex) {
    case 0:
      return tableLookup(tableName, 0, "loadoutStreakModule" + (streakIndex + 1) + "a", classIndex + 1);
    case 1:
      return tableLookup(tableName, 0, "loadoutStreakModule" + (streakIndex + 1) + "b", classIndex + 1);
    case 2:
      return tableLookup(tableName, 0, "loadoutStreakModule" + (streakIndex + 1) + "c", classIndex + 1);
    default:
      AssertMsg("unhandled module index in table_getKillstreakModule");
  }
}

cloneLoadout() {
  teamName = "none";

  class = self.curClass;

  callbackFunc = self.classCallback;

  practiceClassNum = undefined;

  if(class == "copycat") {
    class = self.pers["copyCatLoadout"]["className"];
    practiceClassNum = self.pers["copyCatLoadout"]["practiceClassNum"];
    if(class == "callback") {
      callbackFunc = self.pers["copyCatLoadout"]["classCallbackFunc"];
    }
  }

  if(isSubstr(class, "axis")) {
    teamName = "axis";
  } else if(isSubstr(class, "allies")) {
    teamName = "allies";
  }

  loadoutPerks = [];
  loadoutWildcards = [];
  loadoutKillstreaks = [];
  loadoutKillstreakModules = [];

  if(teamName != "none") {
    classIndex = getClassIndex(class);

    loadoutPrimary = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "weapon");
    loadoutPrimaryAttachment = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "attachment", 0);
    loadoutPrimaryAttachment2 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "attachment", 1);
    loadoutPrimaryAttachment3 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "attachment", 2);
    loadoutPrimaryCamo = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "camo");
    loadoutPrimaryReticle = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "reticle");

    loadoutSecondary = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "weapon");
    loadoutSecondaryAttachment = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "attachment", 0);
    loadoutSecondaryAttachment2 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "attachment", 1);
    loadoutSecondaryAttachment3 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "attachment", 2);
    loadoutSecondaryCamo = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "camo");
    loadoutSecondaryReticle = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "reticle");

    loadoutEquipment = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 0, "equipment");
    loadoutEquipmentExtra = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 0, "extra");
    loadoutOffhand = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 1, "equipment");
    loadoutOffhandExtra = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 1, "extra");

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "perkSlots", i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "wildcardSlots", i);
    }

    for(i = 0; i < 4; i++) {
      loadoutKillstreaks[i] = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "assaultStreaks", i, "streak");
      loadoutKillstreakModules[i] = [];
      for(j = 0; j < 3; j++) {
        loadoutKillstreakModules[i][j] = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "assaultStreaks", i, "modules", j);
      }
    }
  } else if(isSubstr(class, "custom")) {
    class_num = getClassIndex(class);

    loadoutPrimary = cac_getWeapon(class_num, 0);
    loadoutPrimaryAttachment = cac_getWeaponAttachment(class_num, 0);
    loadoutPrimaryAttachment2 = cac_getWeaponAttachmentTwo(class_num, 0);
    loadoutPrimaryAttachment3 = cac_getWeaponAttachmentThree(class_num, 0);
    loadoutPrimaryCamo = cac_getWeaponCamo(class_num, 0);
    loadoutPrimaryReticle = cac_getWeaponReticle(class_num, 0);

    loadoutSecondary = cac_getWeapon(class_num, 1);
    loadoutSecondaryAttachment = cac_getWeaponAttachment(class_num, 1);
    loadoutSecondaryAttachment2 = cac_getWeaponAttachmentTwo(class_num, 1);
    loadoutSecondaryAttachment3 = cac_getWeaponAttachmentThree(class_num, 1);
    loadoutSecondaryCamo = cac_getWeaponCamo(class_num, 1);
    loadoutSecondaryReticle = cac_getWeaponReticle(class_num, 1);

    loadoutEquipment = cac_getEquipment(class_num, 0);
    loadoutEquipmentExtra = cac_getEquipmentExtra(class_num, 0);
    loadoutOffhand = cac_getEquipment(class_num, 1);
    loadoutOffhandExtra = cac_getEquipmentExtra(class_num, 1);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = cac_getPerk(class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = cac_getWildcard(class_num, i);
    }

    for(i = 0; i < 4; i++) {
      loadoutKillstreaks[i] = cac_getKillstreak(class_num, i);
      loadoutKillstreakModules[i] = [];
      for(j = 0; j < 3; j++) {
        loadoutKillstreakModules[i][j] = cac_getKillstreakModule(class_num, i, j);
      }
    }
  } else if(practiceRoundGame() && isSubstr(class, "practice")) {
    class_num = getClassIndex(class);

    if(isDefined(practiceClassNum)) {
      class_num = practiceClassNum;
    } else {
      class_num = self.pers["practiceRoundClasses"][class_num];
      practiceClassNum = class_num;
    }

    loadoutPrimary = table_getWeapon(level.practiceRoundClassTableName, class_num, 0);
    loadoutPrimaryAttachment = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 0);
    loadoutPrimaryAttachment2 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 1);
    loadoutPrimaryAttachment3 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 2);
    loadoutPrimaryCamo = table_getWeaponCamo(level.practiceRoundClassTableName, class_num, 0);
    loadoutPrimaryReticle = table_getWeaponReticle(level.practiceRoundClassTableName, class_num, 0);

    loadoutSecondary = table_getWeapon(level.practiceRoundClassTableName, class_num, 1);
    loadoutSecondaryAttachment = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 0);
    loadoutSecondaryAttachment2 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 1);
    loadoutSecondaryAttachment3 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 2);
    loadoutSecondaryCamo = table_getWeaponCamo(level.practiceRoundClassTableName, class_num, 1);
    loadoutSecondaryReticle = table_getWeaponReticle(level.practiceRoundClassTableName, class_num, 1);

    loadoutEquipment = table_getEquipment(level.practiceRoundClassTableName, class_num);
    loadoutEquipmentExtra = table_getEquipmentExtra(level.practiceRoundClassTableName, class_num);
    loadoutOffhand = table_getOffhand(level.practiceRoundClassTableName, class_num);
    loadoutOffhandExtra = table_getOffhandExtra(level.practiceRoundClassTableName, class_num);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = table_getPerk(level.practiceRoundClassTableName, class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = table_getWildcard(level.practiceRoundClassTableName, class_num, i);
    }

    for(i = 0; i < 4; i++) {
      loadoutKillstreaks[i] = table_getKillstreak(level.practiceRoundClassTableName, class_num, i);
      loadoutKillstreakModules[i] = [];
      for(j = 0; j < 3; j++) {
        loadoutKillstreakModules[i][j] = table_getKillstreakModule(level.practiceRoundClassTableName, class_num, i, j);
      }
    }
  } else if(class == "callback") {
    if(!isDefined(callbackFunc)) {
      error("self.classCallback function reference required for class 'callback'");
    }

    callbackLoadout = [[callbackFunc]](true);
    if(!isDefined(callbackLoadout)) {
      error("array required from self.classCallback for class 'callback'");
    }

    loadoutPrimary = callbackLoadout["loadoutPrimary"];
    loadoutPrimaryAttachment = callbackLoadout["loadoutPrimaryAttachment"];
    loadoutPrimaryAttachment2 = callbackLoadout["loadoutPrimaryAttachment2"];
    loadoutPrimaryAttachment3 = callbackLoadout["loadoutPrimaryAttachment3"];
    loadoutPrimaryCamo = callbackLoadout["loadoutPrimaryCamo"];
    loadoutPrimaryReticle = callbackLoadout["loadoutPrimaryReticle"];

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = callbackLoadout["loadoutPerk" + (i + 1)];
    }
    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = callbackLoadout["loadoutWildcard" + (i + 1)];
    }
    loadoutSecondary = callbackLoadout["loadoutSecondary"];
    loadoutSecondaryAttachment = callbackLoadout["loadoutSecondaryAttachment"];
    loadoutSecondaryAttachment2 = callbackLoadout["loadoutSecondaryAttachment2"];
    loadoutSecondaryAttachment3 = callbackLoadout["loadoutSecondaryAttachment3"];
    loadoutSecondaryCamo = callbackLoadout["loadoutSecondaryCamo"];
    loadoutSecondaryReticle = callbackLoadout["loadoutSecondaryReticle"];
    loadoutEquipment = callbackLoadout["loadoutEquipment"];
    loadoutEquipmentExtra = (callbackLoadout["loadoutEquipment2"] != "specialty_null");
    loadoutOffhand = callbackLoadout["loadoutOffhand"];
    loadoutOffhandExtra = (callbackLoadout["loadoutOffhand2"] != "specialty_null");

    for(i = 0; i < 4; i++) {
      loadoutKillstreaks[i] = callbackLoadout["loadoutStreak" + (i + 1)];
      loadoutKillstreakModules[i] = [];
      for(j = 0; j < 3; j++) {
        loadoutKillstreakModules[i][j] = callbackLoadout["loadoutStreakModule" + (i + 1) + (j + 1)];
      }
    }
  } else {
    class_num = getClassIndex(class);

    loadoutPrimary = table_getWeapon(level.classTableName, class_num, 0);
    loadoutPrimaryAttachment = table_getWeaponAttachment(level.classTableName, class_num, 0, 0);
    loadoutPrimaryAttachment2 = table_getWeaponAttachment(level.classTableName, class_num, 0, 1);
    loadoutPrimaryAttachment3 = table_getWeaponAttachment(level.classTableName, class_num, 0, 2);
    loadoutPrimaryCamo = table_getWeaponCamo(level.classTableName, class_num, 0);
    loadoutPrimaryReticle = table_getWeaponReticle(level.classTableName, class_num, 0);

    loadoutSecondary = table_getWeapon(level.classTableName, class_num, 1);
    loadoutSecondaryAttachment = table_getWeaponAttachment(level.classTableName, class_num, 1, 0);
    loadoutSecondaryAttachment2 = table_getWeaponAttachment(level.classTableName, class_num, 1, 1);
    loadoutSecondaryAttachment3 = table_getWeaponAttachment(level.classTableName, class_num, 1, 2);
    loadoutSecondaryCamo = table_getWeaponCamo(level.classTableName, class_num, 1);
    loadoutSecondaryReticle = table_getWeaponReticle(level.classTableName, class_num, 1);

    loadoutEquipment = table_getEquipment(level.classTableName, class_num);
    loadoutEquipmentExtra = table_getEquipmentExtra(level.classTableName, class_num);
    loadoutOffhand = table_getOffhand(level.classTableName, class_num);
    loadoutOffhandExtra = table_getOffhandExtra(level.classTableName, class_num);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = table_getPerk(level.classTableName, class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = table_getWildcard(level.classTableName, class_num, i);
    }

    for(i = 0; i < 4; i++) {
      loadoutKillstreaks[i] = table_getKillstreak(level.classTableName, class_num, i);
      loadoutKillstreakModules[i] = [];
      for(j = 0; j < 3; j++) {
        loadoutKillstreakModules[i][j] = table_getKillstreakModule(level.classTableName, class_num, i, j);
      }
    }
  }

  clonedLoadout = [];
  clonedLoadout["inUse"] = false;
  clonedLoadout["className"] = class;

  if(isDefined(practiceClassNum)) {
    clonedLoadout["practiceClassNum"] = practiceClassNum;
  }

  if(class == "callback" && isDefined(callbackFunc)) {
    clonedLoadout["classCallbackFunc"] = callbackFunc;
  }

  clonedLoadout["loadoutPrimary"] = loadoutPrimary;
  clonedLoadout["loadoutPrimaryAttachment"] = loadoutPrimaryAttachment;
  clonedLoadout["loadoutPrimaryAttachment2"] = loadoutPrimaryAttachment2;
  clonedLoadout["loadoutPrimaryAttachment3"] = loadoutPrimaryAttachment3;
  clonedLoadout["loadoutPrimaryCamo"] = loadoutPrimaryCamo;
  clonedLoadout["loadoutPrimaryReticle"] = loadoutPrimaryReticle;

  clonedLoadout["loadoutSecondary"] = loadoutSecondary;
  clonedLoadout["loadoutSecondaryAttachment"] = loadoutSecondaryAttachment;
  clonedLoadout["loadoutSecondaryAttachment2"] = loadoutSecondaryAttachment2;
  clonedLoadout["loadoutSecondaryAttachment3"] = loadoutSecondaryAttachment3;
  clonedLoadout["loadoutSecondaryCamo"] = loadoutSecondaryCamo;
  clonedLoadout["loadoutSecondaryReticle"] = loadoutSecondaryReticle;

  clonedLoadout["loadoutEquipment"] = loadoutEquipment;
  clonedLoadout["loadoutEquipmentExtra"] = loadoutEquipmentExtra;
  clonedLoadout["loadoutOffhand"] = loadoutOffhand;
  clonedLoadout["loadoutOffhandExtra"] = loadoutOffhandExtra;

  for(i = 0; i < 6; i++) {
    clonedLoadout["loadoutPerks"][i] = loadoutPerks[i];
  }

  for(i = 0; i < 3; i++) {
    clonedLoadout["loadoutWildcards"][i] = loadoutWildcards[i];
  }

  for(i = 0; i < 4; i++) {
    clonedLoadout["loadoutKillstreaks"][i] = loadoutKillstreaks[i];
    for(j = 0; j < 3; j++) {
      clonedLoadout["loadoutKillstreakModules"][i][j] = loadoutKillstreakModules[i][j];
    }
  }

  return (clonedLoadout);
}

getLoadout(team, class, allowCopycat, setPrimarySpawnWeapon) {
  if(!isDefined(setPrimarySpawnWeapon)) {
    setPrimarySpawnWeapon = true;
  }

  if(!isDefined(allowCopycat)) {
    allowCopycat = true;
  }

  clearAmmo = false;
  class_num = undefined;

  loadoutKillstreak1 = undefined;
  loadoutKillstreak2 = undefined;
  loadoutKillstreak3 = undefined;
  loadoutKillstreak4 = undefined;
  keepCurrentKillstreaks = false;
  playerData = undefined;

  loadoutJuggernaut = undefined;

  cacLoadout = IsSubStr(class, "custom");
  practiceLoadout = practiceRoundGame() && IsSubStr(class, "practice");
  copycatLoadout = false;

  loadoutPerks = [];
  loadoutWildcards = [];
  loadoutWildcards[0] = "specialty_null";
  loadoutWildcards[1] = "specialty_null";
  loadoutWildcards[2] = "specialty_null";
  loadoutKillstreakModules = undefined;
  maxPickCount = level.classPickCount;

  isGameModeClass = (class == "gamemode");

  if(isSubstr(class, "axis")) {
    teamName = "axis";
  } else if(isSubstr(class, "allies")) {
    teamName = "allies";
  } else {
    teamName = "none";
  }

  clonedLoadout = [];
  if(isDefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && allowCopycat) {
    copycatLoadout = true;
    cacLoadout = false;
    practiceLoadout = false;

    class_num = getClassIndex("copycat");

    clonedLoadout = self.pers["copyCatLoadout"];

    loadoutPrimary = clonedLoadout["loadoutPrimary"];
    loadoutPrimaryAttachment = clonedLoadout["loadoutPrimaryAttachment"];
    loadoutPrimaryAttachment2 = clonedLoadout["loadoutPrimaryAttachment2"];
    loadoutPrimaryAttachment3 = clonedLoadout["loadoutPrimaryAttachment3"];
    loadoutPrimaryCamo = clonedLoadout["loadoutPrimaryCamo"];
    loadoutPrimaryReticle = clonedLoadout["loadoutPrimaryReticle"];

    loadoutSecondary = clonedLoadout["loadoutSecondary"];
    loadoutSecondaryAttachment = clonedLoadout["loadoutSecondaryAttachment"];
    loadoutSecondaryAttachment2 = clonedLoadout["loadoutSecondaryAttachment2"];
    loadoutSecondaryAttachment3 = clonedLoadout["loadoutSecondaryAttachment3"];
    loadoutSecondaryCamo = clonedLoadout["loadoutSecondaryCamo"];
    loadoutSecondaryReticle = clonedLoadout["loadoutSecondaryReticle"];

    loadoutEquipment = clonedLoadout["loadoutEquipment"];
    loadoutEquipmentExtra = clonedLoadout["loadoutEquipmentExtra"];
    loadoutOffhand = clonedLoadout["loadoutOffhand"];
    loadoutOffhandExtra = clonedLoadout["loadoutOffhandExtra"];

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = clonedLoadout["loadoutPerks"][i];
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = clonedLoadout["loadoutWildcards"][i];
    }

    loadoutKillstreak1 = clonedLoadout["loadoutKillstreaks"][0];
    loadoutKillstreak2 = clonedLoadout["loadoutKillstreaks"][1];
    loadoutKillstreak3 = clonedLoadout["loadoutKillstreaks"][2];
    loadoutKillstreak4 = clonedLoadout["loadoutKillstreaks"][3];
  } else if(teamName != "none") {
    classIndex = getClassIndex(class);
    class_num = classIndex;
    self.class_num = classIndex;
    self.teamName = teamName;
    maxPickCount = 20;

    loadoutPrimary = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "weapon");
    if(loadoutPrimary == "none") {
      loadoutPrimary = "iw5_combatknife";
      loadoutPrimaryAttachment = "none";
      loadoutPrimaryAttachment2 = "none";
      loadoutPrimaryAttachment3 = "none";
    } else {
      loadoutPrimaryAttachment = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "attachment", 0);
      loadoutPrimaryAttachment2 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "attachment", 1);
      loadoutPrimaryAttachment3 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "attachment", 2);
    }
    loadoutPrimaryCamo = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "camo");
    loadoutPrimaryReticle = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 0, "reticle");

    loadoutSecondary = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "weapon");
    loadoutSecondaryAttachment = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "attachment", 0);
    loadoutSecondaryAttachment2 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "attachment", 1);
    loadoutSecondaryAttachment3 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "attachment", 2);
    loadoutSecondaryCamo = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "camo");
    loadoutSecondaryReticle = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "weaponSetups", 1, "reticle");

    loadoutEquipment = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 0, "equipment");
    loadoutEquipmentExtra = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 0, "extra");
    loadoutOffhand = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 1, "equipment");
    loadoutOffhandExtra = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "equipmentSetups", 1, "extra");

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "perkSlots", i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "wildcardSlots", i);
    }

    loadoutKillstreak1 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "assaultStreaks", 0, "streak");
    loadoutKillstreak2 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "assaultStreaks", 1, "streak");
    loadoutKillstreak3 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "assaultStreaks", 2, "streak");
    loadoutKillstreak4 = getMatchRulesData("defaultClasses", teamName, classIndex, "class", "assaultStreaks", 3, "streak");

    if(((loadoutPrimary == "throwingknife") || (loadoutPrimary == "none")) && loadoutSecondary != "none") {
      loadoutPrimary = loadoutSecondary;
      loadoutPrimaryAttachment = loadoutSecondaryAttachment;
      loadoutPrimaryAttachment2 = loadoutSecondaryAttachment2;
      loadoutPrimaryAttachment3 = loadoutSecondaryAttachment3;
      loadoutPrimaryCamo = loadoutSecondaryCamo;
      loadoutPrimaryReticle = loadoutSecondaryReticle;

      loadoutSecondary = "none";
      loadoutSecondaryAttachment = "none";
      loadoutSecondaryAttachment2 = "none";
      loadoutSecondaryAttachment3 = "none";
      loadoutSecondaryCamo = "none";
      loadoutSecondaryReticle = "none";
    } else if(((loadoutPrimary == "throwingknife") || (loadoutPrimary == "none")) && loadoutSecondary == "none") {
      clearAmmo = true;
      loadoutPrimary = "iw5_usp45";
      loadoutPrimaryAttachment = "tactical";
    }

    loadoutJuggernaut = getMatchRulesData("defaultClasses", teamName, classIndex, "juggernaut");
  } else if(isSubstr(class, "custom")) {
    class_num = getClassIndex(class);
    maxPickCount = level.customClassPickCount;

    loadoutPrimary = cac_getWeapon(class_num, 0);
    loadoutPrimaryAttachment = cac_getWeaponAttachment(class_num, 0);
    loadoutPrimaryAttachment2 = cac_getWeaponAttachmentTwo(class_num, 0);
    loadoutPrimaryAttachment3 = cac_getWeaponAttachmentThree(class_num, 0);
    loadoutPrimaryCamo = cac_getWeaponCamo(class_num, 0);
    loadoutPrimaryReticle = cac_getWeaponReticle(class_num, 0);

    loadoutSecondary = cac_getWeapon(class_num, 1);
    loadoutSecondaryAttachment = cac_getWeaponAttachment(class_num, 1);
    loadoutSecondaryAttachment2 = cac_getWeaponAttachmentTwo(class_num, 1);
    loadoutSecondaryAttachment3 = cac_getWeaponAttachmentThree(class_num, 1);
    loadoutSecondaryCamo = cac_getWeaponCamo(class_num, 1);
    loadoutSecondaryReticle = cac_getWeaponReticle(class_num, 1);

    loadoutEquipment = cac_getEquipment(class_num, 0);
    loadoutEquipmentExtra = cac_getEquipmentExtra(class_num, 0);
    loadoutOffhand = cac_getEquipment(class_num, 1);
    loadoutOffhandExtra = cac_getEquipmentExtra(class_num, 1);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = cac_getPerk(class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = cac_getWildcard(class_num, i);
    }

    loadoutKillstreak1 = cac_getKillstreak(class_num, 0);
    loadoutKillstreak2 = cac_getKillstreak(class_num, 1);
    loadoutKillstreak3 = cac_getKillstreak(class_num, 2);
    loadoutKillstreak4 = cac_getKillstreak(class_num, 3);
  } else if(practiceRoundGame() && isSubstr(class, "practice")) {
    class_num = getClassIndex(class);

    class_num = self.pers["practiceRoundClasses"][class_num];

    loadoutPrimary = table_getWeapon(level.practiceRoundClassTableName, class_num, 0);
    loadoutPrimaryAttachment = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 0);
    loadoutPrimaryAttachment2 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 1);
    loadoutPrimaryAttachment3 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 0, 2);
    loadoutPrimaryCamo = table_getWeaponCamo(level.practiceRoundClassTableName, class_num, 0);
    loadoutPrimaryReticle = table_getWeaponReticle(level.practiceRoundClassTableName, class_num, 0);

    loadoutSecondary = table_getWeapon(level.practiceRoundClassTableName, class_num, 1);
    loadoutSecondaryAttachment = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 0);
    loadoutSecondaryAttachment2 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 1);
    loadoutSecondaryAttachment3 = table_getWeaponAttachment(level.practiceRoundClassTableName, class_num, 1, 2);
    loadoutSecondaryCamo = table_getWeaponCamo(level.practiceRoundClassTableName, class_num, 1);
    loadoutSecondaryReticle = table_getWeaponReticle(level.practiceRoundClassTableName, class_num, 1);

    loadoutEquipment = table_getEquipment(level.practiceRoundClassTableName, class_num);
    loadoutEquipmentExtra = table_getEquipmentExtra(level.practiceRoundClassTableName, class_num);
    loadoutOffhand = table_getOffhand(level.practiceRoundClassTableName, class_num);
    loadoutOffhandExtra = table_getOffhandExtra(level.practiceRoundClassTableName, class_num);

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = table_getPerk(level.practiceRoundClassTableName, class_num, i);
    }

    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = table_getWildcard(level.practiceRoundClassTableName, class_num, i);
    }

    loadoutKillstreak1 = table_getKillstreak(level.practiceRoundClassTableName, class_num, 0);
    loadoutKillstreak2 = table_getKillstreak(level.practiceRoundClassTableName, class_num, 1);
    loadoutKillstreak3 = table_getKillstreak(level.practiceRoundClassTableName, class_num, 2);
    loadoutKillstreak4 = table_getKillstreak(level.practiceRoundClassTableName, class_num, 3);
  } else if(isSubstr(class, "lobby")) {
    class_num = getClassIndex(class);
    classLoc = cac_getCustomClassLoc();
    loadout = self.loadouts[classLoc][class_num];

    loadoutPrimary = loadout["primary"];
    loadoutPrimaryAttachment = loadout["primaryAttachment1"];
    loadoutPrimaryAttachment2 = loadout["primaryAttachment2"];
    loadoutPrimaryAttachment3 = loadout["primaryAttachment3"];
    loadoutPrimaryCamo = loadout["primaryCamo"];
    loadoutPrimaryReticle = loadout["primaryReticle"];
    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = loadout["perk" + i];
    }
    loadoutEquipment = loadout["equipment"];
    loadoutOffhand = loadout["offhand"];
    loadoutEquipmentExtra = false;
    loadoutOffhandExtra = false;
    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = loadout["wildcard" + i];
      if(loadoutWildcards[i] == "specialty_wildcard_duallethals") {
        loadoutEquipmentExtra = true;
      }
    }
    loadoutSecondary = loadout["secondary"];
    loadoutSecondaryAttachment = loadout["secondaryAttachment1"];
    loadoutSecondaryAttachment2 = loadout["secondaryAttachment2"];
    loadoutSecondaryAttachment3 = loadout["secondaryAttachment3"];
    loadoutSecondaryCamo = loadout["secondaryCamo"];
    loadoutSecondaryReticle = loadout["secondaryReticle"];
  } else if(isGameModeClass) {
    gamemodeLoadout = self.pers["gamemodeLoadout"];

    loadoutPrimary = gamemodeLoadout["loadoutPrimary"];
    loadoutPrimaryAttachment = gamemodeLoadout["loadoutPrimaryAttachment"];
    loadoutPrimaryAttachment2 = gamemodeLoadout["loadoutPrimaryAttachment2"];
    loadoutPrimaryAttachment3 = gamemodeLoadout["loadoutPrimaryAttachment3"];
    loadoutPrimaryCamo = gamemodeLoadout["loadoutPrimaryCamo"];
    loadoutPrimaryReticle = gamemodeLoadout["loadoutPrimaryReticle"];
    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = gamemodeLoadout["loadoutPerks"][i];
    }
    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = gamemodeLoadout["loadoutWildcards"][i];
    }
    loadoutSecondary = gamemodeLoadout["loadoutSecondary"];
    loadoutSecondaryAttachment = gamemodeLoadout["loadoutSecondaryAttachment"];
    loadoutSecondaryAttachment2 = gamemodeLoadout["loadoutSecondaryAttachment2"];
    loadoutSecondaryAttachment3 = gamemodeLoadout["loadoutSecondaryAttachment3"];
    loadoutSecondaryCamo = gamemodeLoadout["loadoutSecondaryCamo"];
    loadoutSecondaryReticle = gamemodeLoadout["loadoutSecondaryReticle"];

    loadoutEquipment = gamemodeLoadout["loadoutEquipment"];
    loadoutEquipmentExtra = gamemodeLoadout["loadoutEquipmentExtra"];
    loadoutOffhand = gamemodeLoadout["loadoutOffhand"];
    loadoutOffhandExtra = gamemodeLoadout["loadoutOffhandExtra"];

    if(loadoutOffhand == "specialty_null") {
      loadoutOffhand = "none";
    }

    if(level.killstreakRewards) {
      shouldApplyKillstreaks = true;
      if(isDefined(self.gamemode_carrierClass) && self.gamemode_carrierClass) {
        killstreaksAreEmpty = true;
        foreach(killstreak in gamemodeLoadout["loadoutKillstreaks"]) {
          if(killstreak != "none" && killstreak != "") {
            killstreaksAreEmpty = false;
            break;
          }
        }

        if(killstreaksAreEmpty) {
          shouldApplyKillstreaks = false;
          keepCurrentKillstreaks = true;
        }
      }

      if(shouldApplyKillstreaks) {
        loadoutKillstreak1 = gamemodeLoadout["loadoutKillstreaks"][0];
        loadoutKillstreak2 = gamemodeLoadout["loadoutKillstreaks"][1];
        loadoutKillstreak3 = gamemodeLoadout["loadoutKillstreaks"][2];
        loadoutKillstreak4 = gamemodeLoadout["loadoutKillstreaks"][3];
      }
    } else {
      loadoutKillstreak1 = "none";
      loadoutKillstreak2 = "none";
      loadoutKillstreak3 = "none";
      loadoutKillstreak4 = "none";
    }

    loadoutJuggernaut = gamemodeLoadout["loadoutJuggernaut"];
  } else if(IsSubStr(class, "juggernaut_exosuit")) {
    if(class == "juggernaut_exosuit_maniac") {
      loadoutPrimary = "iw5_mechpunch";
      loadoutPrimaryAttachment = "none";
      loadoutSecondary = "iw5_mechpunch";
      loadoutEquipment = "exoknife_jug_mp";
    } else {
      loadoutPrimary = "iw5_exominigun";
      loadoutPrimaryAttachment = "none";
      loadoutSecondary = "none";
      loadoutEquipment = "frag_grenade_mp";
    }
    loadoutPrimaryAttachment2 = "none";
    loadoutPrimaryAttachment3 = "none";
    loadoutPrimaryCamo = "none";
    loadoutPrimaryReticle = "none";
    loadoutPerks[0] = "specialty_class_fasthands";
    loadoutPerks[1] = "specialty_null";
    loadoutPerks[2] = "specialty_null";
    loadoutPerks[3] = "specialty_null";
    loadoutPerks[4] = "specialty_null";
    loadoutPerks[5] = "specialty_null";
    loadoutWildcards[0] = "specialty_null";
    loadoutWildcards[1] = "specialty_null";
    loadoutWildcards[2] = "specialty_null";
    loadoutSecondaryAttachment = "none";
    loadoutSecondaryAttachment2 = "none";
    loadoutSecondaryAttachment3 = "none";
    loadoutSecondaryCamo = "none";
    loadoutSecondaryReticle = "none";
    loadoutEquipmentExtra = false;
    loadoutOffhand = "none";
    loadoutOffhandExtra = false;
  } else if(class == "minion") {
    loadoutPrimary = "iw5_titan45_mp";
    loadoutPrimaryAttachment = "none";
    loadoutSecondary = "none";
    loadoutEquipment = "none";

    loadoutPrimaryAttachment2 = "none";
    loadoutPrimaryAttachment3 = "none";
    loadoutPrimaryCamo = "none";
    loadoutPrimaryReticle = "none";
    loadoutPerks[0] = "specialty_null";
    loadoutPerks[1] = "specialty_null";
    loadoutPerks[2] = "specialty_null";
    loadoutPerks[3] = "specialty_null";
    loadoutPerks[4] = "specialty_null";
    loadoutPerks[5] = "specialty_null";
    loadoutWildcards[0] = "specialty_null";
    loadoutWildcards[1] = "specialty_null";
    loadoutWildcards[2] = "specialty_null";
    loadoutSecondaryAttachment = "none";
    loadoutSecondaryAttachment2 = "none";
    loadoutSecondaryAttachment3 = "none";
    loadoutSecondaryCamo = "none";
    loadoutSecondaryReticle = "none";
    loadoutEquipmentExtra = false;
    loadoutOffhand = "none";
    loadoutOffhandExtra = false;
  } else if(class == "callback") {
    maxPickCount = level.customClassPickCount;

    if(!isDefined(self.classCallback)) {
      error("self.classCallback function reference required for class 'callback'");
    }

    callbackLoadout = [[self.classCallback]]();
    if(!isDefined(callbackLoadout)) {
      error("array required from self.classCallback for class 'callback'");
    }

    loadoutPrimary = callbackLoadout["loadoutPrimary"];
    loadoutPrimaryAttachment = callbackLoadout["loadoutPrimaryAttachment"];
    loadoutPrimaryAttachment2 = callbackLoadout["loadoutPrimaryAttachment2"];
    loadoutPrimaryAttachment3 = callbackLoadout["loadoutPrimaryAttachment3"];
    loadoutPrimaryCamo = callbackLoadout["loadoutPrimaryCamo"];
    loadoutPrimaryReticle = callbackLoadout["loadoutPrimaryReticle"];

    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = callbackLoadout["loadoutPerk" + (i + 1)];
    }
    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = callbackLoadout["loadoutWildcard" + (i + 1)];
    }
    loadoutSecondary = callbackLoadout["loadoutSecondary"];
    loadoutSecondaryAttachment = callbackLoadout["loadoutSecondaryAttachment"];
    loadoutSecondaryAttachment2 = callbackLoadout["loadoutSecondaryAttachment2"];
    loadoutSecondaryAttachment3 = callbackLoadout["loadoutSecondaryAttachment3"];
    loadoutSecondaryCamo = callbackLoadout["loadoutSecondaryCamo"];
    loadoutSecondaryReticle = callbackLoadout["loadoutSecondaryReticle"];
    loadoutEquipment = callbackLoadout["loadoutEquipment"];
    loadoutEquipmentExtra = (callbackLoadout["loadoutEquipment2"] != "specialty_null");
    loadoutOffhand = callbackLoadout["loadoutOffhand"];
    loadoutOffhandExtra = (callbackLoadout["loadoutOffhand2"] != "specialty_null");

    loadoutKillstreak1 = callbackLoadout["loadoutStreak1"];
    loadoutKillstreak2 = callbackLoadout["loadoutStreak2"];
    loadoutKillstreak3 = callbackLoadout["loadoutStreak3"];
    loadoutKillstreak4 = callbackLoadout["loadoutStreak4"];

    module_letter = ["a", "b", "c"];
    for(i = 0; i < 4; i++) {
      loadoutKillstreakModules[i] = [];
      for(j = 0; j < 3; j++) {
        loadoutKillstreakModules[i][j] = callbackLoadout["loadoutStreakModule" + (i + 1) + module_letter[j]];
      }
    }
  } else {
    class_num = getClassIndex(class);

    loadoutPrimary = table_getWeapon(level.classTableName, class_num, 0);
    loadoutPrimaryAttachment = table_getWeaponAttachment(level.classTableName, class_num, 0, 0);
    loadoutPrimaryAttachment2 = table_getWeaponAttachment(level.classTableName, class_num, 0, 1);
    loadoutPrimaryAttachment3 = table_getWeaponAttachment(level.classTableName, class_num, 0, 2);
    loadoutPrimaryCamo = table_getWeaponCamo(level.classTableName, class_num, 0);
    loadoutPrimaryReticle = table_getWeaponReticle(level.classTableName, class_num, 0);
    for(i = 0; i < 6; i++) {
      loadoutPerks[i] = table_getPerk(level.classTableName, class_num, i);
    }
    for(i = 0; i < 3; i++) {
      loadoutWildcards[i] = table_getWildcard(level.classTableName, class_num, i);
    }
    loadoutSecondary = table_getWeapon(level.classTableName, class_num, 1);
    loadoutSecondaryAttachment = table_getWeaponAttachment(level.classTableName, class_num, 1, 0);
    loadoutSecondaryAttachment2 = table_getWeaponAttachment(level.classTableName, class_num, 1, 1);
    loadoutSecondaryAttachment3 = table_getWeaponAttachment(level.classTableName, class_num, 1, 2);
    loadoutSecondaryCamo = table_getWeaponCamo(level.classTableName, class_num, 1);
    loadoutSecondaryReticle = table_getWeaponReticle(level.classTableName, class_num, 1);
    loadoutEquipment = table_getEquipment(level.classTableName, class_num);
    loadoutEquipmentExtra = table_getEquipmentExtra(level.classTableName, class_num);
    loadoutOffhand = table_getOffhand(level.classTableName, class_num);
    loadoutOffhandExtra = table_getOffhandExtra(level.classTableName, class_num);

    loadoutKillstreak1 = table_getKillstreak(level.classTableName, class_num, 0);
    loadoutKillstreak2 = table_getKillstreak(level.classTableName, class_num, 1);
    loadoutKillstreak3 = table_getKillstreak(level.classTableName, class_num, 2);
    loadoutKillstreak4 = table_getKillstreak(level.classTableName, class_num, 3);

    if(!isDefined(loadoutKillstreak1) || (loadoutKillstreak1 == "")) {
      loadoutKillstreak1 = "none";
    }
    if(!isDefined(loadoutKillstreak2) || (loadoutKillstreak2 == "")) {
      loadoutKillstreak2 = "none";
    }
    if(!isDefined(loadoutKillstreak3) || (loadoutKillstreak3 == "")) {
      loadoutKillstreak3 = "none";
    }
    if(!isDefined(loadoutKillstreak4) || (loadoutKillstreak4 == "")) {
      loadoutKillstreak4 = "none";
    }
  }

  isCustomClass = isSubstr(class, "custom") || isSubstr(class, "lobby");
  isRecipeClass = isSubstr(class, "recipe");
  ignorelock = false;

  unlockallweapons = getdvar("unlockAllLootItems", "0");
  if(unlockallweapons == "1") {
    ignorelock = true;
  }

  if(level.killstreakRewards && !isDefined(loadoutKillstreak1) && !isDefined(loadoutKillstreak2) && !isDefined(loadoutKillstreak3) && !isDefined(loadoutKillstreak4)) {
    if(!IsSubStr(class, "juggernaut") && class != "minion") {
      class_num = getClassIndex(class);
      if(isDefined(self.class_num)) {
        class_num = self.class_num;
      }
    } else {
      class_num = 0;
    }

    defaultKillstreak1 = undefined;
    defaultKillstreak2 = undefined;
    defaultKillstreak3 = undefined;
    defaultKillstreak4 = undefined;
    playerData = "assaultStreaks";

    defaultKillstreak1 = table_getKillstreak(level.classTableName, class_num, 0);
    defaultKillstreak2 = table_getKillstreak(level.classTableName, class_num, 1);
    defaultKillstreak3 = table_getKillstreak(level.classTableName, class_num, 2);
    defaultKillstreak4 = table_getKillstreak(level.classTableName, class_num, 3);

    loadoutKillstreak1 = undefined;
    loadoutKillstreak2 = undefined;
    loadoutKillstreak3 = undefined;
    loadoutKillstreak4 = undefined;

    if(cacLoadout) {
      assert(isDefined(self.class_num));
      loadoutKillstreak1 = self getCaCPlayerData(self.class_num, playerData, 0, "streak");
      loadoutKillstreak2 = self getCaCPlayerData(self.class_num, playerData, 1, "streak");
      loadoutKillstreak3 = self getCaCPlayerData(self.class_num, playerData, 2, "streak");
      loadoutKillstreak4 = self getCaCPlayerData(self.class_num, playerData, 3, "streak");
    }

    if(IsSubStr(class, "juggernaut") || isGameModeClass) {
      foreach(killstreak in self.killstreaks) {
        if(!isDefined(loadoutKillstreak1)) {
          loadoutKillstreak1 = killstreak;
        } else if(!isDefined(loadoutKillstreak2)) {
          loadoutKillstreak2 = killstreak;
        } else if(!isDefined(loadoutKillstreak3)) {
          loadoutKillstreak3 = killstreak;
        } else if(!isDefined(loadoutKillstreak4)) {
          loadoutKillstreak4 = killstreak;
        }
      }
    }

    if(!isSubstr(class, "custom") && !isSubstr(class, "juggernaut") && !isGameModeClass && class != "minion") {
      loadoutKillstreak1 = defaultKillstreak1;
      loadoutKillstreak2 = defaultKillstreak2;
      loadoutKillstreak3 = defaultKillstreak3;
      loadoutKillstreak4 = defaultKillstreak4;
    }

    if(!isDefined(loadoutKillstreak1) || (loadoutKillstreak1 == "")) {
      loadoutKillstreak1 = "none";
    }
    if(!isDefined(loadoutKillstreak2) || (loadoutKillstreak2 == "")) {
      loadoutKillstreak2 = "none";
    }
    if(!isDefined(loadoutKillstreak3) || (loadoutKillstreak3 == "")) {
      loadoutKillstreak3 = "none";
    }
    if(!isDefined(loadoutKillstreak4) || (loadoutKillstreak4 == "")) {
      loadoutKillstreak4 = "none";
    }

    if(!isValidKillstreak(loadoutKillstreak1) || (isCustomClass && !self isItemUnlocked(loadoutKillstreak1))) {
      loadoutKillstreak1 = table_getKillstreak(level.classTableName, 0, 0);
    }
    if(!isValidKillstreak(loadoutKillstreak2) || (isCustomClass && !self isItemUnlocked(loadoutKillstreak2))) {
      loadoutKillstreak2 = table_getKillstreak(level.classTableName, 0, 1);
    }
    if(!isValidKillstreak(loadoutKillstreak3) || (isCustomClass && !self isItemUnlocked(loadoutKillstreak3))) {
      loadoutKillstreak3 = table_getKillstreak(level.classTableName, 0, 2);
    }
    if(!isValidKillstreak(loadoutKillstreak4) || (isCustomClass && !self isItemUnlocked(loadoutKillstreak4))) {
      loadoutKillstreak4 = table_getKillstreak(level.classTableName, 0, 3);
    }
  } else if(!level.killstreakRewards) {
    loadoutKillstreak1 = "none";
    loadoutKillstreak2 = "none";
    loadoutKillstreak3 = "none";
    loadoutKillstreak4 = "none";
  }

  loadoutSecondaryAttachment3 = "none";

  requiredPrimaryAttachment = tablelookup("mp/statstable.csv", 4, loadoutPrimary, 40);
  requiredSecondaryAttachment = tablelookup("mp/statstable.csv", 4, loadoutSecondary, 40);

  pick13ActiveWeaponCount = 0;
  if(loadoutPrimary != "iw5_combatknife") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutPrimaryAttachment != "none" && requiredPrimaryAttachment == "") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutPrimaryAttachment2 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutPrimaryAttachment3 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutSecondary != "iw5_combatknife") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutSecondaryAttachment != "none" && requiredSecondaryAttachment == "") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutSecondaryAttachment2 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutSecondaryAttachment3 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutEquipment != "specialty_null") {
    pick13ActiveWeaponCount++;
  }
  if(isDefined(loadoutEquipmentExtra) && loadoutEquipmentExtra) {
    pick13ActiveWeaponCount++;
  }
  if(loadoutOffhand != "specialty_null") {
    pick13ActiveWeaponCount++;
  }
  if(isDefined(loadoutOffhandExtra) && loadoutOffhandExtra) {
    pick13ActiveWeaponCount++;
  }
  for(i = 0; i < 6; i++) {
    if(loadoutPerks[i] != "specialty_null") {
      pick13ActiveWeaponCount++;
    }
  }
  for(i = 0; i < 3; i++) {
    if(loadoutWildcards[i] != "specialty_null") {
      pick13ActiveWeaponCount++;
    }
  }
  if(loadoutKillstreak1 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutKillstreak2 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutKillstreak3 != "none") {
    pick13ActiveWeaponCount++;
  }
  if(loadoutKillstreak4 != "none") {
    pick13ActiveWeaponCount++;
  }

  if(pick13ActiveWeaponCount > maxPickCount) {
    while(1) {
      if(loadoutKillstreak4 != "none") {
        loadoutKillstreak4 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutKillstreak3 != "none") {
        loadoutKillstreak3 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutKillstreak2 != "none") {
        loadoutKillstreak2 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutKillstreak1 != "none") {
        loadoutKillstreak1 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPerks[5] != "specialty_null") {
        loadoutPerks[5] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPerks[4] != "specialty_null") {
        loadoutPerks[4] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPerks[3] != "specialty_null") {
        loadoutPerks[3] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPerks[2] != "specialty_null") {
        loadoutPerks[2] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPerks[1] != "specialty_null") {
        loadoutPerks[1] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPerks[0] != "specialty_null") {
        loadoutPerks[0] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(isDefined(loadoutOffhandExtra) && loadoutOffhandExtra) {
        loadoutOffhandExtra = false;
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutOffhand != "specialty_null") {
        loadoutOffhand = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(isDefined(loadoutEquipmentExtra) && loadoutEquipmentExtra) {
        loadoutEquipmentExtra = false;
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutEquipment != "specialty_null") {
        loadoutEquipment = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutSecondaryAttachment3 != "none") {
        loadoutSecondaryAttachment3 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutSecondaryAttachment2 != "none") {
        loadoutSecondaryAttachment2 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutSecondaryAttachment != "none" && requiredSecondaryAttachment == "") {
        loadoutSecondaryAttachment = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutSecondary != "iw5_combatknife") {
        loadoutSecondary = "iw5_combatknife";
        loadoutSecondaryAttachment = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPrimaryAttachment3 != "none") {
        loadoutPrimaryAttachment3 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPrimaryAttachment2 != "none") {
        loadoutPrimaryAttachment2 = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPrimaryAttachment != "none" && requiredPrimaryAttachment == "") {
        loadoutPrimaryAttachment = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutPrimary != "iw5_combatknife") {
        loadoutPrimary = "iw5_combatknife";
        loadoutPrimaryAttachment = "none";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }

      if(loadoutWildcards[2] != "specialty_null") {
        loadoutWildcards[2] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutWildcards[1] != "specialty_null") {
        loadoutWildcards[1] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      if(loadoutWildcards[0] != "specialty_null") {
        loadoutWildcards[0] = "specialty_null";
        pick13ActiveWeaponCount--;
        if(pick13ActiveWeaponCount == maxPickCount) {
          break;
        }
      }
      break;
    }
  }

  for(i = 0; i < 3; i++) {
    if(getDvarInt("scr_game_perks") == 0) {
      loadoutWildcards[i] = "specialty_null";
    }
  }

  wildcardsOwned = [];
  wildcardsOwned["specialty_wildcard_perkslot1"] = false;
  wildcardsOwned["specialty_wildcard_perkslot2"] = false;
  wildcardsOwned["specialty_wildcard_perkslot3"] = false;
  wildcardsOwned["specialty_wildcard_primaryattachment"] = false;
  wildcardsOwned["specialty_wildcard_secondaryattachment"] = false;
  wildcardsOwned["specialty_wildcard_dualprimaries"] = false;
  wildcardsOwned["specialty_wildcard_dualtacticals"] = false;
  wildcardsOwned["specialty_wildcard_duallethals"] = false;
  wildcardsOwned["specialty_wildcard_extrastreak"] = false;
  for(i = 0; i < 3; i++) {
    wildcardsOwned[loadoutWildcards[i]] = true;
  }

  if(!wildcardsOwned["specialty_wildcard_extrastreak"]) {
    loadoutKillstreak4 = "none";
  }
  if(!wildcardsOwned["specialty_wildcard_perkslot1"]) {
    loadoutPerks[1] = "specialty_null";
  }
  if(!wildcardsOwned["specialty_wildcard_perkslot2"]) {
    loadoutPerks[3] = "specialty_null";
  }
  if(!wildcardsOwned["specialty_wildcard_perkslot3"]) {
    loadoutPerks[5] = "specialty_null";
  }
  if(!wildcardsOwned["specialty_wildcard_primaryattachment"]) {
    loadoutPrimaryAttachment3 = "none";
  }
  if(!wildcardsOwned["specialty_wildcard_secondaryattachment"]) {
    loadoutSecondaryAttachment2 = "none";
  }

  if(!isGameModeClass && !isRecipeClass && !(isDefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && allowCopycat)) {
    if(!isValidPrimary(loadoutPrimary) || (level.rankedMatch && isCustomClass && !self isItemUnlocked(loadoutPrimary) && !ignorelock)) {
      println("INVALID PRIMARY: " + loadoutPrimary + " isvalid: " + isValidPrimary(loadoutPrimary) + " isLoot: " + isLootWeapon(loadoutPrimary) + " base: " + getBaseFromLootVersion(loadoutPrimary));
      println(" unlocked: " + self isItemUnlocked(loadoutPrimary) + " ingoreLock: " + ignoreLock);

      loadoutPrimary = table_getWeapon(level.classTableName, 10, 0);
      loadoutPrimaryAttachment = "none";
      loadoutPrimaryAttachment2 = "none";
      loadoutPrimaryAttachment3 = "none";
    }

    if(requiredPrimaryAttachment != "") {
      loadoutPrimaryAttachment = requiredPrimaryAttachment;
    } else if(!isValidAttachment(loadoutPrimaryAttachment, loadoutPrimary) || (level.rankedMatch && isCustomClass && !self isAttachmentUnlocked(loadoutPrimary, loadoutPrimaryAttachment) && !ignorelock)) {
      loadoutPrimaryAttachment = table_getWeaponAttachment(level.classTableName, 10, 0, 0);
    }

    if(!isValidAttachment(loadoutPrimaryAttachment2, loadoutPrimary) || (level.rankedMatch && isCustomClass && !self isAttachmentUnlocked(loadoutPrimary, loadoutPrimaryAttachment2) && !ignorelock)) {
      loadoutPrimaryAttachment2 = table_getWeaponAttachment(level.classTableName, 10, 0, 1);
    }

    if(!isValidAttachment(loadoutPrimaryAttachment3, loadoutPrimary) || (level.rankedMatch && isCustomClass && !self isAttachmentUnlocked(loadoutPrimary, loadoutPrimaryAttachment3) && !ignorelock)) {
      loadoutPrimaryAttachment3 = table_getWeaponAttachment(level.classTableName, 10, 0, 2);
    }

    primaryAttachments = [];
    primaryAttachments[primaryAttachments.size] = loadoutPrimaryAttachment;
    primaryAttachments[primaryAttachments.size] = loadoutPrimaryAttachment2;
    primaryAttachments[primaryAttachments.size] = loadoutPrimaryAttachment3;

    for(primaryAttachIdx = 0; primaryAttachIdx < primaryAttachments.size; primaryAttachIdx++) {
      if(primaryAttachments[primaryAttachIdx] == "none") {
        continue;
      }

      for(primaryAttachNextIdx = primaryAttachIdx + 1; primaryAttachNextIdx < primaryAttachments.size; primaryAttachNextIdx++) {
        if(primaryAttachments[primaryAttachNextIdx] == "none") {
          continue;
        }

        if(primaryAttachments[primaryAttachIdx] == primaryAttachments[primaryAttachNextIdx]) {
          assert(primaryAttachNextIdx > 0);
          PrintLn("^1Warning: " + primaryAttachments[primaryAttachNextIdx] + " duplicated for weapon " + loadoutPrimary + "; removing.");
          self recordValidationInfraction();
          primaryAttachments[primaryAttachNextIdx] = "none";

          if(primaryAttachNextIdx == 1) {
            loadoutPrimaryAttachment2 = "none";
          } else if(primaryAttachNextIdx == 2) {
            loadoutPrimaryAttachment3 = "none";
          } else {
            assert(false);
          }
        }
      }
    }

    if(!isValidCamo(loadoutPrimaryCamo) || (level.rankedMatch && isCustomClass && !self isCamoUnlocked(loadoutPrimary, loadoutPrimaryCamo) && !ignorelock)) {
      loadoutPrimaryCamo = table_getWeaponCamo(level.classTableName, 10, 0);
    }

    if(!isValidReticle(loadoutPrimaryReticle)) {
      loadoutPrimaryReticle = table_getWeaponReticle(level.classTableNum, 10, 0);
    }

    if(!isValidSecondary(loadoutSecondary, wildcardsOwned["specialty_wildcard_dualprimaries"]) || (level.rankedMatch && isCustomClass && !self isItemUnlocked(loadoutSecondary) && !ignorelock)) {
      println("INVALID SECONDARY: " + loadoutSecondary + " isLoot: " + isLootWeapon(loadoutSecondary) + " base: " + getBaseFromLootVersion(loadoutSecondary));
      println("isValid: " + isValidSecondary(loadoutSecondary, wildcardsOwned["specialty_wildcard_dualprimaries"]) + " isPrimary: " + wildcardsOwned["specialty_wildcard_dualprimaries"] + " unlocked: " + self isItemUnlocked(loadoutSecondary) + " ignoreLock: " + ignoreLock);

      loadoutSecondary = table_getWeapon(level.classTableName, 10, 1);
      loadoutSecondaryAttachment = "none";
      loadoutSecondaryAttachment2 = "none";
      loadoutSecondaryCamo = "none";
      loadoutSecondaryReticle = "none";
    }

    if(requiredSecondaryAttachment != "") {
      loadoutSecondaryAttachment = requiredSecondaryAttachment;
    } else if(!isValidAttachment(loadoutSecondaryAttachment, loadoutSecondary) || (level.rankedMatch && isCustomClass && !self isAttachmentUnlocked(loadoutSecondary, loadoutSecondaryAttachment) && !ignorelock)) {
      loadoutSecondaryAttachment = table_getWeaponAttachment(level.classTableName, 10, 1, 0);
    }

    if(!isValidAttachment(loadoutSecondaryAttachment2, loadoutSecondary) || (level.rankedMatch && isCustomClass && !self isAttachmentUnlocked(loadoutSecondary, loadoutSecondaryAttachment2) && !ignorelock)) {
      loadoutSecondaryAttachment2 = table_getWeaponAttachment(level.classTableName, 10, 1, 1);
    }

    if(loadoutSecondaryAttachment != "none") {
      if(loadoutSecondaryAttachment == loadoutSecondaryAttachment2) {
        PrintLn("^1Warning: " + loadoutSecondaryAttachment2 + " duplicated for weapon " + loadoutSecondary + "; removing.");
        self recordValidationInfraction();
        loadoutSecondaryAttachment2 = "none";
      }
    }

    if(!isValidCamo(loadoutSecondaryCamo) || (level.rankedMatch && isCustomClass && !self isCamoUnlocked(loadoutSecondary, loadoutSecondaryCamo) && !ignorelock)) {
      loadoutSecondaryCamo = table_getWeaponCamo(level.classTableName, 10, 1);
    }

    if(!isValidReticle(loadoutSecondaryReticle)) {
      loadoutSecondaryReticle = table_getWeaponReticle(level.classTableName, 10, 1);
    }

    if(!isValidEquipment(loadoutEquipment, wildcardsOwned["specialty_wildcard_dualtacticals"]) || (level.rankedMatch && isCustomClass && !self isItemUnlocked(loadoutEquipment) && !ignorelock)) {
      loadoutEquipment = table_getEquipment(level.classTableName, 10);
    }

    if(loadoutEquipment == loadoutOffhand) {
      loadoutEquipment = "specialty_null";
    }

    if(!isValidOffhand(loadoutOffhand, wildcardsOwned["specialty_wildcard_duallethals"])) {
      loadoutOffhand = table_getOffhand(level.classTableName, 10);
    }
  }

  if(wildcardsOwned["specialty_wildcard_duallethals"] && loadoutOffhand != "specialty_null") {
    loadoutOffhand = loadoutOffhand + "_lefthand";
  }

  for(i = 0; i < 6; i++) {
    if(loadoutPerks[i] == "specialty_null") {
      continue;
    }

    loadoutStorePerk = loadoutPerks[i];
    loadoutPerks[i] = maps\mp\perks\_perks::validatePerk(i, loadoutPerks[i]);
    if(loadoutStorePerk != loadoutPerks[i]) {
      PrintLn("^1Warning: Perk " + loadoutStorePerk + " in wrong slot.");
      self recordValidationInfraction();
    }
  }

  loadout = spawnStruct();

  loadout.class = class;
  loadout.class_num = class_num;
  loadout.teamName = teamName;
  loadout.clearAmmo = clearAmmo;

  loadout.copycatLoadout = copycatLoadout;
  loadout.cacLoadout = cacLoadout;
  loadout.practiceLoadout = practiceLoadout;
  loadout.isGameModeClass = isGameModeClass;

  loadout.primary = loadoutPrimary;
  loadout.primaryAttachment = loadoutPrimaryAttachment;
  loadout.primaryAttachment2 = loadoutPrimaryAttachment2;
  loadout.primaryAttachment3 = loadoutPrimaryAttachment3;
  loadout.primaryCamo = loadoutPrimaryCamo;
  loadout.primaryReticle = loadoutPrimaryReticle;
  loadoutPrimaryCamo = int(tableLookup("mp/camoTable.csv", 1, loadout.primaryCamo, 0));
  loadoutPrimaryReticle = int(tableLookup("mp/reticleTable.csv", 1, loadout.primaryReticle, 0));

  loadout.primaryName = buildWeaponName(loadout.primary, loadout.primaryAttachment, loadout.primaryAttachment2, loadout.primaryAttachment3, loadoutPrimaryCamo, loadoutPrimaryReticle);

  loadout.secondary = loadoutSecondary;
  loadout.secondaryAttachment = loadoutSecondaryAttachment;
  loadout.secondaryAttachment2 = loadoutSecondaryAttachment2;
  loadout.secondaryAttachment3 = "none";
  loadout.secondaryCamo = loadoutSecondaryCamo;
  loadout.secondaryReticle = loadoutSecondaryReticle;
  loadoutSecondaryCamo = int(tableLookup("mp/camoTable.csv", 1, loadout.secondaryCamo, 0));
  loadoutSecondaryReticle = int(tableLookup("mp/reticleTable.csv", 1, loadout.secondaryReticle, 0));
  loadout.secondaryName = buildWeaponName(loadout.secondary, loadout.secondaryAttachment, loadout.secondaryAttachment2, loadout.secondaryAttachment3, loadoutSecondaryCamo, loadoutSecondaryReticle);

  loadout.equipment = loadoutEquipment;
  loadout.equipmentExtra = loadoutEquipmentExtra;
  loadout.offhand = loadoutOffhand;
  loadout.offhandExtra = loadoutOffhandExtra;

  loadout.perks = loadoutPerks;

  loadout.killstreak1 = loadoutKillstreak1;
  loadout.killstreak2 = loadoutKillstreak2;
  loadout.killstreak3 = loadoutKillstreak3;
  loadout.killstreak4 = loadoutKillstreak4;
  loadout.loadoutKillstreakModules = loadoutKillstreakModules;
  loadout.keepCurrentKillstreaks = keepCurrentKillstreaks;

  loadout.wildcards = loadoutWildcards;
  loadout.wildcardsOwned = wildcardsOwned;

  loadout.juggernaut = loadoutJuggernaut;

  loadout.setPrimarySpawnWeapon = setPrimarySpawnWeapon;

  return loadout;
}

giveLoadout(team, class, allowCopycat, setPrimarySpawnWeapon) {
  self.loadout = getLoadout(team, class, allowCopycat, setPrimarySpawnWeapon);
}

applyLoadout() {
  Assert(isDefined(self.loadout));
  loadout = self.loadout;
  if(!isDefined(self.loadout)) {
    return;
  }

  self.loadout = undefined;
  self.spectatorViewLoadout = loadout;

  self takeAllWeapons();
  self _clearPerks();
  self _detachAll();

  self.changingWeapon = undefined;

  if(loadout.copycatLoadout) {
    self maps\mp\gametypes\_class::setClass("copycat");
  }

  self.class_num = loadout.class_num;
  self.loadoutWildcards = loadout.wildcards;

  self.loadoutPrimary = loadout.primary;
  self.loadoutPrimaryCamo = int(tableLookup("mp/camoTable.csv", 1, loadout.primaryCamo, 0));
  self.loadoutSecondary = loadout.secondary;
  self.loadoutSecondaryCamo = int(tableLookup("mp/camoTable.csv", 1, loadout.secondaryCamo, 0));

  if(!IsSubstr(loadout.primary, "iw5")) {
    self.loadoutPrimaryCamo = 0;
  }
  if(!IsSubstr(loadout.secondary, "iw5")) {
    self.loadoutSecondaryCamo = 0;
  }

  self.loadoutPrimaryReticle = int(tableLookup("mp/reticleTable.csv", 1, loadout.primaryReticle, 0));
  self.loadoutSecondaryReticle = int(tableLookup("mp/reticleTable.csv", 1, loadout.secondaryReticle, 0));

  if(!IsSubstr(loadout.primary, "iw5")) {
    self.loadoutPrimaryReticle = 0;
  }
  if(!IsSubstr(loadout.secondary, "iw5")) {
    self.loadoutSecondaryReticle = 0;
  }

  if(isDefined(loadout.juggernaut) && loadout.juggernaut) {
    self.health = self.maxHealth;
    self thread recipeClassApplyJuggernaut(self isJuggernaut());
    self.isJuggernaut = true;
    self.juggMoveSpeedScaler = 0.7;
  } else if(self isJuggernaut()) {
    self notify("lost_juggernaut");
    self.isJuggernaut = false;
    self.moveSpeedScaler = level.basePlayerMoveScale;
  }

  secondaryName = loadout.secondaryName;
  if(secondaryName != "none") {
    self _giveWeapon(secondaryName);
  }

  if(loadout.wildcardsOwned["specialty_wildcard_dualtacticals"]) {
    self givePerk("specialty_wildcard_dualtacticals", false);
  }
  if(loadout.wildcardsOwned["specialty_wildcard_duallethals"]) {
    self givePerk("specialty_wildcard_duallethals", false);
  }

  if(level.dieHardMode) {
    self givePerk("specialty_pistoldeath", false);
  }

  self loadoutAllPerks(loadout.equipment, loadout.perks);

  self maps\mp\perks\_perks::applyPerks();
  self giveDefaultPerks();

  self SetLethalWeapon(loadout.equipment);

  if(loadout.equipment != "specialty_null" && self hasWeapon(loadout.equipment)) {
    currentClipAmmo = self GetWeaponAmmoClip(loadout.equipment);
    self SetWeaponAmmoClip(loadout.equipment, currentClipAmmo + 1);
  } else {
    self giveOffhand(loadout.equipment);
  }

  if(isDefined(loadout.equipmentExtra) && loadout.equipmentExtra) {
    givePerk("specialty_extralethal", false);
    currentClipAmmo = self GetWeaponAmmoClip(loadout.equipment);
    self SetWeaponAmmoClip(loadout.equipment, currentClipAmmo + 1);
  }

  primaryName = loadout.primaryName;

  self _giveWeapon(primaryName);

  if(!IsAI(self)) {
    self SwitchToWeapon(primaryName);
  }

  if(primaryName == "riotshield_mp" && level.inGracePeriod) {
    self notify("weapon_change", "riotshield_mp");
  }

  if(loadout.setPrimarySpawnWeapon) {
    self setSpawnWeapon(get_spawn_weapon_name(loadout));
  }

  self.pers["primaryWeapon"] = getBaseWeaponName(primaryName);

  self.loadoutOffhand = loadout.offhand;

  self SetTacticalWeapon(loadout.offhand);

  self giveOffhand(loadout.offhand);

  if(isDefined(loadout.offhandExtra) && loadout.offhandExtra) {
    self givePerk("specialty_extratactical", false);
    currentClipAmmo = self GetWeaponAmmoClip(loadout.offhand);
    self SetWeaponAmmoClip(loadout.offhand, currentClipAmmo + 1);
  }

  self thread loadoutTrackVariableGrenades(loadout.class, loadout.equipment, loadout.offhand);

  primaryWeapon = primaryName;
  self.primaryWeapon = primaryWeapon;
  self.secondaryWeapon = secondaryName;

  if(loadout.clearAmmo) {
    self SetWeaponAmmoClip(self.primaryWeapon, 0);
    self SetWeaponAmmoStock(self.primaryWeapon, 0);
  }

  self.isSniper = (weaponClass(self.primaryWeapon) == "sniper");

  self _setActionSlot(1, "");

  self _setActionSlot(3, "altMode");
  self _setActionSlot(4, "");

  if(!level.console) {
    self _setActionSlot(5, "");
    self _setActionSlot(6, "");
    self _setActionSlot(7, "");
    self _setActionSlot(8, "");
  }

  if(self _hasPerk("specialty_extraammo")) {
    stockAmmo = self GetWeaponAmmoStock(primaryName);
    self SetWeaponAmmoStock(primaryName, stockAmmo * 2);

    if((secondaryName != "none") && (getWeaponClass(secondaryName) != "weapon_projectile")) {
      stockAmmo = self GetWeaponAmmoStock(secondaryName);
      self SetWeaponAmmoStock(secondaryName, stockAmmo * 2);
    }
  }

  if(!InVirtualLobby()) {
    if(!IsSubStr(loadout.class, "juggernaut")) {
      self setKillstreaks(loadout.killstreak1, loadout.killstreak2, loadout.killstreak3, loadout.killstreak4, loadout.cacLoadout, loadout.practiceLoadout, loadout.copycatLoadout, loadout.isGameModeClass, loadout.teamName, loadout.loadoutKillstreakModules);
    }

    should_reset_killstreaks = true;
    if(loadout.keepCurrentKillstreaks) {
      should_reset_killstreaks = false;
    } else if(IsAgent(self)) {
      should_reset_killstreaks = false;
    } else if(!isDefined(self.lastClass)) {
      should_reset_killstreaks = false;
    } else if(!IsBot(self) && self.lastClass == self.class && !(isDefined(self.gamemode_carrierClass) && self.gamemode_carrierClass)) {
      should_reset_killstreaks = false;
    } else if(IsBot(self) && self.bot_last_loadout_num == self.bot_cur_loadout_num) {
      should_reset_killstreaks = false;
    } else if(IsSubStr(self.class, "juggernaut") || IsSubStr(self.lastClass, "juggernaut") || IsSubStr(loadout.class, "juggernaut")) {
      should_reset_killstreaks = false;
    }

    loadout.keepCurrentKillstreaks = !should_reset_killstreaks;

    if(should_reset_killstreaks) {
      if(wasOnlyRound() || self.lastClass != "") {
        streakNames = [];
        modules = [];
        inc = 0;
        self_pers_killstreaks = self.pers["killstreaks"];

        if(self_pers_killstreaks.size > level.KILLSTREAK_STACKING_START_SLOT) {
          for(i = level.KILLSTREAK_STACKING_START_SLOT; i < self_pers_killstreaks.size; i++) {
            streakNames[inc] = self_pers_killstreaks[i].streakName;
            modules[inc] = self_pers_killstreaks[i].modules;
            inc++;
          }
        }

        if(self_pers_killstreaks.size) {
          for(i = level.KILLSTREAK_SLOT_1; i < level.KILLSTREAK_STACKING_START_SLOT; i++) {
            if(isDefined(self_pers_killstreaks[i]) &&
              isDefined(self_pers_killstreaks[i].streakName) &&
              self_pers_killstreaks[i].available) {
              streakNames[inc] = self_pers_killstreaks[i].streakName;
              modules[inc] = self_pers_killstreaks[i].modules;
              inc++;
            }
          }
        }

        self notify("givingLoadout");

        maps\mp\killstreaks\_killstreaks::clearKillstreaks(true);

        for(i = 0; i < streakNames.size; i++) {
          self maps\mp\killstreaks\_killstreaks::giveKillstreak(streakNames[i], undefined, undefined, undefined, modules[i]);
        }
      }
    }

    self.loadoutKeepCurrentKillstreaks = loadout.keepCurrentKillstreaks;
  }

  if(!IsSubStr(loadout.class, "juggernaut")) {
    if(isDefined(self.lastClass) && self.lastClass != "" && self.lastClass != self.class) {
      self notify("changed_class");
    }

    self.pers["lastClass"] = self.class;
    self.lastClass = self.class;
  }

  if(isDefined(self.gamemode_chosenClass)) {
    self.pers["class"] = self.gamemode_chosenClass;
    self.pers["lastClass"] = self.gamemode_chosenClass;
    self.class = self.gamemode_chosenClass;
    if(!isDefined(self.gamemode_carrierClass) || loadout.keepCurrentKillstreaks) {
      self.lastClass = self.gamemode_chosenClass;
    }
    self.gamemode_chosenClass = undefined;
  }

  self.gamemode_carrierClass = undefined;

  if(!isDefined(level.isZombieGame) || !level.isZombieGame) {
    if(!isDefined(self.costume)) {
      if(practiceRoundGame()) {
        self.costume = self maps\mp\gametypes\_teams::getPracticeRoundCostume();
      } else {
        if(IsPlayer(self)) {
          self.costume = self cao_getActiveCostume();
        } else if(IsAgent(self) && self.agent_type == "player") {
          self.costume = maps\mp\gametypes\_teams::getDefaultCostume();
        }
      }
    }

    if(level.hardcoreMode && isPlayer(self)) {
      main_costume = self cao_getActiveCostume();
      self.costume = self maps\mp\gametypes\_teams::getHardcoreCostume();

      self.costume[level.costumeCat2Idx["gender"]] = main_costume[level.costumeCat2Idx["gender"]];
      self.costume[level.costumeCat2Idx["head"]] = main_costume[level.costumeCat2Idx["head"]];
    }

    if(!maps\mp\gametypes\_teams::validCostume(self.costume)) {
      if(isDefined(self.sessionCostume) && maps\mp\gametypes\_teams::validCostume(self.sessionCostume)) {
        self.costume = self.sessionCostume;
      } else {
        self.costume = maps\mp\gametypes\_teams::getDefaultCostume();
        if(IsPlayer(self)) {
          self cao_setActiveCostume(self.costume);
        }
        self.sessionCostume = self.costume;
      }
    }

    self logPlayerCostume();

    self maps\mp\gametypes\_teams::playerModelForWeapon(self.pers["primaryWeapon"], getBaseWeaponName(secondaryName));
  }

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  self maps\mp\perks\_perks::cac_selector();

  self notify("changed_kit");
  self notify("applyLoadout");
}

logPlayerCostume() {
  if(IsAgent(self)) {
    return;
  }

  if(!isDefined(self.costumeLogged)) {
    gender = self cao_getGlobalCostumeCategory("gender");
    head = self cao_getGlobalCostumeCategory("head");

    activeIndex = self cao_getActiveCostumeIndex();

    shirt = self cao_getPerCostumeCategory("shirt", activeIndex);
    pants = self cao_getPerCostumeCategory("pants", activeIndex);
    eyewear = self cao_getPerCostumeCategory("eyewear", activeIndex);
    hat = self cao_getPerCostumeCategory("hat", activeIndex);
    kneepads = self cao_getPerCostumeCategory("kneepads", activeIndex);
    gloves = self cao_getPerCostumeCategory("gloves", activeIndex);
    shoes = self cao_getPerCostumeCategory("shoes", activeIndex);
    gear = self cao_getPerCostumeCategory("gear", activeIndex);
    exo = self cao_getPerCostumeCategory("exo", activeIndex);

    setMatchData("players", self.clientid, "costume", "gender", gender);
    setMatchData("players", self.clientid, "costume", "head", head);
    setMatchData("players", self.clientid, "costume", "shirt", shirt);
    setMatchData("players", self.clientid, "costume", "pants", pants);
    setMatchData("players", self.clientid, "costume", "eyewear", eyewear);
    setMatchData("players", self.clientid, "costume", "hat", hat);
    setMatchData("players", self.clientid, "costume", "kneepads", kneepads);
    setMatchData("players", self.clientid, "costume", "gloves", gloves);
    setMatchData("players", self.clientid, "costume", "shoes", shoes);
    setMatchData("players", self.clientid, "costume", "gear", gear);
    setMatchData("players", self.clientid, "costume", "exo", exo);

    self.costumeLogged = true;
  }
}

giveAndApplyLoadout(team, class, allowCopycat, setPrimarySpawnWeapon) {
  self giveLoadout(team, class, allowCopycat, setPrimarySpawnWeapon);
  self applyLoadout();
}

giveDefaultPerks() {
  self.spawnPerk = false;
  if(!self _hasPerk("specialty_blindeye") && self.avoidKillstreakOnSpawnTimer > 0) {
    self thread maps\mp\perks\_perks::giveBlindEyeAfterspawn();
  }

  if((!isDefined(level.isHorde) || !level.isHorde) && !level.isZombieGame) {
    self givePerk("specialty_marathon", false);
  }

  self givePerk("specialty_falldamage", false);
}

recordValidationInfraction() {
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] += 1;
  }
}

_detachAll() {
  self.frontShieldModel = undefined;
  self.backShieldModel = undefined;
  self.headModel = undefined;

  self detachAll();
}

giveOffhand(offhandWeapon) {
  shortWeapon = maps\mp\_utility::strip_suffix(offhandWeapon, "_lefthand");

  switch (shortWeapon) {
    case "none":
    case "specialty_null":
      break;

    case "trophy_mp":
    case "frag_grenade_mp":
    case "semtex_mp":
    case "bouncingbetty_mp":
    case "claymore_mp":
    case "c4_mp":
    case "tri_drone_mp":
    case "throwingknife_mp":
    case "exoknife_mp":
    case "explosive_gel_mp":
    case "exoknife_jug_mp":
      self givePerk(offhandWeapon, false);
      break;

    case "portable_radar_mp":
    case "s1_tactical_insertion_device_mp":
    case "scrambler_mp":
    case "flash_grenade_mp":
    case "concussion_grenade_mp":
    case "stun_grenade_mp":
    case "paint_grenade_mp":
    case "emp_grenade_mp":
    case "smoke_grenade_mp":
    case "tracking_drone_mp":
    case "explosive_drone_mp":
    case "fast_heal_mp":
    case "mute_bomb_mp":
    case "stun_grenade_var_mp":
    case "emp_grenade_var_mp":
    case "paint_grenade_var_mp":
    case "smoke_grenade_var_mp":
      self giveWeapon(offhandWeapon);
      break;

    case "exoshield_equipment_mp":
      self maps\mp\_exo_shield::give_exo_shield();
      break;
    case "adrenaline_mp":
      self maps\mp\_adrenaline::give_exo_overclock();
      break;
    case "extra_health_mp":
      self maps\mp\_extrahealth::give_exo_health();
      break;
    case "exorepulsor_equipment_mp":
      self maps\mp\_exo_repulsor::give_exo_repulsor();
      break;
    case "exocloak_equipment_mp":
      self maps\mp\_exo_cloak::give_exo_cloak();
      break;
    case "exoping_equipment_mp":
      self maps\mp\_exo_ping::give_exo_ping();
      break;
    case "exohover_equipment_mp":
      self maps\mp\_exo_hover::give_exo_hover();
      break;
    case "exomute_equipment_mp":
      self maps\mp\_exo_mute::give_exo_mute();
      break;
    case "iw5_dlcgun12loot7_mp":
      self maps\mp\_grappling_hook::give_grappling_hook();
      break;

    default:
      assertmsg("Unknown offhand weapon " + offhandWeapon);
  }
}

takeOffhand(offhandWeapon) {
  shortWeapon = maps\mp\_utility::strip_suffix(offhandWeapon, "_lefthand");

  switch (shortWeapon) {
    case "none":
    case "specialty_null":
      break;

    case "trophy_mp":
    case "s1_tactical_insertion_device_mp":
    case "frag_grenade_mp":
    case "semtex_mp":
    case "bouncingbetty_mp":
    case "claymore_mp":
    case "c4_mp":
    case "tri_drone_mp":
    case "throwingknife_mp":
    case "exoknife_mp":
    case "explosive_gel_mp":
    case "exoknife_jug_mp":
      self _unsetPerk(offhandWeapon);
      break;

    case "portable_radar_mp":
    case "scrambler_mp":
    case "flash_grenade_mp":
    case "concussion_grenade_mp":
    case "stun_grenade_mp":
    case "paint_grenade_mp":
    case "emp_grenade_mp":
    case "smoke_grenade_mp":
    case "tracking_drone_mp":
    case "explosive_drone_mp":
    case "fast_heal_mp":
    case "mute_bomb_mp":
    case "stun_grenade_var_mp":
    case "emp_grenade_var_mp":
    case "paint_grenade_var_mp":
    case "smoke_grenade_var_mp":
      self TakeWeapon(offhandWeapon);
      break;

    case "exoshield_equipment_mp":
      self maps\mp\_exo_shield::take_exo_shield();
      break;
    case "adrenaline_mp":
      self maps\mp\_adrenaline::take_exo_overclock();
      break;
    case "extra_health_mp":
      self maps\mp\_extrahealth::take_exo_health();
      break;
    case "exorepulsor_equipment_mp":
      self maps\mp\_exo_repulsor::take_exo_repulsor();
      break;
    case "exocloak_equipment_mp":
      self maps\mp\_exo_cloak::take_exo_cloak();
      break;
    case "exoping_equipment_mp":
      self maps\mp\_exo_ping::take_exo_ping();
      break;
    case "exohover_equipment_mp":
      self maps\mp\_exo_hover::take_exo_hover();
      break;
    case "exomute_equipment_mp":
      self maps\mp\_exo_mute::take_exo_mute();
      break;
    case "iw5_dlcgun12loot7_mp":
      self maps\mp\_grappling_hook::take_grappling_hook();
      break;

    default:
      assertmsg("Unknown offhand weapon " + offhandWeapon);
  }

}

loadoutAllPerks(loadoutEquipment, loadoutPerks) {
  for(i = 0; i < 6; i++) {
    loadoutPerks[i] = maps\mp\perks\_perks::validatePerk(i, loadoutPerks[i]);
  }

  for(i = 0; i < 6; i++) {
    if(loadoutPerks[i] != "specialty_null") {
      self givePerk(loadoutPerks[i], true, i);
    }
  }

  self.loadoutPerks = loadoutPerks;
  self.loadoutEquipment = loadoutEquipment;
}

loadoutTrackVariableGrenades(class, lethal, tactical) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self notify("loadoutTrackVariableGrenades");
  self endon("loadoutTrackVariableGrenades");

  switch (lethal) {
    case "frag_grenade_var_mp":
    case "semtex_grenade_var_mp":
    case "contact_grenade_var_mp":
    case "stun_grenade_var_mp":
    case "emp_grenade_var_mp":
    case "paint_grenade_var_mp":
    case "smoke_grenade_var_mp":

      if(isDefined(self.prevLethalVarClass) && (self.prevLethalVarClass == class) && isDefined(self.prevLethalVarType) && (self.prevLethalVarType != lethal)) {
        newLethal = self.prevLethalVarType;
        assert(newLethal != "specialty_null");

        self TakeWeapon(lethal);
        self.loadoutEquipment = newLethal;
        self SetLethalWeapon(newLethal);
        self givePerk(newLethal, false);

        lethal = newLethal;
      }

      self.prevLethalVarClass = class;
      self.prevLethalVarType = lethal;
      break;

    default:

      self.prevLethalVarClass = undefined;
      self.prevLethalVarType = undefined;
      break;
  }

  shortTactical = maps\mp\_utility::strip_suffix(tactical, "_lefthand");

  switch (shortTactical) {
    case "frag_grenade_var_mp":
    case "semtex_grenade_var_mp":
    case "contact_grenade_var_mp":
    case "stun_grenade_var_mp":
    case "emp_grenade_var_mp":
    case "paint_grenade_var_mp":
    case "smoke_grenade_var_mp":

      if(isDefined(self.prevTacticalVarClass) && (self.prevTacticalVarClass == class) && isDefined(self.prevTacticalVarType) && (self.prevTacticalVarType != tactical)) {
        newTactical = self.prevTacticalVarType;
        assert(newTactical != "specialty_null");

        self TakeWeapon(tactical);
        self.loadoutOffhand = newTactical;
        self SetTacticalWeapon(newTactical);
        self givePerk(newTactical, false);

        tactical = newTactical;
      }

      self.prevTacticalVarClass = class;
      self.prevTacticalVarType = tactical;
      break;

    default:

      self.prevTacticalVarClass = undefined;
      self.prevTacticalVarType = undefined;
      break;
  }

  while(1) {
    self waittill("switched_var_grenade", newWeapon);
    if(IsSubStr(newWeapon, "_lefthand")) {
      self.prevTacticalVarType = newWeapon;
    } else {
      self.prevLethalVarType = newWeapon;
    }
  }
}

isExoXMG(baseName) {
  if(IsSubStr(baseName, "_exoxmg")) {
    return true;
  }

  return false;
}

isSac3(baseName) {
  if(IsSubStr(baseName, "sac3")) {
    return true;
  }

  return false;
}

isMahem(baseName) {
  if(IsSubStr(baseName, "mahem")) {
    return true;
  }

  return false;
}

needsScopeOverride(baseName, attachments) {
  isSniperWeapon = getWeaponClass(baseName) == "weapon_sniper";
  if(isSniperWeapon && !anyAttachmentIsScope(attachments)) {
    return true;
  }
  return false;
}

anyAttachmentIsScope(attachments) {
  foreach(a in attachments) {
    if(getAttachmentType(a) == "rail" || a == "zoomscope" || a == "ironsights") {
      return true;
    }
  }
  return false;
}

addAutomaticAttachments(weaponName, currentAttachments) {
  attachments = [];
  baseName = getBaseWeaponName(weaponName);

  if(needsScopeOverride(baseName, currentAttachments)) {
    bareName = baseName;
    if(IsSubStr(baseName, "iw5_") || IsSubStr(baseName, "iw6_")) {
      endIndex = baseName.size;
      bareName = GetSubStr(baseName, 4, endIndex);
    }

    scopeName = getBaseFromLootVersion(bareName) + "scope";
    attachments[attachments.size] = scopeName;
  }

  if(isExoXMG(baseName)) {
    attachments[attachments.size] = "akimboxmg";
  }

  if(isSac3(baseName)) {
    attachments[attachments.size] = "akimbosac3";
  }

  if(isMahem(baseName)) {
    attachments[attachments.size] = "mahemscopebase";
  }

  return attachments;
}

processAttachments(attachments, baseName) {
  size = attachments.size;

  if(size > 1) {
    attachments = alphabetize(attachments);
  }

  autoAttachments = addAutomaticAttachments(baseName, attachments);
  attachments = array_combine(attachments, autoAttachments);

  return attachments;
}

array_CheckAddAttachment(arr, a) {
  if(isDefined(a) && a != "none") {
    arr[arr.size] = a;
  }
  return arr;
}

getBaseFromLootVersion(lootName) {
  j = 0;

  matches = [];
  matches[0] = "loot";
  matches[1] = "gold";
  matches[2] = "atlas";
  matches[3] = "blops2";
  matches[4] = "ghosts";

  foreach(match in matches) {
    for(i = 0; i < lootName.size; i++) {
      if(tolower(lootName[i]) != tolower(match[j])) {
        i = i - j;
        j = 0;
      } else {
        j++;
        if(j == match.size) {
          break;
        }
      }
    }
    if(j == match.size) {
      lootName = GetSubStr(lootName, 0, i - j + 1);
      break;
    } else {
      j = 0;
    }
  }

  return lootName;
}

buildWeaponName(baseName, attachment1, attachment2, attachment3, camo, reticle) {
  if(!isDefined(baseName) || baseName == "none") {
    return baseName;
  }

  if(!isDefined(level.letterToNumber)) {
    level.letterToNumber = makeLettersToNumbers();
  }

  if(isDefined(reticle) && reticle != 0 && getAttachmentType(attachment1) != "rail" && getAttachmentType(attachment2) != "rail" && getAttachmentType(attachment3) != "rail") {
    reticle = undefined;
  }

  attachment1 = attachmentMap_toUnique(attachment1, baseName);
  attachment2 = attachmentMap_toUnique(attachment2, baseName);
  attachment3 = attachmentMap_toUnique(attachment3, baseName);

  bareWeaponName = "";

  if(isSubstr(baseName, "iw5_")) {
    weaponName = baseName + "_mp";
    endIndex = baseName.size;
    bareWeaponName = GetSubStr(baseName, 4, endIndex);
  } else {
    weaponName = baseName;
    bareWeaponName = baseName;
  }

  attachments = [];
  attachments = array_CheckAddAttachment(attachments, attachment1);
  attachments = array_CheckAddAttachment(attachments, attachment2);
  attachments = array_CheckAddAttachment(attachments, attachment3);

  attachments = processAttachments(attachments, baseName);

  if(isDefined(attachments[0]) && attachments[0] == "vzscope") {
    attachments[0] = bareWeaponName + "scopevz";
  } else if(isDefined(attachments[1]) && attachments[1] == "vzscope") {
    attachments[1] = bareWeaponName + "scopevz";
  } else if(isDefined(attachments[2]) && attachments[2] == "vzscope") {
    attachments[2] = bareWeaponName + "scopevz";
  }

  if(isDefined(attachments.size) && attachments.size) {
    i = 0;
    while(i < attachments.size) {
      if(isDefined(attachments[i + 1]) && is_later_in_alphabet(attachments[i], attachments[i + 1])) {
        tmpAtch = attachments[i];
        attachments[i] = attachments[i + 1];
        attachments[i + 1] = tmpAtch;
        i = 0;
        continue;
      }
      i++;
    }
  }

  foreach(attachment in attachments) {
    weaponName += "_" + attachment;
  }

  if(isSubstr(weaponName, "iw5_")) {
    weaponName = buildWeaponNameCamo(weaponName, camo);
    weaponName = buildWeaponNameReticle(weaponName, reticle);
    return (weaponName);
  } else if(!isValidWeapon(weaponName + "_mp")) {
    return (baseName + "_mp");
  } else {
    weaponName = buildWeaponNameCamo(weaponName, camo);
    weaponName = buildWeaponNameReticle(weaponName, reticle);
    return (weaponName + "_mp");
  }
}

buildWeaponNameCamo(weaponName, camo) {
  if(!isDefined(camo)) {
    return weaponName;
  }
  if(camo <= 0) {
    return weaponName;
  }

  if(camo < 10) {
    weaponName += "_camo0";
  } else {
    weaponName += "_camo";
  }
  weaponName += camo;

  return weaponName;
}

buildWeaponNameReticle(weaponName, reticle) {
  if(!isDefined(reticle)) {
    return weaponName;
  }
  if(reticle <= 0) {
    return weaponName;
  }

  weaponName += "_scope";
  weaponName += reticle;

  return weaponName;
}

makeLettersToNumbers() {
  array = [];

  array["a"] = 0;
  array["b"] = 1;
  array["c"] = 2;
  array["d"] = 3;
  array["e"] = 4;
  array["f"] = 5;
  array["g"] = 6;
  array["h"] = 7;
  array["i"] = 8;
  array["j"] = 9;
  array["k"] = 10;
  array["l"] = 11;
  array["m"] = 12;
  array["n"] = 13;
  array["o"] = 14;
  array["p"] = 15;
  array["q"] = 16;
  array["r"] = 17;
  array["s"] = 18;
  array["t"] = 19;
  array["u"] = 20;
  array["v"] = 21;
  array["w"] = 22;
  array["x"] = 23;
  array["y"] = 24;
  array["z"] = 25;

  return array;
}

setKillstreaks(streak1, streak2, streak3, streak4, cacLoadout, practiceLoadout, copyCatLoadout, isGameModeClass, teamName, overrideModules) {
  self.killStreaks = [];
  self.killStreakModules = [];

  killStreaks = [];

  streak_array = [streak1, streak2, streak3, streak4];

  killstreakIndex = 0;
  foreach(streak in streak_array) {
    if(isDefined(streak) && streak != "none") {
      maxModules = 3;

      if(copyCatLoadout) {
        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = self.pers["copyCatLoadout"]["loadoutKillstreakModules"][killstreakIndex][moduleIndex];
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      } else if(isDefined(teamName) && teamName != "none") {
        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = getMatchRulesData("defaultClasses", teamName, self.class_num, "class", "assaultStreaks", killstreakIndex, "modules", moduleIndex);
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      } else if(cacLoadout) {
        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = self getCaCPlayerData(self.class_num, "assaultStreaks", killstreakIndex, "modules", moduleIndex);
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      } else if(practiceLoadout) {
        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = table_getKillstreakModule(level.practiceRoundClassTableName, self.class_num, killstreakIndex, moduleIndex);
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      } else if(isDefined(overrideModules)) {
        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = overrideModules[killstreakIndex][moduleIndex];
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      } else if(isDefined(self.class_num)) {
        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = table_getKillstreakModule(level.classTableName, self.class_num, killstreakIndex, moduleIndex);
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      } else if(isDefined(isGameModeClass)) {
        modules = self.pers["gamemodeLoadout"]["loadoutKillstreakModules"];

        for(moduleIndex = 0; moduleIndex < maxModules; moduleIndex++) {
          module = modules[killstreakIndex][moduleIndex];
          if(isDefined(module) && module != "none") {
            cost = maps\mp\killstreaks\_killstreaks::getStreakModuleCost(module);
            self.killStreakModules[module] = cost;
          }
        }
      }

      streakVal = self maps\mp\killstreaks\_killstreaks::getStreakCost(streak);

      while(isDefined(killStreaks[streakVal])) {
        streakVal++;
      }

      killStreaks[streakVal] = streak;
    }
    killstreakIndex++;
  }

  maxVal = 0;
  foreach(streakVal, streakName in killStreaks) {
    if(streakVal > maxVal) {
      maxVal = streakVal;
    }
  }

  for(streakIndex = 0; streakIndex <= maxVal; streakIndex++) {
    if(!isDefined(killStreaks[streakIndex])) {
      continue;
    }

    streakName = killStreaks[streakIndex];

    self.killStreaks[streakIndex] = killStreaks[streakIndex];
  }

}

replenishLoadout() {
  team = self.pers["team"];
  class = self.pers["class"];

  weaponsList = self GetWeaponsListAll();
  for(idx = 0; idx < weaponsList.size; idx++) {
    weapon = weaponsList[idx];

    self giveMaxAmmo(weapon);
    self SetWeaponAmmoClip(weapon, 9999);

    if(weapon == "claymore_mp" || weapon == "claymore_detonator_mp") {
      self setWeaponAmmoStock(weapon, 2);
    }
  }

  if(self getAmmoCount(level.classGrenades[class]["primary"]["type"]) < level.classGrenades[class]["primary"]["count"]) {
    self SetWeaponAmmoClip(level.classGrenades[class]["primary"]["type"], level.classGrenades[class]["primary"]["count"]);
  }

  if(self getAmmoCount(level.classGrenades[class]["secondary"]["type"]) < level.classGrenades[class]["secondary"]["count"]) {
    self SetWeaponAmmoClip(level.classGrenades[class]["secondary"]["type"], level.classGrenades[class]["secondary"]["count"]);
  }
}

onPlayerConnecting() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["class"])) {
      player.pers["class"] = "";
    }
    if(!isDefined(player.pers["lastClass"])) {
      player.pers["lastClass"] = "";
    }
    player.class = player.pers["class"];
    player.lastClass = player.pers["lastClass"];
    player.detectExplosives = false;
    player.bombSquadIcons = [];
    player.bombSquadIds = [];
  }
}

fadeAway(waitDelay, fadeDelay) {
  wait waitDelay;

  self fadeOverTime(fadeDelay);
  self.alpha = 0;
}

setClass(newClass) {
  self.curClass = newClass;
}

assignPracticeRoundClasses() {
  if(!isDefined(level.practiceRoundClasses)) {
    level.practiceRoundClasses = [];
    level.practiceRoundClassOrder = [];

    num_columns = TableGetColumnCount(level.practiceRoundClassTableName);
    for(i = 1; i < num_columns; i++) {
      class_type = TableLookupByRow(level.practiceRoundClassTableName, 0, i);
      if(isDefined(level.practiceRoundClasses[class_type])) {
        level.practiceRoundClasses[class_type][level.practiceRoundClasses[class_type].size] = i - 1;
      } else {
        level.practiceRoundClasses[class_type][0] = i - 1;
      }
    }

    class_types = GetArrayKeys(level.practiceRoundClasses);
    class_types = alphabetize(class_types);
    for(i = 0; i < class_types.size; i++) {
      level.practiceRoundClassOrder[class_types[i]] = i;
    }
  }

  self.pers["practiceRoundClasses"] = [];
  foreach(class_type, class_indices in level.practiceRoundClasses) {
    class_slot = 0;
    if(isDefined(level.practiceRoundClassOrder[class_type])) {
      class_slot = level.practiceRoundClassOrder[class_type];
    }

    class_column = 0;
    class_type_index = RandomIntRange(0, class_indices.size);
    if(isDefined(class_indices[class_type_index])) {
      class_column = class_indices[class_type_index];
    }

    self.pers["practiceRoundClasses"][class_slot] = class_column;
    self SetRankedPlayerData("practiceRoundClassMap", class_slot, self.pers["practiceRoundClasses"][class_slot]);
  }
}

getPracticeRoundClass(slot_num) {
  assert(slot_num >= 0 && slot_num < 5);
  return self.pers["practiceRoundClasses"][slot_num];
}

loadoutValidForCopycat(attacker) {
  if(!practiceRoundGame()) {
    return false;
  }

  my_class_name = self.class;
  my_class_num = getClassIndex(my_class_name);
  if(!isDefined(my_class_name) || !isDefined(my_class_num)) {
    return false;
  }

  my_class_is_default = true;
  if(my_class_num == -1) {
    my_class_name = self.pers["copyCatLoadout"]["className"];
    my_class_num = getClassIndex(my_class_name);
    if(IsSubStr(my_class_name, "practice")) {
      my_class_num = self.pers["copyCatLoadout"]["practiceClassNum"];
      my_class_is_default = false;
    }
  } else if(IsSubStr(my_class_name, "practice")) {
    my_class_num = self.pers["practiceRoundClasses"][my_class_num];
    my_class_is_default = false;
  } else if(my_class_name == "callback") {
    return true;
  }

  attacker_class_name = attacker.class;
  attacker_class_num = getClassIndex(attacker_class_name);
  if(!isDefined(attacker_class_name) || !isDefined(attacker_class_num)) {
    return false;
  }

  attacker_class_is_default = true;
  if(attacker_class_num == -1) {
    attacker_class_name = attacker.pers["copyCatLoadout"]["className"];
    attacker_class_num = getClassIndex(attacker_class_name);
    if(IsSubStr(attacker_class_name, "practice")) {
      attacker_class_num = attacker.pers["copyCatLoadout"]["practiceClassNum"];
      attacker_class_is_default = false;
    }
  } else if(IsSubStr(attacker_class_name, "practice")) {
    attacker_class_num = attacker.pers["practiceRoundClasses"][attacker_class_num];
    attacker_class_is_default = false;
  } else if(attacker_class_name == "callback") {
    return true;
  }

  return ((my_class_num != attacker_class_num) || (my_class_is_default != attacker_class_is_default));
}

setCopyCatLoadout(attacker) {
  if(!practiceRoundGame()) {
    return;
  }

  assert(isDefined(attacker));

  self.class = "copycat";
  self.pers["class"] = "copycat";

  loadout = attacker cloneLoadout();
  self.pers["copyCatLoadout"] = loadout;

  self.pers["copyCatLoadout"]["inUse"] = true;
}

clearCopyCatLoadout() {
  self.pers["copyCatLoadout"]["inUse"] = false;
}

isValidPrimary(refString) {
  if(isLootWeapon(refString)) {
    refString = getBaseFromLootVersion(refString);
  }
  switch (refString) {
    case "riotshield":
    case "iw5_mp5":
    case "iw5_pp90m1":
    case "iw5_barrett":
    case "iw5_msr":
    case "iw5_spas12":
    case "iw5_riotshieldt6":
    case "iw5_riotshieldjugg":
    case "iw5_exoshield":

    case "iw5_ak12":
    case "iw5_ak12ghosts":
    case "iw5_bal27":
    case "iw5_bal27atlas":
    case "iw5_hbra3":
    case "iw5_lsat":
    case "iw5_himar":
    case "iw5_arx160":
    case "iw5_m182spr":
    case "iw5_asaw":

    case "iw5_mp11":
    case "iw5_sn6":
    case "iw5_hmr9":
    case "iw5_sac3":
    case "iw5_asm1":
    case "iw5_kf5":

    case "iw5_m990":
    case "iw5_mors":
    case "iw5_gm6":
    case "iw5_thor":

    case "iw5_maul":
    case "iw5_rhino":
    case "iw5_uts19":

    case "iw5_em1":
    case "iw5_em1gold":
    case "iw5_em1atlas":
    case "iw5_epm3":

    case "iw5_combatknife":

    case "iw5_microdronelauncher":

    case "iw5_juggtitan45":
    case "iw5_exoxmgjugg":
    case "iw5_exoxmg":
    case "iw5_exominigun":
    case "iw5_mechpunch":

    case "iw5_dlcgun1":
      return true;
    default:
      self recordValidationInfraction();
      return false;
  }
}

isValidSecondary(refString, isPrimary) {
  if(isDefined(isPrimary) && isPrimary) {
    return isValidPrimary(refString);
  }

  if(isLootWeapon(refString)) {
    refString = getBaseFromLootVersion(refString);
  }

  switch (refString) {
    case "iw5_usp45":
    case "m320":
    case "rpg":
    case "stinger":

    case "iw5_usp45jugg":
    case "iw5_mp412jugg":

    case "iw5_spas12":

    case "iw5_vbr":
    case "iw5_pbw":
    case "iw5_rw1":
    case "iw5_titan45":

    case "iw5_maaws":
    case "iw5_mahem":
    case "iw5_stingerm7":

    case "iw5_combatknife":

    case "iw5_titan45loot0":
    case "iw5_titan45loot1":
    case "iw5_titan45loot2":
    case "iw5_titan45loot3":
    case "iw5_titan45loot4":
    case "iw5_titan45loot5":
    case "iw5_titan45loot6":
    case "iw5_titan45loot7":
    case "iw5_titan45loot8":
    case "iw5_titan45loot9":
    case "iw5_titan45atlas":

    case "iw5_exocrossbow":
    case "iw5_exocrossbowblops2":

    case "iw5_juggtitan45_mp":
    case "iw5_mechpunch":

    case "none":
      return true;
    default:
      self recordValidationInfraction();
      return false;
  }
}

isValidAttachment(refString, weaponName, shouldAssert) {
  result = false;

  if(!isDefined(shouldAssert)) {
    shouldAssert = true;
  }

  switch (refString) {
    case "none":
    case "acog":
    case "acogsmg":
    case "reflex":
    case "reflexsmg":
    case "reflexlmg":
    case "silencer":
    case "silencer02":
    case "silencer03":
    case "grip":
    case "gp25":
    case "m320":
    case "akimbo":
    case "thermal":
    case "thermalsmg":
    case "shotgun":
    case "heartbeat":
    case "fmj":
    case "rof":
    case "xmags":
    case "dualmag":
    case "eotech":
    case "eotechsmg":
    case "eotechlmg":
    case "tactical":
    case "scopevz":
    case "hamrhybrid":
    case "hybrid":
    case "zoomscope":
    case "parabolicmicrophone":
    case "opticsreddot":
    case "opticsacog2":
    case "opticseotech":
    case "opticsthermal":
    case "silencer01":
    case "sensorheartbeat":
    case "foregrip":
    case "variablereddot":
    case "directhack":
    case "opticstargetenhancer":
    case "firerate":
    case "longrange":
    case "quickdraw":
    case "stock":
    case "lasersight":
    case "morsscopevz":
    case "gm6scopevz":
    case "thorscopevz":
    case "m990scopevz":
    case "trackrounds":
    case "stabilizer":
    case "heatsink":
    case "ironsights":
    case "shieldfastmelee":
    case "shieldfastplant":
    case "shieldshockplant":
    case "akimboxmg":
    case "akimbosac3":
    case "rw1scopebase":
    case "morsstabilizer":
    case "gm6stabilizer":
    case "m990stabilizer":
    case "thorstabilizer":
    case "gl":
    case "mahemscopebase":
    case "crossbowscopebase":
    case "silencerpistol":
    case "silencersniper":
      result = true;
      break;
    default:
      result = false;
      break;
  }

  if(result && refString != "none") {
    validAttachments = getWeaponAttachmentArrayFromStats(weaponName);
    result = array_contains(validAttachments, refString);
  }

  if(!result && shouldAssert) {
    self recordValidationInfraction();
    AssertMsg("Replacing invalid equipment weapon: " + refString);
  }

  return result;
}

isAttachmentUnlocked(weaponRef, attachmentRef) {
  if(GetDvarInt("unlockAllItems")) {
    return true;
  }

  if(isMLGMatch()) {
    return true;
  }

  baseWeaponRef = getBaseFromLootVersion(weaponRef);
  itemRef = baseWeaponRef + " " + attachmentRef;
  if(!self isItemUnlocked(itemRef)) {
    return false;
  }

  return true;
}

isValidCamo(refString, dont_assert) {
  switch (refString) {
    case "none":
    case "multicame":
    case "multicamd":
    case "urban":
    case "stranden":
    case "wooldand":
    case "raid":
    case "digital3":
    case "highlander":
    case "yeti":
    case "digital1":
    case "concrete":
    case "urbanjet":
    case "neptune":
    case "tiger":
    case "carbon":
    case "gold":
    case "diamond":
    case "sentinel":
      return true;
    case "camo01":
    case "camo02":
    case "camo03":
    case "camo04":

      return true;
    default:
      self recordValidationInfraction();
      if(!isDefined(dont_assert) || !dont_assert) {
        assertMsg("Replacing invalid camo: " + refString);
      }
      return false;
  }
}

isValidReticle(refString, dont_assert) {
  switch (refString) {
    case "none":
    case "ret1":
    case "ret2":
    case "ret3":
    case "ret4":
    case "ret5":
    case "ret6":
    case "ret7":
    case "ret8":
    case "ret9":
    case "retdlc01":
    case "retdlc02":
    case "retdlc03":
    case "retdlc04":
    case "retdlc05":
    case "retdlc06":
    case "retdlc07":
    case "retdlc08":
    case "retdlc09":
    case "retdlc10":
    case "retdlc11":
    case "retdlc12":
      return true;
    default:
      self recordValidationInfraction();
      if(!isDefined(dont_assert) || !dont_assert) {
        assertMsg("Replacing invalid reticle " + refString);
      }
      return false;
  }
}

isCamoUnlocked(weaponRef, camoRef) {
  if(GetDvarInt("unlockAllItems")) {
    return true;
  }

  if(isMLGMatch()) {
    return true;
  }

  baseWeaponRef = getBaseFromLootVersion(weaponRef);
  itemRef = baseWeaponRef + " " + camoRef;
  if(!self isItemUnlocked(itemRef)) {
    return false;
  }

  return true;
}

isValidEquipment(refString, isOffhand) {
  if(isOffhand) {
    return isValidOffhand(refString, false);
  }

  refString = maps\mp\_utility::strip_suffix(refString, "_lefthand");

  switch (refString) {
    case "specialty_null":
    case "frag_grenade_mp":
    case "semtex_mp":
    case "throwingknife_mp":
    case "exoknife_mp":
    case "claymore_mp":
    case "c4_mp":
    case "bouncingbetty_mp":
    case "tri_drone_mp":
    case "explosive_gel_mp":
    case "frag_grenade_var_mp":
    case "contact_grenade_var_mp":
    case "semtex_grenade_var_mp":
    case "stun_grenade_var_mp":
    case "emp_grenade_var_mp":
    case "paint_grenade_var_mp":
    case "smoke_grenade_var_mp":
    case "flash_grenade_mp":
    case "concussion_grenade_mp":
    case "stun_grenade_mp":
    case "smoke_grenade_mp":
    case "emp_grenade_mp":
    case "trophy_mp":
    case "scrambler_mp":
    case "portable_radar_mp":
    case "paint_grenade_mp":
    case "tracking_drone_mp":
    case "explosive_drone_mp":
    case "mute_bomb_mp":
    case "exoknife_jug_mp":
    case "s1_tactical_insertion_device_mp":
      return true;
    default:
      self recordValidationInfraction();

      return false;
  }
}

isValidOffhand(refString, isEquipment) {
  if(isEquipment) {
    return isValidEquipment(refString, false);
  }

  refString = maps\mp\_utility::strip_suffix(refString, "_lefthand");

  switch (refString) {
    case "none":
    case "specialty_null":
    case "exocloak_equipment_mp":
    case "exoping_equipment_mp":
    case "exoboost_equipment_mp":
    case "exododge_equipment_mp":
    case "exoslide_equipment_mp":
    case "exorepulsor_equipment_mp":
    case "exoshield_equipment_mp":
    case "adrenaline_mp":
    case "extra_health_mp":
    case "fast_heal_mp":
    case "exohover_equipment_mp":
    case "exomute_equipment_mp":
      return true;
    default:
      self recordValidationInfraction();

      return false;
  }
}

isValidWeapon(refString) {
  if(!isDefined(level.weaponRefs)) {
    level.weaponRefs = [];

    foreach(weaponRef in level.weaponList) {
      level.weaponRefs[weaponRef] = true;
    }
  }

  if(isDefined(level.weaponRefs[refString])) {
    return true;
  }

  self recordValidationInfraction();
  assertMsg("Replacing invalid weapon/attachment combo: " + refString);

  return false;
}

isValidKillstreak(refString) {
  switch (refString) {
    case "uav":
    case "missile_strike":
    case "orbital_strike":
    case "orbital_strike_chem":
    case "orbital_strike_laser":
    case "orbital_strike_laser_chem":
    case "orbital_strike_cluster":
    case "orbital_strike_drone":
    case "orbital_carepackage":
    case "sentry":
    case "airdrop_assault":
    case "airdrop_sentry_minigun":
    case "emp":
    case "airdrop_trap":
    case "airdrop_reinforcement_common":
    case "airdrop_reinforcement_uncommon":
    case "airdrop_reinforcement_rare":
    case "airdrop_reinforcement_practice":
    case "directional_uav":
    case "remote_mg_turret":
    case "remote_mg_sentry_turret":
    case "map_killstreak":
    case "mp_prison":
    case "mp_recovery":
    case "mp_lab2":
    case "mp_solar":
    case "mp_torqued":
    case "mp_laser2":
    case "mp_dam":
    case "mp_refraction":
    case "mp_greenband":
    case "mp_instinct":
    case "mp_odium":
    case "mp_recreation":
    case "mp_levity":
    case "mp_terrace":
    case "mp_comeback":
    case "mp_lost":
    case "warbird":
    case "recon_ugv":
    case "assault_ugv":
    case "orbitalsupport":
    case "heavy_exosuit":
    case "drone_carepackage":
    case "next_gen_exo":
    case "strafing_run_airstrike":
    case "zm_camouflage":

    case "none":
      return true;
    default:
      self recordValidationInfraction();
      assertMsg("Replacing invalid killstreak: " + refString);
      return false;
  }
}