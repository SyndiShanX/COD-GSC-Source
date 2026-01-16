/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_statemachine.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

create_state_machine(name, owner, change_notify) {
  if(!isDefined(change_notify))
    change_notify = "change_state";

  state_machine = spawnstruct();
  state_machine.name = name;
  state_machine.states = [];
  state_machine.current_state = undefined;
  state_machine.next_state = undefined;
  state_machine.change_note = change_notify;

  if(isDefined(owner))
    state_machine.owner = owner;
  else
    state_machine.owner = level;

  if(!isDefined(state_machine.owner.state_machines))
    state_machine.owner.state_machines = [];

  state_machine.owner.state_machines[state_machine.owner.state_machines.size] = state_machine;
  return state_machine;
}

add_state(name, enter_func, exit_func, update_func, can_enter_func, can_exit_func) {
  state = spawnstruct();
  state.name = name;
  state.enter_func = enter_func;
  state.exit_func = exit_func;
  state.update_func = update_func;
  state.can_enter_func = can_enter_func;
  state.can_exit_func = can_exit_func;
  state.connections = [];
  self.states[self.states.size] = state;
  return state;
}

add_connection(name, to_state, priority, check_func, param1, param2) {
  connection = spawnstruct();
  connection.to_state = to_state;
  connection.check_func = check_func;
  connection.param1 = param1;
  connection.param2 = param2;
  connection.priority = priority;
  self.connections[self.connections.size] = connection;
}

add_connection_by_type(to_state, priority, type, compare_type, param1) {
  connection = spawnstruct();
  connection.to_state = to_state;
  connection.priority = priority;
  connection.type = type;
  connection.param1 = param1;
  connection.param2 = compare_type;

  switch (type) {
    case 0:
      connection.check_func = ::connection_enemy_dist;
      break;
    case 1:
      connection.check_func = ::connection_enemy_visible;
      break;
    case 3:
      connection.check_func = ::connection_enemy_valid;
      break;
    case 2:
      connection.check_func = ::connection_enemy_angle;
      break;
    case 5:
      connection.check_func = ::connection_enemy_health_pct;
      break;
    case 7:
      connection.check_func = ::connection_health_pct;
      break;
    case 4:
      break;
    case 6:
      break;
    default:

      assertmsg("Unknown Connection Type: " + type);

  }

  self.connections[self.connections.size] = connection;
}

set_state(name) {
  state = undefined;

  for(i = 0; i < self.states.size; i++) {
    if(self.states[i].name == name) {
      state = self.states[i];
      break;
    }
  }

  if(!isDefined(state)) {
    assertmsg("Could not find state named " + name + " in statemachine: " + self.name);

  }

  if(!isDefined(self.current_state)) {
    self.current_state = state;

    if(isDefined(self.current_state.enter_func))
      self.owner[[self.current_state.enter_func]]();

    if(isDefined(self.current_state.update_func))
      self.owner thread[[self.current_state.update_func]]();

    for(j = 0; j < self.current_state.connections.size; j++) {
      if(isDefined(self.current_state.connections[j].type)) {
        if(self.current_state.connections[j].type == 4) {
          if(isDefined(self.owner))
            self.owner thread connection_on_notify(self, self.current_state.connections[j].param1, self.current_state.connections[j]);

          continue;
        }

        if(self.current_state.connections[j].type == 6)
          self.owner thread connection_timer(self, self.current_state.connections[j].param1, self.current_state.connections[j]);
      }
    }
  } else {
    if(isDefined(self.current_state.can_exit_func)) {
      if(!self.owner[[self.current_state.can_exit_func]]())
        return;
    }

    if(isDefined(state.can_enter_func)) {
      if(!self.owner[[state.can_enter_func]]())
        return;
    }

    previous_state = self.current_state;
    self.current_state = state;

    if(isDefined(previous_state.exit_func))
      self.owner[[previous_state.exit_func]]();

    if(isDefined(self.current_state.enter_func))
      self.owner[[self.current_state.enter_func]]();

    self.owner notify(self.change_note);

    for(j = 0; j < self.current_state.connections.size; j++) {
      if(isDefined(self.current_state.connections[j].type)) {
        if(self.current_state.connections[j].type == 4) {
          if(isDefined(self.owner))
            self.owner thread connection_on_notify(self, self.current_state.connections[j].param1, self.current_state.connections[j]);

          continue;
        }

        if(self.current_state.connections[j].type == 6) {
          if(isDefined(self.owner))
            self.owner thread connection_timer(self, self.current_state.connections[j].param1, self.current_state.connections[j]);
        }
      }
    }

    if(isDefined(self.current_state.update_func))
      self.owner thread[[self.current_state.update_func]]();
  }
}

update_state_machine(dt) {
  self.owner endon("death");
  self endon("stop_state_machine_" + self.name);

  if(!isDefined(dt))
    dt = 0.05;

  while(true) {
    assert(isDefined(self.current_state), "Trying to update statemachine: " + self.name + " but it has no current state.");
    best_priority = -1;
    best_connection = undefined;
    connections = self.current_state.connections;

    for(i = 0; i < connections.size; i++) {
      if(isDefined(connections[i].check_func)) {
        if(self.owner[[connections[i].check_func]](connections[i].param1, connections[i].param2)) {
          if(connections[i].priority > best_priority) {
            best_priority = connections[i].priority;
            best_connection = connections[i];
          }
        }
      }
    }

    if(isDefined(best_connection))
      self set_state(best_connection.to_state);

    if(debugon() == 1) {
      print3d(self.owner.origin, "[" + self.name + "] State: " + self.current_state.name, (1, 1, 1), 1, 2, 1);

    } else if(debugon() == 2) {
      for(i = 0; i < self.owner.state_machines.size; i++) {
        machine = self.owner.state_machines[i];
        print3d(machine.owner.origin + (0, 0, 30 * i), "[" + machine.name + "] State: " + machine.current_state.name, (1, 1, 1), 1, 2, 1);
      }

    }

    wait(dt);
  }
}

debugon() {
  dvarval = getdvarint(#"_id_F7EFE201");
  return dvarval;
}

connection_enemy_dist(check_dist, compare_type) {
  if(!isDefined(self.enemy))
    return false;

  dist = distance(self.origin, self.enemy.origin);

  if(compare_type == 0)
    return dist < check_dist;
  else if(compare_type == 1)
    return dist > check_dist;
  else if(compare_type == 2)
    return dist == check_dist;
  else if(compare_type == 3)
    return dist <= check_dist;
  else if(compare_type == 4)
    return dist >= check_dist;

  return false;
}

connection_enemy_visible(trace_height_offset, compare_type) {
  if(!isDefined(self.enemy))
    return 0;

  if(isDefined(self.maxsightdistance)) {
    if(compare_type == 6) {
      if(self vehcansee(self.enemy) && distance2d(self.origin, self.enemy.origin) < self.maxsightdistance)
        return 1;
      else
        return 0;
    } else if(!self vehcansee(self.enemy) || distance2d(self.origin, self.enemy.origin) > self.maxsightdistance)
      return 1;
    else
      return 0;
  }

  return compare_type == 6 ? self vehcansee(self.enemy) : !self vehcansee(self.enemy);
}

connection_enemy_valid(param1, param2) {
  return isDefined(self.enemy);
}

connection_enemy_angle(check_angle, compare_type) {
  if(!isDefined(self.enemy))
    return false;

  forward = anglestoforward(self.angles);
  vec_to_enemy = vectornormalize(self.enemy.origin - self.origin);
  dot = vectordot(forward, vec_to_enemy);
  angle = acos(dot);

  if(compare_type == 0)
    return angle < check_angle;
  else if(compare_type == 1)
    return angle > check_angle;
  else if(compare_type == 2)
    return angle == check_angle;
  else if(compare_type == 3)
    return angle <= check_angle;
  else if(compare_type == 4)
    return angle >= check_angle;

  return false;
}

connection_on_notify(state_machine, notify_name, connection) {
  self endon(state_machine.change_note);

  while(true) {
    self waittill(notify_name, param);
    state_machine thread set_state(connection.to_state);
  }
}

connection_enemy_health_pct(check_pct, compare_type) {
  if(!isDefined(self.enemy))
    return false;

  health_pct = self.enemy.health / self.enemy.maxhealth * 100;

  if(compare_type == 0)
    return health_pct < check_pct;
  else if(compare_type == 1)
    return health_pct > check_pct;
  else if(compare_type == 2)
    return health_pct == check_pct;
  else if(compare_type == 3)
    return health_pct <= check_pct;
  else if(compare_type == 4)
    return health_pct >= check_pct;

  return false;
}

connection_health_pct(check_pct, compare_type) {
  health_pct = self.health / self.maxhealth * 100;

  if(compare_type == 0)
    return health_pct < check_pct;
  else if(compare_type == 1)
    return health_pct > check_pct;
  else if(compare_type == 2)
    return health_pct == check_pct;
  else if(compare_type == 3)
    return health_pct <= check_pct;
  else if(compare_type == 4)
    return health_pct >= check_pct;

  return false;
}

connection_timer(state_machine, time, connection) {
  self endon(state_machine.change_note);
  wait(time);
  state_machine thread set_state(connection.to_state);
}