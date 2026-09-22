/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_hud_util.gsc
***************************************************/

setparent(var_0) {
  if(isDefined(self._id_6E74) && self._id_6E74 == var_0) {
    return;
  }
  if(isDefined(self._id_6E74)) {
    self._id_6E74 _id_7CD5(self);
  }

  self._id_6E74 = var_0;
  self._id_6E74 _id_09A6(self);

  if(isDefined(self._id_7538)) {
    setpoint(self._id_7538, self._id_7C16, self._id_AACD, self._id_AAEB);
  } else {
    setpoint("TOPLEFT");
  }
}

_id_45FC() {
  return self._id_6E74;
}

_id_09A6(var_0) {
  var_0._id_00D4 = self._id_21F6.size;
  self._id_21F6[self._id_21F6.size] = var_0;
}

_id_7CD5(var_0) {
  var_0._id_6E74 = undefined;

  if(self._id_21F6[self._id_21F6.size - 1] != var_0) {
    self._id_21F6[var_0._id_00D4] = self._id_21F6[self._id_21F6.size - 1];
    self._id_21F6[var_0._id_00D4]._id_00D4 = var_0._id_00D4;
  }

  self._id_21F6[self._id_21F6.size - 1] = undefined;
  var_0._id_00D4 = undefined;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = _id_45FC();

  if(var_4) {
    self moveovertime(var_4);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self._id_AACD = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self._id_AAEB = var_3;
  self._id_7538 = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  self._id_7C16 = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }

  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }

  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }

  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }

  if(var_5 == level._id_A012) {
    self._id_00C6 = var_6;
    self._id_01CA = var_7;
  } else {
    self._id_00C6 = var_5._id_00C6;
    self._id_01CA = var_5._id_01CA;
  }

  if(_func_2FF(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5._id_01D2 / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5._id_01D2;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(_func_2FF(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5._id_00BD / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5._id_00BD;

    if(var_7 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self._id_AACD;
  self.y = self.y + self._id_AAEB;

  switch (self._id_35B2) {
    case "bar":
      _id_8708(var_0, var_1, var_2, var_3);
      break;
  }

  _id_A0F5();
}

_id_8708(var_0, var_1, var_2, var_3) {
  self._id_1586._id_00C6 = self._id_00C6;
  self._id_1586._id_01CA = self._id_01CA;
  self._id_1586.alignx = "left";
  self._id_1586.aligny = self.aligny;
  self._id_1586.y = self.y;

  if(self.alignx == "left") {
    self._id_1586.x = self.x;
  } else if(self.alignx == "right") {
    self._id_1586.x = self.x - self._id_01D2;
  } else {
    self._id_1586.x = self.x - int(self._id_01D2 / 2);
  }

  if(self.aligny == "top") {
    self._id_1586.y = self.y;
  } else if(self.aligny == "bottom") {
    self._id_1586.y = self.y;
  }

  _id_A0E3(self._id_1586._id_3E6E);
}

_id_A0E3(var_0, var_1) {
  if(self._id_35B2 == "bar") {
    _id_A0E5(var_0, var_1);
  }
}

_id_A0E5(var_0, var_1) {
  var_2 = int(self._id_01D2 * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }

  self._id_1586._id_3E6E = var_0;
  self._id_1586 setshader(self._id_1586._id_8AC7, var_2, self._id_00BD);

  if(isDefined(var_1) && var_2 < self._id_01D2) {
    if(var_1 > 0) {
      self._id_1586 scaleovertime((1 - var_0) / var_1, self._id_01D2, self._id_00BD);
    } else if(var_1 < 0) {
      self._id_1586 scaleovertime(var_0 / (-1 * var_1), 1, self._id_00BD);
    }
  }

  self._id_1586._id_7A78 = var_1;
  self._id_1586._id_5C09 = gettime();
}

createfontstring(var_0, var_1) {
  var_2 = _newclienthudelem(self);
  var_2._id_35B2 = "font";
  var_2._id_009A = var_0;
  var_2._id_017A = 1;
  var_2.fontscale = var_1;
  var_2._id_15FC = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2._id_01D2 = 0;
  var_2._id_00BD = int(level._id_3DD8 * var_1);
  var_2._id_AACD = 0;
  var_2._id_AAEB = 0;
  var_2._id_21F6 = [];
  var_2 setparent(level._id_A012);
  var_2._id_4CC7 = 0;
  return var_2;
}

_id_2829(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = _newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3._id_35B2 = "font";
  var_3._id_009A = var_0;
  var_3._id_017A = 1;
  var_3.fontscale = var_1;
  var_3._id_15FC = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3._id_01D2 = 0;
  var_3._id_00BD = int(level._id_3DD8 * var_1);
  var_3._id_AACD = 0;
  var_3._id_AAEB = 0;
  var_3._id_21F6 = [];
  var_3 setparent(level._id_A012);
  var_3._id_4CC7 = 0;
  return var_3;
}

_id_282B(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = _newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3._id_35B2 = "timer";
  var_3._id_009A = var_0;
  var_3._id_017A = 1;
  var_3.fontscale = var_1;
  var_3._id_15FC = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3._id_01D2 = 0;
  var_3._id_00BD = int(level._id_3DD8 * var_1);
  var_3._id_AACD = 0;
  var_3._id_AAEB = 0;
  var_3._id_21F6 = [];
  var_3 setparent(level._id_A012);
  var_3._id_4CC7 = 0;
  return var_3;
}

_id_2833(var_0, var_1) {
  var_2 = _newclienthudelem(self);
  var_2._id_35B2 = "timer";
  var_2._id_009A = var_0;
  var_2._id_017A = 1;
  var_2.fontscale = var_1;
  var_2._id_15FC = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2._id_01D2 = 0;
  var_2._id_00BD = int(level._id_3DD8 * var_1);
  var_2._id_AACD = 0;
  var_2._id_AAEB = 0;
  var_2._id_21F6 = [];
  var_2 setparent(level._id_A012);
  var_2._id_4CC7 = 0;
  return var_2;
}

createicon(var_0, var_1, var_2) {
  var_3 = _newclienthudelem(self);
  var_3._id_35B2 = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3._id_01D2 = var_1;
  var_3._id_00BD = var_2;
  var_3._id_1630 = var_3._id_01D2;
  var_3._id_15FD = var_3._id_00BD;
  var_3._id_AACD = 0;
  var_3._id_AAEB = 0;
  var_3._id_21F6 = [];
  var_3 setparent(level._id_A012);
  var_3._id_4CC7 = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3._id_8AC7 = var_0;
  }

  return var_3;
}

_id_282A(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = _newteamhudelem(var_3);
  } else {
    var_4 = newhudelem();
  }

  var_4._id_35B2 = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4._id_01D2 = var_1;
  var_4._id_00BD = var_2;
  var_4._id_1630 = var_4._id_01D2;
  var_4._id_15FD = var_4._id_00BD;
  var_4._id_AACD = 0;
  var_4._id_AAEB = 0;
  var_4._id_21F6 = [];
  var_4 setparent(level._id_A012);
  var_4._id_4CC7 = 0;

  if(isDefined(var_0)) {
    var_4 setshader(var_0, var_1, var_2);
    var_4._id_8AC7 = var_0;
  }

  return var_4;
}

_id_2828(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4)) {
    var_6 = _newteamhudelem(var_4);
  } else {
    var_6 = newhudelem();
  }

  var_6.x = 0;
  var_6.y = 0;
  var_6._id_3E6E = 0;
  var_6.color = var_0;
  var_6.sort = -2;
  var_6._id_8AC7 = "progress_bar_fill";
  var_6 setshader("progress_bar_fill", var_1, var_2);
  var_6._id_4CC7 = 0;

  if(isDefined(var_3)) {
    var_6._id_3D49 = var_3;
  }

  if(isDefined(var_4)) {
    var_7 = _newteamhudelem(var_4);
  } else {
    var_7 = newhudelem();
  }

  var_7._id_35B2 = "bar";
  var_7.x = 0;
  var_7.y = 0;
  var_7._id_01D2 = var_1;
  var_7._id_00BD = var_2;
  var_7._id_AACD = 0;
  var_7._id_AAEB = 0;
  var_7._id_1586 = var_6;
  var_7._id_21F6 = [];
  var_7.sort = -3;
  var_7.color = (0, 0, 0);
  var_7.alpha = 0.5;
  var_7 setparent(level._id_A012);
  var_7 setshader("progress_bar_bg", var_1, var_2);
  var_7._id_4CC7 = 0;
  return var_7;
}

_id_27CF(var_0, var_1, var_2, var_3) {
  var_4 = _newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4._id_3E6E = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4._id_8AC7 = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4._id_4CC7 = 0;

  if(isDefined(var_3)) {
    var_4._id_3D49 = var_3;
  }

  var_5 = _newclienthudelem(self);
  var_5._id_35B2 = "bar";
  var_5._id_01D2 = var_1;
  var_5._id_00BD = var_2;
  var_5._id_AACD = 0;
  var_5._id_AAEB = 0;
  var_5._id_1586 = var_4;
  var_5._id_21F6 = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 setparent(level._id_A012);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5._id_4CC7 = 0;
  return var_5;
}

_id_447D() {
  var_0 = self._id_1586._id_3E6E;

  if(isDefined(self._id_1586._id_7A78)) {
    var_0 = var_0 + (gettime() - self._id_1586._id_5C09) * self._id_1586._id_7A78 / 1000;

    if(var_0 > 1) {
      var_0 = 1;
    }

    if(var_0 < 0) {
      var_0 = 0;
    }
  }

  return var_0;
}

_id_2821(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(self issplitscreenplayer() && !_func_3BA()) {
    var_1 = var_1 + 20;
  }

  if(_func_367()) {
    var_3 = _id_27CF((0.25, 0.58, 0.53), level._id_76FD, level._id_76FA);
  } else {
    var_3 = _id_27CF((1, 1, 1), level._id_76FD, level._id_76FA);
  }

  var_3 setpoint("CENTER", undefined, level._id_76FE + var_0, level._id_76FF + var_1);
  return var_3;
}

_id_2822(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(self issplitscreenplayer() && !_func_3BA()) {
    var_1 = var_1 + 20;
  }

  if(_func_367()) {
    var_2 = createfontstring("mphubfont", 1.4);
  } else {
    var_2 = createfontstring("hudbig", level._id_76F9);
  }

  var_2 setpoint("CENTER", undefined, level._id_76FB + var_0, level._id_76FC + var_1);
  var_2.sort = -1;
  return var_2;
}

_id_2830(var_0) {
  var_1 = _id_2828((1, 0, 0), level._id_9867, level._id_9865, undefined, var_0);
  var_1 setpoint("TOP", undefined, 0, level._id_9868);
  return var_1;
}

_id_2831(var_0) {
  var_1 = _id_2829("default", level._id_9864, var_0);
  var_1 setpoint("TOP", undefined, 0, level._id_9866);
  return var_1;
}

_id_8685(var_0) {
  self._id_1586._id_3D49 = var_0;
}

_id_4D06() {
  if(self._id_4CC7) {
    return;
  }
  self._id_4CC7 = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }

  if(self._id_35B2 == "bar" || self._id_35B2 == "bar_shader") {
    self._id_1586._id_4CC7 = 1;

    if(self._id_1586.alpha != 0) {
      self._id_1586.alpha = 0;
    }
  }
}

_id_8BF6() {
  if(!self._id_4CC7) {
    return;
  }
  self._id_4CC7 = 0;

  if(self._id_35B2 == "bar" || self._id_35B2 == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }

    self._id_1586._id_4CC7 = 0;

    if(self._id_1586.alpha != 1) {
      self._id_1586.alpha = 1;
    }
  } else if(self.alpha != 1)
    self.alpha = 1;
}

_id_3D59() {
  self endon("death");

  if(!self._id_4CC7) {
    self.alpha = 1;
  }

  for(;;) {
    if(self._id_3E6E >= self._id_3D49) {
      if(!self._id_4CC7) {
        self fadeovertime(0.3);
        self.alpha = 0.2;
        wait 0.35;
        self fadeovertime(0.3);
        self.alpha = 1;
      }

      wait 0.7;
      continue;
    }

    if(!self._id_4CC7 && self.alpha != 1) {
      self.alpha = 1;
    }

    waitframe();
  }
}

destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self._id_21F6.size; var_1++) {
    if(isDefined(self._id_21F6[var_1])) {
      var_0[var_0.size] = self._id_21F6[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] setparent(_id_45FC());
  }

  if(self._id_35B2 == "bar" || self._id_35B2 == "bar_shader") {
    self._id_1586 destroy();
  }

  self destroy();
}

_id_86AA(var_0) {
  self setshader(var_0, self._id_01D2, self._id_00BD);
  self._id_8AC7 = var_0;
}

_id_4519(var_0) {
  return self._id_8AC7;
}

_id_86AB(var_0, var_1) {
  self setshader(self._id_8AC7, var_0, var_1);
}

_id_8A69(var_0) {
  self._id_01D2 = var_0;
}

_id_86A1(var_0) {
  self._id_00BD = var_0;
}

_id_8723(var_0, var_1) {
  self._id_01D2 = var_0;
  self._id_00BD = var_1;
}

_id_A0F5() {
  for(var_0 = 0; var_0 < self._id_21F6.size; var_0++) {
    var_1 = self._id_21F6[var_0];
    var_1 setpoint(var_1._id_7538, var_1._id_7C16, var_1._id_AACD, var_1._id_AAEB);
  }
}

_id_9C7F() {
  self.x = self._id_AACD;
  self.y = self._id_AAEB;

  if(self._id_35B2 == "font") {
    self.fontscale = self._id_15FC;
    self.label = &"";
  } else if(self._id_35B2 == "icon")
    self setshader(self._id_8AC7, self._id_01D2, self._id_00BD);

  self.alpha = 0;
}

_id_9C84(var_0) {
  switch (self._id_35B2) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self._id_15FC;
      break;
    case "icon":
      self setshader(self._id_8AC7, self._id_01D2 * 6, self._id_00BD * 6);
      self scaleovertime(var_0, self._id_01D2, self._id_00BD);
      break;
  }
}

_id_9C7E(var_0, var_1) {
  var_2 = int(var_0) * 1000;
  var_3 = int(var_1) * 1000;

  switch (self._id_35B2) {
    case "timer":
    case "font":
      self setpulsefx(var_2 + 250, var_3 + var_2, var_2 + 250);
      break;
    default:
      break;
  }
}

_id_9C81(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  switch (var_1) {
    case "left":
      self.x = self.x + 1000;
      break;
    case "right":
      self.x = self.x - 1000;
      break;
    case "up":
      self.y = self.y - 1000;
      break;
    case "down":
      self.y = self.y + 1000;
      break;
  }

  self moveovertime(var_0);
  self.x = self._id_AACD;
  self.y = self._id_AAEB;
}

_id_9C82(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  var_2 = self._id_AACD;
  var_3 = self._id_AAEB;

  switch (var_1) {
    case "left":
      var_2 = var_2 + 1000;
      break;
    case "right":
      var_2 = var_2 - 1000;
      break;
    case "up":
      var_3 = var_3 - 1000;
      break;
    case "down":
      var_3 = var_3 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_0);
  self.x = var_2;
  self.y = var_3;
}

_id_9C85(var_0) {
  switch (self._id_35B2) {
    case "timer":
    case "font":
      self changefontscaleovertime(var_0);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var_0, self._id_01D2 * 6, self._id_00BD * 6);
      break;
  }
}

_id_9C78(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self._id_6073)) {
    self.alpha = self._id_6073;
  } else {
    self.alpha = 1;
  }
}

_id_9C79(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

_id_5807(var_0) {
  if(issubstr(var_0, "ch_limited")) {
    return 1;
  }

  return 0;
}

_id_5850(var_0) {
  if(common_scripts\utility::_id_9467(var_0, "ch_attach_unlock_kills")) {
    return 1;
  }

  if(common_scripts\utility::_id_9467(var_0, "ch_attach_unlock_hipfirekills")) {
    return 1;
  }

  if(common_scripts\utility::_id_9467(var_0, "ch_attach_unlock_headShots")) {
    return 1;
  }

  return 0;
}

_id_2097(var_0) {
  if(_id_5850(var_0)) {
    return _id_775C(var_0);
  }

  return self getplayerdata(common_scripts\utility::_id_46AE(), "challengeProgress", var_0);
}

_id_2098(var_0) {
  if(_id_5850(var_0)) {
    return _id_775D(var_0);
  } else {
    return self getplayerdata(common_scripts\utility::_id_46AE(), "challengeState", var_0);
  }
}

_id_209E(var_0, var_1) {
  if(_id_5850(var_0)) {
    return;
  }
  var_2 = maps\mp\_utility::_id_2315(var_1);
  self setplayerdata(common_scripts\utility::_id_46AE(), "challengeProgress", var_0, var_2);

  if(issubstr(var_0, "ch_daily_") && var_2 > 0) {
    thread maps\mp\gametypes\_hud_message::_id_9102(var_0, var_2);
  }
}

_id_209F(var_0, var_1) {
  if(_id_5850(var_0)) {
    return;
  } else {
    self setplayerdata(common_scripts\utility::_id_46AE(), "challengeState", var_0, var_1);
  }
}

_id_2099(var_0, var_1) {
  if(issubstr(var_0, "ch_daily")) {
    var_2 = tablelookup("mp/dailyChallengesTable.csv", 0, var_0, 9);
  } else {
    var_2 = tablelookup("mp/allChallengesTable.csv", 0, var_0, 9 + (var_1 - 1) * 2);
  }

  if(isDefined(var_2) && var_2 != "") {
    return int(var_2);
  }

  return 0;
}

_id_3005(var_0, var_1, var_2, var_3) {
  var_4 = createfontstring("hudbig", var_2);
  var_4 setpoint("CENTER", "CENTER", 0, var_1);
  var_4.sort = 1001;
  var_4.color = (1, 1, 1);
  var_4.foreground = 0;
  var_4.hidewheninmenu = 1;
  var_4 settext(var_0);
  common_scripts\utility::_id_A70A(var_3, "joined_team", "death");

  if(isDefined(var_4)) {
    var_4 destroyelem();
  }
}

_id_775C(var_0) {
  if(common_scripts\utility::_id_9467(var_0, "ch_attach_unlock_hipfirekills")) {
    return _id_9AB0(var_0, "hipfirekills");
  } else if(common_scripts\utility::_id_9467(var_0, "ch_attach_unlock_kills")) {
    return _id_9AB0(var_0, "kills");
  } else if(common_scripts\utility::_id_9467(var_0, "ch_attach_unlock_headShots")) {
    return _id_9AB0(var_0, "headShots");
  }
}

_id_775D(var_0) {
  var_1 = _id_775C(var_0);
  var_2 = 1;

  for(var_3 = _id_2099(var_0, var_2); var_3 > 0 && var_1 >= var_3; var_3 = _id_2099(var_0, var_2)) {
    var_2++;
  }

  return var_2;
}

_id_9AB0(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;
  var_4 = strtok(var_0, "_");

  for(var_5 = 0; var_5 < var_4.size - 1; var_5++) {
    if(var_4[var_5] == var_1) {
      var_2 = var_4[var_5 + 1];
      break;
    }
  }

  if(isDefined(var_2)) {
    for(var_6 = _tablelookuprownum("mp/statstable.csv", 28, var_2); var_6 >= 0; var_6 = _tablelookuprownum("mp/statstable.csv", 28, var_2, var_6 - 1)) {
      var_7 = _tablelookupbyrow("mp/statstable.csv", var_6, 2);
      var_3 = var_3 + self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", var_7, var_1);
    }

    if(var_1 == "kills" && isDefined(self._id_9BBA)) {
      var_3 = var_3 + self._id_9BBA;
    }

    if(var_1 == "hipfirekills" && isDefined(self._id_9BB8)) {
      var_3 = var_3 + self._id_9BB8;
    }

    if(var_1 == "headShots" && isDefined(self._id_9BB7)) {
      var_3 = var_3 + self._id_9BB7;
    }

    var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "attachUnlock_" + var_1, var_2);

    if(var_8 > var_3) {
      var_8 = 0;
    }

    return var_3 - var_8;
  }
}

_id_5527() {
  return _func_367() && _func_2C6(getDvar("1673"), "mp_hub_zombies");
}

shoulddohubtutorialflow() {
  return !_id_5527() && !maps\mp\_utility::_id_585F() && getdvarint("mm_hub_tutorial_enabled", 0) == 1;
}