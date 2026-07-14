/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_433d8f78f7e5fb.gsc
***************************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_326cae52b2158981;

function init_flavorbursts() {
  anim.flavorbursts["unitedstates"] = [];
  numbursts = 41;

  for(i = 0; i < numbursts; i++) {
    anim.flavorbursts["unitedstates"][i] = string(i + 1);
  }

  anim.flavorbursts["unitedstatesfemale"] = [];
  numbursts = 41;

  for(i = 0; i < numbursts; i++) {
    anim.flavorbursts["unitedstatesfemale"][i] = string(i + 1);
  }

  anim.flavorbursts["sas"] = [];
  numbursts = 41;

  for(i = 0; i < numbursts; i++) {
    anim.flavorbursts["sas"][i] = string(i + 1);
  }

  anim.flavorbursts["fsa"] = [];
  numbursts = 41;

  for(i = 0; i < numbursts; i++) {
    anim.flavorbursts["fsa"][i] = string(i + 1);
  }

  anim.flavorbursts["fsafemale"] = [];
  numbursts = 41;

  for(i = 0; i < numbursts; i++) {
    anim.flavorbursts["fsafemale"][i] = string(i + 1);
  }

  anim.flavorburstsused = [];
}

function assign_npcid() {
  if(!utility::issp() || !isDefined(self.script_friendname) && !(isstartstr(self.classname, "actor_jup_ally_hero") || isstartstr(self.classname, "actor_t10_ally_hero"))) {
    battlechatter_ai::setnpcid();
    return;
  }

  friendname = self.script_friendname ?? self.classname;
  friendname = tolower(friendname);
  self.battlechatter.npcid = undefined;

  if(issubstr(friendname, "alejandro")) {
    self.battlechatter.countryid = "alej";
  } else if(issubstr(friendname, "farah")) {
    self.battlechatter.countryid = "fara";
  } else if(issubstr(friendname, "price")) {
    self.battlechatter.countryid = "pric";
  } else if(issubstr(friendname, "gaz") || issubstr(friendname, "kyle")) {
    self.battlechatter.countryid = "gazz";
  } else if(issubstr(friendname, "ghost")) {
    self.battlechatter.countryid = "ghos";
  } else if(issubstr(friendname, "griggs")) {
    self.battlechatter.countryid = "grig";
  } else if(issubstr(friendname, "graves")) {
    self.battlechatter.countryid = "grav";
  } else if(issubstr(friendname, "soap")) {
    self.battlechatter.countryid = "soap";
  } else if(issubstr(friendname, "laswell")) {
    self.battlechatter.countryid = "lasw";
  } else if(issubstr(friendname, "nikolai")) {
    self.battlechatter.countryid = "niko";
  } else if(issubstr(friendname, "rodolfo")) {
    self.battlechatter.countryid = "rodo";
  } else if(issubstr(friendname, "adler")) {
    self.battlechatter.countryid = "adlr";
  } else if(issubstr(friendname, "felix")) {
    self.battlechatter.countryid = "neum";
  } else if(issubstr(friendname, "marshall")) {
    self.battlechatter.countryid = "mrsh";
  } else if(issubstr(friendname, "sev")) {
    self.battlechatter.countryid = "sevg";
  } else if(issubstr(friendname, "park")) {
    self.battlechatter.countryid = "park";
  } else if(issubstr(friendname, "sims")) {
    self.battlechatter.countryid = "sims";
  } else if(issubstr(friendname, "harrow")) {
    self.battlechatter.countryid = "hrow";
    self.battlechatterallowed = 0;
  } else {
    battlechatter_ai::setnpcid();
    return;
  }

  self.battlechatter.ishero = 1;
}

function bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    battlechatter::bcs_setup_voice(#"unitednations", "UN", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"unitednationshelmet", "UN", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"unitednationsfemale", "UN", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"setdef", "SD", 1, 0, "", "");
    battlechatter::bcs_setup_voice(#"unitedstates", "USS", 4, 1, "uscm", "usst");
    battlechatter::bcs_setup_voice(#"sas", "USM", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"fsa", "LF", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"fsafemale", "LFF", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"mexicanspecialforces", "LVS", 3, 1, "lvcm", "lvst");
    battlechatter::bcs_setup_voice(#"mexicanspecialforcesfemale", "LVF", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"mexicanarmy", "MXA", 1, 1, "", "");
    battlechatter::bcs_setup_voice(#"alqatalafemale", "AQF", 1, 0, "", "");
    battlechatter::bcs_setup_voice(#"alqatala", "AQS", 5, 0, "aqsc", "aqss");
    battlechatter::bcs_setup_voice(#"cartel", "CTM", 4, 1, "crcm", "crst");
    battlechatter::bcs_setup_voice(#"shadowcompany", "PMC", 6, 1, "pmcc", "pmcs");
    battlechatter::bcs_setup_voice(#"crown", "CFS", 6, 1, "crws", "crws");
    battlechatter::bcs_setup_voice(#"russian", "RU", 9, 0, "rusc", "russ");
    battlechatter::bcs_setup_voice(#"konni", "RU", 9, 0, "rusc", "russ");
    battlechatter::bcs_setup_voice(#"northkorean", "NK", 1, 0, "nms", "nms");
    battlechatter::bcs_setup_voice(#"southkorean", "SK", 1, 0, "nms", "nms");
    battlechatter::bcs_setup_voice(#"pantheon", "PAN", 3, 0, "panc", "pans");
    battlechatter::bcs_setup_voice(#"iraqi", "IRQ", 3, 0, "irqc", "irqs");
    battlechatter::bcs_setup_voice(#"Guild", "GTG", 3, 0, "gtgc", "gtgs");
    battlechatter::bcs_setup_voice(#"casino", "MUS", 3, 0, "musc", "muss");
  }
}

function function_b0cd39ab5c17dcba(countryid) {
  names = [];

  switch (countryid) {
    case #"hash_f8933b6c8c234a3c":
      names[names.size] = "safi";
      names[names.size] = "abbasi";
      names[names.size] = "kinan";
      names[names.size] = "hamed";
      names[names.size] = "hadi";
      names[names.size] = "waseem";
      names[names.size] = "abuelbaz";
      names[names.size] = "beshara";
      names[names.size] = "kamal";
      names[names.size] = "abujamil";
      names[names.size] = "jabour";
      names[names.size] = "yaser";
      names[names.size] = "fayad";
      names[names.size] = "daoud";
      names[names.size] = "laham";
      names[names.size] = "abunazar";
      names[names.size] = "basr";
      names[names.size] = "karam";
      break;
    case #"hash_782a246ccf672edf":
      names[names.size] = "chris";
      names[names.size] = "eric";
      names[names.size] = "trey";
      names[names.size] = "brian";
      names[names.size] = "mike";
      names[names.size] = "matt";
      names[names.size] = "danny";
      names[names.size] = "shane";
      names[names.size] = "mark";
      names[names.size] = "sean";
      names[names.size] = "lucas";
      names[names.size] = "quinten";
      names[names.size] = "geoff";
      names[names.size] = "james";
      names[names.size] = "cole";
      names[names.size] = "jason";
      names[names.size] = "scott";
      names[names.size] = "will";
      names[names.size] = "brooks";
      names[names.size] = "wyatt";
      break;
    case #"hash_8a9636c94e6076d":
      names[names.size] = "chepe";
      names[names.size] = "rodrigo";
      names[names.size] = "alonso";
      names[names.size] = "carlos";
      names[names.size] = "paco";
      names[names.size] = "chava";
      names[names.size] = "juan";
      names[names.size] = "rami";
      names[names.size] = "miguel";
      names[names.size] = "mincho";
      names[names.size] = "oscar";
      names[names.size] = "hector";
      names[names.size] = "too";
      names[names.size] = "andrs";
      names[names.size] = "arturo";
      names[names.size] = "raul";
      names[names.size] = "ramon";
      names[names.size] = "chente";
      names[names.size] = "manny";
      names[names.size] = "temo";
      names[names.size] = "nando";
      break;
    case #"hash_896096c94d66f35":
      names[names.size] = "adams";
      names[names.size] = "baker";
      names[names.size] = "barry";
      names[names.size] = "billy";
      names[names.size] = "chapman";
      names[names.size] = "colin";
      names[names.size] = "edwards";
      names[names.size] = "fisher";
      names[names.size] = "george";
      names[names.size] = "grant";
      names[names.size] = "hall";
      names[names.size] = "james";
      names[names.size] = "matthews";
      names[names.size] = "morgan";
      names[names.size] = "parker";
      names[names.size] = "richards";
      names[names.size] = "roberts";
      names[names.size] = "shaw";
      names[names.size] = "stevens";
      names[names.size] = "thomas";
      names[names.size] = "turner";
      names[names.size] = "williams";
      break;
    case #"hash_fab89df6bdd4bc00":
      names[names.size] = "mikhail";
      names[names.size] = "maxim";
      names[names.size] = "dmitriy";
      names[names.size] = "andrei";
      names[names.size] = "igor";
      names[names.size] = "alexei";
      names[names.size] = "boris";
      names[names.size] = "viktor";
      names[names.size] = "pavel";
      names[names.size] = "leo";
      names[names.size] = "vlad";
      names[names.size] = "denis";
      names[names.size] = "timur";
      names[names.size] = "anton";
      names[names.size] = "artur";
      names[names.size] = "damiem";
      names[names.size] = "bogdan";
      names[names.size] = "luka";
      names[names.size] = "anatoli";
      names[names.size] = "sergei";
      names[names.size] = "roman";
      break;
    case #"hash_4438aa6cb42c06a3":
      names[names.size] = "mikhail";
      names[names.size] = "maxim";
      names[names.size] = "dmitriy";
      names[names.size] = "andrei";
      names[names.size] = "igor";
      names[names.size] = "alexei";
      names[names.size] = "boris";
      names[names.size] = "viktor";
      names[names.size] = "pavel";
      names[names.size] = "leo";
      names[names.size] = "vlad";
      names[names.size] = "denis";
      names[names.size] = "timur";
      names[names.size] = "anton";
      names[names.size] = "artur";
      names[names.size] = "damiem";
      names[names.size] = "bogdan";
      names[names.size] = "luka";
      names[names.size] = "anatoli";
      names[names.size] = "sergei";
      names[names.size] = "roman";
      break;
    case #"hash_7850676ccf85ad6c":
      names[names.size] = "martinez";
      names[names.size] = "richmond";
      names[names.size] = "baker";
      names[names.size] = "jefferson";
      names[names.size] = "hodges";
      names[names.size] = "young";
      names[names.size] = "watson";
      names[names.size] = "krause";
      names[names.size] = "wolfe";
      names[names.size] = "thomas";
      names[names.size] = "elton";
      names[names.size] = "holden";
      names[names.size] = "watts";
      names[names.size] = "hidalgo";
      names[names.size] = "poole";
      names[names.size] = "wallace";
      names[names.size] = "varley";
      names[names.size] = "horn";
      names[names.size] = "wyatt";
      names[names.size] = "christian";
      names[names.size] = "cameron";
      names[names.size] = "baldwin";
      names[names.size] = "ferguson";
      break;
    case #"hash_35a2bd6cac97d049":
      names[names.size] = "mazen";
      names[names.size] = "rawad";
      names[names.size] = "basel";
      names[names.size] = "jamal";
      names[names.size] = "hani";
      names[names.size] = "yamen";
      names[names.size] = "waseem";
      names[names.size] = "kamal";
      names[names.size] = "ameen";
      names[names.size] = "akram";
      names[names.size] = "wael";
      names[names.size] = "tameem";
      names[names.size] = "ehsan";
      names[names.size] = "samer";
      names[names.size] = "waheed";
      names[names.size] = "jawad";
      names[names.size] = "badr";
      names[names.size] = "khaldoon";
      names[names.size] = "fares";
      names[names.size] = "muhanad";
      names[names.size] = "rabeh";
      names[names.size] = "ammar";
      names[names.size] = "kumait";
      names[names.size] = "bassam";
      names[names.size] = "fadi";
      break;
    case #"hash_178adf6c9cb5b60c":
      names[names.size] = "matteo";
      names[names.size] = "riccardo";
      names[names.size] = "davide";
      names[names.size] = "francesco";
      names[names.size] = "angelo";
      names[names.size] = "giorgio";
      names[names.size] = "massimo";
      names[names.size] = "marco";
      names[names.size] = "simone";
      names[names.size] = "michele";
      names[names.size] = "luca";
      names[names.size] = "tommaso";
      names[names.size] = "emanuele";
      names[names.size] = "gabriele";
      names[names.size] = "giulio";
      names[names.size] = "alessandro";
      names[names.size] = "fabio";
      names[names.size] = "daniele";
      names[names.size] = "andrea";
      names[names.size] = "filippo";
      names[names.size] = "alessio";
      names[names.size] = "christian";
      names[names.size] = "lorenzo";
      names[names.size] = "emilio";
      names[names.size] = "federico";
      break;
    case #"hash_e9a4756c844899c3":
      names[names.size] = "martin";
      names[names.size] = "richard";
      names[names.size] = "alexis";
      names[names.size] = "mickael";
      names[names.size] = "yassine";
      names[names.size] = "raoul";
      names[names.size] = "axel";
      names[names.size] = "aziz";
      names[names.size] = "pierrick";
      names[names.size] = "aurlien";
      names[names.size] = "thomas";
      names[names.size] = "lo";
      names[names.size] = "christophe";
      names[names.size] = "jean";
      names[names.size] = "mohamed";
      names[names.size] = "paul";
      names[names.size] = "wallace";
      names[names.size] = "pierre";
      names[names.size] = "zacharie";
      names[names.size] = "mile";
      names[names.size] = "christian";
      names[names.size] = "charles";
      names[names.size] = "samuel";
      names[names.size] = "alain";
      break;
    default:
      return;
  }

  level.battlechatter.names[countryid] = utility::create_deck(names, 1, 1, 1);
}

function bcs_setup_playernameids() {
  anim.playernameids["unitednations"] = "1";
  anim.playernameids["unitednationshelmet"] = "1";
  anim.playernameids["unitednationsfemale"] = "1";
  anim.playernameids["unitedstates"] = "1";
  anim.playernameids["unitedstatesfemale"] = "1";
  anim.playernameids["alqatala"] = "1";
  anim.playernameids["russian"] = "01";
  anim.playernameids["konni"] = "1";
  anim.playernameids["sas"] = "1";
  anim.playernameids["fsa"] = "1";
  anim.playernameids["fsafemale"] = "1";
}

function isalliedcountryid(id) {
  switch (id) {
    case #"hash_516b796cbaa93d1c":
    case #"hash_7e32e56cd23412de":
    case #"hash_ea3640d9fa6d26ce":
    case #"hash_f0bf346c87ed36ed":
    case #"hash_faa2b6f6bdc39a3a":
      return 1;
    default:
      return 0;
  }
}

function isalliedmilitarycountryid(id) {
  switch (id) {
    case #"hash_516b796cbaa93d1c":
    case #"hash_7e32e56cd23412de":
    case #"hash_faa2b6f6bdc39a3a":
      return 1;
    default:
      return 0;
  }
}

function bcisgrenade(model) {
  if(model == "offhand_wm_grenade_mike67") {
    return true;
  }

  return false;
}

function bcisrpg(classname) {
  if(classname == "rocketlauncher") {
    return true;
  }

  return false;
}