/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\elevator.gsc
***********************************************/

function init() {
  if(getDvar("scr_elevator_disabled") == "1") {
    return;
  }

  var0 = getEntArray("elevator_group", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  if(!var0.size) {
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

  foreach(var2 in level.elevators) {
    thread elevator_think();
    thread elevator_sound_think();
  }

  thread elevator_debug();
}

function elevator_update_global_dvars() {
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

    if(scripts\common\utility::issp()) {
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "0");
    } else {
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "1");
    }

    wait 1;
  }
}

function elevator_think() {
  elevator_fsm("[A]");
}

function elevator_call() {
  foreach(var1 in level.elevator_callbuttons) {
    thread monitor_callbutton();
  }
}

function floor_override(var0) {
  self endon("elevator_moving");
  self.floor_override = 0;
  self.overrider = undefined;

  for(;;) {
    var0 waittill("trigger", var1);
    self.floor_override = 1;
    self.overrider = var1;
    break;
  }

  self notify("floor_override");
}

function elevator_fsm(var0) {
  self.estate = var0;
  var1 = get_housing_door_trigger();
  var2 = get_housing_inside_trigger();

  for(;;) {
    if(self.estate == "[A]") {
      jumpiffalse(level.elevator_return && get_curfloor() != get_initfloor()) LOC_00000090;
      self.moveto_floor = get_initfloor();
      thread floor_override(var2);
      waittill_or_timeout("floor_override", level.elevator_waittime);

      if(self.floor_override && isDefined(self.overrider) && isPlayer(self.overrider)) {
        get_floor(self.overrider);
      }

      self.estate = "[B]";
      continue;
    }

    if(self.estate == "[B]") {
      thread elevator_interrupt(var1);
      var8 = get_curfloor();
      thread close_inner_doors();
      thread close_outer_doors(var8);
      scripts\engine\utility::ref_143a5("closed_inner_doors", "interrupted");

      if(self.elevator_interrupted) {
        self.estate = "[C]";
        continue;
      }

      self.estate = "[D]";
      continue;
    }

    if(self.estate == "[C]") {
      var8 = get_curfloor();
      thread open_inner_doors();
      thread open_outer_doors(var8);
      self waittill("opened_floor_" + var8 + "_outer_doors");

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
    }
  }
}

function monitor_callbutton() {
  for(;;) {
    var0 = discrete_waittill("trigger");
    var1 = undefined;
    var2 = [];

    foreach(var4 in self.e) {
      var1 = var5;
      var2 = var4;
    }

    var6 = 0;

    foreach(var8 in var2) {
      var9 = elevator_floor_update(var8);

      if(!level.elevator_aggressive_call && !var9) {
        if(get_curfloor(var8) == var1) {
          var6 = 1;
          var2 = [];
          break;
        }
      }
    }

    foreach(var8 in var2) {
      if(var8.estate == "[A]") {
        call_elevator(var8, var1);
        var6 = 1;

        if(!level.elevator_aggressive_call) {
          break;
        }
      }
    }

    if(var6) {
      self playSound("elev_bell_ding");
    }
  }
}

function call_elevator(var0) {
  self.moveto_floor = var0;
  var1 = get_housing_inside_trigger();
  var1 notify("trigger", "elevator_called");

  if(level.elevator_motion_detection) {
    var1.motion_trigger notify("trigger", "elevator_called");
    return;
  }
}

function get_floor(var0) {
  var1 = get_outer_doorsets();

  if(var1.size == 2) {
    var2 = get_curfloor();
    self.moveto_floor = !var2;
    return;
  }

  var1 setclientdvar("player_current_floor", get_curfloor());

  for(;;) {
    var1 waittill("menuresponse", var3, var4);

    if(var3 == "elevator_floor_selector") {
      if(var4 != "none") {
        self.moveto_floor = int(var4);
      }

      break;
    }
  }
}

function elevator_interrupt(var0) {
  self notify("interrupt_watch");
  level notify("elevator_interior_button_pressed");
  self endon("interrupt_watch");
  self endon("elevator_moving");
  self.elevator_interrupted = 0;
  wait 0.5;
  var0 waittill("trigger", var1);
  self notify("interrupted");
  self.elevator_interrupted = 1;
}

function elevator_floor_update() {
  var0 = get_housing_mainframe();
  var1 = var0.origin;
  var2 = 1;

  foreach(var4 in get_outer_doorsets()) {
    var5 = self.e["floor" + var6 + "_pos"];

    if(var1 == var5) {
      self.e["current_floor"] = var6;
      var2 = 0;
    }
  }

  return var2;
}

function elevator_sound_think() {
  var0 = get_housing_musak_model();

  if(level.elevator_music && isDefined(var0)) {
    var0 playLoopSound("elev_musak_loop");
  }

  thread listen_for("closing_inner_doors");
  thread listen_for("opening_inner_doors");
  thread listen_for("closed_inner_doors");
  thread listen_for("opened_inner_doors");

  foreach(var3, var2 in get_outer_doorsets()) {
    thread listen_for("closing_floor_" + var3 + "_outer_doors");
    thread listen_for("opening_floor_" + var3 + "_outer_doors");
    thread listen_for("closed_floor_" + var3 + "_outer_doors");
    thread listen_for("opened_floor_" + var3 + "_outer_doors");
  }

  thread listen_for("interrupted");
  thread listen_for("elevator_moving");
  thread listen_for("elevator_moved");
}

function listen_for(var0) {
  for(;;) {
    self waittill(var0);
    var1 = get_housing_mainframe();

    if(issubstr(var0, "closing_")) {
      var1 playSound("elev_door_close");
    }

    if(issubstr(var0, "opening_")) {
      var1 playSound("elev_door_open");
    }

    if(var0 == "elevator_moving") {
      var1 playSound("elev_run_start");
      var1 playLoopSound("elev_run_loop");
    }

    if(var0 == "interrupted") {
      var1 playSound("elev_door_interupt");
    }

    if(var0 == "elevator_moved") {
      var1 stoploopsound("elev_run_loop");
      var1 playSound("elev_run_end");
      var1 playSound("elev_bell_ding");
    }
  }
}

function position_elevators() {
  foreach(var1 in level.elevators) {
    var1.moveto_floor = get_curfloor(var1);

    foreach(var4, var3 in get_outer_doorsets(var1)) {
      if(get_curfloor(var1) != var4) {
        thread close_outer_doors(var1);
      }
    }
  }
}

function elevator_move(var0) {
  self notify("elevator_moving");
  self endon("elevator_moving");
  var1 = get_housing_mainframe();
  var2 = self.e["floor" + var0 + "_pos"] - var1.origin;
  var3 = level.elevator_speed;
  var4 = abs(distance(self.e["floor" + var0 + "_pos"], var1.origin));
  var5 = var4 / var3;
  var1 moveTo(var1.origin + var2, var5, var5 * level.elevator_accel, var5 * level.elevator_decel);

  foreach(var7 in get_housing_children()) {
    var8 = var7.origin + var2;

    if(!issubstr(var7.classname, "trigger_")) {
      var7 moveTo(var8, var5, var5 * level.elevator_accel, var5 * level.elevator_decel);
      continue;
    }

    var7.origin = var8;
  }

  waittill_finish_moving(var1, self.e["floor" + var0 + "_pos"]);
  self notify("elevator_moved");
}

function close_inner_doors() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");
  var0 = get_housing_leftdoor();
  var1 = get_housing_rightdoor();
  var2 = get_housing_mainframe();
  var3 = get_housing_closedpos();
  var4 = (var3[0], var3[1], var2.origin[2]);
  var5 = level.elevator_innerdoorspeed;
  var6 = abs(distance(var0.origin, var4));
  var7 = var6 / var5;
  var0 moveTo(var4, var7, var7 * 0.1, var7 * 0.25);
  var1 moveTo(var4, var7, var7 * 0.1, var7 * 0.25);
  waittill_finish_moving(var0, var4, var1, var4);
  self notify("closed_inner_doors");
}

function open_inner_doors() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");
  var0 = get_housing_leftdoor();
  var1 = get_housing_rightdoor();
  var2 = get_housing_mainframe();
  var3 = get_housing_leftdoor_opened_pos();
  var4 = get_housing_rightdoor_opened_pos();
  var5 = (var3[0], var3[1], var2.origin[2]);
  var6 = (var4[0], var4[1], var2.origin[2]);
  var7 = level.elevator_innerdoorspeed;
  var8 = abs(distance(var5, var6) * 0.5);
  var9 = var8 / var7 * 0.5;
  var0 moveTo(var5, var9, var9 * 0.1, var9 * 0.25);
  var1 moveTo(var6, var9, var9 * 0.1, var9 * 0.25);
  waittill_finish_moving(var0, var5, var1, var6);
  self notify("opened_inner_doors");
}

function close_outer_doors(var0) {
  self notify("closing_floor_" + var0 + "_outer_doors");
  self endon("closing_floor_" + var0 + "_outer_doors");
  self endon("opening_floor_" + var0 + "_outer_doors");
  var1 = get_outer_leftdoor(var0);
  var2 = get_outer_rightdoor(var0);
  var3 = get_outer_leftdoor_openedpos(var0);
  var4 = get_outer_closedpos(var0);
  var5 = level.elevator_outterdoorspeed;
  var6 = abs(distance(var3, var4));
  var7 = var6 / var5;
  var1 moveTo(var4, var7, var7 * 0.1, var7 * 0.25);
  var2 moveTo(var4, var7, var7 * 0.1, var7 * 0.25);
  waittill_finish_moving(var1, var4, var2, var4);
  self notify("closed_floor_" + var0 + "_outer_doors");
}

function open_outer_doors(var0) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + var0 + "_outer_doors");
  self endon("opening_floor_" + var0 + "_outer_doors");
  var1 = get_outer_leftdoor(var0);
  var2 = get_outer_rightdoor(var0);
  var3 = get_outer_leftdoor_openedpos(var0);
  var4 = get_outer_rightdoor_openedpos(var0);
  var5 = get_outer_closedpos(var0);
  var6 = level.elevator_outterdoorspeed;
  var7 = abs(distance(var3, var5));
  var8 = var7 / var6 * 0.5;
  var1 moveTo(var3, var8, var8 * 0.1, var8 * 0.25);
  var2 moveTo(var4, var8, var8 * 0.1, var8 * 0.25);
  waittill_finish_moving(var1, var3, var2, var4);
  self notify("opened_floor_" + var0 + "_outer_doors");
}

function build_elevators() {
  var0 = getEntArray("elevator_group", "targetname");
  var1 = getEntArray("elevator_housing", "targetname");
  var2 = getEntArray("elevator_doorset", "targetname");

  foreach(var4 in var0) {
    var5 = getEnt(var4.target, "targetname");
    var6 = [];
    var6 = min(var4.origin[0], var5.origin[0]);
    var6 = max(var4.origin[0], var5.origin[0]);
    var6 = min(var4.origin[1], var5.origin[1]);
    var6 = max(var4.origin[1], var5.origin[1]);
    var7 = spawnStruct();
    var7.e["id"] = level.elevators.size;
    var7.e["housing"] = [];
    var7.e["housing"]["mainframe"] = [];

    foreach(var9 in var1) {
      if(isinbound(var9, var6)) {
        var7.e["housing"]["mainframe"][var7.e["housing"]["mainframe"].size] = var9;

        if(var9.classname == "script_model") {
          continue;
        }

        if(var9.code_classname == "light") {
          continue;
        }

        var10 = getEnt(var9.target, "targetname");
        var7.e["housing"]["left_door"] = var10;
        var7.e["housing"]["left_door_opened_pos"] = var10.origin;
        var11 = getEnt(var10.target, "targetname");
        var7.e["housing"]["right_door"] = var11;
        var7.e["housing"]["right_door_opened_pos"] = var11.origin;
        var12 = (var10.origin - var11.origin) * (0.5, 0.5, 0.5) + var11.origin;
        var7.e["housing"]["door_closed_pos"] = var12;
        var13 = getEnt(var11.target, "targetname");
        var7.e["housing"]["door_trigger"] = var13;
        var14 = getEnt(var13.target, "targetname");
        var7.e["housing"]["inside_trigger"] = var14;
        make_discrete_trigger(var14);
        var14.motion_trigger = spawn("trigger_radius", var9.origin, 0, 64, 128);
      }
    }

    var7.e["outer_doorset"] = [];

    foreach(var17 in var2) {
      if(isinbound(var17, var6)) {
        var18 = isDefined(var17.script_noteworthy) && var17.script_noteworthy == "closed_for_lighting";
        var19 = var7.e["outer_doorset"].size;
        var7.e["outer_doorset"][var19] = [];
        var7.e["outer_doorset"][var19]["door_closed_pos"] = var17.origin;
        var20 = getEnt(var17.target, "targetname");
        var7.e["outer_doorset"][var19]["left_door"] = var20;
        var7.e["outer_doorset"][var19]["left_door_opened_pos"] = var20.origin;
        var21 = getEnt(var20.target, "targetname");
        var7.e["outer_doorset"][var19]["right_door"] = var21;
        var7.e["outer_doorset"][var19]["right_door_opened_pos"] = var21.origin;

        if(var18) {
          var22 = var17.origin - var20.origin;
          var17.origin = var20.origin;
          var20.origin += var22;
          var21.origin -= var22;
          var7.e["outer_doorset"][var19]["door_closed_pos"] = var17.origin;
          var7.e["outer_doorset"][var19]["left_door_opened_pos"] = var20.origin;
          var7.e["outer_doorset"][var19]["right_door_opened_pos"] = var21.origin;
        }
      }
    }

    for(var24 = 0; var24 < var7.e["outer_doorset"].size - 1; var24++) {
      for(var25 = 0; var25 < var7.e["outer_doorset"].size - 1 - var24; var25++) {
        if(var7.e["outer_doorset"][var25 + 1]["door_closed_pos"][2] < var7.e["outer_doorset"][var25]["door_closed_pos"][2]) {
          var26 = var7.e["outer_doorset"][var25]["left_door"];
          var27 = var7.e["outer_doorset"][var25]["left_door_opened_pos"];
          var28 = var7.e["outer_doorset"][var25]["right_door"];
          var29 = var7.e["outer_doorset"][var25]["right_door_opened_pos"];
          var30 = var7.e["outer_doorset"][var25]["door_closed_pos"];
          var7.e["outer_doorset"][var25]["left_door"] = var7.e["outer_doorset"][var25 + 1]["left_door"];
          var7.e["outer_doorset"][var25]["left_door_opened_pos"] = var7.e["outer_doorset"][var25 + 1]["left_door_opened_pos"];
          var7.e["outer_doorset"][var25]["right_door"] = var7.e["outer_doorset"][var25 + 1]["right_door"];
          var7.e["outer_doorset"][var25]["right_door_opened_pos"] = var7.e["outer_doorset"][var25 + 1]["right_door_opened_pos"];
          var7.e["outer_doorset"][var25]["door_closed_pos"] = var7.e["outer_doorset"][var25 + 1]["door_closed_pos"];
          var7.e["outer_doorset"][var25 + 1]["left_door"] = var26;
          var7.e["outer_doorset"][var25 + 1]["left_door_opened_pos"] = var27;
          var7.e["outer_doorset"][var25 + 1]["right_door"] = var28;
          var7.e["outer_doorset"][var25 + 1]["right_door_opened_pos"] = var29;
          var7.e["outer_doorset"][var25 + 1]["door_closed_pos"] = var30;
        }
      }
    }

    var31 = [];

    foreach(var24, var33 in var7.e["outer_doorset"]) {
      var34 = get_housing_mainframe(var7);
      var31 = (var34.origin[0], var34.origin[1], var33["door_closed_pos"][2]);
      var7.e["floor" + var24 + "_pos"] = var31;

      if(var34.origin == var31) {
        var7.e["initial_floor"] = var24;
        var7.e["current_floor"] = var24;
      }
    }

    level.elevators[level.elevators.size] = var7;
    var4 delete();
    var5 delete();
  }

  foreach(var17 in var2) {
    var17 delete();
  }

  build_call_buttons();

  if(!level.elevator_motion_detection) {
    setup_hints();
  }

  foreach(var39 in level.elevators) {
    var40 = get_housing_primarylight(var39);

    if(isDefined(var40) && var40.size) {
      foreach(var42 in var40) {
        var42 setlightintensity(0.75);
      }
    }
  }
}

function build_call_buttons() {
  level.elevator_callbuttons = getEntArray("elevator_call", "targetname");

  foreach(var1 in level.elevator_callbuttons) {
    var1.e = [];
    var2 = (0, 0, var1.origin[2]);
    var3 = (var1.origin[0], var1.origin[1], 0);
    var4 = [];

    foreach(var6 in level.elevators) {
      foreach(var11, var8 in get_outer_doorsets(var6)) {
        var9 = (0, 0, var6.e["floor" + var11 + "_pos"][2]);
        var10 = (var6.e["floor" + var11 + "_pos"][0], var6.e["floor" + var11 + "_pos"][1], 0);

        if(abs(distance(var2, var9)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(var3, var10)) <= level.elevator_callbutton_link_h) {
            var4 = var6;
            var1.e[var11] = var4;
          }
        }
      }
    }

    make_discrete_trigger(var1);
    var1.motion_trigger = spawn("trigger_radius", var1.origin + (0, 0, -32), 0, 32, 64);
  }
}

function setup_hints() {
  foreach(var1 in level.elevators) {
    var2 = get_housing_inside_trigger(var1);
    var3 = get_outer_doorsets(var1);
    var4 = var3.size;
    var2 setCursorHint("HINT_NOICON");

    if(var4 > 2) {
      var2 setHintString(&"ELEVATOR_FLOOR_SELECT_HINT");
      continue;
    }

    var2 setHintString(&"ELEVATOR_USE_HINT");
  }

  foreach(var7 in level.elevator_callbuttons) {
    var7 setCursorHint("HINT_NOICON");
    var7 setHintString(&"ELEVATOR_CALL_HINT");
  }
}

function make_discrete_trigger() {
  self.enabled = 1;
  disable_trigger();
}

function discrete_waittill(var0) {
  enable_trigger();
  jumpiffalse(level.elevator_motion_detection) LOC_00000021;
  self.motion_trigger waittill(var0, var1);
  goto LOC_00000029;
}

function enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin += (0, 0, 10000);

    if(isDefined(self.motion_trigger)) {
      self.motion_trigger.origin += (0, 0, 10000);
      return;
    }

    return;
  }
}

function disable_trigger() {
  self notify("disable_trigger");

  if(self.enabled) {
    thread disable_trigger_helper();
    return;
  }
}

function disable_trigger_helper() {
  self endon("disable_trigger");
  self.enabled = 0;
  wait 1.5;
  self.origin += (0, 0, -10000);

  if(isDefined(self.motion_trigger)) {
    self.motion_trigger.origin += (0, 0, -10000);
    return;
  }
}

function get_outer_doorset(var0) {
  return self.e["outer_doorset"][var0];
}

function get_outer_doorsets() {
  return self.e["outer_doorset"];
}

function get_outer_closedpos(var0) {
  return self.e["outer_doorset"][var0]["door_closed_pos"];
}

function get_outer_leftdoor(var0) {
  return self.e["outer_doorset"][var0]["left_door"];
}

function get_outer_rightdoor(var0) {
  return self.e["outer_doorset"][var0]["right_door"];
}

function get_outer_leftdoor_openedpos(var0) {
  return self.e["outer_doorset"][var0]["left_door_opened_pos"];
}

function get_outer_rightdoor_openedpos(var0) {
  return self.e["outer_doorset"][var0]["right_door_opened_pos"];
}

function get_housing_children() {
  var0 = [];
  var1 = get_housing_door_trigger();
  var2 = get_housing_inside_trigger();
  var3 = var2.motion_trigger;
  var4 = get_housing_leftdoor();
  var5 = get_housing_rightdoor();
  var0 = var1;
  var0 = var2;
  var0 = var4;
  var0 = var5;

  if(isDefined(var3)) {
    var0 = var3;
  }

  var6 = get_housing_models();

  foreach(var8 in var6) {
    var0 = var8;
  }

  var10 = get_housing_primarylight();

  foreach(var12 in var10) {
    var0 = var12;
  }

  return var0;
}

function get_housing_mainframe() {
  var0 = self.e["housing"]["mainframe"];
  var1 = undefined;

  foreach(var3 in var0) {
    if(var3.classname != "script_model" && var3.code_classname != "light") {
      var1 = var3;
    }
  }

  return var1;
}

function get_housing_models() {
  var0 = self.e["housing"]["mainframe"];
  var1 = [];

  foreach(var3 in var0) {
    if(var3.classname == "script_model") {
      var1 = var3;
    }
  }

  return var1;
}

function get_housing_primarylight() {
  var0 = self.e["housing"]["mainframe"];
  var1 = [];

  foreach(var3 in var0) {
    if(var3.code_classname == "light") {
      var1 = var3;
    }
  }

  return var1;
}

function get_housing_musak_model() {
  var0 = get_housing_models();
  var1 = undefined;

  foreach(var3 in var0) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "play_musak") {
      var1 = var3;
    }
  }

  return var1;
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
  var0 = elevator_floor_update();
  return self.e["current_floor"];
}

function get_initfloor() {
  return self.e["initial_floor"];
}

function waittill_finish_moving(var0, var1, var2, var3) {
  jumpiffalse(!isDefined(var2) && !isDefined(var3)) LOC_00000017;
  var2 = var0;
  var3 = var1;

  for(;;) {
    var4 = var0.origin;
    var5 = var2.origin;

    if(var4 == var1 && var5 == var3) {
      break;
    }

    wait 0.05;
  }
}

function isinbound(var0) {
  var1 = self.origin[0];
  var2 = self.origin[1];
  var3 = var0[0];
  var4 = var0[1];
  var5 = var0[2];
  var6 = var0[3];
  return var1 >= var3 && var1 <= var4 && var2 >= var5 && var2 <= var6;
}

function isinboundingspere(var0) {
  var1 = self.origin[0];
  var2 = self.origin[1];
  var3 = var0[0];
  var4 = var0[1];
  var5 = var0[2];
  var6 = var0[3];
  var7 = (var3 + var4) / 2;
  var8 = (var5 + var6) / 2;
  var9 = abs(distance((var3, var5, 0), (var7, var8, 0)));
  return abs(distance((var1, var2, 0), (var7, var8, 0))) < var9;
}

function waittill_or_timeout(var0, var1) {
  self endon(var0);
  wait var1;
}

function elevator_get_dvar_int(var0, var1) {
  return int(elevator_get_dvar(var0, var1));
}

function elevator_get_dvar(var0, var1) {
  if(getDvar(var0) != "") {
    return getdvarfloat(var0);
  }

  setDvar(var0, var1);
  return var1;
}

function elevator_debug() {
  jumpiftrue(level.elevator_debug) LOC_0000000a;
  return;
}