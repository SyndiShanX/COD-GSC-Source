/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\door.gsc
***********************************************/

door_dynamic_setup(_id_42ECB50BA6DDAE43) {
  if(isDefined(level.doors)) {
    return;
  }
  setDvar("cg_buttonHintNaturalDistance", 150.0);
  level.doors = [];
  level.doorsetupstarted = 0;
  thread door_dynamic_setup_adapter("dynamic_door", 0);
  thread door_dynamic_setup_adapter("lean_dynamic_door", 1, _id_42ECB50BA6DDAE43);
  script_model_anims();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

door_dynamic_setup_adapter(_id_497A14A8727744F4, _id_3F79972B04564171, _id_42ECB50BA6DDAE43) {
  doors = getEntArray(_id_497A14A8727744F4, "targetname");
  level.doorsetupstarted++;
  level.doorsetupfinished = 0;
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip", "physicscontents_item"];
  contentoverride = physics_createcontents(_id_C56207BDA09B3A36);
  level.doorcontentoverride = contentoverride;

  foreach(door in doors) {
    if(isDefined(door.script_parameters))
      door door_dynamic_parse_parameters(door.script_parameters);

    door.doors = [];
    door.doors[0] = door;
    door.islean = _id_3F79972B04564171;
    door.baseangles = door.angles;

    if(door.baseangles[1] == 360)
      door.baseangles = (door.baseangles[0], 0, door.baseangles[2]);

    door.state = 0;
    doortarget = door.target;
    _id_95A8D8ADDB57380E = isDefined(door.script_noteworthy) && door.script_noteworthy == "OPEN" || getdvarint("scr_doors_open", 0) != 0;
    _id_74FB145EC8B5103D = isDefined(door.script_noteworthy) && door.script_noteworthy == "LOCKED";
    door.length = 52;
    door.height = 96;
    door.leftplantorg = door.origin + anglesToForward(door.angles) * door.length * 0.5 + anglestoright(door.angles) * -24.5;
    door.leftplantang = (0, door.baseangles[1] - 90.0, 0);
    door.rightplantorg = door.origin + anglesToForward(door.angles) * door.length * 0.5 + anglestoright(door.angles) * 24.5;
    door.rightplantang = (0, door.baseangles[1] + 90.0, 0);
    door.doorcenter = door.origin + anglesToForward(door.angles) * door.length * 0.5 + anglestoup(door.angles) * door.height * 0.5;
    door.max_yaw_left = 90;
    door.max_yaw_right = 90;
    _id_70BE37A43C5B39D5 = door gettagorigin("tag_door_handle", 1);

    if(isDefined(_id_70BE37A43C5B39D5)) {
      door scripts\mp\gameobjects::sethintobject("tag_door_handle", "HINT_BUTTON", undefined, &"MP/DOOR_USE_OPEN_DOUBLE", undefined, "duration_none", undefined, 200, 90, 72, 90);
      door.useprompt = door;
      door.useprompt setusewhenhandsoccupied(1);

      if(!_id_3F79972B04564171 && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
        door.lockprompt = scripts\mp\gameobjects::createhintobject(_id_70BE37A43C5B39D5, "HINT_BUTTON", undefined, &"MP/DOOR_USE_LOCK", undefined, undefined, "show", 200, 90, 72, 90);
        door.lockprompt linkTo(door, "tag_door_handle", (3, 0, 15), (0, 0, 0));
        door.lockprompt setusewhenhandsoccupied(1);
        door.alarmprompts = [];
        _id_32FAC41AB88D1E04 = [(4, 0, 4), (4, 0, 90)];

        foreach(offset in _id_32FAC41AB88D1E04) {
          _id_AE098E74B36DDBC4 = scripts\mp\gameobjects::createhintobject(_id_70BE37A43C5B39D5, "HINT_BUTTON", undefined, &"MP/DOOR_USE_ALARM", undefined, undefined, "show", 100, 90, 80, 20);
          _id_AE098E74B36DDBC4 linkTo(door, "tag_origin", offset, (0, 0, 0));
          _id_AE098E74B36DDBC4 setusewhenhandsoccupied(0);
          _id_3FA8302C3EB6F7B6 = _id_AE098E74B36DDBC4 getentitynumber();
          door.alarmprompts[_id_3FA8302C3EB6F7B6] = _id_AE098E74B36DDBC4;
        }

        clip = undefined;

        if(isDefined(doortarget))
          clip = getEnt(doortarget, "targetname");

        if(isDefined(clip)) {
          door.clipent = clip;
          door.clipent linkTo(door);
          door.clipent.unresolved_collision_func = scripts\mp\movers::unresolved_collision_void;
          door.clipent connectpaths();

          if(isDefined(clip.target)) {
            _id_71E2FAD940312ADB = getEnt(clip.target, "targetname");
            door.audioportalent = _id_71E2FAD940312ADB;
          }
        }
      }

      if(_id_95A8D8ADDB57380E) {
        door thread changestate(2);
        door.angles = (door.angles[0], door.angles[1] + 90.0, door.angles[2]);
      } else if(_id_74FB145EC8B5103D)
        door thread changestate(7);
      else
        door thread changestate(0);
    }

    level.doors[level.doors.size] = door;
    waitframe();
  }

  if(!_id_3F79972B04564171) {
    level thread amortizeyawtraces();

    foreach(door in level.doors)
    door thread get_max_yaws();

    level thread linkdoubledoors();
  }

  level.doorsetupstarted--;
  level.doorsetupfinished = level.doorsetupstarted == 0;
}

door_dynamic_setup_post_init() {
  waitframe();

  if(getdvarint("scr_doors_open", 0) != 0) {
    foreach(door in level.doors) {
      door.statecurr = 2;
      door.angles = door.doortarget.angles;
    }
  }
}

triggerlisten(door) {
  self notify("disableTrigger");
  self endon("disableTrigger");
  level endon("game_ended");

  if(!door.islean && door.statecurr == 0)
    door thread bashmonitor();

  for(;;) {
    self waittill("trigger", player);
    self makeunusable();
    _id_0B53A2D724C54182 = door.doortarget;

    if(isDefined(door.doortargetccw)) {
      _id_AC46B1D56B50F400 = anglesToForward(door.angles);
      _id_F85F26257033C0F2 = vectorcross((0, 0, 1), _id_AC46B1D56B50F400);
      _id_E227374D9D756C2D = anglesToForward((0, player.angles[1], 0));

      if(vectordot(_id_E227374D9D756C2D, _id_F85F26257033C0F2) < 0)
        _id_0B53A2D724C54182 = door.doortargetccw;
    }

    _id_B18D3429CF88F29F = 0.666;

    if(door.statecurr == 0) {
      self notify("stop_bash_monitor");
      door.statecurr = 3;
      door rotateTo(_id_0B53A2D724C54182.angles, _id_B18D3429CF88F29F, 0.0, 0.333);
      hintstring = &"MP/DOOR_USE_CLOSE";
    } else {
      door.statecurr = 1;
      door rotateTo(door.baseangles, _id_B18D3429CF88F29F, 0.0, 0.333);
      hintstring = &"MP/DOOR_USE_OPEN";
    }

    door scripts\mp\events::doorused(player, door.statecurr == 3);
    wait 0.1;
    door childthread door_state_update_sound();
    wait(_id_B18D3429CF88F29F);

    if(door.statecurr == 1) {
      door.statecurr = 0;

      if(!door.islean)
        door thread bashmonitor();
    } else
      door.statecurr = 2;

    self makeusable();
    self setHintString(hintstring);
  }
}

door_dynamic_parse_parameters(_id_6C1755E925291505) {
  door = self;
  door.button_sound = undefined;

  if(!isDefined(_id_6C1755E925291505))
    _id_6C1755E925291505 = "";

  params = strtok(_id_6C1755E925291505, ";");

  foreach(param in params) {
    _id_F077ADF688122C36 = strtok(param, "=");

    if(_id_F077ADF688122C36.size != 2) {
      continue;
    }
    if(_id_F077ADF688122C36[1] == "undefined" || _id_F077ADF688122C36[1] == "default") {
      door.params[_id_F077ADF688122C36[0]] = undefined;
      continue;
    }

    switch (_id_F077ADF688122C36[0]) {
      case "stop_sound":
        door.stop_sound = _id_F077ADF688122C36[1];
        break;
      case "interrupt_sound":
        door.interrupt_sound = _id_F077ADF688122C36[1];
        break;
      case "loop_sound":
        door.loop_sound = _id_F077ADF688122C36[1];
        break;
      case "open_interrupt":
        door.open_interrupt = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "start_sound":
        door.start_sound = _id_F077ADF688122C36[1];
        break;
      case "material":
        door.material = _id_F077ADF688122C36[1];
        break;
    }
  }
}

door_system_init(_id_A95CF9509CE0D814) {
  buttons = getEntArray(_id_A95CF9509CE0D814, "targetname");

  foreach(button in buttons) {
    if(isDefined(button.script_parameters))
      button button_parse_parameters(button.script_parameters);

    button door_setup();
  }

  foreach(button in buttons)
  button thread door_think();
}

door_setup() {
  button = self;
  button.doors = [];
  button.hasbeenused = 0;

  if(isDefined(button.script_index))
    button.doormovetime = max(0.1, float(button.script_index) / 1000);

  _id_FD5EF62C4BDE358E = getEntArray(button.target, "targetname");

  foreach(ent in _id_FD5EF62C4BDE358E) {
    if(issubstr(ent.classname, "trigger")) {
      if(!isDefined(button.trigblock))
        button.trigblock = [];

      if(isDefined(ent.script_parameters))
        ent trigger_parse_parameters(ent.script_parameters);

      if(isDefined(ent.script_linkto)) {
        _id_651359B7E3625955 = getEnt(ent.script_linkto, "script_linkname");
        ent enablelinkTo();
        ent linkTo(_id_651359B7E3625955);
      }

      button.trigblock[button.trigblock.size] = ent;
      continue;
    }

    if(ent.classname == "script_brushmodel" || ent.classname == "script_model") {
      if(isDefined(ent.script_noteworthy) && issubstr(ent.script_noteworthy, "light")) {
        if(issubstr(ent.script_noteworthy, "light_on")) {
          if(!isDefined(button.lights_on))
            button.lights_on = [];

          ent hide();
          button.lights_on[button.lights_on.size] = ent;
        } else if(issubstr(ent.script_noteworthy, "light_off")) {
          if(!isDefined(button.lights_off))
            button.lights_off = [];

          ent hide();
          button.lights_off[button.lights_off.size] = ent;
        } else {}
      } else if(ent.spawnflags & 2) {
        if(!isDefined(button.ai_sight_brushes))
          button.ai_sight_brushes = [];

        ent notsolid();
        ent hide();
        button.ai_sight_brushes[button.ai_sight_brushes.size] = ent;
      } else
        button.doors[button.doors.size] = ent;

      continue;
    }

    if(ent.classname == "script_origin")
      button.entsound = ent;
  }

  if(!isDefined(button.entsound) && button.doors.size)
    button.entsound = sortbydistance(button.doors, button.origin)[0];

  foreach(door in button.doors) {
    door.posclosed = door.origin;
    door.posopen = scripts\engine\utility::getStruct(door.target, "targetname").origin;
    door.distmove = distance(door.posopen, door.posclosed);
    door.no_moving_unresolved_collisions = 0;

    if(!istrue(button.start_closed))
      door.origin = door.posopen;

    if(isDefined(door.script_parameters))
      door door_parse_parameters(door.script_parameters);
  }
}

door_think() {
  button = self;
  _id_F4DB5B4567F88914 = scripts\engine\utility::ter_op(istrue(button.start_closed), 0, 2);
  button door_state_change(_id_F4DB5B4567F88914, 1);

  for(;;) {
    button.statedone = undefined;
    button.stateinterrupted = undefined;
    button scripts\engine\utility::waittill_any_2("door_state_done", "door_state_interrupted");

    if(isDefined(button.statedone) && button.statedone) {
      _id_16EB9F9803646FDF = button door_state_next(button.statecurr);
      button door_state_change(_id_16EB9F9803646FDF, 0);
      continue;
    }

    if(isDefined(button.stateinterrupted) && button.stateinterrupted) {
      button door_state_change(4, 0);
      continue;
    }
  }
}

door_state_next(state) {
  button = self;
  _id_16EB9F9803646FDF = undefined;

  if(state == 0)
    _id_16EB9F9803646FDF = 3;
  else if(state == 2)
    _id_16EB9F9803646FDF = 1;
  else if(state == 1)
    _id_16EB9F9803646FDF = 0;
  else if(state == 3)
    _id_16EB9F9803646FDF = 2;
  else if(state == 4)
    _id_16EB9F9803646FDF = button.stateprev;
  else {}

  return _id_16EB9F9803646FDF;
}

door_state_update(_id_B53415265B603895) {
  button = self;
  button endon("door_state_interrupted");
  button.statedone = undefined;

  if(button.statecurr == 0 || button.statecurr == 2) {
    if(!_id_B53415265B603895) {
      foreach(door in button.doors) {
        if(isDefined(door.stop_sound)) {
          door stoploopsound();
          door playsoundonmovingent(door.stop_sound);
        }
      }
    }

    if(isDefined(button.lights_on)) {
      foreach(light in button.lights_on)
      light show();
    }

    foreach(door in button.doors) {
      if(button.statecurr == 0) {
        if(isDefined(button.ai_sight_brushes)) {
          foreach(_id_E7FE58B8BF035286 in button.ai_sight_brushes)
          _id_E7FE58B8BF035286 show();
        }

        if(door.spawnflags & 1) {}
      } else {
        if(isDefined(button.ai_sight_brushes)) {
          foreach(_id_E7FE58B8BF035286 in button.ai_sight_brushes)
          _id_E7FE58B8BF035286 hide();
        }

        if(door.spawnflags & 1) {
          if(isDefined(door.script_noteworthy) && door.script_noteworthy == "always_disconnect") {} else {}
        }
      }

      if(isDefined(door.script_noteworthy)) {
        if(door.script_noteworthy == "clockwise_wheel" || door.script_noteworthy == "counterclockwise_wheel")
          door rotatevelocity((0, 0, 0), 0.1);
      }

      if(door.no_moving_unresolved_collisions)
        door.unresolved_collision_func = undefined;
    }

    isusable = !istrue(button.one_time_use) || !button.hasbeenused;

    if(isusable) {
      hintstring = scripts\engine\utility::ter_op(button.statecurr == 0, &"MP/DOOR_USE_OPEN", &"MP/DOOR_USE_CLOSE");
      button makeusable();

      if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
        button setHintString(hintstring);

      button waittill("trigger");

      if(isDefined(button.button_sound))
        button playSound(button.button_sound);

      button.hasbeenused = 1;
    } else
      button waittill("forever");
  } else if(button.statecurr == 1 || button.statecurr == 3) {
    if(isDefined(button.lights_off)) {
      foreach(light in button.lights_off)
      light show();
    }

    button makeunusable();

    if(button.statecurr == 1) {
      button thread door_state_on_interrupt();

      foreach(door in button.doors) {
        if(isDefined(door.script_noteworthy)) {
          _id_CAD92BFFBDE8F755 = scripts\engine\utility::ter_op(isDefined(button.doormovetime), button.doormovetime, 3.0);
          _id_7F02CDA7A3B89BB6 = scripts\engine\utility::ter_op(button.statecurr == 1, door.posclosed, door.posopen);
          _id_78E602AB4A4ED223 = distance(door.origin, _id_7F02CDA7A3B89BB6);
          time = max(0.1, _id_78E602AB4A4ED223 / door.distmove * _id_CAD92BFFBDE8F755);
          _id_5669BAB8CF462E92 = max(time * 0.25, 0.05);
          _id_A14444A704BD237A = 360 * _id_78E602AB4A4ED223 / 94.2;

          if(door.script_noteworthy == "clockwise_wheel")
            door rotatevelocity((0, 0, -1 * _id_A14444A704BD237A / time), time, _id_5669BAB8CF462E92, _id_5669BAB8CF462E92);
          else if(door.script_noteworthy == "counterclockwise_wheel")
            door rotatevelocity((0, 0, _id_A14444A704BD237A / time), time, _id_5669BAB8CF462E92, _id_5669BAB8CF462E92);
        }
      }
    } else if(button.statecurr == 3) {
      if(isDefined(button.open_interrupt) && button.open_interrupt)
        button thread door_state_on_interrupt();

      foreach(door in button.doors) {
        if(isDefined(door.script_noteworthy)) {
          _id_CAD92BFFBDE8F755 = scripts\engine\utility::ter_op(isDefined(button.doormovetime), button.doormovetime, 3.0);
          _id_7F02CDA7A3B89BB6 = scripts\engine\utility::ter_op(button.statecurr == 1, door.posclosed, door.posopen);
          _id_78E602AB4A4ED223 = distance(door.origin, _id_7F02CDA7A3B89BB6);
          time = max(0.1, _id_78E602AB4A4ED223 / door.distmove * _id_CAD92BFFBDE8F755);
          _id_5669BAB8CF462E92 = max(time * 0.25, 0.05);
          _id_A14444A704BD237A = 360 * _id_78E602AB4A4ED223 / 94.2;

          if(door.script_noteworthy == "clockwise_wheel")
            door rotatevelocity((0, 0, _id_A14444A704BD237A / time), time, _id_5669BAB8CF462E92, _id_5669BAB8CF462E92);
          else if(door.script_noteworthy == "counterclockwise_wheel")
            door rotatevelocity((0, 0, -1 * _id_A14444A704BD237A / time), time, _id_5669BAB8CF462E92, _id_5669BAB8CF462E92);
        }
      }
    }

    wait 0.1;
    button childthread door_state_update_sound();
    _id_CAD92BFFBDE8F755 = scripts\engine\utility::ter_op(isDefined(button.doormovetime), button.doormovetime, 3.0);
    _id_416DBDA00EB39926 = undefined;

    foreach(door in button.doors) {
      _id_7F02CDA7A3B89BB6 = scripts\engine\utility::ter_op(button.statecurr == 1, door.posclosed, door.posopen);

      if(door.origin != _id_7F02CDA7A3B89BB6) {
        time = max(0.1, distance(door.origin, _id_7F02CDA7A3B89BB6) / door.distmove * _id_CAD92BFFBDE8F755);
        _id_5669BAB8CF462E92 = max(time * 0.25, 0.05);
        door moveTo(_id_7F02CDA7A3B89BB6, time, _id_5669BAB8CF462E92, _id_5669BAB8CF462E92);
        door scripts\mp\movers::notify_moving_platform_invalid();

        if(door.no_moving_unresolved_collisions)
          door.unresolved_collision_func = scripts\mp\movers::unresolved_collision_void;

        if(!isDefined(_id_416DBDA00EB39926) || time > _id_416DBDA00EB39926)
          _id_416DBDA00EB39926 = time;
      }
    }

    if(isDefined(_id_416DBDA00EB39926))
      wait(_id_416DBDA00EB39926);
  } else if(button.statecurr == 4) {
    foreach(door in button.doors) {
      door moveTo(door.origin, 0.05, 0.0, 0.0);
      door scripts\mp\movers::notify_moving_platform_invalid();

      if(door.no_moving_unresolved_collisions)
        door.unresolved_collision_func = undefined;

      if(isDefined(door.script_noteworthy)) {
        if(door.script_noteworthy == "clockwise_wheel" || door.script_noteworthy == "counterclockwise_wheel")
          door rotatevelocity((0, 0, 0), 0.05);
      }
    }

    if(isDefined(button.lights_off)) {
      foreach(light in button.lights_off)
      light show();
    }

    button.entsound stoploopsound();

    foreach(door in button.doors) {
      if(isDefined(door.interrupt_sound))
        door playSound(door.interrupt_sound);
    }

    wait 1.0;
  } else {}

  button.statedone = 1;

  foreach(door in button.doors)
  door.statedone = 1;

  button notify("door_state_done");
}

door_state_update_sound() {
  button = self;
  _id_B11324D10BC5B631 = 1;
  _id_D1EAB7EC60299BD1 = 1;
  _id_40CDBACDA5CCA105 = 0;

  if(button.statecurr == 3 || button.statecurr == 1) {
    foreach(door in button.doors) {
      if(isDefined(door.start_sound)) {
        door playsoundonmovingent(door.start_sound);
        _id_40CDBACDA5CCA105 = lookupsoundlength(door.start_sound) / 1000;
        _id_B11324D10BC5B631 = 0;
      }
    }

    if(_id_B11324D10BC5B631) {
      if(!isDefined(button.entsound))
        button.entsound = button;

      if(button.statecurr == 3) {
        if(soundexists("scrpt_door_wood_double_open")) {
          _id_40CDBACDA5CCA105 = lookupsoundlength("scrpt_door_wood_double_open") / 1000;
          playsoundatpos(button.entsound.origin, "scrpt_door_wood_double_open");
        }
      } else if(button.statecurr == 1) {
        if(soundexists("scrpt_door_wood_double_close")) {
          _id_40CDBACDA5CCA105 = lookupsoundlength("scrpt_door_wood_double_close") / 1000;
          playsoundatpos(button.entsound.origin, "scrpt_door_wood_double_close");
        }
      }
    }
  }

  wait(_id_40CDBACDA5CCA105 * 0.3);

  if(button.statecurr == 3 || button.statecurr == 1) {
    foreach(door in button.doors) {
      if(isDefined(door.loop_sound)) {
        if(door.loop_sound != "none")
          door playLoopSound(door.loop_sound);

        _id_D1EAB7EC60299BD1 = 0;
      }
    }

    if(_id_D1EAB7EC60299BD1) {
      if(soundexists(""))
        button.entsound playLoopSound("");
    }
  }
}

door_state_change(state, _id_B53415265B603895) {
  button = self;

  if(isDefined(button.statecurr)) {
    door_state_exit(button.statecurr);
    button.stateprev = button.statecurr;
  }

  button.statecurr = state;
  button thread door_state_update(_id_B53415265B603895);
}

door_state_exit(state) {
  button = self;

  if(state == 0 || state == 2) {
    if(isDefined(button.lights_on)) {
      foreach(light in button.lights_on)
      light hide();
    }
  } else if(state == 1 || state == 3) {
    if(isDefined(button.lights_off)) {
      foreach(light in button.lights_off)
      light hide();
    }

    button.entsound stoploopsound();

    foreach(door in button.doors) {
      if(isDefined(door.loop_sound))
        door stoploopsound();
    }
  } else {
    if(state == 4) {
      return;
    }
    return;
  }
}

door_state_on_interrupt() {
  button = self;
  button endon("door_state_done");

  if(!isDefined(button.trigblock)) {
    return;
  }
  _id_FF46604C829CBB2E = [];

  foreach(trigger in button.trigblock) {
    if(button.statecurr == 1) {
      if(isDefined(trigger.not_closing) && trigger.not_closing == 1)
        continue;
    } else if(button.statecurr == 3) {
      if(isDefined(trigger.not_opening) && trigger.not_opening == 1)
        continue;
    }

    _id_FF46604C829CBB2E[_id_FF46604C829CBB2E.size] = trigger;
  }

  if(_id_FF46604C829CBB2E.size > 0) {
    interrupter = button waittill_any_triggered_return_triggerer(_id_FF46604C829CBB2E);

    if(!isDefined(interrupter.fauxdead) || interrupter.fauxdead == 0) {
      button.stateinterrupted = 1;
      button notify("door_state_interrupted");
    }
  }
}

waittill_any_triggered_return_triggerer(triggers) {
  button = self;

  foreach(trigger in triggers)
  button thread return_triggerer(trigger);

  button waittill("interrupted");
  return button.interrupter;
}

return_triggerer(trigger) {
  button = self;
  button endon("door_state_done");
  button endon("interrupted");

  for(;;) {
    trigger waittill("trigger", ent);

    if(isDefined(trigger.prone_only) && trigger.prone_only == 1) {
      if(isPlayer(ent)) {
        stance = ent getstance();

        if(stance != "prone")
          continue;
        else {
          _id_5074D4CEE390D757 = vectorNormalize(anglesToForward(ent.angles));
          _id_40D98D9C533FD919 = vectorNormalize(trigger.origin - ent.origin);
          dot = vectordot(_id_5074D4CEE390D757, _id_40D98D9C533FD919);

          if(dot > 0)
            continue;
        }
      }
    }

    break;
  }

  button.interrupter = ent;
  button notify("interrupted");
}

button_parse_parameters(_id_6C1755E925291505) {
  button = self;
  button.button_sound = undefined;

  if(!isDefined(_id_6C1755E925291505))
    _id_6C1755E925291505 = "";

  params = strtok(_id_6C1755E925291505, ";");

  foreach(param in params) {
    _id_F077ADF688122C36 = strtok(param, "=");

    if(_id_F077ADF688122C36.size != 2) {
      continue;
    }
    if(_id_F077ADF688122C36[1] == "undefined" || _id_F077ADF688122C36[1] == "default") {
      button.params[_id_F077ADF688122C36[0]] = undefined;
      continue;
    }

    switch (_id_F077ADF688122C36[0]) {
      case "open_interrupt":
        button.open_interrupt = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "button_sound":
        button.button_sound = _id_F077ADF688122C36[1];
        break;
      case "start_closed":
        button.start_closed = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "one_time_use":
        button.one_time_use = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      default:
        break;
    }
  }
}

door_parse_parameters(_id_6C1755E925291505) {
  door = self;
  door.start_sound = undefined;
  door.stop_sound = undefined;
  door.loop_sound = undefined;
  door.interrupt_sound = undefined;

  if(!isDefined(_id_6C1755E925291505))
    _id_6C1755E925291505 = "";

  params = strtok(_id_6C1755E925291505, ";");

  foreach(param in params) {
    _id_F077ADF688122C36 = strtok(param, "=");

    if(_id_F077ADF688122C36.size != 2) {
      continue;
    }
    if(_id_F077ADF688122C36[1] == "undefined" || _id_F077ADF688122C36[1] == "default") {
      door.params[_id_F077ADF688122C36[0]] = undefined;
      continue;
    }

    switch (_id_F077ADF688122C36[0]) {
      case "stop_sound":
        door.stop_sound = _id_F077ADF688122C36[1];
        break;
      case "interrupt_sound":
        door.interrupt_sound = _id_F077ADF688122C36[1];
        break;
      case "loop_sound":
        door.loop_sound = _id_F077ADF688122C36[1];
        break;
      case "open_interrupt":
        door.open_interrupt = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "start_sound":
        door.start_sound = _id_F077ADF688122C36[1];
        break;
      case "unresolved_collision_nodes":
        door.unresolved_collision_nodes = getnodearray(_id_F077ADF688122C36[1], "targetname");
        break;
      case "no_moving_unresolved_collisions":
        door.no_moving_unresolved_collisions = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "material":
        door.material = _id_F077ADF688122C36[1];
        break;
      default:
        break;
    }
  }
}

trigger_parse_parameters(_id_6C1755E925291505) {
  trigger = self;

  if(!isDefined(_id_6C1755E925291505))
    _id_6C1755E925291505 = "";

  params = strtok(_id_6C1755E925291505, ";");

  foreach(param in params) {
    _id_F077ADF688122C36 = strtok(param, "=");

    if(_id_F077ADF688122C36.size != 2) {
      continue;
    }
    if(_id_F077ADF688122C36[1] == "undefined" || _id_F077ADF688122C36[1] == "default") {
      trigger.params[_id_F077ADF688122C36[0]] = undefined;
      continue;
    }

    switch (_id_F077ADF688122C36[0]) {
      case "not_opening":
        trigger.not_opening = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "not_closing":
        trigger.not_closing = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      case "prone_only":
        trigger.prone_only = scripts\engine\utility::string_to_bool(_id_F077ADF688122C36[1]);
        break;
      default:
        break;
    }
  }
}

bashmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("stateChanged");
  self notify("bashMonitor");
  self endon("bashMonitor");
  thread monitordamage();

  for(;;) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(players.size > 0) {
      foreach(player in players) {
        if(bashproxcheck(player) && shouldbashopen(player))
          thread bashopen(player, player.origin);
      }

      waitframe();
      continue;
    }

    wait 0.1;
  }
}

bashproxcheck(player) {
  _id_AC0E564AC96A9D0F = distancesquared(player.origin, self.doorcenter);
  range = 4900;
  return _id_AC0E564AC96A9D0F < range;
}

shouldbashopen(player) {
  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  _id_E227374D9D756C2D = anglesToForward(player.angles);

  if(scripts\engine\utility::within_fov(player.origin + _id_E227374D9D756C2D * -45.0, player.angles, self.doorcenter, cos(43))) {
    _id_7BF201849AE293CD = anglestoright(self.angles);
    _id_D3310DE4C428A779 = vectorNormalize(self.doorcenter - player getEye());
    _id_88516B40C2F83B3C = vectordot(_id_E227374D9D756C2D, _id_D3310DE4C428A779);
    _id_F77A6113861D6CFD = vectordot(_id_E227374D9D756C2D, _id_7BF201849AE293CD);
    _id_1D0DFDFEE6CACB97 = player getvelocity();
    _id_9B69954F476C76FE = vectordot(vectorNormalize(_id_1D0DFDFEE6CACB97), (0, 0, 1));

    if((length(_id_1D0DFDFEE6CACB97) >= 200 || player scripts\mp\utility\killstreak::isjuggernaut() && length(_id_1D0DFDFEE6CACB97) >= 140) && abs(_id_9B69954F476C76FE) < 0.75 && abs(_id_F77A6113861D6CFD) > 0.75 && _id_88516B40C2F83B3C > 0.75) {
      _id_70BE37A43C5B39D5 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(_id_70BE37A43C5B39D5)) {
        trace = scripts\engine\trace::ray_trace(player getEye(), _id_70BE37A43C5B39D5, player, level.doorcontentoverride, 0);

        if(isDefined(trace["entity"]) && trace["entity"] == self)
          return 1;
      } else
        return 1;
    }
  }

  return 0;
}

bashopen(player, pos) {
  thread checktriggeralarm(player);
  thread changestate(5);

  if(istrue(self.bashed)) {
    return;
  }
  if(!isDefined(self.useprompt))
    self.bashed = 1;

  origin = self.origin;
  angles = self.angles;
  right = anglestoright(angles);
  normal = vectorNormalize(pos - self.origin);
  dot = vectordot(right, normal);
  _id_04FBD3851A4B84B8 = dot > 0;
  _id_62ED0570F5E80A07 = undefined;

  if(isDefined(player) && isPlayer(player)) {
    if(!isai(player))
      thread bashpresentation(player);
    else
      self notify("ai_opened");
  }

  if(isDefined(self.material)) {
    if(self.material == "metal")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    else if(self.material == "wood")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_bash");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");

  if(_id_04FBD3851A4B84B8)
    _id_62ED0570F5E80A07 = self.baseangles[1] + self.max_yaw_left;
  else
    _id_62ED0570F5E80A07 = self.baseangles[1] - self.max_yaw_right;

  if(_id_62ED0570F5E80A07 > 360)
    _id_62ED0570F5E80A07 = _id_62ED0570F5E80A07 - 360;
  else if(_id_62ED0570F5E80A07 < 0)
    _id_62ED0570F5E80A07 = _id_62ED0570F5E80A07 + 360;

  _id_5E7A100369FAFE1E = 0.35;
  _id_11B200101076BC6C = 0.15;
  _id_805136F88545A0DB = scripts\engine\math::normalize_value(0, 170, _id_62ED0570F5E80A07);
  bashtime = scripts\engine\math::factor_value(_id_5E7A100369FAFE1E, _id_11B200101076BC6C, _id_805136F88545A0DB);
  _id_73D0C62EE90EF3C3 = self.angles;
  _id_BBA965DDEFFB21FE = _id_73D0C62EE90EF3C3[1];

  if(_id_BBA965DDEFFB21FE > 360)
    _id_BBA965DDEFFB21FE = _id_BBA965DDEFFB21FE - 360;
  else if(_id_BBA965DDEFFB21FE < 0)
    _id_BBA965DDEFFB21FE = _id_BBA965DDEFFB21FE + 360;

  _id_55A531282AFD5F1D = angle_diff(_id_BBA965DDEFFB21FE, self.baseangles[1]);
  _id_5E0F89CF0C167E08 = angle_diff(_id_62ED0570F5E80A07, self.baseangles[1]);
  _id_C3F370DCF88FB5BB = anglesToForward(_id_73D0C62EE90EF3C3);
  _id_59EE6658D03630A6 = anglestoright(self.baseangles);
  _id_397E59A9937B07DB = vectordot(_id_C3F370DCF88FB5BB, _id_59EE6658D03630A6) < 0.0;

  if(_id_04FBD3851A4B84B8) {
    if(!_id_397E59A9937B07DB)
      _id_5E0F89CF0C167E08 = _id_5E0F89CF0C167E08 + _id_55A531282AFD5F1D;
    else
      _id_5E0F89CF0C167E08 = _id_5E0F89CF0C167E08 - _id_55A531282AFD5F1D;
  } else {
    if(_id_397E59A9937B07DB)
      _id_5E0F89CF0C167E08 = _id_5E0F89CF0C167E08 + _id_55A531282AFD5F1D;
    else
      _id_5E0F89CF0C167E08 = _id_5E0F89CF0C167E08 - _id_55A531282AFD5F1D;

    _id_5E0F89CF0C167E08 = _id_5E0F89CF0C167E08 * -1.0;
  }

  _id_41E917596D6BF09F = (0, _id_5E0F89CF0C167E08, 0);
  self rotateby(_id_41E917596D6BF09F, bashtime);
  wait(bashtime);
  self.lastpushtime = gettime();
  thread changestate(6);

  if(!isDefined(self.useprompt)) {
    self.statecurr = 2;

    if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      self.trigger setHintString(&"MP/DOOR_USE_CLOSE");
  }

  self.bashed = 0;
  _id_B492B99EB62E16F2 = randomfloatrange(3, 5);
  _id_6E09CABEB82B5356 = randomfloatrange(0.25, 2.5);

  if(_id_04FBD3851A4B84B8)
    _id_6E09CABEB82B5356 = _id_6E09CABEB82B5356 * -1.0;

  self rotateYaw(_id_6E09CABEB82B5356, _id_B492B99EB62E16F2, 0.5, _id_B492B99EB62E16F2 - 0.5);
}

bashpresentation(player) {
  player playRumbleOnEntity("grenade_rumble");
  player earthquakeforplayer(0.35, 0.5, player.origin, 200);
}

monitordamage() {
  self endon("stateChanged");
  self notify("monitorDamage");
  self endon("monitorDamage");
  self setCanDamage(1);
  damage = undefined;
  attacker = undefined;
  direction_vec = undefined;
  meansofdeath = undefined;
  modelname = undefined;
  tagname = undefined;
  partname = undefined;
  idflags = undefined;
  objweapon = undefined;
  origin = undefined;
  angles = undefined;
  normal = undefined;
  inflictor = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(meansofdeath)) {
      if(meansofdeath == "MOD_MELEE") {
        if(istrue(self.issaloonstyle))
          self.otherdoor thread bashopen(attacker, attacker.origin);

        thread bashopen(attacker, attacker.origin);
        continue;
      }

      if(meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
        _id_C81A61AE7E6E7025 = isDefined(objweapon) && isDefined(objweapon.basename) && (objweapon.basename == "molotov_mp" || objweapon.basename == "thermite_mp" || objweapon.basename == "thermite_ap_mp" || objweapon.basename == "thermite_av_mp");

        if(damage > 10 && !_id_C81A61AE7E6E7025)
          thread bashopen(inflictor, point);

        continue;
      }

      if(isDefined(objweapon) && objweapon.basename == "pac_sentry_turret_mp" && (meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH"))
        thread bashopen(inflictor, point);
    }
  }
}

openmonitor() {
  self endon("stateChanged");

  if(self.state == 7 || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(self.islean || 0 || 1) {
    if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      self.useprompt setHintString(&"MP/DOOR_USE_OPEN");
  } else if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    self.useprompt setHintString(&"MP/DOOR_USE_OPEN_DOUBLE");

  self.useprompt sethintdisplayrange(200);

  for(;;) {
    self.useprompt waittill("trigger_progress", player);

    if(player meleeButtonPressed()) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < 0.1) {
      if(!player useButtonPressed()) {
        break;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    if(self.state == 7) {
      _id_70BE37A43C5B39D5 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(_id_70BE37A43C5B39D5))
        playsoundatpos(_id_70BE37A43C5B39D5, "door_locked");
      else
        playsoundatpos(self.origin + (0, 0, 42), "door_locked");

      continue;
    }

    if(self.islean) {
      thread cheapopen(player);
      return;
    }

    if(1 && player playerads() > 0.9) {
      thread ajar(player);
      return;
    }

    thread cheapopen(player);
  }
}

cheapopen(player) {
  thread checktriggeralarm(player);
  origin = self.useprompt.origin;
  angles = self.angles;
  right = anglestoright(angles);
  normal = vectorNormalize(player.origin - origin);
  dot = vectordot(right, normal);
  _id_04FBD3851A4B84B8 = dot > 0;

  if(isDefined(self.material)) {
    if(self.material == "metal")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_open");
    else if(self.material == "wood")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_open");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_open");

  thread changestate(3);
  _id_623F3095ECFA11FF = scripts\engine\utility::ter_op(_id_04FBD3851A4B84B8, self.max_yaw_left, self.max_yaw_right * -1.0);
  openangles = (self.baseangles[0], self.baseangles[1] + _id_623F3095ECFA11FF, self.baseangles[2]);
  self rotateTo(openangles, 0.666, 0.0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    _id_623F3095ECFA11FF = scripts\engine\utility::ter_op(!_id_04FBD3851A4B84B8, self.otherdoor.max_yaw_left, self.otherdoor.max_yaw_right * -1.0);
    openangles = (self.otherdoor.baseangles[0], self.otherdoor.baseangles[1] + _id_623F3095ECFA11FF, self.otherdoor.baseangles[2]);
    self.otherdoor rotateTo(openangles, 0.666, 0.0, 0.333);
  }

  wait 0.666;
  self.lastpushtime = gettime();
  thread changestate(2);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle))
    self.otherdoor thread changestate(2);
}

ajar(player) {
  thread checktriggeralarm(player);
  thread changestate(6);
  origin = self.useprompt.origin;
  angles = self.angles;
  right = anglestoright(angles);
  normal = vectorNormalize(player.origin - origin);
  dot = vectordot(right, normal);
  _id_04FBD3851A4B84B8 = dot > 0;
  time = 0.5;
  _id_96CC1618573AD3CC = scripts\engine\utility::ter_op(_id_04FBD3851A4B84B8, 15, -15);
  player playRumbleOnEntity("damage_heavy");

  if(isDefined(self.material)) {
    if(self.material == "metal")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_start_peek");
    else if(self.material == "wood")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_start_peek");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_start_peek");

  self rotateYaw(_id_96CC1618573AD3CC, time, time * 0.25, time * 0.75);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    self.otherdoor thread changestate(6);
    _id_96CC1618573AD3CC = scripts\engine\utility::ter_op(!_id_04FBD3851A4B84B8, 15, -15);
    self.otherdoor rotateYaw(_id_96CC1618573AD3CC, time, time * 0.25, time * 0.75);
  }

  self.lastpushtime = gettime();
}

pushmonitor() {
  if(self.islean) {
    return;
  }
  self endon("stateChanged");
  self notify("pushMonitor");
  self endon("pushMonitor");
  wait 0.5;

  for(;;) {
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(players.size > 0) {
      foreach(player in players) {
        if(pushproxcheck(player)) {
          push(player);
          self.lastpushtime = gettime();
          door_destroynavobstacle();
        }
      }
    }

    if(isDefined(self.lastpushtime) && gettime() > self.lastpushtime + 2000)
      door_createnavobstacle();

    waitframe();
  }
}

pushproxcheck(player) {
  self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  if(player.origin[2] > self.origin[2] + self.height || player.origin[2] + 70 < self.origin[2])
    return 0;

  _id_AC0E564AC96A9D0F = distance2dsquared(player.origin, self.doorcenter);
  range = 900;
  return _id_AC0E564AC96A9D0F < range;
}

push(player) {
  _id_21B0311D64CADFA2 = 26;
  _id_76C663E82A2008DC = 0;
  _id_8928780331CE6436 = 25;
  endpoint = self.origin + anglesToForward(self.angles) * 28;
  dist = distance2d(player.origin, endpoint);
  _id_477C1209E5432ABE = scripts\engine\math::normalize_value(_id_76C663E82A2008DC, _id_21B0311D64CADFA2, dist);
  amount = _id_8928780331CE6436 * (1 - _id_477C1209E5432ABE);

  if(amount == 0) {
    return;
  }
  origin = self.useprompt.origin;
  angles = self.angles;
  right = anglestoright(angles);
  normal = vectorNormalize(player.origin - origin);
  dot = vectordot(right, normal);
  _id_04FBD3851A4B84B8 = dot > 0;
  _id_9DBBC8DD984310F1 = self.angles[1];
  _id_E3125712731D02F9 = scripts\engine\utility::ter_op(_id_04FBD3851A4B84B8 == 1, 1, -1);
  _id_91684A9882455754 = _id_9DBBC8DD984310F1 + amount * _id_E3125712731D02F9;
  angle_diff = angle_diff(_id_91684A9882455754, self.baseangles[1]);

  if(_id_04FBD3851A4B84B8) {
    if(angle_diff > self.max_yaw_left) {
      self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
      self.angles = (self.angles[0], self.baseangles[1] + self.max_yaw_left, self.angles[2]);
      return;
    }
  } else if(angle_diff > self.max_yaw_right) {
    self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
    self.angles = (self.angles[0], self.baseangles[1] - self.max_yaw_right, self.angles[2]);
    return;
  }

  self.angles = (self.angles[0], _id_91684A9882455754, self.angles[2]);
}

autoclosemonitor() {
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
        players = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

        if(players.size == 0)
          thread closedoor(1);
      }
    }

    waitframe();
  }
}

changestate(_id_9B1941CB7354665E) {
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
      if(isDefined(self.useprompt))
        self.useprompt sethinticon("icon_door_unlocked");

      break;
    case 8:
      break;
  }

  self.state = _id_9B1941CB7354665E;
  self notify("stateChanged");

  switch (_id_9B1941CB7354665E) {
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

  if(isDefined(self.otherdoor))
    self.otherdoor thread updatealarmpromptvisibility();
}

updatestate() {
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
      break;
    case 8:
      break;
  }
}

closemonitor() {
  self endon("stateChanged");

  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self.useprompt makeusable();

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    self.useprompt setHintString(&"MP/DOOR_USE_CLOSE");

  self.useprompt sethintdisplayrange(200);
  self.useprompt sethintdisplayfov(120);
  self.useprompt setuserange(125);
  self.useprompt setusefov(120);

  for(;;) {
    self.useprompt waittill("trigger_progress", player);

    if(player meleeButtonPressed()) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < 0.1) {
      if(!player useButtonPressed()) {
        break;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    thread closedoor();
  }
}

closedoor(_id_C81F097EBBBED511) {
  if(isDefined(self.material)) {
    if(self.material == "metal")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_close");
    else if(self.material == "wood")
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_close");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_close");

  thread changestate(1);
  _id_B9F754EF90AFF45B = 0.666;

  if(istrue(_id_C81F097EBBBED511))
    _id_B9F754EF90AFF45B = _id_B9F754EF90AFF45B * 3;

  self rotateTo(self.baseangles, _id_B9F754EF90AFF45B, 0.0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle))
    self.otherdoor rotateTo(self.otherdoor.baseangles, _id_B9F754EF90AFF45B, 0.0, 0.333);

  wait(_id_B9F754EF90AFF45B);
  waitframe();

  if(angle_diff(self.angles[1], self.baseangles[1]) < 1)
    thread changestate(0);
  else
    thread changestate(6);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    if(angle_diff(self.otherdoor.angles[1], self.otherdoor.baseangles[1]) < 1)
      self.otherdoor thread changestate(0);
    else
      self.otherdoor thread changestate(6);
  }
}

angle_diff(_id_456C3AB4CCDC8D5D, _id_456C37B4CCDC86C4) {
  return 180 - abs(abs(_id_456C3AB4CCDC8D5D - _id_456C37B4CCDC86C4) - 180);
}

amortizeyawtraces() {
  level.doorphase = 0;
  level.doortracequeue = 0;
  _id_CDF4A830ECF21001 = [];
  _id_438903624C7EC6C9 = [];
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
  _id_438903624C7EC6C9[0] = level.doortracemetrics.totaltime;

  for(;;) {
    if(level.doortracequeue == 0) {
      currenttime = gettime();
      _id_438903624C7EC6C9[level.doorphase] = currenttime - _id_438903624C7EC6C9[level.doorphase];
      _id_CDF4A830ECF21001[level.doorphase] = level.doortraces;
      level.doortracemetrics.totaltracecount = level.doortracemetrics.totaltracecount + level.doortraces;
      level.doortraces = 0;
      level.doortracemetrics.totalwaitframes = level.doortracemetrics.totalwaitframes + level.waitcycles;
      level.waitcycles = 0;
      level.doorphase++;
      level notify("advance_door_trace");

      if(level.doorphase < 3)
        _id_438903624C7EC6C9[level.doorphase] = currenttime;
      else
        break;
    }

    waitframe();
  }

  level.doortracemetrics.totaltime = gettime() - level.doortracemetrics.totaltime;
  level.doortracemetrics.tracecountbyphase = _id_CDF4A830ECF21001;
  level.doortracemetrics.tracetimebyphase = _id_438903624C7EC6C9;
}

get_max_yaws() {
  thread get_max_yaw(1);
  thread get_max_yaw(0);
}

get_max_yaw(left) {
  if(left) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  _id_0FD30805DC79751C = 90;
  _id_7654C3F9D638AAEA = 10;
  _id_57E78339C006D1EF = 0.0;

  while(level.doorphase < 3) {
    _id_57E78339C006D1EF = get_max_yaw_internal(_id_0FD30805DC79751C, _id_7654C3F9D638AAEA, left);

    if(left)
      self.max_yaw_left = _id_57E78339C006D1EF;
    else
      self.max_yaw_right = _id_57E78339C006D1EF;

    if(_id_57E78339C006D1EF == 100) {
      break;
    }

    _id_7654C3F9D638AAEA = _id_7654C3F9D638AAEA * 0.5;
    _id_0FD30805DC79751C = _id_57E78339C006D1EF + _id_7654C3F9D638AAEA;
    level waittill("advance_door_trace");
  }

  _id_57E78339C006D1EF = max(_id_57E78339C006D1EF, 90);

  if(left)
    self.max_yaw_left = _id_57E78339C006D1EF;
  else
    self.max_yaw_right = _id_57E78339C006D1EF;
}

get_max_yaw_internal(_id_86E2597CACC185B5, _id_2F977E27FA739602, left) {
  if(!isDefined(self.traces))
    self.traces = 0;

  if(!isDefined(level.doortraces))
    level.doortraces = 0;

  _id_FC50F7F1EC656B5C = 0;
  _id_0F5E6316C2383F5F = 0;
  level.doortracequeue++;
  waitframe();

  while(!_id_0F5E6316C2383F5F) {
    if(_id_86E2597CACC185B5 > 100) {
      level.currentdoor = undefined;
      level.doortracequeue--;
      return 100;
    }

    while(isDefined(level.currentdoor) && self != level.currentdoor)
      waitframe();

    if(!isDefined(level.currentdoor))
      level.currentdoor = self;

    _id_0E79F8E052557004 = yaw_collision_check(_id_86E2597CACC185B5, _id_2F977E27FA739602, left);

    if(_id_0E79F8E052557004) {
      if(_id_FC50F7F1EC656B5C)
        finish = 1;

      _id_86E2597CACC185B5 = _id_86E2597CACC185B5 + _id_2F977E27FA739602;
    } else {
      if(!_id_FC50F7F1EC656B5C)
        _id_FC50F7F1EC656B5C = 1;

      _id_86E2597CACC185B5 = _id_86E2597CACC185B5 - _id_2F977E27FA739602;
      _id_0F5E6316C2383F5F = 1;
    }

    self.traces++;
    level.doortraces++;
    currenttime = gettime();

    if(!isDefined(level.doortraceframetime) || level.doortraceframetime != currenttime) {
      level.doortraceframetime = currenttime;
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
  return _id_86E2597CACC185B5;
}

yaw_collision_check(yaw, _id_2F977E27FA739602, left) {
  if(!left)
    yaw = yaw * -1;

  _id_EB10FFC36A6B4B47 = self.baseangles + (0, yaw, 0);
  _id_29AFC51DB09E2830 = self.origin + (0, 0, 8);
  _id_13B5E69A1D26EDDE = self.height - 16.0;
  _id_F85F26257033C0F2 = anglesToForward(_id_EB10FFC36A6B4B47);
  _id_7BF201849AE293CD = anglestoright(_id_EB10FFC36A6B4B47);

  if(left)
    _id_7BF201849AE293CD = _id_7BF201849AE293CD * -1.0;

  start = _id_29AFC51DB09E2830 + _id_F85F26257033C0F2 * self.length * 0.2;
  end = _id_29AFC51DB09E2830 + _id_F85F26257033C0F2 * (self.length - 2.0);
  trace = scripts\engine\trace::capsule_trace(start, end, 2.0, _id_13B5E69A1D26EDDE, _id_EB10FFC36A6B4B47, scripts\engine\utility::ter_op(isDefined(self.clip), [self, self.clip], [self]), level.doorcontentoverride, 0);

  if(getdvarint("dvar_6985E82F27803483")) {
    color = (1, 1, 1);

    if(trace["fraction"] == 1.0)
      color = (0, 1, 0);
    else
      color = (1, 0, 0);

    thread scripts\mp\utility\debug::drawline(start, end, 600, color);
    thread scripts\mp\utility\debug::drawline(start + (0, 0, _id_13B5E69A1D26EDDE), end + (0, 0, _id_13B5E69A1D26EDDE), 600, color);
    thread scripts\mp\utility\debug::drawline(start, start + (0, 0, _id_13B5E69A1D26EDDE), 600, color);
    thread scripts\mp\utility\debug::drawline(end, end + (0, 0, _id_13B5E69A1D26EDDE), 600, color);
  }

  return trace["fraction"] == 1.0;
}

perk_doorsensethink() {
  level endon("game_ended");

  for(;;) {
    foreach(door in level.doors) {
      if(door.state != 0) {
        continue;
      }
      if(isDefined(level.playerswithdoorsense) && level.playerswithdoorsense <= 0) {
        continue;
      }
      _id_B0AEB7FBA823276F = scripts\mp\utility\player::getplayersinradius(door.origin, 128);

      if(_id_B0AEB7FBA823276F.size == 0) {
        continue;
      }
      foreach(player in _id_B0AEB7FBA823276F) {
        if(player scripts\mp\utility\perk::_hasperk("specialty_door_sense"))
          perk_doorsense_outlinedoor(player, _id_B0AEB7FBA823276F, door);
      }
    }

    wait 0.1;
  }
}

perk_doorsense_outlinedoor(_id_0DADBE427BDD6C4D, _id_B0AEB7FBA823276F, door) {
  enemies = [];

  foreach(player in _id_B0AEB7FBA823276F) {
    if(player.team != _id_0DADBE427BDD6C4D.team)
      enemies[enemies.size] = player;
  }

  if(enemies.size == 0) {
    return;
  }
  foreach(enemy in enemies) {
    if(perk_doorsense_othersideofdoorcheck(_id_0DADBE427BDD6C4D, enemy, door)) {
      outlineid = scripts\mp\utility\outline::outlineenableforplayer(door, _id_0DADBE427BDD6C4D, "outline_nodepth_orange", "equipment");
      thread perk_doorsense_trackoutlinedisable(outlineid, door);
    }
  }
}

perk_doorsense_outlineenemies(_id_0DADBE427BDD6C4D, _id_B0AEB7FBA823276F, door) {
  enemies = [];

  foreach(player in _id_B0AEB7FBA823276F) {
    if(player.team != _id_0DADBE427BDD6C4D.team)
      enemies[enemies.size] = player;
  }

  if(enemies.size == 0) {
    return;
  }
  foreach(enemy in enemies) {
    if(perk_doorsense_othersideofdoorcheck(_id_0DADBE427BDD6C4D, enemy, door)) {
      outlineid = scripts\mp\utility\outline::outlineenableforplayer(enemy, _id_0DADBE427BDD6C4D, "outline_nodepth_orange", "equipment");
      thread perk_doorsense_trackoutlinedisable(outlineid, enemy);
    }
  }
}

perk_doorsense_othersideofdoorcheck(_id_52A462A16496CF97, _id_52A463A16496D1CA, door) {
  _id_6555B4D96764D0BB = vectorNormalize(anglestoright(door.angles));
  _id_8711EC2C9D549D05 = vectorNormalize(_id_52A462A16496CF97.origin - door.origin);
  _id_A663FE911064AC1C = vectorNormalize(_id_52A463A16496D1CA.origin - door.origin);
  _id_7F2DACBCAD6F9180 = vectordot(_id_6555B4D96764D0BB, _id_8711EC2C9D549D05);
  _id_7F2DAFBCAD6F9819 = vectordot(_id_6555B4D96764D0BB, _id_A663FE911064AC1C);

  if(_id_7F2DACBCAD6F9180 > 0 && _id_7F2DAFBCAD6F9819 < 0 || _id_7F2DACBCAD6F9180 < 0 && _id_7F2DAFBCAD6F9819 > 0)
    return 1;

  return 0;
}

perk_doorsense_trackoutlinedisable(outlineid, player) {
  wait 0.2;
  scripts\mp\utility\outline::outlinedisable(outlineid, player);
}

onplayerspawned() {
  _id_66EE62BFCEF7C9E5 = scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("dvar_B75E6AFFF090E790", 0) == 1;
  updatealldoorslockvisibilityforplayer(self, _id_66EE62BFCEF7C9E5);
  _id_1E635A556969499B = scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
  updatealldoorsalarmvisibilityforplayer(self, _id_1E635A556969499B);
}

updatelockpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  while(!isDefined(level.players))
    waitframe();

  foreach(player in level.players) {
    _id_66EE62BFCEF7C9E5 = player scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("dvar_B75E6AFFF090E790", 0) == 1;
    updatelockpromptvisibilityforplayer(player, _id_66EE62BFCEF7C9E5);
  }
}

updatealldoorslockvisibilityforplayer(player, _id_66EE62BFCEF7C9E5) {
  foreach(door in level.doors)
  door updatelockpromptvisibilityforplayer(player, _id_66EE62BFCEF7C9E5);
}

updatelockpromptvisibilityforplayer(player, _id_7D3CF95BDBCA0939) {
  if(!isDefined(self.lockprompt)) {
    return;
  }
  _id_37914A1EABCAEBE2 = self.state == 0 || self.state == 7;

  if(_id_37914A1EABCAEBE2 && isDefined(self.otherdoor))
    _id_37914A1EABCAEBE2 = self.otherdoor.state == 0 || self.otherdoor.state == 7;

  if(!istrue(self.breaching) && _id_37914A1EABCAEBE2) {
    if(_id_7D3CF95BDBCA0939) {
      self.lockprompt showtoplayer(player);
      self.lockprompt enableplayeruse(player);
    } else {
      self.lockprompt hidefromplayer(player);
      self.lockprompt disableplayeruse(player);
    }
  } else {
    self.lockprompt hidefromplayer(player);
    self.lockprompt disableplayeruse(player);
  }
}

lockmonitor() {
  if(!isDefined(self.lockprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 0)
      waitframe();
  }

  self.lockprompt setHintString(&"MP/DOOR_USE_LOCK");
  self.lockprompt setuseholdduration("duration_medium");
  updatelockpromptvisibility();

  for(;;) {
    self.lockprompt waittill("trigger", player);

    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(player meleeButtonPressed()) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    thread lockdoor();
  }
}

lockdoor() {
  thread changestate(7);

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(7);
}

updatealarmpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  while(!isDefined(level.players))
    waitframe();

  foreach(player in level.players) {
    _id_1E635A556969499B = player scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
    updatealarmpromptsvisibilityforplayer(player, _id_1E635A556969499B);
  }
}

updatealldoorsalarmvisibilityforplayer(player, _id_1E635A556969499B) {
  foreach(door in level.doors)
  door updatealarmpromptsvisibilityforplayer(player, _id_1E635A556969499B);
}

updatealarmpromptsvisibilityforplayer(player, _id_647AD2E497E12892) {
  if(!isDefined(self.alarmprompts)) {
    return;
  }
  foreach(_id_AE098E74B36DDBC4 in self.alarmprompts) {
    _id_4E57934D9471DD9E = _id_647AD2E497E12892 && self.state == 0 || self.state == 8 && isDefined(self.dooralarmprompt) && _id_AE098E74B36DDBC4 == self.dooralarmprompt;

    if(_id_4E57934D9471DD9E && isDefined(self.otherdoor))
      _id_4E57934D9471DD9E = _id_647AD2E497E12892 && self.otherdoor.state == 0 || self.state == 8 && _id_AE098E74B36DDBC4 == self.dooralarmprompt;

    if(_id_4E57934D9471DD9E) {
      _id_AE098E74B36DDBC4 showtoplayer(player);
      _id_AE098E74B36DDBC4 enableplayeruse(player);
      continue;
    }

    _id_AE098E74B36DDBC4 hidefromplayer(player);
    _id_AE098E74B36DDBC4 disableplayeruse(player);
  }
}

alarmmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 0)
      waitframe();
  }

  foreach(_id_AE098E74B36DDBC4 in self.alarmprompts) {
    _id_AE098E74B36DDBC4 setHintString(&"MP/DOOR_USE_ALARM");
    _id_AE098E74B36DDBC4 setuseholdduration("duration_medium");
  }

  updatealarmpromptvisibility();

  foreach(_id_AE098E74B36DDBC4 in self.alarmprompts)
  thread _alarmmonitorinternal(_id_AE098E74B36DDBC4);
}

_alarmmonitorinternal(_id_AE098E74B36DDBC4) {
  self endon("stateChanged");

  for(;;) {
    _id_AE098E74B36DDBC4 waittill("trigger", player);

    if(self.state != 0) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(player meleeButtonPressed()) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    thread alarmdoor(player, _id_AE098E74B36DDBC4);
  }
}

alarmdoor(_id_C1E072A8515CD2C1, _id_AE098E74B36DDBC4) {
  doorpos = self gettagorigin("tag_door_handle");
  playsoundatpos(_id_AE098E74B36DDBC4.origin, "mp_door_alarm_on");
  self.dooralarment = spawn("script_model", _id_AE098E74B36DDBC4.origin);
  self.dooralarment setModel("shardball_wm");
  self.dooralarment.angles = self.angles;
  self.dooralarment linkTo(self);
  self.dooralarment setentityowner(_id_C1E072A8515CD2C1);
  self.dooralarment setotherent(_id_C1E072A8515CD2C1);
  self.dooralarment setscriptablepartstate("effects", "planted", 0);
  self.dooralarmowner = _id_C1E072A8515CD2C1;
  self.dooralarmprompt = _id_AE098E74B36DDBC4;
  self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_add(self.dooralarmowner.alarmeddoors, self);

  while(self.dooralarmowner.alarmeddoors.size > 3) {
    _id_3AC146BE30C82B22 = self.dooralarmowner.alarmeddoors[0];
    _id_3AC146BE30C82B22 removealarmdoor(0);
  }

  thread changestate(8);

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(8);
}

removealarmmonitor() {
  if(!isDefined(self.dooralarmprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 8)
      waitframe();
  }

  self.dooralarmprompt setHintString(&"MP/DOOR_USE_REMOVE_ALARM");
  self.dooralarmprompt setuseholdduration("duration_medium");
  self.dooralarmprompt.owner = self.dooralarmowner;
  self.dooralarmprompt.team = self.dooralarmowner.team;
  updatealarmpromptvisibility();

  for(;;) {
    self.dooralarmprompt waittill("trigger", player);

    if(self.state != 8) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(player meleeButtonPressed()) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    thread removealarmdoor(1);
  }
}

disownalarmmonitor() {
  if(!isDefined(self.dooralarmprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 8)
      waitframe();
  }

  for(;;) {
    self.dooralarmowner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");

    if(self.state != 8) {
      return;
    }
    thread removealarmdoor(0);
  }
}

removealarmdoor(playsound) {
  if(playsound)
    playsoundatpos(self.dooralarment.origin, "mp_door_alarm_off");

  if(isDefined(self.dooralarmowner))
    self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(self.dooralarmowner.alarmeddoors, self);

  self.dooralarment delete();
  self.dooralarmowner = undefined;
  self.dooralarmprompt = undefined;
  thread changestate(0);

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(0);
}

checktriggeralarm(victim) {
  if(self.state != 8) {
    return;
  }
  _id_49A4EE9CDB34AF57 = self;

  if(!isDefined(self.dooralarment) && isDefined(self.otherdoor))
    _id_49A4EE9CDB34AF57 = self.otherdoor;

  if(!isDefined(_id_49A4EE9CDB34AF57.dooralarmowner)) {
    return;
  }
  _id_DD7DE82CB1C47A2B = _id_49A4EE9CDB34AF57.dooralarment;
  _id_C1E072A8515CD2C1 = _id_49A4EE9CDB34AF57.dooralarmowner;
  _id_49A4EE9CDB34AF57.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(_id_49A4EE9CDB34AF57.dooralarmowner.alarmeddoors, _id_49A4EE9CDB34AF57);
  _id_49A4EE9CDB34AF57.dooralarment = undefined;
  _id_49A4EE9CDB34AF57.dooralarmowner = undefined;
  _id_49A4EE9CDB34AF57.dooralarmprompt = undefined;
  _id_C1E072A8515CD2C1 scripts\mp\killstreaks\killstreaks::givescorefortriggeredalarmeddoor();

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(0);

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(victim, _id_C1E072A8515CD2C1))) {
    _id_DD7DE82CB1C47A2B playLoopSound("mp_door_alarm_lp");
    pinglocationenemyteams(self.origin, victim.team);
    _id_DD7DE82CB1C47A2B setscriptablepartstate("effects", "triggered", 0);
    wait 4.0;
    _id_DD7DE82CB1C47A2B stoploopsound();
    _id_DD7DE82CB1C47A2B delete();
  } else {
    playsoundatpos(_id_DD7DE82CB1C47A2B.origin, "mp_door_alarm_off");
    _id_DD7DE82CB1C47A2B setscriptablepartstate("effects", "neutral", 0);
    _id_DD7DE82CB1C47A2B delete();
  }
}

ajarmonitor() {
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
    waittillframeend;

    if(self.otherdoor.state != 0)
      thread changestate(6);
  }
}

breachmonitor() {
  self endon("stateChanged");
  thread monitorbreachmelee();
  self.lockprompt setHintString(&"MP/DOOR_USE_BREACH");
  self.lockprompt setuseholdduration("duration_short");
  updatelockpromptvisibility();

  if(!isDefined(self.otherdoor))
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  thread updatelocklight("lockedDoor");

  for(;;) {
    self.lockprompt waittill("trigger", player);

    if(player meleeButtonPressed()) {
      continue;
    }
    if(player scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(player issprinting() || player issprintsliding()) {
      continue;
    }
    if(player ismantling()) {
      continue;
    }
    if(istrue(self.breaching)) {
      continue;
    }
    thread breachdoor(player);
  }
}

breachdoor(player) {
  thread plantbreach(player);
}

monitorbreachmelee() {
  self endon("stateChanged");
  self notify("monitorBreachMelee");
  self endon("monitorBreachMelee");
  self.lockedmeleehealth = 150;
  self setCanDamage(1);
  damage = undefined;
  attacker = undefined;
  direction_vec = undefined;
  meansofdeath = undefined;
  modelname = undefined;
  tagname = undefined;
  partname = undefined;
  idflags = undefined;
  objweapon = undefined;
  origin = undefined;
  angles = undefined;
  normal = undefined;
  inflictor = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(meansofdeath) && !istrue(self.breaching)) {
      if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
        _id_C81A61AE7E6E7025 = isDefined(objweapon) && isDefined(objweapon.basename) && (objweapon.basename == "molotov_mp" || objweapon.basename == "thermite_mp" || objweapon.basename == "thermite_ap_mp" || objweapon.basename == "thermite_av_mp");

        if(_id_C81A61AE7E6E7025) {
          continue;
        }
        self.lockedmeleehealth = self.lockedmeleehealth - damage;

        if(isDefined(self.otherdoor))
          self.otherdoor.lockedmeleehealth = self.otherdoor.lockedmeleehealth - damage;

        if(self.lockedmeleehealth < 1) {
          if(isDefined(self.otherdoor) || istrue(self.issaloonstyle)) {
            self.otherdoor thread updatelocklight("off");
            self.otherdoor thread bashopen(attacker, attacker.origin);
          }

          thread updatelocklight("off");
          thread bashopen(attacker, attacker.origin);
          continue;
        }

        playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");
      }
    }
  }
}

#using_animtree("script_model");

plantbreach(player) {
  if(isDefined(self.otherdoor) && istrue(self.otherdoor.breaching)) {
    return;
  }
  self.breaching = 1;
  thread updatelockpromptvisibility();
  thread watchplayerdeath(player);
  origin = self.origin;
  angles = self.angles;
  right = anglestoright(angles);
  normal = vectorNormalize(player.origin - self.origin);
  dot = vectordot(right, normal);
  _id_04FBD3851A4B84B8 = dot > 0;

  if(_id_04FBD3851A4B84B8) {
    _id_C5B5DB793CA45DD3 = self.rightplantorg;
    _id_8EC84979CF48B441 = self.rightplantang;
  } else {
    _id_C5B5DB793CA45DD3 = self.leftplantorg;
    _id_8EC84979CF48B441 = self.leftplantang;
  }

  player.linktoent = player scripts\engine\utility::spawn_tag_origin();
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  scenenode = scripts\engine\utility::spawn_tag_origin(_id_C5B5DB793CA45DD3, _id_8EC84979CF48B441);
  player.linktoent moveTo(_id_C5B5DB793CA45DD3, 0.25, 0.1, 0.1);
  player.linktoent rotateTo(_id_8EC84979CF48B441, 0.25, 0.1, 0.1);
  player setstance("stand");

  if(!istrue(player givegunless())) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  player unlink();
  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(_id_C5B5DB793CA45DD3);
  player setplayerangles(_id_8EC84979CF48B441);
  faction = scripts\engine\utility::ter_op(player.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard")
    faction = scripts\engine\utility::ter_op(player.team == "allies", "ukp1", "abp1");

  player queuedialogforplayer("dx_mpp_" + faction + "_breach_plant", "cop_breach_plant", 2);
  thread create_player_rig(player, "planter");
  scenenode thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "plant");
  _id_F9FAEFD9721CAE01 = spawn("script_model", _id_C5B5DB793CA45DD3);
  _id_F9FAEFD9721CAE01 setModel("offhand_wm_c4");
  _id_F9FAEFD9721CAE01.animname = "c4";
  _id_F9FAEFD9721CAE01 useanimtree(#animtree);
  self.plantedbomb = _id_F9FAEFD9721CAE01;
  scenenode thread scripts\common\anim::anim_single_solo(_id_F9FAEFD9721CAE01, "plant");
  animlength = getanimlength(level.scr_anim["planter"]["plant"]);
  _id_84D825D7E4A24FDE = 0.5;
  wait(animlength - _id_84D825D7E4A24FDE);

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  thread bomb_planted_think(player, _id_04FBD3851A4B84B8);
  givebreachscore(player);
  wait(_id_84D825D7E4A24FDE);

  if(player isviewmodelanimplaying())
    player stopviewmodelanim();

  player thread takegunless();
  remove_player_rig(player);
  return 1;
}

bomb_planted_think(player, _id_04FBD3851A4B84B8) {
  _id_09D423F29A3F3FFE = player.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex))
      level.breachindex = 0;
    else
      level.breachindex++;

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(_id_09D423F29A3F3FFE);

  if(!self.defused) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    _id_B085E4DE6D22E286 = self.doorcenter;

    if(_id_04FBD3851A4B84B8)
      _id_383CFB84041052A4 = self.rightplantang;
    else
      _id_383CFB84041052A4 = self.leftplantang;

    _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["breach_explode"], _id_B085E4DE6D22E286, anglesToForward(_id_383CFB84041052A4) * -1.0, (0, 0, 1));
    triggerfx(_id_EFDFC6EBE7A152C5);
    physicsexplosionsphere(_id_B085E4DE6D22E286, 200, 100, 3);
    playrumbleonposition("grenade_rumble", _id_B085E4DE6D22E286);
    earthquake(0.5, 1.0, _id_B085E4DE6D22E286, 1500);
    player scripts\mp\utility\weapon::_launchgrenade("flash_grenade_mp", self.plantedbomb.origin + anglesToForward(_id_383CFB84041052A4) * 100.0, (0, 0, 0), 0.05, 1);
    player scripts\mp\utility\weapon::_launchgrenade("concussion_grenade_mp", self.plantedbomb.origin + anglesToForward(_id_383CFB84041052A4) * 100.0, (0, 0, 0), 0.05, 1);
    wait 0.1;

    if(isDefined(player))
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 50, 10, 5, player, "MOD_EXPLOSIVE", "bomb_site_mp");
    else
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 100, 50, 5, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

    thread bashopen(player, self.plantedbomb.origin);

    if(isDefined(self.otherdoor))
      self.otherdoor thread bashopen(player, self.plantedbomb.origin);
  }

  self.plantedbomb delete();
  self.plantedbomb = undefined;
  setomnvar("ui_ingame_timer_" + self.breachindex, 0);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, undefined);
  self.breaching = 0;
  thread updatelockpromptvisibility();
  thread updatelocklight("off");

  if(isDefined(self.otherdoor))
    self.otherdoor thread updatelocklight("off");
}

bomb_fuse_think(team) {
  self notify("breach_planted");
  self.timerobject = spawn("script_model", self.plantedbomb.origin);
  currenttime = gettime();
  _id_F28399727742EB23 = int(currenttime + 1000.0);
  setomnvar("ui_ingame_timer_" + self.breachindex, _id_F28399727742EB23);
  setomnvar("ui_ingame_timer_ent_" + self.breachindex, self.timerobject);
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(!self.defused && _id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 < 1500) {
      if(_id_C301D652D9A73075 <= 250)
        self.plantedbomb playSound("breach_warning_beep_05");
      else if(_id_C301D652D9A73075 < 500)
        self.plantedbomb playSound("breach_warning_beep_04");
      else if(_id_C301D652D9A73075 < 1500)
        self.plantedbomb playSound("breach_warning_beep_03");
      else
        self.plantedbomb playSound("breach_warning_beep_02");

      wait 0.25;
    } else if(_id_C301D652D9A73075 < 3500) {
      self.plantedbomb playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self.plantedbomb playSound("breach_warning_beep_01");
      wait 1.0;
    }

    if(_id_C301D652D9A73075 < 0) {
      break;
    }
  }
}

watchplayerdeath(player) {
  self endon("breach_planted");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
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

script_model_anims() {}

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player.player_rig = spawn("script_model", player.origin);
  player.player_rig setModel(_id_486DB5FA512A3B6B);
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  player watch_remove_rig();
  remove_player_rig(player);
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  _id_5BF3E22BDB650432 = player getdroptofloorposition(player.origin);

  if(isDefined(_id_5BF3E22BDB650432))
    player setOrigin(_id_5BF3E22BDB650432);
  else
    player setOrigin(player.origin + (0, 0, 100));

  player.player_rig delete();
  player.player_rig = undefined;
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_2("remove_rig", "death_or_disconnect");
}

givebreachscore(player) {
  event = "stat_C83F9DD7A46C93D8";
  points = scripts\mp\rank::getscoreinfovalue(event);
  player thread scripts\mp\rank::giverankxp(event, points);
  player thread scripts\mp\rank::scoreeventpopup(event);
}

givegunless() {
  self endon("death_or_disconnect");
  gunless = makeweapon("iw8_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);

  if(success) {
    self.gunnlessweapon = gunless;
    _id_3B64EB40368C1450::set("gunless", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("gunless", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("gunless", "melee", 0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(gunless);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return success;
}

takegunless() {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  self.takinggunless = 1;

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("gunless");
}

updatelocklight(state) {
  if(!isDefined(self.locklight)) {
    return;
  }
  self notify("updateLockLight");
  self endon("updateLockLight");

  if(!scripts\mp\flags::levelflag("scriptables_ready"))
    scripts\mp\flags::levelflagwait("scriptables_ready");

  self.locklight setscriptablepartstate("marker", state);
}

linkdoubledoors() {
  foreach(door in level.doors) {
    if(isDefined(door.otherdoor)) {
      continue;
    }
    foreach(otherdoor in level.doors) {
      if(otherdoor == door) {
        continue;
      }
      _id_0349FA0AC676F930 = door gettagorigin("tag_door_handle", 1);
      _id_0349FD0AC676FFC9 = otherdoor gettagorigin("tag_door_handle", 1);

      if(!isDefined(_id_0349FA0AC676F930) || !isDefined(_id_0349FD0AC676FFC9)) {
        continue;
      }
      distsq = distancesquared(_id_0349FA0AC676F930, _id_0349FD0AC676FFC9);

      if(distsq < 225) {
        if(distsq < 100) {
          door.issaloonstyle = 1;
          otherdoor.issaloonstyle = 1;
        }

        otherdoor.otherdoor = door;
        door.otherdoor = otherdoor;

        if(isDefined(door.lockprompt) && isDefined(otherdoor.lockprompt)) {
          otherdoor.lockprompt delete();
          otherdoor.lockprompt = door.lockprompt;
          _id_F95FEB63C772E28F = (_id_0349FA0AC676F930 + _id_0349FD0AC676FFC9) * 0.5 + (0, 0, 15);
          door.lockprompt unlink();
          door.lockprompt.origin = _id_F95FEB63C772E28F;
          door thread changestate(door.state);
          otherdoor thread changestate(otherdoor.state);
          door.leftplantorg = (_id_F95FEB63C772E28F[0], _id_F95FEB63C772E28F[1], door.origin[2]) + anglestoright(door.baseangles) * -24.5;
          door.leftplantang = (0, door.baseangles[1] - 90.0, 0);
          door.rightplantorg = (_id_F95FEB63C772E28F[0], _id_F95FEB63C772E28F[1], door.origin[2]) + anglestoright(door.baseangles) * 24.5;
          door.rightplantang = (0, door.baseangles[1] + 90.0, 0);
          otherdoor.leftplantorg = (_id_F95FEB63C772E28F[0], _id_F95FEB63C772E28F[1], otherdoor.origin[2]) + anglestoright(otherdoor.baseangles) * -24.5;
          otherdoor.leftplantang = (0, otherdoor.baseangles[1] - 90.0, 0);
          otherdoor.rightplantorg = (_id_F95FEB63C772E28F[0], _id_F95FEB63C772E28F[1], otherdoor.origin[2]) + anglestoright(otherdoor.baseangles) * 24.5;
          otherdoor.rightplantang = (0, otherdoor.baseangles[1] + 90.0, 0);
        }
      }
    }
  }
}

door_createnavobstacle() {
  if(!isDefined(self.clipent)) {
    return;
  }
  if(isDefined(self.doornavobstacle)) {
    return;
  }
  self.doornavobstacle = createnavobstaclebyent(self.clipent);
}

door_destroynavobstacle() {
  if(!isDefined(self.doornavobstacle)) {
    return;
  }
  destroynavobstacle(self.doornavobstacle);
  self.doornavobstacle = undefined;
}

door_enableaudioportal() {
  if(isDefined(self.audioportalent))
    self.audioportalent enableaudioportal(1);
}

door_disableaudioportal() {
  if(isDefined(self.otherdoor) && (self.otherdoor.state != 0 && self.otherdoor.state != 7 && self.otherdoor.state != 8)) {
    return;
  }
  if(isDefined(self.audioportalent))
    self.audioportalent enableaudioportal(0);
}

door_can_open_check() {
  return self.state == 6 || self.state == 0;
}