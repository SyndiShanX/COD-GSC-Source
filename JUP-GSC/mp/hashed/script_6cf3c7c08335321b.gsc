/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6cf3c7c08335321b.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#namespace loadout_locker;

function function_907a472bb2ab01e() {
  level.var_c1154388bad688d8 = [];
}

function function_aea2aa66a0043475() {
  playerentnum = self getentitynumber();

  if(!isDefined(level.var_c1154388bad688d8[playerentnum])) {
    level.var_c1154388bad688d8[playerentnum] = spawnStruct();
  }

  function_fd0efa5a567ad260(playerentnum);
  function_870ae5df493cb4ad(playerentnum);
  level.var_c1154388bad688d8[playerentnum].perks = [];
  level.var_c1154388bad688d8[playerentnum].perks = self.loadoutperks;
}

function function_fd0efa5a567ad260(playerentnum) {
  level.var_c1154388bad688d8[playerentnum].weapons = [];

  for(weaponid = 0; weaponid < self.primaryweapons.size; weaponid++) {
    level.var_c1154388bad688d8[playerentnum].weapons[weaponid] = spawnStruct();
    level.var_c1154388bad688d8[playerentnum].weapons[weaponid].weapon = self.primaryweapons[weaponid];
    level.var_c1154388bad688d8[playerentnum].weapons[weaponid].ammostock = self getweaponammostock(self.primaryweapons[weaponid]);
    level.var_c1154388bad688d8[playerentnum].weapons[weaponid].ammoclip = self getweaponammoclip(self.primaryweapons[weaponid]);
  }

  level.var_c1154388bad688d8[playerentnum].currentweapon = self.currentweapon;
}

function function_870ae5df493cb4ad(playerentnum) {
  level.var_c1154388bad688d8[playerentnum].equipment = [];

  if(isDefined(self.equipment["primary"])) {
    level.var_c1154388bad688d8[playerentnum].equipment["primary"] = spawnStruct();
    level.var_c1154388bad688d8[playerentnum].equipment["primary"].equipment = self.equipment["primary"];
    level.var_c1154388bad688d8[playerentnum].equipment["primary"].ammo = getequipmentammo(self.equipment["primary"]);
  }

  if(isDefined(self.equipment["secondary"])) {
    level.var_c1154388bad688d8[playerentnum].equipment["secondary"] = spawnStruct();
    level.var_c1154388bad688d8[playerentnum].equipment["secondary"].equipment = self.equipment["secondary"];
    level.var_c1154388bad688d8[playerentnum].equipment["secondary"].ammo = getequipmentammo(self.equipment["secondary"]);
  }
}

function restoreplayerloadout() {
  playerentnum = self getentitynumber();

  if(!isDefined(level.var_c1154388bad688d8[playerentnum])) {
    assertmsg("<dev string:x1c>");
    return;
  }

  function_b1aab57e7ea64c45(playerentnum);
  function_6ef8e341d1ca3ef8(playerentnum);
  scripts\mp\class::loadout_clearperks();

  foreach(perk in level.var_c1154388bad688d8[playerentnum].perks) {
    scripts\mp\class::loadout_giveperk(perk);
  }
}

function function_b1aab57e7ea64c45(playerentnum) {
  self takeallweapons();

  foreach(weaponstruct in level.var_c1154388bad688d8[playerentnum].weapons) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponstruct.weapon, undefined, undefined, 1);
    self setweaponammostock(weaponstruct.weapon, weaponstruct.ammostock);
    self setweaponammoclip(weaponstruct.weapon, weaponstruct.ammoclip);
  }

  currentweapon = level.var_c1154388bad688d8[playerentnum].currentweapon;

  if(isDefined(currentweapon)) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(currentweapon);
  }
}

function function_6ef8e341d1ca3ef8(playerentnum) {
  clearallequipment();
  equipmentstruct = level.var_c1154388bad688d8[playerentnum].equipment["primary"];

  if(isDefined(equipmentstruct)) {
    scripts\cp_mp\equipment::giveequipment(equipmentstruct.equipment, "primary");
    scripts\cp_mp\equipment::setequipmentammo(equipmentstruct.equipment, equipmentstruct.ammo);
  }

  equipmentstruct = level.var_c1154388bad688d8[playerentnum].equipment["secondary"];

  if(isDefined(equipmentstruct)) {
    scripts\cp_mp\equipment::giveequipment(equipmentstruct.equipment, "secondary");
    scripts\cp_mp\equipment::setequipmentammo(equipmentstruct.equipment, equipmentstruct.ammo);
  }
}

function function_76e32a123417cd84(newloadout) {
  if(isDefined(newloadout)) {
    self.pers["gamemodeLoadout"] = newloadout;
    self.class = "gamemode";
    self.prevweaponobj = undefined;
    struct = scripts\mp\class::loadout_getclassstruct();
    struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
    scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
    scripts\mp\class::giveloadout(self.team, "gamemode", 0, 0);
    self givestartammo(struct.loadoutprimaryobject);
    self givestartammo(struct.loadoutsecondaryobject);
    self notify("ammo_update");
  }
}

function function_32d0db3e4198e55d(scriptbundleloadout) {
  loadout = [];
  loadout["loadoutArchetype"] = scriptbundleloadout.role;
  loadout["loadoutPrimary"] = scriptbundleloadout.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = scriptbundleloadout.primaryweapon.attachment1;
  loadout["loadoutPrimaryAttachment2"] = scriptbundleloadout.primaryweapon.attachment2;
  loadout["loadoutPrimaryCamo"] = scriptbundleloadout.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = scriptbundleloadout.primaryweapon.reticle;
  loadout["loadoutSecondary"] = scriptbundleloadout.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = scriptbundleloadout.secondaryweapon.attachment1;
  loadout["loadoutSecondaryAttachment2"] = scriptbundleloadout.secondaryweapon.attachment2;
  loadout["loadoutSecondaryCamo"] = scriptbundleloadout.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = scriptbundleloadout.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = scriptbundleloadout.meleeslot;
  loadout["loadoutEquipmentPrimary"] = scriptbundleloadout.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = scriptbundleloadout.equipment.secondary;
  loadout["loadoutKillstreak1"] = scriptbundleloadout.killstreaks.killstreak1;
  loadout["loadoutKillstreak2"] = scriptbundleloadout.killstreaks.killstreak2;
  loadout["loadoutKillstreak3"] = scriptbundleloadout.killstreaks.killstreak3;
  loadout["loadoutSuper"] = scriptbundleloadout.super;
  loadout["loadoutPerks"] = [scriptbundleloadout.perks.perk1, scriptbundleloadout.perks.perk2, scriptbundleloadout.perks.perk3];
  loadout["loadoutGesture"] = scriptbundleloadout.gesture;
  loadout["loadoutFieldUpgrade1"] = scriptbundleloadout.fieldupgrades.fieldupgrade1;
  loadout["loadoutFieldUpgrade2"] = scriptbundleloadout.fieldupgrades.fieldupgrade2;
  return loadout;
}