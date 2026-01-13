/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\names.gsc
*********************************************/

main() {}

func_F9E6() {
  if(isDefined(level.var_BE4D)) {
    return;
  }

  var_0["unitednations"] = 1;
  var_0["unitednationsjackal"] = 0;
  var_0["unitednationshelmet"] = 0;
  var_0["unitednationsfemale"] = 2;
  var_0["setdef"] = 3;
  var_0["c6"] = -1;
  foreach(var_3, var_2 in var_0) {
    level.var_BE4D[var_3] = [];
    if(var_2 < 0) {
      continue;
    }

    func_113B2(var_3, var_2);
  }

  func_1718("c6", "C6A");
  func_1718("c6", "C6B");
  func_1718("c6", "C6C");
  func_9725();
  foreach(var_3, var_2 in var_0) {
    func_E081(var_3);
    func_DCB5(var_3);
    level.var_BE4B[var_3] = 0;
  }

  var_0 = undefined;
}

func_113B2(var_0, var_1) {
  var_2 = tablelookuprownum("sp\names.csv", var_1, "__END__");
  var_3 = [];
  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_3[var_4] = var_4;
  }

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_5 = min(50, var_2);
  for(var_4 = 0; var_4 < var_5; var_4++) {
    func_1719(var_0, var_3[var_4], var_1);
  }

  var_3 = undefined;
}

func_1719(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("sp\names.csv", var_1, var_2);
  func_1718(var_0, var_3);
}

func_4646(var_0, var_1) {
  level.var_BE4D[var_0] = level.var_BE4D[var_1];
}

func_1718(var_0, var_1) {
  level.var_BE4D[var_0][level.var_BE4D[var_0].size] = var_1;
}

func_171A(var_0, var_1) {
  foreach(var_3 in var_1) {
    level.var_BE4D[var_0][level.var_BE4D[var_0].size] = var_3;
  }
}

func_E05B(var_0, var_1) {
  level.var_BE4D[var_0] = ::scripts\engine\utility::array_remove(level.var_BE4D[var_0], var_1);
}

func_9725() {
  var_0 = [];
  var_1 = getspawnerarray();
  var_2 = getaiarray();
  foreach(var_4 in var_1) {
    if(isDefined(var_4.var_EDB8) && var_4.var_EDB8 != "none") {
      var_5 = func_C096(var_4.var_EDB8);
      var_0[var_0.size] = var_5;
    }
  }

  foreach(var_8 in var_2) {
    if(isDefined(var_8.var_EDB8) && var_8.var_EDB8 != "none") {
      var_5 = func_C096(var_8.var_EDB8);
      var_0[var_0.size] = var_5;
    }
  }

  level.var_EDB9 = var_0;
}

func_C096(var_0) {
  var_1 = strtok(var_0, " ");
  if(var_1.size > 1) {
    var_0 = var_1[1];
  }

  return var_0;
}

func_E081(var_0) {
  foreach(var_2 in level.var_EDB9) {
    foreach(var_4 in level.var_BE4D[var_0]) {
      if(var_2 == var_4) {
        func_E05B(var_0, var_4);
      }
    }
  }
}

func_DCB5(var_0) {
  var_1 = level.var_BE4D[var_0].size;
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(var_1);
    var_4 = level.var_BE4D[var_0][var_2];
    level.var_BE4D[var_0][var_2] = level.var_BE4D[var_0][var_3];
    level.var_BE4D[var_0][var_3] = var_4;
  }
}

func_7B05(var_0) {
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

func_7B07(var_0) {
  level.var_BE4B[var_0] = level.var_BE4B[var_0] + 1 % level.var_BE4D[var_0].size;
  var_1 = level.var_BE4D[var_0][level.var_BE4B[var_0]];
  var_2 = randomint(10);
  if(func_BE5B(var_0)) {
    var_3 = var_0 + "_surnames";
    level.var_BE4B[var_3] = level.var_BE4B[var_3] + 1 % level.var_BE4D[var_3].size;
    var_1 = var_1 + " " + level.var_BE4D[var_3][level.var_BE4B[var_3]];
  }

  if(func_BE5A(var_0)) {
    var_4 = var_1;
    self.var_1A70 = "private";
  } else if(isDefined(self.subclass) && self.subclass == "MDF") {
    var_5 = func_7E38(var_4);
    var_4 = var_5 + var_1;
  } else if(isDefined(self.subclass) && self.subclass == "jackal") {
    var_5 = canshoot(var_4);
    var_4 = var_5 + var_1;
  } else if(var_4 > 5) {
    var_4 = "Pvt. " + var_2;
    self.var_1A70 = "private";
  } else if(var_4 > 2) {
    var_4 = "Cpl. " + var_2;
    self.var_1A70 = "private";
  } else {
    var_4 = "Sgt. " + var_2;
    self.var_1A70 = "sergeant";
  }

  if(isai(self) && self gettargetchargepos()) {
    self.var_1A53 = var_4;
    return;
  }

  self.name = var_4;
}

func_7E38(var_0) {
  if(var_0 > 5) {
    self.var_1A70 = "private";
    if(scripts\engine\utility::cointoss()) {
      return "SN ";
    }

    return "AN ";
  }

  if(var_0 == 5) {
    self.var_1A70 = "private";
    return "PO3 ";
  }

  if(var_0 == 4) {
    self.var_1A70 = "private";
    return "PO2 ";
  }

  if(var_0 == 3) {
    self.var_1A70 = "private";
    return "PO1 ";
  }

  if(var_0 == 2) {
    self.var_1A70 = "sergeant";
    return "CPO ";
  }

  self.var_1A70 = "sergeant";
  return "SCPO ";
}

canshoot(var_0) {
  if(var_0 > 5) {
    self.var_1A70 = "private";
    return "Lt ";
  }

  if(var_0 > 2) {
    self.var_1A70 = "private";
    return "Ltjg ";
  }

  self.var_1A70 = "sergeant";
  return "Ens ";
}

getrankfromname(var_0) {
  if(!isDefined(var_0)) {
    self.var_1A70 = "private";
  }

  var_1 = strtok(var_0, " ");
  var_2 = var_1[0];
  switch (var_2) {
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

func_BE5A(var_0) {
  switch (var_0) {
    case "czech":
    case "taskforce":
    case "delta":
    case "seal":
      return 1;
  }

  return 0;
}

func_BE5B(var_0) {
  return isDefined(level.var_BE4D[var_0 + "_surnames"]);
}