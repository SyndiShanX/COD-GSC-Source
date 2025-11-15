/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2855.gsc
***************************************/

func_5F84(var_00) {
  self notify("disable_dynamic_move");
  self endon("disable_dynamic_move");

  if(isDefined(self.func_5F76))
    var_01 = squared(self.func_5F76);
  else if(isDefined(var_00))
    var_01 = squared(var_00);
  else
    var_01 = squared(300);

  self.func_51E4 = undefined;
  scripts\sp\utility::func_4145();
  func_F491("sprint_loop", "sprint_super");

  for(;;) {
    var_02 = vectornormalize(level.player.origin - self.origin);
    var_03 = anglesToForward(self.angles);
    var_04 = vectordot(var_03, var_02);
    var_05 = distance2dsquared(level.player.origin, self.origin);

    if(var_04 < 0) {
      if(var_05 > var_01) {
        if(!isDefined(self.demeanoroverride) || isDefined(self.demeanoroverride) && self.demeanoroverride == "sprint") {
          scripts\sp\utility::func_4145();

          if(isDefined(self.func_51E4))
            scripts\sp\utility::func_51E1(self.func_51E4);
        }
      } else if(!isDefined(self.demeanoroverride) || isDefined(self.demeanoroverride) && self.demeanoroverride != "sprint") {
        self.func_51E4 = self.demeanoroverride;
        scripts\sp\utility::func_51E1("sprint");
      }
    } else if(!isDefined(self.demeanoroverride) || isDefined(self.demeanoroverride) && self.demeanoroverride != "sprint") {
      self.func_51E4 = self.demeanoroverride;
      scripts\sp\utility::func_51E1("sprint");
    }

    wait 0.05;
  }
}

func_5557() {
  self notify("disable_dynamic_move");

  if(isDefined(self.func_51E4))
    scripts\sp\utility::func_51E1(self.func_51E4);
  else
    scripts\sp\utility::func_4145();

  self.func_51E4 = undefined;
  scripts\sp\utility::func_4169("sprint");
}

func_F491(var_00, var_01) {
  if(!scripts\asm\asm::asm_hasalias(var_00, var_01)) {
    return;
  }
  var_02 = scripts\asm\asm::asm_lookupanimfromalias(var_00, var_01);
  scripts\asm\asm::asm_setdemeanoranimoverride("sprint", "move", var_02);
}