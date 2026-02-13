/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zone_manager.gsc
*************************************************/

init_zone_manager() {
  if(isDefined(level.zone_manager)) {
    return;
  }
  level.zone_manager = spawnStruct();
  level.zone_manager.defs = [];
  level.zone_manager.inited_defs = [];
  level.zone_manager._id_106A5 = [];
  level.zone_manager.force_update_time = 0;
  level.zone_manager.dirty_zones = [];
  level.zone_manager._id_9C4A = 0;
  scripts\engine\utility::_id_5C11("zone_manager_dirty");
  level thread cache_zone_structs();
  level thread reevaluate_dirty_zones();

  if(getdvarint("#x326e8e0d91bfa02cb", 0)) {
    level thread auto_init_zones();
  }

  level.check_in_playable_area_func = ::is_in_playable_area;
  _id_06CB::_id_AA4E(::handle_player_in_playable_area);
}

zone_init(var_0) {
  if(!isDefined(level.zone_manager)) {
    return;
  }
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("zone_manager_cache_ready");
  var_1 = level.zone_manager.defs[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(get_zone_struct(var_0))) {
    return;
  }
  var_1.is_enabled = 0;
  var_1.is_active = 0;
  var_1.adjacent_zones = [];
  var_1.occupied_adjacencies = [];
  var_1._id_106A5 = get_volumes(var_1);
  var_1._id_A578 = get_nodes(var_1);
  var_1.aabb = get_aabb(var_1);
  var_1._id_A924 = [];
  var_2 = var_1.aabb["max"] - var_1.aabb["min"];
  var_3 = length(0.5 * var_2);
  level.zone_manager._id_9C4A = max(level.zone_manager._id_9C4A, var_3);
  level.zone_manager.inited_defs[var_0] = var_1;
}

add_adjacent_zone(var_0, var_1, var_2, var_3) {
  zone_init(var_0);
  zone_init(var_1);
  make_zone_adjacent(var_0, var_1, var_2);

  if(!istrue(var_3)) {
    make_zone_adjacent(var_1, var_0, var_2);
  }
}

make_zone_adjacent(var_0, var_1, var_2) {
  var_3 = get_zone_struct(var_0);
  var_4 = get_zone_struct(var_1);
  var_5 = undefined;

  if(!isDefined(var_3.adjacent_zones[var_1])) {
    var_5 = spawnStruct();
    var_5.is_connected = 0;
    var_5._id_01C4 = scripts\engine\utility::ter_op(_func_0107(var_2), var_2, [var_2]);
    var_3.adjacent_zones[var_1] = var_5;
  } else {
    var_5 = var_3.adjacent_zones[var_1];
    var_5.or_active_flags = 1;
    var_5._id_01C4 = scripts\engine\utility::_id_1B9D(var_5._id_01C4, scripts\engine\utility::ter_op(_func_0107(var_2), var_2, [var_2]));
  }

  foreach(var_7 in var_5._id_01C4) {
    scripts\engine\utility::_id_5C11(var_7);
  }

  level.zone_manager thread wait_for_active_flags(var_3, var_4, var_5);
}

set_zone_enabled(var_0, var_1) {
  var_2 = get_zone_struct(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2.is_enabled == var_1) {
    return;
  }
  var_2.is_enabled = var_1;
  force_update_current_zones();
  var_2 notify("zone_enable_changed", var_1);
  var_3 = spawnStruct();
  var_3.zone_name = var_0;
  var_3.zone_struct = var_2;
  var_3._id_523F = var_1;
  _id_06CB::_id_2F23("zone_enable_changed", var_3);
}

set_zone_active(var_0, var_1) {
  var_2 = get_zone_struct(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_2.is_active == var_1) {
    return;
  }
  var_2.is_active = var_1;
  var_2 notify("zone_active_changed", var_1);
  var_3 = spawnStruct();
  var_3.zone_name = var_0;
  var_3.zone_struct = var_2;
  var_3._id_0026 = var_1;
  _id_06CB::_id_2F23("zone_active_changed", var_3);
}

get_zone_struct(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  return level.zone_manager.inited_defs[var_0];
}

get_inited_zones() {
  return level.zone_manager.inited_defs;
}

get_all_zones() {
  scripts\engine\utility::_id_5C24("zone_manager_cache_ready");
  return level.zone_manager.defs;
}

get_active_zones() {
  scripts\engine\utility::_id_5C30("zone_manager_dirty");
  var_0 = [];

  foreach(var_2 in level.zone_manager.inited_defs) {
    if(var_2.is_active) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_642F(var_0) {
  if(!isDefined(self.zone_manager_disconnect_thread)) {
    thread zone_manager_disconnect_thread();
  }

  if(istrue(var_0)) {
    update_current_zone(1);
  } else if(!isDefined(self.cached_zone_info)) {
    update_current_zone();
  } else if(self.cached_zone_info._id_FBDD < level.zone_manager.force_update_time) {
    update_current_zone(1);
  } else if(self.cached_zone_info.valid_pos != self.origin) {
    update_current_zone();
  }

  if(!isDefined(self.cached_zone_info)) {
    return undefined;
  }

  return self.cached_zone_info.zone_struct;
}

get_adjacent_zones(var_0, var_1) {
  var_2 = [];

  foreach(var_6, var_4 in self.adjacent_zones) {
    var_5 = get_zone_struct(var_6);

    if(isDefined(var_5) && (!istrue(var_0) || var_5.is_enabled) && (!istrue(var_1) || var_4.is_connected)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

get_zone_occupants(var_0) {
  var_1 = get_zone_struct(var_0);

  if(!isDefined(var_1)) {
    return [];
  }

  return var_1._id_A924;
}

is_in_playable_area(var_0) {
  if(isent(var_0)) {
    var_1 = var_0.origin;
  } else if(isvector(var_0)) {
    var_1 = var_0;
  } else {
    return 0;
  }

  var_2 = scripts\engine\utility::_id_6369(var_1, level.zone_manager.inited_defs, undefined, undefined, level.zone_manager._id_9C4A);

  foreach(var_4 in var_2) {
    if(!var_4.is_enabled) {
      continue;
    }
    if(location_in_zone(var_1, var_4)) {
      return 1;
    }
  }

  return 0;
}

monitor_enter_playable_area() {
  self notify("monitor_enter_playable_area");
  self endon("monitor_enter_playable_area");
  self endon("death");
  self._id_3B1C = 0;
  var_0 = undefined;

  for(;;) {
    if(isDefined(level.check_in_playable_area_func)) {
      var_0 = [[level.check_in_playable_area_func]](self);
    } else {
      var_0 = is_in_playable_area(self);
    }

    if(istrue(var_0)) {
      self._id_3B1C = 1;
      self notify("completed_emerging_into_playable_area");
      var_1 = _id_642F(1);
      return;
    }

    wait 1;
  }
}

is_touching_zone(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, self);
  var_2 = var_0;

  if(_func_0121(var_0)) {
    var_2 = get_zone_struct(var_0);
  }

  if((!isDefined(var_2.aabb) || is_touching_aabb(var_1, var_2.aabb)) && var_1 _meth_813D(var_2._id_106A5).size) {
    return 1;
  }

  return 0;
}

location_in_zone(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(level.zone_manager.location_test_ent)) {
    level.zone_manager.location_test_ent = scripts\engine\utility::spawn_tag_origin(var_0);
  }

  level.zone_manager.location_test_ent.origin = var_0;
  return is_touching_zone(var_1, level.zone_manager.location_test_ent);
}

manage_zones() {
  level.zone_manager notify("manage_zones");
  level.zone_manager endon("manage_zones");
  level endon("game_ended");

  while(!isDefined(level.players)) {
    waitframe();
  }

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(istrue(var_1._id_E3E5)) {
        continue;
      }
      var_1 _id_642F();
      waitframe();
    }

    wait 0.2;
  }
}

force_update_current_zones() {
  level.zone_manager.force_update_time = gettime();
}

update_current_zone(var_0) {
  if(!istrue(var_0) && isDefined(self.cached_zone_info) && is_touching_zone(self.cached_zone_info.zone_struct)) {
    set_cache_zone(self.cached_zone_info.zone_struct);
    return;
  }

  var_1 = undefined;

  if(isDefined(self.cached_zone_info)) {
    var_1 = self.cached_zone_info.zone_struct;
  }

  var_2 = undefined;
  self.cached_zone_info = undefined;

  if(isPlayer(self) && isDefined(var_1) && isDefined(var_1._id_A924[self getentitynumber()])) {
    update_zone_occupant(var_1, self, 0);
  }

  foreach(var_4 in level.zone_manager.inited_defs) {
    if(var_4.is_enabled && is_touching_zone(var_4)) {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  set_cache_zone(var_2);

  if(isPlayer(self) && (!isDefined(var_1) && isDefined(var_2) || isDefined(var_1) && !isDefined(var_2) || isDefined(var_1) && isDefined(var_2) && var_1 != var_2)) {
    var_6 = spawnStruct();
    var_6.previous_zone_struct = var_1;
    var_6.zone_struct = var_2;
    _id_06CB::_id_2F23("zone_changed", var_6);
  }

  if(isPlayer(self)) {
    update_zone_occupant(self.cached_zone_info.zone_struct, self, 1);
  }
}

update_zone_occupant(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3) && isDefined(var_1)) {
    var_3 = var_1 getentitynumber();
  }

  if(!isDefined(var_3)) {
    return;
  }
  if(var_2) {
    var_0._id_A924[var_3] = var_1;
  } else {
    var_0._id_A924[var_3] = undefined;
  }

  update_occupied_adjacencies(var_0);
  level mark_zone_dirty(var_0);
}

update_occupied_adjacencies(var_0) {
  foreach(var_4, var_2 in var_0.adjacent_zones) {
    var_3 = get_zone_struct(var_4);

    if(!var_3.is_enabled || !var_2.is_connected) {
      continue;
    }
    var_3.occupied_adjacencies[var_0.script_zone_name] = ::scripts\engine\utility::ter_op(var_0._id_A924.size > 0, 1, undefined);
    level mark_zone_dirty(var_3);
  }
}

mark_zone_dirty(var_0) {
  level.zone_manager.dirty_zones[var_0.script_zone_name] = var_0;
  scripts\engine\utility::_id_5C1B("zone_manager_dirty");
}

set_cache_zone(var_0) {
  self.cached_zone_info = spawnStruct();
  self.cached_zone_info.zone_struct = var_0;
  self.cached_zone_info.valid_pos = self.origin;
  self.cached_zone_info._id_FBDD = gettime();
}

zone_manager_disconnect_thread() {
  level endon("game_ended");
  self.zone_manager_disconnect_thread = 1;
  var_0 = self getentitynumber();
  self waittill("death_or_disconnect");

  if(isDefined(self.cached_zone_info)) {
    update_zone_occupant(self.cached_zone_info.zone_struct, self, 0, var_0);
  }

  if(isDefined(self)) {
    self.zone_manager_disconnect_thread = undefined;
  }
}

wait_for_active_flags(var_0, var_1, var_2) {
  var_2 notify("wait_for_active_flags");
  var_2 endon("wait_for_active_flags");
  level endon("game_ended");

  if(istrue(var_2.or_active_flags)) {
    _flag_wait_any_array(var_2._id_01C4);
  } else {
    for(;;) {
      var_3 = 1;
      _flag_wait_any_array(var_2._id_01C4);

      foreach(var_5 in var_2._id_01C4) {
        if(!scripts\engine\utility::_id_5C00(var_5)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }
  }

  var_2.is_connected = 1;
  set_zone_enabled(var_0.script_zone_name, 1);
  update_occupied_adjacencies(var_0);
  mark_zone_dirty(var_0);
  set_zone_enabled(var_1.script_zone_name, 1);
  update_occupied_adjacencies(var_1);
  mark_zone_dirty(var_1);
}

_flag_wait_any_array(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::_id_5C00(var_3)) {
      var_1++;
    }

    level endon(var_3);
  }

  if(var_1 == var_0.size) {
    return;
  }
  level waittill("dummy_wait");
}

cache_zone_structs() {
  level endon("game_ended");

  while(!isDefined(level._id_EA6A) || !level._id_EA6A.size) {
    waitframe();
  }

  var_0 = [];

  foreach(var_2 in level._id_EA6A) {
    if(isDefined(var_2.script_zone_name)) {
      var_0[var_2.script_zone_name] = var_2;
    }
  }

  level.zone_manager.defs = var_0;
  scripts\engine\utility::_id_5C1B("zone_manager_cache_ready");
}

get_volumes(var_0) {
  var_1 = getEntArray(var_0._id_0481, "target");

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  return var_1;
}

get_nodes(var_0) {
  var_1 = _func_00B3(var_0._id_0481, "target");

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  return var_1;
}

get_aabb(var_0) {
  var_1 = [];
  var_1["min"] = [];
  var_1["max"] = [];
  var_2 = [];

  foreach(var_4 in var_0._id_106A5) {
    var_5 = [];
    var_5["max"] = var_4 _meth_86AD();
    var_5["min"] = var_5["max"] * -1;

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_1["min"][var_6] = min(var_5["min"][var_6] + var_4.origin[var_6], scripts\cp\utility::_id_459B(var_1["min"][var_6], var_5["min"][var_6] + var_4.origin[var_6]));
      var_1["max"][var_6] = max(var_5["max"][var_6] + var_4.origin[var_6], scripts\cp\utility::_id_459B(var_1["max"][var_6], var_5["max"][var_6] + var_4.origin[var_6]));
    }
  }

  var_1["min"] = (var_1["min"][0], var_1["min"][1], var_1["min"][2]);
  var_1["max"] = (var_1["max"][0], var_1["max"][1], var_1["max"][2]);
  return var_1;
}

is_touching_aabb(var_0, var_1) {
  if(!isDefined(var_0.zone_aabb)) {
    var_2 = [];
    var_2["max"] = var_0 _meth_86AD();
    var_2["min"] = var_2["max"] * -1;
    var_2["midpoint"] = var_0 _meth_86AE();
    var_0.zone_aabb = var_2;
  }

  var_3 = var_0.zone_aabb["min"] + var_0.zone_aabb["midpoint"] + var_0.origin;
  var_4 = var_0.zone_aabb["max"] + var_0.zone_aabb["midpoint"] + var_0.origin;
  var_5 = var_1["min"];
  var_6 = var_1["max"];
  return var_3[0] <= var_6[0] && var_4[0] >= var_5[0] && var_3[1] <= var_6[1] && var_4[1] >= var_5[1] && var_3[2] <= var_6[2] && var_4[2] >= var_5[2];
}

auto_init_zones() {
  level endon("game_ended");

  if(istrue(level.zone_manager.auto_inited)) {
    return;
  }
  scripts\engine\utility::_id_5C24("zone_manager_cache_ready");

  foreach(var_1 in level.zone_manager.defs) {
    zone_init(var_1.script_zone_name);
    set_zone_enabled(var_1.script_zone_name, 1);
  }

  level.zone_manager.auto_inited = 1;
  level thread manage_zones();
}

reevaluate_dirty_zones() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::_id_5C24("zone_manager_dirty");
    waittillframeend;

    foreach(var_1 in level.zone_manager.dirty_zones) {
      if(var_1._id_A924.size || var_1.occupied_adjacencies.size) {
        set_zone_active(var_1.script_zone_name, 1);
        continue;
      }

      set_zone_active(var_1.script_zone_name, 0);
    }

    level.zone_manager.dirty_zones = [];
    scripts\engine\utility::_id_5C04("zone_manager_dirty");
    level notify("zone_update_complete");
  }
}

handle_player_in_playable_area() {
  self endon("disconnect");

  for(;;) {
    if(isalive(self) && !is_in_playable_area(self)) {
      var_0 = undefined;

      if(isDefined(level.check_on_moving_platform_func)) {
        var_0 = self[[level.check_on_moving_platform_func]]();
      }

      var_1 = undefined;

      if(isDefined(level.check_in_teleport_func)) {
        var_1 = self[[level.check_in_teleport_func]]();
      }

      if(!istrue(var_0) && !istrue(var_1)) {
        self dodamage(self.maxhealth * 0.2, self.origin);
      }
    }

    wait 1;
  }
}