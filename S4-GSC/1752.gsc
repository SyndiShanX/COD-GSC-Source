/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1752.gsc
*************************************************/

_id_7FF2() {
  self._id_9DCF = [];
  self._id_9DCF["current_menu"] = spawnStruct();
  thread _id_7F13();
  thread _id_9DC9();
}

_id_385A() {
  _id_4A25("current_menu");
  self notify("end_hud_menu");
  self._id_9DCF = undefined;
}

_id_0FED(var_0, var_1) {
  if(isDefined(self._id_9DCF[var_0])) {
    return;
  }
  self._id_9DCF[var_0] = spawnStruct();
  self._id_9DCF[var_0]._id_F298 = var_1;
}

_id_0FF0(var_0, var_1, var_2) {
  if(!isDefined(self._id_9DCF[var_0]._id_AC58)) {
    self._id_9DCF[var_0]._id_AC58 = [];
  }

  var_3 = self._id_9DCF[var_0]._id_AC58.size;
  self._id_9DCF[var_0]._id_AC58[var_3] = var_1;
  self._id_9DCF[var_0]._id_6037[var_3] = var_2;
}

_id_38E9(var_0) {
  self._id_9DCF[var_0]._id_AC58 = [];
  self._id_9DCF[var_0]._id_6037 = [];
}

_id_0FEE(var_0, var_1, var_2) {
  if(!isDefined(self._id_9DCF[var_1])) {
    _id_0FED(var_1, var_2);
  }

  self._id_9DCF[var_1]._id_AE55 = var_0;

  if(!isDefined(self._id_9DCF[var_0]._id_357E)) {
    self._id_9DCF[var_0]._id_357E = [];
  }

  var_3 = self._id_9DCF[var_0]._id_357E.size;
  self._id_9DCF[var_0]._id_357E[var_3] = var_1;
}

_id_C407(var_0) {
  if(isDefined(self._id_9DCF[var_0])) {
    if(isDefined(self._id_9DCF[var_0]._id_AE55)) {
      var_1 = self._id_9DCF[var_0]._id_AE55;
      var_2 = [];

      foreach(var_4 in self._id_9DCF[var_1]._id_357E) {
        if(var_4 == var_0) {
          continue;
        }
        var_2[var_2.size] = var_4;
      }

      self._id_9DCF[var_1]._id_357E = var_2;
    }
  }

  self._id_9DCF[var_0] = undefined;
}

_id_520C(var_0, var_1) {
  _id_4A25("current_menu");

  if(isDefined(self._id_9DBD)) {
    self._id_9DBD.y = 130;
    self._id_9DBD._id_4190 = 0;
  }

  self._id_9DCF["current_menu"]._id_F298 = _id_D28F(self._id_9DCF[var_0]._id_F298, "title");
  self._id_9DCF["current_menu"]._id_9DCB = var_0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self._id_9DCF["current_menu"]._id_AC4B = var_1;

  if(isDefined(self._id_9DCF[var_0]._id_AC58)) {
    var_2 = self._id_9DCF[var_0]._id_AC58;
    var_3 = var_1 * 14;
    var_4 = min(var_2.size, var_3 + 14);

    for(var_5 = var_3; var_5 < var_4; var_5++) {
      var_6 = self._id_9DCF["current_menu"]._id_AC58.size;
      var_7 = var_5 + 1 + ". " + var_2[var_5];
      self._id_9DCF["current_menu"]._id_AC58[var_6] = _id_D28F(var_7, "options", 20 * var_6);
    }

    if(var_2.size > var_4) {
      var_8 = self._id_9DCF["current_menu"]._id_AC58.size;
      var_7 = "Next";
      self._id_9DCF["current_menu"]._id_AC58[var_8] = _id_D28F(var_7, "options", 20 * var_8);
      self._id_9DCF["current_menu"]._id_A4BE = var_8;
    }

    if(isDefined(self._id_9DCF[var_0]._id_AE55) && !isDefined(self._id_9DCF[var_0]._id_A505) || var_1 > 0) {
      var_9 = self._id_9DCF["current_menu"]._id_AC58.size;
      var_7 = "Back";
      self._id_9DCF["current_menu"]._id_AC58[var_9] = _id_D28F(var_7, "options", 20 * var_9);
      self._id_9DCF["current_menu"]._id_20A9 = var_9;
    }
  }

  _id_9DBD();
}

_id_4A25(var_0) {
  if(isDefined(self._id_9DCF[var_0])) {
    if(isDefined(self._id_9DCF[var_0]._id_F298)) {
      self._id_9DCF[var_0]._id_F298 _meth_8076();
      self._id_9DCF[var_0]._id_F298 destroy();
    }

    if(isDefined(self._id_9DCF[var_0]._id_AC58)) {
      var_1 = self._id_9DCF[var_0]._id_AC58;

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        var_1[var_2] destroy();
      }
    }
  }

  self._id_9DCF[var_0]._id_F298 = undefined;
  self._id_9DCF[var_0]._id_AC58 = [];
  self._id_9DCF[var_0]._id_A4BE = undefined;
  self._id_9DCF[var_0]._id_20A9 = undefined;

  if(isDefined(self._id_9DBD)) {
    self._id_9DBD destroy();
  }
}

_id_D28F(var_0, var_1, var_2) {
  var_3 = 10;
  var_4 = 100;

  if(isDefined(var_1) && var_1 == "title") {
    var_5 = 2;
  } else {
    var_5 = 1.3;
    var_4 = var_4 + 30;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = var_4 + var_2;
  return _id_D24D(var_0, var_3, var_4, var_5);
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

  var_6 = newclienthudelem(self);
  var_6._id_96CF = 0;
  var_6.alignx = "left";
  var_6.aligny = "middle";
  var_6._id_01D6 = 1;
  var_6.fontscale = var_3;
  var_6.sort = var_5;
  var_6.alpha = var_4;
  var_6.x = var_1;
  var_6.y = var_2;
  var_6._id_A9A9 = var_3;
  var_6.archived = 0;

  if(isDefined(var_0)) {}

  var_6 thread _id_4839(self);
  return var_6;
}

_id_4839(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self destroy();
}

_id_9DBD() {
  self._id_9DBD = _id_D24D(undefined, 0, 130, 1.3);
  self._id_9DBD setshader("white", 125, 20);
  self._id_9DBD.color = (0.2, 0.2, 0.2);
  self._id_9DBD.alpha = 0.9;
  self._id_9DBD.sort = 1;
  self._id_9DBD._id_4190 = 0;
}

_id_9DC9() {
  self endon("end_hud_menu");

  for(;;) {
    self waittill("menu_button_pressed", var_0);

    if(!isDefined(self._id_9DBD)) {
      wait 0.1;
      continue;
    }

    var_1 = self._id_9DCF["current_menu"]._id_9DCB;

    if(var_0 == "dpad_up" || var_0 == "uparrow") {
      if(self._id_9DBD._id_4190 > 0) {
        self._id_9DBD.y = self._id_9DBD.y - 20;
        self._id_9DBD._id_4190--;
      } else if(self._id_9DBD._id_4190 == 0) {
        self._id_9DBD.y = self._id_9DBD.y + (self._id_9DCF["current_menu"]._id_AC58.size - 1) * 20;
        self._id_9DBD._id_4190 = self._id_9DCF["current_menu"]._id_AC58.size - 1;
      }

      wait 0.1;
      continue;
    } else if(var_0 == "dpad_down" || var_0 == "downarrow") {
      if(self._id_9DBD._id_4190 < self._id_9DCF["current_menu"]._id_AC58.size - 1) {
        self._id_9DBD.y = self._id_9DBD.y + 20;
        self._id_9DBD._id_4190++;
      } else if(self._id_9DBD._id_4190 == self._id_9DCF["current_menu"]._id_AC58.size - 1) {
        self._id_9DBD.y = self._id_9DBD.y + self._id_9DBD._id_4190 * -20;
        self._id_9DBD._id_4190 = 0;
      }

      wait 0.1;
      continue;
    } else if(var_0 == "button_a" || var_0 == "enter")
      var_2 = self._id_9DBD._id_4190;
    else if(var_0 == "button_b" && isDefined(self._id_9DCF["current_menu"]._id_20A9)) {
      var_2 = self._id_9DCF["current_menu"]._id_20A9;
    } else {
      var_2 = int(var_0) - 1;
    }

    var_3 = 0;

    if(isDefined(self._id_9DCF["current_menu"]._id_AC4B)) {
      var_3 = self._id_9DCF["current_menu"]._id_AC4B;
    }

    if(var_2 > self._id_9DCF["current_menu"]._id_AC58.size) {
      continue;
    } else if(isDefined(self._id_9DCF["current_menu"]._id_A4BE) && var_2 == self._id_9DCF["current_menu"]._id_A4BE) {
      _id_520C(var_1, var_3 + 1);
    } else if(isDefined(self._id_9DCF["current_menu"]._id_20A9) && var_2 == self._id_9DCF["current_menu"]._id_20A9) {
      if(var_3 > 0) {
        _id_520C(var_1, var_3 - 1);
      } else {
        self notify("disable " + var_1);
        _id_520C(self._id_9DCF[var_1]._id_AE55);
      }
    } else if(isDefined(self._id_9DCF[var_1]._id_6037) && isDefined(self._id_9DCF[var_1]._id_6037[var_2]))
      thread _id_9DCE(var_1, var_2);

    if(!isDefined(self._id_9DCF[var_1]._id_357E)) {
      continue;
    } else if(!isDefined(self._id_9DCF[var_1]._id_357E[var_2])) {
      continue;
    } else if(!isDefined(self._id_9DCF[self._id_9DCF[var_1]._id_357E[var_2]])) {
      continue;
    }
    _id_520C(self._id_9DCF[var_1]._id_357E[var_2]);
    wait 0.1;
  }
}

_id_9DCE(var_0, var_1) {
  thread _id_7B46(self._id_9DCF["current_menu"]._id_AC58[var_1].x, self._id_9DCF["current_menu"]._id_AC58[var_1].y);
  var_2 = self thread[[self._id_9DCF[var_0]._id_6037[var_1]]]();
  thread _id_7B47();

  if(isDefined(var_2)) {
    thread _id_D06B(var_2, self._id_9DCF["current_menu"]._id_AC58[var_1].x, self._id_9DCF["current_menu"]._id_AC58[var_1].y);
  }
}

_id_7B46(var_0, var_1) {
  if(!isDefined(self._id_9DBD)) {
    return;
  }
  if(isDefined(self._id_7B46)) {
    thread _id_7B47();
  }

  self._id_9DBD.alpha = 0;
  self._id_7B46 = _id_D24D(undefined, var_0 - 10, var_1, 1);
  self._id_7B46 setshader("white", 125, 20);
  self._id_7B46.color = (0.5, 0.5, 0.5);
  self._id_7B46.alpha = 0.9;
  self._id_7B46.sort = 10;
}

_id_7B47(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.25;
  }

  if(isDefined(self._id_9DBD)) {
    self._id_9DBD.alpha = 0.9;
  }

  var_1 = self._id_7B46;
  self._id_7B46 = undefined;

  if(!isDefined(var_1._id_4457)) {
    var_1 fadeovertime(var_0);
  }

  var_1.alpha = 0;
  wait(var_0 + 0.1);
  var_1 destroy();
}

_id_D06B(var_0, var_1, var_2) {
  var_3 = _id_D24D(undefined, var_1 - 10, var_2, 1);
  var_3 setshader("white", 125, 20);
  var_3.color = (0.5, 0, 0);
  var_3.alpha = 0.7;
  var_4 = _id_D24D(var_0, var_1 + 125, var_2, 1);
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

_id_6426() {
  return self._id_9DCF["current_menu"]._id_9DCB;
}

_id_65A2() {
  var_0 = _id_6426();
  var_1 = 0;

  if(isDefined(self._id_9DCF["current_menu"]._id_AC4B)) {
    var_1 = self._id_9DCF["current_menu"]._id_AC4B;
  }

  var_2 = self._id_9DBD._id_4190 + var_1 * 14;
  return self._id_9DCF[var_0]._id_AC58[var_2];
}

_id_38F4(var_0) {
  if(isDefined(self._id_A693) && isDefined(self._id_A693[var_0])) {
    if(_func_0107(self._id_A693[var_0])) {
      foreach(var_3, var_2 in self._id_A693[var_0]) {
        self _meth_824C(var_2, var_3);
      }
    }

    self._id_A693[var_0] = [];
  }
}

_id_100A(var_0, var_1, var_2) {
  if(!isDefined(self._id_A693)) {
    self._id_A693 = [];
  }

  if(!isDefined(self._id_A693[var_0])) {
    self._id_A693[var_0] = [];
  }

  if(!isDefined(self._id_A693[var_0][var_1])) {
    self notifyonplayercommand(var_2, var_1);
    self._id_A693[var_0][var_1] = var_2;
  }
}

_id_A663(var_0) {
  self endon("end_hud_menu");
  var_1 = var_0 + "_button_pressed";

  for(;;) {
    var_2 = scripts\engine\utility::_id_10892(self._id_A693[var_0]);
    self notify(var_1, var_2);
    wait 0.05;
  }
}

_id_8060() {
  _id_38F4("menu");
  _id_100A("menu", "-actionslot 1", "dpad_up");
  _id_100A("menu", "-actionslot 2", "dpad_down");
  _id_100A("menu", "-actionslot 3", "dpad_left");
  _id_100A("menu", "-actionslot 4", "dpad_right");
  _id_100A("menu", "+gostand", "button_a");
  _id_100A("menu", "+stance", "button_b");
  _id_100A("menu", "+usereload", "button_x");
  _id_100A("menu", "+smoke", "button_lshldr");
  _id_100A("menu", "+frag", "button_rshldr");
  _id_100A("menu", "+weapprev", "1");
  _id_100A("menu", "+weapnext", "2");
  _id_100A("menu", "killstreak1", "3");
  _id_100A("menu", "killstreak2", "4");
  _id_100A("menu", "killstreak3", "5");
  _id_100A("menu", "killstreak4", "6");
  _id_100A("menu", "inventory_drop", "downarrow");
  _id_100A("menu", "inventory_next", "rightarrow");
  _id_100A("menu", "inventory_previous", "leftarrow");
  _id_100A("menu", "chatmodelastused", "enter");
  _id_100A("menu", "gestureslot5", "end");
  _id_100A("menu", "gestureslot4", "del");
  _id_100A("menu", "gestureslot1", "ins");
  _id_100A("menu", "gestureslot3", "pgup");
  _id_100A("menu", "gestureslot6", "pgdn");
  _id_100A("menu", "changeclass4", "kp_leftarrow");
  _id_100A("menu", "changeclass6", "kp_rightarrow");
  _id_100A("menu", "changeclass2", "kp_downarrow");
  thread _id_A663("menu");
}

_id_7F13() {
  self endon("end_hud_menu");
  _id_8060();
}

_id_80ED() {
  _id_3910("menu");
  _id_106B("menu", "dpad_up");
  _id_106B("menu", "dpad_down");
  _id_106B("menu", "dpad_left");
  _id_106B("menu", "dpad_right");
  _id_106B("menu", "button_a");
  _id_106B("menu", "button_b");
  _id_106B("menu", "button_y");
  _id_106B("menu", "button_x");
  _id_106B("menu", "button_lshldr");
  _id_106B("menu", "button_rshldr");
  _id_106B("menu", "1");
  _id_106B("menu", "2");
  _id_106B("menu", "3");
  _id_106B("menu", "4");
  _id_106B("menu", "5");
  _id_106B("menu", "6");
  _id_106B("menu", "7");
  _id_106B("menu", "8");
  _id_106B("menu", "9");
  _id_106B("menu", "0");
  _id_106B("menu", "downarrow");
  _id_106B("menu", "uparrow");
  _id_106B("menu", "leftarrow");
  _id_106B("menu", "rightarrow");
  _id_106B("menu", "=");
  _id_106B("menu", "-");
  _id_106B("menu", "enter");
  _id_106B("menu", "end");
  _id_106B("menu", "backspace");
  _id_106B("menu", "del");
  _id_106B("menu", "ins");
  _id_106B("menu", "pgup");
  _id_106B("menu", "pgdn");
  _id_106B("menu", "kp_leftarrow");
  _id_106B("menu", "kp_rightarrow");
  _id_106B("menu", "kp_uparrow");
  _id_106B("menu", "kp_downarrow");
  _id_106B("menu", "kp_home");
  _id_106B("menu", "kp_pgup");
  thread _id_F956("menu", undefined, undefined, "button_ltrig");
}

_id_3910(var_0) {
  if(isDefined(self._id_F8E7)) {
    self._id_F8E7[var_0] = [];
  }
}

_id_106B(var_0, var_1) {
  if(!isDefined(self._id_F8E7)) {
    self._id_F8E7 = [];
  }

  if(!isDefined(self._id_F8E7[var_0])) {
    self._id_F8E7[var_0] = [];
  }

  if(_id_1B99(self._id_F8E7[var_0], var_1)) {
    self._id_F8E7[var_0][self._id_F8E7[var_0].size] = var_1;
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

_id_F956(var_0, var_1, var_2, var_3) {
  self endon("end_hud_menu");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_4 = var_0 + "_button_pressed";
  var_5 = self._id_F8E7[var_0];
  self._id_F8E8[var_0] = 0;

  for(;;) {
    if(self._id_F8E8[var_0]) {
      wait 0.05;
      continue;
    }

    if(isDefined(var_2) && !self _meth_805E(var_2)) {
      wait 0.05;
      continue;
    } else if(isDefined(var_3) && self _meth_805E(var_3)) {
      wait 0.05;
      continue;
    }

    if(var_1 && self attackbuttonpressed()) {
      level notify(var_4, "fire");
      wait 0.1;
      continue;
    }

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(self _meth_805E(var_5[var_6])) {
        self notify(var_4, var_5[var_6]);
        wait 0.1;
        break;
      }
    }

    wait 0.05;
  }
}