/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#namespace weapons;

function is_primary_weapon(weapon) {
  root_weapon = weapon.rootweapon;
  return root_weapon != level.weaponnone && isDefined(level.primary_weapon_array[root_weapon]);
}

function is_side_arm(weapon) {
  root_weapon = weapon.rootweapon;
  return root_weapon != level.weaponnone && isDefined(level.side_arm_array[root_weapon]);
}

function is_inventory(weapon) {
  root_weapon = weapon.rootweapon;
  return root_weapon != level.weaponnone && isDefined(level.inventory_array[root_weapon]);
}

function is_grenade(weapon) {
  root_weapon = weapon.rootweapon;
  return root_weapon != level.weaponnone && isDefined(level.grenade_array[root_weapon]);
}

function force_stowed_weapon_update() {
  detach_all_weapons();
  stow_on_back();
  stow_on_hip();
}

function detach_carry_object_model() {
  if(isDefined(self.carryobject) && isDefined(self.carryobject gameobjects::get_visible_carrier_model())) {
    if(isDefined(self.tag_stowed_back)) {
      self detach(self.tag_stowed_back, "tag_stowed_back");
      self.tag_stowed_back = undefined;
    }
  }
}

function detach_all_weapons() {
  if(isDefined(self.tag_stowed_back)) {
    clear_weapon = 1;
    if(isDefined(self.carryobject)) {
      carriermodel = self.carryobject gameobjects::get_visible_carrier_model();
      if(isDefined(carriermodel) && carriermodel == self.tag_stowed_back) {
        self detach(self.tag_stowed_back, "tag_stowed_back");
        clear_weapon = 0;
      }
    }
    if(clear_weapon) {
      self clearstowedweapon();
    }
    self.tag_stowed_back = undefined;
  } else {
    self clearstowedweapon();
  }
  if(isDefined(self.tag_stowed_hip)) {
    detach_model = self.tag_stowed_hip.worldmodel;
    self detach(detach_model, "tag_stowed_hip_rear");
    self.tag_stowed_hip = undefined;
  }
}

function stow_on_back(current) {
  currentweapon = self getcurrentweapon();
  currentaltweapon = currentweapon.altweapon;
  self.tag_stowed_back = undefined;
  weaponoptions = 0;
  index_weapon = level.weaponnone;
  if(isDefined(self.carryobject) && isDefined(self.carryobject gameobjects::get_visible_carrier_model())) {
    self.tag_stowed_back = self.carryobject gameobjects::get_visible_carrier_model();
    self attach(self.tag_stowed_back, "tag_stowed_back", 1);
    return;
  }
  if(currentweapon != level.weaponnone) {
    for(idx = 0; idx < self.weapon_array_primary.size; idx++) {
      temp_index_weapon = self.weapon_array_primary[idx];
      assert(isDefined(temp_index_weapon), "");
      if(temp_index_weapon == currentweapon) {
        continue;
      }
      if(temp_index_weapon == currentaltweapon) {
        continue;
      }
      if(temp_index_weapon.nonstowedweapon) {
        continue;
      }
      index_weapon = temp_index_weapon;
    }
  }
  self setstowedweapon(index_weapon);
}

function stow_on_hip() {
  currentweapon = self getcurrentweapon();
  self.tag_stowed_hip = undefined;
  for(idx = 0; idx < self.weapon_array_inventory.size; idx++) {
    if(self.weapon_array_inventory[idx] == currentweapon) {
      continue;
    }
    if(!self getweaponammostock(self.weapon_array_inventory[idx])) {
      continue;
    }
    self.tag_stowed_hip = self.weapon_array_inventory[idx];
  }
  if(!isDefined(self.tag_stowed_hip)) {
    return;
  }
  self attach(self.tag_stowed_hip.worldmodel, "tag_stowed_hip_rear", 1);
}

function weapondamagetracepassed(from, to, startradius, ignore) {
  trace = weapondamagetrace(from, to, startradius, ignore);
  return trace["fraction"] == 1;
}

function weapondamagetrace(from, to, startradius, ignore) {
  midpos = undefined;
  diff = to - from;
  if(lengthsquared(diff) < (startradius * startradius)) {
    midpos = to;
  }
  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
  trace = bulletTrace(midpos, to, 0, ignore);
  if(getdvarint("scr_damage_debug") != 0) {
    if(trace["fraction"] == 1) {
      thread debugline(midpos, to, (1, 1, 1));
    } else {
      thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
      thread debugline(trace["position"], to, (1, 0.4, 0.3));
    }
  }
  return trace;
}

function has_lmg() {
  weapon = self getcurrentweapon();
  return weapon.weapclass == "mg";
}

function has_launcher() {
  weapon = self getcurrentweapon();
  return weapon.isrocketlauncher;
}

function has_hero_weapon() {
  weapon = self getcurrentweapon();
  return weapon.gadget_type == 14;
}

function has_lockon(target) {
  player = self;
  clientnum = player getentitynumber();
  return isDefined(target.locked_on) && target.locked_on & (1 << clientnum);
}