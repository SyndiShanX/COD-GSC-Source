/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\sentientpoolmanager.gsc
***********************************************/

function init() {
  createthreatbiasgroup("Tactical_Static");
  createthreatbiasgroup("Tactical_Moving");
  createthreatbiasgroup("Lethal_Static");
  createthreatbiasgroup("Lethal_Moving");
  createthreatbiasgroup("Level_Vehicle");
  createthreatbiasgroup("Killstreak_Static");
  createthreatbiasgroup("Killstreak_Air");
  createthreatbiasgroup("Killstreak_Ground");
  setignoremegroup("Killstreak_Ground", "Killstreak_Ground");
  setignoremegroup("Killstreak_Air", "Killstreak_Ground");
  setignoremegroup("Killstreak_Air", "Killstreak_Air");
  setignoremegroup("Killstreak_Ground", "Killstreak_Air");
  level.sentientpools = [];
  level.sentientpools[level.sentientpools.size] = "Tactical_Static";
  level.sentientpools[level.sentientpools.size] = "Tactical_Moving";
  level.sentientpools[level.sentientpools.size] = "Lethal_Static";
  level.sentientpools[level.sentientpools.size] = "Lethal_Moving";
  level.sentientpools[level.sentientpools.size] = "Level_Vehicle";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Static";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Air";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Ground";
  level.activesentients = [];

  for(var_0 = 0; var_0 < level.sentientpools.size; var_0++) {
    level.activesentients[level.sentientpools[var_0]] = [];
  }
}

function registersentient(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = -1;

  for(var_7 = 0; var_7 < level.sentientpools.size; var_7++) {
    if(level.sentientpools[var_7] == var_0) {
      var_6 = var_7;
      break;
    }
  }

  if(var_6 == -1) {
    return;
  }

  if(isDefined(self.sentientpool)) {
    return;
  }

  var_8 = getsentientlimits();
  var_9 = nvidiaanselisenabled();

  if(var_8["other"] + var_8["expendable"] >= var_9["other"]) {
    var_10 = removebestsentient(level, var_6);

    if(!var_10) {
      return;
    }
  }

  self.sentientpool = var_0;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  var_11 = undefined;

  if(isstring(var_1)) {
    var_11 = var_1;
  } else if(isPlayer(var_1)) {
    var_11 = var_1.team;
  }

  var_12 = undefined;

  if(isDefined(var_11) && !isagent(self)) {
    var_12 = self makeentitysentient(var_11, undefined, var_4, var_5);
  }

  if(istrue(var_12)) {
    self setthreatbiasgroup(var_0);

    if(istrue(var_2)) {
      self makeentitynomeleetarget();
    }

    level.activesentients[var_0][self.sentientpoolindex] = self;
    thread monitorsentient(var_3);
    return;
  }
}

function monitorsentient(var_0) {
  level endon("game_ended");
  var_1 = self.sentientpool;
  var_2 = self.sentientpoolindex;

  if(isDefined(var_0)) {
    scripts\engine\utility::ref_143a6("death", "remove_sentient", var_0);
  } else {
    scripts\engine\utility::waittill_either("death", "remove_sentient");
  }

  unregistersentient(var_1, var_2);
}

function removebestsentient(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 <= var_0; var_2++) {
    var_1 = getbestsentientfrompool(level.sentientpools[var_2]);

    if(isDefined(var_1)) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return false;
  }

  unregistersentient(var_1, var_1.sentientpool, var_1.sentientpoolindex);
  return true;
}

function getbestsentientfrompool(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.activesentients[var_0]) {
    if(!isDefined(var_2) || var_4.sentientaddedtime < var_2) {
      var_2 = var_4.sentientaddedtime;
      var_1 = var_4;
    }
  }

  return var_1;
}

function unregistersentient(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  level.activesentients[var_0][var_1] = undefined;

  if(isDefined(self)) {
    self.sentientpool = undefined;
    self.sentientpoolindex = undefined;

    if(!isagent(self)) {
      self freeentitysentient();
      return;
    }

    return;
  }
}