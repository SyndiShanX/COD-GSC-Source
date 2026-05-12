/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1391.gsc
*********************************************/

lib_056F::func_52A4() {
  lib_0561::initconsumablesfromtable("double_points", ::lib_056F::func_A208, ::lib_056F::func_1F7D, ::lib_056F::func_44A8);
}

lib_056F::func_1F7D(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

lib_056F::func_A208(param_00) {
  maps\mp\gametypes\zombies::func_32C8(self, 1);
}

lib_056F::func_44A8(param_00) {
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