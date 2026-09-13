/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\supply_sweep.gsc
***************************************************/

main() {
  level thread init();
}

init() {
  while(!isDefined(level.killstreaksetups))
    wait 1;

  waitframe();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("supply_sweep", ::_id_9770267C5FB4F3B3);
  initdialog();
  level thread _id_53CECC93D53FB16E();
}

initdialog() {
  game["dialog"]["supply_sweep_start"] = "trials_killstreak_supplysweep_start";
  game["dialog"]["supply_sweep_end"] = "trials_killstreak_supplysweep_end";
}

_id_53CECC93D53FB16E() {
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
    level.teamdata[level.teamnamelist[_id_AC0E594AC96AA3A8]]["activeSupplySweeps"] = [];
    level.teamdata[level.teamnamelist[_id_AC0E594AC96AA3A8]]["supplySweepEndTime"] = 0;
    level.teamdata[level.teamnamelist[_id_AC0E594AC96AA3A8]]["numSupplySweepKillstreakStarted"] = 0;
  }
}

_id_9770267C5FB4F3B3(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  _id_79710492B71B9E81 = undefined;

  if(istrue(level._id_975B837A4FFA005E))
    _id_79710492B71B9E81 = "KILLSTREAKS/AUAVSCAN_IN_PROGRESS";
  else if(istrue(self.hasradar))
    _id_79710492B71B9E81 = "KILLSTREAKS/UAV_SCAN_IN_PROGRESS";

  if(isDefined(_id_79710492B71B9E81)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](_id_79710492B71B9E81);

    return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_B1D9ABE0BA55BE9F = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(_id_B1D9ABE0BA55BE9F))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  level thread _id_CB5055EF9503457F(self, streakinfo);
  return 1;
}

_id_F881C4E02A77D4D7(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(!istrue(streakinfo._id_F7E9B63A09D59E0C)) {
    _id_8881166E57766E3A = "ks_gesture_generic_mp";
    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon(_id_8881166E57766E3A));

    if(!istrue(_id_9B1DEB5E9D32BBE3))
      return 0;
  }

  return 1;
}

_id_CB5055EF9503457F(owner, streakinfo, _id_79714ABDF73D508A) {
  team = owner.team;

  if(!istrue(_id_79714ABDF73D508A))
    _id_5EA457CBCC4810ED(owner, team, streakinfo);

  _id_84B4DD2D6D918790 = getdvarint("dvar_AE6A45F480E3B2DC", 20);
  _id_CD8090039A345A6E = level.teamdata[team]["activeSupplySweeps"].size > 0;
  _id_AF0411E158EBA42C = undefined;

  if(_id_CD8090039A345A6E)
    _id_AF0411E158EBA42C = level.teamdata[team]["supplySweepEndTime"] + _id_84B4DD2D6D918790 * 1000;
  else
    _id_AF0411E158EBA42C = gettime() + _id_84B4DD2D6D918790 * 1000;

  level.teamdata[team]["activeSupplySweeps"] = scripts\engine\utility::array_add(level.teamdata[team]["activeSupplySweeps"], streakinfo);
  level.teamdata[team]["supplySweepEndTime"] = _id_AF0411E158EBA42C;
  _id_9A35E6082031F3D4 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_9A35E6082031F3D4) {
    if(isDefined(player) && !player _id_2CEDCC356F1B9FC8::playeriszombie()) {
      player _meth_C682F38A22EA89D6(1);
      player playsoundtoplayer("activate_supply_sweep", player);
    }
  }

  _id_D90D9AC30239347E = level.teamdata[team]["activeSupplySweeps"].size >= 3;
  _id_BF750A843CAF9B55(_id_D90D9AC30239347E, team);
  _id_E634D5144976B8BA = max((_id_AF0411E158EBA42C - gettime()) / 1000.0, 0.1);
  scripts\engine\utility::waittill_any_timeout_1(_id_E634D5144976B8BA, "game_ended");
  level.teamdata[team]["activeSupplySweeps"] = scripts\engine\utility::array_remove(level.teamdata[team]["activeSupplySweeps"], streakinfo);
  _id_D90D9AC30239347E = level.teamdata[team]["activeSupplySweeps"].size >= 3;
  _id_BF750A843CAF9B55(_id_D90D9AC30239347E, team);
  _id_23D218EC402FC01C = level.teamdata[team]["activeSupplySweeps"].size == 0;

  if(_id_23D218EC402FC01C) {
    _id_9A35E6082031F3D4 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in _id_9A35E6082031F3D4) {
      if(isDefined(player))
        player _meth_C682F38A22EA89D6(0);
    }
  } else {
    while(!_id_23D218EC402FC01C && !level.gameended) {
      _id_AF0411E158EBA42C = level.teamdata[team]["supplySweepEndTime"];
      _id_E634D5144976B8BA = max((_id_AF0411E158EBA42C - gettime()) / 1000.0, 0.1);
      scripts\engine\utility::waittill_any_timeout_1(_id_E634D5144976B8BA, "game_ended");
      _id_23D218EC402FC01C = level.teamdata[team]["activeSupplySweeps"].size == 0;
    }
  }

  if(!istrue(_id_79714ABDF73D508A))
    _id_5541A7C0F6747C86(owner, team, streakinfo);
}

_id_5EA457CBCC4810ED(owner, team, streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, owner.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_supply_sweep", owner);

  if(!istrue(level.gameended))
    _id_02617455BEBB5944(team, "supply_sweep_start");

  level.teamdata[team]["numSupplySweepKillstreakStarted"]++;
}

_id_5541A7C0F6747C86(owner, team, streakinfo) {
  level.teamdata[team]["numSupplySweepKillstreakStarted"]--;

  if(level.teamdata[team]["numSupplySweepKillstreakStarted"] == 0 && !istrue(level.gameended))
    _id_02617455BEBB5944(team, "supply_sweep_end");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  if(isDefined(owner) && !istrue(level.recordedgameendstats))
    owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + streakinfo.streakname, owner);
}

_id_8192E9B94C7BE3A6(player) {
  if(istrue(level._id_975B837A4FFA005E) || istrue(player.hasradar))
    return 0;

  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("supply_sweep", player);
  level thread _id_CB5055EF9503457F(player, streakinfo, 1);
  return 1;
}

_id_BF750A843CAF9B55(_id_E60552DD6ABCC4AA, team) {
  _id_9A35E6082031F3D4 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_9A35E6082031F3D4) {
    if(isDefined(player) && !player _id_2CEDCC356F1B9FC8::playeriszombie())
      player _meth_EF7982D1F82E7A51(_id_E60552DD6ABCC4AA);
  }
}

_id_02617455BEBB5944(team, dialog) {
  if(istrue(level.disableannouncer)) {
    return;
  }
  if(!isDefined(game["dialog"][dialog])) {
    return;
  }
  _id_CB3339ECE72DBDEB = "dx_bra_pilo_" + game["dialog"][dialog];
  _id_A6AB8D0FDA441DC2 = level.teamdata[team]["players"];

  foreach(player in _id_A6AB8D0FDA441DC2)
  thread _id_4138F41EAC3BB46F(_id_CB3339ECE72DBDEB, dialog, player, 1, 0);
}

_id_4138F41EAC3BB46F(_id_CB3339ECE72DBDEB, dialog, player, _id_A64CAD1ECC519617, _id_29B55B55D98A28F4, delay) {
  level endon("game_ended");

  if(!isDefined(player)) {
    return;
  }
  player endon("death_or_disconnect");

  if(!isalive(player) && !istrue(_id_29B55B55D98A28F4)) {
    return;
  }
  if(player _id_2CEDCC356F1B9FC8::modeplayerskipdialog(dialog, _id_A64CAD1ECC519617)) {
    return;
  }
  if(isDefined(_id_CB3339ECE72DBDEB)) {
    _id_CB3339ECE72DBDEB = tolower(_id_CB3339ECE72DBDEB);
    _id_1499E7C2D69E0074 = lookupsoundlength(_id_CB3339ECE72DBDEB, 1) / 1000.0;

    if(isDefined(delay))
      wait(delay);

    player queuedialogforplayer(_id_CB3339ECE72DBDEB, dialog, _id_1499E7C2D69E0074);
  }
}