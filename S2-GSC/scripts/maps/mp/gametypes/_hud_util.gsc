/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_hud_util.gsc
***************************************************/

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isDefined(self.parent)) {
    self.parent removechild(self);
  }

  self.parent = var_0;
  self.parent _id_09A6(self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  } else {
    setpoint("TOPLEFT");
  }
}

getparent() {
  return self.parent;
}

_id_09A6(var_0) {
  var_0._id_00D4 = self.children.size;
  self.children[self.children.size] = var_0;
}

removechild(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0._id_00D4] = self.children[self.children.size - 1];
    self.children[var_0._id_00D4]._id_00D4 = var_0._id_00D4;
  }

  self.children[self.children.size - 1] = undefined;
  var_0._id_00D4 = undefined;
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
    self._id_00C6 = var_6;
    self._id_01CA = var_7;
  } else {
    self._id_00C6 = var_5._id_00C6;
    self._id_01CA = var_5._id_01CA;
  }

  if(_func_2FF(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5._id_01D2 / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5._id_01D2;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(_func_2FF(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5._id_00BD / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5._id_00BD;

    if(var_7 == "top_adjustable") {
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

  updatechildren();
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar._id_00C6 = self._id_00C6;
  self.bar._id_01CA = self._id_01CA;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self._id_01D2;
  } else {
    self.bar.x = self.x - int(self._id_01D2 / 2);
  }

  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }

  updatebar(self.bar.frac);
}

updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
  }
}

updatebarscale(var_0, var_1) {
  var_2 = int(self._id_01D2 * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self._id_00BD);

  if(isDefined(var_1) && var_2 < self._id_01D2) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self._id_01D2, self._id_00BD);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self._id_00BD);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

createfontstring(var_0, var_1) {
  var_2 = _newclienthudelem(self);
  var_2.elemtype = "font";
  var_2._id_009A = var_0;
  var_2._id_017A = 1;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2._id_01D2 = 0;
  var_2._id_00BD = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

createserverfontstring(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = _newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "font";
  var_3._id_009A = var_0;
  var_3._id_017A = 1;
  var_3.fontscale = var_1;
  var_3.basefontscale = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3._id_01D2 = 0;
  var_3._id_00BD = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

createservertimer(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = _newteamhudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "timer";
  var_3._id_009A = var_0;
  var_3._id_017A = 1;
  var_3.fontscale = var_1;
  var_3.basefontscale = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3._id_01D2 = 0;
  var_3._id_00BD = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

createtimer(var_0, var_1) {
  var_2 = _newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2._id_009A = var_0;
  var_2._id_017A = 1;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2._id_01D2 = 0;
  var_2._id_00BD = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

createicon(var_0, var_1, var_2) {
  var_3 = _newclienthudelem(self);
  var_3.elemtype = "icon";
  var_3.x = 0;
  var_3.y = 0;
  var_3._id_01D2 = var_1;
  var_3._id_00BD = var_2;
  var_3.basewidth = var_3._id_01D2;
  var_3.baseheight = var_3._id_00BD;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3.shader = var_0;
  }

  return var_3;
}

createservericon(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = _newteamhudelem(var_3);
  } else {
    var_4 = newhudelem();
  }

  var_4.elemtype = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4._id_01D2 = var_1;
  var_4._id_00BD = var_2;
  var_4.basewidth = var_4._id_01D2;
  var_4.baseheight = var_4._id_00BD;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  var_4 setparent(level.uiparent);
  var_4.hidden = 0;

  if(isDefined(var_0)) {
    var_4 setshader(var_0, var_1, var_2);
    var_4.shader = var_0;
  }

  return var_4;
}

createserverbar(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4)) {
    var_6 = _newteamhudelem(var_4);
  } else {
    var_6 = newhudelem();
  }

  var_6.x = 0;
  var_6.y = 0;
  var_6.frac = 0;
  var_6.color = var_0;
  var_6.sort = -2;
  var_6.shader = "progress_bar_fill";
  var_6 setshader("progress_bar_fill", var_1, var_2);
  var_6.hidden = 0;

  if(isDefined(var_3)) {
    var_6.flashfrac = var_3;
  }

  if(isDefined(var_4)) {
    var_7 = _newteamhudelem(var_4);
  } else {
    var_7 = newhudelem();
  }

  var_7.elemtype = "bar";
  var_7.x = 0;
  var_7.y = 0;
  var_7._id_01D2 = var_1;
  var_7._id_00BD = var_2;
  var_7.xoffset = 0;
  var_7.yoffset = 0;
  var_7.bar = var_6;
  var_7.children = [];
  var_7.sort = -3;
  var_7.color = (0, 0, 0);
  var_7.alpha = 0.5;
  var_7 setparent(level.uiparent);
  var_7 setshader("progress_bar_bg", var_1, var_2);
  var_7.hidden = 0;
  return var_7;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = _newclienthudelem(self);
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

  var_5 = _newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5._id_01D2 = var_1;
  var_5._id_00BD = var_2;
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

getcurrentfraction() {
  var_0 = self.bar.frac;

  if(isDefined(self.bar.rateofchange)) {
    var_0 = var_0 + (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange / 1000;

    if(var_0 > 1) {
      var_0 = 1;
    }

    if(var_0 < 0) {
      var_0 = 0;
    }
  }

  return var_0;
}

_id_2821(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(self issplitscreenplayer() && !xmodelalias/alias_ger_heads_urb_clean_par()) {
    var_1 = var_1 + 20;
  }

  if(_func_367()) {
    var_3 = createbar((0.25, 0.58, 0.53), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  } else {
    var_3 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  }

  var_3 setpoint("CENTER", undefined, level.primaryprogressbarx + var_0, level.primaryprogressbary + var_1);
  return var_3;
}

createprimaryprogressbartext(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(self issplitscreenplayer() && !xmodelalias/alias_ger_heads_urb_clean_par()) {
    var_1 = var_1 + 20;
  }

  if(_func_367()) {
    var_2 = createfontstring("mphubfont", 1.4);
  } else {
    var_2 = createfontstring("hudbig", level.primaryprogressbarfontsize);
  }

  var_2 setpoint("CENTER", undefined, level.primaryprogressbartextx + var_0, level.primaryprogressbartexty + var_1);
  var_2.sort = -1;
  return var_2;
}

createteamprogressbar(var_0) {
  var_1 = createserverbar((1, 0, 0), level.teamprogressbarwidth, level.teamprogressbarheight, undefined, var_0);
  var_1 setpoint("TOP", undefined, 0, level.teamprogressbary);
  return var_1;
}

createteamprogressbartext(var_0) {
  var_1 = createserverfontstring("default", level.teamprogressbarfontsize, var_0);
  var_1 setpoint("TOP", undefined, 0, level.teamprogressbartexty);
  return var_1;
}

setflashfrac(var_0) {
  self.bar.flashfrac = var_0;
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

    waitframe();
  }
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

seticonshader(var_0) {
  self setshader(var_0, self._id_01D2, self._id_00BD);
  self.shader = var_0;
}

geticonshader(var_0) {
  return self.shader;
}

seticonsize(var_0, var_1) {
  self setshader(self.shader, var_0, var_1);
}

setwidth(var_0) {
  self._id_01D2 = var_0;
}

setheight(var_0) {
  self._id_00BD = var_0;
}

setsize(var_0, var_1) {
  self._id_01D2 = var_0;
  self._id_00BD = var_1;
}

updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

transitionreset() {
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "font") {
    self.fontscale = self.basefontscale;
    self.label = &"";
  } else if(self.elemtype == "icon")
    self setshader(self.shader, self._id_01D2, self._id_00BD);

  self.alpha = 0;
}

transitionzoomin(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self._id_01D2 * 6, self._id_00BD * 6);
      self scaleovertime(var_0, self._id_01D2, self._id_00BD);
      break;
  }
}

transitionpulsefxin(var_0, var_1) {
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

transitionslidein(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  switch (var_1) {
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

  self moveovertime(var_0);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "left";
  }

  var_2 = self.xoffset;
  var_3 = self.yoffset;

  switch (var_1) {
    case "left":
      var_2 = var_2 + 1000;
      break;
    case "right":
      var_2 = var_2 - 1000;
      break;
    case "up":
      var_3 = var_3 - 1000;
      break;
    case "down":
      var_3 = var_3 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_0);
  self.x = var_2;
  self.y = var_3;
}

transitionzoomout(var_0) {
  switch (self.elemtype) {
    case "timer":
    case "font":
      self changefontscaleovertime(var_0);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(var_0, self._id_01D2 * 6, self._id_00BD * 6);
      break;
  }
}

transitionfadein(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self.maxalpha)) {
    self.alpha = self.maxalpha;
  } else {
    self.alpha = 1;
  }
}

transitionfadeout(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

istimelimitedchallenge(var_0) {
  if(issubstr(var_0, "ch_limited")) {
    return 1;
  }

  return 0;
}

isweaponclasschallenge(var_0) {
  if(common_scripts\utility::string_starts_with(var_0, "ch_attach_unlock_kills")) {
    return 1;
  }

  if(common_scripts\utility::string_starts_with(var_0, "ch_attach_unlock_hipfirekills")) {
    return 1;
  }

  if(common_scripts\utility::string_starts_with(var_0, "ch_attach_unlock_headShots")) {
    return 1;
  }

  return 0;
}

ch_getprogress(var_0) {
  if(isweaponclasschallenge(var_0)) {
    return processviaitemstatsprogress(var_0);
  }

  return self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "challengeProgress", var_0);
}

ch_getstate(var_0) {
  if(isweaponclasschallenge(var_0)) {
    return processviaitemstatsstate(var_0);
  } else {
    return self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "challengeState", var_0);
  }
}

ch_setprogress(var_0, var_1) {
  if(isweaponclasschallenge(var_0)) {
    return;
  }
  var_2 = maps\mp\_utility::clamptoshort(var_1);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "challengeProgress", var_0, var_2);

  if(issubstr(var_0, "ch_daily_") && var_2 > 0) {
    thread maps\mp\gametypes\_hud_message::splashnotify(var_0, var_2);
  }
}

ch_setstate(var_0, var_1) {
  if(isweaponclasschallenge(var_0)) {
    return;
  } else {
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "challengeState", var_0, var_1);
  }
}

ch_gettarget(var_0, var_1) {
  if(issubstr(var_0, "ch_daily")) {
    var_2 = tablelookup("mp/dailyChallengesTable.csv", 0, var_0, 9);
  } else {
    var_2 = tablelookup("mp/allChallengesTable.csv", 0, var_0, 9 + (var_1 - 1) * 2);
  }

  if(isDefined(var_2) && var_2 != "") {
    return int(var_2);
  }

  return 0;
}

displayclientstring(var_0, var_1, var_2, var_3) {
  var_4 = createfontstring("hudbig", var_2);
  var_4 setpoint("CENTER", "CENTER", 0, var_1);
  var_4.sort = 1001;
  var_4.color = (1, 1, 1);
  var_4.foreground = 0;
  var_4.hidewheninmenu = 1;
  var_4 settext(var_0);
  common_scripts\utility::waittill_any(var_3, "joined_team", "death");

  if(isDefined(var_4)) {
    var_4 destroyelem();
  }
}

processviaitemstatsprogress(var_0) {
  if(common_scripts\utility::string_starts_with(var_0, "ch_attach_unlock_hipfirekills")) {
    return totalallweaponvariants(var_0, "hipfirekills");
  } else if(common_scripts\utility::string_starts_with(var_0, "ch_attach_unlock_kills")) {
    return totalallweaponvariants(var_0, "kills");
  } else if(common_scripts\utility::string_starts_with(var_0, "ch_attach_unlock_headShots")) {
    return totalallweaponvariants(var_0, "headShots");
  }
}

processviaitemstatsstate(var_0) {
  var_1 = processviaitemstatsprogress(var_0);
  var_2 = 1;

  for(var_3 = ch_gettarget(var_0, var_2); var_3 > 0 && var_1 >= var_3; var_3 = ch_gettarget(var_0, var_2)) {
    var_2++;
  }

  return var_2;
}

totalallweaponvariants(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;
  var_4 = strtok(var_0, "_");

  for(var_5 = 0; var_5 < var_4.size - 1; var_5++) {
    if(var_4[var_5] == var_1) {
      var_2 = var_4[var_5 + 1];
      break;
    }
  }

  if(isDefined(var_2)) {
    for(var_6 = _tablelookuprownum("mp/statstable.csv", 28, var_2); var_6 >= 0; var_6 = _tablelookuprownum("mp/statstable.csv", 28, var_2, var_6 - 1)) {
      var_7 = _tablelookupbyrow("mp/statstable.csv", var_6, 2);
      var_3 = var_3 + self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "weaponStats", var_7, var_1);
    }

    if(var_1 == "kills" && isDefined(self.trackingweaponkills)) {
      var_3 = var_3 + self.trackingweaponkills;
    }

    if(var_1 == "hipfirekills" && isDefined(self.trackingweaponhipfirekills)) {
      var_3 = var_3 + self.trackingweaponhipfirekills;
    }

    if(var_1 == "headShots" && isDefined(self.trackingweaponheadshots)) {
      var_3 = var_3 + self.trackingweaponheadshots;
    }

    var_8 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "attachUnlock_" + var_1, var_2);

    if(var_8 > var_3) {
      var_8 = 0;
    }

    return var_3 - var_8;
  }
}

_id_5527() {
  return _func_367() && _func_2C6(getDvar("1673"), "mp_hub_zombies");
}

shoulddohubtutorialflow() {
  return !_id_5527() && !maps\mp\_utility::_id_585F() && getdvarint("mm_hub_tutorial_enabled", 0) == 1;
}