/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_elevator.gsc
****************************************/

init() {
  if(getDvar("scr_elevator_disabled") == "1") {
    return;
  }
  var_0 = getEntArray("elevator_group", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0.size) {
    return;
  }
  precachestring(&"ELEVATOR_CALL_HINT");
  precachestring(&"ELEVATOR_USE_HINT");
  precachestring(&"ELEVATOR_FLOOR_SELECT_HINT");
  precachemenu("elevator_floor_selector");
  thread _id_35CF();
  level._id_35D1 = [];
  level._id_35B8 = _id_35C0("scr_elevator_callbutton_link_v", "96");
  level._id_35B7 = _id_35C0("scr_elevator_callbutton_link_h", "256");
  _id_1D07();
  _id_758A();
  _id_35B6();

  if(!level._id_35D1.size) {
    return;
  }
  foreach(var_2 in level._id_35D1) {
    var_2 thread _id_35CE();
    var_2 thread _id_35CB();
  }

  thread _id_35BA();
}

_id_35CF() {
  for(;;) {
    level._id_35B4 = _id_35BF("scr_elevator_accel", "0.2");
    level._id_35BB = _id_35BF("scr_elevator_decel", "0.2");
    level._id_35C8 = _id_35C0("scr_elevator_music", "1");
    level._id_35CC = _id_35C0("scr_elevator_speed", "96");
    level._id_35C1 = _id_35C0("scr_elevator_innerdoorspeed", "14");
    level._id_35C9 = _id_35C0("scr_elevator_outterdoorspeed", "16");
    level._id_35CA = _id_35C0("scr_elevator_return", "0");
    level._id_35D0 = _id_35C0("scr_elevator_waittime", "6");
    level._id_35B5 = _id_35C0("scr_elevator_aggressive_call", "0");
    level._id_35BA = _id_35C0("debug_elevator", "0");

    if(common_scripts\utility::issp())
      level._id_35C6 = _id_35C0("scr_elevator_motion_detection", "0");
    else
      level._id_35C6 = _id_35C0("scr_elevator_motion_detection", "1");

    wait 1;
  }
}

_id_35CE() {
  _id_35BE("[A]");
}

_id_35B6() {
  foreach(var_1 in level._id_35B9)
  var_1 thread _id_62ED();
}

_id_3D88(var_0) {
  self endon("elevator_moving");
  self._id_3D88 = 0;
  self._id_6CC6 = undefined;

  for(;;) {
    var_0 waittill("trigger", var_1);
    self._id_3D88 = 1;
    self._id_6CC6 = var_1;
    break;
  }

  self notify("floor_override");
}

_id_35BE(var_0) {
  self._id_3876 = var_0;
  var_1 = _id_41C7();
  var_2 = _id_41C8();

  for(;;) {
    if(self._id_3876 == "[A]") {
      if(level._id_35CA && _id_4128() != _id_41DB()) {
        self._id_64D2 = _id_41DB();
        thread _id_3D88(var_2);
        _id_A752("floor_override", level._id_35D0);

        if(self._id_3D88 && isDefined(self._id_6CC6) && isPlayer(self._id_6CC6))
          _id_4199(self._id_6CC6);

        self._id_3876 = "[B]";
        continue;
      }

      for(;;) {
        if(self._id_64D2 == _id_4128())
          var_3 = var_2 _id_2FC7("trigger");
        else
          var_3 = "elevator_called";

        if(_func_031(var_3) && var_3 == "elevator_called" && self._id_64D2 != _id_4128()) {
          self._id_3876 = "[B]";
          break;
        }

        if(isDefined(var_3) && isPlayer(var_3) && isalive(var_3)) {
          var_4 = var_3 istouching(var_2);
          var_5 = isDefined(var_2._id_6464) && var_3 istouching(var_2._id_6464);
          var_6 = var_4 || var_5;

          if(var_6) {
            var_7 = var_3;
            _id_4199(var_7);

            if(self._id_64D2 == _id_4128()) {
              continue;
            }
            self._id_3876 = "[B]";
            break;
          }
        }
      }
    }

    if(self._id_3876 == "[B]") {
      thread _id_35C2(var_1);
      var_8 = _id_4128();
      thread _id_2437();
      thread _id_2439(var_8);
      common_scripts\utility::_id_A70A("closed_inner_doors", "interrupted");

      if(self._id_35C3) {
        self._id_3876 = "[C]";
        continue;
      }

      self._id_3876 = "[D]";
      continue;
    }

    if(self._id_3876 == "[C]") {
      var_8 = _id_4128();
      thread _id_6BEC();
      thread _id_6BEE(var_8);
      self waittill("opened_floor_" + var_8 + "_outer_doors");

      if(self._id_35C3) {
        self._id_3876 = "[B]";
        continue;
      }

      self._id_3876 = "[A]";
      continue;
    }

    if(self._id_3876 == "[D]") {
      if(self._id_64D2 != _id_4128()) {
        thread _id_35C7(self._id_64D2);
        self waittill("elevator_moved");
      }

      self._id_3876 = "[C]";
      continue;
    }
  }
}

_id_62ED() {
  for(;;) {
    var_0 = _id_2FC7("trigger");
    var_1 = undefined;
    var_2 = [];

    foreach(var_5, var_4 in self._id_3532) {
      var_1 = var_5;
      var_2 = var_4;
    }

    var_6 = 0;

    foreach(var_8 in var_2) {
      var_9 = var_8 _id_35BD();

      if(!level._id_35B5 && !var_9) {
        if(var_8 _id_4128() == var_1) {
          var_6 = 1;
          var_2 = [];
          break;
        }
      }
    }

    foreach(var_8 in var_2) {
      if(var_8._id_3876 == "[A]") {
        var_8 _id_1E5B(var_1);
        var_6 = 1;

        if(!level._id_35B5) {
          break;
        }
      }
    }

    if(var_6)
      self playSound("elev_bell_ding");
  }
}

_id_1E5B(var_0) {
  self._id_64D2 = var_0;
  var_1 = _id_41C8();
  var_1 notify("trigger", "elevator_called");

  if(level._id_35C6)
    var_1._id_6464 notify("trigger", "elevator_called");
}

_id_4199(var_0) {
  var_1 = _id_4271();

  if(var_1.size == 2) {
    var_2 = _id_4128();
    self._id_64D2 = !var_2;
    return;
  }

  var_0 _meth_832A("elevator_floor_selector");
  var_0 setclientdvar("player_current_floor", _id_4128());

  for(;;) {
    var_0 waittill("menuresponse", var_3, var_4);

    if(var_3 == "elevator_floor_selector") {
      if(var_4 != "none")
        self._id_64D2 = int(var_4);

      break;
    }
  }
}

_id_35C2(var_0) {
  self notify("interrupt_watch");
  level notify("elevator_interior_button_pressed");
  self endon("interrupt_watch");
  self endon("elevator_moving");
  self._id_35C3 = 0;
  wait 0.5;
  var_0 waittill("trigger", var_1);
  self notify("interrupted");
  self._id_35C3 = 1;
}

_id_35BD() {
  var_0 = _id_41CB();
  var_1 = var_0.origin;
  var_2 = 1;

  foreach(var_6, var_4 in _id_4271()) {
    var_5 = self._id_3532["floor" + var_6 + "_pos"];

    if(var_1 == var_5) {
      self._id_3532["current_floor"] = var_6;
      var_2 = 0;
    }
  }

  return var_2;
}

_id_35CB() {
  var_0 = _id_41CD();

  if(level._id_35C8 && isDefined(var_0))
    var_0 _meth_861D("elev_musak_loop");

  thread _id_5DCD("closing_inner_doors");
  thread _id_5DCD("opening_inner_doors");
  thread _id_5DCD("closed_inner_doors");
  thread _id_5DCD("opened_inner_doors");

  foreach(var_3, var_2 in _id_4271()) {
    thread _id_5DCD("closing_floor_" + var_3 + "_outer_doors");
    thread _id_5DCD("opening_floor_" + var_3 + "_outer_doors");
    thread _id_5DCD("closed_floor_" + var_3 + "_outer_doors");
    thread _id_5DCD("opened_floor_" + var_3 + "_outer_doors");
  }

  thread _id_5DCD("interrupted");
  thread _id_5DCD("elevator_moving");
  thread _id_5DCD("elevator_moved");
}

_id_5DCD(var_0) {
  for(;;) {
    self waittill(var_0);
    var_1 = _id_41CB();

    if(issubstr(var_0, "closing_"))
      var_1 playSound("elev_door_close");

    if(issubstr(var_0, "opening_"))
      var_1 playSound("elev_door_open");

    if(var_0 == "elevator_moving") {
      var_1 playSound("elev_run_start");
      var_1 _meth_861D("elev_run_loop");
    }

    if(var_0 == "interrupted")
      var_1 playSound("elev_door_interupt");

    if(var_0 == "elevator_moved") {
      var_1 _meth_8612("elev_run_loop");
      var_1 playSound("elev_run_end");
      var_1 playSound("elev_bell_ding");
    }
  }
}

_id_758A() {
  foreach(var_5, var_1 in level._id_35D1) {
    var_1._id_64D2 = var_1 _id_4128();

    foreach(var_4, var_3 in var_1 _id_4271()) {
      if(var_1 _id_4128() != var_4)
        var_1 thread _id_2439(var_4);
    }
  }
}

_id_35C7(var_0) {
  self notify("elevator_moving");
  self endon("elevator_moving");
  var_1 = _id_41CB();
  var_2 = self._id_3532["floor" + var_0 + "_pos"] - var_1.origin;
  var_3 = level._id_35CC;
  var_4 = _func_0AE(distance(self._id_3532["floor" + var_0 + "_pos"], var_1.origin));
  var_5 = var_4 / var_3;
  var_1 _meth_82B1(var_1.origin + var_2, var_5, var_5 * level._id_35B4, var_5 * level._id_35BB);

  foreach(var_7 in _id_41C5()) {
    var_8 = var_7.origin + var_2;

    if(!issubstr(var_7.classname, "trigger_")) {
      var_7 _meth_82B1(var_8, var_5, var_5 * level._id_35B4, var_5 * level._id_35BB);
      continue;
    }

    var_7.origin = var_8;
  }

  _id_A73D(var_1, self._id_3532["floor" + var_0 + "_pos"]);
  self notify("elevator_moved");
}

_id_2437() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");
  var_0 = _id_41C9();
  var_1 = _id_41CF();
  var_2 = _id_41CB();
  var_3 = _id_41C6();
  var_4 = (var_3[0], var_3[1], var_2.origin[2]);
  var_5 = level._id_35C1;
  var_6 = _func_0AE(distance(var_0.origin, var_4));
  var_7 = var_6 / var_5;
  var_0 _meth_82B1(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  var_1 _meth_82B1(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  _id_A73D(var_0, var_4, var_1, var_4);
  self notify("closed_inner_doors");
}

_id_6BEC() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");
  var_0 = _id_41C9();
  var_1 = _id_41CF();
  var_2 = _id_41CB();
  var_3 = _id_41CA();
  var_4 = _id_41D0();
  var_5 = (var_3[0], var_3[1], var_2.origin[2]);
  var_6 = (var_4[0], var_4[1], var_2.origin[2]);
  var_7 = level._id_35C1;
  var_8 = _func_0AE(distance(var_5, var_6) * 0.5);
  var_9 = var_8 / var_7 * 0.5;
  var_0 _meth_82B1(var_5, var_9, var_9 * 0.1, var_9 * 0.25);
  var_1 _meth_82B1(var_6, var_9, var_9 * 0.1, var_9 * 0.25);
  _id_A73D(var_0, var_5, var_1, var_6);
  self notify("opened_inner_doors");
}

_id_2439(var_0) {
  self notify("closing_floor_" + var_0 + "_outer_doors");
  self endon("closing_floor_" + var_0 + "_outer_doors");
  self endon("opening_floor_" + var_0 + "_outer_doors");
  var_1 = _id_4272(var_0);
  var_2 = _id_4274(var_0);
  var_3 = _id_4273(var_0);
  var_4 = _id_426F(var_0);
  var_5 = level._id_35C9;
  var_6 = _func_0AE(distance(var_3, var_4));
  var_7 = var_6 / var_5;
  var_1 _meth_82B1(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  var_2 _meth_82B1(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  _id_A73D(var_1, var_4, var_2, var_4);
  self notify("closed_floor_" + var_0 + "_outer_doors");
}

_id_6BEE(var_0) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + var_0 + "_outer_doors");
  self endon("opening_floor_" + var_0 + "_outer_doors");
  var_1 = _id_4272(var_0);
  var_2 = _id_4274(var_0);
  var_3 = _id_4273(var_0);
  var_4 = _id_4275(var_0);
  var_5 = _id_426F(var_0);
  var_6 = level._id_35C9;
  var_7 = _func_0AE(distance(var_3, var_5));
  var_8 = var_7 / var_6 * 0.5;
  var_1 _meth_82B1(var_3, var_8, var_8 * 0.1, var_8 * 0.25);
  var_2 _meth_82B1(var_4, var_8, var_8 * 0.1, var_8 * 0.25);
  _id_A73D(var_1, var_3, var_2, var_4);
  self notify("opened_floor_" + var_0 + "_outer_doors");
}

_id_1D07() {
  var_0 = getEntArray("elevator_group", "targetname");
  var_1 = getEntArray("elevator_housing", "targetname");
  var_2 = getEntArray("elevator_doorset", "targetname");

  foreach(var_4 in var_0) {
    var_5 = _func_18E(var_4.target, "targetname");
    var_6 = [];
    var_6[0] = _func_0AF(var_4.origin[0], var_5.origin[0]);
    var_6[1] = max(var_4.origin[0], var_5.origin[0]);
    var_6[2] = _func_0AF(var_4.origin[1], var_5.origin[1]);
    var_6[3] = max(var_4.origin[1], var_5.origin[1]);
    var_7 = spawnStruct();
    var_7._id_3532["id"] = level._id_35D1.size;
    var_7._id_3532["housing"] = [];
    var_7._id_3532["housing"]["mainframe"] = [];

    foreach(var_9 in var_1) {
      if(var_9 _id_5719(var_6)) {
        var_7._id_3532["housing"]["mainframe"][var_7._id_3532["housing"]["mainframe"].size] = var_9;

        if(var_9.classname == "script_model") {
          continue;
        }
        if(var_9._id_003B == "light") {
          continue;
        }
        var_10 = _func_18E(var_9.target, "targetname");
        var_7._id_3532["housing"]["left_door"] = var_10;
        var_7._id_3532["housing"]["left_door_opened_pos"] = var_10.origin;
        var_11 = _func_18E(var_10.target, "targetname");
        var_7._id_3532["housing"]["right_door"] = var_11;
        var_7._id_3532["housing"]["right_door_opened_pos"] = var_11.origin;
        var_12 = (var_10.origin - var_11.origin) * (0.5, 0.5, 0.5) + var_11.origin;
        var_7._id_3532["housing"]["door_closed_pos"] = var_12;
        var_13 = _func_18E(var_11.target, "targetname");
        var_7._id_3532["housing"]["door_trigger"] = var_13;
        var_14 = _func_18E(var_13.target, "targetname");
        var_7._id_3532["housing"]["inside_trigger"] = var_14;
        var_14 _id_5FA7();
        var_14._id_6464 = spawn("trigger_radius", var_9.origin, 0, 64, 128);
      }
    }

    var_7._id_3532["outer_doorset"] = [];

    foreach(var_17 in var_2) {
      if(var_17 _id_5719(var_6)) {
        var_18 = isDefined(var_17._id_0165) && var_17._id_0165 == "closed_for_lighting";
        var_19 = var_7._id_3532["outer_doorset"].size;
        var_7._id_3532["outer_doorset"][var_19] = [];
        var_7._id_3532["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
        var_20 = _func_18E(var_17.target, "targetname");
        var_7._id_3532["outer_doorset"][var_19]["left_door"] = var_20;
        var_7._id_3532["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
        var_21 = _func_18E(var_20.target, "targetname");
        var_7._id_3532["outer_doorset"][var_19]["right_door"] = var_21;
        var_7._id_3532["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;

        if(var_18) {
          var_22 = var_17.origin - var_20.origin;
          var_17.origin = var_20.origin;
          var_20.origin = var_20.origin + var_22;
          var_21.origin = var_21.origin - var_22;
          var_7._id_3532["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
          var_7._id_3532["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
          var_7._id_3532["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;
        }
      }
    }

    for(var_24 = 0; var_24 < var_7._id_3532["outer_doorset"].size - 1; var_24++) {
      for(var_25 = 0; var_25 < var_7._id_3532["outer_doorset"].size - 1 - var_24; var_25++) {
        if(var_7._id_3532["outer_doorset"][var_25 + 1]["door_closed_pos"][2] < var_7._id_3532["outer_doorset"][var_25]["door_closed_pos"][2]) {
          var_26 = var_7._id_3532["outer_doorset"][var_25]["left_door"];
          var_27 = var_7._id_3532["outer_doorset"][var_25]["left_door_opened_pos"];
          var_28 = var_7._id_3532["outer_doorset"][var_25]["right_door"];
          var_29 = var_7._id_3532["outer_doorset"][var_25]["right_door_opened_pos"];
          var_30 = var_7._id_3532["outer_doorset"][var_25]["door_closed_pos"];
          var_7._id_3532["outer_doorset"][var_25]["left_door"] = var_7._id_3532["outer_doorset"][var_25 + 1]["left_door"];
          var_7._id_3532["outer_doorset"][var_25]["left_door_opened_pos"] = var_7._id_3532["outer_doorset"][var_25 + 1]["left_door_opened_pos"];
          var_7._id_3532["outer_doorset"][var_25]["right_door"] = var_7._id_3532["outer_doorset"][var_25 + 1]["right_door"];
          var_7._id_3532["outer_doorset"][var_25]["right_door_opened_pos"] = var_7._id_3532["outer_doorset"][var_25 + 1]["right_door_opened_pos"];
          var_7._id_3532["outer_doorset"][var_25]["door_closed_pos"] = var_7._id_3532["outer_doorset"][var_25 + 1]["door_closed_pos"];
          var_7._id_3532["outer_doorset"][var_25 + 1]["left_door"] = var_26;
          var_7._id_3532["outer_doorset"][var_25 + 1]["left_door_opened_pos"] = var_27;
          var_7._id_3532["outer_doorset"][var_25 + 1]["right_door"] = var_28;
          var_7._id_3532["outer_doorset"][var_25 + 1]["right_door_opened_pos"] = var_29;
          var_7._id_3532["outer_doorset"][var_25 + 1]["door_closed_pos"] = var_30;
        }
      }
    }

    var_31 = [];

    foreach(var_24, var_33 in var_7._id_3532["outer_doorset"]) {
      var_34 = var_7 _id_41CB();
      var_31 = (var_34.origin[0], var_34.origin[1], var_33["door_closed_pos"][2]);
      var_7._id_3532["floor" + var_24 + "_pos"] = var_31;

      if(var_34.origin == var_31) {
        var_7._id_3532["initial_floor"] = var_24;
        var_7._id_3532["current_floor"] = var_24;
      }
    }

    level._id_35D1[level._id_35D1.size] = var_7;
    var_4 delete();
    var_5 delete();
  }

  foreach(var_17 in var_2)
  var_17 delete();

  _id_1CF9();

  if(!level._id_35C6)
    _id_8853();

  foreach(var_39 in level._id_35D1) {
    var_40 = var_39 _id_41CE();

    if(isDefined(var_40) && var_40.size) {
      foreach(var_42 in var_40)
      var_42 _meth_81DF(0.75);
    }
  }
}

_id_1CF9() {
  level._id_35B9 = getEntArray("elevator_call", "targetname");

  foreach(var_1 in level._id_35B9) {
    var_1._id_3532 = [];
    var_2 = (0, 0, var_1.origin[2]);
    var_3 = (var_1.origin[0], var_1.origin[1], 0);
    var_4 = [];

    foreach(var_12, var_6 in level._id_35D1) {
      foreach(var_11, var_8 in var_6 _id_4271()) {
        var_9 = (0, 0, var_6._id_3532["floor" + var_11 + "_pos"][2]);
        var_10 = (var_6._id_3532["floor" + var_11 + "_pos"][0], var_6._id_3532["floor" + var_11 + "_pos"][1], 0);

        if(_func_0AE(distance(var_2, var_9)) <= level._id_35B8) {
          if(_func_0AE(distance(var_3, var_10)) <= level._id_35B7) {
            var_4[var_4.size] = var_6;
            var_1._id_3532[var_11] = var_4;
          }
        }
      }
    }

    var_1 _id_5FA7();
    var_1._id_6464 = spawn("trigger_radius", var_1.origin + (0, 0, -32), 0, 32, 64);
  }
}

_id_8853() {
  foreach(var_1 in level._id_35D1) {
    var_2 = var_1 _id_41C8();
    var_3 = var_1 _id_4271();
    var_4 = var_3.size;
    var_2 _meth_80CD("HINT_NOICON");

    if(var_4 > 2) {
      var_2 _meth_80CE(&"ELEVATOR_FLOOR_SELECT_HINT");
      continue;
    }

    var_2 _meth_80CE(&"ELEVATOR_USE_HINT");
  }

  foreach(var_7 in level._id_35B9) {
    var_7 _meth_80CD("HINT_NOICON");
    var_7 _meth_80CE(&"ELEVATOR_CALL_HINT");
  }
}

_id_5FA7() {
  self._id_3655 = 1;
  _id_2F65();
}

_id_2FC7(var_0) {
  _id_364D();

  if(level._id_35C6)
    self._id_6464 waittill(var_0, var_1);
  else
    self waittill(var_0, var_1);

  _id_2F65();
  return var_1;
}

_id_364D() {
  if(!self._id_3655) {
    self._id_3655 = 1;
    self.origin = self.origin + (0, 0, 10000);

    if(isDefined(self._id_6464))
      self._id_6464.origin = self._id_6464.origin + (0, 0, 10000);
  }
}

_id_2F65() {
  self notify("disable_trigger");

  if(self._id_3655)
    thread _id_2F66();
}

_id_2F66() {
  self endon("disable_trigger");
  self._id_3655 = 0;
  wait 1.5;
  self.origin = self.origin + (0, 0, -10000);

  if(isDefined(self._id_6464))
    self._id_6464.origin = self._id_6464.origin + (0, 0, -10000);
}

_id_4270(var_0) {
  return self._id_3532["outer_doorset"][var_0];
}

_id_4271() {
  return self._id_3532["outer_doorset"];
}

_id_426F(var_0) {
  return self._id_3532["outer_doorset"][var_0]["door_closed_pos"];
}

_id_4272(var_0) {
  return self._id_3532["outer_doorset"][var_0]["left_door"];
}

_id_4274(var_0) {
  return self._id_3532["outer_doorset"][var_0]["right_door"];
}

_id_4273(var_0) {
  return self._id_3532["outer_doorset"][var_0]["left_door_opened_pos"];
}

_id_4275(var_0) {
  return self._id_3532["outer_doorset"][var_0]["right_door_opened_pos"];
}

_id_41C5() {
  var_0 = [];
  var_1 = _id_41C7();
  var_2 = _id_41C8();
  var_3 = var_2._id_6464;
  var_4 = _id_41C9();
  var_5 = _id_41CF();
  var_0[var_0.size] = var_1;
  var_0[var_0.size] = var_2;
  var_0[var_0.size] = var_4;
  var_0[var_0.size] = var_5;

  if(isDefined(var_3))
    var_0[var_0.size] = var_3;

  var_6 = _id_41CC();

  foreach(var_8 in var_6)
  var_0[var_0.size] = var_8;

  var_10 = _id_41CE();

  foreach(var_12 in var_10)
  var_0[var_0.size] = var_12;

  return var_0;
}

_id_41CB() {
  var_0 = self._id_3532["housing"]["mainframe"];
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.classname != "script_model" && var_3._id_003B != "light")
      var_1 = var_3;
  }

  return var_1;
}

_id_41CC() {
  var_0 = self._id_3532["housing"]["mainframe"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_model")
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_41CE() {
  var_0 = self._id_3532["housing"]["mainframe"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_003B == "light")
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_41CD() {
  var_0 = _id_41CC();
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_0165) && var_3._id_0165 == "play_musak")
      var_1 = var_3;
  }

  return var_1;
}

_id_41C7() {
  return self._id_3532["housing"]["door_trigger"];
}

_id_41C8() {
  return self._id_3532["housing"]["inside_trigger"];
}

_id_41C6() {
  return self._id_3532["housing"]["door_closed_pos"];
}

_id_41C9() {
  return self._id_3532["housing"]["left_door"];
}

_id_41CF() {
  return self._id_3532["housing"]["right_door"];
}

_id_41CA() {
  return self._id_3532["housing"]["left_door_opened_pos"];
}

_id_41D0() {
  return self._id_3532["housing"]["right_door_opened_pos"];
}

_id_4128() {
  var_0 = _id_35BD();
  return self._id_3532["current_floor"];
}

_id_41DB() {
  return self._id_3532["initial_floor"];
}

_id_A73D(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) && !isDefined(var_3)) {
    var_2 = var_0;
    var_3 = var_1;
  }

  for(;;) {
    var_4 = var_0.origin;
    var_5 = var_2.origin;

    if(var_4 == var_1 && var_5 == var_3) {
      break;
    }

    waitframe();
  }
}

_id_5719(var_0) {
  var_1 = self.origin[0];
  var_2 = self.origin[1];
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  return var_1 >= var_3 && var_1 <= var_4 && var_2 >= var_5 && var_2 <= var_6;
}

_id_571B(var_0) {
  var_1 = self.origin[0];
  var_2 = self.origin[1];
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  var_7 = (var_3 + var_4) / 2;
  var_8 = (var_5 + var_6) / 2;
  var_9 = _func_0AE(distance((var_3, var_5, 0), (var_7, var_8, 0)));
  return _func_0AE(distance((var_1, var_2, 0), (var_7, var_8, 0))) < var_9;
}

_id_A752(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_35C0(var_0, var_1) {
  return int(_id_35BF(var_0, var_1));
}

_id_35BF(var_0, var_1) {
  if(getDvar(var_0) != "")
    return getdvarfloat(var_0);
  else {
    setDvar(var_0, var_1);
    return var_1;
  }
}

_id_35BA() {
  if(!level._id_35BA) {
    return;
  }
  for(;;) {
    if(level._id_35BA != 2) {
      continue;
    }
    foreach(var_7, var_1 in level._id_35D1) {
      var_2 = var_1 _id_41CB();
      var_3 = var_1 _id_41CD();

      foreach(var_6, var_5 in var_1._id_3532["outer_doorset"]) {}
    }

    foreach(var_9 in level._id_35B9) {
      foreach(var_16, var_5 in var_9._id_3532) {
        var_11 = 0;

        foreach(var_15, var_13 in var_5) {
          var_11++;
          var_14 = var_9.origin + (0, 0, var_11 * -4);
        }
      }
    }

    waitframe();
  }
}