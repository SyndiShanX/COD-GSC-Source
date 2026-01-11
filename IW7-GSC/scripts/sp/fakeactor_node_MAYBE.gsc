/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\fakeactor_node_MAYBE.gsc
***********************************************/

func_6B3D() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  if(self.var_ED8B == "path" || self.var_ED8B == "turn") {
    self.var_1366C = 2;
  } else {
    self.var_1366C = 0;
  }

  switch (self.var_ED8B) {
    case "traverse":
      if(isDefined(self.target)) {
        var_00 = getnodearray(self.target, "targetname");
        if(!var_00.size) {
          if(isDefined(self.script_linkto)) {
            var_00 = getnodearray(self.script_linkto, "script_linkname");
          }
        }

        if(var_00.size > 0) {
          foreach(var_02 in var_00) {
            if(var_02.type == "Begin") {
              self.var_126CD = var_02.var_48;
            }
          }
        }

        var_04 = scripts\engine\utility::getstructarray(self.target, "targetname");
        if(isDefined(self.script_linkto)) {
          var_04 = scripts\engine\utility::array_combine(var_04, scripts\engine\utility::getstructarray(self.script_linkto, "script_linkname"));
        }

        foreach(var_06 in var_04) {
          if(isDefined(var_06.animation)) {
            self.origin = var_06.origin;
            self.angles = var_06.angles;
          }
        }
      }
      break;

    case "animation":
      break;
  }

  func_6B29();
  func_6B28();
  func_6B27();
  scripts\engine\utility::waitframe();
  switch (self.var_ED8B) {
    case "animation":
      self.var_1EEF = spawnStruct();
      self.var_1EEF.origin = self.origin;
      self.var_1EEF.angles = self.angles;
      var_08 = scripts\sp\utility::func_7DC3(self.animation);
      var_09 = getstartorigin(self.origin, self.angles, var_08);
      var_0A = getstartangles(self.origin, self.angles, var_08);
      self.origin = var_09;
      self.angles = var_0A;
      break;
  }
}

func_6B29() {
  switch (self.var_ED8B) {
    case "cover_left":
      self.type = "Cover Left";
      break;

    case "cover_right":
      self.type = "Cover Right";
      break;

    case "cover_crouch":
      self.type = "Cover Crouch";
      break;

    case "cover_stand":
      self.type = "Cover Stand";
      break;
  }
}

func_6B28() {
  if(!isDefined(self.script_parameters)) {
    return;
  }

  var_00 = strtok(self.script_parameters, " ");
  foreach(var_02 in var_00) {
    if(!isDefined(level.var_6B23[var_02])) {
      level.var_6B23[var_02] = [];
    }

    level.var_6B23[var_02] = ::scripts\engine\utility::array_add(level.var_6B23[var_02], self);
  }
}

func_6B27() {
  if(!isDefined(self.spawnimpulsefield)) {
    self.spawnimpulsefield = 0;
  }

  if(!self.spawnimpulsefield & 64) {
    var_00 = 32 * anglestoup(self.angles);
    var_01 = -20000 * anglestoup(self.angles);
    var_02 = scripts\common\trace::ray_trace(self.origin + var_00, self.origin + var_01, undefined, scripts\common\trace::create_solid_ai_contents());
    if(var_02["hittype"] == "hittype_none") {}

    self.origin = var_02["position"];
    if(self.spawnimpulsefield & 32) {
      if(isDefined(var_02["entity"])) {
        self.var_8625 = var_02["entity"];
        self.var_862A = self.var_8625 scripts\sp\utility::func_13DCC(self.origin);
        if(!isDefined(self.angles)) {
          self.angles = (0, 0, 0);
        }

        self.var_8627 = self.angles - self.var_8625.angles;
      }
    }
  }

  if(self.spawnimpulsefield & 8) {
    func_6B38(1);
  }

  if(self.spawnimpulsefield & 16) {
    self.var_1366C = 2;
  }

  self.var_C02F = [];
}

func_F97C() {
  level.var_6B23 = [];
  foreach(var_01 in level.struct) {
    if(isDefined(var_01.var_ED8B)) {
      var_01 thread func_6B3D();
    }
  }
}

func_9BE0() {
  return isDefined(self.var_ED8B);
}

func_6B3E() {
  if(!isDefined(self.var_8625)) {
    return;
  }

  self.origin = self.var_8625 gettweakablevalue(self.var_862A);
  var_00 = spawn("script_origin", (0, 0, 0));
  var_00.angles = self.var_8625.angles;
  var_00 getnodeyawtoenemy(self.var_8627[0]);
  var_00 addyaw(self.var_8627[1]);
  var_00 getnodeyawtoorigin(self.var_8627[2]);
  self.angles = var_00.angles;
  var_00 delete();
}

func_6B1F() {
  var_00 = [];
  var_01 = 0;
  if(isDefined(self.spawnimpulsefield)) {
    var_01 = self.spawnimpulsefield;
  }

  if(self.var_ED8B == "cover_left") {
    if(!var_01 & 1) {
      var_00 = scripts\engine\utility::array_add(var_00, "cover_left");
    }

    if(!var_01 & 2) {
      var_00 = scripts\engine\utility::array_add(var_00, "cover_left_crouch");
    }
  } else if(self.var_ED8B == "cover_right") {
    if(!var_01 & 1) {
      var_00 = scripts\engine\utility::array_add(var_00, "cover_right");
    }

    if(!var_01 & 2) {
      var_00 = scripts\engine\utility::array_add(var_00, "cover_right_crouch");
    }
  } else if(self.var_ED8B == "cover_stand") {
    var_00 = scripts\engine\utility::array_add(var_00, "cover_stand");
  } else if(self.var_ED8B == "cover_crouch") {
    var_00 = scripts\engine\utility::array_add(var_00, "cover_crouch");
  } else {
    var_00 = scripts\engine\utility::array_add(var_00, "exposed");
  }

  if(var_00.size == 0) {}

  return var_00;
}

func_6B20() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  var_00 = func_6B1D();
  if(var_00.size) {
    return scripts\engine\utility::random(var_00);
  }

  return undefined;
}

func_6B1D() {
  var_00 = [];
  if(!isDefined(self.target)) {
    return var_00;
  }

  var_01 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_03 in var_01) {
    if(!var_03 func_9BE0()) {
      continue;
    }

    if(!var_03 func_6B34()) {
      continue;
    }

    var_00 = scripts\engine\utility::array_add(var_00, var_03);
  }

  return var_00;
}

func_6B22() {
  if(!isDefined(self.target)) {
    return 0;
  }

  var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");
  var_01 = 0;
  foreach(var_03 in var_00) {
    if(!var_03 func_9BE0()) {
      continue;
    }

    if(!var_03 func_6B34()) {
      continue;
    }

    var_01++;
  }

  return var_01;
}

func_6B1E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = spawn("script_origin", (0, 0, 0));
  if(isDefined(self.angles)) {
    var_01.angles = self.angles;
  }

  if(isDefined(self.type)) {
    if(param_00 && isDefined(level.var_6A63)) {
      if(isDefined(level.var_6A63[self.type])) {
        var_01 addyaw(level.var_6A63[self.type]);
      }
    } else if(isDefined(level.var_6A64)) {
      if(isDefined(level.var_6A64[self.type])) {
        var_01 addyaw(level.var_6A64[self.type]);
      }
    }
  }

  var_02 = var_01.angles;
  var_01 delete();
  return var_02;
}

func_6B21(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_04[0]["origin"] = param_01;
  var_04[0]["dist"] = 0;
  var_04[0]["radius"] = 0;
  var_04[0]["node"] = undefined;
  var_04[0]["total_dist"] = 0;
  var_05 = 1;
  var_06 = 200;
  for(;;) {
    var_07 = var_04.size;
    var_08 = undefined;
    if(var_05) {
      var_08 = param_00;
      var_05 = 0;
    } else {
      var_08 = var_04[var_07 - 1]["node"] func_6B20();
    }

    if(!isDefined(var_08)) {
      break;
    }

    var_04[var_07]["node"] = var_08;
    var_09 = var_08.origin;
    if(isDefined(var_08.fgetarg)) {
      if(!isDefined(self.var_5CC2)) {
        self.var_5CC2 = -1 + randomfloat(2);
      }

      if(!isDefined(var_08.angles)) {
        var_08.angles = (0, 0, 0);
      }

      var_0A = anglesToForward(var_08.angles);
      var_0B = anglestoright(var_08.angles);
      var_0C = anglestoup(var_08.angles);
      var_0D = (0, self.var_5CC2 * var_08.fgetarg, 0);
      var_09 = var_09 + var_0A * var_0D[0];
      var_09 = var_09 + var_0B * var_0D[1];
      var_09 = var_09 + var_0C * var_0D[2];
    }

    var_04[var_07]["origin"] = var_09;
    var_04[var_07]["angles"] = var_08 func_6B1E(param_02);
    if(var_07 > 0) {
      var_0E = var_09 - var_04[var_07 - 1]["origin"];
      var_04[var_07 - 1]["dist"] = length(var_0E);
      var_04[0]["total_dist"] = var_04[0]["total_dist"] + var_04[var_07 - 1]["dist"];
      var_04[var_07 - 1]["to_next_node"] = vectornormalize(var_0E);
      if(isDefined(var_08.fgetarg)) {
        var_04[var_07 - 1]["radius"] = var_08.fgetarg;
      } else {
        var_04[var_07 - 1]["radius"] = var_06;
      }
    }

    var_0F = param_03 && var_07 == 1;
    if(var_08 func_6B2D(var_0F)) {
      break;
    }
  }

  var_04[var_07]["dist"] = 0;
  var_04[var_07]["radius"] = 0;
  var_04[var_07]["to_next_node"] = var_04[var_07 - 1]["to_next_node"];
  return var_04;
}

func_6B34() {
  if(isDefined(self.disabled)) {
    return 0;
  }

  return 1;
}

func_6B2D(param_00) {
  if(func_6B2A() && !param_00) {
    return 1;
  }

  if(func_6B32() && !param_00) {
    return 1;
  }

  if(func_6B33() && !param_00) {
    return 1;
  }

  if(func_6B22() == 0) {
    return 1;
  }

  if(func_6B30()) {
    return 0;
  }

  if(func_6B35() && param_00) {
    return 0;
  }

  return 1;
}

func_6B38(param_00) {
  if(param_00) {
    self.disabled = 1;
    return;
  }

  self.disabled = undefined;
}

func_6B24(param_00, param_01) {
  if(isDefined(level.var_6B23[param_00])) {
    foreach(var_03 in level.var_6B23[param_00]) {
      var_03 func_6B38(param_01);
    }
  }
}

func_6B3B(param_00) {
  self.var_C951 = param_00;
}

func_6B1B() {
  self.var_C951 = undefined;
}

func_6B37(param_00) {
  self.var_C02F[self.var_C02F.size] = param_00;
}

func_6B2B(param_00) {
  if(self.var_C02F.size <= 0) {
    return 0;
  }

  foreach(var_02 in self.var_C02F) {
    if(var_02 == param_00) {
      return 1;
    }
  }

  return 0;
}

func_6B36(param_00) {
  var_01 = [];
  foreach(var_03 in self.var_C02F) {
    if(var_03 != param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  self.var_C02F = var_01;
}

func_6B1A() {
  self.var_C02F = [];
}

func_6B3C() {
  self.var_1366C = 0;
}

func_6B39() {
  self.var_1366C = 1;
}

func_6B3A() {
  self.var_1366C = 2;
}

func_6B35() {
  return self.var_1366C == 0;
}

func_6B2E() {
  return self.var_1366C == 1;
}

func_6B30() {
  return self.var_1366C == 2;
}

func_6B2F() {
  return isDefined(self.var_8625);
}

func_6B2C() {
  return isDefined(self.disabled);
}

func_6B33() {
  return self.var_ED8B == "turn";
}

func_6B32() {
  return self.var_ED8B == "traverse" && isDefined(self.var_126CD);
}

func_6B2A() {
  return self.var_ED8B == "animation";
}

func_6B19() {
  return !self.spawnimpulsefield & 128;
}

func_6B18() {
  return !self.spawnimpulsefield & 256;
}

func_6B1C() {}