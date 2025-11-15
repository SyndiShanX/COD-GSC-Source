/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\rank_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\rank_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace rank;

autoexec __init__system__() {
  system::register(#"rank", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
}

init() {
  level.scoreinfo = [];
  level.rankxpcap = getxpcap();
  level.usingmomentum = 1;
  level.usingscorestreaks = getdvarint(#"scr_scorestreaks", 0) != 0;
  level.scorestreaksmaxstacking = getdvarint(#"scr_scorestreaks_maxstacking", 0);
  level.maxinventoryscorestreaks = getdvarint(#"scr_maxinventory_scorestreaks", 3);
  level.usingrampage = !isDefined(level.usingscorestreaks) || !level.usingscorestreaks;
  level.rampagebonusscale = getdvarfloat(#"scr_rampagebonusscale", 0);
  level.ranktable = [];

  if(sessionmodeiscampaigngame()) {
    level.xpscale = getdvarfloat(#"scr_xpscalecp", 0);
  } else if(sessionmodeiszombiesgame()) {
    level.xpscale = getdvarfloat(#"scr_xpscalezm", 0);
  } else {
    level.xpscale = getdvarfloat(#"scr_xpscalemp", 0);
  }

  initscoreinfo();
  level.maxrank = int(getrankcap());
  level.maxprestige = int(getprestigecap());

  for(rankid = 0; rankid <= level.maxrank; rankid++) {
    level.ranktable[rankid][0] = getrankminxp(rankid);
    level.ranktable[rankid][1] = getrankmaxxp(rankid);
    level.ranktable[rankid][2] = level.ranktable[rankid][1] - level.ranktable[rankid][0];
  }

  callback::on_connect(&on_player_connect);
}

initscoreinfo() {
  scoreinfotablename = scoreevents::getscoreeventtablename(level.gametype);
  rowcount = tablelookuprowcount(scoreinfotablename);

  if(sessionmodeismultiplayergame() && rowcount === 0) {
    scoreinfotablename = #"gamedata/tables/mp/scoreinfo/mp_scoreinfo" + "_base.csv";
    rowcount = tablelookuprowcount(scoreinfotablename);
  }

  for(row = 0; row < rowcount; row++) {
    type = tablelookupcolumnforrow(scoreinfotablename, row, 0);

    if(isDefined(type) && type != "") {
      labelstring = tablelookupcolumnforrow(scoreinfotablename, row, 9);
      label = undefined;

      if(labelstring != "") {
        label = tablelookup(scoreinfotablename, 0, type, 9);
      }

      lp = int(tablelookupcolumnforrow(scoreinfotablename, row, 1));
      xp = int(tablelookupcolumnforrow(scoreinfotablename, row, 2));
      sp = int(tablelookupcolumnforrow(scoreinfotablename, row, 3));
      hs = int(tablelookupcolumnforrow(scoreinfotablename, row, 4));
      res = float(tablelookupcolumnforrow(scoreinfotablename, row, 5));
      var_e775f7ed = tablelookupcolumnforrow(scoreinfotablename, row, 6);
      dp = int(tablelookupcolumnforrow(scoreinfotablename, row, 7));
      is_objective = tablelookupcolumnforrow(scoreinfotablename, row, 8);
      medalname = tablelookupcolumnforrow(scoreinfotablename, row, 11);
      job_type = tablelookupcolumnforrow(scoreinfotablename, row, 16);
      var_b6593614 = tablelookupcolumnforrow(scoreinfotablename, row, 17);
      var_1a39d14 = tablelookupcolumnforrow(scoreinfotablename, row, 18);
      var_bdbfb0e = tablelookupcolumnforrow(scoreinfotablename, row, 19);
      var_a434fd2d = tablelookupcolumnforrow(scoreinfotablename, row, 20);
      is_deprecated = tablelookupcolumnforrow(scoreinfotablename, row, 21);
      bounty_reward = tablelookupcolumnforrow(scoreinfotablename, row, 22);
      var_65181181 = int(isDefined(tablelookupcolumnforrow(scoreinfotablename, row, 24)) ? tablelookupcolumnforrow(scoreinfotablename, row, 24) : 0);
      registerscoreinfo(type, row, lp, xp, sp, hs, res, var_e775f7ed, dp, is_objective, label, medalname, job_type, var_b6593614, var_1a39d14, var_bdbfb0e, var_a434fd2d, is_deprecated, bounty_reward, var_65181181);

      if(!isDefined(game.scoreinfoinitialized)) {
        setddlstat = tablelookupcolumnforrow(scoreinfotablename, row, 12);
        addplayerstat = 0;

        if(setddlstat) {
          addplayerstat = 1;
        }

        ismedal = 0;
        var_9750677a = tablelookup(scoreinfotablename, 0, type, 10);
        var_9f6af7ed = tablelookup(scoreinfotablename, 0, type, 11);

        if(isDefined(var_9750677a) && var_9750677a != #"" && isDefined(var_9f6af7ed) && var_9f6af7ed != #"") {
          ismedal = 1;
        }

        registerxp(type, xp, addplayerstat, ismedal, dp, row, var_65181181);
      }
    }
  }

  game.scoreinfoinitialized = 1;
}

getrankxpcapped(inrankxp) {
  if(isDefined(level.rankxpcap) && level.rankxpcap && level.rankxpcap <= inrankxp) {
    return level.rankxpcap;
  }

  return inrankxp;
}

registerscoreinfo(type, row, lp, xp, sp, hs, res, var_e775f7ed, dp, is_obj, label, medalname, job_type, var_b6593614, var_1a39d14, var_bdbfb0e, var_a434fd2d, is_deprecated, bounty_reward, var_65181181) {
  overridedvar = "scr_" + level.gametype + "_score_" + type;

  if(getdvarstring(overridedvar) != "") {
    value = getdvarint(overridedvar, 0);
  }

  if(!sessionmodeismultiplayergame()) {
    if(isDefined(xp) && xp) {
      level.scoreinfo[type][#"xp"] = xp;
    }
  }

  if(isDefined(sp) && sp) {
    level.scoreinfo[type][#"sp"] = sp;
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    level.scoreinfo[type][#"row"] = row;

    if(isDefined(lp) && lp) {
      level.scoreinfo[type][#"lp"] = lp;
    }

    if(isDefined(hs) && hs) {
      level.scoreinfo[type][#"hs"] = hs;
    }

    if(isDefined(res) && res) {
      level.scoreinfo[type][#"res"] = res;
    }

    if(isDefined(var_e775f7ed) && var_e775f7ed) {
      level.scoreinfo[type][#"hash_4e7be147d773e419"] = var_e775f7ed;
    }

    if(isDefined(dp) && dp) {
      level.scoreinfo[type][#"dp"] = dp;
    }

    if(isDefined(is_obj) && is_obj) {
      level.scoreinfo[type][#"isobj"] = is_obj;
    }

    if(isDefined(medalname)) {
      if(type == "kill" || type == "ekia") {
        multiplier = getgametypesetting(#"killeventscoremultiplier");

        if(multiplier > 0) {
          if(isDefined(level.scoreinfo[type][#"sp"]) && level.scoreinfo[type][#"sp"]) {
            level.scoreinfo[type][#"sp"] = int(multiplier * level.scoreinfo[type][#"sp"]);
          }
        }
      }
    }

    if(isDefined(label)) {
      level.scoreinfo[type][#"label"] = label;
    }

    if(isDefined(medalname) && medalname != #"") {
      level.scoreinfo[type][#"medalnamehash"] = medalname;
    }

    if(job_type != "") {
      level.scoreinfo[type][#"job_type"] = job_type;
    }

    if(var_b6593614 != "") {
      level.scoreinfo[type][#"hash_401b1493e5188252"] = var_b6593614;
    }

    if(var_1a39d14 != "") {
      level.scoreinfo[type][#"hash_251eb53657a5574e"] = var_1a39d14;
    }

    if(var_bdbfb0e != "") {
      level.scoreinfo[type][#"hash_294ec6af2b8cb400"] = var_bdbfb0e;
    }

    if(isDefined(var_a434fd2d) && var_a434fd2d) {
      level.scoreinfo[type][#"hash_6f22dfa8ea741f95"] = var_a434fd2d;
    }

    if(isDefined(is_deprecated) && is_deprecated) {
      level.scoreinfo[type][#"is_deprecated"] = is_deprecated;
    }

    if(isDefined(bounty_reward) && bounty_reward) {
      level.scoreinfo[type][#"bounty_reward"] = bounty_reward;
    }

    if(isDefined(var_65181181) && var_65181181) {
      level.scoreinfo[type][#"hash_691aeaca4a1866e3"] = var_65181181;
    }

    return;
  }

  if(sessionmodeiscampaigngame()) {
    if(isDefined(res) && res) {
      level.scoreinfo[type][#"res"] = res;
    }

    return;
  }

  if(sessionmodeiszombiesgame()) {
    if(isDefined(res) && res) {
      level.scoreinfo[type][#"res"] = res;
    }

    if(isDefined(label)) {
      level.scoreinfo[type][#"label"] = label;
    }
  }
}

function_ca5d4a8(type) {
  return isDefined(level.scoreinfo[type]) && isDefined(level.scoreinfo[type][#"hash_6f22dfa8ea741f95"]) && level.scoreinfo[type][#"hash_6f22dfa8ea741f95"];
}

getscoreinfovalue(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_score = isDefined(level.scoreinfo[type][#"sp"]) ? level.scoreinfo[type][#"sp"] : 0;

    if(isDefined(level.scoremodifiercallback) && isDefined(n_score)) {
      n_score = [
        [level.scoremodifiercallback]
      ](type, n_score);
    }

    var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
    n_score = int(n_score * var_1eb7c454);

    return n_score;
  }

  return 0;
}

function_4587103(type) {
  return int(0);
}

getrole() {
  return "prc_mp_slayer";
}

getscoreinfoposition(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_pos = isDefined(level.scoreinfo[type][#"hash_7c1f7c7897445706"]) ? level.scoreinfo[type][#"hash_7c1f7c7897445706"] : 0;

    if(isDefined(level.scoremodifiercallback) && isDefined(n_pos)) {
      n_resource = [
        [level.scoremodifiercallback]
      ](type, n_pos);
    }

    return n_pos;
  }

  return 0;
}

getscoreinforesource(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_resource = isDefined(level.scoreinfo[type][#"res"]) ? level.scoreinfo[type][#"res"] : 0;

    if(isDefined(level.resourcemodifiercallback) && isDefined(n_resource)) {
      n_resource = [
        [level.resourcemodifiercallback]
      ](type, n_resource);
    }

    return n_resource;
  }

  return 0;
}

getscoreinfoxp(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_xp = isDefined(level.scoreinfo[type][#"xp"]) ? level.scoreinfo[type][#"xp"] : 0;

    if(isDefined(level.xpmodifiercallback) && isDefined(n_xp)) {
      n_xp = [
        [level.xpmodifiercallback]
      ](type, n_xp);
    }

    return n_xp;
  }

  return 0;
}

shouldskipmomentumdisplay(type) {
  if(isDefined(level.disablemomentum) && level.disablemomentum) {
    return true;
  }

  return false;
}

getscoreinfolabel(type) {
  return level.scoreinfo[type][#"label"];
}

getcombatefficiencyevent(type) {
  return level.scoreinfo[type][#"combat_efficiency_event"];
}

doesscoreinfocounttowardrampage(type) {
  return isDefined(level.scoreinfo[type][#"rampage"]) && level.scoreinfo[type][#"rampage"];
}

function_f7b5d9fa(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    return (isDefined(level.scoreinfo[type][#"isobj"]) ? level.scoreinfo[type][#"isobj"] : 0);
  }

  return 0;
}

getrankinfominxp(rankid = 0) {
  rankid = math::clamp(rankid, 0, 54);
  return int(level.ranktable[rankid][0]);
}

getrankinfomaxxp(rankid = 0) {
  rankid = math::clamp(rankid, 0, 54);
  return int(level.ranktable[rankid][1]);
}

getrankinfoxpamt(rankid = 0) {
  rankid = math::clamp(rankid, 0, 54);
  return int(level.ranktable[rankid][2]);
}

shouldkickbyrank() {
  if(self ishost()) {
    return false;
  }

  if(level.rankcap > 0 && self.pers[#"rank"] > level.rankcap) {
    return true;
  }

  if(level.rankcap > 0 && level.minprestige == 0 && self.pers[#"plevel"] > 0) {
    return true;
  }

  if(level.minprestige > self.pers[#"plevel"]) {
    return true;
  }

  return false;
}

getrankxpstat() {
  rankxp = self stats::get_stat_global(#"rankxp", 1);

  if(!isDefined(rankxp)) {
    return 0;
  }

  rankxpcapped = getrankxpcapped(rankxp);

  if(rankxp > rankxpcapped) {
    self stats::set_stat_global(#"rankxp", rankxpcapped, 1);
  }

  return rankxpcapped;
}

getarenapointsstat() {
  arenaslot = arenagetslot();
  arenapoints = self stats::get_stat(#"arenastats", arenaslot, #"rankedplaystats", #"points");
  return arenapoints + 1;
}

on_player_connect() {
  self.pers[#"rankxp"] = self getrankxpstat();
  rankid = getrankforxp(self getrankxp());
  self.pers[#"rank"] = rankid;
  self.pers[#"plevel"] = self stats::get_stat_global(#"plevel", 1);

  if(!isDefined(self.pers[#"plevel"])) {
    self.pers[#"plevel"] = 0;
  }

  if(self shouldkickbyrank()) {
    kick(self getentitynumber());
    return;
  }

  if(!isDefined(self.pers[#"participation"])) {
    self.pers[#"participation"] = 0;
  }

  if(!isDefined(self.pers[#"controllerparticipation"])) {
    self.pers[#"controllerparticipation"] = 0;
  }

  if(!isDefined(self.pers[#"controllerparticipationchecks"])) {
    self.pers[#"controllerparticipationchecks"] = 0;
  }

  if(!isDefined(self.pers[#"controllerparticipationchecksskipped"])) {
    self.pers[#"controllerparticipationchecksskipped"] = 0;
  }

  if(!isDefined(self.pers[#"controllerparticipationconsecutivesuccessmax"])) {
    self.pers[#"controllerparticipationconsecutivesuccessmax"] = 0;
  }

  if(!isDefined(self.pers[#"controllerparticipationconsecutivefailuremax"])) {
    self.pers[#"controllerparticipationconsecutivefailuremax"] = 0;
  }

  if(!isDefined(self.pers[#"hash_3b7fc8c62a7d4420"])) {
    self.pers[#"hash_3b7fc8c62a7d4420"] = 0;
  }

  if(!isDefined(self.pers[#"hash_4a01db5796cf12b1"])) {
    self.pers[#"hash_4a01db5796cf12b1"] = #"none";
  }

  if(!isDefined(self.pers[#"controllerparticipationendgameresult"])) {
    self.pers[#"controllerparticipationendgameresult"] = -1;
  }

  if(!isDefined(self.pers[#"controllerparticipationinactivitywarnings"])) {
    self.pers[#"controllerparticipationinactivitywarnings"] = 0;
  }

  if(!isDefined(self.pers[#"controllerparticipationsuccessafterinactivitywarning"])) {
    self.pers[#"controllerparticipationsuccessafterinactivitywarning"] = 0;
  }

  self.rankupdatetotal = 0;
  self.cur_ranknum = rankid;
  assert(isDefined(self.cur_ranknum), "<dev string:x38>" + rankid + "<dev string:x41>");
  prestige = self stats::get_stat_global(#"plevel", 1);

  if(!isDefined(prestige)) {
    prestige = 0;
  }

  self setrank(rankid, prestige);
  self.pers[#"prestige"] = prestige;

  if(sessionmodeismultiplayergame() && gamemodeisusingstats() || sessionmodeiszombiesgame() && sessionmodeisonlinegame()) {
    paragonrank = self stats::get_stat_global(#"paragon_rank", 1);

    if(!isDefined(paragonrank)) {
      paragonrank = 0;
    }

    paragonrank = int(min(paragonrank, 1000));
    self setparagonrank(paragonrank);
    self.pers[#"paragonrank"] = paragonrank;
    paragoniconid = self stats::get_stat_global(#"paragon_icon_id", 1);

    if(!isDefined(paragoniconid)) {
      paragoniconid = 0;
    }

    self setparagoniconid(paragoniconid);
    self.pers[#"paragoniconid"] = paragoniconid;
  }

  if(sessionmodeiswarzonegame()) {
    self setparagonrank(0);
    self.pers[#"paragonrank"] = 0;
    self setparagoniconid(0);
    self.pers[#"paragoniconid"] = 0;
  }

  if(!isDefined(self.pers[#"summary"])) {
    self.pers[#"summary"] = [];
    self.pers[#"summary"][#"xp"] = 0;
    self.pers[#"summary"][#"score"] = 0;
    self.pers[#"summary"][#"challenge"] = 0;
    self.pers[#"summary"][#"match"] = 0;
    self.pers[#"summary"][#"misc"] = 0;
  }

  if(gamemodeismode(6) && !isbot(self)) {
    arenapoints = self getarenapointsstat();
    arenapoints = int(min(arenapoints, 100));
    self.pers[#"arenapoints"] = arenapoints;
    self setarenapoints(arenapoints);
  }

  self.explosivekills[0] = 0;

  if(level.rankedmatch) {
    if(!sessionmodeiswarzonegame()) {
      self stats::set_stat_global(#"rank", rankid, 1);
      self stats::set_stat_global(#"minxp", getrankinfominxp(rankid), 1);
      self stats::set_stat_global(#"maxxp", getrankinfomaxxp(rankid), 1);
      self stats::set_stat_global(#"lastxp", getrankxpcapped(self.pers[#"rankxp"]), 1);
    }
  }
}

atleastoneplayeroneachteam() {
  foreach(team, _ in level.teams) {
    if(!level.playercount[team]) {
      return false;
    }
  }

  return true;
}

round_this_number(value) {
  value = int(value + 0.5);
  return value;
}

updaterank() {
  newrankid = self getrank();

  if(newrankid == self.pers[#"rank"]) {
    return false;
  }

  oldrank = self.pers[#"rank"];
  rankid = self.pers[#"rank"];
  self.pers[#"rank"] = newrankid;

  while(rankid <= newrankid) {
    self stats::set_stat_global(#"rank", rankid, 1);
    self stats::set_stat_global(#"minxp", int(self getrankinfominxp(rankid)), 1);
    self stats::set_stat_global(#"maxxp", int(self getrankinfomaxxp(rankid)), 1);
    rankid++;
  }

  print("<dev string:x5b>" + oldrank + "<dev string:x6c>" + newrankid + "<dev string:x73>" + self stats::get_stat_global(#"time_played_total"));

  self setrank(newrankid);
  return true;
}

event_handler[player_rankup] codecallback_rankup(eventstruct) {
  if(sessionmodeismultiplayergame()) {
    if(eventstruct.rank > 53) {
      self giveachievement("mp_trophy_battle_tested");
    }

    if(eventstruct.rank > 8) {
      self giveachievement("mp_trophy_welcome_to_the_club");
    }
  }

  self.pers[#"rank"] = eventstruct.rank;

  if(sessionmodeiswarzonegame()) {
    self stats::function_62b271d8(#"rank", self.pers[#"rank"]);
    self stats::function_62b271d8(#"plevel", self.pers[#"plevel"]);
    return;
  }

  self luinotifyevent(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
  self function_b552ffa9(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);

  if(isDefined(level.playpromotionreaction)) {
    self thread[[level.playpromotionreaction]]();
  }
}

getitemindex(refstring) {
  itemindex = getitemindexfromref(refstring);
  assert(itemindex > 0, "<dev string:x83>" + refstring + "<dev string:xa0>" + itemindex);
  return itemindex;
}

endgameupdate() {
  player = self;
}

getrank() {
  rankxp = getrankxpcapped(self.pers[#"rankxp"]);
  rankid = self.pers[#"rank"];

  if(rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
    return rankid;
  }

  return getrankforxp(rankxp);
}

getspm() {
  if(isarenamode()) {
    ranklevel = getrankcap() + 1;
  } else {
    ranklevel = self getrank() + 1;
  }

  return (3 + ranklevel * 0.5) * 10;
}

getrankxp() {
  return getrankxpcapped(self.pers[#"rankxp"]);
}

function_bcb5e246(type) {
  var_920d60e7 = 0;

  if(isDefined(level.scoreinfo[type][#"bounty_reward"])) {
    var_920d60e7 = level.scoreinfo[type][#"bounty_reward"];
  }

  return var_920d60e7;
}