/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\names.gsc
***********************************************/

main() {}

setup_names() {
  if(isDefined(level.names)) {
    return;
  }
  var_0["unitednations"] = 0;
  var_0["unitednationsfemale"] = 1;
  var_0["unitedstates"] = 0;
  var_0["unitedstatesfemale"] = 1;
  var_0["sas"] = 0;
  var_0["sasfemale"] = 1;
  var_0["fsa"] = 4;
  var_0["fsafemale"] = 5;
  var_0["alqatala"] = 2;
  var_0["alqatalafemale"] = 3;
  var_0["russian"] = 6;

  foreach(var_3, var_2 in var_0) {
    level.names[var_3] = [];

    if(var_2 < 0) {
      continue;
    }
    table_get_names(var_3, var_2);
  }

  init_script_friendnames();

  foreach(var_3, var_2 in var_0) {
    remove_script_friendnames_from_list(var_3);
    randomize_name_list(var_3);
    level.nameindex[var_3] = 0;
  }

  var_0 = undefined;
}

table_get_names(var_0, var_1) {
  var_2 = tablelookuprownum("sp/names.csv", var_1, "__END__");
  var_3 = [];

  for(var_4 = 0; var_4 < var_2; var_4++)
    var_3[var_4] = var_4;

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_5 = min(50, var_2);

  for(var_4 = 0; var_4 < var_5; var_4++)
    add_name_from_table(var_0, var_3[var_4], var_1);

  var_3 = undefined;
}

add_name_from_table(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("sp/names.csv", var_1, var_2);
  add_name(var_0, var_3);
}

copy_names(var_0, var_1) {
  level.names[var_0] = level.names[var_1];
}

add_name(var_0, var_1) {
  level.names[var_0][level.names[var_0].size] = var_1;
}

add_names(var_0, var_1) {
  foreach(var_3 in var_1)
  level.names[var_0][level.names[var_0].size] = var_3;
}

remove_name(var_0, var_1) {
  level.names[var_0] = scripts\engine\utility::array_remove(level.names[var_0], var_1);
}

init_script_friendnames() {
  var_0 = [];
  var_1 = getspawnerarray();
  var_2 = getaiarray();

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_friendname) && var_4.script_friendname != "none") {
      var_5 = normalize_script_friendname(var_4.script_friendname);
      var_0[var_0.size] = var_5;
    }
  }

  foreach(var_8 in var_2) {
    if(isDefined(var_8.script_friendname) && var_8.script_friendname != "none") {
      var_5 = normalize_script_friendname(var_8.script_friendname);
      var_0[var_0.size] = var_5;
    }
  }

  level.script_friendnames = var_0;
}

normalize_script_friendname(var_0) {
  var_1 = strtok(var_0, " ");

  if(var_1.size > 1)
    var_0 = var_1[1];

  return var_0;
}

remove_script_friendnames_from_list(var_0) {
  foreach(var_2 in level.script_friendnames) {
    foreach(var_4 in level.names[var_0]) {
      if(var_2 == var_4)
        remove_name(var_0, var_4);
    }
  }
}

randomize_name_list(var_0) {
  var_1 = level.names[var_0].size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(var_1);
    var_4 = level.names[var_0][var_2];
    level.names[var_0][var_2] = level.names[var_0][var_3];
    level.names[var_0][var_3] = var_4;
  }
}

get_name(var_0) {
  if(isDefined(self.team) && self.team == "neutral") {
    return;
  }
  getcallsign();

  if(isDefined(self.script_friendname)) {
    if(self.script_friendname == "none") {
      return;
    }
    self.name = self.script_friendname;
    getrankfromname(self.name);
    self notify("set name and rank");
    return;
  }

  get_name_for_nationality(self.voice);
  self notify("set name and rank");
}

get_name_for_nationality(var_0) {
  level.nameindex[var_0] = (level.nameindex[var_0] + 1) % level.names[var_0].size;
  var_1 = level.names[var_0][level.nameindex[var_0]];
  var_2 = randomint(10);

  if(nationalityusessurnames(var_0)) {
    var_3 = var_0 + "_surnames";
    level.nameindex[var_3] = (level.nameindex[var_3] + 1) % level.names[var_3].size;
    var_1 = var_1 + " " + level.names[var_3][level.nameindex[var_3]];
  }

  if(nationalityusescallsigns(var_0)) {
    var_4 = var_1;
    self.airank = "private";
  } else {
    var_2 = getrank(var_0, var_2);
    var_4 = var_2 + var_1;
    self.airank = "sergeant";
  }

  if(isai(self) && self isbadguy())
    self.ainame = var_4;
  else
    self.name = var_4;
}

getcallsign() {
  if(isDefined(self.script_callsign)) {
    if(self.script_callsign == "none") {
      return;
    }
    self.callsign = self.script_callsign;
    return;
  }
}

getrank(var_0, var_1) {
  if(var_0 == "unitednations") {
    if(var_1 > 5) {
      self.airank = "private";
      return "Cst. ";
    } else if(var_1 > 2) {
      self.airank = "private";
      return "Sgt. ";
    } else {
      self.airank = "sergeant";
      return "Insp. ";
    }
  } else if(var_0 == "sas") {
    if(var_1 > 5) {
      self.airank = "private";
      return "Pte. ";
    } else if(var_1 > 2) {
      self.airank = "private";
      return "Cpl. ";
    } else {
      self.airank = "sergeant";
      return "Sgt. ";
    }
  } else if(var_1 > 5) {
    self.airank = "private";
    return "Pvt. ";
  } else if(var_1 > 2) {
    self.airank = "private";
    return "Cpl. ";
  } else {
    self.airank = "sergeant";
    return "Sgt. ";
  }
}

getrankfromname(var_0) {
  if(!isDefined(var_0))
    self.airank = "private";

  var_1 = strtok(var_0, " ");
  var_2 = var_1[0];

  switch (var_2) {
    case "Pvt.":
      self.airank = "private";
      break;
    case "Pfc.":
      self.airank = "private";
      break;
    case "Agent":
      self.airank = "private";
      break;
    case "Cpl.":
      self.airank = "corporal";
      break;
    case "Sgt.":
      self.airank = "sergeant";
      break;
    case "Lt.":
      self.airank = "lieutenant";
      break;
    case "Cpt.":
      self.airank = "captain";
      break;
    default:
      self.airank = "private";
      break;
  }
}

nationalityusescallsigns(var_0) {
  switch (var_0) {
    case "fsafemale":
    case "fsa":
      return 1;
  }

  return 0;
}

nationalityusessurnames(var_0) {
  return isDefined(level.names[var_0 + "_surnames"]);
}