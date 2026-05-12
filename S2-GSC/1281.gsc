/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1281.gsc
*********************************************/

func_5340() {
  level.var_79C4 = spawnStruct();
  level.var_79C4.var_6C1E = [];
  level.var_79C4.var_5FEE = 0;
  if(getdvarint("233")) {
    return;
  }

  var_00 = tablelookuprownum("mp/raidSettingsMapObjectives.csv", 0, level.var_15D);
  if(var_00 < 0) {
    level.var_79C4.var_5FEE = 0;
  } else {
    level.var_79C4.var_5FEE = int(tablelookupbyrow("mp/raidSettingsMapObjectives.csv", var_00, 1));
  }

  var_01 = function_027A("mp/raidSettingsOptionValues.csv");
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = tablelookupbyrow("mp/raidSettingsOptionValues.csv", var_02, 0);
    var_04 = tablelookupbyrow("mp/raidSettingsOptionValues.csv", var_02, 1 + level.var_79C4.var_5FEE);
    if(var_04 == "") {
      var_04 = tablelookup("mp/raidSettingsOptionValues.csv", 0, var_03, 1);
    }

    level.var_79C4.var_6C1E[var_03] = var_04;
  }
}

func_4646(param_00) {
  if(getdvarint("233")) {
    return 0;
  }

  if(isusingmatchrulesdata()) {
    var_01 = getmatchrulesdata("raidData", param_00);
    if(isDefined(var_01)) {
      return var_01;
    }
  } else {
    var_02 = level.var_79C4.var_6C1E[param_00];
    if(isDefined(var_02)) {
      return var_02;
    }
  }

  return 0;
}

func_4648(param_00) {
  return int(func_4646(param_00));
}

func_4647(param_00) {
  return float(func_4646(param_00));
}