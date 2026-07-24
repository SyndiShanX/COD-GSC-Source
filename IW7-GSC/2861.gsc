/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2861.gsc
**************************************/

_id_6B3D() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  if(self._id_ED8B == "path" || self._id_ED8B == "turn") {
    self._id_1366C = 2;
  } else {
    self._id_1366C = 0;
  }

  switch (self._id_ED8B) {
    case "traverse":
      if(isDefined(self.target)) {
        var_0 = getnodearray(self.target, "targetname");

        if(!var_0.size) {
          if(isDefined(self.script_linkto)) {
            var_0 = getnodearray(self.script_linkto, "script_linkname");
          }
        }

        if(var_0.size > 0) {
          foreach(var_2 in var_0) {
            if(var_2.type == "Begin") {
              self._id_126CD = var_2.animscript;
            }
          }
        }

        var_4 = scripts\engine\utility::getStructArray(self.target, "targetname");

        if(isDefined(self.script_linkto)) {
          var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getStructArray(self.script_linkto, "script_linkname"));
        }

        foreach(var_6 in var_4) {
          if(isDefined(var_6.animation)) {
            self.origin = var_6.origin;
            self.angles = var_6.angles;
          }
        }
      }

      break;
    case "animation":
      break;
  }

  _id_6B29();
  _id_6B28();
  _id_6B27();
  scripts\engine\utility::waitframe();

  switch (self._id_ED8B) {
    case "animation":
      self._id_1EEF = spawnStruct();
      self._id_1EEF.origin = self.origin;
      self._id_1EEF.angles = self.angles;
      var_8 = scripts\sp\utility::_id_7DC3(self.animation);
      var_9 = getstartorigin(self.origin, self.angles, var_8);
      var_10 = getstartangles(self.origin, self.angles, var_8);
      self.origin = var_9;
      self.angles = var_10;
      break;
  }
}

_id_6B29() {
  switch (self._id_ED8B) {
    case "cover_left":
      self.type = "Cover Left";
      return;
    case "cover_right":
      self.type = "Cover Right";
      return;
    case "cover_crouch":
      self.type = "Cover Crouch";
      return;
    case "cover_stand":
      self.type = "Cover Stand";
      return;
  }
}

_id_6B28() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  var_0 = strtok(self.script_parameters, " ");

  foreach(var_2 in var_0) {
    if(!isDefined(level._id_6B23[var_2])) {
      level._id_6B23[var_2] = [];
    }

    level._id_6B23[var_2] = ::scripts\engine\utility::array_add(level._id_6B23[var_2], self);
  }
}

_id_6B27() {
  if(!isDefined(self.spawnflags)) {
    self.spawnflags = 0;
  }

  if(!(self.spawnflags & 64)) {
    var_0 = 32 * anglestoup(self.angles);
    var_1 = -20000 * anglestoup(self.angles);
    var_2 = scripts\common\trace::ray_trace(self.origin + var_0, self.origin + var_1, undefined, scripts\common\trace::create_solid_ai_contents());

    if(var_2["hittype"] == "hittype_none") {}

    self.origin = var_2["position"];

    if(self.spawnflags & 32) {
      if(isDefined(var_2["entity"])) {
        self._id_8625 = var_2["entity"];
        self._id_862A = self._id_8625 scripts\sp\utility::_id_13DCC(self.origin);

        if(!isDefined(self.angles)) {
          self.angles = (0, 0, 0);
        }

        self._id_8627 = self.angles - self._id_8625.angles;
      }
    }
  }

  if(self.spawnflags & 8) {
    _id_6B38(1);
  }

  if(self.spawnflags & 16) {
    self._id_1366C = 2;
  }

  self._id_C02F = [];
}

_id_F97C() {
  level._id_6B23 = [];

  foreach(var_1 in level.struct) {
    if(isDefined(var_1._id_ED8B)) {
      var_1 thread _id_6B3D();
    }
  }
}

_id_9BE0() {
  return isDefined(self._id_ED8B);
}

_id_6B3E() {
  if(!isDefined(self._id_8625)) {
    return;
  }
  self.origin = self._id_8625 localtoworldcoords(self._id_862A);
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.angles = self._id_8625.angles;
  var_0 addpitch(self._id_8627[0]);
  var_0 addyaw(self._id_8627[1]);
  var_0 addroll(self._id_8627[2]);
  self.angles = var_0.angles;
  var_0 delete();
}

_id_6B1F() {
  var_0 = [];
  var_1 = 0;

  if(isDefined(self.spawnflags)) {
    var_1 = self.spawnflags;
  }

  if(self._id_ED8B == "cover_left") {
    if(!(var_1 & 1)) {
      var_0 = scripts\engine\utility::array_add(var_0, "cover_left");
    }

    if(!(var_1 & 2)) {
      var_0 = scripts\engine\utility::array_add(var_0, "cover_left_crouch");
    }
  } else if(self._id_ED8B == "cover_right") {
    if(!(var_1 & 1)) {
      var_0 = scripts\engine\utility::array_add(var_0, "cover_right");
    }

    if(!(var_1 & 2)) {
      var_0 = scripts\engine\utility::array_add(var_0, "cover_right_crouch");
    }
  } else if(self._id_ED8B == "cover_stand")
    var_0 = scripts\engine\utility::array_add(var_0, "cover_stand");
  else if(self._id_ED8B == "cover_crouch") {
    var_0 = scripts\engine\utility::array_add(var_0, "cover_crouch");
  } else {
    var_0 = scripts\engine\utility::array_add(var_0, "exposed");
  }

  if(var_0.size == 0) {}

  return var_0;
}

_id_6B20() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  var_0 = _id_6B1D();

  if(var_0.size) {
    return scripts\engine\utility::random(var_0);
  }

  return undefined;
}

_id_6B1D() {
  var_0 = [];

  if(!isDefined(self.target)) {
    return var_0;
  }

  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(!var_3 _id_9BE0()) {
      continue;
    }
    if(!var_3 _id_6B34()) {
      continue;
    }
    var_0 = scripts\engine\utility::array_add(var_0, var_3);
  }

  return var_0;
}

_id_6B22() {
  if(!isDefined(self.target)) {
    return 0;
  }

  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(!var_3 _id_9BE0()) {
      continue;
    }
    if(!var_3 _id_6B34()) {
      continue;
    }
    var_1++;
  }

  return var_1;
}

_id_6B1E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = spawn("script_origin", (0, 0, 0));

  if(isDefined(self.angles)) {
    var_1.angles = self.angles;
  }

  if(isDefined(self.type)) {
    if(var_0 && isDefined(anim._id_6A63)) {
      if(isDefined(anim._id_6A63[self.type])) {
        var_1 addyaw(anim._id_6A63[self.type]);
      }
    } else if(isDefined(anim._id_6A64)) {
      if(isDefined(anim._id_6A64[self.type])) {
        var_1 addyaw(anim._id_6A64[self.type]);
      }
    }
  }

  var_2 = var_1.angles;
  var_1 delete();
  return var_2;
}

_id_6B21(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0]["origin"] = var_1;
  var_4[0]["dist"] = 0;
  var_4[0]["radius"] = 0;
  var_4[0]["node"] = undefined;
  var_4[0]["total_dist"] = 0;
  var_5 = 1;
  var_6 = 200;

  for(;;) {
    var_7 = var_4.size;
    var_8 = undefined;

    if(var_5) {
      var_8 = var_0;
      var_5 = 0;
    } else
      var_8 = var_4[var_7 - 1]["node"] _id_6B20();

    if(!isDefined(var_8)) {
      break;
    }

    var_4[var_7]["node"] = var_8;
    var_9 = var_8.origin;

    if(isDefined(var_8.radius)) {
      if(!isDefined(self._id_5CC2)) {
        self._id_5CC2 = -1 + randomfloat(2);
      }

      if(!isDefined(var_8.angles)) {
        var_8.angles = (0, 0, 0);
      }

      var_10 = anglesToForward(var_8.angles);
      var_11 = anglestoright(var_8.angles);
      var_12 = anglestoup(var_8.angles);
      var_13 = (0, self._id_5CC2 * var_8.radius, 0);
      var_9 = var_9 + var_10 * var_13[0];
      var_9 = var_9 + var_11 * var_13[1];
      var_9 = var_9 + var_12 * var_13[2];
    }

    var_4[var_7]["origin"] = var_9;
    var_4[var_7]["angles"] = var_8 _id_6B1E(var_2);

    if(var_7 > 0) {
      var_14 = var_9 - var_4[var_7 - 1]["origin"];
      var_4[var_7 - 1]["dist"] = length(var_14);
      var_4[0]["total_dist"] = var_4[0]["total_dist"] + var_4[var_7 - 1]["dist"];
      var_4[var_7 - 1]["to_next_node"] = vectorNormalize(var_14);

      if(isDefined(var_8.radius)) {
        var_4[var_7 - 1]["radius"] = var_8.radius;
      } else {
        var_4[var_7 - 1]["radius"] = var_6;
      }
    }

    var_15 = var_3 && var_7 == 1;

    if(var_8 _id_6B2D(var_15)) {
      break;
    }
  }

  var_4[var_7]["dist"] = 0;
  var_4[var_7]["radius"] = 0;
  var_4[var_7]["to_next_node"] = var_4[var_7 - 1]["to_next_node"];
  return var_4;
}

_id_6B34() {
  if(isDefined(self.disabled)) {
    return 0;
  }

  return 1;
}

_id_6B2D(var_0) {
  if(_id_6B2A() && !var_0) {
    return 1;
  }

  if(_id_6B32() && !var_0) {
    return 1;
  }

  if(_id_6B33() && !var_0) {
    return 1;
  }

  if(_id_6B22() == 0) {
    return 1;
  }

  if(_id_6B30()) {
    return 0;
  }

  if(_id_6B35() && var_0) {
    return 0;
  }

  return 1;
}

_id_6B38(var_0) {
  if(var_0) {
    self.disabled = 1;
  } else {
    self.disabled = undefined;
  }
}

_id_6B24(var_0, var_1) {
  if(isDefined(level._id_6B23[var_0])) {
    foreach(var_3 in level._id_6B23[var_0]) {
      var_3 _id_6B38(var_1);
    }
  }
}

_id_6B3B(var_0) {
  self._id_C951 = var_0;
}

_id_6B1B() {
  self._id_C951 = undefined;
}

_id_6B37(var_0) {
  self._id_C02F[self._id_C02F.size] = var_0;
}

_id_6B2B(var_0) {
  if(self._id_C02F.size <= 0) {
    return 0;
  }

  foreach(var_2 in self._id_C02F) {
    if(var_2 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_6B36(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_C02F) {
    if(var_3 != var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  self._id_C02F = var_1;
}

_id_6B1A() {
  self._id_C02F = [];
}

_id_6B3C() {
  self._id_1366C = 0;
}

_id_6B39() {
  self._id_1366C = 1;
}

_id_6B3A() {
  self._id_1366C = 2;
}

_id_6B35() {
  return self._id_1366C == 0;
}

_id_6B2E() {
  return self._id_1366C == 1;
}

_id_6B30() {
  return self._id_1366C == 2;
}

_id_6B2F() {
  return isDefined(self._id_8625);
}

_id_6B2C() {
  return isDefined(self.disabled);
}

_id_6B33() {
  return self._id_ED8B == "turn";
}

_id_6B32() {
  return self._id_ED8B == "traverse" && isDefined(self._id_126CD);
}

_id_6B2A() {
  return self._id_ED8B == "animation";
}

_id_6B19() {
  return !(self.spawnflags & 128);
}

_id_6B18() {
  return !(self.spawnflags & 256);
}

_id_6B1C() {}