/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2726.gsc
***************************************/

init() {
  if(isDefined(level.func_9801)) {
    return;
  }
  level.func_9801 = 1;

  if(level.multiteambased) {
    foreach(var_01 in level.teamnamelist) {
      var_02 = "entity_headicon_" + var_01;
      game[var_02] = ::scripts\mp\teams::func_BD71(var_01);
      precacheshader(game[var_02]);
    }
  } else {
    game["entity_headicon_allies"] = ::scripts\mp\teams::_meth_81B0("allies");
    game["entity_headicon_axis"] = ::scripts\mp\teams::_meth_81B0("axis");
    precacheshader(game["entity_headicon_allies"]);
    precacheshader(game["entity_headicon_axis"]);
  }
}

setheadicon(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(scripts\mp\utility\game::isgameparticipant(var_00) && !isplayer(var_00)) {
    return;
  }
  if(!isDefined(self.entityheadicons)) {
    self.entityheadicons = [];
  }

  if(!isDefined(var_05)) {
    var_05 = 1;
  }

  if(!isDefined(var_06)) {
    var_06 = 0.05;
  }

  if(!isDefined(var_07)) {
    var_07 = 1;
  }

  if(!isDefined(var_08)) {
    var_08 = 1;
  }

  if(!isDefined(var_09)) {
    var_09 = 0;
  }

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!isplayer(var_00) && var_00 == "none") {
    foreach(var_13, var_12 in self.entityheadicons) {
      if(isDefined(var_12)) {
        var_12 destroy();
      }

      self.entityheadicons[var_13] = undefined;
    }
  } else {
    if(isplayer(var_00)) {
      if(isDefined(self.entityheadicons[var_0.guid])) {
        self.entityheadicons[var_0.guid] destroy();
        self.entityheadicons[var_0.guid] = undefined;
      }

      if(var_01 == "") {
        return;
      }
      if(isDefined(var_0.team)) {
        if(isDefined(self.entityheadicons[var_0.team])) {
          self.entityheadicons[var_0.team] destroy();
          self.entityheadicons[var_0.team] = undefined;
        }
      }

      var_12 = newclienthudelem(var_00);
      self.entityheadicons[var_0.guid] = var_12;
    } else {
      if(isDefined(self.entityheadicons[var_00])) {
        self.entityheadicons[var_00] destroy();
        self.entityheadicons[var_00] = undefined;
      }

      if(var_01 == "") {
        return;
      }
      foreach(var_13, var_15 in self.entityheadicons) {
        if(var_13 == "axis" || var_13 == "allies") {
          continue;
        }
        var_16 = scripts\mp\utility\game::getplayerforguid(var_13);

        if(var_16.team == var_00) {
          self.entityheadicons[var_13] destroy();
          self.entityheadicons[var_13] = undefined;
        }
      }

      var_12 = newteamhudelem(var_00);
      self.entityheadicons[var_00] = var_12;
    }

    if(!isDefined(var_03) || !isDefined(var_04)) {
      var_03 = 10;
      var_04 = 10;
    }

    var_12.archived = var_05;
    var_12.x = self.origin[0] + var_2[0];
    var_12.y = self.origin[1] + var_2[1];
    var_12.z = self.origin[2] + var_2[2];
    var_12.alpha = 0.85;
    var_12 setshader(var_01, var_03, var_04);
    var_12 setwaypoint(var_07, var_08, var_09, var_10);
    var_12 thread keeppositioned(self, var_02, var_06);
    thread destroyiconsondeath();

    if(isplayer(var_00)) {
      var_12 thread destroyonownerdisconnect(var_00);
    }

    if(isplayer(self)) {
      var_12 thread destroyonownerdisconnect(self);
    }
  }
}

destroyonownerdisconnect(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self destroy();
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");

  if(!isDefined(self.entityheadicons)) {
    return;
  }
  foreach(var_02, var_01 in self.entityheadicons) {
    if(!isDefined(var_01)) {
      continue;
    }
    var_01 destroy();
  }
}

keeppositioned(var_00, var_01, var_02) {
  self endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");
  var_03 = isDefined(var_0.classname) && !isownercarepakage(var_00);

  if(var_03) {
    self gettweakabledvarvalue(var_00, var_01);
  }

  for(;;) {
    if(!isDefined(var_00)) {
      return;
    }
    if(!var_03) {
      var_04 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self.z = var_4[2] + var_1[2];
    }

    if(var_02 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_02);
      self.alpha = 0;
    }

    wait(var_02);
  }
}

isownercarepakage(var_00) {
  return isDefined(var_0.targetname) && var_0.targetname == "care_package";
}

setheadicon_factionimage(var_00, var_01, var_02) {
  self endon("death");
  var_00 endon("disconnect");
  wait(var_02);

  if(level.teambased) {
    setteamheadicon(var_0.team, var_01);
  } else {
    setplayerheadicon(var_00, var_01);
  }
}

setteamheadicon(var_00, var_01) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  var_02 = game["entity_headicon_" + var_00];
  self.entityheadiconteam = var_00;

  if(isDefined(var_01)) {
    self.entityheadiconoffset = var_01;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");

  if(var_00 == "none") {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_03 = newteamhudelem(var_00);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self.entityheadiconoffset[0];
  var_3.y = self.origin[1] + self.entityheadiconoffset[1];
  var_3.z = self.origin[2] + self.entityheadiconoffset[2];
  var_3.origin = (var_3.x, var_3.y, var_3.z);
  var_3.alpha = 1.0;
  var_03 setshader(var_02, 10, 10);
  var_03 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_03;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

setplayerheadicon(var_00, var_01) {
  if(level.teambased) {
    return;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicon = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isDefined(var_00)) {
    if(isDefined(self.entityheadicon)) {
      self.entityheadicon destroy();
    }

    return;
  }

  var_02 = var_0.team;
  self.entityheadiconteam = var_02;

  if(isDefined(var_01)) {
    self.entityheadiconoffset = var_01;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }

  var_03 = game["entity_headicon_" + var_02];
  var_04 = newclienthudelem(var_00);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self.entityheadiconoffset[0];
  var_4.y = self.origin[1] + self.entityheadiconoffset[1];
  var_4.z = self.origin[2] + self.entityheadiconoffset[2];
  var_4.alpha = 0.8;
  var_04 setshader(var_03, 10, 10);
  var_04 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_04;
  thread keepiconpositioned();
  thread destroyheadiconsondeath();
}

keepiconpositioned() {
  self.entityheadicon gettweakabledvarvalue(self, self.entityheadiconoffset);
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}