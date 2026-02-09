/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: common_scripts\_elevator.gsc
***************************************************/

#include common_scripts\utility;

init() {
  if(getDvar("scr_elevator_disabled") == "1") {
    return;
  }

  elevator_groups = getEntArray("elevator_group", "targetname");
  if(!isDefined(elevator_groups)) {
    return;
  }
  if(!elevator_groups.size) {
    return;
  }

  precacheString(&"ELEVATOR_CALL_HINT");

  precacheString(&"ELEVATOR_USE_HINT");

  precacheString(&"ELEVATOR_FLOOR_SELECT_HINT");

  precacheMenu("elevator_floor_selector");

  thread elevator_update_global_dvars();

  level.elevators = [];

  level.elevator_callbutton_link_v = elevator_get_dvar_int("scr_elevator_callbutton_link_v", "96");

  level.elevator_callbutton_link_h = elevator_get_dvar_int("scr_elevator_callbutton_link_h", "256");

  build_elevators();
  position_elevators();
  elevator_call();

  if(!level.elevators.size) {
    return;
  }

  foreach(elevator in level.elevators) {
    elevator thread elevator_think();
    elevator thread elevator_sound_think();
  }

  thread elevator_debug();
}

elevator_update_global_dvars() {
  while(1) {
    level.elevator_accel = elevator_get_dvar("scr_elevator_accel", "0.2");
    level.elevator_decel = elevator_get_dvar("scr_elevator_decel", "0.2");
    level.elevator_music = elevator_get_dvar_int("scr_elevator_music", "1");
    level.elevator_speed = elevator_get_dvar_int("scr_elevator_speed", "96");
    level.elevator_innerdoorspeed = elevator_get_dvar_int("scr_elevator_innerdoorspeed", "14");
    level.elevator_outterdoorspeed = elevator_get_dvar_int("scr_elevator_outterdoorspeed", "16");
    level.elevator_return = elevator_get_dvar_int("scr_elevator_return", "0");
    level.elevator_waittime = elevator_get_dvar_int("scr_elevator_waittime", "6");
    level.elevator_aggressive_call = elevator_get_dvar_int("scr_elevator_aggressive_call", "0");
    level.elevator_debug = elevator_get_dvar_int("debug_elevator", "0");

    if(isSP()) {
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "0");
    } else {
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "1");
    }

    wait 1;
  }
}

elevator_think() {
  self elevator_fsm("[A]");
}

elevator_call() {
  foreach(callbutton in level.elevator_callbuttons) {
    callbutton thread monitor_callbutton();
  }
}

floor_override(inside_trig) {
  self endon("elevator_moving");

  self.floor_override = 0;
  self.overrider = undefined;

  while(1) {
    inside_trig waittill("trigger", player);
    self.floor_override = 1;
    self.overrider = player;
    break;
  }
  self notify("floor_override");
}

elevator_fsm(state) {
  self.eState = state;

  door_trig = self get_housing_door_trigger();
  inside_trig = self get_housing_inside_trigger();

  while(1) {
    if(self.eState == "[A]") {
      if(level.elevator_return && (self get_curFloor() != self get_initFloor())) {
        self.moveto_floor = self get_initFloor();
        self thread floor_override(inside_trig);
        self waittill_or_timeout("floor_override", level.elevator_waittime);

        if(self.floor_override && isDefined(self.overrider) && isPlayer(self.overrider)) {
          self get_floor(self.overrider);
        }

        self.eState = "[B]";
        continue;
      }

      while(1) {
        if(self.moveto_floor == self get_curFloor()) {
          param = inside_trig discrete_waittill("trigger");
        } else {
          param = "elevator_called";
        }

        if(isString(param) && (param == "elevator_called") && (self.moveto_floor != self get_curFloor())) {
          self.eState = "[B]";
          break;
        }

        if(isDefined(param) && isPlayer(param) && isAlive(param)) {
          isTouching_trigger = (param istouching(inside_trig));
          isTouching_motion_trigger = (isDefined(inside_trig.motion_trigger) && param istouching(inside_trig.motion_trigger));
          player_isTouching_trigger = (isTouching_trigger || isTouching_motion_trigger);

          if(player_isTouching_trigger) {
            player = param;
            self get_floor(player);

            if(self.moveto_floor == self get_curFloor()) {
              continue;
            }

            self.eState = "[B]";
            break;
          }
        }
      }
    }

    if(self.eState == "[B]") {
      self thread elevator_interrupt(door_trig);
      floor_num = self get_curFloor();

      self thread close_inner_doors();
      self thread close_outer_doors(floor_num);

      self waittill_any("closed_inner_doors", "interrupted");

      if(self.elevator_interrupted) {
        self.eState = "[C]";
        continue;
      }

      self.eState = "[D]";
      continue;
    }

    if(self.eState == "[C]") {
      floor_num = self get_curFloor();

      self thread open_inner_doors();
      self thread open_outer_doors(floor_num);

      self waittill("opened_floor_" + floor_num + "_outer_doors");

      if(self.elevator_interrupted) {
        self.eState = "[B]";
        continue;
      }

      self.eState = "[A]";
      continue;
    }

    if(self.eState == "[D]") {
      assertex(isDefined(self.moveto_floor), "Missing destination floor number");

      if(self.moveto_floor != self get_curFloor()) {
        self thread elevator_move(self.moveto_floor);
        self waittill("elevator_moved");
      }

      self.eState = "[C]";
      continue;
    }
  }
}

monitor_callbutton() {
  while(1) {
    player = self discrete_waittill("trigger");

    call_floor = undefined;
    call_elevators = [];

    foreach(idx, linked_elevators in self.e) {
      call_floor = idx;
      call_elevators = linked_elevators;
    }
    assert(isDefined(call_floor) && isDefined(call_elevators) && call_elevators.size);

    elevator_called = 0;

    foreach(elevator in call_elevators) {
      moving = elevator elevator_floor_update();

      if(!level.elevator_aggressive_call && !moving) {
        if(elevator get_curFloor() == call_floor) {
          elevator_called = 1;
          call_elevators = [];
          break;
        }
      }
    }

    foreach(elevator in call_elevators) {
      if(elevator.eState == "[A]") {
        elevator call_elevator(call_floor);

        elevator_called = 1;

        if(!level.elevator_aggressive_call) {
          break;
        }
      }
    }

    if(elevator_called) {
      self playSound("elev_bell_ding");
    }
  }
}

call_elevator(call_floor) {
  self.moveto_floor = call_floor;

  inside_trigger = self get_housing_inside_trigger();
  inside_trigger notify("trigger", "elevator_called");
  if(level.elevator_motion_detection) {
    inside_trigger.motion_trigger notify("trigger", "elevator_called");
  }
}

get_floor(player) {
  bifloor = self get_outer_doorsets();
  if(bifloor.size == 2) {
    curFloor = self get_curFloor();
    self.moveto_floor = !curFloor;
    return;
  }

  player openpopupmenu("elevator_floor_selector");
  player setClientDvar("player_current_floor", self get_curFloor());

  while(1) {
    player waittill("menuresponse", menu, response);

    if(menu == "elevator_floor_selector") {
      if(response != "none") {
        self.moveto_floor = int(response);
      }

      break;
    }
  }
}

elevator_interrupt(door_trig) {
  self notify("interrupt_watch");
  level notify("elevator_interior_button_pressed");
  self endon("interrupt_watch");
  self endon("elevator_moving");

  self.elevator_interrupted = 0;
  wait 0.5;
  door_trig waittill("trigger", player);

  self notify("interrupted");
  self.elevator_interrupted = 1;
}

elevator_floor_update() {
  mainframe = self get_housing_mainframe();
  cur_pos = mainframe.origin;

  moving = 1;
  foreach(idx, eFloor in self get_outer_doorsets()) {
    floor_pos = self.e["floor" + idx + "_pos"];
    if(cur_pos == floor_pos) {
      self.e["current_floor"] = idx;
      moving = 0;
    }
  }

  return moving;
}

elevator_sound_think() {
  musak_model = self get_housing_musak_model();

  if(level.elevator_music && isDefined(musak_model)) {
    musak_model playLoopSound("elev_musak_loop");
  }

  self thread listen_for("closing_inner_doors");
  self thread listen_for("opening_inner_doors");
  self thread listen_for("closed_inner_doors");
  self thread listen_for("opened_inner_doors");

  foreach(idx, eFloor in self get_outer_doorsets()) {
    self thread listen_for("closing_floor_" + idx + "_outer_doors");
    self thread listen_for("opening_floor_" + idx + "_outer_doors");
    self thread listen_for("closed_floor_" + idx + "_outer_doors");
    self thread listen_for("opened_floor_" + idx + "_outer_doors");
  }

  self thread listen_for("interrupted");

  self thread listen_for("elevator_moving");
  self thread listen_for("elevator_moved");
}

listen_for(msg) {
  while(1) {
    self waittill(msg);
    mainframe = self get_housing_mainframe();

    if(issubstr(msg, "closing_")) {
      mainframe playSound("elev_door_close");
    }

    if(issubstr(msg, "opening_")) {
      mainframe playSound("elev_door_open");
    }

    if(msg == "elevator_moving") {
      mainframe playSound("elev_run_start");
      mainframe playLoopSound("elev_run_loop");
    }

    if(msg == "interrupted") {
      mainframe playSound("elev_door_interupt");
    }

    if(msg == "elevator_moved") {
      mainframe stoploopsound("elev_run_loop");
      mainframe playSound("elev_run_end");
      mainframe playSound("elev_bell_ding");
    }
  }
}

position_elevators() {
  foreach(e, elevator in level.elevators) {
    elevator.moveto_floor = elevator get_curFloor();

    foreach(floor_num, outer_doorset in elevator get_outer_doorsets()) {
      if(elevator get_curFloor() != floor_num) {
        elevator thread close_outer_doors(floor_num);
      }
    }
  }
}

elevator_move(floor_num) {
  self notify("elevator_moving");
  self endon("elevator_moving");

  mainframe = self get_housing_mainframe();
  delta_vec = self.e["floor" + floor_num + "_pos"] - mainframe.origin;

  speed = level.elevator_speed;
  dist = abs(distance(self.e["floor" + floor_num + "_pos"], mainframe.origin));
  moveTime = dist / speed;

  mainframe moveTo(mainframe.origin + delta_vec, moveTime, moveTime * level.elevator_accel, moveTime * level.elevator_decel);

  foreach(part in self get_housing_children()) {
    moveto_pos = part.origin + delta_vec;

    if(!issubstr(part.classname, "trigger_")) {
      part moveTo(moveto_pos, moveTime, moveTime * level.elevator_accel, moveTime * level.elevator_decel);
    } else {
      part.origin = moveto_pos;
    }
  }

  self waittill_finish_moving(mainframe, self.e["floor" + floor_num + "_pos"]);

  self notify("elevator_moved");
}

close_inner_doors() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");

  left_door = self get_housing_leftdoor();
  right_door = self get_housing_rightdoor();

  mainframe = self get_housing_mainframe();
  old_closed_pos = self get_housing_closedpos();
  closed_pos = (old_closed_pos[0], old_closed_pos[1], mainframe.origin[2]);

  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(left_door.origin, closed_pos));
  moveTime = dist / speed;

  left_door moveTo(closed_pos, moveTime, moveTime * 0.1, moveTime * 0.25);
  right_door moveTo(closed_pos, moveTime, moveTime * 0.1, moveTime * 0.25);

  self waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
  self notify("closed_inner_doors");
}

open_inner_doors() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");

  left_door = self get_housing_leftdoor();
  right_door = self get_housing_rightdoor();

  mainframe = self get_housing_mainframe();
  old_left_opened_pos = self get_housing_leftdoor_opened_pos();
  old_right_opened_pos = self get_housing_rightdoor_opened_pos();

  left_opened_pos = (old_left_opened_pos[0], old_left_opened_pos[1], mainframe.origin[2]);
  right_opened_pos = (old_right_opened_pos[0], old_right_opened_pos[1], mainframe.origin[2]);

  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(left_opened_pos, right_opened_pos) * 0.5);
  moveTime = (dist / speed) * 0.5;

  left_door moveTo(left_opened_pos, moveTime, moveTime * 0.1, moveTime * 0.25);
  right_door moveTo(right_opened_pos, moveTime, moveTime * 0.1, moveTime * 0.25);

  self waittill_finish_moving(left_door, left_opened_pos, right_door, right_opened_pos);
  self notify("opened_inner_doors");
}

close_outer_doors(floor_num) {
  self notify("closing_floor_" + floor_num + "_outer_doors");
  self endon("closing_floor_" + floor_num + "_outer_doors");
  self endon("opening_floor_" + floor_num + "_outer_doors");

  left_door = self get_outer_leftdoor(floor_num);
  right_door = self get_outer_rightdoor(floor_num);

  left_opened_pos = self get_outer_leftdoor_openedpos(floor_num);
  closed_pos = self get_outer_closedpos(floor_num);

  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(left_opened_pos, closed_pos));
  moveTime = dist / speed;

  left_door moveTo(closed_pos, moveTime, moveTime * 0.1, moveTime * 0.25);
  right_door moveTo(closed_pos, moveTime, moveTime * 0.1, moveTime * 0.25);

  self waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
  self notify("closed_floor_" + floor_num + "_outer_doors");
}

open_outer_doors(floor_num) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + floor_num + "_outer_doors");
  self endon("opening_floor_" + floor_num + "_outer_doors");

  left_door = self get_outer_leftdoor(floor_num);
  right_door = self get_outer_rightdoor(floor_num);

  left_opened_pos = self get_outer_leftdoor_openedpos(floor_num);
  right_opened_pos = self get_outer_rightdoor_openedpos(floor_num);
  closed_pos = self get_outer_closedpos(floor_num);

  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(left_opened_pos, closed_pos));
  moveTime = (dist / speed) * 0.5;

  left_door moveTo(left_opened_pos, moveTime, moveTime * 0.1, moveTime * 0.25);
  right_door moveTo(right_opened_pos, moveTime, moveTime * 0.1, moveTime * 0.25);

  self waittill_finish_moving(left_door, left_opened_pos, right_door, right_opened_pos);
  self notify("opened_floor_" + floor_num + "_outer_doors");
}

build_elevators() {
  elevator_groups = getEntArray("elevator_group", "targetname");
  assertex(isDefined(elevator_groups) && (elevator_groups.size), "Radiant: Missing elevator bounding origins");

  elevator_housings = getEntArray("elevator_housing", "targetname");
  assertex(isDefined(elevator_housings) && (elevator_housings.size >= elevator_groups.size), "Fail! Missing the whole elevator, script_brushmodel with [targetname = elevator_housing] must be correctly placed");

  elevator_doorsets = getEntArray("elevator_doorset", "targetname");
  assertex(isDefined(elevator_doorsets) && (elevator_doorsets.size >= elevator_groups.size), "Radiant: Missing elevator door(s)");

  foreach(elevator_bound in elevator_groups) {
    elevator_bound_end = getent(elevator_bound.target, "targetname");

    min_max_xy = [];
    min_max_xy[0] = min(elevator_bound.origin[0], elevator_bound_end.origin[0]);
    min_max_xy[1] = max(elevator_bound.origin[0], elevator_bound_end.origin[0]);
    min_max_xy[2] = min(elevator_bound.origin[1], elevator_bound_end.origin[1]);
    min_max_xy[3] = max(elevator_bound.origin[1], elevator_bound_end.origin[1]);

    parts = spawnStruct();
    parts.e["id"] = level.elevators.size;

    parts.e["housing"] = [];
    parts.e["housing"]["mainframe"] = [];

    foreach(elevator_housing in elevator_housings) {
      if(elevator_housing isInbound(min_max_xy)) {
        parts.e["housing"]["mainframe"][parts.e["housing"]["mainframe"].size] = elevator_housing;

        if(elevator_housing.classname == "script_model") {
          continue;
        }

        if(elevator_housing.code_classname == "light") {
          continue;
        }

        inner_leftdoor = getent(elevator_housing.target, "targetname");
        parts.e["housing"]["left_door"] = inner_leftdoor;
        parts.e["housing"]["left_door_opened_pos"] = inner_leftdoor.origin;

        inner_rightdoor = getent(inner_leftdoor.target, "targetname");
        parts.e["housing"]["right_door"] = inner_rightdoor;
        parts.e["housing"]["right_door_opened_pos"] = inner_rightdoor.origin;

        inner_door_closed_pos = (inner_leftdoor.origin - inner_rightdoor.origin) * (0.5, 0.5, 0.5) + inner_rightdoor.origin;
        parts.e["housing"]["door_closed_pos"] = inner_door_closed_pos;

        door_trigger = getent(inner_rightdoor.target, "targetname");
        parts.e["housing"]["door_trigger"] = door_trigger;

        inside_trigger = getent(door_trigger.target, "targetname");
        parts.e["housing"]["inside_trigger"] = inside_trigger;
        inside_trigger make_discrete_trigger();

        inside_trigger.motion_trigger = spawn("trigger_radius", elevator_housing.origin, 0, 64, 128);
        assert(isDefined(inside_trigger.motion_trigger));
      }
    }
    assert(isDefined(parts.e["housing"]));

    parts.e["outer_doorset"] = [];
    foreach(elevator_doorset in elevator_doorsets) {
      if(elevator_doorset isInbound(min_max_xy)) {
        door_starts_closed = isDefined(elevator_doorset.script_noteworthy) && elevator_doorset.script_noteworthy == "closed_for_lighting";

        door_set_id = parts.e["outer_doorset"].size;

        parts.e["outer_doorset"][door_set_id] = [];
        parts.e["outer_doorset"][door_set_id]["door_closed_pos"] = elevator_doorset.origin;

        leftdoor = getent(elevator_doorset.target, "targetname");
        parts.e["outer_doorset"][door_set_id]["left_door"] = leftdoor;
        parts.e["outer_doorset"][door_set_id]["left_door_opened_pos"] = leftdoor.origin;

        rightdoor = getent(leftdoor.target, "targetname");
        parts.e["outer_doorset"][door_set_id]["right_door"] = rightdoor;
        parts.e["outer_doorset"][door_set_id]["right_door_opened_pos"] = rightdoor.origin;

        if(door_starts_closed) {
          left_door_vec = elevator_doorset.origin - leftdoor.origin;
          elevator_doorset.origin = leftdoor.origin;
          leftdoor.origin += left_door_vec;
          rightdoor.origin -= left_door_vec;
          parts.e["outer_doorset"][door_set_id]["door_closed_pos"] = elevator_doorset.origin;
          parts.e["outer_doorset"][door_set_id]["left_door_opened_pos"] = leftdoor.origin;
          parts.e["outer_doorset"][door_set_id]["right_door_opened_pos"] = rightdoor.origin;
        }
      }
    }
    assert(isDefined(parts.e["outer_doorset"]));

    for(i = 0; i < parts.e["outer_doorset"].size - 1; i++) {
      for(j = 0; j < parts.e["outer_doorset"].size - 1 - i; j++) {
        if(parts.e["outer_doorset"][j + 1]["door_closed_pos"][2] < parts.e["outer_doorset"][j]["door_closed_pos"][2]) {
          temp_left_door = parts.e["outer_doorset"][j]["left_door"];
          temp_left_door_opened_pos = parts.e["outer_doorset"][j]["left_door_opened_pos"];
          temp_right_door = parts.e["outer_doorset"][j]["right_door"];
          temp_right_door_opened_pos = parts.e["outer_doorset"][j]["right_door_opened_pos"];
          temp_closed_pos = parts.e["outer_doorset"][j]["door_closed_pos"];

          parts.e["outer_doorset"][j]["left_door"] = parts.e["outer_doorset"][j + 1]["left_door"];
          parts.e["outer_doorset"][j]["left_door_opened_pos"] = parts.e["outer_doorset"][j + 1]["left_door_opened_pos"];
          parts.e["outer_doorset"][j]["right_door"] = parts.e["outer_doorset"][j + 1]["right_door"];
          parts.e["outer_doorset"][j]["right_door_opened_pos"] = parts.e["outer_doorset"][j + 1]["right_door_opened_pos"];
          parts.e["outer_doorset"][j]["door_closed_pos"] = parts.e["outer_doorset"][j + 1]["door_closed_pos"];

          parts.e["outer_doorset"][j + 1]["left_door"] = temp_left_door;
          parts.e["outer_doorset"][j + 1]["left_door_opened_pos"] = temp_left_door_opened_pos;
          parts.e["outer_doorset"][j + 1]["right_door"] = temp_right_door;
          parts.e["outer_doorset"][j + 1]["right_door_opened_pos"] = temp_right_door_opened_pos;
          parts.e["outer_doorset"][j + 1]["door_closed_pos"] = temp_closed_pos;
        }
      }
    }

    floor_pos = [];
    foreach(i, doorset in parts.e["outer_doorset"]) {
      mainframe = parts get_housing_mainframe();

      floor_pos = (mainframe.origin[0], mainframe.origin[1], doorset["door_closed_pos"][2]);
      parts.e["floor" + i + "_pos"] = floor_pos;

      if(mainframe.origin == floor_pos) {
        parts.e["initial_floor"] = i;
        parts.e["current_floor"] = i;
      }
    }

    level.elevators[level.elevators.size] = parts;

    elevator_bound delete();
    elevator_bound_end delete();
  }
  foreach(elevator_doorset in elevator_doorsets) {
    elevator_doorset delete();
  }

  build_call_buttons();

  if(!level.elevator_motion_detection) {
    setup_hints();
  }

  foreach(elevator in level.elevators) {
    pLights = elevator get_housing_primarylight();
    if(isDefined(pLights) && pLights.size) {
      foreach(pLight in pLights) {
        pLight setlightintensity(0.75);
      }
    }
  }
}

build_call_buttons() {
  level.elevator_callbuttons = getEntArray("elevator_call", "targetname");
  assertex(isDefined(level.elevator_callbuttons) && (level.elevator_callbuttons.size > 1), "Missing or not enough elevator call buttons");

  foreach(callbutton in level.elevator_callbuttons) {
    callbutton.e = [];
    callbutton_v_vec = (0, 0, callbutton.origin[2]);
    callbutton_h_vec = (callbutton.origin[0], callbutton.origin[1], 0);

    temp_elevator_list = [];

    foreach(e_idx, elevator in level.elevators) {
      foreach(f_idx, eFloor in elevator get_outer_doorsets()) {
        v_vec = (0, 0, elevator.e["floor" + f_idx + "_pos"][2]);
        h_vec = (elevator.e["floor" + f_idx + "_pos"][0], elevator.e["floor" + f_idx + "_pos"][1], 0);

        if(abs(distance(callbutton_v_vec, v_vec)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(callbutton_h_vec, h_vec)) <= level.elevator_callbutton_link_h) {
            temp_elevator_list[temp_elevator_list.size] = elevator;
            callbutton.e[f_idx] = temp_elevator_list;
          }
        }
      }
    }
    callbutton make_discrete_trigger();
    assertex(isDefined(callbutton.e) && callbutton.e.size, "Elevator call button at " + callbutton.origin + " failed to grab near by elevators, placed too far?");

    callbutton.motion_trigger = spawn("trigger_radius", callbutton.origin + (0, 0, -32), 0, 32, 64);
  }
}

setup_hints() {
  foreach(elevator in level.elevators) {
    use_trig = elevator get_housing_inside_trigger();
    floors = elevator get_outer_doorsets();
    num_of_floors = floors.size;

    use_trig SetCursorHint("HINT_NOICON");
    if(num_of_floors > 2) {
      use_trig setHintString(&"ELEVATOR_FLOOR_SELECT_HINT");
    } else {
      use_trig setHintString(&"ELEVATOR_USE_HINT");
    }
  }

  foreach(callbutton in level.elevator_callbuttons) {
    callbutton SetCursorHint("HINT_NOICON");

    callbutton setHintString(&"ELEVATOR_CALL_HINT");
  }
}

make_discrete_trigger() {
  self.enabled = 1;
  self disable_trigger();
}

discrete_waittill(msg) {
  assert(isDefined(self.motion_trigger));

  self enable_trigger();

  if(level.elevator_motion_detection) {
    self.motion_trigger waittill(msg, param);
  } else {
    self waittill(msg, param);
  }

  self disable_trigger();
  return param;
}

enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin += (0, 0, 10000);

    if(isDefined(self.motion_trigger)) {
      self.motion_trigger.origin += (0, 0, 10000);
    }
  }
}

disable_trigger() {
  self notify("disable_trigger");
  if(self.enabled) {
    self thread disable_trigger_helper();
  }
}

disable_trigger_helper() {
  self endon("disable_trigger");
  self.enabled = 0;
  wait 1.5;
  self.origin += (0, 0, -10000);

  if(isDefined(self.motion_trigger)) {
    self.motion_trigger.origin += (0, 0, -10000);
  }
}

get_outer_doorset(floor_num) {
  return self.e["outer_doorset"][floor_num];
}

get_outer_doorsets() {
  return self.e["outer_doorset"];
}

get_outer_closedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["door_closed_pos"];
}

get_outer_leftdoor(floor_num) {
  return self.e["outer_doorset"][floor_num]["left_door"];
}

get_outer_rightdoor(floor_num) {
  return self.e["outer_doorset"][floor_num]["right_door"];
}

get_outer_leftdoor_openedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["left_door_opened_pos"];
}

get_outer_rightdoor_openedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["right_door_opened_pos"];
}

get_housing_children() {
  children = [];

  door_trig = self get_housing_door_trigger();
  use_trig = self get_housing_inside_trigger();
  motion_trig = use_trig.motion_trigger;
  left_door = self get_housing_leftdoor();
  right_door = self get_housing_rightdoor();

  children[children.size] = door_trig;
  children[children.size] = use_trig;
  children[children.size] = left_door;
  children[children.size] = right_door;

  if(isDefined(motion_trig)) {
    children[children.size] = motion_trig;
  }

  script_models = self get_housing_models();
  foreach(eModel in script_models) {
    children[children.size] = eModel;
  }

  primarylights = get_housing_primarylight();
  foreach(pLight in primarylights) {
    children[children.size] = pLight;
  }

  return children;
}

get_housing_mainframe() {
  parts = self.e["housing"]["mainframe"];

  housing_model = undefined;
  foreach(part in parts) {
    if(part.classname != "script_model" && part.code_classname != "light") {
      assertex(!isDefined(housing_model), "Fail! Found more than one elevator housing script_brushmodels per elevator");
      housing_model = part;
    }
  }
  assertex(isDefined(housing_model), "Epic fail! No elevator housing script_brushmodel found");
  return housing_model;
}

get_housing_models() {
  parts = self.e["housing"]["mainframe"];
  temp_model_array = [];

  foreach(part in parts) {
    if(part.classname == "script_model") {
      temp_model_array[temp_model_array.size] = part;
    }
  }
  return temp_model_array;
}

get_housing_primarylight() {
  parts = self.e["housing"]["mainframe"];
  temp_primarylights = [];

  foreach(part in parts) {
    if(part.code_classname == "light") {
      temp_primarylights[temp_primarylights.size] = part;
    }
  }
  return temp_primarylights;
}

get_housing_musak_model() {
  models = self get_housing_models();
  musak_model = undefined;

  foreach(eModel in models) {
    if(isDefined(eModel.script_noteworthy) && eModel.script_noteworthy == "play_musak") {
      musak_model = eModel;
    }
  }

  return musak_model;
}

get_housing_door_trigger() {
  return self.e["housing"]["door_trigger"];
}

get_housing_inside_trigger() {
  return self.e["housing"]["inside_trigger"];
}

get_housing_closedpos() {
  return self.e["housing"]["door_closed_pos"];
}

get_housing_leftdoor() {
  return self.e["housing"]["left_door"];
}

get_housing_rightdoor() {
  return self.e["housing"]["right_door"];
}

get_housing_leftdoor_opened_pos() {
  return self.e["housing"]["left_door_opened_pos"];
}

get_housing_rightdoor_opened_pos() {
  return self.e["housing"]["right_door_opened_pos"];
}

get_curFloor() {
  moving = self elevator_floor_update();
  return self.e["current_floor"];
}

get_initFloor() {
  return self.e["initial_floor"];
}

waittill_finish_moving(ent1, ent1_moveto_pos, ent2, ent2_moveto_pos) {
  if(!isDefined(ent2) && !isDefined(ent2_moveto_pos)) {
    ent2 = ent1;
    ent2_moveto_pos = ent1_moveto_pos;
  }

  while(1) {
    ent1_current_pos = ent1.origin;
    etn2_current_pos = ent2.origin;

    if(ent1_current_pos == ent1_moveto_pos && etn2_current_pos == ent2_moveto_pos) {
      break;
    }

    wait 0.05;
  }
}

isInbound(bounding_box) {
  assertex(isDefined(self) && isDefined(self.origin), "Fail! Can not test bounds with the entity called on");

  v_x = self.origin[0];
  v_y = self.origin[1];

  min_x = bounding_box[0];
  max_x = bounding_box[1];
  min_y = bounding_box[2];
  max_y = bounding_box[3];

  return (v_x >= min_x && v_x <= max_x && v_y >= min_y && v_y <= max_y);
}

isInBoundingSpere(bounding_box) {
  v_x = self.origin[0];
  v_y = self.origin[1];
  min_x = bounding_box[0];
  max_x = bounding_box[1];
  min_y = bounding_box[2];
  max_y = bounding_box[3];

  mid_x = (min_x + max_x) / 2;
  mid_y = (min_y + max_y) / 2;
  radius = abs(Distance((min_x, min_y, 0), (mid_x, mid_y, 0)));
  return (abs(distance((v_x, v_y, 0), (mid_x, mid_y, 0))) < radius);
}

waittill_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

elevator_get_dvar_int(dvar, def) {
  return int(elevator_get_dvar(dvar, def));
}

elevator_get_dvar(dvar, def) {
  if(getDvar(dvar) != "") {
    return getdvarfloat(dvar);
  } else {
    setDvar(dvar, def);
    return def;
  }
}

elevator_debug() {
  if(!level.elevator_debug) {
    return;
  }

  while(1) {
    if(level.elevator_debug != 2) {
      continue;
    }

    foreach(i, elevator in level.elevators) {
      mainframe = elevator get_housing_mainframe();
      musak_model = elevator get_housing_musak_model();

      print3d(musak_model.origin, "[e" + i + "]musak_origin", (0.75, 0.75, 1.0), 1, 0.25, 20);
      print3d(mainframe.origin, "[e" + i + "]mainframe", (0.75, 0.75, 1.0), 1, 0.25, 20);
      print3d(elevator.e["housing"]["left_door"].origin, "[e" + i + "]left door", (0.75, 0.75, 1.0), 1, 0.25, 20);
      print3d(elevator.e["housing"]["right_door"].origin, "[e" + i + "]right door", (0.75, 0.75, 1.0), 1, 0.25, 20);
      print3d(elevator.e["housing"]["door_closed_pos"], "[e" + i + "]->|<-", (0.75, 0.75, 1.0), 1, 0.25, 20);
      print3d(elevator.e["housing"]["inside_trigger"].origin, "[e" + i + "]USE", (0.75, 0.75, 1.0), 1, 0.25, 20);

      foreach(j, eFloor in elevator.e["outer_doorset"]) {
        print3d(eFloor["left_door"].origin + (0, 0, 8), "[e" + i + "][f" + j + "]left door", (0.75, 1.0, 0.75), 1, 0.25, 20);
        print3d(eFloor["right_door"].origin + (0, 0, 8), "[e" + i + "][f" + j + "]right door", (0.75, 1.0, 0.75), 1, 0.25, 20);
        print3d(eFloor["door_closed_pos"] + (0, 0, 8), "[e" + i + "][f" + j + "]->|<-", (0.75, 1.0, 0.75), 1, 0.25, 20);
        print3d(elevator.e["floor" + j + "_pos"] + (0, 0, 8), "[e" + i + "][f" + j + "]stop", (1.0, 0.75, 0.75), 1, 0.25, 20);
      }
    }

    foreach(callbutton in level.elevator_callbuttons) {
      print3d(callbutton.origin, "linked to:", (0.75, 0.75, 1.0), 1, 0.25, 20);

      foreach(f_idx, eFloor in callbutton.e) {
        printoffset = 0;
        foreach(e_idx, eLinked in eFloor) {
          printoffset++;

          print_pos = callbutton.origin + (0, 0, (printoffset) * (-4));
          print3d(print_pos, "[f" + f_idx + "][e" + eLinked.e["id"] + "]", (0.75, 0.75, 1.0), 1, 0.25, 20);
        }
      }
    }

    wait 0.05;
  }
}