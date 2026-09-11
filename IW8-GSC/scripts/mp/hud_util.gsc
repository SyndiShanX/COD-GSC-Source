/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_util.gsc
***********************************************/

function setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }

  if(isDefined(self.parent)) {
    removechild(self.parent, self);
  }

  self.parent = var_0;
  addchild(self.parent, self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  setpoint("TOPLEFT");
}

function getparent() {
  return self.parent;
}

function removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }

  self.childchecktime = gettime();
  var_0 = [];

  foreach(var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }

    var_2.index = var_0.size;
    var_0 = var_2;
  }

  self.children = var_0;
}

function addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

function removechild(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

function setpoint(var_0, var_1, var_2, var_3, var_4) {
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

  if(scripts\mp\utility\script::strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_8 == "center" || var_7.alignx == "center") {
    var_8 = int(var_7.width / 2);

    if(var_8 == "left_adjustable" || var_7.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_8.width;

    if(var_9 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_9.x + var_9 * var_9;

  if(scripts\mp\utility\script::strip_suffix(var_8, "_adjustable") == var_9.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_9 == "middle" || var_8.aligny == "middle") {
    var_10 = int(var_8.height / 2);

    if(var_9 == "top_adjustable" || var_8.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_10.height;

    if(var_10 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_11.y + var_11 * var_11;
  self.x += self.xoffset;
  self.y += self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var_9, var_8, var_9, var_9);
      break;
  }

  updatechildren();
}

function setpointbar(var_0, var_1, var_2, var_3) {
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

function updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
    return;
  }
}

function updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / -1 * var_1, 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

function createfontstring(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  setparent(var_2, level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

function createservertimer(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "timer";
  var_3.font = var_1;
  var_3.fontscale = var_2;
  var_3.basefontscale = var_2;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_2);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  setparent(var_3, level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

function createtimer(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  setparent(var_2, level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

function createicon(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.elemtype = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = var_1;
  var_3.height = var_2;
  var_3.basewidth = var_3.width;
  var_3.baseheight = var_3.height;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  setparent(var_3, level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3.shader = var_0;
  }

  return var_3;
}

function createbar(var_0, var_1, var_2, var_3) {
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
  setparent(var_5, level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

function getcurrentfraction() {
  var_0 = self.bar.frac;

  if(isDefined(self.bar.rateofchange)) {
    var_0 += (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;

    if(var_0 > 1) {
      var_0 = 1;
    }

    if(var_0 < 0) {
      var_0 = 0;
    }
  }

  return var_0;
}

function createprimaryprogressbar(var_0, var_1) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self issplitscreenplayer()) {
    var_1 += 20;
  }

  var_2 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  setpoint(var_2, "CENTER", undefined, level.primaryprogressbarx + var_0, level.primaryprogressbary + var_1);
  return var_2;
}

function createprimaryprogressbartext(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self issplitscreenplayer()) {
    var_1 += 20;
  }

  var_4 = level.primaryprogressbarfontsize;
  var_5 = "default";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = createfontstring(var_5, var_4);
  setpoint(var_6, "CENTER", undefined, level.primaryprogressbartextx + var_0, level.primaryprogressbartexty + var_1);
  var_6.sort = -1;
  return var_6;
}

function setflashfrac(var_0) {
  self.bar.flashfrac = var_0;
}

function hideelem() {
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
      return;
    }

    return;
  }
}

function showelem() {
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
    return;
  }
}

function flashthread() {
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

function destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0 = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    setparent(var_0[var_1], getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

function seticonshader(var_0) {
  self setshader(var_0, self.width, self.height);
  self.shader = var_0;
}

function geticonshader(var_0) {
  return self.shader;
}

function seticonsize(var_0, var_1) {
  self setshader(self.shader, var_0, var_1);
}

function setwidth(var_0) {
  self.width = var_0;
}

function setheight(var_0) {
  self.height = var_0;
}

function setsize(var_0, var_1) {
  self.width = var_0;
  self.height = var_1;
}

function updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    setpoint(var_1, var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

function transitionreset() {
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

function transitionzoomin(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var_0, self.width, self.height);
      break;
  }
}

function transitionpulsefxin(var_0, var_1) {
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

function transitionslidein(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  switch (var_1) {
    case "left":
      self.x += 1000;
      break;
    case "right":
      self.x -= 1000;
      break;
    case "up":
      self.y -= 1000;
      break;
    case "down":
      self.y += 1000;
      break;
  }

  self moveovertime(var_0);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

function transitionslideout(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  var_2 = self.xoffset;
  var_3 = self.yoffset;

  switch (var_1) {
    case "left":
      var_2 += 1000;
      break;
    case "right":
      var_2 -= 1000;
      break;
    case "up":
      var_3 -= 1000;
      break;
    case "down":
      var_3 += 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_0);
  self.x = var_2;
  self.y = var_3;
}

function transitionzoomout(var_0) {
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

function transitionfadein(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
    return;
  }

  self.alpha = 1;
}

function transitionfadeout(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

function teamplayercardsplash(var_0, var_1, var_2, var_3, var_4) {
  if(level.hardcoremode) {
    return;
  }

  if(!canshowsplash(var_0)) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    var_5 = scripts\mp\utility\teams::getteamdata(var_1.team, "players");

    if(isDefined(var_5)) {
      foreach(var_7 in var_5) {
        if(!isDefined(var_7) || !scripts\mp\utility\player::isreallyalive(var_7) || var_7 scripts\mp\gametypes\br_public::isplayeringulag()) {
          continue;
        }

        if(!istrue(var_4)) {
          var_7 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
        }
      }

      return;
    }

    return;
  }

  foreach(var_7 in level.players) {
    if(var_7 ismlgspectator()) {
      var_10 = var_7 getspectatingplayer();

      if(isDefined(var_10) && isDefined(var_5) && var_10.team != var_5) {
        continue;
      }
    } else {
      if(isDefined(var_5) && var_7.team != var_5) {
        continue;
      }

      if(!isPlayer(var_7)) {
        continue;
      }
    }

    if(!isDefined(var_7)) {
      var_7 thread scripts\mp\hud_message::showsplash(var_3, var_6, var_4);
    }
  }
}

function iskillstreakcalloutsplash(var_0) {
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

    if(isDefined(var_3) && isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_3])) {
      var_1 = 1;
    }
  }

  return var_1;
}

function iseventcalloutsplash(var_0) {
  return issubstr(var_0, "callout_");
}

function getbaseeventcalloutsplash(var_0) {
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

function canshowsplash(var_0) {
  var_1 = 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "brtdm":
    case "arm":
      if(iskillstreakcalloutsplash(var_0)) {
        var_1 = 0;
      } else if(iseventcalloutsplash(var_0)) {
        var_2 = getbaseeventcalloutsplash(var_0);

        switch (var_2) {
          case "firstblood":
          case "9xkill":
          case "8xkill":
          case "7xkill":
          case "6xkill":
          case "5xkill":
          case "4xkill":
          case "3xkill":
            var_1 = 0;
            break;
        }
      }

      break;
    case "br":
      if(iseventcalloutsplash(var_0)) {
        var_2 = getbaseeventcalloutsplash(var_0);

        switch (var_2) {
          case "firstblood":
          case "9xkill":
          case "8xkill":
          case "7xkill":
          case "6xkill":
          case "5xkill":
          case "4xkill":
          case "3xkill":
            var_1 = 0;
            break;
        }
      }

      break;
  }

  return var_1;
}