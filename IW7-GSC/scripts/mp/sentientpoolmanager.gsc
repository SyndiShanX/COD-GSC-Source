/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\sentientpoolmanager.gsc
**********************************************/

init() {
  createthreatbiasgroup("Tactical_Static");
  createthreatbiasgroup("Lethal_Static");
  createthreatbiasgroup("Lethal_Moving");
  createthreatbiasgroup("Killstreak_Air");
  createthreatbiasgroup("Killstreak_Ground");
  setignoremegroup("Killstreak_Ground", "Killstreak_Ground");
  setignoremegroup("Killstreak_Air", "Killstreak_Ground");
  setignoremegroup("Killstreak_Air", "Killstreak_Air");
  setignoremegroup("Killstreak_Ground", "Killstreak_Air");
  level.sentientpools = [];
  level.sentientpools[level.sentientpools.size] = "Tactical_Static";
  level.sentientpools[level.sentientpools.size] = "Lethal_Static";
  level.sentientpools[level.sentientpools.size] = "Lethal_Moving";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Air";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Ground";
  level.activesentients = [];
  for(var_0 = 0; var_0 < level.sentientpools.size; var_0++) {
    level.activesentients[level.sentientpools[var_0]] = [];
  }

  level.activesentientcount = 0;
}

registersentient(var_0, var_1, var_2, var_3) {
  var_4 = -1;
  for(var_5 = 0; var_5 < level.sentientpools.size; var_5++) {
    if(level.sentientpools[var_5] == var_0) {
      var_4 = var_5;
      break;
    }
  }

  if(var_4 == -1) {
    return;
  }

  if(isDefined(self.sentientpool)) {
    return;
  }

  if(level.activesentientcount == 24) {
    var_6 = level removebestsentient(var_4 + 1);
    if(!var_6) {
      return;
    }
  }

  self.sentientpool = var_0;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  if(!isagent(self)) {
    self makeentitysentient(var_1.team);
  }

  self give_zombies_perk(var_0);
  if(scripts\mp\utility::istrue(var_2)) {
    self makeentitynomeleetarget();
  }

  level.activesentients[var_0][self.sentientpoolindex] = self;
  level.activesentientcount++;
  thread monitorsentient(var_3);
}

monitorsentient(var_0) {
  level endon("game_ended");
  var_1 = self.sentientpool;
  var_2 = self.sentientpoolindex;
  if(isDefined(var_0)) {
    scripts\engine\utility::waittill_any_3("death", "remove_sentient", var_0);
  } else {
    scripts\engine\utility::waittill_either("death", "remove_sentient");
  }

  unregistersentient(var_1, var_2);
}

removebestsentient(var_0) {
  var_1 = undefined;
  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1 = getbestsentientfrompool(level.sentientpools[var_2]);
    if(isDefined(var_1)) {
      break;
    }
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_1 unregistersentient(var_1.sentientpool, var_1.sentientpoolindex);
  return 1;
}

getbestsentientfrompool(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  foreach(var_4 in level.activesentients[var_0]) {
    if(var_2 == undefined || var_4.sentientaddedtime < var_2) {
      var_2 = var_4.sentientaddedtime;
      var_1 = var_4;
    }
  }

  return var_1;
}

unregistersentient(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  level.activesentients[var_0][var_1] = undefined;
  level.activesentientcount--;
  if(isDefined(self)) {
    self.sentientpool = undefined;
    self.sentientpoolindex = undefined;
    if(!isagent(self)) {
      self freeentitysentient();
    }
  }
}