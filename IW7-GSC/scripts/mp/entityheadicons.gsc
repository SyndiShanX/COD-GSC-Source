/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\entityheadicons.gsc
*********************************************/

init() {
  if(isDefined(level.var_9801)) {
    return;
  }

  level.var_9801 = 1;
  if(level.multiteambased) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = "entity_headicon_" + var_1;
      game[var_2] = scripts\mp\teams::func_BD71(var_1);
      precacheshader(game[var_2]);
    }

    return;
  }

  game["entity_headicon_allies"] = scripts\mp\teams::_meth_81B0("allies");
  game["entity_headicon_axis"] = scripts\mp\teams::_meth_81B0("axis");
  precacheshader(game["entity_headicon_allies"]);
  precacheshader(game["entity_headicon_axis"]);
}

setheadicon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(scripts\mp\utility::isgameparticipant(var_0) && !isplayer(var_0)) {
    return;
  }

  if(!isDefined(self.entityheadicons)) {
    self.entityheadicons = [];
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.05;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(!isDefined(var_0A)) {
    var_0A = 1;
  }

  if(!isplayer(var_0) && var_0 == "none") {
    foreach(var_0D, var_0C in self.entityheadicons) {
      if(isDefined(var_0C)) {
        var_0C destroy();
      }

      self.entityheadicons[var_0D] = undefined;
    }

    return;
  }

  if(isplayer(var_3)) {
    if(isDefined(self.entityheadicons[var_3.guid])) {
      self.entityheadicons[var_3.guid] destroy();
      self.entityheadicons[var_3.guid] = undefined;
    }

    if(var_4 == "") {
      return;
    }

    if(isDefined(var_3.team)) {
      if(isDefined(self.entityheadicons[var_3.team])) {
        self.entityheadicons[var_3.team] destroy();
        self.entityheadicons[var_3.team] = undefined;
      }
    }

    var_0C = newclienthudelem(var_3);
    self.entityheadicons[var_2.guid] = var_0D;
  } else {
    if(isDefined(self.entityheadicons[var_3])) {
      self.entityheadicons[var_3] destroy();
      self.entityheadicons[var_3] = undefined;
    }

    if(var_4 == "") {
      return;
    }

    foreach(var_0E in self.entityheadicons) {
      if(var_10 == "axis" || var_10 == "allies") {
        continue;
      }

      var_0F = scripts\mp\utility::getplayerforguid(var_10);
      if(var_0F.team == var_1) {
        self.entityheadicons[var_10] destroy();
        self.entityheadicons[var_10] = undefined;
      }
    }

    var_0C = newteamhudelem(var_1);
    self.entityheadicons[var_1] = var_0C;
  }

  if(!isDefined(var_4) || !isDefined(var_5)) {
    var_4 = 10;
    var_5 = 10;
  }

  var_0C.archived = var_6;
  var_0C.x = self.origin[0] + var_3[0];
  var_0C.y = self.origin[1] + var_3[1];
  var_0C.var_3A6 = self.origin[2] + var_3[2];
  var_0C.alpha = 0.85;
  var_0C setshader(var_2, var_4, var_5);
  var_0C setwaypoint(var_8, var_9, var_0A, var_0B);
  var_0C thread keeppositioned(self, var_3, var_7);
  thread destroyiconsondeath();
  if(isplayer(var_1)) {
    var_0C thread destroyonownerdisconnect(var_1);
  }

  if(isplayer(self)) {
    var_0C thread destroyonownerdisconnect(self);
  }

  return var_0C;
}

destroyonownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self destroy();
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");
  if(!isDefined(self.entityheadicons)) {
    return;
  }

  foreach(var_1 in self.entityheadicons) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 destroy();
  }
}

keeppositioned(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_3 = isDefined(var_0.classname) && !isownercarepakage(var_0);
  if(var_3) {
    self linkwaypointtotargetwithoffset(var_0, var_1);
  }

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!var_3) {
      var_4 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self.var_3A6 = var_4[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait(var_2);
  }
}

isownercarepakage(var_0) {
  return isDefined(var_0.var_336) && var_0.var_336 == "care_package";
}

setheadicon_factionimage(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("disconnect");
  wait(var_2);
  if(level.teambased) {
    setteamheadicon(var_0.team, var_1);
    return;
  }

  setplayerheadicon(var_0, var_1);
}

setteamheadicon(var_0, var_1) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var_2 = game["entity_headicon_" + var_0];
  self.entityheadiconteam = var_0;
  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");
  if(var_0 == "none") {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_3 = newteamhudelem(var_0);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self.entityheadiconoffset[0];
  var_3.y = self.origin[1] + self.entityheadiconoffset[1];
  var_3.var_3A6 = self.origin[2] + self.entityheadiconoffset[2];
  var_3.origin = (var_3.x, var_3.y, var_3.var_3A6);
  var_3.alpha = 1;
  var_3 setshader(var_2, 10, 10);
  var_3 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_3;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

setplayerheadicon(var_0, var_1) {
  if(level.teambased) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");
  if(!isDefined(var_0)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_2 = var_0.team;
  self.entityheadiconteam = var_2;
  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  var_3 = game["entity_headicon_" + var_2];
  var_4 = newclienthudelem(var_0);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self.entityheadiconoffset[0];
  var_4.y = self.origin[1] + self.entityheadiconoffset[1];
  var_4.var_3A6 = self.origin[2] + self.entityheadiconoffset[2];
  var_4.alpha = 0.8;
  var_4 setshader(var_3, 10, 10);
  var_4 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_4;
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