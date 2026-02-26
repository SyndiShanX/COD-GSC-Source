/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\rank_shared.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace rank;

function private autoexec __init__system__() {
  system::register(#"rank", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {
  level.scoreinfo = [];
  level.usingmomentum = 1;
  level.usingscorestreaks = getdvarint(#"scr_scorestreaks", 0) != 0;
  level.scorestreaksmaxstacking = 1000;
  level.maxinventoryscorestreaks = getdvarint(#"scr_maxinventory_scorestreaks", 3);
  level.usingrampage = !isDefined(level.usingscorestreaks) || !level.usingscorestreaks;
  level.rampagebonusscale = getdvarfloat(#"scr_rampagebonusscale", 0);

  if(sessionmodeiscampaigngame()) {
    level.xpscale = getdvarfloat(#"scr_xpscalecp", 0);
  } else if(sessionmodeiszombiesgame()) {
    level.xpscale = getdvarfloat(#"scr_xpscalezm", 0);
  } else {
    level.xpscale = getdvarfloat(#"scr_xpscalemp", 0);
  }

  initscoreinfo();
  callback::on_connect(&on_player_connect);
}

function initscoreinfo() {
  scoreinfotablename = scoreevents::getscoreeventtablename(level.gametype);
  rowcount = tablelookuprowcount(scoreinfotablename);

  if(sessionmodeismultiplayergame() && rowcount === 0) {
    scoreinfotablename = # "gamedata/tables/mp/scoreinfo/mp_scoreinfo" + "_base.csv";
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
      dp = int(tablelookupcolumnforrow(scoreinfotablename, row, 7));
      is_objective = tablelookupcolumnforrow(scoreinfotablename, row, 8);
      medalname = tablelookupcolumnforrow(scoreinfotablename, row, 11);
      var_b6cc2245 = tablelookupcolumnforrow(scoreinfotablename, row, 12);
      is_deprecated = tablelookupcolumnforrow(scoreinfotablename, row, 21);
      bounty_reward = tablelookupcolumnforrow(scoreinfotablename, row, 22);
      var_65181181 = int(isDefined(tablelookupcolumnforrow(scoreinfotablename, row, 24)) ? tablelookupcolumnforrow(scoreinfotablename, row, 24) : 0);
      registerscoreinfo(type, row, lp, xp, sp, hs, res, dp, is_objective, label, medalname, var_b6cc2245, is_deprecated, bounty_reward, var_65181181);

      if(!isDefined(game.scoreinfoinitialized)) {
        setddlstat = var_b6cc2245;
        addplayerstat = 0;

        if(setddlstat) {
          addplayerstat = 1;
        }

        ismedal = 0;
        var_9750677a = tablelookup(scoreinfotablename, 0, type, 10);
        var_9f6af7ed = tablelookup(scoreinfotablename, 0, type, 11);

        if(isDefined(var_9750677a) && var_9750677a != # "" && isDefined(var_9f6af7ed) && var_9f6af7ed != # "") {
          ismedal = 1;
        }

        registerxp(type, xp, addplayerstat, ismedal, dp, row, var_65181181);
      }
    }
  }

  game.scoreinfoinitialized = 1;
}

function registerscoreinfo(type, row, lp, xp, sp, hs, res, dp, is_obj, label, medalname, var_b6cc2245, is_deprecated, bounty_reward, var_65181181) {
  overridedvar = "scr_" + level.gametype + "_score_" + type;

  if(getdvarstring(overridedvar) != "") {
    value = getdvarint(overridedvar, 0);
  }

  if(!sessionmodeismultiplayergame() || type == # "ekia") {
    if(is_true(xp)) {
      level.scoreinfo[type][#"xp"] = xp;
    }
  }

  if(is_true(sp)) {
    level.scoreinfo[type][#"sp"] = sp;
  }

  if(isDefined(medalname) && medalname != # "") {
    level.scoreinfo[type][#"medalnamehash"] = medalname;
  }

  if(is_true(var_b6cc2245)) {
    level.scoreinfo[type][#"hash_2ecf46b14fe1efc9"] = var_b6cc2245;
  }

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    level.scoreinfo[type][#"row"] = row;

    if(is_true(lp)) {
      level.scoreinfo[type][#"lp"] = lp;
    }

    if(is_true(hs)) {
      level.scoreinfo[type][#"hs"] = hs;
    }

    if(is_true(res)) {
      level.scoreinfo[type][#"res"] = res;
    }

    if(is_true(dp)) {
      level.scoreinfo[type][#"dp"] = dp;
    }

    if(is_true(is_obj)) {
      level.scoreinfo[type][#"isobj"] = is_obj;
    }

    if(isDefined(medalname)) {
      if(type == "kill" || type == "ekia") {
        multiplier = getgametypesetting(#"killeventscoremultiplier");

        if(multiplier > 0) {
          if(is_true(level.scoreinfo[type][#"sp"])) {
            level.scoreinfo[type][#"sp"] = int(multiplier * level.scoreinfo[type][#"sp"]);
          }
        }
      }
    }

    if(isDefined(label)) {
      level.scoreinfo[type][#"label"] = label;
    }

    if(is_true(is_deprecated)) {
      level.scoreinfo[type][#"is_deprecated"] = is_deprecated;
    }

    if(is_true(bounty_reward)) {
      level.scoreinfo[type][#"bounty_reward"] = bounty_reward;
    }

    if(is_true(var_65181181)) {
      level.scoreinfo[type][#"hash_691aeaca4a1866e3"] = var_65181181;
    }

    return;
  }

  if(sessionmodeiscampaigngame()) {
    if(is_true(res)) {
      level.scoreinfo[type][#"res"] = res;
    }

    return;
  }

  if(sessionmodeiszombiesgame()) {
    if(is_true(res)) {
      level.scoreinfo[type][#"res"] = res;
    }

    if(isDefined(label)) {
      level.scoreinfo[type][#"label"] = label;
    }
  }
}

function getscoreinfovalue(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_score = isDefined(level.scoreinfo[type][#"sp"]) ? level.scoreinfo[type][#"sp"] : 0;

    if(isDefined(level.scoremodifiercallback) && isDefined(n_score)) {
      n_score = [[level.scoremodifiercallback]](type, n_score);
      assert(isint(n_score));
    }

    var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
    n_score = int(n_score * var_1eb7c454);

    return n_score;
  }

  return 0;
}

function function_4587103(type) {
  return int(0);
}

function getrole() {
  return "prc_mp_slayer";
}

function getscoreinfoposition(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_pos = isDefined(level.scoreinfo[type][#"hash_7c1f7c7897445706"]) ? level.scoreinfo[type][#"hash_7c1f7c7897445706"] : 0;

    if(isDefined(level.scoremodifiercallback) && isDefined(n_pos)) {
      n_resource = [[level.scoremodifiercallback]](type, n_pos);
    }

    return n_pos;
  }

  return 0;
}

function getscoreinforesource(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_resource = isDefined(level.scoreinfo[type][#"res"]) ? level.scoreinfo[type][#"res"] : 0;

    if(isDefined(level.resourcemodifiercallback) && isDefined(n_resource)) {
      n_resource = [[level.resourcemodifiercallback]](type, n_resource);
    }

    return n_resource;
  }

  return 0;
}

function getscoreinfoxp(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    n_xp = isDefined(level.scoreinfo[type][#"xp"]) ? level.scoreinfo[type][#"xp"] : 0;

    if(isDefined(level.xpmodifiercallback) && isDefined(n_xp)) {
      n_xp = [[level.xpmodifiercallback]](type, n_xp);
    }

    return n_xp;
  }

  return 0;
}

function shouldskipmomentumdisplay(type) {
  if(is_true(level.disablemomentum)) {
    return true;
  }

  return false;
}

function getscoreinfolabel(type) {
  return level.scoreinfo[type][#"label"];
}

function getcombatefficiencyevent(type) {
  return level.scoreinfo[type][#"combat_efficiency_event"];
}

function function_f7b5d9fa(type) {
  playerrole = getrole();

  if(isDefined(level.scoreinfo[type])) {
    return (isDefined(level.scoreinfo[type][#"isobj"]) ? level.scoreinfo[type][#"isobj"] : 0);
  }

  return 0;
}

function shouldkickbyrank() {
  if(self ishost()) {
    return false;
  }

  return false;
}

function getarenapointsstat() {
  arenaslot = arenagetslot();
  arenapoints = self stats::get_stat(#"arenastats", arenaslot, #"rankedplaystats", #"points");
  return arenapoints + 1;
}

function getrankxp() {
  assert(isPlayer(self));

  if(isPlayer(self)) {
    xp = self function_2f2051c9();

    if(!isDefined(xp)) {
      xp = 0;
    }

    return xp;
  }

  return 0;
}

function function_5b197def(var_9169ac47) {
  assert(isPlayer(self));

  if(isPlayer(self)) {
    xp = self function_2f2051c9(var_9169ac47);

    if(!isDefined(xp)) {
      xp = 0;
    }

    return xp;
  }

  return 0;
}

function getrank() {
  assert(isPlayer(self));

  if(isPlayer(self)) {
    return getrankforxp(getrankxp());
  }

  return 0;
}

function getprestige() {
  assert(isPlayer(self));

  if(isPlayer(self)) {
    return function_a470b201(getrankxp());
  }

  return 0;
}

function on_player_connect() {
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
    self.pers[#"hash_4a01db5796cf12b1"] = # "none";
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

  if(!isDefined(self.pers[#"hash_2013e34fb3c104e9"])) {
    self.pers[#"hash_2013e34fb3c104e9"] = 0;
  }

  self.pers[#"rankxp"] = self getrankxp();
  self.pers[#"rank"] = getrank();
  self.cur_ranknum = self.pers[#"rank"];
  self.rankupdatetotal = 0;
  self.pers[#"plevel"] = getprestige();
  self setrank(self.pers[#"rank"], self.pers[#"plevel"]);
  self.pers[#"hash_43ad5d1b08145b1f"] = self.pers[#"rankxp"];

  if(self shouldkickbyrank()) {
    kick(self getentitynumber());
    return;
  }

  if(!isDefined(self.pers[#"summary"])) {
    self.pers[#"summary"] = [];
    self.pers[#"summary"][#"xp"] = 0;
    self.pers[#"summary"][#"score"] = 0;
    self.pers[#"summary"][#"challenge"] = 0;
    self.pers[#"summary"][#"match"] = 0;
    self.pers[#"summary"][#"misc"] = 0;
  }

  if(gamemodeisarena() && !isbot(self)) {
    arenapoints = self getarenapointsstat();
    arenapoints = int(min(arenapoints, 100));
    self.pers[#"arenapoints"] = arenapoints;
    self setarenapoints(arenapoints);
  }

  self.explosivekills[0] = 0;
}

function atleastoneplayeroneachteam() {
  foreach(team, _ in level.teams) {
    if(!level.playercount[team]) {
      return false;
    }
  }

  return true;
}

function round_this_number(value) {
  value = int(value + 0.5);
  return value;
}

function updaterank() {
  newrankid = self getrank();

  if(newrankid == self.pers[#"rank"]) {
    return false;
  }

  oldrank = self.pers[#"rank"];
  rankid = self.pers[#"rank"];
  self.pers[#"rank"] = newrankid;

  while(rankid <= newrankid) {
    rankid++;
  }

  print("<dev string:x38>" + oldrank + "<dev string:x4a>" + newrankid + "<dev string:x52>" + self stats::get_stat_global(#"time_played_total"));

  self setrank(newrankid);
  return true;
}

function event_handler[player_rankup] codecallback_rankup(eventstruct) {
  self.pers[#"rank"] = eventstruct.rank;

  if(sessionmodeiswarzonegame()) {
    self stats::function_62b271d8(#"rank", self.pers[#"rank"]);
    self stats::function_62b271d8(#"plevel", self.pers[#"plevel"]);
    return;
  }

  self luinotifyevent(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
  self function_8ba40d2f(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
  self thread battlechatter::function_f5b398b6();
}

function getitemindex(refstring) {
  itemindex = getitemindexfromref(refstring);
  assert(itemindex > 0, "<dev string:x63>" + refstring + "<dev string:x81>" + itemindex);
  return itemindex;
}

function endgameupdate() {
  player = self;
}

function getspm() {
  ranklevel = self getrank() + 1;
  return (3 + ranklevel * 0.5) * 10;
}

function function_bcb5e246(type) {
  var_920d60e7 = 0;

  if(isDefined(level.scoreinfo[type][#"bounty_reward"])) {
    var_920d60e7 = level.scoreinfo[type][#"bounty_reward"];
  }

  return var_920d60e7;
}