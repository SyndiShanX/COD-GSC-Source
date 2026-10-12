/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning_util.gsc
***********************************************/



#using script_24e4405cf93f20ed;
#using scripts\asm\shared\mp\utility;
#using scripts\asm\soldier\vehicle;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\weapon;
#using scripts\engine\flags;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_spawning_util;

function enable_juggernaut_move_behavior(group) {
  if(is_specified_unittype("juggernaut")) {
    self.var_c833409fb72d15fb = 0;
  }
}

function disable_juggernaut_move_behavior(group) {
  if(is_specified_unittype("juggernaut")) {
    self.var_c833409fb72d15fb = 1;
  }
}

function enable_cover_node_behavior(group) {
  self.combatmode = "cover";
  self setcanusecover(1);
}

function disable_cover_node_behavior(group) {
  self setcanusecover(0);
}

function end_objective_when_all_dead(group, objective, var_ff5ccede2521cb13, unused3) {
  group thread end_objective_when_all_dead_interal(group, objective, var_ff5ccede2521cb13, unused3);
}

function end_objective_when_all_dead_interal(group, objective_name, var_ff5ccede2521cb13, unused3) {
  level endon("game_ended");
  group waittill("all_group_spawns_dead");

  if(isDefined(var_ff5ccede2521cb13)) {
    level notify(var_ff5ccede2521cb13);
  }

  if(isDefined(objective_name)) {
    scripts\cp\cp_objectives::debugbeatobjective(objective_name);
  }
}

function disable_spawner_until_owner_death(spawnpoint) {
  spawnpoint disable_spawner();
  waittill_any_ents(self, "death", self.group, "death");
  spawnpoint function_ec648f2c89ea1c91();
  spawnpoint enable_spawner();
}

function register_module_for_spawn_owner_disables(group_name) {
  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(i = 0; i < level.ambientgroups[group_name].size; i++) {
        level.ambientgroups[group_name][i].disable_spawners_until_owner_death = 1;
      }

      return;
    }

    level.ambientgroups[group_name].disable_spawners_until_owner_death = 1;
  }
}

function register_grenade_settings_for_module(module_name, grenade_types, grenade_chances) {
  if(grenade_types.size != grenade_chances.size) {
    assertmsg("<dev string:x1c>" + module_name + "<dev string:x96>");
    return;
  }

  if(isDefined(level.ambientgroups[module_name])) {
    if(isarray(level.ambientgroups[module_name])) {
      for(i = 0; i < level.ambientgroups[module_name].size; i++) {
        level.ambientgroups[module_name][i].grenade_types = grenade_types;
        level.ambientgroups[module_name][i].grenade_chances = grenade_chances;
      }
    }
  }
}

function get_spawncount_from_groupnames(var_42dca3c7abc17220) {
  return_count = 0;

  if(!isarray(var_42dca3c7abc17220)) {
    var_42dca3c7abc17220 = [var_42dca3c7abc17220];
  }

  for(i = 0; i < var_42dca3c7abc17220.size; i++) {
    group_name = var_42dca3c7abc17220[i];
    return_count += get_spawn_count_from_groupname(group_name);
  }

  return return_count;
}

function module_disables_spawners_until_owner_death() {
  return istrue(self.disable_spawners_until_owner_death);
}

function combine_module_counters(group, combined_alias) {
  if(!isDefined(level.combined_counters_groups[combined_alias])) {
    level.combined_counters_groups[combined_alias] = [];
  }

  level.combined_counters_groups[combined_alias][level.combined_counters_groups[combined_alias].size] = group;
  group.combined_alias = combined_alias;
}

function remove_group_from_combined_module_counters(group) {
  combined_alias = group get_has_combined_counters_alias();
  group.combined_alias = undefined;

  if(!isDefined(combined_alias)) {
    return;
  }

  if(isDefined(level.combined_counters_groups[combined_alias])) {
    level.combined_counters_groups[combined_alias] = array_remove(level.combined_counters_groups[combined_alias], group);
  }

  if(isDefined(level.combined_counters_groups[combined_alias]) && level.combined_counters_groups[combined_alias].size < 1) {
    level.combined_counters_groups[combined_alias] = undefined;
  }
}

function group_has_combined_counters(group_name) {
  module_structs = get_module_structs_by_groupname(group_name);

  for(i = 0; i < module_structs.size; i++) {
    module = module_structs[i];

    if(isDefined(module.combined_alias)) {
      return true;
    }
  }

  return false;
}

function get_has_combined_counters_alias() {
  return self.combined_alias;
}

function register_module_init_func(group_name, var_4262a8e7c176383d) {
  if(isarray(level.ambientgroups[group_name])) {
    for(i = 0; i < level.ambientgroups[group_name].size; i++) {
      if(!isDefined(level.ambientgroups[group_name][i].module_init_funcs)) {
        level.ambientgroups[group_name][i].module_init_funcs = [];
      }

      level.ambientgroups[group_name][i].module_init_funcs[level.ambientgroups[group_name][i].module_init_funcs.size] = var_4262a8e7c176383d;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[group_name].module_init_funcs)) {
    level.ambientgroups[group_name].module_init_funcs = [];
  }

  level.ambientgroups[group_name].module_init_funcs[level.ambientgroups[group_name].module_init_funcs.size] = var_4262a8e7c176383d;
}

function register_module_died_poorly_func(group_name, var_4262a8e7c176383d) {
  if(isarray(level.ambientgroups[group_name])) {
    for(i = 0; i < level.ambientgroups[group_name].size; i++) {
      if(!isDefined(level.ambientgroups[group_name][i].died_poorly_funcs)) {
        level.ambientgroups[group_name][i].died_poorly_funcs = [];
      }

      level.ambientgroups[group_name][i].died_poorly_funcs[level.ambientgroups[group_name][i].died_poorly_funcs.size] = var_4262a8e7c176383d;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[group_name].died_poorly_funcs)) {
    level.ambientgroups[group_name].died_poorly_funcs = [];
  }

  level.ambientgroups[group_name].died_poorly_funcs[level.ambientgroups[group_name].died_poorly_funcs.size] = var_4262a8e7c176383d;
}

function run_module_init_funcs_on_module_struct() {
  if(isDefined(self.level_module_struct)) {
    data = self.level_module_struct;

    if(isDefined(data.module_init_funcs)) {
      for(i = 0; i < data.module_init_funcs.size; i++) {
        process_module_var(self, data.module_init_funcs[i]);
      }
    }
  }
}

function register_module_pause_unpause_funcs(group_name, pause_func, unpause_func) {
  if(isarray(level.ambientgroups[group_name])) {
    for(i = 0; i < level.ambientgroups[group_name].size; i++) {
      if(!isDefined(level.ambientgroups[group_name][i].module_pause_funcs)) {
        level.ambientgroups[group_name][i].module_pause_funcs = [];
      }

      level.ambientgroups[group_name][i].module_pause_funcs[level.ambientgroups[group_name][i].module_pause_funcs.size] = pause_func;

      if(!isDefined(level.ambientgroups[group_name][i].module_unpause_funcs)) {
        level.ambientgroups[group_name][i].module_unpause_funcs = [];
      }

      level.ambientgroups[group_name][i].module_unpause_funcs[level.ambientgroups[group_name][i].module_unpause_funcs.size] = unpause_func;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[group_name].module_pause_funcs)) {
    level.ambientgroups[group_name].module_pause_funcs = [];
  }

  level.ambientgroups[group_name].module_pause_funcs[level.ambientgroups[group_name].module_pause_funcs.size] = pause_func;

  if(!isDefined(level.ambientgroups[group_name].module_unpause_funcs)) {
    level.ambientgroups[group_name].module_unpause_funcs = [];
  }

  level.ambientgroups[group_name].module_unpause_funcs[level.ambientgroups[group_name].module_unpause_funcs.size] = unpause_func;
}

function run_module_pause_funcs() {
  if(isDefined(self.level_module_struct)) {
    data = self.level_module_struct;

    if(isDefined(data.module_pause_funcs)) {
      for(i = 0; i < data.module_pause_funcs.size; i++) {
        process_module_var(self, data.module_pause_funcs[i]);
      }
    }
  }
}

function run_module_unpause_funcs() {
  if(isDefined(self.level_module_struct)) {
    data = self.level_module_struct;

    if(isDefined(data.module_unpause_funcs)) {
      for(i = 0; i < data.module_unpause_funcs.size; i++) {
        process_module_var(self, data.module_unpause_funcs[i]);
      }
    }
  }
}

function cp_is_point_in_front(point) {
  dot = 0;

  if(isent(self) && isPlayer(self)) {
    to_point = point - self getorigin();
    forward = anglesToForward(self getplayerangles(1));
    dot = vectordot(to_point, forward);
  } else {
    if(isDefined(self.angles)) {
      angles = self.angles;
    } else {
      angles = (0, 0, 0);
    }

    to_point = point - self.origin;
    forward = anglesToForward(angles);
    dot = vectordot(to_point, forward);
  }

  return dot > 0;
}

function cp_is_point_on_right(point) {
  dot = 0;

  if(isPlayer(self)) {
    to_point = point - self getorigin();
    right = anglestoright(self getplayerangles(1));
    dot = vectordot(to_point, right);
  } else {
    if(isDefined(self.angles)) {
      angles = self.angles;
    } else {
      angles = (0, 0, 0);
    }

    to_point = point - self.origin;
    right = anglestoright(angles);
    dot = vectordot(to_point, right);
  }

  return dot > 0;
}

function create_agent_definition(new_def) {
  level.agent_definition[new_def] = [];
  level.agent_definition[new_def]["animclass"] = "soldier";
  level.agent_definition[new_def]["asm"] = "soldier";
  level.agent_definition[new_def]["behaviorTree"] = "soldier_agent";
  level.agent_definition[new_def]["health"] = 150;
  level.agent_definition[new_def]["height"] = 70;
  level.agent_definition[new_def]["radius"] = 15;
  level.agent_definition[new_def]["reward"] = 100;
  level.agent_definition[new_def]["setup_func"] = &new_agent_def_main;
  level.agent_definition[new_def]["setup_model_func"] = &fake_agent_model_setup;
  level.agent_definition[new_def]["species"] = "human";
  level.agent_definition[new_def]["team"] = "axis";
  level.agent_definition[new_def]["traversal_unit_type"] = "soldier";
  level.agent_definition[new_def]["xp"] = 50;
}

function new_agent_def_main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = % "cover_default";
  self.enemyselector = % "hash_5924daa85a22cdd9";
  self.unittype = "soldier";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  self.accuracy = 0.2;

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      self.weapon = scripts\cp_mp\weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self.weapon = scripts\cp_mp\weapon::buildweapon("iw8_ar_falpha_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 2:
      self.weapon = scripts\cp_mp\weapon::buildweapon("iw8_ar_falima_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon("frag_grenade_mp");
  self.grenadeammo = 2;
}

function fake_agent_model_setup(agent_type) {
  self.animationarchetype = "soldier";
  self.voice = #"alqatala";
  self setModel("body_spetsnaz_ar");
  self attach("head_russian_army_balaclava_1", "", 1);
  self.headmodel = "head_russian_army_balaclava_1";
}

function add_spawn_disable_struct(disable_pos, disable_radius) {
  struct = spawnStruct();
  struct.origin = disable_pos;
  struct.radius = disable_radius;
  struct scripts\engine\flags::assign_unique_id();
  level.spawner_poison_structs[struct.unique_id] = struct;
  return struct.unique_id;
}

function remove_spawn_disable_struct(unique_id) {
  if(isDefined(level.spawner_poison_structs[unique_id])) {
    level.spawner_poison_structs[unique_id] = undefined;
  }
}

function toggle_player_pos_memory(bool) {
  level.skip_player_pos_memory = bool;
}

function adjust_player_pos_memory_array_size(new_value) {
  if(isDefined(new_value)) {
    level.disable_recent_area_memory = new_value;
    return;
  }

  level.disable_recent_area_memory = undefined;
}

function get_module_spawn_points() {
  return_array = [];
  spawners = process_module_var(self, self.spawn_points);
  return spawners;
}

function set_recent_spawn_time_threshold_override(module_struct, threshold) {
  if(isarray(module_struct)) {
    foreach(struct in module_struct) {
      struct.recent_spawn_threshold = threshold;
    }

    return;
  }

  module_struct.recent_spawn_threshold = threshold;
}

function function_61ffc6a808c617a0(group_name, time_between_spawns) {
  assert(isstring(group_name));
  assert(isnumber(time_between_spawns));
  var_18e4128165dbee65 = get_module_structs_by_groupname(group_name);

  if(isDefined(var_18e4128165dbee65) && var_18e4128165dbee65.size > 0) {
    foreach(struct in var_18e4128165dbee65) {
      struct.time_between_spawns = time_between_spawns;
      process_module_var(struct, struct.time_between_spawns);
    }
  }
}

function function_76d4300cac6f9381(group_name, min_size) {
  assert(isstring(group_name));
  assert(isint(min_size));
  var_18e4128165dbee65 = get_module_structs_by_groupname(group_name);

  if(isDefined(var_18e4128165dbee65) && var_18e4128165dbee65.size > 0) {
    foreach(struct in var_18e4128165dbee65) {
      struct.min_size = min_size;
      process_module_var(struct, struct.min_size);
    }
  }
}

function function_b905b02b6c7aea3(group_name, max_size) {
  assert(isstring(group_name));
  assert(isint(max_size));
  var_18e4128165dbee65 = get_module_structs_by_groupname(group_name);

  if(isDefined(var_18e4128165dbee65) && var_18e4128165dbee65.size > 0) {
    foreach(struct in var_18e4128165dbee65) {
      struct.max_size = max_size;
      process_module_var(struct, struct.max_size);
    }
  }
}

function function_9f1addb4e0ff0121(name, target, max_time, endon_name) {
  level endon("game_ended");

  if(isDefined(endon_name)) {
    level endon(endon_name);
  }

  if(!isDefined(target)) {
    target = 1;
  }

  assertex(target >= 0, "module target not >= 0");
  struct = undefined;

  if(isDefined(level.spawn_module_structs_memory[name])) {
    struct = level.spawn_module_structs_memory[name];

    if(isarray(struct)) {
      struct = struct[0];
    }
  }

  assertex(isDefined(struct), "module: " + name + "is not defined.");
  assertex(isDefined(struct.activecount), "module: " + name + " has no ai spawned.");
  endtime = undefined;

  if(isDefined(max_time)) {
    assert(isnumber(max_time));
    starttime = gettime();
    endtime = starttime + max_time * 1000;
  }

  if(isDefined(struct) && isDefined(struct.activecount) && struct.activecount > 0) {
    while(struct.activecount > target) {
      if(struct.activecount <= target) {
        break;
      }

      if(isDefined(max_time) && gettime() > endtime) {
        break;
      }

      wait 0.5;
    }
  }
}

function function_5ebbd91d2f142dbc(endon_notify) {
  level endon("game_ended");

  if(!flag_exist("pause_trigger_spawn")) {
    flag_init("pause_trigger_spawn");
  }

  if(!flag_exist("disable_trigger_spawn")) {
    flag_init("disable_trigger_spawn");
  }

  flag_wait("level_ready_for_script");
  triggers = getEntArray("trigger_rotatable_radius", "classname");

  foreach(trigger in triggers) {
    if(!isDefined(trigger.struct) || !isDefined(trigger.struct.spawnflags)) {
      continue;
    }

    if(isDefined(trigger.init)) {
      continue;
    }

    var_eb527018293a50ed = trigger.struct.spawnflags & 32;
    var_a47dfa9be97584d9 = trigger.struct.spawnflags & 16;

    if(var_eb527018293a50ed) {
      if(var_a47dfa9be97584d9) {
        trigger thread function_173d5fa8d42ba233();
        trigger.init = 1;
        continue;
      }

      trigger thread trigger_spawn_init();
      trigger.init = 1;
    }
  }
}

function trigger_spawn_init(endon_notify) {
  self.spawners = getStructArray(self.target, "targetname");
  thread trigger_spawn(endon_notify);
}

function trigger_spawn(endon_notify) {
  self endon("death");
  level endon("game_ended");
  trigger_wait();
  ai_spawngroup(self.spawners);
  wait 1;
  self delete();
}

function ai_spawngroup(spawners, var_9bd8d35e5cf10d81) {
  spawnstructs = spawners;
  var_a9022dcddc38cfa = [];

  if(!isarray(spawners)) {
    spawnstructs = [spawners];
  }

  spawngroup = spawnstructs[0].targetname;
  var_9427293c1eee7deb = getdvarint(@ "hash_1e189dd1ac99d6d2", 0);

  foreach(spawner in spawnstructs) {
    if(var_9427293c1eee7deb) {
      soldier = spawner spawn_ai();
    } else {
      soldier = function_7736c252ad19c782(undefined, spawner, undefined, 1);
    }

    if(!isDefined(soldier)) {
      tries = 0;

      while(tries < 3) {
        if(var_9427293c1eee7deb) {
          soldier = spawner spawn_ai();
        } else {
          soldier = function_7736c252ad19c782(undefined, spawner, undefined, 1);
        }

        if(!isDefined(soldier)) {
          wait 0.1;
          tries++;
          continue;
        }

        break;
      }
    }

    if(!isDefined(soldier)) {
      println("<dev string:x98>" + spawner.targetname + "<dev string:xaa>" + spawner.origin);
      continue;
    }

    var_a9022dcddc38cfa[var_a9022dcddc38cfa.size] = soldier;

    if(isDefined(level.var_7a9f066f79bed633)) {
      soldier thread[[level.var_7a9f066f79bed633]]();
    }

    if(istrue(self.var_9e5f6ca242b92628) || istrue(spawner.var_9e5f6ca242b92628) || isDefined(spawner.spawnflags) && spawner.spawnflags & 4) {
      soldier thread scripts\cp\coop_stealth::run_common_functions(soldier, 1, 1);
    }

    if(getdvarint(@ "hash_5890e41dbbf58b87", 0) != 0 && !istrue(soldier isjuggernaut())) {
      soldier.maxhealth = getdvarint(@ "hash_5890e41dbbf58b87");
      soldier.health = soldier.maxhealth;
    }

    soldier.targetname = spawngroup;

    if(isDefined(soldier.target)) {
      soldier thread go_to_node();
    }
  }

  if(istrue(var_9bd8d35e5cf10d81)) {
    return var_a9022dcddc38cfa;
  }

  self delete();
  return var_a9022dcddc38cfa;
}

function function_173d5fa8d42ba233() {
  self.spawners = getStructArray(self.target, "targetname");
  function_e1884b3c25b85af8();
}

function function_e1884b3c25b85af8(endon_notify) {
  self endon("death");
  level endon("game_ended");
  trigger_wait();

  foreach(spawner in self.spawners) {
    thread vehicle_spawngroup(spawner);
  }

  self delete();
}

function vehicle_spawngroup(veh_spawner, ai_spawners) {
  if(getDvar(@ "hash_742caa13b3c2e685") == "1") {
    return;
  }

  riders = [];
  var_65119e62f62616e1 = "axis";

  if(isDefined(veh_spawner.spawngroup)) {
    if(isDefined(level.var_ed8b3892702336d7)) {
      level[[level.var_ed8b3892702336d7]](veh_spawner);
    }

    spawngroup = veh_spawner.spawngroup;
    spawners = getStructArray(veh_spawner.spawngroup, "targetname");

    if(!spawners.size && isDefined(ai_spawners) || isDefined(ai_spawners) && istrue(veh_spawner.var_79a88fdcf2bbdd5)) {
      spawners = ai_spawners;
    }

    foreach(index, spawner in spawners) {
      spawner.script_demeanor = undefined;
      rider = function_7736c252ad19c782(undefined, spawner, undefined, 1);

      if(isDefined(rider)) {
        var_65119e62f62616e1 = rider.team;

        if(isDefined(spawner.script_startingposition)) {
          rider.script_startingposition = int(spawner.script_startingposition);
        } else {
          rider.script_startingposition = index;
          rider.spawner.script_startingposition = index;
        }

        if(isDefined(level.var_7a9f066f79bed633)) {
          rider thread[[level.var_7a9f066f79bed633]]();
        }

        rider.vehicle_position = rider.script_startingposition;
        riders[riders.size] = rider;

        if(rider.script_startingposition == 0) {
          if(isDefined(rider.nocorpse)) {
            rider.og_nocorpse = rider.nocorpse;
          }

          rider.nocorpse = 1;
        }
      }

      waitframe();
    }
  }

  var_fa890e641f17ea50 = function_30c929b6490aaa38(veh_spawner);
  veh_spawner.initai = 1;

  if(var_fa890e641f17ea50 == "little_bird") {
    veh_spawner.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  } else if(var_fa890e641f17ea50 == "veh9_techo_rebel_armor") {
    veh_spawner.vehicletype = "veh9_techo_physics_cp";
  }

  assertex(isDefined(var_fa890e641f17ea50), "No supported vehicle type found. Check vehicletype list.");
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(var_fa890e641f17ea50, veh_spawner);
  assertex(isDefined(vehicle), "Vehicle wasn't spawned. Check vehicletypes above.");
  vehicle.vehicle_spawner = veh_spawner;

  if(!isDefined(vehicle.classname_mp) && isDefined(veh_spawner.classname_mp)) {
    vehicle.classname_mp = veh_spawner.classname_mp;
  }

  level notify("spawned_vehicle", var_fa890e641f17ea50);

  if(var_fa890e641f17ea50 == "little_bird") {
    vehicle function_247ad6a91f6a4ffe(1);
    vehicle.var_e6036cc5fe1c5c9e = 1;
  }

  if(riders.size) {
    namespace_cbe993018617a21d::function_64d2d74ab85e00bb(riders);

    if(isDefined(veh_spawner.load_vehicle)) {
      scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6(riders);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, var_65119e62f62616e1);
    } else {
      spawninvehicle = !isDefined(veh_spawner.var_3f0312e6382c878f) || istrue(veh_spawner.var_3f0312e6382c878f);
      vehicle scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6(riders, spawninvehicle);
    }

    level notify("loaded_ai_in_vehicle", vehicle);
  }

  if(isDefined(veh_spawner.target)) {
    path = getStruct(veh_spawner.target, "targetname");
  } else {
    path = getclosest(veh_spawner.origin, getStructArray("vehicle_path_start", "targetname"));
  }

  if(isDefined(path) && !isDefined(veh_spawner.nopath)) {
    if(vehicle scripts\common\vehicle::ishelicopter()) {
      vehicle.script_vehicle_selfremove = 1;
      vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
    } else {
      vehicle scripts\cp\vehicles::create_simple_path(path, vehicle.angles);
      vehicle thread scripts\cp\vehicles::vehiclefollowstructpath(path, 1);
    }
  }

  if(isDefined(veh_spawner.auto_crash)) {
    vehicle.auto_crash = 1;
  }

  if(getdvarint(@ "hash_691520ae38c53622", 0) != 0) {
    vehicle.maxhealth = getdvarint(@ "hash_691520ae38c53622");
    vehicle.health = vehicle.maxhealth;
  }

  if(isDefined(veh_spawner.var_72772fa651ecbe2b)) {
    funcs = strtok(veh_spawner.var_72772fa651ecbe2b, "+");

    foreach(func in funcs) {
      if(isDefined(level.var_a8dc22c62ba69b88[func])) {
        vehicle thread[[level.var_a8dc22c62ba69b88[func]]]();
      }
    }
  }

  if(isDefined(level.var_6e5ff6cae14c4081) && !vehicle scripts\common\vehicle::ishelicopter()) {
    level.var_6e5ff6cae14c4081[level.var_6e5ff6cae14c4081.size] = vehicle;
  }

  vehicle.unloadondriverdeath = 1;
  vehicle vehicle_turnengineon();
  return vehicle;
}

function function_30c929b6490aaa38(veh_spawner) {
  if(!isDefined(veh_spawner.vehicletype) && !isDefined(veh_spawner.script_vehicleref)) {
    return undefined;
  }

  if(isDefined(veh_spawner.script_vehicleref)) {
    return veh_spawner.script_vehicleref;
  }

  switch (veh_spawner.vehicletype) {
    case #"hash_317acb35b7665e03":
    case #"hash_ce4127fb9f87567a":
      return "veh9_techo_rebel_armor";
    case #"hash_89190aa2a533d16a":
    case #"hash_893906a2a54d6304":
      return "veh9_jltv";
    case #"hash_c753a6fe7078562b":
    case #"hash_c7a5a2fe70b8f735":
      return "veh9_jltv_mg";
    case #"hash_89ba97a39990db8a":
    case #"hash_d1a8233712983eb8":
      return "little_bird";
  }
}

function trigger_wait() {
  level endon("game_ended");
  self endon("death");
  var_cc98688338a8ab23 = isDefined(self.struct) && isDefined(self.struct.spawnflags) && self.struct.spawnflags & 8;

  while(true) {
    self waittill("trigger", player);
    flag_waitopen("pause_trigger_spawn");
    flag_waitopen("disable_trigger_spawn");

    if(!player is_valid_player()) {
      if(var_cc98688338a8ab23 && isDefined(level.recondronesupers) && level.recondronesupers.size) {
        keys = getarraykeys(level.recondronesupers);

        for(i = 0; i < level.recondronesupers.size; i++) {
          if(isDefined(level.recondronesupers[keys[i]].owner) && isPlayer(level.recondronesupers[keys[i]].owner)) {
            return;
          }
        }
      }

      if(isDefined(player.owner) && isPlayer(player.owner) && istrue(level.var_2f11073bd9ceb3e0)) {
        return;
      }

      continue;
    }

    return;
  }
}

function function_e7d3411db935e99b(pos) {
  self endon("death");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

function function_12c0de9ad36eb18b() {
  self endon("death");
  function_80dc2c3589695b44();
  dive_anim = "dive_fwd";
  getup_anim = "dive_fwd_getup";

  while(true) {
    waitframe();
    validvehicles = function_8a178ee7bfa2ff5a();

    if(!validvehicles.size) {
      continue;
    }

    closest_vehicle = getclosest(self.origin, validvehicles);
    dodge_type = function_c0f7c5e411992612("default", closest_vehicle);

    if(!isDefined(dodge_type) || dodge_type == "default") {
      continue;
    }

    function_e7fc2021e96eb2f9();

    switch (dodge_type) {
      case #"hash_389bec9333a57449":
      case #"hash_4d58a3e12a216eea":
        if(dodge_type == "dive_left") {
          self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoleft(closest_vehicle.angles) * 200));
        } else {
          self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoright(closest_vehicle.angles) * 200));
        }

        wait 0.2;
        scripts\asm\shared\mp\utility::animscripted_single(dive_anim);
        scripts\asm\shared\mp\utility::animscripted_single(getup_anim);
        scripts\asm\shared\mp\utility::animscripted_clear();
        self setgoalpos(self.origin);
        break;
      case #"hash_8dacd2752757b9ec":
        self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoleft(closest_vehicle.angles) * 200));
        break;
      case #"hash_3ab1c5582df829f9":
        self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoright(closest_vehicle.angles) * 200));
        break;
      default:
        break;
    }

    self waittill("goal");
    function_c83e8b49e55a092();
  }
}

function function_80dc2c3589695b44() {
  wait 3;

  while(isDefined(self.vehicle_position)) {
    wait 1;
  }
}

function function_8a178ee7bfa2ff5a() {
  allvehicles = function_823f69bc9733f183();
  cos_10 = cos(10);
  valid_vehicles = [];

  foreach(vehicle in allvehicles) {
    dist = distancesquared(self.origin, vehicle.origin);

    if(dist > squared(1500)) {
      continue;
    }

    if(self isinscriptedstate()) {
      continue;
    }

    currspeed = vehicle vehicle_getspeed();

    if(currspeed < 5) {
      continue;
    }

    var_1d652fb2ebe872f4 = max(int(currspeed * 70), 2000);

    if(dist < squared(var_1d652fb2ebe872f4)) {
      var_2e5bc4f60ff0a001 = within_fov(vehicle.origin, vehicle.angles, self.origin, cos_10);
      velocity = vehicle vehicle_getvelocity();
      fwd = anglesToForward(vehicle.angles);
      dot = vectordot(velocity, fwd);

      if(dot < 0) {
        continue;
      }

      if(!var_2e5bc4f60ff0a001) {
        continue;
      }

      valid_vehicles[valid_vehicles.size] = vehicle;
    }
  }

  return valid_vehicles;
}

function function_823f69bc9733f183() {
  player_vehicles = [];
  closest_vehicle = undefined;

  foreach(player in level.players) {
    if(!isDefined(player.vehicle)) {
      continue;
    }

    player_vehicles[player_vehicles.size] = player.vehicle;
  }

  allvehicles = array_combine(player_vehicles, level.var_6e5ff6cae14c4081);
  allvehicles = array_removeundefined(allvehicles);
  return allvehicles;
}

function function_e7fc2021e96eb2f9() {
  self setcanusecover(0);
  utility::demeanor_override("sprint");
  self.og_ignoreall = self.ignoreall;
  self.og_radius = self.goalradius;
  self.ignoreall = 1;
  self allowedstances("stand");
  self.goalradius = 12;
}

function function_c83e8b49e55a092() {
  utility::clear_demeanor_override();
  self.ignoreall = self.og_ignoreall;
  self.goalradius = self.og_radius;
  self allowedstances("stand", "crouch", "prone");
  self setcanusecover(1);
}

function function_c0f7c5e411992612(dodge_type, closest_vehicle) {
  currspeed = closest_vehicle vehicle_getspeed();
  spot_right = self.origin + (0, 0, 5) + anglestoleft(closest_vehicle.angles) * 200;
  trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 60), spot_right, self);
  var_e06d1f8af320925 = trace["fraction"] == 1;
  spot_left = self.origin + (0, 0, 5) + anglestoright(closest_vehicle.angles) * 200;
  trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 60), spot_left, self);
  var_5149d2dd057854d0 = trace["fraction"] == 1;

  if(!var_e06d1f8af320925 && !var_5149d2dd057854d0) {
    return dodge_type;
  }

  if(var_e06d1f8af320925 && var_5149d2dd057854d0) {
    dir = vectorNormalize((closest_vehicle.origin - self.origin) * (1, 1, 0));
    fwd = anglestoright(closest_vehicle.angles);
    dot = vectordot(dir, fwd);

    if(currspeed > 30) {
      dodge_type = "dive_left";
    } else {
      dodge_type = "juke_left";
    }

    if(dot < 0) {
      if(currspeed > 30) {
        dodge_type = "dive_right";
      } else {
        dodge_type = "juke_right";
      }
    }
  } else {
    if(currspeed > 30) {
      dodge_type = "dive_right";
    } else {
      dodge_type = "juke_right";
    }

    if(var_5149d2dd057854d0) {
      if(currspeed > 30) {
        dodge_type = "dive_left";
      } else {
        dodge_type = "juke_left";
      }
    }
  }

  return dodge_type;
}

function function_a6d375b860cefd56() {
  self endon("death");
  level endon("obj_scene_started");
  waitframe();

  while(!isDefined(self.riders)) {
    wait 0.5;
  }

  self.gunner = get_gunner();

  while(!isDefined(self.gunner)) {
    self.gunner = get_gunner();
    wait 0.1;
  }

  self.gunner give_soldier_armor();
  self.gunner give_soldier_helmet();
  self.gunner.allowpain = 0;
  self.gunner.equip_armor = 1;
  self.gunner.armor_health = 600;
  self.gunner.isgunner = 1;

  while(!isDefined(self.mgturret)) {
    waitframe();
  }

  turret = self.mgturret[0];
  turret makeunusable();
  self.gunner.vehicle = self;
  self.gunner waittill("death");

  if(isDefined(turret)) {
    turret cleartargetentity();
    turret setmode("sentry_offline");
  }

  if(isDefined(self.turret_pointer)) {
    self.turret_pointer delete();
  }

  wait 0.75;
  self notify("gunner_defeated");
}

function private get_gunner() {
  foreach(rider in self.riders) {
    if(rider.vehicle_position == 5) {
      return rider;
    }
  }

  return undefined;
}

function private technical_gunner_custom_death() {
  function_82a45e8aef44ce3f(undefined);
  scripts\asm\soldier\vehicle::playanim_vehicledeath(self.asmname, "vehicle_death");
  return true;
}

function function_bd89bc6288ef7f9b() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  ent_flag_init("turret_investigate_pos_updated");

  while(!isDefined(self.mgturret)) {
    if(isDefined(self.turrets) && isDefined(self.turrets["iw9_mg_jltv_mp"])) {
      self.mgturret = [];
      self.mgturret[0] = self.turrets["iw9_mg_jltv_mp"];
    }

    waitframe();
  }

  turret = self.mgturret[0];
  turret.ownervehicle = self;
  turret setmode("manual");
  turret endon("death");
  turret settoparc(25);
  turret setbottomarc(25);
  self.spotlight = spawn("script_model", turret gettagorigin("tag_aim_animated"));
  self.spotlight setModel("tag_origin");
  self.spotlight linkTo(turret, "tag_aim_animated", (0, 0, 0), (0, 0, 0));
  thread delete_on_death(self.spotlight);
  self.spotlight.tag = spawn_tag_origin(self.spotlight.origin, self.spotlight.angles);
  self.spotlight.tag linkTo(self.spotlight, "tag_origin", (7.5, -3.5, 2.5), (0, 0, 0));
  thread delete_on_death(self.spotlight.tag);
  self.turret_pointer = spawn_script_origin(self.origin - 500 * anglesToForward(self.angles));
  turret settargetentity(self.turret_pointer);
  thread delete_on_death(self.turret_pointer);
  level.technical_spotlight_targets = getStructArray("technical_spotlight_target", "targetname");
  search_side = 1;

  foreach(player in level.players) {
    childthread turret_spotted_ent_think(player);
  }

  while(true) {
    wait 0.2;

    if(!isalive(self.gunner)) {
      continue;
    }

    if(self.var_807a9ed6606103de ent_flag("weapons_free")) {
      turret setleftarc(180);
      turret setrightarc(180);
      turret setconvergencetime(2, "yaw");
      turret setconvergencetime(2, "pitch");
      childthread turret_aim_think();
      turret childthread turret_shoot_think();
      self.gunner waittill_any_timeout_2(10, "stealth_hunt", "death");
      turret notify("stop_turret_shoot_think");
      turret cleartargetentity();
      continue;
    }

    if(isDefined(self.turret_investigate_pos)) {
      if(gettime() - self.turret_investigate_pos_time > 3000) {
        self.turret_investigate_pos = undefined;
        self.turret_investigate_pos_time = undefined;
      } else if(ent_flag("turret_investigate_pos_updated")) {
        turret setleftarc(180);
        turret setrightarc(180);
        turret setconvergencetime(4, "yaw");
        turret setconvergencetime(4, "pitch");
        update_turret_pointer(self.turret_investigate_pos);
        ent_flag_clear("turret_investigate_pos_updated");
      }

      continue;
    }

    success = turret_sweep(turret, search_side, 5);

    if(istrue(success)) {
      search_side *= -1;
    }
  }
}

function private update_turret_pointer(pos) {
  if(!isDefined(self.turret_pointer)) {
    self.turret_pointer = spawn_script_origin(pos);
  } else {
    self.turret_pointer.origin = pos;
  }

  self.mgturret[0] settargetentity(self.turret_pointer);
}

function private turret_aim_think() {
  self.gunner endon("stealth_hunt");
  self.gunner endon("death");
  last_known_pos = undefined;
  self.var_f9374a64ef9c64ec = undefined;
  var_2d1996a1afa79192 = 0;
  aim_offset = (0, 0, 0);
  ignore_array = [self.mgturret[0], self.gunner];
  ignore_array = array_combine(ignore_array, level.players);

  while(true) {
    waitframe();

    if(!isDefined(level.players) || level.players.size == 0) {
      continue;
    }

    self.mgturret[0].var_f9374a64ef9c64ec = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(self.mgturret[0].var_f9374a64ef9c64ec)) {
      continue;
    }

    if(!is_equal(self.gunner.enemy, self.mgturret[0].var_f9374a64ef9c64ec)) {
      continue;
    }

    if(gettime() - self.gunner lastknowntime(self.mgturret[0].var_f9374a64ef9c64ec) > 10000) {
      continue;
    }

    if(is_equal(self.gunner lastknownpos(self.mgturret[0].var_f9374a64ef9c64ec), last_known_pos)) {
      continue;
    }

    last_known_pos = self.gunner lastknownpos(self.mgturret[0].var_f9374a64ef9c64ec);

    if(gettime() > var_2d1996a1afa79192) {
      start_origin = self.mgturret[0] gettagorigin("tag_aim");
      eye_offset = self.mgturret[0].var_f9374a64ef9c64ec getEye() - self.mgturret[0].var_f9374a64ef9c64ec.origin - (0, 0, 10);

      if(scripts\engine\trace::ray_trace_passed(start_origin, last_known_pos, ignore_array)) {
        aim_offset = (0, 0, 0);
      } else if(scripts\engine\trace::ray_trace_passed(start_origin, last_known_pos + eye_offset, ignore_array)) {
        aim_offset = eye_offset;
      } else if(scripts\engine\trace::ray_trace_passed(start_origin, last_known_pos + eye_offset / 2, ignore_array)) {
        aim_offset = eye_offset / 2;
      }

      var_2d1996a1afa79192 = gettime() + 1000;
    }

    aim_pos = last_known_pos + aim_offset;

    if(distancesquared(aim_pos, self.origin) < 40000 && !self.mgturret[0] turretcantarget(aim_pos)) {
      aim_origin = self.origin;
      aim_fwd = flatten_vector(aim_pos - aim_origin);
      aim_pos = aim_origin + aim_fwd * 500;
    }

    update_turret_pointer(aim_pos);
  }
}

function private turret_shoot_think() {
  self notify("stop_turret_shoot_think");
  self endon("stop_turret_shoot_think");
  gunner = self.ownervehicle.gunner;

  while(!gunner_can_shoot_player(gunner)) {
    waitframe();
  }

  while(true) {
    waitframe();

    if(!isDefined(self.var_f9374a64ef9c64ec)) {
      continue;
    }

    if(!is_equal(gunner.enemy, self.var_f9374a64ef9c64ec)) {
      continue;
    }

    if(gettime() - gunner lastknowntime(self.var_f9374a64ef9c64ec) > 10000) {
      continue;
    }

    if(isDefined(self.ownervehicle.turret_pointer)) {
      if(!self turretcantarget(self.ownervehicle.turret_pointer.origin)) {
        continue;
      }
    }

    start_origin = self gettagorigin("tag_flash");
    start_angles = self gettagangles("tag_flash");
    target_origin = gunner lastknownpos(self.var_f9374a64ef9c64ec);

    if(!turret_aimed_at_last_known(start_origin, start_angles, target_origin)) {
      continue;
    }

    if(distance2dsquared(self.origin, target_origin) > squared(3000)) {
      continue;
    }

    trace = scripts\engine\trace::ray_trace(start_origin, start_origin + anglesToForward(start_angles) * 3000, self);
    hit_ent = trace["entity"];

    if(isDefined(hit_ent) && (hit_ent == self.ownervehicle || is_equal(hit_ent.team, "axis"))) {
      continue;
    }

    for(i = 0; i < 10; i++) {
      self shootturret("tag_flash");
      level notify("technical_hot_event", gunner);
      wait 0.1;
    }

    wait 1;

    while(!gunner_can_shoot_player(gunner)) {
      waitframe();
    }
  }
}

function private gunner_can_shoot_player(gunner) {
  if(!isDefined(self.var_f9374a64ef9c64ec)) {
    return false;
  }

  if(gunner cansee(self.var_f9374a64ef9c64ec)) {
    return true;
  }

  last_known_time = gunner lastknowntime(self.var_f9374a64ef9c64ec);

  if(!isDefined(last_known_time)) {
    return false;
  }

  if(gettime() - last_known_time > 10000) {
    return false;
  }

  last_known_pos = gunner lastknownpos(self.var_f9374a64ef9c64ec);

  if(!isDefined(last_known_pos)) {
    return false;
  }

  if(!turret_aimed_at_last_known(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), last_known_pos)) {
    return false;
  }

  if(distancesquared(last_known_pos, self.var_f9374a64ef9c64ec.origin) > 16384) {
    return false;
  }

  return true;
}

function private turret_aimed_at_last_known(start_origin, start_angles, var_c74e2e565ee3fe18) {
  if(!isDefined(self.var_f9374a64ef9c64ec)) {
    return false;
  }

  if(within_fov(start_origin, start_angles, var_c74e2e565ee3fe18, 0.7)) {
    return true;
  }

  eye_offset = self.var_f9374a64ef9c64ec getEye() - self.var_f9374a64ef9c64ec.origin;

  if(within_fov(start_origin, start_angles, var_c74e2e565ee3fe18 + eye_offset, 0.7)) {
    return true;
  }

  if(within_fov(start_origin, start_angles, var_c74e2e565ee3fe18 + eye_offset / 2, 0.7)) {
    return true;
  }

  return false;
}

function private turret_spotted_ent_think(ent) {
  ent endon("stop_turret_spotted_ent_think");
  ent endon("disconnect");
  frames_seen = 0;

  while(true) {
    if(!isDefined(ent)) {
      return;
    }

    while(isalive(self.gunner) && turret_is_on_ent(ent, 10)) {
      frames_seen++;

      if(frames_seen >= 3) {
        if(isPlayer(ent)) {
          if(getdvarint(@ "hash_94c7e87afc7912c4")) {
            iprintln("<dev string:xaf>");
          }

          if(!is_equal(self.turret_investigate_pos, ent.origin)) {
            update_turret_investigate_pos(ent.origin);
          }
        } else {
          return;
        }
      }

      waitframe();
    }

    if(frames_seen > 0) {
      frames_seen = 0;
    }

    waitframe();
  }
}

function private turret_is_on_ent(ent, fov) {
  if(distance2dsquared(self.origin, ent.origin) > 4000000) {
    return false;
  }

  origin = ent.origin;

  if(isPlayer(ent)) {
    origin = ent getEye();
  } else {
    origin = ent.origin;
  }

  turret = self.mgturret[0];
  start = turret gettagorigin("tag_flash");
  angles = turret gettagangles("tag_flash");

  if(within_fov(start, angles, origin, cos(fov))) {
    if(self.gunner cansee(ent)) {
      if(getdvarint(@ "hash_94c7e87afc7912c4")) {
        thread draw_line_for_time(start, origin, 0, 1, 0, 0.05);
      }

      return true;
    }

    if(getdvarint(@ "hash_94c7e87afc7912c4")) {
      thread draw_line_for_time(start, origin, 1, 0, 0, 0.05);
    }
  }

  return false;
}

function private update_turret_investigate_pos(pos) {
  ent_flag_set("turret_investigate_pos_updated");
  self.turret_investigate_pos = pos;
  self.turret_investigate_pos_time = gettime();
}

function private turret_sweep(turret, search_side, sweep_time) {
  self endon("death");
  self endon("turret_investigate_pos_updated");
  self.gunner endon("death");
  self.gunner endon("stealth_combat");
  turret setconvergencetime(sweep_time, "yaw");
  turret setconvergencetime(sweep_time, "pitch");
  turret setleftarc(180);
  turret setrightarc(180);
  closest_targets = get_array_of_closest(self.origin, level.technical_spotlight_targets, undefined, undefined, 4000);
  valid_targets = [];
  right_dir = anglestoright(self.angles);
  var_a02118632c7f1621 = getStructArray("defender_hardpoint", "script_noteworthy");
  var_6b84f2ec187b1c4d = getclosest(self.origin, var_a02118632c7f1621, 1500);

  if(isDefined(var_6b84f2ec187b1c4d)) {
    dir = vectorNormalize(var_6b84f2ec187b1c4d.origin - self.origin);
    dot = vectordot(right_dir, dir);
    search_side = dot;
  }

  foreach(target in closest_targets) {
    dir = vectorNormalize(target.origin - self.origin);
    dot = vectordot(right_dir, dir);

    if(dot * search_side <= 0) {
      continue;
    }

    if(!turret turretcantarget(target.origin)) {
      continue;
    }

    valid_targets[valid_targets.size] = target;
  }

  best_target = undefined;

  foreach(player in level.players) {
    dir = vectorNormalize(player.origin - self.origin);
    dot = vectordot(right_dir, dir);

    if(dot * search_side > 0) {
      best_target = getclosest(player.origin, valid_targets);
      continue;
    }

    best_target = scripts\cp\utility::getfarthest(player.origin, valid_targets);
  }

  if(!isDefined(best_target)) {
    return false;
  }

  update_turret_pointer(best_target.origin);
  waittill_technical_turns_or_timeout(sweep_time + 2);
  return true;
}

function private waittill_technical_turns_or_timeout(timeout) {
  og_forward = anglesToForward(self.angles);
  timeout_time = gettime() + timeout * 1000;

  while(gettime() < timeout_time) {
    waitframe();
    forward = anglesToForward(self.angles);
    dot = vectordot(og_forward, forward);

    if(dot < 0.5) {
      break;
    }
  }
}

function function_362f719b447aba3f(type, pos, ang, tier, var_cb1e30930c35f2e2) {
  if(!isDefined(tier)) {
    tier = 1;
  }

  if(!isDefined(ang)) {
    ang = (0, 0, 0);
  }

  aitype = undefined;

  if(type == "juggernaut") {
    aitype = "jugg_aq";
  } else {
    aitype = type + "_t" + tier;

    if(istrue(var_cb1e30930c35f2e2)) {
      aitype += "_nvg_aq";
    } else {
      aitype += "_aq";
    }
  }

  if(!isDefined(aitype)) {
    assertmsg("unknown aitype: " + type);
    return undefined;
  }

  struct = spawnStruct();
  struct.origin = pos;
  struct.angles = ang;
  struct.script_aitype = aitype;
  return scripts\cp\cp_spawning_util::ai_spawngroup(struct, 1);
}