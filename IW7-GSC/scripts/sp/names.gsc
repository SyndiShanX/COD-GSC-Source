/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\names.gsc
********************************/

main() {}

func_F9E6() {
  if(isDefined(level.var_BE4D)) {
    return;
  }

  var_00["unitednations"] = 1;
  var_00["unitednationsjackal"] = 0;
  var_00["unitednationshelmet"] = 0;
  var_00["unitednationsfemale"] = 2;
  var_00["setdef"] = 3;
  var_00["c6"] = -1;
  foreach(var_03, var_02 in var_00) {
    level.var_BE4D[var_03] = [];
    if(var_02 < 0) {
      continue;
    }

    func_113B2(var_03, var_02);
  }

  func_1718("c6", "C6A");
  func_1718("c6", "C6B");
  func_1718("c6", "C6C");
  func_9725();
  foreach(var_03, var_02 in var_00) {
    func_E081(var_03);
    func_DCB5(var_03);
    level.var_BE4B[var_03] = 0;
  }

  var_00 = undefined;
}

func_113B2(param_00, param_01) {
  var_02 = tablelookuprownum("sp\names.csv", param_01, "__END__");
  var_03 = [];
  for(var_04 = 0; var_04 < var_02; var_04++) {
    var_03[var_04] = var_04;
  }

  var_03 = scripts\engine\utility::array_randomize(var_03);
  var_05 = min(50, var_02);
  for(var_04 = 0; var_04 < var_05; var_04++) {
    func_1719(param_00, var_03[var_04], param_01);
  }

  var_03 = undefined;
}

func_1719(param_00, param_01, param_02) {
  var_03 = tablelookupbyrow("sp\names.csv", param_01, param_02);
  func_1718(param_00, var_03);
}

func_4646(param_00, param_01) {
  level.var_BE4D[param_00] = level.var_BE4D[param_01];
}

func_1718(param_00, param_01) {
  level.var_BE4D[param_00][level.var_BE4D[param_00].size] = param_01;
}

func_171A(param_00, param_01) {
  foreach(var_03 in param_01) {
    level.var_BE4D[param_00][level.var_BE4D[param_00].size] = var_03;
  }
}

func_E05B(param_00, param_01) {
  level.var_BE4D[param_00] = ::scripts\engine\utility::array_remove(level.var_BE4D[param_00], param_01);
}

func_9725() {
  var_00 = [];
  var_01 = getspawnerarray();
  var_02 = getaiarray();
  foreach(var_04 in var_01) {
    if(isDefined(var_04.var_EDB8) && var_04.var_EDB8 != "none") {
      var_05 = func_C096(var_04.var_EDB8);
      var_00[var_00.size] = var_05;
    }
  }

  foreach(var_08 in var_02) {
    if(isDefined(var_08.var_EDB8) && var_08.var_EDB8 != "none") {
      var_05 = func_C096(var_08.var_EDB8);
      var_00[var_00.size] = var_05;
    }
  }

  level.var_EDB9 = var_00;
}

func_C096(param_00) {
  var_01 = strtok(param_00, " ");
  if(var_01.size > 1) {
    param_00 = var_01[1];
  }

  return param_00;
}

func_E081(param_00) {
  foreach(var_02 in level.var_EDB9) {
    foreach(var_04 in level.var_BE4D[param_00]) {
      if(var_02 == var_04) {
        func_E05B(param_00, var_04);
      }
    }
  }
}

func_DCB5(param_00) {
  var_01 = level.var_BE4D[param_00].size;
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = randomint(var_01);
    var_04 = level.var_BE4D[param_00][var_02];
    level.var_BE4D[param_00][var_02] = level.var_BE4D[param_00][var_03];
    level.var_BE4D[param_00][var_03] = var_04;
  }
}

func_7B05(param_00) {
  if(isDefined(self.team) && self.team == "neutral") {
    return;
  }

  if(isDefined(self.var_29B8) && self.var_29B8) {
    if(self.script_team == "axis") {
      return;
    } else {
      self.voice = "unitednationsjackal";
    }
  }

  if(isDefined(self.var_EDB8)) {
    if(self.var_EDB8 == "none") {
      return;
    }

    self.name = self.var_EDB8;
    getrankfromname(self.name);
    self notify("set name and rank");
    return;
  }

  func_7B07(self.voice);
  self notify("set name and rank");
}

func_7B07(param_00) {
  level.var_BE4B[param_00] = level.var_BE4B[param_00] + 1 % level.var_BE4D[param_00].size;
  var_01 = level.var_BE4D[param_00][level.var_BE4B[param_00]];
  var_02 = randomint(10);
  if(func_BE5B(param_00)) {
    var_03 = param_00 + "_surnames";
    level.var_BE4B[var_03] = level.var_BE4B[var_03] + 1 % level.var_BE4D[var_03].size;
    var_01 = var_01 + " " + level.var_BE4D[var_03][level.var_BE4B[var_03]];
  }

  if(func_BE5A(param_00)) {
    var_04 = var_01;
    self.var_1A70 = "private";
  } else if(isDefined(self.subclass) && self.subclass == "MDF") {
    var_05 = func_7E38(var_04);
    var_04 = var_05 + var_01;
  } else if(isDefined(self.subclass) && self.subclass == "jackal") {
    var_05 = canshoot(var_04);
    var_04 = var_05 + var_01;
  } else if(var_04 > 5) {
    var_04 = "Pvt. " + var_02;
    self.var_1A70 = "private";
  } else if(var_04 > 2) {
    var_04 = "Cpl. " + var_02;
    self.var_1A70 = "private";
  } else {
    var_04 = "Sgt. " + var_02;
    self.var_1A70 = "sergeant";
  }

  if(isai(self) && self gettargetchargepos()) {
    self.var_1A53 = var_04;
    return;
  }

  self.name = var_04;
}

func_7E38(param_00) {
  if(param_00 > 5) {
    self.var_1A70 = "private";
    if(scripts\engine\utility::cointoss()) {
      return "SN ";
    }

    return "AN ";
  }

  if(param_00 == 5) {
    self.var_1A70 = "private";
    return "PO3 ";
  }

  if(param_00 == 4) {
    self.var_1A70 = "private";
    return "PO2 ";
  }

  if(param_00 == 3) {
    self.var_1A70 = "private";
    return "PO1 ";
  }

  if(param_00 == 2) {
    self.var_1A70 = "sergeant";
    return "CPO ";
  }

  self.var_1A70 = "sergeant";
  return "SCPO ";
}

canshoot(param_00) {
  if(param_00 > 5) {
    self.var_1A70 = "private";
    return "Lt ";
  }

  if(param_00 > 2) {
    self.var_1A70 = "private";
    return "Ltjg ";
  }

  self.var_1A70 = "sergeant";
  return "Ens ";
}

getrankfromname(param_00) {
  if(!isDefined(param_00)) {
    self.var_1A70 = "private";
  }

  var_01 = strtok(param_00, " ");
  var_02 = var_01[0];
  switch (var_02) {
    case "Pvt.":
      self.var_1A70 = "private";
      break;

    case "Pfc.":
      self.var_1A70 = "private";
      break;

    case "Agent":
      self.var_1A70 = "private";
      break;

    case "Cpl.":
      self.var_1A70 = "corporal";
      break;

    case "Sgt.":
      self.var_1A70 = "sergeant";
      break;

    case "Lt.":
      self.var_1A70 = "lieutenant";
      break;

    case "Cpt.":
      self.var_1A70 = "captain";
      break;

    default:
      self.var_1A70 = "private";
      break;
  }
}

func_BE5A(param_00) {
  switch (param_00) {
    case "czech":
    case "taskforce":
    case "delta":
    case "seal":
      return 1;
  }

  return 0;
}

func_BE5B(param_00) {
  return isDefined(level.var_BE4D[param_00 + "_surnames"]);
}