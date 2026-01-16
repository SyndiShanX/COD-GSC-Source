/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\persistence_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\rank_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace persistence;

autoexec __init__system__() {
  system::register(#"persistence", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
}

init() {
  level.persistentdatainfo = [];
  level.maxrecentstats = 10;
  level.maxhitlocations = 19;
  level thread initialize_stat_tracking();
}

initialize_stat_tracking() {
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

adjust_recent_stats() {
  if(getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

  initialize_match_stats();
}

function_acac764e() {
  index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");

  if(!isDefined(index)) {
    return;
  }

  if(index < 0 || index > 9) {
    return;
  }

  newindex = (index + 1) % 10;
  self.pers[#"hash_76fbbcf94dab5536"] = newindex;
  self stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex", newindex);
}

get_recent_stat(isglobal, index, statname) {
  if(!isDefined(index)) {
    return;
  }

  if(isglobal) {
    modename = level.var_12323003;
    return self stats::get_stat(#"gamehistory", modename, #"matchhistory", index, statname);
  }

  return self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscores", index, statname);
}

set_recent_stat(isglobal, index, statname, value) {
  if(!isglobal) {
    index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");

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

  self stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"prevscores", index, statname, value);
}

add_recent_stat(isglobal, index, statname, value) {
  if(isDefined(level.nopersistence) && level.nopersistence) {
    return;
  }

  if(!isglobal) {
    index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");

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

set_match_history_stat(statname, value) {
  modename = level.var_12323003;
  historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
  set_recent_stat(1, historyindex, statname, value);
}

add_match_history_stat(statname, value) {
  modename = level.var_12323003;
  historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
  add_recent_stat(1, historyindex, statname, value);
}

initialize_match_stats() {
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

  if(sessionmodeiswarzonegame()) {
    level waittill(#"game_playing");
    rankid = getrankforxp(self rank::getrankxp());
    self stats::set_stat_global(#"rank", rankid);
    self stats::set_stat_global(#"minxp", rank::getrankinfominxp(rankid));
    self stats::set_stat_global(#"maxxp", rank::getrankinfomaxxp(rankid));
    self stats::set_stat_global(#"lastxp", rank::getrankxpcapped(self.pers[#"rankxp"]));
  }

  if(sessionmodeiswarzonegame() || sessionmodeismultiplayergame()) {
    self stats::function_bb7eedf0(#"total_games_played", 1);

    if(isDefined(level.hardcoremode) && level.hardcoremode) {
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

event_handler[player_challengecomplete] codecallback_challengecomplete(eventstruct) {
  if(sessionmodeiscampaigngame()) {
    if(isDefined(self.challenge_callback_cp)) {
      [
        [self.challenge_callback_cp]
      ](eventstruct.reward, eventstruct.max, eventstruct.row, eventstruct.table_number, eventstruct.challenge_type, eventstruct.item_index, eventstruct.challenge_index);
    }

    return;
  }

  self thread challenge_complete(eventstruct);
}

function_6020a116() {
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

challenge_complete(eventstruct) {
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
    tablename = #"gamedata/stats/zm/statsmilestones" + var_c4e9517b + ".csv";

    if(var_c4e9517b == 2) {
      var_a05af556 = tablelookupcolumnforrow(tablename, row, 9);

      if(var_a05af556 === #"") {
        return;
      } else if(getdvarint(#"hash_730fab929626f598", 0) == 0) {
        if(var_a05af556 === #"camo_gold" || var_a05af556 === #"camo_diamond" || var_a05af556 === #"camo_darkmatter") {
          return;
        }
      }
    }
  } else {
    tablename = #"gamedata/stats/mp/statsmilestones" + var_c4e9517b + ".csv";
  }

  var_eb67c133 = tablelookupcolumnforrow(tablename, row, 5);

  if(var_eb67c133 === #"hash_4a80d584aac2e7d0") {
    return;
  }

  var_54b50d64 = getdvarstring(#"hash_5f6f875e3935912a", "<dev string:x38>");

  if(var_54b50d64 != "<dev string:x38>") {
    challengecategory = tablelookupcolumnforrow(tablename, row, 16);

    if(isDefined(challengecategory) && challengecategory != var_54b50d64) {
      return;
    }
  }

  self luinotifyevent(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
  self function_b552ffa9(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
  challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
  matchrecordlogchallengecomplete(self, var_c4e9517b, challengetier, itemindex, var_eb67c133);

  if(getdvarint(#"scr_debugchallenges", 0) != 0) {
    challengestring = function_9e72a96(var_eb67c133);
    challengedescstring = challengestring + "<dev string:x3b>";
    challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
    tiertext = "<dev string:x43>" + challengetier;
    herostring = "<dev string:x38>";
    heroinfo = getunlockableiteminfofromindex(itemindex, 1);

    if(isDefined(heroinfo)) {
      herostring = heroinfo.displayname;
    }

    if(getdvarint(#"scr_debugchallenges", 0) == 1) {
      iprintlnbold(challengestring + "<dev string:x55>" + maxval + "<dev string:x5b>" + herostring);
      return;
    }

    if(getdvarint(#"scr_debugchallenges", 0) == 2) {
      self iprintlnbold(challengestring + "<dev string:x55>" + maxval + "<dev string:x5b>" + herostring);
      return;
    }

    if(getdvarint(#"scr_debugchallenges", 0) == 3) {
      iprintln(challengestring + "<dev string:x55>" + maxval + "<dev string:x5b>" + herostring);
    }
  }

}

event_handler[player_gunchallengecomplete] codecallback_gunchallengecomplete(eventstruct) {
  rewardxp = eventstruct.reward;
  attachmentindex = eventstruct.attachment_index;
  itemindex = eventstruct.item_index;
  rankid = eventstruct.rank_id;
  islastrank = eventstruct.is_lastrank;

  if(sessionmodeiscampaigngame()) {
    self notify(#"gun_level_complete", {
      #reward_xp: rewardxp, 
      #attachment_index: attachmentindex, 
      #item_index: itemindex, 
      #rank: rankid, 
      #is_last_rank: islastrank
    });
    return;
  }

  self luinotifyevent(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
  self function_b552ffa9(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
}

upload_stats_soon() {
  self notify(#"upload_stats_soon");
  self endon(#"upload_stats_soon", #"disconnect");
  wait 1;
  uploadstats(self);
}