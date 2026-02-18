/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\weapon_utils.gsc
***********************************************/

#namespace weapons;

function ispistol(weapon, var_d3511cd9 = 0) {
  if(var_d3511cd9) {
    return (weapon.weapclass === # "pistol");
  }

  return isDefined(level.side_arm_array[weapon]);
}

function islauncher(weapon) {
  return weapon.weapclass == "rocketlauncher";
}

function isflashorstunweapon(weapon) {
  return weapon.isflash || weapon.isstun;
}

function isflashorstundamage(weapon, meansofdeath) {
  return isflashorstunweapon(weapon) && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS");
}

function ismeleemod(mod) {
  return mod === "MOD_MELEE" || mod === "MOD_MELEE_WEAPON_BUTT" || mod === "MOD_MELEE_ASSASSINATE";
}

function isexplosivedamage(meansofdeath) {
  switch (meansofdeath) {
    case # "mod_explosive":
    case # "mod_grenade":
    case # "mod_projectile":
    case # "mod_grenade_splash":
    case # "mod_projectile_splash":
      return true;
  }

  return false;
}

function ispunch(weapon) {
  return weapon.type == "melee" && weapon.statname == # "bare_hands";
}

function isknife(weapon) {
  return weapon.type == "melee" && (weapon.rootweapon.name == # "knife_loadout" || weapon.rootweapon.name == # "knife_held");
}

function isnonbarehandsmelee(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name != # "bare_hands";
}

function isbulletdamage(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

function isfiredamage(weapon, meansofdeath) {
  if(weapon.doesfiredamage && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_DOT")) {
    return true;
  }

  return false;
}

function function_a9a8aed8(primaryoffhand) {
  if(primaryoffhand.gadget_type == 0) {
    if(!self hasweapon(level.var_34d27b26)) {
      self giveweapon(level.var_34d27b26);
    }

    return;
  }

  if(self hasweapon(level.var_34d27b26)) {
    self takeweapon(level.var_34d27b26);
  }
}

function isheadshot(weapon, shitloc, smeansofdeath) {
  if(weapon.noheadshots) {
    return false;
  }

  if(ismeleemod(smeansofdeath)) {
    return false;
  }

  if(isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet")) {
    return true;
  }

  return false;
}