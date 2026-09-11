/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\dialog.gsc
***********************************************/

function leaderdialog(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(game["dialog"][var0])) {
    return;
  }

  if(level.teambased && !isDefined(var1)) {
    return;
  }

  var6 = level.players;

  if(isDefined(var1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
      var6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var1, "players");
    }
  }

  for(var7 = 0; var7 < var6.size; var7++) {
    var8 = var6[var7];

    if(isDefined(var3) && scripts\engine\utility::array_contains(var3, var8)) {
      continue;
    }

    if(var8 issplitscreenplayer() && !var8 issplitscreenplayerprimary()) {
      continue;
    }

    leaderdialogonplayer_internal(var8, var0, var2, undefined, var4, var5);
  }
}

function initstatusdialog() {
  foreach(var1 in level.teamnamelist) {
    level.lastteamstatustime[var1][""] = 0;
  }
}

function statusdialog(var0, var1, var2, var3, var4, var5) {
  if(istrue(level.gameended)) {
    return;
  }

  if(!isDefined(level.lastteamstatustime[var1][var0])) {
    level.lastteamstatustime[var1][var0] = 0;
  }

  if(isDefined(var5)) {
    if(gettime() < level.lastteamstatustime[var1][var0] + var5) {
      return;
    }

    var5 = undefined;
  } else if(gettime() < level.lastteamstatustime[var1][var0] + getdialoguedebouncetime()) {
    return;
  }

  thread delayedleaderdialog(var0, var1, var2, var3, var4, var5);
  level.lastteamstatustime[var1][var0] = gettime();
}

function delayedleaderdialog(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  wait 0.1;
  scripts\mp\utility\script::waittillslowprocessallowed();
  leaderdialog(var0, var1, var2, var3, var4, var5);
}

function leaderdialogonplayers(var0, var1, var2, var3) {
  foreach(var5 in var1) {
    leaderdialogonplayer(var5, var0, var2, undefined, var3);
  }
}

function leaderdialogonplayer(var0, var1, var2, var3, var4) {
  if(!isDefined(game["dialog"][var0])) {
    return;
  }

  leaderdialogonplayer_internal(var0, var1, var2, var3, var4);
}

function leaderdialogonplayer_internal(var0, var1, var2, var3, var4) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  if(isDefined(level.ref_11c7d) && self[[level.ref_11c7d]](var0)) {
    return;
  }

  if(isDefined(var4)) {
    var4 *= 1000;

    if(!isDefined(self.playerlastdialogstatus)) {
      initstatusdialogonplayer();
    }

    if(gettime() < self.playerlastdialogstatus["time"] + var4 && self.playerlastdialogstatus["dialog"] == var0) {
      return;
    }

    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = var0;
  }

  var5 = self.pers["team"];

  if(level.gametype == "br") {
    var5 = scripts\mp\gametypes\br_public::disableannouncer(self);
  }

  if(isDefined(var5) && scripts\mp\utility\teams::isgameplayteam(var5)) {
    var6 = self getplayerdata("common", "mp_announcer_type");
    var7 = "dx_mpa_";

    if(level.gametype == "br" && tutorial_tacmap(var0)) {
      var7 = "dx_bra_";
    }

    if(var6 > 0) {
      var8 = tablelookupbyrow("mp/announcervoicedata.csv", var6, 3);
      var9 = var7 + var8 + "_" + game["dialog"][var0];
    } else {
      jumpiffalse(scripts\cp_mp\utility\game_utility::ref_140a8()) LOC_0000013b;
      var9 = var9 + "bchr_" + game["dialog"][var1];
      goto LOC_0000015d;
    }

    LOC_0000015d:
      var9 = tolower(var9);
    self queuedialogforplayer(var9, var2, 2, var3, var4, var5);
    return;
  }
}

function tutorial_tacmap(var0) {
  var1 = 0;

  if(issubstr(var0, "radar_drone_recon") || issubstr(var0, "circle_peek") || issubstr(var0, "plague_box")) {
    var1 = 1;
  }

  return var1;
}

function initstatusdialogonplayer() {
  self.playerlastdialogstatus["time"] = 0;
  self.playerlastdialogstatus["dialog"] = "";
}

function playkillstreakusedialog(var0) {
  var1 = self.team;
  var2 = [self];
  var3 = var1;

  if(level.gametype == "br") {
    var3 = scripts\mp\gametypes\br_public::disableannouncer(self);
  }

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[var0])) {
      if(isDefined(level.killstreakactivatedtime[var0][var1])) {
        if(gettime() < level.killstreakactivatedtime[var0][var1]) {
          return;
        }
      }
    }

    level.killstreakactivatedtime[var0][var1] = gettime() + 10000;
  }

  var4 = self getothersplitscreenplayer();

  if(isDefined(var4)) {
    var2 = var4;
  }

  if(level.teambased) {
    var5 = get_armsrace_interaction_loc(var0, 1);
    var6 = get_armsrace_interaction_loc(var0);

    if(istrue(var5)) {
      leaderdialog(var3 + "_friendly_" + var0 + "_inbound", var1, "killstreak_used", var2);
    }

    if(!isDefined(var4)) {
      var2 = undefined;
    }

    if(istrue(var6) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var0)) {
      foreach(var8 in level.teamnamelist) {
        if(var8 != var1) {
          leaderdialog(var3 + "_enemy_" + var0 + "_inbound", var8, "killstreak_used", var2);
        }
      }

      return;
    }

    return;
  }

  if(scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var3)) {
    leaderdialog(var6 + "_enemy_" + var3 + "_inbound", undefined, "killstreak_used", var5);
    return;
  }
}

function playkillstreakdialogonplayer(var0, var1, var2, var3) {
  if(level.showingfinalkillcam) {
    return;
  }

  var0 = getbasekillstreakdialog(var0);

  if(!isDefined(game["dialog"][var0])) {
    return;
  }

  var4 = game["dialog"][var0];

  if(issubstr(var4, "op_" + var0) || var4 == "op_" + var0) {
    scripts\cp_mp\utility\dialog_utility::operatordialogonplayer(var0, var1, var2, var3);
    return;
  }

  leaderdialogonplayer(var0, var1, var2, var3);
}

function getbasekillstreakdialog(var0) {
  var1 = strtok(var0, "_");
  var2 = undefined;

  foreach(var4 in var1) {
    if(!isDefined(var2)) {
      var2 = var4;
    } else {
      var2 += var4;
    }

    var5 = var1[var6 + 1];

    if(isDefined(var5)) {
      if(var5 == "rare" || var5 == "legend" || var5 == "epic") {
        break;
      }

      var2 += "_";
    }
  }

  return var2;
}

function get_armsrace_interaction_loc(var0, var1) {
  var2 = 1;

  if(level.gametype == "br") {
    if(istrue(var1)) {
      switch (var0) {
        case "airdrop":
        case "radar_drone_overwatch":
        case "manual_turret":
          var2 = 0;
          break;
      }
    } else {
      switch (var0) {
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
          var2 = 0;
          break;
      }
    }
  } else if(level.gametype == "arm") {
    switch (var0) {
      case "airdrop":
      case "radar_drone_overwatch":
      case "manual_turret":
        var2 = 0;
        break;
    }
  } else if(istrue(var1)) {
    switch (var0) {
      case "radar_drone_overwatch":
        var2 = 0;
        break;
    }
  }

  return var2;
}

function sitrepdialogonplayer(var0, var1, var2, var3, var4) {
  if(!isDefined(game["dialog"][var0])) {
    return;
  }

  var5 = gettime();

  if(!isDefined(self.lastsitreptime) || var5 < self.lastsitreptime + 30000 || var5 < level.lastteamstatustime[self.team][var0] + 5000) {
    return;
  }

  if(isDefined(var4)) {
    var6 = var4;
  } else {
    var6 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  }

  self.lastsitreptime = var6;
  var7 = "dx_mpa_" + var6 + "tl_" + game["dialog"][var1];
  self queuedialogforplayer(var7, var1, 2, var2, var3, var4);
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