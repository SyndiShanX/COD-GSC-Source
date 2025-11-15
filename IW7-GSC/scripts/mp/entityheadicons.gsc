/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\entityheadicons.gsc
******************************************/

init() {
  if(isDefined(level.var_9801)) {
    return;
  }

  level.var_9801 = 1;
  if(level.multiteambased) {
    foreach(var_01 in level.teamnamelist) {
      var_02 = "entity_headicon_" + var_01;
      game[var_02] = scripts\mp\teams::func_BD71(var_01);
      precacheshader(game[var_02]);
    }

    return;
  }

  game["entity_headicon_allies"] = scripts\mp\teams::_meth_81B0("allies");
  game["entity_headicon_axis"] = scripts\mp\teams::_meth_81B0("axis");
  precacheshader(game["entity_headicon_allies"]);
  precacheshader(game["entity_headicon_axis"]);
}

setheadicon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(scripts\mp\utility::isgameparticipant(param_00) && !isplayer(param_00)) {
    return;
  }

  if(!isDefined(self.entityheadicons)) {
    self.entityheadicons = [];
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  if(!isDefined(param_06)) {
    param_06 = 0.05;
  }

  if(!isDefined(param_07)) {
    param_07 = 1;
  }

  if(!isDefined(param_08)) {
    param_08 = 1;
  }

  if(!isDefined(param_09)) {
    param_09 = 0;
  }

  if(!isDefined(param_0A)) {
    param_0A = 1;
  }

  if(!isplayer(param_00) && param_00 == "none") {
    foreach(var_0D, var_0C in self.entityheadicons) {
      if(isDefined(var_0C)) {
        var_0C destroy();
      }

      self.entityheadicons[var_0D] = undefined;
    }

    return;
  }

  if(isplayer(param_03)) {
    if(isDefined(self.entityheadicons[param_03.guid])) {
      self.entityheadicons[param_03.guid] destroy();
      self.entityheadicons[param_03.guid] = undefined;
    }

    if(param_04 == "") {
      return;
    }

    if(isDefined(param_03.team)) {
      if(isDefined(self.entityheadicons[param_03.team])) {
        self.entityheadicons[param_03.team] destroy();
        self.entityheadicons[param_03.team] = undefined;
      }
    }

    var_0C = newclienthudelem(param_03);
    self.entityheadicons[param_02.guid] = var_0D;
  } else {
    if(isDefined(self.entityheadicons[param_03])) {
      self.entityheadicons[param_03] destroy();
      self.entityheadicons[param_03] = undefined;
    }

    if(param_04 == "") {
      return;
    }

    foreach(var_0E in self.entityheadicons) {
      if(var_10 == "axis" || var_10 == "allies") {
        continue;
      }

      var_0F = scripts\mp\utility::getplayerforguid(var_10);
      if(var_0F.team == param_01) {
        self.entityheadicons[var_10] destroy();
        self.entityheadicons[var_10] = undefined;
      }
    }

    var_0C = newteamhudelem(param_01);
    self.entityheadicons[param_01] = var_0C;
  }

  if(!isDefined(param_04) || !isDefined(param_05)) {
    param_04 = 10;
    param_05 = 10;
  }

  var_0C.archived = param_06;
  var_0C.x = self.origin[0] + param_03[0];
  var_0C.y = self.origin[1] + param_03[1];
  var_0C.var_3A6 = self.origin[2] + param_03[2];
  var_0C.alpha = 0.85;
  var_0C setshader(param_02, param_04, param_05);
  var_0C setwaypoint(param_08, param_09, param_0A, var_0B);
  var_0C thread keeppositioned(self, param_03, param_07);
  thread destroyiconsondeath();
  if(isplayer(param_01)) {
    var_0C thread destroyonownerdisconnect(param_01);
  }

  if(isplayer(self)) {
    var_0C thread destroyonownerdisconnect(self);
  }

  return var_0C;
}

destroyonownerdisconnect(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  self destroy();
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");
  if(!isDefined(self.entityheadicons)) {
    return;
  }

  foreach(var_01 in self.entityheadicons) {
    if(!isDefined(var_01)) {
      continue;
    }

    var_01 destroy();
  }
}

keeppositioned(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  var_03 = isDefined(param_00.classname) && !isownercarepakage(param_00);
  if(var_03) {
    self linkwaypointtotargetwithoffset(param_00, param_01);
  }

  for(;;) {
    if(!isDefined(param_00)) {
      return;
    }

    if(!var_03) {
      var_04 = param_00.origin;
      self.x = var_04[0] + param_01[0];
      self.y = var_04[1] + param_01[1];
      self.var_3A6 = var_04[2] + param_01[2];
    }

    if(param_02 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(param_02);
      self.alpha = 0;
    }

    wait(param_02);
  }
}

isownercarepakage(param_00) {
  return isDefined(param_00.var_336) && param_00.var_336 == "care_package";
}

setheadicon_factionimage(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("disconnect");
  wait(param_02);
  if(level.teambased) {
    setteamheadicon(param_00.team, param_01);
    return;
  }

  setplayerheadicon(param_00, param_01);
}

setteamheadicon(param_00, param_01) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var_02 = game["entity_headicon_" + param_00];
  self.entityheadiconteam = param_00;
  if(isDefined(param_01)) {
    self.entityheadiconoffset = param_01;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");
  if(param_00 == "none") {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_03 = newteamhudelem(param_00);
  var_03.archived = 1;
  var_03.x = self.origin[0] + self.entityheadiconoffset[0];
  var_03.y = self.origin[1] + self.entityheadiconoffset[1];
  var_03.var_3A6 = self.origin[2] + self.entityheadiconoffset[2];
  var_03.origin = (var_03.x, var_03.y, var_03.var_3A6);
  var_03.alpha = 1;
  var_03 setshader(var_02, 10, 10);
  var_03 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_03;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

setplayerheadicon(param_00, param_01) {
  if(level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");
  if(!isDefined(param_00)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_02 = param_00.team;
  self.entityheadiconteam = var_02;
  if(isDefined(param_01)) {
    self.entityheadiconoffset = param_01;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  var_03 = game["entity_headicon_" + var_02];
  var_04 = newclienthudelem(param_00);
  var_04.archived = 1;
  var_04.x = self.origin[0] + self.entityheadiconoffset[0];
  var_04.y = self.origin[1] + self.entityheadiconoffset[1];
  var_04.var_3A6 = self.origin[2] + self.entityheadiconoffset[2];
  var_04.alpha = 0.8;
  var_04 setshader(var_03, 10, 10);
  var_04 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_04;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

keepiconpositioned() {
  self.entityheadicon linkwaypointtotargetwithoffset(self, self.entityheadiconoffset);
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");
  if(!isDefined(self.entityheadicon)) {
    return;
  }

  self.entityheadicon destroy();
}