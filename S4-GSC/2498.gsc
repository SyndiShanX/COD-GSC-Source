/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2498.gsc
*************************************************/

_id_6B2D() {
  if(!isDefined(level.mapname)) {
    level.mapname = getDvar("#x376847958d67972ef");
  }

  return level.mapname;
}

_id_C26B() {
  level._id_8EE1 = 1;
}

_id_88FE() {
  return istrue(level._id_8EE1);
}

_id_88FD() {
  return level.gametype == "br" && _id_88FE();
}

_id_C27A() {
  level._id_A4EB = 1;
  _func_03DE("killcam_night");
}

isnightmap() {
  return istrue(level._id_A4EB);
}

_id_C27B() {
  level._id_A5AF = 1;
}

_id_894E() {
  return istrue(level._id_A5AF);
}

_id_C23F() {
  level._id_1ABD = 1;
  level._id_4AE7 = 1;
  level._id_DDAF = 1;
  level._id_C58A = 0;
}

_id_C2B4() {
  level._id_4AE7 = 1;
  level._id_DDAF = 1;
}

_id_875F() {
  return istrue(level._id_1ABD);
}

shouldadjustspawnsforsmallmap() {
  var_0 = _id_6B2D();

  if(!isDefined(var_0)) {
    return 0;
  }

  if((issubstr(var_0, "shipment") || var_0 == "mp_shipmas_s4") && getdvarint("#x3fae2f895404566b9", 0)) {
    return 1;
  } else if(var_0 == "mp_dome2" && getdvarint("#x3294a265c9322edbc", 0)) {
    return 1;
  } else if(var_0 == "mp_whitehouse_2" && getdvarint("#x331f1740a4ba36688", 0)) {
    return 1;
  } else {
    return 0;
  }
}

_id_DBD7() {
  return istrue(level._id_DDAF);
}

_id_6B18() {
  if(!isDefined(level._id_96CC)) {
    var_0 = getdvarint("#x32a031d1e6464bda2", 0);

    if(var_0 > 0) {
      level._id_96CC = "locale_" + var_0;
    } else if(var_0 == 0) {
      level._id_96CC = undefined;
    } else {
      switch (_id_6B2D()) {
        case "mp_quarry2":
          level._id_96CC = "locale_5";
          break;
        case "mp_donetsk":
          level._id_96CC = "locale_6";
          break;
        case "mp_downtown_gw":
          level._id_96CC = "locale_6";
          break;
        case "mp_farms2_gw":
          level._id_96CC = "locale_9";
          break;
        case "mp_aniyah":
          level._id_96CC = "locale_17";
          break;
      }
    }
  }

  return level._id_96CC;
}

_id_6B17(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = undefined;

  if(isDefined(var_2) && var_2.size == 1) {
    return var_2[0];
  }

  if(isDefined(_id_6B18())) {
    foreach(var_5 in var_2) {
      if(isDefined(var_5._id_039B) && var_5._id_039B == level._id_96CC) {
        var_3 = var_5;
        continue;
      }

      if(level.mapname == "mp_port2_gw" && var_0 == "airstrikeheight") {
        if(var_5.origin == (34880, -26944, 3072)) {
          var_3 = var_5;
        }

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

  if(isDefined(var_3)) {
    return var_3;
  }

  if(istrue(var_1)) {
    return;
  }
}

_id_6B19(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0, "targetname");
  var_3 = undefined;

  if(isDefined(_id_6B18())) {
    foreach(var_5 in var_2) {
      if(isDefined(var_5._id_039B) && var_5._id_039B == level._id_96CC) {
        var_3 = var_5;
      }
    }
  } else {
    foreach(var_5 in var_2) {
      if(!isDefined(var_3)) {
        var_3 = var_5;
        break;
      }
    }
  }

  if(isDefined(var_3)) {
    return var_3;
  }

  if(istrue(var_1)) {
    return;
  }
}

_id_6B1A(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0, "targetname");
  var_3 = [];

  if(isDefined(_id_6B18())) {
    foreach(var_5 in var_2) {
      if(_id_6B2D() == "mp_quarry2") {
        var_3[var_3.size] = var_5;
        continue;
      }

      if(isDefined(var_5._id_039B) && var_5._id_039B == level._id_96CC) {
        var_3[var_3.size] = var_5;
      }
    }

    return var_3;
  }

  if(var_2.size == 0) {
    if(istrue(var_1)) {}
  } else {}
}

_id_89EC() {
  if(istrue(level._id_ED2B) || istrue(self._id_89EC)) {
    return 1;
  }

  return 0;
}

_id_58C7(var_0, var_1, var_2, var_3) {
  var_0 notify("start_fade_to_black");
  var_0 endon("start_fade_to_black");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_4 = 0;

  if(istrue(var_1)) {
    var_4 = 1;
  }

  if(isDefined(var_3)) {
    wait(var_3);
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2) || var_2 == 0) {
    var_0 setclientomnvar("ui_total_fade", var_4);
    return;
  }

  var_4 = 0;
  var_5 = int(var_2 / level._id_5F3A);
  var_6 = 1 / var_5;

  if(!istrue(var_1)) {
    var_6 = var_6 * -1;
    var_4 = 1;
  }

  while(var_5 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    var_4 = var_4 + var_6;
    var_0 setclientomnvar("ui_total_fade", var_4);
    var_5--;
    waitframe();
  }
}

_id_6DEB() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "getTimeSinceGameStart")]]();
}

_id_E6DE() {
  if(isbot(self) || _func_0458(self)) {
    return;
  }
  if(isDefined(self.reportchallengeuserevent_done)) {
    return;
  }
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  var_0 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
    var_0 = _id_6956(var_1);
  }

  self reportchallengeuserevent("144115188075855893", []);
  self.reportchallengeuserevent_done = 0;
}

_id_E912(var_0) {
  if(isbot(self)) {
    return;
  }
  if(istrue(self.reportchallengeuserevent_done)) {
    return;
  }
  if(!istrue(level.playerxpenabled)) {
    return;
  }
  var_1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
    var_1 = _id_6956(var_2);
  }

  var_3 = 0;

  if(isDefined(var_0)) {
    if(level.teambased) {
      if(var_0 == "tie") {
        var_3 = 3;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == var_0) {
        var_3 = 1;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] != var_0) {
        var_3 = 2;
      }
    } else if(isDefined(self._id_3B82))
      var_3 = 0;
    else if(!isDefined(self._id_F242) || self._id_F242["total"] < 1 || self.pers["participation"] < 1) {
      var_3 = 0;
    } else if(!istrue(self.pers["hasDoneAnyCombat"])) {
      var_3 = 0;
    } else if(!isDefined(level._id_B16C)) {
      var_3 = 0;
    } else {
      var_4 = 0;

      for(var_5 = 0; var_5 < min(level._id_B16C["all"].size, 3); var_5++) {
        if(level._id_B16C["all"][var_5] != self) {
          continue;
        }
        var_4 = 1;
      }

      if(var_4) {
        var_3 = 1;
      } else {
        var_3 = 2;
      }
    }
  }

  var_6 = 0;
  var_7 = 0;

  if(isDefined(self.pers["scavengerPickedUp"])) {
    var_7 = self.pers["scavengerPickedUp"];
  }

  var_8 = 0;

  if(isDefined(self.pers["restockCount"])) {
    var_8 = self.pers["restockCount"];
  }

  var_9 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    var_9[0] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team);
  } else {
    var_9[0] = "";
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupOtherOperator")) {
    var_9[1] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupOtherOperator")]](self.team);
  } else {
    var_9[1] = "";
  }

  if(istrue(level.ismp)) {
    self reportchallengeuserevent("144115188075856031", []);
  } else {
    if(isDefined(var_0) && var_0 == "SUCCESS") {
      var_3 = 1;
    } else {
      var_3 = 2;
    }

    self reportchallengeuserevent("144115188075856031", []);
  }

  self.reportchallengeuserevent_done = 1;
}

_id_0DC3(var_0, var_1) {
  if(var_0 == "") {
    self visionsetnakedforplayer(var_0, var_1);

    if(isDefined(self._id_0F68)) {
      self._id_0F68 = undefined;
    }

    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(self._id_0F68)) {
    self._id_0F68 = [];
  }

  if(!isDefined(self._id_0F68[var_0])) {
    self._id_0F68[var_0] = 1;
  } else {
    self._id_0F68[var_0]++;
  }

  if(self._id_0F68[var_0] == 1) {
    self visionsetnakedforplayer(var_0, var_1);
  }
}

_id_0DC4(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self._id_0F68[var_0]--;

  if(self._id_0F68[var_0] == 0) {
    var_1 = [];

    foreach(var_4, var_3 in self._id_0F68) {
      if(var_4 == var_0) {
        continue;
      }
      var_1[var_4] = var_3;
    }

    self._id_0F68 = var_1;
    self visionsetnakedforplayer("", 0);

    foreach(var_4, var_3 in var_1) {
      self visionsetnakedforplayer(var_4, level._id_5F3A);
    }
  }
}

_id_C4E9(var_0, var_1) {
  var_2 = getEntArray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.model) && var_4.model == var_0) {
      if(istrue(var_1) && isDefined(var_4.target)) {
        _id_C4E8(var_4.target, "targetname");
      }

      var_4 delete();
    }
  }
}

_id_C4E7(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_00EC) && var_3._id_00EC == var_0) {
      var_3 delete();
    }
  }
}

_id_C4E6(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.classname) && var_3.classname == var_0) {
      var_3 delete();
    }
  }
}

_id_C4E8(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_4 delete();
  }
}

_id_815E() {
  var_0 = spawnStruct();
  level._id_33AE = var_0;
  var_0._id_60B1 = [];
  var_0._id_60B1["dm"] = 6;
  var_0._id_60B1["war"] = 7;
  var_0._id_60B1["sd"] = 8;
  var_0._id_60B1["dom"] = 9;
  var_0._id_60B1["conf"] = 10;
  var_0._id_60B1["sr"] = 11;
  var_0._id_60B1["grind"] = 12;
  var_0._id_60B1["ball"] = 13;
  var_0._id_60B1["infect"] = 14;
  var_0._id_60B1["tjugg"] = 15;
  var_0._id_60B1["gun"] = 16;
  var_0._id_60B1["grnd"] = 17;
  var_0._id_60B1["siege"] = 18;
  var_0._id_60B1["koth"] = 19;
  var_0._id_60B1["ctf"] = 20;
  var_0._id_60B1["dd"] = 21;
  var_0._id_60B1["tdef"] = 22;
  var_0._id_60B1["front"] = 23;
  var_0._id_60B1["cmd"] = 24;
  var_0._id_60B1["br"] = 25;
  var_0._id_60B1["arena"] = 26;
  var_0._id_60B1["cyber"] = 27;
  var_0._id_60B1["rush"] = 28;
  var_0._id_60B1["esc"] = 29;
  var_0._id_60B1["vip"] = 30;
  var_0._id_60B1["btm"] = 31;
  var_0._id_60B1["rugby"] = 32;
  var_0._id_60B1["arm"] = 33;
  var_0._id_60B1["mtmc"] = 34;
  var_0._id_60B1["snatch"] = 35;
  var_0._id_60B1["hq"] = 36;
  var_0._id_60B1["defcon"] = 37;
  var_0._id_60B1["pill"] = 38;
  var_0._id_60B1["blitz"] = 39;
  var_0._id_60B1["brm"] = 40;
  var_0._id_60B1["hvt"] = 41;
  var_0._id_60B1["trial"] = 42;
  var_0._id_60B1["cp_survival"] = 43;
  var_0._id_60B1["cp_wave_sv"] = 44;
  var_0._id_60B1["tanks"] = 45;
  var_0._id_60B1["arena_evo"] = 46;
  var_0._id_60B1["base"] = 47;
  var_0._id_60B1["skulls"] = 48;
  var_0._id_60B1["control"] = 49;
  var_0._id_60B1["patrol"] = 50;
  var_0._id_60B1["mines"] = 51;
  var_0._id_60B1["monuments"] = 52;
  var_0._id_60B1["zombie"] = 53;
  var_0._id_60B1["ftue"] = 54;
  var_0._id_60B1["kspoint"] = 55;
  var_0._id_60B1["circle"] = 56;
  var_0._id_60B1["mendota"] = 57;
}

_id_6956(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(level._id_33AE._id_60B1) || !isDefined(level._id_33AE._id_60B1[var_0])) {
    return 0;
  }

  if(var_0 == "br" && isDefined(level._id_2BB5) && isDefined(level._id_2BB5.name)) {
    switch (level._id_2BB5.name) {
      case "dmz":
        return 99;
      case "extract":
        return 98;
      case "evac":
        return 97;
      case "sandbox":
        return 96;
      case "":
        break;
      default:
        break;
    }
  }

  return level._id_33AE._id_60B1[var_0];
}

_id_60B4() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "init")]]();
}