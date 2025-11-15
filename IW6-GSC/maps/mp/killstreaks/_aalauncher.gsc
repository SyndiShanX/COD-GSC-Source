/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_aalauncher.gsc
***********************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_AA_LAUNCHER_WEAPON = "iw6_maaws_mp";
CONST_AA_LAUNCHER_WEAPON_CHILD = "iw6_maawschild_mp";
CONST_AA_LAUNCHER_WEAPON_HOMING = "iw6_maawshoming_mp";
CONST_AA_LAUNCHER_WEAPON_AMMO = 2;

init() {
  level.killstreakFuncs["aa_launcher"] = ::tryUseAALauncher;
  maps\mp\_laserGuidedLauncher::LGM_init("vfx/gameplay/mp/killstreaks/vfx_maaws_split", "vfx/gameplay/mp/killstreaks/vfx_maaws_homing");
}

getAALauncherName() {
  return CONST_AA_LAUNCHER_WEAPON;
}

getAALauncherChildName() {
  return CONST_AA_LAUNCHER_WEAPON_CHILD;
}

getAALauncherHomingName() {
  return CONST_AA_LAUNCHER_WEAPON_HOMING;
}

getAALauncherAmmo(player) {
  AssertEx(isDefined(player.pers["aaLauncherAmmo"]), "getAALauncherAmmo() called on player with no \"aaLauncherAmmo\" array key.");

  ksUniqueID = getAALauncherUniqueIndex(player);
  ammo = 0;
  if(isDefined(player.pers["aaLauncherAmmo"][ksUniqueID])) {
    ammo = player.pers["aaLauncherAmmo"][ksUniqueID];
  }
  return ammo;
}

clearAALauncherAmmo(player) {
  ksUniqueID = getAALauncherUniqueIndex(player);
  player.pers["aaLauncherAmmo"][ksUniqueID] = undefined;
}

setAALauncherAmmo(player, ammo, setAmmo) {
  AssertEx(isDefined(player.pers["aaLauncherAmmo"]), "setAALauncherAmmo() called on player with no \"aaLauncherAmmo\" array key.");

  ksUniqueID = getAALauncherUniqueIndex(player);
  player.pers["aaLauncherAmmo"][ksUniqueID] = ammo;

  if(!isDefined(setAmmo) || setAmmo) {
    if(player HasWeapon(getAALauncherName())) {
      player SetWeaponAmmoClip(getAALauncherName(), ammo);
    }
  }
}

getAALauncherUniqueIndex(player) {
  AssertEx(isDefined(player.killstreakIndexWeapon), "getAALauncherAmmo() called on player with no killstreakIndexWeapon field");

  return player.pers["killstreaks"][player.killstreakIndexWeapon].kID;
}

tryUseAALauncher(lifeId, streakName) {
  return useAALauncher(self, lifeId);
}

useAALauncher(player, lifeId) {
  if(!isDefined(self.pers["aaLauncherAmmo"])) {
    self.pers["aaLauncherAmmo"] = [];
  }

  if(getAALauncherAmmo(player) == 0) {
    setAALauncherAmmo(self, CONST_AA_LAUNCHER_WEAPON_AMMO, false);
  }

  level thread monitorWeaponSwitch(player);
  level thread monitorLauncherAmmo(player);

  self thread maps\mp\_laserGuidedLauncher::LGM_firing_monitorMissileFire(getAALauncherName(), getAALauncherChildName(), getAALauncherHomingName());

  result = false;
  msg = player waittill_any_return("aa_launcher_switch", "aa_launcher_empty", "death", "disconnect");

  if(msg == "aa_launcher_empty") {
    player waittill_any("weapon_change", "LGM_player_allMissilesDestroyed", "death", "disconnect");
    result = true;
  } else {
    if(player HasWeapon(getAALauncherName()) && player GetAmmoCount(getAALauncherName()) == 0) {
      clearAALauncherAmmo(player);
    }

    if(getAALauncherAmmo(player) == 0) {
      result = true;
    }
  }

  player notify("aa_launcher_end");

  self maps\mp\_laserGuidedLauncher::LGM_firing_endMissileFire();

  return result;
}

monitorWeaponSwitch(player) {
  player endon("death");
  player endon("disconnect");
  player endon("aa_launcher_empty");
  player endon("aa_launcher_end");

  currentWeapon = player GetCurrentWeapon();

  while(currentWeapon == getAALauncherName()) {
    player waittill("weapon_change", currentWeapon);
  }

  player notify("aa_launcher_switch");
}

monitorLauncherAmmo(player) {
  player endon("death");
  player endon("disconnect");
  player endon("aa_launcher_switch");
  player endon("aa_launcher_end");

  setAALauncherAmmo(player, getAALauncherAmmo(player), true);

  while(true) {
    player waittill("weapon_fired", weaponName);

    if(weaponName != getAALauncherName()) {
      continue;
    }
    ammo = player GetAmmoCount(getAALauncherName());
    setAALauncherAmmo(player, ammo, false);

    if(getAALauncherAmmo(player) == 0) {
      clearAALauncherAmmo(player);
      player notify("aa_launcher_empty");
      break;
    }
  }
}