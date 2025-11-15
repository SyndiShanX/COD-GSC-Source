/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\door.gsc
*******************************/

door_system_init(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.script_parameters)) {
      var_03 button_parse_parameters(var_03.script_parameters);
    }

    var_03 door_setup();
  }

  foreach(var_03 in var_01) {
    var_03 thread door_think();
  }
}

door_setup() {
  var_00 = self;
  var_00.doors = [];
  if(isDefined(var_00.script_index)) {
    var_00.var_5A17 = max(0.1, float(var_00.script_index) / 1000);
  }

  var_01 = getEntArray(var_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(issubstr(var_03.classname, "trigger")) {
      if(!isDefined(var_00.var_12720)) {
        var_00.var_12720 = [];
      }

      if(isDefined(var_03.script_parameters)) {
        var_03 trigger_parse_parameters(var_03.script_parameters);
      }

      if(isDefined(var_03.script_linkto)) {
        var_04 = getent(var_03.script_linkto, "script_linkname");
        var_03 enablelinkto();
        var_03 linkto(var_04);
      }

      var_00.var_12720[var_00.var_12720.size] = var_03;
      continue;
    }

    if(var_03.classname == "script_brushmodel" || var_03.classname == "script_model") {
      if(isDefined(var_03.script_noteworthy) && issubstr(var_03.script_noteworthy, "light")) {
        if(issubstr(var_03.script_noteworthy, "light_on")) {
          if(!isDefined(var_00.lights_on)) {
            var_00.lights_on = [];
          }

          var_03 hide();
          var_00.lights_on[var_00.lights_on.size] = var_03;
        } else if(issubstr(var_03.script_noteworthy, "light_off")) {
          if(!isDefined(var_00.lights_off)) {
            var_00.lights_off = [];
          }

          var_03 hide();
          var_00.lights_off[var_00.lights_off.size] = var_03;
        } else {}
      } else if(var_03.spawnimpulsefield & 2) {
        if(!isDefined(var_00.var_19E5)) {
          var_00.var_19E5 = [];
        }

        var_03 notsolid();
        var_03 hide();
        var_03 _meth_829D(0);
        var_00.var_19E5[var_00.var_19E5.size] = var_03;
      } else {
        var_00.doors[var_00.doors.size] = var_03;
      }

      continue;
    }

    if(var_03.classname == "script_origin") {
      var_00.entsound = var_03;
    }
  }

  if(!isDefined(var_00.entsound) && var_00.doors.size) {
    var_00.entsound = sortbydistance(var_00.doors, var_00.origin)[0];
  }

  foreach(var_07 in var_00.doors) {
    var_07.var_D6A4 = var_07.origin;
    var_07.var_D6AE = scripts\engine\utility::getstruct(var_07.target, "targetname").origin;
    var_07.var_5717 = distance(var_07.var_D6AE, var_07.var_D6A4);
    var_07.origin = var_07.var_D6AE;
    var_07.var_C001 = 0;
    if(isDefined(var_07.script_parameters)) {
      var_07 func_59BD(var_07.script_parameters);
    }
  }
}

door_think() {
  var_00 = self;
  var_00 door_state_change(2, 1);
  for(;;) {
    var_00.var_10E27 = undefined;
    var_00.var_10E29 = undefined;
    var_00 scripts\engine\utility::waittill_any_3("door_state_done", "door_state_interrupted");
    if(isDefined(var_00.var_10E27) && var_00.var_10E27) {
      var_01 = var_00 door_state_next(var_00.statecurr);
      var_00 door_state_change(var_01, 0);
      continue;
    }

    if(isDefined(var_00.var_10E29) && var_00.var_10E29) {
      var_00 door_state_change(4, 0);
      continue;
    }
  }
}

door_state_next(param_00) {
  var_01 = self;
  var_02 = undefined;
  if(param_00 == 0) {
    var_02 = 3;
  } else if(param_00 == 2) {
    var_02 = 1;
  } else if(param_00 == 1) {
    var_02 = 0;
  } else if(param_00 == 3) {
    var_02 = 2;
  } else if(param_00 == 4) {
    var_02 = var_01.stateprev;
  } else {}

  return var_02;
}

door_state_update(param_00) {
  var_01 = self;
  var_01 endon("door_state_interrupted");
  var_01.var_10E27 = undefined;
  if(var_01.statecurr == 0 || var_01.statecurr == 2) {
    if(!param_00) {
      foreach(var_03 in var_01.doors) {
        if(isDefined(var_03.var_11041)) {
          var_03 stoploopsound();
          var_03 playsoundonmovingent(var_03.var_11041);
        }
      }
    }

    if(isDefined(var_01.lights_on)) {
      foreach(var_06 in var_01.lights_on) {
        var_06 show();
      }
    }

    foreach(var_03 in var_01.doors) {
      if(var_01.statecurr == 0) {
        if(isDefined(var_01.var_19E5)) {
          foreach(var_0A in var_01.var_19E5) {
            var_0A show();
            var_0A _meth_829D(1);
          }
        }

        if(var_03.spawnimpulsefield & 1) {
          var_03 disconnectpaths();
        }
      } else {
        if(isDefined(var_01.var_19E5)) {
          foreach(var_0A in var_01.var_19E5) {
            var_0A hide();
            var_0A _meth_829D(0);
          }
        }

        if(var_03.spawnimpulsefield & 1) {
          if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "always_disconnect") {
            var_03 disconnectpaths();
          } else {
            var_03 connectpaths();
          }
        }
      }

      if(isDefined(var_03.script_noteworthy)) {
        if(var_03.script_noteworthy == "clockwise_wheel" || var_03.script_noteworthy == "counterclockwise_wheel") {
          var_03 rotatevelocity((0, 0, 0), 0.1);
        }
      }

      if(var_03.var_C001) {
        var_03.unresolved_collision_func = undefined;
      }
    }

    var_0F = scripts\engine\utility::ter_op(var_01.statecurr == 0, & "MP_DOOR_USE_OPEN", & "MP_DOOR_USE_CLOSE");
    var_01 sethintstring(var_0F);
    var_01 makeusable();
    var_01 waittill("trigger");
    if(isDefined(var_01.button_smash_count)) {
      var_01 playSound(var_01.button_smash_count);
    }
  } else if(var_01.statecurr == 1 || var_01.statecurr == 3) {
    if(isDefined(var_01.lights_off)) {
      foreach(var_06 in var_01.lights_off) {
        var_06 show();
      }
    }

    var_01 makeunusable();
    if(var_01.statecurr == 1) {
      var_01 thread door_state_on_interrupt();
      foreach(var_03 in var_01.doors) {
        if(isDefined(var_03.script_noteworthy)) {
          var_13 = scripts\engine\utility::ter_op(isDefined(var_01.var_5A17), var_01.var_5A17, 3);
          var_14 = scripts\engine\utility::ter_op(var_01.statecurr == 1, var_03.var_D6A4, var_03.var_D6AE);
          var_15 = distance(var_03.origin, var_14);
          var_16 = max(0.1, var_15 / var_03.var_5717 * var_13);
          var_17 = max(var_16 * 0.25, 0.05);
          var_18 = 360 * var_15 / 94.2;
          if(var_03.script_noteworthy == "clockwise_wheel") {
            var_03 rotatevelocity((0, 0, -1 * var_18 / var_16), var_16, var_17, var_17);
          } else if(var_03.script_noteworthy == "counterclockwise_wheel") {
            var_03 rotatevelocity((0, 0, var_18 / var_16), var_16, var_17, var_17);
          }
        }
      }
    } else if(var_01.statecurr == 3) {
      if(isDefined(var_01.var_C607) && var_01.var_C607) {
        var_01 thread door_state_on_interrupt();
      }

      foreach(var_03 in var_01.doors) {
        if(isDefined(var_03.script_noteworthy)) {
          var_13 = scripts\engine\utility::ter_op(isDefined(var_01.var_5A17), var_01.var_5A17, 3);
          var_14 = scripts\engine\utility::ter_op(var_01.statecurr == 1, var_03.var_D6A4, var_03.var_D6AE);
          var_15 = distance(var_03.origin, var_14);
          var_16 = max(0.1, var_15 / var_03.var_5717 * var_13);
          var_17 = max(var_16 * 0.25, 0.05);
          var_18 = 360 * var_15 / 94.2;
          if(var_03.script_noteworthy == "clockwise_wheel") {
            var_03 rotatevelocity((0, 0, var_18 / var_16), var_16, var_17, var_17);
          } else if(var_03.script_noteworthy == "counterclockwise_wheel") {
            var_03 rotatevelocity((0, 0, -1 * var_18 / var_16), var_16, var_17, var_17);
          }
        }
      }
    }

    wait(0.1);
    var_01 childthread func_59F1("garage_door_start", "garage_door_loop");
    var_13 = scripts\engine\utility::ter_op(isDefined(var_01.var_5A17), var_01.var_5A17, 3);
    var_1C = undefined;
    foreach(var_03 in var_01.doors) {
      var_14 = scripts\engine\utility::ter_op(var_01.statecurr == 1, var_03.var_D6A4, var_03.var_D6AE);
      if(var_03.origin != var_14) {
        var_16 = max(0.1, distance(var_03.origin, var_14) / var_03.var_5717 * var_13);
        var_17 = max(var_16 * 0.25, 0.05);
        var_03 moveto(var_14, var_16, var_17, var_17);
        var_03 scripts\mp\movers::notify_moving_platform_invalid();
        if(var_03.var_C001) {
          var_03.unresolved_collision_func = ::scripts\mp\movers::func_12BEE;
        }

        if(!isDefined(var_1C) || var_16 > var_1C) {
          var_1C = var_16;
        }
      }
    }

    if(isDefined(var_1C)) {
      wait(var_1C);
    }
  } else if(var_01.statecurr == 4) {
    foreach(var_03 in var_01.doors) {
      var_03 moveto(var_03.origin, 0.05, 0, 0);
      var_03 scripts\mp\movers::notify_moving_platform_invalid();
      if(var_03.var_C001) {
        var_03.unresolved_collision_func = undefined;
      }

      if(isDefined(var_03.script_noteworthy)) {
        if(var_03.script_noteworthy == "clockwise_wheel" || var_03.script_noteworthy == "counterclockwise_wheel") {
          var_03 rotatevelocity((0, 0, 0), 0.05);
        }
      }
    }

    if(isDefined(var_01.lights_off)) {
      foreach(var_06 in var_01.lights_off) {
        var_06 show();
      }
    }

    var_01.entsound stoploopsound();
    foreach(var_03 in var_01.doors) {
      if(isDefined(var_03.var_9A88)) {
        var_03 playSound(var_03.var_9A88);
      }
    }

    wait(1);
  } else {}

  var_01.var_10E27 = 1;
  foreach(var_03 in var_01.doors) {
    var_03.var_10E27 = 1;
  }

  var_01 notify("door_state_done");
}

func_59F1(param_00, param_01) {
  var_02 = self;
  var_03 = 1;
  var_04 = 1;
  var_05 = 0;
  if(var_02.statecurr == 3 || var_02.statecurr == 1) {
    foreach(var_07 in var_02.doors) {
      if(isDefined(var_07.var_10D2A)) {
        var_07 playsoundonmovingent(var_07.var_10D2A);
        var_05 = lookupsoundlength(var_07.var_10D2A) / 1000;
        var_03 = 0;
      }
    }

    if(var_03) {
      var_05 = lookupsoundlength(param_00) / 1000;
      playsoundatpos(var_02.entsound.origin, param_00);
    }
  }

  wait(var_05 * 0.3);
  if(var_02.statecurr == 3 || var_02.statecurr == 1) {
    foreach(var_07 in var_02.doors) {
      if(isDefined(var_07.loop_sound)) {
        if(var_07.loop_sound != "none") {
          var_07 playLoopSound(var_07.loop_sound);
        }

        var_04 = 0;
      }
    }

    if(var_04) {
      var_02.entsound playLoopSound(param_01);
    }
  }
}

door_state_change(param_00, param_01) {
  var_02 = self;
  if(isDefined(var_02.statecurr)) {
    door_state_exit(var_02.statecurr);
    var_02.stateprev = var_02.statecurr;
  }

  var_02.statecurr = param_00;
  var_02 thread door_state_update(param_01);
}

door_state_exit(param_00) {
  var_01 = self;
  if(param_00 == 0 || param_00 == 2) {
    if(isDefined(var_01.lights_on)) {
      foreach(var_03 in var_01.lights_on) {
        var_03 hide();
      }

      return;
    }

    return;
  }

  if(var_03 == 1 || var_03 == 3) {
    if(isDefined(var_04.lights_off)) {
      foreach(var_05 in var_04.lights_off) {
        var_05 hide();
      }
    }

    var_03.entsound stoploopsound();
    foreach(var_08 in var_03.doors) {
      if(isDefined(var_08.loop_sound)) {
        var_08 stoploopsound();
      }
    }

    return;
  }

  if(var_02 == 4) {
    return;
  }
}

door_state_on_interrupt() {
  var_00 = self;
  var_00 endon("door_state_done");
  var_01 = [];
  foreach(var_03 in var_00.var_12720) {
    if(var_00.statecurr == 1) {
      if(isDefined(var_03.not_closing) && var_03.not_closing == 1) {
        continue;
      }
    } else if(var_00.statecurr == 3) {
      if(isDefined(var_03.not_opening) && var_03.not_opening == 1) {
        continue;
      }
    }

    var_01[var_01.size] = var_03;
  }

  if(var_01.size > 0) {
    var_05 = var_00 waittill_any_triggered_return_triggerer(var_01);
    if(!isDefined(var_05.fauxdeath) || var_05.fauxdeath == 0) {
      var_00.var_10E29 = 1;
      var_00 notify("door_state_interrupted");
    }
  }
}

waittill_any_triggered_return_triggerer(param_00) {
  var_01 = self;
  foreach(var_03 in param_00) {
    var_01 thread return_triggerer(var_03);
  }

  var_01 waittill("interrupted");
  return var_01.interrupter;
}

return_triggerer(param_00) {
  var_01 = self;
  var_01 endon("door_state_done");
  var_01 endon("interrupted");
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(isDefined(param_00.prone_only) && param_00.prone_only == 1) {
      if(isplayer(var_02)) {
        var_03 = var_02 getstance();
        if(var_03 != "prone") {
          continue;
        } else {
          var_04 = vectornormalize(anglesToForward(var_02.angles));
          var_05 = vectornormalize(param_00.origin - var_02.origin);
          var_06 = vectordot(var_04, var_05);
          if(var_06 > 0) {
            continue;
          }
        }
      }
    }

    break;
  }

  var_01.interrupter = var_02;
  var_01 notify("interrupted");
}

button_parse_parameters(param_00) {
  var_01 = self;
  var_01.button_smash_count = undefined;
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  var_02 = strtok(param_00, ";");
  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "=");
    if(var_05.size != 2) {
      continue;
    }

    if(var_05[1] == "undefined" || var_05[1] == "default") {
      var_01.params[var_05[0]] = undefined;
      continue;
    }

    switch (var_05[0]) {
      case "open_interrupt":
        var_01.var_C607 = string_to_bool(var_05[1]);
        break;

      case "button_sound":
        var_01.button_smash_count = var_05[1];
        break;

      default:
        break;
    }
  }
}

func_59BD(param_00) {
  var_01 = self;
  var_01.var_10D2A = undefined;
  var_01.var_11041 = undefined;
  var_01.loop_sound = undefined;
  var_01.var_9A88 = undefined;
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  var_02 = strtok(param_00, ";");
  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "=");
    if(var_05.size != 2) {
      continue;
    }

    if(var_05[1] == "undefined" || var_05[1] == "default") {
      var_01.params[var_05[0]] = undefined;
      continue;
    }

    switch (var_05[0]) {
      case "stop_sound":
        var_01.var_11041 = var_05[1];
        break;

      case "interrupt_sound":
        var_01.var_9A88 = var_05[1];
        break;

      case "loop_sound":
        var_01.loop_sound = var_05[1];
        break;

      case "open_interrupt":
        var_01.var_C607 = string_to_bool(var_05[1]);
        break;

      case "start_sound":
        var_01.var_10D2A = var_05[1];
        break;

      case "unresolved_collision_nodes":
        var_01.unresolved_collision_nodes = getnodearray(var_05[1], "targetname");
        break;

      case "no_moving_unresolved_collisions":
        var_01.var_C001 = string_to_bool(var_05[1]);
        break;

      default:
        break;
    }
  }
}

trigger_parse_parameters(param_00) {
  var_01 = self;
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  var_02 = strtok(param_00, ";");
  foreach(var_04 in var_02) {
    var_05 = strtok(var_04, "=");
    if(var_05.size != 2) {
      continue;
    }

    if(var_05[1] == "undefined" || var_05[1] == "default") {
      var_01.params[var_05[0]] = undefined;
      continue;
    }

    switch (var_05[0]) {
      case "not_opening":
        var_01.not_opening = string_to_bool(var_05[1]);
        break;

      case "not_closing":
        var_01.not_closing = string_to_bool(var_05[1]);
        break;

      case "prone_only":
        var_01.prone_only = string_to_bool(var_05[1]);
        break;

      default:
        break;
    }
  }
}

string_to_bool(param_00) {
  var_01 = undefined;
  switch (param_00) {
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