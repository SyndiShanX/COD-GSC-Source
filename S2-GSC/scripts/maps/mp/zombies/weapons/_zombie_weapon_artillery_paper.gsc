/******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_weapon_artillery_paper.gsc
******************************************************************************/

init() {}

flourish_map(var_0) {
  thread preview_map(var_0);
}

use_map() {
  self _meth_8305(0);
  self _meth_8113(0);
  self _meth_8114(0);
  self _meth_81E1(0);
  var_0 = self getcurrentweapon();
  _id_0586::_id_078C("papermap_zm");
  _id_0586::_id_078E("papermap_zm");
  self _meth_8326();
  var_1 = wait_for_user_input();
  self _meth_8327();
  _id_0586::_id_078E(var_0);
  wait 1;
  _id_0586::_id_0790("papermap_zm");
  self _meth_81E1(1);
  self _meth_8305(1);
  self _meth_8113(1);
  self _meth_8114(1);
  return var_1;
}

wait_for_user_input() {
  var_0 = 1;

  while(self _meth_8341())
    waitframe();

  wait 0.15;

  while(var_0) {
    if(self _meth_8341())
      return "A";

    if(self _meth_83E4())
      return "B";

    if(self _meth_84F1())
      return "C";

    wait 0.15;
  }
}

preview_map(var_0) {
  var_1 = self getcurrentweapon();
  _id_0586::_id_078C(var_0);
  _id_0586::_id_078E(var_0);
  self _meth_8326();
  wait 1.5;
  _func_18C("DIALOG: We'll need to check out the sub pens first.");
  wait 1.5;
  self _meth_8327();
  _id_0586::_id_078E(var_1);
  wait 1;
  _id_0586::_id_0790(var_0);
}