/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_objectives.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  level.a_objectives = [];
  level.n_obj_index = 0;
  level thread objectives();
}

register_objective(str_objective) {
  if(!isDefined(level.a_objectives)) {
    level.a_objectives = [];
    level.n_obj_index = 0;
  }

  assert(level.n_obj_index < 32, "Too many objectives. Max limit is 32.");
  n_index = level.n_obj_index;
  level.a_objectives[n_index] = str_objective;
  level.n_obj_index++;
  level.a_obj_addstate[n_index] = 0;
  return n_index;
}

set_objective(n_objective, ent_or_pos, str_obj_type, n_targets, b_show_message, n_timer) {
  if(isDefined(n_objective)) {
    if(!isDefined(level.objective_queue))
      level.objective_queue = [];

    if(!isDefined(b_show_message))
      b_show_message = 1;

    s_info = spawnstruct();
    s_info.n_objective = n_objective;
    s_info.objective_pos = ent_or_pos;
    s_info.str_objective_type = str_obj_type;
    s_info.n_objective_targets = n_targets;
    s_info.b_show_message = b_show_message;
    s_info.n_timer = n_timer;

    if(isDefined(ent_or_pos) && !isvec(ent_or_pos))
      s_info.target_id = ent_or_pos.target_id;

    level.objective_queue[level.objective_queue.size] = s_info;
  } else {
    assertmsg("Undefined objective number. Make sure the objective is registered and a valid objective is passed into set_objective().");

  }
}

set_objective_perk(n_objective, ent_or_pos, n_fade_radius, e_volume) {
  if(!isDefined(n_fade_radius))
    n_fade_radius = 1024;

  assert(isDefined(n_objective), "Undefined objective number.Make sure the objective is registered and a valid objective is passed into set_objective_perk().");
  assert(isDefined(ent_or_pos), "Undefined ent_or_pos.Make sure a valid entity or world position is passed into set_objective_perk().");
  flag_wait("level.player");
  v_pos = undefined;

  if(isvec(ent_or_pos))
    v_pos = ent_or_pos;
  else
    v_pos = ent_or_pos.origin;

  if(!isDefined(e_volume)) {
    e_volume = spawn("trigger_radius", v_pos + (0, 0, 0 - n_fade_radius), 0, n_fade_radius, n_fade_radius * 2);
    e_volume.targetname = "perk_obj_trigger_" + n_objective;
  }

  objective_add(n_objective, "current", level.a_objectives[n_objective], v_pos);
  objective_setflag(n_objective, "perk", 1);
  setsaveddvar("cg_objectiveIndicatorPerkFarFadeDist", 10000);
  e_volume thread _objective_perk_volume(n_objective);
}

remove_objective_perk(n_objective) {
  level notify("stop_obj_" + n_objective);
  objective_delete(n_objective);
  t_radius = getent("perk_obj_trigger_" + n_objective, "targetname");

  if(isDefined(t_radius))
    t_radius delete();
}

_objective_perk_volume(n_objective) {
  level endon("stop_obj_" + n_objective);
  self endon("death");
  b_touching = 0;

  while(true) {
    while(isDefined(b_touching) && !b_touching) {
      if(level.player istouching(self)) {
        objective_set3d(n_objective, 1, "white", & "SP_OBJECTIVES_INTERACT");
        b_touching = 1;
      }

      wait 0.05;
    }

    while(isDefined(b_touching) && b_touching) {
      if(!level.player istouching(self)) {
        objective_set3d(n_objective, 0);
        b_touching = 0;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

skip_objective(n_objective) {
  set_objective(n_objective, undefined, undefined, undefined, 0);
  set_objective(n_objective, undefined, "done", undefined, 0);
}

_pop_objective() {
  while(!isDefined(level.objective_queue) || !isDefined(level.objective_queue[0]))
    wait 0.05;

  s_info = level.objective_queue[0];
  arrayremoveindex(level.objective_queue, 0);
  return s_info;
}

objectives() {
  while(level.a_objectives.size == 0)
    wait 0.05;

  n_current_obj = -1;
  pos = undefined;
  level.a_obj_addstate = [];
  level.a_obj_structs = [];

  for(i = 0; i < level.a_objectives.size; i++)
    level.a_obj_addstate[i] = 0;

  while(true) {
    s_info = _pop_objective();
    level.n_objective = s_info.n_objective;
    level.objective_pos = s_info.objective_pos;
    level.target_id = s_info.target_id;
    level.str_objective_type = s_info.str_objective_type;
    level.n_objective_targets = s_info.n_objective_targets;
    level.b_show_objective_message = s_info.b_show_message;

    if(!isDefined(level.n_target_id))
      level.n_target_id = 0;

    n_objective = level.n_objective;

    if(isDefined(level.n_objective_targets) && level.n_objective_targets != -1) {
      if(n_current_obj != n_objective) {
        objective_add(n_objective, "current", isDefined(level.str_objective_type) ? level.str_objective_type : "", level.objective_pos, undefined, level.b_show_objective_message);
        level.a_obj_addstate[n_objective] = 1;
      } else if(isDefined(level.objective_pos))
        objective_position(n_objective, level.objective_pos);

      if(level.a_objectives[n_objective] != & "")
        objective_string(n_objective, level.a_objectives[n_objective], level.n_objective_targets);
    } else if(n_current_obj != n_objective || !is_objective_pos_the_same(level.objective_pos, pos)) {
      if(isDefined(level.objective_pos) && (!isstring(level.str_objective_type) || level.str_objective_type != "remove" && level.str_objective_type != "active")) {
        b_use_pos_origin = 1;

        if(isvec(level.objective_pos) || issentient(level.objective_pos) || isDefined(level.objective_pos.classname) && level.objective_pos.classname == "script_vehicle" || isDefined(level.objective_pos.classname) && level.objective_pos.classname == "script_model")
          b_use_pos_origin = 0;

        if(n_current_obj != n_objective) {
          level.n_target_id = 0;

          if(level.a_obj_addstate[n_objective] != 1) {
            if(!b_use_pos_origin) {
              objective_add(n_objective, "current", level.a_objectives[n_objective], undefined, undefined, level.b_show_objective_message);
              level.a_obj_addstate[n_objective] = 1;
            } else {
              objective_add(n_objective, "current", level.a_objectives[n_objective], level.objective_pos.origin, undefined, level.b_show_objective_message);
              level.a_obj_addstate[n_objective] = 1;
              level.objective_pos thread set_target_id(level.n_target_id);
            }

            _objective_set_position(b_use_pos_origin);
          } else {
            objective_state(n_objective, "current", level.b_show_objective_message);
            _objective_set_position(b_use_pos_origin);
          }
        } else {
          if(isDefined(level.n_target_id) && isDefined(level.n_objective_targets)) {
            level.n_targets_objective = n_objective;
            level.n_target_id++;
          }

          _objective_set_position(b_use_pos_origin);
        }
      } else if(n_current_obj != n_objective) {
        if(isDefined(level.str_objective_type))
          objective_type();
        else if(level.a_obj_addstate[n_objective] != 1) {
          objective_add(n_objective, "current", level.a_objectives[n_objective], undefined, undefined, level.b_show_objective_message);
          level.a_obj_addstate[n_objective] = 1;
        }
      }
    }

    if(isDefined(level.objective_pos) || isDefined(level.target_id)) {
      if(isDefined(level.str_objective_type))
        objective_type(s_info.n_timer);
      else
        objective_set3d_prethink(n_objective, 1, (1, 1, 1));
    } else if(!isDefined(level.n_objective_targets)) {
      objective_set3d_prethink(n_objective, 0);

      if(isDefined(level.str_objective_type))
        objective_type();
    }

    n_current_obj = n_objective;
    pos = level.objective_pos;
    wait_network_frame();
  }
}

set_vectarget_id(v_obj_pos, n_target_id) {
  level.a_obj_structs[level.a_obj_structs.size] = spawnstruct();
  level.a_obj_structs[level.a_obj_structs.size].origin = v_obj_pos;
  level.a_obj_structs[level.a_obj_structs.size].target_id = n_target_id;
}

get_target_id(v_obj_pos) {
  for(i = 0; i < level.a_obj_structs.size; i++) {
    if(level.a_obj_structs[level.a_obj_structs.size].origin == v_obj_pos)
      return level.a_obj_structs[level.a_obj_structs.size].target_id;
  }
}

objective_type(n_timer) {
  if(!isDefined(n_timer))
    n_timer = 0;

  n_objective = level.n_objective;
  level notify("update_objective" + n_objective);

  if(!isstring(level.str_objective_type)) {
    objective_set3d_prethink(n_objective, 1, "default", level.str_objective_type, n_timer);
    return;
  }

  objective_setflag(n_objective, "fadeoutonscreen", 0);

  switch (level.str_objective_type) {
    case "active":
      objective_add(n_objective, "current", "", undefined, undefined, level.b_show_objective_message);
      break;
    case "done":
      objective_state(n_objective, "done", level.b_show_objective_message);

      if(isDefined(level.n_targets_objective) && level.n_targets_objective == n_objective)
        level.n_target_id = 0;

      break;
    case "failed":
      objective_state(n_objective, "failed", level.b_show_objective_message);
      break;
    case "delete":
      objective_delete(n_objective);
      break;
    case "remove":
      if(isDefined(level.target_id))
        objective_additionalposition(n_objective, level.target_id, (0, 0, 0));
      else if(isDefined(level.objective_pos) && isDefined(level.objective_pos.is_breadcrumb))
        objective_set3d_prethink(n_objective, 0);
      else if(isDefined(level.objective_pos) && isvec(level.objective_pos))
        objective_additionalposition(n_objective, get_target_id(level.objective_pos), (0, 0, 0));
      else
        objective_set3d_prethink(n_objective, 0);

      break;
    case "interact":
      objective_set3d_prethink(n_objective, 1, "white", & "SP_OBJECTIVES_INTERACT", n_timer);
      setsaveddvar("cg_objectiveIndicatorPerkFarFadeDist", 1024);
      objective_setflag(n_objective, "perk", 1);
      break;
    case "defend":
      objective_set3d_prethink(n_objective, 1, "default", & "SP_OBJECTIVES_DEFEND", n_timer);
      objective_setflag(n_objective, "fadeoutonscreen", 1);
      break;
    case "follow":
      objective_set3d_prethink(n_objective, 1, "default", & "SP_OBJECTIVES_FOLLOW", n_timer);
      objective_setflag(n_objective, "fadeoutonscreen", 1);
      break;
    case "*":
      objective_set3d_prethink(n_objective, 1, "default", "*");
      break;
    case "":
    case "breadcrumb":
      objective_set3d_prethink(n_objective, 1, "default", undefined, n_timer);
      break;
    case "-":
      objective_set3d_prethink(n_objective, 1, "default", " ", n_timer);
      break;
    case "deactivate":
      objective_state(n_objective, "done", 0);
      break;
    case "reactivate":
      objective_state(n_objective, "active", 0);
      break;
    default:
      objstring = "SP_OBJECTIVES_" + toupper(level.str_objective_type);
      objective_set3d_prethink(n_objective, 1, "default", istring(objstring), n_timer);
      break;
  }
}

set_target_id(n_target_id) {
  if(!isDefined(self.target_id))
    self.target_id = n_target_id;
}

is_objective_pos_the_same(pos1, pos2) {
  if(!isDefined(pos1) && !isDefined(pos2))
    return true;
  else if(isDefined(pos1) && !isDefined(pos2))
    return false;
  else if(!isDefined(pos1) && isDefined(pos2))
    return false;
  else if(issentient(pos1) && !issentient(pos2))
    return false;
  else if(!issentient(pos1) && issentient(pos2))
    return false;
  else if(isvec(pos1) && !isvec(pos2))
    return false;
  else if(!isvec(pos1) && isvec(pos2))
    return false;
  else if(pos1 != pos2)
    return false;

  return true;
}

objective_breadcrumb(n_obj_index, str_trig_targetname) {
  do {
    t_current = getent(str_trig_targetname, "targetname");

    if(isDefined(t_current)) {
      if(isDefined(t_current.target)) {
        s_current = getstruct(t_current.target, "targetname");

        if(isDefined(s_current))
          set_objective(n_obj_index, s_current, "breadcrumb");
        else
          set_objective(n_obj_index, t_current, "breadcrumb");
      } else
        set_objective(n_obj_index, t_current, "breadcrumb");

      str_trig_targetname = t_current.target;
      t_current trigger_wait();
      continue;
    }

    str_trig_targetname = undefined;
  }
  while(isDefined(str_trig_targetname));
}

objective_breadcrumb_area(n_obj_index, str_area_name, str_endon) {
  level endon(str_endon);
  assert(self != level, "objective_breadcrumb_area:: self needs to be the entity to check against, such as the player or a vehicle");
  a_e_areas = getentarray(str_area_name, "targetname");
  assert(a_e_areas.size > 1, "objective_breadcrumb_area:: there should be at least 2 areas to use this function");
  e_curr_area = undefined;
  e_last_area = undefined;
  b_area_updated = 0;
  n_curr_obj = level.n_obj_index;

  while(n_curr_obj == level.n_obj_index) {
    foreach(e_area in a_e_areas) {
      if(isDefined(e_curr_area) && e_area == e_curr_area) {
        if(!self istouching(e_curr_area)) {
          e_curr_area = undefined;
          e_last_area = undefined;
        }

        continue;
      }

      if(isDefined(e_last_area) && e_area == e_last_area) {
        if(!self istouching(e_last_area))
          e_last_area = undefined;

        continue;
      }

      if(self istouching(e_area)) {
        e_last_area = e_curr_area;
        e_curr_area = e_area;
        b_area_updated = 1;
        break;
      }
    }

    if(b_area_updated) {
      b_area_updated = 0;
      s_dest = getstruct(e_curr_area.target, "targetname");

      if(isDefined(s_dest))
        set_objective(n_obj_index, s_dest, "breadcrumb");
      else {
        e_dest = getent(e_curr_area.target, "targetname");

        if(isDefined(e_dest))
          set_objective(n_obj_index, e_dest, "breadcrumb");
      }
    }

    wait 0.1;
  }
}

objective_set3d_prethink(n_objective, use3d, color, alternate_text, n_timer) {
  if(!isDefined(n_timer))
    n_timer = 0;

  if(!use3d) {
    objective_set3d(n_objective, use3d);
    return;
  }

  if(!isDefined(color))
    color = "default";

  if(!isDefined(alternate_text))
    alternate_text = "";

  position_offset = (0, 0, 0);

  if(isDefined(level.objective_pos) && !isvec(level.objective_pos)) {
    if(isDefined(level.objective_pos.classname) && level.objective_pos.classname == "script_vehicle") {
      switch (level.objective_pos.vehicletype) {
        case "horse":
        case "horse_low":
        case "horse_player":
        case "horse_player_low":
          position_offset = vectorscale((0, 0, 1), 72.0);
          break;
        case "heli_hind_afghan":
        case "heli_hind_angola":
        case "heli_hip":
        case "tank_t62":
        case "tank_t62_nophysics":
        case "truck_rts_convoy":
          position_offset = vectorscale((0, 0, 1), 132.0);
          break;
        case "apc_btr60":
          position_offset = (-24, 0, 108);
          break;
        case "plane_x78":
          position_offset = (96, 48, -75);
          break;
        case "apc_cougar_gun_turret":
        case "apc_cougar_gun_turret_low":
        case "civ_ambulance":
        case "civ_van_sprinter_la2":
          position_offset = vectorscale((0, 0, 1), 225.0);
          break;
        case "plane_f35_fast_la2":
        case "plane_f35_fast_nocockpit":
          position_offset = vectorscale((0, 0, 1), 512.0);
          break;
        case "drone_metalstorm":
        case "drone_metalstorm_karma":
        case "drone_metalstorm_rts":
          position_offset = vectorscale((0, 0, 1), 65.0);
      }
    } else if(!isDefined(level.objective_pos.classname) && !isDefined("trigger_radius") || isDefined(level.objective_pos.classname) && isDefined("trigger_radius") && level.objective_pos.classname == "trigger_radius")
      position_offset = (0, 0, level.objective_pos.height / 2);

    if(isDefined(level.objective_pos.use_obj_offset))
      position_offset = level.objective_pos.use_obj_offset;
  }

  objective_set3d(n_objective, use3d, color, alternate_text, -1, position_offset);

  if(n_timer != 0) {
    level thread _objective_set3d_prethink_flash(n_objective, use3d, color, alternate_text, position_offset, n_timer);
    return;
  }
}

private _objective_set3d_prethink_flash(objective_number, use3d, color, alternate_text, position_offset, n_timer) {
  level endon("update_objective" + objective_number);
  orig_color = color;
  s_timer = new_timer();

  while(true) {
    n_current_time = s_timer timer_wait(0.05);
    n_flash_wait = lerpfloat(1, 0.05, n_current_time / n_timer);
    objective_set3d(objective_number, use3d, "red", alternate_text, -1, position_offset);
    wait(n_flash_wait);
    objective_set3d(objective_number, use3d, orig_color, alternate_text, -1, position_offset);
    wait(n_flash_wait);
  }
}

_objective_set_position(b_use_pos_origin) {
  level notify("update_objective" + level.n_objective);

  if(b_use_pos_origin)
    objective_pos = level.objective_pos.origin;
  else
    objective_pos = level.objective_pos;

  if(isDefined(level.n_objective_targets)) {
    if(isDefined(level.a_freed_obj_id)) {
      n_target_id = undefined;

      for(i = 0; i < level.a_freed_obj_id.size; i++) {
        if(!level.a_freed_obj_id[i])
          n_target_id = i;
      }

      assert(isDefined(n_target_id), "Ran out of positions for a new objective in _objective_set_position()");

      if(!isvec(objective_pos))
        objective_pos.n_obj_id = n_target_id;
      else
        level notify("multi_objective_set", n_target_id);
    } else
      n_target_id = level.n_target_id;

    objective_additionalposition(level.n_objective, n_target_id, objective_pos);
    level.objective_pos thread set_target_id(n_target_id);
  } else {
    objective_position(level.n_objective, objective_pos);

    if(!isvec(level.objective_pos))
      level.objective_pos.is_breadcrumb = 1;
  }
}