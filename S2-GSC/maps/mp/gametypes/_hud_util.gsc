/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud_util.gsc
*********************************************/

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

addchild(param_00) {
  param_00.index = self.children.size;
  self.children[self.children.size] = param_00;
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

  if(function_02FF(var_06, "_adjustable") == var_05.alignx) {
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
  if(function_02FF(var_07, "_adjustable") == var_05.aligny) {
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

createfontstring(param_00, param_01) {
  var_02 = newclienthudelem(self);
  var_02.elemtype = "font";
  var_02.font = param_00;
  var_02.shadowed = 1;
  var_02.fontscale = param_01;
  var_02.basefontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  var_02.hidden = 0;
  return var_02;
}

createserverfontstring(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = newteamhudelem(param_02);
  } else {
    var_03 = newhudelem();
  }

  var_03.elemtype = "font";
  var_03.font = param_00;
  var_03.shadowed = 1;
  var_03.fontscale = param_01;
  var_03.basefontscale = param_01;
  var_03.x = 0;
  var_03.y = 0;
  var_03.width = 0;
  var_03.height = int(level.fontheight * param_01);
  var_03.xoffset = 0;
  var_03.yoffset = 0;
  var_03.children = [];
  var_03 setparent(level.uiparent);
  var_03.hidden = 0;
  return var_03;
}

createservertimer(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = newteamhudelem(param_02);
  } else {
    var_03 = newhudelem();
  }

  var_03.elemtype = "timer";
  var_03.font = param_00;
  var_03.shadowed = 1;
  var_03.fontscale = param_01;
  var_03.basefontscale = param_01;
  var_03.x = 0;
  var_03.y = 0;
  var_03.width = 0;
  var_03.height = int(level.fontheight * param_01);
  var_03.xoffset = 0;
  var_03.yoffset = 0;
  var_03.children = [];
  var_03 setparent(level.uiparent);
  var_03.hidden = 0;
  return var_03;
}

createtimer(param_00, param_01) {
  var_02 = newclienthudelem(self);
  var_02.elemtype = "timer";
  var_02.font = param_00;
  var_02.shadowed = 1;
  var_02.fontscale = param_01;
  var_02.basefontscale = param_01;
  var_02.x = 0;
  var_02.y = 0;
  var_02.width = 0;
  var_02.height = int(level.fontheight * param_01);
  var_02.xoffset = 0;
  var_02.yoffset = 0;
  var_02.children = [];
  var_02 setparent(level.uiparent);
  var_02.hidden = 0;
  return var_02;
}

createicon(param_00, param_01, param_02) {
  var_03 = newclienthudelem(self);
  var_03.elemtype = "icon";
  var_03.x = 0;
  var_03.y = 0;
  var_03.width = param_01;
  var_03.height = param_02;
  var_03.basewidth = var_03.width;
  var_03.baseheight = var_03.height;
  var_03.xoffset = 0;
  var_03.yoffset = 0;
  var_03.children = [];
  var_03 setparent(level.uiparent);
  var_03.hidden = 0;
  if(isDefined(param_00)) {
    var_03 setshader(param_00, param_01, param_02);
    var_03.shader = param_00;
  }

  return var_03;
}

createservericon(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    var_04 = newteamhudelem(param_03);
  } else {
    var_04 = newhudelem();
  }

  var_04.elemtype = "icon";
  var_04.x = 0;
  var_04.y = 0;
  var_04.width = param_01;
  var_04.height = param_02;
  var_04.basewidth = var_04.width;
  var_04.baseheight = var_04.height;
  var_04.xoffset = 0;
  var_04.yoffset = 0;
  var_04.children = [];
  var_04 setparent(level.uiparent);
  var_04.hidden = 0;
  if(isDefined(param_00)) {
    var_04 setshader(param_00, param_01, param_02);
    var_04.shader = param_00;
  }

  return var_04;
}

createserverbar(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_04)) {
    var_06 = newteamhudelem(param_04);
  } else {
    var_06 = newhudelem();
  }

  var_06.x = 0;
  var_06.y = 0;
  var_06.frac = 0;
  var_06.color = param_00;
  var_06.sort = -2;
  var_06.shader = "progress_bar_fill";
  var_06 setshader("progress_bar_fill", param_01, param_02);
  var_06.hidden = 0;
  if(isDefined(param_03)) {
    var_06.flashfrac = param_03;
  }

  if(isDefined(param_04)) {
    var_07 = newteamhudelem(param_04);
  } else {
    var_07 = newhudelem();
  }

  var_07.elemtype = "bar";
  var_07.x = 0;
  var_07.y = 0;
  var_07.width = param_01;
  var_07.height = param_02;
  var_07.xoffset = 0;
  var_07.yoffset = 0;
  var_07.bar = var_06;
  var_07.children = [];
  var_07.sort = -3;
  var_07.color = (0, 0, 0);
  var_07.alpha = 0.5;
  var_07 setparent(level.uiparent);
  var_07 setshader("progress_bar_bg", param_01, param_02);
  var_07.hidden = 0;
  return var_07;
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

getcurrentfraction() {
  var_00 = self.bar.frac;
  if(isDefined(self.bar.rateofchange)) {
    var_00 = var_00 + gettime() - self.bar.lastupdatetime * self.bar.rateofchange / 1000;
    if(var_00 > 1) {
      var_00 = 1;
    }

    if(var_00 < 0) {
      var_00 = 0;
    }
  }

  return var_00;
}

createprimaryprogressbar(param_00, param_01, param_02) {
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
    var_03 = createbar((0.25, 0.58, 0.53), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  } else {
    var_03 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  }

  var_03 setpoint("CENTER", undefined, level.primaryprogressbarx + param_00, level.primaryprogressbary + param_01);
  return var_03;
}

createprimaryprogressbartext(param_00, param_01) {
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
    var_02 = createfontstring("mphubfont", 1.4);
  } else {
    var_02 = createfontstring("hudbig", level.primaryprogressbarfontsize);
  }

  var_02 setpoint("CENTER", undefined, level.primaryprogressbartextx + param_00, level.primaryprogressbartexty + param_01);
  var_02.sort = -1;
  return var_02;
}

createteamprogressbar(param_00) {
  var_01 = createserverbar((1, 0, 0), level.teamprogressbarwidth, level.teamprogressbarheight, undefined, param_00);
  var_01 setpoint("TOP", undefined, 0, level.teamprogressbary);
  return var_01;
}

createteamprogressbartext(param_00) {
  var_01 = createserverfontstring("default", level.teamprogressbarfontsize, param_00);
  var_01 setpoint("TOP", undefined, 0, level.teamprogressbartexty);
  return var_01;
}

setflashfrac(param_00) {
  self.bar.flashfrac = param_00;
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
      return;
    }

    return;
  }

  if(self.alpha != 1) {
    self.alpha = 1;
  }
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
        wait(0.35);
        self fadeovertime(0.3);
        self.alpha = 1;
      }

      wait(0.7);
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

seticonshader(param_00) {
  self setshader(param_00, self.width, self.height);
  self.shader = param_00;
}

geticonshader(param_00) {
  return self.shader;
}

seticonsize(param_00, param_01) {
  self setshader(self.shader, param_00, param_01);
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

updatechildren() {
  for(var_00 = 0; var_00 < self.children.size; var_00++) {
    var_01 = self.children[var_00];
    var_01 setpoint(var_01.point, var_01.relativepoint, var_01.xoffset, var_01.yoffset);
  }
}

transitionreset() {
  self.x = self.xoffset;
  self.y = self.yoffset;
  if(self.elemtype == "font") {
    self.fontscale = self.basefontscale;
    self.label = &"";
  } else if(self.elemtype == "icon") {
    self setshader(self.shader, self.width, self.height);
  }

  self.alpha = 0;
}

transitionzoomin(param_00) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(param_00);
      self.fontscale = self.basefontscale;
      break;

    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(param_00, self.width, self.height);
      break;
  }
}

transitionpulsefxin(param_00, param_01) {
  var_02 = int(param_00) * 1000;
  var_03 = int(param_01) * 1000;
  switch (self.elemtype) {
    case "timer":
    case "font":
      self setpulsefx(var_02 + 250, var_03 + var_02, var_02 + 250);
      break;

    default:
      break;
  }
}

transitionslidein(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "left";
  }

  switch (param_01) {
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

  self moveovertime(param_00);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "left";
  }

  var_02 = self.xoffset;
  var_03 = self.yoffset;
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

  self.alpha = 1;
  self moveovertime(param_00);
  self.x = var_02;
  self.y = var_03;
}

transitionzoomout(param_00) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(param_00);
      self.fontscale = 6.3;
      break;

    case "icon":
      self scaleovertime(param_00, self.width * 6, self.height * 6);
      break;
  }
}

transitionfadein(param_00) {
  self fadeovertime(param_00);
  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
    return;
  }

  self.alpha = 1;
}

transitionfadeout(param_00) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

istimelimitedchallenge(param_00) {
  if(issubstr(param_00, "ch_limited")) {
    return 1;
  }

  return 0;
}

isweaponclasschallenge(param_00) {
  if(common_scripts\utility::string_starts_with(param_00, "ch_attach_unlock_kills")) {
    return 1;
  }

  if(common_scripts\utility::string_starts_with(param_00, "ch_attach_unlock_hipfirekills")) {
    return 1;
  }

  if(common_scripts\utility::string_starts_with(param_00, "ch_attach_unlock_headShots")) {
    return 1;
  }

  return 0;
}

ch_getprogress(param_00) {
  if(isweaponclasschallenge(param_00)) {
    return processviaitemstatsprogress(param_00);
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), "challengeProgress", param_00);
}

ch_getstate(param_00) {
  if(isweaponclasschallenge(param_00)) {
    return processviaitemstatsstate(param_00);
  }

  return self getrankedplayerdata(common_scripts\utility::func_46AE(), "challengeState", param_00);
}

ch_setprogress(param_00, param_01) {
  if(isweaponclasschallenge(param_00)) {
    return;
  }

  var_02 = maps\mp\_utility::clamptoshort(param_01);
  self setrankedplayerdata(common_scripts\utility::func_46AE(), "challengeProgress", param_00, var_02);
  if(issubstr(param_00, "ch_daily_") && var_02 > 0) {
    thread maps\mp\gametypes\_hud_message::func_9102(param_00, var_02);
  }
}

ch_setstate(param_00, param_01) {
  if(isweaponclasschallenge(param_00)) {
    return;
  }

  self setrankedplayerdata(common_scripts\utility::func_46AE(), "challengeState", param_00, param_01);
}

ch_gettarget(param_00, param_01) {
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

displayclientstring(param_00, param_01, param_02, param_03) {
  var_04 = createfontstring("hudbig", param_02);
  var_04 setpoint("CENTER", "CENTER", 0, param_01);
  var_04.sort = 1001;
  var_04.color = (1, 1, 1);
  var_04.foreground = 0;
  var_04.hidewheninmenu = 1;
  var_04 settext(param_00);
  common_scripts\utility::waittill_any(param_03, "joined_team", "death");
  if(isDefined(var_04)) {
    var_04 destroyelem();
  }
}

processviaitemstatsprogress(param_00) {
  if(common_scripts\utility::string_starts_with(param_00, "ch_attach_unlock_hipfirekills")) {
    return totalallweaponvariants(param_00, "hipfirekills");
  } else if(common_scripts\utility::string_starts_with(param_00, "ch_attach_unlock_kills")) {
    return totalallweaponvariants(param_00, "kills");
  } else if(common_scripts\utility::string_starts_with(param_00, "ch_attach_unlock_headShots")) {
    return totalallweaponvariants(param_00, "headShots");
  }
}

processviaitemstatsstate(param_00) {
  var_01 = processviaitemstatsprogress(param_00);
  var_02 = 1;
  for(var_03 = ch_gettarget(param_00, var_02); var_03 > 0 && var_01 >= var_03; var_03 = ch_gettarget(param_00, var_02)) {
    var_02++;
  }

  return var_02;
}

totalallweaponvariants(param_00, param_01) {
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

    if(param_01 == "kills" && isDefined(self.trackingweaponkills)) {
      var_03 = var_03 + self.trackingweaponkills;
    }

    if(param_01 == "hipfirekills" && isDefined(self.trackingweaponhipfirekills)) {
      var_03 = var_03 + self.trackingweaponhipfirekills;
    }

    if(param_01 == "headShots" && isDefined(self.trackingweaponheadshots)) {
      var_03 = var_03 + self.trackingweaponheadshots;
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