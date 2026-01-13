/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\contracts_coop.gsc
*****************************************/

init() {
  if(!mayprocesscontracts()) {
    return;
  }

  var_0 = spawnStruct();
  level.contractglobals = var_0;
  scripts\cp\contractchallenges_coop::registercontractchallenges();
  var_0.numchallenges = 0;
  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow("cp\contractChallengesZM.csv", var_1, 0);
    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_0.numchallenges++;
    var_1++;
  }

  level thread onplayerconnect();
}

mayprocesscontracts() {
  if(level.onlinegame) {
    return 1;
  }

  return 0;
}

contractsenabled() {
  if(isai(self)) {
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
  var_0 = self getplayerdata("cp", "contracts", "challenges", 0, "challengeID");
  var_1 = self getplayerdata("cp", "contracts", "challenges", 1, "challengeID");
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
  var_3.progress = self getplayerdata("cp", "contracts", "challenges", var_3.slot, "progress");
  var_4 = 0;
  var_3.completed = var_3.progress >= var_3.target;
  if(!var_3.completed) {
    self thread[[level.contractchallenges[var_3.ref]]](var_3);
    self.contracts[var_1] = var_3;
  }
}

lookupcontractchallengeref(var_0) {
  var_1 = tablelookup("cp\contractChallengesZM.csv", 0, var_0, 1);
  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return var_1;
}

lookupcontractchallengetarget(var_0) {
  var_1 = tablelookup("cp\contractChallengesZM.csv", 0, var_0, 3);
  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return int(var_1);
}

lookupcontractchallengeteam(var_0) {
  var_1 = tablelookup("cp\contractChallengesZM.csv", 0, var_0, 2);
  if(!isDefined(var_1) || var_1 == "") {
    return undefined;
  }

  return int(var_1);
}

updatecontractprogress(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_0.progress = var_0.progress + var_1;
  var_0.progress = int(min(var_0.progress, var_0.target));
  if(!var_0.completed) {
    var_0.completed = var_0.progress >= var_0.target;
    if(var_0.completed) {
      var_2 = scripts\engine\utility::ter_op(var_0.team == -1, "contract_complete_joint_ops", "contract_complete_team_" + var_0.team);
      thread scripts\cp\cp_hud_message::showsplash(var_2);
      self setplayerdata("cp", "contracts", "challenges", var_0.slot, "completed", 1);
    }
  }

  self setplayerdata("cp", "contracts", "challenges", var_0.slot, "progress", var_0.progress);
}