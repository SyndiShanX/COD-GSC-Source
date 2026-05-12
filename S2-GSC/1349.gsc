/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1349.gsc
*********************************************/

lib_0545::func_00D5() {
  if(!isDefined(level.var_954F)) {
    level.var_954F = [];
  }

  if(!isDefined(level.var_954E)) {
    level.var_954E = [];
  }

  if(!isDefined(level.var_9550)) {
    level.var_9550 = [];
  }

  var_00 = common_scripts\utility::func_46B7("switch", "targetname");
  common_scripts\utility::func_0FB2(var_00, ::lib_0545::func_955B);
}

lib_0545::func_9557(param_00, param_01) {
  level.var_954F[param_00] = param_01;
}

lib_0545::func_9556(param_00, param_01) {
  level.var_954E[param_00] = param_01;
}

lib_0545::func_9558(param_00, param_01) {
  level.var_9550[param_00] = param_01;
}

lib_0545::func_955B() {
  self.var_8BC8 = [];
  self.var_4CE1 = [];
  self.var_8BCC = [];
  self.var_4CE5 = [];
  var_00 = getEntArray(self.var_01A2, "targetname");
  foreach(var_02 in var_00) {
    lib_0545::func_954A(var_02);
  }

  var_04 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
  foreach(var_06 in var_04) {
    lib_0545::func_955A(var_06);
  }

  common_scripts\utility::func_3799("needs_update");
  if(!common_scripts\utility::func_3C83(self.var_819A)) {
    common_scripts\utility::func_3C87(self.var_819A);
  }

  waittillframeend;
  thread lib_0545::func_9560(self.var_819A);
  if(isDefined(self.var_81A1)) {
    self.var_81A2 = strtok(self.var_81A1, " ");
    foreach(var_09 in self.var_81A2) {
      thread lib_0545::func_9560(var_09);
    }
  }

  if(isDefined(self.var_819E)) {
    self.var_819F = strtok(self.var_819E, " ");
    foreach(var_09 in self.var_819F) {
      thread lib_0545::func_9560(var_09);
    }
  }

  thread lib_0545::func_9561();
  common_scripts\utility::func_379A("needs_update");
  for(;;) {
    common_scripts\utility::func_379C("needs_update");
    lib_0545::func_955F();
  }
}

lib_0545::func_954A(param_00) {
  var_01 = param_00.var_0165;
  if(!isDefined(var_01)) {
    switch (param_00.var_003A) {
      case "script_model":
        var_01 = "anim_model";
        break;

      case "trigger_use":
      case "trigger_use_touch":
        var_01 = "trigger";
        break;

      default:
        var_01 = "undefined";
        break;
    }
  }

  switch (var_01) {
    case "trigger":
      self.var_9D65 = param_00;
      param_00.var_9555 = self;
      break;

    case "anim_model":
      self.var_6298 = param_00;
      if(isDefined(self.var_6298.var_8109)) {
        var_02 = strtok(self.var_6298.var_8109, ",");
        self.var_6298.var_504F = var_02[0];
        self.var_6298.var_9E90 = var_02[1];
        self.var_6298.var_5051 = var_02[2];
        self.var_6298.var_9E87 = var_02[3];
      }
      break;

    case "show":
      self.var_8BF7[self.var_8BF7.size] = param_00;
      break;

    case "hide":
      self.var_4D07[self.var_4D07.size] = param_00;
      break;

    default:
      break;
  }
}

lib_0545::func_955A(param_00) {
  var_01 = param_00.var_0165;
  switch (var_01) {
    case "indicator_light_on_fx":
      self.var_8BCC[self.var_8BCC.size] = param_00;
      lib_0545::func_954C(param_00);
      break;

    case "indicator_light_off_fx":
      self.var_4CE5[self.var_4CE5.size] = param_00;
      lib_0545::func_954C(param_00);
      break;
  }
}

lib_0545::func_9561() {
  if(!isDefined(self.var_9D65)) {
    return;
  }

  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    if(lib_0545::func_9551()) {
      if(lib_0545::func_9552()) {
        if(lib_0545::func_9547()) {
          common_scripts\utility::func_3C7B(self.var_819A);
          common_scripts\utility::func_379A("needs_update");
        }

        continue;
      }

      common_scripts\utility::func_3C8F(self.var_819A);
      common_scripts\utility::func_379A("needs_update");
    }
  }
}

lib_0545::func_9560(param_00) {
  for(;;) {
    common_scripts\utility::func_3C9F(param_00);
    common_scripts\utility::func_379A("needs_update");
    common_scripts\utility::func_3CA9(param_00);
    common_scripts\utility::func_379A("needs_update");
  }
}

lib_0545::func_9551() {
  return !isDefined(lib_0545::func_7AC7());
}

lib_0545::func_7AC7() {
  if(isDefined(self.var_81A2)) {
    foreach(var_01 in self.var_81A2) {
      if(!common_scripts\utility::func_3C77(var_01)) {
        return var_01;
      }
    }
  }

  if(isDefined(self.var_819F)) {
    foreach(var_01 in self.var_819F) {
      if(common_scripts\utility::func_3C77(var_01)) {
        return var_01;
      }
    }
  }

  return undefined;
}

lib_0545::func_9552() {
  return common_scripts\utility::func_3C77(self.var_819A);
}

lib_0545::func_9547() {
  return lib_0545::func_9551() && lib_0545::func_9552() && isDefined(level.var_954E[self.var_819A]);
}

lib_0545::func_955F() {
  if(isDefined(self.var_9D65)) {
    if(lib_0545::func_9551()) {
      if(lib_0545::func_9552()) {
        var_00 = level.var_954E[self.var_819A];
      } else {
        var_00 = level.var_954F[self.var_819A];
      }
    } else if(!lib_0545::func_9552() || lib_0545::func_9547()) {
      var_00 = level.var_9550[lib_0545::func_7AC7()];
    } else {
      var_00 = undefined;
    }

    if(isDefined(var_00)) {
      self.var_9D65 sethintstring(var_00);
      self.var_9D65 makeusable();
    } else {
      self.var_9D65 makeunusable();
    }
  }

  if(lib_0545::func_9552()) {
    foreach(var_02 in self.var_8BCC) {
      lib_0545::func_954D(var_02);
    }

    foreach(var_05 in self.var_8BC8) {
      var_05 method_805B();
    }

    foreach(var_02 in self.var_4CE5) {
      thread lib_0545::func_954B(var_02);
    }

    foreach(var_05 in self.var_4CE1) {
      var_05 method_805C();
    }
  } else {
    foreach(var_02 in self.var_4CE5) {
      lib_0545::func_954D(var_02);
    }

    foreach(var_05 in self.var_4CE1) {
      var_05 method_805B();
    }

    foreach(var_02 in self.var_8BCC) {
      thread lib_0545::func_954B(var_02);
    }

    foreach(var_05 in self.var_8BC8) {
      var_05 method_805C();
    }
  }

  if(isDefined(self.var_6298)) {
    if(isDefined(self.var_9546) && self.var_9546 != lib_0545::func_9552()) {
      if(lib_0545::func_9552()) {
        var_13 = self.var_6298.var_9E90;
      } else {
        var_13 = self.var_6298.var_9E87;
      }

      if(isDefined(var_13)) {
        self.var_6298 scriptmodelplayanim(var_13, "switch_transition_anim");
        self.var_6298 waittillmatch("end", "switch_transition_anim");
      }

      self.var_9546 = undefined;
    }

    if(!isDefined(self.var_9546) || self.var_9546 != lib_0545::func_9552()) {
      if(lib_0545::func_9552()) {
        var_13 = self.var_6298.var_5051;
      } else {
        var_13 = self.var_6298.var_504F;
      }

      self.var_6298 scriptmodelplayanim(var_13);
      self.var_9546 = lib_0545::func_9552();
    }
  }

  common_scripts\utility::func_3796("needs_update");
}

lib_0545::func_954C(param_00) {
  if(!isDefined(level.var_0611[param_00.var_81BB])) {
    level.var_0611[param_00.var_81BB] = loadfx(param_00.var_81BB);
  }
}

lib_0545::func_954D(param_00) {
  if(isDefined(param_00.var_3F3F)) {
    return;
  }

  if(isDefined(param_00.var_81C7)) {
    param_00.var_5DA5 = spawn("script_model", param_00.var_0116);
    param_00.var_5DA5.var_001D = param_00.var_001D;
    param_00.var_5DA5 setModel("tag_origin");
    param_00.var_5DA5 linkto(self.var_6298, param_00.var_81C7);
    param_00.var_3F3F = spawnlinkedfx(common_scripts\utility::func_44F5(param_00.var_81BB), param_00.var_5DA5, "tag_origin");
  } else {
    param_00.var_3F3F = spawnfx(common_scripts\utility::func_44F5(param_00.var_81BB), param_00.var_0116, anglesToForward(param_00.var_001D), anglestoup(param_00.var_001D));
  }

  if(gettime() < 500) {
    triggerfx(param_00.var_3F3F, 0.5);
    return;
  }

  triggerfx(param_00.var_3F3F);
}

lib_0545::func_954B(param_00) {
  wait 0.05;
  if(isDefined(param_00.var_5DA5)) {
    param_00.var_5DA5 delete();
  }

  if(isDefined(param_00.var_3F3F)) {
    param_00.var_3F3F delete();
  }
}