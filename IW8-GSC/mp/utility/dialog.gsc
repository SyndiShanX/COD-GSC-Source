/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\dialog.gsc
***********************************************/

leaderdialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  if(level.teambased && !isDefined(var_1)) {
    return;
  }
  var_6 = level.players;

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91"))
      var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91")]](var_1, "_encstr_9775086022BE1B413B8B");
  }

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = var_6[var_7];

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_3, var_8)) {
      continue;
    }
    if(var_8 issplitscreenplayer() && !var_8 issplitscreenplayerprimary()) {
      continue;
    }
    var_8 leaderdialogonplayer_internal(var_0, var_2, undefined, var_4, var_5);
  }
}

initstatusdialog() {
  foreach(var_1 in level.teamnamelist)
  level.lastteamstatustime[var_1]["_encstr_B40101"] = 0;
}

statusdialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!isDefined(level.lastteamstatustime[var_1][var_0]))
    level.lastteamstatustime[var_1][var_0] = 0;

  if(isDefined(var_5)) {
    if(gettime() < level.lastteamstatustime[var_1][var_0] + var_5) {
      return;
    }
    var_5 = undefined;
  } else if(gettime() < level.lastteamstatustime[var_1][var_0] + getdialoguedebouncetime()) {
    return;
  }
  thread delayedleaderdialog(var_0, var_1, var_2, var_3, var_4, var_5);
  level.lastteamstatustime[var_1][var_0] = gettime();
}

delayedleaderdialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.1;
  scripts\mp\utility\script::waittillslowprocessallowed();
  leaderdialog(var_0, var_1, var_2, var_3, var_4, var_5);
}

leaderdialogonplayers(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_1)
  var_5 leaderdialogonplayer(var_0, var_2, undefined, var_3);
}

leaderdialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  leaderdialogonplayer_internal(var_0, var_1, var_2, var_3, var_4);
}

leaderdialogonplayer_internal(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }
  if(isDefined(level._id_11C7D) && self[[level._id_11C7D]](var_0)) {
    return;
  }
  if(isDefined(var_4)) {
    var_4 = var_4 * 1000;

    if(!isDefined(self.playerlastdialogstatus))
      initstatusdialogonplayer();

    if(gettime() < self.playerlastdialogstatus["_encstr_84EF055338A18F"] + var_4 && self.playerlastdialogstatus["_encstr_B2DA070A5F8BAB87AF"] == var_0) {
      return;
    }
    self.playerlastdialogstatus["_encstr_84EF055338A18F"] = gettime();
    self.playerlastdialogstatus["_encstr_B2DA070A5F8BAB87AF"] = var_0;
  }

  var_5 = self.pers["_encstr_8AEF05472BC2D6"];

  if(level.gametype == "_encstr_B607038AAB")
    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer(self);

  if(isDefined(var_5) && scripts\mp\utility\teams::isgameplayteam(var_5)) {
    var_6 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_A1441209A2497B78DE1708E81FED33CF23087F85");
    var_7 = "_encstr_816908616B9751608687";

    if(level.gametype == "_encstr_B607038AAB" && tutorial_tacmap(var_0))
      var_7 = "_encstr_AB7508A1C157AA4A61C7";

    if(var_6 > 0) {
      var_8 = tablelookupbyrow("_encstr_84771ADA07F2C2DC37DBBAB91B59C93BEDB43659230BE885E26C9B3B", var_6, 3);
      var_9 = var_7 + var_8 + "_encstr_BA4C02DF" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
    } else if(scripts\cp_mp\utility\game_utility::_id_140A8())
      var_9 = var_7 + "_encstr_B68F06983643E4F5" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
    else {
      var_8 = scripts\mp\utility\teams::getteamvoiceinfix(var_5);
      var_9 = var_7 + var_8 + "_encstr_931904037CD1" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
    }

    var_9 = tolower(var_9);
    self queuedialogforplayer(var_9, var_0, 2, var_1, var_2, var_3);
  }
}

tutorial_tacmap(var_0) {
  var_1 = 0;

  if(issubstr(var_0, "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") || issubstr(var_0, "_encstr_8B820C8D96391B1B59FAC1ACB2B6") || issubstr(var_0, "_encstr_A3340BD89A06AFCBFF2F46C8F0"))
    var_1 = 1;

  return var_1;
}

initstatusdialogonplayer() {
  self.playerlastdialogstatus["_encstr_84EF055338A18F"] = 0;
  self.playerlastdialogstatus["_encstr_B2DA070A5F8BAB87AF"] = "_encstr_B40101";
}

playkillstreakusedialog(var_0) {
  var_1 = self.team;
  var_2 = [self];
  var_3 = var_1;

  if(level.gametype == "_encstr_B607038AAB")
    var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer(self);

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[var_0])) {
      if(isDefined(level.killstreakactivatedtime[var_0][var_1])) {
        if(gettime() < level.killstreakactivatedtime[var_0][var_1])
          return;
      }
    }

    level.killstreakactivatedtime[var_0][var_1] = gettime() + 10000;
  }

  var_4 = self getothersplitscreenplayer();

  if(isDefined(var_4))
    var_2[var_2.size] = var_4;

  if(level.teambased) {
    var_5 = get_armsrace_interaction_loc(var_0, 1);
    var_6 = get_armsrace_interaction_loc(var_0);

    if(istrue(var_5))
      leaderdialog(var_3 + "_encstr_8EBC0BF5994E9695E62336BCD7" + var_0 + "_encstr_86FF098F7BCD431D2BC8F2", var_1, "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559", var_2);

    if(!isDefined(var_4))
      var_2 = undefined;

    if(istrue(var_6) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_0)) {
      foreach(var_8 in level.teamnamelist) {
        if(var_8 != var_1)
          leaderdialog(var_3 + "_encstr_9116087DACCD56DAE57D" + var_0 + "_encstr_86FF098F7BCD431D2BC8F2", var_8, "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559", var_2);
      }

      return;
    }
  } else if(scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_0))
    leaderdialog(var_3 + "_encstr_9116087DACCD56DAE57D" + var_0 + "_encstr_86FF098F7BCD431D2BC8F2", undefined, "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559", var_2);
}

playkillstreakdialogonplayer(var_0, var_1, var_2, var_3) {
  if(level.showingfinalkillcam) {
    return;
  }
  var_0 = getbasekillstreakdialog(var_0);

  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  var_4 = game["_encstr_B2DA070A5F8BAB87AF"][var_0];

  if(issubstr(var_4, "_encstr_8A19045A2817" + var_0) || var_4 == "_encstr_8A19045A2817" + var_0)
    scripts\cp_mp\utility\dialog_utility::operatordialogonplayer(var_0, var_1, var_2, var_3);
  else
    leaderdialogonplayer(var_0, var_1, var_2, var_3);
}

getbasekillstreakdialog(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");
  var_2 = undefined;

  foreach(var_6, var_4 in var_1) {
    if(!isDefined(var_2))
      var_2 = var_4;
    else
      var_2 = var_2 + var_4;

    var_5 = var_1[var_6 + 1];

    if(isDefined(var_5)) {
      if(var_5 == "_encstr_811F05C0D722E1" || var_5 == "_encstr_8A8C07B9F712D51814" || var_5 == "_encstr_A56005CAC14BD8") {
        break;
      } else
        var_2 = var_2 + "_encstr_BA4C02DF";
    }
  }

  return var_2;
}

get_armsrace_interaction_loc(var_0, var_1) {
  var_2 = 1;

  if(level.gametype == "_encstr_B607038AAB") {
    if(istrue(var_1)) {
      switch (var_0) {
        case "_encstr_BA67082278D537E3C827":
        case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
          var_2 = 0;
          break;
      }
    } else {
      switch (var_0) {
        case "_encstr_A3340BD89A06AFCBFF2F46C8F0":
        case "_encstr_8B820C8D96391B1B59FAC1ACB2B6":
        case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
        case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
        case "_encstr_BA67082278D537E3C827":
        case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
        case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        case "_encstr_851904B59B34":
        case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
        case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
        case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
          var_2 = 0;
          break;
      }
    }
  } else if(level.gametype == "_encstr_B81904B04E6B") {
    switch (var_0) {
      case "_encstr_BA67082278D537E3C827":
      case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
      case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        var_2 = 0;
        break;
    }
  } else if(istrue(var_1)) {
    switch (var_0) {
      case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        var_2 = 0;
        break;
    }
  }

  return var_2;
}

sitrepdialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  var_5 = gettime();

  if(!isDefined(self.lastsitreptime) || var_5 < self.lastsitreptime + 30000 || var_5 < level.lastteamstatustime[self.team][var_0] + 5000) {
    return;
  }
  if(isDefined(var_4))
    var_6 = var_4;
  else
    var_6 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);

  self.lastsitreptime = var_5;
  var_7 = "_encstr_816908616B9751608687" + var_6 + "_encstr_931904037CD1" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
  self queuedialogforplayer(var_7, var_0, 2, var_1, var_2, var_3);
}

getkillstreakdialogcooldown() {
  return 10;
}

getdialoguedebouncetime() {
  if(istrue(level.longdialoguecooldown))
    return 15000;
  else
    return 5000;
}