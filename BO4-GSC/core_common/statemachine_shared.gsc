/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\statemachine_shared.gsc
***********************************************/

#namespace statemachine;

create(name, owner, change_notify = "change_state") {
  state_machine = spawnStruct();
  state_machine.name = name;
  state_machine.states = [];
  state_machine.previous_state = undefined;
  state_machine.current_state = undefined;
  state_machine.next_state = undefined;
  state_machine.change_note = change_notify;

  if(isDefined(owner)) {
    state_machine.owner = owner;
  } else {
    state_machine.owner = level;
  }

  if(!isDefined(state_machine.owner.state_machines)) {
    state_machine.owner.state_machines = [];
  }

  state_machine.owner.state_machines[state_machine.name] = state_machine;

  owner thread function_acc83382();

  return state_machine;
}

clear() {
  if(isDefined(self.states) && isarray(self.states)) {
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
  self notify(#"_cancel_connections");
}

add_state(name, enter_func, update_func, exit_func, reenter_func) {
  if(!isDefined(self.states[name])) {
    self.states[name] = spawnStruct();
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

get_state(name) {
  return self.states[name];
}

has_state(name) {
  return isDefined(self.states) && isDefined(self.states[name]);
}

add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc) {
  from_state = get_state(from_state_name);
  to_state = get_state(to_state_name);
  connection = spawnStruct();
  connection.to_state = to_state;
  connection.type = 0;
  connection.on_notify = on_notify;
  connection.checkfunc = checkfunc;
  from_state.connections_notify[on_notify] = connection;
  return from_state.connections_notify[from_state.connections_notify.size - 1];
}

add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore) {
  from_state = get_state(from_state_name);
  to_state = get_state(to_state_name);
  connection = spawnStruct();
  connection.to_state = to_state;
  connection.type = 1;
  connection.checkfunc = checkfunc;
  connection.score = defaultscore;

  if(!isDefined(connection.score)) {
    connection.score = 100;
  }

  if(!isDefined(from_state.connections_utility)) {
    from_state.connections_utility = [];
  } else if(!isarray(from_state.connections_utility)) {
    from_state.connections_utility = array(from_state.connections_utility);
  }

  from_state.connections_utility[from_state.connections_utility.size] = connection;
  return from_state.connections_utility[from_state.connections_utility.size - 1];
}

function_b94a7666(from_state_name, on_notify) {
  from_state = get_state(from_state_name);
  arrayremoveindex(from_state.connections_notify, on_notify, 1);
}

set_state(name, state_params) {
  state = self.states[name];

  if(!isDefined(self.owner)) {
    return false;
  }

  if(!isDefined(state)) {
    assertmsg("<dev string:x38>" + name + "<dev string:x56>" + self.name);
    return false;
  }

  reenter = self.current_state === state;

  if(isDefined(state.reenter_func) && reenter) {
    shouldreenter = self.owner[[state.reenter_func]](state.state_params);
  }

  if(reenter && shouldreenter !== 1) {
    return false;
  }

  if(isDefined(self.current_state)) {
    self.next_state = state;

    if(isDefined(self.current_state.exit_func)) {
      self.owner[[self.current_state.exit_func]](self.current_state.state_params);
    }

    if(!reenter) {
      self.previous_state = self.current_state;
    }

    self.current_state.state_params = undefined;
  }

  if(!isDefined(state_params)) {
    state_params = spawnStruct();
  }

  state.state_params = state_params;
  self.owner notify(self.change_note);
  self.current_state = state;
  self threadnotifyconnections(self.current_state);

  if(isDefined(self.current_state.enter_func)) {
    self.owner[[self.current_state.enter_func]](self.current_state.state_params);
  }

  if(isDefined(self.current_state.update_func)) {
    self.owner thread[[self.current_state.update_func]](self.current_state.state_params);
  }

  return true;
}

threadnotifyconnections(state) {
  self notify(#"_cancel_connections");

  foreach(connection in state.connections_notify) {
    assert(connection.type == 0);
    self.owner thread connection_on_notify(self, connection.on_notify, connection);
  }
}

connection_on_notify(state_machine, notify_name, connection) {
  self endon(state_machine.change_note);
  state_machine endon(#"_cancel_connections");

  while(true) {
    params = self waittill(notify_name);
    connectionvalid = 1;

    if(isDefined(connection.checkfunc)) {
      connectionvalid = self[[connection.checkfunc]](state_machine.current_state.name, connection.to_state.name, connection, params);
    }

    if(connectionvalid) {
      state_machine thread set_state(connection.to_state.name, params);
    }
  }
}

evaluate_connections(eval_func, params) {
  assert(isDefined(self.current_state));
  connectionarray = [];
  scorearray = [];
  best_connection = undefined;
  best_score = -1;

  foreach(connection in self.current_state.connections_utility) {
    assert(connection.type == 1);
    score = connection.score;

    if(isDefined(connection.checkfunc)) {
      score = self.owner[[connection.checkfunc]](self.current_state.name, connection.to_state.name, connection);
    }

    if(score > 0) {
      if(!isDefined(connectionarray)) {
        connectionarray = [];
      } else if(!isarray(connectionarray)) {
        connectionarray = array(connectionarray);
      }

      connectionarray[connectionarray.size] = connection;

      if(!isDefined(scorearray)) {
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

  if(isDefined(eval_func) && connectionarray.size > 0) {
    best_connection = self.owner[[eval_func]](connectionarray, scorearray, self.current_state);
  }

  if(isDefined(best_connection)) {
    self thread set_state(best_connection.to_state.name, params);
  }
}

debugon() {
  dvarval = getdvarint(#"statemachine_debug", 0);
  return dvarval > 0;
}

function_acc83382() {
  owner = self;

  if(!isDefined(owner)) {
    return;
  }

  if(!debugon()) {
    return;
  }

  owner notify(#"hash_616497f187c816cf");
  owner endon(#"death", #"hash_616497f187c816cf");
  heightstart = owner getmaxs()[2];

  if(!isDefined(heightstart)) {
    heightstart = 20;
  }

  while(true) {
    i = 1;

    foreach(state_machine in owner.state_machines) {
      statename = "<dev string:x6b>";

      if(isDefined(state_machine.current_state) && isDefined(state_machine.current_state.name)) {
        statename = state_machine.current_state.name;
      }

      if(!getdvarint(#"recorder_enablerec", 0)) {
        heightoffset = heightstart * i;
        print3d(owner.origin + (0, 0, heightoffset), "<dev string:x76>" + state_machine.name + "<dev string:x7d>" + statename, (1, 1, 0));
      } else {
        record3dtext("<dev string:x76>" + state_machine.name + "<dev string:x7d>" + statename, owner.origin, (1, 1, 0), "<dev string:x82>", owner, 1);
      }

      i++;
    }

    waitframe(1);
  }
}

