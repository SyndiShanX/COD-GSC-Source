/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1394.gsc
*********************************************/

lib_0572::func_52A4() {
  lib_0561::initconsumablesfromtable("max_ammo", ::lib_0572::func_A21A, ::lib_0572::func_1F82, ::lib_0572::func_4575);
}

lib_0572::func_1F82(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

lib_0572::func_A21A(param_00) {
  maps\mp\gametypes\zombies::func_0DB9(self, 1);
}

lib_0572::func_4575(param_00) {
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