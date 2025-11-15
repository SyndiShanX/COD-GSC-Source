/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_names.gsc
**************************************/

main() {}
setup_names() {
  assert(!isDefined(level.names));
  nationalities = [];
  nationalities[0] = "american";
  nationalities[1] = "british";
  nationalities[2] = "russian";
  nationalities[3] = "german";
  nationalities[4] = "japanese";
  for(i = 0; i < nationalities.size; i++) {
    level.names[nationalities[i]] = [];
  }
  american_names();
  british_names();
  russian_names();
  japanese_names();
  german_names();
  for(i = 0; i < nationalities.size; i++) {
    randomize_name_list(nationalities[i]);
    level.nameIndex[nationalities[i]] = 0;
  }
}

american_names() {
  add_name("american", "Adams");
  add_name("american", "Allen");
  add_name("american", "Baker");
  add_name("american", "Brown");
  add_name("american", "Cook");
  add_name("american", "Clarkson");
  add_name("american", "Davis");
  add_name("american", "Edwards");
  add_name("american", "Fletcher");
  add_name("american", "Groves");
  add_name("american", "Grant");
  add_name("american", "Hammond");
  add_name("american", "Hacker");
  add_name("american", "Howard");
  add_name("american", "Jackson");
  add_name("american", "Jones");
  add_name("american", "Lamia");
  add_name("american", "Livingstone");
  add_name("american", "Moore");
  add_name("american", "Mitchell");
  add_name("american", "Nelson");
  add_name("american", "Nash");
  add_name("american", "Osborne");
  add_name("american", "Paige");
  add_name("american", "Pearce");
  add_name("american", "Pepper");
  add_name("american", "Ross");
  add_name("american", "Saxon");
  add_name("american", "Sloan");
  add_name("american", "Scott");
  add_name("american", "Stohl");
  add_name("american", "Suarez");
  add_name("american", "Thompson");
  add_name("american", "Welch");
}

british_names() {
  add_name("british", "Abbot");
}

german_names() {
  add_name("german", "Adler");
}

japanese_names() {
  add_name("japanese", "Aichi");
}

russian_names() {
  add_name("russian", "Avtamonov");
  add_name("russian", "Barzilovich");
  add_name("russian", "Blyakher");
  add_name("russian", "Bulenkov");
  add_name("russian", "Datsyuk");
  add_name("russian", "Diakov");
  add_name("russian", "Dvilyansky");
  add_name("russian", "Dymarsky");
  add_name("russian", "Fedorova");
  add_name("russian", "Gerasimov");
  add_name("russian", "Ilyin");
  add_name("russian", "Ikonnikov");
  add_name("russian", "Kosteltsev");
  add_name("russian", "Krasilnikov");
  add_name("russian", "Lukin");
  add_name("russian", "Maximov");
  add_name("russian", "Melnikov");
  add_name("russian", "Nesterov");
  add_name("russian", "Pelov");
  add_name("russian", "Polubencev");
  add_name("russian", "Pokrovsky");
  add_name("russian", "Repin");
  add_name("russian", "Romanenko");
  add_name("russian", "Saslovsky");
  add_name("russian", "Sidorenko");
  add_name("russian", "Touevsky");
  add_name("russian", "Vakhitov");
  add_name("russian", "Yakubov");
  add_name("russian", "Yoslov");
  add_name("russian", "Zubarev");
}

add_name(nationality, thename) {
  level.names[nationality][level.names[nationality].size] = thename;
}

randomize_name_list(nationality) {
  size = level.names[nationality].size;
  for(i = 0; i < size; i++) {
    switchwith = randomInt(size);
    temp = level.names[nationality][i];
    level.names[nationality][i] = level.names[nationality][switchwith];
    level.names[nationality][switchwith] = temp;
  }
}

get_name(override) {
  if(!isDefined(override) && level.script == "credits") {
    self.airank = "private";
    self notify("set name and rank");
    return;
  }
  if(isDefined(self.script_friendname)) {
    if(self.script_friendname == "none") {
      return;
    }
    self.name = self.script_friendname;
    getRankFromName(self.name);
    self notify("set name and rank");
    return;
  }
  assert(isDefined(level.names));
  if(self.team == "axis") {
    if(self.voice == "japanese") {
      get_name_for_nationality("japanese");
    } else {
      get_name_for_nationality("german");
    }
  } else if(self.voice == "british") {
    get_name_for_nationality("british");
  } else if(self.voice == "russian" || self.voice == "russian_english") {
    get_name_for_nationality("russian");
  } else {
    get_name_for_nationality("american");
  }
  self notify("set name and rank");
}

add_override_name_func(nationality, func) {
  if(!isDefined(level._override_name_funcs)) {
    level._override_name_funcs = [];
  }
  AssertEx(!isDefined(level._override_name_funcs[nationality]), "Setting a name override function twice.");
  level._override_name_funcs[nationality] = func;
}

get_name_for_nationality(nationality) {
  assertex(isDefined(level.nameIndex[nationality]), nationality);
  if(isDefined(level._override_name_funcs) && isDefined(level._override_name_funcs[nationality])) {
    self.name = [[level._override_name_funcs[nationality]]]();
    self.airank = "";
    return;
  }
  level.nameIndex[nationality] = (level.nameIndex[nationality] + 1) % level.names[nationality].size;
  lastname = level.names[nationality][level.nameIndex[nationality]];
  if(!isDefined(lastname)) {
    lastname = "";
  }
  if(isDefined(level._override_rank_func)) {
    self[[level._override_rank_func]](lastname);
  } else {
    rank = randomInt(100);
    if(rank > 20) {
      fullname = "Pvt. " + lastname;
      self.airank = "private";
    } else if(rank > 10) {
      fullname = "Cpl. " + lastname;
      self.airank = "corporal";
    } else {
      fullname = "Sgt. " + lastname;
      self.airank = "sergeant";
    }
    self.name = fullname;
  }
}

getRankFromName(name) {
  if(!isDefined(name)) {
    self.airank = ("private");
  }
  tokens = Strtok(name, " ");
  assert(tokens.size);
  shortRank = tokens[0];
  switch (shortRank) {
    case "Pvt.":
      self.airank = "private";
      break;
    case "Pfc.":
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
      println("sentient has invalid rank " + shortRank + "!");
      self.airank = "private";
      break;
  }
}