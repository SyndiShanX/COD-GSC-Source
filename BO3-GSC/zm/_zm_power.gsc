/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_power.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_utility;
#namespace zm_power;

function autoexec __init__sytem__() {
  system::register("zm_power", &__init__, &__main__, undefined);
}

function __init__() {
  level.powered_items = [];
  level.local_power = [];
}

function __main__() {
  thread standard_powered_items();
  level thread electric_switch_init();
  thread debug_powered_items();
}

function debug_powered_items() {
  while(true) {
    if(getdvarint("")) {
      if(isDefined(level.local_power)) {
        foreach(localpower in level.local_power) {
          circle(localpower.origin, localpower.radius, (1, 0, 0), 0, 1, 1);
        }
      }
    }
    wait(0.05);
  }
}

function electric_switch_init() {
  trigs = getEntArray("use_elec_switch", "targetname");
  if(isDefined(level.temporary_power_switch_logic)) {
    array::thread_all(trigs, level.temporary_power_switch_logic, trigs);
  } else {
    array::thread_all(trigs, &electric_switch, trigs);
  }
}

function electric_switch(switch_array) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.target)) {
    ent_parts = getEntArray(self.target, "targetname");
    struct_parts = struct::get_array(self.target, "targetname");
    foreach(ent in ent_parts) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "elec_switch") {
        master_switch = ent;
        master_switch notsolid();
      }
    }
    foreach(struct in struct_parts) {
      if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "elec_switch_fx") {
        fx_pos = struct;
      }
    }
  }
  while(isDefined(self)) {
    self sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
    self setvisibletoall();
    self waittill("trigger", user);
    self setinvisibletoall();
    if(isDefined(master_switch)) {
      master_switch rotateroll(-90, 0.3);
      master_switch playSound("zmb_switch_flip");
    }
    power_zone = undefined;
    if(isDefined(self.script_int)) {
      power_zone = self.script_int;
    }
    level thread zm_perks::perk_unpause_all_perks(power_zone);
    if(isDefined(master_switch)) {
      master_switch waittill("rotatedone");
      playFX(level._effect["switch_sparks"], fx_pos.origin);
      master_switch playSound("zmb_turn_on");
    }
    level turn_power_on_and_open_doors(power_zone);
    switchentnum = self getentitynumber();
    if(isDefined(switchentnum) && isDefined(user)) {
      user recordmapevent(17, gettime(), user.origin, level.round_number, switchentnum);
    }
    if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "allow_power_off") {
      self delete();
      return;
    }
    self sethintstring(&"ZOMBIE_ELECTRIC_SWITCH_OFF");
    self setvisibletoall();
    self waittill("trigger", user);
    self setinvisibletoall();
    if(isDefined(master_switch)) {
      master_switch rotateroll(90, 0.3);
      master_switch playSound("zmb_switch_flip");
    }
    level thread zm_perks::perk_pause_all_perks(power_zone);
    if(isDefined(master_switch)) {
      master_switch waittill("rotatedone");
    }
    if(isDefined(switchentnum) && isDefined(user)) {
      user recordmapevent(18, gettime(), user.origin, level.round_number, switchentnum);
    }
    level turn_power_off_and_close_doors(power_zone);
  }
}

function watch_global_power() {
  while(true) {
    level flag::wait_till("power_on");
    level thread set_global_power(1);
    level flag::wait_till_clear("power_on");
    level thread set_global_power(0);
  }
}

function standard_powered_items() {
  level flag::wait_till("start_zombie_round_logic");
  vending_triggers = getEntArray("zombie_vending", "targetname");
  foreach(trigger in vending_triggers) {
    powered_on = zm_perks::get_perk_machine_start_state(trigger.script_noteworthy);
    powered_perk = add_powered_item(&perk_power_on, &perk_power_off, &perk_range, &cost_low_if_local, 0, powered_on, trigger);
    if(isDefined(trigger.script_int)) {
      powered_perk thread zone_controlled_perk(trigger.script_int);
    }
  }
  zombie_doors = getEntArray("zombie_door", "targetname");
  foreach(door in zombie_doors) {
    if(isDefined(door.script_noteworthy) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
      add_powered_item(&door_power_on, &door_power_off, &door_range, &cost_door, 0, 0, door);
      continue;
    }
    if(isDefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
      power_sources = 0;
      if(!(isDefined(level.power_local_doors_globally) && level.power_local_doors_globally)) {
        power_sources = 1;
      }
      add_powered_item(&door_local_power_on, &door_local_power_off, &door_range, &cost_door, power_sources, 0, door);
    }
  }
  thread watch_global_power();
}

function zone_controlled_perk(zone) {
  while(true) {
    power_flag = "power_on" + zone;
    level flag::wait_till(power_flag);
    self thread perk_power_on();
    level flag::wait_till_clear(power_flag);
    self thread perk_power_off();
  }
}

function add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
  powered = spawnStruct();
  powered.power_on_func = power_on_func;
  powered.power_off_func = power_off_func;
  powered.range_func = range_func;
  powered.power_sources = power_sources;
  powered.self_powered = self_powered;
  powered.target = target;
  powered.cost_func = cost_func;
  powered.power = self_powered;
  powered.powered_count = self_powered;
  powered.depowered_count = 0;
  level.powered_items[level.powered_items.size] = powered;
  return powered;
}

function remove_powered_item(powered) {
  arrayremovevalue(level.powered_items, powered, 0);
}

function add_temp_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
  powered = add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target);
  if(isDefined(level.local_power)) {
    foreach(localpower in level.local_power) {
      if(powered[[powered.range_func]](1, localpower.origin, localpower.radius)) {
        powered change_power(1, localpower.origin, localpower.radius);
        if(!isDefined(localpower.added_list)) {
          localpower.added_list = [];
        }
        localpower.added_list[localpower.added_list.size] = powered;
      }
    }
  }
  thread watch_temp_powered_item(powered);
  return powered;
}

function watch_temp_powered_item(powered) {
  powered.target waittill("death");
  remove_powered_item(powered);
  if(isDefined(level.local_power)) {
    foreach(localpower in level.local_power) {
      if(isDefined(localpower.added_list)) {
        arrayremovevalue(localpower.added_list, powered, 0);
      }
      if(isDefined(localpower.enabled_list)) {
        arrayremovevalue(localpower.enabled_list, powered, 0);
      }
    }
  }
}

function change_power_in_radius(delta, origin, radius) {
  changed_list = [];
  for(i = 0; i < level.powered_items.size; i++) {
    powered = level.powered_items[i];
    if(powered.power_sources != 2) {
      if(powered[[powered.range_func]](delta, origin, radius)) {
        powered change_power(delta, origin, radius);
        changed_list[changed_list.size] = powered;
      }
    }
  }
  return changed_list;
}

function change_power(delta, origin, radius) {
  if(delta > 0) {
    if(!self.power) {
      self.power = 1;
      self[[self.power_on_func]](origin, radius);
    }
    self.powered_count++;
  } else if(delta < 0) {
    if(self.power) {
      self.power = 0;
      self[[self.power_off_func]](origin, radius);
    }
    self.depowered_count++;
  }
}

function revert_power_to_list(delta, origin, radius, powered_list) {
  for(i = 0; i < powered_list.size; i++) {
    powered = powered_list[i];
    powered revert_power(delta, origin, radius);
  }
}

function revert_power(delta, origin, radius, powered_list) {
  if(delta > 0) {
    self.depowered_count--;
    assert(self.depowered_count >= 0, "");
    if(self.depowered_count == 0 && self.powered_count > 0 && !self.power) {
      self.power = 1;
      self[[self.power_on_func]](origin, radius);
    }
  } else if(delta < 0) {
    self.powered_count--;
    assert(self.powered_count >= 0, "");
    if(self.powered_count == 0 && self.power) {
      self.power = 0;
      self[[self.power_off_func]](origin, radius);
    }
  }
}

function add_local_power(origin, radius) {
  localpower = spawnStruct();
  println(((("" + origin) + "") + radius) + "");
  localpower.origin = origin;
  localpower.radius = radius;
  localpower.enabled_list = change_power_in_radius(1, origin, radius);
  level.local_power[level.local_power.size] = localpower;
  return localpower;
}

function move_local_power(localpower, origin) {
  changed_list = [];
  for(i = 0; i < level.powered_items.size; i++) {
    powered = level.powered_items[i];
    if(powered.power_sources == 2) {
      continue;
    }
    waspowered = isinarray(localpower.enabled_list, powered);
    ispowered = powered[[powered.range_func]](1, origin, localpower.radius);
    if(ispowered && !waspowered) {
      powered change_power(1, origin, localpower.radius);
      localpower.enabled_list[localpower.enabled_list.size] = powered;
      continue;
    }
    if(!ispowered && waspowered) {
      powered revert_power(-1, localpower.origin, localpower.radius, localpower.enabled_list);
      arrayremovevalue(localpower.enabled_list, powered, 0);
    }
  }
  localpower.origin = origin;
  return localpower;
}

function end_local_power(localpower) {
  println(((("" + localpower.origin) + "") + localpower.radius) + "");
  if(isDefined(localpower.enabled_list)) {
    revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.enabled_list);
  }
  localpower.enabled_list = undefined;
  if(isDefined(localpower.added_list)) {
    revert_power_to_list(-1, localpower.origin, localpower.radius, localpower.added_list);
  }
  localpower.added_list = undefined;
  arrayremovevalue(level.local_power, localpower, 0);
}

function has_local_power(origin) {
  if(isDefined(level.local_power)) {
    foreach(localpower in level.local_power) {
      if(distancesquared(localpower.origin, origin) < (localpower.radius * localpower.radius)) {
        return true;
      }
    }
  }
  return false;
}

function get_powered_item_cost() {
  if(!(isDefined(self.power) && self.power)) {
    return 0;
  }
  if(isDefined(level._power_global) && level._power_global && !self.power_sources == 1) {
    return 0;
  }
  cost = [[self.cost_func]]();
  power_sources = self.powered_count;
  if(power_sources < 1) {
    power_sources = 1;
  }
  return cost / power_sources;
}

function get_local_power_cost(localpower) {
  cost = 0;
  if(isDefined(localpower) && isDefined(localpower.enabled_list)) {
    foreach(powered in localpower.enabled_list) {
      cost = cost + powered get_powered_item_cost();
    }
  }
  if(isDefined(localpower) && isDefined(localpower.added_list)) {
    foreach(powered in localpower.added_list) {
      cost = cost + powered get_powered_item_cost();
    }
  }
  return cost;
}

function set_global_power(on_off) {
  demo::bookmark("zm_power", gettime(), undefined, undefined, 1);
  level._power_global = on_off;
  for(i = 0; i < level.powered_items.size; i++) {
    powered = level.powered_items[i];
    if(isDefined(powered.target) && powered.power_sources != 1) {
      powered global_power(on_off);
      util::wait_network_frame();
    }
  }
}

function global_power(on_off) {
  if(on_off) {
    println("");
    if(!self.power) {
      self.power = 1;
      self[[self.power_on_func]]();
    }
    self.powered_count++;
  } else {
    println("");
    self.powered_count--;
    assert(self.powered_count >= 0, "");
    if(self.powered_count == 0 && self.power) {
      self.power = 0;
      self[[self.power_off_func]]();
    }
  }
}

function never_power_on(origin, radius) {}

function never_power_off(origin, radius) {}

function cost_negligible() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }
  return 0;
}

function cost_low_if_local() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }
  if(isDefined(level._power_global) && level._power_global) {
    return 0;
  }
  if(isDefined(self.self_powered) && self.self_powered) {
    return 0;
  }
  return 1;
}

function cost_high() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }
  return 10;
}

function door_range(delta, origin, radius) {
  if(delta < 0) {
    return false;
  }
  if(distancesquared(self.target.origin, origin) < (radius * radius)) {
    return true;
  }
  return false;
}

function door_power_on(origin, radius) {
  println("");
  self.target.power_on = 1;
  self.target notify("power_on");
}

function door_power_off(origin, radius) {
  println("");
  self.target notify("power_off");
  self.target.power_on = 0;
}

function door_local_power_on(origin, radius) {
  println("");
  self.target.local_power_on = 1;
  self.target notify("local_power_on");
}

function door_local_power_off(origin, radius) {
  println("");
  self.target notify("local_power_off");
  self.target.local_power_on = 0;
}

function cost_door() {
  if(isDefined(self.target.power_cost)) {
    if(!isDefined(self.one_time_cost)) {
      self.one_time_cost = 0;
    }
    self.one_time_cost = self.one_time_cost + self.target.power_cost;
    self.target.power_cost = 0;
  }
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }
  return 0;
}

function zombie_range(delta, origin, radius) {
  if(delta > 0) {
    return false;
  }
  self.zombies = array::get_all_closest(origin, zombie_utility::get_round_enemy_array(), undefined, undefined, radius);
  if(!isDefined(self.zombies)) {
    return false;
  }
  self.power = 1;
  return true;
}

function zombie_power_off(origin, radius) {
  println("");
  for(i = 0; i < self.zombies.size; i++) {
    self.zombies[i] thread stun_zombie();
    wait(0.05);
  }
}

function stun_zombie() {
  self endon("death");
  self notify("stun_zombie");
  self endon("stun_zombie");
  if(self.health <= 0) {
    iprintln("");
    return;
  }
  if(isDefined(self.ignore_inert) && self.ignore_inert) {
    return;
  }
  if(isDefined(self.stun_zombie)) {
    self thread[[self.stun_zombie]]();
    return;
  }
}

function perk_range(delta, origin, radius) {
  if(isDefined(self.target)) {
    perkorigin = self.target.origin;
    if(isDefined(self.target.trigger_off) && self.target.trigger_off) {
      perkorigin = self.target.realorigin;
    } else if(isDefined(self.target.disabled) && self.target.disabled) {
      perkorigin = perkorigin + vectorscale((0, 0, 1), 10000);
    }
    if(distancesquared(perkorigin, origin) < (radius * radius)) {
      return true;
    }
  }
  return false;
}

function perk_power_on(origin, radius) {
  println(("" + self.target zm_perks::getvendingmachinenotify()) + "");
  level notify(self.target zm_perks::getvendingmachinenotify() + "_on");
  zm_perks::perk_unpause(self.target.script_noteworthy);
}

function perk_power_off(origin, radius) {
  notify_name = self.target zm_perks::getvendingmachinenotify();
  if(isDefined(notify_name) && notify_name == "revive") {
    if(level flag::exists("solo_game") && level flag::get("solo_game")) {
      return;
    }
  }
  println(("" + self.target.script_noteworthy) + "");
  self.target notify("death");
  self.target thread zm_perks::vending_trigger_think();
  if(isDefined(self.target.perk_hum)) {
    self.target.perk_hum delete();
  }
  zm_perks::perk_pause(self.target.script_noteworthy);
  level notify(self.target zm_perks::getvendingmachinenotify() + "_off");
}

function turn_power_on_and_open_doors(power_zone) {
  level.local_doors_stay_open = 1;
  level.power_local_doors_globally = 1;
  if(!isDefined(power_zone)) {
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 0);
  } else {
    level flag::set("power_on" + power_zone);
    level clientfield::set("zombie_power_on", power_zone);
  }
  zombie_doors = getEntArray("zombie_door", "targetname");
  foreach(door in zombie_doors) {
    if(!isDefined(door.script_noteworthy)) {
      continue;
    }
    if(!isDefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
      door notify("power_on");
      continue;
    }
    if(isDefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
      door notify("power_on");
      if(isDefined(level.temporary_power_switch_logic)) {
        door.power_on = 1;
      }
      continue;
    }
    if(isDefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy === "local_electric_door") {
      door notify("local_power_on");
    }
  }
}

function turn_power_off_and_close_doors(power_zone) {
  level.local_doors_stay_open = 0;
  level.power_local_doors_globally = 0;
  if(!isDefined(power_zone)) {
    level flag::clear("power_on");
    level clientfield::set("zombie_power_off", 0);
  } else {
    level flag::clear("power_on" + power_zone);
    level clientfield::set("zombie_power_off", power_zone);
  }
  zombie_doors = getEntArray("zombie_door", "targetname");
  foreach(door in zombie_doors) {
    if(!isDefined(door.script_noteworthy)) {
      continue;
    }
    if(!isDefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
      door notify("power_on");
      continue;
    }
    if(isDefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
      door notify("power_on");
      if(isDefined(level.temporary_power_switch_logic)) {
        door.power_on = 0;
        door sethintstring(&"ZOMBIE_NEED_POWER");
        door notify("kill_door_think");
        door thread zm_blockers::door_think();
      }
      continue;
    }
    if(isDefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
      door notify("local_power_on");
    }
  }
}