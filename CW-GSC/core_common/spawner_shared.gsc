/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spawner_shared.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\smart_object;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace spawner;

function private autoexec __init__system__() {
  system::register(#"spawner", &preinit, undefined, &finalize, undefined);
}

function private preinit() {
  level._ai_group = [];
  level.missionfailed = 0;
  level.deathflags = [];
  level.go_to_node_arrays = [];
  level.global_spawn_timer = 0;
  level.global_spawn_count = 0;
  level.var_aa384fe2[# "origin"] = &get_target_ents;
  level.var_aa384fe2[# "ent"] = &get_target_ents;
  level.var_aa384fe2[# "node"] = &get_target_nodes;
  level.var_aa384fe2[# "struct"] = &get_target_structs;
  level.var_c4e6faf2[# "origin"] = &go_to_node_set_goal_pos;
  level.var_c4e6faf2[# "ent"] = &go_to_node_set_goal_ent;
  level.var_c4e6faf2[# "struct"] = &function_890856aa;
  level.var_c4e6faf2[# "node"] = &go_to_node_set_goal_node;
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    spawners[i] thread spawn_prethink();
  }

  level.ai = [];
  add_global_spawn_function(#"axis", &global_ai_array);
  add_global_spawn_function(#"allies", &global_ai_array);
  add_global_spawn_function(#"team3", &global_ai_array);

  level thread aigroup_debug();
}

function private finalize() {
  ai = getaispeciesarray("all");
  array::thread_all(ai, &living_ai_prethink);

  foreach(ai_guy in ai) {
    if(isalive(ai_guy)) {
      ai_guy thread spawn_think();
    }
  }

  level thread spawn_throttle_reset();
}

function global_ai_array() {
  if(!isDefined(level.ai[self.team])) {
    level.ai[self.team] = [];
  } else if(!isarray(level.ai[self.team])) {
    level.ai[self.team] = array(level.ai[self.team]);
  }

  level.ai[self.team][level.ai[self.team].size] = self;
  self waittill(#"death");

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

    return;
  }

  foreach(array in level.ai) {
    for(i = array.size - 1; i >= 0; i--) {
      if(!isDefined(array[i])) {
        arrayremoveindex(array, i);
      }
    }
  }
}

function spawn_throttle_reset() {
  while(true) {
    util::wait_network_frame();
    level.global_spawn_count = 0;
  }
}

function global_spawn_throttle(n_count_per_network_frame = 4) {
  if(!is_true(level.first_frame)) {
    while(level.global_spawn_count >= n_count_per_network_frame) {
      waitframe(1);
    }

    level.global_spawn_count++;
  }
}

function spawn_prethink() {
  assert(self != level);

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

function spawn_think(spawner) {
  self endon(#"death");

  if(isDefined(self.spawn_think_thread_active)) {
    return;
  }

  self.spawn_think_thread_active = 1;
  assert(isactor(self) || isvehicle(self), "<dev string:x38>" + "<dev string:x50>");

  if(!isvehicle(self)) {
    if(!isalive(self)) {
      return;
    }

    self.maxhealth = self.health;
  }

  self.script_animname = undefined;

  if(isDefined(self.script_aigroup)) {
    level flag::set(self.script_aigroup + "_spawning");
    self thread aigroup_think(level._ai_group[self.script_aigroup]);
  }

  if(isDefined(spawner) && isDefined(spawner.script_dropammo)) {
    self.disableammodrop = !spawner.script_dropammo;
  } else if(isDefined(self.script_dropammo)) {
    self.disableammodrop = !self.script_dropammo;
  }

  if(isDefined(spawner.var_86f65a6)) {
    self.fixednode = spawner.var_86f65a6;
  } else if(isDefined(self.var_86f65a6)) {
    self.fixednode = self.var_86f65a6;
  }

  if(isDefined(spawner) && isDefined(spawner.var_9d17efa5)) {
    self.script_accuracy = spawner.var_9d17efa5;
  } else if(isDefined(self.var_9d17efa5)) {
    self.script_accuracy = self.var_9d17efa5;
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
}

function run_spawn_functions() {
  self endon(#"death");

  if(!isDefined(level.spawn_funcs)) {
    return;
  }

  if(isDefined(level.spawn_funcs[# "all"])) {
    for(i = 0; i < level.spawn_funcs[# "all"].size; i++) {
      func = level.spawn_funcs[# "all"][i];
      util::single_thread_argarray(self, func[# "function"], func[# "params"]);
    }
  }

  if(isDefined(self.archetype) && isDefined(level.spawn_funcs[self.archetype])) {
    for(i = 0; i < level.spawn_funcs[self.archetype].size; i++) {
      func = level.spawn_funcs[self.archetype][i];
      util::single_thread_argarray(self, func[# "function"], func[# "params"]);
    }
  }

  waittillframeend();
  callback::callback(#"on_ai_spawned");

  if(isDefined(level.spawn_funcs[self.team])) {
    for(i = 0; i < level.spawn_funcs[self.team].size; i++) {
      func = level.spawn_funcs[self.team][i];
      util::single_thread_argarray(self, func[# "function"], func[# "params"]);
    }
  }

  if(isDefined(self.spawn_funcs)) {
    for(i = 0; i < self.spawn_funcs.size; i++) {
      func = self.spawn_funcs[i];
      util::single_thread_argarray(self, func[# "function"], func[# "params"]);
    }

    var_f9bfb16c = self.spawn_funcs;

    self.spawn_funcs = undefined;

    self.spawn_funcs = var_f9bfb16c;
  }

  if(isDefined(self.archetype) && isDefined(level.spawn_funcs[self.archetype + "_post"])) {
    for(i = 0; i < level.spawn_funcs[self.archetype + "_post"].size; i++) {
      func = level.spawn_funcs[self.archetype + "_post"][i];
      util::single_thread_argarray(self, func[# "function"], func[# "params"]);
    }
  }

  self.finished_spawning = 1;
  self notify(#"finished spawning");
}

function living_ai_prethink() {
  if(isDefined(self.target)) {
    crawl_through_targets_to_init_flags();
  }
}

function crawl_through_targets_to_init_flags() {
  array = get_node_funcs_based_on_target();

  if(isDefined(array)) {
    targets = array[# "node"];
    get_func = array[# "get_target_func"];

    for(i = 0; i < targets.size; i++) {
      crawl_target_and_init_flags(targets[i], get_func);
    }
  }
}

function remove_spawner_values() {
  self.spawner_number = undefined;
  self.script_scene_entities = undefined;
}

function spawn_think_action(spawner) {
  remove_spawner_values();

  if(isDefined(spawner)) {
    if(!isDefined(self.targetname)) {
      self.targetname = spawner.targetname;
    }
  }

  if(isDefined(spawner) && isDefined(spawner.script_animname)) {
    self.animname = spawner.script_animname;
  } else if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
  }

  if(isDefined(self.script_forcecolor)) {
    colors::set_force_color(self.script_forcecolor);
  }

  if(isDefined(self.script_ignoreme)) {
    assert(self.script_ignoreme == 1, "<dev string:x77>");
    self val::set_radiant("ignoreme", 1);
  }

  if(isDefined(self.script_ignoreall)) {
    assert(self.script_ignoreall == 1, "<dev string:xcd>");
    self val::set_radiant("ignoreall", 1);
  }

  if(isDefined(self.script_grenades)) {
    self.grenadeammo = self.script_grenades;
  }

  if(isDefined(self.script_pacifist)) {
    self.pacifist = 1;
  }

  if(isDefined(self.script_allowdeath)) {
    self.allowdeath = self.script_allowdeath;
  }

  if(isDefined(self.script_forcegib)) {
    self.force_gib = 1;
  }

  if(isDefined(self.var_1d78e529)) {
    self.delete_on_path_end = 1;
  }

  if(isDefined(spawner.script_demeanor)) {
    self.script_demeanor = spawner.script_demeanor;
  }

  if(isDefined(spawner.var_b1d64777)) {
    self inventory_chopper_gunner(1);
  }

  if(isDefined(self.target) && !isDefined(self.script_disable_spawn_targeting)) {
    var_8e8b0300 = 0;
    a_s_targets = struct::get_array(self.target);

    foreach(s_target in a_s_targets) {
      if(s_target.classname === "scriptbundle_scene") {
        self thread function_27fb21d8(s_target);
        var_8e8b0300 = 1;
        break;
      }
    }

    if(!var_8e8b0300) {
      e_goal = getent(self.target, "targetname");

      if(isDefined(e_goal) && e_goal.classname !== "info_volume") {
        self setgoal(e_goal);
      } else {
        self thread go_to_node();
      }
    }

    return;
  }

  self thread function_5c5e2093();
}

function function_27fb21d8(s_scene) {
  self endon(#"death");
  waittillframeend();
  s_scene scene::play(self);

  if(self flag::get("in_action")) {
    return;
  }

  e_goal = getent(self.target, "targetname");

  if(isDefined(e_goal)) {
    self setgoal(e_goal);
    return;
  }

  if(isDefined(s_scene.target)) {
    self ai::set_goal(s_scene.target);
    return;
  }

  self thread go_to_node();
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

function go_to_origin(origin, optional_arrived_at_node_func) {
  self go_to_node(origin, "origin", optional_arrived_at_node_func);
}

function go_to_struct(struct, optional_arrived_at_node_func) {
  self go_to_node(struct, "struct", optional_arrived_at_node_func);
}

function go_to_node(node, goal_type, optional_arrived_at_node_func) {
  self endon(#"death");
  array = get_node_funcs_based_on_target(node, goal_type);

  if(!isDefined(array)) {
    self notify(#"reached_path_end");
    return;
  }

  if(!isDefined(optional_arrived_at_node_func)) {
    optional_arrived_at_node_func = &util::void;
  }

  go_to_node_using_funcs(array[# "node"], optional_arrived_at_node_func);
}

function function_461ce3e9() {
  var_e0e751a9 = self.go_to_node;
  self notify(#"stop_going_to_node");
  return var_e0e751a9;
}

function private get_least_used_from_array(array) {
  assert(array.size > 0, "<dev string:x124>");

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

  for(i = 0; i < array.size - 1; i++) {
    newarray[i] = array[i + 1];
  }

  newarray[array.size - 1] = array[0];
  level.go_to_node_arrays[targetname] = newarray;
  return first;
}

function private function_b6317f7e(node) {
  if(!isDefined(node.target)) {
    return true;
  }

  if(node util::function_de0e7bbd()) {
    return true;
  }

  if(isDefined(node.script_flag_wait) || node util::function_e387bcd()) {
    return true;
  }

  targetnode = getnode(node.target, "targetname");

  if(isDefined(targetnode) && node_has_radius(targetnode)) {
    if(distancesquared(node.origin, targetnode.origin) < sqr(targetnode.radius)) {
      return true;
    }
  }

  targetent = getent(node.target, "targetname");

  if(isDefined(targetent) && targetent.classname === "info_volume") {
    if(istouching(node.origin, targetent)) {
      return true;
    }
  }

  return false;
}

function private go_to_node_using_funcs(node, optional_arrived_at_node_func, require_player_dist) {
  self endoncallback(&function_e63d4581, #"stop_going_to_node", #"death");
  startnode = undefined;

  for(;;) {
    node = get_least_used_from_array(node);

    if(!isDefined(startnode)) {
      startnode = node;

      if(!is_true(startnode.var_de28b066)) {
        if(ai::has_behavior_attribute("disablearrivals")) {
          ai::set_behavior_attribute("disablearrivals", 1);
        }
      }
    }

    if(function_b6317f7e(node)) {
      if(ai::has_behavior_attribute("disablearrivals")) {
        ai::set_behavior_attribute("disablearrivals", 0);
      }
    }

    if(isDefined(node.scriptbundlename)) {
      s_bundle = scene::get_scenedef(node.scriptbundlename);

      if(isDefined(s_bundle) && isDefined(s_bundle.objects)) {
        self.var_b8b2cd98 = 0;

        foreach(object in s_bundle.objects) {
          if(object.type === "actor" && is_true(object.disablearrivalinreach)) {
            self.var_b8b2cd98 = 1;
          }
        }

        if(self.var_b8b2cd98 && ai::has_behavior_attribute("disablearrivals")) {
          ai::set_behavior_attribute("disablearrivals", 1);
        }
      }
    }

    array = get_node_funcs_based_on_target(node);
    get_target_func = array[# "get_target_func"];
    set_goal_func_quits = array[# "set_goal_func_quits"];
    self.goalradius = 16;

    if(isDefined(node) && isDefined(node.target)) {
      self.patroller = 1;
    }

    self.go_to_node = node;
    player_wait_dist = require_player_dist;

    if(isDefined(node.script_requires_player)) {
      if(node.script_requires_player > 1) {
        player_wait_dist = node.script_requires_player;
      } else {
        player_wait_dist = 256;
      }

      node.script_requires_player = 0;
    }

    self function_5c5e2093(node);

    if(isDefined(node.height)) {
      self.goalheight = node.height;
    }

    goalpoint = node function_d0bfad14(self);

    if(is_true(self.script_forcegoal) || isDefined(node) && is_true(node.script_forcegoal)) {
      self thread ai::force_goal(goalpoint);
    } else {
      [[set_goal_func_quits]](goalpoint);
    }

    self waittill(#"goal");
    [[optional_arrived_at_node_func]](node);

    if(isDefined(node.script_notify)) {
      self notify(node.script_notify);
      level notify(node.script_notify);
    }

    if(isDefined(node.script_flag_set)) {
      if(!level flag::exists(node.script_flag_set)) {
        level flag::init(node.script_flag_set);
      }

      level flag::set(node.script_flag_set);
    }

    if(isDefined(node.script_flag_clear)) {
      if(!level flag::exists(node.script_flag_clear)) {
        level flag::init(node.script_flag_clear);
      }

      level flag::clear(node.script_flag_clear);
    }

    if(isDefined(node.script_ent_flag_set)) {
      if(!self flag::exists(node.script_ent_flag_set)) {
        self flag::init(node.script_ent_flag_set);
      }

      self flag::set(node.script_ent_flag_set);
    }

    if(isDefined(node.script_ent_flag_clear)) {
      if(!self flag::exists(node.script_ent_flag_clear)) {
        self flag::init(node.script_ent_flag_clear);
      }

      self flag::clear(node.script_ent_flag_clear);
    }

    if(smart_object::function_1631909f(node) || isDefined(node.scriptbundlename)) {
      if(smart_object::function_1631909f(node)) {
        if(smart_object::can_use(node)) {
          node smart_object::play(self);
        }
      } else if(isDefined(node.scriptbundlename)) {
        if(4 < self.goalradius) {
          self.goalradius = 4;
          self waittill(#"goal");
        }

        if(node util::function_e387bcd()) {
          node thread scene::play(node.scriptbundlename, self);
        } else {
          node scene::play(node.scriptbundlename, self);
        }
      }
    }

    node util::script_wait();

    if(isDefined(node.script_flag_wait)) {
      level flag::wait_till(node.script_flag_wait);
    }

    if(isDefined(node.var_8e71979c)) {
      var_91cfb325 = strtok(node.var_8e71979c, " ");
      level flag::wait_till_all(var_91cfb325);
    }

    if(isDefined(node.var_a421c52c)) {
      var_b177ca91 = strtok(node.var_a421c52c, " ");
      level flag::wait_till_any(var_b177ca91);
    }

    while(isDefined(node.script_requires_player)) {
      node.script_requires_player = 0;

      if(self go_to_node_wait_for_player(node, get_target_func, player_wait_dist)) {
        node.script_requires_player = 1;
        node notify(#"script_requires_player");
        break;
      }

      wait 0.1;
    }

    if(isDefined(node.script_aigroup)) {
      waittill_ai_group_cleared(node.script_aigroup);
    }

    node util::script_delay();

    if(isDefined(node.var_9ec34b3)) {
      node scene::play(node.var_9ec34b3, self);
    }

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = function_eb7a5643(node);

    if(!nextnode_array.size) {
      break;
    }

    node = nextnode_array;
  }

  if(isDefined(self.arrived_at_end_node_func)) {
    [[self.arrived_at_end_node_func]](node);
  }

  self notify(#"reached_path_end");

  if(isDefined(self.delete_on_path_end)) {
    self deletedelay();
  }

  self function_e63d4581();
}

function private function_eb7a5643(node, startnode = node) {
  nextnode_array = update_target_array(node.target);

  if(!isDefined(nextnode_array)) {
    nextnode_array = [];
  } else if(!isarray(nextnode_array)) {
    nextnode_array = array(nextnode_array);
  }

  for(i = nextnode_array.size - 1; i >= 0; i--) {
    if(smart_object::function_1631909f(nextnode_array[i]) && !smart_object::can_use(nextnode_array[i])) {
      if(nextnode_array.size == 1) {
        if(nextnode_array[0] == startnode) {
          return nextnode_array;
        }

        return function_eb7a5643(nextnode_array[0], startnode);
      }

      nextnode_array = arrayremoveindex(nextnode_array, i);
    }
  }

  return nextnode_array;
}

function private function_d0bfad14(ent) {
  if(smart_object::function_1631909f(self)) {
    ent thread smart_object::function_2677ed08(self);
    return self smart_object::get_goal();
  } else if(isDefined(self.scriptbundlename)) {
    return self scene::function_15be7db9(self.scriptbundlename);
  }

  return self;
}

function private function_e63d4581(params) {
  self.patroller = undefined;
  self.go_to_node = undefined;

  if(ai::has_behavior_attribute("disablearrivals")) {
    ai::set_behavior_attribute("disablearrivals", 0);
  }
}

function private go_to_node_wait_for_player(node, get_target_func, dist) {
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

function private go_to_node_set_goal_ent(ent) {
  self ai::set_goal_ent(ent);
}

function private go_to_node_set_goal_pos(ent) {
  self setgoal(ent.origin);
  self ai::function_54115a91(ent);
}

function private function_890856aa(struct) {
  goalradius = undefined;

  if(isactor(self) && isDefined(struct.goalradius)) {
    goalradius = struct.goalradius;
  }

  if(is_true(struct.var_1e38e46d)) {
    self setgoal(struct.origin, undefined, goalradius);
  } else {
    self setgoal(struct.origin, undefined, goalradius, undefined, struct.angles);
  }

  self ai::function_54115a91(struct);
}

function private go_to_node_set_goal_node(node) {
  self ai::set_goal_node(node);
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
  if(!isDefined(goal_type) && isDefined(node)) {
    goal_type = "origin";

    if(ispathnode(node)) {
      goal_type = "node";
    } else if(isstruct(node)) {
      goal_type = "struct";
    } else if(isentity(node)) {
      goal_type = "ent";
    }
  }

  array = [];

  if(isDefined(node)) {
    array[# "node"][0] = node;
  } else {
    if(!isDefined(self.target)) {
      assertmsg("<dev string:x146>");
      return;
    }

    node = getEntArray(self.target, "targetname");

    if(node.size > 0) {
      if(issubstr(node[0].classname, "volume")) {
        goal_type = "ent";
      } else {
        goal_type = "origin";
      }
    }

    if(!isDefined(goal_type) || goal_type == "node") {
      goal_type = "node";
      node = getnodearray(self.target, "targetname");

      if(!node.size) {
        node = struct::get_array(self.target, "targetname");

        if(!node.size) {
          return;
        }

        goal_type = "struct";
      }
    }

    array[# "node"] = node;
  }

  array[# "get_target_func"] = level.var_aa384fe2[goal_type];
  array[# "set_goal_func_quits"] = level.var_c4e6faf2[goal_type];
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

function function_5c5e2093(node) {
  self endon(#"death");
  waittillframeend();

  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(node) && node_has_radius(node)) {
    self.goalradius = node.radius;
  }
}

function get_goal(str_goal, str_key = "targetname") {
  a_goals = arraycombine(getnodearray(str_goal, str_key), getEntArray(str_goal, str_key));
  a_goals = arraycombine(a_goals, struct::get_array(str_goal, str_key));
  return array::random(a_goals);
}

function aigroup_debug() {
  a_aigroups = [];
  a_spawners = getspawnerarray();

  foreach(spawner in a_spawners) {
    if(isDefined(spawner.script_aigroup) && !isinarray(a_aigroups, spawner.script_aigroup)) {
      array::add(a_aigroups, spawner.script_aigroup, 0);
    }
  }

  foreach(aigroup in a_aigroups) {
    cmd = "<dev string:x19d>" + aigroup + "<dev string:x1ba>" + aigroup + "<dev string:x1d3>";
    adddebugcommand(cmd);
  }

  cmd = "<dev string:x19d>" + "<dev string:x1d7>" + "<dev string:x1ba>" + "<dev string:x1d7>" + "<dev string:x1d3>";
  adddebugcommand(cmd);

  while(true) {
    var_d4f26db9 = getdvarstring(#"debug_aigroup", "<dev string:x1d7>");
    var_c708e6e1 = 120;

    if(var_d4f26db9 != "<dev string:x1d7>") {
      debug2dtext((150, var_c708e6e1, 0), "<dev string:x1df>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
      var_c708e6e1 += 22;

      if(isDefined(level._ai_group) && isDefined(level._ai_group[var_d4f26db9]) && isDefined(level._ai_group[var_d4f26db9].ai)) {
        ais = get_ai_group_ai(var_d4f26db9);
        spawners = get_ai_group_spawner_count(var_d4f26db9);
        debug2dtext((150, var_c708e6e1, 0), "<dev string:x20a>" + var_d4f26db9, (1, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
        var_c708e6e1 += 22;
        debug2dtext((150, var_c708e6e1, 0), "<dev string:x1df>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
        var_c708e6e1 += 22;
        debug2dtext((150, var_c708e6e1, 0), "<dev string:x218>" + ais.size, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
        var_c708e6e1 += 22;
        debug2dtext((150, var_c708e6e1, 0), "<dev string:x226>" + spawners, (1, 0, 0), 1, (0, 0, 0), 0.9, 1, 1);
        var_c708e6e1 += 22;

        if(isDefined(level.flag[var_d4f26db9 + "<dev string:x234>"])) {
          flag = level flag::get(var_d4f26db9 + "<dev string:x234>");

          if(flag) {
            debug2dtext((150, var_c708e6e1, 0), "<dev string:x240>", (1, 0.5, 0), 1, (0, 0, 0), 0.9, 1, 1);
          } else {
            debug2dtext((150, var_c708e6e1, 0), "<dev string:x251>", (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
          }

          var_c708e6e1 += 22;
        }

        if(isDefined(level.flag[var_d4f26db9 + "<dev string:x263>"])) {
          flag = level flag::get(var_d4f26db9 + "<dev string:x263>");

          if(flag) {
            debug2dtext((150, var_c708e6e1, 0), "<dev string:x270>", (1, 0.5, 0), 1, (0, 0, 0), 0.9, 1, 1);
          } else {
            debug2dtext((150, var_c708e6e1, 0), "<dev string:x282>", (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
          }

          var_c708e6e1 += 22;
        }

        debug2dtext((150, var_c708e6e1, 0), "<dev string:x1df>", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
        var_c708e6e1 += 22;

        foreach(ai in ais) {
          sphere(ai.origin + (0, 0, 72), 4, (1, 1, 0), 1, 0, 8, 1);
          line(ai.origin + (0, 0, 72), ai.origin + (0, 0, 92), (1, 1, 0), 1, 1);
        }

        foreach(spawner in level._ai_group[var_d4f26db9].spawners) {
          if(isDefined(spawner) && spawner.count > 0) {
            sphere(spawner.origin + (0, 0, 10), 4, (1, 0, 0), 1, 0, 8, 1);
            line(spawner.origin + (0, 0, 10), spawner.origin + (0, 0, 50), (1, 0, 0), 1, 1);
            print3d(spawner.origin + (0, 0, 20), function_9e72a96(spawner.archetype), (1, 0, 0), 1, 0.4, 1);
            print3d(spawner.origin + (0, 0, 30), "<dev string:x295>" + spawner.count, (1, 0, 0), 1, 0.4, 1);
          }
        }
      }
    }

    waitframe(1);
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
  self waittill(#"death", #"hash_4f7ebd2a17a44113");
  waitframe(1);
  tracker notify(#"update_aigroup");
}

function aigroup_think(tracker) {
  tracker.aicount++;
  tracker.ai[tracker.ai.size] = self;
  tracker notify(#"update_aigroup");
  self waittill(#"death");
  waitframe(1);
  tracker.aicount--;
  tracker.killed_count++;
  tracker notify(#"update_aigroup");
  waitframe(1);
  arrayremovevalue(tracker.ai, undefined);
}

function set_ai_group_cleared_flag(tracker) {
  waittillframeend();

  while(tracker.aicount + get_ai_group_spawner_count(tracker.aigroup) > tracker.cleared_count) {
    tracker waittill(#"update_aigroup");
    waitframe(1);
  }

  level flag::set(tracker.aigroup + "_cleared");
}

function trigger_requires_player(trigger) {
  if(!isDefined(trigger)) {
    return false;
  }

  return isDefined(trigger.script_requires_player);
}

function spawn(b_force = 0, str_targetname, v_origin, v_angles, bignorespawninglimit) {
  self endon(#"death");
  e_spawned = undefined;
  force_spawn = 0;
  isdrone = 0;
  makeroom = 0;
  infinitespawn = 0;
  deleteonzerocount = 0;

  if(!check_player_requirements()) {
    return;
  }

  if(isDefined(self.spawnflags) && (self.spawnflags & 64) == 64) {
    infinitespawn = 1;
  }

  if(is_true(bignorespawninglimit)) {
    infinitespawn = 1;
  }

  var_5d24e75f = !infinitespawn && isDefined(self.count) && self.count <= 0;

  while(true) {
    if(!var_5d24e75f && !is_true(self.ignorespawninglimit)) {
      global_spawn_throttle();
    }

    if(isDefined(self.lastspawntime) && self.lastspawntime >= gettime()) {
      waitframe(1);
      continue;
    }

    break;
  }

  if(isactorspawner(self)) {
    if(isDefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
      makeroom = 1;
    }

    if(isDefined(self.spawnflags) && (self.spawnflags & 128) == 128) {
      deleteonzerocount = 1;
    }
  } else if(isvehiclespawner(self)) {
    if(isDefined(self.spawnflags) && (self.spawnflags & 8) == 8) {
      makeroom = 1;
    }
  }

  if(b_force || isDefined(self.spawnflags) && (self.spawnflags & 16) == 16 || isDefined(self.script_forcespawn)) {
    force_spawn = 1;
  }

  if(isDefined(self.script_drone) && self.script_drone != 0) {
    isdrone = 1;
  }

  if(isDefined(self.script_accuracy)) {
    assertmsg("<dev string:x29f>");
  }

  vehiclespawner = self.classname === "<dev string:x2d7>";
  overridevehicle = !is_true(vehiclespawner) || !is_true(level.var_3313aeb2);

  if(isDefined(level.archetype_spawners) && isarray(level.archetype_spawners) && overridevehicle) {
    archetype = undefined;
    archetype_spawner = undefined;

    if(self.team == # "axis") {
      archetype = getdvarstring(#"feature_ai_enemy_archetype");

      if(getdvarstring(#"feature_ai_archetype_override") == # "enemy") {
        archetype = getdvarstring(#"feature_ai_enemy_archetype");
      }

      archetype_spawner = level.archetype_spawners[archetype];
    } else if(self.team == # "allies") {
      archetype = getdvarstring(#"feature_ai_ally_archetype");

      if(getdvarstring(#"feature_ai_archetype_override") == "<dev string:x2e9>") {
        archetype = getdvarstring(#"feature_ai_ally_archetype");
      }

      archetype_spawner = level.archetype_spawners[archetype];
    } else if(self.team == # "team3") {
      if(getdvarstring(#"feature_ai_archetype_override") == # "enemy") {
        archetype = getdvarstring(#"feature_ai_enemy_archetype");
      } else if(getdvarstring(#"feature_ai_archetype_override") == "<dev string:x2e9>") {
        archetype = getdvarstring(#"feature_ai_ally_archetype");
      } else {
        archetype = getdvarstring(#"feature_ai_enemy_archetype");
      }

      archetype_spawner = level.archetype_spawners[archetype];

      if(!isDefined(archetype_spawner)) {
        archetype = getdvarstring(#"feature_ai_ally_archetype");
        archetype_spawner = level.archetype_spawners[archetype];
      }
    }

    if(isspawner(archetype_spawner)) {
      while(isDefined(archetype_spawner.lastspawntime) && archetype_spawner.lastspawntime >= gettime()) {
        waitframe(1);
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

      if(!isDefined(str_targetname)) {
        e_spawned.targetname = archetype_spawner.targetname;
      }

      archetype_spawner.target = originaltarget;
      archetype_spawner.targetname = originaltargetname;
      archetype_spawner.origin = originalorigin;
      archetype_spawner.angles = originalangles;

      if(isDefined(archetype_spawner.spawnflags) && (archetype_spawner.spawnflags & 64) == 64) {
        archetype_spawner.count++;
      }

      archetype_spawner.lastspawntime = gettime();
    } else if(archetype === "<dev string:x2f1>") {
      bot = bot::add_bot(self.team);

      if(isDefined(bot)) {
        bot.botremoveondeath = 1;
        bot bot::function_bab12815(self.origin, self.angles[1]);
        bot bot::function_39d30bb6(is_true(self.script_forcegoal));
        bot waittill(#"spawned_player");
        bot.sessionteam = self.team;
        bot setteam(self.team);

        if(isDefined(bot.pers)) {
          bot.pers[# "team"] = self.team;
        }

        bot.target = self.target;
        bot.targetname = self.targetname + "<dev string:x2f8>";
        bot.script_noteworthy = self.script_noteworthy;
        bot.script_string = self.script_string;
        return bot;
      }
    }
  }

  if(!isDefined(e_spawned)) {
    use_female = randomint(100) < level.female_percent;

    if(level.dont_use_female_replacements === 1) {
      use_female = 0;
    }

    if(use_female && isDefined(self.aitypevariant)) {
      e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, self.aitypevariant);
    } else {
      override_aitype = undefined;

      if(currentsessionmode() === 2 && getdvarint(#"hash_99ad36e628f93d0", 0)) {
        if(isDefined(self) && isactorspawner(self)) {
          if(self.team == # "allies") {
            override_aitype = "<dev string:x2ff>";
          } else if(self.team == # "axis") {
            override_aitype = "<dev string:x320>";
          }
        }
      }

      if(isDefined(level.override_spawned_aitype_func)) {
        override_aitype = [[level.override_spawned_aitype_func]](self);
      }

      if(isDefined(override_aitype)) {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, override_aitype, 0, isdrone);
      } else {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, undefined, 0, isdrone);
      }
    }
  }

  if(isdrone && isDefined(e_spawned)) {
    if(is_true(self.var_60a43fc7)) {
      e_spawned makesentient();
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

  var_e331297b = isDefined(self.count) && self.count <= 0;

  if(var_e331297b && isDefined(self.script_aigroup)) {
    self notify(#"hash_4f7ebd2a17a44113");
  }

  if((deleteonzerocount || is_true(self.script_delete_on_zero)) && var_e331297b) {
    self thread function_d4a13039();
  }

  if(issentient(e_spawned) && !isdrone) {
    result = spawn_failed(e_spawned);

    if(isDefined(result) && result == 0) {
      if(isDefined(self.radius)) {
        goalvolume = e_spawned getgoalvolume();

        if(isDefined(goalvolume)) {
          assertmsg("<dev string:x33a>" + self.origin + "<dev string:x350>" + goalvolume getentnum());
        }

        e_spawned val::set(#"spawn", "goalradius", self.radius);
      }

      self notify(#"hash_66551cac93d16401");
      return e_spawned;
    }

    return;
  }

  self notify(#"hash_66551cac93d16401");
  return e_spawned;
}

function function_d4a13039() {
  self endon(#"death");
  self waittill(#"hash_66551cac93d16401");
  waittillframeend();
  self delete();
}

function teleport_spawned(v_origin = self.origin, v_angles = self.angles, b_reset_entity = 1) {
  if(isactor(self)) {
    self forceteleport(v_origin, v_angles, 1, b_reset_entity);
    return;
  }

  self.origin = v_origin;
  self.angles = v_angles;
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
    spawn endon(#"death");

    if(!isDefined(spawn.finished_spawning)) {
      spawn waittill(#"finished spawning");
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

function set_ai_group_cleared_count(aigroup, count) {
  aigroup_init(aigroup);
  level._ai_group[aigroup].cleared_count = count;
}

function waittill_ai_group_cleared(aigroup) {
  assert(isDefined(level._ai_group[aigroup]), "<dev string:x39b>" + aigroup + "<dev string:x3ab>");
  level flag::wait_till(aigroup + "_cleared");
}

function waittill_ai_group_count(aigroup, count) {
  while(get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount > count) {
    level._ai_group[aigroup] waittill(#"update_aigroup");
  }
}

function waittill_ai_group_ai_count(aigroup, count) {
  while(level._ai_group[aigroup].aicount > count) {
    level._ai_group[aigroup] waittill(#"update_aigroup");
  }
}

function waittill_ai_group_spawner_count(aigroup, count) {
  while(get_ai_group_spawner_count(aigroup) > count) {
    level._ai_group[aigroup] waittill(#"update_aigroup");
  }
}

function waittill_ai_group_amount_killed(aigroup, amount_killed, timeout) {
  if(isDefined(timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(timeout, "timeout");
  }

  assert(isDefined(level._ai_group[aigroup]), "<dev string:x3be>" + aigroup + "<dev string:x3cb>");

  while(level._ai_group[aigroup].killed_count < amount_killed) {
    level._ai_group[aigroup] waittill(#"update_aigroup");
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
    if(isDefined(sp) && sp.count > 0) {
      n_count += sp.count;
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

function add_global_spawn_function(team, spawn_func, ...) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }

  if(!isDefined(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = [];
  }

  func = [];
  func[# "function"] = spawn_func;
  func[# "params"] = vararg;

  if(!isDefined(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = [];
  } else if(!isarray(level.spawn_funcs[team])) {
    level.spawn_funcs[team] = array(level.spawn_funcs[team]);
  }

  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

function add_ai_spawn_function(spawn_func, ...) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }

  if(!isDefined(level.spawn_funcs[# "all"])) {
    level.spawn_funcs[# "all"] = [];
  }

  func = [];
  func[# "function"] = spawn_func;
  func[# "params"] = vararg;

  if(!isDefined(level.spawn_funcs[# "all"])) {
    level.spawn_funcs[# "all"] = [];
  } else if(!isarray(level.spawn_funcs[# "all"])) {
    level.spawn_funcs[# "all"] = array(level.spawn_funcs[# "all"]);
  }

  level.spawn_funcs[# "all"][level.spawn_funcs[# "all"].size] = func;
}

function function_932006d1(func) {
  if(isDefined(level.spawn_funcs) && isDefined(level.spawn_funcs[# "all"])) {
    array = [];

    for(i = 0; i < level.spawn_funcs[# "all"].size; i++) {
      if(level.spawn_funcs[# "all"][i][# "function"] != func) {
        array[array.size] = level.spawn_funcs[# "all"][i];
      }
    }

    level.spawn_funcs[# "all"] = array;
  }
}

function add_archetype_spawn_function(archetype, spawn_func, ...) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }

  if(!isDefined(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = [];
  }

  func = [];
  func[# "function"] = spawn_func;
  func[# "params"] = vararg;

  if(!isDefined(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = [];
  } else if(!isarray(level.spawn_funcs[archetype])) {
    level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
  }

  level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

function function_89a2cd87(archetype, spawn_func, ...) {
  if(!isDefined(level.spawn_funcs)) {
    level.spawn_funcs = [];
  }

  if(!isDefined(level.spawn_funcs[archetype + "_post"])) {
    level.spawn_funcs[archetype + "_post"] = [];
  }

  func = [];
  func[# "function"] = spawn_func;
  func[# "params"] = vararg;

  if(!isDefined(level.spawn_funcs[archetype + "_post"])) {
    level.spawn_funcs[archetype + "_post"] = [];
  } else if(!isarray(level.spawn_funcs[archetype + "_post"])) {
    level.spawn_funcs[archetype + "_post"] = array(level.spawn_funcs[archetype + "_post"]);
  }

  level.spawn_funcs[archetype + "_post"][level.spawn_funcs[archetype + "_post"].size] = func;
}

function remove_global_spawn_function(team, func) {
  if(isDefined(level.spawn_funcs) && isDefined(level.spawn_funcs[team])) {
    array = [];

    for(i = 0; i < level.spawn_funcs[team].size; i++) {
      if(level.spawn_funcs[team][i][# "function"] != func) {
        array[array.size] = level.spawn_funcs[team][i];
      }
    }

    level.spawn_funcs[team] = array;
  }
}

function add_spawn_function(spawn_func, ...) {
  assert(!isDefined(level._loadstarted) || !isalive(self), "<dev string:x3df>");
  func = [];
  func[# "function"] = spawn_func;
  func[# "params"] = vararg;

  if(!isDefined(self.spawn_funcs)) {
    self.spawn_funcs = [];
  }

  self.spawn_funcs[self.spawn_funcs.size] = func;
}

function remove_spawn_function(func) {
  assert(!isDefined(level._loadstarted) || !isalive(self), "<dev string:x40f>");

  if(isDefined(self.spawn_funcs)) {
    array = [];

    for(i = 0; i < self.spawn_funcs.size; i++) {
      if(self.spawn_funcs[i][# "function"] != func) {
        array[array.size] = self.spawn_funcs[i];
      }
    }

    assert(self.spawn_funcs.size != array.size, "<dev string:x442>");
    self.spawn_funcs = array;
  }
}

function add_spawn_function_group(str_value, str_key = "targetname", func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_value), "<dev string:x498>");
  assert(isDefined(func_spawn), "<dev string:x4da>");
  a_spawners = getspawnerarray(str_value, str_key);
  array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

function function_ec9f109a(str_value, str_key = "targetname", func_spawn) {
  assert(isDefined(str_value), "<dev string:x51d>");
  assert(isDefined(func_spawn), "<dev string:x562>");
  a_spawners = getspawnerarray(str_value, str_key);
  array::run_all(a_spawners, &remove_spawn_function, func_spawn);
}

function add_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_aigroup), "<dev string:x5a8>");
  assert(isDefined(func_spawn), "<dev string:x5ef>");
  a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
  array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

function remove_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(param_4), "<dev string:x635>");
  assert(isDefined(param_5), "<dev string:x67f>");
  a_spawners = getspawnerarray(param_4, "script_aigroup");
  array::run_all(a_spawners, &remove_spawn_function, param_5);
}

function simple_spawn(name_or_spawners, spawn_func, ...) {
  spawners = [];

  if(isstring(name_or_spawners)) {
    spawners = getspawnerarray(name_or_spawners, "targetname");
    assert(spawners.size, "<dev string:x6c8>" + name_or_spawners + "<dev string:x6e8>");
  } else {
    if(!isDefined(name_or_spawners)) {
      name_or_spawners = [];
    } else if(!isarray(name_or_spawners)) {
      name_or_spawners = array(name_or_spawners);
    }

    spawners = name_or_spawners;
  }

  a_spawned = [];
  bforcespawn = vararg[5];

  foreach(sp in spawners) {
    e_spawned = sp spawn(bforcespawn);

    if(isDefined(e_spawned)) {
      if(isDefined(spawn_func)) {
        util::single_thread_argarray(e_spawned, spawn_func, vararg);
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

function simple_spawn_single(name_or_spawner, spawn_func, ...) {
  a_args = arraycombine(array(name_or_spawner, spawn_func), vararg, 1, 0);
  ai = util::single_func_argarray(undefined, &simple_spawn, a_args);
  assert(ai.size <= 1, "<dev string:x6f3>");

  if(ai.size) {
    return ai[0];
  }
}

function autoexec init_female_spawn() {
  level.female_percent = 0;
  set_female_percent(30);
}

function set_female_percent(percent) {
  level.female_percent = percent;
}