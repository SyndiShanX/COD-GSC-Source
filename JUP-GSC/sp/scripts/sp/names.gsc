/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\names.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace names;

function main() {}

function setup_names() {
  if(isDefined(level.names)) {
    return;
  }

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  var_751ffaebfd2f0181[#"unitednations"] = 0;
  var_751ffaebfd2f0181[#"unitednationsfemale"] = 1;
  var_751ffaebfd2f0181[#"unitedstates"] = 0;
  var_751ffaebfd2f0181[#"unitedstatesfemale"] = 1;
  var_751ffaebfd2f0181[#"sas"] = 0;
  var_751ffaebfd2f0181[#"sasfemale"] = 1;
  var_751ffaebfd2f0181[#"fsa"] = 4;
  var_751ffaebfd2f0181[#"fsafemale"] = 5;
  var_751ffaebfd2f0181[#"alqatala"] = 2;
  var_751ffaebfd2f0181[#"alqatalafemale"] = 3;
  var_751ffaebfd2f0181[#"russian"] = 6;
  var_751ffaebfd2f0181[#"russianfemale"] = 6;
  var_751ffaebfd2f0181[#"cartel"] = 8;
  var_751ffaebfd2f0181[#"hash_3df7c24714e86e6d"] = 8;
  var_751ffaebfd2f0181[#"hash_d700685400fbffa1"] = 8;
  var_751ffaebfd2f0181[#"hash_5f1ef8142f0b6fcb"] = 8;
  var_751ffaebfd2f0181[#"shadowcompany"] = 0;
  var_751ffaebfd2f0181[#"konni"] = 6;

  foreach(nationality, column in var_751ffaebfd2f0181) {
    level.names[nationality] = [];

    if(column < 0) {
      continue;
    }

    table_get_names(nationality, column);
  }

  init_script_friendnames();

  foreach(nationality, column in var_751ffaebfd2f0181) {
    remove_script_friendnames_from_list(nationality);
    randomize_name_list(nationality);
    level.nameindex[nationality] = 0;
  }

  var_751ffaebfd2f0181 = undefined;
}

function table_get_names(nationality, column) {
  last_row = tablelookuprownum("sp/names.csv", column, "__END__");
  temp_array = [];

  for(i = 0; i < last_row; i++) {
    temp_array[i] = i;
  }

  temp_array = array_randomize(temp_array);
  limit = min(50, last_row);

  for(i = 0; i < limit; i++) {
    add_name_from_table(nationality, temp_array[i], column);
  }

  temp_array = undefined;
}

function add_name_from_table(nationality, row_num, column) {
  name = tablelookupbyrow("sp/names.csv", row_num, column);
  add_name(nationality, name);
}

function copy_names(copyto, copyfrom) {
  assert(isDefined(level.names[copyfrom]) && level.names[copyfrom].size);
  level.names[copyto] = level.names[copyfrom];
}

function add_name(nationality, thename) {
  level.names[nationality][level.names[nationality].size] = thename;
}

function add_names(nationality, thenames) {
  foreach(thename in thenames) {
    level.names[nationality][level.names[nationality].size] = thename;
  }
}

function remove_name(nationality, thename) {
  level.names[nationality] = array_remove(level.names[nationality], thename);
}

function init_script_friendnames() {
  script_friendnames = [];
  spawners = getspawnerarray();
  ais = getaiarray();

  foreach(spawner in spawners) {
    if(isDefined(spawner.script_friendname) && spawner.script_friendname != "none") {
      name = normalize_script_friendname(spawner.script_friendname);
      script_friendnames[script_friendnames.size] = name;
    }
  }

  foreach(ai in ais) {
    if(isDefined(ai.script_friendname) && ai.script_friendname != "none") {
      name = normalize_script_friendname(ai.script_friendname);
      script_friendnames[script_friendnames.size] = name;
    }
  }

  level.script_friendnames = script_friendnames;
}

function normalize_script_friendname(name) {
  tokens = strtok(name, " ");

  if(tokens.size > 1) {
    name = tokens[1];
  }

  return name;
}

function remove_script_friendnames_from_list(nationality) {
  foreach(scriptedname in level.script_friendnames) {
    foreach(staticname in level.names[nationality]) {
      if(scriptedname == staticname) {
        remove_name(nationality, staticname);
      }
    }
  }
}

function randomize_name_list(nationality) {
  size = level.names[nationality].size;

  for(i = 0; i < size; i++) {
    switchwith = randomint(size);
    temp = level.names[nationality][i];
    level.names[nationality][i] = level.names[nationality][switchwith];
    level.names[nationality][switchwith] = temp;
  }
}

function get_name(override) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

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

  assert(isDefined(level.names));
  get_name_for_nationality(self.voice);
  self notify("set name and rank");
}

function get_name_for_nationality(nationality) {
  assertex(isDefined(level.nameindex[nationality]), nationality);
  level.nameindex[nationality] = (level.nameindex[nationality] + 1) % level.names[nationality].size;
  name = level.names[nationality][level.nameindex[nationality]];
  rank = randomint(10);

  if(nationalityusessurnames(nationality)) {
    var_950abbbb5d12325f = hashcat(nationality, "_surnames");
    level.nameindex[var_950abbbb5d12325f] = (level.nameindex[var_950abbbb5d12325f] + 1) % level.names[var_950abbbb5d12325f].size;
    name = name + " " + level.names[var_950abbbb5d12325f][level.nameindex[var_950abbbb5d12325f]];
  }

  if(nationalityusescallsigns(nationality)) {
    fullname = name;
    self.airank = "private";
  } else {
    rank = getrank(nationality, rank);
    fullname = rank + name;
    self.airank = "sergeant";
  }

  if(isai(self) && self isbadguy()) {
    self.ainame = fullname;
    return;
  }

  self.name = fullname;
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

function getrank(nationality, rank) {
  if(nationality == "unitednations") {
    if(rank > 5) {
      self.airank = "private";
      return "Cst. ";
    } else if(rank > 2) {
      self.airank = "private";
      return "Sgt. ";
    } else {
      self.airank = "sergeant";
      return "Insp. ";
    }

    return;
  }

  if(nationality == "sas") {
    if(rank > 5) {
      self.airank = "private";
      return "Pte. ";
    } else if(rank > 2) {
      self.airank = "private";
      return "Cpl. ";
    } else {
      self.airank = "sergeant";
      return "Sgt. ";
    }

    return;
  }

  if(rank > 5) {
    self.airank = "private";
    return "Pvt. ";
  }

  if(rank > 2) {
    self.airank = "private";
    return "Cpl. ";
  }

  self.airank = "sergeant";
  return "Sgt. ";
}

function getrankfromname(name) {
  if(!isDefined(name)) {
    self.airank = "private";
  }

  tokens = strtok(name, " ");
  assert(tokens.size);
  shortrank = tokens[0];

  switch (shortrank) {
    case #"hash_5072174a5dc37869":
      self.airank = "private";
      break;
    case #"hash_d73e854a1d933402":
      self.airank = "private";
      break;
    case #"hash_60a1e36031bf79e6":
      self.airank = "private";
      break;
    case #"hash_578ee0eed2553410":
      self.airank = "corporal";
      break;
    case #"hash_da838e4f6c421aad":
      self.airank = "sergeant";
      break;
    case #"hash_1e2d1d6c9ffacbb9":
      self.airank = "lieutenant";
      break;
    case #"hash_57a7e0eed268bbc8":
      self.airank = "captain";
      break;
    default:
      self.airank = "private";
      break;
  }
}

function nationalityusescallsigns(nationality) {
  switch (nationality) {
    case #"fsafemale":
    case #"fsa":
      return true;
  }

  return false;
}

function nationalityusessurnames(nationality) {
  return isDefined(level.names[hashcat(nationality, "_surnames")]);
}