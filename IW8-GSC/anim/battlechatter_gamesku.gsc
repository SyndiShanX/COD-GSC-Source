/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\battlechatter_gamesku.gsc
***********************************************/

init_flavorbursts() {
  anim.flavorbursts["unitedstates"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["unitedstates"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["unitedstatesfemale"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["unitedstatesfemale"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["sas"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["sas"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["fsa"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["fsa"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorbursts["fsafemale"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++)
    anim.flavorbursts["fsafemale"][var_1] = scripts\engine\utility::string(var_1 + 1);

  anim.flavorburstsused = [];
}

assign_npcid() {
  if(isDefined(self.script_friendname)) {
    var_0 = tolower(self.script_friendname);
    self.battlechatter.npcid = undefined;

    if(issubstr(var_0, "alex")) {
      self.battlechatter.countryid = "alx";
      self.battlechatter.onlyfirendlyfire = 1;
      return;
    }

    if(issubstr(var_0, "farah")) {
      self.battlechatter.countryid = "far";
      return;
    }

    if(issubstr(var_0, "captain price")) {
      self.battlechatter.countryid = "pri";
      return;
    }

    if(issubstr(var_0, "kyle")) {
      self.battlechatter.countryid = "kyle";
      self.battlechatter.onlyfirendlyfire = 1;
      return;
    }

    if(issubstr(var_0, "hadir")) {
      self.battlechatter.countryid = "had";
      return;
    }

    if(issubstr(var_0, "griggs")) {
      self.battlechatter.countryid = "grg";
      return;
    }

    scripts\anim\battlechatter_ai.gsc::setnpcid();
    return;
    return;
    return;
    return;
    return;
    return;
  } else
    scripts\anim\battlechatter_ai.gsc::setnpcid();
}

bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    scripts\anim\battlechatter.gsc::bcs_setup_voice("unitednations", "UN", 6, 1);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("unitednationshelmet", "UN", 6, 1);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("unitednationsfemale", "UN", 3, 1);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("setdef", "SD", 5);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("unitedstates", "USM", 3, 1);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("sas", "SAS", 3, 1);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("fsa", "LF", 4, 1);
    scripts\anim\battlechatter.gsc::bcs_setup_voice("fsafemale", "LFF", 2, 1);

    switch (getDvar("bcs_forceEnglish")) {
      case "all":
      case "axis":
        scripts\anim\battlechatter.gsc::bcs_setup_voice("alqatala", "USM", 3);
        scripts\anim\battlechatter.gsc::bcs_setup_voice("russian", "USM", 3);
        break;
      default:
        scripts\anim\battlechatter.gsc::bcs_setup_voice("alqatala", "AQ", 4);
        scripts\anim\battlechatter.gsc::bcs_setup_voice("russian", "RU", 4);
        break;
    }
  }
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

isalliedcountryid(var_0) {
  switch (var_0) {
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

isalliedmilitarycountryid(var_0) {
  switch (var_0) {
    case "SAS":
    case "USM":
    case "UN":
      return 1;
    default:
      return 0;
  }
}

bcisgrenade(var_0) {
  if(var_0 == "offhand_wm_grenade_mike67")
    return 1;

  return 0;
}

bcisrpg(var_0) {
  if(var_0 == "rocketlauncher")
    return 1;

  return 0;
}