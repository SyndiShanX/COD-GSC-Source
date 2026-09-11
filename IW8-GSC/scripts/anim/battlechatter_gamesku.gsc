/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_gamesku.gsc
**************************************************/

function init_flavorbursts() {
  anim.flavorbursts["unitedstates"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitedstates"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["unitedstatesfemale"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitedstatesfemale"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["sas"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["sas"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["fsa"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["fsa"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["fsafemale"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["fsafemale"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorburstsused = [];
}

function assign_npcid() {
  if(isDefined(self.script_friendname)) {
    var0 = tolower(self.script_friendname);
    self.battlechatter.npcid = undefined;

    if(issubstr(var0, "alex")) {
      self.battlechatter.countryid = "alx";
      self.battlechatter.onlyfirendlyfire = 1;
      return;
    }

    if(issubstr(var0, "farah")) {
      self.battlechatter.countryid = "far";
      return;
    }

    if(issubstr(var0, "captain price")) {
      self.battlechatter.countryid = "pri";
      return;
    }

    if(issubstr(var0, "kyle")) {
      self.battlechatter.countryid = "kyle";
      self.battlechatter.onlyfirendlyfire = 1;
      return;
    }

    if(issubstr(var0, "hadir")) {
      self.battlechatter.countryid = "had";
      return;
    }

    if(issubstr(var0, "griggs")) {
      self.battlechatter.countryid = "grg";
      return;
    }

    scripts\anim\battlechatter_ai::setnpcid();
    return;
  }

  scripts\anim\battlechatter_ai::setnpcid();
}

function bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    scripts\anim\battlechatter::bcs_setup_voice("unitednations", "UN", 6, 1);
    scripts\anim\battlechatter::bcs_setup_voice("unitednationshelmet", "UN", 6, 1);
    scripts\anim\battlechatter::bcs_setup_voice("unitednationsfemale", "UN", 3, 1);
    scripts\anim\battlechatter::bcs_setup_voice("setdef", "SD", 5);
    scripts\anim\battlechatter::bcs_setup_voice("unitedstates", "USM", 3, 1);
    scripts\anim\battlechatter::bcs_setup_voice("sas", "SAS", 3, 1);
    scripts\anim\battlechatter::bcs_setup_voice("fsa", "LF", 4, 1);
    scripts\anim\battlechatter::bcs_setup_voice("fsafemale", "LFF", 2, 1);

    switch (getDvar("bcs_forceEnglish")) {
      case "all":
      case "axis":
        scripts\anim\battlechatter::bcs_setup_voice("alqatala", "USM", 3);
        scripts\anim\battlechatter::bcs_setup_voice("russian", "USM", 3);
        break;
      default:
        scripts\anim\battlechatter::bcs_setup_voice("alqatala", "AQ", 4);
        scripts\anim\battlechatter::bcs_setup_voice("russian", "RU", 4);
        break;
    }

    return;
  }
}

function bcs_setup_playernameids() {
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

function isalliedcountryid(var0) {
  switch (var0) {
    case "FSAW":
    case "FSA":
    case "SAS":
    case "USM":
    case "UN":
      return 1;
    default:
      return 0;
  }
}

function isalliedmilitarycountryid(var0) {
  switch (var0) {
    case "SAS":
    case "USM":
    case "UN":
      return 1;
    default:
      return 0;
  }
}

function bcisgrenade(var0) {
  if(var0 == "offhand_wm_grenade_mike67") {
    return true;
  }

  return false;
}

function bcisrpg(var0) {
  if(var0 == "rocketlauncher") {
    return true;
  }

  return false;
}