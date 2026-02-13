/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1981.gsc
*************************************************/

init() {
  level._id_3803["class0"] = 0;
  level._id_3803["class1"] = 1;
  level._id_3803["class2"] = 2;
  level._id_3803["custom1"] = 0;
  level._id_3803["custom2"] = 1;
  level._id_3803["custom3"] = 2;
  level._id_3803["custom4"] = 3;
  level._id_3803["custom5"] = 4;
  level._id_3803["custom6"] = 5;
  level._id_3803["custom7"] = 6;
  level._id_3803["custom8"] = 7;
  level._id_3803["custom9"] = 8;
  level._id_3803["custom10"] = 9;
  level._id_3803["custom11"] = 10;
  level._id_3803["custom12"] = 11;
  level._id_3803["axis_recipe1"] = 0;
  level._id_3803["axis_recipe2"] = 1;
  level._id_3803["axis_recipe3"] = 2;
  level._id_3803["axis_recipe4"] = 3;
  level._id_3803["axis_recipe5"] = 4;
  level._id_3803["axis_recipe6"] = 5;
  level._id_3803["allies_recipe1"] = 0;
  level._id_3803["allies_recipe2"] = 1;
  level._id_3803["allies_recipe3"] = 2;
  level._id_3803["allies_recipe4"] = 3;
  level._id_3803["allies_recipe5"] = 4;
  level._id_3803["allies_recipe6"] = 5;
  level._id_3803["gamemode"] = 0;
  level._id_3803["callback"] = 0;
  level._id_3803["default1"] = 0;
  level._id_3803["default2"] = 1;
  level._id_3803["default3"] = 2;
  level._id_3803["default4"] = 3;
  level._id_3803["default5"] = 4;
  level._id_3803["default6"] = 5;
  level._id_3803["default7"] = 6;
  level._id_3803["default8"] = 7;
  level._id_3803["default9"] = 8;
  level._id_3803["default10"] = 9;
  level._id_3803["default11"] = 10;
  level._id_3803["default12"] = 11;
  level._id_3803["juggernaut"] = 0;
  level._id_45A8 = "CLASS_ASSAULT";

  if(level.gametype == "br") {
    level._id_3809 = "mp/classtable_br_default.csv";
  } else if(getdvarint("#x38475eca840c2144b", 0)) {
    level._id_3809 = "mp/classtable_test.csv";
  } else if(scripts\mp\utility\game::isanymlgmatch()) {
    level._id_3809 = "mp/classtable_cdl.csv";
  } else {
    level._id_3809 = "mp/classtable.csv";
  }

  level thread _id_AB5E();
  level thread onplayerspawned();
  setDvar("#x3705e89a2e46c93c", 1.0);
  setDvar("#x3d470ff7eff177ba6", 300);
  setDvar("#x3466301d58964e3de", 550);
}

_id_6960(var_0) {
  return var_0;
}

_id_6E6C(var_0) {
  var_1 = strtok(var_0, ",");

  if(var_1.size > 1) {
    return int(var_1[1]);
  } else {
    return 0;
  }
}

_id_2E8D(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "weapon");
}

_id_2E8E(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "attachment");
}

_id_2E8F(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "variantID");
}

_id_2E92(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "lootItemID");
}

_id_2E95(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "variantID");
}

_id_2E90(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "camo");
}

_id_2E93(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "reticle");
}

_id_2E86(var_0, var_1) {
  var_2 = self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_0, "killstreak");
  return var_2;
}

_id_2E7E() {
  if(isDefined(self._id_33DA)) {
    return self._id_33DA._id_1A35;
  }

  return "archetype_assault";
}

_id_2E7F(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "equipment");
}

_id_2E82(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "extraCharge");
}

_id_2E80(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "equipment");
}

_id_2E83(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "extraCharge");
}

_id_2E8B() {
  if(isDefined(self._id_33DA)) {
    return self._id_33DA._id_EB09;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
}

_id_2E84(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "fieldUpgrades", var_0);
}

_id_2E85() {
  var_0 = "none";

  if(isDefined(self._id_33DA)) {
    var_1 = level._id_1A39[self._id_33DA._id_1A35];
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var_1, "gesture");
  } else
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");

  return _id_0793::_id_6A6A(var_0);
}

_id_2E7D() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return _id_07A6::_id_687C(var_0);
}

_id_2E7B() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return _id_07A6::_id_6878(var_0);
}

_id_2E7C() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return _id_07A6::_id_687A(var_0);
}

_id_2E89(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", var_1);
}

_id_2E88(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "extraPerks", var_1);
}

_id_2E87() {
  if(isDefined(self._id_33DA)) {
    return self._id_33DA._id_F462;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

_id_2E8C(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "usingSpecialist");
}

_id_2E91(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "cosmeticAttachment");
}

_id_2E94(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "sticker", var_2);
}

_id_C111(var_0, var_1, var_2) {
  return scripts\mp\utility\game::_id_6B32("defaultClasses", var_0, var_1, "class", "kilstreakSetups", var_2, "killstreak");
}

_id_EC5F(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutArchetype", var_1 + 1);
}

_id_EC68(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutName", var_1 + 1);
}

_id_EC6D(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return _func_0222(var_0, 0, "loadoutPrimary", var_1 + 1);
  } else {
    return _func_0222(var_0, 0, "loadoutSecondary", var_1 + 1);
  }
}

_id_EC6E(var_0, var_1, var_2, var_3) {
  var_4 = "none";

  if(var_2 == 0) {
    var_4 = _func_0222(var_0, 0, "loadoutPrimaryAttachment" + (var_3 + 1), var_1 + 1);
  } else {
    var_4 = _func_0222(var_0, 0, "loadoutSecondaryAttachment" + (var_3 + 1), var_1 + 1);
  }

  if(var_4 == "" || var_4 == "none") {
    return "none";
  } else {
    return var_4;
  }
}

_id_EC6F(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return _func_0222(var_0, 0, "loadoutPrimaryCamo", var_1 + 1);
  } else {
    return _func_0222(var_0, 0, "loadoutSecondaryCamo", var_1 + 1);
  }
}

_id_EC70(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return _func_0222(var_0, 0, "loadoutPrimaryReticle", var_1 + 1);
  } else {
    return _func_0222(var_0, 0, "loadoutSecondaryReticle", var_1 + 1);
  }
}

_id_EC69(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, "loadoutPerk" + (var_2 + 1), var_1 + 1);
}

_id_EC65(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, "loadoutExtraPerk" + (var_2 + 1), var_1 + 1);
}

_id_EC60(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutEquipmentPrimary", var_1 + 1);
}

_id_EC63(var_0, var_1) {
  var_2 = _func_0222(var_0, 0, "loadoutExtraEquipmentPrimary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

_id_EC61(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutEquipmentSecondary", var_1 + 1);
}

_id_EC64(var_0, var_1) {
  var_2 = _func_0222(var_0, 0, "loadoutExtraEquipmentSecondary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

_id_EC6C(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutSuper", var_1 + 1);
}

_id_EC6B(var_0, var_1) {
  var_2 = _func_0222(var_0, 0, "loadoutSpecialist", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

_id_EC66(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutGesture", var_1 + 1);
}

_id_EC5E(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutAccessory", var_1 + 1);
}

_id_EC62(var_0, var_1) {
  return _func_0222(var_0, 0, "loadoutExecution", var_1 + 1);
}

_id_EC67(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, "loadoutStreak" + var_2, var_1 + 1);
}

_id_962F(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "streaktype_support":
      var_1 = "support";
      break;
    case "streaktype_specialist":
      var_1 = "specialist";
      break;
    case "streaktype_resource":
      var_1 = "resource";
      break;
    default:
      var_1 = "assault";
  }

  return var_1;
}

_id_6B16(var_0) {
  if(!isDefined(var_0)) {
    return "streaktype_assault";
  }

  switch (var_0) {
    case "support":
      return "streaktype_support";
    case "specialist":
      return "streaktype_specialist";
    case "assault":
      return "streaktype_assault";
    default:
      return "streaktype_assault";
  }
}

_id_962B(var_0) {
  var_1 = undefined;

  if(issubstr(var_0, "axis")) {
    var_1 = "axis";
  } else if(issubstr(var_0, "allies")) {
    var_1 = "allies";
  } else {
    var_1 = "none";
  }

  return var_1;
}

_id_961F(var_0) {
  _id_9621(var_0);
  _id_0BBC(var_0);
  scripts\mp\equipment::_id_391D();

  if(isDefined(self._id_965F)) {
    _id_3976();
  }

  _id_09F1::_id_C474(self._id_965F);
  _id_961E(var_0);
  _id_0A6E::_id_5F00();
  _id_0793::_id_3941();
  _id_0790::_id_0B9E();
  _id_07A6::_id_396B();
  _id_0A6C::_id_AFE5();

  if(!istrue(var_0)) {
    _id_C614();
    _id_C5FE();
  }
}

_id_9620(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = self.primaryweaponobj;
  var_2 = self.secondaryweaponobj;
  wait 1.0;
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
  _id_0BBC(var_0);
  scripts\mp\equipment::_id_391D();

  if(isDefined(self._id_965F)) {
    _id_3976();
  }

  _id_09F1::_id_C474(self._id_965F);
  _id_961E(var_0);
  _id_0A6E::_id_5F00();
  _id_0793::_id_3941();
  _id_0790::_id_0B9E();
  _id_07A6::_id_396B();
  _id_0A6C::_id_AFE5();

  if(!istrue(var_0)) {
    _id_C614();
    _id_C5FE();
  }
}

_id_9621(var_0) {
  if(istrue(var_0)) {
    if(isDefined(self.primaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweaponobj);
    }

    if(isDefined(self.secondaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweaponobj);
    }
  } else
    self takeallweapons();

  self._id_034C = undefined;
  self.primaryweaponobj = undefined;
  self._id_03B5 = undefined;
  self.secondaryweaponobj = undefined;
}

_id_9630(var_0) {
  if(!isDefined(self._id_967F)) {
    self._id_967F = [];
  }

  scripts\mp\utility\perk::_id_6FC2(var_0);
  self._id_967F[self._id_967F.size] = var_0;
}

_id_9636(var_0) {
  if(isDefined(self._id_967F)) {
    var_1 = 0;
    var_2 = [];

    foreach(var_4 in self._id_967F) {
      if(!var_1) {
        if(var_4 == var_0) {
          scripts\mp\utility\perk::removeperk(var_4);
          var_1 = 1;
          continue;
        }
      }

      var_2[var_2.size] = var_4;
    }

    self._id_967F = var_2;
  }
}

_id_961E(var_0) {
  if(istrue(var_0)) {
    if(isDefined(self._id_967F)) {
      foreach(var_2 in self._id_967F) {
        scripts\mp\utility\perk::removeperk(var_2);
      }
    }
  } else {
    scripts\mp\perks\perks::_clearperks();
    self notify("all_perks_cleared");
  }

  self._id_967F = [];
  self notify("loadout_perks_cleared");
}

_id_962A() {
  var_0 = spawnStruct();
  var_0._id_965F = "none";
  var_0._id_9683 = "none";
  var_0._id_9685 = [];
  var_0._id_9684 = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0._id_9685[var_1] = "none";
    var_0._id_9684[var_1] = 0;
  }

  var_0._id_9686 = "none";
  var_0._id_968C = "none";
  var_0._id_9689 = 0;
  var_0._id_968E = -1;
  var_0._id_9687 = "none";
  var_0._id_968D = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0._id_968D[var_2] = "none";
  }

  var_0._id_9692 = "none";
  var_0._id_9694 = [];
  var_0._id_9693 = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0._id_9694[var_1] = "none";
    var_0._id_9693[var_1] = 0;
  }

  var_0._id_9695 = "none";
  var_0._id_969A = "none";
  var_0._id_9698 = 0;
  var_0._id_969C = -1;
  var_0._id_9696 = "none";
  var_0._id_969B = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0._id_969B[var_2] = "none";
  }

  var_0._id_967D = "none";
  var_0._id_9680 = 0;
  var_0._id_967F = [];
  var_0._id_969F = [];
  var_0._id_9670 = [];
  var_0._id_9690 = "specialty_null";
  var_0._id_96A3 = 0;
  var_0._id_966A = "none";
  var_0._id_966E = 0;
  var_0._id_966B = "none";
  var_0._id_966F = 0;
  var_0._id_96A2 = "none";
  var_0._id_9676 = "none";
  var_0._id_965C = "none";
  var_0._id_965E = "none";
  var_0._id_96A0 = 0;
  var_0._id_96A1 = "streaktype_assault";
  var_0._id_9679 = "none";
  var_0._id_967A = "none";
  var_0._id_967B = "none";
  var_0._id_F8D6 = 0;
  var_0._id_60CC = 0;
  var_0._id_87C3 = 0;
  return var_0;
}

_id_9622(var_0) {
  var_1 = spawnStruct();
  var_1._id_965F = var_0._id_965F;
  var_1._id_9683 = var_0._id_9683;
  var_1._id_9685 = var_0._id_9685;
  var_1._id_9684 = var_0._id_9684;
  var_1._id_9686 = var_0._id_9686;
  var_1._id_968C = var_0._id_968C;
  var_1._id_9689 = var_0._id_9689;
  var_1._id_968E = var_0._id_968E;
  var_1._id_9687 = var_0._id_9687;
  var_1._id_968D = var_0._id_968F;
  var_1._id_9692 = var_0._id_9692;
  var_1._id_9694 = var_0._id_9694;
  var_1._id_9693 = var_0._id_9693;
  var_1._id_9695 = var_0._id_9695;
  var_1._id_969A = var_0._id_969A;
  var_1._id_9698 = var_0._id_9698;
  var_1._id_969C = var_0._id_969C;
  var_1._id_9696 = var_0._id_9696;
  var_1._id_969B = var_0._id_969B;
  var_1._id_967D = var_0._id_967D;
  var_1._id_9680 = var_0._id_9680;
  var_1._id_967F = var_0._id_967F;
  var_1._id_969F = var_0._id_969F;
  var_1._id_9670 = var_0._id_9670;
  var_1._id_9690 = var_0._id_9690;
  var_1._id_96A3 = var_0._id_96A3;
  var_1._id_966A = var_0._id_966A;
  var_1._id_966E = var_0._id_966E;
  var_1._id_966B = var_0._id_966B;
  var_1._id_966F = var_0._id_966F;
  var_1._id_96A2 = var_0._id_96A2;
  var_1._id_9676 = var_0._id_9676;
  var_1._id_965C = var_0._id_965C;
  var_1._id_965E = var_0._id_965E;
  var_1._id_96A0 = var_0._id_96A0;
  var_1._id_96A1 = var_0._id_96A1;
  var_1._id_9679 = var_0._id_9679;
  var_1._id_967A = var_0._id_967A;
  var_1._id_967B = var_0._id_967B;
  var_1._id_F8D6 = var_0._id_F8D6;
  var_1._id_60CC = var_0._id_60CC;
  var_1._id_87C3 = var_0._id_87C3;
  var_1 = _id_963A(var_1, "copied");
  return var_1;
}

_id_9644(var_0, var_1, var_2) {
  var_2 = _id_962B(var_1);
  var_3 = _id_6962(var_1);
  self._id_37FF = var_3;
  self._id_380A = var_2;
  var_0._id_965F = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "archetype");
  var_0._id_9683 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "weapon");

  if(var_0._id_9683 == "none") {
    var_0._id_9683 = "s4_me_fists";
  } else {
    for(var_4 = 0; var_4 < 10; var_4++) {
      var_0._id_9685[var_4] = ::scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "attachmentSetup", var_4, "attachment");
    }

    for(var_5 = 0; var_5 < 4; var_5++) {
      var_0._id_968D[var_5] = ::scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "sticker", var_5);
    }
  }

  var_0._id_9686 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "camo");
  var_0._id_968C = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "reticle");
  var_0._id_9692 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "weapon");

  for(var_4 = 0; var_4 < 10; var_4++) {
    var_0._id_9694[var_4] = ::scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "attachmentSetup", var_4, "attachment");
  }

  for(var_5 = 0; var_5 < 4; var_5++) {
    var_0._id_969B[var_5] = ::scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "sticker", var_5);
  }

  var_0._id_9695 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "camo");
  var_0._id_969A = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "reticle");
  var_0._id_967D = "none";
  var_0._id_966A = "none";
  var_0._id_966E = 0;
  var_0._id_966B = "none";
  var_0._id_966F = 0;
  var_0._id_96A2 = "none";
  var_0._id_9676 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_2, var_3, "class", "gesture");
  var_0._id_96A0 = 1;
  var_0._id_9679 = _id_C111(var_2, var_3, 0);
  var_0._id_967A = _id_C111(var_2, var_3, 1);
  var_0._id_967B = _id_C111(var_2, var_3, 2);
}

_id_963C(var_0, var_1) {
  var_2 = _id_6962(var_1);
  self._id_37FF = var_2;
  var_0._id_965F = _id_2E7E();
  var_0._id_9683 = _id_2E8D(var_2, 0);

  for(var_3 = 0; var_3 < 10; var_3++) {
    var_0._id_9685[var_3] = _id_2E8E(var_2, 0, var_3);
    var_0._id_9684[var_3] = _id_2E8F(var_2, 0, var_3);
  }

  var_0._id_9686 = _id_2E90(var_2, 0);
  var_0._id_968C = _id_2E93(var_2, 0);
  var_0._id_9689 = _id_2E92(var_2, 0);
  var_0._id_968E = _id_2E95(var_2, 0);
  var_0._id_9687 = _id_2E91(var_2, 0);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_0._id_968D[var_4] = _id_2E94(var_2, 0, var_4);
  }

  var_0._id_9692 = _id_2E8D(var_2, 1);

  for(var_3 = 0; var_3 < 10; var_3++) {
    var_0._id_9694[var_3] = _id_2E8E(var_2, 1, var_3);
    var_0._id_9693[var_3] = _id_2E8F(var_2, 1, var_3);
  }

  var_0._id_9695 = _id_2E90(var_2, 1);
  var_0._id_969A = _id_2E93(var_2, 1);
  var_0._id_9698 = _id_2E92(var_2, 1);
  var_0._id_969C = _id_2E95(var_2, 1);
  var_0._id_9696 = _id_2E91(var_2, 1);

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_0._id_969B[var_4] = _id_2E94(var_2, 1, var_4);
  }

  var_0._id_966A = _id_2E7F(var_2);
  var_0._id_966E = _id_2E82(var_2);
  var_0._id_966B = _id_2E80(var_2);
  var_0._id_966F = _id_2E83(var_2);
  var_0._id_96A2 = _id_2E8B();
  var_0._id_9676 = _id_2E85();
  var_0._id_965E = _id_2E7D();
  var_0._id_965C = _id_2E7B();
  var_0._id_965D = _id_2E7C();
  var_0._id_96A0 = 1;
  var_0._id_9679 = _id_2E86(0, var_1);
  var_0._id_967A = _id_2E86(1, var_1);
  var_0._id_967B = _id_2E86(2, var_1);
  var_0._id_96A3 = _id_2E8C(var_2);
}

_id_9643(var_0, var_1) {
  var_2 = _id_6962(var_1);
  self._id_37FF = var_2;
  var_3 = self.pers["gamemodeLoadout"];

  if(isDefined(var_3["loadoutArchetype"])) {
    var_0._id_965F = var_3["loadoutArchetype"];
  } else if(isbot(self)) {
    var_4 = _id_09F6::_id_283D();
    var_0._id_965F = var_4["loadoutArchetype"];
  } else
    var_0._id_965F = _id_2E7E();

  if(isDefined(var_3["loadoutRigTrait"])) {
    var_0._id_9690 = var_3["loadoutRigTrait"];
  }

  if(isDefined(var_3["loadoutPrimary"])) {
    var_0._id_9683 = var_3["loadoutPrimary"];
  }

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_6 = _id_68E4(var_5, "primary");

    if(isDefined(var_3[var_6])) {
      var_0._id_9685[var_5] = var_3[var_6];
    }
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = _id_6D8F(var_7, "primary");

    if(isDefined(var_3[var_8])) {
      var_0._id_968D[var_7] = var_3[var_8];
    }
  }

  if(isDefined(var_3["loadoutPrimaryCamo"])) {
    var_0._id_9686 = var_3["loadoutPrimaryCamo"];
  }

  if(isDefined(var_3["loadoutPrimaryCosmeticAttachment"])) {
    var_0._id_9687 = var_3["loadoutPrimaryCosmeticAttachment"];
  }

  if(isDefined(var_3["loadoutPrimaryReticle"])) {
    var_0._id_968C = var_3["loadoutPrimaryReticle"];
  }

  if(isDefined(var_3["loadoutSecondary"])) {
    var_0._id_9692 = var_3["loadoutSecondary"];
  }

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_6 = _id_68E4(var_5, "secondary");

    if(isDefined(var_3[var_6])) {
      var_0._id_9694[var_5] = var_3[var_6];
    }
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = _id_6D8F(var_7, "secondary");

    if(isDefined(var_3[var_8])) {
      var_0._id_969B[var_7] = var_3[var_8];
    }
  }

  if(isDefined(var_3["loadoutSecondaryCamo"])) {
    var_0._id_9695 = var_3["loadoutSecondaryCamo"];
  }

  if(isDefined(var_3["loadoutSecondaryCosmeticAttachment"])) {
    var_0._id_9696 = var_3["loadoutSecondaryCosmeticAttachment"];
  }

  if(isDefined(var_3["loadoutSecondaryReticle"])) {
    var_0._id_969A = var_3["loadoutSecondaryReticle"];
  }

  if(isDefined(var_3["loadoutMeleeSlot"])) {
    var_0._id_967D = var_3["loadoutMeleeSlot"];
  }

  var_0._id_9680 = isDefined(var_3["loadoutPerks"]);

  if(isDefined(var_3["loadoutPerks"])) {
    var_0._id_967F = var_3["loadoutPerks"];
  }

  var_0._id_9671 = isDefined(var_3["loadoutExtraPerks"]);

  if(isDefined(var_3["loadoutExtraPerks"])) {
    var_0._id_9670 = var_3["loadoutExtraPerks"];
  }

  if(isDefined(var_3["loadoutEquipmentPrimary"])) {
    var_0._id_966A = var_3["loadoutEquipmentPrimary"];
  }

  if(isDefined(var_3["loadoutExtraEquipmentPrimary"])) {
    var_0._id_966E = var_3["loadoutExtraEquipmentPrimary"];
  }

  if(isDefined(var_3["loadoutEquipmentSecondary"])) {
    var_0._id_966B = var_3["loadoutEquipmentSecondary"];
  }

  if(isDefined(var_3["loadoutExtraEquipmentSecondary"])) {
    var_0._id_966F = var_3["loadoutExtraEquipmentSecondary"];
  }

  if(isDefined(var_3["loadoutSuper"])) {
    var_0._id_96A2 = var_3["loadoutSuper"];
  }

  if(isbot(self)) {
    var_0._id_965E = "none";
    var_0._id_965C = "none";
    var_0._id_965D = "none";
  } else {
    var_0._id_965E = _id_2E7D();
    var_0._id_965C = _id_2E7B();
    var_0._id_965D = _id_2E7C();
  }

  if(isDefined(var_3["loadoutGesture"])) {
    if(var_3["loadoutGesture"] == "playerData") {
      if(isbot(self)) {
        var_0._id_9676 = "none";
      } else {
        var_0._id_9676 = _id_2E85();
      }
    } else
      var_0._id_9676 = var_3["loadoutGesture"];
  }

  if(isDefined(var_3["loadoutKillstreak1"]) && var_3["loadoutKillstreak1"] != "specialty_null" || isDefined(var_3["loadoutKillstreak2"]) && var_3["loadoutKillstreak2"] != "specialty_null" || isDefined(var_3["loadoutKillstreak3"]) && var_3["loadoutKillstreak3"] != "specialty_null") {
    var_0._id_96A0 = 1;
    var_0._id_9679 = var_3["loadoutKillstreak1"];
    var_0._id_967A = var_3["loadoutKillstreak2"];
    var_0._id_967B = var_3["loadoutKillstreak3"];
  }

  if(isDefined(var_3["loadoutUsingSpecialist"])) {
    var_0._id_96A3 = 1;
  }
}

_id_963B(var_0) {
  if(!isDefined(self._id_3802)) {
    scripts\engine\utility::_id_5598("self.classCallback function reference required for class 'callback'");
  }

  var_1 = self[[self._id_3802]]();

  if(!isDefined(var_1)) {
    scripts\engine\utility::_id_5598("array required from self.classCallback for class 'callback'");
  }

  if(isDefined(var_1["loadoutArchetype"])) {
    var_0._id_965F = var_1["loadoutArchetype"];
  }

  if(isDefined(var_1["loadoutPrimary"])) {
    var_0._id_9683 = var_1["loadoutPrimary"];
  }

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = _id_68E4(var_2, "primary");

    if(isDefined(var_1[var_3])) {
      var_0._id_9685[var_2] = var_1[var_3];
    }
  }

  if(isDefined(var_1["loadoutPrimaryCamo"])) {
    var_0._id_9686 = var_1["loadoutPrimaryCamo"];
  }

  if(isDefined(var_1["loadoutPrimaryReticle"])) {
    var_0._id_968C = var_1["loadoutPrimaryReticle"];
  }

  if(isDefined(var_1["loadoutSecondary"])) {
    var_0._id_9692 = var_1["loadoutSecondary"];
  }

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = _id_68E4(var_2, "secondary");

    if(isDefined(var_1[var_3])) {
      var_0._id_9694[var_2] = var_1[var_3];
    }
  }

  if(isDefined(var_1["loadoutSecondaryCamo"])) {
    var_0._id_9695 = var_1["loadoutSecondaryCamo"];
  }

  if(isDefined(var_1["loadoutSecondaryReticle"])) {
    var_0._id_969A = var_1["loadoutSecondaryReticle"];
  }

  if(isDefined(var_1["loadoutMeleeSlot"])) {
    var_0._id_967D = var_1["loadoutMeleeSlot"];
  }

  if(isDefined(var_1["loadoutEquipmentPrimary"])) {
    var_0._id_966A = var_1["loadoutEquipmentPrimary"];
  }

  if(isDefined(var_1["loadoutExtraEquipmentPrimary"])) {
    var_0._id_966E = var_1["loadoutExtraEquipmentPrimary"];
  }

  if(isDefined(var_1["loadoutEquipmentSecondary"])) {
    var_0._id_966B = var_1["loadoutEquipmentSecondary"];
  }

  if(isDefined(var_1["loadoutExtraEquipmentSecondary"])) {
    var_0._id_966F = var_1["loadoutExtraEquipmentSecondary"];
  }

  if(isDefined(var_1["loadoutSuper"])) {
    var_0._id_96A2 = var_1["loadoutSuper"];
  }

  if(isDefined(var_1["loadoutGesture"])) {
    var_0._id_9676 = var_1["loadoutGesture"];
  }

  var_0._id_96A0 = isDefined(var_1["loadoutStreak1"]) || isDefined(var_1["loadoutStreak2"]) || isDefined(var_1["loadoutStreak3"]);

  if(isDefined(var_1["loadoutStreakType"])) {
    var_0._id_96A1 = var_1["loadoutStreakType"];
  }

  if(isDefined(var_1["loadoutStreak1"])) {
    var_0._id_9679 = var_1["loadoutStreak1"];
  }

  if(isDefined(var_1["loadoutStreak2"])) {
    var_0._id_967A = var_1["loadoutStreak2"];
  }

  if(isDefined(var_1["loadoutStreak3"])) {
    var_0._id_967B = var_1["loadoutStreak3"];
  }
}

_id_963D(var_0, var_1) {
  var_2 = _id_6962(var_1);
  self._id_37FF = var_2;

  if(self _meth_878F() && getdvarint("#x315cfcaa3e774ac5c", 1) == 1) {
    _id_9640(var_0);
  } else {
    _id_963F(var_0, var_2);
  }

  if(isDefined(level.override_loadout_updateclassdefault_equipment)) {
    self[[level.override_loadout_updateclassdefault_equipment]](var_0, var_2);
  } else {
    var_0._id_966A = _id_EC60(level._id_3809, var_2);
    var_0._id_966E = _id_EC63(level._id_3809, var_2);
    var_0._id_966B = _id_EC61(level._id_3809, var_2);
    var_0._id_966F = _id_EC64(level._id_3809, var_2);
  }

  var_0._id_9676 = _id_EC66(level._id_3809, var_2);
  var_0._id_96A2 = _id_EC6C(level._id_3809, var_2);
  var_0._id_96A3 = _id_EC6B(level._id_3809, var_2);
  var_0._id_965E = _id_2E7D();
  var_0._id_965C = _id_2E7B();
  var_0._id_965D = _id_2E7C();
  var_0._id_965F = _id_2E7E();
  var_0._id_9679 = _id_2E86(0, var_1);
  var_0._id_967A = _id_2E86(1, var_1);
  var_0._id_967B = _id_2E86(2, var_1);
  var_0._id_9690 = _id_2E87();

  if(getdvarint("#x3510e61cf3518ba9d", 0)) {
    var_0._id_96A2 = "super_bradley";
  }
}

_id_963F(var_0, var_1) {
  if(isDefined(level._id_AD3D)) {
    self[[level._id_AD3D]](var_0, var_1);
    return;
  }

  var_0._id_9683 = _id_EC6D(level._id_3809, var_1, 0);

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_0._id_9685[var_2] = _id_EC6E(level._id_3809, var_1, 0, var_2);
  }

  var_0._id_9686 = _id_EC6F(level._id_3809, var_1, 0);
  var_0._id_968C = _id_EC70(level._id_3809, var_1, 0);
  var_0._id_9692 = _id_EC6D(level._id_3809, var_1, 1);

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_0._id_9694[var_2] = _id_EC6E(level._id_3809, var_1, 1, var_2);
  }

  var_0._id_9695 = _id_EC6F(level._id_3809, var_1, 1);
  var_0._id_969A = _id_EC70(level._id_3809, var_1, 1);
}

_id_9640(var_0) {
  if(!isDefined(self._id_7600)) {
    if(!isDefined(level._id_7600)) {
      var_1 = randomint(200);
      level._id_7600 = var_1;
      level._id_7601 = var_1;
    } else {
      level._id_7600++;
      level._id_7601++;
    }

    self._id_7600 = level._id_7600;
    self._id_7601 = level._id_7601;
  }

  var_2 = _id_963E(self._id_7600, 1);
  var_3 = _id_963E(self._id_7601, 0);
  var_4 = var_2[0];
  var_5 = var_2[1];
  var_6 = var_3[0];
  var_7 = var_3[1];
  var_0._id_9683 = var_4;

  foreach(var_10, var_9 in var_5._id_1D78) {
    var_0._id_9685[var_0._id_9685.size] = var_10;
    var_0._id_9684[var_0._id_9684.size] = var_9;
  }

  var_0._id_968E = var_5._id_04CC;
  var_0._id_9692 = var_6;

  foreach(var_10, var_9 in var_7._id_1D78) {
    var_0._id_9694[var_0._id_9694.size] = var_10;
    var_0._id_9693[var_0._id_9693.size] = var_9;
  }

  var_0._id_969C = var_7._id_04CC;
}

loadout_checkattachmentrestrictions(var_0) {
  var_1 = getDvar("#x3605f899c209cf850");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = strtok(var_1, ",");

  foreach(var_5, var_4 in var_0._id_9685) {
    if(scripts\engine\utility::array_contains(var_2, var_4)) {
      var_0._id_9685[var_5] = "none";
    }
  }

  foreach(var_5, var_4 in var_0._id_9694) {
    if(scripts\engine\utility::array_contains(var_2, var_4)) {
      var_0._id_9694[var_5] = "none";
    }
  }
}

_id_963E(var_0, var_1) {
  var_2 = 0;
  var_3 = -1;

  for(;;) {
    foreach(var_7, var_5 in level._id_10DAC) {
      if(var_5._id_04CC == 0 || var_5._id_8912 || !isDefined(var_5._id_1D78)) {
        continue;
      }
      var_6 = strtok(var_7, "|")[0];

      if(var_1 != scripts\mp\utility\weapon::_id_879A(var_6)) {
        continue;
      }
      var_3++;

      if(var_3 == var_0) {
        return [var_6, var_5];
      }
    }
  }
}

_id_9657(var_0) {
  self._id_EA19 = "streaktype_assault";
  var_0._id_96A1 = self._id_EA19;
}

_id_9638(var_0, var_1) {
  if(!isDefined(self.pers["loadoutPerks"])) {
    self.pers["loadoutPerks"] = [];
  }

  if(!isDefined(self.pers["loadoutStandardPerks"])) {
    self.pers["loadoutStandardPerks"] = [];
  }

  if(!isDefined(self.pers["loadoutExtraPerks"])) {
    self.pers["loadoutExtraPerks"] = [];
  }

  if(!isDefined(self.pers["loadoutRigTrait"])) {
    self.pers["loadoutRigTrait"] = [];
  }

  if(!isDefined(self.pers["loadoutUsingSpecialist"])) {
    self.pers["loadoutUsingSpecialist"] = 0;
  }

  var_2 = _func_00D6(var_1, 0, 7) == "default";

  if(var_0._id_9680) {
    var_0._id_969F = var_0._id_967F;

    if(var_0._id_9671) {
      var_0._id_9670 = var_0._id_9670;
    }
  } else if(!scripts\mp\utility\perk::_id_AFFA())
    return;
  else if(isai(self)) {
    if(isDefined(self.pers["loadoutPerks"])) {
      var_0._id_967F = self.pers["loadoutPerks"];
    }
  } else {
    if(var_1 == "juggernaut" || var_1 == "copied") {
      return;
    }
    var_3 = _id_962B(var_1);

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = "specialty_null";

      if(var_3 != "none") {
        var_6 = _id_6962(var_1);
        var_5 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_3, var_6, "class", "loadoutPerks");
      } else if(var_2) {
        var_6 = _id_6962(var_1);
        var_5 = _id_EC69(level._id_3809, var_6, var_4);
      } else {
        if(scripts\mp\utility\game::getgametype() == "base") {
          if(!isDefined(self.loadoutspurchased)) {
            continue;
          }
        }

        var_5 = _id_2E89(self._id_37FF, var_4);
      }

      if(isDefined(var_5) && var_5 != "specialty_null" && !_id_0825::isperkbanned(var_5)) {
        var_0._id_967F[var_0._id_967F.size] = var_5;
        var_0._id_969F[var_0._id_969F.size] = var_5;
      }
    }

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = "specialty_null";

      if(var_3 != "none") {
        var_6 = _id_6962(var_1);
        var_5 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_3, var_6, "class", "extraPerks");
      } else if(var_2) {
        var_6 = _id_6962(var_1);
        var_5 = _id_EC65(level._id_3809, var_6, var_4);
      } else
        var_5 = _id_2E88(self._id_37FF, var_4);

      if(isDefined(var_5) && var_5 != "specialty_null" && !_id_0825::isperkbanned(var_5)) {
        var_0._id_9670[var_0._id_9670.size] = var_5;
      }
    }

    var_5 = "specialty_null";

    if(var_3 != "none") {
      var_6 = _id_6962(var_1);
      var_5 = scripts\mp\utility\game::_id_6B32("defaultClasses", var_3, var_6, "class", "archetypePerk");
    } else
      var_5 = _id_2E87();

    if(isDefined(var_5) && var_5 != "specialty_null" && !_id_0825::isperkbanned(var_5)) {
      var_0._id_967F[var_0._id_967F.size] = var_5;
      self.pers["loadoutRigTrait"] = var_5;
      var_0._id_9690 = var_5;
    }

    var_6 = _id_6962(var_1);
    return;
  }
}

_id_962C(var_0) {
  var_1 = _id_962B(var_0);

  if(var_1 != "none") {
    return "team";
  } else if(issubstr(var_0, "custom")) {
    return "custom";
  } else if(var_0 == "gamemode") {
    return "gamemode";
  } else if(var_0 == "callback") {
    return "callback";
  } else if(var_0 == "juggernaut") {
    return "juggernaut";
  } else if(var_0 == "copied") {
    return "copied";
  } else {
    return "default";
  }
}

_id_9646(var_0, var_1) {
  var_2 = _id_962C(var_1);

  switch (var_2) {
    case "team":
      break;
    case "custom":
      break;
    case "gamemode":
      _id_9647(var_0, var_1);
      break;
    case "callback":
      break;
    case "default":
      break;
    case "juggernaut":
      break;
  }

  return var_0;
}

_id_963A(var_0, var_1) {
  if(self _meth_878F() && getdvarint("#x315cfcaa3e774ac5c", 1) == 1 && scripts\mp\utility\game::getgametype() != "br") {
    var_1 = "default" + (randomint(5) + 1);
  }

  var_2 = _id_962C(var_1);

  switch (var_2) {
    case "team":
      _id_9644(var_0, var_1);
      break;
    case "custom":
      _id_963C(var_0, var_1);
      break;
    case "gamemode":
      _id_9643(var_0, var_1);
      break;
    case "callback":
      _id_963B(var_0);
      break;
    case "default":
      _id_963D(var_0, var_1);
      break;
    case "juggernaut":
      break;
    case "copied":
      break;
  }

  if(!istrue(game["isLaunchChunk"])) {
    self.pers["defaultOperatorSkinIndex"] = ::scripts\mp\teams::_id_B068(var_0._id_9683);
  }

  loadout_checkattachmentrestrictions(var_0);
  _id_9649(var_0);
  _id_9642(var_0);
  _id_9657(var_0);
  _id_9638(var_0, var_1);
  var_0 = _id_965A(var_0, var_1);
  _id_9641(var_0);

  if(isDefined(level._id_9FF4)) {
    self[[level._id_9FF4]](var_0);
  }

  return var_0;
}

_id_9642(var_0) {
  if(var_0._id_9683 == "none") {
    var_0._id_9683 = "s4_me_fists";
  }

  if(var_0._id_9692 == "none" && var_0._id_9683 != "s4_me_fists" && !istrue(self._id_88DF)) {
    var_0._id_9692 = "s4_me_fists";
  } else if(var_0._id_9683 == "s4_me_fists" && var_0._id_9692 == "s4_me_fists") {
    var_0._id_9692 = "none";
  }
}

_id_9649(var_0) {
  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_0._id_9677 = 1;
  }
}

_id_965A(var_0, var_1) {
  var_2 = issubstr(var_1, "default") && (scripts\mp\utility\game::isanymlgmatch() || getdvarint("#x391583f1a45eeccda", 1) != 1);

  if(issubstr(var_1, "custom") || var_2) {
    return _id_0825::_id_FF4B(var_0);
  }

  return var_0;
}

_id_9628(var_0) {
  var_1 = getdvarint("#x31e1da5f3b6583e72", 0);

  if(var_1 > 0) {
    var_2 = getdvarint("#x31e1da5f3b6583e72", 0);

    switch (var_2) {
      case 1:
        var_0._id_965F = "archetype_assault";
        break;
      default:
        var_0._id_965F = "archetype_assault";
        break;
    }
  } else if(var_1 == -1) {
    var_3 = ["archetype_assault"];
    var_4 = randomint(var_3.size);
    var_0._id_965F = var_3[var_4];
  }
}

_id_964D(var_0) {
  if(!isai(self)) {
    if(!isDefined(level._id_191E) || level._id_191E == 0) {}
  }

  self._id_965F = var_0._id_965F;
  scripts\mp\weapons::_id_FCCC();
  var_1 = 1;
  var_2 = 2;
  var_3 = 4;
  var_4 = 8;
  var_5 = 0;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 400;
  var_9 = 400;
  var_10 = 900;

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_9 = 133.333;
    var_10 = 1800;
  }

  switch (self._id_965F) {
    case "archetype_assault":
      var_5 = var_1 | var_2 | var_3;
      var_6 = _id_09F0::_id_19C5;
      var_7 = "vestlight";
      self._id_39FC = var_7;
      break;
    default:
      if(!isai(self)) {
        if(!isDefined(level._id_191E) || level._id_191E == 0) {}
      }

      break;
  }

  self setcamerathirdperson(0);

  if(getdvarint("#x3159800efe8e136ef")) {
    self allowdoublejump(var_5 &var_1);
    self allowwallrun(var_5 &var_3);
    self allowdodge(var_5 &var_4);
  } else {
    self allowdoublejump(0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowslide(var_5 &var_2);
  self allowlean(0);
  self _meth_8480(0, var_8);
  self _meth_847E(0, var_8);
  self _meth_8486(0, var_9);
  self _meth_8482(0, var_10);
  self _meth_8480(1, 50);
  self _meth_847E(1, 50);
  self _meth_8486(1, 10);
  self _meth_8482(1, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 2500, 0));

  if(isDefined(var_6)) {
    self[[var_6]]();
  }
}

loadout_buildloadoutprimaryobject(var_0) {
  return buildweapon(var_0._id_9683, var_0._id_9685, var_0._id_9686, var_0._id_968C, var_0._id_968E, var_0._id_9684, var_0._id_9687, var_0._id_968D, istrue(var_0._id_9677));
}

loadout_buildloadoutsecondaryobject(var_0) {
  return buildweapon(var_0._id_9692, var_0._id_9694, var_0._id_9695, var_0._id_969A, var_0._id_969C, var_0._id_9693, var_0._id_9696, var_0._id_969B, istrue(var_0._id_9677));
}

_id_9641(var_0) {
  var_0._id_968A = loadout_buildloadoutprimaryobject(var_0);
  var_0._id_9688 = getcompleteweaponname(var_0._id_968A);

  if(var_0._id_9692 == "none") {
    var_0._id_9697 = "none";
    var_0._id_9699 = undefined;
  } else {
    var_0._id_9699 = loadout_buildloadoutsecondaryobject(var_0);
    var_0._id_9697 = getcompleteweaponname(var_0._id_9699);
  }

  if(var_0._id_967D != "none") {
    self giveweapon(var_0._id_967D);
    self _meth_8514(var_0._id_967D);
  }
}

_id_9656(var_0, var_1, var_2, var_3) {
  var_4 = _id_9631(var_0);
  var_5 = _id_9632(var_0);
  self._id_967D = var_0._id_967D;

  if(self hasweapon(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = var_5;
  }

  if(isDefined(var_5) && var_5.basename != "none" && isDefined(var_4) && var_4.basename == "s4_me_fists_mp") {
    var_6 = var_5;
  }

  if(!isai(self)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_6);
  }

  if(!isDefined(var_2) || var_2) {
    var_3 = _id_DBD7(var_6, var_3);

    if(!isagent(self)) {
      self setspawnweapon(var_6, !var_3);
    }
  }

  self._id_E3A8 = var_6;
  _id_9659();
}

_id_9626() {
  if(isDefined(self.primaryweaponobj) && !self hasweapon(self.primaryweaponobj)) {
    _id_9631(self._id_3808);
    thread _id_F42D();
  }

  if(isDefined(self.secondaryweaponobj) && !self hasweapon(self.secondaryweaponobj)) {
    _id_9632(self._id_3808);
    thread _id_F42D();
  }
}

_id_9631(var_0) {
  var_1 = _id_C6AB();
  var_2 = _id_C6B8(var_1);
  var_3 = level._id_992A;
  self._id_9683 = var_0._id_9683;
  self._id_9686 = var_0._id_9686;
  self._id_9685 = var_0._id_9685;
  self._id_9684 = var_0._id_9684;
  self._id_968C = var_0._id_968C;
  self._id_9689 = var_0._id_9689;
  self._id_968E = var_0._id_968E;
  var_4 = undefined;

  if(!var_2) {
    var_4 = var_0._id_968A;
  } else {
    var_4 = _id_C6B1(var_1, "primary");
  }

  if(var_4.basename == "s4_me_rindigo_mp" && !_id_07D1::_id_60BE("prematch_done") && isDefined(self._id_7E24) && !istrue(self._id_7E82)) {} else {
    var_4 = scripts\mp\weapons::_id_FD15(var_4);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4, undefined, undefined, var_4.basename == "s4_me_fists_mp");
    scripts\mp\weapons::_id_FD69(var_4);
    _id_0A6E::_id_96A5(var_4);
    var_5 = var_0._id_968A _meth_8624("maxammo", 1);

    if(var_2) {
      _id_C6B3(var_1, "primary");
    } else if(var_3 != 3) {
      _id_E265(var_4, "primary", var_3);
    } else if(var_5) {
      self givemaxammo(var_0._id_968A);

      if(istrue(var_0._id_968A._id_0216)) {
        var_6 = var_0._id_968A getaltweapon();
        var_7 = weaponclass(var_6);
        self givemaxammo(var_6);
      }
    } else if(istrue(var_0._id_968A._id_0216)) {
      var_6 = var_0._id_968A getaltweapon();
      var_7 = weaponclass(var_6);

      if(var_7 == "spread") {
        self setweaponammoclip(var_6, 6);
      }
    }

    if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
      _id_9639(var_4, var_5);
    }
  }

  self._id_034C = var_0._id_9688;
  self.primaryweaponobj = var_0._id_968A;
  self.pers["primaryWeapon"] = var_0._id_9688;
  return var_4;
}

_id_9632(var_0) {
  var_1 = _id_C6AB();
  var_2 = _id_C6B8(var_1);
  var_3 = level._id_992A;
  self._id_9692 = var_0._id_9692;
  self._id_9695 = var_0._id_9695;
  self._id_9694 = var_0._id_9694;
  self._id_9693 = var_0._id_9693;
  self._id_969A = var_0._id_969A;
  self._id_9698 = var_0._id_9698;
  self._id_969C = var_0._id_969C;
  var_4 = undefined;

  if(!var_2) {
    var_4 = var_0._id_9699;
  } else {
    var_4 = _id_C6B1(var_1, "secondary");
  }

  if(!_func_0376(var_4)) {
    if(var_4.basename == "s4_me_rindigo_mp" && !_id_07D1::_id_60BE("prematch_done") && isDefined(self._id_7E24) && !istrue(self._id_7E82)) {} else {
      var_4 = scripts\mp\weapons::_id_FD15(var_4);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4, undefined, undefined, 1);
      scripts\mp\weapons::_id_FD69(var_4);

      if(var_4 _meth_8624("akimbo", 1)) {
        var_5 = self getweaponammostock(var_4) + self getweaponammoclip(var_4, "right") + self getweaponammoclip(var_4, "left");
        self setweaponammostock(var_4, var_5 * 2 - self getweaponammoclip(var_4, "right") - self getweaponammoclip(var_4, "left"));
      }

      if(var_4.basename == "iw7_axe_mp") {
        self setweaponammoclip(var_4, 1);
      }

      _id_0A6E::_id_96A5(var_4);
      var_6 = var_0._id_9699 _meth_8624("maxammo", 1);

      if(var_2) {
        _id_C6B3(var_1, "secondary");
      } else if(var_3 != 3) {
        _id_E265(var_4, "secondary", var_3);
      } else if(var_6) {
        self givemaxammo(var_0._id_9699);

        if(istrue(var_0._id_9699._id_0216)) {
          var_7 = var_0._id_9699 getaltweapon();
          var_8 = weaponclass(var_7);
          self givemaxammo(var_7);
        }
      } else if(istrue(var_0._id_9699._id_0216)) {
        var_7 = var_0._id_9699 getaltweapon();
        var_8 = weaponclass(var_7);

        if(var_8 == "spread") {
          self setweaponammoclip(var_7, 6);
        }
      }

      if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
        _id_9639(var_4, var_6);
      }
    }
  }

  self._id_03B5 = var_0._id_9697;
  self.secondaryweaponobj = var_0._id_9699;
  self.pers["secondaryWeapon"] = var_0._id_9697;
  return var_4;
}

_id_9639(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_weapons::_id_2A07(var_0);
  var_3 = _func_027D(var_0);
  var_4 = weaponclipsize(var_0);
  var_5 = weaponmaxammo(var_0);
  var_6 = undefined;

  if(var_1) {
    var_6 = var_5;
  } else {
    var_6 = var_3 - var_4;
  }

  if(isDefined(var_2)) {
    scripts\mp\gametypes\br_weapons::_id_29FB(self, var_2, var_6);
  }
}

_id_9659() {
  scripts\mp\weapons::_id_FCCC();
}

_id_9653(var_0) {
  _id_9630("specialty_ads_overlay_awareness");

  if(scripts\mp\utility\game::_id_8902()) {
    scripts\mp\utility\perk::_id_6FC2("specialty_pistoldeath");
  }

  _id_9630("specialty_location_marking");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    _id_9630("specialty_tracker_jammer");
  }

  if(var_0._id_969F.size > 0) {
    var_1 = getdvarint("#x3ebf64a18d581b6f5", 0) == 0;

    if(scripts\mp\utility\game::_id_875D()) {
      var_1 = 0;
    }

    if(scripts\mp\utility\game::isbasegametype()) {
      if(istrue(self._id_75B4)) {
        var_1 = 1;
      } else {
        var_1 = 0;
      }
    }

    if(var_1) {
      scripts\mp\perks\perks::_id_6FC5(var_0._id_967F, 0);
    }
  }

  self.pers["loadoutPerks"] = var_0._id_967F;
  self.pers["loadoutStandardPerks"] = var_0._id_969F;
  self.pers["loadoutExtraPerks"] = var_0._id_9670;
  self.pers["loadoutRigTrait"] = var_0._id_9690;
  self.pers["loadoutUsingSpecialist"] = var_0._id_96A3;
  self setclientomnvar("ui_trait_ref", scripts\mp\perks\perks::_id_6C26(self.pers["loadoutRigTrait"]));

  if(isDefined(self._id_1FAF) && self._id_1FAF > 0) {
    thread scripts\mp\perks\perks::_id_6FC6();
  }

  if(scripts\mp\utility\dvars::_id_6AC8("#x38086f97dfaa620ab", 1) == 1 && game["state"] != "postgame" && !scripts\mp\utility\game::_id_875D() && !scripts\mp\utility\game::isbasegametype()) {
    scripts\mp\perks\perks::_id_D626("ui_spawn_perk_", self.pers["loadoutPerks"]);
  }
}

_id_964E(var_0, var_1) {
  var_2 = _id_C6AB();
  var_3 = _id_C6B4(var_2);

  if(scripts\mp\utility\game::_id_875D() && !istrue(self.arena_evo_equipment_override_done)) {
    [var_0._id_966A, var_0._id_966B] = ::scripts\mp\gametypes\arena_evo_tourney_loot::get_default_equipment();
    self.arena_evo_equipment_override_done = 1;
  }

  self._id_966A = var_0._id_966A;
  self._id_966B = var_0._id_966B;
  var_5 = undefined;

  if(!var_3) {
    var_5 = var_0._id_966A;
  } else {
    var_5 = _id_C6AA(var_2, "primary");
  }

  var_6 = undefined;

  if(!var_3) {
    var_6 = var_0._id_966B;
  } else {
    var_6 = _id_C6AA(var_2, "secondary");
  }

  if(isDefined(var_1)) {
    switch (var_1) {
      case "primary":
        scripts\mp\equipment::giveequipment(var_5, "primary");
        break;
      case "secondary":
        scripts\mp\equipment::giveequipment(var_6, "secondary");
        break;
    }
  } else {
    scripts\mp\equipment::giveequipment(var_5, "primary");
    scripts\mp\equipment::giveequipment(var_6, "secondary");
  }

  if(var_3) {
    _id_C6B2(var_2, "primary");
    _id_C6B2(var_2, "secondary");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread _id_0A12::_id_CA64();
    thread _id_9652();
  }
}

_id_9652() {
  self endon("death_or_disconnect");
  self notify("loadout_updatePlayerNVGs");
  self endon("loadout_updatePlayerNVGs");
  var_0 = 0;

  if(game["roundsPlayed"] == 0 && !istrue(self._id_75B4)) {
    if(!_id_07D1::_id_60BE("infil_will_run") || _id_07D1::_id_60BE("infil_started")) {
      var_0 = 1;
    }
  } else if(istrue(self.pers["useNVG"]))
    var_0 = 1;

  if(istrue(self._id_82F0)) {
    scripts\engine\utility::waittill_any_2("spawned_player", "fadeUp_start");
  }

  while(!isDefined(self._id_AC3D)) {
    waitframe();
  }

  if(var_0) {
    self _meth_8249(1);
  }

  _id_0A12::_id_A7B8(var_0);
}

_id_9655(var_0) {
  var_1 = _id_09D6::_id_9422();

  if(!var_1 && var_0._id_96A2 == "super_bradley") {
    var_0._id_96A2 = "super_pac_sentry";
  }

  var_2 = var_0._id_96A2;
  var_3 = _id_C6AB();
  var_4 = _id_C6B7(var_3);

  if(var_4) {
    var_2 = _id_C6B0(var_3);
  }

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    var_5 = scripts\mp\supers::_id_69B0();

    if(var_5 == var_2 && !_id_754B()) {
      scripts\mp\supers::_id_6FFB(self._id_EB09);
      return;
    }
  }

  if(var_2 == "none" || !level._id_15D8) {
    scripts\mp\supers::_id_3987();
    self._id_96A2 = undefined;
  } else if(level._id_15D8 && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self._id_96A2 = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::givesuper(self._id_96A2, 1);
  } else if(var_2 == "super_bradley" && !_id_09D6::_id_9422()) {
    scripts\mp\supers::_id_3987();
    self._id_96A2 = undefined;
  } else {
    self._id_96A2 = var_0._id_96A2;
    scripts\mp\supers::givesuper(var_2, 1);

    if(var_4) {
      scripts\mp\supers::_id_D6F8(_id_C6AF(var_3));
      scripts\mp\supers::_id_D6FA(_id_C6AE(var_3));
    }
  }
}

_id_9650(var_0) {
  if(!istrue(self._id_2C68)) {
    if(var_0._id_9676 != "none") {
      self._id_9676 = var_0._id_9676;
      _id_0793::_id_6F9C(var_0._id_9676);
    }
  }
}

_id_964B(var_0) {
  if(!istrue(self._id_2C68)) {
    if(isDefined(var_0._id_965E) && var_0._id_965E != "none") {
      self._id_965C = var_0._id_965C;
      self._id_965E = var_0._id_965E;
      _id_07A6::_id_6FC8(var_0._id_965C, var_0._id_965E, var_0._id_965D);
    }
  }
}

_id_9654(var_0) {
  self._id_EA19 = _id_962F(var_0._id_96A1);
}

_id_9651(var_0, var_1) {
  var_2 = scripts\mp\utility\game::getgametype();

  if(!level._id_15BD || var_2 == "kspoint") {
    var_0._id_9679 = "none";
    var_0._id_967A = "none";
    var_0._id_967B = "none";
  }

  if(var_0._id_96A0 == 0 && isDefined(self._id_E9FF) && self._id_E9FF._id_EA14.size > 0 && var_1 == "gamemode") {
    var_3 = 0;

    foreach(var_5 in self._id_E9FF._id_EA14) {
      if(var_3 == 0) {
        var_0._id_9679 = var_5;
        var_3++;
        continue;
      }

      if(var_3 == 1) {
        var_0._id_967A = var_5;
        var_3++;
        continue;
      }

      if(var_3 == 2) {
        var_0._id_967B = var_5;
        break;
      }
    }
  }

  var_7 = [var_0._id_9679, var_0._id_967A, var_0._id_967B];

  if(level._id_15BD) {
    self.pers["hackedStreaks"] = 0;
    var_7 = _id_C55B(var_0);
  }

  self._id_96A3 = var_0._id_96A3;
  self _meth_8778(self._id_96A3);

  if(var_0._id_96A3 && level._id_15BD) {
    var_7 = _id_C55C(var_0);
  }

  var_8 = _id_C6AB();
  var_9 = _id_C6B6(var_8);

  if(var_9 && level._id_15BD) {
    var_7 = _id_C6AD(var_8);
  }

  if(level._id_15BD) {
    var_7 = _id_E033(var_7);
  }

  if(!isagent(self)) {
    var_10 = scripts\mp\killstreaks\killstreaks::_id_1A5A(var_7);

    if(!var_10) {
      self notify("givingLoadout");
      self._id_967C = 1;
      var_11 = scripts\mp\killstreaks\killstreaks::_id_6A6C();
      var_12 = scripts\mp\killstreaks\killstreaks::_id_68EA();

      if(!scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && !isDefined(self._id_50E8)) {
        scripts\mp\killstreaks\killstreaks::_id_394F();
      }

      for(var_13 = 0; var_13 < var_7.size; var_13++) {
        var_14 = var_7[var_13];

        if(isDefined(var_14) && var_14 != "none" && var_14 != "") {
          scripts\mp\killstreaks\killstreaks::_id_5551(var_14, var_13 + 1);
        }
      }

      for(var_15 = var_11.size - 1; var_15 >= 0; var_15--) {
        var_14 = var_11[var_15];

        if(!var_14._id_8A51) {
          scripts\mp\killstreaks\killstreaks::_id_1FC9(var_11[var_15]);
        }
      }

      for(var_15 = 0; var_15 < var_12.size; var_15++) {
        var_14 = var_12[var_15];

        if(!var_14._id_8A51) {
          scripts\mp\killstreaks\killstreaks::_id_1FC9(var_12[var_15]);
        }
      }

      self._id_967C = undefined;
    }
  }

  self notify("equipKillstreaksFinished");
}

_id_E033(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    if(isDefined(var_0[var_1]) && var_0[var_1] != "none" && var_0[var_1] != "") {
      for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
        if(isDefined(var_0[var_2]) && var_0[var_2] != "none" && var_0[var_2] != "") {
          var_3 = scripts\mp\killstreaks\killstreaks::_id_2EC5(var_0[var_1]);
          var_4 = scripts\mp\killstreaks\killstreaks::_id_2EC5(var_0[var_2]);

          if(var_4 < var_3) {
            var_5 = var_0[var_2];
            var_0[var_2] = var_0[var_1];
            var_0[var_1] = var_5;
          }
        }
      }
    }
  }

  return var_0;
}

_id_964C(var_0, var_1) {
  self setactionslot(3, "altmode");
}

_id_9645(var_0, var_1, var_2) {
  if(var_2 == "juggernaut") {
    return;
  }
  self._id_9674 = var_0._id_9674;
  self._id_9675 = var_0._id_9675;

  if(_func_041C(self._id_9674)) {
    self._id_9674 = "super_deadsilence";
  }

  if(_func_041C(self._id_9675)) {
    self._id_9675 = "super_deadsilence";
  }

  if(scripts\mp\utility\game::isanymlgmatch() || self._id_9674 == self._id_9675) {
    self._id_9675 = "none";
  }

  if(getdvarint("#x391583f1a45eeccda", 1) != 1) {
    if(!isDefined(self._id_9674) || self._id_9674 != "none" && istrue(level._id_EB2B._id_E76D[self._id_9674]._id_8B15)) {
      self._id_9674 = "none";
    }

    if(!isDefined(self._id_9675) || self._id_9675 != "none" && istrue(level._id_EB2B._id_E76D[self._id_9675]._id_8B15)) {
      self._id_9675 = "none";
    }
  }

  if(level._id_15D8) {
    if(scripts\mp\utility\game::getgametype() == "base") {
      var_3 = "super_equipment_resupply_drop";

      if(isDefined(self._id_1A7E) && isDefined(self._id_1A7E["arena_evo_loadout_override_equipment_super"])) {
        var_3 = self._id_1A7E["arena_evo_loadout_override_equipment_super"];
      }

      self._id_9674 = var_3;
      self._id_9675 = "none";
      var_4 = scripts\mp\supers::_id_6DA1(var_3);
      scripts\mp\equipment::_id_D5AA("super", var_4);
    }

    thread scripts\mp\supers::_id_10BE6();
    thread _id_0A6C::_id_AFE0();

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_5 = _id_5BF9(self._id_9674);
      scripts\mp\gametypes\br_pickups::_id_5EA7(var_5);
    }
  } else if(scripts\mp\utility\game::getgametype() == "br") {
    self._id_9660 = _id_5BF9(self._id_9674);
    self._id_9674 = "none";
    self._id_9675 = "none";

    if(getdvarint("#x3b9b4779cf6da5800", 0) == 0) {
      _id_0A6C::_id_AFE1();
    }
  }
}

_id_5BF9(var_0) {
  if(var_0 == "none") {
    return "super_ammo_drop";
  }

  return var_0;
}

_id_964A(var_0, var_1, var_2, var_3, var_4) {
  _id_9654(var_1);
  _id_964D(var_1);

  if(!istrue(level._id_A6CB)) {
    _id_9656(var_1, var_2, var_3, var_4);
  }

  _id_9653(var_1);

  if(!istrue(level._id_A6CB)) {
    _id_964E(var_1);
  }

  if(!istrue(game["isLaunchChunk"]) && scripts\mp\utility\game::getgametype() != "br") {
    _id_9651(var_1, var_2);
  }

  _id_964C(var_1, var_2);

  if(!istrue(game["isLaunchChunk"])) {
    _id_9645(var_0, var_1, var_2);
  }

  self.pers["lastClass"] = self.class;
  self._id_8FAF = self.class;
  self._id_8F8C = self._id_33DA;

  if(isDefined(self._id_60C7)) {
    self.pers["class"] = self._id_60C7;
    self.pers["lastClass"] = self._id_60C7;
    self.class = self._id_60C7;
    self._id_8FAF = self._id_60C7;
    self._id_60C7 = undefined;
  }

  if(isDefined(self._id_C7BC)) {
    self.pers["class"] = self._id_C7BC;
    self.pers["lastClass"] = self._id_C7BC;
    self.class = self._id_C7BC;
    self._id_8FAF = self._id_C7BC;
  }

  scripts\mp\teams::_id_D8A1();
  _id_964B(var_1);
}

_id_D4D8(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  var_0 endon("disconnect");
  var_0 notify("setCodcasterClientLoadoutData()");
  var_0 endon("setCodcasterClientLoadoutData()");
  var_0 _meth_8773();
  var_0 _meth_8799(level._id_0271);
  var_0 _meth_80C9(0, var_1._id_9688);
  var_0 _meth_80C9(1, var_1._id_9697);

  if(isDefined(self.equipment["primary"])) {
    var_2 = scripts\mp\equipment::_id_6A17(self.equipment["primary"]);
    var_0 _meth_80C7("primaryPower", var_2._id_7C8C);
  }

  if(isDefined(self.equipment["secondary"])) {
    var_3 = scripts\mp\equipment::_id_6A17(self.equipment["secondary"]);
    var_0 _meth_80C7("secondaryPower", var_3._id_7C8C);
  }

  if(isDefined(self._id_9674)) {
    var_0 _meth_80C7("fieldUpgrade", scripts\mp\supers::_id_6DA1(self._id_9674));
  }

  var_4 = scripts\mp\supers::_id_6DA1(var_1._id_96A2);
  var_0 _meth_80C7("super", var_4);

  if(isai(var_0)) {
    for(var_5 = 0; var_5 < var_1._id_967F.size; var_5++) {
      var_6 = var_1._id_967F[var_5];
      var_7 = scripts\mp\perks\perks::_id_6C26(var_6);
      var_0 _meth_80C7(var_5 + 1 + "_perk", var_7);
    }
  } else {
    if(var_1._id_9680) {
      var_1._id_969F = var_1._id_967F;
    }

    for(var_5 = 0; var_5 < self.pers["loadoutPerks"].size; var_5++) {
      var_6 = self.pers["loadoutPerks"][var_5];
      var_7 = scripts\mp\perks\perks::_id_6C26(var_6);
      var_0 _meth_80C7(var_5 + 1 + "_perk", var_7);
    }

    for(var_5 = 0; var_5 < var_1._id_9670.size; var_5++) {
      var_6 = var_1._id_9670[var_5];
      var_7 = scripts\mp\perks\perks::_id_6C26(var_6);
      var_0 _meth_80C7(var_5 + 1 + "_extraPerk", var_7);
    }
  }

  var_8 = var_1._id_9690;
  var_9 = scripts\mp\perks\perks::_id_6C26(var_8);
  var_0 _meth_80C7("rigTrait", var_9);
  var_10 = _id_09F1::_id_6CF8(var_1._id_965F);
  var_0 _meth_80C7("archetype", var_10);
}

_id_DAFA() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    _id_4A86();
  }

  if(!isDefined(self._id_8305)) {
    return 1;
  }

  return self._id_8305;
}

_id_EC08() {
  if(scripts\engine\utility::_id_5472("swapLoadout_blocked") && scripts\engine\utility::_id_546E("swapLoadout_blocked")) {
    self endon("death_or_disconnect");
    self endon("joined_team");
    self endon("joined_spectators");
    self notify("swapLoadout");
    self endon("swapLoadout");

    if(!scripts\engine\utility::_id_546E("swapLoadout_pending")) {
      scripts\engine\utility::_id_5474("swapLoadout_pending");
    }

    self waittill("swapLoadout_blocked");
  }

  _id_D4D3(self.pers["class"]);
  self._id_046D = undefined;
  self._id_ED41 = undefined;
  scripts\mp\weapons::_id_CB54();
  scripts\mp\weapons::_id_CB3F();

  if(scripts\mp\utility\game::_id_159D()) {
    scripts\mp\utility\stats::_id_7DAE("classChanges", 1);
  }

  _id_6FB1(self.pers["team"], self.pers["class"], undefined, 1);

  if(scripts\engine\utility::_id_5472("swapLoadout_pending") && scripts\engine\utility::_id_546E("swapLoadout_pending")) {
    scripts\engine\utility::_id_5470("swapLoadout_pending");
    scripts\engine\utility::_id_5474("swapLoadout_complete");
  }
}

_id_6FB1(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("giveLoadout_start");
  self._id_6DF0 = 1;

  if(isDefined(self.perks)) {
    self._id_AA37 = self.perks;
  }

  if(!istrue(var_5)) {
    _id_961F(var_3);
  } else {
    self switchtoweapon("none");
    thread _id_9620(var_3);
  }

  var_6 = _id_962D();
  var_6 = _id_9646(var_6, var_1);
  self._id_704A = var_6;
  var_7 = undefined;

  if(isDefined(self._id_BB9A)) {
    var_7 = self._id_BB9A;
    self._id_BB9A = undefined;
    self._id_37FF = _id_6962(var_1);

    if(_id_07D1::_id_60BE("prematch_done")) {
      self _meth_8881(self._id_37FF);
    }
  } else {
    var_7 = _id_962A();
    var_7 = _id_963A(var_7, var_1);
  }

  self._id_3808 = var_7;
  _id_964A(var_6, var_7, var_1, var_2, var_4);

  if(var_1 != "juggernaut") {
    loadout_setcodcasterclientloadoutdata(var_7);

    if(_id_07D1::_id_60BE("prematch_done")) {
      _id_9635(var_6, var_7, var_1);
    }
  }

  self._id_6DF0 = 0;
  _id_C6A9();
  self notify("changed_kit");
  self notify("giveLoadout");
  scripts\mp\rank::_id_F756();

  if(!istrue(game["isLaunchChunk"])) {
    scripts\mp\killstreaks\killstreaks::_id_C612();
  }

  scripts\mp\playerlogic::_id_F73D();
  thread _id_A142();
  thread scripts\cp_mp\utility\player_utility::monitorammoregen();
}

loadout_setcodcasterclientloadoutdata(var_0) {
  if(level.codcasterenabled) {
    if(!isPlayer(self) && !isalive(self)) {
      return;
    }
    if(isagent(self)) {
      return;
    }
    thread _id_D4D8(self, var_0);
  }
}

_id_9635(var_0, var_1, var_2) {
  if(!isPlayer(self) && !isalive(self)) {
    return;
  }
  if(isagent(self)) {
    return;
  }
  if(isbot(self) || _func_03DA(self) || isai(self)) {
    return;
  }
  if(getdvarint("#x366fca6702ea24ddf") == 0) {
    return;
  }
  if(var_1._id_87C3) {
    var_3 = 99;
    var_4 = "copied";
  } else {
    var_3 = _id_6962(var_2);
    var_4 = _id_962C(var_2);
    var_5 = _func_00D6(var_2, 0, 7) == "default";

    if(var_5) {
      var_3 = var_3 + 20;
    }
  }

  var_6 = var_1._id_F8D6 || var_1._id_60CC;
  var_1._id_F8D6 = 0;
  var_1._id_60CC = 0;
  var_7 = 0;

  if(!isDefined(self.pers["loggedClasses"])) {
    self.pers["loggedClasses"] = [];
  }

  var_8 = -1;

  foreach(var_12, var_10 in self.pers["loggedClasses"]) {
    var_11 = self.pers["loggedClasses"][var_12];

    if(var_11 == var_3) {
      if(var_6) {
        var_7 = var_7 + 1;
        continue;
      }

      var_8 = var_12;
    }
  }

  if(var_8 == -1 || var_1._id_87C3) {
    var_8 = self.pers["loggedClasses"].size;
    self.pers["loggedClasses"][var_8] = var_3;
    var_13 = "";
    var_14 = var_1._id_968A;
    var_15 = _func_02F7(var_14);

    if(isDefined(var_15)) {
      var_16 = _func_02F6(var_14);

      if(isDefined(var_16)) {
        var_13 = _func_0222(var_16, 0, var_15, 17);
      }
    }

    var_17 = "";
    var_18 = var_1._id_9699;
    var_19 = _func_02F7(var_18);

    if(isDefined(var_19)) {
      var_16 = _func_02F6(var_18);

      if(isDefined(var_16)) {
        var_17 = _func_0222(var_16, 0, var_19, 17);
      }
    }

    var_20 = spawnStruct();
    var_20.lifeindex = self.pers["telemetry"]._id_9365.life_index;
    var_20._id_704A = var_0;
    var_20._id_3808 = var_1;
    var_20.classtype = var_4;
    var_20._id_9678 = var_8;
    var_20.loadoutversionnumber = var_7;
    var_20.primaryblueprint = var_13;
    var_20.secondaryblueprint = var_17;
    _id_06E2::_id_4C2A("callback_player_new_loadout_used", var_20);
  }

  if(!isDefined(self._id_9678) || self._id_9678 != var_8) {
    var_20 = spawnStruct();
    var_20.player = self;
    var_20._id_704A = var_0;
    var_20._id_EA6A = var_1;
    var_20.class = var_2;
    _id_06E2::_id_4C2A("callback_player_loadout_changed", var_20);
  }

  self._id_9678 = var_8;
}

_id_75C0() {
  return isDefined(self.pers) && isDefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

_id_C151() {
  if(isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
  }
}

_id_0BBC(var_0) {
  if(!istrue(var_0)) {
    self._id_7611 = undefined;
  }

  if(isDefined(self._id_C887)) {
    _id_080B::_id_C878(1);
  }

  if(isDefined(self._id_C888)) {
    _id_080B::_id_C878(0);
  }

  if(!istrue(var_0)) {
    self _meth_809E();
  }

  _id_0A12::_id_395E(istrue(var_0));
}

_id_F42E() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(var_0.basename != "trophy_mp") {
      continue;
    }
    if(!isDefined(self._id_C887)) {
      continue;
    }
    _id_080B::_id_C880(1);
    self waittill("offhand_end");

    if(_id_080B::_id_8A09(self getcurrentweapon()) && isDefined(self._id_C888)) {
      _id_080B::_id_C880(0);
    }
  }
}

_id_8AB9(var_0) {
  if(isDefined(var_0) && var_0.basename != "none") {
    if(scripts\mp\utility\weapon::_id_8A7D(var_0.basename)) {
      return 1;
    }

    var_1 = scripts\mp\utility\weapon::_id_6A18(var_0.basename);

    if(isDefined(var_1) && var_1 == "lethal") {
      return 1;
    }
  }

  return 0;
}

_id_F42C() {
  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(!isnullweapon(var_0) && var_0.basename == "s4_c4_mp" && _id_080B::_id_8A09(self getcurrentweapon())) {
      self._id_AB8F = 1;
    }

    waitframe();
  }
}

_id_F433() {
  if(!istrue(self._id_AB8F)) {
    var_0 = self getheldoffhand();

    if(!isnullweapon(var_0) && var_0.basename != "s4_c4_mp" && _id_080B::_id_8A09(self getcurrentweapon()) && _id_8AB9(var_0)) {
      self._id_AB8F = 1;
    }
  }
}

_id_F42D(var_0) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");
  childthread _id_F42C();

  if(isDefined(var_0)) {
    self._id_10A15 = var_0;
  } else if(!isDefined(self._id_10A15)) {
    self._id_10A15 = 0;
  }

  while(_id_080B::_id_C87D()) {
    _id_F433();

    if(!istrue(self.inlaststand)) {
      if(istrue(self._id_10A15)) {
        self._id_9063 = 1;
        self._id_9064 = gettime() + 1000;
      } else if(isDefined(self._id_9064) && gettime() >= self._id_9064) {
        self._id_9063 = undefined;
        self._id_9064 = undefined;
      }

      self._id_10A15 = 0;
    } else {
      self._id_9063 = undefined;
      self._id_9064 = undefined;
      self._id_10A15 = 1;
    }

    if(self isonladder()) {
      _id_F430();
    } else if(self _meth_86C8()) {
      _id_F430();
    } else if(self _meth_86C9()) {
      _id_F431();
    } else if(self _meth_86B8() || self isskydiving()) {
      _id_F430();
    } else if(istrue(self._id_9063)) {
      _id_F430();
    } else if(istrue(self._id_AB8F)) {
      if(isnullweapon(self getheldoffhand())) {
        self._id_AB8F = undefined;
        _id_F432();
      } else
        _id_F430();
    } else
      _id_F432();

    waitframe();
  }

  _id_F432();
}

_id_F430() {
  var_0 = isDefined(self._id_C887);
  var_1 = isDefined(self._id_C888);

  if(!var_1) {
    if(var_0) {
      _id_080B::_id_C880(1);
    } else {
      _id_080B::_id_C875(0, _id_080B::_id_C87A());
    }
  }
}

_id_F42F() {
  var_0 = isDefined(self._id_C887);
  var_1 = isDefined(self._id_C888);

  if(!var_0) {
    if(var_1) {
      _id_080B::_id_C880(0);
    } else {
      _id_080B::_id_C875(1, _id_080B::_id_C87A());
    }
  }
}

_id_F431() {
  var_0 = isDefined(self._id_C887);
  var_1 = isDefined(self._id_C888);

  if(var_0) {
    _id_080B::_id_C878(1);
  }

  if(var_1) {
    _id_080B::_id_C878(0);
  }
}

_id_F432() {
  if(_id_080B::_id_C87D()) {
    var_0 = _id_080B::_id_8A09(self getcurrentweapon());

    if(var_0) {
      _id_F42F();
      return;
    }

    _id_F430();
    return;
  } else {
    var_1 = isDefined(self._id_C887);
    var_2 = isDefined(self._id_C888);

    if(var_1) {
      _id_080B::_id_C878(1);
    }

    if(var_2) {
      _id_080B::_id_C878(0);
    }
  }
}

_id_C88B(var_0) {
  if(_id_080B::_id_C87D()) {
    thread _id_F42D();
  } else {
    _id_F432();
    _id_C884();
    self notify("riotshield_detach");
  }
}

_id_C884(var_0) {
  self._id_9063 = undefined;
  self._id_9064 = undefined;
  self._id_10A15 = undefined;

  if(istrue(var_0)) {
    self._id_75A5 = undefined;
    self._id_75A6 = undefined;
    self._id_C887 = undefined;
    self._id_C888 = undefined;
  }
}

_id_2D15(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    var_1 = scripts\mp\utility\weapon::_id_10D60(var_0, var_4);

    if(!isDefined(var_1)) {
      var_1 = [];
    }
  }

  return _id_2D12(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

buildweapon_blueprint(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\mp\utility\weapon::_id_10D60(var_0, var_3);

  if(!isDefined(var_7)) {
    var_7 = [];
  }

  return _id_2D12(var_0, var_7, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_2D12(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  foreach(var_12, var_11 in var_1) {
    var_8[var_8.size] = var_12;
    var_9[var_9.size] = var_11;
  }

  return buildweapon(var_0, var_8, var_2, var_3, var_4, var_9, var_5, var_6, var_7);
}

_id_2D13(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  return buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {} else
    var_1 = [];

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(isDefined(var_4) && var_4 < 0) {
    var_4 = undefined;
  }

  var_9 = _id_2D16(var_0, var_4);
  var_10 = _id_2D17(var_1, var_5);

  if(istrue(var_8)) {
    if(scripts\mp\utility\weapon::_id_10DDC(var_9)) {
      var_11 = scripts\mp\utility\weapon::_id_6E7C(var_9);

      if(!scripts\engine\utility::array_contains(var_1, var_11)) {
        var_1[var_1.size] = var_11;

        if(var_10.size > 0) {
          var_10[var_11] = 0;
        }
      }
    }
  }

  var_12 = _id_2D20(var_0, var_1, var_4, var_10);

  if(isDefined(var_6) && var_6 != "none") {
    var_12[var_6] = 0;
  }

  var_12 = _id_5A4D(var_12, var_9);
  var_1 = [];
  var_5 = [];

  foreach(var_15, var_14 in var_12) {
    var_1[var_1.size] = var_15;
    var_5[var_5.size] = var_14;
  }

  if(!isDefined(level.activeattachmentoverrides)) {
    level.activeattachmentoverrides = [];
  }

  foreach(var_15 in var_1) {
    for(var_17 = 0; var_17 < var_1.size; var_17++) {
      var_18 = scripts\mp\utility\weapon::_id_1DA5(var_1[var_17]);

      if(isDefined(level.attachmentmap_combooverrides[var_15]) && isDefined(level.attachmentmap_combooverrides[var_15][var_18])) {
        var_19 = level.attachmentmap_combooverrides[var_15][var_18];
        level.activeattachmentoverrides[var_15] = var_18;
        var_1[var_17] = var_19;
      }
    }
  }

  var_21 = makeweapon(var_9, [], undefined, var_2, var_4);

  for(var_22 = 0; var_22 < var_1.size; var_22++) {
    if(var_5[var_22] > 0) {
      var_23 = var_21 _meth_8889(var_1[var_22], var_5[var_22]);

      if(!var_23) {
        var_5[var_22] = 0;
      }
    }

    var_21 = var_21 _meth_8669(var_1[var_22], var_5[var_22]);
  }

  if(isDefined(var_7)) {
    for(var_22 = 0; var_22 < var_7.size; var_22++) {
      var_24 = var_7[var_22];

      if(var_24 == "none") {
        continue;
      }
      if("i/" != _func_00D6(var_24, 0, 2)) {
        var_24 = "i/" + var_7[var_22];
      }

      var_21 = var_21 _meth_8671(var_22, var_24);
    }
  }

  if(isDefined(var_21._id_0389) && !_func_010D(var_21._id_0389, "ironsdefault")) {
    var_25 = _id_6CF2(var_3);

    if(isDefined(var_25)) {
      var_21 = var_21 _meth_8674(var_25);
    }
  }

  return var_21;
}

_id_2D17(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_1)) {
    foreach(var_5, var_4 in var_0) {
      if(var_5 < var_1.size) {
        var_2[var_4] = var_1[var_5];
        continue;
      }

      var_2[var_4] = 0;
    }
  }

  return var_2;
}

_id_2D20(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 < 0) {
    var_2 = undefined;
  }

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  var_3 = scripts\engine\utility::_id_1BC6(var_3, "none");

  if(var_1.size > 0 && var_3.size == 0) {
    foreach(var_5 in var_1) {
      var_3[var_5] = 0;
    }
  }

  var_7 = scripts\mp\utility\weapon::_id_10D62(var_0, var_2);
  var_8 = _id_2D16(var_0, var_2);
  var_9 = [];

  if(isDefined(var_7)) {
    var_9 = _id_3AD1(var_7, var_3);
  }

  var_10 = [];

  if(var_9.size > 0) {
    var_9 = _id_5A45(var_9, var_0);

    foreach(var_5, var_12 in var_9) {
      var_13 = scripts\mp\utility\weapon::_id_1DA9(var_5, var_8);
      var_10[var_13] = var_12;
    }
  }

  var_14 = [];
  var_15 = 0;
  var_16 = undefined;

  foreach(var_23, var_12 in var_10) {
    var_18 = scripts\mp\utility\weapon::_id_1DA8(var_23);

    if(isDefined(var_18)) {
      var_19 = 0;

      if(isDefined(var_2)) {
        var_20 = scripts\mp\utility\weapon::_id_1DA5(var_18);
        var_19 = scripts\mp\utility\weapon::_id_1DA4(var_20, var_0, var_2);
      }

      var_21 = scripts\mp\utility\weapon::_id_1DA9(var_18, var_8);
      var_14[var_21] = var_19;
    }

    var_22 = scripts\mp\utility\weapon::_id_1DA5(var_23);

    if(!isDefined(var_16) && _id_879E(var_22)) {
      var_16 = var_23;
    }

    if(!var_15 && (_id_8A36(var_22) || _id_8A35(var_23))) {
      var_15 = 1;
    }
  }

  if(var_14.size > 0) {
    var_10 = scripts\engine\utility::_id_1B9E(var_10, var_14);
  }

  if(isDefined(var_16) && var_15) {
    var_16 = scripts\engine\utility::ter_op(var_16 == "calsmg_mike4", "calsil_mike4smg", "calsil");
    var_10[var_16] = 0;
  }

  return var_10;
}

_id_3AD1(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(scripts\engine\utility::_id_1BA1(var_1, var_5)) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4;
  }

  return var_2;
}

_id_5A45(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = getfirstarraykey(var_0);
  var_4[0] = var_5;

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    var_7 = var_4[var_6];

    if(var_7 != "none") {
      var_8 = scripts\mp\utility\weapon::_id_1DA9(var_7, var_1);
      var_9 = 1;

      for(var_10 = 0; var_10 < var_2.size; var_10++) {
        var_11 = var_2[var_10];

        if(var_11 == "") {
          continue;
        }
        if(var_7 == var_11) {
          var_9 = 0;
          break;
        }

        var_12 = scripts\mp\utility\weapon::_id_1DB2(var_7, var_11, var_1, var_8, var_3[var_10]);

        if(var_12 == var_7) {
          var_2[var_10] = "";
          var_3[var_10] = "";
          continue;
        }

        if(var_12 != "") {
          var_2[var_10] = "";
          var_3[var_10] = "";
          var_9 = 0;
          var_13 = [];
          var_13 = strtok(var_12, " ");

          for(var_14 = 0; var_14 < var_13.size; var_14++) {
            var_4[var_4.size] = var_13[var_14];
          }

          break;
        }
      }

      if(var_9) {
        var_15 = var_2.size;
        var_2[var_15] = var_7;
        var_3[var_15] = var_8;
      }
    }

    if(var_6 == var_4.size - 1) {
      var_5 = getnextarraykey(var_0, var_5);

      if(isDefined(var_5)) {
        var_4[var_4.size] = var_5;
      }
    }
  }

  var_16 = [];

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];

    if(var_7 != "") {
      var_17 = scripts\engine\utility::ter_op(isDefined(var_0[var_7]), var_0[var_7], 0);
      var_16[var_7] = var_17;
    }
  }

  return var_16;
}

_id_5A4D(var_0, var_1) {
  var_2 = makeweapon(var_1);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_2 _meth_8629(var_6)) {
      var_3[var_6] = var_5;
      continue;
    }

    thread _id_84F8(var_6, var_1);
  }

  return var_3;
}

_id_84F8(var_0, var_1) {
  var_2 = "Invalid Attachment: " + var_0 + " on " + var_1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("#x3decf448ab3afab5f", 0) == 1) {
      self iprintlnbold(var_2);
    } else {}
  }
}

_id_2D16(var_0, var_1) {
  return scripts\mp\utility\weapon::_id_10D5F(var_0, var_1);
}

_id_6CF2(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = int(_func_0222("mp/reticleTable.csv", 1, var_0, 5));

  if(!isDefined(var_1) || var_1 == 0) {
    return undefined;
  }

  return var_1;
}

_id_879E(var_0) {
  return var_0 == "calcust" || var_0 == "calsmg" || var_0 == "calsmgdrums";
}

_id_8A35(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "barsil_") || var_0 == "barcust2_mpapa5";
}

_id_8A36(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "silencer");
}

issubsonicbullet(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "ammo_subsonic");
}

_id_8B0D(var_0) {
  var_1 = getweaponattachments(var_0);

  foreach(var_3 in var_1) {
    var_4 = scripts\mp\utility\weapon::_id_1DA5(var_3);

    if(_id_8A36(var_4) || _id_8A35(var_3) || issubsonicbullet(var_3)) {
      return 1;
    }
  }

  return 0;
}

_id_6E80(var_0, var_1) {
  return _id_07ED::_id_6C17(var_0, var_1);
}

_id_10D9C(var_0, var_1, var_2) {
  var_3 = _id_6E80(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0) {
    return 0;
  }

  foreach(var_5 in var_3) {
    if(var_2 == var_5) {
      return 1;
    }
  }

  return 0;
}

_id_6E92(var_0, var_1) {
  var_2 = [];
  var_3 = _id_6E80(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = _id_07FD::_id_6C13(var_5);

      if(!isDefined(var_6)) {
        continue;
      }
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

_id_C55D() {
  var_0 = self.pers["team"];
  var_1 = self.pers["class"];
  var_2 = self getweaponslistall();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = var_4.basename;

    if(var_5 == "s4_mg_streak_mp" || var_5 == "s4_la_walpha2_mp") {
      continue;
    }
    self givemaxammo(var_4);
    self setweaponammoclip(var_4, 9999);

    if(var_5 == "claymore_mp" || var_5 == "claymore_detonator_mp") {
      self setweaponammostock(var_4, 2);
    }
  }
}

_id_AB5E() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 enableplayerbreathsystem(0);

    if(!isDefined(var_0.pers["class"])) {
      var_0.pers["class"] = "";
    }

    if(!isDefined(var_0.pers["lastClass"])) {
      var_0.pers["lastClass"] = "";
    }

    var_0.class = var_0.pers["class"];
    var_0._id_8FAF = var_0.pers["lastClass"];
    var_0._id_33DA = var_0.pers["changedArchetypeInfo"];
    var_0._id_8F8C = undefined;

    if(!isDefined(var_0.pers["validationInfractions"])) {
      var_0.pers["validationInfractions"] = 0;
    }
  }
}

onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0._id_AC3D._id_6285) && var_0._id_AC3D._id_6285 == "female") {
      var_0 _meth_84A8("gender", "female");
    } else {
      var_0 _meth_84A8("gender", "");
    }

    if(isDefined(var_0._id_AC43)) {
      var_0 _meth_8680("mp_spawn_camera");
      var_0._id_AC43 stoploopsound(self._id_AC44);
      var_0._id_AC43 delete();
      var_0._id_AC43 = undefined;
      var_0._id_AC44 = undefined;
    }

    if(isDefined(var_0._id_AC3D._id_10691)) {
      switch (var_0._id_AC3D._id_10691) {
        case "alic":
          var_0 _meth_8300("cloth");
          break;
        case "azur":
          var_0 _meth_8300("cloth");
          break;
        case "chly":
          var_0 _meth_8300("cloth");
          break;
        case "golm":
          var_0 _meth_8300("vestheavy");
          break;
        case "ygr":
          var_0 _meth_8300("cloth");
          break;
        case "zane":
          var_0 _meth_8300("cloth");
          break;
        default:
          var_0 _meth_8300("vestlight");
          break;
      }
    }

    var_0 thread _id_505B();
    var_0 thread carefulmovementmonitor();
    var_0 setclientomnvar("ui_binoculars", 0);
  }
}

_id_58B1(var_0, var_1) {
  wait(var_0);
  self fadeovertime(var_1);
  self.alpha = 0;
}

_id_D4D3(var_0) {
  self._id_413A = var_0;
}

_id_754C() {
  if(isDefined(self._id_8FAF) && self._id_8FAF != self.class || !isDefined(self._id_8FAF)) {
    return 1;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && (!isDefined(self._id_8F2E) || self._id_8F2E != self._id_7E15)) {
    return 1;
  }

  return 0;
}

_id_754B() {
  if(isDefined(self._id_33DA)) {
    if(!isDefined(self._id_8F8C)) {
      return 1;
    }

    if(self._id_33DA != self._id_8F8C) {
      return 1;
    }
  }

  return 0;
}

_id_C5FE() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");

  if(!self _meth_8684()) {
    self setactionslot(5, "");
    self setactionslot(6, "");
    self setactionslot(7, "");
  }
}

_id_C614() {
  self _meth_80D6(0);
  self setclientomnvar("ui_hide_hud", 0);
  _func_0264(self, 1);

  if(level._id_9F28) {
    self setclientomnvar("ui_hide_minimap", 0);
  } else {
    self setclientomnvar("ui_hide_minimap", 1);
  }

  scripts\common\input_allow::_id_38AB();
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_10168(self, 1);
  self._id_4EA1 = undefined;
  self._id_4EA2 = undefined;
  self.enabledcollisionnotifies = undefined;
  self._id_5245 = undefined;
  self._id_9F2B = undefined;
  self._id_8A6C = undefined;
  self._id_8780 = undefined;
  self._id_A546 = undefined;
  self._id_BBAB = undefined;
  self._id_8E91 = undefined;
  _id_07C3::_id_C602();
  _id_07C3::_id_392F();
  _id_C884();
  scripts\cp_mp\utility\player_utility::_id_3937();
  scripts\mp\weapons::_id_3927();
  _id_0A11::_id_A047();
  _id_0A1B::_id_F1B5();
  _id_0A1C::_id_F1C6();
  _id_0A0B::_id_3940(1);
  _id_0A0D::_id_614F(1);
  scripts\mp\utility\player::_id_7900();
  _id_09BE::_id_3956();
  _id_09B5::_id_9B3F();
  scripts\mp\utility\player::_id_0CBD();
  scripts\cp_mp\utility\player_utility::_id_B6D8();
}

_id_3976() {
  self setscriptablepartstate("CompassIcon", "defaultIcon");
}

_id_00E0(var_0, var_1, var_2) {
  if(isDefined(self._id_33DA)) {
    var_3 = self._id_33DA;

    if(var_3._id_1A35 == var_0 && var_3._id_EB09 == var_1 && var_3._id_F462 == var_2) {
      return;
    }
  }

  var_4 = spawnStruct();
  var_4._id_1A35 = var_0;
  var_4._id_EB09 = var_1;
  var_4._id_F462 = var_2;
  self._id_33DA = var_4;
  self.pers["changedArchetypeInfo"] = var_4;

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    _id_BB98(self.pers["class"]);

    if(_id_DAFA()) {
      thread _id_EC08();
    } else if(isalive(self)) {
      self iprintlnbold(game["strings"]["change_rig"]);
    }
  }
}

_id_68E4(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment");
  return var_2 + (var_0 + 1);
}

_id_6D8F(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "primary", "loadoutPrimarySticker", "loadoutSecondarySticker");

  if(var_0 == 0) {
    return var_2;
  }

  return var_2 + (var_0 + 1);
}

_id_6B49() {
  return 10;
}

_id_6B4B() {
  return 10;
}

_id_6B39(var_0) {
  return scripts\engine\utility::ter_op(var_0 == "primary", _id_6B49(), _id_6B4B());
}

_id_5A40(var_0, var_1) {
  if(!level._id_15BD) {
    return;
  }
  var_2 = [];
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_5 == "none") {
      var_2[var_2.size] = var_6;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  if(var_2.size > 0) {
    self.pers["hackedStreaks"] = 1;
  }

  foreach(var_8 in var_2) {
    var_9 = _id_5AED(var_3);

    if(var_8 + 1 == 1) {
      var_1._id_9679 = var_9;
    } else if(var_8 + 1 == 2) {
      var_1._id_967A = var_9;
    } else {
      var_1._id_967B = var_9;
    }

    var_3[var_3.size] = var_9;
  }

  return [var_1._id_9679, var_1._id_967A, var_1._id_967B];
}

_id_5AED(var_0) {
  var_1 = [];

  foreach(var_8, var_3 in game["killstreakTable"]._id_EC74) {
    if(!istrue(int(var_3["shownInMenu"]))) {
      continue;
    }
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_8 == var_6 || scripts\mp\killstreaks\killstreaks::_id_2EC5(var_8) == scripts\mp\killstreaks\killstreaks::_id_2EC5(var_6)) {
        var_4 = 1;
        break;
      }
    }

    if(!istrue(var_4)) {
      var_1[var_1.size] = var_8;
    }
  }

  return var_1[0];
}

_id_C55B(var_0) {
  if(!level._id_15BD) {
    return;
  }
  var_1 = _id_09D6::_id_9422();

  if(!var_1) {
    if(var_0._id_9679 == "bradley") {
      var_0._id_9679 = "pac_sentry";
    } else if(var_0._id_967A == "bradley") {
      var_0._id_967A = "pac_sentry";
    } else if(var_0._id_967B == "bradley") {
      var_0._id_967B = "pac_sentry";
    }

    self.pers["hackedStreaks"] = 1;
  }

  return [var_0._id_9679, var_0._id_967A, var_0._id_967B];
}

_id_C55C(var_0) {
  return ["specialist_perk_1", "specialist_perk_2", "specialist_perk_3", "specialist_perk_bonus"];
}

_id_FC91() {
  self endon("disconnect");
  level endon("game_ended");
  self._id_8305 = 1;

  if(scripts\mp\utility\game::getgametype() == "br" && _id_07D1::_id_60BE("prematch_done")) {
    _id_4A86();
  } else if(scripts\mp\utility\game::getgametype() != "br") {
    _id_FC92();
    _id_4A86();
  }
}

_id_FC92() {
  self endon("death");
  var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 0, 15);
  _id_07D1::_id_60C2("prematch_done");

  if(scripts\mp\utility\perk::_hasperk("specialty_tune_up")) {
    var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 0, 5);
  }

  wait(var_0);
}

_id_4A86() {
  if(level.mapname == "mp_firingrange" || level.mapname == "mp_s4_practice") {
    return;
  }
  if(istrue(self._id_8305)) {
    self._id_8305 = 0;

    if(scripts\mp\utility\game::_id_8A95()) {
      self._id_C7BC = self.class;
      self.pers["next_round_class"] = self.class;
    }
  }
}

_id_8AE0(var_0) {
  return isDefined(var_0) && var_0 != "";
}

_id_6962(var_0) {
  return level._id_3803[var_0];
}

_id_BB98(var_0, var_1) {
  var_2 = _id_962E(var_0);
  _id_BB99(var_2, var_1);
  return var_2;
}

_id_BB99(var_0, var_1, var_2) {
  var_3 = scripts\mp\playerlogic::_id_6C42(var_0);
  scripts\mp\playerlogic::_id_96A6([var_3], var_1, var_2);
  self._id_BB9A = var_0;
  level notify("player_class_change", self);
}

_id_962E(var_0) {
  var_1 = _id_962C(var_0);
  var_2 = _id_6941(var_0, var_1);

  if(isDefined(var_2)) {
    if(!isDefined(var_2._id_968A) && isDefined(var_2._id_9688)) {
      var_2._id_968A = makeweaponfromstring(var_2._id_9688);
    }

    if(!isDefined(var_2._id_9699) && isDefined(var_2._id_9697)) {
      var_2._id_9699 = makeweaponfromstring(var_2._id_9697);
    }
  }

  if(isDefined(var_2)) {
    if(var_0 == "gamemode") {
      var_3 = _id_962A();
      var_3 = _id_963A(var_3, var_0);
      var_4 = _id_3AF9(var_3, var_2);

      if(!var_4) {
        var_3._id_60CC = 1;
        _id_F761(var_3, var_0, var_1);
        return var_3;
      }
    }

    return var_2;
  }

  var_5 = _id_962A();
  var_5 = _id_963A(var_5, var_0);
  _id_F761(var_5, var_0, var_1);
  return var_5;
}

_id_962D() {
  if(!isDefined(self.pers["globalLoadoutStruct"])) {
    _id_9648();
  }

  return self.pers["globalLoadoutStruct"];
}

_id_9648() {
  var_0 = spawnStruct();
  var_0._id_9674 = _id_2E84(0);
  var_0._id_9675 = _id_2E84(1);
  self.pers["globalLoadoutStruct"] = var_0;
}

_id_9624() {
  var_0 = _id_962D();
  _id_9648();
  var_1 = _id_962D();

  if(var_0._id_9674 != var_1._id_9674) {
    return 1;
  }

  if(var_0._id_9675 != var_1._id_9675) {
    return 1;
  }

  return 0;
}

_id_9647(var_0, var_1) {
  var_2 = self.pers["gamemodeLoadout"];

  if(isDefined(var_2["loadoutFieldUpgrade1"])) {
    var_0._id_9674 = var_2["loadoutFieldUpgrade1"];
  }

  if(isDefined(var_2["loadoutFieldUpgrade2"])) {
    var_0._id_9675 = var_2["loadoutFieldUpgrade2"];
  }
}

_id_9623(var_0) {
  var_1 = _id_962C(var_0);
  var_2 = _id_6941(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = _id_962A();
    var_3 = _id_963A(var_3, var_0);
    var_4 = _id_3AF9(var_3, var_2);

    if(!var_4) {
      var_3._id_F8D6 = 1;
      _id_F761(var_3, var_0, var_1);
      return 1;
    }
  }

  return 0;
}

_id_6941(var_0, var_1) {
  switch (var_1) {
    case "custom":
    case "gamemode":
    case "default":
      if(!isDefined(self.pers["classCache"])) {
        break;
      }

      return self.pers["classCache"][var_0];
  }

  return undefined;
}

_id_F761(var_0, var_1, var_2) {
  switch (var_2) {
    case "custom":
    case "gamemode":
    case "default":
      _id_109C(var_0, var_1);
      break;
  }
}

_id_109C(var_0, var_1) {
  if(!isDefined(self.pers["classCache"])) {
    self.pers["classCache"][var_1] = [];
  }

  self.pers["classCache"][var_1] = var_0;
}

_id_9625(var_0) {
  if(!isDefined(self.pers["classCache"])) {
    return;
  }
  self.pers["classCache"][var_0] = undefined;
}

_id_9629() {
  self.pers["classCache"]["gamemode"] = undefined;
}

_id_3D64(var_0) {
  self setclientomnvar("ui_loadout_copied", gettime());
  thread _id_0C52();
  var_1 = undefined;

  if(isDefined(var_0._id_8C2B) && isDefined(var_0._id_8C2B._id_BC15)) {
    var_1 = var_0._id_8C2B._id_BC15;
  } else {
    var_1 = var_0._id_3808;
  }

  self.pers["copiedClass"] = _id_9622(var_1);
  self.pers["lastKiller"] = var_0;
}

_id_0C52() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned");
  self setclientomnvar("ui_loadout_changed", 11);
}

_id_9627(var_0, var_1) {
  var_0._id_96A2 = var_1._id_96A2;
  var_0._id_96A0 = var_1._id_96A0;
  var_0._id_96A1 = var_1._id_96A1;
  var_0._id_9679 = var_1._id_9679;
  var_0._id_967A = var_1._id_967A;
  var_0._id_967B = var_1._id_967B;
  var_0._id_965E = var_1._id_965E;
  var_0._id_965C = var_1._id_965C;
  var_0._id_965D = var_1._id_965D;
  var_0._id_F8D6 = 0;
  var_0._id_60CC = 0;
  var_0._id_87C3 = 1;
}

_id_DBD7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_DBD7() && istrue(self._id_75B4)) {
    var_1 = 1;
  }

  if(istrue(self._id_10A1F)) {
    var_1 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && istrue(self._id_59DE)) {
    var_1 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "arena_evo") {
    var_1 = 1;
  }

  if(self._id_936C > 0) {
    var_1 = 1;
  }

  return var_1;
}

_id_C6BB(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_3 = 0;

  if(!isDefined(var_0) || var_0) {
    _id_C6BF(var_4);
  }

  if(!isDefined(var_1) || var_1) {
    _id_C6BA(var_4);
  }

  if(!isDefined(var_2) || var_2) {
    _id_C6BC(var_4);
  }

  if(!isDefined(var_3) || var_3) {
    _id_C6BD(var_4);
  }

  return var_4;
}

_id_C6A8(var_0) {
  self._id_C6A7 = var_0;
}

_id_C6B5() {
  return isDefined(self._id_C6A7);
}

_id_C6AB() {
  if(isDefined(self._id_C6A7)) {
    return self._id_C6A7;
  }

  return undefined;
}

_id_C6A9() {
  self._id_C6A7 = undefined;
}

_id_C6BF(var_0) {
  var_1 = [];
  var_2 = self.primaryweapons;
  var_3 = self._id_0133;

  foreach(var_5 in var_2) {
    if(scripts\mp\utility\weapon::_id_8799(var_5)) {
      var_1[var_1.size] = var_5;
    }
  }

  var_7 = undefined;

  if(isDefined(self._id_8F9F)) {
    var_7 = self._id_8F9F;
  } else if(!scripts\mp\utility\weapon::_id_8799(self._id_0133)) {
    var_7 = self._id_0133;
  } else if(var_1.size > 0) {
    var_7 = var_1[0];
  }

  if(_func_0376(var_7)) {
    var_7 = makeweapon("s4_me_fists_mp");
  }

  _id_C6BE(var_7, "primary", var_0);
  var_8 = undefined;

  foreach(var_5 in var_1) {
    if(!issameweapon(var_5, var_7, 1)) {
      var_8 = var_5;
      break;
    }
  }

  if(isDefined(var_8)) {
    _id_C6BE(var_8, "secondary", var_0);
  }
}

_id_C6BE(var_0, var_1, var_2) {
  if(!isDefined(var_2.weapons)) {
    var_2.weapons = [];
  }

  var_3 = spawnStruct();
  var_2.weapons[var_1] = var_3;
  var_3._id_10DB5 = var_0;
  var_3._id_39AE = self getweaponammoclip(var_0);
  var_3._id_E86A = self getweaponammostock(var_0);

  if(var_0._id_0216) {
    var_4 = var_0 getaltweapon();
    var_3._id_164B = self getweaponammoclip(var_4);
    var_3._id_1651 = self getweaponammostock(var_4);
  }
}

_id_C6BA(var_0) {
  _id_C6B9("primary", var_0);
  _id_C6B9("secondary", var_0);
}

_id_C6B9(var_0, var_1) {
  var_2 = scripts\mp\equipment::_id_69A4(var_0);

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(!isDefined(var_1.equipment)) {
    var_1.equipment = [];
  }

  var_3 = spawnStruct();
  var_1.equipment[var_0] = var_3;
  var_3._id_024F = var_2;

  if(var_2 != "none") {
    var_3._id_16CC = scripts\mp\equipment::_id_6A0F(var_3._id_024F);
  } else {
    var_3._id_16CC = 0;
  }
}

_id_C6BC(var_0) {
  var_1 = spawnStruct();
  var_1._id_EA14 = [];
  var_1._id_EA13 = self._id_EA13;

  if(!isDefined(self._id_EA13)) {
    return;
  }
  var_2 = scripts\mp\killstreaks\killstreaks::_id_6AE4(1);

  if(isDefined(var_2)) {
    var_1._id_EA14[var_1._id_EA14.size] = var_2.streakname;
  }

  var_2 = scripts\mp\killstreaks\killstreaks::_id_6AE4(2);

  if(isDefined(var_2)) {
    var_1._id_EA14[var_1._id_EA14.size] = var_2.streakname;
  }

  var_2 = scripts\mp\killstreaks\killstreaks::_id_6AE4(3);

  if(isDefined(var_2)) {
    var_1._id_EA14[var_1._id_EA14.size] = var_2.streakname;
  }

  if(var_1._id_EA14.size <= 0) {
    return;
  }
  var_0._id_EA17 = var_1;
}

_id_C6BD(var_0) {
  var_1 = scripts\mp\supers::_id_69B0();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = spawnStruct();
  var_0._id_EB4A = var_2;
  var_2._id_EB09 = var_1;
  var_2._id_EB3A = scripts\mp\supers::_id_69AD();
  var_2._id_5854 = scripts\mp\supers::_id_69AE();
}

_id_C6B8(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(var_0.weapons);
}

_id_C6B1(var_0, var_1) {
  return var_0.weapons[var_1]._id_10DB5;
}

_id_C6B3(var_0, var_1) {
  var_2 = var_0.weapons[var_1];
  self setweaponammoclip(var_2._id_10DB5, var_2._id_39AE);
  self setweaponammostock(var_2._id_10DB5, var_2._id_E86A);

  if(var_2._id_10DB5._id_0216) {
    var_3 = var_2._id_10DB5 getaltweapon();
    self setweaponammoclip(var_3, var_2._id_164B);
    self setweaponammostock(var_3, var_2._id_1651);
  }
}

_id_C6B4(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(var_0.equipment);
}

_id_C6AA(var_0, var_1) {
  return var_0.equipment[var_1]._id_024F;
}

_id_C6B2(var_0, var_1) {
  var_2 = _id_C6AA(var_0, var_1);

  if(!isDefined(var_2) || var_2 == "none") {
    return;
  }
  var_3 = var_0.equipment[var_1]._id_16CC;

  if(!isDefined(var_3)) {
    return;
  }
  scripts\mp\equipment::_id_D543(var_2, var_3);
}

_id_C6B6(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(var_0._id_EA17);
}

_id_C6AC(var_0) {
  return var_0._id_EA17._id_EA13;
}

_id_C6AD(var_0) {
  return var_0._id_EA17._id_EA14;
}

_id_C6B7(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(var_0._id_EB4A);
}

_id_C6B0(var_0) {
  return var_0._id_EB4A._id_EB09;
}

_id_C6AF(var_0) {
  return var_0._id_EB4A._id_EB3A;
}

_id_C6AE(var_0) {
  return var_0._id_EB4A._id_5854;
}

_id_E265(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = !var_2;

  if(var_4) {
    var_5 = 0;
    var_6 = 0;

    if(var_0 _meth_8624("akimbo", 1)) {
      self setweaponammoclip(var_3, var_5, "left");
    }
  } else {
    var_5 = var_3._id_00EB;
    var_6 = var_2 - 1;
  }

  if(var_2 == 7) {
    var_6 = weaponmaxammo(var_3);
  } else if(issubstr(var_3.basename, "s4_sh_lindia") && !var_4) {
    var_6 = var_3._id_00EB * var_6 + 18;
  } else {
    var_6 = var_3._id_00EB * var_6;
  }

  self setweaponammoclip(var_3, var_5);
  self setweaponammostock(var_3, var_6);

  if(var_0._id_0216) {
    var_7 = var_0 getaltweapon();

    if(var_4) {
      var_8 = 0;
      var_9 = 0;
    } else {
      var_8 = self getweaponammoclip(var_7);
      var_9 = self getweaponammostock(var_7);
    }

    self setweaponammoclip(var_7, var_8);
    self setweaponammostock(var_7, var_9);
  }
}

_id_3AF9(var_0, var_1) {
  if(!scripts\engine\utility::is_equal(var_0._id_965F, var_1._id_965F)) {
    return 0;
  }

  if(var_0._id_9683 != var_1._id_9683) {
    return 0;
  }

  if(!_id_34EA(var_0._id_9685, var_1._id_9685)) {
    return 0;
  }

  if(!_id_34EA(var_0._id_9684, var_1._id_9684)) {
    return 0;
  }

  if(var_0._id_9686 != var_1._id_9686) {
    return 0;
  }

  if(var_0._id_968C != var_1._id_968C) {
    return 0;
  }

  if(var_0._id_9689 != var_1._id_9689) {
    return 0;
  }

  if(var_0._id_968E != var_1._id_968E) {
    return 0;
  }

  if(var_0._id_9687 != var_1._id_9687) {
    return 0;
  }

  if(var_0._id_9692 != var_1._id_9692) {
    return 0;
  }

  if(!_id_34EA(var_0._id_9694, var_1._id_9694)) {
    return 0;
  }

  if(!_id_34EA(var_0._id_9693, var_1._id_9693)) {
    return 0;
  }

  if(var_0._id_9695 != var_1._id_9695) {
    return 0;
  }

  if(var_0._id_969A != var_1._id_969A) {
    return 0;
  }

  if(var_0._id_9698 != var_1._id_9698) {
    return 0;
  }

  if(var_0._id_969C != var_1._id_969C) {
    return 0;
  }

  if(var_0._id_9696 != var_1._id_9696) {
    return 0;
  }

  if(!_id_34EA(var_0._id_967F, var_1._id_967F)) {
    return 0;
  }

  if(!_id_34EA(var_0._id_969F, var_1._id_969F)) {
    return 0;
  }

  if(!_id_34EA(var_0._id_9670, var_1._id_9670)) {
    return 0;
  }

  if(var_0._id_96A3 != var_1._id_96A3) {
    return 0;
  }

  if(var_0._id_967D != var_1._id_967D) {
    return 0;
  }

  if(var_0._id_9680 != var_1._id_9680) {
    return 0;
  }

  if(var_0._id_9690 != var_1._id_9690) {
    return 0;
  }

  if(var_0._id_966A != var_1._id_966A) {
    return 0;
  }

  if(var_0._id_966E != var_1._id_966E) {
    return 0;
  }

  if(var_0._id_966B != var_1._id_966B) {
    return 0;
  }

  if(var_0._id_966F != var_1._id_966F) {
    return 0;
  }

  if(var_0._id_96A2 != var_1._id_96A2) {
    return 0;
  }

  if(var_0._id_9676 != var_1._id_9676) {
    return 0;
  }

  if(var_0._id_96A0 != var_1._id_96A0) {
    return 0;
  }

  if(var_0._id_96A1 != var_1._id_96A1) {
    return 0;
  }

  if(var_0._id_9679 != var_1._id_9679) {
    return 0;
  }

  if(var_0._id_967A != var_1._id_967A) {
    return 0;
  }

  if(var_0._id_967B != var_1._id_967B) {
    return 0;
  }

  return 1;
}

_id_34EA(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return 0;
  }

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_1[var_4])) {
      return 0;
    }

    if(var_1[var_4] != var_3) {
      return 0;
    }
  }

  return 1;
}

_id_FC7A(var_0, var_1) {
  var_2 = self;
  var_2.pers["gamemodeLoadout"][scripts\engine\utility::ter_op(var_1, "loadoutPrimary", "loadoutSecondary")] = var_0;
  var_3 = scripts\engine\utility::ter_op(var_1, 10, 10);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = _id_68E4(var_4, scripts\engine\utility::ter_op(var_1, "primary", "secondary"));
    var_2.pers["gamemodeLoadout"][var_5] = "none";
  }

  var_2 _id_C1AA();
}

_id_FC77(var_0, var_1) {
  var_2 = self;
  var_2.pers["gamemodeLoadout"][scripts\engine\utility::ter_op(var_1, "loadoutEquipmentPrimary", "loadoutEquipmentSecondary")] = var_0;
  var_2 scripts\mp\equipment::giveequipment(var_0, scripts\engine\utility::ter_op(var_1, "primary", "secondary"));
}

_id_FC78(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.pers["gamemodeLoadout"]["loadoutPerks"][var_1];

  if(isDefined(var_3) && var_3 != "specialty_null" && var_3 != "none" && isDefined(var_2.perks[var_3])) {
    var_2 scripts\mp\utility\perk::removeperk(var_3);
  }

  var_2.pers["gamemodeLoadout"]["loadoutPerks"][var_1] = var_0;
  var_2 scripts\mp\utility\perk::_id_6FC2(var_0);
}

_id_C1AA() {
  var_0 = self;
  var_1 = var_0 _id_962A();
  var_1 = var_0 _id_963A(var_1, "gamemode");
  _id_BB99(var_1, 1, 1);
  _id_6FB1(var_0.team, "gamemode", 1, 1);
  var_0 _meth_819C(var_1._id_968A);
  var_0 _meth_819C(var_1._id_9699);
  var_0 setclientomnvar("ui_player_notify_loadout", gettime());
  var_0 notify("notify_loadout_changed");
}

carefulmovementmonitor() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 = self getstance();
  var_1 = self playerads();
  var_2 = 0;

  for(;;) {
    var_0 = self getstance();
    var_1 = self playerads();
    var_3 = self._id_EB09;
    var_4 = isDefined(var_3) && isDefined(var_3._id_E76B._id_C189) && isDefined(var_3._id_FEA3);

    if(var_0 == "prone" || var_0 == "crouch" || var_1 >= 1) {
      if(!var_2 && !scripts\mp\utility\perk::_hasperk("specialty_quieter")) {
        scripts\mp\utility\perk::_id_6FC2("specialty_quieter");
        var_2 = 1;
      }
    } else if(var_2 && !scripts\mp\utility\perk::_hasperk("specialty_ninja")) {
      if((!var_4 || (var_3._id_E76B._id_C189 != "super_deadsilence" || var_3._id_FEA3 <= 0)) && scripts\mp\utility\perk::_hasperk("specialty_quieter") && !istrue(self.unmarkedactive)) {
        scripts\mp\utility\perk::removeperk("specialty_quieter");
      }

      var_2 = 0;
    } else if((!var_4 || (var_3._id_E76B._id_C189 != "super_deadsilence" || var_3._id_FEA3 <= 0)) && scripts\mp\utility\perk::_hasperk("specialty_quieter") && !istrue(self.unmarkedactive) && !scripts\mp\utility\perk::_hasperk("specialty_ninja"))
      scripts\mp\utility\perk::removeperk("specialty_quieter");

    waitframe();
  }
}

_id_505B() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self._id_41F5 = self getstance();
  self._id_9054 = self getstance();
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    self._id_9054 = self._id_41F5;
    self._id_41F5 = self getstance();

    if(self._id_41F5 == "prone" && self._id_9054 == "stand") {
      var_0 = 0.6;
      var_1 = 0.3;
      var_2 = 0;
    } else if(self._id_41F5 == "prone" && self._id_9054 == "crouch") {
      self _meth_800B(0);
      var_0 = 0.6;
      var_1 = 0;
      var_2 = 0;
      _id_F75B();
    } else if(self._id_41F5 == "crouch" && self._id_9054 == "prone") {
      self _meth_800B(0);
      var_0 = 0.4;
      var_1 = 0;
      var_2 = 0;
    } else if(self._id_41F5 == "stand" && self._id_9054 == "prone") {
      self _meth_800B(0);
      var_0 = 0.4;
      var_1 = 0;
      var_2 = 0;
      _id_F75B();
    } else if(var_0 != -1 && var_0 != 0 && var_2 >= var_0 + var_1) {
      self _meth_800B(1);
      var_0 = -1;
      var_1 = 0;
      var_2 = 0;
      scripts\mp\utility\weapon::_id_D69A(0, 0, 1);
      self _meth_829A();
      self._id_505C = undefined;
    } else if(var_0 > 0)
      var_2 = var_2 + 0.05;

    if(var_0 != -1 && var_0 != 0 && var_2 >= var_1) {
      self _meth_800B(0);
      _id_F75B();
    }

    waitframe();
  }
}

_id_F75B() {
  if(!istrue(self._id_505C) && !issubstr(self._id_0132.basename, "emike1")) {
    self._id_505C = 1;

    if(self._id_0133 _meth_8624("gunperk_acrobatic")) {
      scripts\mp\utility\weapon::_id_D69A(0, -6, 1);
      self _meth_8381(3);
    } else {
      scripts\mp\utility\weapon::_id_D69A(0, -30, 1);
      self _meth_8381(14);
    }
  }
}

_id_A142() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 = 4.3;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    if(var_2) {
      var_1 = var_1 + 0.05;

      if(var_1 >= var_0) {
        var_1 = 0;
        var_2 = 0;
        self _meth_86CD(1);
      }
    } else if(self issprintsliding()) {
      var_2 = 1;
      self _meth_86CD(0);
    } else if(self _meth_846A()) {
      var_2 = 1;
      self _meth_86CD(0);
    }

    waitframe();
  }
}