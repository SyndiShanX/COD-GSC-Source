/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\visionset_mgr_shared.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace visionset_mgr;

function autoexec __init__sytem__() {
  system::register("visionset_mgr", & __init__, undefined, undefined);
}

function __init__() {
  level.vsmgr_initializing = 1;
  level.vsmgr_default_info_name = "__none";
  level.vsmgr = [];
  level thread register_type("visionset");
  level thread register_type("overlay");
  callback::on_finalize_initialization( & finalize_clientfields);
  level thread monitor();
  callback::on_connect( & on_player_connect);
}

function register_info(type, name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread) {
  assert(level.vsmgr_initializing, "");
  lower_name = tolower(name);
  validate_info(type, lower_name, priority);
  add_sorted_name_key(type, lower_name);
  add_sorted_priority_key(type, lower_name, priority);
  level.vsmgr[type].info[lower_name] = spawnstruct();
  level.vsmgr[type].info[lower_name] add_info(type, lower_name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread);
  if(level.vsmgr[type].highest_version < version) {
    level.vsmgr[type].highest_version = version;
  }
}

function activate(type, name, player, opt_param_1, opt_param_2, opt_param_3) {
  if(level.vsmgr[type].info[name].state.should_activate_per_player) {
    activate_per_player(type, name, player, opt_param_1, opt_param_2, opt_param_3);
    return;
  }
  state = level.vsmgr[type].info[name].state;
  if(state.ref_count_lerp_thread) {
    state.ref_count++;
    if(1 < state.ref_count) {
      return;
    }
  }
  if(isdefined(state.lerp_thread)) {
    state thread lerp_thread_wrapper(state.lerp_thread, opt_param_1, opt_param_2, opt_param_3);
  } else {
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
      state set_state_active(players[player_index], 1);
    }
  }
}

function deactivate(type, name, player) {
  if(level.vsmgr[type].info[name].state.should_activate_per_player) {
    deactivate_per_player(type, name, player);
    return;
  }
  state = level.vsmgr[type].info[name].state;
  if(state.ref_count_lerp_thread) {
    state.ref_count--;
    if(0 < state.ref_count) {
      return;
    }
  }
  players = getplayers();
  for (player_index = 0; player_index < players.size; player_index++) {
    state set_state_inactive(players[player_index]);
  }
  state notify("visionset_mgr_deactivate_all");
}

function set_state_active(player, lerp) {
  player_entnum = player getentitynumber();
  if(!isdefined(self.players[player_entnum])) {
    return;
  }
  self.players[player_entnum].active = 1;
  self.players[player_entnum].lerp = lerp;
}

function set_state_inactive(player) {
  player_entnum = player getentitynumber();
  if(!isdefined(self.players[player_entnum])) {
    return;
  }
  self.players[player_entnum].active = 0;
  self.players[player_entnum].lerp = 0;
}

function timeout_lerp_thread(timeout, opt_param_2, opt_param_3) {
  players = getplayers();
  for (player_index = 0; player_index < players.size; player_index++) {
    self set_state_active(players[player_index], 1);
  }
  wait(timeout);
  deactivate(self.type, self.name);
}

function timeout_lerp_thread_per_player(player, timeout, opt_param_2, opt_param_3) {
  self set_state_active(player, 1);
  wait(timeout);
  deactivate_per_player(self.type, self.name, player);
}

function duration_lerp_thread(duration, max_duration) {
  start_time = gettime();
  end_time = start_time + (int(duration * 1000));
  if(isdefined(max_duration)) {
    start_time = end_time - (int(max_duration * 1000));
  }
  while (true) {
    lerp = calc_remaining_duration_lerp(start_time, end_time);
    if(0 >= lerp) {
      break;
    }
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
      self set_state_active(players[player_index], lerp);
    }
    wait(0.05);
  }
  deactivate(self.type, self.name);
}

function duration_lerp_thread_per_player(player, duration, max_duration) {
  start_time = gettime();
  end_time = start_time + (int(duration * 1000));
  if(isdefined(max_duration)) {
    start_time = end_time - (int(max_duration * 1000));
  }
  while (true) {
    lerp = calc_remaining_duration_lerp(start_time, end_time);
    if(0 >= lerp) {
      break;
    }
    self set_state_active(player, lerp);
    wait(0.05);
  }
  deactivate_per_player(self.type, self.name, player);
}

function ramp_in_thread_per_player(player, duration) {
  start_time = gettime();
  end_time = start_time + (int(duration * 1000));
  while (true) {
    lerp = calc_ramp_in_lerp(start_time, end_time);
    if(1 <= lerp) {
      break;
    }
    self set_state_active(player, lerp);
    wait(0.05);
  }
}

function ramp_in_out_thread_hold_func() {
  level endon("kill_ramp_in_out_thread_hold_func");
  while (true) {
    for (player_index = 0; player_index < level.players.size; player_index++) {
      self set_state_active(level.players[player_index], 1);
    }
    wait(0.05);
  }
}

function ramp_in_out_thread(ramp_in, full_period, ramp_out) {
  start_time = gettime();
  end_time = start_time + (int(ramp_in * 1000));
  while (true) {
    lerp = calc_ramp_in_lerp(start_time, end_time);
    if(1 <= lerp) {
      break;
    }
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
      self set_state_active(players[player_index], lerp);
    }
    wait(0.05);
  }
  self thread ramp_in_out_thread_hold_func();
  if(isfunctionptr(full_period)) {
    self[[full_period]]();
  } else {
    wait(full_period);
  }
  level notify("kill_ramp_in_out_thread_hold_func");
  start_time = gettime();
  end_time = start_time + (int(ramp_out * 1000));
  while (true) {
    lerp = calc_remaining_duration_lerp(start_time, end_time);
    if(0 >= lerp) {
      break;
    }
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
      self set_state_active(players[player_index], lerp);
    }
    wait(0.05);
  }
  deactivate(self.type, self.name);
}

function ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out) {
  start_time = gettime();
  end_time = start_time + (int(ramp_in * 1000));
  while (true) {
    lerp = calc_ramp_in_lerp(start_time, end_time);
    if(1 <= lerp) {
      break;
    }
    self set_state_active(player, lerp);
    wait(0.05);
  }
  self set_state_active(player, lerp);
  if(isfunctionptr(full_period)) {
    player[[full_period]]();
  } else {
    wait(full_period);
  }
  start_time = gettime();
  end_time = start_time + (int(ramp_out * 1000));
  while (true) {
    lerp = calc_remaining_duration_lerp(start_time, end_time);
    if(0 >= lerp) {
      break;
    }
    self set_state_active(player, lerp);
    wait(0.05);
  }
  deactivate_per_player(self.type, self.name, player);
}

function ramp_in_out_thread_watch_player_shutdown(player) {
  player notify("ramp_in_out_thread_watch_player_shutdown");
  player endon("ramp_in_out_thread_watch_player_shutdown");
  player endon("disconnect");
  player waittill("death");
  if(player isremotecontrolling() == 0) {
    deactivate_per_player(self.type, self.name, player);
  }
}

function ramp_in_out_thread_per_player_death_shutdown(player, ramp_in, full_period, ramp_out) {
  player endon("death");
  thread ramp_in_out_thread_watch_player_shutdown(player);
  ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out);
}

function ramp_in_out_thread_per_player(player, ramp_in, full_period, ramp_out) {
  ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out);
}

function register_type(type) {
  level.vsmgr[type] = spawnstruct();
  level.vsmgr[type].type = type;
  level.vsmgr[type].in_use = 0;
  level.vsmgr[type].highest_version = 0;
  level.vsmgr[type].cf_slot_name = type + "_slot";
  level.vsmgr[type].cf_lerp_name = type + "_lerp";
  level.vsmgr[type].info = [];
  level.vsmgr[type].sorted_name_keys = [];
  level.vsmgr[type].sorted_prio_keys = [];
  register_info(type, level.vsmgr_default_info_name, 1, 0, 1, 0, undefined);
}

function finalize_clientfields() {
  typekeys = getarraykeys(level.vsmgr);
  for (type_index = 0; type_index < typekeys.size; type_index++) {
    level.vsmgr[typekeys[type_index]] thread finalize_type_clientfields();
  }
  level.vsmgr_initializing = 0;
}

function finalize_type_clientfields() {
  println(("" + self.type) + "");
  if(1 >= self.info.size) {
    return;
  }
  self.in_use = 1;
  self.cf_slot_bit_count = getminbitcountfornum(self.info.size - 1);
  self.cf_lerp_bit_count = self.info[self.sorted_name_keys[0]].lerp_bit_count;
  for (i = 0; i < self.sorted_name_keys.size; i++) {
    self.info[self.sorted_name_keys[i]].slot_index = i;
    if(self.info[self.sorted_name_keys[i]].lerp_bit_count > self.cf_lerp_bit_count) {
      self.cf_lerp_bit_count = self.info[self.sorted_name_keys[i]].lerp_bit_count;
    }
    println(((((("" + self.info[self.sorted_name_keys[i]].name) + "") + self.info[self.sorted_name_keys[i]].version) + "") + self.info[self.sorted_name_keys[i]].lerp_step_count) + "");
  }
  clientfield::register("toplayer", self.cf_slot_name, self.highest_version, self.cf_slot_bit_count, "int");
  if(1 < self.cf_lerp_bit_count) {
    clientfield::register("toplayer", self.cf_lerp_name, self.highest_version, self.cf_lerp_bit_count, "float");
  }
}

function validate_info(type, name, priority) {
  keys = getarraykeys(level.vsmgr);
  for (i = 0; i < keys.size; i++) {
    if(type == keys[i]) {
      break;
    }
  }
  assert(i < keys.size, ("" + type) + "");
  keys = getarraykeys(level.vsmgr[type].info);
  for (i = 0; i < keys.size; i++) {
    assert(level.vsmgr[type].info[keys[i]].name != name, ((("" + type) + "") + name) + "");
    assert(level.vsmgr[type].info[keys[i]].priority != priority, ((((((("" + type) + "") + priority) + "") + name) + "") + level.vsmgr[type].info[keys[i]].name) + "");
  }
}

function add_sorted_name_key(type, name) {
  for (i = 0; i < level.vsmgr[type].sorted_name_keys.size; i++) {
    if(name < level.vsmgr[type].sorted_name_keys[i]) {
      break;
    }
  }
  arrayinsert(level.vsmgr[type].sorted_name_keys, name, i);
}

function add_sorted_priority_key(type, name, priority) {
  for (i = 0; i < level.vsmgr[type].sorted_prio_keys.size; i++) {
    if(priority > level.vsmgr[type].info[level.vsmgr[type].sorted_prio_keys[i]].priority) {
      break;
    }
  }
  arrayinsert(level.vsmgr[type].sorted_prio_keys, name, i);
}

function add_info(type, name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread) {
  self.type = type;
  self.name = name;
  self.version = version;
  self.priority = priority;
  self.lerp_step_count = lerp_step_count;
  self.lerp_bit_count = getminbitcountfornum(lerp_step_count);
  if(!isdefined(ref_count_lerp_thread)) {
    ref_count_lerp_thread = 0;
  }
  self.state = spawnstruct();
  self.state.type = type;
  self.state.name = name;
  self.state.should_activate_per_player = should_activate_per_player;
  self.state.lerp_thread = lerp_thread;
  self.state.ref_count_lerp_thread = ref_count_lerp_thread;
  self.state.players = [];
  if(ref_count_lerp_thread && !should_activate_per_player) {
    self.state.ref_count = 0;
  }
}

function on_player_connect() {
  self player_setup();
}

function player_setup() {
  self.vsmgr_player_entnum = self getentitynumber();
  typekeys = getarraykeys(level.vsmgr);
  for (type_index = 0; type_index < typekeys.size; type_index++) {
    type = typekeys[type_index];
    if(!level.vsmgr[type].in_use) {
      continue;
    }
    for (name_index = 0; name_index < level.vsmgr[type].sorted_name_keys.size; name_index++) {
      name_key = level.vsmgr[type].sorted_name_keys[name_index];
      level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum] = spawnstruct();
      level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum].active = 0;
      level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum].lerp = 0;
      if(level.vsmgr[type].info[name_key].state.ref_count_lerp_thread && level.vsmgr[type].info[name_key].state.should_activate_per_player) {
        level.vsmgr[type].info[name_key].state.players[self.vsmgr_player_entnum].ref_count = 0;
      }
    }
    level.vsmgr[type].info[level.vsmgr_default_info_name].state set_state_active(self, 1);
  }
}

function player_shutdown() {
  self.vsmgr_player_entnum = self getentitynumber();
  typekeys = getarraykeys(level.vsmgr);
  for (type_index = 0; type_index < typekeys.size; type_index++) {
    type = typekeys[type_index];
    if(!level.vsmgr[type].in_use) {
      continue;
    }
    for (name_index = 0; name_index < level.vsmgr[type].sorted_name_keys.size; name_index++) {
      name_key = level.vsmgr[type].sorted_name_keys[name_index];
      deactivate_per_player(type, name_key, self);
    }
  }
}

function monitor() {
  while (level.vsmgr_initializing) {
    wait(0.05);
  }
  typekeys = getarraykeys(level.vsmgr);
  while (true) {
    wait(0.05);
    waittillframeend();
    players = getplayers();
    for (type_index = 0; type_index < typekeys.size; type_index++) {
      type = typekeys[type_index];
      if(!level.vsmgr[type].in_use) {
        continue;
      }
      for (player_index = 0; player_index < players.size; player_index++) {
        if(!isdefined(players[player_index].vsmgr_player_entnum)) {
          continue;
        }
        update_clientfields(players[player_index], level.vsmgr[type]);
      }
    }
  }
}

function get_first_active_name(type_struct) {
  size = type_struct.sorted_prio_keys.size;
  for (prio_index = 0; prio_index < size; prio_index++) {
    prio_key = type_struct.sorted_prio_keys[prio_index];
    if(type_struct.info[prio_key].state.players[self.vsmgr_player_entnum].active) {
      return prio_key;
    }
  }
  return level.vsmgr_default_info_name;
}

function update_clientfields(player, type_struct) {
  name = player get_first_active_name(type_struct);
  player clientfield::set_to_player(type_struct.cf_slot_name, type_struct.info[name].slot_index);
  if(1 < type_struct.cf_lerp_bit_count) {
    player clientfield::set_to_player(type_struct.cf_lerp_name, type_struct.info[name].state.players[player.vsmgr_player_entnum].lerp);
  }
}

function lerp_thread_wrapper(func, opt_param_1, opt_param_2, opt_param_3) {
  self notify("visionset_mgr_deactivate_all");
  self endon("visionset_mgr_deactivate_all");
  self[[func]](opt_param_1, opt_param_2, opt_param_3);
}

function lerp_thread_per_player_wrapper(func, player, opt_param_1, opt_param_2, opt_param_3) {
  player_entnum = player getentitynumber();
  self.players[player_entnum] notify("visionset_mgr_deactivate");
  self.players[player_entnum] endon("visionset_mgr_deactivate");
  player endon("disconnect");
  self[[func]](player, opt_param_1, opt_param_2, opt_param_3);
}

function activate_per_player(type, name, player, opt_param_1, opt_param_2, opt_param_3) {
  player_entnum = player getentitynumber();
  state = level.vsmgr[type].info[name].state;
  if(state.ref_count_lerp_thread) {
    state.players[player_entnum].ref_count++;
    if(1 < state.players[player_entnum].ref_count) {
      return;
    }
  }
  if(isdefined(state.lerp_thread)) {
    state thread lerp_thread_per_player_wrapper(state.lerp_thread, player, opt_param_1, opt_param_2, opt_param_3);
  } else {
    state set_state_active(player, 1);
  }
}

function deactivate_per_player(type, name, player) {
  player_entnum = player getentitynumber();
  state = level.vsmgr[type].info[name].state;
  if(state.ref_count_lerp_thread) {
    state.players[player_entnum].ref_count--;
    if(0 < state.players[player_entnum].ref_count) {
      return;
    }
  }
  state set_state_inactive(player);
  state.players[player_entnum] notify("visionset_mgr_deactivate");
}

function calc_ramp_in_lerp(start_time, end_time) {
  if(0 >= (end_time - start_time)) {
    return 1;
  }
  now = gettime();
  frac = (float(now - start_time)) / (float(end_time - start_time));
  return math::clamp(frac, 0, 1);
}

function calc_remaining_duration_lerp(start_time, end_time) {
  if(0 >= (end_time - start_time)) {
    return 0;
  }
  now = gettime();
  frac = (float(end_time - now)) / (float(end_time - start_time));
  return math::clamp(frac, 0, 1);
}