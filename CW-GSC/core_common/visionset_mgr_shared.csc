/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\visionset_mgr_shared.csc
************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#namespace visionset_mgr;

function private autoexec __init__system__() {
  system::register(#"visionset_mgr", &preinit, &finalize_initialization, undefined, undefined);
}

function private preinit() {
  level.vsmgr_initializing = 1;
  level.vsmgr_default_info_name = "__none";
  level.vsmgr = [];
  level.vsmgr_states_inited = [];
  level._fv2vs_unset_visionset = "default";
  level._fv2vs_prev_visionsets = [];
  level._fv2vs_prev_visionsets[0] = level._fv2vs_unset_visionset;
  level._fv2vs_prev_visionsets[1] = level._fv2vs_unset_visionset;
  level._fv2vs_prev_visionsets[2] = level._fv2vs_unset_visionset;
  level._fv2vs_prev_visionsets[3] = level._fv2vs_unset_visionset;
  level._fv2vs_force_instant_transition = [];
  level._fv2vs_force_instant_transition[0] = 0;
  level._fv2vs_force_instant_transition[1] = 0;
  level._fv2vs_force_instant_transition[2] = 0;
  level._fv2vs_force_instant_transition[3] = 0;
  level thread register_type("visionset", &visionset_slot_cb, &visionset_lerp_cb, &visionset_update_cb);
  register_visionset_info(level.vsmgr_default_info_name, 1, 1, "undefined", "undefined");
  level thread register_type("overlay", &overlay_slot_cb, &overlay_lerp_cb, &overlay_update_cb);
  register_overlay_info_style_none(level.vsmgr_default_info_name, 1, 1);
  level thread monitor();
}

function register_visionset_info(name, version, lerp_step_count, visionset_from, visionset_to, visionset_type = 0) {
  if(!register_info("visionset", name, version, lerp_step_count)) {
    return;
  }

  level.vsmgr[#"visionset"].info[name].visionset_from = visionset_from;
  level.vsmgr[#"visionset"].info[name].visionset_to = visionset_to;
  level.vsmgr[#"visionset"].info[name].visionset_type = visionset_type;
}

function register_overlay_info_style_none(name, version, lerp_step_count) {
  if(!register_info("overlay", name, version, lerp_step_count)) {
    return;
  }

  level.vsmgr[#"overlay"].info[name].style = 0;
}

function register_overlay_info_style_blur(name, version, lerp_step_count, transition_in, transition_out, magnitude) {}

function register_overlay_info_style_burn(name, version, lerp_step_count, duration) {}

function register_overlay_info_style_speed_blur(name, version, lerp_step_count, amount, inner_radius, outer_radius, velocity_should_scale, velocity_scale, blur_in, blur_out, should_offset) {
  if(!register_info("overlay", name, version, lerp_step_count)) {
    return;
  }

  level.vsmgr[#"overlay"].info[name].style = 8;
  level.vsmgr[#"overlay"].info[name].amount = amount;
  level.vsmgr[#"overlay"].info[name].inner_radius = inner_radius;
  level.vsmgr[#"overlay"].info[name].outer_radius = outer_radius;
  level.vsmgr[#"overlay"].info[name].velocity_should_scale = velocity_should_scale;
  level.vsmgr[#"overlay"].info[name].velocity_scale = velocity_scale;
  level.vsmgr[#"overlay"].info[name].blur_in = blur_in;
  level.vsmgr[#"overlay"].info[name].blur_out = blur_out;
  level.vsmgr[#"overlay"].info[name].should_offset = should_offset;
}

function register_overlay_info_style_postfx_bundle(name, version, lerp_step_count, bundle, duration) {
  if(!register_info("overlay", name, version, lerp_step_count)) {
    return;
  }

  level.vsmgr[#"overlay"].info[name].style = 1;
  level.vsmgr[#"overlay"].info[name].bundle = bundle;
  level.vsmgr[#"overlay"].info[name].duration = duration;
}

function is_type_currently_default(localclientnum, type) {
  if(!level.vsmgr[type].in_use) {
    return true;
  }

  state = get_state(localclientnum, type);

  if(isDefined(state)) {
    curr_info = get_info(type, state.curr_slot);
    return (curr_info.name === level.vsmgr_default_info_name);
  }

  return false;
}

function register_type(type, cf_slot_cb, cf_lerp_cb, update_cb) {
  level.vsmgr[type] = spawnStruct();
  level.vsmgr[type].type = type;
  level.vsmgr[type].in_use = 0;
  level.vsmgr[type].highest_version = 0;
  level.vsmgr[type].server_version = getserverhighestclientfieldversion();
  level.vsmgr[type].cf_slot_name = type + "_slot";
  level.vsmgr[type].cf_lerp_name = type + "_lerp";
  level.vsmgr[type].cf_slot_cb = cf_slot_cb;
  level.vsmgr[type].cf_lerp_cb = cf_lerp_cb;
  level.vsmgr[type].update_cb = update_cb;
  level.vsmgr[type].info = [];
  level.vsmgr[type].sorted_name_keys = [];
}

function finalize_initialization(localclientnum) {
  finalize_clientfields();
}

function finalize_clientfields() {
  foreach(v in level.vsmgr) {
    v thread finalize_type_clientfields();
  }

  level.vsmgr_initializing = 0;
}

function finalize_type_clientfields() {
  println("<dev string:x38>" + self.type + "<dev string:x4b>");

  if(1 >= self.info.size) {
    return;
  }

  self.in_use = 1;
  self.cf_slot_bit_count = getminbitcountfornum(self.info.size - 1);
  self.cf_lerp_bit_count = self.info[self.sorted_name_keys[0]].lerp_bit_count;

  for(i = 0; i < self.sorted_name_keys.size; i++) {
    self.info[self.sorted_name_keys[i]].slot_index = i;

    if(self.info[self.sorted_name_keys[i]].lerp_bit_count > self.cf_lerp_bit_count) {
      self.cf_lerp_bit_count = self.info[self.sorted_name_keys[i]].lerp_bit_count;
    }

    println("<dev string:x66>" + self.info[self.sorted_name_keys[i]].name + "<dev string:x74>" + self.info[self.sorted_name_keys[i]].version + "<dev string:x83>" + self.info[self.sorted_name_keys[i]].lerp_step_count + "<dev string:x9a>");
  }

  clientfield::register("toplayer", self.cf_slot_name, self.highest_version, self.cf_slot_bit_count, "int", self.cf_slot_cb, 0, 1);

  if(1 < self.cf_lerp_bit_count) {
    clientfield::register("toplayer", self.cf_lerp_name, self.highest_version, self.cf_lerp_bit_count, "float", self.cf_lerp_cb, 0, 1);
  }
}

function validate_info(type, name, version) {
  keys = getarraykeys(level.vsmgr);

  for(i = 0; i < keys.size; i++) {
    if(type == keys[i]) {
      break;
    }
  }

  assert(i < keys.size, "<dev string:x9e>" + type + "<dev string:xba>");

  if(version > level.vsmgr[type].server_version) {
    return false;
  }

  if(isDefined(level.vsmgr[type].info[name]) && version < level.vsmgr[type].info[name].version) {
    if(version < level.vsmgr[type].info[name].version) {
      return false;
    }

    level.vsmgr[type].info[name] = undefined;
  }

  return true;
}

function add_sorted_name_key(type, name) {
  for(i = 0; i < level.vsmgr[type].sorted_name_keys.size; i++) {
    if(name < level.vsmgr[type].sorted_name_keys[i]) {
      break;
    }
  }

  arrayinsert(level.vsmgr[type].sorted_name_keys, name, i);
}

function add_info(type, name, version, lerp_step_count) {
  self.type = type;
  self.name = name;
  self.version = version;
  self.lerp_step_count = lerp_step_count;
  self.lerp_bit_count = getminbitcountfornum(lerp_step_count);
}

function register_info(type, name, version, lerp_step_count) {
  assert(level.vsmgr_initializing, "<dev string:xc9>");
  lower_name = tolower(name);

  if(!validate_info(type, lower_name, version)) {
    return false;
  }

  add_sorted_name_key(type, lower_name);
  level.vsmgr[type].info[lower_name] = spawnStruct();
  level.vsmgr[type].info[lower_name] add_info(type, lower_name, version, lerp_step_count);

  if(version > level.vsmgr[type].highest_version) {
    level.vsmgr[type].highest_version = version;
  }

  return true;
}

function slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, type) {
  init_states(bnewent);
  level.vsmgr[type].state[bnewent].curr_slot = binitialsnap;

  if(fieldname || bwastimejump) {
    level.vsmgr[type].state[bnewent].force_update = 1;
  }

  level notify(#"hash_4dea82d5e85dfc");
}

function visionset_slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "visionset");
}

function overlay_slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "overlay");
}

function lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, type) {
  init_states(bnewent);
  level.vsmgr[type].state[bnewent].curr_lerp = binitialsnap;

  if(fieldname || bwastimejump) {
    level.vsmgr[type].state[bnewent].force_update = 1;
  }

  level notify(#"hash_4dea82d5e85dfc");
}

function visionset_lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "visionset");
}

function overlay_lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "overlay");
}

function get_info(type, slot) {
  return level.vsmgr[type].info[level.vsmgr[type].sorted_name_keys[slot]];
}

function get_state(localclientnum, type) {
  if(!isDefined(level.vsmgr[type].state)) {
    return undefined;
  }

  return level.vsmgr[type].state[localclientnum];
}

function should_update_state() {
  return self.force_update || self.prev_slot != self.curr_slot || self.prev_lerp != self.curr_lerp;
}

function transition_state() {
  self.prev_slot = self.curr_slot;
  self.prev_lerp = self.curr_lerp;
  self.force_update = 0;
}

function init_states(localclientnum) {
  if(isDefined(level.vsmgr_states_inited[localclientnum])) {
    return;
  }

  foreach(v in level.vsmgr) {
    if(!v.in_use) {
      continue;
    }

    if(!isDefined(v.state)) {
      v.state = [];
    }

    v.state[localclientnum] = spawnStruct();
    v.state[localclientnum].prev_slot = v.info[level.vsmgr_default_info_name].slot_index;
    v.state[localclientnum].curr_slot = v.info[level.vsmgr_default_info_name].slot_index;
    v.state[localclientnum].prev_lerp = 1;
    v.state[localclientnum].curr_lerp = 1;
    v.state[localclientnum].force_update = 0;
  }

  level.vsmgr_states_inited[localclientnum] = 1;
}

function demo_jump_monitor() {
  if(!level.isdemoplaying) {
    return;
  }

  oldlerps = [];

  while(true) {
    level waittill(#"demo_jump", #"demo_player_switch", #"visionset_mgr_reset");

    foreach(v in level.vsmgr) {
      if(!v.in_use) {
        continue;
      }

      if(isDefined(v.state)) {
        v.state[0].force_update = 1;
      }
    }

    level notify(#"hash_4dea82d5e85dfc");
  }
}

function demo_spectate_monitor() {
  if(!level.isdemoplaying) {
    return;
  }

  while(true) {
    if(function_65b9eb0f(0)) {
      if(!is_true(level.vsmgr_is_spectating)) {
        level notify(#"visionset_mgr_reset");
      }

      level.vsmgr_is_spectating = 1;
    } else {
      if(is_true(level.vsmgr_is_spectating)) {
        level notify(#"visionset_mgr_reset");
      }

      level.vsmgr_is_spectating = 0;
    }

    waitframe(1);
  }
}

function monitor() {
  while(level.vsmgr_initializing) {
    waitframe(1);
  }

  if(is_true(level.isdemoplaying)) {
    level thread demo_spectate_monitor();
    level thread demo_jump_monitor();
  }

  while(true) {
    level waittill(#"hash_4dea82d5e85dfc");

    foreach(k, v in level.vsmgr) {
      if(!v.in_use) {
        continue;
      }

      for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        init_states(localclientnum);

        if(v.state[localclientnum] should_update_state()) {
          v thread[[v.update_cb]](localclientnum, k);
          v.state[localclientnum] transition_state();
        }
      }
    }
  }
}

function killcam_visionset_vehicle_mismatch(visionset_to, visionset_vehicle, vehicletype) {
  if(visionset_to == visionset_vehicle) {
    if(isDefined(self.vehicletype) && self.vehicletype != vehicletype) {
      return true;
    }
  }

  return false;
}

function killcam_visionset_player_mismatch(visionset_to, visionset_vehicle) {
  if(visionset_to == visionset_vehicle) {
    if(!isPlayer(self)) {
      return true;
    }
  }

  return false;
}

function visionset_update_cb(localclientnum, type) {
  state = get_state(localclientnum, type);
  curr_info = get_info(type, state.curr_slot);
  prev_info = get_info(type, state.prev_slot);

  if(is_true(level.isdemoplaying) && function_65b9eb0f(localclientnum)) {
    visionsetnaked(localclientnum, "default", 0);
    return;
  }

  if(level.vsmgr_default_info_name == curr_info.name) {
    return;
  }

  if(function_1cbf351b(localclientnum)) {
    if(isDefined(curr_info.visionset_to)) {
      killcament = function_93e0f729(localclientnum);

      if(isDefined(killcament)) {
        if(curr_info.visionset_to == "mp_vehicles_agr" || curr_info.visionset_to == "mp_hellstorm") {
          if(killcament.type == "vehicle") {
            return;
          }
        }

        if(killcament killcam_visionset_vehicle_mismatch(curr_info.visionset_to, "mp_vehicles_dart", "veh_dart_mp")) {
          return;
        }

        if(killcament killcam_visionset_player_mismatch(curr_info.visionset_to, "mp_vehicles_turret")) {
          return;
        }

        if(killcament killcam_visionset_player_mismatch(curr_info.visionset_to, "mp_vehicles_sentinel")) {
          return;
        }
      }
    }
  }

  if(!isDefined(curr_info.visionset_from)) {
    if(curr_info.visionset_type == 6) {
      visionsetlaststandlerp(localclientnum, curr_info.visionset_to, level._fv2vs_prev_visionsets[localclientnum], state.curr_lerp);
    } else {
      visionsetnakedlerp(localclientnum, curr_info.visionset_to, level._fv2vs_prev_visionsets[localclientnum], state.curr_lerp);
    }

    return;
  }

  if(curr_info.visionset_type == 6) {
    visionsetlaststandlerp(localclientnum, curr_info.visionset_to, curr_info.visionset_from, state.curr_lerp);
    return;
  }

  visionsetnakedlerp(localclientnum, curr_info.visionset_to, curr_info.visionset_from, state.curr_lerp);
}

function overlay_update_cb(localclientnum, type) {
  state = get_state(localclientnum, type);

  if(!isDefined(state)) {
    return;
  }

  curr_info = get_info(type, state.curr_slot);
  prev_info = get_info(type, state.prev_slot);
  player = getlocalplayers()[localclientnum];

  if(state.force_update || state.prev_slot != state.curr_slot) {
    switch (prev_info.style) {
      case 0:
        break;
      case 1:
        if(isPlayer(player)) {
          player thread postfx::exitpostfxbundle(prev_info.bundle);
        }

        break;
      case 3:
        setblurbylocalclientnum(localclientnum, 0, prev_info.transition_out);
        break;
      case 8:
        disablespeedblur(localclientnum);
        break;
    }
  }

  if(is_true(level.isdemoplaying) && !function_65b9eb0f(localclientnum)) {
    return;
  }

  switch (curr_info.style) {
    case 0:
      break;
    case 1:
      if(isPlayer(player) && (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp)) {
        player thread postfx::playpostfxbundle(curr_info.bundle);
      }

      break;
    case 3:
      if(state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
        setblurbylocalclientnum(localclientnum, curr_info.magnitude, curr_info.transition_in);
      }

      break;
    case 8:
      if(state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
        if(isDefined(curr_info.should_offset)) {
          enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale, curr_info.blur_in, curr_info.blur_out, curr_info.should_offset);
        } else if(isDefined(curr_info.blur_out)) {
          enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale, curr_info.blur_in, curr_info.blur_out);
        } else if(isDefined(curr_info.blur_in)) {
          enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale, curr_info.blur_in);
        } else if(isDefined(curr_info.velocity_scale)) {
          enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale);
        } else if(isDefined(curr_info.velocity_should_scale)) {
          enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale);
        } else {
          enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius);
        }
      }

      break;
  }
}