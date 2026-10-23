/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_entityheadicons.gsc
************************************************/

init() {
  if(isDefined(level.initedentityheadicons)) {
    return;
  }
  level.initedentityheadicons = 1;

  if(level.multiteambased) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = "entity_headicon_" + var_1;
      game[var_2] = _id_0510::mt_getteamheadicon(var_1);
      _precacheshader(game[var_2]);
    }
  } else {
    game["entity_headicon_allies"] = _id_0510::getteamheadicon("allies");
    game["entity_headicon_axis"] = _id_0510::getteamheadicon("axis");
    _precacheshader(game["entity_headicon_allies"]);
    _precacheshader(game["entity_headicon_axis"]);
  }
}

setheadicon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(maps\mp\_utility::isgameparticipant(var_0) && !isPlayer(var_0)) {
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

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!isDefined(var_11)) {
    var_11 = "";
  }

  if(!isPlayer(var_0) && var_0 == "none") {
    foreach(var_15, var_14 in self.entityheadicons) {
      if(isDefined(var_14)) {
        var_14 destroy();
      }

      self.entityheadicons[var_15] = undefined;
    }
  } else {
    if(isPlayer(var_0)) {
      if(isDefined(self.entityheadicons[var_0.guid])) {
        self.entityheadicons[var_0.guid] destroy();
        self.entityheadicons[var_0.guid] = undefined;
      }

      if(var_1 == "") {
        return;
      }
      if(isDefined(self.entityheadicons[var_0.team])) {
        self.entityheadicons[var_0.team] destroy();
        self.entityheadicons[var_0.team] = undefined;
      }

      var_14 = _newclienthudelem(var_0);
      self.entityheadicons[var_0.guid] = var_14;
    } else {
      if(isDefined(self.entityheadicons[var_0])) {
        self.entityheadicons[var_0] destroy();
        self.entityheadicons[var_0] = undefined;
      }

      if(var_1 == "") {
        return;
      }
      foreach(var_15, var_17 in self.entityheadicons) {
        if(var_15 == "axis" || var_15 == "allies") {
          continue;
        }
        var_18 = maps\mp\_utility::getplayerforguid(var_15);

        if(var_18.team == var_0) {
          self.entityheadicons[var_15] destroy();
          self.entityheadicons[var_15] = undefined;
        }
      }

      if(isDefined(var_12)) {
        var_14 = _func_19D(var_0, var_12);
      } else {
        var_14 = _newteamhudelem(var_0);
      }

      self.entityheadicons[var_0] = var_14;
    }

    if(!isDefined(var_3) || !isDefined(var_4)) {
      var_3 = 10;
      var_4 = 10;
    }

    var_14.archived = var_5;
    var_14.alpha = 0.85;
    var_14 setshader(var_1, var_3, var_4);
    var_14 setwaypoint(var_7, var_8, var_9, var_10);

    if(var_11 == "") {
      var_14.x = self.origin[0] + var_2[0];
      var_14.y = self.origin[1] + var_2[1];
      var_14._id_01D9 = self.origin[2] + var_2[2];
      var_14 thread keeppositioned(self, var_2, var_6);
    } else {
      var_14.x = var_2[0];
      var_14.y = var_2[1];
      var_14._id_01D9 = var_2[2];
      var_14 settargetEnt(self, var_11);
    }

    thread destroyiconsondeath();

    if(isPlayer(var_0)) {
      var_14 thread destroyonownerdisconnect(var_0);
    }

    if(isPlayer(self)) {
      var_14 thread destroyonownerdisconnect(self);
    }
  }
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

  foreach(var_2, var_1 in self.entityheadicons) {
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
  var_3 = var_0.origin;

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    if(var_3 != var_0.origin) {
      var_3 = var_0.origin;
      self.x = var_3[0] + var_1[0];
      self.y = var_3[1] + var_1[1];
      self._id_01D9 = var_3[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait(var_2);
  }
}

setteamheadicon(var_0, var_1, var_2, var_3) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = "";
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  if(isDefined(var_3) && var_3 == 0) {
    var_4 = undefined;
  }

  var_5 = var_0;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1)) {
    var_5 = maps\mp\_utility::getotherteam(var_0);
  }

  var_6 = game["entity_headicon_" + var_5];
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

  var_7 = _newteamhudelem(var_0);
  var_7.archived = 1;
  var_7.alpha = 0.8;
  var_7 setshader(var_6, 10, 10);
  var_7 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_7;

  if(!isDefined(var_3)) {
    if(var_2 == "") {
      var_7.x = self.origin[0] + self.entityheadiconoffset[0];
      var_7.y = self.origin[1] + self.entityheadiconoffset[1];
      var_7._id_01D9 = self.origin[2] + self.entityheadiconoffset[2];
      thread keepiconpositioned();
    } else {
      var_7.x = self.entityheadiconoffset[0];
      var_7.y = self.entityheadiconoffset[1];
      var_7._id_01D9 = self.entityheadiconoffset[2];
      var_7 settargetEnt(self, var_2);
    }
  } else {
    var_8 = anglestoup(self.angles);
    var_9 = self.origin + var_8 * 28;

    if(var_2 == "") {
      var_7.x = var_9[0];
      var_7.y = var_9[1];
      var_7._id_01D9 = var_9[2];
      thread keepiconpositioned(var_3);
    } else {
      var_7.x = var_9[0];
      var_7.y = var_9[1];
      var_7._id_01D9 = var_9[2];
      var_7 settargetEnt(self, var_2);
    }
  }

  thread destroyheadiconsondeath();
}

setplayerheadicon(var_0, var_1, var_2) {
  if(level.teambased) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = "";
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

  var_3 = var_0.team;
  self.entityheadiconteam = var_3;

  if(isDefined(var_1)) {
    self.entityheadiconoffset = var_1;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  if(var_3 == "spectator") {
    var_4 = game["entity_headicon_allies"];
  } else {
    var_4 = game["entity_headicon_" + var_3];
  }

  var_5 = _newclienthudelem(var_0);
  var_5.archived = 1;
  var_5.alpha = 0.8;
  var_5 setshader(var_4, 10, 10);
  var_5 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_5;

  if(var_2 == "") {
    var_5.x = self.origin[0] + self.entityheadiconoffset[0];
    var_5.y = self.origin[1] + self.entityheadiconoffset[1];
    var_5._id_01D9 = self.origin[2] + self.entityheadiconoffset[2];
    thread keepiconpositioned();
  } else {
    var_5.x = self.entityheadiconoffset[0];
    var_5.y = self.entityheadiconoffset[1];
    var_5._id_01D9 = self.entityheadiconoffset[2];
    var_5 settargetEnt(self, var_2);
  }

  thread destroyheadiconsondeath();
}

keepiconpositioned(var_0) {
  self endon("kill_entity_headicon_thread");
  self endon("death");
  var_1 = self.origin;

  for(;;) {
    if(var_1 != self.origin) {
      updateheadiconorigin(var_0);
      var_1 = self.origin;
    }

    waitframe();
  }
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateheadiconorigin(var_0) {
  if(!isDefined(var_0)) {
    self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
    self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
    self.entityheadicon._id_01D9 = self.origin[2] + self.entityheadiconoffset[2];
  } else {
    var_1 = anglestoup(self.angles);
    var_2 = self.origin + var_1 * 28;
    self.entityheadicon.x = var_2[0];
    self.entityheadicon.y = var_2[1];
    self.entityheadicon._id_01D9 = var_2[2];
  }
}