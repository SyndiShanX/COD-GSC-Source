/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_loadout.gsc
*************************************************/

#include scripts\core_common\util_shared;

#namespace loadout;

function_87bcb1b() {
  if(isDefined(level.var_87bcb1b) && level.var_87bcb1b == 0) {
    return false;
  }

  return true;
}

function_c67222df() {
  if(!isDefined(self.pers[#"loadout"])) {
    self.pers[#"loadout"] = spawnStruct();
  }

  self init_loadout_slot("primary");
  self init_loadout_slot("secondary");
  self init_loadout_slot("herogadget");
  self init_loadout_slot("ultimate");
  self init_loadout_slot("primarygrenade");
  self init_loadout_slot("specialgrenade");
}

init_loadout_slot(slot_index) {
  self.pers[#"loadout"].slots[slot_index] = {
    #slot: slot_index, 
    #weapon: level.weaponnone, 
    #var_4cfdfa9b: level.weaponnone, 
    #count: 0, 
    #killed: 0
  };
}

get_loadout_slot(slot_index) {
  if(isDefined(self.pers[#"loadout"])) {
    return self.pers[#"loadout"].slots[slot_index];
  }

  return undefined;
}

function_8435f729(weapon) {
  foreach(slot, slot_index in self.pers[#"loadout"].slots) {
    if(slot.weapon == weapon) {
      return slot_index;
    }
  }

  return undefined;
}

find_loadout_slot(weapon) {
  if(isDefined(self.pers[#"loadout"])) {
    foreach(slot in self.pers[#"loadout"].slots) {
      if(slot.weapon == weapon) {
        return slot;
      }
    }
  }

  return undefined;
}

function_18a77b37(slot_index) {
  if(function_87bcb1b() && isDefined(self) && isDefined(self.pers) && isDefined(self.pers[#"loadout"])) {
    assert(isDefined(self.pers[#"loadout"].slots[slot_index]));
    return self.pers[#"loadout"].slots[slot_index].weapon;
  }

  return undefined;
}

function_442539(slot_index, weapon) {
  assert(isDefined(self.pers[#"loadout"].slots[slot_index]));
  assert(isplayer(self));
  assert(isDefined(weapon));
  self.pers[#"loadout"].slots[slot_index].weapon = weapon;
}

gadget_is_in_use(slot_index) {
  player = self;
  weapon = function_18a77b37(slot_index);

  if(!isDefined(weapon)) {
    return 0;
  }

  slot = player gadgetgetslot(weapon);
  active = player util::gadget_is_in_use(slot);
  return active;
}