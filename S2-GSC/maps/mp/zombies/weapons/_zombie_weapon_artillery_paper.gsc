/**********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_weapon_artillery_paper.gsc
**********************************************************************/

init() {}

flourish_map(param_00) {
  thread preview_map(param_00);
}

use_map() {
  self allowjump(0);
  self method_8113(0);
  self method_8114(0);
  self setmovespeedscale(0);
  var_00 = self getcurrentweapon();
  lib_0586::func_78C("papermap_zm");
  lib_0586::func_78E("papermap_zm");
  self disableweaponswitch();
  var_01 = wait_for_user_input();
  self enableweaponswitch();
  lib_0586::func_78E(var_00);
  wait(1);
  lib_0586::func_790("papermap_zm");
  self setmovespeedscale(1);
  self allowjump(1);
  self method_8113(1);
  self method_8114(1);
  return var_01;
}

wait_for_user_input() {
  var_00 = 1;
  while(self useButtonPressed()) {
    wait 0.05;
  }

  wait(0.15);
  while(var_00) {
    if(self useButtonPressed()) {
      return "A";
    }

    if(self jumpbuttonPressed()) {
      return "B";
    }

    if(self method_84F1()) {
      return "C";
    }

    wait(0.15);
  }
}

preview_map(param_00) {
  var_01 = self getcurrentweapon();
  lib_0586::func_78C(param_00);
  lib_0586::func_78E(param_00);
  self disableweaponswitch();
  wait(1.5);
  iprintlnbold("DIALOG: We\'ll need to check out the sub pens first.");
  wait(1.5);
  self enableweaponswitch();
  lib_0586::func_78E(var_01);
  wait(1);
  lib_0586::func_790(param_00);
}