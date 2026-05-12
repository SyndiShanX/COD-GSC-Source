/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud_util.gsc
*********************************************/

func_86EF(param_00) {
  if(isDefined(self.var_6E74) && self.var_6E74 == param_00) {
    return;
  }

  if(isDefined(self.var_6E74)) {
    self.var_6E74 func_7CD5(self);
  }

  self.var_6E74 = param_00;
  self.var_6E74 func_09A6(self);
  if(isDefined(self.var_7538)) {
    func_8707(self.var_7538, self.var_7C16, self.var_AACD, self.var_AAEB);
    return;
  }

  func_8707("TOPLEFT");
}

func_45FC() {
  return self.var_6E74;
}

func_09A6(param_00) {
  param_00.var_00D4 = self.var_21F6.size;
  self.var_21F6[self.var_21F6.size] = param_00;
}

func_7CD5(param_00) {
  param_00.var_6E74 = undefined;
  if(self.var_21F6[self.var_21F6.size - 1] != param_00) {
    self.var_21F6[param_00.var_00D4] = self.var_21F6[self.var_21F6.size - 1];
    self.var_21F6[param_00.var_00D4].var_00D4 = param_00.var_00D4;
  }

  self.var_21F6[self.var_21F6.size - 1] = undefined;
  param_00.var_00D4 = undefined;
}

func_8707(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  var_05 = func_45FC();
  if(param_04) {
    self moveovertime(param_04);
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  self.var_AACD = param_02;
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  self.var_AAEB = param_03;
  self.var_7538 = param_00;
  self.var_0010 = "center";
  self.var_0011 = "middle";
  if(issubstr(param_00, "TOP")) {
    self.var_0011 = "top";
  }

  if(issubstr(param_00, "BOTTOM")) {
    self.var_0011 = "bottom";
  }

  if(issubstr(param_00, "LEFT")) {
    self.var_0010 = "left";
  }

  if(issubstr(param_00, "RIGHT")) {
    self.var_0010 = "right";
  }

  if(!isDefined(param_01)) {
    param_01 = param_00;
  }

  self.var_7C16 = param_01;
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

  if(var_05 == level.var_A012) {
    self.var_00C6 = var_06;
    self.var_01CA = var_07;
  } else {
    self.var_00C6 = var_05.var_00C6;
    self.var_01CA = var_05.var_01CA;
  }

  if(function_02FF(var_06, "_adjustable") == var_05.var_0010) {
    var_08 = 0;
    var_09 = 0;
  } else if(var_08 == "center" || var_07.var_0010 == "center") {
    var_08 = int(var_07.var_01D2 / 2);
    if(var_07 == "left_adjustable" || var_06.var_0010 == "right") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  } else {
    var_08 = var_07.var_01D2;
    if(var_07 == "left_adjustable") {
      var_09 = -1;
    } else {
      var_09 = 1;
    }
  }

  self.var_01D3 = var_05.var_01D3 + var_08 * var_09;
  if(function_02FF(var_07, "_adjustable") == var_05.var_0011) {
    var_0A = 0;
    var_0B = 0;
  } else if(var_09 == "middle" || var_07.var_0011 == "middle") {
    var_0A = int(var_07.var_00BD / 2);
    if(var_08 == "top_adjustable" || var_06.var_0011 == "bottom") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  } else {
    var_0A = var_07.var_00BD;
    if(var_08 == "top_adjustable") {
      var_0B = -1;
    } else {
      var_0B = 1;
    }
  }

  self.var_01D7 = var_05.var_01D7 + var_0A * var_0B;
  self.var_01D3 = self.var_01D3 + self.var_AACD;
  self.var_01D7 = self.var_01D7 + self.var_AAEB;
  switch (self.var_35B2) {
    case "bar":
      func_8708(param_00, param_01, param_02, param_03);
      break;
  }

  func_A0F5();
}

func_8708(param_00, param_01, param_02, param_03) {
  self.var_1586.var_00C6 = self.var_00C6;
  self.var_1586.var_01CA = self.var_01CA;
  self.var_1586.var_0010 = "left";
  self.var_1586.var_0011 = self.var_0011;
  self.var_1586.var_01D7 = self.var_01D7;
  if(self.var_0010 == "left") {
    self.var_1586.var_01D3 = self.var_01D3;
  } else if(self.var_0010 == "right") {
    self.var_1586.var_01D3 = self.var_01D3 - self.var_01D2;
  } else {
    self.var_1586.var_01D3 = self.var_01D3 - int(self.var_01D2 / 2);
  }

  if(self.var_0011 == "top") {
    self.var_1586.var_01D7 = self.var_01D7;
  } else if(self.var_0011 == "bottom") {
    self.var_1586.var_01D7 = self.var_01D7;
  }

  func_A0E3(self.var_1586.var_3E6E);
}

func_A0E3(param_00, param_01) {
  if(self.var_35B2 == "bar") {
    func_A0E5(param_00, param_01);
  }
}

func_A0E5(param_00, param_01) {
  var_02 = int(self.var_01D2 * param_00 + 0.5);
  if(!var_02) {
    var_02 = 1;
  }

  self.var_1586.var_3E6E = param_00;
  self.var_1586 setshader(self.var_1586.var_8AC7, var_02, self.var_00BD);
  if(isDefined(param_01) && var_02 < self.var_01D2) {
    if(param_01 > 0) {
      self.var_1586 scaleovertime(1 - param_00 / param_01, self.var_01D2, self.var_00BD);
    } else if(param_01 < 0) {
      self.var_1586 scaleovertime(param_00 / -1 * param_01, 1, self.var_00BD);
    }
  }

  self.var_1586.var_7A78 = param_01;
  self.var_1586.var_5C09 = gettime();
}

func_27ED(param_00, param_01) {
  var_02 = newclienthudelem(self);
  var_02.var_35B2 = "font";
  var_02.var_009A = param_00;
  var_02.var_017A = 1;
  var_02.var_009B = param_01;
  var_02.var_15FC = param_01;
  var_02.var_01D3 = 0;
  var_02.var_01D7 = 0;
  var_02.var_01D2 = 0;
  var_02.var_00BD = int(level.var_3DD8 * param_01);
  var_02.var_AACD = 0;
  var_02.var_AAEB = 0;
  var_02.var_21F6 = [];
  var_02 func_86EF(level.var_A012);
  var_02.var_4CC7 = 0;
  return var_02;
}

func_2829(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = newteamhudelem(param_02);
  } else {
    var_03 = newhudelem();
  }

  var_03.var_35B2 = "font";
  var_03.var_009A = param_00;
  var_03.var_017A = 1;
  var_03.var_009B = param_01;
  var_03.var_15FC = param_01;
  var_03.var_01D3 = 0;
  var_03.var_01D7 = 0;
  var_03.var_01D2 = 0;
  var_03.var_00BD = int(level.var_3DD8 * param_01);
  var_03.var_AACD = 0;
  var_03.var_AAEB = 0;
  var_03.var_21F6 = [];
  var_03 func_86EF(level.var_A012);
  var_03.var_4CC7 = 0;
  return var_03;
}

func_282B(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = newteamhudelem(param_02);
  } else {
    var_03 = newhudelem();
  }

  var_03.var_35B2 = "timer";
  var_03.var_009A = param_00;
  var_03.var_017A = 1;
  var_03.var_009B = param_01;
  var_03.var_15FC = param_01;
  var_03.var_01D3 = 0;
  var_03.var_01D7 = 0;
  var_03.var_01D2 = 0;
  var_03.var_00BD = int(level.var_3DD8 * param_01);
  var_03.var_AACD = 0;
  var_03.var_AAEB = 0;
  var_03.var_21F6 = [];
  var_03 func_86EF(level.var_A012);
  var_03.var_4CC7 = 0;
  return var_03;
}

func_2833(param_00, param_01) {
  var_02 = newclienthudelem(self);
  var_02.var_35B2 = "timer";
  var_02.var_009A = param_00;
  var_02.var_017A = 1;
  var_02.var_009B = param_01;
  var_02.var_15FC = param_01;
  var_02.var_01D3 = 0;
  var_02.var_01D7 = 0;
  var_02.var_01D2 = 0;
  var_02.var_00BD = int(level.var_3DD8 * param_01);
  var_02.var_AACD = 0;
  var_02.var_AAEB = 0;
  var_02.var_21F6 = [];
  var_02 func_86EF(level.var_A012);
  var_02.var_4CC7 = 0;
  return var_02;
}

func_280B(param_00, param_01, param_02) {
  var_03 = newclienthudelem(self);
  var_03.var_35B2 = "icon";
  var_03.var_01D3 = 0;
  var_03.var_01D7 = 0;
  var_03.var_01D2 = param_01;
  var_03.var_00BD = param_02;
  var_03.var_1630 = var_03.var_01D2;
  var_03.var_15FD = var_03.var_00BD;
  var_03.var_AACD = 0;
  var_03.var_AAEB = 0;
  var_03.var_21F6 = [];
  var_03 func_86EF(level.var_A012);
  var_03.var_4CC7 = 0;
  if(isDefined(param_00)) {
    var_03 setshader(param_00, param_01, param_02);
    var_03.var_8AC7 = param_00;
  }

  return var_03;
}

func_282A(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    var_04 = newteamhudelem(param_03);
  } else {
    var_04 = newhudelem();
  }

  var_04.var_35B2 = "icon";
  var_04.var_01D3 = 0;
  var_04.var_01D7 = 0;
  var_04.var_01D2 = param_01;
  var_04.var_00BD = param_02;
  var_04.var_1630 = var_04.var_01D2;
  var_04.var_15FD = var_04.var_00BD;
  var_04.var_AACD = 0;
  var_04.var_AAEB = 0;
  var_04.var_21F6 = [];
  var_04 func_86EF(level.var_A012);
  var_04.var_4CC7 = 0;
  if(isDefined(param_00)) {
    var_04 setshader(param_00, param_01, param_02);
    var_04.var_8AC7 = param_00;
  }

  return var_04;
}

func_2828(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_04)) {
    var_06 = newteamhudelem(param_04);
  } else {
    var_06 = newhudelem();
  }

  var_06.var_01D3 = 0;
  var_06.var_01D7 = 0;
  var_06.var_3E6E = 0;
  var_06.var_0056 = param_00;
  var_06.var_0184 = -2;
  var_06.var_8AC7 = "progress_bar_fill";
  var_06 setshader("progress_bar_fill", param_01, param_02);
  var_06.var_4CC7 = 0;
  if(isDefined(param_03)) {
    var_06.var_3D49 = param_03;
  }

  if(isDefined(param_04)) {
    var_07 = newteamhudelem(param_04);
  } else {
    var_07 = newhudelem();
  }

  var_07.var_35B2 = "bar";
  var_07.var_01D3 = 0;
  var_07.var_01D7 = 0;
  var_07.var_01D2 = param_01;
  var_07.var_00BD = param_02;
  var_07.var_AACD = 0;
  var_07.var_AAEB = 0;
  var_07.var_1586 = var_06;
  var_07.var_21F6 = [];
  var_07.var_0184 = -3;
  var_07.var_0056 = (0, 0, 0);
  var_07.var_0018 = 0.5;
  var_07 func_86EF(level.var_A012);
  var_07 setshader("progress_bar_bg", param_01, param_02);
  var_07.var_4CC7 = 0;
  return var_07;
}

func_27CF(param_00, param_01, param_02, param_03) {
  var_04 = newclienthudelem(self);
  var_04.var_01D3 = 0;
  var_04.var_01D7 = 0;
  var_04.var_3E6E = 0;
  var_04.var_0056 = param_00;
  var_04.var_0184 = -2;
  var_04.var_8AC7 = "progress_bar_fill";
  var_04 setshader("progress_bar_fill", param_01, param_02);
  var_04.var_4CC7 = 0;
  if(isDefined(param_03)) {
    var_04.var_3D49 = param_03;
  }

  var_05 = newclienthudelem(self);
  var_05.var_35B2 = "bar";
  var_05.var_01D2 = param_01;
  var_05.var_00BD = param_02;
  var_05.var_AACD = 0;
  var_05.var_AAEB = 0;
  var_05.var_1586 = var_04;
  var_05.var_21F6 = [];
  var_05.var_0184 = -3;
  var_05.var_0056 = (0, 0, 0);
  var_05.var_0018 = 0.5;
  var_05 func_86EF(level.var_A012);
  var_05 setshader("progress_bar_bg", param_01 + 4, param_02 + 4);
  var_05.var_4CC7 = 0;
  return var_05;
}

func_447D() {
  var_00 = self.var_1586.var_3E6E;
  if(isDefined(self.var_1586.var_7A78)) {
    var_00 = var_00 + gettime() - self.var_1586.var_5C09 * self.var_1586.var_7A78 / 1000;
    if(var_00 > 1) {
      var_00 = 1;
    }

    if(var_00 < 0) {
      var_00 = 0;
    }
  }

  return var_00;
}

func_2821(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(self issplitscreenplayer() && !function_03BA()) {
    param_01 = param_01 + 20;
  }

  if(function_0367()) {
    var_03 = func_27CF((0.25, 0.58, 0.53), level.var_76FD, level.var_76FA);
  } else {
    var_03 = func_27CF((1, 1, 1), level.var_76FD, level.var_76FA);
  }

  var_03 func_8707("CENTER", undefined, level.var_76FE + param_00, level.var_76FF + param_01);
  return var_03;
}

func_2822(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(self issplitscreenplayer() && !function_03BA()) {
    param_01 = param_01 + 20;
  }

  if(function_0367()) {
    var_02 = func_27ED("mphubfont", 1.4);
  } else {
    var_02 = func_27ED("hudbig", level.var_76F9);
  }

  var_02 func_8707("CENTER", undefined, level.var_76FB + param_00, level.var_76FC + param_01);
  var_02.var_0184 = -1;
  return var_02;
}

func_2830(param_00) {
  var_01 = func_2828((1, 0, 0), level.var_9867, level.var_9865, undefined, param_00);
  var_01 func_8707("TOP", undefined, 0, level.var_9868);
  return var_01;
}

func_2831(param_00) {
  var_01 = func_2829("default", level.var_9864, param_00);
  var_01 func_8707("TOP", undefined, 0, level.var_9866);
  return var_01;
}

func_8685(param_00) {
  self.var_1586.var_3D49 = param_00;
}

func_4D06() {
  if(self.var_4CC7) {
    return;
  }

  self.var_4CC7 = 1;
  if(self.var_0018 != 0) {
    self.var_0018 = 0;
  }

  if(self.var_35B2 == "bar" || self.var_35B2 == "bar_shader") {
    self.var_1586.var_4CC7 = 1;
    if(self.var_1586.var_0018 != 0) {
      self.var_1586.var_0018 = 0;
    }
  }
}

func_8BF6() {
  if(!self.var_4CC7) {
    return;
  }

  self.var_4CC7 = 0;
  if(self.var_35B2 == "bar" || self.var_35B2 == "bar_shader") {
    if(self.var_0018 != 0.5) {
      self.var_0018 = 0.5;
    }

    self.var_1586.var_4CC7 = 0;
    if(self.var_1586.var_0018 != 1) {
      self.var_1586.var_0018 = 1;
      return;
    }

    return;
  }

  if(self.var_0018 != 1) {
    self.var_0018 = 1;
  }
}

func_3D59() {
  self endon("death");
  if(!self.var_4CC7) {
    self.var_0018 = 1;
  }

  for(;;) {
    if(self.var_3E6E >= self.var_3D49) {
      if(!self.var_4CC7) {
        self fadeovertime(0.3);
        self.var_0018 = 0.2;
        wait(0.35);
        self fadeovertime(0.3);
        self.var_0018 = 1;
      }

      wait(0.7);
      continue;
    }

    if(!self.var_4CC7 && self.var_0018 != 1) {
      self.var_0018 = 1;
    }

    wait 0.05;
  }
}

func_2DCC() {
  var_00 = [];
  for(var_01 = 0; var_01 < self.var_21F6.size; var_01++) {
    if(isDefined(self.var_21F6[var_01])) {
      var_00[var_00.size] = self.var_21F6[var_01];
    }
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] func_86EF(func_45FC());
  }

  if(self.var_35B2 == "bar" || self.var_35B2 == "bar_shader") {
    self.var_1586 destroy();
  }

  self destroy();
}

func_86AA(param_00) {
  self setshader(param_00, self.var_01D2, self.var_00BD);
  self.var_8AC7 = param_00;
}

func_4519(param_00) {
  return self.var_8AC7;
}

func_86AB(param_00, param_01) {
  self setshader(self.var_8AC7, param_00, param_01);
}

func_8A69(param_00) {
  self.var_01D2 = param_00;
}

func_86A1(param_00) {
  self.var_00BD = param_00;
}

func_8723(param_00, param_01) {
  self.var_01D2 = param_00;
  self.var_00BD = param_01;
}

func_A0F5() {
  for(var_00 = 0; var_00 < self.var_21F6.size; var_00++) {
    var_01 = self.var_21F6[var_00];
    var_01 func_8707(var_01.var_7538, var_01.var_7C16, var_01.var_AACD, var_01.var_AAEB);
  }
}

func_9C7F() {
  self.var_01D3 = self.var_AACD;
  self.var_01D7 = self.var_AAEB;
  if(self.var_35B2 == "font") {
    self.var_009B = self.var_15FC;
    self.var_00E5 = &"";
  } else if(self.var_35B2 == "icon") {
    self setshader(self.var_8AC7, self.var_01D2, self.var_00BD);
  }

  self.var_0018 = 0;
}

func_9C84(param_00) {
  switch (self.var_35B2) {
    case "timer":
    case "font":
      self.var_009B = 6.3;
      self changefontscaleovertime(param_00);
      self.var_009B = self.var_15FC;
      break;

    case "icon":
      self setshader(self.var_8AC7, self.var_01D2 * 6, self.var_00BD * 6);
      self scaleovertime(param_00, self.var_01D2, self.var_00BD);
      break;
  }
}

func_9C7E(param_00, param_01) {
  var_02 = int(param_00) * 1000;
  var_03 = int(param_01) * 1000;
  switch (self.var_35B2) {
    case "timer":
    case "font":
      self setpulsefx(var_02 + 250, var_03 + var_02, var_02 + 250);
      break;

    default:
      break;
  }
}

func_9C81(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "left";
  }

  switch (param_01) {
    case "left":
      self.var_01D3 = self.var_01D3 + 1000;
      break;

    case "right":
      self.var_01D3 = self.var_01D3 - 1000;
      break;

    case "up":
      self.var_01D7 = self.var_01D7 - 1000;
      break;

    case "down":
      self.var_01D7 = self.var_01D7 + 1000;
      break;
  }

  self moveovertime(param_00);
  self.var_01D3 = self.var_AACD;
  self.var_01D7 = self.var_AAEB;
}

func_9C82(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "left";
  }

  var_02 = self.var_AACD;
  var_03 = self.var_AAEB;
  switch (param_01) {
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

  self.var_0018 = 1;
  self moveovertime(param_00);
  self.var_01D3 = var_02;
  self.var_01D7 = var_03;
}

func_9C85(param_00) {
  switch (self.var_35B2) {
    case "timer":
    case "font":
      self changefontscaleovertime(param_00);
      self.var_009B = 6.3;
      break;

    case "icon":
      self scaleovertime(param_00, self.var_01D2 * 6, self.var_00BD * 6);
      break;
  }
}

func_9C78(param_00) {
  self fadeovertime(param_00);
  if(isDefined(self.var_6073)) {
    self.var_0018 = self.var_6073;
    return;
  }

  self.var_0018 = 1;
}

func_9C79(param_00) {
  self fadeovertime(0.15);
  self.var_0018 = 0;
}

func_5807(param_00) {
  if(issubstr(param_00, "ch_limited")) {
    return 1;
  }

  return 0;
}

func_5850(param_00) {
  if(common_scripts\utility::func_9467(param_00, "ch_attach_unlock_kills")) {
    return 1;
  }

  if(common_scripts\utility::func_9467(param_00, "ch_attach_unlock_hipfirekills")) {
    return 1;
  }

  if(common_scripts\utility::func_9467(param_00, "ch_attach_unlock_headShots")) {
    return 1;
  }

  return 0;
}

func_2097(param_00) {
  if(func_5850(param_00)) {
    return func_775C(param_00);
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), "challengeProgress", param_00);
}

func_2098(param_00) {
  if(func_5850(param_00)) {
    return func_775D(param_00);
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), "challengeState", param_00);
}

func_209E(param_00, param_01) {
  if(func_5850(param_00)) {
    return;
  }

  var_02 = maps\mp\_utility::func_2315(param_01);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "challengeProgress", param_00, var_02);
  if(issubstr(param_00, "ch_daily_") && var_02 > 0) {
    thread maps\mp\gametypes\_hud_message::func_9102(param_00, var_02);
  }
}

func_209F(param_00, param_01) {
  if(func_5850(param_00)) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), "challengeState", param_00, param_01);
}

func_2099(param_00, param_01) {
  if(issubstr(param_00, "ch_daily")) {
    var_02 = tablelookup("mp/dailyChallengesTable.csv", 0, param_00, 9);
  } else {
    var_02 = tablelookup("mp/allChallengesTable.csv", 0, param_01, 9 + var_02 - 1 * 2);
  }

  if(isDefined(var_02) && var_02 != "") {
    return int(var_02);
  }

  return 0;
}

func_3005(param_00, param_01, param_02, param_03) {
  var_04 = func_27ED("hudbig", param_02);
  var_04 func_8707("CENTER", "CENTER", 0, param_01);
  var_04.var_0184 = 1001;
  var_04.var_0056 = (1, 1, 1);
  var_04.var_00A0 = 0;
  var_04.var_00C2 = 1;
  var_04 settext(param_00);
  common_scripts\utility::func_A70A(param_03, "joined_team", "death");
  if(isDefined(var_04)) {
    var_04 func_2DCC();
  }
}

func_775C(param_00) {
  if(common_scripts\utility::func_9467(param_00, "ch_attach_unlock_hipfirekills")) {
    return func_9AB0(param_00, "hipfirekills");
  } else if(common_scripts\utility::func_9467(param_00, "ch_attach_unlock_kills")) {
    return func_9AB0(param_00, "kills");
  } else if(common_scripts\utility::func_9467(param_00, "ch_attach_unlock_headShots")) {
    return func_9AB0(param_00, "headShots");
  }
}

func_775D(param_00) {
  var_01 = func_775C(param_00);
  var_02 = 1;
  for(var_03 = func_2099(param_00, var_02); var_03 > 0 && var_01 >= var_03; var_03 = func_2099(param_00, var_02)) {
    var_02++;
  }

  return var_02;
}

func_9AB0(param_00, param_01) {
  var_02 = undefined;
  var_03 = 0;
  var_04 = strtok(param_00, "_");
  for(var_05 = 0; var_05 < var_04.size - 1; var_05++) {
    if(var_04[var_05] == param_01) {
      var_02 = var_04[var_05 + 1];
      break;
    }
  }

  if(isDefined(var_02)) {
    var_06 = tablelookuprownum("mp/statstable.csv", 28, var_02);
    while(var_06 >= 0) {
      var_07 = tablelookupbyrow("mp/statstable.csv", var_06, 2);
      var_03 = var_03 + self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_07, param_01);
      var_06 = tablelookuprownum("mp/statstable.csv", 28, var_02, var_06 - 1);
    }

    if(param_01 == "kills" && isDefined(self.var_9BBA)) {
      var_03 = var_03 + self.var_9BBA;
    }

    if(param_01 == "hipfirekills" && isDefined(self.var_9BB8)) {
      var_03 = var_03 + self.var_9BB8;
    }

    if(param_01 == "headShots" && isDefined(self.var_9BB7)) {
      var_03 = var_03 + self.var_9BB7;
    }

    var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "attachUnlock_" + param_01, var_02);
    if(var_08 > var_03) {
      var_08 = 0;
    }

    return var_03 - var_08;
  }
}

func_5527() {
  return function_0367() && function_02C6(getDvar("1673"), "mp_hub_zombies");
}

shoulddohubtutorialflow() {
  return !func_5527() && !maps\mp\_utility::func_585F() && getdvarint("mm_hub_tutorial_enabled", 0) == 1;
}