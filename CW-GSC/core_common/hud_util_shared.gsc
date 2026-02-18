/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\hud_util_shared.gsc
***********************************************/

#namespace hud;

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
    self setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
    return;
  }

  self setpoint("<dev string:x38>");
}

function getparent() {
  return self.parent;
}

function addchild(element) {
  element.index = self.children.size;
  self.children[self.children.size] = element;
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

  element = self getparent();

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
  self.alignx = "<dev string:x3f>";
  self.aligny = "<dev string:x49>";

  switch (point) {
    case # "center":
      break;
    case # "top":
      self.aligny = "<dev string:x53>";
      break;
    case # "bottom":
      self.aligny = "<dev string:x5a>";
      break;
    case # "left":
      self.alignx = "<dev string:x64>";
      break;
    case # "right":
      self.alignx = "<dev string:x6c>";
      break;
    case # "topright":
    case # "top_right":
      self.aligny = "<dev string:x53>";
      self.alignx = "<dev string:x6c>";
      break;
    case # "topleft":
    case # "top_left":
      self.aligny = "<dev string:x53>";
      self.alignx = "<dev string:x64>";
      break;
    case # "topcenter":
      self.aligny = "<dev string:x53>";
      self.alignx = "<dev string:x3f>";
      break;
    case # "bottom_right":
    case # "bottom right":
      self.aligny = "<dev string:x5a>";
      self.alignx = "<dev string:x6c>";
      break;
    case # "bottom left":
    case # "bottom_left":
      self.aligny = "<dev string:x5a>";
      self.alignx = "<dev string:x64>";
      break;
    default:
      println("<dev string:x75>" + point);
      break;
  }

  if(!isDefined(relativepoint)) {
    relativepoint = point;
  }

  self.relativepoint = relativepoint;
  relativex = "<dev string:x3f>";
  relativey = "<dev string:x49>";

  switch (relativepoint) {
    case # "center":
      break;
    case # "top":
      relativey = "<dev string:x53>";
      break;
    case # "bottom":
      relativey = "<dev string:x5a>";
      break;
    case # "left":
      relativex = "<dev string:x64>";
      break;
    case # "right":
      relativex = "<dev string:x6c>";
      break;
    case # "topright":
    case # "top_right":
      relativey = "<dev string:x53>";
      relativex = "<dev string:x6c>";
      break;
    case # "topleft":
    case # "top_left":
      relativey = "<dev string:x53>";
      relativex = "<dev string:x64>";
      break;
    case # "topcenter":
      relativey = "<dev string:x53>";
      relativex = "<dev string:x3f>";
      break;
    case # "bottom_right":
    case # "bottom right":
      relativey = "<dev string:x5a>";
      relativex = "<dev string:x6c>";
      break;
    case # "bottom left":
    case # "bottom_left":
      relativey = "<dev string:x5a>";
      relativex = "<dev string:x64>";
      break;
    default:
      println("<dev string:xa8>" + relativepoint);
      break;
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
  } else if(relativex == "<dev string:x3f>" || element.alignx == "<dev string:x3f>") {
    offsetx = int(element.width / 2);

    if(relativex == "<dev string:x64>" || element.alignx == "<dev string:x6c>") {
      xfactor = -1;
    } else {
      xfactor = 1;
    }
  } else {
    offsetx = element.width;

    if(relativex == "<dev string:x64>") {
      xfactor = -1;
    } else {
      xfactor = 1;
    }
  }

  self.x = element.x + offsetx * xfactor;

  if(relativey == element.aligny) {
    offsety = 0;
    yfactor = 0;
  } else if(relativey == "<dev string:x49>" || element.aligny == "<dev string:x49>") {
    offsety = int(element.height / 2);

    if(relativey == "<dev string:x53>" || element.aligny == "<dev string:x5a>") {
      yfactor = -1;
    } else {
      yfactor = 1;
    }
  } else {
    offsety = element.height;

    if(relativey == "<dev string:x53>") {
      yfactor = -1;
    } else {
      yfactor = 1;
    }
  }

  self.y = element.y + offsety * yfactor;
  self.x += self.xoffset;
  self.y += self.yoffset;

  switch (self.elemtype) {
    case # "bar":
      setpointbar(point, relativepoint, xoffset, yoffset);
      self.barframe setparent(self getparent());
      self.barframe setpoint(point, relativepoint, xoffset, yoffset);
      break;
  }

  self updatechildren();
}

function setpointbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "<dev string:x64>";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "<dev string:x64>") {
    self.bar.x = self.x;
  } else if(self.alignx == "<dev string:x6c>") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }

  if(self.aligny == "<dev string:x53>") {
    self.bar.y = self.y;
  } else if(self.aligny == "<dev string:x5a>") {
    self.bar.y = self.y;
  }

  self updatebar(self.bar.frac);
}

function updatebar(barfrac, rateofchange) {
  if(self.elemtype == "<dev string:xe3>") {
    updatebarscale(barfrac, rateofchange);
  }
}

function updatebarscale(barfrac, rateofchange) {
  barwidth = int(self.width * barfrac + 0.5);

  if(!barwidth) {
    barwidth = 1;
  }

  self.bar.frac = barfrac;
  self.bar setshader(self.bar.shader, barwidth, self.height);
  assert(barwidth <= self.width, "<dev string:xea>" + barwidth + "<dev string:x106>" + self.width + "<dev string:x10e>" + barfrac);

  if(isDefined(rateofchange) && barwidth < self.width) {
    if(rateofchange > 0) {
      assert((1 - barfrac) / rateofchange > 0, "<dev string:x121>" + barfrac + "<dev string:x12e>" + rateofchange);
      self.bar scaleovertime((1 - barfrac) / rateofchange, self.width, self.height);
    } else if(rateofchange < 0) {
      assert(barfrac / -1 * rateofchange > 0, "<dev string:x121>" + barfrac + "<dev string:x12e>" + rateofchange);
      self.bar scaleovertime(barfrac / -1 * rateofchange, 1, self.height);
    }
  }

  self.bar.rateofchange = rateofchange;
  self.bar.lastupdatetime = gettime();
}

function function_665f547d(font, fontscale) {
  fontelem = newdebughudelem(self);
  fontelem.elemtype = "<dev string:x140>";
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
  fontelem.hidden = 0;
  return fontelem;
}

function function_f5a689d(font, fontscale) {
  fontelem = newdebughudelem();
  fontelem.elemtype = "<dev string:x140>";
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
  fontelem.hidden = 0;
  return fontelem;
}

function function_7a0dd8a9(color, width, height) {
  barelem = newdebughudelem(self);
  barelem.x = 0;
  barelem.y = 0;
  barelem.frac = 0;
  barelem.color = color;
  barelem.sort = -2;
  barelem.shader = "<dev string:x148>";
  barelem setshader(#"progress_bar_fill", width, height);
  barelem.hidden = 0;
  barelemframe = newdebughudelem(self);
  barelemframe.elemtype = "<dev string:x15d>";
  barelemframe.x = 0;
  barelemframe.y = 0;
  barelemframe.width = width;
  barelemframe.height = height;
  barelemframe.xoffset = 0;
  barelemframe.yoffset = 0;
  barelemframe.bar = barelem;
  barelemframe.barframe = barelemframe;
  barelemframe.children = [];
  barelemframe.sort = -1;
  barelemframe.color = (1, 1, 1);
  barelemframe setparent(level.uiparent);
  barelemframe.hidden = 0;
  barelembg = newdebughudelem(self);
  barelembg.elemtype = "<dev string:xe3>";

  if(!level.splitscreen) {
    barelembg.x = -2;
    barelembg.y = -2;
  }

  barelembg.width = width;
  barelembg.height = height;
  barelembg.xoffset = 0;
  barelembg.yoffset = 0;
  barelembg.bar = barelem;
  barelembg.barframe = barelemframe;
  barelembg.children = [];
  barelembg.sort = -3;
  barelembg.color = (0, 0, 0);
  barelembg.alpha = 0.5;
  barelembg setparent(level.uiparent);

  if(!level.splitscreen) {
    barelembg setshader(#"progress_bar_bg", width + 4, height + 4);
  } else {
    barelembg setshader(#"progress_bar_bg", width + 0, height + 0);
  }

  barelembg.hidden = 0;
  return barelembg;
}

function function_5037fb7f() {
  bar = function_7a0dd8a9((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);

  if(level.splitscreen) {
    bar setpoint("<dev string:x38>", undefined, level.primaryprogressbarx, level.primaryprogressbary);
  } else {
    bar setpoint("<dev string:x165>", undefined, level.primaryprogressbarx, level.primaryprogressbary);
  }

  return bar;
}

function function_48badcf4() {
  text = function_665f547d("<dev string:x16f>", level.primaryprogressbarfontsize);

  if(level.splitscreen) {
    text setpoint("<dev string:x38>", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty);
  } else {
    text setpoint("<dev string:x165>", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty);
  }

  text.sort = -1;
  return text;
}

function hideelem() {
  if(self.hidden) {
    return;
  }

  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }

  if(self.elemtype == "<dev string:xe3>" || self.elemtype == "<dev string:x17c>") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }

    self.barframe.hidden = 1;

    if(self.barframe.alpha != 0) {
      self.barframe.alpha = 0;
    }
  }
}

function showelem() {
  if(!self.hidden) {
    return;
  }

  self.hidden = 0;

  if(self.elemtype == "<dev string:xe3>" || self.elemtype == "<dev string:x17c>") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }

    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }

    self.barframe.hidden = 0;

    if(self.barframe.alpha != 1) {
      self.barframe.alpha = 1;
    }

    return;
  }

  if(self.alpha != 1) {
    self.alpha = 1;
  }
}

function destroyelem() {
  tempchildren = [];

  for(index = 0; index < self.children.size; index++) {
    if(isDefined(self.children[index])) {
      tempchildren[tempchildren.size] = self.children[index];
    }
  }

  for(index = 0; index < tempchildren.size; index++) {
    tempchildren[index] setparent(self getparent());
  }

  if(self.elemtype == "<dev string:xe3>" || self.elemtype == "<dev string:x17c>") {
    self.bar destroy();
    self.barframe destroy();
  }

  self destroy();
}

function updatechildren() {
  for(index = 0; index < self.children.size; index++) {
    child = self.children[index];
    child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset);
  }
}