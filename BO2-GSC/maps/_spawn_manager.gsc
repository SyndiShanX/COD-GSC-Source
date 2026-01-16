/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_spawn_manager.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_names;
#include maps\_laststand;

spawn_manager_main() {
  level.spawn_manager_max_frame_spawn = 3;
  level.spawn_manager_total_count = 0;
  level.spawn_manager_max_ai = 24;
  level.spawn_manager_active_ai = 0;
  level.spawn_manager_auto_targetname_num = 0;
  level thread spawn_manager_throttle_think();
  level.spawn_managers = [];
  trigger_spawn_manager_setup();
  array_func(getentarray("spawn_manager", "classname"), ::spawn_manager_create_spawn_manager_struct);
  array_thread(level.spawn_managers, ::spawn_manager_think);
  start_triggers();

  level thread spawn_manager_debug();
  level thread spawn_manager_debug_spawn_manager();
  level thread spawn_manager_debug_spawner_values();
}

trigger_spawn_manager_setup() {
  triggers = get_triggers("trigger_multiple", "trigger_once", "trigger_radius", "trigger_lookat", "trigger_box");

  for(j = 0; j < triggers.size; j++) {
    trigger = triggers[j];

    if(trigger has_spawnflag(512))
      trigger_spawn_manager_create(trigger);
  }
}

trigger_spawn_manager_create(trigger) {
  ents = undefined;
  assert(isDefined(trigger.target), "Trigger at " + trigger.origin + " is a spawn manager type ( TRIGGER_SPAWN_MANAGER ) but does not target any spawners");
  ents = getentarray(trigger.target, "targetname");

  for(i = 0; i < ents.size; i++) {
    ent = ents[i];
    assert(ent.classname != "spawn_manager", "Trigger at " + trigger.origin + " is a spawn manager type ( TRIGGER_SPAWN_MANAGER ) and also targetting a spawn manager " + ent.targetname);
    assert(issubstr(ent.classname, "actor"), "Trigger at " + trigger.origin + " is a spawn manager type ( TRIGGER_SPAWN_MANAGER ) but targets a non-actor entity");
  }

  spawn_manager_create_spawn_manager_struct(trigger);
}

spawn_manager_create_spawn_manager_struct(from_ent) {
  if(!isDefined(from_ent))
    from_ent = self;

  spawn_manager_ent = spawnstruct();
  spawn_manager_ent.script_noteworthy = "spawn_manager";
  is_trigger = issubstr(tolower(from_ent.classname), "trigger");

  if(!isDefined(from_ent.targetname))
    from_ent.targetname = generate_targetname();

  if(is_trigger || !isDefined(from_ent.name))
    spawn_manager_ent.sm_id = from_ent.targetname;
  else
    spawn_manager_ent.sm_id = from_ent.name;

  foreach(sm in level.spawn_managers) {
    if(sm.sm_id == spawn_manager_ent.sm_id) {
      assertmsg("Multiple spawn managers wi id '" + spawn_manager_ent.sm_id + "'! If they need to have the same targetname, use the 'name' KVP to make them unique.");

    }
  }

  spawn_manager_ent.targetname = from_ent.targetname;
  spawn_manager_ent.target = from_ent.target;

  if(is_trigger)
    from_ent.target = spawn_manager_ent.targetname;

  if(isDefined(from_ent.script_wait))
    spawn_manager_ent.script_wait = from_ent.script_wait;

  if(isDefined(from_ent.script_wait_min))
    spawn_manager_ent.script_wait_min = from_ent.script_wait_min;

  if(isDefined(from_ent.script_wait_max))
    spawn_manager_ent.script_wait_max = from_ent.script_wait_max;

  if(isDefined(from_ent.script_delay))
    spawn_manager_ent.script_delay = from_ent.script_delay;

  if(isDefined(from_ent.script_delay_min))
    spawn_manager_ent.script_delay_min = from_ent.script_delay_min;

  if(isDefined(from_ent.script_delay_max))
    spawn_manager_ent.script_delay_max = from_ent.script_delay_max;

  if(isDefined(from_ent.sm_count))
    spawn_manager_ent.sm_count = from_ent.sm_count;

  if(isDefined(from_ent.count))
    spawn_manager_ent.count = from_ent.count;

  if(isDefined(from_ent.sm_active_count))
    spawn_manager_ent.sm_active_count = from_ent.sm_active_count;

  if(isDefined(from_ent.sm_group_size))
    spawn_manager_ent.sm_group_size = from_ent.sm_group_size;

  if(isDefined(from_ent.sm_spawner_count))
    spawn_manager_ent.sm_spawner_count = from_ent.sm_spawner_count;

  if(isDefined(from_ent.sm_die))
    spawn_manager_ent.sm_die = from_ent.sm_die;

  if(isDefined(from_ent.script_next_spawn_manager))
    spawn_manager_ent.script_next_spawn_manager = from_ent.script_next_spawn_manager;

  if(!is_trigger)
    from_ent delete();

  level.spawn_managers[level.spawn_managers.size] = spawn_manager_ent;
}

generate_targetname() {
  targetname = "sm_auto_" + level.spawn_manager_auto_targetname_num;
  level.spawn_manager_auto_targetname_num++;
  return targetname;
}

spawn_manager_setup() {
  assert(isDefined(self));
  assert(isDefined(self.target));

  if(!isDefined(self.sm_group_size))
    self.sm_group_size = 1;

  self.sm_group_size_min = get_min_value(self.sm_group_size);
  self.sm_group_size_max = get_max_value(self.sm_group_size);
  assert(self.sm_group_size_max >= self.sm_group_size_min, "Max range should be greater or equal to the min value for sm_count on spawn manager " + self.sm_id);

  if(!isDefined(self.sm_spawner_count))
    self.sm_spawner_count = self.allspawners.size;

  self.sm_spawner_count_min = get_min_value(self.sm_spawner_count);
  self.sm_spawner_count_max = get_max_value(self.sm_spawner_count);
  assert(self.sm_spawner_count_max >= self.sm_spawner_count_min, "Max range should be greater or equal to the min value for sm_count on spawn manager " + self.sm_id);
  self.sm_spawner_count = spawn_manager_random_count(self.sm_spawner_count_min, self.sm_spawner_count_max + 1);
  self calculate_count();
  self.spawners = self spawn_manager_get_spawners();

  if(isDefined(self.sm_active_count)) {
    self.sm_active_count_min = get_min_value(self.sm_active_count);
    self.sm_active_count_max = get_max_value(self.sm_active_count);
  } else {
    self.sm_active_count_min = 0;
    self.sm_active_count_max = 0;

    foreach(spawner in self.spawners) {
      self.sm_active_count_min = self.sm_active_count_min + spawner.sm_active_count_min;
      self.sm_active_count_max = self.sm_active_count_max + spawner.sm_active_count_max;
    }
  }

  if(self.sm_active_count_min < self.sm_group_size_max) {
    assert(self.sm_active_count_max >= self.sm_group_size_max, "Max active count should be greater or equal to the max value for sm_group_size on spawn manager trigger with targetname " + self.targetname);
    self.sm_active_count_min = self.sm_group_size_max;
  }

  assert(self.sm_active_count_max >= self.sm_active_count_min, "Max range should be greater or equal to the min value for sm_active_count on spawn manager trigger with targetname " + self.targetname);
  self.sm_active_count = spawn_manager_random_count(self.sm_active_count_min, self.sm_active_count_max + 1);

  if(!isDefined(self.script_forcespawn))
    self.script_forcespawn = 0;

  assert(self.count >= self.count_min);
  assert(self.count <= self.count_max);
  assert(self.sm_active_count >= self.sm_active_count_min);
  assert(self.sm_active_count <= self.sm_active_count_max);
  assert(self.sm_group_size_max <= self.sm_active_count);
  assert(self.sm_group_size_min <= self.sm_active_count);
}

spawn_manager_can_spawn(spawngroupsize) {
  totalfree = self.count - self.spawncount;
  activefree = self.sm_active_count - self.activeai.size;
  canspawngroup = activefree >= spawngroupsize && totalfree >= spawngroupsize && spawngroupsize > 0;
  globalfree = level.spawn_manager_max_ai - level.spawn_manager_active_ai;
  assert(self.enable == flag("sm_" + self.sm_id + "_enabled"), "Spawn manager flags should not be set by the level script.");

  if(self.script_forcespawn == 0)
    return totalfree > 0 && activefree > 0 && globalfree > 0 && canspawngroup && self.enable;
  else
    return totalfree > 0 && activefree > 0 && self.enable;
}

spawn_manager_spawn(maxdelay) {
  self endon("death");
  start = gettime();

  for(;;) {
    while(level.spawn_manager_frame_spawns >= level.spawn_manager_max_frame_spawn || getaicount() >= level.spawn_manager_max_ai)
      level waittill("spawn_manager_throttle_reset");

    ai = self spawn_ai();

    if(!spawn_failed(ai)) {
      ai maps\_names::get_name();
      return ai;
    } else if(gettime() - start > 1000 * maxdelay)
      return ai;

    wait 0.05;
  }
}

spawn_manager_spawn_group(spawner, spawngroupsize) {
  spawn_count = 0;

  for(i = 0; i < spawngroupsize; i++) {
    ai = undefined;

    if(isDefined(spawner) && isDefined(spawner.targetname))
      ai = spawner spawn_manager_spawn(2.0);
    else
      continue;

    if(!spawn_failed(ai)) {
      spawn_count++;
      level.spawn_manager_frame_spawns = level.spawn_manager_frame_spawns + 1;

      if(isDefined(self.script_radius))
        ai.script_radius = self.script_radius;

      if(isDefined(spawner.script_radius))
        ai.script_radius = spawner.script_radius;

      ai thread spawn_accounting(spawner, self);
    }

    if(spawn_count == spawngroupsize)
      wait 0.05;
  }
}

spawn_accounting(spawner, manager) {
  targetname = manager.targetname;
  classname = spawner.classname;
  level.spawn_manager_total_count = level.spawn_manager_total_count + 1;
  manager.spawncount = manager.spawncount + 1;
  level.spawn_manager_active_ai = level.spawn_manager_active_ai + 1;
  origin = spawner.origin;
  manager.activeai[manager.activeai.size] = self;
  spawner.activeai[spawner.activeai.size] = self;
  self waittill("death");

  if(isDefined(spawner))
    arrayremovevalue(spawner.activeai, self);

  if(isDefined(manager))
    arrayremovevalue(manager.activeai, self);

  level.spawn_manager_active_ai = level.spawn_manager_active_ai - 1;
}

spawn_manager_think() {
  self spawn_manager_flags_setup();
  self thread spawn_manager_enable_think();
  self thread spawn_manager_kill_think();
  self endon("kill");
  self.enable = 0;
  self.activeai = [];
  self.spawncount = 0;
  isfirsttime = 1;
  self.allspawners = getentarray(self.target, "targetname");
  assert(self.allspawners.size, "Spawn manager '" + self.sm_id + "' doesn't target any spawners.");
  self waittill("enable");
  script_delay();
  self spawn_manager_setup();

  while(self.spawncount < self.count && self.spawners.size > 0) {
    self spawn_manager_get_spawn_group_size();

    if(self.sm_group_size + self.spawncount > self.count)
      self.sm_group_size = self.count - self.spawncount;

    spawned = 0;

    while(!spawned) {
      cleanup_spawners();

      if(self.spawners.size <= 0) {
        break;
      }

      if(self spawn_manager_can_spawn(self.sm_group_size)) {
        assert(self.sm_group_size > 0);
        potential_spawners = [];
        priority_spawners = [];

        for(i = 0; i < self.spawners.size; i++) {
          current_spawner = self.spawners[i];

          if(isDefined(current_spawner)) {
            spawnerfree = current_spawner.sm_active_count - current_spawner.activeai.size;

            if(spawnerfree >= self.sm_group_size) {
              if(current_spawner has_spawnflag(32)) {
                priority_spawners[priority_spawners.size] = current_spawner;
                continue;
              }

              potential_spawners[potential_spawners.size] = current_spawner;
            }
          }
        }

        if(potential_spawners.size > 0 || priority_spawners.size > 0) {
          if(priority_spawners.size > 0)
            spawner = random(priority_spawners);
          else
            spawner = random(potential_spawners);

          assert(isDefined(spawner.count));

          if(spawner.count < self.sm_group_size)
            self.sm_group_size = spawner.count;

          if(!isfirsttime)
            spawn_manager_wait();
          else
            isfirsttime = 0;

          if(!self.enable) {
            continue;
          }
          self spawn_manager_spawn_group(spawner, self.sm_group_size);
          spawned = 1;
        } else {
          spawner_max_active_count = 0;

          for(i = 0; i < self.spawners.size; i++) {
            current_spawner = self.spawners[i];

            if(isDefined(current_spawner)) {
              if(current_spawner.sm_active_count > spawner_max_active_count)
                spawner_max_active_count = current_spawner.sm_active_count;
            }
          }

          if(spawner_max_active_count < self.sm_group_size_max) {
            self.sm_group_size_max = spawner_max_active_count;
            self spawn_manager_get_spawn_group_size();
          }
        }
      }

      wait 0.05;
    }

    assert(self.spawncount <= self.count, "Spawn manager spawned more then the allowed AI's");
    wait 0.05;
    assert(!flag("sm_" + self.sm_id + "_killed"), "Spawn manager flags should not be set by the level script.");
    assert(!flag("sm_" + self.sm_id + "_complete"), "Spawn manager flags should not be set by the level script.");

    if(self.script_forcespawn == 0)
      wait(maps\_laststand::player_num_in_laststand() / get_players().size * 8);
  }

  self spawn_manager_flag_complete();
  self notify("kill");
}

spawn_manager_enable_think() {
  self endon("kill");

  for(;;) {
    self waittill("enable");
    self.enable = 1;
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

  if(isDefined(self.script_next_spawn_manager))
    spawn_manager_enable(self.script_next_spawn_manager);

  self spawn_manager_flag_disabled();
  self spawn_manager_flag_killed();

  for(i = 0; i < self.allspawners.size; i++) {
    if(isDefined(self.allspawners[i]))
      self.allspawners[i] delete();
  }

  array_wait(self.activeai, "death");
  self spawn_manager_flag_cleared();
  arrayremovevalue(level.spawn_managers, self);
}

spawn_manager_kill_trigger_think() {
  assert(isDefined(self.sm_kill));
  sm_kill_ids = strtok(self.sm_kill, ";");

  if(sm_kill_ids.size > 0) {
    self waittill("trigger");

    for(id_i = 0; id_i < sm_kill_ids.size; id_i++) {
      killspawner_num = int(sm_kill_ids[id_i]);

      for(sm_i = 0; sm_i < level.spawn_managers.size; sm_i++) {
        if(killspawner_num != 0) {
          if(isDefined(level.spawn_managers[sm_i].sm_die) && level.spawn_managers[sm_i].sm_die == killspawner_num)
            level.spawn_managers[sm_i] notify("kill");

          continue;
        }

        if(level.spawn_managers[sm_i].sm_id == sm_kill_ids[id_i])
          level.spawn_managers[sm_i] notify("kill");
      }
    }
  }
}

start_triggers(trigger_type) {
  triggers = get_triggers("trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage", "trigger_box");

  foreach(trig in triggers) {
    if(isDefined(trig.sm_kill))
      trig thread spawn_manager_kill_trigger_think();

    if(isDefined(trig.target)) {
      targets = get_spawn_manager_array(trig.target);

      foreach(target in targets)
      trig thread spawn_manager_enable_trigger_think(target);
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
  return randomintrange(min, max);
}

get_spawn_manager_array(targetname) {
  if(isDefined(targetname)) {
    spawn_manager_array = [];

    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].targetname == targetname)
        spawn_manager_array[spawn_manager_array.size] = level.spawn_managers[i];
    }

    return spawn_manager_array;
  } else
    return level.spawn_managers;
}

spawn_manager_get_spawners() {
  arrayremovevalue(self.allspawners, undefined);
  exclude = [];

  for(i = 0; i < self.allspawners.size; i++) {
    if(isDefined(level._gamemode_norandomdogs) && self.allspawners[i].classname == "actor_enemy_dog_sp")
      exclude[exclude.size] = self.allspawners[i];

    self.allspawners[i] calculate_count();
  }

  self.allspawners = array_exclude(self.allspawners, exclude);
  spawner_count_with_min_active = 0;

  for(i = 0; i < self.allspawners.size; i++) {
    self.allspawners[i] spawner_calculate_active_count(self);

    if(self.allspawners[i].sm_active_count_min >= self.sm_group_size_min)
      spawner_count_with_min_active++;

    if(!isDefined(self.allspawners[i].activeai))
      self.allspawners[i].activeai = [];
  }

  assert(spawner_count_with_min_active >= self.allspawners.size, "On spawn manager '" + self.sm_id + "' with a min group size of " + self.sm_group_size_min + ", you must have all spawners with an active count of at least " + self.sm_group_size_min + ".");
  groupspawners = self.allspawners;
  spawner_count = self.sm_spawner_count;

  if(spawner_count > self.allspawners.size)
    spawner_count = self.allspawners.size;

  spawners = [];

  while(spawners.size < spawner_count) {
    spawner = random(groupspawners);
    spawners[spawners.size] = spawner;
    arrayremovevalue(groupspawners, spawner);
  }

  return spawners;
}

spawner_calculate_active_count(spawn_manager) {
  if(!isDefined(self.sm_active_count))
    self.sm_active_count = level.spawn_manager_max_ai;

  self.sm_active_count_min = get_min_value(self.sm_active_count);
  self.sm_active_count_max = get_max_value(self.sm_active_count);
  assert(self.sm_active_count_max >= self.sm_active_count_min, "Max value should be greater or equal to the min value for the spawner's sm_active_count on spawn manager " + spawn_manager.sm_id);
  self.sm_active_count = randomintrange(self.sm_active_count_min, self.sm_active_count_max + 1);
}

spawn_manager_get_spawn_group_size() {
  if(self.sm_group_size_min < self.sm_group_size_max)
    self.sm_group_size = randomintrange(self.sm_group_size_min, self.sm_group_size_max + 1);
  else
    self.sm_group_size = self.sm_group_size_min;

  return self.sm_group_size;
}

cleanup_spawners() {
  spawners = [];

  for(i = 0; i < self.spawners.size; i++) {
    if(isDefined(self.spawners[i])) {
      if(self.spawners[i].count != 0) {
        spawners[spawners.size] = self.spawners[i];
        continue;
      }

      self.spawners[i] delete();
    }
  }

  self.spawners = spawners;
}

get_min_value(value) {
  values = strtok(value, " ");
  num_players = get_players();

  for(i = num_players.size - 1; i >= 0; i--) {
    if(isDefined(values[i])) {
      if(!isDefined(values[i + 1]) && i > 0)
        return int(values[i - 1]);
      else
        return int(values[i]);
    }
  }

  return undefined;
}

get_max_value(value) {
  values = strtok(value, " ");
  num_players = get_players();

  for(i = num_players.size; i >= 0; i--) {
    if(isDefined(values[i]))
      return int(values[i]);
  }

  return undefined;
}

spawn_manager_sanity() {
  assert(self.activeai.size <= self.sm_active_count);
  assert(self.spawncount <= self.count);
}

spawn_manager_wait() {
  if(isDefined(self.script_wait)) {
    wait(self.script_wait);

    if(isDefined(self.script_wait_add))
      self.script_wait = self.script_wait + self.script_wait_add;
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    coop_scalar = 1;
    players = get_players();

    if(players.size == 2)
      coop_scalar = 0.7;
    else if(players.size == 3)
      coop_scalar = 0.5;
    else if(players.size == 4)
      coop_scalar = 0.3;

    diff = self.script_wait_max - self.script_wait_min;
    wait(randomfloatrange(self.script_wait_min, self.script_wait_min + diff * coop_scalar));

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min = self.script_wait_min + self.script_wait_add;
      self.script_wait_max = self.script_wait_max + self.script_wait_add;
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
  assert(!flag("sm_" + self.sm_id + "_enabled"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_enabled");
}

spawn_manager_flag_disabled() {
  self.enable = 0;
  flag_clear("sm_" + self.sm_id + "_enabled");
}

spawn_manager_flag_killed() {
  assert(!flag("sm_" + self.sm_id + "_killed"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_killed");
}

spawn_manager_flag_complete() {
  assert(self.spawncount <= self.count, "Spawn manager spawned more then the allowed AI's");
  assert(!flag("sm_" + self.sm_id + "_complete"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_complete");
}

spawn_manager_flag_cleared() {
  assert(!flag("sm_" + self.sm_id + "_cleared"), "Spawn manager flags should not be set by the level script.");
  flag_set("sm_" + self.sm_id + "_cleared");
}

calculate_count() {
  if(!isDefined(self.sm_count)) {
    if(isDefined(self.count) && self.count != 0)
      self.sm_count = self.count;
    else
      self.sm_count = 9999;
  }

  self.count_min = get_min_value(self.sm_count);
  self.count_max = get_max_value(self.sm_count);

  if(isDefined(self.sm_id))
    assert(self.count_max >= self.count_min, "Max range should be greater or equal to the min value for sm_count on spawn manager " + self.sm_id);
  else
    assert(self.count_max >= self.count_min, "Max range should be greater or equal to the min value for sm_count on spawner with targetname " + self.targetname);

  self.count = spawn_manager_random_count(self.count_min, self.count_max + 1);
}

spawn_manager_debug() {
  if(getdvar(#"_id_D0470A59") != "1") {
    return;
  }
  for(;;) {
    managers = get_spawn_manager_array();
    manageractivecount = 0;
    managerpotentialspawncount = 0;
    level.debugactivemanagers = [];

    for(i = 0; i < managers.size; i++) {
      if(isDefined(managers[i]) && isDefined(managers[i].enable)) {
        if(managers[i].enable || !managers[i].enable && isDefined(managers[i].spawners)) {
          if(managers[i].count > managers[i].spawncount) {
            if(managers[i].enable && isDefined(managers[i].sm_active_count)) {
              manageractivecount = manageractivecount + 1;
              managerpotentialspawncount = managerpotentialspawncount + managers[i].sm_active_count;
            }

            level.debugactivemanagers[level.debugactivemanagers.size] = managers[i];
          }
        }
      }
    }

    spawn_manager_debug_hud_update(level.spawn_manager_active_ai, level.spawn_manager_total_count, level.spawn_manager_max_ai, manageractivecount, managerpotentialspawncount);
    wait 0.05;
  }

}

spawn_manager_debug_hud_update(active_ai, spawn_ai, max_ai, active_managers, potential_ai) {
  if(getdvar(#"_id_D0470A59") == "1") {
    if(!isDefined(level.spawn_manager_debug_hud_title)) {
      level.spawn_manager_debug_hud_title = newhudelem();
      level.spawn_manager_debug_hud_title.alignx = "left";
      level.spawn_manager_debug_hud_title.x = -75;
      level.spawn_manager_debug_hud_title.y = 40;
      level.spawn_manager_debug_hud_title.fontscale = 1.5;
      level.spawn_manager_debug_hud_title.color = (1, 1, 1);
    }

    if(!isDefined(level.spawn_manager_debug_hud))
      level.spawn_manager_debug_hud = [];

    level.spawn_manager_debug_hud_title settext("SPAWN MANAGER: Total AI: " + spawn_ai + "Active AI: " + active_ai + "/" + potential_ai + "Max AI: " + max_ai + "Active Managers: " + active_managers);

    for(i = 0; i < level.debugactivemanagers.size; i++) {
      if(!isDefined(level.spawn_manager_debug_hud[i])) {
        level.spawn_manager_debug_hud[i] = newhudelem();
        level.spawn_manager_debug_hud[i].alignx = "left";
        level.spawn_manager_debug_hud[i].x = -70;
        level.spawn_manager_debug_hud[i].fontscale = 1;
        level.spawn_manager_debug_hud[i].y = level.spawn_manager_debug_hud_title.y + (i + 1) * 15;
      }

      if(isDefined(level.current_debug_spawn_manager) && level.debugactivemanagers[i] == level.current_debug_spawn_manager) {
        if(!level.debugactivemanagers[i].enable)
          level.spawn_manager_debug_hud[i].color = vectorscale((0, 1, 0), 0.4);
        else
          level.spawn_manager_debug_hud[i].color = (0, 1, 0);
      } else if(level.debugactivemanagers[i].enable)
        level.spawn_manager_debug_hud[i].color = (1, 1, 1);
      else
        level.spawn_manager_debug_hud[i].color = vectorscale((1, 1, 1), 0.4);

      level.spawn_manager_debug_hud[i] settext("[" + level.debugactivemanagers[i].sm_id + "]" + " Count: " + level.debugactivemanagers[i].spawncount + "/" + level.debugactivemanagers[i].count + "(" + level.debugactivemanagers[i].count_min + "," + level.debugactivemanagers[i].count_max + ")" + " Active Count: " + level.debugactivemanagers[i].activeai.size + "/" + level.debugactivemanagers[i].sm_active_count + "(" + level.debugactivemanagers[i].sm_active_count_min + "," + level.debugactivemanagers[i].sm_active_count_max + ")" + " Group Size: " + level.debugactivemanagers[i].sm_group_size + "(" + level.debugactivemanagers[i].sm_group_size_min + "," + level.debugactivemanagers[i].sm_group_size_max + ")" + " Spawners: " + level.debugactivemanagers[i].spawners.size);
    }

    if(level.debugactivemanagers.size < level.spawn_manager_debug_hud.size) {
      for(i = level.debugactivemanagers.size; i < level.spawn_manager_debug_hud.size; i++) {
        if(isDefined(level.spawn_manager_debug_hud[i]))
          level.spawn_manager_debug_hud[i] destroy();
      }
    }
  }

  if(getdvar(#"_id_D0470A59") != "1") {
    if(isDefined(level.spawn_manager_debug_hud_title))
      level.spawn_manager_debug_hud_title destroy();

    if(isDefined(level.spawn_manager_debug_hud)) {
      for(i = 0; i < level.spawn_manager_debug_hud.size; i++) {
        if(isDefined(level.spawn_manager_debug_hud) && isDefined(level.spawn_manager_debug_hud[i]))
          level.spawn_manager_debug_hud[i] destroy();
      }

      level.spawn_manager_debug_hud = undefined;
    }
  }

}

spawn_manager_debug_spawn_manager() {
  wait_for_first_player();
  level.current_debug_spawn_manager = undefined;
  level.current_debug_spawn_manager_targetname = undefined;
  level.test_player = get_players()[0];
  current_spawn_manager_index = -1;
  old_spawn_manager_index = undefined;

  while(true) {
    if(getdvar(#"_id_D0470A59") != "1") {
      destroy_tweak_hud_elements();
      wait 0.05;
      continue;
    }

    if(isDefined(level.debugactivemanagers) && level.debugactivemanagers.size > 0) {
      if(current_spawn_manager_index == -1) {
        current_spawn_manager_index = 0;
        old_spawn_manager_index = 0;
      }

      if(level.test_player buttonpressed("BUTTON_LSHLDR")) {
        old_spawn_manager_index = current_spawn_manager_index;

        if(level.test_player buttonpressed("DPAD_UP")) {
          current_spawn_manager_index--;

          if(current_spawn_manager_index < 0)
            current_spawn_manager_index = 0;
        }

        if(level.test_player buttonpressed("DPAD_DOWN")) {
          current_spawn_manager_index++;

          if(current_spawn_manager_index > level.debugactivemanagers.size - 1)
            current_spawn_manager_index = level.debugactivemanagers.size - 1;
        }
      }

      if(isDefined(current_spawn_manager_index) && current_spawn_manager_index != -1) {
        if(isDefined(level.current_debug_spawn_manager) && isDefined(level.debugactivemanagers[current_spawn_manager_index])) {
          if(isDefined(old_spawn_manager_index) && old_spawn_manager_index == current_spawn_manager_index) {
            if(level.debugactivemanagers[current_spawn_manager_index].targetname != level.current_debug_spawn_manager_targetname) {
              for(i = 0; i < level.debugactivemanagers.size; i++) {
                if(level.debugactivemanagers[i].targetname == level.current_debug_spawn_manager_targetname) {
                  current_spawn_manager_index = i;
                  old_spawn_manager_index = i;
                }
              }
            }
          }
        }

        if(isDefined(level.debugactivemanagers[current_spawn_manager_index])) {
          level.current_debug_spawn_manager = level.debugactivemanagers[current_spawn_manager_index];
          level.current_debug_spawn_manager_targetname = level.debugactivemanagers[current_spawn_manager_index].targetname;
        }
      }

      if(isDefined(level.current_debug_spawn_manager))
        level.current_debug_spawn_manager spawn_manager_debug_spawn_manager_values_dpad();
    } else
      destroy_tweak_hud_elements();

    wait 0.25;
  }

}

spawn_manager_debug_spawner_values() {
  if(getdvar(#"_id_D0470A59") != "1") {
    return;
  }
  while(true) {
    if(isDefined(level.current_debug_spawn_manager)) {
      spawn_manager = level.current_debug_spawn_manager;

      if(isDefined(spawn_manager.spawners)) {
        for(i = 0; i < spawn_manager.spawners.size; i++) {
          current_spawner = spawn_manager.spawners[i];

          if(isDefined(current_spawner) && current_spawner.count > 0) {
            spawnerfree = current_spawner.sm_active_count - current_spawner.activeai.size;
            print3d(current_spawner.origin + vectorscale((0, 0, 1), 65.0), "count:" + current_spawner.count, (0, 1, 0), 1, 1.25);
            print3d(current_spawner.origin + vectorscale((0, 0, 1), 85.0), "sm_active_count:" + current_spawner.activeai.size + "/" + spawnerfree + "/" + current_spawner.sm_active_count, (0, 1, 0), 1, 1.25);
          }
        }
      }

      wait 0.05;
    }

    wait 0.05;
  }

}

ent_print(text) {
  self endon("death");

  while(true) {
    print3d(self.origin + vectorscale((0, 0, 1), 65.0), text, (0.48, 9.4, 0.76), 1, 1);
    wait 0.05;
  }

}

spawn_manager_debug_spawn_manager_values_dpad() {
  if(!isDefined(level.current_debug_index))
    level.current_debug_index = 0;

  if(!isDefined(level.spawn_manager_debug_hud2)) {
    level.spawn_manager_debug_hud2 = newhudelem();
    level.spawn_manager_debug_hud2.alignx = "left";
    level.spawn_manager_debug_hud2.x = -75;
    level.spawn_manager_debug_hud2.y = 150;
    level.spawn_manager_debug_hud2.fontscale = 1.25;
    level.spawn_manager_debug_hud2.color = (1, 0, 0);
  }

  if(!isDefined(level.sm_active_count_title)) {
    level.sm_active_count_title = newhudelem();
    level.sm_active_count_title.alignx = "left";
    level.sm_active_count_title.x = -75;
    level.sm_active_count_title.y = 165;
    level.sm_active_count_title.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_active_count_min_hud)) {
    level.sm_active_count_min_hud = newhudelem();
    level.sm_active_count_min_hud.alignx = "left";
    level.sm_active_count_min_hud.x = -75;
    level.sm_active_count_min_hud.y = 180;
    level.sm_active_count_min_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_active_count_max_hud)) {
    level.sm_active_count_max_hud = newhudelem();
    level.sm_active_count_max_hud.alignx = "left";
    level.sm_active_count_max_hud.x = -75;
    level.sm_active_count_max_hud.y = 195;
    level.sm_active_count_max_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_group_size_min_hud)) {
    level.sm_group_size_min_hud = newhudelem();
    level.sm_group_size_min_hud.alignx = "left";
    level.sm_group_size_min_hud.x = -75;
    level.sm_group_size_min_hud.y = 210;
    level.sm_group_size_min_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_group_size_max_hud)) {
    level.sm_group_size_max_hud = newhudelem();
    level.sm_group_size_max_hud.alignx = "left";
    level.sm_group_size_max_hud.x = -75;
    level.sm_group_size_max_hud.y = 225;
    level.sm_group_size_max_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_spawner_count_title)) {
    level.sm_spawner_count_title = newhudelem();
    level.sm_spawner_count_title.alignx = "left";
    level.sm_spawner_count_title.x = -75;
    level.sm_spawner_count_title.y = 240;
    level.sm_spawner_count_title.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_spawner_count_min_hud)) {
    level.sm_spawner_count_min_hud = newhudelem();
    level.sm_spawner_count_min_hud.alignx = "left";
    level.sm_spawner_count_min_hud.x = -75;
    level.sm_spawner_count_min_hud.y = 255;
    level.sm_spawner_count_min_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_spawner_count_max_hud)) {
    level.sm_spawner_count_max_hud = newhudelem();
    level.sm_spawner_count_max_hud.alignx = "left";
    level.sm_spawner_count_max_hud.x = -75;
    level.sm_spawner_count_max_hud.y = 270;
    level.sm_spawner_count_max_hud.color = (1, 1, 1);
  }

  if(level.test_player buttonpressed("BUTTON_LTRIG")) {
    if(level.test_player buttonpressed("DPAD_DOWN")) {
      level.current_debug_index++;

      if(level.current_debug_index > 7)
        level.current_debug_index = 7;
    }

    if(level.test_player buttonpressed("DPAD_UP")) {
      level.current_debug_index--;

      if(level.current_debug_index < 0)
        level.current_debug_index = 0;
    }
  }

  set_debug_hud_colors();
  increase_value = 0;
  decrease_value = 0;

  if(level.test_player buttonpressed("BUTTON_LTRIG")) {
    if(level.test_player buttonpressed("DPAD_LEFT"))
      decrease_value = 1;

    if(level.test_player buttonpressed("DPAD_RIGHT"))
      increase_value = 1;
  }

  should_run_set_up = 0;

  if(increase_value || decrease_value) {
    if(increase_value)
      add = 1;
    else
      add = -1;

    switch (level.current_debug_index) {
      case 0:
        if(self.sm_active_count + add > self.sm_active_count_max)
          self.sm_active_count_max = self.sm_active_count + add;

        if(self.sm_active_count + add < self.sm_active_count_min) {
          if(self.sm_active_count + add > 0)
            self.sm_active_count_min = self.sm_active_count + add;
        }

        should_run_set_up = 1;
        self.sm_active_count = self.sm_active_count + add;
        break;
      case 1:
        if(self.sm_active_count_min + add < self.sm_group_size_max) {
          modify_debug_hud2("sm_active_count_min cant be smaller than sm_group_size_max, modify sm_group_size_max and try again.");
          break;
        }

        if(self.sm_active_count_min + add > self.sm_active_count_max) {
          modify_debug_hud2("sm_active_count_min cant be greater than sm_active_count_max, modify sm_active_count_max and try again.");
          break;
        }

        should_run_set_up = 1;
        self.sm_active_count_min = self.sm_active_count_min + add;
        break;
      case 2:
        if(self.sm_active_count_max + add < self.sm_active_count_min) {
          modify_debug_hud2("sm_active_count_max cant be smaller than sm_active_count_min, modify sm_active_count_min and try again.");
          break;
        }

        should_run_set_up = 1;
        self.sm_active_count_max = self.sm_active_count_max + add;
        break;
      case 3:
        if(self.sm_group_size_min + add > self.sm_group_size_max) {
          modify_debug_hud2("sm_group_size_min cant be greater than sm_group_size_max, modify sm_group_size_max and try again.");
          break;
        }

        should_run_set_up = 1;
        self.sm_group_size_min = self.sm_group_size_min + add;
        break;
      case 4:
        if(self.sm_group_size_max + add < self.sm_group_size_min) {
          modify_debug_hud2("sm_group_size_max cant be smaller than sm_group_size_min, modify sm_group_size_min and try again.");
          break;
        }

        if(self.sm_group_size_max + add > self.sm_active_count) {
          modify_debug_hud2("sm_group_size_max cant be greater than sm_active_count, modify sm_active_count and try again.");
          break;
        }

        should_run_set_up = 1;
        self.sm_group_size_max = self.sm_group_size_max + add;
        break;
      case 5:
        if(self.sm_spawner_count + add > self.allspawners.size) {
          modify_debug_hud2("sm_spawner_count cant be greater than max possible available spawners, add more spawners in the map and try again.");
          break;
        }

        if(self.sm_spawner_count + add <= 0) {
          modify_debug_hud2("sm_spawner_count cant be less than 0.");
          break;
        }

        if(self.sm_spawner_count + add < self.sm_spawner_count_min) {
          if(self.sm_spawner_count + add > 0)
            self.sm_spawner_count_min = self.sm_spawner_count + add;
        }

        if(self.sm_spawner_count + add > self.sm_spawner_count_max)
          self.sm_spawner_count_max = self.sm_spawner_count + add;

        should_run_set_up = 1;
        self.sm_spawner_count = self.sm_spawner_count + add;
        break;
      case 6:
        if(self.sm_spawner_count_min + add > self.sm_spawner_count_max) {
          modify_debug_hud2("sm_spawner_count_min cant be greater than sm_spawner_count_max, modify sm_spawner_count_max and try again.");
          break;
        }

        should_run_set_up = 1;
        self.sm_spawner_count_min = self.sm_spawner_count_min + add;
        break;
      case 7:
        if(self.sm_spawner_count_max + add < self.sm_spawner_count_min) {
          modify_debug_hud2("sm_spawner_count_max cant be smaller than sm_spawner_count_min, modify sm_spawner_count_min and try again.");
          break;
        }

        should_run_set_up = 1;
        self.sm_spawner_count_max = self.sm_spawner_count_max + add;
        break;
    }
  }

  if(should_run_set_up)
    level.current_debug_spawn_manager spawn_manager_debug_setup();

  if(isDefined(self)) {
    level.sm_active_count_title settext("sm_active_count: " + self.sm_active_count);
    level.sm_active_count_min_hud settext("sm_active_count_min: " + self.sm_active_count_min);
    level.sm_active_count_max_hud settext("sm_active_count_max: " + self.sm_active_count_max);
    level.sm_group_size_min_hud settext("sm_group_count_min: " + self.sm_group_size_min);
    level.sm_group_size_max_hud settext("sm_group_count_max: " + self.sm_group_size_max);
    level.sm_spawner_count_title settext("sm_spawner_count: " + self.sm_spawner_count);
    level.sm_spawner_count_min_hud settext("sm_spawner_count_min: " + self.sm_spawner_count_min);
    level.sm_spawner_count_max_hud settext("sm_spawner_count_max: " + self.sm_spawner_count_max);
  }

}

set_debug_hud_colors() {
  switch (level.current_debug_index) {
    case 0:
      level.sm_active_count_title.color = (0, 1, 0);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 1:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (0, 1, 0);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 2:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (0, 1, 0);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 3:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (0, 1, 0);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 4:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (0, 1, 0);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 5:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (0, 1, 0);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 6:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (0, 1, 0);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 7:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (0, 1, 0);
      break;
  }

}

spawn_manager_debug_setup() {
  if(isDefined(level.current_debug_index) && level.current_debug_index != 5)
    self.sm_spawner_count = spawn_manager_random_count(self.sm_spawner_count_min, self.sm_spawner_count_max + 1);

  if(isDefined(level.current_debug_index) && level.current_debug_index != 0)
    self.sm_active_count = spawn_manager_random_count(self.sm_active_count_min, self.sm_active_count_max + 1);

  self.spawners = self spawn_manager_get_spawners();
  assert(self.count >= self.count_min);
  assert(self.count <= self.count_max);
  assert(self.sm_active_count >= self.sm_active_count_min);
  assert(self.sm_active_count <= self.sm_active_count_max);
  assert(self.sm_group_size_max <= self.sm_active_count);
  assert(self.sm_group_size_min <= self.sm_active_count);
}

modify_debug_hud2(text) {
  self notify("modified");
  wait 0.05;
  level.spawn_manager_debug_hud2 settext(text);
  level.spawn_manager_debug_hud2 thread moniter_debug_hud2();
}

moniter_debug_hud2() {
  self endon("modified");
  wait 10;
  level.spawn_manager_debug_hud2 settext("");
}

destroy_tweak_hud_elements() {
  if(isDefined(level.sm_active_count_title))
    level.sm_active_count_title destroy();

  if(isDefined(level.sm_active_count_min_hud))
    level.sm_active_count_min_hud destroy();

  if(isDefined(level.sm_active_count_max_hud))
    level.sm_active_count_max_hud destroy();

  if(isDefined(level.sm_group_size_min_hud))
    level.sm_group_size_min_hud destroy();

  if(isDefined(level.sm_group_size_max_hud))
    level.sm_group_size_max_hud destroy();

  if(isDefined(level.sm_spawner_count_title))
    level.sm_spawner_count_title destroy();

  if(isDefined(level.sm_spawner_count_min_hud))
    level.sm_spawner_count_min_hud destroy();

  if(isDefined(level.sm_spawner_count_max_hud))
    level.sm_spawner_count_max_hud destroy();
}