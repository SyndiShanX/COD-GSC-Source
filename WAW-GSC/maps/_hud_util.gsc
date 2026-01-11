/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_hud_util.gsc
*****************************************************/

#include maps\_utility;
#include animscripts\utility;
#include common_scripts\utility;

setParent(element) {
  if(isDefined(self.parent) && self.parent == element) {
    return;
  }
  if(isDefined(self.parent)) {
    self.parent removeChild(self);
  }
  self.parent = element;
  self.parent addChild(self);
  if(isDefined(self.point)) {
    self setPoint(self.point, self.relativePoint, self.xOffset, self.yOffset);
  } else {
    self setPoint("TOPLEFT");
  }
}

getParent() {
  return self.parent;
}

addChild(element) {
  element.index = self.children.size;
  self.children[self.children.size] = element;
}

removeChild(element) {
  element.parent = undefined;
  if(self.children[self.children.size - 1] != element) {
    self.children[element.index] = self.children[self.children.size - 1];
    self.children[element.index].index = element.index;
  }
  self.children[self.children.size - 1] = undefined;
  element.index = undefined;
}

setPoint(point, relativePoint, xOffset, yOffset, moveTime) {
  if(!isDefined(moveTime)) {
    moveTime = 0;
  }
  element = self getParent();
  if(moveTime) {
    self moveOverTime(moveTime);
  }
  if(!isDefined(xOffset)) {
    xOffset = 0;
  }
  self.xOffset = xOffset;
  if(!isDefined(yOffset)) {
    yOffset = 0;
  }
  self.yOffset = yOffset;
  self.point = point;
  self.alignX = "center";
  self.alignY = "middle";
  if(isSubStr(point, "TOP")) {
    self.alignY = "top";
  }
  if(isSubStr(point, "BOTTOM")) {
    self.alignY = "bottom";
  }
  if(isSubStr(point, "LEFT")) {
    self.alignX = "left";
  }
  if(isSubStr(point, "RIGHT")) {
    self.alignX = "right";
  }
  if(!isDefined(relativePoint)) {
    relativePoint = point;
  }
  self.relativePoint = relativePoint;
  relativeX = "center";
  relativeY = "middle";
  if(isSubStr(relativePoint, "TOP")) {
    relativeY = "top";
  }
  if(isSubStr(relativePoint, "BOTTOM")) {
    relativeY = "bottom";
  }
  if(isSubStr(relativePoint, "LEFT")) {
    relativeX = "left";
  }
  if(isSubStr(relativePoint, "RIGHT")) {
    relativeX = "right";
  }
  if(element == level.uiParent) {
    self.horzAlign = relativeX;
    self.vertAlign = relativeY;
  } else {
    self.horzAlign = element.horzAlign;
    self.vertAlign = element.vertAlign;
  }
  if(relativeX == element.alignX) {
    offsetX = 0;
    xFactor = 0;
  } else if(relativeX == "center" || element.alignX == "center") {
    offsetX = int(element.width / 2);
    if(relativeX == "left" || element.alignX == "right") {
      xFactor = -1;
    } else {
      xFactor = 1;
    }
  } else {
    offsetX = element.width;
    if(relativeX == "left") {
      xFactor = -1;
    } else {
      xFactor = 1;
    }
  }
  self.x = element.x + (offsetX * xFactor);
  if(relativeY == element.alignY) {
    offsetY = 0;
    yFactor = 0;
  } else if(relativeY == "middle" || element.alignY == "middle") {
    offsetY = int(element.height / 2);
    if(relativeY == "top" || element.alignY == "bottom") {
      yFactor = -1;
    } else {
      yFactor = 1;
    }
  } else {
    offsetY = element.height;
    if(relativeY == "top") {
      yFactor = -1;
    } else {
      yFactor = 1;
    }
  }
  self.y = element.y + (offsetY * yFactor);
  self.x += self.xOffset;
  self.y += self.yOffset;
  switch (self.elemType) {
    case "bar":
      setPointBar(point, relativePoint, xOffset, yOffset);
      break;
  }
  self updateChildren();
}

setPointBar(point, relativePoint, xOffset, yOffset) {
  self.bar.horzAlign = self.horzAlign;
  self.bar.vertAlign = self.vertAlign;
  self.bar.alignX = "left";
  self.bar.alignY = self.alignY;
  self.bar.y = self.y;
  if(self.alignX == "left") {
    self.bar.x = self.x;
  } else if(self.alignX == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }
  if(self.alignY == "top") {
    self.bar.y = self.y;
  } else if(self.alignY == "bottom") {
    self.bar.y = self.y;
  }
  self updateBar(self.bar.frac);
}

updateBar(barFrac, rateOfChange) {
  if(self.elemType == "bar") {
    updateBarScale(barFrac, rateOfChange);
  }
}

updateBarScale(barFrac, rateOfChange) {
  barWidth = int(self.width * barFrac + 0.5);
  if(!barWidth) {
    barWidth = 1;
  }
  self.bar.frac = barFrac;
  self.bar setShader(self.bar.shader, barWidth, self.height);
  assertEx(barWidth <= self.width, "barWidth <= self.width: " + barWidth + " <= " + self.width + " - barFrac was " + barFrac);
  if(isDefined(rateOfChange) && barWidth < self.width) {
    if(rateOfChange > 0) {
      assertex(((1 - barFrac) / rateOfChange) > 0, "barFrac: " + barFrac + "rateOfChange: " + rateOfChange);
      self.bar scaleOverTime((1 - barFrac) / rateOfChange, self.width, self.height);
    } else if(rateOfChange < 0) {
      assertex((barFrac / (-1 * rateOfChange)) > 0, "barFrac: " + barFrac + "rateOfChange: " + rateOfChange);
      self.bar scaleOverTime(barFrac / (-1 * rateOfChange), 1, self.height);
    }
  }
  self.bar.rateOfChange = rateOfChange;
  self.bar.lastUpdateTime = getTime();
}

createFontString(font, fontScale, player) {
  if(isDefined(player)) {
    fontElem = newClientHudElem(player);
  } else {
    fontElem = newHudElem(self);
  }
  fontElem.elemType = "font";
  fontElem.font = font;
  fontElem.fontscale = fontScale;
  fontElem.x = 0;
  fontElem.y = 0;
  fontElem.sort = 100;
  fontElem.width = 0;
  fontElem.height = int(level.fontHeight * fontScale);
  fontElem.xOffset = 0;
  fontElem.yOffset = 0;
  fontElem.children = [];
  fontElem setParent(level.uiParent);
  return fontElem;
}

createServerFontString(font, fontScale) {
  fontElem = newHudElem(self);
  fontElem.elemType = "font";
  fontElem.font = font;
  fontElem.fontscale = fontScale;
  fontElem.x = 0;
  fontElem.y = 0;
  fontElem.width = 0;
  fontElem.height = int(level.fontHeight * fontScale);
  fontElem.xOffset = 0;
  fontElem.yOffset = 0;
  fontElem.children = [];
  fontElem setParent(level.uiParent);
  return fontElem;
}

createServerTimer(font, fontScale) {
  timerElem = newHudElem();
  timerElem.elemType = "timer";
  timerElem.font = font;
  timerElem.fontscale = fontScale;
  timerElem.x = 0;
  timerElem.y = 0;
  timerElem.width = 0;
  timerElem.height = int(level.fontHeight * fontScale);
  timerElem.xOffset = 0;
  timerElem.yOffset = 0;
  timerElem.children = [];
  timerElem setParent(level.uiParent);
  return timerElem;
}

createIcon(shader, width, height, player) {
  if(isDefined(player)) {
    iconElem = newClientHudElem(player);
  } else {
    iconElem = newHudElem(self);
  }
  iconElem.elemType = "icon";
  iconElem.x = 0;
  iconElem.y = 0;
  iconElem.width = width;
  iconElem.height = height;
  iconElem.xOffset = 0;
  iconElem.yOffset = 0;
  iconElem.children = [];
  iconElem setParent(level.uiParent);
  if(isDefined(shader)) {
    iconElem setShader(shader, width, height);
  }
  return iconElem;
}

createBar(color, width, height, flashFrac) {
  barElem = newClientHudElem(self);
  barElem.x = 0;
  barElem.y = 0;
  barElem.frac = 0;
  barElem.color = color;
  barElem.sort = -2;
  barElem.shader = "white";
  barElem setShader("white", width, height);
  barElem.hidden = false;
  if(isDefined(flashFrac)) {
    barElem.flashFrac = flashFrac;
  }
  barElemFrame = newClientHudElem(self);
  barElemFrame.elemType = "icon";
  barElemFrame.x = 0;
  barElemFrame.y = 0;
  barElemFrame.width = width;
  barElemFrame.height = height;
  barElemFrame.xOffset = 0;
  barElemFrame.yOffset = 0;
  barElemFrame.bar = barElem;
  barElemFrame.barFrame = barElemFrame;
  barElemFrame.children = [];
  barElemFrame.sort = -1;
  barElemFrame.color = (1, 1, 1);
  barElemFrame setParent(level.uiParent);
  barElemFrame.hidden = false;
  barElemBG = newClientHudElem(self);
  barElemBG.elemType = "bar";
  if(!level.splitScreen) {
    barElemBG.x = -2;
    barElemBG.y = -2;
  }
  barElemBG.width = width;
  barElemBG.height = height;
  barElemBG.xOffset = 0;
  barElemBG.yOffset = 0;
  barElemBG.bar = barElem;
  barElemBG.barFrame = barElemFrame;
  barElemBG.children = [];
  barElemBG.sort = -3;
  barElemBG.color = (0, 0, 0);
  barElemBG.alpha = 0.5;
  barElemBG setParent(level.uiParent);
  if(!level.splitScreen) {
    barElemBG setShader("black", width + 4, height + 4);
  } else {
    barElemBG setShader("black", width + 0, height + 0);
  }
  barElemBG.hidden = false;
  return barElemBG;
}

createPrimaryProgressBar() {
  bar = createBar((1, 1, 1), level.primaryProgressBarWidth, level.primaryProgressBarHeight);
  if(level.splitScreen) {
    bar setPoint("TOP", undefined, level.primaryProgressBarX, level.primaryProgressBarY);
  } else {
    bar setPoint("CENTER", undefined, level.primaryProgressBarX, level.primaryProgressBarY);
  }
  return bar;
}

hideElem() {
  if(self.hidden) {
    return;
  }
  self.hidden = true;
  if(self.alpha != 0) {
    self.alpha = 0;
  }
  if(self.elemType == "bar" || self.elemType == "bar_shader") {
    self.bar.hidden = true;
    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
    self.barFrame.hidden = true;
    if(self.barFrame.alpha != 0) {
      self.barFrame.alpha = 0;
    }
  }
}

showElem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = false;
  if(self.elemType == "bar" || self.elemType == "bar_shader") {
    if(self.alpha != .5) {
      self.alpha = .5;
    }
    self.bar.hidden = false;
    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }
    self.barFrame.hidden = false;
    if(self.barFrame.alpha != 1) {
      self.barFrame.alpha = 1;
    }
  } else {
    if(self.alpha != 1) {
      self.alpha = 1;
    }
  }
}

setFlashFrac(flashFrac) {
  self.bar.flashFrac = flashFrac;
}

flashThread() {
  self endon("death");
  self.alpha = 1;
  while(1) {
    if(self.frac >= self.flashFrac) {
      self fadeOverTime(0.3);
      self.alpha = .2;
      wait(0.35);
      self fadeOverTime(0.3);
      self.alpha = 1;
      wait(0.7);
    } else {
      self.alpha = 1;
      wait(0.05);
    }
  }
}

destroyElem() {
  tempChildren = [];
  for(index = 0; index < self.children.size; index++) {
    tempChildren[index] = self.children[index];
  }
  for(index = 0; index < tempChildren.size; index++) {
    tempChildren[index] setParent(self getParent());
  }
  if(self.elemType == "bar") {
    self.bar destroy();
    self.barFrame destroy();
  }
  self destroy();
}

setIconShader(shader) {
  self setShader(shader, self.width, self.height);
}

setWidth(width) {
  self.width = width;
}

setHeight(height) {
  self.height = height;
}

setSize(width, height) {
  self.width = width;
  self.height = height;
}

updateChildren() {
  for(index = 0; index < self.children.size; index++) {
    child = self.children[index];
    child setPoint(child.point, child.relativePoint, child.xOffset, child.yOffset);
  }
}

create_mantle() {
  text = createFontString("default", 1.8);
  text setPoint("CENTER", undefined, -23, 115);
  text settext(level.strings["mantle"]);
  icon = createIcon("hint_mantle", 40, 40);
  icon setPoint("CENTER", undefined, 73, 0);
  icon setparent(text);
  icon.alpha = 0;
  text.alpha = 0;
  level.hud_mantle = [];
  level.hud_mantle["text"] = text;
  level.hud_mantle["icon"] = icon;
}

get_countdown_hud(x) {
  xPos = undefined;
  if(!isDefined(x)) {
    xPos = -225;
  } else {
    xPos = x;
  }
  hudelem = newHudElem();
  hudelem.alignX = "left";
  hudelem.alignY = "middle";
  hudelem.horzAlign = "right";
  hudelem.vertAlign = "top";
  hudelem.x = xPos;
  hudelem.y = 100;
  if(arcadeMode()) {
    hudelem.alignX = "left";
    hudelem.alignY = "top";
    hudelem.horzAlign = "right";
    hudelem.vertAlign = "top";
    hudelem.y = 0;
  }
  hudelem.fontScale = 1.6;
  hudelem.color = (0.8, 1.0, 0.8);
  hudelem.font = "objective";
  hudelem.glowColor = (0.3, 0.6, 0.3);
  hudelem.glowAlpha = 1;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = true;
  return hudelem;
}