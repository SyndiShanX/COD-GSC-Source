/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\battlechatter_ai.gsc
********************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\battlechatter;

isHero() {
  return self.npcID == "bar" ||
    self.npcID == "lew";
}

addToSystem(squadName) {}
aiThreadThreader() {
  self endon("death");
  self endon("removed from battleChatter");
  assert(isDefined(self.isSpeaking));
  waitTime = 0.5;
  wait(waitTime);
  self thread aiGrenadeDangerWaiter();
  self thread aiFollowOrderWaiter();
  if(self.team == "allies") {
    wait(waitTime);
    self thread aiFlankerWaiter();
    self thread aiDisplaceWaiter();
  }
  wait(waitTime);
  self thread aiBattleChatterLoop();
}

setNPCID() {
  assert(!isDefined(self.npcID));
  usedIDs = anim.usedIDs[self.voice];
  numIDs = usedIDs.size;
  startIndex = randomIntRange(0, numIDs);
  lowestID = startIndex;
  for(index = 0; index <= numIDs; index++) {
    if(usedIDs[(startIndex + index) % numIDs].count < usedIDs[lowestID].count) {
      lowestID = (startIndex + index) % numIDs;
    }
  }
  self thread npcIDTracker(lowestID);
  self.npcID = usedIDs[lowestID].npcID;
}

npcIDTracker(lowestID) {
  voice = self.voice;
  anim.usedIDs[voice][lowestID].count++;
  self waittill("death");
  if(!bcsEnabled()) {
    return;
  }
  anim.usedIDs[voice][lowestID].count--;
}

aiBattleChatterLoop() {}
aiNameAndRankWaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  while(1) {
    self.bcName = self animscripts\battlechatter::getName();
    self.bcRank = self animscripts\battlechatter::getRank();
    self waittill("set name and rank");
  }
}

removeFromSystem(squadName) {}
init_aiBattleChatter() {
  self.chatQueue = [];
  self.chatQueue["threat"] = SpawnStruct();
  self.chatQueue["threat"].expireTime = 0;
  self.chatQueue["threat"].priority = 0.0;
  self.chatQueue["response"] = SpawnStruct();
  self.chatQueue["response"].expireTime = 0;
  self.chatQueue["response"].priority = 0.0;
  self.chatQueue["reaction"] = SpawnStruct();
  self.chatQueue["reaction"].expireTime = 0;
  self.chatQueue["reaction"].priority = 0.0;
  self.chatQueue["inform"] = SpawnStruct();
  self.chatQueue["inform"].expireTime = 0;
  self.chatQueue["inform"].priority = 0.0;
  self.chatQueue["order"] = SpawnStruct();
  self.chatQueue["order"].expireTime = 0;
  self.chatQueue["order"].priority = 0.0;
  self.chatQueue["custom"] = SpawnStruct();
  self.chatQueue["custom"].expireTime = 0;
  self.chatQueue["custom"].priority = 0.0;
  self.nextSayTime = GetTime() + 50;
  self.nextSayTimes["threat"] = 0;
  self.nextSayTimes["reaction"] = 0;
  self.nextSayTimes["response"] = 0;
  self.nextSayTimes["inform"] = 0;
  self.nextSayTimes["order"] = 0;
  self.nextSayTimes["custom"] = 0;
  self.isSpeaking = false;
  self.bcs_minPriority = 0.0;
  if(isDefined(self.script_battlechatter) && !self.script_battlechatter) {
    self.battleChatter = false;
  } else {
    self.battleChatter = level.battlechatter[self.team];
  }
  self.chatInitialized = true;
}

squadOfficerWaiter() {}
getThreats(potentialThreats) {}
squadThreatWaiter() {}
flexibleThreatWaiter() {}
filterThreats(potentialThreats) {}
randomThreatWaiter() {}
aiThreatWaiter() {}
aiGrenadeDangerWaiter() {}
aiFlankerWaiter() {}
aiFlankerOrderWaiter() {}
aiDisplaceWaiter() {}
portableMG42Waiter() {}
aiFollowOrderWaiter() {}
evaluateSuppressionEvent() {}
addThreatEvent(a, b, c) {}
endCustomEvent(x) {}
addGenericAliasEx(a, b, c) {}
aiDeathFriendly() {
  attacker = self.attacker;
  if(isDefined(self)) {
    for(i = 0; i < self.squad.members.size; i++) {
      if(IsAlive(self.squad.members[i]) &&
        self.squad.members[i] cansee(self) &&
        distance(self.origin, self.squad.members[i].origin) < 500) {
        self.squad.members[i].bcFriendDeathTime = GetTime();
      }
    }
  }
}

aiDeathEnemy() {
  attacker = self.attacker;
  if(!IsAlive(attacker) || !IsSentient(attacker) || !isDefined(attacker.squad)) {
    return;
  }
  if(isDefined(self.calledOut[attacker.squad.squadName]) &&
    IsAlive(self.calledOut[attacker.squad.squadName].spotter) &&
    self.calledOut[attacker.squad.squadName].spotter != attacker &&
    GetTime() < self.calledOut[attacker.squad.squadName].expireTime) {
    attacker.bcKillTime = GetTime();
  } else if(!IsPlayer(attacker)) {
    attacker.bcKillTime = GetTime();
  }
}

addOrder(type, modifier) {
  self.bcOrderType = type;
  self.bcOrderModifier = modifier;
  self.bcOrderTime = GetTime();
}

evaluateMoveEvent(leavingCover) {}
evaluateReloadEvent() {}
evaluateMeleeEvent() {}
evaluateFiringEvent() {}
evaluateAttackEvent(type) {}
addSituationalOrder() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!isDefined(self.squad.chatInitialized)) {
    return;
  }
  if(self.squad.squadStates["combat"].isActive) {
    self addSituationalCombatOrder();
  } else {
    self addSituationalIdleOrder();
  }
}

addSituationalIdleOrder() {
  self endon("death");
  self endon("removed from battleChatter");
  squad = self.squad;
  squad animscripts\squadmanager::updateStates();
  if(squad.squadStates["move"].isActive) {
    self addOrder("move", "generic");
  }
}

addSituationalCombatOrder() {
  self endon("death");
  self endon("removed from battleChatter");
  squad = self.squad;
  squad animscripts\squadmanager::updateStates();
  if(squad.squadStates["suppressed"].isActive) {
    if(squad.squadStates["move"].isActive) {
      self addOrder("cover", "generic");
    } else if(squad.squadStates["cover"].isActive) {
      self addOrder("action", "grenade");
    } else {
      self addOrder("cover", "generic");
    }
  } else {
    if(self.team == "allies") {
      soldiers = GetAIArray("axis");
    } else {
      soldiers = GetAIArray("allies");
    }
    closestSoldier = undefined;
    closestSoldierDistance = 1000000000;
    closestSoldierInCover = undefined;
    closestSoldierInCoverDistance = 1000000000;
    closestSoldierInCoverLocation = undefined;
    for(index = 0; index < soldiers.size; index++) {
      soldier = soldiers[index];
      distance = distanceSquared(self.origin, soldier.origin);
      if(closestSoldierDistance > distance) {
        closestSoldierDistance = distance;
        closestSoldier = soldier;
      }
      if(soldier isClaimedNodeCover()) {
        if(closestSoldierInCoverDistance > distance) {
          closestSoldierInCover = soldier;
          closestSoldierInCoverDistance = distance;
        }
      }
    }
    if(isDefined(closestSoldierInCover)) {
      node = closestSoldierInCover bcGetClaimedNode();
      if(isDefined(node) && isDefined(node.script_location)) {
        closestSoldierInCoverLocation = node.script_location;
      }
    }
    if(self canshootenemy()) {
      if(squad.squadStates["attacking"].isActive) {
        if(RandomFloatRange(0, 1) < .3) {
          self addOrder("action", "boost");
        }
        if(RandomFloatRange(0, 1) < .3) {
          self addOrder("action", "supress");
        } else {
          self addOrder("attack", "infantry");
        }
      }
    } else {}
  }
}

beginCustomEvent() {}