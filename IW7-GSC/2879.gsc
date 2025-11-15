/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2879.gsc
***************************************/

setparent(var_00) {
  if(isDefined(self.parent) && self.parent == var_00) {
    return;
  }
  if(isDefined(self.parent))
    self.parent removechild(self);

  self.parent = var_00;
  self.parent addchild(self);

  if(isDefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
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
  if(!isDefined(var_04))
    var_04 = 0;

  var_05 = getparent();

  if(var_04)
    self moveovertime(var_04);

  if(!isDefined(var_02))
    var_02 = 0;

  self.xoffset = var_02;

  if(!isDefined(var_03))
    var_03 = 0;

  self.yoffset = var_03;
  self.point = var_00;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_00, "TOP"))
    self.aligny = "top";

  if(issubstr(var_00, "BOTTOM"))
    self.aligny = "bottom";

  if(issubstr(var_00, "LEFT"))
    self.alignx = "left";

  if(issubstr(var_00, "RIGHT"))
    self.alignx = "right";

  if(!isDefined(var_01))
    var_01 = var_00;

  self.relativepoint = var_01;
  var_06 = "center";
  var_07 = "middle";

  if(issubstr(var_01, "TOP"))
    var_07 = "top";

  if(issubstr(var_01, "BOTTOM"))
    var_07 = "bottom";

  if(issubstr(var_01, "LEFT"))
    var_06 = "left";

  if(issubstr(var_01, "RIGHT"))
    var_06 = "right";

  if(var_05 == level.uiparent) {
    self.horzalign = var_06;
    self.vertalign = var_07;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(var_06 == var_5.alignx) {
    var_08 = 0;
    var_09 = 0;
  } else if(var_06 == "center" || var_5.alignx == "center") {
    var_08 = int(var_5.width / 2);

    if(var_06 == "left" || var_5.alignx == "right")
      var_09 = -1;
    else
      var_09 = 1;
  } else {
    var_08 = var_5.width;

    if(var_06 == "left")
      var_09 = -1;
    else
      var_09 = 1;
  }

  self.x = var_5.x + var_08 * var_09;

  if(var_07 == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_07 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_07 == "top" || var_5.aligny == "bottom")
      var_11 = -1;
    else
      var_11 = 1;
  } else {
    var_10 = var_5.height;

    if(var_07 == "top")
      var_11 = -1;
    else
      var_11 = 1;
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var_00, var_01, var_02, var_03);
      break;
  }

  updatechildren(var_04);
}

setpointbar(var_00, var_01, var_02, var_03) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left")
    self.bar.x = self.x + self.func_13E1E;
  else if(self.alignx == "right")
    self.bar.x = self.x - (self.width - self.func_13E1E);
  else
    self.bar.x = self.x - int((self.width - self.func_13E1E * 2) / 2);

  updatebar(self.bar.frac);
}

updatebar(var_00) {
  var_01 = int((self.width - self.func_13E1E * 2) * var_00);

  if(!var_01)
    var_01 = 1;

  self.bar.frac = var_00;
  self.bar setshader(self.bar.shader, var_01, self.height - self.func_13E5D * 2);
}

func_8EB9(var_00) {
  var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, 1);

  if(var_00 || !isDefined(self.func_C708) || !isDefined(self.bar.func_C708)) {
    self.func_C708 = self.alpha;
    self.bar.func_C708 = self.bar.alpha;
  }

  self.alpha = scripts\engine\utility::ter_op(var_00, 0, self.func_C708);
  self.bar.alpha = scripts\engine\utility::ter_op(var_00, 0, self.bar.func_C708);
}

createfontstring(var_00, var_01) {
  var_02 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

func_4999(var_00, var_01) {
  var_02 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

func_499D(var_00, var_01) {
  var_02 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

func_4A15(var_00, var_01) {
  var_02 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

createservertimer(var_00, var_01) {
  var_02 = newhudelem();
  var_2.elemtype = "timer";
  var_2.font = var_00;
  var_2.fontscale = var_01;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_01);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_02 setparent(level.uiparent);
  return var_02;
}

createicon(var_00, var_01, var_02) {
  var_03 = newhudelem();
  return createicon_hudelem(var_03, var_00, var_01, var_02);
}

func_499B(var_00, var_01, var_02) {
  var_03 = newclienthudelem(self);
  return createicon_hudelem(var_03, var_00, var_01, var_02);
}

createicon_hudelem(var_00, var_01, var_02, var_03) {
  var_0.elemtype = "icon";
  var_0.x = 0;
  var_0.y = 0;
  var_0.width = var_02;
  var_0.height = var_03;
  var_0.xoffset = 0;
  var_0.yoffset = 0;
  var_0.children = [];
  var_00 setparent(level.uiparent);

  if(isDefined(var_01))
    var_00 setshader(var_01, var_02, var_03);

  return var_00;
}

createbar(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_00))
    var_00 = "white";

  if(!isDefined(var_01))
    var_01 = "black";

  if(!isDefined(var_02))
    var_02 = 100;

  if(!isDefined(var_03))
    var_03 = 9;

  var_05 = newhudelem();
  var_5.x = 2;
  var_5.y = 2;
  var_5.frac = 0.25;
  var_5.shader = var_00;
  var_5.sort = -1;
  var_05 setshader(var_00, var_02 - 2, var_03 - 2);

  if(isDefined(var_04)) {
    var_5.flashfrac = var_04;
    var_05 thread flashthread();
  }

  var_06 = newhudelem();
  var_6.elemtype = "bar";
  var_6.x = 0;
  var_6.y = 0;
  var_6.width = var_02;
  var_6.height = var_03;
  var_6.xoffset = 0;
  var_6.yoffset = 0;
  var_6.bar = var_05;
  var_6.children = [];
  var_6.func_C85E = 2;
  var_6.sort = -2;
  var_6.alpha = 0.5;
  var_06 setparent(level.uiparent);
  var_06 setshader(var_01, var_02, var_03);
  return var_06;
}

func_499C(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, level.player);
  var_01 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, 90);
  var_02 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, "white");
  var_03 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, "black");
  var_04 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, 100);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_05), var_05, 9);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, 2);
  var_07 = scripts\engine\utility::ter_op(isDefined(var_07), var_07, 2);
  var_08 = var_00 func_4997(var_02, var_03, var_04, var_05, undefined, var_06, var_07);
  var_08 setpoint("CENTER", undefined, 0, var_01);
  return var_08;
}

func_4997(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_05))
    var_05 = 2;

  if(!isDefined(var_06))
    var_06 = 2;

  var_07 = newclienthudelem(self);
  var_7.x = 0 - var_05;
  var_7.y = 0 - var_06;
  var_7.frac = 0.25;
  var_7.shader = var_00;
  var_7.sort = -1;
  var_07 setshader(var_00, var_02 - var_05 * 2, var_03 - var_06 * 2);

  if(isDefined(var_04)) {
    var_7.flashfrac = var_04;
    var_07 thread flashthread();
  }

  var_08 = newclienthudelem(self);
  var_8.elemtype = "bar";
  var_8.x = 0;
  var_8.y = 0;
  var_8.width = var_02;
  var_8.height = var_03;
  var_8.xoffset = -1 * var_05;
  var_8.yoffset = 0;
  var_8.bar = var_07;
  var_8.children = [];
  var_8.func_13E1E = var_05;
  var_8.func_13E5D = var_06;
  var_8.sort = -2;
  var_8.alpha = 0.5;
  var_08 setparent(level.uiparent);
  var_08 setshader(var_01, var_02, var_03);
  return var_08;
}

setflashfrac(var_00) {
  self.bar.flashfrac = var_00;
}

func_6AAB(var_00, var_01) {
  if(isDefined(var_01) && var_01 > 0)
    self fadeovertime(var_01);

  self.alpha = var_00;

  if(isDefined(var_01) && var_01 > 0)
    wait(var_01);
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
    var_00 = [];

    for(var_01 = 0; var_01 < self.children.size; var_1++)
      var_0[var_01] = self.children[var_01];

    for(var_01 = 0; var_01 < var_0.size; var_1++)
      var_0[var_01] setparent(getparent());
  }

  if(isDefined(self.elemtype) && self.elemtype == "bar")
    self.bar destroy();

  self destroy();
}

seticonshader(var_00) {
  self setshader(var_00, self.width, self.height);
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

updatechildren(var_00) {
  for(var_01 = 0; var_01 < self.children.size; var_1++) {
    var_02 = self.children[var_01];
    var_02 setpoint(var_2.point, var_2.relativepoint, var_2.xoffset, var_2.yoffset, var_00);
  }
}

func_10B56(var_00) {
  if(isDefined(var_00) && var_00 == 0) {
    func_10B55();
    return;
  }

  if(isDefined(level.func_10B54))
    level.func_10B54 destroy();

  _setsaveddvar("hud_showStance", "0");
  level.func_10B54 = newhudelem();
  level.func_10B54.x = -75;

  if(level.console)
    level.func_10B54.y = -20;
  else
    level.func_10B54.y = -10;

  level.func_10B54 setshader("stance_carry", 64, 64);
  level.func_10B54.alignx = "right";
  level.func_10B54.aligny = "bottom";
  level.func_10B54.horzalign = "right";
  level.func_10B54.vertalign = "bottom";
  level.func_10B54.foreground = 1;
  level.func_10B54.alpha = 0;
  level.func_10B54 fadeovertime(0.5);
  level.func_10B54.alpha = 1;
}

func_10B55() {
  if(isDefined(level.func_10B54)) {
    level.func_10B54 fadeovertime(0.5);
    level.func_10B54.alpha = 0;
    level.func_10B54 destroy();
  }

  _setsaveddvar("hud_showStance", "1");
}

func_491A() {
  if(level.console) {
    var_00 = createfontstring("default", 1.8);
    var_00 setpoint("CENTER", undefined, -23, 115);
    var_00 give_zap_perk(level.func_1114E["mantle"]);
    var_01 = createicon("hint_mantle", 40, 40);
    var_01 setpoint("CENTER", undefined, 73, 0);
    var_01 setparent(var_00);
  } else {
    var_00 = createfontstring("default", 1.6);
    var_00 setpoint("CENTER", undefined, 0, 115);
    var_00 give_zap_perk(level.func_1114E["mantle"]);
    var_01 = createicon("hint_mantle", 40, 40);
    var_01 setpoint("CENTER", undefined, 0, 30);
    var_01 setparent(var_00);
  }

  var_1.alpha = 0;
  var_0.alpha = 0;
  level.func_9153 = [];
  level.func_9153["text"] = var_00;
  level.func_9153["icon"] = var_01;
}

func_78E6(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03))
    var_03 = 0;

  var_04 = undefined;

  if(!level.console)
    var_04 = -250;
  else if(!isDefined(var_00))
    var_04 = -225;
  else
    var_04 = var_00;

  if(var_03)
    var_04 = var_00;

  if(!isDefined(var_01))
    var_05 = 100;
  else
    var_05 = var_01;

  if(isDefined(var_02))
    var_06 = newclienthudelem(var_02);
  else
    var_06 = newhudelem();

  var_6.alignx = "left";
  var_6.aligny = "middle";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.x = var_04;
  var_6.y = var_05;
  var_6.fontscale = 1.6;
  var_6.color = (0.8, 1, 0.8);
  var_6.font = "objective";
  var_6.glowcolor = (0.3, 0.6, 0.3);
  var_6.glowalpha = 1;
  var_6.foreground = 1;
  var_6.hidewheninmenu = 1;
  var_6.hidewhendead = 1;
  return var_06;
}

func_7956(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_03))
    var_03 = 0;

  var_04 = undefined;

  if(!level.console)
    var_04 = -250;
  else if(!isDefined(var_00))
    var_04 = -170;
  else
    var_04 = var_00;

  if(var_03)
    var_04 = var_00;

  if(!isDefined(var_01))
    var_05 = 100;
  else
    var_05 = var_01;

  if(isDefined(var_02))
    var_06 = newclienthudelem(var_02);
  else
    var_06 = newhudelem();

  var_6.alignx = "right";
  var_6.aligny = "middle";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.x = var_04;
  var_6.y = var_05;
  var_6.fontscale = 1.6;
  var_6.color = (0.8, 1, 0.8);
  var_6.font = "objective";
  var_6.glowcolor = (0.3, 0.6, 0.3);
  var_6.glowalpha = 1;
  var_6.foreground = 1;
  var_6.hidewheninmenu = 1;
  var_6.hidewhendead = 1;
  return var_06;
}

func_48B7(var_00, var_01, var_02) {
  if(isDefined(var_02))
    var_03 = newclienthudelem(var_02);
  else
    var_03 = newhudelem();

  var_3.x = 0;
  var_3.y = 0;
  var_03 setshader(var_00, 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_01;
  var_3.foreground = 1;
  return var_03;
}

func_48B8(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\sp\utility::func_7B92();
  var_06 = newclienthudelem(var_05);

  if(!isDefined(var_04))
    var_04 = 1;

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  var_6.x = var_02;
  var_6.y = var_03;
  var_06 setshader(var_00, int(640 * var_04), int(480 * var_04));
  var_6.alignx = "center";
  var_6.aligny = "middle";
  var_6.sort = 1;
  var_6.horzalign = "center";
  var_6.vertalign = "middle";
  var_6.alpha = var_01;
  var_6.foreground = 1;
  return var_06;
}

func_48B9(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\sp\utility::func_7B92();
  var_06 = newclienthudelem(var_05);

  if(!isDefined(var_04))
    var_04 = 1;

  var_6.x = var_02;
  var_6.y = var_03;
  var_06 setshader(var_00, int(640 * var_04), int(480 * var_04));
  var_6.alignx = "center";
  var_6.aligny = "middle";
  var_6.sort = 1;
  var_6.horzalign = "fullscreen";
  var_6.vertalign = "fullscreen";
  var_6.alpha = var_01;
  var_6.foreground = 1;
  return var_06;
}

func_6A99(var_00, var_01) {
  if(level.func_B8D0) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = 0.3;

  var_02 = func_7B4F(var_01);
  var_02 fadeovertime(var_00);
  var_2.alpha = 0;
  wait(var_00);
}

func_7B4F(var_00) {
  if(!isDefined(var_00))
    var_00 = "black";

  return func_7B5D(var_00);
}

func_6AA3(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = 0.3;

  var_02 = func_7B4F(var_01);

  if(var_00 > 0)
    var_02 fadeovertime(var_00);

  var_2.alpha = 1;
  wait(var_00);
}

func_10CCC(var_00) {
  var_01 = func_7B4F(var_00);
  var_1.alpha = 1;
}

func_7B5D(var_00) {
  if(isplayer(self))
    var_01 = self;
  else
    var_01 = level.player;

  if(!isDefined(var_1.func_C7FD))
    var_1.func_C7FD = [];

  if(!isDefined(var_1.func_C7FD[var_00]))
    var_1.func_C7FD[var_00] = func_48B7(var_00, 0, var_01);

  var_1.func_C7FD[var_00].sort = 0;
  var_1.func_C7FD[var_00].foreground = 1;
  return var_1.func_C7FD[var_00];
}