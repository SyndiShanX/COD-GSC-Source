/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2901.gsc
**************************************/

main() {}

_id_F9E6() {
  if(isDefined(level._id_BE4D)) {
    return;
  }
  var_0["unitednations"] = 1;
  var_0["unitednationsjackal"] = 0;
  var_0["unitednationshelmet"] = 0;
  var_0["unitednationsfemale"] = 2;
  var_0["setdef"] = 3;
  var_0["c6"] = -1;

  foreach(var_3, var_2 in var_0) {
    level._id_BE4D[var_3] = [];

    if(var_2 < 0) {
      continue;
    }
    _id_113B2(var_3, var_2);
  }

  _id_1718("c6", "C6A");
  _id_1718("c6", "C6B");
  _id_1718("c6", "C6C");
  _id_9725();

  foreach(var_3, var_2 in var_0) {
    _id_E081(var_3);
    _id_DCB5(var_3);
    level._id_BE4B[var_3] = 0;
  }

  var_0 = undefined;
}

_id_113B2(var_0, var_1) {
  var_2 = tablelookuprownum("sp/names.csv", var_1, "__END__");
  var_3 = [];

  for(var_4 = 0; var_4 < var_2; var_4++)
    var_3[var_4] = var_4;

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_5 = min(50, var_2);

  for(var_4 = 0; var_4 < var_5; var_4++)
    _id_1719(var_0, var_3[var_4], var_1);

  var_3 = undefined;
}

_id_1719(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("sp/names.csv", var_1, var_2);
  _id_1718(var_0, var_3);
}

_id_4646(var_0, var_1) {
  level._id_BE4D[var_0] = level._id_BE4D[var_1];
}

_id_1718(var_0, var_1) {
  level._id_BE4D[var_0][level._id_BE4D[var_0].size] = var_1;
}

_id_171A(var_0, var_1) {
  foreach(var_3 in var_1)
  level._id_BE4D[var_0][level._id_BE4D[var_0].size] = var_3;
}

_id_E05B(var_0, var_1) {
  level._id_BE4D[var_0] = scripts\engine\utility::array_remove(level._id_BE4D[var_0], var_1);
}

_id_9725() {
  var_0 = [];
  var_1 = getspawnerarray();
  var_2 = getaiarray();

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_EDB8) && var_4._id_EDB8 != "none") {
      var_5 = _id_C096(var_4._id_EDB8);
      var_0[var_0.size] = var_5;
    }
  }

  foreach(var_8 in var_2) {
    if(isDefined(var_8._id_EDB8) && var_8._id_EDB8 != "none") {
      var_5 = _id_C096(var_8._id_EDB8);
      var_0[var_0.size] = var_5;
    }
  }

  level._id_EDB9 = var_0;
}

_id_C096(var_0) {
  var_1 = strtok(var_0, " ");

  if(var_1.size > 1)
    var_0 = var_1[1];

  return var_0;
}

_id_E081(var_0) {
  foreach(var_2 in level._id_EDB9) {
    foreach(var_4 in level._id_BE4D[var_0]) {
      if(var_2 == var_4)
        _id_E05B(var_0, var_4);
    }
  }
}

_id_DCB5(var_0) {
  var_1 = level._id_BE4D[var_0].size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(var_1);
    var_4 = level._id_BE4D[var_0][var_2];
    level._id_BE4D[var_0][var_2] = level._id_BE4D[var_0][var_3];
    level._id_BE4D[var_0][var_3] = var_4;
  }
}

_id_7B05(var_0) {
  if(isDefined(self.team) && self.team == "neutral") {
    return;
  }
  if(isDefined(self._id_29B8) && self._id_29B8) {
    if(self.script_team == "axis")
      return;
    else
      self.voice = "unitednationsjackal";
  }

  if(isDefined(self._id_EDB8)) {
    if(self._id_EDB8 == "none") {
      return;
    }
    self.name = self._id_EDB8;
    getrankfromname(self.name);
    self notify("set name and rank");
    return;
  }

  _id_7B07(self.voice);
  self notify("set name and rank");
}

_id_7B07(var_0) {
  level._id_BE4B[var_0] = (level._id_BE4B[var_0] + 1) % level._id_BE4D[var_0].size;
  var_1 = level._id_BE4D[var_0][level._id_BE4B[var_0]];
  var_2 = randomint(10);

  if(_id_BE5B(var_0)) {
    var_3 = var_0 + "_surnames";
    level._id_BE4B[var_3] = (level._id_BE4B[var_3] + 1) % level._id_BE4D[var_3].size;
    var_1 = var_1 + " " + level._id_BE4D[var_3][level._id_BE4B[var_3]];
  }

  if(_id_BE5A(var_0)) {
    var_4 = var_1;
    self._id_1A70 = "private";
  } else if(isDefined(self.subclass) && self.subclass == "MDF") {
    var_5 = _id_7E38(var_2);
    var_4 = var_5 + var_1;
  } else if(isDefined(self.subclass) && self.subclass == "jackal") {
    var_5 = _id_8060(var_2);
    var_4 = var_5 + var_1;
  } else if(var_2 > 5) {
    var_4 = "Pvt. " + var_1;
    self._id_1A70 = "private";
  } else if(var_2 > 2) {
    var_4 = "Cpl. " + var_1;
    self._id_1A70 = "private";
  } else {
    var_4 = "Sgt. " + var_1;
    self._id_1A70 = "sergeant";
  }

  if(isai(self) && self isbadguy())
    self._id_1A53 = var_4;
  else
    self.name = var_4;
}

_id_7E38(var_0) {
  if(var_0 > 5) {
    self._id_1A70 = "private";

    if(scripts\engine\utility::cointoss())
      return "SN ";
    else
      return "AN ";
  } else if(var_0 == 5) {
    self._id_1A70 = "private";
    return "PO3 ";
  } else if(var_0 == 4) {
    self._id_1A70 = "private";
    return "PO2 ";
  } else if(var_0 == 3) {
    self._id_1A70 = "private";
    return "PO1 ";
  } else if(var_0 == 2) {
    self._id_1A70 = "sergeant";
    return "CPO ";
  } else {
    self._id_1A70 = "sergeant";
    return "SCPO ";
  }
}

_id_8060(var_0) {
  if(var_0 > 5) {
    self._id_1A70 = "private";
    return "Lt ";
  } else if(var_0 > 2) {
    self._id_1A70 = "private";
    return "Ltjg ";
  } else {
    self._id_1A70 = "sergeant";
    return "Ens ";
  }
}

getrankfromname(var_0) {
  if(!isDefined(var_0))
    self._id_1A70 = "private";

  var_1 = strtok(var_0, " ");
  var_2 = var_1[0];

  switch (var_2) {
    case "Pvt.":
      self._id_1A70 = "private";
      break;
    case "Pfc.":
      self._id_1A70 = "private";
      break;
    case "Agent":
      self._id_1A70 = "private";
      break;
    case "Cpl.":
      self._id_1A70 = "corporal";
      break;
    case "Sgt.":
      self._id_1A70 = "sergeant";
      break;
    case "Lt.":
      self._id_1A70 = "lieutenant";
      break;
    case "Cpt.":
      self._id_1A70 = "captain";
      break;
    default:
      self._id_1A70 = "private";
      break;
  }
}

_id_BE5A(var_0) {
  switch (var_0) {
    case "czech":
    case "taskforce":
    case "delta":
    case "seal":
      return 1;
  }

  return 0;
}

_id_BE5B(var_0) {
  return isDefined(level._id_BE4D[var_0 + "_surnames"]);
}