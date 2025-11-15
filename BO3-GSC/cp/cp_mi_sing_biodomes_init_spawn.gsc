/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_biodomes_init_spawn.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#namespace sm_initial_spawns;

function autoexec __init__sytem__() {
  system::register("sm_initial_spawns", & __init__, & __main__, undefined);
}

function __init__() {}

function __main__() {
  level thread sm_infil_zone_setup();
}

function sm_axis_initial_spawn_func(spawn_struct) {
  self endon("death");
  wait(1);
  if(!level flag::get("sm_combat_started")) {
    wait(randomfloatrange(0.5, 1));
    level flag::set("sm_combat_started");
  }
}

function start_wave_spawning_on_combat() {
  level waittill("sm_combat_started");
}

function sm_infil_zone_setup() {
  wait(1);
  a_infil_zones = struct::get_array("infil_manager", "targetname");
  foreach(zone in a_infil_zones) {
    zone infil_zone_selection();
  }
}

function infil_zone_selection() {
  a_volume_list = getEntArray(self.target, "targetname");
  assert(a_volume_list.size != 0, "");
  a_volume_list[0] thread spawn_infil_zones();
}

function get_infil_activity(a_volume_list) {
  for(i = 0; i < a_volume_list.size; i++) {
    if(isDefined(a_volume_list[i].script_noteworthy) && isDefined(level.gametype)) {
      if(a_volume_list[i].script_noteworthy == level.gametype) {
        s_spawn_manager = a_volume_list[i];
        continue;
      }
      a_volume_list[i] infil_clean_up();
      array::remove_index(a_volume_list, i, 1);
    }
  }
  if(a_volume_list.size == 0) {
    return;
  }
  if(!isDefined(s_spawn_manager)) {
    s_spawn_manager = array::random(a_volume_list);
  }
  foreach(volume in a_volume_list) {
    if(volume != s_spawn_manager) {
      volume infil_clean_up();
    }
  }
  return s_spawn_manager;
}

function spawn_infil_zones() {
  while(true) {
    self waittill("trigger", ent);
    if(isDefined(ent.sessionstate) && ent.sessionstate != "spectator") {
      break;
    }
    wait(0.05);
  }
  target = self.target;
  a_entities = getEntArray(target, "targetname");
  assert(a_entities.size != 0, "");
  s_handler = self;
  wait(1);
  foreach(entity in a_entities) {
    if(isspawner(entity) && !isDefined(level._infil_actor_off) && isDefined(s_handler)) {
      entity handle_role_assignment(s_handler);
    }
  }
  self notify("infil_spawn_complete");
}

function handle_role_assignment(handler_struct) {
  defend_volume = getent("street_battle_volume", "targetname");
  if(isDefined(level.free_targeting) || isDefined(level.target_volume)) {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy != "wasp_swarm" && self.script_noteworthy != "hunter_swarm") {
      self.target = undefined;
    }
  }
  if(!isDefined(self.script_noteworthy)) {
    camp_guard = spawner::simple_spawn_single(self);
    if(isDefined(level.target_volume) && isactor(camp_guard)) {
      camp_guard setgoal(defend_volume);
    }
    return;
  }
  if(self.script_noteworthy == "wasp_swarm") {
    self thread wasp_swarm_logic();
    return;
  }
  if(self.script_noteworthy == "hunter_swarm") {
    self thread hunter_swarm_logic();
    return;
  }
  camp_guard = spawner::simple_spawn_single(self);
  if(self.script_noteworthy == "patrol") {
    camp_guard thread infil_patrol_logic(self.target);
  } else {
    if(self.script_noteworthy == "defend") {
      if(isDefined(camp_guard.target)) {}
    } else {
      if(self.script_noteworthy == "guard") {
        if(isDefined(camp_guard.target)) {}
      } else if(self.script_noteworthy == "scene") {
        camp_guard thread script_scene_setup(self, handler_struct);
      }
    }
  }
}

function wasp_swarm_logic() {
  path_start = getvehiclenode(self.target, "targetname");
  offset = vectorscale((0, 1, 0), 60);
  for(i = 0; i < self.script_int; i++) {
    wasp = spawner::simple_spawn_single(self);
    wasp thread handle_spline(path_start, i);
  }
}

function hunter_swarm_logic() {
  path_start = getvehiclenode(self.target, "targetname");
  hunter = spawner::simple_spawn_single(self);
  hunter vehicle_ai::start_scripted();
  hunter vehicle::get_on_path(path_start);
  hunter.drivepath = 1;
  hunter vehicle::go_path();
  hunter setgoal(level.players[0], 0, 1000);
  hunter vehicle_ai::stop_scripted();
  hunter.lockontarget = level.players[0];
}

function handle_spline(path_start, index) {
  offset = vectorscale((0, 1, 0), 30);
  self vehicle_ai::start_scripted();
  self vehicle::get_on_path(path_start);
  self.drivepath = 1;
  offset_scale = get_offset_scale(index);
  self pathfixedoffset(offset * offset_scale);
  self vehicle::go_path();
  self setgoal(level.players[0], 0, 600, 150);
  self vehicle_ai::stop_scripted();
  self.lockontarget = level.players[0];
}

function get_offset_scale(i) {
  if((i % 2) == 0) {
    return (i / 2) * -1;
  }
  return (i - (i / 2)) + 0.5;
}

function infil_patrol_logic(str_start_node) {
  self endon("death");
  while(true) {
    self waittill("patrol_wp_reached", node);
    if(isDefined(node.script_wait) || (isDefined(node.script_wait_min) && isDefined(node.script_wait_max))) {
      node util::script_wait();
    }
  }
}

function script_scene_setup(align_node, handler_struct) {
  if(isDefined(self.target)) {
    node = getnode(self.target, "targetname");
    if(isDefined(node)) {} else {
      defend_volume = getent(self.target, "targetname");
    }
  } else {
    if(isDefined(handler_struct.height)) {
      self.goalheight = handler_struct.height;
    }
    if(isDefined(handler_struct.radius)) {
      self.goalradius = handler_struct.radius;
    }
  }
  wait(0.05);
  assert(isDefined(self.script_string), "");
  align_node thread scene::init(self.script_string, self);
}

function infil_clean_up() {
  a_entities = getEntArray(self.target, "targetname");
  foreach(entity in a_entities) {
    if(isspawner(entity)) {
      entity delete();
      continue;
    }
    if(isDefined(entity.target)) {
      nd_cover_nodes = getnodearray(entity.target, "targetname");
      foreach(node in nd_cover_nodes) {
        setenablenode(node, 0);
      }
    }
    entity connectpaths();
    entity delete();
  }
  self delete();
}

function kill_infil_actor_spawn() {
  if(!isDefined(level._infil_actor_off)) {
    level._infil_actor_off = 1;
  }
}