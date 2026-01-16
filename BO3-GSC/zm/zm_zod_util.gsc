/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_ai_margwa;
#using scripts\zm\_zm_ai_raps;
#using scripts\zm\_zm_ai_wasp;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_zod_util;

function autoexec __init__sytem__() {
  system::register("zm_zod_util", & __init__, & __main__, undefined);
}

function __init__() {
  level.tag_origin_pool = [];
}

function __main__() {
  assert(isdefined(level.zombie_spawners));
  if(isdefined(level.zombie_spawn_callbacks)) {
    foreach(fn in level.zombie_spawn_callbacks) {
      add_zod_zombie_spawn_func(fn);
    }
  }
  level.zombie_spawn_callbacks = undefined;
  add_zod_zombie_spawn_func( & watch_zombie_death);
  callback::on_connect( & on_player_connect);
  level.teleport_positions = struct::get_array("teleport_position");
}

function tag_origin_allocate(v_pos, v_angles) {
  if(level.tag_origin_pool.size == 0) {
    e_model = util::spawn_model("tag_origin", v_pos, v_angles);
    return e_model;
  }
  n_index = level.tag_origin_pool.size - 1;
  e_model = level.tag_origin_pool[n_index];
  arrayremoveindex(level.tag_origin_pool, n_index);
  e_model.angles = v_angles;
  e_model.origin = v_pos;
  e_model notify("reallocated_from_pool");
  return e_model;
}

function tag_origin_free() {
  if(!isdefined(level.tag_origin_pool)) {
    level.tag_origin_pool = [];
  } else if(!isarray(level.tag_origin_pool)) {
    level.tag_origin_pool = array(level.tag_origin_pool);
  }
  level.tag_origin_pool[level.tag_origin_pool.size] = self;
  self thread tag_origin_expire();
}

function private tag_origin_expire() {
  self endon("reallocated_from_pool");
  wait(20);
  arrayremovevalue(level.tag_origin_pool, self);
  self delete();
}

function private watch_zombie_death() {
  self waittill("death", e_attacker, str_means_of_death, weapon);
  if(isdefined(self)) {
    if(isdefined(level.zombie_death_callbacks)) {
      foreach(fn_callback in level.zombie_death_callbacks) {
        self thread[[fn_callback]](e_attacker, str_means_of_death, weapon);
      }
    }
  }
}

function vec_to_string(v) {
  return (((((("<") + v[0]) + ", ") + v[1]) + ", ") + v[2]) + (">");
}

function zod_unitrigger_assess_visibility(player) {
  b_visible = 1;
  if(isdefined(player.beastmode) && player.beastmode && (!(isdefined(self.allow_beastmode) && self.allow_beastmode))) {
    b_visible = 0;
  } else if(isdefined(self.stub.func_unitrigger_visible)) {
    b_visible = self[[self.stub.func_unitrigger_visible]](player);
  }
  str_msg = & "";
  param1 = undefined;
  if(b_visible) {
    if(isdefined(self.stub.func_unitrigger_message)) {
      str_msg = self[[self.stub.func_unitrigger_message]](player);
    } else {
      str_msg = self.stub.hint_string;
      param1 = self.stub.hint_parm1;
    }
  }
  if(isdefined(param1)) {
    self sethintstring(str_msg, param1);
  } else {
    self sethintstring(str_msg);
  }
  return b_visible;
}

function unitrigger_refresh_message() {
  self zm_unitrigger::run_visibility_function_for_all_triggers();
}

function unitrigger_allow_beastmode() {
  self.allow_beastmode = 1;
}

function private unitrigger_think() {
  self endon("kill_trigger");
  self.stub thread unitrigger_refresh_message();
  while (true) {
    self waittill("trigger", player);
    if(isdefined(self.allow_beastmode) && self.allow_beastmode || (!(isdefined(player.beastmode) && player.beastmode))) {
      self.stub notify("trigger", player);
    }
  }
}

function teleport_player(struct_targetname) {
  assert(isdefined(struct_targetname));
  a_dest = struct::get_array(struct_targetname, "targetname");
  if(a_dest.size == 0) {
    /# /
    #
    assertmsg(("" + struct_targetname) + "");
    return;
  }
  v_dest_origin = a_dest[0].origin;
  v_dest_angles = a_dest[0].angles;
  b_valid_found = 0;
  e_teleport = tag_origin_allocate(self.origin, self.angles);
  self playerlinktoabsolute(e_teleport, "tag_origin");
  e_teleport.origin = level.teleport_positions[self.characterindex].origin;
  e_teleport.angles = level.teleport_positions[self.characterindex].angles;
  self freezecontrols(1);
  self disableweapons();
  self disableoffhandweapons();
  wait(2);
  foreach(s_dest in a_dest) {
    foreach(e_player in level.players) {
      if(distance2dsquared(e_player.origin, s_dest.origin) > 10000) {
        b_valid_found = 1;
        v_dest_origin = s_dest.origin;
        v_dest_angles = s_dest.angles;
        break;
      }
    }
    if(b_valid_found) {
      break;
    }
  }
  e_teleport.origin = v_dest_origin;
  e_teleport.angles = v_dest_angles;
  wait(0.5);
  self unlink();
  e_teleport tag_origin_free();
  self freezecontrols(0);
  self enableweapons();
  self enableoffhandweapons();
}

function set_unitrigger_hint_string(str_message, param1) {
  self.hint_string = str_message;
  self.hint_parm1 = param1;
  zm_unitrigger::unregister_unitrigger(self);
  zm_unitrigger::register_unitrigger(self, & unitrigger_think);
}

function private spawn_unitrigger(origin, angles, radius_or_dims, use_trigger = 0, func_per_player_msg) {
  trigger_stub = spawnstruct();
  trigger_stub.origin = origin;
  str_type = "unitrigger_radius";
  if(isvec(radius_or_dims)) {
    trigger_stub.script_length = radius_or_dims[0];
    trigger_stub.script_width = radius_or_dims[1];
    trigger_stub.script_height = radius_or_dims[2];
    str_type = "unitrigger_box";
    if(!isdefined(angles)) {
      angles = (0, 0, 0);
    }
    trigger_stub.angles = angles;
  } else {
    trigger_stub.radius = radius_or_dims;
  }
  if(use_trigger) {
    trigger_stub.cursor_hint = "HINT_NOICON";
    trigger_stub.script_unitrigger_type = str_type + "_use";
  } else {
    trigger_stub.script_unitrigger_type = str_type;
  }
  if(isdefined(func_per_player_msg)) {
    trigger_stub.func_unitrigger_message = func_per_player_msg;
    zm_unitrigger::unitrigger_force_per_player_triggers(trigger_stub, 1);
  }
  trigger_stub.prompt_and_visibility_func = & zod_unitrigger_assess_visibility;
  zm_unitrigger::register_unitrigger(trigger_stub, & unitrigger_think);
  return trigger_stub;
}

function spawn_trigger_radius(origin, radius, use_trigger = 0, func_per_player_msg) {
  return spawn_unitrigger(origin, undefined, radius, use_trigger, func_per_player_msg);
}

function spawn_trigger_box(origin, angles, dims, use_trigger = 0, func_per_player_msg) {
  return spawn_unitrigger(origin, angles, dims, use_trigger, func_per_player_msg);
}

function add_zod_zombie_spawn_func(fn_zombie_spawned) {
  if(!isdefined(level.zombie_spawners)) {
    if(!isdefined(level.zombie_spawn_callbacks)) {
      level.zombie_spawn_callbacks = [];
    }
    if(!isdefined(level.zombie_spawn_callbacks)) {
      level.zombie_spawn_callbacks = [];
    } else if(!isarray(level.zombie_spawn_callbacks)) {
      level.zombie_spawn_callbacks = array(level.zombie_spawn_callbacks);
    }
    level.zombie_spawn_callbacks[level.zombie_spawn_callbacks.size] = fn_zombie_spawned;
  } else {
    array::thread_all(level.zombie_spawners, & spawner::add_spawn_function, fn_zombie_spawned);
    a_ritual_spawners = getentarray("ritual_zombie_spawner", "targetname");
    array::thread_all(a_ritual_spawners, & spawner::add_spawn_function, fn_zombie_spawned);
  }
}

function on_player_connect() {
  self endon("disconnect");
  while (true) {
    self waittill("bled_out");
    if(isdefined(level.bled_out_callbacks)) {
      foreach(fn in level.bled_out_callbacks) {
        self thread[[fn]]();
      }
    }
  }
}

function on_zombie_killed(fn_zombie_killed) {
  if(!isdefined(level.zombie_death_callbacks)) {
    level.zombie_death_callbacks = [];
  }
  if(!isdefined(level.zombie_death_callbacks)) {
    level.zombie_death_callbacks = [];
  } else if(!isarray(level.zombie_death_callbacks)) {
    level.zombie_death_callbacks = array(level.zombie_death_callbacks);
  }
  level.zombie_death_callbacks[level.zombie_death_callbacks.size] = fn_zombie_killed;
}

function on_player_bled_out(fn_callback) {
  if(!isdefined(level.bled_out_callbacks)) {
    level.bled_out_callbacks = [];
  }
  if(!isdefined(level.bled_out_callbacks)) {
    level.bled_out_callbacks = [];
  } else if(!isarray(level.bled_out_callbacks)) {
    level.bled_out_callbacks = array(level.bled_out_callbacks);
  }
  level.bled_out_callbacks[level.bled_out_callbacks.size] = fn_callback;
}

function set_rumble_to_player(n_rumbletype, var_d00db512) {
  self notify("set_rumble_to_player");
  self endon("disconnect");
  self endon("set_rumble_to_player");
  self thread clientfield::set_to_player("player_rumble_and_shake", n_rumbletype);
  if(isdefined(var_d00db512)) {
    wait(var_d00db512);
    self thread set_rumble_to_player(0);
  }
}

function function_3a7a7013(n_rumbletype, n_radius, v_origin, var_d00db512) {
  var_699d80d5 = n_radius * n_radius;
  foreach(player in level.activeplayers) {
    if(isdefined(player) && distance2dsquared(player.origin, v_origin) <= var_699d80d5) {
      player thread set_rumble_to_player(n_rumbletype, var_d00db512);
    }
  }
}

function function_5cc835d6(v_origin, v_target, n_duration) {
  assert(isdefined(v_origin), "");
  assert(isdefined(v_target), "");
  e_fx = tag_origin_allocate(v_origin, (0, 0, 0));
  e_fx clientfield::set("zod_egg_soul", 1);
  e_fx moveto(v_target, n_duration);
  e_fx waittill("movedone");
  e_fx clientfield::set("zod_egg_soul", 0);
  e_fx tag_origin_free();
}

function function_15166300(var_c3a9e22d) {
  var_49fa7253 = 0;
  var_565450eb = 0;
  n_wasps_alive = 0;
  n_raps_alive = 0;
  switch (var_c3a9e22d) {
    case 1: {
      var_565450eb = zombie_utility::get_current_zombie_count();
      var_32218d0b = min(level.activeplayers.size * 5, 10);
      var_49fa7253 = var_32218d0b - var_565450eb;
      break;
    }
    case 2: {
      n_wasps_alive = zm_ai_wasp::get_current_wasp_count();
      var_32218d0b = min(level.activeplayers.size * 4, 8);
      var_49fa7253 = var_32218d0b - n_wasps_alive;
      break;
    }
    case 3: {
      n_raps_alive = zm_ai_raps::get_current_raps_count();
      var_32218d0b = min(level.activeplayers.size * 4, 13);
      var_49fa7253 = var_32218d0b - n_raps_alive;
      break;
    }
    case 4: {
      var_49fa7253 = 3 - level.var_6e63e659;
      var_73d2bce8 = level.zm_loc_types["margwa_location"].size < 1;
      if(var_73d2bce8) {
        var_49fa7253 = 0;
      }
      break;
    }
  }
  var_4422ef10 = (var_565450eb + (n_wasps_alive * 2)) + (n_raps_alive * 2) + level.var_6e63e659;
  var_e1bef548 = level.zombie_ai_limit - var_4422ef10;
  var_49fa7253 = min(var_49fa7253, var_e1bef548);
  if(var_49fa7253 > 0 && (var_c3a9e22d === 2 || var_c3a9e22d === 3)) {
    var_49fa7253 = var_49fa7253 / 2;
    var_49fa7253 = floor(var_49fa7253);
  }
  return var_49fa7253;
}

function function_55f114f9(var_c94b52fa, n_duration) {
  self clientfield::set_player_uimodel(var_c94b52fa, 1);
  wait(n_duration);
  self clientfield::set_player_uimodel(var_c94b52fa, 0);
}

function show_infotext_for_duration(str_infotext, n_duration) {
  self clientfield::set_to_player(str_infotext, 1);
  wait(n_duration);
  self clientfield::set_to_player(str_infotext, 0);
}

function setup_devgui_func(str_devgui_path, str_dvar, n_value, func, n_base_value = -1) {
  setdvar(str_dvar, n_base_value);
  adddebugcommand(((((("devgui_cmd \"" + str_devgui_path) + "\" \"") + str_dvar) + " ") + n_value) + "\"\n");
  while (true) {
    n_dvar = getdvarint(str_dvar);
    if(n_dvar > n_base_value) {
      [
        [func]
      ](n_dvar);
      setdvar(str_dvar, n_base_value);
    }
    util::wait_network_frame();
  }
}