/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\door.gsc
***********************************************/

function door_dynamic_setup(var0) {
  if(isDefined(level.doors)) {
    return;
  }

  setDvar("NSOMOMMLML", 150);
  level.doors = [];
  level.doorsetupstarted = 0;
  thread door_dynamic_setup_adapter("dynamic_door", 0);
  thread door_dynamic_setup_adapter("lean_dynamic_door", 1, var0);
  script_model_anims();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function door_dynamic_setup_adapter(var0, var1, var2) {
  var3 = getEntArray(var0, "targetname");
  level.doorsetupstarted++;
  level.doorsetupfinished = 0;
  var4 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip", "physicscontents_item"];
  var5 = physics_createcontents(var4);
  level.doorcontentoverride = var5;

  foreach(var7 in var3) {
    if(isDefined(var7.script_parameters)) {
      door_dynamic_parse_parameters(var7, var7.script_parameters);
    }

    var7.doors = [];
    var7.doors[0] = var7;
    var7.islean = var1;
    var7.baseangles = var7.angles;

    if(var7.baseangles[1] == 360) {
      var7.baseangles = (var7.baseangles[0], 0, var7.baseangles[2]);
    }

    var7.state = 0;
    var8 = var7.target;
    var9 = isDefined(var7.script_noteworthy) && var7.script_noteworthy == "OPEN" || getdvarint("scr_doors_open", 0) != 0;
    var10 = isDefined(var7.script_noteworthy) && var7.script_noteworthy == "LOCKED";
    var7.length = 52;
    var7.height = 96;
    var7.leftplantorg = var7.origin + anglesToForward(var7.angles) * var7.length * 0.5 + anglestoright(var7.angles) * -24.5;
    var7.leftplantang = (0, var7.baseangles[1] - 90, 0);
    var7.rightplantorg = var7.origin + anglesToForward(var7.angles) * var7.length * 0.5 + anglestoright(var7.angles) * 24.5;
    var7.rightplantang = (0, var7.baseangles[1] + 90, 0);
    var7.doorcenter = var7.origin + anglesToForward(var7.angles) * var7.length * 0.5 + anglestoup(var7.angles) * var7.height * 0.5;
    var7.max_yaw_left = 90;
    var7.max_yaw_right = 90;
    var11 = var7 gettagorigin("tag_door_handle", 1);

    if(isDefined(var11)) {
      var7 scripts\mp\gameobjects::sethintobject("tag_door_handle", "HINT_BUTTON", undefined, &"MP/DOOR_USE_OPEN_DOUBLE", undefined, "duration_none", undefined, 200, 90, 72, 90);
      var7.useprompt = var7;
      var7.useprompt setusewhenhandsoccupied(1);

      if(!var1 && scripts\mp\utility\game::getgametype() != "br") {
        var7.lockprompt = scripts\mp\gameobjects::createhintobject(var11, "HINT_BUTTON", undefined, &"MP/DOOR_USE_LOCK", undefined, undefined, "show", 200, 90, 72, 90);
        var7.lockprompt linkTo(var7, "tag_door_handle", (3, 0, 15), (0, 0, 0));
        var7.lockprompt setusewhenhandsoccupied(1);
        var7.alarmprompts = [];
        var12 = [(4, 0, 4), (4, 0, 90)];

        foreach(var14 in var12) {
          var15 = scripts\mp\gameobjects::createhintobject(var11, "HINT_BUTTON", undefined, &"MP/DOOR_USE_ALARM", undefined, undefined, "show", 100, 90, 80, 20);
          var15 linkTo(var7, "tag_origin", var14, (0, 0, 0));
          var15 setusewhenhandsoccupied(0);
          var16 = var15 getentitynumber();
          var7.alarmprompts[var16] = var15;
        }

        var18 = getEnt(var8, "targetname");

        if(isDefined(var18)) {
          var7.clipent = var18;
          var7.clipent linkTo(var7);
          var7.clipent.unresolved_collision_func = &scripts\mp\movers::unresolved_collision_void;
          var7.clipent connectpaths();

          if(isDefined(var18.target)) {
            var19 = getEnt(var18.target, "targetname");
            var7.audioportalent = var19;
          }
        }
      }

      if(var9) {
        thread changestate(var7);
        var7.angles = (var7.angles[0], var7.angles[1] + 90, var7.angles[2]);
      } else if(var10) {
        thread changestate(var7);
      } else {
        thread changestate(var7);
      }
    }

    level.doors[level.doors.size] = var7;
    waitframe();
  }

  if(!var1) {
    thread amortizeyawtraces();

    foreach(var7 in level.doors) {
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
    foreach(var1 in level.doors) {
      var1.statecurr = 2;
      var1.angles = var1.doortarget.angles;
    }

    return;
  }
}

function triggerlisten(var0) {
  self notify("disableTrigger");
  self endon("disableTrigger");
  level endon("game_ended");
  jumpiffalse(!var0.islean && var0.statecurr == 0) LOC_00000037;
  thread bashmonitor();
  self waittill("trigger", var1);
  self makeunusable();
  var2 = var0.doortarget;

  if(isDefined(var0.doortargetccw)) {
    var3 = anglesToForward(var0.angles);
    var4 = vectorcross((0, 0, 1), var3);
    var5 = anglesToForward((0, var1.angles[1], 0));

    if(vectordot(var5, var4) < 0) {
      var2 = var0.doortargetccw;
    }
  }

  var6 = 0.666;

  if(var0.statecurr == 0) {
    self notify("stop_bash_monitor");
    var0.statecurr = 3;
    var0 rotateTo(var2.angles, var6, 0, 0.333);
    var7 = &"MP/DOOR_USE_CLOSE";
  } else {
    var0.statecurr = 1;
    var0 rotateTo(var0.baseangles, var6, 0, 0.333);
    var7 = &"MP/DOOR_USE_OPEN";
  }

  var0 scripts\mp\events::doorused(var1, var0.statecurr == 3);
  wait 0.1;
  GscBinSkip4(0x6e, var0, var0);
}

function door_dynamic_parse_parameters(var0) {
  var1 = self;
  var1.button_sound = undefined;

  if(!isDefined(var0)) {
    var0 = "";
  }

  var2 = strtok(var0, ";");

  foreach(var4 in var2) {
    var5 = strtok(var4, "=");

    if(var5.size != 2) {
      continue;
    }

    if(var5[1] == "undefined" || var5[1] == "default") {
      var1.params[var5[0]] = undefined;
      continue;
    }

    switch (var5[0]) {
      case "stop_sound":
        var1.stop_sound = var5[1];
        break;
      case "interrupt_sound":
        var1.interrupt_sound = var5[1];
        break;
      case "loop_sound":
        var1.loop_sound = var5[1];
        break;
      case "open_interrupt":
        var1.open_interrupt = string_to_bool(var5[1]);
        break;
      case "start_sound":
        var1.start_sound = var5[1];
        break;
      case "material":
        var1.material = var5[1];
        break;
    }
  }
}

function door_system_init(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    if(isDefined(var3.script_parameters)) {
      button_parse_parameters(var3, var3.script_parameters);
    }

    door_setup(var3);
  }

  foreach(var3 in var1) {
    thread door_think();
  }
}

function door_setup() {
  var0 = self;
  var0.doors = [];
  var0.hasbeenused = 0;

  if(isDefined(var0.script_index)) {
    var0.doormovetime = max(0.1, float(var0.script_index) / 1000);
  }

  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    if(issubstr(var3.classname, "trigger")) {
      if(!isDefined(var0.trigblock)) {
        var0.trigblock = [];
      }

      if(isDefined(var3.script_parameters)) {
        trigger_parse_parameters(var3, var3.script_parameters);
      }

      if(isDefined(var3.script_linkto)) {
        var4 = getEnt(var3.script_linkto, "script_linkname");
        var3 enablelinkTo();
        var3 linkTo(var4);
      }

      var0.trigblock[var0.trigblock.size] = var3;
      continue;
    }

    if(var3.classname == "script_brushmodel" || var3.classname == "script_model") {
      if(isDefined(var3.script_noteworthy) && issubstr(var3.script_noteworthy, "light")) {
        if(issubstr(var3.script_noteworthy, "light_on")) {
          if(!isDefined(var0.lights_on)) {
            var0.lights_on = [];
          }

          var3 hide();
          var0.lights_on[var0.lights_on.size] = var3;
        } else if(issubstr(var3.script_noteworthy, "light_off")) {
          if(!isDefined(var0.lights_off)) {
            var0.lights_off = [];
          }

          var3 hide();
          var0.lights_off[var0.lights_off.size] = var3;
        }
      } else if(var3.spawnflags & 2) {
        if(!isDefined(var0.ai_sight_brushes)) {
          var0.ai_sight_brushes = [];
        }

        var3 notsolid();
        var3 hide();
        var0.ai_sight_brushes[var0.ai_sight_brushes.size] = var3;
      } else {
        var0.doors[var0.doors.size] = var3;
      }

      continue;
    }

    if(var3.classname == "script_origin") {
      var0.entsound = var3;
    }
  }

  if(!isDefined(var0.entsound) && var0.doors.size) {
    var0.entsound = sortbydistance(var0.doors, var0.origin)[0];
  }

  foreach(var7 in var0.doors) {
    var7.posclosed = var7.origin;
    var7.posopen = scripts\engine\utility::getStruct(var7.target, "targetname").origin;
    var7.distmove = distance(var7.posopen, var7.posclosed);
    var7.no_moving_unresolved_collisions = 0;

    if(!istrue(var0.start_closed)) {
      var7.origin = var7.posopen;
    }

    if(isDefined(var7.script_parameters)) {
      door_parse_parameters(var7, var7.script_parameters);
    }
  }
}

function door_think() {
  var0 = self;
  var1 = scripts\engine\utility::ter_op(istrue(var0.start_closed), 0, 2);
  door_state_change(var0, var1, 1);

  for(;;) {
    var0.statedone = undefined;
    var0.stateinterrupted = undefined;
    var0 scripts\engine\utility::ref_143a5("door_state_done", "door_state_interrupted");

    if(isDefined(var0.statedone) && var0.statedone) {
      var2 = door_state_next(var0, var0.statecurr);
      door_state_change(var0, var2, 0);
      continue;
    }

    if(isDefined(var0.stateinterrupted) && var0.stateinterrupted) {
      door_state_change(var0, 4, 0);
    }
  }
}

function door_state_next(var0) {
  var1 = self;
  var2 = undefined;

  if(var0 == 0) {
    var2 = 3;
  } else if(var0 == 2) {
    var2 = 1;
  } else if(var0 == 1) {
    var2 = 0;
  } else if(var0 == 3) {
    var2 = 2;
  } else if(var0 == 4) {
    var2 = var1.stateprev;
  }

  return var2;
}

function door_state_update(var0) {
  var1 = self;
  var1 endon("door_state_interrupted");
  var1.statedone = undefined;

  if(var1.statecurr == 0 || var1.statecurr == 2) {
    if(!var0) {
      foreach(var3 in var1.doors) {
        if(isDefined(var3.stop_sound)) {
          var3 stoploopsound();
          var3 playsoundonmovingent(var3.stop_sound);
        }
      }
    }

    if(isDefined(var1.lights_on)) {
      foreach(var6 in var1.lights_on) {
        var6 show();
      }
    }

    foreach(var3 in var1.doors) {
      if(var1.statecurr == 0) {
        if(isDefined(var1.ai_sight_brushes)) {
          foreach(var10 in var1.ai_sight_brushes) {
            var10 show();
          }
        }

        if(var3.spawnflags & 1) {}
      } else {
        if(isDefined(var1.ai_sight_brushes)) {
          foreach(var10 in var1.ai_sight_brushes) {
            var10 hide();
          }
        }

        if(var3.spawnflags & 1) {
          if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == "always_disconnect") {}
        }
      }

      if(isDefined(var3.script_noteworthy)) {
        if(var3.script_noteworthy == "clockwise_wheel" || var3.script_noteworthy == "counterclockwise_wheel") {
          var3 rotatevelocity((0, 0, 0), 0.1);
        }
      }

      if(var3.no_moving_unresolved_collisions) {
        var3.unresolved_collision_func = undefined;
      }
    }

    var15 = !istrue(var1.one_time_use) || !var1.hasbeenused;

    if(var15) {
      var16 = scripts\engine\utility::ter_op(var1.statecurr == 0, &"MP/DOOR_USE_OPEN", &"MP/DOOR_USE_CLOSE");

      if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var1 setHintString(var16);
      }

      var1 makeusable();
      var1 waittill("trigger");

      if(isDefined(var1.button_sound)) {
        var1 playSound(var1.button_sound);
      }

      var1.hasbeenused = 1;
    } else {
      var1 waittill("forever");
    }
  } else {
    if(var1.statecurr == 1 || var1.statecurr == 3) {
      if(isDefined(var1.lights_off)) {
        foreach(var6 in var1.lights_off) {
          var6 show();
        }
      }

      var1 makeunusable();

      if(var1.statecurr == 1) {
        thread door_state_on_interrupt();

        foreach(var3 in var1.doors) {
          if(isDefined(var3.script_noteworthy)) {
            var20 = scripts\engine\utility::ter_op(isDefined(var1.doormovetime), var1.doormovetime, 3);
            var21 = scripts\engine\utility::ter_op(var1.statecurr == 1, var3.posclosed, var3.posopen);
            var22 = distance(var3.origin, var21);
            var23 = max(0.1, var22 / var3.distmove * var20);
            var24 = max(var23 * 0.25, 0.05);
            var25 = 360 * var22 / 94.2;

            if(var3.script_noteworthy == "clockwise_wheel") {
              var3 rotatevelocity((0, 0, -1 * var25 / var23), var23, var24, var24);
            } else if(var3.script_noteworthy == "counterclockwise_wheel") {
              var3 rotatevelocity((0, 0, var25 / var23), var23, var24, var24);
            }
          }
        }
      } else if(var1.statecurr == 3) {
        if(isDefined(var1.open_interrupt) && var1.open_interrupt) {
          thread door_state_on_interrupt();
        }

        foreach(var3 in var1.doors) {
          if(isDefined(var3.script_noteworthy)) {
            var20 = scripts\engine\utility::ter_op(isDefined(var1.doormovetime), var1.doormovetime, 3);
            var21 = scripts\engine\utility::ter_op(var1.statecurr == 1, var3.posclosed, var3.posopen);
            var22 = distance(var3.origin, var21);
            var23 = max(0.1, var22 / var3.distmove * var20);
            var24 = max(var23 * 0.25, 0.05);
            var25 = 360 * var22 / 94.2;

            if(var3.script_noteworthy == "clockwise_wheel") {
              var3 rotatevelocity((0, 0, var25 / var23), var23, var24, var24);
            } else if(var3.script_noteworthy == "counterclockwise_wheel") {
              var3 rotatevelocity((0, 0, -1 * var25 / var23), var23, var24, var24);
            }
          }
        }
      }

      wait 0.1;
      GscBinSkip4(0x6e, var1, var1, var1);
    }

    if(var1.statecurr == 4) {
      foreach(var3 in var1.doors) {
        var3 moveTo(var3.origin, 0.05, 0, 0);
        var3 scripts\mp\movers::notify_moving_platform_invalid();

        if(var3.no_moving_unresolved_collisions) {
          var3.unresolved_collision_func = undefined;
        }

        if(isDefined(var3.script_noteworthy)) {
          if(var3.script_noteworthy == "clockwise_wheel" || var3.script_noteworthy == "counterclockwise_wheel") {
            var3 rotatevelocity((0, 0, 0), 0.05);
          }
        }
      }

      if(isDefined(var1.lights_off)) {
        foreach(var6 in var1.lights_off) {
          var6 show();
        }
      }

      var1.entsound stoploopsound();

      foreach(var3 in var1.doors) {
        if(isDefined(var3.interrupt_sound)) {
          var3 playSound(var3.interrupt_sound);
        }
      }

      wait 1;
    }
  }

  var1.statedone = 1;

  foreach(var3 in var1.doors) {
    var3.statedone = 1;
  }

  var1 notify("door_state_done");
}

function door_state_update_sound() {
  var0 = self;
  var1 = 1;
  var2 = 1;
  var3 = 0;

  if(var0.statecurr == 3 || var0.statecurr == 1) {
    foreach(var5 in var0.doors) {
      if(isDefined(var5.start_sound)) {
        var5 playsoundonmovingent(var5.start_sound);
        var3 = lookupsoundlength(var5.start_sound) / 1000;
        var1 = 0;
      }
    }

    if(var1) {
      if(!isDefined(var0.entsound)) {
        var0.entsound = var0;
      }

      if(var0.statecurr == 3) {
        if(soundexists("scrpt_door_wood_double_open")) {
          var3 = lookupsoundlength("scrpt_door_wood_double_open") / 1000;
          playsoundatpos(var0.entsound.origin, "scrpt_door_wood_double_open");
        }
      } else if(var0.statecurr == 1) {
        if(soundexists("scrpt_door_wood_double_close")) {
          var3 = lookupsoundlength("scrpt_door_wood_double_close") / 1000;
          playsoundatpos(var0.entsound.origin, "scrpt_door_wood_double_close");
        }
      }
    }
  }

  wait var3 * 0.3;

  if(var0.statecurr == 3 || var0.statecurr == 1) {
    foreach(var5 in var0.doors) {
      if(isDefined(var5.loop_sound)) {
        if(var5.loop_sound != "none") {
          var5 playLoopSound(var5.loop_sound);
        }

        var2 = 0;
      }
    }

    if(var2) {
      if(soundexists("")) {
        var0.entsound playLoopSound("");
        return;
      }

      return;
    }

    return;
  }
}

function door_state_change(var0, var1) {
  var2 = self;

  if(isDefined(var2.statecurr)) {
    door_state_exit(var2.statecurr);
    var2.stateprev = var2.statecurr;
  }

  var2.statecurr = var0;
  thread door_state_update(var2);
}

function door_state_exit(var0) {
  var1 = self;

  if(var0 == 0 || var0 == 2) {
    if(isDefined(var1.lights_on)) {
      foreach(var4, var3 in var1.lights_on) {
        var3 hide();
      }

      return;
    }

    return;
  }

  if(var3 == 1 || var3 == 3) {
    if(isDefined(var4.lights_off)) {
      foreach(var3 in var4.lights_off) {
        var3 hide();
      }
    }

    var4.entsound stoploopsound();

    foreach(var8 in var4.doors) {
      if(isDefined(var8.loop_sound)) {
        var8 stoploopsound();
      }
    }

    return;
  }

  if(var3 == 4) {
    return;
  }
}

function door_state_on_interrupt() {
  var0 = self;
  var0 endon("door_state_done");

  if(!isDefined(var0.trigblock)) {
    return;
  }

  var1 = [];

  foreach(var3 in var0.trigblock) {
    if(var0.statecurr == 1) {
      if(isDefined(var3.not_closing) && var3.not_closing == 1) {
        continue;
      }
    } else if(var0.statecurr == 3) {
      if(isDefined(var3.not_opening) && var3.not_opening == 1) {
        continue;
      }
    }

    var1 = var3;
  }

  if(var1.size > 0) {
    var5 = waittill_any_triggered_return_triggerer(var0, var1);

    if(!isDefined(var5.fauxdead) || var5.fauxdead == 0) {
      var0.stateinterrupted = 1;
      var0 notify("door_state_interrupted");
      return;
    }

    return;
  }
}

function waittill_any_triggered_return_triggerer(var0) {
  var1 = self;

  foreach(var3 in var0) {
    thread return_triggerer(var1);
  }

  var1 waittill("interrupted");
  return var1.interrupter;
}

function return_triggerer(var0) {
  var1 = self;
  var1 endon("door_state_done");
  var1 endon("interrupted");

  for(;;) {
    var0 waittill("trigger", var2);

    if(isDefined(var0.prone_only) && var0.prone_only == 1) {
      if(isPlayer(var2)) {
        var3 = var2 getstance();

        if(var3 != "prone") {
          continue;
        } else {
          var4 = vectorNormalize(anglesToForward(var2.angles));
          var5 = vectorNormalize(var0.origin - var2.origin);
          var6 = vectordot(var4, var5);

          if(var6 > 0) {
            continue;
          }
        }
      }
    }

    break;
  }

  var1.interrupter = var2;
  var1 notify("interrupted");
}

function button_parse_parameters(var0) {
  var1 = self;
  var1.button_sound = undefined;

  if(!isDefined(var0)) {
    var0 = "";
  }

  var2 = strtok(var0, ";");

  foreach(var4 in var2) {
    var5 = strtok(var4, "=");

    if(var5.size != 2) {
      continue;
    }

    if(var5[1] == "undefined" || var5[1] == "default") {
      var1.params[var5[0]] = undefined;
      continue;
    }

    switch (var5[0]) {
      case "open_interrupt":
        var1.open_interrupt = string_to_bool(var5[1]);
        break;
      case "button_sound":
        var1.button_sound = var5[1];
        break;
      case "start_closed":
        var1.start_closed = string_to_bool(var5[1]);
        break;
      case "one_time_use":
        var1.one_time_use = string_to_bool(var5[1]);
        break;
      default:
        break;
    }
  }
}

function door_parse_parameters(var0) {
  var1 = self;
  var1.start_sound = undefined;
  var1.stop_sound = undefined;
  var1.loop_sound = undefined;
  var1.interrupt_sound = undefined;

  if(!isDefined(var0)) {
    var0 = "";
  }

  var2 = strtok(var0, ";");

  foreach(var4 in var2) {
    var5 = strtok(var4, "=");

    if(var5.size != 2) {
      continue;
    }

    if(var5[1] == "undefined" || var5[1] == "default") {
      var1.params[var5[0]] = undefined;
      continue;
    }

    switch (var5[0]) {
      case "stop_sound":
        var1.stop_sound = var5[1];
        break;
      case "interrupt_sound":
        var1.interrupt_sound = var5[1];
        break;
      case "loop_sound":
        var1.loop_sound = var5[1];
        break;
      case "open_interrupt":
        var1.open_interrupt = string_to_bool(var5[1]);
        break;
      case "start_sound":
        var1.start_sound = var5[1];
        break;
      case "unresolved_collision_nodes":
        var1.unresolved_collision_nodes = getnodearray(var5[1], "targetname");
        break;
      case "no_moving_unresolved_collisions":
        var1.no_moving_unresolved_collisions = string_to_bool(var5[1]);
        break;
      case "material":
        var1.material = var5[1];
        break;
      default:
        break;
    }
  }
}

function trigger_parse_parameters(var0) {
  var1 = self;

  if(!isDefined(var0)) {
    var0 = "";
  }

  var2 = strtok(var0, ";");

  foreach(var4 in var2) {
    var5 = strtok(var4, "=");

    if(var5.size != 2) {
      continue;
    }

    if(var5[1] == "undefined" || var5[1] == "default") {
      var1.params[var5[0]] = undefined;
      continue;
    }

    switch (var5[0]) {
      case "not_opening":
        var1.not_opening = string_to_bool(var5[1]);
        break;
      case "not_closing":
        var1.not_closing = string_to_bool(var5[1]);
        break;
      case "prone_only":
        var1.prone_only = string_to_bool(var5[1]);
        break;
      default:
        break;
    }
  }
}

function string_to_bool(var0) {
  var1 = undefined;

  switch (var0) {
    case "true":
    case "1":
      var1 = 1;
      break;
    case "false":
    case "0":
      var1 = 0;
      break;
    default:
      break;
  }

  return var1;
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
    var0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(var0.size > 0) {
      foreach(var2 in var0) {
        if(bashproxcheck(var2) && shouldbashopen(var2)) {
          thread bashopen(var2, var2.origin);
        }
      }

      waitframe();
      continue;
    }

    wait 0.1;
  }
}

function bashproxcheck(var0) {
  var1 = distancesquared(var0.origin, self.doorcenter);
  var2 = 4900;
  return var1 < var2;
}

function shouldbashopen(var0) {
  if(!scripts\mp\utility\player::isreallyalive(var0)) {
    return false;
  }

  var1 = anglesToForward(var0.angles);

  if(scripts\engine\utility::within_fov(var0.origin + var1 * -45, var0.angles, self.doorcenter, cos(43))) {
    var2 = anglestoright(self.angles);
    var3 = vectorNormalize(self.doorcenter - var0 getEye());
    var4 = vectordot(var1, var3);
    var5 = vectordot(var1, var2);
    var6 = var0 getvelocity();
    var7 = vectordot(vectorNormalize(var6), (0, 0, 1));

    if((length(var6) >= 200 || var0 scripts\mp\utility\killstreak::isjuggernaut() && length(var6) >= 140) && abs(var7) < 0.75 && abs(var5) > 0.75 && var4 > 0.75) {
      var8 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(var8)) {
        var9 = scripts\engine\trace::ray_trace(var0 getEye(), var8, var0, level.doorcontentoverride, 0);

        if(isDefined(var9["entity"]) && var9["entity"] == self) {
          return true;
        }
      } else {
        return true;
      }
    }
  }

  return false;
}

function bashopen(var0, var1) {
  thread checktriggeralarm(var0);
  thread changestate(5);

  if(istrue(self.bashed)) {
    return;
  }

  if(!isDefined(self.useprompt)) {
    self.bashed = 1;
  }

  var2 = self.origin;
  var3 = self.angles;
  var4 = anglestoright(var3);
  var5 = vectorNormalize(var1 - self.origin);
  var6 = vectordot(var4, var5);
  var7 = var6 > 0;
  var8 = undefined;

  if(isDefined(var0) && isPlayer(var0)) {
    if(!isai(var0)) {
      thread bashpresentation(var0);
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

  if(var7) {
    var8 = self.baseangles[1] + self.max_yaw_left;
  } else {
    var8 = self.baseangles[1] - self.max_yaw_right;
  }

  if(var8 > 360) {
    var8 -= 360;
  } else if(var8 < 0) {
    var8 += 360;
  }

  var9 = 0.35;
  var10 = 0.15;
  var11 = scripts\engine\math::normalize_value(0, 170, var8);
  var12 = scripts\engine\math::factor_value(var9, var10, var11);
  var13 = self.angles;
  var14 = var13[1];

  if(var14 > 360) {
    var14 -= 360;
  } else if(var14 < 0) {
    var14 += 360;
  }

  var15 = angle_diff(var14, self.baseangles[1]);
  var16 = angle_diff(var8, self.baseangles[1]);
  var17 = anglesToForward(var13);
  var18 = anglestoright(self.baseangles);
  var19 = vectordot(var17, var18) < 0;

  if(var7) {
    if(!var19) {
      var16 += var15;
    } else {
      var16 -= var15;
    }
  } else {
    if(var19) {
      var16 += var15;
    } else {
      var16 -= var15;
    }

    var16 *= -1;
  }

  var20 = (0, var16, 0);
  self rotateby(var20, var12);
  wait var12;
  self.lastpushtime = gettime();
  thread changestate(6);

  if(!isDefined(self.useprompt)) {
    self.statecurr = 2;

    if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      self.trigger setHintString(&"MP/DOOR_USE_CLOSE");
    }
  }

  self.bashed = 0;
  var21 = randomfloatrange(3, 5);
  var22 = randomfloatrange(0.25, 2.5);

  if(var7) {
    var22 *= -1;
  }

  self rotateYaw(var22, var21, 0.5, var21 - 0.5);
}

function bashpresentation(var0) {
  var0 playRumbleOnEntity("grenade_rumble");
  var0 earthquakeforplayer(0.35, 0.5, var0.origin, 200);
}

function monitordamage() {
  self endon("stateChanged");
  self notify("monitorDamage");
  self endon("monitorDamage");
  self setCanDamage(1);
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var12 = undefined;

  for(;;) {
    self waittill("damage", var0, var1, var2, var13, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);

    if(isDefined(var3)) {
      if(var3 == "MOD_MELEE") {
        if(istrue(self.issaloonstyle)) {
          thread bashopen(self.otherdoor, var1);
        }

        thread bashopen(var1, var1.origin);
        continue;
      }

      if(var3 == "MOD_EXPLOSIVE" || var3 == "MOD_GRENADE" || var3 == "MOD_GRENADE_SPLASH" || var3 == "MOD_PROJECTILE") {
        var14 = isDefined(var8) && isDefined(var8.basename) && (var8.basename == "molotov_mp" || var8.basename == "thermite_mp" || var8.basename == "thermite_ap_mp" || var8.basename == "thermite_av_mp");

        if(var0 > 10 && !var14) {
          thread bashopen(var12, var13);
        }

        continue;
      }

      if(isDefined(var8) && var8.basename == "pac_sentry_turret_mp" && (var3 == "MOD_PROJECTILE" || var3 == "MOD_PROJECTILE_SPLASH")) {
        thread bashopen(var12, var13);
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
    self.useprompt waittill("trigger_progress", var0);

    if(var0 meleeButtonPressed()) {
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var1 = 0;

    while(var1 < 0.1) {
      if(!var0 useButtonPressed()) {
        break;
      }

      var1 += level.framedurationseconds;
      waitframe();
    }

    if(self.state == 7) {
      var2 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(var2)) {
        playsoundatpos(var2, "door_locked");
      } else {
        playsoundatpos(self.origin + (0, 0, 42), "door_locked");
      }

      continue;
    }

    if(self.islean) {
      thread cheapopen(var0);
      return;
    }

    if(1 && var0 playerads() > 0.9) {
      thread ajar(var0);
      return;
    }

    thread cheapopen(var0);
  }
}

function cheapopen(var0) {
  thread checktriggeralarm(var0);
  var1 = self.useprompt.origin;
  var2 = self.angles;
  var3 = anglestoright(var2);
  var4 = vectorNormalize(var0.origin - var1);
  var5 = vectordot(var3, var4);
  var6 = var5 > 0;

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
  var7 = scripts\engine\utility::ter_op(var6, self.max_yaw_left, self.max_yaw_right * -1);
  var8 = (self.baseangles[0], self.baseangles[1] + var7, self.baseangles[2]);
  self rotateTo(var8, 0.666, 0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    var7 = scripts\engine\utility::ter_op(!var6, self.otherdoor.max_yaw_left, self.otherdoor.max_yaw_right * -1);
    var8 = (self.otherdoor.baseangles[0], self.otherdoor.baseangles[1] + var7, self.otherdoor.baseangles[2]);
    self.otherdoor rotateTo(var8, 0.666, 0, 0.333);
  }

  wait 0.666;
  self.lastpushtime = gettime();
  thread changestate(2);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    thread changestate(self.otherdoor);
    return;
  }
}

function ajar(var0) {
  thread checktriggeralarm(var0);
  thread changestate(6);
  var1 = self.useprompt.origin;
  var2 = self.angles;
  var3 = anglestoright(var2);
  var4 = vectorNormalize(var0.origin - var1);
  var5 = vectordot(var3, var4);
  var6 = var5 > 0;
  var7 = 0.5;
  var8 = scripts\engine\utility::ter_op(var6, 15, -15);
  var0 playRumbleOnEntity("damage_heavy");

  if(isDefined(self.material)) {
    if(self.material == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_start_peek");
    } else if(self.material == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_start_peek");
    }
  } else {
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_start_peek");
  }

  self rotateYaw(var8, var7, var7 * 0.25, var7 * 0.75);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    thread changestate(self.otherdoor);
    var8 = scripts\engine\utility::ter_op(!var6, 15, -15);
    self.otherdoor rotateYaw(var8, var7, var7 * 0.25, var7 * 0.75);
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
    var0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(var0.size > 0) {
      foreach(var2 in var0) {
        if(pushproxcheck(var2)) {
          push(var2);
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

function pushproxcheck(var0) {
  self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  if(var0.origin[2] > self.origin[2] + self.height || var0.origin[2] + 70 < self.origin[2]) {
    return false;
  }

  var1 = distance2dsquared(var0.origin, self.doorcenter);
  var2 = 900;
  return var1 < var2;
}

function push(var0) {
  var1 = 26;
  var2 = 0;
  var3 = 25;
  var4 = self.origin + anglesToForward(self.angles) * 28;
  var5 = distance2d(var0.origin, var4);
  var6 = scripts\engine\math::normalize_value(var2, var1, var5);
  var7 = var3 * (1 - var6);

  if(var7 == 0) {
    return;
  }

  var8 = self.useprompt.origin;
  var9 = self.angles;
  var10 = anglestoright(var9);
  var11 = vectorNormalize(var0.origin - var8);
  var12 = vectordot(var10, var11);
  var13 = var12 > 0;
  var14 = self.angles[1];
  var15 = scripts\engine\utility::ter_op(var13 == 1, 1, -1);
  var16 = var14 + var7 * var15;
  var17 = angle_diff(var16, self.baseangles[1]);

  if(var13) {
    if(var17 > self.max_yaw_left) {
      self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
      self.angles = (self.angles[0], self.baseangles[1] + self.max_yaw_left, self.angles[2]);
      return;
    }
  } else if(var17 > self.max_yaw_right) {
    self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
    self.angles = (self.angles[0], self.baseangles[1] - self.max_yaw_right, self.angles[2]);
    return;
  }

  self.angles = (self.angles[0], var16, self.angles[2]);
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
        var0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

        if(var0.size == 0) {
          thread closedoor(1);
        }
      }
    }

    waitframe();
  }
}

function changestate(var0) {
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

  self.state = var0;
  self notify("stateChanged");

  switch (var0) {
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
    self.useprompt waittill("trigger_progress", var0);

    if(var0 meleeButtonPressed()) {
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    var1 = 0;

    while(var1 < 0.1) {
      if(!var0 useButtonPressed()) {
        break;
      }

      var1 += level.framedurationseconds;
      waitframe();
    }

    thread closedoor();
  }
}

function closedoor(var0) {
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
  var1 = 0.666;

  if(istrue(var0)) {
    var1 *= 3;
  }

  self rotateTo(self.baseangles, var1, 0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    self.otherdoor rotateTo(self.otherdoor.baseangles, var1, 0, 0.333);
  }

  wait var1;
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

function angle_diff(var0, var1) {
  return 180 - abs(abs(var0 - var1) - 180);
}

function amortizeyawtraces() {
  level.doorphase = 0;
  level.doortracequeue = 0;
  var0 = [];
  var1 = [];
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

function get_max_yaw(var0) {
  if(var0) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  var1 = 90;
  var2 = 10;
  var3 = 0;

  while(level.doorphase < 3) {
    var3 = get_max_yaw_internal(var1, var2, var0);

    if(var0) {
      self.max_yaw_left = var3;
    } else {
      self.max_yaw_right = var3;
    }

    if(var3 == 100) {
      break;
    }

    var2 *= 0.5;
    var1 = var3 + var2;
    level waittill("advance_door_trace");
  }

  var3 = max(var3, 90);

  if(var0) {
    self.max_yaw_left = var3;
    return;
  }

  self.max_yaw_right = var3;
}

function get_max_yaw_internal(var0, var1, var2) {
  if(!isDefined(self.traces)) {
    self.traces = 0;
  }

  if(!isDefined(level.doortraces)) {
    level.doortraces = 0;
  }

  var3 = 0;
  var4 = 0;
  level.doortracequeue++;
  waitframe();

  while(!var4) {
    if(var0 > 100) {
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

    var5 = yaw_collision_check(var0, var1, var2);

    if(var5) {
      if(var3) {
        var6 = 1;
      }

      var0 += var1;
    } else {
      if(!var3) {
        var3 = 1;
      }

      var0 -= var1;
      var4 = 1;
    }

    self.traces++;
    level.doortraces++;
    var7 = gettime();

    if(!isDefined(level.doortraceframetime) || level.doortraceframetime != var7) {
      level.doortraceframetime = var7;
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
  return var0;
}

function yaw_collision_check(var0, var1, var2) {
  if(!var2) {
    var0 *= -1;
  }

  var3 = self.baseangles + (0, var0, 0);
  var4 = self.origin + (0, 0, 8);
  var5 = self.height - 16;
  var6 = anglesToForward(var3);
  var7 = anglestoright(var3);

  if(var2) {
    var7 *= -1;
  }

  var8 = var4 + var6 * self.length * 0.2;
  var9 = var4 + var6 * (self.length - 2);
  var10 = scripts\engine\trace::capsule_trace(var8, var9, 2, var5, var3, scripts\engine\utility::ter_op(isDefined(self.clip), [self, self.clip], [self]), level.doorcontentoverride, 0);

  if(getdvarint("scr_door_debug")) {
    var11 = (1, 1, 1);

    if(var10["fraction"] == 1) {
      var11 = (0, 1, 0);
    } else {
      var11 = (1, 0, 0);
    }

    thread scripts\mp\utility\debug::drawline(var8, var9, 600, var11);
    thread scripts\mp\utility\debug::drawline(var8 + (0, 0, var5), var9 + (0, 0, var5), 600, var11);
    thread scripts\mp\utility\debug::drawline(var8, var8 + (0, 0, var5), 600, var11);
    thread scripts\mp\utility\debug::drawline(var9, var9 + (0, 0, var5), 600, var11);
  }

  return var10["fraction"] == 1;
}

function perk_doorsensethink() {
  level endon("game_ended");

  for(;;) {
    foreach(var1 in level.doors) {
      if(var1.state != 0) {
        continue;
      }

      if(isDefined(level.playerswithdoorsense) && level.playerswithdoorsense <= 0) {
        continue;
      }

      var2 = scripts\mp\utility\player::getplayersinradius(var1.origin, 128);

      if(var2.size == 0) {
        continue;
      }

      foreach(var4 in var2) {
        if(var4 scripts\mp\utility\perk::_hasperk("specialty_door_sense")) {
          perk_doorsense_outlinedoor(var4, var2, var1);
        }
      }
    }

    wait 0.1;
  }
}

function perk_doorsense_outlinedoor(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var1) {
    if(var5.team != var0.team) {
      var3 = var5;
    }
  }

  if(var3.size == 0) {
    return;
  }

  foreach(var8 in var3) {
    if(perk_doorsense_othersideofdoorcheck(var0, var8, var2)) {
      var9 = scripts\mp\utility\outline::outlineenableforplayer(var2, var0, "outline_nodepth_orange", "equipment");
      thread perk_doorsense_trackoutlinedisable(var9, var2);
    }
  }
}

function perk_doorsense_outlineenemies(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var1) {
    if(var5.team != var0.team) {
      var3 = var5;
    }
  }

  if(var3.size == 0) {
    return;
  }

  foreach(var8 in var3) {
    if(perk_doorsense_othersideofdoorcheck(var0, var8, var2)) {
      var9 = scripts\mp\utility\outline::outlineenableforplayer(var8, var0, "outline_nodepth_orange", "equipment");
      thread perk_doorsense_trackoutlinedisable(var9, var8);
    }
  }
}

function perk_doorsense_othersideofdoorcheck(var0, var1, var2) {
  var3 = vectorNormalize(anglestoright(var2.angles));
  var4 = vectorNormalize(var0.origin - var2.origin);
  var5 = vectorNormalize(var1.origin - var2.origin);
  var6 = vectordot(var3, var4);
  var7 = vectordot(var3, var5);

  if(var6 > 0 && var7 < 0 || var6 < 0 && var7 > 0) {
    return true;
  }

  return false;
}

function perk_doorsense_trackoutlinedisable(var0, var1) {
  wait 0.2;
  scripts\mp\utility\outline::outlinedisable(var0, var1);
}

function onplayerspawned() {
  var0 = scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("scr_door_breach_unrestricted", 0) == 1;
  updatealldoorslockvisibilityforplayer(self, var0);
  var1 = scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
  updatealldoorsalarmvisibilityforplayer(self, var1);
}

function updatelockpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(var1 in level.players) {
    var2 = var1 scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("scr_door_breach_unrestricted", 0) == 1;
    updatelockpromptvisibilityforplayer(var1, var2);
  }
}

function updatealldoorslockvisibilityforplayer(var0, var1) {
  foreach(var3 in level.doors) {
    updatelockpromptvisibilityforplayer(var3, var0, var1);
  }
}

function updatelockpromptvisibilityforplayer(var0, var1) {
  if(!isDefined(self.lockprompt)) {
    return;
  }

  var2 = self.state == 0 || self.state == 7;

  if(var2 && isDefined(self.otherdoor)) {
    var2 = self.otherdoor.state == 0 || self.otherdoor.state == 7;
  }

  if(!istrue(self.breaching) && var2) {
    if(var1) {
      self.lockprompt showtoplayer(var0);
      self.lockprompt enableplayeruse(var0);
      return;
    }

    self.lockprompt hidefromplayer(var0);
    self.lockprompt disableplayeruse(var0);
    return;
  }

  self.lockprompt hidefromplayer(var0);
  self.lockprompt disableplayeruse(var0);
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
    self.lockprompt waittill("trigger", var0);

    if(!scripts\mp\utility\player::isreallyalive(var0)) {
      continue;
    }

    if(var0 meleeButtonPressed()) {
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
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

  foreach(var1 in level.players) {
    var2 = var1 scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
    updatealarmpromptsvisibilityforplayer(var1, var2);
  }
}

function updatealldoorsalarmvisibilityforplayer(var0, var1) {
  foreach(var3 in level.doors) {
    updatealarmpromptsvisibilityforplayer(var3, var0, var1);
  }
}

function updatealarmpromptsvisibilityforplayer(var0, var1) {
  if(!isDefined(self.alarmprompts)) {
    return;
  }

  foreach(var3 in self.alarmprompts) {
    var4 = var1 && self.state == 0 || self.state == 8 && isDefined(self.dooralarmprompt) && var3 == self.dooralarmprompt;

    if(var4 && isDefined(self.otherdoor)) {
      var4 = var1 && self.otherdoor.state == 0 || self.state == 8 && var3 == self.dooralarmprompt;
    }

    if(var4) {
      var3 showtoplayer(var0);
      var3 enableplayeruse(var0);
      continue;
    }

    var3 hidefromplayer(var0);
    var3 disableplayeruse(var0);
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

  foreach(var1 in self.alarmprompts) {
    var1 setHintString(&"MP/DOOR_USE_ALARM");
    var1 setuseholdduration("duration_medium");
  }

  updatealarmpromptvisibility();

  foreach(var1 in self.alarmprompts) {
    thread _alarmmonitorinternal(var1);
  }
}

function _alarmmonitorinternal(var0) {
  self endon("stateChanged");

  for(;;) {
    var0 waittill("trigger", var1);

    if(self.state != 0) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var1)) {
      continue;
    }

    if(var1 meleeButtonPressed()) {
      continue;
    }

    if(var1 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    thread alarmdoor(var1, var0);
  }
}

function alarmdoor(var0, var1) {
  var2 = self gettagorigin("tag_door_handle");
  playsoundatpos(var1.origin, "mp_door_alarm_on");
  self.dooralarment = spawn("script_model", var1.origin);
  self.dooralarment setModel("shardball_wm");
  self.dooralarment.angles = self.angles;
  self.dooralarment linkTo(self);
  self.dooralarment setentityowner(var0);
  self.dooralarment setotherent(var0);
  self.dooralarment setscriptablepartstate("effects", "planted", 0);
  self.dooralarmowner = var0;
  self.dooralarmprompt = var1;
  self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_add(self.dooralarmowner.alarmeddoors, self);

  while(self.dooralarmowner.alarmeddoors.size > 3) {
    var3 = self.dooralarmowner.alarmeddoors[0];
    removealarmdoor(var3, 0);
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
    self.dooralarmprompt waittill("trigger", var0);

    if(self.state != 8) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var0)) {
      continue;
    }

    if(var0 meleeButtonPressed()) {
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
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

function removealarmdoor(var0) {
  if(var0) {
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

function checktriggeralarm(var0) {
  if(self.state != 8) {
    return;
  }

  var1 = self;

  if(!isDefined(self.dooralarment) && isDefined(self.otherdoor)) {
    var1 = self.otherdoor;
  }

  if(!isDefined(var1.dooralarmowner)) {
    return;
  }

  var2 = var1.dooralarment;
  var3 = var1.dooralarmowner;
  var1.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(var1.dooralarmowner.alarmeddoors, var1);
  var1.dooralarment = undefined;
  var1.dooralarmowner = undefined;
  var1.dooralarmprompt = undefined;
  var3 scripts\mp\killstreaks\killstreaks::givescorefortriggeredalarmeddoor();

  if(isDefined(self.otherdoor)) {
    thread changestate(self.otherdoor);
  }

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var0, var3))) {
    var2 playLoopSound("mp_door_alarm_lp");
    pinglocationenemyteams(self.origin, var0.team);
    var2 setscriptablepartstate("effects", "triggered", 0);
    wait 4;
    var2 stoploopsound();
    var2 delete();
    return;
  }

  playsoundatpos(var2.origin, "mp_door_alarm_off");
  var2 setscriptablepartstate("effects", "neutral", 0);
  var2 delete();
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
    self.lockprompt waittill("trigger", var0);

    if(var0 meleeButtonPressed()) {
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(var0 issprinting() || var0 issprintsliding()) {
      continue;
    }

    if(var0 ismantling()) {
      continue;
    }

    if(istrue(self.breaching)) {
      continue;
    }

    thread breachdoor(var0);
  }
}

function breachdoor(var0) {
  thread plantbreach(var0);
}

function monitorbreachmelee() {
  self endon("stateChanged");
  self notify("monitorBreachMelee");
  self endon("monitorBreachMelee");
  self.lockedmeleehealth = 150;
  self setCanDamage(1);
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var12 = undefined;

  for(;;) {
    self waittill("damage", var0, var1, var2, var13, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);

    if(isDefined(var3) && !istrue(self.breaching)) {
      if(var3 == "MOD_MELEE" || var3 == "MOD_EXPLOSIVE" || var3 == "MOD_GRENADE" || var3 == "MOD_GRENADE_SPLASH" || var3 == "MOD_PROJECTILE") {
        var14 = isDefined(var8) && isDefined(var8.basename) && (var8.basename == "molotov_mp" || var8.basename == "thermite_mp" || var8.basename == "thermite_ap_mp" || var8.basename == "thermite_av_mp");

        if(var14) {
          continue;
        }

        self.lockedmeleehealth -= var0;

        if(isDefined(self.otherdoor)) {
          self.otherdoor.lockedmeleehealth -= var0;
        }

        if(self.lockedmeleehealth < 1) {
          if(isDefined(self.otherdoor) || istrue(self.issaloonstyle)) {
            thread updatelocklight(self.otherdoor);
            thread bashopen(self.otherdoor, var1);
          }

          thread updatelocklight("off");
          thread bashopen(var1, var1.origin);
          continue;
        }

        playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");
      }
    }
  }
}

#using_animtree("script_model");

function plantbreach(var0) {
  if(isDefined(self.otherdoor) && istrue(self.otherdoor.breaching)) {
    return;
  }

  self.breaching = 1;
  thread updatelockpromptvisibility();
  thread watchplayerdeath(var0);
  var1 = self.origin;
  var2 = self.angles;
  var3 = anglestoright(var2);
  var4 = vectorNormalize(var0.origin - self.origin);
  var5 = vectordot(var3, var4);
  var6 = var5 > 0;

  if(var6) {
    var7 = self.rightplantorg;
    var8 = self.rightplantang;
  } else {
    var7 = self.leftplantorg;
    var8 = self.leftplantang;
  }

  var2.linktoent = var2 scripts\engine\utility::spawn_tag_origin();
  var2 playerlinktodelta(var2.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var9 = scripts\engine\utility::spawn_tag_origin(var7, var8);
  var2.linktoent moveTo(var7, 0.25, 0.1, 0.1);
  var2.linktoent rotateTo(var8, 0.25, 0.1, 0.1);
  var2 setstance("stand");

  if(!istrue(givegunless(var2))) {
    var2 unlink();
    var2.linktoent delete();
    var2.linktoent = undefined;
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  var2 unlink();
  var2.linktoent delete();
  var2.linktoent = undefined;
  var2 setOrigin(var7);
  var2 setplayerangles(var8);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var2, "c4_plant");
  var10 = scripts\engine\utility::ter_op(var2.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard") {
    var10 = scripts\engine\utility::ter_op(var2.team == "allies", "ukp1", "abp1");
  }

  var2 queuedialogforplayer("dx_mpp_" + var10 + "_breach_plant", "cop_breach_plant", 2);
  thread create_player_rig(var2, "planter");
  var9 thread scripts\mp\anim::anim_player_solo(var2, var2.player_rig, "plant");
  var11 = spawn("script_model", var7);
  var11 setModel("offhand_wm_c4");
  var11.animname = "c4";
  var11 useanimtree(#animtree);
  self.plantedbomb = var11;
  var9 thread scripts\common\anim::anim_single_solo(var11, "plant");
  var12 = getanimlength(level.scr_anim["planter"]["plant"]);
  var13 = 0.5;
  wait var12 - var13;

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  thread bomb_planted_think(var2, var8);
  givebreachscore(var2);
  wait var13;

  if(var2 isviewmodelanimplaying()) {
    var2 stopviewmodelanim();
  }

  thread takegunless();
  remove_player_rig(var2);
  return 1;
}

function bomb_planted_think(var0, var1) {
  var2 = var0.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex)) {
      level.breachindex = 0;
    } else {
      level.breachindex++;
    }

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(var2);

  if(!self.defused) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var3 = self.doorcenter;

    if(var1) {
      var4 = self.rightplantang;
    } else {
      var4 = self.leftplantang;
    }

    var5 = spawnfx(level._effect["breach_explode"], var4, anglesToForward(var4) * -1, (0, 0, 1));
    triggerfx(var5);
    physicsexplosionsphere(var4, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var4);
    earthquake(0.5, 1, var4, 1500);
    var1 scripts\mp\utility\weapon::_launchgrenade("flash_grenade_mp", self.plantedbomb.origin + anglesToForward(var4) * 100, (0, 0, 0), 0.05, 1);
    var1 scripts\mp\utility\weapon::_launchgrenade("concussion_grenade_mp", self.plantedbomb.origin + anglesToForward(var4) * 100, (0, 0, 0), 0.05, 1);
    wait 0.1;

    if(isDefined(var1)) {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 50, 10, 5, var1, "MOD_EXPLOSIVE", "bomb_site_mp");
    } else {
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 100, 50, 5, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    thread bashopen(var1, self.plantedbomb.origin);

    if(isDefined(self.otherdoor)) {
      thread bashopen(self.otherdoor, var1);
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

function bomb_fuse_think(var0) {
  self notify("breach_planted");
  self.timerobject = spawn("script_model", self.plantedbomb.origin);
  var1 = gettime();
  var2 = int(var1 + 1000);
  setomnvar("ui_ingame_timer_" + self.breachindex, var2);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, self.timerobject);
  var3 = var2 - var1;

  while(!self.defused && var3 > 0) {
    var1 = gettime();
    var3 = var2 - var1;

    if(var3 < 1500) {
      if(var3 <= 250) {
        self.plantedbomb playSound("breach_warning_beep_05");
      } else if(var3 < 500) {
        self.plantedbomb playSound("breach_warning_beep_04");
      } else if(var3 < 1500) {
        self.plantedbomb playSound("breach_warning_beep_03");
      } else {
        self.plantedbomb playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var3 < 3500) {
      self.plantedbomb playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self.plantedbomb playSound("breach_warning_beep_01");
      wait 1;
    }

    if(var3 < 0) {
      break;
    }
  }
}

function watchplayerdeath(var0) {
  self endon("breach_planted");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var0) || !scripts\mp\utility\player::isreallyalive(var0)) {
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

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0.player_rig = spawn("script_model", var0.origin);
  var0.player_rig setModel(var2);
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var1 = var0 getdroptofloorposition(var0.origin);

  if(isDefined(var1)) {
    var0 setOrigin(var1);
  } else {
    var0 setOrigin(var0.origin + (0, 0, 100));
  }

  var0.player_rig delete();
  var0.player_rig = undefined;
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a5("remove_rig", "death_or_disconnect");
}

function givebreachscore(var0) {
  var1 = "breach";
  var2 = scripts\mp\rank::getscoreinfovalue(var1);
  var0 thread scripts\mp\rank::giverankxp(var1, var2);
  var0 thread scripts\mp\rank::scoreeventpopup(var1);
}

function givegunless() {
  self endon("death_or_disconnect");
  var0 = getcompleteweaponname("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);
  var1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 0);

  if(var1) {
    self.gunnlessweapon = var0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::allow_melee(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var1;
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

function updatelocklight(var0) {
  if(!isDefined(self.locklight)) {
    return;
  }

  self notify("updateLockLight");
  self endon("updateLockLight");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  self.locklight setscriptablepartstate("marker", var0);
}

function linkdoubledoors() {
  foreach(var1 in level.doors) {
    if(isDefined(var1.otherdoor)) {
      continue;
    }

    foreach(var3 in level.doors) {
      if(var3 == var1) {
        continue;
      }

      var4 = var1 gettagorigin("tag_door_handle", 1);
      var5 = var3 gettagorigin("tag_door_handle", 1);

      if(!isDefined(var4) || !isDefined(var5)) {
        continue;
      }

      var6 = distancesquared(var4, var5);

      if(var6 < 225) {
        if(var6 < 100) {
          var1.issaloonstyle = 1;
          var3.issaloonstyle = 1;
        }

        var3.otherdoor = var1;
        var1.otherdoor = var3;

        if(isDefined(var1.lockprompt) && isDefined(var3.lockprompt)) {
          var3.lockprompt delete();
          var3.lockprompt = var1.lockprompt;
          var7 = (var4 + var5) * 0.5 + (0, 0, 15);
          var1.lockprompt unlink();
          var1.lockprompt.origin = var7;
          thread changestate(var1);
          thread changestate(var3);
          var1.leftplantorg = (var7[0], var7[1], var1.origin[2]) + anglestoright(var1.baseangles) * -24.5;
          var1.leftplantang = (0, var1.baseangles[1] - 90, 0);
          var1.rightplantorg = (var7[0], var7[1], var1.origin[2]) + anglestoright(var1.baseangles) * 24.5;
          var1.rightplantang = (0, var1.baseangles[1] + 90, 0);
          var3.leftplantorg = (var7[0], var7[1], var3.origin[2]) + anglestoright(var3.baseangles) * -24.5;
          var3.leftplantang = (0, var3.baseangles[1] - 90, 0);
          var3.rightplantorg = (var7[0], var7[1], var3.origin[2]) + anglestoright(var3.baseangles) * 24.5;
          var3.rightplantang = (0, var3.baseangles[1] + 90, 0);
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