/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\battlechatter.gsc
*****************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include maps\_utility;
#include animscripts\battlechatter_ai;

init_battleChatter() {}
player_init() {}
shutdown_battleChatter() {
  anim.countryIDs = undefined;
  anim.eventTypeMinWait = undefined;
  anim.eventActionMinWait = undefined;
  anim.eventTypeMinWait = undefined;
  anim.eventPriority = undefined;
  anim.eventDuration = undefined;
  anim.chatCount = undefined;
  anim.moveOrigin = undefined;
  anim.areas = undefined;
  anim.locations = undefined;
  anim.landmarks = undefined;
  anim.usedIDs = undefined;
  anim.chatInitialized = false;
  level.battlechatter = undefined;
  for(i = 0; i < anim.squadCreateFuncs.size; i++) {
    if(anim.squadCreateStrings[i] != "::init_squadBattleChatter") {
      continue;
    }
    if(i != (anim.squadCreateFuncs.size - 1)) {
      anim.squadCreateFuncs[i] = anim.squadCreateFuncs[anim.squadCreateFuncs.size - 1];
      anim.squadCreateStrings[i] = anim.squadCreateStrings[anim.squadCreateStrings.size - 1];
    }
    anim.squadCreateFuncs[anim.squadCreateFuncs.size - 1] = undefined;
    anim.squadCreateStrings[anim.squadCreateStrings.size - 1] = undefined;
  }
  level notify("battlechatter disabled");
  anim notify("battlechatter disabled");
}

resetSayTime(name) {
  self.nextSayTimes[name] = GetTime() + 50;
}

resetSayTimes() {
  self.nextSayTime = GetTime();
  resetSayTime("threat");
  resetSayTime("order");
  resetSayTime("reaction");
  resetSayTime("response");
  resetSayTime("inform");
  resetSayTime("custom");
}

init_squadBattleChatter() {}
shutdown_squadBattleChatter() {
  squad = self;
  squad.maxSpeakers = undefined;
  squad.nextSayTime = undefined;
  squad.nextSayTimes = undefined;
  squad.nextTypeSayTimes = undefined;
  squad.isMemberSaying = undefined;
  for(i = 0; i < squad.memberAddFuncs.size; i++) {
    if(squad.memberAddStrings[i] != "::addToSystem") {
      continue;
    }
    if(i != (squad.memberAddFuncs.size - 1)) {
      squad.memberAddFuncs[i] = squad.memberAddFuncs[squad.memberAddFuncs.size - 1];
      squad.memberAddStrings[i] = squad.memberAddStrings[squad.memberAddStrings.size - 1];
    }
    squad.memberAddFuncs[squad.memberAddFuncs.size - 1] = undefined;
    squad.memberAddStrings[squad.memberAddStrings.size - 1] = undefined;
  }
  for(i = 0; i < squad.memberRemoveFuncs.size; i++) {
    if(squad.memberRemoveStrings[i] != "::removeFromSystem") {
      continue;
    }
    if(i != (squad.memberRemoveFuncs.size - 1)) {
      squad.memberRemoveFuncs[i] = squad.memberRemoveFuncs[squad.memberRemoveFuncs.size - 1];
      squad.memberRemoveStrings[i] = squad.memberRemoveStrings[squad.memberRemoveStrings.size - 1];
    }
    squad.memberRemoveFuncs[squad.memberRemoveFuncs.size - 1] = undefined;
    squad.memberRemoveStrings[squad.memberRemoveStrings.size - 1] = undefined;
  }
  for(i = 0; i < squad.squadUpdateFuncs.size; i++) {
    if(squad.squadUpdateStrings[i] != "::initContact") {
      continue;
    }
    if(i != (squad.squadUpdateFuncs.size - 1)) {
      squad.squadUpdateFuncs[i] = squad.squadUpdateFuncs[squad.squadUpdateFuncs.size - 1];
      squad.squadUpdateStrings[i] = squad.squadUpdateStrings[squad.squadUpdateStrings.size - 1];
    }
    squad.squadUpdateFuncs[squad.squadUpdateFuncs.size - 1] = undefined;
    squad.squadUpdateStrings[squad.squadUpdateStrings.size - 1] = undefined;
  }
  for(i = 0; i < anim.squadIndex.size; i++) {
    squad shutdownContact(anim.squadIndex[i].squadName);
  }
  squad.chatInitialized = false;
}

initContact(squadName) {
  if(!isDefined(self.squadList[squadName].calledOut)) {
    self.squadList[squadName].calledOut = false;
  }
  if(!isDefined(self.squadList[squadName].firstContact)) {
    self.squadList[squadName].firstContact = 2000000000;
  }
  if(!isDefined(self.squadList[squadName].lastContact)) {
    self.squadList[squadName].lastContact = 0;
  }
}

shutdownContact(squadName) {
  self.squadList[squadName].calledOut = undefined;
  self.squadList[squadName].firstContact = undefined;
  self.squadList[squadName].lastContact = undefined;
}

bcsEnabled() {
  return anim.chatInitialized;
}

bcsDebugWaiter() {}
enableBattleChatter() {}
disableBattleChatter() {}
playBattleChatter() {}
samePhrase(a, b) {
  assert(isDefined(a));
  assert(isDefined(b));
  if(a.soundAliases.size != b.soundAliases.size) {
    return false;
  }
  for(i = 0; i < a.soundAliases.size; i++) {
    if(a.soundAliases[i] != b.soundAliases[i]) {
      return false;
    }
  }
  return true;
}

initHistory() {
  level.bcHistoryCount = 100;
  level.bcHistoryPhrases = [];
  level.bcHistoryTimes = [];
  level.bcHistoryIndex = 0;
}

addPhraseToHistory(phrase) {
  assert(isDefined(level.bcHistoryIndex));
  i = level.bcHistoryIndex;
  assert(isDefined(i));
  level.bcHistoryPhrases[i] = phrase;
  level.bcHistoryTimes[i] = GetTime();
  assert(isDefined(i));
  level.bcHistoryIndex = (i + 1) % level.bcHistoryCount;
}

isDupePhrase(phrase, threshold) {
  for(i = 0; i < level.bcHistoryCount; i++) {
    if(isDefined(level.bcHistoryPhrases[i]) &&
      samePhrase(level.bcHistoryPhrases[i], phrase) &&
      GetTime() - level.bcHistoryTimes[i] < threshold) {
      if(getDvar(#"debug_bclotsoprint") == "on") {
        println("BC DEBUG history skip time " + GetTime() + " " + level.bcHistoryTimes[i] + " " + (GetTime() - level.bcHistoryTimes[i]));
      }
      return true;
    }
  }
  return false;
}

delayed_notify(n, time, end) {
  self endon(end);
  wait(time);
  if(isDefined(self)) {
    self notify(n);
  }
}

nearestPlayer() {
  players = GetPlayers();
  if(players.size == 0) {
    return undefined;
  }
  distance = distanceSquared(players[0].origin, self.origin);
  player = players[0];
  for(i = 1; i < players.size; i++) {
    d = distanceSquared(players[i].origin, self.origin);
    if(d < distance) {
      distance = d;
      player = players[i];
    }
  }
  return player;
}

typeLimited(strAction, strType) {
  if(!isDefined(anim.eventTypeMinWait[strAction][strType])) {
    return (false);
  }
  if(!isDefined(self.squad.nextTypeSayTimes[strAction][strType])) {
    return (false);
  }
  if(GetTime() > self.squad.nextTypeSayTimes[strAction][strType]) {
    return (false);
  }
  return (true);
}

doTypeLimit(strAction, strType) {
  if(!isDefined(anim.eventTypeMinWait[strAction][strType])) {
    return;
  }
  self.squad.nextTypeSayTimes[strAction][strType] = GetTime() + anim.eventTypeMinWait[strAction][strType];
}

bcIsSniper() {
  if(IsPlayer(self)) {
    return (false);
  }
  return animscripts\combat_utility::isSniperRifle(self.weapon);
}

isExposed() {}
isClaimedNodeCover() {
  node = self bcGetClaimedNode();
  if(!isDefined(node)) {
    return (false);
  }
  if((node.type[0] == "C") &&
    (node.type[1] == "o") &&
    (node.type[2] == "v")) {
    return (true);
  }
  return (false);
}

isNodeCover() {
  node = self.node;
  if(!isDefined(node)) {
    return (false);
  }
  if((node.type[0] == "C") &&
    (node.type[1] == "o") &&
    (node.type[2] == "v")) {
    return (true);
  }
  return (false);
}

isOfficer() {
  fullRank = self getRank();
  if(fullRank == "sergeant" || fullRank == "lieutenant" || fullRank == "captain" || fullRank == "sergeant") {
    return (true);
  }
  return (false);
}

bcGetClaimedNode() {
  if(IsPlayer(self)) {
    node = self.node;
  } else {
    node = self GetClaimedNode();
  }
}

getName() {
  name = undefined;
  if(self.team == "axis") {
    name = self.name;
  } else if(self.team == "allies") {
    name = self.name;
  }
  if(!isDefined(name) && isDefined(self.script_friendname)) {
    name = self.script_friendname;
  }
  if(!isDefined(name) || self.voice == "british") {
    return (undefined);
  }
  tokens = strtok(name, " ");
  if(tokens.size == 1) {
    return tokens[0];
  }
  if(tokens.size >= 2) {
    return tokens[1];
  }
  return undefined;
}

getRank() {
  return self.airank;
}

getClosestSpeaker(strAction, strType, officerOnly) {
  speakers = self getSpeakers(strAction, strType, officerOnly);
  speaker = getClosest(self.origin, speakers);
  return (speaker);
}

getSpeakers(strAction, strType, officersOnly) {
  speakers = [];
  soldiers = GetAIArray(self.team);
  if(isDefined(officersOnly) && officersOnly) {
    officers = [];
    for(i = 0; i < soldiers.size; i++) {
      if(soldiers[i] isOfficer()) {
        officers[officers.size] = soldiers[i];
      }
    }
    soldiers = officers;
  }
  for(i = 0; i < soldiers.size; i++) {
    if(soldiers[i] == self) {
      continue;
    }
    if(!soldiers[i] bcCanSay(strAction, strType)) {
      continue;
    }
    speakers[speakers.size] = soldiers[i];
  }
  return (speakers);
}

getArea() {
  areas = anim.areas;
  for(i = 0; i < areas.size; i++) {
    if(self istouching(areas[i]) && isDefined(areas[i].script_area)) {
      return (areas[i]);
    }
  }
  return (undefined);
}

getLocation() {
  locations = anim.locations;
  for(i = 0; i < locations.size; i++) {
    if(self istouching(locations[i]) && isDefined(locations[i].script_location)) {
      return (locations[i]);
    }
  }
  return (undefined);
}

getLandmark() {
  landmarks = anim.landmarks;
  for(i = 0; i < landmarks.size; i++) {
    if(self istouching(landmarks[i]) && isDefined(landmarks[i].script_landmark)) {
      return (landmarks[i]);
    }
  }
  return (undefined);
}

getDirectionCompass(vOrigin, vPoint) {
  angles = VectorToAngles(vPoint - vOrigin);
  angle = angles[1];
  northYaw = getnorthyaw();
  angle -= northYaw;
  if(angle < 0) {
    angle += 360;
  } else if(angle > 360) {
    angle -= 360;
  }
  if(angle < 22.5 || angle > 337.5) {
    direction = "north";
  } else if(angle < 67.5) {
    direction = "northwest";
  } else if(angle < 112.5) {
    direction = "west";
  } else if(angle < 157.5) {
    direction = "southwest";
  } else if(angle < 202.5) {
    direction = "south";
  } else if(angle < 247.5) {
    direction = "southeast";
  } else if(angle < 292.5) {
    direction = "east";
  } else if(angle < 337.5) {
    direction = "northeast";
  } else {
    direction = "impossible";
  }
  return (direction);
}

getDirectionReferenceSide(vOrigin, vPoint, vReference) {
  anglesToReference = VectorToAngles(vReference - vOrigin);
  anglesToPoint = VectorToAngles(vPoint - vOrigin);
  angle = anglesToReference[1] - anglesToPoint[1];
  angle += 360;
  angle = int(angle) % 360;
  if(angle > 180) {
    angle -= 360;
  }
  if(angle > 2 && angle < 45) {
    side = "right";
  } else if(angle < -2 && angle > -45) {
    side = "left";
  } else {
    if(distance(vOrigin, vPoint) < distance(vOrigin, vReference)) {
      side = "front";
    } else {
      side = "rear";
    }
  }
  return (side);
}

getDirectionFacingFlank(vOrigin, vPoint, vFacing) {
  anglesToFacing = VectorToAngles(vFacing);
  anglesToPoint = VectorToAngles(vPoint - vOrigin);
  angle = anglesToFacing[1] - anglesToPoint[1];
  angle += 360;
  angle = int(angle) % 360;
  if(angle > 315 || angle < 45) {
    direction = "front";
  } else if(angle < 135) {
    direction = "right";
  } else if(angle < 225) {
    direction = "rear";
  } else {
    direction = "left";
  }
  return (direction);
}

getVectorRightAngle(vDir) {
  return (vDir[1], 0 - vDir[0], vDir[2]);
}

getVectorArrayAverage(avAngles) {
  vDominantDir = (0, 0, 0);
  for(i = 0; i < avAngles.size; i++) {
    vDominantDir += avAngles[i];
  }
  return (vDominantDir[0] / avAngles.size, vDominantDir[1] / avAngles.size, vDominantDir[2] / avAngles.size);
}

addAlias(name) {
  if(soundExists(name)) {
    self.soundAliases[self.soundAliases.size] = name;
    return true;
  } else {
    println("ERROR BC cannot find alias " + name);
    return false;
  }
}

createChatPhrase() {
  chatPhrase = SpawnStruct();
  chatPhrase.owner = self;
  chatPhrase.soundAliases = [];
  chatPhrase.master = false;
  return chatPhrase;
}

canSeePoint(origin) {
  forward = AnglesToForward(self.angles);
  return (vectordot(forward, origin - self.origin) > 0.766);
}

pointInFov(origin) {
  forward = AnglesToForward(self.angles);
  return (vectordot(forward, origin - self.origin) > 0.766);
}

resetNextSayTimes(team, action) {}
bcGetName() {
  name = undefined;
  if(self.team == "axis") {
    name = self.name;
  } else if(self.team == "allies") {
    name = self.name;
  }
  if(!isDefined(name) && isDefined(self.script_friendname)) {
    name = self.script_friendname;
  }
  if(!isDefined(name) || self.voice == "british") {
    return (undefined);
  }
  tokens = strtok(name, " ");
  if(tokens.size == 1) {
    return tokens[0];
  }
  if(tokens.size >= 2) {
    return tokens[1];
  }
  return undefined;
}

bcCanSay(eventAction, eventType, priority, modifier) {
  assert(isDefined(eventAction));
  assert(isDefined(eventType));
  isGrenade = false;
  if(isDefined(eventAction) && eventAction == "inform" &&
    isDefined(eventType) && eventType == "incoming" &&
    isDefined(modifier) && modifier == "grenade"
  ) {
    isGrenade = true;
  }
  if(isDefined(eventAction) && eventAction == "inform" &&
    isDefined(eventType) && eventType == "attack" &&
    isDefined(modifier) && modifier == "grenade"
  ) {
    isGrenade = true;
  }
  if(isDefined(eventAction) && eventAction == "threat" &&
    isDefined(eventType) && eventType == "bansai"
  ) {
    isGrenade = true;
  }
  if(IsPlayer(self)) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because i'm a player " + self.bcname);
    }
    return false;
  }
  if(isDefined(self.isTalking) && self.isTalking) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because i'm talking " + self.bcname);
    }
    return false;
  }
  if(isDefined(self.isSpeaking) && self.isSpeaking) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because i'm speaking " + self.bcname);
    }
    return false;
  }
  if(!isDefined(self.nextSayTimes)) {
    msg = "AI at origin " + self.origin + ", classname " + self.classname;
    msg += ", doesn't have the self.nextSayTimes array set up, which the battlechatter system needs! ";
    msg += "This likely means that animscripts\battlechatter_ai::removeFromSystem() was run ";
    msg += "on this guy, but he hasn't been deleted. ";
    msg += "Did you accidentally notify \'death\' without deleting the AI?";
    ASSERTMSG(msg);
    return false;
  }
  if(!isDefined(self.battlechatter) || !self.battlechatter) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because of self.battlechatter " + self.bcname);
    }
    return false;
  }
  if(!isGrenade && isDefined(level.NumberOfImportantPeopleTalking) && level.NumberOfImportantPeopleTalking > 0) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because important people are talking " + level.NumberOfImportantPeopleTalking + " " + self.bcname);
    }
    return false;
  }
  timeout = 3000;
  if(self.team == "axis") {
    timeout = 1800;
  } else if(self.team == "allies") {
    timeout = 1000;
  }
  if(isDefined(level.ImportantPeopleTalkingTime) && (GetTime() - level.ImportantPeopleTalkingTime) < timeout) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because important people were talking " + level.NumberOfImportantPeopleTalking + " " + self.bcname + " " + (GetTime() - level.ImportantPeopleTalkingTime));
    }
    return false;
  }
  np = nearestPlayer();
  if(!isDefined(np)) {
    println("BC DEBUG cannot say because there are no people");
    return false;
  }
  if(np.team == self.team) {
    cullDist = 2000;
  } else {
    cullDist = 3000;
  }
  if(distanceSquared(np.origin, self.origin) > cullDist * cullDist) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say, too far from player " + self.bcname);
    }
    return false;
  }
  if(!isGrenade && GetTime() < self.nextSayTimes[eventAction]) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because of self wait " + self.bcname);
    }
    return (false);
  }
  if(!isGrenade && GetTime() < self.squad.nextSayTimes[eventAction]) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because of squad wait " + self.bcname + " " + self.squad.squadName);
    }
    return (false);
  }
  if(!isGrenade && isDefined(eventType) && typeLimited(eventAction, eventType)) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because of typeLimit " + self.bcname);
    }
    return (false);
  }
  if(isDefined(eventType) && !isDefined(anim.eventPriority[eventAction][eventType])) {
    println("BC priority not set for eventType " + eventType + " " + eventAction);
  } else if(!isGrenade && isDefined(eventType) && anim.eventPriority[eventAction][eventType] < self.bcs_minPriority) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG cannot say because of minPriority " + self.bcname);
    }
    return (false);
  }
  if(getDvar(#"debug_bclotsoprint") == "on") {
    println("BC DEBUG can say because of self wait " + GetTime() + " " + anim.eventActionMinWait[eventAction]["self"] + " " + self.nextSayTimes[eventAction] + "" + self.bcname);
    println("BC DEBUG can say because of squad wait " + GetTime() + " " + anim.eventActionMinWait[eventAction]["squad"] + " " + self.squad.nextSayTimes[eventAction] + "" + self.bcname);
  }
  return (true);
}

bcPlayPhrase(eventAction, eventType, chatPhrase, decCallCount) {
  if(!isDefined(decCallCount)) {
    decCallCount = false;
  }
  if(getDvar(#"debug_bclotsoprint") == "on") {
    a = "";
    for(i = 0; i < chatPhrase.soundAliases.size; i++) {
      a += chatPhrase.soundAliases[i] + " ";
    }
    println("BC DEBUG saying " + a);
  }
  if(chatPhrase.soundAliases.size == 0) {
    println("BC ERROR tried to play empty phrase" + self.bcname);
    return;
  }
  if(isDupePhrase(chatPhrase, 10000)) {
    if(getDvar(#"debug_bclotsoprint") == "on") {
      println("BC DEBUG skipping because of identical phrase " + self.bcname);
    }
    return;
  }
  addPhraseToHistory(chatPhrase);
  squad = self.squad;
  team = self.team;
  self.isSpeaking = true;
  self.nextSayTimes[eventAction] = GetTime() + anim.eventActionMinWait[eventAction]["self"];
  squad.nextSayTimes[eventAction] = GetTime() + anim.eventActionMinWait[eventAction]["squad"];
  for(i = 0; i < chatPhrase.soundAliases.size; i++) {
    if(SoundExists(chatPhrase.soundAliases[i])) {
      self animscripts\face::PlayFaceThread(undefined, chatPhrase.soundAliases[i], .5, chatPhrase.soundAliases[i]);
      if(!isDefined(self)) {
        break;
      }
    } else {
      println("ERROR BC: needed alias does not exist:" + chatPhrase.soundAliases[i]);
      wait(1.0);
    }
  }
  if(getDvar(#"debug_bclotsoprint") == "on") {
    a = "";
    for(i = 0; i < chatPhrase.soundAliases.size; i++) {
      a += chatPhrase.soundAliases[i] + " ";
    }
    println("BC DEBUG done saying " + a);
  }
  if(isDefined(self)) {
    self.isSpeaking = false;
    self doTypeLimit(eventAction, eventType);
    if(isDefined(self.bcCalling) && isDefined(self.bcCalling.bcCallCount) && decCallCount) {
      self.bcCalling.bcCallCount[self.team] -= 1;
    }
  }
}

filter(potentialThreats, isThreat) {
  threats = [];
  for(i = 0; i < potentialThreats.size; i++) {
    players = GetPlayers();
    for(p = 0; p < players.size; p++) {
      if(potentialThreats[i][
          [isThreat]
        ](players[p])) {
        threats[threats.size] = potentialThreats[i];
        break;
      }
    }
  }
  return threats;
}

getThreat(team, threats, threatDistance, callCount) {
  players = GetPlayers();
  closest = threatDistance;
  threat = undefined;
  for(i = 0; i < threats.size; i++) {
    if(!isDefined(threats[i].bcCallCount)) {
      threats[i].bcCallCount = [];
      threats[i].bcCallCount["axis"] = 0;
      threats[i].bcCallCount["allies"] = 0;
    }
    for(p = 0; p < players.size; p++) {
      d = distance(threats[i].origin, players[p].origin);
      if(d < closest && (callCount == 0 || threats[i].bcCallCount[team] < callCount)) {
        closest = d;
        threat = threats[i];
        threat.bcthreatplayer = players[p];
      }
    }
  }
  return threat;
}

getClosestToPlayer(list) {
  players = GetPlayers();
  closest = 0;
  obj = undefined;
  for(i = 0; i < list.size; i++) {
    for(p = 0; p < players.size; p++) {
      d = distance(list[i].origin, players[p].origin);
      if(d < 1) {
        continue;
      }
      if(closest == 0 || d < closest) {
        obj = list[i];
        closest = d;
      }
    }
  }
  return obj;
}

getNearestTalker(origin, threat, friends, action, type, modifier) {
  talkers = [];
  for(i = 0; i < friends.size; i++) {
    if(isDefined(threat) && isDefined(friends[i].bcCalling) && friends[i].bcCalling == threat) {
      continue;
    }
    if(friends[i] bcCanSay(action, type, 1.0, modifier)) {
      talkers[talkers.size] = friends[i];
    }
  }
  if(talkers.size == 0) {
    return undefined;
  }
  return getClosest(origin, talkers);
}

getAlias(action, type, modifier) {
  alias = self.countryID + "_" + self.npcID;
  if(isDefined(action)) {
    alias += "_" + action;
  }
  if(isDefined(type)) {
    alias += "_" + type;
  }
  if(isDefined(modifier)) {
    alias += "_" + modifier;
  }
  return alias;
}

getBCLocation() {
  if(isDefined(self.node) && isDefined(self.node.script_area)) {
    return self.node.script_area;
  }
  triggers = array_combine(anim.locations, anim.landmarks);
  for(i = 0; i < triggers.size; i++) {
    if(self istouching(triggers[i])) {
      if(isDefined(triggers[i].script_area)) {
        return triggers[i].script_area;
      }
      if(isDefined(triggers[i].script_landmark)) {
        return triggers[i].script_landmark;
      }
      if(isDefined(triggers[i].script_location)) {
        return triggers[i].script_location;
      }
    }
  }
  return undefined;
}

tryAddLocation(talker, object) {
  a = object getBCLocation();
  if(isDefined(a)) {
    self addAlias(talker getAlias("landmark", "near", a));
  }
}

tryThreat(friends, them, distance, count, filter, action, type, modifier, doLocation) {
  threat = filter(them, filter);
  threat = getThreat("allies", threat, distance, count);
  if(!isDefined(threat)) {
    return false;
  }
  talker = getNearestTalker(threat.origin, threat, friends, action, type, modifier);
  if(!isDefined(talker)) {
    return false;
  }
  talker.bcCalling = threat;
  threat.bcCallCount[talker.team] += 1;
  threat.bcCalloutTime = GetTime();
  phrase = talker createChatPhrase();
  phrase.threatEnt = threat;
  phrase addAlias(talker getAlias(action, type, modifier));
  if(doLocation && RandomFloat(1) < .5) {
    phrase tryAddLocation(talker, threat);
  }
  talker thread bcPlayPhrase(action, type, phrase, true);
  return true;
}

isGrenade(player) {
  if(isDefined(self.model) && self.model == "mortar_shell") {
    return false;
  }
  if(isDefined(self.model) && self.model == "projectile_us_smoke_grenade") {
    return false;
  }
  if(player.team == "allies" && self.model == "") {
    return false;
  }
  if(isDefined(self.bcCalloutTime) && (GetTime() - self.bcCalloutTime) > 1000) {
    return false;
  }
  if(distance(self.origin, player.origin) > 400) {
    return false;
  }
  return true;
}

isMg(player) {
  if(isDefined(self.bcCalloutTime)) {
    if((GetTime() - self.bcCalloutTime) < 6000) {
      return false;
    }
    if((GetTime() - self.bcCalloutTime) > 30000) {
      self.bcCalloutTime = undefined;
      self.bcCallCount["axis"] = 0;
      self.bcCallCount["allies"] = 0;
    }
  }
  return self cansee(player) || distance(player.origin, self.origin) < 300;
}

isBanzai(player) {
  playerIsTarget = false;
  if(isDefined(self.banzai) && self.banzai) {
    if(isDefined(self.enemy) && IsPlayer(self.enemy)) {
      playerIsTarget = true;
    }
    if(isDefined(self.target) && IsPlayer(self.target)) {
      playerIsTarget = true;
    }
    if(isDefined(self.favoriteenemy) && IsPlayer(self.favoriteenemy)) {
      playerIsTarget = true;
    }
    if(!playerIsTarget) {
      return false;
    }
    if(!isDefined(self.bcNoticeTime)) {
      self.bcNoticeTime = GetTime();
    }
    if(GetTime() - self.bcNoticeTime < 1000) {
      return false;
    }
    if(isDefined(self.bcCalloutTime)) {
      return (GetTime() - self.bcCalloutTime) < 4000;
    }
    return true;
  }
  return false;
}

isInfantry(player) {
  return self cansee(player) && distance(player.origin, self.origin) < 1000;
}

getAllTurrets(team) {
  t = [];
  turrets = array_combine(getentarray("misc_mg42", "classname"), getentarray("misc_turret", "classname"));
  for(i = 0; i < turrets.size; i++) {
    dude = turrets[i] getturretowner();
    if(isDefined(dude) && dude.team == team) {
      t[t.size] = dude;
    }
  }
  return t;
}

isSurpressed(player) {
  valid = false;
  if(isDefined(self.suppressed) && self.suppressed) {
    if(!isDefined(self.bcSurpressedTime)) {
      valid = true;
    } else {
      valid = GetTime() - self.bcSurpressedTime > 3000;
    }
  }
  if(valid) {
    valid = self bcCanSay("inform", "supressed", 1.0, "generic");
  }
  return valid;
}

trySurpressed(team) {
  players = GetPlayers();
  sp = filter(team, ::isSurpressed);
  talker = getNearestTalker(players[0], undefined, sp, "inform", "supressed");
  if(!isDefined(talker)) {
    return false;
  }
  talker.bcSurpressedTime = GetTime();
  phrase = talker createChatPhrase();
  phrase addAlias(talker getAlias("inform", "supressed", 1.0, "generic"));
  talker thread bcPlayPhrase("inform", "supressed", phrase, false);
  return true;
}

findGuyToYellAt(team, notme) {
  for(i = 0; i < team.size; i++) {
    if(notme.npcID == team[i].npcID) {
      continue;
    }
    if(notme cansee(team[i])) {
      return team[i];
    }
    if(distance(notme.origin, team[i].origin) < 500) {
      return team[i];
    }
  }
  return undefined;
}

canSeeAny(team) {
  for(i = 0; i < team.size; i++) {
    if(isDefined(team[i]) && team[i] cansee(self)) {
      return true;
    }
  }
  return false;
}

doReload(otherteam, talker, yellat) {
  phrase = talker createChatPhrase();
  if(isDefined(yellat)) {
    phrase addAlias(talker getAlias("name", yellat bcGetName()));
  }
  if(talker canSeeAny(otherteam)) {
    phrase addAlias(talker getAlias("order", "action", "coverme"));
  }
  phrase addAlias(talker getAlias("inform", "reloading", "generic"));
  talker thread bcPlayPhrase("order", "action", phrase, false);
  if(!isDefined(yellat) || !isDefined(yellat.nextSayTimes) || !yellat bcCanSay("response", "ack", 1.0)) {
    return;
  }
  phrase = yellat createChatPhrase();
  phrase addAlias(yellat getAlias("response", "ack", "covering"));
  yellat thread bcPlayPhrase("response", "ack", phrase, false);
}

tryReload(team, otherteam) {
  for(i = 0; i < team.size; i++) {
    if(isDefined(team[i].bcReloadTime) &&
      (GetTime() - team[i].bcReloadTime) < 2000 &&
      team[i] bcCanSay("order", "action")
    ) {
      thread doReload(otherteam, team[i], findGuyToYellAt(team, team[i]));
      return true;
    }
  }
  return false;
}

doOrder(talker, yellat, type, modifier) {
  phrase = talker createChatPhrase();
  if(isDefined(yellat) && RandomFloat(1) < .6) {
    phrase addAlias(talker getAlias("name", yellat bcGetName()));
  }
  phrase addAlias(talker getAlias("order", type, modifier));
  talker thread bcPlayPhrase("order", type, phrase, false);
  if(!isDefined(yellat) || !isDefined(yellat.nextSayTimes) || !yellat bcCanSay("response", "ack", 1.0)) {
    return;
  }
  if(!isDefined(modifier) || modifier != "follow") {
    modifier = "yes";
  }
  phrase = yellat createChatPhrase();
  phrase addAlias(yellat getAlias("response", "ack", modifier));
  yellat thread bcPlayPhrase("response", "ack", phrase, false);
}

tryOrder(team) {
  for(i = 0; i < team.size; i++) {
    if(isDefined(team[i].bcOrderTime) &&
      (GetTime() - team[i].bcOrderTime) > 2000
    ) {
      team[i].bcOrderTime = undefined;
      team[i].bcOrderType = undefined;
      team[i].bcOrderModifier = undefined;
      continue;
    }
    if(isDefined(team[i].bcOrderTime) &&
      (GetTime() - team[i].bcOrderTime) < 2000 &&
      team[i] bcCanSay("order", team[i].bcOrderType)
    ) {
      thread doOrder(team[i], findGuyToYellAt(team, team[i]), team[i].bcOrderType, team[i].bcOrderModifier);
      return true;
    }
  }
  return false;
}

hasKill(player) {
  return isDefined(self.bcKillTime) && (GetTime() - self.bcKillTime) < 2000 && self bcCanSay("inform", "killfirm");
}

tryKill(team) {
  dude = getClosestToPlayer(filter(team, ::hasKill));
  if(!isDefined(dude)) {
    return false;
  }
  modifier = "infantry";
  if(RandomFloat(1.0) < .35) {
    modifier = "generic";
  }
  phrase = dude createChatPhrase();
  phrase addAlias(dude getAlias("inform", "killfirm", modifier));
  dude thread bcPlayPhrase("inform", "killfirm", phrase, false);
  dude.bcKillTime = undefined;
  return true;
}

hasCasualty(player) {
  return isDefined(self.bcFriendDeathTime) && (GetTime() - self.bcFriendDeathTime) < 3000 && self bcCanSay("reaction", "casualty");
}

tryCasualty(team) {
  dude = getClosestToPlayer(filter(team, ::hasCasualty));
  if(!isDefined(dude)) {
    return false;
  }
  modifier = "generic";
  phrase = dude createChatPhrase();
  phrase addAlias(dude getAlias("reaction", "casualty", modifier));
  dude thread bcPlayPhrase("reaction", "casualty", phrase, false);
  dude.bcFriendDeathTime = undefined;
  return true;
}

tryGrenade(player) {
  return isDefined(self.bcThrewGrenadeTime) && (GetTime() - self.bcThrewGrenadeTime) < 2000 && self bcCanSay("inform", "attack");
}

tryGrenadeInform(team) {
  dude = getClosestToPlayer(filter(team, ::hasCasualty));
  if(!isDefined(dude)) {
    return false;
  }
  modifier = "grenade";
  phrase = dude createChatPhrase();
  phrase addAlias(dude getAlias("inform", "attack", modifier));
  dude thread bcPlayPhrase("inform", "attack", phrase, false);
  dude.bcThrewGrenadeTime = undefined;
  return true;
}

tryFireInform(team, others) {
  if(!isDefined(level.bcOnFireTime)) {
    return false;
  }
  if((GetTime() - level.bcOnFireTime) > 3000) {
    level.bcOnFireTime = undefined;
    level.bcOnFireOrg = undefined;
    return false;
  }
  if(isDefined(level.bcOnFireLastSayTime) && (GetTime() - level.bcOnFireLastSayTime) < 10) {
    return false;
  }
  talker = getNearestTalker(level.bcOnFireOrg, undefined, team, "inform", "burning");
  if(!isDefined(talker)) {
    return false;
  }
  level.bcOnFireLastSayTime = GetTime();
  phrase = talker createChatPhrase();
  phrase addAlias(talker getAlias("inform", "burning"));
  level.bcOnFireTime = undefined;
  level.bcOnFireOrg = undefined;
  talker thread bcPlayPhrase("inform", "burning", phrase, false);
  return true;
}

bccycle(team, otherteam) {
  if(!bcsEnabled()) {
    return false;
  }
  if(tryThreat(GetAIArray(team), getentarray("grenade", "classname"), 300, 1, ::isGrenade, "inform", "incoming", "grenade", true)) {
    return true;
  }
  if(team == "allies" && tryThreat(GetAIArray(team), GetAIArray(otherteam), 1000, 3, ::isBanzai, "threat", "banzai", undefined, false)) {
    return true;
  }
  wait(.01);
  if(team == "allies" && tryThreat(GetAIArray(team), getAllTurrets(otherteam), 3000, 1, ::isMg, "threat", "mg", undefined, true)) {
    return true;
  }
  if(tryOrder(GetAIArray(team))) {
    return true;
  }
  wait(.01);
  if(trySurpressed(GetAIArray(team))) {
    return true;
  }
  if(GetAIArray(otherteam).size > 1 && tryReload(GetAIArray(team), GetAIArray(otherteam))) {
    return true;
  }
  wait(.01);
  if(tryKill(GetAIArray(team))) {
    return true;
  }
  if(tryCasualty(GetAIArray(team))) {
    return true;
  }
  wait(.01);
  if(tryGrenadeInform(GetAIArray(team))) {
    return true;
  }
  wait(.01);
  us = GetAIArray(team);
  them = GetAIArray(otherteam);
  if(us.size + 4 < them.size && RandomFloat(1) < .3) {
    tryThreat(us, them, 2000, 1, ::isInfantry, "threat", "infantry", "multiple", false);
  } else {
    tryThreat(us, them, 2000, 1, ::isInfantry, "threat", "infantry", "generic", true);
  }
  return false;
}

bcthread(us, them, talkdelay, nontalkdelay) {
  while(1) {
    wait(nontalkdelay);
    while(bccycle(us, them)) {
      wait(RandomFloat(2 * talkdelay));
    }
  }
}

bcmain() {
  thread bcthread("axis", "allies", 2, 2);
  thread bcthread("allies", "axis", 1, .5);
}