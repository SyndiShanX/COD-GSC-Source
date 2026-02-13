/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1994.gsc
*************************************************/

_id_4DDD(var_0) {
  if(isDefined(level._id_4E4C)) {
    return;
  }
  setDvar("#x3ea25b1382d5f2d90", 150.0);
  level._id_4E4C = [];
  level._id_4E55 = 0;
  thread _id_4DDE("dynamic_door", 0);
  thread _id_4DDE("lean_dynamic_door", 1, var_0);
  _id_CDBE();
  _id_0AA3::_id_C28D(::onplayerspawned);
}

_id_4DDE(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");
  level._id_4E55++;
  level._id_4E54 = 0;
  var_4 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip", "physicscontents_item"];
  var_5 = physics_createcontents(var_4);
  level._id_4E39 = var_5;

  foreach(var_7 in var_3) {
    if(isDefined(var_7._id_CE18)) {
      var_7 _id_4DDC(var_7._id_CE18);
    }

    var_7._id_4E4C = [];
    var_7._id_4E4C[0] = var_7;
    var_7._id_8907 = var_1;
    var_7._id_22B0 = var_7.angles;

    if(var_7._id_22B0[1] == 360) {
      var_7._id_22B0 = (var_7._id_22B0[0], 0, var_7._id_22B0[2]);
    }

    var_7._id_E747 = 0;
    var_8 = var_7.target;
    var_9 = isDefined(var_7._id_039B) && var_7._id_039B == "OPEN" || getdvarint("#x38ec2283f6f8763c7", 0) != 0;
    var_10 = isDefined(var_7._id_039B) && var_7._id_039B == "LOCKED";
    var_7._id_91A8 = 52;
    var_7.height = 96;
    var_7._id_919C = var_7.origin + anglesToForward(var_7.angles) * var_7._id_91A8 * 0.5 + anglestoright(var_7.angles) * -24.5;
    var_7._id_919B = (0, var_7._id_22B0[1] - 90.0, 0);
    var_7._id_C864 = var_7.origin + anglesToForward(var_7.angles) * var_7._id_91A8 * 0.5 + anglestoright(var_7.angles) * 24.5;
    var_7._id_C863 = (0, var_7._id_22B0[1] + 90.0, 0);
    var_7._id_4E36 = var_7.origin + anglesToForward(var_7.angles) * var_7._id_91A8 * 0.5 + anglestoup(var_7.angles) * var_7.height * 0.5;
    var_7._id_9C47 = 90;
    var_7._id_9C48 = 90;
    var_11 = var_7 gettagorigin("tag_door_handle", 1);

    if(isDefined(var_11)) {
      var_7 _id_07D6::_id_D5A6("tag_door_handle", "HINT_BUTTON", undefined, &"MP/DOOR_USE_OPEN_DOUBLE", undefined, "duration_none", undefined, 200, 90, 72, 90);
      var_7._id_FEAA = var_7;
      var_7._id_FEAA _meth_84D2(1);

      if(!var_1 && scripts\mp\utility\game::getgametype() != "br") {
        var_7._id_9705 = _id_07D6::_id_3FF0(var_11, "HINT_BUTTON", undefined, &"MP/DOOR_USE_LOCK", undefined, undefined, "show", 200, 90, 72, 90);
        var_7._id_9705 linkto(var_7, "tag_door_handle", (3, 0, 15), (0, 0, 0));
        var_7._id_9705 _meth_84D2(1);
        var_7._id_141F = [];
        var_12 = [(4, 0, 4), (4, 0, 90)];

        foreach(var_14 in var_12) {
          var_15 = _id_07D6::_id_3FF0(var_11, "HINT_BUTTON", undefined, &"MP/DOOR_USE_ALARM", undefined, undefined, "show", 100, 90, 80, 20);
          var_15 linkto(var_7, "tag_origin", var_14, (0, 0, 0));
          var_15 _meth_84D2(0);
          var_16 = var_15 getentitynumber();
          var_7._id_141F[var_16] = var_15;
        }

        var_18 = getent(var_8, "targetname");

        if(isDefined(var_18)) {
          var_7._id_39AF = var_18;
          var_7._id_39AF linkto(var_7);
          var_7._id_39AF._id_F9A7 = scripts\mp\movers::_id_F9AE;
          var_7._id_39AF _meth_8093();

          if(isDefined(var_18.target)) {
            var_19 = getent(var_18.target, "targetname");
            var_7._id_1F00 = var_19;
          }
        }
      }

      if(var_9) {
        var_7 thread _id_33E5(2);
        var_7.angles = (var_7.angles[0], var_7.angles[1] + 90.0, var_7.angles[2]);
      } else if(var_10)
        var_7 thread _id_33E5(7);
      else {
        var_7 thread _id_33E5(0);
      }
    }

    level._id_4E4C[level._id_4E4C.size] = var_7;
    waitframe();
  }

  if(!var_1) {
    level thread _id_1751();

    foreach(var_7 in level._id_4E4C) {
      var_7 thread _id_6596();
    }

    level thread _id_94FA();
  }

  level._id_4E55--;
  level._id_4E54 = level._id_4E55 == 0;
}

_id_4DDF() {
  waitframe();

  if(getdvarint("#x38ec2283f6f8763c7", 0) != 0) {
    foreach(var_1 in level._id_4E4C) {
      var_1._id_E752 = 2;
      var_1.angles = var_1._id_4E58.angles;
    }
  }
}

_id_F62B(var_0) {
  self notify("disableTrigger");
  self endon("disableTrigger");
  level endon("game_ended");

  if(!var_0._id_8907 && var_0._id_E752 == 0) {
    var_0 thread _id_233B();
  }

  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_2 = var_0._id_4E58;

    if(isDefined(var_0._id_4E59)) {
      var_3 = anglesToForward(var_0.angles);
      var_4 = _func_025B((0, 0, 1), var_3);
      var_5 = anglesToForward((0, var_1.angles[1], 0));

      if(vectordot(var_5, var_4) < 0) {
        var_2 = var_0._id_4E59;
      }
    }

    var_6 = 0.666;

    if(var_0._id_E752 == 0) {
      self notify("stop_bash_monitor");
      var_0._id_E752 = 3;
      var_0 rotateto(var_2.angles, var_6, 0.0, 0.333);
      var_7 = &"HUD/DOOR_USE_CLOSE";
    } else {
      var_0._id_E752 = 1;
      var_0 rotateto(var_0._id_22B0, var_6, 0.0, 0.333);
      var_7 = &"HUD/DOOR_USE_OPEN";
    }

    var_0 _id_07CE::_id_4E60(var_1, var_0._id_E752 == 3);
    wait 0.1;
    var_0 childthread _id_4E1B();
    wait(var_6);

    if(var_0._id_E752 == 1) {
      var_0._id_E752 = 0;

      if(!var_0._id_8907) {
        var_0 thread _id_233B();
      }
    } else
      var_0._id_E752 = 2;

    self makeuseable();
    self sethintstring(var_7);
  }
}

_id_4DDC(var_0) {
  var_1 = self;
  var_1._id_2DCE = undefined;

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
      var_1._id_AE4A[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "stop_sound":
        var_1._id_E8DB = var_5[1];
        break;
      case "interrupt_sound":
        var_1._id_8417 = var_5[1];
        break;
      case "loop_sound":
        var_1._id_9829 = var_5[1];
        break;
      case "open_interrupt":
        var_1._id_AC0B = _id_EA59(var_5[1]);
        break;
      case "start_sound":
        var_1._id_E64B = var_5[1];
        break;
      case "material":
        var_1._id_0295 = var_5[1];
        break;
    }
  }
}

_id_4E1D(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_CE18)) {
      var_3 _id_2DCD(var_3._id_CE18);
    }

    var_3 _id_4E12();
  }

  foreach(var_3 in var_1) {
    var_3 thread _id_4E20();
  }
}

_id_4E12() {
  var_0 = self;
  var_0._id_4E4C = [];
  var_0._id_7545 = 0;

  if(isDefined(var_0._id_CD8D)) {
    var_0._id_4E42 = max(0.1, float(var_0._id_CD8D) / 1000);
  }

  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(issubstr(var_3.classname, "trigger")) {
      if(!isDefined(var_0._id_F58A)) {
        var_0._id_F58A = [];
      }

      if(isDefined(var_3._id_CE18)) {
        var_3 _id_F5E6(var_3._id_CE18);
      }

      if(isDefined(var_3._id_0399)) {
        var_4 = getent(var_3._id_0399, "script_linkname");
        var_3 _meth_80DB();
        var_3 linkto(var_4);
      }

      var_0._id_F58A[var_0._id_F58A.size] = var_3;
      continue;
    }

    if(var_3.classname == "script_brushmodel" || var_3.classname == "script_model") {
      if(isDefined(var_3._id_039B) && issubstr(var_3._id_039B, "light")) {
        if(issubstr(var_3._id_039B, "light_on")) {
          if(!isDefined(var_0._id_94A3)) {
            var_0._id_94A3 = [];
          }

          var_3 hide();
          var_0._id_94A3[var_0._id_94A3.size] = var_3;
        } else if(issubstr(var_3._id_039B, "light_off")) {
          if(!isDefined(var_0._id_949F)) {
            var_0._id_949F = [];
          }

          var_3 hide();
          var_0._id_949F[var_0._id_949F.size] = var_3;
        } else {}
      } else if(var_3._id_03EA & 2) {
        if(!isDefined(var_0._id_12E3)) {
          var_0._id_12E3 = [];
        }

        var_3 notsolid();
        var_3 hide();
        var_0._id_12E3[var_0._id_12E3.size] = var_3;
      } else
        var_0._id_4E4C[var_0._id_4E4C.size] = var_3;

      continue;
    }

    if(var_3.classname == "script_origin") {
      var_0._id_5529 = var_3;
    }
  }

  if(!isDefined(var_0._id_5529) && var_0._id_4E4C.size) {
    var_0._id_5529 = _func_0204(var_0._id_4E4C, var_0.origin)[0];
  }

  foreach(var_7 in var_0._id_4E4C) {
    var_7._id_BA03 = var_7.origin;
    var_7._id_BA0F = scripts\engine\utility::getstruct(var_7.target, "targetname").origin;
    var_7._id_4BA6 = distance(var_7._id_BA0F, var_7._id_BA03);
    var_7._id_A51D = 0;

    if(!istrue(var_0._id_E5BB)) {
      var_7.origin = var_7._id_BA0F;
    }

    if(isDefined(var_7._id_CE18)) {
      var_7 _id_4E05(var_7._id_CE18);
    }
  }
}

_id_4E20() {
  var_0 = self;
  var_1 = scripts\engine\utility::ter_op(istrue(var_0._id_E5BB), 0, 2);
  var_0 _id_4E16(var_1, 1);

  for(;;) {
    var_0._id_E753 = undefined;
    var_0._id_E75A = undefined;
    var_0 scripts\engine\utility::waittill_any_2("door_state_done", "door_state_interrupted");

    if(isDefined(var_0._id_E753) && var_0._id_E753) {
      var_2 = var_0 _id_4E18(var_0._id_E752);
      var_0 _id_4E16(var_2, 0);
      continue;
    }

    if(isDefined(var_0._id_E75A) && var_0._id_E75A) {
      var_0 _id_4E16(4, 0);
      continue;
    }
  }
}

_id_4E18(var_0) {
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
    var_2 = var_1._id_E75D;
  } else {}

  return var_2;
}

_id_4E1A(var_0) {
  var_1 = self;
  var_1 endon("door_state_interrupted");
  var_1._id_E753 = undefined;

  if(var_1._id_E752 == 0 || var_1._id_E752 == 2) {
    if(!var_0) {
      foreach(var_3 in var_1._id_4E4C) {
        if(isDefined(var_3._id_E8DB)) {
          var_3 stoploopsound();
          var_3 _meth_827E(var_3._id_E8DB);
        }
      }
    }

    if(isDefined(var_1._id_94A3)) {
      foreach(var_6 in var_1._id_94A3) {
        var_6 show();
      }
    }

    foreach(var_3 in var_1._id_4E4C) {
      if(var_1._id_E752 == 0) {
        if(isDefined(var_1._id_12E3)) {
          foreach(var_10 in var_1._id_12E3) {
            var_10 show();
          }
        }

        if(var_3._id_03EA & 1) {}
      } else {
        if(isDefined(var_1._id_12E3)) {
          foreach(var_10 in var_1._id_12E3) {
            var_10 hide();
          }
        }

        if(var_3._id_03EA & 1) {
          if(isDefined(var_3._id_039B) && var_3._id_039B == "always_disconnect") {} else {}
        }
      }

      if(isDefined(var_3._id_039B)) {
        if(var_3._id_039B == "clockwise_wheel" || var_3._id_039B == "counterclockwise_wheel") {
          var_3 rotatevelocity((0, 0, 0), 0.1);
        }
      }

      if(var_3._id_A51D) {
        var_3._id_F9A7 = undefined;
      }
    }

    var_15 = !istrue(var_1._id_AABC) || !var_1._id_7545;

    if(var_15) {
      var_16 = scripts\engine\utility::ter_op(var_1._id_E752 == 0, &"HUD/DOOR_USE_OPEN", &"HUD/DOOR_USE_CLOSE");

      if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
        var_1 sethintstring(var_16);
      }

      var_1 makeuseable();
      var_1 waittill("trigger");

      if(isDefined(var_1._id_2DCE)) {
        var_1 playSound(var_1._id_2DCE);
      }

      var_1._id_7545 = 1;
    } else
      var_1 waittill("forever");
  } else if(var_1._id_E752 == 1 || var_1._id_E752 == 3) {
    if(isDefined(var_1._id_949F)) {
      foreach(var_6 in var_1._id_949F) {
        var_6 show();
      }
    }

    var_1 makeunusable();

    if(var_1._id_E752 == 1) {
      var_1 thread _id_4E19();

      foreach(var_3 in var_1._id_4E4C) {
        if(isDefined(var_3._id_039B)) {
          var_20 = scripts\engine\utility::ter_op(isDefined(var_1._id_4E42), var_1._id_4E42, 3.0);
          var_21 = scripts\engine\utility::ter_op(var_1._id_E752 == 1, var_3._id_BA03, var_3._id_BA0F);
          var_22 = distance(var_3.origin, var_21);
          var_23 = max(0.1, var_22 / var_3._id_4BA6 * var_20);
          var_24 = max(var_23 * 0.25, 0.05);
          var_25 = 360 * var_22 / 94.2;

          if(var_3._id_039B == "clockwise_wheel") {
            var_3 rotatevelocity((0, 0, -1 * var_25 / var_23), var_23, var_24, var_24);
          } else if(var_3._id_039B == "counterclockwise_wheel") {
            var_3 rotatevelocity((0, 0, var_25 / var_23), var_23, var_24, var_24);
          }
        }
      }
    } else if(var_1._id_E752 == 3) {
      if(isDefined(var_1._id_AC0B) && var_1._id_AC0B) {
        var_1 thread _id_4E19();
      }

      foreach(var_3 in var_1._id_4E4C) {
        if(isDefined(var_3._id_039B)) {
          var_20 = scripts\engine\utility::ter_op(isDefined(var_1._id_4E42), var_1._id_4E42, 3.0);
          var_21 = scripts\engine\utility::ter_op(var_1._id_E752 == 1, var_3._id_BA03, var_3._id_BA0F);
          var_22 = distance(var_3.origin, var_21);
          var_23 = max(0.1, var_22 / var_3._id_4BA6 * var_20);
          var_24 = max(var_23 * 0.25, 0.05);
          var_25 = 360 * var_22 / 94.2;

          if(var_3._id_039B == "clockwise_wheel") {
            var_3 rotatevelocity((0, 0, var_25 / var_23), var_23, var_24, var_24);
          } else if(var_3._id_039B == "counterclockwise_wheel") {
            var_3 rotatevelocity((0, 0, -1 * var_25 / var_23), var_23, var_24, var_24);
          }
        }
      }
    }

    wait 0.1;
    var_1 childthread _id_4E1B();
    var_20 = scripts\engine\utility::ter_op(isDefined(var_1._id_4E42), var_1._id_4E42, 3.0);
    var_29 = undefined;

    foreach(var_3 in var_1._id_4E4C) {
      var_21 = scripts\engine\utility::ter_op(var_1._id_E752 == 1, var_3._id_BA03, var_3._id_BA0F);

      if(var_3.origin != var_21) {
        var_23 = max(0.1, distance(var_3.origin, var_21) / var_3._id_4BA6 * var_20);
        var_24 = max(var_23 * 0.25, 0.05);
        var_3 moveto(var_21, var_23, var_24, var_24);
        var_3 scripts\mp\movers::_id_A672();

        if(var_3._id_A51D) {
          var_3._id_F9A7 = scripts\mp\movers::_id_F9AE;
        }

        if(!isDefined(var_29) || var_23 > var_29) {
          var_29 = var_23;
        }
      }
    }

    if(isDefined(var_29)) {
      wait(var_29);
    }
  } else if(var_1._id_E752 == 4) {
    foreach(var_3 in var_1._id_4E4C) {
      var_3 moveto(var_3.origin, 0.05, 0.0, 0.0);
      var_3 scripts\mp\movers::_id_A672();

      if(var_3._id_A51D) {
        var_3._id_F9A7 = undefined;
      }

      if(isDefined(var_3._id_039B)) {
        if(var_3._id_039B == "clockwise_wheel" || var_3._id_039B == "counterclockwise_wheel") {
          var_3 rotatevelocity((0, 0, 0), 0.05);
        }
      }
    }

    if(isDefined(var_1._id_949F)) {
      foreach(var_6 in var_1._id_949F) {
        var_6 show();
      }
    }

    var_1._id_5529 stoploopsound();

    foreach(var_3 in var_1._id_4E4C) {
      if(isDefined(var_3._id_8417)) {
        var_3 playSound(var_3._id_8417);
      }
    }

    wait 1.0;
  } else {}

  var_1._id_E753 = 1;

  foreach(var_3 in var_1._id_4E4C) {
    var_3._id_E753 = 1;
  }

  var_1 notify("door_state_done");
}

_id_4E1B() {
  var_0 = self;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0;

  if(var_0._id_E752 == 3 || var_0._id_E752 == 1) {
    foreach(var_5 in var_0._id_4E4C) {
      if(isDefined(var_5._id_E64B)) {
        var_5 _meth_827E(var_5._id_E64B);
        var_3 = _func_0142(var_5._id_E64B) / 1000;
        var_1 = 0;
      }
    }

    if(var_1) {
      if(!isDefined(var_0._id_5529)) {
        var_0._id_5529 = var_0;
      }

      if(var_0._id_E752 == 3) {
        if(_func_0205("scrpt_door_wood_double_open")) {
          var_3 = _func_0142("scrpt_door_wood_double_open") / 1000;
          playsoundatpos(var_0._id_5529.origin, "scrpt_door_wood_double_open");
        }
      } else if(var_0._id_E752 == 1) {
        if(_func_0205("scrpt_door_wood_double_close")) {
          var_3 = _func_0142("scrpt_door_wood_double_close") / 1000;
          playsoundatpos(var_0._id_5529.origin, "scrpt_door_wood_double_close");
        }
      }
    }
  }

  wait(var_3 * 0.3);

  if(var_0._id_E752 == 3 || var_0._id_E752 == 1) {
    foreach(var_5 in var_0._id_4E4C) {
      if(isDefined(var_5._id_9829)) {
        if(var_5._id_9829 != "none") {
          var_5 playLoopSound(var_5._id_9829);
        }

        var_2 = 0;
      }
    }

    if(var_2) {
      if(_func_0205("")) {
        var_0._id_5529 playLoopSound("");
      }
    }
  }
}

_id_4E16(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2._id_E752)) {
    _id_4E17(var_2._id_E752);
    var_2._id_E75D = var_2._id_E752;
  }

  var_2._id_E752 = var_0;
  var_2 thread _id_4E1A(var_1);
}

_id_4E17(var_0) {
  var_1 = self;

  if(var_0 == 0 || var_0 == 2) {
    if(isDefined(var_1._id_94A3)) {
      foreach(var_3 in var_1._id_94A3) {
        var_3 hide();
      }
    }
  } else if(var_0 == 1 || var_0 == 3) {
    if(isDefined(var_1._id_949F)) {
      foreach(var_3 in var_1._id_949F) {
        var_3 hide();
      }
    }

    var_1._id_5529 stoploopsound();

    foreach(var_8 in var_1._id_4E4C) {
      if(isDefined(var_8._id_9829)) {
        var_8 stoploopsound();
      }
    }
  } else {
    if(var_0 == 4) {
      return;
    }
    return;
  }
}

_id_4E19() {
  var_0 = self;
  var_0 endon("door_state_done");

  if(!isDefined(var_0._id_F58A)) {
    return;
  }
  var_1 = [];

  foreach(var_3 in var_0._id_F58A) {
    if(var_0._id_E752 == 1) {
      if(isDefined(var_3._id_A5E1) && var_3._id_A5E1 == 1) {
        continue;
      }
    } else if(var_0._id_E752 == 3) {
      if(isDefined(var_3._id_A5E3) && var_3._id_A5E3 == 1) {
        continue;
      }
    }

    var_1[var_1.size] = var_3;
  }

  if(var_1.size > 0) {
    var_5 = var_0 _id_108B3(var_1);

    if(!isDefined(var_5._id_59E0) || var_5._id_59E0 == 0) {
      var_0._id_E75A = 1;
      var_0 notify("door_state_interrupted");
    }
  }
}

_id_108B3(var_0) {
  var_1 = self;

  foreach(var_3 in var_0) {
    var_1 thread _id_C789(var_3);
  }

  var_1 waittill("interrupted");
  return var_1._id_841F;
}

_id_C789(var_0) {
  var_1 = self;
  var_1 endon("door_state_done");
  var_1 endon("interrupted");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isDefined(var_0._id_BDAA) && var_0._id_BDAA == 1) {
      if(isPlayer(var_2)) {
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

  var_1._id_841F = var_2;
  var_1 notify("interrupted");
}

_id_2DCD(var_0) {
  var_1 = self;
  var_1._id_2DCE = undefined;

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
      var_1._id_AE4A[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "open_interrupt":
        var_1._id_AC0B = _id_EA59(var_5[1]);
        break;
      case "button_sound":
        var_1._id_2DCE = var_5[1];
        break;
      case "start_closed":
        var_1._id_E5BB = _id_EA59(var_5[1]);
        break;
      case "one_time_use":
        var_1._id_AABC = _id_EA59(var_5[1]);
        break;
      default:
        break;
    }
  }
}

_id_4E05(var_0) {
  var_1 = self;
  var_1._id_E64B = undefined;
  var_1._id_E8DB = undefined;
  var_1._id_9829 = undefined;
  var_1._id_8417 = undefined;

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
      var_1._id_AE4A[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "stop_sound":
        var_1._id_E8DB = var_5[1];
        break;
      case "interrupt_sound":
        var_1._id_8417 = var_5[1];
        break;
      case "loop_sound":
        var_1._id_9829 = var_5[1];
        break;
      case "open_interrupt":
        var_1._id_AC0B = _id_EA59(var_5[1]);
        break;
      case "start_sound":
        var_1._id_E64B = var_5[1];
        break;
      case "unresolved_collision_nodes":
        var_1._id_F9AB = _func_00B3(var_5[1], "targetname");
        break;
      case "no_moving_unresolved_collisions":
        var_1._id_A51D = _id_EA59(var_5[1]);
        break;
      case "material":
        var_1._id_0295 = var_5[1];
        break;
      default:
        break;
    }
  }
}

_id_F5E6(var_0) {
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
      var_1._id_AE4A[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "not_opening":
        var_1._id_A5E3 = _id_EA59(var_5[1]);
        break;
      case "not_closing":
        var_1._id_A5E1 = _id_EA59(var_5[1]);
        break;
      case "prone_only":
        var_1._id_BDAA = _id_EA59(var_5[1]);
        break;
      default:
        break;
    }
  }
}

_id_EA59(var_0) {
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

_id_233B() {
  if(self._id_8907 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  self endon("stateChanged");
  self notify("bashMonitor");
  self endon("bashMonitor");
  thread _id_A0FF();

  for(;;) {
    self._id_4E36 = self.origin + anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var_0 = scripts\mp\utility\player::_id_6C5F(self.origin, 250);

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(_id_233E(var_2) && _id_DB06(var_2)) {
          thread _id_233C(var_2, var_2.origin);
        }
      }

      waitframe();
      continue;
    }

    wait 0.1;
  }
}

_id_233E(var_0) {
  var_1 = distancesquared(var_0.origin, self._id_4E36);
  var_2 = 4900;
  return var_1 < var_2;
}

_id_DB06(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return 0;
  }

  var_1 = anglesToForward(var_0.angles);

  if(scripts\engine\utility::_id_10E76(var_0.origin + var_1 * -45.0, var_0.angles, self._id_4E36, cos(43))) {
    var_2 = anglestoright(self.angles);
    var_3 = vectornormalize(self._id_4E36 - var_0 getEye());
    var_4 = vectordot(var_1, var_3);
    var_5 = vectordot(var_1, var_2);
    var_6 = var_0 getvelocity();
    var_7 = vectordot(vectornormalize(var_6), (0, 0, 1));

    if((length(var_6) >= 200 || var_0 scripts\mp\utility\killstreak::_id_88DF() && length(var_6) >= 140) && abs(var_7) < 0.75 && abs(var_5) > 0.75 && var_4 > 0.75) {
      var_8 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(var_8)) {
        var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_8, var_0, level._id_4E39, 0);

        if(isDefined(var_9["entity"]) && var_9["entity"] == self) {
          return 1;
        }
      } else
        return 1;
    }
  }

  return 0;
}

_id_233C(var_0, var_1) {
  thread _id_356B(var_0);
  thread _id_33E5(5);

  if(istrue(self._id_2335)) {
    return;
  }
  if(!isDefined(self._id_FEAA)) {
    self._id_2335 = 1;
  }

  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglestoright(var_3);
  var_5 = vectornormalize(var_1 - self.origin);
  var_6 = vectordot(var_4, var_5);
  var_7 = var_6 > 0;
  var_8 = undefined;

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isai(var_0)) {
      thread _id_233D(var_0);
    } else {
      self notify("ai_opened");
    }
  }

  if(isDefined(self._id_0295)) {
    if(self._id_0295 == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    } else if(self._id_0295 == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_bash");
    }
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");

  if(var_7) {
    var_8 = self._id_22B0[1] + self._id_9C47;
  } else {
    var_8 = self._id_22B0[1] - self._id_9C48;
  }

  if(var_8 > 360) {
    var_8 = var_8 - 360;
  } else if(var_8 < 0) {
    var_8 = var_8 + 360;
  }

  var_9 = 0.35;
  var_10 = 0.15;
  var_11 = scripts\engine\math::_id_A5C5(0, 170, var_8);
  var_12 = scripts\engine\math::_id_5898(var_9, var_10, var_11);
  var_13 = self.angles;
  var_14 = var_13[1];

  if(var_14 > 360) {
    var_14 = var_14 - 360;
  } else if(var_14 < 0) {
    var_14 = var_14 + 360;
  }

  var_15 = _id_1785(var_14, self._id_22B0[1]);
  var_16 = _id_1785(var_8, self._id_22B0[1]);
  var_17 = anglesToForward(var_13);
  var_18 = anglestoright(self._id_22B0);
  var_19 = vectordot(var_17, var_18) < 0.0;

  if(var_7) {
    if(!var_19) {
      var_16 = var_16 + var_15;
    } else {
      var_16 = var_16 - var_15;
    }
  } else {
    if(var_19) {
      var_16 = var_16 + var_15;
    } else {
      var_16 = var_16 - var_15;
    }

    var_16 = var_16 * -1.0;
  }

  var_20 = (0, var_16, 0);
  self _meth_82A1(var_20, var_12);
  wait(var_12);
  self._id_9033 = gettime();
  thread _id_33E5(6);

  if(!isDefined(self._id_FEAA)) {
    self._id_E752 = 2;

    if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
      self.trigger sethintstring(&"HUD/DOOR_USE_CLOSE");
    }
  }

  self._id_2335 = 0;
  var_21 = randomfloatrange(3, 5);
  var_22 = randomfloatrange(0.25, 2.5);

  if(var_7) {
    var_22 = var_22 * -1.0;
  }

  self rotateyaw(var_22, var_21, 0.5, var_21 - 0.5);
}

_id_233D(var_0) {
  var_0 playrumbleonentity("grenade_rumble");
  var_0 earthquakeforplayer(0.35, 0.5, var_0.origin, 200);
}

_id_A0FF() {
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
        if(istrue(self._id_8A0F)) {
          self._id_AC9C thread _id_233C(var_1, var_1.origin);
        }

        thread _id_233C(var_1, var_1.origin);
        continue;
      }

      if(var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE") {
        var_14 = isDefined(var_8) && isDefined(var_8.basename) && (var_8.basename == "s4_molotov_mp" || var_8.basename == "s4_thermite_mp" || var_8.basename == "thermite_ap_mp" || var_8.basename == "thermite_av_mp");

        if(var_0 > 10 && !var_14) {
          thread _id_233C(var_12, var_13);
        }

        continue;
      }

      if(isDefined(var_8) && var_8.basename == "pac_sentry_turret_mp" && (var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH")) {
        thread _id_233C(var_12, var_13);
      }
    }
  }
}

_id_AC31() {
  self endon("stateChanged");

  if(self._id_E747 == 7 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(self._id_8907 || 0 || 1) {
    if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
      self._id_FEAA sethintstring(&"HUD/DOOR_USE_OPEN");
    }
  } else if(!scripts\cp_mp\utility\game_utility::_id_89EC())
    self._id_FEAA sethintstring(&"MP/DOOR_USE_OPEN_DOUBLE");

  self._id_FEAA _meth_84D4(200);

  for(;;) {
    self._id_FEAA waittill("trigger_progress", var_0);

    if(var_0 meleebuttonpressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_1 = 0;

    while(var_1 < 0.1) {
      if(!var_0 usebuttonpressed()) {
        break;
      }

      var_1 = var_1 + level._id_5F3A;
      waitframe();
    }

    if(self._id_E747 == 7) {
      var_2 = self gettagorigin("tag_door_handle", 1);

      if(isDefined(var_2)) {
        playsoundatpos(var_2, "door_locked");
      } else {
        playsoundatpos(self.origin + (0, 0, 42), "door_locked");
      }

      continue;
    }

    if(self._id_8907) {
      thread _id_3423(var_0);
      return;
    }

    if(1 && var_0 playerads() > 0.9) {
      thread _id_13FF(var_0);
      return;
    }

    thread _id_3423(var_0);
  }
}

_id_3423(var_0) {
  thread _id_356B(var_0);
  var_1 = self._id_FEAA.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectornormalize(var_0.origin - var_1);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;

  if(isDefined(self._id_0295)) {
    if(self._id_0295 == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_open");
    } else if(self._id_0295 == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_open");
    }
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_open");

  thread _id_33E5(3);
  var_7 = scripts\engine\utility::ter_op(var_6, self._id_9C47, self._id_9C48 * -1.0);
  var_8 = (self._id_22B0[0], self._id_22B0[1] + var_7, self._id_22B0[2]);
  self rotateto(var_8, 0.666, 0.0, 0.333);

  if(isDefined(self._id_AC9C) && istrue(self._id_8A0F)) {
    var_7 = scripts\engine\utility::ter_op(!var_6, self._id_AC9C._id_9C47, self._id_AC9C._id_9C48 * -1.0);
    var_8 = (self._id_AC9C._id_22B0[0], self._id_AC9C._id_22B0[1] + var_7, self._id_AC9C._id_22B0[2]);
    self._id_AC9C rotateto(var_8, 0.666, 0.0, 0.333);
  }

  wait 0.666;
  self._id_9033 = gettime();
  thread _id_33E5(2);

  if(isDefined(self._id_AC9C) && istrue(self._id_8A0F)) {
    self._id_AC9C thread _id_33E5(2);
  }
}

_id_13FF(var_0) {
  thread _id_356B(var_0);
  thread _id_33E5(6);
  var_1 = self._id_FEAA.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectornormalize(var_0.origin - var_1);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;
  var_7 = 0.5;
  var_8 = scripts\engine\utility::ter_op(var_6, 15, -15);
  var_0 playrumbleonentity("damage_heavy");

  if(isDefined(self._id_0295)) {
    if(self._id_0295 == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_start_peek");
    } else if(self._id_0295 == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_start_peek");
    }
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_start_peek");

  self rotateyaw(var_8, var_7, var_7 * 0.25, var_7 * 0.75);

  if(isDefined(self._id_AC9C) && istrue(self._id_8A0F)) {
    self._id_AC9C thread _id_33E5(6);
    var_8 = scripts\engine\utility::ter_op(!var_6, 15, -15);
    self._id_AC9C rotateyaw(var_8, var_7, var_7 * 0.25, var_7 * 0.75);
  }

  self._id_9033 = gettime();
}

_id_BE58() {
  if(self._id_8907) {
    return;
  }
  self endon("stateChanged");
  self notify("pushMonitor");
  self endon("pushMonitor");
  wait 0.5;

  for(;;) {
    var_0 = scripts\mp\utility\player::_id_6C5F(self.origin, 250);

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(_id_BE5B(var_2)) {
          _id_BE3B(var_2);
          self._id_9033 = gettime();
          _id_4DD9();
        }
      }
    }

    if(isDefined(self._id_9033) && gettime() > self._id_9033 + 2000) {
      _id_4DD5();
    }

    waitframe();
  }
}

_id_BE5B(var_0) {
  self._id_4E36 = self.origin + anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  if(var_0.origin[2] > self.origin[2] + self.height || var_0.origin[2] + 70 < self.origin[2]) {
    return 0;
  }

  var_1 = distance2dsquared(var_0.origin, self._id_4E36);
  var_2 = 900;
  return var_1 < var_2;
}

_id_BE3B(var_0) {
  var_1 = 26;
  var_2 = 0;
  var_3 = 25;
  var_4 = self.origin + anglesToForward(self.angles) * 28;
  var_5 = distance2d(var_0.origin, var_4);
  var_6 = scripts\engine\math::_id_A5C5(var_2, var_1, var_5);
  var_7 = var_3 * (1 - var_6);

  if(var_7 == 0) {
    return;
  }
  var_8 = self._id_FEAA.origin;
  var_9 = self.angles;
  var_10 = anglestoright(var_9);
  var_11 = vectornormalize(var_0.origin - var_8);
  var_12 = vectordot(var_10, var_11);
  var_13 = var_12 > 0;
  var_14 = self.angles[1];
  var_15 = scripts\engine\utility::ter_op(var_13 == 1, 1, -1);
  var_16 = var_14 + var_7 * var_15;
  var_17 = _id_1785(var_16, self._id_22B0[1]);

  if(var_13) {
    if(var_17 > self._id_9C47) {
      self._id_4429 = "Pushed to max left yaw of " + self._id_9C47;
      self.angles = (self.angles[0], self._id_22B0[1] + self._id_9C47, self.angles[2]);
      return;
    }
  } else if(var_17 > self._id_9C48) {
    self._id_4429 = "Pushed to max right yaw of " + self._id_9C48;
    self.angles = (self.angles[0], self._id_22B0[1] - self._id_9C48, self.angles[2]);
    return;
  }

  self.angles = (self.angles[0], var_16, self.angles[2]);
}

_id_1F23() {
  if(self._id_8907) {
    return;
  }
  self endon("stateChanged");
  self notify("autoCloseMonitor");
  self endon("autoCloseMonitor");
  wait 0.5;

  for(;;) {
    if(_id_1785(self.angles[1], self._id_22B0[1]) < 40) {
      if(isDefined(self._id_9033) && gettime() > self._id_9033 + 3000) {
        var_0 = scripts\mp\utility\player::_id_6C5F(self.origin, 250);

        if(var_0.size == 0) {
          thread _id_39D8(1);
        }
      }
    }

    waitframe();
  }
}

_id_33E5(var_0) {
  if(!isDefined(self._id_FEAA)) {
    return;
  }
  switch (self._id_E747) {
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
      if(isDefined(self._id_FEAA)) {
        self._id_FEAA _meth_84DA("icon_door_unlocked");
      }

      break;
    case 8:
      break;
  }

  self._id_E747 = var_0;
  self notify("stateChanged");

  switch (var_0) {
    case 0:
      _id_4DD9();
      _id_4DDA();
      thread _id_AC31();
      thread _id_233B();
      thread _id_96FD();
      thread _id_141E();
      thread _id_1402();
      break;
    case 1:
      _id_4DD9();
      break;
    case 2:
      _id_4DD5();
      _id_4DE1();
      thread _id_39DA();
      thread _id_233B();
      break;
    case 3:
      _id_4DD9();
      _id_4DE1();
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      _id_4DE1();
      thread _id_39DA();
      thread _id_BE58();
      thread _id_233B();
      thread _id_1F23();
      break;
    case 7:
      if(isDefined(self._id_FEAA)) {
        self._id_FEAA _meth_84D4(300);
        self._id_FEAA _meth_84DA("icon_door_locked");
        self._id_FEAA sethintstring(&"MP/DOOR_USE_LOCKED");
      }

      thread _id_AC31();
      thread _id_2B6E();
      break;
    case 8:
      thread _id_AC31();
      thread _id_233B();
      thread _id_C46B();
      thread _id_4B48();
      break;
  }

  thread _id_FCB0();
  thread _id_FBF7();

  if(isDefined(self._id_AC9C)) {
    self._id_AC9C thread _id_FBF7();
  }
}

_id_FD42() {
  switch (self._id_E747) {
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

_id_39DA() {
  self endon("stateChanged");

  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    self._id_FEAA sethintstring(&"HUD/DOOR_USE_CLOSE");
  }

  self._id_FEAA _meth_84D4(200);
  self._id_FEAA sethintdisplayfov(120);
  self._id_FEAA setuserange(125);
  self._id_FEAA setusefov(120);
  self._id_FEAA makeuseable();

  for(;;) {
    self._id_FEAA waittill("trigger_progress", var_0);

    if(var_0 meleebuttonpressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_1 = 0;

    while(var_1 < 0.1) {
      if(!var_0 usebuttonpressed()) {
        break;
      }

      var_1 = var_1 + level._id_5F3A;
      waitframe();
    }

    thread _id_39D8();
  }
}

_id_39D8(var_0) {
  if(isDefined(self._id_0295)) {
    if(self._id_0295 == "metal") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_close");
    } else if(self._id_0295 == "wood") {
      playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_barn_close");
    }
  } else
    playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_close");

  thread _id_33E5(1);
  var_1 = 0.666;

  if(istrue(var_0)) {
    var_1 = var_1 * 3;
  }

  self rotateto(self._id_22B0, var_1, 0.0, 0.333);

  if(isDefined(self._id_AC9C) && istrue(self._id_8A0F)) {
    self._id_AC9C rotateto(self._id_AC9C._id_22B0, var_1, 0.0, 0.333);
  }

  wait(var_1);
  waitframe();

  if(_id_1785(self.angles[1], self._id_22B0[1]) < 1) {
    thread _id_33E5(0);
  } else {
    thread _id_33E5(6);
  }

  if(isDefined(self._id_AC9C) && istrue(self._id_8A0F)) {
    if(_id_1785(self._id_AC9C.angles[1], self._id_AC9C._id_22B0[1]) < 1) {
      self._id_AC9C thread _id_33E5(0);
    } else {
      self._id_AC9C thread _id_33E5(6);
    }
  }
}

_id_1785(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}

_id_1751() {
  level._id_4E49 = 0;
  level._id_4E5C = 0;
  var_0 = [];
  var_1 = [];
  level._id_4E5B = spawnStruct();
  level._id_4E5B._id_4E3A = level._id_4E4C.size;
  level._id_4E5B._id_F386 = 0;
  level._id_4E5B._id_F3C7 = [];
  level._id_4E5B._id_F3D3 = [];
  level._id_4E5B._id_F384 = 0;
  level._id_4E5B._id_F387 = 0;
  level._id_107E8 = 0;
  level._id_4E5D = 0;
  waitframe();
  level._id_4E5B._id_F384 = gettime();
  var_1[0] = level._id_4E5B._id_F384;

  for(;;) {
    if(level._id_4E5C == 0) {
      var_2 = gettime();
      var_1[level._id_4E49] = var_2 - var_1[level._id_4E49];
      var_0[level._id_4E49] = level._id_4E5D;
      level._id_4E5B._id_F386 = level._id_4E5B._id_F386 + level._id_4E5D;
      level._id_4E5D = 0;
      level._id_4E5B._id_F387 = level._id_4E5B._id_F387 + level._id_107E8;
      level._id_107E8 = 0;
      level._id_4E49++;
      level notify("advance_door_trace");

      if(level._id_4E49 < 3) {
        var_1[level._id_4E49] = var_2;
      } else {
        break;
      }
    }

    waitframe();
  }

  level._id_4E5B._id_F384 = gettime() - level._id_4E5B._id_F384;
  level._id_4E5B._id_F3C7 = var_0;
  level._id_4E5B._id_F3D3 = var_1;
}

_id_6596() {
  thread _id_6594(1);
  thread _id_6594(0);
}

_id_6594(var_0) {
  if(var_0) {
    if(isDefined(self._id_CDAF)) {
      self._id_9C47 = self._id_CDAF;
      return;
    }
  } else if(isDefined(self._id_CDB0)) {
    self._id_9C48 = self._id_CDB0;
    return;
  }

  var_1 = 90;
  var_2 = 10;
  var_3 = 0.0;

  while(level._id_4E49 < 3) {
    var_3 = _id_6595(var_1, var_2, var_0);

    if(var_0) {
      self._id_9C47 = var_3;
    } else {
      self._id_9C48 = var_3;
    }

    if(var_3 == 100) {
      break;
    }

    var_2 = var_2 * 0.5;
    var_1 = var_3 + var_2;
    level waittill("advance_door_trace");
  }

  var_3 = max(var_3, 90);

  if(var_0) {
    self._id_9C47 = var_3;
  } else {
    self._id_9C48 = var_3;
  }
}

_id_6595(var_0, var_1, var_2) {
  if(!isDefined(self._id_F3CF)) {
    self._id_F3CF = 0;
  }

  if(!isDefined(level._id_4E5D)) {
    level._id_4E5D = 0;
  }

  var_3 = 0;
  var_4 = 0;
  level._id_4E5C++;
  waitframe();

  while(!var_4) {
    if(var_0 > 100) {
      level._id_41C1 = undefined;
      level._id_4E5C--;
      return 100;
    }

    while(isDefined(level._id_41C1) && self != level._id_41C1) {
      waitframe();
    }

    if(!isDefined(level._id_41C1)) {
      level._id_41C1 = self;
    }

    var_5 = _id_10FE7(var_0, var_1, var_2);

    if(var_5) {
      if(var_3) {
        var_6 = 1;
      }

      var_0 = var_0 + var_1;
    } else {
      if(!var_3) {
        var_3 = 1;
      }

      var_0 = var_0 - var_1;
      var_4 = 1;
    }

    self._id_F3CF++;
    level._id_4E5D++;
    var_7 = gettime();

    if(!isDefined(level._id_4E5A) || level._id_4E5A != var_7) {
      level._id_4E5A = var_7;
      level._id_4E5E = 0;
    }

    level._id_4E5E++;

    if(level._id_4E5E == 3) {
      level._id_4E5E = 0;
      level._id_107E8++;
      waitframe();
    }
  }

  level._id_41C1 = undefined;
  level._id_4E5C--;
  return var_0;
}

_id_10FE7(var_0, var_1, var_2) {
  if(!var_2) {
    var_0 = var_0 * -1;
  }

  var_3 = self._id_22B0 + (0, var_0, 0);
  var_4 = self.origin + (0, 0, 8);
  var_5 = self.height - 16.0;
  var_6 = anglesToForward(var_3);
  var_7 = anglestoright(var_3);

  if(var_2) {
    var_7 = var_7 * -1.0;
  }

  var_8 = var_4 + var_6 * self._id_91A8 * 0.2;
  var_9 = var_4 + var_6 * (self._id_91A8 - 2.0);
  var_10 = scripts\engine\trace::_id_3219(var_8, var_9, 2.0, var_5, var_3, scripts\engine\utility::ter_op(isDefined(self._id_39A7), [self, self._id_39A7], [self]), level._id_4E39, 0);

  if(getdvarint("#x3a9ee06dbdf2be81d")) {
    var_11 = (1, 1, 1);

    if(var_10["fraction"] == 1.0) {
      var_11 = (0, 1, 0);
    } else {
      var_11 = (1, 0, 0);
    }

    thread scripts\mp\utility\debug::_id_4F43(var_8, var_9, 600, var_11);
    thread scripts\mp\utility\debug::_id_4F43(var_8 + (0, 0, var_5), var_9 + (0, 0, var_5), 600, var_11);
    thread scripts\mp\utility\debug::_id_4F43(var_8, var_8 + (0, 0, var_5), 600, var_11);
    thread scripts\mp\utility\debug::_id_4F43(var_9, var_9 + (0, 0, var_5), 600, var_11);
  }

  return var_10["fraction"] == 1.0;
}

_id_AFAF() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_4E4C) {
      if(var_1._id_E747 != 0) {
        continue;
      }
      if(isDefined(level._id_B7ED) && level._id_B7ED <= 0) {
        continue;
      }
      var_2 = scripts\mp\utility\player::_id_6C5F(var_1.origin, 128);

      if(var_2.size == 0) {
        continue;
      }
      foreach(var_4 in var_2) {
        if(var_4 scripts\mp\utility\perk::_hasperk("specialty_door_sense")) {
          _id_AFAC(var_4, var_2, var_1);
        }
      }
    }

    wait 0.1;
  }
}

_id_AFAC(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5.team != var_0.team) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size == 0) {
    return;
  }
  foreach(var_8 in var_3) {
    if(_id_AFAB(var_0, var_8, var_2)) {
      var_9 = scripts\mp\utility\outline::outlineenableforplayer(var_2, var_0, "outline_nodepth_orange", "equipment");
      thread _id_AFAE(var_9, var_2);
    }
  }
}

_id_AFAD(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5.team != var_0.team) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size == 0) {
    return;
  }
  foreach(var_8 in var_3) {
    if(_id_AFAB(var_0, var_8, var_2)) {
      var_9 = scripts\mp\utility\outline::outlineenableforplayer(var_8, var_0, "outline_nodepth_orange", "equipment");
      thread _id_AFAE(var_9, var_8);
    }
  }
}

_id_AFAB(var_0, var_1, var_2) {
  var_3 = vectornormalize(anglestoright(var_2.angles));
  var_4 = vectornormalize(var_0.origin - var_2.origin);
  var_5 = vectornormalize(var_1.origin - var_2.origin);
  var_6 = vectordot(var_3, var_4);
  var_7 = vectordot(var_3, var_5);

  if(var_6 > 0 && var_7 < 0 || var_6 < 0 && var_7 > 0) {
    return 1;
  }

  return 0;
}

_id_AFAE(var_0, var_1) {
  wait 0.2;
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

onplayerspawned() {
  var_0 = scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("#x36564d56ed53e8a3e", 0) == 1;
  _id_FBFC(self, var_0);
  var_1 = scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
  _id_FBFB(self, var_1);
}

_id_FCB0() {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(var_1 in level.players) {
    var_2 = var_1 scripts\mp\utility\perk::_hasperk("specialty_door_breach") || getdvarint("#x36564d56ed53e8a3e", 0) == 1;
    _id_FCB1(var_1, var_2);
  }
}

_id_FBFC(var_0, var_1) {
  foreach(var_3 in level._id_4E4C) {
    var_3 _id_FCB1(var_0, var_1);
  }
}

_id_FCB1(var_0, var_1) {
  if(!isDefined(self._id_9705)) {
    return;
  }
  var_2 = self._id_E747 == 0 || self._id_E747 == 7;

  if(var_2 && isDefined(self._id_AC9C)) {
    var_2 = self._id_AC9C._id_E747 == 0 || self._id_AC9C._id_E747 == 7;
  }

  if(!istrue(self._id_2B6D) && var_2) {
    if(var_1) {
      self._id_9705 showtoplayer(var_0);
      self._id_9705 _meth_80E0(var_0);
    } else {
      self._id_9705 hidefromplayer(var_0);
      self._id_9705 disableplayeruse(var_0);
    }
  } else {
    self._id_9705 hidefromplayer(var_0);
    self._id_9705 disableplayeruse(var_0);
  }
}

_id_96FD() {
  if(!isDefined(self._id_9705) || self._id_8907 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self._id_AC9C)) {
    while(self._id_AC9C._id_E747 != 0) {
      waitframe();
    }
  }

  self._id_9705 sethintstring(&"MP/DOOR_USE_LOCK");
  self._id_9705 setuseholdduration("duration_medium");
  _id_FCB0();

  for(;;) {
    self._id_9705 waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(var_0 meleebuttonpressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    thread _id_96EE();
  }
}

_id_96EE() {
  thread _id_33E5(7);

  if(isDefined(self._id_AC9C)) {
    self._id_AC9C thread _id_33E5(7);
  }
}

_id_FBF7() {
  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  while(!isDefined(level.players)) {
    waitframe();
  }

  foreach(var_1 in level.players) {
    var_2 = var_1 scripts\mp\utility\perk::_hasperk("specialty_door_alarm");
    _id_FBF6(var_1, var_2);
  }
}

_id_FBFB(var_0, var_1) {
  foreach(var_3 in level._id_4E4C) {
    var_3 _id_FBF6(var_0, var_1);
  }
}

_id_FBF6(var_0, var_1) {
  if(!isDefined(self._id_141F)) {
    return;
  }
  foreach(var_3 in self._id_141F) {
    var_4 = var_1 && self._id_E747 == 0 || self._id_E747 == 8 && isDefined(self._id_4E2D) && var_3 == self._id_4E2D;

    if(var_4 && isDefined(self._id_AC9C)) {
      var_4 = var_1 && self._id_AC9C._id_E747 == 0 || self._id_E747 == 8 && var_3 == self._id_4E2D;
    }

    if(var_4) {
      var_3 showtoplayer(var_0);
      var_3 _meth_80E0(var_0);
      continue;
    }

    var_3 hidefromplayer(var_0);
    var_3 disableplayeruse(var_0);
  }
}

_id_141E() {
  if(self._id_8907 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self._id_AC9C)) {
    while(self._id_AC9C._id_E747 != 0) {
      waitframe();
    }
  }

  foreach(var_1 in self._id_141F) {
    var_1 sethintstring(&"MP/DOOR_USE_ALARM");
    var_1 setuseholdduration("duration_medium");
  }

  _id_FBF7();

  foreach(var_1 in self._id_141F) {
    thread _id_0B25(var_1);
  }
}

_id_0B25(var_0) {
  self endon("stateChanged");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(self._id_E747 != 0) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(var_1 meleebuttonpressed()) {
      continue;
    }
    if(var_1 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    thread _id_141C(var_1, var_0);
  }
}

_id_141C(var_0, var_1) {
  var_2 = self gettagorigin("tag_door_handle");
  playsoundatpos(var_1.origin, "mp_door_alarm_on");
  self._id_4E2B = spawn("script_model", var_1.origin);
  self._id_4E2B setModel("shardball_wm");
  self._id_4E2B.angles = self.angles;
  self._id_4E2B linkto(self);
  self._id_4E2B setentityowner(var_0);
  self._id_4E2B setotherent(var_0);
  self._id_4E2B setscriptablepartstate("effects", "planted", 0);
  self._id_4E2C = var_0;
  self._id_4E2D = var_1;
  self._id_4E2C._id_141D = scripts\engine\utility::array_add(self._id_4E2C._id_141D, self);

  while(self._id_4E2C._id_141D.size > 3) {
    var_3 = self._id_4E2C._id_141D[0];
    var_3 _id_C46A(0);
  }

  thread _id_33E5(8);

  if(isDefined(self._id_AC9C)) {
    self._id_AC9C thread _id_33E5(8);
  }
}

_id_C46B() {
  if(!isDefined(self._id_4E2D) || self._id_8907 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self._id_AC9C)) {
    while(self._id_AC9C._id_E747 != 8) {
      waitframe();
    }
  }

  self._id_4E2D sethintstring(&"MP/DOOR_USE_REMOVE_ALARM");
  self._id_4E2D setuseholdduration("duration_medium");
  self._id_4E2D.owner = self._id_4E2C;
  self._id_4E2D.team = self._id_4E2C.team;
  _id_FBF7();

  for(;;) {
    self._id_4E2D waittill("trigger", var_0);

    if(self._id_E747 != 8) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(var_0 meleebuttonpressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    thread _id_C46A(1);
  }
}

_id_4B48() {
  if(!isDefined(self._id_4E2D) || self._id_8907 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  self endon("stateChanged");

  if(isDefined(self._id_AC9C)) {
    while(self._id_AC9C._id_E747 != 8) {
      waitframe();
    }
  }

  for(;;) {
    self._id_4E2C scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");

    if(self._id_E747 != 8) {
      return;
    }
    thread _id_C46A(0);
  }
}

_id_C46A(var_0) {
  if(var_0) {
    playsoundatpos(self._id_4E2B.origin, "mp_door_alarm_off");
  }

  if(isDefined(self._id_4E2C)) {
    self._id_4E2C._id_141D = scripts\engine\utility::array_remove(self._id_4E2C._id_141D, self);
  }

  self._id_4E2B delete();
  self._id_4E2C = undefined;
  self._id_4E2D = undefined;
  thread _id_33E5(0);

  if(isDefined(self._id_AC9C)) {
    self._id_AC9C thread _id_33E5(0);
  }
}

_id_356B(var_0) {
  if(self._id_E747 != 8) {
    return;
  }
  var_1 = self;

  if(!isDefined(self._id_4E2B) && isDefined(self._id_AC9C)) {
    var_1 = self._id_AC9C;
  }

  if(!isDefined(var_1._id_4E2C)) {
    return;
  }
  var_2 = var_1._id_4E2B;
  var_3 = var_1._id_4E2C;
  var_1._id_4E2C._id_141D = scripts\engine\utility::array_remove(var_1._id_4E2C._id_141D, var_1);
  var_1._id_4E2B = undefined;
  var_1._id_4E2C = undefined;
  var_1._id_4E2D = undefined;
  var_3 scripts\mp\killstreaks\killstreaks::_id_6FED();

  if(isDefined(self._id_AC9C)) {
    self._id_AC9C thread _id_33E5(0);
  }

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_3))) {
    var_2 playLoopSound("mp_door_alarm_lp");
    _func_0252(self.origin, var_0.team);
    var_2 setscriptablepartstate("effects", "triggered", 0);
    wait 4.0;
    var_2 stoploopsound();
    var_2 delete();
  } else {
    playsoundatpos(var_2.origin, "mp_door_alarm_off");
    var_2 setscriptablepartstate("effects", "neutral", 0);
    var_2 delete();
  }
}

_id_1402() {
  if(self._id_8907 || scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(!istrue(self._id_8A0F)) {
    return;
  }
  self endon("stateChanged");
  self notify("ajarMonitor");
  self endon("ajarMonitor");

  for(;;) {
    waitframe();
    waittillframeend;

    if(self._id_AC9C._id_E747 != 0) {
      thread _id_33E5(6);
    }
  }
}

_id_2B6E() {
  self endon("stateChanged");
  thread _id_A0F9();
  self._id_9705 sethintstring(&"MP/DOOR_USE_BREACH");
  self._id_9705 setuseholdduration("duration_short");
  _id_FCB0();

  if(!isDefined(self._id_AC9C)) {
    self._id_4E36 = self.origin + anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height * 0.5;
  }

  thread _id_FCAF("lockedDoor");

  for(;;) {
    self._id_9705 waittill("trigger", var_0);

    if(var_0 meleebuttonpressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(var_0 issprinting() || var_0 issprintsliding()) {
      continue;
    }
    if(var_0 _meth_81CE()) {
      continue;
    }
    if(istrue(self._id_2B6D)) {
      continue;
    }
    thread _id_2B67(var_0);
  }
}

_id_2B67(var_0) {
  thread _id_B1C6(var_0);
}

_id_A0F9() {
  self endon("stateChanged");
  self notify("monitorBreachMelee");
  self endon("monitorBreachMelee");
  self._id_96F5 = 150;
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

    if(isDefined(var_3) && !istrue(self._id_2B6D)) {
      if(var_3 == "MOD_MELEE" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE") {
        var_14 = isDefined(var_8) && isDefined(var_8.basename) && (var_8.basename == "s4_molotov_mp" || var_8.basename == "s4_thermite_mp" || var_8.basename == "thermite_ap_mp" || var_8.basename == "thermite_av_mp");

        if(var_14) {
          continue;
        }
        self._id_96F5 = self._id_96F5 - var_0;

        if(isDefined(self._id_AC9C)) {
          self._id_AC9C._id_96F5 = self._id_AC9C._id_96F5 - var_0;
        }

        if(self._id_96F5 < 1) {
          if(isDefined(self._id_AC9C) || istrue(self._id_8A0F)) {
            self._id_AC9C thread _id_FCAF("off");
            self._id_AC9C thread _id_233C(var_1, var_1.origin);
          }

          thread _id_FCAF("off");
          thread _id_233C(var_1, var_1.origin);
          continue;
        }

        playsoundatpos(self.origin + (0, 0, 42), "scrpt_door_wood_double_bash");
      }
    }
  }
}

#using_animtree("script_model");

_id_B1C6(var_0) {
  if(isDefined(self._id_AC9C) && istrue(self._id_AC9C._id_2B6D)) {
    return;
  }
  self._id_2B6D = 1;
  thread _id_FCB0();
  thread _id_10BD6(var_0);
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectornormalize(var_0.origin - self.origin);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;

  if(var_6) {
    var_7 = self._id_C864;
    var_8 = self._id_C863;
  } else {
    var_7 = self._id_919C;
    var_8 = self._id_919B;
  }

  var_0._id_9515 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0._id_9515, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_9 = scripts\engine\utility::spawn_tag_origin(var_7, var_8);
  var_0._id_9515 moveto(var_7, 0.25, 0.1, 0.1);
  var_0._id_9515 rotateto(var_8, 0.25, 0.1, 0.1);
  var_0 setstance("stand");

  if(!istrue(var_0 _id_6FA0())) {
    var_0 unlink();
    var_0._id_9515 delete();
    var_0._id_9515 = undefined;
    self._id_2B6D = 0;
    thread _id_FCB0();
    return 0;
  }

  if(istrue(self._id_3163)) {
    self._id_2B6D = 0;
    thread _id_FCB0();
    return 0;
  }

  var_0 unlink();
  var_0._id_9515 delete();
  var_0._id_9515 = undefined;
  var_0 setorigin(var_7);
  var_0 setplayerangles(var_8);
  level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "c4_plant");
  var_10 = scripts\engine\utility::ter_op(var_0.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard") {
    var_10 = scripts\engine\utility::ter_op(var_0.team == "allies", "ukp1", "abp1");
  }

  var_0 _meth_8287("dx_mpp_" + var_10 + "_breach_plant", "cop_breach_plant", 2);
  thread _id_3F5D(var_0, "planter");
  var_9 thread _id_07AA::_id_17FD(var_0, var_0._id_B5A4, "plant");
  var_11 = spawn("script_model", var_7);
  var_11 setModel("offhand_wm_c4");
  var_11._id_18AF = "c4";
  var_11 useanimtree(#animtree);
  self._id_B1CB = var_11;
  var_9 thread _id_06C6::_id_1845(var_11, "plant");
  var_12 = _func_0079(level._id_CC31["planter"]["plant"]);
  var_13 = 0.5;
  wait(var_12 - var_13);

  if(istrue(self._id_3163)) {
    self._id_2B6D = 0;
    thread _id_FCB0();
    return 0;
  }

  thread _id_261B(var_0, var_6);
  _id_6F87(var_0);
  wait(var_13);

  if(var_0 _meth_8683()) {
    var_0 _meth_8656();
  }

  var_0 thread _id_EDC3();
  _id_C436(var_0);
  return 1;
}

_id_261B(var_0, var_1) {
  var_2 = var_0.team;
  self._id_463E = 0;

  if(!isDefined(self._id_2B6C)) {
    if(!isDefined(level._id_2B6C)) {
      level._id_2B6C = 0;
    } else {
      level._id_2B6C++;
    }

    self._id_2B6C = level._id_2B6C;
  }

  _id_260A(var_2);

  if(!self._id_463E) {
    self._id_4E36 = self.origin + anglesToForward(self.angles) * self._id_91A8 * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var_3 = self._id_4E36;

    if(var_1) {
      var_4 = self._id_C863;
    } else {
      var_4 = self._id_919B;
    }

    var_5 = spawnfx(level._effect["breach_explode"], var_3, anglesToForward(var_4) * -1.0, (0, 0, 1));
    triggerfx(var_5);
    physicsexplosionsphere(var_3, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var_3);
    earthquake(0.5, 1.0, var_3, 1500);
    var_0 scripts\mp\utility\weapon::_id_0C48("flash_grenade_mp", self._id_B1CB.origin + anglesToForward(var_4) * 100.0, (0, 0, 0), 0.05, 1);
    var_0 scripts\mp\utility\weapon::_id_0C48("s4_stun_gbr_n69_mp", self._id_B1CB.origin + anglesToForward(var_4) * 100.0, (0, 0, 0), 0.05, 1);
    wait 0.1;

    if(isDefined(var_0)) {
      self._id_B1CB radiusdamage(self._id_B1CB.origin, 50, 10, 5, var_0, "MOD_EXPLOSIVE", "bomb_site_mp");
    } else {
      self._id_B1CB radiusdamage(self._id_B1CB.origin, 100, 50, 5, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    thread _id_233C(var_0, self._id_B1CB.origin);

    if(isDefined(self._id_AC9C)) {
      self._id_AC9C thread _id_233C(var_0, self._id_B1CB.origin);
    }
  }

  self._id_B1CB delete();
  self._id_B1CB = undefined;
  setomnvar("ui_ingame_timer_" + self._id_2B6C, 0);
  setomnvar("ui_ingame_timer_ent_" + self._id_2B6C, undefined);
  self._id_2B6D = 0;
  thread _id_FCB0();
  thread _id_FCAF("off");

  if(isDefined(self._id_AC9C)) {
    self._id_AC9C thread _id_FCAF("off");
  }
}

_id_260A(var_0) {
  self notify("breach_planted");
  self._id_F25D = spawn("script_model", self._id_B1CB.origin);
  var_1 = gettime();
  var_2 = int(var_1 + 1000.0);
  setomnvar("ui_ingame_timer_" + self._id_2B6C, var_2);
  setomnvar("ui_ingame_timer_ent_" + self._id_2B6C, self._id_F25D);
  var_3 = var_2 - var_1;

  while(!self._id_463E && var_3 > 0) {
    var_1 = gettime();
    var_3 = var_2 - var_1;

    if(var_3 < 1500) {
      if(var_3 <= 250) {
        self._id_B1CB playSound("breach_warning_beep_05");
      } else if(var_3 < 500) {
        self._id_B1CB playSound("breach_warning_beep_04");
      } else if(var_3 < 1500) {
        self._id_B1CB playSound("breach_warning_beep_03");
      } else {
        self._id_B1CB playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_3 < 3500) {
      self._id_B1CB playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self._id_B1CB playSound("breach_warning_beep_01");
      wait 1.0;
    }

    if(var_3 < 0) {
      break;
    }
  }
}

_id_10BD6(var_0) {
  self endon("breach_planted");
  self._id_3163 = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      if(isDefined(self._id_B1CB)) {
        self._id_B1CB delete();
        self._id_B1CB = undefined;
        self._id_B1CD = undefined;
      }

      self._id_3163 = 1;
      break;
    }

    waitframe();
  }
}

_id_CDBE() {}

_id_3F5D(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0._id_B5A4 = spawn("script_model", var_0.origin);
  var_0._id_B5A4 setModel(var_2);
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  var_0 _id_10A7E();
  _id_C436(var_0);
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 _meth_812D(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setorigin(var_1);
  } else {
    var_0 setorigin(var_0.origin + (0, 0, 100));
  }

  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
}

_id_10A7E(var_0) {
  scripts\engine\utility::waittill_any_2("remove_rig", "death_or_disconnect");
}

_id_6F87(var_0) {
  var_1 = "breach";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::_id_CC00(var_1);
}

_id_6FA0() {
  self endon("death_or_disconnect");
  var_0 = makeweapon("s4_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self._id_72C3 = var_0;
    scripts\common\utility::_id_1593(0);
    scripts\common\utility::_id_1562(0);
    scripts\common\utility::_id_1554(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::_id_5ED6();
  }

  return var_1;
}

_id_EDC3() {
  self endon("death_or_disconnect");

  if(!isDefined(self._id_72C3) || !self hasweapon(self._id_72C3)) {
    return;
  }
  self._id_EDE2 = 1;
  scripts\common\utility::_id_1593(1);

  while(self hasweapon(self._id_72C3)) {
    if(!scripts\cp_mp\utility\inventory_utility::_id_87E0(self._id_72C3)) {
      scripts\cp_mp\utility\inventory_utility::_id_0E0C(self._id_72C3);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_72C3);
      scripts\cp_mp\utility\inventory_utility::_id_5ED6();
    }

    waitframe();
  }

  self._id_EDE2 = 0;
  self._id_72C3 = undefined;
  scripts\common\utility::_id_1562(1);
  scripts\common\utility::_id_1554(1);
}

_id_FCAF(var_0) {
  if(!isDefined(self._id_96FC)) {
    return;
  }
  self notify("updateLockLight");
  self endon("updateLockLight");

  if(!_id_07D1::_id_9351("scriptables_ready")) {
    _id_07D1::_id_9356("scriptables_ready");
  }

  self._id_96FC setscriptablepartstate("marker", var_0);
}

_id_94FA() {
  foreach(var_1 in level._id_4E4C) {
    if(isDefined(var_1._id_AC9C)) {
      continue;
    }
    foreach(var_3 in level._id_4E4C) {
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
          var_1._id_8A0F = 1;
          var_3._id_8A0F = 1;
        }

        var_3._id_AC9C = var_1;
        var_1._id_AC9C = var_3;

        if(isDefined(var_1._id_9705) && isDefined(var_3._id_9705)) {
          var_3._id_9705 delete();
          var_3._id_9705 = var_1._id_9705;
          var_7 = (var_4 + var_5) * 0.5 + (0, 0, 15);
          var_1._id_9705 unlink();
          var_1._id_9705.origin = var_7;
          var_1 thread _id_33E5(var_1._id_E747);
          var_3 thread _id_33E5(var_3._id_E747);
          var_1._id_919C = (var_7[0], var_7[1], var_1.origin[2]) + anglestoright(var_1._id_22B0) * -24.5;
          var_1._id_919B = (0, var_1._id_22B0[1] - 90.0, 0);
          var_1._id_C864 = (var_7[0], var_7[1], var_1.origin[2]) + anglestoright(var_1._id_22B0) * 24.5;
          var_1._id_C863 = (0, var_1._id_22B0[1] + 90.0, 0);
          var_3._id_919C = (var_7[0], var_7[1], var_3.origin[2]) + anglestoright(var_3._id_22B0) * -24.5;
          var_3._id_919B = (0, var_3._id_22B0[1] - 90.0, 0);
          var_3._id_C864 = (var_7[0], var_7[1], var_3.origin[2]) + anglestoright(var_3._id_22B0) * 24.5;
          var_3._id_C863 = (0, var_3._id_22B0[1] + 90.0, 0);
        }
      }
    }
  }
}

_id_4DD5() {
  if(!isDefined(self._id_39AF)) {
    return;
  }
  if(isDefined(self._id_4E43)) {
    return;
  }
  self._id_4E43 = _func_02B0(self._id_39AF);
}

_id_4DD9() {
  if(!isDefined(self._id_4E43)) {
    return;
  }
  _func_02B1(self._id_4E43);
  self._id_4E43 = undefined;
}

_id_4DE1() {
  if(isDefined(self._id_1F00)) {
    self._id_1F00 _meth_8652(1);
  }
}

_id_4DDA() {
  if(isDefined(self._id_AC9C) && (self._id_AC9C._id_E747 != 0 && self._id_AC9C._id_E747 != 7 && self._id_AC9C._id_E747 != 8)) {
    return;
  }
  if(isDefined(self._id_1F00)) {
    self._id_1F00 _meth_8652(0);
  }
}

_id_4DCC() {
  return self._id_E747 == 6 || self._id_E747 == 0;
}