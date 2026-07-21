/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\killstreaks.gsc
***********************************************/

removeincoming() {
  var_0 = 3;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    var_0 = 1;

  return var_0;
}

initkillstreakdata() {
  var_0 = spawnStruct();
  level.killstreakglobals = var_0;
  var_0.costomnvars = [];
  var_0.costomnvars[1] = "_encstr_B15A15D573597A2718FBEA31A3ED2BB7F0DF474BE7D043";
  var_0.costomnvars[2] = "_encstr_B65819C8C73F339FA2D2F590EA6BC5B96957117817D74E578ABA75";
  var_0.costomnvars[3] = "_encstr_ABC51BEA967D9BD8DBE4B2AF6EE8C959165BF53A344EACCA7DB1B737A3";
  var_0.slotomnvars = [];
  var_0.slotomnvars[0] = "_encstr_A39E181BECE7200E32031B672FABCE2871C4C610D50458BB6972";
  var_0.slotomnvars[1] = "_encstr_8F9E18A3B84F326708E6BD8F7E337BFF5BD089FA28816FC3E66F";
  var_0.slotomnvars[2] = "_encstr_919E18D52DEBCD8DDEC956BECD479CAC2CADF5A573C82B0FFA91";
  var_0.slotomnvars[3] = "_encstr_AC9E186B83870B23A8D8C727F8E30AD2532A79E4F829A270F6AA";
  var_0.availableomnvars = [];
  var_0.availableomnvars[0] = "_encstr_85B21C6B18C9431A90C58F6FEFC5D38DD0A069F6538011A2FFFD939F4FCF";
  var_0.availableomnvars[1] = "_encstr_ADB21CDD9829209F8F436046D3E312CD899781606E09ECE22F6A6852F6F3";
  var_0.availableomnvars[2] = "_encstr_84B21C5DB4F5E636BD3995AFCD479C56B06DBEB0D92C4BB10B4C6395BE19";
  var_0.availableomnvars[3] = "_encstr_8AB21C90AAE9A729F722E5F01BA33343CE1249C8B3BE2B80A75A79D5DF56";
  parsestreaktable();
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::killstreakonteamchange);
}

parsestreaktable() {
  var_0 = level.killstreakglobals;

  if(isDefined(game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"])) {
    var_0.streaktable = game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"];
    return;
  }

  var_1 = spawnStruct();
  game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"] = var_1;
  var_0.streaktable = var_1;
  var_1.tabledatabyref = [];
  var_2 = 1;

  for(;;) {
    var_3 = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 1);

    if(var_3 == "_encstr_B40101") {
      break;
    }

    var_1.tabledatabyref[var_3] = [];
    var_1.tabledatabyref[var_3]["_encstr_B48F06CC58B0F50B"] = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 0));
    var_1.tabledatabyref[var_3]["_encstr_825208061DE7FBB08DAB"] = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 27));
    var_1.tabledatabyref[var_3]["_encstr_BE6C080DBA2392367BE6"] = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 12);
    var_1.tabledatabyref[var_3]["_encstr_8FAE0D7BECCA4ED05958C892B1B737"] = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 13);
    var_1.tabledatabyref[var_3]["_encstr_82A50F2BCA77EB1A6F33F56D31E7E0A75F"] = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 10));
    var_1.tabledatabyref[var_3]["_encstr_8E8D0697EB01F243"] = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 4));
    var_1.tabledatabyref[var_3]["_encstr_A9BD0C33AB3FCBD580F16347D798"] = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 5));
    var_1.tabledatabyref[var_3]["_encstr_82F50AC337E76B7345E50B74"] = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 6));
    var_1.tabledatabyref[var_3]["_encstr_84BA05A8CA852B"] = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 2);
    var_1.tabledatabyref[var_3]["_encstr_A60B0C5B60D8AFED315DC5F54508"] = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 16);

    if(var_3 != "_encstr_8BBA05185F8B99") {
      var_4 = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 7);
      game["_encstr_B2DA070A5F8BAB87AF"][var_3] = var_4;
      var_5 = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 8);
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83E71143334233A0E34151EBF4DDB0FD1A0F47" + var_3 + "_encstr_86FF098F7BCD431D2BC8F2"] = var_5 + "_encstr_AA6C0EA77B73086198AD84D3366D0BE7";
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A060E9972031B807AFF534DED25B8C8" + var_3 + "_encstr_86FF098F7BCD431D2BC8F2"] = var_5 + "_encstr_8CCC0BEBB2DCB25B5EEB5D372B";
      var_6 = tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 9);
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81530F7169AF76277EAB486DF01BC3508F" + var_3 + "_encstr_86FF098F7BCD431D2BC8F2"] = var_6 + "_encstr_AA6C0EA77B73086198AD84D3366D0BE7";
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADAC0CA31804C0F8C7AAE990A357" + var_3 + "_encstr_86FF098F7BCD431D2BC8F2"] = var_6 + "_encstr_8CCC0BEBB2DCB25B5EEB5D372B";
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7E40528F8D8C7" + var_3] = var_5 + "_encstr_AB430576C3D388";
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACB80B32E13893EAC81A9F1209" + var_3] = var_5 + "_encstr_8D5A0BF58C59B98E39F65E2B32";
      game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3C8091B70E9F7BDC09927" + var_3] = var_5 + "_encstr_A3BD09C633595885CA97A1";
      var_7 = int(tablelookupbyrow("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", var_2, 11));
      scripts\mp\rank::registerscoreinfo("_encstr_91190C5BC21225AA3320AB5238E9" + var_3, "_encstr_BA94069D16D8ABAC", var_7);
    }

    var_2++;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isDefined(var_0.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"]))
      var_0.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"] = 0;

    if(!isDefined(var_0.pers["_encstr_B19F0BDCE8E4590BD611851D85"]))
      var_0.pers["_encstr_B19F0BDCE8E4590BD611851D85"] = createplayerstreakdatastruct();

    var_0.streakdata = var_0.pers["_encstr_B19F0BDCE8E4590BD611851D85"];
    var_0 scripts\mp\utility\stats::initpersstat("_encstr_819A0D6335439F5ED779027A903112");
    var_0.streakpoints = var_0 scripts\mp\utility\stats::getpersstat("_encstr_819A0D6335439F5ED779027A903112");
    var_0.previousstreakpoints = var_0.streakpoints;
    var_0.nukepoints = var_0 scripts\mp\utility\stats::getpersstat("_encstr_84C910D248050977F8F9A49F0E236BCF4B20");
    var_0 visionsetmissilecamforplayer(game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"]);

    if(!level.roundretainstreaks)
      var_0 resetstreakavailability(1);
  }
}

onplayerspawned() {
  if(isDefined(level.deathretainstreaks) && !level.deathretainstreaks)
    resetstreakavailability(1);

  selectfirstavailablekillstreak();

  if(!isDefined(self.earnedstreaklevel))
    self.earnedstreaklevel = 0;

  self.triggeringstreak = undefined;
  setstreakcounttonext();
  updatekillstreakselectedui();
  updatekillstreakuislots();
  updatestreakmeterui();
  updatestreakcosts();
  _id_13DB8();
}

createplayerstreakdatastruct() {
  var_0 = spawnStruct();
  var_0.streaks = [];
  return var_0;
}

getplayerstreakdata() {
  return self.streakdata;
}

resetforloadoutswitch() {
  updatespecialistui();
  updatestreakcosts();

  if(isDefined(self.oldperks) && isDefined(self.perks) && self.oldperks.size > 0) {
    if(scripts\engine\utility::array_contains_key(self.perks, "_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E") && scripts\engine\utility::array_contains_key(self.oldperks, "_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E"))
      return;
    else if(!scripts\engine\utility::array_contains_key(self.oldperks, "_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E"))
      return;
    else {
      resetstreakpoints();
      resetstreakavailability();
      updatekillstreakuislots();
      updatekillstreakselectedui();
    }
  }
}

setupinputnotifications() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isbot(self)) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  self notifyonplayercommand("_encstr_8DDC0D5B37EBCD951B59D88EAF5DE0", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  self notifyonplayercommand("_encstr_A7FE0F1B5A28331AE820CBC3F76BB0BCFE", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  self notifyonplayercommand("_encstr_B15E0CCB4759FE2795984A22264D", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
  self notifyonplayercommand("_encstr_BA5E0CB6E6FAC28D3A4BBD73D71B", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
  self notifyonplayercommand("_encstr_8D5E0CB66ED7B06C3A96DB73AF66", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_A25E0C6803E1FB519321F8603FBA", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  self setactionslot(4, "_encstr_B40101");
}

updatestreakcount() {
  if(self.streakpoints == self.previousstreakpoints) {
    return;
  }
  var_0 = self.streakpoints;
  self setkillstreakpoints(int(min(self.streakpoints, 16384)));

  if(!isDefined(self.nextstreakcost) || self.streakpoints >= self.nextstreakcost)
    setstreakcounttonext();
}

resetstreakcount() {
  self setkillstreakpoints(0);
  self setclientomnvar("_encstr_B15A15D573597A2718FBEA31A3ED2BB7F0DF474BE7D043", 0);
  var_0 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

  if(!var_0) {
    self setclientomnvar("_encstr_B65819C8C73F339FA2D2F590EA6BC5B96957117817D74E578ABA75", 0);
    self setclientomnvar("_encstr_ABC51BEA967D9BD8DBE4B2AF6EE8C959165BF53A344EACCA7DB1B737A3", 0);
  }

  setstreakcounttonext();
  self resetclientkillstreakavailability();
}

setstreakcounttonext() {
  if(!isDefined(self.streaktype)) {
    self.nextstreakcost = 0;
    self setnextkillstreakcost(0);
    return;
  }

  if(findmaxstreakcost() == 0) {
    self.nextstreakcost = 0;
    self setnextkillstreakcost(0);
    return;
  }

  var_0 = self.nextstreakcost;
  var_1 = getnextstreakname();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = calcstreakcost(var_1);
  self.nextstreakcost = var_2;

  if(scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E") && isDefined(getkillstreakinslot(1)) && !istrue(self.earnedmaxkillstreak)) {
    var_3 = 0;

    foreach(var_5 in self.streakdata.streaks) {
      if(istrue(var_5.earned)) {
        var_3 = 1;
        continue;
      }

      var_3 = 0;
    }

    if(var_3 && !isDefined(self.earnedmaxkillstreak)) {
      self.earnedmaxkillstreak = 1;
      self.nextstreakcost = 0;
      self setnextkillstreakcost(0);
      self setkillstreakpoints(0);
      self setclientomnvar("_encstr_B15A15D573597A2718FBEA31A3ED2BB7F0DF474BE7D043", 0);
      var_7 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

      if(!var_7) {
        self setclientomnvar("_encstr_B65819C8C73F339FA2D2F590EA6BC5B96957117817D74E578ABA75", 0);
        self setclientomnvar("_encstr_ABC51BEA967D9BD8DBE4B2AF6EE8C959165BF53A344EACCA7DB1B737A3", 0);
      }

      return;
    }
  }

  self setnextkillstreakcost(var_2);
}

getnextstreakname() {
  if(self.streakpoints == findmaxstreakcost() && self.streaktype != "_encstr_BAAE0B0FF9C056F999C9F4D008")
    var_0 = 0;
  else
    var_0 = self.streakpoints;

  for(var_1 = 1; var_1 <= 4; var_1++) {
    var_2 = getkillstreakinslot(var_1);

    if(var_2.currentcost > var_0)
      return var_2.streakname;
  }

  return undefined;
}

updatestreakmeterui() {
  self setclientomnvar("_encstr_811810C3AC700F3F274EB94E93CBD2731FD2", self.streakpoints);
}

updatestreakcosts() {
  updatestreakcost(1);
  updatestreakcost(2);
  updatestreakcost(3);
  updatestreakcost(4);
}

updatestreakcost(var_0) {
  var_1 = level.killstreakglobals;
  var_2 = getkillstreakinslot(var_0);

  if(isDefined(var_2)) {
    var_3 = calcstreakcost(var_2.streakname);
    var_2.currentcost = var_3;

    if(var_0 <= removeincoming()) {
      var_4 = var_1.costomnvars[var_0];
      self setclientomnvar(var_4, var_3);
    }
  }
}

findmaxstreakcost() {
  for(var_0 = 4; var_0 >= 1; var_0--) {
    var_1 = getkillstreakinslot(var_0);

    if(!isDefined(var_1)) {
      continue;
    }
    return var_1.currentcost;
  }

  return 0;
}

updatekillstreakuislots() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  var_0 = level.killstreakglobals;

  for(var_1 = 0; var_1 <= removeincoming(); var_1++)
    updatekillstreakuislot(var_1);
}

updatekillstreakuislot(var_0) {
  if(var_0 > removeincoming()) {
    return;
  }
  if(isDefined(level._id_11C8C) && ![[level._id_11C8C]](var_0)) {
    return;
  }
  var_1 = level.killstreakglobals;
  var_2 = getkillstreakinslot(var_0);

  if(isDefined(var_2) && isDefined(var_2.streakname)) {
    var_3 = undefined;

    if(istrue(self.loadoutusingspecialist) && var_0 != 0) {
      var_4 = scripts\mp\perks\perks::getspecialistperkforstreak(var_2.streakname);
      var_3 = scripts\mp\perks\perks::getperkid(var_4);
    } else
      var_3 = scripts\mp\utility\killstreak::getkillstreakindex(var_2.streakname);

    self setclientomnvar(var_1.slotomnvars[var_0], var_3);
    self setclientomnvar(var_1.availableomnvars[var_0], var_2.available);
    ammobox_getbufferedattachment(var_0, var_3);
    ammobox_clearbufferedattachmentweapon(var_0, var_2.available);
  } else {
    self setclientomnvar(var_1.slotomnvars[var_0], 0);
    self setclientomnvar(var_1.availableomnvars[var_0], 0);
    ammobox_getbufferedattachment(var_0, 0);
    ammobox_clearbufferedattachmentweapon(var_0, 0);
  }
}

updatekillstreakselectedui() {
  var_0 = getselectedkillstreakindex();

  if(isDefined(var_0))
    self setclientomnvar("_encstr_95B41E5F5A1F4827586A63414684C81898B08F135B992970388D5991C02C9FA3", var_0);
  else
    self setclientomnvar("_encstr_95B41E5F5A1F4827586A63414684C81898B08F135B992970388D5991C02C9FA3", -1);
}

updatespecialistui() {
  if(isDefined(self.loadoutusingspecialist))
    self setclientomnvar("_encstr_86161EFBE8710FCF303395F79ABB13937EAAD7D963908B22250FD37B8CF7A265", self.loadoutusingspecialist);
}

killstreakonteamchange(var_0) {
  if(istrue(var_0.changedteams))
    var_0 clearkillstreaks();
}

listenkillstreakaction(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "_encstr_AD1C0E6B1B7A20BFA267C7E3836AF6F0")
    dokillstreakaction(undefined, var_1);
}

dokillstreakaction(var_0, var_1) {
  if(isDefined(self.triggeringstreak)) {
    return;
  }
  if(isDefined(var_0) && issubstr(var_0, "_encstr_831904EFF7F7"))
    var_1 = gettriggeredslotfromnotify(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getkillstreakinslot(var_1);

  if(!isDefined(var_2) || var_2.available == 0 || var_2.available == -1) {
    return;
  }
  setselectedkillstreak(var_1);
  thread triggerkillstreak(var_2, var_1);
}

trytriggerkillstreakfromsuper(var_0) {
  var_1 = createstreakitemstruct(var_0);
  var_1.available = 1;
  return triggerkillstreak(var_1);
}

gettriggeredslotfromnotify(var_0) {
  var_1 = undefined;

  if(!isai(self)) {
    if(!self usinggamepad()) {
      if(var_0 == "_encstr_8D5E0CB66ED7B06C3A96DB73AF66" || var_0 == "_encstr_A25E0C6803E1FB519321F8603FBA" || var_0 == "_encstr_B15E0CCB4759FE2795984A22264D" || var_0 == "_encstr_BA5E0CB6E6FAC28D3A4BBD73D71B")
        var_1 = getselectedkillstreakindex();
    }
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919" && !scripts\engine\utility::is_player_gamepad_enabled()) {
    switch (var_0) {
      case "_encstr_8D5E0CB66ED7B06C3A96DB73AF66":
        var_1 = 0;
        break;
      case "_encstr_A25E0C6803E1FB519321F8603FBA":
        var_1 = 0;
        break;
      case "_encstr_B15E0CCB4759FE2795984A22264D":
        var_1 = 0;
        break;
      case "_encstr_BA5E0CB6E6FAC28D3A4BBD73D71B":
        var_1 = 0;
        break;
    }
  } else {
    switch (var_0) {
      case "_encstr_8D5E0CB66ED7B06C3A96DB73AF66":
        var_1 = 1;
        break;
      case "_encstr_A25E0C6803E1FB519321F8603FBA":
        var_1 = 2;
        break;
      case "_encstr_B15E0CCB4759FE2795984A22264D":
        var_1 = 3;
        break;
      case "_encstr_BA5E0CB6E6FAC28D3A4BBD73D71B":
        var_1 = 0;
        break;
    }
  }

  return var_1;
}

iskillstreakvisibleforcodcaster(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "_encstr_8C9D0C506F0B96A8F78B297BF313":
    case "_encstr_86F20A19E4F6E659469CDEE0":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
    case "_encstr_851904B59B34":
      return 0;
    default:
      return 1;
  }
}

triggerkillstreak(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_0.streaksetupinfo;

  if(!scripts\common\utility::is_killstreaks_allowed()) {
    scripts\mp\hud_message::showerrormessage("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && isDefined(self.scrambledby)) {
    if(var_0.streakname != "_encstr_8F770E0752D834A2F69B9BAF8F16EA67") {
      scripts\mp\hud_message::showerrormessage("_encstr_8C371D6198B78575014891D1E0AD83FE736590E43ABEE3F36560D199D877C9");
      return 0;
    }
  }

  if(isDefined(level._id_11C6C) && !self[[level._id_11C6C]](var_0, var_1)) {
    scripts\mp\hud_message::showerrormessage("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");
    return 0;
  }

  if(var_0.isspecialist || isDefined(self.triggeringstreak) && self.triggeringstreak == var_0)
    return 0;

  self.triggeringstreak = var_0;
  scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_cancelalldeployments();
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0.streakname, self);
  var_3.mpstreaksysteminfo = var_0;
  var_4 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

  if(var_4)
    var_0.uniqueid = var_3.id;

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var_5 = self[[var_2.triggeredfunc]](var_3);
  self.triggeringstreak = undefined;

  if(!istrue(var_5))
    return 0;

  if(isDefined(var_1))
    onsuccessfulstreakactivation(var_0, var_1);

  return 1;
}

onkillstreaktriggered(var_0) {
  return 1;
}

onkillstreakbeginuse(var_0) {
  var_1 = var_0.owner;

  if(!isDefined(var_1))
    return 0;

  if(!var_1 scripts\mp\utility\killstreak::validateusestreak(var_0.streakname))
    return 0;

  return 1;
}

onkillstreakfinishuse(var_0, var_1) {}

forceactivatekillstreak(var_0, var_1) {
  var_2 = createstreakitemstruct(var_0);
  triggerkillstreak(var_2);
}

forceactivategimmekillstreak() {
  var_0 = getkillstreakinslot(0);
  triggerkillstreak(var_0);
}

onsuccessfulstreakactivation(var_0, var_1) {
  var_2 = var_0.streakname;

  if(istrue(level._id_145EC) && self.streaktype != "_encstr_BAAE0B0FF9C056F999C9F4D008")
    var_0.available = -1;
  else
    var_0.available = -1;

  ammobox_clearbufferedattachmentweapon(var_1, var_0.available);
  var_3 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

  if(isDefined(var_1)) {
    if(var_3 || (var_1 == 0 || var_1 >= 5))
      removekillstreak(var_1);

    selectnextavailablekillstreak();
    updatekillstreakuislot(var_1);
  } else {}

  thread scripts\cp\vehicles\vehicle_compass_cp::usedkillstreak(var_2);
  scripts\mp\utility\print::printgameaction("_encstr_B82A160AE47A61DBC46388903FA8139972CA7D853F165BE9" + var_2, self);
  scripts\mp\utility\dialog::playkillstreakusedialog(var_2);
  var_6 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_0.attackerisinflictor = var_6;
  scripts\mp\analyticslog::logevent_killstreakactivated(self, var_0._id_13913, var_0.streakname, var_0.isgimme, var_6, self.origin);

  switch (var_2) {
    case "_encstr_BAE50DE60E739BA638C72068AF47B9":
      scripts\mp\utility\stats::incpersstat("_encstr_86E81A0FE828C49B598EE79E7A5FF28251899FA7606107222326EFD7", 1);
      break;
    case "_encstr_A3C51256AD95277695CDB15EBE585A4E8C39ED1C":
      scripts\mp\utility\stats::incpersstat("_encstr_96E31F4A9252217B3B93F74040C80D57E36FE51AE62129C8DA4782B5138FABE0AF", 1);
      break;
  }

  combatrecordkillstreakuse(var_2);

  if(isDefined(self.petwatch)) {
    scripts\cp_mp\pet_watch::addkillstreakcharge();

    if(var_0.currentcost > 7)
      scripts\cp_mp\pet_watch::addtopkillstreakcharge();

    if(var_2 == "_encstr_B8BA05F06B9785")
      scripts\cp_mp\pet_watch::addnukecharge();
    else if(var_2 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
      scripts\cp_mp\pet_watch::battle_tracks_standingonsamevehiclewithsametracksowner();
  }
}

createstreakitemstruct(var_0) {
  var_1 = spawnStruct();
  var_1.available = 0;
  var_1.streakname = var_0;
  var_1.isgimme = 0;
  var_1.streaksetupinfo = getkillstreaksetupinfo(var_0);
  var_1.madeavailabletime = -1;
  var_1.currentcost = calcstreakcost(var_0);
  var_1.isspecialist = scripts\mp\perks\perks::usescriptablemeleeblood(var_0);
  var_1._id_136D2 = scripts\mp\perks\perks::getspecialistperkforstreak(var_0);
  return var_1;
}

awardkillstreak(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = createstreakitemstruct(var_0);
  awardkillstreakfromstruct(var_6, var_1, var_2, var_3, var_4, var_5);
}

awardkillstreakfromstruct(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0.isgimme = 1;
  var_6 = 0;

  if(isDefined(var_5))
    var_6 = var_5;

  if(isDefined(var_0)) {
    if(!isDefined(var_2))
      var_2 = var_0.streaklifeid;

    if(!isDefined(var_3))
      var_3 = var_0._id_13913;
  }

  slotkillstreak(var_0, var_6);
  setselectedkillstreak(var_6);
  makekillstreakavailable(var_6, var_1, var_2, var_3, var_4);
}

equipkillstreak(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = createstreakitemstruct(var_0);
  slotkillstreak(var_2, var_1);
}

equipslotonekillstreak(var_0) {
  equipkillstreak(var_0, 1);
}

equipslottwokillstreak(var_0) {
  equipkillstreak(var_0, 2);
}

equipslotthreekillstreak(var_0) {
  equipkillstreak(var_0, 3);
}

pushgimmeslotstreakontostack() {
  var_0 = getplayerstreakdata();

  if(isDefined(var_0.streaks[36]))
    return 0;

  var_1 = var_0.streaks[0];

  if(!isDefined(var_1))
    return 1;

  for(var_2 = 5; var_2 < 37; var_2++) {
    if(!isDefined(var_0.streaks[var_2])) {
      var_0.streaks[var_2] = var_1;
      var_0.streaks[0] = undefined;
      break;
    }
  }

  return 1;
}

popstackedstreakintogimmeslot() {
  var_0 = getplayerstreakdata();
  var_1 = var_0.streaks[0];
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 5; var_4 < 37; var_4++) {
    var_5 = var_0.streaks[var_4];

    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = var_4;
      continue;
    }

    break;
  }

  var_0.streaks[0] = var_2;

  if(isDefined(var_3))
    var_0.streaks[var_3] = undefined;
}

deletestackedstreak(var_0) {
  var_1 = getplayerstreakdata();

  if(var_0 == 36) {
    var_1.streaks[var_0] = undefined;
    return;
  }

  for(var_2 = var_0; var_2 < 36; var_2++) {
    var_3 = var_1.streaks[var_2 + 1];

    if(!isDefined(var_3)) {
      break;
    }

    var_1.streaks[var_0] = var_3;
  }
}

removekillstreak(var_0) {
  self.streakdata.streaks[var_0] = undefined;

  if(var_0 == 0)
    popstackedstreakintogimmeslot();
  else if(var_0 >= 5)
    deletestackedstreak(var_0);
}

clearkillstreaks() {
  self.streakdata.streaks = [];
  resetstreakpoints();
  resetstreakavailability();
  clearkillstreakselection();
  updatekillstreakuislots();
  updatekillstreakselectedui();
}

slotkillstreak(var_0, var_1) {
  if(var_1 == 0) {
    if(!pushgimmeslotstreakontostack())
      return;
  } else {}

  self.streakdata.streaks[var_1] = var_0;
  updatekillstreakuislot(var_1);

  if(var_1 != 0)
    updatestreakcost(var_1);
}

earnkillstreak(var_0, var_1) {
  var_2 = getkillstreakinslot(var_0);
  var_3 = var_2.streakname;
  scripts\mp\utility\script::bufferednotify("_encstr_A7C21B73793EB0078149500820A1924BF822DE94F1BAE8527022EA6BB4", var_3);
  self.earnedstreaklevel = var_1;

  if(scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E"))
    self.streakdata.streaks[var_0].earned = 1;

  self.streakdata.streaks[var_0].lifeid = scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();

  if(!level.gameended) {
    thread scripts\mp\hud_message::showkillstreaksplash(var_3, var_1);
    combatrecordincrementkillstreakawardedstat(var_3);
  }

  setstreakcounttonext();
  makekillstreakavailable(var_0, "_encstr_BEBD07C1360273C53A");
}

makekillstreakavailable(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getkillstreakinslot(var_0);

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = var_5.streakname;

  if(isDefined(var_5._id_136D2))
    var_6 = var_5._id_136D2;

  loadassociatedkillstreakweapons(var_6);
  var_7 = var_5.streaksetupinfo;

  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    return;
  }
  var_5.available = 1;
  ammobox_clearbufferedattachmentweapon(var_0, var_5.available);
  setselectedkillstreak(var_0);
  updatekillstreakuislot(var_0);

  if(isDefined(var_7.availablefunc))
    self[[var_7.availablefunc]](var_5);

  if(var_5.isgimme)
    self notify("_encstr_8D171B28EA660BE813B5E5708D77B3D54F62C918C27DA1E373CA7D576B");

  var_5.madeavailabletime = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_5.streaklifeid = self.lifeid;
  var_5._id_13913 = self.matchdatalifeindex;
  var_5.owner = self;
  var_5._id_121B0 = self getxuid();

  if(isDefined(var_2))
    var_5.streaklifeid = var_2;

  if(isDefined(var_3))
    var_5._id_13913 = var_3;

  if(isDefined(var_4)) {
    var_5.owner = var_4;
    var_5._id_121B0 = var_4 getxuid();
  }

  scripts\cp\vehicles\vehicle_compass_cp::_id_12047(var_5.streakname, var_1);
  scripts\mp\analyticslog::logevent_killstreakavailable(self, var_5._id_13913, var_6, var_5.isgimme, var_5.madeavailabletime, self.origin);

  if(isDefined(self.petwatch) && var_0 == removeincoming()) {
    var_8 = 0;
    var_9 = 0;
    var_10 = getallavailablekillstreakstructs();

    foreach(var_12 in var_10) {
      var_13 = getvisiblekillstreakavailable(var_12.streakname);

      switch (var_13) {
        case 1:
          var_8 = var_12.streaklifeid == self.lifeid;
          break;
        case 2:
          var_9 = var_12.streaklifeid == self.lifeid;
          break;
        default:
          break;
      }
    }

    if(var_8 && var_9)
      scripts\cp_mp\pet_watch::battle_tracks_getplayerdataenum();
    else
      scripts\cp_mp\pet_watch::battle_tracks_getnewtogglestate();
  }
}

ammobox_getbufferedattachment(var_0, var_1) {
  if(var_0 > removeincoming()) {
    return;
  }
  self setclientkillstreakavailability(var_0, var_1);
}

ammobox_clearbufferedattachmentweapon(var_0, var_1) {
  if(var_0 > removeincoming()) {
    return;
  }
  self setpowerammo(var_0, var_1);
}

givekillstreak(var_0, var_1, var_2) {
  awardkillstreak(var_0, "_encstr_8261067B1D34AC27");
}

calcstreakcost(var_0) {
  var_1 = int(scripts\mp\utility\killstreak::getkillstreakkills(var_0));

  if(isDefined(self) && isPlayer(self))
    var_1 = var_1 + getperkadjustedkillstreakcost(var_0, var_1);

  var_1 = int(clamp(var_1, 0, 7000));
  return var_1;
}

getperkadjustedkillstreakcost(var_0, var_1) {
  var_2 = 0;

  if(scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E")) {
    var_3 = scripts\mp\utility\killstreak::getkillstreakindex(var_0);
    var_2 = 175 * var_3;
  }

  if(scripts\mp\utility\perk::_hasperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F") && var_1 > 0 && var_0 != "_encstr_B8BA05F06B9785") {
    if(scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"))
      var_2 = var_2 - 125;
    else
      var_2--;
  }

  return var_2;
}

killstreakselectionwatcher() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AD("_encstr_8DDC0D5B37EBCD951B59D88EAF5DE0", "_encstr_A7FE0F1B5A28331AE820CBC3F76BB0BCFE");

    if(!scripts\engine\utility::is_player_gamepad_enabled()) {
      continue;
    }
    if(!istrue(self.iscarrying)) {
      var_1 = getselectedkillstreakindex();

      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = var_1;

      if(var_0 == "_encstr_8DDC0D5B37EBCD951B59D88EAF5DE0")
        var_2 = getnextselectablekillstreakslot(var_1);
      else if(var_0 == "_encstr_A7FE0F1B5A28331AE820CBC3F76BB0BCFE")
        var_2 = getpreviousselectablekillstreakslot(var_1);
      else {}

      setselectedkillstreak(var_2);
    }
  }
}

selectfirstavailablekillstreak() {
  var_0 = getplayerstreakdata();

  if(isDefined(var_0.streaks[0])) {
    if(var_0.streaks[0].available == 1) {
      setselectedkillstreak(0);
      return;
    }
  } else {
    for(var_1 = removeincoming(); var_1 >= 0; var_1--) {
      var_2 = var_0.streaks[var_1];

      if(isDefined(var_2) && var_2.available == 1) {
        setselectedkillstreak(var_1);
        return;
      }
    }
  }

  clearkillstreakselection();
}

getnextselectablekillstreakslot(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::ter_op(var_0 >= removeincoming(), 0, var_0 + 1);
  var_3 = var_0;
  var_4 = var_2;

  while(var_4 != var_3) {
    var_5 = self.streakdata.streaks[var_4];

    if(isDefined(var_5) && var_5.available == 1) {
      var_1 = var_4;
      break;
    }

    var_4++;

    if(var_4 > removeincoming())
      var_4 = 0;
  }

  return var_1;
}

getpreviousselectablekillstreakslot(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::ter_op(var_0 <= 0, removeincoming(), var_0 - 1);
  var_3 = var_0;
  var_4 = var_2;

  while(var_4 != var_3) {
    var_5 = self.streakdata.streaks[var_4];

    if(isDefined(var_5) && var_5.available == 1) {
      var_1 = var_4;
      break;
    }

    var_4--;

    if(var_4 < 0)
      var_4 = removeincoming();
  }

  return var_1;
}

selectmostexpensivekillstreak() {
  var_0 = undefined;
  var_1 = -1;

  for(var_2 = removeincoming(); var_2 >= 0; var_2--) {
    var_3 = self.streakdata.streaks[var_2];

    if(isDefined(var_3) && var_3.available == 1) {
      if(var_3.currentcost > var_1) {
        var_0 = var_2;
        var_1 = var_3.currentcost;
      }
    }
  }

  if(!isDefined(var_0)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(var_0);
}

selectnextavailablekillstreak() {
  var_0 = undefined;
  var_1 = -1;

  for(var_2 = 0; var_2 <= removeincoming(); var_2++) {
    var_3 = self.streakdata.streaks[var_2];

    if(isDefined(var_3) && var_3.available == 1) {
      if(istrue(var_3.isgimme)) {
        var_0 = var_2;
        break;
      } else if(var_3.currentcost > var_1) {
        var_0 = var_2;
        var_1 = var_3.currentcost;
      }
    }
  }

  if(!isDefined(var_0)) {
    clearkillstreakselection();
    return;
  }

  setselectedkillstreak(var_0);
}

setselectedkillstreak(var_0) {
  if(var_0 != 0 && istrue(self.loadoutusingspecialist)) {
    return;
  }
  var_1 = getkillstreakinslot(var_0);
  self.currentselectedkillstreakslot = var_0;
  updatekillstreakselectedui();

  if(scripts\mp\utility\game::unset_relic_grounded()) {
    var_2 = game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].tabledatabyref[var_1.streakname]["_encstr_825208061DE7FBB08DAB"];
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_ABB312D50723C247B21393B23CD1938523161D16("_encstr_A9B31537CAB1B21B8EB223B45AD8B1DC4739560BB6528C", var_2);
  }
}

clearkillstreakselection() {
  self.currentselectedkillstreakslot = undefined;
  updatekillstreakselectedui();

  if(scripts\mp\utility\game::unset_relic_grounded())
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_ABB312D50723C247B21393B23CD1938523161D16("_encstr_A9B31537CAB1B21B8EB223B45AD8B1DC4739560BB6528C", 0);
}

getselectedkillstreak() {
  var_0 = getselectedkillstreakindex();

  if(!isDefined(var_0))
    return undefined;

  return self.streakdata.streaks[var_0];
}

getselectedkillstreakindex() {
  return self.currentselectedkillstreakslot;
}

getkillstreakinslot(var_0) {
  return self.streakdata.streaks[var_0];
}

getequippedkillstreakbyname(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0)
      return var_2;
  }

  return undefined;
}

getequippedkillstreakslotbyname(var_0) {
  for(var_1 = 1; var_1 <= 3; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0)
      return var_1;
  }

  return undefined;
}

getvisiblekillstreakavailable(var_0) {
  for(var_1 = 0; var_1 <= removeincoming(); var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0 && var_2.available == 1)
      return var_1;
  }

  return undefined;
}

getkillstreakvisibleslotbyname(var_0) {
  for(var_1 = 0; var_1 <= removeincoming(); var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && var_2.streakname == var_0)
      return var_1;
  }

  return undefined;
}

getgimmeslotkillstreakstructs() {
  var_0 = [];
  var_1 = getkillstreakinslot(0);

  if(isDefined(var_1)) {
    var_0[0] = var_1;

    for(var_2 = 5; var_2 < 37; var_2++) {
      var_3 = self.streakdata.streaks[var_2];

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
        continue;
      }

      break;
    }
  }

  return var_0;
}

getavailableequippedkillstreakstructs() {
  var_0 = [];

  if(self.streakdata.streaks.size > 0) {
    for(var_1 = 1; var_1 < 4; var_1++) {
      var_2 = self.streakdata.streaks[var_1];

      if(isDefined(var_2) && isDefined(var_2.streakname) && var_2.available == 1)
        var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

getallavailablekillstreakstructs() {
  var_0 = [];

  if(self.streakdata.streaks.size > 0) {
    for(var_1 = 0; var_1 < removeincoming(); var_1++) {
      var_2 = self.streakdata.streaks[var_1];

      if(isDefined(var_2) && isDefined(var_2.streakname) && var_2.available == 1)
        var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

registerkillstreak(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.killstreaksetups))
    level.killstreaksetups = [];

  var_4 = spawnStruct();
  level.killstreaksetups[var_0] = var_4;
  var_4.triggeredfunc = var_1;
  var_4.availablefunc = var_2;
  var_4.linkedtotag = var_3;
}

getkillstreaksetupinfo(var_0) {
  var_1 = level.killstreaksetups[var_0];
  return var_1;
}

checkstreakreward(var_0, var_1) {
  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_3 = getkillstreakinslot(var_2);

    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3.currentcost;

    if(self.previousstreakpoints >= var_4 || var_0 < var_4) {
      continue;
    }
    if(scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E") && istrue(var_3.earned)) {
      continue;
    }
    if(istrue(level.casualscorestreaks) && istrue(var_1)) {
      continue;
    }
    if(isDefined(var_3.lifeid) && var_3.lifeid == self.lifeid && (!istrue(level._id_145EC) || istrue(level._id_145EC) && self.streaktype == "_encstr_BAAE0B0FF9C056F999C9F4D008") || istrue(level._id_145EC) && istrue(level.casualscorestreaks) && self.streaktype != "_encstr_BAAE0B0FF9C056F999C9F4D008" && var_3.available == -1) {
      continue;
    }
    earnkillstreak(var_2, var_4);
  }
}

arekillstreaksequipped(var_0) {
  var_1 = getplayerstreakdata();

  if(!isDefined(var_1) || !isDefined(var_1.streaks))
    return 0;

  foreach(var_3 in var_0) {
    var_4 = 0;

    for(var_5 = 1; var_5 <= 4; var_5++) {
      var_6 = var_1.streaks[var_5];

      if(isDefined(var_6)) {
        if(isDefined(var_6.streakname) && var_6.streakname == var_3) {
          if(var_6.isspecialist) {
            var_7 = scripts\mp\perks\perks::getspecialistperkforstreak(var_3);

            if(var_6._id_136D2 == var_7) {
              var_4 = 1;
              break;
            }
          } else {
            var_4 = 1;
            break;
          }
        }

        continue;
      }

      if(var_3 == "_encstr_8BBA05185F8B99") {
        var_4 = 1;
        break;
      }
    }

    if(!var_4)
      return 0;
  }

  return 1;
}

findkillstreakslotnumber(var_0) {
  for(var_1 = 0; var_1 <= 37; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(!isDefined(var_2)) {
      if(var_1 >= 5) {
        break;
      }
    } else if(var_0 == var_2)
      return var_1;
  }

  return undefined;
}

streakglobals_onkillstreaktriggered(var_0) {
  if(isDefined(var_0.mpstreaksysteminfo)) {
    var_1 = onkillstreaktriggered(var_0);

    if(!var_1)
      return 0;
  }

  return 1;
}

streakglobals_onkillstreakbeginuse(var_0) {
  var_1 = var_0.owner;

  if(isDefined(var_0.mpstreaksysteminfo)) {
    var_2 = onkillstreakbeginuse(var_0);

    if(!var_2)
      return 0;
  }

  if(isDefined(var_1)) {
    if(level.codcasterenabled) {
      if(iskillstreakvisibleforcodcaster(var_0.streakname))
        var_1 setnoteworthykillstreakactive(1);
    }

    if(scripts\mp\utility\game::ismlgmatch()) {
      var_3 = int(tablelookup("_encstr_AB7A17451FC08F44C1703B43683BBE77430FD2CC3DB8E78AAD", 1, var_0.streakname, 4));

      if(var_3 >= 1000) {
        var_4 = tablelookup("_encstr_AB7A17451FC08F44C1703B43683BBE77430FD2CC3DB8E78AAD", 1, var_0.streakname, 0);

        if(var_4 != "_encstr_B40101")
          var_5 = int(var_4);
      }
    }
  }

  return 1;
}

streakglobals_onkillstreakfinishuse(var_0) {
  var_1 = var_0.owner;
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = var_1 scripts\mp\utility\killstreak::hasplayerdiedwhileusingkillstreak(var_0);

  if(isDefined(var_0.mpstreaksysteminfo))
    onkillstreakfinishuse(var_0, var_2);

  if(isDefined(var_1)) {
    if(!var_2)
      var_1 notify("_encstr_ACCB18D6968D63373AC95916DAEBEA9BB2F533D2DC5ADCA1AC91");

    if(level.codcasterenabled)
      var_1 setnoteworthykillstreakactive(0);
  }
}

givestreakpoints(var_0, var_1, var_2) {
  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"), var_2, var_1);

  if(!isDefined(var_3))
    var_3 = scripts\mp\rank::getscoreinfovalue(var_0);

  if(var_3 == 0) {
    return;
  }
  self.pers["_encstr_A5E41897E78271D024CAF149B42CF826AA175D0317ABC63849E4"] = undefined;
  self.pers["_encstr_AB321F6717728120B45A61F904BC88563AA7CDF3871B56A8F9742E50AC762BE322"] = undefined;
  var_4 = self.streakpoints + var_3;
  var_5 = findmaxstreakcost();

  if(var_4 > var_5)
    var_4 = var_5;

  var_6 = var_0 == "_encstr_ABD70578F3D02C";

  if(var_6 && !istrue(level.loadout_updateclassdefault_weapons) && (istrue(level.allowkillstreaks) || isDefined(level._id_12305))) {
    var_7 = self.nukepoints + var_1;
    var_8 = calcstreakcost("_encstr_B8BA05F06B9785");

    if(isDefined(level._id_12305))
      var_8 = level._id_12305;

    if(var_7 >= var_8) {
      self.nukepoints = var_8;

      if(!istrue(self.molotov_delete_scriptable)) {
        thread scripts\mp\hud_message::showkillstreaksplash("_encstr_B8BA05F06B9785", var_8);
        awardkillstreak("_encstr_B8BA05F06B9785", "_encstr_BEBD07C1360273C53A");
        self.molotov_delete_scriptable = 1;
      }
    } else {
      self.nukepoints = var_7;

      if(isDefined(self.petwatch))
        scripts\cp_mp\pet_watch::_id_13FFD(self.nukepoints / var_8);
    }
  }

  setstreakpoints(var_4);
  checkstreakreward(var_4);
  updatestreakmeterui();

  if(istrue(level._id_145EC && self.streaktype != "_encstr_BAAE0B0FF9C056F999C9F4D008")) {
    if(var_4 >= var_5) {
      var_4 = var_4 - var_5;
      setstreakpoints(var_4);
      self setkillstreakpoints(var_4);
      setstreakcounttonext();
      resetstreakavailability();
    }
  }

  scripts\mp\analyticslog::logevent_reportstreakscore(var_3, gettime(), scripts\mp\rank::getscoreinfocategory(var_0, "_encstr_AA5B08F5B421339B1359"));
}

isbountyevent(var_0) {
  return var_0 == "_encstr_B64C0742801D38E33F";
}

iskillstreakkillevent(var_0) {
  return issubstr(var_0, "_encstr_9B1208E286FFF221C030") || var_0 == "_encstr_8118166DACE9731F4B4EB9899079D75399A2AE3F5F28166F";
}

resetstreakpoints() {
  self.earnedstreaklevel = 0;
  self.nukepoints = 0;
  setstreakpoints(0);
  resetstreakcount();
  updatestreakmeterui();
}

resetstreakavailability(var_0) {
  if(!isDefined(self)) {
    return;
  }
  for(var_1 = 0; var_1 <= 4; var_1++) {
    var_2 = self.streakdata.streaks[var_1];

    if(isDefined(var_2) && isDefined(var_2.streakname)) {
      if(istrue(var_0))
        var_2.available = 0;
      else if(istrue(var_2.isspecialist))
        var_2.available = 0;
      else if(var_2.available == -1)
        var_2.available = 0;

      ammobox_clearbufferedattachmentweapon(var_1, var_2.available);
    }
  }
}

_id_13DB8() {
  for(var_0 = 1; var_0 <= 4; var_0++) {
    var_1 = self.streakdata.streaks[var_0];

    if(isDefined(var_1) && istrue(var_1.available)) {
      var_2 = var_1.streaksetupinfo;

      if(isDefined(var_2.availablefunc))
        self[[var_2.availablefunc]](var_1);
    }
  }
}

setstreakpoints(var_0) {
  if(var_0 < 0)
    var_0 = 0;

  if(isDefined(self.streakpoints))
    self.previousstreakpoints = self.streakpoints;
  else
    self.previousstreakpoints = 0;

  self.streakpoints = var_0;
  updatestreakcount();
}

storescorestreakpointsongameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(level.roundretainstreakprog) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = 0;

      if(isDefined(var_1.streakpoints)) {
        if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"))
          var_2 = scripts\mp\perks\perkfunctions::vote_player_set(var_1.streakpoints);
        else
          var_2 = var_1.streakpoints;
      }

      var_1.pers["_encstr_819A0D6335439F5ED779027A903112"] = var_2;
    }
  }
}

findunobstructedfiringpointaroundz(var_0, var_1, var_2, var_3) {
  var_4 = rotatevector((0, 0, 1), (-1 * var_3, 0, 0));
  var_5 = vectortoangles(var_1 - var_0.origin);

  for(var_6 = 0; var_6 < 360; var_6 = var_6 + 30) {
    var_7 = var_2 * rotatevector(var_4, (0, var_6 + var_5[1], 0));
    var_8 = var_1 + var_7;

    if(_findunobstructedfiringpointhelper(var_0, var_8, var_1))
      return var_8;
  }

  return undefined;
}

findunobstructedfiringpointaroundy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_0.origin - var_1);

  for(var_7 = var_3; var_7 <= var_4; var_7 = var_7 + var_5) {
    var_8 = rotatevector((1, 0, 0), (var_7 - 90, 0, 0));
    var_9 = var_2 * rotatevector(var_8, (0, var_6[1], 0));
    var_10 = var_1 + var_9;

    if(_findunobstructedfiringpointhelper(var_0, var_10, var_1))
      return var_10;
  }

  return undefined;
}

_findunobstructedfiringpointhelper(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::_bullet_trace(var_1, var_2, 0);

  if(var_3["_encstr_A53009A25003666B9818C6"] > 0.99)
    return 1;

  return 0;
}

findunobstructedfiringpoint(var_0, var_1, var_2) {
  var_3 = findunobstructedfiringpointaroundz(var_0, var_1, var_2, 30);

  if(!isDefined(var_3))
    var_3 = findunobstructedfiringpointaroundy(var_0, var_1, var_2, 15, 75, 15);

  return var_3;
}

killstreakhit(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_2.owner)) {
      var_2 _id_14018(var_0, var_4);

      if(scripts\mp\utility\weapon::iskillstreakweapon(var_1.basename)) {
        return;
      }
      var_5 = createheadicon(var_1);

      if(!isDefined(var_0.lasthittime[var_5]))
        var_0.lasthittime[var_5] = 0;

      if(var_0.lasthittime[var_5] == gettime()) {
        return;
      }
      var_0.lasthittime[var_5] = gettime();
      var_0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_5, 1, "_encstr_88CC0521F3A13B");

      if(scripts\mp\utility\game::onlinestatsenabled()) {
        var_6 = var_0 scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_972C0B3AF63A8563A6D07B3ADC");
        var_7 = var_0 scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B") + 1;

        if(var_7 <= var_6) {
          var_0 scripts\mp\playerstats_interface::setplayerstatbuffered(var_7, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
          var_0 scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_6 - var_7), "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
        }
      }

      if(isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3) || scripts\mp\utility\damage::isprojectiledamage(var_3)) {
        var_0.lastdamagetime = gettime();
        var_8 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);

        if(var_8 == "_encstr_A3710BEEACC2E0B737EB36B676") {
          if(!isDefined(var_0.shotslandedlmg))
            var_0.shotslandedlmg = 1;
          else
            var_0.shotslandedlmg++;
        }
      }
    }
  }
}

_id_14019(var_0) {
  _id_14018(var_0, 150);
}

_id_14018(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_12F3C))
    self._id_12F3C = [];

  var_2 = var_0 getxuid();
  var_0.shoulddeleteimmediately = 1;

  if(!isDefined(self._id_12F3C[var_2])) {
    var_3 = spawnStruct();
    var_3.damage = 0;
    var_3.player = var_0;
    self._id_12F3C[var_2] = var_3;
  }

  self._id_12F3C[var_2].damage = self._id_12F3C[var_2].damage + var_1;
}

rocket_internal(var_0) {
  if(!isDefined(self._id_12F3C))
    return [];

  var_1 = [];

  foreach(var_3 in self._id_12F3C) {
    var_4 = var_3.damage;
    var_5 = var_3.player;

    if(var_4 < 150) {
      continue;
    }
    var_6 = !scripts\mp\utility\player::isfriendly(self.team, var_5);
    var_7 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_5, self.owner));

    if(!var_6 && !var_7) {
      continue;
    }
    if(isDefined(var_0) && var_5 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

givescoreforequipment(var_0, var_1) {
  if(isDefined(var_1) && weaponclass(var_1) != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && var_1.basename != "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA")
    var_1 = undefined;

  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029", var_1);
  scripts\cp_mp\gestures::processcalloutdeath(var_0, self);
}

givescorefordestroyedtacinsert() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B27C15E279237C524FC3AD6DC94383ABB642204BAF150B");
}

givescorefortrophyblocks() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_97D60FBBB3BD77A010294930AD97CD1A85");
}

givescoreforblackhat() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BABF0EC4B1581B6D860B1D7D340BC6D6");
}

givescoreforhack() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_95CC050D168DDA");
}

givescoreforempedvehicle() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_88280E59EDA920A5A73BFD69437F609A");
}

givescoreforempedkillstreak() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A3AB110D99B812F1C1DA97D8E2862B8D38A707");
}

givescoreforempedplayer() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_84BE0DF00AC22B699780C14F718753");
}

givescoreformarktarget(var_0) {
  if(var_0)
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BA19138047050C36433A8BAAC51409A3D8421FD773");
  else
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BA19138047050C36433A8BAAC51409A3D8421FD773", undefined, 0);
}

givescorefordestorymarkedtarget() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B49E16F797EB1F2EA42F28086BF7A24B32B16DF7AA52DB73");
}

givescoreforassistdestroymarkedtarget() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B49E16F797EB1F2EA42F28086BF7A24B32B16DF7AA52DB73");
}

givescorefortriggeredalarmeddoor() {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A2B3108E93D23B9DAC27598CEB851B0B27B6");
}

streaktyperesetsondeath(var_0) {
  switch (var_0) {
    case "_encstr_AB3508737F830710ACDB":
    case "_encstr_BAAE0B0FF9C056F999C9F4D008":
      return 1;
    case "_encstr_9A040910D25A57235BFB2D":
    case "_encstr_B29108FB78F3394A7385":
      return 0;
    default:
      return 1;
  }
}

initridekillstreak(var_0) {
  scripts\common\utility::allow_usability(0);
  var_1 = initridekillstreak_internal(var_0);

  if(isDefined(self))
    scripts\common\utility::allow_usability(1);

  return var_1;
}

initridekillstreak_internal(var_0) {
  if(isDefined(var_0) && islaptoptimeoutkillstreak(var_0))
    var_1 = "_encstr_995408F398012F656821";
  else
    var_1 = scripts\engine\utility::_id_143BB(1.0, "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 == "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC")
    return "_encstr_BD79059C51C351";

  if(!isalive(self))
    return "_encstr_BD79059C51C351";

  if(var_1 == "_encstr_8D820B49520F0EC02DDE6367EC" || var_1 == "_encstr_AD75063D571AE108") {
    if(var_1 == "_encstr_8D820B49520F0EC02DDE6367EC")
      return "_encstr_8D820B49520F0EC02DDE6367EC";

    if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      return "_encstr_BD79059C51C351";

    return "_encstr_88E30897BDF1B71F7823";
  }

  if(scripts\mp\utility\game::iskillstreakdenied())
    return "_encstr_BD79059C51C351";

  if(!isDefined(var_0) || !issubstr(var_0, "_encstr_84FE0C70AF38EDABD6294AC2F19D")) {
    if(var_0 == "_encstr_AAFC0BF2206F353F4EABF1E635") {
      self visionsetfadetoblackforplayer("_encstr_8A8C09A5D372D6302FEE93", 0);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("_encstr_8A8C09A5D372D6302FEE93", 0, 1.0, undefined, 1);
      var_2 = scripts\engine\utility::_id_143B9(0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    } else {
      self visionsetfadetoblackforplayer("_encstr_8A8C09A5D372D6302FEE93", 0.75);
      thread scripts\mp\utility\player::set_visionset_for_watching_players("_encstr_8A8C09A5D372D6302FEE93", 0.75, 1.0, undefined, 1);
      var_2 = scripts\engine\utility::_id_143B9(0.8, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    }
  } else
    var_2 = scripts\engine\utility::_id_143B9(1.0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  self notify("_encstr_81B50F9639D32273F658FFE3C1C93FBAA3");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 != "_encstr_8D820B49520F0EC02DDE6367EC") {
    if(!isDefined(var_0) || !issubstr(var_0, "_encstr_84FE0C70AF38EDABD6294AC2F19D"))
      thread clearrideintro(1.0);
    else
      self notify("_encstr_BEFD0E1BA6DB5008C78220098A5B3558");

    if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      return "_encstr_BD79059C51C351";
  }

  if(self isonladder())
    return "_encstr_BD79059C51C351";

  if(!isalive(self))
    return "_encstr_BD79059C51C351";

  if(scripts\mp\utility\game::iskillstreakdenied())
    return "_encstr_BD79059C51C351";

  if(var_2 == "_encstr_8D820B49520F0EC02DDE6367EC")
    return "_encstr_8D820B49520F0EC02DDE6367EC";
  else
    return "_encstr_88E30897BDF1B71F7823";
}

islaptoptimeoutkillstreak(var_0) {
  switch (var_0) {
    case "_encstr_A3AC0C1A9D50B2D162C0E3B0C28A":
    case "_encstr_A54E0BF3EA0FB710F7F74B5BE6":
    case "_encstr_8EBA0EF6DC0E279597FAB3BA9B3756C9":
    case "_encstr_84FE0C70AF38EDABD6294AC2F19D":
    case "_encstr_AAFC0BF2206F353F4EABF1E635":
    case "_encstr_9B100BD059D8A5D7C1B4C6B7D1":
    case "_encstr_86FD08B775CD07DC1338":
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      return 1;
  }

  return 0;
}

clearrideintro(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    wait(var_0);

  if(!isDefined(var_1))
    var_1 = 0;

  self visionsetfadetoblackforplayer("_encstr_B40101", var_1);
  scripts\mp\utility\player::set_visionset_for_watching_players("_encstr_B40101", var_1);
  self notify("_encstr_BEFD0E1BA6DB5008C78220098A5B3558");
}

allowridekillstreakplayerexit(var_0, var_1) {
  if(isDefined(var_0))
    self endon(var_0);

  if(!isDefined(self.owner)) {
    return;
  }
  var_2 = self.owner;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 endon("_encstr_920E0BE7880931BA61B86733C0");
  self endon("_encstr_AD75063D571AE108");
  var_3 = 0.75;

  if(isDefined(var_1))
    var_3 = var_1;

  var_4 = level.framedurationseconds;
  var_5 = 1;

  for(;;) {
    var_6 = 0;

    if(var_5 == 1) {
      var_2 setclientomnvar("_encstr_AF5311AE4BF5ACF0D2D1FA0727F6B327ACCD9B", 0);
      var_5 = 0;
    }

    while(var_2 useButtonPressed()) {
      var_6 = var_6 + var_4;
      var_5 = 1;
      var_2 setclientomnvar("_encstr_AF5311AE4BF5ACF0D2D1FA0727F6B327ACCD9B", var_6 / var_3);

      if(var_6 > var_3) {
        self notify("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
        return;
      }

      wait(var_4);
    }

    wait(var_4);
  }
}

combatrecordkillstreakuse(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    if(var_0 != "_encstr_B8BA05F06B9785" && var_0 != "_encstr_8F770E0752D834A2F69B9BAF8F16EA67") {}

    return;
  }

  var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_A5E405AB8F12FE");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_A5E405AB8F12FE", var_2 + 1);
}

checkcasualstreaksreset() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.streaktype) && self.streaktype == "_encstr_BAAE0B0FF9C056F999C9F4D008" || isDefined(self.loadoutstreaktype) && self.loadoutstreaktype == "_encstr_BAAE0B0FF9C056F999C9F4D008" || !istrue(level._id_145EC)) {
    var_0 = self.streakdata.streaks[self.streakdata.streaks.size];

    if(var_0.available == 1 || var_0.available == -1)
      return 1;
  }

  return 0;
}

loadassociatedkillstreakweapons(var_0) {
  var_1 = [];
  var_2 = scripts\cp_mp\utility\killstreak_utility::getkillstreakdeployweapon(var_0);
  var_1[var_1.size] = var_2;
  var_3 = scripts\cp_mp\utility\killstreak_utility::getkillstreakgameweapons(var_0);
  var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  self loadweaponsforplayer(var_1, 1);
}

combatrecordincrementkillstreakawardedstat(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_A6400D11E321D0751AC3DFBFBF9245");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_A6400D11E321D0751AC3DFBFBF9245", var_2 + 1);
}

hide_player_clip(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_99D60BC5B8554096E7F459CC2F");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_99D60BC5B8554096E7F459CC2F", var_2 + 1);
}