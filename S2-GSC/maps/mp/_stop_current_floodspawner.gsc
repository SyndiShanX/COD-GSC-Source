/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_stop_current_floodspawner.gsc
**************************************************/

func_9DB1(param_00, param_01) {
  param_00 endon("death");
  param_00 waittill("trigger", var_02);
  param_00 common_scripts\utility::func_0161();
  maps\mp\_utility::func_0FA8(param_00.var_01A2);
  if(isDefined(param_01)) {
    common_scripts\utility::func_3C8F(param_01, var_02);
  }
}

func_9D7C(param_00) {
  param_00 endon("death");
  param_00 waittill("trigger");
  param_00 common_scripts\utility::func_0161();
  var_01 = getEntArray(param_00.var_01A2, "targetname");
  common_scripts\utility::func_0FB2(var_01, ::func_3D85);
}

func_3D85() {
  self endon("death");
  self notify("stop_current_floodspawner");
  self endon("stop_current_floodspawner");
  if(!isDefined(self.var_005C) || self.var_005C <= 0) {
    return;
  }

  while(self.var_005C > 0) {
    var_00 = maps\mp\_utility::func_0FA7([self]);
    var_01 = var_00[0];
    if(!isDefined(var_01)) {
      wait(2);
      continue;
    }

    var_01 waittill("death", var_02);
    if(!common_scripts\utility::func_8155()) {
      wait(randomfloatrange(5, 9));
    }
  }
}