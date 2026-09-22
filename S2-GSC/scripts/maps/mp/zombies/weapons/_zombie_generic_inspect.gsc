/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_generic_inspect.gsc
***********************************************************************/

zmb_do_weapon_inspect(var_0) {
  var_1 = self;

  while(var_1 isswitchingweapon()) {
    waitframe();
  }

  var_1 _id_0586::_id_078C(var_0);
  var_1 _id_0586::_id_078E(var_0);
  var_1 common_scripts\utility::_id_0603();
  var_1 common_scripts\utility::_disableoffhandweapons();
  wait 1;

  while(var_1 _meth_8677()) {
    waitframe();
  }

  var_1 _id_0586::_id_078E(var_1 _id_0547::_id_AB2B());
  var_1 common_scripts\utility::_id_0617();
  var_1 common_scripts\utility::_id_0614();

  if(var_1 hasweapon(var_0)) {
    var_1 _id_0586::_id_0790(var_0);
  }
}