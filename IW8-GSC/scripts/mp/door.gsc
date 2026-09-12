/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\door.gsc
***********************************************/

function door_dynamic_setup(var_0) {
  if(isDefined(level.doors)) {
    return;
  }

  setDvar("cg_buttonHintNaturalDistance", 150);
  level.doors = [];
  level.doorsetupstarted = 0;
  thread door_dynamic_setup_adapter("dynamic_door", 0);
  thread door_dynamic_setup_adapter("lean_dynamic_door", 1, var_0);
  script_model_anims();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function door_dynamic_setup_adapter(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");
  level.doorsetupstarted++;
  level.doorsetupfinished = 0;
  var_4 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip", "physicscontents_item"];
  var_5 = physics_createcontents(var_4);
  level.doorcontentoverride = var_5;

  foreach(var_7 in var_3) {
    if(isDefined(var_7.script_parameters)) {
      door_dynamic_parse_parameters(var_7, var_7.script_parameters);
    }

    var_7.doors = [];
    var_7.doors[0] = var_7;
    var_7.islean = var_1;
    var_7.baseangles = var_7.angles;

    if(var_7.baseangles[1] == 360) {
      var_7.baseangles = (var_7.baseangles[0], 0, var_7.baseangles[2]);
    }

    var_7.state = 0;
    var_8 = var_7.target;
    var_9 = isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "OPEN" || getdvarint("scr_doors_open", 0) != 0;
    var_10 = isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "LOCKED";
    var_7.length = 52;
    var_7.height = 96;
    var_7.leftplantorg = var_7.origin + anglesToForward(var_7.angles) * var_7.length * 0.5 + anglestoright(var_7.angles) * -24.5;
    var_7.leftplantang = (0, var_7.baseangles[1] - 90, 0);
    var_7.rightplantorg = var_7.origin + anglesToForward(var_7.angles) * var_7.length * 0.5 + anglestoright(var_7.angles) * 24.5;
    var_7.rightplantang = (0, var_7.baseangles[1] + 90, 0);
    var_7.doorcenter = var_7.origin + anglesToForward(var_7.angles) * var_7.length * 0.5 + anglestoup(var_7.angles) * var_7.height * 0.5;
    var_7.max_yaw_left = 90;
    var_7.max_yaw_right = 90;
    var_11 = var_7 gettagorigin("tag_door_handle", 1);

    if(isDefined(var_11)) {
      var_7 scripts\mp\gameobjects::sethintobject("tag_door_handle", "HINT_BUTTON", undefined, &"MP/DOOR_USE_OPEN_DOUBLE", undefined, "duration_none", undefined, 200, 90, 72, 90);
      var_7.useprompt = var_7;
      var_7.useprompt setusewhenhandsoccupied(1);

      if(!var_1 && scripts\mp\utility\game::getgametype() != "br") {
        var_7.lockprompt = scripts\mp\gameobjects::createhintobject(var_11, "HINT_BUTTON", undefined, &"MP/DOOR_USE_LOCK", undefined, undefined, "show", 200, 90, 72, 90);
        var_7.lockprompt linkTo(var_7, "tag_door_handle", (3, 0, 15), (0, 0, 0));
        var_7.lockprompt setusewhenhandsoccupied(1);
        var_7.alarmprompts = [];
        var_12 = [(4, 0, 4), (4, 0, 90)];

        foreach(var_14 in var_12) {
          var_15 = scripts\mp\gameobjects::createhintobject(var_11, "HINT_BUTTON", undefined, &"MP/DOOR_USE_ALARM", undefined, undefined, "show", 100, 90, 80, 20);
          var_15 linkTo(var_7, "tag_origin", var_14, (0, 0, 0));
          var_15 setusewhenhandsoccupied(0);
          var_16 = var_15 getentitynumber();
          var_7.alarmprompts[var_16] = var_15;
        }

        var_18 = getEnt(var_8, "targetname");

        if(isDefined(var_18)) {
          var_7.clipent = var_18;
          var_7.clipent linkTo(var_7);
          var_7.clipent.unresolved_collision_func = &scripts\mp\movers::unresolved_collision_void;
          var_7.clipent connectpaths();

          if(isDefined(var_18.target)) {
            var_19 = getEnt(var_18.target, "targetname");
            var_7.audioportalent = var_19;
          }
        }
      }

      if(var_9) {
        thread changestate(var_7);
        var_7.angles = (var_7.angles[0], var_7.angles[1] + 90, var_7.angles[2]);
      } else if(var_10) {
        thread changestate(var_7);
      } else {
        thread changestate(var_7);
      }
    }

    level.doors[level.doors.size] = var_7;
    waitframe();
  }

  if(!var_1) {
    thread amortizeyawtraces();

    foreach(var_7 in level.doors) {
      thread get_max_yaws();
    }

    thread linkdoubledoors();
  }

  level.doorsetupstarted--;
  level.doorsetupfinished = level.doorsetupstarted == 0;
}

function door_dynamic_setup_post_init() {
  waitframe();

  if(getdvarint("scr_doors_open", 0) != 0) {
    foreach(var_1 in level.doors) {
      var_1.statecurr = 2;
      var_1.angles = var_1.doortarget.angles;
    }

    return;
  }
}

function triggerlisten(var_0) {
  self notify("disableTrigger");
  self endon("disableTrigger");
  level endon("game_ended");
  jumpiffalse(!var_0.islean && var_0.statecurr == 0) LOC_00000037;
  thread bashmonitor();
  self waittill("trigger", var_1);
  self makeunusable();
  var_2 = var_0.doortarget;

  if(isDefined(var_0.doortargetccw)) {
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectorcross((0, 0, 1), var_3);
    var_5 = anglesToForward((0, var_1.angles[1], 0));

    if(vectordot(var_5, var_4) < 0) {
      var_2 = var_0.doortargetccw;
    }
  }

  var_6 = 0.666;

  if(var_0.statecurr == 0) {
    self notify("stop_bash_monitor");
    var_0.statecurr = 3;
    var_0 rotateTo(var_2.angles, var_6, 0, 0.333);
    var_7 = &"MP/DOOR_USE_CLOSE";
  } else {
    var_0.statecurr = 1;
    var_0 rotateTo(var_0.baseangles, var_6, 0, 0.333);
    var_7 = &"MP/DOOR_USE_OPEN";
  }

  var_0 scripts\mp\events::doorused(var_1, var_0.statecurr == 3);
  wait 0.1;
  GscBinSkip4(0x6e, var_0, var_0);
}

function door_dynamic_parse_parameters(var_0) {
  var_1 = self;
  var_1.button_sound = undefined;

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
        var_1.stop_sound = var_5[1];
        break;
      case "interrupt_sound":
        var_1.interrupt_sound = var_5[1];
        break;
      case "loop_sound":
        var_1.loop_sound = var_5[1];
        break;
      case "open_interrupt":
        var_1.open_interrupt = string_to_bool(var_5[1]);
        break;
      case "start_sound":
        var_1.start_sound = var_5[1];
        break;
      case "material":
        var_1.material = var_5[1];
        break;
    }
  }
}

function door_system_init(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters)) {
      button_parse_parameters(var_3, var_3.script_parameters);
    }

    door_setup(var_3);
  }

  foreach(var_3 in var_1) {
    thread door_think();
  }
}

function door_setup() {
  var_0 = self;
  var_0.doors = [];
  var_0.hasbeenused = 0;

  if(isDefined(var_0.script_index)) {
    var_0.doormovetime = max(0.1, float(var_0.script_index) / 1000);
  }

  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(issubstr(var_3.classname, "trigger")) {
      if(!isDefined(var_0.trigblock)) {
        var_0.trigblock = [];
      }

      if(isDefined(var_3.script_parameters)) {
        trigger_parse_parameters(var_3, var_3.script_parameters);
      }

      if(isDefined(var_3.script_linkto)) {
        var_4 = getEnt(var_3.script_linkto, "script_linkname");
        var_3 enablelinkTo();
        var_3 linkTo(var_4);
      }

      var_0.trigblock[var_0.trigblock.size] = var_3;
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
      } else if(var_3.spawnflags & 2) {
        if(!isDefined(var_0.ai_sight_brushes)) {
          var_0.ai_sight_brushes = [];
        }

        var_3 notsolid();
        var_3 hide();
        var_0.ai_sight_brushes[var_0.ai_sight_brushes.size] = var_3;
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
    var_7.posclosed = var_7.origin;
    var_7.posopen = scripts\engine\utility::getStruct(var_7.target, "targetname").origin;
    var_7.distmove = distance(var_7.posopen, var_7.posclosed);
    var_7.no_moving_unresolved_collisions = 0;

    if(!istrue(var_0.start_closed)) {
      var_7.origin = var_7.posopen;
    }

    if(isDefined(var_7.script_parameters)) {
      door_parse_parameters(var_7, var_7.script_parameters);
    }
  }
}

function door_think() {
  var_0 = self;
  var_1 = scripts\engine\utility::ter_op(istrue(var_0.start_closed), 0, 2);
  door_state_change(var_0, var_1, 1);

  for(;;) {
    var_0.statedone = undefined;
    var_0.stateinterrupted = undefined;
    var_0 scripts\engine\utility::ref_143a5("door_state_done", "door_state_interrupted");

    if(isDefined(var_0.statedone) && var_0.statedone) {
      var_2 = door_state_next(var_0, var_0.statecurr);
      door_state_change(var_0, var_2, 0);
      continue;
    }

    if(isDefined(var_0.stateinterrupted) && var_0.stateinterrupted) {
      door_state_change(var_0, 4, 0);
    }
  }
}

function door_state_next(var_0) {
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

function door_state_update(var_0) {
  var_1 = self;
  var_1 endon("door_state_interrupted");
  var_1.statedone = undefined;

  if(var_1.statecurr == 0 || var_1.statecurr == 2) {
    if(!var_0) {
      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.stop_sound)) {
          var_3 stoploopsound();
          var_3 playsoundonmovingent(var_3.stop_sound);
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
        if(isDefined(var_1.ai_sight_brushes)) {
          foreach(var_10 in var_1.ai_sight_brushes) {
            var_10 show();
          }
        }

        if(var_3.spawnflags & 1) {}
      } else {
        if(isDefined(var_1.ai_sight_brushes)) {
          foreach(var_10 in var_1.ai_sight_brushes) {
            var_10 hide();
          }
        }

        if(var_3.spawnflags & 1) {
          if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "always_disconnect") {}
        }
      }

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "clockwise_wheel" || var_3.script_noteworthy == "counterclockwise_wheel") {
          var_3 rotatevelocity((0, 0, 0), 0.1);
        }
      }

      if(var_3.no_moving_unresolved_collisions) {
        var_3.unresolved_collision_func = undefined;
      }
    }

    var_15 = !istrue(var_1.one_time_use) || !var_1.hasbeenused;

    if(var_15) {
      var_16 = scripts\engine\utility::ter_op(var_1.statecurr == 0, &"MP/DOOR_USE_OPEN", &"MP/DOOR_USE_CLOSE");

      if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var_1 setHintString(var_16);
      }

      var_1 makeusable();
      var_1 waittill("trigger");

      if(isDefined(var_1.button_sound)) {
        var_1 playSound(var_1.button_sound);
      }

      var_1.hasbeenused = 1;
    } else {
      var_1 waittill("forever");
    }
  } else {
    if(var_1.statecurr == 1 || var_1.statecurr == 3) {
      if(isDefined(var_1.lights_off)) {
        foreach(var_6 in var_1.lights_off) {
          var_6 show();
        }
      }

      var_1 makeunusable();

      if(var_1.statecurr == 1) {
        thread door_state_on_interrupt();

        foreach(var_3 in var_1.doors) {
          if(isDefined(var_3.script_noteworthy)) {
            var_20 = scripts\engine\utility::ter_op(isDefined(var_1.doormovetime), var_1.doormovetime, 3);
            var_21 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.posclosed, var_3.posopen);
            var_22 = distance(var_3.origin, var_21);
            var_23 = max(0.1, var_22 / var_3.distmove * var_20);
            var_24 = max(var_23 * 0.25, 0.05);
            var_25 = 360 * var_22 / 94.2;

            if(var_3.script_noteworthy == "clockwise_wheel") {
              var_3 rotatevelocity((0, 0, -1 * var_25 / var_23), var_23, var_24, var_24);
            } else if(var_3.script_noteworthy == "counterclockwise_wheel") {
              var_3 rotatevelocity((0, 0, var_25 / var_23), var_23, var_24, var_24);
            }
          }
        }
      } else if(var_1.statecurr == 3) {
        if(isDefined(var_1.open_interrupt) && var_1.open_interrupt) {
          thread door_state_on_interrupt();
        }

        foreach(var_3 in var_1.doors) {
          if(isDefined(var_3.script_noteworthy)) {
            var_20 = scripts\engine\utility::ter_op(isDefined(var_1.doormovetime), var_1.doormovetime, 3);
            var_21 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.posclosed, var_3.posopen);
            var_22 = distance(var_3.origin, var_21);
            var_23 = max(0.1, var_22 / var_3.distmove * var_20);
            var_24 = max(var_23 * 0.25, 0.05);
            var_25 = 360 * var_22 / 94.2;

            if(var_3.script_noteworthy == "clockwise_wheel") {
              var_3 rotatevelocity((0, 0, var_25 / var_23), var_23, var_24, var_24);
            } else if(var_3.script_noteworthy == "counterclockwise_wheel") {
              var_3 rotatevelocity((0, 0, -1 * var_25 / var_23), var_23, var_24, var_24);
            }
          }
        }
      }

      wait 0.1;
      GscBinSkip4(0x6e, var_1, var_1, var_1);
    }

    if(var_1.statecurr == 4) {
      foreach(var_3 in var_1.doors) {
        var_3 moveTo(var_3.origin, 0.05, 0, 0);
        var_3 scripts\mp\movers::notify_moving_platform_invalid();

        if(var_3.no_moving_unresolved_collisions) {
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
        if(isDefined(var_3.interrupt_sound)) {
          var_3 playSound(var_3.interrupt_sound);
        }
      }

      wait 1;
    }
  }

  var_1.statedone = 1;

  foreach(var_3 in var_1.doors) {
    var_3.statedone = 1;
  }

  var_1 notify("door_state_done");
}

function door_state_update_sound() {
  var_0 = self;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0;

  if(var_0.statecurr == 3 || var_0.statecurr == 1) {
    foreach(var_5 in var_0.doors) {
      if(isDefined(var_5.start_sound)) {
        var_5 playsoundonmovingent(var_5.start_sound);
        var_3 = lookupsoundlength(var_5.start_sound) / 1000;
        var_1 = 0;
      }
    }

    if(var_1) {
      if(!isDefined(var_0.entsound)) {
        var_0.entsound = var_0;
      }

      if(var_0.statecurr == 3) {
        if(soundexists("scrpt_door_wood_double_open")) {
          var_3 = lookupsoundlength("scrpt_door_wood_double_open") / 1000;
          playsoundatpos(var_0.entsound.origin, "scrpt_door_wood_double_open");
        }
      } else if(var_0.statecurr == 1) {
        if(soundexists("scrpt_door_wood_double_close")) {
          var_3 = lookupsoundlength("scrpt_door_wood_double_close") / 1000;
          playsoundatpos(var_0.entsound.origin, "scrpt_door_wood_double_close");
        }
      }
    }
  }

  wait var_3 * 0.3;

  if(var_0.statecurr == 3 || var_0.statecurr == 1) {
    foreach(var_5 in var_0.doors) {
      if(isDefined(var_5.loop_sound)) {
        if(var_5.loop_sound != "none") {
          var_5 playLoopSound(var_5.loop_sound);
        }

        var_2 = 0;
      }
    }

    if(var_2) {
      if(soundexists("")) {
        var_0.entsound playLoopSound("");
        return;
      }

      return;
    }

    return;
  }
}

function door_state_change(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2.statecurr)) {
    door_state_exit(var_2.statecurr);
    var_2.stateprev = var_2.statecurr;
  }

  var_2.statecurr = var_0;
  thread door_state_update(var_2);
}

function door_state_exit(var_0) {
  var_1 = self;

  if(var_0 == 0 || var_0 == 2) {
    if(isDefined(var_1.lights_on)) {
      foreach(var_4, var_3 in var_1.lights_on) {
        var_3 hide();
      }

      return;
    }

    return;
  }

  if(var_3 == 1 || var_3 == 3) {
    if(isDefined(var_4.lights_off)) {
      foreach(var_3 in var_4.lights_off) {
        var_3 hide();
      }
    }

    var_4.entsound stoploopsound();

    foreach(var_8 in var_4.doors) {
      if(isDefined(var_8.loop_sound)) {
        var_8 stoploopsound();
      }
    }

    return;
  }

  if(var_3 == 4) {
    return;
  }
}

function door_state_on_interrupt() {
  var_0 = self;
  var_0 endon("door_state_done");

  if(!isDefined(var_0.trigblock)) {
    return;
  }

  var_1 = [];

  foreach(var_3 in var_0.trigblock) {
    if(var_0.statecurr == 1) {
      if(isDefined(var_3.not_closing) && var_3.not_closing == 1) {
        continue;
      }
    } else if(var_0.statecurr == 3) {
      if(isDefined(var_3.not_opening) && var_3.not_opening == 1) {
        continue;
      }
    }

    var_1 = var_3;
  }

  if(var_1.size > 0) {
    var_5 = waittill_any_triggered_return_triggerer(var_0, var_1);

    if(!isDefined(var_5.fauxdead) || var_5.fauxdead == 0) {
      var_0.stateinterrupted = 1;
      var_0 notify("door_state_interrupted");
      return;
    }

    return;
  }
}

function waittill_any_triggered_return_triggerer(var_0) {
  var_1 = self;

  foreach(var_3 in var_0) {
    thread return_triggerer(var_1);
  }

  var_1 waittill("interrupted");
  return var_1.interrupter;
}

function return_triggerer(var_0) {
  var_1 = self;
  var_1 endon("door_state_done");
  var_1 endon("interrupted");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isDefined(var_0.prone_only) && var_0.prone_only == 1) {
      if(isPlayer(var_2)) {
        var_3 = var_2 getstance();

        if(var_3 != "prone") {
          continue;
        } else {
          var_4 = vectorNormalize(anglesToForward(var_2.angles));
          var_5 = vectorNormalize(var_0.origin - var_2.origin);
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

function button_parse_parameters(var_0) {
  var_1 = self;
  var_1.button_sound = undefined;

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
        var_1.open_interrupt = string_to_bool(var_5[1]);
        break;
      case "button_sound":
        var_1.button_sound = var_5[1];
        break;
      case "start_closed":
        var_1.start_closed = string_to_bool(var_5[1]);
        break;
      case "one_time_use":
        var_1.one_time_use = string_to_bool(var_5[1]);
        break;
      default:
        break;
    }
  }
}

function door_parse_parameters(var_0) {
  var_1 = self;
  var_1.start_sound = undefined;
  var_1.stop_sound = undefined;
  var_1.loop_sound = undefined;
  var_1.interrupt_sound = undefined;

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
        var_1.stop_sound = var_5[1];
        break;
      case "interrupt_sound":
        var_1.interrupt_sound = var_5[1];
        break;
      case "loop_sound":
        var_1.loop_sound = var_5[1];
        break;
      case "open_interrupt":
        var_1.open_interrupt = string_to_bool(var_5[1]);
        break;
      case "start_sound":
        var_1.start_sound = var_5[1];
        break;
      case "unresolved_collision_nodes":
        var_1.unresolved_collision_nodes = getnodearray(var_5[1], "targetname");
        break;
      case "no_moving_unresolved_collisions":
        var_1.no_moving_unresolved_collisions = string_to_bool(var_5[1]);
        break;
      case "material":
        var_1.material = var_5[1];
        break;
      default:
        break;
    }
  }
}

function trigger_parse_parameters(var_0) {
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

function string_to_bool(var_0) {
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

function bashmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  self endon("stateChanged");
  self notify("bashMonitor");
  self endon("bashMonitor");
  thread monitordamage();

  for(;;) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(bashproxcheck(var_2) && shouldbashopen(var_2)) {
          thread bashopen(var_2, var_2.origin);
        }
      }

      waitframe();
      continue;
    }

    wait 0.1;
  }
}

function bashproxcheck(var_0) {
  var_1 = distancesquared(var_0.origin, self.doorcenter);
  var_2 = 4900;
  return var_1 < var_2;
}

function shouldbashopen(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return false;
  }

  var_1 = anglesToForward(var_0.angles);

  if(scripts\engine\utility::within_fov(var_0.origin + var_1 * -45, var_0.angles, self.doorcenter, cos(43))) {
    var_2 = anglestoright(self.angles);
    var_3 = vectorNormalize(self.doorcenter - var_0 getEye());
    var_4 = vectordot(var_1, var_3);
    var_5 = vectordot(var_1, var_2);
    var_6 = var_0 getvelocity();
    var_7 = vectordot(vectorNormalize(var_6), (0, 0, 1));

    if((length(var_6) >= 200 || var_0 scripts\mp\utility\killstreak::isjuggernaut() && length(var_6) >= 140) && abs(var_7) < 0.75 && abs(var_5) > 0.75 && var_4 > 0.75) {
      var_8 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(var_8)) {
        var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_8, var_0, level.doorcontentoverride, 0);

        if(isDefined(var_9["entity"]) && var_9["entity"] == self) {
          return true;
        }
      } else {
        return true;
      }
    }
  }

  return false;
}

function bashopen(var_0, var_1) {
  thread checktriggeralarm(var_0);
  thread changestate(5);

  if(istrue(self.bashed)) {
    return;
  }

  if(!isDefined(self.useprompt)) {
    self.bashed = 1;
  }

  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglestoright(var_3);
  var_5 = vectorNormalize(var_1 - self.origin);
  var_6 = vectordot(var_4, var_5);
  var_7 = var_6 > 0;
  var_8 = undefined;

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isai(var_0)) {
      thread bashpresentation(var_0);
    } else {
      self notify("ai_opened");
    }
  }

  if(isDefined(self.material)) {
    if(self.material == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    } else if(self.material == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_bash");
    }
  } else {
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");
  }

  if(var_7) {
    var_8 = self.baseangles[1] + self.max_yaw_left;
  } else {
    var_8 = self.baseangles[1] - self.max_yaw_right;
  }

  if(var_8 > 360) {
    var_8 -= 360;
  } else if(var_8 < 0) {
    var_8 += 360;
  }

  var_9 = 0.35;
  var_10 = 0.15;
  var_11 = scripts\engine\math::normalize_value(0, 170, var_8);
  var_12 = scripts\engine\math::factor_value(var_9, var_10, var_11);
  var_13 = self.angles;
  var_14 = var_13[1];

  if(var_14 > 360) {
    var_14 -= 360;
  } else if(var_14 < 0) {
    var_14 += 360;
  }

  var_15 = angle_diff(var_14, self.baseangles[1]);
  var_16 = angle_diff(var_8, self.baseangles[1]);
  var_17 = anglesToForward(var_13);
  var_18 = anglestoright(self.baseangles);
  var_19 = vectordot(var_17, var_18) < 0;

  if(var_7) {
    if(!var_19) {
      var_16 += var_15;
    } else {
      var_16 -= var_15;
    }
  } else {
    if(var_19) {
      var_16 += var_15;
    } else {
      var_16 -= var_15;
    }

    var_16 *= -1;
  }

  var_20 = (0, var_16, 0);
  self rotateby(var_20, var_12);
  wait var_12;
  self.lastpushtime = gettime();
  thread changestate(6);

  if(!isDefined(self.useprompt)) {
    self.statecurr = 2;

    if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      self.trigger setHintString(&"MP/DOOR_USE_CLOSE");
    }
  }

  self.bashed = 0;
  var_21 = randomfloatrange(3, 5);
  var_22 = randomfloatrange(0.25, 2.5);

  if(var_7) {
    var_22 *= -1;
  }

  self rotateYaw(var_22, var_21, 0.5, var_21 - 0.5);
}

function bashpresentation(var_0) {
  var_0 playRumbleOnEntity("grenade_rumble");
  var_0 earthquakeforplayer(0.35, 0.5, var_0.origin, 200);
}

function monitordamage() {
  self endon("stateChanged");
  self notify("monitorDamage");
  self endon("monitorDamage");
  self setCanDamage(1);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_13, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isDefined(var_3)) {
      if(var_3 == "MOD_MELEE") {
        if(istrue(self.issaloonstyle)) {
          thread bashopen(self.otherdoor, var_1);
        }

        thread bashopen(var_1, var_1.origin);
        continue;
      }

      if(var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE") {
        var_14 = isDefined(var_8) && isDefined(var_8.basename) && (var_8.basename == "molotov_mp" || var_8.basename == "thermite_mp" || var_8.basename == "thermite_ap_mp" || var_8.basename == "thermite_av_mp");

        if(var_0 > 10 && !var_14) {
          thread bashopen(var_12, var_13);
        }

        continue;
      }

      if(isDefined(var_8) && var_8.basename == "pac_sentry_turret_mp" && (var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH")) {
        thread bashopen(var_12, var_13);
      }
    }
  }
}

function openmonitor() {
  self endon("stateChanged");

  if(self.state == 7 || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(self.islean || 0 || true) {
    if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      self.useprompt setHintString(&"MP/DOOR_USE_OPEN");
    }
  } else if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    self.useprompt setHintString(&"MP/DOOR_USE_OPEN_DOUBLE");
  }

  self.useprompt sethintdisplayrange(200);

  for(;;) {
    self.useprompt waittill("trigger_progress", var_0);

    if(var_0 meleeButtonPressed()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_1 = 0;

    while(var_1 < 0.1) {
      if(!var_0 useButtonPressed()) {
        break;
      }

      var_1 += level.framedurationseconds;
      waitframe();
    }

    if(self.state == 7) {
      var_2 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(var_2)) {
        playsoundatpos(var_2, "door_locked");
      } else {
        playsoundatpos(self.origin + (0, 0, 42), "door_locked");
      }

      continue;
    }

    if(self.islean) {
      thread cheapopen(var_0);
      return;
    }

    if(1 && var_0 playerads() > 0.9) {
      thread ajar(var_0);
      return;
    }

    thread cheapopen(var_0);
  }
}

function cheapopen(var_0) {
  thread checktriggeralarm(var_0);
  var_1 = self.useprompt.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectorNormalize(var_0.origin - var_1);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;

  if(isDefined(self.material)) {
    if(self.material == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_open");
    } else if(self.material == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_open");
    }
  } else {
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_open");
  }

  thread changestate(3);
  var_7 = scripts\engine\utility::ter_op(var_6, self.max_yaw_left, self.max_yaw_right * -1);
  var_8 = (self.baseangles[0], self.baseangles[1] + var_7, self.baseangles[2]);
  self rotateTo(var_8, 0.666, 0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    var_7 = scripts\engine\utility::ter_op(!var_6, self.otherdoor.max_yaw_left, self.otherdoor.max_yaw_right * -1);
    var_8 = (self.otherdoor.baseangles[0], self.otherdoor.baseangles[1] + var_7, self.otherdoor.baseangles[2]);
    self.otherdoor rotateTo(var_8, 0.666, 0, 0.333);
  }

  wait 0.666;
  self.lastpushtime = gettime();
  thread changestate(2);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    thread changestate(self.otherdoor);
    return;
  }
}

function ajar(var_0) {
  thread checktriggeralarm(var_0);
  thread changestate(6);
  var_1 = self.useprompt.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectorNormalize(var_0.origin - var_1);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;
  var_7 = 0.5;
  var_8 = scripts\engine\utility::ter_op(var_6, 15, -15);
  var_0 playRumbleOnEntity("damage_heavy");

  if(isDefined(self.material)) {
    if(self.material == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_start_peek");
    } else if(self.material == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_start_peek");
    }
  } else {
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_start_peek");
  }

  self rotateYaw(var_8, var_7, var_7 * 0.25, var_7 * 0.75);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    thread changestate(self.otherdoor);
    var_8 = scripts\engine\utility::ter_op(!var_6, 15, -15);
    self.otherdoor rotateYaw(var_8, var_7, var_7 * 0.25, var_7 * 0.75);
  }

  self.lastpushtime = gettime();
}

function pushmonitor() {
  if(self.islean) {
    return;
  }

  self endon("stateChanged");
  self notify("pushMonitor");
  self endon("pushMonitor");
  wait 0.5;

  for(;;) {
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(pushproxcheck(var_2)) {
          push(var_2);
          self.lastpushtime = gettime();
          door_destroynavobstacle();
        }
      }
    }

    if(isDefined(self.lastpushtime) && gettime() > self.lastpushtime + 2000) {
      door_createnavobstacle();
    }

    waitframe();
  }
}

function pushproxcheck(var_0) {
  self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  if(var_0.origin[2] > self.origin[2] + self.height || var_0.origin[2] + 70 < self.origin[2]) {
    return false;
  }

  var_1 = distance2dsquared(var_0.origin, self.doorcenter);
  var_2 = 900;
  return var_1 < var_2;
}

function push(var_0) {
  var_1 = 26;
  var_2 = 0;
  var_3 = 25;
  var_4 = self.origin + anglesToForward(self.angles) * 28;
  var_5 = distance2d(var_0.origin, var_4);
  var_6 = scripts\engine\math::normalize_value(var_2, var_1, var_5);
  var_7 = var_3 * (1 - var_6);

  if(var_7 == 0) {
    return;
  }

  var_8 = self.useprompt.origin;
  var_9 = self.angles;
  var_10 = anglestoright(var_9);
  var_11 = vectorNormalize(var_0.origin - var_8);
  var_12 = vectordot(var_10, var_11);
  var_13 = var_12 > 0;
  var_14 = self.angles[1];
  var_15 = scripts\engine\utility::ter_op(var_13 == 1, 1, -1);
  var_16 = var_14 + var_7 * var_15;
  var_17 = angle_diff(var_16, self.baseangles[1]);

  if(var_13) {
    if(var_17 > self.max_yaw_left) {
      self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
      self.angles = (self.angles[0], self.baseangles[1] + self.max_yaw_left, self.angles[2]);
      return;
    }
  } else if(var_17 > self.max_yaw_right) {
    self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
    self.angles = (self.angles[0], self.baseangles[1] - self.max_yaw_right, self.angles[2]);
    return;
  }

  self.angles = (self.angles[0], var_16, self.angles[2]);
}

function autoclosemonitor() {
  if(self.islean) {
    return;
  }

  self endon("stateChanged");
  self notify("autoCloseMonitor");
  self endon("autoCloseMonitor");
  wait 0.5;

  for(;;) {
    if(angle_diff(self.angles[1], self.baseangles[1]) < 40) {
      if(isDefined(self.lastpushtime) && gettime() > self.lastpushtime + 3000) {
        var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

        if(var_0.size == 0) {
          thread closedoor(1);
        }
      }
    }

    waitframe();
  }
}

function changestate(var_0) {
  if(!isDefined(self.useprompt)) {
    return;
  }

  switch (self.state) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      if(isDefined(self.useprompt)) {
        self.useprompt sethinticon("icon_door_unlocked");
      }

      break;
    case 8:
      break;
  }

  self.state = var_0;
  self notify("stateChanged");

  switch (var_0) {
    case 0:
      door_destroynavobstacle();
      door_disableaudioportal();
      thread openmonitor();
      thread bashmonitor();
      thread lockmonitor();
      thread alarmmonitor();
      thread ajarmonitor();
      break;
    case 1:
      door_destroynavobstacle();
      break;
    case 2:
      door_createnavobstacle();
      door_enableaudioportal();
      thread closemonitor();
      thread bashmonitor();
      break;
    case 3:
      door_destroynavobstacle();
      door_enableaudioportal();
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      door_enableaudioportal();
      thread closemonitor();
      thread pushmonitor();
      thread bashmonitor();
      thread autoclosemonitor();
      break;
    case 7:
      if(isDefined(self.useprompt)) {
        self.useprompt sethintdisplayrange(300);
        self.useprompt sethinticon("icon_door_locked");
        self.useprompt setHintString(&"MP/DOOR_USE_LOCKED");
      }

      thread openmonitor();
      thread breachmonitor();
      break;
    case 8:
      thread openmonitor();
      thread bashmonitor();
      thread removealarmmonitor();
      thread disownalarmmonitor();
      break;
  }

  thread updatelockpromptvisibility();
  thread updatealarmpromptvisibility();

  if(isDefined(self.otherdoor)) {
    thread updatealarmpromptvisibility();
    return;
  }
}

function updatestate() {
  switch (self.state) {
    default:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      break;
    case 8:
      break;
  }
}

function closemonitor() {
  self endon("stateChanged");

  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    self.useprompt setHintString(&"MP/DOOR_USE_CLOSE");
  }

  self.useprompt sethintdisplayrange(200);
  self.useprompt sethintdisplayfov(120);
  self.useprompt setuserange(125);
  self.useprompt setusefov(120);
  self.useprompt makeusable();

  for(;;) {
    self.useprompt waittill("trigger_progress", var_0);

    if(var_0 meleeButtonPressed()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var_1 = 0;

    while(var_1 < 0.1) {
      if(!var_0 useButtonPressed()) {
        break;
      }

      var_1 += level.framedurationseconds;
      waitframe();
    }

    thread closedoor();
  }
}

function closedoor(var_0) {
  if(isDefined(self.material)) {
    if(self.material == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_close");
    } else if(self.material == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_close");
    }
  } else {
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_close");
  }

  thread changestate(1);
  var_1 = 0.666;

  if(istrue(var_0)) {
    var_1 *= 3;
  }

  self rotateTo(self.baseangles, var_1, 0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    self.otherdoor rotateTo(self.otherdoor.baseangles, var_1, 0, 0.333);
  }

  wait var_1;
  waitframe();

  if(angle_diff(self.angles[1], self.baseangles[1]) < 1) {
    thread changestate(0);
  } else {
    thread changestate(6);
  }

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    if(angle_diff(self.otherdoor.angles[1], self.otherdoor.baseangles[1]) < 1) {
      thread changestate(self.otherdoor);
      return;
    }

    thread changestate(self.otherdoor);
    return;
  }
}

function angle_diff(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}

function amortizeyawtraces() {
  level.doorphase = 0;
  level.doortracequeue = 0;
  var_0 = [];
  var_1 = [];
  level.doortracemetrics = spawnStruct();
  level.doortracemetrics.doorcount = level.doors.size;
  level.doortracemetrics.totaltracecount = 0;
  level.doortracemetrics.tracecountbyphase = [];
  level.doortracemetrics.tracetimebyphase = [];
  level.doortracemetrics.totaltime = 0;
  level.doortracemetrics.totalwaitframes = 0;
  level.waitcycles = 0;
  level.doortraces = 0;
  waitframe();
  level.doortracemetrics.totaltime = gettime();
  GscBinSkip0(0x2e, 0, level.doortracemetrics.totaltime);
}

function get_max_yaws() {
  thread get_max_yaw(1);
  thread get_max_yaw(0);
}

function get_max_yaw(var_0) {
  if(var_0) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  var_1 = 90;
  var_2 = 10;
  var_3 = 0;

  while(level.doorphase < 3) {
    var_3 = get_max_yaw_internal(var_1, var_2, var_0);

    if(var_0) {
      self.max_yaw_left = var_3;
    } else {
      self.max_yaw_right = var_3;
    }

    if(var_3 == 100) {
      break;
    }

    var_2 *= 0.5;
    var_1 = var_3 + var_2;
    level waittill("advance_door_trace");
  }

  var_3 = max(var_3, 90);

  if(var_0) {
    self.max_yaw_left = var_3;
    return;
  }

  self.max_yaw_right = var_3;
}

function get_max_yaw_internal(var_0, var_1, var_2) {
  if(!isDefined(self.traces)) {
    self.traces = 0;
  }

  if(!isDefined(level.doortraces)) {
    level.doortraces = 0;
  }

  var_3 = 0;
  var_4 = 0;
  level.doortracequeue++;
  waitframe();

  while(!var_4) {
    if(var_0 > 100) {
      level.currentdoor = undefined;
      level.doortracequeue--;
      return 100;
    }

    while(isDefined(level.currentdoor) && self != level.currentdoor) {
      waitframe();
    }

    if(!isDefined(level.currentdoor)) {
      level.currentdoor = self;
    }

    var_5 = yaw_collision_check(var_0, var_1, var_2);

    if(var_5) {
      if(var_3) {
        var_6 = 1;
      }

      var_0 += var_1;
    } else {
      if(!var_3) {
        var_3 = 1;
      }

      var_0 -= var_1;
      var_4 = 1;
    }

    self.traces++;
    level.doortraces++;
    var_7 = gettime();

    if(!isDefined(level.doortraceframetime) || level.doortraceframetime != var_7) {
      level.doortraceframetime = var_7;
      level.doortracesthisframe = 0;
    }

    level.doortracesthisframe++;

    if(level.doortracesthisframe == 3) {
      level.doortracesthisframe = 0;
      level.waitcycles++;
      waitframe();
    }
  }

  level.currentdoor = undefined;
  level.doortracequeue--;
  return var_0;
}

function yaw_collision_check(var_0, var_1, var_2) {
  if(!var_2) {
    var_0 *= -1;
  }

  var_3 = self.baseangles + (0, var_0, 0);
  var_4 = self.origin + (0, 0, 8);
  var_5 = self.height - 16;
  var_6 = anglesToForward(var_3);
  var_7 = anglestoright(var_3);

  if(var_2) {
    var_7 *= -1;
  }

  var_8 = var_4 + var_6 * self.length * 0.2;
  var_9 = var_4 + var_6 * (self.length - 2);
  var_10 = scripts\engine\trace::capsule_trace(var_8, var_9, 2, var_5, var_3, scripts\engine\utility::ter_op(isDefined(self.clip), [self, self.clip], [self]), level.doorcontentoverride, 0);

  if(getdvarint("scr_door_debug")) {
    var_11 = (1, 1, 1);

    if(var_10["fraction"] == 1) {
      var_11 = (0, 1, 0);
    } else {
      var_11 = (1, 0, 0);
    }

    thread scripts\mp\utility\debug::drawline(var_8, var_9, 600, var_11);
    thread scripts\mp\utility\debug::drawline(var_8 + (0, 0, var_5), var_9 + (0, 0, var_5), 600, var_11);
    thread scripts\mp\utility\debug::drawline(var_8, var_8 + (0, 0, var_5), 600, var_11);
    thread scripts\mp\utility\debug::drawline(var_9, var_9 + (0, 0, var_5), 600, var_11);
  }

  return var_10["fraction"] == 1;
}

function perk_doorsensethink() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.doors) {
      if(var_1.state != 0) {
        continue;
      }

      if(isDefined(level.playerswithdoorsense) && level.playerswithdoorsense <= 0) {
        continue;
      }

      var_2 = scripts\mp\utility\player::getplayersinradius(var_1.origin, 128);

      if(var_2.size == 0) {
        continue;
      }

      foreach(var_4 in var_2) {
        if(var_4 scripts\mp\utility\perk::_hasperk("specialty_door_sense")) {
          perk_doorsense_outlinedoor(var_4, var_2, var_1);
        }
      }
    }

    wait 0.1;
  }
}

function perk_doorsense_outlinedoor(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5.team != var_0.team) {
      var_3 = var_5;
    }
  }

  if(var_3.size == 0) {
    return;
  }

  foreach(var_8 in var_3) {
    if(perk_doorsense_othersideofdoorcheck(var_0, var_8, var_2)) {
      var_9 = scripts\mp\utility\outline::outlineenableforplayer(var_2, var_0, "outline_nodepth_orange", "equipment");
      thread perk_doorsense_trackoutlinedisable(var_9, var_2);
    }
  }
}

function perk_doorsense_outlineenemies(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5.team != var_0.team) {
      var_3 = var_5;
    }
  }

  if(var_3.size == 0) {
    return;
  }

  foreach(var_8 in var_3) {
    if(perk_doorsense_othersideofdoorcheck(var_0, var_8, var_2)) {
      var_9 = scripts\mp\utility\outline::outlineenableforplayer(var_8, var_0, "outline_nodepth_orange", "equipment");
      thread perk_doorsense_trackoutlinedisable(var_9, var_8);
    }
  }
}

function perk_doorsense_othersideofdoorcheck(var_0, var_1, var_2) {
  var_3 = vectorNormalize(anglestoright(var_2.angles));
  var_4 = vectorNormalize(var_0.origin - var_2.origin);
  var_5 = vectorNormalize(var_1.origin - var_2.origin);
  var_6 = vectordot(var_3, var_4);
  var_7 = vectordot(var_3, var_5);

  if(var_6 > 0 && var_7 < 0 || var_6 < 0 && var_7 > 0) {
    return true;
  }

  return false;
}

function perk_doorsense_trackoutlinedisable(var_0, var_1) {
  wait 0.2;
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

function onplayerspawned() {
  var_0 = scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("scr_door_breach_unrestricted", 0) == 1;
  updatealldoorslockvisibilityforplayer(self, var_0);
  var_1 = scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
  updatealldoorsalarmvisibilityforplayer(self, var_1);
}

function updatelockpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(var_1 in level.players) {
    var_2 = var_1 scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("scr_door_breach_unrestricted", 0) == 1;
    updatelockpromptvisibilityforplayer(var_1, var_2);
  }
}

function updatealldoorslockvisibilityforplayer(var_0, var_1) {
  foreach(var_3 in level.doors) {
    updatelockpromptvisibilityforplayer(var_3, var_0, var_1);
  }
}

function updatelockpromptvisibilityforplayer(var_0, var_1) {
  if(!isDefined(self.lockprompt)) {
    return;
  }

  var_2 = self.state == 0 || self.state == 7;

  if(var_2 && isDefined(self.otherdoor)) {
    var_2 = self.otherdoor.state == 0 || self.otherdoor.state == 7;
  }

  if(!istrue(self.breaching) && var_2) {
    if(var_1) {
      self.lockprompt showtoplayer(var_0);
      self.lockprompt enableplayeruse(var_0);
      return;
    }

    self.lockprompt hidefromplayer(var_0);
    self.lockprompt disableplayeruse(var_0);
    return;
  }

  self.lockprompt hidefromplayer(var_0);
  self.lockprompt disableplayeruse(var_0);
}

function lockmonitor() {
  if(!isDefined(self.lockprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 0) {
      waitframe();
    }
  }

  self.lockprompt setHintString(&"MP/DOOR_USE_LOCK");
  self.lockprompt setuseholdduration("duration_medium");
  updatelockpromptvisibility();

  for(;;) {
    self.lockprompt waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    if(var_0 meleeButtonPressed()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    thread lockdoor();
  }
}

function lockdoor() {
  thread changestate(7);

  if(isDefined(self.otherdoor)) {
    thread changestate(self.otherdoor);
    return;
  }
}

function updatealarmpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(var_1 in level.players) {
    var_2 = var_1 scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
    updatealarmpromptsvisibilityforplayer(var_1, var_2);
  }
}

function updatealldoorsalarmvisibilityforplayer(var_0, var_1) {
  foreach(var_3 in level.doors) {
    updatealarmpromptsvisibilityforplayer(var_3, var_0, var_1);
  }
}

function updatealarmpromptsvisibilityforplayer(var_0, var_1) {
  if(!isDefined(self.alarmprompts)) {
    return;
  }

  foreach(var_3 in self.alarmprompts) {
    var_4 = var_1 && self.state == 0 || self.state == 8 && isDefined(self.dooralarmprompt) && var_3 == self.dooralarmprompt;

    if(var_4 && isDefined(self.otherdoor)) {
      var_4 = var_1 && self.otherdoor.state == 0 || self.state == 8 && var_3 == self.dooralarmprompt;
    }

    if(var_4) {
      var_3 showtoplayer(var_0);
      var_3 enableplayeruse(var_0);
      continue;
    }

    var_3 hidefromplayer(var_0);
    var_3 disableplayeruse(var_0);
  }
}

function alarmmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 0) {
      waitframe();
    }
  }

  foreach(var_1 in self.alarmprompts) {
    var_1 setHintString(&"MP/DOOR_USE_ALARM");
    var_1 setuseholdduration("duration_medium");
  }

  updatealarmpromptvisibility();

  foreach(var_1 in self.alarmprompts) {
    thread _alarmmonitorinternal(var_1);
  }
}

function _alarmmonitorinternal(var_0) {
  self endon("stateChanged");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(self.state != 0) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(var_1 meleeButtonPressed()) {
      continue;
    }

    if(var_1 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    thread alarmdoor(var_1, var_0);
  }
}

function alarmdoor(var_0, var_1) {
  var_2 = self gettagorigin("tag_door_handle");
  playsoundatpos(var_1.origin, "mp_door_alarm_on");
  self.dooralarment = spawn("script_model", var_1.origin);
  self.dooralarment setModel("shardball_wm");
  self.dooralarment.angles = self.angles;
  self.dooralarment linkTo(self);
  self.dooralarment setentityowner(var_0);
  self.dooralarment setotherent(var_0);
  self.dooralarment setscriptablepartstate("effects", "planted", 0);
  self.dooralarmowner = var_0;
  self.dooralarmprompt = var_1;
  self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_add(self.dooralarmowner.alarmeddoors, self);

  while(self.dooralarmowner.alarmeddoors.size > 3) {
    var_3 = self.dooralarmowner.alarmeddoors[0];
    removealarmdoor(var_3, 0);
  }

  thread changestate(8);

  if(isDefined(self.otherdoor)) {
    thread changestate(self.otherdoor);
    return;
  }
}

function removealarmmonitor() {
  if(!isDefined(self.dooralarmprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 8) {
      waitframe();
    }
  }

  self.dooralarmprompt setHintString(&"MP/DOOR_USE_REMOVE_ALARM");
  self.dooralarmprompt setuseholdduration("duration_medium");
  self.dooralarmprompt.owner = self.dooralarmowner;
  self.dooralarmprompt.team = self.dooralarmowner.team;
  updatealarmpromptvisibility();

  for(;;) {
    self.dooralarmprompt waittill("trigger", var_0);

    if(self.state != 8) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    if(var_0 meleeButtonPressed()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    thread removealarmdoor(1);
  }
}

function disownalarmmonitor() {
  if(!isDefined(self.dooralarmprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 8) {
      waitframe();
    }
  }

  for(;;) {
    self.dooralarmowner scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");

    if(self.state != 8) {
      return;
    }

    thread removealarmdoor(0);
  }
}

function removealarmdoor(var_0) {
  if(var_0) {
    playsoundatpos(self.dooralarment.origin, "mp_door_alarm_off");
  }

  if(isDefined(self.dooralarmowner)) {
    self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(self.dooralarmowner.alarmeddoors, self);
  }

  self.dooralarment delete();
  self.dooralarmowner = undefined;
  self.dooralarmprompt = undefined;
  thread changestate(0);

  if(isDefined(self.otherdoor)) {
    thread changestate(self.otherdoor);
    return;
  }
}

function checktriggeralarm(var_0) {
  if(self.state != 8) {
    return;
  }

  var_1 = self;

  if(!isDefined(self.dooralarment) && isDefined(self.otherdoor)) {
    var_1 = self.otherdoor;
  }

  if(!isDefined(var_1.dooralarmowner)) {
    return;
  }

  var_2 = var_1.dooralarment;
  var_3 = var_1.dooralarmowner;
  var_1.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(var_1.dooralarmowner.alarmeddoors, var_1);
  var_1.dooralarment = undefined;
  var_1.dooralarmowner = undefined;
  var_1.dooralarmprompt = undefined;
  var_3 scripts\mp\killstreaks\killstreaks::givescorefortriggeredalarmeddoor();

  if(isDefined(self.otherdoor)) {
    thread changestate(self.otherdoor);
  }

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_3))) {
    var_2 playLoopSound("mp_door_alarm_lp");
    pinglocationenemyteams(self.origin, var_0.team);
    var_2 setscriptablepartstate("effects", "triggered", 0);
    wait 4;
    var_2 stoploopsound();
    var_2 delete();
    return;
  }

  playsoundatpos(var_2.origin, "mp_door_alarm_off");
  var_2 setscriptablepartstate("effects", "neutral", 0);
  var_2 delete();
}

function ajarmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(!istrue(self.issaloonstyle)) {
    return;
  }

  self endon("stateChanged");
  self notify("ajarMonitor");
  self endon("ajarMonitor");

  for(;;) {
    waitframe();
    waittillframeend();

    if(self.otherdoor.state != 0) {
      thread changestate(6);
    }
  }
}

function breachmonitor() {
  self endon("stateChanged");
  thread monitorbreachmelee();
  self.lockprompt setHintString(&"MP/DOOR_USE_BREACH");
  self.lockprompt setuseholdduration("duration_short");
  updatelockpromptvisibility();

  if(!isDefined(self.otherdoor)) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
  }

  thread updatelocklight("lockedDoor");

  for(;;) {
    self.lockprompt waittill("trigger", var_0);

    if(var_0 meleeButtonPressed()) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(var_0 issprinting() || var_0 issprintsliding()) {
      continue;
    }

    if(var_0 ismantling()) {
      continue;
    }

    if(istrue(self.breaching)) {
      continue;
    }

    thread breachdoor(var_0);
  }
}

function breachdoor(var_0) {
  thread plantbreach(var_0);
}

function monitorbreachmelee() {
  self endon("stateChanged");
  self notify("monitorBreachMelee");
  self endon("monitorBreachMelee");
  self.lockedmeleehealth = 150;
  self setCanDamage(1);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_13, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isDefined(var_3) && !istrue(self.breaching)) {
      if(var_3 == "MOD_MELEE" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE") {
        var_14 = isDefined(var_8) && isDefined(var_8.basename) && (var_8.basename == "molotov_mp" || var_8.basename == "thermite_mp" || var_8.basename == "thermite_ap_mp" || var_8.basename == "thermite_av_mp");

        if(var_14) {
          continue;
        }

        self.lockedmeleehealth -= var_0;

        if(isDefined(self.otherdoor)) {
          self.otherdoor.lockedmeleehealth -= var_0;
        }

        if(self.lockedmeleehealth < 1) {
          if(isDefined(self.otherdoor) || istrue(self.issaloonstyle)) {
            thread updatelocklight(self.otherdoor);
            thread bashopen(self.otherdoor, var_1);
          }

          thread updatelocklight("off");
          thread bashopen(var_1, var_1.origin);
          continue;
        }

        playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");
      }
    }
  }
}

#using_animtree("script_model");

function plantbreach(var_0) {
  if(isDefined(self.otherdoor) && istrue(self.otherdoor.breaching)) {
    return;
  }

  self.breaching = 1;
  thread updatelockpromptvisibility();
  thread watchplayerdeath(var_0);
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectorNormalize(var_0.origin - self.origin);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;

  if(var_6) {
    var_7 = self.rightplantorg;
    var_8 = self.rightplantang;
  } else {
    var_7 = self.leftplantorg;
    var_8 = self.leftplantang;
  }

  var_2.linktoent = var_2 scripts\engine\utility::spawn_tag_origin();
  var_2 playerlinktodelta(var_2.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_9 = scripts\engine\utility::spawn_tag_origin(var_7, var_8);
  var_2.linktoent moveTo(var_7, 0.25, 0.1, 0.1);
  var_2.linktoent rotateTo(var_8, 0.25, 0.1, 0.1);
  var_2 setstance("stand");

  if(!istrue(givegunless(var_2))) {
    var_2 unlink();
    var_2.linktoent delete();
    var_2.linktoent = undefined;
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  var_2 unlink();
  var_2.linktoent delete();
  var_2.linktoent = undefined;
  var_2 setOrigin(var_7);
  var_2 setplayerangles(var_8);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_2, "c4_plant");
  var_10 = scripts\engine\utility::ter_op(var_2.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard") {
    var_10 = scripts\engine\utility::ter_op(var_2.team == "allies", "ukp1", "abp1");
  }

  var_2 queuedialogforplayer("dx_mpp_" + var_10 + "_breach_plant", "cop_breach_plant", 2);
  thread create_player_rig(var_2, "planter");
  var_9 thread scripts\mp\anim::anim_player_solo(var_2, var_2.player_rig, "plant");
  var_11 = spawn("script_model", var_7);
  var_11 setModel("offhand_wm_c4");
  var_11.animname = "c4";
  var_11 useanimtree(#animtree);
  self.plantedbomb = var_11;
  var_9 thread scripts\common\anim::anim_single_solo(var_11, "plant");
  var_12 = getanimlength(level.scr_anim["planter"]["plant"]);
  var_13 = 0.5;
  wait var_12 - var_13;

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  thread bomb_planted_think(var_2, var_8);
  givebreachscore(var_2);
  wait var_13;

  if(var_2 isviewmodelanimplaying()) {
    var_2 stopviewmodelanim();
  }

  thread takegunless();
  remove_player_rig(var_2);
  return 1;
}

function bomb_planted_think(var_0, var_1) {
  var_2 = var_0.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(var_2);

  if(!self.defused) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var_3 = self.doorcenter;

    if(var_1) {
      var_4 = self.rightplantang;
    } else {
      var_4 = self.leftplantang;
    }

    var_5 = spawnfx(level._effect["breach_explode"], var_4, anglesToForward(var_4) * -1, (0, 0, 1));
    triggerfx(var_5);
    physicsexplosionsphere(var_4, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var_4);
    earthquake(0.5, 1, var_4, 1500);
    var_1 scripts\mp\utility\weapon::_launchgrenade("flash_grenade_mp", self.plantedbomb.origin + anglesToForward(var_4) * 100, (0, 0, 0), 0.05, 1);
    var_1 scripts\mp\utility\weapon::_launchgrenade("concussion_grenade_mp", self.plantedbomb.origin + anglesToForward(var_4) * 100, (0, 0, 0), 0.05, 1);
    wait 0.1;

    if(isDefined(var_1)) {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 50, 10, 5, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    } else {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 100, 50, 5, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    thread bashopen(var_1, self.plantedbomb.origin);

    if(isDefined(self.otherdoor)) {
      thread bashopen(self.otherdoor, var_1);
    }
  }

  self.plantedbomb delete();
  self.plantedbomb = undefined;
  setomnvar("ui_ingame_timer_" + self.breachindex, 0);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, undefined);
  self.breaching = 0;
  thread updatelockpromptvisibility();
  thread updatelocklight("off");

  if(isDefined(self.otherdoor)) {
    thread updatelocklight(self.otherdoor);
    return;
  }
}

function bomb_fuse_think(var_0) {
  self notify("breach_planted");
  self.timerobject = spawn("script_model", self.plantedbomb.origin);
  var_1 = gettime();
  var_2 = int(var_1 + 1000);
  setomnvar("ui_ingame_timer_" + self.breachindex, var_2);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, self.timerobject);
  var_3 = var_2 - var_1;

  while(!self.defused && var_3 > 0) {
    var_1 = gettime();
    var_3 = var_2 - var_1;

    if(var_3 < 1500) {
      if(var_3 <= 250) {
        self.plantedbomb playSound("breach_warning_beep_05");
      } else if(var_3 < 500) {
        self.plantedbomb playSound("breach_warning_beep_04");
      } else if(var_3 < 1500) {
        self.plantedbomb playSound("breach_warning_beep_03");
      } else {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_3 < 3500) {
      self.plantedbomb playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self.plantedbomb playSound("breach_warning_beep_01");
      wait 1;
    }

    if(var_3 < 0) {
      break;
    }
  }
}

function watchplayerdeath(var_0) {
  self endon("breach_planted");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
        self.plantedkey = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

function script_model_anims() {}

#using_animtree("");

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0.player_rig = spawn("script_model", var_0.origin);
  var_0.player_rig setModel(var_2);
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143a5("remove_rig", "death_or_disconnect");
}

function givebreachscore(var_0) {
  var_1 = "breach";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
}

function givegunless() {
  self endon("death_or_disconnect");
  var_0 = getcompleteweaponname("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.gunnlessweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::allow_melee(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

function takegunless() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }

  self.takinggunless = 1;
  scripts\common\utility::allow_weapon_switch(1);

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_melee(1);
}

function updatelocklight(var_0) {
  if(!isDefined(self.locklight)) {
    return;
  }

  self notify("updateLockLight");
  self endon("updateLockLight");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  self.locklight setscriptablepartstate("marker", var_0);
}

function linkdoubledoors() {
  foreach(var_1 in level.doors) {
    if(isDefined(var_1.otherdoor)) {
      continue;
    }

    foreach(var_3 in level.doors) {
      if(var_3 == var_1) {
        continue;
      }

      var_4 = var_1 gettagorigin("tag_door_handle", 1);
      var_5 = var_3 gettagorigin("tag_door_handle", 1);

      if(!isDefined(var_4) || !isDefined(var_5)) {
        continue;
      }

      var_6 = distancesquared(var_4, var_5);

      if(var_6 < 225) {
        if(var_6 < 100) {
          var_1.issaloonstyle = 1;
          var_3.issaloonstyle = 1;
        }

        var_3.otherdoor = var_1;
        var_1.otherdoor = var_3;

        if(isDefined(var_1.lockprompt) && isDefined(var_3.lockprompt)) {
          var_3.lockprompt delete();
          var_3.lockprompt = var_1.lockprompt;
          var_7 = (var_4 + var_5) * 0.5 + (0, 0, 15);
          var_1.lockprompt unlink();
          var_1.lockprompt.origin = var_7;
          thread changestate(var_1);
          thread changestate(var_3);
          var_1.leftplantorg = (var_7[0], var_7[1], var_1.origin[2]) + anglestoright(var_1.baseangles) * -24.5;
          var_1.leftplantang = (0, var_1.baseangles[1] - 90, 0);
          var_1.rightplantorg = (var_7[0], var_7[1], var_1.origin[2]) + anglestoright(var_1.baseangles) * 24.5;
          var_1.rightplantang = (0, var_1.baseangles[1] + 90, 0);
          var_3.leftplantorg = (var_7[0], var_7[1], var_3.origin[2]) + anglestoright(var_3.baseangles) * -24.5;
          var_3.leftplantang = (0, var_3.baseangles[1] - 90, 0);
          var_3.rightplantorg = (var_7[0], var_7[1], var_3.origin[2]) + anglestoright(var_3.baseangles) * 24.5;
          var_3.rightplantang = (0, var_3.baseangles[1] + 90, 0);
        }
      }
    }
  }
}

function door_createnavobstacle() {
  if(!isDefined(self.clipent)) {
    return;
  }

  if(isDefined(self.doornavobstacle)) {
    return;
  }

  self.doornavobstacle = createnavobstaclebyent(self.clipent);
}

function door_destroynavobstacle() {
  if(!isDefined(self.doornavobstacle)) {
    return;
  }

  destroynavobstacle(self.doornavobstacle);
  self.doornavobstacle = undefined;
}

function door_enableaudioportal() {
  if(isDefined(self.audioportalent)) {
    self.audioportalent enableaudioportal(1);
    return;
  }
}

function door_disableaudioportal() {
  if(isDefined(self.otherdoor) && self.otherdoor.state != 0 && self.otherdoor.state != 7 && self.otherdoor.state != 8) {
    return;
  }

  if(isDefined(self.audioportalent)) {
    self.audioportalent enableaudioportal(0);
    return;
  }
}

function door_can_open_check() {
  return self.state == 6 || self.state == 0;
}