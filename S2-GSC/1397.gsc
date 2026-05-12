/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1397.gsc
*********************************************/

lib_0575::func_52A4() {
  lib_0561::initconsumablesfromtable("ref_coupon", ::lib_0575::func_A230, ::lib_0575::func_1F86, ::lib_0575::func_4661);
}

lib_0575::func_1F86(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  if(lib_0575::func_4B8A()) {
    return 0;
  }

  return 1;
}

lib_0575::func_A230(param_00) {
  self.var_4B8A = 1;
}

lib_0575::func_4661(param_00) {
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

lib_0575::func_4B8A() {
  return isDefined(self.var_4B8A) && self.var_4B8A;
}

lib_0575::func_A22F(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  if(!lib_0575::func_4B8A()) {
    return;
  }

  wait(0.25);
  var_01 = int(0.25 * param_00);
  self.var_4B8A = 0;
  maps\mp\gametypes\zombies::func_4798(var_01, 1);
}