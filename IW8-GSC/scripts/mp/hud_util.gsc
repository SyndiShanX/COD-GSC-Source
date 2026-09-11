/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_util.gsc
***********************************************/

function setparent(var0) {
  if(isDefined(self.parent) && self.parent == var0) {
    return;
  }

  if(isDefined(self.parent)) {
    removechild(self.parent, self);
  }

  self.parent = var0;
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
  var0 = [];

  foreach(var2 in self.children) {
    if(!isDefined(var2)) {
      continue;
    }

    var2.index = var0.size;
    var0 = var2;
  }

  self.children = var0;
}

function addchild(var0) {
  var0.index = self.children.size;
  self.children[self.children.size] = var0;
  removedestroyedchildren();
}

function removechild(var0) {
  var0.parent = undefined;

  if(self.children[self.children.size - 1] != var0) {
    self.children[var0.index] = self.children[self.children.size - 1];
    self.children[var0.index].index = var0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var0.index = undefined;
}

function setpoint(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = getparent();

  if(var4) {
    self moveovertime(var4);
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  self.xoffset = var2;

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self.yoffset = var3;
  self.point = var0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var0, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var0, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var0, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var0, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var1)) {
    var1 = var0;
  }

  self.relativepoint = var1;
  var6 = "center_adjustable";
  var7 = "middle";

  if(issubstr(var1, "TOP")) {
    var7 = "top_adjustable";
  }

  if(issubstr(var1, "BOTTOM")) {
    var7 = "bottom_adjustable";
  }

  if(issubstr(var1, "LEFT")) {
    var6 = "left_adjustable";
  }

  if(issubstr(var1, "RIGHT")) {
    var6 = "right_adjustable";
  }

  if(var5 == level.uiparent) {
    self.horzalign = var6;
    self.vertalign = var7;
  } else {
    self.horzalign = var5.horzalign;
    self.vertalign = var5.vertalign;
  }

  if(scripts\mp\utility\script::strip_suffix(var6, "_adjustable") == var5.alignx) {
    var8 = 0;
    var9 = 0;
  } else if(var8 == "center" || var7.alignx == "center") {
    var8 = int(var7.width / 2);

    if(var8 == "left_adjustable" || var7.alignx == "right") {
      var9 = -1;
    } else {
      var9 = 1;
    }
  } else {
    var8 = var8.width;

    if(var9 == "left_adjustable") {
      var9 = -1;
    } else {
      var9 = 1;
    }
  }

  self.x = var9.x + var9 * var9;

  if(scripts\mp\utility\script::strip_suffix(var8, "_adjustable") == var9.aligny) {
    var10 = 0;
    var11 = 0;
  } else if(var9 == "middle" || var8.aligny == "middle") {
    var10 = int(var8.height / 2);

    if(var9 == "top_adjustable" || var8.aligny == "bottom") {
      var11 = -1;
    } else {
      var11 = 1;
    }
  } else {
    var10 = var10.height;

    if(var10 == "top_adjustable") {
      var11 = -1;
    } else {
      var11 = 1;
    }
  }

  self.y = var11.y + var11 * var11;
  self.x += self.xoffset;
  self.y += self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var9, var8, var9, var9);
      break;
  }

  updatechildren();
}

function setpointbar(var0, var1, var2, var3) {
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

function updatebar(var0, var1) {
  if(self.elemtype == "bar") {
    updatebarscale(var0, var1);
    return;
  }
}

function updatebarscale(var0, var1) {
  var2 = int(self.width * var0 + 0.5);

  if(!var2) {
    var2 = 1;
  }

  self.bar.frac = var0;
  self.bar setshader(self.bar.shader, var2, self.height);

  if(isDefined(var1) && var2 < self.width) {
    if(var1 > 0) {
      self.bar scaleovertime((1 - var0) / var1, self.width, self.height);
    } else if(var1 < 0) {
      self.bar scaleovertime(var0 / -1 * var1, 1, self.height);
    }
  }

  self.bar.rateofchange = var1;
  self.bar.lastupdatetime = gettime();
}

function createfontstring(var0, var1) {
  var2 = newclienthudelem(self);
  var2.elemtype = "font";
  var2.font = var0;
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  var2.hidden = 0;
  return var2;
}

function createservertimer(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = newteamhudelem(var2);
  } else {
    var3 = newhudelem();
  }

  var3.elemtype = "timer";
  var3.font = var1;
  var3.fontscale = var2;
  var3.basefontscale = var2;
  var3.x = 0;
  var3.y = 0;
  var3.width = 0;
  var3.height = int(level.fontheight * var2);
  var3.xoffset = 0;
  var3.yoffset = 0;
  var3.children = [];
  setparent(var3, level.uiparent);
  var3.hidden = 0;
  return var3;
}

function createtimer(var0, var1) {
  var2 = newclienthudelem(self);
  var2.elemtype = "timer";
  var2.font = var0;
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  var2.hidden = 0;
  return var2;
}

function createicon(var0, var1, var2) {
  var3 = newclienthudelem(self);
  var3.elemtype = "icon";
  var3.x = 0;
  var3.y = 0;
  var3.width = var1;
  var3.height = var2;
  var3.basewidth = var3.width;
  var3.baseheight = var3.height;
  var3.xoffset = 0;
  var3.yoffset = 0;
  var3.children = [];
  setparent(var3, level.uiparent);
  var3.hidden = 0;

  if(isDefined(var0)) {
    var3 setshader(var0, var1, var2);
    var3.shader = var0;
  }

  return var3;
}

function createbar(var0, var1, var2, var3) {
  var4 = newclienthudelem(self);
  var4.x = 0;
  var4.y = 0;
  var4.frac = 0;
  var4.color = var0;
  var4.sort = -2;
  var4.shader = "progress_bar_fill";
  var4 setshader("progress_bar_fill", var1, var2);
  var4.hidden = 0;

  if(isDefined(var3)) {
    var4.flashfrac = var3;
  }

  var5 = newclienthudelem(self);
  var5.elemtype = "bar";
  var5.width = var1;
  var5.height = var2;
  var5.xoffset = 0;
  var5.yoffset = 0;
  var5.bar = var4;
  var5.children = [];
  var5.sort = -3;
  var5.color = (0, 0, 0);
  var5.alpha = 0.5;
  setparent(var5, level.uiparent);
  var5 setshader("progress_bar_bg", var1 + 4, var2 + 4);
  var5.hidden = 0;
  return var5;
}

function getcurrentfraction() {
  var0 = self.bar.frac;

  if(isDefined(self.bar.rateofchange)) {
    var0 += (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;

    if(var0 > 1) {
      var0 = 1;
    }

    if(var0 < 0) {
      var0 = 0;
    }
  }

  return var0;
}

function createprimaryprogressbar(var0, var1) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = -25;
  }

  if(self issplitscreenplayer()) {
    var1 += 20;
  }

  var2 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  setpoint(var2, "CENTER", undefined, level.primaryprogressbarx + var0, level.primaryprogressbary + var1);
  return var2;
}

function createprimaryprogressbartext(var0, var1, var2, var3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = -25;
  }

  if(self issplitscreenplayer()) {
    var1 += 20;
  }

  var4 = level.primaryprogressbarfontsize;
  var5 = "default";

  if(isDefined(var2)) {
    var4 = var2;
  }

  if(isDefined(var3)) {
    var5 = var3;
  }

  var6 = createfontstring(var5, var4);
  setpoint(var6, "CENTER", undefined, level.primaryprogressbartextx + var0, level.primaryprogressbartexty + var1);
  var6.sort = -1;
  return var6;
}

function setflashfrac(var0) {
  self.bar.flashfrac = var0;
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
  var0 = [];

  for(var1 = 0; var1 < self.children.size; var1++) {
    if(isDefined(self.children[var1])) {
      var0 = self.children[var1];
    }
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    setparent(var0[var1], getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

function seticonshader(var0) {
  self setshader(var0, self.width, self.height);
  self.shader = var0;
}

function geticonshader(var0) {
  return self.shader;
}

function seticonsize(var0, var1) {
  self setshader(self.shader, var0, var1);
}

function setwidth(var0) {
  self.width = var0;
}

function setheight(var0) {
  self.height = var0;
}

function setsize(var0, var1) {
  self.width = var0;
  self.height = var1;
}

function updatechildren() {
  for(var0 = 0; var0 < self.children.size; var0++) {
    var1 = self.children[var0];
    setpoint(var1, var1.point, var1.relativepoint, var1.xoffset, var1.yoffset);
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

function transitionzoomin(var0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var0);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var0, self.width, self.height);
      break;
  }
}

function transitionpulsefxin(var0, var1) {
  var2 = int(var0) * 1000;
  var3 = int(var1) * 1000;

  switch (self.elemtype) {
    case "timer":
    case "font":
      self setpulsefx(var2 + 250, var3 + var2, var2 + 250);
      break;
    default:
      break;
  }
}

function transitionslidein(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "left";
  }

  switch (var1) {
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

  self moveovertime(var0);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

function transitionslideout(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "left";
  }

  var2 = self.xoffset;
  var3 = self.yoffset;

  switch (var1) {
    case "left":
      var2 += 1000;
      break;
    case "right":
      var2 -= 1000;
      break;
    case "up":
      var3 -= 1000;
      break;
    case "down":
      var3 += 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var0);
  self.x = var2;
  self.y = var3;
}

function transitionzoomout(var0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(var0);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var0, self.width * 6, self.height * 6);
      break;
  }
}

function transitionfadein(var0) {
  self fadeovertime(var0);

  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
    return;
  }

  self.alpha = 1;
}

function transitionfadeout(var0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

function teamplayercardsplash(var0, var1, var2, var3, var4) {
  if(level.hardcoremode) {
    return;
  }

  if(!canshowsplash(var0)) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    var5 = scripts\mp\utility\teams::getteamdata(var1.team, "players");

    if(isDefined(var5)) {
      foreach(var7 in var5) {
        if(!isDefined(var7) || !scripts\mp\utility\player::isreallyalive(var7) || var7 scripts\mp\gametypes\br_public::isplayeringulag()) {
          continue;
        }

        if(!istrue(var4)) {
          var7 thread scripts\mp\hud_message::showsplash(var0, var3, var1);
        }
      }

      return;
    }

    return;
  }

  foreach(var7 in level.players) {
    if(var7 ismlgspectator()) {
      var10 = var7 getspectatingplayer();

      if(isDefined(var10) && isDefined(var5) && var10.team != var5) {
        continue;
      }
    } else {
      if(isDefined(var5) && var7.team != var5) {
        continue;
      }

      if(!isPlayer(var7)) {
        continue;
      }
    }

    if(!isDefined(var7)) {
      var7 thread scripts\mp\hud_message::showsplash(var3, var6, var4);
    }
  }
}

function iskillstreakcalloutsplash(var0) {
  var1 = 0;

  if(issubstr(var0, "used_")) {
    var2 = strtok(var0, "_");
    var3 = undefined;

    foreach(var5 in var2) {
      if(var5 == "used") {
        continue;
      }

      if(!isDefined(var3)) {
        var3 = var5;
        continue;
      }

      var3 = var3 + "_" + var5;
    }

    if(isDefined(var3) && isDefined(level.killstreakglobals.streaktable.tabledatabyref[var3])) {
      var1 = 1;
    }
  }

  return var1;
}

function iseventcalloutsplash(var0) {
  return issubstr(var0, "callout_");
}

function getbaseeventcalloutsplash(var0) {
  var1 = undefined;
  var2 = strtok(var0, "_");

  foreach(var4 in var2) {
    if(var4 == "callout") {
      continue;
    }

    if(!isDefined(var1)) {
      var1 = var4;
      continue;
    }

    var1 = var1 + "_" + var4;
  }

  return var1;
}

function canshowsplash(var0) {
  var1 = 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "brtdm":
    case "arm":
      if(iskillstreakcalloutsplash(var0)) {
        var1 = 0;
      } else if(iseventcalloutsplash(var0)) {
        var2 = getbaseeventcalloutsplash(var0);

        switch (var2) {
          case "firstblood":
          case "9xkill":
          case "8xkill":
          case "7xkill":
          case "6xkill":
          case "5xkill":
          case "4xkill":
          case "3xkill":
            var1 = 0;
            break;
        }
      }

      break;
    case "br":
      if(iseventcalloutsplash(var0)) {
        var2 = getbaseeventcalloutsplash(var0);

        switch (var2) {
          case "firstblood":
          case "9xkill":
          case "8xkill":
          case "7xkill":
          case "6xkill":
          case "5xkill":
          case "4xkill":
          case "3xkill":
            var1 = 0;
            break;
        }
      }

      break;
  }

  return var1;
}