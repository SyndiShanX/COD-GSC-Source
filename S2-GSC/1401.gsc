/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1401.gsc
*********************************************/

lib_0579::func_52A4() {
  lib_0561::initconsumablesfromtable("weap_guarantee", ::lib_0579::func_A247, ::lib_0579::func_1F8C, ::lib_0579::func_4721);
}

lib_0579::func_1F8C(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  return 1;
}

lib_0579::func_A247(param_00) {
  self method_8615("zmb_pickup_general");
  var_01 = self.var_259F[param_00].var_0109;
  var_02 = lib_0579::func_398B(var_01);
  self.var_A99B = var_02;
  foreach(var_04 in self getweaponslistprimaries()) {
    if(lib_0547::func_5565(lib_0547::func_AAF9(var_04), var_02)) {
      maps\mp\zombies\_zombies_magicbox::func_3AC1(self, var_04);
      self givemaxammo(var_04);
    }
  }

  lib_0561::notifywallbuytriggers();
}

lib_0579::func_4721(param_00) {
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

lib_0579::func_398B(param_00) {
  var_01 = function_0337(param_00, "consumable_zm_guarantee_");
  return var_01;
}

lib_0579::func_4BA5() {
  if(isDefined(self.var_A99B)) {
    return 1;
  }

  return 0;
}

lib_0579::func_A246() {
  var_00 = self.var_A99B;
  self.var_A99B = undefined;
  lib_0561::notifywallbuytriggers();
  return var_00;
}