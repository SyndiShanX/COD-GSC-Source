/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\dialog.gsc
***********************************************/

function leaderdialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  if(level.teambased && !isDefined(var_1)) {
    return;
  }

  var_6 = level.players;

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
      var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var_1, "players");
    }
  }

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = var_6[var_7];

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_3, var_8)) {
      continue;
    }

    if(var_8 issplitscreenplayer() && !var_8 issplitscreenplayerprimary()) {
      continue;
    }

    leaderdialogonplayer_internal(var_8, var_0, var_2, undefined, var_4, var_5);
  }
}

function initstatusdialog() {
  foreach(var_1 in level.teamnamelist) {
    level.lastteamstatustime[var_1][""] = 0;
  }
}

function statusdialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.gameended)) {
    return;
  }

  if(!isDefined(level.lastteamstatustime[var_1][var_0])) {
    level.lastteamstatustime[var_1][var_0] = 0;
  }

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

function delayedleaderdialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  wait 0.1;
  scripts\mp\utility\script::waittillslowprocessallowed();
  leaderdialog(var_0, var_1, var_2, var_3, var_4, var_5);
}

function leaderdialogonplayers(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_1) {
    leaderdialogonplayer(var_5, var_0, var_2, undefined, var_3);
  }
}

function leaderdialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  leaderdialogonplayer_internal(var_0, var_1, var_2, var_3, var_4);
}

function leaderdialogonplayer_internal(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  if(isDefined(level.ref_11C7D) && self[[level.ref_11C7D]](var_0)) {
    return;
  }

  if(isDefined(var_4)) {
    var_4 *= 1000;

    if(!isDefined(self.playerlastdialogstatus)) {
      initstatusdialogonplayer();
    }

    if(gettime() < self.playerlastdialogstatus["time"] + var_4 && self.playerlastdialogstatus["dialog"] == var_0) {
      return;
    }

    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = var_0;
  }

  var_5 = self.pers["team"];

  if(level.gametype == "br") {
    var_5 = scripts\mp\gametypes\br_public::disableannouncer(self);
  }

  if(isDefined(var_5) && scripts\mp\utility\teams::isgameplayteam(var_5)) {
    var_6 = self getplayerdata("common", "mp_announcer_type");
    var_7 = "dx_mpa_";

    if(level.gametype == "br" && tutorial_tacmap(var_0)) {
      var_7 = "dx_bra_";
    }

    if(var_6 > 0) {
      var_8 = tablelookupbyrow("mp/announcervoicedata.csv", var_6, 3);
      var_9 = var_7 + var_8 + "_" + game["dialog"][var_0];
    } else {
      jumpiffalse(scripts\cp_mp\utility\game_utility::ref_140A8()) LOC_0000013b;
      var_9 = var_9 + "bchr_" + game["dialog"][var_1];
      goto LOC_0000015d;
    }

    LOC_0000015d:
      var_9 = tolower(var_9);
    self queuedialogforplayer(var_9, var_2, 2, var_3, var_4, var_5);
    return;
  }
}

function tutorial_tacmap(var_0) {
  var_1 = 0;

  if(issubstr(var_0, "radar_drone_recon") || issubstr(var_0, "circle_peek") || issubstr(var_0, "plague_box")) {
    var_1 = 1;
  }

  return var_1;
}

function initstatusdialogonplayer() {
  self.playerlastdialogstatus["time"] = 0;
  self.playerlastdialogstatus["dialog"] = "";
}

function playkillstreakusedialog(var_0) {
  var_1 = self.team;
  var_2 = [self];
  var_3 = var_1;

  if(level.gametype == "br") {
    var_3 = scripts\mp\gametypes\br_public::disableannouncer(self);
  }

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[var_0])) {
      if(isDefined(level.killstreakactivatedtime[var_0][var_1])) {
        if(gettime() < level.killstreakactivatedtime[var_0][var_1]) {
          return;
        }
      }
    }

    level.killstreakactivatedtime[var_0][var_1] = gettime() + 10000;
  }

  var_4 = self getothersplitscreenplayer();

  if(isDefined(var_4)) {
    var_2 = var_4;
  }

  if(level.teambased) {
    var_5 = get_armsrace_interaction_loc(var_0, 1);
    var_6 = get_armsrace_interaction_loc(var_0);

    if(istrue(var_5)) {
      leaderdialog(var_3 + "_friendly_" + var_0 + "_inbound", var_1, "killstreak_used", var_2);
    }

    if(!isDefined(var_4)) {
      var_2 = undefined;
    }

    if(istrue(var_6) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_0)) {
      foreach(var_8 in level.teamnamelist) {
        if(var_8 != var_1) {
          leaderdialog(var_3 + "_enemy_" + var_0 + "_inbound", var_8, "killstreak_used", var_2);
        }
      }

      return;
    }

    return;
  }

  if(scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_3)) {
    leaderdialog(var_6 + "_enemy_" + var_3 + "_inbound", undefined, "killstreak_used", var_5);
    return;
  }
}

function playkillstreakdialogonplayer(var_0, var_1, var_2, var_3) {
  if(level.showingfinalkillcam) {
    return;
  }

  var_0 = getbasekillstreakdialog(var_0);

  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_4 = game["dialog"][var_0];

  if(issubstr(var_4, "op_" + var_0) || var_4 == "op_" + var_0) {
    scripts\cp_mp\utility\dialog_utility::operatordialogonplayer(var_0, var_1, var_2, var_3);
    return;
  }

  leaderdialogonplayer(var_0, var_1, var_2, var_3);
}

function getbasekillstreakdialog(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_2)) {
      var_2 = var_4;
    } else {
      var_2 += var_4;
    }

    var_5 = var_1[var_6 + 1];

    if(isDefined(var_5)) {
      if(var_5 == "rare" || var_5 == "legend" || var_5 == "epic") {
        break;
      }

      var_2 += "_";
    }
  }

  return var_2;
}

function get_armsrace_interaction_loc(var_0, var_1) {
  var_2 = 1;

  if(level.gametype == "br") {
    if(istrue(var_1)) {
      switch (var_0) {
        case "airdrop":
        case "radar_drone_overwatch":
        case "manual_turret":
          var_2 = 0;
          break;
      }
    } else {
      switch (var_0) {
        case "plague_box":
        case "circle_peek":
        case "radar_drone_recon":
        case "assault_drone":
        case "airdrop":
        case "directional_uav":
        case "radar_drone_overwatch":
        case "scrambler_drone_guard":
        case "uav":
        case "sentry_gun":
        case "manual_turret":
        case "toma_strike":
        case "precision_airstrike":
          var_2 = 0;
          break;
      }
    }
  } else if(level.gametype == "arm") {
    switch (var_0) {
      case "airdrop":
      case "radar_drone_overwatch":
      case "manual_turret":
        var_2 = 0;
        break;
    }
  } else if(istrue(var_1)) {
    switch (var_0) {
      case "radar_drone_overwatch":
        var_2 = 0;
        break;
    }
  }

  return var_2;
}

function sitrepdialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_5 = gettime();

  if(!isDefined(self.lastsitreptime) || var_5 < self.lastsitreptime + 30000 || var_5 < level.lastteamstatustime[self.team][var_0] + 5000) {
    return;
  }

  if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  }

  self.lastsitreptime = var_6;
  var_7 = "dx_mpa_" + var_6 + "tl_" + game["dialog"][var_1];
  self queuedialogforplayer(var_7, var_1, 2, var_2, var_3, var_4);
}

function getkillstreakdialogcooldown() {
  return 10;
}

function getdialoguedebouncetime() {
  if(istrue(level.longdialoguecooldown)) {
    return 15000;
  }

  return 5000;
}