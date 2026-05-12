/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_fx.gsc
*********************************************/

func_8274() {
  if(!isDefined(self.var_81BB) || !isDefined(self.var_81BA) || !isDefined(self.var_0161)) {
    self delete();
    return;
  }

  if(isDefined(self.var_01A2)) {
    var_00 = getent(self.var_01A2).var_0116;
  } else {
    var_00 = "undefined";
  }

  if(self.var_81BA == "OneShotfx") {}

  if(self.var_81BA == "loopfx") {}

  if(self.var_81BA == "loopsound") {}
}

func_4866(param_00) {
  playFX(level.var_0611["mechanical explosion"], param_00);
  earthquake(0.15, 0.5, param_00, 250);
}

func_8F42(param_00, param_01, param_02) {
  var_03 = spawn("script_origin", (0, 0, 0));
  var_03.var_0116 = param_01;
  var_03 method_861D(param_00);
  if(isDefined(param_02)) {
    var_03 thread func_8F43(param_02);
  }
}

func_8F43(param_00) {
  level waittill(param_00);
  self delete();
}

func_1797(param_00) {
  self waittill("death");
  param_00 delete();
}