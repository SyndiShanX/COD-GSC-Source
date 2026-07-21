/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\game_utility.gsc
***********************************************/

getmapname() {
  if(!isDefined(level.mapname))
    level.mapname = getDvar("_encstr_9570084B1793A090CDFF");

  return level.mapname;
}

registerlargemap() {
  level.largemap = 1;
}

islargemap() {
  return istrue(level.largemap);
}

update_ai_volumes() {
  return level.gametype == "_encstr_B607038AAB" && islargemap();
}

_id_140A8() {
  if(level.gametype == "_encstr_B607038AAB") {
    var_0 = getdvarint("_encstr_9A4D19338E7347AED5D1732B38B7232FA378A9D6907857F59F680B", 1);

    if(var_0 == 2)
      return istrue(self._id_12E3A);
    else if(var_0 == 1)
      return 1;
  }

  return 0;
}

tutorialzoneenter() {
  return level.gametype == "_encstr_B607038AAB" && getDvar("_encstr_8B380D5AE910DF5A4ECFB3F7BDF612") == "_encstr_BD1904CF572A";
}

_id_140A9() {
  if(level.gametype == "_encstr_B607038AAB")
    return getdvarint("_encstr_9306299F1BEA895EA391F33B1A3F8C90924FD7238CD5209D5B2A4920C1974F80DDF75BB5173F28E41FA2C1", 1);
  else
    return 0;
}

_id_140AA() {
  if(level.gametype == "_encstr_B607038AAB")
    return getdvarint("_encstr_B6C61BE66CE4AF89E4F5AB37CAEBDDDD8CFAB6DE19568DAF37BB163837", 1);
  else
    return 0;
}

_id_12B26() {
  level.unsetchainkillstreaks = 1;
}

unsetchainkillstreaks() {
  return istrue(level.unsetchainkillstreaks);
}

_id_12B17() {
  level.unlink_on_ai_death = 1;
}

unlink_on_ai_death() {
  return istrue(level.unlink_on_ai_death);
}

_id_12B18() {
  level.matchdata_br_onmatchstart = 1;
}

unload_after_timeout() {
  return istrue(level.matchdata_br_onmatchstart);
}

validateprojectileent() {
  switch (level.mapname) {
    case "_encstr_AD2B10B5E0EBA1ADB9969BC659EB8E56E61D":
    case "_encstr_8F340F3992796F28DFDFE808E736C1FF27":
      return 1;
  }

  return 0;
}

turretdisabled() {
  switch (level.mapname) {
    case "_encstr_8D200EC21BB88FC238EB405D29B18AB6":
    case "_encstr_AF690B8DE7364F0A17C0C3EA12":
    case "_encstr_A9690B5B38F5ACB98D2C0EACCC":
    case "_encstr_9B330E11FF076B6E22C70B31FB3FB7B0":
    case "_encstr_8C690B68C3BF0D206ED1496BAA":
      return 1;
  }

  return 0;
}

turretlightsonstate() {
  switch (level.mapname) {
    case "_encstr_9B330E11FF076B6E22C70B31FB3FB7B0":
      return 1;
  }

  return getdvarint("_encstr_979615CB7F28694BFE26C29B685F431B58C77E299F206B", 0) == 1;
}

registernightmap() {
  level.nightmap = 1;
  getnodeindex("_encstr_96AF0E634B928017B6C8472E1FD064C8");
}

isnightmap() {
  return istrue(level.nightmap);
}

_id_12B2C() {
  level._id_11EB5 = 1;
}

update_operator_west_char_loc() {
  return istrue(level._id_11EB5);
}

registerarenamap() {
  level.arenamap = 1;
  level.loadoutdefaultfiresalediscount = 1;
  level._id_133D1 = 1;
  level.requiresminstartspawns = 0;
}

_id_12B3B() {
  level.loadoutdefaultfiresalediscount = 1;
  level._id_133D1 = 1;
}

_id_12B25() {
  level._id_133D5 = 1;
}

isarenamap() {
  return istrue(level.arenamap);
}

shouldskipfirstraise() {
  return istrue(level._id_133D1);
}

getlocaleid() {
  if(!isDefined(level.localeid)) {
    var_0 = getdvarint("_encstr_A1940DCB06FBCFB577B88A52A01367", 0);

    if(var_0 > 0)
      level.localeid = "_encstr_B4A608203A19875127D9" + var_0;
    else if(var_0 == 0)
      level.localeid = undefined;
    else if(unlink_on_ai_death())
      level.localeid = "_encstr_8A34097127C761890FA9D2";
    else {
      switch (getmapname()) {
        case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
          level.localeid = "_encstr_84340989AF4FE911972172";
          break;
        case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
          level.localeid = "_encstr_8A34097127C761890FA9D2";
          break;
        case "_encstr_93D20D28714743B99070632BAF3944":
          level.localeid = "_encstr_AF3409DC18C12FBD6B6107";
          break;
        case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
          level.localeid = "_encstr_AC9F0A2D80FF2A2CE9B19686";
          break;
      }
    }
  }

  return level.localeid;
}

getlocaleent(var_0, var_1) {
  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = undefined;

  if(isDefined(var_2) && var_2.size == 1)
    return var_2[0];

  if(isDefined(getlocaleid())) {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid) {
        var_3 = var_5;
        continue;
      }

      if(level.mapname == "_encstr_AC880C67503EA82A05DD62214CE7" && var_0 == "_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998") {
        if(var_5.origin == (34880, -26944, 3072))
          var_3 = var_5;

        continue;
      }

      var_5 delete();
    }
  } else {
    foreach(var_5 in var_2) {
      if(!isDefined(var_3)) {
        var_3 = var_5;
        continue;
      }

      var_5 delete();
    }
  }

  if(isDefined(var_3))
    return var_3;

  if(istrue(var_1))
    return;
}

removematchingents_bycodeclassname(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = undefined;

  if(isDefined(getlocaleid())) {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid)
        var_3 = var_5;
    }
  } else {
    foreach(var_5 in var_2) {
      if(!isDefined(var_3)) {
        var_3 = var_5;
        break;
      }
    }
  }

  if(isDefined(var_3))
    return var_3;

  if(istrue(var_1))
    return;
}

removematchingents_bykey(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = [];

  if(isDefined(getlocaleid())) {
    foreach(var_5 in var_2) {
      if(getmapname() == "_encstr_8B240B70C2BF685DFA3B1DF3C2") {
        var_3[var_3.size] = var_5;
        continue;
      }

      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid)
        var_3[var_3.size] = var_5;
    }

    return var_3;
  }

  if(var_2.size == 0) {
    if(istrue(var_1)) {}
  } else {}
}

isrealismenabled() {
  if(istrue(level.tacticalmode) || istrue(self.isrealismenabled))
    return 1;

  return 0;
}

fadetoblackforplayer(var_0, var_1, var_2) {
  var_0 notify("_encstr_95D714A24543A3FC66A01F33805EB43A67D6ED5EA6FF");
  var_0 endon("_encstr_95D714A24543A3FC66A01F33805EB43A67D6ED5EA6FF");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = 0;

  if(istrue(var_1))
    var_3 = 1;

  if(!isDefined(var_2) || var_2 == 0) {
    var_0 setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", var_3);
    return;
  }

  var_3 = 0;
  var_4 = int(var_2 / level.framedurationseconds);
  var_5 = 1 / var_4;

  if(!istrue(var_1)) {
    var_5 = var_5 * -1;
    var_3 = 1;
  }

  while(var_4 > 0) {
    var_3 = var_3 + var_5;
    var_0 setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", var_3);
    var_4--;
    waitframe();
  }
}

gettimesincegamestart() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88220D9C76FAE3CE55CB5868A78CC2", "_encstr_B4B3167656E88AA5DACAA65ACDC656E8166B95A6A32CC947")]]();
}

_id_13168(var_0) {
  self.vehicle_tracking_cp_post_spawn = var_0;
}

_encstr_BEB0164FA80BE3DA6325C63A986B22B7D39047BB802D3A02(var_0) {
  if(var_0 < 1) {
    return;
  }
  self._encstr_86B913A89FB1E07FF36333356FFBB0684CF2100207 = var_0;
}

startkeyearning() {
  if(isbot(self)) {
    return;
  }
  if(isDefined(self.reportchallengeuserevent_done)) {
    return;
  }
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  _id_13168(255);
  _encstr_BEB0164FA80BE3DA6325C63A986B22B7D39047BB802D3A02(255);
  var_0 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();

  if(istrue(level.ismp))
    self reportchallengeuserevent("_encstr_9B230C3EC5BADE83BEAF431B0F80", var_0);
  else
    self reportchallengeuserevent("_encstr_9B230C3EC5BADE83BEAF431B0F80", var_0);

  self.reportchallengeuserevent_done = 0;
}

stopkeyearning(var_0) {
  if(isbot(self)) {
    return;
  }
  if(istrue(self.reportchallengeuserevent_done)) {
    return;
  }
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  if(!isDefined(self.vehicle_tracking_cp_post_spawn))
    _id_13168(255);

  if(!isDefined(self._encstr_86B913A89FB1E07FF36333356FFBB0684CF2100207))
    _encstr_BEB0164FA80BE3DA6325C63A986B22B7D39047BB802D3A02(255);

  scripts\cp\vehicles\vehicle_compass_cp::_encstr_B476144DEC23E043FFEA49D092DF08087F6BE13B9C0A();
  var_1 = 0;

  if(isDefined(var_0)) {
    if(level.teambased) {
      if(var_0 == "_encstr_A6EB0BEB4C4470A3AB1A8B51B2")
        var_1 = 4;
      else if(var_0 == "_encstr_8D19048EA595")
        var_1 = 3;
      else if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && self.pers["_encstr_8AEF05472BC2D6"] == var_0)
        var_1 = 1;
      else if(isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && self.pers["_encstr_8AEF05472BC2D6"] != var_0)
        var_1 = 2;
    } else if(isDefined(self.connectedpostgame))
      var_1 = 0;
    else if(!isDefined(self.timeplayed) || self.timeplayed["_encstr_BE7D0633C08849E2"] < 1 || self.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] < 1)
      var_1 = 0;
    else if(!istrue(self.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"]))
      var_1 = 0;
    else if(!isDefined(level.placement))
      var_1 = 0;
    else if(!isPlayer(var_0) && var_0 == "_encstr_A6EB0BEB4C4470A3AB1A8B51B2")
      var_1 = 4;
    else {
      var_2 = 0;

      for(var_3 = 0; var_3 < min(level.placement["_encstr_AF1904A7F929"].size, 3); var_3++) {
        if(level.placement["_encstr_AF1904A7F929"][var_3] != self) {
          continue;
        }
        var_2 = 1;
      }

      if(var_2)
        var_1 = 1;
      else
        var_1 = 2;
    }
  }

  var_4 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  var_5 = 0;

  if(isDefined(self.pers["_encstr_B1A81263104592BBB74837413915989D6123EAE5"]))
    var_5 = int(self.pers["_encstr_B1A81263104592BBB74837413915989D6123EAE5"]);

  var_6 = 0;

  if(isDefined(self.pers["_encstr_B8FE12908769CBCB1A2F5DDECA420FD0D5333983"]))
    var_6 = self.pers["_encstr_B8FE12908769CBCB1A2F5DDECA420FD0D5333983"];

  var_7 = 0;

  if(isDefined(self.pers["_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D"]))
    var_7 = self.pers["_encstr_A7670DC9ACDC3AEDC6B60DDBD5731D"];

  var_8 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
  var_9 = int(gettimesincegamestart() / 1000.0);

  if(self.vehicle_tracking_cp_post_spawn != 255)
    scripts\cp\vehicles\vehicle_compass_cp::_id_1205A(self.vehicle_tracking_cp_post_spawn);

  var_10 = 1.0;
  var_11 = 1.0;
  var_12 = 1.0;

  if(isDefined(level.rankxpmultipliers) && isDefined(level.rankxpmultipliers["_encstr_B66612EDCDB1B4CD56F56B077DF0839B3658D856"]) && level.rankxpmultipliers["_encstr_B66612EDCDB1B4CD56F56B077DF0839B3658D856"] >= 2)
    var_10 = 2.0;

  if(isDefined(level.weaponrankxpmultipliers) && isDefined(level.weaponrankxpmultipliers["_encstr_AC1A194FFE95C0B01789D8639187FD482A47C5B780FA480E2F52D1"]) && level.weaponrankxpmultipliers["_encstr_AC1A194FFE95C0B01789D8639187FD482A47C5B780FA480E2F52D1"] >= 2)
    var_11 = 2.0;

  if(isDefined(level.cleanupfunc) && isDefined(level.cleanupfunc["_encstr_AA361B47F548748B85D6625ADB65DB2F7961D0C307D8FD6FA0A95B4223"]) && level.cleanupfunc["_encstr_AA361B47F548748B85D6625ADB65DB2F7961D0C307D8FD6FA0A95B4223"] >= 2)
    var_12 = 2.0;

  var_13 = scripts\cp\vehicles\vehicle_compass_cp::relic_squadlink_onsteppedclose();
  var_14 = 0;
  var_15 = int(self.vehicle_tracking_cp_post_spawn / self._encstr_86B913A89FB1E07FF36333356FFBB0684CF2100207 * 100);
  var_16 = 0;

  if(isDefined(self.pers["_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3"]))
    var_16 = int(self.pers["_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3"]);

  if(istrue(level.ismp))
    self reportchallengeuserevent("_encstr_99A40A9537C8AFDA161DB10D", var_4, var_1, var_5, var_6, var_7, var_8, var_9, self.vehicle_tracking_cp_post_spawn, int(var_10 * 100.0), int(var_11 * 100.0), int(var_12 * 100.0), var_13, var_14, var_15, var_16);
  else {
    if(isDefined(var_0) && var_0 == "_encstr_88E308D7ADF5379F7903")
      var_1 = 1;
    else
      var_1 = 2;

    self reportchallengeuserevent("_encstr_99A40A9537C8AFDA161DB10D", var_4, var_1, var_5, 0, 0, var_8, var_9, self.vehicle_tracking_cp_post_spawn, int(var_10 * 100.0), int(var_11 * 100.0), int(var_12 * 100.0), var_13, var_14, var_15, var_16);
  }

  self.reportchallengeuserevent_done = 1;
}

_visionsetnakedforplayer(var_0, var_1) {
  if(var_0 == "_encstr_B40101") {
    self visionsetnakedforplayer(var_0, var_1);

    if(isDefined(self.activevisionsetlist))
      self.activevisionsetlist = undefined;

    return;
  }

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(self.activevisionsetlist))
    self.activevisionsetlist = [];

  if(!isDefined(self.activevisionsetlist[var_0]))
    self.activevisionsetlist[var_0] = 1;
  else
    self.activevisionsetlist[var_0]++;

  if(self.activevisionsetlist[var_0] == 1)
    self visionsetnakedforplayer(var_0, var_1);
}

_visionunsetnakedforplayer(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.activevisionsetlist[var_0]--;

  if(self.activevisionsetlist[var_0] == 0) {
    var_1 = [];

    foreach(var_4, var_3 in self.activevisionsetlist) {
      if(var_4 == var_0) {
        continue;
      }
      var_1[var_4] = var_3;
    }

    self.activevisionsetlist = var_1;
    self visionsetnakedforplayer("_encstr_B40101", 0);

    foreach(var_4, var_3 in var_1)
    self visionsetnakedforplayer(var_4, level.framedurationseconds);
  }
}

_id_12C11(var_0, var_1) {
  var_2 = getEntArray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.model) && var_4.model == var_0) {
      if(istrue(var_1) && isDefined(var_4.target))
        _id_12C10(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      var_4 delete();
    }
  }
}

_id_12C0F(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.code_classname) && var_3.code_classname == var_0)
      var_3 delete();
  }
}

_id_12C0E(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.classname) && var_3.classname == var_0)
      var_3 delete();
  }
}

_id_12C10(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2)
  var_4 delete();
}

teamwipedobituary() {
  var_0 = spawnStruct();
  level.getallselectableattachments = var_0;
  var_0.game_type_col = [];
  var_0.game_type_col["_encstr_9707038CB6"] = 5;
  var_0.game_type_col["_encstr_B41904BB8593"] = 6;
  var_0.game_type_col["_encstr_B807035284"] = 7;
  var_0.game_type_col["_encstr_8218041DF5FA"] = 8;
  var_0.game_type_col["_encstr_959105B99040BD"] = 9;
  var_0.game_type_col["_encstr_9B0703CD93"] = 10;
  var_0.game_type_col["_encstr_A7290676E4D2378C"] = 11;
  var_0.game_type_col["_encstr_819B0572BF80BB"] = 12;
  var_0.game_type_col["_encstr_AAE507E8423F63C163"] = 13;
  var_0.game_type_col["_encstr_8E65062BD0CFB4EC"] = 14;
  var_0.game_type_col["_encstr_8A1804DAAB75"] = 15;
  var_0.game_type_col["_encstr_9A7205B39CB919"] = 16;
  var_0.game_type_col["_encstr_A54F06D32A2F0498"] = 17;
  var_0.game_type_col["_encstr_BDD705AD7BD143"] = 18;
  var_0.game_type_col["_encstr_8E1904B3F501"] = 19;
  var_0.game_type_col["_encstr_B60703EACA"] = 20;
  var_0.game_type_col["_encstr_85EF050CB150E7"] = 21;
  var_0.game_type_col["_encstr_AA5606FD1AF05085"] = 22;
  var_0.game_type_col["_encstr_9719046E3182"] = 23;
  var_0.game_type_col["_encstr_B607038AAB"] = 24;
  var_0.game_type_col["_encstr_A9B606B0C956B916"] = 25;
  var_0.game_type_col["_encstr_ACF906B79752C5E8"] = 26;
  var_0.game_type_col["_encstr_A61F054B28EBE0"] = 27;
  var_0.game_type_col["_encstr_8D1804ACCD8D"] = 28;
  var_0.game_type_col["_encstr_951904D8F1E0"] = 29;
  var_0.game_type_col["_encstr_A9190405B4E5"] = 30;
  var_0.game_type_col["_encstr_AF6A069265315388"] = 31;
  var_0.game_type_col["_encstr_B81904B04E6B"] = 32;
  var_0.game_type_col["_encstr_93A2056DBB5853"] = 33;
  var_0.game_type_col["_encstr_B1C5079B73C2D13634"] = 34;
  var_0.game_type_col["_encstr_8E07030349"] = 35;
  var_0.game_type_col["_encstr_A10C0780F23F6F400B"] = 36;
  var_0.game_type_col["_encstr_A20D05FBEB01F2"] = 37;
  var_0.game_type_col["_encstr_97AB06BBB583D1F5"] = 38;
  var_0.game_type_col["_encstr_BA1904921B3B"] = 39;
  var_0.game_type_col["_encstr_B1190448CD80"] = 40;
  var_0.game_type_col["_encstr_8CA606F38878410D"] = 41;
  var_0.game_type_col["_encstr_839E0CBFD1801B5DB0D34C932998"] = 42;
  var_0.game_type_col["_encstr_B6570B78A33FB39B3317E886AB"] = 43;
  var_0.game_type_col["_encstr_931D068662634370"] = 44;
  var_0.game_type_col["_encstr_831904E79F07"] = 45;
  var_0.game_type_col["_encstr_8B6B0B26FA20C3E85FFAA84F0B"] = 46;
}

game_utility_init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88220D9C76FAE3CE55CB5868A78CC2", "_encstr_88C5055208731B")]]();
}