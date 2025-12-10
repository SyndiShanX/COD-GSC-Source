/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_pickup_items.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_weaponobjects;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\shared\weapons\_weapons;
#namespace pickup_items;

function autoexec __init__sytem__() {
  system::register("pickup_items", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&start_gametype);
  level.nullprimaryoffhand = getweapon("null_offhand_primary");
  level.nullsecondaryoffhand = getweapon("null_offhand_secondary");
  level.pickup_items = [];
  level.pickupitemrespawn = 1;
}

function on_player_spawned() {
  self.pickup_damage_scale = undefined;
  self.pickup_damage_scale_time = undefined;
}

function start_gametype() {
  callback::on_spawned(&on_player_spawned);
  pickup_triggers = getEntArray("pickup_item", "targetname");
  pickup_models = getEntArray("pickup_model", "targetname");
  visuals = [];
  foreach(trigger in pickup_triggers) {
    visuals[0] = get_visual_for_trigger(trigger, pickup_models);
    assert(isDefined(visuals[0]));
    visuals[0] pickup_item_init();
    pickup_item_object = gameobjects::create_use_object("neutral", trigger, visuals, vectorscale((0, 0, 1), 32), istring("pickup_item"));
    pickup_item_object gameobjects::allow_use("any");
    pickup_item_object gameobjects::set_use_time(0);
    pickup_item_object.onuse = &on_touch;
    level.pickup_items[level.pickup_items.size] = pickup_item_object;
  }
}

function get_visual_for_trigger(trigger, pickup_models) {
  foreach(model in pickup_models) {
    if(model istouchingswept(trigger)) {
      return model;
    }
  }
  return undefined;
}

function set_pickup_bobbing() {
  self bobbing((0, 0, 1), 4, 1);
}

function set_pickup_rotation() {
  self rotate(vectorscale((0, 1, 0), 175));
}

function get_item_for_pickup() {
  if(self.items.size == 1) {
    return self.items[0];
  }
  if(self.items_shuffle.size == 0) {
    self.items_shuffle = arraycopy(self.items);
    array::randomize(self.items_shuffle);
  }
  return array::pop_front(self.items_shuffle);
}

function cycle_item() {
  self.current_item = self get_item_for_pickup();
  if(isDefined(self.current_item.model)) {
    self setModel(self.current_item.model);
  }
}

function get_item_from_string_ammo(perks_string) {
  item_struct = spawnStruct();
  item_struct.name = "ammo";
  item_struct.weapon = getweapon("scavenger_item");
  item_struct.model = item_struct.weapon.worldmodel;
  self.angles = vectorscale((0, 0, 1), 90);
  self thread weapons::scavenger_think();
  return item_struct;
}

function get_item_from_string_damage(perks_string) {
  item_struct = spawnStruct();
  item_struct.name = "damage";
  item_struct.damage_scale = float(perks_string);
  item_struct.model = "wpn_t7_igc_bullet_prop";
  self.angles = vectorscale((-1, 0, 0), 45);
  self setscale(2);
  return item_struct;
}

function get_item_from_string_health(perks_string) {
  item_struct = spawnStruct();
  item_struct.name = "health";
  item_struct.extra_health = int(perks_string);
  item_struct.model = "p7_medical_surgical_tools_syringe";
  self.angles = vectorscale((-1, 0, 1), 45);
  self setscale(5);
  return item_struct;
}

function get_item_from_string_perk(perks_string) {
  item_struct = spawnStruct();
  if(!isDefined(level.perkspecialties[perks_string])) {
    util::error((("" + perks_string) + "") + self.origin);
    return;
  }
  item_struct.name = perks_string;
  item_struct.specialties = strtok(level.perkspecialties[perks_string], "|");
  item_struct.model = "p7_perk_" + level.perkicons[perks_string];
  self setscale(2);
  return item_struct;
}

function get_item_from_string_weapon(weapon_and_attachments_string) {
  item_struct = spawnStruct();
  weapon_and_attachments = strtok(weapon_and_attachments_string, "+");
  weapon_name = getsubstr(weapon_and_attachments[0], 0, weapon_and_attachments[0].size);
  attachments = array::remove_index(weapon_and_attachments, 0);
  item_struct.name = weapon_name;
  item_struct.weapon = getweapon(weapon_name, attachments);
  item_struct.model = item_struct.weapon.worldmodel;
  self setscale(1.5);
  return item_struct;
}

function get_item_from_string(item_string) {
  switch (self.script_noteworthy) {
    case "ammo": {
      return self get_item_from_string_ammo(item_string);
    }
    case "damage": {
      return self get_item_from_string_damage(item_string);
    }
    case "health": {
      return self get_item_from_string_health(item_string);
    }
    case "perk": {
      return self get_item_from_string_perk(item_string);
    }
    case "weapon": {
      return self get_item_from_string_weapon(item_string);
    }
  }
}

function init_items_for_pickup() {
  items_string = self.script_parameters;
  items_array = strtok(items_string, " ");
  items = [];
  foreach(item_string in items_array) {
    items[items.size] = self get_item_from_string(item_string);
  }
  return items;
}

function pickup_item_respawn_time() {
  switch (self.script_noteworthy) {
    case "ammo": {
      return 10;
    }
    case "damage": {
      return 60;
    }
    case "health": {
      return 10;
    }
    case "perk": {
      return 10;
    }
    case "weapon": {
      return 30;
    }
  }
}

function pickup_item_sound_pickup() {
  switch (self.script_noteworthy) {
    case "ammo": {
      return "wpn_ammo_pickup_oldschool";
    }
    case "damage": {
      return "wpn_weap_pickup_oldschool";
    }
    case "health": {
      return "wpn_weap_pickup_oldschool";
    }
    case "perk": {
      return "wpn_weap_pickup_oldschool";
    }
    case "weapon": {
      return "wpn_weap_pickup_oldschool";
    }
  }
}

function pickup_item_sound_respawn() {
  switch (self.script_noteworthy) {
    case "ammo": {
      return "wpn_ammo_pickup_oldschool";
    }
    case "damage": {
      return "wpn_weap_pickup_oldschool";
    }
    case "health": {
      return "wpn_weap_pickup_oldschool";
    }
    case "perk": {
      return "wpn_weap_pickup_oldschool";
    }
    case "weapon": {
      return "wpn_weap_pickup_oldschool";
    }
  }
}

function pickup_item_init() {
  self.items_shuffle = [];
  self set_pickup_bobbing();
  self.items = self init_items_for_pickup();
  self.respawn_time = self pickup_item_respawn_time();
  self.sound_pickup = self pickup_item_sound_pickup();
  self.sound_respawn = self pickup_item_sound_respawn();
  self set_pickup_rotation();
  self cycle_item();
}

function on_touch(player) {
  self endon("respawned");
  pickup_item = self.visuals[0];
  switch (pickup_item.script_noteworthy) {
    case "ammo": {
      pickup_item on_touch_ammo(player);
      break;
    }
    case "damage": {
      pickup_item on_touch_damage(player);
      break;
    }
    case "health": {
      pickup_item on_touch_health(player);
      break;
    }
    case "perk": {
      pickup_item on_touch_perk(player);
      break;
    }
    case "weapon": {
      if(!pickup_item on_touch_weapon(player)) {
        return;
      }
      break;
    }
  }
  pickup_item playSound(pickup_item.sound_pickup);
  self gameobjects::set_model_visibility(0);
  self gameobjects::allow_use("none");
  if(level.pickupitemrespawn) {
    wait(pickup_item.respawn_time);
    self thread respawn_pickup();
  }
}

function respawn_pickup() {
  self notify("respawned");
  pickup_item = self.visuals[0];
  pickup_item playSound(pickup_item.sound_respawn);
  pickup_item cycle_item();
  self gameobjects::set_model_visibility(1);
  self gameobjects::allow_use("any");
}

function respawn_all_pickups() {
  foreach(item in level.pickup_items) {
    item respawn_pickup();
  }
}

function on_touch_ammo(player) {
  self notify("scavenger", player);
  player pickupammoevent();
}

function on_touch_damage(player) {
  damage_scale_length = 15000;
  player.pickup_damage_scale = self.current_item.damage_scale;
  player.pickup_damage_scale_time = gettime() + damage_scale_length;
}

function on_touch_health(player) {
  if(self.current_item.extra_health <= 100) {
    health = player.health + self.current_item.extra_health;
    if(health > 100) {
      health = 100;
    }
  } else {
    health = self.current_item.extra_health;
  }
  player.health = health;
}

function on_touch_perk(player) {
  foreach(specialty in self.current_item.specialties) {
    player setperk(specialty);
  }
}

function has_active_gadget() {
  weapons = self getweaponslist(1);
  foreach(weapon in weapons) {
    if(!weapon.isgadget) {
      continue;
    }
    if(!weapon.isheroweapon && weapon.offhandslot !== "Gadget") {
      continue;
    }
    slot = self gadgetgetslot(weapon);
    if(self gadgetisactive(slot)) {
      return true;
    }
  }
  return false;
}

function take_player_gadgets() {
  weapons = self getweaponslist(1);
  foreach(weapon in weapons) {
    if(weapon.isgadget) {
      self takeweapon(weapon);
    }
  }
}

function take_offhand_weapon(offhandslot) {
  weapons = self getweaponslist(1);
  foreach(weapon in weapons) {
    if(weapon.offhandslot == offhandslot) {
      self takeweapon(weapon);
      return;
    }
  }
}

function should_switch_to_pickup_weapon(weapon) {
  if(weapon.isgadget) {
    return false;
  }
  if(weapon.isgrenadeweapon) {
    return false;
  }
  return true;
}

function on_touch_weapon(player) {
  weapon = self.current_item.weapon;
  had_weapon = player hasweapon(weapon);
  ammo_in_reserve = player getweaponammostock(weapon);
  if(weapon.isgadget) {
    if(player has_active_gadget()) {
      return false;
    }
    player take_player_gadgets();
  }
  if(weapon.inventorytype == "offhand") {
    player take_offhand_weapon(weapon.offhandslot);
  }
  player pickupweaponevent(weapon);
  player giveweapon(weapon);
  if(!player hasweapon(weapon)) {
    return false;
  }
  if(isDefined(self.script_ammo_clip) && isDefined(self.script_ammo_extra)) {
    if(had_weapon) {
      player setweaponammostock(weapon, (ammo_in_reserve + self.script_ammo_clip) + self.script_ammo_extra);
    } else {
      if(self.script_ammo_clip >= 0) {
        player setweaponammoclip(weapon, self.script_ammo_clip);
      }
      if(self.script_ammo_extra >= 0) {
        player setweaponammostock(weapon, self.script_ammo_extra);
      }
    }
  }
  if(weapon.isgadget) {
    slot = player gadgetgetslot(weapon);
    player gadgetpowerset(slot, 100);
  }
  if(!had_weapon && should_switch_to_pickup_weapon(weapon)) {
    player switchtoweapon(weapon);
  }
  return true;
}