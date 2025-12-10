/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_objectives.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_objectives;
#using scripts\cp\_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\objpoints_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;

class cobjective {
  var m_a_game_obj;
  var m_a_targets;
  var m_str_type;

  constructor() {}

  destructor() {}

  function is_breadcrumb() {
    return false;
  }

  function get_id_for_target(e_target) {
    foreach(i, obj_id in m_a_game_obj) {
      ent = m_a_targets[i];
      if(isDefined(ent) && ent == e_target) {
        return obj_id;
      }
    }
    return -1;
  }

  function show_for_target(e_target) {
    foreach(i, obj_id in m_a_game_obj) {
      ent = m_a_targets[i];
      if(isDefined(ent) && ent == e_target) {
        objective_state(obj_id, "active");
        return;
      }
    }
  }

  function hide_for_target(e_target) {
    foreach(i, obj_id in m_a_game_obj) {
      ent = m_a_targets[i];
      if(isDefined(ent) && ent == e_target) {
        objective_state(obj_id, "invisible");
        return;
      }
    }
  }

  function show(e_player) {
    if(isDefined(e_player)) {
      assert(isplayer(e_player), "");
      foreach(obj_id in m_a_game_obj) {
        objective_setvisibletoplayer(obj_id, e_player);
      }
    } else {
      foreach(obj_id in m_a_game_obj) {
        objective_setvisibletoall(obj_id);
      }
    }
  }

  function hide(e_player) {
    if(isDefined(e_player)) {
      assert(isplayer(e_player), "");
      foreach(obj_id in m_a_game_obj) {
        objective_setinvisibletoplayer(obj_id, e_player);
      }
    } else {
      foreach(obj_id in m_a_game_obj) {
        objective_setinvisibletoall(obj_id);
      }
    }
  }

  function complete(a_target_or_list) {
    if(a_target_or_list.size > 0) {
      foreach(target in a_target_or_list) {
        for(i = m_a_targets.size - 1; i >= 0; i--) {
          if(m_a_targets[i] == target) {
            objective_state(m_a_game_obj[i], "done");
            arrayremoveindex(m_a_game_obj, i);
            arrayremoveindex(m_a_targets, i);
            break;
          }
        }
      }
    } else {
      foreach(n_gobj_id in m_a_game_obj) {
        objective_state(n_gobj_id, "done");
      }
      for(i = m_a_targets.size - 1; i >= 0; i--) {
        arrayremoveindex(m_a_game_obj, i);
        arrayremoveindex(m_a_targets, i);
      }
    }
    if(m_a_game_obj.size == 0) {
      arrayremovevalue(level.a_objectives, self, 1);
    }
  }

  function add_target(target) {
    if(isinarray(m_a_targets, target)) {
      return;
    }
    gobj_id = undefined;
    if(m_a_targets.size < m_a_game_obj.size) {
      gobj_id = m_a_game_obj[m_a_game_obj.size - 1];
    } else {
      gobj_id = gameobjects::get_next_obj_id();
      array::add(m_a_game_obj, gobj_id);
    }
    if(isvec(target) || isentity(target)) {
      objective_add(gobj_id, "active", target, istring(m_str_type));
    } else {
      objective_add(gobj_id, "active", target.origin, istring(m_str_type));
    }
    array::add(m_a_targets, target);
    assert(m_a_targets.size == m_a_game_obj.size);
  }

  function update_counter(x_val, y_val) {
    update_value("obj_x", x_val);
    if(isDefined(y_val)) {
      update_value("obj_y", y_val);
    }
  }

  function update_value(str_menu_data_name, value) {
    gobj_id = m_a_game_obj[0];
    objective_setuimodelvalue(gobj_id, str_menu_data_name, value);
  }

  function init(str_type, a_target_list, b_done = 0) {
    m_a_targets = [];
    m_a_game_obj = [];
    m_str_type = str_type;
    if(b_done) {
      gobj_id = gameobjects::get_next_obj_id();
      m_a_game_obj = array(gobj_id);
      objective_add(gobj_id, "done", (0, 0, 0), istring(str_type));
    } else {
      if(isDefined(a_target_list) && a_target_list.size > 0) {
        foreach(target in a_target_list) {
          add_target(target);
        }
      } else {
        gobj_id = gameobjects::get_next_obj_id();
        m_a_game_obj = array(gobj_id);
        objective_add(gobj_id, "active", (0, 0, 0), istring(str_type));
      }
    }
  }

}

class cbreadcrumbobjective: cobjective {
  var m_done;
  var m_str_type;
  var m_str_first_trig_targetname;
  var m_a_player_game_obj;
  var m_a_game_obj;

  constructor() {}

  destructor() {}

  function is_done() {
    return m_done;
  }

  function is_breadcrumb() {
    return true;
  }

  function do_player_breadcrumb(player) {
    level endon("breadcrumb_" + m_str_type);
    level endon(("breadcrumb_" + m_str_type) + "_complete");
    player endon("death");
    str_trig_targetname = m_str_first_trig_targetname;
    entnum = player getentitynumber();
    obj_id = m_a_player_game_obj[entnum];
    objective_setvisibletoplayer(obj_id, player);
    do {
      t_current = getent(str_trig_targetname, "targetname");
      if(isDefined(t_current)) {
        if(isDefined(t_current.target)) {
          if(isDefined(t_current.script_flag_true)) {
            objective_setinvisibletoplayer(obj_id, player);
            level flag::wait_till(t_current.script_flag_true);
            objective_setvisibletoplayer(obj_id, player);
          }
          s_current = struct::get(t_current.target, "targetname");
          if(isDefined(s_current)) {
            set_player_objective(player, s_current);
          } else {
            set_player_objective(player, t_current);
          }
        } else {
          set_player_objective(player, t_current);
        }
        str_trig_targetname = t_current.target;
        t_current trigger::wait_till(undefined, undefined, player);
      } else {
        str_trig_targetname = undefined;
      }
    }
    while(isDefined(str_trig_targetname));
    objective_setinvisibletoplayer(obj_id, player);
    foreach(player in level.players) {
      player.v_current_active_breadcrumb = undefined;
    }
    m_done = 1;
  }

  function private set_player_objective(player, target) {
    entnum = player getentitynumber();
    obj_id = m_a_player_game_obj[entnum];
    n_breadcrumb_height = 72;
    v_pos = target;
    if(!isvec(target)) {
      v_pos = target.origin;
      if(isDefined(target.script_height)) {
        n_breadcrumb_height = target.script_height;
      }
    }
    v_pos = util::ground_position(v_pos, 300, n_breadcrumb_height);
    player.v_current_active_breadcrumb = v_pos;
    objective_position(obj_id, v_pos);
    objective_state(obj_id, "active");
  }

  function add_player(player) {
    entnum = player getentitynumber();
    obj_id = m_a_player_game_obj[entnum];
    objective_setinvisibletoall(obj_id);
    objective_setvisibletoplayer(obj_id, player);
    objective_state(obj_id, "active");
    thread do_player_breadcrumb(player);
  }

  function start(str_trig_targetname) {
    m_str_first_trig_targetname = str_trig_targetname;
    m_done = 0;
    foreach(player in level.players) {
      add_player(player);
    }
  }

  function show(e_player) {
    if(isDefined(e_player)) {
      assert(isplayer(e_player), "");
      entnum = e_player getentitynumber();
      obj_id = m_a_player_game_obj[entnum];
      objective_setvisibletoplayer(obj_id, e_player);
    } else {
      for(i = 0; i < 4; i++) {
        obj_id = m_a_player_game_obj[i];
        objective_setvisibletoplayerbyindex(obj_id, i);
      }
    }
  }

  function hide(e_player) {
    if(isDefined(e_player)) {
      assert(isplayer(e_player), "");
      entnum = e_player getentitynumber();
      obj_id = m_a_player_game_obj[entnum];
      objective_setinvisibletoplayer(obj_id, e_player);
    } else {
      for(i = 0; i < 4; i++) {
        obj_id = m_a_player_game_obj[i];
        objective_setinvisibletoplayerbyindex(obj_id, i);
      }
    }
  }

  function complete(a_target_or_list) {
    level notify(("breadcrumb_" + m_str_type) + "_complete");
    for(i = 0; i < 4; i++) {
      obj_id = m_a_player_game_obj[i];
      objective_state(obj_id, "done");
    }
    foreach(player in level.players) {
      player.v_current_active_breadcrumb = undefined;
    }
    cobjective::complete(a_target_or_list);
  }

  function init(str_type, a_target_list, b_done = 0) {
    cobjective::init(str_type, a_target_list, b_done);
    m_str_first_trig_targetname = "";
    m_done = b_done;
    m_a_player_game_obj = [];
    for(i = 0; i < 4; i++) {
      obj_id = gameobjects::get_next_obj_id();
      m_a_player_game_obj[i] = obj_id;
      if(m_done) {
        objective_add(obj_id, "done", (0, 0, 0), istring(m_str_type));
        continue;
      }
      objective_add(obj_id, "empty", (0, 0, 0), istring(m_str_type));
    }
    obj_id = m_a_game_obj[0];
    objective_setinvisibletoall(obj_id);
  }

}

#namespace objectives;

function autoexec __init__sytem__() {
  system::register("objectives", &__init__, undefined, undefined);
}

function __init__() {
  level.a_objectives = [];
  level.n_obj_index = 0;
  callback::on_spawned(&on_player_spawned);
}

function set(str_obj_type, a_target_or_list, b_breadcrumb) {
  if(!isDefined(level.a_objectives)) {
    level.a_objectives = [];
  }
  if(!isDefined(b_breadcrumb)) {
    b_breadcrumb = 0;
  }
  if(!isDefined(a_target_or_list)) {
    a_target_or_list = [];
  } else if(!isarray(a_target_or_list)) {
    a_target_or_list = array(a_target_or_list);
  }
  o_objective = undefined;
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    if(isDefined(a_target_or_list)) {
      foreach(target in a_target_or_list) {
        [
          [o_objective]
        ] - > add_target(target);
      }
    }
  } else {
    if(b_breadcrumb) {
      o_objective = new cbreadcrumbobjective();
    } else {
      o_objective = new cobjective();
    }
    [[o_objective]] - > init(str_obj_type, a_target_or_list);
    level.a_objectives[str_obj_type] = o_objective;
  }
  return o_objective;
}

function complete(str_obj_type, a_target_or_list) {
  if(!isDefined(a_target_or_list)) {
    a_target_or_list = [];
  } else if(!isarray(a_target_or_list)) {
    a_target_or_list = array(a_target_or_list);
  }
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    [[o_objective]] - > complete(a_target_or_list);
  } else {
    if(str_obj_type == "cp_waypoint_breadcrumb") {
      o_objective = new cbreadcrumbobjective();
    } else {
      o_objective = new cobjective();
    }
    [[o_objective]] - > init(str_obj_type, undefined, 1);
    level.a_objectives[str_obj_type] = o_objective;
  }
}

function set_with_counter(str_obj_id, a_targets) {
  if(!isDefined(a_targets)) {
    a_targets = [];
  } else if(!isarray(a_targets)) {
    a_targets = array(a_targets);
  }
  o_obj = set(str_obj_id, a_targets);
  [[o_obj]] - > update_counter(0, a_targets.size);
}

function update_counter(str_obj_id, x_val, y_val) {
  o_obj = level.a_objectives[str_obj_id];
  if(isDefined(o_obj)) {
    [[o_obj]] - > update_counter(x_val, y_val);
  }
}

function set_value(str_obj_id, str_menu_data_name, value) {
  o_obj = level.a_objectives[str_obj_id];
  if(isDefined(o_obj)) {
    [[o_obj]] - > update_value(str_menu_data_name, value);
  }
}

function breadcrumb(str_trig_targetname, str_obj_id = "cp_waypoint_breadcrumb", b_complete_on_first_player_finish = 1) {
  level notify("breadcrumb_" + str_obj_id);
  level endon("breadcrumb_" + str_obj_id);
  if(isDefined(level.a_objectives[str_obj_id])) {
    complete(str_obj_id);
  }
  o_objective = set(str_obj_id, undefined, 1);
  [[o_objective]] - > start(str_trig_targetname);
  while(![[o_objective]] - > is_done()) {
    wait(0.05);
  }
  if(b_complete_on_first_player_finish) {
    complete(str_obj_id);
  }
}

function hide(str_obj_type, e_player) {
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    [[o_objective]] - > hide(e_player);
  } else {
    assert(0, "");
  }
}

function hide_for_target(str_obj_type, e_target) {
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    [[o_objective]] - > hide_for_target(e_target);
  } else {
    assert(0, "");
  }
}

function show(str_obj_type, e_player) {
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    [[o_objective]] - > show(e_player);
  } else {
    assert(0, "");
  }
}

function show_for_target(str_obj_type, e_target) {
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    [[o_objective]] - > show_for_target(e_target);
  } else {
    assert(0, "");
  }
}

function get_id_for_target(str_obj_type, e_target) {
  id = -1;
  if(isDefined(level.a_objectives[str_obj_type])) {
    o_objective = level.a_objectives[str_obj_type];
    id = [[o_objective]] - > get_id_for_target(e_target);
  }
  if(id < 0) {
    assert(0, "");
  }
  return id;
}

function event_message(istr_message) {
  foreach(player in level.players) {
    util::show_event_message(player, istring(istr_message));
  }
}

function create_temp_icon(str_obj_type, str_obj_name, v_pos, v_offset = (0, 0, 0)) {
  switch (str_obj_type) {
    case "target": {
      str_shader = "waypoint_targetneutral";
      break;
    }
    case "capture": {
      str_shader = "waypoint_capture";
      break;
    }
    case "capture_a": {
      str_shader = "waypoint_capture_a";
      break;
    }
    case "capture_b": {
      str_shader = "waypoint_capture_b";
      break;
    }
    case "capture_c": {
      str_shader = "waypoint_capture_c";
      break;
    }
    case "defend": {
      str_shader = "waypoint_defend";
      break;
    }
    case "defend_a": {
      str_shader = "waypoint_defend_a";
      break;
    }
    case "defend_b": {
      str_shader = "waypoint_defend_b";
      break;
    }
    case "defend_c": {
      str_shader = "waypoint_defend_c";
      break;
    }
    case "return": {
      str_shader = "waypoint_return";
      break;
    }
    default: {
      assertmsg(("" + str_obj_type) + "");
      break;
    }
  }
  nextobjpoint = objpoints::create(str_obj_name, v_pos + v_offset, "all", str_shader);
  nextobjpoint setwaypoint(1, str_shader);
  return nextobjpoint;
}

function destroy_temp_icon() {
  objpoints::delete(self);
}

function private on_player_spawned() {
  if(isDefined(level.a_objectives)) {
    foreach(o_objective in level.a_objectives) {
      if([
          [o_objective]
        ] - > is_breadcrumb() && !([
          [o_objective]
        ] - > is_done())) {
        [
          [o_objective]
        ] - > add_player(self);
      }
    }
  }
}