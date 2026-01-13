/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\contracts.gsc
************************************/

init() {
  if(getdvarint("mission_team_contracts_enabled", 0) == 0) {
    return;
  }

  var_0 = spawnStruct();
  level.contractglobals = var_0;
  scripts\mp\contractchallenges::registercontractchallenges();
  var_0.numchallenges = 0;
  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow("mp\contractChallenges.csv", var_1, 0);
    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_0.numchallenges++;
    var_1++;
  }

  level thread onplayerconnect();
}

contractsenabled() {
  if(isai(self)) {
    return 0;
  }

  if(!level.rankedmatch) {
    return 0;
  }

  if(!scripts\mp\utility::rankingenabled()) {
    return 0;
  }

  if(getdvarint("mission_team_contracts_enabled", 0) == 0) {
    return 0;
  }

  return 1;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    if(!var_0 contractsenabled()) {
      continue;
    }

    var_0.contracts = [];
    var_1 = var_0 getchallengeids();
    foreach(var_4, var_3 in var_1) {
      var_0 givecontractchallenge(var_3, var_4);
    }
  }
}

getchallengeids() {
  var_0 = self getplayerdata("mp", "contracts", "challenges", 0, "challengeID");
  var_1 = self getplayerdata("mp", "contracts", "challenges", 1, "challengeID");
  return [var_0, var_1];
}

givecontractchallenge(var_0, var_1) {
  var_2 = lookupcontractchallengeref(var_0);
  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = spawnStruct();
  var_3.slot = var_1;
  var_3.ref = var_2;
  var_3.target = lookupcontractchallengetarget(var_0);
  var_3.team = lookupcontractchallengeteam(var_0);
  var_3.id = var_0;
  var_3.progress = self getplayerdata("mp", "contracts", "challenges", var_3.slot, "progress");
  var_4 = self getplayerdata("mp", "activeMissionTeam");
  var_5 = var_3.team == var_4 || var_3.team == -1;
  var_3.completed = var_3.progress >= var_3.target;
  if(!var_3.completed && var_5) {
    self thread[[level.contractchallenges[var_3.ref]]](var_3);
    self.contracts[var_1] = var_3;
  }
}

lookupcontractchallengeref(var_0) {
  var_1 = tablelookup("mp\contractChallenges.csv", 0, var_0, 1);
  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return var_1;
}

lookupcontractchallengetarget(var_0) {
  var_1 = tablelookup("mp\contractChallenges.csv", 0, var_0, 3);
  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return int(var_1);
}

lookupcontractchallengeteam(var_0) {
  var_1 = tablelookup("mp\contractChallenges.csv", 0, var_0, 2);
  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return int(var_1);
}

updatecontractprogress(var_0, var_1) {
  if(!level.onlinegame) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_0.progress = var_0.progress + var_1;
  var_0.progress = int(min(var_0.progress, var_0.target));
  if(!var_0.completed) {
    var_0.completed = var_0.progress >= var_0.target;
    if(var_0.completed) {
      var_2 = scripts\engine\utility::ter_op(var_0.team == -1, "contract_complete_joint_ops", "contract_complete_team_" + var_0.team);
      thread scripts\mp\hud_message::showsplash(var_2);
      self setplayerdata("mp", "contracts", "challenges", var_0.slot, "completed", 1);
    }
  }

  self setplayerdata("mp", "contracts", "challenges", var_0.slot, "progress", var_0.progress);
}