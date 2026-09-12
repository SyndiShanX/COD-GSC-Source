/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_entityheadicons.gsc
*********************************************/

init() {
  if(isDefined(level.var_52B3)) {
    return;
  }

  level.var_52B3 = 1;
  if(level.multiteambased) {
    foreach(var_01 in level.teamnamelist) {
      var_02 = "entity_headicon_" + var_01;
      game[var_02] = maps\mp\gametypes\_teams::func_650A(var_01);
      precacheshader(game[var_02]);
    }

    return;
  }

  game["entity_headicon_allies"] = maps\mp\gametypes\_teams::func_46D1("allies");
  game["entity_headicon_axis"] = maps\mp\gametypes\_teams::func_46D1("axis");
  precacheshader(game["entity_headicon_allies"]);
  precacheshader(game["entity_headicon_axis"]);
}

func_869E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  if(maps\mp\_utility::func_56FF(param_00) && !isPlayer(param_00)) {
    return;
  }

  if(!isDefined(self.var_37D6)) {
    self.var_37D6 = [];
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

  if(!isDefined(param_0B)) {
    param_0B = "";
  }

  if(!isPlayer(param_00) && param_00 == "none") {
    foreach(var_0F, var_0E in self.var_37D6) {
      if(isDefined(var_0E)) {
        var_0E destroy();
      }

      self.var_37D6[var_0F] = undefined;
    }

    return;
  }

  if(isPlayer(param_03)) {
    if(isDefined(self.var_37D6[param_03.guid])) {
      self.var_37D6[param_03.guid] destroy();
      self.var_37D6[param_03.guid] = undefined;
    }

    if(param_04 == "") {
      return;
    }

    if(isDefined(self.var_37D6[param_03.team])) {
      self.var_37D6[param_03.team] destroy();
      self.var_37D6[param_03.team] = undefined;
    }

    var_0E = newclienthudelem(param_03);
    self.var_37D6[param_02.guid] = var_0F;
  } else {
    if(isDefined(self.var_37D6[param_03])) {
      self.var_37D6[param_03] destroy();
      self.var_37D6[param_03] = undefined;
    }

    if(param_04 == "") {
      return;
    }

    foreach(var_10 in self.var_37D6) {
      if(var_12 == "axis" || var_12 == "allies") {
        continue;
      }

      var_11 = maps\mp\_utility::func_4621(var_12);
      if(var_11.team == param_01) {
        self.var_37D6[var_12] destroy();
        self.var_37D6[var_12] = undefined;
      }
    }

    if(isDefined(var_0D)) {
      var_0E = newteamclienthiddenhudelem(param_01, var_0D);
    } else {
      var_0E = newteamhudelem(param_01);
    }

    self.var_37D6[param_01] = var_0E;
  }

  if(!isDefined(param_04) || !isDefined(param_05)) {
    param_04 = 10;
    param_05 = 10;
  }

  var_0E.archived = param_06;
  var_0E.alpha = 0.85;
  var_0E setshader(param_02, param_04, param_05);
  var_0E setwaypoint(param_08, param_09, param_0A, param_0B);
  if(param_0C == "") {
    var_0E.x = self.origin[0] + param_03[0];
    var_0E.y = self.origin[1] + param_03[1];
    var_0E.z = self.origin[2] + param_03[2];
    var_0E thread func_59DC(self, param_03, param_07);
  } else {
    var_0E.x = param_03[0];
    var_0E.y = param_03[1];
    var_0E.z = param_03[2];
    var_0E settargetEnt(self, param_0C);
  }

  thread func_2DCF();
  if(isPlayer(param_01)) {
    var_0E thread func_2DD5(param_01);
  }

  if(isPlayer(self)) {
    var_0E thread func_2DD5(self);
  }

  return var_0E;
}

func_2DD5(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  self destroy();
}

func_2DCF() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");
  foreach(var_01 in self.var_37D6) {
    if(!isDefined(var_01)) {
      continue;
    }

    var_01 destroy();
  }
}

func_59DC(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  var_03 = param_00.origin;
  for(;;) {
    if(!isDefined(param_00)) {
      return;
    }

    if(var_03 != param_00.origin) {
      var_03 = param_00.origin;
      self.x = var_03[0] + param_01[0];
      self.y = var_03[1] + param_01[1];
      self.z = var_03[2] + param_01[2];
    }

    if(param_02 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(param_02);
      self.alpha = 0;
    }

    wait(param_02);
  }
}

func_873C(param_00, param_01, param_02, param_03) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = "";
  }

  if(!isDefined(self.var_37D7)) {
    self.var_37D7 = "none";
    self.var_37D3 = undefined;
  }

  if(isDefined(param_03) && param_03 == 0) {
    var_04 = undefined;
  }

  var_05 = param_00;
  if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    var_05 = maps\mp\_utility::func_45DE(param_00);
  }

  var_06 = game["entity_headicon_" + var_05];
  self.var_37D7 = param_00;
  if(isDefined(param_01)) {
    self.var_37D4 = param_01;
  } else {
    self.var_37D4 = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");
  if(param_00 == "none") {
    if(isDefined(self.var_37D3)) {
      self.var_37D3 destroy();
    }

    return;
  }

  var_07 = newteamhudelem(param_00);
  var_07.archived = 1;
  var_07.alpha = 0.8;
  var_07 setshader(var_06, 10, 10);
  var_07 setwaypoint(0, 0, 0, 1);
  self.var_37D3 = var_07;
  if(!isDefined(param_03)) {
    if(param_02 == "") {
      var_07.x = self.origin[0] + self.var_37D4[0];
      var_07.y = self.origin[1] + self.var_37D4[1];
      var_07.z = self.origin[2] + self.var_37D4[2];
      thread func_59DB();
    } else {
      var_07.x = self.var_37D4[0];
      var_07.y = self.var_37D4[1];
      var_07.z = self.var_37D4[2];
      var_07 settargetEnt(self, param_02);
    }
  } else {
    var_08 = anglestoup(self.angles);
    var_09 = self.origin + var_08 * 28;
    if(param_02 == "") {
      var_07.x = var_09[0];
      var_07.y = var_09[1];
      var_07.z = var_09[2];
      thread func_59DB(param_03);
    } else {
      var_07.x = var_09[0];
      var_07.y = var_09[1];
      var_07.z = var_09[2];
      var_07 settargetEnt(self, param_02);
    }
  }

  thread func_2DCE();
}

func_86FC(param_00, param_01, param_02) {
  if(level.teambased) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = "";
  }

  if(!isDefined(self.var_37D7)) {
    self.var_37D7 = "none";
    self.var_37D3 = undefined;
  }

  self notify("kill_entity_headicon_thread");
  if(!isDefined(param_00)) {
    if(isDefined(self.var_37D3)) {
      self.var_37D3 destroy();
    }

    return;
  }

  var_03 = param_00.team;
  self.var_37D7 = var_03;
  if(isDefined(param_01)) {
    self.var_37D4 = param_01;
  } else {
    self.var_37D4 = (0, 0, 0);
  }

  if(var_03 == "spectator") {
    var_04 = game["entity_headicon_allies"];
  } else {
    var_04 = game["entity_headicon_" + var_04];
  }

  var_05 = newclienthudelem(param_00);
  var_05.archived = 1;
  var_05.alpha = 0.8;
  var_05 setshader(var_04, 10, 10);
  var_05 setwaypoint(0, 0, 0, 1);
  self.var_37D3 = var_05;
  if(param_02 == "") {
    var_05.x = self.origin[0] + self.var_37D4[0];
    var_05.y = self.origin[1] + self.var_37D4[1];
    var_05.z = self.origin[2] + self.var_37D4[2];
    thread func_59DB();
  } else {
    var_05.x = self.var_37D4[0];
    var_05.y = self.var_37D4[1];
    var_05.z = self.var_37D4[2];
    var_05 settargetEnt(self, param_02);
  }

  thread func_2DCE();
}

func_59DB(param_00) {
  self endon("kill_entity_headicon_thread");
  self endon("death");
  var_01 = self.origin;
  for(;;) {
    if(var_01 != self.origin) {
      func_A122(param_00);
      var_01 = self.origin;
    }

    wait 0.05;
  }
}

func_2DCE() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");
  if(!isDefined(self.var_37D3)) {
    return;
  }

  self.var_37D3 destroy();
}

func_A122(param_00) {
  if(!isDefined(param_00)) {
    self.var_37D3.x = self.origin[0] + self.var_37D4[0];
    self.var_37D3.y = self.origin[1] + self.var_37D4[1];
    self.var_37D3.z = self.origin[2] + self.var_37D4[2];
    return;
  }

  var_01 = anglestoup(self.angles);
  var_02 = self.origin + var_01 * 28;
  self.var_37D3.x = var_02[0];
  self.var_37D3.y = var_02[1];
  self.var_37D3.z = var_02[2];
}