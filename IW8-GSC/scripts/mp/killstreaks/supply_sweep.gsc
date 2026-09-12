/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\supply_sweep.gsc
***************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("supply_sweep", &tryusesupplysweepfromstruct);
  teleportplayertoselection();

  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.teamdata[level.teamnamelist[var_0]]["activeSupplySweeps"] = [];
    level.teamdata[level.teamnamelist[var_0]]["supplySweepEndTime"] = 0;
    level.teamdata[level.teamnamelist[var_0]]["numSupplySweepKillstreakStarted"] = 0;
  }
}

function teleportplayertoselection() {
  game["dialog"]["supply_sweep_start"] = "trials_killstreak_supplysweep_start";
  game["dialog"]["supply_sweep_end"] = "trials_killstreak_supplysweep_end";
}

function tryusesupplysweepfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = undefined;

  if(istrue(level.pe_auavscan_active)) {
    var_1 = "MP_BR_INGAME_TU_WZ335/AUAVSCAN_IN_PROGRESS";
  } else if(istrue(self.hasradar)) {
    var_1 = "MP_BR_INGAME_TU_WZ350/UAV_SCAN_IN_PROGRESS";
  }

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_1);
    }

    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_2 = playcallingesture(var_0);

  if(!istrue(var_2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  thread launchsupplysweep(level, self);
  return true;
}

function playcallingesture(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!istrue(var_0.ref_133cc)) {
    var_1 = "ks_gesture_generic_mp";

    if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
      var_1 = "ks_gesture_generic_mp_ch3";
    }

    var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname(var_1));

    if(!istrue(var_2)) {
      return false;
    }
  }

  return true;
}

function launchsupplysweep(var_0, var_1) {
  var_2 = var_0.team;
  onstartsupplysweep(var_0, var_2, var_1);
  var_3 = getdvarint("scr_supply_sweep_duration", 20);
  var_4 = level.teamdata[var_2]["activeSupplySweeps"].size > 0;
  var_5 = undefined;

  if(var_4) {
    var_5 = level.teamdata[var_2]["supplySweepEndTime"] + var_3 * 1000;
  } else {
    var_5 = gettime() + var_3 * 1000;
  }

  level.teamdata[var_2]["activeSupplySweeps"] = scripts\engine\utility::array_add(level.teamdata[var_2]["activeSupplySweeps"], var_1);
  level.teamdata[var_2]["supplySweepEndTime"] = var_5;
  var_6 = scripts\mp\utility\teams::getteamdata(var_2, "players");

  foreach(var_8 in var_6) {
    if(isDefined(var_8) && !var_8 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_8 method_87ec(1);
      var_8 playsoundtoplayer("activate_supply_sweep", var_8);
    }
  }

  var_10 = level.teamdata[var_2]["activeSupplySweeps"].size >= 3;
  advancedsupplysweepsetenabled(var_10, var_2);
  var_11 = max((var_5 - gettime()) / 1000, 0.1);
  scripts\engine\utility::ref_143b9(var_11, "game_ended");
  level.teamdata[var_2]["activeSupplySweeps"] = scripts\engine\utility::array_remove(level.teamdata[var_2]["activeSupplySweeps"], var_1);
  var_10 = level.teamdata[var_2]["activeSupplySweeps"].size >= 3;
  advancedsupplysweepsetenabled(var_10, var_2);
  var_12 = level.teamdata[var_2]["activeSupplySweeps"].size == 0;

  if(var_12) {
    var_6 = scripts\mp\utility\teams::getteamdata(var_2, "players");

    foreach(var_8 in var_6) {
      if(isDefined(var_8)) {
        var_8 method_87ec(0);
      }
    }
  } else {
    while(!var_12 && !level.gameended) {
      var_5 = level.teamdata[var_2]["supplySweepEndTime"];
      var_11 = max((var_5 - gettime()) / 1000, 0.1);
      scripts\engine\utility::ref_143b9(var_11, "game_ended");
      var_12 = level.teamdata[var_2]["activeSupplySweeps"].size == 0;
    }
  }

  onendsupplysweep(var_0, var_2, var_1);
}

function onstartsupplysweep(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_2.streakname, var_0.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_supply_sweep", var_0);
  }

  if(!istrue(level.gameended)) {
    playsupplysweepoperatordialog(var_1, "supply_sweep_start");
  }

  level.teamdata[var_1]["numSupplySweepKillstreakStarted"]++;
}

function onendsupplysweep(var_0, var_1, var_2) {
  level.teamdata[var_1]["numSupplySweepKillstreakStarted"]--;

  if(level.teamdata[var_1]["numSupplySweepKillstreakStarted"] == 0 && !istrue(level.gameended)) {
    playsupplysweepoperatordialog(var_1, "supply_sweep_end");
  }

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_2);
  }

  if(isDefined(var_0) && !istrue(level.ref_12aa4)) {
    var_0 scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_2);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_2.streakname, var_0);
    return;
  }
}

function advancedsupplysweepsetenabled(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "players");

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && !var_4 scripts\mp\gametypes\br_public::ref_125f3()) {
      var_4 method_87ed(var_0);
    }
  }
}

function playsupplysweepoperatordialog(var_0, var_1) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  if(!isDefined(game["dialog"][var_1])) {
    return;
  }

  var_2 = "dx_bra_pilo_" + game["dialog"][var_1];
  var_3 = level.teamdata[var_0]["players"];

  foreach(var_5 in var_3) {
    thread supplysweepdialogplayer(var_2, var_1, var_5, 1, 0);
  }
}

function supplysweepdialogplayer(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");

  if(!isDefined(var_2)) {
    return;
  }

  var_2 endon("death_or_disconnect");

  if(!isalive(var_2) && !istrue(var_4)) {
    return;
  }

  if(var_2 scripts\mp\gametypes\br_public::ref_11c7d(var_1, var_3)) {
    return;
  }

  if(isDefined(var_0)) {
    var_0 = tolower(var_0);
    var_6 = lookupsoundlength(var_0, 1) / 1000;

    if(isDefined(var_5)) {
      wait var_5;
    }

    var_2 queuedialogforplayer(var_0, var_1, var_6);
    return;
  }
}