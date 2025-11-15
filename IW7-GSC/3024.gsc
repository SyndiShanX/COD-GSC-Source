/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3024.gsc
************************/

func_F5E9(param_00, param_01) {
  param_00.var_C8DF = [];
  param_00.var_B813 = func_4963(param_00, "veh_hud_missile_locked");
  param_00.var_AF23 = func_4963(param_00, "veh_hud_missile");
  param_00.var_916B = func_48B6(param_00, 1, "hud_viper_booster_lft_on", 128, 480, 0, "LEFT", "LEFT", 0, 0);
  param_00.var_916E = func_48B6(param_00, 1, "hud_viper_booster_rht_on", 128, 480, 0, "RIGHT", "RIGHT", 0, 0);
  param_00.var_916C = func_48B6(param_00, 1, "hud_viper_booster_lft_on_red", 128, 480, 0, "LEFT", "LEFT", 0, 0);
  param_00.var_916F = func_48B6(param_00, 1, "hud_viper_booster_rht_on_red", 128, 480, 0, "RIGHT", "RIGHT", 0, 0);
  param_00.var_9173 = func_4920(param_00);
  param_00 thread func_915E(param_00, param_01);
}

func_52B0(param_00) {
  param_00.var_B813 destroyelem();
  param_00.var_AF23 destroyelem();
  param_00.var_916B destroyelem();
  param_00.var_916E destroyelem();
  param_00.var_916C destroyelem();
  param_00.var_916F destroyelem();
  func_52B1(param_00);
}

func_490B(param_00) {
  var_01 = param_00 createprimaryprogressbar(0, 212, 32, 3);
  var_01 updatebar(1);
  return var_01;
}

func_4963(param_00, param_01) {
  var_02 = newclienthudelem(param_00, 200, 200);
  var_02 setshader(param_01);
  var_02 setwaypoint(0, 1, 1, 0);
  var_02.alpha = 0;
  var_02.children = [];
  var_02.elemtype = "icon";
  return var_02;
}

func_48B7(param_00, param_01, param_02) {
  var_03 = newclienthudelem(param_00);
  var_03.x = 0;
  var_03.y = 0;
  var_03 setshader(param_01, 640, 480);
  var_03.alignx = "left";
  var_03.aligny = "top";
  var_03.sort = 1;
  var_03.horzalign = "fullscreen";
  var_03.vertalign = "fullscreen";
  var_03.alpha = param_02;
  var_03.foreground = 1;
  var_03.children = [];
  var_03.elemtype = "overlay";
  return var_03;
}

func_48B6(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = newclienthudelem(param_00);
  var_0A.elemtype = "icon";
  var_0A.children = [];
  var_0A.alpha = param_05;
  var_0A.archived = 0;
  var_0A setparent(level.uiparent);
  var_0A setshader(param_02, param_03, param_04);
  var_0A setpoint(param_06, param_07, param_08, param_09);
  if(param_01) {
    param_00.var_C8DF[param_00.var_C8DF.size] = var_0A;
  }

  return var_0A;
}

func_4920(param_00) {
  var_01 = [];
  var_02 = 80;
  var_03 = 15;
  var_01[var_01.size] = func_48B6(param_00, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", -1 * var_02, -1 * var_03);
  var_01[var_01.size] = func_48B6(param_00, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", -1 * var_02, var_03);
  var_01[var_01.size] = func_48B6(param_00, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", var_02, -1 * var_03);
  var_01[var_01.size] = func_48B6(param_00, 0, "hud_viper_missile", 14, 14, 0, "CENTER", "CENTER", var_02, var_03);
  return var_01;
}

func_52B1(param_00) {
  foreach(var_02 in param_00.var_9173) {
    var_02 destroyelem();
  }
}

func_A0D1(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("exit_jackal");
  param_01 endon("death");
  param_00 notifyonplayercommand("jackal boost", "+breath_sprint");
  for(;;) {
    param_00 waittill("jackal boost");
    param_00 thread func_1297D(param_00, param_01);
    while(param_00 issprinting()) {
      scripts\engine\utility::waitframe();
    }

    param_00 thread func_12951(param_00, param_01);
  }
}

func_1297D(param_00, param_01) {
  param_00 notify("engage boost");
  param_00 endon("disconnect");
  param_00 endon("engage boost");
  param_00 endon("disengage boost");
  param_00 endon("exit_jackal");
  param_01 endon("death");
  func_6EB6(param_00);
}

func_12951(param_00, param_01) {
  param_00 notify("disengage boost");
  param_00 endon("disconnect");
  param_00 endon("engage boost");
  param_00 endon("disengage boost");
  param_00 endon("exit_jackal");
  param_01 endon("death");
  func_12959(param_00.var_916B);
  func_12959(param_00.var_916E);
  func_12959(param_00.var_916C);
  func_12959(param_00.var_916F);
}

func_6EB6(param_00) {
  for(;;) {
    wait(0.3);
    func_12959(param_00.var_916B);
    func_12959(param_00.var_916E);
    func_12985(param_00.var_916C);
    func_12985(param_00.var_916F);
    wait(0.3);
    func_12985(param_00.var_916B);
    func_12985(param_00.var_916E);
    func_12959(param_00.var_916C);
    func_12959(param_00.var_916F);
  }
}

func_915E(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("exit_jackal");
  param_01 endon("death");
  for(;;) {
    var_02 = func_7B68(param_01, 0.05);
    func_BC4C(param_00, var_02);
    wait(0.05);
    func_BC4C(param_00, -1 * var_02);
    var_02 = func_7B68(param_01, 0.05);
    func_BC4C(param_00, -1 * var_02);
    wait(0.05);
    func_BC4C(param_00, var_02);
  }
}

func_7B68(param_00, param_01) {
  var_02 = param_00.origin;
  wait(param_01);
  var_03 = param_00.origin;
  var_04 = distancesquared(var_02, var_03);
  var_05 = var_04 / param_01;
  var_06 = var_05 / 120000;
  return clamp(var_06, 0, 1);
}

func_BC4C(param_00, param_01) {
  foreach(var_03 in param_00.var_C8DF) {
    var_03.x = var_03.x + param_01;
  }
}

func_12985(param_00) {
  if(isDefined(param_00)) {
    param_00.alpha = 1;
  }
}

func_12959(param_00) {
  if(isDefined(param_00)) {
    param_00.alpha = 0;
  }
}

createprimaryprogressbar(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = -25;
  }

  if(!isDefined(param_02)) {
    param_02 = level.primaryprogressbarwidth;
  }

  if(!isDefined(param_03)) {
    param_03 = level.primaryprogressbarheight;
  }

  var_04 = createbar((1, 1, 1), param_02, param_03);
  var_04 setpoint("CENTER", undefined, 0 + param_00, -61 + param_01);
  return var_04;
}

createbar(param_00, param_01, param_02, param_03) {
  var_04 = newclienthudelem(self);
  var_04.x = 0;
  var_04.y = 0;
  var_04.frac = 0;
  var_04.color = param_00;
  var_04.sort = -2;
  var_04.shader = "progress_bar_fill";
  var_04 setshader("progress_bar_fill", param_01, param_02);
  var_04.hidden = 0;
  if(isDefined(param_03)) {
    var_04.flashfrac = param_03;
  }

  var_05 = newclienthudelem(self);
  var_05.elemtype = "bar";
  var_05.width = param_01;
  var_05.height = param_02;
  var_05.xoffset = 0;
  var_05.yoffset = 0;
  var_05.bar = var_04;
  var_05.children = [];
  var_05.sort = -3;
  var_05.color = (0, 0, 0);
  var_05.alpha = 0.5;
  var_05 setparent(level.uiparent);
  var_05 setshader("progress_bar_bg", param_01 + 4, param_02 + 4);
  var_05.hidden = 0;
  return var_05;
}

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

addchild(param_00) {
  param_00.index = self.children.size;
  self.children[self.children.size] = param_00;
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
  var_06 = "center_adjustable";
  var_07 = "middle";
  if(issubstr(param_01, "TOP")) {
    var_07 = "top_adjustable";
  }

  if(issubstr(param_01, "BOTTOM")) {
    var_07 = "bottom_adjustable";
  }

  if(issubstr(param_01, "LEFT")) {
    var_06 = "left_adjustable";
  }

  if(issubstr(param_01, "RIGHT")) {
    var_06 = "right_adjustable";
  }

  if(var_05 == level.uiparent) {
    self.horzalign = var_06;
    self.vertalign = var_07;
  } else {
    self.horzalign = var_05.horzalign;
    self.vertalign = var_05.vertalign;
  }

  if(strip_suffix(var_06, "_adjustable") == var_05.alignx) {
    var_08 = 0;
    var_09 = 0;
  } else if(var_08 == "center" || var_07.alignx == "center") {
    var_08 = int(var_07.width / 2);
    if(var_07 == "left_adjustable" || var_06.alignx == "right") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  } else {
    var_08 = var_07.width;
    if(var_07 == "left_adjustable") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  }

  self.x = var_05.x + var_08 * var_09;
  if(strip_suffix(var_07, "_adjustable") == var_05.aligny) {
    var_0A = 0;
    var_0B = 0;
  } else if(var_09 == "middle" || var_07.aligny == "middle") {
    var_0A = int(var_07.height / 2);
    if(var_08 == "top_adjustable" || var_06.aligny == "bottom") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  } else {
    var_0A = var_07.height;
    if(var_08 == "top_adjustable") {
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

  updatechildren();
}

strip_suffix(param_00, param_01) {
  if(param_00.size <= param_01.size) {
    return param_00;
  }

  if(getsubstr(param_00, param_00.size - param_01.size, param_00.size) == param_01) {
    return getsubstr(param_00, 0, param_00.size - param_01.size);
  }

  return param_00;
}

getparent() {
  return self.parent;
}

setpointbar(param_00, param_01, param_02, param_03) {
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
  for(var_00 = 0; var_00 < self.children.size; var_00++) {
    var_01 = self.children[var_00];
    var_01 setpoint(var_01.point, var_01.relativepoint, var_01.xoffset, var_01.yoffset);
  }
}

updatebar(param_00, param_01) {
  if(self.elemtype == "bar") {
    updatebarscale(param_00, param_01);
  }
}

updatebarscale(param_00, param_01) {
  var_02 = int(self.width * param_00 + 0.5);
  if(!var_02) {
    var_02 = 1;
  }

  self.bar.frac = param_00;
  self.bar setshader(self.bar.shader, var_02, self.height);
  if(isDefined(param_01) && var_02 < self.width) {
    if(param_01 > 0) {
      self.bar scaleovertime(1 - param_00 / param_01, self.width, self.height);
    } else if(param_01 < 0) {
      self.bar scaleovertime(param_00 / -1 * param_01, 1, self.height);
    }
  }

  self.bar.rateofchange = param_01;
  self.bar.lastupdatetime = gettime();
}

destroyelem() {
  var_00 = [];
  for(var_01 = 0; var_01 < self.children.size; var_01++) {
    if(isDefined(self.children[var_01])) {
      var_00[var_00.size] = self.children[var_01];
    }
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] setparent(getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}