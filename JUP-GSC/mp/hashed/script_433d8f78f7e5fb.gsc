/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_433d8f78f7e5fb.gsc
***********************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_2430e72272756bb0;

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
  if(!issp() && !iscp() || !isDefined(self.script_friendname) && !isstartstr(self.classname, "actor_jup_ally_hero")) {
    setnpcid();
    return;
  }

  friendname = default_to(self.script_friendname, self.classname);
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
  } else {
    setnpcid();
    return;
  }

  self.battlechatter.ishero = 1;
}

function bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    bcs_setup_voice(#"unitednations", "UN", 1, 1, "", "");
    bcs_setup_voice(#"unitednationshelmet", "UN", 1, 1, "", "");
    bcs_setup_voice(#"unitednationsfemale", "UN", 1, 1, "", "");
    bcs_setup_voice(#"setdef", "SD", 1, 0, "", "");
    bcs_setup_voice(#"unitedstates", "USS", 4, 1, "uscm", "usst");
    bcs_setup_voice(#"sas", "USM", 1, 1, "", "");
    bcs_setup_voice(#"fsa", "LF", 1, 1, "", "");
    bcs_setup_voice(#"fsafemale", "LFF", 1, 1, "", "");
    bcs_setup_voice(#"hash_3df7c24714e86e6d", "LVS", 3, 1, "lvcm", "lvst");
    bcs_setup_voice(#"hash_d700685400fbffa1", "LVF", 1, 1, "", "");
    bcs_setup_voice(#"hash_5f1ef8142f0b6fcb", "MXA", 1, 1, "", "");
    bcs_setup_voice(#"alqatalafemale", "AQF", 1, 0, "", "");
    bcs_setup_voice(#"alqatala", "AQS", 5, 0, "aqsc", "aqss");
    bcs_setup_voice(#"cartel", "CTM", 4, 1, "crcm", "crst");
    bcs_setup_voice(#"shadowcompany", "PMC", 6, 1, "pmcc", "pmcs");
    bcs_setup_voice(#"crown", "CFS", 6, 1, "crwc", "crws");
    bcs_setup_voice(#"russian", "RU", 9, 0, "rusc", "russ");
  }
}

function function_793f0c4da1ff138f(countryid) {
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
    default:
      return;
  }

  level.battlechatter.names[countryid] = create_deck(names, 1, 1, 1);
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