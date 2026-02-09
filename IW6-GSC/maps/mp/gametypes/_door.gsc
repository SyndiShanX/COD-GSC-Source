/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_door.gsc
***************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

DEFAULT_DOOR_MOVE_TIME_SEC = 3.0;
DEFAULT_DOOR_PAUSE_TIME_SEC = 1.0;

DEFAULT_WHEEL_DIAMETER = 30.0;

STATE_DOOR_CLOSED = 0;
STATE_DOOR_CLOSING = 1;
STATE_DOOR_OPEN = 2;
STATE_DOOR_OPENING = 3;
STATE_DOOR_PAUSED = 4;

SPAWNFLAG_DYNAMIC_PATH = 1;
SPAWNFLAG_AI_SIGHT_LINE = 2;

door_system_init(triggerName) {
  buttons = getEntArray(triggerName, "targetname");

  foreach(button in buttons) {
    if(isDefined(button.script_parameters)) {
      button button_parse_parameters(button.script_parameters);
    }
    button door_setup();
  }

  foreach(button in buttons) {
    button thread door_think();
  }
}

door_setup() {
  button = self;

  AssertEx(isDefined(button.target), "door_setup() found switch without at least one door target.");

  button.doors = [];

  if(isDefined(button.script_index)) {
    button.doorMoveTime = max(0.1, Float(button.script_index) / 1000);
  }

  targetEnts = getEntArray(button.target, "targetname");
  foreach(ent in targetEnts) {
    if(IsSubStr(ent.classname, "trigger")) {
      if(!isDefined(button.trigBlock)) {
        button.trigBlock = [];
      }
      if(isDefined(ent.script_parameters)) {
        ent trigger_parse_parameters(ent.script_parameters);
      }
      if(isDefined(ent.script_linkTo)) {
        linked_door = GetEnt(ent.script_linkTo, "script_linkname");
        ent EnableLinkTo();
        ent LinkTo(linked_door);
      }

      button.trigBlock[button.trigBlock.size] = ent;
    } else if(ent.classname == "script_brushmodel" || ent.classname == "script_model") {
      if(isDefined(ent.script_noteworthy) && IsSubStr(ent.script_noteworthy, "light")) {
        if(IsSubStr(ent.script_noteworthy, "light_on")) {
          if(!isDefined(button.lights_on)) {
            button.lights_on = [];
          }

          ent Hide();
          button.lights_on[button.lights_on.size] = ent;
        } else if(IsSubStr(ent.script_noteworthy, "light_off")) {
          if(!isDefined(button.lights_off)) {
            button.lights_off = [];
          }

          ent Hide();
          button.lights_off[button.lights_off.size] = ent;
        } else {
          AssertMsg("Invalid light ent with script_noteworthy of: " + ent.script_noteworthy);
        }
      } else if(ent.spawnflags &SPAWNFLAG_AI_SIGHT_LINE) {
        if(!isDefined(button.ai_sight_brushes)) {
          button.ai_sight_brushes = [];
        }

        ent NotSolid();
        ent Hide();
        ent SetAISightLineVisible(false);
        button.ai_sight_brushes[button.ai_sight_brushes.size] = ent;
      } else {
        button.doors[button.doors.size] = ent;
      }
    } else if(ent.classname == "script_origin") {
      button.entSound = ent;
    }
  }

  if(!isDefined(button.entSound) && button.doors.size) {
    button.entSound = SortByDistance(button.doors, button.origin)[0];
  }

  foreach(door in button.doors) {
    AssertEx(isDefined(door.target), "door_setup() found door without a close position struct target.");
    door.posClosed = door.origin;
    door.posOpen = getstruct(door.target, "targetname").origin;
    door.distMove = Distance(door.posOpen, door.posClosed);
    door.origin = door.posOpen;
    door.no_moving_unresolved_collisions = false;

    if(isDefined(door.script_parameters)) {
      door door_parse_parameters(door.script_parameters);
    }
  }
}

door_think() {
  button = self;

  button door_state_change(STATE_DOOR_OPEN, true);

  while(1) {
    button.stateDone = undefined;
    button.stateInterrupted = undefined;

    button waittill_any("door_state_done", "door_state_interrupted");

    if(isDefined(button.stateDone) && button.stateDone) {
      stateNext = button door_state_next(button.stateCurr);
      button door_state_change(stateNext, false);
    } else if(isDefined(button.stateInterrupted) && button.stateInterrupted) {
      button door_state_change(STATE_DOOR_PAUSED, false);
    } else {
      AssertMsg("state finished without being flagged as done or interrupted.");
    }
  }
}

door_state_next(state) {
  button = self;
  stateNext = undefined;

  if(state == STATE_DOOR_CLOSED) {
    stateNext = STATE_DOOR_OPENING;
  } else if(state == STATE_DOOR_OPEN) {
    stateNext = STATE_DOOR_CLOSING;
  } else if(state == STATE_DOOR_CLOSING) {
    stateNext = STATE_DOOR_CLOSED;
  } else if(state == STATE_DOOR_OPENING) {
    stateNext = STATE_DOOR_OPEN;
  } else if(state == STATE_DOOR_PAUSED) {
    AssertEx(isDefined(button.statePrev), "door_state_next() was passed STATE_DOOR_PAUSED without a previous state to go to.");
    stateNext = button.statePrev;
  } else {
    AssertMsg("Unhandled state value of: " + state);
  }

  return stateNext;
}

door_state_update(noSound) {
  button = self;

  button endon("door_state_interrupted");

  button.stateDone = undefined;

  if(button.stateCurr == STATE_DOOR_CLOSED || button.stateCurr == STATE_DOOR_OPEN) {
    if(!noSound) {
      foreach(door in button.doors) {
        if(isDefined(door.stop_sound)) {
          door StopLoopSound();
          door PlaySoundOnMovingEnt(door.stop_sound);
        }
      }
    }

    if(isDefined(button.lights_on)) {
      foreach(light in button.lights_on) {
        light Show();
      }
    }

    foreach(door in button.doors) {
      if(button.stateCurr == STATE_DOOR_CLOSED) {
        if(isDefined(button.ai_sight_brushes)) {
          foreach(ai_sight_brush in button.ai_sight_brushes) {
            ai_sight_brush Show();
            ai_sight_brush SetAISightLineVisible(true);
          }
        }

        if(door.spawnflags &SPAWNFLAG_DYNAMIC_PATH) {
          door DisconnectPaths();
        }
      } else {
        if(isDefined(button.ai_sight_brushes)) {
          foreach(ai_sight_brush in button.ai_sight_brushes) {
            ai_sight_brush Hide();
            ai_sight_brush SetAISightLineVisible(false);
          }
        }

        if(door.spawnflags &SPAWNFLAG_DYNAMIC_PATH) {
          if(isDefined(door.script_noteworthy) && (door.script_noteworthy == "always_disconnect")) {
            door DisconnectPaths();
          } else {
            door ConnectPaths();
          }
        }
      }

      if(isDefined(door.script_noteworthy)) {
        if((door.script_noteworthy == "clockwise_wheel") || (door.script_noteworthy == "counterclockwise_wheel")) {
          door RotateVelocity((0, 0, 0), 0.1);
        }
      }

      if(door.no_moving_unresolved_collisions) {
        door.unresolved_collision_func = undefined;
      }
    }

    hintString = ter_op(button.stateCurr == STATE_DOOR_CLOSED, &"MP_DOOR_USE_OPEN", &"MP_DOOR_USE_CLOSE");
    button SetHintString(hintString);
    button MakeUsable();
    button waittill("trigger");
    if(isDefined(button.button_sound)) {
      button playSound(button.button_sound);
    }
  } else if(button.stateCurr == STATE_DOOR_CLOSING || button.stateCurr == STATE_DOOR_OPENING) {
    if(isDefined(button.lights_off)) {
      foreach(light in button.lights_off) {
        light Show();
      }
    }

    button MakeUnusable();

    if(button.stateCurr == STATE_DOOR_CLOSING) {
      button thread door_state_on_interrupt();

      foreach(door in button.doors) {
        if(isDefined(door.script_noteworthy)) {
          timeMove = ter_op(isDefined(button.doorMoveTime), button.doorMoveTime, DEFAULT_DOOR_MOVE_TIME_SEC);
          posGoal = ter_op(button.stateCurr == STATE_DOOR_CLOSING, door.posClosed, door.posOpen);
          distRemaining = Distance(door.origin, posGoal);
          time = max(0.1, distRemaining / door.distMove * timeMove);
          timeEase = max(time * 0.25, 0.05);

          angularDistance = 360 * distRemaining / (3.14 * DEFAULT_WHEEL_DIAMETER);

          if(door.script_noteworthy == "clockwise_wheel") {
            door RotateVelocity((0, 0, -1 * angularDistance / time), time, timeEase, timeEase);
          } else if(door.script_noteworthy == "counterclockwise_wheel") {
            door RotateVelocity((0, 0, angularDistance / time), time, timeEase, timeEase);
          }
        }
      }
    } else if(button.stateCurr == STATE_DOOR_OPENING) {
      if(isDefined(button.open_interrupt) && (button.open_interrupt)) {
        button thread door_state_on_interrupt();
      }

      foreach(door in button.doors) {
        if(isDefined(door.script_noteworthy)) {
          timeMove = ter_op(isDefined(button.doorMoveTime), button.doorMoveTime, DEFAULT_DOOR_MOVE_TIME_SEC);
          posGoal = ter_op(button.stateCurr == STATE_DOOR_CLOSING, door.posClosed, door.posOpen);
          distRemaining = Distance(door.origin, posGoal);
          time = max(0.1, distRemaining / door.distMove * timeMove);
          timeEase = max(time * 0.25, 0.05);

          angularDistance = 360 * distRemaining / (3.14 * DEFAULT_WHEEL_DIAMETER);

          if(door.script_noteworthy == "clockwise_wheel") {
            door RotateVelocity((0, 0, angularDistance / time), time, timeEase, timeEase);
          } else if(door.script_noteworthy == "counterclockwise_wheel") {
            door RotateVelocity((0, 0, -1 * angularDistance / time), time, timeEase, timeEase);
          }
        }
      }
    }

    wait 0.1;

    button childthread door_state_update_sound("garage_door_start", "garage_door_loop");

    timeMove = ter_op(isDefined(button.doorMoveTime), button.doorMoveTime, DEFAULT_DOOR_MOVE_TIME_SEC);
    timeMax = undefined;
    foreach(door in button.doors) {
      posGoal = ter_op(button.stateCurr == STATE_DOOR_CLOSING, door.posClosed, door.posOpen);

      if(door.origin != posGoal) {
        time = max(0.1, Distance(door.origin, posGoal) / door.distMove * timeMove);
        timeEase = max(time * 0.25, 0.05);
        door MoveTo(posGoal, time, timeEase, timeEase);
        door maps\mp\_movers::notify_moving_platform_invalid();

        if(door.no_moving_unresolved_collisions) {
          door.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;
        }

        if(!isDefined(timeMax) || time > timeMax) {
          timeMax = time;
        }
      }
    }

    if(isDefined(timeMax)) {
      wait timeMax;
    }
  } else if(button.stateCurr == STATE_DOOR_PAUSED) {
    foreach(door in button.doors) {
      door MoveTo(door.origin, 0.05, 0.0, 0.0);
      door maps\mp\_movers::notify_moving_platform_invalid();

      if(door.no_moving_unresolved_collisions) {
        door.unresolved_collision_func = undefined;
      }

      if(isDefined(door.script_noteworthy)) {
        if((door.script_noteworthy == "clockwise_wheel") || (door.script_noteworthy == "counterclockwise_wheel")) {
          door RotateVelocity((0, 0, 0), 0.05);
        }
      }

    }

    AssertEx(isDefined(button.statePrev) && (button.statePrev == STATE_DOOR_CLOSING || button.statePrev == STATE_DOOR_OPENING), "door_state_init() called with pause state without a valid previous state.");

    if(isDefined(button.lights_off)) {
      foreach(light in button.lights_off) {
        light Show();
      }
    }

    button.entSound StopLoopSound();

    foreach(door in button.doors) {
      if(isDefined(door.interrupt_sound)) {
        door playSound(door.interrupt_sound);
      }
    }

    wait DEFAULT_DOOR_PAUSE_TIME_SEC;
  } else {
    AssertMsg("Unhandled state value of: " + button.stateCurr);
  }

  button.stateDone = true;
  foreach(door in button.doors) {
    door.stateDone = true;
  }
  button notify("door_state_done");
}

door_state_update_sound(default_soundStart, default_soundLoop) {
  button = self;

  use_default_start_sound = true;
  use_default_loop_sound = true;

  sound_length = 0;

  if((button.stateCurr == STATE_DOOR_OPENING) || (button.stateCurr == STATE_DOOR_CLOSING)) {
    foreach(door in button.doors) {
      if(isDefined(door.start_sound)) {
        door PlaySoundOnMovingEnt(door.start_sound);
        sound_length = LookupSoundLength(door.start_sound) / 1000;
        use_default_start_sound = false;
      }
    }

    if(use_default_start_sound) {
      sound_length = LookupSoundLength(default_soundStart) / 1000;
      playSoundAtPos(button.entSound.origin, default_soundStart);
    }
  }

  wait(sound_length * 0.3);

  if((button.stateCurr == STATE_DOOR_OPENING) || (button.stateCurr == STATE_DOOR_CLOSING)) {
    foreach(door in button.doors) {
      if(isDefined(door.loop_sound)) {
        if(door.loop_sound != "none") {
          door playLoopSound(door.loop_sound);
        }
        use_default_loop_sound = false;
      }
    }

    if(use_default_loop_sound) {
      button.entSound playLoopSound(default_soundLoop);
    }
  }
}

door_state_change(state, noSound) {
  button = self;
  if(isDefined(button.stateCurr)) {
    door_state_exit(button.stateCurr);
    button.statePrev = button.stateCurr;
  }

  button.stateCurr = state;

  button thread door_state_update(noSound);
}

door_state_exit(state) {
  button = self;

  if(state == STATE_DOOR_CLOSED || state == STATE_DOOR_OPEN) {
    if(isDefined(button.lights_on)) {
      foreach(light in button.lights_on) {
        light Hide();
      }
    }
  } else if(state == STATE_DOOR_CLOSING || state == STATE_DOOR_OPENING) {
    if(isDefined(button.lights_off)) {
      foreach(light in button.lights_off) {
        light Hide();
      }
    }

    button.entSound StopLoopSound();

    foreach(door in button.doors) {
      if(isDefined(door.loop_sound)) {
        door StopLoopSound();
      }
    }
  } else if(state == STATE_DOOR_PAUSED) {} else {
    AssertMsg("Unhandled state value of: " + state);
  }
}

door_state_on_interrupt() {
  button = self;

  button endon("door_state_done");

  filtered_triggers = [];

  foreach(trigger in button.trigBlock) {
    if(button.stateCurr == STATE_DOOR_CLOSING) {
      if(isDefined(trigger.not_closing) && (trigger.not_closing == true)) {
        continue;
      }
    } else if(button.stateCurr == STATE_DOOR_OPENING) {
      if(isDefined(trigger.not_opening) && (trigger.not_opening == true)) {
        continue;
      }
    }

    filtered_triggers[filtered_triggers.size] = trigger;
  }

  if(filtered_triggers.size > 0) {
    interrupter = button waittill_any_triggered_return_triggerer(filtered_triggers);

    if(!isDefined(interrupter.fauxDead) || (interrupter.fauxDead == false)) {
      button.stateInterrupted = true;
      button notify("door_state_interrupted");
    }
  }
}

waittill_any_triggered_return_triggerer(triggers) {
  button = self;
  foreach(trigger in triggers) {
    button thread return_triggerer(trigger);
  }

  button waittill("interrupted");
  return button.interrupter;
}

return_triggerer(trigger) {
  button = self;

  button endon("door_state_done");
  button endon("interrupted");

  while(1) {
    trigger waittill("trigger", ent);

    if(isDefined(trigger.prone_only) && (trigger.prone_only == true)) {
      if(isPlayer(ent)) {
        stance = ent GetStance();
        if(stance != "prone") {
          continue;
        } else {
          norm_facing_vec = VectorNormalize(anglesToForward(ent.angles));
          norm_vec_to_trig = VectorNormalize(trigger.origin - ent.origin);
          dot = VectorDot(norm_facing_vec, norm_vec_to_trig);

          if(dot > 0) {
            continue;
          }
        }
      }
    }

    break;
  }

  button.interrupter = ent;
  button notify("interrupted");
}

button_parse_parameters(parameters) {
  button = self;
  button.button_sound = undefined;

  if(!isDefined(parameters))
    parameters = "";

  params = StrTok(parameters, ";");
  foreach(param in params) {
    toks = StrTok(param, "=");
    if(toks.size != 2) {
      continue;
    }
    if(toks[1] == "undefined" || toks[1] == "default") {
      button.params[toks[0]] = undefined;
      continue;
    }

    switch (toks[0]) {
      case "open_interrupt":
        button.open_interrupt = string_to_bool(toks[1]);
        break;
      case "button_sound":
        button.button_sound = toks[1];
        break;
      default:
        break;
    }
  }
}

door_parse_parameters(parameters) {
  door = self;
  door.start_sound = undefined;
  door.stop_sound = undefined;
  door.loop_sound = undefined;
  door.interrupt_sound = undefined;

  if(!isDefined(parameters))
    parameters = "";

  params = StrTok(parameters, ";");
  foreach(param in params) {
    toks = StrTok(param, "=");
    if(toks.size != 2) {
      continue;
    }
    if(toks[1] == "undefined" || toks[1] == "default") {
      door.params[toks[0]] = undefined;
      continue;
    }

    switch (toks[0]) {
      case "stop_sound":
        door.stop_sound = toks[1];
        break;
      case "interrupt_sound":
        door.interrupt_sound = toks[1];
        break;
      case "loop_sound":
        door.loop_sound = toks[1];
        break;
      case "open_interrupt":
        door.open_interrupt = string_to_bool(toks[1]);
        break;
      case "start_sound":
        door.start_sound = toks[1];
        break;
      case "unresolved_collision_nodes":
        door.unresolved_collision_nodes = GetNodeArray(toks[1], "targetname");
        break;
      case "no_moving_unresolved_collisions":
        door.no_moving_unresolved_collisions = string_to_bool(toks[1]);
        break;
      default:
        break;
    }
  }
}

trigger_parse_parameters(parameters) {
  trigger = self;

  if(!isDefined(parameters))
    parameters = "";

  params = StrTok(parameters, ";");
  foreach(param in params) {
    toks = StrTok(param, "=");
    if(toks.size != 2) {
      continue;
    }
    if(toks[1] == "undefined" || toks[1] == "default") {
      trigger.params[toks[0]] = undefined;
      continue;
    }

    switch (toks[0]) {
      case "not_opening":
        trigger.not_opening = string_to_bool(toks[1]);
        break;
      case "not_closing":
        trigger.not_closing = string_to_bool(toks[1]);
        break;
      case "prone_only":
        trigger.prone_only = string_to_bool(toks[1]);
        break;
      default:
        break;
    }
  }
}

string_to_bool(the_string) {
  retVal = undefined;
  switch (the_string) {
    case "1":
    case "true":
      retVal = true;
      break;
    case "0":
    case "false":
      retVal = false;
      break;
    default:
      AssertMsg("Invalid string to bool convert attempted.");
      break;
  }

  return retVal;
}