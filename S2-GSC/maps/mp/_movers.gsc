/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_movers.gsc
*********************************************/

func_00F9() {
  if(getDvar("233") == "1") {
    return;
  }

  level.var_8216 = [];
  level.var_8216["move_time"] = 5;
  level.var_8216["accel_time"] = 0;
  level.var_8216["decel_time"] = 0;
  level.var_8216["wait_time"] = 0;
  level.var_8216["delay_time"] = 0;
  level.var_8216["usable"] = 0;
  level.var_8216["hintstring"] = "activate";
  func_820C("activate", &"MP_ACTIVATE_MOVER");
  func_820D("none", "");
  level.var_8226 = [];
  level.var_8211 = [];
  wait 0.05;
  var_00 = [];
  var_01 = func_8213();
  foreach(var_03 in var_01) {
    var_00 = common_scripts\utility::func_0F73(var_00, getEntArray(var_03, "classname"));
  }

  common_scripts\utility::func_0FB2(var_00, ::func_821E);
}

func_8213() {
  return ["script_model_mover", "script_brushmodel_mover"];
}

func_8222() {
  if(isDefined(self.var_820A)) {
    return self.var_820A;
  }

  var_00 = func_8213();
  foreach(var_02 in var_00) {
    if(self.var_003A == var_02) {
      self.var_820A = 1;
      return 1;
    }
  }

  return 0;
}

func_820C(param_00, param_01) {
  if(!isDefined(level.var_821D)) {
    level.var_821D = [];
  }

  level.var_821D[param_00] = param_01;
}

func_820D(param_00, param_01) {
  if(!isDefined(level.var_8229)) {
    level.var_8229 = [];
  }

  level.var_8229[param_00] = param_01;
}

func_820B(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_8211)) {
    level.var_8211 = [];
  }

  if(!isDefined(param_03)) {
    param_03 = "default";
  }

  if(!isDefined(level.var_8211[param_00])) {
    level.var_8211[param_00] = [];
  }

  var_04 = spawnStruct();
  var_04.var_0EC4 = param_01;
  var_04.var_0ED1 = param_02;
  level.var_8211[param_00][param_03] = var_04;
}

func_821E() {
  self.var_820A = 1;
  self.var_64E3 = 0;
  self.var_6C3E = self;
  self.var_A1F9 = [];
  self.var_5DAB = [];
  var_00 = [];
  if(isDefined(self.var_01A2)) {
    var_00 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
  }

  foreach(var_02 in var_00) {
    if(!isDefined(var_02.var_0165)) {
      continue;
    }

    switch (var_02.var_0165) {
      case "origin":
        if(!isDefined(var_02.var_001D)) {
          var_02.var_001D = (0, 0, 0);
        }

        self.var_6C3E = spawn("script_model", var_02.var_0116);
        self.var_6C3E.var_001D = var_02.var_001D;
        self.var_6C3E setModel("tag_origin");
        self.var_6C3E linkto(self);
        break;

      case "scene_node":
      case "scripted_node":
        if(!isDefined(var_02.var_001D)) {
          var_02.var_001D = (0, 0, 0);
        }

        self.var_830E = var_02;
        break;

      default:
        break;
    }
  }

  var_04 = [];
  if(isDefined(self.var_01A2)) {
    var_04 = getEntArray(self.var_01A2, "targetname");
  }

  foreach(var_02 in var_04) {
    if(!isDefined(var_02.var_0165)) {
      continue;
    }

    var_06 = strtok(var_02.var_0165, ";");
    foreach(var_08 in var_06) {
      switch (var_08) {
        case "use_trigger_link":
          var_02 enablelinkto();
          var_02 linkto(self);
          break;

        case "use_trigger":
          var_02 func_822D();
          thread func_823C(var_02);
          self.var_A1F9[self.var_A1F9.size] = var_02;
          break;

        case "link":
          var_02 linkto(self);
          self.var_5DAB[self.var_5DAB.size] = var_02;
          break;

        default:
          break;
      }
    }
  }

  thread func_822D();
  thread func_821F();
  thread func_8231();
  thread func_8232();
  thread func_8212(self);
  thread func_8230();
  func_8237();
  foreach(var_0C in self.var_A1F9) {
    func_8234(var_0C, 1);
  }

  self.var_821E = 1;
  self notify("script_mover_init");
}

func_8237() {
  if(func_8220()) {
    thread func_8210();
    return;
  }

  thread func_8225();
}

func_8230() {
  self.var_64C0 = self.var_0116;
  self.var_64BF = self.var_001D;
}

func_822F(param_00) {
  self notify("mover_reset");
  if(func_8220()) {
    self scriptmodelclearanim();
  }

  self.var_0116 = self.var_64C0;
  self.var_001D = self.var_64BF;
  self notify("new_path");
  wait 0.05;
  func_8237();
}

func_823C(param_00) {
  self endon("death");
  for(;;) {
    param_00 waittill("trigger");
    if(param_00.var_480C.size > 0) {
      self notify("new_path");
      thread func_8225(param_00);
      continue;
    }

    self notify("trigger");
  }
}

func_8224(param_00) {
  if(isDefined(level.var_8226[param_00])) {
    self notify("new_path");
    self.var_480C = level.var_8226[param_00];
    thread func_8225();
  }
}

func_0DDE(param_00) {
  return (angleclamp180(param_00[0]), angleclamp180(param_00[1]), angleclamp180(param_00[2]));
}

func_822D() {
  if(isDefined(self.var_6E88) && self.var_6E88) {
    return;
  }

  self.var_6E88 = 1;
  self.var_480C = [];
  self.var_64C5 = [];
  var_00 = [];
  var_01 = [];
  if(isDefined(self.var_01A2)) {
    var_00 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
    var_01 = getEntArray(self.var_01A2, "targetname");
  }

  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    var_03 = var_00[var_02];
    if(!isDefined(var_03.var_0165)) {
      var_03.var_0165 = "goal";
    }

    switch (var_03.var_0165) {
      case "ignore":
        if(isDefined(var_03.var_01A2)) {
          var_04 = common_scripts\utility::func_46B7(var_03.var_01A2, "targetname");
          foreach(var_06 in var_04) {
            var_00[var_00.size] = var_06;
          }
        }
        break;

      case "goal":
        var_03 func_821F();
        var_03 func_822D();
        self.var_480C[self.var_480C.size] = var_03;
        if(isDefined(var_03.var_6E5C["name"])) {
          if(!isDefined(level.var_8226[var_03.var_6E5C["name"]])) {
            level.var_8226[var_03.var_6E5C["name"]] = [];
          }

          var_08 = level.var_8226[var_03.var_6E5C["name"]].size;
          level.var_8226[var_03.var_6E5C["name"]][var_08] = var_03;
        }
        break;

      default:
        break;
    }
  }

  foreach(var_0A in var_01) {
    if(var_0A func_8222()) {
      self.var_64C5[self.var_64C5.size] = var_0A;
    }

    thread func_822A(var_0A);
  }
}

func_822A(param_00) {
  if(!isDefined(param_00.var_0165)) {
    return;
  }

  if(param_00 func_8222() && !isDefined(param_00.var_821E)) {
    param_00 waittill("script_mover_init");
  }

  var_01 = strtok(param_00.var_0165, ";");
  foreach(var_03 in var_01) {
    var_04 = strtok(var_03, "_");
    if(var_04.size < 3 || var_04[1] != "on") {
      continue;
    }

    var_05 = tolower(var_04[0]);
    var_06 = var_04[2];
    for(var_07 = 3; var_07 < var_04.size; var_07++) {
      var_06 = var_06 + "_" + var_04[var_07];
    }

    switch (var_05) {
      case "connectpaths":
        thread func_821A(param_00, var_06, ::func_8215, ::func_8219);
        break;

      case "disconnectpaths":
        thread func_821A(param_00, var_06, ::func_8219, ::func_8215);
        break;

      case "solid":
        param_00 notsolid();
        thread func_821A(param_00, var_06, ::func_8236, ::func_8228);
        break;

      case "notsolid":
        thread func_821A(param_00, var_06, ::func_8228, ::func_8236);
        break;

      case "delete":
        thread func_821A(param_00, var_06, ::func_8218);
        break;

      case "hide":
        thread func_821A(param_00, var_06, ::func_821C, ::func_8235);
        break;

      case "show":
        param_00 method_805C();
        thread func_821A(param_00, var_06, ::func_8235, ::func_821C);
        break;

      case "triggerhide":
        thread func_821A(param_00, var_06, ::func_8239, ::func_823A);
        break;

      case "triggershow":
        param_00 common_scripts\utility::func_9D9F();
        thread func_821A(param_00, var_06, ::func_823A, ::func_8239);
        break;

      case "trigger":
        thread func_821A(param_00, var_06, ::func_8238, ::func_822F);
        break;

      default:
        break;
    }
  }
}

func_8239(param_00) {
  self method_808C();
  common_scripts\utility::func_9D9F();
}

func_823A(param_00) {
  self method_808C();
  common_scripts\utility::func_9DA3();
}

func_8227(param_00, param_01) {
  param_00 notify(param_01);
}

func_8223(param_00, param_01) {
  level notify(param_01);
}

func_8215(param_00) {
  self method_8060();
}

func_8219(param_00) {
  self method_805F(param_00);
}

func_8236(param_00) {
  self solid();
}

func_8228(param_00) {
  self notsolid();
}

func_8218(param_00) {
  self delete();
}

func_821C(param_00) {
  self method_805C();
}

func_8235(param_00) {
  self method_805B();
}

func_8238(param_00) {
  self notify("trigger");
}

func_821A(param_00, param_01, param_02, param_03) {
  self endon("death");
  param_00 endon("death");
  for(;;) {
    self waittill(param_01, var_04);
    param_00[[param_02]](var_04);
    if(isDefined(param_03) && isDefined(var_04)) {
      var_04 func_823D(param_00, param_03);
      continue;
    }

    break;
  }
}

func_823B() {
  var_00 = [];
  if(func_8221()) {
    var_00[var_00.size] = self;
  }

  foreach(var_02 in self.var_5DAB) {
    if(var_02 func_8221()) {
      var_00[var_00.size] = var_02;
    }
  }

  if(var_00.size == 0) {
    return;
  }

  for(;;) {
    foreach(var_05 in var_00) {
      var_05 func_8219();
    }

    self waittill("move_start");
    foreach(var_05 in var_00) {
      var_05 func_8215();
    }

    self waittill("move_end");
  }
}

func_8210() {
  childthread func_823B();
  var_00 = self.var_6E5C["animation"];
  if(isDefined(level.var_8211[var_00]["idle"])) {
    func_822E(level.var_8211[var_00]["idle"], 0);
  }

  func_8217();
  self notify("move_start");
  self notify("start", self);
  var_01 = level.var_8211[var_00]["default"];
  if(isDefined(var_01)) {
    func_822E(var_01, 1);
    self waittill("end");
  }

  self notify("move_end");
}

func_822E(param_00, param_01) {
  self notify("play_animation");
  if(param_01) {
    thread func_821B();
  }

  if(isDefined(self.var_830E)) {
    self method_8495(param_00.var_0EC4, self.var_830E.var_0116, self.var_830E.var_001D, "script_mover_anim");
    return;
  }

  self method_8278(param_00.var_0EC4, "script_mover_anim");
}

func_821B() {
  self endon("play_animation");
  self endon("mover_reset");
  for(;;) {
    self waittill("script_mover_anim", var_00);
    self notify(var_00, self);
  }
}

func_8217() {
  if(isDefined(self.var_6E5C["delay_till"])) {
    level waittill(self.var_6E5C["delay_till"]);
  }

  if(isDefined(self.var_6E5C["delay_till_trigger"]) && self.var_6E5C["delay_till_trigger"]) {
    self waittill("trigger");
  }

  if(self.var_6E5C["delay_time"] > 0) {
    wait(self.var_6E5C["delay_time"]);
  }
}

func_8225(param_00) {
  self endon("death");
  self endon("new_path");
  childthread func_823B();
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  while(param_00.var_480C.size != 0) {
    var_01 = common_scripts\utility::func_7A33(param_00.var_480C);
    var_02 = self;
    var_02 func_8212(var_01);
    var_02 func_8217();
    var_03 = var_02.var_6E5C["move_time"];
    var_04 = var_02.var_6E5C["accel_time"];
    var_05 = var_02.var_6E5C["decel_time"];
    var_06 = 0;
    var_07 = 0;
    var_08 = transformmove(var_01.var_0116, var_01.var_001D, self.var_6C3E.var_0116, self.var_6C3E.var_001D, self.var_0116, self.var_001D);
    if(var_02.var_0116 != var_01.var_0116) {
      if(isDefined(var_02.var_6E5C["move_speed"])) {
        var_09 = distance(var_02.var_0116, var_01.var_0116);
        var_03 = var_09 / var_02.var_6E5C["move_speed"];
      }

      if(isDefined(var_02.var_6E5C["accel_frac"])) {
        var_04 = var_02.var_6E5C["accel_frac"] * var_03;
      }

      if(isDefined(var_02.var_6E5C["decel_frac"])) {
        var_05 = var_02.var_6E5C["decel_frac"] * var_03;
      }

      if(var_03 <= 0) {
        var_02 method_808C();
        var_02.var_0116 = var_08["origin"];
      } else {
        var_02 moveto(var_08["origin"], var_03, var_04, var_05);
      }

      var_06 = 1;
    }

    if(func_0DDE(var_08["angles"]) != func_0DDE(var_02.var_001D)) {
      if(var_03 <= 0) {
        var_02 method_808C();
        var_02.var_001D = var_08["angles"];
      } else {
        var_02 rotateto(var_08["angles"], var_03, var_04, var_05);
      }

      var_07 = 1;
    }

    foreach(var_0B in var_02.var_64C5) {
      var_0B notify("trigger");
      func_823D(var_0B, ::func_822F);
    }

    var_02 notify("move_start");
    param_00 notify("depart", var_02);
    if(isDefined(var_02.var_6E5C["name"])) {
      var_0D = "mover_depart_" + var_02.var_6E5C["name"];
      var_02 notify(var_0D);
      level notify(var_0D, var_02);
    }

    var_02 func_820F(0);
    if(var_03 <= 0) {} else if(var_06) {
      var_02 waittill("movedone");
    } else if(var_07) {
      var_02 waittill("rotatedone");
    } else {
      wait(var_03);
    }

    var_02 notify("move_end");
    var_01 notify("arrive", var_02);
    if(isDefined(var_02.var_6E5C["name"])) {
      var_0D = "mover_arrive_" + var_02.var_6E5C["name"];
      var_02 notify(var_0D);
      level notify(var_0D, var_02);
    }

    if(isDefined(var_02.var_6E5C["solid"])) {
      if(var_02.var_6E5C["solid"]) {
        var_02 solid();
      } else {
        var_02 notsolid();
      }
    }

    foreach(var_0B in var_01.var_64C5) {
      var_0B notify("trigger");
      func_823D(var_0B, ::func_822F);
    }

    if(isDefined(var_02.var_6E5C["wait_till"])) {
      level waittill(var_02.var_6E5C["wait_till"]);
    }

    if(var_02.var_6E5C["wait_time"] > 0) {
      wait(var_02.var_6E5C["wait_time"]);
    }

    var_02 func_820F(1);
    param_00 = var_01;
  }
}

func_823D(param_00, param_01) {
  thread func_821A(param_00, "mover_reset", param_01);
}

func_821F() {
  self.var_6E5C = [];
  if(!isDefined(self.var_001D)) {
    self.var_001D = (0, 0, 0);
  }

  self.var_001D = func_0DDE(self.var_001D);
  func_822B(self.var_8260);
}

func_822B(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  var_01 = strtok(param_00, ";");
  foreach(var_03 in var_01) {
    var_04 = strtok(var_03, "=");
    if(var_04.size != 2) {
      continue;
    }

    if(var_04[1] == "undefined" || var_04[1] == "default") {
      self.var_6E5C[var_04[0]] = "<undefined>";
      continue;
    }

    switch (var_04[0]) {
      case "decel_frac":
      case "accel_frac":
      case "move_speed":
      case "delay_time":
      case "wait_time":
      case "decel_time":
      case "accel_time":
      case "move_time":
        self.var_6E5C[var_04[0]] = func_822C(var_04[1]);
        break;

      case "wait_till":
      case "delay_till":
      case "animation":
      case "hintstring":
      case "name":
        self.var_6E5C[var_04[0]] = var_04[1];
        break;

      case "delay_till_trigger":
      case "usable":
      case "solid":
        self.var_6E5C[var_04[0]] = int(var_04[1]);
        break;

      case "script_params":
        var_05 = var_04[1];
        var_06 = level.var_8229[var_05];
        if(isDefined(var_06)) {
          func_822B(var_06);
        }
        break;

      default:
        break;
    }
  }
}

func_822C(param_00) {
  var_01 = 0;
  var_02 = strtok(param_00, ",");
  if(var_02.size == 1) {
    var_01 = float(var_02[0]);
  } else if(var_02.size == 2) {
    var_03 = float(var_02[0]);
    var_04 = float(var_02[1]);
    if(var_03 >= var_04) {
      var_01 = var_03;
    } else {
      var_01 = randomfloatrange(var_03, var_04);
    }
  }

  return var_03;
}

func_8212(param_00) {
  foreach(var_03, var_02 in param_00.var_6E5C) {
    func_8233(var_03, var_02);
  }

  func_8232();
}

func_8233(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 == "usable" && isDefined(param_01)) {
    func_8234(self, param_01);
  }

  if(isDefined(param_01) && isstring(param_01) && param_01 == "<undefined>") {
    param_01 = undefined;
  }

  self.var_6E5C[param_00] = param_01;
}

func_820F(param_00) {
  if(self.var_6E5C["usable"]) {
    func_8234(self, param_00);
  }

  foreach(var_02 in self.var_A1F9) {
    func_8234(var_02, param_00);
  }
}

func_8234(param_00, param_01) {
  if(param_01) {
    param_00 makeusable();
    param_00 setcursorhint("HINT_ACTIVATE");
    param_00 sethintstring(level.var_821D[self.var_6E5C["hintstring"]]);
    return;
  }

  param_00 makeunusable();
}

func_8231() {
  self.var_6E5D = [];
  foreach(var_02, var_01 in self.var_6E5C) {
    self.var_6E5D[var_02] = var_01;
  }
}

func_8232() {
  if(isDefined(self.var_6E5D)) {
    foreach(var_02, var_01 in self.var_6E5D) {
      if(!isDefined(self.var_6E5C[var_02])) {
        func_8233(var_02, var_01);
      }
    }
  }

  foreach(var_02, var_01 in level.var_8216) {
    if(!isDefined(self.var_6E5C[var_02])) {
      func_8233(var_02, var_01);
    }
  }
}

func_8221() {
  return isDefined(self.var_0187) && self.var_0187 & 1;
}

func_8220() {
  return isDefined(self.var_6E5C["animation"]);
}

func_00D5() {
  level thread func_8214();
  level thread func_820E();
}

func_8214() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_7388();
  }
}

func_820E() {
  for(;;) {
    level waittill("spawned_agent", var_00);
    var_00 thread func_7388();
  }
}

func_7388() {
  self endon("disconnect");
  if(function_01EF(self)) {
    self endon("death");
  }

  self.var_A043 = 0;
  for(;;) {
    self waittill("unresolved_collision", var_00);
    if(function_01EF(self) && isDefined(self.var_0EAE)) {
      if(self method_8554() == "noclip") {
        continue;
      }
    }

    self.var_A043++;
    thread func_23D3();
    var_01 = 3;
    if(isDefined(var_00) && isDefined(var_00.var_A049)) {
      var_01 = var_00.var_A049;
    }

    if(self.var_A043 >= var_01) {
      if(isDefined(var_00)) {
        if(isDefined(var_00.var_A045)) {
          var_00[[var_00.var_A045]](self);
        } else if(isDefined(var_00.var_A046) && var_00.var_A046) {
          var_00 func_A04A(self);
        } else {
          var_00 func_A047(self);
        }
      } else {
        func_A047(self);
      }

      self.var_A043 = 0;
    }
  }
}

func_23D3() {
  self endon("unresolved_collision");
  wait 0.05;
  if(isDefined(self)) {
    self.var_A043 = 0;
  }
}

func_A04A(param_00) {
  var_01 = self;
  if(!isDefined(var_01.var_0117)) {
    param_00 func_64C1();
    return;
  }

  var_02 = 0;
  if(level.var_984D) {
    if(isDefined(var_01.var_0117.var_01A7) && var_01.var_0117.var_01A7 != param_00.var_01A7) {
      var_02 = 1;
    }
  } else if(param_00 != var_01.var_0117) {
    var_02 = 1;
  }

  if(!var_02) {
    param_00 func_64C1();
    return;
  }

  var_03 = 1000;
  if(isDefined(var_01.var_A044)) {
    var_03 = var_01.var_A044;
  }

  param_00 dodamage(var_03, var_01.var_0116, var_01.var_0117, var_01, "MOD_CRUSH");
}

func_A047(param_00, param_01) {
  var_02 = self.var_A048;
  var_03 = undefined;
  if(maps\mp\_utility::func_585F() && common_scripts\utility::func_562E(level.use_zombie_unresolved_collision)) {
    if(!isDefined(var_02)) {
      var_02 = [];
    }

    var_04 = getclosestpointonnavmesh(param_00.var_0116);
    if(isDefined(var_04)) {
      var_03 = spawnStruct();
      var_03.var_0116 = getclosestpointonnavmesh(param_00.var_0116);
      var_02 = common_scripts\utility::func_0F6F(var_02, var_03);
    }

    var_02 = common_scripts\utility::func_0F73(var_02, getnodesinradius(param_00.var_0116, 300, 0, 200, "End 3D"));
    if(isDefined(level.failsafe_collision_nodes) && isarray(level.failsafe_collision_nodes)) {
      var_02 = common_scripts\utility::func_0F73(var_02, level.failsafe_collision_nodes);
    }
  }

  if(isDefined(var_02)) {
    var_02 = function_01AC(var_02, param_00.var_0116);
  } else {
    var_02 = getnodesinradius(param_00.var_0116, 300, 0, 200);
    var_02 = function_01AC(var_02, param_00.var_0116);
  }

  var_05 = (0, 0, -100);
  param_00 method_843C();
  param_00 method_808C();
  param_00 setorigin(param_00.var_0116 + var_05);
  for(var_06 = 0; var_06 < var_02.size; var_06++) {
    var_07 = var_02[var_06];
    var_08 = var_07.var_0116;
    if(!canspawn(var_08)) {
      continue;
    }

    if(positionwouldtelefrag(var_08)) {
      continue;
    }

    if(param_00 playerisweaponplantenabled()) {
      param_00 common_scripts\_plant_weapon::forcedismountweapon();
    }

    if(param_00 getstance() == "prone") {
      param_00 setstance("crouch");
    }

    param_00 setorigin(var_08);
    return;
  }

  if(level.var_015D == "mp_hub_allies_slim" && var_02.size == 0) {
    if(param_00 playerisweaponplantenabled()) {
      param_00 common_scripts\_plant_weapon::forcedismountweapon();
    }

    return;
  }

  param_00 setorigin(param_00.var_0116 - var_05);
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01) {
    param_00 func_64C1();
  }
}

func_A04B(param_00) {}

func_64C1() {
  maps\mp\_utility::func_0728();
}

func_7305(param_00) {
  self endon("death");
  self endon("stop_player_pushed_kill");
  for(;;) {
    self waittill("player_pushed", var_01, var_02);
    if(isPlayer(var_01) || function_01EF(var_01)) {
      var_03 = length(var_02);
      if(var_03 >= param_00) {
        func_A04A(var_01);
      }
    }
  }
}

func_93E1() {
  self notify("stop_player_pushed_kill");
}

func_67F9() {
  var_00 = self getlinkedchildren(0);
  if(!isDefined(var_00)) {
    return;
  }

  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_66F0) && var_02.var_66F0) {
      continue;
    }

    var_02 unlink();
    var_02 notify("invalid_parent", self);
  }
}

func_774B(param_00, param_01) {
  if(isDefined(param_01) && isDefined(param_01.var_66EF) && param_01.var_66EF) {
    return;
  }

  if(isDefined(param_00.var_720F)) {
    playFX(common_scripts\utility::func_44F5("airdrop_crate_destroy"), self.var_0116);
  }

  if(isDefined(param_00.var_2AA8)) {
    self thread[[param_00.var_2AA8]](param_00);
    return;
  }

  self delete();
}

func_4A26(param_00) {
  for(;;) {
    self waittill("touching_platform", var_01);
    if(isDefined(param_00.var_9AC2) && !self[[param_00.var_9AC2]](var_01)) {
      continue;
    }

    if(isDefined(param_00.var_A270) && param_00.var_A270) {
      if(!self istouching(var_01)) {
        wait 0.05;
        continue;
      }
    }

    thread func_774B(param_00, var_01);
    break;
  }
}

func_4A25(param_00) {
  self waittill("invalid_parent", var_01);
  if(isDefined(param_00.var_54FA)) {
    self thread[[param_00.var_54FA]](param_00);
    return;
  }

  thread func_774B(param_00, var_01);
}

func_4A27(param_00) {
  self notify("handle_moving_platforms");
  self endon("handle_moving_platforms");
  level endon("game_ended");
  self endon("death");
  self endon("stop_handling_moving_platforms");
  if(!isDefined(param_00)) {
    param_00 = spawnStruct();
  }

  if(isDefined(param_00.var_36DE)) {
    self endon(param_00.var_36DE);
  }

  if(isDefined(param_00.var_5DB9)) {
    self linkto(param_00.var_5DB9);
  }

  childthread func_4A26(param_00);
  childthread func_4A25(param_00);
}

func_93CE() {
  self notify("stop_handling_moving_platforms");
}

func_64E7(param_00) {}