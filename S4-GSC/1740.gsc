/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1740.gsc
*************************************************/

_id_3EE9() {
  level endon("game_ended");
  _id_81D2();
  scripts\engine\utility::_id_5C11("file_opened");
}

_id_81D2() {
  var_0 = spawnStruct();
  var_0._id_F3BA = scripts\engine\trace::_id_3F70(1);
  var_0._id_1470 = [];
  var_0._id_9A9F = 1;
  level._id_AECB = var_0;
  _id_C5CF();
  return level._id_AECB;
}

_id_C5D2() {
  var_0 = _id_C5CF();
  var_0._id_10FD0 = 32;
  var_0._id_10FE4 = 32;
  var_0._id_9C45 = 20;
  var_0._id_9C46 = 20;
  level._id_AECB = var_0;
  return level._id_AECB;
}

_id_C5D1() {
  var_0 = _id_C5CF();
  var_0._id_442F = 1;
  var_0._id_A554 = 32;
  var_0._id_46B1 = 0;
  var_0._id_3F4F = 500;
  level._id_AECB = var_0;
  return level._id_AECB;
}

_id_C5D0() {
  var_0 = _id_C5CF();
  var_0._id_442F = 1;
  var_0._id_4431 = 50;
  var_0._id_4430 = 0;
  var_0._id_FF31 = 64;
  var_0._id_10FD0 = 256;
  var_0._id_10FE4 = 256;
  var_0._id_10FFD = 128;
  var_0._id_9C27 = 4096;
  var_0._id_3F4F = 5000;
  var_0._id_9C45 = undefined;
  var_0._id_9C46 = undefined;
  var_0._id_9C49 = undefined;
  level._id_AECB = var_0;
  return level._id_AECB;
}

_id_C5CF() {
  var_0 = level._id_AECB;
  var_0._id_F363 = 0;
  var_0._id_E658 = gettime();
  var_0._id_52CE = gettime();
  var_0._id_F36A = gettime();
  var_0._id_2983 = 1024;
  var_0._id_2985 = 1024;
  var_0._id_2987 = 512;
  var_0._id_2984 = 512;
  var_0._id_2986 = 512;
  var_0._id_2988 = 128;
  var_0._id_7DC7 = 1;
  var_0._id_7DCA = 1;
  var_0._id_7DCD = 1;
  var_0._id_296D = (0, 0, 0);
  var_0._id_296C = (0, 0, 0);
  var_0._id_5F5C = 0;
  var_0._id_2970 = 0;
  var_0._id_10FCF = 0;
  var_0._id_10FE3 = 0;
  var_0._id_10FFB = 0;
  var_0._id_1F1C = 1;
  var_0._id_FDC5 = getdvarint("#x31900f98cf3e1a13c", 1);
  var_0._id_442F = getdvarint("#x3e8e93d03e8d86441", 0);
  var_0._id_5100 = 1;
  var_0._id_5A30 = level.script + "_script_paths.map";
  var_0._id_A554 = 16;
  var_0._id_A553 = 0;
  var_0._id_A552 = 365;
  var_0._id_A551 = 360 / var_0._id_A554;
  var_0._id_0DFA = "waiting";
  var_0._id_3F4F = 5000;
  var_0._id_F172 = 0;
  var_0._id_F3D0 = 0;
  var_0._id_10FD0 = 256;
  var_0._id_10FE4 = 256;
  var_0._id_10FFD = 64;
  var_0._id_9C27 = 16384;
  var_0._id_FF31 = 64;
  var_0._id_4171 = undefined;
  var_0.x = 1;
  var_0.y = 1;
  var_0._id_050C = 1;
  var_0._id_9C45 = undefined;
  var_0._id_9C46 = undefined;
  var_0._id_8F7E = 1;
  var_0._id_8F7F = 1;
  var_0._id_10FCE = 0;
  var_0._id_10FE2 = 0;
  var_0._id_49C2 = 0;
  var_0._id_9C12 = 500;
  var_0._id_F36D = 5;
  var_0._id_AC77 = 0;
  var_0._id_AC7D = 8;
  var_0._id_49C4[0] = 1;
  var_0._id_49C4[1] = 1;
  var_0._id_49C4[2] = 1;
  var_0._id_49C4[3] = 1;
  var_0._id_49C4[4] = 1;
  var_0._id_49C4[5] = 1;
  var_0._id_49C4[6] = 1;
  var_0._id_49C4[7] = 1;
  var_0._id_718A = 1;
  var_0._id_109AE = 0;
  var_0._id_109AF = 32;
  var_0._id_5F12 = 0;
  var_0._id_5F14 = 0;
  var_0._id_5F16 = 0;
  var_0._id_5F11 = 0;
  var_0._id_FE14 = getdvarint("#x340fcb61d744d3553", 0);
  var_0._id_CB3B = 0;
  var_0._id_F06F = [];
  var_0._id_F070 = [];
  var_0._id_F3BB = [];
  var_0._id_F3BC = [];
  var_0._id_7189 = (0, 0, 0);
  var_0._id_47C2 = 64;
  var_0._id_47C0 = 4;
  var_0._id_47C1 = 0;
  var_0._id_5F17 = 0;
  var_0._id_3F0C = getdvarint("#x312c8be27c19889a4", 0);
  var_0._id_DA80 = 1;
  level._id_AECB = var_0;
  level._id_7DCA = var_0;
  level._id_A751 = 0;
  return level._id_AECB;
}

_id_44C4() {
  return level._id_AECB;
}

_id_C9FA(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  _id_C5D0();
  var_1 = _id_44C4();
  var_1.player = var_0;
  _id_ABF2();
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");

  for(;;) {
    var_0 waittill("use");
    var_1 thread _id_4671();
  }
}

_id_B151(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  _id_C5D1();
  var_1 = _id_44C4();
  var_1.player = var_0;
  _id_ABF2();
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");

  for(;;) {
    var_0 waittill("use");
    var_1 childthread _id_DC68();
    _id_4670();
    var_1 notify("stop_showing_message");
  }
}

_id_4671() {
  var_0 = _id_44C4();
  var_1 = var_0.player;
  _id_ABF2();
  var_0._id_E6C4 = var_1.origin;
  var_2 = anglesToForward(var_1 getplayerangles());
  var_3 = _id_3F50(var_0.player getEye(), var_0.player getEye() + var_2 * 10000);

  if(isDefined(var_3["position"]) && isDefined(var_3["fraction"]) && var_3["fraction"] < 1) {
    var_4 = scripts\engine\utility::_id_5000(var_3["position"] + -1 * (var_2 * 32), 96, -300) + (0, 0, 16);
    var_0.x = var_4[0];
    var_0.y = var_4[1];
    var_0._id_050C = var_4[2];
    var_0.origin = var_4;
    var_0._id_7189 = var_4;

    if(_id_FF3A()) {
      var_0._id_A563 = "script_struct";
      var_0._id_F363++;
      var_0.angles = (0, 0, 0);
      _id_10FBF();
      var_0.classname = "node_exposed";
      _id_3ECE();
    }
  }
}

_id_4670() {
  var_0 = _id_44C4();
  var_1 = var_0.player;
  _id_ABF2();
  var_0._id_E6C4 = var_1.origin;
  var_2 = anglesToForward(var_1 getplayerangles());
  var_3 = _id_3F50(var_0.player getEye(), var_0.player getEye() + var_2 * 10000);

  if(isDefined(var_3["position"]) && isDefined(var_3["fraction"]) && var_3["fraction"] < 1) {
    var_4 = scripts\engine\utility::_id_5000(var_3["position"] + -1 * (var_2 * 32), 24, -300) + (0, 0, 16);
    var_0.x = var_4[0];
    var_0.y = var_4[1];
    var_0._id_050C = var_4[2];
    var_0.origin = var_4;
    var_0._id_7189 = var_4;

    if(_id_FF3A()) {
      var_0.angles = (0, 0, 0);
      var_0.classname = "node_exposed";
      _id_3EEA();
    }
  }
}

_id_B153(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  var_1 = _id_44C4();
  var_1.player = var_0;
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");
  _id_C5D0();
  var_1 childthread _id_3ECC();

  for(;;) {
    var_0 waittill("use");
    var_1.x = 0;
    var_1.y = 0;
    var_1._id_050C = 0;
    var_1._id_7DC7 = 1;
    var_1._id_7DCA = 1;
    var_1._id_7DCD = 1;
    var_1._id_10FCF = 0;
    var_1._id_10FE3 = 0;
    var_1._id_10FFB = 0;
    var_1._id_9C45 = int(var_1._id_2983 / var_1._id_10FD0 / 2 + 1);
    var_1._id_9C46 = int(var_1._id_2985 / var_1._id_10FE4 / 2 + 1);
    var_1._id_9C49 = int(var_1._id_2987 / var_1._id_10FFD / 2 + 1);
    var_1._id_2970 = 1;
    _id_ABF2();
    var_1._id_E6C4 = var_1._id_296D;
    var_1 childthread _id_DC68();
    var_1._id_E658 = gettime();
    _id_3EED();
    var_1._id_52CE = gettime();
    var_1._id_F36A = (var_1._id_52CE - var_1._id_E658) / 1000;
    var_1 notify("stop_showing_message");
    var_1._id_2970 = 0;
  }
}

_id_3ECC() {
  var_0 = _id_44C4();
  var_0.player notifyonplayercommand("up", "+actionslot 1");
  var_0.player notifyonplayercommand("down", "+actionslot 2");
  var_0.player notifyonplayercommand("right", "+actionslot 4");
  var_0.player notifyonplayercommand("rb", "+frag");
  var_0.player notifyonplayercommand("lb", "+smoke");
  var_0.player notifyonplayercommand("a", "+gostand");
  var_0.player notifyonplayercommand("left", "+actionslot 3");
  var_0.player notifyonplayercommand("dpad_left_release", "-actionslot 3");
  var_0.player notifyonplayercommand("dpad_left_press", "+actionslot 3");
  var_0 childthread _id_3EDB();

  for(;;) {
    var_1 = var_0.player scripts\engine\utility::_id_10892(["up", "a", "down", "left", "rb", "lb", "right", "dpad_left_release", "dpad_left_press"]);

    if(var_0._id_2970) {
      wait 1;
      continue;
    }

    switch (var_1) {
      case "right":
        while(var_0.player _meth_805E("DPAD_RIGHT")) {
          var_0._id_2985 = var_0._id_2985 + var_0._id_10FE4;
          wait 0.1;
        }

        break;
      case "dpad_left_press":
      case "dpad_left_release":
      case "left":
        var_0._id_2985 = int(max(var_0._id_2985 - var_0._id_10FE4, var_0._id_2986));
        wait 0.1;
        break;
      case "a":
        if(var_0._id_5F5C) {
          var_0._id_5F5C = 0;
        } else {
          var_0._id_5F5C = 1;
        }

        break;
      case "up":
        while(var_0.player _meth_805E("DPAD_UP")) {
          var_0._id_2983 = var_0._id_2983 + var_0._id_10FD0;
          wait 0.1;
        }

        break;
      case "down":
        while(var_0.player _meth_805E("DPAD_DOWN")) {
          var_0._id_2983 = int(max(var_0._id_2983 - var_0._id_10FD0, var_0._id_2984));
          wait 0.1;
        }

        break;
      case "rb":
        while(var_0.player _meth_805E("BUTTON_RSHLDR")) {
          var_0._id_2987 = var_0._id_2987 + var_0._id_10FFD;
          wait 0.1;
        }

        break;
      case "lb":
        while(var_0.player _meth_805E("BUTTON_LSHLDR")) {
          var_0._id_2987 = int(max(var_0._id_2987 - var_0._id_10FFD, var_0._id_2988));
          wait 0.1;
        }

        break;
      default:
        break;
    }
  }
}

_id_DC68() {
  self endon("stop_showing_message");
  var_0 = 0;

  for(;;) {
    var_1 = 500;
    var_2 = "Creating Nodes | Time Elapsed: " + var_0;
    waitframe();
    var_0 = var_0 + 0.05;
  }
}

_id_3EDB() {
  var_0 = _id_44C4();
  var_1 = var_0.player;
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 500;
  var_3 = var_1.angles;
  var_4 = var_2;
  var_5 = var_3;

  for(;;) {
    if(var_0._id_2970) {
      wait 1;
      continue;
    }

    var_6 = 150;

    if(getdvarint("#x3f5f2d1ca5c763142", 0) != 0) {
      var_0._id_2983 = getdvarint("#x3f5f2d1ca5c763142", 0);
      var_7 = "X: " + var_0._id_2983;
    } else
      var_7 = "X: " + var_0._id_2983;

    var_6 = var_6 + 25;

    if(getdvarint("#x3f5f2d2ca5c763375", 0) != 0) {
      var_0._id_2983 = getdvarint("#x3f5f2d2ca5c763375", 0);
      var_7 = "Y: " + var_0._id_2985;
    } else
      var_7 = "Y: " + var_0._id_2985;

    var_6 = var_6 + 25;

    if(getdvarint("#x3f5f2cfca5c762cdc", 0) != 0) {
      var_0._id_2983 = getdvarint("#x3f5f2cfca5c762cdc", 0);
      var_7 = "Z: " + var_0._id_2987;
    } else
      var_7 = "Z: " + var_0._id_2987;

    var_6 = var_6 + 25;
    var_7 = "Location Locked: " + var_0._id_5F5C;
    var_6 = var_6 + 25;

    if(var_0._id_5F5C) {
      var_2 = var_4;
      var_3 = var_5;
    } else {
      var_2 = var_1.origin + anglesToForward(var_1.angles) * 500;
      var_3 = var_1.angles;
    }

    var_4 = var_2;
    var_5 = var_3;
    var_0._id_296D = var_2;
    var_0._id_296C = var_3;
    waitframe();
  }
}

_id_B154(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  var_1 = _id_44C4();
  var_1.player = var_0;
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");

  for(;;) {
    _id_C5D2();
    var_0 waittill("use");
    _id_ABF2();
    var_1._id_E6C4 = var_0.origin;
    _id_3EEB();
  }
}

_id_B152(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = _id_44C4();
  var_1.player = var_0;
  var_1._id_E6C4 = var_0.origin;
  _id_C5CF();
  _id_ABF2();
  var_1._id_0DFA = "starting";
  var_1 childthread _id_DC68();
  _id_3EEB();
  var_1 notify("stop_showing_message");
  _id_39C5();
}

_id_3835() {
  level endon("game_ended");
  level endon("stop_creating_nodes");
  var_0 = _id_44C4();
  _id_C5CF();
  _id_ABF2();
  var_0._id_0DFA = "starting";
  var_0._id_FDC5 = 0;
  var_0._id_5A30 = level.script + "_script_paths_clean.map";
  var_0 childthread _id_DC68();
  var_1 = _func_0075();
  var_2 = var_1;

  if(getdvarint("#x36bb8690f96c78e9e", 1) && isDefined(level._id_AECC) && _func_0221(level._id_AECC)) {
    var_3 = level._id_AECC;
    var_4 = 0;

    for(;;) {
      var_5 = tablelookupbyrow(var_3, var_4, 0);

      if(var_5 == "") {
        break;
      }

      var_6 = strtok(tablelookupbyrow(var_3, var_4, 2), " ");
      var_7 = (float(var_6[0]), float(var_6[1]), float(var_6[2]));
      var_8 = strtok(tablelookupbyrow(var_3, var_4, 3), " ");
      var_9 = (float(var_8[0]), float(var_8[1]), float(var_8[2]));
      var_10 = 16;
      var_11 = getdvarint("#x36428e159c6b2a18a");

      if(var_11 != 0) {
        var_10 = var_11;
      }

      var_12 = var_10 * var_10;
      var_0.origin = var_7;
      var_0.angles = var_9;
      var_13 = strtok(tablelookupbyrow(var_3, var_4, 4), " ");
      var_13 = (float(var_13[0]), float(var_13[1]), float(var_13[2]));
      var_14 = strtok(tablelookupbyrow(var_3, var_4, 5), " ");
      var_14 = (float(var_14[0]), float(var_14[1]), float(var_14[2]));
      var_0 _id_F4A6(var_13, var_14);
      var_15 = getgroundposition(var_0.origin, 1);
      var_0.origin = var_15;

      if(isDefined(var_5)) {
        if(_id_A55F()) {
          var_0.origin = var_7;
          var_0.angles = var_9;
          var_0._id_A563 = var_5;
          _id_10FBF();
        }
      }

      var_4++;
    }
  } else {
    var_16 = 0;

    while(var_2.size > 1) {
      var_17 = var_2[0];
      var_2 = scripts\engine\utility::array_remove_index(var_2, 0, 0);
      var_15 = getgroundposition(var_17.origin, 16);
      var_0.origin = var_15;
      var_0.angles = var_17.angles;

      if(_id_A55F(1)) {
        if(isDefined(var_17.type)) {
          switch (var_17.type) {
            case "Cover Left":
              var_0._id_A563 = "node_cover_left";
              _id_10FBF();
              break;
            case "Cover Right":
              var_0._id_A563 = "node_cover_right";
              _id_10FBF();
              break;
            case "Cover Crouch":
              var_0._id_A563 = "node_cover_crouch";
              _id_10FBF();
              break;
            case "Exposed":
              var_0._id_A563 = "node_exposed";
              _id_10FBF();
              break;
            case "Exposed Crouch":
              var_0._id_A563 = "exposed_crouch";
              _id_10FBF();
              break;
            case "Cover Crouch Window":
              var_0._id_A563 = "node_cover_crouch_window";
              _id_10FBF();
              break;
            default:
              break;
          }
        }

        var_18 = [];
        var_19 = _func_00B4(var_0.origin, 16, 0, 32);
        var_2 = scripts\engine\utility::_id_1BBF(var_2, var_19);
      }

      var_16++;

      if(var_16 % 100) {
        waitframe();
      }
    }
  }

  var_0 notify("stop_showing_message");
  _id_39C5();
  _id_C5CF();
}

_id_F4A6(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = (0, 0, 0);
  }

  if(isDefined(self.angles)) {
    var_3 = self.angles;
  } else {
    var_3 = (0, 0, 0);
  }

  var_4 = self.origin;
  var_5 = anglesToForward(var_3);
  self.origin = var_0 + rotatevector(var_4, var_2);
  var_6 = vectortoangles(rotatevector(var_5, var_2));
  self.angles = var_6;
}

_id_A55F(var_0) {
  var_1 = _id_44C4();

  if(distancesquared(_func_02AB(var_1.origin), var_1.origin) >= 1024) {
    return 0;
  } else if(!_id_30FA(var_1.origin)) {
    return 0;
  } else if(!istrue(var_0)) {
    var_2 = _func_00B4(var_1.origin, 16, 0, 64);

    if(var_2.size < 1) {
      return 1;
      return;
    }

    return 0;
    return;
  } else
    return 1;
}

_id_C449(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  var_1 = 100;
  var_2 = getdvarint("#x36428e159c6b2a18a");

  if(var_2 != 0) {
    var_1 = var_2;
  }

  var_3 = var_1 * var_1;
  var_4 = _id_44C4();
  var_4.player = var_0;
  _id_C5CF();
  _id_ABF2();
  var_4._id_0DFA = "starting";
  var_5 = _func_0075();

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];

    if(isDefined(var_7)) {
      var_8 = 0;

      for(var_9 = 0; var_9 < var_5.size; var_9++) {
        var_10 = var_5[var_9];

        if(!isDefined(var_10)) {
          continue;
        }
        if(var_10.origin == var_7.origin) {
          continue;
        }
        var_11 = var_7.origin;
        var_12 = distancesquared(var_11, var_10.origin);

        if(var_12 <= var_3) {
          if(var_7.type == var_10.type) {
            if(var_7.angles == var_10.angles) {
              var_8 = 1;
              break;
            }
          }
        }
      }

      if(!var_8) {
        var_4._id_A563 = _id_65ED(var_7);

        if(isDefined(var_4._id_A563)) {
          var_4.origin = var_7.origin;
          var_4.angles = var_7.angles;
          _id_10FBF();
        } else
          var_5[var_6] = undefined;
      } else
        var_5[var_6] = undefined;
    }
  }

  level thread _id_39C5();
}

_id_DD48() {
  var_0 = _id_44C4();
  var_1 = 100;
  var_2 = var_1 * var_1;

  if(var_0._id_FDC5) {
    var_3 = _func_0075();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4];

      if(isDefined(var_5)) {
        if(var_0.origin == var_5.origin) {
          return 0;
        }

        var_6 = distancesquared(var_5.origin, var_0.origin);

        if(var_6 <= var_2) {
          if(var_5.angles == var_0.angles) {
            return 0;
          }
        }
      }
    }
  }

  var_3 = level._id_AECB._id_1470;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5)) {
      if(var_0.origin == var_5.origin) {
        return 0;
      }

      var_6 = distancesquared(var_0.origin, var_5.origin);

      if(var_6 <= var_2) {
        if(var_5.angles == var_0.angles) {
          return 0;
        }
      }
    }
  }

  return 1;
}

_id_65ED(var_0) {
  switch (var_0.type) {
    case "Cover Crouch":
      return "node_cover_crouch";
    case "Cover Left":
      return "node_cover_left";
    case "Cover Right":
      return "node_cover_right";
    case "Cover Stand":
      return "node_cover_stand";
    case "Cover Exposed":
      return "node_exposed";
  }

  return undefined;
}

_id_66F1() {
  return "raw";
}

_id_64C0() {
  return "cp";
}

_id_39C5() {
  var_0 = _id_44C4();

  if(scripts\engine\utility::_id_5C00("file_opened")) {
    scripts\engine\utility::_id_5C04("file_opened");
    var_1 = var_0._id_5A30;
    var_2 = _id_66F1();
    var_3 = _id_64C0();
    var_4 = "/map_source/" + var_1;
    var_5 = 1;
    scripts\engine\utility::_id_5A32(var_4, var_5);
    level notify("stop_creating_nodes");
  }

  if(getdvarint("#x340fcb61d744d3553", 0)) {
    level thread _id_446A(var_0._id_1470);
  }
}

_id_3EED() {
  level endon("game_ended");
  var_0 = _id_44C4();
  var_0._id_0DFA = "creating_cover_node_positions";
  var_0._id_718A = 1;
  var_0._id_7DCA = 1;

  while(var_0._id_718A) {
    var_0._id_A751 = 0;

    for(var_1 = 0; var_1 < var_0._id_AC7D; var_1++) {
      var_0._id_AC77 = var_1;
      _id_65E7();

      if(_id_106A0()) {
        var_0.angles = (0, 0, 0);
        var_0._id_A563 = "script_struct";
        var_0.origin = var_0._id_7189;
        var_0.classname = "node_exposed";
        _id_1069C();
      }
    }

    _id_3F21();
  }

  iprintlnbold("Create Node Completed " + var_0._id_1470.size + " Created.");
}

_id_1069C() {
  var_0 = _id_44C4();
  var_0._id_DA80 = 1;

  for(var_1 = 0; var_1 <= var_0._id_A554; var_1++) {
    var_0._id_A553 = var_1;
    _id_1069B();
  }

  if(istrue(var_0._id_3F0C) && istrue(var_0._id_DA80)) {
    var_2 = scripts\engine\utility::_id_5000(var_0._id_7189, 16, -300) + (0, 0, 16);
    var_0.origin = var_2;

    if(_id_30FA(var_2) && !_id_F3BD()) {
      var_0.angles = (0, 0, 0);

      if(!_id_DD48()) {
        return;
      }
      var_0._id_A563 = "node_exposed";
      _id_C9EC();
    }
  }
}

_id_3EEB() {
  level endon("game_ended");
  level endon("end_grid_creation");
  var_0 = _id_44C4();
  var_0._id_0DFA = "creating_cover_node_positions";
  var_0._id_718A = 1;
  var_0._id_7DCA = 1;

  while(var_0._id_718A) {
    var_0._id_A751 = 0;
    _id_3F20();

    for(var_1 = 0; var_1 < var_0._id_AC7D; var_1++) {
      var_0._id_AC77 = var_1;

      for(var_2 = 0; var_2 < var_0._id_F36D; var_2++) {
        var_0._id_050C = var_2;
        _id_65E2();

        if(_id_FF3A()) {
          var_0.angles = (0, 0, 0);
          var_0.classname = "node_exposed";
          _id_3EEA();
        }
      }
    }
  }

  iprintlnbold("Create Node Completed " + var_0._id_1470.size + " Created.");
}

_id_3F21() {
  var_0 = _id_44C4();

  if(var_0._id_7DC7) {
    _id_1069D();
  } else if(var_0._id_7DCA) {
    var_0._id_7DC7 = 1;
    var_0.x = 0;
    _id_1069E();
  } else {
    var_0._id_7DC7 = 1;
    var_0._id_7DCA = 1;
    var_0.x = 0;
    var_0.y = 0;
    _id_1069F();
  }

  if(var_0._id_10FCF && var_0._id_10FE3 && var_0._id_10FFB) {
    var_0._id_718A = 0;
    level notify("end_grid_creation");
  }
}

_id_3F20() {
  var_0 = _id_44C4();
  var_1 = 0;

  if(!_id_7DCB()) {
    var_1++;

    if(_id_7DC8()) {
      var_0.y = 1;
    } else {
      var_1++;
    }
  }

  if(var_1 >= 2) {
    var_0._id_718A = 0;
    level notify("end_grid_creation");
  }
}

_id_3F22() {
  var_0 = _id_44C4();

  if(var_0._id_49C2 >= var_0._id_9C12) {
    var_0._id_718A = 0;
    level notify("end_grid_creation");
  } else {
    var_1 = 0;

    if(isDefined(var_0._id_9C46)) {
      if(var_0.y > var_0._id_9C46) {
        var_1++;
      }
    }

    if(isDefined(var_0._id_9C45)) {
      if(var_0.x > var_0._id_9C45) {
        var_1++;
      }
    }

    if(var_1 >= 2) {
      var_0._id_718A = 0;
      level notify("end_grid_creation");
      return;
    }

    if(var_0._id_7DCA) {
      _id_7DCC();
      var_0._id_7DCA = 0;
      return;
    }

    _id_7DC9();
    var_0._id_7DCA = 1;
  }
}

_id_7DCC() {
  var_0 = _id_44C4();

  if(isDefined(var_0._id_9C46)) {
    if(var_0.y < var_0._id_9C46) {
      var_0.y++;
      return 1;
    } else
      return 0;
  } else {
    var_0.y++;
    return 1;
  }
}

_id_7DC9() {
  var_0 = _id_44C4();

  if(isDefined(var_0._id_9C45)) {
    if(var_0.x < var_0._id_9C45) {
      var_0.x++;
      return 1;
    } else
      return 0;
  } else {
    var_0.x++;
    return 1;
  }
}

_id_7DC8() {
  var_0 = _id_44C4();

  if(var_0._id_10FCE <= var_0._id_9C12) {
    if(isDefined(var_0._id_9C45)) {
      if(var_0.x < var_0._id_9C45) {
        var_0.x++;
        return 1;
      } else
        return 0;
    } else {
      var_0.x++;
      return 1;
    }
  } else
    return 0;
}

_id_1069D() {
  var_0 = _id_44C4();

  if(isDefined(var_0._id_9C45)) {
    if(var_0.x < var_0._id_9C45) {
      var_0.x++;
      return 1;
    } else {
      var_0._id_7DC7 = 0;
      var_0._id_10FCF = 1;
      return 0;
    }
  } else {
    var_0.x++;
    return 1;
  }
}

_id_7DCB() {
  var_0 = _id_44C4();

  if(var_0._id_10FE2 <= var_0._id_9C12) {
    if(isDefined(var_0._id_9C46)) {
      if(var_0.y < var_0._id_9C46) {
        var_0.y++;
        return 1;
      } else
        return 0;
    } else {
      var_0.y++;
      return 1;
    }
  } else
    return 0;
}

_id_1069E() {
  var_0 = _id_44C4();

  if(isDefined(var_0._id_9C46)) {
    if(var_0.y < var_0._id_9C46) {
      var_0.y++;
      return 1;
    } else {
      var_0._id_7DCA = 0;
      var_0._id_10FE3 = 1;
      return 0;
    }
  } else {
    var_0.y++;
    return 1;
  }
}

_id_1069F() {
  var_0 = _id_44C4();

  if(isDefined(var_0._id_9C49)) {
    if(var_0._id_050C < var_0._id_9C49) {
      var_0._id_050C++;
      return 1;
    } else {
      var_0._id_10FFB = 1;
      return 0;
    }
  } else {
    var_0._id_050C++;
    return 1;
  }
}

_id_65E2() {
  var_0 = _id_44C4();
  var_1 = var_0._id_E6C4;
  var_2 = var_0.x;
  var_3 = var_0.y;
  var_4 = var_0._id_050C;

  if(var_0._id_49C4[var_0._id_AC77]) {
    switch (var_0._id_AC77) {
      case 0:
        var_0._id_7189 = var_1 + (var_2 * var_0._id_10FD0, var_3 * var_0._id_10FE4, var_4 * var_0._id_10FFD);
        break;
      case 1:
        var_0._id_7189 = var_1 + (-1 * (var_2 * var_0._id_10FD0), var_3 * var_0._id_10FE4, var_4 * var_0._id_10FFD);
        break;
      case 2:
        var_0._id_7189 = var_1 + (-1 * (var_2 * var_0._id_10FD0), -1 * (var_3 * var_0._id_10FE4), var_4 * var_0._id_10FFD);
        break;
      case 3:
        var_0._id_7189 = var_1 + (-1 * (var_2 * var_0._id_10FD0), var_3 * var_0._id_10FE4, -1 * (var_4 * var_0._id_10FFD));
        break;
      case 4:
        var_0._id_7189 = var_1 + (-1 * (var_2 * var_0._id_10FD0), -1 * (var_3 * var_0._id_10FE4), -1 * (var_4 * var_0._id_10FFD));
        break;
      case 5:
        var_0._id_7189 = var_1 + (var_2 * var_0._id_10FD0, -1 * (var_3 * var_0._id_10FE4), var_4 * var_0._id_10FFD);
        break;
      case 6:
        var_0._id_7189 = var_1 + (var_2 * var_0._id_10FD0, -1 * (var_3 * var_0._id_10FE4), -1 * (var_4 * var_0._id_10FFD));
        break;
      case 7:
        var_0._id_7189 = var_1 + (var_2 * var_0._id_10FD0, var_3 * var_0._id_10FE4, -1 * (var_4 * var_0._id_10FFD));
        break;
    }
  }
}

_id_65E7() {
  var_0 = _id_44C4();
  var_1 = var_0._id_E6C4;
  var_2 = var_0.x;
  var_3 = var_0.y;
  var_4 = var_0._id_050C;
  var_5 = var_0._id_296C;
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = anglestoup(var_5);
  var_9 = var_6 * (var_2 * var_0._id_10FD0);
  var_10 = var_7 * (var_3 * var_0._id_10FE4);
  var_11 = var_8 * (var_4 * var_0._id_10FFD);

  switch (var_0._id_AC77) {
    case 0:
      var_0._id_7189 = var_1 + var_9 + var_10 + var_11;
      break;
    case 1:
      var_0._id_7189 = var_1 + -1 * var_9 + var_10 + var_11;
      break;
    case 2:
      var_0._id_7189 = var_1 + -1 * var_9 + -1 * var_10 + var_11;
      break;
    case 3:
      var_0._id_7189 = var_1 + -1 * var_9 + var_10 + -1 * var_11;
      break;
    case 4:
      var_0._id_7189 = var_1 + -1 * var_9 + -1 * var_10 + -1 * var_11;
      break;
    case 5:
      var_0._id_7189 = var_1 + var_9 + -1 * var_10 + var_11;
      break;
    case 6:
      var_0._id_7189 = var_1 + var_9 + -1 * var_10 + -1 * var_11;
      break;
    case 7:
      var_0._id_7189 = var_1 + var_9 + var_10 + -1 * var_11;
      break;
  }
}

_id_106A0() {
  var_0 = _id_44C4();
  var_1 = _func_02AB(var_0._id_7189);

  if(distancesquared(var_1, var_0._id_7189) <= var_0._id_9C27) {
    var_0._id_7189 = scripts\engine\utility::_id_5000(var_1, 96, -300);
    var_0.origin = var_0._id_7189 + (0, 0, 16);
    var_0._id_8F7E = var_0.x;
    var_0._id_8F7F = var_0.y;
    return 1;
  } else
    return 0;
}

_id_FF3A() {
  var_0 = _id_44C4();
  var_1 = _func_02AB(var_0._id_7189);

  if(distancesquared(var_1, var_0._id_7189) <= var_0._id_9C27) {
    var_0._id_7189 = scripts\engine\utility::_id_5000(var_1, 96, -300) + (0, 0, 16);
    var_0.origin = var_0._id_7189;
    var_0._id_8F7E = var_0.x;
    var_0._id_8F7F = var_0.y;
    var_0._id_10FCE = 0;
    var_0._id_10FE2 = 0;
    return 1;
  } else {
    var_0._id_49C2++;

    if(var_0._id_8F7E != var_0.x) {
      var_0._id_10FCE++;
    }

    if(var_0._id_8F7F != var_0.y) {
      var_0._id_10FE2++;
    }

    return 0;
  }
}

_id_3EEC() {
  var_0 = _id_44C4();
  var_0._id_DA80 = 1;

  for(var_1 = 0; var_1 <= var_0._id_A554; var_1++) {
    var_0._id_A553 = var_1;
    _id_3ECE();
  }
}

_id_3EEA() {
  var_0 = _id_44C4();
  var_0._id_DA80 = 1;

  for(var_1 = 0; var_1 <= var_0._id_A554; var_1++) {
    var_0._id_A553 = var_1;
    _id_3ECD();
  }

  if(istrue(var_0._id_3F0C) && istrue(var_0._id_DA80)) {
    var_2 = scripts\engine\utility::_id_5000(var_0._id_7189, 16, -300) + (0, 0, 16);
    var_0.origin = var_2;

    if(_id_30FA(var_2) && !_id_F3BD()) {
      var_0.angles = (0, 0, 0);

      if(!_id_DD48()) {
        return;
      }
      var_0._id_A563 = "node_exposed";
      _id_C9EC();
    }
  }
}

_id_1069B() {
  var_0 = _id_44C4();
  var_1 = var_0._id_7189;
  var_2 = var_0._id_A551 * var_0._id_A553;
  var_3 = cos(var_2) * var_0._id_A552;
  var_4 = sin(var_2) * var_0._id_A552;
  var_5 = var_1[0] + var_3;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2];
  var_8 = (var_5, var_6, var_7);
  var_9 = _id_3F50(var_1, var_8);

  if(isDefined(var_9["position"]) && isDefined(var_9["fraction"]) && var_9["fraction"] < 1) {
    var_0._id_DA80 = 0;

    if(isDefined(var_9["normal"])) {
      var_10 = vectordot(var_9["normal"], (0, 0, 1));
      var_0.origin = var_9["position"];
      var_0.angles = (0, scripts\engine\math::_id_10FA2(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);

      if(-0.1 > var_10 || var_10 > 0.1) {
        return;
      }
    }

    var_11 = _func_02AB(var_9["position"]);

    if(distancesquared(var_9["position"], var_11) <= var_0._id_9C27) {
      var_0._id_DA80 = 0;
      var_0.origin = scripts\engine\utility::_id_5000(var_11, 96, -300) + (0, 0, 16);
      var_0.angles = (0, scripts\engine\math::_id_10FA2(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);
      _id_C562();
    }
  }
}

_id_3ECE() {
  var_0 = _id_44C4();
  var_1 = var_0._id_7189;
  var_2 = var_0._id_A551 * var_0._id_A553;
  var_3 = cos(var_2) * var_0._id_A552;
  var_4 = sin(var_2) * var_0._id_A552;
  var_5 = var_1[0] + var_3;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2];
  var_8 = (var_5, var_6, var_7);
  var_9 = _id_3F50(var_1, var_8);

  if(isDefined(var_9["normal"])) {
    var_10 = vectordot(var_9["normal"], (0, 0, 1));

    if(-0.1 > var_10 || var_10 > 0.1) {
      return;
    }
  }

  var_11 = _func_02AB(var_9["position"]);

  if(distancesquared(var_9["position"], var_11) <= var_0._id_9C27) {
    var_0._id_DA80 = 0;
    var_0._id_A563 = "script_struct";
    var_0.origin = scripts\engine\utility::_id_5000(var_11, 12, -300) + (0, 0, 16);
    var_0.angles = (0, scripts\engine\math::_id_10FA2(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);
    _id_10FBF();
    var_0._id_F363++;
    _id_C562();
  } else {
    var_0._id_A563 = "script_struct";
    var_0.angles = (0, 0, 0);
    var_0.origin = var_9["position"];
    _id_10FBF();
  }
}

_id_3ECD() {
  var_0 = _id_44C4();
  var_1 = var_0._id_7189;
  var_2 = var_0._id_A551 * var_0._id_A553;
  var_3 = cos(var_2) * var_0._id_A552;
  var_4 = sin(var_2) * var_0._id_A552;
  var_5 = var_1[0] + var_3;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2];
  var_8 = (var_5, var_6, var_7);
  var_9 = _id_3F50(var_1, var_8);

  if(isDefined(var_9["position"]) && isDefined(var_9["fraction"]) && var_9["fraction"] < 1) {
    var_0._id_DA80 = 0;

    if(isDefined(var_9["normal"])) {
      var_10 = vectordot(var_9["normal"], (0, 0, 1));

      if(-0.1 > var_10 || var_10 > 0.1) {
        return;
      }
    }

    var_11 = _func_02AB(var_9["position"]);

    if(distancesquared(var_9["position"], var_11) <= var_0._id_9C27) {
      var_0.origin = scripts\engine\utility::_id_5000(var_11, 12, -300) + (0, 0, 16);
      var_0.angles = (0, scripts\engine\math::_id_10FA2(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);
      _id_C562();
    }
  }
}

_id_3F50(var_0, var_1, var_2) {
  var_3 = _id_44C4();
  _id_1E03();
  var_3._id_F3D0++;
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, level.players, var_3._id_F3BA);

  if(var_3._id_CB3B) {
    if(isDefined(var_4["position"])) {
      if(!isDefined(var_2)) {
        var_2 = (1, 1, 1);
      }

      var_3._id_F06F[var_3._id_F06F.size] = var_4["position"];
      var_3._id_F070[var_3._id_F070.size] = var_2;
      var_3._id_F06F[var_3._id_F06F.size] = var_1;
      var_3._id_F070[var_3._id_F070.size] = (0, 0, 0);
    }
  }

  return scripts\engine\trace::ray_trace(var_0, var_1, level.players, var_3._id_F3BA);
}

_id_446A(var_0) {
  level notify("debug_node_array");
  level endon("debug_node_array");
  var_1 = _id_44C4();

  for(;;) {
    level waittill("start_array_debug");

    if(isDefined(var_1._id_F3BB[getdvarint("#x3c8abe3ab29c0acc", 0)])) {
      var_2 = var_1._id_F3BB[getdvarint("#x3c8abe3ab29c0acc", 0)];

      foreach(var_6, var_4 in var_2) {
        var_5 = var_1._id_F3BC[getdvarint("#x3c8abe3ab29c0acc", 0)][var_6];
        level thread _id_4F1A(var_4, var_5[0], var_5[1], var_5[2], ["start_array_debug"]);

        if(var_6 % 100) {
          waitframe();
        }
      }

      waitframe();
    }
  }
}

_id_C562() {
  if(!_id_DD48()) {
    return;
  }
  level notify("reposition_cover_node");
  var_0 = _id_44C4();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = anglestoright(var_2);
  var_4 = anglestoleft(var_2);
  var_5 = anglesToForward(var_2);
  var_6 = -1 * anglesToForward(var_2);
  var_7 = anglestoup(var_2);
  var_8 = [var_4, var_3];
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_0._id_5F12 = 0;
  var_0._id_5F14 = 0;
  var_0._id_5F16 = 0;
  var_0._id_5F11 = 0;
  var_0._id_109AE = 0;
  var_0._id_F06F = [];
  var_0._id_5F17 = 0;
  var_0._id_F070 = [];

  if(getdvarint("#x340fcb61d744d3553", 0)) {
    var_0._id_CB3B = 1;
    var_0._id_F06F[var_0._id_F06F.size] = var_1;
    var_0._id_F070[var_0._id_F070.size] = (1, 1, 1);
  }

  var_12 = var_0._id_FF31;

  for(var_13 = 0; var_13 < 4; var_13++) {
    if(var_8.size < 1) {
      break;
    }

    for(var_14 = 0; var_14 < var_8.size; var_14++) {
      var_15 = var_8[var_14];
      var_16 = var_1 + var_15 * (var_13 * 32);

      if(!_id_30FA(var_16)) {
        var_8 = scripts\engine\utility::array_remove(var_8, var_15);
        continue;
      }

      var_17 = _id_3F50(var_16, var_16 + var_5 * var_12, (0, 1, 1));

      if(!_id_F3C3(var_17)) {
        var_0._id_5F17 = 0;

        for(var_18 = 1; var_18 < 32; var_18++) {
          var_19 = var_16 + -1 * var_15 * var_18;

          if(!_id_30FA(var_19)) {
            var_8 = scripts\engine\utility::array_remove(var_8, var_15);
            continue;
          }

          var_20 = _id_3F50(var_19, var_19 + var_5 * 24, (0, 1, 1));

          if(_id_F3C3(var_20)) {
            var_0._id_5F17 = 1;
            var_0._id_DA80 = 0;

            if(_id_BA06(var_20["position"])) {
              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }

            if(var_15 == var_4) {
              if(!var_0._id_5F12 && var_0._id_5100) {
                if(_id_5101(var_19, var_15, var_5)) {
                  var_0._id_5F12 = 1;
                  var_9 = scripts\engine\utility::_id_5000(var_20["position"], 12, -300);
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                } else {
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                }
              }
            } else if(!var_0._id_5F14 && var_0._id_5100) {
              if(_id_5101(var_19, var_15, var_5)) {
                var_0._id_5F14 = 1;
                var_10 = scripts\engine\utility::_id_5000(var_20["position"], 12, -300);
                var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                continue;
              }

              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }
          }
        }

        continue;
      }

      var_21 = _id_3F50(var_17["position"] + var_7 * 28, var_17["position"] + var_5 * var_0._id_FF31 + var_7 * 28, (1, 0, 1));

      if(!var_0._id_5F16 && !_id_F3C3(var_21) && !_id_BA06(var_21["position"]) && _id_FB2E(var_17["position"] + -1 * var_5, [var_4, var_3], var_5, var_7)) {
        var_0._id_5F16 = 1;
        var_0._id_DA80 = 0;
        var_11 = scripts\engine\utility::_id_5000(var_17["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(var_9) && var_0._id_5F12) {
    var_22 = scripts\engine\utility::_id_5000(var_9 + var_6 * 17 + -1 * (var_4 * 16), 16, -300) + (0, 0, 16);

    if(_id_30FA(var_22) && !_id_F3BD()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = _id_3F50(var_16, var_16 + var_5 * var_0._id_FF31, (1, 1, 0));

      if(_id_F3C3(var_20)) {
        var_0._id_A563 = "node_cover_left";
      } else {
        var_0._id_A563 = "node_cover_crouch";
      }

      _id_C9EC();
    }
  }

  if(isDefined(var_10) && var_0._id_5F14) {
    var_22 = scripts\engine\utility::_id_5000(var_10 + var_6 * 17 + -1 * (var_3 * 16), 16, -300) + (0, 0, 16);

    if(_id_30FA(var_22) && !_id_F3BD()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = _id_3F50(var_16, var_16 + var_5 * 64, (1, 1, 0));

      if(_id_F3C3(var_20)) {
        var_0._id_A563 = "node_cover_right";
      } else {
        var_0._id_A563 = "node_cover_crouch";
      }

      _id_C9EC();
    }
  }

  if(isDefined(var_11) && var_0._id_5F16 && !var_0._id_5F14 && !var_0._id_5F12) {
    var_22 = scripts\engine\utility::_id_5000(var_11 + var_6 * 17, 16, -300) + (0, 0, 16);

    if(_id_30FA(var_22) && !_id_F3BD()) {
      var_0.origin = var_22;
      var_0._id_A563 = "node_cover_crouch";
      _id_C9EC();
    }
  }

  var_0._id_CB3B = 0;
}

_id_DD4D() {
  if(!_id_DD48()) {
    return;
  }
  level notify("reposition_cover_node");
  var_0 = _id_44C4();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = anglestoright(var_2);
  var_4 = anglestoleft(var_2);
  var_5 = anglesToForward(var_2);
  var_6 = -1 * anglesToForward(var_2);
  var_7 = anglestoup(var_2);

  if(scripts\engine\utility::is_equal(var_0._id_A563, "node_cover_left")) {
    var_8 = [var_4];
  } else {
    var_8 = [var_3];
  }

  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_0._id_5F12 = 0;
  var_0._id_5F14 = 0;
  var_0._id_5F16 = 0;
  var_0._id_5F11 = 0;
  var_0._id_109AE = 0;
  var_0._id_F06F = [];
  var_0._id_5F17 = 0;
  var_0._id_F070 = [];
  var_12 = var_0._id_FF31;

  for(var_13 = 0; var_13 < 4; var_13++) {
    if(var_8.size < 1) {
      break;
    }

    for(var_14 = 0; var_14 < var_8.size; var_14++) {
      var_15 = var_8[var_14];
      var_16 = var_1 + var_15 * (var_13 * 32);

      if(!_id_30FA(var_16)) {
        var_8 = scripts\engine\utility::array_remove(var_8, var_15);
        continue;
      }

      var_17 = _id_3F50(var_16, var_16 + var_5 * var_12, (0, 1, 1));

      if(!_id_F3C3(var_17)) {
        var_0._id_5F17 = 0;

        for(var_18 = 1; var_18 < 32; var_18++) {
          var_19 = var_16 + -1 * var_15 * var_18;

          if(!_id_30FA(var_19)) {
            var_8 = scripts\engine\utility::array_remove(var_8, var_15);
            continue;
          }

          var_20 = _id_3F50(var_19, var_19 + var_5 * 24, (0, 1, 1));

          if(_id_F3C3(var_20)) {
            var_0._id_5F17 = 1;
            var_0._id_DA80 = 0;

            if(var_15 == var_4) {
              if(!var_0._id_5F12 && var_0._id_5100) {
                if(_id_5101(var_19, var_15, var_5)) {
                  var_0._id_5F12 = 1;
                  var_9 = scripts\engine\utility::_id_5000(var_20["position"], 12, -300);
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                } else {
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                }
              }
            } else if(!var_0._id_5F14 && var_0._id_5100) {
              if(_id_5101(var_19, var_15, var_5)) {
                var_0._id_5F14 = 1;
                var_10 = scripts\engine\utility::_id_5000(var_20["position"], 12, -300);
                var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                continue;
              }

              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }
          }
        }

        continue;
      }

      var_21 = _id_3F50(var_17["position"] + var_7 * 28, var_17["position"] + var_5 * var_0._id_FF31 + var_7 * 28, (1, 0, 1));

      if(!var_0._id_5F16 && !_id_F3C3(var_21) && _id_FB2E(var_17["position"] + -1 * var_5, [var_4, var_3], var_5, var_7)) {
        var_0._id_5F16 = 1;
        var_0._id_DA80 = 0;
        var_11 = scripts\engine\utility::_id_5000(var_17["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(var_9) && var_0._id_5F12) {
    var_22 = scripts\engine\utility::_id_5000(var_9 + var_6 * 17 + -1 * (var_4 * 16), 16, -300) + (0, 0, 16);

    if(_id_30FA(var_22) && !_id_F3BD()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = _id_3F50(var_16, var_16 + var_5 * var_0._id_FF31, (1, 1, 0));

      if(_id_F3C3(var_20)) {
        var_0._id_A563 = "node_cover_left";
      } else {
        var_0._id_A563 = "node_cover_crouch";
      }

      _id_C9EC();
    }
  }

  if(isDefined(var_10) && var_0._id_5F14) {
    var_22 = scripts\engine\utility::_id_5000(var_10 + var_6 * 17 + -1 * (var_3 * 16), 16, -300) + (0, 0, 16);

    if(_id_30FA(var_22) && !_id_F3BD()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = _id_3F50(var_16, var_16 + var_5 * 64, (1, 1, 0));

      if(_id_F3C3(var_20)) {
        var_0._id_A563 = "node_cover_right";
      } else {
        var_0._id_A563 = "node_cover_crouch";
      }

      _id_C9EC();
    }
  }

  if(isDefined(var_11) && var_0._id_5F16 && !var_0._id_5F14 && !var_0._id_5F12) {
    var_22 = scripts\engine\utility::_id_5000(var_11 + var_6 * 17, 16, -300) + (0, 0, 16);

    if(_id_30FA(var_22) && !_id_F3BD()) {
      var_0.origin = var_22;
      var_0._id_A563 = "node_cover_crouch";
      _id_C9EC();
    }
  }

  var_0._id_CB3B = 0;
}

_id_5AC7(var_0) {}

_id_F3BD() {
  return 0;
}

_id_5101(var_0, var_1, var_2) {
  var_3 = _id_44C4();

  for(var_4 = 32; var_4 > 0; var_4--) {
    var_5 = var_0 + -1 * var_1 * var_4;

    if(!_id_30FA(var_5)) {
      break;
    }

    var_6 = _id_3F50(var_5, var_5 + var_2 * 24, (0, 1, 0));

    if(_id_F3C3(var_6)) {
      var_3._id_109AE++;
    }
  }

  if(var_3._id_109AE >= var_3._id_109AF) {
    for(var_7 = 32; var_7 > 0; var_7--) {
      var_5 = var_0 + var_1 * var_7;

      if(!_id_30FA(var_5)) {
        return 0;
      }

      var_6 = _id_3F50(var_5, var_5 + var_2 * var_3._id_FF31, (0, 1, 0));

      if(_id_F3C3(var_6)) {
        return 0;
      }
    }

    return 1;
  } else
    return 0;
}

_id_FB2E(var_0, var_1, var_2, var_3) {
  var_4 = _id_44C4();
  var_5 = var_1;

  for(var_6 = 32; var_6 > 0; var_6--) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];
      var_9 = var_0 + -1 * var_8 * var_6;
      var_10 = _id_3F50(var_9, var_9 + var_2 * 24, (0, 1, 0));

      if(!_id_F3C3(var_10)) {
        var_4._id_109AE++;

        if(var_4._id_109AE >= var_4._id_109AF) {
          break;
        }
      } else
        continue;
    }
  }

  var_5 = var_1;
  var_4._id_109AE = 0;

  for(var_7 = 32; var_7 > 0; var_7--) {
    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_8 = var_5[var_6];
      var_9 = var_0 + var_8 * var_7 + var_3 * 28;
      var_10 = _id_3F50(var_9, var_9 + var_2 * var_4._id_FF31, (0, 1, 0));

      if(_id_F3C3(var_10)) {
        continue;
      } else {
        var_4._id_109AE++;
      }
    }
  }

  if(var_4._id_109AE >= var_4._id_109AF) {
    return 1;
  } else {
    return 0;
  }
}

_id_1E03() {
  var_0 = _id_44C4();
  var_0._id_F172++;

  if(var_0._id_F172 >= var_0._id_3F4F) {
    var_0._id_F172 = 0;
    waitframe();
  }
}

_id_F3C3(var_0, var_1) {
  var_2 = _id_44C4();

  if(isDefined(var_0["position"]) && isDefined(var_0["fraction"]) && var_0["fraction"] < 1 && var_0["fraction"] > 0) {
    if(isDefined(var_1)) {
      if(isDefined(var_0["normal"])) {
        if(var_1 == var_0["normal"]) {
          return 1;
        } else {
          return 0;
        }
      } else
        return 1;
    } else
      return 1;
  } else
    return 0;
}

_id_ABF2() {
  var_0 = _id_44C4();

  if(!scripts\engine\utility::_id_5C00("file_opened")) {
    scripts\engine\utility::_id_5C1B("file_opened");
    var_0._id_0DFA = "adding_nodes_to_map";
    scripts\engine\utility::_id_5A33();
    var_1 = "\t";
    var_2 = 0;
    scripts\engine\utility::_id_5A31("iwmap 11");
    scripts\engine\utility::_id_5A31(var_1 + "entity " + var_2);
    scripts\engine\utility::_id_5A31("{");
    scripts\engine\utility::_id_5A31(var_1 + "\"classname\" \"worldspawn\"");
    scripts\engine\utility::_id_5A31("}");
  }
}

_id_4EFC(var_0, var_1) {
  level endon("game_ended");
  level notify("draw_closest_wall_points");
  level endon("draw_closest_wall_points");
  var_0 endon("use");
  var_0 endon("disconnect");
  var_2 = _id_44C4();

  for(;;) {
    var_0 notify("reset_wall_lines");
    var_3 = scripts\engine\utility::_id_6369(var_0.origin, var_1, undefined, 50);

    foreach(var_5 in var_3) {}

    wait 1;
  }
}

_id_C9EC() {
  level endon("game_ended");
  level endon("get_nav_start_points");
  var_0 = _id_44C4();

  if(!_id_BA06(var_0.origin)) {
    var_1 = spawnStruct();
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin;
    var_0._id_1470[var_0._id_1470.size] = var_1;

    if(getdvarint("#x340fcb61d744d3553", 0)) {
      var_0._id_F3BB[var_0._id_9A9F] = var_0._id_F06F;
      var_0._id_F3BC[var_0._id_9A9F] = var_0._id_F070;
    }

    var_0._id_DA80 = 0;
    _id_10FBF();

    if(istrue(var_0._id_442F)) {
      return;
    }
  }
}

_id_BA06(var_0) {
  var_1 = _id_44C4();
  var_1._id_47C1 = 0;

  if(var_1._id_FDC5) {
    var_2 = _func_0075();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(var_4.origin == var_0) {
        return 1;
      }

      var_5 = distancesquared(var_0, var_4.origin);

      if(var_5 <= 576) {
        return 1;
      }
    }
  }

  var_6 = var_1._id_1470;

  for(var_3 = 0; var_3 < var_6.size; var_3++) {
    var_7 = var_6[var_3];

    if(var_7.origin == var_0) {
      return 1;
    }

    var_5 = distancesquared(var_0, var_7.origin);

    if(var_5 <= 256) {
      return 1;
    }

    if(var_5 <= var_1._id_47C2) {
      var_1._id_47C1++;

      if(var_1._id_47C1 >= var_1._id_47C0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_10FBF() {
  var_0 = _id_44C4();
  var_1 = "\t";
  scripts\engine\utility::_id_5A31("entity " + var_0._id_9A9F);
  scripts\engine\utility::_id_5A31("{");
  scripts\engine\utility::_id_5A31(var_1 + "\"origin\" \"" + var_0.origin[0] + " " + var_0.origin[1] + " " + var_0.origin[2] + "\"");

  if(isDefined(var_0._id_A563)) {
    scripts\engine\utility::_id_5A31(var_1 + "\"classname\" \"" + var_0._id_A563 + "\"");
  } else {
    scripts\engine\utility::_id_5A31(var_1 + "\"classname\" \"node_cover_left\"");
  }

  if(isDefined(var_0.angles)) {
    scripts\engine\utility::_id_5A31(var_1 + "\"angles\" \"" + var_0.angles[0] + " " + var_0.angles[1] + " " + var_0.angles[2] + "\"");
  } else {
    scripts\engine\utility::_id_5A31(var_1 + "\"angles\" \"0 0 0\"");
  }

  scripts\engine\utility::_id_5A31("}");
  var_0._id_9A9F++;
}

_id_4F1A(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = _id_44C4();

  if(isDefined(var_4)) {
    if(_func_0107(var_4)) {
      foreach(var_7 in var_4) {
        self endon(var_7);
      }
    } else
      self endon(var_4);
  }

  for(;;) {
    waitframe();
  }
}

_id_10A9(var_0) {
  level thread _id_10AA(var_0);
}

_id_10AA(var_0) {
  level endon("game_ended");
  wait 5;
  var_1 = "";
  var_2 = strtok(var_0, "/");
  var_3 = " ";
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = strtok(var_6, " ");
    var_8 = 1;
    var_9 = var_7.size;

    foreach(var_11 in var_7) {
      if(var_8 < var_9) {
        var_1 = var_1 + var_11 + var_3;
      } else {
        var_1 = var_1 + var_11;
      }

      var_8++;
    }

    var_4++;

    if(var_4 < var_2.size) {
      var_1 = var_1 + "/";
    }
  }
}

_id_30FA(var_0) {
  return scripts\engine\trace::_id_321B(var_0 + (0, 0, 32), var_0, 16, 32);
}