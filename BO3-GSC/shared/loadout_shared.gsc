/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\loadout_shared.gsc
*************************************************/

#namespace loadout;

function is_warlord_perk(itemindex) {
  return false;
}

function is_item_excluded(itemindex) {
  if(!level.onlinegame) {
    return false;
  }
  numexclusions = level.itemexclusions.size;
  for (exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
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