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

  for(var0 = 0; var0 < level.sentientpools.size; var0++) {
    level.activesentients[level.sentientpools[var0]] = [];
  }
}

function registersentient(var0, var1, var2, var3, var4, var5) {
  var6 = -1;

  for(var7 = 0; var7 < level.sentientpools.size; var7++) {
    if(level.sentientpools[var7] == var0) {
      var6 = var7;
      break;
    }
  }

  if(var6 == -1) {
    return;
  }

  if(isDefined(self.sentientpool)) {
    return;
  }

  var8 = getsentientlimits();
  var9 = nvidiaanselisenabled();

  if(var8["other"] + var8["expendable"] >= var9["other"]) {
    var10 = removebestsentient(level, var6);

    if(!var10) {
      return;
    }
  }

  self.sentientpool = var0;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  var11 = undefined;

  if(isstring(var1)) {
    var11 = var1;
  } else if(isPlayer(var1)) {
    var11 = var1.team;
  }

  var12 = undefined;

  if(isDefined(var11) && !isagent(self)) {
    var12 = self makeentitysentient(var11, undefined, var4, var5);
  }

  if(istrue(var12)) {
    self setthreatbiasgroup(var0);

    if(istrue(var2)) {
      self makeentitynomeleetarget();
    }

    level.activesentients[var0][self.sentientpoolindex] = self;
    thread monitorsentient(var3);
    return;
  }
}

function monitorsentient(var0) {
  level endon("game_ended");
  var1 = self.sentientpool;
  var2 = self.sentientpoolindex;

  if(isDefined(var0)) {
    scripts\engine\utility::ref_143a6("death", "remove_sentient", var0);
  } else {
    scripts\engine\utility::waittill_either("death", "remove_sentient");
  }

  unregistersentient(var1, var2);
}

function removebestsentient(var0) {
  var1 = undefined;

  for(var2 = 0; var2 <= var0; var2++) {
    var1 = getbestsentientfrompool(level.sentientpools[var2]);

    if(isDefined(var1)) {
      break;
    }
  }

  if(!isDefined(var1)) {
    return false;
  }

  unregistersentient(var1, var1.sentientpool, var1.sentientpoolindex);
  return true;
}

function getbestsentientfrompool(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in level.activesentients[var0]) {
    if(!isDefined(var2) || var4.sentientaddedtime < var2) {
      var2 = var4.sentientaddedtime;
      var1 = var4;
    }
  }

  return var1;
}

function unregistersentient(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  level.activesentients[var0][var1] = undefined;

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