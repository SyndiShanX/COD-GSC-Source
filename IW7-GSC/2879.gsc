/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2879.gsc
**************************************/

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isDefined(self.parent)) {
    self.parent removechild(self);
  }

  self.parent = var_0;
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

addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

removechild(var_0) {
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
  var_6 = "center";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top";
  }

  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom";
  }

  if(issubstr(var_1, "LEFT")) {
    var_6 = "left";
  }

  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right";
  }

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(var_6 == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "left" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5.width;

    if(var_6 == "left") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(var_7 == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_7 == "top") {
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
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  updatechildren(var_4);
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x + self.var_13E1E;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - (self.width - self.var_13E1E);
  } else {
    self.bar.x = self.x - int((self.width - self.var_13E1E * 2) / 2);
  }

  updatebar(self.bar.frac);
}

updatebar(var_0) {
  var_1 = int((self.width - self.var_13E1E * 2) * var_0);

  if(!var_1) {
    var_1 = 1;
  }

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_1, self.height - self.var_13E5D * 2);
}

func_8EB9(var_0) {
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);

  if(var_0 || !isDefined(self.var_C708) || !isDefined(self.bar.var_C708)) {
    self.var_C708 = self.alpha;
    self.bar.var_C708 = self.bar.alpha;
  }

  self.alpha = scripts\engine\utility::ter_op(var_0, 0, self.var_C708);
  self.bar.alpha = scripts\engine\utility::ter_op(var_0, 0, self.bar.var_C708);
}

createfontstring(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  return var_2;
}

func_4999(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  return var_2;
}

func_499D(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  return var_2;
}

func_4A15(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  return var_2;
}

createservertimer(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  return var_2;
}

createicon(var_0, var_1, var_2) {
  var_3 = newhudelem();
  return createicon_hudelem(var_3, var_0, var_1, var_2);
}

func_499B(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  return createicon_hudelem(var_3, var_0, var_1, var_2);
}

createicon_hudelem(var_0, var_1, var_2, var_3) {
  var_0.elemtype = "icon";
  var_0.x = 0;
  var_0.y = 0;
  var_0.width = var_2;
  var_0.height = var_3;
  var_0.xoffset = 0;
  var_0.yoffset = 0;
  var_0.children = [];
  var_0 setparent(level.uiparent);

  if(isDefined(var_1)) {
    var_0 setshader(var_1, var_2, var_3);
  }

  return var_0;
}

createbar(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    var_0 = "white";
  }

  if(!isDefined(var_1)) {
    var_1 = "black";
  }

  if(!isDefined(var_2)) {
    var_2 = 100;
  }

  if(!isDefined(var_3)) {
    var_3 = 9;
  }

  var_5 = newhudelem();
  var_5.x = 2;
  var_5.y = 2;
  var_5.frac = 0.25;
  var_5.shader = var_0;
  var_5.sort = -1;
  var_5 setshader(var_0, var_2 - 2, var_3 - 2);

  if(isDefined(var_4)) {
    var_5.flashfrac = var_4;
    var_5 thread flashthread();
  }

  var_6 = newhudelem();
  var_6.elemtype = "bar";
  var_6.x = 0;
  var_6.y = 0;
  var_6.width = var_2;
  var_6.height = var_3;
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_6.bar = var_5;
  var_6.children = [];
  var_6.var_C85E = 2;
  var_6.sort = -2;
  var_6.alpha = 0.5;
  var_6 setparent(level.uiparent);
  var_6 setshader(var_1, var_2, var_3);
  return var_6;
}

func_499C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.player);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 90);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "white");
  var_3 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, "black");
  var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, 100);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 9);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, 2);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_7), var_7, 2);
  var_8 = var_0 func_4997(var_2, var_3, var_4, var_5, undefined, var_6, var_7);
  var_8 setpoint("CENTER", undefined, 0, var_1);
  return var_8;
}

func_4997(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_5)) {
    var_5 = 2;
  }

  if(!isDefined(var_6)) {
    var_6 = 2;
  }

  var_7 = newclienthudelem(self);
  var_7.x = 0 - var_5;
  var_7.y = 0 - var_6;
  var_7.frac = 0.25;
  var_7.shader = var_0;
  var_7.sort = -1;
  var_7 setshader(var_0, var_2 - var_5 * 2, var_3 - var_6 * 2);

  if(isDefined(var_4)) {
    var_7.flashfrac = var_4;
    var_7 thread flashthread();
  }

  var_8 = newclienthudelem(self);
  var_8.elemtype = "bar";
  var_8.x = 0;
  var_8.y = 0;
  var_8.width = var_2;
  var_8.height = var_3;
  var_8.xoffset = -1 * var_5;
  var_8.yoffset = 0;
  var_8.bar = var_7;
  var_8.children = [];
  var_8.var_13E1E = var_5;
  var_8.var_13E5D = var_6;
  var_8.sort = -2;
  var_8.alpha = 0.5;
  var_8 setparent(level.uiparent);
  var_8 setshader(var_1, var_2, var_3);
  return var_8;
}

setflashfrac(var_0) {
  self.bar.flashfrac = var_0;
}

func_6AAB(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    self fadeovertime(var_1);
  }

  self.alpha = var_0;

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }
}

flashthread() {
  self endon("death");
  self.alpha = 1;

  for(;;) {
    if(self.frac >= self.flashfrac) {
      self fadeovertime(0.3);
      self.alpha = 0.2;
      wait 0.35;
      self fadeovertime(0.3);
      self.alpha = 1;
      wait 0.7;
      continue;
    }

    self.alpha = 1;
    wait 0.05;
  }
}

destroyelem() {
  if(isDefined(self.children) && self.children.size) {
    var_0 = [];

    for(var_1 = 0; var_1 < self.children.size; var_1++) {
      var_0[var_1] = self.children[var_1];
    }

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] setparent(getparent());
    }
  }

  if(isDefined(self.elemtype) && self.elemtype == "bar") {
    self.bar destroy();
  }

  self destroy();
}

seticonshader(var_0) {
  self setshader(var_0, self.width, self.height);
}

func_FB1F(var_0) {
  self.width = var_0;
}

func_F743(var_0) {
  self.height = var_0;
}

setsize(var_0, var_1) {
  self.width = var_0;
  self.height = var_1;
}

updatechildren(var_0) {
  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    var_2 = self.children[var_1];
    var_2 setpoint(var_2.point, var_2.relativepoint, var_2.xoffset, var_2.yoffset, var_0);
  }
}

func_10B56(var_0) {
  if(isDefined(var_0) && var_0 == 0) {
    func_10B55();
    return;
  }

  if(isDefined(level.var_10B54)) {
    level.var_10B54 destroy();
  }

  _setsaveddvar("hud_showStance", "0");
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

  _setsaveddvar("hud_showStance", "1");
}

func_491A() {
  if(level.console) {
    var_0 = createfontstring("default", 1.8);
    var_0 setpoint("CENTER", undefined, -23, 115);
    var_0 give_zap_perk(level.var_1114E["mantle"]);
    var_1 = createicon("hint_mantle", 40, 40);
    var_1 setpoint("CENTER", undefined, 73, 0);
    var_1 setparent(var_0);
  } else {
    var_0 = createfontstring("default", 1.6);
    var_0 setpoint("CENTER", undefined, 0, 115);
    var_0 give_zap_perk(level.var_1114E["mantle"]);
    var_1 = createicon("hint_mantle", 40, 40);
    var_1 setpoint("CENTER", undefined, 0, 30);
    var_1 setparent(var_0);
  }

  var_1.alpha = 0;
  var_0.alpha = 0;
  level.var_9153 = [];
  level.var_9153["text"] = var_0;
  level.var_9153["icon"] = var_1;
}

func_78E6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = undefined;

  if(!level.console) {
    var_4 = -250;
  } else if(!isDefined(var_0)) {
    var_4 = -225;
  } else {
    var_4 = var_0;
  }

  if(var_3) {
    var_4 = var_0;
  }

  if(!isDefined(var_1)) {
    var_5 = 100;
  } else {
    var_5 = var_1;
  }

  if(isDefined(var_2)) {
    var_6 = newclienthudelem(var_2);
  } else {
    var_6 = newhudelem();
  }

  var_6.alignx = "left";
  var_6.aligny = "middle";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.x = var_4;
  var_6.y = var_5;
  var_6.fontscale = 1.6;
  var_6.color = (0.8, 1, 0.8);
  var_6.font = "objective";
  var_6.glowcolor = (0.3, 0.6, 0.3);
  var_6.glowalpha = 1;
  var_6.foreground = 1;
  var_6.hidewheninmenu = 1;
  var_6.hidewhendead = 1;
  return var_6;
}

func_7956(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = undefined;

  if(!level.console) {
    var_4 = -250;
  } else if(!isDefined(var_0)) {
    var_4 = -170;
  } else {
    var_4 = var_0;
  }

  if(var_3) {
    var_4 = var_0;
  }

  if(!isDefined(var_1)) {
    var_5 = 100;
  } else {
    var_5 = var_1;
  }

  if(isDefined(var_2)) {
    var_6 = newclienthudelem(var_2);
  } else {
    var_6 = newhudelem();
  }

  var_6.alignx = "right";
  var_6.aligny = "middle";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.x = var_4;
  var_6.y = var_5;
  var_6.fontscale = 1.6;
  var_6.color = (0.8, 1, 0.8);
  var_6.font = "objective";
  var_6.glowcolor = (0.3, 0.6, 0.3);
  var_6.glowalpha = 1;
  var_6.foreground = 1;
  var_6.hidewheninmenu = 1;
  var_6.hidewhendead = 1;
  return var_6;
}

func_48B7(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = newclienthudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader(var_0, 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_1;
  var_3.foreground = 1;
  return var_3;
}

func_48B8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\sp\utility::func_7B92();
  var_6 = newclienthudelem(var_5);

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_6.x = var_2;
  var_6.y = var_3;
  var_6 setshader(var_0, int(640 * var_4), int(480 * var_4));
  var_6.alignx = "center";
  var_6.aligny = "middle";
  var_6.sort = 1;
  var_6.horzalign = "center";
  var_6.vertalign = "middle";
  var_6.alpha = var_1;
  var_6.foreground = 1;
  return var_6;
}

func_48B9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\sp\utility::func_7B92();
  var_6 = newclienthudelem(var_5);

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_6.x = var_2;
  var_6.y = var_3;
  var_6 setshader(var_0, int(640 * var_4), int(480 * var_4));
  var_6.alignx = "center";
  var_6.aligny = "middle";
  var_6.sort = 1;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = var_1;
  var_6.foreground = 1;
  return var_6;
}

func_6A99(var_0, var_1) {
  if(level.var_B8D0) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 0.3;
  }

  var_2 = func_7B4F(var_1);
  var_2 fadeovertime(var_0);
  var_2.alpha = 0;
  wait(var_0);
}

func_7B4F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "black";
  }

  return func_7B5D(var_0);
}

func_6AA3(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0.3;
  }

  var_2 = func_7B4F(var_1);

  if(var_0 > 0) {
    var_2 fadeovertime(var_0);
  }

  var_2.alpha = 1;
  wait(var_0);
}

func_10CCC(var_0) {
  var_1 = func_7B4F(var_0);
  var_1.alpha = 1;
}

func_7B5D(var_0) {
  if(isPlayer(self)) {
    var_1 = self;
  } else {
    var_1 = level.player;
  }

  if(!isDefined(var_1.var_C7FD)) {
    var_1.var_C7FD = [];
  }

  if(!isDefined(var_1.var_C7FD[var_0])) {
    var_1.var_C7FD[var_0] = func_48B7(var_0, 0, var_1);
  }

  var_1.var_C7FD[var_0].sort = 0;
  var_1.var_C7FD[var_0].foreground = 1;
  return var_1.var_C7FD[var_0];
}