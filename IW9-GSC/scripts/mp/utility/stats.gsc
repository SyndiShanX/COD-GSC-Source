/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\stats.gsc
***********************************************/

initpersstat(_id_B03F67117DA3F61A) {
  if(!isDefined(self.pers[_id_B03F67117DA3F61A]))
    self.pers[_id_B03F67117DA3F61A] = 0;
}

getpersstat(_id_B03F67117DA3F61A) {
  return self.pers[_id_B03F67117DA3F61A];
}

incpersstat(_id_B03F67117DA3F61A, _id_2F977E27FA739602) {
  if(disablepersupdates()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self.leaderboarddata[_id_B03F67117DA3F61A]))
    self.leaderboarddata[_id_B03F67117DA3F61A] = self.leaderboarddata[_id_B03F67117DA3F61A] + _id_2F977E27FA739602;

  if(isDefined(level._id_9012AFFFEE4D9306[_id_B03F67117DA3F61A]))
    [[level._id_9012AFFFEE4D9306[_id_B03F67117DA3F61A]]](self, _id_2F977E27FA739602);

  incrementpersistentstat(self, _id_B03F67117DA3F61A, _id_2F977E27FA739602);
}

initleaderboardstat(_id_B03F67117DA3F61A, _id_1381632D44859C99) {
  if(!isDefined(self.leaderboarddata[_id_B03F67117DA3F61A]))
    self.leaderboarddata[_id_B03F67117DA3F61A] = 0;

  if(!isDefined(level._id_9012AFFFEE4D9306))
    level._id_9012AFFFEE4D9306 = [];

  if(isDefined(_id_1381632D44859C99) && !isDefined(level._id_9012AFFFEE4D9306[_id_B03F67117DA3F61A]))
    level._id_9012AFFFEE4D9306[_id_B03F67117DA3F61A] = _id_1381632D44859C99;
}

setextrascore0(_id_8F617FFD000EB682) {
  if(disablepersupdates()) {
    return;
  }
  if(_id_8F617FFD000EB682 >= 65000)
    _id_8F617FFD000EB682 = 65000;

  self.extrascore0 = _id_8F617FFD000EB682;
  self.pers["extrascore0"] = _id_8F617FFD000EB682;
}

setextrascore1(_id_8F617FFD000EB682) {
  if(disablepersupdates()) {
    return;
  }
  if(_id_8F617FFD000EB682 >= 255)
    _id_8F617FFD000EB682 = 255;

  self.extrascore1 = _id_8F617FFD000EB682;
  self.pers["extrascore1"] = _id_8F617FFD000EB682;
}

setextrascore2(_id_8F617FFD000EB682) {
  if(disablepersupdates()) {
    return;
  }
  if(_id_8F617FFD000EB682 >= 65000)
    _id_8F617FFD000EB682 = 65000;

  self.extrascore2 = _id_8F617FFD000EB682;
  self.pers["extrascore2"] = _id_8F617FFD000EB682;
}

setextrascore3(_id_8F617FFD000EB682) {
  if(disablepersupdates()) {
    return;
  }
  if(_id_8F617FFD000EB682 >= 65000)
    _id_8F617FFD000EB682 = 65000;

  self.extrascore3 = _id_8F617FFD000EB682;
  self.pers["extrascore3"] = _id_8F617FFD000EB682;
}

setextrascore4(_id_8F617FFD000EB682) {
  if(disablepersupdates()) {
    return;
  }
  if(_id_8F617FFD000EB682 >= 65000)
    _id_8F617FFD000EB682 = 65000;

  self.extrascore4 = _id_8F617FFD000EB682;
  self.pers["extrascore4"] = _id_8F617FFD000EB682;
}

disablepersupdates() {
  if(istrue(game["practiceRound"]))
    return 1;

  if(istrue(level.disablestattracking))
    return 1;

  if(isagent(self))
    return 1;

  return 0;
}

_id_785A9AED533E514C() {
  if(level._id_EC2FB549B15AD827)
    return "leagueplayprogression";

  if(level._id_77907D733ABE8B63 && getdvarint("dvar_08B2E1BF19FA1C9D", 0))
    return "leagueplayprogression";

  return "mp";
}

getplayerdataloadoutgroup() {
  if(istrue(level._id_EC2FB549B15AD827)) {
    if(getdvarint("leagueplay_loadouts_enabled", 0))
      return "leagueplayloadouts";
    else
      return "rankedloadouts";
  } else if(istrue(level._id_77907D733ABE8B63)) {
    if(getdvarint("wz_leagueplay_loadouts_enabled", 0))
      return "wzleagueplayloadouts";
    else
      return "wzrankedloadouts";
  }

  _id_7377D0F486A012D0 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\mp\utility\game::getgametype() == "ballmode";
  _id_AF15BBF00BD78E3E = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();

  if(level.rankedmatch && (!scripts\mp\utility\game::isanymlgmatch() || getdvarint("dvar_6037589AC3376EF3", 0)) || _id_AF15BBF00BD78E3E) {
    if(_id_7377D0F486A012D0)
      return "wzrankedloadouts";
    else
      return "rankedloadouts";
  }

  if(_id_7377D0F486A012D0)
    return "wzprivateloadouts";
  else
    return "privateloadouts";
}

_id_FBADC58163719D2B() {
  return (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") && getdvarint("dvar_0BB9178DA63CE4B9", 1) == 1;
}

setplayerdatagroups() {
  level._id_5D69837CF4DB0407 = _id_785A9AED533E514C();
  level.loadoutsgroup = getplayerdataloadoutgroup();
  level._id_13ECA9A3244E502F = level.loadoutsgroup;

  if(_id_FBADC58163719D2B())
    level._id_13ECA9A3244E502F = "mp";
}

canrecordcombatrecordstats() {
  if(scripts\mp\utility\game::getgametype() == "infect")
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  return level.rankedmatch && !istrue(level.ignorescoring);
}

getstreakrecordtype(streakname) {
  if(isenumvaluevalid(level._id_5D69837CF4DB0407, "LethalScorestreakStatItems", streakname))
    return "lethalScorestreakStats";

  if(isenumvaluevalid(level._id_5D69837CF4DB0407, "SupportScorestreakStatItems", streakname))
    return "supportScorestreakStats";

  return undefined;
}