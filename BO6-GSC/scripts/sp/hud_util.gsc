/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\hud_util.gsc
**************************************/

#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace hud_util;

function setparent(element) {
  if(isDefined(self.parent) && self.parent == element) {
    return;
  }

  if(isDefined(self.parent)) {
    self.parent removechild(self);
  }

  self.parent = element;
  self.parent addchild(self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  setpoint("\xac\x8c\xde\f\xec\xdcy");
}

function getparent() {
  return self.parent;
}

function removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }

  self.childchecktime = gettime();
  newchildren = [];

  foreach(child in self.children) {
    if(!isDefined(child)) {
      continue;
    }

    child.index = newchildren.size;
    newchildren[newchildren.size] = child;
  }

  self.children = newchildren;
}

function addchild(element) {
  element.index = self.children.size;
  self.children[self.children.size] = element;
  removedestroyedchildren();
}

function removechild(element) {
  element.parent = undefined;

  if(self.children[self.children.size - 1] != element) {
    self.children[element.index] = self.children[self.children.size - 1];
    self.children[element.index].index = element.index;
  }

  self.children[self.children.size - 1] = undefined;
  element.index = undefined;
}

function setpoint(point, relativepoint, xoffset, yoffset, movetime) {
  if(!isDefined(movetime)) {
    movetime = 0;
  }

  element = getparent();

  if(movetime) {
    self moveovertime(movetime);
  }

  if(!isDefined(xoffset)) {
    xoffset = 0;
  }

  self.xoffset = xoffset;

  if(!isDefined(yoffset)) {
    yoffset = 0;
  }

  self.yoffset = yoffset;
  self.point = point;
  self.alignx = "O\xd5!\xe8\xd4\x9d";
  self.aligny = "#\xb8\xfd\xf5\x1a@";

  if(issubstr(point, "\x1c!P")) {
    self.aligny = "\x1d Q";
  }

  if(issubstr(point, "Tc\x05\xc9\r\x91")) {
    self.aligny = "\x14#\x01\x89\f\x81";
  }

  if(issubstr(point, "\x1d\xf7\xb0`")) {
    self.alignx = "=\xff0b";
  }

  if(issubstr(point, "g4\xef\xc9\xac")) {
    self.alignx = "o0\xee\xc1\x8c";
  }

  if(!isDefined(relativepoint)) {
    relativepoint = point;
  }

  self.relativepoint = relativepoint;
  relativex = "O\xd5!\xe8\xd4\x9d";
  relativey = "#\xb8\xfd\xf5\x1a@";

  if(issubstr(relativepoint, "\x1c!P")) {
    relativey = "\x1d Q";
  }

  if(issubstr(relativepoint, "Tc\x05\xc9\r\x91")) {
    relativey = "\x14#\x01\x89\f\x81";
  }

  if(issubstr(relativepoint, "\x1d\xf7\xb0`")) {
    relativex = "=\xff0b";
  }

  if(issubstr(relativepoint, "g4\xef\xc9\xac")) {
    relativex = "o0\xee\xc1\x8c";
  }

  if(element == level.uiparent) {
    self.horzalign = relativex;
    self.vertalign = relativey;
  } else {
    self.horzalign = element.horzalign;
    self.vertalign = element.vertalign;
  }

  if(relativex == element.alignx) {
    offsetx = 0;
    xfactor = 0;
  } else if(relativex == "O\xd5!\xe8\xd4\x9d" || element.alignx == "O\xd5!\xe8\xd4\x9d") {
    offsetx = int(element.width / 2);

    if(relativex == "=\xff0b" || element.alignx == "o0\xee\xc1\x8c") {
      xfactor = -1;
    } else {
      xfactor = 1;
    }
  } else {
    offsetx = element.width;

    if(relativex == "=\xff0b") {
      xfactor = -1;
    } else {
      xfactor = 1;
    }
  }

  self.x = element.x + offsetx * xfactor;

  if(relativey == element.aligny) {
    offsety = 0;
    yfactor = 0;
  } else if(relativey == "#\xb8\xfd\xf5\x1a@" || element.aligny == "#\xb8\xfd\xf5\x1a@") {
    offsety = int(element.height / 2);

    if(relativey == "\x1d Q" || element.aligny == "\x14#\x01\x89\f\x81") {
      yfactor = -1;
    } else {
      yfactor = 1;
    }
  } else {
    offsety = element.height;

    if(relativey == "\x1d Q") {
      yfactor = -1;
    } else {
      yfactor = 1;
    }
  }

  self.y = element.y + offsety * yfactor;
  self.x += self.xoffset;
  self.y += self.yoffset;

  switch (self.elemtype) {
    case #"hash_2125856c1b2381fa":
      setpointbar(point, relativepoint, xoffset, yoffset);
      break;
  }

  updatechildren(movetime);
}

function setpointbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "=\xff0b";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "=\xff0b") {
    self.bar.x = self.x + self.xpadding;
  } else if(self.alignx == "o0\xee\xc1\x8c") {
    self.bar.x = self.x - self.width - self.xpadding;
  } else {
    self.bar.x = self.x - int((self.width - self.xpadding * 2) / 2);
  }

  updatebar(self.bar.frac);
}

function updatebar(barfrac) {
  barwidth = int((self.width - self.xpadding * 2) * barfrac);

  if(!barwidth) {
    barwidth = 1;
  }

  self.bar.frac = barfrac;
  self.bar setshader(self.bar.shader, barwidth, self.height - self.ypadding * 2);
}

function hidebar(bool = 1) {
  if(bool || !(isDefined(self.orig_alpha) && isDefined(self.bar.orig_alpha))) {
    self.orig_alpha = self.alpha;
    self.bar.orig_alpha = self.bar.alpha;
  }

  self.alpha = bool ? 0 : self.orig_alpha;
  self.bar.alpha = bool ? 0 : self.bar.orig_alpha;
}

function createfontstring(font, fontscale) {
  fontelem = newhudelem();
  fontelem.elemtype = "\xe5\xf7\xe5\"";
  fontelem.font = font;
  fontelem.fontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem setparent(level.uiparent);
  return fontelem;
}

function createclientfontstring(font, fontscale) {
  assert(isPlayer(self));
  fontelem = newclienthudelem(self);
  fontelem.elemtype = "\xe5\xf7\xe5\"";
  fontelem.font = font;
  fontelem.fontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem setparent(level.uiparent);
  return fontelem;
}

function createclienttimer(font, fontscale) {
  assert(isPlayer(self));
  timerelem = newclienthudelem(self);
  timerelem.elemtype = "\xe2)Tf\xee";
  timerelem.font = font;
  timerelem.fontscale = fontscale;
  timerelem.x = 0;
  timerelem.y = 0;
  timerelem.width = 0;
  timerelem.height = int(level.fontheight * fontscale);
  timerelem.xoffset = 0;
  timerelem.yoffset = 0;
  timerelem.children = [];
  timerelem setparent(level.uiparent);
  return timerelem;
}

function createservertimer(font, fontscale) {
  timerelem = newhudelem();
  timerelem.elemtype = "\xe2)Tf\xee";
  timerelem.font = font;
  timerelem.fontscale = fontscale;
  timerelem.x = 0;
  timerelem.y = 0;
  timerelem.width = 0;
  timerelem.height = int(level.fontheight * fontscale);
  timerelem.xoffset = 0;
  timerelem.yoffset = 0;
  timerelem.children = [];
  timerelem setparent(level.uiparent);
  return timerelem;
}

function createicon(shader, width, height) {
  iconelem = newhudelem();
  return createicon_hudelem(iconelem, shader, width, height);
}

function createclienticon(shader, width, height) {
  iconelem = newclienthudelem(self);
  return createicon_hudelem(iconelem, shader, width, height);
}

function createicon_hudelem(iconelem, shader, width, height) {
  iconelem.elemtype = "Z\xb1\xf6\xe6";
  iconelem.x = 0;
  iconelem.y = 0;
  iconelem.width = width;
  iconelem.height = height;
  iconelem.xoffset = 0;
  iconelem.yoffset = 0;
  iconelem.children = [];
  iconelem setparent(level.uiparent);

  if(isDefined(shader)) {
    iconelem setshader(shader, width, height);
  }

  return iconelem;
}

function createbar(shader, bgshader, width, height, flashfrac) {
  if(!isDefined(shader)) {
    shader = "e\xac\x11}\xfd";
  }

  if(!isDefined(bgshader)) {
    bgshader = "\x8a-\v\xa1\xbd";
  }

  if(!isDefined(width)) {
    width = 100;
  }

  if(!isDefined(height)) {
    height = 9;
  }

  barelem = newhudelem();
  barelem.x = 2;
  barelem.y = 2;
  barelem.frac = 0.25;
  barelem.shader = shader;
  barelem.sort = -1;
  barelem setshader(shader, width - 2, height - 2);

  if(isDefined(flashfrac)) {
    barelem.flashfrac = flashfrac;
    barelem thread flashthread();
  }

  barelembg = newhudelem();
  barelembg.elemtype = "\xbb\x86y";
  barelembg.x = 0;
  barelembg.y = 0;
  barelembg.width = width;
  barelembg.height = height;
  barelembg.xoffset = 0;
  barelembg.yoffset = 0;
  barelembg.bar = barelem;
  barelembg.children = [];
  barelembg.padding = 2;
  barelembg.sort = -2;
  barelembg.alpha = 0.5;
  barelembg setparent(level.uiparent);
  barelembg setshader(bgshader, width, height);
  return barelembg;
}

function createclientprogressbar(player = level.player, y_offset = 90, shader = "e\xac\x11}\xfd", bgshader = "\x8a-\v\xa1\xbd", width = 100, height = 9, xpadding = 2, ypadding = 2) {
  bar = player createclientbar(shader, bgshader, width, height, undefined, xpadding, ypadding);
  bar setpoint("\xcf\xf5\xa1\xf8\xd6\x99", undefined, 0, y_offset);
  return bar;
}

function createclientbar(shader, bgshader, width, height, flashfrac, xpadding, ypadding) {
  if(!isDefined(xpadding)) {
    xpadding = 2;
  }

  if(!isDefined(ypadding)) {
    ypadding = 2;
  }

  barelem = newclienthudelem(self);
  barelem.x = 0 - xpadding;
  barelem.y = 0 - ypadding;
  barelem.frac = 0.25;
  barelem.shader = shader;
  barelem.sort = -1;
  barelem setshader(shader, width - xpadding * 2, height - ypadding * 2);

  if(isDefined(flashfrac)) {
    barelem.flashfrac = flashfrac;
    barelem thread flashthread();
  }

  barelembg = newclienthudelem(self);
  barelembg.elemtype = "\xbb\x86y";
  barelembg.x = 0;
  barelembg.y = 0;
  barelembg.width = width;
  barelembg.height = height;
  barelembg.xoffset = -1 * xpadding;
  barelembg.yoffset = 0;
  barelembg.bar = barelem;
  barelembg.children = [];
  barelembg.xpadding = xpadding;
  barelembg.ypadding = ypadding;
  barelembg.sort = -2;
  barelembg.alpha = 0.5;
  barelembg setparent(level.uiparent);
  barelembg setshader(bgshader, width, height);
  return barelembg;
}

function setflashfrac(flashfrac) {
  self.bar.flashfrac = flashfrac;
}

function fade_over_time(target_alpha, fade_time) {
  assert(isDefined(target_alpha), "<dev string:x24>");

  if(isDefined(fade_time) && fade_time > 0) {
    self fadeovertime(fade_time);
  }

  self.alpha = target_alpha;

  if(isDefined(fade_time) && fade_time > 0) {
    wait fade_time;
  }
}

function flashthread() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.alpha = 1;

  while(true) {
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
    tempchildren = [];

    for(index = 0; index < self.children.size; index++) {
      tempchildren[index] = self.children[index];
    }

    for(index = 0; index < tempchildren.size; index++) {
      tempchildren[index] setparent(getparent());
    }
  }

  if(isDefined(self.elemtype) && self.elemtype == "\xbb\x86y") {
    self.bar destroy();
  }

  self destroy();
}

function seticonshader(shader) {
  self setshader(shader, self.width, self.height);
}

function setwidth(width) {
  self.width = width;
}

function setheight(height) {
  self.height = height;
}

function setsize(width, height) {
  self.width = width;
  self.height = height;
}

function updatechildren(movetime) {
  for(index = 0; index < self.children.size; index++) {
    child = self.children[index];
    child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset, movetime);
  }
}

function stance_carry_icon_enable(bool) {
  if(isDefined(bool) && bool == 0) {
    stance_carry_icon_disable();
    return;
  }

  if(isDefined(level.stance_carry)) {
    level.stance_carry destroy();
  }

  setsaveddvar(@ "hash_4e8225c28298a6ad", "\xfe");
  level.stance_carry = newhudelem();
  level.stance_carry.x = -75;

  if(isplatformconsole()) {
    level.stance_carry.y = -20;
  } else {
    level.stance_carry.y = -10;
  }

  level.stance_carry setshader("\xfe\xa5\x9f7MzYJ\x1b\xba\xc7m", 64, 64);
  level.stance_carry.alignx = "o0\xee\xc1\x8c";
  level.stance_carry.aligny = "\x14#\x01\x89\f\x81";
  level.stance_carry.horzalign = "o0\xee\xc1\x8c";
  level.stance_carry.vertalign = "\x14#\x01\x89\f\x81";
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

  setsaveddvar(@ "hash_4e8225c28298a6ad", "\x87");
}

function create_mantle_hint() {
  hud = createfontstring("\x91\xca\xcc\v\xab\xd8:", 1);
  hud setpoint("\xcf\xf5\xa1\xf8\xd6\x99", undefined, 0, 80);
  hud settext(&"platform/mantle");
  return hud;
}

function get_countdown_hud(x, y, player, forcexpos) {
  if(!isDefined(forcexpos)) {
    forcexpos = 0;
  }

  xpos = undefined;

  if(!isplatformconsole()) {
    xpos = -250;
  } else if(!isDefined(x)) {
    xpos = -225;
  } else {
    xpos = x;
  }

  if(forcexpos) {
    xpos = x;
  }

  if(!isDefined(y)) {
    ypos = 100;
  } else {
    ypos = y;
  }

  if(isDefined(player)) {
    hudelem = newclienthudelem(player);
  } else {
    hudelem = newhudelem();
  }

  hudelem.alignx = "=\xff0b";
  hudelem.aligny = "#\xb8\xfd\xf5\x1a@";
  hudelem.horzalign = "o0\xee\xc1\x8c";
  hudelem.vertalign = "\x1d Q";
  hudelem.x = xpos;
  hudelem.y = ypos;
  hudelem.fontscale = 1.6;
  hudelem.color = (0.8, 1, 0.8);
  hudelem.font = "8\xc5\xe5\x91E\x1b\xf9\xb2e";
  hudelem.glowcolor = (0.3, 0.6, 0.3);
  hudelem.glowalpha = 1;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = 1;
  hudelem.hidewhendead = 1;
  return hudelem;
}

function get_download_state_hud(x, y, player, forcexpos) {
  if(!isDefined(forcexpos)) {
    forcexpos = 0;
  }

  xpos = undefined;

  if(!isplatformconsole()) {
    xpos = -250;
  } else if(!isDefined(x)) {
    xpos = -170;
  } else {
    xpos = x;
  }

  if(forcexpos) {
    xpos = x;
  }

  if(!isDefined(y)) {
    ypos = 100;
  } else {
    ypos = y;
  }

  if(isDefined(player)) {
    hudelem = newclienthudelem(player);
  } else {
    hudelem = newhudelem();
  }

  hudelem.alignx = "o0\xee\xc1\x8c";
  hudelem.aligny = "#\xb8\xfd\xf5\x1a@";
  hudelem.horzalign = "o0\xee\xc1\x8c";
  hudelem.vertalign = "\x1d Q";
  hudelem.x = xpos;
  hudelem.y = ypos;
  hudelem.fontscale = 1.6;
  hudelem.color = (0.8, 1, 0.8);
  hudelem.font = "8\xc5\xe5\x91E\x1b\xf9\xb2e";
  hudelem.glowcolor = (0.3, 0.6, 0.3);
  hudelem.glowalpha = 1;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = 1;
  hudelem.hidewhendead = 1;
  return hudelem;
}

function create_client_overlay(shader_name, start_alpha, player) {
  if(isDefined(player)) {
    overlay = newclienthudelem(player);
  } else {
    overlay = newhudelem();
  }

  overlay.x = 0;
  overlay.y = 0;
  overlay setshader(shader_name, 640, 480);
  overlay.alignx = "=\xff0b";
  overlay.aligny = "\x1d Q";
  overlay.sort = 1;
  overlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.alpha = start_alpha;
  overlay.foreground = 1;
  return overlay;
}

function function_b63a1498180aeb16(fade_state, var_e239b42fe0e6d811, callback_function, under_hud) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  assert(hud_management::function_73ac92d48ae2a07f("<dev string:x55>"), "<dev string:x79>");

  if(!isDefined(fade_state)) {
    if(!isDefined(fade_state)) {
      fade_state = "\xf7\xd1\xa2q\fX\xa1g\x91\xe5v\xaetl";
    }
  }

  assert(isDefined(hud_management::function_8bf9383f77c82a9b("<dev string:x55>", fade_state)), "<dev string:x12c>");

  if(!isDefined(var_e239b42fe0e6d811)) {
    var_e239b42fe0e6d811 = 1;
  }

  ui::lui_registercallback("\xa1\xea\x19_\x99,2\xca_o\xec+rc\xb0\xe5\xfa\xc6\xf6\xda\x836\xacG\xac", &hud_fade_overlay_complete);

  if(!hud_management::function_48c98ea9a4f0da89("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8")) {
    options = spawnStruct();
    options.under_hud = under_hud;
    hud_management::function_35924dfcb78711f4("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8", "@b\x8e{\x0e\x12\xd3\xe0\xd9\xb9\xdd\xf0\x8a\x83\xf9C)B\xf3\x9c\xfb,\xb6\xa96\x1cs&\x01Y\x99'", options);
    hud_management::function_85d8a0ba2e35b6f2("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8", 0, 0, 3, 3, 0);
  }

  hud_management::function_d8d634ceece460("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8", fade_state);
  self.var_92bb5f5d8a26cd2e = callback_function;
  self.var_80b8b31c55eb1fa1 = var_e239b42fe0e6d811;
  val::set("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
}

function function_a619bab4dd20b378() {
  if(hud_management::function_48c98ea9a4f0da89("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8")) {
    hud_management::scripted_widget_destroy("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8");
  }
}

function hud_fade_overlay_complete(val) {
  if(isDefined(self.var_80b8b31c55eb1fa1) && self.var_80b8b31c55eb1fa1) {
    function_a619bab4dd20b378();
  }

  if(isDefined(self.var_92bb5f5d8a26cd2e)) {
    thread[[self.var_92bb5f5d8a26cd2e]]();
  }

  self.var_92bb5f5d8a26cd2e = undefined;
  self.var_80b8b31c55eb1fa1 = undefined;
  val::reset_all("\xca\xb1\x06\xa5\xc8\xf2G\xccK\xdfaB0\x8e?\xc8");
}

function create_client_overlay_custom_size(shader_name, start_alpha, x, y, scale) {
  player = utility_sp::get_player_from_self();
  overlay = newclienthudelem(player);

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(x)) {
    x = 0;
  }

  if(!isDefined(y)) {
    y = 0;
  }

  overlay.x = x;
  overlay.y = y;
  overlay setshader(shader_name, int(640 * scale), int(480 * scale));
  overlay.alignx = "O\xd5!\xe8\xd4\x9d";
  overlay.aligny = "#\xb8\xfd\xf5\x1a@";
  overlay.sort = 1;
  overlay.horzalign = "O\xd5!\xe8\xd4\x9d";
  overlay.vertalign = "#\xb8\xfd\xf5\x1a@";
  overlay.alpha = start_alpha;
  overlay.foreground = 1;
  return overlay;
}

function create_client_overlay_fullscreen(shader, start_alpha, x, y, scale) {
  player = utility_sp::get_player_from_self();
  overlay = newclienthudelem(player);

  if(!isDefined(scale)) {
    scale = 1;
  }

  overlay.x = x;
  overlay.y = y;
  overlay setshader(shader, int(640 * scale), int(480 * scale));
  overlay.alignx = "O\xd5!\xe8\xd4\x9d";
  overlay.aligny = "#\xb8\xfd\xf5\x1a@";
  overlay.sort = 1;
  overlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  overlay.alpha = start_alpha;
  overlay.foreground = 1;
  return overlay;
}

function fade_in(time, shader, under_hud) {
  if(level.missionfailed) {
    return;
  }

  if(getprojectname() == "_\xde_" && (!isDefined(shader) || shader == "\x8a-\v\xa1\xbd")) {
    fadestate = function_7dfa705d1465986e(time, 1);
    level.player function_b63a1498180aeb16(fadestate, 1, undefined, under_hud);
    return;
  }

  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 0;

  if(time > 0) {
    wait time;
  }
}

function get_optional_overlay(shader) {
  if(!isDefined(shader)) {
    shader = "\x8a-\v\xa1\xbd";
  }

  return get_overlay(shader);
}

function fade_out(time, shader, under_hud) {
  if(getprojectname() == "_\xde_" && (!isDefined(shader) || shader == "\x8a-\v\xa1\xbd")) {
    fadestate = function_7dfa705d1465986e(time, 0);
    level.player function_b63a1498180aeb16(fadestate, 0, undefined, under_hud);
    return;
  }

  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 1;

  if(time > 0) {
    wait time;
  }
}

function start_overlay(shader) {
  overlay = get_optional_overlay(shader);
  overlay.alpha = 1;
}

function get_overlay(shader) {
  if(isPlayer(self)) {
    guy = self;
  } else {
    guy = level.player;
  }

  if(!isDefined(guy.overlay)) {
    guy.overlay = [];
  }

  if(!isDefined(guy.overlay[shader])) {
    guy.overlay[shader] = create_client_overlay(shader, 0, guy);
  }

  guy.overlay[shader].sort = 0;
  guy.overlay[shader].foreground = 1;
  return guy.overlay[shader];
}

function screen_detailed_alpha() {
  fade_in_time = 0.2;
  self.alpha = 0.7;
  self fadeovertime(fade_in_time);
  self.alpha = 0;
  wait fade_in_time;
  self destroy();
}

function function_7dfa705d1465986e(time, var_7d642e8c6053a61f) {
  if(var_7d642e8c6053a61f) {
    if(time <= 0) {
      return "\xb6\xb5\x9d;\xe1pp\xfd\xb9\xa0@\xbf";
    } else if(time <= 0.7) {
      return "R'\x81\xd0q\x9f\x859\xb1%?`\xb4";
    } else if(time <= 1.3) {
      return "\xf7\xd1\xa2q\fX\xa1g\x91\xe5v\xaetl";
    } else {
      return "\\6*\xa3\x8e\t\xe3\xa9(\xffV\xc1";
    }

    return;
  }

  if(time <= 0) {
    return "\xdcC\x8e\\\x86\x1a\xf6Fk\xb0\n\x19\xf9";
  }

  if(time <= 0.7) {
    return "\xd7e\xc8\xff_ait[\xfd\x9b\xef\xeav";
  }

  if(time <= 1.3) {
    return "/\aq\xea\x9f(`\x03\xa7\x90\xed\x8a\xd2\xd3)";
  }

  return "\xfe\\\x03x\xf3b\x1am\x8c\xdc\xcb\xa1n";
}