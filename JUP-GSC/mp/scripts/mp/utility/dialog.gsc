/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\dialog.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\war;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace dialog;

function leaderdialog(dialog, team, group, excludelist, location, time) {
  assert(isDefined(level.players));

  if(!isDefined(game["dialog"][dialog])) {
    println("<dev string:x1c>" + dialog + "<dev string:x27>");
    return;
  }

  if(level.teambased && !isDefined(team)) {
    return;
  }

  players = level.players;

  if(isDefined(team)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "getTeamData")) {
      players = [[scripts\engine\utility::getsharedfunc("game", "getTeamData")]](team, "players");
    }
  }

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(isDefined(excludelist) && array_contains(excludelist, player)) {
      continue;
    }

    if(player issplitscreenplayer() && !player issplitscreenplayerprimary()) {
      continue;
    }

    if(dialog == "halfway_friendly_score" && scripts\cp_mp\talking_gun::function_a1e1b35a0bd2f57c(player, dialog)) {
      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(player, dialog);
      continue;
    }

    player leaderdialogonplayer_internal(dialog, group, undefined, location, time);
  }
}

function initstatusdialog() {
  foreach(entry in level.teamnamelist) {
    level.lastteamstatustime[entry][""] = 0;
  }
}

function statusdialog(dialog, team, group, excludelist, location, time) {
  if(istrue(level.gameended)) {
    return;
  }

  if(!isDefined(level.lastteamstatustime[team][dialog])) {
    level.lastteamstatustime[team][dialog] = 0;
  }

  if(isDefined(time)) {
    if(gettime() < level.lastteamstatustime[team][dialog] + time) {
      return;
    }

    time = undefined;
  } else if(gettime() < level.lastteamstatustime[team][dialog] + getdialoguedebouncetime()) {
    return;
  }

  thread delayedleaderdialog(dialog, team, group, excludelist, location, time);
  level.lastteamstatustime[team][dialog] = gettime();
}

function delayedleaderdialog(sound, team, group, excludelist, location, time) {
  level endon("game_ended");
  wait 0.1;
  waittillslowprocessallowed();
  leaderdialog(sound, team, group, excludelist, location, time);
}

function leaderdialogonplayers(dialog, players, group, location) {
  foreach(player in players) {
    player leaderdialogonplayer(dialog, group, undefined, location);
  }
}

function leaderdialogonplayer(dialog, group, groupoverride, location, time) {
  if(!isDefined(game["dialog"][dialog])) {
    println("<dev string:x1c>" + dialog + "<dev string:x27>");
    return;
  }

  leaderdialogonplayer_internal(dialog, group, groupoverride, location, time);
}

function leaderdialogonplayer_internal(dialog, group, groupoverride, location, time) {
  if(istrue(level.disableannouncer)) {
    return;
  }

  if(isDefined(level.modeplayerskipdialog) && self[[level.modeplayerskipdialog]](dialog)) {
    return;
  }

  if(isDefined(time)) {
    time *= 1000;

    if(!isDefined(self.playerlastdialogstatus)) {
      scripts\mp\utility\dialog::initstatusdialogonplayer();
    }

    if(gettime() < self.playerlastdialogstatus["time"] + time && self.playerlastdialogstatus["dialog"] == dialog) {
      return;
    }

    self.playerlastdialogstatus["time"] = gettime();
    self.playerlastdialogstatus["dialog"] = dialog;
  }

  team = self.pers["team"];

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    team = scripts\mp\gametypes\br_public::brgetoperatorteam(self);
  }

  if(isDefined(team) && isgameplayteam(team)) {
    announcer = self getplayerdata("common", "mp_announcer_type");

    if(function_99fd33719db79d3f(game["dialog"][dialog]) || function_1937c4131d39b030(game["dialog"][dialog])) {
      var_9ae55bedba1d14d6 = strtok(game["dialog"][dialog], "_");
      prefix = var_9ae55bedba1d14d6[0] + "_" + var_9ae55bedba1d14d6[1] + "_" + var_9ae55bedba1d14d6[2] + "_" + var_9ae55bedba1d14d6[3];
      infix = getteamvoiceinfix(team);
      suffix = var_9ae55bedba1d14d6[5];

      if(getdvarint(@ "t10", 0)) {
        if(is_equal(team, "allies")) {
          infix = "t141";
        } else {
          infix = "sptnz";
        }
      }

      soundname = prefix + "_" + infix + "_" + suffix;
    } else if(function_ee82db162f3b07a8(game["dialog"][dialog])) {
      prefix = "dx_mp_";
      infix = getteamvoiceinfix(team);
      var_9ae55bedba1d14d6 = strtok(game["dialog"][dialog], "_");
      dialog = prefix + var_9ae55bedba1d14d6[1] + "_" + var_9ae55bedba1d14d6[2] + "_" + infix + "tl_" + var_9ae55bedba1d14d6[4];
      soundname = dialog;
    } else if(function_1937c4131d39b030(game["dialog"][dialog])) {
      prefix = "dx_mp_";
      infix = getteamvoiceinfix(team);
      var_9ae55bedba1d14d6 = strtok(game["dialog"][dialog], "_");
      dialog = prefix + var_9ae55bedba1d14d6[2] + "_" + var_9ae55bedba1d14d6[3] + "_" + infix + "tl_" + var_9ae55bedba1d14d6[5];
      soundname = dialog;
    } else if(isslamannouncerline(game["dialog"][dialog])) {
      dialog = callsharedfunc("slam", "getSoundName", game["dialog"][dialog]);
      soundname = dialog;
    } else {
      prefix = "dx_mpa_";

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && function_6b1af1c789523d89(dialog)) {
        prefix = "dx_bra_";
      }

      if(announcer > 0) {
        infix = tablelookupbyrow("mp/announcervoicedata.csv", announcer, 3);
        soundname = prefix + infix + "_" + game["dialog"][dialog];
      } else {
        infix = getteamvoiceinfix(team);
        soundname = prefix + infix + "tl_" + game["dialog"][dialog];
      }

      if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
        soundname = prefix + "uktl_" + game["dialog"][dialog];
      }

      if(function_1b7524a0e081ab71(game["dialog"][dialog])) {
        soundname = game["dialog"][dialog];
      }

      var_31d69d326a1d3eda = issubstr(dialog, "lrad");
      var_ba47c289a27153c6 = issubstr(dialog, "switchblade_drone ");

      if(var_31d69d326a1d3eda || var_ba47c289a27153c6) {
        prefix = "dx_mp_jkil_";
        streak = undefined;

        if(var_31d69d326a1d3eda) {
          streak = "guar_";
        } else if(var_ba47c289a27153c6) {
          streak = "mdro_";
        }

        if(is_equal(self.pers["team"], "allies")) {
          teamref = "detl_";
        } else {
          teamref = "uktl_";
        }

        soundname = prefix + streak + teamref + game["dialog"][dialog];
      }
    }

    soundname = tolower(soundname);

    if(isxhash(dialog)) {
      dialog = getxhashhexname(dialog);
    }

    self queuedialogforplayer(soundname, dialog, 2, group, groupoverride, location);
  }
}

function function_ee82db162f3b07a8(dialog) {
  return issubstr(dialog, "iw9");
}

function function_99fd33719db79d3f(dialog) {
  return getdvarint(@ "jup", 0) && issubstr(dialog, "dx_mp_") && !function_1b7524a0e081ab71(dialog) && !isslamannouncerline(dialog);
}

function function_1b7524a0e081ab71(dialog) {
  if(!getdvarint(@ "jup", 0)) {
    return 0;
  }

  if(!isDefined(dialog)) {
    return 0;
  }

  switch (dialog) {
    case #"hash_e54ea4dddd99ffb":
    case #"hash_c752ed699512b30f":
      return 1;
    default:
      return 0;
  }
}

function isslamannouncerline(dialog) {
  if(scripts\mp\gametypes\war::function_2898a9c3d425a919() && issharedfuncdefined("slam", "isSlamAnnouncerLine")) {
    return callsharedfunc("slam", "isSlamAnnouncerLine", dialog);
  }

  return 0;
}

function function_1937c4131d39b030(dialog) {
  return getdvarint(@ "t10", 0) > 0 && (issubstr(dialog, "_mode_") || issubstr(dialog, "_shrd_") || issubstr(dialog, "_game_"));
}

function function_26fb379f4ba5caa2(team) {
  return ter_op(team == "allies", "uk", "ru");
}

function function_6b1af1c789523d89(dialog) {
  var_c2d024171c7e33a7 = 0;

  if(issubstr(dialog, "radar_drone_recon") || issubstr(dialog, "circle_peek")) {
    var_c2d024171c7e33a7 = 1;
  }

  return var_c2d024171c7e33a7;
}

function initstatusdialogonplayer() {
  self.playerlastdialogstatus["time"] = 0;
  self.playerlastdialogstatus["dialog"] = "";
}

function sitrepdialogonplayer(dialog, group, groupoverride, location, announceroverride) {
  if(!isDefined(game["dialog"][dialog])) {
    println("<dev string:x1c>" + dialog + "<dev string:x52>");
    return;
  }

  currenttime = gettime();

  if(!isDefined(self.lastsitreptime) || currenttime < self.lastsitreptime + 30000 || currenttime < level.lastteamstatustime[self.team][dialog] + 5000) {
    return;
  }

  if(isDefined(announceroverride)) {
    var_840772ec06a3e063 = announceroverride;
  } else {
    var_840772ec06a3e063 = getteamvoiceinfix(self.team);
  }

  self.lastsitreptime = currenttime;
  soundname = "dx_mpa_" + var_840772ec06a3e063 + "tl_" + game["dialog"][dialog];
  self queuedialogforplayer(soundname, dialog, 2, group, groupoverride, location);
}

function getdialoguedebouncetime() {
  if(istrue(level.longdialoguecooldown)) {
    return 15000;
  }

  return 5000;
}

function function_7991789fbdef687e() {
  switch (getgametype()) {
    case #"hash_ec086b911c1011ec":
      game["dialog"]["gametype"] = "iw9_mbtl_prmd_detl_name";
      break;
    case #"hash_fa50b0f6bd82e972":
      game["dialog"]["gametype"] = "iw9_mbtl_mode_uktl_name";
      break;
    case #"hash_eb5e5f470e0c1dc2":
      game["dialog"]["gametype"] = "iw9_cybr_mode_uktl_nam2";
      break;
  }
}