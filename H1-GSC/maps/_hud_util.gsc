/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_hud_util.gsc
********************************/

setparent(var_0) {
  if(isdefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isdefined(self.parent))
    self.parent removechild(self);

  self.parent = var_0;
  self.parent addchild(self);

  if(isdefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
    setpoint("TOPLEFT");
}

getparent() {
  return self.parent;
}

removedestroyedchildren() {
  if(isdefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  var_0 = [];

  foreach(var_3, var_2 in self.children) {
    if(!isdefined(var_2)) {
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
  if(!isdefined(var_4))
    var_4 = 0;

  var_5 = getparent();

  if(var_4)
    self moveovertime(var_4);

  if(!isdefined(var_2))
    var_2 = 0;

  self.xoffset = var_2;

  if(!isdefined(var_3))
    var_3 = 0;

  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP"))
    self.aligny = "top";

  if(issubstr(var_0, "BOTTOM"))
    self.aligny = "bottom";

  if(issubstr(var_0, "LEFT"))
    self.alignx = "left";

  if(issubstr(var_0, "RIGHT"))
    self.alignx = "right";

  if(!isdefined(var_1))
    var_1 = var_0;

  self.relativepoint = var_1;
  var_6 = "center";
  var_7 = "middle";

  if(issubstr(var_1, "TOP"))
    var_7 = "top";

  if(issubstr(var_1, "BOTTOM"))
    var_7 = "bottom";

  if(issubstr(var_1, "LEFT"))
    var_6 = "left";

  if(issubstr(var_1, "RIGHT"))
    var_6 = "right";

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

    if(var_6 == "left" || var_5.alignx == "right")
      var_9 = -1;
    else
      var_9 = 1;
  } else {
    var_8 = var_5.width;

    if(var_6 == "left")
      var_9 = -1;
    else
      var_9 = 1;
  }

  self.x = var_5.x + var_8 * var_9;

  if(var_7 == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top" || var_5.aligny == "bottom")
      var_11 = -1;
    else
      var_11 = 1;
  } else {
    var_10 = var_5.height;

    if(var_7 == "top")
      var_11 = -1;
    else
      var_11 = 1;
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
  self.bar.y = self.bar.offset_y + self.y;

  if(self.alignx == "left")
    self.bar.x = self.bar.offset_x + self.x + self.xpadding;
  else if(self.alignx == "right")
    self.bar.x = self.bar.offset_x + self.x - (self.width - self.xpadding);
  else
    self.bar.x = self.bar.offset_x + self.x - int((self.width - self.xpadding * 2) / 2);

  if(isdefined(self.progress_bg_distort)) {
    self.progress_bg_distort.x = self.x;
    self.progress_bg_distort.y = self.y;
    self.progress_bg_distort.horzalign = self.horzalign;
    self.progress_bg_distort.vertalign = self.vertalign;
    self.progress_bg_distort.alignx = self.alignx;
    self.progress_bg_distort.aligny = self.aligny;
  }

  updatebar(self.bar.frac);
}

updatebar(var_0) {
  var_1 = int((self.width - self.xpadding * 2) * var_0);

  if(!var_1)
    var_1 = 1;

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_1, self.height - self.ypadding * 2);
}

hidebar(var_0) {
  var_0 = common_scripts\utility::ter_op(isdefined(var_0), var_0, 1);

  if(var_0 || !isdefined(self.orig_alpha) || !isdefined(self.bar.orig_alpha)) {
    self.orig_alpha = self.alpha;
    self.bar.orig_alpha = self.bar.alpha;
  }

  self.alpha = common_scripts\utility::ter_op(var_0, 0, self.orig_alpha);
  self.bar.alpha = common_scripts\utility::ter_op(var_0, 0, self.bar.orig_alpha);
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

createclientfontstring(var_0, var_1) {
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

createclienttimer(var_0, var_1) {
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

createserverfontstring(var_0, var_1) {
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

createclienticon(var_0, var_1, var_2) {
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

  if(isdefined(var_1))
    var_0 setshader(var_1, var_2, var_3);

  return var_0;
}

h1_createbar(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = newhudelem();
  var_7.alignx = "center";
  var_7.aligny = "bottom";
  var_7.horzalign = "center";
  var_7.vertalign = "bottom";
  var_7.x = var_0;
  var_7.y = var_1 + 1;
  var_7.alpha = 0.9;
  var_7 setshader(var_5, var_2, var_3);
  var_7.sort = -2;
  var_8 = newhudelem();
  var_8 setshader(var_6, 10, 0);
  var_8.alignx = "right";
  var_8.aligny = "bottom";
  var_8.horzalign = "right";
  var_8.vertalign = "bottom";
  var_8.offset_x = 1;
  var_8.offset_y = -2;
  var_8.color = (1, 0.9, 0.1);
  var_8.alpha = 0.9;
  var_8.sort = 0;
  var_8.frac = 0.25;
  var_8.shader = var_6;
  var_9 = newhudelem();
  var_9.elemtype = "bar";
  var_9.alignx = "center";
  var_9.aligny = "bottom";
  var_9.horzalign = "center";
  var_9.vertalign = "bottom";
  var_9.x = var_0;
  var_9.y = var_1 + 1;
  var_9.alpha = 0.3;
  var_9 setshader(var_4, var_2, var_3);
  var_9.sort = -1;
  var_9.width = var_2;
  var_9.height = var_3;
  var_9.xpadding = 2;
  var_9.ypadding = 3;
  var_9.children = [];
  var_9.progress_bg_distort = var_7;
  var_9.bar = var_8;
  var_9 setparent(level.uiparent);
  return var_9;
}

createbar(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_0))
    var_0 = "white";

  if(!isdefined(var_1))
    var_1 = "black";

  if(!isdefined(var_2))
    var_2 = 100;

  if(!isdefined(var_3))
    var_3 = 9;

  var_5 = newhudelem();
  var_5.x = 2;
  var_5.y = 2;
  var_5.frac = 0.25;
  var_5.shader = var_0;
  var_5.sort = -1;
  var_5 setshader(var_0, var_2 - 2, var_3 - 2);

  if(isdefined(var_4)) {
    var_5.flashfrac = var_4;
    var_5 thread flashthread();
  }

  var_5.offset_x = 0;
  var_5.offset_y = 0;
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
  var_6.xpadding = 2;
  var_6.ypadding = 2;
  var_6.sort = -2;
  var_6.alpha = 0.5;
  var_6 setparent(level.uiparent);
  var_6 setshader(var_1, var_2, var_3);
  return var_6;
}

createclientprogressbar(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 = common_scripts\utility::ter_op(isdefined(var_0), var_0, level.player);
  var_1 = common_scripts\utility::ter_op(isdefined(var_1), var_1, 90);
  var_2 = common_scripts\utility::ter_op(isdefined(var_2), var_2, "white");
  var_3 = common_scripts\utility::ter_op(isdefined(var_3), var_3, "black");
  var_4 = common_scripts\utility::ter_op(isdefined(var_4), var_4, 100);
  var_5 = common_scripts\utility::ter_op(isdefined(var_5), var_5, 9);
  var_6 = common_scripts\utility::ter_op(isdefined(var_6), var_6, 2);
  var_7 = common_scripts\utility::ter_op(isdefined(var_7), var_7, 2);
  var_8 = var_0 createclientbar(var_2, var_3, var_4, var_5, undefined, var_6, var_7);
  var_8 setpoint("CENTER", undefined, 0, var_1);
  return var_8;
}

createclientbar(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(var_5))
    var_5 = 2;

  if(!isdefined(var_6))
    var_6 = 2;

  var_7 = newclienthudelem(self);
  var_7.x = 0 - var_5;
  var_7.y = 0 - var_6;
  var_7.frac = 0.25;
  var_7.shader = var_0;
  var_7.sort = -1;
  var_7 setshader(var_0, var_2 - var_5 * 2, var_3 - var_6 * 2);

  if(isdefined(var_4)) {
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
  var_8.xpadding = var_5;
  var_8.ypadding = var_6;
  var_8.sort = -2;
  var_8.alpha = 0.5;
  var_8 setparent(level.uiparent);
  var_8 setshader(var_1, var_2, var_3);
  return var_8;
}

setflashfrac(var_0) {
  self.bar.flashfrac = var_0;
}

fade_over_time(var_0, var_1) {
  if(isdefined(var_1) && var_1 > 0)
    self fadeovertime(var_1);

  self.alpha = var_0;

  if(isdefined(var_1) && var_1 > 0)
    wait(var_1);
}

flashthread() {
  self endon("death");
  self.alpha = 1;

  for (;;) {
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
  if(isdefined(self.children) && self.children.size) {
    var_0 = [];

    for (var_1 = 0; var_1 < self.children.size; var_1++)
      var_0[var_1] = self.children[var_1];

    for (var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] setparent(getparent());
  }

  if(isdefined(self.elemtype) && self.elemtype == "bar") {
    self.bar destroy();

    if(isdefined(self.progress_bg_distort))
      self.progress_bg_distort destroy();
  }

  self destroy();
}

seticonshader(var_0) {
  self setshader(var_0, self.width, self.height);
}

setwidth(var_0) {
  self.width = var_0;
}

setheight(var_0) {
  self.height = var_0;
}

setsize(var_0, var_1) {
  self.width = var_0;
  self.height = var_1;
}

updatechildren(var_0) {
  for (var_1 = 0; var_1 < self.children.size; var_1++) {
    var_2 = self.children[var_1];
    var_2 setpoint(var_2.point, var_2.relativepoint, var_2.xoffset, var_2.yoffset, var_0);
  }
}

stance_carry_icon_enable(var_0) {
  if(isdefined(var_0) && var_0 == 0) {
    stance_carry_icon_disable();
    return;
  }

  setsaveddvar("hud_showStanceCarry", "1");
}

stance_carry_icon_disable() {
  setsaveddvar("hud_showStanceCarry", "0");
}

create_mantle() {
  if(level.console) {
    var_0 = createfontstring("default", 1.8);
    var_0 setpoint("CENTER", undefined, 0, 115);
    var_0 settext(level.strings["mantle"]);
  } else {
    var_0 = createfontstring("default", 1.6);
    var_0 setpoint("CENTER", undefined, 0, 115);
    var_0 settext(level.strings["mantle"]);
  }

  var_0.alpha = 0;
  level.hud_mantle = [];
  level.hud_mantle["text"] = var_0;
}

add_hint_background(var_0, var_1, var_2) {
  clear_hint_background();

  if(!isdefined(var_1))
    var_1 = 0.0;

  if(!isdefined(var_2))
    var_2 = 0.0;

  if(isdefined(var_0)) {
    var_3 = 121;
    var_4 = 38;
    level.hintbackground = createicon("h1_hud_tutorial_blur", 560, 39);
    level.hintbordertop = createicon("h1_hud_tutorial_border", 560, 1);
    level.hintborderbottom = createicon("h1_hud_tutorial_border", 560, 1);
  } else {
    var_3 = 121;
    var_4 = 24;
    level.hintbackground = createicon("h1_hud_tutorial_blur", 560, 25);
    level.hintbordertop = createicon("h1_hud_tutorial_border", 560, 1);
    level.hintborderbottom = createicon("h1_hud_tutorial_border", 560, 1);
  }

  level.hintbackground setpoint("TOP", undefined, 0, var_3 + var_1);
  level.hintbackground.sort = 1;
  level.hintbackground.hidewheninmenu = 1;
  level.hintbackground.hidewhendead = 1;
  level.hintbordertop setpoint("TOP", undefined, 0, var_3 + var_1);
  level.hintbordertop.sort = 1;
  level.hintbordertop.hidewheninmenu = 1;
  level.hintbordertop.hidewhendead = 1;
  level.hintborderbottom setpoint("TOP", undefined, 0, var_3 + var_1 + var_4);
  level.hintborderbottom.sort = 1;
  level.hintborderbottom.hidewheninmenu = 1;
  level.hintborderbottom.hidewhendead = 1;

  if(var_2 == 0) {
    level.hintbackground.alpha = 0.9;
    level.hintbordertop.alpha = 0.05;
    level.hintborderbottom.alpha = 0.05;
  } else {
    level.hintbackground.alpha = 0;
    level.hintbackground fadeovertime(var_2);
    level.hintbackground.alpha = 0.9;
    level.hintbordertop.alpha = 0;
    level.hintbordertop fadeovertime(var_2);
    level.hintbordertop.alpha = 0.05;
    level.hintborderbottom.alpha = 0;
    level.hintborderbottom fadeovertime(var_2);
    level.hintborderbottom.alpha = 0.05;
  }
}

fade_hint_background(var_0) {
  if(isdefined(level.hintbackground)) {
    if(var_0 > 0)
      level.hintbackground fadeovertime(var_0);

    level.hintbackground.alpha = 0;
  }

  if(isdefined(level.hintbordertop)) {
    if(var_0 > 0)
      level.hintbordertop fadeovertime(var_0);

    level.hintbordertop.alpha = 0;
  }

  if(isdefined(level.hintborderbottom)) {
    if(var_0 > 0)
      level.hintborderbottom fadeovertime(var_0);

    level.hintborderbottom.alpha = 0;
  }
}

clear_hint_background() {
  if(isdefined(level.hintbackground))
    level.hintbackground destroyelem();

  if(isdefined(level.hintbordertop))
    level.hintbordertop destroyelem();

  if(isdefined(level.hintborderbottom))
    level.hintborderbottom destroyelem();
}

get_stats_display_hud(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_6 = common_scripts\utility::ter_op(!isdefined(var_0) || var_3, -225, var_0);
  var_7 = common_scripts\utility::ter_op(!isdefined(var_1), 10.5, var_1);
  var_4 = common_scripts\utility::ter_op(!isdefined(var_4), 1.6, var_4);

  if(isdefined(var_2))
    var_8 = newclienthudelem(var_2);
  else
    var_8 = newhudelem();

  var_8.alignx = "left";
  var_8.aligny = "middle";
  var_8.horzalign = "right";
  var_8.vertalign = "top";
  var_8.x = var_6;
  var_8.y = var_7;

  if(maps\_utility::arcademode()) {
    var_8.alignx = "left";
    var_8.aligny = "top";
    var_8.horzalign = "right";
    var_8.vertalign = "top";
    var_8.y = 0;
  }

  var_8.fontscale = var_4;
  var_8.color = (0.8, 1, 0.8);
  var_8.font = "objective";
  var_8.glowcolor = (0.26, 0.65, 0.32);
  var_8.glowalpha = 0.2;
  var_8.foreground = 1;
  var_8.hidewheninmenu = 1;
  var_8.hidewhendead = 1;

  if(isdefined(var_5))
    var_8 settext(var_5);

  return var_8;
}

add_countdown_flourish_flash_timer(var_0, var_1, var_2, var_3) {
  level endon("kill_timer_flourish");

  for (;;) {
    var_0.color = var_2;
    wait(var_1);
    var_0.color = var_3;
    wait(var_1);
  }
}

add_countdown_flourish(var_0, var_1, var_2, var_3) {
  level endon("kill_timer_flourish");
  var_4 = 57;
  var_5 = (1, 1, 1);
  var_6 = 210;
  var_7 = 0.13;
  var_8 = 0.03;
  var_9 = 0.01;
  var_10 = 5;
  var_11 = 0.1;
  var_12 = (0.9, 0.2, 0.2);
  var_13 = var_7 + var_8;

  if(var_2 > 30)
    var_14 = var_5;
  else
    var_14 = var_12;

  var_15 = newhudelem();
  var_15.x = var_0;
  var_15.y = var_1 - 10;
  var_15 setshader("h1_timer_on_flare", 0, var_4);
  var_15.alignx = "center";
  var_15.color = var_14;
  var_15.aligny = "top";
  var_15.sort = 1;
  var_15.foreground = 0;
  var_15.horzalign = "center_adjustable";
  var_15.vertalign = "top_adjustable";
  var_15.hidewheninmenu = 1;
  var_15.hidewhendead = 1;
  var_15.alpha = 1;
  var_2 = var_2 - 0.05;
  wait 0.05;

  if(var_2 > 30) {
    var_15 scaleovertime(var_13, var_6, var_4);
    var_2 = var_2 - var_7;
    wait(var_7);
    var_15 fadeovertime(var_8);
    var_15.alpha = 0;
    var_2 = var_2 - var_8;
    wait(var_8);
    var_16 = var_2 - 30;
    var_2 = var_2 - var_16;
    wait(var_16);
    var_15 scaleovertime(0.05, 0, var_4);
    var_2 = var_2 - 0.05;
    wait 0.05;
  }

  var_3.color = var_12;
  var_15.color = var_12;
  var_15.alpha = 1;
  var_15 scaleovertime(var_13, var_6, var_4);
  var_2 = var_2 - var_7;
  wait(var_7);
  var_15 fadeovertime(var_8);
  var_15.alpha = 0;
  var_2 = var_2 - var_8;
  wait(var_8);
  var_15 scaleovertime(0.05, 0, var_4);

  if(var_2 > 15) {
    var_17 = var_2 - 15;
    var_2 = var_2 - var_17;
    wait(var_17);
  }

  thread add_countdown_flourish_flash_timer(var_3, var_11, var_5, var_12);
  var_18 = var_3.y;

  for (;;) {
    var_15.alpha = 1;
    var_15 scaleovertime(0.05, var_6, var_4);
    var_3.y = var_18 + var_10;
    wait(var_9);
    var_15 fadeovertime(0.05);
    var_15.alpha = 0;
    var_3.y = var_18;
    wait(1.0 - var_9);
  }

  var_15 destroy();
}

get_countdown_hud(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_5 = common_scripts\utility::ter_op(!isdefined(var_0) || var_3, 0, var_0);
  var_6 = common_scripts\utility::ter_op(!isdefined(var_1), 10.5, var_1);

  if(isdefined(var_2))
    var_7 = newclienthudelem(var_2);
  else
    var_7 = newhudelem();

  var_7.alignx = "center";
  var_7.aligny = "top";
  var_7.horzalign = "center_adjustable";
  var_7.vertalign = "top_adjustable";
  var_7.x = var_5;

  switch (getdvarint("loc_language")) {
    case 15:
    case 12:
    case 11:
    case 10:
    case 9:
    case 8:
      var_7.y = var_6 + 18;
      break;
    default:
      var_7.y = var_6 + 16;
      break;
  }

  var_7.fontscale = 0.75;
  var_7.color = (1, 1, 1);
  var_7.font = "timer";
  var_7.glowcolor = (0, 0, 0);
  var_7.glowalpha = 1;
  var_7.foreground = 1;
  var_7.hidewheninmenu = 1;
  var_7.hidewhendead = 1;
  var_7.text = newhudelem();
  var_7.text.alignx = "center";
  var_7.text.aligny = "top";
  var_7.text.horzalign = "center_adjustable";
  var_7.text.vertalign = "top_adjustable";
  var_7.text.x = var_5;
  var_7.text.y = var_6 + 8;
  var_7.text.fontscale = 0.45;
  var_7.text.color = (1, 1, 1);
  var_7.text.font = "timer";
  var_7.text.glowcolor = (0, 0, 0);
  var_7.text.glowalpha = 1;
  var_7.text.foreground = 1;
  var_7.text.hidewheninmenu = 1;
  var_7.text.hidewhendead = 1;
  var_7.blur = newhudelem();
  var_7.blur.x = var_5;
  var_7.blur.y = var_6;
  var_7.blur setshader("h1_hud_timer_blur", 227, 57);
  var_7.blur.alignx = "center";
  var_7.blur.aligny = "top";
  var_7.blur.sort = 1;
  var_7.blur.foreground = 0;
  var_7.blur.horzalign = "center_adjustable";
  var_7.blur.vertalign = "top_adjustable";
  var_7.blur.alpha = 0.9;
  var_7.blur.hidewheninmenu = 1;
  var_7.blur.hidewhendead = 1;
  var_7.border = newhudelem();
  var_7.border.x = var_5;
  var_7.border.y = var_6;
  var_7.border setshader("h1_hud_timer_border", 227, 57);
  var_7.border.alignx = "center";
  var_7.border.aligny = "top";
  var_7.border.sort = 1;
  var_7.border.foreground = 0;
  var_7.border.horzalign = "center_adjustable";
  var_7.border.vertalign = "top_adjustable";
  var_7.border.alpha = 0.1;
  var_7.border.hidewheninmenu = 1;
  var_7.border.hidewhendead = 1;

  if(isdefined(var_4))
    thread add_countdown_flourish(var_5, var_6, var_4, var_7);

  return var_7;
}

destroy_countdown_hud(var_0) {
  level notify("kill_timer_flourish");

  if(!isdefined(var_0)) {
    return;
  }
  if(isdefined(var_0.text))
    var_0.text destroy();

  if(isdefined(var_0.blur))
    var_0.blur destroy();

  if(isdefined(var_0.border))
    var_0.border destroy();

  var_0 destroy();
}

get_download_state_hud(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 0;

  var_4 = undefined;

  if(!level.console)
    var_4 = -250;
  else if(!isdefined(var_0))
    var_4 = -170;
  else
    var_4 = var_0;

  if(var_3)
    var_4 = var_0;

  if(!isdefined(var_1))
    var_5 = 100;
  else
    var_5 = var_1;

  if(isdefined(var_2))
    var_6 = newclienthudelem(var_2);
  else
    var_6 = newhudelem();

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

create_client_overlay(var_0, var_1, var_2) {
  if(isdefined(var_2))
    var_3 = newclienthudelem(var_2);
  else
    var_3 = newhudelem();

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

create_client_overlay_custom_size(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\_utility::get_player_from_self();
  var_6 = newclienthudelem(var_5);

  if(!isdefined(var_4))
    var_4 = 1;

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

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

create_client_overlay_fullscreen(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\_utility::get_player_from_self();
  var_6 = newclienthudelem(var_5);

  if(!isdefined(var_4))
    var_4 = 1;

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

fade_in(var_0, var_1) {
  if(level.missionfailed) {
    return;
  }
  if(!isdefined(var_0))
    var_0 = 0.3;

  var_2 = get_optional_overlay(var_1);
  var_2 fadeovertime(var_0);
  var_2.alpha = 0;
  wait(var_0);
}

get_optional_overlay(var_0) {
  if(!isdefined(var_0))
    var_0 = "black";

  return get_overlay(var_0);
}

fade_out(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = 0.3;

  var_2 = get_optional_overlay(var_1);

  if(var_0 > 0)
    var_2 fadeovertime(var_0);

  var_2.alpha = 1;
  wait(var_0);
}

start_overlay(var_0) {
  var_1 = get_optional_overlay(var_0);
  var_1.alpha = 1;
}

get_overlay(var_0) {
  if(isplayer(self))
    var_1 = self;
  else
    var_1 = level.player;

  if(!isdefined(var_1.overlay))
    var_1.overlay = [];

  if(!isdefined(var_1.overlay[var_0]))
    var_1.overlay[var_0] = create_client_overlay(var_0, 0, var_1);

  var_1.overlay[var_0].sort = 0;
  var_1.overlay[var_0].foreground = 1;
  return var_1.overlay[var_0];
}

display_custom_nameplate(var_0, var_1, var_2) {
  if(!maps\_utility::ent_flag_exist("kill_custom_nameplate"))
    maps\_utility::ent_flag_init("kill_custom_nameplate");

  var_3 = undefined;

  if(isdefined(var_1))
    var_3 = var_1;
  else if(isdefined(self.name))
    var_3 = self.name;

  var_4 = undefined;

  if(isdefined(var_2))
    var_4 = var_2;
  else if(isdefined(self.team))
    var_4 = self.team;

  var_5 = undefined;

  for (;;) {
    if(!isdefined(self) || maps\_utility::ent_flag("kill_custom_nameplate")) {
      if(isdefined(var_5))
        var_5 destroy();

      break;
    }

    if([
        [var_0]
      ]()) {
      if(!isdefined(var_5))
        var_5 = create_nameplate_hud(var_3, var_4);
    } else if(isdefined(var_5))
      var_5 destroy();

    wait 0.05;
  }
}

create_nameplate_hud(var_0, var_1) {
  var_2 = 25.0;
  var_3 = -2.0;
  var_4 = newhudelem();
  var_4.alignx = "left";
  var_4.aligny = "bottom";
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.x = var_2;
  var_4.y = var_3;
  var_4.fontscale = 1.2;
  var_4.font = "objective";
  var_4.label = var_0;
  var_5 = get_nameplate_color("hostileNameFontColor");
  var_6 = get_nameplate_color("hostileNameFontGlowColor");
  var_7 = get_nameplate_color("friendlyNameFontColor");
  var_8 = get_nameplate_color("friendlyNameFontGlowColor");

  if(var_1 == "axis") {
    var_4.color = (var_5[0], var_5[1], var_5[2]);
    var_4.alpha = var_5[3];
    var_4.glowcolor = (var_6[0], var_6[1], var_6[2]);
    var_4.glowalpha = var_6[3];
  } else {
    var_4.color = (var_7[0], var_7[1], var_7[2]);
    var_4.alpha = var_7[3];
    var_4.glowcolor = (var_8[0], var_8[1], var_8[2]);
    var_4.glowalpha = var_8[3];
  }

  var_4.foreground = 1;
  var_4.hidewheninmenu = 1;
  var_4.hidewhendead = 1;
  return var_4;
}

get_nameplate_color(var_0) {
  var_1 = strtok(getdvar(var_0), " ");
  var_2 = [];
  var_2 = common_scripts\utility::array_add(var_2, float(var_1[0]));
  var_2 = common_scripts\utility::array_add(var_2, float(var_1[1]));
  var_2 = common_scripts\utility::array_add(var_2, float(var_1[2]));
  var_2 = common_scripts\utility::array_add(var_2, float(var_1[3]));
  return var_2;
}