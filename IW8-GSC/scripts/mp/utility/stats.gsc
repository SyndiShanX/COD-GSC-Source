/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\stats.gsc
***********************************************/

function initpersstat(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
    return;
  }
}

function getpersstat(var_0) {
  return self.pers[var_0];
}

function incpersstat(var_0, var_1) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(isagent(self) || scripts\mp\utility\entity::isturret(self)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.watchvehicleingas[var_0])) {
    self.watchvehicleingas[var_0] += var_1;
  }

  objective_sethideformlgspectator(self, var_0, var_1);
}

function timedrun_finishlinevfx(var_0) {
  if(!isDefined(self.watchvehicleingas[var_0])) {
    self.watchvehicleingas[var_0] = 0;
    return;
  }
}

function setextrascore0(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && (level.disable_super_in_turret.name == "rebirth" || level.disable_super_in_turret.name == "rebirth_reverse" || level.disable_super_in_turret.name == "rebirth_dbd" || level.disable_super_in_turret.name == "rebirth_dbd_reverse")) {
    return;
  }

  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self.extrascore0 = var_0;
  self.pers["extrascore0"] = var_0;
}

function ref_1314c(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self.packarenaomnvardata = var_0;
  self.pers["extrascore4"] = var_0;
}

function setextrascore1(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var_0 >= 255) {
    var_0 = 255;
  }

  self.extrascore1 = var_0;
  self.pers["extrascore1"] = var_0;
}

function setextrascore2(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self.extrascore2 = var_0;
  self.pers["extrascore2"] = var_0;
}

function setextrascore3(var_0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var_0 >= 65000) {
    var_0 = 65000;
  }

  self.extrascore3 = var_0;
  self.pers["extrascore3"] = var_0;
}

function loadout_updateclassdefault_weaponsheadless() {
  if(istrue(game["practiceRound"])) {
    return true;
  }

  if(istrue(level.disablestattracking)) {
    return true;
  }

  return false;
}

function getplayerdataloadoutgroup() {
  if(isgamebattlematch()) {
    return "privateloadouts";
  }

  var_0 = istrue(level.ref_14434) && getdvarint("LNLMORMPTS");

  if(level.rankedmatch && !scripts\mp\utility\game::isanymlgmatch()) {
    if(var_0) {
      return "wzrankedloadouts";
    } else {
      return "rankedloadouts";
    }
  }

  if(var_0) {
    return "wzprivateloadouts";
  }

  return "privateloadouts";
}

function setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

function canrecordcombatrecordstats() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    return false;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done")) {
    return false;
  }

  return level.rankedmatch && !istrue(level.ignorescoring);
}

function getstreakrecordtype(var_0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}