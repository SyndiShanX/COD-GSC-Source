/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2019.gsc
*************************************************/

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isDefined(self.parent)) {
    self.parent _id_C484(self);
  }

  self.parent = var_0;
  self.parent _id_109B(self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  } else {
    setpoint("TOPLEFT");
  }
}

getparent() {
  return self.parent;
}

_id_C48F() {
  if(isDefined(self._id_3579) && self._id_3579 == gettime()) {
    return;
  }
  self._id_3579 = gettime();
  var_0 = [];

  foreach(var_3, var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2.index = var_0.size;
    var_0[var_0.size] = var_2;
  }

  self.children = var_0;
}

_id_109B(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  _id_C48F();
}

_id_C484(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = getparent();

  if(var_4) {
    self moveovertime(var_4);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self.xoffset = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self.yoffset = var_3;
  self.point = var_0;
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

  self.relativepoint = var_1;
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

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(scripts\mp\utility\script::_id_EA63(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5.width;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(scripts\mp\utility\script::_id_EA63(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_7 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      _id_D682(var_0, var_1, var_2, var_3);
      break;
  }

  _id_FC2C();
}

_id_D682(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }

  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }

  _id_FC11(self.bar._id_5F33);
}

_id_FC11(var_0, var_1) {
  if(self.elemtype == "bar") {
    _id_FC12(var_0, var_1);
  }
}

_id_FC12(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }

  self.bar._id_5F33 = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
    }
  }

  self.bar._id_C048 = var_1;
  self.bar._id_90B3 = gettime();
}

createfontstring(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

_id_404A(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "timer";
  var_3.font = var_0;
  var_3.fontscale = var_1;
  var_3._id_22B8 = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

_id_4065(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

createicon(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.elemtype = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = var_1;
  var_3.height = var_2;
  var_3._id_232E = var_3.width;
  var_3._id_22BD = var_3.height;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3.shader = var_0;
  }

  return var_3;
}

_id_3F99(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4._id_5F33 = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3)) {
    var_4._id_5CA4 = var_3;
  }

  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

_id_69A5() {
  var_0 = self.bar._id_5F33;

  if(isDefined(self.bar._id_C048)) {
    var_0 = var_0 + (gettime() - self.bar._id_90B3) * self.bar._id_C048;

    if(var_0 > 1) {
      var_0 = 1;
    }

    if(var_0 < 0) {
      var_0 = 0;
    }
  }

  return var_0;
}

_id_4035(var_0, var_1) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self _meth_81E2()) {
    var_1 = var_1 + 20;
  }

  var_2 = _id_3F99((1, 1, 1), level._id_BCDA, level._id_BCD7);
  var_2 setpoint("CENTER", undefined, level._id_BCDB + var_0, level._id_BCDC + var_1);
  return var_2;
}

_id_4036(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self _meth_81E2()) {
    var_1 = var_1 + 20;
  }

  var_4 = level._id_BCD6;
  var_5 = "default";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = createfontstring(var_5, var_4);
  var_6 setpoint("CENTER", undefined, level._id_BCD8 + var_0, level._id_BCD9 + var_1);
  var_6.sort = -1;
  return var_6;
}

_id_D563(var_0) {
  self.bar._id_5CA4 = var_0;
}

_id_78F5() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
  }
}

_id_DC9A() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }

    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }
  } else if(self.alpha != 1)
    self.alpha = 1;
}

_id_5CD8() {
  self endon("death");

  if(!self.hidden) {
    self.alpha = 1;
  }

  for(;;) {
    if(self._id_5F33 >= self._id_5CA4) {
      if(!self.hidden) {
        self fadeovertime(0.3);
        self.alpha = 0.2;
        wait 0.35;
        self fadeovertime(0.3);
        self.alpha = 1;
      }

      wait 0.7;
      continue;
    }

    if(!self.hidden && self.alpha != 1) {
      self.alpha = 1;
    }

    wait 0.05;
  }
}

destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0[var_0.size] = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] setparent(getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

_id_D5AE(var_0) {
  self setshader(var_0, self.width, self.height);
  self.shader = var_0;
}

_id_6AB1(var_0) {
  return self.shader;
}

_id_D5AF(var_0, var_1) {
  self setshader(self.shader, var_0, var_1);
}

_id_D8EF(var_0) {
  self.width = var_0;
}

_id_D5A3(var_0) {
  self.height = var_0;
}

_id_D6CB(var_0, var_1) {
  self.width = var_0;
  self.height = var_1;
}

_id_FC2C() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

_id_F49C() {
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "font") {
    self.fontscale = self._id_22B8;
    self.label = &"";
  } else if(self.elemtype == "icon")
    self setshader(self.shader, self.width, self.height);

  self.alpha = 0;
}

_id_F4A0(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self._id_22B8;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var_0, self.width, self.height);
      break;
  }
}

_id_F49B(var_0, var_1) {
  var_2 = int(var_0) * 1000;
  var_3 = int(var_1) * 1000;

  switch (self.elemtype) {
    case "timer":
    case "font":
      self setpulsefx(var_2 + 250, var_3 + var_2, var_2 + 250);
      break;
    default:
      break;
  }
}

_id_F49E(var_0, var_1) {
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
  self.x = self.xoffset;
  self.y = self.yoffset;
}

_id_F49F(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  var_2 = self.xoffset;
  var_3 = self.yoffset;

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

_id_F4A1(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(var_0);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var_0, self.width * 6, self.height * 6);
      break;
  }
}

_id_F494(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self._id_9C52)) {
    self.alpha = self._id_9C52;
  } else {
    self.alpha = 1;
  }
}

_id_F495(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

_id_EF8D(var_0, var_1, var_2, var_3, var_4) {
  if(level._id_74C4) {
    return;
  }
  if(!_id_31D7(var_0)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_88FD()) {
    var_5 = scripts\mp\utility\teams::_id_6DCA(var_1.team, "players");

    if(isDefined(var_5)) {
      foreach(var_7 in var_5) {
        if(!isDefined(var_7) || !scripts\mp\utility\player::isreallyalive(var_7) || var_7 scripts\mp\gametypes\br_public::_id_8990()) {
          continue;
        }
        if(!istrue(var_4)) {
          var_7 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
        }
      }

      return;
    }
  } else {
    foreach(var_7 in level.players) {
      if(var_7 _meth_81D3()) {
        var_10 = var_7 getspectatingplayer();

        if(isDefined(var_10) && isDefined(var_2) && var_10.team != var_2) {
          continue;
        }
      } else {
        if(isDefined(var_2) && var_7.team != var_2) {
          continue;
        }
        if(!isPlayer(var_7)) {
          continue;
        }
      }

      if(!isDefined(var_4)) {
        var_7 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
      }
    }
  }
}

_id_88ED(var_0) {
  var_1 = 0;

  if(issubstr(var_0, "used_")) {
    var_2 = strtok(var_0, "_");
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(var_5 == "used") {
        continue;
      }
      if(!isDefined(var_3)) {
        var_3 = var_5;
        continue;
      }

      var_3 = var_3 + "_" + var_5;
    }

    if(isDefined(var_3) && isDefined(level._id_8DD5._id_EA18._id_EC74[var_3])) {
      var_1 = 1;
    }
  }

  return var_1;
}

_id_883E(var_0) {
  return issubstr(var_0, "callout_");
}

_id_68FD(var_0) {
  var_1 = undefined;
  var_2 = strtok(var_0, "_");

  foreach(var_4 in var_2) {
    if(var_4 == "callout") {
      continue;
    }
    if(!isDefined(var_1)) {
      var_1 = var_4;
      continue;
    }

    var_1 = var_1 + "_" + var_4;
  }

  return var_1;
}

_id_31D7(var_0) {
  var_1 = 1;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    if(_id_88ED(var_0)) {
      var_1 = 0;
    } else if(_id_883E(var_0)) {
      var_2 = _id_68FD(var_0);

      switch (var_2) {
        case "3xkill":
        case "4xkill":
        case "6xkill":
        case "9xkill":
        case "5xkill":
        case "7xkill":
        case "8xkill":
        case "firstblood":
          var_1 = 0;
          break;
      }
    }
  } else if(scripts\mp\utility\game::getgametype() == "br") {
    if(_id_883E(var_0)) {
      var_2 = _id_68FD(var_0);

      switch (var_2) {
        case "3xkill":
        case "4xkill":
        case "6xkill":
        case "9xkill":
        case "5xkill":
        case "7xkill":
        case "8xkill":
        case "firstblood":
          var_1 = 0;
          break;
      }
    }
  }

  return var_1;
}