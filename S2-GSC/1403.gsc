/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1403.gsc
*********************************************/

lib_057B::func_00D5() {
  level.var_1EB9 = 20;
  level.var_5A61["zm_camouflage"] = ::lib_057B::func_9E3E;
}

lib_057B::func_9E3E(param_00, param_01) {
  thread lib_057B::func_73BA();
  return 1;
}

lib_057B::func_73BA(param_00) {
  if(!isDefined(param_00)) {
    param_00 = level.var_1EB9;
  }

  var_01 = int(gettime() + param_00 * 1000);
  if(isDefined(self.var_2747) && self.var_2747) {
    var_02 = self getclientomnvar("ui_zm_camo");
    if(var_02 >= var_01) {
      return;
    }
  }

  self notify("playerCamouflageMode");
  if(!isDefined(self.var_2747)) {
    self.var_2747 = 0;
  }

  self method_8615("zmb_ss_camo_use");
  self.var_2747++;
  lib_0547::func_8A6D(1);
  self setclientomnvar("ui_zm_camo", var_01);
  lib_057B::func_73BB(param_00);
  if(isDefined(self)) {
    lib_0547::func_8A6D(0);
    self.var_2747--;
  }
}

lib_057B::func_73BB(param_00) {
  self endon("playerCamouflageMode");
  wait(param_00);
}