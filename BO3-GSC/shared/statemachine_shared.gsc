/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\statemachine_shared.gsc
*************************************************/

#using scripts\shared\array_shared;
#namespace statemachine;

function create(name, owner, change_notify = "change_state") {
  state_machine = spawnstruct();
  state_machine.name = name;
  state_machine.states = [];
  state_machine.previous_state = undefined;
  state_machine.current_state = undefined;
  state_machine.next_state = undefined;
  state_machine.change_note = change_notify;
  if(isdefined(owner)) {
    state_machine.owner = owner;
  } else {
    state_machine.owner = level;
  }
  if(!isdefined(state_machine.owner.state_machines)) {
    state_machine.owner.state_machines = [];
  }
  state_machine.owner.state_machines[state_machine.name] = state_machine;
  return state_machine;
}

function clear() {
  if(isdefined(self.states) && isarray(self.states)) {
    foreach(state in self.states) {
      state.connections_notify = undefined;
      state.connections_utility = undefined;
    }
  }
  self.states = undefined;
  self.previous_state = undefined;
  self.current_state = undefined;
  self.next_state = undefined;
  self.owner = undefined;
  self notify("_cancel_connections");
}

function add_state(name, enter_func, update_func, exit_func, reenter_func) {
  if(!isdefined(self.states[name])) {
    self.states[name] = spawnstruct();
  }
  self.states[name].name = name;
  self.states[name].enter_func = enter_func;
  self.states[name].exit_func = exit_func;
  self.states[name].update_func = update_func;
  self.states[name].reenter_func = reenter_func;
  self.states[name].connections_notify = [];
  self.states[name].connections_utility = [];
  self.states[name].owner = self;
  return self.states[name];
}

function get_state(name) {
  return self.states[name];
}

function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc) {
  from_state = get_state(from_state_name);
  to_state = get_state(to_state_name);
  connection = spawnstruct();
  connection.to_state = to_state;
  connection.type = 0;
  connection.on_notify = on_notify;
  connection.checkfunc = checkfunc;
  from_state.connections_notify[on_notify] = connection;
  return from_state.connections_notify[from_state.connections_notify.size - 1];
}

function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore) {
  from_state = get_state(from_state_name);
  to_state = get_state(to_state_name);
  connection = spawnstruct();
  connection.to_state = to_state;
  connection.type = 1;
  connection.checkfunc = checkfunc;
  connection.score = defaultscore;
  if(!isdefined(connection.score)) {
    connection.score = 100;
  }
  if(!isdefined(from_state.connections_utility)) {
    from_state.connections_utility = [];
  } else if(!isarray(from_state.connections_utility)) {
    from_state.connections_utility = array(from_state.connections_utility);
  }
  from_state.connections_utility[from_state.connections_utility.size] = connection;
  return from_state.connections_utility[from_state.connections_utility.size - 1];
}

function set_state(name, state_params) {
  state = self.states[name];
  if(!isdefined(self.owner)) {
    return false;
  }
  if(!isdefined(state)) {
    assertmsg((("" + name) + "") + self.name);
    return false;
  }
  reenter = self.current_state === state;
  if(isdefined(state.reenter_func) && reenter) {
    shouldreenter = self.owner[[state.reenter_func]](state.state_params);
  }
  if(reenter && shouldreenter !== 1) {
    return false;
  }
  if(isdefined(self.current_state)) {
    self.next_state = state;
    if(isdefined(self.current_state.exit_func)) {
      self.owner[[self.current_state.exit_func]](self.current_state.state_params);
    }
    if(!reenter) {
      self.previous_state = self.current_state;
    }
    self.current_state.state_params = undefined;
  }
  if(!isdefined(state_params)) {
    state_params = spawnstruct();
  }
  state.state_params = state_params;
  self.owner notify(self.change_note);
  self.current_state = state;
  self threadnotifyconnections(self.current_state);
  if(isdefined(self.current_state.enter_func)) {
    self.owner[[self.current_state.enter_func]](self.current_state.state_params);
  }
  if(isdefined(self.current_state.update_func)) {
    self.owner thread[[self.current_state.update_func]](self.current_state.state_params);
  }
  return true;
}

function threadnotifyconnections(state) {
  self notify("_cancel_connections");
  foreach(connection in state.connections_notify) {
    assert(connection.type == 0);
    self.owner thread connection_on_notify(self, connection.on_notify, connection);
  }
}

function connection_on_notify(state_machine, notify_name, connection) {
  self endon(state_machine.change_note);
  state_machine endon("_cancel_connections");
  while (true) {
    self waittill(notify_name, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15);
    params = spawnstruct();
    params.notify_param = [];
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param0;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param1;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param2;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param3;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param4;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param5;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param6;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param7;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param8;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param9;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param10;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param11;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param12;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param13;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param14;
    if(!isdefined(params.notify_param)) {
      params.notify_param = [];
    } else if(!isarray(params.notify_param)) {
      params.notify_param = array(params.notify_param);
    }
    params.notify_param[params.notify_param.size] = param15;
    connectionvalid = 1;
    if(isdefined(connection.checkfunc)) {
      connectionvalid = self[[connection.checkfunc]](self.current_state, connection.to_state.name, connection, params);
    }
    if(connectionvalid) {
      state_machine thread set_state(connection.to_state.name, params);
    }
  }
}

function evaluate_connections(eval_func, params) {
  assert(isdefined(self.current_state));
  connectionarray = [];
  scorearray = [];
  best_connection = undefined;
  best_score = -1;
  foreach(connection in self.current_state.connections_utility) {
    assert(connection.type == 1);
    score = connection.score;
    if(isdefined(connection.checkfunc)) {
      score = self.owner[[connection.checkfunc]](self.current_state.name, connection.to_state.name, connection);
    }
    if(score > 0) {
      if(!isdefined(connectionarray)) {
        connectionarray = [];
      } else if(!isarray(connectionarray)) {
        connectionarray = array(connectionarray);
      }
      connectionarray[connectionarray.size] = connection;
      if(!isdefined(scorearray)) {
        scorearray = [];
      } else if(!isarray(scorearray)) {
        scorearray = array(scorearray);
      }
      scorearray[scorearray.size] = score;
      if(score > best_score) {
        best_connection = connection;
        best_score = score;
      }
    }
  }
  if(isdefined(eval_func) && connectionarray.size > 0) {
    best_connection = self.owner[[eval_func]](connectionarray, scorearray, self.current_state);
  }
  if(isdefined(best_connection)) {
    self thread set_state(best_connection.to_state.name, params);
  }
}

function debugon() {
  dvarval = getdvarint("statemachine_debug");
  return dvarval;
}