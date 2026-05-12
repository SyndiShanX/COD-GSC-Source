/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1395.gsc
*********************************************/

lib_0573::func_52A4() {
  lib_0561::initconsumablesfromtable("mys_box_key", ::lib_0573::func_A21F, ::lib_0573::func_1F5C, ::lib_0573::func_4598);
}

lib_0573::func_1F5C(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  if(lib_0573::func_4B7B()) {
    return 0;
  }

  return 1;
}

lib_0573::func_A21F(param_00) {
  self method_8615("zmb_pickup_general");
  var_01 = self.var_259F[param_00].var_01B9;
  self.var_65EC = spawnStruct();
  self.var_65EC.var_01B9 = var_01;
  self.var_65EC.var_267C = 1 - lib_0573::func_4599(var_01);
  if(common_scripts\utility::func_562E(level.reworkedconsumabledenabled)) {
    self.var_65EC.flatdiscount = 1250;
  }

  lib_0561::notifywallbuytriggers();
  maps\mp\zombies\_zombies_magicbox::func_861C();
}

lib_0573::func_4598(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  switch (param_00) {
    case "epic":
      return 4;

    case "legendary":
      return 3;

    case "rare":
      return 2;

    case "common":
      return 1;

    default:
      return 0;
  }
}

lib_0573::func_4599(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  switch (param_00) {
    case "common":
    case "rare":
    case "legendary":
    case "epic":
      return 0.5;

    default:
      return 0;
  }
}

lib_0573::func_4B7B() {
  if(isDefined(self.var_65EC)) {
    return 1;
  }

  return 0;
}

lib_0573::func_A21E() {
  if(!lib_0573::func_4B7B()) {
    return;
  }

  self.var_65EC = undefined;
  lib_0561::notifywallbuytriggers();
}