/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58268.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("nuke", &_calloutmarkerping_handleluinotify_acknowledged::tryusenukefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("nuke_select_location", &_calloutmarkerping_handleluinotify_acknowledged::tryusenukefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "hostmigration_waitLongDurationWithPause", &ref_11eea);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "hostmigration_waitTillHostMigrationDone", &ref_11eeb);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "delayEndGame", &nuke_delayendgame);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "addTeamRankXPMultiplier", &ref_11edd);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "cankill", &nuke_cankill);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "killPlayer", &ref_11eec);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "killPlayerWithAttacker", &ref_11eed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "destroyActiveObjects", &nuke_destroyactiveobjects);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "isPlayerInRadZone", &nuke_isplayerinradzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "stopTheClock", &ref_11ef7);
}

function ref_11eea(var_0) {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

function ref_11eeb() {
  return scripts\mp\hostmigration::waittillhostmigrationdone();
}

function nuke_delayendgame(var_0, var_1) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(istrue(level.ref_11bd4)) {
    level thread scripts\mp\gamelogic::endgame(var_1, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 1, 1);
    return;
  }

  level thread scripts\mp\gamelogic::endgame(var_1, game["end_reason"]["nuke_end"], undefined, 1);
}

function ref_11edd(var_0, var_1, var_2) {
  scripts\mp\rank::addteamrankxpmultiplier(var_0, var_1, var_2);
}

function nuke_cankill(var_0, var_1) {
  if(istrue(level.blocknukekills)) {
    return false;
  }

  if(!isDefined(level.nukeinfo)) {
    return false;
  }

  if(istrue(var_1)) {
    return true;
  }

  if(level.teambased) {
    if(isDefined(level.nukeinfo.team) && var_0.team == level.nukeinfo.team) {
      return false;
    }
  } else {
    var_2 = isDefined(level.nukeinfo.player) && var_0 == level.nukeinfo.player;
    var_3 = isDefined(level.nukeinfo.player) && isDefined(var_0.owner) && var_0.owner == level.nukeinfo.player;

    if(var_2 || var_3) {
      return false;
    }
  }

  return true;
}

function nuke_destroyactiveobjects(var_0) {
  var_1 = "nuke_mp";
  var_2 = level.activekillstreaks;
  var_3 = [[level.getactiveequipmentarray]]();
  var_4 = undefined;

  if(isDefined(var_2) && isDefined(var_3)) {
    var_4 = scripts\engine\utility::array_combine_unique(var_2, var_3);
  } else if(isDefined(var_2)) {
    var_4 = var_2;
  } else if(isDefined(var_3)) {
    var_4 = var_3;
  }

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
          var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, level.nukeinfo.player, level.nukeinfo.player, var_0, var_6.origin, "MOD_EXPLOSIVE", var_1);
        }
      }
    }

    return;
  }
}

function nuke_isplayerinradzone(var_0, var_1, var_2) {
  var_3 = distance2dsquared(var_1, var_0.origin);
  return var_3 < var_2;
}

function ref_11eec(var_0) {
  if(isPlayer(var_0)) {
    var_1 = getcompleteweaponname("nuke_mp");
    scripts\mp\damage::addattacker(var_0, level.nukeinfo.player, undefined, var_1, 0, undefined, undefined, undefined, undefined, undefined);
    var_2 = vectorNormalize(var_0.origin + (0, 0, 1000) - level.nuke_inflictor.origin);
    var_0 thread scripts\mp\damage::finishplayerdamagewrapper(level.nuke_inflictor, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", var_1, var_0.origin, var_2, "none", 0, 0, undefined, undefined);
    return;
  }
}

function ref_11eed(var_0) {
  var_1 = level.nukeinfo.player;

  if(level.teambased && var_0.team == var_1.team) {
    var_1 = var_0;
  }

  var_2 = getcompleteweaponname("nuke_mp");
  var_0 dodamage(999999, level.nuke_inflictor.origin, var_1, level.nuke_inflictor, "MOD_EXPLOSIVE", var_2, "none");
}

function ref_11ef7(var_0) {
  var_1 = "scr_" + var_0 + "_timelimit";
  level.watchdvars[var_1].value = 0;
  level.overridewatchdvars[var_1] = 0;
  level.extratime = 0;
  return var_1;
}