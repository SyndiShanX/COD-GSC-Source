/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\names.gsc
**************************************/

#using scripts\engine\utility;
#namespace names;

function main() {}

function setup_names() {
  if(isDefined(level.names)) {
    return;
  }

  level.names = spawnStruct();
  level.names.nameindex = [];
  level.names.ranks = [];
  level.names.surnames = [];
  level.names.use_ranks = [];

  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  function_296f4dd56d3f4db8(level.gamemodebundle.campaignnames);
}

function private function_296f4dd56d3f4db8(bundlename) {
  if(!isDefined(bundlename)) {
    return;
  }

  bundle = getscriptbundle("\x85[:V\xe0Z\xa4^~a\x18\xe0\xdbO" + bundlename);
  init_ranks(#"", bundle.ranks);

  foreach(nationality in bundle.var_825b08d684727b3c) {
    nationalityhash = getxhash(nationality.internalname);
    init_ranks(nationalityhash, nationality.ranks);
    init_surnames(bundle.csv, nationalityhash, nationality.column);
    level.names.use_ranks[nationalityhash] = istrue(nationality.useranks);
  }

  init_script_friendnames();

  foreach(nationality, surnames in level.names.surnames) {
    remove_script_friendnames_from_list(nationality);
    randomize_name_list(nationality);
    level.names.nameindex[nationality] = 0;
  }
}

function private init_ranks(nationality, ranksarray) {
  assert(!isDefined(level.names.ranks[nationality]));

  if(isarray(ranksarray) && ranksarray.size > 0) {
    level.names.ranks[nationality] = [];

    foreach(rank in ranksarray) {
      newindex = level.names.ranks[nationality].size;
      level.names.ranks[nationality][newindex] = structcopy(rank, 1);
    }
  }
}

function private init_surnames(csvname, nationality, column) {
  assert(!isDefined(level.names.surnames[nationality]));
  level.names.surnames[nationality] = [];
  last_row = tablelookuprownum(csvname, column, "\x86\xcf\xef9\x92}\x91");
  temp_array = [];

  for(i = 0; i < last_row; i++) {
    temp_array[i] = i;
  }

  randomizedarray = utility::array_randomize(temp_array);
  limit = min(50, last_row);

  for(i = 0; i < limit; i++) {
    add_name_from_table(csvname, nationality, randomizedarray[i], column);
  }
}

function add_name_from_table(csvname, nationality, row_num, column) {
  name = tablelookupbyrow(csvname, row_num, column);
  add_name(nationality, name);
}

function copy_names(copyto, copyfrom) {
  assert(isDefined(level.names[copyfrom]) && level.names[copyfrom].size);
  level.names[copyto] = level.names[copyfrom];
}

function add_name(nationality, thename) {
  level.names.surnames[nationality][level.names.surnames[nationality].size] = thename;
}

function add_names(nationality, thenames) {
  foreach(thename in thenames) {
    level.names.surnames[nationality][level.names.surnames[nationality].size] = thename;
  }
}

function remove_name(nationality, thename) {
  level.names.surnames[nationality] = arrayremove(level.names.surnames[nationality], thename);
}

function init_script_friendnames() {
  script_friendnames = [];
  spawners = getspawnerarray();
  ais = getaiarray();

  foreach(spawner in spawners) {
    if(isDefined(spawner.script_friendname) && spawner.script_friendname != "\r+x5") {
      name = normalize_script_friendname(spawner.script_friendname);
      script_friendnames[script_friendnames.size] = name;
    }
  }

  foreach(ai in ais) {
    if(isDefined(ai.script_friendname) && ai.script_friendname != "\r+x5") {
      name = normalize_script_friendname(ai.script_friendname);
      script_friendnames[script_friendnames.size] = name;
    }
  }

  level.names.script_friendnames = script_friendnames;
}

function normalize_script_friendname(name) {
  tokens = strtok(name, "\xda");

  if(tokens.size > 1) {
    name = tokens[1];
  }

  return name;
}

function remove_script_friendnames_from_list(nationality) {
  foreach(scriptedname in level.names.script_friendnames) {
    foreach(staticname in level.names.surnames[nationality]) {
      if(scriptedname == staticname) {
        remove_name(nationality, staticname);
      }
    }
  }
}

function randomize_name_list(nationality) {
  size = level.names.surnames[nationality].size;

  for(i = 0; i < size; i++) {
    switchwith = randomint(size);
    temp = level.names.surnames[nationality][i];
    level.names.surnames[nationality][i] = level.names.surnames[nationality][switchwith];
    level.names.surnames[nationality][switchwith] = temp;
  }
}

function get_name(override) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  if(isDefined(self.team) && self.team == "\xba\xa5\x1f\xc9m\x80i") {
    return;
  }

  getcallsign();

  if(isDefined(self.script_friendname)) {
    if(self.script_friendname == "\r+x5") {
      return;
    }

    self.name = self.script_friendname;
    getrankfromname(self.name);
    self notify("\x13\x8f\xeb>\xbf6\b4x<\xf4t<Z^A\x11");
    return;
  }

  assert(isDefined(level.names.surnames));
  get_name_for_nationality(self.voice);
  self notify("\x13\x8f\xeb>\xbf6\b4x<\xf4t<Z^A\x11");
}

function get_name_for_nationality(nationality) {
  fullname = "";
  self.airank = "8\xf2\x91\x92q\xe5\x84";

  if(isDefined(level.names.nameindex[nationality])) {
    level.names.nameindex[nationality] = (level.names.nameindex[nationality] + 1) % level.names.surnames[nationality].size;
    name = level.names.surnames[nationality][level.names.nameindex[nationality]];
    rank = randomint(10);

    if(!istrue(level.names.use_ranks[nationality])) {
      fullname = name;
      self.airank = "8\xf2\x91\x92q\xe5\x84";
    } else {
      rank = getrank(nationality, rank);
      fullname = rank + "\xda" + name;
      self.airank = "\xf0\xc6\xe9\x8d\xb6\xbe#4";
    }
  }

  if(isai(self) && self isbadguy()) {
    self.ainame = fullname;
    return;
  }

  self.name = fullname;
}

function getcallsign() {
  if(isDefined(self.script_callsign)) {
    if(self.script_callsign == "\r+x5") {
      return;
    }

    self.callsign = self.script_callsign;
    return;
  }
}

function getrank(nationality, rank) {
  rankstable = level.names.ranks[nationality];

  if(!isDefined(rankstable) || rankstable.size == 0) {
    rankstable = level.names.ranks[#""];
  }

  if(!isDefined(rankstable)) {
    self.airank = "8\xf2\x91\x92q\xe5\x84";
    return "Ag\x8e\\";
  }

  foreach(rankinfo in rankstable) {
    if(rank >= rankinfo.threshold) {
      self.airank = rankinfo.internalname;
      return rankinfo.displayname;
    }
  }
}

function getrankfromname(name) {
  self.airank = "8\xf2\x91\x92q\xe5\x84";

  if(!isDefined(name)) {
    return;
  }

  tokens = strtok(name, "\xda");
  assert(tokens.size);
  shortrank = tokens[0];

  foreach(ranks in level.names.ranks) {
    foreach(rankinfo in ranks) {
      if(shortrank == rankinfo.displayname) {
        self.airank = rankinfo.internalname;
        return;
      }
    }
  }
}