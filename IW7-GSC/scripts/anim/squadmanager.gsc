/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\squadmanager.gsc
*********************************************/

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

func_4A1B(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.var_10AEE = var_0;
  level.var_10AF9[var_0] = var_2;
  var_2.team = getplayerangles(var_1);
  var_2.var_101E8 = 0;
  var_2.origin = undefined;
  var_2.missionfailed = undefined;
  var_2.enemy = undefined;
  var_2.var_9E40 = 0;
  var_2.var_B65C = 0;
  var_2.var_B661 = [];
  var_2.var_C35C = [];
  var_2.var_C35A = 0;
  var_2.var_10AE9 = [];
  var_2.var_B659 = [];
  var_2.var_B65A = [];
  var_2.var_B65F = [];
  var_2.var_B660 = [];
  var_2.var_10AFD = [];
  var_2.var_10AFE = [];
  var_2.var_10AE4 = level.var_10AE5.size;
  level.var_10AE5[level.var_10AE5.size] = var_2;
  var_2 func_12F25();
  level notify("squad created " + var_0);
  anim notify("squad created " + var_0);
  for(var_3 = 0; var_3 < level.var_10AE0.size; var_3++) {
    var_4 = level.var_10AE0[var_3];
    var_2 thread[[var_4]]();
  }

  for(var_3 = 0; var_3 < level.var_10AE5.size; var_3++) {
    level.var_10AE5[var_3] func_12F25();
  }

  var_2 thread func_10AFC();
  var_2 thread func_C35D();
  var_2 thread func_12ECE();
  return var_2;
}

func_51D2(var_0) {
  if(var_0 == "axis" || var_0 == "team3" || var_0 == "allies" || var_0 == "jackal_allies" || var_0 == "jackal_axis") {
    return;
  }

  var_1 = level.var_10AF9[var_0].var_10AE4;
  var_2 = level.var_10AF9[var_0];
  var_2 notify("squad_deleting");
  while(var_2.var_B661.size) {
    var_2.var_B661[0] func_185C(var_2.var_B661[0].team);
  }

  level.var_10AE5[var_1] = level.var_10AE5[level.var_10AE5.size - 1];
  level.var_10AE5[var_1].var_10AE4 = var_1;
  level.var_10AE5[level.var_10AE5.size - 1] = undefined;
  level.var_10AF9[var_0] = undefined;
  anim notify("squad deleted " + var_0);
  for(var_3 = 0; var_3 < level.var_10AE5.size; var_3++) {
    level.var_10AE5[var_3] func_12F25();
  }
}

func_1811(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.var_EEC4)) {
      var_0 = self.var_EEC4;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(level.var_10AF9[var_0])) {
    anim func_4A1B(var_0, self);
  }

  var_1 = level.var_10AF9[var_0];
  var_2 = 0;
  if(isDefined(var_1.var_B661)) {
    foreach(var_4 in var_1.var_B661) {
      if(var_4 != level.player) {
        continue;
      } else {
        var_2 = 1;
        break;
      }
    }

    if(!var_2) {
      var_1.var_B661[var_1.var_B661.size] = self;
    }
  }

  self.var_10AC8 = var_1;
}

func_D362() {
  var_0 = getEntArray("player", "classname")[0];
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
    for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
      level.var_10AE5[var_1].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_1].var_B661);
      level.var_10AE5[var_1] func_12F25();
    }

    lib_0E4E::func_96F1();
    while(scripts\engine\utility::player_is_in_jackal()) {
      wait(0.05);
    }
  } else {
    anim.player = var_1;
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
    for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
      level.var_10AE5[var_1].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_1].var_B661);
      level.var_10AE5[var_1] func_12F25();
    }

    lib_0E4E::func_96F1();
    while(!scripts\engine\utility::player_is_in_jackal()) {
      wait(0.05);
    }
  }

  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      var_2 = [];
      foreach(var_4 in level.var_10AF9["allies"].var_B661) {
        if(var_4 != level.player) {
          var_2[var_2.size] = var_4;
        }
      }

      level.var_10AF9["allies"].var_B661 = var_2;
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
      for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
        level.var_10AE5[var_1].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_1].var_B661);
        level.var_10AE5[var_1] func_12F25();
      }

      lib_0E4E::func_96F1();
      while(scripts\engine\utility::player_is_in_jackal()) {
        wait(0.05);
      }

      continue;
    }

    var_2 = [];
    foreach(var_4 in level.var_10AF9["allies"].var_B661) {
      if(!isDefined(level.var_D127) || isDefined(level.var_D127) && var_4 != level.var_D127) {
        var_2[var_2.size] = var_4;
      }
    }

    level.var_10AF9["allies"].var_B661 = var_2;
    anim.player = var_0;
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
    for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
      level.var_10AE5[var_1].var_B661 = scripts\engine\utility::array_removeundefined(level.var_10AE5[var_1].var_B661);
      level.var_10AE5[var_1] func_12F25();
    }

    lib_0E4E::func_96F1();
    while(!scripts\engine\utility::player_is_in_jackal()) {
      wait(0.05);
    }
  }
}

getplayerangles(var_0) {
  var_1 = "allies";
  if(isDefined(level.template_script) && level.template_script == "phparade") {
    var_0.team = "allies";
  }

  if(var_0.team == "axis" || var_0.team == "neutral" || var_0.team == "team3") {
    var_1 = var_0.team;
  }

  return var_1;
}

func_185C(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.var_EEC4)) {
      var_0 = self.var_EEC4;
    } else {
      var_0 = self.team;
    }

    if(isDefined(self.var_29B8) && self.var_29B8) {
      var_0 = "jackal_" + self.script_team;
    }
  }

  if(!isDefined(level.var_10AF9[var_0])) {
    anim func_4A1B(var_0, self);
  }

  var_1 = level.var_10AF9[var_0];
  if(isDefined(self.var_10AC8)) {
    if(self.var_10AC8 == var_1) {
      return;
    } else {
      func_E11A();
    }
  }

  self.lastenemysighttime = 0;
  self.var_440E = 0;
  self.starttime = gettime();
  self.var_10AC8 = var_1;
  self.var_10AED = var_1.var_B661.size;
  var_1.var_B661[self.var_10AED] = self;
  var_1.var_B65C = var_1.var_B661.size;
  if(isDefined(level.var_AE64)) {
    if(self.team == "allies" && scripts\anim\battlechatter::func_9EC2()) {
      func_1804();
    }
  }

  foreach(var_3 in self.var_10AC8.var_B659) {
    self thread[[var_3]](self.var_10AC8.var_10AEE);
  }

  thread func_B65D();
}

func_E11A() {
  var_0 = self.var_10AC8;
  var_1 = -1;
  if(isDefined(self)) {
    var_1 = self.var_10AED;
  } else {
    for(var_2 = 0; var_2 < var_0.var_B661.size; var_2++) {
      if(var_0.var_B661[var_2] == self) {
        var_1 = var_2;
      }
    }
  }

  if(var_1 != var_0.var_B661.size - 1) {
    var_3 = var_0.var_B661[var_0.var_B661.size - 1];
    var_0.var_B661[var_1] = var_3;
    if(isDefined(var_3)) {
      var_3.var_10AED = var_1;
    }
  }

  var_0.var_B661[var_0.var_B661.size - 1] = undefined;
  var_0.var_B65C = var_0.var_B661.size;
  if(isDefined(self.var_10AF0)) {
    func_E142();
  }

  foreach(var_5 in self.var_10AC8.var_B65F) {
    self thread[[var_5]](var_0.var_10AEE);
  }

  if(var_0.var_B65C == 0) {
    func_51D2(var_0.var_10AEE);
  }

  if(isDefined(self)) {
    self.var_10AC8 = undefined;
    self.var_10AED = undefined;
    self notify("removed from squad");
  }
}

func_1804() {
  var_0 = self.var_10AC8;
  if(isDefined(self.var_10AF0)) {
    return;
  }

  self.var_10AF0 = var_0.var_C35C.size;
  var_0.var_C35C[self.var_10AF0] = self;
  var_0.var_C35A = var_0.var_C35C.size;
}

func_E142() {
  var_0 = self.var_10AC8;
  var_1 = -1;
  if(isDefined(self)) {
    var_1 = self.var_10AF0;
  } else {
    for(var_2 = 0; var_2 < var_0.var_C35C.size; var_2++) {
      if(var_0.var_C35C[var_2] == self) {
        var_1 = var_2;
      }
    }
  }

  if(var_1 != var_0.var_C35C.size - 1) {
    var_3 = var_0.var_C35C[var_0.var_C35C.size - 1];
    var_0.var_C35C[var_1] = var_3;
    if(isDefined(var_3)) {
      var_3.var_10AF0 = var_1;
    }
  }

  var_0.var_C35C[var_0.var_C35C.size - 1] = undefined;
  var_0.var_C35A = var_0.var_C35C.size;
  if(isDefined(self)) {
    self.var_10AF0 = undefined;
  }
}

func_C35D() {
  if(!isDefined(level.var_AE64)) {
    anim waittill("loadout complete");
  }

  for(var_0 = 0; var_0 < self.var_B661.size; var_0++) {
    if(self.var_B661[var_0] scripts\anim\battlechatter::func_9EC2()) {
      self.var_B661[var_0] func_1804();
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
  self waittill("death", var_0);
  if(isDefined(self)) {
    self.opcode::OP_EvalLocalVariableRefCached = var_0;
  }

  func_E11A();
}

func_12E77() {
  self.var_9E40 = 0;
  for(var_0 = 0; var_0 < level.var_10AE5.size; var_0++) {
    self.var_10AE9[level.var_10AE5[var_0].var_10AEE].var_9E42 = 0;
  }

  for(var_0 = 0; var_0 < self.var_B661.size; var_0++) {
    if(isDefined(self.var_B661[var_0])) {
      if(isDefined(self.var_B661[var_0].enemy) && isDefined(self.var_B661[var_0].enemy.var_10AC8) && self.var_B661[var_0].var_440E > 0) {
        self.var_10AE9[self.var_B661[var_0].enemy.var_10AC8.var_10AEE].var_9E42 = 1;
      }
    }
  }
}

func_12E59() {
  var_0 = (0, 0, 0);
  var_1 = (0, 0, 0);
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;
  func_12E77();
  var_5 = !isDefined(self.enemy);
  if(!var_5) {
    self.missionfailed = vectornormalize(self.enemy.origin - self.origin);
  }

  foreach(var_7 in self.var_B661) {
    if(!isalive(var_7)) {
      continue;
    }

    var_2++;
    var_0 = var_0 + var_7.origin;
    if(var_5) {
      var_1 = var_1 + anglesToForward(var_7.angles);
    }

    if(isDefined(var_7.enemy) && isDefined(var_7.enemy.var_10AC8)) {
      if(!isDefined(var_3)) {
        var_3 = var_7.enemy.var_10AC8;
        continue;
      }

      if(var_7.enemy.var_10AC8.var_B65C > var_3.var_B65C) {
        var_3 = var_7.enemy.var_10AC8;
      }
    }
  }

  if(var_2) {
    self.origin = var_0 / var_2;
    if(var_5) {
      self.missionfailed = var_1 / var_2;
    }
  } else {
    self.origin = var_0;
    if(var_5) {
      self.missionfailed = var_1;
    }
  }

  self.var_9E40 = var_4;
  self.enemy = var_3;
}

func_12F25() {
  for(var_0 = 0; var_0 < level.var_10AE5.size; var_0++) {
    if(!isDefined(self.var_10AE9[level.var_10AE5[var_0].var_10AEE])) {
      self.var_10AE9[level.var_10AE5[var_0].var_10AEE] = spawnStruct();
      self.var_10AE9[level.var_10AE5[var_0].var_10AEE].var_9E42 = 0;
    }

    foreach(var_2 in self.var_10AFD) {
      self thread[[var_2]](level.var_10AE5[var_0].var_10AEE);
    }
  }
}

func_D909(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = (1, 0, 0);
  }

  for(var_4 = 0; var_4 < var_1 * 2; var_4++) {
    if(!isalive(self)) {
      return;
    }

    var_5 = self getshootatpos() + (0, 0, 10) + var_2;
    wait(0.05);
  }
}

func_1B0E(var_0) {
  switch (var_0) {
    case "combat":
    case "stop":
    case "move":
    case "death":
      self.a.state = var_0;
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
  var_0 = 0.05;
  for(;;) {
    foreach(var_2 in self.var_B661) {
      if(!isalive(var_2) || var_2 == level.player) {
        continue;
      }

      var_2 func_1B0F(var_0);
      var_2 func_1B10(var_0);
    }

    wait(var_0);
  }
}

func_1B0F(var_0) {
  if(!isDefined(self.var_440E)) {
    return;
  }

  if(isDefined(self.lastenemysightpos)) {
    if(self.var_440E < 0) {
      self.var_440E = var_0;
    } else {
      self.var_440E = self.var_440E + var_0;
    }

    self.lastenemysighttime = gettime();
    return;
  } else if((isDefined(self.var_3136) && self.var_3136) || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.var_440E = self.var_440E + var_0;
    return;
  }

  if(self.var_440E > 0) {
    self.var_440E = 0 - var_0;
    return;
  }

  self.var_440E = self.var_440E - var_0;
}

func_1B10(var_0) {
  if(!isDefined(self.var_112CA)) {
    return;
  }

  if((isDefined(self.var_3136) && self.var_3136) || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    if(self.var_112CA < 0) {
      self.var_112CA = var_0;
    } else {
      self.var_112CA = self.var_112CA + var_0;
    }

    return;
  }

  if(self.var_112CA > 0) {
    self.var_112CA = 0 - var_0;
    return;
  }

  self.var_112CA = self.var_112CA - var_0;
}