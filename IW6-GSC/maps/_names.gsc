/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_names.gsc
*****************************************************/

setup_names() {
  if(isDefined(level.names)) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "american";
  var_0[var_0.size] = "seal";
  var_0[var_0.size] = "taskforce";
  var_0[var_0.size] = "secretservice";
  var_0[var_0.size] = "british";
  var_0[var_0.size] = "arab";
  var_0[var_0.size] = "russian";
  var_0[var_0.size] = "multilingual";
  var_0[var_0.size] = "portuguese";
  var_0[var_0.size] = "shadowcompany";
  var_0[var_0.size] = "delta";
  var_0[var_0.size] = "french";
  var_0[var_0.size] = "african";
  var_0[var_0.size] = "czech";
  var_0[var_0.size] = "czech_surnames";
  var_0[var_0.size] = "pmc";

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level.names[var_0[var_1]] = [];
  }

  add_name("american", "Smith");
  add_name("american", "Johnson");
  add_name("american", "Williams");
  add_name("american", "Jones");
  add_name("american", "Brown");
  add_name("american", "Davis");
  add_name("american", "Miller");
  add_name("american", "Wilson");
  add_name("american", "Moore");
  add_name("american", "Taylor");
  add_name("american", "Anderson");
  add_name("american", "Thomas");
  add_name("american", "Jackson");
  add_name("american", "White");
  add_name("american", "Harris");
  add_name("american", "Martin");
  add_name("american", "Garcia");
  add_name("american", "Martinez");
  add_name("american", "Robinson");
  add_name("american", "Clark");
  add_name("american", "Rodriguez");
  add_name("american", "Lewis");
  add_name("american", "Lee");
  add_name("american", "Hall");
  add_name("american", "Allen");
  add_name("american", "Young");
  add_name("american", "Hernandez");
  add_name("american", "King");
  add_name("seal", "Angel");
  add_name("seal", "Apex");
  add_name("seal", "Bearcat");
  add_name("seal", "Bishop");
  add_name("seal", "Boomer");
  add_name("seal", "Boxer");
  add_name("seal", "Canine");
  add_name("seal", "Chemist");
  add_name("seal", "Chemo");
  add_name("seal", "Cherub");
  add_name("seal", "Chino");
  add_name("seal", "Coffin");
  add_name("seal", "Coma");
  add_name("seal", "Cyclops");
  add_name("seal", "Cypher");
  add_name("seal", "Doc");
  add_name("seal", "Druid");
  add_name("seal", "Exxon");
  add_name("seal", "Gator");
  add_name("seal", "Hannibal");
  add_name("seal", "Hazard");
  add_name("seal", "Hitman");
  add_name("seal", "Jayhawk");
  add_name("seal", "Jester");
  add_name("seal", "Justice");
  add_name("seal", "Klepto");
  add_name("seal", "Kojak");
  add_name("seal", "Langley");
  add_name("seal", "Neptune");
  add_name("seal", "Mamba");
  add_name("seal", "Midnight");
  add_name("seal", "Neon");
  add_name("seal", "Nomad");
  add_name("seal", "Ogre");
  add_name("seal", "Ozone");
  add_name("seal", "Patron");
  add_name("seal", "Pharaoh");
  add_name("seal", "Pieces");
  add_name("seal", "Poet");
  add_name("seal", "Preacher");
  add_name("seal", "Reaper");
  add_name("seal", "Redcell");
  add_name("seal", "Roadie");
  add_name("seal", "Robot");
  add_name("seal", "Rocket");
  add_name("seal", "Rooster");
  add_name("seal", "Sparrow");
  add_name("seal", "Taco");
  add_name("seal", "Thumper");
  add_name("seal", "Trojan");
  add_name("seal", "Twister");
  add_name("seal", "Undertone");
  add_name("seal", "Utah");
  add_name("seal", "Whiskey");
  add_name("seal", "Worm");
  add_name("seal", "Yankee");
  add_name("seal", "Zero");
  copy_names("taskforce", "seal");
  copy_names("delta", "seal");
  add_name("secretservice", "Smith");
  add_name("secretservice", "Jones");
  add_name("british", "Abbot");
  add_name("british", "Adams");
  add_name("british", "Bartlett");
  add_name("british", "Boyd");
  add_name("russian", "Sasha Ivanov");
  add_name("russian", "Aleksei Vyshinskiy");
  add_name("russian", "Boris Ryzhkov");
  add_name("russian", "Dima Tikhonov");
  add_name("russian", "Oleg Kosygin");
  add_name("arab", "Abdulaziz");
  add_name("arab", "Abdullah");
  add_name("arab", "Ali");
  add_name("portuguese", "Carlitos");
  add_name("portuguese", "Antonio");
  add_name("portuguese", "Gervasio");
  add_name("portuguese", "Lois");
  add_name("portuguese", "Xesus");
  add_name("shadowcompany", "Lestat");
  add_name("shadowcompany", "Nosferatu");
  add_name("shadowcompany", "Lecter");
  add_name("multilingual", "Kugelschreiber");
  add_name("multilingual", "Flughafen");
  add_name("french", "Astor");
  add_name("french", "Beliveau");
  add_name("african", "Sulaiman");
  add_name("african", "Camara");
  add_name("african", "Mustapha");
  add_name("african", "Abubakarr");
  add_name("czech", "Andrej");
  add_name("czech", "Anton");
  add_name("czech_surnames", "Blumel");
  add_name("czech_surnames", "Maly");
  add_name("czech_surnames", "Pospisil");
  copy_names("pmc", "czech_surnames");
  init_script_friendnames();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    remove_script_friendnames_from_list(var_0[var_1]);
    randomize_name_list(var_0[var_1]);
    level.nameindex[var_0[var_1]] = 0;
  }
}

copy_names(var_0, var_1) {
  level.names[var_0] = level.names[var_1];
}

add_name(var_0, var_1) {
  level.names[var_0][level.names[var_0].size] = var_1;
}

remove_name(var_0, var_1) {
  level.names[var_0] = common_scripts\utility::array_remove(level.names[var_0], var_1);
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

  if(var_1.size > 1) {
    var_0 = var_1[1];
  }

  return var_0;
}

remove_script_friendnames_from_list(var_0) {
  foreach(var_2 in level.script_friendnames) {
    foreach(var_4 in level.names[var_0]) {
      if(var_2 == var_4) {
        remove_name(var_0, var_4);
      }
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
  } else if(var_0 == "secretservice") {
    var_4 = "Agent " + var_1;
    self.airank = "private";
  } else if(var_2 > 5) {
    var_4 = "Pvt. " + var_1;
    self.airank = "private";
  } else if(var_2 > 2) {
    var_4 = "Cpl. " + var_1;
    self.airank = "private";
  } else {
    var_4 = "Sgt. " + var_1;
    self.airank = "sergeant";
  }

  if(isai(self) && self isbadguy()) {
    self.ainame = var_4;
  }
  else {
    self.name = var_4;
  }
}

getrankfromname(var_0) {
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

nationalityusescallsigns(var_0) {
  switch (var_0) {
    case "czech":
    case "delta":
    case "taskforce":
    case "seal":
      return 1;
  }

  return 0;
}

nationalityusessurnames(var_0) {
  return isDefined(level.names[var_0 + "_surnames"]);
}