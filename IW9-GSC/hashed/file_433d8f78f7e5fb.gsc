/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_433d8f78f7e5fb.gsc
***********************************************/

init_flavorbursts() {
  anim.flavorbursts["unitedstates"] = [];
  _id_1F9D1F8654F966B8 = 41;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F9D1F8654F966B8; _id_AC0E594AC96AA3A8++)
    anim.flavorbursts["unitedstates"][_id_AC0E594AC96AA3A8] = scripts\engine\utility::string(_id_AC0E594AC96AA3A8 + 1);

  anim.flavorbursts["unitedstatesfemale"] = [];
  _id_1F9D1F8654F966B8 = 41;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F9D1F8654F966B8; _id_AC0E594AC96AA3A8++)
    anim.flavorbursts["unitedstatesfemale"][_id_AC0E594AC96AA3A8] = scripts\engine\utility::string(_id_AC0E594AC96AA3A8 + 1);

  anim.flavorbursts["sas"] = [];
  _id_1F9D1F8654F966B8 = 41;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F9D1F8654F966B8; _id_AC0E594AC96AA3A8++)
    anim.flavorbursts["sas"][_id_AC0E594AC96AA3A8] = scripts\engine\utility::string(_id_AC0E594AC96AA3A8 + 1);

  anim.flavorbursts["fsa"] = [];
  _id_1F9D1F8654F966B8 = 41;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F9D1F8654F966B8; _id_AC0E594AC96AA3A8++)
    anim.flavorbursts["fsa"][_id_AC0E594AC96AA3A8] = scripts\engine\utility::string(_id_AC0E594AC96AA3A8 + 1);

  anim.flavorbursts["fsafemale"] = [];
  _id_1F9D1F8654F966B8 = 41;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F9D1F8654F966B8; _id_AC0E594AC96AA3A8++)
    anim.flavorbursts["fsafemale"][_id_AC0E594AC96AA3A8] = scripts\engine\utility::string(_id_AC0E594AC96AA3A8 + 1);

  anim.flavorburstsused = [];
}

assign_npcid() {
  if(!scripts\common\utility::issp() || !isDefined(self.script_friendname) && !isstartstr(self.classname, "actor_iw9_ally_hero")) {
    _id_0F4E8D02D2F70888::setnpcid();
    return;
  }

  _id_CF64803F6000AE12 = scripts\engine\utility::_id_53C4C53197386572(self.script_friendname, self.classname);
  _id_CF64803F6000AE12 = tolower(_id_CF64803F6000AE12);
  self.battlechatter.npcid = undefined;

  if(issubstr(_id_CF64803F6000AE12, "alejandro"))
    self.battlechatter.countryid = "alej";
  else if(issubstr(_id_CF64803F6000AE12, "farah"))
    self.battlechatter.countryid = "fara";
  else if(issubstr(_id_CF64803F6000AE12, "price"))
    self.battlechatter.countryid = "pric";
  else if(issubstr(_id_CF64803F6000AE12, "gaz") || issubstr(_id_CF64803F6000AE12, "kyle"))
    self.battlechatter.countryid = "gazz";
  else if(issubstr(_id_CF64803F6000AE12, "ghost"))
    self.battlechatter.countryid = "ghos";
  else if(issubstr(_id_CF64803F6000AE12, "griggs"))
    self.battlechatter.countryid = "grig";
  else if(issubstr(_id_CF64803F6000AE12, "graves"))
    self.battlechatter.countryid = "grav";
  else if(issubstr(_id_CF64803F6000AE12, "soap"))
    self.battlechatter.countryid = "soap";
  else if(issubstr(_id_CF64803F6000AE12, "laswell"))
    self.battlechatter.countryid = "lasw";
  else if(issubstr(_id_CF64803F6000AE12, "nikolai"))
    self.battlechatter.countryid = "niko";
  else if(issubstr(_id_CF64803F6000AE12, "rodolfo"))
    self.battlechatter.countryid = "rodo";
  else {
    _id_0F4E8D02D2F70888::setnpcid();
    return;
  }

  self.battlechatter._id_732DF8DB084AB0C5 = 1;
}

bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    _id_35DE402EFC5ACFB3::bcs_setup_voice("unitednations", "UN", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("unitednationshelmet", "UN", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("unitednationsfemale", "UN", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("setdef", "SD", 1, 0, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("unitedstates", "USS", 4, 1, "uscm", "usst");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("sas", "USM", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("fsa", "LF", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("fsafemale", "LFF", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("mexicanspecialforces", "LVS", 3, 1, "lvcm", "lvst");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("mexicanspecialforcesfemale", "LVF", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("mexicanarmy", "MXA", 1, 1, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("alqatalafemale", "AQF", 1, 0, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("russian", "RU", 1, 0, "", "");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("alqatala", "AQS", 5, 0, "aqsc", "aqss");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("cartel", "CTM", 4, 1, "crcm", "crst");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("shadowcompany", "PMC", 6, 1, "pmcc", "pmcs");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("crown", "CFS", 6, 1, "crwc", "crws");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("russian", "RUK", 6, 1, "knnc", "knns");
    _id_35DE402EFC5ACFB3::bcs_setup_voice("german", "DGG", 5, 1, "degs", "degs");
  }
}

_id_793F0C4DA1FF138F(countryid) {
  names = [];

  switch (countryid) {
    case "AQS":
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
    case "PMC":
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
    case "CTM":
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
    case "CRW":
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
    default:
      return;
  }

  level.battlechatter.names[countryid] = scripts\engine\utility::create_deck(names, 1, 1, 1);
}

bcs_setup_playernameids() {
  anim.playernameids["unitednations"] = "1";
  anim.playernameids["unitednationshelmet"] = "1";
  anim.playernameids["unitednationsfemale"] = "1";
  anim.playernameids["unitedstates"] = "1";
  anim.playernameids["unitedstatesfemale"] = "1";
  anim.playernameids["alqatala"] = "1";
  anim.playernameids["russian"] = "1";
  anim.playernameids["sas"] = "1";
  anim.playernameids["fsa"] = "1";
  anim.playernameids["fsafemale"] = "1";
}

isalliedcountryid(id) {
  switch (id) {
    case "FSAW":
    case "UN":
    case "FSA":
    case "SAS":
    case "USM":
      return 1;
    default:
      return 0;
  }
}

isalliedmilitarycountryid(id) {
  switch (id) {
    case "UN":
    case "SAS":
    case "USM":
      return 1;
    default:
      return 0;
  }
}

bcisgrenade(model) {
  if(model == "offhand_wm_grenade_mike67")
    return 1;

  return 0;
}

bcisrpg(classname) {
  if(classname == "rocketlauncher")
    return 1;

  return 0;
}