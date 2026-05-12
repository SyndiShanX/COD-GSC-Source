/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1337.gsc
*********************************************/

lib_0539::func_00D5() {}

lib_0539::func_3662() {
  maps\mp\zombies\_zombies_roles::func_6AB2("role_ability_melee_frenzy_zm");
  self.var_60E8 = 1;
  lib_0547::func_7ACD();
}

lib_0539::func_2F9E() {
  if(common_scripts\utility::func_562E(self.var_60E8)) {
    self.var_60E8 = undefined;
    lib_0547::func_7ACD();
  }
}

lib_0539::func_62A6(param_00, param_01, param_02) {
  var_03 = param_00;
  if(isDefined(param_02) && maps\mp\_utility::func_5755(param_02) && isDefined(param_01.var_60E8)) {
    switch (self.var_0A4B) {
      case "zombie_berserker":
      case "zombie_generic":
      case "zombie_exploder":
        var_03 = self.var_00BC + 1;
        break;

      default:
        var_03 = var_03 + 1500;
        break;
    }
  }

  return var_03;
}