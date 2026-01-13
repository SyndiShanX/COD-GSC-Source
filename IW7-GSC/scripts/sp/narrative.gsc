/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\narrative.gsc
*********************************************/

func_BE57(var_0, var_1, var_2) {
  setdvarifuninitialized("narrative_debug", 0);
  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(self)) {}

    if(!isDefined(var_2)) {
      var_2 = (0, 0, 0);
    }

    self endon("death");
    self endon("narrative_debug_stop");
    for(var_3 = 0; var_3 < var_1; var_3++) {
      scripts\engine\utility::waitframe();
    }
  }
}

func_BE56(var_0, var_1, var_2) {
  setdvarifuninitialized("narrative_debug", 0);
  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(self.origin)) {
      return;
    } else {
      var_3 = self.origin;
    }

    if(!isDefined(var_0)) {
      var_0 = 6;
    }

    if(!isDefined(var_1)) {
      var_1 = (1, 1, 1);
    }

    if(!isDefined(var_2)) {
      var_2 = 400;
    }
  }
}

func_BE55(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  setdvarifuninitialized("narrative_debug", 0);
  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(var_2)) {
      var_2 = (1, 1, 1);
    }

    if(!isDefined(var_3)) {
      var_3 = 1;
    }

    if(!isDefined(var_4)) {
      var_4 = 0;
    }

    if(!isDefined(var_5)) {
      var_5 = 200;
    }

    if(isDefined(var_6)) {
      if(isDefined(var_7)) {
        var_8 = 40;
        var_1 = self.origin + anglesToForward(self.angles) * var_8;
      } else {
        var_8 = distance2d(var_1, var_2);
      }

      var_9 = var_8 * 0.2;
      var_0A = var_8 * 0.5;
      var_0B = var_8 * 0.175;
      var_0C = var_0 - var_1;
      var_0D = var_1 + anglesToForward(vectortoangles(var_0C)) * var_9;
      var_0E = var_1 + anglesToForward(vectortoangles(var_0C)) * var_0A;
      return;
    }
  }
}

func_48A9() {
  if(isDefined(self.target) && isDefined(getent(self.target, "targetname"))) {
    var_0 = getent(self.target, "targetname");
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "big_collision") {
      var_0.origin = self.origin;
      var_0.angles = self.angles;
      var_0 linkto(self);
      self.var_2AC1 = var_0;
    }
  }
}

func_DFCC() {
  if(isDefined(self.var_2AC1)) {
    self.var_2AC1 delete();
  }
}

func_196B(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_2 = squared(var_2);
  var_1 = lib_0EFB::func_7D7A(var_1);
  var_3 = lib_0EFB::func_7D7A(var_3).origin;
  var_4 = distance2dsquared(self.origin, var_3);
  while(var_4 > var_2) {
    var_4 = distance2dsquared(self.origin, var_3);
    scripts\engine\utility::waitframe();
  }

  self thread[[var_0]](var_1);
}

func_194A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  if(isDefined(var_6) && scripts\engine\utility::flag(var_6)) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.7;
  }

  thread func_1949(var_0);
  if(isDefined(var_1)) {
    wait(var_3);
    var_2 = lib_0EFB::func_7D7A(var_2);
    if(isDefined(var_5)) {
      self thread[[var_1]](var_2, var_5);
      scripts\engine\utility::delaythread(var_5, ::scripts\sp\utility::func_77B9, 0.7);
    } else {
      self thread[[var_1]](var_2);
    }
  }

  self waittill("gesture_dialog_finished");
  scripts\sp\utility::func_77B9(var_4);
}

func_1961(var_0, var_1, var_2, var_3) {
  self endon("death");
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  thread func_1949(var_0);
  lib_0C4C::func_1960(var_1);
  self waittill("gesture_dialog_finished");
}

func_1949(var_0) {
  self endon("death");
  scripts\sp\utility::func_10347(var_0);
  self notify("gesture_dialog_finished");
}

func_195C(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.25;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.35;
  }

  var_0 = lib_0EFB::func_7D7A(var_0);
  thread lib_0C4C::func_1955(var_0, var_1, var_2);
  wait(var_4);
  lib_0C4C::func_1964(var_3);
}

func_10348(var_0, var_1) {
  if(!scripts\engine\utility::flag(var_1)) {
    scripts\sp\utility::func_10347(var_0);
  }
}