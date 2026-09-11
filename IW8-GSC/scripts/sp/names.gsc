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

function table_get_names(var0, var1) {
  var2 = tablelookuprownum("sp/names.csv", var1, "__END__");
  var3 = [];

  for(var4 = 0; var4 < var2; var4++) {
    var3 = var4;
  }

  var3 = scripts\engine\utility::array_randomize(var3);
  var5 = min(50, var2);

  for(var4 = 0; var4 < var5; var4++) {
    add_name_from_table(var0, var3[var4], var1);
  }

  var3 = undefined;
}

function add_name_from_table(var0, var1, var2) {
  var3 = tablelookupbyrow("sp/names.csv", var1, var2);
  add_name(var0, var3);
}

function copy_names(var0, var1) {
  level.names[var0] = level.names[var1];
}

function add_name(var0, var1) {
  level.names[var0][level.names[var0].size] = var1;
}

function add_names(var0, var1) {
  foreach(var3 in var1) {
    level.names[var0][level.names[var0].size] = var3;
  }
}

function remove_name(var0, var1) {
  level.names[var0] = scripts\engine\utility::array_remove(level.names[var0], var1);
}

function init_script_friendnames() {
  var0 = [];
  var1 = getspawnerarray();
  var2 = getaiarray();

  foreach(var4 in var1) {
    if(isDefined(var4.script_friendname) && var4.script_friendname != "none") {
      var5 = normalize_script_friendname(var4.script_friendname);
      var0 = var5;
    }
  }

  foreach(var8 in var2) {
    if(isDefined(var8.script_friendname) && var8.script_friendname != "none") {
      var5 = normalize_script_friendname(var8.script_friendname);
      var0 = var5;
    }
  }

  level.script_friendnames = var0;
}

function normalize_script_friendname(var0) {
  var1 = strtok(var0, " ");

  if(var1.size > 1) {
    var0 = var1[1];
  }

  return var0;
}

function remove_script_friendnames_from_list(var0) {
  foreach(var2 in level.script_friendnames) {
    foreach(var4 in level.names[var0]) {
      if(var2 == var4) {
        remove_name(var0, var4);
      }
    }
  }
}

function randomize_name_list(var0) {
  var1 = level.names[var0].size;

  for(var2 = 0; var2 < var1; var2++) {
    var3 = randomint(var1);
    var4 = level.names[var0][var2];
    level.names[var0][var2] = level.names[var0][var3];
    level.names[var0][var3] = var4;
  }
}

function get_name(var0) {
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

function get_name_for_nationality(var0) {
  level.nameindex[var0] = (level.nameindex[var0] + 1) % level.names[var0].size;
  var1 = level.names[var0][level.nameindex[var0]];
  var2 = randomint(10);

  if(nationalityusessurnames(var0)) {
    var3 = var0 + "_surnames";
    level.nameindex[var3] = (level.nameindex[var3] + 1) % level.names[var3].size;
    var1 = var1 + " " + level.names[var3][level.nameindex[var3]];
  }

  if(nationalityusescallsigns(var0)) {
    var4 = var1;
    self.airank = "private";
  } else {
    var4 = getrank(var1, var4);
    var4 += var2;
    self.airank = "sergeant";
  }

  if(isai(self) && self isbadguy()) {
    self.ainame = var4;
    return;
  }

  self.name = var4;
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

function getrank(var0, var1) {
  if(var0 == "unitednations") {
    if(var1 > 5) {
      self.airank = "private";
      return "Cst. ";
    }

    if(var1 > 2) {
      self.airank = "private";
      return "Sgt. ";
    }

    self.airank = "sergeant";
    return "Insp. ";
  }

  if(var0 == "sas") {
    if(var1 > 5) {
      self.airank = "private";
      return "Pte. ";
    }

    if(var1 > 2) {
      self.airank = "private";
      return "Cpl. ";
    }

    self.airank = "sergeant";
    return "Sgt. ";
  }

  if(var1 > 5) {
    self.airank = "private";
    return "Pvt. ";
  }

  if(var1 > 2) {
    self.airank = "private";
    return "Cpl. ";
  }

  self.airank = "sergeant";
  return "Sgt. ";
}

function getrankfromname(var0) {
  if(!isDefined(var0)) {
    self.airank = "private";
  }

  var1 = strtok(var0, " ");
  var2 = var1[0];

  switch (var2) {
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

function nationalityusescallsigns(var0) {
  switch (var0) {
    case "fsafemale":
    case "fsa":
      return true;
  }

  return false;
}

function nationalityusessurnames(var0) {
  return isDefined(level.names[var0 + "_surnames"]);
}