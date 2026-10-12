/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchdata.gsc
***********************************************/

#using script_3f8889c16399185c;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;
#using scripts\mp\rank;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\weaponrank;
#namespace matchdata;

function init() {
  if(getdvarint(@ "online_matchdata_enabled") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdatadef("ddl/mp/matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);

    if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
      tmp = getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", tmp);
    } else {
      setmatchdata("commonMatchData", "gametype", getgametype());
    }

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", privatematch());
    setmatchdata("firstOvertimeRoundIndex", -1);

    if(ismlgmatch()) {
      setmatchdata("codESportsRules", 1);
    }
  }

  if(getdvarint(@ "online_matchdata_enabled") != 0) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      level.maxlogclients = 200;
    } else {
      level.maxlogclients = 30;
    }
  } else {
    level.maxlogclients = 0;
  }

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
  level.matchdata_onroundend = &onroundend;
  level.matchdata_logkillstreakevent = &logkillstreakevent;
  level.matchdata_logattackerkillevent = &logattackerkillevent;
  level.matchdata_logvictimkillevent = &logvictimkillevent;
  level.matchdata_logmultikill = &logmultikill;
  level.matchdata_logplayerdata = &logplayerdata;
  level.matchdata_recordrecentlyplayeddata = &recordrecentlyplayeddata;
  level.matchdata_logattachmentstat = &logattachmentstat;
  level.matchdata_buildweaponrootlist = &buildweaponrootlist;
  level.matchdata_logchallenge = &logchallenge;
  level.matchdata_logaward = &logaward;
  level thread endofgamesummarylogger();
}

function onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("commonMatchData", "utc_end_time_s", level.endtimeutcseconds);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(scripts\mp\rank::getglobalrankxpmultiplier()));
  setmatchdata("globalWeaponXpModifier", int(scripts\mp\weaponrank::getglobalweaponrankxpmultiplier()));
}

function getmatchstarttimeutc() {
  if(getdvarint(@ "online_matchdata_enabled") == 0) {
    return level.starttimeutcseconds;
  }

  return getmatchdata("commonMatchData", "utc_start_time_s");
}

function getmatchendtimeutc() {
  if(getdvarint(@ "online_matchdata_enabled") == 0) {
    return level.endtimeutcseconds;
  }

  return getmatchdata("commonMatchData", "utc_end_time_s");
}

function gettimefrommatchstart(basetime) {
  timefrom = basetime;

  if(isDefined(level.starttimefrommatchstart)) {
    timefrom -= level.starttimefrommatchstart;

    if(timefrom < 0) {
      timefrom = 0;
    }
  } else {
    timefrom = 0;
  }

  return timefrom;
}

function logkillstreakevent(event, position) {
  println("<dev string:x1c>");
}

function logattackerkillevent(lifeid, eventref) {
  println("<dev string:x6c>");
}

function logvictimkillevent(lifeid, eventref) {
  println("<dev string:xda>");
}

function logmultikill(lifeid, multikillcount) {
  println("<dev string:x146>");
}

function monitorweaponfire() {
  self endon("death_or_disconnect");

  while(true) {
    self waittill("begin_firing");
    thread monitorweaponfiretime();
    weaponobj = self.lastdroppableweaponobj;
    weaponobj = mapweapon(weaponobj);
    sweapon = getcompleteweaponname(weaponobj);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(sweapon, 1, "trigger_pulls");
  }
}

function monitorweaponfiretime() {
  self endon("disconnect");
  self.lastweaponfiretimestart = gettime();
  self notify("monitorWeaponFireTime");
  self endon("monitorWeaponFireTime");
  waittill_either("end_firing", "death");
  self.lastweaponfiretimeend = gettime();
}

function ctgs_recordmatchstats() {
  if(!onlinestatsenabled()) {
    return;
  }

  if(!rankingenabled()) {
    return;
  }

  if(!self hasplayerdata()) {
    return;
  }

  gamemode = getgametype();
  kills = getpersstat("kills");
  deaths = getpersstat("deaths");
  headshots = getpersstat("headshots");
  assists = getpersstat("assists");
  suicides = getpersstat("suicides");
  score = getpersstat("score");
  rankxp = getrankxp();
  rank = getrankforxp(rankxp);
  timejoined = self.pers["telemetry"].utc_connect_time_s;
  timeplayed = getsystemtime() - timejoined;
  self ctgsreportusermatchstats(gamemode, kills, deaths, headshots, assists, suicides, score, rank, timeplayed);
}

function logplayerdata(disconnectreason) {
  if(!isvalidclient(self)) {
    return;
  }

  ctgs_recordmatchstats();
  self sendclientnetworktelemetry();
  self sendcollectedclientanticheatdata();
  shots = 0;
  hits = 0;

  foreach(datastruct in self.pers["matchdataWeaponStats"]) {
    var_75e61e9afcfd1e96 = 0;
    var_e1e89bd150d2b6e5 = 0;
    vardeaths = 0;
    varheadshots = 0;
    varhits = 0;
    varkills = 0;
    var_c4530fef629dd385 = 0;
    varshots = 0;
    vartimeused = 0;
    vardamage = 0;
    varfriendlydamage = 0;

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(isenumvaluevalid("common", "LoadoutWeapon", datastruct.weapon)) {
        var_75e61e9afcfd1e96 = self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", datastruct.weapon);
      }
    }

    foreach(statname, value in datastruct.stats) {
      if(statname == "deaths") {
        vardeaths += value;
      }

      if(statname == "headshots") {
        varheadshots += value;
      }

      if(statname == "hits") {
        varhits += value;
        hits += value;
      }

      if(statname == "ads_kills") {
        var_c4530fef629dd385 += value;
      }

      if(statname == "kills") {
        varkills += value;
      }

      if(statname == "shots") {
        varshots += value;
        shots += value;
      }

      if(statname == "xp_earned") {
        var_e1e89bd150d2b6e5 += value;
      }

      if(statname == "damage") {
        vardamage += value;
      }

      if(statname == "friendly_fire_damage") {
        varfriendlydamage += value;
      }
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      weapongroup = weapon::getweapongroup(datastruct.weapon);
      self dlog_recordplayerevent("dlog_event_mp_player_weapon_stats", ["weapon", datastruct.weapon, "variant_id", datastruct.variantid, "loadout_index", datastruct.loadoutindex, "starting_weapon_xp", var_75e61e9afcfd1e96, "xp_earned", var_e1e89bd150d2b6e5, "deaths", vardeaths, "headshots", varheadshots, "hits", varhits, "kills", varkills, "ads_kills", var_c4530fef629dd385, "shots", varshots, "timeUsed", vartimeused, "damage", vardamage, "friendly_fire_damage", varfriendlydamage, "weapon_group", weapongroup]);
    }
  }
}

function endofgamesummarylogger() {
  level waittill("game_ended", winner);

  if(istrue(level.var_10a1699461d4ad08)) {
    return;
  }

  foreach(player in level.players) {
    wait 0.05;

    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.challengescompleted)) {
      player setplayerdata("common", "round", "challengeNumCompleted", player.challengescompleted.size);
    } else {
      player setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(i = 0; i < 20; i++) {
      if(isDefined(player.challengescompleted) && isDefined(player.challengescompleted[i]) && player.challengescompleted[i] != "ch_prestige" && !issubstr(player.challengescompleted[i], "_daily") && !issubstr(player.challengescompleted[i], "_weekly")) {
        player setplayerdata("common", "round", "challengesCompleted", i, player.challengescompleted[i]);
        continue;
      }

      player setplayerdata("common", "round", "challengesCompleted", i, "ch_none");
    }

    current_map = tolower(getDvar(@ "g_mapname"));
    var_329a74732d424f82 = getbasegametype();

    if(var_329a74732d424f82 == "defuse") {
      var_329a74732d424f82 = "sd";
    }

    player setplayerdata("common", "round", "gameMode", var_329a74732d424f82);
    player setplayerdata("common", "round", "map", current_map);
  }
}

function recordrecentlyplayeddata() {
  if(matchmakinggame()) {
    currentmap = tolower(getDvar(@ "g_mapname"));

    foreach(player in level.players) {
      for(i = 4; i > 0; i--) {
        map = player getplayerdata(level.progressiongroup, "mapsPlayed", i - 1);
        player setplayerdata(level.progressiongroup, "mapsPlayed", i, map);
      }

      player setplayerdata(level.progressiongroup, "mapsPlayed", 0, currentmap);
    }
  }
}

function isvalidclient(client) {
  if(istrue(game["isLaunchChunk"])) {
    return false;
  }

  if(!isDefined(client)) {
    return false;
  } else if(isagent(client)) {
    return false;
  } else if(!isPlayer(client)) {
    return false;
  }

  return true;
}

function canlogclient(client) {
  if(isvalidclient(client)) {
    return (client.clientid < level.maxlogclients);
  }

  return 0;
}

function canloglife(lifeid) {
  return lifeid < level.maxlives;
}

function logattachmentstat(attachname, statname, incvalue, weapon) {
  if(!level.matchdataattachmentstatsenabled) {
    return;
  }

  println("<dev string:x16c>");
}

function logchallenge(challengename, tier) {
  println("<dev string:x197>");
}

function logaward(awardname) {
  if(!isvalidclient(self)) {
    return;
  }

  if(isbot(self) || istestclient(self) || isai(self)) {
    return;
  }

  time_ms = gettimefrommatchstart(gettime());

  if(isxhash(awardname)) {
    awardname = getxhashhexname(awardname);
  }

  self dlog_recordplayerevent("dlog_event_player_award", ["time_ms_from_match_start", time_ms, "award", awardname]);
}