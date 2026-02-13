/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2144.gsc
*************************************************/

_id_7FF3() {
  level._id_9DCF = [];
  level._id_9DCF["current_menu"] = spawnStruct();
  _id_7F13();
  level thread _id_9DC9();

  if(!isDefined(level._id_4464)) {
    level._id_4464 = 20;
  }
}

_id_0FED(var_0, var_1, var_2) {
  if(_id_9DC0(var_0)) {
    return;
  }
  level._id_9DCF[var_0] = spawnStruct();
  level._id_9DCF[var_0]._id_F298 = var_1;
  level._id_9DCF[var_0]._id_ADD6 = 0;
  level._id_9DCF[var_0]._id_30C6 = istrue(var_2);
}

_id_9DC0(var_0) {
  return isDefined(level._id_9DCF[var_0]);
}

_id_0FF0(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_9DCF[var_0]._id_AC58)) {
    level._id_9DCF[var_0]._id_AC58 = [];
    level._id_9DCF[var_0]._id_AC59 = [];
  }

  var_5 = level._id_9DCF[var_0]._id_AC58.size;
  level._id_9DCF[var_0]._id_AC58[var_5] = var_1;
  level._id_9DCF[var_0]._id_6037[var_5] = var_2;
  level._id_9DCF[var_0]._id_2096[var_5] = var_3;

  if(isDefined(var_4)) {
    level._id_9DCF[var_0]._id_AC59[var_5] = var_4;
  }
}

_id_0FEF(var_0, var_1) {
  level._id_9DCF[var_0]._id_5469 = var_1;
}

_id_0FEE(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_9DCF[var_1])) {
    _id_0FED(var_1, var_2);
  }

  level._id_9DCF[var_1]._id_AE55 = var_0;

  if(!isDefined(level._id_9DCF[var_0]._id_357E)) {
    level._id_9DCF[var_0]._id_357E = [];
  }

  if(!isDefined(var_3)) {
    var_5 = level._id_9DCF[var_0]._id_357E.size;
  } else {
    var_5 = var_3;
  }

  level._id_9DCF[var_0]._id_357E[var_5] = var_1;

  if(isDefined(var_4)) {
    if(!isDefined(level._id_9DCF[var_0]._id_357D)) {
      level._id_9DCF[var_0]._id_357D = [];
    }

    level._id_9DCF[var_0]._id_357D[var_5] = var_4;
  }
}

_id_520C(var_0) {
  _id_4A25("current_menu");

  if(isDefined(level._id_9DBD)) {
    level._id_9DBD._id_4190 = 0;
    _id_9DBE();
  }

  level._id_9DCF["current_menu"]._id_F298 = _id_D28F(level._id_9DCF[var_0]._id_F298, "title");
  level._id_9DCF["current_menu"]._id_9DCB = var_0;

  if(isDefined(level._id_9DCF[var_0]._id_AC58)) {
    _id_4F1E(var_0);
  }

  if(isDefined(level._id_9DCF[var_0]._id_5469)) {
    level._id_9DCF["current_menu"]._id_5469 = level._id_9DCF[var_0]._id_5469;
  }

  _id_9DBD();
  _id_9DC8("current_menu", level._id_9DBD._id_4190);
}

_id_5753() {
  level notify("exit_menu");
  level._id_5787 = 1;
}

_id_4F1E(var_0) {
  var_1 = level._id_9DCF[var_0]._id_AC58;
  var_2 = level._id_9DCF[var_0]._id_ADD6;

  for(var_3 = 0; var_3 < level._id_4464 && var_3 + var_2 * level._id_4464 < var_1.size; var_3++) {
    var_4 = var_3 + var_2 * level._id_4464;
    var_5 = var_4 + 1 + ". " + var_1[var_4];
    level._id_9DCF["current_menu"]._id_AC58[var_3] = _id_D28F(var_5, "options", int(25.0) * var_3);

    if(isDefined(level._id_9DCF[var_0]._id_AC59[var_4])) {
      var_6 = level._id_9DCF[var_0]._id_AC59[var_4];
      var_7 = _id_D28F(var_6, "value", int(25.0) * var_3);

      if(scripts\common\utility::iscp()) {
        var_7.x = var_7.x + int(247.5);
      } else {
        var_7.x = var_7.x + int(207.5);
      }

      level._id_9DCF["current_menu"]._id_AC59[var_3] = var_7;
    }
  }

  if(var_1.size > level._id_4464) {
    var_5 = "";

    if(var_2 > 0) {
      var_5 = var_5 + "<-- Prev ";
    }

    if(var_2 < floor(var_1.size / level._id_4464)) {
      var_5 = var_5 + "Next -->";
    }

    if(var_5 != "") {
      level._id_9DCF["current_menu"]._id_AC58[var_3] = _id_D28F(var_5, "options", int(25.0) * var_3);
      var_3++;
    }
  }

  if(level._id_9DCF[var_0]._id_30C6) {
    level._id_9DCF["current_menu"]._id_AC58[var_3] = _id_D28F("Exit", "options", int(25.0) * var_3);
  }
}

_id_4A25(var_0) {
  level notify("stop_all_menus");

  if(isDefined(level._id_9DCF[var_0])) {
    if(isDefined(level._id_9DCF[var_0]._id_F298)) {
      level._id_9DCF[var_0]._id_F298 _id_CF88();
    }

    if(isDefined(level._id_9DCF[var_0]._id_AC58)) {
      _id_38E8(var_0);
    }
  }

  level._id_9DCF[var_0]._id_F298 = undefined;
  level._id_9DCF[var_0]._id_9DCB = undefined;
  level._id_9DCF[var_0]._id_5469 = undefined;

  if(isDefined(level._id_9DBD)) {
    level._id_9DBD _id_CF88();
  }
}

_id_38E8(var_0) {
  var_1 = level._id_9DCF[var_0]._id_AC58;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_5852)) {
      foreach(var_4 in var_1[var_2]._id_5852) {
        if(isDefined(var_4)) {
          var_4 _id_CF88();
        }
      }
    }

    var_1[var_2] _id_CF88();

    if(!isDefined(level._id_9DCF[var_0]._id_AC59)) {
      continue;
    }
    if(isDefined(level._id_9DCF[var_0]._id_AC59[var_2])) {
      level._id_9DCF[var_0]._id_AC59[var_2] _id_CF88();
    }
  }

  level._id_9DCF[var_0]._id_AC58 = [];

  if(isDefined(level._id_9DCF[var_0]._id_AC59)) {
    level._id_9DCF[var_0]._id_AC59 = [];
  }
}

_id_4837(var_0) {
  level._id_9DCF[var_0] = undefined;
}

_id_D28F(var_0, var_1, var_2) {
  if(scripts\common\utility::iscp()) {
    var_3 = 60;
  } else {
    var_3 = 20;
  }

  if(isDefined(level._id_4465)) {
    var_4 = level._id_4465;
  } else {
    var_4 = 300;
  }

  if(var_1 == "title") {
    var_5 = 1.375;
  } else {
    var_5 = 1.25;
    var_4 = var_4 + int(25.0);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = var_4 + var_2;
  return _id_D39C(var_0, var_3, var_4, var_5);
}

_id_D24D(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 20;
  }

  var_6 = newhudelem();
  var_6._id_96CF = 0;
  var_6.alignx = "left";
  var_6.aligny = "bottom";
  var_6.vertalign = "fullscreen";
  var_6.horzalign = "fullscreen";
  var_6._id_01D6 = 1;
  var_6.fontscale = var_3;
  var_6.sort = var_5;
  var_6.alpha = var_4;
  var_6.x = var_1;
  var_6.y = var_2;
  var_6._id_A9A9 = var_3;
  var_6.archived = 0;

  if(isDefined(var_0)) {
    var_6._id_F0E8 = var_0;

    if(_func_02B7(var_0)) {
      var_6 _meth_83A3(var_0);
    } else {
      var_6 _meth_8076();
    }
  }

  return var_6;
}

_id_D39C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 2;
  }

  var_5 = _id_A45B();
  var_5.x = var_1;
  var_5.y = var_2;
  var_5._id_CB76 = var_3;

  if(isDefined(var_0)) {
    var_5._id_F0E8 = var_0;
  }

  if(isDefined(var_4)) {
    var_6 = scripts\engine\math::_id_91A9(var_5.color[0] * 0.6, var_5.color[0], var_4);
    var_7 = scripts\engine\math::_id_91A9(var_5.color[1] * 0.6, var_5.color[1], var_4);
    var_8 = scripts\engine\math::_id_91A9(var_5.color[2] * 0.6, var_5.color[2], var_4);
    var_5.color = (var_6, var_7, var_8);
  }

  return var_5;
}

_id_A45B() {
  var_0 = spawnStruct();
  var_0.x = 0;
  var_0.y = 0;
  var_0._id_F0E8 = "";
  var_0.color = (1, 1, 1);
  var_0._id_CB76 = 2;
  var_0._id_8A1B = 1;
  var_0._id_145C = 1;
  var_0 thread _id_CF89();
  return var_0;
}

_id_CF89() {
  while(self._id_145C) {
    waitframe();
  }
}

_id_CF88() {
  if(!istrue(self._id_8A1B)) {
    self destroy();
    return;
  }

  self._id_145C = 0;
}

_id_A45A(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.x = var_0;
  var_2.y = var_1;
  var_2._id_F0E8 = ">";
  var_2.color = (0.8, 0.1, 0.1);
  var_2._id_CB76 = 2;
  var_2._id_8A1B = 1;
  var_2._id_145C = 1;
  var_2 thread _id_CF89();
  return var_2;
}

_id_9DC9() {
  level notify("stop_menu_input");
  level endon("stop_menu_input");

  for(;;) {
    level waittill("menu_button_pressed", var_0);

    if(!isDefined(level._id_9DBD) || isDefined(level._id_4428) && isDefined(level._id_4428._id_448E) && level._id_4428._id_448E) {
      wait 0.1;
      continue;
    }

    var_1 = level._id_9DCF["current_menu"]._id_9DCB;

    if(!isDefined(var_1)) {
      continue;
    }
    var_2["shift"] = 0;
    var_2["ctrl"] = 0;
    var_2["alt"] = 0;

    if(var_0 == "dpad_up" || var_0 == "uparrow") {
      if(level._id_9DBD._id_4190 > 0) {
        level._id_9DBD.y = level._id_9DBD.y - int(25.0);
        level._id_9DBD._id_4190--;
      } else if(level._id_9DBD._id_4190 == 0) {
        level._id_9DBD.y = level._id_9DBD.y + (level._id_9DCF["current_menu"]._id_AC58.size - 1) * int(25.0);
        level._id_9DBD._id_4190 = level._id_9DCF["current_menu"]._id_AC58.size - 1;
      }

      _id_9DC8("current_menu", level._id_9DBD._id_4190);
      wait 0.1;
      continue;
    } else if(var_0 == "dpad_down" || var_0 == "downarrow") {
      if(level._id_9DBD._id_4190 < level._id_9DCF["current_menu"]._id_AC58.size - 1) {
        level._id_9DBD.y = level._id_9DBD.y + int(25.0);
        level._id_9DBD._id_4190++;
      } else if(level._id_9DBD._id_4190 == level._id_9DCF["current_menu"]._id_AC58.size - 1) {
        level._id_9DBD.y = level._id_9DBD.y + level._id_9DBD._id_4190 * int(25.0) * -1;
        level._id_9DBD._id_4190 = 0;
      }

      _id_9DC8("current_menu", level._id_9DBD._id_4190);
      wait 0.1;
      continue;
    } else if(var_0 == "button_a" || var_0 == "dpad_right" || var_0 == "dpad_left" || var_0 == "rightarrow" || var_0 == "leftarrow") {
      if(var_0 == "dpad_left" || var_0 == "leftarrow") {
        var_2["shift"] = 1;
      }

      var_3 = level._id_9DBD._id_4190;
    } else
      var_3 = int(var_0) - 1;

    if(level.player _meth_805E("lshift") || level.player _meth_805E("rshift")) {
      var_2["shift"] = 1;
    }

    if(level._id_9DCF[var_1]._id_30C6) {
      var_4 = 2;
    } else {
      var_4 = 1;
    }

    if(var_3 >= level._id_9DCF["current_menu"]._id_AC58.size) {
      continue;
    } else if(level._id_9DCF[var_1]._id_30C6 && var_3 == level._id_9DCF["current_menu"]._id_AC58.size - 1) {
      level notify("exit_menu");
      level._id_5787 = 1;
      continue;
    } else if(level._id_9DCF[var_1]._id_AC58.size > level._id_4464 && var_3 == level._id_9DCF["current_menu"]._id_AC58.size - var_4) {
      var_5 = 0;

      if(var_2["shift"] && level._id_9DCF[var_1]._id_ADD6 > 0) {
        level._id_9DCF[var_1]._id_ADD6--;
        var_5 = 1;
      } else if(!var_2["shift"] && level._id_9DCF[var_1]._id_ADD6 < floor(level._id_9DCF[var_1]._id_AC58.size / level._id_4464)) {
        level._id_9DCF[var_1]._id_ADD6++;
        var_5 = 1;
      }

      if(var_5) {
        var_6 = level._id_9DCF["current_menu"]._id_AC58.size;
        _id_38E8("current_menu");
        _id_4F1E(var_1);

        if(level._id_9DCF["current_menu"]._id_AC58.size != var_6) {
          if(isDefined(level._id_4465)) {
            var_7 = level._id_4465;
          } else {
            var_7 = 300;
          }

          level._id_9DBD.y = var_7 + (level._id_9DCF["current_menu"]._id_AC58.size - var_4 + 1) * int(25.0);
          level._id_9DBD._id_4190 = level._id_9DCF["current_menu"]._id_AC58.size - var_4;
        }
      }

      continue;
    } else {
      var_8 = var_3;
      var_3 = var_3 + level._id_9DCF[var_1]._id_ADD6 * level._id_4464;
    }

    if(isDefined(level._id_9DCF[var_1]._id_AE55) && var_3 == level._id_9DCF[var_1]._id_AC58.size) {
      level notify("disable " + var_1);
      level _id_520C(level._id_9DCF[var_1]._id_AE55);
    } else if(isDefined(level._id_9DCF[var_1]._id_6037) && isDefined(level._id_9DCF[var_1]._id_6037[var_3])) {
      var_9 = undefined;

      if(!var_2["shift"]) {
        var_9 = level._id_9DCF[var_1]._id_6037[var_3];
      } else if(isDefined(level._id_9DCF[var_1]._id_2096)) {
        var_9 = level._id_9DCF[var_1]._id_2096[var_3];
      }

      if(isDefined(var_9)) {
        var_10 = level;

        if(isDefined(level._id_9DCF["current_menu"]._id_5469)) {
          var_10 = level._id_9DCF["current_menu"]._id_5469;
        }

        var_11 = var_10[[var_9]]();

        if(isDefined(var_11)) {
          level._id_9DCF["current_menu"]._id_AC59[var_8]._id_F0E8 = var_11;

          if(isDefined(level._id_9DCF["current_menu"]._id_AC59[var_8]._id_8A1B)) {
            level._id_9DCF["current_menu"]._id_AC59[var_8]._id_F0E8 = var_11;
          } else if(_func_02B7(var_11)) {
            level._id_9DCF["current_menu"]._id_AC59[var_8] _meth_83A3(var_11);
          } else {
            level._id_9DCF["current_menu"]._id_AC59[var_8] _meth_8076();
          }
        }
      }
    }

    if(!isDefined(level._id_9DCF[var_1]._id_357E)) {
      continue;
    } else if(!isDefined(level._id_9DCF[var_1]._id_357E[var_3])) {
      continue;
    } else if(!isDefined(level._id_9DCF[level._id_9DCF[var_1]._id_357E[var_3]])) {
      continue;
    }
    if(isDefined(level._id_9DCF[var_1]._id_357D) && isDefined(level._id_9DCF[var_1]._id_357D[var_3])) {
      var_9 = level._id_9DCF[var_1]._id_357D[var_3];
      var_12 = [[var_9]]();

      if(isDefined(var_12)) {
        level thread _id_D06B(var_12, level._id_9DCF["current_menu"]._id_AC58[var_8].x, level._id_9DCF["current_menu"]._id_AC58[var_8].y);
        continue;
      }
    }

    level _id_520C(level._id_9DCF[var_1]._id_357E[var_3]);
    wait 0.1;
  }
}

_id_9DC8(var_0, var_1) {
  foreach(var_3 in level._id_9DCF[var_0]._id_AC58) {
    var_3.color = (1, 1, 1);
  }

  if(isDefined(level._id_9DCF[var_0]._id_AC59)) {
    foreach(var_3 in level._id_9DCF[var_0]._id_AC59) {
      var_3.color = (1, 1, 1);
    }
  }

  if(isDefined(level._id_9DCF[var_0]._id_AC59) && isDefined(level._id_9DCF[var_0]._id_AC59[var_1])) {
    level._id_9DCF[var_0]._id_AC59[var_1].color = (1, 1, 0);
  }

  level._id_9DCF[var_0]._id_AC58[var_1].color = (1, 1, 0);
}

_id_7B46(var_0, var_1) {}

_id_7B47(var_0) {}

_id_9DC4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_9DBD._id_4190;
  }

  return level._id_9DCF["current_menu"]._id_AC59[var_0];
}

_id_6426() {
  return level._id_9DCF["current_menu"]._id_9DCB;
}

_id_9DC3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_9DBD._id_4190;
  }

  return level._id_9DCF["current_menu"]._id_AC58[var_0];
}

_id_9DC5() {
  var_0 = level._id_9DBD._id_4190;
  return level._id_9DCF["current_menu"]._id_AC58[var_0]._id_F0E8;
}

_id_D06B(var_0, var_1, var_2) {
  var_3 = _id_D24D(undefined, var_1 - 10, var_2, 1);

  if(scripts\common\utility::iscp()) {
    var_3 setshader("white", int(247.5), 20);
  } else {
    var_3 setshader("white", int(207.5), 20);
  }

  var_3.color = (0.5, 0, 0);
  var_3.alpha = 0.7;

  if(scripts\common\utility::iscp()) {
    var_4 = _id_D24D(var_0, var_1 + int(247.5), var_2, 1);
  } else {
    var_4 = _id_D24D(var_0, var_1 + int(207.5), var_2, 1);
  }

  var_4.color = (1, 0, 0);

  if(!isDefined(var_3._id_4457)) {
    var_3 fadeovertime(3);
  }

  var_3.alpha = 0;

  if(!isDefined(var_4._id_4457)) {
    var_4 fadeovertime(3);
  }

  var_4.alpha = 0;
  wait 3.1;
  var_3 destroy();
  var_4 destroy();
}

_id_9DBD() {
  if(isDefined(level._id_4465)) {
    var_0 = level._id_4465;
  } else {
    var_0 = 300;
  }

  level._id_9DBD = _id_A45A(0, var_0 + int(25.0));
  level._id_9DBD._id_4190 = 0;
  _id_9DBE();
}

_id_9DBE() {
  if(isDefined(level._id_4465)) {
    var_0 = level._id_4465;
  } else {
    var_0 = 300;
  }

  level._id_9DBD.x = 0;
  level._id_9DBD.y = var_0 + int(25.0) + 6;
}

_id_0FD8(var_0) {
  if(!isDefined(self._id_5852)) {
    self._id_5852 = [];
  }

  self._id_5852[self._id_5852.size] = var_0;
}

_id_951D(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("stop_all_menus");
  var_6 = _id_9DC3();

  if(!isDefined(var_0) || var_0.size == 0) {
    return -1;
  }

  var_7 = [];
  var_8 = 25.0;
  var_9 = _id_D39C("->", var_1 - 20, var_2, 1.25, 1);
  var_9.color = (0.8, 0.1, 0.1);
  var_6 _id_0FD8(var_9);

  if(scripts\common\utility::issp()) {
    var_10 = 5;
    var_11 = 2;
  } else {
    var_10 = 3;
    var_11 = 1;
  }

  for(var_12 = 0; var_12 < var_10; var_12++) {
    if(var_12 == 0) {
      var_13 = 0.3;
    } else if(var_12 == 1) {
      var_13 = 0.6;
    } else if(var_12 == 2) {
      var_13 = 1;
    } else if(var_12 == 3) {
      var_13 = 0.6;
    } else {
      var_13 = 0.3;
    }

    var_14 = _id_D39C(var_0[var_12], var_1, var_2 + (var_12 - var_11) * var_8, 1.25, var_13);
    var_6 _id_0FD8(var_14);
    var_7 = scripts\engine\utility::array_add(var_7, var_14);
  }

  if(isDefined(var_5)) {
    _id_A1E3(var_7, var_0, var_5, var_11);
  } else {
    _id_A1E3(var_7, var_0, 0, var_11);
  }

  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  level._id_9DCA = 0;

  if(isDefined(var_3)) {
    [[var_3]](var_0[var_15]);
  }

  for(;;) {
    level waittill("menu_button_pressed", var_18);

    if(!isDefined(level._id_9DBD)) {
      var_17 = 0;
      break;
    }

    level._id_9DCA = 1;

    if(_id_1906(var_18, "numbers")) {
      break;
    } else if(var_18 == "downarrow" || var_18 == "dpad_down") {
      if(var_15 >= var_0.size - 1) {
        var_15 = 0;
        _id_A1E3(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15++;
      _id_A1E3(var_7, var_0, var_15, var_11);
    } else if(var_18 == "uparrow" || var_18 == "dpad_up") {
      if(var_15 <= 0) {
        var_15 = var_0.size - 1;
        _id_A1E3(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15--;
      _id_A1E3(var_7, var_0, var_15, var_11);
    } else if(var_18 == "pgup") {
      if(var_15 <= 0) {
        var_15 = var_0.size - 1;
        _id_A1E3(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15 = var_15 - 5;
      var_15 = clamp(var_15, 0, var_0.size - 1);
      var_15 = int(var_15);
      _id_A1E3(var_7, var_0, var_15, var_11);
    } else if(var_18 == "pgdn") {
      if(var_15 >= var_0.size - 1) {
        var_15 = 0;
        _id_A1E3(var_7, var_0, var_15, var_11);
        continue;
      }

      var_15 = var_15 + 5;
      var_15 = clamp(var_15, 0, var_0.size - 1);
      var_15 = int(var_15);
      _id_A1E3(var_7, var_0, var_15, var_11);
    } else if(var_18 == "enter" || var_18 == "button_a" || var_18 == "dpad_right" || var_18 == "rightarrow") {
      var_17 = 1;
      break;
    } else if(var_18 == "end" || var_18 == "button_b" || var_18 == "dpad_left" || var_18 == "leftarrow") {
      var_17 = 0;
      break;
    }

    level notify("scroll_list");

    if(var_15 != var_16) {
      var_16 = var_15;

      if(isDefined(var_3)) {
        [[var_3]](var_0[var_15]);
      }
    }

    wait 0.1;
  }

  if(var_9._id_8A1B) {
    var_9 _id_CF88();
  } else {
    var_9 destroy();
  }

  for(var_12 = 0; var_12 < var_7.size; var_12++) {
    if(var_7[var_12]._id_8A1B) {
      var_7[var_12] _id_CF88();
      continue;
    }

    var_7[var_12] destroy();
  }

  if(var_17) {
    return var_15;
  }
}

_id_A1E3(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_4 + (var_2 - var_3);

    if(isDefined(var_1[var_5])) {
      var_6 = var_1[var_5];
    } else if(var_5 < 0) {
      var_6 = var_1[var_1.size + var_5];
    } else {
      var_6 = var_1[var_5 % var_1.size];
    }

    var_0[var_4].archived = 0;

    if(isDefined(var_0[var_4]._id_8A1B)) {
      var_0[var_4]._id_F0E8 = var_6;
      continue;
    }

    var_0[var_4] _meth_8076();
  }
}

_id_30C6() {
  if(isDefined(level._id_5787)) {
    level._id_5787 = undefined;
    return 1;
  }

  if(isai(self) && !isalive(self)) {
    return 1;
  }

  return 0;
}

_id_106B(var_0, var_1) {
  if(!isDefined(level._id_F8E7[var_0])) {
    level._id_F8E7[var_0] = [];
  }

  if(_id_1B99(level._id_F8E7[var_0], var_1)) {
    level._id_F8E7[var_0][level._id_F8E7[var_0].size] = var_1;
  }
}

_id_1B99(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 0;
    }
  }

  return 1;
}

_id_3910(var_0) {
  level._id_F8E7[var_0] = [];
}

_id_F956(var_0, var_1, var_2, var_3, var_4) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level endon(var_1);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = var_0 + "_button_pressed";
  var_6 = level._id_F8E7[var_0];
  level._id_F8E8[var_0] = 0;

  for(;;) {
    if(level._id_F8E8[var_0]) {
      waitframe();
      continue;
    }

    if(isDefined(var_3) && !level.player _meth_805E(var_3)) {
      waitframe();
      continue;
    } else if(isDefined(var_4) && level.player _meth_805E(var_4)) {
      waitframe();
      continue;
    }

    if(var_2 && level.player attackbuttonpressed()) {
      level notify(var_5, "fire");
      wait 0.1;
      continue;
    }

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(level.player _meth_805E(var_6[var_7])) {
        level notify(var_5, var_6[var_7]);
        wait 0.1;
        break;
      }
    }

    waitframe();
  }
}

_id_1906(var_0, var_1) {
  var_2 = [];

  if(var_1 == "numbers") {
    var_2[0] = "0";
    var_2[1] = "1";
    var_2[2] = "2";
    var_2[3] = "3";
    var_2[4] = "4";
    var_2[5] = "5";
    var_2[6] = "6";
    var_2[7] = "7";
    var_2[8] = "8";
    var_2[9] = "9";
  } else
    var_2 = level._id_2DDC;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_0 == var_2[var_3]) {
      return 1;
    }
  }

  return 0;
}

_id_7F13() {
  _id_3910("menu");
  _id_106B("menu", "dpad_up");
  _id_106B("menu", "dpad_down");
  _id_106B("menu", "dpad_left");
  _id_106B("menu", "dpad_right");
  _id_106B("menu", "downarrow");
  _id_106B("menu", "uparrow");
  _id_106B("menu", "leftarrow");
  _id_106B("menu", "rightarrow");
  _id_106B("menu", "enter");
  level thread _id_F956("menu", "never", undefined, undefined, "button_ltrig");
}

_id_80A9() {
  thread _id_82DB();
  thread _id_4210();
}

_id_82DB() {
  var_0 = 0;
  level._id_60A3 = 0;

  for(;;) {
    if(gettime() > level._id_60A3 && level.player usebuttonpressed() || isDefined(level._id_5E6C)) {
      if(isDefined(level._id_5E6C)) {
        level._id_793A = level._id_5E6C;
      }

      level._id_60A3 = gettime() + 400;

      if(isDefined(level._id_793A)) {
        if(isDefined(level._id_793A._id_FE73)) {
          level._id_793A thread[[level._id_793A._id_FE73]]();
        }

        if(isDefined(level._id_793A._id_AB9A)) {
          level._id_793A[[level._id_793A._id_AB9A]]();
        } else if(isDefined(level._id_793A._id_D03E)) {
          level._id_793A[[level._id_793A._id_D03E]]();
        }
      }

      if(isDefined(level._id_5E6C)) {
        level._id_5E6C = undefined;
      }

      wait 0.2;
    }

    waitframe();
  }
}

_id_480E() {
  if(!isDefined(level._id_D054)) {
    return;
  }
  if(isDefined(level._id_D05E)) {
    level._id_D05E destroy();
  }

  level notify("deselect");
  level._id_D054._id_D054 = 0;
  level._id_D054 notify("deselect");

  if(!_func_02E1(level._id_D054)) {
    level._id_D054 _meth_81AD();
  }

  level._id_D054 = undefined;
  setsaveddvar("#x37f5385a7721003c6", 2);

  if(isDefined(level._id_5E26) && isDefined(level._id_6016["followcam"])) {
    [[level._id_6016["followcam"]]](0);
  }
}

_id_5E6B(var_0) {
  level._id_5E6C = var_0;
}

_id_D033(var_0) {
  _id_480E();
  var_0 endon("death");

  if(_func_02E1(var_0)) {
    var_0 notify("stop_highlight");
    var_0 thread _id_4EF2(var_0.origin + (0, 0, 16), 32, (0.2, 1, 0.2), var_0.angles, 32, "deselect");
  } else {
    var_0 _meth_81B0("outline_nodepth_cyan");
    setsaveddvar("#x37f5385a7721003c6", 2);
  }

  var_0._id_D054 = 1;
  level._id_D054 = var_0;
  wait 1;

  if(_func_02E1(var_0)) {
    return;
  }
  var_0 _meth_81AD();
  return;
}

_id_1016(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_D04D, var_0)) {
    level._id_D04D[level._id_D04D.size] = var_0;
  }
}

_id_C446(var_0) {
  level._id_D04D = scripts\engine\utility::array_remove(level._id_D04D, var_0);
}

_id_3862() {
  level._id_D04D = scripts\engine\utility::_id_1BD1(level._id_D04D);
}

_id_D059(var_0) {
  var_1 = newhudelem();
  var_1.y = 460;
  var_1.x = 320;
  var_1.alpha = 0.8;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.archived = 0;
  var_1 _meth_8076();
  level._id_D05E = var_1;
}

_id_4210() {
  level._id_D04D = [];
  level._id_4219 = (0, 0, 0);
  _id_7F49();
  level notify("stop_cursor");
  level endon("stop_cursor");

  for(;;) {
    _id_4211();
    waitframe();
  }
}

_id_4211() {
  var_0 = level.player getEye();
  var_1 = anglesToForward(level.player getplayerangles());
  var_0 = var_0 + var_1 * 30;
  var_2 = var_0 + var_1 * 10000;
  var_3 = scripts\engine\trace::_id_C051(var_0, var_2);
  var_4 = var_3["position"];
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_5 = _id_6748(var_0, var_2, 40);

  if(isDefined(var_5)) {
    _id_4F11(var_5);
    level._id_793A = var_5;
  } else {
    if(distance(var_3["position"], var_4) < 0.1) {
      if(_id_8663(var_4)) {
        level._id_4219 = var_4;
      }
    }

    _id_4EF0();
    _id_E8CF();
    level._id_793A = undefined;
  }
}

_id_6748(var_0, var_1, var_2) {
  _id_3862();
  return _id_6749(level._id_D04D, level._id_D05A, var_0, var_1, var_2);
}

_id_6749(var_0, var_1, var_2, var_3, var_4) {
  var_4 = _func_0219(var_4);
  var_5 = var_4;
  var_6 = undefined;

  foreach(var_8 in var_0) {
    var_9 = var_8.origin;

    if(isent(var_8) && isai(var_8)) {
      var_9 = var_9 + (0, 0, 40);
    }

    if(isDefined(var_1) && var_1 == var_8) {
      continue;
    }
    var_10 = _func_01A4(var_2, var_3, var_9);
    var_11 = distancesquared(var_10, var_9);

    if(var_11 < var_5) {
      var_5 = var_11;
      var_6 = var_8;
    }
  }

  return var_6;
}

_id_4F11(var_0) {
  var_1 = 4;
  var_2 = (1, 1, 0.5);
  var_3 = 1;
  var_4 = 1;

  if(isDefined(var_0._id_86BF)) {
    _id_E8CF();
    _id_4F27(var_0.origin, var_0.angles, var_2);
  } else if(!isDefined(level._id_D054) && (!isDefined(level._id_793A) || level._id_793A != var_0)) {
    _id_E8CF();

    if(isDefined(var_0._id_AB00)) {
      var_0 thread[[var_0._id_AB00]]();
    }

    if(_func_02E1(var_0)) {
      var_0 thread _id_4EF2(var_0.origin + (0, 0, 16), 32, (1, 1, 0), var_0.angles, 32);
    } else {
      var_0 _meth_81B0("outline_nodepth_orange");
      var_0 thread _id_4F2D(var_0.origin + (0, 0, 70), "Press X To Select");
    }
  }
}

_id_E8CF() {
  if(!isDefined(level._id_793A)) {
    return;
  }
  level._id_793A notify("stop_highlight");

  if(_func_02E1(level._id_793A)) {
    return;
  }
  if(isDefined(level._id_D054) && level._id_D054 == level._id_793A) {
    return;
  }
  level._id_793A _meth_81AD();
}

_id_4F27(var_0, var_1, var_2) {
  var_3 = var_0 + anglesToForward(var_1) * 20;
  _id_0BC9(var_0 + (0, 0, 36), var_3 + (0, 0, 36), var_2);
  _id_4EF1(var_0, var_2, var_1, 72);
}

_id_0BC9(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_1 - var_0);
  var_4 = length(var_1 - var_0);
  var_5 = anglesToForward(var_3);
  var_6 = var_5 * var_4;
  var_7 = 5;
  var_8 = var_5 * (var_4 - var_7);
  var_9 = anglestoright(var_3);
  var_10 = var_9 * (var_7 * -1);
  var_11 = var_9 * var_7;
}

_id_4F2D(var_0, var_1) {
  self endon("stop_highlight");
  self endon("death");

  for(;;) {
    waitframe();
  }
}

_id_4EF2(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    self endon(var_5);
  } else {
    self endon("stop_highlight");
  }

  for(;;) {
    _id_4EF1(var_0, var_1, var_2, var_3, var_4);
    waitframe();
  }
}

_id_4EF1(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = 32;
  }

  if(!isDefined(var_4)) {
    var_4 = 32;
  }

  var_5 = anglesToForward(var_3);
}

_id_4EF0() {
  var_0 = 5;
  var_1 = level._id_4219;
  var_2 = 1;
  var_3 = 1;
}

_id_7F49() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  var_0 = newhudelem();
  var_0._id_96CF = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0._id_01D6 = 1;
  var_0.fontscale = 1;
  var_0.sort = 20;
  var_0.alpha = 1;
  var_0.x = 320;
  var_0.y = 237;
  var_0.archived = 0;
}

_id_8663(var_0) {
  var_1 = getdvarint("#x3d8895774949f4ed6");
  var_2 = 6;
  var_3 = 360 / var_2;
  var_4 = _func_0219(0.1);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = (-30, var_5 * var_3, 0);
    var_7 = anglesToForward(var_6);
    var_8 = var_0 + var_7 * 30;
    var_9 = scripts\engine\trace::ray_trace(var_0, var_8, undefined, scripts\engine\trace::_id_3F70(1));
    var_10 = var_9["position"];
    var_11 = distancesquared(var_10, var_8);

    if(var_11 > var_4) {
      return 0;
    }

    var_9 = scripts\engine\trace::ray_trace(var_8 + (0, 0, 42), var_8, undefined, scripts\engine\trace::_id_3F70(1));
    var_10 = var_9["position"];

    if(var_11 > var_4) {
      return 0;
    }
  }

  return 1;
}