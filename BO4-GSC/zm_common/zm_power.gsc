/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_power.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_power;

autoexec __init__system__() {
  system::register(#"zm_power", &__init__, &__main__, undefined);
}

__init__() {
  level.powered_items = [];
  level.local_power = [];
}

__main__() {
  thread standard_powered_items();
  level thread electric_switch_init();

  thread debug_powered_items();

}

debug_powered_items() {
  while(true) {
    if(getdvarint(#"zombie_equipment_health", 0)) {
      if(isDefined(level.local_power)) {
        foreach(localpower in level.local_power) {
          circle(localpower.origin, localpower.radius, (1, 0, 0), 0, 1, 1);
        }
      }
    }

    waitframe(1);
  }
}

  function electric_switch_init() {
    trigs = getEntArray("use_elec_switch", "targetname");

    if(isDefined(level.temporary_power_switch_logic)) {
      array::thread_all(trigs, level.temporary_power_switch_logic, trigs);
      return;
    }

    array::thread_all(trigs, &electric_switch);
  }

electric_switch() {
  self endon(#"hash_21e36726a7f30458");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.target)) {
    ent_parts = getEntArray(self.target, "targetname");
    struct_parts = struct::get_array(self.target, "targetname");

    foreach(ent in ent_parts) {
      if(isDefined(ent.script_noteworthy)) {
        master_switch = ent;

        switch (ent.script_noteworthy) {
          case #"elec_switch":
            break;
          case #"hash_47bde376753a03c9":
            break;
          case #"artifact_mind":
            break;
        }
      }
    }

    foreach(struct in struct_parts) {
      if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "elec_switch_fx") {
        fx_pos = struct;
      }
    }
  }

  while(isDefined(self)) {
    if(isDefined(master_switch) && isDefined(master_switch.script_noteworthy) && !(isDefined(self.var_1d2fecd6) && self.var_1d2fecd6)) {
      switch (master_switch.script_noteworthy) {
        case #"elec_switch":
          if(function_8b1a219a()) {
            self sethintstring(#"hash_5c4125d53451e888");
          } else {
            self sethintstring(#"zombie/electric_switch");
          }

          break;
        case #"hash_47bde376753a03c9":
          if(function_8b1a219a()) {
            self sethintstring(#"hash_5c4125d53451e888");
          } else {
            self sethintstring(#"zombie/electric_switch");
          }

          break;
        case #"artifact_mind":
          level waittill(#"player_spawned");

          if(function_8b1a219a()) {
            self sethintstring(#"hash_10cc78ab5ba5a7f2");
          } else {
            self sethintstring(#"hash_60e4802baafefe56");
          }

          break;
      }
    }

    self setvisibletoall();
    waitresult = self waittill(#"trigger");
    user = waitresult.activator;

    if(isDefined(self.var_b9eb2dbb) && self.var_b9eb2dbb) {
      self.var_1d2fecd6 = 1;
      waitframe(1);
      continue;
    }

    self setinvisibletoall();
    power_zone = undefined;

    if(isDefined(self.script_int)) {
      power_zone = self.script_int;
    }

    level thread zm_perks::perk_unpause_all_perks(power_zone);

    if(isDefined(master_switch) && isDefined(master_switch.script_noteworthy)) {
      switch (master_switch.script_noteworthy) {
        case #"elec_switch":
          elec_switch_on(master_switch, fx_pos);
          break;
        case #"hash_47bde376753a03c9":
          function_9d9892d2(master_switch);
          break;
        case #"artifact_mind":
          artifact_mind_on(master_switch, fx_pos, user);
          break;
      }
    }

    level turn_power_on_and_open_doors(power_zone);
    switchentnum = self getentitynumber();

    if(isDefined(switchentnum) && isDefined(user)) {
      user recordmapevent(17, gettime(), user.origin, level.round_number, switchentnum);
    }

    if(isplayer(user)) {
      user util::delay(1, "death", &zm_audio::create_and_play_dialog, #"power_switch", #"activate", undefined, 2);
    }

    if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "allow_power_off") {
      self delete();
      return;
    }

    if(isDefined(master_switch) && isDefined(master_switch.script_noteworthy)) {
      switch (master_switch.script_noteworthy) {
        case #"elec_switch":
          self sethintstring(#"hash_3071a199ee6ad7a6");
          break;
      }
    }

    self setvisibletoall();
    waitresult = self waittill(#"trigger");
    user = waitresult.activator;
    self setinvisibletoall();
    level thread zm_perks::perk_pause_all_perks(power_zone);

    if(isDefined(master_switch) && isDefined(master_switch.script_noteworthy)) {
      switch (master_switch.script_noteworthy) {
        case #"elec_switch":
          elec_switch_off(master_switch);
          break;
      }
    }

    if(isDefined(switchentnum) && isDefined(user)) {
      user recordmapevent(18, gettime(), user.origin, level.round_number, switchentnum);
    }

    level turn_power_off_and_close_doors(power_zone);
  }
}

elec_switch_on(master_switch, fx_pos) {
  master_switch rotateroll(-90, 0.3);
  master_switch playSound(#"zmb_switch_flip");
  master_switch waittill(#"rotatedone");
  master_switch playSound(#"zmb_turn_on");

  if(isDefined(fx_pos)) {
    playFX(level._effect[#"switch_sparks"], fx_pos.origin);
  }
}

elec_switch_off(master_switch) {
  master_switch rotateroll(90, 0.3);
  master_switch waittill(#"rotatedone");
}

function_9d9892d2(master_switch) {
  if(isDefined(master_switch.model_on)) {
    master_switch setModel(master_switch.model_on);
  }

  if(isDefined(master_switch.bundle)) {
    master_switch thread scene::play(master_switch.bundle, "ON", master_switch);
  }
}

artifact_mind_on(master_switch, fx_pos, user) {
  level notify(#"hash_3e80d503318a5674", {
    #player: user
  });
}

watch_global_power() {
  while(true) {
    level flag::wait_till("power_on");
    level thread set_global_power(1);
    level flag::wait_till_clear("power_on");
    level thread set_global_power(0);
  }
}

standard_powered_items() {
  level flag::wait_till("start_zombie_round_logic");
  vending_machines = zm_perks::get_perk_machines();

  foreach(trigger in vending_machines) {
    powered_on = zm_perks::get_perk_machine_start_state(trigger.script_noteworthy);
    powered_perk = add_powered_item(&perk_power_on, &perk_power_off, &perk_range, &cost_low_if_local, 0, powered_on, trigger);

    if(isDefined(trigger.script_int)) {
      powered_perk thread zone_controlled_perk(trigger.script_int);
    }
  }

  if(zm_custom::function_901b751c(#"zmpowerdoorstate") != 0) {
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
  }

  thread watch_global_power();
}

zone_controlled_perk(zone) {
  while(true) {
    power_flag = "power_on" + zone;
    level flag::wait_till(power_flag);
    self thread perk_power_on();
    level flag::wait_till_clear(power_flag);
    self thread perk_power_off();
  }
}

add_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
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

remove_powered_item(powered) {
  arrayremovevalue(level.powered_items, powered, 0);
}

add_temp_powered_item(power_on_func, power_off_func, range_func, cost_func, power_sources, self_powered, target) {
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

watch_temp_powered_item(powered) {
  powered.target waittill(#"death");
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

change_power_in_radius(delta, origin, radius) {
  changed_list = [];

  for(i = 0; i < level.powered_items.size; i++) {
    powered = level.powered_items[i];

    if(powered.power_sources != 2 && powered[[powered.range_func]](delta, origin, radius)) {
      powered change_power(delta, origin, radius);
      changed_list[changed_list.size] = powered;
    }
  }

  return changed_list;
}

change_power(delta, origin, radius) {
  if(delta > 0) {
    if(!self.power) {
      self.power = 1;
      self[[self.power_on_func]](origin, radius);
    }

    self.powered_count++;
    return;
  }

  if(delta < 0) {
    if(self.power) {
      self.power = 0;
      self[[self.power_off_func]](origin, radius);
    }

    self.depowered_count++;
  }
}

revert_power_to_list(delta, origin, radius, powered_list) {
  for(i = 0; i < powered_list.size; i++) {
    powered = powered_list[i];
    powered revert_power(delta, origin, radius);
  }
}

revert_power(delta, origin, radius, powered_list) {
  if(delta > 0) {
    self.depowered_count--;
    assert(self.depowered_count >= 0, "<dev string:x38>");

    if(self.depowered_count == 0 && self.powered_count > 0 && !self.power) {
      self.power = 1;
      self[[self.power_on_func]](origin, radius);
    }

    return;
  }

  if(delta < 0) {
    self.powered_count--;
    assert(self.powered_count >= 0, "<dev string:x5c>");

    if(self.powered_count == 0 && self.power) {
      self.power = 0;
      self[[self.power_off_func]](origin, radius);
    }
  }
}

add_local_power(origin, radius) {
  localpower = spawnStruct();
  println("<dev string:x80>" + origin + "<dev string:x9f>" + radius + "<dev string:xaa>");
  localpower.origin = origin;
  localpower.radius = radius;
  localpower.enabled_list = change_power_in_radius(1, origin, radius);
  level.local_power[level.local_power.size] = localpower;
  return localpower;
}

move_local_power(localpower, origin) {
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

end_local_power(localpower) {
  println("<dev string:xae>" + localpower.origin + "<dev string:x9f>" + localpower.radius + "<dev string:xaa>");

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

has_local_power(origin) {
  if(isDefined(level.local_power)) {
    foreach(localpower in level.local_power) {
      if(distancesquared(localpower.origin, origin) < localpower.radius * localpower.radius) {
        return true;
      }
    }
  }

  return false;
}

get_powered_item_cost() {
  if(!(isDefined(self.power) && self.power)) {
    return 0;
  }

  if(isDefined(level._power_global) && level._power_global && !(self.power_sources == 1)) {
    return 0;
  }

  cost = [[self.cost_func]]();
  power_sources = self.powered_count;

  if(power_sources < 1) {
    power_sources = 1;
  }

  return cost / power_sources;
}

get_local_power_cost(localpower) {
  cost = 0;

  if(isDefined(localpower) && isDefined(localpower.enabled_list)) {
    foreach(powered in localpower.enabled_list) {
      cost += powered get_powered_item_cost();
    }
  }

  if(isDefined(localpower) && isDefined(localpower.added_list)) {
    foreach(powered in localpower.added_list) {
      cost += powered get_powered_item_cost();
    }
  }

  return cost;
}

set_global_power(on_off) {
  demo::bookmark(#"zm_power", gettime(), undefined, undefined, 1);
  potm::bookmark(#"zm_power", gettime(), undefined, undefined, 1);
  level._power_global = on_off;

  for(i = 0; i < level.powered_items.size; i++) {
    powered = level.powered_items[i];

    if(isDefined(powered.target) && powered.power_sources != 1) {
      powered global_power(on_off);
      util::wait_network_frame();
    }
  }
}

global_power(on_off) {
  if(on_off) {
    println("<dev string:xce>");

    if(!self.power) {
      self.power = 1;
      self[[self.power_on_func]]();
    }

    self.powered_count++;
    return;
  }

  println("<dev string:xeb>");
  self.powered_count--;
  assert(self.powered_count >= 0, "<dev string:x5c>");

  if(self.powered_count == 0 && self.power) {
    self.power = 0;
    self[[self.power_off_func]]();
  }
}

never_power_on(origin, radius) {}

never_power_off(origin, radius) {}

cost_negligible() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }

  return 0;
}

cost_low_if_local() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }

  if(isDefined(level._power_global) && level._power_global || isDefined(self.self_powered) && self.self_powered) {
    return 0;
  }

  return 1;
}

cost_high() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }

  return 10;
}

door_range(delta, origin, radius) {
  if(delta < 0) {
    return false;
  }

  if(distancesquared(self.target.origin, origin) < radius * radius) {
    return true;
  }

  return false;
}

door_power_on(origin, radius) {
  println("<dev string:x109>");
  self.target.power_on = 1;
  self.target notify(#"power_on");
}

door_power_off(origin, radius) {
  println("<dev string:x120>");
  self.target notify(#"power_off");
  self.target.power_on = 0;
}

door_local_power_on(origin, radius) {
  println("<dev string:x138>");
  self.target.local_power_on = 1;
  self.target notify(#"local_power_on");
}

door_local_power_off(origin, radius) {
  println("<dev string:x157>");
  self.target notify(#"local_power_off");
  self.target.local_power_on = 0;
}

cost_door() {
  if(isDefined(self.target.power_cost)) {
    if(!isDefined(self.one_time_cost)) {
      self.one_time_cost = 0;
    }

    self.one_time_cost += self.target.power_cost;
    self.target.power_cost = 0;
  }

  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }

  return 0;
}

zombie_range(delta, origin, radius) {
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

zombie_power_off(origin, radius) {
  println("<dev string:x177>");

  for(i = 0; i < self.zombies.size; i++) {
    self.zombies[i] thread stun_zombie();
    waitframe(1);
  }
}

stun_zombie() {
  self notify(#"stun_zombie");
  self endon(#"death", #"stun_zombie");

  if(self.health <= 0) {

    iprintln("<dev string:x192>");

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

perk_range(delta, origin, radius) {
  if(isDefined(self.target)) {
    perkorigin = self.target.origin;

    if(isDefined(self.target.trigger_off) && self.target.trigger_off) {
      perkorigin = self.target.realorigin;
    } else if(isDefined(self.target.disabled) && self.target.disabled) {
      perkorigin += (0, 0, 10000);
    }

    if(distancesquared(perkorigin, origin) < radius * radius) {
      return true;
    }
  }

  return false;
}

perk_power_on(origin, radius) {
  println("<dev string:x1b1>" + self.target zm_perks::getvendingmachinenotify() + "<dev string:x1c5>");
  level notify(self.target zm_perks::getvendingmachinenotify() + "_on");
  zm_perks::perk_unpause(self.target.script_noteworthy);
}

perk_power_off(origin, radius) {
  notify_name = self.target zm_perks::getvendingmachinenotify();

  if(isDefined(notify_name) && notify_name == "revive") {
    if(level flag::exists("solo_game") && level flag::get("solo_game")) {
      return;
    }
  }

  println("<dev string:x1b1>" + self.target.script_noteworthy + "<dev string:x1cc>");
  self.target notify(#"death");
  self.target thread zm_perks::vending_trigger_think();

  if(isDefined(self.target.perk_hum)) {
    self.target.perk_hum delete();
  }

  zm_perks::perk_pause(self.target.script_noteworthy);
  level notify(self.target zm_perks::getvendingmachinenotify() + "_off");
}

turn_power_on_and_open_doors(power_zone) {
  level.local_doors_stay_open = 1;
  level.power_local_doors_globally = 1;

  if(!isDefined(power_zone)) {
    level flag::set("power_on");
    level clientfield::set("zombie_power_on", 1);
  } else {
    level flag::set("power_on" + power_zone);
    level clientfield::set("zombie_power_on", power_zone + 1);
  }

  foreach(player in level.players) {
    player zm_stats::forced_attachment("boas_power_turnedon");
  }

  if(zm_custom::function_901b751c(#"zmpowerdoorstate") != 0) {
    zombie_doors = getEntArray("zombie_door", "targetname");

    foreach(door in zombie_doors) {
      if(!isDefined(door.script_noteworthy)) {
        continue;
      }

      if(!isDefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
        door notify(#"power_on");
        continue;
      }

      if(isDefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
        door notify(#"power_on");

        if(isDefined(level.temporary_power_switch_logic)) {
          door.power_on = 1;
        }

        continue;
      }

      if(isDefined(door.script_int) && door.script_int == power_zone && door.script_noteworthy === "local_electric_door") {
        door notify(#"local_power_on");
      }
    }
  }
}

turn_power_off_and_close_doors(power_zone) {
  level.local_doors_stay_open = 0;
  level.power_local_doors_globally = 0;

  if(!isDefined(power_zone)) {
    level flag::clear("power_on");
    level clientfield::set("zombie_power_off", 0);
  } else {
    level flag::clear("power_on" + power_zone);
    level clientfield::set("zombie_power_off", power_zone);
  }

  if(zm_custom::function_901b751c(#"zmpowerdoorstate") != 0) {
    zombie_doors = getEntArray("zombie_door", "targetname");

    foreach(door in zombie_doors) {
      if(!isDefined(door.script_noteworthy)) {
        continue;
      }

      if(!isDefined(power_zone) && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
        door notify(#"power_on");
        continue;
      }

      if(isDefined(door.script_int) && door.script_int == power_zone && (door.script_noteworthy == "electric_door" || door.script_noteworthy == "electric_buyable_door")) {
        door notify(#"power_on");

        if(isDefined(level.temporary_power_switch_logic)) {
          door.power_on = 0;
          door sethintstring(#"zombie/need_power");
          door notify(#"kill_door_think");
          door thread zm_blockers::door_think();
        }

        continue;
      }

      if(isDefined(door.script_noteworthy) && door.script_noteworthy == "local_electric_door") {
        door notify(#"local_power_on");
      }
    }
  }
}