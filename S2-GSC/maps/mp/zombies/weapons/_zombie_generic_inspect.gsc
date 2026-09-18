/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_generic_inspect.gsc
***************************************************************/

zmb_do_weapon_inspect(param_00) {
  var_01 = self;
  while(var_01 method_833B()) {
    wait 0.05;
  }

  var_01 lib_0586::func_78C(param_00);
  var_01 lib_0586::func_78E(param_00);
  var_01 common_scripts\utility::func_603();
  var_01 common_scripts\utility::_disableoffhandweapons();
  wait(1);
  while(var_01 isswitchingweapon()) {
    wait 0.05;
  }

  var_01 lib_0586::func_78E(var_01 lib_0547::func_AB2B());
  var_01 common_scripts\utility::func_617();
  var_01 common_scripts\utility::func_614();
  if(var_01 hasweapon(param_00)) {
    var_01 lib_0586::func_790(param_00);
  }
}