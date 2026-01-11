/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2753.gsc
***************************************/

setparent(var_00) {
  if(isDefined(self.parent) && self.parent == var_00) {
    return;
  }
  if(isDefined(self.parent)) {
    self.parent removechild(self);
  }

  self.parent = var_00;
  self.parent addchild(self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  } else {
    setpoint("TOPLEFT");
  }
}

getparent() {
  return self.parent;
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  var_00 = [];

  foreach(var_03, var_02 in self.children) {
    if(!isDefined(var_02)) {
      continue;
    }
    var_2.index = var_0.size;
    var_0[var_0.size] = var_02;
  }

  self.children = var_00;
}

addchild(var_00) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_00;
  removedestroyedchildren();
}

removechild(var_00) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_00) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

setpoint(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04)) {
    var_04 = 0;
  }

  var_05 = getparent();

  if(var_04) {
    self moveovertime(var_04);
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  self.xoffset = var_02;

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  self.yoffset = var_03;
  self.point = var_00;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_00, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var_00, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var_00, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var_00, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var_01)) {
    var_01 = var_00;
  }

  self.relativepoint = var_01;
  var_06 = "center_adjustable";
  var_07 = "middle";

  if(issubstr(var_01, "TOP")) {
    var_07 = "top_adjustable";
  }

  if(issubstr(var_01, "BOTTOM")) {
    var_07 = "bottom_adjustable";
  }

  if(issubstr(var_01, "LEFT")) {
    var_06 = "left_adjustable";
  }

  if(issubstr(var_01, "RIGHT")) {
    var_06 = "right_adjustable";
  }

  if(var_05 == level.uiparent) {
    self.horzalign = var_06;
    self.vertalign = var_07;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(scripts\mp\utility\game::strip_suffix(var_06, "_adjustable") == var_5.alignx) {
    var_08 = 0;
    var_09 = 0;
  } else if(var_06 == "center" || var_5.alignx == "center") {
    var_08 = int(var_5.width / 2);

    if(var_06 == "left_adjustable" || var_5.alignx == "right") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  } else {
    var_08 = var_5.width;

    if(var_06 == "left_adjustable") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  }

  self.x = var_5.x + var_08 * var_09;

  if(scripts\mp\utility\game::strip_suffix(var_07, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_07 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_07 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_07 == "top_adjustable") {
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
      setpointbar(var_00, var_01, var_02, var_03);
      break;
  }

  updatechildren();
}

setpointbar(var_00, var_01, var_02, var_03) {
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

  updatebar(self.bar.frac);
}

updatebar(var_00, var_01) {
  if(self.elemtype == "bar") {
    updatebarscale(var_00, var_01);
  }
}

updatebarscale(var_00, var_01) {
  var_02 = int(self.width * var_00 + 0.5);

  if(!var_02) {
    var_02 = 1;
  }

  self.bar.frac = var_00;
  self.bar setshader(self.bar.shader, var_02, self.height);

  if(isDefined(var_01) && var_02 < self.width) {
    if(var_01 > 0) {
      self.bar scaleovertime((1 - var_00) / var_01, self.width, self.height);
    } else if(var_01 < 0) {
      self.bar scaleovertime(var_00 / (-1 * var_01), 1, self.height);
    }
  }

  self.bar.rateofchange = var_01;
  self.bar.lastupdatetime = gettime();
}

createfontstring(var_00, var_01) {
  var_02 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.basefontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_02;
}

func_4A15(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    var_03 = newteamhudelem(var_02);
  } else {
    var_03 = newhudelem();
  }

  var_3.elemtype = "font";
  var_3.font = var_00;
  var_3.fontscale = var_01;
  var_3.basefontscale = var_01;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_01);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_03 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_03;
}

createservertimer(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    var_03 = newteamhudelem(var_02);
  } else {
    var_03 = newhudelem();
  }

  var_3.elemtype = "timer";
  var_3.font = var_00;
  var_3.fontscale = var_01;
  var_3.basefontscale = var_01;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_01);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_03 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_03;
}

createtimer(var_00, var_01) {
  var_02 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.basefontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_02;
}

createicon(var_00, var_01, var_02) {
  var_03 = newclienthudelem(self);
  var_3.elemtype = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = var_01;
  var_3.height = var_02;
  var_3.basewidth = var_3.width;
  var_3.baseheight = var_3.height;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_03 setparent(level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_00)) {
    var_03 setshader(var_00, var_01, var_02);
    var_3.shader = var_00;
  }

  return var_03;
}

func_4A16(var_00, var_01, var_02, var_03) {
  if(isDefined(var_03)) {
    var_04 = newteamhudelem(var_03);
  } else {
    var_04 = newhudelem();
  }

  var_4.elemtype = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4.width = var_01;
  var_4.height = var_02;
  var_4.basewidth = var_4.width;
  var_4.baseheight = var_4.height;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  var_04 setparent(level.uiparent);
  var_4.hidden = 0;

  if(isDefined(var_00)) {
    var_04 setshader(var_00, var_01, var_02);
    var_4.shader = var_00;
  }

  return var_04;
}

func_4A14(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_04)) {
    var_06 = newteamhudelem(var_04);
  } else {
    var_06 = newhudelem();
  }

  var_6.x = 0;
  var_6.y = 0;
  var_6.frac = 0;
  var_6.color = var_00;
  var_6.sort = -2;
  var_6.shader = "progress_bar_fill";
  var_06 setshader("progress_bar_fill", var_01, var_02);
  var_6.hidden = 0;

  if(isDefined(var_03)) {
    var_6.flashfrac = var_03;
  }

  if(isDefined(var_04)) {
    var_07 = newteamhudelem(var_04);
  } else {
    var_07 = newhudelem();
  }

  var_7.elemtype = "bar";
  var_7.x = 0;
  var_7.y = 0;
  var_7.width = var_01;
  var_7.height = var_02;
  var_7.xoffset = 0;
  var_7.yoffset = 0;
  var_7.bar = var_06;
  var_7.children = [];
  var_7.sort = -3;
  var_7.color = (0, 0, 0);
  var_7.alpha = 0.5;
  var_07 setparent(level.uiparent);
  var_07 setshader("progress_bar_bg", var_01, var_02);
  var_7.hidden = 0;
  return var_07;
}

createbar(var_00, var_01, var_02, var_03) {
  var_04 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_00;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_04 setshader("progress_bar_fill", var_01, var_02);
  var_4.hidden = 0;

  if(isDefined(var_03)) {
    var_4.flashfrac = var_03;
  }

  var_05 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_01;
  var_5.height = var_02;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_04;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_05 setparent(level.uiparent);
  var_05 setshader("progress_bar_bg", var_01 + 4, var_02 + 4);
  var_5.hidden = 0;
  return var_05;
}

getcurrentfraction() {
  var_00 = self.bar.frac;

  if(isDefined(self.bar.rateofchange)) {
    var_00 = var_00 + (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;

    if(var_00 > 1) {
      var_00 = 1;
    }

    if(var_00 < 0) {
      var_00 = 0;
    }
  }

  return var_00;
}

createprimaryprogressbar(var_00, var_01) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_00)) {
    var_00 = 0;
  }

  if(!isDefined(var_01)) {
    var_01 = -25;
  }

  if(self issplitscreenplayer()) {
    var_01 = var_01 + 20;
  }

  var_02 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  var_02 setpoint("CENTER", undefined, level.primaryprogressbarx + var_00, level.primaryprogressbary + var_01);
  return var_02;
}

createprimaryprogressbartext(var_00, var_01, var_02, var_03) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_00)) {
    var_00 = 0;
  }

  if(!isDefined(var_01)) {
    var_01 = -25;
  }

  if(self issplitscreenplayer()) {
    var_01 = var_01 + 20;
  }

  var_04 = level.primaryprogressbarfontsize;
  var_05 = "default";

  if(isDefined(var_02)) {
    var_04 = var_02;
  }

  if(isDefined(var_03)) {
    var_05 = var_03;
  }

  var_06 = createfontstring(var_05, var_04);
  var_06 setpoint("CENTER", undefined, level.primaryprogressbartextx + var_00, level.primaryprogressbartexty + var_01);
  var_6.sort = -1;
  return var_06;
}

func_4A24(var_00) {
  var_01 = func_4A14((1, 0, 0), level.func_115E3, level.func_115E1, undefined, var_00);
  var_01 setpoint("TOP", undefined, 0, level.func_115E4);
  return var_01;
}

func_4A25(var_00) {
  var_01 = func_4A15("default", level.func_115E0, var_00);
  var_01 setpoint("TOP", undefined, 0, level.func_115E2);
  return var_01;
}

setflashfrac(var_00) {
  self.bar.flashfrac = var_00;
}

hideelem() {
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

showelem() {
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

flashthread() {
  self endon("death");

  if(!self.hidden) {
    self.alpha = 1;
  }

  for(;;) {
    if(self.frac >= self.flashfrac) {
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
  var_00 = [];

  for(var_01 = 0; var_01 < self.children.size; var_1++) {
    if(isDefined(self.children[var_01])) {
      var_0[var_0.size] = self.children[var_01];
    }
  }

  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    var_0[var_01] setparent(getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

seticonshader(var_00) {
  self setshader(var_00, self.width, self.height);
  self.shader = var_00;
}

func_7F0B(var_00) {
  return self.shader;
}

seticonsize(var_00, var_01) {
  self setshader(self.shader, var_00, var_01);
}

func_FB1F(var_00) {
  self.width = var_00;
}

func_F743(var_00) {
  self.height = var_00;
}

setsize(var_00, var_01) {
  self.width = var_00;
  self.height = var_01;
}

updatechildren() {
  for(var_00 = 0; var_00 < self.children.size; var_0++) {
    var_01 = self.children[var_00];
    var_01 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

transitionreset() {
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "font") {
    self.fontscale = self.basefontscale;
    self.label = &"";
  } else if(self.elemtype == "icon")
    self setshader(self.shader, self.width, self.height);

  self.alpha = 0;
}

transitionzoomin(var_00) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_00);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var_00, self.width, self.height);
      break;
  }
}

transitionpulsefxin(var_00, var_01) {
  var_02 = int(var_00) * 1000;
  var_03 = int(var_01) * 1000;

  switch (self.elemtype) {
    case "timer":
    case "font":
      self setpulsefx(var_02 + 250, var_03 + var_02, var_02 + 250);
      break;
    default:
      break;
  }
}

transitionslidein(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = "left";
  }

  switch (var_01) {
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

  self moveovertime(var_00);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = "left";
  }

  var_02 = self.xoffset;
  var_03 = self.yoffset;

  switch (var_01) {
    case "left":
      var_02 = var_02 + 1000;
      break;
    case "right":
      var_02 = var_02 - 1000;
      break;
    case "up":
      var_03 = var_03 - 1000;
      break;
    case "down":
      var_03 = var_03 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_00);
  self.x = var_02;
  self.y = var_03;
}

transitionzoomout(var_00) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(var_00);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var_00, self.width * 6, self.height * 6);
      break;
  }
}

transitionfadein(var_00) {
  self fadeovertime(var_00);

  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
  } else {
    self.alpha = 1;
  }
}

transitionfadeout(var_00) {
  self fadeovertime(0.15);
  self.alpha = 0;
}