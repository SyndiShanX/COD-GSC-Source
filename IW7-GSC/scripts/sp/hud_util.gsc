/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\hud_util.gsc
***********************************/

setparent(param_00) {
  if(isDefined(self.parent) && self.parent == param_00) {
    return;
  }

  if(isDefined(self.parent)) {
    self.parent removechild(self);
  }

  self.parent = param_00;
  self.parent addchild(self);
  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  setpoint("TOPLEFT");
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
  foreach(var_02 in self.children) {
    if(!isDefined(var_02)) {
      continue;
    }

    var_02.index = var_00.size;
    var_00[var_00.size] = var_02;
  }

  self.children = var_00;
}

addchild(param_00) {
  param_00.index = self.children.size;
  self.children[self.children.size] = param_00;
  removedestroyedchildren();
}

removechild(param_00) {
  param_00.parent = undefined;
  if(self.children[self.children.size - 1] != param_00) {
    self.children[param_00.index] = self.children[self.children.size - 1];
    self.children[param_00.index].index = param_00.index;
  }

  self.children[self.children.size - 1] = undefined;
  param_00.index = undefined;
}

setpoint(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  var_05 = getparent();
  if(param_04) {
    self moveovertime(param_04);
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  self.xoffset = param_02;
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  self.yoffset = param_03;
  self.point = param_00;
  self.alignx = "center";
  self.aligny = "middle";
  if(issubstr(param_00, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(param_00, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(param_00, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(param_00, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(param_01)) {
    param_01 = param_00;
  }

  self.relativepoint = param_01;
  var_06 = "center";
  var_07 = "middle";
  if(issubstr(param_01, "TOP")) {
    var_07 = "top";
  }

  if(issubstr(param_01, "BOTTOM")) {
    var_07 = "bottom";
  }

  if(issubstr(param_01, "LEFT")) {
    var_06 = "left";
  }

  if(issubstr(param_01, "RIGHT")) {
    var_06 = "right";
  }

  if(var_05 == level.uiparent) {
    self.horzalign = var_06;
    self.vertalign = var_07;
  } else {
    self.horzalign = var_05.horzalign;
    self.vertalign = var_05.vertalign;
  }

  if(var_06 == var_05.alignx) {
    var_08 = 0;
    var_09 = 0;
  } else if(var_08 == "center" || var_07.alignx == "center") {
    var_08 = int(var_07.width / 2);
    if(var_07 == "left" || var_06.alignx == "right") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  } else {
    var_08 = var_07.width;
    if(var_07 == "left") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  }

  self.x = var_05.x + var_08 * var_09;
  if(var_07 == var_05.aligny) {
    var_0A = 0;
    var_0B = 0;
  } else if(var_09 == "middle" || var_07.aligny == "middle") {
    var_0A = int(var_07.height / 2);
    if(var_08 == "top" || var_06.aligny == "bottom") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  } else {
    var_0A = var_07.height;
    if(var_08 == "top") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  }

  self.y = var_05.y + var_0A * var_0B;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;
  switch (self.elemtype) {
    case "bar":
      setpointbar(param_00, param_01, param_02, param_03);
      break;
  }

  updatechildren(param_04);
}

setpointbar(param_00, param_01, param_02, param_03) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;
  if(self.alignx == "left") {
    self.bar.x = self.x + self.var_13E1E;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width - self.var_13E1E;
  } else {
    self.bar.x = self.x - int(self.width - self.var_13E1E * 2 / 2);
  }

  updatebar(self.bar.frac);
}

updatebar(param_00) {
  var_01 = int(self.width - self.var_13E1E * 2 * param_00);
  if(!var_01) {
    var_01 = 1;
  }

  self.bar.frac = param_00;
  self.bar setshader(self.bar.shader, var_01, self.height - self.var_13E5D * 2);
}

func_8EB9(param_00) {
  param_00 = scripts\engine\utility::ter_op(isDefined(param_00), param_00, 1);
  if(param_00 || !isDefined(self.var_C708) || !isDefined(self.bar.var_C708)) {
    self.var_C708 = self.alpha;
    self.bar.var_C708 = self.bar.alpha;
  }

  self.alpha = scripts\engine\utility::ter_op(param_00, 0, self.var_C708);
  self.bar.alpha = scripts\engine\utility::ter_op(param_00, 0, self.bar.var_C708);
}

createfontstring(param_00, param_01) {
  var_02 = newhudelem();
  var_02.elemtype = "font";
  var_02.font = param_00;
  var_02.fontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

func_4999(param_00, param_01) {
  var_02 = newclienthudelem(self);
  var_02.elemtype = "font";
  var_02.font = param_00;
  var_02.fontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

func_499D(param_00, param_01) {
  var_02 = newclienthudelem(self);
  var_02.elemtype = "timer";
  var_02.font = param_00;
  var_02.fontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

createserverfontstring(param_00, param_01) {
  var_02 = newhudelem();
  var_02.elemtype = "font";
  var_02.font = param_00;
  var_02.fontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

createservertimer(param_00, param_01) {
  var_02 = newhudelem();
  var_02.elemtype = "timer";
  var_02.font = param_00;
  var_02.fontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

createicon(param_00, param_01, param_02) {
  var_03 = newhudelem();
  return createicon_hudelem(var_03, param_00, param_01, param_02);
}

func_499B(param_00, param_01, param_02) {
  var_03 = newclienthudelem(self);
  return createicon_hudelem(var_03, param_00, param_01, param_02);
}

createicon_hudelem(param_00, param_01, param_02, param_03) {
  param_00.elemtype = "icon";
  param_00.x = 0;
  param_00.y = 0;
  param_00.width = param_02;
  param_00.height = param_03;
  param_00.xoffset = 0;
  param_00.yoffset = 0;
  param_00.children = [];
  param_00 setparent(level.uiparent);
  if(isDefined(param_01)) {
    param_00 setshader(param_01, param_02, param_03);
  }

  return param_00;
}

createbar(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_00)) {
    param_00 = "white";
  }

  if(!isDefined(param_01)) {
    param_01 = "black";
  }

  if(!isDefined(param_02)) {
    param_02 = 100;
  }

  if(!isDefined(param_03)) {
    param_03 = 9;
  }

  var_05 = newhudelem();
  var_05.x = 2;
  var_05.y = 2;
  var_05.frac = 0.25;
  var_05.shader = param_00;
  var_05.sort = -1;
  var_05 setshader(param_00, param_02 - 2, param_03 - 2);
  if(isDefined(param_04)) {
    var_05.flashfrac = param_04;
    var_05 thread flashthread();
  }

  var_06 = newhudelem();
  var_06.elemtype = "bar";
  var_06.x = 0;
  var_06.y = 0;
  var_06.width = param_02;
  var_06.height = param_03;
  var_06.xoffset = 0;
  var_06.yoffset = 0;
  var_06.bar = var_05;
  var_06.children = [];
  var_06.var_C85E = 2;
  var_06.sort = -2;
  var_06.alpha = 0.5;
  var_06 setparent(level.uiparent);
  var_06 setshader(param_01, param_02, param_03);
  return var_06;
}

func_499C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  param_00 = scripts\engine\utility::ter_op(isDefined(param_00), param_00, level.player);
  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 90);
  param_02 = scripts\engine\utility::ter_op(isDefined(param_02), param_02, "white");
  param_03 = scripts\engine\utility::ter_op(isDefined(param_03), param_03, "black");
  param_04 = scripts\engine\utility::ter_op(isDefined(param_04), param_04, 100);
  param_05 = scripts\engine\utility::ter_op(isDefined(param_05), param_05, 9);
  param_06 = scripts\engine\utility::ter_op(isDefined(param_06), param_06, 2);
  param_07 = scripts\engine\utility::ter_op(isDefined(param_07), param_07, 2);
  var_08 = param_00 func_4997(param_02, param_03, param_04, param_05, undefined, param_06, param_07);
  var_08 setpoint("CENTER", undefined, 0, param_01);
  return var_08;
}

func_4997(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_05)) {
    param_05 = 2;
  }

  if(!isDefined(param_06)) {
    param_06 = 2;
  }

  var_07 = newclienthudelem(self);
  var_07.x = 0 - param_05;
  var_07.y = 0 - param_06;
  var_07.frac = 0.25;
  var_07.shader = param_00;
  var_07.sort = -1;
  var_07 setshader(param_00, param_02 - param_05 * 2, param_03 - param_06 * 2);
  if(isDefined(param_04)) {
    var_07.flashfrac = param_04;
    var_07 thread flashthread();
  }

  var_08 = newclienthudelem(self);
  var_08.elemtype = "bar";
  var_08.x = 0;
  var_08.y = 0;
  var_08.width = param_02;
  var_08.height = param_03;
  var_08.xoffset = -1 * param_05;
  var_08.yoffset = 0;
  var_08.bar = var_07;
  var_08.children = [];
  var_08.var_13E1E = param_05;
  var_08.var_13E5D = param_06;
  var_08.sort = -2;
  var_08.alpha = 0.5;
  var_08 setparent(level.uiparent);
  var_08 setshader(param_01, param_02, param_03);
  return var_08;
}

setflashfrac(param_00) {
  self.bar.flashfrac = param_00;
}

func_6AAB(param_00, param_01) {
  if(isDefined(param_01) && param_01 > 0) {
    self fadeovertime(param_01);
  }

  self.alpha = param_00;
  if(isDefined(param_01) && param_01 > 0) {
    wait(param_01);
  }
}

flashthread() {
  self endon("death");
  self.alpha = 1;
  for(;;) {
    if(self.frac >= self.flashfrac) {
      self fadeovertime(0.3);
      self.alpha = 0.2;
      wait(0.35);
      self fadeovertime(0.3);
      self.alpha = 1;
      wait(0.7);
      continue;
    }

    self.alpha = 1;
    wait(0.05);
  }
}

destroyelem() {
  if(isDefined(self.children) && self.children.size) {
    var_00 = [];
    for(var_01 = 0; var_01 < self.children.size; var_01++) {
      var_00[var_01] = self.children[var_01];
    }

    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      var_00[var_01] setparent(getparent());
    }
  }

  if(isDefined(self.elemtype) && self.elemtype == "bar") {
    self.bar destroy();
  }

  self destroy();
}

seticonshader(param_00) {
  self setshader(param_00, self.width, self.height);
}

setwidth(param_00) {
  self.width = param_00;
}

setheight(param_00) {
  self.height = param_00;
}

setsize(param_00, param_01) {
  self.width = param_00;
  self.height = param_01;
}

updatechildren(param_00) {
  for(var_01 = 0; var_01 < self.children.size; var_01++) {
    var_02 = self.children[var_01];
    var_02 setpoint(var_02.point, var_02.relativepoint, var_02.xoffset, var_02.yoffset, param_00);
  }
}

func_10B56(param_00) {
  if(isDefined(param_00) && param_00 == 0) {
    func_10B55();
    return;
  }

  if(isDefined(level.var_10B54)) {
    level.var_10B54 destroy();
  }

  setsaveddvar("hud_showStance", "0");
  level.var_10B54 = newhudelem();
  level.var_10B54.x = -75;
  if(level.console) {
    level.var_10B54.y = -20;
  } else {
    level.var_10B54.y = -10;
  }

  level.var_10B54 setshader("stance_carry", 64, 64);
  level.var_10B54.alignx = "right";
  level.var_10B54.aligny = "bottom";
  level.var_10B54.horzalign = "right";
  level.var_10B54.vertalign = "bottom";
  level.var_10B54.foreground = 1;
  level.var_10B54.alpha = 0;
  level.var_10B54 fadeovertime(0.5);
  level.var_10B54.alpha = 1;
}

func_10B55() {
  if(isDefined(level.var_10B54)) {
    level.var_10B54 fadeovertime(0.5);
    level.var_10B54.alpha = 0;
    level.var_10B54 destroy();
  }

  setsaveddvar("hud_showStance", "1");
}

func_491A() {
  if(level.console) {
    var_00 = createfontstring("default", 1.8);
    var_00 setpoint("CENTER", undefined, -23, 115);
    var_00 settext(level.var_1114E["mantle"]);
    var_01 = createicon("hint_mantle", 40, 40);
    var_01 setpoint("CENTER", undefined, 73, 0);
    var_01 setparent(var_00);
  } else {
    var_00 = createfontstring("default", 1.6);
    var_01 setpoint("CENTER", undefined, 0, 115);
    var_01 settext(level.var_1114E["mantle"]);
    var_01 = createicon("hint_mantle", 40, 40);
    var_01 setpoint("CENTER", undefined, 0, 30);
    var_01 setparent(var_00);
  }

  var_01.alpha = 0;
  var_00.alpha = 0;
  level.var_9153 = [];
  level.var_9153["text"] = var_00;
  level.var_9153["icon"] = var_01;
}

func_78E6(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = undefined;
  if(!level.console) {
    var_04 = -250;
  } else if(!isDefined(param_00)) {
    var_04 = -225;
  } else {
    var_04 = param_00;
  }

  if(param_03) {
    var_04 = param_00;
  }

  if(!isDefined(param_01)) {
    var_05 = 100;
  } else {
    var_05 = param_02;
  }

  if(isDefined(param_02)) {
    var_06 = newclienthudelem(param_02);
  } else {
    var_06 = newhudelem();
  }

  var_06.alignx = "left";
  var_06.aligny = "middle";
  var_06.horzalign = "right";
  var_06.vertalign = "top";
  var_06.x = var_04;
  var_06.y = var_05;
  var_06.fontscale = 1.6;
  var_06.color = (0.8, 1, 0.8);
  var_06.font = "objective";
  var_06.objective_delete = (0.3, 0.6, 0.3);
  var_06.objective_current_nomessage = 1;
  var_06.foreground = 1;
  var_06.hidewheninmenu = 1;
  var_06.playrumblelooponposition = 1;
  return var_06;
}

func_7956(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = undefined;
  if(!level.console) {
    var_04 = -250;
  } else if(!isDefined(param_00)) {
    var_04 = -170;
  } else {
    var_04 = param_00;
  }

  if(param_03) {
    var_04 = param_00;
  }

  if(!isDefined(param_01)) {
    var_05 = 100;
  } else {
    var_05 = param_02;
  }

  if(isDefined(param_02)) {
    var_06 = newclienthudelem(param_02);
  } else {
    var_06 = newhudelem();
  }

  var_06.alignx = "right";
  var_06.aligny = "middle";
  var_06.horzalign = "right";
  var_06.vertalign = "top";
  var_06.x = var_04;
  var_06.y = var_05;
  var_06.fontscale = 1.6;
  var_06.color = (0.8, 1, 0.8);
  var_06.font = "objective";
  var_06.objective_delete = (0.3, 0.6, 0.3);
  var_06.objective_current_nomessage = 1;
  var_06.foreground = 1;
  var_06.hidewheninmenu = 1;
  var_06.playrumblelooponposition = 1;
  return var_06;
}

func_48B7(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = newclienthudelem(param_02);
  } else {
    var_03 = newhudelem();
  }

  var_03.x = 0;
  var_03.y = 0;
  var_03 setshader(param_00, 640, 480);
  var_03.alignx = "left";
  var_03.aligny = "top";
  var_03.sort = 1;
  var_03.horzalign = "fullscreen";
  var_03.vertalign = "fullscreen";
  var_03.alpha = param_01;
  var_03.foreground = 1;
  return var_03;
}

func_48B8(param_00, param_01, param_02, param_03, param_04) {
  var_05 = scripts\sp\utility::func_7B92();
  var_06 = newclienthudelem(var_05);
  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_06.x = param_02;
  var_06.y = param_03;
  var_06 setshader(param_00, int(640 * param_04), int(480 * param_04));
  var_06.alignx = "center";
  var_06.aligny = "middle";
  var_06.sort = 1;
  var_06.horzalign = "center";
  var_06.vertalign = "middle";
  var_06.alpha = param_01;
  var_06.foreground = 1;
  return var_06;
}

func_48B9(param_00, param_01, param_02, param_03, param_04) {
  var_05 = scripts\sp\utility::func_7B92();
  var_06 = newclienthudelem(var_05);
  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  var_06.x = param_02;
  var_06.y = param_03;
  var_06 setshader(param_00, int(640 * param_04), int(480 * param_04));
  var_06.alignx = "center";
  var_06.aligny = "middle";
  var_06.sort = 1;
  var_06.horzalign = "fullscreen";
  var_06.vertalign = "fullscreen";
  var_06.alpha = param_01;
  var_06.foreground = 1;
  return var_06;
}

func_6A99(param_00, param_01) {
  if(level.var_B8D0) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = 0.3;
  }

  var_02 = func_7B4F(param_01);
  var_02 fadeovertime(param_00);
  var_02.alpha = 0;
  wait(param_00);
}

func_7B4F(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "black";
  }

  return func_7B5D(param_00);
}

func_6AA3(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0.3;
  }

  var_02 = func_7B4F(param_01);
  if(param_00 > 0) {
    var_02 fadeovertime(param_00);
  }

  var_02.alpha = 1;
  wait(param_00);
}

func_10CCC(param_00) {
  var_01 = func_7B4F(param_00);
  var_01.alpha = 1;
}

func_7B5D(param_00) {
  if(isplayer(self)) {
    var_01 = self;
  } else {
    var_01 = level.player;
  }

  if(!isDefined(var_01.var_C7FD)) {
    var_01.var_C7FD = [];
  }

  if(!isDefined(var_01.var_C7FD[param_00])) {
    var_01.var_C7FD[param_00] = func_48B7(param_00, 0, var_01);
  }

  var_01.var_C7FD[param_00].sort = 0;
  var_01.var_C7FD[param_00].foreground = 1;
  return var_01.var_C7FD[param_00];
}