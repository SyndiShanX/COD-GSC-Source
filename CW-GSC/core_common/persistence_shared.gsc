/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\persistence_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace persistence;

function private autoexec __init__system__() {
  system::register(#"persistence", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {
  level.persistentdatainfo = [];
  level.maxrecentstats = 10;
  level.maxhitlocations = 19;
  level thread initialize_stat_tracking();
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

  foreach(team, _ in level.teams) {
    level.globalbombsdestroyedbyteam[team] = 0;
  }
}

function adjust_recent_stats() {
  if(getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

  initialize_match_stats();
}

function function_acac764e() {
  index = self stats::get_stat(#"playerstatsbygametype", stats::function_8921af36(), #"prevscoreindex");

  if(!isDefined(index)) {
    return;
  }

  if(index < 0 || index > 9) {
    return;
  }

  newindex = (index + 1) % 10;
  self.pers[# "hash_76fbbcf94dab5536"] = newindex;
  self stats::set_stat(#"playerstatsbygametype", stats::function_8921af36(), #"prevscoreindex", newindex);
}

function get_recent_stat(isglobal, index, statname) {
  if(!isDefined(index)) {
    return;
  }

  if(isglobal) {
    modename = level.var_12323003;
    return self stats::get_stat(#"gamehistory", modename, #"matchhistory", index, statname);
  }

  return self stats::get_stat(#"playerstatsbygametype", stats::function_8921af36(), #"prevscores", index, statname);
}

function set_recent_stat(isglobal, index, statname, value) {
  if(!isglobal) {
    index = self stats::get_stat(#"playerstatsbygametype", stats::function_8921af36(), #"prevscoreindex");

    if(!isDefined(index)) {
      return;
    }

    if(index < 0 || index > 9) {
      return;
    }
  }

  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }

  if(!isDefined(index)) {
    return;
  }

  if(isglobal) {
    modename = level.var_12323003;
    self stats::set_stat(#"gamehistory", modename, #"matchhistory", "" + index, statname, value);
    return;
  }

  self stats::set_stat(#"playerstatsbygametype", stats::function_8921af36(), #"prevscores", index, statname, value);
}

function add_recent_stat(isglobal, index, statname, value) {
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }

  if(!isglobal) {
    index = self stats::get_stat(#"playerstatsbygametype", stats::function_8921af36(), #"prevscoreindex");

    if(!isDefined(index)) {
      return;
    }

    if(index < 0 || index > 9) {
      return;
    }
  }

  if(!isDefined(index)) {
    return;
  }

  currstat = get_recent_stat(isglobal, index, statname);

  if(isDefined(currstat)) {
    set_recent_stat(isglobal, index, statname, currstat + value);
  }
}

function set_match_history_stat(statname, value) {
  modename = level.var_12323003;
  historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
  set_recent_stat(1, historyindex, statname, value);
}

function add_match_history_stat(statname, value) {
  modename = level.var_12323003;
  historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
  add_recent_stat(1, historyindex, statname, value);
}

function initialize_match_stats() {
  self endon(#"disconnect");

  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }

  if(!level.onlinegame) {
    return;
  }

  if(!(level.rankedmatch || level.leaguematch)) {
    return;
  }

  if(sessionmodeiswarzonegame() || sessionmodeismultiplayergame()) {
    self stats::function_bb7eedf0(#"total_games_played", 1);

    if(is_true(level.hardcoremode)) {
      hc_games_played = self stats::get_stat(#"playerstatslist", #"hc_games_played", #"statvalue") + 1;
      self stats::set_stat(#"playerstatslist", #"hc_games_played", #"statvalue", hc_games_played);
    }
  }

  if(isDefined(level.var_12323003)) {
    self gamehistorystartmatch(level.var_12323003);
    return;
  }

  level.var_12323003 = level.gametype;
  self gamehistorystartmatch(getgametypeenumfromname(level.gametype, level.hardcoremode));
}

function event_handler[player_challengecomplete] codecallback_challengecomplete(eventstruct) {
  if(sessionmodeiscampaigngame()) {
    if(isDefined(self.challenge_callback_cp)) {
      [[self.challenge_callback_cp]](eventstruct.reward, eventstruct.max, eventstruct.row, eventstruct.table_number, eventstruct.challenge_type, eventstruct.item_index, eventstruct.challenge_index);
    }

    return;
  }

  self thread challenge_complete(eventstruct);
}

function function_6020a116() {
  if(!isDefined(level.var_697b1d55)) {
    level.var_697b1d55 = 0;
  }

  if(!isDefined(level.var_445b1bca)) {
    level.var_445b1bca = 0;
  }

  while(level.var_697b1d55 == gettime() || level.var_445b1bca == gettime()) {
    waitframe(1);
  }

  level.var_697b1d55 = gettime();
}

function challenge_complete(eventstruct) {
  self endon(#"disconnect");
  function_6020a116();
  callback::callback(#"on_challenge_complete", eventstruct);
  rewardxp = eventstruct.reward;
  maxval = eventstruct.max;
  row = eventstruct.row;
  tablenumber = eventstruct.table_number;
  challengetype = eventstruct.challenge_type;
  itemindex = eventstruct.item_index;
  challengeindex = eventstruct.challenge_index;
  var_c4e9517b = tablenumber + 1;

  if(currentsessionmode() == 0) {
    tablename = # "gamedata/stats/zm/statsmilestones" + var_c4e9517b + ".csv";

    if(var_c4e9517b == 2) {
      var_a05af556 = tablelookupcolumnforrow(tablename, row, 9);

      if(var_a05af556 === # "") {
        return;
      } else if(getdvarint(#"hash_730fab929626f598", 0) == 0) {
        if(var_a05af556 === # "camo_gold" || var_a05af556 === # "camo_diamond" || var_a05af556 === # "camo_darkmatter") {
          return;
        }
      }
    }
  } else {
    tablename = # "gamedata/stats/mp/statsmilestones" + var_c4e9517b + ".csv";
  }

  var_eb67c133 = tablelookupcolumnforrow(tablename, row, 5);

  if(isDefined(var_eb67c133) && (var_eb67c133 == # "hash_5a619f94abe000b" || var_eb67c133 == # "hash_4a80d584aac2e7d0")) {
    return;
  }

  var_54b50d64 = getdvarstring(#"hash_5f6f875e3935912a", "<dev string:x38>");

  if(var_54b50d64 != "<dev string:x38>") {
    challengecategory = tablelookupcolumnforrow(tablename, row, 16);

    if(challengecategory !== var_54b50d64) {
      return;
    }
  }

  var_5d5d13c3 = getdvarstring(#"hash_5941150fef84419c", "<dev string:x38>");

  if(var_5d5d13c3 != "<dev string:x38>") {
    challengestat = tablelookupcolumnforrow(tablename, row, 4);
    var_40fdd9a5 = ishash(challengestat) ? function_9e72a96(challengestat) : challengestat;

    if(!issubstr(tolower(var_40fdd9a5), tolower(var_5d5d13c3))) {
      return;
    }
  }

  self luinotifyevent(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
  self function_8ba40d2f(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
  challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
  matchrecordlogchallengecomplete(self, var_c4e9517b, challengetier, itemindex, var_eb67c133);
  var_c710a35a = level.var_faccd7d4[var_eb67c133];

  if(isDefined(var_c710a35a)) {
    self[[var_c710a35a]](eventstruct);
  }

  if(getdvarint(#"debugchallenges", 0) != 0) {
    challengestring = makelocalizedstring(var_eb67c133);
    tiertext = challengetier + 1;
    var_33b913f5 = "<dev string:x3c>";

    if(challengetype == 0) {
      var_33b913f5 = "<dev string:x47>";
    } else if(challengetype == 1) {
      iteminfo = getunlockableiteminfofromindex(itemindex, 1);

      if(isDefined(iteminfo)) {
        var_33b913f5 = makelocalizedstring(iteminfo.displayname);
      }
    }

    if(issubstr(challengestring, "<dev string:x51>")) {
      if(challengetype == 3) {
        challengestring = strreplace(challengestring, "<dev string:x51>", "<dev string:x58>" + function_60394171(#"challenge", 3, itemindex));
        var_33b913f5 = "<dev string:x5d>";
      }
    }

    if(issubstr(challengestring, "<dev string:x66>")) {
      challengestring = strreplace(challengestring, "<dev string:x66>", "<dev string:x58>" + tiertext);
    }

    if(var_33b913f5 == "<dev string:x3c>") {
      var_fb76383b = 1;
      var_fb76383b++;
    }

    msg = var_33b913f5 + "<dev string:x6d>" + challengestring + "<dev string:x74>" + maxval;

    if(getdvarint(#"debugchallenges", 0) == 1) {
      iprintlnbold(msg);
    } else if(getdvarint(#"debugchallenges", 0) == 2) {
      self iprintlnbold(msg);
    } else if(getdvarint(#"debugchallenges", 0) == 3) {
      iprintln(msg);
    }

    println(msg);
  }
}

function event_handler[player_gunchallengecomplete] codecallback_gunchallengecomplete(eventstruct) {
  if(!isDefined(eventstruct)) {
    return;
  }

  rewardxp = eventstruct.reward;
  attachmentindex = eventstruct.attachment_index;
  itemindex = eventstruct.item_index;
  rankid = eventstruct.rank_id;
  islastrank = eventstruct.is_lastrank;

  if(sessionmodeiscampaigngame()) {
    self notify(#"gun_level_complete", {
      #reward_xp: rewardxp, #attachment_index: attachmentindex, #item_index: itemindex, #rank: rankid, #is_last_rank: islastrank
    });
    return;
  }

  if(islastrank === 1) {
    self thread challenges::dochallengecallback(#"gun_level_complete_last_rank", eventstruct);
  }

  self luinotifyevent(#"gun_level_complete", 5, rankid, itemindex, attachmentindex, rewardxp, islastrank);
  self function_8ba40d2f(#"gun_level_complete", 5, rankid, itemindex, attachmentindex, rewardxp, islastrank);
}

function upload_stats_soon() {
  self notify(#"upload_stats_soon");
  self endon(#"upload_stats_soon", #"disconnect");
  wait 1;
  uploadstats(self);
}