/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1392.gsc
*********************************************/

lib_0570::func_52A4() {
  lib_0561::initconsumablesfromtable("full_meter", ::lib_0570::func_A20D, ::lib_0570::func_1F7E, ::lib_0570::func_44F3);
}

lib_0570::func_1F7E(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

lib_0570::func_A20D(param_00) {
  maps\mp\gametypes\zombies::func_0840(self, 1);
}

lib_0570::func_44F3(param_00) {
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