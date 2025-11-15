/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\squadmanager.gsc
*****************************************/

func_9763() {
  if(isDefined(level.var_10AE6) && level.var_10AE6) {
    return;
  }

  anim.var_10AE0 = [];
  anim.var_10AE1 = [];
  anim.var_10AF9 = [];
  anim.var_10AE5 = [];
  anim.var_10AF2 = 0;
  anim.var_10AE6 = 1;
}

func_4A1B(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_10AEE = param_00;
  level.var_10AF9[param_00] = var_02;
  var_02.team = getplayerangles(param_01);
  var_02.var_101E8 = 0;
  var_02.origin = undefined;
  var_02.missionfailed = undefined;
  var_02.isnodeoccupied = undefined;
  var_02.var_9E40 = 0;
  var_02.var_B65C = 0;
  var_02.var_B661 = [];
  var_02.var_C35C = [];
  var_02.var_C35A = 0;
  var_02.var_10AE9 = [];
  var_02.var_B659 = [];
  var_02.var_B65A = [];
  var_02.var_B65F = [];
  var_02.var_B660 = [];
  var_02.var_10AFD = [];
  var_02.var_10AFE = [];
  var_02.var_10AE4 = level.var_10AE5.size;
  level.var_10AE5[level.var_10AE5.size] = var_02;
  var_02 func_12F25();
  level notify("squad created " + param_00);
  anim notify("squad created " + param_00);
  for(var_03 = 0; var_03 < level.var_10AE0.size; var_03++) {
    var_04 = level.var_10AE0[var_03];
    var_02 thread[[var_04]]();
  }

  for(var_03 = 0; var_03 < level.var_10AE5.size; var_03++) {
    level.var_10AE5[var_03] func_12F25();
  }

  var_02 thread func_10AFC();
  var_02 thread func_C35D();
  var_02 thread func_12ECE();
  return var_02;
}

func_51D2(param_00) {
  if(param_00 == "axis" || param_00 == "team3" || param_00 == "allies" || param_00 == "jackal_allies" || param_00 == "jackal_axis") {
    return;
  }

  var_01 = level.var_10AF9[param_00].var_10AE4;
  var_02 = level.var_10AF9[param_00];
  var_02 notify("squad_deleting");
  while(var_02.var_B661.size) {
    var_02.var_B661[0] func_185C(var_02.var_B661[0].team);
  }

  level.var_10AE5[var_01] = level.var_10AE5[level.var_10AE5.size - 1];
  level.var_10AE5[var_01].var_10AE4 = var_01;
  level.var_10AE5[level.var_10AE5.size - 1] = undefined;
  level.var_10AF9[param_00] = undefined;
  anim notify("squad deleted " + param_00);
  for(var_03 = 0; var_03 < level.var_10AE5.size; var_03++) {
    level.var_10AE5[var_03] func_12F25();
  }
}

func_1811(param_00) {
  if(!isDefined(param_00)) {
    if(isDefined(self.var_EEC4)) {
      param_00 = self.var_EEC4;
    } else {
      param_00 = self.team;
    }
  }

  if(!isDefined(level.var_10AF9[param_00])) {
    anim func_4A1B(param_00, self);
  }

  var_01 = level.var_10AF9[param_00];
  var_02 = 0;
  if(isDefined(var_01.var_B661)) {
    foreach(var_04 in var_01.var_B661) {
      if(var_04 != level.player) {
        continue;
      } else {
        var_02 = 1;
        break;
      }
    }

    if(!var_02) {
      var_01.var_B661[var_01.var_B661.size] = self;
    }
  }

  self.var_10AC8 = var_01;
}

func_D362() {
  var_00 = getEntArray("player", "classname")[0];
  lib_0E4E::func_D313();
  if(scripts\engine\utility::player_is_in_jackal()) {
    anim.player = level.var_D127;
    if(!isDefined(level.player.team)) {
      level.player.team = "allies";
    }

    level.var_68AD["threat"]["self"] = 11000;
    level.var_68AD["threat"]["squad"] = 7000;
    level.var_29BE = squared(9999999);
    level.var_29BD = squared(9999999);
    anim.var_115EE = 300000;
    anim.var_6BB2 = 9999999;
    anim.var_6BB8 = 2;
    anim.var_6BB7 = 5;
    anim.var_6BB6 = 0.5;
    anim.var_6BB5 = 3;
    level.player func_1811("jackal_allies");
    for(var_01 = 0; var_01 < level.var_10AE5.size; var_01++) {
      level.var_10AE5[var_01].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_01].var_B661);
      level.var_10AE5[var_01] func_12F25();
    }

    lib_0E4E::func_96F1();
    while(scripts\engine\utility::player_is_in_jackal()) {
      wait(0.05);
    }
  } else {
    anim.player = var_01;
    if(!isDefined(level.player.team)) {
      level.player.team = "allies";
    }

    lib_0E4E::func_D313();
    level.var_68AD["threat"]["self"] = 9000;
    level.var_68AD["threat"]["squad"] = 5000;
    level.var_29BE = squared(5000);
    level.var_29BD = squared(3000);
    anim.var_115EE = 120000;
    anim.var_6BB2 = 620;
    anim.var_6BB8 = 12;
    anim.var_6BB7 = 24;
    anim.var_6BB6 = 2;
    anim.var_6BB5 = 5;
    level.player func_1811("allies");
    for(var_01 = 0; var_01 < level.var_10AE5.size; var_01++) {
      level.var_10AE5[var_01].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_01].var_B661);
      level.var_10AE5[var_01] func_12F25();
    }

    lib_0E4E::func_96F1();
    while(!scripts\engine\utility::player_is_in_jackal()) {
      wait(0.05);
    }
  }

  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      var_02 = [];
      foreach(var_04 in level.var_10AF9["allies"].var_B661) {
        if(var_04 != level.player) {
          var_02[var_02.size] = var_04;
        }
      }

      level.var_10AF9["allies"].var_B661 = var_02;
      anim.player = level.var_D127;
      if(!isDefined(level.player.team)) {
        level.player.team = "allies";
      }

      lib_0E4E::func_D313();
      level.var_68AD["threat"]["self"] = 11000;
      level.var_68AD["threat"]["squad"] = 7000;
      level.var_29BE = squared(9999999);
      level.var_29BD = squared(9999999);
      anim.var_115EE = 300000;
      anim.var_6BB2 = 9999999;
      anim.var_6BB8 = 2;
      anim.var_6BB7 = 5;
      anim.var_6BB6 = 0.5;
      anim.var_6BB5 = 3;
      level.player func_1811("jackal_allies");
      for(var_01 = 0; var_01 < level.var_10AE5.size; var_01++) {
        level.var_10AE5[var_01].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_01].var_B661);
        level.var_10AE5[var_01] func_12F25();
      }

      lib_0E4E::func_96F1();
      while(scripts\engine\utility::player_is_in_jackal()) {
        wait(0.05);
      }

      continue;
    }

    var_02 = [];
    foreach(var_04 in level.var_10AF9["allies"].var_B661) {
      if(!isDefined(level.var_D127) || isDefined(level.var_D127) && var_04 != level.var_D127) {
        var_02[var_02.size] = var_04;
      }
    }

    level.var_10AF9["allies"].var_B661 = var_02;
    anim.player = var_00;
    if(!isDefined(level.player.team)) {
      level.player.team = "allies";
    }

    lib_0E4E::func_D313();
    level.var_68AD["threat"]["self"] = 9000;
    level.var_68AD["threat"]["squad"] = 5000;
    level.var_29BE = squared(5000);
    level.var_29BD = squared(3000);
    anim.var_115EE = 120000;
    anim.var_6BB2 = 620;
    anim.var_6BB8 = 12;
    anim.var_6BB7 = 24;
    anim.var_6BB6 = 2;
    anim.var_6BB5 = 5;
    level.player func_1811("allies");
    for(var_01 = 0; var_01 < level.var_10AE5.size; var_01++) {
      level.var_10AE5[var_01].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_01].var_B661);
      level.var_10AE5[var_01] func_12F25();
    }

    lib_0E4E::func_96F1();
    while(!scripts\engine\utility::player_is_in_jackal()) {
      wait(0.05);
    }
  }
}

getplayerangles(param_00) {
  var_01 = "allies";
  if(isDefined(level.template_script) && level.template_script == "phparade") {
    param_00.team = "allies";
  }

  if(param_00.team == "axis" || param_00.team == "neutral" || param_00.team == "team3") {
    var_01 = param_00.team;
  }

  return var_01;
}

func_185C(param_00) {
  if(!isDefined(param_00)) {
    if(isDefined(self.var_EEC4)) {
      param_00 = self.var_EEC4;
    } else {
      param_00 = self.team;
    }

    if(isDefined(self.var_29B8) && self.var_29B8) {
      param_00 = "jackal_" + self.script_team;
    }
  }

  if(!isDefined(level.var_10AF9[param_00])) {
    anim func_4A1B(param_00, self);
  }

  var_01 = level.var_10AF9[param_00];
  if(isDefined(self.var_10AC8)) {
    if(self.var_10AC8 == var_01) {
      return;
    } else {
      func_E11A();
    }
  }

  self.lastenemysighttime = 0;
  self.var_440E = 0;
  self.starttime = gettime();
  self.var_10AC8 = var_01;
  self.var_10AED = var_01.var_B661.size;
  var_01.var_B661[self.var_10AED] = self;
  var_01.var_B65C = var_01.var_B661.size;
  if(isDefined(level.var_AE64)) {
    if(self.team == "allies" && scripts\anim\battlechatter::func_9EC2()) {
      func_1804();
    }
  }

  foreach(var_03 in self.var_10AC8.var_B659) {
    self thread[[var_03]](self.var_10AC8.var_10AEE);
  }

  thread func_B65D();
}

func_E11A() {
  var_00 = self.var_10AC8;
  var_01 = -1;
  if(isDefined(self)) {
    var_01 = self.var_10AED;
  } else {
    for(var_02 = 0; var_02 < var_00.var_B661.size; var_02++) {
      if(var_00.var_B661[var_02] == self) {
        var_01 = var_02;
      }
    }
  }

  if(var_01 != var_00.var_B661.size - 1) {
    var_03 = var_00.var_B661[var_00.var_B661.size - 1];
    var_00.var_B661[var_01] = var_03;
    if(isDefined(var_03)) {
      var_03.var_10AED = var_01;
    }
  }

  var_00.var_B661[var_00.var_B661.size - 1] = undefined;
  var_00.var_B65C = var_00.var_B661.size;
  if(isDefined(self.var_10AF0)) {
    func_E142();
  }

  foreach(var_05 in self.var_10AC8.var_B65F) {
    self thread[[var_05]](var_00.var_10AEE);
  }

  if(var_00.var_B65C == 0) {
    func_51D2(var_00.var_10AEE);
  }

  if(isDefined(self)) {
    self.var_10AC8 = undefined;
    self.var_10AED = undefined;
    self notify("removed from squad");
  }
}

func_1804() {
  var_00 = self.var_10AC8;
  if(isDefined(self.var_10AF0)) {
    return;
  }

  self.var_10AF0 = var_00.var_C35C.size;
  var_00.var_C35C[self.var_10AF0] = self;
  var_00.var_C35A = var_00.var_C35C.size;
}

func_E142() {
  var_00 = self.var_10AC8;
  var_01 = -1;
  if(isDefined(self)) {
    var_01 = self.var_10AF0;
  } else {
    for(var_02 = 0; var_02 < var_00.var_C35C.size; var_02++) {
      if(var_00.var_C35C[var_02] == self) {
        var_01 = var_02;
      }
    }
  }

  if(var_01 != var_00.var_C35C.size - 1) {
    var_03 = var_00.var_C35C[var_00.var_C35C.size - 1];
    var_00.var_C35C[var_01] = var_03;
    if(isDefined(var_03)) {
      var_03.var_10AF0 = var_01;
    }
  }

  var_00.var_C35C[var_00.var_C35C.size - 1] = undefined;
  var_00.var_C35A = var_00.var_C35C.size;
  if(isDefined(self)) {
    self.var_10AF0 = undefined;
  }
}

func_C35D() {
  if(!isDefined(level.var_AE64)) {
    anim waittill("loadout complete");
  }

  for(var_00 = 0; var_00 < self.var_B661.size; var_00++) {
    if(self.var_B661[var_00] scripts\anim\battlechatter::func_9EC2()) {
      self.var_B661[var_00] func_1804();
    }
  }
}

func_10AFC() {
  anim endon("squad deleted " + self.var_10AEE);
  for(;;) {
    func_12E59();
    wait(0.1);
  }
}

func_B65D() {
  self endon("removed from squad");
  self waittill("death", var_00);
  if(isDefined(self)) {
    self.opcode::OP_EvalLocalVariableRefCached = var_00;
  }

  func_E11A();
}

func_12E77() {
  self.var_9E40 = 0;
  for(var_00 = 0; var_00 < level.var_10AE5.size; var_00++) {
    self.var_10AE9[level.var_10AE5[var_00].var_10AEE].var_9E42 = 0;
  }

  for(var_00 = 0; var_00 < self.var_B661.size; var_00++) {
    if(isDefined(self.var_B661[var_00])) {
      if(isDefined(self.var_B661[var_00].isnodeoccupied) && isDefined(self.var_B661[var_00].isnodeoccupied.var_10AC8) && self.var_B661[var_00].var_440E > 0) {
        self.var_10AE9[self.var_B661[var_00].isnodeoccupied.var_10AC8.var_10AEE].var_9E42 = 1;
      }
    }
  }
}

func_12E59() {
  var_00 = (0, 0, 0);
  var_01 = (0, 0, 0);
  var_02 = 0;
  var_03 = undefined;
  var_04 = 0;
  func_12E77();
  var_05 = !isDefined(self.isnodeoccupied);
  if(!var_05) {
    self.missionfailed = vectornormalize(self.isnodeoccupied.origin - self.origin);
  }

  foreach(var_07 in self.var_B661) {
    if(!isalive(var_07)) {
      continue;
    }

    var_02++;
    var_00 = var_00 + var_07.origin;
    if(var_05) {
      var_01 = var_01 + anglesToForward(var_07.angles);
    }

    if(isDefined(var_07.isnodeoccupied) && isDefined(var_07.isnodeoccupied.var_10AC8)) {
      if(!isDefined(var_03)) {
        var_03 = var_07.isnodeoccupied.var_10AC8;
        continue;
      }

      if(var_07.isnodeoccupied.var_10AC8.var_B65C > var_03.var_B65C) {
        var_03 = var_07.isnodeoccupied.var_10AC8;
      }
    }
  }

  if(var_02) {
    self.origin = var_00 / var_02;
    if(var_05) {
      self.missionfailed = var_01 / var_02;
    }
  } else {
    self.origin = var_00;
    if(var_05) {
      self.missionfailed = var_01;
    }
  }

  self.var_9E40 = var_04;
  self.isnodeoccupied = var_03;
}

func_12F25() {
  for(var_00 = 0; var_00 < level.var_10AE5.size; var_00++) {
    if(!isDefined(self.var_10AE9[level.var_10AE5[var_00].var_10AEE])) {
      self.var_10AE9[level.var_10AE5[var_00].var_10AEE] = spawnStruct();
      self.var_10AE9[level.var_10AE5[var_00].var_10AEE].var_9E42 = 0;
    }

    foreach(var_02 in self.var_10AFD) {
      self thread[[var_02]](level.var_10AE5[var_00].var_10AEE);
    }
  }
}

func_D909(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  if(!isDefined(param_03)) {
    param_03 = (1, 0, 0);
  }

  for(var_04 = 0; var_04 < param_01 * 2; var_04++) {
    if(!isalive(self)) {
      return;
    }

    var_05 = self getshootatpos() + (0, 0, 10) + param_02;
    wait(0.05);
  }
}

func_1B0E(param_00) {
  switch (param_00) {
    case "combat":
    case "stop":
    case "move":
    case "death":
      self.a.state = param_00;
      break;

    case "grenadecower":
    case "pain":
      break;

    case "stalingrad_cover_crouch":
    case "cover_wide_right":
    case "cover_wide_left":
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_prone":
    case "cover_stand":
    case "cover_left":
    case "cover_right":
    case "cover_crouch":
      self.a.state = "cover";
      break;

    case "l33t truckride combat":
    case "aim":
      self.a.state = "combat";
      break;
  }
}

func_12ECE() {
  anim endon("squad deleted " + self.var_10AEE);
  var_00 = 0.05;
  for(;;) {
    foreach(var_02 in self.var_B661) {
      if(!isalive(var_02) || var_02 == level.player) {
        continue;
      }

      var_02 func_1B0F(var_00);
      var_02 func_1B10(var_00);
    }

    wait(var_00);
  }
}

func_1B0F(param_00) {
  if(!isDefined(self.var_440E)) {
    return;
  }

  if(isDefined(self.setignoremegroup)) {
    if(self.var_440E < 0) {
      self.var_440E = param_00;
    } else {
      self.var_440E = self.var_440E + param_00;
    }

    self.lastenemysighttime = gettime();
    return;
  } else if((isDefined(self.var_3136) && self.var_3136) || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.var_440E = self.var_440E + param_00;
    return;
  }

  if(self.var_440E > 0) {
    self.var_440E = 0 - param_00;
    return;
  }

  self.var_440E = self.var_440E - param_00;
}

func_1B10(param_00) {
  if(!isDefined(self.var_112CA)) {
    return;
  }

  if((isDefined(self.var_3136) && self.var_3136) || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    if(self.var_112CA < 0) {
      self.var_112CA = param_00;
    } else {
      self.var_112CA = self.var_112CA + param_00;
    }

    return;
  }

  if(self.var_112CA > 0) {
    self.var_112CA = 0 - param_00;
    return;
  }

  self.var_112CA = self.var_112CA - param_00;
}