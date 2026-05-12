/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1400.gsc
*********************************************/

lib_0578::func_52A4() {
  lib_0561::initconsumablesfromtable("vending_machine", ::lib_0578::func_A244, ::lib_0578::func_1F8B, ::lib_0578::func_4716);
}

lib_0578::func_1F8B(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  if(lib_0578::func_4BA4()) {
    return 0;
  }

  return 1;
}

lib_0578::func_A244(param_00) {
  self.var_4B7D = 1;
  self notify("perk_discount_applied");
}

lib_0578::func_4716(param_00) {
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

lib_0578::func_4717(param_00) {
  if(lib_056B::func_9D19(param_00.var_6F63)) {
    return 0;
  }

  if(lib_0578::func_4BA4()) {
    return 0.5;
  }

  return 1;
}

lib_0578::func_4BA4() {
  return isDefined(self.var_4B7D) && self.var_4B7D;
}

lib_0578::func_A245() {
  var_00 = self;
  if(var_00 lib_0578::func_4BA4()) {
    var_00.var_4B7D = undefined;
  }

  var_00 notify("used_vending_machine_discount");
}