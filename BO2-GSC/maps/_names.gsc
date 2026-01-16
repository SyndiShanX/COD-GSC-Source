/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_names.gsc
**************************************/

setup_names() {
  assert(!isDefined(level.names));
  level.names = [];
  level.namesindex = [];
  initialize_nationality("american");
}

initialize_nationality(str_nationality) {
  if(!isDefined(level.names[str_nationality])) {
    level.names[str_nationality] = [];

    if(str_nationality != "civilian")
      add_nationality_names(str_nationality);

    randomize_name_list(str_nationality);
    level.nameindex[str_nationality] = 0;
  }
}

add_nationality_names(str_nationality) {
  switch (str_nationality) {
    case "american":
      american_names();
      break;
    case "british":
      british_names();
      break;
    case "chinese":
      chinese_names();
      break;
    case "russian":
      russian_names();
      break;
    case "japanese":
      japanese_names();
      break;
    case "german":
      german_names();
      break;
    case "afghan":
      afghan_names();
      break;
    case "angolan":
      angolan_names();
      break;
    case "cuban":
      cuban_names();
      break;
    case "nicaraguan":
      nicaraguan_names();
      break;
    case "pakistani":
      pakistani_names();
      break;
    case "panamanian":
      panamanian_names();
      break;
    case "yemeni":
      yemeni_names();
      break;
    case "agent":
      agent_names();
      break;
    case "police":
      police_names();
      break;
    case "seal":
      seal_names();
      break;
    case "navy":
      navy_names();
      break;
    case "security":
      security_names();
      break;
    default:

      assertmsg("Name list does not exist for " + str_nationality);

      break;
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

afghan_names() {
  add_name("afghan", "Apirdai");
  add_name("afghan", "Ahmadzai");
  add_name("afghan", "Bijan");
  add_name("afghan", "Balkhi");
  add_name("afghan", "Busri");
  add_name("afghan", "Dawar");
  add_name("afghan", "Durrani");
  add_name("afghan", "Gul");
  add_name("afghan", "Hazrat");
  add_name("afghan", "Hotak");
  add_name("afghan", "Jaidhara");
  add_name("afghan", "Khan");
  add_name("afghan", "Mandokhel");
  add_name("afghan", "Mangal");
  add_name("afghan", "Marwat");
  add_name("afghan", "Momand");
  add_name("afghan", "Niazai");
  add_name("afghan", "Sakhi");
  add_name("afghan", "Shah");
  add_name("afghan", "Shinwarai");
  add_name("afghan", "Sulemankhel");
  add_name("afghan", "Tanai");
  add_name("afghan", "Wardak");
  add_name("afghan", "Wazir");
  add_name("afghan", "Yusufzai");
  add_name("afghan", "Zadran");
  add_name("afghan", "Zaman");
  add_name("afghan", "Zazai");
}

agent_names() {
  add_name("agent", "Bailey");
  add_name("agent", "Campbell");
  add_name("agent", "Collins");
  add_name("agent", "Cook");
  add_name("agent", "Cooper");
  add_name("agent", "Edwards");
  add_name("agent", "Evans");
  add_name("agent", "Gray");
  add_name("agent", "Howard");
  add_name("agent", "Morgan");
  add_name("agent", "Morris");
  add_name("agent", "Murphy");
  add_name("agent", "Phillips");
  add_name("agent", "Rivera");
  add_name("agent", "Roberts");
  add_name("agent", "Rogers");
  add_name("agent", "Stewart");
  add_name("agent", "Torres");
  add_name("agent", "Turner");
  add_name("agent", "Ward");
}

chinese_names() {
  add_name("chinese", "Chan");
  add_name("chinese", "Cheng");
  add_name("chinese", "Chiang");
  add_name("chinese", "Feng");
  add_name("chinese", "Guan");
  add_name("chinese", "Hu");
  add_name("chinese", "Lai");
  add_name("chinese", "Leung");
  add_name("chinese", "Wu");
  add_name("chinese", "Zheng");
}

angolan_names() {
  add_name("angolan", "Santos");
  add_name("angolan", "Samakuva");
  add_name("angolan", "Neto");
  add_name("angolan", "Roberto");
  add_name("angolan", "Lando");
  add_name("angolan", "Pasos");
  add_name("angolan", "Cacete");
  add_name("angolan", "Chipenda");
  add_name("angolan", "Pereira");
  add_name("angolan", "Constantino");
  add_name("angolan", "Botelho");
  add_name("angolan", "Diniz");
  add_name("angolan", "Rapaso");
  add_name("angolan", "Azavedo");
  add_name("angolan", "Catulo");
  add_name("angolan", "Teles");
}

cuban_names() {
  add_name("cuban", "Martinez");
  add_name("cuban", "Perez");
  add_name("cuban", "Lopez");
  add_name("cuban", "Garcia");
  add_name("cuban", "Vasquez");
  add_name("cuban", "Rodriguez");
  add_name("cuban", "Sardina");
  add_name("cuban", "Aldama");
  add_name("cuban", "Bacigalupi");
  add_name("cuban", "Novoa");
  add_name("cuban", "Hornedo");
  add_name("cuban", "Foca");
  add_name("cuban", "Villa");
  add_name("cuban", "Castellanos");
  add_name("cuban", "Estrada");
  add_name("cuban", "Sotolongo");
  add_name("cuban", "Fuentes");
  add_name("cuban", "Sanchez");
  add_name("cuban", "Lima");
  add_name("cuban", "Mendez");
  add_name("cuban", "Moreno");
  add_name("cuban", "Hernandez");
}

navy_names() {
  add_name("navy", "Buckner");
  add_name("navy", "Coffey");
  add_name("navy", "Dashnaw");
  add_name("navy", "Dobson");
  add_name("navy", "Frank");
  add_name("navy", "Frey");
  add_name("navy", "Howe");
  add_name("navy", "Johns");
  add_name("navy", "Lee");
  add_name("navy", "Lockhart");
  add_name("navy", "Moon");
  add_name("navy", "Paiser");
  add_name("navy", "Preston");
  add_name("navy", "Reyes");
  add_name("navy", "Slater");
  add_name("navy", "Waller");
  add_name("navy", "Wong");
  add_name("navy", "Velasquez");
  add_name("navy", "York");
}

nicaraguan_names() {
  add_name("nicaraguan", "Alegria");
  add_name("nicaraguan", "Arguello");
  add_name("nicaraguan", "Barbeito");
  add_name("nicaraguan", "Cardenal");
  add_name("nicaraguan", "Cuadra");
  add_name("nicaraguan", "Estrada");
  add_name("nicaraguan", "Francisco");
  add_name("nicaraguan", "Gallegos");
  add_name("nicaraguan", "Hurtado");
  add_name("nicaraguan", "Icasa");
  add_name("nicaraguan", "Jaire");
  add_name("nicaraguan", "Molina");
  add_name("nicaraguan", "Mejia");
  add_name("nicaraguan", "Nunes");
  add_name("nicaraguan", "Obando");
  add_name("nicaraguan", "Poma");
  add_name("nicaraguan", "Reyes");
  add_name("nicaraguan", "Rivas");
  add_name("nicaraguan", "Rosales");
  add_name("nicaraguan", "Solano");
  add_name("nicaraguan", "Toro");
  add_name("nicaraguan", "Urtecho");
  add_name("nicaraguan", "Villegas");
}

pakistani_names() {
  add_name("pakistani", "Afrida");
  add_name("pakistani", "Awan");
  add_name("pakistani", "Baqri");
  add_name("pakistani", "Bilgrami");
  add_name("pakistani", "Chaudhri");
  add_name("pakistani", "Edhi");
  add_name("pakistani", "Farooqi");
  add_name("pakistani", "Jaffri");
  add_name("pakistani", "Khan");
  add_name("pakistani", "Laghari");
  add_name("pakistani", "Mirza");
  add_name("pakistani", "Naqvi");
  add_name("pakistani", "Panjwani");
  add_name("pakistani", "Qadri");
  add_name("pakistani", "Rehmani");
  add_name("pakistani", "Saigal");
  add_name("pakistani", "Singh");
  add_name("pakistani", "Taqvi");
  add_name("pakistani", "Usmani");
  add_name("pakistani", "Zaidi");
}

panamanian_names() {
  add_name("panamanian", "Martinelli");
  add_name("panamanian", "Varela");
  add_name("panamanian", "Mulino");
  add_name("panamanian", "Suarez");
  add_name("panamanian", "Vergara");
  add_name("panamanian", "Aquilar");
  add_name("panamanian", "Sierra");
  add_name("panamanian", "Benitez");
  add_name("panamanian", "Burillo");
  add_name("panamanian", "Clement");
}

police_names() {
  add_name("police", "Anderson");
  add_name("police", "Brown");
  add_name("police", "Davis");
  add_name("police", "Garcia");
  add_name("police", "Harris");
  add_name("police", "Jackson");
  add_name("police", "Johnson");
  add_name("police", "Jones");
  add_name("police", "Martin");
  add_name("police", "Martinez");
  add_name("police", "Miller");
  add_name("police", "Moore");
  add_name("police", "Robinson");
  add_name("police", "Smith");
  add_name("police", "Taylor");
  add_name("police", "Thomas");
  add_name("police", "Thompson");
  add_name("police", "White");
  add_name("police", "Williams");
  add_name("police", "Wilson");
}

security_names() {
  add_name("security", "Anderson");
  add_name("security", "Brown");
  add_name("security", "Davis");
  add_name("security", "Garcia");
  add_name("security", "Harris");
  add_name("security", "Jackson");
  add_name("security", "Johnson");
  add_name("security", "Jones");
  add_name("security", "Martin");
  add_name("security", "Martinez");
  add_name("security", "Miller");
  add_name("security", "Moore");
  add_name("security", "Robinson");
  add_name("security", "Smith");
  add_name("security", "Taylor");
  add_name("security", "Thomas");
  add_name("security", "Thompson");
  add_name("security", "White");
  add_name("security", "Williams");
  add_name("security", "Wilson");
}

seal_names() {
  add_name("seal", "Adams");
  add_name("seal", "Carter");
  add_name("seal", "Gonzalez");
  add_name("seal", "Green");
  add_name("seal", "Hall");
  add_name("seal", "Hill");
  add_name("seal", "Hernandez");
  add_name("seal", "King");
  add_name("seal", "Lee");
  add_name("seal", "Lewis");
  add_name("seal", "Lopez");
  add_name("seal", "Maestas");
  add_name("seal", "Mitchell");
  add_name("seal", "Nelson");
  add_name("seal", "Rodriguez");
  add_name("seal", "Scott");
  add_name("seal", "Walker");
  add_name("seal", "Weichert");
  add_name("seal", "Wright");
  add_name("seal", "Young");
  add_name("seal", "Focht");
}

yemeni_names() {
  add_name("yemeni", "Adel");
  add_name("yemeni", "Amer");
  add_name("yemeni", "Amin");
  add_name("yemeni", "Anas");
  add_name("yemeni", "Awad");
  add_name("yemeni", "Ayman");
  add_name("yemeni", "Fares");
  add_name("yemeni", "Hamid");
  add_name("yemeni", "Hassan");
  add_name("yemeni", "Hisham");
  add_name("yemeni", "Jamal");
  add_name("yemeni", "Jamil");
  add_name("yemeni", "Mansour");
  add_name("yemeni", "Musaab");
  add_name("yemeni", "Naser");
  add_name("yemeni", "Nouman");
  add_name("yemeni", "Obeida");
  add_name("yemeni", "Odai");
  add_name("yemeni", "Saleh");
  add_name("yemeni", "Samer");
  add_name("yemeni", "Sharif");
  add_name("yemeni", "Taher");
  add_name("yemeni", "Yehya");
  add_name("yemeni", "Zayd");
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

add_name(nationality, thename) {
  level.names[nationality][level.names[nationality].size] = thename;
}

randomize_name_list(nationality) {
  size = level.names[nationality].size;

  for(i = 0; i < size; i++) {
    switchwith = randomint(size);
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
    if(self.script_friendname == "none")
      self.name = "";
    else {
      self.name = self.script_friendname;
      getrankfromname(self.name);
    }

    self notify("set name and rank");
    return;
  }

  assert(isDefined(level.names));
  str_classname = self get_ai_classname();
  str_nationality = "american";

  if(issubstr(str_classname, "_civilian_")) {
    self.airank = "none";
    str_nationality = "civilian";
  } else if(issubstr(str_classname, "_muj_")) {
    self.airank = "none";
    str_nationality = "afghan";
  } else if(self is_special_agent_member(str_classname))
    str_nationality = "agent";
  else if(issubstr(str_classname, "_unita_")) {
    self.airank = "none";
    str_nationality = "angolan";
  } else if(issubstr(str_classname, "_sco_")) {
    self.airank = "none";
    str_nationality = "chinese";
  } else if(issubstr(str_classname, "_cuban_")) {
    self.airank = "none";
    str_nationality = "cuban";
  } else if(issubstr(str_classname, "_cartel_")) {
    self.airank = "none";
    str_nationality = "nicaraguan";
  } else if(issubstr(str_classname, "_isi_") || issubstr(str_classname, "_let_")) {
    self.airank = "none";
    str_nationality = "pakistani";
  } else if(issubstr(str_classname, "_pdf_") || issubstr(str_classname, "_digbat_") || issubstr(str_classname, "_panama_")) {
    self.airank = "none";
    str_nationality = "panamanian";
  } else if(self is_lapd_member(str_classname))
    str_nationality = "police";
  else if(self is_seal_member(str_classname))
    str_nationality = "seal";
  else if(self is_navy_member(str_classname))
    str_nationality = "navy";
  else if(self is_security_member(str_classname))
    str_nationality = "security";
  else if(issubstr(str_classname, "_soviet_")) {
    self.airank = "none";
    str_nationality = "russian";
  } else if(issubstr(str_classname, "_yemeni_") || issubstr(str_classname, "_terrorist_yemen_")) {
    self.airank = "none";
    str_nationality = "yemeni";
  }

  initialize_nationality(str_nationality);
  get_name_for_nationality(str_nationality);
  self notify("set name and rank");
}

get_ai_classname() {
  if(isDefined(self.dr_ai_classname))
    str_classname = tolower(self.dr_ai_classname);
  else
    str_classname = tolower(self.classname);

  return str_classname;
}

add_override_name_func(nationality, func) {
  if(!isDefined(level._override_name_funcs))
    level._override_name_funcs = [];

  assert(!isDefined(level._override_name_funcs[nationality]), "Setting a name override function twice.");
  level._override_name_funcs[nationality] = func;
}

get_name_for_nationality(nationality) {
  assert(isDefined(level.nameindex[nationality]), nationality);

  if(isDefined(level._override_name_funcs) && isDefined(level._override_name_funcs[nationality])) {
    self.name = [
      [level._override_name_funcs[nationality]]
    ]();
    self.airank = "";
    return;
  }

  if(nationality == "civilian") {
    self.name = "";
    return;
  }

  level.nameindex[nationality] = (level.nameindex[nationality] + 1) % level.names[nationality].size;
  lastname = level.names[nationality][level.nameindex[nationality]];

  if(!isDefined(lastname))
    lastname = "";

  if(isDefined(level._override_rank_func))
    self[[level._override_rank_func]](lastname);
  else if(isDefined(self.airank) && self.airank == "none") {
    self.name = lastname;
    return;
  } else {
    rank = randomint(100);

    if(nationality == "seal") {
      if(rank > 20) {
        fullname = "PO " + lastname;
        self.airank = "petty officer";
      } else if(rank > 10) {
        fullname = "CPO " + lastname;
        self.airank = "chief petty officer";
      } else {
        fullname = "Lt. " + lastname;
        self.airank = "lieutenant";
      }
    } else if(nationality == "navy") {
      if(rank > 60) {
        fullname = "SN " + lastname;
        self.airank = "seaman";
      } else if(rank > 20) {
        fullname = "PO " + lastname;
        self.airank = "petty officer";
      } else {
        fullname = "CPO " + lastname;
        self.airank = "chief petty officer";
      }
    } else if(nationality == "police") {
      fullname = "Officer " + lastname;
      self.airank = "police officer";
    } else if(nationality == "agent") {
      fullname = "Agent " + lastname;
      self.airank = "special agent";
    } else if(nationality == "security")
      fullname = "Officer " + lastname;
    else if(rank > 20) {
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

is_seal_member(str_classname) {
  if(issubstr(str_classname, "_seal_"))
    return true;
  else
    return false;
}

is_navy_member(str_classname) {
  if(issubstr(str_classname, "_navy_"))
    return true;
  else
    return false;
}

is_lapd_member(str_classname) {
  if(issubstr(str_classname, "_lapd_") || issubstr(str_classname, "_swat_"))
    return true;
  else
    return false;
}

is_security_member(str_classname) {
  if(issubstr(str_classname, "_security_"))
    return true;

  return false;
}

is_special_agent_member(str_classname) {
  if(issubstr(str_classname, "_sstactical_"))
    return true;
  else
    return false;
}

getrankfromname(name) {
  if(!isDefined(name))
    self.airank = "private";

  tokens = strtok(name, " ");
  assert(tokens.size);
  shortrank = tokens[0];

  switch (shortrank) {
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

      println("sentient has invalid rank " + shortrank + "!");

      self.airank = "private";
      break;
  }
}

issubstr_match_any(str_match, str_search_array) {
  assert(str_search_array.size, "String array is empty");

  foreach(str_search in str_search_array) {
    if(issubstr(str_match, str_search))
      return true;
  }

  return false;
}