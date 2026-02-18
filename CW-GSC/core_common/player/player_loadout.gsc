/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_loadout.gsc
*************************************************/

#using scripts\core_common\util_shared;
#namespace loadout;

function function_87bcb1b() {
  return level.var_d0e6b79d === 1;
}

function function_c67222df() {
  if(!isDefined(self.pers[# "loadout"])) {
    self.pers[# "loadout"] = spawnStruct();
  }

  self init_loadout_slot("primary");
  self init_loadout_slot("secondary");
  self init_loadout_slot("herogadget");
  self init_loadout_slot("ultimate");
  self init_loadout_slot("primarygrenade");
  self init_loadout_slot("secondarygrenade");
  self init_loadout_slot("specialgrenade");
}

function init_loadout_slot(slot_index) {
  self.pers[# "loadout"].slots[slot_index] = {
    #slot: slot_index, #weapon: level.weaponnone, #var_4cfdfa9b: level.weaponnone, #count: 0, #killed: 0
  };
}

function get_loadout_slot(slot_index) {
  if(isDefined(self.pers[# "loadout"])) {
    return self.pers[# "loadout"].slots[slot_index];
  }

  return undefined;
}

function function_8435f729(weapon) {
  if(isDefined(self.pers[# "loadout"])) {
    foreach(slot_index, slot in self.pers[# "loadout"].slots) {
      if(slot.weapon == weapon) {
        return slot_index;
      }
    }
  }

  return undefined;
}

function find_loadout_slot(weapon) {
  if(isDefined(self.pers[# "loadout"])) {
    foreach(slot in self.pers[# "loadout"].slots) {
      if(slot.weapon == weapon) {
        return slot;
      }
    }
  }

  return undefined;
}

function function_18a77b37(slot_index) {
  if(function_87bcb1b() && isDefined(self) && isDefined(self.pers) && isDefined(self.pers[# "loadout"])) {
    assert(isDefined(self.pers[# "loadout"].slots[slot_index]));
    return self.pers[# "loadout"].slots[slot_index].weapon;
  }

  return undefined;
}

function function_442539(slot_index, weapon) {
  assert(isDefined(self.pers[# "loadout"].slots[slot_index]));
  assert(isPlayer(self));
  assert(isDefined(weapon));
  self.pers[# "loadout"].slots[slot_index].weapon = weapon;
}

function gadget_is_in_use(slot_index) {
  player = self;
  weapon = function_18a77b37(slot_index);

  if(!isDefined(weapon)) {
    return 0;
  }

  slot = player gadgetgetslot(weapon);
  active = player util::gadget_is_in_use(slot);
  return active;
}