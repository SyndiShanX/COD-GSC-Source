/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_teamammorefill.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.killStreakFuncs["team_ammo_refill"] = ::tryUseTeamAmmoRefill;
}

tryUseTeamAmmoRefill(lifeId, modules) {
  result = self giveTeamAmmoRefill();
  if(result) {
    self maps\mp\_matchdata::logKillstreakEvent("team_ammo_refill", self.origin);
  }

  return (result);
}

giveTeamAmmoRefill() {
  if(level.teambased) {
    foreach(teammate in level.players) {
      if(teammate.team == self.team) {
        teammate refillAmmo(true);
      }
    }
  } else {
    self refillAmmo(true);
  }

  level thread teamPlayerCardSplash("used_team_ammo_refill", self);

  return true;
}

refillAmmo(refillEquipment) {
  weaponList = self GetWeaponsListAll();

  foreach(weaponName in weaponList) {
    if(isSubStr(weaponName, "grenade") || (GetSubStr(weaponName, 0, 2) == "gl")) {
      if(!refillEquipment || self getAmmoCount(weaponName) >= 1) {
        continue;
      }
    }

    self giveMaxAmmo(weaponName);
  }

  self playLocalSound("ammo_crate_use");
}