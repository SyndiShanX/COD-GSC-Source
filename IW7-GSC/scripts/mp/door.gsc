/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\door.gsc
*********************************************/

door_system_init(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters)) {
      var_3 button_parse_parameters(var_3.script_parameters);
    }

    var_3 door_setup();
  }

  foreach(var_3 in var_1) {
    var_3 thread door_think();
  }
}

door_setup() {
  var_0 = self;
  var_0.doors = [];
  if(isDefined(var_0.script_index)) {
    var_0.var_5A17 = max(0.1, float(var_0.script_index) / 1000);
  }

  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(issubstr(var_3.classname, "trigger")) {
      if(!isDefined(var_0.var_12720)) {
        var_0.var_12720 = [];
      }

      if(isDefined(var_3.script_parameters)) {
        var_3 trigger_parse_parameters(var_3.script_parameters);
      }

      if(isDefined(var_3.script_linkto)) {
        var_4 = getent(var_3.script_linkto, "script_linkname");
        var_3 enablelinkto();
        var_3 linkto(var_4);
      }

      var_0.var_12720[var_0.var_12720.size] = var_3;
      continue;
    }

    if(var_3.classname == "script_brushmodel" || var_3.classname == "script_model") {
      if(isDefined(var_3.script_noteworthy) && issubstr(var_3.script_noteworthy, "light")) {
        if(issubstr(var_3.script_noteworthy, "light_on")) {
          if(!isDefined(var_0.lights_on)) {
            var_0.lights_on = [];
          }

          var_3 hide();
          var_0.lights_on[var_0.lights_on.size] = var_3;
        } else if(issubstr(var_3.script_noteworthy, "light_off")) {
          if(!isDefined(var_0.lights_off)) {
            var_0.lights_off = [];
          }

          var_3 hide();
          var_0.lights_off[var_0.lights_off.size] = var_3;
        }
      } else if(var_3.spawnimpulsefield & 2) {
        if(!isDefined(var_0.var_19E5)) {
          var_0.var_19E5 = [];
        }

        var_3 notsolid();
        var_3 hide();
        var_3 func_829D(0);
        var_0.var_19E5[var_0.var_19E5.size] = var_3;
      } else {
        var_0.doors[var_0.doors.size] = var_3;
      }

      continue;
    }

    if(var_3.classname == "script_origin") {
      var_0.entsound = var_3;
    }
  }

  if(!isDefined(var_0.entsound) && var_0.doors.size) {
    var_0.entsound = sortbydistance(var_0.doors, var_0.origin)[0];
  }

  foreach(var_7 in var_0.doors) {
    var_7.var_D6A4 = var_7.origin;
    var_7.var_D6AE = scripts\engine\utility::getstruct(var_7.target, "targetname").origin;
    var_7.var_5717 = distance(var_7.var_D6AE, var_7.var_D6A4);
    var_7.origin = var_7.var_D6AE;
    var_7.var_C001 = 0;
    if(isDefined(var_7.script_parameters)) {
      var_7 func_59BD(var_7.script_parameters);
    }
  }
}

door_think() {
  var_0 = self;
  var_0 door_state_change(2, 1);
  for(;;) {
    var_0.var_10E27 = undefined;
    var_0.var_10E29 = undefined;
    var_0 scripts\engine\utility::waittill_any("door_state_done", "door_state_interrupted");
    if(isDefined(var_0.var_10E27) && var_0.var_10E27) {
      var_1 = var_0 door_state_next(var_0.statecurr);
      var_0 door_state_change(var_1, 0);
      continue;
    }

    if(isDefined(var_0.var_10E29) && var_0.var_10E29) {
      var_0 door_state_change(4, 0);
      continue;
    }
  }
}

door_state_next(var_0) {
  var_1 = self;
  var_2 = undefined;
  if(var_0 == 0) {
    var_2 = 3;
  } else if(var_0 == 2) {
    var_2 = 1;
  } else if(var_0 == 1) {
    var_2 = 0;
  } else if(var_0 == 3) {
    var_2 = 2;
  } else if(var_0 == 4) {
    var_2 = var_1.stateprev;
  }

  return var_2;
}

door_state_update(var_0) {
  var_1 = self;
  var_1 endon("door_state_interrupted");
  var_1.var_10E27 = undefined;
  if(var_1.statecurr == 0 || var_1.statecurr == 2) {
    if(!var_0) {
      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.var_11041)) {
          var_3 stoploopsound();
          var_3 playsoundonmovingent(var_3.var_11041);
        }
      }
    }

    if(isDefined(var_1.lights_on)) {
      foreach(var_6 in var_1.lights_on) {
        var_6 show();
      }
    }

    foreach(var_3 in var_1.doors) {
      if(var_1.statecurr == 0) {
        if(isDefined(var_1.var_19E5)) {
          foreach(var_10 in var_1.var_19E5) {
            var_10 show();
            var_10 func_829D(1);
          }
        }

        if(var_3.spawnimpulsefield & 1) {
          var_3 disconnectpaths();
        }
      } else {
        if(isDefined(var_1.var_19E5)) {
          foreach(var_10 in var_1.var_19E5) {
            var_10 hide();
            var_10 func_829D(0);
          }
        }

        if(var_3.spawnimpulsefield & 1) {
          if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "always_disconnect") {
            var_3 disconnectpaths();
          } else {
            var_3 connectpaths();
          }
        }
      }

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel") {
          var_3 rotatevelocity((0, 0, 0), 0.1);
        }
      }

      if(var_3.var_C001) {
        var_3.unresolved_collision_func = undefined;
      }
    }

    var_15 = scripts\engine\utility::ter_op(var_1.statecurr == 0, &"MP_DOOR_USE_OPEN", &"MP_DOOR_USE_CLOSE");
    var_1 sethintstring(var_15);
    var_1 makeusable();
    var_1 waittill("trigger");
    if(isDefined(var_1.button_smash_count)) {
      var_1 playSound(var_1.button_smash_count);
    }
  } else if(var_1.statecurr == 1 || var_1.statecurr == 3) {
    if(isDefined(var_1.lights_off)) {
      foreach(var_6 in var_1.lights_off) {
        var_6 show();
      }
    }

    var_1 makeunusable();
    if(var_1.statecurr == 1) {
      var_1 thread door_state_on_interrupt();
      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.script_noteworthy)) {
          var_13 = scripts\engine\utility::ter_op(isDefined(var_1.var_5A17), var_1.var_5A17, 3);
          var_14 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.var_D6A4, var_3.var_D6AE);
          var_15 = distance(var_3.origin, var_14);
          var_16 = max(0.1, var_15 / var_3.var_5717 * var_13);
          var_17 = max(var_16 * 0.25, 0.05);
          var_18 = 360 * var_15 / 94.2;
          if(var_3.script_noteworthy == "clockwise_wheel") {
            var_3 rotatevelocity((0, 0, -1 * var_18 / var_16), var_16, var_17, var_17);
          } else if(var_3.script_noteworthy == "counterclockwise_wheel") {
            var_3 rotatevelocity((0, 0, var_18 / var_16), var_16, var_17, var_17);
          }
        }
      }
    } else if(var_1.statecurr == 3) {
      if(isDefined(var_1.var_C607) && var_1.var_C607) {
        var_1 thread door_state_on_interrupt();
      }

      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.script_noteworthy)) {
          var_13 = scripts\engine\utility::ter_op(isDefined(var_1.var_5A17), var_1.var_5A17, 3);
          var_14 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.var_D6A4, var_3.var_D6AE);
          var_15 = distance(var_3.origin, var_14);
          var_16 = max(0.1, var_15 / var_3.var_5717 * var_13);
          var_17 = max(var_16 * 0.25, 0.05);
          var_18 = 360 * var_15 / 94.2;
          if(var_3.script_noteworthy == "clockwise_wheel") {
            var_3 rotatevelocity((0, 0, var_18 / var_16), var_16, var_17, var_17);
          } else if(var_3.script_noteworthy == "counterclockwise_wheel") {
            var_3 rotatevelocity((0, 0, -1 * var_18 / var_16), var_16, var_17, var_17);
          }
        }
      }
    }

    wait(0.1);
    var_1 childthread func_59F1("garage_door_start", "garage_door_loop");
    var_13 = scripts\engine\utility::ter_op(isDefined(var_1.var_5A17), var_1.var_5A17, 3);
    var_1C = undefined;
    foreach(var_3 in var_1.doors) {
      var_14 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.var_D6A4, var_3.var_D6AE);
      if(var_3.origin != var_14) {
        var_16 = max(0.1, distance(var_3.origin, var_14) / var_3.var_5717 * var_13);
        var_17 = max(var_16 * 0.25, 0.05);
        var_3 moveto(var_14, var_16, var_17, var_17);
        var_3 scripts\mp\movers::notify_moving_platform_invalid();
        if(var_3.var_C001) {
          var_3.unresolved_collision_func = scripts\mp\movers::func_12BEE;
        }

        if(!isDefined(var_1C) || var_16 > var_1C) {
          var_1C = var_16;
        }
      }
    }

    if(isDefined(var_1C)) {
      wait(var_1C);
    }
  } else if(var_1.statecurr == 4) {
    foreach(var_3 in var_1.doors) {
      var_3 moveto(var_3.origin, 0.05, 0, 0);
      var_3 scripts\mp\movers::notify_moving_platform_invalid();
      if(var_3.var_C001) {
        var_3.unresolved_collision_func = undefined;
      }

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel") {
          var_3 rotatevelocity((0, 0, 0), 0.05);
        }
      }
    }

    if(isDefined(var_1.lights_off)) {
      foreach(var_6 in var_1.lights_off) {
        var_6 show();
      }
    }

    var_1.entsound stoploopsound();
    foreach(var_3 in var_1.doors) {
      if(isDefined(var_3.var_9A88)) {
        var_3 playSound(var_3.var_9A88);
      }
    }

    wait(1);
  }

  var_1.var_10E27 = 1;
  foreach(var_3 in var_1.doors) {
    var_3.var_10E27 = 1;
  }

  var_1 notify("door_state_done");
}

func_59F1(var_0, var_1) {
  var_2 = self;
  var_3 = 1;
  var_4 = 1;
  var_5 = 0;
  if(var_2.statecurr == 3 || var_2.statecurr == 1) {
    foreach(var_7 in var_2.doors) {
      if(isDefined(var_7.var_10D2A)) {
        var_7 playsoundonmovingent(var_7.var_10D2A);
        var_5 = lookupsoundlength(var_7.var_10D2A) / 1000;
        var_3 = 0;
      }
    }

    if(var_3) {
      var_5 = lookupsoundlength(var_0) / 1000;
      playsoundatpos(var_2.entsound.origin, var_0);
    }
  }

  wait(var_5 * 0.3);
  if(var_2.statecurr == 3 || var_2.statecurr == 1) {
    foreach(var_7 in var_2.doors) {
      if(isDefined(var_7.loop_sound)) {
        if(var_7.loop_sound != "none") {
          var_7 playLoopSound(var_7.loop_sound);
        }

        var_4 = 0;
      }
    }

    if(var_4) {
      var_2.entsound playLoopSound(var_1);
    }
  }
}

door_state_change(var_0, var_1) {
  var_2 = self;
  if(isDefined(var_2.statecurr)) {
    door_state_exit(var_2.statecurr);
    var_2.stateprev = var_2.statecurr;
  }

  var_2.statecurr = var_0;
  var_2 thread door_state_update(var_1);
}

door_state_exit(var_0) {
  var_1 = self;
  if(var_0 == 0 || var_0 == 2) {
    if(isDefined(var_1.lights_on)) {
      foreach(var_3 in var_1.lights_on) {
        var_3 hide();
      }

      return;
    }

    return;
  }

  if(var_3 == 1 || var_3 == 3) {
    if(isDefined(var_4.lights_off)) {
      foreach(var_5 in var_4.lights_off) {
        var_5 hide();
      }
    }

    var_3.entsound stoploopsound();
    foreach(var_8 in var_3.doors) {
      if(isDefined(var_8.loop_sound)) {
        var_8 stoploopsound();
      }
    }

    return;
  }

  if(var_2 == 4) {
    return;
  }
}

door_state_on_interrupt() {
  var_0 = self;
  var_0 endon("door_state_done");
  var_1 = [];
  foreach(var_3 in var_0.var_12720) {
    if(var_0.statecurr == 1) {
      if(isDefined(var_3.not_closing) && var_3.not_closing == 1) {
        continue;
      }
    } else if(var_0.statecurr == 3) {
      if(isDefined(var_3.not_opening) && var_3.not_opening == 1) {
        continue;
      }
    }

    var_1[var_1.size] = var_3;
  }

  if(var_1.size > 0) {
    var_5 = var_0 waittill_any_triggered_return_triggerer(var_1);
    if(!isDefined(var_5.fauxdeath) || var_5.fauxdeath == 0) {
      var_0.var_10E29 = 1;
      var_0 notify("door_state_interrupted");
    }
  }
}

waittill_any_triggered_return_triggerer(var_0) {
  var_1 = self;
  foreach(var_3 in var_0) {
    var_1 thread return_triggerer(var_3);
  }

  var_1 waittill("interrupted");
  return var_1.interrupter;
}

return_triggerer(var_0) {
  var_1 = self;
  var_1 endon("door_state_done");
  var_1 endon("interrupted");
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(isDefined(var_0.prone_only) && var_0.prone_only == 1) {
      if(isplayer(var_2)) {
        var_3 = var_2 getstance();
        if(var_3 != "prone") {
          continue;
        } else {
          var_4 = vectornormalize(anglesToForward(var_2.angles));
          var_5 = vectornormalize(var_0.origin - var_2.origin);
          var_6 = vectordot(var_4, var_5);
          if(var_6 > 0) {
            continue;
          }
        }
      }
    }

    break;
  }

  var_1.interrupter = var_2;
  var_1 notify("interrupted");
}

button_parse_parameters(var_0) {
  var_1 = self;
  var_1.button_smash_count = undefined;
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_2 = strtok(var_0, ";");
  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "=");
    if(var_5.size != 2) {
      continue;
    }

    if(var_5[1] == "undefined" || var_5[1] == "default") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "open_interrupt":
        var_1.var_C607 = string_to_bool(var_5[1]);
        break;

      case "button_sound":
        var_1.button_smash_count = var_5[1];
        break;

      default:
        break;
    }
  }
}

func_59BD(var_0) {
  var_1 = self;
  var_1.var_10D2A = undefined;
  var_1.var_11041 = undefined;
  var_1.loop_sound = undefined;
  var_1.var_9A88 = undefined;
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_2 = strtok(var_0, ";");
  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "=");
    if(var_5.size != 2) {
      continue;
    }

    if(var_5[1] == "undefined" || var_5[1] == "default") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "stop_sound":
        var_1.var_11041 = var_5[1];
        break;

      case "interrupt_sound":
        var_1.var_9A88 = var_5[1];
        break;

      case "loop_sound":
        var_1.loop_sound = var_5[1];
        break;

      case "open_interrupt":
        var_1.var_C607 = string_to_bool(var_5[1]);
        break;

      case "start_sound":
        var_1.var_10D2A = var_5[1];
        break;

      case "unresolved_collision_nodes":
        var_1.unresolved_collision_nodes = getnodearray(var_5[1], "targetname");
        break;

      case "no_moving_unresolved_collisions":
        var_1.var_C001 = string_to_bool(var_5[1]);
        break;

      default:
        break;
    }
  }
}

trigger_parse_parameters(var_0) {
  var_1 = self;
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_2 = strtok(var_0, ";");
  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "=");
    if(var_5.size != 2) {
      continue;
    }

    if(var_5[1] == "undefined" || var_5[1] == "default") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "not_opening":
        var_1.not_opening = string_to_bool(var_5[1]);
        break;

      case "not_closing":
        var_1.not_closing = string_to_bool(var_5[1]);
        break;

      case "prone_only":
        var_1.prone_only = string_to_bool(var_5[1]);
        break;

      default:
        break;
    }
  }
}

string_to_bool(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "true":
    case "1":
      var_1 = 1;
      break;

    case "false":
    case "0":
      var_1 = 0;
      break;

    default:
      break;
  }

  return var_1;
}