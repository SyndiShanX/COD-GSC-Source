/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\class.gsc
***********************************************/

function init() {
  level.classmap["class0"] = 0;
  level.classmap["class1"] = 1;
  level.classmap["class2"] = 2;
  level.classmap["custom1"] = 0;
  level.classmap["custom2"] = 1;
  level.classmap["custom3"] = 2;
  level.classmap["custom4"] = 3;
  level.classmap["custom5"] = 4;
  level.classmap["custom6"] = 5;
  level.classmap["custom7"] = 6;
  level.classmap["custom8"] = 7;
  level.classmap["custom9"] = 8;
  level.classmap["custom10"] = 9;
  level.classmap["axis_recipe1"] = 0;
  level.classmap["axis_recipe2"] = 1;
  level.classmap["axis_recipe3"] = 2;
  level.classmap["axis_recipe4"] = 3;
  level.classmap["axis_recipe5"] = 4;
  level.classmap["axis_recipe6"] = 5;
  level.classmap["allies_recipe1"] = 0;
  level.classmap["allies_recipe2"] = 1;
  level.classmap["allies_recipe3"] = 2;
  level.classmap["allies_recipe4"] = 3;
  level.classmap["allies_recipe5"] = 4;
  level.classmap["allies_recipe6"] = 5;
  level.classmap["gamemode"] = 0;
  level.classmap["custgamemode"] = 0;
  level.classmap["custgamemode1"] = 0;
  level.classmap["custgamemode2"] = 1;
  level.classmap["custgamemode3"] = 2;
  level.classmap["custgamemode4"] = 3;
  level.classmap["custgamemode5"] = 4;
  level.classmap["custgamemode6"] = 5;
  level.classmap["custgamemode7"] = 6;
  level.classmap["custgamemode8"] = 7;
  level.classmap["custgamemode9"] = 8;
  level.classmap["custgamemode10"] = 9;
  level.classmap["custgamemode_d1"] = 0;
  level.classmap["custgamemode_d2"] = 1;
  level.classmap["custgamemode_d3"] = 2;
  level.classmap["custgamemode_d4"] = 3;
  level.classmap["custgamemode_d5"] = 4;
  level.classmap["callback"] = 0;
  level.classmap["default1"] = 0;
  level.classmap["default2"] = 1;
  level.classmap["default3"] = 2;
  level.classmap["default4"] = 3;
  level.classmap["default5"] = 4;
  level.classmap["default6"] = 5;
  level.classmap["default7"] = 6;
  level.classmap["default8"] = 7;
  level.classmap["default9"] = 8;
  level.classmap["default10"] = 9;
  level.classmap["default11"] = 10;
  level.classmap["juggernaut"] = 0;
  level.defaultclass = "CLASS_ASSAULT";

  if(getdvarint("scr_br_mmp_defaultLoadouts", 0)) {
    level.classtablename = "mp/classtable_br_default_mmp.csv";
  } else if(level.gametype == "br" || level.gametype == "brtdm") {
    level.classtablename = "mp/classtable_br_default.csv";
  } else if(scripts\mp\utility\game::tv_station_intro_camera()) {
    var_0 = getdvarint("scr_classtable_override", 0);

    switch (var_0) {
      case 1:
        level.classtablename = "mp/classtable_snipers_only.csv";
        break;
      default:
        level.classtablename = "mp/classtable.csv";
        break;
    }

    setomnvar("ui_classtable_override", var_0);
  } else if(getdvarint("scr_test_loadouts", 0)) {
    level.classtablename = "mp/classtable_test.csv";
  } else if(scripts\mp\utility\game::isanymlgmatch()) {
    level.classtablename = "mp/classtable_cdl.csv";
  } else {
    level.classtablename = "mp/classtable.csv";
  }

  thread onplayerconnecting();
  thread onplayerspawned();
}

function getclasschoice(var_0) {
  return var_0;
}

function getweaponchoice(var_0) {
  var_1 = strtok(var_0, ",");

  if(var_1.size > 1) {
    return int(var_1[1]);
  }

  return 0;
}

function cac_getweapon(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "weapon");
}

function cac_getweaponattachment(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "attachment");
}

function force_interrupt_current_combat_action(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "attachmentSetup", var_2, "variantID");
}

function cac_getweaponlootitemid(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "lootItemID");
}

function cac_getweaponvariantid(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "variantID");
}

function cac_getweaponcamo(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "camo");
}

function cac_getweaponreticle(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "reticle");
}

function cac_getkillstreak(var_0, var_1) {
  var_2 = self getplayerdata(level.loadoutsgroup, "squadMembers", "killstreakSetups", var_0, "killstreak");
  return var_2;
}

function cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.archetype;
  }

  return "archetype_assault";
}

function cac_getequipmentprimary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "equipment");
}

function cac_getextraequipmentprimary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 0, "extraCharge");
}

function cac_getequipmentsecondary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "equipment");
}

function cac_getextraequipmentsecondary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "equipmentSetups", 1, "extraCharge");
}

function cac_getsuper() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.super;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
}

function cac_getfieldupgrade(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "fieldUpgrades", var_0);
}

function cac_getgesture() {
  var_0 = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    var_1 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", var_1, "gesture");
  } else {
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");
  }

  return scripts\cp_mp\gestures::getgesturedata(var_0);
}

function cac_getaccessoryweapon() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessoryweaponbyindex(var_0);
}

function cac_getaccessorydata() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::getaccessorydatabyindex(var_0);
}

function force_interrupt_all_current_combat_actions() {
  var_0 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\mp\accessories::register_respawn_functions(var_0);
}

function cac_getloadoutperk(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "loadoutPerks", var_1);
}

function cac_getloadoutextraperk(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "extraPerks", var_1);
}

function cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo)) {
    return self.changedarchetypeinfo.trait;
  }

  return self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePerk");
}

function cac_getusingspecialist(var_0) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "usingSpecialist");
}

function cac_getweaponcosmeticattachment(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "cosmeticAttachment");
}

function cac_getweaponsticker(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0, "weaponSetups", var_1, "sticker", var_2);
}

function recipe_getkillstreak(var_0, var_1, var_2) {
  return scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "kilstreakSetups", var_2, "killstreak");
}

function table_getarchetype(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutArchetype", var_1 + 1);
}

function table_getloadoutname(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutName", var_1 + 1);
}

function ref_139e4(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_2 == 0, "loadoutPrimaryAddBlueprintAttachments", "loadoutSecondaryAddBlueprintAttachments");
  var_4 = tablelookup(var_0, 0, var_3, var_1 + 1);

  if(var_4 == "") {
    return 0;
  }

  return istrue(int(var_4));
}

function table_getweapon(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimary", var_1 + 1);
  }

  return tablelookup(var_0, 0, "loadoutSecondary", var_1 + 1);
}

function table_getweaponattachment(var_0, var_1, var_2, var_3) {
  var_4 = "none";

  if(var_2 == 0) {
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryAttachment" + var_3 + 1, var_1 + 1);
  } else {
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryAttachment" + var_3 + 1, var_1 + 1);
  }

  if(var_4 == "" || var_4 == "none") {
    return "none";
  }

  return var_4;
}

function table_getweaponcamo(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimaryCamo", var_1 + 1);
  }

  return tablelookup(var_0, 0, "loadoutSecondaryCamo", var_1 + 1);
}

function table_getweaponreticle(var_0, var_1, var_2) {
  if(var_2 == 0) {
    return tablelookup(var_0, 0, "loadoutPrimaryReticle", var_1 + 1);
  }

  return tablelookup(var_0, 0, "loadoutSecondaryReticle", var_1 + 1);
}

function ref_139e6(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(var_2 == 0) {
    var_4 = tablelookup(var_0, 0, "loadoutPrimaryVariantID", var_1 + 1);
  } else {
    var_4 = tablelookup(var_0, 0, "loadoutSecondaryVariantID", var_1 + 1);
  }

  return ref_139e7(var_3, var_4);
}

function ref_139e7(var_0, var_1) {
  if(var_0 == "none") {
    return 0;
  }

  if(!isDefined(level.confirm_good_pickup_location)) {
    level.confirm_good_pickup_location = [];
    level.confirm_good_pickup_location["iw8_ar_tango21"] = [1];
    level.confirm_good_pickup_location["iw8_ar_mike4"] = [5];
    level.confirm_good_pickup_location["iw8_ar_kilo433"] = [3];
    level.confirm_good_pickup_location["iw8_ar_scharlie"] = [3];
    level.confirm_good_pickup_location["iw8_sm_uzulu"] = [4];
    level.confirm_good_pickup_location["iw8_sh_romeo870"] = [5];
    level.confirm_good_pickup_location["iw8_sh_dpapa12"] = [3];
    level.confirm_good_pickup_location["iw8_lm_mgolf34"] = [4];
    level.confirm_good_pickup_location["iw8_sn_kilo98"] = [16];
    level.confirm_good_pickup_location["iw8_sn_alpha50"] = [2];
    level.confirm_good_pickup_location["iw8_sn_hdromeo"] = [4];
    level.confirm_good_pickup_location["iw8_pi_golf21"] = [3];
    level.confirm_good_pickup_location["iw8_pi_cpapa"] = [15];
    var_2 = getDvar("scr_blockedClassTableVariants", "");

    if(var_2 != "") {
      var_3 = strtok(var_2, ",");

      foreach(var_5 in var_3) {
        var_6 = strtok(var_5, "|");

        if(var_6.size == 2) {
          var_7 = var_6[0];
          var_8 = int(var_6[1]);

          if(!isDefined(level.confirm_good_pickup_location[var_7])) {
            level.confirm_good_pickup_location[var_7] = [];
          }

          level.confirm_good_pickup_location[var_7][level.confirm_good_pickup_location[var_7].size] = var_8;
        }
      }
    }
  }

  var_10 = undefined;

  if(isDefined(level.confirm_good_pickup_location[var_0])) {
    var_10 = level.confirm_good_pickup_location[var_0];
  }

  var_11 = 0;
  var_12 = getdvarint("scr_forceClassTableVariantRandom", 0);

  if(var_12 == 1) {
    var_11 = scripts\mp\utility\weapon::runspawnmodule_isolated(var_0, var_10);
  } else {
    var_13 = strtok(var_1, " ");
    var_14 = [];

    foreach(var_16 in var_13) {
      var_17 = int(var_16);

      if(!isDefined(var_10) || !scripts\engine\utility::array_contains(var_10, var_17)) {
        var_14 = var_17;
      }
    }

    if(var_14.size != 0) {
      var_11 = var_14[randomint(var_14.size)];
    }
  }

  if(var_11 == -1) {
    var_11 = scripts\mp\utility\weapon::runspawnmodule_isolated(var_0, var_10);
  }

  var_19 = scripts\mp\utility\weapon::ref_1458c(var_0, var_11);

  if(!var_19) {
    var_11 = 0;
  }

  return var_11;
}

function table_getperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutPerk" + var_2 + 1, var_1 + 1);
}

function table_getextraperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutExtraPerk" + var_2 + 1, var_1 + 1);
}

function table_getequipmentprimary(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutEquipmentPrimary", var_1 + 1);
}

function table_getextraequipmentprimary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutExtraEquipmentPrimary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

function table_getequipmentsecondary(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutEquipmentSecondary", var_1 + 1);
}

function table_getextraequipmentsecondary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutExtraEquipmentSecondary", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

function table_getsuper(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutSuper", var_1 + 1);
}

function table_getspecialist(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "loadoutSpecialist", var_1 + 1);
  return isDefined(var_2) && var_2 == "TRUE";
}

function table_getgesture(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutGesture", var_1 + 1);
}

function table_getaccessory(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutAccessory", var_1 + 1);
}

function table_getexecution(var_0, var_1) {
  return tablelookup(var_0, 0, "loadoutExecution", var_1 + 1);
}

function table_getkillstreak(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "loadoutStreak" + var_2, var_1 + 1);
}

function loadout_getplayerstreaktype(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "streaktype_support":
      var_1 = "support";
      break;
    case "streaktype_specialist":
    case "specialist":
      var_1 = "specialist";
      break;
    case "streaktype_resource":
      var_1 = "resource";
      break;
    default:
      var_1 = "assault";
      break;
  }

  return var_1;
}

function getloadoutstreaktypefromstreaktype(var_0) {
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

function loadout_getclassteam(var_0) {
  if(self.team == "spectator") {
    var_0 = "none";
  }

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

function loadout_clearplayer(var_0) {
  loadout_clearweapons(var_0);
  _detachall(var_0);
  scripts\mp\equipment::clearallequipment();

  if(isDefined(self.loadoutarchetype)) {
    clearscriptable();
  }

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  loadout_clearperks(var_0);
  scripts\mp\perks\weaponpassives::forgetpassives();
  scripts\cp_mp\gestures::cleargesture();
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\accessories::clearplayeraccessory();
  scripts\mp\perks\perkpackage::ref_12301();

  if(!istrue(var_0)) {
    resetfunctionality();
    resetactionslots();
  }
}

function loadout_clearweapons(var_0) {
  if(istrue(var_0)) {
    if(isDefined(self.primaryweaponobj)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweaponobj);
    }

    if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "none") {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweaponobj);
    }
  } else {
    self takeallweapons();
  }

  self.primaryweapon = undefined;
  self.primaryweaponobj = undefined;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;
}

function loadout_giveperk(var_0) {
  if(!isDefined(self.loadoutperks)) {
    self.loadoutperks = [];
  }

  scripts\mp\utility\perk::giveperk(var_0);
  self.loadoutperks[self.loadoutperks.size] = var_0;
}

function loadout_removeperk(var_0) {
  if(isDefined(self.loadoutperks)) {
    var_1 = 0;
    var_2 = [];

    foreach(var_4 in self.loadoutperks) {
      if(!var_1) {
        if(var_4 == var_0) {
          scripts\mp\utility\perk::removeperk(var_4);
          var_1 = 1;
          continue;
        }
      }

      var_2 = var_4;
    }

    self.loadoutperks = var_2;
    return;
  }
}

function loadout_clearperks(var_0) {
  if(istrue(var_0)) {
    if(isDefined(self.loadoutperks)) {
      foreach(var_2 in self.loadoutperks) {
        scripts\mp\utility\perk::removeperk(var_2);
      }
    }
  } else {
    scripts\mp\perks\perks::_clearperks();
    self notify("all_perks_cleared");
  }

  self.loadoutperks = [];
  self notify("loadout_perks_cleared");
}

function loadout_getclassstruct() {
  var_0 = spawnStruct();
  var_0.loadoutarchetype = "none";
  var_0.loadoutprimary = "none";
  var_0.loadoutprimaryattachments = [];
  var_0.loadoutprimaryattachmentids = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0.loadoutprimaryattachments[var_1] = "none";
    var_0.loadoutprimaryattachmentids[var_1] = 0;
  }

  var_0.loadoutprimarycamo = "none";
  var_0.loadoutprimaryreticle = "none";
  var_0.loadoutprimarylootitemid = 0;
  var_0.loadoutprimaryvariantid = -1;
  var_0.loadoutprimarycosmeticattachment = "none";
  var_0.loadoutprimarystickers = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0.loadoutprimarystickers[var_2] = "none";
  }

  var_0.loadoutsecondary = "none";
  var_0.loadoutsecondaryattachments = [];
  var_0.loadoutsecondaryattachmentids = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0.loadoutsecondaryattachments[var_1] = "none";
    var_0.loadoutsecondaryattachmentids[var_1] = 0;
  }

  var_0.loadoutsecondarycamo = "none";
  var_0.loadoutsecondaryreticle = "none";
  var_0.loadoutsecondarylootitemid = 0;
  var_0.loadoutsecondaryvariantid = -1;
  var_0.loadoutsecondarycosmeticattachment = "none";
  var_0.loadoutsecondarystickers = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0.loadoutsecondarystickers[var_2] = "none";
  }

  var_0.loadoutmeleeslot = "none";
  var_0.loadoutperksfromgamemode = 0;
  var_0.loadoutperks = [];
  var_0.loadoutstandardperks = [];
  var_0.loadoutextraperks = [];
  var_0.loadoutrigtrait = "specialty_null";
  var_0.loadoutusingspecialist = 0;
  var_0.loadoutequipmentprimary = "none";
  var_0.loadoutextraequipmentprimary = 0;
  var_0.loadoutequipmentsecondary = "none";
  var_0.loadoutextraequipmentsecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutgesture = "none";
  var_0.loadoutaccessorydata = "none";
  var_0.loadoutaccessoryweapon = "none";
  var_0.loadoutstreaksfilled = 0;
  var_0.loadoutstreaktype = "streaktype_assault";
  var_0.loadoutkillstreak1 = "none";
  var_0.loadoutkillstreak2 = "none";
  var_0.loadoutkillstreak3 = "none";
  var_0.tweakedbyplayerduringmatch = 0;
  var_0.gamemodeforcednewloadout = 0;
  var_0.uavbestid = 0;
  return var_0;
}

function zombieregenratescaleingas(var_0) {
  var_1 = spawnStruct();
  var_1.loadoutarchetype = var_0.loadoutarchetype;

  if(isDefined(var_0.ref_11960)) {
    var_1.ref_11960 = var_0.ref_11960;
  }

  var_1.loadoutprimary = var_0.loadoutprimary;
  var_1.loadoutprimaryattachments = var_0.loadoutprimaryattachments;
  var_1.loadoutprimaryattachmentids = var_0.loadoutprimaryattachmentids;
  var_1.loadoutprimarycamo = var_0.loadoutprimarycamo;
  var_1.loadoutprimaryreticle = var_0.loadoutprimaryreticle;
  var_1.loadoutprimarylootitemid = var_0.loadoutprimarylootitemid;
  var_1.loadoutprimaryvariantid = var_0.loadoutprimaryvariantid;
  var_1.loadoutprimarycosmeticattachment = var_0.loadoutprimarycosmeticattachment;
  var_1.loadoutprimarystickers = var_0.loadoutprimaryweaponstickers;

  if(isDefined(var_0.ref_11961)) {
    var_1.ref_11961 = var_0.ref_11961;
  }

  var_1.loadoutsecondary = var_0.loadoutsecondary;
  var_1.loadoutsecondaryattachments = var_0.loadoutsecondaryattachments;
  var_1.loadoutsecondaryattachmentids = var_0.loadoutsecondaryattachmentids;
  var_1.loadoutsecondarycamo = var_0.loadoutsecondarycamo;
  var_1.loadoutsecondaryreticle = var_0.loadoutsecondaryreticle;
  var_1.loadoutsecondarylootitemid = var_0.loadoutsecondarylootitemid;
  var_1.loadoutsecondaryvariantid = var_0.loadoutsecondaryvariantid;
  var_1.loadoutsecondarycosmeticattachment = var_0.loadoutsecondarycosmeticattachment;
  var_1.loadoutsecondarystickers = var_0.loadoutsecondarystickers;
  var_1.loadoutmeleeslot = var_0.loadoutmeleeslot;
  var_1.loadoutperksfromgamemode = var_0.loadoutperksfromgamemode;
  var_1.loadoutperks = var_0.loadoutperks;
  var_1.loadoutstandardperks = var_0.loadoutstandardperks;
  var_1.loadoutextraperks = var_0.loadoutextraperks;
  var_1.loadoutrigtrait = var_0.loadoutrigtrait;
  var_1.loadoutusingspecialist = var_0.loadoutusingspecialist;
  var_1.loadoutequipmentprimary = var_0.loadoutequipmentprimary;
  var_1.loadoutextraequipmentprimary = var_0.loadoutextraequipmentprimary;
  var_1.loadoutequipmentsecondary = var_0.loadoutequipmentsecondary;
  var_1.loadoutextraequipmentsecondary = var_0.loadoutextraequipmentsecondary;
  var_1.loadoutsuper = var_0.loadoutsuper;
  var_1.loadoutgesture = var_0.loadoutgesture;
  var_1.loadoutaccessorydata = var_0.loadoutaccessorydata;
  var_1.loadoutaccessoryweapon = var_0.loadoutaccessoryweapon;
  var_1.loadoutstreaksfilled = var_0.loadoutstreaksfilled;
  var_1.loadoutstreaktype = var_0.loadoutstreaktype;
  var_1.loadoutkillstreak1 = var_0.loadoutkillstreak1;
  var_1.loadoutkillstreak2 = var_0.loadoutkillstreak2;
  var_1.loadoutkillstreak3 = var_0.loadoutkillstreak3;
  var_1.tweakedbyplayerduringmatch = var_0.tweakedbyplayerduringmatch;
  var_1.gamemodeforcednewloadout = var_0.gamemodeforcednewloadout;
  var_1.uavbestid = var_0.uavbestid;
  var_1 = loadout_updateclass(var_1, "copied");
  return var_1;
}

function loadout_updateclassteam(var_0, var_1, var_2) {
  var_2 = loadout_getclassteam(var_1);
  var_3 = getclassindex(var_1);
  self.class_num = var_3;
  self.classteam = var_2;
  var_0.loadoutarchetype = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "archetype");
  var_0.loadoutprimary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "weapon");

  if(var_0.loadoutprimary == "none") {
    var_0.loadoutprimary = "iw8_fists";
  } else {
    for(var_4 = 0; var_4 < 10; var_4++) {
      var_0.loadoutprimaryattachments[var_4] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "attachmentSetup", var_4, "attachment");
    }

    for(var_5 = 0; var_5 < 4; var_5++) {
      var_0.loadoutprimarystickers[var_5] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "sticker", var_5);
    }
  }

  var_0.loadoutprimarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "camo");
  var_0.loadoutprimaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 0, "reticle");
  var_0.loadoutsecondary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "weapon");

  for(var_4 = 0; var_4 < 10; var_4++) {
    var_0.loadoutsecondaryattachments[var_4] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "attachmentSetup", var_4, "attachment");
  }

  for(var_5 = 0; var_5 < 4; var_5++) {
    var_0.loadoutsecondarystickers[var_5] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "sticker", var_5);
  }

  var_0.loadoutsecondarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "camo");
  var_0.loadoutsecondaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "weaponSetups", 1, "reticle");
  var_0.loadoutmeleeslot = "none";
  var_0.loadoutequipmentprimary = "none";
  var_0.loadoutextraequipmentprimary = 0;
  var_0.loadoutequipmentsecondary = "none";
  var_0.loadoutextraequipmentsecondary = 0;
  var_0.loadoutsuper = "none";
  var_0.loadoutgesture = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_2, var_3, "class", "gesture");
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = recipe_getkillstreak(var_2, var_3, 0);
  var_0.loadoutkillstreak2 = recipe_getkillstreak(var_2, var_3, 1);
  var_0.loadoutkillstreak3 = recipe_getkillstreak(var_2, var_3, 2);
}

function loadout_updateclasscustom(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;

  if(!isDefined(var_2)) {
    var_3 = scripts\engine\utility::ter_op(isDefined(self.name), self.name, "<undefined>");
    var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "<undefined>");
    scripts\mp\utility\script::laststand_dogtags("loadout_updateClassCustom() called on " + var_3 + " with invalid class = " + var_4);
  }

  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutprimary = cac_getweapon(var_2, 0);

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_0.loadoutprimaryattachments[var_5] = cac_getweaponattachment(var_2, 0, var_5);
    var_0.loadoutprimaryattachmentids[var_5] = force_interrupt_current_combat_action(var_2, 0, var_5);
  }

  var_0.loadoutprimarycamo = cac_getweaponcamo(var_2, 0);
  var_0.loadoutprimaryreticle = cac_getweaponreticle(var_2, 0);
  var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_2, 0);
  var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_2, 0);
  var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 0);

  for(var_6 = 0; var_6 < 4; var_6++) {
    var_0.loadoutprimarystickers[var_6] = cac_getweaponsticker(var_2, 0, var_6);
  }

  var_0.loadoutsecondary = cac_getweapon(var_2, 1);

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_0.loadoutsecondaryattachments[var_5] = cac_getweaponattachment(var_2, 1, var_5);
    var_0.loadoutsecondaryattachmentids[var_5] = force_interrupt_current_combat_action(var_2, 1, var_5);
  }

  var_0.loadoutsecondarycamo = cac_getweaponcamo(var_2, 1);
  var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_2, 1);
  var_0.loadoutsecondarylootitemid = cac_getweaponlootitemid(var_2, 1);
  var_0.loadoutsecondaryvariantid = cac_getweaponvariantid(var_2, 1);
  var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 1);

  for(var_6 = 0; var_6 < 4; var_6++) {
    var_0.loadoutsecondarystickers[var_6] = cac_getweaponsticker(var_2, 1, var_6);
  }

  var_0.loadoutequipmentprimary = cac_getequipmentprimary(var_2);
  var_0.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var_2);
  var_0.loadoutequipmentsecondary = cac_getequipmentsecondary(var_2);
  var_0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var_2);
  var_0.loadoutsuper = cac_getsuper();
  var_0.loadoutgesture = cac_getgesture();
  loadout_updateclassaccessory(var_0);
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = cac_getkillstreak(0, var_1);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1, var_1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2, var_1);
  var_0.loadoutusingspecialist = cac_getusingspecialist(var_2);
  var_7 = 0;

  foreach(var_9 in var_0.loadoutprimaryattachments) {
    if(var_9 != "none") {
      var_7++;
    }
  }

  var_11 = 0;

  foreach(var_9 in var_0.loadoutsecondaryattachments) {
    if(var_9 != "none") {
      var_11++;
    }
  }

  var_14 = int(tablelookup("mp/statstable.csv", 4, var_0.loadoutprimary, 18));

  if(var_14 < var_7) {
    for(var_5 = 0; var_5 < 10; var_5++) {
      var_0.loadoutprimaryattachments[var_5] = "none";
      var_0.loadoutprimaryattachmentids[var_5] = 0;
    }
  }

  var_14 = int(tablelookup("mp/statstable.csv", 4, var_0.loadoutsecondary, 18));

  if(var_14 < var_11) {
    for(var_5 = 0; var_5 < 10; var_5++) {
      var_0.loadoutsecondaryattachments[var_5] = "none";
      var_0.loadoutsecondaryattachmentids[var_5] = 0;
    }

    return;
  }
}

function loadout_updateclassgamemode(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;
  var_3 = self.pers["gamemodeLoadout"];

  if(isDefined(var_3["loadoutArchetype"])) {
    var_0.loadoutarchetype = var_3["loadoutArchetype"];
  } else if(isbot(self)) {
    var_4 = scripts\mp\bots\bots_loadout::bot_loadout_class_callback();
    var_0.loadoutarchetype = var_4["loadoutArchetype"];
  } else {
    var_0.loadoutarchetype = cac_getcharacterarchetype();
  }

  if(isDefined(var_3["loadoutRigTrait"])) {
    var_0.loadoutrigtrait = var_3["loadoutRigTrait"];
  }

  if(isDefined(var_3["loadoutPrimaryAddBlueprintAttachments"])) {
    var_0.ref_11960 = var_3["loadoutPrimaryAddBlueprintAttachments"];
  }

  if(isDefined(var_3["loadoutPrimary"])) {
    var_0.loadoutprimary = var_3["loadoutPrimary"];
  }

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_6 = getattachmentloadoutstring(var_5, "primary");

    if(isDefined(var_3[var_6])) {
      var_0.loadoutprimaryattachments[var_5] = var_3[var_6];
    }
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = getstickerloadoutstring(var_7, "primary");

    if(isDefined(var_3[var_8])) {
      var_0.loadoutprimarystickers[var_7] = var_3[var_8];
    }
  }

  if(isDefined(var_3["loadoutPrimaryCamo"])) {
    var_0.loadoutprimarycamo = var_3["loadoutPrimaryCamo"];
  }

  if(isDefined(var_3["loadoutPrimaryCosmeticAttachment"])) {
    var_0.loadoutprimarycosmeticattachment = var_3["loadoutPrimaryCosmeticAttachment"];
  }

  if(isDefined(var_3["loadoutPrimaryReticle"])) {
    var_0.loadoutprimaryreticle = var_3["loadoutPrimaryReticle"];
  }

  if(isDefined(var_3["loadoutPrimaryVariantID"])) {
    var_0.loadoutprimaryvariantid = var_3["loadoutPrimaryVariantID"];
  }

  if(isDefined(var_3["loadoutPrimaryVariantID"]) && scripts\mp\utility\game::getgametype() == "arena") {
    if(isDefined(var_3["roundWinStreakPrimaryCamoTeam"]) && isDefined(self.pers["team"]) && var_3["roundWinStreakPrimaryCamoTeam"] == self.pers["team"]) {
      if(isDefined(var_3["roundWinStreakPrimaryCamo"])) {
        var_0.loadoutprimarycamo = var_3["roundWinStreakPrimaryCamo"];
      }
    }

    if(var_3["loadoutPrimaryVariantID"] != -1) {
      setomnvar("ui_arena_primaryVariantID", var_3["loadoutPrimaryVariantID"]);
    }
  }

  if(isDefined(var_3["loadoutSecondaryAddBlueprintAttachments"])) {
    var_0.ref_11961 = var_3["loadoutSecondaryAddBlueprintAttachments"];
  }

  if(isDefined(var_3["loadoutSecondary"])) {
    var_0.loadoutsecondary = var_3["loadoutSecondary"];
  }

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_6 = getattachmentloadoutstring(var_5, "secondary");

    if(isDefined(var_3[var_6])) {
      var_0.loadoutsecondaryattachments[var_5] = var_3[var_6];
    }
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = getstickerloadoutstring(var_7, "secondary");

    if(isDefined(var_3[var_8])) {
      var_0.loadoutsecondarystickers[var_7] = var_3[var_8];
    }
  }

  if(isDefined(var_3["loadoutSecondaryCamo"])) {
    var_0.loadoutsecondarycamo = var_3["loadoutSecondaryCamo"];
  }

  if(isDefined(var_3["loadoutSecondaryCosmeticAttachment"])) {
    var_0.loadoutsecondarycosmeticattachment = var_3["loadoutSecondaryCosmeticAttachment"];
  }

  if(isDefined(var_3["loadoutSecondaryReticle"])) {
    var_0.loadoutsecondaryreticle = var_3["loadoutSecondaryReticle"];
  }

  if(isDefined(var_3["loadoutSecondaryVariantID"])) {
    var_0.loadoutsecondaryvariantid = var_3["loadoutSecondaryVariantID"];
  }

  if(isDefined(var_3["loadoutSecondaryVariantID"]) && scripts\mp\utility\game::getgametype() == "arena" && var_3["loadoutSecondaryVariantID"] != -1) {
    if(isDefined(var_3["roundWinStreakecondaryCamoTeam"]) && isDefined(self.pers["team"]) && var_3["roundWinStreakecondaryCamoTeam"] == self.pers["team"]) {
      if(isDefined(var_3["roundWinStreakSecondaryCamo"])) {
        var_0.loadoutsecondarycamo = var_3["roundWinStreakSecondaryCamo"];
      }
    }

    if(var_3["loadoutSecondaryVariantID"] != -1) {
      setomnvar("ui_arena_secondaryVariantID", var_3["loadoutSecondaryVariantID"]);
    }
  }

  if(isDefined(var_3["loadoutMeleeSlot"])) {
    var_0.loadoutmeleeslot = var_3["loadoutMeleeSlot"];
  }

  var_0.loadoutperksfromgamemode = isDefined(var_3["loadoutPerks"]);

  if(isDefined(var_3["loadoutPerks"])) {
    var_0.loadoutperks = var_3["loadoutPerks"];
  }

  var_0.ref_1195e = isDefined(var_3["loadoutExtraPerks"]);

  if(isDefined(var_3["loadoutExtraPerks"])) {
    var_0.loadoutextraperks = var_3["loadoutExtraPerks"];
  }

  if(isDefined(var_3["loadoutEquipmentPrimary"])) {
    var_0.loadoutequipmentprimary = var_3["loadoutEquipmentPrimary"];
  }

  if(isDefined(var_3["loadoutExtraEquipmentPrimary"])) {
    var_0.loadoutextraequipmentprimary = var_3["loadoutExtraEquipmentPrimary"];
  }

  if(isDefined(var_3["loadoutEquipmentSecondary"])) {
    var_0.loadoutequipmentsecondary = var_3["loadoutEquipmentSecondary"];
  }

  if(isDefined(var_3["loadoutExtraEquipmentSecondary"])) {
    var_0.loadoutextraequipmentsecondary = var_3["loadoutExtraEquipmentSecondary"];
  }

  if(isDefined(var_3["loadoutSuper"])) {
    var_0.loadoutsuper = var_3["loadoutSuper"];
  }

  if(isbot(self)) {
    var_0.loadoutaccessoryweapon = "none";
    var_0.loadoutaccessorydata = "none";
    var_0.loadoutaccessorylogic = "none";
  } else {
    loadout_updateclassaccessory(var_0);
  }

  if(isDefined(var_3["loadoutGesture"])) {
    if(var_3["loadoutGesture"] == "playerData") {
      if(isbot(self)) {
        var_0.loadoutgesture = "none";
      } else {
        var_0.loadoutgesture = cac_getgesture();
      }
    } else {
      var_0.loadoutgesture = var_3["loadoutGesture"];
    }
  }

  if(isDefined(var_3["loadoutKillstreak1"]) && var_3["loadoutKillstreak1"] != "specialty_null" || isDefined(var_3["loadoutKillstreak2"]) && var_3["loadoutKillstreak2"] != "specialty_null" || isDefined(var_3["loadoutKillstreak3"]) && var_3["loadoutKillstreak3"] != "specialty_null") {
    var_0.loadoutstreaksfilled = 1;
    var_0.loadoutkillstreak1 = var_3["loadoutKillstreak1"];
    var_0.loadoutkillstreak2 = var_3["loadoutKillstreak2"];
    var_0.loadoutkillstreak3 = var_3["loadoutKillstreak3"];
  }

  if(isDefined(var_3["loadoutUsingSpecialist"])) {
    var_0.loadoutusingspecialist = 1;
    return;
  }
}

function zone_get_node_nearest_2d_bounds(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;
  var_3 = self.pers["gamemodeLoadout"];
  var_4 = issubstr(var_1, "custgamemode_d");

  if(!var_4) {
    var_0.loadoutarchetype = cac_getcharacterarchetype();

    if(isDefined(var_3["loadoutPrimaryAddBlueprintAttachments"])) {
      var_0.ref_11960 = var_3["loadoutPrimaryAddBlueprintAttachments"];
    }

    if(isDefined(var_3["loadoutPrimary"])) {
      var_0.loadoutprimary = var_3["loadoutPrimary"];

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_6 = getattachmentloadoutstring(var_5, "primary");

        if(isDefined(var_3[var_6])) {
          var_0.loadoutprimaryattachments[var_5] = var_3[var_6];
        }
      }

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_8 = getstickerloadoutstring(var_7, "primary");

        if(isDefined(var_3[var_8])) {
          var_0.loadoutprimarystickers[var_7] = var_3[var_8];
        }
      }

      if(isDefined(var_3["loadoutPrimaryCamo"])) {
        var_0.loadoutprimarycamo = var_3["loadoutPrimaryCamo"];
      }

      if(isDefined(var_3["loadoutPrimaryCosmeticAttachment"])) {
        var_0.loadoutprimarycosmeticattachment = var_3["loadoutPrimaryCosmeticAttachment"];
      }

      if(isDefined(var_3["loadoutPrimaryReticle"])) {
        var_0.loadoutprimaryreticle = var_3["loadoutPrimaryReticle"];
      }

      if(isDefined(var_3["loadoutPrimaryVariantID"])) {
        var_0.loadoutprimaryvariantid = var_3["loadoutPrimaryVariantID"];
      }
    } else {
      var_2.loadoutprimary = cac_getweapon(var_4, 0);

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_2.loadoutprimaryattachments[var_5] = cac_getweaponattachment(var_4, 0, var_5);
        var_2.loadoutprimaryattachmentids[var_5] = force_interrupt_current_combat_action(var_4, 0, var_5);
      }

      var_2.loadoutprimarycamo = cac_getweaponcamo(var_4, 0);
      var_2.loadoutprimaryreticle = cac_getweaponreticle(var_4, 0);
      var_2.loadoutprimarylootitemid = cac_getweaponlootitemid(var_4, 0);
      var_2.loadoutprimaryvariantid = cac_getweaponvariantid(var_4, 0);
      var_2.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_4, 0);

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_2.loadoutprimarystickers[var_7] = cac_getweaponsticker(var_4, 0, var_7);
      }
    }

    if(isDefined(var_5["loadoutSecondaryAddBlueprintAttachments"])) {
      var_2.ref_11961 = var_5["loadoutSecondaryAddBlueprintAttachments"];
    }

    if(isDefined(var_5["loadoutSecondary"])) {
      var_2.loadoutsecondary = var_5["loadoutSecondary"];

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_6 = getattachmentloadoutstring(var_5, "secondary");

        if(isDefined(var_5[var_6])) {
          var_2.loadoutsecondaryattachments[var_5] = var_5[var_6];
        }
      }

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_8 = getstickerloadoutstring(var_7, "secondary");

        if(isDefined(var_5[var_8])) {
          var_2.loadoutsecondarystickers[var_7] = var_5[var_8];
        }
      }

      if(isDefined(var_5["loadoutSecondaryCamo"])) {
        var_2.loadoutsecondarycamo = var_5["loadoutSecondaryCamo"];
      }

      if(isDefined(var_5["loadoutSecondaryCosmeticAttachment"])) {
        var_2.loadoutsecondarycosmeticattachment = var_5["loadoutSecondaryCosmeticAttachment"];
      }

      if(isDefined(var_5["loadoutSecondaryReticle"])) {
        var_2.loadoutsecondaryreticle = var_5["loadoutSecondaryReticle"];
      }

      if(isDefined(var_5["loadoutSecondaryVariantID"])) {
        var_2.loadoutsecondaryvariantid = var_5["loadoutSecondaryVariantID"];
      }
    } else {
      var_2.loadoutsecondary = cac_getweapon(var_4, 1);

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_2.loadoutsecondaryattachments[var_5] = cac_getweaponattachment(var_4, 1, var_5);
        var_2.loadoutsecondaryattachmentids[var_5] = force_interrupt_current_combat_action(var_4, 1, var_5);
      }

      var_2.loadoutsecondarycamo = cac_getweaponcamo(var_4, 1);
      var_2.loadoutsecondaryreticle = cac_getweaponreticle(var_4, 1);
      var_2.loadoutsecondarylootitemid = cac_getweaponlootitemid(var_4, 1);
      var_2.loadoutsecondaryvariantid = cac_getweaponvariantid(var_4, 1);
      var_2.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_4, 1);

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_2.loadoutsecondarystickers[var_7] = cac_getweaponsticker(var_4, 1, var_7);
      }
    }

    if(isDefined(var_5["loadoutMeleeSlot"])) {
      var_2.loadoutmeleeslot = var_5["loadoutMeleeSlot"];
    }

    var_2.loadoutequipmentprimary = cac_getequipmentprimary(var_4);
    var_2.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var_4);
    var_2.loadoutequipmentsecondary = cac_getequipmentsecondary(var_4);
    var_2.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var_4);
    var_2.loadoutsuper = cac_getsuper();
    var_2.loadoutgesture = cac_getgesture();
    loadout_updateclassaccessory(var_2);
    var_2.loadoutstreaksfilled = 1;
    var_2.loadoutkillstreak1 = cac_getkillstreak(0, var_3);
    var_2.loadoutkillstreak2 = cac_getkillstreak(1, var_3);
    var_2.loadoutkillstreak3 = cac_getkillstreak(2, var_3);
    var_2.loadoutusingspecialist = cac_getusingspecialist(var_4);
    return;
  }

  if(isDefined(var_5["loadoutPrimaryAddBlueprintAttachments"])) {
    var_2.ref_11960 = var_5["loadoutPrimaryAddBlueprintAttachments"];
  }

  if(isDefined(var_5["loadoutPrimary"])) {
    var_2.loadoutprimary = var_5["loadoutPrimary"];

    for(var_5 = 0; var_5 < 10; var_5++) {
      var_6 = getattachmentloadoutstring(var_5, "primary");

      if(isDefined(var_5[var_6])) {
        var_2.loadoutprimaryattachments[var_5] = var_5[var_6];
      }
    }

    for(var_7 = 0; var_7 < 4; var_7++) {
      var_8 = getstickerloadoutstring(var_7, "primary");

      if(isDefined(var_5[var_8])) {
        var_2.loadoutprimarystickers[var_7] = var_5[var_8];
      }
    }

    if(isDefined(var_5["loadoutPrimaryCamo"])) {
      var_2.loadoutprimarycamo = var_5["loadoutPrimaryCamo"];
    }

    if(isDefined(var_5["loadoutPrimaryCosmeticAttachment"])) {
      var_2.loadoutprimarycosmeticattachment = var_5["loadoutPrimaryCosmeticAttachment"];
    }

    if(isDefined(var_5["loadoutPrimaryReticle"])) {
      var_2.loadoutprimaryreticle = var_5["loadoutPrimaryReticle"];
    }

    if(isDefined(var_5["loadoutPrimaryVariantID"])) {
      var_2.loadoutprimaryvariantid = var_5["loadoutPrimaryVariantID"];
    }
  } else if(!isagent(self) && self calloutmarkerping_getEnt() && getdvarint("scr_forceHeadlessCustomization", 1) == 1) {
    zoomkey(var_2);
  } else {
    var_2.loadoutprimary = table_getweapon(level.classtablename, var_4, 0);

    for(var_5 = 0; var_5 < 10; var_5++) {
      var_2.loadoutprimaryattachments[var_5] = table_getweaponattachment(level.classtablename, var_4, 0, var_5);
    }

    var_2.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_4, 0);
    var_2.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_4, 0);
    var_2.loadoutsecondary = table_getweapon(level.classtablename, var_4, 1);

    for(var_5 = 0; var_5 < 10; var_5++) {
      var_2.loadoutsecondaryattachments[var_5] = table_getweaponattachment(level.classtablename, var_4, 1, var_5);
    }

    var_2.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_4, 1);
    var_2.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_4, 1);
  }

  var_2.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var_4);
  var_2.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var_4);
  var_2.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var_4);
  var_2.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var_4);
  var_2.loadoutgesture = table_getgesture(level.classtablename, var_4);
  var_2.loadoutsuper = table_getsuper(level.classtablename, var_4);
  var_2.loadoutusingspecialist = table_getspecialist(level.classtablename, var_4);
  loadout_updateclassaccessory(var_2);
  var_2.loadoutarchetype = cac_getcharacterarchetype();
  var_2.loadoutkillstreak1 = cac_getkillstreak(0, var_3);
  var_2.loadoutkillstreak2 = cac_getkillstreak(1, var_3);
  var_2.loadoutkillstreak3 = cac_getkillstreak(2, var_3);
  var_2.loadoutrigtrait = cac_getloadoutarchetypeperk();

  if(getdvarint("scr_superForceLightTank", 0)) {
    var_2.loadoutsuper = "super_bradley";
    return;
  }
}

function loadout_updateclasscallback(var_0) {
  if(!isDefined(self.classcallback)) {
    scripts\engine\utility::error("self.classCallback function reference required for class 'callback'");
  }

  var_1 = self[[self.classcallback]]();

  if(!isDefined(var_1)) {
    scripts\engine\utility::error("array required from self.classCallback for class 'callback'");
  }

  if(isDefined(var_1["loadoutArchetype"])) {
    var_0.loadoutarchetype = var_1["loadoutArchetype"];
  }

  if(isDefined(var_1["loadoutPrimaryAddBlueprintAttachments"])) {
    var_0.ref_11960 = var_1["loadoutPrimaryAddBlueprintAttachments"];
  }

  if(isDefined(var_1["loadoutPrimary"])) {
    var_0.loadoutprimary = var_1["loadoutPrimary"];
  }

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = getattachmentloadoutstring(var_2, "primary");

    if(isDefined(var_1[var_3])) {
      var_0.loadoutprimaryattachments[var_2] = var_1[var_3];
    }
  }

  if(isDefined(var_1["loadoutPrimaryCamo"])) {
    var_0.loadoutprimarycamo = var_1["loadoutPrimaryCamo"];
  }

  if(isDefined(var_1["loadoutPrimaryReticle"])) {
    var_0.loadoutprimaryreticle = var_1["loadoutPrimaryReticle"];
  }

  if(isDefined(var_1["loadoutPrimaryVariantID"])) {
    var_0.loadoutprimaryvariantid = var_1["loadoutPrimaryVariantID"];
  }

  if(isDefined(var_1["loadoutSecondaryAddBlueprintAttachments"])) {
    var_0.ref_11961 = var_1["loadoutSecondaryAddBlueprintAttachments"];
  }

  if(isDefined(var_1["loadoutSecondary"])) {
    var_0.loadoutsecondary = var_1["loadoutSecondary"];
  }

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = getattachmentloadoutstring(var_2, "secondary");

    if(isDefined(var_1[var_3])) {
      var_0.loadoutsecondaryattachments[var_2] = var_1[var_3];
    }
  }

  if(isDefined(var_1["loadoutSecondaryCamo"])) {
    var_0.loadoutsecondarycamo = var_1["loadoutSecondaryCamo"];
  }

  if(isDefined(var_1["loadoutSecondaryReticle"])) {
    var_0.loadoutsecondaryreticle = var_1["loadoutSecondaryReticle"];
  }

  if(isDefined(var_1["loadoutSecondaryVariantID"])) {
    var_0.loadoutsecondaryvariantid = var_1["loadoutSecondaryVariantID"];
  }

  if(isDefined(var_1["loadoutMeleeSlot"])) {
    var_0.loadoutmeleeslot = var_1["loadoutMeleeSlot"];
  }

  if(isDefined(var_1["loadoutEquipmentPrimary"])) {
    var_0.loadoutequipmentprimary = var_1["loadoutEquipmentPrimary"];
  }

  if(isDefined(var_1["loadoutExtraEquipmentPrimary"])) {
    var_0.loadoutextraequipmentprimary = var_1["loadoutExtraEquipmentPrimary"];
  }

  if(isDefined(var_1["loadoutEquipmentSecondary"])) {
    var_0.loadoutequipmentsecondary = var_1["loadoutEquipmentSecondary"];
  }

  if(isDefined(var_1["loadoutExtraEquipmentSecondary"])) {
    var_0.loadoutextraequipmentsecondary = var_1["loadoutExtraEquipmentSecondary"];
  }

  if(isDefined(var_1["loadoutSuper"])) {
    var_0.loadoutsuper = var_1["loadoutSuper"];
  }

  if(isDefined(var_1["loadoutGesture"])) {
    var_0.loadoutgesture = var_1["loadoutGesture"];
  }

  var_0.loadoutstreaksfilled = isDefined(var_1["loadoutStreak1"]) || isDefined(var_1["loadoutStreak2"]) || isDefined(var_1["loadoutStreak3"]);

  if(isDefined(var_1["loadoutStreakType"])) {
    var_0.loadoutstreaktype = var_1["loadoutStreakType"];
  }

  if(isDefined(var_1["loadoutStreak1"])) {
    var_0.loadoutkillstreak1 = var_1["loadoutStreak1"];
  }

  if(isDefined(var_1["loadoutStreak2"])) {
    var_0.loadoutkillstreak2 = var_1["loadoutStreak2"];
  }

  if(isDefined(var_1["loadoutStreak3"])) {
    var_0.loadoutkillstreak3 = var_1["loadoutStreak3"];
    return;
  }
}

function loadout_updateclassdefault(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;

  if(!isDefined(var_2)) {
    var_3 = "<undefined>";
    var_4 = "<undefined>";

    if(isDefined(self.name)) {
      var_3 = self.name;
    }

    if(isDefined(var_1)) {
      var_4 = var_1;
    }

    scripts\mp\utility\script::laststand_dogtags("loadout_updateClassDefault() called on " + var_3 + " with invalid class = " + var_4);
  }

  if(!isagent(self) && self calloutmarkerping_getEnt() && getdvarint("scr_forceHeadlessCustomization", 1) == 1) {
    zoomkey(var_0);
    loadout_updateclassaccessoryheadless(var_0);
  } else {
    zoneislocked(var_0, var_2);
    loadout_updateclassaccessory(var_0);
  }

  var_0.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var_2);
  var_0.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var_2);
  var_0.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var_2);
  var_0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var_2);
  var_0.loadoutgesture = table_getgesture(level.classtablename, var_2);
  var_0.loadoutsuper = table_getsuper(level.classtablename, var_2);
  var_0.loadoutusingspecialist = table_getspecialist(level.classtablename, var_2);
  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutkillstreak1 = cac_getkillstreak(0, var_1);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1, var_1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2, var_1);
  var_0.loadoutrigtrait = cac_getloadoutarchetypeperk();

  if(getdvarint("scr_superForceLightTank", 0)) {
    var_0.loadoutsuper = "super_bradley";
    return;
  }
}

function zoneislocked(var_0, var_1) {
  var_0.loadoutprimary = table_getweapon(level.classtablename, var_1, 0);

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_0.loadoutprimaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 0, var_2);
  }

  var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_1, 0);
  var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_1, 0);
  var_0.loadoutsecondary = table_getweapon(level.classtablename, var_1, 1);

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_0.loadoutsecondaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 1, var_2);
  }

  var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_1, 1);
  var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_1, 1);
}

function zoomkey(var_0) {
  if(!isDefined(self.showextractiontime)) {
    if(!isDefined(level.showextractiontime)) {
      var_1 = randomint(200);
      level.showextractiontime = var_1;
      level.showhint = var_1;
    } else {
      level.showextractiontime++;
      level.showhint++;
    }

    self.showextractiontime = level.showextractiontime;
    self.showhint = level.showhint;
  }

  var_2 = zone_stompeenemyprogressupdate(self.showextractiontime, 1);
  var_3 = zone_stompeenemyprogressupdate(self.showhint, 0);
  var_4 = var_2[0];
  var_5 = var_2[1];
  var_6 = var_3[0];
  var_7 = var_3[1];
  var_0.loadoutprimary = var_4;

  foreach(var_10, var_9 in var_5.attachcustomtoidmap) {
    var_0.loadoutprimaryattachments[var_0.loadoutprimaryattachments.size] = var_10;
    var_0.loadoutprimaryattachmentids[var_0.loadoutprimaryattachmentids.size] = var_9;
  }

  var_0.loadoutprimaryvariantid = var_5.variantid;
  var_0.loadoutsecondary = var_6;

  foreach(var_9 in var_7.attachcustomtoidmap) {
    var_0.loadoutsecondaryattachments[var_0.loadoutsecondaryattachments.size] = var_10;
    var_0.loadoutsecondaryattachmentids[var_0.loadoutsecondaryattachmentids.size] = var_9;
  }

  var_0.loadoutsecondaryvariantid = var_7.variantid;
}

function zone_stompeenemyprogressupdate(var_0, var_1) {
  var_2 = 0;
  var_3 = -1;
  var_4 = getdvarint("scr_limit_headless_to_core", 1);

  for(;;) {
    foreach(var_6 in level.weaponlootmapdata) {
      if(var_6.variantid == 0 || var_6.update_focus_fire_objective || !isDefined(var_6.attachcustomtoidmap)) {
        continue;
      }

      if(var_4 && isDefined(var_6.tut_bot_nameplate) && !var_6.tut_bot_nameplate) {
        continue;
      }

      var_7 = strtok(var_8, "|")[0];

      if(var_1 != scripts\mp\utility\weapon::iscacprimaryweapon(var_7)) {
        continue;
      }

      var_3++;

      if(var_3 == var_0) {
        return [var_7, var_6];
      }
    }
  }
}

function loadout_updateclassaccessory(var_0) {
  var_1 = cac_getaccessoryweapon();
  var_2 = cac_getaccessorydata();
  var_3 = force_interrupt_all_current_combat_actions();
  loadout_updateclassaccessoryinternal(var_0, var_1, var_2, var_3);
}

function loadout_updateclassaccessoryheadless(var_0) {
  var_1 = getarraykeys(level.accessoryweaponbyindex);

  if(!isDefined(self.headlessaccessoryindex)) {
    if(!isDefined(level.headlessaccessoryindex)) {
      var_2 = randomint(var_1.size);
      level.headlessaccessoryindex = var_2;
    } else {
      level.headlessaccessoryindex++;

      if(level.headlessaccessoryindex >= var_1.size) {
        level.headlessaccessoryindex = 0;
      }
    }

    self.headlessaccessoryindex = level.headlessaccessoryindex;
  }

  var_3 = var_1[self.headlessaccessoryindex];
  var_4 = scripts\mp\accessories::getaccessoryweaponbyindex(var_3);
  var_5 = scripts\mp\accessories::getaccessorydatabyindex(var_3);
  var_6 = scripts\mp\accessories::register_respawn_functions(var_3);
  loadout_updateclassaccessoryinternal(var_0, var_4, var_5, var_6);
}

function loadout_updateclassaccessoryinternal(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("scr_limit_accessories", -1);

  if(var_4 >= 0 && isDefined(var_1)) {
    if(!isDefined(level.limitaccessorieslist)) {
      level.limitaccessorieslist = [];
    }

    level.limitaccessorieslist = scripts\engine\utility::array_removeundefined(level.limitaccessorieslist);

    if(level.limitaccessorieslist.size < var_4) {
      level.limitaccessorieslist[level.limitaccessorieslist.size] = var_1;
    } else if(scripts\engine\utility::array_contains(level.limitaccessorieslist, var_1)) {} else {
      var_0.loadoutaccessoryweapon = "none";
      var_0.loadoutaccessorydata = "none";
      var_0.loadoutaccessorylogic = "none";
      return;
    }
  }

  var_0.loadoutaccessoryweapon = var_1;
  var_0.loadoutaccessorydata = var_2;
  var_0.loadoutaccessorylogic = var_3;
}

function loadout_updatestreaktype(var_0) {
  if(istrue(var_0.loadoutusingspecialist)) {
    self.streaktype = "streaktype_specialist";
  } else {
    self.streaktype = "streaktype_assault";
  }

  var_0.loadoutstreaktype = self.streaktype;
}

function loadout_updateabilities(var_0, var_1) {
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

  var_2 = getsubstr(var_1, 0, 7) == "default";
  var_3 = getsubstr(var_1, 0, 14) == "custgamemode_d";

  if(var_0.loadoutperksfromgamemode) {
    var_0.loadoutstandardperks = var_0.loadoutperks;

    if(var_0.ref_1195e) {
      var_0.loadoutextraperks = var_0.loadoutextraperks;
      return;
    }

    return;
  }

  if(!scripts\mp\utility\perk::perksenabled()) {
    return;
  }

  if(isai(self)) {
    if(isDefined(self.pers["loadoutPerks"])) {
      var_0.loadoutperks = self.pers["loadoutPerks"];
      return;
    }

    return;
  }

  if(var_1 == "juggernaut" || var_1 == "copied") {
    return;
  }

  var_4 = loadout_getclassteam(var_1);

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = "specialty_null";

    if(var_4 != "none") {
      var_7 = getclassindex(var_1);
      var_6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_4, var_7, "class", "loadoutPerks");
    } else if(var_2 || var_3) {
      var_7 = getclassindex(var_1);
      var_6 = table_getperk(level.classtablename, var_7, var_5);
    } else {
      var_6 = cac_getloadoutperk(self.class_num, var_5);
    }

    if(isDefined(var_6) && var_6 != "specialty_null") {
      var_0.loadoutperks[var_0.loadoutperks.size] = var_6;
      var_0.loadoutstandardperks[var_0.loadoutstandardperks.size] = var_6;
    }
  }

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = "specialty_null";

    if(var_4 != "none") {
      var_7 = getclassindex(var_1);
      var_6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_4, var_7, "class", "extraPerks");
    } else if(var_2 || var_3) {
      var_7 = getclassindex(var_1);
      var_6 = table_getextraperk(level.classtablename, var_7, var_5);
    } else {
      var_6 = cac_getloadoutextraperk(self.class_num, var_5);
    }

    if(isDefined(var_6) && var_6 != "specialty_null") {
      var_0.loadoutextraperks[var_0.loadoutextraperks.size] = var_6;
    }
  }

  var_6 = "specialty_null";

  if(var_4 != "none") {
    var_7 = getclassindex(var_1);
    var_6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", var_4, var_7, "class", "archetypePerk");
  } else {
    var_6 = cac_getloadoutarchetypeperk();
  }

  if(isDefined(var_6) && var_6 != "specialty_null") {
    var_0.loadoutperks[var_0.loadoutperks.size] = var_6;
    self.pers["loadoutRigTrait"] = var_6;
    var_0.loadoutrigtrait = var_6;
  }

  var_7 = getclassindex(var_1);
}

function loadout_getclasstype(var_0) {
  var_1 = loadout_getclassteam(var_0);

  if(var_1 == "none" && !isDefined(var_0)) {
    return "custom";
  }

  if(var_1 != "none") {
    return "team";
  }

  if(issubstr(var_0, "custom")) {
    return "custom";
  }

  if(var_0 == "gamemode") {
    return "gamemode";
  }

  if(issubstr(var_0, "custgamemode")) {
    return "custgamemode";
  }

  if(var_0 == "callback") {
    return "callback";
  }

  if(var_0 == "juggernaut") {
    return "juggernaut";
  }

  if(var_0 == "copied") {
    return "copied";
  }

  return "default";
}

function ref_1194e(var_0, var_1) {
  var_2 = loadout_getclasstype(var_1);

  switch (var_2) {
    case "team":
      break;
    case "custom":
      break;
    case "custgamemode":
      break;
    case "gamemode":
      ref_1194f(var_0, var_1);
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

function loadout_updateclass(var_0, var_1) {
  if(!isagent(self) && self calloutmarkerping_getEnt() && getdvarint("scr_forceHeadlessCustomization", 1) == 1 && scripts\mp\utility\game::getgametype() != "br") {
    var_1 = "default" + randomint(5) + 1;
  }

  var_2 = loadout_getclasstype(var_1);

  switch (var_2) {
    case "team":
      loadout_updateclassteam(var_0, var_1);
      break;
    case "custom":
      loadout_updateclasscustom(var_0, var_1);
      break;
    case "gamemode":
      loadout_updateclassgamemode(var_0, var_1);
      break;
    case "custgamemode":
      zone_get_node_nearest_2d_bounds(var_0, var_1);
      break;
    case "callback":
      loadout_updateclasscallback(var_0);
      break;
    case "default":
      loadout_updateclassdefault(var_0, var_1);
      break;
    case "juggernaut":
      break;
    case "copied":
      break;
  }

  if(!istrue(game["isLaunchChunk"])) {
    self.pers["defaultOperatorSkinIndex"] = scripts\mp\teams::pickdefaultoperatorskin(var_0.loadoutprimary);
  }

  loadout_updatehasnvg(var_0);
  loadout_updateclassfistweapons(var_0);
  loadout_updatestreaktype(var_0);
  loadout_updateabilities(var_0, var_1);
  var_0 = loadout_validateclass(var_0, var_1);

  if(!isbot(self) && isDefined(level.set_systems_init_flag) && level.set_systems_init_flag) {
    zvelscale(var_0);
  } else {
    loadout_updateclassfinalweapons(var_0);
  }

  if(isDefined(level.ref_11c88)) {
    self[[level.ref_11c88]](var_0);
  }

  return var_0;
}

function loadout_updateclassfistweapons(var_0) {
  if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag && issameweapon(var_0.loadoutprimary)) {
    var_0.loadoutprimary = var_0.loadoutprimary;
  } else if(var_0.loadoutprimary == "none") {
    var_0.loadoutprimary = "iw8_fists";
  }

  if(scripts\mp\utility\game::handle_carry_special_item()) {
    if(var_0.loadoutsecondary == "none") {
      var_0.loadoutsecondary = "none";
      return;
    }

    return;
  }

  if(var_0.loadoutsecondary == "none" && var_0.loadoutprimary != "iw8_fists" && !istrue(self.isjuggernaut)) {
    var_0.loadoutsecondary = "iw8_fists";
    return;
  }

  if(var_0.loadoutprimary == "iw8_fists" && var_0.loadoutsecondary == "iw8_fists") {
    var_0.loadoutsecondary = "none";
    return;
  }
}

function loadout_updatehasnvg(var_0) {
  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_0.loadouthasnvg = 1;
    return;
  }
}

function loadout_validateclass(var_0, var_1) {
  var_2 = scripts\mp\utility\game::isanymlgmatch() && issubstr(var_1, "default");

  if(issubstr(var_1, "custom") || var_2) {
    return scripts\mp\validation::validateloadout(var_0);
  }

  return var_0;
}

function loadout_forcearchetype(var_0) {
  var_1 = getdvarint("forceArchetype", 0);

  if(var_1 > 0) {
    var_2 = getdvarint("forceArchetype", 0);

    switch (var_2) {
      case 1:
        var_0.loadoutarchetype = "archetype_assault";
        break;
      default:
        var_0.loadoutarchetype = "archetype_assault";
        break;
    }

    return;
  }

  if(var_1 == -1) {
    var_3 = ["archetype_assault"];
    var_4 = randomint(var_3.size);
    var_0.loadoutarchetype = var_3[var_4];
    self iprintlnbold("Random Archetype: " + var_3[var_4]);
    return;
  }
}

function loadout_updateplayerarchetype(var_0) {
  if(!istrue(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {}
  }

  self.loadoutarchetype = var_0.loadoutarchetype;
  scripts\mp\weapons::updatemovespeedscale();
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

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_9 = 133.333;
    var_10 = 1800;
  }

  switch (self.loadoutarchetype) {
    case "archetype_assault":
      var_5 = var_1 | var_2 | var_3;
      var_6 = &scripts\mp\archetypes\archassault::applyarchetype;
      var_7 = "vestlight";
      self.clothtype = var_7;
      break;
    default:
      if(!istrue(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {}
      }

      break;
  }

  self setcamerathirdperson(0);

  if(getdvarint("debug_iw7_backwards_compat")) {
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
  self energy_setmax(0, var_8);
  self energy_setenergy(0, var_8);
  self energy_setrestorerate(0, var_9);
  self energy_setresttimems(0, var_10);
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
  self energy_setrestorerate(1, 10);
  self energy_setresttimems(1, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 2500, 0));

  if(isDefined(var_6)) {
    self[[var_6]]();
  }
}

function loadout_updateclassfinalweapons(var_0) {
  if(istrue(var_0.ref_11960)) {
    var_0.loadoutprimaryobject = fixsuperforbr(var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimaryvariantid, var_0.loadoutprimaryattachmentids, var_0.loadoutprimarycosmeticattachment, var_0.loadoutprimarystickers, istrue(var_0.loadouthasnvg));
  } else {
    var_0.loadoutprimaryobject = buildweapon(var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimaryvariantid, var_0.loadoutprimaryattachmentids, var_0.loadoutprimarycosmeticattachment, var_0.loadoutprimarystickers, istrue(var_0.loadouthasnvg));
  }

  var_0.loadoutprimaryfullname = createheadicon(var_0.loadoutprimaryobject);

  if(var_0.loadoutsecondary == "none") {
    var_0.loadoutsecondaryfullname = "none";
    var_0.loadoutsecondaryobject = undefined;
  } else {
    if(istrue(var_0.ref_11961)) {
      var_0.loadoutsecondaryobject = fixsuperforbr(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));
    } else {
      var_0.loadoutsecondaryobject = buildweapon(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));
    }

    var_0.loadoutsecondaryfullname = createheadicon(var_0.loadoutsecondaryobject);
  }

  if(var_0.loadoutmeleeslot != "none") {
    self giveweapon(var_0.loadoutmeleeslot);
    self assignweaponmeleeslot(var_0.loadoutmeleeslot);
    return;
  }
}

function loadout_updateplayerweapons(var_0, var_1, var_2, var_3) {
  var_4 = respawnitems_getrespawnitems();
  var_5 = respawnitems_hasweapondata(var_4);
  var_6 = level.magcount;
  var_7 = loadout_giveprimaryweapon(var_0, var_4, var_5);
  var_8 = loadout_givesecondaryweapon(var_0, var_4, var_5);
  zombievehiclelaststand(var_0, var_7, var_8, var_4, var_5, var_6);
  self.loadoutmeleeslot = var_0.loadoutmeleeslot;

  if(!isDefined(var_7)) {
    scripts\mp\utility\script::laststand_dogtags(var_0.loadoutprimary);
  }

  if(isDefined(var_7) && self hasweapon(var_7)) {
    var_9 = var_7;
  } else {
    var_9 = var_9;
  }

  if(isDefined(var_9) && var_9.basename != "none" && isDefined(var_8) && var_8.basename == "iw8_fists_mp") {
    var_9 = var_9;
  }

  if(!isai(self)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_9);
  }

  if(!isDefined(var_3) || var_3) {
    var_4 = shouldskipfirstraise(var_9, var_4);

    if(!isagent(self)) {
      self setspawnweapon(var_9, !var_4);
    }
  }

  self.spawnweaponobj = var_9;
  ref_11951();
}

function zombierespawning() {
  if(isDefined(self.primaryweaponobj) && !self hasweapon(self.primaryweaponobj)) {
    loadout_giveprimaryweapon(self.classstruct);
    thread ref_13c58();
  }

  if(isDefined(self.secondaryweaponobj) && !self hasweapon(self.secondaryweaponobj)) {
    loadout_givesecondaryweapon(self.classstruct);
    thread ref_13c58();
    return;
  }
}

function loadout_giveprimaryweapon(var_0, var_1, var_2) {
  self.loadoutprimary = var_0.loadoutprimary;
  self.loadoutprimarycamo = var_0.loadoutprimarycamo;
  self.loadoutprimaryattachments = var_0.loadoutprimaryattachments;
  self.loadoutprimaryattachmentids = var_0.loadoutprimaryattachmentids;
  self.loadoutprimaryreticle = var_0.loadoutprimaryreticle;
  self.loadoutprimarylootitemid = var_0.loadoutprimarylootitemid;
  self.loadoutprimaryvariantid = var_0.loadoutprimaryvariantid;
  var_3 = zombiespawninair("primary", var_0.loadoutprimaryobject, var_1, var_2);
  self.primaryweapon = var_0.loadoutprimaryfullname;
  self.primaryweaponobj = var_0.loadoutprimaryobject;
  self.pers["primaryWeapon"] = var_0.loadoutprimaryfullname;
  return var_3;
}

function loadout_givesecondaryweapon(var_0, var_1, var_2) {
  self.loadoutsecondary = var_0.loadoutsecondary;
  self.loadoutsecondarycamo = var_0.loadoutsecondarycamo;
  self.loadoutsecondaryattachments = var_0.loadoutsecondaryattachments;
  self.loadoutsecondaryattachmentids = var_0.loadoutsecondaryattachmentids;
  self.loadoutsecondaryreticle = var_0.loadoutsecondaryreticle;
  self.loadoutsecondarylootitemid = var_0.loadoutsecondarylootitemid;
  self.loadoutsecondaryvariantid = var_0.loadoutsecondaryvariantid;
  var_3 = zombiespawninair("secondary", var_0.loadoutsecondaryobject, var_1, var_2);
  self.secondaryweapon = var_0.loadoutsecondaryfullname;
  self.secondaryweaponobj = var_0.loadoutsecondaryobject;
  self.pers["secondaryWeapon"] = var_0.loadoutsecondaryfullname;
  return var_3;
}

function zombiespawninair(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(!istrue(var_3)) {
    var_4 = var_1;
  } else {
    var_4 = respawnitems_getweaponobj(var_2, var_0);
  }

  if(!getqueuedspleveltransients(var_4)) {
    if(scripts\mp\riotshield::isriotshield(var_4) && !scripts\mp\flags::gameflag("prematch_done") && isDefined(self.infil) && !istrue(self.stopchallengetimers)) {} else {
      var_4 = scripts\mp\weapons::updatesavedaltstate(var_4);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4, undefined, undefined, 1);
      scripts\mp\weapons::updatetogglescopestate(var_4);
      scripts\mp\perks\weaponpassives::loadoutweapongiven(var_4);
    }
  }

  return var_4;
}

function zombievehiclelaststand(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_0.loadoutprimaryobject) && var_0.loadoutprimaryobject.basename != "none") {
    GscBinSkip0(0x2e, var_6.size, var_0.loadoutprimaryobject);
  }

  if(isDefined(var_0.loadoutsecondaryobject) && var_0.loadoutsecondaryobject.basename != "none") {
    GscBinSkip0(0x2e, var_6.size, var_0.loadoutsecondaryobject);
  }

  foreach(var_8 in var_6) {
    var_8.should_spawn_boss_one = var_8 hasattachment("maxammo", 1);
  }

  if(isDefined(level.ref_11c73)) {
    self[[level.ref_11c73]](var_6);
  } else if(istrue(var_4)) {
    respawnitems_giveweaponammo(var_3, "primary");
    respawnitems_giveweaponammo(var_3, "secondary");
  } else if(var_5 != 3) {
    if(isDefined(var_1)) {
      spawnammocountoverride_giveweaponammo(var_1, "primary", var_5);
    }

    if(isDefined(var_2)) {
      spawnammocountoverride_giveweaponammo(var_2, "secondary", var_5);
    }
  } else {
    foreach(var_8 in var_6) {
      if(istrue(var_8.should_spawn_boss_one)) {
        var_11 = weaponmaxammo(var_8) - weaponstartammo(var_8);
        var_12 = self getweaponammostock(var_8);
        self setweaponammostock(var_8, var_12 + var_11);
      }
    }
  }

  if(!istrue(var_4) && var_5 == 3) {
    foreach(var_8 in var_6) {
      if(istrue(var_8.hasalternate)) {
        var_15 = var_8 getaltweapon();
        var_16 = weaponclass(var_15);

        if(var_16 == "grenade" && istrue(var_8.should_spawn_boss_one)) {
          self setweaponammostock(var_15, 1);
        } else if(var_16 == "spread") {
          self setweaponammoclip(var_15, scripts\engine\utility::ter_op(istrue(var_8.should_spawn_boss_one), 8, 6));
        }

        continue;
      }

      if(scripts\mp\utility\weapon::turnexfiltoside(var_8)) {
        self setweaponammostock(var_8, self getweaponammostock(var_8) + weaponclipsize(var_8) * 3);
      }
    }

    return;
  }
}

function ref_11951() {
  scripts\mp\weapons::updatemovespeedscale();
}

function loadout_updateplayerperks(var_0) {
  loadout_giveperk("specialty_selectivehearing");

  if(scripts\mp\utility\game::islaststandenabled()) {
    scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
  }

  loadout_giveperk("specialty_location_marking");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    loadout_giveperk("specialty_tracker_jammer");
  }

  if(var_0.loadoutstandardperks.size > 0) {
    var_1 = getdvarint("scr_loadoutPerksOff", 0) == 0;

    if(var_1) {
      scripts\mp\perks\perks::giveperks(var_0.loadoutperks, 0);
    }
  }

  self.pers["loadoutPerks"] = var_0.loadoutperks;
  self.pers["loadoutStandardPerks"] = var_0.loadoutstandardperks;
  self.pers["loadoutExtraPerks"] = var_0.loadoutextraperks;
  self.pers["loadoutRigTrait"] = var_0.loadoutrigtrait;
  self.pers["loadoutUsingSpecialist"] = var_0.loadoutusingspecialist;

  if(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0) {
    thread scripts\mp\perks\perks::giveperksafterspawn();
  }

  if(!isagent(self) && scripts\mp\utility\dvars::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {
    scripts\mp\perks\perks::setomnvarsforperklist("ui_spawn_perk_", self.pers["loadoutPerks"]);
  }
}

function loadout_updateplayerequipment(var_0) {
  var_1 = respawnitems_getrespawnitems();
  var_2 = respawnitems_hasequipmentdata(var_1);
  self.loadoutequipmentprimary = var_0.loadoutequipmentprimary;
  self.loadoutequipmentsecondary = var_0.loadoutequipmentsecondary;
  var_3 = undefined;

  if(!var_2) {
    var_3 = var_0.loadoutequipmentprimary;
  } else {
    var_3 = respawnitems_getequipmentref(var_1, "primary");
  }

  var_4 = undefined;

  if(!var_2) {
    var_4 = var_0.loadoutequipmentsecondary;
  } else {
    var_4 = respawnitems_getequipmentref(var_1, "secondary");
  }

  scripts\mp\equipment::giveequipment(var_3, "primary");
  scripts\mp\equipment::giveequipment(var_4, "secondary");

  if(var_2) {
    respawnitems_giveequipmentammo(var_1, "primary");
    respawnitems_giveequipmentammo(var_1, "secondary");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread scripts\mp\equipment\nvg::runnvg();
    thread loadout_updateplayernvgs();
  }
}

function loadout_updateplayernvgs() {
  self endon("death_or_disconnect");
  self notify("loadout_updatePlayerNVGs");
  self endon("loadout_updatePlayerNVGs");
  var_0 = 0;

  if(game["roundsPlayed"] == 0 && !istrue(self.hasspawned)) {
    if(!scripts\mp\flags::gameflag("infil_will_run") || scripts\mp\flags::gameflag("infil_started")) {
      var_0 = 1;
    }
  } else if(istrue(self.pers["useNVG"])) {
    var_0 = 1;
  }

  if(istrue(self.inspawncamera)) {
    scripts\engine\utility::ref_143a5("spawned_player", "fadeUp_start");
  }

  while(!isDefined(self.operatorcustomization)) {
    waitframe();
  }

  if(var_0) {
    self nightvisionviewon(1);
  }

  scripts\mp\equipment\nvg::nvg_update3rdperson(var_0);
}

function loadout_updateplayersuper(var_0) {
  var_1 = scripts\cp_mp\vehicles\light_tank::light_tank_supported();

  if(!var_1 && var_0.loadoutsuper == "super_bradley") {
    var_0.loadoutsuper = "super_pac_sentry";
  }

  var_2 = var_0.loadoutsuper;
  var_3 = respawnitems_getrespawnitems();
  var_4 = respawnitems_hassuperdata(var_3);

  if(var_4) {
    var_2 = respawnitems_getsuperref(var_3);
  }

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    var_5 = scripts\mp\supers::getcurrentsuperref();

    if(var_5 == var_2 && !haschangedarchetype()) {
      scripts\mp\supers::givesuperweapon(self.super);
      return;
    }
  }

  if(var_2 == "none" || !level.allowsupers) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
    return;
  }

  if(level.allowsupers && isDefined(self.pers["gamemodeLoadout"]) && isDefined(self.pers["gamemodeLoadout"]["loadoutSuper"])) {
    self.loadoutsuper = self.pers["gamemodeLoadout"]["loadoutSuper"];
    scripts\mp\supers::givesuper(self.loadoutsuper, 1);
    return;
  }

  if(var_2 == "super_bradley" && !scripts\cp_mp\vehicles\light_tank::light_tank_supported()) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
    return;
  }

  self.loadoutsuper = var_0.loadoutsuper;
  scripts\mp\supers::givesuper(var_2, 1);

  if(var_4) {
    scripts\mp\supers::setsuperbasepoints(respawnitems_getsuperpoints(var_3));
    scripts\mp\supers::setsuperextrapoints(respawnitems_getsuperextrapoints(var_3));
  }
}

function loadout_updateplayergesture(var_0) {
  if(!istrue(self.btestclient)) {
    if(var_0.loadoutgesture != "none") {
      self.loadoutgesture = var_0.loadoutgesture;
      scripts\cp_mp\gestures::givegesture(var_0.loadoutgesture);
    }
  }
}

function zombiethermalon(var_0) {
  var_1 = getdvarint("scr_t9_watch_suppression", 0);

  if(var_1 && isDefined(var_0.loadoutaccessorydata)) {
    var_2 = scripts\mp\accessories::register_script_model_animation(var_0.loadoutaccessorydata);

    if(isDefined(var_2) && var_2 == "t9") {
      return true;
    }
  }

  return false;
}

function loadout_updateplayeraccessory(var_0) {
  if(!istrue(self.btestclient)) {
    if(isDefined(var_0.loadoutaccessoryweapon) && var_0.loadoutaccessoryweapon != "none") {
      if(zombiethermalon(var_0)) {
        return;
      }

      self.loadoutaccessorydata = var_0.loadoutaccessorydata;
      self.loadoutaccessoryweapon = var_0.loadoutaccessoryweapon;
      scripts\mp\accessories::giveplayeraccessory(var_0.loadoutaccessorydata, var_0.loadoutaccessoryweapon, var_0.loadoutaccessorylogic);
      return;
    }

    return;
  }
}

function loadout_updateplayerstreaktype(var_0) {
  self.streaktype = loadout_getplayerstreaktype(var_0.loadoutstreaktype);
}

function loadout_updateplayerkillstreaks(var_0, var_1) {
  if(!level.allowkillstreaks) {
    var_0.loadoutkillstreak1 = "none";
    var_0.loadoutkillstreak2 = "none";
    var_0.loadoutkillstreak3 = "none";
  }

  if(var_0.loadoutstreaksfilled == 0 && isDefined(self.streakdata) && self.streakdata.streaks.size > 0 && var_1 == "gamemode") {
    var_2 = 0;

    foreach(var_4 in self.streakdata.streaks) {
      if(var_2 == 0) {
        var_0.loadoutkillstreak1 = var_4;
        var_2++;
        continue;
      }

      if(var_2 == 1) {
        var_0.loadoutkillstreak2 = var_4;
        var_2++;
        continue;
      }

      if(var_2 == 2) {
        var_0.loadoutkillstreak3 = var_4;
        break;
      }
    }
  }

  if(scripts\mp\utility\game::usefloorrocks()) {
    var_2 = 0;
    var_6 = getDvar("scr_game_classtable_streak_override", "uav,precision_airstrike,directional_uav");

    if(var_6 != "") {
      var_6 = strtok(var_6, ",");

      foreach(var_4 in var_6) {
        if(var_2 == 0) {
          var_0.loadoutkillstreak1 = var_6[0];
          var_2++;
          continue;
        }

        if(var_2 == 1) {
          var_0.loadoutkillstreak2 = var_6[1];
          var_2++;
          continue;
        }

        if(var_2 == 2) {
          var_0.loadoutkillstreak3 = var_6[2];
          break;
        }
      }
    }
  }

  if(level.allowkillstreaks && getDvar("scr_restrict_killstreaks", "") != "") {
    var_9 = [];

    if(getDvar("scr_template_killstreaks", "") != "") {
      var_9 = strtok(getDvar("scr_template_killstreaks", ""), " ");

      for(var_10 = 0; var_10 < 3; var_10++) {
        if(var_10 < var_9.size) {
          var_11 = var_9[var_10];

          if(!isDefined(level.killstreaksetups[var_11])) {
            var_9 = "none";
          }

          continue;
        }

        var_9 = "none";
      }
    } else {
      GscBinSkip0(0x2e, 0, "toma_strike");
    }

    var_12 = strtok(getDvar("scr_restrict_killstreaks", ""), " ");

    foreach(var_14 in var_12) {
      if(var_0.loadoutkillstreak1 == var_14) {
        var_0.loadoutkillstreak1 = var_9[0];
        continue;
      }

      if(var_0.loadoutkillstreak2 == var_14) {
        var_0.loadoutkillstreak2 = var_9[1];
        continue;
      }

      if(var_0.loadoutkillstreak3 == var_14) {
        var_0.loadoutkillstreak3 = var_9[2];
      }
    }
  }

  var_16 = [var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3];

  if(level.allowkillstreaks) {
    self.pers["hackedStreaks"] = 0;
    var_16 = replacetankwithwheelson(var_0);
  }

  self.loadoutusingspecialist = var_0.loadoutusingspecialist;
  self getfollowedplayer(self.loadoutusingspecialist);

  if(var_0.loadoutusingspecialist && level.allowkillstreaks) {
    var_16 = replacewithspecialistkillstreaks(var_0);
  }

  var_17 = respawnitems_getrespawnitems();
  var_18 = respawnitems_hasstreakdata(var_17);

  if(var_18 && level.allowkillstreaks) {
    var_16 = respawnitems_getstreaks(var_17);
  }

  if(level.allowkillstreaks) {
    var_16 = sortkillstreaksbycost(var_16);
  }

  if(!isagent(self)) {
    var_19 = scripts\mp\killstreaks\killstreaks::arekillstreaksequipped(var_16);

    if(!var_19) {
      self notify("givingLoadout");
      var_20 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();
      var_21 = scripts\mp\killstreaks\killstreaks::getavailableequippedkillstreakstructs();

      if(!scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks") && !isDefined(self.earnedmaxkillstreak)) {
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();
      }

      for(var_22 = 0; var_22 < var_16.size; var_22++) {
        var_23 = var_16[var_22];

        if(isDefined(var_23) && var_23 != "none" && var_23 != "") {
          scripts\mp\killstreaks\killstreaks::equipkillstreak(var_23, var_22 + 1);
        }
      }

      for(var_24 = var_20.size - 1; var_24 >= 0; var_24--) {
        var_23 = var_20[var_24];

        if(!var_23.isspecialist) {
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_20[var_24], "other");
        }
      }

      for(var_24 = 0; var_24 < var_21.size; var_24++) {
        var_23 = var_21[var_24];

        if(!var_23.isspecialist) {
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_21[var_24], "other");
        }
      }
    }
  }

  self notify("equipKillstreaksFinished");
}

function sortkillstreaksbycost(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    if(isDefined(var_0[var_1]) && var_0[var_1] != "none" && var_0[var_1] != "") {
      for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
        if(isDefined(var_0[var_2]) && var_0[var_2] != "none" && var_0[var_2] != "") {
          var_3 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var_0[var_1]);
          var_4 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var_0[var_2]);

          if(var_4 < var_3) {
            var_5 = var_0[var_2];
            var_0 = var_0[var_1];
            var_0 = var_5;
          }
        }
      }
    }
  }

  return var_0;
}

function loadout_updateplayeractionslots(var_0, var_1) {
  self setactionslot(3, "altmode");
}

function loadout_updatefieldupgrades(var_0, var_1) {
  if(var_1 == "juggernaut") {
    return;
  }

  self.loadoutfieldupgrade1 = var_0.loadoutfieldupgrade1;
  self.loadoutfieldupgrade2 = var_0.loadoutfieldupgrade2;

  if(setgamebattleplayerstats(self.loadoutfieldupgrade1)) {
    self.loadoutfieldupgrade1 = "super_deadsilence";
  }

  if(setgamebattleplayerstats(self.loadoutfieldupgrade2)) {
    self.loadoutfieldupgrade2 = "super_deadsilence";
  }

  if(scripts\mp\utility\game::isanymlgmatch() || self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2) {
    self.loadoutfieldupgrade2 = "none";
  }

  if(level.allowsupers) {
    var_2 = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(var_2, "mp_m_") && var_2 != "mp_m_speed") {
      self.loadoutfieldupgrade1 = player_give_killstreak(self.loadoutfieldupgrade1);
      self.loadoutfieldupgrade2 = player_give_killstreak(self.loadoutfieldupgrade2);

      if(self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2) {
        self.loadoutfieldupgrade2 = "none";
      }
    }

    thread scripts\mp\supers::watchplayersuperdelayweapon();
    thread scripts\mp\perks\perkpackage::perkpackage_initperkpackages();

    if(scripts\mp\utility\game::getgametype() == "br") {
      var_3 = player_get_carepackage_sentry(self.loadoutfieldupgrade1);

      if(isDefined(level.forcegivesuper)) {
        self[[level.forcegivesuper]](var_3);
        return;
      }

      return;
    }

    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self.ref_11954 = player_get_carepackage_sentry(self.loadoutfieldupgrade1);

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      if(isDefined(level.forcegivesuper)) {
        self[[level.forcegivesuper]]("super_ammo_drop");
      }
    }

    self.loadoutfieldupgrade1 = "none";
    self.loadoutfieldupgrade2 = "none";

    if(getdvarint("scr_disablePerks", 0) == 0) {
      scripts\mp\perks\perkpackage::perkpackage_initpersdata();
      return;
    }

    return;
  }
}

function player_get_carepackage_sentry(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return "super_ammo_drop";
  }

  return var_0;
}

function player_give_killstreak(var_0) {
  switch (var_0) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      var_0 = "super_ammo_drop";
      break;
    default:
      break;
  }

  return var_0;
}

function loadout_updateplayer(var_0, var_1, var_2, var_3, var_4) {
  loadout_updateplayerstreaktype(var_1);
  loadout_updateplayerarchetype(var_1);

  if(!istrue(level.noweaponsonstart)) {
    loadout_updateplayerweapons(var_1, var_2, var_3, var_4);
  }

  loadout_updateplayerperks(var_1);

  if(!istrue(level.noweaponsonstart)) {
    loadout_updateplayerequipment(var_1);
  }

  if(!istrue(game["isLaunchChunk"]) && scripts\mp\utility\game::getgametype() != "br") {
    loadout_updateplayerkillstreaks(var_1, var_2);
  }

  loadout_updateplayeractionslots(var_1, var_2);

  if(!istrue(game["isLaunchChunk"])) {
    loadout_updatefieldupgrades(var_0, var_2);
  }

  self.pers["lastClass"] = self.class;
  self.lastclass = self.class;
  self.lastarchetypeinfo = self.changedarchetypeinfo;

  if(isDefined(self.gamemode_chosenclass)) {
    self.pers["class"] = self.gamemode_chosenclass;
    self.pers["lastClass"] = self.gamemode_chosenclass;
    self.class = self.gamemode_chosenclass;
    self.lastclass = self.gamemode_chosenclass;
    self.gamemode_chosenclass = undefined;
  }

  if(isDefined(self.revive_chosenclass)) {
    self.pers["class"] = self.revive_chosenclass;
    self.pers["lastClass"] = self.revive_chosenclass;
    self.class = self.revive_chosenclass;
    self.lastclass = self.revive_chosenclass;
  }

  scripts\mp\teams::setupplayermodel();
  loadout_updateplayeraccessory(var_1);
}

function setmlgspectatorclientloadoutdata(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }

  var_0 endon("disconnect");
  var_0 notify("setMLGSpectatorClientLoadoutData()");
  var_0 endon("setMLGSpectatorClientLoadoutData()");
  var_0 updatemlgammoinfo();
  var_0 disableplayeruseforallplayers(level.laststand);
  var_0 setclientweaponinfo(0, var_1.loadoutprimaryfullname);
  var_0 setclientweaponinfo(1, var_1.loadoutsecondaryfullname);

  if(isDefined(self.equipment["primary"])) {
    var_2 = scripts\mp\equipment::getequipmenttableinfo(self.equipment["primary"]);
    var_0 setclientloadoutinfo("primaryPower", var_2.id);
  }

  if(isDefined(self.equipment["secondary"])) {
    var_3 = scripts\mp\equipment::getequipmenttableinfo(self.equipment["secondary"]);
    var_0 setclientloadoutinfo("secondaryPower", var_3.id);
  }

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    var_4 = scripts\mp\codcasterclientmatchdata::getcodcasterplayervalue(var_0, "damageDone");
    scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_0, "damageDone", var_4);
  }

  if(isDefined(self.loadoutfieldupgrade1)) {
    var_0 setclientloadoutinfo("fieldUpgrade", scripts\mp\supers::getsuperid(self.loadoutfieldupgrade1));
  }

  var_5 = scripts\mp\supers::getsuperid(var_1.loadoutsuper);
  var_0 setclientloadoutinfo("super", var_5);

  if(isai(var_0)) {
    for(var_6 = 0; var_6 < var_1.loadoutperks.size; var_6++) {
      var_7 = var_1.loadoutperks[var_6];
      var_8 = scripts\mp\perks\perks::getperkid(var_7);
      var_0 setclientloadoutinfo(var_6 + 1 + "_perk", var_8);
    }
  } else {
    if(var_7.loadoutperksfromgamemode) {
      var_7.loadoutstandardperks = var_7.loadoutperks;
    }

    for(var_6 = 0; var_6 < self.pers["loadoutPerks"].size; var_6++) {
      var_7 = self.pers["loadoutPerks"][var_6];
      var_8 = scripts\mp\perks\perks::getperkid(var_7);
      var_6 setclientloadoutinfo(var_6 + 1 + "_perk", var_8);
    }

    for(var_6 = 0; var_6 < var_7.loadoutextraperks.size; var_6++) {
      var_7 = var_7.loadoutextraperks[var_6];
      var_8 = scripts\mp\perks\perks::getperkid(var_7);
      var_6 setclientloadoutinfo(var_6 + 1 + "_extraPerk", var_8);
    }
  }

  var_9 = var_7.loadoutrigtrait;
  var_10 = scripts\mp\perks\perks::getperkid(var_9);
  var_6 setclientloadoutinfo("rigTrait", var_10);
  var_11 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(var_7.loadoutarchetype);
  var_6 setclientloadoutinfo("archetype", var_11);
}

function shouldallowinstantclassswap() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1) || istrue(self.isjuggernaut)) {
    disableclassswapallowed();
  }

  if(!isDefined(self.instantclassswapallowed)) {
    return 1;
  }

  return self.instantclassswapallowed;
}

function swaploadout() {
  if(scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && scripts\engine\utility::ent_flag("swapLoadout_blocked")) {
    self endon("death_or_disconnect");
    self endon("joined_team");
    self endon("joined_spectators");
    self notify("swapLoadout");
    self endon("swapLoadout");

    if(!scripts\engine\utility::ent_flag("swapLoadout_pending")) {
      scripts\engine\utility::ent_flag_set("swapLoadout_pending");
    }

    self waittill("swapLoadout_blocked");
  }

  setclass(self.pers["class"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(scripts\mp\utility\game::allowclasschoice()) {
    scripts\mp\utility\stats::incpersstat("classChanges", 1);
  }

  giveloadout(self.pers["team"], self.pers["class"], undefined, 1);
  var_0 = scripts\mp\utility\game::unset_relic_grounded() && !scripts\mp\flags::gameflag("prematch_done");

  if(var_0 && isDefined(level.calculateclientmatchdataextrainfopayload)) {
    self[[level.calculateclientmatchdataextrainfopayload]]();
  }

  if(scripts\engine\utility::ent_flag_exist("swapLoadout_pending") && scripts\engine\utility::ent_flag("swapLoadout_pending")) {
    scripts\engine\utility::ent_flag_clear("swapLoadout_pending");
    scripts\engine\utility::ent_flag_set("swapLoadout_complete");
    return;
  }
}

function giveloadout(var_0, var_1, var_2, var_3, var_4) {
  self notify("giveLoadout_start");
  self.gettingloadout = 1;

  if(isDefined(self.perks)) {
    self.oldperks = self.perks;
  }

  loadout_clearplayer(var_3);
  var_5 = zombiesignorevehicleexplosions();
  var_5 = ref_1194e(var_5, var_1);
  self.select_bridge_two_spawners = var_5;
  var_6 = undefined;

  if(isDefined(self.preloadedclassstruct)) {
    var_6 = self.preloadedclassstruct;
    self.preloadedclassstruct = undefined;
    self.class_num = getclassindex(var_1);

    if(scripts\mp\flags::gameflag("prematch_done")) {
      self setmoverantilagged(self.class_num);
    }
  } else {
    var_6 = loadout_getclassstruct();
    var_6 = loadout_updateclass(var_6, var_1);
  }

  self.classstruct = var_6;
  loadout_updateplayer(var_5, var_6, var_1, var_2, var_4);

  if(var_1 != "juggernaut") {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      loadout_lognewlygivenloadout(var_5, var_6, var_1);
    }
  }

  self.gettingloadout = 0;
  respawnitems_clear();
  self notify("changed_kit");
  self notify("giveLoadout");
  scripts\mp\rank::tryresetrankxp();

  if(!istrue(game["isLaunchChunk"]) && !isagent(self)) {
    scripts\mp\killstreaks\killstreaks::resetforloadoutswitch();
  }

  scripts\mp\playerlogic::trydisableminimap();
}

function loadout_lognewlygivenloadout(var_0, var_1, var_2) {
  if(!isPlayer(self) && !isalive(self)) {
    return;
  }

  if(isagent(self)) {
    return;
  }

  if(level.codcasterenabled) {
    thread setmlgspectatorclientloadoutdata(self, var_1);
  }

  if(getdvarint("online_matchdata_enabled") == 0) {
    return;
  }

  if(var_1.uavbestid) {
    var_3 = 99;
    var_4 = "copied";
  } else {
    var_3 = getclassindex(var_4);
    var_4 = loadout_getclasstype(var_4);
    var_5 = getsubstr(var_4, 0, 7) == "default";

    if(var_5) {
      var_3 += 20;
    }
  }

  var_6 = var_3.tweakedbyplayerduringmatch || var_3.gamemodeforcednewloadout;
  var_3.tweakedbyplayerduringmatch = 0;
  var_3.gamemodeforcednewloadout = 0;
  var_7 = 0;

  if(!isDefined(self.pers["loggedClasses"])) {
    self.pers["loggedClasses"] = [];
  }

  var_8 = -1;

  foreach(var_10 in self.pers["loggedClasses"]) {
    var_11 = self.pers["loggedClasses"][var_12];

    if(var_11 == var_3) {
      if(var_6) {
        var_7 += 1;
        continue;
      }

      var_8 = var_12;
    }
  }

  if(var_8 == -1 || var_3.uavbestid) {
    var_8 = self.pers["loggedClasses"].size;
    self.pers["loggedClasses"][var_8] = var_3;
    loadout_logloadout(var_2, var_3, var_8, var_7, var_4);
  }

  self.loadoutindex = var_8;
}

function loadout_logloadout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = var_4;
  var_7 = var_3;

  if(isDefined(self.matchdatalifeindex)) {
    var_8 = self.matchdatalifeindex;
  } else {
    var_8 = -1;
  }

  var_9 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_10 = var_2.loadoutprimary;
  var_11 = [];

  for(var_12 = 0; var_12 < 10; var_12++) {
    var_11 = var_2.loadoutprimaryattachments[var_12];

    if(!isDefined(var_11[var_12])) {
      var_11 = "";
    }
  }

  var_13 = var_2.loadoutprimarycamo;
  var_14 = var_2.loadoutprimaryreticle;
  var_15 = var_2.loadoutprimarylootitemid;
  var_16 = var_2.loadoutprimaryvariantid;
  var_17 = var_2.loadoutsecondary;
  var_18 = [];
  var_12 = 0;

  if(var_12 < 10) {
    GscBinSkip0(0x2e, var_12, var_2.loadoutsecondaryattachments[var_12]);
  }

  var_19 = var_2.loadoutsecondarycamo;
  var_20 = var_2.loadoutsecondaryreticle;
  var_21 = var_2.loadoutsecondarylootitemid;
  var_22 = var_2.loadoutsecondaryvariantid;
  var_23 = var_2.loadoutequipmentprimary;
  var_24 = var_2.loadoutequipmentsecondary;
  var_25 = [];
  var_26 = 3;

  for(var_27 = 0; var_27 < var_26; var_27++) {
    var_28 = "specialty_null";

    if(isDefined(var_2.loadoutstandardperks[var_27])) {
      var_28 = var_2.loadoutstandardperks[var_27];
    }

    var_25 = var_28;
  }

  var_29 = [];
  var_30 = var_2.loadoutextraperks.size;

  if(var_30 > 3) {
    var_30 = 3;
  }

  for(var_27 = 0; var_27 < var_30; var_27++) {
    var_29 = var_2.loadoutextraperks[var_27];
  }

  for(var_27 = 0; var_27 < 3; var_27++) {
    if(!isDefined(var_29[var_27])) {
      var_29 = "null";
    }
  }

  self dlog_recordplayerevent("dlog_event_player_loadout", ["loadout_index", var_3, "class_type", var_7, "mid_match_edit_count", var_8, "first_use_life_index", var_8, "time_ms_from_match_start", var_9, "primary_weapon_setup_weapon", var_10, "primary_weapon_setup_attachment_0", var_11[0], "primary_weapon_setup_attachment_1", var_11[1], "primary_weapon_setup_attachment_2", var_11[2], "primary_weapon_setup_attachment_3", var_11[3], "primary_weapon_setup_attachment_4", var_11[4], "primary_weapon_setup_camo", var_13, "primary_weapon_setup_reticle", var_14, "primary_weapon_setup_loot_item_id", var_15, "primary_weapon_setup_variant_id", var_16, "secondary_weapon_setup_weapon", var_17, "secondary_weapon_setup_attachment_0", var_18[0], "secondary_weapon_setup_attachment_1", var_18[1], "secondary_weapon_setup_attachment_2", var_18[2], "secondary_weapon_setup_attachment_3", var_18[3], "secondary_weapon_setup_attachment_4", var_18[4], "secondary_weapon_setup_camo", var_19, "secondary_weapon_setup_reticle", var_20, "secondary_weapon_setup_loot_item_id", var_21, "secondary_weapon_setup_variant_id", var_22, "primary_grenade", var_23, "tactical_gear", var_24, "loadout_perk_0", var_25[0], "loadout_perk_1", var_25[1], "loadout_perk_2", var_25[2], "extra_loadout_perk_0", var_29[0], "extra_loadout_perk_1", var_29[1], "extra_loadout_perk_2", var_29[2], "killstreak_0", var_2.loadoutkillstreak1, "killstreak_1", var_2.loadoutkillstreak2, "killstreak_2", var_2.loadoutkillstreak3, "field_upgrade_0", var_1.loadoutfieldupgrade1, "field_upgrade_1", var_1.loadoutfieldupgrade2]);
}

function hasvalidationinfraction() {
  return isDefined(self.pers) && isDefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

function recordvalidationinfraction() {
  if(isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
    return;
  }
}

function _detachall(var_0) {
  if(!istrue(var_0)) {
    self.headmodel = undefined;
  }

  if(isDefined(self.riotshieldmodel)) {
    scripts\mp\riotshield::riotshield_detach(1);
  }

  if(isDefined(self.riotshieldmodelstowed)) {
    scripts\mp\riotshield::riotshield_detach(0);
  }

  if(!istrue(var_0)) {
    self detachall();
  }

  scripts\mp\equipment\nvg::clearnvg(istrue(var_0));
}

function trackriotshield_ontrophystow() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(var_0.basename != "trophy_mp") {
      continue;
    }

    if(!isDefined(self.riotshieldmodel)) {
      continue;
    }

    scripts\mp\riotshield::riotshield_move(1);
    self waittill("offhand_end");

    if(scripts\mp\riotshield::isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed)) {
      scripts\mp\riotshield::riotshield_move(0);
    }
  }
}

function valuehud(var_0) {
  if(isDefined(var_0) && var_0.basename != "none") {
    if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
      return true;
    }

    var_1 = scripts\mp\utility\weapon::getequipmenttype(var_0.basename);

    if(isDefined(var_1) && var_1 == "lethal") {
      return true;
    }
  }

  return false;
}

function ref_13c57() {
  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(!nullweapon(var_0) && var_0.basename == "c4_mp_p" && scripts\mp\riotshield::isriotshield(self getcurrentweapon())) {
      self.ref_1207e = 1;
    }

    waitframe();
  }
}

function ref_13c5d() {
  if(!istrue(self.ref_1207e)) {
    var_0 = self getheldoffhand();

    if(!nullweapon(var_0) && var_0.basename != "c4_mp_p" && scripts\mp\riotshield::isriotshield(self getcurrentweapon()) && valuehud(var_0)) {
      self.ref_1207e = 1;
      return;
    }

    return;
  }
}

function ref_13c5f() {
  self.ref_12d52 = undefined;
  self.ref_12d51 = undefined;

  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(!scripts\mp\riotshield::isriotshield(var_0)) {
      self.ref_12d52 = gettime() + 200;
      continue;
    }

    self.ref_12d52 = undefined;
    self.ref_12d51 = undefined;
  }
}

function ref_13c5e() {
  for(;;) {
    self waittill("weapon_switch_canceled", var_0);
    waittillframeend();

    if(scripts\mp\riotshield::isriotshield(var_0)) {
      self.ref_12d52 = undefined;
      self.ref_12d51 = undefined;
    }
  }
}

function ref_13c58(var_0) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");

  if(isDefined(self.infil)) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  GscBinSkip4(0x35);
}

function ref_13c5a() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_1) {
    if(var_0) {
      scripts\mp\riotshield::riotshield_move(1);
      return;
    }

    scripts\mp\riotshield::riotshield_attach(0, scripts\mp\riotshield::riotshield_getmodel());
    return;
  }
}

function ref_13c59() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_0) {
    if(var_1) {
      scripts\mp\riotshield::riotshield_move(0);
      return;
    }

    scripts\mp\riotshield::riotshield_attach(1, scripts\mp\riotshield::riotshield_getmodel());
    return;
  }
}

function ref_13c5b() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(var_0) {
    scripts\mp\riotshield::riotshield_detach(1);
  }

  if(var_1) {
    scripts\mp\riotshield::riotshield_detach(0);
    return;
  }
}

function ref_13c5c() {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    var_0 = scripts\mp\riotshield::isriotshield(self getcurrentweapon());

    if(var_0) {
      ref_13c59();
      return;
    }

    ref_13c5a();
    return;
  }

  var_1 = isDefined(self.riotshieldmodel);
  var_2 = isDefined(self.riotshieldmodelstowed);

  if(var_1) {
    scripts\mp\riotshield::riotshield_detach(1);
  }

  if(var_2) {
    scripts\mp\riotshield::riotshield_detach(0);
    return;
  }
}

function riotshieldonweaponchange(var_0) {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    thread ref_13c58();
    return;
  }

  ref_13c5c();
  ref_12d4e();
  self notify("riotshield_detach");
}

function ref_12d4e(var_0) {
  self.watch_for_heli_bosses_dead = undefined;
  self.watch_for_heli_death = undefined;
  self.ref_1443a = undefined;

  if(istrue(var_0)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
    return;
  }
}

function fixsuperforbr(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = buildweaponassetname(var_0, var_4);
  var_10 = scripts\mp\utility\weapon::weaponattachcustomtoidmap(var_0, var_4);

  if(!isDefined(var_10)) {
    var_10 = [];
  }

  var_11 = [];

  foreach(var_16, var_13 in var_10) {
    var_14 = scripts\mp\utility\weapon::attachmentmap_tounique(var_16, var_9);
    var_15 = scripts\mp\utility\weapon::carryiteminfo(var_14);

    if(isDefined(var_15)) {
      var_11 = 1;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_16 in var_1) {
      if(var_11.size > 0) {
        var_14 = scripts\mp\utility\weapon::attachmentmap_tounique(var_16, var_9);
        var_15 = scripts\mp\utility\weapon::carryitemomnvar(var_14);

        if(isDefined(var_11[var_15])) {
          continue;
        }
      }

      var_18 = 0;

      if(isDefined(var_5) && isDefined(var_5[var_19])) {
        var_18 = var_5[var_19];
      }

      var_10 = var_18;
    }
  }

  return buildweapon_attachmentidmap(var_0, var_10, var_2, var_3, var_4, var_6, var_7, var_8);
}

function fixcollision(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\mp\utility\weapon::weaponattachcustomtoidmap(var_0, var_3);

  if(!isDefined(var_7)) {
    var_7 = [];
  }

  return buildweapon_attachmentidmap(var_0, var_7, var_1, var_2, var_3, var_4, var_5, var_6);
}

function buildweapon_attachmentidmap(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  foreach(var_11 in var_1) {
    var_8 = var_12;
    var_9 = var_11;
  }

  return buildweapon(var_0, var_8, var_2, var_3, var_4, var_9, var_5, var_6, var_7);
}

function buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {} else {
    var_1 = [];
  }

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(isDefined(var_4) && var_4 <= 0) {
    var_4 = undefined;
  }

  var_9 = buildweaponassetname(var_0, var_4);
  var_10 = buildweaponattachmentidmap(var_1, var_5);

  if(istrue(var_8)) {
    if(scripts\mp\utility\weapon::weaponsupportslaserir(var_9)) {
      var_11 = scripts\mp\utility\weapon::getweaponnvgattachment(var_9);

      if(!isDefined(var_10[var_11])) {
        if(var_10.size > 0) {
          var_10 = 0;
        }
      }
    }
  }

  var_12 = buildweaponuniqueattachmenttoidmap(var_0, var_10, var_4);

  if(isDefined(var_6) && var_6 != "none") {
    var_6 = player_get_secondary_weapon_object(var_6);
    GscBinSkip0(0x2e, var_6, 0);
  }

  var_12 = filterinvalidattachmentsfromidmap(var_12, var_9);
  var_12 = getbrendsplashpostgamestate(var_12, var_9);

  if(!isDefined(var_9) || var_9 == "") {
    scripts\mp\utility\script::laststand_dogtags("buildWeapon - bad weaponAssetName - rootName: " + scripts\engine\utility::ter_op(isDefined(var_0), var_0, "null") + ", variant: " + scripts\engine\utility::ter_op(isDefined(var_4), var_4, "none"));
  }

  var_13 = getcompleteweaponname(var_9, [], undefined, var_2, var_4);

  if(isDefined(var_9) && !isDefined(var_13)) {
    scripts\mp\utility\script::laststand_dogtags("buildWeapon - null weapon: weaponAssetName = " + var_9 + ", rootName = " + scripts\engine\utility::ter_op(isDefined(var_0), var_0, "null") + ", variant = " + scripts\engine\utility::ter_op(isDefined(var_4), var_4, "none"));
  }

  foreach(var_15 in var_12) {
    var_13 = var_13 withattachment(var_16, var_15);
  }

  if(isDefined(var_7)) {
    for(var_17 = 0; var_17 < var_7.size; var_17++) {
      var_18 = var_7[var_17];

      if(var_18 == "none") {
        continue;
      }

      if("i/" != getsubstr(var_18, 0, 2)) {
        var_18 = "i/" + var_7[var_17];
      }

      var_13 = var_13 setsticker(var_17, var_18);
    }
  }

  if(isDefined(var_13.scope) && !isstartstr(var_13.scope, "ironsdefault")) {
    var_19 = getreticleindex(var_3);

    if(isDefined(var_19)) {
      var_13 = var_13 withreticle(var_19);
    }
  }

  return var_13;
}

function player_get_secondary_weapon_object(var_0) {
  switch (var_0) {
    case "t9_charm_rebirthIsland_01":
      var_0 = "t9_charm_rebirthisland_01";
    default:
      break;
  }

  return var_0;
}

function buildweaponattachmentidmap(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_1) && var_5 < var_1.size) {
      var_2 = var_1[var_5];
      continue;
    }

    var_2 = 0;
  }

  return var_2;
}

function buildweaponuniqueattachmenttoidmap(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_1 = scripts\engine\utility::array_remove_key(var_1, "none");
  var_3 = scripts\mp\utility\weapon::weaponattachdefaulttoidmap(var_0, var_2);
  var_4 = buildweaponassetname(var_0, var_2);
  var_5 = [];

  if(isDefined(var_3)) {
    var_5 = combinedefaultandcustomattachmentidmaps(var_3, var_1);
  }

  var_6 = [];

  if(var_5.size > 0) {
    var_5 = filterattachmenttoidmap(var_5, var_0);

    foreach(var_8 in var_5) {
      var_9 = scripts\mp\utility\weapon::attachmentmap_tounique(var_10, var_4);
      var_6 = var_8;
    }
  }

  var_11 = [];
  var_12 = 0;
  var_13 = undefined;

  foreach(var_20, var_8 in var_6) {
    var_15 = scripts\mp\utility\weapon::attachmentmap_toextra(var_20);

    if(isDefined(var_15)) {
      var_16 = 0;

      if(isDefined(var_2)) {
        var_17 = scripts\mp\utility\weapon::attachmentmap_tobase(var_15);
        var_16 = scripts\mp\utility\weapon::attachmentmap_extratovariantid(var_17, var_0, var_2);
      } else if(var_8 != 0) {
        var_16 = var_8;
      }

      var_18 = scripts\mp\utility\weapon::attachmentmap_tounique(var_15, var_4);
      var_11 = var_16;
    }

    var_19 = scripts\mp\utility\weapon::attachmentmap_tobase(var_20);

    if(!isDefined(var_13) && tv_station_fastrope_two_infil_rider_start_targetname(var_19)) {
      var_13 = var_20;
    }

    if(!var_12 && (useeventtype(var_19) || useeventtimestamp(var_20))) {
      var_12 = 1;
    }
  }

  if(var_11.size > 0) {
    var_6 = scripts\engine\utility::array_combine_unique_keys(var_6, var_11);
  }

  if(isDefined(var_13) && var_12 && !issubstr(var_0, "s4_")) {
    var_13 = scripts\engine\utility::ter_op(var_13 == "calsmg_mike4", "calsil_mike4smg", "calsil");
    var_6 = 0;
  }

  return var_6;
}

function combinedefaultandcustomattachmentidmaps(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(scripts\engine\utility::array_contains_key(var_1, var_5)) {
      continue;
    }

    var_2 = var_4;
  }

  foreach(var_4 in var_1) {
    var_2 = var_4;
  }

  return var_2;
}

function filterattachmenttoidmap(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = getfirstarraykey(var_0);
  var_4 = var_5;

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    var_7 = var_4[var_6];

    if(var_7 != "none") {
      var_8 = scripts\mp\utility\weapon::attachmentmap_tounique(var_7, var_1);
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

        var_12 = scripts\mp\utility\weapon::attachmentsconflict(var_7, var_11, var_1, var_8, var_3[var_10]);

        if(var_12 == var_7) {
          var_2 = "";
          var_3 = "";
          continue;
        }

        if(var_12 != "") {
          var_2 = "";
          var_3 = "";
          var_9 = 0;
          var_13 = [];
          var_13 = strtok(var_12, " ");

          for(var_14 = 0; var_14 < var_13.size; var_14++) {
            var_4 = var_13[var_14];
          }

          break;
        }
      }

      if(var_9) {
        var_15 = var_2.size;
        var_2 = var_7;
        var_3 = var_8;
      }
    }

    if(var_6 == var_4.size - 1) {
      var_5 = getnextarraykey(var_0, var_5);

      if(isDefined(var_5)) {
        var_4 = var_5;
      }
    }
  }

  var_16 = [];

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];

    if(var_7 != "") {
      var_17 = scripts\engine\utility::ter_op(isDefined(var_0[var_7]), var_0[var_7], 0);
      var_16 = var_17;
    }
  }

  return var_16;
}

function filterinvalidattachmentsfromidmap(var_0, var_1) {
  var_2 = getcompleteweaponname(var_1);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_2 canuseattachment(var_6)) {
      var_3 = var_5;
      continue;
    }

    thread invalidattachmentwarning(var_6, var_1);
  }

  return var_3;
}

function getbrendsplashpostgamestate(var_0, var_1) {
  if(!isDefined(level.attachmentoverridetobase)) {
    level.attachmentoverridetobase = [];
  }

  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = var_10;

    foreach(var_9, var_7 in var_0) {
      var_8 = scripts\mp\utility\weapon::attachmentmap_tobase(var_10);

      if(isDefined(level.carryingplayer[var_9]) && isDefined(level.carryingplayer[var_9][var_8])) {
        var_5 = level.carryingplayer[var_9][var_8];
        level.attachmentoverridetobase[var_5] = var_8;
      }
    }

    var_2 = var_4;
  }

  return var_2;
}

function invalidattachmentwarning(var_0, var_1) {
  var_2 = "Invalid Attachment: " + var_0 + " on " + var_1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("scr_playtest", 0) == 1) {
      self iprintlnbold(var_2);
    }
  }
}

function buildweaponassetname(var_0, var_1) {
  return scripts\mp\utility\weapon::weaponassetnamemap(var_0, var_1);
}

function getreticleindex(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = int(tablelookup("mp/reticleTable.csv", 1, var_0, 5));

  if(!isDefined(var_1) || var_1 == 0) {
    return undefined;
  }

  return var_1;
}

function tv_station_fastrope_two_infil_rider_start_targetname(var_0) {
  return var_0 == "calcust" || var_0 == "calsmg" || var_0 == "calsmgdrums";
}

function useeventtimestamp(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "barsil_") || var_0 == "barcust2_mpapa5" || scripts\engine\utility::string_starts_with(var_0, "front_valpha") || var_0 == "barlight_valpha" || var_0 == "barheavy_valpha" || var_0 == "barshort_valpha";
}

function useeventtype(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "silencer");
}

function vehicle_checkpiggybackexploit(var_0) {
  return var_0 method_87b8();
}

function getweaponpassives(var_0, var_1) {
  return scripts\mp\loot::getpassivesforweapon(var_0, var_1);
}

function weaponhaspassive(var_0, var_1, var_2) {
  var_3 = getweaponpassives(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0) {
    return false;
  }

  foreach(var_5 in var_3) {
    if(var_2 == var_5) {
      return true;
    }
  }

  return false;
}

function getweaponvariantattachments(var_0, var_1) {
  var_2 = [];
  var_3 = getweaponpassives(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = scripts\mp\passives::getpassiveattachment(var_5);

      if(!isDefined(var_6)) {
        continue;
      }

      var_2 = var_6;
    }
  }

  return var_2;
}

function replenishloadout() {
  var_0 = self.pers["team"];
  var_1 = self.pers["class"];
  var_2 = self getweaponslistall();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    self givemaxammo(var_4);
    self setweaponammoclip(var_4, 9999);
    var_5 = var_4.basename;

    if(var_5 == "claymore_mp" || var_5 == "claymore_detonator_mp") {
      self setweaponammostock(var_4, 2);
    }
  }
}

function onplayerconnecting() {
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
    var_0.lastclass = var_0.pers["lastClass"];
    var_0.changedarchetypeinfo = var_0.pers["changedArchetypeInfo"];
    var_0.lastarchetypeinfo = undefined;

    if(!isDefined(var_0.pers["validationInfractions"])) {
      var_0.pers["validationInfractions"] = 0;
    }
  }
}

function onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 enableplayerbreathsystem(1);

    if(getdvarint("scr_br_alt_mode_zxp", 0)) {
      if(istrue(var_0.iszombie)) {
        var_0 method_87aa("zombie");
        var_0 setentitysoundcontext("gender", "zombie");
      } else if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "female") {
        var_0 method_87aa("female");
      } else {
        var_0 method_87aa("");
      }
    } else if(getdvarint("scr_br_alt_mode_gxp", 0)) {
      if(istrue(var_0.unset_relic_gun_game)) {
        var_0 method_87aa("ghost");
        var_0 setentitysoundcontext("gender", "zombie");
      } else if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "female") {
        var_0 method_87aa("female");
      } else {
        var_0 method_87aa("");
      }
    } else if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() == "infect" && var_0.team == "axis") {
      var_0 method_87aa("zombie");
    } else if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "female") {
      var_0 method_87aa("female");
    } else {
      var_0 method_87aa("");
    }

    var_0 stoplocalsound("deaths_door_death");

    if(isDefined(var_0.ref_12135)) {
      var_0 clearsoundsubmix("iw8_mp_spawn_camera");
      var_0.ref_12135 stoploopsound(self.ref_12136);
      var_0.ref_12135 delete();
      var_0.ref_12135 = undefined;
      var_0.ref_12136 = undefined;
    }

    if(isDefined(var_0.operatorcustomization.clothtype) && var_0.operatorcustomization.clothtype != "") {
      if(istrue(var_0.iszombie)) {
        var_0 setclothtype("cloth");
      } else {
        var_0 setclothtype(var_0.operatorcustomization.clothtype);
      }

      continue;
    }

    var_0 setclothtype("vestlight");
  }
}

function fadeaway(var_0, var_1) {
  wait var_0;
  self fadeovertime(var_1);
  self.alpha = 0;
}

function setclass(var_0) {
  self.curclass = var_0;
}

function haschangedclass() {
  if(isDefined(self.lastclass) && self.lastclass != self.class || !isDefined(self.lastclass)) {
    return true;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && (!isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class)) {
    return true;
  }

  return false;
}

function haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo)) {
      return true;
    }

    if(self.changedarchetypeinfo != self.lastarchetypeinfo) {
      return true;
    }
  }

  return false;
}

function resetactionslots() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");

  if(!isagent(self) && !self isconsoleplayer()) {
    self setactionslot(5, "");
    self setactionslot(6, "");
    self setactionslot(7, "");
    return;
  }
}

function resetfunctionality() {
  self enableequipdeployvfx(0);

  if(!isagent(self)) {
    self setclientomnvar("ui_hide_hud", 0);
    vehicle_allowplayeruse(self, 1);

    if(level.minimaponbydefault) {
      self setclientomnvar("ui_hide_minimap", 0);
    } else {
      self setclientomnvar("ui_hide_minimap", 1);
    }
  }

  scripts\common\input_allow::clear_all_allow_info();
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141ca(self, 1);
  scripts\common\utility::allow_script_weapon_switch(0);
  self.doublejumpenergy = undefined;
  self.doublejumpenergyrestorerate = undefined;
  self.enabledcollisionnotifies = undefined;
  self.enabledequipdeployvfx = undefined;
  self.minimapstatetracker = undefined;
  self.isstunned = undefined;
  self.isblinded = undefined;
  self.nocorpse = undefined;
  self.prematchlook = undefined;
  self.ladderexecutionblocked = undefined;
  scripts\mp\damage::resetattackerlist();
  scripts\mp\damage::clearcorpsetablefuncs();
  ref_12d4e();
  scripts\cp_mp\utility\player_utility::cleardemeanorsafe();
  scripts\mp\weapons::clearburnfx();
  scripts\mp\equipment\molotov::ref_11cb6();
  scripts\mp\equipment\throwing_knife_mp::ref_13b52();
  scripts\mp\equipment\flash_grenade::clearflash(1);
  scripts\mp\equipment\gas_grenade::gas_clear(1);

  if(!isagent(self)) {
    scripts\mp\utility\player::spawn_carriables_from_scriptables_total_percentage();
    scripts\cp_mp\killstreaks\helper_drone::markeduioff();
  }

  scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
  scripts\mp\utility\player::_resetenableignoreme();
  scripts\cp_mp\utility\player_utility::ref_125d0();
}

function clearscriptable() {
  self setscriptablepartstate("CompassIcon", "defaultIcon");
}

function changearchetype(var_0, var_1, var_2) {
  if(isDefined(self.changedarchetypeinfo)) {
    var_3 = self.changedarchetypeinfo;

    if(var_3.archetype == var_0 && var_3.super == var_1 && var_3.trait == var_2) {
      return;
    }
  }

  var_4 = spawnStruct();
  var_4.archetype = var_0;
  var_4.super = var_1;
  var_4.trait = var_2;
  self.changedarchetypeinfo = var_4;
  self.pers["changedArchetypeInfo"] = var_4;

  if(isDefined(self.pers["class"]) && self.pers["class"] != "") {
    preloadandqueueclass(self.pers["class"]);

    if(shouldallowinstantclassswap()) {
      thread swaploadout();
      return;
    }

    if(isalive(self)) {
      self iprintlnbold(game["strings"]["change_rig"]);
      return;
    }

    return;
  }
}

function getattachmentloadoutstring(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "primary", "loadoutPrimaryAttachment", "loadoutSecondaryAttachment");

  if(var_0 == 0) {
    return var_2;
  }

  return var_2 + var_0 + 1;
}

function getstickerloadoutstring(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "primary", "loadoutPrimarySticker", "loadoutSecondarySticker");

  if(var_0 == 0) {
    return var_2;
  }

  return var_2 + var_0 + 1;
}

function getmaxprimaryattachments() {
  return 10;
}

function getmaxsecondaryattachments() {
  return 10;
}

function getmaxattachments(var_0) {
  return scripts\engine\utility::ter_op(var_0 == "primary", getmaxprimaryattachments(), getmaxsecondaryattachments());
}

function fillemptystreakslots(var_0, var_1) {
  if(!level.allowkillstreaks) {
    return;
  }

  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_5 == "none") {
      var_2 = var_6;
      continue;
    }

    var_3 = var_5;
  }

  if(var_2.size > 0) {
    self.pers["hackedStreaks"] = 1;
  }

  foreach(var_8 in var_2) {
    var_9 = findfirststreakdifferentcost(var_3);

    if(var_8 + 1 == 1) {
      var_1.loadoutkillstreak1 = var_9;
    } else if(var_8 + 1 == 2) {
      var_1.loadoutkillstreak2 = var_9;
    } else {
      var_1.loadoutkillstreak3 = var_9;
    }

    var_3 = var_9;
  }

  return [var_1.loadoutkillstreak1, var_1.loadoutkillstreak2, var_1.loadoutkillstreak3];
}

function findfirststreakdifferentcost(var_0) {
  var_1 = [];

  foreach(var_8, var_3 in game["killstreakTable"].tabledatabyref) {
    if(!istrue(int(var_3["shownInMenu"]))) {
      continue;
    }

    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_8 == var_6 || scripts\mp\killstreaks\killstreaks::calcstreakcost(var_8) == scripts\mp\killstreaks\killstreaks::calcstreakcost(var_6)) {
        var_4 = 1;
        break;
      }
    }

    if(!istrue(var_4)) {
      var_1 = var_8;
    }
  }

  return var_1[0];
}

function replacetankwithwheelson(var_0) {
  if(!level.allowkillstreaks) {
    return;
  }

  var_1 = scripts\cp_mp\vehicles\light_tank::light_tank_supported();

  if(!var_1) {
    if(var_0.loadoutkillstreak1 == "bradley") {
      var_0.loadoutkillstreak1 = "pac_sentry";
    } else if(var_0.loadoutkillstreak2 == "bradley") {
      var_0.loadoutkillstreak2 = "pac_sentry";
    } else if(var_0.loadoutkillstreak3 == "bradley") {
      var_0.loadoutkillstreak3 = "pac_sentry";
    }

    self.pers["hackedStreaks"] = 1;
  }

  return [var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3];
}

function replacewithspecialistkillstreaks(var_0) {
  return ["specialist_perk_1", "specialist_perk_2", "specialist_perk_3", "specialist_perk_bonus"];
}

function updateinstantclassswapallowed() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self.instantclassswapallowed = 1;

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_0 = scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic());

    if(var_0) {
      scripts\mp\flags::gameflagwait("prematch_fade_done");
      ref_13fe4();
    }
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
    ref_13fe4();
  }

  disableclassswapallowed();
}

function ref_13fe4() {
  self endon("death");
  var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::ismlgmatch(), 5, 15);

  if(scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic())) {
    while(scripts\mp\utility\game::updatehistoryhud(self)) {
      waitframe();
    }

    self waittill("parachute_complete");
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_tune_up")) {
    var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::ismlgmatch(), 5, 5);
  }

  wait var_0;
}

function disableclassswapallowed() {
  if(istrue(self.instantclassswapallowed)) {
    self.instantclassswapallowed = 0;

    if(scripts\mp\utility\game::isteamreviveenabled()) {
      self.revive_chosenclass = self.class;
      self.pers["next_round_class"] = self.class;
      return;
    }

    return;
  }
}

function isvalidclass(var_0) {
  return isDefined(var_0) && var_0 != "";
}

function getclassindex(var_0) {
  return level.classmap[var_0];
}

function preloadandqueueclass(var_0, var_1) {
  var_2 = loadout_getorbuildclassstruct(var_0);
  preloadandqueueclassstruct(var_2, var_1);
  return var_2;
}

function preloadandqueueclassstruct(var_0, var_1, var_2) {
  var_3 = scripts\mp\playerlogic::getplayerassets(var_0);
  scripts\mp\playerlogic::loadplayerassets([var_3], var_1, var_2);
  self.preloadedclassstruct = var_0;
}

function loadout_getorbuildclassstruct(var_0) {
  if(self.team == "spectator" && !isDefined(var_0)) {
    var_0 = "custom1";
  }

  var_1 = loadout_getclasstype(var_0);
  var_2 = getcachedloadoutstruct(var_0, var_1);
  var_3 = var_1 == "custom" || var_1 == "default";

  if(var_3 && scripts\mp\utility\game::unset_relic_grounded()) {
    self.wam_sequence = var_0;
  }

  if(isDefined(var_2)) {
    if(!isDefined(var_2.loadoutprimaryobject) && isDefined(var_2.loadoutprimaryfullname)) {
      var_2.loadoutprimaryobject = asmdevgetallstates(var_2.loadoutprimaryfullname);
    }

    if(!isDefined(var_2.loadoutsecondaryobject) && isDefined(var_2.loadoutsecondaryfullname)) {
      var_2.loadoutsecondaryobject = asmdevgetallstates(var_2.loadoutsecondaryfullname);
    }
  }

  if(isDefined(var_2)) {
    if(var_0 == "gamemode") {
      var_4 = loadout_getclassstruct();
      var_4 = loadout_updateclass(var_4, var_0);
      var_5 = compareclassstructs(var_4, var_2);

      if(!var_5) {
        var_4.gamemodeforcednewloadout = 1;
        trytocacheclassstruct(var_4, var_0, var_1);
        return var_4;
      }
    }

    return var_2;
  }

  var_6 = loadout_getclassstruct();
  var_6 = loadout_updateclass(var_6, var_0);
  trytocacheclassstruct(var_6, var_0, var_1);
  return var_6;
}

function zombiesignorevehicleexplosions() {
  if(!isDefined(self.pers["globalLoadoutStruct"])) {
    ref_11950();
  }

  return self.pers["globalLoadoutStruct"];
}

function ref_11950() {
  var_0 = spawnStruct();

  if(!isagent(self)) {
    var_0.loadoutfieldupgrade1 = cac_getfieldupgrade(0);
    var_0.loadoutfieldupgrade2 = cac_getfieldupgrade(1);
  } else {
    var_0.loadoutfieldupgrade1 = "none";
    var_0.loadoutfieldupgrade2 = "none";
  }

  self.pers["globalLoadoutStruct"] = var_0;
}

function zombieregenratescaleoutgas() {
  var_0 = zombiesignorevehicleexplosions();
  ref_11950();
  var_1 = zombiesignorevehicleexplosions();

  if(var_0.loadoutfieldupgrade1 != var_1.loadoutfieldupgrade1) {
    return true;
  }

  if(var_0.loadoutfieldupgrade2 != var_1.loadoutfieldupgrade2) {
    return true;
  }

  return false;
}

function ref_1194f(var_0, var_1) {
  var_2 = self.pers["gamemodeLoadout"];

  if(isDefined(var_2["loadoutFieldUpgrade1"])) {
    var_0.loadoutfieldupgrade1 = var_2["loadoutFieldUpgrade1"];
  }

  if(isDefined(var_2["loadoutFieldUpgrade2"])) {
    var_0.loadoutfieldupgrade2 = var_2["loadoutFieldUpgrade2"];
    return;
  }
}

function loadout_editcachedclassstruct(var_0) {
  var_1 = loadout_getclasstype(var_0);
  var_2 = getcachedloadoutstruct(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = loadout_getclassstruct();
    var_3 = loadout_updateclass(var_3, var_0);
    var_4 = compareclassstructs(var_3, var_2);

    if(!var_4) {
      var_3.tweakedbyplayerduringmatch = 1;
      trytocacheclassstruct(var_3, var_0, var_1);
      return true;
    }
  }

  return false;
}

function getcachedloadoutstruct(var_0, var_1) {
  switch (var_1) {
    case "custgamemode":
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

function trytocacheclassstruct(var_0, var_1, var_2) {
  switch (var_2) {
    case "custgamemode":
    case "custom":
    case "gamemode":
    case "default":
      addclassstructtocache(var_0, var_1);
      break;
  }
}

function addclassstructtocache(var_0, var_1) {
  if(!isDefined(self.pers["classCache"])) {
    self.pers["classCache"][var_1] = [];
  }

  self.pers["classCache"][var_1] = var_0;
}

function loadout_emptycacheofloadout(var_0) {
  if(!isDefined(self.pers["classCache"])) {
    return;
  }

  self.pers["classCache"][var_0] = undefined;
}

function loadout_gamemodeloadoutchanged() {
  self.pers["classCache"]["gamemode"] = undefined;
}

function copyclassfornextlife(var_0) {
  self setclientomnvar("ui_loadout_copied", gettime());
  thread allow_cp_munitions();
  var_1 = undefined;

  if(isDefined(var_0.juggcontext) && isDefined(var_0.juggcontext.prevclassstruct)) {
    var_1 = var_0.juggcontext.prevclassstruct;
  } else {
    var_1 = var_0.classstruct;
  }

  self.pers["copiedClass"] = zombieregenratescaleingas(var_1);
  self.pers["lastKiller"] = var_0;
}

function allow_cp_munitions() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned");
  self setclientomnvar("ui_loadout_changed", 11);
}

function zombiesdamagezombies(var_0, var_1) {
  var_0.loadoutsuper = var_1.loadoutsuper;
  var_0.loadoutstreaksfilled = var_1.loadoutstreaksfilled;
  var_0.loadoutstreaktype = var_1.loadoutstreaktype;
  var_0.loadoutkillstreak1 = var_1.loadoutkillstreak1;
  var_0.loadoutkillstreak2 = var_1.loadoutkillstreak2;
  var_0.loadoutkillstreak3 = var_1.loadoutkillstreak3;
  var_0.loadoutaccessoryweapon = var_1.loadoutaccessoryweapon;
  var_0.loadoutaccessorydata = var_1.loadoutaccessorydata;
  var_0.loadoutaccessorylogic = var_1.loadoutaccessorylogic;
  var_0.tweakedbyplayerduringmatch = 0;
  var_0.gamemodeforcednewloadout = 0;
  var_0.uavbestid = 1;
}

function shouldskipfirstraise(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!istrue(self.hasspawned)) {
    var_1 = 1;
  }

  if(scripts\cp_mp\utility\game_utility::shouldskipfirstraise() && istrue(self.hasspawned)) {
    var_1 = 1;
  }

  if(istrue(self.ref_1443d)) {
    var_1 = 1;
  }

  if(weaponclass(var_0.basename) == "mg" && !istrue(self.usingascender)) {
    var_1 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && istrue(self.faux_spawn_infected)) {
    var_1 = 1;
  }

  return var_1;
}

function respawnitems_saveplayeritemstostruct(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_3 = 0;

  if(!isDefined(var_0) || var_0) {
    respawnitems_saveweapons(var_4);
  }

  if(!isDefined(var_1) || var_1) {
    respawnitems_saveequipmentitems(var_4);
  }

  if(!isDefined(var_2) || var_2) {
    respawnitems_savestreaks(var_4);
  }

  if(!isDefined(var_3) || var_3) {
    respawnitems_savesuper(var_4);
  }

  return var_4;
}

function respawnitems_assignrespawnitems(var_0) {
  self.respawnitems = var_0;
}

function respawnitems_hasrespawnitems() {
  return isDefined(self.respawnitems);
}

function respawnitems_getrespawnitems() {
  if(isDefined(self.respawnitems)) {
    return self.respawnitems;
  }

  return undefined;
}

function respawnitems_clear() {
  self.respawnitems = undefined;
}

function respawnitems_saveweapons(var_0) {
  var_1 = [];
  var_2 = self.primaryweapons;
  var_3 = self.currentweapon;

  foreach(var_5 in var_2) {
    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_5)) {
      var_1 = var_5;
    }
  }

  var_7 = undefined;

  if(isDefined(self.lastcacweaponobj)) {
    var_7 = self.lastcacweaponobj;
  } else if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(self.currentweapon)) {
    var_7 = self.currentweapon;
  } else if(var_1.size > 0) {
    var_7 = var_1[0];
  }

  if(getqueuedspleveltransients(var_7)) {
    var_7 = getcompleteweaponname("iw8_fists_mp");
  }

  respawnitems_saveweapon(var_7, "primary", var_0);
  var_8 = undefined;

  foreach(var_5 in var_1) {
    if(!isnullweapon(var_5, var_7, 1)) {
      var_8 = var_5;
      break;
    }
  }

  if(isDefined(var_8)) {
    respawnitems_saveweapon(var_8, "secondary", var_0);
    return;
  }
}

function respawnitems_saveweapon(var_0, var_1, var_2) {
  if(!isDefined(var_2.weapons)) {
    var_2.weapons = [];
  }

  var_3 = spawnStruct();
  var_2.weapons[var_1] = var_3;
  var_3.weaponobj = var_0;
  var_3.clipammo = self getweaponammoclip(var_0);
  var_3.stockammo = self getweaponammostock(var_0);

  if(var_0.hasalternate) {
    var_4 = var_0 getaltweapon();
    var_3.altclipammo = self getweaponammoclip(var_4);
    var_3.altstockammo = self getweaponammostock(var_4);
    return;
  }
}

function respawnitems_saveequipmentitems(var_0) {
  respawnitems_saveequipment("primary", var_0);
  respawnitems_saveequipment("secondary", var_0);
}

function respawnitems_saveequipment(var_0, var_1) {
  var_2 = scripts\mp\equipment::getcurrentequipment(var_0);

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(!isDefined(var_1.equipment)) {
    var_1.equipment = [];
  }

  var_3 = spawnStruct();
  var_1.equipment[var_0] = var_3;
  var_3.item = var_2;

  if(var_2 != "none") {
    var_3.ammo = scripts\mp\equipment::getequipmentammo(var_3.item);
    return;
  }

  var_3.ammo = 0;
}

function respawnitems_savestreaks(var_0) {
  var_1 = spawnStruct();
  var_1.streaks = [];
  var_1.streakpoints = self.streakpoints;

  if(!isDefined(self.streakpoints)) {
    return;
  }

  var_2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(var_2)) {
    var_1.streaks[var_1.streaks.size] = var_2.streakname;
  }

  var_2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(2);

  if(isDefined(var_2)) {
    var_1.streaks[var_1.streaks.size] = var_2.streakname;
  }

  var_2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(3);

  if(isDefined(var_2)) {
    var_1.streaks[var_1.streaks.size] = var_2.streakname;
  }

  if(var_1.streaks.size <= 0) {
    return;
  }

  var_0.streakstate = var_1;
}

function respawnitems_savesuper(var_0) {
  var_1 = scripts\mp\supers::getcurrentsuperref();

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = spawnStruct();
  var_0.superstate = var_2;
  var_2.super = var_1;
  var_2.superpoints = scripts\mp\supers::getcurrentsuperbasepoints();
  var_2.extrapoints = scripts\mp\supers::getcurrentsuperextrapoints();
}

function respawnitems_hasweapondata(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return isDefined(var_0.weapons);
}

function respawnitems_getweaponobj(var_0, var_1) {
  return var_0.weapons[var_1].weaponobj;
}

function respawnitems_giveweaponammo(var_0, var_1) {
  var_2 = var_0.weapons[var_1];
  self setweaponammoclip(var_2.weaponobj, var_2.clipammo);
  self setweaponammostock(var_2.weaponobj, var_2.stockammo);

  if(var_2.weaponobj.hasalternate) {
    var_3 = var_2.weaponobj getaltweapon();
    self setweaponammoclip(var_3, var_2.altclipammo);
    self setweaponammostock(var_3, var_2.altstockammo);
    return;
  }
}

function respawnitems_hasequipmentdata(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return isDefined(var_0.equipment);
}

function respawnitems_getequipmentref(var_0, var_1) {
  return var_0.equipment[var_1].item;
}

function respawnitems_giveequipmentammo(var_0, var_1) {
  var_2 = respawnitems_getequipmentref(var_0, var_1);

  if(!isDefined(var_2) || var_2 == "none") {
    return;
  }

  var_3 = var_0.equipment[var_1].ammo;

  if(!isDefined(var_3)) {
    return;
  }

  scripts\mp\equipment::setequipmentammo(var_2, var_3);
}

function respawnitems_hasstreakdata(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return isDefined(var_0.streakstate);
}

function respawnitems_getstreakpoints(var_0) {
  return var_0.streakstate.streakpoints;
}

function respawnitems_getstreaks(var_0) {
  return var_0.streakstate.streaks;
}

function respawnitems_hassuperdata(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  return isDefined(var_0.superstate);
}

function respawnitems_getsuperref(var_0) {
  return var_0.superstate.super;
}

function respawnitems_getsuperpoints(var_0) {
  return var_0.superstate.superpoints;
}

function respawnitems_getsuperextrapoints(var_0) {
  return var_0.superstate.extrapoints;
}

function spawnammocountoverride_giveweaponammo(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = !var_2;

  if(var_4 && !update_health_bar_to_players(var_0)) {
    var_5 = 0;
    var_6 = 0;

    if(var_0 hasattachment("akimbo", 1)) {
      self setweaponammoclip(var_3, var_5, "left");
    }
  } else {
    var_5 = var_5.clipsize;
    var_6 = var_4 - 1;
  }

  if(var_4 == 7) {
    var_6 = weaponmaxammo(var_5);
  } else if(issubstr(var_5.basename, "iw8_sh_charlie725") && !var_6) {
    var_6 = var_5.clipsize * var_6 + 18;
  } else {
    var_6 = var_5.clipsize * var_6;
  }

  self setweaponammoclip(var_5, var_5);
  self setweaponammostock(var_5, var_6);

  if(var_2.hasalternate) {
    var_7 = var_2 getaltweapon();

    if(var_6) {
      var_8 = 0;
      var_9 = 0;
    } else {
      var_8 = self getweaponammoclip(var_9);
      var_9 = self getweaponammostock(var_9);
    }

    self setweaponammoclip(var_9, var_8);
    self setweaponammostock(var_9, var_9);
    return;
  }
}

function update_health_bar_to_players(var_0) {
  var_1 = scripts\mp\utility\weapon::isknifeonly(var_0.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_0.basename) || scripts\mp\utility\weapon::isaxeweapon(var_0.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var_0) || scripts\mp\riotshield::isriotshield(var_0.basename);
  return var_1;
}

function compareclassstructs(var_0, var_1) {
  if(var_0.loadoutarchetype != var_1.loadoutarchetype) {
    return false;
  }

  if(var_0.loadoutprimary != var_1.loadoutprimary) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutprimaryattachments, var_1.loadoutprimaryattachments)) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutprimaryattachmentids, var_1.loadoutprimaryattachmentids)) {
    return false;
  }

  if(var_0.loadoutprimarycamo != var_1.loadoutprimarycamo) {
    return false;
  }

  if(var_0.loadoutprimaryreticle != var_1.loadoutprimaryreticle) {
    return false;
  }

  if(var_0.loadoutprimarylootitemid != var_1.loadoutprimarylootitemid) {
    return false;
  }

  if(var_0.loadoutprimaryvariantid != var_1.loadoutprimaryvariantid) {
    return false;
  }

  if(var_0.loadoutprimarycosmeticattachment != var_1.loadoutprimarycosmeticattachment) {
    return false;
  }

  if(var_0.loadoutsecondary != var_1.loadoutsecondary) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutsecondaryattachments, var_1.loadoutsecondaryattachments)) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutsecondaryattachmentids, var_1.loadoutsecondaryattachmentids)) {
    return false;
  }

  if(var_0.loadoutsecondarycamo != var_1.loadoutsecondarycamo) {
    return false;
  }

  if(var_0.loadoutsecondaryreticle != var_1.loadoutsecondaryreticle) {
    return false;
  }

  if(var_0.loadoutsecondarylootitemid != var_1.loadoutsecondarylootitemid) {
    return false;
  }

  if(var_0.loadoutsecondaryvariantid != var_1.loadoutsecondaryvariantid) {
    return false;
  }

  if(var_0.loadoutsecondarycosmeticattachment != var_1.loadoutsecondarycosmeticattachment) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutperks, var_1.loadoutperks)) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutstandardperks, var_1.loadoutstandardperks)) {
    return false;
  }

  if(!checkclassstructarray(var_0.loadoutextraperks, var_1.loadoutextraperks)) {
    return false;
  }

  if(var_0.loadoutusingspecialist != var_1.loadoutusingspecialist) {
    return false;
  }

  if(var_0.loadoutmeleeslot != var_1.loadoutmeleeslot) {
    return false;
  }

  if(var_0.loadoutperksfromgamemode != var_1.loadoutperksfromgamemode) {
    return false;
  }

  if(var_0.loadoutrigtrait != var_1.loadoutrigtrait) {
    return false;
  }

  if(var_0.loadoutequipmentprimary != var_1.loadoutequipmentprimary) {
    return false;
  }

  if(var_0.loadoutextraequipmentprimary != var_1.loadoutextraequipmentprimary) {
    return false;
  }

  if(var_0.loadoutequipmentsecondary != var_1.loadoutequipmentsecondary) {
    return false;
  }

  if(var_0.loadoutextraequipmentsecondary != var_1.loadoutextraequipmentsecondary) {
    return false;
  }

  if(var_0.loadoutsuper != var_1.loadoutsuper) {
    return false;
  }

  if(var_0.loadoutgesture != var_1.loadoutgesture) {
    return false;
  }

  if(var_0.loadoutstreaksfilled != var_1.loadoutstreaksfilled) {
    return false;
  }

  if(var_0.loadoutstreaktype != var_1.loadoutstreaktype) {
    return false;
  }

  if(var_0.loadoutkillstreak1 != var_1.loadoutkillstreak1) {
    return false;
  }

  if(var_0.loadoutkillstreak2 != var_1.loadoutkillstreak2) {
    return false;
  }

  if(var_0.loadoutkillstreak3 != var_1.loadoutkillstreak3) {
    return false;
  }

  return true;
}

function checkclassstructarray(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_1[var_4])) {
      return false;
    }

    if(var_1[var_4] != var_3) {
      return false;
    }
  }

  return true;
}

function computerrebootsequence_init() {
  scripts\engine\utility::ent_flag_init("swapLoadout_blocked");
  scripts\engine\utility::ent_flag_init("swapLoadout_pending");
  scripts\engine\utility::ent_flag_init("swapLoadout_complete");
  scripts\engine\utility::ent_flag_set("swapLoadout_blocked");
}

function ref_13f02() {
  if(scripts\engine\utility::ent_flag_exist("swapLoadout_blocked") && scripts\engine\utility::ent_flag("swapLoadout_blocked")) {
    scripts\engine\utility::ent_flag_clear("swapLoadout_blocked");
    return;
  }
}

function zvelscale(var_0) {
  var_0.loadoutprimaryobject = var_0.loadoutprimary;

  if(issameweapon(var_0.loadoutprimary)) {
    var_0.loadoutprimaryfullname = createheadicon(var_0.loadoutprimaryobject);
  }

  if(var_0.loadoutsecondary == "none") {
    var_0.loadoutsecondaryfullname = "none";
    var_0.loadoutsecondaryobject = undefined;
  } else {
    if(istrue(var_0.ref_11961)) {
      var_0.loadoutsecondaryobject = fixsuperforbr(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));
    } else {
      var_0.loadoutsecondaryobject = buildweapon(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));
    }

    var_0.loadoutsecondaryfullname = createheadicon(var_0.loadoutsecondaryobject);
  }

  if(var_0.loadoutmeleeslot != "none") {
    self giveweapon(var_0.loadoutmeleeslot);
    self assignweaponmeleeslot(var_0.loadoutmeleeslot);
    return;
  }
}