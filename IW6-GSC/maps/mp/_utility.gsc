/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_utility.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

KILLSTREAK_GIMME_SLOT = 0;
KILLSTREAK_SLOT_1 = 1;
KILLSTREAK_SLOT_2 = 2;
KILLSTREAK_SLOT_3 = 3;
KILLSTREAK_ALL_PERKS_SLOT = 4;
KILLSTREAK_STACKING_START_SLOT = 5;

MAX_VEHICLES = 8;

LIGHTWEIGHT_SCALAR = 1.07;

ATTACHMAP_TABLE = "mp/attachmentmap.csv";
ATTACHMAP_COL_CLASS_OR_WEAP_NAME = 0;
ATTACHMAP_ROW_ATTACH_BASE_NAME = 0;

ALIENS_ATTACHMAP_TABLE = "mp/alien/alien_attachmentmap.csv";
ALIENS_ATTACHMAP_COL_CLASS_OR_WEAP_NAME = 0;
ALIENS_ATTACHMAP_ROW_ATTACH_BASE_NAME = 0;

MAX_CUSTOM_DEFAULT_LOADOUTS = 6;

exploder_sound() {
  if(isDefined(self.script_delay))
    wait self.script_delay;

  self playSound(level.scr_sound[self.script_sound]);
}

_beginLocationSelection(streakName, selectorType, directionality, size) {
  self BeginLocationSelection(selectorType, directionality, size);
  self.selectingLocation = true;
  self setblurforplayer(10.3, 0.3);

  self thread endSelectionOnAction("cancel_location");
  self thread endSelectionOnAction("death");
  self thread endSelectionOnAction("disconnect");
  self thread endSelectionOnAction("used");
  self thread endSelectionOnAction("weapon_change");

  self endon("stop_location_selection");
  self thread endSelectionOnEndGame();
  self thread endSelectionOnEMP();

  if(isDefined(streakName) && self.team != "spectator") {
    if(isDefined(self.streakMsg))
      self.streakMsg destroy();

    if(self IsSplitscreenPlayer()) {
      self.streakMsg = self maps\mp\gametypes\_hud_util::createFontString("default", 1.3);
      self.streakMsg maps\mp\gametypes\_hud_util::setPoint("CENTER", "CENTER", 0, -98);
    } else {
      self.streakMsg = self maps\mp\gametypes\_hud_util::createFontString("default", 1.6);
      self.streakMsg maps\mp\gametypes\_hud_util::setPoint("CENTER", "CENTER", 0, -190);
    }
    streakString = getKillstreakName(streakName);
    self.streakMsg setText(streakString);
  }
}

stopLocationSelection(disconnected, reason) {
  if(!isDefined(reason))
    reason = "generic";

  if(!disconnected) {
    self setblurforplayer(0, 0.3);
    self endLocationSelection();
    self.selectingLocation = undefined;

    if(isDefined(self.streakMsg))
      self.streakMsg destroy();
  }
  self notify("stop_location_selection", reason);
}

endSelectionOnEMP() {
  self endon("stop_location_selection");
  for(;;) {
    level waittill("emp_update");

    if(!self isEMPed()) {
      continue;
    }
    self thread stopLocationSelection(false, "emp");
    return;
  }
}

endSelectionOnAction(waitfor) {
  self endon("stop_location_selection");
  self waittill(waitfor);
  self thread stopLocationSelection((waitfor == "disconnect"), waitfor);
}

endSelectionOnEndGame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  self thread stopLocationSelection(false, "end_game");
}

isAttachment(attachmentName) {
  if(is_aliens())
    attachment = tableLookup("mp/alien/alien_attachmentTable.csv", 4, attachmentName, 0);
  else
    attachment = tableLookup("mp/attachmentTable.csv", 4, attachmentName, 0);

  if(isDefined(attachment) && attachment != "")
    return true;
  else
    return false;
}

getAttachmentType(attachmentName) {
  if(is_aliens())
    attachmentType = tableLookup("mp/alien/alien_attachmentTable.csv", 4, attachmentName, 2);
  else
    attachmentType = tableLookup("mp/attachmentTable.csv", 4, attachmentName, 2);

  return attachmentType;
}

delayThread(timer, func, param1, param2, param3, param4, param5) {
  thread delayThread_proc(func, timer, param1, param2, param3, param4, param5);
}

delayThread_proc(func, timer, param1, param2, param3, param4, param5) {
  wait(timer);
  if(!isDefined(param1)) {
    assertex(!isDefined(param2), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param3), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param4), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]]();
  } else
  if(!isDefined(param2)) {
    assertex(!isDefined(param3), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param4), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]](param1);
  } else
  if(!isDefined(param3)) {
    assertex(!isDefined(param4), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]](param1, param2);
  } else
  if(!isDefined(param4)) {
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]](param1, param2, param3);
  } else
  if(!isDefined(param5)) {
    thread[[func]](param1, param2, param3, param4);
  } else {
    thread[[func]](param1, param2, param3, param4, param5);
  }
}

array_contains_index(array, index) {
  AssertEx(IsArray(array), "array_contains_index() passed invalid array.");
  AssertEx(isDefined(index), "array_contains_index() passed undefind index.");

  foreach(i, _ in array)
  if(i == index)
    return true;
  return false;
}

getPlant() {
  start = self.origin + (0, 0, 10);

  range = 11;
  forward = anglesToForward(self.angles);
  forward = (forward * range);

  traceorigins[0] = start + forward;
  traceorigins[1] = start;

  trace = bulletTrace(traceorigins[0], (traceorigins[0] + (0, 0, -18)), false, undefined);
  if(trace["fraction"] < 1) {
    temp = spawnStruct();
    temp.origin = trace["position"];
    temp.angles = orientToNormal(trace["normal"]);
    return temp;
  }

  trace = bulletTrace(traceorigins[1], (traceorigins[1] + (0, 0, -18)), false, undefined);
  if(trace["fraction"] < 1) {
    temp = spawnStruct();
    temp.origin = trace["position"];
    temp.angles = orientToNormal(trace["normal"]);
    return temp;
  }

  traceorigins[2] = start + (16, 16, 0);
  traceorigins[3] = start + (16, -16, 0);
  traceorigins[4] = start + (-16, -16, 0);
  traceorigins[5] = start + (-16, 16, 0);

  besttracefraction = undefined;
  besttraceposition = undefined;
  for(i = 0; i < traceorigins.size; i++) {
    trace = bulletTrace(traceorigins[i], (traceorigins[i] + (0, 0, -1000)), false, undefined);

    if(!isDefined(besttracefraction) || (trace["fraction"] < besttracefraction)) {
      besttracefraction = trace["fraction"];
      besttraceposition = trace["position"];
    }
  }

  if(besttracefraction == 1)
    besttraceposition = self.origin;

  temp = spawnStruct();
  temp.origin = besttraceposition;
  temp.angles = orientToNormal(trace["normal"]);
  return temp;
}

orientToNormal(normal) {
  hor_normal = (normal[0], normal[1], 0);
  hor_length = length(hor_normal);

  if(!hor_length)
    return (0, 0, 0);

  hor_dir = vectornormalize(hor_normal);
  neg_height = normal[2] * -1;
  tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
  plant_angle = vectortoangles(tangent);

  return plant_angle;
}

deletePlacedEntity(entity) {
  entities = getEntArray(entity, "classname");
  for(i = 0; i < entities.size; i++) {
    entities[i] delete();
  }
}

playSoundOnPlayers(sound, team, excludeList) {
  assert(isDefined(level.players));

  if(level.splitscreen) {
    if(isDefined(level.players[0]))
      level.players[0] playLocalSound(sound);
  } else {
    if(isDefined(team)) {
      if(isDefined(excludeList)) {
        for(i = 0; i < level.players.size; i++) {
          player = level.players[i];

          if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
            continue;
          }
          if(isDefined(player.pers["team"]) && (player.pers["team"] == team) && !isExcluded(player, excludeList))
            player playLocalSound(sound);
        }
      } else {
        for(i = 0; i < level.players.size; i++) {
          player = level.players[i];

          if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
            continue;
          }
          if(isDefined(player.pers["team"]) && (player.pers["team"] == team))
            player playLocalSound(sound);
        }
      }
    } else {
      if(isDefined(excludeList)) {
        for(i = 0; i < level.players.size; i++) {
          if(level.players[i] isSplitscreenPlayer() && !level.players[i] isSplitscreenPlayerPrimary()) {
            continue;
          }
          if(!isExcluded(level.players[i], excludeList))
            level.players[i] playLocalSound(sound);
        }
      } else {
        for(i = 0; i < level.players.size; i++) {
          if(level.players[i] isSplitscreenPlayer() && !level.players[i] isSplitscreenPlayerPrimary()) {
            continue;
          }
          level.players[i] playLocalSound(sound);
        }
      }
    }
  }
}

sortLowerMessages() {
  for(i = 1; i < self.lowerMessages.size; i++) {
    message = self.lowerMessages[i];
    priority = message.priority;
    for(j = i - 1; j >= 0 && priority > self.lowerMessages[j].priority; j--)
      self.lowerMessages[j + 1] = self.lowerMessages[j];
    self.lowerMessages[j + 1] = message;
  }
}

addLowerMessage(name, text, time, priority, showTimer, shouldFade, fadeToAlpha, fadeToAlphaTime, hideWhenInDemo, hideWhenInMenu) {
  newMessage = undefined;
  foreach(message in self.lowerMessages) {
    if(message.name == name) {
      if(message.text == text && message.priority == priority) {
        return;
      }
      newMessage = message;
      break;
    }
  }

  if(!isDefined(newMessage)) {
    newMessage = spawnStruct();
    self.lowerMessages[self.lowerMessages.size] = newMessage;
  }

  newMessage.name = name;
  newMessage.text = text;
  newMessage.time = time;
  newMessage.addTime = getTime();
  newMessage.priority = priority;
  newMessage.showTimer = showTimer;
  newMessage.shouldFade = shouldFade;
  newMessage.fadeToAlpha = fadeToAlpha;
  newMessage.fadeToAlphaTime = fadeToAlphaTime;
  newMessage.hideWhenInDemo = hideWhenInDemo;
  newMessage.hideWhenInMenu = hideWhenInMenu;

  sortLowerMessages();
}

removeLowerMessage(name) {
  if(isDefined(self.lowerMessages)) {
    for(i = self.lowerMessages.size; i > 0; i--) {
      if(self.lowerMessages[i - 1].name != name) {
        continue;
      }
      message = self.lowerMessages[i - 1];

      for(j = i; j < self.lowerMessages.size; j++) {
        if(isDefined(self.lowerMessages[j]))
          self.lowerMessages[j - 1] = self.lowerMessages[j];
      }

      self.lowerMessages[self.lowerMessages.size - 1] = undefined;
    }

    sortLowerMessages();
  }
}

getLowerMessage() {
  if(!isDefined(self.lowerMessages))
    return undefined;

  return self.lowerMessages[0];
}

setLowerMessage(name, text, time, priority, showTimer, shouldFade, fadeToAlpha, fadeToAlphaTime, hideWhenInDemo, hideWhenInMenu) {
  if(!isDefined(priority))
    priority = 1;

  if(!isDefined(time))
    time = 0;

  if(!isDefined(showTimer))
    showTimer = false;

  if(!isDefined(shouldFade))
    shouldFade = false;

  if(!isDefined(fadeToAlpha))
    fadeToAlpha = 0.85;

  if(!isDefined(fadeToAlphaTime))
    fadeToAlphaTime = 3.0;

  if(!isDefined(hideWhenInDemo))
    hideWhenInDemo = false;

  if(!isDefined(hideWhenInMenu))
    hideWhenInMenu = true;

  self addLowerMessage(name, text, time, priority, showTimer, shouldFade, fadeToAlpha, fadeToAlphaTime, hideWhenInDemo, hideWhenInMenu);
  self updateLowerMessage();
}

updateLowerMessage() {
  if(!isDefined(self)) {
    return;
  }
  message = self getLowerMessage();

  if(!isDefined(message)) {
    if(isDefined(self.lowerMessage) && isDefined(self.lowerTimer)) {
      self.lowerMessage.alpha = 0;
      self.lowerTimer.alpha = 0;
    }
    return;
  }

  self.lowerMessage setText(message.text);
  self.lowerMessage.alpha = 0.85;
  self.lowerTimer.alpha = 1;

  self.lowerMessage.hideWhenInDemo = message.hideWhenInDemo;
  self.lowerMessage.hideWhenInMenu = message.hideWhenInMenu;

  if(message.shouldFade) {
    self.lowerMessage FadeOverTime(min(message.fadeToAlphaTime, 60));
    self.lowerMessage.alpha = message.fadeToAlpha;
  }

  if(message.time > 0 && message.showTimer) {
    self.lowerTimer setTimer(max(message.time - ((getTime() - message.addTime) / 1000), 0.1));
  } else if(message.time > 0 && !message.showTimer) {
    self.lowerTimer setText("");
    self.lowerMessage FadeOverTime(min(message.time, 60));
    self.lowerMessage.alpha = 0;
    self thread clearOnDeath(message);
    self thread clearAfterFade(message);
  } else {
    self.lowerTimer setText("");
  }
}

clearOnDeath(message) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");

  self waittill("death");
  self clearLowerMessage(message.name);
}

clearAfterFade(message) {
  wait(message.time);
  self clearLowerMessage(message.name);
  self notify("message_cleared");
}

clearLowerMessage(name) {
  self removeLowerMessage(name);
  self updateLowerMessage();
}

clearLowerMessages() {
  for(i = 0; i < self.lowerMessages.size; i++)
    self.lowerMessages[i] = undefined;

  if(!isDefined(self.lowerMessage)) {
    return;
  }
  self updateLowerMessage();
}

printOnTeam(printString, team) {
  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }
    player iPrintLn(printString);
  }
}

printBoldOnTeam(text, team) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team))
      player iprintlnbold(text);
  }
}

printBoldOnTeamArg(text, team, arg) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team))
      player iprintlnbold(text, arg);
  }
}

printOnTeamArg(text, team, arg) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team))
      player iprintln(text, arg);
  }
}

printOnPlayers(text, team) {
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == team))
        players[i] iprintln(text);
    } else {
      players[i] iprintln(text);
    }
  }
}

printAndSoundOnEveryone(team, otherteam, printFriendly, printEnemy, soundFriendly, soundEnemy, printarg) {
  shouldDoSounds = isDefined(soundFriendly);

  shouldDoEnemySounds = false;
  if(isDefined(soundEnemy)) {
    assert(shouldDoSounds);
    shouldDoEnemySounds = true;
  }

  if(level.splitscreen || !shouldDoSounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.team;
      if(isDefined(playerteam)) {
        if(playerteam == team && isDefined(printFriendly))
          player iprintln(printFriendly, printarg);
        else if(playerteam == otherteam && isDefined(printEnemy))
          player iprintln(printEnemy, printarg);
      }
    }
    if(shouldDoSounds) {
      assert(level.splitscreen);
      level.players[0] playLocalSound(soundFriendly);
    }
  } else {
    assert(shouldDoSounds);
    if(shouldDoEnemySounds) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.team;
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printFriendly))
              player iprintln(printFriendly, printarg);
            player playLocalSound(soundFriendly);
          } else if(playerteam == otherteam) {
            if(isDefined(printEnemy))
              player iprintln(printEnemy, printarg);
            player playLocalSound(soundEnemy);
          }
        }
      }
    } else {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.team;
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printFriendly))
              player iprintln(printFriendly, printarg);
            player playLocalSound(soundFriendly);
          } else if(playerteam == otherteam) {
            if(isDefined(printEnemy))
              player iprintln(printEnemy, printarg);
          }
        }
      }
    }
  }
}

printAndSoundOnTeam(team, printString, soundAlias) {
  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }
    player printAndSoundOnPlayer(printString, soundAlias);
  }
}

printAndSoundOnPlayer(printString, soundAlias) {
  self iPrintLn(printString);
  self playLocalSound(soundAlias);
}

_playLocalSound(soundAlias) {
  if(level.splitscreen && self getEntityNumber() != 0) {
    return;
  }
  self playLocalSound(soundAlias);
}

dvarIntValue(dVar, defVal, minVal, maxVal) {
  dVar = "scr_" + level.gameType + "_" + dVar;
  if(getDvar(dVar) == "") {
    setDvar(dVar, defVal);
    return defVal;
  }

  value = getDvarInt(dVar);

  if(value > maxVal)
    value = maxVal;
  else if(value < minVal)
    value = minVal;
  else
    return value;

  setDvar(dVar, value);
  return value;
}

dvarFloatValue(dVar, defVal, minVal, maxVal) {
  dVar = "scr_" + level.gameType + "_" + dVar;
  if(getDvar(dVar) == "") {
    setDvar(dVar, defVal);
    return defVal;
  }

  value = getDvarFloat(dVar);

  if(value > maxVal)
    value = maxVal;
  else if(value < minVal)
    value = minVal;
  else
    return value;

  setDvar(dVar, value);
  return value;
}

play_sound_on_tag(alias, tag) {
  if(isDefined(tag)) {
    playsoundatpos(self getTagOrigin(tag), alias);
  } else {
    playsoundatpos(self.origin, alias);
  }
}

getOtherTeam(team) {
  if(level.multiTeamBased) {
    assertMsg("getOtherTeam() should not be called in Multi Team Based gametypes");
  }

  if(team == "allies")
    return "axis";
  else if(team == "axis")
    return "allies";
  else
    return "none";

  assertMsg("getOtherTeam: invalid team " + team);
}

wait_endon(waitTime, endOnString, endonString2, endonString3) {
  self endon(endOnString);
  if(isDefined(endonString2))
    self endon(endonString2);
  if(isDefined(endonString3))
    self endon(endonString3);

  wait(waitTime);
}

initPersStat(dataName) {
  if(!isDefined(self.pers[dataName]))
    self.pers[dataName] = 0;
}

getPersStat(dataName) {
  return self.pers[dataName];
}

incPersStat(dataName, increment, optionalDontStore) {
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[dataName])) {
    self.pers[dataName] += increment;

    if(!isDefined(optionalDontStore) || optionalDontStore == false)
      self maps\mp\gametypes\_persistence::statAdd(dataName, increment);
  }
}

setPersStat(dataName, value) {
  assertEx(isDefined(dataName), "Called setPersStat with no dataName defined.");
  assertEx(isDefined(value), "Called setPersStat for " + dataName + " with no value defined.");

  self.pers[dataName] = value;
}

initPlayerStat(ref, defaultvalue) {
  if(!isDefined(self.stats["stats_" + ref])) {
    if(!isDefined(defaultvalue))
      defaultvalue = 0;

    self.stats["stats_" + ref] = spawnStruct();
    self.stats["stats_" + ref].value = defaultvalue;
  }
}

incPlayerStat(ref, increment) {
  if(IsAgent(self) || IsBot(self)) {
    return;
  }
  stat = self.stats["stats_" + ref];
  stat.value += increment;
}

setPlayerStat(ref, value) {
  stat = self.stats["stats_" + ref];
  stat.value = value;
  stat.time = getTime();
}

getPlayerStat(ref) {
  return self.stats["stats_" + ref].value;
}

getPlayerStatTime(ref) {
  return self.stats["stats_" + ref].time;
}

setPlayerStatIfGreater(ref, newvalue) {
  currentvalue = self getPlayerStat(ref);

  if(newvalue > currentvalue)
    self setPlayerStat(ref, newvalue);
}

setPlayerStatIfLower(ref, newvalue) {
  currentvalue = self getPlayerStat(ref);

  if(newvalue < currentvalue)
    self setPlayerStat(ref, newvalue);
}

updatePersRatio(ratio, num, denom) {
  if(!self rankingEnabled()) {
    return;
  }
  numValue = self maps\mp\gametypes\_persistence::statGet(num);
  denomValue = self maps\mp\gametypes\_persistence::statGet(denom);
  if(denomValue == 0)
    denomValue = 1;

  self maps\mp\gametypes\_persistence::statSet(ratio, int((numValue * 1000) / denomValue));
}

updatePersRatioBuffered(ratio, num, denom) {
  if(!self rankingEnabled()) {
    return;
  }
  numValue = self maps\mp\gametypes\_persistence::statGetBuffered(num);
  denomValue = self maps\mp\gametypes\_persistence::statGetBuffered(denom);
  if(denomValue == 0)
    denomValue = 1;

  self maps\mp\gametypes\_persistence::statSetBuffered(ratio, int((numValue * 1000) / denomValue));
}

WaitTillSlowProcessAllowed(allowLoop) {
  if(level.lastSlowProcessFrame == gettime()) {
    if(isDefined(allowLoop) && allowLoop) {
      while(level.lastSlowProcessFrame == getTime())
        wait(0.05);
    } else {
      wait .05;
      if(level.lastSlowProcessFrame == gettime()) {
        wait .05;
        if(level.lastSlowProcessFrame == gettime()) {
          wait .05;
          if(level.lastSlowProcessFrame == gettime()) {
            wait .05;
          }
        }
      }
    }
  }

  level.lastSlowProcessFrame = getTime();
}

waitForTimeOrNotify(time, notifyname) {
  self endon(notifyname);
  wait time;
}

isExcluded(entity, entityList) {
  for(index = 0; index < entityList.size; index++) {
    if(entity == entityList[index])
      return true;
  }
  return false;
}

leaderDialog(dialog, team, group, excludeList, location) {
  assert(isDefined(level.players));

  dialogName = game["dialog"][dialog];

  if(!isDefined(dialogName)) {
    PrintLn("Dialog " + dialog + " was not defined in game[dialog] array.");
    return;
  }

  alliesSoundName = game["voice"]["allies"] + dialogName;
  axisSoundName = game["voice"]["axis"] + dialogName;

  QueueDialog(alliesSoundName, axisSoundName, dialog, 2, team, group, excludeList, location);
}

leaderDialogOnPlayers(dialog, players, group, location) {
  foreach(player in players)
  player leaderDialogOnPlayer(dialog, group, undefined, location);
}

leaderDialogOnPlayer(dialog, group, groupOverride, location) {
  if(!isDefined(game["dialog"][dialog])) {
    PrintLn("Dialog " + dialog + " was not defined in game[dialog] array.");
    return;
  }

  team = self.pers["team"];
  if(isDefined(team) && (team == "axis" || team == "allies")) {
    soundName = game["voice"][team] + game["dialog"][dialog];
    self QueueDialogForPlayer(soundName, dialog, 2, group, groupOverride, location);
  }
}

getNextRelevantDialog() {
  for(i = 0; i < self.leaderDialogQueue.size; i++) {
    if(IsSubStr(self.leaderDialogQueue[i], "losing")) {
      if(self.team == "allies") {
        if(isSubStr(level.axisCapturing, self.leaderDialogQueue[i]))
          return self.leaderDialogQueue[i];
        else
          array_remove(self.leaderDialogQueue, self.leaderDialogQueue[i]);
      } else {
        if(isSubStr(level.alliesCapturing, self.leaderDialogQueue[i]))
          return self.leaderDialogQueue[i];
        else
          array_remove(self.leaderDialogQueue, self.leaderDialogQueue[i]);
      }
    } else {
      return level.alliesCapturing[self.leaderDialogQueue];
    }
  }
}

OrderOnQueuedDialog() {
  self endon("disconnect");

  tempArray = [];
  tempArray = self.leaderDialogQueue;

  for(i = 0; i < self.leaderDialogQueue.size; i++) {
    if(isSubStr(self.leaderDialogQueue[i], "losing")) {
      for(c = i; c >= 0; c--) {
        if(!IsSubStr(self.leaderDialogQueue[c], "losing") && c != 0) {
          continue;
        }
        if(c != i) {
          arrayInsertion(tempArray, self.leaderDialogQueue[i], c);
          array_remove(tempArray, self.leaderDialogQueue[i]);
          break;
        }
      }
    }
  }

  self.leaderDialogQueue = tempArray;
}

updateMainMenu() {
  if(self.pers["team"] == "spectator") {
    self setClientDvar("g_scriptMainMenu", game["menu_team"]);
  } else {
    self setClientDvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
  }
}

updateObjectiveText() {
  if(self.pers["team"] == "spectator") {
    self setClientDvar("cg_objectiveText", "");
    return;
  }

  if(getWatchedDvar("scorelimit") > 0 && !isObjectiveBased()) {
    if(isDefined(getObjectiveScoreText(self.pers["team"]))) {
      if(level.splitScreen)
        self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]));
      else
        self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]), getWatchedDvar("scorelimit"));
    }
  } else {
    if(isDefined(getObjectiveText(self.pers["team"])))
      self setclientdvar("cg_objectiveText", getObjectiveText(self.pers["team"]));
  }
}

setObjectiveText(team, text) {
  game["strings"]["objective_" + team] = text;
}

setObjectiveScoreText(team, text) {
  game["strings"]["objective_score_" + team] = text;
}

setObjectiveHintText(team, text) {
  game["strings"]["objective_hint_" + team] = text;
}

getObjectiveText(team) {
  return game["strings"]["objective_" + team];
}

getObjectiveScoreText(team) {
  return game["strings"]["objective_score_" + team];
}

getObjectiveHintText(team) {
  return game["strings"]["objective_hint_" + team];
}

getTimePassed() {
  if(!isDefined(level.startTime) || !isDefined(level.discardTime))
    return 0;

  if(level.timerStopped)
    return (level.timerPauseTime - level.startTime) - level.discardTime;
  else
    return (gettime() - level.startTime) - level.discardTime;
}

getTimePassedPercentage() {
  return (getTimePassed() / (getTimeLimit() * 60 * 1000)) * 100;
}

getSecondsPassed() {
  return (getTimePassed() / 1000);
}

getMinutesPassed() {
  return (getSecondsPassed() / 60);
}

ClearKillcamState() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = false;
}

isInKillcam() {
  ASSERT(self.spectatekillcam == (self.forcespectatorclient != -1 || self.killcamentity != -1));
  return self.spectatekillcam;
}

isValidClass(class) {
  return isDefined(class) && class != "";
}

getValueInRange(value, minValue, maxValue) {
  if(value > maxValue)
    return maxValue;
  else if(value < minValue)
    return minValue;
  else
    return value;
}

waitForTimeOrNotifies(desiredDelay) {
  startedWaiting = getTime();

  waitedTime = (getTime() - startedWaiting) / 1000;

  if(waitedTime < desiredDelay) {
    wait desiredDelay - waitedTime;
    return desiredDelay;
  } else {
    return waitedTime;
  }
}

logXPGains() {
  if(!isDefined(self.xpGains)) {
    return;
  }
  xpTypes = getArrayKeys(self.xpGains);
  for(index = 0; index < xpTypes.size; index++) {
    gain = self.xpGains[xpTypes[index]];
    if(!gain) {
      continue;
    }
    self logString("xp " + xpTypes[index] + ": " + gain);
  }
}

registerRoundSwitchDvar(dvarString, defaultValue, minValue, maxValue) {
  registerWatchDvarInt("roundswitch", defaultValue);

  dvarString = ("scr_" + dvarString + "_roundswitch");

  level.roundswitchDvar = dvarString;
  level.roundswitchMin = minValue;
  level.roundswitchMax = maxValue;
  level.roundswitch = getDvarInt(dvarString, defaultValue);

  if(level.roundswitch < minValue)
    level.roundswitch = minValue;
  else if(level.roundswitch > maxValue)
    level.roundswitch = maxValue;
}

registerRoundLimitDvar(dvarString, defaultValue) {
  registerWatchDvarInt("roundlimit", defaultValue);
}

registerNumTeamsDvar(dvarString, defaultValue) {
  registerWatchDvarInt("numTeams", defaultValue);
}

registerWinLimitDvar(dvarString, defaultValue) {
  registerWatchDvarInt("winlimit", defaultValue);
}

registerScoreLimitDvar(dvarString, defaultValue) {
  registerWatchDvarInt("scorelimit", defaultValue);
}

registerTimeLimitDvar(dvarString, defaultValue) {
  registerWatchDvarFloat("timelimit", defaultValue);
  setDvar("ui_timelimit", getTimeLimit());
}

registerHalfTimeDvar(dvarString, defaultValue) {
  registerWatchDvarInt("halftime", defaultValue);
  setDvar("ui_halftime", getHalfTime());
}

registerNumLivesDvar(dvarString, defaultValue) {
  registerWatchDvarInt("numlives", defaultValue);
}

setOverTimeLimitDvar(value) {
  setDvar("overtimeTimeLimit", value);
}

get_damageable_player(player, playerpos) {
  newent = spawnStruct();
  newent.isPlayer = true;
  newent.isADestructable = false;
  newent.entity = player;
  newent.damageCenter = playerpos;
  return newent;
}

get_damageable_sentry(sentry, sentryPos) {
  newent = spawnStruct();
  newent.isPlayer = false;
  newent.isADestructable = false;
  newent.isSentry = true;
  newent.entity = sentry;
  newent.damageCenter = sentryPos;
  return newent;
}

get_damageable_grenade(grenade, entpos) {
  newent = spawnStruct();
  newent.isPlayer = false;
  newent.isADestructable = false;
  newent.entity = grenade;
  newent.damageCenter = entpos;
  return newent;
}

get_damageable_mine(mine, entpos) {
  newent = spawnStruct();
  newent.isPlayer = false;
  newent.isADestructable = false;
  newent.entity = mine;
  newent.damageCenter = entpos;
  return newent;
}

get_damageable_player_pos(player) {
  return player.origin + (0, 0, 32);
}

getStanceCenter() {
  if(self GetStance() == "crouch")
    center = self.origin + (0, 0, 24);
  else if(self GetStance() == "prone")
    center = self.origin + (0, 0, 10);
  else
    center = self.origin + (0, 0, 32);

  return center;
}

get_damageable_grenade_pos(grenade) {
  return grenade.origin;
}

getDvarVec(dvarName) {
  dvarString = getDvar(dvarName);

  if(dvarString == "")
    return (0, 0, 0);

  dvarTokens = strTok(dvarString, " ");

  if(dvarTokens.size < 3)
    return (0, 0, 0);

  setDvar("tempR", dvarTokens[0]);
  setDvar("tempG", dvarTokens[1]);
  setDvar("tempB", dvarTokens[2]);

  return ((getDvarFloat("tempR"), getDvarFloat("tempG"), getDvarFloat("tempB")));
}

strip_suffix(lookupString, stripString) {
  if(lookupString.size <= stripString.size)
    return lookupString;

  if(getSubStr(lookupString, lookupString.size - stripString.size, lookupString.size) == stripString)
    return getSubStr(lookupString, 0, lookupString.size - stripString.size);

  return lookupString;
}

_takeWeaponsExcept(saveWeapon) {
  weaponsList = self GetWeaponsListAll();

  foreach(weapon in weaponsList) {
    if(weapon == saveWeapon) {
      continue;
    } else {
      self takeWeapon(weapon);
    }
  }
}

saveData() {
  saveData = spawnStruct();

  saveData.offhandClass = self getOffhandSecondaryClass();
  saveData.actionSlots = self.saved_actionSlotData;

  saveData.currentWeapon = self getCurrentWeapon();

  weaponsList = self GetWeaponsListAll();
  saveData.weapons = [];
  foreach(weapon in weaponsList) {
    if(weaponInventoryType(weapon) == "exclusive") {
      continue;
    }
    if(weaponInventoryType(weapon) == "altmode") {
      continue;
    }
    saveWeapon = spawnStruct();
    saveWeapon.name = weapon;
    saveWeapon.clipAmmoR = self getWeaponAmmoClip(weapon, "right");
    saveWeapon.clipAmmoL = self getWeaponAmmoClip(weapon, "left");
    saveWeapon.stockAmmo = self getWeaponAmmoStock(weapon);

    if(isDefined(self.throwingGrenade) && self.throwingGrenade == weapon)
      saveWeapon.stockAmmo--;

    assert(saveWeapon.stockAmmo >= 0);

    saveData.weapons[saveData.weapons.size] = saveWeapon;
  }

  self.script_saveData = saveData;
}

restoreData() {
  saveData = self.script_saveData;

  self setOffhandSecondaryClass(saveData.offhandClass);

  foreach(weapon in saveData.weapons) {
    self _giveWeapon(weapon.name, int(tableLookup("mp/camoTable.csv", 1, self.loadoutPrimaryCamo, 0)));

    self setWeaponAmmoClip(weapon.name, weapon.clipAmmoR, "right");
    if(isSubStr(weapon.name, "akimbo"))
      self setWeaponAmmoClip(weapon.name, weapon.clipAmmoL, "left");

    self setWeaponAmmoStock(weapon.name, weapon.stockAmmo);
  }

  foreach(slotID, actionSlot in saveData.actionSlots)
  self _setActionSlot(slotID, actionSlot.type, actionSlot.item);

  if(self getCurrentWeapon() == "none") {
    weapon = saveData.currentWeapon;

    if(weapon == "none")
      weapon = self getLastWeapon();

    self setSpawnWeapon(weapon);
    self switchToWeapon(weapon);
  }
}

_setActionSlot(slotID, type, item) {
  self.saved_actionSlotData[slotID].type = type;
  self.saved_actionSlotData[slotID].item = item;

  self setActionSlot(slotID, type, item);
}

isFloat(value) {
  if(int(value) != value)
    return true;

  return false;
}

registerWatchDvarInt(nameString, defaultValue) {
  dvarString = "scr_" + level.gameType + "_" + nameString;

  level.watchDvars[dvarString] = spawnStruct();
  level.watchDvars[dvarString].value = getDvarInt(dvarString, defaultValue);
  level.watchDvars[dvarString].type = "int";
  level.watchDvars[dvarString].notifyString = "update_" + nameString;
}

registerWatchDvarFloat(nameString, defaultValue) {
  dvarString = "scr_" + level.gameType + "_" + nameString;

  level.watchDvars[dvarString] = spawnStruct();
  level.watchDvars[dvarString].value = getDvarFloat(dvarString, defaultValue);
  level.watchDvars[dvarString].type = "float";
  level.watchDvars[dvarString].notifyString = "update_" + nameString;
}

registerWatchDvar(nameString, defaultValue) {
  dvarString = "scr_" + level.gameType + "_" + nameString;

  level.watchDvars[dvarString] = spawnStruct();
  level.watchDvars[dvarString].value = getDvar(dvarString, defaultValue);
  level.watchDvars[dvarString].type = "string";
  level.watchDvars[dvarString].notifyString = "update_" + nameString;
}

setOverrideWatchDvar(dvarString, value) {
  dvarString = "scr_" + level.gameType + "_" + dvarString;
  level.overrideWatchDvars[dvarString] = value;
}

getWatchedDvar(dvarString) {
  dvarString = "scr_" + level.gameType + "_" + dvarString;

  if(isDefined(level.overrideWatchDvars) && isDefined(level.overrideWatchDvars[dvarString])) {
    return level.overrideWatchDvars[dvarString];
  }

  return (level.watchDvars[dvarString].value);
}

updateWatchedDvars() {
  while(game["state"] == "playing") {
    watchDvars = getArrayKeys(level.watchDvars);

    foreach(dvarString in watchDvars) {
      if(level.watchDvars[dvarString].type == "string")
        dvarValue = getProperty(dvarString, level.watchDvars[dvarString].value);
      else if(level.watchDvars[dvarString].type == "float")
        dvarValue = getFloatProperty(dvarString, level.watchDvars[dvarString].value);
      else
        dvarValue = getIntProperty(dvarString, level.watchDvars[dvarString].value);

      if(dvarValue != level.watchDvars[dvarString].value) {
        level.watchDvars[dvarString].value = dvarValue;
        level notify(level.watchDvars[dvarString].notifyString, dvarValue);
      }
    }

    wait(1.0);
  }
}

isRoundBased() {
  if(!level.teamBased)
    return false;

  if(getWatchedDvar("winlimit") != 1 && getWatchedDvar("roundlimit") != 1)
    return true;

  if(level.gameType == "sr" || level.gameType == "sd" || level.gameType == "siege")
    return true;

  return false;
}

isFirstRound() {
  if(!level.teamBased)
    return true;

  if(getWatchedDvar("roundlimit") > 1 && game["roundsPlayed"] == 0)
    return true;

  if(getWatchedDvar("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0)
    return true;

  return false;
}

isLastRound() {
  if(!level.teamBased)
    return true;

  if(getWatchedDvar("roundlimit") > 1 && game["roundsPlayed"] >= (getWatchedDvar("roundlimit") - 1))
    return true;

  if(getWatchedDvar("winlimit") > 1 && game["roundsWon"]["allies"] >= getWatchedDvar("winlimit") - 1 && game["roundsWon"]["axis"] >= getWatchedDvar("winlimit") - 1)
    return true;

  return false;
}

wasOnlyRound() {
  if(!level.teamBased)
    return true;

  if(isDefined(level.onlyRoundOverride))
    return false;

  if(getWatchedDvar("winlimit") == 1 && hitWinLimit())
    return true;

  if(getWatchedDvar("roundlimit") == 1)
    return true;

  return false;
}

wasLastRound() {
  if(level.forcedEnd)
    return true;

  if(!level.teamBased)
    return true;

  if(hitRoundLimit() || hitWinLimit())
    return true;

  return false;
}

hitTimeLimit() {
  if(getWatchedDvar("timelimit") <= 0)
    return false;

  timeleft = maps\mp\gametypes\_gamelogic::getTimeRemaining();

  if(timeleft > 0)
    return false;

  return true;
}

hitRoundLimit() {
  if(getWatchedDvar("roundlimit") <= 0)
    return false;

  return (game["roundsPlayed"] >= getWatchedDvar("roundlimit"));
}

hitScoreLimit() {
  if(isObjectiveBased())
    return false;

  if(getWatchedDvar("scorelimit") <= 0)
    return false;

  if(level.teamBased) {
    if(game["teamScores"]["allies"] >= getWatchedDvar("scorelimit") || game["teamScores"]["axis"] >= getWatchedDvar("scorelimit"))
      return true;
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.score) && player.score >= getWatchedDvar("scorelimit"))
        return true;
    }
  }
  return false;
}

hitWinLimit() {
  if(getWatchedDvar("winlimit") <= 0)
    return false;

  if(!level.teamBased)
    return true;

  if(getRoundsWon("allies") >= getWatchedDvar("winlimit") || getRoundsWon("axis") >= getWatchedDvar("winlimit"))
    return true;

  return false;
}

getScoreLimit() {
  if(isRoundBased()) {
    if(getWatchedDvar("roundlimit"))
      return (getWatchedDvar("roundlimit"));
    else
      return (getWatchedDvar("winlimit"));
  } else {
    return (getWatchedDvar("scorelimit"));
  }
}

getRoundsWon(team) {
  return game["roundsWon"][team];
}

isObjectiveBased() {
  return level.objectiveBased;
}

getTimeLimit() {
  if(inOvertime() && (!isDefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])) {
    timeLimit = int(getDvar("overtimeTimeLimit"));

    if(isDefined(timeLimit))
      return timeLimit;
    else
      return 1;
  } else if(isDefined(level.dd) && level.dd && isDefined(level.bombexploded) && level.bombexploded > 0) {
    return (getWatchedDvar("timelimit") + (level.bombexploded * level.ddTimeToAdd));
  } else {
    return getWatchedDvar("timelimit");
  }
}

getHalfTime() {
  if(inOvertime())
    return false;
  else if(isDefined(game["inNukeOvertime"]) && game["inNukeOvertime"])
    return false;
  else
    return getWatchedDvar("halftime");
}

inOvertime() {
  return (isDefined(game["status"]) && game["status"] == "overtime");
}

gameHasStarted() {
  if(isDefined(level.gameHasStarted))
    return level.gameHasStarted;

  if(level.teamBased)
    return (level.hasSpawned["axis"] && level.hasSpawned["allies"]);

  return (level.maxPlayerCount > 1);
}

getAverageOrigin(ent_array) {
  avg_origin = (0, 0, 0);

  if(!ent_array.size)
    return undefined;

  foreach(ent in ent_array)
  avg_origin += ent.origin;

  avg_x = int(avg_origin[0] / ent_array.size);
  avg_y = int(avg_origin[1] / ent_array.size);
  avg_z = int(avg_origin[2] / ent_array.size);

  avg_origin = (avg_x, avg_y, avg_z);

  return avg_origin;
}

getLivingPlayers(team) {
  player_array = [];

  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }
    if(level.teambased && isDefined(team)) {
      if(team == player.pers["team"])
        player_array[player_array.size] = player;
    } else {
      player_array[player_array.size] = player;
    }
  }

  return player_array;
}

setUsingRemote(remoteName) {
  if(isDefined(self.carryIcon))
    self.carryIcon.alpha = 0;

  assert(!self isUsingRemote());
  self.usingRemote = remoteName;

  self _disableOffhandWeapons();
  self notify("using_remote");
}

getRemoteName() {
  assert(self isUsingRemote());

  return self.usingRemote;
}

freezeControlsWrapper(frozen) {
  if(isDefined(level.hostMigrationTimer)) {
    println("Migration Wrapper freezing controls for " + maps\mp\gametypes\_hostMigration::hostMigrationName(self) + " with frozen = " + frozen);
    self.hostMigrationControlsFrozen = true;
    self freezeControls(true);
    return;
  }

  self freezeControls(frozen);
  self.controlsFrozen = frozen;
}

clearUsingRemote() {
  if(isDefined(self.carryIcon))
    self.carryIcon.alpha = 1;

  self.usingRemote = undefined;
  self _enableOffhandWeapons();

  curWeapon = self getCurrentWeapon();

  if(curWeapon == "none" || isKillstreakWeapon(curWeapon)) {
    lastWeapon = self Getlastweapon();

    if(isReallyAlive(self)) {
      if(!self HasWeapon(lastWeapon))
        lastWeapon = selfmaps\mp\killstreaks\_killstreaks::getFirstPrimaryWeapon();

      self switchToWeapon(lastWeapon);
    }
  }

  self freezeControlsWrapper(false);

  self notify("stopped_using_remote");
}

isUsingRemote() {
  return (isDefined(self.usingRemote));
}

isRocketCorpse() {
  return (isDefined(self.isRocketCorpse) && self.isRocketCorpse);
}

queueCreate(queueName) {
  if(!isDefined(level.queues))
    level.queues = [];

  assert(!isDefined(level.queues[queueName]));

  level.queues[queueName] = [];
}

queueAdd(queueName, entity) {
  assert(isDefined(level.queues[queueName]));
  level.queues[queueName][level.queues[queueName].size] = entity;
}

queueRemoveFirst(queueName) {
  assert(isDefined(level.queues[queueName]));

  first = undefined;
  newQueue = [];
  foreach(element in level.queues[queueName]) {
    if(!isDefined(element)) {
      continue;
    }
    if(!isDefined(first))
      first = element;
    else
      newQueue[newQueue.size] = element;
  }

  level.queues[queueName] = newQueue;

  return first;
}

_giveWeapon(weapon, variant, dualWieldOverRide) {
  if(!isDefined(variant))
    variant = -1;

  if(isSubstr(weapon, "_akimbo") || isDefined(dualWieldOverRide) && dualWieldOverRide == true)
    self giveWeapon(weapon, variant, true);
  else
    self giveWeapon(weapon, variant, false);
}

perksEnabled() {
  return GetDvarInt("scr_game_perks") == 1;
}

_hasPerk(perkName) {
  perks = self.perks;

  if(!isDefined(perks))
    return false;

  if(isDefined(perks[perkName]))
    return true;

  return false;
}

givePerk(perkName, useSlot) {
  AssertEx(isDefined(perkName), "givePerk perkName not defined and should be");
  AssertEx(isDefined(useSlot), "givePerk useSlot not defined and should be");
  AssertEx(!IsSubStr(perkName, "specialty_null"), "givePerk perkName shouldn't be specialty_null, use _clearPerks()s");
  AssertEx(!IsSubStr(perkName, "none"), "givePerk perkName shouldn't be none, use _clearPerks()s");

  if(IsSubStr(perkName, "specialty_weapon_")) {
    self _setPerk(perkName, useSlot);
    return;
  }

  self _setPerk(perkName, useSlot);

  self _setExtraPerks(perkName);
}

givePerkEquipment(perkName, useSlot) {
  AssertEx(isDefined(perkName), "givePerkEquipment perkName not defined and should be");
  AssertEx(isDefined(useSlot), "givePerkEquipment useSlot not defined and should be");

  if(perkName == "none" || perkName == "specialty_null") {
    self SetOffhandPrimaryClass("none");
    return;
  }

  self.primaryGrenade = perkName;

  if(IsSubStr(perkName, "_mp")) {
    switch (perkName) {
      case "frag_grenade_mp":
      case "mortar_shell_mp":
      case "mortar_shelljugg_mp":
        self SetOffhandPrimaryClass("frag");
        break;
      case "throwingknife_mp":
      case "throwingknifejugg_mp":
        self SetOffhandPrimaryClass("throwingknife");
        break;
      case "trophy_mp":
      case "flash_grenade_mp":
      case "emp_grenade_mp":
      case "motion_sensor_mp":
      case "thermobaric_grenade_mp":
        self SetOffhandPrimaryClass("flash");
        break;
      case "smoke_grenade_mp":
      case "smoke_grenadejugg_mp":
      case "concussion_grenade_mp":
        self SetOffhandPrimaryClass("smoke");
        break;
      default:
        self SetOffhandPrimaryClass("other");
        break;
    }

    self _giveWeapon(perkName, 0);

    self GiveStartAmmo(perkName);

    self _setPerk(perkName, useSlot);
  } else
    self _setPerk(perkName, useSlot);
}

givePerkOffhand(perkName, useSlot) {
  AssertEx(isDefined(perkName), "givePerkOffhand perkName not defined and should be");
  AssertEx(isDefined(useSlot), "givePerkOffhand useSlot not defined and should be");

  if(perkName == "none" || perkName == "specialty_null") {
    self SetOffhandSecondaryClass("none");
    return;
  }

  self.secondaryGrenade = perkName;

  if(IsSubStr(perkName, "_mp")) {
    switch (perkName) {
      case "frag_grenade_mp":
      case "mortar_shell_mp":
      case "mortar_shelljugg_mp":
        self SetOffhandSecondaryClass("frag");
        break;
      case "throwingknife_mp":
      case "throwingknifejugg_mp":
        self SetOffhandSecondaryClass("throwingknife");
        break;
      case "trophy_mp":
      case "flash_grenade_mp":
      case "emp_grenade_mp":
      case "motion_sensor_mp":
      case "thermobaric_grenade_mp":
        self SetOffhandSecondaryClass("flash");
        break;
      case "smoke_grenade_mp":
      case "smoke_grenadejugg_mp":
      case "concussion_grenade_mp":
        self SetOffhandSecondaryClass("smoke");
        break;
      default:
        self SetOffhandSecondaryClass("other");
        break;
    }

    self _giveWeapon(perkName, 0);

    switch (perkName) {
      case "concussion_grenade_mp":
      case "flash_grenade_mp":
      case "smoke_grenade_mp":
      case "emp_grenade_mp":
      case "motion_sensor_mp":
      case "trophy_mp":
      case "thermobaric_grenade_mp":
        self SetWeaponAmmoClip(perkName, 1);
        break;
      default:
        self GiveStartAmmo(perkName);
        break;
    }

    self _setPerk(perkName, useSlot);
  } else
    self _setPerk(perkName, useSlot);
}

_setPerk(perkName, useSlot) {
  AssertEx(isDefined(perkName), "_setPerk perkName not defined and should be");
  AssertEx(isDefined(useSlot), "_setPerk useSlot not defined and should be");

  self.perks[perkName] = true;
  self.perksPerkName[perkName] = perkName;
  self.perksUseSlot[perkName] = useSlot;

  perkSetFunc = level.perkSetFuncs[perkName];

  if(isDefined(perkSetFunc)) {
    self thread[[perkSetFunc]]();
  }

  self setPerk(perkName, !isDefined(level.scriptPerks[perkName]), useSlot);
}

_setExtraPerks(perkName) {
  if(perkName == "specialty_stun_resistance")
    self givePerk("specialty_empimmune", false);

  if(perkName == "specialty_hardline")
    self givePerk("specialty_assists", false);

  if(perkName == "specialty_incog") {
    self givePerk("specialty_spygame", false);
    self givePerk("specialty_coldblooded", false);
    self givePerk("specialty_noscopeoutline", false);
    self givePerk("specialty_heartbreaker", false);
  }

  if(perkName == "specialty_blindeye")
    self givePerk("specialty_noplayertarget", false);

  if(perkName == "specialty_sharp_focus")
    self givePerk("specialty_reducedsway", false);

  if(perkName == "specialty_quickswap")
    self givePerk("specialty_fastoffhand", false);
}

_unsetPerk(perkName) {
  self.perks[perkName] = undefined;
  self.perksPerkName[perkName] = undefined;
  self.perksUseSlot[perkName] = undefined;

  if(isDefined(level.perkUnsetFuncs[perkName]))
    self thread[[level.perkUnsetFuncs[perkName]]]();

  self unsetPerk(perkName, !isDefined(level.scriptPerks[perkName]));
}

_unsetExtraPerks(perkName) {
  if(perkName == "specialty_bulletaccuracy")
    self _unsetPerk("specialty_steadyaimpro");

  if(perkName == "specialty_coldblooded")
    self _unsetPerk("specialty_heartbreaker");

  if(perkName == "specialty_fasterlockon")
    self _unsetPerk("specialty_armorpiercing");

  if(perkName == "specialty_heartbreaker")
    self _unsetPerk("specialty_empimmune");

  if(perkName == "specialty_rollover")
    self _unsetPerk("specialty_assists");
}

_clearPerks() {
  foreach(perkName, perkValue in self.perks) {
    if(isDefined(level.perkUnsetFuncs[perkName]))
      self[[level.perkUnsetFuncs[perkName]]]();
  }

  self.perks = [];
  self.perksPerkName = [];
  self.perksUseSlot = [];
  self clearPerks();
}

quickSort(array) {
  return quickSortMid(array, 0, array.size - 1);
}

quickSortMid(array, start, end) {
  i = start;
  k = end;

  if(end - start >= 1) {
    pivot = array[start];

    while(k > i) {
      while(array[i] <= pivot && i <= end && k > i)
        i++;
      while(array[k] > pivot && k >= start && k >= i)
        k--;
      if(k > i)
        array = swap(array, i, k);
    }
    array = swap(array, start, k);
    array = quickSortMid(array, start, k - 1);
    array = quickSortMid(array, k + 1, end);
  } else
    return array;

  return array;
}

swap(array, index1, index2) {
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
  return array;
}

_suicide() {
  if(self isUsingRemote() && !isDefined(self.fauxDead))
    self thread maps\mp\gametypes\_damage::PlayerKilled_internal(self, self, self, 10000, "MOD_SUICIDE", "frag_grenade_mp", (0, 0, 0), "none", 0, 1116, true);
  else if(!self isUsingRemote() && !isDefined(self.fauxDead))
    self suicide();
}

isReallyAlive(player) {
  if(isAlive(player) && !isDefined(player.fauxDead))
    return true;

  return false;
}

waittill_any_timeout_pause_on_death_and_prematch(timeOut, string1, string2, string3, string4, string5) {
  ent = spawnStruct();

  if(isDefined(string1))
    self thread waittill_string_no_endon_death(string1, ent);

  if(isDefined(string2))
    self thread waittill_string_no_endon_death(string2, ent);

  if(isDefined(string3))
    self thread waittill_string_no_endon_death(string3, ent);

  if(isDefined(string4))
    self thread waittill_string_no_endon_death(string4, ent);

  if(isDefined(string5))
    self thread waittill_string_no_endon_death(string5, ent);

  ent thread _timeout_pause_on_death_and_prematch(timeOut, self);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_timeout_pause_on_death_and_prematch(delay, ent) {
  self endon("die");

  inc = 0.05;
  while(delay > 0) {
    if(isPlayer(ent) && !isReallyAlive(ent)) {
      ent waittill("spawned_player");
    }
    if(GetOmnvar("ui_prematch_period")) {
      level waittill("prematch_over");
    }

    wait(inc);
    delay -= inc;
  }
  self notify("returned", "timeout");
}

playDeathSound() {
  rand = RandomIntRange(1, 8);

  type = "generic";
  if(self hasFemaleCustomizationModel())
    type = "female";

  if(self.team == "axis")
    self playSound(type + "_death_russian_" + rand);
  else
    self playSound(type + "_death_american_" + rand);
}

rankingEnabled() {
  if(!isPlayer(self))
    return false;

  return (level.rankedMatch && !self.usingOnlineDataOffline);
}

privateMatch() {
  return (level.onlineGame && getDvarInt("xblive_privatematch"));
}

matchMakingGame() {
  return (level.onlineGame && !getDvarInt("xblive_privatematch"));
}

setAltSceneObj(object, tagName, fov, forceLink) {}

endSceneOnDeath(object) {
  self endon("altscene");

  object waittill("death");
  self notify("end_altScene");
}

getGametypeNumLives() {
  return getWatchedDvar("numlives");
}

giveCombatHigh(combatHighName) {
  self.combatHigh = combatHighName;
}

arrayInsertion(array, item, index) {
  if(array.size != 0) {
    for(i = array.size; i >= index; i--) {
      array[i + 1] = array[i];
    }
  }

  array[index] = item;
}

getProperty(dvar, defValue) {
  value = defValue;

  setDevDvarIfUninitialized(dvar, defValue);

  value = getDvar(dvar, defValue);
  return value;
}

getIntProperty(dvar, defValue) {
  value = defValue;

  setDevDvarIfUninitialized(dvar, defValue);

  value = getDvarInt(dvar, defValue);
  return value;
}

getFloatProperty(dvar, defValue) {
  value = defValue;

  setDevDvarIfUninitialized(dvar, defValue);

  value = getDvarFloat(dvar, defValue);
  return value;
}

isChangingWeapon() {
  return (isDefined(self.changingWeapon));
}

killShouldAddToKillstreak(weapon) {
  if(weapon == "venomxgun_mp" || weapon == "venomxproj_mp")
    return true;

  if(self _hasPerk("specialty_explosivebullets"))
    return false;

  if(isDefined(self.isJuggernautRecon) && self.isJuggernautRecon == true)
    return false;

  self_pers_killstreaks = self.pers["killstreaks"];

  if(isDefined(level.killstreakWeildWeapons[weapon]) && isDefined(self.streakType) && self.streakType != "support") {
    for(i = KILLSTREAK_SLOT_1; i < KILLSTREAK_SLOT_3 + 1; i++) {
      if(isDefined(self_pers_killstreaks[i]) && isDefined(self_pers_killstreaks[i].streakName) && self_pers_killstreaks[i].streakName == level.killstreakWeildWeapons[weapon] && isDefined(self_pers_killstreaks[i].lifeId) && self_pers_killstreaks[i].lifeId == self.pers["deaths"]) {
        return self streakShouldChain(level.killstreakWeildWeapons[weapon]);
      }
    }
    return false;
  }

  return !isKillstreakWeapon(weapon);
}

streakShouldChain(streakName) {
  currentStreakCost = maps\mp\killstreaks\_killstreaks::getStreakCost(streakName);
  nextStreakName = maps\mp\killstreaks\_killstreaks::getNextStreakName();
  nextStreakCost = maps\mp\killstreaks\_killstreaks::getStreakCost(nextStreakName);

  return (currentStreakCost < nextStreakCost);
}

isJuggernaut() {
  if((isDefined(self.isJuggernaut) && self.isJuggernaut == true))
    return true;

  if((isDefined(self.isJuggernautDef) && self.isJuggernautDef == true))
    return true;

  if((isDefined(self.isJuggernautGL) && self.isJuggernautGL == true))
    return true;

  if((isDefined(self.isJuggernautRecon) && self.isJuggernautRecon == true))
    return true;

  if((isDefined(self.isJuggernautManiac) && self.isJuggernautManiac == true))
    return true;

  if((isDefined(self.isJuggernautLevelCustom) && self.isJuggernautLevelCustom == true))
    return true;

  return false;
}

isKillstreakWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isKillstreakWeapon called without a weapon name passed in");
    return false;
  }

  if(weapon == "none")
    return false;

  if(isDestructibleWeapon(weapon))
    return false;

  if(isBombSiteWeapon(weapon))
    return false;

  if(isSubStr(weapon, "killstreak"))
    return true;

  if(isSubStr(weapon, "cobra"))
    return true;

  if(isSubStr(weapon, "remote_tank_projectile"))
    return true;

  if(isSubStr(weapon, "artillery_mp"))
    return true;

  if(isSubStr(weapon, "harrier"))
    return true;

  tokens = strTok(weapon, "_");
  foundSuffix = false;

  foreach(token in tokens) {
    if(token == "mp") {
      foundSuffix = true;
      break;
    }
  }

  if(!foundSuffix) {
    weapon += "_mp";
  }

  if(isDefined(level.killstreakWeildWeapons[weapon]))
    return true;

  if(maps\mp\killstreaks\_killstreaks::isAirdropMarker(weapon))
    return true;

  weaponInvType = WeaponInventoryType(weapon);
  if(isDefined(weaponInvType) && weaponInvType == "exclusive")
    return true;

  return false;
}

isDestructibleWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isDestructibleWeapon called without a weapon name passed in");
    return false;
  }

  switch (weapon) {
    case "destructible":
    case "destructible_car":
    case "destructible_toy":
    case "barrel_mp":
      return true;
  }

  return false;
}

isBombSiteWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isBombSiteWeapon called without a weapon name passed in");
    return false;
  }

  switch (weapon) {
    case "briefcase_bomb_mp":
    case "bomb_site_mp":
      return true;
  }

  return false;
}

isEnvironmentWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isEnvironmentWeapon called without a weapon name passed in");
    return false;
  }

  if(weapon == "turret_minigun_mp")
    return true;

  if(isSubStr(weapon, "_bipod_"))
    return true;

  return false;
}

isJuggernautWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isJuggernautWeapon called without a weapon name passed in");
    return false;
  }

  switch (weapon) {
    case "iw6_minigunjugg_mp":
    case "iw6_magnumjugg_mp":
    case "iw6_p226jugg_mp":
    case "iw6_knifeonlyjugg_mp":
    case "iw6_riotshieldjugg_mp":
    case "throwingknifejugg_mp":
    case "smoke_grenadejugg_mp":
    case "mortar_shelljugg_mp":
    case "iw6_axe_mp":
    case "iw6_predatorcannon_mp":
    case "iw6_mariachimagnum_mp_akimbo":
      return true;
  }

  return false;
}

getWeaponClass(weapon) {
  baseName = getBaseWeaponName(weapon);

  if(is_aliens())
    weaponClass = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv", 4, baseName, 2);
  else
    weaponClass = tablelookup("mp/statstable.csv", 4, baseName, 2);

  if(weaponClass == "") {
    weaponName = strip_suffix(weapon, "_mp");
    if(is_aliens())
      weaponClass = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv", 4, weaponName, 2);
    else
      weaponClass = tablelookup("mp/statstable.csv", 4, weaponName, 2);
  }

  if(isEnvironmentWeapon(weapon))
    weaponClass = "weapon_mg";
  else if(!is_aliens() && isKillstreakWeapon(weapon))
    weaponClass = "killstreak";
  else if(weapon == "none")
    weaponClass = "other";
  else if(weaponClass == "")
    weaponClass = "other";

  assertEx(weaponClass != "", "ERROR: invalid weapon class for weapon " + weapon);

  return weaponClass;
}

getWeaponAttachmentArrayFromStats(weaponName) {
  weaponName = getBaseWeaponName(weaponName);

  if(!isDefined(level.weaponAttachments[weaponName])) {
    attachments = [];
    for(i = 0; i <= 19; i++) {
      attachment = TableLookup("mp/statsTable.csv", 4, weaponName, 10 + i);
      if(attachment == "") {
        break;
      }

      attachments[attachments.size] = attachment;
    }

    level.weaponAttachments[weaponName] = attachments;
  }

  return level.weaponAttachments[weaponName];
}

getWeaponAttachmentFromStats(weaponName, index) {
  weaponName = getBaseWeaponName(weaponName);

  return TableLookup("mp/statsTable.csv", 4, weaponName, 10 + index);
}

attachmentsCompatible(attachment1, attachment2) {
  AssertEx(isDefined(attachment1) && isDefined(attachment1), "areAttachmentsCompatible() passed undefined attachment");

  attachment1 = attachmentMap_toBase(attachment1);
  attachment2 = attachmentMap_toBase(attachment2);

  compatible = true;

  if(attachment1 == attachment2) {
    compatible = false;
  } else if(attachment1 != "none" && attachment2 != "none") {
    attach2RowAndCol = TableLookupRowNum("mp/attachmentcombos.csv", 0, attachment2);

    AssertEx(attach2RowAndCol >= 0, "areAttachmentsCompatible() could not find attachment: " + attachment2 + " in attachmentcombos.csv");

    if(TableLookup("mp/attachmentcombos.csv", 0, attachment1, attach2RowAndCol) == "no") {
      compatible = false;
    }
  }

  return compatible;
}

getBaseWeaponName(weaponName) {
  tokens = strTok(weaponName, "_");

  if(tokens[0] == "iw5" || tokens[0] == "iw6") {
    weaponName = tokens[0] + "_" + tokens[1];
  } else if(tokens[0] == "alt") {
    weaponName = tokens[1] + "_" + tokens[2];
  }

  return weaponName;
}

getBasePerkName(perkName) {
  if(IsEndStr(perkName, "_ks"))
    perkName = GetSubStr(perkName, 0, perkName.size - 3);

  return perkName;
}

getValidExtraAmmoWeapons() {
  weaponList = [];

  primaryList = self GetWeaponsListPrimaries();

  foreach(primary in primaryList) {
    weapClass = WeaponClass(primary);

    if(!isKillstreakWeapon(primary) && weapClass != "grenade" && weapClass != "rocketlauncher")
      weaponList[weaponList.size] = primary;
  }

  return weaponList;
}

riotShield_hasWeapon() {
  result = false;

  weaponList = self GetWeaponsListPrimaries();
  foreach(weapon in weaponList) {
    if(maps\mp\gametypes\_weapons::isRiotShield(weapon)) {
      result = true;
      break;
    }
  }
  return result;
}

riotShield_hasTwo() {
  count = 0;

  weapons = self GetWeaponsListPrimaries();
  foreach(weapon in weapons) {
    if(maps\mp\gametypes\_weapons::isRiotShield(weapon)) {
      count++;
    }

    if(count == 2) {
      break;
    }
  }

  return count == 2;
}

riotShield_attach(onArm, modelShield) {
  tagAttach = undefined;
  if(onArm) {
    AssertEx(!isDefined(self.riotShieldModel), "riotShield_attach() called on player with no riot shield model on the arm");
    self.riotShieldModel = modelShield;
    tagAttach = "tag_weapon_right";
  } else {
    AssertEx(!isDefined(self.riotShieldModelStowed), "riotShield_attach() called on player with no riot shield model stowed");
    self.riotShieldModelStowed = modelShield;
    tagAttach = "tag_shield_back";
  }

  self AttachShieldModel(modelShield, tagAttach);
  self.hasRiotShield = self riotShield_hasWeapon();
}

riotShield_detach(onArm) {
  modelShield = undefined;
  tagDetach = undefined;
  if(onArm) {
    AssertEx(isDefined(self.riotShieldModel), "riotShield_detach() called on player with no riot shield model on arm");
    modelShield = self.riotShieldModel;
    tagDetach = "tag_weapon_right";
  } else {
    AssertEx(isDefined(self.riotShieldModelStowed), "riotShield_detach() called on player with no riot shield model stowed");
    modelShield = self.riotShieldModelStowed;
    tagDetach = "tag_shield_back";
  }

  self DetachShieldModel(modelShield, tagDetach);

  if(onArm) {
    self.riotShieldModel = undefined;
  } else {
    self.riotShieldModelStowed = undefined;
  }

  self.hasRiotShield = self riotShield_hasWeapon();
}

riotShield_move(fromArm) {
  tagStart = undefined;
  tagEnd = undefined;
  modelShield = undefined;
  if(fromArm) {
    AssertEx(isDefined(self.riotShieldModel), "riotShield_move() called on player with no riot shield model on arm");
    modelShield = self.riotShieldModel;
    tagStart = "tag_weapon_right";
    tagEnd = "tag_shield_back";
  } else {
    AssertEx(isDefined(self.riotShieldModelStowed), "riotShield_move() called on player with no riot shield model stowed");
    modelShield = self.riotShieldModelStowed;
    tagStart = "tag_shield_back";
    tagEnd = "tag_weapon_right";
  }

  self MoveShieldModel(modelShield, tagStart, tagEnd);

  if(fromArm) {
    self.riotShieldModelStowed = modelShield;
    self.riotShieldModel = undefined;
  } else {
    self.riotShieldModel = modelShield;
    self.riotShieldModelStowed = undefined;
  }
}

riotShield_clear() {
  self.hasRiotShieldEquipped = false;
  self.hasRiotShield = false;
  self.riotShieldModelStowed = undefined;
  self.riotShieldModel = undefined;
}

riotShield_getModel() {
  return ter_op(self isJuggernaut(), "weapon_riot_shield_jug_iw6", "weapon_riot_shield_iw6");
}

outlineEnableForAll(entToOutline, colorName, depthEnable, priorityGroup) {
  playersVisibleTo = level.players;
  colorIndex = maps\mp\gametypes\_outline::outlineColorIndexMap(colorName);
  priority = maps\mp\gametypes\_outline::outlinePriorityGroupMap(priorityGroup);

  return maps\mp\gametypes\_outline::outlineEnableInternal(entToOutline, colorIndex, playersVisibleTo, depthEnable, priority, "ALL");
}

outlineEnableForTeam(entToOutline, colorName, teamVisibleTo, depthEnable, priorityGroup) {
  playersVisibleTo = getTeamArray(teamVisibleTo, false);
  colorIndex = maps\mp\gametypes\_outline::outlineColorIndexMap(colorName);
  priority = maps\mp\gametypes\_outline::outlinePriorityGroupMap(priorityGroup);

  return maps\mp\gametypes\_outline::outlineEnableInternal(entToOutline, colorIndex, playersVisibleTo, depthEnable, priority, "TEAM", teamVisibleTo);
}

outlineEnableForPlayer(entToOutline, colorName, playerVisibleTo, depthEnable, priorityGroup) {
  colorIndex = maps\mp\gametypes\_outline::outlineColorIndexMap(colorName);
  priority = maps\mp\gametypes\_outline::outlinePriorityGroupMap(priorityGroup);

  if(IsAgent(playerVisibleTo)) {
    return maps\mp\gametypes\_outline::outlineGenerateUniqueID();
  }

  return maps\mp\gametypes\_outline::outlineEnableInternal(entToOutline, colorIndex, [playerVisibleTo], depthEnable, priority, "ENTITY");
}

outlineDisable(ID, entOutlined) {
  AssertEx(isDefined(ID) && Int(ID) == ID, "Invalid ID passed to outlineDisable()");
  AssertEX(isDefined(entOutlined), "Undefined entOutlined passed to outlineDiable()");
  maps\mp\gametypes\_outline::outlineDisableInternal(ID, entOutlined);
}

playSoundinSpace(alias, origin) {
  playSoundAtPos(origin, alias);
}

limitDecimalPlaces(value, places) {
  modifier = 1;
  for(i = 0; i < places; i++)
    modifier *= 10;

  newvalue = value * modifier;
  newvalue = Int(newvalue);
  newvalue = newvalue / modifier;

  return newvalue;
}

roundDecimalPlaces(value, places, style) {
  if(!isDefined(style))
    style = "nearest";

  modifier = 1;
  for(i = 0; i < places; i++)
    modifier *= 10;

  newValue = value * modifier;

  if(style == "up")
    roundedValue = ceil(newValue);
  else if(style == "down")
    roundedValue = floor(newValue);
  else
    roundedValue = newvalue + 0.5;

  newvalue = Int(roundedValue);
  newvalue = newvalue / modifier;

  return newvalue;
}

playerForClientId(clientId) {
  foreach(player in level.players) {
    if(player.clientId == clientId)
      return player;
  }

  return undefined;
}

isRested() {
  if(!self rankingEnabled())
    return false;

  return (self getRankedPlayerData("restXPGoal") > self getRankedPlayerData("experience"));
}

stringToFloat(stringVal) {
  floatElements = strtok(stringVal, ".");

  floatVal = int(floatElements[0]);
  if(isDefined(floatElements[1])) {
    modifier = 1;
    for(i = 0; i < floatElements[1].size; i++)
      modifier *= 0.1;

    floatVal += int(floatElements[1]) * modifier;
  }

  return floatVal;
}

setSelfUsable(caller) {
  self makeUsable();

  foreach(player in level.players) {
    if(player != caller)
      self disablePlayerUse(player);
    else
      self enablePlayerUse(player);
  }
}

makeTeamUsable(team) {
  self makeUsable();
  self thread _updateTeamUsable(team);
}

_updateTeamUsable(team) {
  self endon("death");

  for(;;) {
    foreach(player in level.players) {
      if(player.team == team)
        self enablePlayerUse(player);
      else
        self disablePlayerUse(player);
    }

    level waittill("joined_team");
  }
}

makeEnemyUsable(owner) {
  self makeUsable();
  self thread _updateEnemyUsable(owner);
}

_updateEnemyUsable(owner) {
  self endon("death");

  team = owner.team;

  for(;;) {
    if(level.teambased) {
      foreach(player in level.players) {
        if(player.team != team)
          self enablePlayerUse(player);
        else
          self disablePlayerUse(player);
      }
    } else {
      foreach(player in level.players) {
        if(player != owner)
          self enablePlayerUse(player);
        else
          self disablePlayerUse(player);
      }
    }

    level waittill("joined_team");
  }
}

initGameFlags() {
  if(!isDefined(game["flags"]))
    game["flags"] = [];
}

gameFlagInit(flagName, isEnabled) {
  assert(isDefined(game["flags"]));
  game["flags"][flagName] = isEnabled;
}

gameFlag(flagName) {
  assertEx(isDefined(game["flags"][flagName]), "gameFlag " + flagName + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )");
  return (game["flags"][flagName]);
}

gameFlagSet(flagName) {
  assertEx(isDefined(game["flags"][flagName]), "gameFlag " + flagName + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )");
  game["flags"][flagName] = true;

  level notify(flagName);
}

gameFlagClear(flagName) {
  assertEx(isDefined(game["flags"][flagName]), "gameFlag " + flagName + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )");
  game["flags"][flagName] = false;
}

gameFlagWait(flagName) {
  assertEx(isDefined(game["flags"][flagName]), "gameFlag " + flagName + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )");
  while(!gameFlag(flagName))
    level waittill(flagName);
}

isPrimaryDamage(meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET")
    return true;
  return false;
}

isBulletDamage(meansofdeath) {
  bulletDamage = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
  if(isSubstr(bulletDamage, meansofdeath))
    return true;
  return false;
}

isFMJDamage(sWeapon, sMeansOfDeath, attacker) {
  return isDefined(attacker) && attacker _hasPerk("specialty_bulletpenetration") && isDefined(sMeansOfDeath) && isBulletDamage(sMeansOfDeath);
}

initLevelFlags() {
  if(!isDefined(level.levelFlags))
    level.levelFlags = [];
}

levelFlagInit(flagName, isEnabled) {
  assert(isDefined(level.levelFlags));
  level.levelFlags[flagName] = isEnabled;
}

levelFlag(flagName) {
  assertEx(isDefined(level.levelFlags[flagName]), "levelFlag " + flagName + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )");
  return (level.levelFlags[flagName]);
}

levelFlagSet(flagName) {
  assertEx(isDefined(level.levelFlags[flagName]), "levelFlag " + flagName + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )");
  level.levelFlags[flagName] = true;

  level notify(flagName);
}

levelFlagClear(flagName) {
  assertEx(isDefined(level.levelFlags[flagName]), "levelFlag " + flagName + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )");
  level.levelFlags[flagName] = false;

  level notify(flagName);
}

levelFlagWait(flagName) {
  assertEx(isDefined(level.levelFlags[flagName]), "levelFlag " + flagName + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )");
  while(!levelFlag(flagName))
    level waittill(flagName);
}

levelFlagWaitOpen(flagName) {
  assertEx(isDefined(level.levelFlags[flagName]), "levelFlag " + flagName + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )");
  while(levelFlag(flagName))
    level waittill(flagName);
}

initGlobals() {
  if(!isDefined(level.global_tables)) {
    level.global_tables["killstreakTable"] = spawnStruct();
    level.global_tables["killstreakTable"].path = "mp/killstreakTable.csv";
    level.global_tables["killstreakTable"].index_col = 0;
    level.global_tables["killstreakTable"].ref_col = 1;
    level.global_tables["killstreakTable"].name_col = 2;
    level.global_tables["killstreakTable"].desc_col = 3;
    level.global_tables["killstreakTable"].kills_col = 4;
    level.global_tables["killstreakTable"].earned_hint_col = 5;
    level.global_tables["killstreakTable"].sound_col = 6;
    level.global_tables["killstreakTable"].earned_dialog_col = 7;
    level.global_tables["killstreakTable"].allies_dialog_col = 8;
    level.global_tables["killstreakTable"].enemy_dialog_col = 9;
    level.global_tables["killstreakTable"].enemy_use_dialog_col = 10;
    level.global_tables["killstreakTable"].weapon_col = 11;
    level.global_tables["killstreakTable"].score_col = 12;
    level.global_tables["killstreakTable"].icon_col = 13;
    level.global_tables["killstreakTable"].overhead_icon_col = 14;
    level.global_tables["killstreakTable"].dpad_icon_col = 15;
    level.global_tables["killstreakTable"].unearned_icon_col = 16;
    level.global_tables["killstreakTable"].all_team_steak_col = 17;
  }
}

isKillStreakDenied() {
  return (self isEMPed() || isAirDenied());
}

isEMPed() {
  if(self.team == "spectator")
    return false;

  if(level.teamBased) {
    return (level.teamEMPed[self.team] || (isDefined(self.empGrenaded) && self.empGrenaded) || level.teamNukeEMPed[self.team]);
  } else {
    return ((isDefined(level.empPlayer) && level.empPlayer != self) || (isDefined(self.empGrenaded) && self.empGrenaded) || (isDefined(level.nukeInfo.player) && self != level.nukeInfo.player && level.teamNukeEMPed[self.team]));
  }
}

isAirDenied() {
  if(self.team == "spectator")
    return false;

  if(level.teamBased)
    return (level.teamAirDenied[self.team]);
  else
    return (isDefined(level.airDeniedPlayer) && level.airDeniedPlayer != self);
}

isNuked() {
  if(self.team == "spectator")
    return false;

  return (isDefined(self.nuked));
}

getPlayerForGuid(guid) {
  foreach(player in level.players) {
    if(player.guid == guid)
      return player;
  }

  return undefined;
}

teamPlayerCardSplash(splash, owner, team, optionalNumber) {
  if(level.hardCoreMode && !is_aliens()) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(team) && player.team != team) {
      continue;
    }
    if(!isPlayer(player)) {
      continue;
    }
    player thread maps\mp\gametypes\_hud_message::playerCardSplashNotify(splash, owner, optionalNumber);
  }
}

isCACPrimaryWeapon(weapName) {
  switch (getWeaponClass(weapName)) {
    case "weapon_smg":
    case "weapon_assault":
    case "weapon_riot":
    case "weapon_sniper":
    case "weapon_dmr":
    case "weapon_lmg":
    case "weapon_shotgun":
      return true;
    default:
      return false;
  }
}

isCACSecondaryWeapon(weapName) {
  switch (getWeaponClass(weapName)) {
    case "weapon_projectile":
    case "weapon_pistol":
    case "weapon_machine_pistol":
      return true;
    default:
      return false;
  }
}

getLastLivingPlayer(team) {
  livePlayer = undefined;

  foreach(player in level.players) {
    if(isDefined(team) && player.team != team) {
      continue;
    }
    if(!isReallyAlive(player) && !player maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    if(isDefined(player.switching_teams) && player.switching_teams) {
      continue;
    }
    assertEx(!isDefined(livePlayer), "getLastLivingPlayer() found more than one live player on team.");

    livePlayer = player;
  }

  return livePlayer;
}

getPotentialLivingPlayers() {
  livePlayers = [];

  foreach(player in level.players) {
    if(!isReallyAlive(player) && !player maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    livePlayers[livePlayers.size] = player;
  }

  return livePlayers;
}

waitTillRecoveredHealth(time, interval) {
  self endon("death");
  self endon("disconnect");

  fullHealthTime = 0;

  if(!isDefined(interval))
    interval = .05;

  if(!isDefined(time))
    time = 0;

  while(1) {
    if(self.health != self.maxhealth)
      fullHealthTime = 0;
    else
      fullHealthTime += interval;

    wait interval;

    if(self.health == self.maxhealth && fullHealthTime >= time) {
      break;
    }
  }

  return;
}

enableWeaponLaser() {
  if(!isDefined(self.weaponLaserCalls)) {
    self.weaponLaserCalls = 0;
  }

  self.weaponLaserCalls++;
  self LaserOn();
}

disableWeaponLaser() {
  AssertEx(isDefined(self.weaponLaserCalls), "disableWeaponLaser() called before at least one enableWeaponLaser() call.");

  self.weaponLaserCalls--;

  AssertEx(self.weaponLaserCalls >= 0, "disableWeaponLaser() called at least one more time than enableWeaponLaser() causing a negative call count.");

  if(self.weaponLaserCalls == 0) {
    self LaserOff();
    self.weaponLaserCalls = undefined;
  }
}

attachmentMap_toUnique(attachmentName, weaponName) {
  nameUnique = attachmentName;
  weaponName = getBaseWeaponName(weaponName);

  AssertEx(isDefined(level.attachmentMap_baseToUnique), "attachmentMap() called without first calling buildAttachmentMaps()");

  if(isDefined(level.attachmentMap_baseToUnique[weaponName]) && isDefined(level.attachmentMap_baseToUnique[weaponName][attachmentName])) {
    nameUnique = level.attachmentMap_baseToUnique[weaponName][attachmentName];
  } else {
    if(is_aliens()) {
      weapClass = TableLookup("mp/alien/mode_string_tables/alien_statstable.csv", 4, weaponName, 2);
    } else {
      weapClass = TableLookup("mp/statstable.csv", 4, weaponName, 2);
    }
    if(isDefined(level.attachmentMap_baseToUnique[weapClass]) && isDefined(level.attachmentMap_baseToUnique[weapClass][attachmentName])) {
      nameUnique = level.attachmentMap_baseToUnique[weapClass][attachmentName];
    }
  }
  return nameUnique;
}

attachmentPerkMap(attachmentName) {
  AssertEx(isDefined(level.attachmentMap_attachToPerk), "attachmentPerkMap() called without first calling buildAttachmentMaps()");

  perk = undefined;

  if(isDefined(level.attachmentMap_attachToPerk[attachmentName])) {
    perk = level.attachmentMap_attachToPerk[attachmentName];
  }
  return perk;
}

weaponPerkMap(weaponName) {
  AssertEx(isDefined(level.weaponMap_toPerk), "weaponPerkMap() called without first calling buildWeaponPerkMap().");

  perk = undefined;

  if(isDefined(level.weaponMap_toPerk[weaponName])) {
    perk = level.weaponMap_toPerk[weaponName];
  }
  return perk;
}

isAttachmentSniperScopeDefault(weaponName, attachName) {
  tokens = StrTok(weaponName, "_");

  return isAttachmentSniperScopeDefaultTokenized(tokens, attachName);
}

isAttachmentSniperScopeDefaultTokenized(weaponTokens, attachName) {
  AssertEx(IsArray(weaponTokens), "isAttachmentSniperScopeDefaultTokenized() called with non array weapon name.");

  result = false;
  if(weaponTokens.size && isDefined(attachName)) {
    idx = 0;
    if(weaponTokens[0] == "alt") {
      idx = 1;
    }

    if(weaponTokens.size >= 3 + idx && (weaponTokens[idx] == "iw5" || weaponTokens[idx] == "iw6")) {
      if(weaponClass(weaponTokens[idx] + "_" + weaponTokens[idx + 1] + "_" + weaponTokens[idx + 2]) == "sniper") {
        result = weaponTokens[idx + 1] + "scope" == attachName;
      }
    }
  }
  return result;
}

getNumDefaultAttachments(weaponName) {
  if(WeaponClass(weaponName) == "sniper") {
    weaponAttachments = getWeaponAttachments(weaponName);
    foreach(attachment in weaponAttachments) {
      if(isAttachmentSniperScopeDefault(weaponName, attachment)) {
        return 1;
      }
    }
  } else if(isStrStart(weaponName, "iw6_dlcweap02")) {
    weaponAttachments = GetWeaponAttachments(weaponName);
    foreach(attachment in weaponAttachments) {
      if(attachment == "dlcweap02scope") {
        return 1;
      }
    }
  }

  return 0;
}

getWeaponAttachmentsBaseNames(weaponName) {
  attachmentsBase = GetWeaponAttachments(weaponName);
  foreach(idx, attachment in attachmentsBase) {
    attachmentsBase[idx] = attachmentMap_toBase(attachment);
  }

  return attachmentsBase;
}

getAttachmentListBaseNames() {
  attachmentList = [];

  index = 0;
  if(is_aliens())
    attachmentName = TableLookup("mp/alien/alien_attachmentTable.csv", 0, index, 5);
  else
    attachmentName = TableLookup("mp/attachmentTable.csv", 0, index, 5);

  while(attachmentName != "") {
    if(!array_contains(attachmentList, attachmentName)) {
      attachmentList[attachmentList.size] = attachmentName;
    }

    index++;
    if(is_aliens())
      attachmentName = TableLookup("mp/alien/alien_attachmentTable.csv", 0, index, 5);
    else
      attachmentName = TableLookup("mp/attachmentTable.csv", 0, index, 5);
  }

  return attachmentList;
}

getAttachmentListUniqeNames() {
  attachmentList = [];

  index = 0;

  if(is_aliens())
    attachmentName = TableLookup("mp/alien/alien_attachmentTable.csv", 0, index, 4);
  else
    attachmentName = TableLookup("mp/attachmentTable.csv", 0, index, 4);

  while(attachmentName != "") {
    AssertEx(!isDefined(attachmentList[attachmentName]), "Duplicate unique attachment reference name found in attachmentTable.csv");

    attachmentList[attachmentList.size] = attachmentName;

    index++;

    if(is_aliens())
      attachmentName = tableLookup("mp/alien/alien_attachmentTable.csv", 0, index, 4);
    else
      attachmentName = TableLookup("mp/attachmentTable.csv", 0, index, 4);
  }

  return attachmentList;
}

buildAttachmentMaps() {
  AssertEx(!isDefined(level.attachmentMap_uniqueToBase), "buildAttachmentMaps() called when map already existed.");

  attachmentNamesUnique = getAttachmentListUniqeNames();

  level.attachmentMap_uniqueToBase = [];

  foreach(uniqueName in attachmentNamesUnique) {
    if(is_aliens())
      baseName = TableLookup("mp/alien/alien_attachmentTable.csv", 4, uniqueName, 5);
    else
      baseName = TableLookup("mp/attachmenttable.csv", 4, uniqueName, 5);

    AssertEx(isDefined(baseName) && baseName != "", "No base attachment name found in attachmentTable.csv for unique name: " + uniqueName);

    if(uniqueName == baseName) {
      continue;
    }
    level.attachmentMap_uniqueToBase[uniqueName] = baseName;
  }

  AssertEx(!isDefined(level.attachmentMap_baseToUnique), "buildAttachmentMaps() called when map already existed.");

  weaponClassesAndNames = [];
  idxRow = 1;
  if(is_aliens())
    classOrName = TableLookupByRow(ALIENS_ATTACHMAP_TABLE, idxRow, ALIENS_ATTACHMAP_COL_CLASS_OR_WEAP_NAME);
  else
    classOrName = TableLookupByRow(ATTACHMAP_TABLE, idxRow, ATTACHMAP_COL_CLASS_OR_WEAP_NAME);

  while(classOrName != "") {
    weaponClassesAndNames[weaponClassesAndNames.size] = classOrName;

    idxRow++;
    if(is_aliens())
      classOrName = TableLookupByRow(ALIENS_ATTACHMAP_TABLE, idxRow, ALIENS_ATTACHMAP_COL_CLASS_OR_WEAP_NAME);
    else
      classOrName = TableLookupByRow(ATTACHMAP_TABLE, idxRow, ATTACHMAP_COL_CLASS_OR_WEAP_NAME);
  }

  attachmentNameColumns = [];

  idxCol = 1;
  if(is_aliens())
    attachTitle = TableLookupByRow(ALIENS_ATTACHMAP_TABLE, ALIENS_ATTACHMAP_ROW_ATTACH_BASE_NAME, idxCol);
  else
    attachTitle = TableLookupByRow(ATTACHMAP_TABLE, ATTACHMAP_ROW_ATTACH_BASE_NAME, idxCol);

  while(attachTitle != "") {
    attachmentNameColumns[attachTitle] = idxCol;

    idxCol++;

    if(is_aliens())
      attachTitle = TableLookupByRow(ALIENS_ATTACHMAP_TABLE, ALIENS_ATTACHMAP_ROW_ATTACH_BASE_NAME, idxCol);
    else
      attachTitle = TableLookupByRow(ATTACHMAP_TABLE, ATTACHMAP_ROW_ATTACH_BASE_NAME, idxCol);
  }

  level.attachmentMap_baseToUnique = [];

  foreach(classOrName in weaponClassesAndNames) {
    foreach(attachment, column in attachmentNameColumns) {
      if(is_aliens())
        attachNameUnique = TableLookup(ALIENS_ATTACHMAP_TABLE, ALIENS_ATTACHMAP_COL_CLASS_OR_WEAP_NAME, classOrName, column);
      else
        attachNameUnique = TableLookup(ATTACHMAP_TABLE, ATTACHMAP_COL_CLASS_OR_WEAP_NAME, classOrName, column);

      if(attachNameUnique == "") {
        continue;
      }
      if(!isDefined(level.attachmentMap_baseToUnique[classOrName])) {
        level.attachmentMap_baseToUnique[classOrName] = [];
      }

      AssertEx(!isDefined(level.attachmentMap_baseToUnique[classOrName][attachment]), "Multiple entries found for uniqe attachment of base name: " + attachment);

      level.attachmentMap_baseToUnique[classOrName][attachment] = attachNameUnique;
    }
  }

  AssertEx(!isDefined(level.attachmentMap_attachToPerk), "buildAttachmentMaps() called when map already existed.");

  level.attachmentMap_attachToPerk = [];

  foreach(attachName in attachmentNamesUnique) {
    if(is_aliens())
      perkName = TableLookup("mp/alien/alien_attachmenttable.csv", 4, attachName, 12);
    else
      perkName = TableLookup("mp/attachmenttable.csv", 4, attachName, 12);

    if(perkName == "") {
      continue;
    }
    level.attachmentMap_attachToPerk[attachName] = perkName;
  }
}

buildWeaponPerkMap() {
  AssertEx(!isDefined(level.weaponMap_toPerk), "buildWeaponPerkMap() called when map already existed.");

  level.weaponMap_toPerk = [];

  if(is_aliens()) {
    return;
  }
  weaponIdx = 0;
  while(TableLookup("mp/statstable.csv", 0, weaponIdx, 0) != "") {
    perk = TableLookup("mp/statstable.csv", 0, weaponIdx, 5);

    if(perk != "") {
      weapon = TableLookup("mp/statstable.csv", 0, weaponIdx, 4);

      Assert(weapon != "", "buildWeaponPerkMap() found perk: " + perk + " entered without a weapon name.");

      if(weapon != "") {
        level.weaponMap_toPerk[weapon] = perk;
      }
    }
    weaponIdx++;
  }
}

attachmentMap_toBase(attachmentName) {
  AssertEx(isDefined(level.attachmentMap_uniqueToBase), "validateAttachment() called without first calling buildAttachmentMaps()");

  if(isDefined(level.attachmentMap_uniqueToBase[attachmentName])) {
    attachmentName = level.attachmentMap_uniqueToBase[attachmentName];
  }

  return attachmentName;
}

weaponMap(weaponName) {
  if(isDefined(weaponName)) {
    switch (weaponName) {
      case "semtexproj_mp":
        weaponName = "iw6_mk32_mp";
        break;
      case "iw6_maawschild_mp":
      case "iw6_maawshoming_mp":
        weaponName = "iw6_maaws_mp";
        break;
      case "iw6_knifeonlyfast_mp":
        weaponName = "iw6_knifeonly_mp";
        break;
      case "iw6_pdwauto_mp":
        weaponName = "iw6_pdw_mp";
      default:
        break;
    }
  }

  return weaponName;
}

weaponHasIntegratedSilencer(baseWeapon) {
  return (baseWeapon == "iw6_vks" || baseWeapon == "iw6_k7" || baseWeapon == "iw6_honeybadger");
}

weaponIsFireTypeBurst(weaponName) {
  if(weaponHasIntegratedFireTypeBurst(weaponName)) {
    return true;
  } else {
    return weaponHasAttachment(weaponName, "firetypeburst");
  }
}

weaponHasIntegratedFireTypeBurst(weaponName) {
  baseWeapon = getBaseWeaponName(weaponName);

  if(baseWeapon == "iw6_pdw")
    return true;
  else if(baseWeapon == "iw6_msbs") {
    weaponAttachments = getWeaponAttachmentsBaseNames(weaponName);
    foreach(attachment in weaponAttachments) {
      if(attachment == "firetypeauto" || attachment == "firetypesingle")
        return false;
    }

    return true;
  } else
    return false;
}

weaponHasIntegratedGrip(baseWeapon) {
  return (baseWeapon == "iw6_g28");
}

weaponHasIntegratedFMJ(baseWeapon) {
  return (baseWeapon == "iw6_cbjms");
}

weaponHasIntegratedTrackerScope(weaponName) {
  baseWeapon = getBaseWeaponName(weaponName);

  if(baseWeapon == "iw6_dlcweap03") {
    weaponAttachments = GetWeaponAttachments(weaponName);
    foreach(attachment in weaponAttachments) {
      if(isStrStart(attachment, "dlcweap03"))
        return true;
    }
  }
  return false;
}

weaponHasAttachment(weaponName, attachmentName) {
  weaponAttachments = getWeaponAttachmentsBaseNames(weaponName);
  foreach(attachment in weaponAttachments) {
    if(attachment == attachmentName)
      return true;
  }

  return false;
}

weaponGetNumAttachments(weaponName) {
  numDefaultAttachments = getNumDefaultAttachments(weaponName);
  weaponAttachments = getWeaponAttachments(weaponName);

  return weaponAttachments.size - numDefaultAttachments;
}

isPlayerAds() {
  return (self PlayerAds() > 0.5);
}

_objective_delete(objID) {
  objective_delete(objID);

  if(!isDefined(level.reclaimedReservedObjectives)) {
    level.reclaimedReservedObjectives = [];
    level.reclaimedReservedObjectives[0] = objID;
  } else {
    level.reclaimedReservedObjectives[level.reclaimedReservedObjectives.size] = objID;
  }
}

touchingBadTrigger(optionalEnt) {
  killTriggers = getEntArray("trigger_hurt", "classname");
  foreach(trigger in killTriggers) {
    if(self isTouching(trigger) && (level.mapName != "mp_mine" || trigger.dmg > 0))
      return true;
  }

  radTriggers = getEntArray("radiation", "targetname");
  foreach(trigger in radTriggers) {
    if(self isTouching(trigger))
      return true;
  }

  if(isDefined(optionalEnt) && optionalEnt == "gryphon") {
    gryphonTriggers = getEntArray("gryphonDeath", "targetname");
    foreach(trigger in gryphonTriggers) {
      if(self isTouching(trigger))
        return true;
    }
  }

  return false;
}

setThirdPersonDOF(isEnabled) {
  if(isEnabled)
    self setDepthOfField(0, 110, 512, 4096, 6, 1.8);
  else
    self setDepthOfField(0, 0, 512, 512, 4, 0);
}

killTrigger(pos, radius, height) {
  trig = spawn("trigger_radius", pos, 0, radius, height);

  if(getDvar("scr_killtriggerdebug") == "1")
    thread killTriggerDebug(pos, radius, height);

  for(;;) {
    if(getDvar("scr_killtriggerradius") != "")
      radius = int(getDvar("scr_killtriggerradius"));

    trig waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    player suicide();
  }
}

findIsFacing(ent1, ent2, tolerance) {
  facingCosine = Cos(tolerance);

  ent1ForwardVector = anglesToForward(ent1.angles);
  ent1ToTarget = ent2.origin - ent1.origin;
  ent1ForwardVector *= (1, 1, 0);
  ent1ToTarget *= (1, 1, 0);

  ent1ToTarget = VectorNormalize(ent1ToTarget);
  ent1ForwardVector = VectorNormalize(ent1ForwardVector);

  targetCosine = VectorDot(ent1ToTarget, ent1ForwardVector);

  if(targetCosine >= facingCosine)
    return true;
  else
    return false;
}

drawLine(start, end, timeSlice, color) {
  drawTime = int(timeSlice * 20);
  for(time = 0; time < drawTime; time++) {
    line(start, end, color, false, 1);
    wait(0.05);
  }
}

drawSphere(origin, radius, timeSlice, color) {
  drawTime = int(timeSlice * 20);
  for(time = 0; time < drawTime; time++) {
    Sphere(origin, radius, color);
    wait(0.05);
  }
}

setRecoilScale(scaler, scaleOverride) {
  if(!isDefined(scaler))
    scaler = 0;

  if(!isDefined(self.recoilScale))
    self.recoilScale = scaler;
  else
    self.recoilScale += scaler;

  if(isDefined(scaleOverride)) {
    if(isDefined(self.recoilScale) && scaleOverride < self.recoilScale)
      scaleOverride = self.recoilScale;

    scale = 100 - scaleOverride;
  } else
    scale = 100 - self.recoilScale;

  if(scale < 0)
    scale = 0;

  if(scale > 100)
    scale = 100;

  if(scale == 100) {
    self player_recoilScaleOff();
    return;
  }

  self player_recoilScaleOn(scale);
}

cleanArray(array) {
  newArray = [];

  foreach(key, elem in array) {
    if(!isDefined(elem)) {
      continue;
    }
    newArray[newArray.size] = array[key];
  }

  return newArray;
}

killTriggerDebug(pos, radius, height) {
  for(;;) {
    for(i = 0; i < 20; i++) {
      angle = i / 20 * 360;
      nextangle = (i + 1) / 20 * 360;

      linepos = pos + (cos(angle) * radius, sin(angle) * radius, 0);
      nextlinepos = pos + (cos(nextangle) * radius, sin(nextangle) * radius, 0);

      line(linepos, nextlinepos);
      line(linepos + (0, 0, height), nextlinepos + (0, 0, height));
      line(linepos, linepos + (0, 0, height));
    }
    wait .05;
  }
}

notUsableForJoiningPlayers(owner) {
  self notify("notusablejoiningplayers");

  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");
  owner endon("death");
  self endon("notusablejoiningplayers");

  while(true) {
    level waittill("player_spawned", player);
    if(isDefined(player) && player != owner) {
      self disablePlayerUse(player);
    }
  }
}

isStrStart(string, subStr) {
  return (GetSubStr(string, 0, subStr.size) == subStr);
}

disableAllStreaks() {
  level.killstreaksDisabled = true;
}

enableAllStreaks() {
  level.killstreaksDisabled = undefined;
}

validateUseStreak(optional_streakname, disable_print_output) {
  if(isDefined(optional_streakname)) {
    streakName = optional_streakname;
  } else {
    self_pers_killstreaks = self.pers["killstreaks"];
    streakName = self_pers_killstreaks[self.killstreakIndexWeapon].streakName;
  }

  if(isDefined(level.killstreaksDisabled) && level.killstreaksDisabled)
    return false;

  if(!self IsOnGround() && (isRideKillstreak(streakName) || isCarryKillstreak(streakName)))
    return false;

  if(self isUsingRemote())
    return false;

  if(isDefined(self.selectingLocation))
    return false;

  if(shouldPreventEarlyUse(streakName) && level.killstreakRoundDelay) {
    if(level.gracePeriod - level.inGracePeriod < level.killstreakRoundDelay) {
      if(!(isDefined(disable_print_output) && disable_print_output))
        self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_FOR_N", (level.killstreakRoundDelay - (level.gracePeriod - level.inGracePeriod)));
      return false;
    }
  }

  if(isDefined(self.nuked) && self.nuked && isEMPed()) {
    if(isKillstreakAffectedByEMP(streakName)) {
      if(!(isDefined(disable_print_output) && disable_print_output))
        self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_FOR_N_WHEN_NUKE", level.nukeEmpTimeRemaining);
      return false;
    }
  }

  if(self isEMPed()) {
    if(isKillstreakAffectedByEMP(streakName)) {
      if(!(isDefined(disable_print_output) && disable_print_output))
        self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_WHEN_JAMMED");
      return false;
    }
  }

  if(self isAirDenied()) {
    if(isFlyingKillstreak(streakName) && streakName != "air_superiority") {
      if(!(isDefined(disable_print_output) && disable_print_output))
        self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_WHEN_AA");
      return false;
    }
  }

  if(self IsUsingTurret() && (isRideKillstreak(streakName) || isCarryKillstreak(streakName))) {
    if(!(isDefined(disable_print_output) && disable_print_output))
      self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_USING_TURRET");
    return false;
  }

  if(isDefined(self.lastStand) && !self _hasPerk("specialty_finalstand")) {
    if(!isDefined(level.allowLastStandAI) || !level.allowLastStandAI || (streakName != "agent")) {
      if(!(isDefined(disable_print_output) && disable_print_output))
        self IPrintLnBold(&"KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");

      return false;
    }
  }

  if(!self isWeaponEnabled())
    return false;

  if(isDefined(level.civilianJetFlyBy) && isFlyingKillstreak(streakName)) {
    if(!(isDefined(disable_print_output) && disable_print_output))
      self IPrintLnBold(&"KILLSTREAKS_CIVILIAN_AIR_TRAFFIC");
    return false;
  }

  return true;
}

isRideKillstreak(streakName) {
  switch (streakName) {
    case "vanguard":
    case "heli_pilot":
    case "drone_hive":
    case "odin_support":
    case "odin_assault":
    case "ca_a10_strafe":
    case "ac130":
      return true;

    default:
      return false;
  }
}

isCarryKillstreak(streakName) {
  switch (streakName) {
    case "sentry":
    case "sentry_gl":
    case "minigun_turret":
    case "gl_turret":
    case "deployable_vest":
    case "deployable_ammo":
    case "deployable_grenades":
    case "deployable_exp_ammo":
    case "ims":
      return true;

    default:
      return false;
  }
}

shouldPreventEarlyUse(streakName) {
  switch (streakName) {
    case "uplink":
    case "ims":
    case "guard_dog":
    case "sentry":
    case "ball_drone_backup":
    case "uplink_support":
    case "deployable_ammo":
    case "deployable_vest":
    case "aa_launcher":
    case "ball_drone_radar":
    case "recon_agent":
    case "jammer":
    case "air_superiority":
    case "uav_3dping":
      return false;
    default:

      return (!isStrStart(streakName, "airdrop_"));
  }
}

isKillstreakAffectedByEMP(streakName) {
  switch (streakName) {
    case "deployable_vest":
    case "agent":
    case "recon_agent":
    case "guard_dog":
    case "deployable_ammo":
    case "dome_seekers":
    case "zerosub_level_killstreak":
      return false;

    default:
      return true;
  }
}

isKillstreakAffectedByJammer(streakName) {
  return (isKillstreakAffectedByEMP(streakName) && !isFlyingKillstreak(streakName));
}

isFlyingKillstreak(streakName) {
  switch (streakName) {
    case "helicopter":
    case "airdrop_sentry_minigun":
    case "airdrop_juggernaut":
    case "airdrop_juggernaut_recon":
    case "heli_sniper":
    case "airdrop_assault":
    case "airdrop_juggernaut_maniac":
    case "heli_pilot":
    case "air_superiority":
    case "odin_support":
    case "odin_assault":
    case "vanguard":
    case "drone_hive":
    case "ca_a10_strafe":
    case "ac130":
      return true;

    default:
      return false;
  }
}

isAllTeamStreak(streakName) {
  isTeamStreak = getKillstreakAllTeamStreak(streakName);

  if(!isDefined(isTeamStreak))
    return false;

  if(Int(isTeamStreak) == 1)
    return true;

  return false;
}

getKillstreakRowNum(streakName) {
  return TableLookupRowNum(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName);
}

getKillstreakIndex(streakName) {
  indexString = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].index_col);
  if(indexString == "")
    index = -1;
  else
    index = int(indexString);
  return index;
}

getKillstreakReference(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].ref_col);
}

getKillstreakReferenceByWeapon(streakWeapon) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].weapon_col, streakWeapon, level.global_tables["killstreakTable"].ref_col);
}

getKillstreakName(streakName) {
  return TableLookupIString(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].name_col);
}

getKillstreakDescription(streakName) {
  return TableLookupIString(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].desc_col);
}

getKillstreakKills(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].kills_col);
}

getKillstreakEarnedHint(streakName) {
  return TableLookupIString(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].earned_hint_col);
}

getKillstreakSound(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].sound_col);
}

getKillstreakEarnedDialog(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].earned_dialog_col);
}

getKillstreakAlliesDialog(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].allies_dialog_col);
}

getKillstreakEnemyDialog(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].enemy_dialog_col);
}

getKillstreakEnemyUseDialog(streakName) {
  return int(TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].enemy_use_dialog_col));
}

getKillstreakWeapon(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].weapon_col);
}

getKillstreakScore(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].score_col);
}

getKillstreakIcon(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].icon_col);
}

getKillstreakOverheadIcon(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].overhead_icon_col);
}

getKillstreakDpadIcon(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].dpad_icon_col);
}

getKillstreakUnearnedIcon(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].unearned_icon_col);
}

getKillstreakAllTeamStreak(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].all_team_streak_col);
}

currentActiveVehicleCount(extra) {
  if(!isDefined(extra))
    extra = 0;

  count = extra;
  if(isDefined(level.helis))
    count += level.helis.size;
  if(isDefined(level.littleBirds))
    count += level.littleBirds.size;
  if(isDefined(level.ugvs))
    count += level.ugvs.size;

  return count;
}

maxVehiclesAllowed() {
  return MAX_VEHICLES;
}

incrementFauxVehicleCount() {
  level.fauxVehicleCount++;
}

decrementFauxVehicleCount() {
  level.fauxVehicleCount--;

  currentVehicleCount = currentActiveVehicleCount();

  if(currentVehicleCount > level.fauxVehicleCount)
    level.fauxVehicleCount = currentVehicleCount;

  if(level.fauxVehicleCount < 0)
    level.fauxVehicleCount = 0;
}

lightWeightScalar() {
  return LIGHTWEIGHT_SCALAR;
}

allowTeamChoice() {
  if(level.gameType == "cranked")
    return level.teamBased;

  allowed = int(tableLookup("mp/gametypesTable.csv", 0, level.gameType, 4));
  assert(isDefined(allowed));

  return allowed;
}

allowClassChoice() {
  allowed = int(tableLookup("mp/gametypesTable.csv", 0, level.gameType, 5));
  assert(isDefined(allowed));

  return allowed;
}

showFakeLoadout() {
  if(level.gameType == "sotf" || level.gameType == "sotf_ffa" || level.gametype == "gun" || level.gameType == "infect")
    return true;

  if(level.gameType == "horde" && !matchMakingGame() && IsSplitScreen())
    return false;

  if(level.gameType == "horde" && level.currentRoundNumber == 0)
    return true;

  return false;
}

setFakeLoadoutWeaponSlot(sWeapon, omnvarSlot) {
  weaponName = getBaseWeaponName(sWeapon);
  attachments = [];
  if(weaponName != "iw6_knifeonly" && weaponName != "iw6_knifeonlyfast") {
    attachments = GetWeaponAttachments(sWeapon);
  }

  weaponOmnvar = "ui_fakeloadout_weapon" + omnvarSlot;

  if(isDefined(weaponName)) {
    weaponRowIdx = TableLookupRowNum("mp/statsTable.csv", 4, weaponName);
    self SetClientOmnvar(weaponOmnvar, weaponRowIdx);
  } else {
    self SetClientOmnvar(weaponOmnvar, -1);
  }

  for(i = 0; i < 3; i++) {
    attachmentOmnvar = weaponOmnvar + "_attach" + (i + 1);
    attachmentRowIdx = -1;
    if(isDefined(attachments[i])) {
      if(!isAttachmentSniperScopeDefault(sWeapon, attachments[i])) {
        attachmentRowIdx = TableLookupRowNum("mp/attachmentTable.csv", 4, attachments[i]);
      }
    }

    self SetClientOmnvar(attachmentOmnvar, attachmentRowIdx);
  }
}

isBuffUnlockedForWeapon(buffRef, weaponRef) {
  WEAPON_RANK_TABLE_LEVEL_COL = 4;
  WEAPON_RANK_TABLE_WEAPONCLASS_COL = 0;
  WEAPON_RANK_TABLE_WEAPONCLASS_BUFF_COL = 4;

  weaponRank = self GetRankedPlayerData("weaponRank", weaponRef);
  rankTableBuffCol = int(tableLookup("mp/weaponRankTable.csv", WEAPON_RANK_TABLE_WEAPONCLASS_COL, getWeaponClass(weaponRef), WEAPON_RANK_TABLE_WEAPONCLASS_BUFF_COL));
  rankTableBuffLevel = tableLookup("mp/weaponRankTable.csv", rankTableBuffCol, buffRef, WEAPON_RANK_TABLE_LEVEL_COL);

  if(rankTableBuffLevel != "") {
    if(weaponRank >= int(rankTableBuffLevel))
      return true;
  }

  return false;
}

isBuffEquippedOnWeapon(buffRef, weaponRef) {
  if(isDefined(self.loadoutPrimary) && self.loadoutPrimary == weaponRef) {
    if(isDefined(self.loadoutPrimaryBuff) && self.loadoutPrimaryBuff == buffRef)
      return true;
  } else if(isDefined(self.loadoutSecondary) && self.loadoutSecondary == weaponRef) {
    if(isDefined(self.loadoutSecondaryBuff) && self.loadoutSecondaryBuff == buffRef)
      return true;
  }

  return false;
}

setCommonRulesFromMatchRulesData(skipFriendlyFire) {
  timeLimit = GetMatchRulesData("commonOption", "timeLimit");
  SetDynamicDvar("scr_" + level.gameType + "_timeLimit", timeLimit);
  registerTimeLimitDvar(level.gameType, timeLimit);

  scoreLimit = GetMatchRulesData("commonOption", "scoreLimit");
  SetDynamicDvar("scr_" + level.gameType + "_scoreLimit", scoreLimit);
  registerScoreLimitDvar(level.gameType, scoreLimit);

  numLives = GetMatchRulesData("commonOption", "numLives");
  SetDynamicDvar("scr_" + level.gameType + "_numLives", numLives);
  registerNumLivesDvar(level.gameType, numLives);

  SetDynamicDvar("scr_player_maxhealth", GetMatchRulesData("commonOption", "maxHealth"));
  SetDynamicDvar("scr_player_healthregentime", GetMatchRulesData("commonOption", "healthRegen"));

  level.matchRules_damageMultiplier = 0;
  level.matchRules_vampirism = 0;

  SetDynamicDvar("scr_game_spectatetype", GetMatchRulesData("commonOption", "spectateModeAllowed"));
  SetDynamicDvar("scr_game_allowkillcam", GetMatchRulesData("commonOption", "showKillcam"));
  SetDynamicDvar("scr_game_forceuav", GetMatchRulesData("commonOption", "radarAlwaysOn"));
  SetDynamicDvar("scr_" + level.gameType + "_playerrespawndelay", GetMatchRulesData("commonOption", "respawnDelay"));
  SetDynamicDvar("scr_" + level.gameType + "_waverespawndelay", GetMatchRulesData("commonOption", "waveRespawnDelay"));
  SetDynamicDvar("scr_player_forcerespawn", GetMatchRulesData("commonOption", "forceRespawn"));

  level.matchRules_allowCustomClasses = GetMatchRulesData("commonOption", "allowCustomClasses");
  level.supportIntel = GetMatchRulesData("commonOption", "allowIntel");
  SetDynamicDvar("scr_game_hardpoints", GetMatchRulesData("commonOption", "allowKillstreaks"));
  SetDynamicDvar("scr_game_perks", GetMatchRulesData("commonOption", "allowPerks"));
  SetDynamicDvar("g_hardcore", GetMatchRulesData("commonOption", "hardcoreModeOn"));

  SetDynamicDvar("scr_game_onlyheadshots", GetMatchRulesData("commonOption", "headshotsOnly"));
  if(!isDefined(skipFriendlyFire))
    SetDynamicDvar("scr_team_fftype", GetMatchRulesData("commonOption", "friendlyFire"));

  if(GetMatchRulesData("commonOption", "hardcoreModeOn")) {
    SetDynamicDvar("scr_team_fftype", 2);
    SetDynamicDvar("scr_player_maxhealth", 30);
    SetDynamicDvar("scr_player_healthregentime", 0);
    SetDynamicDvar("scr_player_respawndelay", 0);

    SetDynamicDvar("scr_game_allowkillcam", 0);
    SetDynamicDvar("scr_game_forceuav", 0);
  }

  setDvar("bg_compassShowEnemies", getDvar("scr_game_forceuav"));
}

reInitializeMatchRulesOnMigration() {
  assert(isUsingMatchRulesData());
  assert(isDefined(level.initializeMatchRules));

  while(1) {
    level waittill("host_migration_begin");
    [[level.initializeMatchRules]]();
  }
}

reInitializeThermal(ent) {
  self endon("disconnect");

  if(isDefined(ent))
    ent endon("death");

  while(true) {
    level waittill("host_migration_begin");
    if(isDefined(self.lastVisionSetThermal))
      self VisionSetThermalForPlayer(self.lastVisionSetThermal, 0);
  }
}

reInitializeDevDvarsOnMigration() {
  level notify("reInitializeDevDvarsOnMigration");
  level endon("reInitializeDevDvarsOnMigration");

  while(1) {
    level waittill("host_migration_begin");

    SetDevDvarIfUninitialized("scr_emp_timeout", 15.0);
    SetDevDvarIfUninitialized("scr_nuke_empTimeout", 60.0);
    SetDevDvarIfUninitialized("scr_uav_timeout", level.radarViewTime);

    SetDevDvarIfUninitialized("scr_balldrone_timeout", 60.0);
    SetDevDvarIfUninitialized("scr_balldrone_debug_position", 0);
    SetDevDvarIfUninitialized("scr_balldrone_debug_position_forward", 50.0);
    SetDevDvarIfUninitialized("scr_balldrone_debug_position_height", 35.0);

    SetDevDvarIfUninitialized("scr_devIntelChallengeName", "temp");

    SetDevDvarIfUninitialized("scr_devchangetimelimit", -1);

    SetDevDvarIfUninitialized("scr_odin_support_timeout", 60.0);
    SetDevDvarIfUninitialized("scr_odin_assault_timeout", 60.0);

    SetDevDvarIfUninitialized("scr_cranked_bomb_timer", 30);

    SetDevDvarIfUninitialized("scr_helipilot_timeout", 60.0);

    SetDevDvarIfUninitialized("scr_ims_timeout", 90.0);

    SetDevDvarIfUninitialized("scr_vanguard_reloadTime", 1500);
  }
}

GetMatchRulesSpecialClass(team, index) {
  class = [];
  class ["loadoutPrimaryAttachment2"] = "none";
  class ["loadoutSecondaryAttachment2"] = "none";

  loadoutAbilities = [];

  AssertEx(isDefined(team) && team != "none", "The team value needs to be valid in order to get the correct default loadout");

  class ["loadoutPrimary"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "weapon");
  class ["loadoutPrimaryAttachment"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "attachment", 0);
  class ["loadoutPrimaryAttachment2"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "attachment", 1);
  class ["loadoutPrimaryBuff"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "buff");
  class ["loadoutPrimaryCamo"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "camo");
  class ["loadoutPrimaryReticle"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "reticle");

  class ["loadoutSecondary"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "weapon");
  class ["loadoutSecondaryAttachment"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "attachment", 0);
  class ["loadoutSecondaryAttachment2"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "attachment", 1);
  class ["loadoutSecondaryBuff"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "buff");
  class ["loadoutSecondaryCamo"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "camo");
  class ["loadoutSecondaryReticle"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "reticle");

  class ["loadoutEquipment"] = getMatchRulesData("defaultClasses", team, index, "class", "perks", 0);
  class ["loadoutOffhand"] = getMatchRulesData("defaultClasses", team, index, "class", "perks", 1);

  if(class ["loadoutOffhand"] == "specialty_null") {
    class ["loadoutOffhand"] = "none";

    if(level.gameType == "infect" && team == "axis")
      class ["loadoutOffhand"] = "specialty_tacticalinsertion";
  }

  for(abilityCategoryIndex = 0; abilityCategoryIndex < maps\mp\gametypes\_class::getNumAbilityCategories(); abilityCategoryIndex++) {
    for(abilityIndex = 0; abilityIndex < maps\mp\gametypes\_class::getNumSubAbility(); abilityIndex++) {
      picked = false;
      picked = getMatchRulesData("defaultClasses", team, index, "class", "abilitiesPicked", abilityCategoryIndex, abilityIndex);
      if(isDefined(picked) && picked) {
        abilityRef = TableLookup("mp/cacAbilityTable.csv", 0, abilityCategoryIndex + 1, abilityIndex + 4);
        loadoutAbilities[loadoutAbilities.size] = abilityRef;
      }
    }
  }

  class ["loadoutPerks"] = loadoutAbilities;

  loadoutStreakType = getMatchRulesData("defaultClasses", team, index, "class", "perks", 5);
  if(loadoutStreakType != "specialty_null") {
    class ["loadoutStreakType"] = loadoutStreakType;
    class ["loadoutKillstreak1"] = maps\mp\gametypes\_class::recipe_getKillstreak(team, index, loadoutStreakType, 0);
    class ["loadoutKillstreak2"] = maps\mp\gametypes\_class::recipe_getKillstreak(team, index, loadoutStreakType, 1);
    class ["loadoutKillstreak3"] = maps\mp\gametypes\_class::recipe_getKillstreak(team, index, loadoutStreakType, 2);
  }

  class ["loadoutJuggernaut"] = getMatchRulesData("defaultClasses", team, index, "juggernaut");

  return class;
}

recipeClassApplyJuggernaut(removeJuggernaut) {
  level endon("game_ended");
  self endon("disconnect");

  if(level.inGracePeriod && !self.hasDoneCombat)
    self waittill("giveLoadout");
  else
    self waittill("spawned_player");

  if(removeJuggernaut) {
    self notify("lost_juggernaut");
    wait(0.5);
  }

  if(!isDefined(self.isJuiced)) {
    self.moveSpeedScaler = 0.7;
    self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  }
  self.juggMoveSpeedScaler = 0.7;
  self disableWeaponPickup();

  if(!getDvarInt("camera_thirdPerson")) {
    self SetClientOmnvar("ui_juggernaut", 1);
  }

  self thread maps\mp\killstreaks\_juggernaut::juggernautSounds();

  if(level.gameType != "jugg" || (isDefined(level.matchRules_showJuggRadarIcon) && level.matchRules_showJuggRadarIcon))
    self setPerk("specialty_radarjuggernaut", true, false);

  if(isDefined(self.isJuggModeJuggernaut) && self.isJuggModeJuggernaut) {
    self makePortableRadar(self);
  }

  level notify("juggernaut_equipped", self);

  self thread maps\mp\killstreaks\_juggernaut::juggRemover();
}

updateSessionState(sessionState, statusIcon) {
  assert(sessionState == "playing" || sessionState == "dead" || sessionState == "spectator" || sessionState == "intermission");
  self.sessionstate = sessionState;

  if(!isDefined(statusIcon))
    statusIcon = "";
  self.statusicon = statusIcon;

  self SetClientOmnvar("ui_session_state", sessionState);
}

getClassIndex(className) {
  assert(isDefined(level.classMap[className]));

  return level.classMap[className];
}

isTeamInLastStand() {
  myteam = getLivingPlayers(self.team);
  foreach(guy in myteam) {
    if(guy != self && (!isDefined(guy.lastStand) || !guy.lastStand)) {
      return false;
    }
  }
  return true;
}

killTeamInLastStand(team) {
  myteam = getLivingPlayers(team);
  foreach(guy in myteam) {
    if(isDefined(guy.lastStand) && guy.lastStand) {
      guy thread maps\mp\gametypes\_damage::dieAfterTime(RandomIntRange(1, 3));
    }
  }
}

switch_to_last_weapon(lastWeapon) {
  if(!IsAI(self)) {
    self SwitchToWeapon(lastWeapon);
  } else {
    self SwitchToWeapon("none");
  }
}

IsAITeamParticipant(ent) {
  if(IsAgent(ent) && ent.agent_teamParticipant == true)
    return true;

  if(IsBot(ent))
    return true;

  return false;
}

IsTeamParticipant(ent) {
  if(IsAITeamParticipant(ent))
    return true;

  if(isPlayer(ent))
    return true;

  return false;
}

IsAIGameParticipant(ent) {
  if(IsAgent(ent) && isDefined(ent.agent_gameParticipant) && ent.agent_gameParticipant == true)
    return true;

  if(IsBot(ent))
    return true;

  return false;
}

IsGameParticipant(ent) {
  if(IsAIGameParticipant(ent))
    return true;

  if(isPlayer(ent))
    return true;

  return false;
}

getTeamIndex(team) {
  AssertEx(isDefined(team), "getTeamIndex: team is undefined!");

  teamIndex = 0;
  if(level.teambased) {
    switch (team) {
      case "axis":
        teamIndex = 1;
        break;
      case "allies":
        teamIndex = 2;
        break;
    }
  }

  return teamIndex;
}

getTeamArray(team, includeAgents) {
  teamArray = [];
  if(!isDefined(includeAgents) || includeAgents) {
    foreach(player in level.characters) {
      if(player.team == team) {
        teamArray[teamArray.size] = player;
      }
    }
  } else {
    foreach(player in level.players) {
      if(player.team == team) {
        teamArray[teamArray.size] = player;
      }
    }
  }

  return teamArray;
}

isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      if(attacker.code_classname == "script_vehicle")
        return false;
      if(attacker.code_classname == "misc_turret")
        return false;
      if(attacker.code_classname == "script_model")
        return false;
    }
    if(isDefined(attacker.agent_type)) {
      if(attacker.agent_type == "dog" || attacker.agent_type == "alien")
        return false;
    }
  }

  return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_IMPACT" && sMeansOfDeath != "MOD_SCARAB" && sMeansOfDeath != "MOD_CRUSH" && !isEnvironmentWeapon(sWeapon);
}

attackerIsHittingTeam(victim, attacker) {
  if(!level.teamBased)
    return false;
  else if(!isDefined(attacker) || !isDefined(victim))
    return false;
  else if(!isDefined(victim.team) || !isDefined(attacker.team))
    return false;
  else if(victim == attacker)
    return false;
  else if(level.gametype == "infect" && victim.pers["team"] == attacker.team && isDefined(attacker.teamChangedThisFrame))
    return false;
  else if(level.gametype == "infect" && victim.pers["team"] != attacker.team && isDefined(attacker.teamChangedThisFrame))
    return true;
  else if(isDefined(attacker.scrambled) && attacker.scrambled)
    return false;
  else if(victim.team == attacker.team)
    return true;
  else
    return false;
}

set_high_priority_target_for_bot(bot) {
  Assert(isDefined(self.bot_interaction_type));
  if(!(isDefined(self.high_priority_for) && array_contains(self.high_priority_for, bot))) {
    self.high_priority_for = array_add(self.high_priority_for, bot);
    bot notify("calculate_new_level_targets");
  }
}

add_to_bot_use_targets(new_use_target, use_time) {
  if(isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    new_use_target.use_time = use_time;
    new_use_target.bot_interaction_type = "use";
    [[level.bot_funcs["bots_add_to_level_targets"]]](new_use_target);
  }
}

remove_from_bot_use_targets(use_target_to_remove) {
  if(isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](use_target_to_remove);
  }
}

add_to_bot_damage_targets(new_damage_target) {
  if(isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    new_damage_target.bot_interaction_type = "damage";
    [[level.bot_funcs["bots_add_to_level_targets"]]](new_damage_target);
  }
}

remove_from_bot_damage_targets(damage_target_to_remove) {
  if(isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](damage_target_to_remove);
  }
}

notify_enemy_bots_bomb_used(type) {
  if(isDefined(level.bot_funcs["notify_enemy_bots_bomb_used"])) {
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](type);
  }
}

get_rank_xp_for_bot() {
  if(isDefined(level.bot_funcs["bot_get_rank_xp"])) {
    return self[[level.bot_funcs["bot_get_rank_xp"]]]();
  }
}

bot_israndom() {
  isRandom = true;

  if(getDvar("squad_use_hosts_squad") == "1") {
    botTeam = undefined;

    if(isDefined(self.bot_team))
      botTeam = self.bot_team;
    else if(isDefined(self.pers["team"]))
      botTeam = self.pers["team"];

    if(isDefined(botTeam) && level.wargame_client.team == botTeam)
      isRandom = false;
    else
      isRandom = true;
  } else {
    isRandom = self BotIsRandomized();
  }

  return isRandom;
}

isAssaultKillstreak(refString) {
  switch (refString) {
    case "airdrop_assault":
    case "ims":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "airdrop_juggernaut":
    case "airdrop_juggernaut_maniac":
    case "sentry":
    case "ball_drone_backup":
    case "guard_dog":
    case "heli_pilot":
    case "vanguard":
    case "uplink":
    case "drone_hive":
    case "odin_assault":
      return true;
    default:
      return false;
  }
}

isSupportKillstreak(refString) {
  switch (refString) {
    case "deployable_vest":
    case "sam_turret":
    case "jammer":
    case "air_superiority":
    case "airdrop_juggernaut_recon":
    case "ball_drone_radar":
    case "heli_sniper":
    case "uplink_support":
    case "odin_support":
    case "recon_agent":
    case "aa_launcher":
    case "uav_3dping":
    case "deployable_ammo":
      return true;
    default:
      return false;
  }
}

isSpecialistKillstreak(refString) {
  switch (refString) {
    case "specialty_fastsprintrecovery_ks":
    case "specialty_fastreload_ks":
    case "specialty_lightweight_ks":
    case "specialty_marathon_ks":
    case "specialty_stalker_ks":
    case "specialty_reducedsway_ks":
    case "specialty_quickswap_ks":
    case "specialty_pitcher_ks":
    case "specialty_bulletaccuracy_ks":
    case "specialty_quickdraw_ks":
    case "specialty_sprintreload_ks":
    case "specialty_silentkill_ks":
    case "specialty_blindeye_ks":
    case "specialty_gpsjammer_ks":
    case "specialty_quieter_ks":
    case "specialty_incog_ks":
    case "specialty_paint_ks":
    case "specialty_scavenger_ks":
    case "specialty_detectexplosive_ks":
    case "specialty_selectivehearing_ks":
    case "specialty_comexp_ks":
    case "specialty_falldamage_ks":
    case "specialty_regenfaster_ks":
    case "specialty_sharp_focus_ks":
    case "specialty_stun_resistance_ks":
    case "_specialty_blastshield_ks":
    case "specialty_gunsmith_ks":
    case "specialty_extraammo_ks":
    case "specialty_extra_equipment_ks":
    case "specialty_extra_deadly_ks":
    case "specialty_extra_attachment_ks":
    case "specialty_explosivedamage_ks":
    case "specialty_gambler_ks":
    case "specialty_hardline_ks":
    case "specialty_twoprimaries_ks":
    case "specialty_boom_ks":
    case "specialty_deadeye_ks":
      return true;
    default:
      return false;
  }
}

bot_is_fireteam_mode() {
  fireteam_bots = (BotAutoConnectEnabled() == 2);

  if(fireteam_bots) {
    if(!level.teamBased || (level.gametype != "war" && level.gametype != "dom")) {
      return false;
    }
    return true;
  }
  return false;
}

set_console_status() {
  if(!isDefined(level.Console))
    level.Console = getDvar("consoleGame") == "true";
  else
    AssertEx(level.Console == (getDvar("consoleGame") == "true"), "Level.console got set incorrectly.");

  if(!isDefined(level.xenon))
    level.xenon = getDvar("xenonGame") == "true";
  else
    AssertEx(level.xenon == (getDvar("xenonGame") == "true"), "Level.xenon got set incorrectly.");

  if(!isDefined(level.ps3))
    level.ps3 = getDvar("ps3Game") == "true";
  else
    AssertEx(level.ps3 == (getDvar("ps3Game") == "true"), "Level.ps3 got set incorrectly.");

  if(!isDefined(level.xb3))
    level.xb3 = getDvar("xb3Game") == "true";
  else
    AssertEx(level.xb3 == (getDvar("xb3Game") == "true"), "Level.xb3 got set incorrectly.");

  if(!isDefined(level.ps4))
    level.ps4 = getDvar("ps4Game") == "true";
  else
    AssertEx(level.ps4 == (getDvar("ps4Game") == "true"), "Level.ps4 got set incorrectly.");
}

is_gen4() {
  AssertEx(isDefined(level.Console) && isDefined(level.xb3) && isDefined(level.ps4), "is_gen4() called before set_console_status() has been run.");

  if(level.xb3 || level.ps4 || !level.console)
    return true;
  else
    return false;
}

setdvar_cg_ng(dvar_name, current_gen_val, next_gen_val) {
  if(!isDefined(level.console) || !isDefined(level.xb3) || !isDefined(level.ps4))
    set_console_status();
  AssertEx(isDefined(level.console) && isDefined(level.xb3) && isDefined(level.ps4), "Expected platform defines to be complete.");

  if(is_gen4())
    setDvar(dvar_name, next_gen_val);
  else
    setDvar(dvar_name, current_gen_val);
}

isValidTeamTarget(attacker, victimTeam, target) {
  return (isDefined(target.team) && target.team == victimTeam);
}

isValidFFATarget(attacker, victimTeam, target) {
  return (isDefined(target.owner) && (!isDefined(attacker) || target.owner != attacker));
}

getHeliPilotMeshOffset() {
  return (0, 0, 5000);
}

getHeliPilotTraceOffset() {
  return (0, 0, 2500);
}

getLinknameNodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = strtok(self.script_linkto, " ");
    for(i = 0; i < linknames.size; i++) {
      ent = getnode(linknames[i], "script_linkname");
      if(isDefined(ent))
        array[array.size] = ent;
    }
  }

  return array;
}

is_aliens() {
  return level.gameType == "aliens";
}

get_players_watching(just_spectators, just_killcam) {
  if(!isDefined(just_spectators))
    just_spectators = false;
  if(!isDefined(just_killcam))
    just_killcam = false;

  entity_num_self = self GetEntityNumber();
  players_watching = [];
  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    player_is_watching = false;

    if(!just_killcam) {
      if(player.team == "spectator" || player.sessionstate == "spectator") {
        spectatingPlayer = player GetSpectatingPlayer();
        if(isDefined(spectatingPlayer) && spectatingPlayer == self)
          player_is_watching = true;
      }

      if(player.forcespectatorclient == entity_num_self)
        player_is_watching = true;
    }

    if(!just_spectators) {
      if(player.killcamentity == entity_num_self)
        player_is_watching = true;
    }

    if(player_is_watching)
      players_watching[players_watching.size] = player;
  }

  return players_watching;
}

set_visionset_for_watching_players(new_visionset, new_visionset_transition_time, time_in_new_visionset, is_missile_visionset, just_spectators, just_killcam) {
  players_watching = self get_players_watching(just_spectators, just_killcam);
  foreach(player in players_watching) {
    player notify("changing_watching_visionset");
    if(isDefined(is_missile_visionset) && is_missile_visionset)
      player VisionSetMissilecamForPlayer(new_visionset, new_visionset_transition_time);
    else
      player VisionSetNakedForPlayer(new_visionset, new_visionset_transition_time);
    if(new_visionset != "" && isDefined(time_in_new_visionset)) {
      player thread reset_visionset_on_team_change(self, new_visionset_transition_time + time_in_new_visionset);
      player thread reset_visionset_on_disconnect(self);

      if(player isInKillcam())
        player thread reset_visionset_on_spawn();
    }
  }
}

reset_visionset_on_spawn() {
  self endon("disconnect");

  self waittill("spawned");
  self VisionSetNakedForPlayer("", 0.0);
}

reset_visionset_on_team_change(current_player_watching, time_till_default_visionset) {
  self endon("changing_watching_visionset");

  time_started = GetTime();
  team_started = self.team;
  while(GetTime() - time_started < time_till_default_visionset * 1000) {
    if(self.team != team_started || !array_contains(current_player_watching get_players_watching(), self)) {
      self VisionSetNakedForPlayer("", 0.0);
      self notify("changing_visionset");
      break;
    }

    wait(0.05);
  }
}

reset_visionset_on_disconnect(entity_watching) {
  self endon("changing_watching_visionset");
  entity_watching waittill("disconnect");
  self VisionSetNakedForPlayer("", 0.0);
}

_setPlayerData(data, value) {
  if(matchMakingGame())
    self SetRankedPlayerData(data, value);
  else
    self setPrivatePlayerData(data, value);
}

_getPlayerData(data) {
  if(matchMakingGame())
    return self GetRankedPlayerData(data);
  else
    return self GetPrivatePlayerData(data);
}

_validateAttacker(eAttacker) {
  if(IsAgent(eAttacker) && (!isDefined(eAttacker.isActive) || !eAttacker.isActive))
    return undefined;

  if(IsAgent(eAttacker) && !isDefined(eAttacker.classname))
    return undefined;

  return eAttacker;
}

waittill_grenade_fire() {
  self waittill("grenade_fire", grenade, weapon_name);
  if(isDefined(grenade)) {
    if(!isDefined(grenade.weapon_name))
      grenade.weapon_name = weapon_name;
    if(!isDefined(grenade.owner))
      grenade.owner = self;
    if(!isDefined(grenade.team))
      grenade.team = self.team;
  }

  return grenade;
}

waittill_missile_fire() {
  self waittill("missile_fire", missile, weapon_name);
  if(isDefined(missile)) {
    if(!isDefined(missile.weapon_name))
      missile.weapon_name = weapon_name;
    if(!isDefined(missile.owner))
      missile.owner = self;
    if(!isDefined(missile.team))
      missile.team = self.team;
  }

  return missile;
}

_setNameplateMaterial(friendlyMat, enemyMat) {
  if(!isDefined(self.nameplateMaterial)) {
    self.nameplateMaterial = [];
    self.prevNameplateMaterial = [];
  } else {
    self.prevNameplateMaterial[0] = self.nameplateMaterial[0];
    self.prevNameplateMaterial[1] = self.nameplateMaterial[1];
  }
  self.nameplateMaterial[0] = friendlyMat;
  self.nameplateMaterial[1] = enemyMat;

  self SetNameplateMaterial(friendlyMat, enemyMat);
}

_restorePreviousNameplateMaterial() {
  if(isDefined(self.prevNameplateMaterial)) {
    self SetNameplateMaterial(self.prevNameplateMaterial[0], self.prevNameplateMaterial[1]);
  } else {
    self SetNameplateMaterial("", "");
  }
  self.nameplateMaterial = undefined;
  self.prevNameplateMaterial = undefined;
}

isPlayerOutsideOfAnyBombSite(weaponName) {
  if(isDefined(level.bombZones)) {
    foreach(bombZone in level.bombZones) {
      if(self IsTouching(bombZone.trigger))
        return false;
    }
  }

  return true;
}

weaponIgnoresBlastShield(sWeapon) {
  return sWeapon == "heli_pilot_turret_mp" || sWeapon == "bomb_site_mp";
}

isWeaponAffectedByBlastShield(sWeapon) {
  return (sWeapon == "ims_projectile_mp" || sWeapon == "remote_tank_projectile_mp");
}

restoreBaseVisionSet(fadeTime) {
  self VisionSetNakedForPlayer("", fadeTime);
}

playPlayerAndNpcSounds(player, firstPersonSound, thirdPersonSound) {
  player PlayLocalSound(firstPersonSound);
  player PlaySoundToTeam(thirdPersonSound, "allies", player);
  player PlaySoundToTeam(thirdPersonSound, "axis", player);
}

isEnemy(other) {
  if(level.teamBased) {
    return self isPlayerOnEnemyTeam(other);
  } else {
    return self isPlayerFFAEnemy(other);
  }
}

isPlayerOnEnemyTeam(other) {
  return (other.team != self.team);
}

isPlayerFFAEnemy(other) {
  if(isDefined(other.owner)) {
    return (other.owner != self);
  } else {
    return (other != self);
  }
}

setExtraScore0(newValue) {
  self.extrascore0 = newValue;
  self setPersStat("extrascore0", newValue);
}

allowLevelKillstreaks() {
  if(level.gametype == "sotf" && level.gametype == "sotf_ffa" && level.gametype == "infect" && level.gametype == "horde")
    return false;

  return true;
}

getUniqueId() {
  if(isDefined(self.pers["guid"]))
    return self.pers["guid"];

  playerGuid = self getGuid();
  if(playerGuid == "0000000000000000") {
    if(isDefined(level.guidGen))
      level.guidGen++;
    else
      level.guidGen = 1;

    playerGuid = "script" + level.guidGen;
  }

  self.pers["guid"] = playerGuid;

  return self.pers["guid"];
}

getRandomPlayingPlayer() {
  unparsedPlayers = array_removeUndefined(level.players);

  for(;;) {
    if(!unparsedPlayers.size) {
      return;
    }
    randNum = RandomIntRange(0, unparsedPlayers.size);
    selectedPlayer = unparsedPlayers[randNum];

    if(!isReallyAlive(selectedPlayer) || selectedPlayer.sessionstate != "playing") {
      unparsedPlayers = array_remove(unparsedPlayers, selectedPlayer);
      continue;
    }

    return selectedPlayer;
  }
}

getMapName() {
  if(!isDefined(level.mapName))
    level.mapName = getDvar("mapname");

  return level.mapName;
}

isSingleHitWeapon(weaponName) {
  switch (weaponName) {
    case "iw6_mk32_mp":
    case "iw6_rgm_mp":
    case "iw6_panzerfaust3_mp":
    case "iw6_maaws_mp":
      return true;
    default:
      return false;
  }
}

gameHasNeutralCrateOwner(gameType) {
  switch (gameType) {
    case "sotf":
    case "sotf_ffa":
      return true;
    default:
      return false;
  }
}

array_remove_keep_index(ents, remover) {
  newents = [];
  foreach(index, ent in ents) {
    if(ent != remover)
      newents[index] = ent;
  }

  return newents;
}

isAnyMLGMatch() {
  if(GetDvarInt("xblive_competitionmatch"))
    return true;

  return false;
}

isMLGSystemLink() {
  if((GetDvarInt("systemlink") && GetDvarInt("xblive_competitionmatch")))
    return true;

  return false;
}

isMLGPrivateMatch() {
  if((privateMatch() && GetDvarInt("xblive_competitionmatch")))
    return true;

  return false;
}

isMLGMatch() {
  if(isMLGSystemLink() || isMLGPrivateMatch())
    return true;

  return false;
}

isModdedRoundGame() {
  if(level.gameType == "blitz" || level.gameType == "dom")
    return true;

  return false;
}

isUsingDefaultClass(team, index) {
  usingDefaultClass = false;

  if(isDefined(index)) {
    if(isUsingMatchRulesData() && GetMatchRulesData("defaultClasses", team, index, "class", "inUse"))
      usingDefaultClass = true;
  } else {
    for(index = 0; index < MAX_CUSTOM_DEFAULT_LOADOUTS; index++) {
      if(isUsingMatchRulesData() && GetMatchRulesData("defaultClasses", team, index, "class", "inUse")) {
        usingDefaultClass = true;
        break;
      }
    }
  }

  return usingDefaultClass;
}

canCustomJuggUseKillstreak(streakNameWeapon) {
  useKillstreak = true;

  if((isDefined(self.isJuggernautLevelCustom) && self.isJuggernautLevelCustom) && (isDefined(self.canUseKillstreakCallback) && !self[[self.canUseKillstreakCallback]](streakNameWeapon)))
    useKillstreak = false;

  return useKillstreak;
}

printCustomJuggKillstreakErrorMsg() {
  if(isDefined(self.killstreakErrorMsg))
    [[self.killstreakErrorMsg]]();
}