/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\hud_util.gsc
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
  var6 = "center";
  var7 = "middle";

  if(issubstr(var1, "TOP")) {
    var7 = "top";
  }

  if(issubstr(var1, "BOTTOM")) {
    var7 = "bottom";
  }

  if(issubstr(var1, "LEFT")) {
    var6 = "left";
  }

  if(issubstr(var1, "RIGHT")) {
    var6 = "right";
  }

  if(var5 == level.uiparent) {
    self.horzalign = var6;
    self.vertalign = var7;
  } else {
    self.horzalign = var5.horzalign;
    self.vertalign = var5.vertalign;
  }

  if(var6 == var5.alignx) {
    var8 = 0;
    var9 = 0;
  } else if(var8 == "center" || var7.alignx == "center") {
    var8 = int(var7.width / 2);

    if(var8 == "left" || var7.alignx == "right") {
      var9 = -1;
    } else {
      var9 = 1;
    }
  } else {
    var8 = var8.width;

    if(var9 == "left") {
      var9 = -1;
    } else {
      var9 = 1;
    }
  }

  self.x = var9.x + var9 * var9;

  if(var8 == var9.aligny) {
    var10 = 0;
    var11 = 0;
  } else if(var9 == "middle" || var8.aligny == "middle") {
    var10 = int(var8.height / 2);

    if(var9 == "top" || var8.aligny == "bottom") {
      var11 = -1;
    } else {
      var11 = 1;
    }
  } else {
    var10 = var10.height;

    if(var10 == "top") {
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

  updatechildren(var10);
}

function setpointbar(var0, var1, var2, var3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x + self.xpadding;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width - self.xpadding;
  } else {
    self.bar.x = self.x - int((self.width - self.xpadding * 2) / 2);
  }

  updatebar(self.bar.frac);
}

function updatebar(var0) {
  var1 = int((self.width - self.xpadding * 2) * var0);

  if(!var1) {
    var1 = 1;
  }

  self.bar.frac = var0;
  self.bar setshader(self.bar.shader, var1, self.height - self.ypadding * 2);
}

function hidebar(var0) {
  var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, 1);

  if(var0 || !isDefined(self.orig_alpha) || !isDefined(self.bar.orig_alpha)) {
    self.orig_alpha = self.alpha;
    self.bar.orig_alpha = self.bar.alpha;
  }

  self.alpha = scripts\engine\utility::ter_op(var0, 0, self.orig_alpha);
  self.bar.alpha = scripts\engine\utility::ter_op(var0, 0, self.bar.orig_alpha);
}

function createfontstring(var0, var1) {
  var2 = newhudelem();
  var2.elemtype = "font";
  var2.font = var0;
  var2.fontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  return var2;
}

function createclientfontstring(var0, var1) {
  var2 = newclienthudelem(self);
  var2.elemtype = "font";
  var2.font = var0;
  var2.fontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  return var2;
}

function createclienttimer(var0, var1) {
  var2 = newclienthudelem(self);
  var2.elemtype = "timer";
  var2.font = var0;
  var2.fontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  return var2;
}

function createservertimer(var0, var1) {
  var2 = newhudelem();
  var2.elemtype = "timer";
  var2.font = var0;
  var2.fontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  setparent(var2, level.uiparent);
  return var2;
}

function createicon(var0, var1, var2) {
  var3 = newhudelem();
  return createicon_hudelem(var3, var0, var1, var2);
}

function createclienticon(var0, var1, var2) {
  var3 = newclienthudelem(self);
  return createicon_hudelem(var3, var0, var1, var2);
}

function createicon_hudelem(var0, var1, var2, var3) {
  var0.elemtype = "icon";
  var0.x = 0;
  var0.y = 0;
  var0.width = var2;
  var0.height = var3;
  var0.xoffset = 0;
  var0.yoffset = 0;
  var0.children = [];
  setparent(var0, level.uiparent);

  if(isDefined(var1)) {
    var0 setshader(var1, var2, var3);
  }

  return var0;
}

function createbar(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    var0 = "white";
  }

  if(!isDefined(var1)) {
    var1 = "black";
  }

  if(!isDefined(var2)) {
    var2 = 100;
  }

  if(!isDefined(var3)) {
    var3 = 9;
  }

  var5 = newhudelem();
  var5.x = 2;
  var5.y = 2;
  var5.frac = 0.25;
  var5.shader = var0;
  var5.sort = -1;
  var5 setshader(var0, var2 - 2, var3 - 2);

  if(isDefined(var4)) {
    var5.flashfrac = var4;
    thread flashthread();
  }

  var6 = newhudelem();
  var6.elemtype = "bar";
  var6.x = 0;
  var6.y = 0;
  var6.width = var2;
  var6.height = var3;
  var6.xoffset = 0;
  var6.yoffset = 0;
  var6.bar = var5;
  var6.children = [];
  var6.padding = 2;
  var6.sort = -2;
  var6.alpha = 0.5;
  setparent(var6, level.uiparent);
  var6 setshader(var1, var2, var3);
  return var6;
}

function createclientprogressbar(var0, var1, var2, var3, var4, var5, var6, var7) {
  var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, level.player);
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 90);
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, "white");
  var3 = scripts\engine\utility::ter_op(isDefined(var3), var3, "black");
  var4 = scripts\engine\utility::ter_op(isDefined(var4), var4, 100);
  var5 = scripts\engine\utility::ter_op(isDefined(var5), var5, 9);
  var6 = scripts\engine\utility::ter_op(isDefined(var6), var6, 2);
  var7 = scripts\engine\utility::ter_op(isDefined(var7), var7, 2);
  var8 = createclientbar(var0, var2, var3, var4, var5, undefined, var6, var7);
  setpoint(var8, "CENTER", undefined, 0, var1);
  return var8;
}

function createclientbar(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var5)) {
    var5 = 2;
  }

  if(!isDefined(var6)) {
    var6 = 2;
  }

  var7 = newclienthudelem(self);
  var7.x = 0 - var5;
  var7.y = 0 - var6;
  var7.frac = 0.25;
  var7.shader = var0;
  var7.sort = -1;
  var7 setshader(var0, var2 - var5 * 2, var3 - var6 * 2);

  if(isDefined(var4)) {
    var7.flashfrac = var4;
    thread flashthread();
  }

  var8 = newclienthudelem(self);
  var8.elemtype = "bar";
  var8.x = 0;
  var8.y = 0;
  var8.width = var2;
  var8.height = var3;
  var8.xoffset = -1 * var5;
  var8.yoffset = 0;
  var8.bar = var7;
  var8.children = [];
  var8.xpadding = var5;
  var8.ypadding = var6;
  var8.sort = -2;
  var8.alpha = 0.5;
  setparent(var8, level.uiparent);
  var8 setshader(var1, var2, var3);
  return var8;
}

function setflashfrac(var0) {
  self.bar.flashfrac = var0;
}

function fade_over_time(var0, var1) {
  if(isDefined(var1) && var1 > 0) {
    self fadeovertime(var1);
  }

  self.alpha = var0;

  if(isDefined(var1) && var1 > 0) {
    wait var1;
    return;
  }
}

function flashthread() {
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

function destroyelem() {
  if(isDefined(self.children) && self.children.size) {
    var0 = [];

    for(var1 = 0; var1 < self.children.size; var1++) {
      var0 = self.children[var1];
    }

    for(var1 = 0; var1 < var0.size; var1++) {
      setparent(var0[var1], getparent());
    }
  }

  if(isDefined(self.elemtype) && self.elemtype == "bar") {
    self.bar destroy();
  }

  self destroy();
}

function seticonshader(var0) {
  self setshader(var0, self.width, self.height);
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

function updatechildren(var0) {
  for(var1 = 0; var1 < self.children.size; var1++) {
    var2 = self.children[var1];
    setpoint(var2, var2.point, var2.relativepoint, var2.xoffset, var2.yoffset, var0);
  }
}

function stance_carry_icon_enable(var0) {
  if(isDefined(var0) && var0 == 0) {
    stance_carry_icon_disable();
    return;
  }

  if(isDefined(level.stance_carry)) {
    level.stance_carry destroy();
  }

  setsaveddvar("MPNNTKMQTS", "0");
  level.stance_carry = newhudelem();
  level.stance_carry.x = -75;

  if(isplatformpc()) {
    level.stance_carry.y = -20;
  } else {
    level.stance_carry.y = -10;
  }

  level.stance_carry setshader("stance_carry", 64, 64);
  level.stance_carry.alignx = "right";
  level.stance_carry.aligny = "bottom";
  level.stance_carry.horzalign = "right";
  level.stance_carry.vertalign = "bottom";
  level.stance_carry.foreground = 1;
  level.stance_carry.alpha = 0;
  level.stance_carry fadeovertime(0.5);
  level.stance_carry.alpha = 1;
}

function stance_carry_icon_disable() {
  if(isDefined(level.stance_carry)) {
    level.stance_carry fadeovertime(0.5);
    level.stance_carry.alpha = 0;
    level.stance_carry destroy();
  }

  setsaveddvar("MPNNTKMQTS", "1");
}

function create_mantle() {
  if(isplatformpc()) {
    var0 = createfontstring("default", 1.8);
    setpoint(var0, "CENTER", undefined, -23, 115);
    var0 settext(level.strings["mantle"]);
    var1 = createicon("hint_mantle", 40, 40);
    setpoint(var1, "CENTER", undefined, 73, 0);
    setparent(var1, var0);
  } else {
    var0 = createfontstring("default", 1.6);
    setpoint(var0, "CENTER", undefined, 0, 115);
    var0 settext(level.strings["mantle"]);
    var1 = createicon("hint_mantle", 40, 40);
    setpoint(var1, "CENTER", undefined, 0, 30);
    setparent(var1, var0);
  }

  var1.alpha = 0;
  var0.alpha = 0;
  level.hud_mantle = [];
  level.hud_mantle["text"] = var0;
  level.hud_mantle["icon"] = var1;
}

function get_countdown_hud(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = undefined;

  if(!isplatformpc()) {
    var4 = -250;
  } else if(!isDefined(var0)) {
    var4 = -225;
  } else {
    var4 = var0;
  }

  if(var3) {
    var4 = var0;
  }

  if(!isDefined(var1)) {
    var5 = 100;
  } else {
    var5 = var2;
  }

  if(isDefined(var3)) {
    var6 = newclienthudelem(var3);
  } else {
    var6 = newhudelem();
  }

  var6.alignx = "left";
  var6.aligny = "middle";
  var6.horzalign = "right";
  var6.vertalign = "top";
  var6.x = var5;
  var6.y = var6;
  var6.fontscale = 1.6;
  var6.color = (0.8, 1, 0.8);
  var6.font = "objective";
  var6.glowcolor = (0.3, 0.6, 0.3);
  var6.glowalpha = 1;
  var6.foreground = 1;
  var6.hidewheninmenu = 1;
  var6.hidewhendead = 1;
  return var6;
}

function get_download_state_hud(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = undefined;

  if(!isplatformpc()) {
    var4 = -250;
  } else if(!isDefined(var0)) {
    var4 = -170;
  } else {
    var4 = var0;
  }

  if(var3) {
    var4 = var0;
  }

  if(!isDefined(var1)) {
    var5 = 100;
  } else {
    var5 = var2;
  }

  if(isDefined(var3)) {
    var6 = newclienthudelem(var3);
  } else {
    var6 = newhudelem();
  }

  var6.alignx = "right";
  var6.aligny = "middle";
  var6.horzalign = "right";
  var6.vertalign = "top";
  var6.x = var5;
  var6.y = var6;
  var6.fontscale = 1.6;
  var6.color = (0.8, 1, 0.8);
  var6.font = "objective";
  var6.glowcolor = (0.3, 0.6, 0.3);
  var6.glowalpha = 1;
  var6.foreground = 1;
  var6.hidewheninmenu = 1;
  var6.hidewhendead = 1;
  return var6;
}

function create_client_overlay(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = newclienthudelem(var2);
  } else {
    var3 = newhudelem();
  }

  var3.x = 0;
  var3.y = 0;
  var3 setshader(var1, 640, 480);
  var3.alignx = "left";
  var3.aligny = "top";
  var3.sort = 1;
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var3.alpha = var2;
  var3.foreground = 1;
  return var3;
}

function create_client_overlay_custom_size(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\sp\utility::get_player_from_self();
  var6 = newclienthudelem(var5);

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var6.x = var2;
  var6.y = var3;
  var6 setshader(var0, int(640 * var4), int(480 * var4));
  var6.alignx = "center";
  var6.aligny = "middle";
  var6.sort = 1;
  var6.horzalign = "center";
  var6.vertalign = "middle";
  var6.alpha = var1;
  var6.foreground = 1;
  return var6;
}

function create_client_overlay_fullscreen(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\sp\utility::get_player_from_self();
  var6 = newclienthudelem(var5);

  if(!isDefined(var4)) {
    var4 = 1;
  }

  var6.x = var2;
  var6.y = var3;
  var6 setshader(var0, int(640 * var4), int(480 * var4));
  var6.alignx = "center";
  var6.aligny = "middle";
  var6.sort = 1;
  var6.horzalign = "fullscreen";
  var6.vertalign = "fullscreen";
  var6.alpha = var1;
  var6.foreground = 1;
  return var6;
}

function fade_in(var0, var1) {
  if(level.missionfailed) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = 0.3;
  }

  var2 = get_optional_overlay(var1);

  if(var0 > 0) {
    var2 fadeovertime(var0);
  }

  var2.alpha = 0;

  if(var0 > 0) {
    wait var0;
    return;
  }
}

function get_optional_overlay(var0) {
  if(!isDefined(var0)) {
    var0 = "black";
  }

  return get_overlay(var0);
}

function fade_out(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0.3;
  }

  var2 = get_optional_overlay(var1);

  if(var0 > 0) {
    var2 fadeovertime(var0);
  }

  var2.alpha = 1;

  if(var0 > 0) {
    wait var0;
    return;
  }
}

function start_overlay(var0) {
  var1 = get_optional_overlay(var0);
  var1.alpha = 1;
}

function get_overlay(var0) {
  if(isPlayer(self)) {
    var1 = self;
  } else {
    var1 = level.player;
  }

  if(!isDefined(var1.overlay)) {
    var1.overlay = [];
  }

  if(!isDefined(var1.overlay[var1])) {
    var1.overlay[var1] = create_client_overlay(var1, 0, var1);
  }

  var1.overlay[var1].sort = 0;
  var1.overlay[var1].foreground = 1;
  return var1.overlay[var1];
}

function screen_detailed_alpha() {
  var0 = 0.2;
  self.alpha = 0.7;
  self fadeovertime(var0);
  self.alpha = 0;
  wait var0;
  self destroy();
}