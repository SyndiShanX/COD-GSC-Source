/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1396.gsc
*********************************************/

lib_0574::func_52A4() {
  lib_0561::initconsumablesfromtable("nuke", ::lib_0574::func_A221, ::lib_0574::func_1F83, ::lib_0574::func_45BA);
}

lib_0574::func_1F83(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

lib_0574::func_A221(param_00) {
  maps\mp\gametypes\zombies::func_685F(self, 1);
}

lib_0574::func_45BA(param_00) {
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