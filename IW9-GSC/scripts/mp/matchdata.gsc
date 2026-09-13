/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchdata.gsc
***********************************************/

init() {
  if(getdvarint("online_matchdata_enabled") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdatadef("ddl/mp/matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);

    if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
      _id_E97B68032A8F5332 = scripts\mp\utility\game::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", _id_E97B68032A8F5332);
    } else
      setmatchdata("commonMatchData", "gametype", scripts\mp\utility\game::getgametype());

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", scripts\mp\utility\game::privatematch());
    setmatchdata("firstOvertimeRoundIndex", -1);

    if(scripts\mp\utility\game::ismlgmatch())
      setmatchdata("codESportsRules", 1);
  }

  if(getdvarint("online_matchdata_enabled") != 0) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      level.maxlogclients = 200;
    else
      level.maxlogclients = 30;
  } else
    level.maxlogclients = 0;

  level.maxlives = 475;
  level.maxnamelength = 26;
  level.maxgameevents = 250;
  level.maxkillstreaks = 64;
  level.maxkillstreaksavailable = 64;
  level.maxnumchallengesperplayer = 10;
  level.maxnumawardsperplayer = 10;
  level.maxsupersavailable = 50;
  level.maxsupersactivated = 50;
  level.maxsupersexpired = 50;
  level.matchdataattachmentstatsenabled = 0;
  level.matchdata_onroundend = ::onroundend;
  level.matchdata_logkillstreakevent = ::logkillstreakevent;
  level.matchdata_logattackerkillevent = ::logattackerkillevent;
  level.matchdata_logvictimkillevent = ::logvictimkillevent;
  level.matchdata_logmultikill = ::logmultikill;
  level.matchdata_logplayerdata = ::logplayerdata;
  level.matchdata_recordrecentlyplayeddata = ::recordrecentlyplayeddata;
  level.matchdata_logattachmentstat = ::logattachmentstat;
  level.matchdata_buildweaponrootlist = _id_2669878CF5A1B6BC::buildweaponrootlist;
  level.matchdata_logchallenge = ::logchallenge;
  level.matchdata_logaward = ::logaward;
  level thread endofgamesummarylogger();
}

onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("commonMatchData", "utc_end_time_s", level.endtimeutcseconds);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(scripts\mp\rank::getglobalrankxpmultiplier()));
  setmatchdata("globalWeaponXpModifier", int(scripts\mp\weaponrank::getglobalweaponrankxpmultiplier()));
}

getmatchstarttimeutc() {
  if(getdvarint("online_matchdata_enabled") == 0)
    return level.starttimeutcseconds;

  return getmatchdata("commonMatchData", "utc_start_time_s");
}

getmatchendtimeutc() {
  if(getdvarint("online_matchdata_enabled") == 0)
    return level.endtimeutcseconds;

  return getmatchdata("commonMatchData", "utc_end_time_s");
}

gettimefrommatchstart(basetime) {
  _id_FBDCFBD6233E2398 = basetime;

  if(isDefined(level.starttimefrommatchstart)) {
    _id_FBDCFBD6233E2398 = _id_FBDCFBD6233E2398 - level.starttimefrommatchstart;

    if(_id_FBDCFBD6233E2398 < 0)
      _id_FBDCFBD6233E2398 = 0;
  } else
    _id_FBDCFBD6233E2398 = 0;

  return _id_FBDCFBD6233E2398;
}

logkillstreakevent(event, position) {}

logattackerkillevent(lifeid, eventref) {}

logvictimkillevent(lifeid, eventref) {}

logmultikill(lifeid, _id_5FD73D74128A5E31) {}

monitorweaponfire() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("begin_firing");
    thread monitorweaponfiretime();
    weaponobj = self.lastdroppableweaponobj;
    weaponobj = scripts\mp\utility\weapon::mapweapon(weaponobj);
    sweapon = getcompleteweaponname(weaponobj);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(sweapon, 1, "trigger_pulls");
  }
}

monitorweaponfiretime() {
  self endon("disconnect");
  self.lastweaponfiretimestart = gettime();
  self notify("monitorWeaponFireTime");
  self endon("monitorWeaponFireTime");
  scripts\engine\utility::waittill_either("end_firing", "death");
  self.lastweaponfiretimeend = gettime();
}

ctgs_recordmatchstats() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(!self hasplayerdata()) {
    return;
  }
  gametype = scripts\mp\utility\game::getgametype();
  kills = scripts\mp\utility\stats::getpersstat("kills");
  deaths = scripts\mp\utility\stats::getpersstat("deaths");
  headshots = scripts\mp\utility\stats::getpersstat("headshots");
  assists = scripts\mp\utility\stats::getpersstat("assists");
  _id_05E5C27FCED1B958 = scripts\mp\utility\stats::getpersstat("suicides");
  score = scripts\mp\utility\stats::getpersstat("score");
  damage = scripts\mp\utility\stats::getpersstat("damage");
  damagetaken = scripts\mp\utility\stats::getpersstat("damageTaken");
  _id_B68C71585B47C517 = scripts\mp\utility\stats::getpersstat("longestStreak");
  _id_C5732E73897E110B = scripts\mp\rank::getrankxp();
  _id_00AE17C5A8B1BC1B = scripts\mp\rank::getrankforxp(_id_C5732E73897E110B);
  _id_A5DA089AD8A4E8B9 = self.pers["telemetry"]._id_72AC055B0A1C5D26;
  timeplayed = getsystemtime() - _id_A5DA089AD8A4E8B9;
  self ctgsreportusermatchstats(gametype, kills, deaths, headshots, assists, _id_05E5C27FCED1B958, score, damage, damagetaken, _id_B68C71585B47C517, _id_00AE17C5A8B1BC1B, timeplayed);
}

logplayerdata(_id_934DC135AAF6F953) {
  if(!isvalidclient(self)) {
    return;
  }
  ctgs_recordmatchstats();
  self sendclientnetworktelemetry();
  self sendcollectedclientanticheatdata();
  _id_58E50AEE46852766 = 0;
  hits = 0;

  foreach(key, _id_5842E592DDCEF384 in self.pers["matchdataWeaponStats"]) {
    _id_75E61E9AFCFD1E96 = 0;
    _id_E1E89BD150D2B6E5 = 0;
    _id_111DAE76DBEE9581 = 0;
    _id_4AC1D6453910F005 = 0;
    _id_2CD6C62534B95EB8 = 0;
    _id_08797207B95AE767 = 0;
    _id_C4530FEF629DD385 = 0;
    _id_BE9811F337918BA3 = 0;
    _id_474A6D79EF62CF1A = 0;
    _id_6EA7D87F1769FDB7 = 0;
    _id_53565C7950C80700 = 0;

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(isenumvaluevalid("common", "LoadoutWeapon", _id_5842E592DDCEF384.weapon))
        _id_75E61E9AFCFD1E96 = self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", _id_5842E592DDCEF384.weapon);
    }

    foreach(_id_629757F5C9E770D8, value in _id_5842E592DDCEF384.stats) {
      if(_id_629757F5C9E770D8 == "deaths")
        _id_111DAE76DBEE9581 = _id_111DAE76DBEE9581 + value;

      if(_id_629757F5C9E770D8 == "headshots")
        _id_4AC1D6453910F005 = _id_4AC1D6453910F005 + value;

      if(_id_629757F5C9E770D8 == "hits") {
        _id_2CD6C62534B95EB8 = _id_2CD6C62534B95EB8 + value;
        hits = hits + value;
      }

      if(_id_629757F5C9E770D8 == "ads_kills")
        _id_C4530FEF629DD385 = _id_C4530FEF629DD385 + value;

      if(_id_629757F5C9E770D8 == "kills")
        _id_08797207B95AE767 = _id_08797207B95AE767 + value;

      if(_id_629757F5C9E770D8 == "shots") {
        _id_BE9811F337918BA3 = _id_BE9811F337918BA3 + value;
        _id_58E50AEE46852766 = _id_58E50AEE46852766 + value;
      }

      if(_id_629757F5C9E770D8 == "xp_earned")
        _id_E1E89BD150D2B6E5 = _id_E1E89BD150D2B6E5 + value;

      if(_id_629757F5C9E770D8 == "damage")
        _id_6EA7D87F1769FDB7 = _id_6EA7D87F1769FDB7 + value;

      if(_id_629757F5C9E770D8 == "friendly_fire_damage")
        _id_53565C7950C80700 = _id_53565C7950C80700 + value;
    }

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      self dlog_recordplayerevent("dlog_event_mp_player_weapon_stats", ["weapon", _id_5842E592DDCEF384.weapon, "variant_id", _id_5842E592DDCEF384.variantid, "loadout_index", _id_5842E592DDCEF384.loadoutindex, "starting_weapon_xp", _id_75E61E9AFCFD1E96, "xp_earned", _id_E1E89BD150D2B6E5, "deaths", _id_111DAE76DBEE9581, "headshots", _id_4AC1D6453910F005, "hits", _id_2CD6C62534B95EB8, "kills", _id_08797207B95AE767, "ads_kills", _id_C4530FEF629DD385, "shots", _id_BE9811F337918BA3, "timeUsed", _id_474A6D79EF62CF1A, "damage", _id_6EA7D87F1769FDB7, "friendly_fire_damage", _id_53565C7950C80700]);
  }
}

endofgamesummarylogger() {
  level waittill("game_ended", winner);

  foreach(player in level.players) {
    wait 0.05;

    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.challengescompleted))
      player setplayerdata("common", "round", "challengeNumCompleted", player.challengescompleted.size);
    else
      player setplayerdata("common", "round", "challengeNumCompleted", 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 20; _id_AC0E594AC96AA3A8++) {
      if(isDefined(player.challengescompleted) && isDefined(player.challengescompleted[_id_AC0E594AC96AA3A8]) && player.challengescompleted[_id_AC0E594AC96AA3A8] != "ch_prestige" && !issubstr(player.challengescompleted[_id_AC0E594AC96AA3A8], "_daily") && !issubstr(player.challengescompleted[_id_AC0E594AC96AA3A8], "_weekly")) {
        player setplayerdata("common", "round", "challengesCompleted", _id_AC0E594AC96AA3A8, player.challengescompleted[_id_AC0E594AC96AA3A8]);
        continue;
      }

      player setplayerdata("common", "round", "challengesCompleted", _id_AC0E594AC96AA3A8, "ch_none");
    }

    _id_10D864DD73F88213 = tolower(getDvar("g_mapname"));
    player setplayerdata("common", "round", "gameMode", scripts\mp\utility\game::getgametype());
    player setplayerdata("common", "round", "map", _id_10D864DD73F88213);
  }
}

recordrecentlyplayeddata() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_7B8A8DDCC38832E8 = tolower(getDvar("g_mapname"));

    foreach(player in level.players) {
      for(_id_AC0E594AC96AA3A8 = 4; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
        _id_365929041E4386ED = player getplayerdata(level._id_5D69837CF4DB0407, "mapsPlayed", _id_AC0E594AC96AA3A8 - 1);
        player setplayerdata(level._id_5D69837CF4DB0407, "mapsPlayed", _id_AC0E594AC96AA3A8, _id_365929041E4386ED);
      }

      player setplayerdata(level._id_5D69837CF4DB0407, "mapsPlayed", 0, _id_7B8A8DDCC38832E8);
    }
  }
}

isvalidclient(_id_2C6CA80E296FED3A) {
  if(istrue(game["isLaunchChunk"]))
    return 0;

  if(!isDefined(_id_2C6CA80E296FED3A))
    return 0;
  else if(isagent(_id_2C6CA80E296FED3A))
    return 0;
  else if(!isPlayer(_id_2C6CA80E296FED3A))
    return 0;

  return 1;
}

canlogclient(_id_2C6CA80E296FED3A) {
  if(isvalidclient(_id_2C6CA80E296FED3A))
    return _id_2C6CA80E296FED3A.clientid < level.maxlogclients;
  else
    return 0;
}

canloglife(lifeid) {
  return lifeid < level.maxlives;
}

logattachmentstat(_id_FF180C307F2BAFD3, _id_629757F5C9E770D8, _id_A1D4E7D5EF9DA660, weapon) {
  if(!level.matchdataattachmentstatsenabled)
    return;
}

logchallenge(_id_33BE63BF54F72FA9, tier) {}

logaward(_id_84EA5CF2793332C1) {
  if(!isvalidclient(self)) {
    return;
  }
  if(isbot(self) || istestclient(self) || isai(self)) {
    return;
  }
  _id_16FBC6A2229D1D81 = gettimefrommatchstart(gettime());

  if(_func_D03495FE6418377B(_id_84EA5CF2793332C1))
    _id_84EA5CF2793332C1 = _func_0F28FD66285FA2C9(_id_84EA5CF2793332C1);

  self dlog_recordplayerevent("dlog_event_player_award", ["time_ms_from_match_start", _id_16FBC6A2229D1D81, "award", _id_84EA5CF2793332C1]);
}