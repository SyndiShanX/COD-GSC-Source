/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_target_utility.gsc
******************************************************/

function init() {
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
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "shouldNukeEndGame", &ref_11ef3);
}

function ref_11eea(var0) {
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var0);
}

function ref_11eeb() {
  return scripts\cp\cp_hostmigration::waittillhostmigrationdone();
}

function nuke_delayendgame(var0, var1) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
}

function ref_11edd(var0, var1, var2) {}

function nuke_cankill(var0, var1) {
  if(istrue(level.blocknukekills)) {
    return false;
  }

  if(!isDefined(level.nukeinfo)) {
    return false;
  }

  if(istrue(var1)) {
    return true;
  }

  if(level.teambased) {
    if(isDefined(level.nukeinfo.team) && var0.team == level.nukeinfo.team) {
      return false;
    }
  } else {
    var2 = isDefined(level.nukeinfo.player) && var0 == level.nukeinfo.player;
    var3 = isDefined(level.nukeinfo.player) && isDefined(var0.owner) && var0.owner == level.nukeinfo.player;

    if(var2 || var3) {
      return false;
    }
  }

  return true;
}

function nuke_destroyactiveobjects(var0) {
  var1 = "nuke_mp";
  var2 = level.activekillstreaks;
  var3 = [[level.getactiveequipmentarray]]();
  var4 = undefined;

  if(isDefined(var2) && isDefined(var3)) {
    var4 = scripts\engine\utility::array_combine_unique(var2, var3);
  } else if(isDefined(var2)) {
    var4 = var2;
  } else if(isDefined(var3)) {
    var4 = var3;
  }

  if(isDefined(var4)) {
    foreach(var6 in var4) {
      if(isDefined(var6)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
          var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, level.nukeinfo.player, level.nukeinfo.player, var0, var6.origin, "MOD_EXPLOSIVE", var1);
        }
      }
    }

    return;
  }
}

function nuke_isplayerinradzone(var0, var1, var2) {
  var3 = distance2dsquared(var1, var0.origin);
  return var3 < var2;
}

function ref_11eec(var0) {
  if(!isPlayer(var0)) {
    var0 suicide();
    return;
  }

  var1 = getcompleteweaponname("nuke_mp");
  var2 = vectorNormalize(var0.origin + (0, 0, 1000) - level.nuke_inflictor.origin);
  var0 thread scripts\cp\cp_damage::finishplayerdamagewrapper(level.nuke_inflictor, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", var1, var0.origin, var2, "none", 0, 0, undefined, undefined);
}

function ref_11eed(var0) {
  var1 = level.nukeinfo.player;

  if(level.teambased && var0.team == var1.team) {
    var1 = var0;
  }

  var2 = getcompleteweaponname("nuke_mp");
  var0 dodamage(999999, level.nuke_inflictor.origin, var1, level.nuke_inflictor, "MOD_EXPLOSIVE", var2, "none");
}

function ref_11ef7(var0) {
  return undefined;
}

function ref_11ef3() {
  return false;
}