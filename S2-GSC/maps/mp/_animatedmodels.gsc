/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_animatedmodels.gsc
*********************************************/

func_00F9() {
  if(!isDefined(level.var_0E2F)) {
    level.var_0E2F = [];
  }

  var_00 = getarraykeys(level.var_0E2F);
  foreach(var_02 in var_00) {
    var_03 = getarraykeys(level.var_0E2F[var_02]);
    foreach(var_05 in var_03) {
      precachempanim(level.var_0E2F[var_02][var_05]);
    }
  }

  waittillframeend;
  level.var_515E = [];
  var_08 = getEntArray("animated_model", "targetname");
  common_scripts\utility::func_0FB2(var_08, ::func_0E9F);
  level.var_515E = undefined;
}

func_0E9F() {
  if(isDefined(self.var_0EA4)) {
    var_00 = self.var_0EA4;
  } else {
    var_01 = getarraykeys(level.var_0E2F[self.var_0106]);
    var_02 = var_01[randomint(var_01.size)];
    var_00 = level.var_0E2F[self.var_0106][var_02];
  }

  self scriptmodelplayanim(var_00);
  self method_80D4();
}