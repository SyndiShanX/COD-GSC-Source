/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\elevator.gsc
***********************************************/

init() {
  if(getDvar("scr_elevator_disabled") == "1") {
    return;
  }
  _id_ADEDE90FB88CD9CC = getEntArray("elevator_group", "targetname");

  if(!isDefined(_id_ADEDE90FB88CD9CC)) {
    return;
  }
  if(!_id_ADEDE90FB88CD9CC.size) {
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
  foreach(_id_EEC55FABA21F3653 in level.elevators) {
    _id_EEC55FABA21F3653 thread elevator_think();
    _id_EEC55FABA21F3653 thread elevator_sound_think();
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
    level.elevator_return = elevator_get_dvar_int("dvar_0A2D058994E722A4", "0");
    level.elevator_waittime = elevator_get_dvar_int("scr_elevator_waittime", "6");
    level.elevator_aggressive_call = elevator_get_dvar_int("scr_elevator_aggressive_call", "0");
    level.elevator_debug = elevator_get_dvar_int("debug_elevator", "0");

    if(scripts\common\utility::issp())
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "0");
    else
      level.elevator_motion_detection = elevator_get_dvar_int("scr_elevator_motion_detection", "1");

    wait 1;
  }
}

elevator_think() {
  elevator_fsm("[A]");
}

elevator_call() {
  foreach(_id_651E74ABAA82EBA1 in level.elevator_callbuttons)
  _id_651E74ABAA82EBA1 thread monitor_callbutton();
}

floor_override(_id_24B5A460BFBB32DC) {
  self endon("elevator_moving");
  self.floor_override = 0;
  self.overrider = undefined;

  for(;;) {
    _id_24B5A460BFBB32DC waittill("trigger", player);
    self.floor_override = 1;
    self.overrider = player;
    break;
  }

  self notify("floor_override");
}

elevator_fsm(state) {
  self.estate = state;
  _id_C37005BC24398E68 = get_housing_door_trigger();
  _id_24B5A460BFBB32DC = get_housing_inside_trigger();

  for(;;) {
    if(self.estate == "[A]") {
      if(level.elevator_return && get_curfloor() != get_initfloor()) {
        self.moveto_floor = get_initfloor();
        thread floor_override(_id_24B5A460BFBB32DC);
        waittill_or_timeout("floor_override", level.elevator_waittime);

        if(self.floor_override && isDefined(self.overrider) && isPlayer(self.overrider))
          get_floor(self.overrider);

        self.estate = "[B]";
        continue;
      }

      for(;;) {
        if(self.moveto_floor == get_curfloor())
          param = _id_24B5A460BFBB32DC discrete_waittill("trigger");
        else
          param = "elevator_called";

        if(isstring(param) && param == "elevator_called" && self.moveto_floor != get_curfloor()) {
          self.estate = "[B]";
          break;
        }

        if(isDefined(param) && isPlayer(param) && isalive(param)) {
          _id_DB83FB26A6892637 = param istouching(_id_24B5A460BFBB32DC);
          _id_BA5566B3BF32BA20 = isDefined(_id_24B5A460BFBB32DC.motion_trigger) && param istouching(_id_24B5A460BFBB32DC.motion_trigger);
          _id_FAB9923D97D18FEF = _id_DB83FB26A6892637 || _id_BA5566B3BF32BA20;

          if(_id_FAB9923D97D18FEF) {
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
      thread elevator_interrupt(_id_C37005BC24398E68);
      floor_num = get_curfloor();
      thread close_inner_doors();
      thread close_outer_doors(floor_num);
      scripts\engine\utility::waittill_any_2("closed_inner_doors", "interrupted");

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
    player = discrete_waittill("trigger");
    _id_1F1D06F9964427B0 = undefined;
    _id_7303178F63EDFED5 = [];

    foreach(_id_FE8F7703F6313ED4, _id_5774A6A46FA3BE88 in self.e) {
      _id_1F1D06F9964427B0 = _id_FE8F7703F6313ED4;
      _id_7303178F63EDFED5 = _id_5774A6A46FA3BE88;
    }

    _id_D8D49B0100702AD5 = 0;

    foreach(_id_EEC55FABA21F3653 in _id_7303178F63EDFED5) {
      moving = _id_EEC55FABA21F3653 elevator_floor_update();

      if(!level.elevator_aggressive_call && !moving) {
        if(_id_EEC55FABA21F3653 get_curfloor() == _id_1F1D06F9964427B0) {
          _id_D8D49B0100702AD5 = 1;
          _id_7303178F63EDFED5 = [];
          break;
        }
      }
    }

    foreach(_id_EEC55FABA21F3653 in _id_7303178F63EDFED5) {
      if(_id_EEC55FABA21F3653.estate == "[A]") {
        _id_EEC55FABA21F3653 call_elevator(_id_1F1D06F9964427B0);
        _id_D8D49B0100702AD5 = 1;

        if(!level.elevator_aggressive_call) {
          break;
        }
      }
    }

    if(_id_D8D49B0100702AD5)
      self playSound("elev_bell_ding");
  }
}

call_elevator(_id_1F1D06F9964427B0) {
  self.moveto_floor = _id_1F1D06F9964427B0;
  _id_B2DEFA6DE22BC4BA = get_housing_inside_trigger();
  _id_B2DEFA6DE22BC4BA notify("trigger", "elevator_called");

  if(level.elevator_motion_detection)
    _id_B2DEFA6DE22BC4BA.motion_trigger notify("trigger", "elevator_called");
}

get_floor(player) {
  _id_BD15884F5CD41F16 = get_outer_doorsets();

  if(_id_BD15884F5CD41F16.size == 2) {
    _id_1703FB5D6A6ACB41 = get_curfloor();
    self.moveto_floor = !_id_1703FB5D6A6ACB41;
    return;
  }

  player setclientdvar("player_current_floor", get_curfloor());

  for(;;) {
    player waittill("menuresponse", menu, _id_7E9CCC2D6DDB44DA);

    if(menu == "elevator_floor_selector") {
      if(_id_7E9CCC2D6DDB44DA != "none")
        self.moveto_floor = int(_id_7E9CCC2D6DDB44DA);

      break;
    }
  }
}

elevator_interrupt(_id_C37005BC24398E68) {
  self notify("interrupt_watch");
  level notify("elevator_interior_button_pressed");
  self endon("interrupt_watch");
  self endon("elevator_moving");
  self.elevator_interrupted = 0;
  wait 0.5;
  _id_C37005BC24398E68 waittill("trigger", player);
  self notify("interrupted");
  self.elevator_interrupted = 1;
}

elevator_floor_update() {
  _id_DB9D06DCDD758731 = get_housing_mainframe();
  _id_455B112DF88184E0 = _id_DB9D06DCDD758731.origin;
  moving = 1;

  foreach(_id_FE8F7703F6313ED4, _id_E3119E31D0658DDA in get_outer_doorsets()) {
    _id_1C49C4424C716A30 = self.e["floor" + _id_FE8F7703F6313ED4 + "_pos"];

    if(_id_455B112DF88184E0 == _id_1C49C4424C716A30) {
      self.e["current_floor"] = _id_FE8F7703F6313ED4;
      moving = 0;
    }
  }

  return moving;
}

elevator_sound_think() {
  _id_B1753895A03172EA = get_housing_musak_model();

  if(level.elevator_music && isDefined(_id_B1753895A03172EA))
    _id_B1753895A03172EA playLoopSound("elev_musak_loop");

  thread listen_for("closing_inner_doors");
  thread listen_for("opening_inner_doors");
  thread listen_for("closed_inner_doors");
  thread listen_for("opened_inner_doors");

  foreach(_id_FE8F7703F6313ED4, _id_E3119E31D0658DDA in get_outer_doorsets()) {
    thread listen_for("closing_floor_" + _id_FE8F7703F6313ED4 + "_outer_doors");
    thread listen_for("opening_floor_" + _id_FE8F7703F6313ED4 + "_outer_doors");
    thread listen_for("closed_floor_" + _id_FE8F7703F6313ED4 + "_outer_doors");
    thread listen_for("opened_floor_" + _id_FE8F7703F6313ED4 + "_outer_doors");
  }

  thread listen_for("interrupted");
  thread listen_for("elevator_moving");
  thread listen_for("elevator_moved");
}

listen_for(msg) {
  for(;;) {
    self waittill(msg);
    _id_DB9D06DCDD758731 = get_housing_mainframe();

    if(issubstr(msg, "closing_"))
      _id_DB9D06DCDD758731 playSound("elev_door_close");

    if(issubstr(msg, "opening_"))
      _id_DB9D06DCDD758731 playSound("elev_door_open");

    if(msg == "elevator_moving") {
      _id_DB9D06DCDD758731 playSound("elev_run_start");
      _id_DB9D06DCDD758731 playLoopSound("elev_run_loop");
    }

    if(msg == "interrupted")
      _id_DB9D06DCDD758731 playSound("elev_door_interupt");

    if(msg == "elevator_moved") {
      _id_DB9D06DCDD758731 stoploopsound("elev_run_loop");
      _id_DB9D06DCDD758731 playSound("elev_run_end");
      _id_DB9D06DCDD758731 playSound("elev_bell_ding");
    }
  }
}

position_elevators() {
  foreach(e, _id_EEC55FABA21F3653 in level.elevators) {
    _id_EEC55FABA21F3653.moveto_floor = _id_EEC55FABA21F3653 get_curfloor();

    foreach(floor_num, _id_677D252949D6780F in _id_EEC55FABA21F3653 get_outer_doorsets()) {
      if(_id_EEC55FABA21F3653 get_curfloor() != floor_num)
        _id_EEC55FABA21F3653 thread close_outer_doors(floor_num);
    }
  }
}

elevator_move(floor_num) {
  self notify("elevator_moving");
  self endon("elevator_moving");
  _id_DB9D06DCDD758731 = get_housing_mainframe();
  _id_4B9803DD55CA19DC = self.e["floor" + floor_num + "_pos"] - _id_DB9D06DCDD758731.origin;
  speed = level.elevator_speed;
  dist = abs(distance(self.e["floor" + floor_num + "_pos"], _id_DB9D06DCDD758731.origin));
  movetime = dist / speed;
  _id_DB9D06DCDD758731 moveTo(_id_DB9D06DCDD758731.origin + _id_4B9803DD55CA19DC, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);

  foreach(part in get_housing_children()) {
    _id_FBF029F7C07ED1E8 = part.origin + _id_4B9803DD55CA19DC;

    if(!issubstr(part.classname, "trigger_")) {
      part moveTo(_id_FBF029F7C07ED1E8, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel);
      continue;
    }

    part.origin = _id_FBF029F7C07ED1E8;
  }

  waittill_finish_moving(_id_DB9D06DCDD758731, self.e["floor" + floor_num + "_pos"]);
  self notify("elevator_moved");
}

close_inner_doors() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");
  _id_000540862D753425 = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  _id_DB9D06DCDD758731 = get_housing_mainframe();
  _id_D73B15F6C837CF86 = get_housing_closedpos();
  closed_pos = (_id_D73B15F6C837CF86[0], _id_D73B15F6C837CF86[1], _id_DB9D06DCDD758731.origin[2]);
  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(_id_000540862D753425.origin, closed_pos));
  movetime = dist / speed;
  _id_000540862D753425 moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(_id_000540862D753425, closed_pos, right_door, closed_pos);
  self notify("closed_inner_doors");
}

open_inner_doors() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");
  _id_000540862D753425 = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  _id_DB9D06DCDD758731 = get_housing_mainframe();
  _id_E389930453448AA3 = get_housing_leftdoor_opened_pos();
  _id_5A488A3500727BA4 = get_housing_rightdoor_opened_pos();
  _id_77DD329A87B4E69D = (_id_E389930453448AA3[0], _id_E389930453448AA3[1], _id_DB9D06DCDD758731.origin[2]);
  _id_A4A379D93E5F8616 = (_id_5A488A3500727BA4[0], _id_5A488A3500727BA4[1], _id_DB9D06DCDD758731.origin[2]);
  speed = level.elevator_innerdoorspeed;
  dist = abs(distance(_id_77DD329A87B4E69D, _id_A4A379D93E5F8616) * 0.5);
  movetime = dist / speed * 0.5;
  _id_000540862D753425 moveTo(_id_77DD329A87B4E69D, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(_id_A4A379D93E5F8616, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(_id_000540862D753425, _id_77DD329A87B4E69D, right_door, _id_A4A379D93E5F8616);
  self notify("opened_inner_doors");
}

close_outer_doors(floor_num) {
  self notify("closing_floor_" + floor_num + "_outer_doors");
  self endon("closing_floor_" + floor_num + "_outer_doors");
  self endon("opening_floor_" + floor_num + "_outer_doors");
  _id_000540862D753425 = get_outer_leftdoor(floor_num);
  right_door = get_outer_rightdoor(floor_num);
  _id_77DD329A87B4E69D = get_outer_leftdoor_openedpos(floor_num);
  closed_pos = get_outer_closedpos(floor_num);
  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(_id_77DD329A87B4E69D, closed_pos));
  movetime = dist / speed;
  _id_000540862D753425 moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(closed_pos, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(_id_000540862D753425, closed_pos, right_door, closed_pos);
  self notify("closed_floor_" + floor_num + "_outer_doors");
}

open_outer_doors(floor_num) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + floor_num + "_outer_doors");
  self endon("opening_floor_" + floor_num + "_outer_doors");
  _id_000540862D753425 = get_outer_leftdoor(floor_num);
  right_door = get_outer_rightdoor(floor_num);
  _id_77DD329A87B4E69D = get_outer_leftdoor_openedpos(floor_num);
  _id_A4A379D93E5F8616 = get_outer_rightdoor_openedpos(floor_num);
  closed_pos = get_outer_closedpos(floor_num);
  speed = level.elevator_outterdoorspeed;
  dist = abs(distance(_id_77DD329A87B4E69D, closed_pos));
  movetime = dist / speed * 0.5;
  _id_000540862D753425 moveTo(_id_77DD329A87B4E69D, movetime, movetime * 0.1, movetime * 0.25);
  right_door moveTo(_id_A4A379D93E5F8616, movetime, movetime * 0.1, movetime * 0.25);
  waittill_finish_moving(_id_000540862D753425, _id_77DD329A87B4E69D, right_door, _id_A4A379D93E5F8616);
  self notify("opened_floor_" + floor_num + "_outer_doors");
}

build_elevators() {
  _id_ADEDE90FB88CD9CC = getEntArray("elevator_group", "targetname");
  _id_020AA4EADBC86B00 = getEntArray("elevator_housing", "targetname");
  _id_099D29B5B670BE15 = getEntArray("elevator_doorset", "targetname");

  foreach(_id_83CFFCDCD2976304 in _id_ADEDE90FB88CD9CC) {
    _id_57DFF06718226286 = getEnt(_id_83CFFCDCD2976304.target, "targetname");
    _id_4195778095AACA54 = [];
    _id_4195778095AACA54[0] = min(_id_83CFFCDCD2976304.origin[0], _id_57DFF06718226286.origin[0]);
    _id_4195778095AACA54[1] = max(_id_83CFFCDCD2976304.origin[0], _id_57DFF06718226286.origin[0]);
    _id_4195778095AACA54[2] = min(_id_83CFFCDCD2976304.origin[1], _id_57DFF06718226286.origin[1]);
    _id_4195778095AACA54[3] = max(_id_83CFFCDCD2976304.origin[1], _id_57DFF06718226286.origin[1]);
    parts = spawnStruct();
    parts.e["id"] = level.elevators.size;
    parts.e["housing"] = [];
    parts.e["housing"]["mainframe"] = [];

    foreach(_id_B9066CF7C718E973 in _id_020AA4EADBC86B00) {
      if(_id_B9066CF7C718E973 isinbound(_id_4195778095AACA54)) {
        parts.e["housing"]["mainframe"][parts.e["housing"]["mainframe"].size] = _id_B9066CF7C718E973;

        if(_id_B9066CF7C718E973.classname == "script_model") {
          continue;
        }
        if(_id_B9066CF7C718E973.code_classname == "light") {
          continue;
        }
        _id_29A503D62F6811D9 = getEnt(_id_B9066CF7C718E973.target, "targetname");
        parts.e["housing"]["left_door"] = _id_29A503D62F6811D9;
        parts.e["housing"]["left_door_opened_pos"] = _id_29A503D62F6811D9.origin;
        _id_B6A12B29F856D2C2 = getEnt(_id_29A503D62F6811D9.target, "targetname");
        parts.e["housing"]["right_door"] = _id_B6A12B29F856D2C2;
        parts.e["housing"]["right_door_opened_pos"] = _id_B6A12B29F856D2C2.origin;
        _id_0701670BFD9F3BF8 = (_id_29A503D62F6811D9.origin - _id_B6A12B29F856D2C2.origin) * (0.5, 0.5, 0.5) + _id_B6A12B29F856D2C2.origin;
        parts.e["housing"]["door_closed_pos"] = _id_0701670BFD9F3BF8;
        _id_AF123F3B3717038E = getEnt(_id_B6A12B29F856D2C2.target, "targetname");
        parts.e["housing"]["door_trigger"] = _id_AF123F3B3717038E;
        _id_B2DEFA6DE22BC4BA = getEnt(_id_AF123F3B3717038E.target, "targetname");
        parts.e["housing"]["inside_trigger"] = _id_B2DEFA6DE22BC4BA;
        _id_B2DEFA6DE22BC4BA make_discrete_trigger();
        _id_B2DEFA6DE22BC4BA.motion_trigger = spawn("trigger_radius", _id_B9066CF7C718E973.origin, 0, 64, 128);
      }
    }

    parts.e["outer_doorset"] = [];

    foreach(_id_998EB4531454C6E4 in _id_099D29B5B670BE15) {
      if(_id_998EB4531454C6E4 isinbound(_id_4195778095AACA54)) {
        _id_D1C3449BFB5C7CD0 = isDefined(_id_998EB4531454C6E4.script_noteworthy) && _id_998EB4531454C6E4.script_noteworthy == "closed_for_lighting";
        _id_F6A5CF1C5D09A6FE = parts.e["outer_doorset"].size;
        parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE] = [];
        parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["door_closed_pos"] = _id_998EB4531454C6E4.origin;
        _id_69A72D7EC7EF23A4 = getEnt(_id_998EB4531454C6E4.target, "targetname");
        parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["left_door"] = _id_69A72D7EC7EF23A4;
        parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["left_door_opened_pos"] = _id_69A72D7EC7EF23A4.origin;
        _id_4879514832A59AB5 = getEnt(_id_69A72D7EC7EF23A4.target, "targetname");
        parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["right_door"] = _id_4879514832A59AB5;
        parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["right_door_opened_pos"] = _id_4879514832A59AB5.origin;

        if(_id_D1C3449BFB5C7CD0) {
          _id_ACD175A84B61485C = _id_998EB4531454C6E4.origin - _id_69A72D7EC7EF23A4.origin;
          _id_998EB4531454C6E4.origin = _id_69A72D7EC7EF23A4.origin;
          _id_69A72D7EC7EF23A4.origin = _id_69A72D7EC7EF23A4.origin + _id_ACD175A84B61485C;
          _id_4879514832A59AB5.origin = _id_4879514832A59AB5.origin - _id_ACD175A84B61485C;
          parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["door_closed_pos"] = _id_998EB4531454C6E4.origin;
          parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["left_door_opened_pos"] = _id_69A72D7EC7EF23A4.origin;
          parts.e["outer_doorset"][_id_F6A5CF1C5D09A6FE]["right_door_opened_pos"] = _id_4879514832A59AB5.origin;
        }
      }
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < parts.e["outer_doorset"].size - 1; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < parts.e["outer_doorset"].size - 1 - _id_AC0E594AC96AA3A8; _id_AC0E5C4AC96AAA41++) {
        if(parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["door_closed_pos"][2] < parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["door_closed_pos"][2]) {
          _id_7F2DAD6015BC0D0A = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["left_door"];
          _id_3059A59B44B17477 = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["left_door_opened_pos"];
          _id_C04C69A2100CD59B = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["right_door"];
          _id_FDFB0DA61E43818C = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["right_door_opened_pos"];
          _id_CF422D8BEA6D8FDD = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["door_closed_pos"];
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["left_door"] = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["left_door"];
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["left_door_opened_pos"] = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["left_door_opened_pos"];
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["right_door"] = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["right_door"];
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["right_door_opened_pos"] = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["right_door_opened_pos"];
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41]["door_closed_pos"] = parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["door_closed_pos"];
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["left_door"] = _id_7F2DAD6015BC0D0A;
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["left_door_opened_pos"] = _id_3059A59B44B17477;
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["right_door"] = _id_C04C69A2100CD59B;
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["right_door_opened_pos"] = _id_FDFB0DA61E43818C;
          parts.e["outer_doorset"][_id_AC0E5C4AC96AAA41 + 1]["door_closed_pos"] = _id_CF422D8BEA6D8FDD;
        }
      }
    }

    _id_1C49C4424C716A30 = [];

    foreach(_id_AC0E594AC96AA3A8, _id_3C922F24E6D5726B in parts.e["outer_doorset"]) {
      _id_DB9D06DCDD758731 = parts get_housing_mainframe();
      _id_1C49C4424C716A30 = (_id_DB9D06DCDD758731.origin[0], _id_DB9D06DCDD758731.origin[1], _id_3C922F24E6D5726B["door_closed_pos"][2]);
      parts.e["floor" + _id_AC0E594AC96AA3A8 + "_pos"] = _id_1C49C4424C716A30;

      if(_id_DB9D06DCDD758731.origin == _id_1C49C4424C716A30) {
        parts.e["initial_floor"] = _id_AC0E594AC96AA3A8;
        parts.e["current_floor"] = _id_AC0E594AC96AA3A8;
      }
    }

    level.elevators[level.elevators.size] = parts;
    _id_83CFFCDCD2976304 delete();
    _id_57DFF06718226286 delete();
  }

  foreach(_id_998EB4531454C6E4 in _id_099D29B5B670BE15)
  _id_998EB4531454C6E4 delete();

  build_call_buttons();

  if(!level.elevator_motion_detection)
    setup_hints();

  foreach(_id_EEC55FABA21F3653 in level.elevators) {
    _id_FA32CD866699414A = _id_EEC55FABA21F3653 get_housing_primarylight();

    if(isDefined(_id_FA32CD866699414A) && _id_FA32CD866699414A.size) {
      foreach(_id_B88E7E111018D3FD in _id_FA32CD866699414A)
      _id_B88E7E111018D3FD setlightintensity(0.75);
    }
  }
}

build_call_buttons() {
  level.elevator_callbuttons = getEntArray("elevator_call", "targetname");

  foreach(_id_651E74ABAA82EBA1 in level.elevator_callbuttons) {
    _id_651E74ABAA82EBA1.e = [];
    _id_7C9BD32185A94469 = (0, 0, _id_651E74ABAA82EBA1.origin[2]);
    _id_84A9E27D3F377CDF = (_id_651E74ABAA82EBA1.origin[0], _id_651E74ABAA82EBA1.origin[1], 0);
    _id_C0FC917AAED1B9BB = [];

    foreach(_id_CA390C0243AC052C, _id_EEC55FABA21F3653 in level.elevators) {
      foreach(_id_E484449A2EF68BE1, _id_E3119E31D0658DDA in _id_EEC55FABA21F3653 get_outer_doorsets()) {
        _id_CF86A66BE5425DBC = (0, 0, _id_EEC55FABA21F3653.e["floor" + _id_E484449A2EF68BE1 + "_pos"][2]);
        _id_EEFB6A6623D8D576 = (_id_EEC55FABA21F3653.e["floor" + _id_E484449A2EF68BE1 + "_pos"][0], _id_EEC55FABA21F3653.e["floor" + _id_E484449A2EF68BE1 + "_pos"][1], 0);

        if(abs(distance(_id_7C9BD32185A94469, _id_CF86A66BE5425DBC)) <= level.elevator_callbutton_link_v) {
          if(abs(distance(_id_84A9E27D3F377CDF, _id_EEFB6A6623D8D576)) <= level.elevator_callbutton_link_h) {
            _id_C0FC917AAED1B9BB[_id_C0FC917AAED1B9BB.size] = _id_EEC55FABA21F3653;
            _id_651E74ABAA82EBA1.e[_id_E484449A2EF68BE1] = _id_C0FC917AAED1B9BB;
          }
        }
      }
    }

    _id_651E74ABAA82EBA1 make_discrete_trigger();
    _id_651E74ABAA82EBA1.motion_trigger = spawn("trigger_radius", _id_651E74ABAA82EBA1.origin + (0, 0, -32), 0, 32, 64);
  }
}

setup_hints() {
  foreach(_id_EEC55FABA21F3653 in level.elevators) {
    _id_9BD00D8648D3D2BB = _id_EEC55FABA21F3653 get_housing_inside_trigger();
    _id_E108D0ABDB42CFF6 = _id_EEC55FABA21F3653 get_outer_doorsets();
    _id_DE5F949CF6389975 = _id_E108D0ABDB42CFF6.size;
    _id_9BD00D8648D3D2BB setCursorHint("HINT_NOICON");

    if(_id_DE5F949CF6389975 > 2) {
      _id_9BD00D8648D3D2BB setHintString(&"ELEVATOR_FLOOR_SELECT_HINT");
      continue;
    }

    _id_9BD00D8648D3D2BB setHintString(&"ELEVATOR_USE_HINT");
  }

  foreach(_id_651E74ABAA82EBA1 in level.elevator_callbuttons) {
    _id_651E74ABAA82EBA1 setCursorHint("HINT_NOICON");
    _id_651E74ABAA82EBA1 setHintString(&"ELEVATOR_CALL_HINT");
  }
}

make_discrete_trigger() {
  self.enabled = 1;
  disable_trigger();
}

discrete_waittill(msg) {
  enable_trigger();

  if(level.elevator_motion_detection)
    self.motion_trigger waittill(msg, param);
  else
    self waittill(msg, param);

  disable_trigger();
  return param;
}

enable_trigger() {
  if(!self.enabled) {
    self.enabled = 1;
    self.origin = self.origin + (0, 0, 10000);

    if(isDefined(self.motion_trigger))
      self.motion_trigger.origin = self.motion_trigger.origin + (0, 0, 10000);
  }
}

disable_trigger() {
  self notify("disable_trigger");

  if(self.enabled)
    thread disable_trigger_helper();
}

disable_trigger_helper() {
  self endon("disable_trigger");
  self.enabled = 0;
  wait 1.5;
  self.origin = self.origin + (0, 0, -10000);

  if(isDefined(self.motion_trigger))
    self.motion_trigger.origin = self.motion_trigger.origin + (0, 0, -10000);
}

get_outer_doorset(floor_num) {
  return self.e["outer_doorset"][floor_num];
}

get_outer_doorsets() {
  return self.e["outer_doorset"];
}

get_outer_closedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["door_closed_pos"];
}

get_outer_leftdoor(floor_num) {
  return self.e["outer_doorset"][floor_num]["left_door"];
}

get_outer_rightdoor(floor_num) {
  return self.e["outer_doorset"][floor_num]["right_door"];
}

get_outer_leftdoor_openedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["left_door_opened_pos"];
}

get_outer_rightdoor_openedpos(floor_num) {
  return self.e["outer_doorset"][floor_num]["right_door_opened_pos"];
}

get_housing_children() {
  children = [];
  _id_C37005BC24398E68 = get_housing_door_trigger();
  _id_9BD00D8648D3D2BB = get_housing_inside_trigger();
  _id_D596B9CFFB652EF6 = _id_9BD00D8648D3D2BB.motion_trigger;
  _id_000540862D753425 = get_housing_leftdoor();
  right_door = get_housing_rightdoor();
  children[children.size] = _id_C37005BC24398E68;
  children[children.size] = _id_9BD00D8648D3D2BB;
  children[children.size] = _id_000540862D753425;
  children[children.size] = right_door;

  if(isDefined(_id_D596B9CFFB652EF6))
    children[children.size] = _id_D596B9CFFB652EF6;

  script_models = get_housing_models();

  foreach(_id_F519F16439798FC9 in script_models)
  children[children.size] = _id_F519F16439798FC9;

  _id_F064D39CF631A944 = get_housing_primarylight();

  foreach(_id_B88E7E111018D3FD in _id_F064D39CF631A944)
  children[children.size] = _id_B88E7E111018D3FD;

  return children;
}

get_housing_mainframe() {
  parts = self.e["housing"]["mainframe"];
  _id_D5B09E442F70BAC2 = undefined;

  foreach(part in parts) {
    if(part.classname != "script_model" && part.code_classname != "light")
      _id_D5B09E442F70BAC2 = part;
  }

  return _id_D5B09E442F70BAC2;
}

get_housing_models() {
  parts = self.e["housing"]["mainframe"];
  _id_212F549BB87DC0E3 = [];

  foreach(part in parts) {
    if(part.classname == "script_model")
      _id_212F549BB87DC0E3[_id_212F549BB87DC0E3.size] = part;
  }

  return _id_212F549BB87DC0E3;
}

get_housing_primarylight() {
  parts = self.e["housing"]["mainframe"];
  _id_6DDFF02957646117 = [];

  foreach(part in parts) {
    if(part.code_classname == "light")
      _id_6DDFF02957646117[_id_6DDFF02957646117.size] = part;
  }

  return _id_6DDFF02957646117;
}

get_housing_musak_model() {
  models = get_housing_models();
  _id_B1753895A03172EA = undefined;

  foreach(_id_F519F16439798FC9 in models) {
    if(isDefined(_id_F519F16439798FC9.script_noteworthy) && _id_F519F16439798FC9.script_noteworthy == "play_musak")
      _id_B1753895A03172EA = _id_F519F16439798FC9;
  }

  return _id_B1753895A03172EA;
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
  moving = elevator_floor_update();
  return self.e["current_floor"];
}

get_initfloor() {
  return self.e["initial_floor"];
}

waittill_finish_moving(_id_6848D0559BA20855, _id_E46B13EF3F8C9DCB, _id_6848CD559BA201BC, _id_4ED727C032053180) {
  if(!isDefined(_id_6848CD559BA201BC) && !isDefined(_id_4ED727C032053180)) {
    _id_6848CD559BA201BC = _id_6848D0559BA20855;
    _id_4ED727C032053180 = _id_E46B13EF3F8C9DCB;
  }

  for(;;) {
    _id_AF7BFEC8A5F57692 = _id_6848D0559BA20855.origin;
    _id_24312405E5D18857 = _id_6848CD559BA201BC.origin;

    if(_id_AF7BFEC8A5F57692 == _id_E46B13EF3F8C9DCB && _id_24312405E5D18857 == _id_4ED727C032053180) {
      break;
    }

    wait 0.05;
  }
}

isinbound(_id_45287878F0BC903F) {
  _id_0689C2033FE04622 = self.origin[0];
  _id_0689C3033FE04855 = self.origin[1];
  min_x = _id_45287878F0BC903F[0];
  max_x = _id_45287878F0BC903F[1];
  min_y = _id_45287878F0BC903F[2];
  max_y = _id_45287878F0BC903F[3];
  return _id_0689C2033FE04622 >= min_x && _id_0689C2033FE04622 <= max_x && _id_0689C3033FE04855 >= min_y && _id_0689C3033FE04855 <= max_y;
}

isinboundingspere(_id_45287878F0BC903F) {
  _id_0689C2033FE04622 = self.origin[0];
  _id_0689C3033FE04855 = self.origin[1];
  min_x = _id_45287878F0BC903F[0];
  max_x = _id_45287878F0BC903F[1];
  min_y = _id_45287878F0BC903F[2];
  max_y = _id_45287878F0BC903F[3];
  _id_7F6034BB0BC7E29E = (min_x + max_x) / 2;
  _id_7F6035BB0BC7E4D1 = (min_y + max_y) / 2;
  radius = abs(distance((min_x, min_y, 0), (_id_7F6034BB0BC7E29E, _id_7F6035BB0BC7E4D1, 0)));
  return abs(distance((_id_0689C2033FE04622, _id_0689C3033FE04855, 0), (_id_7F6034BB0BC7E29E, _id_7F6035BB0BC7E4D1, 0))) < radius;
}

waittill_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

elevator_get_dvar_int(dvar, def) {
  return int(elevator_get_dvar(dvar, def));
}

elevator_get_dvar(dvar, def) {
  if(getDvar(dvar) != "")
    return getdvarfloat(dvar);
  else {
    setDvar(dvar, def);
    return def;
  }
}

elevator_debug() {
  if(!level.elevator_debug) {
    return;
  }
  for(;;) {
    if(level.elevator_debug != 2) {
      continue;
    }
    foreach(_id_AC0E594AC96AA3A8, _id_EEC55FABA21F3653 in level.elevators) {
      _id_DB9D06DCDD758731 = _id_EEC55FABA21F3653 get_housing_mainframe();
      _id_B1753895A03172EA = _id_EEC55FABA21F3653 get_housing_musak_model();

      foreach(_id_AC0E5C4AC96AAA41, _id_E3119E31D0658DDA in _id_EEC55FABA21F3653.e["outer_doorset"]) {}
    }

    foreach(_id_651E74ABAA82EBA1 in level.elevator_callbuttons) {
      foreach(_id_E484449A2EF68BE1, _id_E3119E31D0658DDA in _id_651E74ABAA82EBA1.e) {
        _id_59422A90759990E7 = 0;

        foreach(_id_CA390C0243AC052C, _id_1CFA296A253FDC9D in _id_E3119E31D0658DDA) {
          _id_59422A90759990E7++;
          _id_BD86AD8F5C8000AD = _id_651E74ABAA82EBA1.origin + (0, 0, _id_59422A90759990E7 * -4);
        }
      }
    }

    wait 0.05;
  }
}

_id_0D9D18DAB18EBDED(movingplatforment) {
  if(!isDefined(movingplatforment))
    return 0;

  if(isDefined(level.elevators)) {
    foreach(_id_6614A0347DF667FA in level.elevators) {
      if(!isDefined(_id_6614A0347DF667FA.car)) {
        continue;
      }
      if(_id_6614A0347DF667FA.car == movingplatforment)
        return 1;
    }
  }

  return 0;
}