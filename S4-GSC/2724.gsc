/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2724.gsc
*************************************************/

_id_8257(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
  }
}

_id_6C29(var_0) {
  return self.pers[var_0];
}

_id_7DAE(var_0, var_1) {
  if(_id_4ADB()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self._id_9134[var_0])) {
    self._id_9134[var_0] = self._id_9134[var_0] + var_1;
  }

  _func_0410(self, var_0, var_1);
}

_id_820B(var_0) {
  if(!isDefined(self._id_9134[var_0])) {
    self._id_9134[var_0] = 0;
  }
}

_id_D550(var_0) {
  if(_id_4ADB()) {
    return;
  }
  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self._id_01A5 = var_0;
  self.pers["extrascore0"] = var_0;
}

_id_D551(var_0) {
  if(_id_4ADB()) {
    return;
  }
  if(var_0 >= 255) {
    var_0 = 255;
  }

  self._id_01A6 = var_0;
  self.pers["extrascore1"] = var_0;
}

_id_D552(var_0) {
  if(_id_4ADB()) {
    return;
  }
  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self._id_01A7 = var_0;
  self.pers["extrascore2"] = var_0;
}

_id_D553(var_0) {
  if(_id_4ADB()) {
    return;
  }
  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self._id_01A8 = var_0;
  self.pers["extrascore3"] = var_0;
}

_id_4ADB() {
  if(istrue(game["practiceRound"])) {
    return 1;
  }

  if(istrue(level._id_4AEC)) {
    return 1;
  }

  return 0;
}

getplayerdataprogressiongroup() {
  if(level.leagueplaymatch) {
    return "leagueplayprogression";
  }

  return "mp";
}

getplayerdataloadoutgroup() {
  if(isgamebattlematch()) {
    return "privateloadouts";
  }

  if(level.leagueplaymatch) {
    if(getdvarint("#x391b828c1f556b457", 0)) {
      return "leagueplayloadouts";
    } else {
      return "rankedloadouts";
    }
  }

  if(level.rankedmatch && !scripts\mp\utility\game::isanymlgmatch()) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
  level.progressiongroup = getplayerdataprogressiongroup();
}

_id_31BA() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && !_id_07D1::_id_60BE("prematch_done")) {
    return 0;
  }

  return level.rankedmatch && !istrue(level.ignorescoring);
}

_id_6D95(var_0) {
  if(_func_030C("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(_func_030C("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}