/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\common\elevator.gsc
***************************************/

init() {
  if(getdvar("scr_elevator_disabled") == "1") {
    return;
  }

  var_00 = getEntArray("elevator_group", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  if(!var_00.size) {
    return;
  }

  precachestring(&"ELEVATOR_CALL_HINT");
  precachestring(&"ELEVATOR_USE_HINT");
  precachestring(&"ELEVATOR_FLOOR_SELECT_HINT");
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

  foreach(var_02 in level.elevators) {
    var_02 thread elevator_think();
    var_02 thread elevator_sound_think();
  }

  thread elevator_debug();
}

elevator_update_global_dvars() {
  for(;;) {
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
    if(scripts\engine\utility::issp()) {
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "0");
    } else {
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "1");
    }

    wait(1);
  }
}

elevator_think() {
  elevator_fsm("[A]");
}

elevator_call() {
  foreach(var_01 in level.elevator_callbuttons) {
    var_01 thread monitor_callbutton();
  }
}

floor_override(param_00) {
  self endon("elevator_moving");
  self.floor_override = 0;
  self.overrider = undefined;
  for(;;) {
    param_00 waittill("trigger", var_01);
    self.floor_override = 1;
    self.overrider = var_01;
    break;
  }

  self notify("floor_override");
}

elevator_fsm(param_00) {
  self.estate = param_00;
  var_01 = get_housing_door_trigger();
  var_02 = get_housing_inside_trigger();
  for(;;) {
    if(self.estate == "[A]") {
      if(level.elevator_return && get_curfloor() != get_initfloor()) {
        self.moveto_floor = get_initfloor();
        thread floor_override(var_02);
        waittill_or_timeout("floor_override", level.elevator_waittime);
        if(self.floor_override && isDefined(self.overrider) && isplayer(self.overrider)) {
          get_floor(self.overrider);
        }

        self.estate = "[B]";
        continue;
      }

      for(;;) {
        if(self.moveto_floor == get_curfloor()) {
          var_03 = var_02 discrete_waittill("trigger");
        } else {
          var_03 = "elevator_called";
        }

        if(isstring(var_03) && var_03 == "elevator_called" && self.moveto_floor != get_curfloor()) {
          self.estate = "[B]";
          break;
        }

        if(isDefined(var_03) && isplayer(var_03) && isalive(var_03)) {
          var_04 = var_03 istouching(var_02);
          var_05 = isDefined(var_02.motion_trigger) && var_03 istouching(var_02.motion_trigger);
          var_06 = var_04 || var_05;
          if(var_06) {
            var_07 = var_03;
            get_floor(var_07);
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
      thread elevator_interrupt(var_01);
      var_08 = get_curfloor();
      thread close_inner_doors();
      thread close_outer_doors(var_08);
      scripts\engine\utility::waittill_any_3("closed_inner_doors", "interrupted");
      if(self.elevator_interrupted) {
        self.estate = "[C]";
        continue;
      }

      self.estate = "[D]";
      continue;
    }

    if(self.estate == "[C]") {
      var_08 = get_curfloor();
      thread open_inner_doors();
      thread open_outer_doors(var_08);
      self waittill("opened_floor_" + var_08 + "_outer_doors");
      if(self.elevator_interrupted) {
        self.estate = "[B]";
        continue;
      }

      self.estate = "[A]";
      continue;
    }

    if(self.estate == "[D]") {
      if(self.moveto_floor != get_curfloor()) {
        thread elevator_move(self.moveto_floor);
        self waittill("elevator_moved");
      }

      self.estate = "[C]";
      continue;
    }
  }
}

monitor_callbutton() {
  for(;;) {
    var_00 = discrete_waittill("trigger");
    var_01 = undefined;
    var_02 = [];
    foreach(var_05, var_04 in self.e) {
      var_01 = var_05;
      var_02 = var_04;
    }

    var_06 = 0;
    foreach(var_08 in var_02) {
      var_09 = var_08 elevator_floor_update();
      if(!level.elevator_aggressive_call && !var_09) {
        if(var_08 get_curfloor() == var_01) {
          var_06 = 1;
          var_02 = [];
          break;
        }
      }
    }

    foreach(var_08 in var_02) {
      if(var_08.estate == "[A]") {
        var_08 call_elevator(var_01);
        var_06 = 1;
        if(!level.elevator_aggressive_call) {
          break;
        }
      }
    }

    if(var_06) {
      self playSound("elev_bell_ding");
    }
  }
}

call_elevator(param_00) {
  self.moveto_floor = param_00;
  var_01 = get_housing_inside_trigger();
  var_01 notify("trigger", "elevator_called");
  if(level.elevator_motion_detection) {
    var_01.motion_trigger notify("trigger", "elevator_called");
  }
}

get_floor(param_00) {
  var_01 = get_outer_doorsets();
  if(var_01.size == 2) {
    var_02 = get_curfloor();
    self.moveto_floor = !var_02;
    return;
  }

  var_01 setclientdvar("player_current_floor", get_curfloor());
  for(;;) {
    var_01 waittill("menuresponse", var_03, var_04);
    if(var_03 == "elevator_floor_selector") {
      if(var_04 != "none") {
        self.moveto_floor = int(var_04);
      }

      break;
    }
  }
}

elevator_interrupt(param_00) {
  self notify("interrupt_watch");
  level notify("elevator_interior_button_pressed");
  self endon("interrupt_watch");
  self endon("elevator_moving");
  self.elevator_interrupted = 0;
  wait(0.5);
  param_00 waittill("trigger", var_01);
  self notify("interrupted");
  self.elevator_interrupted = 1;
}

elevator_floor_update() {
  var_00 = get_housing_mainframe();
  var_01 = var_00.origin;
  var_02 = 1;
  foreach(var_06, var_04 in get_outer_doorsets()) {
    var_05 = self.e["floor" + var_06 + "_pos"];
    if(var_01 == var_05) {
      self.e["current_floor"] = var_06;
      var_02 = 0;
    }
  }

  return var_02;
}

elevator_sound_think() {
  var_00 = get_housing_musak_model();
  if(level.elevator_music && isDefined(var_00)) {
    var_00 playLoopSound("elev_musak_loop");
  }

  thread listen_for("closing_inner_doors");
  thread listen_for("opening_inner_doors");
  thread listen_for("closed_inner_doors");
  thread listen_for("opened_inner_doors");
  foreach(var_03, var_02 in get_outer_doorsets()) {
    thread listen_for("closing_floor_" + var_03 + "_outer_doors");
    thread listen_for("opening_floor_" + var_03 + "_outer_doors");
    thread listen_for("closed_floor_" + var_03 + "_outer_doors");
    thread listen_for("opened_floor_" + var_03 + "_outer_doors");
  }

  thread listen_for("interrupted");
  thread listen_for("elevator_moving");
  thread listen_for("elevator_moved");
}

listen_for(param_00) {
  for(;;) {
    self waittill(param_00);
    var_01 = get_housing_mainframe();
    if(issubstr(param_00, "closing_")) {
      var_01 playSound("elev_door_close");
    }

    if(issubstr(param_00, "opening_")) {
      var_01 playSound("elev_door_open");
    }

    if(param_00 == "elevator_moving") {
      var_01 playSound("elev_run_start");
      var_01 playLoopSound("elev_run_loop");
    }

    if(param_00 == "interrupted") {
      var_01 playSound("elev_door_interupt");
    }

    if(param_00 == "elevator_moved") {
      var_01 stoploopsound("elev_run_loop");
      var_01 playSound("elev_run_end");
      var_01 playSound("elev_bell_ding");
    }
  }
}

position_elevators() {
  foreach(var_01 in level.elevators) {
    var_01.moveto_floor = var_01 get_curfloor();
    foreach(var_04, var_03 in var_01 get_outer_doorsets()) {
      if(var_01 get_curfloor() != var_04) {
        var_01 thread close_outer_doors(var_04);
      }
    }
  }
}

elevator_move(param_00) {
  self notify("elevator_moving");
  self endon("elevator_moving");
  var_01 = get_housing_mainframe();
  var_02 = self.e["floor" + param_00 + "_pos"] - var_01.origin;
  var_03 = level.elevator_speed;
  var_04 = abs(distance(self.e["floor" + param_00 + "_pos"], var_01.origin));
  var_05 = var_04 / var_03;
  var_01 moveto(var_01.origin + var_02, var_05, var_05 * level.elevator_accel, var_05 * level.elevator_decel);
  foreach(var_07 in get_housing_children()) {
    var_08 = var_07.origin + var_02;
    if(!issubstr(var_07.classname, "trigger_")) {
      var_07 moveto(var_08, var_05, var_05 * level.elevator_accel, var_05 * level.elevator_decel);
      continue;
    }

    var_07.origin = var_08;
  }

  waittill_finish_moving(var_01, self.e["floor" + param_00 + "_pos"]);
  self notify("elevator_moved");
}

close_inner_doors() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");
  var_00 = get_housing_leftdoor();
  var_01 = get_housing_rightdoor();
  var_02 = get_housing_mainframe();
  var_03 = get_housing_closedpos();
  var_04 = (var_03[0], var_03[1], var_02.origin[2]);
  var_05 = level.elevator_innerdoorspeed;
  var_06 = abs(distance(var_00.origin, var_04));
  var_07 = var_06 / var_05;
  var_00 moveto(var_04, var_07, var_07 * 0.1, var_07 * 0.25);
  var_01 moveto(var_04, var_07, var_07 * 0.1, var_07 * 0.25);
  waittill_finish_moving(var_00, var_04, var_01, var_04);
  self notify("closed_inner_doors");
}

open_inner_doors() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");
  var_00 = get_housing_leftdoor();
  var_01 = get_housing_rightdoor();
  var_02 = get_housing_mainframe();
  var_03 = get_housing_leftdoor_opened_pos();
  var_04 = get_housing_rightdoor_opened_pos();
  var_05 = (var_03[0], var_03[1], var_02.origin[2]);
  var_06 = (var_04[0], var_04[1], var_02.origin[2]);
  var_07 = level.elevator_innerdoorspeed;
  var_08 = abs(distance(var_05, var_06) * 0.5);
  var_09 = var_08 / var_07 * 0.5;
  var_00 moveto(var_05, var_09, var_09 * 0.1, var_09 * 0.25);
  var_01 moveto(var_06, var_09, var_09 * 0.1, var_09 * 0.25);
  waittill_finish_moving(var_00, var_05, var_01, var_06);
  self notify("opened_inner_doors");
}

close_outer_doors(param_00) {
  self notify("closing_floor_" + param_00 + "_outer_doors");
  self endon("closing_floor_" + param_00 + "_outer_doors");
  self endon("opening_floor_" + param_00 + "_outer_doors");
  var_01 = get_outer_leftdoor(param_00);
  var_02 = get_outer_rightdoor(param_00);
  var_03 = get_outer_leftdoor_openedpos(param_00);
  var_04 = get_outer_closedpos(param_00);
  var_05 = level.elevator_outterdoorspeed;
  var_06 = abs(distance(var_03, var_04));
  var_07 = var_06 / var_05;
  var_01 moveto(var_04, var_07, var_07 * 0.1, var_07 * 0.25);
  var_02 moveto(var_04, var_07, var_07 * 0.1, var_07 * 0.25);
  waittill_finish_moving(var_01, var_04, var_02, var_04);
  self notify("closed_floor_" + param_00 + "_outer_doors");
}

open_outer_doors(param_00) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + param_00 + "_outer_doors");
  self endon("opening_floor_" + param_00 + "_outer_doors");
  var_01 = get_outer_leftdoor(param_00);
  var_02 = get_outer_rightdoor(param_00);
  var_03 = get_outer_leftdoor_openedpos(param_00);
  var_04 = get_outer_rightdoor_openedpos(param_00);
  var_05 = get_outer_closedpos(param_00);
  var_06 = level.elevator_outterdoorspeed;
  var_07 = abs(distance(var_03, var_05));
  var_08 = var_07 / var_06 * 0.5;
  var_01 moveto(var_03, var_08, var_08 * 0.1, var_08 * 0.25);
  var_02 moveto(var_04, var_08, var_08 * 0.1, var_08 * 0.25);
  waittill_finish_moving(var_01, var_03, var_02, var_04);
  self notify("opened_floor_" + param_00 + "_outer_doors");
}

build_elevators() {
  var_00 = getEntArray("elevator_group", "targetname");
  var_01 = getEntArray("elevator_housing", "targetname");
  var_02 = getEntArray("elevator_doorset", "targetname");
  foreach(var_04 in var_00) {
    var_05 = getent(var_04.target, "targetname");
    var_06 = [];
    var_06[0] = min(var_04.origin[0], var_05.origin[0]);
    var_06[1] = max(var_04.origin[0], var_05.origin[0]);
    var_06[2] = min(var_04.origin[1], var_05.origin[1]);
    var_06[3] = max(var_04.origin[1], var_05.origin[1]);
    var_07 = spawnStruct();
    var_07.e["id"] = level.elevators.size;
    var_07.e["housing"] = [];
    var_07.e["housing"]["mainframe"] = [];
    foreach(var_09 in var_01) {
      if(var_09 isinbound(var_06)) {
        var_07.e["housing"]["mainframe"][var_07.e["housing"]["mainframe"].size] = var_09;
        if(var_09.classname == "script_model") {
          continue;
        }

        if(var_09.var_9F == "light") {
          continue;
        }

        var_0A = getent(var_09.target, "targetname");
        var_07.e["housing"]["left_door"] = var_0A;
        var_07.e["housing"]["left_door_opened_pos"] = var_0A.origin;
        var_0B = getent(var_0A.target, "targetname");
        var_07.e["housing"]["right_door"] = var_0B;
        var_07.e["housing"]["right_door_opened_pos"] = var_0B.origin;
        var_0C = var_0A.origin - var_0B.origin * (0.5, 0.5, 0.5) + var_0B.origin;
        var_07.e["housing"]["door_closed_pos"] = var_0C;
        var_0D = getent(var_0B.target, "targetname");
        var_07.e["housing"]["door_trigger"] = var_0D;
        var_0E = getent(var_0D.target, "targetname");
        var_07.e["housing"]["inside_trigger"] = var_0E;
        var_0E make_discrete_trigger();
        var_0E.motion_trigger = spawn("trigger_radius", var_09.origin, 0, 64, 128);
      }
    }

    var_07.e["outer_doorset"] = [];
    foreach(var_11 in var_02) {
      if(var_11 isinbound(var_06)) {
        var_12 = isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "closed_for_lighting";
        var_13 = var_07.e["outer_doorset"].size;
        var_07.e["outer_doorset"][var_13] = [];
        var_07.e["outer_doorset"][var_13]["door_closed_pos"] = var_11.origin;
        var_14 = getent(var_11.target, "targetname");
        var_07.e["outer_doorset"][var_13]["left_door"] = var_14;
        var_07.e["outer_doorset"][var_13]["left_door_opened_pos"] = var_14.origin;
        var_15 = getent(var_14.target, "targetname");
        var_07.e["outer_doorset"][var_13]["right_door"] = var_15;
        var_07.e["outer_doorset"][var_13]["right_door_opened_pos"] = var_15.origin;
        if(var_12) {
          var_16 = var_11.origin - var_14.origin;
          var_11.origin = var_14.origin;
          var_14.origin = var_14.origin + var_16;
          var_15.origin = var_15.origin - var_16;
          var_07.e["outer_doorset"][var_13]["door_closed_pos"] = var_11.origin;
          var_07.e["outer_doorset"][var_13]["left_door_opened_pos"] = var_14.origin;
          var_07.e["outer_doorset"][var_13]["right_door_opened_pos"] = var_15.origin;
        }
      }
    }

    for(var_18 = 0; var_18 < var_07.e["outer_doorset"].size - 1; var_18++) {
      for(var_19 = 0; var_19 < var_07.e["outer_doorset"].size - 1 - var_18; var_19++) {
        if(var_07.e["outer_doorset"][var_19 + 1]["door_closed_pos"][2] < var_07.e["outer_doorset"][var_19]["door_closed_pos"][2]) {
          var_1A = var_07.e["outer_doorset"][var_19]["left_door"];
          var_1B = var_07.e["outer_doorset"][var_19]["left_door_opened_pos"];
          var_1C = var_07.e["outer_doorset"][var_19]["right_door"];
          var_1D = var_07.e["outer_doorset"][var_19]["right_door_opened_pos"];
          var_1E = var_07.e["outer_doorset"][var_19]["door_closed_pos"];
          var_07.e["outer_doorset"][var_19]["left_door"] = var_07.e["outer_doorset"][var_19 + 1]["left_door"];
          var_07.e["outer_doorset"][var_19]["left_door_opened_pos"] = var_07.e["outer_doorset"][var_19 + 1]["left_door_opened_pos"];
          var_07.e["outer_doorset"][var_19]["right_door"] = var_07.e["outer_doorset"][var_19 + 1]["right_door"];
          var_07.e["outer_doorset"][var_19]["right_door_opened_pos"] = var_07.e["outer_doorset"][var_19 + 1]["right_door_opened_pos"];
          var_07.e["outer_doorset"][var_19]["door_closed_pos"] = var_07.e["outer_doorset"][var_19 + 1]["door_closed_pos"];
          var_07.e["outer_doorset"][var_19 + 1]["left_door"] = var_1A;
          var_07.e["outer_doorset"][var_19 + 1]["left_door_opened_pos"] = var_1B;
          var_07.e["outer_doorset"][var_19 + 1]["right_door"] = var_1C;
          var_07.e["outer_doorset"][var_19 + 1]["right_door_opened_pos"] = var_1D;
          var_07.e["outer_doorset"][var_19 + 1]["door_closed_pos"] = var_1E;
        }
      }
    }

    var_1F = [];
    foreach(var_18, var_21 in var_07.e["outer_doorset"]) {
      var_22 = var_07 get_housing_mainframe();
      var_1F = (var_22.origin[0], var_22.origin[1], var_21["door_closed_pos"][2]);
      var_07.e["floor" + var_18 + "_pos"] = var_1F;
      if(var_22.origin == var_1F) {
        var_07.e["initial_floor"] = var_18;
        var_07.e["current_floor"] = var_18;
      }
    }

    level.elevators[level.elevators.size] = var_07;
    var_04 delete();
    var_05 delete();
  }

  foreach(var_11 in var_02) {
    var_11 delete();
  }

  build_call_buttons();
  if(!level.elevator_motion_detection) {
    setup_hints();
  }

  foreach(var_27 in level.elevators) {
    var_28 = var_27 get_housing_primarylight();
    if(isDefined(var_28) && var_28.size) {
      foreach(var_2A in var_28) {
        var_2A setlightintensity(0.75);
      }
    }
  }
}

build_call_buttons() {
  level.elevator_callbuttons = getEntArray("elevator_call", "targetname");
  foreach(var_01 in level.elevator_callbuttons) {
    var_01.e = [];
    var_02 = (0, 0, var_01.origin[2]);
    var_03 = (var_01.origin[0], var_01.origin[1], 0);
    var_04 = [];
    foreach(var_06 in level.elevators) {
      foreach(var_0B, var_08 in var_06 get_outer_doorsets()) {
        var_09 = (0, 0, var_06.e["floor" + var_0B + "_pos"][2]);
        var_0A = (var_06.e["floor" + var_0B + "_pos"][0], var_06.e["floor" + var_0B + "_pos"][1], 0);
        if(abs(distance(var_02, var_09)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(var_03, var_0A)) <= level.elevator_callbutton_link_h) {
            var_04[var_04.size] = var_06;
            var_01.e[var_0B] = var_04;
          }
        }
      }
    }

    var_01 make_discrete_trigger();
    var_01.motion_trigger = spawn("trigger_radius", var_01.origin + (0, 0, -32), 0, 32, 64);
  }
}

setup_hints() {
  foreach(var_01 in level.elevators) {
    var_02 = var_01 get_housing_inside_trigger();
    var_03 = var_01 get_outer_doorsets();
    var_04 = var_03.size;
    var_02 setcursorhint("HINT_NOICON");
    if(var_04 > 2) {
      var_02 sethintstring(&"ELEVATOR_FLOOR_SELECT_HINT");
      continue;
    }

    var_02 sethintstring(&"ELEVATOR_USE_HINT");
  }

  foreach(var_07 in level.elevator_callbuttons) {
    var_07 setcursorhint("HINT_NOICON");
    var_07 sethintstring(&"ELEVATOR_CALL_HINT");
  }
}

make_discrete_trigger() {
  self.enabled = 1;
  disable_trigger();
}

discrete_waittill(param_00) {
  enable_trigger();
  if(level.elevator_motion_detection) {
    self.motion_trigger waittill(param_00, var_01);
  } else {
    self waittill(var_01, var_01);
  }

  disable_trigger();
  return var_01;
}

enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin = self.origin + (0, 0, 10000);
    if(isDefined(self.motion_trigger)) {
      self.motion_trigger.origin = self.motion_trigger.origin + (0, 0, 10000);
    }
  }
}

disable_trigger() {
  self notify("disable_trigger");
  if(self.enabled) {
    thread disable_trigger_helper();
  }
}

disable_trigger_helper() {
  self endon("disable_trigger");
  self.enabled = 0;
  wait(1.5);
  self.origin = self.origin + (0, 0, -10000);
  if(isDefined(self.motion_trigger)) {
    self.motion_trigger.origin = self.motion_trigger.origin + (0, 0, -10000);
  }
}

get_outer_doorset(param_00) {
  return self.e["outer_doorset"][param_00];
}

get_outer_doorsets() {
  return self.e["outer_doorset"];
}

get_outer_closedpos(param_00) {
  return self.e["outer_doorset"][param_00]["door_closed_pos"];
}

get_outer_leftdoor(param_00) {
  return self.e["outer_doorset"][param_00]["left_door"];
}

get_outer_rightdoor(param_00) {
  return self.e["outer_doorset"][param_00]["right_door"];
}

get_outer_leftdoor_openedpos(param_00) {
  return self.e["outer_doorset"][param_00]["left_door_opened_pos"];
}

get_outer_rightdoor_openedpos(param_00) {
  return self.e["outer_doorset"][param_00]["right_door_opened_pos"];
}

get_housing_children() {
  var_00 = [];
  var_01 = get_housing_door_trigger();
  var_02 = get_housing_inside_trigger();
  var_03 = var_02.motion_trigger;
  var_04 = get_housing_leftdoor();
  var_05 = get_housing_rightdoor();
  var_00[var_00.size] = var_01;
  var_00[var_00.size] = var_02;
  var_00[var_00.size] = var_04;
  var_00[var_00.size] = var_05;
  if(isDefined(var_03)) {
    var_00[var_00.size] = var_03;
  }

  var_06 = get_housing_models();
  foreach(var_08 in var_06) {
    var_00[var_00.size] = var_08;
  }

  var_0A = get_housing_primarylight();
  foreach(var_0C in var_0A) {
    var_00[var_00.size] = var_0C;
  }

  return var_00;
}

get_housing_mainframe() {
  var_00 = self.e["housing"]["mainframe"];
  var_01 = undefined;
  foreach(var_03 in var_00) {
    if(var_03.classname != "script_model" && var_03.var_9F != "light") {
      var_01 = var_03;
    }
  }

  return var_01;
}

get_housing_models() {
  var_00 = self.e["housing"]["mainframe"];
  var_01 = [];
  foreach(var_03 in var_00) {
    if(var_03.classname == "script_model") {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

get_housing_primarylight() {
  var_00 = self.e["housing"]["mainframe"];
  var_01 = [];
  foreach(var_03 in var_00) {
    if(var_03.var_9F == "light") {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

get_housing_musak_model() {
  var_00 = get_housing_models();
  var_01 = undefined;
  foreach(var_03 in var_00) {
    if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "play_musak") {
      var_01 = var_03;
    }
  }

  return var_01;
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

get_curfloor() {
  var_00 = elevator_floor_update();
  return self.e["current_floor"];
}

get_initfloor() {
  return self.e["initial_floor"];
}

waittill_finish_moving(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02) && !isDefined(param_03)) {
    param_02 = param_00;
    param_03 = param_01;
  }

  for(;;) {
    var_04 = param_00.origin;
    var_05 = param_02.origin;
    if(var_04 == param_01 && var_05 == param_03) {
      break;
    }

    wait(0.05);
  }
}

isinbound(param_00) {
  var_01 = self.origin[0];
  var_02 = self.origin[1];
  var_03 = param_00[0];
  var_04 = param_00[1];
  var_05 = param_00[2];
  var_06 = param_00[3];
  return var_01 >= var_03 && var_01 <= var_04 && var_02 >= var_05 && var_02 <= var_06;
}

isinboundingspere(param_00) {
  var_01 = self.origin[0];
  var_02 = self.origin[1];
  var_03 = param_00[0];
  var_04 = param_00[1];
  var_05 = param_00[2];
  var_06 = param_00[3];
  var_07 = var_03 + var_04 / 2;
  var_08 = var_05 + var_06 / 2;
  var_09 = abs(distance((var_03, var_05, 0), (var_07, var_08, 0)));
  return abs(distance((var_01, var_02, 0), (var_07, var_08, 0))) < var_09;
}

waittill_or_timeout(param_00, param_01) {
  self endon(param_00);
  wait(param_01);
}

elevator_get_dvar_int(param_00, param_01) {
  return int(elevator_get_dvar(param_00, param_01));
}

elevator_get_dvar(param_00, param_01) {
  if(getdvar(param_00) != "") {
    return getdvarfloat(param_00);
  }

  setdvar(param_00, param_01);
  return param_01;
}

elevator_debug() {
  if(!level.elevator_debug) {
    return;
  }

  for(;;) {
    if(level.elevator_debug != 2) {
      continue;
    }

    foreach(var_01 in level.elevators) {
      var_02 = var_01 get_housing_mainframe();
      var_03 = var_01 get_housing_musak_model();
      foreach(var_05 in var_01.e["outer_doorset"]) {}
    }

    foreach(var_09 in level.elevator_callbuttons) {
      foreach(var_05 in var_09.e) {
        var_0B = 0;
        foreach(var_0D in var_05) {
          var_0B++;
          var_0E = var_09.origin + (0, 0, var_0B * -4);
        }
      }
    }

    wait(0.05);
  }
}