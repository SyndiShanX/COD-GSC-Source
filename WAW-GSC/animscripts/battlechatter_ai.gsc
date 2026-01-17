/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\battlechatter_ai.gsc
*****************************************************/

#include animscripts\utility;
#include maps\_utility;
#include animscripts\battlechatter;

isHero() {
  return self.npcID == "sul" ||
    self.npcID == "roe" ||
    self.npcID == "pol" ||
    self.npcID == "rez" ||
    self.npcID == "che" ||
    self.npcID == "com";
}

addToSystem(squadName) {
  self endon("death");
  if(!bcsEnabled()) {
    return;
  }
  if(self.chatInitialized) {
    return;
  }
  assert(isDefined(self.squad));
  if(!isDefined(self.squad.chatInitialized) || !self.squad.chatInitialized)
    self.squad init_squadBattleChatter();
  self.enemyClass = "infantry";
  self.calledOut = [];
  if(isPlayer(self)) {
    self.battleChatter = false;
    self.type = "human";
    return;
  }
  if(self.type == "dog") {
    self.enemyClass = undefined;
    self.battlechatter = false;
    return;
  }
  self.countryID = anim.countryIDs[self.voice];
  if(isDefined(self.script_friendname)) {
    friendname = tolower(self.script_friendname);
    if(issubstr(friendname, "sullivan"))
      self.npcID = "sul";
    else if(issubstr(friendname, "roebuck"))
      self.npcID = "roe";
    else if(issubstr(friendname, "polonsky"))
      self.npcID = "pol";
    else if(issubstr(friendname, "reznov"))
      self.npcID = "rez";
    else if(issubstr(friendname, "chernov"))
      self.npcID = "che";
    else if(issubstr(friendname, "commissar"))
      self.npcID = "com";
    else
      self setNPCID();
  } else {
    self setNPCID();
  }
  self thread aiNameAndRankWaiter();
  self init_aiBattleChatter();
  self thread aiThreadThreader();
}

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
    if(usedIDs[(startIndex + index) % numIDs].count < usedIDs[lowestID].count)
      lowestID = (startIndex + index) % numIDs;
  }
  self thread npcIDTracker(lowestID);
  self.npcID = usedIDs[lowestID].npcID;
}

npcIDTracker(lowestID) {
  anim.usedIDs[self.voice][lowestID].count++;
  self waittill("death");
  if(!bcsEnabled()) {
    return;
  }
  anim.usedIDs[self.voice][lowestID].count--;
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

removeFromSystem(squadName) {
  if(!isalive(self) && bcsEnabled()) {
    self aiDeathFriendly();
    self aiDeathEnemy();
  }
  if(isDefined(self)) {
    self.battleChatter = false;
    self.chatInitialized = false;
  }
  self notify("removed from battleChatter");
  if(isDefined(self)) {
    if(getdvar("debug_bclotsoprint") == "on")
      println("BC DEBUG removing " + self.bcname);
    self.chatQueue = undefined;
    self.nextSayTime = undefined;
    self.nextSayTimes = undefined;
    self.isSpeaking = undefined;
    self.enemyClass = undefined;
    self.calledOut = undefined;
    self.countryID = undefined;
    self.npcID = undefined;
  }
}

init_aiBattleChatter() {
  self.chatQueue = [];
  self.chatQueue["threat"] = spawnStruct();
  self.chatQueue["threat"].expireTime = 0;
  self.chatQueue["threat"].priority = 0.0;
  self.chatQueue["response"] = spawnStruct();
  self.chatQueue["response"].expireTime = 0;
  self.chatQueue["response"].priority = 0.0;
  self.chatQueue["reaction"] = spawnStruct();
  self.chatQueue["reaction"].expireTime = 0;
  self.chatQueue["reaction"].priority = 0.0;
  self.chatQueue["inform"] = spawnStruct();
  self.chatQueue["inform"].expireTime = 0;
  self.chatQueue["inform"].priority = 0.0;
  self.chatQueue["order"] = spawnStruct();
  self.chatQueue["order"].expireTime = 0;
  self.chatQueue["order"].priority = 0.0;
  self.chatQueue["custom"] = spawnStruct();
  self.chatQueue["custom"].expireTime = 0;
  self.chatQueue["custom"].priority = 0.0;
  self.nextSayTime = getTime() + 50;
  self.nextSayTimes["threat"] = 0;
  self.nextSayTimes["reaction"] = 0;
  self.nextSayTimes["response"] = 0;
  self.nextSayTimes["inform"] = 0;
  self.nextSayTimes["order"] = 0;
  self.nextSayTimes["custom"] = 0;
  self.isSpeaking = false;
  self.bcs_minPriority = 0.0;
  if(isDefined(self.script_battlechatter) && !self.script_battlechatter)
    self.battleChatter = false;
  else
    self.battleChatter = level.battlechatter[self.team];
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
      if(isalive(self.squad.members[i]) &&
        self.squad.members[i] cansee(self) &&
        distance(self.origin, self.squad.members[i].origin) < 500) {
        self.squad.members[i].bcFriendDeathTime = gettime();
      }
    }
  }
}

aiDeathEnemy() {
  attacker = self.attacker;
  if(!isalive(attacker) || !issentient(attacker) || !isDefined(attacker.squad)) {
    return;
  }
  if(isDefined(self.calledOut[attacker.squad.squadName]) &&
    isalive(self.calledOut[attacker.squad.squadName].spotter) &&
    self.calledOut[attacker.squad.squadName].spotter != attacker &&
    gettime() < self.calledOut[attacker.squad.squadName].expireTime) {
    attacker.bcKillTime = gettime();
  } else if(!isplayer(attacker)) {
    attacker.bcKillTime = gettime();
  }
}

addOrder(type, modifier) {
  self.bcOrderType = type;
  self.bcOrderModifier = modifier;
  self.bcOrderTime = gettime();
}

evaluateMoveEvent(leavingCover) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!bcsEnabled()) {
    return;
  }
  if(!isDefined(self.node)) {
    return;
  }
  dist = distance(self.origin, self.node.origin);
  if(dist < 150) {
    return;
  }
  if(!self isNodeCover()) {
    return;
  }
  if(self.combatTime > 0.0) {
    anim.moveOrigin.origin = self.node.origin;
    self.squad animscripts\squadmanager::updateStates();
    if(self.squad.squadStates["move"].isActive) {
      if(self isHero())
        self addOrder("move", "follow");
      else
        self addOrder("action", "coverme");
    } else {
      addOrder("cover", "generic");
    }
  } else {
    if(self isHero()) {
      self addOrder("move", "forward");
    } else {
      self addOrder("move", "generic");
    }
  }
}

evaluateReloadEvent() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!bcsEnabled()) {
    return;
  }
  self.bcReloadTime = gettime();
}

evaluateMeleeEvent() {
  return false;
}

evaluateFiringEvent() {
  return false;
}

evaluateAttackEvent(type) {
  self endon("death");
  self endon("removed from battleChatter");
  if(!bcsEnabled()) {
    return;
  }
  switch (type) {
    case "grenade":
      self.bcThrewGrenadeTime = gettime();
      break;
  }
}

addSituationalOrder() {
  self endon("death");
  self endon("removed from battleChatter");
  if(!isDefined(self.squad.chatInitialized)) {
    return;
  }
  if(self.squad.squadStates["combat"].isActive)
    self addSituationalCombatOrder();
  else
    self addSituationalIdleOrder();
}

addSituationalIdleOrder() {
  self endon("death");
  self endon("removed from battleChatter");
  squad = self.squad;
  squad animscripts\squadmanager::updateStates();
  if(squad.squadStates["move"].isActive)
    self addOrder("move", "generic");
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
    if(self.team == "allies")
      soldiers = getAIArray("axis");
    else
      soldiers = getAIArray("allies");
    closestSoldier = undefined;
    closestSoldierDistance = 1000000000;
    closestSoldierInCover = undefined;
    closestSoldierInCoverDistance = 1000000000;
    closestSoldierInCoverLocation = undefined;
    for(index = 0; index < soldiers.size; index++) {
      soldier = soldiers[index];
      distance = DistanceSquared(self.origin, soldier.origin);
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
        if(randomfloatrange(0, 1) < .3) {
          self addOrder("action", "boost");
        }
        if(randomfloatrange(0, 1) < .3) {
          self addOrder("action", "supress");
        } else {
          self addOrder("attack", "infantry");
        }
      }
    } else {}
  }
}

beginCustomEvent() {
  if(!bcsEnabled()) {
    return;
  }
  self.customChatPhrase = createChatPhrase();
}