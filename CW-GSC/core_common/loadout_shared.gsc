/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\loadout_shared.gsc
***********************************************/

#namespace loadout;

function is_warlord_perk(itemindex) {
  return false;
}

function is_item_excluded(itemindex) {
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

function getloadoutitemfromddlstats(customclassnum, loadoutslot) {
  itemindex = self getloadoutitem(customclassnum, loadoutslot);

  if(is_item_excluded(itemindex) && !is_warlord_perk(itemindex)) {
    return 0;
  }

  return itemindex;
}

function initweaponattachments(weapon) {
  self.currentweaponstarttime = gettime();
  self.currentweapon = weapon;
}

function isprimarydamage(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

function cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
  if(!isDefined(attacker) || !isDefined(damage) || !isPlayer(damage)) {
    return meansofdeath;
  }

  if(!isDefined(meansofdeath) || !isDefined(weapon) || !isDefined(inflictor)) {
    return meansofdeath;
  }

  old_damage = meansofdeath;
  final_damage = meansofdeath;

  if(damage hasperk(#"specialty_bulletdamage") && isprimarydamage(weapon) && isDefined(level.cac_bulletdamage_data)) {
    final_damage = meansofdeath * (100 + level.cac_bulletdamage_data) / 100;

    if(getdvarint(#"scr_perkdebug", 0)) {
      println("<dev string:x38>" + damage.name + "<dev string:x43>");
    }
  } else {
    final_damage = old_damage;
  }

  if(getdvarint(#"scr_perkdebug", 0)) {
    println("<dev string:x73>" + final_damage / old_damage + "<dev string:x8d>" + old_damage + "<dev string:xa0>" + final_damage);
  }

  return int(final_damage);
}

function function_3ba6ee5d(weapon, amount) {
  if(!self hasweapon(weapon)) {
    assertmsg("<dev string:xb4>" + weapon.name + "<dev string:xcf>");
    return;
  }

  if(weapon.iscliponly) {
    self setweaponammoclip(weapon, amount);
    return;
  }

  self setweaponammoclip(weapon, amount);
  diff = amount - self getweaponammoclip(weapon);
  assert(diff >= 0);
  self setweaponammostock(weapon, diff);
}