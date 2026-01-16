/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_entityheadicons.gsc
****************************************/

init() {
  if(isdefined(level.initedentityheadicons)) {
    return;
  }
  level.initedentityheadicons = 1;

  if(level.multiteambased) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = "entity_headicon_" + var_1;
      game[var_2] = maps\mp\gametypes\_teams::mt_getteamheadicon(var_1);
      precacheshader(game[var_2]);
    }
  } else {
    game["entity_headicon_allies"] = maps\mp\gametypes\_teams::getteamheadicon("allies");
    game["entity_headicon_axis"] = maps\mp\gametypes\_teams::getteamheadicon("axis");
    precacheshader(game["entity_headicon_allies"]);
    precacheshader(game["entity_headicon_axis"]);
  }
}

setheadicon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(maps\mp\_utility::isgameparticipant(var_0) && !isplayer(var_0)) {
    return;
  }
  if(!isdefined(self.entityheadicons))
    self.entityheadicons = [];

  if(!isdefined(var_5))
    var_5 = 1;

  if(!isdefined(var_6))
    var_6 = 0.05;

  if(!isdefined(var_7))
    var_7 = 1;

  if(!isdefined(var_8))
    var_8 = 1;

  if(!isdefined(var_9))
    var_9 = 0;

  if(!isdefined(var_10))
    var_10 = 1;

  if(!isdefined(var_11))
    var_11 = "";

  if(!isplayer(var_0) && var_0 == "none") {
    foreach(var_14, var_13 in self.entityheadicons) {
      if(isdefined(var_13))
        var_13 destroy();

      self.entityheadicons[var_14] = undefined;
    }
  } else {
    if(isplayer(var_0)) {
      if(isdefined(self.entityheadicons[var_0.guid])) {
        self.entityheadicons[var_0.guid] destroy();
        self.entityheadicons[var_0.guid] = undefined;
      }

      if(var_1 == "") {
        return;
      }
      if(isdefined(self.entityheadicons[var_0.team])) {
        self.entityheadicons[var_0.team] destroy();
        self.entityheadicons[var_0.team] = undefined;
      }

      var_13 = newclienthudelem(var_0);
      self.entityheadicons[var_0.guid] = var_13;
    } else {
      if(isdefined(self.entityheadicons[var_0])) {
        self.entityheadicons[var_0] destroy();
        self.entityheadicons[var_0] = undefined;
      }

      if(var_1 == "") {
        return;
      }
      foreach(var_14, var_16 in self.entityheadicons) {
        if(var_14 == "axis" || var_14 == "allies") {
          continue;
        }
        var_17 = maps\mp\_utility::getplayerforguid(var_14);

        if(var_17.team == var_0) {
          self.entityheadicons[var_14] destroy();
          self.entityheadicons[var_14] = undefined;
        }
      }

      var_13 = newteamhudelem(var_0);
      self.entityheadicons[var_0] = var_13;
    }

    if(!isdefined(var_3) || !isdefined(var_4)) {
      var_3 = 10;
      var_4 = 10;
    }

    var_13.archived = var_5;
    var_13.alpha = 0.85;
    var_13 setshader(var_1, var_3, var_4);
    var_13 setwaypoint(var_7, var_8, var_9, var_10);

    if(var_11 == "") {
      var_13.x = self.origin[0] + var_2[0];
      var_13.y = self.origin[1] + var_2[1];
      var_13.z = self.origin[2] + var_2[2];
      var_13 thread keeppositioned(self, var_2, var_6);
    } else {
      var_13.x = var_2[0];
      var_13.y = var_2[1];
      var_13.z = var_2[2];
      var_13 settargetent(self, var_11);
    }

    thread destroyiconsondeath();

    if(isplayer(var_0))
      var_13 thread destroyonownerdisconnect(var_0);

    if(isplayer(self))
      var_13 thread destroyonownerdisconnect(self);
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
    if(!isdefined(var_1)) {
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

  for (;;) {
    if(!isdefined(var_0)) {
      return;
    }
    if(var_3 != var_0.origin) {
      var_3 = var_0.origin;
      self.x = var_3[0] + var_1[0];
      self.y = var_3[1] + var_1[1];
      self.z = var_3[2] + var_1[2];
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
  if(!isdefined(var_2))
    var_2 = "";

  if(!isdefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  if(isdefined(var_3) && var_3 == 0)
    var_4 = undefined;

  var_5 = game["entity_headicon_" + var_0];
  self.entityheadiconteam = var_0;

  if(isdefined(var_1))
    self.entityheadiconoffset = var_1;
  else
    self.entityheadiconoffset = (0, 0, 0);

  self notify("kill_entity_headicon_thread");

  if(var_0 == "none") {
    if(isdefined(self.entityheadicon))
      self.entityheadicon destroy();

    return;
  }

  var_6 = newteamhudelem(var_0);
  var_6.archived = 1;
  var_6.alpha = 0.8;
  var_6 setshader(var_5, 10, 10);
  var_6 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_6;

  if(!isdefined(var_3)) {
    if(var_2 == "") {
      var_6.x = self.origin[0] + self.entityheadiconoffset[0];
      var_6.y = self.origin[1] + self.entityheadiconoffset[1];
      var_6.z = self.origin[2] + self.entityheadiconoffset[2];
      thread keepiconpositioned();
    } else {
      var_6.x = self.entityheadiconoffset[0];
      var_6.y = self.entityheadiconoffset[1];
      var_6.z = self.entityheadiconoffset[2];
      var_6 settargetent(self, var_2);
    }
  } else {
    var_7 = anglestoup(self.angles);
    var_8 = self.origin + var_7 * 28;

    if(var_2 == "") {
      var_6.x = var_8[0];
      var_6.y = var_8[1];
      var_6.z = var_8[2];
      thread keepiconpositioned(var_3);
    } else {
      var_6.x = var_8[0];
      var_6.y = var_8[1];
      var_6.z = var_8[2];
      var_6 settargetent(self, var_2);
    }
  }

  thread destroyheadiconsondeath();
}

setplayerheadicon(var_0, var_1, var_2) {
  if(level.teambased) {
    return;
  }
  if(!isdefined(var_2))
    var_2 = "";

  if(!isdefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isdefined(var_0)) {
    if(isdefined(self.entityheadicon))
      self.entityheadicon destroy();

    return;
  }

  var_3 = var_0.team;
  self.entityheadiconteam = var_3;

  if(isdefined(var_1))
    self.entityheadiconoffset = var_1;
  else
    self.entityheadiconoffset = (0, 0, 0);

  var_4 = game["entity_headicon_" + var_3];
  var_5 = newclienthudelem(var_0);
  var_5.archived = 1;
  var_5.alpha = 0.8;
  var_5 setshader(var_4, 10, 10);
  var_5 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_5;

  if(var_2 == "") {
    var_5.x = self.origin[0] + self.entityheadiconoffset[0];
    var_5.y = self.origin[1] + self.entityheadiconoffset[1];
    var_5.z = self.origin[2] + self.entityheadiconoffset[2];
    thread keepiconpositioned();
  } else {
    var_5.x = self.entityheadiconoffset[0];
    var_5.y = self.entityheadiconoffset[1];
    var_5.z = self.entityheadiconoffset[2];
    var_5 settargetent(self, var_2);
  }

  thread destroyheadiconsondeath();
}

keepiconpositioned(var_0) {
  self endon("kill_entity_headicon_thread");
  self endon("death");
  var_1 = self.origin;

  for (;;) {
    if(var_1 != self.origin) {
      updateheadiconorigin(var_0);
      var_1 = self.origin;
    }

    wait 0.05;
  }
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isdefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateheadiconorigin(var_0) {
  if(!isdefined(var_0)) {
    self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
    self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
    self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
  } else {
    var_1 = anglestoup(self.angles);
    var_2 = self.origin + var_1 * 28;
    self.entityheadicon.x = var_2[0];
    self.entityheadicon.y = var_2[1];
    self.entityheadicon.z = var_2[2];
  }
}