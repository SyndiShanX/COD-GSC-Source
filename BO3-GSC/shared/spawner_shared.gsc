/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\spawner_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\serverfaceanim_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#namespace spawner;

function autoexec __init__sytem__() {
  system::register("spawner", &__init__, &__main__, undefined);
}

function __init__() {
  if(getdvarstring("noai") == "") {
    setdvar("noai", "off");
  }
  level._nextcoverprint = 0;
  level._ai_group = [];
  level.killedaxis = 0;
  level.ffpoints = 0;
  level.missionfailed = 0;
  level.gather_delay = [];
  level.smoke_thrown = [];
  level.deathflags = [];
  level.spawner_number = 0;
  level.go_to_node_arrays = [];
  level.next_health_drop_time = 0;
  level.guys_to_die_before_next_health_drop = randomintrange(1, 4);
  level.portable_mg_gun_tag = "J_Shoulder_RI";
  level.mg42_hide_distance = 1024;
  level.global_spawn_timer = 0;
  level.global_spawn_count = 0;
  if(!isDefined(level.maxfriendlies)) {
    level.maxfriendlies = 11;
  }
  level.ai_classname_in_level = [];
  spawners = getspawnerarray();
  for(i = 0; i < spawners.size; i++) {
    spawners[i] thread spawn_prethink();
  }
  thread process_deathflags();
  precache_player_weapon_drops(array("rpg"));
  goal_volume_init();
  level thread spawner_targets_init();
  level.ai = [];
  add_global_spawn_function("axis", &global_ai_array);
  add_global_spawn_function("allies", &global_ai_array);
  add_global_spawn_function("team3", &global_ai_array);
  level thread update_nav_triggers();
}

function __main__() {
  waittillframeend();
  ai = getaispeciesarray("all");
  array::thread_all(ai, &living_ai_prethink);
  foreach(ai_guy in ai) {
    if(isalive(ai_guy)) {
      ai_guy.overrideactorkilled = &callback_track_dead_npcs_by_type;
      ai_guy thread spawn_think();
    }
  }
  level thread spawn_throttle_reset();
}

function update_nav_triggers() {
  level.valid_navmesh_positions = [];
  a_nav_triggers = getEntArray("trigger_navmesh", "classname");
  if(!a_nav_triggers.size) {
    return;
  }
  level.navmesh_zones = [];
  foreach(trig in a_nav_triggers) {
    level.navmesh_zones[trig.targetname] = 0;
  }
  while(true) {
    updatenavtriggers();
    level util::waittill_notify_or_timeout("update_nav_triggers", 1);
  }
}

function global_ai_array() {
  if(!isDefined(level.ai[self.team])) {
    level.ai[self.team] = [];
  } else if(!isarray(level.ai[self.team])) {
    level.ai[self.team] = array(level.ai[self.team]);
  }
  level.ai[self.team][level.ai[self.team].size] = self;
  self waittill("death");
  if(isDefined(self)) {
    if(isDefined(level.ai) && isDefined(level.ai[self.team]) && isinarray(level.ai[self.team], self)) {
      arrayremovevalue(level.ai[self.team], self);
    } else {
      foreach(aiarray in level.ai) {
        if(isinarray(aiarray, self)) {
          arrayremovevalue(aiarray, self);
          break;
        }
      }
    }
  } else {
    foreach(array in level.ai) {
      for(i = array.size - 1; i >= 0; i--) {
        if(!isDefined(array[i])) {
          arrayremoveindex(array, i);
        }
      }
    }
  }
}

function spawn_throttle_reset() {
  while(true) {
    util::wait_network_frame();
    util::wait_network_frame();
    level.global_spawn_count = 0;
  }
}

function global_spawn_throttle(n_count_per_network_frame) {
  if(!(isDefined(level.first_frame) && level.first_frame)) {
    while(level.global_spawn_count >= n_count_per_network_frame) {
      wait(0.05);
    }
    level.global_spawn_count++;
  }
}

function callback_track_dead_npcs_by_type() {}

function goal_volume_init() {
  volumes = getEntArray("info_volume", "classname");
  level.deathchain_goalvolume = [];
  level.goalvolumes = [];
  for(i = 0; i < volumes.size; i++) {
    volume = volumes[i];
    if(isDefined(volume.script_deathchain)) {
      level.deathchain_goalvolume[volume.script_deathchain] = volume;
    }
    if(isDefined(volume.script_goalvolume)) {
      level.goalvolumes[volume.script_goalvolume] = volume;
    }
  }
}

function precache_player_weapon_drops(weapon_names) {
  level.ai_classname_in_level_keys = getarraykeys(level.ai_classname_in_level);
  for(i = 0; i < level.ai_classname_in_level_keys.size; i++) {
    if(weapon_names.size <= 0) {
      break;
    }
    for(j = 0; j < weapon_names.size; j++) {
      weaponname = weapon_names[j];
      if(!issubstr(tolower(level.ai_classname_in_level_keys[i]), weaponname)) {
        continue;
      }
      arrayremovevalue(weapon_names, weaponname);
      break;
    }
  }
  level.ai_classname_in_level_keys = undefined;
}

function process_deathflags() {
  keys = getarraykeys(level.deathflags);
  level.deathflags = [];
  for(i = 0; i < keys.size; i++) {
    deathflag = keys[i];
    level.deathflags[deathflag] = [];
    level.deathflags[deathflag]["ai"] = [];
    if(!isDefined(level.flag[deathflag])) {
      level flag::init(deathflag);
    }
  }
}

function spawn_guys_until_death_or_no_count() {
  self endon("death");
  self waittill("count_gone");
}

function flood_spawner_scripted(spawners) {
  assert(isDefined(spawners) && spawners.size, "");
  array::thread_all(spawners, &flood_spawner_init);
  array::thread_all(spawners, &flood_spawner_think);
}

function reincrement_count_if_deleted(spawner) {
  spawner endon("death");
  self waittill("death");
  if(!isDefined(self)) {
    spawner.count++;
  }
}

function kill_trigger(trigger) {
  if(!isDefined(trigger)) {
    return;
  }
  if(isDefined(trigger.targetname) && trigger.targetname != "flood_spawner") {
    return;
  }
  trigger delete();
}

function waittilldeathorpaindeath() {
  self endon("death");
  self waittill("pain_death");
}

function drop_gear() {
  team = self.team;
  waittilldeathorpaindeath();
  if(!isDefined(self)) {
    return;
  }
  if(self.grenadeammo <= 0) {
    return;
  }
  if(isDefined(self.dropweapon) && !self.dropweapon) {
    return;
  }
  if(!isDefined(level.nextgrenadedrop)) {
    level.nextgrenadedrop = randomint(3);
  }
  level.nextgrenadedrop--;
  if(level.nextgrenadedrop > 0) {
    return;
  }
  level.nextgrenadedrop = 2 + randomint(2);
  spawn_grenade_bag((self.origin + (randomint(25) - 12, randomint(25) - 12, 2)) + vectorscale((0, 0, 1), 42), (0, randomint(360), 0), self.team);
}

function spawn_grenade_bag(origin, angles, team) {
  if(!isDefined(level.grenade_cache) || !isDefined(level.grenade_cache[team])) {
    level.grenade_cache_index[team] = 0;
    level.grenade_cache[team] = [];
  }
  index = level.grenade_cache_index[team];
  grenade = level.grenade_cache[team][index];
  if(isDefined(grenade)) {
    grenade delete();
  }
  count = self.grenadeammo;
  grenade = sys::spawn(("weapon_" + self.grenadeweapon.name) + level.game_mode_suffix, origin);
  level.grenade_cache[team][index] = grenade;
  level.grenade_cache_index[team] = (index + 1) % 16;
  grenade.angles = angles;
  grenade.count = count;
}

function spawn_prethink() {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = 1;
  if(getdvarstring("") != "") {
    self.count = 0;
    return;
  }
  if(isDefined(self.script_aigroup)) {
    aigroup_init(self.script_aigroup, self);
  }
  if(isDefined(self.script_delete)) {
    array_size = 0;
    if(isDefined(level._ai_delete)) {
      if(isDefined(level._ai_delete[self.script_delete])) {
        array_size = level._ai_delete[self.script_delete].size;
      }
    }
    level._ai_delete[self.script_delete][array_size] = self;
  }
  if(isDefined(self.target)) {
    crawl_through_targets_to_init_flags();
  }
}

function update_nav_triggers_for_actor() {
  level notify("update_nav_triggers");
  while(isalive(self)) {
    self util::waittill_either("death", "goal_changed");
    level notify("update_nav_triggers");
  }
}

function spawn_think(spawner) {
  self endon("death");
  if(isDefined(self.spawn_think_thread_active)) {
    return;
  }
  self.spawn_think_thread_active = 1;
  self.spawner = spawner;
  assert(isactor(self) || isvehicle(self), "spawner::spawn_think" + "");
  if(!isvehicle(self)) {
    if(!isalive(self)) {
      return;
    }
    self.maxhealth = self.health;
    self thread update_nav_triggers_for_actor();
  }
  self.script_animname = undefined;
  if(isDefined(self.script_aigroup)) {
    level flag::set(self.script_aigroup + "_spawning");
    self thread aigroup_think(level._ai_group[self.script_aigroup]);
  }
  if(isDefined(spawner) && isDefined(spawner.script_dropammo)) {
    self.disableammodrop = !spawner.script_dropammo;
  }
  if(isDefined(spawner) && isDefined(spawner.spawn_funcs)) {
    self.spawn_funcs = spawner.spawn_funcs;
  }
  if(isai(self)) {
    spawn_think_action(spawner);
    assert(isalive(self));
    assert(isDefined(self.team));
  }
  self thread run_spawn_functions();
  self.finished_spawning = 1;
  self notify("hash_f42b7e06");
}

function run_spawn_functions() {
  self endon("death");
  if(!isDefined(level.spawn_funcs)) {
    return;
  }
  if(isDefined(self.archetype) && isDefined(level.spawn_funcs[self.archetype])) {
    for(i = 0; i < level.spawn_funcs[self.archetype].size; i++) {
      func = level.spawn_funcs[self.archetype][i];
      util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
    }
  }
  waittillframeend();
  callback::callback("hash_f96ca9bc");
  if(isDefined(level.spawn_funcs[self.team])) {
    for(i = 0; i < level.spawn_funcs[self.team].size; i++) {
      func = level.spawn_funcs[self.team][i];
      util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
    }
  }
  if(isDefined(self.spawn_funcs)) {
    for(i = 0; i < self.spawn_funcs.size; i++) {
      func = self.spawn_funcs[i];
      util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
    }
    return;
  }
}

function living_ai_prethink() {
  if(isDefined(self.script_deathflag)) {
    level.deathflags[self.script_deathflag] = 1;
  }
  if(isDefined(self.target)) {
    crawl_through_targets_to_init_flags();
  }
}

function crawl_through_targets_to_init_flags() {
  array = get_node_funcs_based_on_target();
  if(isDefined(array)) {
    targets = array["node"];
    get_func = array["get_target_func"];
    for(i = 0; i < targets.size; i++) {
      crawl_target_and_init_flags(targets[i], get_func);
    }
  }
}

function remove_spawner_values() {
  self.spawner_number = undefined;
}

function spawn_think_action(spawner) {
  remove_spawner_values();
  if(isDefined(level._use_faceanim) && level._use_faceanim) {
    self thread serverfaceanim::init_serverfaceanim();
  }
  if(isDefined(spawner)) {
    if(isDefined(spawner.targetname) && !isDefined(self.targetname)) {
      self.targetname = spawner.targetname + "_ai";
    }
  }
  if(isDefined(spawner) && isDefined(spawner.script_animname)) {
    self.animname = spawner.script_animname;
  } else if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
  }
  thread show_bad_path();
  if(isDefined(self.script_forcecolor)) {
    colors::set_force_color(self.script_forcecolor);
    if(!isDefined(self.script_no_respawn) || self.script_no_respawn < 1 && !isDefined(level.no_color_respawners_sm)) {
      self thread replace_on_death();
    }
  }
  if(isDefined(self.script_moveoverride) && self.script_moveoverride == 1) {
    override = 1;
  } else {
    override = 0;
  }
  self.heavy_machine_gunner = issubstr(self.classname, "mgportable");
  gameskill::grenadeawareness();
  if(isDefined(self.script_ignoreme)) {
    assert(self.script_ignoreme == 1, "");
    self.ignoreme = 1;
  }
  if(isDefined(self.script_hero)) {
    assert(self.script_hero == 1, "");
  }
  if(isDefined(self.script_ignoreall)) {
    assert(self.script_ignoreall == 1, "");
    self.ignoreall = 1;
  }
  if(isDefined(self.script_sightrange)) {
    self.maxsightdistsqrd = self.script_sightrange;
  } else if(self.weaponclass === "gas") {
    self.maxsightdistsqrd = 1048576;
  }
  if(self.team != "axis") {
    if(isDefined(self.script_followmin)) {
      self.followmin = self.script_followmin;
    }
    if(isDefined(self.script_followmax)) {
      self.followmax = self.script_followmax;
    }
  }
  if(self.team == "axis") {}
  if(isDefined(self.script_fightdist)) {
    self.pathenemyfightdist = self.script_fightdist;
  }
  if(isDefined(self.script_maxdist)) {
    self.pathenemylookahead = self.script_maxdist;
  }
  if(isDefined(self.script_longdeath)) {
    assert(!self.script_longdeath, "" + self.export);
    self.a.disablelongdeath = 1;
    assert(self.team != "", "" + self.export);
  }
  if(isDefined(self.script_grenades)) {
    self.grenadeammo = self.script_grenades;
  }
  if(isDefined(self.script_pacifist)) {
    self.pacifist = 1;
  }
  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
  }
  if(isDefined(self.script_allowdeath)) {
    self.allowdeath = self.script_allowdeath;
  }
  if(isDefined(self.script_forcegib)) {
    self.force_gib = 1;
  }
  if(isDefined(self.script_lights_on)) {
    self.has_ir = 1;
  }
  if(isDefined(self.script_patroller)) {
    return;
  }
  if(isDefined(self.script_rusher) && self.script_rusher) {
    return;
  }
  if(isDefined(self.used_an_mg42)) {
    return;
  }
  if(override) {
    self thread set_goalradius_based_on_settings();
    self setgoal(self.origin);
    return;
  }
  if(isDefined(level.using_awareness) && level.using_awareness) {
    return;
  }
  if(isDefined(self.vehicleclass) && self.vehicleclass == "artillery") {
    return;
  }
  if(isDefined(self.target)) {
    e_goal = getent(self.target, "targetname");
    if(isDefined(e_goal)) {
      self setgoal(e_goal);
    } else {
      self thread go_to_node();
    }
  } else {
    self thread set_goalradius_based_on_settings();
    if(isDefined(self.script_spawner_targets)) {
      self thread go_to_spawner_target(strtok(self.script_spawner_targets, " "));
    }
  }
  if(isDefined(self.script_goalvolume)) {
    self thread set_goal_volume();
  }
  if(isDefined(self.script_turnrate)) {
    self.turnrate = self.script_turnrate;
  }
}

function set_goal_volume() {
  self endon("death");
  waittillframeend();
  volume = level.goalvolumes[self.script_goalvolume];
  if(!isDefined(volume)) {
    return;
  }
  if(isDefined(volume.target)) {
    node = getnode(volume.target, "targetname");
    ent = getent(volume.target, "targetname");
    struct = struct::get(volume.target, "targetname");
    pos = undefined;
    if(isDefined(node)) {
      pos = node;
      self setgoal(pos);
    } else {
      if(isDefined(ent)) {
        pos = ent;
        self setgoal(pos.origin);
      } else if(isDefined(struct)) {
        pos = struct;
        self setgoal(pos.origin);
      }
    }
    if(isDefined(pos.radius) && pos.radius != 0) {
      self.goalradius = pos.radius;
    }
    if(isDefined(pos.goalheight) && pos.goalheight != 0) {
      self.goalheight = pos.goalheight;
    }
  }
  if(isDefined(self.target)) {
    self setgoal(volume);
  } else {
    if(isDefined(self.script_spawner_targets)) {
      self waittill("spawner_target_set");
      self setgoal(volume);
    } else {
      self setgoal(volume);
    }
  }
}

function get_target_ents(target) {
  return getEntArray(target, "targetname");
}

function get_target_nodes(target) {
  return getnodearray(target, "targetname");
}

function get_target_structs(target) {
  return struct::get_array(target, "targetname");
}

function node_has_radius(node) {
  return isDefined(node.radius) && node.radius != 0;
}

function go_to_origin(node, optional_arrived_at_node_func) {
  self go_to_node(node, "origin", optional_arrived_at_node_func);
}

function go_to_struct(node, optional_arrived_at_node_func) {
  self go_to_node(node, "struct", optional_arrived_at_node_func);
}

function go_to_node(node, goal_type, optional_arrived_at_node_func) {
  self endon("death");
  if(isDefined(self.used_an_mg42)) {
    return;
  }
  array = get_node_funcs_based_on_target(node, goal_type);
  if(!isDefined(array)) {
    self notify("reached_path_end");
    return;
  }
  if(!isDefined(optional_arrived_at_node_func)) {
    optional_arrived_at_node_func = &util::empty;
  }
  go_to_node_using_funcs(array["node"], array["get_target_func"], array["set_goal_func_quits"], optional_arrived_at_node_func);
}

function spawner_targets_init() {
  allnodes = getallnodes();
  level.script_spawner_targets_nodes = [];
  for(i = 0; i < allnodes.size; i++) {
    if(isDefined(allnodes[i].script_spawner_targets)) {
      level.script_spawner_targets_nodes[level.script_spawner_targets_nodes.size] = allnodes[i];
    }
  }
}

function go_to_spawner_target(target_names) {
  self endon("death");
  self notify("go_to_spawner_target");
  self endon("go_to_spawner_target");
  nodes = [];
  a_nodes_unavailable = [];
  nodespresent = 0;
  for(i = 0; i < target_names.size; i++) {
    target_nodes = get_spawner_target_nodes(target_names[i]);
    if(target_nodes.size > 0) {
      nodespresent = 1;
    }
    foreach(node in target_nodes) {
      if(isnodeoccupied(node) || (isDefined(node.node_claimed) && node.node_claimed)) {
        if(!isDefined(a_nodes_unavailable)) {
          a_nodes_unavailable = [];
        } else if(!isarray(a_nodes_unavailable)) {
          a_nodes_unavailable = array(a_nodes_unavailable);
        }
        a_nodes_unavailable[a_nodes_unavailable.size] = node;
        continue;
      }
      if(isDefined(node.spawnflags) && (node.spawnflags & 512) == 512) {
        if(!isDefined(a_nodes_unavailable)) {
          a_nodes_unavailable = [];
        } else if(!isarray(a_nodes_unavailable)) {
          a_nodes_unavailable = array(a_nodes_unavailable);
        }
        a_nodes_unavailable[a_nodes_unavailable.size] = node;
        continue;
      }
      if(!isDefined(nodes)) {
        nodes = [];
      } else if(!isarray(nodes)) {
        nodes = array(nodes);
      }
      nodes[nodes.size] = node;
    }
  }
  if(nodes.size == 0) {
    while(nodes.size == 0) {
      foreach(node in a_nodes_unavailable) {
        if(!isnodeoccupied(node) && (!(isDefined(node.node_claimed) && node.node_claimed)) && (!(isDefined(node.spawnflags) && (node.spawnflags & 512) == 512))) {
          if(!isDefined(nodes)) {
            nodes = [];
          } else if(!isarray(nodes)) {
            nodes = array(nodes);
          }
          nodes[nodes.size] = node;
          break;
        }
      }
      wait(0.2);
    }
  }
  assert(nodespresent, "");
  goal = undefined;
  if(nodes.size > 0) {
    goal = array::random(nodes);
  }
  if(isDefined(goal)) {
    if(isDefined(self.script_radius)) {
      self.goalradius = self.script_radius;
    } else {
      self.goalradius = 400;
    }
    goal.node_claimed = 1;
    self setgoal(goal);
    self notify("spawner_target_set");
    self thread release_spawner_target_node(goal);
    self waittill("goal");
  }
  self set_goalradius_based_on_settings(goal);
}

function release_spawner_target_node(node) {
  self util::waittill_any("death", "goal_changed");
  node.node_claimed = undefined;
}

function get_spawner_target_nodes(group) {
  if(group == "") {
    return [];
  }
  nodes = [];
  for(i = 0; i < level.script_spawner_targets_nodes.size; i++) {
    groups = strtok(level.script_spawner_targets_nodes[i].script_spawner_targets, " ");
    for(j = 0; j < groups.size; j++) {
      if(groups[j] == group) {
        nodes[nodes.size] = level.script_spawner_targets_nodes[i];
      }
    }
  }
  return nodes;
}

function get_least_used_from_array(array) {
  assert(array.size > 0, "");
  if(array.size == 1) {
    return array[0];
  }
  targetname = array[0].targetname;
  if(!isDefined(level.go_to_node_arrays[targetname])) {
    level.go_to_node_arrays[targetname] = array;
  }
  array = level.go_to_node_arrays[targetname];
  first = array[0];
  newarray = [];
  for(i = 0; i < (array.size - 1); i++) {
    newarray[i] = array[i + 1];
  }
  newarray[array.size - 1] = array[0];
  level.go_to_node_arrays[targetname] = newarray;
  return first;
}

function go_to_node_using_funcs(node, get_target_func, set_goal_func_quits, optional_arrived_at_node_func, require_player_dist) {
  self endon("stop_going_to_node");
  self endon("death");
  for(;;) {
    node = get_least_used_from_array(node);
    player_wait_dist = require_player_dist;
    if(isDefined(node.script_requires_player)) {
      if(node.script_requires_player > 1) {
        player_wait_dist = node.script_requires_player;
      } else {
        player_wait_dist = 256;
      }
      node.script_requires_player = 0;
    }
    self set_goalradius_based_on_settings(node);
    if(isDefined(node.height)) {
      self.goalheight = node.height;
    }
    [[set_goal_func_quits]](node);
    self waittill("goal");
    [[optional_arrived_at_node_func]](node);
    if(isDefined(node.script_flag_set)) {
      level flag::set(node.script_flag_set);
    }
    if(isDefined(node.script_flag_clear)) {
      level flag::set(node.script_flag_clear);
    }
    if(isDefined(node.script_ent_flag_set)) {
      if(!self flag::exists(node.script_ent_flag_set)) {
        assertmsg(("" + node.script_ent_flag_set) + "");
      }
      self flag::set(node.script_ent_flag_set);
    }
    if(isDefined(node.script_ent_flag_clear)) {
      if(!self flag::exists(node.script_ent_flag_clear)) {
        assertmsg(("" + node.script_ent_flag_clear) + "");
      }
      self flag::clear(node.script_ent_flag_clear);
    }
    if(isDefined(node.script_flag_wait)) {
      level flag::wait_till(node.script_flag_wait);
    }
    while(isDefined(node.script_requires_player)) {
      node.script_requires_player = 0;
      if(self go_to_node_wait_for_player(node, get_target_func, player_wait_dist)) {
        node.script_requires_player = 1;
        node notify("script_requires_player");
        break;
      }
      wait(0.1);
    }
    if(isDefined(node.script_aigroup)) {
      waittill_ai_group_cleared(node.script_aigroup);
    }
    node util::script_delay();
    if(!isDefined(node.target)) {
      break;
    }
    nextnode_array = update_target_array(node.target);
    if(!nextnode_array.size) {
      break;
    }
    node = nextnode_array;
  }
  if(isDefined(self.arrived_at_end_node_func)) {
    [[self.arrived_at_end_node_func]](node);
  }
  self notify("reached_path_end");
  if(isDefined(self.delete_on_path_end)) {
    self delete();
  }
  self set_goalradius_based_on_settings(node);
}

function go_to_node_wait_for_player(node, get_target_func, dist) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(distancesquared(player.origin, node.origin) < distancesquared(self.origin, node.origin)) {
      return true;
    }
  }
  vec = anglesToForward(self.angles);
  if(isDefined(node.target)) {
    temp = [[get_target_func]](node.target);
    if(temp.size == 1) {
      vec = vectornormalize(temp[0].origin - node.origin);
    } else if(isDefined(node.angles)) {
      vec = anglesToForward(node.angles);
    }
  } else if(isDefined(node.angles)) {
    vec = anglesToForward(node.angles);
  }
  vec2 = [];
  for(i = 0; i < players.size; i++) {
    player = players[i];
    vec2[vec2.size] = vectornormalize(player.origin - self.origin);
  }
  for(i = 0; i < vec2.size; i++) {
    value = vec2[i];
    if(vectordot(vec, value) > 0) {
      return true;
    }
  }
  dist2rd = dist * dist;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(distancesquared(player.origin, self.origin) < dist2rd) {
      return true;
    }
  }
  return false;
}

function go_to_node_set_goal_pos(ent) {
  self setgoal(ent.origin);
}

function go_to_node_set_goal_node(node) {
  self setgoal(node);
}

function remove_crawled(ent) {
  waittillframeend();
  if(isDefined(ent)) {
    ent.crawled = undefined;
  }
}

function crawl_target_and_init_flags(ent, get_func) {
  targets = [];
  index = 0;
  for(;;) {
    if(!isDefined(ent.crawled)) {
      ent.crawled = 1;
      level thread remove_crawled(ent);
      if(isDefined(ent.script_flag_set)) {
        if(!isDefined(level.flag[ent.script_flag_set])) {
          level flag::init(ent.script_flag_set);
        }
      }
      if(isDefined(ent.script_flag_wait)) {
        if(!isDefined(level.flag[ent.script_flag_wait])) {
          level flag::init(ent.script_flag_wait);
        }
      }
      if(isDefined(ent.target)) {
        new_targets = [[get_func]](ent.target);
        array::add(targets, new_targets);
      }
    }
    index++;
    if(index >= targets.size) {
      break;
    }
    ent = targets[index];
  }
}

function get_node_funcs_based_on_target(node, goal_type) {
  get_target_func["origin"] = &get_target_ents;
  get_target_func["node"] = &get_target_nodes;
  get_target_func["struct"] = &get_target_structs;
  set_goal_func_quits["origin"] = &go_to_node_set_goal_pos;
  set_goal_func_quits["struct"] = &go_to_node_set_goal_pos;
  set_goal_func_quits["node"] = &go_to_node_set_goal_node;
  if(!isDefined(goal_type)) {
    goal_type = "node";
  }
  array = [];
  if(isDefined(node)) {
    array["node"][0] = node;
  } else {
    node = getEntArray(self.target, "targetname");
    if(node.size > 0) {
      goal_type = "origin";
    }
    if(goal_type == "node") {
      node = getnodearray(self.target, "targetname");
      if(!node.size) {
        node = struct::get_array(self.target, "targetname");
        if(!node.size) {
          return;
        }
        goal_type = "struct";
      }
    }
    array["node"] = node;
  }
  array["get_target_func"] = get_target_func[goal_type];
  array["set_goal_func_quits"] = set_goal_func_quits[goal_type];
  return array;
}

function update_target_array(str_target) {
  a_nd_target = getnodearray(str_target, "targetname");
  if(a_nd_target.size) {
    return a_nd_target;
  }
  a_s_target = struct::get_array(str_target, "targetname");
  if(a_s_target.size) {
    return a_s_target;
  }
  a_e_target = getEntArray(str_target, "targetname");
  if(a_e_target.size) {
    return a_e_target;
  }
}

function set_goalradius_based_on_settings(node) {
  self endon("death");
  waittillframeend();
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
  } else if(isDefined(node) && node_has_radius(node)) {
    self.goalradius = node.radius;
  }
  if(isDefined(self.script_forcegoal) && self.script_forcegoal) {
    n_radius = (self.script_forcegoal > 1 ? self.script_forcegoal : undefined);
    self thread ai::force_goal(get_goal(self.target), n_radius);
  }
}

function get_goal(str_goal, str_key = "targetname") {
  a_goals = getnodearray(str_goal, str_key);
  if(!a_goals.size) {
    a_goals = getEntArray(str_goal, str_key);
  }
  return array::random(a_goals);
}

function fallback_spawner_think(num, node_array, ignorewhilefallingback) {
  self endon("death");
  level.max_fallbackers[num] = level.max_fallbackers[num] + self.count;
  firstspawn = 1;
  while(self.count > 0) {
    self waittill("spawned", spawn);
    if(firstspawn) {
      if(getdvarstring("") == "") {
        println("", num);
      }
      level notify("fallback_firstspawn" + num);
      firstspawn = 0;
    }
    wait(0.05);
    if(spawn_failed(spawn)) {
      level notify("fallbacker_died" + num);
      level.max_fallbackers[num]--;
      continue;
    }
    spawn thread fallback_ai_think(num, node_array, "is spawner", ignorewhilefallingback);
  }
}

function fallback_ai_think_death(ai, num) {
  ai waittill("death");
  level.current_fallbackers[num]--;
  level notify("fallbacker_died" + num);
}

function fallback_ai_think(num, node_array, spawner, ignorewhilefallingback) {
  if(!isDefined(self.fallback) || !isDefined(self.fallback[num])) {
    self.fallback[num] = 1;
  } else {
    return;
  }
  self.script_fallback = num;
  if(!isDefined(spawner)) {
    level.current_fallbackers[num]++;
  }
  if(isDefined(node_array) && level.fallback_initiated[num]) {
    self thread fallback_ai(num, node_array, ignorewhilefallingback);
  }
  level thread fallback_ai_think_death(self, num);
}

function fallback_death(ai, num) {
  ai waittill("death");
  if(isDefined(ai.fallback_node)) {
    ai.fallback_node.fallback_occupied = 0;
  }
  level notify("fallback_reached_goal" + num);
}

function fallback_goal(ignorewhilefallingback) {
  self waittill("goal");
  self.ignoresuppression = 0;
  if(isDefined(ignorewhilefallingback) && ignorewhilefallingback) {
    self.ignoreall = 0;
  }
  self notify("fallback_notify");
  self notify("stop_coverprint");
}

function fallback_interrupt() {
  self notify("stop_fallback_interrupt");
  self endon("stop_fallback_interrupt");
  self endon("stop_going_to_node");
  self endon("hash_1f355ad7");
  self endon("fallback_notify");
  self endon("death");
  while(true) {
    origin = self.origin;
    wait(2);
    if(self.origin == origin) {
      self.ignoreall = 0;
      return;
    }
  }
}

function fallback_ai(num, node_array, ignorewhilefallingback) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("hash_1f355ad7");
  self endon("death");
  node = undefined;
  while(true) {
    assert(node_array.size >= level.current_fallbackers[num], ("" + num) + "");
    node = node_array[randomint(node_array.size)];
    if(!isDefined(node.fallback_occupied) || !node.fallback_occupied) {
      node.fallback_occupied = 1;
      self.fallback_node = node;
      break;
    }
    wait(0.1);
  }
  self.ignoresuppression = 1;
  if(self.ignoreall == 0 && isDefined(ignorewhilefallingback) && ignorewhilefallingback) {
    self.ignoreall = 1;
    self thread fallback_interrupt();
  }
  self setgoal(node);
  if(node.radius != 0) {
    self.goalradius = node.radius;
  }
  self endon("death");
  level thread fallback_death(self, num);
  self thread fallback_goal(ignorewhilefallingback);
  if(getdvarstring("") == "") {
    self thread coverprint(node.origin);
  }
  self waittill("fallback_notify");
  level notify("fallback_reached_goal" + num);
}

function coverprint(org) {
  self endon("fallback_notify");
  self endon("stop_coverprint");
  self endon("death");
  while(true) {
    line(self.origin + vectorscale((0, 0, 1), 35), org, (0.2, 0.5, 0.8), 0.5);
    print3d(self.origin + vectorscale((0, 0, 1), 70), "", (0.98, 0.4, 0.26), 0.85);
    wait(0.05);
  }
}

function fallback_overmind(num, group, ignorewhilefallingback, percent) {
  fallback_nodes = undefined;
  nodes = getallnodes();
  for(i = 0; i < nodes.size; i++) {
    if(isDefined(nodes[i].script_fallback) && nodes[i].script_fallback == num) {
      array::add(fallback_nodes, nodes[i]);
    }
  }
  if(isDefined(fallback_nodes)) {
    level thread fallback_overmind_internal(num, group, fallback_nodes, ignorewhilefallingback, percent);
  }
}

function fallback_overmind_internal(num, group, fallback_nodes, ignorewhilefallingback, percent) {
  level.current_fallbackers[num] = 0;
  level.max_fallbackers[num] = 0;
  level.spawner_fallbackers[num] = 0;
  level.fallback_initiated[num] = 0;
  spawners = getspawnerarray();
  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].script_fallback) && spawners[i].script_fallback == num) {
      if(spawners[i].count > 0) {
        spawners[i] thread fallback_spawner_think(num, fallback_nodes, ignorewhilefallingback);
        level.spawner_fallbackers[num]++;
      }
    }
  }
  assert(level.spawner_fallbackers[num] <= fallback_nodes.size, "" + num);
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_fallback) && ai[i].script_fallback == num) {
      ai[i] thread fallback_ai_think(num, undefined, undefined, ignorewhilefallingback);
    }
  }
  if(!level.current_fallbackers[num] && !level.spawner_fallbackers[num]) {
    return;
  }
  spawners = undefined;
  ai = undefined;
  thread fallback_wait(num, group, ignorewhilefallingback, percent);
  level waittill("fallbacker_trigger" + num);
  fallback_add_previous_group(num, fallback_nodes);
  if(getdvarstring("") == "") {
    println("", num);
  }
  level.fallback_initiated[num] = 1;
  fallback_ai = undefined;
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_fallback) && ai[i].script_fallback == num || (isDefined(ai[i].script_fallback_group) && isDefined(group) && ai[i].script_fallback_group == group)) {
      array::add(fallback_ai, ai[i]);
    }
  }
  ai = undefined;
  if(!isDefined(fallback_ai)) {
    return;
  }
  if(!isDefined(percent)) {
    percent = 0.4;
  }
  first_half = fallback_ai.size * percent;
  first_half = int(first_half);
  level notify("fallback initiated " + num);
  fallback_text(fallback_ai, 0, first_half);
  first_half_ai = [];
  for(i = 0; i < first_half; i++) {
    fallback_ai[i] thread fallback_ai(num, fallback_nodes, ignorewhilefallingback);
    first_half_ai[i] = fallback_ai[i];
  }
  for(i = 0; i < first_half; i++) {
    level waittill("fallback_reached_goal" + num);
  }
  fallback_text(fallback_ai, first_half, fallback_ai.size);
  for(i = 0; i < fallback_ai.size; i++) {
    if(isalive(fallback_ai[i])) {
      set_fallback = 1;
      for(p = 0; p < first_half_ai.size; p++) {
        if(isalive(first_half_ai[p])) {
          if(fallback_ai[i] == first_half_ai[p]) {
            set_fallback = 0;
          }
        }
      }
      if(set_fallback) {
        fallback_ai[i] thread fallback_ai(num, fallback_nodes, ignorewhilefallingback);
      }
    }
  }
}

function fallback_text(fallbackers, start, end) {
  if(gettime() <= level._nextcoverprint) {
    return;
  }
  for(i = start; i < end; i++) {
    if(!isalive(fallbackers[i])) {
      continue;
    }
    level._nextcoverprint = (gettime() + 2500) + randomint(2000);
    return;
  }
}

function fallback_wait(num, group, ignorewhilefallingback, percent) {
  level endon("fallbacker_trigger" + num);
  if(getdvarstring("") == "") {
    println("", num);
  }
  for(i = 0; i < level.spawner_fallbackers[num]; i++) {
    if(getdvarstring("") == "") {
      println("", num, "", i);
    }
    level waittill("fallback_firstspawn" + num);
  }
  if(getdvarstring("") == "") {
    println("", num, "", level.current_fallbackers[num]);
  }
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_fallback) && ai[i].script_fallback == num || (isDefined(ai[i].script_fallback_group) && isDefined(group) && ai[i].script_fallback_group == group)) {
      ai[i] thread fallback_ai_think(num, undefined, undefined, ignorewhilefallingback);
    }
  }
  ai = undefined;
  for(deadfallbackers = 0; deadfallbackers < (level.max_fallbackers[num] * percent); deadfallbackers++) {
    if(getdvarstring("") == "") {
      println((("" + deadfallbackers) + "") + (level.max_fallbackers[num] * 0.5));
    }
    level waittill("fallbacker_died" + num);
  }
  println(deadfallbackers, "");
  level notify("fallbacker_trigger" + num);
}

function fallback_think(trigger) {
  ignorewhilefallingback = 0;
  if(isDefined(trigger.script_ignoreall) && trigger.script_ignoreall) {
    ignorewhilefallingback = 1;
  }
  if(!isDefined(level.fallback) || !isDefined(level.fallback[trigger.script_fallback])) {
    percent = 0.5;
    if(isDefined(trigger.script_percent)) {
      percent = trigger.script_percent / 100;
    }
    level thread fallback_overmind(trigger.script_fallback, trigger.script_fallback_group, ignorewhilefallingback, percent);
  }
  trigger waittill("trigger");
  level notify("fallbacker_trigger" + trigger.script_fallback);
  kill_trigger(trigger);
}

function fallback_add_previous_group(num, node_array) {
  if(!isDefined(level.current_fallbackers[num - 1])) {
    return;
  }
  for(i = 0; i < (level.current_fallbackers[num - 1]); i++) {
    level.max_fallbackers[num]++;
  }
  for(i = 0; i < (level.current_fallbackers[num - 1]); i++) {
    level.current_fallbackers[num]++;
  }
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_fallback) && ai[i].script_fallback == (num - 1)) {
      ai[i].script_fallback++;
      if(isDefined(ai[i].fallback_node)) {
        ai[i].fallback_node.fallback_occupied = 0;
        ai[i].fallback_node = undefined;
      }
    }
  }
}

function aigroup_init(aigroup, spawner) {
  if(!isDefined(level._ai_group[aigroup])) {
    level._ai_group[aigroup] = spawnStruct();
    level._ai_group[aigroup].aigroup = aigroup;
    level._ai_group[aigroup].aicount = 0;
    level._ai_group[aigroup].killed_count = 0;
    level._ai_group[aigroup].ai = [];
    level._ai_group[aigroup].spawners = [];
    level._ai_group[aigroup].cleared_count = 0;
    if(!isDefined(level.flag[aigroup + "_cleared"])) {
      level flag::init(aigroup + "_cleared");
    }
    if(!isDefined(level.flag[aigroup + "_spawning"])) {
      level flag::init(aigroup + "_spawning");
    }
    level thread set_ai_group_cleared_flag(level._ai_group[aigroup]);
  }
  if(isDefined(spawner)) {
    if(!isDefined(level._ai_group[aigroup].spawners)) {
      level._ai_group[aigroup].spawners = [];
    } else if(!isarray(level._ai_group[aigroup].spawners)) {
      level._ai_group[aigroup].spawners = array(level._ai_group[aigroup].spawners);
    }
    level._ai_group[aigroup].spawners[level._ai_group[aigroup].spawners.size] = spawner;
    spawner thread aigroup_spawner_death(level._ai_group[aigroup]);
  }
}

function aigroup_spawner_death(tracker) {
  self util::waittill_any("death", "aigroup_spawner_death");
  tracker notify("update_aigroup");
}

function aigroup_think(tracker) {
  tracker.aicount++;
  tracker.ai[tracker.ai.size] = self;
  tracker notify("update_aigroup");
  if(isDefined(self.script_deathflag_longdeath)) {
    self waittilldeathorpaindeath();
  } else {
    self waittill("death");
  }
  tracker.aicount--;
  tracker.killed_count++;
  tracker notify("update_aigroup");
  wait(0.05);
  tracker.ai = array::remove_undefined(tracker.ai);
}

function set_ai_group_cleared_flag(tracker) {
  waittillframeend();
  while((tracker.aicount + get_ai_group_spawner_count(tracker.aigroup)) > tracker.cleared_count) {
    tracker waittill("update_aigroup");
  }
  level flag::set(tracker.aigroup + "_cleared");
}

function flood_trigger_think(trigger) {
  assert(isDefined(trigger.target), ("" + trigger.origin) + "");
  floodspawners = getEntArray(trigger.target, "targetname");
  assert(floodspawners.size, ("" + trigger.target) + "");
  for(i = 0; i < floodspawners.size; i++) {
    floodspawners[i].script_trigger = trigger;
  }
  array::thread_all(floodspawners, &flood_spawner_init);
  trigger waittill("trigger");
  floodspawners = getEntArray(trigger.target, "targetname");
  array::thread_all(floodspawners, &flood_spawner_think, trigger);
}

function flood_spawner_init(spawner) {
  assert(isDefined(self.spawnflags) && (self.spawnflags & 1) == 1, (("" + self.origin) + "") + self getorigin() + "");
}

function trigger_requires_player(trigger) {
  if(!isDefined(trigger)) {
    return 0;
  }
  return isDefined(trigger.script_requires_player);
}

function flood_spawner_think(trigger) {
  self endon("death");
  self notify("hash_87140c16");
  self endon("hash_87140c16");
  requires_player = trigger_requires_player(trigger);
  util::script_delay();
  while(self.count > 0) {
    if(requires_player) {
      while(!util::any_player_is_touching(trigger)) {
        wait(0.5);
      }
    }
    soldier = self spawn();
    if(spawn_failed(soldier)) {
      wait(2);
      continue;
    }
    soldier thread reincrement_count_if_deleted(self);
    soldier waittill("death", attacker);
    if(!player_saw_kill(soldier, attacker)) {
      self.count++;
    }
    if(!isDefined(soldier)) {
      continue;
    }
    if(!util::script_wait(1)) {
      players = getplayers();
      if(players.size == 1) {
        wait(randomfloatrange(5, 9));
      } else {
        if(players.size == 2) {
          wait(randomfloatrange(3, 6));
        } else {
          if(players.size == 3) {
            wait(randomfloatrange(1, 4));
          } else if(players.size == 4) {
            wait(randomfloatrange(0.5, 1.5));
          }
        }
      }
    }
  }
}

function player_saw_kill(guy, attacker) {
  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return 1;
    }
  }
  if(!isDefined(guy)) {
    return 0;
  }
  if(isalive(attacker)) {
    if(isplayer(attacker)) {
      return 1;
    }
    players = getplayers();
    for(q = 0; q < players.size; q++) {
      if(distancesquared(attacker.origin, players[q].origin) < 40000) {
        return 1;
      }
    }
  } else if(isDefined(attacker)) {
    if(attacker.classname == "worldspawn") {
      return 0;
    }
    player = util::get_closest_player(attacker.origin);
    if(isDefined(player) && distancesquared(attacker.origin, player.origin) < 40000) {
      return 1;
    }
  }
  closest_player = util::get_closest_player(guy.origin);
  if(isDefined(closest_player) && distancesquared(guy.origin, closest_player.origin) < 40000) {
    return 1;
  }
  return bullettracepassed(closest_player getEye(), guy getEye(), 0, undefined);
}

function show_bad_path() {
  self endon("death");
  last_bad_path_time = -5000;
  bad_path_count = 0;
  for(;;) {
    self waittill("bad_path", badpathpos);
    if(!isDefined(level.debug_badpath) || !level.debug_badpath) {
      continue;
    }
    if((gettime() - last_bad_path_time) > 5000) {
      bad_path_count = 0;
    } else {
      bad_path_count++;
    }
    last_bad_path_time = gettime();
    if(bad_path_count < 10) {
      continue;
    }
    for(p = 0; p < 200; p++) {
      line(self.origin, badpathpos, (1, 0.4, 0.1), 0, 200);
      wait(0.05);
    }
  }
}

function watches_for_friendly_fire() {
  return true;
}

function spawn(b_force = 0, str_targetname, v_origin, v_angles, bignorespawninglimit) {
  if(isDefined(level.overrideglobalspawnfunc) && self.team == "axis") {
    return [[level.overrideglobalspawnfunc]](b_force, str_targetname, v_origin, v_angles);
  }
  e_spawned = undefined;
  force_spawn = 0;
  makeroom = 0;
  infinitespawn = 0;
  deleteonzerocount = 0;
  if(getdvarstring("") != "") {
    return;
  }
  if(!check_player_requirements()) {
    return;
  }
  while(true) {
    if(!(isDefined(bignorespawninglimit) && bignorespawninglimit) && (!(isDefined(self.ignorespawninglimit) && self.ignorespawninglimit))) {
      global_spawn_throttle(1);
    }
    if(sessionmodeiscampaignzombiesgame() && !isDefined(self)) {
      return;
    }
    if(isDefined(self.lastspawntime) && self.lastspawntime >= gettime()) {
      wait(0.05);
      continue;
    }
    break;
  }
  if(isactorspawner(self)) {
    if(isDefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
      makeroom = 1;
    }
  } else if(isvehiclespawner(self)) {
    if(isDefined(self.spawnflags) && (self.spawnflags & 8) == 8) {
      makeroom = 1;
    }
  }
  if(b_force || (isDefined(self.spawnflags) && (self.spawnflags & 16) == 16) || isDefined(self.script_forcespawn)) {
    force_spawn = 1;
  }
  if(isDefined(self.spawnflags) && (self.spawnflags & 64) == 64) {
    infinitespawn = 1;
  }
  if(isDefined(level.archetype_spawners) && isarray(level.archetype_spawners)) {
    archetype_spawner = undefined;
    if(self.team == "") {
      archetype = getdvarstring("");
      if(getdvarstring("") == "") {
        archetype = getdvarstring("");
      }
      archetype_spawner = level.archetype_spawners[archetype];
    } else if(self.team == "") {
      archetype = getdvarstring("");
      if(getdvarstring("") == "") {
        archetype = getdvarstring("");
      }
      archetype_spawner = level.archetype_spawners[archetype];
    }
    if(isspawner(archetype_spawner)) {
      while(isDefined(archetype_spawner.lastspawntime) && archetype_spawner.lastspawntime >= gettime()) {
        wait(0.05);
      }
      originalorigin = archetype_spawner.origin;
      originalangles = archetype_spawner.angles;
      originaltarget = archetype_spawner.target;
      originaltargetname = archetype_spawner.targetname;
      archetype_spawner.target = self.target;
      archetype_spawner.targetname = self.targetname;
      archetype_spawner.script_noteworthy = self.script_noteworthy;
      archetype_spawner.script_string = self.script_string;
      archetype_spawner.origin = self.origin;
      archetype_spawner.angles = self.angles;
      e_spawned = archetype_spawner spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
      archetype_spawner.target = originaltarget;
      archetype_spawner.targetname = originaltargetname;
      archetype_spawner.origin = originalorigin;
      archetype_spawner.angles = originalangles;
      if(isDefined(archetype_spawner.spawnflags) && (archetype_spawner.spawnflags & 64) == 64) {
        archetype_spawner.count++;
      }
      archetype_spawner.lastspawntime = gettime();
    }
  }
  if(!isDefined(e_spawned)) {
    female_override = undefined;
    use_female = randomint(100) < level.female_percent;
    if(level.dont_use_female_replacements === 1) {
      use_female = 0;
    }
    if(use_female && isDefined(self.aitypevariant)) {
      e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, "actor_" + self.aitypevariant);
    } else {
      override_aitype = undefined;
      if(isDefined(level.override_spawned_aitype_func)) {
        override_aitype = [[level.override_spawned_aitype_func]](self);
      }
      if(isDefined(override_aitype)) {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, override_aitype);
      } else {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
      }
    }
  }
  if(isDefined(e_spawned)) {
    if(isDefined(level.run_custom_function_on_ai)) {
      if(isDefined(archetype_spawner)) {
        e_spawned thread[[level.run_custom_function_on_ai]](archetype_spawner, str_targetname, force_spawn);
      } else {
        e_spawned thread[[level.run_custom_function_on_ai]](self, str_targetname, force_spawn);
      }
    }
    if(isDefined(v_origin) || isDefined(v_angles)) {
      e_spawned teleport_spawned(v_origin, v_angles);
    }
    self.lastspawntime = gettime();
  }
  if(deleteonzerocount || (isDefined(self.script_delete_on_zero) && self.script_delete_on_zero) && isDefined(self.count) && self.count <= 0) {
    self delete();
  }
  if(issentient(e_spawned)) {
    if(!spawn_failed(e_spawned)) {
      return e_spawned;
    }
  } else {
    return e_spawned;
  }
}

function teleport_spawned(v_origin = self.origin, v_angles = self.angles, b_reset_entity = 1) {
  if(isactor(self)) {
    self forceteleport(v_origin, v_angles, 1, b_reset_entity);
  } else {
    self.origin = v_origin;
    self.angles = v_angles;
  }
}

function check_player_requirements() {
  if(isDefined(level.players) && level.players.size > 0) {
    n_player_count = level.players.size;
  } else {
    n_player_count = getnumexpectedplayers();
  }
  if(isDefined(self.script_minplayers)) {
    if(n_player_count < self.script_minplayers) {
      self delete();
      return false;
    }
  }
  if(isDefined(self.script_numplayers)) {
    if(n_player_count < self.script_numplayers) {
      self delete();
      return false;
    }
  }
  if(isDefined(self.script_maxplayers)) {
    if(n_player_count > self.script_maxplayers) {
      self delete();
      return false;
    }
  }
  return true;
}

function spawn_failed(spawn) {
  if(isalive(spawn)) {
    if(!isDefined(spawn.finished_spawning)) {
      spawn waittill("hash_f42b7e06");
    }
    waittillframeend();
    if(isalive(spawn)) {
      return false;
    }
  }
  return true;
}

function kill_spawnernum(number) {
  foreach(sp in getspawnerarray("" + number, "script_killspawner")) {
    sp delete();
  }
}

function disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

function replace_on_death() {
  colors::colornode_replace_on_death();
}

function set_ai_group_cleared_count(aigroup, count) {
  aigroup_init(aigroup);
  level._ai_group[aigroup].cleared_count = count;
}

function waittill_ai_group_cleared(aigroup) {
  assert(isDefined(level._ai_group[aigroup]), ("" + aigroup) + "");
  level flag::wait_till(aigroup + "_cleared");
}

function waittill_ai_group_count(aigroup, count) {
  while((get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount) > count) {
    level._ai_group[aigroup] waittill("update_aigroup");
  }
}

function waittill_ai_group_ai_count(aigroup, count) {
  while(level._ai_group[aigroup].aicount > count) {
    level._ai_group[aigroup] waittill("update_aigroup");
  }
}

function waittill_ai_group_spawner_count(aigroup, count) {
  while(get_ai_group_spawner_count(aigroup) > count) {
    level._ai_group[aigroup] waittill("update_aigroup");
  }
}

function waittill_ai_group_amount_killed(aigroup, amount_killed) {
  while(level._ai_group[aigroup].killed_count < amount_killed) {
    level._ai_group[aigroup] waittill("update_aigroup");
  }
}

function get_ai_group_count(aigroup) {
  return get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount;
}

function get_ai_group_sentient_count(aigroup) {
  return level._ai_group[aigroup].aicount;
}

function get_ai_group_spawner_count(aigroup) {
  n_count = 0;
  foreach(sp in level._ai_group[aigroup].spawners) {
    if(isDefined(sp)) {
      n_count = n_count + sp.count;
    }
  }
  return n_count;
}

function get_ai_group_ai(aigroup) {
  aiset = [];
  for(index = 0; index < level._ai_group[aigroup].ai.size; index++) {
    if(!isalive(level._ai_group[aigroup].ai[index])) {
      continue;
    }
    aiset[aiset.size] = level._ai_group[aigroup].ai[index];
  }
  return aiset;
}

function add_global_spawn_function(team, spawn_func, param1, param2, param3, param4, param5) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }
  if(!isDefined(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = [];
  }
  func = [];
  func["function"] = spawn_func;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func["param5"] = param5;
  if(!isDefined(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = [];
  } else if(!isarray(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = array(level.spawn_funcs[team]);
  }
  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

function add_archetype_spawn_function(archetype, spawn_func, param1, param2, param3, param4, param5) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }
  if(!isDefined(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = [];
  }
  func = [];
  func["function"] = spawn_func;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func["param5"] = param5;
  if(!isDefined(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = [];
  } else if(!isarray(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
  }
  level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

function remove_global_spawn_function(team, func) {
  if(isDefined(level.spawn_funcs) && isDefined(level.spawn_funcs[team])) {
    array = [];
    for(i = 0; i < level.spawn_funcs[team].size; i++) {
      if(level.spawn_funcs[team][i]["function"] != func) {
        array[array.size] = level.spawn_funcs[team][i];
      }
    }
    level.spawn_funcs[team] = array;
  }
}

function add_spawn_function(spawn_func, param1, param2, param3, param4, param5) {
  assert(!isDefined(level._loadstarted) || !isalive(self), "");
  func = [];
  func["function"] = spawn_func;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func["param5"] = param5;
  if(!isDefined(self.spawn_funcs)) {
    self.spawn_funcs = [];
  }
  self.spawn_funcs[self.spawn_funcs.size] = func;
}

function remove_spawn_function(func) {
  assert(!isDefined(level._loadstarted) || !isalive(self), "");
  if(isDefined(self.spawn_funcs)) {
    array = [];
    for(i = 0; i < self.spawn_funcs.size; i++) {
      if(self.spawn_funcs[i]["function"] != func) {
        array[array.size] = self.spawn_funcs[i];
      }
    }
    assert(self.spawn_funcs.size != array.size, "");
    self.spawn_funcs = array;
  }
}

function add_spawn_function_group(str_value, str_key = "targetname", func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_value), "");
  assert(isDefined(func_spawn), "");
  a_spawners = getspawnerarray(str_value, str_key);
  array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

function add_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_aigroup), "");
  assert(isDefined(func_spawn), "");
  a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
  array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

function remove_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_aigroup), "");
  assert(isDefined(func_spawn), "");
  a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
  array::run_all(a_spawners, &remove_spawn_function, func_spawn);
}

function simple_flood_spawn(name, spawn_func, spawn_func_2) {
  spawners = getEntArray(name, "targetname");
  assert(spawners.size, ("" + name) + "");
  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func);
    }
  }
  if(isDefined(spawn_func_2)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func_2);
    }
  }
  for(i = 0; i < spawners.size; i++) {
    if(i % 2) {
      util::wait_network_frame();
    }
    spawners[i] thread flood_spawner_init();
    spawners[i] thread flood_spawner_think();
  }
}

function simple_spawn(name_or_spawners, spawn_func, param1, param2, param3, param4, param5, bforce) {
  spawners = [];
  if(isstring(name_or_spawners)) {
    spawners = getEntArray(name_or_spawners, "targetname");
    assert(spawners.size, ("" + name_or_spawners) + "");
  } else {
    if(!isDefined(name_or_spawners)) {
      name_or_spawners = [];
    } else if(!isarray(name_or_spawners)) {
      name_or_spawners = array(name_or_spawners);
    }
    spawners = name_or_spawners;
  }
  a_spawned = [];
  foreach(sp in spawners) {
    e_spawned = sp spawn(bforce);
    if(isDefined(e_spawned)) {
      if(isDefined(spawn_func)) {
        util::single_thread(e_spawned, spawn_func, param1, param2, param3, param4, param5);
      }
      if(!isDefined(a_spawned)) {
        a_spawned = [];
      } else if(!isarray(a_spawned)) {
        a_spawned = array(a_spawned);
      }
      a_spawned[a_spawned.size] = e_spawned;
    }
  }
  return a_spawned;
}

function simple_spawn_single(name_or_spawner, spawn_func, param1, param2, param3, param4, param5, bforce) {
  ai = simple_spawn(name_or_spawner, spawn_func, param1, param2, param3, param4, param5, bforce);
  assert(ai.size <= 1, "");
  if(ai.size) {
    return ai[0];
  }
}

function set_targets(spawner_targets) {
  self thread go_to_spawner_target(strtok(spawner_targets, " "));
}

function getscoreinfoxp(type) {
  if(isDefined(level.scoreinfo) && isDefined(level.scoreinfo[type])) {
    n_xp = level.scoreinfo[type][""];
    if(isDefined(level.xpmodifiercallback) && isDefined(n_xp)) {
      n_xp = [[level.xpmodifiercallback]](type, n_xp);
    }
    return n_xp;
  }
}

function autoexec init_npcdeathtracking() {
  level.a_npcdeaths = [];
  level.str_killsoutput = "";
  callback::add_callback("hash_8c38c12e", &track_npc_deaths);
  callback::add_callback("hash_acb66515", &track_vehicle_deaths);
  callback::add_callback("hash_7b543e98", &show_actor_damage);
  callback::add_callback("hash_9bd1e27f", &show_vehicle_damage);
  setdvar("", 0);
  setdvar("", 0);
  setdvar("", 0);
  setdvar("", 0);
  level thread listenfornpcdeaths();
}

function track_vehicle_deaths(params) {
  b_killed_by_player = 0;
  if(isDefined(params) && isplayer(params.eattacker)) {
    b_killed_by_player = 1;
    if(getdvarint("")) {
      n_xp_value = getscoreinfoxp("" + self.scoretype);
      v_death_position = self.origin;
      n_print_height = 50;
      if(isDefined(self.height)) {
        n_print_height = self.height;
      }
      v_death_position = v_death_position + (0, 0, n_print_height);
      show_xp_popup_for_enemy(n_xp_value, v_death_position);
    }
  }
  adddeadnpctolist(b_killed_by_player);
}

function track_npc_deaths(params) {
  b_killed_by_player = 0;
  if(isplayer(params.eattacker)) {
    b_killed_by_player = 1;
    if(getdvarint("")) {
      n_xp_value = getscoreinfoxp("" + self.scoretype);
      v_death_position = self.origin;
      n_print_height = 72;
      if(isDefined(self.goalheight)) {
        n_print_height = self.goalheight - 12;
      }
      v_death_position = v_death_position + (0, 0, n_print_height);
      show_xp_popup_for_enemy(n_xp_value, v_death_position);
    }
  }
  adddeadnpctolist(b_killed_by_player);
}

function show_actor_damage(params) {
  v_print_pos = (0, 0, 0);
  n_damage_value = params.idamage;
  if(getdvarstring("") == "") {
    if(isDefined(self gettagorigin(""))) {
      v_position = self gettagorigin("") + vectorscale((0, 0, 1), 18);
    } else {
      v_position = self getorigin() + vectorscale((0, 0, 1), 78);
    }
    level thread show_number_popup(n_damage_value, v_position, "", "", (0.96, 0.12, 0.12), 1, 0.6);
  }
}

function show_vehicle_damage(params) {
  v_print_pos = (0, 0, 0);
  n_damage_value = params.idamage;
  if(getdvarstring("") == "") {
    v_print_pos = self.origin;
    n_print_height = 50;
    if(isDefined(self.height)) {
      n_print_height = self.height;
    }
    v_print_pos = v_print_pos + (0, 0, n_print_height);
    level thread show_number_popup(n_damage_value, v_print_pos, "", "", (0.96, 0.12, 0.12), 1, 0.6);
  }
}

function show_xp_popup_for_enemy(n_xp_value, v_position) {
  level thread show_number_popup(n_xp_value, v_position, "", "", (0.83, 0.18, 0.76), 1, 0.7);
}

function show_number_popup(n_value, v_pos, string_prefix, string_suffix, color, n_alpha, n_size) {
  n_current_tick = 0;
  n_current_alpha = n_alpha;
  v_print_position = v_pos;
  while(n_current_tick < 40) {
    v_print_position = v_print_position + (0, 0, 1.125);
    print3d(v_print_position, (string_prefix + n_value) + string_suffix, color, n_current_alpha, n_size, 1);
    if(n_current_tick >= 20) {
      n_current_alpha = n_current_alpha - (1 / 20);
    }
    wait(0.05);
    n_current_tick++;
  }
}

function get_xp_value_for_enemy(e_enemy) {
  n_xp_value = getscoreinfoxp("" + e_enemy.scoretype);
  if(isDefined(n_xp_value)) {
    return n_xp_value;
  }
  return 0;
}

function adddeadnpctolist(b_killed_by_player) {
  if(!isDefined(self)) {
    return;
  }
  if(self.team == "" || self.team == "") {
    bentryexists = 0;
    for(i = 0; i < level.a_npcdeaths.size; i++) {
      if(level.a_npcdeaths[i].strscoretype == self.scoretype) {
        level.a_npcdeaths[i].icount = level.a_npcdeaths[i].icount + 1;
        if(b_killed_by_player) {
          level.a_npcdeaths[i].ikilledbyplayercount = level.a_npcdeaths[i].ikilledbyplayercount + 1;
          if(isDefined(level.a_npcdeaths[i].ixpvaluesum)) {
            level.a_npcdeaths[i].ixpvaluesum = level.a_npcdeaths[i].ixpvaluesum + get_xp_value_for_enemy(self);
          }
        }
        bentryexists = 1;
      }
    }
    if(!bentryexists) {
      s_npcdeath = spawnStruct();
      s_npcdeath.strscoretype = self.scoretype;
      s_npcdeath.icount = 1;
      s_npcdeath.ikilledbyplayercount = 0;
      s_npcdeath.ixpvaluesum = 0;
      if(b_killed_by_player) {
        s_npcdeath.ikilledbyplayercount = 1;
        s_npcdeath.ixpvaluesum = get_xp_value_for_enemy(self);
      }
      itypesofnpcskilled = level.a_npcdeaths.size;
      level.a_npcdeaths[itypesofnpcskilled] = s_npcdeath;
    }
  }
}

function listenfornpcdeaths() {
  while(true) {
    checkfordeathtrackingreset();
    if(getdvarint("") == 1) {
      if(!isDefined(level.npc_death_tracking_hud_text)) {
        level.npc_death_tracking_hud_text = newhudelem();
        level.npc_death_tracking_hud_text.alignx = "";
        level.npc_death_tracking_hud_text.x = 50;
        level.npc_death_tracking_hud_text.y = 60;
        level.npc_death_tracking_hud_text.fontscale = 1.5;
        level.npc_death_tracking_hud_text.color = (1, 1, 1);
        iprintlnbold("");
      } else {
        level.s_killsoutput = ((("" + getaiteamarray("").size) + "") + getaiteamarray("").size) + "";
        level.s_killsoutput = level.s_killsoutput + "";
        if(level.a_npcdeaths.size == 0) {
          level.s_killsoutput = level.s_killsoutput + "";
        } else {
          foreach(deadnpctypecount in level.a_npcdeaths) {
            level.s_killsoutput = (((((level.s_killsoutput + deadnpctypecount.strscoretype) + "") + deadnpctypecount.icount) + "") + deadnpctypecount.ikilledbyplayercount) + "";
          }
        }
        if(getdvarint("") == 1) {
          level.npc_death_tracking_hud_text settext(level.s_killsoutput);
        }
      }
    } else if(isDefined(level.npc_death_tracking_hud_text)) {
      level.npc_death_tracking_hud_text destroy();
      iprintlnbold("");
    }
    wait(0.25);
  }
}

function checkfordeathtrackingreset() {
  if(getdvarint("") == 1) {
    level.a_npcdeaths = [];
    iprintln("");
    setdvar("", 0);
  }
}

function autoexec init_female_spawn() {
  level.female_percent = 0;
  set_female_percent(30);
}

function set_female_percent(percent) {
  level.female_percent = percent;
}