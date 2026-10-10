/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\sentientpoolmanager.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace sentientpoolmanager;

function init() {
  flag_init("sentientpoolmanager_initialized");
  createthreatbiasgroup("Tactical_Static");
  createthreatbiasgroup("Tactical_Moving");
  createthreatbiasgroup("Lethal_Static");
  createthreatbiasgroup("Lethal_Moving");
  createthreatbiasgroup("Level_Vehicle");
  createthreatbiasgroup("Killstreak_Static");
  createthreatbiasgroup("Killstreak_Air");
  createthreatbiasgroup("Killstreak_Ground");
  createthreatbiasgroup("Drone");
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
  level.sentientpools[level.sentientpools.size] = "Drone";
  level.activesentients = [];

  for(i = 0; i < level.sentientpools.size; i++) {
    level.activesentients[level.sentientpools[i]] = [];
  }

  flag_set("sentientpoolmanager_initialized");
}

function registersentient(threatbiasgroup, var_5c00772332ce642c, islethal, var_5f6534ad3a0a1fa2, var_719c179eabb70b31, var_8928fdf873929e88) {
  var_ee6f4af9861df2ab = -1;

  for(i = 0; i < level.sentientpools.size; i++) {
    if(level.sentientpools[i] == threatbiasgroup) {
      var_ee6f4af9861df2ab = i;
      break;
    }
  }

  if(var_ee6f4af9861df2ab == -1) {
    assertex(var_ee6f4af9861df2ab, "<dev string:x1c>" + threatbiasgroup);
    return;
  }

  if(isDefined(self.sentientpool)) {
    return;
  }

  sentientcounts = getsentientcounts();
  sentientlimits = getsentientlimits();

  if(sentientcounts["other"] + sentientcounts["expendable"] >= sentientlimits["other"]) {
    maderoom = level removebestsentient(var_ee6f4af9861df2ab);

    if(!maderoom) {
      return;
    }
  }

  self.sentientpool = threatbiasgroup;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  team = undefined;

  if(isstring(var_5c00772332ce642c)) {
    team = var_5c00772332ce642c;
  } else if(isPlayer(var_5c00772332ce642c)) {
    team = var_5c00772332ce642c.team;
  }

  succeeded = undefined;

  if(isDefined(team) && !isagent(self)) {
    succeeded = self makeentitysentient(team, undefined, var_719c179eabb70b31, var_8928fdf873929e88);
  }

  if(istrue(succeeded)) {
    self setthreatbiasgroup(threatbiasgroup);

    if(istrue(islethal)) {
      self makeentitynomeleetarget();
    }

    level.activesentients[threatbiasgroup][self.sentientpoolindex] = self;
    thread monitorsentient(var_5f6534ad3a0a1fa2);
  }
}

function monitorsentient(var_5f6534ad3a0a1fa2) {
  level endon("game_ended");
  poolid = self.sentientpool;
  keyid = self.sentientpoolindex;

  if(isDefined(var_5f6534ad3a0a1fa2)) {
    waittill_any_3("death", "remove_sentient", var_5f6534ad3a0a1fa2);
  } else {
    waittill_either("death", "remove_sentient");
  }

  unregistersentient(poolid, keyid);
}

function removebestsentient(var_6f03d6ebff31de00) {
  assert(var_6f03d6ebff31de00 >= 0 && var_6f03d6ebff31de00 < level.sentientpools.size);
  bestsentient = undefined;

  for(i = 0; i <= var_6f03d6ebff31de00; i++) {
    assert(isDefined(level.sentientpools[i]));
    bestsentient = getbestsentientfrompool(level.sentientpools[i]);

    if(isDefined(bestsentient)) {
      break;
    }
  }

  if(!isDefined(bestsentient)) {
    return false;
  }

  bestsentient unregistersentient(bestsentient.sentientpool, bestsentient.sentientpoolindex);
  return true;
}

function getbestsentientfrompool(pooltype) {
  bestsentient = undefined;
  oldesttime = undefined;

  foreach(sentient in level.activesentients[pooltype]) {
    if(!isDefined(oldesttime) || sentient.sentientaddedtime < oldesttime) {
      oldesttime = sentient.sentientaddedtime;
      bestsentient = sentient;
    }
  }

  return bestsentient;
}

function unregistersentient(poolid, keyid) {
  if(!isDefined(poolid) || !isDefined(keyid)) {
    return;
  }

  level.activesentients[poolid][keyid] = undefined;

  if(isDefined(self)) {
    self.sentientpool = undefined;
    self.sentientpoolindex = undefined;

    if(!isagent(self)) {
      self freeentitysentient();
    }
  }
}