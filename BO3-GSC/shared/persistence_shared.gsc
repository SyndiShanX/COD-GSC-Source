/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\persistence_shared.gsc
*************************************************/

#using scripts\shared\bots\_bot;
#using scripts\shared\callbacks_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace persistence;

function autoexec __init__sytem__() {
  system::register("persistence", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

function init() {
  level.can_set_aar_stat = 1;
  level.persistentdatainfo = [];
  level.maxrecentstats = 10;
  level.maxhitlocations = 19;
  level thread initialize_stat_tracking();
  level thread upload_global_stat_counters();
}

function on_player_connect() {
  self.enabletext = 1;
}

function initialize_stat_tracking() {
  level.globalexecutions = 0;
  level.globalchallenges = 0;
  level.globalsharepackages = 0;
  level.globalcontractsfailed = 0;
  level.globalcontractspassed = 0;
  level.globalcontractscppaid = 0;
  level.globalkillstreakscalled = 0;
  level.globalkillstreaksdestroyed = 0;
  level.globalkillstreaksdeathsfrom = 0;
  level.globallarryskilled = 0;
  level.globalbuzzkills = 0;
  level.globalrevives = 0;
  level.globalafterlifes = 0;
  level.globalcomebacks = 0;
  level.globalpaybacks = 0;
  level.globalbackstabs = 0;
  level.globalbankshots = 0;
  level.globalskewered = 0;
  level.globalteammedals = 0;
  level.globalfeetfallen = 0;
  level.globaldistancesprinted = 0;
  level.globaldembombsprotected = 0;
  level.globaldembombsdestroyed = 0;
  level.globalbombsdestroyed = 0;
  level.globalfraggrenadesfired = 0;
  level.globalsatchelchargefired = 0;
  level.globalshotsfired = 0;
  level.globalcrossbowfired = 0;
  level.globalcarsdestroyed = 0;
  level.globalbarrelsdestroyed = 0;
  level.globalbombsdestroyedbyteam = [];
  foreach(team in level.teams) {
    level.globalbombsdestroyedbyteam[team] = 0;
  }
}

function upload_global_stat_counters() {
  level waittill("game_ended");
  if(!level.rankedmatch && !level.wagermatch) {
    return;
  }
  totalkills = 0;
  totaldeaths = 0;
  totalassists = 0;
  totalheadshots = 0;
  totalsuicides = 0;
  totaltimeplayed = 0;
  totalflagscaptured = 0;
  totalflagsreturned = 0;
  totalhqsdestroyed = 0;
  totalhqscaptured = 0;
  totalsddefused = 0;
  totalsdplants = 0;
  totalhumiliations = 0;
  totalsabdestroyedbyteam = [];
  foreach(team in level.teams) {
    totalsabdestroyedbyteam[team] = 0;
  }
  switch (level.gametype) {
    case "dem": {
      bombzonesleft = 0;
      for(index = 0; index < level.bombzones.size; index++) {
        if(!isDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
          level.globaldembombsprotected++;
          continue;
        }
        level.globaldembombsdestroyed++;
      }
      break;
    }
    case "sab": {
      foreach(team in level.teams) {
        totalsabdestroyedbyteam[team] = level.globalbombsdestroyedbyteam[team];
      }
      break;
    }
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(isDefined(player.timeplayed) && isDefined(player.timeplayed["total"])) {
      totaltimeplayed = totaltimeplayed + min(player.timeplayed["total"], level.timeplayedcap);
    }
  }
  if(!util::waslastround()) {
    return;
  }
  wait(0.05);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    totalkills = totalkills + player.kills;
    totaldeaths = totaldeaths + player.deaths;
    totalassists = totalassists + player.assists;
    totalheadshots = totalheadshots + player.headshots;
    totalsuicides = totalsuicides + player.suicides;
    totalhumiliations = totalhumiliations + player.humiliated;
    if(isDefined(player.timeplayed) && isDefined(player.timeplayed["alive"])) {
      totaltimeplayed = totaltimeplayed + int(min(player.timeplayed["alive"], level.timeplayedcap));
    }
    switch (level.gametype) {
      case "ctf": {
        totalflagscaptured = totalflagscaptured + player.captures;
        totalflagsreturned = totalflagsreturned + player.returns;
        break;
      }
      case "koth": {
        totalhqsdestroyed = totalhqsdestroyed + player.destructions;
        totalhqscaptured = totalhqscaptured + player.captures;
        break;
      }
      case "sd": {
        totalsddefused = totalsddefused + player.defuses;
        totalsdplants = totalsdplants + player.plants;
        break;
      }
      case "sab": {
        if(isDefined(player.team) && isDefined(level.teams[player.team])) {
          totalsabdestroyedbyteam[player.team] = totalsabdestroyedbyteam[player.team] + player.destructions;
        }
        break;
      }
    }
  }
}

function stat_get_with_gametype(dataname) {
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return 0;
  }
  if(!level.onlinegame) {
    return 0;
  }
  return self getdstat("PlayerStatsByGameType", get_gametype_name(), dataname, "StatValue");
}

function get_gametype_name() {
  if(!isDefined(level.fullgametypename)) {
    if(isDefined(level.hardcoremode) && level.hardcoremode && is_party_gamemode() == 0) {
      prefix = "HC";
    } else {
      prefix = "";
    }
    level.fullgametypename = tolower(prefix + level.gametype);
  }
  return level.fullgametypename;
}

function is_party_gamemode() {
  switch (level.gametype) {
    case "gun":
    case "oic":
    case "sas":
    case "shrp": {
      return true;
      break;
    }
  }
  return false;
}

function is_stat_modifiable(dataname) {
  return level.rankedmatch || level.wagermatch;
}

function stat_set_with_gametype(dataname, value, incvalue) {
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return false;
  }
  if(!is_stat_modifiable(dataname)) {
    return;
  }
  if(level.disablestattracking) {
    return;
  }
  self setdstat("PlayerStatsByGameType", get_gametype_name(), dataname, "StatValue", value);
}

function adjust_recent_stats() {
  if(getdvarint("") == 1 || getdvarint("") == 1) {
    return;
  }
  initialize_match_stats();
}

function get_recent_stat(isglobal, index, statname) {
  if(level.wagermatch) {
    return self getdstat("RecentEarnings", index, statname);
  }
  if(isglobal) {
    modename = util::getcurrentgamemode();
    return self getdstat("gameHistory", modename, "matchHistory", index, statname);
  }
  return self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScores", index, statname);
}

function set_recent_stat(isglobal, index, statname, value) {
  if(!isglobal) {
    index = self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScoreIndex");
    if(index < 0 || index > 9) {
      return;
    }
  }
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }
  if(!level.onlinegame) {
    return;
  }
  if(!is_stat_modifiable(statname)) {
    return;
  }
  if(level.wagermatch) {
    self setdstat("RecentEarnings", index, statname, value);
  } else {
    if(isglobal) {
      modename = util::getcurrentgamemode();
      self setdstat("gameHistory", modename, "matchHistory", "" + index, statname, value);
    } else {
      self setdstat("PlayerStatsByGameType", get_gametype_name(), "prevScores", index, statname, value);
    }
  }
}

function add_recent_stat(isglobal, index, statname, value) {
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }
  if(!level.onlinegame) {
    return;
  }
  if(!is_stat_modifiable(statname)) {
    return;
  }
  if(!isglobal) {
    index = self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScoreIndex");
    if(index < 0 || index > 9) {
      return;
    }
  }
  currstat = get_recent_stat(isglobal, index, statname);
  set_recent_stat(isglobal, index, statname, currstat + value);
}

function set_match_history_stat(statname, value) {
  modename = util::getcurrentgamemode();
  historyindex = self getdstat("gameHistory", modename, "currentMatchHistoryIndex");
  set_recent_stat(1, historyindex, statname, value);
}

function add_match_history_stat(statname, value) {
  modename = util::getcurrentgamemode();
  historyindex = self getdstat("gameHistory", modename, "currentMatchHistoryIndex");
  add_recent_stat(1, historyindex, statname, value);
}

function initialize_match_stats() {
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }
  if(!level.onlinegame) {
    return;
  }
  if(!(level.rankedmatch || level.wagermatch || level.leaguematch)) {
    return;
  }
  self.pers["lastHighestScore"] = self getdstat("HighestStats", "highest_score");
  if(sessionmodeismultiplayergame()) {
    self.pers["lastHighestKills"] = self getdstat("HighestStats", "highest_kills");
    self.pers["lastHighestKDRatio"] = self getdstat("HighestStats", "highest_kdratio");
  }
  currgametype = get_gametype_name();
  self gamehistorystartmatch(getgametypeenumfromname(currgametype, level.hardcoremode));
}

function can_set_aar_stat() {
  return level.can_set_aar_stat;
}

function set_after_action_report_player_stat(playerindex, statname, value) {
  if(can_set_aar_stat()) {
    self setdstat("AfterActionReportStats", "playerStats", playerindex, statname, value);
  }
}

function set_after_action_report_player_medal(playerindex, medalindex, value) {
  if(can_set_aar_stat()) {
    self setdstat("AfterActionReportStats", "playerStats", playerindex, "medals", medalindex, value);
  }
}

function set_after_action_report_stat(statname, value, index) {
  if(self util::is_bot()) {
    return;
  }
  if(getdvarint("") == 1 || getdvarint("") == 1) {
    return;
  }
  if(can_set_aar_stat()) {
    if(isDefined(index)) {
      self setaarstat(statname, index, value);
    } else {
      self setaarstat(statname, value);
    }
  }
}

function codecallback_challengecomplete(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex) {
  params = spawnStruct();
  params.rewardxp = rewardxp;
  params.maxval = maxval;
  params.row = row;
  params.tablenumber = tablenumber;
  params.challengetype = challengetype;
  params.itemindex = itemindex;
  params.challengeindex = challengeindex;
  if(sessionmodeiscampaigngame()) {
    if(isDefined(self.challenge_callback_cp)) {
      [
        [self.challenge_callback_cp]
      ](rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex);
    }
    return;
  }
  callback::callback("hash_b286c65c", params);
  self luinotifyevent(&"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
  self luinotifyeventtospectators(&"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
  tablenumber = tablenumber + 1;
  tablename = (("gamedata/stats/mp/statsmilestones") + tablenumber) + ".csv";
  challengestring = tablelookupcolumnforrow(tablename, row, 5);
  challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
  matchrecordlogchallengecomplete(self, tablenumber, challengetier, itemindex, challengestring);
  if(getdvarint("", 0) != 0) {
    challengedescstring = challengestring + "";
    challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
    tiertext = "" + challengetier;
    statstablename = "";
    herostring = tablelookup(statstablename, 0, itemindex, 3);
    if(getdvarint("") == 1) {
      iprintlnbold((((makelocalizedstring(challengestring) + "") + maxval) + "") + makelocalizedstring(herostring));
    } else {
      if(getdvarint("") == 2) {
        self iprintlnbold((((makelocalizedstring(challengestring) + "") + maxval) + "") + makelocalizedstring(herostring));
      } else if(getdvarint("") == 3) {
        iprintln((((makelocalizedstring(challengestring) + "") + maxval) + "") + makelocalizedstring(herostring));
      }
    }
  }
}

function codecallback_gunchallengecomplete(rewardxp, attachmentindex, itemindex, rankid, islastrank) {
  if(sessionmodeiscampaigngame()) {
    self notify("gun_level_complete", rewardxp, attachmentindex, itemindex, rankid, islastrank);
    return;
  }
  self luinotifyevent(&"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
  self luinotifyeventtospectators(&"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
}

function check_contract_expirations() {}

function increment_contract_times(timeinc) {}

function add_contract_to_queue(index, passed) {}

function upload_stats_soon() {
  self notify("upload_stats_soon");
  self endon("upload_stats_soon");
  self endon("disconnect");
  wait(1);
  uploadstats(self);
}

function codecallback_onaddplayerstat(dataname, value) {}

function codecallback_onaddweaponstat(weapon, dataname, value) {}

function process_contracts_on_add_stat(stattype, dataname, value, weapon) {}