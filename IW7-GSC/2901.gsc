/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2901.gsc
***************************************/

main() {}

func_F9E6() {
  if(isDefined(level.func_BE4D)) {
    return;
  }
  var_0["unitednations"] = 1;
  var_0["unitednationsjackal"] = 0;
  var_0["unitednationshelmet"] = 0;
  var_0["unitednationsfemale"] = 2;
  var_0["setdef"] = 3;
  var_0["c6"] = -1;

  foreach(var_03, var_02 in var_00) {
    level.func_BE4D[var_03] = [];

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
    level.func_BE4B[var_03] = 0;
  }

  var_00 = undefined;
}

func_113B2(var_00, var_01) {
  var_02 = tablelookuprownum("sp\names.csv", var_01, "__END__");
  var_03 = [];

  for(var_04 = 0; var_04 < var_02; var_4++)
    var_3[var_04] = var_04;

  var_03 = scripts\engine\utility::array_randomize(var_03);
  var_05 = min(50, var_02);

  for(var_04 = 0; var_04 < var_05; var_4++)
    func_1719(var_00, var_3[var_04], var_01);

  var_03 = undefined;
}

func_1719(var_00, var_01, var_02) {
  var_03 = tablelookupbyrow("sp\names.csv", var_01, var_02);
  func_1718(var_00, var_03);
}

func_4646(var_00, var_01) {
  level.func_BE4D[var_00] = level.func_BE4D[var_01];
}

func_1718(var_00, var_01) {
  level.func_BE4D[var_00][level.func_BE4D[var_00].size] = var_01;
}

func_171A(var_00, var_01) {
  foreach(var_03 in var_01)
  level.func_BE4D[var_00][level.func_BE4D[var_00].size] = var_03;
}

func_E05B(var_00, var_01) {
  level.func_BE4D[var_00] = ::scripts\engine\utility::array_remove(level.func_BE4D[var_00], var_01);
}

func_9725() {
  var_00 = [];
  var_01 = _getspawnerarray();
  var_02 = _getaiarray();

  foreach(var_04 in var_01) {
    if(isDefined(var_4.func_EDB8) && var_4.func_EDB8 != "none") {
      var_05 = func_C096(var_4.func_EDB8);
      var_0[var_0.size] = var_05;
    }
  }

  foreach(var_08 in var_02) {
    if(isDefined(var_8.func_EDB8) && var_8.func_EDB8 != "none") {
      var_05 = func_C096(var_8.func_EDB8);
      var_0[var_0.size] = var_05;
    }
  }

  level.func_EDB9 = var_00;
}

func_C096(var_00) {
  var_01 = strtok(var_00, " ");

  if(var_1.size > 1)
    var_00 = var_1[1];

  return var_00;
}

func_E081(var_00) {
  foreach(var_02 in level.func_EDB9) {
    foreach(var_04 in level.func_BE4D[var_00]) {
      if(var_02 == var_04)
        func_E05B(var_00, var_04);
    }
  }
}

func_DCB5(var_00) {
  var_01 = level.func_BE4D[var_00].size;

  for(var_02 = 0; var_02 < var_01; var_2++) {
    var_03 = randomint(var_01);
    var_04 = level.func_BE4D[var_00][var_02];
    level.func_BE4D[var_00][var_02] = level.func_BE4D[var_00][var_03];
    level.func_BE4D[var_00][var_03] = var_04;
  }
}

func_7B05(var_00) {
  if(isDefined(self.team) && self.team == "neutral") {
    return;
  }
  if(isDefined(self.func_29B8) && self.func_29B8) {
    if(self.script_team == "axis")
      return;
    else
      self.voice = "unitednationsjackal";
  }

  if(isDefined(self.func_EDB8)) {
    if(self.func_EDB8 == "none") {
      return;
    }
    self.name = self.func_EDB8;
    getrankfromname(self.name);
    self notify("set name and rank");
    return;
  }

  func_7B07(self.voice);
  self notify("set name and rank");
}

func_7B07(var_00) {
  level.func_BE4B[var_00] = (level.func_BE4B[var_00] + 1) % level.func_BE4D[var_00].size;
  var_01 = level.func_BE4D[var_00][level.func_BE4B[var_00]];
  var_02 = randomint(10);

  if(func_BE5B(var_00)) {
    var_03 = var_00 + "_surnames";
    level.func_BE4B[var_03] = (level.func_BE4B[var_03] + 1) % level.func_BE4D[var_03].size;
    var_01 = var_01 + " " + level.func_BE4D[var_03][level.func_BE4B[var_03]];
  }

  if(func_BE5A(var_00)) {
    var_04 = var_01;
    self.func_1A70 = "private";
  } else if(isDefined(self.subclass) && self.subclass == "MDF") {
    var_05 = func_7E38(var_02);
    var_04 = var_05 + var_01;
  } else if(isDefined(self.subclass) && self.subclass == "jackal") {
    var_05 = canshoot(var_02);
    var_04 = var_05 + var_01;
  } else if(var_02 > 5) {
    var_04 = "Pvt. " + var_01;
    self.func_1A70 = "private";
  } else if(var_02 > 2) {
    var_04 = "Cpl. " + var_01;
    self.func_1A70 = "private";
  } else {
    var_04 = "Sgt. " + var_01;
    self.func_1A70 = "sergeant";
  }

  if(isai(self) && self isbadguy())
    self.func_1A53 = var_04;
  else
    self.name = var_04;
}

func_7E38(var_00) {
  if(var_00 > 5) {
    self.func_1A70 = "private";

    if(scripts\engine\utility::cointoss())
      return "SN ";
    else
      return "AN ";
  } else if(var_00 == 5) {
    self.func_1A70 = "private";
    return "PO3 ";
  } else if(var_00 == 4) {
    self.func_1A70 = "private";
    return "PO2 ";
  } else if(var_00 == 3) {
    self.func_1A70 = "private";
    return "PO1 ";
  } else if(var_00 == 2) {
    self.func_1A70 = "sergeant";
    return "CPO ";
  } else {
    self.func_1A70 = "sergeant";
    return "SCPO ";
  }
}

canshoot(var_00) {
  if(var_00 > 5) {
    self.func_1A70 = "private";
    return "Lt ";
  } else if(var_00 > 2) {
    self.func_1A70 = "private";
    return "Ltjg ";
  } else {
    self.func_1A70 = "sergeant";
    return "Ens ";
  }
}

getrankfromname(var_00) {
  if(!isDefined(var_00))
    self.func_1A70 = "private";

  var_01 = strtok(var_00, " ");
  var_02 = var_1[0];

  switch (var_02) {
    case "Pvt.":
      self.func_1A70 = "private";
      break;
    case "Pfc.":
      self.func_1A70 = "private";
      break;
    case "Agent":
      self.func_1A70 = "private";
      break;
    case "Cpl.":
      self.func_1A70 = "corporal";
      break;
    case "Sgt.":
      self.func_1A70 = "sergeant";
      break;
    case "Lt.":
      self.func_1A70 = "lieutenant";
      break;
    case "Cpt.":
      self.func_1A70 = "captain";
      break;
    default:
      self.func_1A70 = "private";
      break;
  }
}

func_BE5A(var_00) {
  switch (var_00) {
    case "czech":
    case "taskforce":
    case "delta":
    case "seal":
      return 1;
  }

  return 0;
}

func_BE5B(var_00) {
  return isDefined(level.func_BE4D[var_00 + "_surnames"]);
}