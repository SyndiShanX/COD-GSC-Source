/******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_weapon_artillery_paper.gsc
******************************************************************************/

init() {}

flourish_map(var_0) {
  thread preview_map(var_0);
}

use_map() {
  self allowjump(0);
  self allowcrouch(0);
  self allowprone(0);
  self setmovespeedscale(0);
  var_0 = self getcurrentweapon();
  _id_0586::_id_078C("papermap_zm");
  _id_0586::_id_078E("papermap_zm");
  self disableweaponswitch();
  var_1 = wait_for_user_input();
  self enableweaponswitch();
  _id_0586::_id_078E(var_0);
  wait 1;
  _id_0586::_id_0790("papermap_zm");
  self setmovespeedscale(1);
  self allowjump(1);
  self allowcrouch(1);
  self allowprone(1);
  return var_1;
}

wait_for_user_input() {
  var_0 = 1;

  while(self useButtonPressed()) {
    waitframe();
  }

  wait 0.15;

  while(var_0) {
    if(self useButtonPressed()) {
      return "A";
    }

    if(self jumpbuttonPressed()) {
      return "B";
    }

    if(self _meth_84F1()) {
      return "C";
    }

    wait 0.15;
  }
}

preview_map(var_0) {
  var_1 = self getcurrentweapon();
  _id_0586::_id_078C(var_0);
  _id_0586::_id_078E(var_0);
  self disableweaponswitch();
  wait 1.5;
  _iprintlnbold("DIALOG: We'll need to check out the sub pens first.");
  wait 1.5;
  self enableweaponswitch();
  _id_0586::_id_078E(var_1);
  wait 1;
  _id_0586::_id_0790(var_0);
}