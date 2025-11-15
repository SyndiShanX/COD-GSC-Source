/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\weapon_utils.gsc
***********************************************/

#namespace weapon_utils;

ispistol(weapon) {
  return isDefined(level.side_arm_array[weapon]);
}

isflashorstunweapon(weapon) {
  return weapon.isflash || weapon.isstun;
}

isflashorstundamage(weapon, meansofdeath) {
  return isflashorstunweapon(weapon) && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS");
}

ismeleemod(mod) {
  return mod === "MOD_MELEE" || mod === "MOD_MELEE_WEAPON_BUTT" || mod === "MOD_MELEE_ASSASSINATE";
}

isexplosivedamage(meansofdeath) {
  switch (meansofdeath) {
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_projectile":
    case #"mod_grenade_splash":
    case #"mod_projectile_splash":
      return true;
  }

  return false;
}

ispunch(weapon) {
  return weapon.type == "melee" && weapon.statname == #"bare_hands";
}

isknife(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name == #"knife_loadout";
}

isnonbarehandsmelee(weapon) {
  return weapon.type == "melee" && weapon.rootweapon.name != #"bare_hands";
}

isbulletdamage(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

isfiredamage(weapon, meansofdeath) {
  if(weapon.doesfiredamage && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_DOT")) {
    return true;
  }

  return false;
}