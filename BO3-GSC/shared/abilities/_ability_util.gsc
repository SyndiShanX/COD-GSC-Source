/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\_ability_util.gsc
*************************************************/

#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\util_shared;
#namespace ability_util;

function gadget_is_type(slot, type) {
  if(!isdefined(self._gadgets_player[slot])) {
    return 0;
  }
  return self._gadgets_player[slot].gadget_type == type;
}

function gadget_slot_for_type(type) {
  invalid = 3;
  for (i = 0; i < 3; i++) {
    if(!self gadget_is_type(i, type)) {
      continue;
    }
    return i;
  }
  return invalid;
}

function gadget_is_camo_suit_on() {
  return gadget_is_active(2);
}

function gadget_combat_efficiency_enabled() {
  if(isdefined(self._gadget_combat_efficiency)) {
    return self._gadget_combat_efficiency;
  }
  return 0;
}

function gadget_combat_efficiency_power_drain(score) {
  powerchange = -1 * score * getdvarfloat("scr_combat_efficiency_power_loss_scalar", 0.275);
  slot = gadget_slot_for_type(15);
  if(slot != 3) {
    self gadgetpowerchange(slot, powerchange);
  }
}

function gadget_is_camo_suit_flickering() {
  slot = self gadget_slot_for_type(2);
  if(slot >= 0 && slot < 3) {
    if(self ability_player::gadget_is_flickering(slot)) {
      return true;
    }
  }
  return false;
}

function gadget_is_escort_drone_on() {
  return gadget_is_active(5);
}

function is_weapon_gadget(weapon) {
  foreach(gadget_key, gadget_val in level._gadgets_level) {
    if(gadget_key == weapon) {
      return true;
    }
  }
  return false;
}

function gadget_power_reset(gadgetweapon) {
  slot = self gadgetgetslot(gadgetweapon);
  if(slot >= 0 && slot < 3) {
    self gadgetpowerreset(slot);
    self gadgetcharging(slot, 1);
  }
}

function gadget_reset(gadgetweapon, changedclass, roundbased, firstround) {
  if(getdvarint("gadgetEnabled") == 0) {
    return;
  }
  slot = self gadgetgetslot(gadgetweapon);
  if(slot >= 0 && slot < 3) {
    if(isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers["held_gadgets_power"][gadgetweapon])) {
      self gadgetpowerset(slot, self.pers["held_gadgets_power"][gadgetweapon]);
    } else {
      if(isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[# "hash_c35f137f"]) && isdefined(self.pers["held_gadgets_power"][self.pers[# "hash_c35f137f"]])) {
        self gadgetpowerset(slot, self.pers["held_gadgets_power"][self.pers[# "hash_c35f137f"]]);
      } else if(isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[# "hash_65987563"]) && isdefined(self.pers["held_gadgets_power"][self.pers[# "hash_65987563"]])) {
        self gadgetpowerset(slot, self.pers["held_gadgets_power"][self.pers[# "hash_65987563"]]);
      }
    }
    resetonclasschange = changedclass && gadgetweapon.gadget_power_reset_on_class_change;
    resetonfirstround = !isdefined(self.firstspawn) && (!roundbased || firstround);
    resetonroundswitch = !isdefined(self.firstspawn) && roundbased && !firstround && gadgetweapon.gadget_power_reset_on_round_switch;
    resetonteamchanged = isdefined(self.firstspawn) && (isdefined(self.switchedteamsresetgadgets) && self.switchedteamsresetgadgets) && gadgetweapon.gadget_power_reset_on_team_change;
    if(resetonclasschange || resetonfirstround || resetonroundswitch || resetonteamchanged) {
      self gadgetpowerreset(slot);
      self gadgetcharging(slot, 1);
    }
  }
}

function gadget_power_armor_on() {
  return gadget_is_active(4);
}

function gadget_is_active(gadgettype) {
  slot = self gadget_slot_for_type(gadgettype);
  if(slot >= 0 && slot < 3) {
    if(self ability_player::gadget_is_in_use(slot)) {
      return true;
    }
  }
  return false;
}

function gadget_has_type(gadgettype) {
  slot = self gadget_slot_for_type(gadgettype);
  if(slot >= 0 && slot < 3) {
    return true;
  }
  return false;
}