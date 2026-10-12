/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\elevator.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace elevator;

function init() {
  if(getDvar(@ "hash_74714610a987a982") == "1") {
    return;
  }

  elevator_groups = getEntArray("elevator_group", "targetname");

  if(!isDefined(elevator_groups)) {
    return;
  }

  if(!elevator_groups.size) {
    return;
  }

  precachestring(&"ELEVATOR_CALL_HINT");
  precachestring(&"ELEVATOR_USE_HINT");
  precachestring(&"ELEVATOR_FLOOR_SELECT_HINT");
  thread elevator_update_global_dvars();
  level.elevators = [];
  level.elevator_callbutton_link_v = elevator_get_dvar_int(@ "hash_64b9a07b582553fa", "96");
  level.elevator_callbutton_link_h = elevator_get_dvar_int(@ "hash_64b9827b58251200", "256");
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

function elevator_update_global_dvars() {
  while(true) {
    level.elevator_accel = elevator_get_dvar(@ "hash_f32e7148016d2756", "0.2");
    level.elevator_decel = elevator_get_dvar(@ "hash_da5b272234cd0d73", "0.2");
    level.elevator_music = elevator_get_dvar_int(@ "hash_87b3871ebe6fc289", "1");
    level.elevator_speed = elevator_get_dvar_int(@ "hash_42374da9d25c0c8d", "96");
    level.elevator_innerdoorspeed = elevator_get_dvar_int(@ "hash_244b021e435ed089", "14");
    level.elevator_outterdoorspeed = elevator_get_dvar_int(@ "hash_b4be805451b81b50", "16");
    level.elevator_return = elevator_get_dvar_int(@ "hash_a2d058994e722a4", "0");
    level.elevator_waittime = elevator_get_dvar_int(@ "hash_6d3dbdefd394cade", "6");
    level.elevator_aggressive_call = elevator_get_dvar_int(@ "hash_59e9d8f59b714057", "0");
    level.elevator_debug = elevator_get_dvar_int(@ "debug_elevator", "0");

    if(utility::issp()) {
      level.elevator_motion_detection = elevator_get_dvar_int(@ "hash_2f42511a40542c14", "0");
    } else {
      level.elevator_motion_detection = elevator_get_dvar_int(@ "hash_2f42511a40542c14", "1");
    }

    wait 1;
  }
}

function elevator_think() {
  elevator_fsm("[A]");
}

function elevator_call() {
  foreach(callbutton in level.elevator_callbuttons) {
    callbutton thread monitor_callbutton();
  }
}

function floor_override(inside_trig) {
  self endon("elevator_moving");
  self.floor_override = 0;
  self.overrider = undefined;

  while(true) {
    inside_trig waittill("trigger", player);
    self.floor_override = 1;
    self.overrider = player;
    break;
  }

  self notify("floor_override");
}

function elevator_fsm(state) {
  self.estate = state;
  door_trig = get_housing_door_trigger();
  inside_trig = get_housing_inside_trigger();

  while(true) {
    if(self.estate == "[A]") {
      if(level.elevator_return && get_curfloor() != get_initfloor()) {
        self.moveto_floor = get_initfloor();
        thread floor_override(inside_trig);
        waittill_or_timeout("floor_override", level.elevator_waittime);

        if(self.floor_override && isDefined(self.overrider) && isPlayer(self.overrider)) {
          get_floor(self.overrider);
        }

        self.estate = "[B]";
        continue;
      }

      while(true) {
        if(self.moveto_floor == get_curfloor()) {
          param = inside_trig discrete_waittill("trigger");
        } else {
          param = "elevator_called";
        }

        if(isstring(param) && param == "elevator_called" && self.moveto_floor != get_curfloor()) {
          self.estate = "[B]";
          break;
        }

        if(isDefined(param) && isPlayer(param) && isalive(param)) {
          istouching_trigger = param istouching(inside_trig);
          var_ba5566b3bf32ba20 = isDefined(inside_trig.motion_trigger) && param istouching(inside_trig.motion_trigger);
          var_fab9923d97d18fef = istouching_trigger || var_ba5566b3bf32ba20;

          if(var_fab9923d97d18fef) {
            player = param;
            get_floor(player);

            if(self.moveto_floor == get_curfloor()) {
              continue;
            }

            self.estate = "[B]";
            break;
          }
        }
      }
    }

    if(self.estate == "[B]") {
      thread elevator_interrupt(door_trig);
      floor_num = get_curfloor();
      thread close_inner_doors();
      thread close_outer_doors(floor_num);
      waittill_any_2("closed_inner_doors", "interrupted");

      if(self.elevator_interrupted) {
        self.estate = "[C]";
        continue;
      }

      self.estate = "[D]";
      continue;
    }

    if(self.estate == "[C]") {
      floor_num = get_curfloor();
      thread open_inner_doors();
      thread open_outer_doors(floor_num);
      self waittill("opened_floor_" + floor_num + "_outer_doors");

      if(self.elevator_interrupted) {
        self.estate = "[B]";
        continue;
      }

      self.estate = "[A]";
      continue;
    }

    if(self.estate == "[D]") {
      assertex(isDefined(self.moveto_floor), "Missing destination floor number");

      if(self.moveto_floor != get_curfloor()) {
        thread elevator_move(self.moveto_floor);
        self waittill("elevator_moved");
      }

      self.estate = "[C]";
      continue;
    }
  }
}

function monitor_callbutton() {
  while(true) {
    player = discrete_waittill("trigger");
    call_floor = undefined;
    call_elevators = [];

    foreach(linked_elevators in self.e) {
      call_floor = idx;
      call_elevators = linked_elevators;
    }

    assert(isDefined(call_floor) && isDefined(call_elevators) && call_elevators.size);
    elevator_called = 0;

    foreach(elevator in call_elevators) {
      moving = elevator elevator_floor_update();

      if(!level.elevator_aggressive_call && !moving) {
        if(elevator get_curfloor() == call_floor) {
          elevator_called = 1;
          call_elevators = [];
          break;
        }
      }
    }

    foreach(elevator in call_elevators) {
      if(elevator.estate == "[A]") {
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

function call_elevator(call_floor) {
  self.moveto_floor = call_floor;
  inside_trigger = get_housing_inside_trigger();
  inside_trigger notify("trigger", "elevator_called");

  if(level.elevator_motion_detection) {
    inside_trigger.motion_trigger notify("trigger", "elevator_called");
  }
}

function get_floor(player) {
  bifloor = get_outer_doorsets();

  if(bifloor.size == 2) {
    curfloor = get_curfloor();
    self.moveto_floor = !curfloor;
    return;
  }

  player setclientdvar(@ "hash_1cdbc3f4c0889e48", get_curfloor());

  while(true) {
    player waittill("menuresponse", menu, response);

    if(menu == "elevator_floor_selector") {
      if(response != "none") {
        self.moveto_floor = int(response);
      }

      break;
    }
  }
}

function elevator_interrupt(door_trig) {
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

function elevator_floor_update() {
  mainframe = get_housing_mainframe();
  cur_pos = mainframe.origin;
  moving = 1;

  foreach(idx, efloor in get_outer_doorsets()) {
    floor_pos = self.e["floor" + idx + "_pos"];

    if(cur_pos == floor_pos) {
      self.e["current_floor"] = idx;
      moving = 0;
    }
  }

  return moving;
}

function elevator_sound_think() {
  musak_model = get_housing_musak_model();

  if(level.elevator_music && isDefined(musak_model)) {
    musak_model playLoopSound("elev_musak_loop");
  }

  thread listen_for("closing_inner_doors");
  thread listen_for("opening_inner_doors");
  thread listen_for("closed_inner_doors");
  thread listen_for("opened_inner_doors");

  foreach(idx, efloor in get_outer_doorsets()) {
    thread listen_for("closing_floor_" + idx + "_outer_doors");
    thread listen_for("opening_floor_" + idx + "_outer_doors");
    thread listen_for("closed_floor_" + idx + "_outer_doors");
    thread listen_for("opened_floor_" + idx + "_outer_doors");
  }

  thread listen_for("interrupted");
  thread listen_for("elevator_moving");
  thread listen_for("elevator_moved");
}

function listen_for(msg) {
  while(true) {
    self waittill(msg);
    mainframe = get_housing_mainframe();

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

function position_elevators() {
  foreach(elevator in level.elevators) {
    elevator.moveto_floor = elevator get_curfloor();

    foreach(floor_num, outer_doorset in elevator get_outer_doorsets()) {
      if(elevator get_curfloor() != floor_num) {
        elevator thread close_outer_doors(floor_num);
      }
    }
  }
}

function elevator_move(floor_num) {
  self notify("elevator_moving");
  self endon("elevator_moving");
  mainframe = get_housing_mainframe();
  delta_vec = self.e["floor" + floor_num + "_pos"] - mainframe.origin;
  speed = level.elevator_speed;
  dist = abs(distance(self.e["floor" + floor_num + "_pos"], mainframe.origin));
  movetime = dist / speed;
  mainframe moveTo(mainframe.origin + delta_vec, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);

  foreach(part in get_housing_children()) {
    moveto_pos = part.origin + delta_vec;

    if(!issubstr(part.classname, "trigger_")) {
      part moveTo(moveto_pos, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);
      continue;
    }

    part.origin = moveto_pos;
  }

  waittill_finish_moving(mainframe, self.e["floor" + floor_num + "_pos"]);
  self notify("elevator_moved");
}

function close_inner_doors() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");
  left_door = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  mainframe = get_housing_mainframe();
  var_d73b15f6c837cf86 = get_housing_closedpos();
  closed_pos = (var_d73b15f6c837cf86[0], var_d73b15f6c837cf86[1], mainframe.origin[2]);
  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(left_door.origin, closed_pos));
  movetime = dist / speed;
  left_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
  self notify("closed_inner_doors");
}

function open_inner_doors() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");
  left_door = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  mainframe = get_housing_mainframe();
  var_e389930453448aa3 = get_housing_leftdoor_opened_pos();
  var_5a488a3500727ba4 = get_housing_rightdoor_opened_pos();
  var_77dd329a87b4e69d = (var_e389930453448aa3[0], var_e389930453448aa3[1], mainframe.origin[2]);
  var_a4a379d93e5f8616 = (var_5a488a3500727ba4[0], var_5a488a3500727ba4[1], mainframe.origin[2]);
  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(var_77dd329a87b4e69d, var_a4a379d93e5f8616) * 0.5);
  movetime = dist / speed * 0.5;
  left_door moveTo(var_77dd329a87b4e69d, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(var_a4a379d93e5f8616, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, var_77dd329a87b4e69d, right_door, var_a4a379d93e5f8616);
  self notify("opened_inner_doors");
}

function close_outer_doors(floor_num) {
  self notify("closing_floor_" + floor_num + "_outer_doors");
  self endon("closing_floor_" + floor_num + "_outer_doors");
  self endon("opening_floor_" + floor_num + "_outer_doors");
  left_door = get_outer_leftdoor(floor_num);
  right_door = get_outer_rightdoor(floor_num);
  var_77dd329a87b4e69d = get_outer_leftdoor_openedpos(floor_num);
  closed_pos = get_outer_closedpos(floor_num);
  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(var_77dd329a87b4e69d, closed_pos));
  movetime = dist / speed;
  left_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, closed_pos, right_door, closed_pos);
  self notify("closed_floor_" + floor_num + "_outer_doors");
}

function open_outer_doors(floor_num) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + floor_num + "_outer_doors");
  self endon("opening_floor_" + floor_num + "_outer_doors");
  left_door = get_outer_leftdoor(floor_num);
  right_door = get_outer_rightdoor(floor_num);
  var_77dd329a87b4e69d = get_outer_leftdoor_openedpos(floor_num);
  var_a4a379d93e5f8616 = get_outer_rightdoor_openedpos(floor_num);
  closed_pos = get_outer_closedpos(floor_num);
  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(var_77dd329a87b4e69d, closed_pos));
  movetime = dist / speed * 0.5;
  left_door moveTo(var_77dd329a87b4e69d, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(var_a4a379d93e5f8616, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(left_door, var_77dd329a87b4e69d, right_door, var_a4a379d93e5f8616);
  self notify("opened_floor_" + floor_num + "_outer_doors");
}

function build_elevators() {
  elevator_groups = getEntArray("elevator_group", "targetname");
  assertex(isDefined(elevator_groups) && elevator_groups.size, "Radiant: Missing elevator bounding origins");
  var_20aa4eadbc86b00 = getEntArray("elevator_housing", "targetname");
  assertex(isDefined(var_20aa4eadbc86b00) && var_20aa4eadbc86b00.size >= elevator_groups.size, "Fail! Missing the whole elevator, script_brushmodel with [targetname = elevator_housing] must be correctly placed");
  elevator_doorsets = getEntArray("elevator_doorset", "targetname");
  assertex(isDefined(elevator_doorsets) && elevator_doorsets.size >= elevator_groups.size, "Radiant: Missing elevator door(s)");

  foreach(elevator_bound in elevator_groups) {
    var_57dff06718226286 = getEnt(elevator_bound.target, "targetname");
    var_4195778095aaca54 = [];
    var_4195778095aaca54[0] = min(elevator_bound.origin[0], var_57dff06718226286.origin[0]);
    var_4195778095aaca54[1] = max(elevator_bound.origin[0], var_57dff06718226286.origin[0]);
    var_4195778095aaca54[2] = min(elevator_bound.origin[1], var_57dff06718226286.origin[1]);
    var_4195778095aaca54[3] = max(elevator_bound.origin[1], var_57dff06718226286.origin[1]);
    parts = spawnStruct();
    parts.e["id"] = level.elevators.size;
    parts.e["housing"] = [];
    parts.e["housing"]["mainframe"] = [];

    foreach(elevator_housing in var_20aa4eadbc86b00) {
      if(elevator_housing isinbound(var_4195778095aaca54)) {
        parts.e["housing"]["mainframe"][parts.e["housing"]["mainframe"].size] = elevator_housing;

        if(elevator_housing.classname == "script_model") {
          continue;
        }

        if(elevator_housing.code_classname == "light") {
          continue;
        }

        inner_leftdoor = getEnt(elevator_housing.target, "targetname");
        parts.e["housing"]["left_door"] = inner_leftdoor;
        parts.e["housing"]["left_door_opened_pos"] = inner_leftdoor.origin;
        inner_rightdoor = getEnt(inner_leftdoor.target, "targetname");
        parts.e["housing"]["right_door"] = inner_rightdoor;
        parts.e["housing"]["right_door_opened_pos"] = inner_rightdoor.origin;
        var_701670bfd9f3bf8 = (inner_leftdoor.origin - inner_rightdoor.origin) * (0.5, 0.5, 0.5) + inner_rightdoor.origin;
        parts.e["housing"]["door_closed_pos"] = var_701670bfd9f3bf8;
        door_trigger = getEnt(inner_rightdoor.target, "targetname");
        parts.e["housing"]["door_trigger"] = door_trigger;
        inside_trigger = getEnt(door_trigger.target, "targetname");
        parts.e["housing"]["inside_trigger"] = inside_trigger;
        inside_trigger make_discrete_trigger();
        inside_trigger.motion_trigger = spawn("trigger_radius", elevator_housing.origin, 0, 64, 128);
        assert(isDefined(inside_trigger.motion_trigger));
      }
    }

    assert(isDefined(parts.e["housing"]));
    parts.e["outer_doorset"] = [];

    foreach(elevator_doorset in elevator_doorsets) {
      if(elevator_doorset isinbound(var_4195778095aaca54)) {
        var_d1c3449bfb5c7cd0 = isDefined(elevator_doorset.script_noteworthy) && elevator_doorset.script_noteworthy == "closed_for_lighting";
        var_f6a5cf1c5d09a6fe = parts.e["outer_doorset"].size;
        parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe] = [];
        parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["door_closed_pos"] = elevator_doorset.origin;
        leftdoor = getEnt(elevator_doorset.target, "targetname");
        parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["left_door"] = leftdoor;
        parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["left_door_opened_pos"] = leftdoor.origin;
        rightdoor = getEnt(leftdoor.target, "targetname");
        parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["right_door"] = rightdoor;
        parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["right_door_opened_pos"] = rightdoor.origin;

        if(var_d1c3449bfb5c7cd0) {
          var_acd175a84b61485c = elevator_doorset.origin - leftdoor.origin;
          elevator_doorset.origin = leftdoor.origin;
          leftdoor.origin += var_acd175a84b61485c;
          rightdoor.origin -= var_acd175a84b61485c;
          parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["door_closed_pos"] = elevator_doorset.origin;
          parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["left_door_opened_pos"] = leftdoor.origin;
          parts.e["outer_doorset"][var_f6a5cf1c5d09a6fe]["right_door_opened_pos"] = rightdoor.origin;
        }
      }
    }

    assert(isDefined(parts.e["outer_doorset"]));

    for(i = 0; i < parts.e["outer_doorset"].size - 1; i++) {
      for(j = 0; j < parts.e["outer_doorset"].size - 1 - i; j++) {
        if(parts.e["outer_doorset"][j + 1]["door_closed_pos"][2] < parts.e["outer_doorset"][j]["door_closed_pos"][2]) {
          var_7f2dad6015bc0d0a = parts.e["outer_doorset"][j]["left_door"];
          var_3059a59b44b17477 = parts.e["outer_doorset"][j]["left_door_opened_pos"];
          var_c04c69a2100cd59b = parts.e["outer_doorset"][j]["right_door"];
          var_fdfb0da61e43818c = parts.e["outer_doorset"][j]["right_door_opened_pos"];
          var_cf422d8bea6d8fdd = parts.e["outer_doorset"][j]["door_closed_pos"];
          parts.e["outer_doorset"][j]["left_door"] = parts.e["outer_doorset"][j + 1]["left_door"];
          parts.e["outer_doorset"][j]["left_door_opened_pos"] = parts.e["outer_doorset"][j + 1]["left_door_opened_pos"];
          parts.e["outer_doorset"][j]["right_door"] = parts.e["outer_doorset"][j + 1]["right_door"];
          parts.e["outer_doorset"][j]["right_door_opened_pos"] = parts.e["outer_doorset"][j + 1]["right_door_opened_pos"];
          parts.e["outer_doorset"][j]["door_closed_pos"] = parts.e["outer_doorset"][j + 1]["door_closed_pos"];
          parts.e["outer_doorset"][j + 1]["left_door"] = var_7f2dad6015bc0d0a;
          parts.e["outer_doorset"][j + 1]["left_door_opened_pos"] = var_3059a59b44b17477;
          parts.e["outer_doorset"][j + 1]["right_door"] = var_c04c69a2100cd59b;
          parts.e["outer_doorset"][j + 1]["right_door_opened_pos"] = var_fdfb0da61e43818c;
          parts.e["outer_doorset"][j + 1]["door_closed_pos"] = var_cf422d8bea6d8fdd;
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
    var_57dff06718226286 delete();
  }

  foreach(elevator_doorset in elevator_doorsets) {
    elevator_doorset delete();
  }

  build_call_buttons();

  if(!level.elevator_motion_detection) {
    setup_hints();
  }

  foreach(elevator in level.elevators) {
    plights = elevator get_housing_primarylight();

    if(isDefined(plights) && plights.size) {
      foreach(plight in plights) {
        plight setlightintensity(0.75);
      }
    }
  }
}

function build_call_buttons() {
  level.elevator_callbuttons = getEntArray("elevator_call", "targetname");
  assertex(isDefined(level.elevator_callbuttons) && level.elevator_callbuttons.size > 1, "Missing or not enough elevator call buttons");

  foreach(callbutton in level.elevator_callbuttons) {
    callbutton.e = [];
    var_7c9bd32185a94469 = (0, 0, callbutton.origin[2]);
    var_84a9e27d3f377cdf = (callbutton.origin[0], callbutton.origin[1], 0);
    var_c0fc917aaed1b9bb = [];

    foreach(elevator in level.elevators) {
      foreach(f_idx, efloor in elevator get_outer_doorsets()) {
        v_vec = (0, 0, elevator.e["floor" + f_idx + "_pos"][2]);
        h_vec = (elevator.e["floor" + f_idx + "_pos"][0], elevator.e["floor" + f_idx + "_pos"][1], 0);

        if(abs(distance(var_7c9bd32185a94469, v_vec)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(var_84a9e27d3f377cdf, h_vec)) <= level.elevator_callbutton_link_h) {
            var_c0fc917aaed1b9bb[var_c0fc917aaed1b9bb.size] = elevator;
            callbutton.e[f_idx] = var_c0fc917aaed1b9bb;
          }
        }
      }
    }

    callbutton make_discrete_trigger();
    assertex(isDefined(callbutton.e) && callbutton.e.size, "Elevator call button at " + callbutton.origin + " failed to grab near by elevators, placed too far?");
    callbutton.motion_trigger = spawn("trigger_radius", callbutton.origin + (0, 0, -32), 0, 32, 64);
  }
}

function setup_hints() {
  foreach(elevator in level.elevators) {
    use_trig = elevator get_housing_inside_trigger();
    floors = elevator get_outer_doorsets();
    var_de5f949cf6389975 = floors.size;
    use_trig setCursorHint("HINT_NOICON");

    if(var_de5f949cf6389975 > 2) {
      use_trig setHintString(&"ELEVATOR_FLOOR_SELECT_HINT");
      continue;
    }

    use_trig setHintString(&"ELEVATOR_USE_HINT");
  }

  foreach(callbutton in level.elevator_callbuttons) {
    callbutton setCursorHint("HINT_NOICON");
    callbutton setHintString(&"ELEVATOR_CALL_HINT");
  }
}

function make_discrete_trigger() {
  self.enabled = 1;
  disable_trigger();
}

function discrete_waittill(msg) {
  assert(isDefined(self.motion_trigger));
  enable_trigger();

  if(level.elevator_motion_detection) {
    self.motion_trigger waittill(msg, param);
  } else {
    self waittill(msg, param);
  }

  disable_trigger();
  return param;
}

function enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin += (0, 0, 10000);

    if(isDefined(self.motion_trigger)) {
      self.motion_trigger.origin += (0, 0, 10000);
    }
  }
}

function disable_trigger() {
  self notify("disable_trigger");

  if(self.enabled) {
    thread disable_trigger_helper();
  }
}

function disable_trigger_helper() {
  self endon("disable_trigger");
  self.enabled = 0;
  wait 1.5;
  self.origin += (0, 0, -10000);

  if(isDefined(self.motion_trigger)) {
    self.motion_trigger.origin += (0, 0, -10000);
  }
}

function get_outer_doorset(floor_num) {
  return self.e["outer_doorset"][floor_num];
}

function get_outer_doorsets() {
  return self.e["outer_doorset"];
}

function get_outer_closedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["door_closed_pos"];
}

function get_outer_leftdoor(floor_num) {
  return self.e["outer_doorset"][floor_num]["left_door"];
}

function get_outer_rightdoor(floor_num) {
  return self.e["outer_doorset"][floor_num]["right_door"];
}

function get_outer_leftdoor_openedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["left_door_opened_pos"];
}

function get_outer_rightdoor_openedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["right_door_opened_pos"];
}

function get_housing_children() {
  children = [];
  door_trig = get_housing_door_trigger();
  use_trig = get_housing_inside_trigger();
  motion_trig = use_trig.motion_trigger;
  left_door = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  children[children.size] = door_trig;
  children[children.size] = use_trig;
  children[children.size] = left_door;
  children[children.size] = right_door;

  if(isDefined(motion_trig)) {
    children[children.size] = motion_trig;
  }

  script_models = get_housing_models();

  foreach(emodel in script_models) {
    children[children.size] = emodel;
  }

  primarylights = get_housing_primarylight();

  foreach(plight in primarylights) {
    children[children.size] = plight;
  }

  return children;
}

function get_housing_mainframe() {
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

function get_housing_models() {
  parts = self.e["housing"]["mainframe"];
  var_212f549bb87dc0e3 = [];

  foreach(part in parts) {
    if(part.classname == "script_model") {
      var_212f549bb87dc0e3[var_212f549bb87dc0e3.size] = part;
    }
  }

  return var_212f549bb87dc0e3;
}

function get_housing_primarylight() {
  parts = self.e["housing"]["mainframe"];
  temp_primarylights = [];

  foreach(part in parts) {
    if(part.code_classname == "light") {
      temp_primarylights[temp_primarylights.size] = part;
    }
  }

  return temp_primarylights;
}

function get_housing_musak_model() {
  models = get_housing_models();
  musak_model = undefined;

  foreach(emodel in models) {
    if(isDefined(emodel.script_noteworthy) && emodel.script_noteworthy == "play_musak") {
      musak_model = emodel;
    }
  }

  return musak_model;
}

function get_housing_door_trigger() {
  return self.e["housing"]["door_trigger"];
}

function get_housing_inside_trigger() {
  return self.e["housing"]["inside_trigger"];
}

function get_housing_closedpos() {
  return self.e["housing"]["door_closed_pos"];
}

function get_housing_leftdoor() {
  return self.e["housing"]["left_door"];
}

function get_housing_rightdoor() {
  return self.e["housing"]["right_door"];
}

function get_housing_leftdoor_opened_pos() {
  return self.e["housing"]["left_door_opened_pos"];
}

function get_housing_rightdoor_opened_pos() {
  return self.e["housing"]["right_door_opened_pos"];
}

function get_curfloor() {
  moving = elevator_floor_update();
  return self.e["current_floor"];
}

function get_initfloor() {
  return self.e["initial_floor"];
}

function waittill_finish_moving(ent1, var_e46b13ef3f8c9dcb, ent2, var_4ed727c032053180) {
  if(!isDefined(ent2) && !isDefined(var_4ed727c032053180)) {
    ent2 = ent1;
    var_4ed727c032053180 = var_e46b13ef3f8c9dcb;
  }

  while(true) {
    var_af7bfec8a5f57692 = ent1.origin;
    var_24312405e5d18857 = ent2.origin;

    if(var_af7bfec8a5f57692 == var_e46b13ef3f8c9dcb && var_24312405e5d18857 == var_4ed727c032053180) {
      break;
    }

    wait 0.05;
  }
}

function isinbound(bounding_box) {
  assertex(isDefined(self) && isDefined(self.origin), "Fail! Can not test bounds with the entity called on");
  v_x = self.origin[0];
  v_y = self.origin[1];
  min_x = bounding_box[0];
  max_x = bounding_box[1];
  min_y = bounding_box[2];
  max_y = bounding_box[3];
  return v_x >= min_x && v_x <= max_x && v_y >= min_y && v_y <= max_y;
}

function isinboundingspere(bounding_box) {
  v_x = self.origin[0];
  v_y = self.origin[1];
  min_x = bounding_box[0];
  max_x = bounding_box[1];
  min_y = bounding_box[2];
  max_y = bounding_box[3];
  mid_x = (min_x + max_x) / 2;
  mid_y = (min_y + max_y) / 2;
  radius = abs(distance((min_x, min_y, 0), (mid_x, mid_y, 0)));
  return abs(distance((v_x, v_y, 0), (mid_x, mid_y, 0))) < radius;
}

function waittill_or_timeout(msg, timer) {
  self endon(msg);
  wait timer;
}

function elevator_get_dvar_int(dvar, def) {
  return int(elevator_get_dvar(dvar, def));
}

function elevator_get_dvar(dvar, def) {
  if(getDvar(dvar) != "") {
    return getdvarfloat(dvar);
  }

  setDvar(dvar, def);
  return def;
}

function elevator_debug() {
  if(!level.elevator_debug) {
    return;
  }

  while(true) {
    if(level.elevator_debug != 2) {
      continue;
    }

    foreach(i, elevator in level.elevators) {
      mainframe = elevator get_housing_mainframe();
      musak_model = elevator get_housing_musak_model();

      print3d(musak_model.origin, "<dev string:x1c>" + i + "<dev string:x1f>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(mainframe.origin, "<dev string:x1c>" + i + "<dev string:x2d>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x38>"]["<dev string:x40>"].origin, "<dev string:x1c>" + i + "<dev string:x4a>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x38>"]["<dev string:x55>"].origin, "<dev string:x1c>" + i + "<dev string:x60>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x38>"]["<dev string:x6c>"], "<dev string:x1c>" + i + "<dev string:x7c>", (0.75, 0.75, 1), 1, 0.25, 20);

      print3d(elevator.e["<dev string:x38>"]["<dev string:x83>"].origin, "<dev string:x1c>" + i + "<dev string:x92>", (0.75, 0.75, 1), 1, 0.25, 20);

      foreach(j, efloor in elevator.e["outer_doorset"]) {
        print3d(efloor["<dev string:x40>"].origin + (0, 0, 8), "<dev string:x1c>" + i + "<dev string:x97>" + j + "<dev string:x4a>", (0.75, 1, 0.75), 1, 0.25, 20);

        print3d(efloor["<dev string:x55>"].origin + (0, 0, 8), "<dev string:x1c>" + i + "<dev string:x97>" + j + "<dev string:x60>", (0.75, 1, 0.75), 1, 0.25, 20);

        print3d(efloor["<dev string:x6c>"] + (0, 0, 8), "<dev string:x1c>" + i + "<dev string:x97>" + j + "<dev string:x7c>", (0.75, 1, 0.75), 1, 0.25, 20);

        print3d(elevator.e["<dev string:x9b>" + j + "<dev string:xa1>"] + (0, 0, 8), "<dev string:x1c>" + i + "<dev string:x97>" + j + "<dev string:xa6>", (1, 0.75, 0.75), 1, 0.25, 20);
      }
    }

    foreach(callbutton in level.elevator_callbuttons) {
      print3d(callbutton.origin, "<dev string:xac>", (0.75, 0.75, 1), 1, 0.25, 20);

      foreach(efloor in callbutton.e) {
        printoffset = 0;

        foreach(elinked in efloor) {
          printoffset++;
          print_pos = callbutton.origin + (0, 0, printoffset * -4);

          print3d(print_pos, "<dev string:xb7>" + f_idx + "<dev string:xba>" + elinked.e["<dev string:xbe>"] + "<dev string:xc1>", (0.75, 0.75, 1), 1, 0.25, 20);
        }
      }
    }

    wait 0.05;
  }
}

function function_d9d18dab18ebded(movingplatforment) {
  if(!isDefined(movingplatforment)) {
    return false;
  }

  if(isDefined(level.elevators)) {
    foreach(elevatorstruct in level.elevators) {
      if(!isDefined(elevatorstruct.car)) {
        continue;
      }

      if(elevatorstruct.car == movingplatforment) {
        return true;
      }
    }
  }

  return false;
}