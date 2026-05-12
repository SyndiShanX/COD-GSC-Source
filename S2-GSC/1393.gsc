/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1393.gsc
*********************************************/

lib_0571::func_52A4() {
  lib_0561::initconsumablesfromtable("insta_kill", ::lib_0571::func_A218, ::lib_0571::func_1F80, ::lib_0571::func_4525);
}

lib_0571::func_1F80(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

lib_0571::func_A218(param_00) {
  maps\mp\gametypes\zombies::func_53DD(self, 1);
}

lib_0571::func_4525(param_00) {
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