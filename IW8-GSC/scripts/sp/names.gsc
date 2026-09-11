/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\names.gsc
***********************************************/

function main() {}

function setup_names() {
  if(isDefined(level.names)) {
    return;
  }

  GscBinSkip1(0x45, "unitednations", 0);
}

function table_get_names(var_0, var_1) {
  var_2 = tablelookuprownum("sp/names.csv", var_1, "__END__");
  var_3 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_3 = var_4;
  }

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_5 = min(50, var_2);

  for(var_4 = 0; var_4 < var_5; var_4++) {
    add_name_from_table(var_0, var_3[var_4], var_1);
  }

  var_3 = undefined;
}

function add_name_from_table(var_0, var_1, var_2) {
  var_3 = tablelookupbyrow("sp/names.csv", var_1, var_2);
  add_name(var_0, var_3);
}

function copy_names(var_0, var_1) {
  level.names[var_0] = level.names[var_1];
}

function add_name(var_0, var_1) {
  level.names[var_0][level.names[var_0].size] = var_1;
}

function add_names(var_0, var_1) {
  foreach(var_3 in var_1) {
    level.names[var_0][level.names[var_0].size] = var_3;
  }
}

function remove_name(var_0, var_1) {
  level.names[var_0] = scripts\engine\utility::array_remove(level.names[var_0], var_1);
}

function init_script_friendnames() {
  var_0 = [];
  var_1 = getspawnerarray();
  var_2 = getaiarray();

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_friendname) && var_4.script_friendname != "none") {
      var_5 = normalize_script_friendname(var_4.script_friendname);
      var_0 = var_5;
    }
  }

  foreach(var_8 in var_2) {
    if(isDefined(var_8.script_friendname) && var_8.script_friendname != "none") {
      var_5 = normalize_script_friendname(var_8.script_friendname);
      var_0 = var_5;
    }
  }

  level.script_friendnames = var_0;
}

function normalize_script_friendname(var_0) {
  var_1 = strtok(var_0, " ");

  if(var_1.size > 1) {
    var_0 = var_1[1];
  }

  return var_0;
}

function remove_script_friendnames_from_list(var_0) {
  foreach(var_2 in level.script_friendnames) {
    foreach(var_4 in level.names[var_0]) {
      if(var_2 == var_4) {
        remove_name(var_0, var_4);
      }
    }
  }
}

function randomize_name_list(var_0) {
  var_1 = level.names[var_0].size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(var_1);
    var_4 = level.names[var_0][var_2];
    level.names[var_0][var_2] = level.names[var_0][var_3];
    level.names[var_0][var_3] = var_4;
  }
}

function get_name(var_0) {
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

function get_name_for_nationality(var_0) {
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
    var_4 = getrank(var_1, var_4);
    var_4 += var_2;
    self.airank = "sergeant";
  }

  if(isai(self) && self isbadguy()) {
    self.ainame = var_4;
    return;
  }

  self.name = var_4;
}

function getcallsign() {
  if(isDefined(self.script_callsign)) {
    if(self.script_callsign == "none") {
      return;
    }

    self.callsign = self.script_callsign;
    return;
  }
}

function getrank(var_0, var_1) {
  if(var_0 == "unitednations") {
    if(var_1 > 5) {
      self.airank = "private";
      return "Cst. ";
    }

    if(var_1 > 2) {
      self.airank = "private";
      return "Sgt. ";
    }

    self.airank = "sergeant";
    return "Insp. ";
  }

  if(var_0 == "sas") {
    if(var_1 > 5) {
      self.airank = "private";
      return "Pte. ";
    }

    if(var_1 > 2) {
      self.airank = "private";
      return "Cpl. ";
    }

    self.airank = "sergeant";
    return "Sgt. ";
  }

  if(var_1 > 5) {
    self.airank = "private";
    return "Pvt. ";
  }

  if(var_1 > 2) {
    self.airank = "private";
    return "Cpl. ";
  }

  self.airank = "sergeant";
  return "Sgt. ";
}

function getrankfromname(var_0) {
  if(!isDefined(var_0)) {
    self.airank = "private";
  }

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

function nationalityusescallsigns(var_0) {
  switch (var_0) {
    case "fsafemale":
    case "fsa":
      return true;
  }

  return false;
}

function nationalityusessurnames(var_0) {
  return isDefined(level.names[var_0 + "_surnames"]);
}