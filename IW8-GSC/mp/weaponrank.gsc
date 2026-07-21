/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\weaponrank.gsc
***********************************************/

init() {
  track_consecutive_kills();
  var_0 = getdvarint("_encstr_8F6E0AA0359E929C0A39512D", 1);
  addglobalweaponrankxpmultiplier(var_0, "_encstr_AC1A194FFE95C0B01789D8639187FD482A47C5B780FA480E2F52D1");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0)) {
      if(level.weaponxpenabled) {
        var_1 = getdvarint("_encstr_AA0C0BB1EB816453202D9F0632");
        var_2 = var_0 getprivatepartysize() > 1;

        if(var_2)
          var_0 addweaponrankxpmultiplier(var_1, "_encstr_A7521F4035DCF880EABF1331A7E35F687C48CEDB1F39E8C872D731393F3A972005");
      }
    }
  }
}

loadweaponranktable(var_0) {
  var_1 = spawnStruct();
  var_1.rankinfo = [];
  var_2 = 0;

  for(;;) {
    var_3 = int(tablelookuprownum(var_0, 0, var_2));

    if(!isDefined(var_3) || var_3 < 0) {
      break;
    }

    var_4 = spawnStruct();
    var_1.rankinfo[var_2] = var_4;
    var_4.minxp = int(tablelookupbyrow(var_0, var_2, 1));
    var_4.xptonextrank = int(tablelookupbyrow(var_0, var_2, 2));
    var_4.maxxp = int(tablelookupbyrow(var_0, var_2, 3));
    var_2++;
  }

  var_1.maxrank = var_2 - 1;
  return var_1;
}

track_consecutive_kills() {
  level._id_1459A = loadweaponranktable("_encstr_86B91A68DAE7685321072B2B330A308041B550C30612E0254E4F3F1D");
  level.weaponranktable = loadweaponranktable("_encstr_877A172A485790D5BEF320583A92581391E9EE406FA010E09B");
  level.weaponranktable.maxweaponranks = [];
  var_0 = tablelookupgetnumrows("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_1, 4);
    var_3 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_1, 42);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101" || !isDefined(var_3) || var_3 == "_encstr_B40101") {
      continue;
    }
    var_3 = int(var_3);
    level.weaponranktable.maxweaponranks[var_2] = var_3;
  }
}

getplayerweaponrank(var_0) {
  var_1 = getplayerweaponrankxp(var_0);
  var_2 = getweaponrankforxp(var_1);
  return var_2;
}

getplayerweaponrankxp(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_AF1904A7F929";

  switch (var_1) {
    case "_encstr_8C07031599":
      var_2 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8D9012B9862CC9598C1427DECE9395CD9B96DBE6", "_encstr_91500CE315AFFF95A6739AA34813", var_0, "_encstr_97A205D6388582");
      return var_2;
    case "_encstr_850703B7D9":
      var_3 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8D9012B9862CC9598C1427DECE9395CD9B96DBE6", "_encstr_91500CE315AFFF95A6739AA34813", var_0, "_encstr_9A9005DE0BC150");
      return var_3;
    case "_encstr_AF1904A7F929":
      var_2 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8D9012B9862CC9598C1427DECE9395CD9B96DBE6", "_encstr_91500CE315AFFF95A6739AA34813", var_0, "_encstr_97A205D6388582");
      var_3 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8D9012B9862CC9598C1427DECE9395CD9B96DBE6", "_encstr_91500CE315AFFF95A6739AA34813", var_0, "_encstr_9A9005DE0BC150");
      return var_2 + var_3;
  }
}

isplayerweaponatmaxxp(var_0) {
  var_1 = getplayerweaponrankxp(var_0);
  var_2 = getweaponmaxrankxp(var_0);
  return var_1 >= var_2;
}

weaponshouldgetxp(var_0) {
  if(self.pers["_encstr_A51F05CB11A052"] < 3 && !getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88"))
    return 0;

  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(!weaponhasranks(var_1))
    return 0;

  return 1;
}

weaponhasranks(var_0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_0]))
    return 0;

  var_1 = level.weaponranktable.maxweaponranks[var_0] > 0;
  return var_1;
}

getweaponmaxrankxp(var_0) {
  var_1 = getmaxweaponrankforrootweapon(var_0);
  return getweaponrankinfomaxxp(var_1);
}

getweaponrankforxp(var_0) {
  if(var_0 == 0)
    return 0;

  for(var_1 = getmaxweaponrank() - 1; var_1 >= 0; var_1--) {
    if(var_0 >= getweaponrankinfominxp(var_1))
      return var_1;
  }

  return var_1;
}

rpg_attack_apc(var_0) {
  for(var_1 = replace_turret() - 1; var_1 >= 0; var_1--) {
    if(var_0 >= rpg_building_guys(var_1))
      return var_1;
  }

  return var_1;
}

getmaxweaponrankforrootweapon(var_0) {
  return level.weaponranktable.maxweaponranks[var_0];
}

getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

replace_turret() {
  return level._id_1459A.maxrank;
}

getweaponrankinfominxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].minxp;
}

rpg_building_guys(var_0) {
  return level._id_1459A.rankinfo[var_0].minxp;
}

getweaponrankinfoxptonextrank(var_0) {
  return level.weaponranktable.rankinfo[var_0].xptonextrank;
}

getweaponrankinfomaxxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].maxxp;
}

addglobalweaponrankxpmultiplier(var_0, var_1) {
  level addweaponrankxpmultiplier(var_0, var_1);
}

getglobalweaponrankxpmultiplier() {
  return level getweaponrankxpmultiplier();
}

respawntagvisibility() {
  if(self resetclientkillstreakindexes())
    return sortbydistancecullbyradius();

  return 1.0;
}

addweaponrankxpmultiplier(var_0, var_1) {
  if(!isDefined(self.weaponrankxpmultipliers))
    self.weaponrankxpmultipliers = [];

  if(isDefined(self.weaponrankxpmultipliers[var_1]))
    self.weaponrankxpmultipliers[var_1] = max(self.weaponrankxpmultipliers[var_1], var_0);
  else
    self.weaponrankxpmultipliers[var_1] = var_0;
}

getweaponrankxpmultiplier() {
  if(!isDefined(self.weaponrankxpmultipliers))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self.weaponrankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

removeglobalweaponrankxpmultiplier(var_0) {
  level removeweaponrankxpmultiplier(var_0);
}

removeweaponrankxpmultiplier(var_0) {
  if(!isDefined(self.weaponrankxpmultipliers)) {
    return;
  }
  if(!isDefined(self.weaponrankxpmultipliers[var_0])) {
    return;
  }
  self.rankxpmultipliers[var_0] = undefined;
}

safefromnuke() {
  if(!isDefined(level._id_12750))
    level._id_12750 = getdvarfloat("_encstr_8F781D4E2ED34FE3846710B06FB33B17EBD7CF5785AAC92B4F37F8C003F933", 1.0);

  return level._id_12750;
}

getweaponrankxpmultipliertotal() {
  var_0 = getweaponrankxpmultiplier();
  var_1 = getglobalweaponrankxpmultiplier();
  var_2 = reloadnotehandler();
  var_3 = respawntagvisibility();
  var_4 = safefromnuke();
  var_5 = scripts\engine\utility::ter_op(_func_043E(self), 1.1, 1.0);
  var_6 = 1.0;

  if(isDefined(self)) {
    var_7 = _func_0446(self, 1);

    if(isDefined(scripts\engine\utility::array_find(var_7, self)) && var_7.size > 1)
      var_6 = var_6 * 1.25;
  }

  return var_0 * var_1 * var_2 * var_3 * var_4 * var_5 * var_6;
}

reloadnotehandler() {
  if(!isDefined(level.playplundersound))
    level.playplundersound = float(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, scripts\mp\utility\game::getgametype(), 19));

  return level.playplundersound;
}

reload_handle_hintstring() {
  if(!isDefined(level.playjumpsoundtosquad))
    level.playjumpsoundtosquad = getdvarint("_encstr_842311B9B14ED7964184D7F6CE599C93964656", int(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, scripts\mp\utility\game::getgametype(), 20)));

  return level.playjumpsoundtosquad;
}

reload_use_think() {
  if(!isDefined(level.playkillstreakdeploydialog)) {
    var_0 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB");

    if(var_0 == 0)
      var_0 = 900;

    var_1 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_B28B0AAFBB2DB9B1B4DA2DE8");

    if(var_1 > 0)
      var_0 = var_0 * (var_1 * 2 - 1);

    level.playkillstreakdeploydialog = reload_handle_hintstring() / 60 * (var_0 / 60);
  }

  return level.playkillstreakdeploydialog;
}