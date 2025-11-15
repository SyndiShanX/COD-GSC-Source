/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  for(var_00 = 0; var_00 < level.sentientpools.size; var_00++) {
    level.activesentients[level.sentientpools[var_00]] = [];
  }

  level.activesentientcount = 0;
}

registersentient(param_00, param_01, param_02, param_03) {
  var_04 = -1;
  for(var_05 = 0; var_05 < level.sentientpools.size; var_05++) {
    if(level.sentientpools[var_05] == param_00) {
      var_04 = var_05;
      break;
    }
  }

  if(var_04 == -1) {
    return;
  }

  if(isDefined(self.sentientpool)) {
    return;
  }

  if(level.activesentientcount == 24) {
    var_06 = level removebestsentient(var_04 + 1);
    if(!var_06) {
      return;
    }
  }

  self.sentientpool = param_00;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  if(!isagent(self)) {
    self makeentitysentient(param_01.team);
  }

  self give_zombies_perk(param_00);
  if(scripts\mp\utility::istrue(param_02)) {
    self makeentitynomeleetarget();
  }

  level.activesentients[param_00][self.sentientpoolindex] = self;
  level.activesentientcount++;
  thread monitorsentient(param_03);
}

monitorsentient(param_00) {
  level endon("game_ended");
  var_01 = self.sentientpool;
  var_02 = self.sentientpoolindex;
  if(isDefined(param_00)) {
    scripts\engine\utility::waittill_any_3("death", "remove_sentient", param_00);
  } else {
    scripts\engine\utility::waittill_either("death", "remove_sentient");
  }

  unregistersentient(var_01, var_02);
}

removebestsentient(param_00) {
  var_01 = undefined;
  for(var_02 = 0; var_02 < param_00; var_02++) {
    var_01 = getbestsentientfrompool(level.sentientpools[var_02]);
    if(isDefined(var_01)) {
      break;
    }
  }

  if(!isDefined(var_01)) {
    return 0;
  }

  var_01 unregistersentient(var_01.sentientpool, var_01.sentientpoolindex);
  return 1;
}

getbestsentientfrompool(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in level.activesentients[param_00]) {
    if(var_02 == undefined || var_04.sentientaddedtime < var_02) {
      var_02 = var_04.sentientaddedtime;
      var_01 = var_04;
    }
  }

  return var_01;
}

unregistersentient(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  level.activesentients[param_00][param_01] = undefined;
  level.activesentientcount--;
  if(isDefined(self)) {
    self.sentientpool = undefined;
    self.sentientpoolindex = undefined;
    if(!isagent(self)) {
      self freeentitysentient();
    }
  }
}