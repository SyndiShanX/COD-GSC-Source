/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3024.gsc
************************/

func_F5E9(var_0, var_1) {
  var_0.var_C8DF = [];
  var_0.var_B813 = func_4963(var_0, "veh_hud_missile_locked");
  var_0.var_AF23 = func_4963(var_0, "veh_hud_missile");
  var_0.var_916B = func_48B6(var_0, 1, "hud_viper_booster_lft_on", 128, 480, 0, "LEFT", "LEFT", 0, 0);
  var_0.var_916E = func_48B6(var_0, 1, "hud_viper_booster_rht_on", 128, 480, 0, "RIGHT", "RIGHT", 0, 0);
  var_0.var_916C = func_48B6(var_0, 1, "hud_viper_booster_lft_on_red", 128, 480, 0, "LEFT", "LEFT", 0, 0);
  var_0.var_916F = func_48B6(var_0, 1, "hud_viper_booster_rht_on_red", 128, 480, 0, "RIGHT", "RIGHT", 0, 0);
  var_0.var_9173 = func_4920(var_0);
  var_0 thread func_915E(var_0, var_1);
}

func_52B0(var_0) {
  var_0.var_B813 destroyelem();
  var_0.var_AF23 destroyelem();
  var_0.var_916B destroyelem();
  var_0.var_916E destroyelem();
  var_0.var_916C destroyelem();
  var_0.var_916F destroyelem();
  func_52B1(var_0);
}

func_490B(var_0) {
  var_1 = var_0 createprimaryprogressbar(0, 212, 32, 3);
  var_1 updatebar(1);
  return var_1;
}

func_4963(var_0, var_1) {
  var_2 = newclienthudelem(var_0, 200, 200);
  var_2 setshader(var_1);
  var_2 setwaypoint(0, 1, 1, 0);
  var_2.alpha = 0;
  var_2.children = [];
  var_2.elemtype = "icon";
  return var_2;
}

func_48B7(var_0, var_1, var_2) {
  var_3 = newclienthudelem(var_0);
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader(var_1, 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_2;
  var_3.foreground = 1;
  var_3.children = [];
  var_3.elemtype = "overlay";
  return var_3;
}

func_48B6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = newclienthudelem(var_0);
  var_0A.elemtype = "icon";
  var_0A.children = [];
  var_0A.alpha = var_5;
  var_0A.archived = 0;
  var_0A setparent(level.uiparent);
  var_0A setshader(var_2, var_3, var_4);
  var_0A setpoint(var_6, var_7, var_8, var_9);
  if(var_1) {
    var_0.var_C8DF[var_0.var_C8DF.size] = var_0A;
  }

  return var_0A;
}

func_4920(var_0) {
  var_1 = [];
  var_2 = 80;
  var_3 = 15;
  var_1[var_1.size] = func_48B6(var_0, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", -1 * var_2, -1 * var_3);
  var_1[var_1.size] = func_48B6(var_0, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", -1 * var_2, var_3);
  var_1[var_1.size] = func_48B6(var_0, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", var_2, -1 * var_3);
  var_1[var_1.size] = func_48B6(var_0, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", var_2, var_3);
  return var_1;
}

func_52B1(var_0) {
  foreach(var_2 in var_0.var_9173) {
    var_2 destroyelem();
  }
}

func_A0D1(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("exit_jackal");
  var_1 endon("death");
  var_0 notifyonplayercommand("jackal boost", "+breath_sprint");
  for(;;) {
    var_0 waittill("jackal boost");
    var_0 thread func_1297D(var_0, var_1);
    while(var_0 issprinting()) {
      scripts\engine\utility::waitframe();
    }

    var_0 thread func_12951(var_0, var_1);
  }
}

func_1297D(var_0, var_1) {
  var_0 notify("engage boost");
  var_0 endon("disconnect");
  var_0 endon("engage boost");
  var_0 endon("disengage boost");
  var_0 endon("exit_jackal");
  var_1 endon("death");
  func_6EB6(var_0);
}

func_12951(var_0, var_1) {
  var_0 notify("disengage boost");
  var_0 endon("disconnect");
  var_0 endon("engage boost");
  var_0 endon("disengage boost");
  var_0 endon("exit_jackal");
  var_1 endon("death");
  func_12959(var_0.var_916B);
  func_12959(var_0.var_916E);
  func_12959(var_0.var_916C);
  func_12959(var_0.var_916F);
}

func_6EB6(var_0) {
  for(;;) {
    wait(0.3);
    func_12959(var_0.var_916B);
    func_12959(var_0.var_916E);
    func_12985(var_0.var_916C);
    func_12985(var_0.var_916F);
    wait(0.3);
    func_12985(var_0.var_916B);
    func_12985(var_0.var_916E);
    func_12959(var_0.var_916C);
    func_12959(var_0.var_916F);
  }
}

func_915E(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("exit_jackal");
  var_1 endon("death");
  for(;;) {
    var_2 = func_7B68(var_1, 0.05);
    func_BC4C(var_0, var_2);
    wait(0.05);
    func_BC4C(var_0, -1 * var_2);
    var_2 = func_7B68(var_1, 0.05);
    func_BC4C(var_0, -1 * var_2);
    wait(0.05);
    func_BC4C(var_0, var_2);
  }
}

func_7B68(var_0, var_1) {
  var_2 = var_0.origin;
  wait(var_1);
  var_3 = var_0.origin;
  var_4 = distancesquared(var_2, var_3);
  var_5 = var_4 / var_1;
  var_6 = var_5 / 120000;
  return clamp(var_6, 0, 1);
}

func_BC4C(var_0, var_1) {
  foreach(var_3 in var_0.var_C8DF) {
    var_3.x = var_3.x + var_1;
  }
}

func_12985(var_0) {
  if(isDefined(var_0)) {
    var_0.alpha = 1;
  }
}

func_12959(var_0) {
  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

createprimaryprogressbar(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(!isDefined(var_2)) {
    var_2 = level.primaryprogressbarwidth;
  }

  if(!isDefined(var_3)) {
    var_3 = level.primaryprogressbarheight;
  }

  var_4 = createbar((1, 1, 1), var_2, var_3);
  var_4 setpoint("CENTER", undefined, 0 + var_0, -61 + var_1);
  return var_4;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;
  if(isDefined(var_3)) {
    var_4.flashfrac = var_3;
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
    return;
  }

  setpoint("TOPLEFT");
}

addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }

  self.childchecktime = gettime();
  if(!isDefined(self.children)) {
    return;
  }

  var_0 = [];
  foreach(var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2.index = var_0.size;
    var_0[var_0.size] = var_2;
  }

  self.children = var_0;
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

  if(strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_8 == "center" || var_7.alignx == "center") {
    var_8 = int(var_7.width / 2);
    if(var_7 == "left_adjustable" || var_6.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_7.width;
    if(var_7 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;
  if(strip_suffix(var_7, "_adjustable") == var_5.aligny) {
    var_0A = 0;
    var_0B = 0;
  } else if(var_9 == "middle" || var_7.aligny == "middle") {
    var_0A = int(var_7.height / 2);
    if(var_8 == "top_adjustable" || var_6.aligny == "bottom") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  } else {
    var_0A = var_7.height;
    if(var_8 == "top_adjustable") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  }

  self.y = var_5.y + var_0A * var_0B;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;
  switch (self.elemtype) {
    case "bar":
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  updatechildren();
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

getparent() {
  return self.parent;
}

setpointbar(var_0, var_1, var_2, var_3) {
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

updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
  }
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);
  if(!var_2) {
    var_2 = 1;
  }

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);
  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime(1 - var_0 / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / -1 * var_1, 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
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