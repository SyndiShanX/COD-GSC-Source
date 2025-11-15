/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\loadout_shared.gsc
***********************************************/

#namespace loadout;

is_warlord_perk(itemindex) {
  return false;
}

is_item_excluded(itemindex) {
  if(!level.onlinegame) {
    return false;
  }

  numexclusions = level.itemexclusions.size;

  for(exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
    if(itemindex == level.itemexclusions[exclusionindex]) {
      return true;
    }
  }

  return false;
}

getloadoutitemfromddlstats(customclassnum, loadoutslot) {
  itemindex = self getloadoutitem(customclassnum, loadoutslot);

  if(is_item_excluded(itemindex) && !is_warlord_perk(itemindex)) {
    return 0;
  }

  return itemindex;
}

initweaponattachments(weapon) {
  self.currentweaponstarttime = gettime();
  self.currentweapon = weapon;
}

isprimarydamage(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
  if(!isDefined(victim) || !isDefined(attacker) || !isplayer(attacker)) {
    return damage;
  }

  if(!isDefined(damage) || !isDefined(meansofdeath) || !isDefined(weapon)) {
    return damage;
  }

  old_damage = damage;
  final_damage = damage;

  if(attacker hasperk(#"specialty_bulletdamage") && isprimarydamage(meansofdeath)) {
    final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;

    if(getdvarint(#"scr_perkdebug", 0)) {
      println("<dev string:x38>" + attacker.name + "<dev string:x42>");
    }

  } else {
    final_damage = old_damage;
  }

  if(getdvarint(#"scr_perkdebug", 0)) {
    println("<dev string:x71>" + final_damage / old_damage + "<dev string:x8a>" + old_damage + "<dev string:x9c>" + final_damage);
  }

  return int(final_damage);
}

function_3ba6ee5d(weapon, amount) {
  if(weapon.iscliponly) {
    self setweaponammoclip(weapon, amount);
    return;
  }

  self setweaponammoclip(weapon, amount);
  diff = amount - self getweaponammoclip(weapon);
  assert(diff >= 0);
  self setweaponammostock(weapon, diff);
}