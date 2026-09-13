/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\dialog.gsc
***********************************************/

leaderdialog(dialog, team, group, _id_21D6D994B0F4FAF1, location, time) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  if(level.teambased && !isDefined(team)) {
    return;
  }
  players = level.players;

  if(isDefined(team)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
      players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](team, "players");
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_21D6D994B0F4FAF1) && scripts\engine\utility::array_contains(_id_21D6D994B0F4FAF1, player)) {
      continue;
    }
    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }
    if(dialog == "halfway_friendly_score" && _id_189B67B2735B981D::_id_A1E1B35A0BD2F57C(player, dialog)) {
      _id_189B67B2735B981D::_id_55B08D6D71B41402(player, dialog);
      continue;
    }

    player leaderdialogonplayer_internal(dialog, group, undefined, location, time);
  }
}

initstatusdialog() {
  foreach(_id_F90358454413407F in level.teamnamelist)
  level.lastteamstatustime[_id_F90358454413407F][""] = 0;
}

statusdialog(dialog, team, group, _id_21D6D994B0F4FAF1, location, time) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!isDefined(level.lastteamstatustime[team][dialog]))
    level.lastteamstatustime[team][dialog] = 0;

  if(isDefined(time)) {
    if(gettime() < level.lastteamstatustime[team][dialog] + time) {
      return;
    }
    time = undefined;
  } else if(gettime() < level.lastteamstatustime[team][dialog] + getdialoguedebouncetime()) {
    return;
  }
  thread delayedleaderdialog(dialog, team, group, _id_21D6D994B0F4FAF1, location, time);
  level.lastteamstatustime[team][dialog] = gettime();
}

delayedleaderdialog(sound, team, group, _id_21D6D994B0F4FAF1, location, time) {
  level endon("game_ended");
  wait 0.1;
  scripts\mp\utility\script::waittillslowprocessallowed();
  leaderdialog(sound, team, group, _id_21D6D994B0F4FAF1, location, time);
}

leaderdialogonplayers(dialog, players, group, location) {
  foreach(player in players)
  player leaderdialogonplayer(dialog, group, undefined, location);
}

leaderdialogonplayer(dialog, group, _id_E8F8F1056DA11E98, location, time) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  leaderdialogonplayer_internal(dialog, group, _id_E8F8F1056DA11E98, location, time);
}

leaderdialogonplayer_internal(dialog, group, _id_E8F8F1056DA11E98, location, time) {
  if(istrue(level.disableannouncer)) {
    return;
  }
  if(isDefined(level.modeplayerskipdialog) && self[[level.modeplayerskipdialog]](dialog)) {
    return;
  }
  if(isDefined(time)) {
    time = time * 1000;

    if(!isDefined(self.playerlastdialogstatus))
      initstatusdialogonplayer();

    if(gettime() < self.playerlastdialogstatus["time"] + time && self.playerlastdialogstatus["dialog"] == dialog) {
      return;
    }
    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = dialog;
  }

  team = self.pers["team"];

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    team = _id_2CEDCC356F1B9FC8::brgetoperatorteam(self);

  if(isDefined(team) && scripts\mp\utility\teams::isgameplayteam(team)) {
    _id_6BB6D4E4BE824FEC = self getplayerdata("common", "mp_announcer_type");

    if(_id_EE82DB162F3B07A8(game["dialog"][dialog])) {
      _id_DEC9BCCE93873125 = "dx_mp_";
      _id_5F02B3A1FBA344D5 = scripts\mp\utility\teams::getteamvoiceinfix(team);
      _id_9AE55BEDBA1D14D6 = strtok(game["dialog"][dialog], "_");
      dialog = _id_DEC9BCCE93873125 + _id_9AE55BEDBA1D14D6[1] + "_" + _id_9AE55BEDBA1D14D6[2] + "_" + _id_5F02B3A1FBA344D5 + "tl_" + _id_9AE55BEDBA1D14D6[4];
      _id_CB3339ECE72DBDEB = dialog;
    } else {
      _id_DEC9BCCE93873125 = "dx_mpa_";

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_6B1AF1C789523D89(dialog))
        _id_DEC9BCCE93873125 = "dx_bra_";

      if(_id_6BB6D4E4BE824FEC > 0) {
        _id_5F02B3A1FBA344D5 = tablelookupbyrow("mp/announcervoicedata.csv", _id_6BB6D4E4BE824FEC, 3);
        _id_CB3339ECE72DBDEB = _id_DEC9BCCE93873125 + _id_5F02B3A1FBA344D5 + "_" + game["dialog"][dialog];
      } else {
        _id_5F02B3A1FBA344D5 = scripts\mp\utility\teams::getteamvoiceinfix(team);
        _id_CB3339ECE72DBDEB = _id_DEC9BCCE93873125 + _id_5F02B3A1FBA344D5 + "tl_" + game["dialog"][dialog];
      }

      if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm")
        _id_CB3339ECE72DBDEB = _id_DEC9BCCE93873125 + "uktl_" + game["dialog"][dialog];
    }

    _id_CB3339ECE72DBDEB = tolower(_id_CB3339ECE72DBDEB);

    if(_func_D03495FE6418377B(dialog))
      dialog = _func_0F28FD66285FA2C9(dialog);

    self queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2, group, _id_E8F8F1056DA11E98, location);
  }
}

_id_EE82DB162F3B07A8(dialog) {
  return issubstr(dialog, "iw9");
}

_id_26FB379F4BA5CAA2(team) {
  return scripts\engine\utility::ter_op(team == "allies", "uk", "ru");
}

_id_6B1AF1C789523D89(dialog) {
  _id_C2D024171C7E33A7 = 0;

  if(issubstr(dialog, "radar_drone_recon") || issubstr(dialog, "circle_peek"))
    _id_C2D024171C7E33A7 = 1;

  return _id_C2D024171C7E33A7;
}

initstatusdialogonplayer() {
  self.playerlastdialogstatus["time"] = 0;
  self.playerlastdialogstatus["dialog"] = "";
}

sitrepdialogonplayer(dialog, group, _id_E8F8F1056DA11E98, location, _id_33E84A22F9F80374) {
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  currenttime = gettime();

  if(!isDefined(self.lastsitreptime) || currenttime < self.lastsitreptime + 30000 || currenttime < level.lastteamstatustime[self.team][dialog] + 5000) {
    return;
  }
  if(isDefined(_id_33E84A22F9F80374))
    _id_840772EC06A3E063 = _id_33E84A22F9F80374;
  else
    _id_840772EC06A3E063 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);

  self.lastsitreptime = currenttime;
  _id_CB3339ECE72DBDEB = "dx_mpa_" + _id_840772EC06A3E063 + "tl_" + game["dialog"][dialog];
  self queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, 2, group, _id_E8F8F1056DA11E98, location);
}

getdialoguedebouncetime() {
  if(istrue(level.longdialoguecooldown))
    return 15000;
  else
    return 5000;
}

_id_7991789FBDEF687E() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "rescue":
      game["dialog"]["gametype"] = "iw9_mbtl_prmd_detl_name";
      break;
    case "sd":
      game["dialog"]["gametype"] = "iw9_mbtl_mode_uktl_name";
      break;
    case "cyber":
      game["dialog"]["gametype"] = "iw9_cybr_mode_uktl_nam2";
      break;
  }
}