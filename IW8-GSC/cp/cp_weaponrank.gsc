/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_weaponrank.gsc
***********************************************/

init() {
  loadweaponranktable();
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

        var_3 = getdvarint("_encstr_A36D13E66CE4BEBBB22C38B7E6C338F5C64B5B4B1D", 40000);
        var_0._id_11B7E = var_3;
        var_0._id_13BFC = 0;
        var_0._id_14677 = [];

        foreach(var_5, var_3 in level.weaponranktable.maxweaponranks)
        var_0._id_14677[var_5 + "_encstr_851A049F8337"] = 0;
      }
    }
  }
}

loadweaponranktable() {
  level.weaponranktable = spawnStruct();
  level.weaponranktable.rankinfo = [];
  var_0 = 0;

  for(;;) {
    var_1 = int(tablelookuprownum("_encstr_877A172A485790D5BEF320583A92581391E9EE406FA010E09B", 0, var_0));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_2 = spawnStruct();
    level.weaponranktable.rankinfo[var_0] = var_2;
    var_2.minxp = int(tablelookupbyrow("_encstr_877A172A485790D5BEF320583A92581391E9EE406FA010E09B", var_0, 1));
    var_2.xptonextrank = int(tablelookupbyrow("_encstr_877A172A485790D5BEF320583A92581391E9EE406FA010E09B", var_0, 2));
    var_2.maxxp = int(tablelookupbyrow("_encstr_877A172A485790D5BEF320583A92581391E9EE406FA010E09B", var_0, 3));
    var_0++;
  }

  level.weaponranktable.maxrank = var_0 - 1;
  level.weaponranktable.maxweaponranks = [];
  var_3 = 1;

  for(;;) {
    var_1 = int(tablelookuprownum("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3));

    if(!isDefined(var_1) || var_1 < 0) {
      break;
    }

    var_4 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_1, 4);
    var_5 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_1, 42);

    if(!isDefined(var_4) || var_4 == "_encstr_B40101" || !isDefined(var_5) || var_5 == "_encstr_B40101") {} else {
      var_5 = int(var_5);
      level.weaponranktable.maxweaponranks[var_4] = var_5;
    }

    var_3++;
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

  var_1 = scripts\cp\utility::getweaponrootname(var_0);
  return weaponhasranks(var_1);
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

getmaxweaponrankforrootweapon(var_0) {
  return level.weaponranktable.maxweaponranks[var_0];
}

getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

getweaponrankinfominxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].minxp;
}

getweaponrankinfoxptonextrank(var_0) {
  return level.weaponranktable.rankinfo[var_0].xptonextrank;
}

getweaponrankinfomaxxp(var_0) {
  return level.weaponranktable.rankinfo[var_0].maxxp;
}

giveplayerweaponxp(var_0, var_1, var_2) {
  if(isai(self) || !isPlayer(self) || !isDefined(var_2) || var_2 == 0 || !level.weaponxpenabled) {
    return;
  }
  var_3 = scripts\cp\utility::getweaponrootname(var_0.basename);

  if(!self isitemunlocked(var_3, "_encstr_AC20072B9FA9487832")) {
    return;
  }
  if(!weaponhasranks(var_3)) {
    return;
  }
  var_4 = remapscoreeventforweapon(var_1);

  if(var_4 != var_1) {
    var_1 = var_4;
    var_2 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_1);
  }

  if(var_2 < 0) {
    return;
  }
  var_5 = var_2;
  var_2 = var_2 * getweaponrankxpmultipliertotal();
  var_2 = int(var_2);
  var_6 = getplayerweaponrankxp(var_3, "_encstr_8C07031599");
  var_7 = getplayerweaponrankxp(var_3, "_encstr_850703B7D9");
  var_8 = var_6 + var_7;
  var_9 = getweaponrankforxp(var_8);
  var_10 = getweaponmaxrankxp(var_3);
  var_11 = var_10 - var_7;
  var_12 = var_6 + var_2;

  if(var_12 > var_11)
    var_12 = var_11;

  var_13 = var_12 + var_7;
  var_14 = getmaxweaponrankforrootweapon(var_3);
  var_15 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8D9012B9862CC9598C1427DECE9395CD9B96DBE6", "_encstr_91500CE315AFFF95A6739AA34813", var_3, "_encstr_A1ED09400BA5D351227715");
  var_16 = int(min(getweaponrankforxp(var_13), var_14));
  scripts\cp\cp_analytics::_id_119B3(var_0, var_15, var_16, var_2, var_1);

  if(var_9 < var_16) {
    var_17 = "_encstr_9274136338D312B7C8508A91D0B0AF9B59519F79DA";

    if(var_16 >= 15)
      var_17 = "_encstr_9B6A17AB738A6B7D2B481BA985424E9DE83937E3E8372AF32F";
    else if(var_16 >= 10)
      var_17 = "_encstr_A3B11583EDA36307A089B307F8F8FFFB59689AEA586B5F";
    else if(var_16 >= 5)
      var_17 = "_encstr_9274136338D312B7C8508A91D0B0AF9B5951CF79B2";

    var_18 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_17);
    scripts\cp\drone\emp_drone::giverankxp(var_17, var_18);
  }

  return var_2;
}

remapscoreeventforweapon(var_0) {
  switch (var_0) {
    case "_encstr_ABD70578F3D02C":
      var_0 = "_encstr_B22E0C78B23DF1C6EF5D8F7F3FE3";
      break;
    case "_encstr_932E0A09FB023CC0DA8D7FFF":
      var_0 = "_encstr_81C511EE2B2CC17BB9AFB10DC2368D959B9DB2";
      break;
  }

  return var_0;
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

getweaponrankxpmultipliertotal() {
  var_0 = getweaponrankxpmultiplier();
  var_1 = getglobalweaponrankxpmultiplier();
  var_2 = reloadnotehandler();
  var_3 = respawntagvisibility();
  var_4 = getdvarfloat("_encstr_AF2D143F17522E8FAF61C17F08B3ABC9E6DE0B680706", 1);
  var_5 = 1.0;
  var_6 = _func_0446(self, 1);

  if(isDefined(scripts\engine\utility::array_find(var_6, self)) && var_6.size > 1)
    var_5 = var_5 * 1.25;

  return var_0 * var_1 * var_2 * var_4 * var_3 * var_5;
}

reloadnotehandler() {
  if(!isDefined(level.playplundersound))
    level.playplundersound = float(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, scripts\cp\utility::getgametype(), 19));

  return level.playplundersound;
}

reload_handle_hintstring() {
  if(!isDefined(level.playjumpsoundtosquad))
    level.playjumpsoundtosquad = int(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, scripts\cp\utility::getgametype(), 20));

  return level.playjumpsoundtosquad;
}

reload_use_think() {
  if(!isDefined(level.playkillstreakdeploydialog)) {
    var_0 = getdvarint("_encstr_AF1805EFE726E9" + scripts\cp\utility::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB");

    if(var_0 == 0)
      var_0 = 900;

    var_1 = getdvarint("_encstr_AF1805EFE726E9" + scripts\cp\utility::getgametype() + "_encstr_B28B0AAFBB2DB9B1B4DA2DE8");

    if(var_1 > 0)
      var_0 = var_0 * (var_1 * 2 - 1);

    level.playkillstreakdeploydialog = reload_handle_hintstring() / 60 * (var_0 / 60);
  }

  return level.playkillstreakdeploydialog;
}