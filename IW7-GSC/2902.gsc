/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2902.gsc
***************************************/

func_BE57(var_00, var_01, var_02) {
  setdvarifuninitialized("narrative_debug", 0);

  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(self)) {}

    if(!isDefined(var_02)) {
      var_02 = (0, 0, 0);
    }

    self endon("death");
    self endon("narrative_debug_stop");

    for(var_03 = 0; var_03 < var_01; var_3++) {
      scripts\engine\utility::waitframe();
    }
  }
}

func_BE56(var_00, var_01, var_02) {
  setdvarifuninitialized("narrative_debug", 0);

  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(self.origin)) {
      return;
    } else {
      var_03 = self.origin;
    }

    if(!isDefined(var_00)) {
      var_00 = 6;
    }

    if(!isDefined(var_01)) {
      var_01 = (1, 1, 1);
    }

    if(!isDefined(var_02)) {
      var_02 = 400;
    }
  }
}

func_BE55(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  setdvarifuninitialized("narrative_debug", 0);

  if(getdvarint("narrative_debug") == 1) {
    if(!isDefined(var_02)) {
      var_02 = (1, 1, 1);
    }

    if(!isDefined(var_03)) {
      var_03 = 1;
    }

    if(!isDefined(var_04)) {
      var_04 = 0;
    }

    if(!isDefined(var_05)) {
      var_05 = 200;
    }

    if(isDefined(var_06)) {
      if(isDefined(var_07)) {
        var_08 = 40;
        var_01 = self.origin + anglesToForward(self.angles) * var_08;
      } else
        var_08 = distance2d(var_00, var_01);

      var_09 = var_08 * 0.2;
      var_10 = var_08 * 0.5;
      var_11 = var_08 * 0.175;
      var_12 = var_00 - var_01;
      var_13 = var_01 + anglesToForward(vectortoangles(var_12)) * var_09;
      var_14 = var_01 + anglesToForward(vectortoangles(var_12)) * var_10;
    } else {}
  }
}

func_48A9() {
  if(isDefined(self.target) && isDefined(getent(self.target, "targetname"))) {
    var_00 = getent(self.target, "targetname");

    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "big_collision") {
      var_0.origin = self.origin;
      var_0.angles = self.angles;
      var_00 linkto(self);
      self.func_2AC1 = var_00;
    }
  }
}

func_DFCC() {
  if(isDefined(self.func_2AC1)) {
    self.func_2AC1 delete();
  }
}

func_196B(var_00, var_01, var_02, var_03) {
  self endon("death");
  var_02 = squared(var_02);
  var_01 = func_0EFB::func_7D7A(var_01);
  var_03 = func_0EFB::func_7D7A(var_03).origin;
  var_04 = distance2dsquared(self.origin, var_03);

  while(var_04 > var_02) {
    var_04 = distance2dsquared(self.origin, var_03);
    scripts\engine\utility::waitframe();
  }

  self thread[[var_00]](var_01);
}

func_194A(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");

  if(isDefined(var_06) && scripts\engine\utility::flag(var_06)) {
    return;
  }
  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  if(!isDefined(var_04)) {
    var_04 = 0.7;
  }

  thread func_1949(var_00);

  if(isDefined(var_01)) {
    wait(var_03);
    var_02 = func_0EFB::func_7D7A(var_02);

    if(isDefined(var_05)) {
      self thread[[var_01]](var_02, var_05);
      scripts\engine\utility::delaythread(var_05, scripts\sp\utility::func_77B9, 0.7);
    } else
      self thread[[var_01]](var_02);
  }

  self waittill("gesture_dialog_finished");
  scripts\sp\utility::func_77B9(var_04);
}

func_1961(var_00, var_01, var_02, var_03) {
  self endon("death");

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  thread func_1949(var_00);
  func_0C4C::func_1960(var_01);
  self waittill("gesture_dialog_finished");
}

func_1949(var_00) {
  self endon("death");
  scripts\sp\utility::func_10347(var_00);
  self notify("gesture_dialog_finished");
}

func_195C(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");

  if(!isDefined(var_01)) {
    var_01 = 4.0;
  }

  if(!isDefined(var_04)) {
    var_04 = 1.0;
  }

  if(!isDefined(var_02)) {
    var_02 = 0.25;
  }

  if(!isDefined(var_03)) {
    var_03 = 0.35;
  }

  var_00 = func_0EFB::func_7D7A(var_00);
  thread func_0C4C::func_1955(var_00, var_01, var_02);
  wait(var_04);
  func_0C4C::func_1964(var_03);
}

func_10348(var_00, var_01) {
  if(!scripts\engine\utility::flag(var_01)) {
    scripts\sp\utility::func_10347(var_00);
  }
}