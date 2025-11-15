/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\narrative.gsc
************************************/

func_BE57(param_00, param_01, param_02) {
  setdvarifuninitialized("narrative_debug", 0);
  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(self)) {}

    if(!isDefined(param_02)) {
      param_02 = (0, 0, 0);
    }

    self endon("death");
    self endon("narrative_debug_stop");
    for(var_03 = 0; var_03 < param_01; var_03++) {
      scripts\engine\utility::waitframe();
    }
  }
}

func_BE56(param_00, param_01, param_02) {
  setdvarifuninitialized("narrative_debug", 0);
  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(self.origin)) {
      return;
    } else {
      var_03 = self.origin;
    }

    if(!isDefined(param_00)) {
      param_00 = 6;
    }

    if(!isDefined(param_01)) {
      param_01 = (1, 1, 1);
    }

    if(!isDefined(param_02)) {
      param_02 = 400;
    }
  }
}

func_BE55(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  setdvarifuninitialized("narrative_debug", 0);
  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(param_02)) {
      param_02 = (1, 1, 1);
    }

    if(!isDefined(param_03)) {
      param_03 = 1;
    }

    if(!isDefined(param_04)) {
      param_04 = 0;
    }

    if(!isDefined(param_05)) {
      param_05 = 200;
    }

    if(isDefined(param_06)) {
      if(isDefined(param_07)) {
        var_08 = 40;
        param_01 = self.origin + anglesToForward(self.angles) * var_08;
      } else {
        var_08 = distance2d(param_01, param_02);
      }

      var_09 = var_08 * 0.2;
      var_0A = var_08 * 0.5;
      var_0B = var_08 * 0.175;
      var_0C = param_00 - param_01;
      var_0D = param_01 + anglesToForward(vectortoangles(var_0C)) * var_09;
      var_0E = param_01 + anglesToForward(vectortoangles(var_0C)) * var_0A;
      return;
    }
  }
}

func_48A9() {
  if(isDefined(self.target) && isDefined(getent(self.target, "targetname"))) {
    var_00 = getent(self.target, "targetname");
    if(isDefined(var_00.script_parameters) && var_00.script_parameters == "big_collision") {
      var_00.origin = self.origin;
      var_00.angles = self.angles;
      var_00 linkto(self);
      self.var_2AC1 = var_00;
    }
  }
}

func_DFCC() {
  if(isDefined(self.var_2AC1)) {
    self.var_2AC1 delete();
  }
}

func_196B(param_00, param_01, param_02, param_03) {
  self endon("death");
  param_02 = squared(param_02);
  param_01 = lib_0EFB::func_7D7A(param_01);
  param_03 = lib_0EFB::func_7D7A(param_03).origin;
  var_04 = distance2dsquared(self.origin, param_03);
  while(var_04 > param_02) {
    var_04 = distance2dsquared(self.origin, param_03);
    scripts\engine\utility::waitframe();
  }

  self thread[[param_00]](param_01);
}

func_194A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  if(isDefined(param_06) && scripts\engine\utility::flag(param_06)) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_04)) {
    param_04 = 0.7;
  }

  thread func_1949(param_00);
  if(isDefined(param_01)) {
    wait(param_03);
    param_02 = lib_0EFB::func_7D7A(param_02);
    if(isDefined(param_05)) {
      self thread[[param_01]](param_02, param_05);
      scripts\engine\utility::delaythread(param_05, ::scripts\sp\utility::func_77B9, 0.7);
    } else {
      self thread[[param_01]](param_02);
    }
  }

  self waittill("gesture_dialog_finished");
  scripts\sp\utility::func_77B9(param_04);
}

func_1961(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  thread func_1949(param_00);
  lib_0C4C::func_1960(param_01);
  self waittill("gesture_dialog_finished");
}

func_1949(param_00) {
  self endon("death");
  scripts\sp\utility::func_10347(param_00);
  self notify("gesture_dialog_finished");
}

func_195C(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  if(!isDefined(param_01)) {
    param_01 = 4;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 0.25;
  }

  if(!isDefined(param_03)) {
    param_03 = 0.35;
  }

  param_00 = lib_0EFB::func_7D7A(param_00);
  thread lib_0C4C::func_1955(param_00, param_01, param_02);
  wait(param_04);
  lib_0C4C::func_1964(param_03);
}

func_10348(param_00, param_01) {
  if(!scripts\engine\utility::flag(param_01)) {
    scripts\sp\utility::func_10347(param_00);
  }
}