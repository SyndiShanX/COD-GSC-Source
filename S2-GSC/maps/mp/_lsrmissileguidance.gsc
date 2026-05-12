/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_lsrmissileguidance.gsc
*********************************************/

func_631C() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  for(;;) {
    self waittill("missile_fire", var_00, var_01);
    if(issubstr(var_01, "maaws")) {
      if(!isDefined(self.var_5F39)) {
        self.var_5F39 = spawn("script_origin", self.var_0116);
        self.var_5F39.var_01A5 = "lsr_missile";
      }

      self.var_5F39 thread func_5F3A(var_00);
      var_00 thread func_5F38(self);
    }
  }
}

func_5F38(param_00) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("faux_spawn");
  for(;;) {
    if(param_00 playerads() > 0.3) {
      var_01 = anglesToForward(param_00 getangles());
      var_02 = param_00 getEye();
      var_03 = var_02 + var_01 * 15000;
      var_04 = bulletTrace(var_02, var_03, 1, param_00, 1, 0, 0, 0, 0);
      param_00.var_5F39.var_0116 = var_04["position"];
      self method_81D9(param_00.var_5F39);
    }

    wait 0.05;
  }
}

func_5F3A(param_00) {
  if(!isDefined(self.var_5F37)) {
    self.var_5F37 = 1;
  } else {
    self.var_5F37++;
  }

  param_00 waittill("death");
  self.var_5F37--;
  if(self.var_5F37 == 0) {
    self delete();
  }
}