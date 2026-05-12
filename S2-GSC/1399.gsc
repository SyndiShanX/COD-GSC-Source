/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1399.gsc
*********************************************/

lib_0577::func_52A4() {
  lib_0561::initconsumablesfromtable("skel_key", ::lib_0577::func_A237, ::lib_0577::func_1F6F, ::lib_0577::func_4685);
}

lib_0577::func_1F6F(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  if(lib_0577::func_4B95()) {
    return 0;
  }

  return 1;
}

lib_0577::func_A237(param_00) {
  self method_8615("zmb_pickup_general");
  var_01 = self.var_259F[param_00].var_01B9;
  self.var_8C71 = spawnStruct();
  self.var_8C71.var_01B9 = var_01;
  self.var_8C71.var_267C = 1 - lib_0577::func_4686(var_01);
  if(common_scripts\utility::func_562E(level.reworkedconsumabledenabled)) {
    self.var_8C71.flatdiscount = 1000;
  }

  lib_0561::notifywallbuytriggers();
}

lib_0577::func_4685(param_00) {
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

lib_0577::func_4686(param_00) {
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

lib_0577::func_4687() {
  if(lib_0577::func_4B95()) {
    return self.var_8C71.var_267C;
  }

  return 1;
}

lib_0577::func_4B95() {
  if(isDefined(self.var_8C71)) {
    return 1;
  }

  return 0;
}

lib_0577::func_A236() {
  if(!lib_0577::func_4B95()) {
    return;
  }

  self.var_8C71 = undefined;
  lib_0561::notifywallbuytriggers();
}