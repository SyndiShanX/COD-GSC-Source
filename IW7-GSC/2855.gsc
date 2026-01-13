/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2855.gsc
***************************************/

func_5F84(var_0) {
  self notify("disable_dynamic_move");
  self endon("disable_dynamic_move");

  if(isDefined(self.var_5F76)) {
    var_1 = squared(self.var_5F76);
  } else if(isDefined(var_0)) {
    var_1 = squared(var_0);
  } else {
    var_1 = squared(300);
  }

  self.var_51E4 = undefined;
  scripts\sp\utility::func_4145();
  func_F491("sprint_loop", "sprint_super");

  for(;;) {
    var_2 = vectornormalize(level.player.origin - self.origin);
    var_3 = anglesToForward(self.angles);
    var_4 = vectordot(var_3, var_2);
    var_5 = distance2dsquared(level.player.origin, self.origin);

    if(var_4 < 0) {
      if(var_5 > var_1) {
        if(!isDefined(self.demeanoroverride) || isDefined(self.demeanoroverride) && self.demeanoroverride == "sprint") {
          scripts\sp\utility::func_4145();

          if(isDefined(self.var_51E4)) {
            scripts\sp\utility::func_51E1(self.var_51E4);
          }
        }
      } else if(!isDefined(self.demeanoroverride) || isDefined(self.demeanoroverride) && self.demeanoroverride != "sprint") {
        self.var_51E4 = self.demeanoroverride;
        scripts\sp\utility::func_51E1("sprint");
      }
    } else if(!isDefined(self.demeanoroverride) || isDefined(self.demeanoroverride) && self.demeanoroverride != "sprint") {
      self.var_51E4 = self.demeanoroverride;
      scripts\sp\utility::func_51E1("sprint");
    }

    wait 0.05;
  }
}

func_5557() {
  self notify("disable_dynamic_move");

  if(isDefined(self.var_51E4)) {
    scripts\sp\utility::func_51E1(self.var_51E4);
  } else {
    scripts\sp\utility::func_4145();
  }

  self.var_51E4 = undefined;
  scripts\sp\utility::func_4169("sprint");
}

func_F491(var_0, var_1) {
  if(!scripts\asm\asm::asm_hasalias(var_0, var_1)) {
    return;
  }
  var_2 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_1);
  scripts\asm\asm::asm_setdemeanoranimoverride("sprint", "move", var_2);
}