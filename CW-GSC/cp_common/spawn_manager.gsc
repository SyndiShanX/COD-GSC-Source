/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\spawn_manager.gsc
***********************************************/

#using script_2c9bc8b876b81af8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace spawn_manager;

function private autoexec __init__system__() {
  system::register(#"spawn_manager", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.spawn_manager_total_count = 0;
  level.spawn_manager_max_ai = 50;
  level.spawn_manager_active_ai = 0;
  level.spawn_manager_auto_targetname_num = 0;
  level.spawn_managers = [];
  level.spawn_managers = getEntArray("spawn_manager", "classname");
  array::thread_all(level.spawn_managers, &spawn_manager_think);
  start_triggers();

  callback::on_connect(&on_player_connect);
  level thread spawn_manager_debug();
}

function spawn_manager_setup() {
  assert(isDefined(self));
  assert(isDefined(self.target));
  assert(self.sm_group_size_max >= self.sm_group_size_min, "<dev string:x38>" + self.sm_id);

  if(!isDefined(self.sm_spawner_count_min) || self.sm_spawner_count_min > self.allspawners.size) {
    self.sm_spawner_count_min = self.allspawners.size;
  }

  if(!isDefined(self.sm_spawner_count_max) || self.sm_spawner_count_max > self.allspawners.size) {
    self.sm_spawner_count_max = self.allspawners.size;
  }

  assert(self.sm_spawner_count_max >= self.sm_spawner_count_min, "<dev string:x38>" + self.sm_id);
  self.sm_spawner_count = randomintrange(self.sm_spawner_count_min, self.sm_spawner_count_max + 1);
  self.spawners = self spawn_manager_get_spawners();
  update_for_coop();
  assert(self.sm_group_size_min <= self.sm_active_count_max, "<dev string:x90>");

  if(!isDefined(self.script_forcespawn)) {
    self.script_forcespawn = 0;
  }
}

function spawn_manager_can_spawn(spawngroupsize) {
  totalfree = self.count >= 0 ? self.count : level.spawn_manager_max_ai;
  activefree = self.sm_active_count_max - self.activeai.size;
  canspawngroup = activefree >= spawngroupsize && totalfree >= spawngroupsize && spawngroupsize > 0;
  globalfree = level.spawn_manager_max_ai - level.spawn_manager_active_ai;
  assert(self.enable == level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:xca>"), "<dev string:xd6>");

  if(self.script_forcespawn == 0) {
    return (totalfree > 0 && activefree > 0 && globalfree > 0 && canspawngroup && self.enable);
  }

  return totalfree > 0 && activefree > 0 && self.enable;
}

function spawn_manager_spawn(maxdelay) {
  self endon(#"death");
  start = gettime();

  while(true) {
    ai = self spawner::spawn();

    if(isDefined(ai) || gettime() - start > 1000 * maxdelay) {
      return ai;
    }

    wait 0.5;
  }
}

function spawn_manager_spawn_group(spawner, spawngroupsize) {
  for(i = 0; i < spawngroupsize; i++) {
    ai = undefined;

    if(isDefined(spawner) && isDefined(spawner.targetname)) {
      ai = spawner spawn_manager_spawn(2);

      if(isDefined(ai)) {
        ai.sm_id = self.sm_id;
      }
    } else {
      continue;
    }

    if(!spawner::spawn_failed(ai)) {
      if(isDefined(self.script_radius)) {
        ai.script_radius = self.script_radius;
      }

      if(isDefined(spawner.script_radius)) {
        ai.script_radius = spawner.script_radius;
      }

      ai thread spawn_accounting(spawner, self);
    }
  }
}

function spawn_accounting(spawner, manager) {
  targetname = manager.targetname;
  classname = spawner.classname;
  level.spawn_manager_total_count++;
  manager.spawncount++;

  if(manager.count > 0) {
    manager.count--;
  }

  level.spawn_manager_active_ai++;
  origin = spawner.origin;
  manager.activeai[manager.activeai.size] = self;
  spawner.activeai[spawner.activeai.size] = self;
  self waittill(#"death");

  if(isDefined(spawner)) {
    arrayremovevalue(spawner.activeai, self);
  }

  if(isDefined(manager)) {
    arrayremovevalue(manager.activeai, self);
  }

  level.spawn_manager_active_ai--;
}

function set_defaults() {
  if(isDefined(self.name)) {
    check_name(self.name);

    self.sm_id = self.name;
  } else if(isDefined(self.targetname) && !strstartswith(self.targetname, "pf")) {
    check_name(self.targetname);

    self.sm_id = self.targetname;
  } else {
    auto_id();
  }

  if(!isDefined(self.sm_count_1player)) {
    self.sm_count_1player = self.count;
  }

  if(!isDefined(self.sm_active_count_min_1player)) {
    self.sm_active_count_min_1player = isDefined(self.sm_active_count_min) ? self.sm_active_count_min : level.spawn_manager_max_ai;
  }

  if(!isDefined(self.sm_active_count_max_1player)) {
    self.sm_active_count_max_1player = isDefined(self.sm_active_count_max) ? self.sm_active_count_max : level.spawn_manager_max_ai;
  }

  if(!isDefined(self.sm_group_size_min_1player)) {
    self.sm_group_size_min_1player = isDefined(self.sm_group_size_min) ? self.sm_group_size_min : 1;
  }

  if(!isDefined(self.sm_group_size_max_1player)) {
    self.sm_group_size_max_1player = isDefined(self.sm_group_size_max) ? self.sm_group_size_max : 1;
  }
}

function check_name(str_name) {
  a_spawn_managers = getEntArray("<dev string:x114>", "<dev string:x125>");

  foreach(sm in a_spawn_managers) {
    if(sm != self) {
      if(sm.targetname === str_name || sm.name === str_name) {
        assertmsg("<dev string:x132>" + str_name + "<dev string:x162>" + self.origin + "<dev string:x17b>" + sm.origin);
      }
    }
  }
}

function auto_id() {
  if(!isDefined(level.sm_auto_id)) {
    level.sm_auto_id = 0;
  }

  self.sm_id = "sm_auto" + level.sm_auto_id;
  level.sm_auto_id++;
}

function update_count_for_coop() {
  if(level.players.size >= 4 && isDefined(self.sm_count_4player)) {
    n_count = self.sm_count_4player;
  } else if(level.players.size >= 3 && isDefined(self.sm_count_3player)) {
    n_count = self.sm_count_3player;
  } else if(level.players.size >= 2 && isDefined(self.sm_count_2player)) {
    n_count = self.sm_count_2player;
  } else {
    n_count = self.sm_count_1player;
  }

  if(n_count > 0) {
    self.count = n_count;
    return;
  }

  self.count = -1;
}

function update_active_count_min_for_coop() {
  if(level.players.size >= 4 && isDefined(self.sm_active_count_min_4player)) {
    self.sm_active_count_min = self.sm_active_count_min_4player;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.sm_active_count_min_3player)) {
    self.sm_active_count_min = self.sm_active_count_min_3player;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.sm_active_count_min_2player)) {
    self.sm_active_count_min = self.sm_active_count_min_2player;
    return;
  }

  self.sm_active_count_min = self.sm_active_count_min_1player;
}

function update_active_count_max_for_coop() {
  if(level.players.size >= 4 && isDefined(self.sm_active_count_max_4player)) {
    self.sm_active_count_max = self.sm_active_count_max_4player;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.sm_active_count_max_3player)) {
    self.sm_active_count_max = self.sm_active_count_max_3player;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.sm_active_count_max_2player)) {
    self.sm_active_count_max = self.sm_active_count_max_2player;
    return;
  }

  self.sm_active_count_max = self.sm_active_count_max_1player;
}

function update_group_size_min_for_coop() {
  if(level.players.size >= 4 && isDefined(self.sm_group_size_min_4player)) {
    self.sm_group_size_min = self.sm_group_size_min_4player;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.sm_group_size_min_3player)) {
    self.sm_group_size_min = self.sm_group_size_min_3player;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.sm_group_size_min_2player)) {
    self.sm_group_size_min = self.sm_group_size_min_2player;
    return;
  }

  self.sm_group_size_min = self.sm_group_size_min_1player;
}

function update_group_size_max_for_coop() {
  if(level.players.size >= 4 && isDefined(self.sm_group_size_max_4player)) {
    self.sm_group_size_max = self.sm_group_size_max_4player;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.sm_group_size_max_3player)) {
    self.sm_group_size_max = self.sm_group_size_max_3player;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.sm_group_size_max_2player)) {
    self.sm_group_size_max = self.sm_group_size_max_2player;
    return;
  }

  self.sm_group_size_max = self.sm_group_size_max_1player;
}

function update_for_coop() {
  update_count_for_coop();
  update_active_count_min_for_coop();
  update_active_count_max_for_coop();
  update_group_size_min_for_coop();
  update_group_size_max_for_coop();

  foreach(sp in self.spawners) {
    sp update_count_for_coop();
    sp update_active_count_min_for_coop();
    sp update_active_count_max_for_coop();
  }
}

function spawn_manager_wave_wait() {
  if(!isDefined(self.sm_wave_wait_min)) {
    self.sm_wave_wait_min = 0;
  }

  if(!isDefined(self.sm_wave_wait_max)) {
    self.sm_wave_wait_max = 0;
  }

  if(self.sm_wave_wait_max > 0 && self.sm_wave_wait_max > self.sm_wave_wait_min) {
    wait randomfloatrange(self.sm_wave_wait_min, self.sm_wave_wait_max);
    return;
  }

  if(self.sm_wave_wait_min > 0) {
    wait self.sm_wave_wait_min;
  }
}

function spawn_manager_think() {
  self endon(#"death");
  self set_defaults();
  self spawn_manager_flags_setup();
  self thread spawn_manager_enable_think();
  self thread spawn_manager_kill_think();
  self.enable = 0;
  self.activeai = [];
  self.spawncount = 0;
  isfirsttime = 1;
  self.allspawners = getEntArray(self.target, "targetname");
  assert(self.allspawners.size, "<dev string:x186>" + self.sm_id + "<dev string:x199>");
  level flag::wait_till("sm_" + self.sm_id + "_enabled");
  util::script_delay();
  self spawn_manager_setup();
  b_spawn_up = 1;
  self spawn_manager_get_spawn_group_size();

  while(self.count != 0 && self.spawners.size > 0) {
    cleanup_spawners();
    n_active = self.activeai.size;
    n_active_budget = self.sm_active_count_max - n_active;

    if(!b_spawn_up && self.activeai.size <= self.sm_active_count_min) {
      b_spawn_up = 1;
      spawn_manager_wave_wait();
    } else if(b_spawn_up && n_active_budget < self.sm_group_size) {
      b_spawn_up = 0;
    }

    if(!b_spawn_up) {
      waitframe(1);
      continue;
    }

    self spawn_manager_get_spawn_group_size();

    if(self.count > 0) {
      if(self.sm_group_size > self.count) {
        self.sm_group_size = self.count;
      }
    }

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
            if(current_spawner.activeai.size > current_spawner.sm_active_count_min) {
              continue;
            }

            if(!function_42a4d0d8(current_spawner)) {
              continue;
            }

            spawnerfree = current_spawner.sm_active_count_max - current_spawner.activeai.size;

            if(spawnerfree >= self.sm_group_size) {
              if(isDefined(current_spawner.spawnflags) && (current_spawner.spawnflags & 32) == 32) {
                priority_spawners[priority_spawners.size] = current_spawner;
                continue;
              }

              potential_spawners[potential_spawners.size] = current_spawner;
            }
          }
        }

        if(potential_spawners.size > 0 || priority_spawners.size > 0) {
          if(priority_spawners.size > 0) {
            spawner = array::random(priority_spawners);
          } else {
            spawner = array::random(potential_spawners);
          }

          if(!(isDefined(spawner.spawnflags) && (spawner.spawnflags & 64) == 64) && spawner.count < self.sm_group_size) {
            self.sm_group_size = spawner.count;
          }

          if(!isfirsttime) {
            spawn_manager_wait();
          } else {
            isfirsttime = 0;
          }

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
              if(current_spawner.sm_active_count_max > spawner_max_active_count) {
                spawner_max_active_count = current_spawner.sm_active_count_max;
              }
            }
          }

          if(spawner_max_active_count < self.sm_group_size_max) {
            self.sm_group_size_max = spawner_max_active_count;
            self spawn_manager_get_spawn_group_size();
          }
        }
      }

      waitframe(1);
    }

    waitframe(1);
    assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1bb>"), "<dev string:xd6>");
    assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1c6>"), "<dev string:xd6>");
  }

  self spawn_manager_flag_complete();

  if(isDefined(self.activeai) && self.activeai.size != 0) {
    array::wait_till(self.activeai, "death");
  }

  function_257e48e2();
  self delete();
}

function spawn_manager_enable_think() {
  self endon(#"death");

  while(isDefined(self)) {
    self waittill(#"enable");
    self.enable = 1;
    self spawn_manager_flag_enabled();
    self waittill(#"disable");
    self spawn_manager_flag_disabled();
  }

  self spawn_manager_flag_disabled();
}

function spawn_manager_enable_trigger_think(spawn_manager) {
  spawn_manager endon(#"death", #"enable");
  self endon(#"death");
  self waittill(#"trigger");
  spawn_manager notify(#"enable");
}

function spawn_manager_kill_think() {
  self waittill(#"death");
  sm_id = self.sm_id;
  a_spawners = self.allspawners;
  a_active_ai = self.activeai;
  level flag::clear("sm_" + sm_id + "_enabled");
  level flag::set("sm_" + sm_id + "_killed");
  level flag::set("sm_" + sm_id + "_complete");
  function_257e48e2();

  if(a_active_ai.size) {
    array::wait_till(a_active_ai, "death");
  }

  level flag::set("sm_" + sm_id + "_cleared");
  arrayremovevalue(level.spawn_managers, undefined);
}

function start_triggers(trigger_type) {
  triggers = trigger::get_all("trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage", "trigger_box");

  foreach(trig in triggers) {
    if(isDefined(trig.target)) {
      targets = get_spawn_manager_array(trig.target);

      foreach(target in targets) {
        trig thread spawn_manager_enable_trigger_think(target);
      }
    }
  }
}

function get_spawn_manager_array(targetname) {
  if(isDefined(targetname)) {
    spawn_manager_array = [];

    for(i = 0; i < level.spawn_managers.size; i++) {
      if(isDefined(level.spawn_managers[i])) {
        if(level.spawn_managers[i].targetname === targetname || level.spawn_managers[i].name === targetname) {
          if(!isDefined(spawn_manager_array)) {
            spawn_manager_array = [];
          } else if(!isarray(spawn_manager_array)) {
            spawn_manager_array = array(spawn_manager_array);
          }

          spawn_manager_array[spawn_manager_array.size] = level.spawn_managers[i];
        }
      }
    }

    return spawn_manager_array;
  }

  return level.spawn_managers;
}

function spawn_manager_get_spawners() {
  arrayremovevalue(self.allspawners, undefined);
  exclude = [];

  for(i = 0; i < self.allspawners.size; i++) {
    if(isDefined(level._gamemode_norandomdogs) && self.allspawners[i].classname == "actor_enemy_dog_sp") {
      if(!isDefined(exclude)) {
        exclude = [];
      } else if(!isarray(exclude)) {
        exclude = array(exclude);
      }

      exclude[exclude.size] = self.allspawners[i];
    }
  }

  self.allspawners = array::exclude(self.allspawners, exclude);
  spawner_count_with_max_active = 0;

  foreach(sp in self.allspawners) {
    if(!isDefined(sp.sm_count_1player)) {
      sp.sm_count_1player = sp.count;
    }

    if(!isDefined(sp.sm_active_count_max_1player)) {
      sp.sm_active_count_max_1player = isDefined(sp.sm_active_count_max) ? sp.sm_active_count_max : level.spawn_manager_max_ai;
    }

    if(!isDefined(sp.sm_active_count_min_1player)) {
      sp.sm_active_count_min_1player = isDefined(sp.sm_active_count_min) ? sp.sm_active_count_min : sp.sm_active_count_max_1player;
    }

    sp.activeai = [];
  }

  groupspawners = arraycopy(self.allspawners);
  spawner_count = self.sm_spawner_count;

  if(spawner_count > self.allspawners.size) {
    spawner_count = self.allspawners.size;
  }

  spawners = [];

  while(spawners.size < spawner_count) {
    spawner = array::random(groupspawners);

    if(!isDefined(spawners)) {
      spawners = [];
    } else if(!isarray(spawners)) {
      spawners = array(spawners);
    }

    spawners[spawners.size] = spawner;
    arrayremovevalue(groupspawners, spawner);
  }

  return spawners;
}

function spawn_manager_get_spawn_group_size() {
  if(self.sm_group_size_min < self.sm_group_size_max) {
    self.sm_group_size = randomintrange(self.sm_group_size_min, self.sm_group_size_max + 1);
  } else {
    self.sm_group_size = self.sm_group_size_min;
  }

  return self.sm_group_size;
}

function function_257e48e2() {
  if(isDefined(self.spawners)) {
    foreach(spawner in self.spawners) {
      if(isDefined(spawner) && !is_false(spawner.script_delete)) {
        spawner delete();
      }
    }

    self.spawners = undefined;
  }
}

function cleanup_spawners() {
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

function spawn_manager_wait() {
  if(isDefined(self.script_wait)) {
    wait self.script_wait;

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }

    return;
  }

  if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    coop_scalar = 1;
    players = getPlayers();

    if(players.size == 2) {
      coop_scalar = 0.7;
    } else if(players.size == 3) {
      coop_scalar = 0.5;
    } else if(players.size == 4) {
      coop_scalar = 0.3;
    }

    diff = self.script_wait_max - self.script_wait_min;

    if(abs(diff) > 0) {
      wait randomfloatrange(self.script_wait_min, self.script_wait_min + diff * coop_scalar);
    } else {
      wait self.script_wait_min;
    }

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }
}

function function_42a4d0d8(spawner) {
  if(!isDefined(spawner.var_3717c478)) {
    return true;
  }

  radius = isDefined(spawner.var_3717c478) ? spawner.var_3717c478 : 0;
  players = getPlayers();

  if(!isDefined(players) || players.size == 0) {
    return true;
  }

  foreach(player in players) {
    if(distancesquared(spawner.origin, player.origin) <= sqr(spawner.var_3717c478)) {
      return false;
    }
  }

  return true;
}

function spawn_manager_flags_setup() {
  level flag::init("sm_" + self.sm_id + "_enabled");
  level flag::init("sm_" + self.sm_id + "_complete");
  level flag::init("sm_" + self.sm_id + "_killed");
  level flag::init("sm_" + self.sm_id + "_cleared");
}

function spawn_manager_flag_enabled() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:xca>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_enabled");
}

function spawn_manager_flag_disabled() {
  self.enable = 0;
  level flag::clear("sm_" + self.sm_id + "_enabled");
}

function spawn_manager_flag_killed() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1bb>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_killed");
}

function spawn_manager_flag_complete() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1c6>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_complete");
}

function spawn_manager_flag_cleared() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1d3>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_cleared");
}

function set_global_active_count(cnt) {
  assert(cnt <= 32, "<dev string:x1df>");
  level.spawn_manager_max_ai = cnt;
}

function use_trig_when_complete(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getEnt(trig_name, trig_key);
    assert(isDefined(trigger), "<dev string:x21f>" + trig_key + "<dev string:x22f>" + trig_name + "<dev string:x236>");
    trigger endon(#"trigger");
  }

  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_complete");
    trigger::use(trig_name, trig_key);
    return;
  }

  assertmsg("<dev string:x24a>" + spawn_manager_targetname + "<dev string:x275>");
}

function use_trig_when_cleared(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getEnt(trig_name, trig_key);
    assert(isDefined(trigger), "<dev string:x21f>" + trig_key + "<dev string:x22f>" + trig_name + "<dev string:x236>");
    trigger endon(#"trigger");
  }

  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_cleared");
    trigger::use(trig_name, trig_key);
    return;
  }

  assertmsg("<dev string:x285>" + spawn_manager_targetname + "<dev string:x275>");
}

function use_trig_when_enabled(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getEnt(trig_name, trig_key);
    assert(isDefined(trigger), "<dev string:x21f>" + trig_key + "<dev string:x22f>" + trig_name + "<dev string:x236>");
    trigger endon(#"trigger");
  }

  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_enabled");
    trigger::use(trig_name, trig_key);
    return;
  }

  assertmsg("<dev string:x285>" + spawn_manager_targetname + "<dev string:x275>");
}

function run_func_when_complete(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "<dev string:x2b2>");
  assert(level flag::exists("<dev string:xc3>" + spawn_manager_targetname + "<dev string:xca>"), "<dev string:x2e9>" + spawn_manager_targetname + "<dev string:x275>");
  wait_till_complete(spawn_manager_targetname);
  util::single_func(ent, process, var1, var2, var3, var4, var5);
}

function run_func_when_cleared(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "<dev string:x314>");
  assert(level flag::exists("<dev string:xc3>" + spawn_manager_targetname + "<dev string:xca>"), "<dev string:x34a>" + spawn_manager_targetname + "<dev string:x275>");
  wait_till_cleared(spawn_manager_targetname);
  util::single_func(ent, process, var1, var2, var3, var4, var5);
}

function run_func_when_enabled(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "<dev string:x374>");
  assert(level flag::exists("<dev string:xc3>" + spawn_manager_targetname + "<dev string:xca>"), "<dev string:x3aa>" + spawn_manager_targetname + "<dev string:x275>");
  wait_till_enabled(spawn_manager_targetname);
  util::single_func(ent, process, var1, var2, var3, var4, var5);
}

function enable(spawn_manager_targetname, no_assert) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    foreach(sm in level.spawn_managers) {
      if(isDefined(sm) && sm.sm_id == spawn_manager_targetname) {
        sm notify(#"enable");
        return;
      }
    }

    return;
  }

  if(!is_true(no_assert)) {
    assertmsg("<dev string:x3d4>" + spawn_manager_targetname + "<dev string:x275>");
  }
}

function disable(spawn_manager_targetname, no_assert) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    foreach(sm in level.spawn_managers) {
      if(isDefined(sm) && sm.sm_id == spawn_manager_targetname) {
        sm notify(#"disable");
        return;
      }
    }

    return;
  }

  if(!is_true(no_assert)) {
    assertmsg("<dev string:x3ef>" + spawn_manager_targetname + "<dev string:x275>");
  }
}

function kill(spawn_manager_targetname, no_assert) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    foreach(sm in level.spawn_managers) {
      if(isDefined(sm) && sm.sm_id == spawn_manager_targetname) {
        sm delete();
        arrayremovevalue(level.spawn_managers, undefined);
        return;
      }
    }

    return;
  }

  if(!is_true(no_assert)) {
    assertmsg("<dev string:x40b>" + spawn_manager_targetname + "<dev string:x275>");
  }
}

function is_enabled(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(level flag::get("sm_" + spawn_manager_targetname + "_enabled")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x424>" + spawn_manager_targetname + "<dev string:x275>");
}

function is_complete(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(level flag::get("sm_" + spawn_manager_targetname + "_complete")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x443>" + spawn_manager_targetname + "<dev string:x275>");
}

function is_cleared(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(level flag::get("sm_" + spawn_manager_targetname + "_cleared")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x463>" + spawn_manager_targetname + "<dev string:x275>");
}

function is_killed(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(level flag::get("sm_" + spawn_manager_targetname + "_killed")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x482>" + spawn_manager_targetname + "<dev string:x275>");
}

function wait_till_cleared(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_cleared");
    return;
  }

  assertmsg("<dev string:x4a0>" + spawn_manager_targetname + "<dev string:x275>");
}

function wait_till_ai_remaining(spawn_manager_targetname, count_to_reach) {
  assert(isDefined(count_to_reach), "<dev string:x4c6>");
  assert(count_to_reach, "<dev string:x50f>");

  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_complete");
  } else {
    assertmsg("<dev string:x570>" + spawn_manager_targetname + "<dev string:x275>");
  }

  if(level flag::get("sm_" + spawn_manager_targetname + "_cleared")) {
    return;
  }

  while(get_ai(spawn_manager_targetname).size > count_to_reach) {
    wait 0.1;
  }
}

function wait_till_complete(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_complete");
    return;
  }

  assertmsg("<dev string:x59b>" + spawn_manager_targetname + "<dev string:x275>");
}

function wait_till_enabled(spawn_manager_targetname) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_enabled");
    return;
  }

  assertmsg("<dev string:x5c2>" + spawn_manager_targetname + "<dev string:x275>");
}

function wait_till_spawned_count(spawn_manager_targetname, count) {
  if(level flag::exists("sm_" + spawn_manager_targetname + "_enabled")) {
    level flag::wait_till("sm_" + spawn_manager_targetname + "_enabled");
  } else {
    assertmsg("<dev string:x5e8>" + spawn_manager_targetname + "<dev string:x275>");
  }

  spawn_manager = get_spawn_manager_array(spawn_manager_targetname);
  assert(spawn_manager.size, "<dev string:x614>");
  assert(spawn_manager.size == 1, "<dev string:x660>");

  while(true) {
    if(isDefined(spawn_manager[0].spawncount) && spawn_manager[0].spawncount < count && !is_killed(spawn_manager_targetname)) {
      wait 0.5;
      continue;
    }

    break;
  }
}

function get_ai(spawn_manager_targetname) {
  a_ai = getaiarray(spawn_manager_targetname, "sm_id");
  return a_ai;
}