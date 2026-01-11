/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2722.gsc
***************************************/

door_system_init(var_00) {
  var_01 = getEntArray(var_00, "targetname");

  foreach(var_03 in var_01) {
    if(isDefined(var_3.script_parameters)) {
      var_03 button_parse_parameters(var_3.script_parameters);
    }

    var_03 door_setup();
  }

  foreach(var_03 in var_01) {
    var_03 thread door_think();
  }
}

door_setup() {
  var_00 = self;
  var_0.doors = [];

  if(isDefined(var_0.script_index)) {
    var_0.func_5A17 = max(0.1, float(var_0.script_index) / 1000);
  }

  var_01 = getEntArray(var_0.target, "targetname");

  foreach(var_03 in var_01) {
    if(issubstr(var_3.classname, "trigger")) {
      if(!isDefined(var_0.func_12720)) {
        var_0.func_12720 = [];
      }

      if(isDefined(var_3.script_parameters)) {
        var_03 trigger_parse_parameters(var_3.script_parameters);
      }

      if(isDefined(var_3.script_linkto)) {
        var_04 = getent(var_3.script_linkto, "script_linkname");
        var_03 getrankxp();
        var_03 linkto(var_04);
      }

      var_0.func_12720[var_0.func_12720.size] = var_03;
      continue;
    }

    if(var_3.classname == "script_brushmodel" || var_3.classname == "script_model") {
      if(isDefined(var_3.script_noteworthy) && issubstr(var_3.script_noteworthy, "light")) {
        if(issubstr(var_3.script_noteworthy, "light_on")) {
          if(!isDefined(var_0.lights_on)) {
            var_0.lights_on = [];
          }

          var_03 hide();
          var_0.lights_on[var_0.lights_on.size] = var_03;
        } else if(issubstr(var_3.script_noteworthy, "light_off")) {
          if(!isDefined(var_0.lights_off)) {
            var_0.lights_off = [];
          }

          var_03 hide();
          var_0.lights_off[var_0.lights_off.size] = var_03;
        } else {}
      } else if(var_3.spawnflags & 2) {
        if(!isDefined(var_0.func_19E5)) {
          var_0.func_19E5 = [];
        }

        var_03 notsolid();
        var_03 hide();
        var_03 _meth_829D(0);
        var_0.func_19E5[var_0.func_19E5.size] = var_03;
      } else
        var_0.doors[var_0.doors.size] = var_03;

      continue;
    }

    if(var_3.classname == "script_origin") {
      var_0.entsound = var_03;
    }
  }

  if(!isDefined(var_0.entsound) && var_0.doors.size) {
    var_0.entsound = sortbydistance(var_0.doors, var_0.origin)[0];
  }

  foreach(var_07 in var_0.doors) {
    var_7.func_D6A4 = var_7.origin;
    var_7.func_D6AE = scripts\engine\utility::getstruct(var_7.target, "targetname").origin;
    var_7.func_5717 = distance(var_7.func_D6AE, var_7.func_D6A4);
    var_7.origin = var_7.func_D6AE;
    var_7.func_C001 = 0;

    if(isDefined(var_7.script_parameters)) {
      var_07 func_59BD(var_7.script_parameters);
    }
  }
}

door_think() {
  var_00 = self;
  var_00 door_state_change(2, 1);

  for(;;) {
    var_0.func_10E27 = undefined;
    var_0.func_10E29 = undefined;
    var_00 scripts\engine\utility::waittill_any("door_state_done", "door_state_interrupted");

    if(isDefined(var_0.func_10E27) && var_0.func_10E27) {
      var_01 = var_00 door_state_next(var_0.statecurr);
      var_00 door_state_change(var_01, 0);
      continue;
    }

    if(isDefined(var_0.func_10E29) && var_0.func_10E29) {
      var_00 door_state_change(4, 0);
      continue;
    }
  }
}

door_state_next(var_00) {
  var_01 = self;
  var_02 = undefined;

  if(var_00 == 0) {
    var_02 = 3;
  } else if(var_00 == 2) {
    var_02 = 1;
  } else if(var_00 == 1) {
    var_02 = 0;
  } else if(var_00 == 3) {
    var_02 = 2;
  } else if(var_00 == 4) {
    var_02 = var_1.stateprev;
  } else {}

  return var_02;
}

door_state_update(var_00) {
  var_01 = self;
  var_01 endon("door_state_interrupted");
  var_1.func_10E27 = undefined;

  if(var_1.statecurr == 0 || var_1.statecurr == 2) {
    if(!var_00) {
      foreach(var_03 in var_1.doors) {
        if(isDefined(var_3.func_11041)) {
          var_03 stoploopsound();
          var_03 playsoundonmovingent(var_3.func_11041);
        }
      }
    }

    if(isDefined(var_1.lights_on)) {
      foreach(var_06 in var_1.lights_on) {
        var_06 show();
      }
    }

    foreach(var_03 in var_1.doors) {
      if(var_1.statecurr == 0) {
        if(isDefined(var_1.func_19E5)) {
          foreach(var_10 in var_1.func_19E5) {
            var_10 show();
            var_10 _meth_829D(1);
          }
        }

        if(var_3.spawnflags & 1) {
          var_03 disconnectpaths();
        }
      } else {
        if(isDefined(var_1.func_19E5)) {
          foreach(var_10 in var_1.func_19E5) {
            var_10 hide();
            var_10 _meth_829D(0);
          }
        }

        if(var_3.spawnflags & 1) {
          if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "always_disconnect") {
            var_03 disconnectpaths();
          } else {
            var_03 connectpaths();
          }
        }
      }

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel") {
          var_03 rotatevelocity((0, 0, 0), 0.1);
        }
      }

      if(var_3.func_C001) {
        var_3.unresolved_collision_func = undefined;
      }
    }

    var_15 = scripts\engine\utility::ter_op(var_1.statecurr == 0, &"MP_DOOR_USE_OPEN", &"MP_DOOR_USE_CLOSE");
    var_01 sethintstring(var_15);
    var_01 makeusable();
    var_01 waittill("trigger");

    if(isDefined(var_1.button_smash_count)) {
      var_01 playSound(var_1.button_smash_count);
    }
  } else if(var_1.statecurr == 1 || var_1.statecurr == 3) {
    if(isDefined(var_1.lights_off)) {
      foreach(var_06 in var_1.lights_off) {
        var_06 show();
      }
    }

    var_01 makeunusable();

    if(var_1.statecurr == 1) {
      var_01 thread door_state_on_interrupt();

      foreach(var_03 in var_1.doors) {
        if(isDefined(var_3.script_noteworthy)) {
          var_19 = scripts\engine\utility::ter_op(isDefined(var_1.func_5A17), var_1.func_5A17, 3.0);
          var_20 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.func_D6A4, var_3.func_D6AE);
          var_21 = distance(var_3.origin, var_20);
          var_22 = max(0.1, var_21 / var_3.func_5717 * var_19);
          var_23 = max(var_22 * 0.25, 0.05);
          var_24 = 360 * var_21 / 94.2;

          if(var_3.script_noteworthy == "clockwise_wheel") {
            var_03 rotatevelocity((0, 0, -1 * var_24 / var_22), var_22, var_23, var_23);
          } else if(var_3.script_noteworthy == "counterclockwise_wheel") {
            var_03 rotatevelocity((0, 0, var_24 / var_22), var_22, var_23, var_23);
          }
        }
      }
    } else if(var_1.statecurr == 3) {
      if(isDefined(var_1.func_C607) && var_1.func_C607) {
        var_01 thread door_state_on_interrupt();
      }

      foreach(var_03 in var_1.doors) {
        if(isDefined(var_3.script_noteworthy)) {
          var_19 = scripts\engine\utility::ter_op(isDefined(var_1.func_5A17), var_1.func_5A17, 3.0);
          var_20 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.func_D6A4, var_3.func_D6AE);
          var_21 = distance(var_3.origin, var_20);
          var_22 = max(0.1, var_21 / var_3.func_5717 * var_19);
          var_23 = max(var_22 * 0.25, 0.05);
          var_24 = 360 * var_21 / 94.2;

          if(var_3.script_noteworthy == "clockwise_wheel") {
            var_03 rotatevelocity((0, 0, var_24 / var_22), var_22, var_23, var_23);
          } else if(var_3.script_noteworthy == "counterclockwise_wheel") {
            var_03 rotatevelocity((0, 0, -1 * var_24 / var_22), var_22, var_23, var_23);
          }
        }
      }
    }

    wait 0.1;
    var_01 childthread func_59F1("garage_door_start", "garage_door_loop");
    var_19 = scripts\engine\utility::ter_op(isDefined(var_1.func_5A17), var_1.func_5A17, 3.0);
    var_28 = undefined;

    foreach(var_03 in var_1.doors) {
      var_20 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.func_D6A4, var_3.func_D6AE);

      if(var_3.origin != var_20) {
        var_22 = max(0.1, distance(var_3.origin, var_20) / var_3.func_5717 * var_19);
        var_23 = max(var_22 * 0.25, 0.05);
        var_03 moveto(var_20, var_22, var_23, var_23);
        var_03 scripts\mp\movers::notify_moving_platform_invalid();

        if(var_3.func_C001) {
          var_3.unresolved_collision_func = scripts\mp\movers::func_12BEE;
        }

        if(!isDefined(var_28) || var_22 > var_28) {
          var_28 = var_22;
        }
      }
    }

    if(isDefined(var_28)) {
      wait(var_28);
    }
  } else if(var_1.statecurr == 4) {
    foreach(var_03 in var_1.doors) {
      var_03 moveto(var_3.origin, 0.05, 0.0, 0.0);
      var_03 scripts\mp\movers::notify_moving_platform_invalid();

      if(var_3.func_C001) {
        var_3.unresolved_collision_func = undefined;
      }

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel") {
          var_03 rotatevelocity((0, 0, 0), 0.05);
        }
      }
    }

    if(isDefined(var_1.lights_off)) {
      foreach(var_06 in var_1.lights_off) {
        var_06 show();
      }
    }

    var_1.entsound stoploopsound();

    foreach(var_03 in var_1.doors) {
      if(isDefined(var_3.func_9A88)) {
        var_03 playSound(var_3.func_9A88);
      }
    }

    wait 1.0;
  } else {}

  var_1.func_10E27 = 1;

  foreach(var_03 in var_1.doors) {
    var_3.func_10E27 = 1;
  }

  var_01 notify("door_state_done");
}

func_59F1(var_00, var_01) {
  var_02 = self;
  var_03 = 1;
  var_04 = 1;
  var_05 = 0;

  if(var_2.statecurr == 3 || var_2.statecurr == 1) {
    foreach(var_07 in var_2.doors) {
      if(isDefined(var_7.func_10D2A)) {
        var_07 playsoundonmovingent(var_7.func_10D2A);
        var_05 = lookupsoundlength(var_7.func_10D2A) / 1000;
        var_03 = 0;
      }
    }

    if(var_03) {
      var_05 = lookupsoundlength(var_00) / 1000;
      playLoopSound(var_2.entsound.origin, var_00);
    }
  }

  wait(var_05 * 0.3);

  if(var_2.statecurr == 3 || var_2.statecurr == 1) {
    foreach(var_07 in var_2.doors) {
      if(isDefined(var_7.loop_sound)) {
        if(var_7.loop_sound != "none") {
          var_07 playLoopSound(var_7.loop_sound);
        }

        var_04 = 0;
      }
    }

    if(var_04) {
      var_2.entsound playLoopSound(var_01);
    }
  }
}

door_state_change(var_00, var_01) {
  var_02 = self;

  if(isDefined(var_2.statecurr)) {
    door_state_exit(var_2.statecurr);
    var_2.stateprev = var_2.statecurr;
  }

  var_2.statecurr = var_00;
  var_02 thread door_state_update(var_01);
}

door_state_exit(var_00) {
  var_01 = self;

  if(var_00 == 0 || var_00 == 2) {
    if(isDefined(var_1.lights_on)) {
      foreach(var_03 in var_1.lights_on) {
        var_03 hide();
      }
    }
  } else if(var_00 == 1 || var_00 == 3) {
    if(isDefined(var_1.lights_off)) {
      foreach(var_03 in var_1.lights_off) {
        var_03 hide();
      }
    }

    var_1.entsound stoploopsound();

    foreach(var_08 in var_1.doors) {
      if(isDefined(var_8.loop_sound)) {
        var_08 stoploopsound();
      }
    }
  } else {
    if(var_00 == 4) {
      return;
    }
    return;
  }
}

door_state_on_interrupt() {
  var_00 = self;
  var_00 endon("door_state_done");
  var_01 = [];

  foreach(var_03 in var_0.func_12720) {
    if(var_0.statecurr == 1) {
      if(isDefined(var_3.not_closing) && var_3.not_closing == 1) {
        continue;
      }
    } else if(var_0.statecurr == 3) {
      if(isDefined(var_3.not_opening) && var_3.not_opening == 1) {
        continue;
      }
    }

    var_1[var_1.size] = var_03;
  }

  if(var_1.size > 0) {
    var_05 = var_00 waittill_any_triggered_return_triggerer(var_01);

    if(!isDefined(var_5.fauxdeath) || var_5.fauxdeath == 0) {
      var_0.func_10E29 = 1;
      var_00 notify("door_state_interrupted");
    }
  }
}

waittill_any_triggered_return_triggerer(var_00) {
  var_01 = self;

  foreach(var_03 in var_00) {
    var_01 thread return_triggerer(var_03);
  }

  var_01 waittill("interrupted");
  return var_1.interrupter;
}

return_triggerer(var_00) {
  var_01 = self;
  var_01 endon("door_state_done");
  var_01 endon("interrupted");

  for(;;) {
    var_00 waittill("trigger", var_02);

    if(isDefined(var_0.prone_only) && var_0.prone_only == 1) {
      if(isplayer(var_02)) {
        var_03 = var_02 getstance();

        if(var_03 != "prone") {
          continue;
        } else {
          var_04 = vectornormalize(anglesToForward(var_2.angles));
          var_05 = vectornormalize(var_0.origin - var_2.origin);
          var_06 = vectordot(var_04, var_05);

          if(var_06 > 0) {
            continue;
          }
        }
      }
    }

    break;
  }

  var_1.interrupter = var_02;
  var_01 notify("interrupted");
}

button_parse_parameters(var_00) {
  var_01 = self;
  var_1.button_smash_count = undefined;

  if(!isDefined(var_00)) {
    var_00 = "";
  }

  var_02 = strtok(var_00, ";");

  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "=");

    if(var_5.size != 2) {
      continue;
    }
    if(var_5[1] == "undefined" || var_5[1] == "default") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "open_interrupt":
        var_1.func_C607 = string_to_bool(var_5[1]);
        break;
      case "button_sound":
        var_1.button_smash_count = var_5[1];
        break;
      default:
        break;
    }
  }
}

func_59BD(var_00) {
  var_01 = self;
  var_1.func_10D2A = undefined;
  var_1.func_11041 = undefined;
  var_1.loop_sound = undefined;
  var_1.func_9A88 = undefined;

  if(!isDefined(var_00)) {
    var_00 = "";
  }

  var_02 = strtok(var_00, ";");

  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "=");

    if(var_5.size != 2) {
      continue;
    }
    if(var_5[1] == "undefined" || var_5[1] == "default") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "stop_sound":
        var_1.func_11041 = var_5[1];
        break;
      case "interrupt_sound":
        var_1.func_9A88 = var_5[1];
        break;
      case "loop_sound":
        var_1.loop_sound = var_5[1];
        break;
      case "open_interrupt":
        var_1.func_C607 = string_to_bool(var_5[1]);
        break;
      case "start_sound":
        var_1.func_10D2A = var_5[1];
        break;
      case "unresolved_collision_nodes":
        var_1.unresolved_collision_nodes = getnodearray(var_5[1], "targetname");
        break;
      case "no_moving_unresolved_collisions":
        var_1.func_C001 = string_to_bool(var_5[1]);
        break;
      default:
        break;
    }
  }
}

trigger_parse_parameters(var_00) {
  var_01 = self;

  if(!isDefined(var_00)) {
    var_00 = "";
  }

  var_02 = strtok(var_00, ";");

  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "=");

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

string_to_bool(var_00) {
  var_01 = undefined;

  switch (var_00) {
    case "true":
    case "1":
      var_01 = 1;
      break;
    case "false":
    case "0":
      var_01 = 0;
      break;
    default:
      break;
  }

  return var_01;
}