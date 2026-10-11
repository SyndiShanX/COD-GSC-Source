/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\stats.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\utility\game;
#namespace stats;

function initpersstat(dataname) {
  if(!isDefined(level.var_74d2859df4e039f3)) {
    level.var_74d2859df4e039f3 = getdvarint(@ "hash_ab7a3193a6878af5", 1) != 0;
  }

  if(level.var_74d2859df4e039f3) {
    if(isPlayer(self)) {
      function_38472c8e1cee838(self, dataname);
      return;
    }
  }

  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }
}

function getpersstat(dataname) {
  if(!isDefined(level.var_30da0a8ab3edaf1f)) {
    level.var_30da0a8ab3edaf1f = getdvarint(@ "hash_c09b6858cb329245", 1) != 0;
  }

  if(level.var_30da0a8ab3edaf1f) {
    if(isPlayer(self)) {
      return function_e539214eed237be4(self, dataname);
    }
  }

  return self.pers[dataname];
}

function incpersstat(dataname, increment) {
  if(disablepersupdates()) {
    return;
  }

  assertex(isPlayer(self), "<dev string:x1c>");

  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.leaderboarddata[dataname])) {
    self.leaderboarddata[dataname] += increment;
  }

  if(isDefined(level.var_9012afffee4d9306[dataname])) {
    [[level.var_9012afffee4d9306[dataname]]](self, increment);
  }

  incrementpersistentstat(self, dataname, increment);
}

function initleaderboardstat(dataname, functionptr) {
  if(!isDefined(self.leaderboarddata[dataname])) {
    self.leaderboarddata[dataname] = 0;
  }

  if(!isDefined(level.var_9012afffee4d9306)) {
    level.var_9012afffee4d9306 = [];
  }

  if(isDefined(functionptr) && !isDefined(level.var_9012afffee4d9306[dataname])) {
    level.var_9012afffee4d9306[dataname] = functionptr;
  }
}

function setextrascore0(newvalue) {
  if(disablepersupdates()) {
    return;
  }

  if(newvalue >= 65000) {
    newvalue = 65000;
  }

  self.extrascore0 = newvalue;
  self.pers["extrascore0"] = newvalue;
}

function setextrascore1(newvalue) {
  if(disablepersupdates()) {
    return;
  }

  if(newvalue >= 255) {
    newvalue = 255;
  }

  self.extrascore1 = newvalue;
  self.pers["extrascore1"] = newvalue;
}

function setextrascore2(newvalue) {
  if(disablepersupdates()) {
    return;
  }

  if(newvalue >= 65000) {
    newvalue = 65000;
  }

  self.extrascore2 = newvalue;
  self.pers["extrascore2"] = newvalue;
}

function setextrascore3(newvalue) {
  if(disablepersupdates()) {
    return;
  }

  if(newvalue >= 65000) {
    newvalue = 65000;
  }

  self.extrascore3 = newvalue;
  self.pers["extrascore3"] = newvalue;
}

function setextrascore4(newvalue) {
  if(disablepersupdates()) {
    return;
  }

  if(newvalue >= 65000) {
    newvalue = 65000;
  }

  self.extrascore4 = newvalue;
  self.pers["extrascore4"] = newvalue;
}

function disablepersupdates() {
  if(istrue(game["practiceRound"])) {
    return true;
  }

  if(istrue(level.disablestattracking)) {
    return true;
  }

  if(isagent(self)) {
    return true;
  }

  return false;
}

function function_785a9aed533e514c() {
  if(level.leagueplaymatch) {
    return "leagueplayprogression";
  }

  if(level.var_77907d733abe8b63 && getdvarint(@ "wz_leagueplay_progression_enabled", 0)) {
    return "leagueplayprogression";
  }

  return "mp";
}

function getplayerdataloadoutgroup() {
  if(istrue(level.leagueplaymatch)) {
    if(getdvarint(@ "hash_6299be121597b3c5", 0)) {
      return "leagueplayloadouts";
    } else {
      return "rankedloadouts";
    }
  } else if(istrue(level.var_77907d733abe8b63)) {
    if(getdvarint(@ "wz_leagueplay_loadouts_enabled", 0)) {
      return "wzleagueplayloadouts";
    } else {
      return "wzrankedloadouts";
    }
  }

  var_7377d0f486a012d0 = scripts\cp_mp\utility\game_utility::isbrstylegametype() || getgametype() == "ballmode";

  if(level.rankedmatch && (!scripts\mp\utility\game::isanymlgmatch() || getdvarint(@ "hash_6037589ac3376ef3", 0))) {
    if(!getdvarint(@ "hash_6dd8fb66d1032ceb", 0)) {
      if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.var_7dfb2f7ad76e0d5)) {
        return level.gametypebundle.var_7dfb2f7ad76e0d5;
      }

      if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.var_7dfb2f7ad76e0d5)) {
        return level.gamemodebundle.var_7dfb2f7ad76e0d5;
      }
    }

    if(var_7377d0f486a012d0) {
      return "wzrankedloadouts";
    } else {
      return "rankedloadouts";
    }
  }

  if(!getdvarint(@ "hash_6dd8fb66d1032ceb", 0)) {
    if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.var_713cf903b125c101)) {
      return level.gametypebundle.var_713cf903b125c101;
    }

    if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.var_713cf903b125c101)) {
      return level.gamemodebundle.var_713cf903b125c101;
    }
  }

  if(var_7377d0f486a012d0) {
    return "wzprivateloadouts";
  }

  return "privateloadouts";
}

function function_cd79d5c7c340b40e() {
  if(!getdvarint(@ "hash_6dd8fb66d1032ceb", 0)) {
    if(isDefined(level.gametypebundle)) {
      if(level.rankedmatch && isDefined(level.gametypebundle.var_3d1f074daf608448)) {
        return level.gametypebundle.var_3d1f074daf608448;
      } else if(isDefined(level.gametypebundle.var_13a8bce3a0b4279e)) {
        return level.gametypebundle.var_13a8bce3a0b4279e;
      }
    }

    if(isDefined(level.gamemodebundle)) {
      if(level.rankedmatch && isDefined(level.gamemodebundle.var_3d1f074daf608448)) {
        return level.gamemodebundle.var_3d1f074daf608448;
      } else if(isDefined(level.gamemodebundle.var_13a8bce3a0b4279e)) {
        return level.gamemodebundle.var_13a8bce3a0b4279e;
      }
    }
  }

  if(function_fbadc58163719d2b()) {
    return "mp";
  }

  return level.loadoutsgroup;
}

function function_fbadc58163719d2b() {
  return (getsubgametype() == "dmz" || getsubgametype() == "exgm") && getdvarint(@ "hash_bb9178da63ce4b9", 1) == 1;
}

function setplayerdatagroups() {
  level.progressiongroup = function_785a9aed533e514c();
  level.loadoutsgroup = getplayerdataloadoutgroup();
  level.loadoutdata = function_cd79d5c7c340b40e();
}

function canrecordcombatrecordstats() {
  if(scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  return level.rankedmatch && !istrue(level.ignorescoring);
}

function getstreakrecordtype(streakname) {
  if(isenumvaluevalid(level.progressiongroup, "LethalScorestreakStatItems", streakname)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid(level.progressiongroup, "SupportScorestreakStatItems", streakname)) {
    return "supportScorestreakStats";
  }

  return undefined;
}