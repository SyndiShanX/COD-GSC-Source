/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_spawn_manager.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

spawn_manager_main() {
  level.spawn_manager_max_frame_spawn = 3;
  level.spawn_manager_total_count = 0;
  level.spawn_manager_max_ai = 24;
  level.spawn_manager_active_ai = 0;
  level.spawn_manager_auto_targetname_num = 0;
  level thread spawn_manager_throttle_think();
  level.spawn_managers = [];
  trigger_spawn_manager_setup();
  array_func(getEntArray("spawn_manager", "classname"), ::spawn_manager_create_spawn_manager_struct);
  array_thread(level.spawn_managers, ::spawn_manager_think);
  start_triggers("trigger_multiple");
  start_triggers("trigger_once");
  start_triggers("trigger_use");
  start_triggers("trigger_radius");
  start_triggers("trigger_lookat");
  start_triggers("trigger_damage");
}
trigger_spawn_manager_setup() {
  trigger_types = [];
  trigger_types[trigger_types.size] = "trigger_multiple";
  trigger_types[trigger_types.size] = "trigger_once";
  trigger_types[trigger_types.size] = "trigger_radius";
  trigger_types[trigger_types.size] = "trigger_lookat";
  for(i = 0; i < trigger_types.size; i++) {
    triggers = getEntArray(trigger_types[i], "classname");
    for(j = 0; j < triggers.size; j++) {
      trigger = triggers[j];
      if(trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_SPAWN_MANAGER)) {
        trigger_spawn_manager_create(trigger);
      }
    }
  }
}
trigger_spawn_manager_create(trigger) {
  ents = undefined;
  AssertEx(isDefined(trigger.target), "Trigger at " + trigger.origin + " is a spawn manager type ( TRIGGER_SPAWN_MANAGER ) but does not target any spawners");
  ents = getEntArray(trigger.target, "targetname");
  for(i = 0; i < ents.size; i++) {
    ent = ents[i];
    AssertEx(ent.classname != "spawn_manager", "Trigger at " + trigger.origin + " is a spawn manager type ( TRIGGER_SPAWN_MANAGER ) and also targetting a spawn manager " + ent.targetname);
    AssertEx(IsSubStr(ent.classname, "actor"), "Trigger at " + trigger.origin + " is a spawn manager type ( TRIGGER_SPAWN_MANAGER ) but targets a non-actor entity");
  }
  spawn_manager_create_spawn_manager_struct(trigger);
}
spawn_manager_create_spawn_manager_struct(from_ent) {
  if(!isDefined(from_ent)) {
    from_ent = self;
  }
  spawn_manager_ent = spawnStruct();
  spawn_manager_ent.script_noteworthy = "spawn_manager";
  IsTrigger = IsSubStr(tolower(from_ent.classname), "trigger");
  if(!isDefined(from_ent.targetname)) {
    from_ent.targetname = generate_targetname();
  }
  spawn_manager_ent.targetname = from_ent.targetname;
  spawn_manager_ent.target = from_ent.target;
  if(IsTrigger) {
    from_ent.target = spawn_manager_ent.targetname;
  }
  if(isDefined(from_ent.script_wait)) {
    spawn_manager_ent.script_wait = from_ent.script_wait;
  }
  if(isDefined(from_ent.script_wait_min)) {
    spawn_manager_ent.script_wait_min = from_ent.script_wait_min;
  }
  if(isDefined(from_ent.script_wait_max)) {
    spawn_manager_ent.script_wait_max = from_ent.script_wait_max;
  }
  if(isDefined(from_ent.script_delay)) {
    spawn_manager_ent.script_delay = from_ent.script_delay;
  }
  if(isDefined(from_ent.script_delay_min)) {
    spawn_manager_ent.script_delay_min = from_ent.script_delay_min;
  }
  if(isDefined(from_ent.script_delay_max)) {
    spawn_manager_ent.script_delay_max = from_ent.script_delay_max;
  }
  if(isDefined(from_ent.sm_count)) {
    spawn_manager_ent.sm_count = from_ent.sm_count;
  }
  if(isDefined(from_ent.count)) {
    spawn_manager_ent.count = from_ent.count;
  }
  if(isDefined(from_ent.sm_active_count)) {
    spawn_manager_ent.sm_active_count = from_ent.sm_active_count;
  }
  if(isDefined(from_ent.sm_group_size)) {
    spawn_manager_ent.sm_group_size = from_ent.sm_group_size;
  }
  if(isDefined(from_ent.sm_spawner_count)) {
    spawn_manager_ent.sm_spawner_count = from_ent.sm_spawner_count;
  }
  if(isDefined(from_ent.sm_die)) {
    spawn_manager_ent.sm_die = from_ent.sm_die;
  }
  if(isDefined(from_ent.script_next_spawn_manager)) {
    spawn_manager_ent.script_next_spawn_manager = from_ent.script_next_spawn_manager;
  }
  if(isDefined(from_ent.targetname)) {
    spawn_manager_ent.sm_id = from_ent.targetname;
  }
  if(!IsTrigger) {
    from_ent delete();
  }
  level.spawn_managers[level.spawn_managers.size] = spawn_manager_ent;
  return spawn_manager_ent;
}
generate_targetname() {
  targetname = "sm_auto_" + level.spawn_manager_auto_targetname_num;
  level.spawn_manager_auto_targetname_num++;
  return targetname;
}
spawn_manager_setup() {
  Assert(isDefined(self));
  Assert(isDefined(self.target));
  if(!isDefined(self.sm_group_size)) {
    self.sm_group_size = 1;
  }
  self.sm_group_size_min = get_min_value(self.sm_group_size);
  self.sm_group_size_max = get_max_value(self.sm_group_size);
  AssertEx(self.sm_group_size_max >= self.sm_group_size_min, "Max range should be greater or equal to the min value for sm_count on spawn manager " + self.sm_id);
  if(!isDefined(self.sm_spawner_count)) {
    self.sm_spawner_count = self.allSpawners.size;
  }
  self.sm_spawner_count_min = get_min_value(self.sm_spawner_count);
  self.sm_spawner_count_max = get_max_value(self.sm_spawner_count);
  AssertEx(self.sm_spawner_count_max >= self.sm_spawner_count_min, "Max range should be greater or equal to the min value for sm_count on spawn manager " + self.sm_id);
  self.sm_spawner_count = spawn_manager_random_count(self.sm_spawner_count_min, self.sm_spawner_count_max + 1);
  self calculate_count();
  if(!isDefined(self.sm_active_count)) {
    self.sm_active_count = self.allSpawners.size;
    if(self.sm_active_count < self.sm_group_size_max) {
      self.sm_active_count = self.sm_group_size_max;
    }
  }
  self.sm_active_count_min = get_min_value(self.sm_active_count);
  self.sm_active_count_max = get_max_value(self.sm_active_count);
  if(self.sm_active_count_min < self.sm_group_size_max) {
    AssertEx(self.sm_active_count_max >= self.sm_group_size_max, "Max active count should be greater or equal to the max value for sm_group_size on spawn manager trigger with targetname " + self.targetname);
    self.sm_active_count_min = self.sm_group_size_max;
  }
  AssertEx(self.sm_active_count_max >= self.sm_active_count_min, "Max range should be greater or equal to the min value for sm_active_count on spawn manager trigger with targetname " + self.targetname);
  self.sm_active_count = spawn_manager_random_count(self.sm_active_count_min, self.sm_active_count_max + 1);
  if(!isDefined(self.script_forcespawn)) {
    self.script_forcespawn = 0;
  }
  self.spawners = self spawn_manager_get_spawners();
  Assert(self.count >= self.count_min);
  Assert(self.count <= self.count_max);
  Assert(self.sm_active_count >= self.sm_active_count_min);
  Assert(self.sm_active_count <= self.sm_active_count_max);
  Assert(self.sm_group_size_max <= self.sm_active_count);
  Assert(self.sm_group_size_min <= self.sm_active_count);
}
spawn_manager_can_spawn(spawnGroupSize) {
  totalFree = self.count - self.spawnCount;
  activeFree = self.sm_active_count - self.activeAI.size;
  canSpawnGroup = (activeFree >= spawnGroupSize) &&
    (totalFree >= spawnGroupSize) &&
    (spawnGroupSize > 0);
  globalFree = level.spawn_manager_max_ai - level.spawn_manager_active_ai;
  AssertEx(self.enable == flag("sm_" + self.sm_id + "_enabled"), "Spawn manager flags should not be set by the level script.");
  if(self.script_forcespawn == 0) {
    return (totalFree > 0) &&
      (activeFree > 0) &&
      (globalFree > 0) &&
      canSpawnGroup &&
      self.enable;
  } else {
    return (totalFree > 0) &&
      (activeFree > 0) &&
      self.enable;
  }
}
spawn_manager_spawn(maxDelay) {
  self endon("death");
  start = GetTime();
  for(;;) {
    while(level.spawn_manager_frame_spawns >= level.spawn_manager_max_frame_spawn || level.spawn_manager_active_ai >= level.spawn_manager_max_ai) {
      level waittill("spawn_manager_throttle_reset");
    }
    ai = self spawn_ai();
    if(!spawn_failed(ai)) {
      ai maps\_names::get_name();
      return ai;
    } else if((gettime() - start) > (1000 * maxDelay)) {
      return ai;
    }
    wait(0.05);
  }
}
spawn_manager_spawn_group(manager, spawner, spawnGroupSize) {
  spawn_count = 0;
  for(i = 0; i < spawnGroupSize; i++) {
    ai = undefined;
    if(isDefined(spawner) && isDefined(spawner.targetname)) {
      ai = spawner spawn_manager_spawn(2.0);
    } else {
      continue;
    }
    if(!spawn_failed(ai)) {
      spawn_count++;
      level.spawn_manager_frame_spawns += 1;
      if(isDefined(self.script_radius)) {
        ai.script_radius = self.script_radius;
      }
      if(isDefined(spawner.script_radius)) {
        ai.script_radius = spawner.script_radius;
      }
      ai thread spawn_accounting(spawner, self);
    }
    if(spawn_count == spawnGroupSize) {
      wait(.05);
    }
  }
}
spawn_accounting(spawner, manager) {
  targetname = manager.targetname;
  classname = spawner.classname;
  level.spawn_manager_total_count += 1;
  manager.spawnCount += 1;
  level.spawn_manager_active_ai += 1;
  origin = spawner.origin;
  manager.activeAI[manager.activeAI.size] = self;
  spawner.activeAI[spawner.activeAI.size] = self;
  self waittill("death");
  if(isDefined(spawner)) {
    spawner.activeAI = array_remove_nokeys(spawner.activeAI, self);
  }
  if(isDefined(manager)) {
    manager.activeAI = array_remove_nokeys(manager.activeAI, self);
  }
  level.spawn_manager_active_ai -= 1;
}
spawn_manager_think() {
  if(!isDefined(self.targetname)) {
    self.targetname = generate_targetname();
  }
  if(!isDefined(self.sm_id)) {
    self.sm_id = self.targetname;
  }
  self spawn_manager_flags_setup();
  self thread spawn_manager_enable_think();
  self thread spawn_manager_kill_think();
  self endon("kill");
  self.enable = false;
  self.activeAI = [];
  self.spawnCount = 0;
  isFirstTime = true;
  self.allSpawners = getEntArray(self.target, "targetname");
  AssertEx(self.allSpawners.size, "Spawn manager '" + self.sm_id + "' doesn't target any spawners.");
  self waittill("enable");
  script_delay();
  self spawn_manager_setup();
  while(self.spawnCount < self.count && self.spawners.size > 0) {
    self spawn_manager_get_spawn_group_size();
    if(self.sm_group_size + self.spawnCount > self.count) {
      self.sm_group_size = self.count - self.spawnCount;
    }
    spawned = false;
    while(!spawned) {
      cleanup_spawners();
      if(self.spawners.size <= 0) {
        break;
      }
      if(self spawn_manager_can_spawn(self.sm_group_size)) {
        Assert(self.sm_group_size > 0);
        potential_spawners = [];
        priority_spawners = [];
        for(i = 0; i < self.spawners.size; i++) {
          current_spawner = self.spawners[i];
          if(isDefined(current_spawner)) {
            spawnerFree = current_spawner.sm_active_count - current_spawner.activeAI.size;
            if(spawnerFree >= self.sm_group_size) {
              if(current_spawner has_spawnflag(level.SPAWNFLAG_ACTOR_SM_PRIORITY)) {
                priority_spawners[priority_spawners.size] = current_spawner;
              } else {
                potential_spawners[potential_spawners.size] = current_spawner;
              }
            }
          }
        }
        if(potential_spawners.size > 0 || priority_spawners.size > 0) {
          if(priority_spawners.size > 0) {
            spawner = random(priority_spawners);
          } else {
            spawner = random(potential_spawners);
          }
          Assert(isDefined(spawner.count));
          if(spawner.count < self.sm_group_size) {
            self.sm_group_size = spawner.count;
          }
          if(!isFirstTime) {
            spawn_manager_wait();
          } else {
            isFirstTime = false;
          }
          if(!self.enable) {
            continue;
          }
          self spawn_manager_spawn_group(self, spawner, self.sm_group_size);
          spawned = true;
        } else {
          spawner_max_active_count = 0;
          for(i = 0; i < self.spawners.size; i++) {
            current_spawner = self.spawners[i];
            if(isDefined(current_spawner)) {
              if(current_spawner.sm_active_count > spawner_max_active_count) {
                spawner_max_active_count = current_spawner.sm_active_count;
              }
            }
          }
          if(spawner_max_active_count < self.sm_group_size_max) {
            self.sm_group_size_max = spawner_max_active_count;
            self spawn_manager_get_spawn_group_size();
          }
        }
      }
      wait(0.05);
    }
    AssertEx(self.spawnCount <= self.count, "Spawn manager spawned more then the allowed AI's");
    wait(0.05);
    AssertEx(!flag("sm_" + self.sm_id + "_killed"), "Spawn manager flags should not be set by the level script.");
    AssertEx(!flag("sm_" + self.sm_id + "_complete"), "Spawn manager flags should not be set by the level script.");
    if(self.script_forcespawn == 0) {
      wait(maps\_laststand::player_num_in_laststand() / get_players().size * 8);
    }
  }
  self spawn_manager_flag_complete();
  self notify("kill");
}
spawn_manager_enable_think() {
  self endon("kill");
  for(;;) {
    self waittill("enable");
    self.enable = true;
    self spawn_manager_flag_enabled();
    self waittill("disable");
    self spawn_manager_flag_disabled();
  }
}
spawn_manager_enable_trigger_think(spawn_manager) {
  spawn_manager endon("enable");
  self waittill("trigger");
  spawn_manager notify("enable");
}
spawn_manager_kill_think() {
  self waittill("kill");
  if(isDefined(self.script_next_spawn_manager)) {
    spawn_manager_enable(self.script_next_spawn_manager);
  }
  self spawn_manager_flag_disabled();
  self spawn_manager_flag_killed();
  for(i = 0; i < self.allSpawners.size; i++) {
    if(isDefined(self.allSpawners[i])) {
      self.allSpawners[i] Delete();
    }
  }
  array_wait(self.activeAI, "death");
  self spawn_manager_flag_cleared();
  level.spawn_managers = array_remove(level.spawn_managers, self);
}
spawn_manager_kill_trigger_think() {
  assert(isDefined(self.sm_kill));
  sm_kill_ids = StrTok(self.sm_kill, ";");
  if(sm_kill_ids.size > 0) {
    self waittill("trigger");
    for(id_i = 0; id_i < sm_kill_ids.size; id_i++) {
      killspawner_num = Int(sm_kill_ids[id_i]);
      for(sm_i = 0; sm_i < level.spawn_managers.size; sm_i++) {
        if(killspawner_num != 0) {
          if(isDefined(level.spawn_managers[sm_i].sm_die) && (level.spawn_managers[sm_i].sm_die == killspawner_num)) {
            level.spawn_managers[sm_i] notify("kill");
          }
        } else if(level.spawn_managers[sm_i].sm_id == sm_kill_ids[id_i]) {
          level.spawn_managers[sm_i] notify("kill");
        }
      }
    }
  }
}
start_triggers(trigger_type) {
  triggers = getEntArray(trigger_type, "classname");
  for(i = 0; i < triggers.size; i++) {
    if(isDefined(triggers[i].sm_kill)) {
      triggers[i] thread spawn_manager_kill_trigger_think();
    }
    if(isDefined(triggers[i].target)) {
      targets = get_spawn_manager_array(triggers[i].target);
      sm_num = 0;
      if(targets.size > 0) {
        for(j = 0; j < targets.size; j++) {
          AssertEx(is_in_array(level.spawn_managers, targets[j]), "Spawn manager is found but doesnt exists in the level.spawn_managers");
          sm_num++;
          triggers[i] thread spawn_manager_enable_trigger_think(targets[j]);
          AssertEx(!(sm_num > 1), "Only one spawn manager can be triggered by a single trigger.");
        }
      }
    }
  }
}
spawn_manager_throttle_think() {
  for(;;) {
    level.spawn_manager_frame_spawns = 0;
    level notify("spawn_manager_throttle_reset");
    wait_network_frame();
  }
}
spawn_manager_random_count(min, max) {
  return RandomIntRange(min, max);
}
get_spawn_manager_array(targetname) {
  if(isDefined(targetname)) {
    spawn_manager_array = [];
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].targetname == targetname) {
        spawn_manager_array = array_add(spawn_manager_array, level.spawn_managers[i]);
      }
    }
    return spawn_manager_array;
  } else {
    return level.spawn_managers;
  }
}
spawn_manager_get_spawners() {
  self.allSpawners = array_removeUndefined(self.allSpawners);
  exclude = [];
  for(i = 0; i < self.allSpawners.size; i++) {
    if((isDefined(level._gamemode_norandomdogs)) && (self.allSpawners[i].classname == "actor_enemy_dog_sp")) {
      exclude = array_add(exclude, self.allSpawners[i]);
    }
    self.allSpawners[i] calculate_count();
  }
  self.allSpawners = array_exclude(self.allSpawners, exclude);
  spawner_count_with_min_active = 0;
  for(i = 0; i < self.allSpawners.size; i++) {
    self.allSpawners[i] spawner_calculate_active_count(self);
    if(self.allSpawners[i].sm_active_count_min >= self.sm_group_size_min) {
      spawner_count_with_min_active++;
    }
    if(!isDefined(self.allSpawners[i].activeAI)) {
      self.allSpawners[i].activeAI = [];
    }
  }
  AssertEx(spawner_count_with_min_active >= self.allSpawners.size, "On spawn manager '" + self.sm_id + "' with a min group size of " + self.sm_group_size_min + ", you must have all spawners with an active count of at least " + self.sm_group_size_min + ".");
  groupSpawners = self.allSpawners;
  spawner_count = self.sm_spawner_count;
  if(spawner_count > self.allSpawners.size) {
    spawner_count = self.allSpawners.size;
  }
  spawners = [];
  while(spawners.size < spawner_count) {
    spawner = random(groupSpawners);
    spawners = array_add(spawners, spawner);
    groupSpawners = array_remove_nokeys(groupSpawners, spawner);
  }
  return spawners;
}
spawner_calculate_active_count(spawn_manager) {
  if(!isDefined(self.sm_active_count)) {
    self.sm_active_count = level.spawn_manager_max_ai;
  }
  self.sm_active_count_min = get_min_value(self.sm_active_count);
  self.sm_active_count_max = get_max_value(self.sm_active_count);
  AssertEx(self.sm_active_count_max >= self.sm_active_count_min, "Max value should be greater or equal to the min value for the spawner's sm_active_count on spawn manager " + spawn_manager.sm_id);
  self.sm_active_count = RandomIntRange(self.sm_active_count_min, self.sm_active_count_max + 1);
}
spawn_manager_get_spawn_group_size() {
  if(self.sm_group_size_min < self.sm_group_size_max) {
    self.sm_group_size = RandomIntRange(self.sm_group_size_min, self.sm_group_size_max + 1);
  } else {
    self.sm_group_size = self.sm_group_size_min;
  }
  return self.sm_group_size;
}
cleanup_spawners() {
  spawners = [];
  for(i = 0; i < self.spawners.size; i++) {
    if(isDefined(self.spawners[i])) {
      if(self.spawners[i].count != 0) {
        spawners[spawners.size] = self.spawners[i];
      } else {
        self.spawners[i] delete();
      }
    }
  }
  self.spawners = spawners;
}
get_min_value(value) {
  values = strtok(value, " ");
  num_players = get_players();
  for(i = num_players.size - 1; i >= 0; i--) {
    if(isDefined(values[i])) {
      if(!isDefined(values[i + 1]) && i > 0) {
        return Int(values[i - 1]);
      } else {
        return Int(values[i]);
      }
    }
  }
  return undefined;
}
get_max_value(value) {
  values = strtok(value, " ");
  num_players = get_players();
  for(i = num_players.size; i >= 0; i--) {
    if(isDefined(values[i])) {
      return Int(values[i]);
    }
  }
  return undefined;
}
spawn_manager_sanity() {
  assert(self.activeAI.size <= self.sm_active_count);
  assert(self.spawnCount <= self.count);
}
spawn_manager_wait() {
  if(isDefined(self.script_wait)) {
    wait(self.script_wait);
    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    coop_scalar = 1;
    players = get_players();
    if(players.size == 2) {
      coop_scalar = 0.7;
    } else if(players.size == 3) {
      coop_scalar = 0.5;
    } else if(players.size == 4) {
      coop_scalar = 0.3;
    }
    diff = self.script_wait_max - self.script_wait_min;
    wait(RandomFloatrange(self.script_wait_min, self.script_wait_min + (diff * coop_scalar)));
    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }
}
spawn_manager_flags_setup() {
  flag_init("sm_" + self.sm_id + "_enabled");
  flag_init("sm_" + self.sm_id + "_complete");
  flag_init("sm_" + self.sm_id + "_killed");
  flag_init("sm_" + self.sm_id + "_cleared");
}
spawn_manager_flag_enabled() {
  AssertEx(!flag("sm_" + self.sm_id + "_enabled"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_enabled");
}
spawn_manager_flag_disabled() {
  self.enable = false;
  flag_clear("sm_" + self.sm_id + "_enabled");
}
spawn_manager_flag_killed() {
  AssertEx(!flag("sm_" + self.sm_id + "_killed"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_killed");
}
spawn_manager_flag_complete() {
  AssertEx(self.spawnCount <= self.count, "Spawn manager spawned more then the allowed AI's");
  AssertEx(!flag("sm_" + self.sm_id + "_complete"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_complete");
}
spawn_manager_flag_cleared() {
  AssertEx(!flag("sm_" + self.sm_id + "_cleared"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_cleared");
}
calculate_count() {
  if(!isDefined(self.sm_count)) {
    if(isDefined(self.count) && (self.count != 0)) {
      self.sm_count = self.count;
    } else {
      self.sm_count = 9999;
    }
  }
  self.count_min = get_min_value(self.sm_count);
  self.count_max = get_max_value(self.sm_count);
  if(isDefined(self.sm_id)) {
    AssertEx(self.count_max >= self.count_min, "Max range should be greater or equal to the min value for sm_count on spawn manager " + self.sm_id);
  } else {
    AssertEx(self.count_max >= self.count_min, "Max range should be greater or equal to the min value for sm_count on spawner with targetname " + self.targetname);
  }
  self.count = spawn_manager_random_count(self.count_min, self.count_max + 1);
}