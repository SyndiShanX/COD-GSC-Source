/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_util.gsc
***********************************************/

setparent(_id_F7806D4CF24AACD3) {
  if(isDefined(self.parent) && self.parent == _id_F7806D4CF24AACD3) {
    return;
  }
  if(isDefined(self.parent))
    self.parent removechild(self);

  self.parent = _id_F7806D4CF24AACD3;
  self.parent addchild(self);

  if(isDefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
    setpoint("TOPLEFT");
}

getparent() {
  return self.parent;
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  _id_3DDCDB8C8D35246A = [];

  foreach(_id_AC0E594AC96AA3A8, child in self.children) {
    if(!isDefined(child)) {
      continue;
    }
    child.index = _id_3DDCDB8C8D35246A.size;
    _id_3DDCDB8C8D35246A[_id_3DDCDB8C8D35246A.size] = child;
  }

  self.children = _id_3DDCDB8C8D35246A;
}

addchild(_id_F7806D4CF24AACD3) {
  _id_F7806D4CF24AACD3.index = self.children.size;
  self.children[self.children.size] = _id_F7806D4CF24AACD3;
  removedestroyedchildren();
}

removechild(_id_F7806D4CF24AACD3) {
  _id_F7806D4CF24AACD3.parent = undefined;

  if(self.children[self.children.size - 1] != _id_F7806D4CF24AACD3) {
    self.children[_id_F7806D4CF24AACD3.index] = self.children[self.children.size - 1];
    self.children[_id_F7806D4CF24AACD3.index].index = _id_F7806D4CF24AACD3.index;
  }

  self.children[self.children.size - 1] = undefined;
  _id_F7806D4CF24AACD3.index = undefined;
}

setpoint(point, relativepoint, xoffset, yoffset, movetime) {
  if(!isDefined(movetime))
    movetime = 0;

  _id_F7806D4CF24AACD3 = getparent();

  if(movetime)
    self moveovertime(movetime);

  if(!isDefined(xoffset))
    xoffset = 0;

  self.xoffset = xoffset;

  if(!isDefined(yoffset))
    yoffset = 0;

  self.yoffset = yoffset;
  self.point = point;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(point, "TOP"))
    self.aligny = "top";

  if(issubstr(point, "BOTTOM"))
    self.aligny = "bottom";

  if(issubstr(point, "LEFT"))
    self.alignx = "left";

  if(issubstr(point, "RIGHT"))
    self.alignx = "right";

  if(!isDefined(relativepoint))
    relativepoint = point;

  self.relativepoint = relativepoint;
  _id_32149D41AB89B2CB = "center_adjustable";
  _id_32149C41AB89B098 = "middle";

  if(issubstr(relativepoint, "TOP"))
    _id_32149C41AB89B098 = "top_adjustable";

  if(issubstr(relativepoint, "BOTTOM"))
    _id_32149C41AB89B098 = "bottom_adjustable";

  if(issubstr(relativepoint, "LEFT"))
    _id_32149D41AB89B2CB = "left_adjustable";

  if(issubstr(relativepoint, "RIGHT"))
    _id_32149D41AB89B2CB = "right_adjustable";

  if(_id_F7806D4CF24AACD3 == level.uiparent) {
    self.horzalign = _id_32149D41AB89B2CB;
    self.vertalign = _id_32149C41AB89B098;
  } else {
    self.horzalign = _id_F7806D4CF24AACD3.horzalign;
    self.vertalign = _id_F7806D4CF24AACD3.vertalign;
  }

  if(scripts\mp\utility\script::strip_suffix(_id_32149D41AB89B2CB, "_adjustable") == _id_F7806D4CF24AACD3.alignx) {
    offsetx = 0;
    _id_D92133D2D7B55484 = 0;
  } else if(_id_32149D41AB89B2CB == "center" || _id_F7806D4CF24AACD3.alignx == "center") {
    offsetx = int(_id_F7806D4CF24AACD3.width / 2);

    if(_id_32149D41AB89B2CB == "left_adjustable" || _id_F7806D4CF24AACD3.alignx == "right")
      _id_D92133D2D7B55484 = -1;
    else
      _id_D92133D2D7B55484 = 1;
  } else {
    offsetx = _id_F7806D4CF24AACD3.width;

    if(_id_32149D41AB89B2CB == "left_adjustable")
      _id_D92133D2D7B55484 = -1;
    else
      _id_D92133D2D7B55484 = 1;
  }

  self.x = _id_F7806D4CF24AACD3.x + offsetx * _id_D92133D2D7B55484;

  if(scripts\mp\utility\script::strip_suffix(_id_32149C41AB89B098, "_adjustable") == _id_F7806D4CF24AACD3.aligny) {
    offsety = 0;
    _id_F28981E9D5FBE3EB = 0;
  } else if(_id_32149C41AB89B098 == "middle" || _id_F7806D4CF24AACD3.aligny == "middle") {
    offsety = int(_id_F7806D4CF24AACD3.height / 2);

    if(_id_32149C41AB89B098 == "top_adjustable" || _id_F7806D4CF24AACD3.aligny == "bottom")
      _id_F28981E9D5FBE3EB = -1;
    else
      _id_F28981E9D5FBE3EB = 1;
  } else {
    offsety = _id_F7806D4CF24AACD3.height;

    if(_id_32149C41AB89B098 == "top_adjustable")
      _id_F28981E9D5FBE3EB = -1;
    else
      _id_F28981E9D5FBE3EB = 1;
  }

  self.y = _id_F7806D4CF24AACD3.y + offsety * _id_F28981E9D5FBE3EB;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(point, relativepoint, xoffset, yoffset);
      break;
  }

  updatechildren();
}

setpointbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left")
    self.bar.x = self.x;
  else if(self.alignx == "right")
    self.bar.x = self.x - self.width;
  else
    self.bar.x = self.x - int(self.width / 2);

  if(self.aligny == "top")
    self.bar.y = self.y;
  else if(self.aligny == "bottom")
    self.bar.y = self.y;

  updatebar(self.bar.frac);
}

updatebar(_id_144981CC6EB4B07A, rateofchange) {
  if(self.elemtype == "bar")
    updatebarscale(_id_144981CC6EB4B07A, rateofchange);
}

updatebarscale(_id_144981CC6EB4B07A, rateofchange) {
  _id_9017AC78A8DCE9DA = int(self.width * _id_144981CC6EB4B07A + 0.5);

  if(!_id_9017AC78A8DCE9DA)
    _id_9017AC78A8DCE9DA = 1;

  self.bar.frac = _id_144981CC6EB4B07A;
  self.bar setshader(self.bar.shader, _id_9017AC78A8DCE9DA, self.height);

  if(isDefined(rateofchange) && _id_9017AC78A8DCE9DA < self.width) {
    if(rateofchange > 0)
      self.bar scaleovertime((1 - _id_144981CC6EB4B07A) / rateofchange, self.width, self.height);
    else if(rateofchange < 0)
      self.bar scaleovertime(_id_144981CC6EB4B07A / (-1 * rateofchange), 1, self.height);
  }

  self.bar.rateofchange = rateofchange;
  self.bar.lastupdatetime = gettime();
}

createfontstring(font, fontscale) {
  _id_372B658AEA9D2487 = newclienthudelem(self);
  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = font;
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  return _id_372B658AEA9D2487;
}

createservertimer(font, fontscale, team) {
  if(isDefined(team))
    _id_4908CA330BDC48D1 = newteamhudelem(team);
  else
    _id_4908CA330BDC48D1 = newhudelem();

  _id_4908CA330BDC48D1.elemtype = "timer";
  _id_4908CA330BDC48D1.font = font;
  _id_4908CA330BDC48D1.fontscale = fontscale;
  _id_4908CA330BDC48D1.basefontscale = fontscale;
  _id_4908CA330BDC48D1.x = 0;
  _id_4908CA330BDC48D1.y = 0;
  _id_4908CA330BDC48D1.width = 0;
  _id_4908CA330BDC48D1.height = int(level.fontheight * fontscale);
  _id_4908CA330BDC48D1.xoffset = 0;
  _id_4908CA330BDC48D1.yoffset = 0;
  _id_4908CA330BDC48D1.children = [];
  _id_4908CA330BDC48D1 setparent(level.uiparent);
  _id_4908CA330BDC48D1.hidden = 0;
  return _id_4908CA330BDC48D1;
}

createtimer(font, fontscale) {
  _id_4908CA330BDC48D1 = newclienthudelem(self);
  _id_4908CA330BDC48D1.elemtype = "timer";
  _id_4908CA330BDC48D1.font = font;
  _id_4908CA330BDC48D1.fontscale = fontscale;
  _id_4908CA330BDC48D1.basefontscale = fontscale;
  _id_4908CA330BDC48D1.x = 0;
  _id_4908CA330BDC48D1.y = 0;
  _id_4908CA330BDC48D1.width = 0;
  _id_4908CA330BDC48D1.height = int(level.fontheight * fontscale);
  _id_4908CA330BDC48D1.xoffset = 0;
  _id_4908CA330BDC48D1.yoffset = 0;
  _id_4908CA330BDC48D1.children = [];
  _id_4908CA330BDC48D1 setparent(level.uiparent);
  _id_4908CA330BDC48D1.hidden = 0;
  return _id_4908CA330BDC48D1;
}

createicon(shader, width, height) {
  _id_5B6A2597D526BD27 = newclienthudelem(self);
  _id_5B6A2597D526BD27.elemtype = "icon";
  _id_5B6A2597D526BD27.x = 0;
  _id_5B6A2597D526BD27.y = 0;
  _id_5B6A2597D526BD27.width = width;
  _id_5B6A2597D526BD27.height = height;
  _id_5B6A2597D526BD27.basewidth = _id_5B6A2597D526BD27.width;
  _id_5B6A2597D526BD27.baseheight = _id_5B6A2597D526BD27.height;
  _id_5B6A2597D526BD27.xoffset = 0;
  _id_5B6A2597D526BD27.yoffset = 0;
  _id_5B6A2597D526BD27.children = [];
  _id_5B6A2597D526BD27 setparent(level.uiparent);
  _id_5B6A2597D526BD27.hidden = 0;

  if(isDefined(shader)) {
    _id_5B6A2597D526BD27 setshader(shader, width, height);
    _id_5B6A2597D526BD27.shader = shader;
  }

  return _id_5B6A2597D526BD27;
}

createbar(color, width, height, flashfrac) {
  barelem = newclienthudelem(self);
  barelem.x = 0;
  barelem.y = 0;
  barelem.frac = 0;
  barelem.color = color;
  barelem.sort = -2;
  barelem.shader = "progress_bar_fill";
  barelem setshader("progress_bar_fill", width, height);
  barelem.hidden = 0;

  if(isDefined(flashfrac))
    barelem.flashfrac = flashfrac;

  _id_B27D6AD98ACD05BA = newclienthudelem(self);
  _id_B27D6AD98ACD05BA.elemtype = "bar";
  _id_B27D6AD98ACD05BA.width = width;
  _id_B27D6AD98ACD05BA.height = height;
  _id_B27D6AD98ACD05BA.xoffset = 0;
  _id_B27D6AD98ACD05BA.yoffset = 0;
  _id_B27D6AD98ACD05BA.bar = barelem;
  _id_B27D6AD98ACD05BA.children = [];
  _id_B27D6AD98ACD05BA.sort = -3;
  _id_B27D6AD98ACD05BA.color = (0, 0, 0);
  _id_B27D6AD98ACD05BA.alpha = 0.5;
  _id_B27D6AD98ACD05BA setparent(level.uiparent);
  _id_B27D6AD98ACD05BA setshader("progress_bar_bg", width + 4, height + 4);
  _id_B27D6AD98ACD05BA.hidden = 0;
  return _id_B27D6AD98ACD05BA;
}

getcurrentfraction() {
  frac = self.bar.frac;

  if(isDefined(self.bar.rateofchange)) {
    frac = frac + (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;

    if(frac > 1)
      frac = 1;

    if(frac < 0)
      frac = 0;
  }

  return frac;
}

createprimaryprogressbar(xoffset, yoffset) {
  if(isagent(self))
    return undefined;

  if(!isDefined(xoffset))
    xoffset = 0;

  if(!isDefined(yoffset))
    yoffset = -25;

  if(self issplitscreenplayer())
    yoffset = yoffset + 20;

  bar = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  bar setpoint("CENTER", undefined, level.primaryprogressbarx + xoffset, level.primaryprogressbary + yoffset);
  return bar;
}

createprimaryprogressbartext(xoffset, yoffset, _id_780737A0C9EC4AB5, _id_76AC8A084F06EA85) {
  if(isagent(self))
    return undefined;

  if(!isDefined(xoffset))
    xoffset = 0;

  if(!isDefined(yoffset))
    yoffset = -25;

  if(self issplitscreenplayer())
    yoffset = yoffset + 20;

  _id_F0778934C2C7E788 = level.primaryprogressbarfontsize;
  font = "default";

  if(isDefined(_id_780737A0C9EC4AB5))
    _id_F0778934C2C7E788 = _id_780737A0C9EC4AB5;

  if(isDefined(_id_76AC8A084F06EA85))
    font = _id_76AC8A084F06EA85;

  text = createfontstring(font, _id_F0778934C2C7E788);
  text setpoint("CENTER", undefined, level.primaryprogressbartextx + xoffset, level.primaryprogressbartexty + yoffset);
  text.sort = -1;
  return text;
}

setflashfrac(flashfrac) {
  self.bar.flashfrac = flashfrac;
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0)
    self.alpha = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0)
      self.bar.alpha = 0;
  }
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5)
      self.alpha = 0.5;

    self.bar.hidden = 0;

    if(self.bar.alpha != 1)
      self.bar.alpha = 1;
  } else if(self.alpha != 1)
    self.alpha = 1;
}

flashthread() {
  self endon("death");

  if(!self.hidden)
    self.alpha = 1;

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

    if(!self.hidden && self.alpha != 1)
      self.alpha = 1;

    wait 0.05;
  }
}

destroyelem() {
  _id_3D3334E0AD5D51F4 = [];

  for(index = 0; index < self.children.size; index++) {
    if(isDefined(self.children[index]))
      _id_3D3334E0AD5D51F4[_id_3D3334E0AD5D51F4.size] = self.children[index];
  }

  for(index = 0; index < _id_3D3334E0AD5D51F4.size; index++)
    _id_3D3334E0AD5D51F4[index] setparent(getparent());

  if(self.elemtype == "bar" || self.elemtype == "bar_shader")
    self.bar destroy();

  self destroy();
}

seticonshader(shader) {
  self setshader(shader, self.width, self.height);
  self.shader = shader;
}

geticonshader(shader) {
  return self.shader;
}

seticonsize(width, height) {
  self setshader(self.shader, width, height);
}

setwidth(width) {
  self.width = width;
}

setheight(height) {
  self.height = height;
}

setsize(width, height) {
  self.width = width;
  self.height = height;
}

updatechildren() {
  for(index = 0; index < self.children.size; index++) {
    child = self.children[index];
    child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset);
  }
}

transitionreset() {
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "font") {
    self.fontscale = self.basefontscale;
    self.label = &"";
  } else if(self.elemtype == "icon")
    self setshader(self.shader, self.width, self.height);

  self.alpha = 0;
}

transitionzoomin(duration) {
  switch (self.elemtype) {
    case "font":
    case "timer":
      self.fontscale = 6.3;
      self changefontscaleovertime(duration);
      self.fontscale = self.basefontscale;
      break;
    case "icon":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(duration, self.width, self.height);
      break;
  }
}

transitionpulsefxin(_id_187EF7FAE5A4F6F3, duration) {
  _id_12F792CF249A56D4 = int(_id_187EF7FAE5A4F6F3) * 1000;
  _id_E6932C067E0B2E71 = int(duration) * 1000;

  switch (self.elemtype) {
    case "font":
    case "timer":
      self setpulsefx(_id_12F792CF249A56D4 + 250, _id_E6932C067E0B2E71 + _id_12F792CF249A56D4, _id_12F792CF249A56D4 + 250);
      break;
    default:
      break;
  }
}

transitionslidein(duration, direction) {
  if(!isDefined(direction))
    direction = "left";

  switch (direction) {
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

  self moveovertime(duration);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(duration, direction) {
  if(!isDefined(direction))
    direction = "left";

  _id_DC7E30144BC463CE = self.xoffset;
  _id_DC7E31144BC46601 = self.yoffset;

  switch (direction) {
    case "left":
      _id_DC7E30144BC463CE = _id_DC7E30144BC463CE + 1000;
      break;
    case "right":
      _id_DC7E30144BC463CE = _id_DC7E30144BC463CE - 1000;
      break;
    case "up":
      _id_DC7E31144BC46601 = _id_DC7E31144BC46601 - 1000;
      break;
    case "down":
      _id_DC7E31144BC46601 = _id_DC7E31144BC46601 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(duration);
  self.x = _id_DC7E30144BC463CE;
  self.y = _id_DC7E31144BC46601;
}

transitionzoomout(duration) {
  switch (self.elemtype) {
    case "font":
    case "timer":
      self changefontscaleovertime(duration);
      self.fontscale = 6.3;
    case "icon":
      self scaleovertime(duration, self.width * 6, self.height * 6);
      break;
  }
}

transitionfadein(duration) {
  self fadeovertime(duration);

  if(isDefined(self.maxalpha))
    self.alpha = self.maxalpha;
  else
    self.alpha = 1;
}

transitionfadeout(duration) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

teamplayercardsplash(_id_1B4ADA49A21B51CA, owner, team, optionalnumber, _id_B7ABC0284E13CA7A) {
  if(!canshowsplash(_id_1B4ADA49A21B51CA)) {
    return;
  }
  _id_B7ABC0284E13CA7A = istrue(_id_B7ABC0284E13CA7A);

  if(scripts\cp_mp\utility\game_utility::islargebrmap()) {
    _id_54216530F9ADE838 = scripts\mp\utility\teams::getteamdata(owner.team, "players");

    if(isDefined(_id_54216530F9ADE838)) {
      foreach(player in _id_54216530F9ADE838) {
        if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player) || player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
          continue;
        }
        if(_id_B7ABC0284E13CA7A && isPlayer(owner) && player == owner) {
          continue;
        }
        player thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, owner);
      }

      return;
    }
  } else {
    foreach(player in level.players) {
      if(player _meth_8420670EAFC8D391()) {
        _id_13C5603D4BEEA2FC = player getspectatingplayer();

        if(isDefined(_id_13C5603D4BEEA2FC) && isDefined(team) && _id_13C5603D4BEEA2FC.team != team)
          continue;
      } else {
        if(!isPlayer(player)) {
          continue;
        }
        if(isDefined(team) && player.team != team) {
          continue;
        }
        if(_id_B7ABC0284E13CA7A && isPlayer(owner) && player == owner)
          continue;
      }

      player thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, owner);
    }
  }
}

_id_7B2653A588F28E29(owner, _id_34C19B030FB21CC7, _id_274D4F09B844D959, _id_B94346D9018FE098, _id_B7ABC0284E13CA7A, _id_F5C11D099500E94E, _id_6ACC43FA4DB03A7F, _id_6AD135FA4DB6448C) {
  if(canshowsplash(_id_34C19B030FB21CC7) && !istrue(_id_B7ABC0284E13CA7A))
    owner thread scripts\mp\hud_message::showsplash(_id_34C19B030FB21CC7, _id_F5C11D099500E94E, owner);

  level thread scripts\mp\hud_message::notifyteam(_id_274D4F09B844D959, _id_B94346D9018FE098, owner.team, [owner], _id_6ACC43FA4DB03A7F, _id_6AD135FA4DB6448C, owner);
}

iskillstreakcalloutsplash(_id_1B4ADA49A21B51CA) {
  _id_EF41235A89500AD8 = 0;

  if(issubstr(_id_1B4ADA49A21B51CA, "used_")) {
    _id_475639EA36EA224B = strtok(_id_1B4ADA49A21B51CA, "_");
    _id_A4E8372932B8612C = undefined;

    foreach(_id_E97377032A878881 in _id_475639EA36EA224B) {
      if(_id_E97377032A878881 == "used") {
        continue;
      }
      if(!isDefined(_id_A4E8372932B8612C)) {
        _id_A4E8372932B8612C = _id_E97377032A878881;
        continue;
      }

      _id_A4E8372932B8612C = _id_A4E8372932B8612C + "_" + _id_E97377032A878881;
    }

    if(isDefined(_id_A4E8372932B8612C) && isDefined(level._id_0B23156D776B1D85._id_038F2A11237246AC[_id_A4E8372932B8612C]))
      _id_EF41235A89500AD8 = 1;
  }

  return _id_EF41235A89500AD8;
}

iseventcalloutsplash(_id_1B4ADA49A21B51CA) {
  return issubstr(_id_1B4ADA49A21B51CA, "callout_");
}

getbaseeventcalloutsplash(_id_1B4ADA49A21B51CA) {
  _id_04544740304048F3 = undefined;
  _id_64E9E0E7C5B091AB = strtok(_id_1B4ADA49A21B51CA, "_");

  foreach(_id_E97377032A878881 in _id_64E9E0E7C5B091AB) {
    if(_id_E97377032A878881 == "callout") {
      continue;
    }
    if(!isDefined(_id_04544740304048F3)) {
      _id_04544740304048F3 = _id_E97377032A878881;
      continue;
    }

    _id_04544740304048F3 = _id_04544740304048F3 + "_" + _id_E97377032A878881;
  }

  return _id_04544740304048F3;
}

canshowsplash(_id_1B4ADA49A21B51CA) {
  if(istrue(level._id_E028CA551ECC95A3) || scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    return 0;

  if(!isDefined(_id_1B4ADA49A21B51CA) || _id_1B4ADA49A21B51CA == "")
    return 0;

  _id_2B6EDAC9AF839814 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(iseventcalloutsplash(_id_1B4ADA49A21B51CA)) {
      _id_04544740304048F3 = getbaseeventcalloutsplash(_id_1B4ADA49A21B51CA);

      switch (_id_04544740304048F3) {
        case "3xkill":
        case "9xkill":
        case "7xkill":
        case "8xkill":
        case "firstblood":
        case "4xkill":
        case "5xkill":
        case "6xkill":
          _id_2B6EDAC9AF839814 = 0;
          break;
      }
    }
  } else {
    switch (scripts\mp\utility\game::getgametype()) {
      case "brtdm_mgl":
      case "brtdm":
      case "conflict":
      case "risk":
      case "arm":
        if(iskillstreakcalloutsplash(_id_1B4ADA49A21B51CA))
          _id_2B6EDAC9AF839814 = 0;
        else if(iseventcalloutsplash(_id_1B4ADA49A21B51CA)) {
          _id_04544740304048F3 = getbaseeventcalloutsplash(_id_1B4ADA49A21B51CA);

          switch (_id_04544740304048F3) {
            case "3xkill":
            case "9xkill":
            case "7xkill":
            case "8xkill":
            case "firstblood":
            case "4xkill":
            case "5xkill":
            case "6xkill":
              _id_2B6EDAC9AF839814 = 0;
              break;
          }
        }

        break;
    }
  }

  return _id_2B6EDAC9AF839814;
}

showsplashtoall(splashname, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6) {
  foreach(player in level.players)
  player scripts\mp\hud_message::showsplash(splashname, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6);
}

showsplashtoteam(team, splashname, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6) {
  foreach(player in level.teamdata[team]["players"])
  player scripts\mp\hud_message::showsplash(splashname, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6);
}

showsplashtoallexceptteam(team, splashname, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6) {
  foreach(player in level.players) {
    if(isDefined(player) && player.team != team)
      player scripts\mp\hud_message::showsplash(splashname, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6);
  }
}