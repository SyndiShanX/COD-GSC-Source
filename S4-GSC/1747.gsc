/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1747.gsc
*************************************************/

init() {
  if(getDvar("#x3300a7a4fedfaa568") == "1") {
    return;
  }
  var_0 = getEntArray("elevator_group", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0.size) {
    return;
  }
  _func_01B4(&"ELEVATOR_CALL_HINT");
  _func_01B4(&"ELEVATOR_USE_HINT");
  _func_01B4(&"ELEVATOR_FLOOR_SELECT_HINT");
  thread _id_513E();
  level._id_5140 = [];
  level._id_512A = _id_5131("#x33b2857cc725cf248", "96");
  level._id_5129 = _id_5131("#x33b2845cc725ccab2", "256");
  _id_2CBC();
  _id_BA05();
  _id_5128();

  if(!level._id_5140.size) {
    return;
  }
  foreach(var_2 in level._id_5140) {
    var_2 thread _id_513D();
    var_2 thread _id_513B();
  }

  thread _id_512C();
}

_id_513E() {
  for(;;) {
    level._id_5124 = _id_5130("#x32a3d6d97489b7f98", "0.2");
    level._id_512D = _id_5130("#x32e662b0e45e81491", "0.2");
    level._id_5138 = _id_5131("#x3bf23761fd65d9c23", "1");
    level._id_513C = _id_5131("#x342a6c974a6e9480b", "96");
    level._id_5132 = _id_5131("#x39770b7eb321b697b", "14");
    level._id_5139 = _id_5131("#x39d427d7aec1090da", "16");
    level._id_513A = _id_5131("#x34f2a1caabe3161e6", "0");
    level._id_513F = _id_5131("#x3ada06bdce765f358", "6");
    level._id_5125 = _id_5131("#x3aacaa000124914e1", "0");
    level._id_512C = _id_5131("#x34d91f4c2d358aa6", "0");

    if(scripts\common\utility::issp()) {
      level._id_5135 = _id_5131("#x38db2cad400ef9bc6", "0");
    } else {
      level._id_5135 = _id_5131("#x38db2cad400ef9bc6", "1");
    }

    wait 1;
  }
}

_id_513D() {
  _id_512F("[A]");
}

_id_5128() {
  foreach(var_1 in level._id_512B) {
    var_1 thread _id_A0C0();
  }
}

_id_5D1F(var_0) {
  self endon("elevator_moving");
  self._id_5D1F = 0;
  self._id_AD5A = undefined;

  for(;;) {
    var_0 waittill("trigger", var_1);
    self._id_5D1F = 1;
    self._id_AD5A = var_1;
    break;
  }

  self notify("floor_override");
}

_id_512F(var_0) {
  self._id_5632 = var_0;
  var_1 = _id_64F1();
  var_2 = _id_64F2();

  for(;;) {
    if(self._id_5632 == "[A]") {
      if(level._id_513A && _id_6421() != _id_6514()) {
        self._id_A269 = _id_6514();
        thread _id_5D1F(var_2);
        _id_108FB("floor_override", level._id_513F);

        if(self._id_5D1F && isDefined(self._id_AD5A) && isPlayer(self._id_AD5A)) {
          _id_64AF(self._id_AD5A);
        }

        self._id_5632 = "[B]";
        continue;
      }

      for(;;) {
        if(self._id_A269 == _id_6421()) {
          var_3 = var_2 _id_4B1F("trigger");
        } else {
          var_3 = "elevator_called";
        }

        if(_func_0121(var_3) && var_3 == "elevator_called" && self._id_A269 != _id_6421()) {
          self._id_5632 = "[B]";
          break;
        }

        if(isDefined(var_3) && isPlayer(var_3) && isalive(var_3)) {
          var_4 = var_3 istouching(var_2);
          var_5 = isDefined(var_2._id_A1B3) && var_3 istouching(var_2._id_A1B3);
          var_6 = var_4 || var_5;

          if(var_6) {
            var_7 = var_3;
            _id_64AF(var_7);

            if(self._id_A269 == _id_6421()) {
              continue;
            }
            self._id_5632 = "[B]";
            break;
          }
        }
      }
    }

    if(self._id_5632 == "[B]") {
      thread _id_5133(var_1);
      var_8 = _id_6421();
      thread _id_39C4();
      thread _id_39C6(var_8);
      scripts\engine\utility::waittill_any_2("closed_inner_doors", "interrupted");

      if(self._id_5134) {
        self._id_5632 = "[C]";
        continue;
      }

      self._id_5632 = "[D]";
      continue;
    }

    if(self._id_5632 == "[C]") {
      var_8 = _id_6421();
      thread _id_AC0A();
      thread _id_AC10(var_8);
      self waittill("opened_floor_" + var_8 + "_outer_doors");

      if(self._id_5134) {
        self._id_5632 = "[B]";
        continue;
      }

      self._id_5632 = "[A]";
      continue;
    }

    if(self._id_5632 == "[D]") {
      if(self._id_A269 != _id_6421()) {
        thread _id_5136(self._id_A269);
        self waittill("elevator_moved");
      }

      self._id_5632 = "[C]";
      continue;
    }
  }
}

_id_A0C0() {
  for(;;) {
    var_0 = _id_4B1F("trigger");
    var_1 = undefined;
    var_2 = [];

    foreach(var_5, var_4 in self._id_50D0) {
      var_1 = var_5;
      var_2 = var_4;
    }

    var_6 = 0;

    foreach(var_8 in var_2) {
      var_9 = var_8 _id_512E();

      if(!level._id_5125 && !var_9) {
        if(var_8 _id_6421() == var_1) {
          var_6 = 1;
          var_2 = [];
          break;
        }
      }
    }

    foreach(var_8 in var_2) {
      if(var_8._id_5632 == "[A]") {
        var_8 _id_2F0E(var_1);
        var_6 = 1;

        if(!level._id_5125) {
          break;
        }
      }
    }

    if(var_6) {
      self playSound("elev_bell_ding");
    }
  }
}

_id_2F0E(var_0) {
  self._id_A269 = var_0;
  var_1 = _id_64F2();
  var_1 notify("trigger", "elevator_called");

  if(level._id_5135) {
    var_1._id_A1B3 notify("trigger", "elevator_called");
  }
}

_id_64AF(var_0) {
  var_1 = _id_6628();

  if(var_1.size == 2) {
    var_2 = _id_6421();
    self._id_A269 = !var_2;
    return;
  }

  var_0 setclientdvar("#x3a4c911c03e516a", _id_6421());

  for(;;) {
    var_0 waittill("menuresponse", var_3, var_4);

    if(var_3 == "elevator_floor_selector") {
      if(var_4 != "none") {
        self._id_A269 = int(var_4);
      }

      break;
    }
  }
}

_id_5133(var_0) {
  self notify("interrupt_watch");
  level notify("elevator_interior_button_pressed");
  self endon("interrupt_watch");
  self endon("elevator_moving");
  self._id_5134 = 0;
  wait 0.5;
  var_0 waittill("trigger", var_1);
  self notify("interrupted");
  self._id_5134 = 1;
}

_id_512E() {
  var_0 = _id_64F5();
  var_1 = var_0.origin;
  var_2 = 1;

  foreach(var_6, var_4 in _id_6628()) {
    var_5 = self._id_50D0["floor" + var_6 + "_pos"];

    if(var_1 == var_5) {
      self._id_50D0["current_floor"] = var_6;
      var_2 = 0;
    }
  }

  return var_2;
}

_id_513B() {
  var_0 = _id_64F7();

  if(level._id_5138 && isDefined(var_0)) {
    var_0 playLoopSound("elev_musak_loop");
  }

  thread _id_9537("closing_inner_doors");
  thread _id_9537("opening_inner_doors");
  thread _id_9537("closed_inner_doors");
  thread _id_9537("opened_inner_doors");

  foreach(var_3, var_2 in _id_6628()) {
    thread _id_9537("closing_floor_" + var_3 + "_outer_doors");
    thread _id_9537("opening_floor_" + var_3 + "_outer_doors");
    thread _id_9537("closed_floor_" + var_3 + "_outer_doors");
    thread _id_9537("opened_floor_" + var_3 + "_outer_doors");
  }

  thread _id_9537("interrupted");
  thread _id_9537("elevator_moving");
  thread _id_9537("elevator_moved");
}

_id_9537(var_0) {
  for(;;) {
    self waittill(var_0);
    var_1 = _id_64F5();

    if(issubstr(var_0, "closing_")) {
      var_1 playSound("elev_door_close");
    }

    if(issubstr(var_0, "opening_")) {
      var_1 playSound("elev_door_open");
    }

    if(var_0 == "elevator_moving") {
      var_1 playSound("elev_run_start");
      var_1 playLoopSound("elev_run_loop");
    }

    if(var_0 == "interrupted") {
      var_1 playSound("elev_door_interupt");
    }

    if(var_0 == "elevator_moved") {
      var_1 stoploopsound("elev_run_loop");
      var_1 playSound("elev_run_end");
      var_1 playSound("elev_bell_ding");
    }
  }
}

_id_BA05() {
  foreach(var_5, var_1 in level._id_5140) {
    var_1._id_A269 = var_1 _id_6421();

    foreach(var_4, var_3 in var_1 _id_6628()) {
      if(var_1 _id_6421() != var_4) {
        var_1 thread _id_39C6(var_4);
      }
    }
  }
}

_id_5136(var_0) {
  self notify("elevator_moving");
  self endon("elevator_moving");
  var_1 = _id_64F5();
  var_2 = self._id_50D0["floor" + var_0 + "_pos"] - var_1.origin;
  var_3 = level._id_513C;
  var_4 = abs(distance(self._id_50D0["floor" + var_0 + "_pos"], var_1.origin));
  var_5 = var_4 / var_3;
  var_1 moveto(var_1.origin + var_2, var_5, var_5 * level._id_5124, var_5 * level._id_512D);

  foreach(var_7 in _id_64EF()) {
    var_8 = var_7.origin + var_2;

    if(!issubstr(var_7.classname, "trigger_")) {
      var_7 moveto(var_8, var_5, var_5 * level._id_5124, var_5 * level._id_512D);
      continue;
    }

    var_7.origin = var_8;
  }

  _id_108D2(var_1, self._id_50D0["floor" + var_0 + "_pos"]);
  self notify("elevator_moved");
}

_id_39C4() {
  self notify("closing_inner_doors");
  self endon("closing_inner_doors");
  self endon("opening_inner_doors");
  var_0 = _id_64F3();
  var_1 = _id_64F9();
  var_2 = _id_64F5();
  var_3 = _id_64F0();
  var_4 = (var_3[0], var_3[1], var_2.origin[2]);
  var_5 = level._id_5132;
  var_6 = abs(distance(var_0.origin, var_4));
  var_7 = var_6 / var_5;
  var_0 moveto(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  var_1 moveto(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  _id_108D2(var_0, var_4, var_1, var_4);
  self notify("closed_inner_doors");
}

_id_AC0A() {
  self notify("opening_inner_doors");
  self endon("opening_inner_doors");
  var_0 = _id_64F3();
  var_1 = _id_64F9();
  var_2 = _id_64F5();
  var_3 = _id_64F4();
  var_4 = _id_64FA();
  var_5 = (var_3[0], var_3[1], var_2.origin[2]);
  var_6 = (var_4[0], var_4[1], var_2.origin[2]);
  var_7 = level._id_5132;
  var_8 = abs(distance(var_5, var_6) * 0.5);
  var_9 = var_8 / var_7 * 0.5;
  var_0 moveto(var_5, var_9, var_9 * 0.1, var_9 * 0.25);
  var_1 moveto(var_6, var_9, var_9 * 0.1, var_9 * 0.25);
  _id_108D2(var_0, var_5, var_1, var_6);
  self notify("opened_inner_doors");
}

_id_39C6(var_0) {
  self notify("closing_floor_" + var_0 + "_outer_doors");
  self endon("closing_floor_" + var_0 + "_outer_doors");
  self endon("opening_floor_" + var_0 + "_outer_doors");
  var_1 = _id_6629(var_0);
  var_2 = _id_662C(var_0);
  var_3 = _id_662A(var_0);
  var_4 = _id_6626(var_0);
  var_5 = level._id_5139;
  var_6 = abs(distance(var_3, var_4));
  var_7 = var_6 / var_5;
  var_1 moveto(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  var_2 moveto(var_4, var_7, var_7 * 0.1, var_7 * 0.25);
  _id_108D2(var_1, var_4, var_2, var_4);
  self notify("closed_floor_" + var_0 + "_outer_doors");
}

_id_AC10(var_0) {
  level notify("elevator_doors_opening");
  self notify("opening_floor_" + var_0 + "_outer_doors");
  self endon("opening_floor_" + var_0 + "_outer_doors");
  var_1 = _id_6629(var_0);
  var_2 = _id_662C(var_0);
  var_3 = _id_662A(var_0);
  var_4 = _id_662D(var_0);
  var_5 = _id_6626(var_0);
  var_6 = level._id_5139;
  var_7 = abs(distance(var_3, var_5));
  var_8 = var_7 / var_6 * 0.5;
  var_1 moveto(var_3, var_8, var_8 * 0.1, var_8 * 0.25);
  var_2 moveto(var_4, var_8, var_8 * 0.1, var_8 * 0.25);
  _id_108D2(var_1, var_3, var_2, var_4);
  self notify("opened_floor_" + var_0 + "_outer_doors");
}

_id_2CBC() {
  var_0 = getEntArray("elevator_group", "targetname");
  var_1 = getEntArray("elevator_housing", "targetname");
  var_2 = getEntArray("elevator_doorset", "targetname");

  foreach(var_4 in var_0) {
    var_5 = getent(var_4.target, "targetname");
    var_6 = [];
    var_6[0] = min(var_4.origin[0], var_5.origin[0]);
    var_6[1] = max(var_4.origin[0], var_5.origin[0]);
    var_6[2] = min(var_4.origin[1], var_5.origin[1]);
    var_6[3] = max(var_4.origin[1], var_5.origin[1]);
    var_7 = spawnStruct();
    var_7._id_50D0["id"] = level._id_5140.size;
    var_7._id_50D0["housing"] = [];
    var_7._id_50D0["housing"]["mainframe"] = [];

    foreach(var_9 in var_1) {
      if(var_9 _id_88B8(var_6)) {
        var_7._id_50D0["housing"]["mainframe"][var_7._id_50D0["housing"]["mainframe"].size] = var_9;

        if(var_9.classname == "script_model") {
          continue;
        }
        if(var_9._id_00EC == "light") {
          continue;
        }
        var_10 = getent(var_9.target, "targetname");
        var_7._id_50D0["housing"]["left_door"] = var_10;
        var_7._id_50D0["housing"]["left_door_opened_pos"] = var_10.origin;
        var_11 = getent(var_10.target, "targetname");
        var_7._id_50D0["housing"]["right_door"] = var_11;
        var_7._id_50D0["housing"]["right_door_opened_pos"] = var_11.origin;
        var_12 = (var_10.origin - var_11.origin) * (0.5, 0.5, 0.5) + var_11.origin;
        var_7._id_50D0["housing"]["door_closed_pos"] = var_12;
        var_13 = getent(var_11.target, "targetname");
        var_7._id_50D0["housing"]["door_trigger"] = var_13;
        var_14 = getent(var_13.target, "targetname");
        var_7._id_50D0["housing"]["inside_trigger"] = var_14;
        var_14 _id_999E();
        var_14._id_A1B3 = spawn("trigger_radius", var_9.origin, 0, 64, 128);
      }
    }

    var_7._id_50D0["outer_doorset"] = [];

    foreach(var_17 in var_2) {
      if(var_17 _id_88B8(var_6)) {
        var_18 = isDefined(var_17._id_039B) && var_17._id_039B == "closed_for_lighting";
        var_19 = var_7._id_50D0["outer_doorset"].size;
        var_7._id_50D0["outer_doorset"][var_19] = [];
        var_7._id_50D0["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
        var_20 = getent(var_17.target, "targetname");
        var_7._id_50D0["outer_doorset"][var_19]["left_door"] = var_20;
        var_7._id_50D0["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
        var_21 = getent(var_20.target, "targetname");
        var_7._id_50D0["outer_doorset"][var_19]["right_door"] = var_21;
        var_7._id_50D0["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;

        if(var_18) {
          var_22 = var_17.origin - var_20.origin;
          var_17.origin = var_20.origin;
          var_20.origin = var_20.origin + var_22;
          var_21.origin = var_21.origin - var_22;
          var_7._id_50D0["outer_doorset"][var_19]["door_closed_pos"] = var_17.origin;
          var_7._id_50D0["outer_doorset"][var_19]["left_door_opened_pos"] = var_20.origin;
          var_7._id_50D0["outer_doorset"][var_19]["right_door_opened_pos"] = var_21.origin;
        }
      }
    }

    for(var_24 = 0; var_24 < var_7._id_50D0["outer_doorset"].size - 1; var_24++) {
      for(var_25 = 0; var_25 < var_7._id_50D0["outer_doorset"].size - 1 - var_24; var_25++) {
        if(var_7._id_50D0["outer_doorset"][var_25 + 1]["door_closed_pos"][2] < var_7._id_50D0["outer_doorset"][var_25]["door_closed_pos"][2]) {
          var_26 = var_7._id_50D0["outer_doorset"][var_25]["left_door"];
          var_27 = var_7._id_50D0["outer_doorset"][var_25]["left_door_opened_pos"];
          var_28 = var_7._id_50D0["outer_doorset"][var_25]["right_door"];
          var_29 = var_7._id_50D0["outer_doorset"][var_25]["right_door_opened_pos"];
          var_30 = var_7._id_50D0["outer_doorset"][var_25]["door_closed_pos"];
          var_7._id_50D0["outer_doorset"][var_25]["left_door"] = var_7._id_50D0["outer_doorset"][var_25 + 1]["left_door"];
          var_7._id_50D0["outer_doorset"][var_25]["left_door_opened_pos"] = var_7._id_50D0["outer_doorset"][var_25 + 1]["left_door_opened_pos"];
          var_7._id_50D0["outer_doorset"][var_25]["right_door"] = var_7._id_50D0["outer_doorset"][var_25 + 1]["right_door"];
          var_7._id_50D0["outer_doorset"][var_25]["right_door_opened_pos"] = var_7._id_50D0["outer_doorset"][var_25 + 1]["right_door_opened_pos"];
          var_7._id_50D0["outer_doorset"][var_25]["door_closed_pos"] = var_7._id_50D0["outer_doorset"][var_25 + 1]["door_closed_pos"];
          var_7._id_50D0["outer_doorset"][var_25 + 1]["left_door"] = var_26;
          var_7._id_50D0["outer_doorset"][var_25 + 1]["left_door_opened_pos"] = var_27;
          var_7._id_50D0["outer_doorset"][var_25 + 1]["right_door"] = var_28;
          var_7._id_50D0["outer_doorset"][var_25 + 1]["right_door_opened_pos"] = var_29;
          var_7._id_50D0["outer_doorset"][var_25 + 1]["door_closed_pos"] = var_30;
        }
      }
    }

    var_31 = [];

    foreach(var_24, var_33 in var_7._id_50D0["outer_doorset"]) {
      var_34 = var_7 _id_64F5();
      var_31 = (var_34.origin[0], var_34.origin[1], var_33["door_closed_pos"][2]);
      var_7._id_50D0["floor" + var_24 + "_pos"] = var_31;

      if(var_34.origin == var_31) {
        var_7._id_50D0["initial_floor"] = var_24;
        var_7._id_50D0["current_floor"] = var_24;
      }
    }

    level._id_5140[level._id_5140.size] = var_7;
    var_4 delete();
    var_5 delete();
  }

  foreach(var_17 in var_2) {
    var_17 delete();
  }

  _id_2CB0();

  if(!level._id_5135) {
    _id_D7C8();
  }

  foreach(var_39 in level._id_5140) {
    var_40 = var_39 _id_64F8();

    if(isDefined(var_40) && var_40.size) {
      foreach(var_42 in var_40) {
        var_42 _meth_8338(0.75);
      }
    }
  }
}

_id_2CB0() {
  level._id_512B = getEntArray("elevator_call", "targetname");

  foreach(var_1 in level._id_512B) {
    var_1._id_50D0 = [];
    var_2 = (0, 0, var_1.origin[2]);
    var_3 = (var_1.origin[0], var_1.origin[1], 0);
    var_4 = [];

    foreach(var_12, var_6 in level._id_5140) {
      foreach(var_11, var_8 in var_6 _id_6628()) {
        var_9 = (0, 0, var_6._id_50D0["floor" + var_11 + "_pos"][2]);
        var_10 = (var_6._id_50D0["floor" + var_11 + "_pos"][0], var_6._id_50D0["floor" + var_11 + "_pos"][1], 0);

        if(abs(distance(var_2, var_9)) <= level._id_512A) {
          if(abs(distance(var_3, var_10)) <= level._id_5129) {
            var_4[var_4.size] = var_6;
            var_1._id_50D0[var_11] = var_4;
          }
        }
      }
    }

    var_1 _id_999E();
    var_1._id_A1B3 = spawn("trigger_radius", var_1.origin + (0, 0, -32), 0, 32, 64);
  }
}

_id_D7C8() {
  foreach(var_1 in level._id_5140) {
    var_2 = var_1 _id_64F2();
    var_3 = var_1 _id_6628();
    var_4 = var_3.size;
    var_2 setcursorhint("HINT_NOICON");

    if(var_4 > 2) {
      var_2 sethintstring(&"ELEVATOR_FLOOR_SELECT_HINT");
      continue;
    }

    var_2 sethintstring(&"ELEVATOR_USE_HINT");
  }

  foreach(var_7 in level._id_512B) {
    var_7 setcursorhint("HINT_NOICON");
    var_7 sethintstring(&"ELEVATOR_CALL_HINT");
  }
}

_id_999E() {
  self._id_523F = 1;
  _id_4A5F();
}

_id_4B1F(var_0) {
  _id_522F();

  if(level._id_5135) {
    self._id_A1B3 waittill(var_0, var_1);
  } else {
    self waittill(var_0, var_1);
  }

  _id_4A5F();
  return var_1;
}

_id_522F() {
  if(!self._id_523F) {
    self._id_523F = 1;
    self.origin = self.origin + (0, 0, 10000);

    if(isDefined(self._id_A1B3)) {
      self._id_A1B3.origin = self._id_A1B3.origin + (0, 0, 10000);
    }
  }
}

_id_4A5F() {
  self notify("disable_trigger");

  if(self._id_523F) {
    thread _id_4A60();
  }
}

_id_4A60() {
  self endon("disable_trigger");
  self._id_523F = 0;
  wait 1.5;
  self.origin = self.origin + (0, 0, -10000);

  if(isDefined(self._id_A1B3)) {
    self._id_A1B3.origin = self._id_A1B3.origin + (0, 0, -10000);
  }
}

_id_6627(var_0) {
  return self._id_50D0["outer_doorset"][var_0];
}

_id_6628() {
  return self._id_50D0["outer_doorset"];
}

_id_6626(var_0) {
  return self._id_50D0["outer_doorset"][var_0]["door_closed_pos"];
}

_id_6629(var_0) {
  return self._id_50D0["outer_doorset"][var_0]["left_door"];
}

_id_662C(var_0) {
  return self._id_50D0["outer_doorset"][var_0]["right_door"];
}

_id_662A(var_0) {
  return self._id_50D0["outer_doorset"][var_0]["left_door_opened_pos"];
}

_id_662D(var_0) {
  return self._id_50D0["outer_doorset"][var_0]["right_door_opened_pos"];
}

_id_64EF() {
  var_0 = [];
  var_1 = _id_64F1();
  var_2 = _id_64F2();
  var_3 = var_2._id_A1B3;
  var_4 = _id_64F3();
  var_5 = _id_64F9();
  var_0[var_0.size] = var_1;
  var_0[var_0.size] = var_2;
  var_0[var_0.size] = var_4;
  var_0[var_0.size] = var_5;

  if(isDefined(var_3)) {
    var_0[var_0.size] = var_3;
  }

  var_6 = _id_64F6();

  foreach(var_8 in var_6) {
    var_0[var_0.size] = var_8;
  }

  var_10 = _id_64F8();

  foreach(var_12 in var_10) {
    var_0[var_0.size] = var_12;
  }

  return var_0;
}

_id_64F5() {
  var_0 = self._id_50D0["housing"]["mainframe"];
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.classname != "script_model" && var_3._id_00EC != "light") {
      var_1 = var_3;
    }
  }

  return var_1;
}

_id_64F6() {
  var_0 = self._id_50D0["housing"]["mainframe"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_model") {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_64F8() {
  var_0 = self._id_50D0["housing"]["mainframe"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_00EC == "light") {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_64F7() {
  var_0 = _id_64F6();
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_039B) && var_3._id_039B == "play_musak") {
      var_1 = var_3;
    }
  }

  return var_1;
}

_id_64F1() {
  return self._id_50D0["housing"]["door_trigger"];
}

_id_64F2() {
  return self._id_50D0["housing"]["inside_trigger"];
}

_id_64F0() {
  return self._id_50D0["housing"]["door_closed_pos"];
}

_id_64F3() {
  return self._id_50D0["housing"]["left_door"];
}

_id_64F9() {
  return self._id_50D0["housing"]["right_door"];
}

_id_64F4() {
  return self._id_50D0["housing"]["left_door_opened_pos"];
}

_id_64FA() {
  return self._id_50D0["housing"]["right_door_opened_pos"];
}

_id_6421() {
  var_0 = _id_512E();
  return self._id_50D0["current_floor"];
}

_id_6514() {
  return self._id_50D0["initial_floor"];
}

_id_108D2(var_0, var_1, var_2, var_3) {
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

    wait 0.05;
  }
}

_id_88B8(var_0) {
  var_1 = self.origin[0];
  var_2 = self.origin[1];
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  return var_1 >= var_3 && var_1 <= var_4 && var_2 >= var_5 && var_2 <= var_6;
}

_id_88B9(var_0) {
  var_1 = self.origin[0];
  var_2 = self.origin[1];
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  var_7 = (var_3 + var_4) / 2;
  var_8 = (var_5 + var_6) / 2;
  var_9 = abs(distance((var_3, var_5, 0), (var_7, var_8, 0)));
  return abs(distance((var_1, var_2, 0), (var_7, var_8, 0))) < var_9;
}

_id_108FB(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_5131(var_0, var_1) {
  return int(_id_5130(var_0, var_1));
}

_id_5130(var_0, var_1) {
  if(getDvar(var_0) != "") {
    return getdvarfloat(var_0);
  } else {
    setDvar(var_0, var_1);
    return var_1;
  }
}

_id_512C() {
  if(!level._id_512C) {
    return;
  }
  for(;;) {
    if(level._id_512C != 2) {
      continue;
    }
    foreach(var_7, var_1 in level._id_5140) {
      var_2 = var_1 _id_64F5();
      var_3 = var_1 _id_64F7();

      foreach(var_6, var_5 in var_1._id_50D0["outer_doorset"]) {}
    }

    foreach(var_9 in level._id_512B) {
      foreach(var_16, var_5 in var_9._id_50D0) {
        var_11 = 0;

        foreach(var_15, var_13 in var_5) {
          var_11++;
          var_14 = var_9.origin + (0, 0, var_11 * -4);
        }
      }
    }

    wait 0.05;
  }
}