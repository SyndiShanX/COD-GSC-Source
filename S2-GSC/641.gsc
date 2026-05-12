/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 641.gsc
*********************************************/

lib_0281::func_86CC(param_00) {
  self setModel(param_00[randomint(param_00.size)]);
}

lib_0281::func_7653(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    precachemodel(param_00[var_01]);
  }
}

lib_0281::func_114A(param_00, param_01) {
  if(!isDefined(level.var_20D0)) {
    level.var_20D0 = [];
  }

  if(!isDefined(level.var_20D0[param_00])) {
    level.var_20D0[param_00] = randomint(param_01.size);
  }

  var_02 = level.var_20D0[param_00] + 1 % param_01.size;
  level.var_20D0[param_00] = var_02;
  lib_0281::func_86A0(param_01[var_02]);
}

lib_0281::func_86A0(param_00) {
  if(isDefined(self.var_4BF2)) {
    self method_802E(self.var_4BF2);
  }

  self attach(param_00, "", 1);
  self.var_4BF2 = param_00;
}

lib_0281::func_1149(param_00, param_01) {
  if(!isDefined(level.var_20CF)) {
    level.var_20CF = [];
  }

  if(!isDefined(level.var_20CF[param_00])) {
    level.var_20CF[param_00] = randomint(param_01.size);
  }

  var_02 = level.var_20CF[param_00] + 1 % param_01.size;
  level.var_20CF[param_00] = var_02;
  self attach(param_01[var_02]);
  self.var_4BA9 = param_01[var_02];
}

lib_0281::func_6685() {
  self detachall();
  var_00 = self.var_0E14;
  if(!isDefined(var_00)) {
    return;
  }

  self.var_0E14 = "none";
  self[[level.var_77C6]](var_00);
}

lib_0281::func_8055() {
  var_00["gunHand"] = self.var_0E14;
  var_00["gunInHand"] = self.var_0E15;
  var_00["model"] = self.var_0106;
  var_00["hatModel"] = self.var_4BA9;
  if(isDefined(self.var_0109)) {
    var_00["name"] = self.var_0109;
  } else {}

  var_01 = self getattachsize();
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_00["attach"][var_02]["model"] = self getattachmodelname(var_02);
    var_00["attach"][var_02]["tag"] = self getattachtagname(var_02);
  }

  return var_00;
}

lib_0281::func_5DDF(param_00) {
  self detachall();
  self.var_0E14 = param_00["gunHand"];
  self.var_0E15 = param_00["gunInHand"];
  self setModel(param_00["model"]);
  self.var_4BA9 = param_00["hatModel"];
  if(isDefined(param_00["name"])) {
    self.var_0109 = param_00["name"];
  } else {}

  var_01 = param_00["attach"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    self attach(var_01[var_03]["model"], var_01[var_03]["tag"]);
  }
}

lib_0281::func_0136(param_00) {
  if(isDefined(param_00["name"])) {} else {}

  precachemodel(param_00["model"]);
  var_01 = param_00["attach"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    precachemodel(var_01[var_03]["model"]);
  }
}

lib_0281::func_42DF(param_00) {
  if(isDefined(self.var_003A)) {
    var_01 = strtok(self.var_003A, "_");
  } else {
    var_01 = [];
  }

  if(!common_scripts\utility::func_57D7()) {
    if(isDefined(self.var_012C["modelIndex"]) && self.var_012C["modelIndex"] < param_00) {
      return self.var_012C["modelIndex"];
    }

    var_02 = randomint(param_00);
    self.var_012C["modelIndex"] = var_02;
    return var_02;
  } else if(var_02.size <= 2) {
    return randomint(var_01);
  }

  var_03 = "auto";
  var_02 = undefined;
  var_04 = var_01[2];
  if(!isDefined(level.var_20D1)) {
    level.var_20D1 = [];
  }

  if(!isDefined(level.var_20D1[var_04])) {
    level.var_20D1[var_04] = [];
  }

  if(!isDefined(level.var_20D1[var_04][var_02])) {
    lib_0281::func_52DF(var_04, var_02, param_00);
  }

  if(!isDefined(var_03)) {
    var_03 = lib_0281::func_41E6(var_04, var_02);
    if(!isDefined(var_03)) {
      var_03 = randomint(5000);
    }
  }

  while(var_03 >= param_00) {
    var_03 = var_03 - param_00;
  }

  level.var_20D1[var_04][var_02][var_03]++;
  return var_03;
}

lib_0281::func_41E6(param_00, param_01) {
  var_02 = [];
  var_03 = level.var_20D1[param_00][param_01][0];
  var_02[0] = 0;
  for(var_04 = 1; var_04 < level.var_20D1[param_00][param_01].size; var_04++) {
    if(level.var_20D1[param_00][param_01][var_04] > var_03) {
      continue;
    }

    if(level.var_20D1[param_00][param_01][var_04] < var_03) {
      var_02 = [];
      var_03 = level.var_20D1[param_00][param_01][var_04];
    }

    var_02[var_02.size] = var_04;
  }

  return lib_0281::func_7A33(var_02);
}

lib_0281::func_52DF(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_02; var_03++) {
    level.var_20D1[param_00][param_01][var_03] = 0;
  }
}

lib_0281::func_42EA(param_00) {
  return randomint(param_00);
}

lib_0281::func_7A33(param_00) {
  return param_00[randomint(param_00.size)];
}

lib_0281::func_5563(param_00, param_01) {
  var_02 = function_0060(param_00);
  var_03 = 1;
  foreach(var_05 in var_02) {
    if(var_05 == param_01) {
      var_03 = 0;
      break;
    }
  }

  return var_03;
}

lib_0281::func_1D32(param_00, param_01) {
  var_02 = param_00;
  if(isDefined(param_01)) {
    foreach(var_04 in param_01) {
      if(!lib_0281::func_5563(param_00, var_04)) {
        var_02 = var_02 + "+" + var_04;
      }
    }
  }

  return var_02;
}