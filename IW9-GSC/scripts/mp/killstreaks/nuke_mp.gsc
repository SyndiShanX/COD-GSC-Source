/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\nuke_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("nuke", scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("nuke_select_location", scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("nuke_multi", scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "hostmigration_waitLongDurationWithPause", ::nuke_hostmigration_waitlongdurationwithpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "hostmigration_waitTillHostMigrationDone", ::nuke_hostmigration_waittillhostmigrationdone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "delayEndGame", ::nuke_delayendgame);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "addTeamRankXPMultiplier", ::nuke_addteamrankxpmultiplier);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "cankill", ::nuke_cankill);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "killPlayer", ::nuke_killplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "killPlayerWithAttacker", ::nuke_killplayerwithattacker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "destroyActiveObjects", ::nuke_destroyactiveobjects);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "isPlayerInRadZone", ::nuke_isplayerinradzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("nuke", "stopTheClock", ::nuke_stoptheclock);
}

nuke_hostmigration_waitlongdurationwithpause(delay) {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(delay);
}

nuke_hostmigration_waittillhostmigrationdone() {
  return scripts\mp\hostmigration::waittillhostmigrationdone();
}

nuke_delayendgame(_id_74B5B12BB6514385, winner) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  if(istrue(level.mercywintriggered))
    level thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 1, 1);
  else
    level thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["nuke_end"], undefined, 1);
}

nuke_addteamrankxpmultiplier(_id_98EA5AFB293A76A2, team, ref) {
  scripts\mp\rank::addteamrankxpmultiplier(_id_98EA5AFB293A76A2, team, ref);
}

nuke_cankill(_id_7DC3241E7F3C6B24, _id_CFC1A4C269CFFB70) {
  if(istrue(level.blocknukekills))
    return 0;

  if(!isDefined(level.nukeinfo))
    return 0;

  if(istrue(_id_CFC1A4C269CFFB70))
    return 1;

  if(level.teambased) {
    if(isDefined(level.nukeinfo.team) && _id_7DC3241E7F3C6B24.team == level.nukeinfo.team)
      return 0;
  } else {
    _id_0F82034C88ACA0F2 = isDefined(level.nukeinfo.player) && _id_7DC3241E7F3C6B24 == level.nukeinfo.player;
    _id_F1BDB76B8FBF0F45 = isDefined(level.nukeinfo.player) && isDefined(_id_7DC3241E7F3C6B24.owner) && _id_7DC3241E7F3C6B24.owner == level.nukeinfo.player;

    if(_id_0F82034C88ACA0F2 || _id_F1BDB76B8FBF0F45)
      return 0;
  }

  return 1;
}

nuke_destroyactiveobjects(team) {
  _id_6C845D64BE969CE8 = level.activekillstreaks;
  _id_98FA4B76D957B210 = [[level.getactiveequipmentarray]]();
  _id_34CA454BBEC477F1 = undefined;

  if(isDefined(_id_6C845D64BE969CE8) && isDefined(_id_98FA4B76D957B210))
    _id_34CA454BBEC477F1 = scripts\engine\utility::array_combine_unique(_id_6C845D64BE969CE8, _id_98FA4B76D957B210);
  else if(isDefined(_id_6C845D64BE969CE8))
    _id_34CA454BBEC477F1 = _id_6C845D64BE969CE8;
  else if(isDefined(_id_98FA4B76D957B210))
    _id_34CA454BBEC477F1 = _id_98FA4B76D957B210;

  if(isDefined(_id_34CA454BBEC477F1)) {
    foreach(object in _id_34CA454BBEC477F1) {
      if(isDefined(object)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak"))
          object[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, level.nukeinfo.player, level.nukeinfo.player, team, object.origin, "MOD_EXPLOSIVE", level.nukeinfo.weapon);
      }
    }
  }
}

nuke_isplayerinradzone(player, _id_456B8F0EA933D0E5, _id_87F8E6C7847115BA) {
  if(getdvarint("dvar_D5FD9067CAFB06B9") == 1)
    return 0;

  _id_5A3A7553B49C43F9 = distance2dsquared(_id_456B8F0EA933D0E5, player.origin);
  return _id_5A3A7553B49C43F9 < _id_87F8E6C7847115BA;
}

nuke_killplayer(_id_7DC3241E7F3C6B24) {
  if(isPlayer(_id_7DC3241E7F3C6B24)) {
    objweapon = makeweapon(level.nukeinfo.weapon);
    scripts\mp\damage::addattacker(_id_7DC3241E7F3C6B24, level.nukeinfo.player, undefined, objweapon, 0, undefined, undefined, undefined, undefined, undefined);
    _id_3BE1B771648E3C2D = vectorNormalize(_id_7DC3241E7F3C6B24.origin + (0, 0, 1000) - level.nukeinfo.inflictor.origin);
    _id_7DC3241E7F3C6B24 thread scripts\mp\damage::finishplayerdamagewrapper(level.nukeinfo.inflictor, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", objweapon, _id_7DC3241E7F3C6B24.origin, _id_3BE1B771648E3C2D, "none", 0, 0, undefined, undefined);
  }
}

nuke_killplayerwithattacker(_id_7DC3241E7F3C6B24) {
  _id_705CC2040029EDB7 = level.nukeinfo.player;

  if(level.teambased && _id_7DC3241E7F3C6B24.team == _id_705CC2040029EDB7.team)
    _id_705CC2040029EDB7 = _id_7DC3241E7F3C6B24;

  objweapon = makeweapon(level.nukeinfo.weapon);
  _id_7DC3241E7F3C6B24 dodamage(999999, level.nukeinfo.inflictor.origin, _id_705CC2040029EDB7, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", objweapon, "none");
}

nuke_stoptheclock(gametype) {
  timelimit = _func_2EF675C13CA1C4AF("scr_", gametype, "_timelimit");
  level.watchdvars[timelimit].value = 0;
  level.overridewatchdvars[timelimit] = 0;
  level.extratime = 0;
  return timelimit;
}