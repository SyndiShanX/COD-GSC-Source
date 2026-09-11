/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\stats.gsc
***********************************************/

function initpersstat(var0) {
  if(!isDefined(self.pers[var0])) {
    self.pers[var0] = 0;
    return;
  }
}

function getpersstat(var0) {
  return self.pers[var0];
}

function incpersstat(var0, var1) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(isagent(self) || scripts\mp\utility\entity::isturret(self)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.watchvehicleingas[var0])) {
    self.watchvehicleingas[var0] += var1;
  }

  objective_sethideformlgspectator(self, var0, var1);
}

function timedrun_finishlinevfx(var0) {
  if(!isDefined(self.watchvehicleingas[var0])) {
    self.watchvehicleingas[var0] = 0;
    return;
  }
}

function setextrascore0(var0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && (level.disable_super_in_turret.name == "rebirth" || level.disable_super_in_turret.name == "rebirth_reverse" || level.disable_super_in_turret.name == "rebirth_dbd" || level.disable_super_in_turret.name == "rebirth_dbd_reverse")) {
    return;
  }

  if(var0 >= 65000) {
    var0 = 65000;
  }

  self.extrascore0 = var0;
  self.pers["extrascore0"] = var0;
}

function ref_1314c(var0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var0 >= 65000) {
    var0 = 65000;
  }

  self.packarenaomnvardata = var0;
  self.pers["extrascore4"] = var0;
}

function setextrascore1(var0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var0 >= 255) {
    var0 = 255;
  }

  self.extrascore1 = var0;
  self.pers["extrascore1"] = var0;
}

function setextrascore2(var0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var0 >= 65000) {
    var0 = 65000;
  }

  self.extrascore2 = var0;
  self.pers["extrascore2"] = var0;
}

function setextrascore3(var0) {
  if(loadout_updateclassdefault_weaponsheadless()) {
    return;
  }

  if(var0 >= 65000) {
    var0 = 65000;
  }

  self.extrascore3 = var0;
  self.pers["extrascore3"] = var0;
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

  var0 = istrue(level.ref_14434) && getdvarint("LNLMORMPTS");

  if(level.rankedmatch && !scripts\mp\utility\game::isanymlgmatch()) {
    if(var0) {
      return "wzrankedloadouts";
    } else {
      return "rankedloadouts";
    }
  }

  if(var0) {
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

function getstreakrecordtype(var0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}